"""Read-only, occurrence-preserving queue for covered SYM declaration restoration.

2026-10-29: the legacy EXTRA issue list can collapse repeated local names.
Pair functions only by independent compilation-unit provenance and symbol;
never pick duplicate copies by VA, ordinal, or apparent contract similarity.
Keep every ordered local tuple and all candidates for a repeated-name surplus.

This is NOT a source-restoration certificate. It does not prove source-only
object necessity, original macro text, global/type graphs, STAT storage VAs,
byte matching, or full-source build freshness. SDK/library coverage is limited
to supplied retail function records. Existing parsers/comparators are reused,
not relaxed. No source, compiler output, SYM, or reference is modified. New
tool: no existing tool is replaced and no prior-file backup is necessary.
"""
import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools' / 'psyq_pipe'))
from local_owner_cmp import parse_owner_records, compare
from sldtree_cmp import parse_dump_records, directory_of, line_at
import sld_file_events as files
from source_review_inventory import mask_trivia, SYNTHETIC, REVIEW, source_group

# Wider register/stack artifacts are kept separate from the legacy spelling
# scan. A lexical hit is a review candidate, not proof of an invented object.
REGISTER_ARTIFACT = re.compile(
    r'\b(?:in_(?:[avst]\d+|ra|sp|fp|gp)|unaff_[A-Za-z0-9_]+'
    r'|extraout_[A-Za-z0-9_]+|[auisbcfpd]+Stack[0-9a-fA-Fx_]+)\b')

# 2026-10-30: InsertTrigger exposed a gap in the legacy variable-name scan.
# Keep VA-derived label/reference candidates separate: a lexical hit needs
# SYM/canonical-source review,not an automatic invented-object verdict.
# Backup: build/nc12/aitriger_source_20261030/source_owner_queue.py.before.
ADDRESS_DERIVED = re.compile(r'\b(?:LAB|lbl)_[0-9a-fA-F]{8}\b')


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def key_of(record):
    return record.get('provenance', {}).get('unit'), record.get('name')


def pair_records(native, retail):
    """Fail closed for missing provenance and every repeated (TU,symbol) key."""
    ng, rg = defaultdict(list), defaultdict(list)
    for record in native:
        ng[key_of(record)].append(record)
    for record in retail:
        rg[key_of(record)].append(record)
    out = []
    for key in sorted(ng.keys() | rg.keys(), key=lambda x: (x[0] or '', x[1] or '')):
        n, r = ng.get(key, []), rg.get(key, [])
        status = ('INVALID' if not all(key) or len(n) > 1 or len(r) > 1 else
                  'MISSING_NATIVE' if not n else 'NATIVE_ONLY' if not r else 'PAIRED')
        out.append(dict(unit=key[0], name=key[1], pairing=status,
                        native=n, retail=r))
    return out


def name_balance(native, retail):
    """Count repeated names but never guess which same-name occurrence is extra.

    A surplus name count is NOT a count of invented source objects. A missing
    inline producer can also explain a name/record difference. Full candidates
    retain their home, type, dimensions, scope path, and range for investigation.
    """
    nc = Counter(x['name'] for x in native)
    rc = Counter(x['name'] for x in retail)
    out = []
    for name in sorted(nc.keys() | rc.keys()):
        if nc[name] != rc[name]:
            out.append(dict(name=name, native_count=nc[name], retail_count=rc[name],
                            native_surplus=max(0, nc[name] - rc[name]),
                            retail_surplus=max(0, rc[name] - nc[name]),
                            native_candidates=[x for x in native if x['name'] == name],
                            retail_candidates=[x for x in retail if x['name'] == name]))
    return out


def canonical_file(path):
    return files.normalize(path)


def attach_coordinates(owners, coordinates):
    """Address is used only to attach records WITHIN one dump, not to pair dumps."""
    assert len(owners) == len(coordinates), 'parser coverage disagreement'
    for owner, coord in zip(owners, coordinates):
        assert owner['name'] == coord['name'] and owner['start'] == coord['start']
        owner['_coordinates'] = coord


def audit(native_path, retail_path, *, root=ROOT):
    native_path, retail_path, root = map(Path, (native_path, retail_path, root))
    n, r = parse_owner_records(native_path), parse_owner_records(retail_path)
    nr, nk, ne = parse_dump_records(native_path)
    rr, rk, re = parse_dump_records(retail_path)
    attach_coordinates(n, nr)
    attach_coordinates(r, rr)
    nf, rf = files.events(native_path), files.events(retail_path)
    report = dict(schema=1, scope='all supplied function occurrences, not whole raw SYM',
                  full_goal_complete=False, source_freshness_certified=False,
                  inputs=dict(native=dict(path=str(native_path), sha256=sha(native_path)),
                              retail=dict(path=str(retail_path), sha256=sha(retail_path))),
                  limitations=[
                      'Unpaired/ambiguous copies are retained and cannot receive exact status.',
                      'Name surpluses are counts with full candidates, not inferred source objects.',
                      'Local tuples exclude STAT storage VAs and global/complete type-graph validation.',
                      'Lexical names and markers are review locations, not distinct source objects.',
                      'Debug-elided source-only carriers need independent source/compiler review.',
                      'This tool does not build, verify bytes/branches, or certify original source text.',
                      'EACLIB/SYSLIB records are partial coverage, never whole-library certification.'],
                  native_function_occurrences=len(n), retail_function_occurrences=len(r),
                  functions=[], directories={}, source_files_sha256={}, source_locations=[])
    counts = defaultdict(Counter)
    for pair in pair_records(n, r):
        origins = pair['retail'] or pair['native']
        group = directory_of(origins[0]['hdr'].get('file', '')) if origins else 'OTHER'
        row = dict(unit=pair['unit'], name=pair['name'], directory=group,
                   pairing=pair['pairing'], native_occurrences=len(pair['native']),
                   retail_occurrences=len(pair['retail']))
        c = counts[group]
        c['native_function_occurrences'] += len(pair['native'])
        c['retail_function_occurrences'] += len(pair['retail'])
        c['pairing_' + pair['pairing']] += 1
        if pair['pairing'] != 'PAIRED':
            row.update(native_records=pair['native'], retail_records=pair['retail'])
            report['functions'].append(row)
            continue
        a, b = pair['native'][0], pair['retail'][0]
        ac, bc = a['_coordinates'], b['_coordinates']
        owner = compare(a, b)
        balance = name_balance(a['locals'], b['locals'])
        if owner['status'] == 'INVALID':
            row.update(declaration_owner_status='INVALID', owner_errors=owner,
                       native_records=[a], retail_records=[b], name_balance=balance,
                       covered_local_frame_SLD_exact=False)
            c['declaration_owner_INVALID'] += 1
            c['native_local_tuple_occurrences'] += len(a['locals'])
            c['retail_local_tuple_occurrences'] += len(b['locals'])
            c['native_name_surplus_occurrences'] += sum(x['native_surplus'] for x in balance)
            c['retail_name_surplus_occurrences'] += sum(x['retail_surplus'] for x in balance)
            report['functions'].append(row)
            continue
        ah, bh = a['hdr'], b['hdr']
        frame = all(k in ah and k in bh and ah[k] == bh[k] for k in ('fp', 'fsize', 'retreg', 'mask', 'maskoffs'))
        header = 'line' in ah and 'line' in bh and ah['line'] == bh['line']
        filename = bool(ah.get('file') and bh.get('file') and canonical_file(ah['file']) == canonical_file(bh['file']))
        block_lines = (ac['blocks'] == bc['blocks'] and
                       all(x[2] is not None for x in ac['blocks'] + bc['blocks']))
        end_line = ac['end_line'] is not None and bc['end_line'] is not None and ac['end_line'] == bc['end_line']
        size = ac['end'] - ac['start']
        rsize = bc['end'] - bc['start']
        tag_diffs, missing_tags = [], []
        if size == rsize and size > 0 and size % 4 == 0:
            for off in range(0, size, 4):
                actual = line_at(nk, ne, ac['start'] + off)
                expected = line_at(rk, re, bc['start'] + off)
                if actual is None or expected is None:
                    missing_tags.append(dict(offset=off, native=actual, retail=expected))
                if actual != expected:
                    tag_diffs.append(dict(offset=off, native=actual, retail=expected))
        file_error = None
        try:
            files.check(nf, rf, ac, bc)
        except AssertionError as exc:
            file_error = str(exc)
        tags = size == rsize and size > 0 and size % 4 == 0 and not tag_diffs and not missing_tags
        exact = (owner['status'] == 'PASS' and frame and header and filename and
                 block_lines and end_line and tags and file_error is None)
        row.update(native_source=ah.get('file'), retail_source=bh.get('file'),
                   native_origin=a['provenance'], retail_origin=b['provenance'],
                   declaration_owner_status=owner['status'], owner_differences=owner['differences'],
                   native_local_tuples=a['locals'], retail_local_tuples=b['locals'],
                   name_balance=balance, frame_exact=frame, header_line_exact=header,
                   header_filename_exact=filename, block_lines_exact=block_lines,
                   end_line_exact=end_line, instruction_line_tags_exact=tags,
                   instruction_line_differences=tag_diffs, missing_tag_coverage=missing_tags,
                   instruction_file_coverage_error=file_error,
                   native_word_count=size // 4, retail_word_count=rsize // 4,
                   covered_local_frame_SLD_exact=exact,
                   stat_storage_addresses_not_checked=sum(x['home'] == 'STAT' for x in b['locals']))
        c['declaration_owner_' + owner['status']] += 1
        c['native_local_tuple_occurrences'] += len(a['locals'])
        c['retail_local_tuple_occurrences'] += len(b['locals'])
        c['native_name_surplus_occurrences'] += sum(x['native_surplus'] for x in balance)
        c['retail_name_surplus_occurrences'] += sum(x['retail_surplus'] for x in balance)
        c['covered_local_frame_SLD_exact'] += exact
        c['tag_difference_words'] += len(tag_diffs)
        report['functions'].append(row)
    for path in sorted((root / 'recon').rglob('*')):
        if not path.is_file() or path.suffix.lower() not in {'.c', '.cpp', '.cxx', '.h', '.hpp', '.inl'}:
            continue
        rel = path.relative_to(root).as_posix()
        if rel.startswith(('recon/mod/', 'recon/game-mod/', 'recon/syslib-mod/')):
            continue
        text = path.read_text(encoding='utf-8', errors='replace')
        report['source_files_sha256'][rel] = sha(path)
        counts[source_group(rel)]['source_files_scanned'] += 1
        for kind, regex, content in [('synthetic_identifier', SYNTHETIC, mask_trivia(text)),
                                     ('register_artifact_identifier', REGISTER_ARTIFACT, mask_trivia(text)),
                                     ('address_derived_identifier', ADDRESS_DERIVED, mask_trivia(text)),
                                     ('review_marker', REVIEW, text)]:
            for match in regex.finditer(content):
                report['source_locations'].append(dict(kind=kind, file=rel,
                    line=content.count('\n', 0, match.start()) + 1, text=match.group()))
                counts[source_group(rel)]['lexical_' + kind + '_locations'] += 1
    for group in ('GAME/COMMON', 'GAME/PSX', 'FRONTEND/COMMON', 'FRONTEND/PSX',
                  'EACLIB/PSX', 'SYSLIB/PSX'):
        c = counts[group]
        for field in ('native_function_occurrences', 'retail_function_occurrences',
                      'native_name_surplus_occurrences', 'retail_name_surplus_occurrences',
                      'lexical_synthetic_identifier_locations', 'lexical_register_artifact_identifier_locations',
                      'lexical_address_derived_identifier_locations',
                      'lexical_review_marker_locations'):
            c.setdefault(field, 0)
    report['directories'] = {k: dict(v) for k, v in sorted(counts.items())}
    for group, summary in report['directories'].items():
        summary['retail_metadata_scope'] = 'PARTIAL' if group.startswith(('EACLIB/', 'SYSLIB/')) else 'SUPPLIED_FUNCTION_RECORDS_ONLY'
        summary['function_pairing_scope'] = ('NO_RETAIL_FUNCTION_RECORDS' if not summary.get('retail_function_occurrences') else
            'COMPLETE_PROVENANCE_PAIRING' if summary.get('pairing_PAIRED', 0) == summary['retail_function_occurrences']
            and summary.get('native_function_occurrences') == summary['retail_function_occurrences'] else 'INCOMPLETE_OR_AMBIGUOUS')
    report['all_function_occurrences_accounted_for'] = (
        sum(x['native_occurrences'] for x in report['functions']) == len(n) and
        sum(x['retail_occurrences'] for x in report['functions']) == len(r))
    assert report['all_function_occurrences_accounted_for']
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native', required=True, type=Path)
    parser.add_argument('--retail', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    report = audit(args.native, args.retail)
    args.output.mkdir(parents=True, exist_ok=True)
    (args.output / 'covered-owner-queue.json').write_text(json.dumps(report, indent=2) + '\n')
    for group, summary in report['directories'].items():
        subset = dict(directory=group, summary=summary, full_goal_complete=False,
                      inputs=report['inputs'], scope=report['scope'], limitations=report['limitations'],
                      functions=[x for x in report['functions'] if x['directory'] == group],
                      source_locations=[x for x in report['source_locations'] if source_group(x['file']) == group])
        (args.output / (group.replace('/', '_').lower() + '.json')).write_text(json.dumps(subset, indent=2) + '\n')
        print(group, json.dumps(summary, sort_keys=True))
    print('Accounted for native/retail function occurrences:', report['native_function_occurrences'], report['retail_function_occurrences'])
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
