"""P875 read-only PSX public-prototype evidence collector (no source writes)."""
import json
import re
import subprocess
import sys
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(Path(__file__).parent))
import audit_sym_source as audit

queue = ROOT / 'scratchpad/root_sym_audit/public_header_prototype_queue_p874_20260906.md'
rows = []
for line in queue.read_text().splitlines():
    if line.startswith('| recon/game/psx/'):
        fields = [v.strip().strip('`') for v in line.split('|')[1:-1]]
        header, lineno = fields[0].split(':')
        rows.append(dict(header=header, line=int(lineno), encoded=fields[1],
                         name=fields[2], inventory_class=fields[3], include_hits=int(fields[4])))

sources = sorted({str((ROOT / row['header']).with_suffix('.cpp')) for row in rows})
proc = subprocess.run(['ctags', '--output-format=json', '--fields=+neKSt',
                       '--kinds-C++=f', '-o', '-', *sources], capture_output=True, text=True)
assert proc.returncode == 0, proc.stderr
records = defaultdict(list)
for line in proc.stdout.splitlines():
    rec = json.loads(line)
    if rec.get('kind') == 'function':
        records[(Path(rec['path']).stem, rec['name'])].append(rec)

symbols = {r['encoded'] for r in rows}
native = defaultdict(list)
with Path(r'C:/Temp/nfs4-clean/nfs4-f-v3.txt').open(encoding='utf-8') as handle:
    for line in handle:
        m = audit.DEF.match(line.rstrip('\n'))
        if not m or m[7] not in symbols or not m[4].startswith('FCN '):
            continue
        tag = re.search(r'\btag\s+(\S*)', m[6])
        decl = audit.Decl(m[3], m[7], m[4][4:], tag[1] if tag else '', int(m[5]))
        native[m[7]].append(dict(record=m[1], va=m[2], linkage=m[3],
                                return_type=decl.display_type, raw=line.strip()))

for row in rows:
    header = ROOT / row['header']
    line = header.read_text(encoding='utf-8').splitlines()[row['line']-1]
    m = re.match(r'^(.*?)\b' + re.escape(row['encoded']) + r'\s*(\(.*\))\s*;(.*)$', line)
    if not m:
        # After repair, the encoded declaration lives only in the frozen
        # before-probe.  Preserve reproducibility without undoing a header.
        snapshot = Path(__file__).with_name('p875_psx') / (header.stem + '_before.cpp')
        if snapshot.exists():
            for prior_line in snapshot.read_text(encoding='utf-8').splitlines():
                prior_match = re.match(r'^(.*?)\b' + re.escape(row['encoded']) + r'\s*(\(.*\))\s*;(.*)$', prior_line)
                if prior_match:
                    line, m = prior_line, prior_match
                    break
    assert m, (row, line)
    row['original'] = line
    row['header_return'] = m[1].strip()
    row['header_signature'] = m[2]
    row['native'] = native[row['encoded']]
    row['definitions'] = records[(header.stem, row['name'])]
    for definition in row['definitions']:
        definition['return_type'] = re.sub(r'^(?:typename|struct|union|enum):', '', definition.get('typeref', ''))
        definition['return_matches_native'] = any(audit.compatible_return_types(n['return_type'], definition['return_type']) for n in row['native'])
    row['extern_c_header'] = 'extern "C"' in header.read_text(encoding='utf-8')

if '--compact' in sys.argv:
    for row in rows:
        for definition in row['definitions']:
            definition.pop('pattern', None)
            definition.pop('_type', None)
        row['native'] = [{k:v for k,v in n.items() if k != 'raw'} for n in row['native']]
    print(json.dumps(rows))
elif '--json' in sys.argv:
    print(json.dumps(rows, indent=2))
else:
    print('Rows', len(rows), 'headers', len({r['header'] for r in rows}))
    print('Inventory classes', dict(Counter(r['inventory_class'] for r in rows)))
    for row in rows:
        defs = row['definitions']
        if not row['native'] or len(defs) != 1 or not defs[0]['return_matches_native'] or row['extern_c_header']:
            print(json.dumps(row))
