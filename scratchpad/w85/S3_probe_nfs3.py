"""S3 probe: swap the NFS3_CheckForFileOperations body for a variant, gate, restore.

usage: python scratchpad/w85/S3_probe_nfs3.py <variantfile>   (or 'restore')
The body region is delimited by the two sentinels below, which are the exact
first/last lines of the current function body in recon/game/common/nfs3.cpp.
"""
import subprocess, sys, re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TGT = ROOT / 'recon' / 'game' / 'common' / 'nfs3.cpp'
ORIG = ROOT / 'scratchpad' / 'w85' / 'S3_nfs3_orig.cpp'

BEG = "  int *p;\n"
END = "  return;\n}\n\n\n\n/* ---- main"


def body_span(text):
    i = text.index(BEG)
    j = text.index(END, i)
    return i, j


def main():
    orig = ORIG.read_text(encoding='utf-8', newline='') if False else ORIG.read_text(encoding='utf-8')
    if sys.argv[1] == 'restore':
        TGT.write_text(orig, encoding='utf-8', newline='')
        print('restored')
        return
    var = Path(sys.argv[1]).read_text(encoding='utf-8')
    i, j = body_span(orig)
    new = orig[:i] + var + orig[j:]
    TGT.write_text(new, encoding='utf-8', newline='')
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'verify_asm.py'),
                        'recon/game/common/nfs3.cpp', 'NFS3_CheckForFileOperations__Fv'],
                       cwd=str(ROOT), capture_output=True, text=True)
    out = (r.stdout + r.stderr).strip()
    print(out[-3000:])


main()
