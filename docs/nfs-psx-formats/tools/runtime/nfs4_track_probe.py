#!/usr/bin/env python3
"""Boot retail NFS4 in the modified DuckStation (GDB + full-state API), drive the front end with
injected pad presses, stop right after Track_Init() returns, dump the runtime track structures,
and save a full-state checkpoint for later probes.

Runtime  : isolated copy of PSX-Dynamic-Decomp's api-runtime at C:\\Temp\\nfs4-runtime\\duckstation
           (GDB port 2350, interpreter, paused at start).
Disc     : C:\\Temp\\nfs4iso\\NFS4.cue (the same image the pristine files were extracted from).
Addresses: retail NFS4.MAP.

Pad injection: a breakpoint on PAD_update's `jr ra` (0x800E4310) lets us overwrite
gPadinfo.buf[0].data.standard.state (0x8013E8A2, raw active-low u16) after every tick, before any
reader (PAD_state, device.cpp direct reads) sees it.

Usage: python nfs4_track_probe.py <outdir> [--max-frames N]
"""
import os, sys, time, json, struct, socket, subprocess, argparse

RT = r'C:\Temp\nfs4-runtime'
EXE = os.path.join(RT, 'duckstation', 'duckstation-qt-x64-ReleaseLTCG.exe')
CUE = r'C:\Temp\nfs4iso\NFS4.cue'
PORT = 2350
os.environ['FF_GDB_RAM_BACKEND'] = 'rsp'
sys.path.insert(0, RT)
from gdb_remote import Remote   # noqa: E402

PAD_RET    = 0x800E4310
TRACK_INIT = 0x800BA808
PAD_STATE  = 0x8013E8A2
G = dict(Track_header=0x8013D4B4, Track_chunkList=0x8013D4B8, Track_gInViewList=0x8013D4AC,
         Track_gInViewCount=0x8013D4B0, BWorldSm_slices=0x8013C7C0, gNumSlices=0x8013C7C8,
         Chunk_chunkCenters=0x8013C81C, Chunk_lightTable=0x8013C818, Chunk_numLight=0x8013D4EC,
         Track_materials=0x8013D4D0, Track_gObjDefs=0x8013D4D4, gPersistObjInst=0x8013D4C0)
BTN = dict(start=0x0008, cross=0x4000)

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
    return r.read_memory(a, n)

def u32(r, a):
    return struct.unpack('<I', rd(r, a, 4))[0]

def wr16(r, a, v):
    return r.packet(f'M{a:x},2:{v & 0xff:02x}{(v >> 8) & 0xff:02x}')

def pattern(frame):
    """Raw active-low word for this tick: press Cross 4 ticks of every 24; every 4th cycle Start."""
    cyc, ph = divmod(frame, 24)
    if ph < 4:
        return 0xFFFF & ~(BTN['start'] if cyc % 4 == 3 else BTN['cross'])
    return 0xFFFF

def main():
    ap = argparse.ArgumentParser(); ap.add_argument('out'); ap.add_argument('--max-frames', type=int, default=20000)
    a = ap.parse_args(); os.makedirs(a.out, exist_ok=True)
    si = subprocess.STARTUPINFO(); si.dwFlags |= subprocess.STARTF_USESHOWWINDOW; si.wShowWindow = 7  # minimized, no focus
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
    try:
        log('connected; qSupported =', r.packet('qSupported')[:120])
        for bp in (PAD_RET, TRACK_INIT):
            log('Z0', hex(bp), r.packet(f'Z0,{bp:x},4'))
        frame = 0; t0 = time.time()
        while True:
            r.send_no_reply('c'); stop = wait_stop(r, 120)
            pc = reg(r, 37)
            if pc == PAD_RET:
                frame += 1
                wr16(r, PAD_STATE, pattern(frame))
                if frame % 500 == 0:
                    log(f'frame {frame} ({time.time() - t0:.0f}s)')
                if frame >= a.max_frames:
                    log('max frames reached without Track_Init'); return
                continue
            if pc == TRACK_INIT:
                name_ptr = reg(r, 4); ra = reg(r, 31)
                name = rd(r, name_ptr, 64).split(b'\0')[0].decode('latin1')
                log(f'Track_Init("{name}") at frame {frame}, ra={ra:08x}')
                r.packet(f'z0,{PAD_RET:x},4'); r.packet(f'z0,{TRACK_INIT:x},4')
                r.packet(f'Z0,{ra:x},4'); r.send_no_reply('c'); wait_stop(r, 300)
                log('Track_Init returned; pc =', hex(reg(r, 37)))
                dump(r, a.out, name, frame)
                try:
                    r.checkpoint('nfs4_after_track_init'); log('checkpoint saved: nfs4_after_track_init')
                except Exception as e:
                    log('checkpoint failed:', e)
                return
            log('unexpected stop', stop[:40], 'pc', hex(pc))
    finally:
        try:
            r.close()
        except Exception:
            pass
        proc.kill()

def dump(r, out, name, frame):
    g = {k: u32(r, v) for k, v in G.items()}
    hdr = rd(r, g['Track_header'], 32)
    chunks = struct.unpack_from('<8i', hdr)[7]
    blobs = {
        'header': hdr,
        'chunkList': rd(r, g['Track_chunkList'], chunks * 0x70),
        'inViewCount': rd(r, g['Track_gInViewCount'], chunks),
        'inViewList': rd(r, g['Track_gInViewList'], chunks * 0x48),
        'slices': rd(r, g['BWorldSm_slices'], g['gNumSlices'] * 32),
        'chunkCenters': rd(r, g['Chunk_chunkCenters'], chunks * 12),
        'lightTable': rd(r, g['Chunk_lightTable'], 0x404),
    }
    for k, v in blobs.items():
        open(os.path.join(out, k + '.bin'), 'wb').write(v)
    json.dump(dict(track_name=name, frame=frame, globals={k: hex(v) if k != 'gNumSlices' and k != 'Chunk_numLight' else v
              for k, v in g.items()}), open(os.path.join(out, 'globals.json'), 'w'), indent=1)
    log('dumped', {k: len(v) for k, v in blobs.items()})

if __name__ == '__main__':
    main()
