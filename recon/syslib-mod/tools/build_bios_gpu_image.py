#!/usr/bin/env python3
"""Same-address candidate for direct BIOS replacements of low-level GPU helpers."""
import hashlib,json,struct,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];PAIR=Path(r'C:\Temp\nfs4-syslib-pair');OUT=PAIR/'candidate-image-bios-gpu';EXE=ROOT/'rom/nfs4-f.exe';IMAGE=Path(r'C:\Temp\nfs4iso\NFS4.IMG')
PATCHES={'_get_status':(0x800EEA64,0x18,0x4D),'_send_gp0':(0x800EF280,0x40,0x4A),'_gpu_dma_chain':(0x800EF2C0,0x48,0x4B)}
def sha(x):return hashlib.sha256(x).hexdigest()
def main():
 OUT.mkdir(parents=True,exist_ok=True);source=EXE.read_bytes();data=bytearray(source);load,size=struct.unpack_from('<II',data,0x18);rows=[]
 for name,(va,extent,number) in PATCHES.items():
  off=0x800+va-load;before=bytes(data[off:off+extent]);payload=struct.pack('<3I',0x240A00A0,0x01400008,0x24090000|number);data[off:off+extent]=payload+b'\0'*(extent-12);rows.append(dict(name=name,va=f'{va:08X}',size=extent,bios=f'A0:{number:02X}',retail_sha256=sha(before),candidate_sha256=sha(bytes(data[off:off+extent]))))
 exe=OUT/'NFS4.EXE';exe.write_bytes(data);img=OUT/'NFS4-SYSLIB-BIOS-GPU.IMG';inject=ROOT/'docs/nfs-psx-formats/tools/psx_iso_inject.py';subprocess.run([sys.executable,str(inject),str(IMAGE),str(img),str(OUT),'NFS4.EXE'],check=True,cwd=ROOT)
 report=dict(schema='nfs4-syslib-bios-gpu-v1',same_address=True,source_exe=str(EXE),source_exe_sha256=sha(source),candidate_exe=str(exe),candidate_exe_sha256=sha(data),image=str(img),image_sha256=sha(img.read_bytes()),cue=str(img.with_suffix('.cue')),load=f'{load:08X}',image_size=size,patches=rows,code_ranges=[[x['va'],x['size']] for x in rows],expected_runtime_reclaim=0,eventual_compacted_saving=sum(x[1]-12 for x in PATCHES.values()))
 (OUT/'image-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps(report,indent=2))
if __name__=='__main__':main()
