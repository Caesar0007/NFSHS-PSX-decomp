#!/usr/bin/env python3
"""NFS1 (USA SLUS-00204) race setup: drive the front end with injected pad presses until the track loader
func_80037058 runs, hold accelerate (Cross) for --race-frames pad frames, save a DuckStation checkpoint and dump
the loaded RoadSection facts used by NFS1_TRACK_FILES.md.

Pad injection: the PsyQ pad driver copies each port's record into 0x800F7B3C (memcpy at 0x800107E0, called from
0x800AD684); a breakpoint on the return 0x800AD68C rewrites the button half-word before the game reads it.

Usage: python nfs1_race_setup.py <out.json> [--race-frames 900] [--checkpoint nfs1_race] [--track ZTR1]
"""
import os, sys, json, struct, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402
from nfs1_pad_probe import boot   # noqa: E402

PAD_BP = 0x800AD68C
PAD_REC = 0x800F7B3C
TRACK_LOAD = 0x80037058
ROAD_PTR = 0x800DC2C8          # RoadSection
HOLD_CROSS = 0xFFFF & ~P.BTN['cross']
DISC = r'C:\Temp\nfs1_disc'


def u32(r, a):
    return struct.unpack('<I', P.rd(r, a, 4))[0]


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--race-frames', type=int, default=900); ap.add_argument('--max-frames', type=int, default=30000)
    ap.add_argument('--checkpoint', default='nfs1_race')
    a = ap.parse_args()
    proc, r = boot()
    log = {}
    try:
        r.packet(f'Z0,{PAD_BP:x},4'); r.packet(f'Z0,{TRACK_LOAD:x},4')
        frame = 0; race_at = None
        while frame < a.max_frames:
            r.send_no_reply('c'); P.wait_stop(r, 300)
            pc = P.reg(r, P.REG['pc'])
            if pc == TRACK_LOAD:
                name = P.rd(r, P.reg(r, 4), 8).split(b'\0')[0].decode(errors='replace')
                race_at = frame; log['track_arg'] = name
                P.log('track load at frame', frame, repr(name)); r.packet(f'z0,{TRACK_LOAD:x},4')
                continue
            frame += 1
            w = P.pattern(frame) if race_at is None else HOLD_CROSS
            P.wr(r, PAD_REC + 2, bytes([w & 0xFF, w >> 8]))
            if race_at is not None and frame - race_at >= a.race_frames:
                road = u32(r, ROAD_PTR); rs = P.rd(r, road, 0x1621C)
                log['road'] = '%08x' % road
                n = struct.unpack_from('<h', rs, 6)[0]
                tri = open(os.path.join(DISC, 'Z%s.TRI' % log['track_arg'].upper()), 'rb').read()[:0x1621C]
                diff = [i for i in range(0x1621C) if rs[i] != tri[i]]
                log['n'] = n
                log['ram_vs_file_diffs'] = len(diff)
                log['diff_ranges'] = sorted({'%x' % (0x98C if 0x98C <= i < 0x15B0C else
                                                     0x15B0C if 0x15B0C <= i < 0x16214 else i) for i in diff})[:40]
                spd = [(i, tri[0x15B0C + 3 * i], rs[0x15B0C + 3 * i]) for i in range(n)]
                log['speed_byte0_changed_blocks'] = [i for i, f, m in spd if f != m][:5]
                log['speed_byte0_first_changed'] = min([i for i, f, m in spd if f != m], default=None)
                log['speed_scale_samples'] = [(f, m) for i, f, m in spd if f != m][:12]
                log['speed_bytes12_changed'] = sum(1 for i in range(n) for k in (1, 2)
                                                   if tri[0x15B0C + 3 * i + k] != rs[0x15B0C + 3 * i + k])
                log['lane_table_80111c90'] = [struct.unpack_from('<40h', P.rd(r, 0x80111C90 + 80 * k, 80))[:8]
                                              for k in range(4)]
                log['car_node'] = [u32(r, u32(r, 0x8010C720) + 0x48)]
                log['lgt_level_800dc644'] = u32(r, 0x800DC644)
                log['objs'] = '%08x' % u32(r, 0x800DC654); log['placements'] = '%08x' % u32(r, 0x800DC6AC)
                log['nodes'] = '%08x' % u32(r, 0x800DC560)
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
