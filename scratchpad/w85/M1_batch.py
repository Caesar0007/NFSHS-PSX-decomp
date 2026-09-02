import json, subprocess, sys
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp')
P = ROOT/'recon/syslib/psx/libgpu/FONT.c'
BASE = (ROOT/'scratchpad/w85/M1_nodev.c').read_bytes()
S = BASE.decode('utf-8')
BLOCK = """        {
            {
                int peel;
                len--;
                peel = -1;
                if (len != peel) {
                    int neg1 = -1;
                    do {
                        WriteChar(*bufPtr++);
                        len--;
                    } while (len != neg1);
                }
            }
        }
""".replace('\n','\r\n')
assert BLOCK in S
def run(name, newblock, fns='FntPrint'):
    s = S.replace(BLOCK, newblock.replace('\n','\r\n'), 1)
    P.write_bytes(s.encode('utf-8'))
    r = subprocess.run([sys.executable,'tools/verify_asm.py','recon/syslib/psx/libgpu/FONT.c',fns],
                       cwd=ROOT, capture_output=True, text=True)
    print('---', name)
    print((r.stdout+r.stderr).strip())
variants = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
for name, blk in variants:
    run(name, blk)
P.write_bytes(BASE)
print('[reverted]')
