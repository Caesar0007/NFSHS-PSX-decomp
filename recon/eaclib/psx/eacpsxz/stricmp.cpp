/* eaclib/psx/eacpsxz/stricmp.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\stricmp.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800FE520.  stricmp -- case-insensitive ASCII string compare.  Ghidra nfs4-f.exe.c + IDA sig.
 */
extern "C" int stricmp(unsigned char *a, unsigned char *b);   /* @0x800FE520 */

/* stricmp @0x800FE520 : compare `a`/`b` case-insensitively; <0/0/>0 like the C library.  (`c-0x41 < 0x1a`
 *   is the unsigned A..Z test, +0x20 folds to lower case.) */
extern "C" int stricmp(unsigned char *a, unsigned char *b)
{
    int diff;
    for (;;) {
        unsigned int ca = (unsigned int)*a;
        if (ca - 0x41 < 0x1a)
            ca = ca + 0x20;
        if ((unsigned int)(*b - 0x41) < 0x1a)
            diff = (int)((ca - 0x20) - (unsigned int)*b);
        else
            diff = (int)(ca - *b);
        if (diff != 0)
            break;
        {
            unsigned char ch = *a;
            a = a + 1;
            if (ch == 0)
                break;
        }
        b = b + 1;
    }
    return diff;
}
