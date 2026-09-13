#!/usr/bin/env python3
"""shram_record.py -- zero-interference input recorder via shared memory.

Saves a start checkpoint (one brief stop), then polls the raw pad word and
the game's 60 Hz frame counter through the shared-RAM mapping while the game
runs FREE -- no CPU stops, no writes to game RAM.  Builds a video-frame-
indexed tape (<label>.pad.bin, 4 bytes/frame) plus a sidecar
(<label>.pad.json: counter0, counter_addr) so run_frames can replay it keyed
to the same clock.  Incremental writes make it kill-safe.

Run in the background and stop it (or Ctrl+C) when the human is done playing.

Usage:
  py -3.14 runtime/tools/shram_record.py --label fullgame3
"""
import argparse, json, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote
from shared_ram import SharedRAM

RUNTIME = Path(__file__).resolve().parents[1]
PORT = 2350
PAD0 = 0x8013E8F0
FRAMECNT = 0x80137D10          # +60/sec, verified by find_frame_counter
NEUTRAL = 0x0041FFFF

def hardstop(g):
    for _ in range(6):
        try:
            r = g.packet('?', timeout=2)
            if r.startswith(('S', 'T')):
                g.stopped = True
                return
        except (TimeoutError, OSError):
            pass
        try:
            g.send_no_reply('c'); time.sleep(0.2)
            r = g.interrupt()
            if r.startswith(('S', 'T')):
                g.stopped = True
                return
        except (TimeoutError, OSError):
            pass
    raise RuntimeError('cannot stop CPU')

def build_tape(changes, c0, cN):
    """changes: sorted [(counter, padword)]; -> bytes, 4/frame over [c0,cN]."""
    import struct
    n = max(0, cN - c0 + 1)
    tape = bytearray(n * 4)
    ci = 0
    val = NEUTRAL
    for f in range(n):
        c = c0 + f
        while ci < len(changes) and changes[ci][0] <= c:
            val = changes[ci][1]
            ci += 1
        struct.pack_into('<I', tape, f * 4, val)
    return bytes(tape)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--label', required=True)
    ap.add_argument('--poll-hz', type=int, default=400)
    args = ap.parse_args()
    g = Remote('127.0.0.1', PORT)
    binp = RUNTIME / 'traces' / (args.label + '.pad.bin')
    jsonp = RUNTIME / 'traces' / (args.label + '.pad.json')
    binp.parent.mkdir(parents=True, exist_ok=True)
    try:
        hardstop(g)
        g.checkpoint(args.label + '-start')
        g.send_no_reply('c')              # resume; no more stops after this
        g.close()                         # GDB link not needed while polling
        sr = SharedRAM('127.0.0.1', PORT)
        import struct
        c0 = struct.unpack('<I', sr.read(FRAMECNT, 4))[0]
        print(f'checkpoint {args.label}-start saved; frame0={c0}. '
              f'RECORDING via shared memory -- play now (fully smooth). '
              f'Stop this task when done.', flush=True)
        changes = []
        last = None
        cN = c0
        period = 1.0 / args.poll_hz
        next_flush = time.time() + 1.0
        while True:
            c = struct.unpack('<I', sr.read(FRAMECNT, 4))[0]
            p = struct.unpack('<I', sr.read(PAD0, 4))[0]
            if c >= c0:
                cN = max(cN, c)
                if p != last:
                    changes.append((c, p))
                    last = p
            if time.time() >= next_flush:
                binp.write_bytes(build_tape(changes, c0, cN))
                jsonp.write_text(json.dumps(
                    {'counter0': c0, 'counter_addr': FRAMECNT,
                     'frames': cN - c0 + 1, 'changes': len(changes)}))
                print(f'  frame {cN - c0}  ({len(changes)} changes)', flush=True)
                next_flush = time.time() + 1.0
            time.sleep(period)
    except KeyboardInterrupt:
        pass
    finally:
        try:
            binp.write_bytes(build_tape(changes, c0, cN))
            jsonp.write_text(json.dumps(
                {'counter0': c0, 'counter_addr': FRAMECNT,
                 'frames': cN - c0 + 1, 'changes': len(changes)}))
            print(f'{cN - c0 + 1} frames -> {binp}')
            sr.close()
        except Exception:
            pass

if __name__ == '__main__':
    main()
