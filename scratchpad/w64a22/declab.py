"""W64-A22 MISSION A/1 -- THE 13A DECL-ORDER SCOPE EXPERIMENT.

Question under adjudication
---------------------------
catalog 13A: "BOTH allocator layers tie-break by NUMBER (qty = block birth order,
allocno = pseudo = DECLARATION ORDER) so the decl dial reaches the ALLOCATOR too."
W41 + tenchu cookbook 3.9: "pseudo numbers follow FIRST-USE order, NOT declaration
order; reordering scalar local declarations is a no-op (contrast address-taken /
stack locals, whose declaration order DOES fix slot order)."

The discriminating design
-------------------------
Permute ONLY the declaration order.  Hold FIRST-USE order fixed (every variable is
assigned from a distinct global in a fixed statement order) and hold REF COUNTS
fixed (each variable gets a distinct, permutation-invariant number of uses so it
is identifiable in the .lreg dump WITHOUT names).  Then read:
  * the PSEUDO NUMBER each variable got            (.lreg "Register N used R times")
  * the HARD REG each variable got                 (.lreg ";; Register N in H." /
                                                    .greg "Register dispositions")
  * the whole emitted .s                           (byte compare)

Four probes, each permuted:
  P1 SCALAR-REG-GLOBAL : call-crossing scalars  -> global allocnos
  P2 SCALAR-REG-LOCAL  : straight-line, no call -> local-alloc qtys
  P3 SCALAR-INIT       : decl-WITH-initializer  (decl order == first-use order)
  P4 ADDR-TAKEN        : &x escapes -> memory locals (frame slot order)

Both lanes: CC1PLPSX (2.8.0, C++ lane, -fno-exceptions -fno-rtti per 12H) and
CC1PSX 2.7.2 (the cc1_272 lane recipe: -O2 -G0 -mgas).
"""
import os
import re
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
WORK = os.path.join(tempfile.gettempdir(), "w64a22_declab")
os.makedirs(WORK, exist_ok=True)

CC1PL = r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"
CC1_272 = r"C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE"
CC1_280 = r"C:/Temp/psq43/COMPILER/CC1PSX.EXE"
LADDER = {"c281": r"C:/Temp/windows-gcc-psx/gcc-2.8.1-psx/cc1.exe",
          "c272b": r"C:/Temp/windows-gcc-psx/gcc-2.7.2-970404-psx/cc1.exe",
          "c280b": r"C:/Temp/windows-gcc-psx/gcc-2.8.0-psx/cc1.exe"}

# variable name -> number of EXTRA uses (so ref counts are distinct + invariant)
VARS = ["a", "b", "c", "d", "e"]
USES = {"a": 1, "b": 2, "c": 3, "d": 5, "e": 8}


def gen(kind, order):
    """order = permutation of VARS controlling DECLARATION order only."""
    L = []
    L.append("int G0,G1,G2,G3,G4;")
    L.append("int sink(int);")
    L.append("int sinkp(int*);")
    L.append("")
    if kind in ("glob", "loc"):
        L.append("int f(int p) {")
        for v in order:
            L.append("  int %s;" % v)
        # FIRST-USE order fixed = a,b,c,d,e regardless of decl order
        for i, v in enumerate(VARS):
            L.append("  %s = G%d + p;" % (v, i))
    elif kind == "init":
        L.append("int f(int p) {")
        # decl-with-init: decl order IS first-use order (the coupled axis)
        for v in order:
            L.append("  int %s = G%d + p;" % (v, VARS.index(v)))
    elif kind == "addr":
        L.append("int f(int p) {")
        for v in order:
            L.append("  int %s;" % v)
        for i, v in enumerate(VARS):
            L.append("  %s = G%d + p;" % (v, i))
        for v in VARS:
            L.append("  sinkp(&%s);" % v)
    # interleave so live ranges overlap (a real coloring contest)
    inter = []
    n = max(USES.values())
    for k in range(n):
        for v in VARS:
            if USES[v] > k:
                inter.append("  p += %s;" % v if kind == "loc"
                             else "  p += sink(%s);" % v)
    L += inter
    L.append("  return p + %s;" % " + ".join(VARS))
    L.append("}")
    return "\n".join(L) + "\n"


def compile_dump(src_text, lane, tag):
    d = os.path.join(WORK, tag)
    os.makedirs(d, exist_ok=True)
    i_file = os.path.join(d, "lab.i")
    open(i_file, "w").write(src_text)
    for ext in (".lreg", ".greg"):
        try:
            os.remove(i_file + ext)
        except OSError:
            pass
    s_file = os.path.join(d, "lab.s")
    if lane == "cpp":
        cmd = [CC1PL, "-quiet", "-O2", "-G4", "-fno-exceptions", "-fno-rtti",
               "-dl", "-dg", i_file, "-o", s_file]
    elif lane == "c272":
        cmd = [CC1_272, "-quiet", "-O2", "-G0", "-mgas", "-dl", "-dg",
               i_file, "-o", s_file]
    elif lane in LADDER:
        cmd = [LADDER[lane], "-quiet", "-O2", "-G4", "-dl", "-dg", i_file,
               "-o", s_file]
    else:
        cmd = [CC1_280, "-quiet", "-O2", "-G4", "-dl", "-dg", i_file,
               "-o", s_file]
    r = subprocess.run(cmd, capture_output=True, text=True, cwd=d)
    lreg = _read(i_file + ".lreg")
    greg = _read(i_file + ".greg")
    return _read(s_file), lreg, greg, (r.stdout + r.stderr)


def _read(p):
    try:
        return open(p, errors="replace").read()
    except OSError:
        return ""


NAME = ['zero', 'at', 'v0', 'v1', 'a0', 'a1', 'a2', 'a3', 't0', 't1', 't2',
        't3', 't4', 't5', 't6', 't7', 's0', 's1', 's2', 's3', 's4', 's5',
        's6', 's7', 't8', 't9', 'k0', 'k1', 'gp', 'sp', 'fp', 'ra']


def parse(lreg, greg):
    """-> {pseudo: (refs, live, block)}, {pseudo: hardreg}"""
    regs = {}
    for m in re.finditer(r"Register (\d+) used (\d+) times across (\d+) insns"
                         r"(?: in block (\d+))?;([^\n]*)", lreg):
        regs[int(m.group(1))] = (int(m.group(2)), int(m.group(3)),
                                 m.group(4), m.group(5).strip())
    home = {}
    for m in re.finditer(r"Register (\d+) in (\d+)\.", lreg):
        home[int(m.group(1))] = int(m.group(2))
    if "Register dispositions" in greg:
        for m in re.finditer(r"(\d+) in (\d+)",
                             greg.split("Register dispositions:")[-1]):
            home[int(m.group(1))] = int(m.group(2))
    return regs, home
