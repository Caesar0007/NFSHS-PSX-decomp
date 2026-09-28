#!/usr/bin/env python3
"""NFS1 (USA SLUS-00204) runtime helper, step 1: boot the disc, let it run, then scan RAM for idle
controller records (PsyQ "PS-X Control PAD Driver Ver 3.0" buffers: {status 0x00, type 0x41, 0xFF, 0xFF})
and, with --watch <addr>, report which instruction writes that address.

Usage: python nfs1_pad_probe.py [--seconds 12] [--watch 0x800xxxxx]
"""
import os, sys, time, argparse, subprocess
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402  (shared GDB helpers; EXE/PORT reused)

CUE = r'C:\Temp\_from_github\Road & Track Presents - The Need for Speed (USA).cue'


def boot():
    si = subprocess.STARTUPINFO(); si.dwFlags |= subprocess.STARTF_USESHOWWINDOW; si.wShowWindow = 7
    proc = subprocess.Popen([P.EXE, '-batch', '-fastboot', CUE], cwd=os.path.dirname(P.EXE), startupinfo=si)
    for _ in range(150):
        try:
            return proc, P.Remote('127.0.0.1', P.PORT)
        except OSError:
            time.sleep(0.2)
    proc.kill(); raise SystemExit('GDB did not come up')


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('--seconds', type=float, default=12)
    ap.add_argument('--watch', type=lambda s: int(s, 0)); a = ap.parse_args()
    proc, r = boot()
    try:
        r.send_no_reply('c'); time.sleep(a.seconds); r.interrupt()
        if a.watch is None:
            ram = P.rd(r, 0x80000000, 0x200000)
            i = -1
            while True:
                i = ram.find(b'\x00\x41\xff\xff', i + 1)
                if i < 0:
                    break
                print('%08x %s' % (0x80000000 + i, ram[i - 4:i + 12].hex()))
        else:
            r.packet(f'Z2,{a.watch:x},4')
            for _ in range(6):
                r.send_no_reply('c'); P.wait_stop(r, 30)
                pc = P.reg(r, P.REG['pc'])
                print('write near pc %08x ra %08x value %s' % (pc, P.reg(r, P.REG['ra']), P.rd(r, a.watch, 4).hex()))
    finally:
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
