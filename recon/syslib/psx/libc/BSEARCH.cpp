/* syslib/psx/libc/BSEARCH.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\BSEARCH.obj ; libc.lib.  1 fn bsearch @0x801091DC (192 B) -- REAL code (in EXE).
 *   Ghidra nfs4-f.exe.c.  Binary search over `n` elements of width `w`; cmp is called as cmp(element, key).
 *   Returns the matching element or 0.  Structure transcribed verbatim from the decompile.
 */
extern "C" void *bsearch(void *key, void *base, unsigned n, unsigned w,
                         int (*cmp)(void *, void *))   /* @0x801091DC */
{
    unsigned lo = 0, hi = n, mid;
    if (n != 0) {
        do {
            mid = n >> 1;
            int c = cmp((unsigned char *)base + w * mid, key);
            if (c < 0) { lo = mid + 1; mid = hi; }
            else if (c < 1) return (unsigned char *)base + w * mid;
            n = lo + mid;
            hi = mid;
        } while (lo < mid);
    }
    return (void *)0;
}
