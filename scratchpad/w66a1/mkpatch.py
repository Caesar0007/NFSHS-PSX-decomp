#!/usr/bin/env python3
"""mkpatch.py -- emit scratchpad/w66a1/branch_retarget.patch from mech.py.

The patch is generated FROM the same `patched_source()` the probe harness
executes, so "what I measured" and "what the orchestrator applies" cannot
diverge.  tools/build.py is never written: the diff is taken between two
copies in a temp tree whose paths are `a/tools/build.py` / `b/tools/build.py`,
so `git apply` (p1) lands it on the real file.
"""
import ast, shutil, subprocess, sys, tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
from mech import patched_source, BUILD

out = patched_source()
ast.parse(out)                      # never ship a patch that breaks the parse

with tempfile.TemporaryDirectory() as td:
    td = Path(td)
    for side, text in (('a', BUILD.read_text(newline='')), ('b', out)):
        p = td / side / 'tools'
        p.mkdir(parents=True)
        (p / 'build.py').write_bytes(text.encode())
    r = subprocess.run(['git', '-c', 'core.autocrlf=false', 'diff', '--no-index',
                        '--no-color', '--src-prefix=a/', '--dst-prefix=b/',
                        'a/tools/build.py', 'b/tools/build.py'],
                       cwd=td, capture_output=True)
    diff = r.stdout.decode()
assert diff, 'empty diff'
diff = diff.replace('a/a/tools/build.py', 'a/tools/build.py')
diff = diff.replace('b/b/tools/build.py', 'b/tools/build.py')
(HERE / 'branch_retarget.patch').write_bytes(diff.encode())
print('wrote branch_retarget.patch (%d bytes, %d lines)'
      % (len(diff), diff.count('\n')))
