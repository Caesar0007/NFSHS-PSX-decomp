"""press_to_race.py [--load front_menu] [--name race_start] [--timeout 600]
Drive NFS4 from the front end into a race by injecting pad presses through the debugger.

The EA pad driver's PAD_update refreshes gPadinfo (0x8013E89C) once per frame for the front end and the game alike
(Device_ReadPad is NOT used by the front end).  We break at its return (0x800E4310) and overwrite port 0's record: nopad = 0, ID = 0x41 (digital pad), state = active-low button
word.  Presses are pulsed (held for --hold polls, released for --gap polls) and alternate CROSS and START so both
"press start" screens and menu confirmations advance.  Race-only functions are tripwires; on the first hits a named
full-state checkpoint is saved for blob_trace.py --load.

Launch first:  powershell -File tools/duckstation/launch.ps1 -FastBoot   (then reach_race.py once for front_menu)"""
import argparse
import re
import struct
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
from gdb_remote import Remote, decode_registers  # noqa: E402

PORT = 2350
GPADINFO = 0x8013E89C
READPAD = 0x800E4310   # `jr ra` of the EA pad driver's PAD_update: gPadinfo has just been refreshed (front end AND game)
CROSS, START = 0x4000, 0x0008
ap = argparse.ArgumentParser()
ap.add_argument('--load', default=None)
ap.add_argument('--name', default='race_start')
ap.add_argument('--timeout', type=float, default=600)
ap.add_argument('--hold', type=int, default=40)
ap.add_argument('--gap', type=int, default=160)
ap.add_argument('--settle', type=int, default=4)
args = ap.parse_args()

syms = {}
for ln in open(ROOT / 'configs/symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func', ln)
    if m:
        syms.setdefault(m.group(1), int(m.group(2), 16))
RACE = ['AIHigh_StartUp__Fv', 'AIState_StartUp__Fv', 'Weather_InitSplats__Fv', 'AICop_StartUp__Fv',
        'Replay_InitReplay__Fv', 'Hud_CreateHudViews__Fv']
race = {syms[n]: n for n in RACE if n in syms}

g = Remote('127.0.0.1', PORT)


def write(addr, data):
    r = g.packet('M%x,%x:%s' % (addr, len(data), data.hex()))
    assert r == 'OK', r


try:
    try:
        g.interrupt()
    except Exception:
        pass
    if args.load:
        g.checkpoint(args.load, load=True)
        print('checkpoint loaded:', args.load)
    assert g.packet('Z0,%x,4' % READPAD) == 'OK'
    for a in race:
        assert g.packet('Z0,%x,4' % a) == 'OK'
    polls = 0
    pulses = 0
    race_hits = 0
    rec = None
    t0 = time.time()
    deadline = t0 + args.timeout
    while time.time() < deadline:
        try:
            g.packet('c', timeout=max(1.0, deadline - time.time()))
        except Exception:
            print('no stop before the timeout')
            break
        pc = int(decode_registers(g.packet('g'))['pc'], 16)
        if pc == READPAD:
            if rec is None:
                live = g.read_memory(GPADINFO, 24)
                print('gPadinfo live:', live.hex())
                # port 0 record = {nopad, ID, u16 state}: find it as the first byte pair followed by a word
                rec = GPADINFO
                for o in range(0, 12):
                    if live[o + 1] in (0x41, 0x73, 0x23, 0x53) or live[o] == 0xFF:
                        rec = GPADINFO + o
                        break
                print('port-0 record at %#x' % rec)
            phase = polls % (args.hold + args.gap)
            if phase == 0:
                pulses += 1
            pressed = phase < args.hold
            mask = CROSS if pulses % 2 else START
            state = 0xFFFF & ~mask if pressed else 0xFFFF
            write(rec, bytes([0x00, 0x41]) + struct.pack('<H', state))
            polls += 1
            continue
        if pc in race:
            race_hits += 1
            print(f'[{time.time() - t0:6.1f}s] race tripwire: {race[pc]}  (after {pulses} pulses, {polls} polls)')
            g.packet('z0,%x,4' % pc)
            if race_hits >= args.settle:
                g.packet('z0,%x,4' % READPAD)
                g.checkpoint(args.name)
                print(f'          checkpoint "{args.name}" saved; target paused at race set-up')
                break
    else:
        print(f'timeout after {pulses} pulses, {polls} polls')
finally:
    g.close()
