#!/usr/bin/env python3
"""W66-A6: RUNNABLE copy of tools/stale_absolutes.py.

tools/stale_absolutes.py is UNRUNNABLE as promoted -- it carries the W64-16F
promotion defect: `ROOT = Path(__file__).resolve().parents[2]` resolves to
C:\\Temp when the file lives in tools/ (it needs parents[1]).  The standing gate
has therefore been throwing FileNotFoundError, i.e. VACUOUS, since promotion.
This copy is identical except for the root and a freshness re-census of the
DEFINED set straight from the build objects (so it no longer depends on a
w65a6 session artifact).

ORCHESTRATOR ACTION: in tools/stale_absolutes.py change
    ROOT = Path(__file__).resolve().parents[2]
to
    ROOT = Path(__file__).resolve().parents[1]
(and consider inlining the census below so the tool is self-contained).
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJD = str(Path(r"C:/Tools/mips-ps1/mips/bin") / "mipsel-none-elf-objdump.exe")
EXCLUDED = ("diffsrc", "scratch", "scratchpad", "pbuild", "relink", "probe_link")


def defined_symbols():
    """Every GLOBAL symbol DEFINED (not undefined, not common) by a build object."""
    objs = [p for p in (ROOT / "build").rglob("*.o")
            if not any(x in p.as_posix() for x in EXCLUDED)]
    out = set()
    for i in range(0, len(objs), 60):                    # ARG_MAX discipline
        r = subprocess.run([OBJD, "-t"] + [str(o) for o in objs[i:i + 60]],
                           capture_output=True, text=True)
        for ln in r.stdout.split("\n"):
            p = ln.split()
            if len(p) >= 5 and p[1] in ("g", "l") and not ln.startswith("*UND*"):
                sec = next((t for t in p if t.startswith(".")), None)
                if sec and sec not in (".text",) or sec == ".text":
                    if "*UND*" not in ln and "*COM*" not in ln:
                        out.add(p[-1])
    return out


if __name__ == "__main__":
    defined = defined_symbols()
    p = ROOT / "linkers/undefined_syms_auto.txt"
    rows = []
    for i, line in enumerate(open(p, encoding="latin-1"), 1):
        m = re.match(r"^\s*(\S+)\s*=\s*(0x[0-9A-Fa-f]+)\s*;", line)
        if m and m.group(1) in defined:
            rows.append((i, m.group(1), m.group(2)))
    print("defined-symbol census: %d names from build objects" % len(defined))
    print("linkers/undefined_syms_auto.txt: %d rows now shadow a REAL definition"
          % len(rows))
    for i, s, v in rows:
        print("  line %4d  %-22s %s" % (i, s, v))
    sys.exit(0)
