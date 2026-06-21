/* syslib/psx/libc/QSORT.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\syslib\psx\QSORT.obj ; archive C:\nfs4\SYSLIB\PSX\LIBC.LIB (xlsx col10)
 *               == libc.lib(QSORT.OBJ). proto: void qsort(void*, size_t, size_t, int(*)()) [stdlib]
 *   2 fns: qsort@0x800E5D8C (336 B) + _swap@0x800E5EDC (64 B).  FULL reconstruction (disasm-v3 MIPS);
 *   NOT a stub/thunk.  C-linkage XDEFs.
 *
 *   Recursive quicksort: pivot = the MIDDLE element swapped to the front, then a single forward
 *   partition pass (elements < pivot are compacted to the low end via _swap), pivot moved to its
 *   resting slot, and the two sides recursed.  n<2 returns; n==2 is a single compare-and-swap.
 *   Two MIPS branch delay-slot assignments are semantically load-bearing and are folded in here:
 *     - `count++` @0x800E5E4C runs for EVERY element < pivot (even when its _swap is skipped because
 *        it is already in place) -> count == partition size, which the left recursion relies on.
 *     - `_swap`'s write-back `q[i]=tmp` @0x800E5F0C runs every loop iteration (it is the delay slot).
 */

/* _swap @0x800E5EDC : exchange two `size`-byte elements byte by byte. */
extern "C" void _swap(char *p, char *q, int size)
{
    int i;
    if (size == 0)
        return;
    for (i = 0; i < size; i++) {
        char tmp = p[i];
        p[i] = q[i];
        q[i] = tmp;
    }
}

/* qsort @0x800E5D8C : sort `nmemb` elements of `size` bytes using comparator `cmp`. */
extern "C" void qsort(void *base, int nmemb, int size,
                      int (*cmp)(const void *, const void *))
{
    char *b = (char *)base;

    if (nmemb < 2)
        return;

    if (nmemb == 2) {                       /* trivial 2-element case */
        if (cmp(b, b + size) > 0)
            _swap(b, b + size, size);
        return;
    }

    _swap(b, b + (nmemb >> 1) * size, size);   /* middle element -> pivot at b[0] */

    char *boundary = b;                     /* end of the "< pivot" region */
    char *elem     = b + size;
    int   count    = 0;                     /* number of elements < pivot */
    int   i;
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
