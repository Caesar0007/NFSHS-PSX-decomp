"""cprobe.py -- Night_CreateNightTableElement: the SLD-natural pack block with the
retail FORWARDING pattern (.g and .b forwarded, .r reloaded).  w63-a13."""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/night.cpp'
FN = 'Night_CreateNightTableElement__FiliPUc'

BASE = (b'  newColor.b = (u_char)(newB & ~7);\n'
        b'  newColor.g = (u_char)(newG & ~7);\n'
        b'  newColor.r = (u_char)(newR & ~7);\n'
        b'  newR = newColor.r;\n')

def V(b): return [(BASE, b)]

VARIANTS = {
 'base': [],
 # SLD-natural r,g,b + retail's forwarding pair (.g and .b read back, .r left reloaded)
 'rgb_fwd_gb': V(
   b'  newColor.r = (u_char)(newR & ~7);\n'
   b'  newColor.g = (u_char)(newG & ~7);\n'
   b'  newColor.b = (u_char)(newB & ~7);\n'
   b'  newG = newColor.g;\n'
   b'  newB = newColor.b;\n'),
 'rgb_fwd_b': V(
   b'  newColor.r = (u_char)(newR & ~7);\n'
   b'  newColor.g = (u_char)(newG & ~7);\n'
   b'  newColor.b = (u_char)(newB & ~7);\n'
   b'  newB = newColor.b;\n'),
 'rgb_fwd_g': V(
   b'  newColor.r = (u_char)(newR & ~7);\n'
   b'  newColor.g = (u_char)(newG & ~7);\n'
   b'  newColor.b = (u_char)(newB & ~7);\n'
   b'  newG = newColor.g;\n'),
 # keep the shipped reverse order but add the g/b forwarding too
 'bgr_fwd_all': V(
   b'  newColor.b = (u_char)(newB & ~7);\n'
   b'  newColor.g = (u_char)(newG & ~7);\n'
   b'  newColor.r = (u_char)(newR & ~7);\n'
   b'  newR = newColor.r;\n'
   b'  newG = newColor.g;\n'),
 # r stored last but g,b in retail order before it (g,b,r) + fwd r
 'gbr_fwd_r': V(
   b'  newColor.g = (u_char)(newG & ~7);\n'
   b'  newColor.b = (u_char)(newB & ~7);\n'
   b'  newColor.r = (u_char)(newR & ~7);\n'
   b'  newR = newColor.r;\n'),
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="8", dump=False)
