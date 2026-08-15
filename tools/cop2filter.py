#!/usr/bin/env python3
"""cop2filter.py -- COP2/GTE pre-filter for m2c input.

Rewrites the COP2 spellings m2c cannot parse into the mnemonics the local
m2c fork (C:/Temp/m2c-updated @16830ab+) understands:

  .word 0x4A......   (GTE op)          -> cop2  0x<imm25>
  .word 0x48......   (COP2 moves)      -> mfc2/cfc2/mtc2/ctc2 $gpr, $N
  .word 0xC8/0xE8... (lwc2/swc2)       -> lwc2/swc2 $N, imm($gpr)
  c2 0x...           (objdump form)    -> cop2 0x...

Everything else passes through byte-for-byte.  Splat/spimdisasm oracle .s
render every GTE op as `.word` (catalog 15E/w63-a20 law), so this filter is
the bridge:  cop2filter.py oracle.s | python m2c.py /dev/stdin ...
Usage: cop2filter.py [file] (stdin if omitted; output on stdout).

CAVEAT: apply to FUNCTION (.text) .s only -- a rodata .word can collide with
the COP2 encoding space by coincidence.
"""
import re
import sys

_GPR = [
    "zero", "at", "v0", "v1", "a0", "a1", "a2", "a3",
    "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7",
    "s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
    "t8", "t9", "k0", "k1", "gp", "sp", "fp", "ra",
]

WORD_RE = re.compile(r'^(?P<pre>\s*(?:/\*.*?\*/\s*)?)\.word\s+(?P<val>0x[0-9a-fA-F]{7,8})\b(?P<rest>.*)$')
C2_RE = re.compile(r'^(?P<pre>\s*(?:/\*.*?\*/\s*)?)c2(?P<sp>\s+)(?P<rest>.*)$')


def decode_cop2_word(val: int):
    op = val >> 26
    if op == 0x12:  # COP2 primary
        if val & 0x02000000:
            return "cop2    0x%X" % (val & 0x1FFFFFF)
        rs = (val >> 21) & 31
        rt = (val >> 16) & 31
        rd = (val >> 11) & 31
        mn = {0x00: "mfc2", 0x02: "cfc2", 0x04: "mtc2", 0x06: "ctc2"}.get(rs)
        if mn is None or (val & 0x7FF):
            return None
        return "%-7s $%s, $%d" % (mn, _GPR[rt], rd)
    if op in (0x32, 0x3A):  # lwc2 / swc2
        base = (val >> 21) & 31
        rt = (val >> 16) & 31
        imm = val & 0xFFFF
        if imm >= 0x8000:
            imm -= 0x10000
        mn = "lwc2" if op == 0x32 else "swc2"
        return "%-7s $%d, %#x($%s)" % (mn, rt, imm, _GPR[base]) if imm >= 0 \
            else "%-7s $%d, -%#x($%s)" % (mn, rt, -imm, _GPR[base])
    return None


def filter_line(line: str) -> str:
    m = C2_RE.match(line)
    if m:
        return "%scop2%s%s" % (m.group('pre'), m.group('sp'), m.group('rest'))
    m = WORD_RE.match(line)
    if m:
        dec = decode_cop2_word(int(m.group('val'), 16))
        if dec is not None:
            return m.group('pre') + dec + m.group('rest')
    return line


def main():
    src = open(sys.argv[1], encoding='utf-8', errors='replace') if len(sys.argv) > 1 else sys.stdin
    for line in src:
        sys.stdout.write(filter_line(line.rstrip('\n')) + '\n')


if __name__ == '__main__':
    main()
