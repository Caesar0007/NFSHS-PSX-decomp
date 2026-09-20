"""strip_api_asm.py -- libapi CHCLRPAD.obj (_remove_ChgclrPAD) and PATCH.obj (EnablePAD, DisablePAD, _patch_pad): Sony HAND
ASSEMBLY (addi, $ra parked in the member's own .bss, BIOS B0:0x57 table patching).  Retail linked both members (SYM FILE
records, tail of the link order: libapi PAD.obj references them) and its final link removed every function in them.
Lines generated from the PsyQ 4.3 objects by strip_asm_gen.py."""
import json
import sys

sys.path.insert(0, 'C:/Temp/nfs4-decomp/scratchpad/psyq_pipe')
import strip_asm_gen as G

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


class Map(dict):
    def __missing__(self, k):
        assert '(' not in k, k
        return k


h = R + 'recon/link_stripped.h'
t = open(h, encoding='utf-8').read()
if 'ASM_LINK_STRIPPED' not in t:
    a = '#endif'
    i = t.rindex(a)
    t = (t[:i] + '/* A Sony HAND-ASSEMBLY routine the final link removed: the SDK object\'s own instruction lines, in `.text.strip`. */' + NL +
         '#define ASM_LINK_STRIPPED(name, body)                                          \\' + NL +
         '    __asm__("\\t.section .text.strip,\\"ax\\",@progbits\\n\\t.set noreorder\\n\\t.set noat\\n"  \\' + NL +
         '            "\\t.globl " #name "\\n\\t.type " #name ",@function\\n" #name ":\\n"    \\' + NL +
         '            body                                                               \\' + NL +
         '            "\\t.size " #name ",.-" #name "\\n\\t.set reorder\\n\\t.set at\\n\\t.text\\n")' + NL + t[i:])
    open(h, 'w', encoding='utf-8', newline='').write(t)


def macro(fn, lines):
    return 'ASM_LINK_STRIPPED(%s,\n%s);\n' % (fn, '\n'.join('    "%s\\n"' % l.replace('\t', '\\t') for l in lines))


jf = json.load(open(R + 'linkers/link_stripped.json'))
HEAD = ('/* syslib/psx/libapi/%s.c -- RECONSTRUCTED.  obj libapi.lib(%s.OBJ): %s.' + NL +
        ' *   Sony hand assembly.  Retail LINKED this member (SYM FILE record at the tail of the link order: libapi PAD.obj' + NL +
        ' *   references it) and its final link then REMOVED every function in it -- PAD.obj\'s callers were unreferenced.  The' + NL +
        ' *   member\'s .bss is not removed by that stripping; its retail address is unknown (no label), so it is left to the' + NL +
        ' *   linker.  Lines generated from the PsyQ 4.3 object (scratchpad/psyq_pipe/strip_asm_gen.py). */' + NL +
        '#include "../../../link_stripped.h"' + NL + NL)
c = G.gen('LIBAPI', 'CHCLRPAD', '_remove_ChgclrPAD', None, Map({'SECT(.bss)': '_chgclrpad_ra'}))
open(R + 'recon/syslib/psx/libapi/CHCLRPAD.c', 'w', encoding='utf-8', newline='').write(
    HEAD % ('CHCLRPAD', 'CHCLRPAD', '_remove_ChgclrPAD -- zero the BIOS ChangeClearPAD patch slots (B0:0x57 table)') +
    'long _chgclrpad_ra;   /* CHCLRPAD.obj .bss +0 : $ra parked across the BIOS calls */' + NL + NL + macro('_remove_ChgclrPAD', c))
jf['functions'].append({'object': 'build/recon/syslib/psx/libapi/CHCLRPAD.c.o', 'function': '_remove_ChgclrPAD', 'sdk': 'LIBAPI/_remove_ChgclrPAD',
                        'evidence': 'libapi.lib(CHCLRPAD.obj) is in the retail SYM FILE list; no byte of it is in the image (text ends with ssine.obj)'})
pm = Map({'SECT(.bss)': '_patchpad_bss', 'SECT(.bss)+0x8': '_patchpad_bss+8', 'SECT(.bss)+0xc': '_patchpad_bss+12'})
body = ''
for fn, nxt in (('EnablePAD', 'DisablePAD'), ('DisablePAD', '_patch_pad'), ('_patch_pad', None)):
    body += macro(fn, G.gen('LIBAPI', 'PATCH', fn, nxt, pm))
    jf['functions'].append({'object': 'build/recon/syslib/psx/libapi/PATCH.c.o', 'function': fn, 'sdk': 'LIBAPI/' + fn,
                            'evidence': 'libapi.lib(PATCH.obj) is in the retail SYM FILE list; no byte of it is in the image'})
open(R + 'recon/syslib/psx/libapi/PATCH.c', 'w', encoding='utf-8', newline='').write(
    HEAD % ('PATCH', 'PATCH', 'EnablePAD / DisablePAD (tail-jump through the two saved BIOS entry points) and _patch_pad (find them)') +
    'long _patchpad_bss[4];   /* PATCH.obj .bss: +0 $ra, +8 / +12 the two BIOS pad entry points */' + NL + NL + body)
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(jf, indent=1) + NL)
print('ok')
