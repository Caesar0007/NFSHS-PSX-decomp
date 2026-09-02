"""s6_symaudit.py -- W86-S6 SYM/SLD exactness auditor (READ-ONLY; scratchpad tool).

Parses the trusted SYM dump into per-function local/param records (REGPARM/ARG/
REG/AUTO/STAT, with block nesting), then diffs those names against the local
declarations found in a recon .cpp function body.

usage:
  python s6_symaudit.py block <mangled_fn>     -- dump one SYM 8c block
  python s6_symaudit.py tu <recon.cpp>         -- audit every fn in a TU
"""
import re, sys, os

SYM = r"C:/Temp/nfs4-psx/nfs4-psx-sym.txt"

REGNAME = ['zero','at','v0','v1','a0','a1','a2','a3','t0','t1','t2','t3',
           't4','t5','t6','t7','s0','s1','s2','s3','s4','s5','s6','s7',
           't8','t9','k0','k1','gp','sp','fp','ra']

DEFRE = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class (\w+) type (.*?) name (\S+)$')
LOCAL_CLASSES = {'REG', 'AUTO', 'ARG', 'REGPARM', 'STAT'}

_cache = None


def load():
    """Return {mangled_name: dict(block info)} for every 8c Function start."""
    global _cache
    if _cache is not None:
        return _cache
    txt = open(SYM, errors='replace').read().splitlines()
    starts = [i for i, l in enumerate(txt) if '8c Function start' in l]
    out = {}
    for k, i in enumerate(starts):
        end = starts[k + 1] if k + 1 < len(starts) else len(txt)
        blk = txt[i:end]
        info = {'lines': blk, 'locals': [], 'fsize': 0, 'line': 0, 'file': '',
                'name': '', 'endline': 0, 'va': ''}
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8})', blk[0])
        if m:
            info['va'] = m.group(1)
        depth = 0
        for l in blk:
            s = l.strip()
            mm = re.match(r'fsize = (\d+)', s)
            if mm:
                info['fsize'] = int(mm.group(1))
            mm = re.match(r'line = (\d+)', s)
            if mm and not info['line']:
                info['line'] = int(mm.group(1))
            mm = re.match(r'file = (.*)', s)
            if mm and not info['file']:
                info['file'] = mm.group(1)
            mm = re.match(r'name = (\S+)', s)
            if mm and not info['name']:
                info['name'] = mm.group(1)
            if '90 Block start' in s:
                depth += 1
                continue
            if '92 Block end' in s:
                depth -= 1
                continue
            mm = re.search(r'8e Function end\s+line (\d+)', s)
            if mm:
                info['endline'] = int(mm.group(1))
                break
            d = DEFRE.match(s)
            if d and d.group(2) in LOCAL_CLASSES:
                val = int(d.group(1), 16)
                cls, typ, nm = d.group(2), d.group(3).strip(), d.group(4)
                home = ''
                if cls in ('REG', 'REGPARM'):
                    home = REGNAME[val] if val < 32 else '$%d' % val
                else:
                    home = '+0x%x' % val
                info['locals'].append({'cls': cls, 'type': typ, 'name': nm,
                                       'home': home, 'depth': depth})
        if info['name']:
            out.setdefault(info['name'], info)
    _cache = out
    return out


# ---------------- recon C parsing ----------------

DECL = re.compile(
    r'^\s{0,8}(?:static\s+|const\s+|volatile\s+|register\s+|unsigned\s+|signed\s+|struct\s+|union\s+|enum\s+)*'
    r'([A-Za-z_][A-Za-z0-9_:]*)(?:\s*(\*+)\s*|\s+(?=\w))(\**)?([A-Za-z_][A-Za-z0-9_]*)\s*'
    r'(\[[^;]*\])?\s*(?:=[^;]*?)?;\s*$')

# a declaration whose initializer opens a brace and runs onto later lines
DECL_OPEN = re.compile(
    r'^\s{0,8}(?:static\s+|const\s+|volatile\s+|register\s+|unsigned\s+|signed\s+|struct\s+|union\s+|enum\s+)*'
    r'([A-Za-z_][A-Za-z0-9_:]*)(?:\s*(\*+)\s*|\s+(?=\w))(\**)?([A-Za-z_][A-Za-z0-9_]*)\s*'
    r'(\[[^;=]*\])?\s*=\s*\{')

NOT_TYPES = {'return', 'goto', 'break', 'continue', 'case', 'else', 'do',
             'if', 'while', 'for', 'switch', 'sizeof', 'typedef'}


def fn_bodies(path):
    """Yield (cname, startline, bodylines) for each top-level fn definition."""
    lines = open(path, errors='replace').read().splitlines()
    # strip comments for structure but keep line alignment
    src = '\n'.join(lines)
    stripped = re.sub(r'/\*.*?\*/', lambda m: re.sub(r'[^\n]', ' ', m.group(0)),
                      src, flags=re.S)
    stripped = re.sub(r'//[^\n]*', '', stripped)
    sl = stripped.split('\n')
    i = 0
    n = len(sl)
    while i < n:
        line = sl[i]
        # a function definition's opening brace at column 0
        if line.startswith('{'):
            # walk back to the signature
            j = i - 1
            while j >= 0 and sl[j].strip() == '':
                j -= 1
            sig = []
            while j >= 0 and sl[j].strip() != '' and not sl[j].strip().endswith((';', '}')):
                sig.insert(0, sl[j])
                j -= 1
                if len(sig) > 6:
                    break
            sigtxt = ' '.join(x.strip() for x in sig)
            m = re.search(r'([A-Za-z_~][A-Za-z0-9_:~]*)\s*\([^()]*\)\s*(?:const)?\s*$', sigtxt)
            cname = m.group(1) if m else '?@%d' % (i + 1)
            depth = 0
            body = []
            k = i
            while k < n:
                depth += sl[k].count('{') - sl[k].count('}')
                body.append(sl[k])
                k += 1
                if depth == 0:
                    break
            pm = re.search(r'\(([^()]*)\)\s*(?:const)?\s*$', sigtxt)
            params = []
            if pm:
                for part in pm.group(1).split(','):
                    part = part.strip().rstrip(')')
                    q = re.search(r'([A-Za-z_]\w*)\s*(?:\[[^\]]*\])?$', part)
                    if q and q.group(1) not in ('void', 'int', 'char', 'long',
                                                'short', 'unsigned', 'signed'):
                        params.append(q.group(1))
            yield cname, j + 2, body, params
            i = k
            continue
        i += 1


def c_locals(body):
    out = []
    depth = 0
    for l in body:
        d0 = depth
        depth += l.count('{') - l.count('}')
        m = DECL.match(l) or DECL_OPEN.match(l)
        if not m:
            continue
        if m.re is DECL_OPEN:
            out.append({'name': m.group(4), 'type': m.group(1), 'arr': m.group(5) or '',
                        'depth': d0, 'text': l.strip()})
            continue
        typ = m.group(1)
        stars = (m.group(2) or '') + (m.group(3) or '')
        nm, arr = m.group(4), m.group(5) or ''
        if typ in NOT_TYPES or nm in NOT_TYPES:
            continue
        if '(' in l or ')' in l:
            continue
        out.append({'name': nm, 'type': (typ + ' ' + stars).strip(), 'arr': arr,
                    'depth': d0, 'text': l.strip()})
    return out


def demangle_base(mangled):
    """crude: strip GCC2 __F.. / __<len><Class> suffix to get a C-visible name."""
    m = re.match(r'^(.*?)__(F|\d|C|H)', mangled)
    return m.group(1) if m else mangled


def audit_tu(path):
    syms = load()
    filetxt = open(path, errors='replace').read()
    # index SYM fns by demangled base name
    by_base = {}
    for mn, info in syms.items():
        by_base.setdefault(demangle_base(mn), []).append((mn, info))
    print('=== %s ===' % path)
    total = matched = 0
    for cname, ln, body, params in fn_bodies(path):
        total += 1
        base = cname.split('::')[-1]
        cls = cname.split('::')[0] if '::' in cname else None
        cands = [c for c in (by_base.get(base) or []) ]
        if cls is not None:
            # a GCC2 method mangles as name__<len><Class>...; require an exact
            # length-prefixed class match so sibling classes don't collide.
            pat = re.compile(r'^%s__%d%s(?:$|[A-Za-z_])' %
                             (re.escape(base), len(cls), re.escape(cls)))
            q = [c for c in cands if pat.match(c[0])]
            cands = q
        else:
            cands = [c for c in cands if re.match(r'^%s__F' % re.escape(base), c[0])] or cands
        if len(cands) != 1:
            print('  [%-40s] SYM: %d candidates -- SKIP' % (cname, len(cands)))
            continue
        matched += 1
        mn, info = cands[0]
        cl = c_locals(body)
        cnames = [x['name'] for x in cl] + params + ['this']
        snames = [x['name'] for x in info['locals']]
        seen = set()
        sloc = []
        for x in info['locals']:
            if x['name'] in seen:
                continue
            seen.add(x['name'])
            sloc.append(x)
        bodytxt = '\n'.join(body)
        miss = []
        soft = []
        for x in sloc:
            if x['name'] in cnames:
                continue
            # a name that occurs anywhere in the body is present but was not
            # parsed as a declaration (multi-line decl / attribute); only a name
            # that occurs NOWHERE is a genuine SYM-vs-C absence.
            if re.search(r'(?<![\w.>])%s\b' % re.escape(x['name']), bodytxt):
                soft.append(x)
            else:
                miss.append(x)
        extra = [x for x in cl if x['name'] not in snames]
        flag = 'OK ' if not miss and not extra else 'DIFF'
        if miss:
            flag = 'ABS '
        print('  [%s] %-38s SYM=%-40s locals SYM=%d C=%d  SLD %d-%d' %
              (flag, cname, mn, len(sloc), len(cl), info['line'], info['endline']))
        for x in miss:
            print('        ABSENT-in-C  : %-6s %-22s %-16s d%d' %
                  (x['cls'], x['type'], x['name'], x['depth']))
        for x in soft:
            print('        soft(present): %-6s %-22s %-16s d%d' %
                  (x['cls'], x['type'], x['name'], x['depth']))
        for x in extra:
            print('        EXTRA-in-C   : %-38s d%d' % (x['text'], x['depth']))
    print('  -- %d fns, %d SYM-matched' % (total, matched))


if __name__ == '__main__':
    if sys.argv[1] == 'block':
        info = load().get(sys.argv[2])
        if not info:
            sys.exit('no SYM block for ' + sys.argv[2])
        print('\n'.join(info['lines'][:200]))
    elif sys.argv[1] == 'tu':
        for p in sys.argv[2:]:
            if not os.path.exists(p):
                print('=== %s === MISSING FILE, skipped' % p)
                continue
            try:
                audit_tu(p)
            except Exception as e:
                print('=== %s === ERROR %r' % (p, e))
