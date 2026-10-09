"""Read-only source review inventory; not a source-restoration certificate.

2026-10-08: combines the existing native/SLD snapshots with lexical review
locations. Never edits source, compiler output, SYM records or references.
Const/debug-elided aliases and original spelling require separate review;
absence of a lexical hit is not proof that a TU has no synthetic objects.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
COMMON = {"GAME/COMMON", "GAME/PSX", "FRONTEND/COMMON", "FRONTEND/PSX"}
LOCAL_ISSUES = {"EXTRA", "MISSING", "MOVED", "TYPE", "SCOPE", "ORDER"}
TRIVIA = re.compile(r'/\*.*?\*/|//[^\r\n]*|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'', re.S)
SYNTHETIC = re.compile(
    r'\b(?:[ibufdsclpu]+Var\d+|pp?[A-Z]Var\d+|local_[A-Za-z0-9_]+'
    r'|(?:var|temp)_(?:[avst]\d+|f\d+|ra|sp|fp)(?:_\d+)?)\b')
REVIEW = re.compile(
    r'SYM-CODEGEN-CARRIER|SOURCE-RECOVERY CARRIER|SOURCE-REVIEW-UNRESOLVED'
    r'|ORIGINAL-NAME-UNRESOLVED|DEBUG-ELIDED SOURCE VALUE|SOURCE-RECOVERY REVIEW')


def mask_trivia(text):
    return TRIVIA.sub(lambda m: re.sub(r'[^\r\n]', ' ', m.group()), text)


def directory(file):
    value = file.replace('/', '\\').upper()
    match = re.search(r'\\(GAME|FRONTEND)\\(COMMON|PSX)\\', value)
    return '/'.join(match.groups()) if match else 'OTHER/PARTIAL'


def local_contract_clean(issues):
    return not any(issue.split()[0] in LOCAL_ISSUES for issue in issues)


def source_group(rel):
    parts = Path(rel).parts
    return '/'.join(parts[1:3]).upper() if len(parts) > 3 else 'ROOT/SHARED'


def input_info(path):
    data = path.read_bytes()
    return {"path": str(path), "sha256": hashlib.sha256(data).hexdigest()}


def inventory(native_path, sld_path):
    native = json.loads(native_path.read_text())
    sld = json.loads(sld_path.read_text())["functions"]
    directories = {}
    extra_rows = []
    for name, row in native.items():
        group = directory(row['file'])
        if group not in COMMON:
            continue
        summary = directories.setdefault(group, Counter())
        summary['covered_functions'] += 1
        summary['native_clean'] += not row['issues']
        summary['local_contract_clean'] += local_contract_clean(row['issues'])
        summary['native_and_sld_exact'] += (
            not row['issues'] and sld.get(name, {}).get('status') == 'EXACT')
        for issue in row['issues']:
            kind = issue.split()[0]
            summary['issue_rows_' + kind.lower()] += 1
            if kind == 'EXTRA':
                extra_rows.append({"function": name, "file": row['file'], "issue": issue})
    locations = []
    files = Counter()
    for path in sorted((ROOT / 'recon').rglob('*')):
        if not path.is_file() or path.suffix not in {'.c', '.cpp', '.h', '.hpp', '.inl'}:
            continue
        rel = path.relative_to(ROOT).as_posix()
        if rel.startswith(('recon/mod/', 'recon/game-mod/', 'recon/syslib-mod/')):
            continue
        text = path.read_text(encoding='utf-8', errors='replace')
        files[source_group(rel)] += 1
        code = mask_trivia(text)
        for kind, pattern, content in [('synthetic_identifier', SYNTHETIC, code),
                                       ('review_marker', REVIEW, text)]:
            for match in pattern.finditer(content):
                locations.append({"kind": kind, "file": rel,
                                  "line": content.count('\n', 0, match.start()) + 1,
                                  "text": match.group()})
    return {
        "schema": 1,
        "inputs": [input_info(native_path), input_info(sld_path)],
        "scope": "Common-function snapshots plus reconstruction source/header lexical locations; mod trees excluded",
        "source_freshness_certified": False,
        "limitations": [
            "This tool does not rebuild or refresh the input SYM dumps.",
            "Local contract excludes FRAME/BLOCKS/SLD and global/type-body records.",
            "Lexical candidates and review-marker occurrences are not distinct unresolved source objects.",
            "Const aliases, original macro spelling and unnamed producer mechanisms need independent inspection.",
            "eaclib/syslib lexical locations are included, but incomplete retail records are not whole-library coverage."],
        "directories": {k: dict(v) for k, v in sorted(directories.items())},
        "source_files_scanned": dict(sorted(files.items())),
        "native_extra_rows": extra_rows,
        "source_locations": locations,
    }


def self_test():
    value = 'int iVar1; /* uVar2 */ const char *s="pCVar3"; // local_10\n int temp_v0_2;'
    masked = mask_trivia(value)
    assert masked.count('\n') == value.count('\n')
    assert [m.group() for m in SYNTHETIC.finditer(masked)] == ['iVar1', 'temp_v0_2']
    assert local_contract_clean(['BLOCKS 1 scopes != 2', 'FRAME fsize differs'])
    for kind in LOCAL_ISSUES:
        assert not local_contract_clean([kind + ' fixture'])
    assert directory(r'C:\nfs4\GAME\COMMON\TEST.CPP') == 'GAME/COMMON'
    assert directory(r'C:\nfs4\syslib\TEST.C') == 'OTHER/PARTIAL'
    print('PASS: trivia masking, synthetic candidates, local-contract criteria and directory fixtures')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native', type=Path, default=ROOT / 'build/psyq_g/symtree_report.json')
    parser.add_argument('--sld', type=Path, default=ROOT / 'build/psyq_g/sldtree_report.json')
    parser.add_argument('--output', type=Path, default=ROOT / 'build/source_review_inventory.json')
    parser.add_argument('--self-test', action='store_true')
    args = parser.parse_args()
    if args.self_test:
        self_test()
        return
    report = inventory(args.native, args.sld)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2), encoding='utf-8')
    for group, row in report['directories'].items():
        print(group, 'covered', row['covered_functions'], 'native', row['native_clean'],
              'local-contract', row['local_contract_clean'], 'strict', row['native_and_sld_exact'])
    counts = Counter(row['kind'] for row in report['source_locations'])
    print('Native EXTRA rows:', len(report['native_extra_rows']))
    print('Lexical locations (not unique objects):', dict(counts))
    print('Diagnostic only:', args.output)


if __name__ == '__main__':
    main()
