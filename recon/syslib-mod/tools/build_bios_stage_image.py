#!/usr/bin/env python3
"""Build same-address candidates replacing selected syslib routines with BIOS thunks."""
import argparse,hashlib,json,struct,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];PAIR=Path(r'C:\Temp\nfs4-syslib-pair');OUT=PAIR/'candidate-image-bios-sort';EXE=ROOT/'rom/nfs4-f.exe';IMAGE=Path(r'C:\Temp\nfs4iso\NFS4.IMG')
# name: VA, complete reclaimable object extent, BIOS vector, function number
PATCHES={'qsort':(0x800E5D8C,0x18C,0xA0,0x31),'bsearch':(0x801091DC,0x0C0,0xA0,0x36)}
def sha(x):return hashlib.sha256(x).hexdigest()
def thunk(vector,number):return struct.pack('<3I',0x240A0000|vector,0x01400008,0x24090000|number)
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--variant',choices=('qsort','bsearch','combined'),default='combined');a=p.parse_args();out=PAIR/('candidate-image-bios-sort' if a.variant=='combined' else f'candidate-image-bios-{a.variant}');chosen=PATCHES if a.variant=='combined' else {a.variant:PATCHES[a.variant]}
 out.mkdir(parents=True,exist_ok=True);source=EXE.read_bytes();data=bytearray(source);load,size=struct.unpack_from('<II',data,0x18);rows=[]
 for name,(va,extent,vector,number) in chosen.items():
  off=0x800+va-load;before=bytes(data[off:off+extent]);payload=thunk(vector,number);data[off:off+extent]=payload+b'\0'*(extent-len(payload));rows.append(dict(name=name,va=f'{va:08X}',size=extent,bios=f'{vector:02X}:{number:02X}',retail_sha256=sha(before),candidate_sha256=sha(bytes(data[off:off+extent]))))
 exe=out/'NFS4.EXE';exe.write_bytes(data);img=out/f'NFS4-SYSLIB-BIOS-{a.variant.upper()}.IMG';inject=ROOT/'docs/nfs-psx-formats/tools/psx_iso_inject.py';subprocess.run([sys.executable,str(inject),str(IMAGE),str(img),str(out),'NFS4.EXE'],check=True,cwd=ROOT)
 report=dict(schema='nfs4-syslib-bios-sort-v1',variant=a.variant,same_address=True,source_exe=str(EXE),source_exe_sha256=sha(source),candidate_exe=str(exe),candidate_exe_sha256=sha(data),image=str(img),image_sha256=sha(img.read_bytes()),cue=str(img.with_suffix('.cue')),load=f'{load:08X}',image_size=size,patches=rows,code_ranges=[[x['va'],x['size']] for x in rows],expected_runtime_reclaim=0,eventual_compacted_saving=sum(x[1]-12 for x in chosen.values()))
 (out/'image-report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8');print(json.dumps(report,indent=2))
if __name__=='__main__':main()
