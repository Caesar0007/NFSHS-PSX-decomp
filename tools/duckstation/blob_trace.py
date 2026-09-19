"""blob_trace.py [--seconds N] [--min BYTES] [--per-chunk HITS] -- runtime OWNERSHIP trace for the retail
passthrough blobs.  Launch the project emulator first:

    powershell -File tools/duckstation/launch.ps1 -FastBoot

The tracer arms access watchpoints (GDB Z4, <=256 bytes each) over every blob-only run reported by
scratchpad/psyq_pipe/blob_runs.py logic, lets the game run (boot, menus, attract-mode demo; no input needed),
and for each hit records the accessing PC, $ra, the address touched and whether the instruction is a load or a
store.  PCs are mapped to the retail function (configs/symbol_addrs.txt) and to the reconstructed object that
owns that text address (linkers/nfs4_recon.ld spine), which is the ownership evidence we want.
A chunk is disarmed after --per-chunk hits so hot loops cannot stall the run.
Output: status/runtime/blob_trace.json + a readable summary on stdout."""
import argparse
import bisect
import json
import re
import struct
import sys
import time
from collections import Counter, defaultdict
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
from gdb_remote import Remote, decode_registers  # noqa: E402

PORT = 2350
LOAD = 0x80010000
ap = argparse.ArgumentParser()
ap.add_argument('--seconds', type=int, default=180)
ap.add_argument('--min', type=int, default=8)
ap.add_argument('--per-chunk', type=int, default=40)
args = ap.parse_args()

rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()
entry = struct.unpack_from('<I', rom, 0x10)[0]
n = len(rom) - 0x800

# ---- blob-only runs (same ownership logic as scratchpad/psyq_pipe/blob_runs.py) ----
lines = (ROOT / 'build/gen_ld/recon_multdef-ok.map').read_text(errors='replace').splitlines()
recon, blob = bytearray(n), bytearray(n)
one = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')
two = re.compile(r'^\s+0x([0-9a-f]{8})\s+0x([0-9a-f]+)\s+(\S+\.o)$')


def mark(a, sz, src):
    src = src.replace('\\', '/')
    t = recon if 'build/recon/' in src else blob if 'build/asm/' in src else None
    if t is None or not sz or not (LOAD <= a < LOAD + n):
        return
    for i in range(a - LOAD, min(a - LOAD + sz, n)):
        t[i] = 1


for i, ln in enumerate(lines):
    m = one.match(ln)
    if m:
        mark(int(m.group(2), 16), int(m.group(3), 16), m.group(4))
    elif re.match(r'^ \.\S+$', ln) and i + 1 < len(lines):
        m = two.match(lines[i + 1])
        if m:
            mark(int(m.group(1), 16), int(m.group(2), 16), m.group(3))
runs = []
off = 0
while off < n:
    if blob[off] and not recon[off]:
        s = off
        while off < n and blob[off] and not recon[off]:
            off += 1
        if off - s >= args.min:
            runs.append((LOAD + s, off - s))
    else:
        off += 1
chunks = []
for va, sz in runs:
    for o in range(0, sz, 256):
        chunks.append((va + o, min(256, sz - o)))
print(f'{len(runs)} blob runs >= {args.min} B, {sum(s for _, s in runs)} bytes, {len(chunks)} watch chunks')

# ---- PC -> function / object ----
fn = []
for ln in open(ROOT / 'configs/symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func', ln)
    if m:
        fn.append((int(m.group(2), 16), m.group(1)))
fn.sort()
fk = [v for v, _ in fn]
spine = []
for m in re.finditer(r'(0x[0-9a-f]+) : SUBALIGN\(4\) \{ build/recon/(\S+?)\(\.text\)', (ROOT / 'linkers/nfs4_recon.ld').read_text(errors='replace')):
    spine.append((int(m.group(1), 16), m.group(2)))
spine.sort()
sk = [v for v, _ in spine]


def where(pc):
    i = bisect.bisect_right(fk, pc) - 1
    f = f'{fn[i][1]}+{pc - fn[i][0]:#x}' if i >= 0 else '?'
    j = bisect.bisect_right(sk, pc) - 1
    o = spine[j][1] if j >= 0 else '?'
    return f, o


g = Remote('127.0.0.1', PORT)
hits = []
per_chunk = Counter()
try:
    # run to the executable's entry so the image is in RAM before arming data watchpoints
    assert g.packet('Z0,%x,4' % entry) == 'OK'
    for _ in range(400):
        g.packet('c', timeout=120)
        r = decode_registers(g.packet('g'))
        if int(r['pc'], 16) == entry:
            break
    else:
        raise SystemExit('never reached the entry point %#x' % entry)
    g.packet('z0,%x,4' % entry)
    live = g.read_memory(entry, 16)
    print('entry reached; live RAM == image at entry:', live == rom[entry - LOAD + 0x800:entry - LOAD + 0x810])
    armed = set()
    for va, sz in chunks:
        if g.packet('Z4,%x,%x' % (va, sz)) == 'OK':
            armed.add((va, sz))
    print(f'armed {len(armed)} access watchpoints; running for {args.seconds} s')
    deadline = time.time() + args.seconds
    while time.time() < deadline and armed:
        try:
            reply = g.packet('c', timeout=max(5, deadline - time.time()))
        except Exception:
            g.interrupt()
            break
        m = re.match(r'T[0-9a-f]{2}(a?r?watch):([0-9a-f]{8})', reply)
        if not m:
            continue
        addr = int(m.group(2), 16) | 0x80000000
        r = decode_registers(g.packet('g'))
        pc, ra = int(r['pc'], 16), int(r['r31'], 16)
        ins = struct.unpack('<I', g.read_memory(pc, 4))[0]
        op = ins >> 26
        kind = 'store' if op in (0x28, 0x29, 0x2a, 0x2b, 0x2e) else 'load' if op in (0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26) else 'op%02x' % op
        hits.append({'addr': addr, 'pc': pc, 'ra': ra, 'kind': kind})
        ch = next(((va, sz) for va, sz in armed if va <= addr < va + sz), None)
        if ch:
            per_chunk[ch] += 1
            if per_chunk[ch] >= args.per_chunk:
                g.packet('z4,%x,%x' % ch)
                armed.discard(ch)
finally:
    try:
        g.interrupt()
    except Exception:
        pass
    g.close()

out = ROOT / 'status/runtime/blob_trace.json'
out.parent.mkdir(parents=True, exist_ok=True)
json.dump(hits, open(out, 'w'))
print(f'{len(hits)} hits -> {out}')
by_run = defaultdict(Counter)
for h in hits:
    run = next(((va, sz) for va, sz in runs if va <= h['addr'] < va + sz), None)
    f, o = where(h['pc'])
    by_run[run][(o, f.split('+')[0], h['kind'])] += 1
for run in sorted(k for k in by_run if k):
    print(f'\n== run {run[0]:#010x} +{run[1]}')
    for (o, f, k), c in by_run[run].most_common(8):
        print(f'   {c:5d}  {k:5s}  {o:40s} {f}')
silent = [r for r in runs if r not in by_run]
print(f'\n{len(silent)} runs never touched in this session:')
for va, sz in silent:
    print(f'   {va:#010x} +{sz}')
