#!/usr/bin/env python3
"""slink_pullsolve.py -- which missing REFERENCE puts a library member where retail has it?

slink pulls library members on demand, in the order the unresolved names are met: objects in script order, inside an
object the XREF RECORD order (ASPSX writes those in its symbol-hash order, not in source order).  A member retail has
earlier than we do was asked for by an object that retail linked before that point -- through a reference our object does
not have (a function the final link later removed; the pull happens BEFORE the stripping).
For every displaced member this tries, for each candidate object and each name the member defines, to add that one
reference to a copy of the object (a 2-instruction stripped stub assembled by ASPSX) and keeps the combinations that put
the member EXACTLY at its retail position in the pull model (slink_pullsim.py's model).
usage: slink_pullsolve.py [member ...]"""
import json
import os
import re
import subprocess
import sys
from collections import OrderedDict
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
sys.path.insert(0, str(ROOT / 'tools'))
import psyq_extract as X
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
ASPSX = 'C:/Temp/psq43/PSSN/ASPSX.EXE'
TMP = ROOT / 'build/tmp/pullsolve'; TMP.mkdir(parents=True, exist_ok=True)
only = [a for a in sys.argv[1:] if not a.startswith('--')]


def parse(data):
    o = X.parse_obj(data)
    return [x['name'] for x in o['xdefs']], list(o['xrefs'])


script = (OUT / 'off.lnk').read_text(encoding='latin-1')
objs, libs = [], []
for m in re.finditer(r'^\s+(include|inclib)\s+"?([^",\r\n\t;]+)"?', script, re.M):
    (objs if m.group(1) == 'include' else libs).append(m.group(2).strip())
equ = set(re.findall(r'^(\S+)\s+equ\s', script, re.M))
OBJ = OrderedDict()
for f in objs:
    p = Path(f) if ':' in f else OUT / f
    OBJ[p.name] = parse(p.read_bytes())
index, byname = [], {}
for lf in libs:
    lib = Path(lf).stem.lower()
    raw = Path(lf).read_bytes()
    if raw[:4] == b'LIB' + bytes([1]):
        members = [(m['name'], m['data']) for m in X.lib_members(raw)[0]]
    else:
        members = [(f.stem, f.read_bytes()) for f in sorted((OUT / 'ealib' / lib).glob('*.obj'))]
    for name, blob in members:
        xd, xr = parse(blob)
        index.append(('%s.lib(%s.obj)' % (lib, name.lower()), xd, xr))
        for n in xd:
            byname.setdefault(n, len(index) - 1)


def simulate(objtable, libover=None):
    libover = libover or {}
    defined = set(equ)
    names, seen = [], set()
    for f, (xd, xr) in objtable.items():
        defined.update(xd)
    for f, (xd, xr) in objtable.items():
        for n in xr:
            if n not in seen:
                seen.add(n); names.append(n)
    pulled, loaded = [], set()
    i = 0
    while i < len(names):
        n = names[i]; i += 1
        if n in defined or n not in byname or byname[n] in loaded:
            continue
        k = byname[n]; loaded.add(k)
        tag, xd, xr = index[k]
        xr = libover.get(tag, xr)
        pulled.append(tag); defined.update(xd)
        for r in xr:
            if r not in seen:
                seen.add(r); names.append(r)
    return pulled


order = json.load(open(ROOT / 'tools/psyq_pipe/sym_obj_order.json'))
retail = []
for n, *_ in order:
    m = re.search(r'(\w+)\.lib\((\w+)\.obj\)', n)
    if m:
        t = '%s.lib(%s.obj)' % (m.group(1).lower(), m.group(2).lower())
        if t not in retail:
            retail.append(t)
base = simulate(OBJ)
shared = [t for t in retail if t in base]


def rank(pulled, t):
    """position of t among the shared members"""
    s = [x for x in pulled if x in shared]
    return s.index(t)


def with_ref(objname, sym):
    """XREF list of `objname` after adding one reference to `sym` (real ASPSX, so the record order is the real one)"""
    src = (OUT / objname.replace('.obj', '.s')).read_bytes() if not str(objname).endswith('.s') else Path(objname).read_bytes()
    stub = b'\r\n\t.text\r\n\t.globl\t__pullsolve_stub\r\n__pullsolve_stub:\r\n\tjal\t' + sym.encode() + b'\r\n\tnop\r\n'
    s = TMP / 'probe.s'; o = TMP / 'probe.obj'
    s.write_bytes(src + stub)
    if o.exists():
        o.unlink()
    subprocess.run([ASPSX, '-q', '-G0', str(s), '-o', str(o)], capture_output=True, cwd=str(ROOT))
    return parse(o.read_bytes()) if o.exists() else None


import difflib


def score(pulled):
    s2 = [x for x in pulled if x in want]
    return sum(b.size for b in difflib.SequenceMatcher(None, shared, s2, autojunk=False).get_matching_blocks()), s2


want = {t: shared.index(t) for t in shared}
base_score, base_seq = score(base)
sm = difflib.SequenceMatcher(None, shared, base_seq, autojunk=False)
moved = [t for tag, i1, i2, j1, j2 in sm.get_opcodes() if tag in ('delete', 'replace') for t in shared[i1:i2]]
print('%d shared members, %d in retail order in the model, displaced: %s' % (len(shared), base_score, ' '.join(re.sub(r'^.*\(|\.obj\)', '', m) for m in moved)))
game = [f for f in OBJ if f.startswith('recon__')]
# our EA library members can be the asker too (their removed functions are as invisible as the game's)
EASRC = {}
for m in re.finditer(r'^\s+include\s+(recon__eaclib\S+)\.obj\s*;\s*.*?(\w+)\.lib\((\w+)\.obj\)', (OUT / 'nfs4.lnk').read_text(encoding='latin-1'), re.M):
    EASRC['%s.lib(%s.obj)' % (m.group(2).lower(), m.group(3).lower())] = OUT / (m.group(1) + '.s')
FORCE = [a.split('=', 1)[1] for a in sys.argv[1:] if a.startswith('--target=')]
if FORCE:
    moved = [t for t in shared if any(f in t for f in FORCE)]
for t in moved:
    if only and not any(o in t for o in only):
        continue
    syms = index[[i for i, x in enumerate(index) if x[0] == t][0]][1]
    prev_t = shared[want[t] - 1]
    hits = []
    for f in game:
        xd, xr = OBJ[f]
        for sym in syms:
            if sym in xr:
                continue
            quick = OrderedDict(OBJ); quick[f] = (xd, xr + [sym])      # cheap pre-filter: the reference appended last
            qs, qseq = score(simulate(quick))
            if qs < base_score:
                continue
            r = with_ref(f, sym)
            if r is None:
                continue
            trial = OrderedDict(OBJ); trial[f] = r
            sc, seq = score(simulate(trial))
            k = seq.index(t)
            if sc > base_score and (('--loose' in sys.argv) or (k and seq[k - 1] == prev_t)):
                hits.append((sc, f, sym))
    if '--libs' in sys.argv:
        ix = {x[0]: x for x in index}
        for tag, sfile in EASRC.items():
            if tag not in base or not sfile.exists() or tag == t:
                continue
            for sym in syms:
                if sym in ix[tag][2]:
                    continue
                qs, qseq = score(simulate(OBJ, {tag: ix[tag][2] + [sym]}))
                if qs < base_score:
                    continue
                r = with_ref(str(sfile), sym)
                if r is None:
                    continue
                sc, seq = score(simulate(OBJ, {tag: r[1]}))
                k = seq.index(t)
                if sc > base_score and (('--loose' in sys.argv) or (k and seq[k - 1] == prev_t)):
                    hits.append((sc, tag, sym))
    hits.sort(reverse=True)
    print('%-28s retail: right after %s -- %d solutions' % (t, prev_t, len(hits)))
    for sc, f, sym in hits[:int(os.environ.get("PULLSOLVE_SHOW", "6"))]:
        print('      %-40s references %-30s -> %d members in retail order' % (f.replace('recon__', '')[:40], sym, sc))
