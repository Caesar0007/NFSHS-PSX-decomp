"""Read-only local declaration ownership comparison for native/retail SYM.

2026-10-14: symtree_cmp compares local depth and block trees independently.
Neither proves that a local at depth N belongs to the same sibling block.
Track its actual enclosing block and compare function-relative boundaries and
the lexical child path. These are debug declaration regions, NOT runtime
live ranges. No source, compiler output, SYM, or reference is rewritten.

This supplements, never replaces, bytes/link, declaration/type, whole-tree and
SLD checks. A matching subset is not whole-project coverage. Incomplete or
duplicate function records cannot receive an ownership PASS.
"""
import argparse
import json
import re
from pathlib import Path

from symtree_parse import REC, DEF


def parse_owners(path):
    functions, current, header = {}, None, False
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
                        if name in functions:
                            functions[name]['errors'].append('duplicate function record')
                        else:
                            functions[name] = current
            continue
        address, kind, payload = int(record[1], 16), record[2], record[3]
        if kind == '8c':
            if current is not None:
                current['errors'].append('missing function end')
            current = dict(start=address, end=None, hdr={}, locals=[], errors=[])
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
    for function in functions.values():
        for local in function['locals']:
            owner = local['owner']
            local['owner'] = {key: owner[key] for key in ('start', 'end', 'path')}
        del function['stack'], function['root']
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
        file = (result['retail_file'] or '').replace('/', '\\')
        match = re.search(r'\\(GAME|FRONTEND)\\(COMMON|PSX)\\', file, re.I)
        directory = '/'.join(match.groups()).upper() if match else 'OTHER'
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
