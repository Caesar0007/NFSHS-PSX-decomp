#!/usr/bin/env python3
"""W67-A2: xenogears setIntr body + per-fn (2.7.2 | extra-flags) splice ladder.
Uses the w63a8 verflag harness (in-memory patch; build.py never edited).
Restores INTR.c in finally."""
import subprocess, sys, os, shutil, json

REPO = r'C:\Temp\nfs4-decomp'
SRC = os.path.join(REPO, r'recon\syslib\psx\libetc\INTR.c')
sys.path.insert(0, os.path.join(REPO, 'scratchpad', 'w67a2'))
from probe_setintr import NEW_BODY  # reuse the body text

CELLS = [
    "2.7.2",                                    # control (should be 12)
    "2.7.2|-fpeephole",
    "2.7.2|-ffunction-cse",
    "2.7.2|-fpcc-struct-return",
    "2.7.2|-mips1|-mcpu=3000",
    "2.7.2|-msoft-float",
    "2.7.2|-G8",
    "2.7.2|-mips1|-mcpu=3000|-funsigned-char|-fpeephole|-ffunction-cse|-fpcc-struct-return|-fcommon|-msoft-float",
]

def main():
    src = open(SRC, 'r', encoding='utf-8', newline='').read()
    start_anchor = 'extern int _set_intr_callback(unsigned int idx, int handler)   /* @0x800F2C10 */'
    end_anchor = '\nextern IntrState *StopCallback(void)   /* @0x800F2D58 */'
    assert src.count(start_anchor) == 1 and src.count(end_anchor) == 1
    i = src.index(start_anchor); j = src.index(end_anchor)
    orig_bytes = open(SRC, 'rb').read()
    shutil.copyfile(SRC, os.path.join(REPO, r'scratchpad\w67a2\INTR.c.flagprobe.bak'))
    try:
        with open(SRC, 'w', encoding='utf-8', newline='') as f:
            f.write(src[:i] + NEW_BODY + src[j:])
        for cell in CELLS:
            env = dict(os.environ, VA_MAX='6',
                       W63A8_VERFLAG=json.dumps(
                           {"recon/syslib/psx/libetc/INTR.c": {cell: ["_set_intr_callback"]}}))
            r = subprocess.run([sys.executable, r'scratchpad\w63a8\w63a8_verflag.py',
                                r'recon/syslib/psx/libetc/INTR.c', '_set_intr_callback'],
                               capture_output=True, text=True, cwd=REPO, env=env)
            out = (r.stdout + r.stderr).strip().splitlines()
            head = next((l for l in out if '_set_intr_callback' in l), '??')
            print('%-100s %s' % (cell, head.strip()))
    finally:
        with open(SRC, 'wb') as f:
            f.write(orig_bytes)
        assert open(SRC, 'rb').read() == orig_bytes
        print('[restored]')

if __name__ == '__main__':
    main()
