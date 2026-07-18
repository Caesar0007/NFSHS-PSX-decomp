#!/usr/bin/env python3
"""bareva_sweep.py — disguised-bare-VA sweep (worker w14-a2, task part 2).

Two evasion classes hunted (comments stripped first):
  (a) NEGATIVE literal (hex or decimal) whose 32-bit two's-complement value decodes to a
      program VA (top byte 0x80, i.e. the 0x80000000-0x80200000 PSX RAM window). e.g.
      `-0x7feee918` == 0x801116e8. May appear standalone (`x = -0x7fe...;`) or added to a
      base (`X + -0x7fe...`).
  (b) "masked-address" POSITIVE literal (VA - 0x80000000, i.e. a raw RAM offset in
      [0x10000, 0x200000)) used ADJACENT to a `+` with another operand -- a computed-base
      address in disguise (e.g. `base + 0x13e414`).

Usage: python tools/bareva_sweep.py > scratch/bareva_hits.txt
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
RECON = ROOT / 'recon'

VA_LO, VA_HI = 0x80000000, 0x80200000   # NFS4 RAM window (image 0x80010000..~0x80149000 + BSS headroom)
OFF_LO, OFF_HI = 0x10000, 0x200000      # matching masked-address (VA - 0x80000000) window

def strip_comments(text):
    """Blank out comment CONTENT (replace with spaces) but preserve every newline and the
    overall character count, so line numbers stay 1:1 with the original text -- unlike a
    naive re.sub(..., '') which collapses a multi-line /* */ into zero lines and desyncs
    every line number after it."""
    def _blank(m):
        return ''.join(c if c == '\n' else ' ' for c in m.group(0))
    text = re.sub(r'/\*.*?\*/', _blank, text, flags=re.S)
    text = re.sub(r'//[^\n]*', _blank, text)
    return text

HEX_LIT = re.compile(r'(-)?\b0[xX]([0-9a-fA-F]+)\b')
DEC_LIT = re.compile(r'(-)?\b(\d{6,10})\b')

files = sorted(list(RECON.glob('**/*.cpp')) + list(RECON.glob('**/*.c')) + list(RECON.glob('**/*.h')))

hits_a = []  # (file, lineno, literal_text, decoded_va, line)
hits_b = []  # (file, lineno, literal_text, decoded_off_as_va, line)

for f in files:
    raw = f.read_text(encoding='utf-8', errors='replace')
    stripped = strip_comments(raw)
    lines_raw = raw.splitlines()
    lines_stripped = stripped.splitlines()
    n = min(len(lines_raw), len(lines_stripped))
    for i in range(n):
        sline = lines_stripped[i]
        rline = lines_raw[i]
        # class (a): negative hex/decimal literal decoding to a VA
        for m in HEX_LIT.finditer(sline):
            neg, digits = m.group(1), m.group(2)
            if not neg:
                continue
            val = int(digits, 16)
            v32 = (-val) & 0xFFFFFFFF
            if VA_LO <= v32 < VA_HI:
                hits_a.append((str(f.relative_to(ROOT)), i + 1, m.group(0), v32, rline.strip()))
        for m in DEC_LIT.finditer(sline):
            neg, digits = m.group(1), m.group(2)
            if not neg:
                continue
            val = int(digits, 10)
            v32 = (-val) & 0xFFFFFFFF
            if VA_LO <= v32 < VA_HI:
                hits_a.append((str(f.relative_to(ROOT)), i + 1, m.group(0), v32, rline.strip()))
        # class (b): positive masked-address literal, in a `+` expression that is itself under
        # a POINTER CAST (`(T *)(base + 0x1xxxxx)` or `(T *)(0x1xxxxx + base)`) -- this is the
        # discriminator that separates a real disguised address from the MUCH more common
        # 16.16-fixed-point arithmetic constant (0x10000=1.0, 0x20000=2.0, 0x18000=1.5, ...)
        # that also happens to numerically fall in the same [0x10000,0x200000) window.
        for m in re.finditer(
                r'\(\s*[A-Za-z_][A-Za-z0-9_:]*\s*\*+\s*\)\s*\([^()]*?0[xX]([0-9a-fA-F]{5,6})\b[^()]*?\)',
                sline):
            val = int(m.group(1), 16)
            if not (OFF_LO <= val < OFF_HI):
                continue
            hits_b.append((str(f.relative_to(ROOT)), i + 1, m.group(0), VA_LO + val, rline.strip()))

print(f"=== CLASS (a): negative-literal disguised VAs -- {len(hits_a)} hits ===")
for fn, ln, lit, va, line in hits_a:
    print(f"{fn}:{ln}  {lit} == 0x{va:08X}\n    {line}")

print(f"\n=== CLASS (b): masked-address literals adjacent to '+' -- {len(hits_b)} hits ===")
for fn, ln, lit, va, line in hits_b:
    print(f"{fn}:{ln}  {lit} (+0x80000000 == 0x{va:08X})\n    {line}")
