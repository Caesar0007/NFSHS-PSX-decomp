/* eaclib/psx/eacpsxz/stricmp.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\stricmp.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800FE520.  stricmp -- case-insensitive ASCII string compare.  Ghidra nfs4-f.exe.c + IDA sig.
 */
extern int stricmp(unsigned char *a, unsigned char *b);   /* @0x800FE520 */

/* stricmp @0x800FE520 : compare `a`/`b` case-insensitively; <0/0/>0 like the C library.  (`c-0x41 < 0x1a`
 *   is the unsigned A..Z test, +0x20 folds to lower case.)
 * Oracle is a genuine TAIL-CALL SELF-RECURSION (`j stricmp` w/ a+1,b+1 in the delay slots), NOT an
 * iterative for(;;) loop -- ca (the folded first char) stays live in $a2 throughout, never spilled to
 * a named local.  The `calo = ca - 0x20` hoist (explicit in-place subtract, not `(ca-0x20)-*b` inline)
 * forces gcc to associate the -0x20 onto ca (matching the oracle's `addiu v0,a2,-0x20`) instead of
 * folding it onto *b -- 11->9 diffs.  RESIDUAL 9-diff floor: the oracle RELOADS *b via a fresh `lbu`
 * for the range-test AND again for each branch's subtraction (3 total lbu's); our build's CSE keeps
 * the range-test's loaded value live and reuses it for the else-branch subtraction (2 lbu's) -- tried
 * a `volatile` cast (regressed to 11, perturbs surrounding scheduling) and distinctly-named per-branch
 * temps (gcc's dataflow-level CSE folds them back regardless of surface naming); not source-reachable
 * without a semantically-false `volatile` on the plain `unsigned char *b` param. */
extern int stricmp(unsigned char *a, unsigned char *b)
{
    int diff;
    for (;;) {
        unsigned int ca = (unsigned int)*a;
        if (ca - 0x41 < 0x1a)
            ca = ca + 0x20;
        if ((unsigned int)(*b - 0x41) < 0x1a) {
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
