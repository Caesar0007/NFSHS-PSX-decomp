#!/usr/bin/env python3
"""Boot NFS3 with the front-end pad pattern of nfs3_track_probe.py and log every write (GDB Z2 watchpoint)
to the given addresses until a race loads (first chunk bound at 0x8007A728) or --max-frames.
Each hit records pc, ra and the watched word's value after the write.

Usage: python nfs3_boot_watch.py <log.json> --addr 0x800F9F80:4 [--addr ...] [--max-frames 9000]
"""
import os, sys, time, json, argparse, subprocess
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--addr', action='append', required=True)
    ap.add_argument('--max-frames', type=int, default=9000)
    a = ap.parse_args()
    watches = [(int(x.split(':')[0], 0), int(x.split(':')[1])) for x in a.addr]
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
    log = []
    try:
        r.packet(f'Z0,{P.PAD_RET:x},4'); r.packet(f'Z0,{P.CHUNK_DONE:x},4')
        for ad, ln in watches:
            P.log('Z2', hex(ad), ln, r.packet(f'Z2,{ad:x},{ln}'))
        frame = 0
        while frame < a.max_frames:
            r.send_no_reply('c'); stop = P.wait_stop(r, 180)
            pc = P.reg(r, P.REG['pc'])
            if pc == P.PAD_RET:
                frame += 1
                w = P.pattern(frame)
                P.wr(r, P.PAD_REC, bytes([0, 0x41, w & 0xFF, w >> 8]))
                continue
            if pc == P.CHUNK_DONE:
                P.log('race loaded at frame', frame); break
            ra = P.reg(r, P.REG['ra'])
            vals = {hex(ad): P.rd(r, ad, 4).hex() for ad, ln in watches}
            ent = dict(frame=frame, pc=f'{pc:08x}', ra=f'{ra:08x}', stop=stop[:48], values=vals)
            log.append(ent); P.log(ent)
    finally:
        json.dump(log, open(a.out, 'w'), indent=1)
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
