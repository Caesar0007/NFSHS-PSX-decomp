"""Read-only exhaustive GP relocation audit of live reconstruction objects.

Reads input ELF relocations, actual generated linker map/ELF and native/raw
oracles. Writes only this diagnostic's JSON report. No rebuild or relinking.
"""
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import re
import struct

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
ELF_PATH = ROOT / "build/gen_ld/recon_multdef-ok.elf"
MAP_PATH = ROOT / "build/gen_ld/recon_multdef-ok.map"

class Elf:
    def __init__(self, path):
        self.path = path
        self.data = path.read_bytes()
        assert self.data[:6] == b'\x7fELF\x01\x01', path
        off = struct.unpack_from('<I', self.data, 32)[0]
        width, count, ni = struct.unpack_from('<HHH', self.data, 46)
        hs = [struct.unpack_from('<10I', self.data, off+i*width) for i in range(count)]
        names = self.data[hs[ni][4]:hs[ni][4]+hs[ni][5]]
        self.sections = []
        for i,h in enumerate(hs):
            self.sections.append(dict(index=i, name=names[h[0]:].split(b'\0')[0].decode(),
                type=h[1], flags=h[2], addr=h[3], off=h[4], size=h[5], link=h[6], info=h[7], entsize=h[9]))
        self.byname = {s['name']:s for s in self.sections}
        self.symbols = []
        st = self.byname['.symtab']
        strings = self.payload(self.sections[st['link']])
        for at in range(st['off'],st['off']+st['size'],st['entsize']):
            n,v,z,info,other,sec = struct.unpack_from('<IIIBBH',self.data,at)
            self.symbols.append(dict(name=strings[n:].split(b'\0')[0].decode(errors='replace'),
                value=v,size=z,bind=info>>4,type=info&15,section=sec))
        self.rels=[]
        for s in self.sections:
            if s['type'] not in (4,9): continue
            assert s['type']==9, ('RELA input needs explicit addend handling',path,s)
            assert s['link']==st['index'],(path,s)
            for at in range(s['off'],s['off']+s['size'],s['entsize']):
                off,info=struct.unpack_from('<II',self.data,at)
                self.rels.append(dict(section=s['info'],offset=off,type=info&255,symbol=info>>8))
        self.gp0=struct.unpack_from('<I',self.payload(self.byname['.reginfo']),20)[0] if '.reginfo' in self.byname else 0
    def payload(self,s):
        return self.data[s['off']:s['off']+s['size']]
    def word(self,si,off):
        s=self.sections[si]
        assert s['type']!=8 and off+4<=s['size']
        return struct.unpack_from('<I',self.data,s['off']+off)[0]

linked=Elf(ELF_PATH)
linked_hash=hashlib.sha256(linked.data).hexdigest()
global_syms={s['name']:s for s in linked.symbols if s['bind'] in (1,2) and s['section']!=0}
GP=global_syms['_gp']['value']

# Preserve both input and output section identity from the actual map.
places={}
outname=None
pending=None
map_text=MAP_PATH.read_text(errors='replace')
map_hash=hashlib.sha256(MAP_PATH.read_bytes()).hexdigest()
for line in map_text.splitlines():
    m=re.match(r'^(\.\S+)(?:\s+0x[0-9a-f]+\s+0x[0-9a-f]+)?\s*$',line)
    if m: outname=m[1]; pending=None; continue
    m=re.match(r'^\s+(\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(build/\S+\.o)$',line)
    if m:
        places[m[4],m[1]]={'addr':int(m[2],16),'size':int(m[3],16),'output':outname};pending=None;continue
    m=re.match(r'^\s+(\.\S+)\s*$',line)
    if m:pending=m[1];continue
    m=re.match(r'^\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(build/\S+\.o)$',line)
    if m and pending:
        places[m[3],pending]={'addr':int(m[1],16),'size':int(m[2],16),'output':outname};pending=None

native_candidates=defaultdict(set)
for line in Path(r'C:/Temp/nfs4-clean/NFS4.MAP').read_text(errors='replace').splitlines():
    m=re.match(r'^\s*(8[0-9A-Fa-f]{7})\s+(\S+)\s*$',line)
    if m:native_candidates[m[2]].add(int(m[1],16))
for line in Path(r'C:/Temp/nfs4-clean/nfs4-f-v3.txt').read_text(errors='replace').splitlines():
    m=re.match(r'^[0-9a-f]+: \$(8[0-9a-f]{7}) (?:[126] (\S+)|9[46] Def2? class (?:EXT|STAT).* name (\S+))$',line)
    if m:native_candidates[m[2] or m[3]].add(int(m[1],16))
native={n:next(iter(v)) for n,v in native_candidates.items() if len(v)==1}
rom=(ROOT/'rom/nfs4-f.exe').read_bytes()
oracle_paths={}
for p in (ROOT/'asm/nonmatchings').rglob('*.s'):
    oracle_paths.setdefault(p.stem,[]).append(p)
oracle_cache={}
def oracle(name):
    if name not in oracle_cache:
        candidates=[]
        for p in oracle_paths.get(name,[]):
            words=[(int(a,16),int.from_bytes(bytes.fromhex(w),'little')) for a,w in
                   re.findall(r'/\* [0-9A-Fa-f]+ ([0-9A-Fa-f]{8}) ([0-9A-Fa-f]{8}) \*/',p.read_text())]
            if words:candidates.append(words)
        oracle_cache[name]=candidates[0] if len(candidates)==1 else None
    return oracle_cache[name]

def s16(v):return (v&65535)-65536 if v&32768 else v&65535
def s32(v):return v-0x100000000 if v&0x80000000 else v
sources=sorted([*(ROOT/'recon').rglob('*.c'),*(ROOT/'recon').rglob('*.cpp')])
missing=[]; rows=[]; reltypes=Counter();gp0s=Counter();func_cache={}; file_hashes={}
for source in sources:
    op=ROOT/'build'/(source.relative_to(ROOT).as_posix()+'.o')
    if not op.exists():missing.append(str(op.relative_to(ROOT)));continue
    obj=Elf(op); oname=op.relative_to(ROOT).as_posix()
    gp_rels=[r for r in obj.rels if r['type'] in (7,8,12)]
    reltypes.update(r['type'] for r in obj.rels)
    if not gp_rels:continue
    file_hashes[oname]=hashlib.sha256(obj.data).hexdigest();gp0s[obj.gp0]+=1
    # This repository's objects carry zero input GP. Refuse an unproved local
    # GP0 formula instead of silently miscounting an alternate ABI's objects.
    assert obj.gp0==0,(oname,obj.gp0)
    funcs=sorted([s for s in obj.symbols if s['type']==2 and s['size'] and s['section']<len(obj.sections)],key=lambda s:(s['section'],s['value']))
    rel_masks={}
    for r in obj.rels:
        mask=0 if r['type']==2 else 0xfc000000 if r['type']==4 else 0xffff0000 if r['type'] in (5,6,7,8) else 0xffffffff
        rel_masks[r['section'],r['offset']]=mask
    for r in gp_rels:
        sy=obj.symbols[r['symbol']]; sec=obj.sections[r['section']]
        word=obj.word(r['section'],r['offset'])
        addend=s32(word) if r['type']==12 else s16(word)
        target_sec=obj.sections[sy['section']]['name'] if sy['section']<len(obj.sections) else str(sy['section'])
        method=None;sv=None
        if sy['bind'] in (1,2):
            if sy['name'] in global_syms:sv=global_syms[sy['name']]['value'];method='linked_global'
        elif sy['section']==0xfff1:sv=sy['value'];method='absolute_local'
        elif (oname,target_sec) in places:
            sv=places[oname,target_sec]['addr']+sy['value'];method='input_section_map'
        row=dict(object=oname,relocation_section=sec['name'],offset=r['offset'],type=r['type'],
                 symbol=sy['name'] or target_sec,binding=sy['bind'],symbol_section=target_sec,
                 symbol_offset=sy['value'],addend=addend,resolution=method)
        if sv is not None:
            target=(sv+addend)&0xffffffff; delta=s32((target-GP)&0xffffffff)
            row.update(link_symbol=sv,actual_target=target,gp_delta=delta,overflow=(r['type']!=12 and not -32768<=delta<=32767))
            p=places.get((oname,sec['name']))
            if p and p['output'] in linked.byname:
                linked_sec=linked.byname[p['output']]
                actual_pc=p['addr']+r['offset']
                linked_off=actual_pc-linked_sec['addr']
                if 0<=linked_off and linked_off+4<=linked_sec['size']:
                    linkedword=linked.word(linked_sec['index'],linked_off)
                    row.update(link_pc=actual_pc,linked_word=linkedword,
                               encoding_agrees=((linkedword if r['type']==12 else linkedword&65535)==((target-GP)&(0xffffffff if r['type']==12 else 65535))))
        # Native-symbol comparison does not infer a name for a section-local.
        if sy['name'] in native:
            row.update(expected_target=(native[sy['name']]+addend)&0xffffffff,expected_basis='native_symbol')
        fn=next((f for f in funcs if f['section']==r['section'] and f['value']<=r['offset']<f['value']+f['size']),None)
        if fn:
            row['function']=fn['name']; key=(oname,fn['name'])
            if key not in func_cache:
                ow=oracle(fn['name']); ok=bool(ow and len(ow)*4==fn['size'])
                if ok:
                    for i,(va,raw) in enumerate(ow):
                        off=fn['value']+i*4; ours=obj.word(r['section'],off)
                        mask=rel_masks.get((r['section'],off),0xffffffff)
                        if ours>>26 in (1,4,5,6,7):mask&=0xffff0000
                        if (ours&mask)!=(raw&mask):ok=False;break
                func_cache[key]=(ok,ow)
            aligned,ow=func_cache[key]
            row['oracle_aligned']=aligned
            if aligned and r['type'] in (7,8):
                i=(r['offset']-fn['value'])//4;va,oword=ow[i]
                # Raw source bytes independently checked, not merely comments.
                raw=struct.unpack_from('<I',rom,va-0x8000f800)[0]
                assert raw==oword,(fn['name'],va)
                if (raw>>21)&31==28:
                    target=(GP+s16(raw))&0xffffffff
                    row.update(raw_pc=va,raw_target=target)
                    if 'expected_target' in row and row['expected_target']!=target:
                        row['native_vs_raw_disagreement']=True
                    else:row.update(expected_target=target,expected_basis='raw_opcode_aligned')
        if 'actual_target' in row and 'expected_target' in row:row['wrong_target']=row['actual_target']!=row['expected_target']
        rows.append(row)

assert hashlib.sha256(ELF_PATH.read_bytes()).hexdigest()==linked_hash,'ELF changed during audit'
assert hashlib.sha256(MAP_PATH.read_bytes()).hexdigest()==map_hash,'map changed during audit'
changed=[n for n,h in file_hashes.items() if hashlib.sha256((ROOT/n).read_bytes()).hexdigest()!=h]
assert not changed,('GP input objects changed during audit',changed)
by_object=defaultdict(Counter)
for r in rows:
    c=by_object[r['object']];c['gp_relocations']+=1;c['overflow']+=r.get('overflow',False);c['wrong_target']+=r.get('wrong_target',False)
    c['expected_unknown']+='expected_target' not in r
summary=dict(live_sources=len(sources),missing_objects=missing,gp_objects=len(file_hashes),
    gp_relocations=len(rows),relocation_type_counts=dict(reltypes),gp_input_values=dict(gp0s),gp=hex(GP),
    resolved=sum('actual_target' in r for r in rows),unresolved=sum('actual_target' not in r for r in rows),
    out_of_range=sum(r.get('overflow',False) for r in rows),
    expected_known=sum('expected_target' in r for r in rows),
    wrong_target=sum(r.get('wrong_target',False) for r in rows),
    in_range_wrong_target=sum(r.get('wrong_target',False) and not r.get('overflow',False) for r in rows),
    in_range_encoding_mismatch=sum(not r['encoding_agrees'] and not r['overflow'] for r in rows if 'encoding_agrees' in r),
    encoding_checked=sum('encoding_agrees' in r for r in rows),
    native_raw_conflicts=sum(r.get('native_vs_raw_disagreement',False) for r in rows),
    output_elf_sha256=linked_hash,output_map_sha256=map_hash)
report=dict(summary=summary,by_object={k:dict(v) for k,v in by_object.items()},relocations=rows)
(HERE/'audit.json').write_text(json.dumps(report,indent=2))
print(json.dumps(summary,indent=2))
print('OVERFLOW OBJECTS')
for o,c in sorted(by_object.items(),key=lambda x:(-x[1]['overflow'],x[0])):
    if c['overflow']:print(o,dict(c))
