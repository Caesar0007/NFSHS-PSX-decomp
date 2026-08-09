/* syslib/psx/libmath/FIXDFSI.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj FIXDFSI.obj ; libmath.lib.  __fixdfsi @0x800F6834 (252 B) -- double -> signed int (truncate toward 0).
 *   Soft-float ABI: a1=lo word, a2=hi word.  Uses _dbl_shift; overflow -> _err_math(34,17), INT_MAX/MIN.
 */
/* W52-A4 CLUSTER IDENTITY (applies to every TU in this directory):
 * retail's libmath is NOT an EA rebuild -- it is Sony's PREBUILT vendor object.
 * Each function's retail bytes appear VERBATIM inside the shipped PsyQ
 * PSX/LIB/LIBMATH.LIB of psq43 / psq44 / psq45 / psq47(Lib43,44,45) AND inside
 * psq43/COFF/LIB/LIBMATH.A (ECOFF magic 0x0162; members named adddf3.o,
 * muldf3.o, ... with symbols `<name>.c` + `gcc2_compiled.` + `__gnu_compiled_c`).
 * Verified 10/10 fns: EXACT where the fn has no relocs, HI16-masked where it
 * has jal/%hi (scratchpad/w52a4_libscan.py).  Identical in every SDK drop from
 * 4.0 to 4.7 => Sony compiled it ONCE with a mid-90s gcc-2.x mips-ecoff and
 * shipped that binary unchanged for years.  CONSEQUENCE: the search axis for
 * this cluster is the COMPILER LADDER (04U), not our 2.8 flag space, and no
 * public source exists for it (Sony's own soft-float: _dbl_shift/_add_mant_d/
 * _mainasu/_comp_mant/_mul_mant_d are NOT FSF libgcc2/fp-bit names; searched
 * rage-racer-decomp + psyz + the whole disk -- nothing).  Full ladder tables and
 * the cracked levers are in GTDF2.c / LTDF2.c / MULSF3.c. */
/* MATCH (W53-A12): 67 -> 6 diffs, count 61 vs oracle 63.  Lane: cc1_272 (unchanged).
 * TWO levers, in order of value:
 *
 * 1. THE `union double_long` + `double` PARAMETER SHAPE (the cluster lever --
 *    full mechanism written up in GTDF2.c, which it took to PASS).  Retail's
 *    entry is `addu $s0,$a0,$zero; addu $s1,$a1,$zero` = ONE DFmode pseudo in
 *    an EVEN-ALIGNED callee-saved PAIR, not two independent int params.  Under
 *    -msoft-float `double a` IS that pseudo; the union (address never taken)
 *    keeps it in registers, and because it is live across the `jal` it must go
 *    to a callee-saved pair -> $s0:$s1, with the parm copy surviving.  Two int
 *    params can never produce that (each is its own allocno; $a0/$a1 win).
 *
 * 2. ORACLE-SHAPE corrections read off the branch polarity / operand roles:
 *    (a) `v6 = v4 - 1053` is ONE named variable used BOTH as the overflow test
 *        AND (negated) as the shift count -- retail keeps it in $s3 across the
 *        `jal` (`negu $v0,$s3; srav $v1,$v1,$v0`).  The old `v5 = 29 - v4`
 *        spelling is arithmetically equal mod 32 but is a different value, so
 *        it could not share the register or the frame slot.
 *    (b) the err arm is the IF BODY (fall-through), the shift path the tail:
 *        `if (v6 > 0) { _err_math(...); ... }` -- the old `if (<=0){shift}
 *        else{err}` inverted every branch in the fn.
 *    (c) `_dbl_shift(..., sh[0], sh[1], 10)` -- pass the ARRAY ELEMENTS, not
 *        `ua.w.lo`: retail re-LOADS both words (`lw $a2,0x18($sp)`;
 *        `lw $a3,0x1C($sp)`) at the call.  This alone was 24 -> 8.
 *
 * RESIDUAL (6, count 61 vs 63): retail keeps the shift RESULT in $v1 and copies
 * it to $v0 at the join (`srav $v1,$v1,$v0` ... `addu $v0,$v1,$zero`) plus a `j`
 * over an out-of-line `return 0` block; ours srav's straight into $v0 and lets
 * `return 0` be the fall-through, so we are 2 insns SHORT.  FALSIFIED at this
 * basin (all still 6): symmetric if/else funnel, both-arms-return, default-then-
 * override on `result`, negating `result` vs negating `r`, and FOUR fence forms
 * (identity fence on r / on result before and after the negate, read-only fence
 * on r).  NAMED NEXT ANGLE: this is the delete_noop_moves class (catalog w47-a2)
 * -- the copy dies because local-alloc's combine_regs TIES the srav's dest to
 * the return pseudo.  The reachable lever is to make the PRODUCER's destination
 * a distinct SHORT-LIVED pseudo whose end-points get different regs, or to force
 * the `return 0` block out of the fall-through position (its placement is what
 * removes the `j`).  Not a floor. */
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int _err_math(int errnum, int code);

typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

unsigned int __fixdfsi(double a)   /* @0x800F6834 */
{
    double_long ua;
    int v4, v6;
    ua.d = a;
    if ((ua.w.hi & 0x7FFFFFFF) == 0 && !ua.w.lo) return ua.w.hi & 0x80000000;
    v4 = (ua.w.hi >> 20) & 0x7FF;
    v6 = v4 - 1053;
    if (v6 > 0) {
        _err_math(34, 17);
        if (ua.w.hi < 0) return 0x80000000;
        return 0x7FFFFFFF;
    }
    {
        int sh[2];
        int v8;
        sh[1] = (ua.w.hi & 0xFFFFF) | 0x100000;
        sh[0] = ua.w.lo;
        _dbl_shift((unsigned int *)sh, 0, sh[0], sh[1], 10);
        v8 = sh[1];
        if ((unsigned int)(v4 - 1022) >= 0x20) return 0;
        if (v8 == 0) return 0;
        {
            int r = v8 >> (-v6);
            unsigned int result = (unsigned int)r;
            if (ua.w.hi < 0) result = (unsigned int)(-r);
            return result;
        }
    }
}
