#!/usr/bin/env python3
"""nfs4_track_probe_map.py -- the Track_Init boot probe with every address resolved from a link MAP.

  python nfs4_track_probe_map.py <outdir> --cue <image.cue> --map <nfs4.map> --exe <NFS4.EXE> [--tag NAME]
                                 [--max-frames N] [--load-checkpoint NAME]

Works for retail (rom/NFS4.MAP + the retail EXE) and for any relinked image (route D: build/route_d/nfs4_d.map).
Addresses: PAD_update's `jr ra` is found by scanning the EXE; the pad word is gPadinfo+6; the tick counter is
simGlobal+4; the stage breakpoints and dumped globals are looked up by their (mangled) symbol names.
"""
import os, sys, time, json, struct, socket, subprocess, argparse, re

RT = r'C:\Temp\nfs4-runtime'
EXE = os.path.join(RT, 'duckstation', 'duckstation-qt-x64-ReleaseLTCG.exe')
PORT = 2350
os.environ['FF_GDB_RAM_BACKEND'] = 'rsp'
sys.path.insert(0, RT)
from gdb_remote import Remote   # noqa: E402


def load_map(fn):
    return {m.group(2): int(m.group(1), 16)
            for m in re.finditer(r'^ ([0-9A-F]{8}) (\S+)\s*$', open(fn, encoding='latin-1').read(), re.M)}


def resolve(mapfile, exefile, entry='Track_Init__FPc'):
    global _D
    D = _D = load_map(mapfile)
    exe = open(exefile, 'rb').read()
    load = struct.unpack_from('<I', exe, 0x18)[0]
    pu = D['PAD_update']
    off = 0x800 + pu - load
    pad_ret = next(pu + i for i in range(0, 0x400, 4) if struct.unpack_from('<I', exe, off + i)[0] == 0x03E00008)
    stage_names = {
        'Track_InitPersistentData__FP15SerializedGroup': 'Track_InitPersistentData',
        'LocateGroupNum__15SerializedGroupi': 'SerializedGroup::LocateGroupNum',
        'Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial': 'Track_LinkMaterials',
        'BWorldSm_Init__FP5Group': 'BWorldSm_Init',
        'CalcObjDefPtrs__Fv': 'CalcObjDefPtrs',
        'CalcObjectBoundingSphere__FP5GroupT0': 'CalcObjectBoundingSphere',
        'ReduceObjectPrecision__FP5GroupT0i': 'ReduceObjectPrecision',
        'InvalidatePersistentCollideBoomObjects__FP5GroupT0': 'InvalidatePersistentCollideBoomObjects',
    }
    stages = {D[k]: v for k, v in stage_names.items()}
    names = ('Track_header', 'Track_chunkList', 'Track_gInViewList', 'Track_gInViewCount', 'BWorldSm_slices',
             'gNumSlices', 'Chunk_chunkCenters', 'Chunk_lightTable', 'Chunk_numLight', 'Track_materials',
             'Track_gObjDefs', 'gPersistObjInst')
    G = {k: D[k] for k in names}
    # drive-loop diagnostics (retail literals before 2026-10-04; a relinked image moves every one of these)
    for k in ('gTotalMem', 'gEnviro', 'Draw_gView', 'gFlip', 'gLowMemory', 'gHighMemory', 'gCurrentMemory', 'gTotalMemory',
              'memclass', 'CF_DVLC', 'CF2_DVLC', 'AudioMus_g', 'AudioTrk_g', '_6Speech.fgSpeech', 'gSm',
              'Night_gPlayerLightingTable', 'Weather_gPos', 'Object_customObjInst', 'Object_customSimObjs',
              'Object_customSFXInst', 'gPersistObjDefBoundingSpheres', 'Track_mem'):
        G[k] = D[k]
    G['dctArenaPtr'] = D['gLowMemory'] - 4          # unnamed static just below gLowMemory (retail G['dctArenaPtr'])
    G['heapLow'] = D['endofcode'] + 8               # EA heap start (retail G['heapLow'])
    return dict(PAD_RET=pad_ret, TRACK_INIT=D[entry], STAGES=stages, PAD_STATE=D['gPadinfo'] + 6,
                TICKS=D['simGlobal'] + 4, G=G)


_ap = argparse.ArgumentParser()
_ap.add_argument('out')
_ap.add_argument('--cue', required=True)
_ap.add_argument('--map', required=True)
_ap.add_argument('--exe', required=True)
_ap.add_argument('--tag', default='probe')
_ap.add_argument('--max-frames', type=int, default=20000)
_ap.add_argument('--load-checkpoint')
_ap.add_argument('--compact', action='store_true', help='experiment: shrink the primitive buffers to 0xD000 after Track_Init (writes guest memory)')
_ap.add_argument('--poke', action='append', default=[], help='SYM=hexval: write a 32-bit word (map symbol) right before Track_Init runs, e.g. TrackMod_forceStreaming=1')
_ap.add_argument('--entry', default='Track_Init__FPc', help='symbol to stop at (TrackMod_TrackInit for route D streaming)')
_A = _ap.parse_args()
CUE = _A.cue
TAG = _A.tag
_R = resolve(_A.map, _A.exe, _A.entry)
PAD_RET = _R['PAD_RET']
TRACK_INIT = _R['TRACK_INIT']
STAGES = _R['STAGES']
PAD_STATE = _R['PAD_STATE']
TICKS = _R['TICKS']
G = _R['G']
print('resolved: PAD_RET %08x TRACK_INIT %08x PAD_STATE %08x TICKS %08x' % (PAD_RET, TRACK_INIT, PAD_STATE, TICKS))

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

def wr32(r, a, v):
    return r.packet(f'M{a:x},4:{v.to_bytes(4, "little").hex()}')

def pattern(frame):
    """Raw active-low word for this tick: press Cross 4 ticks of every 24; every 4th cycle Start."""
    cyc, ph = divmod(frame, 24)
    if ph < 4:
        return 0xFFFF & ~(BTN['start'] if cyc % 4 == 3 else BTN['cross'])
    return 0xFFFF

def main():
    a = _A; os.makedirs(a.out, exist_ok=True)
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
        if a.load_checkpoint:
            r.checkpoint(a.load_checkpoint, load=True)
            ra = reg(r, 31)
            log('checkpoint loaded at pc =', hex(reg(r, 37)), 'ra =', hex(ra))
            for pk in a.poke:
                nm, val = pk.split('='); wr32(r, _D[nm], int(val, 16)); log('poked', nm, val)
            for address in STAGES:
                r.packet(f'Z0,{address:x},4')
            r.packet(f'Z0,{ra:x},4')
            while True:
                r.send_no_reply('c')
                try:
                    wait_stop(r, 30)
                except TimeoutError:
                    r.interrupt()
                    log('timeout; interrupted at pc =', hex(reg(r, 37)), 'ra =', hex(reg(r, 31)))
                    return
                pc = reg(r, 37)
                if pc == ra:
                    log('Track_Init returned; pc =', hex(pc))
                    for address in STAGES:
                        r.packet(f'z0,{address:x},4')
                    r.packet(f'z0,{ra:x},4')
                    r.packet(f'Z0,{PAD_RET:x},4')
                    start_ticks = u32(r, TICKS)
                    max_prim = [0, 0]
                    compacted = False
                    for post_frame in range(1, 1501):
                        r.send_no_reply('c')
                        try:
                            wait_stop(r, 10)
                        except TimeoutError:
                            r.interrupt()
                            log('post-init timeout at pc =', hex(reg(r, 37)))
                            return
                        if reg(r, 37) != PAD_RET:
                            log('post-init unexpected stop at pc =', hex(reg(r, 37)))
                            return
                        if a.compact and not compacted and u32(r, G['gTotalMem']) != 0:
                            compact_total = 0xD000
                            old_total = u32(r, G['gTotalMem'])
                            server0 = u32(r, G['gEnviro'] + 20)
                            wr32(r, G['gEnviro'] + 24 + 20, server0 + compact_total)
                            wr32(r, G['gTotalMem'], compact_total)
                            wr32(r, G['gCurrentMemory'], server0 + compact_total * 2)
                            view = bytearray(rd(r, G['Draw_gView'], 0x7D0))
                            old_budget = old_total - 0x1A00
                            new_budget = compact_total - 0x1A00
                            replaced = 0
                            for off in range(0, len(view) - 3, 4):
                                if int.from_bytes(view[off:off+4], 'little') == old_budget:
                                    wr32(r, G['Draw_gView'] + off, new_budget)
                                    replaced += 1
                            log('compacted primitive buffers', old_total, '->', compact_total,
                                'membudgets patched', replaced,
                                'freed', old_total * 2 - compact_total * 2)
                            compacted = True
                        wr16(r, PAD_STATE, 0xFFFF & ~BTN['cross'])
                        flip = u32(r, G['gFlip']) & 1
                        packet = u32(r, 0x1F800004)
                        server = u32(r, G['gEnviro'] + flip * 24 + 20)
                        if server <= packet <= server + u32(r, G['gTotalMem']):
                            max_prim[flip] = max(max_prim[flip], packet - server)
                        if post_frame % 250 == 0:
                            log('post-init frame', post_frame, 'gameTicks', u32(r, TICKS),
                                'gNumSlices', u32(r, G['gNumSlices']))
                    log('post-init simulation advanced', u32(r, TICKS) - start_ticks,
                        'ticks across 1500 pad frames')
                    low = u32(r, G['gLowMemory']); high = u32(r, G['gHighMemory'])
                    current = u32(r, G['gCurrentMemory']); total = u32(r, G['gTotalMemory'])
                    log('front arena', hex(low), hex(current), hex(high), 'total', total,
                        'used', current - low, 'tail', high - current, 'maxPrim', max_prim)
                    dct = u32(r, G['dctArenaPtr'])
                    log('DCT arena', hex(G['CF_DVLC']), hex(dct), 'used', dct - G['CF_DVLC'],
                        'tail', G['CF2_DVLC'] - dct)
                    cls = u32(r, G['memclass']); block = u32(r, cls + 8)
                    used = free = largest = count = 0
                    while block and count < 2048:
                        raw = rd(r, block, 16)
                        magic, flags, size, nxt, prev = struct.unpack('<HHiII', raw)
                        if magic == 0x4246:
                            free += size; largest = max(largest, size)
                        elif magic == 0x424D:
                            used += max(0, size)
                        block = nxt; count += 1
                    log('EA heap blocks', count, 'used payload', used, 'free payload', free,
                        'largest free', largest)
                    def allocation(label, pointer):
                        if pointer and G['heapLow'] <= pointer < 0x801FC000:
                            h = rd(r, pointer - 16, 8)
                            magic, flags, size = struct.unpack('<HHi', h)
                            log('allocation', label, hex(pointer), 'size', size,
                                'magic', hex(magic), 'flags', hex(flags))
                    music = u32(r, G['AudioMus_g'])
                    allocation('AudioMus_g', music)
                    if music:
                        allocation('Music Buffer', u32(r, music + 0x70))
                        allocation('Music bigfile header', u32(r, music + 0x8c))
                    allocation('AudioTrk_g', u32(r, G['AudioTrk_g']))
                    allocation('Speech object', u32(r, G['_6Speech.fgSpeech']))
                    allocation('SkidMark', u32(r, G['gSm']))
                    allocation('Night player table', u32(r, G['Night_gPlayerLightingTable']))
                    allocation('Weather positions', u32(r, G['Weather_gPos']))
                    allocation('Object instances', u32(r, G['Object_customObjInst']))
                    allocation('Object sim', u32(r, G['Object_customSimObjs']))
                    allocation('Object sfx', u32(r, G['Object_customSFXInst']))
                    allocation('Object spheres', u32(r, G['gPersistObjDefBoundingSpheres']))
                    track_mem_obj = u32(r, G['Track_mem'])
                    allocation('Track SimpleMem object', track_mem_obj)
                    if track_mem_obj:
                        allocation('Track memory arena', u32(r, track_mem_obj))
                    return
                log('stage', STAGES.get(pc, 'unexpected'), 'pc =', hex(pc),
                    'a0 =', hex(reg(r, 4)), 'a1 =', hex(reg(r, 5)))
        for bp in (PAD_RET, TRACK_INIT):
            log('Z0', hex(bp), r.packet(f'Z0,{bp:x},4'))
        frame = 0; t0 = time.time()
        while True:
            r.send_no_reply('c')
            try:
                stop = wait_stop(r, 120)
            except TimeoutError:
                r.interrupt()
                pc = reg(r, 37); sp = reg(r, 29)
                log('no pad frame for 120 s at frame', frame, '; pc =', hex(pc), 'ra =', hex(reg(r, 31)), 'sp =', hex(sp))
                import bisect
                names = sorted((v, k) for k, v in _D.items()); keys = [v for v, _ in names]
                def symz(a):
                    i = bisect.bisect_right(keys, a) - 1
                    return '%s+%x' % (names[i][1], a - names[i][0]) if i >= 0 and 0x80010000 <= a < 0x80200000 else hex(a)
                log('pc', symz(pc), 'vectors zero?', rd(r, 0x80000080, 16) == bytes(16))
                if 0x80000000 <= sp < 0x80200000:
                    words = struct.unpack('<128I', rd(r, sp, 512))
                    log('stack code ptrs:', [symz(v) for v in words if 0x80010000 <= v < 0x80160000][:24])
                return
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
                try:
                    r.checkpoint(TAG + '_pre')
                    log('checkpoint saved:', TAG + '_pre')
                except Exception as e:
                    log('checkpoint failed:', e)
                for pk in a.poke:
                    nm, val = pk.split('='); wr32(r, _D[nm], int(val, 16)); log('poked', nm, val)
                r.packet(f'z0,{PAD_RET:x},4'); r.packet(f'z0,{TRACK_INIT:x},4')
                for address in STAGES:
                    r.packet(f'Z0,{address:x},4')
                r.packet(f'Z0,{ra:x},4')
                while True:
                    r.send_no_reply('c')
                    try:
                        wait_stop(r, 30)
                    except TimeoutError:
                        r.interrupt()
                        log('Track_Init timeout; interrupted at pc =', hex(reg(r, 37)),
                            'ra =', hex(reg(r, 31)))
                        return
                    pc = reg(r, 37)
                    if pc == ra:
                        log('Track_Init returned; pc =', hex(pc))
                        break
                    log('stage', STAGES.get(pc, 'unexpected'), 'pc =', hex(pc),
                        'a0 =', hex(reg(r, 4)), 'a1 =', hex(reg(r, 5)))
                dump(r, a.out, name, frame)
                try:
                    r.checkpoint(TAG + '_post'); log('checkpoint saved:', TAG + '_post')
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
