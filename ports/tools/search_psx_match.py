"""Bounded ordinary-C source-shape probes; exact compare after real linking.

Scratch compiler inputs stay in ports/build. Candidate text is never rewritten.
No assembly templates, opcode bodies, volatile dials or register pins are used.
Only an exact linked-byte result is a match; edit distance merely chooses the
next probe, and does not prove a remaining routine impossible to match.
"""
from pathlib import Path
import difflib
import hashlib
import json
import os
import re
import struct
import subprocess
import sys
from probe_byte_match import ROOT, PORTS, HEADERS, bld, functions

def run(command, log, stdin=None):
    temporary=PORTS/'build/compiler_tmp'
    temporary.mkdir(parents=True,exist_ok=True)
    env=dict(os.environ)
    env.update(TMPDIR=str(temporary),TMP=str(temporary),TEMP=str(temporary))
    result=subprocess.run([str(x) for x in command],input=stdin,capture_output=True,
                          text=True,cwd=ROOT,timeout=90,env=env)
    log.write_text(result.stdout+'\n'+result.stderr)
    if result.returncode:raise RuntimeError(str(log))

def compile_candidate(directory, key, source, retail, extra_flags=(), compiler_path=None, extern_addresses=None):
    work=directory/key;work.mkdir(parents=True,exist_ok=True)
    if isinstance(source,Path):path=source
    else:
        path=work/'candidate.c';path.write_text('#include <stdint.h>\n'+source+'\n')
    pre=work/'candidate.i';asm=work/'candidate.s';obj=work/'candidate.o'
    symbol='nfs4_match_'+retail
    run([bld.CPP,'-nostdinc','-undef','-D__GNUC__=2','-D__OPTIMIZE__','-I',directory/'include',
         '-P',path,'-o',pre],work/'cpp.log')
    compiler=Path(compiler_path) if compiler_path else bld.CC1
    run([compiler,*bld.CC1_FLAGS,*extra_flags,pre,'-o',asm],work/'cc1.log')
    run([sys.executable,bld.MASPSX,'--aspsx-version=2.77','--expand-div',
         '--run-assembler',f'--gnu-as-path={bld.AS}',*bld.AS_ARCH,'-G4','-o',obj],
         work/'as.log',asm.read_text())
    oracle=(ROOT/'asm/nonmatchings/main'/f'{retail}.s').read_text()
    rows=re.findall(r'/\*\s+[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s+([0-9A-Fa-f]{8})\s+\*/',oracle)
    address=int(rows[0][0],16)
    target=b''.join(bytes.fromhex(word) for _,word in rows)
    rom=(ROOT/'rom/nfs4-f.exe').read_bytes()
    load=struct.unpack_from('<I',rom,0x18)[0]
    offset=address-load+0x800
    assert rom[offset:offset+len(target)]==target, ('stale oracle',retail)
    script=work/'candidate.ld'
    bindings=''.join(f'{name} = 0x{va:x};\n' for name,va in (extern_addresses or {}).items())
    script.write_text(bindings+f'ENTRY({symbol})\nSECTIONS {{ . = 0x{address:x}; .text : {{ *(.text) }} .rodata : {{ *(.rodata*) *(.rdata*) }} .data : {{ *(.data*) }} .bss : {{ *(.bss*) }} }}\n')
    elf=work/'candidate.elf'
    run([bld.LD,'-T',script,'-o',elf,obj],work/'ld.log')
    symbols=subprocess.check_output([str(bld.MIPS/'mipsel-none-elf-nm.exe'),str(elf)],text=True)
    actual=re.search(r'^([0-9a-fA-F]+)\s+[Tt]\s+'+re.escape(symbol)+r'$',symbols,re.M)
    assert actual and int(actual[1],16)==address, ('wrong linked entry address',symbol)
    code=next(code for name,code,_ in functions(elf) if name==symbol)
    words=lambda data:[data[i:i+4] for i in range(0,len(data),4)]
    matcher=difflib.SequenceMatcher(None,words(code),words(target),autojunk=False)
    distance=sum(max(a1-a0,b1-b0) for tag,a0,a1,b0,b1 in matcher.get_opcodes() if tag!='equal')
    return {'probe':key,'retail':retail,'candidate_instructions':len(code)//4,
            'retail_instructions':len(target)//4,'word_edit_distance':distance,
            'exact_linked_bytes':code==target,'source':str(path),
            'extra_flags':list(extra_flags),
            'compiler':str(compiler),'compiler_sha256':hashlib.sha256(compiler.read_bytes()).hexdigest(),
            'retail_address':hex(address),'source_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
            'candidate_text_sha256':hashlib.sha256(code).hexdigest(),
            'retail_text_sha256':hashlib.sha256(target).hexdigest(),
            'elf_sha256':hashlib.sha256(elf.read_bytes()).hexdigest()}

def main():
    work=PORTS/'build/source_search';work.mkdir(parents=True,exist_ok=True)
    inc=work/'include';inc.mkdir(exist_ok=True)
    for name,text in HEADERS.items():(inc/name).write_text(text)
    counter_shapes={
        'for_up':('unsigned i;', 'for(i=0;i<32;i++){BODY}'),
        'for_down':('int i;', 'for(i=31;i>=0;i--){BODY}'),
        'do_post':('int i=31;', 'do{BODY}while(i--!=0);'),
        'do_pre':('int i=32;', 'do{BODY}while(--i!=0);'),
        'while_post':('int i=32;', 'while(i--){BODY}'),
        'while_top':('int i=32;', 'while(i!=0){i--;BODY}'),
        'while_exit':('int i=32;', 'for(;;){i--;BODY if(i==0)break;}'),
        'do_forced_minus1':('int i=32; i=i-1;', 'do{BODY}while(i--!=0);')
    }
    bodies={
        'combined':'q <<= 1; lo=(lo<<1)+(hi>>31); hi<<=1; if(lo>=den){lo-=den;q++;}',
        'split':'q <<= 1; lo <<= 1; lo += hi>>31; hi<<=1; if(lo>=den){lo-=den;q++;}',
        'top_temp':'uint32_t top; q <<=1; lo<<=1; top=hi>>31; lo+=top; hi<<=1; if(lo>=den){lo-=den;q++;}',
        'top_late':'uint32_t top; q <<=1; lo<<=1; top=hi>>31; lo+=top; if(lo>=den){lo-=den;q++;} hi<<=1;'
    }
    results=[]
    for shape,(decl,loop) in counter_shapes.items():
        for body_name,body in bodies.items():
            temp='uint32_t top;' if 'uint32_t top;' in body else ''
            body=body.replace('uint32_t top;','')
            source=f'uint32_t nfs4_match_divu64(uint32_t hi,uint32_t lo,uint32_t den){{ uint32_t q=0; {temp} {decl} {loop.replace("BODY",body)} return q; }}'
            results.append(compile_candidate(work,'divu64_'+shape+'_'+body_name,source,'divu64'))
    for order in ('low_high','high_low'):
        for bias_first in (False,True):
            for carry in ('constant','variable'):
                bias='uint32_t bias=0x8000U;'
                product='uint64_t product=(uint64_t)((int64_t)a*b);'
                lo='uint32_t low=(uint32_t)product;'
                hi='uint32_t high=(uint32_t)(product>>32);'
                decl=(bias+product if bias_first else product+bias)+(lo+hi if order=='low_high' else hi+lo)
                value='0x8000U' if carry=='constant' else 'bias'
                source=f'uint32_t nfs4_match_fixedmult(int32_t a,int32_t b){{{decl} low += bias; high += low < {value}; return (high<<16)|(low>>16);}}'
                key=f'fixedmult_{order}_{bias_first}_{carry}'
                results.append(compile_candidate(work,key,source,'fixedmult'))
    # Output-preserving ordinary-C absorption identities can change allocator
    # priority without a register pin or empty asm. Count only emitted bytes.
    identities=['q &= q|hi;','q |= q&hi;','q &= q|lo;',
                'q |= q&lo;','q ^= q^q;','q += hi-hi;']
    for style in ('for_down','do_post','while_top'):
        decl,loop=counter_shapes[style]
        for i,identity in enumerate(identities):
            for position in ('before','after'):
                body=bodies['split']
                body=identity+body if position=='before' else body+identity
                source=f'uint32_t nfs4_match_divu64(uint32_t hi,uint32_t lo,uint32_t den){{uint32_t q=0;{decl}{loop.replace("BODY",body)}return q;}}'
                results.append(compile_candidate(work,f'divu64_identity_{style}_{i}_{position}',source,'divu64'))
    products={
        'signed_shift_round':'''int64_t product=(int64_t)a*b;
          int64_t shifted=product>>15; return (uint32_t)((shifted+1)>>1);''',
        'shift_plus_low_bit':'''int64_t product=(int64_t)a*b;
          uint32_t result=(uint32_t)(product>>16);
          uint32_t round=((uint32_t)product>>15)&1U; return result+round;''',
        'union_words':'''union {int64_t product; struct {uint32_t low,high;} words;} value;
          uint32_t low,high,bias=0x8000U; value.product=(int64_t)a*b;
          low=value.words.low+bias; high=value.words.high+(low<bias);
          return (high<<16)|(low>>16);''',
        'signed_high':'''int64_t product=(int64_t)a*b; uint32_t low=(uint32_t)product;
          uint32_t high=(uint32_t)(int32_t)(product>>32); uint32_t bias=0x8000U;
          low+=bias; high+=(low<bias); return (low>>16)|(high<<16);'''
    }
    for name,body in products.items():
        source='uint32_t nfs4_match_fixedmult(int32_t a,int32_t b){'+body+'}'
        results.append(compile_candidate(work,'fixedmult_'+name,source,'fixedmult'))
    identities=['','low &= low|(uint32_t)a;','high &= high|(uint32_t)b;',
                'low &= low|((uint32_t)a^(uint32_t)b);',
                'low &= low|(uint32_t)a; high &= high|(uint32_t)b;']
    for register in (False,True):
        for order in ('low_first','high_first'):
            for idx,identity in enumerate(identities):
                qualifier='register ' if register else ''
                expr='(low>>16)|(high<<16)' if order=='low_first' else '(high<<16)|(low>>16)'
                source=f'''uint32_t nfs4_match_fixedmult(int32_t a,int32_t b){{
                  union {{int64_t product;struct {{uint32_t low,high;}} words;}} value;
                  {qualifier}uint32_t low,high,bias=0x8000U;
                  value.product=(int64_t)a*b; low=value.words.low+bias;
                  high=value.words.high+(low<bias); {identity} return {expr};}}'''
                for flag_idx,flags in enumerate(((),('-fno-schedule-insns',),
                                               ('-fno-schedule-insns2',),
                                               ('-fno-schedule-insns','-fno-schedule-insns2'))):
                    key=f'fixedmult_union_{register}_{order}_{idx}_{flag_idx}'
                    results.append(compile_candidate(work,key,source,'fixedmult',flags))
    source='uint32_t nfs4_match_shapecount(const uint32_t *file){return file[2];}'
    results.append(compile_candidate(work,'shapecount_native_load',source,'shapecount'))
    source='uint32_t nfs4_match_setclipwindow(void){return 0;}'
    results.append(compile_candidate(work,'null_body',source,'setclipwindow'))
    report={'ordinary_C_only':True,'compiler_sha256':hashlib.sha256(bld.CC1.read_bytes()).hexdigest(),
            'production_or_portable_sources_changed':False,'probes':results,
            'scope':'divu64 counter/body shapes, fixedmult carry shapes, known aligned shapecount/null bodies; not all 24 routines searched'}
    path=PORTS/'verification/source_search.json'
    path.write_text(json.dumps(report,indent=2)+'\n')
    for retail in sorted({r['retail'] for r in results}):
        group=[r for r in results if r['retail']==retail]
        best=min(group,key=lambda r:r['word_edit_distance'])
        print(json.dumps({'retail':retail,'probes':len(group),'best':best}))
    print(path)

if __name__=='__main__':main()
