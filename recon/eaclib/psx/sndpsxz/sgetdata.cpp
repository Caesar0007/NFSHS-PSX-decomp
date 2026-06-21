/* eaclib/psx/sndpsxz/sgetdata.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sgetdata.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010C928.  iSNDgetdata -- read an `n`-byte big-endian field, sign-extended to int.
 *   Ghidra nfs4-f.exe.c (sgetdata).
 */

extern "C" int iSNDgetdata(unsigned char *p, int n);   /* @0x8010C928 */

/* iSNDgetdata @0x8010C928 : assemble `n` big-endian bytes at `p` into a signed int (n = 1/2/3 sign-extend). */
extern "C" int iSNDgetdata(unsigned char *p, int n)
{
    int v = 0;
    int i = n - 1;
    if (n != 0) {
        do {
            v = v * 0x100 + (unsigned int)*p;
            p = p + 1;
            i--;
        } while (i != -1);
    }
    if (n == 1 && 0x7f < v)
        v = v - 0x100;
    else if ((n == 2 && (i = -0x10000, 0x7fff < v)) ||
             (n == 3 && (i = -0x1000000, 0x7fffff < v)))
        v = v + i;
    return v;
}
