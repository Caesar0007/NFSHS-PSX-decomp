#!/usr/bin/env python3
"""Build a bootable FONT/PC candidate containing the resident restore loader and disc assets."""
import hashlib,json,re,shutil,struct,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];PAIR=Path(r'C:\Temp\nfs4-syslib-pair');OUT=PAIR/'candidate-image-overlay';EXE=ROOT/'rom/nfs4-f.exe';IMAGE=Path(r'C:\Temp\nfs4iso\NFS4.IMG');OBJ=ROOT/'build/recon/syslib-mod/psx/overlay_restore.c.o';LD=Path(r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-ld.exe');OBJCOPY=Path(r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-objcopy.exe')
TEXT=0x800F6D20;TEXT_CAP=0x6D4;FNT=0x800F6D18
PC={'PCread':(0x80106BE4,0xC0,-1),'PCopen':(0x80106CA4,0x20,-1),'PCinit':(0x80106CC4,0x0C,0),'PCcreat':(0x80106CD0,0x20,-1),'PClseek':(0x80106D1C,0x24,-1),'PCclose':(0x80106D40,0x10,0),'PCwrite':(0x80106D50,0xC0,-1)}
SYMS={'FlushCache':0x800F43D4,'EnterCriticalSection':0x8010698C,'ExitCriticalSection':0x8010696C,'asyncloadfileat':0x800F143C,'getasyncreadstatus':0x800F16D8,'systemtask':0x800E6C04,'unrefpack':0x800F52B8,'AudioCmn_DeInit':0x80076F44}
def sha(x):return hashlib.sha256(x).hexdigest()
def root_files(path):
 raw=path.read_bytes();sector=lambda n:raw[n*2352+24:n*2352+24+2048];pvd=sector(16);lba,size=struct.unpack_from('<I',pvd,158)[0],struct.unpack_from('<I',pvd,166)[0];result={}
 for i in range((size+2047)//2048):
  data=sector(lba+i);off=0
  while off<2048 and data[off]:
   rec=data[off:off+data[off]];name=rec[33:33+rec[32]].decode('ascii','replace').split(';')[0].upper();result[name]=(struct.unpack_from('<I',rec,2)[0],struct.unpack_from('<I',rec,10)[0]);off+=data[off]
 return result
def main():
 OUT.mkdir(parents=True,exist_ok=True);script=OUT/'loader.ld';elf=OUT/'loader.elf';assign=' '.join(f'{k} = 0x{v:08X};' for k,v in SYMS.items());script.write_text(f'SECTIONS {{ {assign} .text 0x{TEXT:08X} : {{ *(.text) *(.rodata*) *(.sdata*) }} /DISCARD/ : {{ *(*) }} }}\n',encoding='ascii');subprocess.run([str(LD),'-T',str(script),'-o',str(elf),str(OBJ)],check=True);textfile=OUT/'loader.bin';subprocess.run([str(OBJCOPY),'-O','binary','-j','.text',str(elf),str(textfile)],check=True);loader=textfile.read_bytes();nm=subprocess.check_output([r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-nm.exe','-S',str(elf)],text=True);symbols={m.group(2):m.group(1) for line in nm.splitlines() if (m:=re.match(r'([0-9a-fA-F]+)\s+\S+\s+[TtRr]\s+(\S+)',line))}
 if len(loader)>TEXT_CAP:raise ValueError('loader exceeds dead FONT text')
 raw=EXE.read_bytes();data=bytearray(raw);load,size=struct.unpack_from('<II',data,0x18);rows=[]
 def patch(name,va,payload,extent):
  off=0x800+va-load;before=bytes(data[off:off+extent]);data[off:off+extent]=payload+b'\0'*(extent-len(payload));rows.append(dict(name=name,va=f'{va:08X}',size=extent,retail_sha256=sha(before),candidate_sha256=sha(bytes(data[off:off+extent]))))
 patch('FntFlush_stub',FNT,struct.pack('<2I',0x03E00008,0x00001021),8);patch('overlay_loader',TEXT,loader,TEXT_CAP)
 for name,(va,extent,value) in PC.items():patch(name,va,struct.pack('<2I',0x03E00008,0x2402FFFF if value<0 else 0x00001021),extent)
 def jal(symbol):return 0x0C000000|((int(symbols[symbol],16)>>2)&0x03FFFFFF)
 patch('overlay_enter_hook',0x800A433C,struct.pack('<I',jal('SyslibMod_EnterRace')),4)
 patch('overlay_exit_hook',0x800A4474,struct.pack('<I',jal('SyslibMod_CleanupAudioAndRestore')),4)
 exe=OUT/'NFS4.EXE';exe.write_bytes(data);compress=ROOT/'recon/syslib-mod/tools/refpack_compress.py';subprocess.run([sys.executable,str(compress),str(PAIR/'overlay/SYSLIB.RSO'),str(PAIR/'overlay/SYSLIB.RSC')],check=True,cwd=ROOT);shutil.copyfile(PAIR/'overlay/SYSLIB.RSC',OUT/'NFS4.SYM');shutil.copyfile(PAIR/'overlay/SYSLIB.DYN',OUT/'NFS4.MAP');img=OUT/'NFS4-SYSLIB-OVERLAY.IMG';inject=ROOT/'docs/nfs-psx-formats/tools/psx_iso_inject.py';subprocess.run([sys.executable,str(inject),str(IMAGE),str(img),str(OUT),'NFS4.*'],check=True,cwd=ROOT)
 snapshot_address=0x80140454;snapshot_size=478;work_address=(snapshot_address+snapshot_size+3)&~3;work_size=1924;status_address=work_address+work_size;arena_control=dict(address=f'{status_address+4:08X}',size=8);compressed_address=status_address+12;compressed_size=(PAIR/'overlay/SYSLIB.RSC').stat().st_size;reserved_span=compressed_address+compressed_size-snapshot_address;files=root_files(img);report=dict(schema='nfs4-syslib-overlay-image-v1',source_exe=str(EXE),source_exe_sha256=sha(raw),candidate_exe=str(exe),candidate_exe_sha256=sha(data),image=str(img),image_sha256=sha(img.read_bytes()),cue=str(img.with_suffix('.cue')),load=f'{load:08X}',image_size=size,loader_bytes=len(loader),loader_symbols=symbols,work_buffer=dict(address=f'{work_address:08X}',size=work_size),snapshot=dict(address=f'{snapshot_address:08X}',size=snapshot_size),status_address=f'{status_address:08X}',arena_control=arena_control,compressed_restore=dict(address=f'{compressed_address:08X}',size=compressed_size,unpacked_size=33368),name_buffer=f'{work_address:08X}',patches=rows,code_ranges=[[x['va'],x['size']] for x in rows],runtime_normalize_ranges=[['80149864',4],['80149878',4]],restore_file='NFS4.SYM',restore_lba=files['NFS4.SYM'][0],dynamic_file='NFS4.MAP',dynamic_lba=files['NFS4.MAP'][0],gross_reclaim=64120,resident_overhead=len(loader)+reserved_span,net_reclaim=64120-len(loader)-reserved_span)
 (OUT/'image-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps({k:report[k] for k in ('loader_bytes','loader_symbols','gross_reclaim','resident_overhead','net_reclaim','image_sha256')},indent=2))
if __name__=='__main__':main()
