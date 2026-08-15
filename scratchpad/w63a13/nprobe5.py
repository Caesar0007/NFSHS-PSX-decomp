"""nprobe5.py -- Night_SetEnviroment round 5: the last 2 = a sched2 li/lw order pair."""
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

def V(b): return [(BASE, b)]

VARIANTS = {
 'base': [],
 'two_fences': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    __asm__("" : : "r"(tgt));\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'zn_only_fence': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'tgt_fence_then_inline_const': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(tgt), "r"(zn2));\n'
   b'    Night_gZNear = 0x80;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'byte_read_before_store': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    int flg = tgt[0x447];\n'
   b'    __asm__("" : : "r"(tgt), "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((flg & 4) != 0) {\n'),
 'tgt_deref_fence': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(tgt[0x447]), "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 'void_tail_then_fence': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(tgt), "r"(zn2), "i"(0));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="8", dump=False)
