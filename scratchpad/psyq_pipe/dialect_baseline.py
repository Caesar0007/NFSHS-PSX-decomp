#!/usr/bin/env python3
"""dialect_baseline.py [snapshot|compare] -- compile every TU touched by the asm-dialect
rewrite with the GNU lane and snapshot / compare its object (section bytes + relocs + symbols),
so the rewrite is proven byte-neutral for the honest link before it lands."""
import sys, json, subprocess, shutil, hashlib
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp'); sys.path.insert(0, str(ROOT / 'tools'))
import build
W = ROOT / 'scratchpad' / 'psyq_pipe'
BASE = W / 'baseline_objs'
mode = sys.argv[1] if len(sys.argv) > 1 else 'snapshot'
extra = sys.argv[2:]


def affected():
    s = set(rel for rel, _ in json.load(open(W / 'assemble_fails.json')))
    for l in (W / 'dialect_files.txt').read_text().split('\n') if (W / 'dialect_files.txt').exists() else []:
        if l.strip():
            s.add(l.strip())
    s.update(extra)
    return sorted(s)


def obj_digest(o: Path):
    """objdump -h/-r/-t + section bytes -> a stable digest text."""
    out = []
    for args in (['-h'], ['-r'], ['-t'], ['-s']):
        r = subprocess.run([str(build.MIPS / 'mipsel-none-elf-objdump.exe')] + args + [str(o)],
                           capture_output=True, text=True)
        out.append(r.stdout)
    return '\n'.join(out)


def compile_one(rel):
    src = ROOT / rel
    if src.suffix == '.cpp':
        return build.compile_cpp(src)
    return build.compile_c(src, False)


res = {}
for rel in affected():
    try:
        o = compile_one(rel)
    except SystemExit as e:
        print('COMPILE FAIL', rel, e); continue
    except Exception as e:
        print('COMPILE FAIL', rel, repr(e)[:200]); continue
    d = obj_digest(o)
    key = rel.replace('/', '__')
    if mode == 'snapshot':
        BASE.mkdir(exist_ok=True)
        (BASE / (key + '.txt')).write_text(d)
        shutil.copy(o, BASE / (key + '.o'))
        res[rel] = 'snap'
    else:
        b = BASE / (key + '.txt')
        if not b.exists():
            res[rel] = 'NO-BASELINE'; continue
        res[rel] = 'SAME' if b.read_text() == d else 'DIFF'
        if res[rel] == 'DIFF':
            (W / 'diff_' + key + '.txt') if False else None
            (W / ('diff_' + key + '.txt')).write_text(d)
print(mode, len(res), 'TUs;', {k: sum(1 for v in res.values() if v == k) for k in set(res.values())})
for rel, v in res.items():
    if v not in ('snap', 'SAME'):
        print('  ', v, rel)
