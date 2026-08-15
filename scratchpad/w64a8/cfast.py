"""cfast.py -- the C-LANE twin of tools/fast.py (w64-a8).

fast.py drives CC1PLPSX (the C++ lane).  eaclib/syslib .c TUs compile with
CC1PSX (gcc 2.8.0) or the 272 rung, so its allocno picture is the wrong
compiler for them.  This harness:
   gate      -> tools/verify_asm.py (unchanged, the authority)
   allocnos  -> cpp with build.py's CPP_FLAGS + the TU's real cc1 binary,
                -dl -dg, per-PID work dir (w61-a13 hazard).

usage (import):  run(src, fn, dumpfn, {tag: (old,new) | [(old,new),...]}, cc1=...)
"""
import os
import re
import subprocess
import sys
import pathlib
import tempfile

ROOT = str(pathlib.Path(__file__).resolve().parents[2])
HERE = os.path.join(tempfile.gettempdir(), "cfast_%d" % os.getpid())
os.makedirs(HERE, exist_ok=True)
CPP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe"
CC1_28 = r"C:/Temp/psq43/COMPILER/CC1PSX.EXE"
CC1_272 = r"C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE"
RECON = os.path.join(ROOT, "recon")
INCLUDE = os.path.join(ROOT, "include")
NAME = ['zero', 'at', 'v0', 'v1', 'a0', 'a1', 'a2', 'a3', 't0', 't1', 't2',
        't3', 't4', 't5', 't6', 't7', 's0', 's1', 's2', 's3', 's4', 's5',
        's6', 's7', 't8', 't9', 'k0', 'k1', 'gp', 'sp', 'fp', 'ra']


def gate(path, fn):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", path, fn],
                       capture_output=True, text=True, cwd=ROOT)
    out = [l.strip() for l in r.stdout.splitlines() if l.strip()]
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


def picture(src, dumpfn, gval="4", minrefs=2, cc1=CC1_28, extra=()):
    i_file = os.path.join(HERE, "v.i")
    r = subprocess.run([CPP, "-nostdinc", "-undef", "-D__GNUC__=2",
                        "-D__OPTIMIZE__", "-Dmips", "-D__mips__", "-D__psx__",
                        "-DPSX", "-I" + INCLUDE, "-I" + RECON,
                        os.path.join(ROOT, src), "-o", i_file],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode:
        return "    cpp FAILED: " + r.stderr[-200:]
    for ext in (".lreg", ".greg"):
        try:
            os.remove(i_file + ext)
        except OSError:
            pass
    subprocess.run([cc1, "-quiet", "-O2", "-G" + gval, "-g1", "-mgpOPT",
                    "-fgnu-linker", "-dl", "-dg", *extra,
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
    lq = re.findall(r";; Register (\d+) in (\d+)\.", lreg)
    out = ["    globals: " + (alloc.group(2).strip() if alloc else "(none)")]
    if lq:
        out.append("    local-alloc handout: " +
                   ", ".join("p%s=%s" % (a, NAME[int(b)] if int(b) < 32 else b)
                             for a, b in lq))
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


def dumps(src, dumpfn, gval="4", cc1=CC1_28, extra=()):
    """return (lreg_section, greg_section) raw text for the fn"""
    picture(src, dumpfn, gval, 99, cc1, extra)
    i_file = os.path.join(HERE, "v.i")
    return _sec(i_file + ".lreg", dumpfn), _sec(i_file + ".greg", dumpfn)


def run(src, fn, dumpfn, variants, gval="4", minrefs=2, dump=True,
        cc1=CC1_28, extra=()):
    full = os.path.join(ROOT, src)
    orig = open(full, "rb").read()
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
                n = data.count(old)
                if n != 1:
                    ok = False
                    print("      (anchor count=%d on %r)" % (n, old[:60]))
                    break
                data = data.replace(old, new)
            if not ok:
                print("=== %-40s ANCHOR-MISS" % tag)
                continue
            tmp = full + ".cfasttmp"
            open(tmp, "wb").write(data)
            os.replace(tmp, full)
            print("=== %-40s %s" % (tag, gate(src, fn)))
            if dump:
                print(picture(src, dumpfn, gval, minrefs, cc1, extra))
    finally:
        tmp = full + ".cfasttmp"
        open(tmp, "wb").write(orig)
        os.replace(tmp, full)
        assert open(full, "rb").read() == orig
        print("(restored)")
