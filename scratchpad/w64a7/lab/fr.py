"""fr.py -- compile a .i with a rung cc1 and print the .frame line of one fn.

usage: python fr.py <file.i> <fnname> [ver] [extra cc1 flags...]
"""
import os, re, subprocess, sys

RUNG = {
    "2.6.0": r"C:/Temp/windows-gcc-psx/gcc-2.6.0-psx/cc1.exe",
    "2.6.3": r"C:/Temp/windows-gcc-psx/gcc-2.6.3-psx/cc1.exe",
    "2.7.2": r"C:/Temp/windows-gcc-psx/gcc-2.7.2-psx/cc1.exe",
    "2.7.2-970404": r"C:/Temp/windows-gcc-psx/gcc-2.7.2-970404-psx/cc1.exe",
    "2.8.0": r"C:/Temp/windows-gcc-psx/gcc-2.8.0-psx/cc1.exe",
    "2.8.1": r"C:/Temp/windows-gcc-psx/gcc-2.8.1-psx/cc1.exe",
}


def frame(ifile, fn, ver="2.7.2", extra=()):
    s = os.path.splitext(ifile)[0] + ".fr.s"
    cmd = [RUNG[ver], "-quiet", "-O2", "-G0", "-mgas", *extra, ifile, "-o", s]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode:
        return "ERR " + (r.stdout + r.stderr)[-300:]
    txt = open(s, errors="replace").read()
    m = re.search(r"^%s:\n\t\.frame\t([^\n]*)\n" % re.escape(fn), txt, re.M)
    if not m:
        return "NOFN"
    return m.group(1).strip()


if __name__ == "__main__":
    ifile, fn = sys.argv[1], sys.argv[2]
    ver = sys.argv[3] if len(sys.argv) > 3 else "2.7.2"
    print(frame(ifile, fn, ver, sys.argv[4:]))
