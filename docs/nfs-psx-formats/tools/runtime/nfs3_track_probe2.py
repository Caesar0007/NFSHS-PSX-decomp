#!/usr/bin/env python3
"""Stage 2 of the NFS3 runtime check: load checkpoint `nfs3_after_chunks` (saved by nfs3_track_probe.py),
dump the persistent COL data the game keeps (loaded COL buffer, material list, slices), then hold
Cross (accelerate) and capture further streamed chunks exactly like stage 1.

Usage: python nfs3_track_probe2.py <outdir> --colbuf 0x800247fc --colsize 42064 --slices 0x80026560
       --nslices 959 --matlist 0x80022d6c --nmat 403 [--chunks 40] [--max-frames 8000]
"""
import os, sys, time, json, struct, subprocess, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402

HOLD_CROSS = 0xFFFF & ~P.BTN['cross']


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    for k in ('colbuf', 'colsize', 'slices', 'nslices', 'matlist', 'nmat'):
        ap.add_argument('--' + k, type=lambda x: int(x, 0), required=True)
    ap.add_argument('--chunks', type=int, default=40); ap.add_argument('--max-frames', type=int, default=8000)
    a = ap.parse_args(); os.makedirs(a.out, exist_ok=True)
    si = subprocess.STARTUPINFO(); si.dwFlags |= subprocess.STARTF_USESHOWWINDOW; si.wShowWindow = 7
    proc = subprocess.Popen([P.EXE, '-batch', '-fastboot', P.CUE], cwd=os.path.dirname(P.EXE), startupinfo=si)
    P.log('launched pid', proc.pid)
    r = None
    for _ in range(150):
        try:
            r = P.Remote('127.0.0.1', P.PORT); break
        except OSError:
            time.sleep(0.2)
    if r is None:
        proc.kill(); raise SystemExit('GDB did not come up')
    meta = dict(chunks=[])
    try:
        r.checkpoint('nfs3_after_chunks', load=True); P.log('checkpoint loaded')
        open(os.path.join(a.out, 'col_region.bin'), 'wb').write(P.rd(r, a.colbuf, a.colsize))
        open(os.path.join(a.out, 'slices.bin'), 'wb').write(P.rd(r, a.slices, 36 * a.nslices))
        open(os.path.join(a.out, 'matlist.bin'), 'wb').write(P.rd(r, a.matlist, 8 * a.nmat))
        P.log('COL region / slices / material list dumped')
        for bp in (P.PAD_RET, P.CHUNK_DONE):
            r.packet(f'Z0,{bp:x},4')
        frame = 0
        while True:
            r.send_no_reply('c'); P.wait_stop(r, 180)
            pc = P.reg(r, P.REG['pc'])
            if pc == P.PAD_RET:
                frame += 1
                P.wr(r, P.PAD_REC, bytes([0, 0x41, HOLD_CROSS & 0xFF, HOLD_CROSS >> 8]))
                if frame % 500 == 0:
                    P.log(f'frame {frame}, chunks {len(meta["chunks"])}')
                if frame >= a.max_frames:
                    P.log('max frames reached'); break
                continue
            if pc == P.CHUNK_DONE:
                s0, s1, s2 = (P.reg(r, P.REG[k]) for k in ('s0', 's1', 's2'))
                size = P.u32(r, s2 + 4)
                tag = f'chunk{s1:03d}'
                open(os.path.join(a.out, tag + '_dat.bin'), 'wb').write(P.rd(r, s0, 0x58))
                open(os.path.join(a.out, tag + '_loaded.bin'), 'wb').write(P.rd(r, s0 + 0x58, size))
                open(os.path.join(a.out, tag + '_src.bin'), 'wb').write(P.rd(r, s2, size))
                meta['chunks'].append(dict(index=s1, chunkDat=hex(s0), src=hex(s2), size=size, frame=frame))
                P.log(f'chunk {s1} captured (frame {frame})')
                if len(meta['chunks']) >= a.chunks:
                    break
    finally:
        # stage-2 dumps reuse stage-1 header/table files for the comparison script
        json.dump(meta, open(os.path.join(a.out, 'meta.json'), 'w'), indent=1)
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
