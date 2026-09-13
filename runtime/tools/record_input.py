#!/usr/bin/env python3
"""record_input.py -- record a human playthrough as a deterministic input tape.

Saves a start checkpoint, then logs the RAW pad port-0 bytes at every
PAD_update (the game's own per-frame decode point) into <label>.pad.bin
(4 bytes/frame).  Replay with run_frames.py --pad-file to reproduce the
session exactly from <label>-start.

Also monitors the probe scratch window (0x801E5F00..0x801EA000) every 300
frames and reports if the game ever writes there -- the go/no-go for
relocated-candidate patching during the recorded scenario.

The emulator should be running VISIBLE at 100%% speed (launch.ps1 -Visible);
per-frame GDB stops cost a little smoothness while recording.

Usage:
  py -3.14 runtime/tools/record_input.py --label race1 --frames 30000
"""
import argparse, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote

RUNTIME = Path(__file__).resolve().parents[1]
PORT = 2350
PAD_UPDATE = 0x800E4210
RAW_PAD0 = 0x8013E8F0
SCRATCH_LO, SCRATCH_HI = 0x801E5F00, 0x801EA000

def stop_cpu(g):
    for _ in range(4):
        try:
            r = g.packet('?', timeout=2)
            if r.startswith(('S', 'T')):
                g.stopped = True
                return
        except (TimeoutError, OSError):
            pass
        try:
            g.send_no_reply('c')
            time.sleep(0.2)
            r = g.interrupt()
            if r.startswith(('S', 'T')):
                g.stopped = True
                return
        except (TimeoutError, OSError):
            pass
    raise RuntimeError('cannot stop CPU')

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--label', required=True)
    ap.add_argument('--frames', type=int, default=30000)
    args = ap.parse_args()
    g = Remote('127.0.0.1', PORT)
    tape = bytearray()
    dirty = set()
    out = RUNTIME / 'traces' / (args.label + '.pad.bin')
    out.parent.mkdir(parents=True, exist_ok=True)
    try:
        stop_cpu(g)
        g.checkpoint(args.label + '-start')
        print(f'checkpoint {args.label}-start saved; RECORDING -- play now '
              f'(up to {args.frames} frames); Ctrl+C here to finish early',
              flush=True)
        assert g.packet(f'Z0,{PAD_UPDATE:x},4') == 'OK'
        frame = 0
        try:
            while frame < args.frames:
                g.send_no_reply('c')
                while True:
                    try:
                        r = g._receive_packet()
                    except TimeoutError:
                        continue          # user paused / long frame
                    if r.startswith(('S', 'T')):
                        g.stopped = True
                        break
                tape += g.read_memory(RAW_PAD0, 4)
                frame += 1
                if frame % 300 == 0:
                    out.write_bytes(tape)          # crash/kill-safe tape
                    blk = g.read_memory(SCRATCH_LO, SCRATCH_HI - SCRATCH_LO)
                    nz = [i for i, b in enumerate(blk) if b]
                    if nz:
                        dirty.add((SCRATCH_LO + nz[0]) & ~0xFFF)
                    print(f'  {frame} frames'
                          + (f'  ⚠️ scratch dirty near {hex(SCRATCH_LO+nz[0])}' if nz else ''),
                          flush=True)
        except KeyboardInterrupt:
            print('stopping on Ctrl+C', flush=True)
        out.write_bytes(tape)
        print(f'{len(tape)//4} frames -> {out}')
        print('scratch window ' + ('CLEAN for this scenario' if not dirty
              else f'DIRTY pages: {[hex(d) for d in sorted(dirty)]}'))
    finally:
        try:
            stop_cpu(g)
            g.packet(f'z0,{PAD_UPDATE:x},4', timeout=2)
            g.send_no_reply('c')
        except Exception:
            pass
        g.close()

if __name__ == '__main__':
    main()
