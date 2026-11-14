"""collapse_dead.py [--apply] -- resolve conditionals that test only NFS4_* names nothing defines any more.
`#ifdef DEAD` blocks are removed (an #else part is kept), `#ifndef DEAD` blocks become unconditional, `#if`
expressions built only from dead names are evaluated with every name undefined. Conditionals that mix dead and
live names, or that have #elif branches, are left alone. Lines are removed (headers with `#line` restores keep
their line count: removed lines become blank)."""
import glob
import os
import re
import sys

apply = '--apply' in sys.argv


def files():
    for e in ('h', 'cpp', 'c', 'inc'):
        for p in glob.glob('recon/**/*.' + e, recursive=True):
            q = p.replace(os.sep, '/')
            if '/mod/' in q or 'game-mod' in q or 'syslib-mod' in q:
                continue
            yield q


defined = set()
tested = set()
texts = {}
for q in files():
    s = open(q, encoding='latin-1', newline='').read()
    texts[q] = s
    j = re.sub(r'\\[ \t]*\r?\n', ' ', s)
    defined.update(re.findall(r'(?m)^[ \t]*#[ \t]*define[ \t]+(\w+)', j))
    for m in re.finditer(r'(?m)^[ \t]*#[ \t]*(?:if|ifdef|ifndef|elif)\b(.*)$', j):
        tested.update(re.findall(r'\bNFS4_\w+', re.sub(r'/\*.*?\*/', ' ', m.group(1))))
for t in ('tools/build.py', 'tools/psyq_pipe/gdebug_compile.py'):
    if os.path.exists(t):
        defined.update(re.findall(r'-D(\w+)', open(t, encoding='latin-1').read()))
dead = tested - defined


def const(kind, rest):
    """None = not decidable; else True/False = whether the block is taken"""
    rest = re.sub(r'/\*.*?\*/', ' ', rest).strip()
    if kind in ('ifdef', 'ifndef'):
        n = rest.split()[0] if rest.split() else ''
        if n in dead:
            return kind == 'ifndef'
        return None
    names = set(re.findall(r'\b[A-Za-z_]\w*\b', rest)) - {'defined'}
    if not names or not names <= dead:
        return None
    e = re.sub(r'defined\s*\(\s*\w+\s*\)|defined\s+\w+', '0', rest)
    e = e.replace('&&', ' and ').replace('||', ' or ')
    e = re.sub(r'!(?!=)', ' not ', e)
    e = re.sub(r'\b[A-Za-z_]\w*\b', lambda m: m.group(0) if m.group(0) in ('and', 'or', 'not') else '0', e)
    try:
        return bool(eval(e, {'__builtins__': {}}, {}))
    except Exception:
        return None


total = 0
changed = 0
for q, s in texts.items():
    if '\\\n' in s or '\\\r\n' in s:
        pass
    nl = '\r\n' if '\r\n' in s else '\n'
    L = s.split(nl)
    keepcount = q.endswith('.h') and '#line ' in s
    drop = set()
    stack = []      # (line index, verdict or None, has_elif, else index)
    n = 0
    cont = False
    for i, x in enumerate(L):
        was = cont
        cont = x.rstrip().endswith('\\')
        if was:
            if stack and stack[-1][1] is not None:
                stack[-1] = (stack[-1][0], None, stack[-1][2], stack[-1][3])   # multi-line condition: leave alone
            continue
        m = re.match(r'[ \t]*#[ \t]*(if|ifdef|ifndef|elif|else|endif)\b(.*)$', x)
        if not m:
            continue
        k, rest = m.group(1), m.group(2)
        if k in ('if', 'ifdef', 'ifndef'):
            stack.append((i, None if cont else const(k, rest), False, None))
        elif k == 'elif':
            a, v, e, el = stack[-1]
            stack[-1] = (a, v, True, el)
        elif k == 'else':
            a, v, e, el = stack[-1]
            stack[-1] = (a, v, e, i)
        else:
            a, v, e, el = stack.pop()
            if v is None or e:
                continue
            n += 1
            if v:          # block taken: drop the directive lines and any #else part
                drop.add(a)
                if el is not None:
                    drop.update(range(el, i))
                drop.add(i)
            else:          # block not taken: drop it, keep an #else part
                if el is not None:
                    drop.update(range(a, el + 1))
                else:
                    drop.update(range(a, i))
                drop.add(i)
    if n:
        total += n
        changed += 1
        if apply:
            out = [('' if i in drop else x) for i, x in enumerate(L)] if keepcount else [x for i, x in enumerate(L) if i not in drop]
            open(q, 'w', encoding='latin-1', newline='').write(nl.join(out))
print('dead names %d; conditionals resolved %d in %d files%s' % (len(dead), total, changed, '' if apply else ' (dry run)'))
