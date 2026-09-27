#!/usr/bin/env python3
"""NFS3 race roster / chase-music probe: cold boot, drive the menus as nfs3_track_probe.py does while forcing
COPS on (cfg[5] = 0x800F9F58), then in the race log, every N pad frames:
  roster  0x800F9FDC count, 0xA4-byte entries at 0x800F9FEC {+0 model id, +4 kind bits}; model name 0x800F9B8C[id]
  list    0x800F82D8 (count gp+1132): objects registered with kind & 0x18 (func_80074404)
  per car flags +1440, distance-to-player +132, and the PathFinder control level 0x8012562A / current node

Usage: python nfs3_roster_probe.py <log.json> [--race-frames 6000] [--every 60] [--racetype N]
"""
import os, sys, time, json, struct, argparse, subprocess
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402

COPS = 0x800F9F58
HOLD_CROSS = 0xFFFF & ~P.BTN['cross']


def u32(r, a):
    return struct.unpack('<I', P.rd(r, a, 4))[0]


def snapshot(r, gp):
    n = u32(r, 0x800F9FDC)
    roster = []
    for i in range(min(n, 12)):
        e = 0x800F9FEC + 0xA4 * i
        mid, kind = struct.unpack('<ii', P.rd(r, e, 8))
        name = P.rd(r, 0x800F9B8C + 8 * mid, 8).split(b'\0')[0].decode('latin1') if 0 <= mid < 64 else '?'
        roster.append(dict(i=i, model=mid, name=name, kind=kind))
    cnt = u32(r, gp + 1132)
    lst = []
    for k in range(min(cnt, 12)):
        car = u32(r, 0x800F82D8 + 4 * k)
        desc = u32(r, car + 632)
        lst.append(dict(car='%08x' % car, active=P.rd(r, car + 137, 1)[0], flags=u32(r, car + 1440),
                        dist=u32(r, car + 132) / 65536.0, roster=(desc - 0x800F9FEC) // 0xA4))
    return dict(roster=roster, list=lst, control=P.rd(r, 0x8012562A, 1)[0],
                node=struct.unpack('<h', P.rd(r, 0x80125628, 2))[0])


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--race-frames', type=int, default=6000)
    ap.add_argument('--every', type=int, default=60)
    ap.add_argument('--racetype', type=int, default=None, help='force cfg[0] RACETYPE (0x800F9F44)')
    a = ap.parse_args()
    si = subprocess.STARTUPINFO(); si.dwFlags |= subprocess.STARTF_USESHOWWINDOW; si.wShowWindow = 7
    proc = subprocess.Popen([P.EXE, '-batch', '-fastboot', P.CUE], cwd=os.path.dirname(P.EXE), startupinfo=si)
    r = None
    for _ in range(150):
        try:
            r = P.Remote('127.0.0.1', P.PORT); break
        except OSError:
            time.sleep(0.2)
    if r is None:
        proc.kill(); raise SystemExit('GDB did not come up')
    snaps = []
    try:
        for bp in (P.PAD_RET, P.CHUNK_DONE):
            r.packet(f'Z0,{bp:x},4')
        frame = 0; race_at = None
        while True:
            r.send_no_reply('c'); P.wait_stop(r, 180)
            pc = P.reg(r, P.REG['pc'])
            if pc == P.CHUNK_DONE:
                if race_at is None:
                    race_at = frame; P.log('race loaded at frame', frame)
                r.packet(f'z0,{P.CHUNK_DONE:x},4')
                continue
            frame += 1
            if race_at is None:
                P.wr(r, COPS, struct.pack('<i', 1))
                if a.racetype is not None:
                    P.wr(r, 0x800F9F44, struct.pack('<i', a.racetype))
                w = P.pattern(frame)
            else:
                w = HOLD_CROSS
                if (frame - race_at) % a.every == 0:
                    s = snapshot(r, P.reg(r, P.REG['gp'])); s['frame'] = frame - race_at
                    snaps.append(s); P.log(s['frame'], s['control'], s['node'], s['list'])
                if frame - race_at >= a.race_frames:
                    break
            P.wr(r, P.PAD_REC, bytes([0, 0x41, w & 0xFF, w >> 8]))
    finally:
        json.dump(snaps, open(a.out, 'w'), indent=1)
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
