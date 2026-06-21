/* syslib/psx/libc/MEMMOVE.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\MEMMOVE.obj ; libc.lib.  1 fn memmove @0x800FE398 (108 B) -- REAL code (in EXE).
 *   Ghidra nfs4-f.exe.c.  Overlap-safe: forward copy when dest<src, else backward.  Note this PsyQ memmove
 *   returns the (advanced) dest pointer = dest+n in the forward case, dest in the backward case (matches the
 *   binary; verified vs original MIPS via Unicorn oracle).
 */
extern "C" void *memmove(void *dest, void *src, int n)   /* @0x800FE398 */
{
    unsigned char *d = (unsigned char *)dest;
    unsigned char *s = (unsigned char *)src;
    if (d < s) {
        for (; 0 < n; n = n - 1) {
            unsigned char t = *s;
            s = s + 1;
            *d = t;
            d = d + 1;
        }
    } else {
        while (0 < n) {
            n = n - 1;
            d[n] = s[n];
        }
    }
    return d;
}
