import struct,hashlib,json,re,subprocess,bisect
from pathlib import Path
def snap(path):
 b=Path(path).read_bytes(); assert b[:6]==b'\x7fELF\x01\x01'
 shoff=struct.unpack_from('<I',b,32)[0]; ents,n,strings=struct.unpack_from('<HHH',b,46)
 sh=[struct.unpack_from('<10I',b,shoff+i*ents) for i in range(n)]
 st=sh[strings]; names=b[st[4]:st[4]+st[5]]
 def z(s,o): return s[o:s.find(b'\0',o)].decode()
 sn=[z(names,s[0]) for s in sh]
 symbols=[]; tables={}
 for j,s in enumerate(sh):
  if s[1]!=2: continue
  ss=sh[s[6]]; strings=b[ss[4]:ss[4]+ss[5]]; table=[]
  for off in range(s[4],s[4]+s[5],s[9]):
   no,val,size,info,other,idx=struct.unpack_from('<IIIBBH',b,off)
   name=z(strings,no); section=sn[idx] if idx<n else idx
   table.append((name,val,size,info,other,section))
   if info&15!=4: symbols.append(table[-1])
  tables[j]=table
 rel=[]; payload=[]
 for j,s in enumerate(sh):
  if s[1]==9:
   for off in range(s[4],s[4]+s[5],s[9]):
    pos,info=struct.unpack_from('<II',b,off)
    rel.append((sn[s[7]],pos,info&255,tables[s[6]][info>>8]))
  elif s[1] not in (0,2,3):
   data=b'' if s[1]==8 else b[s[4]:s[4]+s[5]]
   payload.append((sn[j],s[1],s[2],s[3],s[5],s[8],hashlib.sha256(data).hexdigest()))
 receipt=(sorted(payload),sorted(symbols,key=str),sorted(rel,key=str))
 return {'file':str(path),'sha256':hashlib.sha256(b).hexdigest(),'semantic_sha256':hashlib.sha256(json.dumps(receipt,sort_keys=True).encode()).hexdigest(),'CURRENTPLAYER':[x for x in symbols if x[0]=='CURRENTPLAYER'],'sections':payload}

ROOT = Path(__file__).resolve().parents[2]
WORK = Path(__file__).resolve().parent
FN = 'CopSpeak_PlayNextRequest__Fv'
VA = 0x8009a828
SYMPATH = Path('C:/Temp/nfs4-clean/nfs4-f-v3.txt')
OBJD = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
before_obj = WORK/'before_whole.o'
after_obj = ROOT/'build/recon/game/common/copspeak.cpp.o'
before_g = WORK/'before_whole.g.o'
after_g = ROOT/'build/diffsrc/recon/game/common/copspeak.cpp.g.o'

def local_defs(path):
 s=path.read_text()
 m=re.search(r'(?ms)^\s*\.ent\s+'+FN+r'\s*$(.*?)^\s*\.end\s+'+FN+r'\s*$',s)
 return [line.strip() for line in m[1].splitlines() if re.match(r'\s*\.(?:frame|mask|begin|bend|def)\b',line)]

def body_lines(path):
 dis=subprocess.check_output([OBJD,'-d','-l','-r','-z',str(path)],text=True)
 start=None; line=None; rows=[]
 for s in dis.splitlines():
  label=re.match(r'^([0-9a-f]+) <(.+)>:',s)
  if label and label[2]==FN: start=int(label[1],16)
  if start is None: continue
  atline=re.match(r'^.*[\\/].*:(\d+)$',s.strip())
  if atline: line=int(atline[1])
  ins=re.match(r'^\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(.+)$',s)
  if ins:
   offset=int(ins[1],16)-start
   if offset>=0x11c: break
   if offset>=0: rows.append({'va':VA+offset,'source_line':line,'word':ins[2],'instruction':ins[3]})
 return rows

sl={}
for line in SYMPATH.read_text().splitlines():
 m=re.search(r'\$([0-9a-f]{8})\s+\S+\s+(?:Inc SLD linenum.*\(to (\d+)\)|Set SLD linenum to (\d+))',line)
 if m and VA<=int(m[1],16)<=VA+0x11c: sl[int(m[1],16)]=int(m[2] or m[3])
keys=sorted(sl)
def retail_line(va): return sl[keys[bisect.bisect_right(keys,va)-1]]
before_rows=body_lines(before_g); after_rows=body_lines(after_g)
for rows in (before_rows,after_rows):
 for row in rows: row['retail_sld']=retail_line(row['va'])
groups={}
for sld in sorted(set(row['retail_sld'] for row in before_rows+after_rows)):
 groups[sld]={'before_source_lines':sorted(set(row['source_line'] for row in before_rows if row['retail_sld']==sld)),
              'after_source_lines':sorted(set(row['source_line'] for row in after_rows if row['retail_sld']==sld))}
native=[
 '26bc32: $00000010 96 Def2 class REG type PTR STRUCT size 32 dims 0 tag CopSpeak_tRequest name r',
 '26bc55: $00000005 94 Def class REG type INT size 0 name handle']
assert all(line in SYMPATH.read_text() for line in native)
rom=(ROOT/'rom/nfs4-f.exe').read_bytes()
raw_count=0;raw_fail=[]
for line in (ROOT/'asm/nonmatchings/main'/ (FN+'.s')).read_text().splitlines():
 m=re.search(r'/\*\s+[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s+([0-9A-Fa-f]{8})\s+\*/',line)
 if m:
  at=int(m[1],16)-0x8000f800
  raw_count+=1
  if rom[at:at+4].hex().lower()!=m[2].lower(): raw_fail.append(m[1])
snapshots={name:snap(path) for name,path in [('before',before_obj),('after',after_obj),
                                             ('before_debug',before_g),('after_debug',after_g)]}
def text_sha(name):
 return next(s[-1] for s in snapshots[name]['sections'] if s[0]=='.text')
result={'function':FN,'native_locals':native,
 'before_defs':local_defs(WORK/'before_whole.g.s'),
 'after_defs':local_defs(ROOT/'build/diffsrc/recon/game/common/copspeak.cpp.g.s'),
 'next_qualification':'The target SYM contains no next record. P842 recovered the spelling for the same queue-wrap output role in sibling functions of COPSPEAK.CPP. Its emitted home changes REG3 to REG4 in the single value chain; this is not a native-target home proof.',
 'object_snapshots':snapshots,
 'code_data_symbol_relocation_identity':snapshots['before']['semantic_sha256']==snapshots['after']['semantic_sha256'],
 'whole_object_hash_equal':snapshots['before']['sha256']==snapshots['after']['sha256'],
 'full_object_hash_difference':'The frozen baseline is compiled under a different scratch filename; STT_FILE/string-table/container metadata differs. No object is rewritten. The section/symbol/resolved-relocation fingerprint excludes only filename records and raw string-table/index ordering.',
 'debug_text_twin_equal':{'before':text_sha('before')==text_sha('before_debug'),
                          'after':text_sha('after')==text_sha('after_debug')},
 'raw_oracle_words':raw_count,'raw_oracle_failures':raw_fail,
 'retail_sld_source_groups':groups,'before_instruction_lines':before_rows,'after_instruction_lines':after_rows,
 'full_target_sym_sld_exact':False,
 'falsified_probe':{'shape':'single next chain with in-place if/else at the wrap','diffs':8,'ours_insns':71,'oracle_insns':71},
 'retained_probe':{'shape':'single next chain with ternary; compound initial queue expression and chained final store','diffs':0,'ours_insns':71,'oracle_insns':71}}
prior_receipt=ROOT/'scratchpad/root_sym_audit/p875_common2_public_header_receipts_20260906.md'
prior_hash=re.search(r'\|\s*`copspeak\.cpp\.o`\s*\|\s*`([0-9a-f]{64})`',prior_receipt.read_text())[1]
result['prior_production_object_receipt']={'path':str(prior_receipt.relative_to(ROOT)),
                                         'sha256':prior_hash}
result['production_full_object_identical']=prior_hash==snapshots['after']['sha256']
assert len(before_rows)==len(after_rows)==71
assert result['code_data_symbol_relocation_identity'] and not raw_fail
assert result['production_full_object_identical']
assert all(result['debug_text_twin_equal'].values())
print(json.dumps(result,indent=2))
