"""Gate persistent PSX C variants by real linked bytes AND live/native results.

Only exact entries from ports/psx_match are admitted. General portable C bodies
remain unchanged. No source pins, assembly, text patching, or normalization of
instruction operands is used in the byte gate.
"""
from pathlib import Path
import ctypes as C
import hashlib
import json
import random
import struct
import subprocess
import sys
import time
from search_psx_match import ROOT, PORTS, HEADERS, compile_candidate

sys.path.insert(0,str(ROOT/'tools/duckstation'))
from gdb_remote import Remote, decode_registers

sha=lambda data:hashlib.sha256(data).hexdigest()
ARENA=0x801C0000
RETURN=0x801FE000

def main():
    assert sys.byteorder=='little', 'PSX-specific word-load variant needs little endian'
    sources={'shapecount':PORTS/'psx_match/shapecount.c',
             'setclipwindow':PORTS/'psx_match/null_result.c'}
    source_hashes={str(p.relative_to(PORTS)):sha(p.read_bytes()) for p in
                   list(sources.values())+[PORTS/'include/nfs4_psx_match.h']}
    build=PORTS/'build/exact_matches';build.mkdir(parents=True,exist_ok=True)
    inc=build/'include';inc.mkdir(exist_ok=True)
    for name,text in HEADERS.items():(inc/name).write_text(text)
    matches=[compile_candidate(build,'exact_'+name,path,name) for name,path in sources.items()]
    assert all(m['exact_linked_bytes'] for m in matches), matches

    dll_path=build/'exact_matches.dll'
    compiled=subprocess.run(['gcc','-std=c11','-O2','-Wall','-Wextra','-Werror',
                             '-shared',*[str(p) for p in sources.values()],'-o',str(dll_path)],
                            capture_output=True,text=True,timeout=60)
    (build/'native.log').write_text(compiled.stdout+compiled.stderr)
    compiled.check_returncode()
    lib=C.CDLL(str(dll_path))
    lib.nfs4_match_shapecount.argtypes=[C.POINTER(C.c_uint32)]
    lib.nfs4_match_shapecount.restype=C.c_uint32
    lib.nfs4_match_setclipwindow.argtypes=[]
    lib.nfs4_match_setclipwindow.restype=C.c_uint32
    rom=(ROOT/'rom/nfs4-f.exe').read_bytes()
    base=struct.unpack_from('<I',rom,0x18)[0]
    windows={'shapecount':(0x800F0AAC,12),'setclipwindow':(0x800F6114,8)}
    record=json.loads((ROOT/'status/runtime/duckstation-process.json').read_text(encoding='utf-8-sig'))
    exe=Path(record['executable']).resolve()
    expected=(ROOT/'tools/duckstation/api-runtime/duckstation-qt-x64-ReleaseLTCG.exe').resolve()
    assert exe==expected and record['port']==2350
    command=f"$p=Get-CimInstance Win32_Process -Filter 'ProcessId = {record['pid']}'; " \
            "$l=Get-NetTCPConnection -State Listen -LocalPort 2350; " \
            "@{exe=$p.ExecutablePath;owner=@($l.OwningProcess)}|ConvertTo-Json -Compress"
    actual=json.loads(subprocess.check_output(['powershell','-NoProfile','-Command',command],text=True))
    assert Path(actual['exe']).resolve()==exe and actual['owner']==[record['pid']]
    g=Remote('127.0.0.1',2350)
    g.s.setsockopt(__import__('socket').IPPROTO_TCP,__import__('socket').TCP_NODELAY,1)
    assert g.packet('?').startswith(('S','T'))
    before=g.packet('g');before_regs=decode_registers(before)
    before_ram=g.read_memory(0x80000000,0x200000)
    before_scratch=g.read_memory(0x1F800000,1024)
    label=time.strftime('exact-%Y%m%d-%H%M%S')
    out=PORTS/'evidence'/label;out.mkdir(parents=True,exist_ok=False)
    g.checkpoint(label)
    tests=[];counts={}
    rng=random.Random(0x4E465334)
    def write(address,data):
        for offset in range(0,len(data),1024):
            chunk=data[offset:offset+1024]
            assert g.packet(f'M{address+offset:x},{len(chunk):x}:'+chunk.hex())=='OK'
    def call(name,arguments):
        regs=[before[i:i+8] for i in range(0,len(before),8)]
        values={i:(0x24680000+i*0x10203)&0xFFFFFFFF for i in range(1,32)}
        values.update({4+i:a for i,a in enumerate(arguments)})
        values.update({28:0x80140000,29:0x801FD000,31:RETURN,32:0,37:windows[name][0]})
        for index,value in values.items():regs[index]=struct.pack('<I',value).hex()
        assert g.packet('G'+''.join(regs))=='OK'
        assert g.packet('c',timeout=10).startswith(('S','T'))
        state=decode_registers(g.packet('g'))
        assert int(state['pc'],16)==RETURN,state
        for i in range(1,32):
            if i!=2:assert int(state[f'r{i}'],16)==values[i], (name,f'unexpected register effect r{i}')
        return int(state['r2'],16)
    try:
        for name,(address,size) in windows.items():
            offset=address-base+0x800
            write(address,rom[offset:offset+size])
        assert g.packet(f'Z0,{RETURN:x},4')=='OK'
        injected=g.read_memory(0x80000000,0x200000)
        values=[0,1,2,7,8,0x7FFF,0xFFFF,0x7FFFFFFF,0x80000000,0xFFFFFFFE,0xFFFFFFFF]
        values += [rng.getrandbits(32) for _ in range(256)]
        for count in values:
            data=struct.pack('<4I',rng.getrandbits(32),rng.getrandbits(32),count,rng.getrandbits(32))
            write(ARENA,data)
            buffer=(C.c_uint32*4).from_buffer_copy(data)
            assert C.addressof(buffer)%4==0
            native=lib.nfs4_match_shapecount(buffer)
            retail=call('shapecount',[ARENA])
            assert bytes(buffer)==data and g.read_memory(ARENA,16)==data
            tests.append({'function':'shapecount','input':data.hex(),'native':native,
                          'retail':retail,'passed':native==retail})
            assert native==retail
            counts['shapecount']=counts.get('shapecount',0)+1
        for _ in range(64):
            arguments=[rng.getrandbits(32) for _ in range(4)]
            native=lib.nfs4_match_setclipwindow()
            retail=call('setclipwindow',arguments)
            tests.append({'function':'setclipwindow','arguments':arguments,'native':native,
                          'retail':retail,'passed':native==retail})
            assert native==retail==0
            counts['setclipwindow']=counts.get('setclipwindow',0)+1
        after=bytearray(g.read_memory(0x80000000,0x200000))
        offset=ARENA&0x1FFFFF;after[offset:offset+16]=injected[offset:offset+16]
        assert bytes(after)==injected,'unexpected RAM write'
    finally:
        g.checkpoint(label,load=True)
        restored_ram=g.read_memory(0x80000000,0x200000)
        restored_scratch=g.read_memory(0x1F800000,1024)
        restored_regs=decode_registers(g.packet('g'));g.close()
        assert restored_ram==before_ram and restored_scratch==before_scratch
        differences={k:[v,restored_regs.get(k)] for k,v in before_regs.items() if v!=restored_regs.get(k)}
        assert not(set(differences)-{'cause'}),differences
        if 'cause' in differences:
            assert (int(differences['cause'][0],16)^int(differences['cause'][1],16))&~0x400==0
        (out/'cases.json').write_text(json.dumps(tests,indent=2))
    assert all(sha((PORTS/name).read_bytes())==digest for name,digest in source_hashes.items())
    report={'passed':True,'byte_matches':matches,'runtime_cases':sum(counts.values()),
            'per_function':counts,'source_sha256':source_hashes,'rom_sha256':sha(rom),
            'native_dll_sha256':sha(dll_path.read_bytes()),'emulator_sha256':sha(exe.read_bytes()),
            'all_state_restored':True,'register_differences_after_restore':differences,
            'scope':'two ordinary-C PSX-specific entries, exact linked bytes plus tested native behavior; other routines remain open'}
    path=PORTS/'verification/exact_matches.json';path.write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({'passed':True,'exact_bodies':len(matches),'runtime_cases':sum(counts.values()),'report':str(path)}))

if __name__=='__main__':main()
