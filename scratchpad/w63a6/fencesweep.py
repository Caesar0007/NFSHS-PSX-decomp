"""w63a6 generic VOID-BARRIER position sweeper (the W45 fence-fixpoint law made mechanical).

Inserts a zero-insn `__asm__("" : : "i"(0));` before each candidate statement line inside
one function's body and gates the function, printing the whole position/score curve.
POSITION is the dial, so this replaces hand-probing.

Usage:  python scratchpad/w63a6/fencesweep.py <tu-rel> <FUNC> <start-marker> <end-marker>
The TU is patched in place and ALWAYS restored in `finally` (PER_TU_FLAGS is path-keyed,
so a renamed copy would measure the wrong lane).
"""
import os, re, subprocess, sys

ROOT = r"C:\Temp\nfs4-decomp"
VOID = '__asm__("" : : "i"(0));'


def gate(turel, fn):
    p = subprocess.run([sys.executable, "tools/verify_asm.py", turel, fn],
                       cwd=ROOT, capture_output=True, text=True, timeout=900)
    out = p.stdout + p.stderr
    for line in out.splitlines():
        if line.strip().startswith(fn + ":"):
            return line.strip()
    return (out.strip().splitlines() or ["NO OUTPUT"])[-1]


def main():
    turel, fn, start, end = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
    tu = os.path.join(ROOT, turel.replace("/", os.sep))
    base = open(tu, "rb").read()
    i = base.find(start.encode("ascii"))
    assert i >= 0, "start marker not found"
    j = base.find(end.encode("ascii"), i)
    assert j > i, "end marker not found"
    body = base[i:j]
    # candidate insertion points: the start of every line that begins a statement
    cands = []
    for m in re.finditer(rb"\r?\n([ \t]+)(?![ \t]*[*}/#])[A-Za-z_*(]", body):
        off = m.start(1)
        indent = m.group(1)
        cands.append((off, indent))
    print("baseline  %s   (%d candidate positions)" % (gate(turel, fn), len(cands)), flush=True)
    try:
        for n, (off, indent) in enumerate(cands):
            ins = indent + VOID.encode("ascii") + b"\n" + indent
            new = base[: i + off] + ins + base[i + off + len(indent):]
            tmp = tu + ".tmp"
            open(tmp, "wb").write(new)
            assert os.path.getsize(tmp) > len(base) - 10
            os.replace(tmp, tu)
            ctx = body[off: off + 60].split(b"\n")[0].decode("ascii", "replace").strip()
            print("%3d  %-46s  %s" % (n, gate(turel, fn), ctx[:52]), flush=True)
    finally:
        open(tu, "wb").write(base)
        print("restored", os.path.getsize(tu))


main()
