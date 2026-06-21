/* eaclib/psx/eacpsxz/blkmov.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\blkmov.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn @0x800E62DC (796 bytes): blockmove -- EA's overlap-safe block copy (memmove with the
 *   (src, dst, n) argument order).  FULL reconstruction of the actual BEHAVIOUR (disasm-v3 MIPS).
 *
 *   The binary is a hand-optimised copier: it picks copy DIRECTION by `src < dst` (overlap-safe:
 *   copy backward when the destination is higher), then for the forward case unrolls aligned 64/16/
 *   4/1-byte runs (and uses lwl/lwr/swl/swr word loads/stores on the unaligned path).  Those are
 *   pure performance details; the observable result is exactly an n-byte memmove, reconstructed here.
 */

extern "C" void blockmove(void *src, void *dst, int n)   /* @0x800E62DC */
{
    char *s = (char *)src;
    char *d = (char *)dst;

    if (s < d) {                       /* dst higher -> copy backward (overlap-safe) */
        s += n;
        d += n;
        while (n-- > 0)
            *--d = *--s;
    } else {                           /* copy forward */
        while (n-- > 0)
            *d++ = *s++;
    }
}
