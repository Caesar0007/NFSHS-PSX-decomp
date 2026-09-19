"""fevirt_sites.py SLOTMAP FILE [FILE...] -- turn manual vtable dispatch into real virtual calls, ONLY at the sites the
compiler rejects (so other hierarchies' `_vf` members are left alone until their turn).
  SLOTMAP  e.g.  1=delete,2=Value,3=TextValue,4=Increment,5=Decrement
For each FILE: compile it (tools/build.py --only), collect the lines of "has no member named `_vf'" errors, and rewrite
every dispatch expression whose span covers one of those lines:
    [(cast)] (*(*E->_vf)[N].pfn) ( (char *|int)[&]THIS + (int)(*E->_vf)[N].delta [, ARGS] )   ->   E->Method(ARGS)
    slot `delete`:  ... ,3)   ->   delete E
An argument spelled 0xffffffff / -1 becomes (tPlayer)-1 (what the int-typed hand call was passing).
Prints what it could not parse; never touches a site outside the error list."""
import re
import subprocess
import sys

ROOT = 'C:/Temp/nfs4-decomp/'
slotmap = dict((int(k), v) for k, v in (p.split('=') for p in sys.argv[1].split(',')))
HEAD = re.compile(r'(?:\(\s*\([^()]*\(\s*\*\s*\)\s*\([^()]*\)\s*\)\s*|\(\s*\*\s*)\(\s*\*\s*(?P<e>[^;{}]+?)->_vf\s*\)\s*\[\s*(?P<n>\d+)\s*\]\s*\.pfn\s*\)\s*\(')


def errors(rel):
    out = subprocess.run(['python', 'tools/build.py', '--no-link', '--only', rel], capture_output=True, text=True, cwd=ROOT)
    txt = out.stdout + out.stderr
    base = rel.split('/')[-1]
    return sorted({int(m.group(1)) for m in re.finditer(re.escape(base) + r":(\d+): [^\n]*has no member named `_vf'", txt)}), txt


def split_args(s):
    out, depth, cur = [], 0, ''
    for c in s:
        if c == ',' and depth == 0:
            out.append(cur)
            cur = ''
            continue
        depth += c in '([{'
        depth -= c in ')]}'
        cur += c
    out.append(cur)
    return [a.strip() for a in out]


for rel in sys.argv[2:]:
    errs, _ = errors(rel)
    if not errs:
        print(rel, ': no `_vf` errors')
        continue
    s = open(ROOT + rel, encoding='utf-8').read()
    starts = [0]
    for m in re.finditer('\n', s):
        starts.append(m.end())

    def line_of(pos):
        import bisect
        return bisect.bisect_right(starts, pos)

    res, pos, done, skipped = '', 0, 0, []
    for m in HEAD.finditer(s):
        if m.start() < pos:
            continue
        i, depth = m.end(), 1
        while depth:
            depth += s[i] == '('
            depth -= s[i] == ')'
            i += 1
        l0, l1 = line_of(m.start()), line_of(i)
        if not any(l0 <= e <= l1 for e in errs):
            continue
        args = split_args(s[m.end():i - 1])
        n = int(m.group('n'))
        e = ' '.join(m.group('e').split())
        if n not in slotmap or '.delta' not in args[0]:
            skipped.append((l0, s[m.start():i][:80]))
            continue
        rest = ['(tPlayer)-1' if a in ('0xffffffff', '-1', '0xffffffffU') else a for a in args[1:]]
        if slotmap[n] == 'delete':
            new = 'delete ' + e
        else:
            sep = '.' if e.startswith('(*') else '->'
            new = '%s%s%s(%s)' % (e, sep, slotmap[n], ','.join(rest))
        res += s[pos:m.start()] + new
        pos = i
        done += 1
    res += s[pos:]
    open(ROOT + rel, 'w', encoding='utf-8', newline='').write(res)
    left, _ = errors(rel)
    print('%s: %d sites rewritten, %d error lines before, %d after %s' % (rel, done, len(errs), len(left), left[:12]))
    for l, t in skipped:
        print('   SKIPPED line %d: %s' % (l, t.replace(chr(10), ' ')))
