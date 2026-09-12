/* eaclib/psx/eacpsxz/primate.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\primate.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   3 fns: initlinkmode@0x800F05F4, waitdraw@0x800F06E0, settrans@0x800F070C.
 *   FULL reconstruction (disasm-v3 MIPS); NOT stubs.  EA GPU "primitive" / ordering-table front end.
 *
 *   initlinkmode allocates the per-frame draw-list buffer ("Draw Lists") that holds the double-buffered
 *   ordering table (OT) and primitive scratch, and resets the draw cursors.  Layout of the one buffer:
 *       [0 .. maxot*8)             OT region (2 OTs of maxot u_longs each; 2nd OT @ +maxot*4)
 *       [maxot*8 .. +13*maxprim*8) primitive region (2 prim buffers of 52*maxprim bytes; 2nd @ +52*maxprim)
 *   total = (13*maxprim + maxot) * 8 bytes, allocated via reservememadr(class 0x10).  maxot is fixed 16.
 *   waitdraw blocks (DrawSync) until any pending draw finishes.  settrans sets/queries the semi-
 *   transparency mode (>0 -> 3, ==0 -> 1, <0 -> query only), returning the mode bit (semitrans>>1).
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "memstd.h"

// FIXME
extern void ClearOTagR(unsigned long *ot, int n);              /* PsyQ libgpu */
extern int  DrawSync(int mode);                                /* PsyQ libgpu */

/* P904: native MAP and CPE load8013DD04..8013DD18 prove this initialized
 * small-data run, including semitrans=1. Public source definitions replace
 * the former private zero-filled copies and the duplicate raw oracle cells.
 * Compact SYM preserves these names but no typed Def/Def2 records: existing
 * char-pointer/int spellings remain inferred, not recovered declarations.
 * Evidence/backups: scratchpad/p904_primate_native, p904_checkpoint. */
char *otbuf = 0;       /* @0x8013DD04: base of the "Draw Lists" allocation */
char *primbuf = 0;     /* @0x8013DD08: primitive allocation region */
int linkmodeflag = 0;  /* @0x8013DD0C */
int drawpending = 0;   /* @0x8013DD10 */
int semitrans = 1;     /* @0x8013DD14 */

/* P905: MAP orders this zero-initialized SBSS run; CPE has no load here.
 * Ordinary tentative definitions emit public .comm declarations in this
 * order. The owner-specific assembler option preserves their public binding
 * during SBSS lowering; the linker selects exactly this40-byte source run.
 * All producer/consumer references share one backing store. No source asm,
 * storage attribute or linker-only replacement variable is needed.
 * Original declaration tokens/order are not uniquely recoverable from MAP;
 * these types remain inferred, and both unnamed slots remain open below. */
int oti;              /* @0x8013DE68: OT index */
int otp;              /* @0x8013DE6C: OT page/parity */
char *otbl;           /* @0x8013DE70: active OT pointer */
/* SYM-GLOBAL-CARRIER: otbl2 -- raw four-byte slot, original name/shape unknown. */
char *otbl2;          /* @0x8013DE74: second OT buffer */
char *nextprim;       /* @0x8013DE78: next primitive link target */
int maxot;            /* @0x8013DE7C: ordering-table length */
char *primptr;        /* @0x8013DE80: current primitive write cursor */
char *primbase;       /* @0x8013DE84: primitive buffer base */
/* SYM-GLOBAL-CARRIER: primbuf2 -- raw four-byte slot, original name/shape unknown. */
char *primbuf2;       /* @0x8013DE88: second primitive buffer */
int maxprim;          /* @0x8013DE8C: primitive capacity */
#include "primate.h"

void *initlinkmode(void *unused, int maxprimArg, int linkmode)   /* @0x800F05F4 */
{
    (void)unused;                                  /* 1st arg is unused by the asm */
    maxot   = 16;
    maxprim = maxprimArg;
    if (otbuf != 0)
        purgememadr(otbuf);                        /* free the previous draw-list buffer */

    {
        /* MATCH: the SIZE math reloads `maxprim`/`maxot` fresh off the gp-rel globals (the
         * oracle does too -- v0/v1 reloads, not the param registers), but primbuf2's 52*N
         * term uses the PARAMETER `maxprimArg`, which stays live in the callee-saved $s0
         * across the reservememadr() call (that cross-call liveness is what forces $s0 to be
         * saved, matching the oracle's +8 frame). */
        int size = (13 * maxprim + maxot) << 3;    /* (13*maxprim + maxot) * 8 bytes */
        char *buf = (char *)reservememadr("Draw Lists", size, 0x10);
        otbuf = buf;
        otbl  = buf;
        primbuf   = buf + maxot * 8;
        otbl2     = buf + maxot * 4;               /* @0x8013DE74 second OT (double-buffer) */
        primbase  = primbuf;
        primbuf2  = primbuf + 52 * maxprimArg;     /* @0x8013DE88 second prim buffer        */
        ClearOTagR((unsigned long *)otbl, maxot);
        linkmodeflag = linkmode;
        oti = 0;
        otp = 0;
        drawpending = 0;
        primptr  = primbuf;
        nextprim = otbl;
    }
    return otbuf;
}

void waitdraw(void)   /* @0x800F06E0 */
{
    if (drawpending != 0) {
        DrawSync(0);
        drawpending = 0;
    }
}

int settrans(int mode)   /* @0x800F070C */
{
    /* oracle: bltz→skip; beqz→1; j(delay li 3)→3 */
    if (mode < 0) goto done;
    if (mode != 0) { semitrans = 3; goto done; }
    semitrans = 1;
done:
    return semitrans >> 1;
} 
