#!/usr/bin/env python3
"""W64-A3 multi-edit variant prober (libgpu vendor belt).

Spec file defines:
    SRC  = repo-relative source path (default recon/syslib/psx/libgpu/SYS.c)
    FNS  = list of symbols to gate after every variant  (list of str)
    SPEC = [(name, [(old, new), ...]), ...]
Every anchor count is asserted -- a missed replace is FATAL, never a fake "inert".
Restores the file in `finally` and writes a restore log BEFORE any print
(never pipe this script into head/sed: SIGPIPE would skip the restore).

  python scratchpad/w64a3/probe.py <specfile> [only-index]
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
MY = ROOT / "scratchpad/w64a3"
g = {}
exec(open(sys.argv[1]).read(), g)
rel = g.get('SRC', 'recon/syslib/psx/libgpu/SYS.c')
SRCP = ROOT / rel
FNS = g['FNS']
spec = g['SPEC']
sel = int(sys.argv[2]) if len(sys.argv) > 2 else None

orig = SRCP.read_text(encoding="utf-8", newline="")
(MY / "RESTORE.bak").write_text(orig, encoding="utf-8", newline="")
out = []
try:
    for i, (name, edits) in enumerate(spec):
        if sel is not None and i != sel:
            continue
        t = orig
        for old, new in edits:
            assert t.count(old) == 1, "variant %r: anchor count %d for %r" % (
                name, t.count(old), old[:70])
            t = t.replace(old, new)
        assert t != orig, "variant %r: no change" % name
        SRCP.write_text(t, encoding="utf-8", newline="")
        r = subprocess.run([sys.executable, "tools/verify_asm.py", rel,
                            ",".join(FNS)],
                           cwd=ROOT, capture_output=True, text=True)
        rows = []
        for fn in FNS:
            ln = [l for l in r.stdout.splitlines() if l.strip().startswith(fn + ":")]
            rows.append(ln[0].strip() if ln else ("ERR:" + r.stderr.strip()[-60:]))
        line = "%-46s %s" % (name, " | ".join(rows))
        out.append(line)
        print(line)
        sys.stdout.flush()
finally:
    SRCP.write_text(orig, encoding="utf-8", newline="")
    (MY / "last_probe.txt").write_text(
        "\n".join(out) + "\nrestored\n", encoding="utf-8", newline="")
print("restored")
