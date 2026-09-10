/* eaclib/psx/eacpsxz/threads.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\threads.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE408 .. 0x800FE41C].  Minimal cooperative-thread stubs (the PSX build is single-threaded).
 *   Ghidra nfs4-f.exe.c (threads) + IDA sigs.
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "threads.h"

/* Owning definition of g_currentthread (tentative def -> .sdata -> gp-rel; see note above). */
int g_currentthread; /* @0x8013DD5C: threads.obj owning definition */

/* iscurrentthread @0x800FE408 : 1 if `id` is the running thread. */
unsigned int iscurrentthread(int id)
{
    return (unsigned int)(g_currentthread == id);
}

/* yieldthread @0x800FE41C : no-op on the single-threaded PSX target. */
void yieldthread(void)
{
}
