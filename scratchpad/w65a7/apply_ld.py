#!/usr/bin/env python3
"""W65-A7 -- land the variant-C src-lane fix into linkers/nfs4.ld.

Asserted, byte-mode, LF-preserving, with a backup.  Re-derives the new text
from the CURRENT file (never from a stale copy) using the same replacements
mkld.py variant C applies, so a peer edit to the object lists is preserved.
"""
import os
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
LD = ROOT / "linkers" / "nfs4.ld"

raw = LD.read_bytes()
assert b"\r\n" not in raw, "nfs4.ld gained CRLF -- re-derive the endings"
txt = raw.decode("ascii")

DISCARD_OLD = """    /DISCARD/ :
    {
        *(*);
    }
}"""
DISCARD_NEW = """    /* W65-A7: the trailing `*(*)` rule ate 459 of the src lane's 461
     * per-module objects ("defined in discarded section" x1975).  It is
     * narrowed to metadata + linker-generated sections ONLY; every real
     * input section is now placed by the catch-alls above.  The list is
     * derived from a census of every input section across both lanes
     * (scratchpad/w65a7/seccensus.py) plus the ld-generated .rel.dyn --
     * dropping .rel.dyn is what keeps the splat link byte-identical. */
    /DISCARD/ :
    {
        *(.pdr); *(.reginfo); *(.MIPS.abiflags); *(.gnu.attributes);
        *(.comment); *(.mdebug*); *(.rel.dyn); *(.rel*); *(.note*);
        *(.debug*); *(.line); *(.stab*); *(.got*); *(.dyn*);
    }
}"""
assert DISCARD_OLD in txt, "the /DISCARD/ block moved -- re-derive the anchor"
assert txt.count(DISCARD_OLD) == 1
new = txt.replace(DISCARD_OLD, DISCARD_NEW)

# Section-aware catch-alls, scoped to build/src/*, folded into the MATCHING
# run of .nfs4 (never a trailing region): a trailing catch-all splits the
# small-data run in two and every %gp_rel reference then overflows
# (measured: 1 "small-data section too large" + 18 R_MIPS_GPREL16
# truncations; the same symbols land gp+0xb9c instead of gp-0xf3824 when the
# catch-all sits inside the section -- scratchpad/w65a7/gprel.py).
CATCH = ((".rodata", "nfs4_RODATA_END"), (".text", "nfs4_TEXT_END"),
         (".data", "nfs4_DATA_END"), (".sdata", "nfs4_SDATA_END"),
         (".sbss", "nfs4_SBSS_END"), (".bss", "nfs4_BSS_END"))
for sec, end in CATCH:
    anchor = "        . = ALIGN(., 16);\n        %s = .;" % end
    assert new.count(anchor) == 1, "anchor for %s not unique" % end
    extra = "        build/src/*(%s);\n" % sec
    if sec == ".bss":
        extra += "        build/src/*(COMMON);\n"
    new = new.replace(anchor, extra + anchor, 1)

if new == txt:
    sys.exit("nothing to do")
out = new.encode("ascii")
assert len(out) > len(raw), "refusing a shrinking write"
shutil.copy2(LD, HERE / "nfs4.ld.bak")
tmp = LD.with_suffix(".ld.tmp")
tmp.write_bytes(out)
os.replace(tmp, LD)
print("landed: %d -> %d bytes (backup scratchpad/w65a7/nfs4.ld.bak)"
      % (len(raw), len(out)))
