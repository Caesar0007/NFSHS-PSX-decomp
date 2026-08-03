#!/usr/bin/env python3
"""Apply one variant body, dump our disasm for MCRD_handlecardevents, restore."""
import subprocess, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import a2_probe as pr

def dis(body, grep=None):
    orig = pr.read()
    a, b = pr.bounds(orig)
    try:
        pr.write(orig[:a] + body + orig[b:])
        r = subprocess.run([sys.executable, "tools/ourdis.py",
                            "recon/frontend/psx/memcard.c",
                            "MCRD_handlecardevents"],
                           cwd=pr.ROOT, capture_output=True, text=True)
        return r.stdout
    finally:
        pr.write(orig)

if __name__ == "__main__":
    S, B, T, P, D0, D1 = pr.S, pr.B, pr.T, pr.P, pr.D0, pr.D1
    which = sys.argv[1] if len(sys.argv) > 1 else "base"
    bodies = {
        "base": pr.BASE,
        "span3t": S + D0*3 + T + B + D1*3 + P,
        "span4t": S + D0*4 + T + B + D1*4 + P,
    }
    out = dis(bodies[which])
    lines = out.splitlines()
    # print the window around the 2nd gMemCardInfo lui in the arm
    for i, ln in enumerate(lines):
        if 'sllv' in ln:
            print("\n".join(lines[max(0, i-8):i+16]))
            break
