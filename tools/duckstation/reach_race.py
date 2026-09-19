"""reach_race.py [--name race_demo] [--timeout 900] -- drive NFS4 from boot into a RACE without any pad input.

The front end times out into the attract-mode demo race.  We only plant execution breakpoints (no data watchpoints, so
the emulator runs at full unlimited speed) on functions that run exclusively at race set-up / in a race, wait for the
first hit, let it settle for --settle further hits, then save a named full-state checkpoint that blob_trace.py can load.
Also reports the front-end milestone (first hit of a front-end-only function) so a menu checkpoint can be saved too.

Launch first:  powershell -File tools/duckstation/launch.ps1 -FastBoot"""
import argparse
import re
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
from gdb_remote import Remote, decode_registers  # noqa: E402

PORT = 2350
ap = argparse.ArgumentParser()
ap.add_argument('--name', default='race_demo')
ap.add_argument('--menu-name', default='front_menu')
ap.add_argument('--timeout', type=float, default=900)
ap.add_argument('--settle', type=int, default=3)
args = ap.parse_args()

syms = {}
for ln in open(ROOT / 'configs/symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func', ln)
    if m:
        syms.setdefault(m.group(1), int(m.group(2), 16))
RACE = ['AIHigh_StartUp__Fv', 'AIState_StartUp__Fv', 'Weather_InitSplats__Fv', 'AICop_StartUp__Fv',
        'Replay_InitReplay__Fv', 'Hud_CreateHudViews__Fv']
MENU = ['Fe3D_InitShowroom__Fv', 'Front_ConstructAll__Fv']
race = {syms[n]: n for n in RACE if n in syms}
menu = {syms[n]: n for n in MENU if n in syms}
print('race tripwires:', ', '.join(f'{n}@{a:#x}' for a, n in race.items()))
print('menu tripwires:', ', '.join(f'{n}@{a:#x}' for a, n in menu.items()))

g = Remote('127.0.0.1', PORT)
try:
    try:
        g.interrupt()
    except Exception:
        pass
    for a in list(race) + list(menu):
        assert g.packet('Z0,%x,4' % a) == 'OK', hex(a)
    t0 = time.time()
    deadline = t0 + args.timeout
    race_hits = 0
    menu_saved = False
    while time.time() < deadline:
        try:
            g.packet('c', timeout=max(1.0, deadline - time.time()))
        except Exception:
            break
        pc = int(decode_registers(g.packet('g'))['pc'], 16)
        dt = time.time() - t0
        if pc in menu:
            print(f'[{dt:6.1f}s] front end reached: {menu[pc]}')
            for a in menu:
                g.packet('z0,%x,4' % a)
            if not menu_saved:
                try:
                    g.checkpoint(args.menu_name)
                    print(f'          checkpoint "{args.menu_name}" saved')
                except Exception as e:
                    print('          menu checkpoint not saved:', e)
                menu_saved = True
            continue
        if pc in race:
            race_hits += 1
            print(f'[{dt:6.1f}s] race tripwire: {race[pc]}')
            g.packet('z0,%x,4' % pc)
            if race_hits >= args.settle or race_hits >= len(race):
                g.checkpoint(args.name)
                print(f'          checkpoint "{args.name}" saved; target left paused in the race set-up')
                break
    else:
        print('timeout: no race tripwire hit')
finally:
    g.close()
