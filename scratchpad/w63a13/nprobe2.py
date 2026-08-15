"""nprobe2.py -- Night_SetEnviroment round 2 (w63-a13)."""
import sys, os
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/night.cpp'
FN = 'Night_SetEnviroment__FP13DRender_tView'

BASE = (b'    zn = 0x80;\n'
        b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
        b'    Night_gZNear = zn;\n'
        b'    if ((*((u_char *)Camera_gInfo[Vi->player].target + 0x447) & 4) != 0) {\n')

def V(body):
    return [(BASE, body)]

VARIANTS = {
  'base': [],
  # fence BEFORE the store so the store group can still sink into the load slot
  'fence_before_store': V(
     b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
     b'    __asm__("" : : "r"(tgt));\n'
     b'    Night_gZNear = 0x80;\n'
     b'    if ((tgt[0x447] & 4) != 0) {\n'),
  # same but keeping the constant launder too
  'fence_before_store+launder': V(
     b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
     b'    __asm__("" : : "r"(tgt));\n'
     b'    zn = 0x80;\n'
     b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
     b'    Night_gZNear = zn;\n'
     b'    if ((tgt[0x447] & 4) != 0) {\n'),
  # the 5@69 winner, volatile flavour
  'rofence_guard_volatile': V(
     b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
     b'    Night_gZNear = 0x80;\n'
     b'    __asm__ __volatile__("" : : "r"(tgt));\n'
     b'    if ((tgt[0x447] & 4) != 0) {\n'),
  # TWO operands on one fence = +2 refs on tgt (13B: each operand = +1 ref)
  'rofence_guard_x2': V(
     b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
     b'    Night_gZNear = 0x80;\n'
     b'    __asm__("" : : "r"(tgt), "r"(tgt));\n'
     b'    if ((tgt[0x447] & 4) != 0) {\n'),
  # identity launder on the POINTER only, at the guard (die-twice -> global)
  'ptr_launder_at_guard': V(
     b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
     b'    Night_gZNear = 0x80;\n'
     b'    __asm__("" : "=r"(tgt) : "0"(tgt));\n'
     b'    if ((tgt[0x447] & 4) != 0) {\n'),
  # SHORTEN the pointer qty: read the byte straight into a local, fence the BYTE
  'byte_local': V(
     b'    Night_gZNear = 0x80;\n'
     b'    if ((*((u_char *)Camera_gInfo[Vi->player].target + 0x447) & 4U) != 0) {\n'),
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="8", dump=False)
