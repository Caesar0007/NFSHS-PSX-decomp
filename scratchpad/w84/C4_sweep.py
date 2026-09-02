#!/usr/bin/env python
"""W84-C4 sweep: where does the 0x10000 materialisation (`li $6`) land?

Goal (derived in C4_receipt.md): get `li $6,0x10000` emitted in the ENTRY block
AFTER the volatile busy read, so reorg's fill_simple backward scan can MOVE it
into the guard branch's delay slot (-1 insn = the oracle).

Each variant: apply -> whole-TU gate -> print the entry-block .s slice.
The file is ALWAYS restored from the backup afterwards.
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

PRINTF = """            printf("StCdInterrupt: DMA ch busy %08x\\n",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;"""

V = {}

def loop(pre, cond="*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000",
         test="i == limit", post="        i++;\n"):
    return (pre + "    while (%s) {\n        if (%s) {\n%s\n        }\n%s    }\n"
            % (cond, test, PRINTF, post))

# --- source POSITION of `limit = 0x10000;` --------------------------------
V["p1_first"]   = loop("    limit = 0x10000;\n    mode = enable_irq;\n    i = 0;\n")
V["p2_mid"]     = loop("    mode = enable_irq;\n    limit = 0x10000;\n    i = 0;\n")
V["p3_last"]    = loop("    mode = enable_irq;\n    i = 0;\n    limit = 0x10000;\n")
# --- inside the condition (later LUID than the volatile read) -------------
V["p4_incond"]  = loop("    mode = enable_irq;\n    i = 0;\n",
                       cond="(*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000)"
                            " && (limit = 0x10000) != 0")
V["p5_comma"]   = loop("    mode = enable_irq;\n    i = 0;\n",
                       cond="(limit = 0x10000), (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000)")
# --- limit derived so that it has a PREDECESSOR in the entry block --------
V["p6_from_mode"] = loop("    mode = enable_irq;\n    i = 0;\n    limit = 0x10000 + (mode & 0);\n")
V["p7_from_ch"]   = loop("    mode = enable_irq;\n    i = 0;\n    limit = 0x10000 + (ch & 0);\n")
# --- limit as a for-init ---------------------------------------------------
V["p8_forinit"] = ("    mode = enable_irq;\n"
                   "    for (i = 0, limit = 0x10000;"
                   " *(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000; i++) {\n"
                   "        if (i == limit) {\n" + PRINTF + "\n        }\n    }\n")
# --- unsigned / long spellings --------------------------------------------
V["p9_unsigned"] = loop("    mode = enable_irq;\n    i = 0;\n    limit = 0x10000;\n")

DECL = "    int           mode;\n"
DECLS = {
    "p9_unsigned": DECL + "    unsigned      limit;\n",
}


def apply(name):
    s = BAK.read_text(encoding="utf-8", errors="surrogateescape")
    assert BASE in s
    s = s.replace(BASE, V[name], 1)
    s = s.replace(DECL, DECLS.get(name, DECL + "    int           limit;\n"), 1)
    SRC.write_text(s, encoding="utf-8", errors="surrogateescape")


def gate():
    r = subprocess.run([sys.executable, "tools/verify_asm.py",
                        "recon/syslib/psx/libcd/stcdint.c",
                        "StCdInterrupt,_st_copy_words,_st_dma"],
                       capture_output=True, text=True)
    return (r.stdout + r.stderr).strip()


def entry_asm():
    subprocess.run([sys.executable, "scratchpad/w84/C4_dump.py"],
                   capture_output=True, text=True)
    s = (ROOT / "scratchpad/w84/rtl/stcdint.s").read_text(errors="replace")
    m = re.search(r"^_st_dma:.*?\n\t\.end", s, re.S | re.M)
    if not m:
        return "(no body)"
    lines = [l for l in m.group(0).splitlines()]
    out = []
    for l in lines:
        out.append(l)
        if "beq\t$2,$0" in l:
            idx = lines.index(l)
            return "\n".join(lines[max(0, idx - 12):idx + 6])
    return "\n".join(lines[:24])


if __name__ == "__main__":
    names = sys.argv[1:] or sorted(V)
    for n in names:
        try:
            apply(n)
            print("=" * 70)
            print("### ", n)
            print(gate())
            print(entry_asm())
        except Exception as e:
            print("###", n, "ERROR", e)
        finally:
            shutil.copyfile(BAK, SRC)
