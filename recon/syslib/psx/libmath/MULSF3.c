/* syslib/psx/libmath/MULSF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj MULSF3.obj ; libmath.lib.  __mulsf3 @0x800F34B0 (320 B) -- IEEE-754 single multiply (a1*a2 bit
 *   patterns).  24x24 mantissa product split into 16/8-bit lanes; round-to-nearest.  Overflow -> _err_math.
 */
int _err_math(int errnum, int code);

/* MATCH (W52-A4, 94 -> 93 at the wired lane, 88 under rung 2.95.2;
 * RECOMMEND per-TU {"cc1_alt": "2.95.2"} -- MULSF3.obj holds only __mulsf3,
 * so there is no TU-mate risk.  Drop the existing cc1_272 entry if adopted.)
 * Cluster identity: retail libmath is Sony's PREBUILT vendor object -- these
 * 320 bytes are byte-verbatim in psq43/44/45/47 PSX/LIB/LIBMATH.LIB and in
 * COFF/LIB/LIBMATH.A (see GTDF2.c for the full receipt).
 *
 * LEVER LANDED: retail tests the product's sign as `and $v0,$a3,$t2(0x80000000);
 * beqz` -- a MASK, not `bltz`/`bgez`.  So the source wrote
 * `if (v5 & 0x80000000)`, not `if (v5 < 0)` (the same fold class GTDF2 hit:
 * gcc turns a literal-0 signed compare into the shift/branch form).
 *
 * LADDER on the ORIGINAL source: BASE/2.7.2-970404/2.8.x = 94 * 2.6.x = 100 *
 * 2.7.2 = 101 * 2.91.66/2.95.2 = 93.  After the lever 2.95.2 = 88.
 * NEXT ANGLE (named, untried): retail issues the two exponent extractions
 * (`sra $a2,$t0,23` / `sra $a1,$t1,23`) INTERLEAVED with the mantissa
 * assembly, and keeps the two 24-bit mantissas in $t0/$t1 (retail also has the
 * 2-insn entry parm copy).  Ours computes them as one late block -- that is a
 * statement-ORDER / named-temp job on the v4/v5 expressions, not coloring. */
/* W53-A12 -- THE `union float_long` + `float` PARAMETER SHAPE DOES NOT TRANSFER HERE
 * (falsified across the WHOLE ladder; recorded so it is not re-tried).  That shape is
 * what took GTDF2/LTDF2/EXTSFDF2 to PASS and TRUDFSF2/FIXDFSI to 2/6 this wave, and
 * __mulsf3's oracle head looks like the same class (`addu $t0,$a0,$zero; addu $t1,$a1,
 * $zero` = both params copied off their incoming regs).  It is not: a `double` param is
 * ONE DFmode pseudo needing an EVEN-ALIGNED PAIR, which is what forces $t0:$t1 there,
 * whereas __mulsf3's two floats are two independent SFmode allocnos and the union merely
 * adds a copy.  Measured (union / stock, same source otherwise):
 *   2.6.0 103/-  2.6.3 103/-  2.7.2-970404 97/93  2.7.2 104/-  2.8.0 97/93
 *   2.8.1 97/-  2.91.66 88/-  2.95.2 88/88  => the wired 2.95.2 rung stays the winner.
 * THE REAL CLASS IS SIZE, NOT COLORING: ours is 76 insns against the oracle's 80.  The
 * four missing insns are (a) the RETURN FUNNEL -- retail stages the result through $t0
 * (`addu $t0,$a0,$zero` ... `or $t0,$v0,$a3` ... `addu $v0,$t0,$zero`) where we write
 * $v0 directly, and (b) an out-of-line block: retail's normalisation test is `beqz $v0`
 * + `nop` + `j` over a separate block where ours falls through with `bnez $v0`.  NAMED
 * NEXT ANGLE: this is exactly the TRUDFSF2 recipe.  DONE, PARTIALLY -- 88 -> 84, count
 * 78 vs 80 (was 76).  What landed: ONE named `sign` returned by the early exit instead of
 * recomputing the xor; ONE in-place `prod` carrying the whole rounding chain as compound
 * assignments; `exp = e - 126` hoisted ABOVE the test so it lands in retail's `beqz` delay
 * slot with `exp = e - 127` as the override in the third block; and the ERR arm as the IF
 * BODY with the normal arm as the `else` (retail's `bnez $v0,.L800F35D4` jumps FORWARD to
 * the normal block), both arms assigning one `result` returned once (retail's $t0 funnel
 * + `addu $v0,$t0,$zero`).
 * FALSIFIED on top of that (90, i.e. WORSE than 84): mutating the PARAMETERS in place as
 * the mantissa variables (`a1 = a1 & 0x7FFFFF | 0x800000;`), which is what retail's
 * `or $t0,$v1,$a0` into the param register looks like, in both statement orders for the
 * exponent sum.  Re-laddered after the landing (04Z): 2.91.66 = 2.95.2 = 84, every other
 * rung 92-93, so the wired 2.95.2 stays.
 * RESIDUAL (84, still 2 short): the two missing insns are the last of the funnel, and the
 * bulk of the count is a whole-band coloring rotation -- retail keeps the two mantissas in
 * $t0/$t1 (the param registers) and the running product in $a3, ours uses $a1/$v1/$a2.
 * NAMED NEXT ANGLE: the in-place-param spelling above is semantically what retail did but
 * loses on this rung; the productive instrument is now the -dg dump + allocsim on the
 * three-mult block (which allocno owns $t0/$t1 there), not more source permutation. */
unsigned int __mulsf3(int a1, int a2)   /* @0x800F34B0 */
{
    unsigned int sign;
    unsigned int result;
    unsigned int prod;
    int ma, mb, ha, hb;
    int e, exp;

    sign = a1 & 0x80000000 ^ a2 & 0x80000000;
    if ((a1 & 0x7FFFFFFF) == 0 || (a2 & 0x7FFFFFFF) == 0)
        return sign;
    ma = a1 & 0x7FFFFF | 0x800000;
    mb = a2 & 0x7FFFFF | 0x800000;
    ha = ma >> 8;
    hb = mb >> 8;
    e = (unsigned char)(a1 >> 23) + (unsigned char)(a2 >> 23);
    prod = ha * hb;
    prod += ((ma & 0xFF) * hb) >> 8;
    prod += ((mb & 0xFF) * ha) >> 8;
    exp = e - 126;
    if ((prod & 0x80000000) != 0) {
        prod = (prod + 0x80) >> 8;
    } else {
        prod += 0x40;
        if ((prod & 0x80000000) != 0) {
            prod >>= 8;
        } else {
            prod >>= 7;
            exp = e - 127;
        }
    }
    prod &= 0xFF7FFFFF;
    if (exp >= 255) {
        _err_math(34, 12);
        if (sign != 0) result = 0xFF800000; else result = 0x7F800000;
    } else {
        result = (sign | exp << 23) | prod;
    }
    return result;
}
