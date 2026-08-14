#!/usr/bin/env python3
"""w60a8 blockmove: byte-exact move of a text block within a file.

usage: blockmove.py FILE START_MARK END_MARK BEFORE_MARK
  moves the byte range [find(START_MARK), find(END_MARK)+len(END_MARK)) so that it
  sits immediately before the first occurrence of BEFORE_MARK.
All marks must be UNIQUE in the file. Line endings are preserved byte-for-byte.
"""
import os, sys

path, start_m, end_m, before_m = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
data = open(path, 'rb').read()
orig_len = len(data)


def uniq(m):
    b = m.encode('utf-8')
    n = data.count(b)
    if n != 1:
        sys.exit(f"MARK NOT UNIQUE ({n}): {m!r}")
    return data.index(b), b


s, _ = uniq(start_m)
e, eb = uniq(end_m)
e += len(eb)
b, _ = uniq(before_m)
if not (s < e):
    sys.exit("bad range")
if b >= s and b < e:
    sys.exit("target inside the moved range")
block = data[s:e]
rest = data[:s] + data[e:]
# recompute the insertion point in `rest`
ib = rest.index(before_m.encode('utf-8'))
out = rest[:ib] + block + rest[ib:]
assert len(out) == orig_len, (len(out), orig_len)
tmp = path + '.w60a8tmp'
with open(tmp, 'wb') as f:
    f.write(out)
os.replace(tmp, path)
print(f"moved {len(block)} bytes; file size unchanged ({orig_len})")
