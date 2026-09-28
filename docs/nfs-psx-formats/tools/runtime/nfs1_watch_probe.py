#!/usr/bin/env python3
"""NFS1 read-watch: load a checkpoint made by nfs1_race_setup.py, tap --shift (gear up; the car starts in neutral), hold the
given buttons (Square = accelerate) through the pad hook,
set GDB read watchpoints (Z3) on address:length ranges and log every PC that reads them with the data address.
Ranges may be given relative to the loaded tables: road+OFF (RoadSection), node+N (road node N), place+N
(placement N), or absolute addresses.

Usage: python nfs1_watch_probe.py <log.json> --addr node+40:0x100 [--addr ...] [--frames 3000]
                                   [--buttons square] [--shift R1] [--pattern-frames 0] [--checkpoint nfs1_race]
"""
import os, re, sys, json, struct, argparse, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402
from nfs1_pad_probe import boot   # noqa: E402
from nfs1_race_setup import PAD_BP, PAD_REC   # noqa: E402

BTN = dict(cross=0x4000, square=0x8000, circle=0x2000, triangle=0x1000, up=0x0010, start=0x0008, left=0x0080, right=0x0020,
           R1=0x0800, L1=0x0400, R2=0x0200, L2=0x0100)
BASES = dict(road=(0x800DC2C8, 1), node=(0x800DC560, 36), place=(0x800DC6AC, 16), objs=(0x800DC654, 16))


def u32(r, a):
    return struct.unpack('<I', P.rd(r, a, 4))[0]


def resolve(r, spec):
    ad, ln = spec.split(':')
    if '+' in ad:
        k, n = ad.split('+'); ptr, sz = BASES[k]
        return u32(r, ptr) + int(n, 0) * sz, int(ln, 0)
    return int(ad, 0), int(ln, 0)


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--addr', action='append', required=True)
    ap.add_argument('--frames', type=int, default=3000); ap.add_argument('--max-hits', type=int, default=2000)
    ap.add_argument('--buttons', default='square'); ap.add_argument('--shift', default='R1'); ap.add_argument('--pattern-frames', type=int, default=0); ap.add_argument('--checkpoint', default='nfs1_race')
    a = ap.parse_args()
    held = 0
    for b in a.buttons.split(','):
        held |= BTN[b]
    w = 0xFFFF & ~held
    proc, r = boot()
    hits = collections.Counter(); addrs = collections.defaultdict(collections.Counter); first = {}; ranges = {}
    track = []
    try:
        r.checkpoint(a.checkpoint, load=True); P.log('checkpoint loaded')
        r.packet(f'Z0,{PAD_BP:x},4')
        for spec in a.addr:
            ad, ln = resolve(r, spec); ranges[spec] = ['%08x' % ad, ln, r.packet(f'Z3,{ad:x},{ln:x}')]
            P.log('Z3', spec, ranges[spec])
        frame = 0; nh = 0
        while frame < a.frames and nh < a.max_hits:
            r.send_no_reply('c'); stop = P.wait_stop(r, 180)
            pc = P.reg(r, P.REG['pc'])
            if pc == PAD_BP:
                frame += 1; x = P.pattern(frame) if frame <= a.pattern_frames else w
                k = frame - a.pattern_frames
                if 0 < k <= 600 and k % 40 < 4:
                    x &= ~BTN[a.shift]      # tap gear-up every 40 frames (the car starts in neutral)
                P.wr(r, PAD_REC + 2, bytes([x & 0xFF, x >> 8]))
                if frame % 250 == 0:
                    node = u32(r, u32(r, 0x8010C720) + 0x48); track.append((frame, node))
                    P.log(f'frame {frame} car node {node} hits {nh}')
                continue
            m = re.search(r'watch:([0-9a-fA-F]+)', str(stop))
            key = f'{pc:08x}'; hits[key] += 1; nh += 1
            if m:
                addrs[key]['%08x' % int(m.group(1), 16)] += 1
            first.setdefault(key, dict(ra=f'{P.reg(r, P.REG["ra"]):08x}', frame=frame))
    finally:
        json.dump(dict(ranges=ranges, hits=hits, first=first, addrs=addrs, car_track=track),
                  open(a.out, 'w'), indent=1)
        P.log('hits', dict(hits))
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
