#!/usr/bin/env python3
"""build_database.py -- build runtime/analysis.sqlite for the NFS4 project.

Adapts the PSX-Dynamic-Decomp sqlite-database-guide to nfs4-decomp's existing
artifacts (everything is REGENERABLE -- the db is derived, never hand-edited):

  images        : rom/nfs4-f.exe (base, == NFS4-B-USA.EXE == dev-CD NFS4.EXE +
                  FRONT.BIN overlay) + the six retail regionals
  functions     : names/VAs from MATCH_PROGRESS.txt (base) and
                  regiondiff/oracles/<R>/INDEX.tsv (regionals);
                  status: base %match 100 -> DONE else WIP;
                  regionals from regiondiff/REGION_PROGRESS.txt
  instructions  : the symdump disasm oracle (C:/Temp/symdump-disasm/disasm-v4.txt)
                  -- rendered text + the raw 32-bit word read from the image
  edges         : direct calls parsed from the oracle's `&Name()` lines
  symbols       : configs/symbol_addrs.txt (code+data, incl. overlay markers)
  function_reuse: regiondiff/variants.tsv cross-region variant groups

Usage:  py -3.14 runtime/tools/build_database.py
"""
import re, sqlite3, hashlib, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RUNTIME = ROOT / 'runtime'
DB = RUNTIME / 'analysis.sqlite'
DISASM = Path(r'C:/Temp/symdump-disasm/disasm-v4.txt')
BIN = Path(r'C:/Temp/nfs4-clean/Binaries')
LOAD = 0x80010000
BASE_IMG = 'nfs4-f.exe'
REGIONS = ['NFS4-R-AU', 'NFS4-R-FR-DE', 'NFS4-R-JPN', 'NFS4-R-UK-ES-IT',
           'NFS4-R-UK-SW', 'NFS4-R-USA']

SCHEMA = """
CREATE TABLE images(image TEXT PRIMARY KEY, path TEXT, sha256 TEXT,
                    load_addr INT, entry INT, size INT);
CREATE TABLE functions(image TEXT, address INT, end INT, name TEXT,
                    unit TEXT, status TEXT, match REAL, sha256 TEXT,
                    PRIMARY KEY(image, address));
CREATE TABLE instructions(image TEXT, address INT, word INT, text TEXT,
                    function INT, PRIMARY KEY(image, address));
CREATE TABLE edges(image TEXT, source_function INT, at INT, target_name TEXT,
                    target INT);
CREATE TABLE symbols(image TEXT, name TEXT, address INT,
                    PRIMARY KEY(image, name, address));
CREATE TABLE function_reuse(image TEXT, address INT, group_id INT,
                    peer_image TEXT, peer_address INT, kind TEXT);
CREATE TABLE metadata(key TEXT PRIMARY KEY, value TEXT);
CREATE INDEX idx_fn_name ON functions(name);
CREATE INDEX idx_edge_src ON edges(image, source_function);
CREATE INDEX idx_edge_tgt ON edges(image, target_name);
CREATE INDEX idx_insn_fn ON instructions(image, function);
"""

def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def main():
    if DB.exists():
        DB.unlink()
    con = sqlite3.connect(DB)
    con.executescript(SCHEMA)

    # ---------------- images ----------------
    base_path = ROOT / 'rom' / BASE_IMG
    img = base_path.read_bytes()
    con.execute('INSERT INTO images VALUES(?,?,?,?,?,?)',
                (BASE_IMG, str(base_path), sha(base_path), LOAD,
                 int.from_bytes(img[0x10:0x14], 'little'), len(img) - 0x800))
    for r in REGIONS:
        p = BIN / (r + '.EXE')
        if p.exists():
            b = p.read_bytes()
            con.execute('INSERT INTO images VALUES(?,?,?,?,?,?)',
                        (r, str(p), sha(p), LOAD,
                         int.from_bytes(b[0x10:0x14], 'little'), len(b) - 0x800))
    payload = img[0x800:]

    def word(va):
        off = va - LOAD
        if 0 <= off + 4 <= len(payload):
            return int.from_bytes(payload[off:off+4], 'little')
        return None

    # ---------------- base functions from MATCH_PROGRESS ----------------
    fn_rows = {}
    for ln in (ROOT / 'MATCH_PROGRESS.txt').read_text().splitlines():
        m = re.match(r'^(0x[0-9A-Fa-f]{8})\s+([\d.]+)%\s+(\S+)\s+(\S+)$', ln)
        if m:
            va = int(m.group(1), 16)
            pct = float(m.group(2))
            fn_rows[va] = [m.group(4), m.group(3), pct]

    # ---------------- oracle disasm: boundaries + instructions + edges ----
    # Function starts: the MATCH_PROGRESS board is authoritative (the oracle
    # lacks `name:` headers for many debug-stripped lib fns); oracle headers
    # add oracle-only labels.  Every instruction is attributed to the start
    # bin it falls in (bisect), so an unlabeled lib fn never bleeds into the
    # previous labeled span.
    print('parsing disasm oracle ...', flush=True)
    import bisect as _b
    starts = {va: name for va, (name, _u, _m) in fn_rows.items()}
    pending = None
    insns = []
    calls = []                         # (fn_va, at, target_name)
    lines = []                         # (va, text) first pass
    addr_re = re.compile(r'^\s+0x([0-9A-Fa-f]{8})\s\s(.*)$')
    call_re = re.compile(r'&([A-Za-z_$][\w$]*)\(')
    with DISASM.open(encoding='latin-1') as f:
        for ln in f:
            if ln and ln[0] not in ' \t#\n':
                m = re.match(r'^([\w$]+):', ln)
                if m and not m.group(1).startswith('lbl_'):
                    pending = m.group(1)
                continue
            m = addr_re.match(ln)
            if not m:
                continue
            va = int(m.group(1), 16)
            if pending is not None:
                starts.setdefault(va, pending)
                pending = None
            lines.append((va, m.group(2).rstrip()))
    svas = sorted(starts)
    fn_last = {}
    for va, text in lines:
        i = _b.bisect_right(svas, va) - 1
        if i < 0:
            continue                    # data before the first function
        fn = svas[i]
        fn_last[fn] = max(fn_last.get(fn, fn), va)
        insns.append((BASE_IMG, va, word(va), text, fn))
        cm = call_re.search(text)
        if cm and not cm.group(1).startswith('lbl_'):
            calls.append((fn, va, cm.group(1)))
    con.executemany('INSERT OR REPLACE INTO instructions VALUES(?,?,?,?,?)', insns)

    name2va = {n: v for v, n in starts.items()}
    for va in svas:
        name = starts[va]
        unit, status, match = '?', 'TODO', None
        if va in fn_rows:
            _n, unit, match = fn_rows[va]
            status = 'DONE' if match >= 100.0 else 'WIP'
        last = fn_last.get(va)
        end = (last + 4) if last else None
        body = payload[va - LOAD: end - LOAD] if end else b''
        con.execute('INSERT OR REPLACE INTO functions VALUES(?,?,?,?,?,?,?,?)',
                    (BASE_IMG, va, end, name, unit, status, match,
                     hashlib.sha256(body).hexdigest() if body else None))

    fva_re = re.compile(r'^func_([0-9A-Fa-f]{8})$')
    for fn, at, tname in calls:
        target = name2va.get(tname)
        if target is None:
            m = fva_re.match(tname)
            if m:
                target = int(m.group(1), 16)
        con.execute('INSERT INTO edges VALUES(?,?,?,?,?)',
                    (BASE_IMG, fn, at, tname, target))

    # ---------------- symbols ----------------
    for ln in (ROOT / 'configs' / 'symbol_addrs.txt').read_text().splitlines():
        m = re.match(r'^\s*([\w$.]+)\s*=\s*(0x[0-9A-Fa-f]+)\s*;', ln)
        if m:
            con.execute('INSERT OR IGNORE INTO symbols VALUES(?,?,?)',
                        (BASE_IMG, m.group(1), int(m.group(2), 16)))

    # ---------------- regional functions + reuse groups ----------------
    prog = {}
    rp = ROOT / 'regiondiff' / 'REGION_PROGRESS.txt'
    if rp.exists():
        for ln in rp.read_text().splitlines():
            m = re.match(r'^(SEALED|FAIL|TODO|N-A)\S*\s+\d+\s+(\S+)\s+(\S+)\s+(\S+)$', ln)
            if m:
                prog[(m.group(2), m.group(4))] = m.group(1)
    for r in REGIONS:
        idx = ROOT / 'regiondiff' / 'oracles' / r / 'INDEX.tsv'
        if not idx.exists():
            continue
        short = r.replace('NFS4-R-', '')
        for ln in idx.read_text().splitlines()[1:]:
            f = ln.split('\t')
            if len(f) < 4 or not f[1]:
                continue
            va = int(f[1], 16)
            st = prog.get((short, f[3]), 'TODO')
            st = {'SEALED': 'DONE', 'FAIL': 'WIP', 'N-A': 'SKIP'}.get(st, st)
            con.execute('INSERT OR REPLACE INTO functions VALUES(?,?,?,?,?,?,?,?)',
                        (r, va, None, f[3], f[0], st, None, None))
            if f[2]:                    # CHANGED rows: base sibling = reuse pair
                con.execute('INSERT INTO function_reuse VALUES(?,?,?,?,?,?)',
                            (r, va, None, BASE_IMG, int(f[2], 16), 'regional-variant'))

    con.execute("INSERT INTO metadata VALUES('generator','runtime/tools/build_database.py')")
    con.execute("INSERT INTO metadata VALUES('oracle', ?)", (str(DISASM),))
    import datetime
    con.execute("INSERT INTO metadata VALUES('built', ?)",
                (datetime.datetime.now().isoformat(),))
    con.commit()
    for t in ('images', 'functions', 'instructions', 'edges', 'symbols',
              'function_reuse'):
        print(f'{t:16} {con.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0]}')
    con.close()

if __name__ == '__main__':
    main()
