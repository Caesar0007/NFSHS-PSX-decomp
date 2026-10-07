#!/usr/bin/env python3
"""Build the card/libpress/movie-CD restore blob from the verified layered race manifest."""
import argparse,binascii,hashlib,json,struct
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];DEFAULT_MANIFEST=ROOT/'recon/syslib-mod/race_reclaim_plus_cd_movie.json';EXE=ROOT/'rom/nfs4-f.exe'
PERMANENT_PREFIX=('fnt','font_','pc','snread','snwrite','sndef')
def sha(x):return hashlib.sha256(x).hexdigest()
def load_manifest(path):
 d=json.loads(path.read_text());rows=[]
 for inc in d.get('includes',[]):rows+=load_manifest((path.parent/inc).resolve())
 return rows+d.get('ranges',[])
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--manifest',type=Path,default=DEFAULT_MANIFEST);p.add_argument('--output',type=Path,required=True);a=p.parse_args();a.output.parent.mkdir(parents=True,exist_ok=True)
 raw=EXE.read_bytes();load,size=struct.unpack_from('<II',raw,0x18);end=load+size;rows=[];payload=bytearray()
 for item in load_manifest(a.manifest.resolve()):
  if item['name'].startswith(PERMANENT_PREFIX):continue
  va=int(item['va'],16);n=item['size'];flags=1 if load<=va and va+n<=end else 2;offset=len(payload)
  if flags==1:
   data=raw[0x800+va-load:0x800+va-load+n];payload+=data
  else:data=b'\0'*n;offset=0
  rows.append(dict(name=item['name'],va=va,size=n,flags=flags,offset=offset,crc32=binascii.crc32(data)&0xffffffff))
 table=b''.join(struct.pack('<6I',x['va'],x['size'],x['flags'],x['offset'],x['crc32'],binascii.crc32(x['name'].encode())&0xffffffff) for x in rows)
 header=struct.pack('<4s4I',b'NSRO',1,len(rows),len(table),len(payload));blob=header+table+payload;a.output.write_bytes(blob)
 report=dict(schema='nfs4-syslib-restore-blob-v1',manifest=str(a.manifest.resolve()),source_exe=str(EXE),source_exe_sha256=sha(raw),blob=str(a.output),blob_sha256=sha(blob),entries=len(rows),restore_bytes=sum(x['size'] for x in rows),payload_bytes=len(payload),zero_fill_bytes=sum(x['size'] for x in rows if x['flags']==2),permanent_reclaim_bytes=22788,entries_detail=[dict(name=x['name'],va=f'{x["va"]:08X}',size=x['size'],kind='payload' if x['flags']==1 else 'zero',crc32=f'{x["crc32"]:08X}') for x in rows])
 a.output.with_suffix('.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps({k:report[k] for k in ('entries','restore_bytes','payload_bytes','zero_fill_bytes','permanent_reclaim_bytes','blob_sha256')},indent=2))
if __name__=='__main__':main()

