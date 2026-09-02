#!/usr/bin/env python3
"""M1_edit.py OLDFILE  -- CRLF/UTF-8 safe text substitution on FONT.c.
Usage: python M1_edit.py <marker-file>   where marker-file holds
   <<<OLD\n...\n>>>NEW\n...\n<<<END   blocks (LF in the marker file; script
   converts to CRLF before matching).
Simpler: import and call sub(old, new).
"""
import sys
from pathlib import Path

P = Path(__file__).resolve().parents[2] / 'recon/syslib/psx/libgpu/FONT.c'


def read():
    return P.read_bytes().decode('utf-8')


def write(s):
    P.write_bytes(s.encode('utf-8'))


def sub(old, new, count=1):
    s = read()
    old = old.replace('\n', '\r\n')
    new = new.replace('\n', '\r\n')
    if old not in s:
        raise SystemExit('NOT FOUND: ' + repr(old[:120]))
    n = s.count(old)
    if count and n != count:
        raise SystemExit('found %d occurrences, expected %d' % (n, count))
    write(s.replace(old, new))


def restore(src):
    P.write_bytes(Path(src).read_bytes())


if __name__ == '__main__':
    if sys.argv[1] == 'restore':
        restore(sys.argv[2])
        print('restored')
