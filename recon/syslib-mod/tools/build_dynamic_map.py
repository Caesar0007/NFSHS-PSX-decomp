#!/usr/bin/env python3
"""Build a sparse mutable-address map from a restore audit report."""
import argparse,hashlib,json,struct
from pathlib import Path
def sha(x):return hashlib.sha256(x.read_bytes() if isinstance(x,Path) else x).hexdigest()
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--audit',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args();audit=json.loads(a.audit.read_text());addresses=[]
 for row in audit['ranges']:
  base=int(row['va'],16);addresses.extend(base+x for x in row['different_offsets'])
 addresses=sorted(set(addresses));blob=struct.pack('<4s2I',b'NSDY',1,len(addresses))+b''.join(struct.pack('<I',x) for x in addresses);a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_bytes(blob)
 report=dict(schema='nfs4-syslib-dynamic-map-v1',audit=str(a.audit),audit_sha256=sha(a.audit),addresses=len(addresses),snapshot_bytes=len(addresses),map_bytes=len(blob),first=f'{addresses[0]:08X}',last=f'{addresses[-1]:08X}',blob=str(a.output),blob_sha256=sha(blob));a.output.with_suffix('.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps(report,indent=2))
if __name__=='__main__':main()
