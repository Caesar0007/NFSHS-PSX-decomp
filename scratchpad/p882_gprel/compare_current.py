"""Compare a fresh current GP audit with the complete frozen native baseline.

The baseline's three FIRST references were established independently by raw
absolute address pairs. Reuse that proven expectation, never an index-based
alignment of its nonmatching source function. No objects or images are edited.
"""
from collections import Counter
from pathlib import Path
import json
import sys

HERE=Path(__file__).resolve().parent
tag=sys.argv[1] if len(sys.argv)>1 else 'current'
old=json.loads((HERE/'baseline_complete.json').read_text())
new=json.loads((HERE/'audit.json').read_text())
def key(row):
    return row['object'],row['relocation_section'],row['offset'],row['type']
prior={key(row):row for row in old['relocations']}
assert len(prior)==len(old['relocations'])==2381
assert {key(row) for row in new['relocations']}==set(prior)
fixed=regressed=0
for row in new['relocations']:
    before=prior[key(row)]
    assert (row['symbol'],row['addend'])==(before['symbol'],before['addend'])
    assert 'expected_target' in before
    if 'expected_target' in row:
        assert row['expected_target']==before['expected_target'],(key(row),row,before)
    else:
        row['expected_target']=before['expected_target']
        row['expected_basis']=before['expected_basis']
    row['wrong_target']=row['actual_target']!=row['expected_target']
    fixed+=before['wrong_target'] and not row['wrong_target']
    regressed+=not before['wrong_target'] and row['wrong_target']
new['summary'].update(expected_known=2381,expected_unknown=0,
    wrong_target=sum(row['wrong_target'] for row in new['relocations']),
    in_range_wrong_target=sum(row['wrong_target'] and not row['overflow'] for row in new['relocations']),
    fixed_native_targets=fixed,regressed_native_targets=regressed)
new['by_object']={obj:dict(gp_relocations=len(rows),overflow=sum(r['overflow'] for r in rows),
                         wrong_target=sum(r['wrong_target'] for r in rows))
                  for obj in sorted({r['object'] for r in new['relocations']})
                  for rows in [[r for r in new['relocations'] if r['object']==obj]]}
(HERE/(tag+'_complete.json')).write_text(json.dumps(new,indent=2)+'\n')
print(json.dumps(new['summary'],indent=2))
