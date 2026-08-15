#!/usr/bin/env python3
"""ed.py -- byte-exact CRLF-safe replace with a match-count assert (12K rule).

usage: python ed.py <file> <oldfile> <newfile> [expected_count]
The old/new payloads are read as BYTES from files so no shell/heredoc escaping
is involved.  Refuses to write unless the count matches.
"""
import os
import sys

f, oldf, newf = sys.argv[1], sys.argv[2], sys.argv[3]
exp = int(sys.argv[4]) if len(sys.argv) > 4 else 1
data = open(f, 'rb').read()
old = open(oldf, 'rb').read()
new = open(newf, 'rb').read()
n = data.count(old)
if n != exp:
    sys.exit("MATCH COUNT %d != expected %d -- NOT WRITING" % (n, exp))
out = data.replace(old, new)
assert out != data, "replacement produced identical bytes"
tmp = f + '.tmp'
open(tmp, 'wb').write(out)
os.replace(tmp, f)
print("ok: %d replacement(s), %d -> %d bytes" % (n, len(data), len(out)))
