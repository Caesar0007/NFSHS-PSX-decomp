/* eaclib/psx/sndpsxz/spatkey.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 7/10 PASS ***
 *   Source obj : nfs4\eaclib\psx\spatkey.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   10 fns @[0x800FEF4C .. 0x800FF3CC].  SPU key/voice/volume control -- the bottom-level poke layer for
 *   the channel pool (volume calc, panning, SPU key-on/off + reverb-effect registers).
 *   Ghidra nfs4-f.exe.c L164056..164366 + disasm-v3 L329894+ (for the dropped setvol/setslot args).
 *
 *   SPU register bases (set by iSNDinit): DAT_80147e28 = voice L/R-vol regs (chan*0x10), DAT_80147e2c =
 *   SPU control regs (key-on @+0x188, key-off @+0x18C, reverb-on @+0x198, reverb-vol @+0x184).
 *   Packet-voice table @0x801479F0 (0x2c stride): +0x1c playstate, +0x1e routing mode, +0x1f channels,
 *   +0x20 linked voice, +0x22 fx send, +0x24/0x25 L/R cache, +0x26 flag.
 */
/* W85-S8 VOLATILE AUDIT (2026-09-02): the `volatile` qualifiers on 20, 109, 120, 131, 146, 161 (`SNDPD_VOICEREG` and the five `int *base = (int *)sndpd` driver-state bases; the SPU-register accesses THROUGH them keep their volatile)
 * were REMOVED -- plain main-RAM driver state, not MMIO and not IRQ-mutated; removal is
 * gate-neutral (whole-TU verify_asm/tugate PASS before and after).  Every REMAINING
 * `volatile` in this file was measured individually or as a group and is load-bearing
 * (MMIO, or state the oracle provably re-reads) -- do not strip them.  Receipt:
 * scratchpad/w85/S8_receipt.md. */


extern int sndgs[];
extern unsigned char sndpd[];   /* EA sound-driver state base @0x80147918 (unsized array: forces
                                     * the oracle's `lui;addiu &sndpd; lw r,0x514(base)` base+offset shape
                                     * instead of folding &sndpd+const into one absolute %lo load) */
/* SPU register-base pointers live as fields inside the sndpd state block:
 *   DAT_80147e28 (voice regs)   = *(int*)(sndpd + 0x510)
 *   DAT_80147e2c (control regs) = *(int*)(sndpd + 0x514) */
#define SNDPD_VOICEREG   (((int *)sndpd)[0x510/4])
extern int DAT_80147e28[];      /* one-word SPU voice register base storage */
extern int DAT_801479f0;        /* packet-voice table base; entry +0x00 = SPU start addr, +0x04 idx src, +0x08 sample-rate src */
/* packet-voice table fields (0x2c stride, indexed [chan*0x2c]) */
extern unsigned char DAT_80147a0c;   /* +0x1c playstate */
extern unsigned char DAT_80147a0d;   /* +0x1d           */
extern unsigned char DAT_80147a0e;   /* +0x1e routing mode */
extern unsigned char DAT_80147a0f;   /* +0x1f channel count */
extern unsigned char DAT_80147a10;   /* +0x20 linked voice */
extern unsigned char DAT_80147a12;   /* +0x22 fx send level */
extern unsigned char DAT_80147a14;   /* +0x24 L cache */
extern unsigned char DAT_80147a15;   /* +0x25 R cache */
extern unsigned char DAT_80147a16;   /* +0x26 flag */
extern unsigned char DAT_80147a17;   /* +0x27 partner-addr mode (bit7) / table index */

extern void iSNDvol(int chan, int level);            /* sdriver */
extern int iSNDplatformfxlevel(unsigned int chan, int bus, int fxon);

extern int iSNDsetslot(int chan, int addr, int pitch);   /* @0x800FF394 */

#define SB(base,idx) ((&(base))[idx])              /* (&DAT)[idx] -- byte at base+idx */

/* iSNDpatchkey @0x800FEF4C : iterate the voices keyed to a channel group.  For a standalone channel,
 *   hands back `chan` once; for a group, walks the pool returning each held member.  `tag` points at a
 *   cursor (init -1).  Returns 1 while voices remain, 0 when exhausted. */
extern int iSNDpatchkey(int chan, int tag)
{
    int pbase = sndgs[0x25];
    char grp;
    pbase += chan * 100;
    grp = *(char *)(pbase + 0x37);
    if (grp != 0) {
        int i = *(int *)tag;
        *(int *)tag = i + 1;
        if (i + 1 < (int)(unsigned)((unsigned char *)sndgs)[0x11]) {
            int *gs = sndgs;
            do {
                int *p = (int *)(gs[0x25] + *(int *)tag * 100);
                if (*(char *)((int)p + 0x37) == grp && *(signed char *)((int)p + 0xb) == 1 && -1 < *p)
                    return 1;
                *(int *)tag = *(int *)tag + 1;
            } while (*(int *)tag < (int)(unsigned)((unsigned char *)gs)[0x11]);
        }
        goto no_key;
    }
    if (*(int *)tag >= 0)
        goto no_key;
    *(int *)tag = chan;
    return 1;
no_key:
    return 0;
    /* near-miss floor (31 diffs, was 43 -- landed 2 real bugs: block-order INVERSION [grp!=0 is the
     * oracle's fall-through main path, grp==0 branches away to code at the function's END -- the
     * source had them swapped] and a signed-char bug [*(char*)(p+0xb)==1 must be `signed char`, not
     * the platform's unsigned `char`]. Residual = an extra `&sndgs` re-materialization (`lui a2,0` +
     * a spurious reg-reg move) for the byte-indexed count check `((unsigned char*)sndgs)[0x11]`
     * alongside the int-indexed `sndgs[0x25]` base -- tried unifying both through one shared
     * `unsigned char *g = (unsigned char*)sndgs;` base pointer, which REGRESSED 31->33 (worse
     * coloring elsewhere), reverted. Allocator floor across the two typed views; permuter
     * candidate. */
}

/* iSNDcalcvol .. iSNDstartvoice (0x800FF050..0x800FF5A8) are NOT in this object: they open slib.obj (2026-09-21).
 * Retail pulls spatkey.obj for span.obj's `iSNDpatchkey`, then slib.obj, then sdriver.obj for svol.obj's `iSNDvol` -- and the
 * only thing svol.obj asks for in between is `iSNDcalcvol`.  The code is contiguous, so the text layout cannot tell; the pull
 * order does (tools/psyq_pipe/slink_pullsim.py). */
