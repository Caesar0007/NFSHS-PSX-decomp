#!/usr/bin/env python3
"""Find which code reads given memory fields at runtime (NFS3): load checkpoint `nfs3_after_chunks`,
hold accelerate via the pad hook, and set GDB read/access watchpoints (Z3/Z4) on the requested
addresses. Every hit logs the PC (and ra) that touched the watched word.

Usage: python nfs3_watch_probe.py <log.json> --addr 0x80026578:2 [--addr ...] [--frames 3000] [--kind 3|4]
"""
import os, sys, time, json, argparse, subprocess, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402

HOLD_CROSS = 0xFFFF & ~P.BTN['cross']


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--addr', action='append', required=True)
    ap.add_argument('--frames', type=int, default=3000); ap.add_argument('--kind', default='3')
    ap.add_argument('--max-hits', type=int, default=400)
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
    hits = collections.Counter(); first = {}
    try:
        r.checkpoint('nfs3_after_chunks', load=True)
        P.log('checkpoint loaded')
        P.log('Z0 pad', r.packet(f'Z0,{P.PAD_RET:x},4'))
        for spec in a.addr:
            ad, ln = spec.split(':')
            P.log('Z%s' % a.kind, ad, ln, '->', r.packet(f'Z{a.kind},{int(ad, 0):x},{int(ln)}'))
        frame = 0; nh = 0
        while frame < a.frames and nh < a.max_hits:
            r.send_no_reply('c'); stop = P.wait_stop(r, 180)
            pc = P.reg(r, P.REG['pc'])
            if pc == P.PAD_RET:
                frame += 1
                P.wr(r, P.PAD_REC, bytes([0, 0x41, HOLD_CROSS & 0xFF, HOLD_CROSS >> 8]))
                if frame % 500 == 0:
                    P.log(f'frame {frame}, hits {nh}')
                continue
            ra = P.reg(r, P.REG['ra'])
            key = f'{pc:08x}'
            hits[key] += 1; nh += 1
            first.setdefault(key, dict(ra=f'{ra:08x}', stop=stop[:60], frame=frame))
    finally:
        json.dump(dict(hits=hits, first=first), open(a.out, 'w'), indent=1)
        P.log('hits', dict(hits))
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
