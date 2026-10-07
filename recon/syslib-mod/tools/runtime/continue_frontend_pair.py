#!/usr/bin/env python3
"""Continue an exact post-restore pair through neutral frontend frames."""
import argparse,hashlib,json,os,struct,sys,threading,uuid
from pathlib import Path
RT=Path(r'C:\Temp\nfs4-runtime');sys.path.insert(0,str(RT));os.environ.setdefault('FF_GDB_RAM_BACKEND','auto')
from gdb_remote import Remote,decode_registers
PAIR=Path(r'C:\Temp\nfs4-syslib-pair');PAD_RET=0x800E4310;PAD_STATE=0x8013E8A2
WATCH={0x800F6D18:'FntFlush',0x800FAAAC:'mcrd_text',0x80109550:'mcrd_bios',0x80109D10:'card_info',0x80109D60:'card_load',0x8010A0A0:'card_write',0x800F7E78:'stcdint',0x800F8968:'StClearRing',0x800F8EC8:'StUnSetRing',0x800F8FF8:'StSetStream',0x800F99F8:'StSetRing',0x800FA994:'StFreeRing',0x80108758:'StInitRing',0x8010885C:'StSetMask',0x8010887C:'CdRead'}
MOVIE_WATCH={k:v for k,v in WATCH.items() if v in ('FntFlush','StSetRing','StUnSetRing','StInitRing','StSetStream','StSetMask')}
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def load_reclaim(path):
 d=json.loads(path.read_text());rows=[]
 for include in d.get('includes',[]):rows.extend(load_reclaim((path.parent/include).resolve()))
 return rows+d.get('ranges',[])
def reg(r,n):return int.from_bytes(bytes.fromhex(r.packet(f'p{n:x}')),'little')
def set_reg(r,n,value):
 if r.packet(f'P{n:x}='+struct.pack('<I',value&0xffffffff).hex())!='OK':raise RuntimeError(f'register write {n}')
def wait(r,t):
 r.s.settimeout(t)
 try:
  while True:
   p=r._receive_packet()
   if p[:1] in ('T','S'):return p
 finally:r.s.settimeout(3)
def screenshot_payload(path):
 from compression import zstd
 data=Path(path).read_bytes();comp,w,h,size,offset=struct.unpack_from('<5I',data,0xB4);raw=zstd.decompress(data[offset:offset+size]) if comp==2 else data[offset:offset+size];return w,h,raw
def call_memcard(r,hits):
 saved=r.packet('g');sentinel=0x80027AD4
 set_reg(r,31,sentinel);set_reg(r,37,0x80027994)
 if r.packet(f'Z0,{sentinel:x},4')!='OK':raise RuntimeError('sentinel breakpoint')
 r.send_no_reply('c')
 while True:
  wait(r,300);pc=reg(r,37)
  if pc==sentinel:break
  if pc in WATCH:
   hits[WATCH[pc]]+=1;r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10);r.packet(f'Z0,{pc:x},4');r.send_no_reply('c');continue
  raise RuntimeError(f'memcard unexpected stop {pc:#x}')
 r.packet(f'z0,{sentinel:x},4')
 if r.packet('G'+saved)!='OK':raise RuntimeError('register restore')
def movie_call(r,hits,watch,address,args):
 saved=r.packet('g');sentinel=0x80027AD4
 for i,value in enumerate(args):set_reg(r,4+i,value)
 set_reg(r,31,sentinel);set_reg(r,37,address)
 if r.packet(f'Z0,{sentinel:x},4')!='OK':raise RuntimeError('movie breakpoint')
 r.send_no_reply('c')
 while True:
  wait(r,300);pc=reg(r,37)
  if pc==sentinel:break
  if pc in watch:
   hits[watch[pc]]+=1;r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10);r.packet(f'Z0,{pc:x},4');r.send_no_reply('c');continue
  raise RuntimeError(f'movie unexpected stop {pc:#x}')
 r.packet(f'z0,{sentinel:x},4');value=reg(r,2)
 if r.packet('G'+saved)!='OK':raise RuntimeError('register restore')
 return value
def call_movie(r,hits,watch):
 movie_call(r,hits,watch,0x8004C608,[4]);movie_call(r,hits,watch,0x8004C984,[4]);loaded=struct.unpack('<I',r.read_memory(0x80052D14,4))[0];hits['Movie_Loaded']=loaded
 if loaded!=1:raise RuntimeError(f'movie did not load: {loaded}')
 movie_call(r,hits,watch,0x8004C7D8,[])
def run(record,checkpoint,frames,pulses,memcard_check,movie_test,natural_movie,result,index,abort):
 r=Remote('127.0.0.1',record['port']);hits={name:0 for name in WATCH.values()}
 try:
  r.packet('qSupported');r.checkpoint(checkpoint,load=True)
  active_watch=MOVIE_WATCH if (movie_test or natural_movie) else WATCH
  for bp in active_watch:r.packet(f'Z0,{bp:x},4')
  if memcard_check:call_memcard(r,hits)
  if movie_test:call_movie(r,hits,active_watch)
  movie_next=0x8004CB30;movie_frames=0
  if natural_movie:
   movie_call(r,hits,active_watch,0x8007AD8C,[])
   if r.packet('M800517ec,4:01000000')!='OK':raise RuntimeError('first frontend flag write')
   active_watch=MOVIE_WATCH
   for bp in active_watch:r.packet(f'Z0,{bp:x},4')
   r.packet(f'Z0,{movie_next:x},4')
  r.packet(f'Z0,{PAD_RET:x},4')
  count=0
  while count<frames:
   r.send_no_reply('c');wait(r,60);pc=reg(r,37)
   if abort.is_set():raise RuntimeError('peer aborted')
   if pc==PAD_RET:
    count+=1
    value=0xbfff if any(p<=count<p+2 for p in pulses) else 0xffff
    if r.packet(f'M{PAD_STATE:x},2:'+struct.pack('<H',value).hex())!='OK':raise RuntimeError('pad write')
    if count%300==0:print(record['role'],'frontend',count,flush=True)
    continue
   if natural_movie and pc==movie_next:
    movie_frames+=1
    if movie_frames>=3:
     if r.packet('M80052d18,4:01000000')!='OK' or r.packet('M80052a2c,2:0100')!='OK':raise RuntimeError('natural movie stop')
    r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10);r.packet(f'Z0,{pc:x},4');continue
   if pc in active_watch:
    hits[active_watch[pc]]+=1;r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10);r.packet(f'Z0,{pc:x},4');continue
   raise RuntimeError(f'unexpected stop {pc:#x}')
  registers=r.packet('g');ram=r.read_memory(0x80000000,0x200000);scratch=r.read_memory(0x1f800000,0x400);name=f'nfs4-syslib-front-{record["role"]}-{uuid.uuid4().hex[:12]}';r.checkpoint(name);save=Path(record['executable']).parent/'savestates'/('ff-audit-'+name+'.sav')
  hits['Movie_NextFrame']=movie_frames
  result[index]=dict(role=record['role'],frames=count,hits=hits,registers=registers,ram=ram,scratch=scratch,save=str(save),save_sha256=sha(save),checkpoint=name)
 except Exception as e:abort.set();result[index]=dict(role=record['role'],error=repr(e),hits=hits)
 finally:r.close()
def main():
 p=argparse.ArgumentParser();p.add_argument('--startup-report',type=Path,required=True);p.add_argument('--race-report',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--frames',type=int,default=600);p.add_argument('--reclaim-manifest',type=Path,required=True);p.add_argument('--cross-pulses',default='');p.add_argument('--memcard-check',action='store_true');p.add_argument('--movie-test',action='store_true');p.add_argument('--natural-movie',action='store_true');a=p.parse_args();out=a.output.resolve();pulses=[int(x) for x in a.cross_pulses.split(',') if x]
 if out.exists():p.error('output exists')
 out.mkdir(parents=True);startup=json.loads(a.startup_report.read_text());race=json.loads(a.race_report.read_text());records=[json.loads(Path(x['record_path']).read_text(encoding='utf-8-sig')) for x in startup['records']];checkpoints=[x['checkpoint'] for x in race['runs']]
 if not race.get('passed') or records[0]['image_sha256']!=records[1]['image_sha256']:raise ValueError('requires passing symmetric race report')
 rows=[None,None];abort=threading.Event();ts=[threading.Thread(target=run,args=(records[i],checkpoints[i],a.frames,pulses,a.memcard_check,a.movie_test,a.natural_movie,rows,i,abort),daemon=True) for i in range(2)]
 for t in ts:t.start()
 for t in ts:t.join()
 report=dict(schema='nfs4-syslib-frontend-pair-v1',passed=False,frames=a.frames,cross_pulses=pulses,memcard_check=a.memcard_check,movie_test=a.movie_test,natural_movie=a.natural_movie,runs=[],comparison={})
 if any('error'in x for x in rows):report['runs']=[{k:v for k,v in x.items() if k not in('ram','scratch','registers')} for x in rows]
 else:
  regs=[decode_registers(x['registers']) for x in rows];right=bytearray(rows[1]['ram'])
  for item in load_reclaim(a.reclaim_manifest.resolve()):
   va=int(item['va'],16)&0x1fffff;right[va:va+item['size']]=rows[0]['ram'][va:va+item['size']]
  diff=sum(rows[0]['ram'][i:i+4]!=right[i:i+4] for i in range(0,0x200000,4));regdiff={k:[regs[0][k],regs[1][k]] for k in regs[0] if regs[0][k]!=regs[1][k]};shot=screenshot_payload(rows[0]['save'])==screenshot_payload(rows[1]['save']);report['runs']=[{k:v for k,v in x.items() if k not in('ram','scratch','registers')} for x in rows];report['comparison']=dict(ram_word_differences=diff,reclaim_normalized_bytes=sum(x['size'] for x in load_reclaim(a.reclaim_manifest.resolve())),scratchpad_equal=rows[0]['scratch']==rows[1]['scratch'],register_differences=regdiff,screenshot_equal=shot,hits_equal=rows[0]['hits']==rows[1]['hits']);report['passed']=diff==0 and report['comparison']['scratchpad_equal'] and not regdiff and shot and report['comparison']['hits_equal']
 (out/'report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2));return 0 if report['passed'] else 1
if __name__=='__main__':raise SystemExit(main())
