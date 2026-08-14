/* MATCH (w51-a8, 2026-08-09) -- *** cc1_272 LANE CANDIDATE: BOTH FNS PASS BYTE-EXACT ***
 * qsort 84/84 AND _swap 15/15 with
 *     PER_TU_FLAGS["recon/syslib/psx/libc/QSORT.c"] = {"cc1_272": True,
 *                                                      "no_strength_reduce": True}
 * TWO build.py changes are required: (1) the lane entry above, and (2)
 * `_compile_c_272` must HONOUR the "no_strength_reduce" key -- today it forwards only
 * "no_delayed_branch", so every other PER_TU key silently no-ops inside the 2.7.2 lane
 * (same class of defect as the compile_c `g_value` no-op w47-a8/a9/a7 triple-found).
 * WHY -fno-strength-reduce: 2.7.2's loop.c strength-reduces _swap's `p[i]`/`q[i]` pair
 * into a single pointer walk with an end-pointer sentinel, but retail keeps the
 * UN-reduced index form (both params copied to $t0/$t1, then `addu v1,t0,a3` /
 * `addu a0,t1,a3` recomputed every iteration).  The flag restores it exactly and is
 * INERT on qsort.  (Under the 2.8 lane _swap already matches, so this is 2.7.2-specific.)
 * SOURCE CHANGE LANDED HERE (neutral in the 2.8 lane: qsort stays 70, _swap stays PASS):
 * `nmemb` and the counter `i` are now UNSIGNED.  That was the whole residual of the
 * 2.7.2 build (70 -> 8 -> 0): the oracle's `sltiu v0,s5,2`, `srl v0,s5,1` and
 * `sltu v0,s0,s5` are the unsigned forms of `nmemb < 2`, `nmemb >> 1`, `i < nmemb`.
 * The pre-existing "~70-diff coloring WALL" note below is a 2.8-LANE artifact: under the
 * correct compiler the param->s-reg map is exact and nothing had to be contorted.
 */
/* syslib/psx/libc/QSORT.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\QSORT.obj ; archive C:\nfs4\SYSLIB\PSX\LIBC.LIB (xlsx col10)
 *               == libc.lib(QSORT.OBJ). proto: void qsort(void*, size_t, size_t, int(*)()) [stdlib]
 *   2 fns: qsort@0x800E5D8C (336 B) + _swap@0x800E5EDC (64 B).  FULL reconstruction (disasm-v3 MIPS);
 *   NOT a stub/thunk.  C-linkage XDEFs.  (_swap = PsyQ memswap/_swap; named by VA per the
 *   FUN_<va> identifier rule, oracle asm/nonmatchings/main/_swap.s.)
 *
 *   VERIFY: _swap = PASS (15/15) -- do-while + unsigned index `i` (sltu) cracked it.
 *   qsort = 84/84 insns, STRUCTURALLY EXACT; ~70-diff coloring near-miss WALL: gcc maps the params to
 *   callee-saved regs off-by-one vs the oracle (oracle base->s4,nmemb->s5,size->s3,cmp->s7; ours
 *   base->s3,nmemb->s6,size->s4), which renumbers every s-reg downstream.  Hoisting elem=base+size and
 *   count=0 to the prologue (matching the oracle's prologue materialization) dropped it 88->70, but the
 *   residual parameter->s-reg coloring is not source-reachable (gcc-2.8 liveness-graph allocation over
 *   8 callee-saved regs).  No reference C body exists (psyz leaves qsort/memswap INCLUDE_ASM).
 *
 *   Recursive quicksort: pivot = the MIDDLE element swapped to the front, then a single forward
 *   partition pass (elements < pivot are compacted to the low end via _swap), pivot moved to its
 *   resting slot, and the two sides recursed.  n<2 returns; n==2 is a single compare-and-swap.
 *   Two MIPS branch delay-slot assignments are semantically load-bearing and are folded in here:
 *     - `count++` @0x800E5E4C runs for EVERY element < pivot (even when its _swap is skipped because
 *        it is already in place) -> count == partition size, which the left recursion relies on.
 *     - `_swap`'s write-back `q[i]=tmp` @0x800E5F0C runs every loop iteration (it is the delay slot).
 */

/* fwd decl: retail VA order puts qsort (0x800E5D8C) before _swap (0x800E5EDC) */
extern void _swap(char *p, char *q, int size);

/* qsort @0x800E5D8C : sort `nmemb` elements of `size` bytes using comparator `cmp`. */
extern void qsort(void *base, unsigned nmemb, int size,
                      int (*cmp)(const void *, const void *))
{
    unsigned i;
    char * boundary;
    char *b     = (char *)base;
    char *elem  = b + size;                 /* hoisted: oracle materializes base+size in the prologue */
    int   count = 0;                        /* hoisted: oracle zeroes count in the prologue */

    if (nmemb < 2)
        return;

    if (nmemb == 2) {                       /* trivial 2-element case */
        if (cmp(b, b + size) > 0)
            _swap(b, b + size, size);
        return;
    }

    _swap(b, b + (nmemb >> 1) * size, size);   /* middle element -> pivot at b[0] */

    boundary = b;

    for (i = 1; i < nmemb; i++) {
        if (cmp(elem, b) < 0) {             /* elem < pivot */
            boundary += size;
            count++;                        /* delay slot: always on this branch */
            if (elem != boundary)
                _swap(elem, boundary, size);
        }
        elem += size;
    }

    if (boundary != b)
        _swap(b, boundary, size);           /* pivot -> its sorted position */

    qsort(b, count, size, cmp);                            /* left  partition */
    qsort(boundary + size, nmemb - count - 1, size, cmp);  /* right partition */
}

/* _swap @0x800E5EDC : exchange two `size`-byte elements byte by byte. */
extern void _swap(char *p, char *q, int size)
{
    unsigned i = 0;
    if (size == 0)
        return;
    do {
        char tmp = p[i];
        p[i] = q[i];
        q[i] = tmp;
        i++;
    } while (i < (unsigned)size);
}
