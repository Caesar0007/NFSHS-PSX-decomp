#!/usr/bin/env python
"""W84-C4 experiment harness for _st_dma's busy-wait guard delay slot.

Usage:  python scratchpad/w84/C4_try.py <variantname>
Applies the named variant to recon/syslib/psx/libcd/stcdint.c, gates the WHOLE
TU, prints the slot region of the raw cc1 .s, then ALWAYS restores the file
from scratchpad/w84/C4_stcdint_backup.c.
"""
import subprocess, sys, os, re, shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
os.chdir(ROOT)
SRC = ROOT / "recon/syslib/psx/libcd/stcdint.c"
BAK = ROOT / "scratchpad/w84/C4_stcdint_backup.c"

BASE = """    mode = enable_irq;
    i = 0;
    while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {
        if (i == 0x10000) {
            printf("StCdInterrupt: DMA ch busy %08x\\n",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;
        }
        i++;
    }
"""

VARIANTS = {
"base": BASE,

# --- E-a family: try to get the 0x10000 materialised in the ENTRY block -----
"v1_named_limit": """    mode = enable_irq;
    i = 0;
    limit = 0x10000;
    while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {
        if (i == limit) {
            printf("StCdInterrupt: DMA ch busy %08x\\n",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;
        }
        i++;
    }
""",

"v2_forever": """    mode = enable_irq;
    i = 0;
    for (;;) {
        if ((*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) == 0)
            break;
        if (i == 0x10000) {
            printf("StCdInterrupt: DMA ch busy %08x\\n",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;
        }
        i++;
    }
""",

"v3_if_dowhile": """    mode = enable_irq;
    i = 0;
    if (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {
        do {
            if (i == 0x10000) {
                printf("StCdInterrupt: DMA ch busy %08x\\n",
                       *(volatile int *)(0x1F801088 + (ch << 4)));
                break;
            }
            i++;
        } while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000);
    }
""",

"v4_for_incr": """    mode = enable_irq;
    for (i = 0; *(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000; i++) {
        if (i == 0x10000) {
            printf("StCdInterrupt: DMA ch busy %08x\\n",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;
        }
    }
""",

"v5_limit_neq_guard": """    mode = enable_irq;
    i = 0;
    limit = 0x10000;
    if (limit != 0)
    while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {
        if (i == limit) {
            printf("StCdInterrupt: DMA ch busy %08x\\n",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;
        }
        i++;
    }
""",

# --- E-b family: kill $a2 in the window between the exit label and the first
#     conditional jump after it (gcc-2.7.2's only forward-rescue window).
"v6_dv_before_mode": BASE,   # handled by an extra transform below
}

# extra whole-body transforms keyed by variant name
def extra(name, s):
    if name in ("v1_named_limit", "v5_limit_neq_guard"):
        s = s.replace("    int           mode;\n",
                      "    int           mode;\n    int           limit;\n", 1)
    return s


def apply(name):
    body = VARIANTS[name]
    s = BAK.read_text(encoding="utf-8", errors="surrogateescape")
    assert BASE in s, "base block not found"
    s = s.replace(BASE, body, 1)
    s = extra(name, s)
    SRC.write_text(s, encoding="utf-8", errors="surrogateescape")


def gate():
    r = subprocess.run([sys.executable, "tools/verify_asm.py",
                        "recon/syslib/psx/libcd/stcdint.c",
                        "StCdInterrupt,_st_copy_words,_st_dma"],
                       capture_output=True, text=True)
    return r.stdout + r.stderr


def dump_slot():
    r = subprocess.run([sys.executable, "scratchpad/w84/C4_dump.py"],
                       capture_output=True, text=True)
    s = (ROOT / "scratchpad/w84/rtl/stcdint.s").read_text(errors="replace")
    m = re.search(r"^_st_dma:.*?\n\t\.end", s, re.S | re.M)
    body = m.group(0) if m else s
    out = []
    lines = body.splitlines()
    for i, l in enumerate(lines):
        if "$L" in l and ("beq\t$2,$0" in l or "beq\t$2,$0," in l):
            out = lines[max(0, i - 4):i + 10]
            break
    if not out:
        out = lines[:40]
    return "\n".join(out)


if __name__ == "__main__":
    name = sys.argv[1]
    try:
        apply(name)
        print("### VARIANT", name)
        print(gate())
        print("--- cc1 .s slot region ---")
        print(dump_slot())
    finally:
        shutil.copyfile(BAK, SRC)
