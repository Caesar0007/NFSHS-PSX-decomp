"""Audit every duplicate-symbol function copy using independent TU anchors.

2026-10-15: supplement local_owner_cmp's fail-closed symbol-only view, not a
relaxation of it. Retail paired FILE records and native unique SLD source units
identify copies; address, occurrence order and matching contracts never do.
Unknown/conflicting owners, duplicate copies within one owner, missing copies
and malformed records cannot PASS. This compares declaration ownership only;
bytes, frame/type graphs, full SLD and fresh-build coverage remain separate.
No source, compiler output, SYM or reference is rewritten. New tool, no prior
file replaced. Parser backup is recorded in local_owner_cmp.py.
"""
import argparse
from collections import defaultdict, Counter
import json
from pathlib import Path

from local_owner_cmp import parse_owner_records, compare


def audit(native, retail):
    def groups(records):
        result = defaultdict(list)
        for record in records:
            if record.get('name'):
                result[record['name']].append(record)
        return result

    ng, rg = groups(native), groups(retail)
    names = sorted(name for name in ng.keys() | rg.keys()
                   if len(ng.get(name, [])) > 1 or len(rg.get(name, [])) > 1)
    report = dict(scope='duplicate-symbol-copies-only', functions={},
                  coverage=dict(native_records=len(native), retail_records=len(retail),
                                unnamed_native=sum(not r.get('name') for r in native),
                                unnamed_retail=sum(not r.get('name') for r in retail)))
    for name in names:
        left, right = ng.get(name, []), rg.get(name, [])
        def index(records):
            buckets = defaultdict(list)
            for record in records:
                buckets[record['provenance']['unit']].append(record)
            bad = [dict(unit=owner, count=len(rows)) for owner, rows in buckets.items()
                   if owner is None or len(rows) != 1]
            return {owner: rows[0] for owner, rows in buckets.items()
                    if owner is not None and len(rows) == 1}, bad
        ni, nb = index(left)
        ri, rb = index(right)
        copies = {}
        for owner in sorted(ni.keys() & ri.keys()):
            result = compare(ni[owner], ri[owner])
            result.update(native_start=ni[owner]['start'], retail_start=ri[owner]['start'],
                          native_origin=ni[owner]['provenance'],
                          retail_origin=ri[owner]['provenance'],
                          native_source=ni[owner]['hdr'].get('file'),
                          retail_source=ri[owner]['hdr'].get('file'))
            copies[owner] = result
        missing, extra = sorted(ri.keys()-ni.keys()), sorted(ni.keys()-ri.keys())
        if nb or rb or any(r['status'] == 'INVALID' for r in copies.values()):
            status = 'INVALID'
        elif missing or extra or not copies:
            status = 'COVERAGE'
        elif any(r['status'] != 'PASS' for r in copies.values()):
            status = 'DIFF'
        else:
            status = 'PASS'
        report['functions'][name] = dict(status=status, native_count=len(left),
            retail_count=len(right), native_bad_owners=nb, retail_bad_owners=rb,
            missing_native_owners=missing, extra_native_owners=extra, copies=copies)
    report['summary'] = dict(Counter(row['status'] for row in report['functions'].values()))
    report['coverage']['native_duplicate_records'] = sum(len(ng.get(n, [])) for n in names)
    report['coverage']['retail_duplicate_records'] = sum(len(rg.get(n, [])) for n in names)
    report['coverage']['paired_copies'] = sum(len(r['copies']) for r in report['functions'].values())
    def basename(path):
        return (path or '').replace('\\', '/').rsplit('/', 1)[-1].lower()
    report['coverage']['header_filename_differences'] = sum(
        basename(copy['native_source']) != basename(copy['retail_source'])
        for group in report['functions'].values() for copy in group['copies'].values())
    return report


def main():
    from retail_sym import txt
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native', required=True)
    parser.add_argument('--retail', default=str(txt()))
    parser.add_argument('--report', required=True)
    parser.add_argument('--require-exact', action='store_true',
                        help='Require complete duplicate-copy declaration ownership; '
                             'not a source-path, byte, frame or SLD certificate.')
    args = parser.parse_args()
    report = audit(parse_owner_records(args.native), parse_owner_records(args.retail))
    report['inputs'] = dict(native=args.native, retail=args.retail)
    Path(args.report).write_text(json.dumps(report, indent=2))
    print(report['scope'], report['coverage'], report['summary'])
    for name, row in report['functions'].items():
        print(name, row['status'], 'paired', len(row['copies']))
    if args.require_exact and (not report['functions'] or
        report['coverage']['unnamed_native'] or report['coverage']['unnamed_retail'] or
        any(row['status'] != 'PASS' for row in report['functions'].values())):
        return 1
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
