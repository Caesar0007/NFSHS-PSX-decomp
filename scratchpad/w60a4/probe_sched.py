#!/usr/bin/env python3
"""W60-A4: dump-informed probes on the shared get_alarm() timeout printf.

Written with the Write tool (NOT a heredoc): the source carries a literal
backslash-n inside a C string, and bash heredocs collapse it.
"""
import re
import shutil
import subprocess
import sys

BASE = r'C:\Temp\nfs4-decomp\scratchpad\w60a4\drv.c.w60base'
TGT = r'C:\Temp\nfs4-decomp\recon\syslib\psx\libcd\drv.c'
BS = bytes([92])              # a single backslash, built numerically
NL = BS + b'n'                # the two source characters  \  n

shutil.copy(TGT, BASE)


def gate(tag, fn='CD_datasync'):
    r = subprocess.run([sys.executable, 'tools/verify_asm.py',
                        'recon/syslib/psx/libcd/drv.c', fn],
                       capture_output=True, text=True, cwd=r'C:\Temp\nfs4-decomp')
    m = re.search(r'(FAIL \d+ diffs \(ours \d+ / oracle \d+\)|PASS)', r.stdout)
    print("%-46s %s" % (tag, m.group(0) if m else r.stdout.strip()[:160]))


b0 = open(BASE, 'rb').read()
A = (b'        puts("CD timeout: ");\n'
     b'        printf("%s:(%s) Sync=%s, Ready=%s' + NL + b'", D_801489BC,\n'
     b'               CD_comstr[CD_com], CD_intstr[Intr.sync], CD_intstr[Intr.ready]);\n')
assert b0.count(A) == 1, b0.count(A)

V = [
    ('H: cmdName hoisted above puts',
     b'        {\n'
     b'        char *cmdName = CD_comstr[CD_com];\n'
     b'        puts("CD timeout: ");\n'
     b'        printf("%s:(%s) Sync=%s, Ready=%s' + NL + b'", D_801489BC,\n'
     b'               cmdName, CD_intstr[Intr.sync], CD_intstr[Intr.ready]);\n'
     b'        }\n'),
    ('I: CD_com INDEX hoisted above puts',
     b'        {\n'
     b'        int comIdx = CD_com;\n'
     b'        puts("CD timeout: ");\n'
     b'        printf("%s:(%s) Sync=%s, Ready=%s' + NL + b'", D_801489BC,\n'
     b'               CD_comstr[comIdx], CD_intstr[Intr.sync], CD_intstr[Intr.ready]);\n'
     b'        }\n'),
    ('J: cmdName local assigned after puts',
     b'        {\n'
     b'        char *cmdName;\n'
     b'        puts("CD timeout: ");\n'
     b'        cmdName = CD_comstr[CD_com];\n'
     b'        printf("%s:(%s) Sync=%s, Ready=%s' + NL + b'", D_801489BC,\n'
     b'               cmdName, CD_intstr[Intr.sync], CD_intstr[Intr.ready]);\n'
     b'        }\n'),
]
for tag, rep in V:
    open(TGT, 'wb').write(b0.replace(A, rep, 1))
    gate(tag)
shutil.copy(BASE, TGT)
print("restored")
