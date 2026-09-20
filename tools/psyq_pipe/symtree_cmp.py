"""symtree_cmp.py OURS_DUMP.txt [--list CLASS] [--fn NAME] -- WHOLE-TREE source-level comparison of our full-debug PSYLINK
SYM (psylink_lane.py in NFS4_LANE_G mode) with the retail SYM, function by function:

  FRAME    fsize / register mask / mask offset
  LOCALS   every parameter and local: name, class (REG / REGPARM / AUTO / ARG / STAT), register number or sp offset, type
           -- EXTRA = a local retail does not have (an invented carrier), MISSING = a retail local we lack, MOVED = same
           name, different home, TYPE = same name, different type
  BLOCKS   the scope tree: nesting + function-relative start/end addresses (a wrong scope, an extra brace level, a missing
           empty scope all show here)
The current CLEAN classification covers the implemented checks above, NOT SLD
instruction/statement attribution, block line numbers, or source-line spans.
End-line pairs are stored in the report for review but do not create issues.
Use independent SLD/block-line checks before claiming source restoration.
Writes symtree_report.json next to OURS_DUMP.

2026-09-20: corrected this documentation only; comparison behavior is unchanged.
Backup: scratchpad/sym_copspeak_engine_20260920/backups/symtree_cmp.py.
"""
import json
import re
import sys
from collections import Counter
from pathlib import Path

RETAIL = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt'
REC = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([0-9a-f]{2}) (.*)$')
DEF = re.compile(r'class (\w+) type (.*?) size (\d+)(?: dims .*?)?(?: tag (\S*))? name (\S+)$')


def parse(path):
    fns, cur, hdr_mode = {}, None, False
    for l in open(path, errors='replace'):
        l = l.rstrip('\n')
        m = REC.match(l)
        if not m:
            if cur is not None and hdr_mode:
                h = re.match(r'\s+(\w+) = (.*)$', l)
                if h:
                    cur['hdr'][h.group(1)] = h.group(2).strip()
                    if h.group(1) == 'name':
                        hdr_mode = False
                        nm = cur['hdr']['name']
                        if nm.startswith('___'):      # the lane spells cfront destructors EA's way (___X); retail's SYM says _._X
                            nm = '_._' + nm[3:]
                        fns.setdefault(nm, cur)
            continue
        a, t, rest = int(m.group(1), 16), m.group(2), m.group(3)
        if t == '8c':
            cur = {'start': a, 'hdr': {}, 'locals': [], 'blocks': [], 'depth': 0, 'end_line': None}
            hdr_mode = True
        elif cur is None:
            continue
        elif t == '8e':
            k = re.search(r'line (\d+)', rest)
            cur['end_line'] = int(k.group(1)) if k else None
            cur = None
        elif t == '90':
            cur['blocks'].append(('{', cur['depth'], a - cur['start'])); cur['depth'] += 1
        elif t == '92':
            cur['depth'] -= 1; cur['blocks'].append(('}', cur['depth'], a - cur['start']))
        elif t in ('94', '96'):
            d = DEF.search(rest)
            if d and d.group(1) in ('REG', 'REGPARM', 'AUTO', 'ARG', 'STAT'):
                v = a if a < 0x80000000 else a - (1 << 32)
                home = d.group(1) + (':$%d' % a if d.group(1) in ('REG', 'REGPARM') else ':sp%+d' % v if d.group(1) in ('AUTO', 'ARG') else '')
                # anonymous tags are numbered per TU (`._148`): the number counts every unnamed type seen before, not comparable
                ty = re.sub(r'\._\d+', '._N', (d.group(2) + ' ' + (d.group(4) or '')).strip())
                cur['locals'].append((d.group(5), home, ty, cur['depth']))
    return fns


ours_path = sys.argv[1]
ours, retail = parse(ours_path), parse(RETAIL)
common = sorted(set(ours) & set(retail))
report, tally = {}, Counter()
for fn in common:
    o, r = ours[fn], retail[fn]
    issues = []
    for k in ('fsize', 'mask', 'maskoffs'):
        if o['hdr'].get(k) != r['hdr'].get(k):
            issues.append('FRAME %s %s != %s' % (k, o['hdr'].get(k), r['hdr'].get(k)))
    on, rn = Counter(n for n, *_ in o['locals']), Counter(n for n, *_ in r['locals'])
    for n in sorted((on - rn)):
        issues.append('EXTRA %s %s' % (n, next(h for x, h, *_ in o['locals'] if x == n)))
    for n in sorted((rn - on)):
        issues.append('MISSING %s %s' % (n, next(h for x, h, *_ in r['locals'] if x == n)))
    oh = {}
    for n, h, ty, d in o['locals']:
        oh.setdefault(n, []).append((h, ty, d))
    rh = {}
    for n, h, ty, d in r['locals']:
        rh.setdefault(n, []).append((h, ty, d))
    for n in sorted(set(oh) & set(rh)):
        if len(oh[n]) == len(rh[n]):
            for (h1, t1, d1), (h2, t2, d2) in zip(oh[n], rh[n]):
                if h1 != h2:
                    issues.append('MOVED %s %s != %s' % (n, h1, h2))
                elif t1 != t2:
                    issues.append('TYPE %s "%s" != "%s"' % (n, t1, t2))
    if [n for n, *_ in o['locals'] if n in rh] != [n for n, *_ in r['locals'] if n in oh] and not any(i.startswith(('EXTRA', 'MISSING')) for i in issues):
        issues.append('ORDER of declarations differs')
    if o['blocks'] != r['blocks']:
        ob, rb = sum(1 for b in o['blocks'] if b[0] == '{'), sum(1 for b in r['blocks'] if b[0] == '{')
        issues.append('BLOCKS %d scopes != %d' % (ob, rb) if ob != rb else 'BLOCKS same count, different nesting/addresses')
    try:
        so = o['end_line'] - int(o['hdr']['line']); sr = r['end_line'] - int(r['hdr']['line'])
        # `Function end line` is relative in some records: keep both readings honest by comparing what each file says
        span = (o['end_line'], r['end_line'])
    except Exception:
        span = None
    report[fn] = {'issues': issues, 'file': r['hdr'].get('file', ''), 'end_line': span}
    kinds = {i.split()[0] for i in issues}
    for k in kinds:
        tally[k] += 1
    tally['CLEAN' if not issues else 'DIRTY'] += 1
Path(ours_path).with_name('symtree_report.json').write_text(json.dumps(report, indent=1))
print('functions with debug records: ours %d, retail %d, common %d; retail-only %d, ours-only %d' % (
    len(ours), len(retail), len(common), len(set(retail) - set(ours)), len(set(ours) - set(retail))))
print('CLEAN %d | DIRTY %d' % (tally['CLEAN'], tally['DIRTY']))
for k in ('FRAME', 'EXTRA', 'MISSING', 'MOVED', 'TYPE', 'ORDER', 'BLOCKS'):
    print('  %-8s %5d functions' % (k, tally[k]))
if '--list' in sys.argv:
    want = sys.argv[sys.argv.index('--list') + 1]
    for fn in common:
        hit = [i for i in report[fn]['issues'] if i.startswith(want)]
        if hit:
            print('%-60s %s' % (fn[:60], '; '.join(hit)[:160]))
if '--fn' in sys.argv:
    fn = sys.argv[sys.argv.index('--fn') + 1]
    print(fn, json.dumps(report.get(fn), indent=1))
if '--retail-only' in sys.argv:
    for fn in sorted(set(retail) - set(ours)):
        print('  retail-only', fn, retail[fn]['hdr'].get('file', ''))
