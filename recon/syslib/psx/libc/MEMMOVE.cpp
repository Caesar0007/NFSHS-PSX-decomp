/* syslib/psx/libc/MEMMOVE.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\MEMMOVE.obj ; libc.lib.  1 fn memmove @0x800FE398 (108 B) -- REAL code (in EXE).
 *   Ghidra nfs4-f.exe.c.  Overlap-safe: backward (index form dst[i]=src[i]) when dest>=src, else forward
 *   (pointer-walk *d++ = *s++).  Returns the dest pointer = dest+n in the forward case (d is walked), dest
 *   in the backward case (d untouched) -- matches the binary.
 *   VERIFY: 27/27 insns, 2-diff near-miss -- the only residual is gcc cross-jumping the backward path's
 *   `jr ra` into the shared epilogue (oracle `j .L3FC; addu v0,a3,zero[delay]`) vs our inline `jr ra`.
 *   A pure code-layout tie-break (both byte-valid); not reachable from C structure (early-return form
 *   regresses to 5 diffs).  branch polarity + loop shapes are exact.
 */
extern "C" void *memmove(void *dest, void *src, int n)   /* @0x800FE398 */
{
    unsigned char *d = (unsigned char *)dest;
    unsigned char *s = (unsigned char *)src;
    if (d >= s) {
        while (n-- > 0) {
            d[n] = s[n];
        }
    } else {
        while (n-- > 0) {
            *d = *s;
            s = s + 1;
            d = d + 1;
        }
    }
    return d;
}
