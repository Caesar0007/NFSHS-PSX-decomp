/* eaclib/psx/sndpsxz/spatkey.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 10/10 ***
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

extern int sndgs[];
extern unsigned char sndpd[];   /* EA sound-driver state base @0x80147918 (unsized array: forces
                                     * the oracle's `lui;addiu &sndpd; lw r,0x514(base)` base+offset shape
                                     * instead of folding &sndpd+const into one absolute %lo load) */
/* SPU register-base pointers live as fields inside the sndpd state block:
 *   DAT_80147e28 (voice regs)   = *(int*)(sndpd + 0x510)
 *   DAT_80147e2c (control regs) = *(int*)(sndpd + 0x514) */
#define SNDPD_VOICEREG   (((volatile int *)sndpd)[0x510/4])
#define SNDPD_CTRLREG    (((volatile int *)sndpd)[0x514/4])
extern int DAT_80147e28;        /* SPU voice register base (address)   */
extern int DAT_80147e2c;        /* SPU control register base (address) */
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
extern void iSNDplatformfxlevel(int chan);

extern int iSNDsetslot(int chan, int addr, int pitch);   /* @0x800FF394 */

#define SB(base,idx) ((&(base))[idx])              /* (&DAT)[idx] -- byte at base+idx */

/* iSNDpatchkey @0x800FEF4C : iterate the voices keyed to a channel group.  For a standalone channel,
 *   hands back `chan` once; for a group, walks the pool returning each held member.  `tag` points at a
 *   cursor (init -1).  Returns 1 while voices remain, 0 when exhausted. */
extern int iSNDpatchkey(int chan, int tag)
{
    char grp = *(char *)(sndgs[0x25] + chan * 100 + 0x37);
    if (grp == 0) {
        if (*(int *)tag < 0) {
            *(int *)tag = chan;
            return 1;
        }
    } else {
        int i = *(int *)tag;
        *(int *)tag = i + 1;
        if (i + 1 < (int)(unsigned)((unsigned char *)sndgs)[0x11]) {
            do {
                int *p = (int *)(sndgs[0x25] + *(int *)tag * 100);
                if (*(char *)((int)p + 0x37) == grp && *(char *)((int)p + 0xb) == 1 && -1 < *p)
                    return 1;
                i = *(int *)tag;
                *(int *)tag = i + 1;
            } while (i + 1 < (int)(unsigned)((unsigned char *)sndgs)[0x11]);
        }
    }
    return 0;
}

/* iSNDcalcvol @0x800FF050 : compute a channel's effective 0..0x7F volume from its patch volume (+0x2C),
 *   note velocity (+0x1E), expression (+0x26) and the master volume, then apply the optional velocity
 *   (+0x50) and final (+0x44) volume curves.  Caches the result at +0x2D and returns it. */
extern unsigned int iSNDcalcvol(int chan)
{
    int          v = sndgs[0x25] + chan * 100;
    int          n = (int)*(char *)(v + 0x2c) * (int)*(short *)(v + 0x1e) *
                     (int)*(short *)(v + 0x26) * (int)((signed char *)sndgs)[0x3d];
    unsigned int vol = n >> 0x1f;
    n = n / 0x1f417f;
    *(char *)(v + 0x2d) = (char)n;
    if (*(int *)(v + 0x50) != 0) {                  /* velocity curve */
        vol = ((n * 0x1000000 >> 0x18) *
               (int)*(char *)(*(int *)(v + 0x50) + (unsigned)*(unsigned char *)(v + 0x3a))) / 0x7f;
        *(char *)(v + 0x2d) = (char)vol;
    }
    if (*(int *)(v + 0x44) != 0) {                  /* final volume curve */
        unsigned char b = *(unsigned char *)(*(int *)(v + 0x44) + (int)*(char *)(v + 0x2d));
        vol = (unsigned int)b;
        *(unsigned char *)(v + 0x2d) = b;
    }
    return vol;
}

/* iSNDpsxkeyon @0x800FF140 : strobe the SPU key-on register for `mask` (24 voices). */
extern int iSNDpsxkeyon(int mask)
{
    volatile int *base = (volatile int *)sndpd;
    int r;
    *(volatile short *)(base[0x514/4] + 0x188) = (short)mask;
    r = base[0x514/4];
    *(volatile short *)(r + 0x18a) = (short)(mask >> 0x10);
    return r;
}

/* iSNDpsxkeyoff @0x800FF168 : strobe the SPU key-off register for `mask`. */
extern int iSNDpsxkeyoff(int mask)
{
    volatile int *base = (volatile int *)sndpd;
    int r;
    *(volatile short *)(base[0x514/4] + 0x18c) = (short)mask;
    r = base[0x514/4];
    *(volatile short *)(r + 0x18e) = (short)(mask >> 0x10);
    return r;
}

/* iSNDpsxeffecton @0x800FF190 : enable reverb on the `mask` voices (OR into the SPU echo-on register). */
extern unsigned int iSNDpsxeffecton(int mask)
{
    volatile int *base = (volatile int *)sndpd;
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
    volatile int *base = (volatile int *)sndpd;
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
    volatile int *base = (volatile int *)sndpd;
    int r;
    *(volatile short *)(base[0x514/4] + 0x184) = (short)left;
    r = base[0x514/4];
    *(volatile short *)(r + 0x186) = (short)right;
    return r;
}

/* iSNDsetvol @0x800FF238 : write a channel's SPU voice L/R volume from logical (left,right) levels,
 *   panning per the routing mode (mono spread vs hard L/R) and output mode (mono/stereo). */
extern unsigned int iSNDsetvol(int chan, int left, int right)
{
    int            vt = chan * 0x2c;
    unsigned short *vreg = (unsigned short *)(DAT_80147e28 + chan * 0x10);
    unsigned int   v;
    unsigned short u;

    if (SB(DAT_80147a0f, vt) == 1) {                /* single channel */
        if ((char)sndgs[4] == 2) {                  /* stereo output */
            *vreg = (short)left * 0x81 & 0x7fff;
            v = right * 0x81 & 0x7fff;
            vreg[1] = (unsigned short)v;
            return v;
        }
        {
            int sum = left + right;
            if (SB(DAT_80147a0e, vt) == 1) {        /* L/R-spread routing */
                if (left < 0)  left = -left;
                if (right < 0) right = -right;
                if (0x7f < left)  left = 0x7f;
                sum = left + right;
                if (0x7f < right) sum = left + 0x7f;
            }
            v = sum * 0x81 >> 1;
            u = (unsigned short)v;
        }
    } else {                                        /* linked pair */
        if ((char)sndgs[4] == 2) {
            unsigned short *vreg2;
            *vreg = (short)left * 0x81 & 0x7fff;
            vreg[1] = 0;
            vreg2 = (unsigned short *)(DAT_80147e28 + ((int)((unsigned)SB(DAT_80147a10, vt) << 0x18) >> 0x14));
            v = right * 0x81 & 0x7fff;
            *vreg2 = 0;
            vreg2[1] = (short)v;
            return v;
        }
        u = (unsigned short)(left * 0x81 >> 1) & 0x7fff;
        *vreg = u;
        vreg[1] = u;
        u = (unsigned short)(right * 0x81 >> 1);
        vreg = (unsigned short *)(DAT_80147e28 + ((int)((unsigned)SB(DAT_80147a10, vt) << 0x18) >> 0x14));
        v = DAT_80147e28;
    }
    *vreg = u & 0x7fff;
    vreg[1] = u & 0x7fff;
    return v;
}

/* iSNDsetslot @0x800FF394 : program a channel's SPU voice ADSR + pitch slot (attack/decay rate, start
 *   address, sample rate). */
/* near-miss floor (6 diffs): oracle's `lui;sll(chan*0x10);sra(addr>>3);lw` interleaves the two
 * independent shifts INTO the DAT_80147e28 lui/lw pair's gap; our gcc-2.8.0 emits the lui+lw
 * back-to-back and both shifts after. Tried: pre-computing addr>>3/chan*0x10 as named locals
 * (before/after/either order), in-place mutation of the params -- all reproduce this identical
 * schedule. Pure RTL instruction-scheduling choice, not source-reachable; permuter candidate. */
extern int iSNDsetslot(int chan, int addr, int pitch)
{
    int r = DAT_80147e28 + chan * 0x10;
    *(short *)(r + 8)  = 0xf;                        /* ADSR attack */
    *(short *)(r + 10) = 5;                          /* ADSR sustain/release */
    *(short *)(r + 4)  = (short)pitch;               /* sample rate / pitch */
    *(short *)(r + 6)  = (short)(addr >> 3);         /* SPU start address (8-byte units) */
    *(short *)(r + 0xe) = 0x200;                     /* ADSR sustain level */
    return r;
}

/* iSNDstartvoice @0x800FF3CC : key a channel's voice (and its linked partner) -- reset pan caches, arm the
 *   ADSR slot, set the initial volume + fx level, and return the SPU key-on mask. */
extern unsigned int iSNDstartvoice(unsigned int chan)
{
    int          vt  = chan * 0x2c;
    char        *vte = (char *)&DAT_801479f0 + vt;   /* &voicetable[chan] */
    int          f0  = *(int *)vte;                  /* +0x00 SPU start address / tag */
    /* H08: pitch = MULT_HI((uint)voicetable[chan].+0x08, 0x4A4DC96F) >> 7 (oracle 0x800FF41C-434); shared by both calls */
    int          pitch = (int)((unsigned int)(((unsigned long long)(unsigned int)*(int *)(vte + 8) * 0x4A4DC96FuLL) >> 32) >> 7);
    unsigned int mask;

    SB(DAT_80147a14, vt) = 0;
    SB(DAT_80147a15, vt) = 0;
    iSNDsetslot((int)chan, f0, pitch);               /* H08: was (chan,0,0) -> addr+pitch were zeroed (oracle 0x800FF438) */
    mask = 1u << (chan);
    SB(DAT_80147a0c, vt) = 2;
    SB(DAT_80147a0d, vt) = 2;
    SB(DAT_80147a16, vt) = 0;
    if (SB(DAT_80147a0f, vt) == 2) {                 /* linked pair -> arm the partner too */
        char        link = (char)SB(DAT_80147a10, vt);
        int         vt2  = link * 0x2c;
        signed char f27  = (signed char)SB(DAT_80147a17, vt);   /* +0x27 partner-addr mode */
        int         a3;                              /* linked-partner start-addr offset (oracle 0x800FF468-50C) */
        if (f27 < 0) {                               /* bit7 set: index from +0x04 via 1/0x1c reciprocal (oracle 0x800FF4C8-50C) */
            int          f4 = *(int *)(vte + 4);
            unsigned int q  = (unsigned int)(((unsigned long long)((unsigned int)f4 >> 2) * 0x24924925uLL) >> 32);
            a3 = (int)q;
            if (f4 != (int)(q * 0x1c)) a3 = a3 + 1;  /* round up to the 0x1c stride */
            a3 = a3 << 4;
        } else {                                     /* bit7 clear: ptr table at base+0x420 indexed by f27 (oracle 0x800FF4A0-BC) */
            int *pt = *(int **)((char *)&DAT_801479f0 + (int)f27 * 4 + 0x420);
            a3 = *(int *)((char *)pt + 8);
        }
        iSNDsetslot((int)link, f0 + a3, pitch);      /* H08: was (link,0,0); addr = f0 + a3 (oracle 0x800FF524/528) */
        SB(DAT_80147a0c, vt2) = 2;
        SB(DAT_80147a0d, vt2) = 2;
        SB(DAT_80147a16, vt2) = 0;
        mask = mask | (1u << ((int)link));
    }
    iSNDvol((int)chan, (int)(char)SB(DAT_80147a12, vt));
    iSNDplatformfxlevel(chan);
    return mask;
}
