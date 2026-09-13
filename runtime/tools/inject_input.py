#!/usr/bin/env python3
"""inject_input.py -- deterministic pad injection for the NFS4 runtime lane.

Mechanism (addresses recovered from analysis.sqlite, padinit/PAD_update):
  padinit  -> PadInitDirect(0x8013E8F0, 0x8013E8F8)   raw direct-mode buffers
  PAD_update @0x800E4210 (per-frame timer) copies raw -> state @0x8013E8A0.
Breakpoint at PAD_update entry; on every hit write the raw port-0 buffer
(status 0x00, id 0x41 digital, ~buttons active-low LE), continue.  The write
lands after the SIO exchange and before the game-visible copy, so the game
decodes exactly the injected state each frame.

Standard digital button mask bits (halfword): SELECT 0x0001 START 0x0008
UP 0x0010 RIGHT 0x0020 DOWN 0x0040 LEFT 0x0080 L2 0x0100 R2 0x0200 L1 0x0400
R1 0x0800 TRIANGLE 0x1000 CIRCLE 0x2000 CROSS 0x4000 SQUARE 0x8000.

Usage:
  py -3.14 runtime/tools/inject_input.py --route menu [--max-frames 3600]
  py -3.14 runtime/tools/inject_input.py --press START:8,-:8,CROSS:8,-:8
"""
import argparse, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote

ROOT = Path(__file__).resolve().parents[2]
PORT = 2350
PAD_UPDATE = 0x800E4210
RAW_PAD0 = 0x8013E8F0
FRONT_CHECK = (0x80034C80, 0x24C80)          # SaveGame code: resident == FE loaded

BTN = {'SELECT': 0x0001, 'START': 0x0008, 'UP': 0x0010, 'RIGHT': 0x0020,
       'DOWN': 0x0040, 'LEFT': 0x0080, 'L2': 0x0100, 'R2': 0x0200,
       'L1': 0x0400, 'R1': 0x0800, 'TRIANGLE': 0x1000, 'CIRCLE': 0x2000,
       'CROSS': 0x4000, 'SQUARE': 0x8000, '-': 0}

def pad_bytes(mask):
    inv = (~mask) & 0xFFFF
    return bytes([0x00, 0x41, inv & 0xFF, inv >> 8]).hex()

def stop_cpu(g):
    try:
        r = g.packet('?', timeout=2)
        if r.startswith(('S', 'T')):
            g.stopped = True
            return
    except (TimeoutError, OSError):
        pass
    g.interrupt()

def parse_press(spec):
    steps = []
    for part in spec.split(','):
        name, n = part.rsplit(':', 1)
        steps.append((BTN[name.upper()] if name.upper() in BTN else int(name, 0),
                      int(n)))
    return steps

def route_menu():
    """Idle through boot, then mash START and CROSS press/release cycles."""
    steps = [(0, 90)]
    for _ in range(200):
        steps += [(BTN['START'], 6), (0, 6), (BTN['CROSS'], 6), (0, 6)]
    return steps

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--route', choices=['menu'])
    ap.add_argument('--press')
    ap.add_argument('--max-frames', type=int, default=3600)
    ap.add_argument('--until-frontend', action='store_true', default=None)
    args = ap.parse_args()
    steps = route_menu() if args.route == 'menu' else parse_press(args.press)
    until_fe = args.until_frontend if args.until_frontend is not None else (args.route == 'menu')
    base = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[0x800:]
    fe_ref = base[FRONT_CHECK[1]:FRONT_CHECK[1] + 64]

    g = Remote('127.0.0.1', PORT)
    frame = 0
    try:
        stop_cpu(g)
        assert g.packet(f'Z0,{PAD_UPDATE:x},4') == 'OK', 'breakpoint set failed'
        for mask, frames in steps:
            payload = pad_bytes(mask)
            for _ in range(frames):
                g.send_no_reply('c')
                # wait for the breakpoint stop
                while True:
                    r = g._receive_packet()
                    if r.startswith(('S', 'T')):
                        g.stopped = True
                        break
                g.packet(f'M{RAW_PAD0:x},4:{payload}')
                frame += 1
                if until_fe and frame % 60 == 0:
                    if g.read_memory(FRONT_CHECK[0], 64) == fe_ref:
                        print(f'frontend RESIDENT at frame {frame}')
                        return
                if frame >= args.max_frames:
                    print(f'frame budget exhausted at {frame}')
                    return
        print(f'route complete at frame {frame}')
    finally:
        try:
            stop_cpu(g)
            g.packet(f'z0,{PAD_UPDATE:x},4')
            g.send_no_reply('c')
        except Exception:
            pass
        g.close()

if __name__ == '__main__':
    main()
