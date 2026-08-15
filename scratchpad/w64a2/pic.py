"""allocno picture with the MANDATORY cc1plus lab flags (-fno-exceptions -fno-rtti,
12H) -- tools/fast.py's picture() omits them."""
import os, re, subprocess, sys, tempfile, pathlib

ROOT = str(pathlib.Path(__file__).resolve().parents[2])
sys.path.insert(0, os.path.join(ROOT, "tools"))
import fast

HERE = os.path.join(tempfile.gettempdir(), "w64a2pic_%d" % os.getpid())
os.makedirs(HERE, exist_ok=True)
CPP = fast.CPP
CC1PL = fast.CC1PL
RECON = fast.RECON
NAME = fast.NAME


def picture(src, dumpfn, gval="4", minrefs=4):
    i_file = os.path.join(HERE, "v.i")
    r = subprocess.run([CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
                        "-Dmips", "-D__mips__", "-D__psx__", "-I" + RECON,
                        os.path.join(ROOT, src), "-o", i_file],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode:
        return "    cpp FAILED: " + r.stderr[-300:]
    for ext in (".lreg", ".greg"):
        try:
            os.remove(i_file + ext)
        except OSError:
            pass
    subprocess.run([CC1PL, "-quiet", "-O2", "-G" + gval, "-fno-exceptions",
                    "-fno-rtti", "-dl", "-dg", i_file,
                    "-o", os.path.join(HERE, "v.s")], capture_output=True, cwd=HERE)
    lreg, greg = fast._sec(i_file + ".lreg", dumpfn), fast._sec(i_file + ".greg", dumpfn)
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
        pri = (len(bin(refs)) - 3) * refs / float(live) if live else 0
        out.append("    p%-4d refs=%-3d live=%-4d pri=%.4f blk=%-4s %-4s %s %s"
                   % (r_, refs, live, pri, blk, hn,
                      "GLOBAL" if str(r_) in conf else "local ", note[:40]))
    return "\n".join(out)


if __name__ == "__main__":
    print(picture(sys.argv[1], sys.argv[2], sys.argv[3] if len(sys.argv) > 3 else "4",
                  int(sys.argv[4]) if len(sys.argv) > 4 else 4))
