"""NFS4 adaptation of PSX-Dynamic-Decomp's audit_actor_math.py methodology.

Native portable C DLL vs live patched DuckStation executing retail ROM bytes.
Uses the repository's already-adapted gdb_remote/shared_ram, dedicated port2350,
full-state save/restore, raw fixture records, and no game-specific FF addresses.
No instruction interpreter stands in for the emulator. Unsupported/trapping
cases fail closed or are checked as explicit MIPS exception results.
"""
from pathlib import Path
import argparse
import ctypes as C
import hashlib
import json
import random
import re
import struct
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[2]
PORTS = ROOT / 'ports'
sys.path.insert(0, str(ROOT / 'tools/duckstation'))
from gdb_remote import Remote, decode_registers

ARENA = 0x801C0000
RETURN = 0x801FE000
SEED = 0x8012349C
BOOT_GP = 0x801234E8
FAULT = 0x80000080
MASK = 0xFFFFFFFF
sha = lambda data: hashlib.sha256(data).hexdigest()
u32 = lambda x: x & MASK
s32 = lambda x: x if x < 0x80000000 else x - 0x100000000

class ArithmeticResult(C.Structure):
    _fields_ = [('bits', C.c_uint32), ('overflow', C.c_uint32)]

class RandomState(C.Structure):
    _fields_ = [('words', C.c_uint32 * 6)]

class GPContext(C.Structure):
    _fields_ = [('boot_gp', C.c_uint32), ('current_gp', C.c_uint32)]

def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--random-cases', type=int, default=64)
    ap.add_argument('--label', default=time.strftime('eac-%Y%m%d-%H%M%S'))
    args = ap.parse_args()
    out = PORTS / 'evidence' / args.label
    out.mkdir(parents=True, exist_ok=False)
    build = PORTS / 'build'
    build.mkdir(exist_ok=True)
    dll_path = build / 'nfs4_eac_port.dll'
    command = ['gcc', '-std=c11', '-O2', '-Wall', '-Wextra', '-Werror', '-shared',
               str(PORTS/'eaclib/eac_port.c'), str(PORTS/'eaclib/shape_sine_port.c'),
               '-o', str(dll_path)]
    compiled = subprocess.run(command, capture_output=True, text=True)
    (out/'build.log').write_text(compiled.stdout + compiled.stderr)
    compiled.check_returncode()
    lib = C.CDLL(str(dll_path))
    scalar = {
        'fixedmult': ([C.c_int32,C.c_int32], C.c_uint32),
        'fixeddiv': ([C.c_int32,C.c_int32], ArithmeticResult),
        'fixedinverse': ([C.c_int32], C.c_uint32),
        'fixedsqrt': ([C.c_int32], C.c_uint32),
        'divu64': ([C.c_uint32]*3, C.c_uint32),
        'getm': ([C.c_void_p,C.c_int32], C.c_uint32),
        'geti': ([C.c_void_p,C.c_uint32], C.c_uint32),
        'crc16': ([C.c_void_p,C.c_int32], C.c_uint32),
        'shapedepth': ([C.c_void_p], C.c_int32),
        'make64': ([C.c_void_p,C.c_int32,C.c_int32], C.c_uint32),
        'blockfill': ([C.c_void_p,C.c_int32,C.c_uint32], None),
        'blockclear': ([C.c_void_p,C.c_int32], None),
        'blockmove': ([C.c_void_p,C.c_void_p,C.c_int32], None),
        'random': ([C.POINTER(RandomState)], C.c_uint32),
        'seedrandom': ([C.POINTER(RandomState),C.c_uint32], None),
        'initgp': ([C.POINTER(GPContext)], None),
        'savegp': ([C.POINTER(GPContext),C.POINTER(C.c_uint32)], None),
        'restoregp': ([C.POINTER(GPContext),C.c_uint32], None)
    }
    scalar.update({'intsin':([C.c_uint32],C.c_uint32),
                   'intcos':([C.c_uint32],C.c_uint32),
                   'shapecount':([C.c_void_p],C.c_uint32),
                   'shapepointer':([C.c_void_p,C.c_uint32],C.c_void_p),
                   'shapename':([C.c_void_p,C.c_uint32,C.c_void_p],None),
                   'null_result':([],C.c_uint32)})
    for name, (types, result) in scalar.items():
        fn = getattr(lib, 'nfs4_'+name)
        fn.argtypes, fn.restype = types, result

    rom = (ROOT/'rom/nfs4-f.exe').read_bytes()
    assert rom[:8] == b'PS-X EXE'
    base, size = struct.unpack_from('<II', rom, 0x18)
    def raw(address, length):
        offset = address - base + 0x800
        assert 0x800 <= offset <= offset+length <= min(len(rom),size+0x800)
        return rom[offset:offset+length]
    windows = {}
    for name in ('blockmove','blockclear','blockfill','fixedmult','rdiv',
                 'fixedinverse','fixedsqrt','random','seedrandom','crc16',
                 'getm','geti','make64','divu64','shapedepth','initgp','savegp','restoregp',
                 'intsin','intcos','shapecount','shapepointer','shapename','setclipwindow'):
        path = ROOT/'asm/nonmatchings/main'/f'{name}.s'
        rows = re.findall(r'/\*\s+[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s+([0-9A-Fa-f]{8})\s+\*/',
                          path.read_text())
        assert rows, name
        address = int(rows[0][0],16)
        code = b''.join(bytes.fromhex(word) for _,word in rows)
        assert all(int(va,16)==address+4*i for i,(va,_) in enumerate(rows)), name
        assert raw(address,len(code))==code, f'ROM/oracle mismatch: {name}'
        windows[name] = (address,code)

    # Do not connect based on a stale PID file: verify actual listener ownership.
    record = json.loads((ROOT/'status/runtime/duckstation-process.json').read_text(encoding='utf-8-sig'))
    exe = Path(record['executable']).resolve()
    assert exe == (ROOT/'tools/duckstation/api-runtime/duckstation-qt-x64-ReleaseLTCG.exe').resolve()
    assert record['port']==2350
    ps = f"$p=Get-CimInstance Win32_Process -Filter 'ProcessId = {record['pid']}'; " \
         f"$l=Get-NetTCPConnection -State Listen -LocalPort 2350; " \
         "@{exe=$p.ExecutablePath;owner=@($l.OwningProcess)}|ConvertTo-Json -Compress"
    live = json.loads(subprocess.check_output(['powershell','-NoProfile','-Command',ps],text=True))
    assert Path(live['exe']).resolve()==exe and live['owner']==[record['pid']]
    g = Remote('127.0.0.1',2350)
    g.s.setsockopt(__import__('socket').IPPROTO_TCP,__import__('socket').TCP_NODELAY,1)
    assert g.packet('?').startswith(('S','T'))
    before = g.packet('g')
    before_regs = decode_registers(before)
    before_ram = g.read_memory(0x80000000,0x200000)
    before_scratch = g.read_memory(0x1F800000,1024)
    checkpoint = args.label
    g.checkpoint(checkpoint)
    tests, counts = [], {}
    rng = random.Random(0x4E465334)
    def write(address, data):
        for off in range(0,len(data),1024):
            piece = data[off:off+1024]
            assert g.packet(f'M{address+off:x},{len(piece):x}:'+piece.hex())=='OK'
    def call(name, values=(), gp=None):
        regs = [before[i:i+8] for i in range(0,len(before),8)]
        # GPR sentinels let us check every callee-saved register independently.
        changed = {i:u32(0x13570000+i*0x10203) for i in range(1,32)}
        changed.update({4+i:u32(v) for i,v in enumerate(values)})
        changed.update({28:gp if gp is not None else 0x80140000,
                        29:0x801FD000,31:RETURN,32:0,37:windows[name][0]})
        for i,v in changed.items(): regs[i]=struct.pack('<I',v).hex()
        assert g.packet('G'+''.join(regs))=='OK'
        reply = g.packet('c',timeout=10)
        assert reply.startswith(('S','T')), reply
        state = decode_registers(g.packet('g'))
        pc = int(state['pc'],16)
        assert pc in (RETURN,FAULT), (name,state)
        fault = ((int(state['cause'],16)>>2)&31) if pc==FAULT else 0
        if fault: assert fault==12, (name,state)
        for i in list(range(16,24))+[29,30]:
            assert int(state[f'r{i}'],16)==changed[i], (name,f'callee-saved r{i}')
        if name not in ('savegp','restoregp'):
            assert int(state['r28'],16)==changed[28], (name,'gp changed')
        return int(state['r2'],16),fault,state
    def check(name, values, native, oracle, fixture=b''):
        counts[name]=counts.get(name,0)+1
        item={'function':name,'arguments':[u32(x) for x in values],
              'native':native,'retail':oracle,'fixture_sha256':sha(fixture),
              'passed':native==oracle}
        tests.append(item)
        assert native==oracle, item
    try:
        for _,(address,code) in windows.items(): write(address,code)
        for address,length in ((0x801234EC,264),(0x80135C58,512),(0x80137464,1028)):
            write(address,raw(address,length))
        write(RETURN,struct.pack('<II',0x0807F800,0)) # unexecuted return breakpoint
        assert g.packet(f'Z0,{RETURN:x},4')=='OK'
        assert g.packet(f'Z0,{FAULT:x},4')=='OK'
        injected_ram = g.read_memory(0x80000000,0x200000)

        edges=[0,1,2,3,0x7FFF,0x8000,0xFFFF,0x10000,0x7FFFFFFF,0x80000000,0xFFFFFFFF]
        pairs=[(s32(a),s32(b)) for a in edges for b in edges]
        pairs += [(s32(rng.getrandbits(32)),s32(rng.getrandbits(32))) for _ in range(args.random_cases)]
        for a,b in pairs:
            native=lib.nfs4_fixedmult(a,b)
            ret,fault,_=call('fixedmult',(a,b));check('fixedmult',(a,b),[native,0],[ret,fault])
            native=lib.nfs4_fixeddiv(a,b)
            ret,fault,_=call('rdiv',(a,b))
            check('fixeddiv',(a,b),[native.bits if not native.overflow else None,native.overflow],
                  [ret if not fault else None,int(bool(fault))])
        roots=set(edges)
        for bit in range(32):
            roots.update(u32((1<<bit)+d) for d in (-1,0,1))
        roots.update(rng.getrandbits(32) for _ in range(args.random_cases))
        for bits in sorted(roots):
            x=s32(bits)
            for name in ('fixedinverse','fixedsqrt'):
                ret,fault,_=call(name,(x,))
                check(name,(x,),[getattr(lib,'nfs4_'+name)(x),0],[ret,fault])
        for _ in range(args.random_cases+8):
            vals=tuple(rng.getrandbits(32) for _ in range(3))
            ret,fault,_=call('divu64',vals)
            check('divu64',vals,[lib.nfs4_divu64(*vals),0],[ret,fault])

        initial=bytes(rng.getrandbits(8) for _ in range(4096))
        sizes=list(range(0,17))+[31,32,63,64,65,127,128,129,255,256,257,511,1024]
        for length in sizes:
            for offset in range(4):
                for name in ('blockfill','blockclear'):
                    write(ARENA,initial)
                    buffer=C.create_string_buffer(initial,len(initial))
                    value=rng.getrandbits(32)
                    dst=128+offset
                    values=(ARENA+dst,length,value) if name=='blockfill' else (ARENA+dst,length)
                    if name=='blockfill':lib.nfs4_blockfill(C.byref(buffer,dst),length,value)
                    else:lib.nfs4_blockclear(C.byref(buffer,dst),length)
                    _,fault,_=call(name,values)
                    actual=g.read_memory(ARENA,len(initial))
                    check(name,values,[sha(buffer.raw),0],[sha(actual),fault],initial)
        for length in sizes:
            for delta in (-129,-17,-4,-3,-1,0,1,2,3,4,17,129,1400):
                src=512+(length&3);dst=src+delta
                write(ARENA,initial)
                buffer=C.create_string_buffer(initial,len(initial))
                lib.nfs4_blockmove(C.byref(buffer,src),C.byref(buffer,dst),length)
                vals=(ARENA+src,ARENA+dst,length)
                _,fault,_=call('blockmove',vals)
                actual=g.read_memory(ARENA,len(initial))
                check('blockmove',vals,[sha(buffer.raw),0],[sha(actual),fault],initial)
        (out/'memory-fixture.bin').write_bytes(initial)

        write(ARENA,initial)
        buffer=C.create_string_buffer(initial,len(initial))
        for count in [0,1,2,3,4,5,8,-1,-2,-3,0x7FFFFFFF,-0x80000000]:
            for offset in range(4):
                vals=(ARENA+offset,count)
                for name in ('getm','geti'):
                    ret,fault,_=call(name,vals)
                    expected=getattr(lib,'nfs4_'+name)(C.byref(buffer,offset),count)
                    check(name,vals,[expected,0],[ret,fault],initial[:8])
        for count in sizes:
            vals=(ARENA,count);ret,fault,_=call('crc16',vals)
            check('crc16',vals,[lib.nfs4_crc16(buffer,count),0],[ret,fault],initial[:count])
        for format_byte in range(256):
            data=bytes([format_byte])+initial[1:16]
            write(ARENA,data);buffer16=C.create_string_buffer(data,16)
            ret,fault,_=call('shapedepth',(ARENA,))
            check('shapedepth',(format_byte,),[lib.nfs4_shapedepth(buffer16),0],[ret,fault],data)
        for angle in list(range(1024))+edges+[rng.getrandbits(32) for _ in range(args.random_cases)]:
            ret,fault,_=call('intsin',(angle,))
            check('intsin',(angle,),[lib.nfs4_intsin(angle),0],[ret,fault])
        for angle in list(range(0,1024,16))+edges+[rng.getrandbits(32) for _ in range(args.random_cases)]:
            ret,fault,_=call('intcos',(angle,))
            check('intcos',(angle,),[lib.nfs4_intcos(angle),0],[ret,fault])
        for count in (0,1,2,7,8):
            data=bytearray(initial)
            struct.pack_into('<I',data,8,count)
            for index in range(8):
                struct.pack_into('<II',data,16+8*index,rng.getrandbits(32),128+index*16)
            for index in list(range(9))+[MASK]:
                write(ARENA,data)
                buffer=C.create_string_buffer(bytes(data),len(data))
                ret,fault,_=call('shapecount',(ARENA,))
                check('shapecount',(count,),[lib.nfs4_shapecount(buffer),0],[ret,fault],data[:80])
                pointer=lib.nfs4_shapepointer(buffer,index)
                expected=0 if pointer is None else ARENA+pointer-C.addressof(buffer)
                ret,fault,_=call('shapepointer',(ARENA,index))
                check('shapepointer',(count,index),[expected,0],[ret,fault],data[:80])
                for alignment in range(4):
                    write(ARENA,data)
                    buffer=C.create_string_buffer(bytes(data),len(data))
                    destination=1024+alignment
                    lib.nfs4_shapename(buffer,index,C.byref(buffer,destination))
                    _,fault,_=call('shapename',(ARENA,index,ARENA+destination))
                    check('shapename',(count,index,alignment),[sha(buffer.raw),0],
                          [sha(g.read_memory(ARENA,len(data))),fault],data[:80])
        for _ in range(8):
            values=[rng.getrandbits(32) for _ in range(4)]
            ret,fault,_=call('setclipwindow',values)
            check('null_result',values,[lib.nfs4_null_result(),0],[ret,fault])
        for shift in [-0x80000000,-0x80000000+31,-0x80000000+32,-100,-1,0]+list(range(1,66))+[95,96,0x7FFFFFFF]:
            for bits in edges:
                data=bytes.fromhex('78563412efcdab90')
                write(ARENA,data)
                outputs=(C.c_uint32*2)(0x12345678,0x90ABCDEF)
                overflow=lib.nfs4_make64(outputs,s32(bits),shift)
                _,fault,_=call('make64',(ARENA,bits,shift))
                check('make64',(bits,shift),[list(outputs),overflow],
                      [list(struct.unpack('<2I',g.read_memory(ARENA,8))),int(bool(fault))],data)
        for seed in edges+[rng.getrandbits(32) for _ in range(args.random_cases)]:
            state=RandomState()
            lib.nfs4_seedrandom(C.byref(state),seed)
            _,fault,_=call('seedrandom',(seed,))
            actual=g.read_memory(SEED,24)
            check('seedrandom',(seed,),[bytes(state).hex(),0],[actual.hex(),fault])
            for i in range(4):
                expected=lib.nfs4_random(C.byref(state))
                ret,fault,_=call('random')
                actual=g.read_memory(SEED,24)
                check('random',(seed,i),[expected,bytes(state).hex(),0],[ret,actual.hex(),fault])
        # Force carry chains that ordinary seeding might never reach.
        for words in ([MASK]*6,[0]*6,[0,MASK,MASK,MASK,MASK,MASK],
                      [MASK,0,MASK,0,MASK,0]):
            state=RandomState((C.c_uint32*6)(*words))
            write(SEED,bytes(state))
            expected=lib.nfs4_random(C.byref(state));ret,fault,_=call('random')
            check('random',words,[expected,bytes(state).hex(),0],
                  [ret,g.read_memory(SEED,24).hex(),fault])
        for gp in edges:
            context=GPContext(0xDEADBEEF,gp)
            lib.nfs4_initgp(C.byref(context));_,fault,_=call('initgp',gp=gp)
            check('initgp',(gp,),[context.boot_gp,0],
                  [struct.unpack('<I',g.read_memory(BOOT_GP,4))[0],fault])
            context.current_gp=u32(gp^0xA5A5A5A5)
            saved=C.c_uint32()
            lib.nfs4_savegp(C.byref(context),C.byref(saved))
            _,fault,state=call('savegp',(ARENA,),gp=u32(gp^0xA5A5A5A5))
            check('savegp',(gp,),[saved.value,context.current_gp,0],
                  [struct.unpack('<I',g.read_memory(ARENA,4))[0],int(state['r28'],16),fault])
            lib.nfs4_restoregp(C.byref(context),saved.value)
            _,fault,state=call('restoregp',(saved.value,),gp=context.boot_gp)
            check('restoregp',(saved.value,),[context.current_gp,0],[int(state['r28'],16),fault])
        # Detect accidental writes outside all declared effects, across all tests.
        final_ram=bytearray(g.read_memory(0x80000000,0x200000))
        for address,length in ((ARENA,4096),(SEED,24),(BOOT_GP,4)):
            off=address&0x1FFFFF
            final_ram[off:off+length]=injected_ram[off:off+length]
        assert bytes(final_ram)==injected_ram, 'unexpected RAM side effect'
    finally:
        # Restore CPU/GPU/SPU/RAM, not just the injected code or registers.
        g.checkpoint(checkpoint,load=True)
        restored_ram=g.read_memory(0x80000000,0x200000)
        restored_scratch=g.read_memory(0x1F800000,1024)
        restored_regs=decode_registers(g.packet('g'))
        g.close()
        restored=restored_ram==before_ram and restored_scratch==before_scratch
        differences={k:[v,restored_regs.get(k)] for k,v in before_regs.items() if v!=restored_regs.get(k)}
        assert restored and not(set(differences)-{'cause'}), (restored,differences)
        if 'cause' in differences:
            assert (int(differences['cause'][0],16)^int(differences['cause'][1],16))&~0x400==0
        (out/'cases.json').write_text(json.dumps(tests,indent=2))
    report={'passed':True,'method':'native C vs live patched DuckStation; synthetic isolated retail calls',
            'cases':len(tests),'per_function':counts,'ram_and_scratch_restored':restored,
            'register_differences_after_restore':differences,
            'rom_sha256':sha(rom),'native_dll_sha256':sha(dll_path.read_bytes()),
            'native_source_sha256':{path:sha((PORTS/path).read_bytes()) for path in
                ('eaclib/eac_port.c','eaclib/shape_sine_port.c','include/nfs4_eac_port.h')},
            'compiler':subprocess.check_output(['gcc','--version'],text=True).splitlines()[0],
            'compile_command':command,'random_seed':0x4E465334,'random_cases':args.random_cases,
            'overflow_exceptions_checked':sum(t['function'] in ('make64','fixeddiv')
                and bool(t['retail'][-1]) for t in tests),
            'co_equal_entry_aliases':{'fixedmult':['rmult'],'fixeddiv':['rdiv'],
                'fixedinverse':['rinverse'],'intsin':['fastintsin'],'intcos':['fastintcos']},
            'emulator_sha256':sha(exe.read_bytes()),'gdb_client_sha256':sha((ROOT/'tools/duckstation/gdb_remote.py').read_bytes()),
            'toolset_methodology':'C:/Temp/PSX-Dynamic-Decomp/tools/audit_actor_math.py',
            'methodology_sha256':sha(Path('C:/Temp/PSX-Dynamic-Decomp/tools/audit_actor_math.py').read_bytes()),
            'checkpoint':checkpoint,'port':2350,
            'oracle_functions':{name:{'address':hex(address),'size':len(code),'sha256':sha(code)}
                                for name,(address,code) in windows.items()},
            'scope':'observed valid RAM inputs/returns/state and explicit arithmetic-overflow outcomes; not a proof over all inputs or gameplay'}
    (out/'report.json').write_text(json.dumps(report,indent=2))
    receipts=PORTS/'verification'
    receipts.mkdir(exist_ok=True)
    (receipts/(args.label+'.json')).write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({'passed':True,'cases':len(tests),'per_function':counts,'report':str(out/'report.json')}))

if __name__=='__main__': main()
