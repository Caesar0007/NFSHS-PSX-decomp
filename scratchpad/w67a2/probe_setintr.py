#!/usr/bin/env python3
"""W67-A2 probe: transplant the xenogears matched setIntr body (04T: gate community
bodies AS-IS) into _set_intr_callback. Asserting anchors; restores in finally."""
import subprocess, sys, os, shutil

REPO = r'C:\Temp\nfs4-decomp'
SRC = os.path.join(REPO, r'recon\syslib\psx\libetc\INTR.c')
BAK = os.path.join(REPO, r'scratchpad\w67a2\INTR.c.probe.bak')

NEW_BODY = r'''extern int _set_intr_callback(unsigned int idx, int handler)   /* @0x800F2C10 */
{
    /* W67-A2 PROBE: xenogears-decomp setIntr body verbatim (matched vs the SAME bytes,
     * vendor-obj byte-identity proven) */
    int oldCallback;
    unsigned short nMask;
    int nNewMask;

    oldCallback = g_intr.cb[idx];
    if ((handler != oldCallback) && g_intr.inited) {
        nMask = I_MASK;
        I_MASK = 0;
        nNewMask = nMask & 0xFFFF;
        if (handler != 0) {
            g_intr.cb[idx] = handler;
            nNewMask = nNewMask | (1 << idx);
            g_intr.enabled |= (1 << idx);
        } else {
            g_intr.cb[idx] = 0;
            nNewMask = nNewMask & ~(1 << idx);
            g_intr.enabled &= ~(1 << idx);
        }
        if (idx == 0) {
            ChangeClearPAD(handler == 0);
            ChangeClearRCnt(3, handler == 0);
        }
        if (idx == 4) ChangeClearRCnt(0, handler == 0);
        if (idx == 5) ChangeClearRCnt(1, handler == 0);
        if (idx == 6) ChangeClearRCnt(2, handler == 0);
        I_MASK = nNewMask;
    }
    return oldCallback;
}
'''

def main():
    src = open(SRC, 'r', encoding='utf-8', newline='').read()
    start_anchor = 'extern int _set_intr_callback(unsigned int idx, int handler)   /* @0x800F2C10 */'
    end_anchor = '\nextern IntrState *StopCallback(void)   /* @0x800F2D58 */'
    assert src.count(start_anchor) == 1, 'start anchor %d' % src.count(start_anchor)
    assert src.count(end_anchor) == 1, 'end anchor'
    i = src.index(start_anchor)
    j = src.index(end_anchor)
    shutil.copyfile(SRC, BAK)
    orig_bytes = open(SRC, 'rb').read()
    try:
        new = src[:i] + NEW_BODY + src[j:]
        with open(SRC, 'w', encoding='utf-8', newline='') as f:
            f.write(new)
        for run in (1, 2):
            r = subprocess.run([sys.executable, 'tools/verify_asm.py',
                                r'recon/syslib/psx/libetc/INTR.c', '_set_intr_callback'],
                               capture_output=True, text=True, cwd=REPO,
                               env=dict(os.environ, VA_MAX='40'))
            out = r.stdout + r.stderr
            for line in out.splitlines():
                print(line)
            if run == 1:
                print('--- run 2 ---')
    finally:
        with open(SRC, 'wb') as f:
            f.write(orig_bytes)
        assert open(SRC, 'rb').read() == orig_bytes
        print('[restored]')

if __name__ == '__main__':
    main()
