"""nprobe.py -- Night_SetEnviroment variants (w63-a13). Restores base in finally."""
import sys, os
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/night.cpp'
FN = 'Night_SetEnviroment__FP13DRender_tView'

BASE = (b'    zn = 0x80;\n'
        b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
        b'    Night_gZNear = zn;\n'
        b'    if ((*((u_char *)Camera_gInfo[Vi->player].target + 0x447) & 4) != 0) {\n')

# --- variants of the store+guard region -------------------------------------
PLAIN = (b'    Night_gZNear = 0x80;\n'
         b'    if ((*((u_char *)Camera_gInfo[Vi->player].target + 0x447) & 4) != 0) {\n')

TGT_FIRST = (b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
             b'    Night_gZNear = 0x80;\n'
             b'    if ((tgt[0x447] & 4) != 0) {\n')

TGT_FIRST_LAUNDER = (b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
                     b'    zn = 0x80;\n'
                     b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
                     b'    Night_gZNear = zn;\n'
                     b'    if ((tgt[0x447] & 4) != 0) {\n')

# +1 ref on the POINTER via a read-only fence placed at the guard (non-launder basin)
TGT_ROFENCE = (b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
               b'    Night_gZNear = 0x80;\n'
               b'    __asm__("" : : "r"(tgt));\n'
               b'    if ((tgt[0x447] & 4) != 0) {\n')

# pointer fence AFTER the guard use (shortest possible barrier damage)
TGT_ROFENCE_LATE = (b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
                    b'    Night_gZNear = 0x80;\n'
                    b'    if ((tgt[0x447] & 4) != 0) {\n')
TGT_ROFENCE_LATE_TAIL = (b'      Night_gZDistShift = 0xd;\n'
                         b'      Night_gXDistShift = 0xb;\n'
                         b'      __asm__("" : : "r"(tgt));\n')
ARM = (b'      Night_gZDistShift = 0xd;\n'
       b'      Night_gXDistShift = 0xb;\n')

# constant laundered AND pointer named (no pointer launder)
BOTH = (b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
        b'    zn = 0x80;\n'
        b'    __asm__("" : "=r"(zn) : "0"(zn));\n'
        b'    Night_gZNear = zn;\n'
        b'    __asm__("" : : "r"(tgt));\n'
        b'    if ((tgt[0x447] & 4) != 0) {\n')

VARIANTS = {
    'base': [],
    'plain_control': [(BASE, PLAIN)],
    'tgt_first': [(BASE, TGT_FIRST)],
    'tgt_first_launder': [(BASE, TGT_FIRST_LAUNDER)],
    'tgt_rofence_at_guard': [(BASE, TGT_ROFENCE)],
    'tgt_rofence_in_arm': [(BASE, TGT_ROFENCE_LATE), (ARM, TGT_ROFENCE_LATE_TAIL)],
    'launder+tgt_rofence': [(BASE, BOTH)],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="8", dump=False)
