/* syslib/psx/libc/MEMCMP.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\MEMCMP.obj ; libc.lib.  1 fn memcmp @0x80103734 (76 B) -- REAL code (in EXE).
 *   Faithful to disasm-v3 (byte-compare loop; the PsyQ memcmp reads >=1 byte even for n==0).
 *   Verified vs original MIPS via Unicorn oracle.
 */
extern "C" int memcmp(void *s1, void *s2, int n)   /* @0x80103734 */
{
    unsigned char *a = (unsigned char *)s1;
    unsigned char *b = (unsigned char *)s2;
    for (;;) {
        if (*a != *b) return (int)*a - (int)*b;
        if (--n <= 0) return 0;
        a = a + 1;
        b = b + 1;
    }
}
