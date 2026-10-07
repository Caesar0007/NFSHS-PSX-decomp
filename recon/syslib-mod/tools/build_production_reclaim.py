#!/usr/bin/env python3
"""Derive the actually reusable production overlay ranges from the gross manifest."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'race_reclaim_plus_cd_movie.json'
IMAGE_REPORT = Path(r'C:\Temp\nfs4-syslib-pair\candidate-image-overlay\image-report.json')
OUTPUT = ROOT / 'production_race_reclaim.json'


def load(path):
    data = json.loads(path.read_text())
    ranges = []
    for include in data.get('includes', []):
        ranges.extend(load(path.parent / include))
    ranges.extend(data.get('ranges', []))
    return ranges


def subtract(item, cuts):
    pieces = [(int(item['va'], 16), int(item['va'], 16) + item['size'])]
    for cut_start, cut_end in cuts:
        next_pieces = []
        for start, end in pieces:
            if cut_end <= start or cut_start >= end:
                next_pieces.append((start, end))
            else:
                if start < cut_start:
                    next_pieces.append((start, cut_start))
                if cut_end < end:
                    next_pieces.append((cut_end, end))
        pieces = next_pieces
    return [dict(name=item['name'] + ('' if len(pieces) == 1 else f'_part{i + 1}'),
                 va=f'{start:08X}', size=end - start)
            for i, (start, end) in enumerate(pieces) if end > start]


def main():
    image = json.loads(IMAGE_REPORT.read_text())
    loader_start = 0x800F6D20
    loader_end = loader_start + image['loader_bytes']
    snapshot_start = int(image['snapshot']['address'], 16)
    work_end = int(image['compressed_restore']['address'], 16) + image['compressed_restore']['size']
    cuts = [(loader_start, loader_end), (snapshot_start, work_end)]
    ranges = [piece for item in load(SOURCE) for piece in subtract(item, cuts)]
    total = sum(item['size'] for item in ranges)
    if total != image['net_reclaim']:
        raise ValueError(f'manifest {total} != image net reclaim {image["net_reclaim"]}')
    result = {
        'schema': 'nfs4-syslib-production-race-reclaim-v1',
        'total_bytes': total,
        'source_gross_bytes': image['gross_reclaim'],
        'reserved_ranges': [
            {'name': 'overlay_loader', 'va': f'{loader_start:08X}', 'size': loader_end-loader_start},
            {'name': 'snapshot_alignment_and_work', 'va': f'{snapshot_start:08X}', 'size': work_end-snapshot_start},
        ],
        'restore_before': ['Nfs2_CleanUpGameModule', 'frontend memory-card access', 'STR movie playback'],
        'ranges': ranges,
    }
    OUTPUT.write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    print(f'{OUTPUT}: {total} bytes in {len(ranges)} ranges')


if __name__ == '__main__':
    main()
