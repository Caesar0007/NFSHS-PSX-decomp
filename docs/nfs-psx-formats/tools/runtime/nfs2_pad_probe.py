#!/usr/bin/env python3
"""NFS2 (PAL SLES-00658) runtime helper, step 1: boot the disc, stop at the BIOS pad thunk
B0:0x15 OutdatedPadInitAndStart (func_8008D39C) and report its arguments (a1 = button destination),
then watch the destination for a few seconds of free run.

Usage: python nfs2_pad_probe.py
"""
import os, sys, time, struct, subprocess
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import nfs3_track_probe as P   # noqa: E402  (shared GDB helpers; only EXE/PORT reused)

CUE = r'C:\Temp\nfs2psx-decomp\cdimage\Need for Speed II (Europe) (En,Fr,De,Es,It,Sv).cue'
PAD_INIT = 0x8008D39C


def main():
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
    try:
        r.packet(f'Z0,{PAD_INIT:x},4')
        r.send_no_reply('c'); P.wait_stop(r, 120)
        pc = P.reg(r, P.REG['pc'])
        a = [P.reg(r, 4 + i) for i in range(4)]
        print('stop pc %08x a0..a3 %s ra %08x' % (pc, ' '.join('%08x' % x for x in a), P.reg(r, P.REG['ra'])))
        dest = a[1]
        r.packet(f'z0,{PAD_INIT:x},4')
        print('dest before', P.rd(r, dest, 8).hex())
    finally:
        try:
            r.close()
        except Exception:
            pass
        proc.kill()


if __name__ == '__main__':
    main()
