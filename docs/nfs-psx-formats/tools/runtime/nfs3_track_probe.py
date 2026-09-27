#!/usr/bin/env python3
"""Boot retail NFS3 (SLUS-006.20) in the modified DuckStation (GDB + full-state API), drive the front end
with injected pad presses, and capture streamed track chunks right after the game has copied, bound and
relocated them. Also dumps the TRK header/tables and the loaded COL buffer, then saves a checkpoint.

Runtime  : isolated copy at C:\\Temp\\nfs4-runtime\\duckstation (GDB port 2350), shared with the NFS4 probes.
Disc     : C:\\Temp\\nfs3_iso\\NFS3.cue (local copy of the share's NFS3.bin = USA retail).
Addresses: NFS3 raw oracle (C:\\Temp\\nfs3-clean\\nfs3-raw-L.txt).

Pad injection: func_800DE180 copies the TAP record {status, type, u16 buttons} to 0x8012E2F0 every frame;
a breakpoint on its `jr ra` (0x800DE38C) rewrites that record before any reader sees it.

Chunk capture: stop at 0x8007A728 (after memmove + func_8007A198 binder + func_80079F4C relocation);
s0 = Chunk_tChunkDat, s1 = chunk index, s2 = the chunk's source inside the meta-chunk stream buffer.

Usage: python nfs3_track_probe.py <outdir> [--chunks N] [--max-frames N]
"""
import os, sys, time, json, struct, subprocess, argparse

RT = r'C:\Temp\nfs4-runtime'
EXE = os.path.join(RT, 'duckstation', 'duckstation-qt-x64-ReleaseLTCG.exe')
CUE = r'C:\Temp\nfs3_iso\NFS3.cue'
PORT = 2350
os.environ['FF_GDB_RAM_BACKEND'] = 'rsp'
sys.path.insert(0, RT)
from gdb_remote import Remote   # noqa: E402

PAD_RET = 0x800DE38C
CHUNK_DONE = 0x8007A728
PAD_REC = 0x8012E2F0
TRK_HDR = 0x80108FA4
TBL = dict(StmChunkF=0x80126010, StmCenter=0x80126014, StmMetaI=0x80126018)
BTN = dict(start=0x0008, cross=0x4000)
REG = dict(s0=16, s1=17, s2=18, gp=28, ra=31, pc=37)


def log(*a):
    print(time.strftime('%H:%M:%S'), *a, flush=True)


def wait_stop(r, timeout):
    r.s.settimeout(timeout)
    try:
        while True:
            p = r._receive_packet()
            if p[:1] in ('T', 'S'):
                return p
    finally:
        r.s.settimeout(3)


def reg(r, n):
    return int.from_bytes(bytes.fromhex(r.packet(f'p{n:x}')), 'little')


def rd(r, a, n):
    out = b''
    while n > 0:                      # keep RSP reads modest
        k = min(n, 0x800)
        out += r.read_memory(a, k); a += k; n -= k
    return out


def u32(r, a):
    return struct.unpack('<I', rd(r, a, 4))[0]


def wr(r, a, data):
    return r.packet(f'M{a:x},{len(data)}:{data.hex()}')


def pattern(frame):
    """Active-low button word: Cross 4 ticks of every 24; every 4th cycle Start instead."""
    cyc, ph = divmod(frame, 24)
    if ph < 4:
        return 0xFFFF & ~(BTN['start'] if cyc % 4 == 3 else BTN['cross'])
    return 0xFFFF


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out')
    ap.add_argument('--chunks', type=int, default=16); ap.add_argument('--max-frames', type=int, default=30000)
    a = ap.parse_args(); os.makedirs(a.out, exist_ok=True)
    si = subprocess.STARTUPINFO(); si.dwFlags |= subprocess.STARTF_USESHOWWINDOW; si.wShowWindow = 7
    proc = subprocess.Popen([EXE, '-batch', '-fastboot', CUE], cwd=os.path.dirname(EXE), startupinfo=si)
    log('launched pid', proc.pid)
    r = None
    for _ in range(150):
        try:
            r = Remote('127.0.0.1', PORT); break
        except OSError:
            time.sleep(0.2)
    if r is None:
        proc.kill(); raise SystemExit('GDB did not come up')
    meta = dict(chunks=[])
    try:
        for bp in (PAD_RET, CHUNK_DONE):
            log('Z0', hex(bp), r.packet(f'Z0,{bp:x},4'))
        frame = 0; t0 = time.time()
        while True:
            r.send_no_reply('c'); stop = wait_stop(r, 180)
            pc = reg(r, REG['pc'])
            if pc == PAD_RET:
                frame += 1
                w = pattern(frame)
                wr(r, PAD_REC, bytes([0, 0x41, w & 0xFF, w >> 8]))
                if frame % 500 == 0:
                    log(f'frame {frame} ({time.time() - t0:.0f}s)')
                if frame >= a.max_frames:
                    log('max frames reached'); break
                continue
            if pc == CHUNK_DONE:
                s0, s1, s2 = (reg(r, REG[k]) for k in ('s0', 's1', 's2'))
                size = u32(r, s2 + 4)
                cd = rd(r, s0, 0x58)
                data = rd(r, s0 + 0x58, size)
                src = rd(r, s2, size)
                tag = f'chunk{s1:03d}'
                open(os.path.join(a.out, tag + '_dat.bin'), 'wb').write(cd)
                open(os.path.join(a.out, tag + '_loaded.bin'), 'wb').write(data)
                open(os.path.join(a.out, tag + '_src.bin'), 'wb').write(src)
                meta['chunks'].append(dict(index=s1, chunkDat=hex(s0), src=hex(s2), size=size, frame=frame))
                log(f'chunk {s1} captured: ChunkDat={s0:08x} src={s2:08x} size={size:#x} (frame {frame})')
                if len(meta['chunks']) >= a.chunks:
                    r.packet(f'z0,{PAD_RET:x},4'); r.packet(f'z0,{CHUNK_DONE:x},4')
                    dump_globals(r, a.out, meta)
                    try:
                        r.checkpoint('nfs3_after_chunks'); log('checkpoint saved: nfs3_after_chunks')
                    except Exception as e:
                        log('checkpoint failed:', e)
                    break
                continue
            log('unexpected stop', stop[:40], 'pc', hex(pc))
    finally:
        json.dump(meta, open(os.path.join(a.out, 'meta.json'), 'w'), indent=1)
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


def dump_globals(r, out, meta):
    gp = reg(r, REG['gp']); meta['gp'] = hex(gp)
    hdr = rd(r, TRK_HDR, 32)
    open(os.path.join(out, 'trk_header.bin'), 'wb').write(hdr)
    nmeta, nchunk = struct.unpack_from('<II', hdr, 24)
    sizes = dict(StmChunkF=4 * nmeta, StmCenter=12 * nchunk, StmMetaI=2 * nchunk)
    for k, v in TBL.items():
        p = u32(r, v); meta[k] = hex(p)
        open(os.path.join(out, k + '.bin'), 'wb').write(rd(r, p, sizes[k]))
    g = {name: u32(r, gp + off) for name, off in dict(colBuf=884, objDefs=824, instances=828, inst12=832,
                                                       matCount=840, matList=844, slicesHdr=932,
                                                       slicesA=916, slicesB=928, sliceCount=924).items()}
    meta['gp_globals'] = {k: hex(v) for k, v in g.items()}
    col = rd(r, g['colBuf'], 16)
    if col[:4] == b'COLL':
        size = struct.unpack_from('<I', col, 8)[0]
        open(os.path.join(out, 'col_loaded.bin'), 'wb').write(rd(r, g['colBuf'], size))
    log('globals dumped', meta['gp_globals'])


if __name__ == '__main__':
    main()
