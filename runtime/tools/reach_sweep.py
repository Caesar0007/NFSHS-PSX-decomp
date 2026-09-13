#!/usr/bin/env python3
"""reach_sweep.py -- count executions of watched functions during a driven run.

Loads a checkpoint, breakpoints the watched fns + PAD_update, drives the
menu-mash input route, and reports per-fn hit counts (with first-hit frame
and $ra owner).  Coverage evidence for semantic probes: a probe is only
valid over a scenario that actually EXECUTES the function.

Usage:
  py -3.14 runtime/tools/reach_sweep.py --checkpoint frontend-loaded-v1 \
      --frames 1800 [--watch NAME:VA,...]
"""
import argparse, json, sqlite3, sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote

RUNTIME = Path(__file__).resolve().parents[1]
PORT = 2350
PAD_UPDATE = 0x800E4210
RAW_PAD0 = 0x8013E8F0

DEFAULT_WATCH = {
    'FntFlush':           0x800F6D18,
    '_st_dma':            0x800F87C0,
    'MemCardGetDirentry': 0x800FB888,
    'MemCardFormat':      0x800FBFDC,
}

BTN = {'START': 0x0008, 'CROSS': 0x4000, 'DOWN': 0x0040, 'UP': 0x0010,
       'TRIANGLE': 0x1000, '-': 0}

def pad_payload(mask):
    inv = (~mask) & 0xFFFF
    return bytes([0x00, 0x41, inv & 0xFF, inv >> 8]).hex()

def stop_cpu(g):
    for _ in range(3):
        try:
            r = g.packet('?', timeout=2)
            if r.startswith(('S', 'T')):
                g.stopped = True
                return
        except (TimeoutError, OSError):
            pass
        try:
            r = g.interrupt()
            if r.startswith(('S', 'T')):
                g.stopped = True
                return
        except (TimeoutError, OSError):
            pass
    raise RuntimeError('cannot stop CPU')

def owner(db, pc):
    r = db.execute("SELECT name, address FROM functions WHERE image='nfs4-f.exe' "
                   "AND address<=? ORDER BY address DESC LIMIT 1", (pc,)).fetchone()
    return f'{r[0]}+0x{pc - r[1]:X}' if r else hex(pc)

def route_masks():
    while True:
        for mask in (BTN['START'], 0, BTN['CROSS'], 0, BTN['DOWN'], 0,
                     BTN['CROSS'], 0):
            for _ in range(6):
                yield mask

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--checkpoint')
    ap.add_argument('--frames', type=int, default=1800)
    ap.add_argument('--watch')
    ap.add_argument('--idle', action='store_true', help='no input injection')
    args = ap.parse_args()
    watch = DEFAULT_WATCH
    if args.watch:
        watch = {p.split(':')[0]: int(p.split(':')[1], 16)
                 for p in args.watch.split(',')}
    db = sqlite3.connect(RUNTIME / 'analysis.sqlite')
    g = Remote('127.0.0.1', PORT)
    hits = {n: [] for n in watch}      # first few (frame, ra_owner)
    counts = {n: 0 for n in watch}
    frame = 0
    try:
        stop_cpu(g)
        if args.checkpoint:
            g.checkpoint(args.checkpoint, load=True)
        for va in [PAD_UPDATE] + list(watch.values()):
            assert g.packet(f'Z0,{va:x},4') == 'OK', hex(va)
        masks = route_masks()
        while frame < args.frames:
            g.send_no_reply('c')
            while True:
                r = g._receive_packet()
                if r.startswith(('S', 'T')):
                    g.stopped = True
                    break
            regs = g.packet('g')
            pc = int.from_bytes(bytes.fromhex(regs[37*8:37*8+8]), 'little')
            if pc == PAD_UPDATE:
                frame += 1
                if not args.idle:
                    g.packet(f'M{RAW_PAD0:x},4:{pad_payload(next(masks))}')
            else:
                name = next((n for n, v in watch.items() if v == pc), hex(pc))
                counts[name] = counts.get(name, 0) + 1
                if len(hits.get(name, [])) < 5:
                    ra = int.from_bytes(bytes.fromhex(regs[31*8:31*8+8]), 'little')
                    hits[name].append((frame, owner(db, ra)))
        print(json.dumps({'frames': frame, 'counts': counts, 'first_hits': hits},
                         indent=1))
    finally:
        try:
            stop_cpu(g)
            for va in [PAD_UPDATE] + list(watch.values()):
                g.packet(f'z0,{va:x},4', timeout=2)
            g.send_no_reply('c')
        except Exception:
            pass
        g.close()

if __name__ == '__main__':
    main()
