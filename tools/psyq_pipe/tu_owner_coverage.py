"""Selected-TU function coverage, including header-defined and repeated copies.

2026-10-15: source-basename filtering misses retail header-owned destructors.
Use independently proven FILE/SLD compilation-unit anchors from the existing
owner parser. Never pair by VA, order or a best-matching declaration. This is
coverage/declaration ownership. from_dumps also reports every empty scope
region and strict source-line comparison. It is NOT full type/frame/global
validation or a certificate of recovered literal source text.
Only available retail SDK records are required; stripped information is not
invented. No source, compiler output, SYM, reference or binary is rewritten.
"""
from collections import Counter, defaultdict
import hashlib
from pathlib import Path

from local_owner_cmp import compare, parse_owner_records, unit_name
from sldtree_cmp import compare_function, directory_of, parse_dump_records


# 2026-10-15: declaration equality cannot detect empty scope regions. The
# byte-PASS AnimKeyPoints statement-expression trial had exact parameters but
# an extra region. Keep separate full-region/SLD receipts, without relaxing any
# existing comparator. Backup: build/nc12/tu_owner_coverage_before_scope_receipts_20261015.py.
def _sld_dump(path, owners):
    records, keys, events = parse_dump_records(path)
    identities = defaultdict(list)
    for record in records:
        identities[(record.get('name'), record['start'])].append(record)
    functions = defaultdict(list)
    for owner in owners:
        # Address identity joins two parsers WITHIN this one dump only.
        # Native/retail pairing remains independently proven (TU,name).
        matches = identities[(owner.get('name'), owner['start'])]
        if len(matches) == 1:
            functions[(owner.get('name'), owner['provenance']['unit'])].append(matches[0])
    return dict(functions=functions, keys=keys, events=events)


def add_scope_receipts(report, native, retail):
    """Preserve all empty regions and source-line differences per paired owner.

    Coverage means the records were compared, NOT that they agree. Only SDK
    records with no retail region/SLD supply are explicitly NOT_SUPPLIED.
    This still does not validate global/type-body records, runtime behavior,
    source-only debug-elided objects or uniqueness of original source text.
    """
    for unit, summary in report['units'].items():
        for name, row in summary['functions'].items():
            left = native['functions'].get((name, unit), [])
            right = retail['functions'].get((name, unit), [])
            if len(left) != 1 or len(right) != 1:
                summary['errors'].append('invalid scope/SLD record identity: '+name)
                row['scope_regions'] = dict(status='INVALID_RECORD_IDENTITY')
                row['sld'] = dict(status='INVALID_RECORD_IDENTITY')
            else:
                n, r = left[0], right[0]
                nb, rb = [v[:2] for v in n['blocks']], [v[:2] for v in r['blocks']]
                same_length = (n['end'] is not None and r['end'] is not None and
                               n['end']-n['start'] == r['end']-r['start'])
                scope_status = ('NOT_SUPPLIED' if summary['partial'] and not rb else
                                'PASS' if same_length and nb == rb else 'DIFF')
                row['scope_regions'] = dict(status=scope_status, native=nb, retail=rb,
                                            function_lengths_equal=same_length)
                try:
                    sld = compare_function(n, r, native['keys'], native['events'], retail['keys'], retail['events'])
                except (KeyError, TypeError, ValueError) as error:
                    sld = dict(status='INVALID_SOURCE_RECORD', error=str(error))
                if sld['status'] in ('INVALID_SOURCE_RECORD', 'INVALID_BOUNDS', 'UNALIGNED_BOUNDS'):
                    summary['errors'].append('invalid scope/SLD source record: '+name)
                def source_identity(fn):
                    path = fn['hdr'].get('file')
                    return (directory_of(path), path.replace('\\', '/').rsplit('/', 1)[-1].lower()) if path else None
                sld['source_file_equal'] = (source_identity(n) is not None and source_identity(n) == source_identity(r))
                if summary['partial'] and sld['status'] == 'NO_FUNCTION_SLD_EVENT':
                    sld['status'] = 'NOT_SUPPLIED'
                elif not sld['source_file_equal']:
                    sld['sld_candidate'] = sld['status']
                    sld['status'] = 'SOURCE_FILE_MISMATCH'
                row['sld'] = sld
            row['declaration_scope_sld_status'] = ('EXACT' if row['status'] == 'PASS' and
                row['scope_regions']['status'] == 'PASS' and row['sld']['status'] == 'EXACT' else 'INCOMPLETE')
        summary['scope_region_statuses'] = dict(Counter(r['scope_regions']['status'] for r in summary['functions'].values()))
        summary['sld_statuses'] = dict(Counter(r['sld']['status'] for r in summary['functions'].values()))
        summary['declaration_scope_sld_statuses'] = dict(Counter(r['declaration_scope_sld_status'] for r in summary['functions'].values()))
        summary['coverage_complete'] = not summary['errors']
    report['coverage_complete'] = all(row['coverage_complete'] for row in report['units'].values())
    directories = {}
    for unit, summary in report['units'].items():
        group = directory_of(summary['source'])
        entry = directories.setdefault(group, dict(scope='selected-TUs-only', selected_units=[],
            retail_records=0, compared=0, non_primary_source_records=0,
            complete_selected_tu_coverage=True, partial_retail=False,
            declaration_statuses=Counter(), scope_region_statuses=Counter(),
            sld_statuses=Counter(), declaration_scope_sld_statuses=Counter()))
        entry['selected_units'].append(unit)
        for key in ('retail_records', 'compared', 'non_primary_source_records'):
            entry[key] += summary[key]
        entry['complete_selected_tu_coverage'] &= summary['coverage_complete']
        entry['partial_retail'] |= summary['partial']
        for key in ('declaration_statuses', 'scope_region_statuses', 'sld_statuses', 'declaration_scope_sld_statuses'):
            entry[key].update(summary[key])
    for entry in directories.values():
        entry['selected_units'].sort()
        for key in ('declaration_statuses', 'scope_region_statuses', 'sld_statuses', 'declaration_scope_sld_statuses'):
            entry[key] = dict(entry[key])
    report['directories'] = directories
    return report


def audit(native, retail, sources):
    selected = {}
    for source in sources:
        path = str(source).replace('\\', '/')
        unit = unit_name(path)
        if not unit or unit in selected:
            raise ValueError('Missing/ambiguous selected TU basename: '+path)
        selected[unit] = dict(source=path, partial=any(
            '/'+group+'/' in '/'+path.lower() for group in ('eaclib', 'syslib')))
    if not selected:
        raise ValueError('No selected compilation units')
    ni, ri = defaultdict(list), defaultdict(list)
    for index, records in ((ni, native), (ri, retail)):
        for record in records:
            index[(record['provenance']['unit'], record.get('name'))].append(record)
    units = {}
    for unit, info in selected.items():
        keys = {key for key in ri if key[0] == unit}
        names = {key[1] for key in keys}
        errors, functions = [], {}
        if not keys:
            errors.append('no proven retail records for selected owner')
        for key in sorted(keys, key=lambda k: str(k[1])):
            name = key[1]
            left, right = ni.get(key, []), ri[key]
            if not name or len(right) != 1 or right[0]['errors']:
                errors.append('invalid/duplicate retail record: '+str(name))
                continue
            if len(left) != 1:
                errors.append('missing/duplicate native record: '+str(name))
                continue
            if ni.get((None, name)) or ri.get((None, name)):
                errors.append('unknown-owner copy cannot be excluded: '+name)
                continue
            row = compare(left[0], right[0])
            if row['status'] == 'INVALID':
                errors.append('invalid native declaration record: '+name)
            basename = right[0]['hdr'].get('file', '').replace('\\', '/').rsplit('/', 1)[-1].lower()
            row.update(native_source=left[0]['hdr'].get('file'),
                       retail_source=right[0]['hdr'].get('file'),
                       non_primary_source=basename != info['source'].rsplit('/', 1)[-1].lower())
            functions[name] = row
        extra = sorted(str(name) for owner, name in ni if owner == unit and name not in names)
        if extra and not info['partial']:
            errors.append('extra native records in complete game TU: '+', '.join(extra))
        units[unit] = dict(**info, coverage_complete=not errors, errors=errors,
                           retail_records=sum(len(ri[key]) for key in keys),
                           compared=len(functions),
                           non_primary_source_records=sum(row['non_primary_source'] for row in functions.values()),
                           declaration_statuses=dict(Counter(row['status'] for row in functions.values())),
                           uncovered_native_records=extra, functions=functions)
    return dict(scope='selected-TU-all-function-record-ownership',
                coverage_complete=all(row['coverage_complete'] for row in units.values()),
                units=units)


def from_dumps(native, retail, sources):
    no, ro = parse_owner_records(native), parse_owner_records(retail)
    report = add_scope_receipts(audit(no, ro, sources), _sld_dump(native, no), _sld_dump(retail, ro))
    report['inputs'] = {key: dict(path=str(path), sha256=hashlib.sha256(
        Path(path).read_bytes()).hexdigest()) for key,path in [('native',native),('retail',retail)]}
    return report
