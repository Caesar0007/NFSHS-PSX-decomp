"""fast.py -- per-variant GATE + REAL-CC1PLPSX allocno picture, WITHOUT a tree
rebuild (the w60-a10 lesson: build.py --skip-asm per variant costs minutes).

  gate      -> tools/verify_asm.py (compiles just that TU)
  allocnos  -> our own cpp run (same flags as build.py compile_cpp) + CC1PLPSX -dl -dg
"""
import os
import re
import subprocess
import sys

import pathlib
ROOT = str(pathlib.Path(__file__).resolve().parents[1])   # tools/ -> repo root
HERE = os.path.dirname(os.path.abspath(__file__))
CPP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe"
CC1PL = r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"
RECON = os.path.join(ROOT, "recon")
NAME = ['zero', 'at', 'v0', 'v1', 'a0', 'a1', 'a2', 'a3', 't0', 't1', 't2',
        't3', 't4', 't5', 't6', 't7', 's0', 's1', 's2', 's3', 's4', 's5',
        's6', 's7', 't8', 't9', 'k0', 'k1', 'gp', 'sp', 'fp', 'ra']


def gate(path, fn):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", path, fn],
                       capture_output=True, text=True, cwd=ROOT)
    out = [l.strip() for l in r.stdout.splitlines() if l.strip()]
    # cc1plus warnings land on stdout too -- pick the gate's own verdict line
    hit = [l for l in out if l.startswith(fn + ":")]
    if hit:
        return hit[0]
    return (out[-1] if out else "") + " |ERR " + r.stderr.strip()[-160:]


def _sec(path, fn):
    try:
        txt = open(path, errors="replace").read()
    except OSError:
        return ""
    for p in re.split(r"\n;; Function ", txt):
        if fn in p[:130]:
            return p
    return ""


def picture(src, dumpfn, gval="0", minrefs=4):
    i_file = os.path.join(HERE, "v.i")
    r = subprocess.run([CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
                        "-Dmips", "-D__mips__", "-D__psx__", "-I" + RECON,
                        os.path.join(ROOT, src), "-o", i_file],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode:
        return "    cpp FAILED: " + r.stderr[-200:]
    for ext in (".lreg", ".greg"):
        try:
            os.remove(i_file + ext)
        except OSError:
            pass
    subprocess.run([CC1PL, "-quiet", "-O2", "-G" + gval, "-dl", "-dg",
                    i_file, "-o", os.path.join(HERE, "v.s")],
                   capture_output=True, cwd=HERE)
    lreg, greg = _sec(i_file + ".lreg", dumpfn), _sec(i_file + ".greg", dumpfn)
    regs = {}
    for m in re.finditer(r"Register (\d+) used (\d+) times across (\d+) insns"
                         r"(?: in block (\d+))?;([^\n]*)", lreg):
        regs[int(m.group(1))] = (int(m.group(2)), int(m.group(3)),
                                 m.group(4), m.group(5).strip())
    alloc = re.search(r";; (\d+) regs to allocate: ([^\n]*)", greg)
    disp = {}
    for m in re.finditer(r"(\d+) in (\d+)", greg.split("Register dispositions:")[-1]):
        disp[int(m.group(1))] = int(m.group(2))
    conf = dict(re.findall(r";; (\d+) conflicts: ([^\n]*)", greg))
    out = ["    globals: " + (alloc.group(2).strip() if alloc else "(none)")]
    for r_ in sorted(regs):
        refs, live, blk, note = regs[r_]
        if refs < minrefs:
            continue
        h = disp.get(r_)
        hn = NAME[h] if h is not None and h < 32 else str(h)
        out.append("    p%-4d refs=%-3d live=%-3d blk=%-4s %-4s %s %s"
                   % (r_, refs, live, blk, hn,
                      "GLOBAL" if str(r_) in conf else "local ", note[:40]))
    return "\n".join(out)


def run(src, fn, dumpfn, variants, gval="0", minrefs=4, dump=True):
    full = os.path.join(ROOT, src)
    orig = open(full, "rb").read()
    # w60-a10 hazard: the Edit tool normalizes a mixed-ending file to CRLF, so an
    # anchor written with \n silently misses.  Translate anchors to whichever
    # ending the file actually uses (checked per anchor, so a mixed file works).
    crlf = orig.count(b"\r\n") > orig.count(b"\n") // 2

    def fix(b):
        if crlf and b"\r\n" not in b:
            return b.replace(b"\n", b"\r\n")
        return b
    try:
        for tag, pairs in variants.items():
            if isinstance(pairs, tuple):
                pairs = [pairs]
            data, ok = orig, True
            for old, new in pairs:
                old, new = fix(old), fix(new)
                if old not in data:
                    ok = False
                    print("      (miss on %r)" % old[:48])
                    break
                data = data.replace(old, new)
            if not ok:
                print("=== %-34s ANCHOR-MISS" % tag)
                continue
            tmp = full + ".fasttmp"
            open(tmp, "wb").write(data)
            os.replace(tmp, full)
            print("=== %-34s %s" % (tag, gate(src, fn)))
            if dump:
                print(picture(src, dumpfn, gval, minrefs))
    finally:
        tmp = full + ".fasttmp"
        open(tmp, "wb").write(orig)
        os.replace(tmp, full)
        assert open(full, "rb").read() == orig
        print("(restored)")
