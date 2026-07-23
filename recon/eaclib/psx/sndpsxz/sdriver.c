/* eaclib/psx/sndpsxz/sdriver.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 PASS ***
 *   Source obj : nfs4\eaclib\psx\sdriver.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800FFE90 .. 0x801000F8].  The platform (PSX) sound-driver back-end: the four entry points
 *   the channel layer pokes to actually start/stop/pitch/volume a hardware voice.
 *   Ghidra nfs4-f.exe.c (sdriver) + disasm-v3 L<800FFE90+> -- AUTHORITATIVE for the args Ghidra dropped:
 *     iSNDvol's 2nd param is the LEVEL (Ghidra called it "chan"); iSNDatolrv is 4-arg, iSNDatodlrv 6-arg,
 *     iSNDsetvol 3-arg; iSNDplatformpitch 2-arg; iSNDplatformfxlevel 3-arg (chan,bus,fxon) -- Ghidra
 *     dropped to 1 visible arg + `in_a2`; IDA sig (a1,a2,a3) confirms 3 (a1=bus is unused/overwritten).
 *
 *   Packet-voice table @0x801479F0 (0x2c stride, indexed [chan*0x2c] for bytes / [chan*0xb] for ints):
 *     int  +0x08 (DAT_801479f8) hw pitch/rate    u16 +0x18 (DAT_80147a08) volume angle/pan
 *     u16  +0x1a (DAT_80147a0a) base pitch        b  +0x1c (DAT_80147a0c) playstate (2 == playing)
 *     b    +0x1d (DAT_80147a0d) substate          b  +0x1e (DAT_80147a0e) volume routing mode
 *     b    +0x1f (DAT_80147a0f) channel count     b  +0x20 (DAT_80147a10) linked voice index
 *     b    +0x22 (DAT_80147a12) cached level      b  +0x23 (DAT_80147a13) cached fx level
 *     b    +0x24/+0x25 (DAT_80147a14/15) L/R out  b  +0x27 (DAT_80147a17) voice-done flag (bit7)
 *     b    +0x28 (DAT_80147a18) pitch-dirty flag
 */

/* --- packet-voice table fields (0x2c stride) --- */
extern int           DAT_801479f8;     /* +0x08 hw pitch/rate (int view: [chan*0xb]) */
extern char          DAT_801479f0;     /* +0x00 voice-table base (byte, for hook arg)  */
extern unsigned char DAT_80147a08;     /* +0x18 volume angle/pan (u16) */
extern unsigned char DAT_80147a0a;     /* +0x1a base pitch (u16)       */
extern unsigned char DAT_80147a0c;     /* +0x1c playstate              */
extern unsigned char DAT_80147a0d;     /* +0x1d substate               */
extern unsigned char DAT_80147a0e;     /* +0x1e volume routing mode    */
extern unsigned char DAT_80147a0f;     /* +0x1f channel count          */
extern unsigned char DAT_80147a10;     /* +0x20 linked voice index     */
extern unsigned char DAT_80147a12;     /* +0x22 cached level           */
extern unsigned char DAT_80147a13;     /* +0x23 cached fx level        */
extern unsigned char DAT_80147a14;     /* +0x24 L out cache            */
extern unsigned char DAT_80147a15;     /* +0x25 R out cache            */
extern unsigned char DAT_80147a17;     /* +0x27 voice-done flag (bit7) */
extern unsigned char DAT_80147a18;     /* +0x28 pitch-dirty flag       */
extern unsigned char sndpd[];          /* driver-state base; voice table starts at +0xd8 */

/* "voice has finished" notifier installed by the host (@0x8014803C) */
extern void (*snd_voice_done_hook)(void *voice);

/* dependencies in sibling objs */
extern void         iSNDfreechan(int chan);                       /* salloc  */
extern int          iSNDpsxkeyoff(int mask);                      /* spatkey */
extern unsigned int iSNDpsxeffecton(int mask);                    /* spatkey */
extern unsigned int iSNDpsxeffectoff(int mask);                   /* spatkey */
extern unsigned int iSNDsetvol(int chan, int left, int right);    /* spatkey */
extern void iSNDatolrv(unsigned int pan, int level, int *outL, int *outR);                 /* saetolrv */
extern void iSNDatodlrv(unsigned int pan, int level, int *outL, int *outR, int pL, int pR);/* saetodv  */

extern int iSNDstop(unsigned int chan);                           /* @0x800FFE90 */
extern int iSNDvol(int chan, int level);                          /* @0x801000F8 */

/* iSNDstop @0x800FFE90 : silence a hardware voice (and its linked partner).  Fires the voice-done hook
 *   unless already flagged, releases the channel(s) back to the pool, marks them idle and strobes the SPU
 *   key-off for the combined voice mask. */
extern int iSNDstop(unsigned int chan)
{
    int vt = (int)chan * 0x2c;
    volatile unsigned char *base = sndpd + 0xd8;
    volatile unsigned char *slot = base + vt;
    unsigned int mask;

    if (0 <= (int)((unsigned int)slot[0x27] << 24))            /* voice-done bit clear -> notify */
        (*(void (**)(void *))(base + 0x64c))((void *)slot);
    iSNDfreechan((int)chan);
    slot[0x1d] = 3;
    slot[0x1c] = 0;
    mask = 1u << chan;
    if (1 < slot[0x1f]) {                                     /* linked pair -> stop the partner too */
        chan = (int)(signed char)slot[0x20];
        iSNDfreechan((int)chan);
        slot = base + (int)chan * 0x2c;
        mask |= 1u << chan;
        slot[0x1d] = 3;
        slot[0x1c] = 0;
    }
    iSNDpsxkeyoff((int)mask);
    return 0;
}

/* iSNDplatformpitch @0x800FFF94 : program a voice's hardware pitch from its base pitch * `pitch` multiplier
 *   (12.12), scaled by 0x1b9, mirrored to the linked partner. MATCH (49/49): the voice table is
 *   sndpd+0xd8; spelling the 0x2c stride as 0xb then <<2 preserves the oracle's scheduling. */
extern int iSNDplatformpitch(int chan, int pitch)
{
    int vt = chan * 0xb;
    unsigned char *slot;

    vt <<= 2;
    chan = (int)(sndpd + 0xd8);
    slot = (unsigned char *)(chan + vt);

    *(volatile int *)(slot + 8) =
        ((int)((unsigned)*(unsigned short *)(slot + 0x1a) * pitch) >> 0xc) * 0x1b9;
    *(volatile unsigned char *)(slot + 0x28) = 1;
    if (*(volatile unsigned char *)(slot + 0x1f) == 2) {      /* linked pair shares the pitch */
        chan -= 0xd8;
        *(int *)(chan + (int)*(volatile signed char *)(slot + 0x20) * 0x2c + 0xe0) =
            *(int *)(slot + 8);
        *(unsigned char *)(chan + (int)*(volatile signed char *)(slot + 0x20) * 0x2c + 0x100) = 1;
    }
    return 0;
}

/* iSNDplatformfxlevel @0x80100058 : set/queue a voice's reverb (effect) routing.  While playing, builds the
 *   voice mask (+ linked partner) and turns the SPU echo on/off; otherwise just caches the level.
 *   `fxon` == 0 disables reverb, non-zero enables.  3-arg (chan,bus,fxon): `bus` is unused (the binary
 *   overwrites $a1 with the playstate), `fxon` is $a2 -- matches SNDfxlevel's iSNDplatformfxlevel(voice,bus,fxArg).
 *   MATCH: the slot is async/volatile signed-byte storage; casting playstate to unsigned char produces the
 *   oracle's lbu+nop+andi sequence, and `if (fxon)` preserves its effect-on/effect-off block order. */
extern int iSNDplatformfxlevel(unsigned int chan, int bus, int fxon)
{
    int          vt = (int)chan * 0x2c;
    volatile signed char *slot = (volatile signed char *)&DAT_801479f0 + vt;
    unsigned int mask;
    bus = (unsigned char)slot[0x1c]; /* 3-arg per IDA/disasm: a1 is overwritten by the playstate */

    if (bus != 2) {                                          /* not playing -> cache for next key-on */
        slot[0x23] = (char)fxon;
        return 0;
    }
    mask = 1u << (chan);                               /* (computed even when the branch below skips) */
    if ((unsigned char)slot[0x1f] == (unsigned int)bus)
        mask |= 1u << (unsigned char)slot[0x20];
    if (fxon)
        iSNDpsxeffecton((int)mask);
    else
        iSNDpsxeffectoff((int)mask);
    return 0;
}

/* iSNDvol @0x801000F8 : apply a logical `level` to a playing voice -- resolve it to SPU L/R via the voice's
 *   routing mode (absolute iSNDatolrv, or delta-from-cache iSNDatodlrv), cache the L/R, and push to the SPU
 *   voice regs via iSNDsetvol.  When not playing, just caches the level.  (Ghidra mis-named arg2 "chan" and
 *   dropped the inner-call args -- all restored from disasm-v3.) */
extern int iSNDvol(int chan, int level)
{
    int vt = chan * 0x2c;
    volatile unsigned char *slot = sndpd + 0xd8 + vt;
    int outL, outR;

    if (slot[0x1c] != 2) {                                   /* not playing -> cache the level */
        slot[0x22] = (char)level;
        return 0;
    }
    if (slot[0x1e] == 0)                                     /* absolute L/R from level */
        iSNDatolrv((unsigned)*(volatile unsigned short *)(slot + 0x18), level, &outL, &outR);
    else if (slot[0x1e] == 1)                                /* delta from current L/R cache */
        iSNDatodlrv((unsigned)*(volatile unsigned short *)(slot + 0x18), level, &outL, &outR,
                    (int)(signed char)slot[0x24], (int)(signed char)slot[0x25]);
    slot[0x24] = (unsigned char)outL;
    slot[0x25] = (unsigned char)outR;
    iSNDsetvol(chan, outL, outR);
    return 0;
}
