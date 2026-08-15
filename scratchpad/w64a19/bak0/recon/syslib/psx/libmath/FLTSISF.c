/* syslib/psx/libmath/FLTSISF.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\FLTSISF.obj ; libmath.lib (PsyQ/GCC 2.7.2 soft-float).  1 fn __floatsisf @0x800F6224
 *   (180 B) -- REAL code (in EXE): convert a signed int to an IEEE-754 single (returned as its 32-bit pattern).
 *   Ghidra nfs4-f.exe.c, transcribed verbatim.  Round-to-nearest via the +0x40 bias.  Verified vs original
 *   MIPS via Unicorn oracle.  (The neighbouring SetLineF4 @0x800F62D8 is a DIFFERENT obj, not part of FLTSISF.)
 */
/* MATCH: PASS 45/45 (W55-A4).  Lane: cc1_272 (unchanged).
 * W55-A4 closed the last 4 by writing the sign+exponent accumulation INTO `exp`
 * (`exp = sign | exp << 0x17;`) instead of into `sign`.  W53-A12's named angle
 * was right that the fix had to avoid minting a new pseudo -- the answer was to
 * reuse an EXISTING one whose register is the target ($v1 = exp).  Measured at
 * this basin: into-exp = PASS * into-exp with the mantissa first = 2 * split
 * shift-then-or = 4 * masking mant first = 8 * (W53) into-sign = 4.
 * ---- W53-A12 history (the 32 -> 4 pass) ----
 * 32 -> 4 diffs, count EXACT 45/45.
 * The whole 32 was ONE allocno rotation: `exp` sits in $v1 in retail but ours
 * put it in $a1 while the two hoisted loop-bound constants (0xFFFFFF and
 * 0x3FFFFFFF) took $v1.  It is NOT a priority question -- the -dg dump shows
 * p74(exp, refs 12 / live 34) carries a HARD CONFLICT with reg 3, minted by the
 * two BLOCK-LOCAL qtys of the return expression (p82/p83, block 13) which
 * local_alloc had already parked in $v1.  So the dial is the RETURN EXPRESSION,
 * not the loops: writing the masked mantissa as the FIRST operand
 * (`(mant & 0xff7fffff) | sign | exp << 0x17`) moves those qtys off $v1 and
 * frees it for `exp` (32 -> 6), and accumulating the sign/exponent into `sign`
 * as its own statement (`sign = sign | exp << 0x17;`) recovers retail's second
 * `or` (6 -> 4).
 * FALSIFIED at this basin: every other association/order of the final `|`
 * (sign-first = 32, fully-parenthesised sign|exp first = 30, `mant &= mask` as
 * a separate statement = 8), a read-only fence on `mant` and on `exp` (6 each),
 * and -- the counterexample worth recording -- BOTH forms that introduce a
 * FRESH result pseudo (`unsigned int r = sign | exp<<23; return r | ...;`,
 * block-scope or with a split decl) snap straight back to 32: a new pseudo
 * re-colors the head (catalog's "any-new-pseudo-recolors-head" trap).
 * RESIDUAL (4): retail writes `sign | exp<<23` into $v1 -- exp's JUST-FREED
 * register -- while we mutate $a2 in place (`or $a2,$a2,$v0` vs `or $v1,$a2,$v0`).
 * NAMED NEXT ANGLE: same delete_noop_moves/combine_regs family as FIXDFSI's
 * residual, but here the fix must arrive WITHOUT minting a new pseudo (proven
 * fatal above) -- i.e. via the block-13 qty set (3-QTY LAW) rather than a new
 * variable.  Not a floor. */
extern int __floatsisf(int arg1)   /* @0x800F6224 */
{
    unsigned int sign = 0;
    int          exp  = 0x9d;
    unsigned int mant;
    if (arg1 == 0)
        return 0;
    if (arg1 < 0) { sign = 0x80000000; arg1 = -arg1; }
    for (; arg1 < 0x1000000;  arg1 = arg1 << 4) exp = exp - 4;
    for (; arg1 < 0x40000000; arg1 = arg1 << 1) exp = exp - 1;
    mant = arg1 + 0x40;
    if ((int)mant < 0) { exp = exp + 1; mant = mant >> 8; }
    else               {                mant = mant >> 7; }
    /* W55-A4 SEAL: accumulate the sign+exponent into `exp` ITSELF -- retail's
     * `or $v1,$a2,$v0` writes exp's own (just-freed) register.  Reusing the exp
     * pseudo as the destination gets that register WITHOUT minting a new pseudo
     * (which W53-A12 proved fatal: any fresh result pseudo re-colors the head
     * and snaps back to 32). */
    exp = (int)(sign | exp << 0x17);
    return (int)((unsigned int)exp | (mant & 0xff7fffff));
}
