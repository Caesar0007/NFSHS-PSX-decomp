#!/usr/bin/env python3
"""query.py -- read-only function card from runtime/analysis.sqlite.

Usage:
  py -3.14 runtime/tools/query.py 0x80105F40 [--image nfs4-f.exe]
  py -3.14 runtime/tools/query.py transmult            # by name (substring ok)
"""
import argparse, json, sqlite3
from pathlib import Path

RUNTIME = Path(__file__).resolve().parents[1]
ap = argparse.ArgumentParser()
ap.add_argument('key')
ap.add_argument('--image', default='nfs4-f.exe')
ap.add_argument('--full', action='store_true', help='include instruction listing')
a = ap.parse_args()

con = sqlite3.connect((RUNTIME / 'analysis.sqlite').as_uri() + '?mode=ro', uri=True)
con.row_factory = sqlite3.Row

if a.key.lower().startswith('0x'):
    f = con.execute('SELECT * FROM functions WHERE image=? AND address=?',
                    (a.image, int(a.key, 16))).fetchone()
else:
    rows = con.execute('SELECT * FROM functions WHERE image=? AND name LIKE ? '
                       'ORDER BY address', (a.image, f'%{a.key}%')).fetchall()
    if len(rows) > 1 and not any(r['name'] == a.key for r in rows):
        print(json.dumps([dict(r) for r in rows], indent=1))
        raise SystemExit(f'{len(rows)} matches; pick one')
    f = next((r for r in rows if r['name'] == a.key), rows[0] if rows else None)
if not f:
    raise SystemExit('function not found')

va = f['address']
out = {'function': dict(f), 'va_hex': f'0x{va:08X}'}
out['callees'] = [
    {'at': f"0x{r['at']:08X}", 'name': r['target_name'],
     'target': (f"0x{r['target']:08X}" if r['target'] else None),
     'resolved': r['resolved']}
    for r in con.execute(
        'SELECT e.at, e.target_name, e.target, fn.name AS resolved FROM edges e '
        'LEFT JOIN functions fn ON fn.image=e.image AND fn.address=e.target '
        'WHERE e.image=? AND e.source_function=?', (a.image, va))]
out['callers'] = [
    {'caller': r['caller'], 'fn': f"0x{r['source_function']:08X}",
     'at': f"0x{r['at']:08X}"}
    for r in con.execute(
        'SELECT e.source_function, fn.name AS caller, e.at FROM edges e '
        'LEFT JOIN functions fn ON fn.image=e.image AND fn.address=e.source_function '
        'WHERE e.image=? AND (e.target=? OR e.target_name=?)',
        (a.image, va, f['name']))]
out['reuse_peers'] = [dict(r) for r in con.execute(
    'SELECT * FROM function_reuse WHERE (image=? AND address=?) '
    'OR (peer_image=? AND peer_address=?)', (a.image, va, a.image, va))]
out['regional_variants'] = [dict(r) for r in con.execute(
    "SELECT image, address, status, unit FROM functions WHERE name=? AND image!=?",
    (f['name'], a.image))]
if a.full:
    out['instructions'] = [f"0x{r['address']:08X}  {r['text']}" for r in con.execute(
        'SELECT address, text FROM instructions WHERE image=? AND function=? '
        'ORDER BY address', (a.image, va))]
else:
    out['insn_count'] = con.execute(
        'SELECT COUNT(*) FROM instructions WHERE image=? AND function=?',
        (a.image, va)).fetchone()[0]

def enc(o):
    return json.dumps(o, indent=1, default=str)
print(enc(out))
