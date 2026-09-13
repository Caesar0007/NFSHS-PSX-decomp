#!/usr/bin/env python3
"""probe_boot.py -- prove the emulated RAM holds OUR base build (nfs4-f.exe).

Connects to the project DuckStation (port 2349), interrupts the CPU, and
compares sample windows of RAM against rom/nfs4-f.exe:

  * game/lib/data windows (>= 0x80054D90) must match as soon as NFS4.EXE is
    loaded -- they are identical between the disc EXE and our base image.
  * the FRONTEND window (0x80010000..0x80054D90) matches only after the game
    has loaded FRONT.BIN (proven byte-identical to the base image's window).

Usage:
  py -3.14 runtime/tools/probe_boot.py            # one-shot identity check
  py -3.14 runtime/tools/probe_boot.py --wait-frontend [--timeout 120]
"""
import argparse, json, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gdb_remote import Remote, decode_registers

ROOT = Path(__file__).resolve().parents[2]           # nfs4-decomp
RUNTIME = Path(__file__).resolve().parents[1]
BASE = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()[0x800:]
LOAD = 0x80010000
PORT = 2350

GAME_WINDOWS = [0x80054D90, 0x80060000, 0x80090000, 0x800E402C, 0x80120000]
FRONT_WINDOWS = [0x80010078, 0x80020000, 0x80034C80]   # const table + 2 code fns
WIN = 64

def window_ok(g, va):
    ours = BASE[va - LOAD: va - LOAD + WIN]
    live = g.read_memory(va, WIN)
    return live == ours, live

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--wait-frontend', action='store_true')
    ap.add_argument('--timeout', type=int, default=120)
    args = ap.parse_args()
    g = Remote('127.0.0.1', PORT)
    report = {'game': {}, 'frontend': {}}

    def stop_cpu():
        try:
            r = g.packet('?', timeout=2)
            if r.startswith(('S', 'T')):
                g.stopped = True
                return r
        except (TimeoutError, OSError):
            pass
        return g.interrupt()

    try:
        deadline = time.time() + args.timeout
        while True:                     # boot phase: wait for NFS4.EXE in RAM
            stop_cpu()
            for va in GAME_WINDOWS:
                ok, _ = window_ok(g, va)
                report['game'][f'0x{va:08X}'] = ok
            if all(report['game'].values()) or time.time() > deadline:
                break
            g.send_no_reply('c')
            time.sleep(3)
        regs = decode_registers(g.packet('g'))
        report['pc'] = regs.get('pc')
        for k, v in report['game'].items():
            print(f'  game   {k}: {"MATCH" if v else "DIFFERS"}')
        if not all(report['game'].values()):
            raise SystemExit('IDENTITY FAIL: game-code windows differ from rom/nfs4-f.exe')
        while True:
            fr = {}
            for va in FRONT_WINDOWS:
                ok, _ = window_ok(g, va)
                fr[f'0x{va:08X}'] = ok
            report['frontend'] = fr
            if all(fr.values()) or not args.wait_frontend or time.time() > deadline:
                break
            g.send_no_reply('c')
            time.sleep(2)
            stop_cpu()
        for k, v in report['frontend'].items():
            print(f'  front  {k}: {"MATCH" if v else "not loaded yet"}')
        verdict = 'BASE-IDENTITY VERIFIED' + (
            ' (frontend loaded)' if all(report['frontend'].values()) else ' (frontend overlay not resident)')
        report['verdict'] = verdict
        print(verdict)
        (RUNTIME / 'status' / 'probe-boot.json').write_text(json.dumps(report, indent=2))
    finally:
        try:
            g.send_no_reply('c')     # leave the emulator running
        except Exception:
            pass
        g.close()

if __name__ == '__main__':
    main()
