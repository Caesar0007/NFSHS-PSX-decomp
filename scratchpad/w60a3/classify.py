#!/usr/bin/env python3
"""Classify a function's residual using the GATE'S OWN normalized streams.

Reuses gatecmp.py's substitution trick to get verify_asm's `ours()`/`oracle()`
out of its own source, then buckets every mismatched position:

  * v0<->v1 role swap only
  * that swap plus a commutative-operand flip
  * everything else (printed)

  GATE_OBJ=<obj> python classify.py <recon-path> <FUNC>
"""
import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
VA = ROOT / "tools" / "verify_asm.py"
src = VA.read_text()
m = re.search(
    r"# compile via build\.py's compile_cpp\n"
    r"import importlib\.util\n"
    r"spec = .*?\n"
    r"bld = .*?\n"
    r"bld\.OUT = bld\.BUILD\n"
    r"obj = .*?\n", src)
if not m:
    sys.exit("classify: verify_asm.py's compile block changed shape")
src = src[:m.start()] + "obj = Path(os.environ['GATE_OBJ'])\n" + src[m.end():]
# keep everything up to the reporting loop; we want the helpers, not the print
cut = src.index("allpass=True")
g = {"__name__": "__classify__", "__file__": str(VA)}
sys.argv = [str(VA), sys.argv[1], sys.argv[2]]
exec(compile(src[:cut], str(VA), "exec"), g)

fn = sys.argv[2]
o, e = g["ours"](fn), g["oracle"](fn)
print("%s: ours=%d oracle=%d" % (fn, len(o), len(e)))
if len(o) != len(e):
    sys.exit("count differs -- positional classification would be meaningless")

SWAP = re.compile(r"\bv([01])\b")
COMM = re.compile(r"^(or|addu|and|xor|nor|slt|sltu) (\w+),(\w+),(\w+)$")


def swap(t):
    return SWAP.sub(lambda m: "v" + ("1" if m.group(1) == "0" else "0"), t)


def comm(t):
    m = COMM.match(t)
    return "%s %s,%s,%s" % (m.group(1), m.group(2), m.group(4), m.group(3)) if m else t


mis = [i for i in range(len(o)) if o[i] != e[i]]
a = [i for i in mis if swap(o[i]) == e[i]]
b = [i for i in mis if i not in a and (comm(swap(o[i])) == e[i] or swap(comm(o[i])) == e[i])]
c = [i for i in mis if i not in a and i not in b]
print("  mismatched positions        : %d" % len(mis))
print("  v0<->v1 role swap ONLY      : %d" % len(a))
print("  swap + commutative flip     : %d" % len(b))
print("  everything else             : %d" % len(c))
for i in c:
    print("    %4d  %-34s | %s" % (i, o[i], e[i]))
