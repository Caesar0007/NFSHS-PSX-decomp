/* syslib/psx/libmath/DIVSF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj DIVSF3.obj ; libmath.lib.  __divsf3 @0x800F66E4 (324 B) -- IEEE-754 single divide (a1/a2 bit
 *   patterns) via restoring bitwise long division of the mantissas.  Div-by-0 -> +/-Inf; overflow -> _err_math.
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
int _err_math(int errnum, int code);

/* MATCH (W55-A4): 96 -> 38 diffs, ours 79 / oracle 81.  Lane RE-WIRED
 * {"cc1_alt": "2.7.2"} (was 2.95.2).  04Z table on the landed basin:
 * 2.6.3=42 * 2.7.2=38 * 2.7.2-970404/2.8.0/2.8.1=49-51 * 2.95.2=67.
 * LANDINGS: 96 -> 72 the IN-PLACE mantissa rebuild over the parameter variables
 * (as __mulsf3); 72 -> 39 (a) POSITIVE zero tests so the two degenerate arms are
 * retail's FALL-THROUGH (`bnez v0,<continue>`), (b) the rounding arms mutate the
 * quotient AND the exponent IN PLACE (`addiu $a0,$a0,1` / `addiu $a3,$a3,1` /
 * `srav $a0,$a0,$v1`) instead of writing v10/v11 temps, with the >= 0 arm as the
 * fall-through (`bltz $a3`), and (c) the overflow test spelled `if (v3 >= 255)`
 * so the err block is the fall-through; 39 -> 38 masking the quotient IN PLACE
 * (`v9 &= 0xFF7FFFFF`, retail `and $a0,$a0,$v0`).
 * RESIDUAL (38, ours 2 short): one callee-saved seat rotation (ours {exp=$t0,
 * bit=$a3}, retail {exp=$a3, bit=$v1}) plus the same RESULT FUNNEL copies as
 * __mulsf3.  Not a floor. */
/* MATCH (w60-a5, 2026-08-14): 38 -> 14.  The "seat rotation" above was ONE
 * declaration: SPLITTING `int v8 = 0x1000000;` into a bare decl + an assignment
 * in the loop PREHEADER.  The fused decl-with-init starts the mask's live range
 * at the top of the else-block, so its priority (floor_log2(refs)*refs/live)
 * falls below both exponent values and all THREE rotate one seat
 * (ours v8/v2/v3 = $a3/$t1/$t0 -> retail $v1/$t0/$a3).  Same emitted position
 * for the `lui` either way -- this is purely the live-range START.  Generalizes:
 * on a block-local constant whose only real use is a loop, decl-with-init is an
 * allocno DEMOTE you did not ask for.
 * FALSIFIED at 38 before it (each whole-TU gated): identity fence on v8 38 |
 * identity fence on v3 38 | read-only fence on v3 38 | read-only fence on v2 38 |
 * do{}while(0) depth wrapper on `v8 >>= 1` 38.
 * RESIDUAL (14) = TWO clusters, both known classes:
 *  (a) the RESULT FUNNEL shared with __mulsf3 -- retail stages `result` through
 *      $a2 with a copy IN from each err arm (`addu $a2,$a0,$zero`) and a copy OUT
 *      to $v0; ours coalesces both away.  Falsified here: the explicit
 *      default-then-override funnel (`if(..) v13=..; else v13=..;` + one
 *      `return v13;`) 14 (no change), and in __mulsf3 the identity-fence family
 *      (5 placements) is falsified too.  This is the 06E non-propagated
 *      reg-reg-copy instrument gap, now with THREE members (MULSF3, DIVSF3,
 *      FLTSISF's old one) -- crack it once, transfer it three times.
 *  (b) two speculative materializations retail does BEFORE a guard: `lui
 *      $v0,20224` before the sign test (ours fills the beqz slot with it) and
 *      `sll $v0,$a3,23` in the overflow test's delay slot.  Falsified: hoisting
 *      the shift into a named temp before the guard 19, and combining it with
 *      the funnel/default-first shapes 19/14. */
unsigned int __divsf3(int a1, int a2)   /* @0x800F66E4 */
{
    int          v2 = (unsigned char)(a1 >> 23) - (unsigned char)(a2 >> 23);
    int          v3 = v2 + 126;
    unsigned int v4 = a1 & 0x80000000 ^ a2 & 0x80000000;
    if ((a2 & 0x7FFFFFFF) == 0) {
        /* W55-A4 branch polarity: retail's `bnez v0,<continue>` makes the two
         * degenerate arms the FALL-THROUGH, i.e. the tests are POSITIVE. */
        /* w60-a5 SEAL: retail materializes the DEFAULT constant BEFORE the
         * sign test (`lui $v0,20224`) and leaves the beqz's delay slot EMPTY.
         * default-then-override alone is not enough -- gcc still schedules the
         * lui into the slot; the zero-insn VOID-TAIL FENCE between the default
         * and the test is what stops reorg's backward scan from reaching it
         * (06B: any asm bounds that scan), reproducing retail's nop. */
        {
            unsigned int r = 1325400064;
            __asm__("" : : "i"(0));
            if (v4) r = 1333788672;
            return r;
        }
    } else if ((a1 & 0x7FFFFFFF) == 0) {
        return v4;
    } else {
            /* W55-A4: retail rebuilds BOTH mantissas IN PLACE over the
             * incoming parameter registers (`or $a2,$v1,$a0` / `or $a1,$v0,$a0`)
             * after the exponents are already extracted -- separate v6/v7
             * locals cost two extra pseudos. */
            /* w60-a5: SPLIT decl from init.  The fused `int v8 = 0x1000000;`
             * starts the mask's live range at the top of the block, dropping its
             * allocno below the two exponent values and rotating all three
             * (ours v8/v2/v3 -> $a3/$t1/$t0 vs retail $v1/$t0/$a3).  Assigning it
             * in the loop preheader instead gives retail's exact handout. 38 -> 14. */
            int v8;
            int v9, n;
            a1 = a1 & 0x7FFFFF | 0x800000;
            a2 = a2 & 0x7FFFFF | 0x800000;
            if (a1 < a2) { a1 *= 2; v3 = v2 + 125; }
            v8 = 0x1000000;
            v9 = 0;
            do {
                if (a1 >= a2) { v9 |= v8; a1 -= a2; }
                v8 >>= 1;
                a1 *= 2;
            } while (v8);
            /* both arms mutate the quotient AND the exponent IN PLACE
             * (`addiu $a0,$a0,1` / `addiu $a3,$a3,1` / `srav $a0,$a0,$v1`);
             * the >= 0 arm is retail's FALL-THROUGH (`bltz $a3`). */
            if (v3 >= 0) {
                v9 += 1;
                v3 += 1;
                v9 >>= 1;
            } else {
                n = -v3;
                v9 += 1 << n;
                n += 1;
                v9 >>= n;
                v3 = 0;
            }
            v9 &= 0xFF7FFFFF;   /* retail masks the quotient IN PLACE (`and $a0,$a0,$v0`) */
            /* w60-a5: RESULT FUNNEL via the FLTSISF law (same crack as
             * __mulsf3) -- accumulate into an EXISTING pseudo whose register
             * is the target, never a fresh one.  Retail's result lives in $a2
             * = the FIRST PARAMETER's own register (`addu $a2,$a0,$zero` in
             * the head, mantissa rebuilt in place by `or $a2,$v1,$a0`, dead
             * after the division loop).  14 -> 8.  Measured on every candidate:
             * a1 8 | v9 10 | a2 12 | v3 12 | v4 26; the old v13 funnel = 14. */
            if (v3 >= 255) {
                _err_math(34, 14);
                /* w60-a5: the err arm stages through the DEAD QUOTIENT pseudo
                 * -- retail `lui $a0,..; addu $a2,$a0,$zero`, and $a0 is v9's
                 * own register (`addu $a0,$zero,$zero` at the loop head,
                 * `and $a0,$a0,$v0` at the mask).  8 -> 3.  Same law as the
                 * result funnel: an EXISTING dead pseudo, never a fresh one.
                 * Measured: v9 3 | v3 9 | v2 9 | a2 9 | n 67. */
                if (v4) v9 = (int)0xFF800000; else v9 = 0x7F800000;
                a1 = v9;
            } else {
                a1 = (int)(v4 | (v3 << 23) | v9);
            }
            return (unsigned int)a1;
    }
}
