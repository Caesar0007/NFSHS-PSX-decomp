"""w65a3: apply BASE-SCOPE QUALIFICATION to the wrong-bound member calls the
calltarget audit found.

For each (file, Class::Method, TargetMethod, BaseClass) it locates the DEFINITION
of Class::Method, brace-matches its body, and rewrites `this->TargetMethod(` to
`this->BaseClass::TargetMethod(` inside that body only.  Byte-level, so a mixed
CRLF/LF TU is never normalised.  Asserts exactly one definition and at least one
call site; prints the count per edit.

usage: python qualify.py <spec.tsv>     (file <TAB> Class <TAB> Method <TAB> TargetMethod <TAB> Base)
       python qualify.py <spec.tsv> --dry
"""
import re
import sys
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')


def find_def(txt, cls, meth):
    """Return (start, end) byte offsets of the body of `cls::meth`'s definition."""
    hits = []
    for m in re.finditer(re.escape(f'{cls}::{meth}') + r'\s*\(', txt):
        j = txt.index('(', m.end() - 1)
        depth = 0
        k = j
        while k < len(txt):
            if txt[k] == '(':
                depth += 1
            elif txt[k] == ')':
                depth -= 1
                if depth == 0:
                    break
            k += 1
        rest = txt[k + 1:k + 200]
        if re.match(r'\s*(const\s*)?\{', rest):
            b = txt.index('{', k)
            depth = 0
            e = b
            while e < len(txt):
                if txt[e] == '{':
                    depth += 1
                elif txt[e] == '}':
                    depth -= 1
                    if depth == 0:
                        break
                e += 1
            hits.append((b, e))
    assert len(hits) == 1, f'{cls}::{meth}: {len(hits)} definitions found'
    return hits[0]


def main():
    dry = '--dry' in sys.argv
    spec = [l.split('\t') for l in Path(sys.argv[1]).read_text().split('\n')
            if l.strip() and not l.startswith('#')]
    by_file = {}
    for f, cls, meth, tgt, base in spec:
        by_file.setdefault(f, []).append((cls, meth, tgt, base))
    for f, items in by_file.items():
        p = ROOT / f
        data = p.read_bytes()
        txt = data.decode('latin-1')
        edits = []
        for cls, meth, tgt, base in items:
            b, e = find_def(txt, cls, meth)
            body = txt[b:e]
            needle = f'this->{tgt}('
            n = body.count(needle)
            assert n >= 1, f'{cls}::{meth}: no `{needle}` in body'
            print(f'  {f}  {cls}::{meth}  {needle} x{n} -> this->{base}::{tgt}(')
            for m in re.finditer(re.escape(needle), body):
                edits.append((b + m.start(), b + m.end(), f'this->{base}::{tgt}('))
        if dry:
            continue
        edits.sort(reverse=True)
        for s, e2, rep in edits:
            txt = txt[:s] + rep + txt[e2:]
        out = txt.encode('latin-1')
        assert len(out) > len(data)
        tmp = p.with_suffix(p.suffix + '.w65a3tmp')
        tmp.write_bytes(out)
        import os
        os.replace(tmp, p)
        d = p.read_bytes()
        print(f'OK {f}: {len(data)} -> {len(d)} bytes, {len(edits)} sites, '
              f'NUL {d.count(bytes([0]))}')


main()
