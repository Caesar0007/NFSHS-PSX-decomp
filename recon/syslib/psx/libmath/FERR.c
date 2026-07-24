/* syslib/psx/libmath/FERR.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\FERR.obj ; libmath.lib.  1 fn _err_math @0x80106A54 (100 B) + the errno state
 *   math_errno @0x8013BF18 (and math_err_point).  Sets the soft-float errno; for EDOM(0x21)/ERANGE(0x22)
 *   also raises a root-counter event via DeliverEvent.  Ghidra nfs4-f.exe.c, verbatim (the `this`==errnum
 *   __thiscall artifact restored to the real first arg).
 */
extern void DeliverEvent(unsigned int event, int spec);   /* libapi A07.obj (BIOS B0:0x07) */

/* oracle addresses both via `lui $at,%hi; sw r,%lo($at)` (absolute), never gp-relative, even though
 * each is a plain 4-byte int within the -G4 threshold -- force them out of .sdata (catalog §I-addendum
 * gp-rel-floor-is-beatable lever: `__attribute__((section(".data")))` on an INITIALIZED file-scope
 * scalar reproduces aspsx 2.77's absolute form; ours defaulted to gp-rel `sw r,0(gp)`). */
extern int math_errno __attribute__((section(".data"))) = 0;        /* @0x8013BF18 */
extern int math_err_point __attribute__((section(".data"))) = 0;

/* Oracle writes BOTH globals UNCONDITIONALLY first (a0/a1 stored to their %lo before either compare
 * is even resolved), THEN decides whether EDOM(0x21)/ERANGE(0x22) also raises the event -- our prior
 * per-branch duplication of the two stores was a real bug (matched semantics on paper but reordered
 * relative to the raw, and diverged from the oracle's shape). */
extern int _err_math(int errnum, int code)   /* @0x80106A54 */
{
    math_errno = errnum;
    math_err_point = code;
    /* switch (not if/else-if): oracle branches with EQUAL-sense compares straight to each case body,
     * falls through to the shared return when neither matches -- an if/else-if chain compiles with the
     * opposite (not-equal, skip-ahead) branch sense. */
    switch (errnum) {
    case 0x21: DeliverEvent(0xf4000002, 0x301); break;
    case 0x22: DeliverEvent(0xf4000002, 0x302); break;
    }
    return 0;
}
