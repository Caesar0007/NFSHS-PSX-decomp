"""Read-only local declaration ownership comparison for native/retail SYM.

2026-10-14: symtree_cmp compares local depth and block trees independently.
Neither proves that a local at depth N belongs to the same sibling block.
Track its actual enclosing block and compare function-relative boundaries and
the lexical child path. These are debug declaration regions, NOT runtime
live ranges. No source, compiler output, SYM, or reference is rewritten.

This supplements, never replaces, bytes/link, declaration/type, whole-tree and
SLD checks. A matching subset is not whole-project coverage. Incomplete records
and duplicate names in the legacy symbol-only view cannot receive a PASS.

2026-10-15: expose every parsed record for the separate duplicate-copy audit.
The legacy symbol-only API still rejects duplicate names. Paired retail FILE
anchors and unique native SLD compilation units are provenance, never a reason
to discard a copy. Backup: build/nc12/local_owner_cmp_before_copy_audit_20261015.py.
"""
import argparse
import ast
import hashlib
import json
import re
from pathlib import Path

from symtree_parse import REC, DEF
from sldtree_cmp import directory_of


def unit_name(path):
    name = path.replace('\\', '/').rsplit('/', 1)[-1].lower()
    for suffix in ('.cpp', '.cxx', '.obj', '.c', '.o'):
        if name.endswith(suffix):
            return name[:-len(suffix)]
    return None


def _recon_key(path):
    value = re.sub(r'/+', '/', str(path).replace('\\', '/')).lower()
    if value.startswith('recon/'):
        return value
    marker = '/recon/'
    return 'recon/' + value.rsplit(marker, 1)[1] if marker in value else None


def _source_path(root, key):
    """Resolve recorded Windows case on other hosts; never escape this tree."""
    if not key or key.startswith(('recon/mod/', 'recon/game-mod/', 'recon/syslib-mod/')):
        return None
    current = root
    for part in key.split('/'):
        matches = [p for p in current.iterdir() if p.name.lower() == part]
        if len(matches) != 1:
            return None
        current = matches[0]
    return current if current.is_file() and current.resolve().is_relative_to((root/'recon').resolve()) else None


def _included_sld_owner(sources, root=None):
    """Independently prove a multi-file SLD compilation group, or decline it.

    2026-10-16: Speech.obj includes SPCHEVNT.C. Native PsyQ has no paired FILE
    records here, so a unique SLD filename alone loses that entire TU. Use the
    build's literal INCLUDED_SOURCES role declaration AND a direct include
    edge, not function names, addresses, record order or contract similarity.
    Backup: build/nc12/game_common_refresh_20261016/local_owner_cmp_before_include_groups.py.
    Unknown graphs, multiple roots and conflicting FILE anchors stay invalid.
    """
    root = Path(root) if root is not None else Path(__file__).resolve().parents[2]
    try:
        manifest = root/'tools/build.py'
        data = manifest.read_bytes()
        tree = ast.parse(data.decode('utf-8'))
        declarations = [node.value for node in tree.body if isinstance(node, ast.Assign)
                        and any(isinstance(t, ast.Name) and t.id == 'INCLUDED_SOURCES' for t in node.targets)]
        if len(declarations) != 1:
            return None, None
        declared = ast.literal_eval(declarations[0])
        if not isinstance(declared, (set, frozenset)) or not all(isinstance(p, str) for p in declared):
            return None, None
        included = {_recon_key(p) for p in declared}
        keys = [_recon_key(p) for p in sources]
        if None in keys or len(set(keys)) != len(keys):
            return None, None
        roots = [p for p in keys if p not in included]
        if len(roots) != 1 or len(keys) < 2:
            return None, None
        primary = roots[0]
        files = {key: _source_path(root, key) for key in keys}
        if not all(files.values()):
            return None, None
        text = files[primary].read_text(encoding='utf-8').replace('\\\r\n', '').replace('\\\n', '')
        trivia = re.compile(r'("(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\')|/\*.*?\*/|//[^\r\n]*', re.S)
        text = trivia.sub(lambda m: m.group() if m.group(1) else re.sub(r'[^\r\n]', ' ', m.group()), text)
        targets = set()
        for match in re.finditer(r'^\s*#\s*include\s+"([^"\r\n]+)"', text, re.M):
            target = (files[primary].parent/match[1]).resolve()
            if target.is_relative_to((root/'recon').resolve()):
                targets.add(target)
        helpers = sorted(key for key in keys if key != primary)
        if any(key not in included or files[key].resolve() not in targets for key in helpers):
            return None, None
        evidence = dict(kind='declared_included_source_group', primary_source=primary,
                        included_sources=helpers, manifest='tools/build.py:INCLUDED_SOURCES',
                        manifest_sha256=hashlib.sha256(data).hexdigest(),
                        source_sha256={key: hashlib.sha256(files[key].read_bytes()).hexdigest() for key in keys})
        return unit_name(primary), evidence
    except (OSError, ValueError, TypeError, SyntaxError):
        return None, None


def parse_owner_records(path, *, source_root=None):
    """Preserve all function occurrences; do not coalesce repeated symbols."""
    functions, current, header = [], None, False
    pending_sources, active_sources, file_unit = set(), (), None
    for line in Path(path).read_text(errors='replace').splitlines():
        record = REC.match(line)
        if not record:
            if current is not None and header:
                field = re.match(r'\s+(\w+) = (.*)$', line)
                if field:
                    key, value = field.groups()
                    current['hdr'][key] = value.strip()
                    if key == 'name':
                        header = False
                        name = value.strip()
                        if name.startswith('___'):
                            name = '_._' + name[3:]
                        current['name'] = name
            continue
        address, kind, payload = int(record[1], 16), record[2], record[3]
        if kind == '88':
            source = re.search(r'of file (.*)', payload)
            if source and source[1].lower().endswith(('.cpp', '.cxx', '.c')):
                pending_sources.add(source[1])
        elif kind == '8a':
            active_sources = tuple(sorted(pending_sources))
            pending_sources.clear()
        elif kind in ('94', '96') and current is None:
            definition = DEF.search(payload)
            if definition and definition[1] == 'FILE':
                name = definition[5].lower()
                if file_unit is None:
                    file_unit = dict(name=name, closed=False, valid=True)
                elif file_unit['name'] == name:
                    file_unit['closed'] = True
                    file_unit = None
                else:
                    file_unit['valid'] = False
                    file_unit = dict(name=name, closed=False, valid=True)
        if kind == '8c':
            if current is not None:
                current['errors'].append('missing function end')
            current = dict(start=address, end=None, hdr={}, locals=[], errors=[],
                           _file_unit=file_unit, _sld_sources=active_sources)
            functions.append(current)
            current['root'] = dict(start=0, end=None, path=[], children=0)
            current['stack'] = [current['root']]
            header = True
        elif current is None:
            continue
        elif kind == '90':
            parent = current['stack'][-1]
            block = dict(start=address-current['start'], end=None,
                         path=parent['path']+[parent['children']], children=0)
            parent['children'] += 1
            current['stack'].append(block)
        elif kind == '92':
            if len(current['stack']) == 1:
                current['errors'].append('block end without block start')
            else:
                block = current['stack'].pop()
                block['end'] = address-current['start']
        elif kind in ('94', '96'):
            definition = DEF.search(payload)
            if not definition or definition[1] not in ('REG', 'REGPARM', 'AUTO', 'ARG', 'STAT'):
                continue
            cls = definition[1]
            value = address if address < 0x80000000 else address-(1 << 32)
            home = cls + (':$%d' % address if cls in ('REG', 'REGPARM') else
                          ':sp%+d' % value if cls in ('AUTO', 'ARG') else '')
            ty = re.sub(r'\._\d+', '._N', (definition[2]+' '+(definition[4] or '')).strip())
            dimensions = re.search(r'\bdims (.*?)(?: tag | name )', payload)
            dims = [int(n) for n in re.findall(r'\d+', dimensions[1])] if dimensions else []
            # Def2 dims 0 encodes no dimensions; plain Def has none either.
            if dims == [0] and not re.search(r'\bARY\b', definition[2]):
                dims = []
            current['locals'].append(dict(name=definition[5], home=home, type=ty,
                                          size=int(definition[3]), dimensions=dims,
                                          depth=len(current['stack'])-1,
                                          owner=current['stack'][-1]))
        elif kind == '8e':
            current['end'] = address
            current['root']['end'] = address-current['start']
            if len(current['stack']) != 1:
                current['errors'].append('unclosed declaring block')
            current = None
            header = False
    if current is not None:
        current['errors'].append('missing function end')
    source_owners = {}
    for function in functions:
        if not function.get('name'):
            function['errors'].append('missing function name')
        unit, sources = function.pop('_file_unit'), function.pop('_sld_sources')
        # FILE provenance is trusted only after its matching closing record.
        # Never choose a source merely by VA order or occurrence number.
        file_owner = unit_name(unit['name']) if unit and unit['valid'] and unit['closed'] else None
        if sources not in source_owners:
            source_owners[sources] = ((unit_name(sources[0]), None) if len(sources) == 1 else
                                     _included_sld_owner(sources, source_root) if sources else (None, None))
        source_owner, include_evidence = source_owners[sources]
        owner = file_owner or source_owner
        if unit and (not unit['valid'] or not unit['closed']):
            owner = None
        if file_owner and source_owner and file_owner != source_owner:
            owner = None
        function['provenance'] = dict(unit=owner, file_owner=file_owner,
                                      sld_sources=list(sources))
        if include_evidence is not None:
            function['provenance']['sld_include_evidence'] = include_evidence
        for local in function['locals']:
            owner = local['owner']
            local['owner'] = {key: owner[key] for key in ('start', 'end', 'path')}
        del function['stack'], function['root']
    return functions


def parse_owners(path):
    """Legacy symbol-only view: duplicate symbols remain fail-closed."""
    functions = {}
    for function in parse_owner_records(path):
        name = function.get('name')
        if name is None:
            continue
        if name in functions:
            functions[name]['errors'].append('duplicate function record')
        else:
            functions[name] = function
    return functions


def compare(native, retail):
    issues = []
    if native['errors'] or retail['errors'] or native['end'] is None or retail['end'] is None:
        return dict(status='INVALID', native_errors=native['errors'],
                    retail_errors=retail['errors'], differences=[])
    # Keep ordered occurrences; duplicate/shadowed names are not collapsed.
    for index in range(max(len(native['locals']), len(retail['locals']))):
        actual = native['locals'][index] if index < len(native['locals']) else None
        expected = retail['locals'][index] if index < len(retail['locals']) else None
        if actual != expected:
            issues.append(dict(index=index, native=actual, retail=expected))
    return dict(status='DIFF' if issues else 'PASS', differences=issues)


def main():
    from retail_sym import txt
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native', required=True)
    parser.add_argument('--retail', default=str(txt()))
    parser.add_argument('--report', required=True)
    parser.add_argument('--fn')
    parser.add_argument('--require-exact', action='store_true')
    args = parser.parse_args()
    native, retail = parse_owners(args.native), parse_owners(args.retail)
    common = sorted(native.keys() & retail.keys())
    report = dict(scope='common-functions-only', native=str(args.native), retail=str(args.retail),
                  native_only=sorted(native.keys()-retail.keys()),
                  retail_only=sorted(retail.keys()-native.keys()), functions={})
    for name in common:
        result = compare(native[name], retail[name])
        result['retail_file'] = retail[name]['hdr'].get('file')
        report['functions'][name] = result
    report['summary'] = {status: sum(r['status'] == status for r in report['functions'].values())
                         for status in ('PASS', 'DIFF', 'INVALID')}
    report['directories'] = {}
    for result in report['functions'].values():
        # 2026-10-15: same explicit path classification as SLD, including
        # available EACLIB/SYSLIB records, never inferred from symbol names.
        # Backup: build/nc12/local_owner_cmp_before_sdk_dirs_20261015.py.
        directory = directory_of(result['retail_file'] or '')
        counts = report['directories'].setdefault(directory, {'PASS': 0, 'DIFF': 0, 'INVALID': 0})
        counts[result['status']] += 1
    Path(args.report).write_text(json.dumps(report, indent=2))
    print('Common functions:', len(common), 'Ownership:', report['summary'])
    print('Coverage: retail-only', len(report['retail_only']), 'native-only', len(report['native_only']))
    for directory, counts in sorted(report['directories'].items()):
        print(directory, counts)
    if args.fn:
        if args.fn not in report['functions']:
            parser.error('requested function is not covered in both dumps')
        print(args.fn, json.dumps(report['functions'][args.fn], indent=2))
    if args.require_exact and (not common or any(r['status'] != 'PASS' for r in report['functions'].values())):
        return 1
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
