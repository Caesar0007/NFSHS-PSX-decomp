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
extern void *reservememadr(char *name, int size, int classid);  /* eacpsxz @0x800E533C (memstd) */
extern int   purgememadr (void *p);                             /* eacpsxz @0x800E5540 (memstd) */
extern void  ClearOTagR(unsigned long *ot, int n);              /* PsyQ libgpu */
extern int   DrawSync(int mode);                                /* PsyQ libgpu */

/* ---- shared GPU draw-list globals -- this TU OWNS every one of them (nothing else defines
 * them; the oracle reaches ALL of them via %gp_rel(sym) in initlinkmode, which is only possible
 * if THIS module tentative-defines them -> .comm/.sbss -> gp-rel, §3.12 #6). */
 int   maxot;          /* ordering-table length (set to 16 here)        */
 int   maxprim;        /* primitive capacity                            */
 char *otbuf;          /* base of the "Draw Lists" allocation           */
 char *otbl;           /* active OT pointer (== otbuf)                   */
 char *otbl2;          /* @0x8013DE74 : 2nd OT buffer (otbuf + maxot*4)  */
 char *primbuf;        /* active primitive buffer (otbuf + maxot*8)      */
 char *primbase;       /* primitive buffer base                         */
 char *primbuf2;       /* @0x8013DE88 : 2nd prim buffer (primbuf+52*maxprim) */
 char *primptr;        /* current primitive write cursor                */
 char *nextprim;       /* next primitive link target (== otbl)          */
 int   oti;            /* OT index                                      */
 int   otp;            /* OT page/parity                                */
 int drawpending;   /* owning-TU tentative def → .comm/.sbss → gp-rel */
 int linkmodeflag;  /* owning-TU tentative def → .comm/.sbss → gp-rel */
 int semitrans;     /* owning-TU tentative def → .comm/.sbss → gp-rel */

extern void *initlinkmode(void *unused, int maxprimArg, int linkmode)   /* @0x800F05F4 */
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

extern void waitdraw(void)   /* @0x800F06E0 */
{
    if (drawpending != 0) {
        DrawSync(0);
        drawpending = 0;
    }
}

extern int settrans(int mode)   /* @0x800F070C */
{
    /* oracle: bltz→skip; beqz→1; j(delay li 3)→3 */
    if (mode < 0) goto done;
    if (mode != 0) { semitrans = 3; goto done; }
    semitrans = 1;
done:
    return semitrans >> 1;
} 
