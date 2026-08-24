#!/usr/bin/env python3
"""w64a21 objclass.py -- BOARD-SIDE mechanism classifier.

For a (unit, symbol) pair, runs objdiff-cli's own one-shot diff (the exact engine
that produces MATCH_PROGRESS.txt's fuzzy_match_percent) and classifies every
diffing instruction:

  RELOC_ALIAS   both sides relocate the same mnemonic; the two reloc targets
                resolve to the SAME VA (splat synthetic `D_<va>` / `func_<va>`
                vs our C symbol + addend).  Byte-identical after link -> the
                board is UNDER-counting; verify_asm's reloc-name leniency is right.
  RELOC_UNK     same shape, but one side's symbol has no known VA (co-equal XDEF
                aliases such as rdiv/fixeddiv).  Needs an eyeball; almost always
                the same class.
  BRANCH_DEST   the branch/jump DESTINATION differs -> a REAL byte divergence the
                gate normalises away (04Q law).  Production signal.
  DATA          a .word/data row inside the symbol span.
  STRUCT        insert/delete (instruction-count divergence).
  OTHER         opcode or non-reloc argument mismatch -> real.

Usage: python objclass.py UNIT SYMBOL [--json]
       python objclass.py --batch worklist.json  (writes objclass.jsonl)
"""
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

# Resolve the checkout that owns this tool so linked worktrees classify their
# own objects/configuration instead of silently reading the primary checkout.
ROOT = Path(__file__).resolve().parents[1]
CLI = str(ROOT / 'tools' / 'objdiff' / 'objdiff-cli.exe')   # vendored 3.8.0; the repo IS the version pin

_ADDRS = None


def addrs():
    global _ADDRS
    if _ADDRS is None:
        _ADDRS = {}
        for ln in (ROOT / 'configs' / 'symbol_addrs.txt').read_text(
                encoding='utf-8', errors='replace').splitlines():
            m = re.match(r'^\s*([A-Za-z_$][\w$.]*)\s*=\s*(0x[0-9A-Fa-f]+)\s*;', ln)
            if m:
                _ADDRS.setdefault(m.group(1), int(m.group(2), 16))
    return _ADDRS


def sym_va(name):
    """VA of a reloc target symbol, or None."""
    if name is None:
        return None
    m = re.fullmatch(r'(?:D|func|jtbl|jpt|dlabel)_([0-9A-Fa-f]{6,8})', name)
    if m:
        return int(m.group(1), 16)
    return addrs().get(name)


def reloc_of(ins, symtab):
    r = ins.get('relocation')
    if not r:
        return None
    ts = r.get('target_symbol')
    nm = None
    if ts is not None and ts < len(symtab):
        nm = symtab[ts].get('name')
    return (r.get('type_name'), nm, int(r.get('addend', 0) or 0))


def mnem(ins):
    for p in ins.get('parts', []):
        if 'opcode' in p:
            return p['opcode'].get('mnemonic')
    return None


def run_diff(unit, symbol):
    with tempfile.NamedTemporaryFile('w', suffix='.json', delete=False) as f:
        out = f.name
    r = subprocess.run([CLI, 'diff', '-u', unit, symbol, '-o', out,
                        '--format', 'json'],
                       cwd=str(ROOT), capture_output=True, text=True)
    if r.returncode != 0:
        return None, f'objdiff-cli failed: {r.stderr.strip()[:200]}'
    d = json.load(open(out, encoding='utf-8'))
    Path(out).unlink(missing_ok=True)
    return d, None


def pick(side, symbol):
    syms = side.get('symbols', [])
    for s in syms:
        if s.get('name') == symbol:
            return s, syms
    # mangled-name suffix drift (objdiff prints the object's own spelling)
    for s in syms:
        n = s.get('name', '')
        if n.startswith(symbol) or symbol.startswith(n):
            if s.get('kind') == 'SYMBOL_FUNCTION':
                return s, syms
    return None, syms


def classify(unit, symbol):
    d, err = run_diff(unit, symbol)
    if err:
        return {'unit': unit, 'fn': symbol, 'err': err}
    L, Lsyms = pick(d['left'], symbol)     # target = expected (splat oracle)
    R, Rsyms = pick(d['right'], symbol)    # base   = our recon object
    if L is None or R is None:
        return {'unit': unit, 'fn': symbol,
                'err': 'symbol not found in %s side' % ('left' if L is None else 'right')}
    li, ri = L.get('instructions', []), R.get('instructions', [])
    out = {'unit': unit, 'fn': symbol,
           'match': R.get('match_percent'),
           'n_left': len(li), 'n_right': len(ri), 'rows': []}
    n = max(len(li), len(ri))
    for i in range(n):
        a = li[i] if i < len(li) else None
        b = ri[i] if i < len(ri) else None
        k = (b or a or {}).get('diff_kind', 'DIFF_NONE')
        if k in (None, 'DIFF_NONE'):
            continue
        ai = (a or {}).get('instruction', {})
        bi = (b or {}).get('instruction', {})
        fa, fb = ai.get('formatted'), bi.get('formatted')
        if k in ('DIFF_INSERT', 'DIFF_DELETE') or a is None or b is None:
            cls = 'STRUCT'
        elif mnem(ai) != mnem(bi):
            cls = 'OTHER'
        elif ai.get('branch_dest') is not None or bi.get('branch_dest') is not None:
            cls = ('BRANCH_DEST'
                   if ai.get('branch_dest') != bi.get('branch_dest') else 'OTHER')
        else:
            ra, rb = reloc_of(ai, Lsyms), reloc_of(bi, Rsyms)
            if ra and rb and ra[0] == rb[0]:
                va, vb = sym_va(ra[1]), sym_va(rb[1])
                if va is not None and vb is not None:
                    cls = 'RELOC_ALIAS' if (va + ra[2]) == (vb + rb[2]) else 'RELOC_DIFF'
                else:
                    cls = 'RELOC_UNK'
            elif (fa or '').lstrip().startswith('.') or (fb or '').lstrip().startswith('.'):
                cls = 'DATA'
            else:
                cls = 'OTHER'
        out['rows'].append({'i': i, 'kind': k, 'cls': cls,
                            'target': fa, 'ours': fb})
    kinds = {}
    for r in out['rows']:
        kinds[r['cls']] = kinds.get(r['cls'], 0) + 1
    out['classes'] = kinds
    return out


def main():
    if sys.argv[1] == '--batch':
        rows = json.load(open(sys.argv[2], encoding='utf-8'))
        with open(ROOT / 'scratchpad/w64a21/objclass.jsonl', 'w') as f:
            for r in rows:
                res = classify(r['unit'], r['fn'])
                f.write(json.dumps(res) + '\n')
                f.flush()
                print(f"{r['unit']:<32} {r['fn'][:48]:<48} {res.get('classes', res.get('err'))}",
                      flush=True)
        return
    res = classify(sys.argv[1], sys.argv[2])
    print(json.dumps(res, indent=1))


if __name__ == '__main__':
    main()
