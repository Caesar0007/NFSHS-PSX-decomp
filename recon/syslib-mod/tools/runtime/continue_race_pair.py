#!/usr/bin/env python3
"""Continue a passed startup pair through Track_Init and driven race frames."""
import argparse, hashlib, json, os, struct, sys, threading, uuid
from pathlib import Path

RT_TOOLS=Path(r'C:\Temp\nfs4-runtime');sys.path.insert(0,str(RT_TOOLS));os.environ.setdefault('FF_GDB_RAM_BACKEND','auto')
from gdb_remote import Remote,decode_registers
TRACK_INIT,PAD_RET,PAD_STATE=0x800BA808,0x800E4310,0x8013E8A2
SIM_LOOP=0x800B6D4C
CLEANUP=0x800A4354;FRONT_BOUNDARY=0x80027AD4;END_SIM_GAME=0x8011E0C8
CROSS=0x4000;START=0x0008; G_NUM_SLICES=0x8013C7C8; GAME_TICKS=0x8011E0B0
WATCH={0x800F6D18:'FntFlush',0x80106BE4:'PCread',0x80106CA4:'PCopen',0x80106CC4:'PCinit',0x80106CD0:'PCcreat',0x80106D1C:'PClseek',0x80106D40:'PCclose',0x80106D50:'PCwrite',0x8009EC80:'MPause_StartPauseMenu',0x80079B60:'AudioCmn_Pause',0x80079C18:'AudioCmn_UnPause'}
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def load_reclaim(path):
 data=json.loads(path.read_text());ranges=[]
 for include in data.get('includes',[]):ranges.extend(load_reclaim((path.parent/include).resolve())['ranges'])
 ranges.extend(data.get('ranges',[]));data['ranges']=ranges
 if data.get('total_bytes') is not None and sum(x['size'] for x in ranges)!=data['total_bytes']:raise ValueError('reclaim manifest total mismatch')
 return data
def screenshot_payload(path):
 from compression import zstd
 data=Path(path).read_bytes();comp,w,h,size,offset=struct.unpack_from('<5I',data,0xB4)
 raw=zstd.decompress(data[offset:offset+size]) if comp==2 else data[offset:offset+size]
 return (w,h,raw)
def reg(r,n):return int.from_bytes(bytes.fromhex(r.packet(f'p{n:x}')),'little')
def u32(r,a):return struct.unpack('<I',r.read_memory(a,4))[0]
def wait(r,t):
 r.s.settimeout(t)
 try:
  while True:
   p=r._receive_packet()
   if p[:1] in ('T','S'):return p
 finally:r.s.settimeout(3)
def canary_bytes(va,size):return bytes(((va+i)*131+0xA5)&255 for i in range(size))
def write_memory(r,va,data):
 for offset in range(0,len(data),512):
  chunk=data[offset:offset+512]
  if r.packet(f'M{va+offset:x},{len(chunk):x}:{chunk.hex()}')!='OK':raise RuntimeError(f'canary write {va+offset:#x}')
def patch_setup_stream(r,overrides,clone_player_two=False):
 if not overrides and not clone_player_two:return {}
 address=reg(r,4);applied={};guard=0;player0={};player1=[]
 while guard<1024:
  op=u32(r,address)
  if op==0:break
  if op in overrides and op<0x103:
   write_memory(r,address+4,struct.pack('<I',overrides[op]));applied[str(op)]=overrides[op]
  if op>=0x103:
   idx=u32(r,address+4);value=u32(r,address+8)
   if idx==0:player0[op]=value
   elif idx==1:player1.append((address,op))
   address+=12
  elif op>=0x4d:address+=8
  elif op>=0x4b:address+=(u32(r,address+4)+2)*4
  else:address+=8
  guard+=1
 if guard>=1024:raise RuntimeError('setup stream did not terminate')
 missing=set(map(str,overrides))-set(applied)
 if missing:raise RuntimeError(f'setup opcodes missing: {sorted(missing)}')
 if clone_player_two:
  for item,op in player1:
   if op in player0:write_memory(r,item+8,struct.pack('<I',player0[op]))
  applied['clone_player_two']=len(player1)
 return applied
def set_reg(r,n,value):
 if r.packet(f'P{n:x}='+struct.pack('<I',value&0xffffffff).hex())!='OK':raise RuntimeError(f'register write r{n}')
def injected_call(r,address,args):
 saved=r.packet('g');sentinel=0x800A41A8
 for i,value in enumerate(args):set_reg(r,4+i,value)
 set_reg(r,31,sentinel);set_reg(r,37,address)
 if r.packet(f'Z0,{sentinel:x},4')!='OK':raise RuntimeError('injected return breakpoint')
 r.send_no_reply('c');wait(r,120);pc=reg(r,37);r.packet(f'z0,{sentinel:x},4')
 if pc!=sentinel:raise RuntimeError(f'injected call stopped {pc:#x}')
 value=reg(r,2)
 if r.packet('G'+saved)!='OK':raise RuntimeError('register restore rejected')
 return value
def async_load(r,image,name,destination):
 work=int(image['work_buffer']['address'],16);name_address=work+image['work_buffer']['size']-16
 write_memory(r,name_address,name.encode('ascii')+b'\0')
 handle=injected_call(r,0x800F143C,[name_address,destination])
 if handle==0:raise RuntimeError(f'async load did not start: {name}')
 for polls in range(20000):
  status=injected_call(r,0x800F16D8,[handle])
  if status!=0:
   if status<0 or status&0x80000000:raise RuntimeError(f'async load {name} status {status:#x}')
   return dict(handle=handle,bytes=status,polls=polls+1)
  injected_call(r,0x800E6C04,[0])
 raise RuntimeError(f'async load timeout: {name}')
def verify_restored_bytes(r,image):
 blob=Path(r'C:\Temp\nfs4-syslib-pair\overlay\SYSLIB.RSO').read_bytes();magic,version,count,table_bytes,payload_bytes=struct.unpack_from('<4s4I',blob,0)
 if magic!=b'NSRO' or version!=1:raise RuntimeError('bad host restore blob')
 payload_base=20+table_bytes;dynamic=Path(r'C:\Temp\nfs4-syslib-pair\overlay\SYSLIB.DYN').read_bytes();dcount=struct.unpack_from('<I',dynamic,8)[0];addresses=struct.unpack_from(f'<{dcount}I',dynamic,12);snapshot=r.read_memory(int(image['snapshot']['address'],16),dcount);dynamic_values=dict(zip(addresses,snapshot));different=0;checked=0;first=[]
 for i in range(count):
  va,size,flags,offset,crc,name_crc=struct.unpack_from('<6I',blob,20+i*24);expected=bytearray(blob[payload_base+offset:payload_base+offset+size] if flags==1 else b'\0'*size)
  for address,value in dynamic_values.items():
   if va<=address<va+size:expected[address-va]=value
  actual=r.read_memory(va,size);checked+=size
  for j,(a,b) in enumerate(zip(actual,expected)):
   if a!=b:
    different+=1
    if len(first)<20:first.append(dict(va=f'{va+j:08X}',actual=a,expected=b))
 return dict(entries=count,checked_bytes=checked,different_bytes=different,first_differences=first)
def run(record,path,start,out,frames,sim_ticks,game_ticks,reclaim,image,exercise_overlay,quiesce_audio,cleanup_frontend,hook_exit,load_frontend,natural_exit,setup_overrides,clone_player_two,pause_at,result,index,abort):
 r=Remote('127.0.0.1',record['port']);hits={n:0 for n in WATCH.values()}
 try:
  r.packet('qSupported');r.checkpoint(start,load=True);canaries=[];arena_results={};arena_initialized=False;applied_setup=patch_setup_stream(r,setup_overrides,clone_player_two)
  for bp in (TRACK_INIT,*WATCH):r.packet(f'Z0,{bp:x},4')
  while True:
   r.send_no_reply('c');wait(r,300);pc=reg(r,37)
   if abort.is_set():raise RuntimeError('peer runtime aborted')
   if pc==TRACK_INIT:break
   if pc in WATCH:
    hits[WATCH[pc]]+=1;r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10);r.packet(f'Z0,{pc:x},4');continue
   raise RuntimeError(f'unexpected pre-init stop {pc:#x}')
  overlay_results={}
  entry_status=None
  if index==1 and exercise_overlay:
   work=int(image['work_buffer']['address'],16);snapshot=int(image['snapshot']['address'],16)
   overlay_results['load_dynamic_entry']=async_load(r,image,image['dynamic_file'],work)
   overlay_results['save_dynamic']=injected_call(r,int(image['loader_symbols']['SyslibMod_SaveDynamic'],16),[work,snapshot])
   if overlay_results['save_dynamic']!=image['snapshot']['size']:raise RuntimeError(f'save dynamic returned {overlay_results["save_dynamic"]}')
  name=r.read_memory(reg(r,4),32).split(b'\0')[0].decode('latin1');ret=reg(r,31)
  r.packet(f'z0,{TRACK_INIT:x},4');r.packet(f'Z0,{ret:x},4')
  r.send_no_reply('c');wait(r,300)
  if reg(r,37)!=ret:raise RuntimeError(f'wrong Track_Init return {reg(r,37):#x}')
  r.packet(f'z0,{ret:x},4');slices=u32(r,G_NUM_SLICES);ticks0=u32(r,GAME_TICKS)
  r.packet(f'Z0,{PAD_RET:x},4');pad_frames=0;sim_count=0;tick_trace=[]
  if sim_ticks:r.packet(f'Z0,{SIM_LOOP:x},4')
  while (sim_count<sim_ticks) if sim_ticks else ((u32(r,GAME_TICKS)-ticks0<game_ticks) if game_ticks else (pad_frames<frames)):
   r.send_no_reply('c');wait(r,30);pc=reg(r,37)
   if pc in WATCH:
    hits[WATCH[pc]]+=1;r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10);r.packet(f'Z0,{pc:x},4');continue
   if pc==PAD_RET:
    if reclaim and not arena_initialized and image.get('status_address') and u32(r,int(image['status_address'],16))==image['snapshot']['size']:
     base_items=[x for x in reclaim['ranges'] if x.get('allocator','base')=='base'];gte_items=[x for x in reclaim['ranges'] if x.get('allocator')=='gte'];cd_items=[x for x in reclaim['ranges'] if x.get('allocator')=='cd']
     if 'SyslibMod_ArenaAlloc' in image['loader_symbols']:
      capacity=injected_call(r,int(image['loader_symbols']['SyslibMod_ArenaCapacity'],16),[]);arena_results['capacity']=capacity;arena_results['allocations']=[]
      expected_base=sum(x['size'] for x in base_items)
      if capacity!=expected_base:raise RuntimeError(f'arena capacity {capacity} != base manifest {expected_base}')
     for item in base_items:
      va=int(item['va'],16)
      if 'SyslibMod_ArenaAlloc' in image['loader_symbols']:
       got=injected_call(r,int(image['loader_symbols']['SyslibMod_ArenaAlloc'],16),[item['size'],1]);arena_results['allocations'].append(dict(name=item['name'],expected=f'{va:08X}',actual=f'{got:08X}',size=item['size']))
       if got!=va:raise RuntimeError(f'arena allocation {item["name"]}: {got:#x} != {va:#x}')
      if index==1:
       data=canary_bytes(va,item['size']);write_memory(r,va,data);canaries.append((item['name'],va,data))
     if gte_items:
      ga=image['gte_arena'];gcap=injected_call(r,int(ga['capacity'],16),[]);arena_results['gte_capacity']=gcap;arena_results['gte_allocations']=[]
      if gcap!=sum(x['size'] for x in gte_items):raise RuntimeError(f'gte arena capacity {gcap}')
      for item in gte_items:
       va=int(item['va'],16);got=injected_call(r,int(ga['alloc'],16),[item['size'],1]);arena_results['gte_allocations'].append(dict(name=item['name'],expected=f'{va:08X}',actual=f'{got:08X}',size=item['size']))
       if got!=va:raise RuntimeError(f'gte allocation {got:#x} != {va:#x}')
       if index==1:
        data=canary_bytes(va,item['size']);write_memory(r,va,data);canaries.append((item['name'],va,data))
     if cd_items:
      ca=image['cd_arena'];ccap=injected_call(r,int(ca['capacity'],16),[]);arena_results['cd_capacity']=ccap;arena_results['cd_allocations']=[]
      if ccap!=sum(x['size'] for x in cd_items):raise RuntimeError(f'cd arena capacity {ccap}')
      for item in cd_items:
       va=int(item['va'],16);got=injected_call(r,int(ca['alloc'],16),[item['size'],1]);arena_results['cd_allocations'].append(dict(name=item['name'],expected=f'{va:08X}',actual=f'{got:08X}',size=item['size']))
       if got!=va:raise RuntimeError(f'cd allocation {got:#x} != {va:#x}')
       if index==1:
        data=canary_bytes(va,item['size']);write_memory(r,va,data);canaries.append((item['name'],va,data))
     arena_initialized=True
    pad_frames+=1
    if pause_at and pause_at-20<=pad_frames<pause_at+70:
     value=0xffff
     if pause_at<=pad_frames<pause_at+2:value&=~START
     if pause_at+50<=pad_frames<pause_at+52:value&=~CROSS
    else:value=0xffff&~CROSS
    r.packet(f'M{PAD_STATE:x},2:'+struct.pack('<H',value).hex())
    tick_trace.append(u32(r,GAME_TICKS)-ticks0);tick_trace=tick_trace[-128:]
    if not sim_ticks and pad_frames%300==0:print(record['role'],'drive',pad_frames,'ticks',u32(r,GAME_TICKS)-ticks0,flush=True)
    continue
   if sim_ticks and pc==SIM_LOOP:
    sim_count+=1
    if sim_count==sim_ticks:break
    r.packet(f'z0,{SIM_LOOP:x},4');r.packet('s',timeout=10);r.packet(f'Z0,{SIM_LOOP:x},4')
    if sim_count%300==0:print(record['role'],'sim',sim_count,'pad',pad_frames,flush=True)
    continue
   raise RuntimeError(f'drive pad={pad_frames} sim={sim_count} stop {pc:#x}')
  ticks1=u32(r,GAME_TICKS)
  if index==1 and image.get('status_address'):
   entry_status=u32(r,int(image['status_address'],16))
   if entry_status!=image['snapshot']['size']:raise RuntimeError(f'overlay entry status {entry_status:#x}')
  if reclaim and not arena_initialized:raise RuntimeError('arena allocator was never initialized after entry snapshot')
  if index==1 and reclaim and not canaries:raise RuntimeError('reclaim canaries were never installed through arena allocator')
  if quiesce_audio:
   audio_result=injected_call(r,0x80076F44,[])
  else:audio_result=None
  canary_result=[dict(name=name,va=f'{va:08X}',size=len(data),unchanged=r.read_memory(va,len(data))==data) for name,va,data in canaries]
  natural_results={}
  if natural_exit:
   r.packet(f'z0,{PAD_RET:x},4');write_memory(r,END_SIM_GAME,struct.pack('<I',1))
   stages={0x800A45B8:'loading_icon',0x800EDA00:'clear_image',0x800ED87C:'draw_sync',0x800A454C:'load_overlay',0x80095B30:'speech_destroy',0x80099ADC:'copspeak_cleanup',0x8008BA40:'clock_cleanup',0x8009C120:'gamesetup_cleanup',0x800B6754:'sim_cleanup',0x800D0184:'horizon_cleanup',0x8007E8B4:'bworld_cleanup',0x80083BEC:'camera_kill',0x800E287C:'weather_cleanup',0x800BBC64:'audio_driver_deinit'}
   if index==1:
    stages.update({int(image['loader_symbols']['SyslibMod_ExitRace'],16):'overlay_exit',0x800F52B8:'unrefpack',int(image['loader_symbols']['SyslibMod_RestoreOverlay'],16):'restore_static',0x8010698C:'enter_critical',0x800F43D4:'flush_cache',0x8010696C:'exit_critical',int(image['loader_symbols']['SyslibMod_RestoreDynamic'],16):'restore_dynamic'})
   for bp in (SIM_LOOP,CLEANUP,FRONT_BOUNDARY,*stages):r.packet(f'Z0,{bp:x},4')
   replay_entry=cleanup_entry=0;stage_hits=[]
   exit_written=[]
   while True:
    r.send_no_reply('c');wait(r,90);pc=reg(r,37)
    if abort.is_set():raise RuntimeError('peer runtime aborted')
    if pc==SIM_LOOP:
     replay_entry+=1;write_memory(r,END_SIM_GAME,struct.pack('<I',1));r.packet(f'z0,{SIM_LOOP:x},4');r.packet('s',timeout=10);continue
    if pc==CLEANUP:
     cleanup_entry+=1;r.packet(f'z0,{CLEANUP:x},4');r.packet('s',timeout=10);continue
    if pc==FRONT_BOUNDARY:break
    if pc in stages:
     if index==1 and stages[pc]=='overlay_exit':
      dynamic=Path(r'C:\Temp\nfs4-syslib-pair\overlay\SYSLIB.DYN').read_bytes();dcount=struct.unpack_from('<I',dynamic,8)[0];addresses=struct.unpack_from(f'<{dcount}I',dynamic,12)
      for address in addresses:
       value=r.read_memory(address,1)[0]
       if value!=canary_bytes(address,1)[0]:exit_written.append(dict(va=f'{address:08X}',value=value))
      print(record['role'],'exit-written',json.dumps(exit_written),flush=True)
     stage_hits.append(stages[pc]);print(record['role'],'natural',stages[pc],flush=True);r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10);continue
    if pc in WATCH:
     hits[WATCH[pc]]+=1;r.packet(f'z0,{pc:x},4');r.packet('s',timeout=10);r.packet(f'Z0,{pc:x},4');continue
    raise RuntimeError(f'natural exit unexpected stop {pc:#x}')
   natural_results=dict(replay_loop_entries=replay_entry,cleanup_entries=cleanup_entry,stage_hits=stage_hits,exit_written_dynamic=exit_written,frontend_boundary=f'{pc:08X}')
  hook_exit_result=None
  if index==1 and hook_exit:
   hook_exit_result=injected_call(r,int(image['loader_symbols']['SyslibMod_ExitRace'],16),[])
   restore_verification=verify_restored_bytes(r,image)
   if hook_exit_result!=image['snapshot']['size'] or restore_verification['different_bytes']:
    raise RuntimeError(f'packed restore verification failed: return={hook_exit_result} verify={restore_verification}')
  else:restore_verification=None
  if index==1 and natural_exit:
   restore_verification=verify_restored_bytes(r,image)
   if restore_verification['different_bytes']:raise RuntimeError(f'natural restore verification failed: {restore_verification}')
  if index==1 and exercise_overlay:
   work=int(image['work_buffer']['address'],16);snapshot=int(image['snapshot']['address'],16)
   overlay_results['load_restore_exit']=async_load(r,image,image['restore_file'],0x80010000)
   overlay_results['restore_static']=injected_call(r,int(image['loader_symbols']['SyslibMod_RestoreOverlay'],16),[0x80010000])
   overlay_results['load_dynamic_exit']=async_load(r,image,image['dynamic_file'],work)
   overlay_results['restore_dynamic']=injected_call(r,int(image['loader_symbols']['SyslibMod_RestoreDynamic'],16),[work,snapshot])
   if overlay_results['restore_static']!=1 or overlay_results['restore_dynamic']!=image['snapshot']['size']:raise RuntimeError(f'overlay restore returned {overlay_results}')
  lifecycle_results={}
  if cleanup_frontend:
   lifecycle_results['cleanup_return']=injected_call(r,0x800A4354,[])
   lifecycle_results['load_overlay_return']=injected_call(r,0x800A454C,[])
  elif load_frontend:
   lifecycle_results['load_overlay_return']=injected_call(r,0x800A454C,[])
  registers=r.packet('g');ram=r.read_memory(0x80000000,0x200000);scratch=r.read_memory(0x1f800000,0x400)
  checkpoint=f'nfs4-syslib-race-{record["role"]}-{uuid.uuid4().hex[:12]}';r.checkpoint(checkpoint)
  save=Path(record['executable']).parent/'savestates'/('ff-audit-'+checkpoint+'.sav')
  result[index]=dict(role=record['role'],setup_overrides=applied_setup,arena_results=arena_results,track=name,slices=slices,pad_frames=pad_frames,sim_entries=sim_count,ticks_before=ticks0,ticks_after=ticks1,tick_trace=tick_trace,entry_status=entry_status,audio_deinit_return=audio_result,hook_exit_return=hook_exit_result,restore_verification=restore_verification,natural_results=natural_results,watched_entries=hits,canaries=canary_result,overlay_results=overlay_results,lifecycle_results=lifecycle_results,registers=registers,ram=ram,scratch=scratch,checkpoint=checkpoint,save=str(save),save_sha256=sha(save))
 except Exception as e:
  abort.set();result[index]=dict(role=record['role'],error=repr(e),watched_entries=hits)
 finally:r.close()
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--startup-report',type=Path,required=True);p.add_argument('--image-report',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--frames',type=int,default=900);p.add_argument('--sim-ticks',type=int,default=0);p.add_argument('--game-ticks',type=int,default=0);p.add_argument('--reclaim-manifest',type=Path);p.add_argument('--exercise-overlay',action='store_true');p.add_argument('--quiesce-audio',action='store_true');p.add_argument('--cleanup-frontend',action='store_true');p.add_argument('--hook-exit',action='store_true');p.add_argument('--load-frontend',action='store_true');p.add_argument('--natural-exit',action='store_true');p.add_argument('--stream-overrides',default='');p.add_argument('--clone-player-two',action='store_true');p.add_argument('--pause-at',type=int,default=0);p.add_argument('--allow-startup-timing-drift',action='store_true');a=p.parse_args();out=a.output.resolve();setup_overrides={int(k,0):int(v,0) for k,v in (x.split('=',1) for x in a.stream_overrides.split(',') if x)}
 if out.exists() or not 1<=a.frames<=5000:p.error('new output and 1..5000 frames required')
 out.mkdir(parents=True);start=json.loads(a.startup_report.read_text());image=json.loads(a.image_report.read_text());paths=[Path(x['record_path']) for x in start['records']];records=[json.loads(x.read_text(encoding='utf-8-sig')) for x in paths]
 if (not start['passed'] and not a.allow_startup_timing_drift) or start['image_report_sha256']!=sha(a.image_report):raise ValueError('unbound startup pair')
 reclaim=None if not a.reclaim_manifest else load_reclaim(a.reclaim_manifest.resolve());rows=[None,None];abort=threading.Event();threads=[threading.Thread(target=run,args=(records[i],paths[i],start['records'][i]['checkpoint'],out,a.frames,a.sim_ticks,a.game_ticks,reclaim,image,a.exercise_overlay,a.quiesce_audio,a.cleanup_frontend,a.hook_exit,a.load_frontend,a.natural_exit,setup_overrides,a.clone_player_two,a.pause_at,rows,i,abort),daemon=True) for i in range(2)]
 for t in threads:t.start()
 for t in threads:t.join()
 report=dict(schema='nfs4-syslib-race-pair-v1',passed=False,frames=a.frames,sim_ticks=a.sim_ticks,startup_report_sha256=sha(a.startup_report),image_report_sha256=sha(a.image_report),runs=[],comparison={})
 if any('error'in x for x in rows):report['runs']=[{k:v for k,v in x.items() if k not in('ram','scratch','registers')} for x in rows]
 else:
  rr=[rows[0]['ram'],rows[1]['ram']];retail=Path(image['source_exe']).read_bytes();load=int(image['load'],16);norm=bytearray(rr[1]);symmetric_image=records[0]['image_sha256']==records[1]['image_sha256']
  if not symmetric_image:
   for hv,size in image['code_ranges']:
    va=int(hv,16);norm[va&0x1fffff:(va&0x1fffff)+size]=retail[0x800+va-load:0x800+va-load+size]
   for hv,size in image.get('runtime_normalize_ranges',[]):
    va=int(hv,16);norm[va&0x1fffff:(va&0x1fffff)+size]=rr[0][va&0x1fffff:(va&0x1fffff)+size]
  if reclaim:
   for item in reclaim['ranges']:
    va=int(item['va'],16);norm[va&0x1fffff:(va&0x1fffff)+item['size']]=rr[0][va&0x1fffff:(va&0x1fffff)+item['size']]
  rr[1]=bytes(norm);diff=[];regs=[decode_registers(x['registers']) for x in rows];stack=min(int(x['r29'],16) for x in regs)
  for off in range(0,0x200000,4):
   if rr[0][off:off+4]!=rr[1][off:off+4]:
    va=0x80000000+off;kind=('kernel-timing' if va<0x80010000 else 'interrupt-stack-residue' if 0x80134B60<=va<0x80135B60 else 'dead-stack-below-sp' if stack-0x1000<=va<stack else 'game-state')
    diff.append(dict(va=f'{va:08X}',retail=rr[0][off:off+4].hex(),candidate=rr[1][off:off+4].hex(),kind=kind))
  shot_equal=screenshot_payload(rows[0]['save'])==screenshot_payload(rows[1]['save'])
  regdiff={k:[regs[0][k],regs[1][k]] for k in regs[0] if regs[0][k]!=regs[1][k]};game=[x for x in diff if x['kind']=='game-state']
  report['runs']=[{k:v for k,v in x.items() if k not in('ram','scratch','registers')} for x in rows]
  report['comparison']=dict(symmetric_image=symmetric_image,ram_differences=len(diff),game_state_differences=len(game),interrupt_stack_differences=sum(x['kind']=='interrupt-stack-residue' for x in diff),first_ram_differences=diff[:50],scratchpad_equal=rows[0]['scratch']==rows[1]['scratch'],register_differences=regdiff,screenshot_equal=shot_equal,track_equal=rows[0]['track']==rows[1]['track'],slices_equal=rows[0]['slices']==rows[1]['slices'],tick_delta=[rows[0]['ticks_after']-rows[0]['ticks_before'],rows[1]['ticks_after']-rows[1]['ticks_before']])
  canary_ok=not reclaim or all(x['unchanged'] for x in rows[1]['canaries']);report['comparison']['canaries_unchanged']=canary_ok
  report['passed']=not game and report['comparison']['scratchpad_equal'] and not regdiff and shot_equal and report['comparison']['track_equal'] and report['comparison']['slices_equal'] and canary_ok
 (out/'report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps({k:report.get(k) for k in('passed','runs','comparison')},indent=2));return 0 if report['passed'] else 1
if __name__=='__main__':raise SystemExit(main())
