/* syslib/psx/libc/MEMCMP.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\MEMCMP.obj ; libc.lib.  1 fn memcmp @0x80103734 (76 B) -- REAL code (in EXE).
 *   Faithful to disasm-v3 (byte-compare loop; the PsyQ memcmp reads >=1 byte even for n==0).
 *   Verified vs original MIPS via Unicorn oracle.
 *   VERIFY: near-miss WALL (~20 diffs).  No reference C body exists (psyz/psy-q/sotn all leave memcmp as
 *   INCLUDE_ASM); the oracle is a peculiar gcc-2.8 loop lowering -- entry `j` into the body past an
 *   early-placed continuation block (a2-- ; bgtz ; a1++) with `beq v1,v0 -> continue` polarity and a
 *   pointer back-up (`a0--; lbu 0(a0)`) on mismatch.  Multiple loop-rotation / branch-polarity / block-
 *   layout source forms tried (do-while, goto-entry, *a++/a[-1]); gcc collapses each to a different
 *   layout.  Genuine scheduling/coloring wall -- kept as the clearest faithful semantic form.
 */
extern int memcmp(void *s1, void *s2, int n)   /* @0x80103734 */
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
