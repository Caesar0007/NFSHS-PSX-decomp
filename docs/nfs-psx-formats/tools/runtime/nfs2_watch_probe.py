#!/usr/bin/env python3
"""NFS2 (PAL) read-watch: load a checkpoint made by nfs2_race_setup.py, hold accelerate through the pad driver
hook, set GDB read watchpoints (Z3, or access Z4) on the given address:length ranges and log every PC that reads
them (with ra and the watched data address when the stub reports it).

Usage: python nfs2_watch_probe.py <log.json> --addr 0x80190000:4 [--addr ...] [--frames 3000]
                                   [--checkpoint nfs2_race] [--kind 3]
"""
import os, re, sys, time, json, argparse, subprocess, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402
from nfs2_track_probe import CUE, PAD_BP, PAD_BUF_PTR   # noqa: E402

HOLD_CROSS = 0xFFFF & ~P.BTN['cross']


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--addr', action='append', required=True)
    ap.add_argument('--frames', type=int, default=3000); ap.add_argument('--kind', default='3')
    ap.add_argument('--checkpoint', default='nfs2_race'); ap.add_argument('--max-hits', type=int, default=600)
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
    hits = collections.Counter(); first = {}; replies = {}; addrs = collections.defaultdict(list)
    try:
        r.checkpoint(a.checkpoint, load=True); P.log('checkpoint loaded')
        r.packet(f'Z0,{PAD_BP:x},4')
        for spec in a.addr:
            ad, ln = spec.split(':')
            replies[spec] = r.packet(f'Z{a.kind},{int(ad, 0):x},{int(ln, 0):x}')
            P.log('Z%s' % a.kind, spec, '->', replies[spec])
        frame = 0; nh = 0
        while frame < a.frames and nh < a.max_hits:
            r.send_no_reply('c'); stop = P.wait_stop(r, 180)
            pc = P.reg(r, P.REG['pc'])
            if pc == PAD_BP:
                frame += 1
                buf = struct_u32(r, PAD_BUF_PTR)
                if buf:
                    P.wr(r, buf, bytes([0, 0x41, HOLD_CROSS & 0xFF, HOLD_CROSS >> 8]))
                if frame % 500 == 0:
                    P.log(f'frame {frame}, hits {nh}')
                continue
            ra = P.reg(r, P.REG['ra'])
            m = re.search(r'(?:r|a)?watch:([0-9a-fA-F]+)', str(stop))
            da = int(m.group(1), 16) if m else None
            key = f'{pc:08x}'
            hits[key] += 1; nh += 1
            if da is not None:
                addrs[key].append(da)
            first.setdefault(key, dict(ra=f'{ra:08x}', stop=str(stop)[:80], frame=frame))
    finally:
        json.dump(dict(replies=replies, hits=hits, first=first, addrs={k: ['%08x' % x for x in v] for k, v in addrs.items()}), open(a.out, 'w'), indent=1)
        P.log('hits', dict(hits))
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


def struct_u32(r, ad):
    import struct
    return struct.unpack('<I', P.rd(r, ad, 4))[0]


if __name__ == '__main__':
    main()
