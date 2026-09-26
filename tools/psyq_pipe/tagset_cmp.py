"""tagset_cmp.py [--json OUT] [--file SUBSTR] [--core] -- per-source-file comparison of SYM type records.

Both dumpsym texts (retail = retail_sym, ours = build/psyq_g/nfs4_sym.txt) emit each object's type records
(STRTAG/UNTAG/ENTAG/TPDEF) as one run, followed by that object's function records.  A run is keyed by the source file
named in the header of the first function record that follows it, so retail and ours line up without relying on
FILE records (ours has none).  For each key the tool reports tags retail records that ours does not (MISSING), tags
ours records that retail does not (EXTRA), and whether the shared tags appear in the same order within each kind
(retail groups all tags before all typedefs; our cc1 interleaves them, an emission difference).

--core prints the core: tags recorded by >= 99% of retail's keyed files, in the order of the most common sequence.
"""
import json, re, sys, collections
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(Path(__file__).resolve().parent))
RETAIL = __import__('retail_sym').txt()
OURS = ROOT / 'build/psyq_g/nfs4_sym.txt'
TAG = re.compile(r' Def2? class (STRTAG|UNTAG|ENTAG|TPDEF) .* name (\S+)$')
FN = re.compile(r' 8c Function start')
FILE_HDR = re.compile(r'^\s+file = (.*)$')
BS = chr(92)


def runs(path):
    """Return {source_file_key: [tags in order]}."""
    out = collections.OrderedDict()
    pending = []
    want_file = False
    for l in open(path, errors='replace'):
        l = l.rstrip('\n')
        m = TAG.search(l)
        if m:
            name = m.group(2)
            # anonymous tags are numbered per object (`._12`); normalise so they compare by position only
            if name.startswith('._'):
                name = '._N'
            pending.append((m.group(1), name))
            continue
        if FN.search(l):
            want_file = bool(pending)
            continue
        if want_file:
            h = FILE_HDR.match(l)
            if h:
                key = h.group(1).strip().replace(BS, '/').upper().split('/')[-1]
                out.setdefault(key, []).extend(pending)
                pending = []
                want_file = False
    return out


def core(retail_runs, thr=0.99):
    n = len(retail_runs)
    cnt = collections.Counter()
    for tags in retail_runs.values():
        for t in set(tags):
            cnt[t] += 1
    keep = {t for t, c in cnt.items() if c >= thr * n}
    orders = collections.Counter(tuple(t for t in tags if t in keep) for tags in retail_runs.values())
    return list(orders.most_common(1)[0][0]) if orders else [], n, orders


def main():
    args = sys.argv[1:]
    r, o = runs(RETAIL), runs(OURS)
    if '--core' in args:
        seq, n, orders = core(r)
        print('retail files with type records:', n)
        print('core (>= 99%% of files): %d tags' % len(seq))
        for i, (s, c) in enumerate(orders.most_common(5)):
            print('  order variant %d used by %d files' % (i, c))
        print(' '.join('%s:%s' % t for t in seq))
        return
    only = args[args.index('--file') + 1].upper() if '--file' in args else None
    rows = []
    for key in sorted(set(r) | set(o)):
        if only and only not in key:
            continue
        rt, ot = r.get(key, []), o.get(key, [])
        rs, os_ = collections.Counter(rt), collections.Counter(ot)
        missing = sorted((rs - os_).elements())
        extra = sorted((os_ - rs).elements())
        # Retail emits every struct/union/enum tag of an object before its typedefs; our cc1 interleaves each tag
        # with its typedef.  That is an emission difference, not a source one, so order is compared per kind.
        same_order = True
        for kind in ('STRTAG', 'UNTAG', 'ENTAG', 'TPDEF'):
            shared = [t for t in rt if t[0] == kind and t in os_]
            oshared = [t for t in ot if t[0] == kind and t in rs]
            if shared != oshared:
                same_order = False
        rows.append(dict(file=key, retail=len(rt), ours=len(ot), missing=len(missing), extra=len(extra),
                         order=same_order, missing_tags=missing[:40], extra_tags=extra[:40]))
    tot = collections.Counter()
    for x in rows:
        tot['files'] += 1
        tot['retail'] += x['retail']; tot['ours'] += x['ours']
        tot['missing'] += x['missing']; tot['extra'] += x['extra']
        tot['exact'] += int(x['missing'] == 0 and x['extra'] == 0 and x['order'])
    print('files %(files)d | retail tag records %(retail)d | ours %(ours)d | missing %(missing)d | extra %(extra)d | exact files %(exact)d' % tot)
    if '--json' in args:
        Path(args[args.index('--json') + 1]).write_text(json.dumps(rows, indent=1))
    if only or '--list' in args:
        for x in rows:
            print('%-28s retail %4d ours %4d  missing %4d extra %4d order %s' % (x['file'], x['retail'], x['ours'], x['missing'], x['extra'], 'same' if x['order'] else 'DIFF'))
            if only:
                print('   MISSING', x['missing_tags'])
                print('   EXTRA  ', x['extra_tags'])


if __name__ == '__main__':
    main()
