#!/usr/bin/env python3
"""w46-a2 probe harness for MCRD_handlecardevents res==1 arm.

Replaces the arm body between two unique anchors with a variant, gates the
single function (and optionally the whole TU), then ALWAYS restores.

Usage:  python scratch/a2_probe.py variants.py-module-less   (see __main__)
"""
import subprocess, sys, re
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-wt46-a2")
SRC = ROOT / "recon" / "frontend" / "psx" / "memcard.c"
NL = "\r\n"

# unique anchors bracketing the res==1 arm body
HEAD = "      case 1:" + NL
TAIL = "        break;" + NL + "      case 2:" + NL

TU_FNS = ("MCRD_init,iMCRD_InitCard,MCRD_restore,MCRD_getopts,MCRD_setopts,"
          "MCRD_loadfile,iMCRD_DoFileLoad,MCRD_savefile,iMCRD_DoFileWrite,"
          "iMCRD_DoFileDelete,MCRD_handlecardevents,MCRD_fileexists,"
          "iMCRD_timersub,garyMemCardGrabBlocks,iMCRD_LoadCard,iMCRD_FormatCard,"
          "iMCRD_HandleError,iMCRD_DefaultCBProc1,ascii2sjis,sjis2ascii")


def read():
    return SRC.read_text(encoding="utf-8", newline="")


def write(t):
    SRC.write_text(t, encoding="utf-8", newline="")


def bounds(text):
    i = text.index(HEAD)
    j = text.index(TAIL, i)
    return i + len(HEAD), j


def gate(fns="MCRD_handlecardevents"):
    r = subprocess.run([sys.executable, "tools/verify_asm.py",
                        "recon/frontend/psx/memcard.c", fns],
                       cwd=ROOT, capture_output=True, text=True)
    return r.stdout + r.stderr


def score(out, fn="MCRD_handlecardevents"):
    for ln in out.splitlines():
        if ln.strip().startswith(fn + ":"):
            if "PASS" in ln:
                m = re.search(r"\((\d+) insns\)", ln)
                return 0, int(m.group(1)) if m else -1, int(m.group(1)) if m else -1
            m = re.search(r"FAIL (\d+) diffs \(ours (\d+) / oracle (\d+)\)", ln)
            if m:
                return int(m.group(1)), int(m.group(2)), int(m.group(3))
    return None, None, None


def run(variants, full_tu=False):
    orig = read()
    a, b = bounds(orig)
    base_body = orig[a:b]
    results = []
    try:
        for name, body in variants:
            write(orig[:a] + body + orig[b:])
            out = gate(TU_FNS if full_tu else "MCRD_handlecardevents")
            d, o, orc = score(out)
            npass = out.count(": PASS")
            results.append((name, d, o, orc, npass, out))
            print(f"{name:<44} diffs={d} ours={o}/{orc}" +
                  (f" pass={npass}" if full_tu else ""))
    finally:
        write(orig)
    return results


S = "        status = 2;" + NL
B = "        gMemCardInfo.bReady = cmd;" + NL
T = "        gMemCardInfo.existencecheckticks[card + -1] = timerhz;" + NL
P = "        pCI->status = -1;" + NL
D0 = "        do {" + NL
D1 = "        } while (0);" + NL

BASE = S + B + D0 + T + D1 + P
