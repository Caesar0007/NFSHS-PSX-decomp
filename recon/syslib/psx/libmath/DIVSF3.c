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
unsigned int __divsf3(int a1, int a2)   /* @0x800F66E4 */
{
    int          v2 = (unsigned char)(a1 >> 23) - (unsigned char)(a2 >> 23);
    int          v3 = v2 + 126;
    unsigned int v4 = a1 & 0x80000000 ^ a2 & 0x80000000;
    if ((a2 & 0x7FFFFFFF) == 0) {
        /* W55-A4 branch polarity: retail's `bnez v0,<continue>` makes the two
         * degenerate arms the FALL-THROUGH, i.e. the tests are POSITIVE. */
        if (v4) return 1333788672;
        return 1325400064;
    } else if ((a1 & 0x7FFFFFFF) == 0) {
        return v4;
    } else {
            /* W55-A4: retail rebuilds BOTH mantissas IN PLACE over the
             * incoming parameter registers (`or $a2,$v1,$a0` / `or $a1,$v0,$a0`)
             * after the exponents are already extracted -- separate v6/v7
             * locals cost two extra pseudos. */
            int v8 = 0x1000000;
            int v9, n, v13;
            a1 = a1 & 0x7FFFFF | 0x800000;
            a2 = a2 & 0x7FFFFF | 0x800000;
            if (a1 < a2) { a1 *= 2; v3 = v2 + 125; }
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
            if (v3 >= 255) {
                _err_math(34, 14);
                v13 = 2139095040;
                if (v4) return -8388608;
                return v13;
            }
            return v4 | (v3 << 23) | v9;
    }
}
