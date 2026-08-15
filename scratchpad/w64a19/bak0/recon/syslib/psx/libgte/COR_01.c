/* syslib/psx/libgte/COR_01.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgte.lib(COR_01.OBJ): csincos -- first-octant sine & cosine by 6-step CORDIC.
 *   Rotates the seed vector (x = 0x9B7, the gain-compensated 1.0, y = 0) by `angle` (4.12, one
 *   revolution = 0x1000) driving the residual z to zero with the arctan table H_cor_tbl, then
 *   linearly corrects for the leftover residual.  Outputs sin -> *psin, cos -> *pcos.
 *
 *   buf[] holds three 8-element columns 0x20 bytes apart: x = buf[0..7] @sp+0x00,
 *   y = buf[8..15] @sp+0x20, z = buf[16..23] @sp+0x40 (frame 0x60).  The retail loop walks
 *   FIVE induction variables -- xi = &x[i] (the read base: x = 0(xi), y = 0x20(xi),
 *   z = 0x40(xi), and the x[i+1] store = 0x4(xi)), yo = &y[i+1], zo = &z[i+1], t = &tbl[i],
 *   and the counter i (the srav shift amount) -- exactly the five locals below.
 *
 *   MATCH receipts (W52-A9, 76 diffs -> PASS 71/71):
 *     1. H_cor_tbl is a REAL exported data global (@0x8013BF20, already materialized in
 *        asm/data/data_8010CCD4.data.s), not a TU-private table -- declare it `extern int
 *        H_cor_tbl[]` and let the reloc point at the blob; the old file-static `_H_cor_tbl`
 *        DOUBLE-defined those bytes.
 *     2. branch POLARITY: retail is `bltz z,ADD` = the source tests the NON-negative case
 *        (`if (z >= 0) { subtract } else { add }`), so the subtract arm is the fall-through.
 *        Written `if (z < 0)` the whole two-arm body mis-aligns (52 -> 24 diffs on the flip).
 *     3. DECLARATION ORDER is the register map: cc1 hands out $t0-$t3 in REVERSE declaration
 *        order, so `i, zo, t, yo, xi` yields retail's i=$t0, yo=$t1, t=$t2, zo=$t3 (the
 *        natural xi/yo/zo/t order gives the exact 3-cycle permutation of those four).
 *        `int i = 0;` FIRST also puts the `addu t0,zero,zero` at the head of the prologue
 *        where retail has it.  (catalog SA "DECL SCOPE + ORDER ARE LOAD-BEARING")
 *     4. INCREMENT ORDER `zo++; t++; yo++; xi++;` -- the pointer bumps are emitted in source
 *        order, and reorg then steals the LAST one that the loop test does not feed into the
 *        `bnez` delay slot.  With xi++ written last, retail's `addiu a3,a3,4` lands in the
 *        slot; written first it is the tbl bump that gets stolen (6 diffs).
 *     5. TOOLCHAIN IDENTITY: needs `-fno-strength-reduce` (see the PER_TU_FLAGS entry).
 *        With strength reduction ON, cc1 promotes the `xi[16]` (z) address to a SIXTH
 *        induction variable and leaves the source's own xi as a separate biv -- +1 prologue
 *        init and +1 loop bump, i.e. the 73-vs-71 count gap that no source shape closes.
 *        The 04M syslib identity (cc1_272) then supplies retail's `la`-macro address form
 *        (`lui t2,%hi; addiu t2,t2,%lo` self-temp) that the 2.8 lane pre-splits through a
 *        $v0 scratch; on the 2.8 lane `no_split_addresses` is the equivalent. */

extern int H_cor_tbl[];   /* @0x8013BF20 : CORDIC arctan steps {511,302,159,81,41,20} */

/* @0x80106AC4 : csincos(int angle, int *psin, int *pcos) -> sin */
extern int csincos(int angle, int *psin, int *pcos)
{
    int buf[24];
    int i = 0;
    int *zo = buf + 17;            /* &z[i+1] */
    int *t = H_cor_tbl;            /* &tbl[i] */
    int *yo = buf + 9;             /* &y[i+1] */
    int *xi = buf;                 /* &x[i] : reads x[i]=xi[0], y[i]=xi[8], z[i]=xi[16] */
    buf[0] = 0x9b7;
    buf[8] = 0;
    buf[16] = angle;
    for (; i < 6; i++) {
        if (xi[16] >= 0) {
            xi[1] = xi[0] - (xi[8] >> i);
            *yo   = xi[8] + (xi[0] >> i);
            *zo   = xi[16] - *t;
        } else {
            xi[1] = xi[0] + (xi[8] >> i);
            *yo   = xi[8] - (xi[0] >> i);
            *zo   = xi[16] + *t;
        }
        zo++; t++; yo++; xi++;
    }
    *pcos = buf[6]  - (buf[22] * buf[14] >> 0xc);   /* x[6] - (z[6]*y[6] >> 12) */
    *psin = buf[14] + (buf[22] * buf[6]  >> 0xc);   /* y[6] + (z[6]*x[6] >> 12) */
    return *psin;
}
