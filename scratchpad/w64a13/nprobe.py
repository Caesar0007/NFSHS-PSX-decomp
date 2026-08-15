"""w64-a13 nprobe -- Night_SetEnviroment, the last 2 diffs.  The residual is ONE line
relocation: retail issues `lw v0,4(v0)` (the Camera_gInfo[].target load) BEFORE `li v1,128`
and we issue it after; the register map is otherwise identical and the count is exact.

MECHANISM HYPOTHESIS (catalog 12H THE LAUNCH-BOOST RULE, never applied to this fn):
adjust_priority raises a readied insn to 0x7f000001 only if it is a BIRTHING insn --
`(set (reg N) ...)` with REG_N_SETS(N) == 1.  `zn2 = 0x80` is exactly that (one set), so
it wins the ready-list tie against the load; a MUTATED pseudo never boosts.  The zero-insn
way to give zn2 a SECOND set is the IDENTITY LAUNDER `asm("" : "=r"(x) : "0"(x))` -- and
the w63 falsification list for this basin contains the read-only fence in every position
but NOT the identity form (the "constant launder alone = 6" measurement was taken in the
PRE-`tgt`-local basin, i.e. 04Z-stale).
"""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/night.cpp'
FN = 'Night_SetEnviroment__FP13DRender_tView'

BLK = (b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
       b'    int zn2 = 0x80;\n'
       b'    __asm__("" : : "r"(zn2));\n'
       b'    Night_gZNear = zn2;\n')

RO = b'    __asm__("" : : "r"(zn2));\n'
ID = b'    __asm__("" : "=r"(zn2) : "0"(zn2));\n'
TGT = b'    u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;\n'
DECL = b'    int zn2 = 0x80;\n'
ST = b'    Night_gZNear = zn2;\n'
SPLIT = b'    int zn2;\n    zn2 = 0x80;\n'

VARIANTS = {
    'base': [],
    'id_only': [(BLK, TGT + DECL + ID + ST)],
    'id_and_ro': [(BLK, TGT + DECL + ID + RO + ST)],
    'ro_and_id': [(BLK, TGT + DECL + RO + ID + ST)],
    'id_after_store': [(BLK, TGT + DECL + RO + ST + ID)],
    'id_split': [(BLK, TGT + SPLIT + ID + ST)],
    'id_ro_tgt': [(BLK, TGT + DECL + ID + b'    __asm__("" : : "r"(tgt));\n' + ST)],
    'ro_tgt_only': [(BLK, TGT + DECL + b'    __asm__("" : : "r"(tgt));\n' + ST)],
    'id_tgt': [(BLK, TGT + b'    __asm__("" : "=r"(tgt) : "0"(tgt));\n' + DECL + RO + ST)],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)
