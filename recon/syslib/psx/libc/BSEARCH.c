/* MATCH (w51-a8, 2026-08-09) -- BEST-KNOWN IS NOW THE 2.7.2 LANE, but it is only a
 * partial win so nothing was landed: cc1_272 + `-fno-schedule-insns` gates 24 diffs
 * (vs 26 in the 2.8 lane), count-exact 48/48, and it CLOSES the {w,cmp} half of the
 * two-pair transposition described below (w -> $s4, cmp -> $s7 exactly as retail).
 * What is left there is {key,base} and {n,lo} swapped.  It needs both a PER_TU_FLAGS
 * `cc1_272` entry AND `_compile_c_272` learning the `no_schedule_insns` key (see the
 * QSORT.c receipt), so it is reported as a candidate rather than landed at 24.
 * FALSIFIED (all gated): plain cc1_272 32 | +(-fno-strength-reduce) 32 |
 * +(-fno-expensive-optimizations) 32; 2.8 lane -fno-strength-reduce 26,
 * -fno-schedule-insns2 38.  Priority dials (a local copy of a param = +2 weighted
 * refs at 0 insns; a read-only fence on a local = +1) in BOTH lanes: 2.8 copyW 28 |
 * copyC 26 | copyWC 38 | fence-lo 38 | combinations 32-40; 2.7.2+nosched copyKey 24 |
 * copyBase 28 | copyBoth 26 | fence-lo 28 | fence-n 36 | combinations 30-40.
 */
/* syslib/psx/libc/BSEARCH.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\BSEARCH.obj ; libc.lib.  1 fn bsearch @0x801091DC (192 B) -- REAL code (in EXE).
 *   Ghidra nfs4-f.exe.c.  Binary search over `n` elements of width `w`; cmp is called as cmp(element, key).
 *   mid=(lo+n)>>1, el=base+w*mid; c<0 -> lo=mid+1, c>0 -> n=mid, c==0 -> return el; loop while lo<n.
 *   Returns the matching element or 0.
 *   VERIFY: 48/48 insns, STRUCTURALLY EXACT (algorithm + control-flow match the oracle 1:1).
 *   30 -> 26-diff near-miss WALL: writing the mid computation as `(n + lo)` (matching the oracle's
 *   `addu v0,s2,s3`==lo+n operand ORDER once each var's home register is known) shaved 4 diffs purely
 *   by matching that one instruction's operand text; the residual is gcc's parameter->callee-saved-
 *   register coloring: oracle picks key->s5,base->s6,n->s3,w->s4,cmp->s7,lo->s2,mid->s0,el->s1; our
 *   build swaps BOTH (n,lo)->(s2,s3) and (cmp,w)->(s4,s7) as two independent pair-transpositions.
 *   Not source-reachable -- tried: mid*w vs w*mid (no effect on the swap), block-scoping lo inside the
 *   `if` (regressed 30->36, added a spill), hoisting w into a fresh `stride` local (regressed 30->30,
 *   added a save slot). The mapping is decided by gcc-2.8's full liveness-graph allocation over 8
 *   callee-saved regs, immune to every operand/decl-order lever tried. No reference C body exists
 *   (psyz leaves it INCLUDE_ASM).
 */
extern void *bsearch(void *key, void *base, unsigned n, unsigned w,
                         int (*cmp)(void *, void *))   /* @0x801091DC */
{
    unsigned lo = 0;
    if (n != 0) {
        do {
            unsigned mid = (lo + n) >> 1;
            unsigned char *el = (unsigned char *)base + w * mid;
            int c = cmp(el, key);
            if (c < 0)
                lo = mid + 1;
            else if (c > 0)
                n = mid;
            else
                return el;
        } while (lo < n);
    }
    __asm__("" : : "r"(lo), "r"(key), "r"(w));
    return (void *)0;
}
