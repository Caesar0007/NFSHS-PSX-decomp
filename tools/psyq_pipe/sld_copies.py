"""Read-only SLD audit of all duplicate-symbol copies, paired by proven TU.

2026-10-15: supplements sldtree_cmp's AMBIGUOUS_NAME result without relaxing
that legacy audit. Uses paired retail FILE/native unique SLD source ownership
from local_owner_cmp. Addresses join two parsers WITHIN ONE dump only; never
pair native/retail copies by address, occurrence order, or best-match score.
Requires complete declaration ownership too. No line normalization, source,
compiler-output, SYM, instruction, reference, or binary rewriting occurs.
Fresh debug compilation and linked-byte checks remain separate prerequisites.
This is a new tool; prior parser backup is documented in sldtree_cmp.py.
"""
import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path

from local_owner_cmp import parse_owner_records
from local_owner_copies import audit as owner_audit
from sldtree_cmp import compare_function, directory_of, parse_dump_records


def load_dump(path):
    owners = parse_owner_records(path)
    records, keys, events = parse_dump_records(path)
    by_record = defaultdict(list)
    for record in records:
        by_record[(record.get('name'), record['start'])].append(record)
    by_owner = defaultdict(list)
    for owner in owners:
        # Exact identity inside this same input, not a cross-image VA heuristic.
        matches = by_record[(owner.get('name'), owner['start'])]
        if len(matches) == 1:
            by_owner[(owner.get('name'), owner['provenance']['unit'])].append(matches[0])
    return dict(owners=owners, functions=by_owner, keys=keys, events=events)


def audit(native, retail):
    ownership = owner_audit(native['owners'], retail['owners'])
    groups, summary = {}, Counter()
    for name, group in ownership['functions'].items():
        copies = {}
        for unit, owner in group['copies'].items():
            left = native['functions'].get((name, unit), [])
            right = retail['functions'].get((name, unit), [])
            if len(left) != 1 or len(right) != 1:
                result = dict(status='INVALID_RECORD_IDENTITY')
            else:
                result = compare_function(left[0], right[0], native['keys'],
                    native['events'], retail['keys'], retail['events'])
                result.update(native_source=left[0]['hdr'].get('file'),
                              retail_source=right[0]['hdr'].get('file'))
                def source_identity(path):
                    return (directory_of(path),
                            path.replace('\\', '/').rsplit('/', 1)[-1].lower()) if path else None
                result['source_file_equal'] = (
                    source_identity(result['native_source']) is not None and
                    source_identity(result['native_source']) == source_identity(result['retail_source']))
                if not result['source_file_equal']:
                    result['sld_candidate'] = result['status']
                    result['status'] = 'SOURCE_FILE_MISMATCH'
            result['declaration_status'] = owner['status']
            if owner['status'] != 'PASS':
                result['sld_candidate'] = result['status']
                result['status'] = 'INVALID_DECLARATION_OWNERSHIP'
            copies[unit] = result
            summary[result['status']] += 1
        status = ('INVALID_OWNERSHIP' if group['status'] == 'INVALID' else
                  'COVERAGE' if group['status'] == 'COVERAGE' else
                  'EXACT' if copies and all(c['status'] == 'EXACT' for c in copies.values())
                  else 'DIFF')
        groups[name] = dict(status=status, declaration_status=group['status'],
                           copies=copies,
                           missing_native_owners=group['missing_native_owners'],
                           extra_native_owners=group['extra_native_owners'],
                           native_bad_owners=group['native_bad_owners'],
                           retail_bad_owners=group['retail_bad_owners'])
    return dict(scope='duplicate-symbol-copies-only', coverage=ownership['coverage'],
                copy_statuses=dict(summary), functions=groups)


def main():
    from retail_sym import txt
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native', required=True)
    parser.add_argument('--retail', default=str(txt()))
    parser.add_argument('--report', required=True)
    parser.add_argument('--require-exact', action='store_true')
    args = parser.parse_args()
    report = audit(load_dump(args.native), load_dump(args.retail))
    report['inputs'] = {key: dict(path=str(path), sha256=hashlib.sha256(
        Path(path).read_bytes()).hexdigest())
        for key, path in [('native', args.native), ('retail', args.retail)]}
    Path(args.report).write_text(json.dumps(report, indent=2)+'\n')
    print(report['scope'], report['coverage'], report['copy_statuses'])
    for name, group in report['functions'].items():
        for unit, copy in group['copies'].items():
            print(name, unit, copy['status'], 'tags', copy.get('tag_diffs'),
                  '/', copy.get('retail_words'), 'end', copy.get('native_end_delta'),
                  '/', copy.get('retail_end_delta'))
    if args.require_exact and (not report['functions'] or
        report['coverage']['unnamed_native'] or report['coverage']['unnamed_retail'] or
        any(g['status'] != 'EXACT' for g in report['functions'].values())):
        return 1
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
