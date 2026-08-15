#!/usr/bin/env python3
"""mkprobe.py <fragment.py> -- build scratchpad/w65a1/build_probe.py =
tools/build.py with the fragment appended as EXECUTABLE statements right before
`def _apply_text_moves(` (so it can MERGE into TU keys the real table already
has -- a second dict-literal entry for the same TU would be silently dropped).
NEVER touches tools/build.py (orchestrator-owned)."""
import ast
import pathlib
import sys

ROOT = pathlib.Path(r'C:\Temp\nfs4-decomp')
frag = pathlib.Path(sys.argv[1]).read_text()
b = (ROOT / 'tools' / 'build.py').read_text()
anchor = 'def _apply_text_moves('
assert b.count(anchor) == 1
b = b.replace(anchor, frag + '\n\n' + anchor)
lines = b.splitlines(True)
for i, l in enumerate(lines):
    if l.startswith('ROOT ='):
        lines[i] = ("ROOT = Path('C:/Temp/nfs4-decomp')\n"
                    "import sys as _sys; _sys.path.insert(0, str(ROOT / 'tools'))\n")
        break
b = ''.join(lines)
ast.parse(b)
out = ROOT / 'scratchpad' / 'w65a1' / 'build_probe.py'
out.write_text(b)
print('wrote', out, len(b), 'bytes')
