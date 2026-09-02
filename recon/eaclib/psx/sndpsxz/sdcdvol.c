/* eaclib/psx/sndpsxz/sdcdvol.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdcdvol.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x801094EC.  iSNDplatformcdpanvol -- push a CD pan/volume to the SPU CD-input volume registers.
 *   Ghidra nfs4-f.exe.c (sdcdvol) + IDA sig.  Ghidra-ism: void(void) typing dropped both args -- IDA shows
 *   2 (pan, vol), passed in $a0/$a1 from SNDcdvol.
 */
/* W85-S8 VOLATILE AUDIT (2026-09-02): the `volatile` qualifiers on 16, 32, 35, 36 (the `int *base = (int *)sndpd` driver-state base)
 * were REMOVED -- plain main-RAM driver state, not MMIO and not IRQ-mutated; removal is
 * gate-neutral (whole-TU verify_asm/tugate PASS before and after).  Every REMAINING
 * `volatile` in this file was measured individually or as a group and is load-bearing
 * (MMIO, or state the oracle provably re-reads) -- do not strip them.  Receipt:
 * scratchpad/w85/S8_receipt.md. */

extern void iSNDpvtolrv(int pan, int level, int *out_l, int *out_r);   /* spvtolrv */
extern unsigned char sndpd[];   /* EA sound-driver state base @0x80147918 */

extern int iSNDplatformcdpanvol(int pan, int vol);   /* @0x801094EC */

/* iSNDplatformcdpanvol @0x801094EC : derive CD L/R from (pan, vol) and write SPU_CD_VOL_L/R (base+0x1b0/2),
 *   scaling each by 0x102 and clamping to 15-bit. */
extern int iSNDplatformcdpanvol(int pan, int vol)
{
    int *base;
    int outL, outR;
    int ctlL, r;
    iSNDpvtolrv(pan, vol, &outL, &outR);
    /* MATCH (byte-exact): three shape facts the oracle dictates, in order.
     *  1. `volatile int *base` indexed by a CONSTANT word index (the spatkey.c idiom) is what
     *     produces the oracle's `lui;addiu &sndpd` + `lw r,0x514(base)` pair -- a plain
     *     `*(int *)(sndpd + 0x514)` folds base+offset into ONE absolute %lo load and then CSEs
     *     the second read away (the oracle re-reads it: two `lw ...,0x514($a0)`).
     *  2. iSNDpvtolrv is declared VOID here: an `int` return makes cc1 emit `(set (reg $v0) call)`,
     *     which keeps $v0 out of the allocator's reach for the whole body -- every value then
     *     colors one slot high (product $v1 not $v0, operand $a1 not $v1).  Prototype = coloring.
     *  3. `r = outR;` read BEFORE the first store is the oracle's hoisted `lw $v1,0x14($sp)`:
     *     &outR escaped into the call, so the scheduler may NOT move that load across the SPU
     *     store on its own (it would have to prove no alias) -- retail's source read it early.
     *     Reading it any earlier (before the ctlL load) mis-orders the pair; hence this exact spot. */
    base = (int *)sndpd;
    ctlL = base[0x514/4];
    r = outR;
    *(unsigned short *)(ctlL + 0x1b0) = (unsigned short)(outL * 0x102 & 0x7fff);
    *(unsigned short *)(base[0x514/4] + 0x1b2) = (unsigned short)(r * 0x102 & 0x7fff);
    return 0;
}
