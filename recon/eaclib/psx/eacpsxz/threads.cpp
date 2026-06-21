/* eaclib/psx/eacpsxz/threads.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\threads.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE408 .. 0x800FE41C].  Minimal cooperative-thread stubs (the PSX build is single-threaded).
 *   Ghidra nfs4-f.exe.c (threads) + IDA sigs.
 */
extern "C" int g_currentthread;   /* id of the running thread */

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
