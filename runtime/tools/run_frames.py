#!/usr/bin/env python3
"""run_frames.py -- deterministic driven run: load checkpoint, inject a fixed
input stream, run N PAD_update frames, dump full 2 MiB RAM.

The workhorse behind paired semantic probes: two runs from the same
checkpoint with the same schedule must produce identical RAM (determinism
gate), and a candidate-patched run is compared against baseline the same way.

Usage:
  py -3.14 runtime/tools/run_frames.py --checkpoint frontend-loaded-v1 \
      --frames 300 --out traces/base-a.ram [--patch VA=HEXBYTES,...] [--idle]
"""
import argparse, hashlib, sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote

RUNTIME = Path(__file__).resolve().parents[1]
PORT = 2350
PAD_UPDATE = 0x800E4210
RAW_PAD0 = 0x8013E8F0

BTN = {'START': 0x0008, 'CROSS': 0x4000, 'DOWN': 0x0040, '-': 0}

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

def route_masks():
    while True:
        for mask in (BTN['START'], 0, BTN['CROSS'], 0, BTN['DOWN'], 0,
                     BTN['CROSS'], 0):
            for _ in range(6):
                yield mask

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--checkpoint', required=True)
    ap.add_argument('--frames', type=int, default=300)
    ap.add_argument('--out', required=True)
    ap.add_argument('--patch', help='VA=HEXBYTES[,VA=HEXBYTES...] applied after load')
    ap.add_argument('--idle', action='store_true')
    ap.add_argument('--pad-file', help='recorded input tape (4 bytes/frame) '
                                       'from record_input.py; overrides the '
                                       'route and sets the frame count')
    ap.add_argument('--hash-every', type=int, default=0,
                    help='record an intermediate full-RAM sha every N frames')
    args = ap.parse_args()
    tape = None
    tape_c0 = tape_caddr = None
    if args.pad_file:
        p = Path(args.pad_file)
        p = p if p.is_absolute() else RUNTIME / p
        tape = p.read_bytes()
        args.frames = len(tape) // 4
        side = p.with_suffix('.json')          # <label>.pad.json sidecar
        if side.exists():
            import json as _j
            meta = _j.loads(side.read_text())
            tape_c0 = meta.get('counter0')
            tape_caddr = meta.get('counter_addr')
            # PAD_update fires >1x per video frame; give the loop headroom to
            # walk the 60Hz counter through the whole tape (it breaks at the end)
            args.frames = (len(tape) // 4) * 4
    g = Remote('127.0.0.1', PORT)
    try:
        stop_cpu(g)
        g.checkpoint(args.checkpoint, load=True)
        if args.patch:
            for p in args.patch.split(','):
                va, hexb = p.split('=')
                assert g.packet(f'M{int(va,16):x},{len(hexb)//2:x}:{hexb}') == 'OK'
        assert g.packet(f'Z0,{PAD_UPDATE:x},4') == 'OK'
        masks = route_masks()
        frame = 0
        import hashlib as _hl
        interim = []
        while frame < args.frames:
            g.send_no_reply('c')
            while True:
                try:
                    r = g._receive_packet()
                except TimeoutError:
                    continue
                if r.startswith(('S', 'T')):
                    g.stopped = True
                    break
            if tape is not None:
                if tape_caddr is not None:
                    # counter-keyed: align to the same 60Hz clock the tape was
                    # recorded against, independent of PAD_update firing rate
                    cur = int.from_bytes(g.read_memory(tape_caddr, 4), 'little')
                    idx = cur - tape_c0
                    if idx < 0:
                        idx = 0
                    elif idx * 4 + 4 > len(tape):
                        break               # replayed the whole tape
                    g.packet(f'M{RAW_PAD0:x},4:{tape[idx*4:idx*4+4].hex()}')
                else:
                    g.packet(f'M{RAW_PAD0:x},4:{tape[frame*4:frame*4+4].hex()}')
            elif not args.idle:
                g.packet(f'M{RAW_PAD0:x},4:{pad_payload(next(masks))}')
            frame += 1
            if args.hash_every and frame % args.hash_every == 0:
                h = _hl.sha256(g.read_memory(0x80000000, 0x200000)).hexdigest()[:16]
                interim.append((frame, h))
                print(f'  frame {frame}: {h}', flush=True)
        ram = g.read_memory(0x80000000, 0x200000)
        regs = g.packet('g')
        out = RUNTIME / args.out if not Path(args.out).is_absolute() else Path(args.out)
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_bytes(ram)
        (out.with_suffix(out.suffix + '.regs')).write_text(regs)
        print(f'{args.frames} frames -> {out}  sha256 {hashlib.sha256(ram).hexdigest()[:16]}')
        g.packet(f'z0,{PAD_UPDATE:x},4')
    finally:
        try:
            stop_cpu(g)
            g.packet(f'z0,{PAD_UPDATE:x},4', timeout=2)
        except Exception:
            pass
        g.close()

if __name__ == '__main__':
    main()
