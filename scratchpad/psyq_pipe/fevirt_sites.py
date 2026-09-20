"""fevirt_sites.py SLOTMAP FILE [FILE...] -- turn manual vtable dispatch into real virtual calls, ONLY at the sites the
compiler rejects (so other hierarchies' `_vf` members are left alone until their turn).
  SLOTMAP  e.g.  1=delete,2=Value,3=TextValue,4=Increment,5=Decrement
           or    auto-menu  : pick the front-end ITEM or MENU slot map per site from the struct the compiler names.
For each FILE: compile it (tools/build.py --only), collect the lines of "has no member named `_vf'" errors, and rewrite
every dispatch expression whose span covers one of those lines:
    [(cast)] (*(*E->_vf)[N].pfn) ( (char *|int)[&]THIS + (int)(*E->_vf)[N].delta [, ARGS] )   ->   E->Method(ARGS)
    slot `delete`:  ... ,3)   ->   delete E
An argument spelled 0xffffffff / -1 becomes (tPlayer)-1; `&x` arguments lose the `&` (they were references).
Prints what it could not parse; never touches a site outside the error list."""
import bisect
import re
import subprocess
import sys

ROOT = 'C:/Temp/nfs4-decomp/'
ITEM = {1: 'delete', 2: 'DebounceKeys', 3: 'ProcessInput', 4: 'Draw', 5: 'Draw', 6: 'Draw', 7: 'TransitionOff',
        8: 'TransitionOn', 9: 'TransitionIsFinished', 10: 'UpdateTransition'}
MENU = {1: 'delete', 2: 'Initialize', 3: 'ProcessInput', 4: 'DebounceKeys', 5: 'TransitionOff', 6: 'TransitionOn',
        7: 'TransitionIsFinished', 8: 'IsSubMenu', 9: 'Draw', 10: 'UpdateTransition'}
MENU_TYPES = re.compile(r'^(tMenu|tMenuNFS4\w*|tMenuBlank|tMenuOptions|tOptionsMenu|tInsideBoxMenu|tInsideBoxSongMenu)$')
SCREEN = {1: 'GetShapeInfo', 2: 'DrawBackground', 3: 'DrawForeground', 4: 'delete', 5: 'PreLoad', 6: 'Initialize',
          7: 'Cleanup', 8: 'TransitionIsFinished', 9: 'ProcessInput'}
DIALOG = {**SCREEN, **{10: 'CalculateDimensions', 11: 'Draw'}}
CONGRATS = {**SCREEN, **{10: 'CalculatePrizes', 12: 'GetCar'}}
CARSEL = {**SCREEN, **{10: 'DrawVideoWall', 11: 'InitializeVideoWall', 12: 'UpdateVideoWall', 13: 'GetCar',
                         14: 'AllocateAsyncBuffer', 15: 'FreeAsyncBuffer'}}
CARSEL2 = {**CARSEL, **{16: 'TurnOffVideoWall', 17: 'SetDialog'}}
CARDUEL = {**CARSEL, **{16: 'DrawOpponentVideoWall'}}


def screen_map(st):
    if st.startswith('tDialog'):
        return DIALOG
    if 'Congrats' in st or st == 'tScreenTournamentTrophy':
        return CONGRATS
    if st in ('tScreenCarSelectTwoPlayer', 'tScreenPinkSlipsCarSelect'):
        return CARSEL2
    if st == 'tScreenCarSelectDuel':
        return CARDUEL
    if st == 'tScreenCarSelect':
        return CARSEL
    return SCREEN


AUTO = sys.argv[1] in ('auto-menu', 'auto-screen')
AUTO_SCREEN = sys.argv[1] == 'auto-screen'
FIXED = {} if AUTO else dict((int(k), v) for k, v in (p.split('=') for p in sys.argv[1].split(',')))
HEAD = re.compile(r'(?:\(\s*\([^()]*\(\s*\*\s*\)\s*\([^()]*\)\s*\)\s*|\(\s*\*\s*(?:\([^()]*\(\s*\*\s*\)\s*\([^()]*\)\s*\)\s*)?)'
                  r'\(\s*\*\s*(?P<e>[^;{}]+?)->_vf\s*\)\s*\[\s*(?P<n>\d+)\s*\]\s*\.pfn\s*\)\s*\(')
ERR = re.compile(r":(\d+): `(?:struct (\w+)|this)' has no member named `_vf'")


def errors(rel):
    out = subprocess.run(['python', 'tools/build.py', '--no-link', '--only', rel], capture_output=True, text=True, cwd=ROOT)
    txt = out.stdout + out.stderr
    base = rel.split('/')[-1]
    types = {}
    for m in re.finditer(re.escape(base) + ERR.pattern, txt):
        types[int(m.group(1))] = m.group(2) or ''
    return types


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
    types = errors(rel)
    errs = sorted(types)
    if not errs:
        print(rel, ': no `_vf` errors')
        continue
    s = open(ROOT + rel, encoding='utf-8').read()
    starts = [0] + [m.end() for m in re.finditer('\n', s)]
    res, pos, done, skipped = '', 0, 0, []
    for m in HEAD.finditer(s):
        if m.start() < pos:
            continue
        i, depth = m.end(), 1
        while depth:
            depth += s[i] == '('
            depth -= s[i] == ')'
            i += 1
        l0, l1 = bisect.bisect_right(starts, m.start()), bisect.bisect_right(starts, i)
        hit = [e for e in errs if l0 <= e <= l1]
        if not hit:
            continue
        args = split_args(s[m.end():i - 1])
        n = int(m.group('n'))
        e = ' '.join(m.group('e').split())
        if AUTO_SCREEN:
            slotmap = screen_map(types[hit[0]])
        else:
            slotmap = (MENU if MENU_TYPES.match(types[hit[0]]) else ITEM) if AUTO else FIXED
        if n not in slotmap or '.delta' not in args[0]:
            skipped.append((l0, types[hit[0]], s[m.start():i][:90]))
            continue
        rest = []
        for a in args[1:]:
            if a in ('0xffffffff', '-1', '0xffffffffU'):
                a = '(tPlayer)-1'
            elif re.match(r'^&\s*\w+$', a):
                a = a[1:].strip()
            rest.append(a)
        if slotmap[n] == 'delete':
            new = 'delete ' + e
        else:
            new = '%s->%s(%s)' % (e, slotmap[n], ','.join(rest))
        res += s[pos:m.start()] + new
        pos = i
        done += 1
    res += s[pos:]
    open(ROOT + rel, 'w', encoding='utf-8', newline='').write(res)
    left = sorted(errors(rel))
    print('%s: %d sites rewritten, %d error lines before, %d after %s' % (rel, done, len(errs), len(left), left[:14]))
    for l, t, x in skipped:
        print('   SKIPPED line %d (%s): %s' % (l, t, x.replace(chr(10), ' ')))
