#!/usr/bin/env python3
"""W65-A7 -- build candidate src-lane linker scripts from linkers/nfs4.ld.

variant "A"  = the W64-A19 spec verbatim: narrow /DISCARD/ to metadata and add
               ONE trailing catch-all region .src_rest after the .nfs4 section.
variant "B"  = section-aware: the catch-alls are folded INTO .nfs4 at the
               matching section boundary (text with text, sdata with sdata,
               ...), so gp-relative data stays inside the small-data window.

usage: python scratchpad/w65a7/mkld.py A|B  -> scratchpad/w65a7/nfs4_<v>.ld
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
SRC = (ROOT / "linkers" / "nfs4.ld").read_text()
variant = (sys.argv[1] if len(sys.argv) > 1 else "A").upper()

DISCARD_OLD = """    /DISCARD/ :
    {
        *(*);
    }
}"""
DISCARD_NEW = """    /DISCARD/ :
    {
        *(.pdr); *(.reginfo); *(.MIPS.abiflags); *(.gnu.attributes);
        *(.comment); *(.mdebug*); *(.rel.dyn); *(.rel*); *(.note*);
        *(.debug*); *(.line); *(.stab*); *(.got*); *(.dyn*);
    }
}"""
assert DISCARD_OLD in SRC, "the /DISCARD/ block moved -- re-derive the anchor"

if variant == "A":
    body = SRC.replace(
        DISCARD_OLD,
        "    .src_rest : SUBALIGN(4) { *(.text); *(.rodata); *(.data); "
        "*(.sdata); *(.sbss); *(.bss); *(COMMON); }\n" + DISCARD_NEW)
elif variant == "B":
    body = SRC.replace(DISCARD_OLD, DISCARD_NEW)
    # fold a catch-all into each section run of .nfs4, right before its _END
    for sec, end in ((".rodata", "nfs4_RODATA_END"),
                     (".text", "nfs4_TEXT_END"),
                     (".data", "nfs4_DATA_END"),
                     (".sdata", "nfs4_SDATA_END"),
                     (".sbss", "nfs4_SBSS_END"),
                     (".bss", "nfs4_BSS_END")):
        anchor = f"        . = ALIGN(., 16);\n        {end} = .;"
        assert anchor in body, f"anchor for {end} not found"
        extra = f"        *({sec});\n"
        if sec == ".bss":
            extra += "        *(COMMON);\n"
        body = body.replace(anchor, extra + anchor, 1)
elif variant == "C":
    # section-aware AND scoped to the src lane, so the no-object-list link that
    # tools/build.py performs is provably byte-neutral (a bare `*(.sbss)` etc.
    # otherwise keeps blob sections HEAD's `/DISCARD/ : *(*)` was dropping,
    # measured +240 bytes on variant B).
    body = SRC.replace(DISCARD_OLD, DISCARD_NEW)
    for sec, end in ((".rodata", "nfs4_RODATA_END"),
                     (".text", "nfs4_TEXT_END"),
                     (".data", "nfs4_DATA_END"),
                     (".sdata", "nfs4_SDATA_END"),
                     (".sbss", "nfs4_SBSS_END"),
                     (".bss", "nfs4_BSS_END")):
        anchor = f"        . = ALIGN(., 16);\n        {end} = .;"
        assert anchor in body, f"anchor for {end} not found"
        extra = f"        build/src/*({sec});\n"
        if sec == ".bss":
            extra += "        build/src/*(COMMON);\n"
        body = body.replace(anchor, extra + anchor, 1)
else:
    sys.exit("variant must be A, B or C")

out = HERE / f"nfs4_{variant}.ld"
out.write_text(body)
print(f"wrote {out}  ({len(body)} bytes)")
