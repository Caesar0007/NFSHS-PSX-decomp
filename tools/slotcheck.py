"""W75-A17: scan an object's disassembly for an ILLEGAL branch/jump in a delay slot.

A zero-insn `__asm__` can be picked by reorg as a delay-slot filler; it emits
nothing, so the NEXT real instruction silently lands in the slot.  If that
instruction is itself a branch/jump the object is broken (R3000: a branch in a
branch delay slot is undefined) and every gate in the tree is blind to it.

usage: a17_slotcheck.py <obj> [fn]
"""
import re, subprocess, sys
from pathlib import Path

OBJD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
BR = re.compile(r"\b(j|jal|jr|jalr|b|beq|bne|beqz|bnez|blez|bgtz|bltz|bgez|"
                r"bgezal|bltzal|bal)\b")

obj = sys.argv[1]
want = sys.argv[2] if len(sys.argv) > 2 else None
dis = subprocess.run([OBJD, "-d", "-z", obj], capture_output=True, text=True).stdout
cur = None
prev = None
bad = 0
for ln in dis.splitlines():
    m = re.match(r"^[0-9a-f]+ <(.+)>:", ln)
    if m:
        cur = m.group(1)
        prev = None
        continue
    m = re.match(r"^\s*([0-9a-f]+):\s+[0-9a-f]{8}\s+(\S+)", ln)
    if not m:
        continue
    mn = m.group(2)
    if prev and BR.match(prev[1]) and BR.match(mn):
        if want is None or cur == want:
            print("ILLEGAL slot: %s  %s: %s  <-  in the delay slot of %s"
                  % (cur, m.group(1), mn, prev[1]))
            bad += 1
    prev = (m.group(1), mn)
print("bad =", bad)
sys.exit(1 if bad else 0)
