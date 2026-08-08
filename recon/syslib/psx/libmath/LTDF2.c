/* syslib/psx/libmath/LTDF2.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\LTDF2.obj ; libmath.lib.  __ltdf2 @0x800EB8E4 (220 B) -- libgcc double compare
 *   `int __ltdf2(double a, double b)`; soft-float ABI a=$a0:$a1, b=$a2:$a3 (lo:hi).  Returns <0 iff a<b.
 *   IDA Hex-Rays (fresh NFS4.EXE.i64), verbatim.
 */
/* MATCH (W51-A6): re-derived from the ORACLE's own block graph, replacing the IDA
 * Hex-Rays transcription (nested `&&`-chains + an inverted result var).  39 -> 29 diffs.
 *  - the quadrant/compare cascade is a flat `goto less` / `goto greater` chain: the oracle
 *    reaches .L800EB99C (less) and .L800EB9AC (greater) from FOUR separate tests, which no
 *    nested-if form lays out;
 *  - `return 0` is a SHARED labeled block (.L800EB9B4) reached BOTH from the both-operands-
 *    are-zero early test and by falling out of `greater` -- so it must be a `goto ret0;`
 *    target, not a literal `return 0;` per arm (a literal lets gcc-2.7.2 strength-reduce the
 *    (0,-1) select branchLESS via `sra x,31` / `sltu;negu`, which the oracle never does).
 * Residual (29): the oracle copies $a0/$a1 into $t0/$t1 at entry and reuses $a0 for `ae`/`bm`
 * -- a REGPARM-copy allocation difference (catalog: some OTHER value must take $aM inside the
 * arg's live range).  Lane note: 29 under cc1-2.8 vs 35 under the gcc-2.7.2 lane, but the
 * 2.7.2 lane is COUNT-EXACT-adjacent (56/55 both) -- see the W51-A6 lane table. */
int __ltdf2(unsigned int a_lo, int a_hi, unsigned int b_lo, int b_hi)   /* @0x800EB8E4 */
{
    int ae, be, am, bm;
    if (a_hi == b_hi && a_lo == b_lo) return 0;
    if ((a_hi & 0x7fffffff) == 0 && a_lo == 0 &&
        (b_hi & 0x7fffffff) == 0 && b_lo == 0) goto ret0;
    if ((a_hi & 0x80000000) != (b_hi & 0x80000000)) {
        if (a_hi & 0x80000000) return -1;
        goto ret0;
    }
    ae = (a_hi >> 20) & 0x7ff;
    be = (b_hi >> 20) & 0x7ff;
    if (ae < be) goto less;
    if (ae != be) goto greater;
    am = (a_hi & 0xfffff) | 0x100000;
    bm = (b_hi & 0xfffff) | 0x100000;
    if (am < bm) goto less;
    if (am != bm) goto greater;
    if (a_lo < b_lo) goto less;
greater:
    if (a_hi < 0) return -1;
    goto ret0;
less:
    if (a_hi < 0) goto ret0;
    return -1;
ret0:
    return 0;
}
