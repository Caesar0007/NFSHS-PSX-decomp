#!/usr/bin/env python3
"""mkprobe.py <rows.py-fragment-file> -- build scratchpad/w65a1/build_probe.py =
tools/build.py with the fragment spliced into PER_FN_TEXT_MOVES and ROOT pinned.
NEVER touches tools/build.py (orchestrator-owned)."""
import ast
import pathlib
import sys

ROOT = pathlib.Path(r'C:\Temp\nfs4-decomp')
frag = pathlib.Path(sys.argv[1]).read_text()
b = (ROOT / 'tools' / 'build.py').read_text()
old = 'PER_FN_TEXT_MOVES = {\n'
assert b.count(old) == 1
b = b.replace(old, old + frag)
lines = b.splitlines(True)
for i, l in enumerate(lines):
    if l.startswith('ROOT ='):
        lines[i] = ("ROOT = pathlib_Path_probe('C:/Temp/nfs4-decomp')\n"
                    "import sys as _sys; _sys.path.insert(0, str(ROOT / 'tools'))\n")
        break
b = ''.join(lines).replace('pathlib_Path_probe', 'Path')
ast.parse(b)
out = ROOT / 'scratchpad' / 'w65a1' / 'build_probe.py'
out.write_text(b)
print('wrote', out, len(b), 'bytes')
