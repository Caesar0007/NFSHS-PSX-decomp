#!/usr/bin/env python3
"""Apply a restore blob to the candidate race checkpoint and compare restored ranges with retail."""
import argparse,json,struct,sys,hashlib
from pathlib import Path
sys.path.insert(0,r'C:\Temp\nfs4-runtime');from gdb_remote import Remote
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(r,va,data):
 for off in range(0,len(data),512):
  part=data[off:off+512]
  if r.packet(f'M{va+off:x},{len(part):x}:{part.hex()}')!='OK':raise RuntimeError('write')
def parse(blob):
 magic,ver,count,table,payload_size=struct.unpack_from('<4s4I',blob);assert magic==b'NSRO' and ver==1 and table==count*24
 base=20+table;rows=[]
 for i in range(count):
  va,size,flags,offset,crc,name=struct.unpack_from('<6I',blob,20+i*24);data=blob[base+offset:base+offset+size] if flags==1 else b'\0'*size;rows.append((va,size,flags,data,name))
 return rows
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--race-report',type=Path,required=True);p.add_argument('--blob',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args();a.output.parent.mkdir(parents=True,exist_ok=True)
 race=json.loads(a.race_report.read_text());records=[json.loads(Path(r'C:\Temp\nfs4-syslib-pair\retail-process.json').read_text(encoding='utf-8-sig')),json.loads(Path(r'C:\Temp\nfs4-syslib-pair\candidate-process.json').read_text(encoding='utf-8-sig'))]
 clients=[];blob=a.blob.read_bytes();entries=parse(blob);report=dict(schema='nfs4-restore-audit-v1',race_report_sha256=sha(a.race_report),blob_sha256=sha(a.blob),restore_bytes=sum(x[1] for x in entries),ranges=[],passed=False)
 try:
  for side in range(2):
   r=Remote('127.0.0.1',records[side]['port']);clients.append(r);r.packet('qSupported');r.checkpoint(race['runs'][side]['checkpoint'],load=True)
  for va,size,flags,data,name in entries:write(clients[1],va,data)
  total=0
  for va,size,flags,data,name in entries:
   left=clients[0].read_memory(va,size);right=clients[1].read_memory(va,size);offsets=[i for i,(a,b) in enumerate(zip(left,right)) if a!=b];diff=len(offsets);total+=diff;report['ranges'].append(dict(va=f'{va:08X}',size=size,kind='payload' if flags==1 else 'zero',different_bytes=diff,different_offsets=offsets))
  report['different_bytes']=total;report['passed']=total==0
 finally:
  for r in clients:r.close()
 a.output.write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps({k:report.get(k) for k in ('passed','restore_bytes','different_bytes')},indent=2));print([x for x in report['ranges'] if x['different_bytes']][:20])
 return 0 if report['passed'] else 1
if __name__=='__main__':raise SystemExit(main())
