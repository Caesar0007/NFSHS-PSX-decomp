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

/* iSNDcalcvol @0x800FF050 : compute a channel's effective 0..0x7F volume from its patch volume (+0x2C),
 *   note velocity (+0x1E), expression (+0x26) and the master volume, then apply the optional velocity
 *   (+0x50) and final (+0x44) volume curves.  Caches the result at +0x2D and returns it. */
extern void iSNDcalcvol(int chan)
{
    int          v = sndgs[0x25] + chan * 100;
    int          n = (int)*(signed char *)(v + 0x2c) * (int)*(short *)(v + 0x1e) *
                     (int)*(short *)(v + 0x26) * (int)((signed char *)sndgs)[0x3d];
    /* VOID (W31): oracle exits `jr ra; nop` with nothing computed into $v0 -- the cached byte at
     * +0x2D is the only output and no caller consumes a result.  The old "v1-not-v0 coloring floor"
     * was the reserved-return symptom (3.2): dropping the return frees $v0 and the whole velocity-
     * curve block colors itself. */
    n = n / 0x1f417f;
    *(char *)(v + 0x2d) = (char)n;
    if (*(int *)(v + 0x50) != 0) {                  /* velocity curve */
        *(char *)(v + 0x2d) = (char)(((n * 0x1000000 >> 0x18) *
               (int)*(signed char *)(*(int *)(v + 0x50) + (unsigned)*(unsigned char *)(v + 0x3a))) / 0x7f);
    }
    if (*(int *)(v + 0x44) != 0) {                  /* final volume curve */
        *(unsigned char *)(v + 0x2d) =
            *(unsigned char *)(*(int *)(v + 0x44) + (int)*(signed char *)(v + 0x2d));
    }
}

/* iSNDpsxkeyon @0x800FF140 : strobe the SPU key-on register for `mask` (24 voices). */
extern int iSNDpsxkeyon(int mask)
{
    int *base = (int *)sndpd;
    int r;
    *(volatile short *)(base[0x514/4] + 0x188) = (short)mask;
    r = base[0x514/4];
    *(volatile short *)(r + 0x18a) = (short)(mask >> 0x10);
    return r;
}

/* iSNDpsxkeyoff @0x800FF168 : strobe the SPU key-off register for `mask`. */
extern int iSNDpsxkeyoff(int mask)
{
    int *base = (int *)sndpd;
    int r;
    *(volatile short *)(base[0x514/4] + 0x18c) = (short)mask;
    r = base[0x514/4];
    *(volatile short *)(r + 0x18e) = (short)(mask >> 0x10);
    return r;
}

/* iSNDpsxeffecton @0x800FF190 : enable reverb on the `mask` voices (OR into the SPU echo-on register). */
extern unsigned int iSNDpsxeffecton(int mask)
{
    int *base = (int *)sndpd;
    unsigned int r;
    int          c0 = base[0x514/4];
    *(volatile unsigned short *)(c0 + 0x198) = *(volatile unsigned short *)(c0 + 0x198) | (unsigned short)mask;
    {
        int c1 = base[0x514/4];
        r = (unsigned int)*(volatile unsigned short *)(c1 + 0x19a) | (mask >> 0x10);
        *(volatile short *)(c1 + 0x19a) = (short)r;
    }
    return r;
}

/* iSNDpsxeffectoff @0x800FF1D0 : disable reverb on the `mask` voices. */
extern unsigned int iSNDpsxeffectoff(int mask)
{
    int *base = (int *)sndpd;
    unsigned int r;
    int          c0 = base[0x514/4];
    *(volatile unsigned short *)(c0 + 0x198) = *(volatile unsigned short *)(c0 + 0x198) & ~(unsigned short)mask;
    {
        int c1 = base[0x514/4];
        r = (unsigned int)*(volatile unsigned short *)(c1 + 0x19a) & ~(mask >> 0x10);
        *(volatile short *)(c1 + 0x19a) = (short)r;
    }
    return r;
}

/* iSNDpsxeffectvol @0x800FF210 : set the SPU reverb (echo) L/R output volume. */
extern int iSNDpsxeffectvol(int left, int right)
{
    int *base = (int *)sndpd;
    int r;
    *(volatile short *)(base[0x514/4] + 0x184) = (short)left;
    r = base[0x514/4];
    *(volatile short *)(r + 0x186) = (short)right;
    return r;
}

/* iSNDsetvol @0x800FF238 : write a channel's SPU voice L/R volume from logical (left,right) levels,
 *   panning per the routing mode (mono spread vs hard L/R) and output mode (mono/stereo).
 *   VOID (W31): no caller consumes a result and the oracle's exit `$v0` holds the UNMASKED
 *   `(sum*0x81)>>1` scratch on the mono paths (no C `return` could produce that) -- the declared
 *   return value was the 4 extra insns (`addu v0,x,zero` funnels).  One `vol` + one reused `vreg`
 *   carry the a0/a3 webs through the shared tail. */
extern void iSNDsetvol(int chan, int left, int right)
{
    int            vt = chan * 0x2c;
    volatile unsigned char *voiceBase = sndpd + 0xd8;
    volatile unsigned char *slot = voiceBase + vt;
    unsigned char  *pd = (unsigned char *)voiceBase - 0xd8;
    int            voiceRegs = *(int *)(pd + 0x510);
    unsigned short *vreg = (unsigned short *)(voiceRegs + chan * 0x10);
    int            vol;

    chan = slot[0x1f];

    if (chan == 1) {                                /* single channel */
        int sum;
        if ((char)sndgs[4] == 2) {                  /* stereo output */
            *vreg   = left * 0x81 & 0x7fff;
            vreg[1] = right * 0x81 & 0x7fff;
            return;
        }
        sum = left + right;
        if (*(unsigned char *)((unsigned char *)slot + 0x1e) == chan) { /* L/R-spread routing */
            if (left < 0)  left = -left;
            if (right < 0) right = -right;
            if (0x7f < left)  left = 0x7f;
            if (0x7f < right) right = 0x7f;
            sum = left + right;
        }
        vol = (sum * 0x81 >> 1) & 0x7fff;
    } else {                                        /* linked pair */
        if ((char)sndgs[4] == 2) {
            *vreg   = left * 0x81 & 0x7fff;
            vreg[1] = 0;
            vreg = (unsigned short *)(*(int *)(pd + 0x510) +
                    ((int)((unsigned)slot[0x20] << 0x18) >> 0x14));
            *vreg   = 0;
            vreg[1] = right * 0x81 & 0x7fff;
            return;
        }
        vol = (left * 0x81 >> 1) & 0x7fff;
        *vreg   = vol;
        vreg[1] = vol;
        vol = (right * 0x81 >> 1) & 0x7fff;
        vreg = (unsigned short *)(*(int *)(pd + 0x510) +
                ((int)((unsigned)slot[0x20] << 0x18) >> 0x14));
    }
    *vreg   = vol;
    vreg[1] = vol;
}

/* iSNDsetslot @0x800FF394 : program a channel's SPU voice ADSR + pitch slot (attack/decay rate, start
 *   address, sample rate). */
/* MATCH: reconstructing DAT_80147e28 as its true one-word array storage fixes address
 * materialization.  Listing the two variable stores before the constant ADSR stores gives gcc the
 * oracle's early `sra`/base-load schedule; it still emits the hardware writes in oracle order
 * (attack, sustain, pitch, address, level). */
extern int iSNDsetslot(int chan, int addr, int pitch)
{
    int r = DAT_80147e28[0] + chan * 0x10;
    *(short *)(r + 4)  = (short)pitch;               /* sample rate / pitch */
    *(short *)(r + 6)  = (short)(addr >> 3);         /* SPU start address (8-byte units) */
    *(short *)(r + 8)  = 0xf;                        /* ADSR attack */
    *(short *)(r + 10) = 5;                          /* ADSR sustain/release */
    *(short *)(r + 0xe) = 0x200;                     /* ADSR sustain level */
    return r;
}

/* iSNDstartvoice @0x800FF3CC : key a channel's voice (and its linked partner) -- reset pan caches, arm the
 *   ADSR slot, set the initial volume + fx level, and return the SPU key-on mask. */
extern unsigned int iSNDstartvoice(unsigned int chan)
{
    int          vt  = chan * 0x2c;
    volatile unsigned char *vte = sndpd + 0xd8 + vt; /* &voicetable[chan] */
    volatile unsigned char *voiceBase = sndpd + 0xd8;
    /* 441 Hz units; cc1psx lowers the unsigned divide to multu 0x4A4DC96F + mfhi >> 7. */
    int          pitch;
    unsigned int mask;

    vte[0x24] = 0;
    vte[0x25] = 0;
    pitch = (int)(*(volatile unsigned int *)(vte + 8) / 441u);
    iSNDsetslot((int)chan, *(volatile int *)vte, pitch); /* +0x00 SPU start address / tag */
    mask = 1u << (chan);
    vte[0x1c] = 2;
    vte[0x1d] = 2;
    vte[0x26] = 0;
    if (vte[0x1f] == 2) {                            /* linked pair -> arm the partner too */
        signed char link = (signed char)vte[0x20];
        signed char maskLink;
        int         vt2  = link * 0x2c;
        volatile unsigned char *vte2 = voiceBase + vt2;
        int         a3;                              /* linked-partner start-addr offset (oracle 0x800FF468-50C) */
        if (0 <= (int)((unsigned int)vte[0x27] << 24)) { /* bit7 clear: ptr table at base+0x420 indexed by f27 */
            int f27x4 = ((int)((unsigned int)vte[0x27] << 24)) >> 22;
            volatile unsigned char *table = voiceBase + 0x420;
            int *pt = *(int **)(table + f27x4);
            a3 = *(int *)((char *)pt + 8);
        } else {                                     /* bit7 set: index from +0x04 via 1/0x1c reciprocal */
            unsigned int checkNumerator;
            a3 = (int)(*(volatile unsigned int *)((unsigned char *)vte + 4) / 0x1c);
            checkNumerator = *(volatile unsigned int *)((unsigned char *)vte + 4);
            if ((int)checkNumerator != (int)((checkNumerator / 0x1c) * 0x1c))
                a3 = a3 + 1;
            a3 = a3 << 4;
        }
        iSNDsetslot(((int)((unsigned int)vte[0x20] << 24)) >> 24,
                    *(volatile int *)vte + a3, pitch);
        maskLink = (signed char)vte[0x20];
        vte2[0x1c] = 2;
        vte2[0x1d] = 2;
        vte2[0x26] = 0;
        mask = mask | (1u << (int)maskLink);
    }
    iSNDvol((int)chan, (int)(signed char)vte[0x22]);
    iSNDplatformfxlevel(chan, 0, (int)(signed char)vte[0x23]);
    return mask;
}
