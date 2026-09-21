/* eaclib/psx/sndpsxz/sdasync.c -- a library member the final link left NO code of (slink /strip removed every function).
 *   It is in the retail link all the same: the SYM has its FILE record, because slink pulls members on demand BEFORE it strips.
 *   What is known about it comes from WHERE retail pulled it in (tools/psyq_pipe/slink_pullsim.py):
 *   retail #184, between sdata.obj (sbremove.obj's `sndgs`) and sbirmpat.obj (sbremove.obj's `iSNDbankremovepat`): what
 *   sbremove.obj asks for in between is `iSNDplatformfree` -- so that function is THIS member's (it lived in sdata.c until
 *   2026-09-22; sdata.obj is data only).  It is the one function of this member the final link kept.
 *   sdmemman.obj (#292, `iSNDpsxfree`) and sdma.obj (#293) are pulled from the queue slot of THIS member, back to back: besides
 *   iSNDpsxfree it asked for a DMA-queue name of sdma.obj -- the asynchronous SPU transfer its name promises.
 *   Function names and bodies are NOT retained anywhere; the names below are the natural ones for the member and are
 *   INFERRED.  What is evidence is the reference chain -- it is what puts the members in the retail order. */
#include "../../../link_stripped.h"

/* ---- the surviving function (moved verbatim from sdata.c) ---- */
extern void iSNDpsxfree(int ptr);   /* sdmemman */

extern void iSNDplatformfree(int ptr);   /* @0x800FE594 */

/* iSNDplatformfree @0x800FE594 : free the SPU block at `ptr`. */
extern void iSNDplatformfree(int ptr)
{
    iSNDpsxfree(ptr);
}

/* ---- removed by the final link ---- */
/* WHICH sdma.obj name: ASPSX writes this member's reference records in hash order, and retail pulls sdmemman.obj (iSNDpsxfree)
 * BEFORE sdma.obj -- that rules out iSNDdmqueue and iSNDdmservice (they sort ahead of iSNDpsxfree) and leaves iSNDdmcallback,
 * iSNDdmqueuesplit, iSNDdmcomplete, iSNDdmtransfer.  The transfer entry is the natural one for an async download. */
extern int iSNDdmtransfer();
LINK_STRIPPED int iSNDplatformasync(int a, int b, int c) { return iSNDdmtransfer(a, b, c); }
