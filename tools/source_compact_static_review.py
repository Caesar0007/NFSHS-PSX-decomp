"""Corroborate detailed-local surpluses against compact static SYM records.

2026-10-29: additive, read-only review; this new tool replaces no existing
tool and needs no prior-file backup. Reuse the established fail-closed
same-function INT-STAT/+4-anchor receipt. Never turn a raw declaration DIFF
into PASS or claim that a compact symbol supplies a missing detailed type.
Reject stale inputs and globally ambiguous function names rather than using
the legacy parser's collapsed function map to pick a copy by address.
"""
import argparse
import ast
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools' / 'psyq_pipe'))
# symtree_cmp is an old CLI with unguarded top-level execution. Load only its
# existing regex/three pure definitions, never its CLI or output-writing code.
# No existing comparator is edited, copied with changed rules, or weakened.
HELPER = ROOT / 'tools' / 'psyq_pipe' / 'symtree_cmp.py'
_wanted = {'REC', 'DEF', 'COMPACT', 'compact_stat_symbols', 'compact_static_receipt', 'parse'}
_nodes = []
_seen = set()
for _node in ast.parse(HELPER.read_text(encoding='utf-8')).body:
    _name = (_node.name if isinstance(_node, ast.FunctionDef) else
             _node.targets[0].id if isinstance(_node, ast.Assign) and len(_node.targets) == 1
             and isinstance(_node.targets[0], ast.Name) else None)
    if _name in _wanted:
        _nodes.append(_node)
        _seen.add(_name)
assert _seen == _wanted
exec(compile(ast.Module(body=_nodes, type_ignores=[]), str(HELPER), 'exec'), globals())


def corroborate(row, native_function, retail_function, native_symbols, retail_symbols):
    """Annotate evidence only. Never edit the row or either comparison status."""
    if row['pairing'] != 'PAIRED' or row['native_occurrences'] != 1 or row['retail_occurrences'] != 1:
        return []
    found = []
    for balance in row.get('name_balance', []):
        if balance['native_count'] != 1 or balance['retail_count'] != 0:
            continue
        candidates = balance['native_candidates']
        if len(candidates) != 1 or candidates[0]['home'] != 'STAT' or candidates[0]['type'] != 'INT':
            continue
        name = balance['name']
        receipt = compact_static_receipt(name, native_function, retail_function,
                                         native_symbols, retail_symbols)
        if receipt is None:
            continue
        found.append(dict(name=name, native_local_tuple=candidates[0], receipt=receipt,
                          native_compact=native_symbols[name], retail_compact=retail_symbols[name],
                          native_detailed_status=row['declaration_owner_status'],
                          compact_name_and_relative_storage_corroborated=True,
                          retail_detailed_type_and_scope_still_absent=True,
                          original_source_uses_not_proved=True,
                          strict_owner_or_SLD_status_changed=False))
    return found


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def audit(queue_path, root=ROOT):
    queue_path, root = Path(queue_path), Path(root)
    queue = json.loads(queue_path.read_text())
    paths = {}
    for key in ('native', 'retail'):
        raw = queue['inputs'][key]
        path = Path(raw['path'])
        if not path.is_absolute():
            path = root / path
        if sha(path) != raw['sha256']:
            raise ValueError('Stale ' + key + ' queue input')
        paths[key] = path
    for rel, digest in queue['source_files_sha256'].items():
        if sha(root / rel) != digest:
            raise ValueError('Stale queue source: ' + rel)
    native, retail = parse(paths['native']), parse(paths['retail'])
    nc, rc = compact_stat_symbols(paths['native']), compact_stat_symbols(paths['retail'])
    names = Counter(row['name'] for row in queue['functions'])
    rows, ambiguous = [], []
    for row in queue['functions']:
        if names[row['name']] != 1:
            ambiguous.append(dict(unit=row['unit'], name=row['name']))
            continue
        n, r = native.get(row['name']), retail.get(row['name'])
        if n is None or r is None:
            continue
        support = corroborate(row, n, r, nc, rc)
        if support:
            rows.append(dict(unit=row['unit'], function=row['name'], directory=row['directory'],
                             declaration_owner_status=row['declaration_owner_status'], support=support,
                             covered_local_frame_SLD_exact=row['covered_local_frame_SLD_exact']))
    directories = {name: dict(corroborated_surplus_occurrences=0,
                             strict_declaration_owner_DIFF=value.get('declaration_owner_DIFF', 0),
                             strict_covered_contracts=value.get('covered_local_frame_SLD_exact', 0),
                             retail_metadata_scope=value['retail_metadata_scope'])
                   for name, value in queue['directories'].items()}
    for row in rows:
        directories[row['directory']]['corroborated_surplus_occurrences'] += len(row['support'])
    return dict(schema=1, queue_path=str(queue_path), queue_sha256=sha(queue_path),
                existing_helper_source_sha256=sha(HELPER),
                inputs=queue['inputs'], raw_owner_and_SLD_statuses_unchanged=True,
                source_build_freshness_certified=False, full_goal_complete=False,
                directories=directories,
                corroborated_surplus_occurrences=sum(len(row['support']) for row in rows),
                functions=rows, ambiguous_function_names_not_selected=ambiguous,
                limitations=['Compact names/relative storage do not prove missing detailed types or lexical ownership.',
                             'Do not delete a compact-supported static merely to clean the detailed-record queue.',
                             'The source/runtime/byte/build and every other raw SYM obligation remain separate.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--queue', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    report = audit(args.queue)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print('Compact-supported detailed-local surplus occurrences:', report['corroborated_surplus_occurrences'])
    print('Strict declaration/SLD comparisons remain unchanged; missing type/scope facts remain unresolved.')


if __name__ == '__main__':
    main()
