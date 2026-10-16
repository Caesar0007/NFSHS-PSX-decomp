"""Defined-C reader probes on modern MIPS GCC, with ordinary optimizer flags.

No fixed-register flags, pins, assembly, or text changes. This is a separate
compiler basin, not a change to the production toolchain or portable sources.
"""
import hashlib
import json
import re
import struct
import subprocess
from search_psx_match import ROOT,PORTS,HEADERS,bld,functions,run

def main():
    work=PORTS/'build/modern_reader';work.mkdir(parents=True,exist_ok=True)
    inc=work/'include';inc.mkdir(exist_ok=True)
    for name,text in HEADERS.items():(inc/name).write_text(text)
    oracle=(ROOT/'asm/nonmatchings/main/geti.s').read_text()
    rows=re.findall(r'/\*\s+[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s+([0-9A-Fa-f]{8})\s+\*/',oracle)
    address=int(rows[0][0],16);target=b''.join(bytes.fromhex(w) for _,w in rows)
    rom=(ROOT/'rom/nfs4-f.exe').read_bytes();load=struct.unpack_from('<I',rom,0x18)[0]
    off=address-load+0x800;assert rom[off:off+len(target)]==target
    packed='typedef struct {uint32_t value;} __attribute__((packed)) Word;'
    sources={
      'local':packed+'''uint32_t nfs4_match_geti(const void *p,uint32_t count){
        uint32_t word=((const Word*)p)->value; uint32_t shift=(32u-count*8u)&31u;
        return (word<<shift)>>shift;}''',
      'mutate':packed+'''uint32_t nfs4_match_geti(const void *p,uint32_t count){
        uint32_t word=((const Word*)p)->value;count*=8u;count=32u-count;
        word<<=(count&31u);return word>>(count&31u);}''',
      'bytes':'''uint32_t nfs4_match_geti(const unsigned char *p,uint32_t count){
        uint32_t word=p[0]|((uint32_t)p[1]<<8)|((uint32_t)p[2]<<16)|((uint32_t)p[3]<<24);
        uint32_t shift=(32u-count*8u)&31u;return (word<<shift)>>shift;}'''
    }
    choices=[(),('-frename-registers',),('-fno-schedule-insns',),('-fno-schedule-insns2',),
      ('-fno-schedule-insns','-fno-schedule-insns2'),('-fno-tree-reassoc',),
      ('-fno-tree-forwprop',),('-fno-tree-reassoc','-fno-tree-forwprop'),
      ('-frename-registers','-fno-schedule-insns'),
      ('-frename-registers','-fno-schedule-insns2'),
      ('-frename-registers','-fno-tree-reassoc','-fno-tree-forwprop'),
      ('-O1',),('-O3',),('-Os',)]
    gcc=bld.MIPS/'mipsel-none-elf-gcc.exe'
    report=[]
    for name,source in sources.items():
        for index,flags in enumerate(choices):
            path=work/f'{name}_{index}';path.mkdir(exist_ok=True)
            c=path/'candidate.c';c.write_text('#include <stdint.h>\n'+source+'\n')
            obj=path/'candidate.o';elf=path/'candidate.elf';script=path/'candidate.ld'
            run([gcc,'-std=c11','-O2','-EL','-mips1','-mabi=32','-msoft-float',
                 '-fno-pic','-mno-abicalls','-ffreestanding','-nostdinc','-I',inc,
                 '-G4',*flags,'-c',c,'-o',obj],path/'gcc.log')
            script.write_text(f'ENTRY(nfs4_match_geti)\nSECTIONS {{ .text 0x{address:x} : {{ *(.text) }} }}\n')
            run([bld.LD,'-T',script,'-o',elf,obj],path/'ld.log')
            nm=subprocess.check_output([str(bld.MIPS/'mipsel-none-elf-nm.exe'),str(elf)],text=True)
            match=re.search(r'^([0-9a-fA-F]+)\s+T\s+nfs4_match_geti$',nm,re.M)
            assert match and int(match[1],16)==address
            code=next(code for symbol,code,_ in functions(elf) if symbol=='nfs4_match_geti')
            report.append({'probe':name+'_'+str(index),'flags':list(flags),'source':str(c),
               'candidate_instructions':len(code)//4,'retail_instructions':len(target)//4,
               'different_word_positions':sum(code[i:i+4]!=target[i:i+4] for i in range(0,min(len(code),len(target)),4)),
               'exact_linked_bytes':code==target,'source_sha256':hashlib.sha256(c.read_bytes()).hexdigest(),
               'candidate_text_sha256':hashlib.sha256(code).hexdigest(),
               'retail_text_sha256':hashlib.sha256(target).hexdigest()})
    result={'compiler':subprocess.check_output([str(gcc),'--version'],text=True).splitlines()[0],
            'compiler_sha256':hashlib.sha256(gcc.read_bytes()).hexdigest(),
            'scope':'geti defined masked-shift/LE reader forms; no physical-register constraints',
            'probes':report}
    out=PORTS/'verification/modern_reader_search.json';out.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'probes':len(report),'exact':[r for r in report if r['exact_linked_bytes']],
                     'best':min(report,key=lambda r:r['different_word_positions']+abs(r['candidate_instructions']-8))}))
    print(out)

if __name__=='__main__':main()
