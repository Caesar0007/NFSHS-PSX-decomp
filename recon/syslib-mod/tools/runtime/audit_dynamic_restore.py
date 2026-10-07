#!/usr/bin/env python3
"""Prove that entry-time sparse state plus the static blob restores the post-race overlay exactly."""
import argparse,json,struct,sys,hashlib
from pathlib import Path
sys.path.insert(0,r'C:\Temp\nfs4-runtime');from gdb_remote import Remote
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(r,va,data):
 for off in range(0,len(data),512):
  part=data[off:off+512];assert r.packet(f'M{va+off:x},{len(part):x}:{part.hex()}')=='OK'
def restore_entries(blob):
 magic,ver,count,table,payload=struct.unpack_from('<4s4I',blob);base=20+table
 for i in range(count):
  va,size,flags,offset,crc,name=struct.unpack_from('<6I',blob,20+i*24);yield va,blob[base+offset:base+offset+size] if flags==1 else b'\0'*size
def dyn_addresses(blob):
 magic,ver,count=struct.unpack_from('<4s2I',blob);assert magic==b'NSDY' and ver==1;return list(struct.unpack_from('<%dI'%count,blob,12))
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--startup-report',type=Path,required=True);p.add_argument('--race-report',type=Path,required=True);p.add_argument('--restore-blob',type=Path,required=True);p.add_argument('--dynamic-map',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args();start=json.loads(a.startup_report.read_text());race=json.loads(a.race_report.read_text());records=[json.loads(Path(r'C:\Temp\nfs4-syslib-pair\retail-process.json').read_text(encoding='utf-8-sig')),json.loads(Path(r'C:\Temp\nfs4-syslib-pair\candidate-process.json').read_text(encoding='utf-8-sig'))];clients=[];addresses=dyn_addresses(a.dynamic_map.read_bytes());static=list(restore_entries(a.restore_blob.read_bytes()));report=dict(schema='nfs4-dynamic-restore-audit-v1',startup_report_sha256=sha(a.startup_report),race_report_sha256=sha(a.race_report),restore_blob_sha256=sha(a.restore_blob),dynamic_map_sha256=sha(a.dynamic_map),snapshot_bytes=len(addresses),passed=False)
 try:
  for side in range(2):r=Remote('127.0.0.1',records[side]['port']);clients.append(r);r.packet('qSupported')
  clients[1].checkpoint(start['records'][1]['checkpoint'],load=True);snapshot=bytes(clients[1].read_memory(va,1)[0] for va in addresses)
  clients[0].checkpoint(race['runs'][0]['checkpoint'],load=True);clients[1].checkpoint(race['runs'][1]['checkpoint'],load=True)
  final_values=bytes(clients[0].read_memory(va,1)[0] for va in addresses);report['snapshot_vs_retail_final_differences']=sum(a!=b for a,b in zip(snapshot,final_values))
  for va,data in static:write(clients[1],va,data)
  for va,value in zip(addresses,snapshot):write(clients[1],va,bytes((value,)))
  rows=[];total=0
  for va,data in static:
   left=clients[0].read_memory(va,len(data));right=clients[1].read_memory(va,len(data));diff=sum(a!=b for a,b in zip(left,right));rows.append(dict(va=f'{va:08X}',size=len(data),different_bytes=diff));total+=diff
  report['ranges']=rows;report['different_bytes_after_restore']=total;report['passed']=total==0
 finally:
  for r in clients:r.close()
 a.output.write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps({k:report.get(k) for k in ('passed','snapshot_bytes','snapshot_vs_retail_final_differences','different_bytes_after_restore')},indent=2));return 0 if report['passed'] else 1
if __name__=='__main__':raise SystemExit(main())
