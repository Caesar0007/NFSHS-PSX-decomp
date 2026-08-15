/* eaclib/psx/eacpsxz/textcrnt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\textcrnt.obj ; EACPSXZ.LIB.  2 fns @[0x800F30AC .. 0x800F30D4].  putm/puti -- store
 *   an n-byte field (big-endian / little-endian).  Ghidra nfs4-f.exe.c + IDA sigs (dropped reg args restored).
 */
extern void putm(int dst, unsigned int val, int n);            /* @0x800F30AC */
extern void puti(unsigned char *buf, unsigned int val, int n); /* @0x800F30D4 */

/* putm @0x800F30AC : write `val` as `n` bytes big-endian into dst[0..n). */
extern void putm(int dst, unsigned int val, int n)
{
    int            i = n - 1;
    unsigned char *p = (unsigned char *)(dst + i);
    for (; -1 < i; i = i - 1) {
        *p = (unsigned char)val;
        val = val >> 8;
        p = p - 1;
    }
}

/* puti @0x800F30D4 : write `val` as `n` bytes little-endian into buf[0..n). */
extern void puti(unsigned char *buf, unsigned int val, int n)
{
    while (n = n - 1, -1 < n) {
        *buf = (unsigned char)val;
        val = val >> 8;
        buf = buf + 1;
    }
}
