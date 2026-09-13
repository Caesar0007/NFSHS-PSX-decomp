#!/usr/bin/env python3
"""hook_recorder.py -- zero-stutter in-game input recorder.

Patches a ~20-insn stub over PAD_update's first two instructions: every
frame the GAME itself logs (frame, raw-pad-word) CHANGES into a scratch
ring -- no GDB stops while the human plays.  `install` arms it (and zeroes
the ring), `dump` stops once, reads the ring, reconstructs the full
4-bytes/frame tape, and restores the original code.

Layout: stub @0x801E5000; ring header @0x801E5100 (framecnt, nchanges,
lastval); entries (frame, value) @0x801E5110, capacity 2462 changes.

Usage:
  py -3.14 runtime/tools/hook_recorder.py install
  ... human plays ...
  py -3.14 runtime/tools/hook_recorder.py dump --label fullgame2
"""
import argparse, struct, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote

ROOT = Path(__file__).resolve().parents[2]
RUNTIME = Path(__file__).resolve().parents[1]
PORT = 2350
PAD_UPDATE = 0x800E4210
STUB = 0x801E5000
RING = 0x801E5100
ENTRIES = RING + 0x10
CAP = 2462

ORIG0, ORIG1 = 0x27BDFFE0, 0x3C028014      # addiu sp,-0x20 ; lui v0,0x8014

STUB_WORDS = [
    0x3C08801E,  # lui   t0,0x801E
    0x35085100,  # ori   t0,t0,0x5100          t0 = RING
    0x8D090000,  # lw    t1,0(t0)              framecnt
    0x3C0A8014,  # lui   t2,0x8014
    0x8D4BE8F0,  # lw    t3,-0x1710(t2)        raw pad word @0x8013E8F0
    0x8D0C0008,  # lw    t4,8(t0)              lastval
    0x252D0001,  # addiu t5,t1,1
    0xAD0D0000,  # sw    t5,0(t0)              framecnt++
    0x116C0009,  # beq   t3,t4,skip (+9)
    0x00000000,  # nop
    0xAD0B0008,  # sw    t3,8(t0)              lastval = t3
    0x8D0E0004,  # lw    t6,4(t0)              nchanges
    0x000E78C0,  # sll   t7,t6,3
    0x01E87821,  # addu  t7,t7,t0
    0xADE90010,  # sw    t1,0x10(t7)           entry.frame
    0xADEB0014,  # sw    t3,0x14(t7)           entry.value
    0x25CE0001,  # addiu t6,t6,1
    0xAD0E0004,  # sw    t6,4(t0)              nchanges++
    ORIG0,       # skip: displaced insn 0
    ORIG1,       #       displaced insn 1
    0x08000000 | ((PAD_UPDATE + 8) >> 2) & 0x03FFFFFF,  # j PAD_update+8
    0x00000000,  # nop (delay)
]
HOOK = [0x08000000 | (STUB >> 2) & 0x03FFFFFF, 0x00000000]   # j stub ; nop

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

def wr(g, va, words):
    data = b''.join(struct.pack('<I', w) for w in words)
    assert g.packet(f'M{va:x},{len(data):x}:{data.hex()}') == 'OK'

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('cmd', choices=['install', 'dump'])
    ap.add_argument('--label')
    ap.add_argument('--checkpoint', help='checkpoint to save right before arming')
    args = ap.parse_args()
    g = Remote('127.0.0.1', PORT)
    try:
        stop_cpu(g)
        # sanity: PAD_update words are what we expect (orig or our hook)
        cur = g.read_memory(PAD_UPDATE, 8)
        cur0 = struct.unpack('<I', cur[:4])[0]
        if args.cmd == 'install':
            assert cur0 == ORIG0, f'PAD_update+0 is {cur0:#x}, not the expected original'
            if args.checkpoint:
                g.checkpoint(args.checkpoint)
                print(f'checkpoint {args.checkpoint} saved')
            wr(g, STUB, STUB_WORDS)
            wr(g, RING, [0, 0, 0xFFFFFFFF])      # framecnt, nchanges, lastval sentinel
            wr(g, PAD_UPDATE, HOOK)
            g.send_no_reply('c')
            print('recorder armed -- play now (no GDB traffic until dump)')
        else:
            hdr = g.read_memory(RING, 12)
            frames, nch, last = struct.unpack('<III', hdr)
            print(f'{frames} frames, {nch} input changes')
            assert nch <= CAP, 'ring overflow -- tape invalid'
            raw = g.read_memory(ENTRIES, nch * 8)
            wr(g, PAD_UPDATE, [ORIG0, ORIG1])    # unhook
            g.send_no_reply('c')
            changes = [struct.unpack_from('<II', raw, i*8) for i in range(nch)]
            tape = bytearray()
            val = 0x0041FFFF                      # neutral until first change
            ci = 0
            for f in range(frames):
                while ci < len(changes) and changes[ci][0] <= f:
                    val = changes[ci][1]
                    ci += 1
                tape += struct.pack('<I', val)
            out = RUNTIME / 'traces' / (args.label + '.pad.bin')
            out.parent.mkdir(parents=True, exist_ok=True)
            out.write_bytes(tape)
            print(f'{frames} frames -> {out}')
    finally:
        try:
            g.send_no_reply('c')
        except Exception:
            pass
        g.close()

if __name__ == '__main__':
    main()
