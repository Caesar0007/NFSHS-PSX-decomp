"""Consolidated source-only re-gate of the 79 P874/P875 header owners.

Diagnostic only: no production source, flags, instructions or oracle rewrites.
Pre-edit byte receipts remain in the individual batch records. The hashes here
compare the current accepted object with its fresh rebuild, not with Git HEAD.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest() if path.exists() else None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--out', default='p875_public_header_final_validation_20260906.json')
    args = parser.parse_args()
    previous = (HERE / 'public_header_prototype_queue_p874_20260906.md').read_text()
    headers = sorted(set(re.findall(r'^\|\s*(recon/[^|:]+\.h):\d+\s*\|', previous, re.M)))
    assert len(headers) == 79, len(headers)
    sources = {p.relative_to(ROOT).as_posix().lower(): p
               for p in (ROOT / 'recon').rglob('*.cpp')}
    env = dict(os.environ, NFS4_SOURCE_ONLY='1')
    rows = []
    for header in headers:
        src = sources[str(Path(header).with_suffix('.cpp')).replace('\\', '/').lower()]
        relative = src.relative_to(ROOT).as_posix()
        obj = ROOT / ('build/' + relative + '.o')
        # P878: full builds use filesystem case, while older targeted gates
        # used lowercase aiworld.cpp. Reuse the accepted object's input spelling
        # so this idempotency check compares identical inputs. This selects a
        # compiler input; no object bytes are normalized or rewritten.
        if relative == 'recon/game/common/AIWORLD.cpp' and obj.exists():
            previous = obj.read_bytes()
            if b'aiworld.cpp\0' in previous and b'AIWORLD.cpp\0' not in previous:
                relative = 'recon/game/common/aiworld.cpp'
        row = dict(header=header, source=relative, accepted_object_sha256=digest(obj))
        for name, script in [('gate', 'tugate.py'), ('branches', 'brdist.py')]:
            proc = subprocess.run([sys.executable, str(ROOT / 'tools' / script), relative],
                                  cwd=ROOT, env=env, capture_output=True, text=True)
            row[name] = dict(returncode=proc.returncode, stdout=proc.stdout, stderr=proc.stderr)
        match = re.search(r': (\d+)/(\d+) PASS', row['gate']['stdout'])
        row['pass'], row['total'] = map(int, match.groups()) if match else (0, 0)
        row['rebuilt_object_sha256'] = digest(obj)
        row['accepted_rebuild_identical'] = (row['accepted_object_sha256'] is not None and
            row['accepted_object_sha256'] == row['rebuilt_object_sha256'])
        rows.append(row)
        print(f"{relative}: {row['pass']}/{row['total']} PASS; accepted rebuild identical="
              f"{row['accepted_rebuild_identical']}", flush=True)
    result = dict(round='P875', headers=len(headers), owners=len(rows),
                  passed=sum(r['pass'] for r in rows), total=sum(r['total'] for r in rows),
                  accepted_rebuild_identical=sum(r['accepted_rebuild_identical'] for r in rows),
                  rows=rows)
    path = HERE / args.out
    path.write_text(json.dumps(result, indent=2) + '\n')
    print({k:v for k,v in result.items() if k != 'rows'}, flush=True)
    print(path)
    return 0 if all(r['total'] and r['accepted_rebuild_identical'] and
                    not r['gate']['returncode'] and not r['branches']['returncode']
                    for r in rows) else 1


if __name__ == '__main__':
    raise SystemExit(main())
