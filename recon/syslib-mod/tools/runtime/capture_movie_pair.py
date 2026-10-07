#!/usr/bin/env python3
"""Cold-boot the final image through three native STR movie frames."""
import hashlib,json,os,struct,sys,threading,uuid
from pathlib import Path
RT=Path(r'C:\Temp\nfs4-runtime');sys.path.insert(0,str(RT));os.environ.setdefault('FF_GDB_RAM_BACKEND','auto')
from gdb_remote import Remote,decode_registers
PAIR=Path(r'C:\Temp\nfs4-syslib-pair');MOVIE=0x8004CCE4;NEXT=0x8004CB30;DEINIT=0x8004C7D8;RENDER=0x8004DD0C;PAD=0x800E4310;PAD_STATE=0x8013E8A2
WATCH={0x800F8FF8:'StSetStream',0x800F99F8:'StSetRing',0x80108758:'StInitRing',0x8010885C:'StSetMask',0x800F8EC8:'StUnSetRing'}
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def reg(r,n):return int.from_bytes(bytes.fromhex(r.packet(f'p{n:x}')),'little')
def wait(r,t=300):
 r.s.settimeout(t)
 try:
  while True:
   p=r._receive_packet()
   if p[:1] in ('S','T'):return p
 finally:r.s.settimeout(3)
def step_break(r,pc,readd=True):
 r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10)
 if readd:r.packet(f'Z0,{pc:x},4')
def worker(record,result,index,abort):
 r=Remote('127.0.0.1',record['port']);hits={x:0 for x in WATCH.values()};movie_calls=next_frames=deinit_calls=pad_frames=0
 try:
  r.packet('qSupported');r.checkpoint(f'nfs4-movie-origin-{record["role"]}-{uuid.uuid4().hex[:8]}')
  for bp in (MOVIE,NEXT,DEINIT,RENDER,PAD,*WATCH):
   if r.packet(f'Z0,{bp:x},4')!='OK':raise RuntimeError(f'breakpoint {bp:#x}')
  while True:
   r.send_no_reply('c');wait(r);pc=reg(r,37)
   if abort.is_set():raise RuntimeError('peer aborted')
   if pc==RENDER:break
   if pc==PAD:
    pad_frames+=1
    if r.packet(f'M{PAD_STATE:x},2:ffff')!='OK':raise RuntimeError('pad write')
    continue
   if pc==MOVIE:movie_calls+=1;step_break(r,pc);continue
   if pc==NEXT:
    next_frames+=1
    if next_frames>=3:
     if r.packet('M80052d18,4:01000000')!='OK' or r.packet('M80052a2c,2:0100')!='OK':raise RuntimeError('movie stop')
    step_break(r,pc);continue
   if pc==DEINIT:deinit_calls+=1;step_break(r,pc);continue
   if pc in WATCH:hits[WATCH[pc]]+=1;step_break(r,pc);continue
   raise RuntimeError(f'unexpected stop {pc:#x}')
  if movie_calls<1 or next_frames<3 or deinit_calls<1:raise RuntimeError(f'incomplete movie route calls={movie_calls} frames={next_frames} deinit={deinit_calls}')
  registers=r.packet('g');ram=r.read_memory(0x80000000,0x200000);scratch=r.read_memory(0x1f800000,0x400);name=f'nfs4-movie-{record["role"]}-{uuid.uuid4().hex[:10]}';r.checkpoint(name);save=Path(record['executable']).parent/'savestates'/('ff-audit-'+name+'.sav')
  result[index]=dict(role=record['role'],movie_calls=movie_calls,next_frames=next_frames,deinit_calls=deinit_calls,pad_frames=pad_frames,hits=hits,registers=registers,ram=ram,scratch=scratch,checkpoint=name,save=str(save),save_sha256=sha(save))
 except Exception as e:abort.set();result[index]=dict(role=record['role'],error=repr(e),movie_calls=movie_calls,next_frames=next_frames,deinit_calls=deinit_calls,hits=hits)
 finally:r.close()
def main():
 out=Path(sys.argv[1]).resolve()
 if out.exists():raise SystemExit('output exists')
 out.mkdir(parents=True);records=[json.loads((PAIR/f'{role}-process.json').read_text(encoding='utf-8-sig')) for role in ('retail','candidate')]
 if records[0]['image_sha256']!=records[1]['image_sha256']:raise ValueError('movie control requires identical images')
 rows=[None,None];abort=threading.Event();ts=[threading.Thread(target=worker,args=(records[i],rows,i,abort),daemon=True) for i in range(2)]
 for t in ts:t.start()
 for t in ts:t.join()
 report=dict(schema='nfs4-syslib-movie-pair-v1',passed=False,image_sha256=records[0]['image_sha256'],runtime_sha256=[x['runtime_sha256'] for x in records],settings_sha256=[x['settings_sha256'] for x in records],runs=[],comparison={})
 if any('error'in x for x in rows):report['runs']=[{k:v for k,v in x.items() if k not in('ram','scratch','registers')} for x in rows]
 else:
  regs=[decode_registers(x['registers']) for x in rows];diff=[]
  for off in range(0,0x200000,4):
   if rows[0]['ram'][off:off+4]!=rows[1]['ram'][off:off+4]:diff.append(0x80000000+off)
  game=[x for x in diff if x>=0x80010000 and not 0x80134B60<=x<0x80135B60];regdiff={k:[regs[0][k],regs[1][k]] for k in regs[0] if regs[0][k]!=regs[1][k]};report['runs']=[{k:v for k,v in x.items() if k not in('ram','scratch','registers')} for x in rows];report['comparison']=dict(ram_word_differences=len(diff),game_state_differences=len(game),scratchpad_equal=rows[0]['scratch']==rows[1]['scratch'],register_differences=regdiff,hits_equal=rows[0]['hits']==rows[1]['hits'],movie_counts_equal=[rows[0]['movie_calls'],rows[0]['next_frames'],rows[0]['deinit_calls']]==[rows[1]['movie_calls'],rows[1]['next_frames'],rows[1]['deinit_calls']]);report['passed']=not game and report['comparison']['scratchpad_equal'] and not regdiff and report['comparison']['hits_equal'] and report['comparison']['movie_counts_equal']
 (out/'report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2));return 0 if report['passed'] else 1
if __name__=='__main__':raise SystemExit(main())
