#!/usr/bin/env python3
"""W67-A2 probe: xenogears WIP trapIntr shape for _intrhand. Restores in finally."""
import subprocess, sys, os

REPO = r'C:\Temp\nfs4-decomp'
SRC = os.path.join(REPO, r'recon\syslib\psx\libetc\INTR.c')

NEW = (
'extern void _intrhand(void)            /* @0x800F2A40 */\n'
'{\n'
'    int i;\n'
'    unsigned short mask;\n'
'    void (*fn)();\n'
'\n'
'    if (g_intr.inited == 0) {\n'
'        printf("unexpected interrupt(%04x)\\n", I_STAT);\n'
'        ReturnFromException();\n'
'    }\n'
'    g_intr.in_handler = 1;\n'
'    mask = (g_intr.enabled & I_STAT) & I_MASK;\n'
'    while (mask) {\n'
'        for (i = 0; mask && i < 11; ++i, mask >>= 1) {\n'
'            if (mask & 1) {\n'
'                I_STAT = ~(1 << i);\n'
'                fn = (void (*)())g_intr.cb[i];\n'
'                if (fn) {\n'
'                    fn();\n'
'                }\n'
'            }\n'
'        }\n'
'        mask = (g_intr.enabled & I_STAT) & I_MASK;\n'
'    }\n'
'    if (I_STAT & I_MASK) {\n'
'        if (g_intr_timeout++ > 0x800) {\n'
'            printf("intr timeout(%04x:%04x)\\n", I_STAT, I_MASK);\n'
'            g_intr_timeout = 0;\n'
'            I_STAT = 0;\n'
'        }\n'
'    } else {\n'
'        g_intr_timeout = 0;\n'
'    }\n'
'    g_intr.in_handler = 0;\n'
'    ReturnFromException();\n'
'}\n'
'\n')

def main():
    src = open(SRC, 'r', encoding='utf-8', newline='').read()
    sa_txt = 'extern void _intrhand(void)            /* @0x800F2A40 */'
    eb_txt = 'extern int _set_intr_callback(unsigned int idx, int handler)   /* @0x800F2C10 */'
    assert src.count(sa_txt) == 1 and src.count(eb_txt) == 1
    sa = src.index(sa_txt); eb = src.index(eb_txt)
    orig = open(SRC, 'rb').read()
    try:
        with open(SRC, 'w', encoding='utf-8', newline='') as f:
            f.write(src[:sa] + NEW + src[eb:])
        r = subprocess.run([sys.executable, 'tools/verify_asm.py',
                            'recon/syslib/psx/libetc/INTR.c', '_intrhand'],
                           capture_output=True, text=True, cwd=REPO,
                           env=dict(os.environ, VA_MAX='30'))
        print('RC', r.returncode)
        for l in (r.stdout + r.stderr).strip().splitlines()[:40]:
            print(l)
    finally:
        with open(SRC, 'wb') as f:
            f.write(orig)
        assert open(SRC, 'rb').read() == orig
        print('[restored]')

if __name__ == '__main__':
    main()
