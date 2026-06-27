/* eaclib/psx/eacpsxz/threads.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\threads.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE408 .. 0x800FE41C].  Minimal cooperative-thread stubs (the PSX build is single-threaded).
 *   Ghidra nfs4-f.exe.c (threads) + IDA sigs.
 */
/* g_currentthread: the oracle reaches it via %gp_rel (iscurrentthread wants
 * `lw $v0,%gp_rel(g_currentthread)($gp)`), so threads.obj owns it gp-rel.  The
 * lever-#6 fix (tentative def -> .comm -> gp-rel) works for the src/ C TUs, but
 * here asm/data/sdata_8013C54C.sdata.s ALREADY STRONGLY DEFINES g_currentthread
 * in .sdata, and a cc1plus C++ tentative def is ALSO a strong .sdata def -> the
 * two collide ("multiple definition") at link.  cc1plus doesn't emit the `.comm`
 * (common) form that gen_gprel_defs.py relies on for C, so the clean gp-rel form
 * isn't reachable from this C++ TU without editing asm/data.  Left `extern`
 * (absolute) -> iscurrentthread stays a 3-diff near-miss (the gp-rel load). */
extern "C" int g_currentthread;   /* id of the running thread (asm/data owns) */

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
