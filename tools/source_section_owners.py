"""P907 exact same-TU section-pointer guards; verification only, never object rewriting.

Keep the production GLOBAL-UNDEF R32 helper untouched. This separate mode is
only for explicitly declared pointers to a same-object, previously validated
native source section. Auxiliary windows validate data; they do not consume or
split a compiler section and must not create a second source linker selector.
"""
from collections import Counter
import hashlib,re,struct


def read_owner_image(path):
    """Read the exact ELF32/MIPS metadata needed by this opt-in validator.

    All symbols, including duplicate names and LOCAL section records, remain
    in order. No object normalization or mutation occurs. The independent
    integration proof uses the full strict ELF reader as a second check.
    """
    data=path.read_bytes()
    assert data[:7]==b'\x7fELF\x01\x01\x01' and struct.unpack_from('<HHI',data,16)==(1,8,1)
    offset=struct.unpack_from('<I',data,32)[0]
    stride,count,names_index=struct.unpack_from('<HHH',data,46)
    assert stride==40 and 0<count<0xff00 and 0<names_index<count
    assert offset+stride*count<=len(data)
    headers=[struct.unpack_from('<10I',data,offset+i*stride) for i in range(count)]
    def span(off,size):
        assert 0<=off<=len(data) and 0<=size<=len(data)-off
        return data[off:off+size]
    def string(blob,off):
        assert 0<=off<len(blob)
        end=blob.find(b'\0',off);assert end>=0
        return blob[off:end].decode()
    h=headers[names_index];assert h[1]==3
    names=span(h[4],h[5]);labels=[string(names,h[0]) for h in headers]
    assert len(labels)==len(set(labels))
    for h in headers:
        if h[1]!=8:span(h[4],h[5])
        assert h[8]==0 or h[8]&(h[8]-1)==0
    indices=[i for i,h in enumerate(headers) if h[1]==2];assert len(indices)==1
    si=indices[0];st=headers[si]
    assert labels[si]=='.symtab' and st[9]==16 and st[5]%16==0 and 0<st[6]<count
    h=headers[st[6]];assert h[1]==3
    strings=span(h[4],h[5]);symbols=[]
    for at in range(st[4],st[4]+st[5],16):
        n,v,z,info,other,index=struct.unpack_from('<IIIBBH',data,at)
        assert index<count or index in (0xfff1,0xfff2)
        symbols.append((string(strings,n),v,z,info,other,labels[index] if index<count else index))
    rels=[]
    for h in headers:
        if h[1] not in (4,9):continue
        assert h[1]==9 and h[9]==8 and h[5]%8==0 and h[6]==si and 0<h[7]<count
        for at in range(h[4],h[4]+h[5],8):
            off,info=struct.unpack_from('<II',data,at)
            assert info>>8<len(symbols)
            rels.append((labels[h[7]],off,info&255,symbols[info>>8]))
    return dict(data=data,sections=dict(zip(labels,headers)),section_order=labels,symbols=symbols,relocations=rels)

def payload(image,section):
    h=image['sections'][section]
    return image['data'][h[4]:h[4]+h[5]]

def storage(image,row):
    section=row['section'];h=image['sections'][section]
    assert h[1]==1 and h[2]==(0x10000003 if section=='.sdata' else 3) and h[5]==row['size'] and h[8]==row['alignment']
    found=[s for s in image['symbols'] if s[5]==section and s[3]&15!=3]
    assert len(found)==len(row['symbols'])
    used=[]
    for name,value,size,bind,mode in row['symbols']:
        assert mode in ('exact','uid') and (mode!='uid' or bind==0)
        matches=[s for s in found if (s[0]==name if mode=='exact' else bool(re.fullmatch(re.escape(name)+r'\.\d+',s[0])))
                 and s[1]==value and s[2] in (0,size) and s[3]>>4==bind and s[3]&15 in (0,1) and s[4]==0]
        assert len(matches)==1 and matches[0] not in used
        used.extend(matches)
    assert len(used)==len(found)

def validate_target_owner(image,row,validated):
    """Called only after ordinary owner validation; stronger local mode check."""
    storage(image,row)
    assert row.get('placement')=='fragment' and row['alignment']==4
    assert not any(r[0]==row['section'] for r in image['relocations'])
    assert hashlib.sha256(payload(image,row['section'])).hexdigest()==row['payload_sha256']
    anchors=tuple(s[0] for s in row['symbols'] if s[3]==1 and s[4]=='exact')
    assert tuple(row['assert_native_symbols'])==anchors
    assert len({r['source']+':'+r['section'] for r in validated})==len(validated)
    key=(row['source'],row['section'])
    assert all((r['source'],r['section'])!=key for r in validated)
    validated.append(dict(source=row['source'],section=row['section'],address=row['address'],size=row['size'],
        payload_sha256=row['payload_sha256'],image_sha256=hashlib.sha256(image['data']).hexdigest(),
        symbols=tuple(row['symbols']),assert_native_symbols=anchors))

def validate_same_tu_section_owner(image,row,validated,placement):
    """New opt-in mode, not a relaxation of existing FEI GLOBAL-UNDEF checks."""
    assert row.get('relocation_target_mode')=='validated_same_tu_section'
    assert struct.unpack_from('<HHI',image['data'],16)==(1,8,1)
    assert len(image['section_order'])==len(set(image['section_order']))
    section=row['section'];h=image['sections'][section]
    window=row.get('auxiliary_readonly_window',False)
    assert h[1]==1 and h[2]==(2 if window else 3) and h[8]==row['alignment']
    assert row['alignment']>0 and row['alignment']&(row['alignment']-1)==0
    start=row.get('offset',0);end=start+row['size']
    assert start%4==0 and 0<=start<end<=h[5] and row['size']%4==0
    if window:
        assert section=='.rodata' and h[5]==row['section_size']
        assert not row.get('symbols') and 'placement' not in row
        places=[r for r in placement if r['obj']=='build/'+row['source']+'.o']
        assert len(places)==1
        p=places[0]
        assert p['base']==row['section_address'] and p['end']==p['base']+p['size']
        assert h[5]<=p['size'] and row['address']==p['base']+start
    else:
        assert start==0 and row['size']==h[5] and row['placement']=='fragment'
        storage(image,row)
        assert tuple(row['assert_native_symbols'])==tuple(s[0] for s in row['symbols'] if s[3]==1 and s[4]=='exact')
    target_rows=tuple(tuple(t) for t in row['local_section_targets'])
    assert target_rows and len({t[0] for t in target_rows})==len(target_rows)
    targets={}
    for name,address,size,digest in target_rows:
        owners=[o for o in validated if o['source']==row['source'] and o['section']==name]
        assert len(owners)==1
        owner=owners[0]
        assert (owner['address'],owner['size'],owner['payload_sha256'])==(address,size,digest)
        assert owner['image_sha256']==hashlib.sha256(image['data']).hexdigest()
        matches=[s for s in image['symbols'] if s[0]==name]
        assert matches==[(name,0,0,3,0,name)],'exact LOCAL STT_SECTION required'
        targets[name]=(address,size)
    data=payload(image,section)[start:end]
    assert hashlib.sha256(data).hexdigest()==row['payload_sha256']
    expected=tuple(tuple(r) for r in row['relocations32'])
    assert expected and len({r[0] for r in expected})==len(expected)
    assert all(o%4==0 and 0<=o<=len(data)-4 and n in targets and 0<=a<targets[n][1] for o,n,a in expected)
    actual=[]
    for sec,off,kind,symbol in image['relocations']:
        if sec!=section:continue
        if window and not(start<=off<end):
            assert off+4<=start or off>=end,'relocation crosses window seam'
            continue
        assert kind==2 and start<=off<=end-4 and off%4==0
        assert symbol==(symbol[0],0,0,3,0,symbol[0]) and symbol[0] in targets
        actual.append((off-start,symbol[0],struct.unpack_from('<I',data,off-start)[0]))
    assert Counter(actual)==Counter(expected),'complete exact per-word relocation list'
    masked=bytearray(data);resolved=bytearray(data)
    for off,name,addend in actual:
        masked[off:off+4]=b'\0'*4
        value=targets[name][0]+addend
        assert 0<=value<=0xffffffff
        struct.pack_into('<I',resolved,off,value)
    assert hashlib.sha256(masked).hexdigest()==row['masked_payload_sha256']
    assert hashlib.sha256(resolved).hexdigest()==row['resolved_payload_sha256']
    return dict(source=row['source'],section=section,offset=start,size=len(data),native_address=row['address'],
        references=len(actual),resolved_sha256=hashlib.sha256(resolved).hexdigest(),window_only=bool(window))
