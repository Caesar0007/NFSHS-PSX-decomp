"""gprefs.py VA [VA ...] -- retail code that addresses VA gp-relatively ($gp = 0x8013C54C) or through a
lui/addiu|load|store pair in the same function: prints accessing PC, function and reconstructed object.
Static counterpart of the runtime watchpoint trace, for cells the game never touches during a trace."""
import bisect
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:]
LOAD, GP = 0x80010000, 0x8013C54C
fn = []
for ln in open(ROOT / 'configs/symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func', ln)
    if m:
        fn.append((int(m.group(2), 16), m.group(1)))
fn.sort()
fk = [v for v, _ in fn]
spine = sorted((int(m.group(1), 16), m.group(2)) for m in re.finditer(
    r'(0x[0-9a-f]+) : SUBALIGN\(4\) \{ build/recon/(\S+?)\(\.text\)', (ROOT / 'linkers/nfs4_recon.ld').read_text(errors='replace')))
sk = [v for v, _ in spine]
TEXT_END = 0x8010CCD4


def where(pc):
    i = bisect.bisect_right(fk, pc) - 1
    j = bisect.bisect_right(sk, pc) - 1
    return (fn[i][1] if i >= 0 else '?'), (spine[j][1] if j >= 0 else '?')


targets = [int(a, 16) for a in sys.argv[1:]]
MEM = {0x20, 0x21, 0x23, 0x24, 0x25, 0x28, 0x29, 0x2b, 0x09}
for t in targets:
    print(f'== {t:#010x}')
    seen = set()
    hi_needed = ((t + 0x8000) >> 16) & 0xffff
    lui_at = {}
    for off in range(0, TEXT_END - LOAD, 4):
        w = struct.unpack_from('<I', rom, off)[0]
        op, rs, rt, imm = w >> 26, (w >> 21) & 31, (w >> 16) & 31, w & 0xffff
        simm = imm - 0x10000 if imm & 0x8000 else imm
        pc = LOAD + off
        if op == 0x0f:
            lui_at[rt] = (imm, pc)
            continue
        if op in MEM:
            hit = False
            if rs == 28 and GP + simm == t:
                hit = True
            elif rs in lui_at and lui_at[rs][0] == hi_needed and pc - lui_at[rs][1] < 64 and ((lui_at[rs][0] << 16) + simm) & 0xffffffff == t:
                hit = True
            if hit:
                f, o = where(pc)
                key = (f, o)
                if key not in seen:
                    seen.add(key)
                    print(f'   {pc:#010x} {"gp" if rs == 28 else "abs"}  {o:40s} {f}')
    if not seen:
        print('   (no direct reference found)')
