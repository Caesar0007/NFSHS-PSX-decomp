#!/usr/bin/env python3
"""w47-a8: baseline + flag sweep over EVERY eaclib TU in the wave-47 worklist.

Writes scratch/base_<tu>.json then scratch/sweep_<tu>.json for each, and a
one-line-per-TU summary of any flag that met the recommendation rule
(TOTALDIFF strictly down AND zero PASS->FAIL regressions).
"""
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRATCH = ROOT / 'scratch'

TUS = sys.argv[1:] if len(sys.argv) > 1 else []


def main():
    summary = []
    for tu in TUS:
        stem = Path(tu).stem
        bj = SCRATCH / f'base_{stem}.json'
        if not bj.exists():
            r = subprocess.run([sys.executable, str(SCRATCH / 'w47_a8_tugate.py'), tu,
                                '--json', str(bj)], capture_output=True, text=True, cwd=str(ROOT))
            if not bj.exists():
                print(f"!! {tu} BASELINE FAILED: {(r.stdout + r.stderr)[-200:]}")
                summary.append((tu, 'BASELINE-FAIL', None))
                continue
        base = {k: v for k, v in json.loads(bj.read_text()).items() if isinstance(v, int)}
        bt, bp = sum(base.values()), sum(1 for v in base.values() if v == 0)
        sj = SCRATCH / f'sweep_{stem}.json'
        r = subprocess.run([sys.executable, str(SCRATCH / 'w47_a8_sweep.py'), tu,
                            '--out', str(sj)], capture_output=True, text=True, cwd=str(ROOT))
        wins = []
        if sj.exists():
            for row in json.loads(sj.read_text())['rows']:
                if row.get('status') == 'BUILDFAIL':
                    continue
                if row['delta'] < 0 and not row['regressions']:
                    wins.append((row['flag'], row['delta'], row['pass'] - bp))
        print(f"{tu}: n={len(base)} PASS={bp} TOTAL={bt} WINS={wins}")
        summary.append((tu, f'n={len(base)} PASS={bp} TOTAL={bt}', wins))
    (SCRATCH / 'w47_a8_batch_summary.json').write_text(json.dumps(summary, indent=1),
                                                       encoding='utf-8', newline='')


if __name__ == '__main__':
    main()
