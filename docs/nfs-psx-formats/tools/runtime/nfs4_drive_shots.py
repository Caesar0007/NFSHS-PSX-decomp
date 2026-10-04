"""Load the post-Track_Init checkpoint of the converted track, hold accelerate, and save a
full-state checkpoint (which embeds a screenshot + VRAM) every N pad frames."""
import os, sys, time, struct, subprocess
RT = r'C:\Temp\nfs4-runtime'
EXE = os.path.join(RT, 'duckstation', 'duckstation-qt-x64-ReleaseLTCG.exe')
CUE = sys.argv[1]; TAG = sys.argv[2]; START = sys.argv[3]   # <image.cue> <checkpoint tag> <checkpoint to load> <frames,comma-separated>
os.environ['FF_GDB_RAM_BACKEND'] = 'rsp'
sys.path.insert(0, RT)
from gdb_remote import Remote
PAD_RET, PAD_STATE = 0x800E4310, 0x8013E8A2   # retail NFS4.EXE
TICKS = 0x8011E0B0
if len(sys.argv) > 7:   # relinked image: <PAD_RET> <PAD_STATE> <TICKS> hex (from nfs4_track_probe_map.py's 'resolved:' line)
    PAD_RET, PAD_STATE, TICKS = (int(x, 16) for x in sys.argv[5:8])
CROSS, LEFT, RIGHT = 0x4000, 0x0080, 0x0020
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
    r.packet('qSupported')
    r.checkpoint(START, load=True)
    r.packet(f'Z0,{PAD_RET:x},4')
    shots = [int(x) for x in sys.argv[4].split(',')]
    for frame in range(1, max(shots) + 1):
        r.send_no_reply('c'); wait_stop(r, 30)
        if reg(r, 37) != PAD_RET:
            print('unexpected stop pc', hex(reg(r, 37)), 'frame', frame); break
        r.packet(f'M{PAD_STATE:x},2:' + struct.pack('<H', 0xFFFF & ~CROSS).hex())
        if frame in shots:
            name = f'{TAG}-{frame}'
            r.checkpoint(name); print('saved', name, 'ticks', struct.unpack('<I', r.read_memory(TICKS, 4))[0], flush=True)
            r.packet(f'Z0,{PAD_RET:x},4')
finally:
    try: r.close()
    except Exception: pass
    proc.kill()
