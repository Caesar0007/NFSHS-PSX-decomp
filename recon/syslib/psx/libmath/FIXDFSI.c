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
/* MATCH (w60-a5, 2026-08-14): 6 -> 5, count 62 vs 63.  The first half of that
 * named angle LANDED -- in-place shift + a zero-insn OPACITY FENCE restores
 * retail's `srav $v1,$v1,$v0` + `addu $v0,$v1,$zero` copy (see the fence
 * comment in the body).  RESIDUAL (5) is now PURELY jump.c BLOCK PLACEMENT and
 * ours is 1 insn SHORTER: retail lays [tests][shift; j Ltail][ret0][Ltail],
 * i.e. `beqz $v1,Lret0` with the shift as the FALL-THROUGH and a `j` over the
 * shared return-0 block; gcc gives us the canonicalized `bnez $v1,Lshift` with
 * the ret0 block inline (no `j`).  Both cross-jump the two `return 0` sites
 * into ONE block -- only its POSITION differs.
 * FALSIFIED for the placement half (all whole-TU gated on the fence base):
 *   if/else with `return 0` as the else arm 5 (byte-identical to early-return:
 *     jump.c canonicalizes the two forms) | explicit `goto zero;` with the
 *     label physically BETWEEN shift and tail 5 (gcc re-orders anyway) |
 *     same + void-tail fence in the zero block 7 | 04T `return (unsigned)v8;`
 *     (distinct return site) 5 | the two guards swapped 9 | the two guards
 *     merged into one `||` 5 | void-tail fence at the tail-block head 5.
 * Without the fence, the same layout set measures 6/6/8/6/6/6 -- i.e. the
 * placement is invariant under every source shape tried, in BOTH basins.
 * NAMED NEXT ANGLE: jump.c's "conditional jumping around an unconditional
 * jump" inversion is what collapses retail's `j Ltail`; the reachable lever
 * would be one that keeps the shift arm from ENDING in that `j` (a real insn
 * in the arm tail that cross_jump cannot merge), or the permuter.
 *
 * W61-A9 (2026-08-15) -- RE-GATED at 5 (62/63) and the axis pushed further; NO
 * change landed, the four NEW falsifications below are recorded so nobody
 * re-fights them:
 *   SOURCE SHAPES (whole-TU gated, scratchpad/w61a9/fix_v1.json), all 5:
 *     `goto lzero;` from BOTH guards with the label at the very END of the
 *     function (the complete-funnel form 11D asks for) 5 | the 12C EXIT-BLOCK
 *     PLACEMENT DEVICE `if (0) { lzero: return 0; }` after the shift block 5 |
 *     `if (v8 != 0) { shift...; return result; } return 0;` 5 | an explicit
 *     `goto lshift;` / `lzero: return 0;` / `lshift:;` three-label lay-out 5.
 *     ==> jump.c canonicalizes EVERY C block order to the same RTL; the
 *     placement is not source-reachable at this rung, confirmed 11 shapes over
 *     two waves.
 *   04Z LADDER re-run on this basin (whole-TU, NFS4_FORCE_CC1_ALT):
 *     2.6.0 5 * 2.6.3 5 * 2.7.2 5 (= the wired cc1_272 lane, optimal) *
 *     2.7.2-970404 17 * 2.8.0 17 * 2.8.1 17 * 2.91.66 36 * 2.95.2 51.
 *   PER-FN cc1 FLAG SPLICES (272 lane, W60_FN_FLAGS probe): -fno-thread-jumps 5
 *     (inert) * -fno-cse-follow-jumps 5 * -fno-rerun-cse-after-loop 5 *
 *     -fomit-frame-pointer 5 * -fno-expensive-optimizations 10 at 63/63 --
 *     count parity but the SAME jump.c residual plus a new one, so the parity
 *     is coincidental, not the cure.
 * SHARPENED NEXT ANGLE: the fold is gcc's `jump_optimize` "condjump around an
 * unconditional jump" inversion, and it fires at EVERY rung <= 2.8.  Since no
 * source order and no available flag reaches it, the only two live routes are
 * (i) a cc1-instrument read of WHY retail's build left the `j` standing (a
 * jump.c gate we do not have on the ladder), or (ii) PER_FN_TEXT_MOVES -- the
 * residual is a pure 3-line relocation (`srav`/`j`/`addu v0,zero,zero`) plus a
 * branch-polarity flip, which is exactly what a take/after/slot row expresses.
 * NOT a floor. */
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
            unsigned int result;
            /* w60-a5: retail shifts IN PLACE (`srav $v1,$v1,$v0`) and copies to
             * the return reg at the join (`addu $v0,$v1,$zero`).  The in-place
             * mutation alone is not enough -- local-alloc's combine_regs ties
             * the srav's dest to the return pseudo and delete_noop_moves eats
             * the copy.  The zero-insn OPACITY FENCE gives the shifted value an
             * end-point cse/combine cannot equate with its source, so the copy
             * survives (the w47-a2 delete_noop_moves cure, and exactly the
             * "make the PRODUCER's destination a distinct pseudo" angle the
             * W53-A12 receipt below named).  6 -> 5. */
            v8 = v8 >> (-v6);
            __asm__("" : "=r"(v8) : "0"(v8));
            result = (unsigned int)v8;
            if (ua.w.hi < 0) result = (unsigned int)(-(int)result);
            return result;
        }
    }
}
