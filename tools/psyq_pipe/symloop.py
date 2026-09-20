"""Fail-closed per-file native SYM loop; no source/compiler-output rewriting.

2026-09-20: --ref-only rebuilds first and never overwrites a differing reference.
No success token until byte, debug, ASPSX, link, dump and coverage checks pass.
Backup/tests: scratchpad/symloop_guard_20260920.
"""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile

ROOT = Path('C:/Temp/nfs4-decomp')  # same checkout as downstream lane tools
PY = sys.executable
SECTIONS = ('.text', '.rodata', '.data', '.sdata')


class GateError(RuntimeError):
    pass


def require_file(path):
    if not path.is_file() or path.stat().st_size == 0:
        raise GateError('Missing or empty fresh output: ' + str(path))


def object_snapshot(obj):
    """Validated ELF bytes; preserve the legacy four-section reference format.
    BSS, binding and relocation semantics still need the honest link/guards.
    """
    require_file(obj)
    spec = importlib.util.spec_from_file_location('_symloop_elf', ROOT / 'tools/source_section_owners.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    image = module.read_owner_image(obj)
    out = b''
    layout = []
    for name in SECTIONS:
        section = image['sections'].get(name)
        if section is not None and section[1] != 1:
            raise GateError('Expected PROGBITS section: ' + name)
        data = module.payload(image, name) if section is not None else b''
        out += b'|' + name.encode() + b'|' + data
        layout.append(dict(name=name, present=section is not None, size=len(data),
                           flags=section[2] if section else None, alignment=section[8] if section else None,
                           sha256=hashlib.sha256(data).hexdigest()))
    return out, dict(schema=1, sections=layout)


def text_of(obj):
    return object_snapshot(obj)[0]


def select_sources(fragments):
    sources = sorted([*(ROOT / 'recon').rglob('*.cpp'), *(ROOT / 'recon').rglob('*.c')])
    chosen = set()
    for fragment in fragments:
        fragment = fragment.replace('\\', '/').strip()
        hits = [s for s in sources if fragment and fragment in s.relative_to(ROOT).as_posix()]
        if not hits:
            raise GateError('No TU matches fragment: ' + fragment)
        chosen.update(hits)
    return sorted(chosen)


def retail_functions():
    spec = importlib.util.spec_from_file_location('_symloop_retail', ROOT / 'tools/psyq_pipe/symtree_parse.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.parse(module.RETAIL)


def expected_functions(sources):
    """Refuse zero/partial coverage and ambiguous retail basename matches."""
    retail = retail_functions()
    names = [s.name.upper() for s in sources]
    if len(names) != len(set(names)):
        raise GateError('Duplicate source basenames require an explicit ownership mapping')
    expected = {}
    for source in sources:
        matches = {n: f for n, f in retail.items()
                   if f['hdr'].get('file', '').replace('\\', '/').split('/')[-1].upper() == source.name.upper()}
        owners = {f['hdr']['file'].replace('\\', '/').upper() for f in matches.values()}
        if not matches or len(owners) != 1:
            raise GateError('Missing or ambiguous retail function coverage: ' + str(source))
        expected.update(matches)
    return expected


def quarantine(paths, run_dir, stage):
    """Retain old generated artifacts, but do not accept them as fresh output."""
    for path in paths:
        if path.exists():
            if not path.is_file() or not path.resolve().is_relative_to(ROOT.resolve()):
                raise GateError('Unsafe generated-artifact path: ' + str(path))
            saved = run_dir / stage / path.relative_to(ROOT)
            saved.parent.mkdir(parents=True, exist_ok=True)
            path.replace(saved)


def run_stage(name, command, run_dir, env=None):
    result = subprocess.run(command, cwd=ROOT, env=env, capture_output=True, text=True)
    (run_dir / (name + '.log')).write_text(result.stdout + '\n' + result.stderr)
    if result.returncode:
        raise GateError('%s failed (exit %s); see %s' % (name, result.returncode, run_dir))
    return result.stdout


def run_gate(args):
    sources = select_sources(args.fragments)
    rels = [s.relative_to(ROOT).as_posix() for s in sources]
    refs = [ROOT / 'build/symloop_ref' / (rel + '.text') for rel in rels]
    layouts = [p.with_suffix(p.suffix + '.json') for p in refs]
    if not args.ref_only and any(not p.is_file() for p in refs + layouts):
        raise GateError('Missing byte/layout reference. Run --ref-only BEFORE editing; no baseline was created.')
    expected = {} if args.ref_only else expected_functions(sources)
    runs = ROOT / 'build/symloop_runs'
    runs.mkdir(parents=True, exist_ok=True)
    run_dir = Path(tempfile.mkdtemp(prefix='run-', dir=runs))
    objects = [ROOT / 'build' / (rel + '.o') for rel in rels]
    normal_s = [ROOT / 'build' / (rel + '.s') for rel in rels]
    quarantine(objects + normal_s, run_dir, 'normal-before')
    run_stage('normal', [PY, str(ROOT / 'tools/build.py'), '--skip-asm', '--only', ','.join(rels)], run_dir)
    for path in objects + normal_s:
        require_file(path)
    current = [object_snapshot(obj) for obj in objects]
    moved = [rel for rel, ref, layout, (data, shape) in zip(rels, refs, layouts, current)
             if (ref.exists() and ref.read_bytes() != data)
             or (layout.exists() and json.loads(layout.read_text()) != shape)]
    if moved:
        print('BYTES: MOVED in ' + ', '.join(moved), flush=True)
        raise GateError('Byte gate failed; references unchanged. Logs: ' + str(run_dir))
    if args.ref_only:
        created = 0
        for ref, layout, (data, shape) in zip(refs, layouts, current):
            if not ref.exists():
                ref.parent.mkdir(parents=True, exist_ok=True)
                with ref.open('xb') as output:
                    output.write(data)
                created += 1
            # Explicit pre-edit adoption of a legacy reference is allowed only
            # after its original bytes match the fresh object. The companion
            # removes delimiter ambiguity and also guards sizes/flags/alignment.
            if not layout.exists():
                with layout.open('x') as output:
                    json.dump(shape, output, indent=2)
                    output.write('\n')
        print('REFERENCES: %d recorded, %d existing verified after fresh compile' % (created, len(refs) - created))
        return 0

    work = ROOT / 'tools/psyq_pipe'
    debug_s = [ROOT / 'build/gdebug' / (rel + '.s') for rel in rels]
    debug_report = ROOT / 'scratchpad/psyq_pipe/gdebug_report.json'
    quarantine(debug_s + [debug_report], run_dir, 'debug-before')
    run_stage('debug', [PY, str(work / 'gdebug_compile.py'), *rels], run_dir)
    for path in debug_s + [debug_report]:
        require_file(path)
    debug = json.loads(debug_report.read_text())
    if not isinstance(debug, dict):
        raise GateError('Malformed debug compile report')
    for rel in rels:
        row = debug.get(rel)
        if not isinstance(row, dict) or row.get('s') is not True or row.get('same_code') is not True or 'FAILED' in row.get('note', ''):
            raise GateError('Missing, failed or code-changing debug compile: %s; inspect %s (use lower-level tools for -g diagnostics)' % (rel, run_dir))

    lane = ROOT / 'build/psyq_g'
    sn_objects = [lane / (rel.replace('/', '__') + '.obj') for rel in rels]
    artifacts = [lane / name for name in ('assemble_fails.json', 'psylink.log', 'nfs4.cpe', 'nfs4.sym', 'nfs4.map', 'nfs4_sym.txt', 'symtree_report.json')]
    quarantine(sn_objects + artifacts, run_dir, 'lane-before')
    env = dict(os.environ, NFS4_LANE_G='1', NFS4_LANE_OUT='build/psyq_g', NFS4_LANE_ONLY=','.join(rels))
    lane_stdout = run_stage('lane', [PY, str(work / 'psylink_lane.py')], run_dir, env)
    for path in sn_objects + artifacts[:-1]:
        require_file(path)
    if json.loads((lane / 'assemble_fails.json').read_text()) != []:
        raise GateError('ASPSX assembly failures; see ' + str(run_dir))
    if not re.search(r'(?m)^\s*0 error\(s\)', (lane / 'psylink.log').read_text()):
        raise GateError('PSYLINK did not report a successful final link; see ' + str(run_dir))
    run_stage('compare', [PY, str(work / 'symtree_cmp.py'), str(lane / 'nfs4_sym.txt')], run_dir)
    require_file(lane / 'symtree_report.json')
    report = json.loads((lane / 'symtree_report.json').read_text())
    if not isinstance(report, dict):
        raise GateError('Malformed function comparison report')
    missing = sorted(set(expected) - set(report))
    if missing:
        raise GateError('Incomplete selected-function comparison: ' + ', '.join(missing[:8]))
    mine = {name: report[name] for name in expected}
    if any(not isinstance(row, dict) or not isinstance(row.get('issues'), list)
           or any(not isinstance(issue, str) for issue in row['issues'])
           or row.get('file') != expected[name]['hdr']['file'] for name, row in mine.items()):
        raise GateError('Malformed function comparison report')
    dirty = {name: row for name, row in mine.items() if row['issues']}
    result = dict(pipeline_pass=True, bytes_unchanged=True, debug_code_unchanged=True,
                  sources=rels, compared=len(mine), clean=len(mine)-len(dirty), dirty=len(dirty))
    (run_dir / 'result.json').write_text(json.dumps(result, indent=2) + '\n')
    # Delay this legacy success token: old callers match stdout, not return
    # codes. DIRTY is a valid comparison, never a source-completion claim.
    print('BYTES: UNCHANGED')
    for line in lane_stdout.splitlines():
        if line.startswith(('ASPSX ok', 'PSYLINK:')):
            print(' ', line[:150])
    print('SYM  : %d functions, %d CLEAN, %d DIRTY' % (len(mine), len(mine)-len(dirty), len(dirty)))
    if not args.quiet:
        for name, row in sorted(dirty.items()):
            print('   %-52s %s' % (name[:52], '; '.join(row['issues'])[:170]))
    print('LOGS : ' + str(run_dir))
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('fragments', nargs='+')
    parser.add_argument('--quiet', action='store_true')
    parser.add_argument('--ref-only', action='store_true')
    args = parser.parse_args(argv)
    try:
        return run_gate(args)
    except (GateError, OSError, ValueError, KeyError, AssertionError) as error:
        print('SYMLOOP FAILED: ' + str(error), file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
