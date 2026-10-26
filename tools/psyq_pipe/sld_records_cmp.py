"""Read-only ordered interior SLD-record audit, supplementing word-tag checks.

2026-10-26: sldtree_cmp intentionally keeps the last line at an address. That
cannot certify every record: PSYLINK2.73 coalesces notes retained by ASPSX and
SLINK. Keep same-address repetitions, order, full filenames and raw encodings.
No existing comparator/reference is changed. This new tool has no predecessor
to back up; source/producer receipts: build/nc12/object_block_notes_20261026/.

Scope is STRICTLY INTERIOR addresses. Entry/end events can belong to adjacent
functions and require separate ownership attribution. Neither an exact interior
nor an empty interior proves full function/project SYM, SLD, source or bytes.
Library coverage is limited to records actually retained by retail.
"""
import argparse
from bisect import bisect_left, bisect_right
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import re

from retail_sym import txt as retail_sym_text
from sld_file_events import normalize
from sldtree_cmp import LINE, REC, directory_of, parse_dump_records

ROOT = Path(__file__).resolve().parents[2]
KINDS = {'80', '82', '84', '86', '88'}


def decode_records(text):
    records, filename = [], None
    for ordinal, row in enumerate(text.splitlines()):
        match = REC.match(row)
        if not match or match[2].lower() not in KINDS:
            continue
        address, kind, payload = int(match[1], 16), match[2].lower(), match[3]
        line = LINE.search(payload)
        if not line:
            raise ValueError('Undecoded SLD record: ' + row)
        line = int(next(value for value in line.groups() if value))
        if kind == '88':
            file_record = re.fullmatch(r'Set SLD to line \d+ of file (.+)', payload)
            if not file_record:
                raise ValueError('Undecoded SLD filename: ' + row)
            filename = normalize(file_record[1])
        records.append(dict(address=address, ordinal=ordinal, line=line,
                            file=filename, encoding=kind, payload=payload))
    records.sort(key=lambda record: (record['address'], record['ordinal']))
    return records, [record['address'] for record in records]


def interior(stream, fn):
    records, keys = stream
    begin = bisect_right(keys, fn['start'])
    end = bisect_left(keys, fn['end'])
    # Restore physical record order after the address-index lookup. Sorting by
    # address alone would conceal an incorrectly reordered producer stream.
    selected = sorted(records[begin:end], key=lambda record: record['ordinal'])
    return [dict(offset=r['address'] - fn['start'], line=r['line'],
                 file=r['file'], encoding=r['encoding'], payload=r['payload'])
            for r in selected]


def compare(native, retail, native_stream, retail_stream):
    if any(not isinstance(fn.get(key), int) for fn in (native, retail) for key in ('start', 'end')):
        return dict(status='INVALID_BOUNDS')
    n_len, r_len = native['end'] - native['start'], retail['end'] - retail['start']
    if min(n_len, r_len) <= 0 or n_len % 4 or r_len % 4:
        return dict(status='INVALID_BOUNDS')
    if n_len != r_len:
        return dict(status='LENGTH_MISMATCH', native_bytes=n_len, retail_bytes=r_len)
    n, r = interior(native_stream, native), interior(retail_stream, retail)
    for stream, fn in ((native_stream, native), (retail_stream, retail)):
        keys = stream[1]
        if bisect_left(keys, fn['start']) == bisect_left(keys, fn['end']):
            return dict(status='NO_FUNCTION_SLD_EVENTS')
    if any(row['file'] is None for row in n + r):
        return dict(status='MISSING_INTERIOR_FILENAME')
    semantic = lambda rows: [(x['offset'], x['line'], x['file']) for x in rows]
    raw = lambda rows: [(x['offset'], x['encoding'], x['payload']) for x in rows]
    semantic_equal, raw_equal = semantic(n) == semantic(r), raw(n) == raw(r)
    status = ('DIFF' if not semantic_equal else 'EMPTY_INTERIOR' if not n
              else 'INTERIOR_EXACT' if raw_equal else 'SEMANTIC_INTERIOR_EXACT')
    first = next((i for i, (a, b) in enumerate(zip(semantic(n), semantic(r)))
                  if a != b), min(len(n), len(r)))
    return dict(status=status, semantic_sequence_equal=semantic_equal,
                raw_payload_sequence_equal=raw_equal, native_count=len(n),
                retail_count=len(r), first_difference=None if semantic_equal else first,
                native_records=n, retail_records=r)


def index_functions(records):
    grouped = defaultdict(list)
    for record in records:
        grouped[record['name']].append(record)
    return ({name: rows[0] for name, rows in grouped.items() if len(rows) == 1},
            {name: len(rows) for name, rows in grouped.items() if len(rows) != 1})


def strict_failure(results, require_raw=False):
    allowed = {'INTERIOR_EXACT', 'SEMANTIC_INTERIOR_EXACT', 'EMPTY_INTERIOR'}
    return any(row['status'] not in allowed or
               (require_raw and not row.get('raw_payload_sequence_equal'))
               for row in results.values())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native', default=str(ROOT/'build/psyq_g/nfs4_sym.txt'))
    parser.add_argument('--retail', default=str(retail_sym_text()))
    parser.add_argument('--manifest', help='JSON checkpoint containing absolute_contract_manifest')
    parser.add_argument('--fn', action='append', default=[], help='select/add an exact mangled name')
    parser.add_argument('--report', required=True)
    parser.add_argument('--require-exact', action='store_true', help='fail on any semantic record difference')
    parser.add_argument('--require-raw', action='store_true', help='also require identical interior payload encodings')
    args = parser.parse_args()
    paths = [Path(args.native), Path(args.retail)]
    streams = [decode_records(path.read_text(errors='replace')) for path in paths]
    indices = [index_functions(parse_dump_records(path)[0]) for path in paths]
    (native, n_dup), (retail, r_dup) = indices
    selected = set(args.fn)
    if args.manifest:
        manifest = json.loads(Path(args.manifest).read_text())['absolute_contract_manifest']
        if not isinstance(manifest, list) or not manifest:
            raise ValueError('Empty or invalid function manifest')
        for row in manifest:
            if not isinstance(row, list) or len(row) != 2 or not all(isinstance(x, str) for x in row):
                raise ValueError('Invalid function manifest row: ' + repr(row))
            selected.add(row[1])
    if not args.manifest and not args.fn:
        selected = set(native) & set(retail) | set(n_dup) | set(r_dup)
    if not selected:
        raise ValueError('No selected functions; refusing an empty success')
    results = {}
    for name in sorted(selected):
        if name in n_dup or name in r_dup:
            result = dict(status='AMBIGUOUS_NAME', native_copies=n_dup.get(name, int(name in native)),
                          retail_copies=r_dup.get(name, int(name in retail)))
        elif name not in native or name not in retail:
            result = dict(status='NATIVE_MISSING' if name not in native else 'RETAIL_MISSING')
        else:
            result = compare(native[name], retail[name], *streams)
        result['directory'] = directory_of(retail.get(name, {}).get('hdr', {}).get('file', ''))
        results[name] = result
    counts = dict(Counter(row['status'] for row in results.values()))
    directories = {}
    for result in results.values():
        summary = directories.setdefault(result['directory'], Counter())
        summary['selected_functions'] += 1
        summary[result['status']] += 1
    report = dict(scope='selected unique function interiors; entry/end ownership NOT covered',
                  inputs={label: dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest())
                          for label, path in zip(('native', 'retail'), paths)},
                  counts=counts, directories={key: dict(value) for key, value in sorted(directories.items())},
                  selected_function_count=len(results), functions=results,
                  ambiguous_names={'native': n_dup, 'retail': r_dup},
                  native_only=sorted(set(native)-set(retail)-set(r_dup)),
                  retail_only=sorted(set(retail)-set(native)-set(n_dup)),
                  full_function_or_project_exactness_proved=False,
                  freshness='Read-only dumps; caller must independently verify current source/build/link bindings')
    output = Path(args.report)
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=1)+'\n')
    print('Selected interior record sequences:', counts)
    print('Boundary attribution, source freshness, code and full SYM exactness are separate checks.')
    if (args.require_exact or args.require_raw) and strict_failure(results, args.require_raw):
        raise SystemExit(1)


if __name__ == '__main__':
    main()
