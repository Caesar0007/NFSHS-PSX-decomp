/* syslib/psx/libc/QSORT.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\QSORT.obj ; archive C:\nfs4\SYSLIB\PSX\LIBC.LIB (xlsx col10)
 *               == libc.lib(QSORT.OBJ). proto: void qsort(void*, size_t, size_t, int(*)()) [stdlib]
 *   2 fns: qsort@0x800E5D8C (336 B) + func_800E5EDC@0x800E5EDC (64 B).  FULL reconstruction (disasm-v3 MIPS);
 *   NOT a stub/thunk.  C-linkage XDEFs.  (func_800E5EDC = PsyQ memswap/_swap; named by VA per the
 *   FUN_<va> identifier rule, oracle asm/nonmatchings/main/func_800E5EDC.s.)
 *
 *   VERIFY: func_800E5EDC = PASS (15/15) -- do-while + unsigned index `i` (sltu) cracked it.
 *   qsort = 84/84 insns, STRUCTURALLY EXACT; ~70-diff coloring near-miss WALL: gcc maps the params to
 *   callee-saved regs off-by-one vs the oracle (oracle base->s4,nmemb->s5,size->s3,cmp->s7; ours
 *   base->s3,nmemb->s6,size->s4), which renumbers every s-reg downstream.  Hoisting elem=base+size and
 *   count=0 to the prologue (matching the oracle's prologue materialization) dropped it 88->70, but the
 *   residual parameter->s-reg coloring is not source-reachable (gcc-2.8 liveness-graph allocation over
 *   8 callee-saved regs).  No reference C body exists (psyz leaves qsort/memswap INCLUDE_ASM).
 *
 *   Recursive quicksort: pivot = the MIDDLE element swapped to the front, then a single forward
 *   partition pass (elements < pivot are compacted to the low end via func_800E5EDC), pivot moved to its
 *   resting slot, and the two sides recursed.  n<2 returns; n==2 is a single compare-and-swap.
 *   Two MIPS branch delay-slot assignments are semantically load-bearing and are folded in here:
 *     - `count++` @0x800E5E4C runs for EVERY element < pivot (even when its func_800E5EDC is skipped because
 *        it is already in place) -> count == partition size, which the left recursion relies on.
 *     - `func_800E5EDC`'s write-back `q[i]=tmp` @0x800E5F0C runs every loop iteration (it is the delay slot).
 */

/* func_800E5EDC @0x800E5EDC : exchange two `size`-byte elements byte by byte. */
extern "C" void func_800E5EDC(char *p, char *q, int size)
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

/* qsort @0x800E5D8C : sort `nmemb` elements of `size` bytes using comparator `cmp`. */
extern "C" void qsort(void *base, int nmemb, int size,
                      int (*cmp)(const void *, const void *))
{
    char *b     = (char *)base;
    char *elem  = b + size;                 /* hoisted: oracle materializes base+size in the prologue */
    int   count = 0;                        /* hoisted: oracle zeroes count in the prologue */

    if (nmemb < 2)
        return;

    if (nmemb == 2) {                       /* trivial 2-element case */
        if (cmp(b, b + size) > 0)
            func_800E5EDC(b, b + size, size);
        return;
    }

    func_800E5EDC(b, b + (nmemb >> 1) * size, size);   /* middle element -> pivot at b[0] */

    char *boundary = b;                     /* end of the "< pivot" region */
    int   i;
    for (i = 1; i < nmemb; i++) {
        if (cmp(elem, b) < 0) {             /* elem < pivot */
            boundary += size;
            count++;                        /* delay slot: always on this branch */
            if (elem != boundary)
                func_800E5EDC(elem, boundary, size);
        }
        elem += size;
    }

    if (boundary != b)
        func_800E5EDC(b, boundary, size);           /* pivot -> its sorted position */

    qsort(b, count, size, cmp);                            /* left  partition */
    qsort(boundary + size, nmemb - count - 1, size, cmp);  /* right partition */
}
