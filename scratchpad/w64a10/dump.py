"""w64a10 dump.py -- run cpp + REAL CC1PLPSX with RTL dump flags for one TU,
matching tools/build.py compile_cpp EXACTLY (same flags, same -G), and drop the
dumps in this agent's private work dir.

usage:  python scratchpad/w64a10/dump.py <recon/path.cpp> [extra cc1 flags...]
prints the dump paths.
"""
import os
import pathlib
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
CPP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe"
CC1PL = r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"
RECON = ROOT / "recon"
WORK = pathlib.Path(os.environ.get("W64A10_WORK",
                                   str(ROOT / "scratchpad" / "w64a10" / "work")))


def tu_flags(src):
    import build
    return build.per_tu_flags(pathlib.Path(src)), str(build.G_VALUE)


def dump(src, extra=(), tag=""):
    WORK.mkdir(parents=True, exist_ok=True)
    flags, gdef = tu_flags(ROOT / src)
    gval = str(flags.get("g_value", gdef))
    stem = WORK / (pathlib.Path(src).name + (tag or "") + ".i")
    r = subprocess.run([CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
                        "-Dmips", "-D__mips__", "-D__psx__", "-I" + str(RECON),
                        str(ROOT / src), "-o", str(stem)],
                       capture_output=True, text=True)
    if r.returncode:
        sys.exit("cpp failed: " + r.stderr[-400:])
    cc = ["-quiet", "-O2", "-G" + gval]
    for k, f in (("no_delayed_branch", "-fno-delayed-branch"),
                 ("no_split_addresses", "-mno-split-addresses"),
                 ("no_schedule_insns", "-fno-schedule-insns"),
                 ("no_schedule_insns2", "-fno-schedule-insns2"),
                 ("no_strength_reduce", "-fno-strength-reduce"),
                 ("no_builtin", "-fno-builtin")):
        if flags.get(k):
            cc.append(f)
    cc += list(extra)
    for ext in (".lreg", ".greg", ".sched", ".sched2", ".jump", ".combine"):
        try:
            os.remove(str(stem) + ext)
        except OSError:
            pass
    r = subprocess.run([CC1PL, *cc, str(stem), "-o", str(stem)[:-2] + ".s"],
                       capture_output=True, text=True, cwd=str(WORK))
    return stem, cc, r


if __name__ == "__main__":
    src = sys.argv[1]
    stem, cc, r = dump(src, sys.argv[2:])
    print("flags:", " ".join(cc))
    print("stem :", stem)
    for ext in (".lreg", ".greg", ".sched", ".sched2"):
        p = str(stem) + ext
        if os.path.exists(p):
            print("  dump", p, os.path.getsize(p))
    if r.returncode:
        print("cc1 rc", r.returncode, r.stderr[-300:])
