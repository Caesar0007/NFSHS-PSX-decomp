"""symfix_order.py [--apply] [--file FRAGMENT] -- declaration ORDER fixer.  For every function the board marks with an ORDER
issue (and no EXTRA / MISSING), reorder the local declarations at the top of each scope of OUR source so that their order
is retail's (the debug records list a scope's locals in declaration order).

Conservative by construction: a scope is touched only when its declaration run consists of single-declarator statements
whose names are unique in the function and all present in retail; comments / blank lines directly above a declaration
travel with it.  The function is found through OUR debug record (source file + start line).  Nothing here can change
semantics unnoticed: symloop.py re-checks the object bytes afterwards."""
import importlib.util
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
spec = importlib.util.spec_from_file_location('stp', str(ROOT / 'scratchpad/psyq_pipe/symtree_parse.py'))
stp = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stp)
apply = '--apply' in sys.argv
frag = sys.argv[sys.argv.index('--file') + 1].lower() if '--file' in sys.argv else None
only_fns = set(sys.argv[sys.argv.index('--fn') + 1].split(',')) if '--fn' in sys.argv else None
rep = json.load(open(ROOT / 'build/psyq_g/symtree_report.json'))
ours, retail = stp.parse(str(ROOT / 'build/psyq_g/nfs4_sym.txt')), stp.parse(stp.RETAIL)

TYPEWORD = r'(?:register|static|const|volatile|unsigned|signed|struct|union|enum|short|long|int|char|float|double|void|bool|[A-Za-z_]\w*(?:::\w+)*)'
DECL = re.compile(r'^\s*(?:%s[\s\*&]+)+(\**\s*[A-Za-z_]\w*)\s*((?:\[[^\]]*\]\s*)*)(?:=[^;]*|asm\s*\([^)]*\)\s*)?;\s*(?:/\*.*?\*/\s*|//.*)?$' % TYPEWORD, re.S)
KEYWORDS = {'return', 'goto', 'break', 'continue', 'else', 'delete', 'new', 'case', 'default', 'typedef'}


def src_of(fn):
    f = ours[fn]['hdr'].get('file', '').replace(chr(92), '/')
    while '//' in f:
        f = f.replace('//', '/')
    i = f.upper().find('/RECON/')
    if i < 0:
        return None
    rel = f[i + 1:]
    # the SYM upper-cases the path: find the real file
    for p in (ROOT / 'recon').rglob('*'):
        if p.is_file() and p.relative_to(ROOT).as_posix().upper() == rel.upper():
            return p
    return None


def strip_comments(line, in_c):
    out, i = '', 0
    while i < len(line):
        if in_c:
            j = line.find('*/', i)
            if j < 0:
                return out, True
            i, in_c = j + 2, False
        elif line.startswith('/*', i):
            in_c = True; i += 2
        elif line.startswith('//', i):
            break
        elif line[i] in '"\'':
            q = line[i]; j = i + 1
            while j < len(line) and line[j] != q:
                j += 2 if line[j] == chr(92) else 1
            out += q + q; i = j + 1
        else:
            out += line[i]; i += 1
    return out, in_c


def fix_function(lines, start, order):
    """lines: file lines; start: 0-based index of the function's first line.  Returns (new_lines, n_scopes_changed, why)"""
    rank = {n: k for k, n in enumerate(order)}
    # find the body
    i, depth, in_c, opened = start, 0, False, False
    changed = 0
    n = len(lines)
    scopes_pending = []          # indices of lines right after a '{'
    while i < n:
        code, in_c = strip_comments(lines[i], in_c)
        for ch in code:
            if ch == '{':
                depth += 1; opened = True
                scopes_pending.append(i + 1)
            elif ch == '}':
                depth -= 1
        if opened and depth == 0:
            break
        i += 1
    end = i
    for s0 in scopes_pending:
        if s0 > end:
            continue
        items, cur_lead, j, ic = [], [], s0, False
        while j <= end and (not lines[j].strip() or ('if (0)' in lines[j] and 'SimpleMem' in lines[j])):
            j += 1          # skip the literal-carrier statement (and blank lines around it)
        s0 = j
        while j <= end:
            raw = lines[j]
            code, ic2 = strip_comments(raw, ic)
            if not code.strip():                     # blank or comment-only line
                cur_lead.append(raw); ic = ic2; j += 1
                continue
            # a declaration may span lines: join until ';'
            k, stmt, icx = j, raw, ic2
            joined = code
            while ((';' not in joined and '{' not in joined and '}' not in joined) or
                   ('=' in joined and joined.count('{') > joined.count('}')) or
                   ('=' in joined and '{' in joined and ';' not in joined.rsplit('}', 1)[-1])) and k + 1 <= end and k - j < 40:
                k += 1
                c2, icx = strip_comments(lines[k], icx)
                joined += ' ' + c2; stmt += lines[k]
            flat = re.sub(r'=\s*\{.*\}', '= 0', re.sub(r'/\*.*?\*/', ' ', joined.replace('\n', ' ')), flags=re.S)
            m = DECL.match(flat)
            head = joined.strip().split('(')[0].split()
            first = head[0] if head else ''
            if not m or first in KEYWORDS or '(' in joined.split('=')[0].split('asm')[0]:
                break
            name = m.group(1).replace('*', '').strip()
            items.append((name, cur_lead + lines[j:k + 1]))
            cur_lead, ic, j = [], icx, k + 1
        names = [x[0] for x in items]
        if len(items) < 2 or len(set(names)) != len(names) or not any(x in rank for x in names):
            continue
        key, last = {}, -1.0          # a carrier retail lacks keeps its place right after its predecessor
        for x in names:
            if x in rank:
                last = float(rank[x]); key[x] = last
            else:
                last += 0.001; key[x] = last
        want = sorted(items, key=lambda x: key[x[0]])
        if want == items:
            continue
        newblock = [l for _, ls in want for l in ls]
        span = sum(len(ls) for _, ls in items)
        lines[s0:s0 + span] = newblock
        changed += 1
    return changed


byfile = defaultdict(list)
for fn, v in rep.items():
    ks = {i.split()[0] for i in v['issues']}
    if 'ORDER' in ks and not (ks & {'EXTRA', 'MISSING'}) and (only_fns is None or fn in only_fns):
        byfile[v['file'].split(chr(92))[-1]].append(fn)
tot = 0
for fname, fns in sorted(byfile.items()):
    if frag and frag not in fname.lower():
        continue
    src = src_of(fns[0])
    if not src:
        print('?? no source for', fname); continue
    lines = src.read_text(encoding='utf-8', errors='surrogateescape').splitlines(keepends=True)
    # process bottom-up so earlier line numbers stay valid
    done = []
    for fn in sorted(fns, key=lambda f: -int(ours[f]['hdr']['line'])):
        names = [n for n, *_ in retail[fn]['locals']]
        if len(set(names)) != len(names):
            dup = [n for n, c in Counter(names).items() if c > 1]
            names = [n for n in names if n not in dup]
        c = fix_function(lines, int(ours[fn]['hdr']['line']) - 1, names)
        done.append((fn, c))
        tot += c > 0
    print('%-22s [%s] %s' % (fname, src.relative_to(ROOT).as_posix(), ' '.join('%s:%d' % (f, c) for f, c in done)))
    if apply:
        src.write_text(''.join(lines), encoding='utf-8', errors='surrogateescape', newline='')
print('functions with a reordered scope:', tot, '(applied)' if apply else '(dry run)')
