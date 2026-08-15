"""w64-a13 sprobe -- Sfx_BuildSouffleFacet.  posdiff says the register ROLES ARE ALREADY
CORRECT (ours and the oracle have the IDENTICAL first-use order s0 a0 s2 a1 s3 s1 v0 v1 a2
a3 t2 t3 t4 t5 t6 t1 t0, alpha-renamed LCS 882/938), so the 116 is NOT a permutation -- it
is emission order, and chunkdiff localises the WHOLE of it to ONE 11-insn run at the tail:

  OURS                          ORACLE
  lw   a0,0(t1)   <- RE-READ    lw   a0,20(s3)
  lw   v1,20(s3)                addiu v1,t0,40     <- bump off the LIVE prim ($t0)
  addiu v0,a0,40                sll  a0,a0,2
  sll  v1,v1,2                  addu a0,a0,a2
  addu v1,v1,a1                 lw   v0,0(a0)
  sw   v0,0(t1)                 and  a1,t0,a1      <- mask the LIVE prim
  lw   v0,0(v1)                 sw   v1,0(t1)
  and  a0,a0,a3                 and  v0,v0,a3
  and  v0,v0,a2                 or   v0,v0,a1
  or   v0,v0,a0                 sw   v0,0(a0)
  sw   v0,0(v1)

i.e. the source re-reads Render_gPacketPtr for both the link value AND the bump where
retail uses the already-loaded `prim`.  That is the catalog's packet-emission law
("bump the cursor off the ALREADY-LOADED prim, never a scratchpad re-read").
"""
import sys
sys.path.insert(0, r'C:/Temp/nfs4-decomp/tools')
import fast

SRC = 'recon/game/psx/sfx.cpp'
FN = 'Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle'

TAG = (b'          prim->tag = prim->tag & 0xff000000 |\n'
       b'                      *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;\n')
LINK = b'          link = (u_int)Render_gPacketPtr & 0xffffff;\n'
BUMP = b'          Render_gPacketPtr = Render_gPacketPtr + 0x28;\n'
PAL = (b'          *(u_int *)(Render_gPalettePtr + sd->otz * 4) =\n'
       b'               *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xff000000 | link;\n')
BLK = TAG + LINK + BUMP + PAL

LINK_P = b'          link = (u_int)prim & 0xffffff;\n'
BUMP_P = b'          Render_gPacketPtr = (u_char *)prim + 0x28;\n'

VARIANTS = {
    'base': [],
    'link_prim': [(BLK, TAG + LINK_P + BUMP + PAL)],
    'bump_prim': [(BLK, TAG + LINK + BUMP_P + PAL)],
    'both_prim': [(BLK, TAG + LINK_P + BUMP_P + PAL)],
    'both_swap': [(BLK, TAG + BUMP_P + LINK_P + PAL)],
    'both_bump_last': [(BLK, TAG + LINK_P + PAL + BUMP_P)],
    'both_pal_mid': [(BLK, TAG + LINK_P + BUMP_P + PAL)],
}

if __name__ == '__main__':
    only = sys.argv[1:] if len(sys.argv) > 1 else None
    v = {k: x for k, x in VARIANTS.items() if not only or k in only}
    fast.run(SRC, FN, FN, v, gval="0", dump=False)
