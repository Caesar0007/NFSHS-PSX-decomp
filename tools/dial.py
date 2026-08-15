"""dial.py <relfile> <MANGLED> <variantfile> <fn-sig> p1,p2,...
For each variant: gate + a fresh REAL-CC1PLPSX -dl/-dg dump, then print the
allocsim row (refs/live/pri/reg) for the listed pseudos.  Always restores.
"""
import os, re, runpy, subprocess, sys, tempfile

ROOT = r"C:/Temp/nfs4-decomp"
CPP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe"
CC1PL = r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"
HERE = os.path.join(tempfile.gettempdir(), "w62a12dial_%d" % os.getpid())
os.makedirs(HERE, exist_ok=True)
sys.path.insert(0, os.path.join(ROOT, "tools"))
import allocsim as A


def eol_of(data, anchor_lf):
    hits = [e for e in ("\n", "\r\n")
            if data.count(anchor_lf.replace("\n", e).encode("ascii")) == 1]
    if len(hits) != 1:
        raise SystemExit("anchor regimes %r" % hits)
    return hits[0]


rel, fn, vfile, sig = sys.argv[1:5]
pseudos = [int(x) for x in sys.argv[5].split(',')] if len(sys.argv) > 5 else []
path = os.path.join(ROOT, rel)
orig = open(path, "rb").read()
ns = runpy.run_path(vfile)
eol = eol_of(orig, ns["ANCHOR"])
anchor = ns["ANCHOR"].replace("\n", eol).encode("ascii")
assert orig.count(anchor) == 1
env = dict(os.environ, VA_MAX=os.environ.get("VA_MAX", "400"))
try:
    for name in sorted(ns["VARIANTS"]):
        new = orig.replace(anchor, ns["VARIANTS"][name].replace("\n", eol)
                           .encode("ascii"), 1)
        tmp = path + ".dialtmp"
        open(tmp, "wb").write(new)
        assert os.path.getsize(tmp) > 0
        os.replace(tmp, path)
        r = subprocess.run([sys.executable, "tools/verify_asm.py", rel, fn],
                           capture_output=True, text=True, cwd=ROOT, env=env)
        line = [l.strip() for l in r.stdout.splitlines() if fn + ":" in l]
        print("=== %-6s %s" % (name, line[0] if line else r.stdout.strip()[-120:]))
        i = os.path.join(HERE, "v.i")
        c = subprocess.run([CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc",
                            "-undef", "-Dmips", "-D__mips__", "-D__psx__",
                            "-I" + os.path.join(ROOT, "recon"), path, "-o", i],
                           capture_output=True, text=True, cwd=ROOT)
        if c.returncode:
            print("    cpp FAILED"); continue
        for e in (".lreg", ".greg"):
            try: os.remove(i + e)
            except OSError: pass
        subprocess.run([CC1PL, "-quiet", "-O2", "-G0", "-dl", "-dg", i,
                        "-o", os.path.join(HERE, "v.s")], capture_output=True,
                       cwd=HERE)
        try:
            L = A.parse_lreg(i + ".lreg", sig)
            order, conf, prefs, disp = A.parse_greg(i + ".greg", sig)
            sim = A.Sim(L, order, conf, prefs, disp,
                        A.parse_copy_prefs(i + ".lreg", sig),
                        A.parse_ever_live(i + ".lreg", sig))
            pri = sim.priorities(None)
            show = pseudos or [p for p in order]
            for p in show:
                if p in pri:
                    pr, refs, live, size = pri[p]
                    print("    p%-5d refs=%-4d live=%-5d pri=%.4f  reg=%s"
                          % (p, refs, live, pr / 10000.0,
                             A.rname(disp.get(p))))
        except Exception as ex:
            print("    dump parse failed: %r" % (ex,))
finally:
    tmp = path + ".dialtmp"
    open(tmp, "wb").write(orig)
    os.replace(tmp, path)
    assert open(path, "rb").read() == orig
    print("(restored)")
