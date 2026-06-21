/* eaclib/psx/eacpsxz/getm.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\getm.obj ; EACPSXZ.LIB.  2 fns @[0x800F3024 .. 0x800F308C].  getm: read an n-byte
 *   BIG-endian field; geti: read n bytes from an UNALIGNED address (lwl/lwr) as a little-endian word.
 *   Ghidra nfs4-f.exe.c (getm; CONCAT byte-assembly) + disasm-v3 (geti unaligned) + IDA sigs.
 */
extern "C" int          getm(unsigned char *p, int n);   /* @0x800F3024 */
extern "C" unsigned int geti(void *p, char nbits);       /* @0x800F308C */

/* getm @0x800F3024 : n-byte big-endian read (n = 1..4). */
extern "C" int getm(unsigned char *p, int n)
{
    if (n - 3 < 0) {
        if (-1 < n - 2)
            return (int)(((unsigned int)p[0] << 8) | p[1]);
        return (int)(unsigned int)p[0];
    }
    if (n != 3)
        return (int)(((unsigned int)p[0] << 24) | ((unsigned int)p[1] << 16) |
                     ((unsigned int)p[2] << 8) | p[3]);
    return (int)(((unsigned int)p[0] << 16) | ((unsigned int)p[1] << 8) | p[2]);
}

/* geti @0x800F308C : unaligned LE word at p (lwl/lwr), masked to the low nbits*8 bits. */
extern "C" unsigned int geti(void *p, char nbits)
{
    unsigned char *b = (unsigned char *)p;
    unsigned int word = (unsigned int)b[0] | ((unsigned int)b[1] << 8) |
                        ((unsigned int)b[2] << 16) | ((unsigned int)b[3] << 24);
    unsigned int sh = (unsigned int)(0x20 - ((int)nbits << 3)) & 0x1f;
    return (word << sh) >> sh;
}
