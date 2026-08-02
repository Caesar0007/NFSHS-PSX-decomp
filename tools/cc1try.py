#!/usr/bin/env python
"""cc1try -- one-shot standalone cc1(+maspsx) harness for testing a SPELLING.

Why: verify_asm re-preprocesses the whole recon TU (~0.6 s) and drags in every
header, so an exhaustive spelling sweep (masks x statement orders x ...) is slow
and noisy.  A hand-written mini-TU containing ONLY the function under test plus
the few decls it needs compiles in ~0.1 s and lets you sweep hundreds of
variants, then transcribe the winner back into the real TU and gate it there.
This is how w44 found strSetDefDecEnv's read-order/store-order coupling
(24x24 sweep = 576 builds) and mdecdone's volatile address-value form.

The input is a **.i file** -- it goes STRAIGHT to cc1, no preprocessor -- so
write it with no #include and no macros (or run cpp yourself first).

usage:
    python tools/cc1try.py <file.i> [--fn NAME] [--cpp] [cc1 flags...]

    --fn NAME   print only that function's body (default: whole output)
    --cpp       use CC1PLPSX (C++ lane, the default); pass --c for CC1PSX
    extra args are appended to the cc1 command line (e.g. -mno-split-addresses)

Output is post-maspsx (so assembler-macro expansion / div guards / delay-slot
nops are what the object will really contain), one instruction per line,
directives and comments stripped -- directly diffable against an
asm/nonmatchings/**.s oracle body.

As a library:
    from cc1try import build
    insns = build(source_text, fn="myfunc", flags=["-O2","-G4"])
"""
import subprocess
import sys
import os
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CC1PL = os.environ.get("NFS4_CC1PL", r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE")
CC1 = os.environ.get("NFS4_CC1", r"C:/Temp/psq43/COMPILER/CC1PSX.EXE")
MASPSX = os.environ.get("NFS4_MASPSX", r"C:/Temp/maspsx-master/maspsx.py")
ASPSX_VERSION = "2.77"


def build(src_text, fn=None, flags=("-O2", "-G4"), cplusplus=True):
    """Compile src_text (a .i body) and return the post-maspsx instruction list.

    Returns a list of 'mnemonic operands' strings (directives/labels/comments
    stripped).  On failure returns a one-element list ['CC1FAIL ...'].
    If fn is given, only that symbol's body is returned.
    """
    cc = CC1PL if cplusplus else CC1
    with tempfile.TemporaryDirectory() as td:
        i_file = Path(td) / "t.i"
        s_file = Path(td) / "t.s"
        i_file.write_text(src_text, encoding="utf-8")
        r = subprocess.run([cc, "-quiet", *flags, str(i_file), "-o", str(s_file)],
                           capture_output=True, text=True)
        if r.returncode:
            return ["CC1FAIL " + (r.stdout + r.stderr).strip()[:400]]
        with open(s_file) as fh:
            m = subprocess.run([sys.executable, MASPSX,
                                f"--aspsx-version={ASPSX_VERSION}", "--expand-div"],
                               stdin=fh, capture_output=True, text=True)
        if m.returncode:
            return ["MASPSXFAIL " + (m.stdout + m.stderr).strip()[:400]]
    out, started = [], (fn is None)
    for ln in m.stdout.splitlines():
        s = ln.split("#")[0].strip()          # maspsx annotates with '#'
        if fn is not None and s.startswith(fn + ":"):
            started = True
            continue
        if not started or not s or s.startswith("."):
            continue
        if s.endswith(":"):                    # a label ends the body we want
            if fn is not None:
                break
            continue
        out.append(" ".join(s.split()))
    return out


def main():
    args = list(sys.argv[1:])
    if not args:
        sys.exit(__doc__)
    path, fn, cplusplus, flags = args.pop(0), None, True, ["-O2", "-G4"]
    while args:
        a = args.pop(0)
        if a == "--fn":
            fn = args.pop(0)
        elif a == "--c":
            cplusplus = False
        elif a == "--cpp":
            cplusplus = True
        else:
            flags.append(a)
    for i, ins in enumerate(build(Path(path).read_text(), fn, flags, cplusplus), 1):
        print("%3d %s" % (i, ins))


if __name__ == "__main__":
    main()
