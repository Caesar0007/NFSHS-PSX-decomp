/* eaclib/psx/eacpsxz/threads.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\threads.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE408 .. 0x800FE41C].  Minimal cooperative-thread stubs (the PSX build is single-threaded).
 *   Ghidra nfs4-f.exe.c (threads) + IDA sigs.
 */
/* g_currentthread: the oracle reaches it via %gp_rel (iscurrentthread wants
 * `lw $v0,%gp_rel(g_currentthread)($gp)`), so threads.obj OWNS it in .sdata.
 * lever-#6: a cc1plus C++ tentative definition (no init) lands the symbol
 * directly in .sdata, so maspsx -G4 expands `lw $2,g_currentthread` to the
 * oracle's `lw $2,%gp_rel(...)($gp)` (verified in an isolated cc1plus+maspsx
 * run).  This is the OWNING module's real definition; the zero word in
 * asm/data/sdata_8013C54C.sdata.s is the splat placeholder for the same symbol
 * (dedup at final-link when the TU is sealed -- the standard "owned globals
 * defined in the cpp" resolution). */
extern "C" int g_currentthread;   /* fwd decl (owned + defined below, gp-rel) */

extern "C" unsigned int iscurrentthread(int id);   /* @0x800FE408 */
extern "C" void         yieldthread(void);         /* @0x800FE41C */

/* iscurrentthread @0x800FE408 : 1 if `id` is the running thread. */
extern "C" unsigned int iscurrentthread(int id)
{
    return (unsigned int)(g_currentthread == id);
}

/* yieldthread @0x800FE41C : no-op on the single-threaded PSX target. */
extern "C" void yieldthread(void)
{
}

/* Owning definition of g_currentthread (tentative def -> .sdata -> gp-rel; see note above). */
int g_currentthread;
