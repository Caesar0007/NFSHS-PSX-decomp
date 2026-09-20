"""strip_gte_reg03.py -- libgte REG03.obj head: 13 GTE register setters retail's link removed (the object text starts at
SetDQA).  They are Sony GTE assembly (lwc2 / mtc2 / ctc2 + jr ra), relocation-free, so the source lines are generated
from the PsyQ 4.3 function blobs' disassembly."""
import json
import re
import subprocess

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
SDK = 'C:/Temp/nfs4-clean/psyq43/extracted/LIBGTE/functions/'
OD = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
REG = {'zero': 0, 'at': 1, 'v0': 2, 'v1': 3, 'a0': 4, 'a1': 5, 'a2': 6, 'a3': 7, 't0': 8, 't1': 9, 't2': 10, 't3': 11, 't4': 12,
       't5': 13, 't6': 14, 't7': 15, 's0': 16, 's1': 17, 's2': 18, 's3': 19, 's4': 20, 's5': 21, 's6': 22, 's7': 23, 't8': 24,
       't9': 25, 'k0': 26, 'k1': 27, 'gp': 28, 'sp': 29, 's8': 30, 'ra': 31}
FNS = ['SetVertex0', 'SetVertex1', 'SetVertex2', 'SetVertexTri', 'SetRGBfifo', 'SetIR123', 'SetIR0', 'SetSZfifo3', 'SetSZfifo4',
       'SetSXSYfifo', 'SetRii', 'SetMAC123', 'SetData32']


def lines(fn):
    blob = open(SDK + fn + '.bin', 'rb').read().rstrip(b'\0')
    while len(blob) % 4:
        blob += b'\0'
    tmp = R + 'build/tmp/gte.bin'
    open(tmp, 'wb').write(blob)
    out = subprocess.run([OD, '-D', '-b', 'binary', '-m', 'mips:3000', '-EL', '-M', 'no-aliases', tmp], capture_output=True, text=True).stdout
    res = []
    for ln in out.splitlines():
        m = re.match(r'\s*[0-9a-f]+:\s+[0-9a-f]{8}\s+(\S+)\s*(.*)', ln)
        if not m:
            continue
        op, args = m.group(1), m.group(2)
        args = re.sub(r'\b(' + '|'.join(REG) + r')\b', lambda k: '$%d' % REG[k.group(1)], args)
        if op == 'sll' and args.replace(' ', '') == '$0,$0,0x0':
            op, args = 'nop', ''
        res.append((op + ' ' + args).strip())
    # the blob may end before the delay-slot nop (stripped zero tail): a jr needs one
    if res and res[-1].startswith('jr '):
        res.append('nop')
    return res


h = R + 'recon/lib/gte_thunk.h'
t = open(h, encoding='utf-8').read()
if 'GTE_ASM_LINK_STRIPPED' not in t:
    a = '#else' + NL + '#define GTE_CTC_THUNK(name, creg, argtype)'
    assert t.count(a) == 1
    t = t.replace(a, '/* A GTE assembly routine retail\'s final link REMOVED as unreferenced (recon/link_stripped.h): the SDK\'s own' + NL +
                  ' * instruction sequence, emitted into the discarded `.text.strip` input section. */' + NL +
                  '#define GTE_ASM_LINK_STRIPPED(name, body)                                      \\' + NL +
                  '    __asm__("\\t.section .text.strip,\\"ax\\",@progbits\\n\\t.set noreorder\\n"      \\' + NL +
                  '            "\\t.globl " #name "\\n\\t.type " #name ",@function\\n" #name ":\\n"    \\' + NL +
                  '            body                                                               \\' + NL +
                  '            "\\t.size " #name ",.-" #name "\\n\\t.set reorder\\n\\t.set at\\n\\t.text\\n")' + NL + a)
    t = t.replace('    extern "C" void name(argtype v) { (void)v; } /* GTE absent on host */',
                  '    extern "C" void name(argtype v) { (void)v; } /* GTE absent on host */' + NL + '#define GTE_ASM_LINK_STRIPPED(name, body)')
    open(h, 'w', encoding='utf-8', newline='').write(t)
p = R + 'recon/syslib/psx/libgte/REG03.c'
s = open(p, encoding='utf-8').read()
a = 'GTE_CTC_THUNK(SetDQA, 27, short);'
assert s.count(a) == 1
blk = ('/* REG03.obj head (LINK-STRIPPED): thirteen GTE register setters nobody calls -- retail\'s object text starts at SetDQA.' + NL +
       ' * Sony GTE assembly; the instruction lines are the PsyQ 4.3 object\'s own. */' + NL)
for fn in FNS:
    body = ' '.join('"\\t%s\\n"' % l for l in lines(fn))
    blk += 'GTE_ASM_LINK_STRIPPED(%s, %s);' % (fn, body) + NL
s = s.replace(a, blk + a)
open(p, 'w', encoding='utf-8', newline='').write(s)
jf = json.load(open(R + 'linkers/link_stripped.json'))
for fn in FNS:
    jf['functions'].append({'object': 'build/recon/syslib/psx/libgte/REG03.c.o', 'function': fn, 'sdk': 'LIBGTE/' + fn,
                            'evidence': 'PsyQ 4.3 libgte REG03.obj head; the retail object text starts at SetDQA (strip_headtail.py)'})
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(jf, indent=1) + NL)
print('ok')
