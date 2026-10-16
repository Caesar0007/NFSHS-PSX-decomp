"""Read-only source diagnostic: compile portable bodies for MIPS and inspect text.

Uses original PsyQ 4.3 CC1PSX+maspsx and a modern MIPS compiler. No production
source/tooling edits, opcode rewrites, or register pins. Raw text identity is
decisive only without unresolved relocations; linked addresses are not guessed.
Failure in these basins is NOT a proof that another ordinary C shape cannot match.
"""
from pathlib import Path
import argparse
import hashlib
import importlib.util
import json
import re
import struct
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[2]
PORTS=ROOT/'ports'
sys.path.insert(0,str(ROOT/'tools'))
spec=importlib.util.spec_from_file_location('nfs4_build',ROOT/'tools/build.py')
bld=importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)

HEADERS={
 'stdint.h':'''#ifndef PORT_PROBE_STDINT
#define PORT_PROBE_STDINT
typedef unsigned char uint8_t;
typedef unsigned int uint32_t;
typedef int int32_t;
typedef unsigned long long uint64_t;
typedef long long int64_t;
#define UINT32_MAX 0xffffffffU
#define INT32_MIN (-2147483647 - 1)
#define UINT32_C(x) x##U
#define INT64_C(x) x##LL
#endif
''',
 'stddef.h':'''#ifndef PORT_PROBE_STDDEF
#define PORT_PROBE_STDDEF
typedef unsigned int size_t;
#define NULL ((void *)0)
#endif
''',
 'limits.h':'#include <stdint.h>\n',
 'string.h':'''#include <stddef.h>
extern void *memset(void *, int, size_t);
extern void *memmove(void *, const void *, size_t);
'''
}
NAMES={'blockfill':'blockfill','blockclear':'blockclear','blockmove':'blockmove',
 'fixedmult':'fixedmult','fixeddiv':'rdiv','fixedinverse':'fixedinverse',
 'fixedsqrt':'fixedsqrt','random':'random','seedrandom':'seedrandom','crc16':'crc16',
 'getm':'getm','geti':'geti','make64':'make64','divu64':'divu64',
 'shapedepth':'shapedepth','shapecount':'shapecount','shapepointer':'shapepointer',
 'shapename':'shapename','intsin':'intsin','intcos':'intcos','null_result':'setclipwindow',
 'initgp':'initgp','savegp':'savegp','restoregp':'restoregp'}
ABI_CHANGED={'fixeddiv':'portable result structure/overflow flag vs raw v0 return/trap',
 'make64':'portable overflow-status return vs retail void/trapping operation',
 'random':'explicit state pointer replaces PSX global seed',
 'seedrandom':'state pointer plus seed replaces PSX one-argument seed routine',
 'initgp':'explicit context pointer replaces CPU gp access',
 'savegp':'explicit context pointer replaces CPU gp access',
 'restoregp':'explicit context pointer replaces CPU gp access'}

def functions(path):
    data=path.read_bytes()
    assert data[:6]==b'\x7fELF\x01\x01'
    shoff=struct.unpack_from('<I',data,32)[0]
    entsize,number=struct.unpack_from('<HH',data,46)
    sections=[struct.unpack_from('<10I',data,shoff+i*entsize) for i in range(number)]
    records=[]
    for section in sections:
        if section[1]!=2:continue
        strings=sections[section[6]]
        names=data[strings[4]:strings[4]+strings[5]]
        for off in range(section[4],section[4]+section[5],section[9]):
            name,start,size,info,other,index=struct.unpack_from('<IIIBBH',data,off)
            if (info&15)!=2 or index==0 or not size:continue
            symbol=names[name:names.find(b'\0',name)].decode()
            section_start=start-sections[index][3] if struct.unpack_from('<H',data,16)[0]==2 else start
            code=data[sections[index][4]+section_start:sections[index][4]+section_start+size]
            relocations=[]
            for rel in sections:
                if rel[1] not in (9,4) or rel[7]!=index:continue
                for r in range(rel[4],rel[4]+rel[5],rel[9]):
                    at,kind=struct.unpack_from('<II',data,r)
                    if start<=at<start+size:relocations.append({'offset':at-start,'type':kind&255})
            records.append((symbol,code,relocations))
    return records

def main():
    out=PORTS/'build/byte_probe'
    out.mkdir(parents=True,exist_ok=True)
    includes=out/'include';includes.mkdir(exist_ok=True)
    for name,text in HEADERS.items():(includes/name).write_text(text)
    proof=out/'shapecount_psx.c'
    proof.write_text('unsigned port_shapecount_psx(const unsigned *file) { return file[2]; }\n')
    # The proof has PSX-aligned/native-LE word-load assumptions. It is NOT a
    # replacement for the byte-endian-independent portable implementation.
    sources=[PORTS/'eaclib/eac_port.c',PORTS/'eaclib/shape_sine_port.c',proof]
    rows=[];compilations=[]
    def run(command,log,input=None):
        result=subprocess.run([str(x) for x in command],input=input,capture_output=True,
                              text=True,cwd=ROOT,timeout=90)
        log.write_text(result.stdout+'\n'+result.stderr)
        if result.returncode:raise RuntimeError(f'compile failed: {log}')
        return result
    oracle={}
    rom=(ROOT/'rom/nfs4-f.exe').read_bytes()
    assert rom[:8]==b'PS-X EXE'
    rom_base=struct.unpack_from('<I',rom,0x18)[0]
    for name,retail in NAMES.items():
        text=(ROOT/'asm/nonmatchings/main'/f'{retail}.s').read_text()
        entries=re.findall(r'/\*\s+[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s+([0-9A-Fa-f]{8})\s+\*/',text)
        oracle[name]=b''.join(bytes.fromhex(word) for _,word in entries)
        address=int(entries[0][0],16)
        offset=address-rom_base+0x800
        assert rom[offset:offset+len(oracle[name])]==oracle[name], ('retail/oracle mismatch',name)
    for lane in ('psyq43','gcc14'):
        for source in sources:
            obj=out/(source.stem+'.'+lane+'.o')
            if lane=='psyq43':
                pre=out/(source.stem+'.i');asm=out/(source.stem+'.s')
                run([bld.CPP,'-nostdinc','-undef','-D__GNUC__=2','-D__OPTIMIZE__',
                     '-I',includes,'-P',source,'-o',pre],out/(source.stem+'.cpp.log'))
                run([bld.CC1,*bld.CC1_FLAGS,pre,'-o',asm],out/(source.stem+'.cc1.log'))
                run([sys.executable,bld.MASPSX,'--aspsx-version=2.77','--expand-div',
                     '--run-assembler',f'--gnu-as-path={bld.AS}',*bld.AS_ARCH,'-G4',
                     '-o',obj],out/(source.stem+'.as.log'),asm.read_text())
            else:
                run([bld.MIPS/'mipsel-none-elf-gcc.exe','-std=c11','-O2','-EL','-mips1',
                     '-mabi=32','-msoft-float','-fno-pic','-mno-abicalls','-ffreestanding',
                     '-nostdinc','-I',includes,'-G4','-c',source,'-o',obj],
                     out/(source.stem+'.modern.log'))
            compilations.append({'lane':lane,'object':str(obj),'sha256':hashlib.sha256(obj.read_bytes()).hexdigest()})
            for symbol,code,relocs in functions(obj):
                if symbol=='port_shapecount_psx':key='shapecount'
                elif symbol.startswith('nfs4_'):key=symbol[5:]
                else:continue
                target=oracle[key]
                rows.append({'lane':lane,'function':key,'symbol':symbol,
                    'portable_or_psx_probe':'psx-aligned-read proof' if symbol=='port_shapecount_psx' else 'unchanged portable body',
                    'candidate_instructions':len(code)//4,'retail_instructions':len(target)//4,
                    'byte_exact_without_relocations':not relocs and code==target,
                    'unresolved_relocations':relocs,
                    'different_word_positions':sum(code[i:i+4]!=target[i:i+4] for i in range(0,min(len(code),len(target)),4)),
                    'abi_note':ABI_CHANGED.get(key,'same observable argument/return ABI on MIPS32'),
                    'entry_note':'fall-through entry into the following ASM body' if key in ('blockclear','intcos') else None,
                    'candidate_text_sha256':hashlib.sha256(code).hexdigest(),
                    'retail_text_sha256':hashlib.sha256(target).hexdigest()})
    for lane in ('psyq43','gcc14'):
        actual=[r for r in rows if r['lane']==lane and r['portable_or_psx_probe']=='unchanged portable body']
        assert len(actual)==24,(lane,len(actual))
    report={'method':'unmodified portable C bodies compiled for MIPS32, plus isolated ordinary-C aligned-read proof',
            'limitations':'Unlinked relocations are disclosed, not called byte PASS. Two compiler basins are not a proof of impossibility or a completed matching campaign.',
            'production_sources_edited':False,'compilations':compilations,'functions':rows,
            'rom_sha256':hashlib.sha256(rom).hexdigest(),
            'psyq_cc1_sha256':hashlib.sha256(bld.CC1.read_bytes()).hexdigest(),
            'psyq_cc1_flags':bld.CC1_FLAGS,
            'portable_source_sha256':{str(p.relative_to(PORTS)):hashlib.sha256(p.read_bytes()).hexdigest()
                                     for p in sources[:2]+[PORTS/'include/nfs4_eac_port.h']}}
    target=PORTS/'verification/byte_probe.json'
    target.write_text(json.dumps(report,indent=2)+'\n')
    for lane in ('psyq43','gcc14'):
        actual=[r for r in rows if r['lane']==lane and r['portable_or_psx_probe']=='unchanged portable body']
        exact=[r['function'] for r in actual if r['byte_exact_without_relocations']]
        print(lane+': byte-identical unchanged portable bodies '+str(exact))
    proofs=[(r['lane'],r['byte_exact_without_relocations']) for r in rows if r['symbol']=='port_shapecount_psx']
    print('PSX-aligned ordinary-C shapecount proof: '+str(proofs))
    print(target)

if __name__=='__main__':main()
