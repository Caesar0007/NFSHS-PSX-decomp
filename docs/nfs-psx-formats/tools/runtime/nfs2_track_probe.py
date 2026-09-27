#!/usr/bin/env python3
"""NFS2 (PAL SLES-00658) runtime check: drive the menus into a race and capture loaded track chunks.

Pad: bp at 0x800A0058 inside the pad-driver VSync callback _padDr (func_800A0018, after both ports are polled);
     each stop writes a digital-pad record {0x00, 0x41, lo, hi} (active-low buttons) into the port-0 result
     buffer *(u32*)0x800D5F60.
Race: bp on LoadChunkFromBuffer (func_8004BB3C); at each hit the chunk slot records are read after the
     function returns (bp on its return address) and the slot's pointers + the chunk bytes are logged.

Usage: python nfs2_track_probe.py <out.json> [--max-frames 20000] [--chunks 12]
"""
import os, sys, time, json, struct, argparse, subprocess
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402  (shared GDB helpers)

CUE = r'C:\Temp\nfs2psx-decomp\cdimage\Need for Speed II (Europe) (En,Fr,De,Es,It,Sv).cue'
PAD_BP = 0x800A0058
PAD_BUF_PTR = 0x800D5F60
BINDER = 0x8004BB3C


def u32(r, a):
    return struct.unpack('<I', P.rd(r, a, 4))[0]


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--max-frames', type=int, default=20000)
    ap.add_argument('--chunks', type=int, default=12)
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
    log = dict(binds=[])
    try:
        r.packet(f'Z0,{PAD_BP:x},4'); r.packet(f'Z0,{BINDER:x},4')
        frame = 0; ret_bp = None; pending = None
        while frame < a.max_frames and len(log['binds']) < a.chunks:
            r.send_no_reply('c'); P.wait_stop(r, 300)
            pc = P.reg(r, P.REG['pc'])
            if pc == PAD_BP:
                frame += 1
                buf = u32(r, PAD_BUF_PTR)
                if buf:
                    w = P.pattern(frame) if not log['binds'] else 0xFFFF & ~P.BTN['cross']
                    P.wr(r, buf, bytes([0, 0x41, w & 0xFF, w >> 8]))
                continue
            if pc == BINDER:
                ra = P.reg(r, P.REG['ra'])
                if ret_bp is None:
                    ret_bp = ra; r.packet(f'Z0,{ret_bp:x},4')
                    P.log('binder first hit at frame', frame, 'track', P.rd(r, 0x800F6E44, 4).hex())
                continue
            if pc == ret_bp:
                gp = P.reg(r, P.REG['gp'])
                base = u32(r, gp + 4824)
                log['gp'] = '%08x' % gp; log['slots_base'] = '%08x' % base
                log['track'] = P.rd(r, 0x800F6E44, 4).hex()
                log['binds'].append(dict(frame=frame))
                if len(log['binds']) >= a.chunks:
                    log['region'] = P.rd(r, base, 0x1800).hex()
                P.log('bind', len(log['binds']))
                continue
    finally:
        json.dump(log, open(a.out, 'w'), indent=1)
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
