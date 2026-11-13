#!/usr/bin/env python3
"""Global-type audit (docs/HEADER_TRUTH_PLAN.md, phase 7).

The retail SYM records the type of every global (`Def`/`Def2 class EXT ... name X`).  This tool compares every
`extern` declaration in recon/{game,frontend,shared} against it.

  python tools/global_type_audit.py            # summary + build/tmp/global_type_audit.json
  python tools/global_type_audit.py NAME ...   # retail type and every declaration of NAME

Findings:
  VIEW      retail type is a struct/union/enum, the tree declares another type (int/char array, other tag)
  SCALAR    both are scalars/pointers but base type or pointer depth differs
  SHAPE     same base type, different array shape (unsized `[]` is accepted)
"""
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SYM = Path('C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt')
DIRS = ['recon/game', 'recon/frontend', 'recon/shared']
OUT = ROOT / 'build' / 'tmp' / 'global_type_audit.json'

BASE = {'CHAR': 'char', 'UCHAR': 'unsigned char', 'SHORT': 'short', 'USHORT': 'unsigned short', 'INT': 'int',
        'UINT': 'unsigned int', 'LONG': 'long', 'ULONG': 'unsigned long', 'VOID': 'void', 'FLOAT': 'float',
        'DOUBLE': 'double', 'BOOL': 'unsigned char', 'STRUCT': 'struct', 'UNION': 'union', 'ENUM': 'enum', 'NULL': 'int'}
ALIAS = {'u_char': 'unsigned char', 'u_short': 'unsigned short', 'u_long': 'unsigned long', 'u_int': 'unsigned int',
         'uchar': 'unsigned char', 'ushort': 'unsigned short', 'ulong': 'unsigned long', 'uint': 'unsigned int',
         'byte': 'unsigned char', 'bool': 'unsigned char', 'BOOL': 'int', 'size_t': 'unsigned int',
         'signed char': 'char'}
REC = re.compile(r'Def2? class (EXT|STAT) type ((?:[A-Z]+ )+)size (\d+)(?: dims (\d+)((?: \d+)*))?(?: tag (\S+))? name (\S+)')


def retail_globals():
    out = {}
    for line in SYM.read_text(encoding='latin-1').splitlines():
        m = REC.search(line)
        if not m or m.group(1) != 'EXT':
            continue
        words = m.group(2).split()
        if 'FCN' in words:
            continue
        base = words[-1]
        ptr = words.count('PTR')
        dims = [int(x) for x in (m.group(5) or '').split()]
        tag = m.group(6)
        btxt = tag if base in ('STRUCT', 'UNION', 'ENUM') and tag else BASE.get(base, base.lower())
        out[m.group(7)] = {'base': btxt, 'agg': base in ('STRUCT', 'UNION', 'ENUM'), 'ptr': ptr, 'dims': dims,
                           'size': int(m.group(3))}
    return out


DECL = re.compile(r'^\s*extern\s+(?!"C")((?:const\s+|volatile\s+|struct\s+|unsigned\s+|signed\s+)*[A-Za-z_]\w*(?:\s+(?:int|char|short|long))*)'
                  r'\s*((?:\*\s*(?:const\s+)?)*)\s*([A-Za-z_]\w*)\s*((?:\[[^\]]*\])*)\s*(?:(?:__asm__|asm)\s*\("[^"]*"\))?\s*;', re.M)


def norm_base(t):
    t = re.sub(r'\b(const|volatile|struct|extern)\b', '', t)
    t = re.sub(r'\s+', ' ', t).strip()
    t = ALIAS.get(t, t)
    if t in ('unsigned', 'signed'):
        t += ' int'
    if t == 'signed int':
        t = 'int'
    return t


def tree_externs():
    out = defaultdict(list)
    for d in DIRS:
        for p in list((ROOT / d).rglob('*.h')) + list((ROOT / d).rglob('*.cpp')) + list((ROOT / d).rglob('*.c')):
            s = re.sub(r'/\*.*?\*/', '', p.read_text(encoding='latin-1'), flags=re.S)
            for m in DECL.finditer(s):
                dims = re.findall(r'\[([^\]]*)\]', m.group(4))
                out[m.group(3)].append({'base': norm_base(m.group(1)), 'ptr': m.group(2).count('*'),
                                        'dims': [x.strip() for x in dims], 'file': p.relative_to(ROOT).as_posix()})
    return out


def dims_ok(tree, retail):
    if len(tree) != len(retail):
        return False
    for t, r in zip(tree, retail):
        if t == '':
            continue
        try:
            if int(t, 0) != r:
                return False
        except ValueError:
            continue    # a macro or expression: not checked
    return True


def main():
    retail = retail_globals()
    tree = tree_externs()
    if len(sys.argv) > 1 and not sys.argv[1].startswith('-'):
        for n in sys.argv[1:]:
            print(n, '| retail:', retail.get(n))
            for d in tree.get(n, []):
                print('   %s %s%s  %s' % (d['base'], '*' * d['ptr'], ''.join('[%s]' % x for x in d['dims']), d['file']))
        return
    find = defaultdict(list)
    checked = 0
    for name, ds in sorted(tree.items()):
        r = retail.get(name)
        if not r:
            continue
        for d in ds:
            checked += 1
            row = [name, d['file'], '%s %s%s' % (d['base'], '*' * d['ptr'], ''.join('[%s]' % x for x in d['dims'])),
                   '%s %s%s' % (r['base'], '*' * r['ptr'], ''.join('[%d]' % x for x in r['dims']))]
            if d['base'] != r['base'] or d['ptr'] != r['ptr']:
                find['VIEW' if r['agg'] else 'SCALAR'].append(row)
            elif not dims_ok(d['dims'], r['dims']):
                find['SHAPE'].append(row)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(find, indent=1), encoding='utf-8')
    print('retail globals with a recorded type: %d | extern declarations checked: %d (%d names)'
          % (len(retail), checked, sum(1 for n in tree if n in retail)))
    for k in ('VIEW', 'SCALAR', 'SHAPE'):
        print('%-7s %4d declarations, %4d globals' % (k, len(find[k]), len({x[0] for x in find[k]})))
    print('report: %s' % OUT.relative_to(ROOT).as_posix())


if __name__ == '__main__':
    main()
