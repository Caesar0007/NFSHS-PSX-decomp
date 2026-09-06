import struct,hashlib,json
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
