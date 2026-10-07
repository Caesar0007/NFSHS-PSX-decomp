#!/usr/bin/env python3
"""Call-level differential for compact RotMatrix and RotMatrixZ."""
import hashlib,json,os,random,struct,sys
from pathlib import Path
RT=Path(r'C:\Temp\nfs4-runtime');sys.path.insert(0,str(RT));os.environ.setdefault('FF_GDB_RAM_BACKEND','auto')
from gdb_remote import Remote
PAIR=Path(r'C:\Temp\nfs4-syslib-pair');SENTINEL=0x800A41A8;VECTOR=0x80140400;MATRIX=0x80140420
def reg(r,n):return int.from_bytes(bytes.fromhex(r.packet(f'p{n:x}')),'little')
def setreg(r,n,v):
 if r.packet(f'P{n:x}='+struct.pack('<I',v&0xffffffff).hex())!='OK':raise RuntimeError('register write')
def write(r,a,d):
 for off in range(0,len(d),512):
  part=d[off:off+512]
  if r.packet(f'M{a+off:x},{len(part):x}:{part.hex()}')!='OK':raise RuntimeError('memory write')
def wait(r):
 r.s.settimeout(30)
 try:
  while True:
   p=r._receive_packet()
   if p[:1] in ('S','T'):return
 finally:r.s.settimeout(3)
def call(r,address,args):
 saved=r.packet('g')
 for i,v in enumerate(args):setreg(r,4+i,v)
 setreg(r,31,SENTINEL);setreg(r,37,address);r.packet(f'Z0,{SENTINEL:x},4');r.send_no_reply('c');wait(r);pc=reg(r,37);r.packet(f'z0,{SENTINEL:x},4')
 if pc!=SENTINEL:raise RuntimeError(f'call stopped {pc:#x}')
 value=reg(r,2)
 if r.packet('G'+saved)!='OK':raise RuntimeError('register restore')
 return value
def matrix_bytes(values,translation=(0x12345678,-0x1234567,0x76543210)):
 return struct.pack('<9h2x3i',*values,*translation)
def main():
 startup=Path(sys.argv[1]);out=Path(sys.argv[2]);report=json.loads(startup.read_text());records=[json.loads(Path(x['record_path']).read_text(encoding='utf-8-sig')) for x in report['records']];checkpoints=[x['checkpoint'] for x in report['records']];remotes=[Remote('127.0.0.1',x['port']) for x in records];patch_report=json.loads(Path(sys.argv[3]).read_text()) if len(sys.argv)>3 else None
 for r,c in zip(remotes,checkpoints):r.packet('qSupported');r.checkpoint(c,load=True)
 if patch_report:
  exe=Path(patch_report['candidate_exe']).read_bytes();load=int(patch_report['load'],16)
  for hv,size in patch_report['code_ranges']:
   va=int(hv,16);write(remotes[1],va,exe[0x800+va-load:0x800+va-load+size])
 rng=random.Random(0x4e465334);special=[-32768,-8193,-4097,-4096,-2049,-1024,-1,0,1,1023,1024,2047,2048,3071,4095,4096,8191,32767];vectors=[(x,y,z) for x,y,z in zip(special,special[5:]+special[:5],special[11:]+special[:11])]
 vectors += [(rng.randint(-32768,32767),rng.randint(-32768,32767),rng.randint(-32768,32767)) for _ in range(256)]
 zcases=[(a,[rng.randint(-32768,32767) for _ in range(9)]) for a in special for _ in range(4)]
 mismatches=[];calls=0
 try:
  for vector in vectors:
   inp=struct.pack('<4h',*vector,0);initial=matrix_bytes([0]*9)
   outputs=[]
   for r in remotes:
    write(r,VECTOR,inp);write(r,MATRIX,initial);call(r,0x800F252C,[VECTOR,MATRIX]);outputs.append(r.read_memory(MATRIX,32))
   calls+=1
   if outputs[0]!=outputs[1] and len(mismatches)<20:mismatches.append(dict(function='RotMatrix',input=vector,retail=outputs[0].hex(),candidate=outputs[1].hex()))
  for angle,values in zcases:
   initial=matrix_bytes(values);outputs=[]
   for r in remotes:
    write(r,MATRIX,initial);call(r,0x800F312C,[angle,MATRIX]);outputs.append(r.read_memory(MATRIX,32))
   calls+=1
   if outputs[0]!=outputs[1] and len(mismatches)<20:mismatches.append(dict(function='RotMatrixZ',angle=angle,input=values,retail=outputs[0].hex(),candidate=outputs[1].hex()))
 finally:
  for r in remotes:r.close()
 result=dict(schema='nfs4-syslib-gte-call-diff-v1',passed=not mismatches,rotmatrix_cases=len(vectors),rotmatrixz_cases=len(zcases),calls_per_side=calls,mismatches=mismatches,image_sha256=[x['image_sha256'] for x in records],patched_candidate_image_sha256=None if not patch_report else patch_report['image_sha256']);out.mkdir(parents=True);(out/'report.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2));return 0 if result['passed'] else 1
if __name__=='__main__':raise SystemExit(main())
