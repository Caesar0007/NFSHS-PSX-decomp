#!/usr/bin/env python3
"""w65a4 -- ORACLE-SIDE relabel of splat's LITERAL `D_<hex>` pseudo-labels.

W64-A21 class c: spimdisasm invented a *data symbol* for a value that is a
CONSTANT, not an address, so the oracle `.s` carries
`lui rX,%hi(D_100FF)` / `addiu rY,rY,%lo(D_100FF)` where retail has a plain
`lui rX,0x1` / `addiu rY,rY,0xFF` pair with NO relocation.

Consequence: the assembled `expected/` object really carries R_MIPS_HI16/LO16
relocations while our recon object has none.  `verify_asm` already resolves
this (`_literal_dlabel`, the w52-a9 fix) so these gate PASS -- but objdiff
cannot: it is not a reloc *name* difference, so `functionRelocDiffs` never
reaches it and the row is charged 0.05 instructions per site forever.

This script rewrites the OPERAND to the bare constant that the retail word
already encodes.  Byte-identical after assembly (proven per-site below).

ANTI-VACUITY: every rewrite is verified by DECODING the retail instruction word
out of that line's own `/* fileoff VA word */` comment and asserting the new
operand equals the immediate field.  A rewrite whose decode disagrees aborts.
(Catalog w43: "VALIDATE ANY CENSUS TOOL AGAINST A KNOWN-POSITIVE".)

Usage:  python scratchpad/w65a4/relabel_literal_d.py [--apply]
"""
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
APPLY = "--apply" in sys.argv
ASM = ROOT / "asm" / "nonmatchings" / "main"

# splat literal pseudo-label -> its constant VALUE
LITERALS = {
    "D_100FF":     0x000100FF,   # the /255 div-guard pair (AISpeeds, Physics)
    "D_FF9D0001":  0xFF9D0001,   # -0x62FFFF (R3DCar)
    "D_1000001":   0x01000001,   # mantissa hi-bit + 1 (__divsf3)
    "D_A000DFAC":  0xA000DFAC,   # BIOS kernel-scratch literal (libcard PATCH)
    "D_A000DF80":  0xA000DF80,   # BIOS kernel-scratch literal (libcard PATCH)
}

FILES = [
    "AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi.s",
    "Physics_CalculateCarAcceleration__FP8Car_tObj.s",
    "R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei.s",
    "__divsf3.s",
    "func_8010CA40.s",
]

# `/* 5E234 8006DA34 0100023C */   lui  $v0, %hi(D_100FF)`
LINE_RE = re.compile(
    r"^(?P<pre>\s*/\* \S+ (?P<va>[0-9A-Fa-f]{8}) (?P<word>[0-9A-Fa-f]{8}) \*/\s*"
    r"(?P<mn>\w+)\s+(?P<ops>.*?))"
    r"%(?P<kind>hi|lo)\((?P<sym>D_[0-9A-Fa-f]+)\)(?P<post>.*)$"
)


def hi_of(v):
    """IDT Ch9 signed %hi/%lo pair: carry into %hi when %lo bit-15 is set."""
    return ((v + 0x8000) >> 16) & 0xFFFF


def lo_of(v):
    lo = v & 0xFFFF
    return lo - 0x10000 if lo >= 0x8000 else lo


def fmt(n):
    return ("-0x%X" % -n) if n < 0 else ("0x%X" % n)


total = 0
for name in FILES:
    p = ASM / name
    raw = p.read_bytes()
    assert b"\r\n" not in raw, f"{name}: expected LF, found CRLF"
    lines = raw.decode("ascii").split("\n")
    hits = 0
    for i, ln in enumerate(lines):
        m = LINE_RE.match(ln)
        if not m:
            assert "D_" not in ln or "%hi" not in ln and "%lo" not in ln, \
                f"{name}:{i+1}: unparsed literal line: {ln!r}"
            continue
        sym = m.group("sym")
        if sym not in LITERALS:
            continue
        val = LITERALS[sym]
        want = hi_of(val) if m.group("kind") == "hi" else lo_of(val)

        # --- ANTI-VACUITY: decode the retail word from this line's own comment
        w = struct.unpack("<I", bytes.fromhex(m.group("word")))[0]
        # little-endian byte string in the comment -> instruction word
        imm = w & 0xFFFF
        op = w >> 26
        if m.group("kind") == "hi":
            assert op == 0x0F, f"{name}:{i+1}: %hi on non-lui (op={op:#x})"
            got = imm                       # lui immediate is unsigned 16
        else:
            assert op in (0x09, 0x0D), \
                f"{name}:{i+1}: %lo on op={op:#x} (expected addiu/ori)"
            got = imm - 0x10000 if imm >= 0x8000 else imm   # addiu sign-extends
        assert got == want, (f"{name}:{i+1}: DECODE MISMATCH {sym} {m.group('kind')} "
                             f"-> computed {want:#x} but retail word {w:#010x} "
                             f"encodes {got:#x}")

        lines[i] = m.group("pre") + fmt(want) + m.group("post")
        hits += 1
        print(f"  {name}:{i+1:<5} {sym:<12} %{m.group('kind')} -> {fmt(want):>9}"
              f"   [retail word {w:#010x} verified]")
    if hits:
        total += hits
        if APPLY:
            out = "\n".join(lines).encode("ascii")
            assert abs(len(out) - len(raw)) < 200
            p.write_bytes(out)
    print(f"{name}: {hits} operand(s)")

print(f"\nTOTAL {total} operands across {len(FILES)} oracle .s files")
if not APPLY:
    print("DRY-RUN. pass --apply to write.")
