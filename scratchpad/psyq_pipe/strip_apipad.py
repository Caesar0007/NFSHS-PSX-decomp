"""strip_apipad.py -- the rest of libapi PAD.obj (all link-stripped): PAD_init @28, InitPAD @172, StopPAD @364 and the four
STATIC functions the SDK index lumps into StopPAD's blob (gate `sdk_slice`): install @+56 (120 B), remove @+176 (56 B),
ack handler @+232 (104 B), verifier @+336 (64 B).  PAD.obj also owns 16 .bss bytes: the SysEnqIntRP chain node."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'recon/syslib/psx/libapi/PAD.c'
s = open(p, encoding='utf-8').read()
old_todo = ('Written so far: SetInitPadFlag, StartPAD.  TODO (LINK-STRIPPED, not yet written): PAD_init' + NL +
            ' * @28+144, InitPAD @172+144, StopPAD @364+56 and the static helper @420+348. */')
assert s.count(old_todo) == 1
s = s.replace(old_todo, 'All of them are written below in SDK order. */')
a = 'extern void SetInitPadFlag(int flag) LINK_STRIPPED;'
assert s.count(a) == 1
s = s.replace(a, a + NL +
              'extern int  PAD_init(unsigned long a, unsigned long *b, unsigned long c, unsigned long d) LINK_STRIPPED;' + NL +
              'extern int  InitPAD(char *b1, long l1, char *b2, long l2) LINK_STRIPPED;' + NL + 'extern void StopPAD(void) LINK_STRIPPED;' + NL +
              'static int  _pad_install_intr(void) LINK_STRIPPED;' + NL + 'static int  _pad_remove_intr(void) LINK_STRIPPED;' + NL +
              'static int  _pad_intr_ack(void) LINK_STRIPPED;' + NL + 'static int  _pad_intr_verify(void) LINK_STRIPPED;' + NL +
              'extern void _remove_ChgclrPAD(void);' + NL + 'extern void _patch_pad(void);' + NL + 'extern void EnterCriticalSection(void);' + NL +
              'extern void ExitCriticalSection(void);' + NL + 'extern void DisablePAD(void);' + NL + 'extern void StopPAD2(void);' + NL +
              'extern int  PAD_init2(unsigned long a, unsigned long *b, unsigned long c, unsigned long d);' + NL +
              'extern int  InitPAD2(char *b1, long l1, char *b2, long l2);' + NL + 'extern int  SysEnqIntRP(int prio, void *node);' + NL +
              'extern int  SysDeqIntRP(int prio, void *node);' + NL + NL +
              '/* PAD.obj .bss (16 B): the interrupt chain node {next, handler, verifier, pad} */' + NL +
              'static struct { void *next; int (*handler)(void); int (*verifier)(void); int pad; } _pad_node;' + NL)
m = '/* PAD.obj +316 (LINK-STRIPPED) : StartPAD */'
assert s.count(m) == 1


def init(name, inner, sig, args):
    return ('extern int %s(%s)' % (name, sig) + NL + '{' + NL + '    _remove_ChgclrPAD();' + NL + '    EnterCriticalSection();' + NL +
            '    _patch_pad();' + NL + '    ExitCriticalSection();' + NL + '    ChangeClearPAD(0);' + NL + '    _pad_install_intr();' + NL +
            '    %s(%s);' % (inner, args) + NL + '    _init_pad_flag = 1;' + NL + '    return 1;' + NL + '}' + NL + NL)


s = s.replace(m, '/* PAD.obj +28 (LINK-STRIPPED) : PAD_init */' + NL +
              init('PAD_init', 'PAD_init2', 'unsigned long a, unsigned long *b, unsigned long c, unsigned long d', 'a, b, c, d') +
              '/* PAD.obj +172 (LINK-STRIPPED) : InitPAD */' + NL + init('InitPAD', 'InitPAD2', 'char *b1, long l1, char *b2, long l2', 'b1, l1, b2, l2') + m)
s = s.rstrip() + NL + NL + (
    '/* PAD.obj +364 (LINK-STRIPPED) : StopPAD */' + NL + 'extern void StopPAD(void)' + NL + '{' + NL + '    DisablePAD();' + NL + '    StopPAD2();' + NL +
    '    _pad_remove_intr();' + NL + '    _init_pad_flag = 0;' + NL + '}' + NL + NL +
    '/* PAD.obj +420 (LINK-STRIPPED, static) : hook the pad interrupt handler into the BIOS chain */' + NL +
    'static int _pad_install_intr(void)' + NL + '{' + NL + '    EnterCriticalSection();' + NL + '    _pad_node.handler = _pad_intr_ack;' + NL +
    '    _pad_node.verifier = _pad_intr_verify;' + NL + '    _pad_node.next = 0;' + NL + '    _pad_node.pad = 0;' + NL +
    '    SysDeqIntRP(1, &_pad_node);' + NL + '    SysEnqIntRP(1, &_pad_node);' + NL + '    ExitCriticalSection();' + NL + '    return 1;' + NL + '}' + NL + NL +
    '/* PAD.obj +540 (LINK-STRIPPED, static) */' + NL + 'static int _pad_remove_intr(void)' + NL + '{' + NL + '    EnterCriticalSection();' + NL +
    '    SysDeqIntRP(1, &_pad_node);' + NL + '    ExitCriticalSection();' + NL + '    return 1;' + NL + '}' + NL + NL +
    '/* PAD.obj +596 (LINK-STRIPPED, static) : acknowledge -- clear JOY_CTRL, then a short volatile countdown */' + NL +
    'static int _pad_intr_ack(void)' + NL + '{' + NL + '    volatile int i;' + NL + NL + '    *(unsigned short *)(_pad_joy_data + 10) = 0;' + NL +
    '    i = 10;' + NL + '    while (--i != -1)' + NL + '        ;' + NL + '    return 0;' + NL + '}' + NL + NL +
    '/* PAD.obj +700 (LINK-STRIPPED, static) : is this our interrupt?  (I_MASK bit 0 and I_STAT bit 0) */' + NL +
    'static int _pad_intr_verify(void)' + NL + '{' + NL + '    if ((_pad_i_stat[1] & 1) && (_pad_i_stat[0] & 1))' + NL + '        return 1;' + NL +
    '    return 0;' + NL + '}' + NL)
open(p, 'w', encoding='utf-8', newline='').write(s)
jf = json.load(open(R + 'linkers/link_stripped.json'))
O = 'build/recon/syslib/psx/libapi/PAD.c.o'
EV = 'libapi PAD.obj (identical member layout in PsyQ 3.6..4.5): retail keeps its 16 data bytes but only ReadInitPadFlag of its 768 text bytes'
for fn, sdk, sl in (('PAD_init', 'LIBAPI/PAD_init', None), ('InitPAD', 'LIBAPI/InitPAD', None), ('StopPAD', 'LIBAPI/StopPAD', [0, 56]),
                    ('_pad_install_intr', 'LIBAPI/StopPAD', [56, 120]), ('_pad_remove_intr', 'LIBAPI/StopPAD', [176, 56]),
                    ('_pad_intr_ack', 'LIBAPI/StopPAD', [232, 104]), ('_pad_intr_verify', 'LIBAPI/StopPAD', [336, 64])):
    e = {'object': O, 'function': fn, 'sdk': sdk, 'evidence': EV}
    if sl:
        e['sdk_slice'] = sl
    jf['functions'].append(e)
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(jf, indent=1) + NL)
print('ok')
