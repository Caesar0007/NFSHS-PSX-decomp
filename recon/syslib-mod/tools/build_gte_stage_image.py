#!/usr/bin/env python3
"""Layer compact RotMatrix/RotMatrixZ and quarter table onto the allocator image."""
import hashlib,json,re,struct,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];PAIR=Path(r'C:\Temp\nfs4-syslib-pair');BASE=PAIR/'candidate-image-overlay';OUT=PAIR/'candidate-image-gte'
EXE=BASE/'NFS4.EXE';IMAGE=BASE/'NFS4-SYSLIB-OVERLAY.IMG';OBJ=ROOT/'build/recon/syslib-mod/psx/libgte/compact_trig.c.o'
LD=Path(r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-ld.exe');OBJCOPY=Path(r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-objcopy.exe');NM=Path(r'C:\tools\mips-ps1\mips\bin\mipsel-none-elf-nm.exe')
STORE=0x80137D20;STORE_SIZE=16384;TEXT=STORE;TABLE=0x80138200;ROTM=0x800F252C;ROTMZ=0x800F312C;ENTER_HOOK=0x800A433C
def sha(x):return hashlib.sha256(x).hexdigest()
def main():
 base_report=json.loads((BASE/'image-report.json').read_text())
 OUT.mkdir(parents=True,exist_ok=True);script=OUT/'compact.ld';elf=OUT/'compact.elf';script.write_text(f'SECTIONS {{ SyslibMod_EnterRace = 0x{int(base_report["loader_symbols"]["SyslibMod_EnterRace"],16):08X}; .text 0x{TEXT:08X} : {{ *(.text) }} .rodata 0x{TABLE:08X} : {{ *(.rodata) }} /DISCARD/ : {{ *(*) }} }}\n',encoding='ascii');subprocess.run([str(LD),'-T',str(script),'-o',str(elf),str(OBJ)],check=True,cwd=ROOT)
 textfile=OUT/'compact.text.bin';tablefile=OUT/'compact.table.bin';subprocess.run([str(OBJCOPY),'-O','binary','-j','.text',str(elf),str(textfile)],check=True);subprocess.run([str(OBJCOPY),'-O','binary','-j','.rodata',str(elf),str(tablefile)],check=True);text=textfile.read_bytes();table=tablefile.read_bytes();symbols={m.group(3):int(m.group(1),16) for line in subprocess.check_output([str(NM),'-S',str(elf)],text=True).splitlines() if (m:=re.match(r'([0-9a-fA-F]+)\s+([0-9a-fA-F]+)\s+[TtRr]\s+(\S+)',line))}
 if len(text)>TABLE-TEXT or TABLE-STORE+len(table)>STORE_SIZE:raise ValueError('compact payload overflow')
 source=EXE.read_bytes();data=bytearray(source);load,size=struct.unpack_from('<II',data,0x18);rows=[]
 def patch(name,va,payload,extent):
  off=0x800+va-load;before=bytes(data[off:off+extent]);data[off:off+extent]=payload+b'\0'*(extent-len(payload));rows.append(dict(name=name,va=f'{va:08X}',size=extent,retail_sha256=sha(before),candidate_sha256=sha(bytes(data[off:off+extent]))))
 store=bytearray(STORE_SIZE);store[:len(text)]=text;store[TABLE-STORE:TABLE-STORE+len(table)]=table;struct.pack_into('<I',store,0x80138A08-STORE,0x80138A0C);patch('compact_gte_store',STORE,bytes(store),STORE_SIZE)
 def jump(target):return struct.pack('<2I',0x08000000|((target>>2)&0x03ffffff),0)
 patch('RotMatrix_redirect',ROTM,jump(symbols['nfs4_RotMatrix_compact']),8);patch('RotMatrixZ_redirect',ROTMZ,jump(symbols['nfs4_RotMatrixZ_compact']),8)
 def call(target):return struct.pack('<2I',0x0C000000|((target>>2)&0x03ffffff),0)
 patch('Gte_enter_hook',ENTER_HOOK,call(symbols['nfs4_GteEnterRace']),8)
 exe=OUT/'NFS4.EXE';exe.write_bytes(data);img=OUT/'NFS4-SYSLIB-GTE.IMG';inject=ROOT/'docs/nfs-psx-formats/tools/psx_iso_inject.py';subprocess.run([sys.executable,str(inject),str(IMAGE),str(img),str(OUT),'NFS4.EXE'],check=True,cwd=ROOT)
 used=TABLE-STORE+len(table);gte_arena=dict(address='80138A0C',size=0x8013BD20-0x80138A0C,control='80138A04',base_config='80138A08',reset=f'{symbols["nfs4_GteArenaReset"]:08X}',alloc=f'{symbols["nfs4_GteArenaAlloc"]:08X}',capacity=f'{symbols["nfs4_GteArenaCapacity"]:08X}');report=dict(schema='nfs4-syslib-gte-image-v2',source_exe=str(EXE),source_exe_sha256=sha(source),candidate_exe=str(exe),candidate_exe_sha256=sha(data),image=str(img),image_sha256=sha(img.read_bytes()),cue=str(img.with_suffix('.cue')),load=f'{load:08X}',image_size=size,text_bytes=len(text),table_bytes=len(table),store_bytes=STORE_SIZE,store_used=used,additional_reclaim=gte_arena['size'],gte_arena=gte_arena,symbols={k:f'{v:08X}' for k,v in symbols.items()},patches=rows,code_ranges=[[x['va'],x['size']] for x in rows],runtime_normalize_ranges=[],loader_symbols=base_report['loader_symbols'],work_buffer=base_report['work_buffer'],snapshot=base_report['snapshot'],status_address=base_report['status_address'],arena_control=base_report['arena_control'],compressed_restore=base_report['compressed_restore'])
 (OUT/'image-report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
if __name__=='__main__':main()
