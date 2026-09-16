"""asmblocks.py -- locate file-scope / statement `__asm__( ... )` blocks in C/C++ sources and
expose their string-literal spans.  Shared by the census and the rewriter.
Usage: asmblocks.py census   -> per-file directive + symbolic-register census (asm blocks only)"""
import re, sys, pathlib
from collections import Counter, defaultdict
ROOT = pathlib.Path('C:/Temp/nfs4-decomp')
REG = {'zero': 0, 'at': 1, 'v0': 2, 'v1': 3, 'a0': 4, 'a1': 5, 'a2': 6, 'a3': 7,
       't0': 8, 't1': 9, 't2': 10, 't3': 11, 't4': 12, 't5': 13, 't6': 14, 't7': 15,
       's0': 16, 's1': 17, 's2': 18, 's3': 19, 's4': 20, 's5': 21, 's6': 22, 's7': 23,
       't8': 24, 't9': 25, 'k0': 26, 'k1': 27, 'gp': 28, 'sp': 29, 'fp': 30, 'ra': 31}
REGPAT = re.compile(r'\$(zero|at|v[01]|a[0-3]|t[0-9]|s[0-7]|k[01]|gp|sp|fp|ra)\b')


def blocks(text):
    """yield (start, end) of every `__asm__ ( ... )` / `asm ( ... )` block (end = index after ')')."""
    i = 0
    n = len(text)
    while True:
        m = re.compile(r'\b(__asm__|__asm|asm)\b').search(text, i)
        if not m:
            return
        j = m.end()
        # optional `volatile`/`__volatile__`
        m2 = re.compile(r'\s*(__volatile__|volatile)?\s*\(').match(text, j)
        if not m2:
            i = j
            continue
        k = m2.end()
        depth = 1
        while k < n and depth:
            c = text[k]
            if c == '"':
                k += 1
                while k < n and text[k] != '"':
                    if text[k] == '\\':
                        k += 1
                    k += 1
                k += 1
                continue
            if text.startswith('/*', k):
                k = text.index('*/', k) + 2
                continue
            if text.startswith('//', k):
                k = text.index('\n', k)
                continue
            if c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
            k += 1
        yield m.start(), k
        i = k


def literals(text, s, e):
    """yield (start, end) of string literal CONTENTS inside text[s:e], skipping comments."""
    k = s
    while k < e:
        c = text[k]
        if c == '"':
            a = k + 1
            k = a
            while text[k] != '"':
                if text[k] == '\\':
                    k += 1
                k += 1
            yield a, k
            k += 1
            continue
        if text.startswith('/*', k):
            k = text.index('*/', k) + 2
            continue
        if text.startswith('//', k):
            k = text.index('\n', k)
            continue
        k += 1


def sources():
    for p in sorted(ROOT.joinpath('recon').rglob('*')):
        if p.suffix in ('.c', '.cpp', '.h'):
            yield p


if __name__ == '__main__' and sys.argv[1:] == ['census']:
    dirs = defaultdict(Counter)
    regs = Counter()
    for p in sources():
        t = p.read_bytes().decode('utf-8', errors='replace')
        rel = p.relative_to(ROOT).as_posix()
        for s, e in blocks(t):
            for a, b in literals(t, s, e):
                lit = t[a:b].replace('\\n', '\n').replace('\\t', '\t')
                regs[rel] += len(REGPAT.findall(lit))
                for line in lit.split('\n'):
                    line = line.strip()
                    m = re.match(r'(\.[A-Za-z_]+)', line)
                    if m:
                        dirs[m.group(1)][rel] += 1
                    m = re.match(r'(\w+)\s*=\s*\w+$', line)
                    if m:
                        dirs['<alias =>'][rel] += 1
                    if re.match(r'\.set\s+(push|pop)', line):
                        dirs['<set ' + line.split()[1] + '>'][rel] += 1
    print('== symbolic registers inside asm blocks: %d files, %d uses' % (len([1 for v in regs.values() if v]), sum(regs.values())))
    for f, n in sorted(regs.items()):
        if n:
            print('  %4d %s' % (n, f))
    print('== directives inside asm blocks (directive: nfiles, total; files)')
    for d, c in sorted(dirs.items()):
        print('  %-14s %3d files %4d uses  %s' % (d, len(c), sum(c.values()), ' '.join(sorted(c)) if len(c) <= 8 else ''))
