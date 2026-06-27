/* eaclib/psx/eacpsxz/primate.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
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
extern "C" void *reservememadr(char *name, int size, int classid);  /* eacpsxz @0x800E533C (memstd) */
extern "C" int   purgememadr (void *p);                             /* eacpsxz @0x800E5540 (memstd) */
extern "C" void  ClearOTagR(unsigned long *ot, int n);              /* PsyQ libgpu */
extern "C" int   DrawSync(int mode);                                /* PsyQ libgpu */

/* ---- shared GPU draw-list globals (data-materialization pass owns the definitions) ---- */
extern "C" int   maxot;          /* ordering-table length (set to 16 here)        */
extern "C" int   maxprim;        /* primitive capacity                            */
extern "C" char *otbuf;          /* base of the "Draw Lists" allocation           */
extern "C" char *otbl;           /* active OT pointer (== otbuf)                   */
extern "C" char *otbl2;          /* @0x8013DE74 : 2nd OT buffer (otbuf + maxot*4)  */
extern "C" char *primbuf;        /* active primitive buffer (otbuf + maxot*8)      */
extern "C" char *primbase;       /* primitive buffer base                         */
extern "C" char *primbuf2;       /* @0x8013DE88 : 2nd prim buffer (primbuf+52*maxprim) */
extern "C" char *primptr;        /* current primitive write cursor                */
extern "C" char *nextprim;       /* next primitive link target (== otbl)          */
extern "C" int   oti;            /* OT index                                      */
extern "C" int   otp;            /* OT page/parity                                */
extern "C" { int drawpending; }  /* owning-TU tentative def → .comm/.sbss → gp-rel */
extern "C" { int linkmodeflag; } /* owning-TU tentative def → .comm/.sbss → gp-rel */
extern "C" { int semitrans; }    /* owning-TU tentative def → .comm/.sbss → gp-rel */

extern "C" void *initlinkmode(void *unused, int maxprimArg, int linkmode)   /* @0x800F05F4 */
{
    (void)unused;                                  /* 1st arg is unused by the asm */
    maxot   = 16;
    maxprim = maxprimArg;
    if (otbuf != 0)
        purgememadr(otbuf);                        /* free the previous draw-list buffer */

    {
        int size = (13 * maxprim + maxot) << 3;    /* (13*maxprim + maxot) * 8 bytes */
        char *buf = (char *)reservememadr("Draw Lists", size, 0x10);
        otbuf = buf;
        otbl  = buf;
        otbl2     = buf + maxot * 4;               /* @0x8013DE74 second OT (double-buffer) */
        primbuf   = buf + maxot * 8;
        primbase  = primbuf;
        primbuf2  = primbuf + 52 * maxprim;        /* @0x8013DE88 second prim buffer        */
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

extern "C" void waitdraw(void)   /* @0x800F06E0 */
{
    if (drawpending != 0) {
        DrawSync(0);
        drawpending = 0;
    }
}

extern "C" int settrans(int mode)   /* @0x800F070C */
{
    /* oracle: bltz→skip; beqz→1; j(delay li 3)→3 */
    if (mode < 0) goto done;
    if (mode != 0) { semitrans = 3; goto done; }
    semitrans = 1;
done:
    return semitrans >> 1;
}

/* owning-TU def (extern-declared, never defined; link-harness) */
extern "C" { char *otbl2; char *primbuf2; }
