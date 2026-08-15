#!/usr/bin/env python3
"""ed.py OLD NEW [--file F] -- byte-level single-match replace, LF/CRLF preserving.

OLD/NEW are read from FILES (never argv) so no shell/heredoc escape ever touches
them (12K hazard).  Asserts exactly one match BEFORE writing and asserts the
file grew/shrank by the expected delta.
"""
import os
import sys

f = sys.argv[3] if len(sys.argv) > 3 else 'recon/syslib/psx/libcd/drv.c'
old = open(sys.argv[1], 'rb').read()
new = open(sys.argv[2], 'rb').read()
d = open(f, 'rb').read()
n = d.count(old)
if n != 1:
    sys.exit('MATCH COUNT %d (need 1) for %s' % (n, sys.argv[1]))
out = d.replace(old, new)
assert len(out) == len(d) - len(old) + len(new)
crlf_before = d.count(b'\r\n')
tmp = f + '.tmp'
open(tmp, 'wb').write(out)
os.replace(tmp, f)
chk = open(f, 'rb').read()
assert chk == out, 'write-back mismatch'
print('OK  %d -> %d bytes, CRLF %d -> %d' % (len(d), len(out), crlf_before,
                                             chk.count(b'\r\n')))
