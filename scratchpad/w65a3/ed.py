"""w65a3 line-ending-safe exact replace.

usage: python ed.py <file> <oldfile> <newfile>
Both old/new are read as text with newlines preserved; the search is done on a
newline-normalised view and mapped back to bytes so a MIXED-EOL TU (fedialog.cpp
is 925 CRLF / 125 bare LF) is never rewritten wholesale.  Asserts exactly one
occurrence and that the file size changed as expected.
"""
import re
import sys
from pathlib import Path


def main():
    tgt, oldp, newp = (Path(a) for a in sys.argv[1:4])
    data = tgt.read_bytes()
    old = oldp.read_bytes().replace(b'\r\n', b'\n')
    new = newp.read_bytes().replace(b'\r\n', b'\n')
    # strip one trailing newline the editor may have added
    if old.endswith(b'\n'):
        old = old[:-1]
    if new.endswith(b'\n'):
        new = new[:-1]
    pat = re.compile(b'\r?\n'.join(re.escape(l) for l in old.split(b'\n')))
    hits = pat.findall(data)
    assert len(hits) == 1, f'{len(hits)} occurrences, need exactly 1'
    # rebuild `new` with the SAME per-line endings the matched region used
    m = pat.search(data)
    eols = re.findall(b'\r?\n', m.group(0))
    nl = new.split(b'\n')
    out = nl[0]
    for i, seg in enumerate(nl[1:]):
        out += (eols[i] if i < len(eols) else (eols[-1] if eols else b'\n')) + seg
    res = data[:m.start()] + out + data[m.end():]
    assert res != data
    tmp = tgt.with_suffix(tgt.suffix + '.w65a3tmp')
    tmp.write_bytes(res)
    assert tmp.stat().st_size == len(res) and len(res) > 0
    import os
    os.replace(tmp, tgt)
    d = tgt.read_bytes()
    print(f'OK {tgt}  {len(data)} -> {len(d)} bytes; '
          f'CRLF {d.count(chr(13).encode()+chr(10).encode())} '
          f'LF {d.count(chr(10).encode())} NUL {d.count(bytes([0]))}')


main()
