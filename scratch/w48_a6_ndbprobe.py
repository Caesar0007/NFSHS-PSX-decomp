"""w48-a6: per-fn -fno-delayed-branch splice probe (patch-in-place, MEASURE, REVERT).

Adds entries to build.py's PER_FN_NO_DELAYED_BRANCH, gates the whole TU, restores.
"""
import sys, io, re, subprocess, os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUILD = os.path.join(ROOT, "tools", "build.py")
ANCHOR = "PER_FN_NO_DELAYED_BRANCH = {\n"

# TU -> (all fns to gate, fns to splice)
CASES = [
    ("recon/syslib/psx/libcd/stream.c",
     "StClearRing,StSetStream,StSetRing", ["StSetRing"]),
    ("recon/syslib/psx/libcd/streamhelp.c",
     "StUnSetRing,StGetNext,StFreeRing,data_ready_callback,StSetMask,init_ring_status",
     ["data_ready_callback"]),
    ("recon/syslib/psx/libcd/streamhelp.c",
     "StUnSetRing,StGetNext,StFreeRing,data_ready_callback,StSetMask,init_ring_status",
     ["StSetMask"]),
]


def gate(path, fns):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", path, fns],
                       capture_output=True, text=True, cwd=ROOT, timeout=1200)
    out = r.stdout + r.stderr
    res = {}
    for m in re.finditer(r'^\s+(\S+): (PASS|FAIL (\d+) diffs|NO ORACLE|NOT IN OBJECT)', out, re.M):
        res[m.group(1)] = 0 if m.group(2) == 'PASS' else (int(m.group(3)) if m.group(3) else None)
    return res, out


def main():
    with io.open(BUILD, 'r', newline='') as f:
        orig = f.read()
    assert orig.count(ANCHOR.replace('\n', '')) >= 1
    nl = '\r\n' if orig.count('\r\n') > 5 else '\n'
    anchor = ANCHOR.replace('\n', nl)
    assert orig.count(anchor) == 1, orig.count(anchor)
    try:
        for path, allfns, splice in CASES:
            before, _ = gate(path, allfns)
            inject = "".join(
                '    "%s": {%s},%s' % (path, ", ".join('"%s"' % n for n in splice), nl))
            with io.open(BUILD, 'w', newline='') as f:
                f.write(orig.replace(anchor, anchor + inject))
            after, out = gate(path, allfns)
            print("=== %s  splice=%s" % (path, splice))
            for k in sorted(set(before) | set(after)):
                b, a = before.get(k), after.get(k)
                mark = "" if b == a else ("  <== BETTER" if (a is not None and b is not None and a < b) else "  <== WORSE")
                print("   %-24s %s -> %s%s" % (k, b, a, mark))
            with io.open(BUILD, 'w', newline='') as f:
                f.write(orig)
    finally:
        with io.open(BUILD, 'w', newline='') as f:
            f.write(orig)
        print("build.py restored (%d bytes)" % len(orig))


main()
