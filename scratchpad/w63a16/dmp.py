"""w63a16 dump harness: cc1plus RTL dumps with the MANDATORY C++-lane flags.
usage: python dmp.py <srcrel> <dumpfn> [flags...]   (writes v.lreg/.greg/.loop next to it)
"""
import os, re, subprocess, sys, pathlib, tempfile
ROOT = str(pathlib.Path(__file__).resolve().parents[2])
HERE = os.path.join(tempfile.gettempdir(), "w63a16_%d" % os.getpid())
os.makedirs(HERE, exist_ok=True)
CPP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe"
CC1PL = r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"
RECON = os.path.join(ROOT, "recon")

def dump(src, dumpfn, gval="0", extra=()):
    i_file = os.path.join(HERE, "v.i")
    r = subprocess.run([CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
                        "-Dmips", "-D__mips__", "-D__psx__", "-I" + RECON,
                        os.path.join(ROOT, src), "-o", i_file],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode:
        print("cpp FAILED", r.stderr[-400:]); return {}
    for ext in (".lreg", ".greg", ".loop", ".jump", ".combine"):
        try: os.remove(i_file + ext)
        except OSError: pass
    cmd = [CC1PL, "-quiet", "-O2", "-G" + gval, "-fno-exceptions", "-fno-rtti",
           "-dl", "-dg", "-dL"] + list(extra) + [i_file, "-o", os.path.join(HERE, "v.s")]
    p = subprocess.run(cmd, capture_output=True, cwd=HERE, text=True)
    if p.returncode: print("cc1 rc", p.returncode, p.stderr[-400:])
    out = {}
    for ext in (".lreg", ".greg", ".loop"):
        path = i_file + ext
        try: txt = open(path, errors="replace").read()
        except OSError: out[ext] = ""; continue
        sec = ""
        for part in re.split(r"\n;; Function ", txt):
            if dumpfn in part[:200]:
                sec = part
        out[ext] = sec
    return out

if __name__ == "__main__":
    src, fn = sys.argv[1], sys.argv[2]
    d = dump(src, fn)
    for k in (".loop", ".lreg", ".greg"):
        print("=" * 20, k)
        print(d.get(k, "")[:20000])
