#!/usr/bin/env python3
"""w64a21 worklist.py -- build the census worklist: every row that is non-100 in
EITHER the committed board or a fresh objdiff report, mapped to its recon TU."""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from boardcmp import load_report, load_board  # noqa: E402

ROOT = Path(r'C:\Temp\nfs4-decomp')


def unit_sources():
    cfg = json.load(open(ROOT / 'objdiff.json', encoding='utf-8'))
    out = {}
    for u in cfg['units']:
        name = u['name'].replace('\\', '/')
        out[name] = {
            'src': u.get('metadata', {}).get('source_path', ''),
            'base': u.get('base_path', ''),
            'target': u.get('target_path', ''),
        }
    return out


def main():
    rep = load_report(sys.argv[1])
    board = load_board()
    us = unit_sources()

    keys = sorted(k for k in set(rep) | set(board)
                  if rep.get(k, 0.0) < 100.0 or board.get(k, (0.0, ''))[0] < 100.0)

    rows = []
    for k in keys:
        unit, fn = k
        info = us.get(unit, {})
        rows.append({
            'unit': unit, 'fn': fn,
            'va': board.get(k, (0, '-'))[1],
            'board': board.get(k, (float('nan'), ''))[0],
            'fresh': rep.get(k, float('nan')),
            'src': info.get('src', ''),
            'base': info.get('base', ''),
        })
    json.dump(rows, open(ROOT / 'scratchpad/w64a21/worklist.json', 'w'), indent=1)

    tus = {}
    for r in rows:
        tus.setdefault(r['src'], []).append(r['fn'])
    print(f"{len(rows)} rows across {len(tus)} TUs")
    for src in sorted(tus):
        print(f"{len(tus[src]):3}  {src}")


if __name__ == '__main__':
    main()
