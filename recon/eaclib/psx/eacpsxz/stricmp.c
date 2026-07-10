/* eaclib/psx/eacpsxz/stricmp.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\stricmp.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800FE520.  stricmp -- case-insensitive ASCII string compare.  Ghidra nfs4-f.exe.c + IDA sig.
 */
extern int stricmp(unsigned char *a, unsigned char *b);   /* @0x800FE520 */

/* stricmp @0x800FE520 : compare `a`/`b` case-insensitively; <0/0/>0 like the C library.
 * The `calo = ca - 0x20` hoist (explicit in-place subtract, not `(ca-0x20)-*b` inline) forces gcc to
 * associate the -0x20 onto ca (matching the oracle's `addiu v0,a2,-0x20`) instead of folding it onto
 * *b.  MATCH (9->0): the b-side A..Z test MUST be the RELATIONAL form `*b >= 0x41 && *b <= 0x5a` --
 * gcc range-folds it itself into the unsigned `(u)(*b-0x41)<0x1a` trick, and that fold CONSUMES the
 * loaded value in place, so each branch arm RELOADS *b (3 lbu's, = oracle).  Writing the unsigned
 * trick explicitly in C names the load as a subexpression and gcc CSE-reuses it across both arms
 * (1 lbu, the old 9-diff "floor").  (`ca` keeps the explicit trick form -- it tests a named local,
 * not a memory deref, and matches as-is.) */
extern int stricmp(unsigned char *a, unsigned char *b)
{
    int diff;
    for (;;) {
        unsigned int ca = (unsigned int)*a;
        if (ca - 0x41 < 0x1a)
            ca = ca + 0x20;
        if (*b >= 0x41 && *b <= 0x5a) {
            unsigned int calo = ca - 0x20;
            diff = (int)(calo - (unsigned int)*b);
        } else
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
