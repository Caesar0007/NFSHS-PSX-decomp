#!/usr/bin/env python
"""CRLF-safe literal replace helper for M7. Usage: M7_ed.py <file> <oldfile> <newfile>"""
import sys
p, oldf, newf = sys.argv[1], sys.argv[2], sys.argv[3]
b = open(p, 'rb').read()
crlf = b.count(b'\r\n')
lf = b.count(b'\n')
old = open(oldf, 'rb').read().replace(b'\r\n', b'\n')
new = open(newf, 'rb').read().replace(b'\r\n', b'\n')
if crlf == lf:
    old = old.replace(b'\n', b'\r\n')
    new = new.replace(b'\n', b'\r\n')
n = b.count(old)
if n != 1:
    sys.exit("MATCHES=%d (need exactly 1)" % n)
b2 = b.replace(old, new)
open(p, 'wb').write(b2)
assert b2.count(b'\r\n') == b2.count(b'\n') if crlf == lf else True
print("OK crlf-regime-intact=%s" % (b2.count(b'\r\n') == b2.count(b'\n')))
