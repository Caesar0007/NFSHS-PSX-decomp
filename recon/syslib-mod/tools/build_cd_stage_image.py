#!/usr/bin/env python3
"""Layer the compact resident CD core onto the compact-GTE allocator image."""
import hashlib,json,re,shutil,struct,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];PAIR=Path(r'C:\Temp\nfs4-syslib-pair');BASE=PAIR/'candidate-image-gte';OUT=PAIR/'candidate-image-cd'
EXE=BASE/'NFS4.EXE';IMAGE=BASE/'NFS4-SYSLIB-GTE.IMG';OBJ=ROOT/'build/recon/syslib-mod/psx/libcd/race_core_combined.o'
LD=Path(r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-ld.exe');OBJCOPY=Path(r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-objcopy.exe');NM=Path(r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-nm.exe')
FIXED={'CD_cbsync':0x8013BF48,'CD_cbready':0x8013BF4C,'CD_debug':0x8013BF50,'CD_status':0x8013BF54,'CD_nopen':0x8013BF5C,'CD_pos':0x8013BF60,'CD_mode':0x8013BF64,'CD_com':0x8013BF65,'DS_active':0x8013BF68,'CD_cbread':0x8013C2D0,'CD_read_dma_mode':0x8013C2D4,'StMode':0x801489CC}
ENTER_HOOK=0x800A433C
def sha(x):return hashlib.sha256(x).hexdigest()
def symaddrs():
 out={}
 for line in (ROOT/'configs/symbol_addrs.txt').read_text().splitlines():
  m=re.match(r'(\S+) = 0x([0-9A-Fa-f]+)',line)
  if m:out[m.group(1)]=int(m.group(2),16)
 return out
def main():
 subprocess.run([sys.executable,str(Path(__file__).with_name('build_cd_objects.py'))],check=True,cwd=ROOT)
 base=json.loads((BASE/'image-report.json').read_text());syms=symaddrs();store=int(base['gte_arena']['address'],16);OUT.mkdir(parents=True,exist_ok=True);weak=OUT/'core.weak.o';shutil.copyfile(OBJ,weak)
 weaken=['CD_cbsync','CD_cbready','CD_debug','CD_status','CD_nopen','CD_pos','CD_mode','CD_com','DS_active','StMode']
 subprocess.run([str(OBJCOPY),*[f'--weaken-symbol={x}' for x in weaken],str(weak)],check=True)
 assigns=dict(FIXED)
 for name in ('CheckCallback','DeliverEvent','DMACallback','InterruptCallback','ResetCallback','strncmp','VSync'):assigns[name]=syms[name]
 assigns['nfs4_GteEnterRace']=int(base['symbols']['nfs4_GteEnterRace'],16)
 script=OUT/'core.ld';elf=OUT/'core.elf';defs=' '.join(f'{k} = 0x{v:08X};' for k,v in assigns.items());script.write_text(f'SECTIONS {{ {defs} .text 0x{store:08X} : {{ *(.text) }} .rodata ALIGN(16) : {{ *(.rodata) }} .data ALIGN(16) : {{ *(.data) }} .bss ALIGN(16) : {{ *(.bss) *(COMMON) }} .bss_extra ALIGN(4) : {{ *(.bss.*) }} __cd_store_end = .; /DISCARD/ : {{ *(.text.strip) *(*) }} }}\n',encoding='ascii')
 subprocess.run([str(LD),'-T',str(script),'-o',str(elf),str(weak)],check=True,cwd=ROOT);nm=subprocess.check_output([str(NM),'-S',str(elf)],text=True);defined={parts[-1]:int(parts[0],16) for line in nm.splitlines() if len(parts:=line.split())>=3 and parts[-2] in 'TtRrDdBbAa'};end=defined['__cd_store_end'];payload_file=OUT/'core.bin';subprocess.run([str(OBJCOPY),'-O','binary',str(elf),str(payload_file)],check=True);raw_payload=payload_file.read_bytes();payload=raw_payload+b'\0'*(end-store-len(raw_payload))
 source=EXE.read_bytes();data=bytearray(source);load,size=struct.unpack_from('<II',data,0x18);rows=[]
 def patch(name,va,blob,extent):
  off=0x800+va-load;before=bytes(data[off:off+extent]);data[off:off+extent]=blob+b'\0'*(extent-len(blob));rows.append(dict(name=name,va=f'{va:08X}',size=extent,retail_sha256=sha(before),candidate_sha256=sha(bytes(data[off:off+extent]))))
 patch('compact_cd_store',store,payload,len(payload));patch('gte_arena_base_config',int(base['gte_arena'].get('base_config','80138A08'),16),struct.pack('<I',(end+3)&~3),4)
 redirects=[]
 globals_out=subprocess.check_output([str(NM),'-g','--defined-only',str(elf)],text=True)
 for line in globals_out.splitlines():
  parts=line.split()
  if len(parts)>=3 and parts[-2] in ('T','W') and parts[-1] in syms:
   name=parts[-1];old=syms[name];new=int(parts[0],16)
   if any(x['old']==old for x in redirects):continue
   patch(name+'_redirect',old,struct.pack('<2I',0x08000000|((new>>2)&0x03FFFFFF),0),8);redirects.append(dict(name=name,old=f'{old:08X}',new=f'{new:08X}'))
 patch('CD_enter_hook',ENTER_HOOK,struct.pack('<2I',0x0C000000|((defined['nfs4_CdEnterRace']>>2)&0x03FFFFFF),0),8)
 exe=OUT/'NFS4.EXE';exe.write_bytes(data);img=OUT/'NFS4-SYSLIB-CD.IMG';inject=ROOT/'docs/nfs-psx-formats/tools/psx_iso_inject.py';subprocess.run([sys.executable,str(inject),str(IMAGE),str(img),str(OUT),'NFS4.EXE'],check=True,cwd=ROOT)
 arena_start=(end+3)&~3;arena_size=0x8013BD20-arena_start;gte_arena=dict(base['gte_arena']);gte_arena.update(address=f'{arena_start:08X}',size=arena_size);retired=json.loads((ROOT/'recon/syslib-mod/psx/libcd/retired_cd_ranges.json').read_text());cd_arena=dict(reset=f'{defined["nfs4_CdArenaReset"]:08X}',alloc=f'{defined["nfs4_CdArenaAlloc"]:08X}',capacity=f'{defined["nfs4_CdArenaCapacity"]:08X}',size=retired['total_bytes']);report=dict(schema='nfs4-syslib-cd-image-v2',source_exe=str(EXE),source_exe_sha256=sha(source),candidate_exe=str(exe),candidate_exe_sha256=sha(data),image=str(img),image_sha256=sha(img.read_bytes()),cue=str(img.with_suffix('.cue')),load=f'{load:08X}',image_size=size,cd_store=dict(address=f'{store:08X}',size=end-store,end=f'{end:08X}'),gte_arena=gte_arena,cd_arena=cd_arena,redirects=redirects,retired_cd=retired,patches=rows,code_ranges=base.get('code_ranges',[])+[[x['va'],x['size']] for x in rows],runtime_normalize_ranges=base.get('runtime_normalize_ranges',[]),loader_symbols=base['loader_symbols'],work_buffer=base['work_buffer'],snapshot=base['snapshot'],status_address=base['status_address'],arena_control=base['arena_control'],compressed_restore=base['compressed_restore'])
 (OUT/'image-report.json').write_text(json.dumps(report,indent=2)+'\n')
 production=json.loads((ROOT/'recon/syslib-mod/production_race_reclaim.json').read_text());all_ranges=list(production['ranges'])+[dict(name='gte_compact_table_tail_after_cd_core',va=f'{arena_start:08X}',size=arena_size,allocator='gte')]+retired['ranges'];manifest=dict(schema='nfs4-syslib-production-race-reclaim-cd-v2',total_bytes=sum(x['size'] for x in all_ranges),restore_before=production['restore_before'],ranges=all_ranges);(OUT/'reclaim-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
 print(json.dumps({k:report[k] for k in ('image_sha256','cd_store','gte_arena','cd_arena','redirects')},indent=2))
if __name__=='__main__':main()
