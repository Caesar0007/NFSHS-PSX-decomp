"""w65a3: extract the SELF-CALL / WRONG-SCOPE rows out of a calltarget dump and
locate each call site in the recon source.

A row qualifies when the METHOD NAME of retail's target equals the method name
of ours -- i.e. the same member function, bound at a different class.  Prints
the file, the enclosing definition, and every `this->Method(` occurrence inside
its body so the base-scope qualification can be applied surgically.
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')


def demangle(sym):
    """`Initialize__12tScreenAudio` -> ('Initialize', 'tScreenAudio')."""
    m = re.match(r'^(.*?)__(\d+)(.*)$', sym)
    if not m:
        return None, None
    meth, n, rest = m.group(1), int(m.group(2)), m.group(3)
    return meth, rest[:n]


def rows(path):
    L = open(path).read().split('\n')
    out, i = [], 1
    while i + 2 < len(L):
        if L[i].startswith('  ') and 'retail calls' in L[i + 1]:
            unit, fn = L[i].strip().split('  ', 1)
            r = L[i + 1].split('retail calls ')[1].split(' @')[0]
            o = L[i + 2].split('ours   calls ')[1].split(' @')[0]
            out.append((unit, fn, r, o))
            i += 3
        else:
            i += 1
    return out


def src_of(unit):
    cfg = json.load(open(ROOT / 'objdiff.json', encoding='utf-8'))
    for u in cfg['units']:
        if u['name'].replace('\\', '/') == unit:
            bp = u['base_path'].replace('\\', '/')
            return bp[len('build/recon/'):-2] if bp.startswith('build/recon/') else bp
    return None


def main():
    todo = []
    for unit, fn, r, o in rows(sys.argv[1]):
        rm, rc = demangle(r)
        om, oc = demangle(o)
        if rm is None or rm != om or rc == oc:
            continue
        cm, cc = demangle(fn)
        todo.append((unit, fn, cc, cm, rm, rc, oc))
    print(f'{len(todo)} same-method-different-class rows\n')
    for unit, fn, cc, cm, meth, base, ours in todo:
        rel = src_of(unit)
        p = ROOT / 'recon' / rel if rel else None
        where = 'SELF' if ours == cc else f'(ours={ours})'
        print(f'{rel}  {cc}::{cm}  ->  want {base}::{meth}  {where}')
        if p and p.exists():
            txt = p.read_text(errors='replace')
            for m in re.finditer(re.escape(f'this->{meth}('), txt):
                ln = txt.count('\n', 0, m.start()) + 1
                print(f'      line {ln}: {txt[m.start():m.start()+60].splitlines()[0]}')


main()
