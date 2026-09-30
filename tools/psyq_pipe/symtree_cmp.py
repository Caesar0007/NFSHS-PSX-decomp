"""symtree_cmp.py OURS_DUMP.txt [--list CLASS] [--fn NAME] -- WHOLE-TREE source-level comparison of our full-debug PSYLINK
SYM (psylink_lane.py in NFS4_LANE_G mode) with the retail SYM, function by function:

  FRAME    fsize / register mask / mask offset
  LOCALS   every parameter and local: name, class (REG / REGPARM / AUTO / ARG / STAT), register number or sp offset, type, scope depth
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
2026-09-23: compare local scope depth as SCOPE. Matching block trees alone do
not prove a named local belongs to the same block (AILife checkCar showed this).
Backup: scratchpad/symtree_cmp_pre_scope_20260923.py.
2026-09-30: a function-static STAT may be absent from retail's detailed
Def/Def2 stream while surviving as a compact type-6 name. Reconcile only when
both compact streams prove the exact name and the same four-byte offset from
a detailed, same-function INT STAT anchor; keep the evidence in the report.
Backup: scratchpad/symtree_cmp_before_compact_static_20260930.py.
"""
import json
import re
import sys
from collections import Counter
from pathlib import Path

RETAIL = __import__('retail_sym').txt()
REC = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([0-9a-f]{2}) (.*)$')
DEF = re.compile(r'class (\w+) type (.*?) size (\d+)(?: dims .*?)?(?: tag (\S*))? name (\S+)$')
COMPACT = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) 6 ([A-Za-z_]\w*\.\d+)$')


def compact_stat_symbols(path):
    """Return unambiguous compact type-6 static symbols by base source name."""
    symbols = {}
    for line in open(path, errors='replace'):
        m = COMPACT.match(line)
        if m:
            full_name = m.group(2)
            symbols.setdefault(full_name.rsplit('.', 1)[0], []).append(
                (int(m.group(1), 16), full_name))
    return symbols


def compact_static_receipt(name, ours_fn, retail_fn, ours_symbols, retail_symbols):
    """Prove a missing detailed INT STAT via a same-function adjacent anchor.

    A mere compact name match is insufficient: the local suffix changes across
    builds, and the two images have different absolute data addresses.
    """
    if not any(n == name and h == 'STAT' and ty == 'INT'
               for n, h, ty, _ in ours_fn['locals']):
        return None
    candidate = ours_symbols.get(name, [])
    retail_candidate = retail_symbols.get(name, [])
    if len(candidate) != 1 or len(retail_candidate) != 1:
        return None
    native_address, native_symbol = candidate[0]
    retail_address, retail_symbol = retail_candidate[0]
    if ours_fn['stat_addrs'].get(name) != native_address:
        return None
    for anchor, home, ty, _ in retail_fn['locals']:
        if home != 'STAT' or ty != 'INT':
            continue
        if not any(n == anchor and h == 'STAT' and t == 'INT'
                   for n, h, t, _ in ours_fn['locals']):
            continue
        native_anchor = ours_symbols.get(anchor, [])
        retail_anchor = retail_symbols.get(anchor, [])
        if len(native_anchor) != 1 or len(retail_anchor) != 1:
            continue
        if ours_fn['stat_addrs'].get(anchor) != native_anchor[0][0]:
            continue
        if native_address - native_anchor[0][0] != 4:
            continue
        if retail_address - retail_anchor[0][0] != 4:
            continue
        return ('%s: %s@0x%08x / %s@0x%08x; +4 from %s in both compact '
                'streams' % (name, native_symbol, native_address,
                             retail_symbol, retail_address, anchor))
    return None


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
            cur = {'start': a, 'hdr': {}, 'locals': [], 'stat_addrs': {},
                   'blocks': [], 'depth': 0, 'end_line': None}
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
                if d.group(1) == 'STAT':
                    cur['stat_addrs'][d.group(5)] = a
    return fns


ours_path = sys.argv[1]
ours, retail = parse(ours_path), parse(RETAIL)
ours_compact, retail_compact = compact_stat_symbols(ours_path), compact_stat_symbols(RETAIL)
common = sorted(set(ours) & set(retail))
report, tally = {}, Counter()
for fn in common:
    o, r = ours[fn], retail[fn]
    issues = []
    compact_evidence = []
    for k in ('fsize', 'mask', 'maskoffs'):
        if o['hdr'].get(k) != r['hdr'].get(k):
            issues.append('FRAME %s %s != %s' % (k, o['hdr'].get(k), r['hdr'].get(k)))
    on, rn = Counter(n for n, *_ in o['locals']), Counter(n for n, *_ in r['locals'])
    for n in sorted((on - rn)):
        receipt = compact_static_receipt(n, o, r, ours_compact, retail_compact)
        if receipt:
            compact_evidence.append(receipt)
        else:
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
                # A scope tree can match while a name is bound to a different
                # block; that is a source-declaration mismatch, not CLEAN.
                if d1 != d2:
                    issues.append('SCOPE %s depth %d != %d' % (n, d1, d2))
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
    report[fn] = {'issues': issues, 'compact_stat_evidence': compact_evidence,
                  'file': r['hdr'].get('file', ''), 'end_line': span}
    kinds = {i.split()[0] for i in issues}
    for k in kinds:
        tally[k] += 1
    tally['CLEAN' if not issues else 'DIRTY'] += 1
Path(ours_path).with_name('symtree_report.json').write_text(json.dumps(report, indent=1))
print('functions with debug records: ours %d, retail %d, common %d; retail-only %d, ours-only %d' % (
    len(ours), len(retail), len(common), len(set(retail) - set(ours)), len(set(ours) - set(retail))))
print('CLEAN %d | DIRTY %d' % (tally['CLEAN'], tally['DIRTY']))
for k in ('FRAME', 'EXTRA', 'MISSING', 'MOVED', 'TYPE', 'SCOPE', 'ORDER', 'BLOCKS'):
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
