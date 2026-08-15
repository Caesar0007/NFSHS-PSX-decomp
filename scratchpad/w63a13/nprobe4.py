"""nprobe4.py -- Night_SetEnviroment round 4 from the 2-diff basin (w63-a13)."""
import sys, os
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/night.cpp'
FN = 'Night_SetEnviroment__FP13DRender_tView'

BASE = (b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
        b'    int zn2 = 0x80;\n'
        b'    __asm__("" : : "r"(tgt), "r"(zn2));\n'
        b'    Night_gZNear = zn2;\n'
        b'    if ((tgt[0x447] & 4) != 0) {\n')
DECLS = b'  int mode;\n  int zn;\n'

def V(b, extra=None):
    r = [(BASE, b)]
    if extra: r += extra
    return r

VARIANTS = {
 'base': [],
 'op_order_swap': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(zn2), "r"(tgt));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'split_decl': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    zn = 0x80;\n'
   b'    __asm__("" : : "r"(tgt), "r"(zn));\n'
   b'    Night_gZNear = zn;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'fence_after_store': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    Night_gZNear = zn2;\n'
   b'    __asm__("" : : "r"(tgt), "r"(zn2));\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'zn2_first': V(
   b'    int zn2 = 0x80;\n'
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    __asm__("" : : "r"(tgt), "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'volatile_fence': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__ __volatile__("" : : "r"(tgt), "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'tgt_x2_zn': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(tgt), "r"(tgt), "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'zn_x2': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(tgt), "r"(zn2), "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'drop_dead_decls': V(BASE, [(DECLS, b'')]),
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="8", dump=False)
