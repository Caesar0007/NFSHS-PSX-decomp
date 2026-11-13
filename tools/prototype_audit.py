#!/usr/bin/env python3
"""Prototype audit (docs/HEADER_TRUTH_PLAN.md, phase 6).

The retail link map names every C++ function with its g++ 2.x mangled name, and a mangled name encodes the
exact parameter types.  This tool demangles those names and compares every free-function prototype declared in
recon/{game,frontend,shared} headers against them.

  python tools/prototype_audit.py            # summary + build/tmp/prototype_audit.json
  python tools/prototype_audit.py NAME ...   # show retail signatures and every declaration of NAME

Findings:
  VARIADIC   declared `(...)` although retail has typed C++ signatures
  ARITY      declared parameter count matches no retail overload
  KIND       same count, but a pointer/reference is declared where retail has a scalar (or the reverse)
  CONFLICT   the tree declares the function with several different parameter lists and retail has fewer overloads
"""
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MAP = Path('C:/Temp/nfs4iso/NFS4.MAP')
DIRS = ['recon/game', 'recon/frontend', 'recon/shared']
OUT = ROOT / 'build' / 'tmp' / 'prototype_audit.json'

BASIC = {'v': 'void', 'i': 'int', 'c': 'char', 's': 'short', 'l': 'long', 'x': 'long long', 'f': 'float',
         'd': 'double', 'b': 'bool', 'w': 'wchar_t', 'e': '...', 'r': 'long double'}


class Bad(Exception):
    pass


def parse_type(s, i, args):
    """Parse one g++ 2.x mangled type at s[i]; return (text, next_index)."""
    mods = []
    while i < len(s) and s[i] in 'UCSV':
        mods.append({'U': 'unsigned', 'C': 'const', 'S': 'signed', 'V': 'volatile'}[s[i]])
        i += 1
    if i >= len(s):
        raise Bad(s)
    ch = s[i]
    pre = (' '.join(mods) + ' ') if mods else ''
    if ch in 'PR':
        t, i = parse_type(s, i + 1, args)
        return pre + t + ('*' if ch == 'P' else '&'), i
    if ch == 'A':
        m = re.match(r'A(\d+)_', s[i:])
        if not m:
            raise Bad(s)
        t, i = parse_type(s, i + m.end(), args)
        return pre + t + '[%d]' % (int(m.group(1)) + 1), i
    if ch == 'F':
        i += 1
        sub = []
        while i < len(s) and s[i] != '_':
            i = parse_arg(s, i, sub)
        if i >= len(s):
            raise Bad(s)
        r, i = parse_type(s, i + 1, args)
        return pre + '%s(%s)' % (r, ','.join(sub)), i
    if ch == 'Q':
        n = int(s[i + 1])
        i += 2
        parts = []
        for _ in range(n):
            m = re.match(r'(\d+)', s[i:])
            if not m:
                raise Bad(s)
            ln = int(m.group(1))
            i += m.end()
            parts.append(s[i:i + ln])
            i += ln
        return pre + '::'.join(parts), i
    if ch.isdigit():
        m = re.match(r'(\d+)', s[i:])
        ln = int(m.group(1))
        i += m.end()
        return pre + s[i:i + ln], i + ln
    if ch in BASIC:
        return pre + BASIC[ch], i + 1
    raise Bad(s)


def parse_arg(s, i, args):
    ch = s[i]
    if ch == 'T':
        m = re.match(r'T(\d+)', s[i:])
        k = int(m.group(1))
        if k >= len(args):
            raise Bad(s)
        args.append(args[k])
        return i + m.end()
    if ch == 'N':
        cnt = int(s[i + 1])
        m = re.match(r'(\d+)', s[i + 2:])
        k = int(m.group(1))
        if k >= len(args):
            raise Bad(s)
        args.extend([args[k]] * cnt)
        return i + 2 + m.end()
    t, i = parse_type(s, i, args)
    args.append(t)
    return i


def demangle_params(p):
    args = []
    i = 0
    while i < len(p):
        i = parse_arg(p, i, args)
    if args == ['void']:
        return []
    return args


def retail_functions():
    """name -> list of parameter lists, for free functions (name__F...)."""
    out = defaultdict(list)
    seen = set()
    for line in MAP.read_text(encoding='latin-1').splitlines():
        m = re.match(r'\s*[0-9A-Fa-f]{8}\s+(\S+)\s*$', line)
        if not m:
            continue
        sym = m.group(1)
        if sym in seen:
            continue
        seen.add(sym)
        k = sym.find('__F')
        if k <= 0:
            continue
        try:
            out[sym[:k]].append((demangle_params(sym[k + 3:]), sym))
        except (Bad, ValueError, IndexError):
            out[sym[:k]].append((None, sym))
    return out


PROTO = re.compile(r'^(?:extern\s+)?(?:static\s+)?(?:inline\s+)?(?!return\b|else\b|typedef\b)([A-Za-z_][\w \*&:]*?[\s\*&])'
                   r'([A-Za-z_]\w*)\s*\(([^;{}()]*(?:\([^()]*\)[^;{}()]*)*)\)\s*(?:(?:__asm__|asm)\s*\("[^"]*"\))?\s*;', re.M)


def split_args(a):
    a = a.strip()
    if a in ('', 'void'):
        return []
    out, depth, cur = [], 0, ''
    for ch in a:
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        if ch == ',' and depth == 0:
            out.append(cur.strip())
            cur = ''
        else:
            cur += ch
    out.append(cur.strip())
    return out


SCALAR = re.compile(r'^(?:const |unsigned |signed )*(?:int|char|short|long|bool|u_long|u_char|u_short|u_int|float|double)(?: \w+)?$')


def is_ptr(t):
    return '*' in t or '&' in t or '[' in t or '(' in t


def kind(t):
    """'p' pointer-like, 's' plain scalar, '?' a typedef name we cannot classify."""
    if is_ptr(t):
        return 'p'
    return 's' if SCALAR.match(t.strip()) else '?'


def kinds_match(a, b):
    return len(a) == len(b) and all(x == y or '?' in (x, y) for x, y in zip(a, b))


def plain_symbols():
    """C-linkage function-like names in the retail map (no type information)."""
    out = set()
    for line in MAP.read_text(encoding='latin-1').splitlines():
        m = re.match(r'\s*[0-9A-Fa-f]{8}\s+([A-Za-z_]\w*)\s*$', line)
        if m and '__' not in m.group(1):
            out.add(m.group(1))
    return out


def tree_prototypes():
    decl = defaultdict(list)
    for d in DIRS:
        for p in (ROOT / d).rglob('*.h'):
            s = re.sub(r'/\*.*?\*/', '', p.read_text(encoding='latin-1'), flags=re.S)
            s = re.sub(r'//[^\n]*', '', s)
            # drop class bodies: member declarations are not free functions
            s = re.sub(r'\b(?:struct|class)\s+\w+[^;{]*\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}', '', s)
            for m in PROTO.finditer(s):
                name = m.group(2)
                if name in ('if', 'while', 'for', 'switch', 'sizeof', 'defined'):
                    continue
                decl[name].append((split_args(m.group(3)), p.relative_to(ROOT).as_posix()))
    return decl


def main():
    retail = retail_functions()
    decl = tree_prototypes()
    if len(sys.argv) > 1 and not sys.argv[1].startswith('-'):
        for n in sys.argv[1:]:
            print(n)
            for a, sym in retail.get(n, []):
                print('  retail  (%s)   %s' % (', '.join(a) if a is not None else '?', sym))
            for a, f in decl.get(n, []):
                print('  tree    (%s)   %s' % (', '.join(a), f))
        return
    find = defaultdict(list)
    for name, ds in sorted(decl.items()):
        if name not in retail:
            continue
        sigs = [a for a, _ in retail[name] if a is not None]
        if not sigs:
            continue
        sigs = [[x for x in a if x != '...'] for a in sigs]
        counts = {len(a) for a in sigs}
        forms = set()
        for a, f in ds:
            if a == ['...']:
                find['VARIADIC'].append((name, f))
                continue
            n = len([x for x in a if x != '...'])
            forms.add(tuple(is_ptr(x) for x in a if x != '...'))
            if n not in counts:
                find['ARITY'].append((name, f, n, sorted(counts)))
                continue
            mine = [kind(x) for x in a if x != '...']
            if not any(kinds_match(mine, [kind(x) for x in s]) for s in sigs if len(s) == n):
                find['KIND'].append((name, f, ', '.join(a), ' | '.join(', '.join(s) for s in sigs if len(s) == n)))
        if len(forms) > len({tuple(is_ptr(x) for x in s) for s in sigs}):
            find['CONFLICT'].append((name, len(forms), len(sigs)))
    plain = plain_symbols()
    for name, ds in sorted(decl.items()):
        if name in retail or name not in plain:
            continue
        forms = {tuple(re.sub(r'\s+', ' ', re.sub(r'\w+$', '', x) if re.search(r'[\*& ]\w+$', x) else x).strip()
                       for x in a) for a, _ in ds}
        for a, f in ds:
            if a == ['...']:
                find['C_VARIADIC'].append((name, f))
        if len(forms) > 1:
            find['C_CONFLICT'].append((name, len(forms), sorted(', '.join(x) for x in forms)[:6]))
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps({k: v for k, v in find.items()}, indent=1), encoding='utf-8')
    print('retail C++ free functions: %d (overloaded: %d) | declared in the tree and known to retail: %d'
          % (len(retail), sum(1 for v in retail.values() if len(v) > 1), sum(1 for n in decl if n in retail)))
    for k in ('VARIADIC', 'ARITY', 'KIND', 'CONFLICT', 'C_VARIADIC', 'C_CONFLICT'):
        print('%-9s %4d declarations, %4d functions' % (k, len(find[k]), len({x[0] for x in find[k]})))
    print('report: %s' % OUT.relative_to(ROOT).as_posix())


if __name__ == '__main__':
    main()
