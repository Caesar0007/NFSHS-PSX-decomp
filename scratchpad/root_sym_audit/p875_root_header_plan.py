"""Read-only plan for the root's disjoint public-prototype batch.

No source or compiler output is rewritten. Definition extraction is only a
review aid; native signatures, return types, storage and probes are required.
"""
from pathlib import Path
import json
import re
from p874_public_header_inventory import uncomment

ROOT = Path(__file__).resolve().parents[2]
STEMS = ('physics newton replay object input gmesetup stats schedule sim '
         'simqueue quatern scene souffle track trgsfx').split()
SYM = Path(r'C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt')


def definitions(text, name):
    out = []
    text = uncomment(text)
    for m in re.finditer(r'^([A-Za-z_][\w\s:*&]*?)\b' + re.escape(name) + r'\s*\(', text, re.M):
        pos = m.end(); depth = 1
        while pos < len(text) and depth:
            if text[pos] == '(':
                depth += 1
            elif text[pos] == ')':
                depth -= 1
            pos += 1
        if depth or not text[pos:].lstrip().startswith('{'):
            continue
        ret = m[1].strip()
        if '::' in ret:
            continue
        out.append({'return': ret, 'parameters': text[m.end():pos-1].strip(),
                    'signature': re.sub(r'\s+', ' ', text[m.start():pos].strip())})
    return out


def main():
    records = {}
    for m in re.finditer(r'^([0-9a-f]+): \$([0-9a-f]+) 9[46] Def2? class (EXT|STAT) type FCN (.*?) size (\d+)(?: dims .*?)?(?: tag (\S+))? name (\S+)', SYM.read_text(), re.M):
        records.setdefault(m[7], []).append({'record': m[1], 'address': m[2],
            'storage': m[3], 'return': m[4], 'size': m[5], 'tag': m[6]})
    rows = []
    for stem in STEMS:
        header = ROOT / 'recon/game/common' / (stem + '.h')
        source = header.with_suffix('.cpp').read_text(encoding='utf-8')
        for line in header.read_text(encoding='utf-8').splitlines():
            m = re.match(r'\s*(.*?)\b([A-Za-z]\w*?)__F(\w*)\s*\((.*)\)\s*;', line)
            if not m:
                continue
            name = m[2]; symbol = name + '__F' + m[3]
            rows.append({'header': header.relative_to(ROOT).as_posix(),
                'old': line, 'name': name, 'symbol': symbol,
                'native': records.get(symbol, []), 'definitions': definitions(source, name)})
    output = Path(__file__).with_name('p875_root_header_plan.json')
    output.write_text(json.dumps(rows, indent=2) + '\n')
    print(len(rows), 'prototype candidates')
    for row in rows:
        old_sig = row['old'].split(';')[0].strip()
        ds = row['definitions']
        if len(ds) != 1 or not row['native']:
            print('REVIEW', row['symbol'], row['native'], ds)
        elif re.sub(r'\s+', '', old_sig.replace(row['symbol'],row['name'])) != re.sub(r'\s+', '',ds[0]['signature']):
            print(row['symbol'], '\n OLD', old_sig, '\n SRC', ds[0]['signature'], '\n SYM', row['native'])


if __name__ == '__main__':
    main()
