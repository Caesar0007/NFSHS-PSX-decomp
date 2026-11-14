"""flatten.py <tu.cpp> <header-to-flatten> [--agg PATTERN ...] [--write]

Partial preprocessor for the header-truth work. It runs the whole translation unit like cpp does (macro state,
conditionals, includes), but for the chosen header it WRITES OUT what that header amounts to for this object:
  - includes of aggregator headers (files matching an --agg pattern, and the chosen header itself when it is
    re-entered) are expanded in place, their conditionals resolved and dropped;
  - every other include stays an #include line (path from the recon root);
  - #define / #undef / #line lines and plain text of the expanded files are kept as they are.
The result has no order switches and no hooks: it is this object's explicit include list. Check it with ichk.sh.
Run from the tree root. cpp flags mirrored from tools/build.py: -D__cplusplus=1 -Dmips -D__mips__ -D__psx__ -I recon."""
import fnmatch
import os
import re
import sys

ROOT = 'recon'
args = sys.argv[1:]
tu = args[0].replace(chr(92), '/')
target = os.path.normpath(args[1]).replace(chr(92), '/')
aggs = []
while '--agg' in args:
    i = args.index('--agg')
    aggs.append(args[i + 1])
    del args[i:i + 2]
write = '--write' in args
auto = '--auto' in args
prune = '--prune' in args
seen_text = []

macros = {'__cplusplus': '1', 'mips': '1', '__mips__': '1', '__psx__': '1'}
out = []
capturing = [False]
captured_once = [False]
stats = {'inlined': set(), 'kept': 0, 'text': 0}


_pure = {}


def pure_aggregator(path):
    """True when the file holds only directives, comments and forward declarations: a list/switch file."""
    if path not in _pure:
        try:
            s = open(path, encoding='latin-1').read()
        except OSError:
            _pure[path] = False
            return False
        s = re.sub(r'/\*.*?\*/', ' ', s, flags=re.S)
        s = re.sub(r'//[^\n]*', '', s)
        ok = True
        for x in s.split('\n'):
            x = x.strip()
            if not x or x.startswith('#'):
                continue
            if not re.fullmatch(r'((struct|class|enum|union)\s+\w+\s*;\s*)+', x):
                ok = False
                break
        _pure[path] = ok
    return _pure[path]


def is_agg(path):
    if path == target:
        return True
    if any(fnmatch.fnmatch(path, a) or fnmatch.fnmatch(os.path.basename(path), a) for a in aggs):
        return True
    return auto and '/shared/' not in path and pure_aggregator(path)


def strip_comments(lines):
    """yield (logical line without comments, list of original physical lines)"""
    incomment = False
    buf = ''
    orig = []
    for raw in lines:
        orig.append(raw)
        s = raw
        res = ''
        i = 0
        instr = None
        while i < len(s):
            c = s[i]
            if incomment:
                j = s.find('*/', i)
                if j < 0:
                    i = len(s)
                else:
                    incomment = False
                    i = j + 2
                    res += ' '
                continue
            if instr:
                res += c
                if c == chr(92) and i + 1 < len(s):
                    res += s[i + 1]
                    i += 2
                    continue
                if c == instr:
                    instr = None
                i += 1
                continue
            if c in '"\'':
                instr = c
                res += c
                i += 1
            elif s.startswith('/*', i):
                incomment = True
                i += 2
            elif s.startswith('//', i):
                break
            else:
                res += c
                i += 1
        if res.rstrip().endswith(chr(92)) and not incomment:
            buf += res.rstrip()[:-1] + ' '
            continue
        if incomment:
            buf += res + ' '
            continue
        yield buf + res, orig
        buf = ''
        orig = []
    if buf or orig:
        yield buf, orig


def expand_value(name, depth=0):
    v = macros.get(name)
    if v is None or depth > 20:
        return None
    v = v.strip()
    if re.fullmatch(r'[A-Za-z_]\w*', v) and v in macros:
        return expand_value(v, depth + 1)
    return v


def evaluate(expr):
    def rep_defined(m):
        return '1' if m.group(1) in macros else '0'
    e = re.sub(r'defined\s*\(\s*(\w+)\s*\)', rep_defined, expr)
    e = re.sub(r'defined\s+(\w+)', rep_defined, e)

    def rep_ident(m):
        n = m.group(0)
        if n in ('and', 'or', 'not'):
            return n
        v = expand_value(n)
        if v is None:
            return '0'
        try:
            return str(int(v.rstrip('uUlL'), 0))
        except ValueError:
            return '0'
    e = e.replace('&&', ' and ').replace('||', ' or ')
    e = re.sub(r'!(?!=)', ' not ', e)
    e = re.sub(r'\b[A-Za-z_]\w*\b', rep_ident, e)
    e = re.sub(r'\b(0[xX][0-9a-fA-F]+|\d+)[uUlL]*\b', lambda m: str(int(m.group(1), 0)), e)
    try:
        return bool(eval(e, {'__builtins__': {}}, {}))
    except Exception as ex:
        raise SystemExit('cannot evaluate #if %r -> %r (%s)' % (expr, e, ex))


def resolve(name, cur_file, presumed_dir, angled):
    cands = []
    if not angled:
        if presumed_dir is not None:
            cands.append(os.path.join(presumed_dir, name))
        cands.append(os.path.join(os.path.dirname(cur_file), name))
    cands.append(os.path.join(ROOT, name))
    for c in cands:
        if os.path.isfile(c):
            return os.path.normpath(c).replace(chr(92), '/')
    return None


def process(path, emit, depth=0):
    """emit: True when this file's lines are written to the output (file is inlined into the target)."""
    if depth > 80:
        raise SystemExit('include depth: ' + path)
    try:
        lines = open(path, encoding='latin-1').read().split('\n')
    except OSError:
        raise SystemExit('cannot open ' + path)
    lines = [l.rstrip('\r') for l in lines]
    if not (emit and capturing[0]):
        seen_text.append('\n'.join(lines))
    stack = []          # (taking_now, any_taken_before, parent_active)
    presumed_dir = None
    for logical, orig in strip_comments(lines):
        active = all(s[0] for s in stack)
        t = logical.strip()
        m = re.match(r'#\s*(\w+)\s*(.*)$', t)
        if not m:
            if active and emit and capturing[0] and t:
                out.extend(orig)
                stats['text'] += 1
            continue
        d, rest = m.group(1), m.group(2).strip()
        if d in ('if', 'ifdef', 'ifndef'):
            if not active:
                stack.append((False, True, False))
            else:
                v = evaluate(rest) if d == 'if' else ((rest.split()[0] in macros) == (d == 'ifdef'))
                stack.append((v, v, True))
            continue
        if d == 'elif':
            tk, anyt, par = stack[-1]
            if not par or anyt:
                stack[-1] = (False, anyt, par)
            else:
                v = evaluate(rest)
                stack[-1] = (v, v, par)
            continue
        if d == 'else':
            tk, anyt, par = stack[-1]
            stack[-1] = (par and not anyt, True, par)
            continue
        if d == 'endif':
            stack.pop()
            continue
        if not active:
            continue
        if d == 'define':
            mm = re.match(r'(\w+)(\([^)]*\))?\s*(.*)$', rest)
            macros[mm.group(1)] = mm.group(3) if not mm.group(2) else '(function-like)'
            if emit and capturing[0]:
                out.extend(orig)
            continue
        if d == 'undef':
            macros.pop(rest.split()[0], None)
            if emit and capturing[0]:
                out.extend(orig)
            continue
        if d == 'line':
            mm = re.match(r'\d+\s+"([^"]+)"', rest)
            if mm:
                f = mm.group(1).replace(chr(92), '/')
                presumed_dir = os.path.dirname(f) if not re.match(r'[A-Za-z]:', f) else os.path.dirname(f)
            if emit and capturing[0]:
                out.extend(orig)
            continue
        if d == 'include':
            spec = rest
            if re.match(r'[A-Za-z_]\w*$', spec):
                v = expand_value(spec)
                if v is None:
                    raise SystemExit('%s: #include %s: macro not defined' % (path, spec))
                spec = v.strip()
            mm = re.match(r'"([^"]+)"|<([^>]+)>', spec)
            if not mm:
                raise SystemExit('%s: bad include %r' % (path, rest))
            name = mm.group(1) or mm.group(2)
            f = resolve(name, path, presumed_dir, angled=mm.group(2) is not None)
            if f is None:
                raise SystemExit('%s: include not found: %s' % (path, name))
            if f == target and not capturing[0] and not captured_once[0]:
                capturing[0] = True
                captured_once[0] = True
                process(f, True, depth + 1)
                capturing[0] = False
                continue
            if capturing[0] and emit and is_agg(f):
                stats['inlined'].add(f)
                process(f, True, depth + 1)
                continue
            if capturing[0] and emit:
                rel = f[len(ROOT) + 1:] if f.startswith(ROOT + '/') else f
                out.append('#include "%s"' % rel)
                stats['kept'] += 1
            process(f, False, depth + 1)
            continue
        # other directives (pragma, error, ident): keep when emitting
        if emit and capturing[0]:
            out.extend(orig)


process(tu, False)
if not captured_once[0]:
    raise SystemExit('target header was never included by ' + tu)
if prune:
    words = set()
    for s in seen_text:
        words.update(re.findall(r'[A-Za-z_]\w*', s))
    for l in out:
        if not re.match(r'\s*#\s*(define|undef)\b', l):
            words.update(re.findall(r'[A-Za-z_]\w*', re.sub(r'/\*.*?\*/', ' ', l)))
    kept = []
    dropped = 0
    for l in out:
        m = re.match(r'\s*#\s*(define|undef)\s+(\w+)', l)
        if m and m.group(2) not in words:
            dropped += 1
            continue
        kept.append(l)
    out[:] = kept
    sys.stderr.write('pruned %d define/undef lines that nothing reads\n' % dropped)
# squeeze blank runs
res = []
for l in out:
    if not l.strip() and res and not res[-1].strip():
        continue
    res.append(l)
guard = 'NFS4_FLAT_' + re.sub(r'\W', '_', os.path.basename(target)).upper()
text = '\n'.join(['/* %s -- the explicit type/include list of this object (generated by tools/psyq_pipe/flatten.py from the' % os.path.basename(target),
                  '   former switch-driven headers; identical preprocessed source). */', '#ifndef ' + guard, '#define ' + guard] + res + ['#endif', ''])
sys.stderr.write('flatten %s: %d lines, kept includes %d, text lines %d, inlined: %s\n' % (
    target, len(res), stats['kept'], stats['text'], ' '.join(sorted(os.path.basename(x) for x in stats['inlined']))))
if write:
    open(target, 'w', encoding='latin-1', newline='\n').write(text)
else:
    sys.stdout.write(text)
