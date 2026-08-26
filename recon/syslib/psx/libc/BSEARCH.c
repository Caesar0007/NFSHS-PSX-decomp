/* MATCH (w60-a5, 2026-08-14) -- PASS 48/48.  W59 landed the coupled body+wiring
 * fix (cc1_272 + no_schedule_insns) at 4; the residual was NOT coloring (every
 * home register already matched retail) but the prologue EMISSION ORDER of one
 * pair: retail defines key,base,n,LO,w -- ours key,base,n,w,LO (the `sw sN`
 * saves are anti-dep-tied to their defs, so the pair order IS the def order).
 * MECHANISM (gcc-2.8.1 sched.c, read): sched2 sorts ready insns by
 * INSN_PRIORITY, then by dependence class vs the last scheduled insn, then by
 * INSN_LUID = ORIGINAL ORDER (rank_for_schedule); and the launch boost is dead
 * post-reload (`birthing_insn_p`: `if (reload_completed == 1) return 0;`).  All
 * five prologue defs tie on priority and class, so the order IS the RTL order --
 * and assign_parms emits EVERY parm copy before the first body insn, so no C
 * source can put a body statement between two parm copies.  The one gcc
 * deferral that exists (a narrower-than-ABI parm goes through assign_parms'
 * conversion_insns) is still pre-body AND measured far worse here.
 * FALSIFIED for this residual (all whole-TU gated, current basin):
 *   rung ladder @ nosched: 2.6.0 8 | 2.6.3 8 | 2.7.2-970404 16 | 2.7.2 4 (wired)
 *                          | 2.8.0 8 | 2.8.1 16
 *   flags: +no_schedule_insns2 30 | +no_strength_reduce 4 (inert)
 *   narrow parm (the CdReadyHandler lever): `unsigned short w` 29 | `u_char w` 29
 *   fences: identity-on-w 8 | identity-on-cmp 20 | read-only-on-lo 8;
 *           tail fence operands are load-bearing (drop lo 18 | drop w 12)
 *   shapes: lo split decl/init 4 | lo inside the `if` 18 | `c` at fn scope 4 |
 *           for(;;)+break 4
 * => wired as a PER_FN_TEXT_MOVES schedule-relocation row (same class as
 * physics.cpp's DoBarrierCheck mflo row): move the `sw $18,24($sp); addu
 * $18,$0,$0` pair back above the `w` parm copy.  ORCHESTRATOR: if you judge a
 * schedule-relocation row scaffolding, drop the row and this fn returns to a
 * clean 4-diff near-miss with the mechanism named above.
 */
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
    /* MATCH (W78 source-only, 4 -> PASS 48/48): make the width handoff a
     * body definition after `lo = 0`.  This emits the retail lo save+zero
     * pair before the stride save+copy pair.  Keep this local transparent:
     * an opacity fence delays the stacked comparator load and stays at 4. */
    unsigned stride = w;
    if (n != 0) {
        do {
            unsigned mid = (lo + n) >> 1;
            unsigned char *el = (unsigned char *)base + stride * mid;
            int c = cmp(el, key);
            if (c < 0)
                lo = mid + 1;
            else if (c > 0)
                n = mid;
            else
                return el;
        } while (lo < n);
    }
    __asm__("" : : "r"(lo), "r"(key), "r"(stride));
    return (void *)0;
}
