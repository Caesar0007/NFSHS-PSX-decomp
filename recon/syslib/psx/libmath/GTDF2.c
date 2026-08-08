/* syslib/psx/libmath/GTDF2.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\GTDF2.obj ; libmath.lib.  __gtdf2 @0x800F0514 (212 B) -- libgcc double compare
 *   `int __gtdf2(double a, double b)`; soft-float ABI passes a=$a0:$a1, b=$a2:$a3 (lo:hi word pairs).
 *   Returns >0 iff a>b (sign-of-difference convention).  IDA Hex-Rays (fresh NFS4.EXE.i64), verbatim.
 */
/* MATCH (W51-A6): re-derived from the oracle's block graph (twin of LTDF2's rewrite),
 * replacing the IDA transcription.  50 -> 40 diffs in the gcc-2.7.2 lane (46 under 2.8 --
 * the lane stays correct for this TU).  Two shape facts read off the oracle:
 *  - the magnitude cascade is a flat `goto greater` / `goto lesseq` chain reached from four
 *    tests (.L800F05D0 / .L800F05E0-region), not nested ifs;
 *  - unlike __ltdf2 (which returns 0/-1 and therefore needs a BRANCHED shared-ret0 block to
 *    stop gcc strength-reducing the select), __gtdf2 returns a 0/1 BOOLEAN and the oracle's
 *    tails are deliberately branchLESS: `and $v0,$t1,0x80000000; sltiu $v0,$v0,1` (= a_hi >= 0)
 *    and `slti $v0,$t1,0` (= a_hi < 0), the latter duplicated into two branch delay slots.
 *    So the tails must be written as plain boolean RETURN EXPRESSIONS, and the both-zero
 *    early exit as a literal `return 0;` (a shared `goto ret0` label costs 2 insns here).
 * Residual (40): the same REGPARM-copy class as __ltdf2 ($a0/$a1 -> $t0/$t1 at entry). */
int __gtdf2(unsigned int a_lo, int a_hi, unsigned int b_lo, int b_hi)   /* @0x800F0514 */
{
    int ae, be, am, bm;
    if (a_hi == b_hi && a_lo == b_lo) return 0;
    if ((a_hi & 0x7fffffff) == 0 && a_lo == 0 &&
        (b_hi & 0x7fffffff) == 0 && b_lo == 0) return 0;
    if ((a_hi & 0x80000000) != (b_hi & 0x80000000)) {
        if (a_hi & 0x80000000) return 0;
        return 1;
    }
    ae = (a_hi >> 20) & 0x7ff;
    be = (b_hi >> 20) & 0x7ff;
    if (be < ae) goto greater;
    if (ae != be) goto lesseq;
    am = (a_hi & 0xfffff) | 0x100000;
    bm = (b_hi & 0xfffff) | 0x100000;
    if (bm < am) goto greater;
    if (am != bm) goto lesseq;
    if (b_lo < a_lo) goto greater;
greater:
    return (a_hi & 0x80000000) == 0;
lesseq:
    return a_hi < 0;
}
