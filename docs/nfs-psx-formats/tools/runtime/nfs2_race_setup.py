#!/usr/bin/env python3
"""NFS2 (PAL) race setup: drive the menus (pad injection as nfs2_track_probe.py) while forcing front-end
config words every frame (RACETYPE 0x800F6E20, NUMCARS 0x800F6E74, TRACK 0x800F6E44), hold accelerate once
the track loads, and save a DuckStation checkpoint `--checkpoint` `--race-frames` pad frames after the first
chunk bind. Logs the loaded chunk indices of the 8 slots and the car table 0x800F75E0.

Usage: python nfs2_race_setup.py <out.json> [--racetype 1] [--numcars 8] [--track 5]
                                  [--race-frames 600] [--checkpoint nfs2_race]
"""
import os, sys, time, json, struct, argparse, subprocess
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402
from nfs2_track_probe import CUE, PAD_BP, PAD_BUF_PTR, BINDER   # noqa: E402

CFG = dict(racetype=0x800F6E20, numcars=0x800F6E74, track=0x800F6E44)
HOLD_CROSS = 0xFFFF & ~P.BTN['cross']


def u32(r, a):
    return struct.unpack('<I', P.rd(r, a, 4))[0]


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--racetype', type=int); ap.add_argument('--numcars', type=int); ap.add_argument('--track', type=int)
    ap.add_argument('--race-frames', type=int, default=600); ap.add_argument('--max-frames', type=int, default=20000)
    ap.add_argument('--checkpoint', default='nfs2_race')
    a = ap.parse_args()
    si = subprocess.STARTUPINFO(); si.dwFlags |= subprocess.STARTF_USESHOWWINDOW; si.wShowWindow = 7
    proc = subprocess.Popen([P.EXE, '-batch', '-fastboot', CUE], cwd=os.path.dirname(P.EXE), startupinfo=si)
    r = None
    for _ in range(150):
        try:
            r = P.Remote('127.0.0.1', P.PORT); break
        except OSError:
            time.sleep(0.2)
    if r is None:
        proc.kill(); raise SystemExit('GDB did not come up')
    log = {}
    try:
        r.packet(f'Z0,{PAD_BP:x},4'); r.packet(f'Z0,{BINDER:x},4')
        frame = 0; race_at = None
        while frame < a.max_frames:
            r.send_no_reply('c'); P.wait_stop(r, 300)
            pc = P.reg(r, P.REG['pc'])
            if pc == BINDER:
                if race_at is None:
                    race_at = frame; P.log('first bind at frame', frame)
                    r.packet(f'z0,{BINDER:x},4')
                continue
            frame += 1
            if race_at is None:
                for k, ad in CFG.items():
                    v = getattr(a, k)
                    if v is not None:
                        P.wr(r, ad, struct.pack('<i', v))
                w = P.pattern(frame)
            else:
                w = HOLD_CROSS
            buf = u32(r, PAD_BUF_PTR)
            if buf:
                P.wr(r, buf, bytes([0, 0x41, w & 0xFF, w >> 8]))
            if race_at is not None and frame - race_at >= a.race_frames:
                gp = 0x800D50A0; base = u32(r, gp + 4824)   # fixed game gp (stops happen in the VSync IRQ, where $gp is the BIOS one)
                log['cfg'] = {k: struct.unpack('<i', P.rd(r, ad, 4))[0] for k, ad in CFG.items()}
                log['slots'] = []
                for s in range(24):
                    ch = u32(r, base + 0xBC * s + 1012)
                    log['slots'].append(dict(chunk_ptr='%08x' % ch,
                                             index=struct.unpack('<h', P.rd(r, ch + 0xC, 2))[0] if ch else None,
                                             w1020='%08x' % u32(r, base + 0xBC * s + 1020)))
                log['cars'] = ['%08x' % u32(r, 0x800F75E0 + 4 * i) for i in range(8)]
                log['speeds_ptr'] = '%08x' % u32(r, gp + 8); log['line_ptr'] = '%08x' % u32(r, gp + 12)
                log['slots_base'] = '%08x' % base; log['gp'] = '%08x' % gp
                P.log('saving checkpoint', a.checkpoint, r.checkpoint(a.checkpoint))
                break
    finally:
        json.dump(log, open(a.out, 'w'), indent=1)
        P.log(log)
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
