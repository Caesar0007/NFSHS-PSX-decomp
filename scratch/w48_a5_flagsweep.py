#!/usr/bin/env python3
"""w48_a5_flagsweep.py <i-file> <FN> [flag ...] -- run CC1PSX on a preprocessed .i with the
build's real flag set plus each extra flag in turn, printing the named function's raw cc1 body
(directives stripped except .set). Purpose: cheap identity probing (which cc1 flag changes the
epilogue / delay-slot shape) WITHOUT touching the tree."""
import subprocess, sys, os, re, tempfile, shutil
from pathlib import Path

CC1 = r"C:/Temp/psq43/COMPILER/CC1PSX.EXE"
BASE = ["-quiet", "-O2", "-G4", "-g1", "-mgpOPT", "-fgnu-linker"]

ifile = sys.argv[1]
fn = sys.argv[2]
flagsets = sys.argv[3:] or [""]
tmp = Path(os.environ.get("LOCALAPPDATA", "/tmp")) / "Temp" / "w48a5"
tmp.mkdir(parents=True, exist_ok=True)


def body(flags, tag):
    src = tmp / f"fs_{tag}.i"
    shutil.copyfile(ifile, src)
    out = tmp / f"fs_{tag}.s"
    r = subprocess.run([CC1, *BASE, *flags, str(src), "-o", str(out)],
                       capture_output=True, text=True)
    if r.returncode:
        return ["CC1FAIL " + (r.stderr or r.stdout).strip().splitlines()[0][:120]]
    txt = out.read_text()
    m = re.search(r'^\t\.ent\t%s\b.*?^\t\.end\t%s' % (re.escape(fn), re.escape(fn)),
                  txt, re.M | re.S)
    if not m:
        return ["NOT FOUND"]
    keep = []
    for ln in m.group(0).splitlines():
        s = ln.strip()
        if not s or s.startswith(('.ent', '.end', '.frame', '.mask', '.fmask',
                                  '.def', '.loc', '#')) or re.match(r'^(LM|\$L|L)\d', s) or s.endswith(':'):
            continue
        keep.append(s)
    return keep


ref = None
for i, fs in enumerate(flagsets):
    flags = fs.split() if fs else []
    b = body(flags, str(i))
    tagname = fs or "<base>"
    same = " (== base)" if ref is not None and b == ref else ""
    if ref is None:
        ref = b
    print(f"===== {tagname}{same}")
    if not same:
        for l in b:
            print("   " + l)
