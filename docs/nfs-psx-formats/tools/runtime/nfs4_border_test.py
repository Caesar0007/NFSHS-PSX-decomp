"""Steer the player car into the track borders and log its lateral position.
  border_test.py <image.cue> <checkpoint>"""
import os, sys, time, struct, subprocess
RT = r'C:\Temp\nfs4-runtime'
EXE = os.path.join(RT, 'duckstation', 'duckstation-qt-x64-ReleaseLTCG.exe')
CUE, START = sys.argv[1], sys.argv[2]
os.environ['FF_GDB_RAM_BACKEND'] = 'rsp'
sys.path.insert(0, RT)
from gdb_remote import Remote
PAD_RET, PAD_STATE = 0x800E4310, 0x8013E8A2
CROSS, LEFT, RIGHT = 0x4000, 0x0080, 0x0020
CARLIST, SLICES = 0x8010FA48, 0x8013C7C0
def wait_stop(r, t):
    r.s.settimeout(t)
    try:
        while True:
            p = r._receive_packet()
            if p[:1] in ('T', 'S'): return p
    finally: r.s.settimeout(3)
def reg(r, n): return int.from_bytes(bytes.fromhex(r.packet(f'p{n:x}')), 'little')
si = subprocess.STARTUPINFO(); si.dwFlags |= subprocess.STARTF_USESHOWWINDOW; si.wShowWindow = 7
proc = subprocess.Popen([EXE, '-batch', '-fastboot', CUE], cwd=os.path.dirname(EXE), startupinfo=si)
r = None
for _ in range(150):
    try: r = Remote('127.0.0.1', 2350); break
    except OSError: time.sleep(0.2)
try:
    r.packet('qSupported'); r.checkpoint(START, load=True); r.packet(f'Z0,{PAD_RET:x},4')
    plan = [(450, 0, 'straight'), (350, LEFT, 'LEFT'), (250, 0, 'straight'), (500, RIGHT, 'RIGHT'), (200, 0, 'straight')]
    frame = 0
    print('phase    frame slice quad offEdge  xRel    leftDrive rightDrive  speed   y      surface')
    for count, steer, label in plan:
        for k in range(count):
            r.send_no_reply('c'); wait_stop(r, 30); frame += 1
            if reg(r, 37) != PAD_RET: print('unexpected stop', hex(reg(r, 37))); raise SystemExit
            r.packet(f'M{PAD_STATE:x},2:' + struct.pack('<H', 0xFFFF & ~(CROSS | steer)).hex())
            if frame % 25 == 0:
                car = struct.unpack('<I', r.read_memory(CARLIST, 4))[0]
                n = r.read_memory(car, 200)
                sl, = struct.unpack_from('<h', n, 8); offe = n[98]; quad = struct.unpack_from('<b', n, 124)[0]
                y = struct.unpack_from('<i', n, 164)[0]; spd, xrel = struct.unpack_from('<ii', n, 192)
                sq = struct.unpack_from('<I', n, 128)[0]
                surf = r.read_memory(sq, 1)[0] if sq > 0x80000000 else -1
                base = struct.unpack('<I', r.read_memory(SLICES, 4))[0]
                ld, rd = struct.unpack('<hh', r.read_memory(base + 32 * sl + 24, 4)) if 0 <= sl < 2000 else (0, 0)
                print(f'{label:<8} {frame:5d} {sl:5d} {quad:4d} {offe:4d} {xrel/65536:9.2f} {ld/256:9.2f} {rd/256:9.2f} {spd/65536:8.1f} {y/65536:8.2f} {surf:4d}', flush=True)
finally:
    try: r.close()
    except Exception: pass
    proc.kill()
