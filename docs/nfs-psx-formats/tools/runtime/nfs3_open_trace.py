#!/usr/bin/env python3
"""Log every file NFS3 opens: cold boot with the menu pad pattern of nfs3_track_probe.py, breakpoints on the
game's file entry points (a0 = name string), through the front end into a race, then keep driving.

  func_800DB910  load whole file (via func_800DB8D0 / func_800DB8F0)
  func_800DADAC  open by name (via func_800DAF74)
  extra --bp addresses may be given (their a0 is logged as a string too)

Usage: python nfs3_open_trace.py <log.json> [--race-frames 2500] [--max-frames 12000] [--bp 0x800E323C]
"""
import os, sys, time, json, argparse, subprocess, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402

OPEN_BPS = [0x800DB910, 0x800DADAC]
HOLD_CROSS = 0xFFFF & ~P.BTN['cross']


def cstr(r, a):
    try:
        return P.rd(r, a, 64).split(b'\0')[0].decode('latin1')
    except Exception:
        return '?%08x' % a


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--race-frames', type=int, default=2500)
    ap.add_argument('--max-frames', type=int, default=12000)
    ap.add_argument('--bp', action='append', default=[])
    a = ap.parse_args()
    bps = OPEN_BPS + [int(x, 0) for x in a.bp]
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
    log = []; seen = collections.OrderedDict()
    try:
        for bp in [P.PAD_RET, P.CHUNK_DONE] + bps:
            r.packet(f'Z0,{bp:x},4')
        frame = 0; race_at = None
        while frame < a.max_frames:
            r.send_no_reply('c'); P.wait_stop(r, 180)
            pc = P.reg(r, P.REG['pc'])
            if pc == P.PAD_RET:
                frame += 1
                w = HOLD_CROSS if race_at is not None else P.pattern(frame)
                P.wr(r, P.PAD_REC, bytes([0, 0x41, w & 0xFF, w >> 8]))
                if race_at is not None and frame - race_at >= a.race_frames:
                    break
                continue
            if pc == P.CHUNK_DONE:
                if race_at is None:
                    race_at = frame; P.log('race loaded at frame', frame)
                r.packet(f'z0,{P.CHUNK_DONE:x},4')
                continue
            name = cstr(r, P.reg(r, 4)); ra = P.reg(r, P.REG['ra'])
            ent = dict(frame=frame, bp=f'{pc:08x}', ra=f'{ra:08x}', name=name, phase='race' if race_at else 'front')
            log.append(ent)
            key = name.lower()
            if key not in seen:
                seen[key] = ent; P.log(ent)
    finally:
        json.dump(dict(opens=log, unique=list(seen.values())), open(a.out, 'w'), indent=1)
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
