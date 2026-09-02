#!/usr/bin/env python3
"""D2_vd.py FILE PATCHFILE VARIANTLABEL FN -- apply one variant, show verify_asm's
diff for FN, restore."""
import subprocess, sys, ast
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent.parent
rel = sys.argv[1].replace('\\', '/')
variants = ast.literal_eval(Path(sys.argv[2]).read_text(encoding='utf-8'))
label = sys.argv[3]
fn = sys.argv[4]
path = ROOT / rel
orig = path.read_bytes()
crlf = b'\r\n' in orig
src = orig.decode('utf-8', 'surrogateescape')
if crlf:
    src = src.replace('\r\n', '\n')
try:
    for lbl, pairs in variants:
        if lbl != label:
            continue
        t = src
        for old, new in pairs:
            assert t.count(old) == 1, old[:60]
            t = t.replace(old, new)
        w = t.replace('\n', '\r\n') if crlf else t
        path.write_bytes(w.encode('utf-8', 'surrogateescape'))
        r = subprocess.run([sys.executable, 'tools/verify_asm.py', rel, fn],
                           capture_output=True, text=True, cwd=str(ROOT))
        print(r.stdout[-6000:]); print(r.stderr[-2000:])
finally:
    path.write_bytes(orig)
