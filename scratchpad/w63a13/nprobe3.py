"""nprobe3.py -- Night_SetEnviroment round 3 from the NEW 4-diff basin (w63-a13)."""
import sys, os
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/night.cpp'
FN = 'Night_SetEnviroment__FP13DRender_tView'

BASE = (b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
        b'    __asm__("" : : "r"(tgt));\n'
        b'    zn = 0x80;\n'
        b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
        b'    Night_gZNear = zn;\n'
        b'    if ((tgt[0x447] & 4) != 0) {\n')

def V(b): return [(BASE, b)]

VARIANTS = {
 'base': [],
 # constant back in the qty pool (no launder) now that the pointer carries +1 ref
 'no_zn_launder': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    __asm__("" : : "r"(tgt));\n'
   b'    Night_gZNear = 0x80;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 # read-only fence on zn instead of the identity launder (keeps it a local qty, +1 ref)
 'zn_rofence': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    __asm__("" : : "r"(tgt));\n'
   b'    zn = 0x80;\n'
   b'    Night_gZNear = zn;\n'
   b'    __asm__("" : : "r"(zn));\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 # both values on ONE fence -> one barrier, +1 ref each
 'one_fence_both': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    int zn2 = 0x80;\n'
   b'    __asm__("" : : "r"(tgt), "r"(zn2));\n'
   b'    Night_gZNear = zn2;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 # pointer fence x2 operands (+2 refs on tgt) with the launder
 'tgt_x2+launder': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    __asm__("" : : "r"(tgt), "r"(tgt));\n'
   b'    zn = 0x80;\n'
   b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
   b'    Night_gZNear = zn;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 # zn declared AFTER tgt fence but stored through a launder placed after the store
 'launder_after_store': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    __asm__("" : : "r"(tgt));\n'
   b'    zn = 0x80;\n'
   b'    Night_gZNear = zn;\n'
   b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 # identity launder on the POINTER (die-twice -> global) + constant left as a qty
 'ptr_launder_only': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    __asm__("" : "=r"(tgt) : "0"(tgt));\n'
   b'    Night_gZNear = 0x80;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
 # both laundered (both global)
 'both_launder': V(
   b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
   b'    __asm__("" : "=r"(tgt) : "0"(tgt));\n'
   b'    zn = 0x80;\n'
   b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
   b'    Night_gZNear = zn;\n'
   b'    if ((tgt[0x447] & 4) != 0) {\n'),
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="8", dump=False)
