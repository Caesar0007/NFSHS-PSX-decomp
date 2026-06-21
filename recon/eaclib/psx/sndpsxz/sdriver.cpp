/* eaclib/psx/sndpsxz/sdriver.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
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
extern "C" int           DAT_801479f8;     /* +0x08 hw pitch/rate (int view: [chan*0xb]) */
extern "C" char          DAT_801479f0;     /* +0x00 voice-table base (byte, for hook arg)  */
extern "C" unsigned char DAT_80147a08;     /* +0x18 volume angle/pan (u16) */
extern "C" unsigned char DAT_80147a0a;     /* +0x1a base pitch (u16)       */
extern "C" unsigned char DAT_80147a0c;     /* +0x1c playstate              */
extern "C" unsigned char DAT_80147a0d;     /* +0x1d substate               */
extern "C" unsigned char DAT_80147a0e;     /* +0x1e volume routing mode    */
extern "C" unsigned char DAT_80147a0f;     /* +0x1f channel count          */
extern "C" unsigned char DAT_80147a10;     /* +0x20 linked voice index     */
extern "C" unsigned char DAT_80147a12;     /* +0x22 cached level           */
extern "C" unsigned char DAT_80147a13;     /* +0x23 cached fx level        */
extern "C" unsigned char DAT_80147a14;     /* +0x24 L out cache            */
extern "C" unsigned char DAT_80147a15;     /* +0x25 R out cache            */
extern "C" unsigned char DAT_80147a17;     /* +0x27 voice-done flag (bit7) */
extern "C" unsigned char DAT_80147a18;     /* +0x28 pitch-dirty flag       */

/* "voice has finished" notifier installed by the host (@0x8014803C) */
extern "C" void (*snd_voice_done_hook)(void *voice);

/* dependencies in sibling objs */
extern "C" int          iSNDfreechan(int chan);                       /* salloc  */
extern "C" int          iSNDpsxkeyoff(int mask);                      /* spatkey */
extern "C" unsigned int iSNDpsxeffecton(int mask);                    /* spatkey */
extern "C" unsigned int iSNDpsxeffectoff(int mask);                   /* spatkey */
extern "C" unsigned int iSNDsetvol(int chan, int left, int right);    /* spatkey */
extern "C" void iSNDatolrv(unsigned int pan, int level, int *outL, int *outR);                 /* saetolrv */
extern "C" void iSNDatodlrv(unsigned int pan, int level, int *outL, int *outR, int pL, int pR);/* saetodv  */

extern "C" int iSNDstop(unsigned int chan);                           /* @0x800FFE90 */
extern "C" int iSNDvol(int chan, int level);                          /* @0x801000F8 */

/* iSNDstop @0x800FFE90 : silence a hardware voice (and its linked partner).  Fires the voice-done hook
 *   unless already flagged, releases the channel(s) back to the pool, marks them idle and strobes the SPU
 *   key-off for the combined voice mask. */
extern "C" int iSNDstop(unsigned int chan)
{
    int          vt = (int)chan * 0x2c;
    unsigned int mask, link;

    if (-1 < (int)((unsigned)(&DAT_80147a17)[vt] << 0x18))     /* voice-done bit clear -> notify */
        (*snd_voice_done_hook)(&DAT_801479f0 + vt);
    iSNDfreechan((int)chan);
    (&DAT_80147a0d)[vt] = 3;
    (&DAT_80147a0c)[vt] = 0;
    mask = 1u << (chan & 0x1f);
    if (1 < (&DAT_80147a0f)[vt]) {                             /* linked pair -> stop the partner too */
        link = (unsigned)(char)(&DAT_80147a10)[vt];
        iSNDfreechan((int)link);
        mask |= 1u << (link & 0x1f);
        (&DAT_80147a0d)[link * 0x2c] = 3;
        (&DAT_80147a0c)[link * 0x2c] = 0;
    }
    iSNDpsxkeyoff((int)mask);
    return 0;
}

/* iSNDplatformpitch @0x800FFF94 : program a voice's hardware pitch from its base pitch * `pitch` multiplier
 *   (12.12), scaled by 0x1b9, mirrored to the linked partner. */
extern "C" int iSNDplatformpitch(int chan, int pitch)
{
    int vt = chan * 0x2c;

    (&DAT_801479f8)[chan * 0xb] =
        ((int)((unsigned)*(unsigned short *)(&DAT_80147a0a + vt) * pitch) >> 0xc) * 0x1b9;
    (&DAT_80147a18)[vt] = 1;
    if ((&DAT_80147a0f)[vt] == 2) {                            /* linked pair shares the pitch */
        int link = (char)(&DAT_80147a10)[vt];
        (&DAT_801479f8)[link * 0xb] = (&DAT_801479f8)[chan * 0xb];
        (&DAT_80147a18)[link * 0x2c] = 1;
    }
    return 0;
}

/* iSNDplatformfxlevel @0x80100058 : set/queue a voice's reverb (effect) routing.  While playing, builds the
 *   voice mask (+ linked partner) and turns the SPU echo on/off; otherwise just caches the level.
 *   `fxon` == 0 disables reverb, non-zero enables.  3-arg (chan,bus,fxon): `bus` is unused (the binary
 *   overwrites $a1 with the playstate), `fxon` is $a2 -- matches SNDfxlevel's iSNDplatformfxlevel(voice,bus,fxArg). */
extern "C" int iSNDplatformfxlevel(unsigned int chan, int bus, int fxon)
{
    int          vt = (int)chan * 0x2c;
    unsigned int mask;
    (void)bus;        /* 3-arg per IDA/disasm (a1=bus is overwritten by the playstate read); fxon is a2 */

    if ((&DAT_80147a0c)[vt] != 2) {                           /* not playing -> cache for next key-on */
        (&DAT_80147a13)[vt] = (char)fxon;
        return 0;
    }
    mask = 1u << (chan & 0x1f);                               /* (computed even when the branch below skips) */
    if ((&DAT_80147a0f)[vt] == 2)
        mask |= 1u << ((unsigned char)(&DAT_80147a10)[vt] & 0x1f);
    if (fxon == 0)
        iSNDpsxeffectoff((int)mask);
    else
        iSNDpsxeffecton((int)mask);
    return 0;
}

/* iSNDvol @0x801000F8 : apply a logical `level` to a playing voice -- resolve it to SPU L/R via the voice's
 *   routing mode (absolute iSNDatolrv, or delta-from-cache iSNDatodlrv), cache the L/R, and push to the SPU
 *   voice regs via iSNDsetvol.  When not playing, just caches the level.  (Ghidra mis-named arg2 "chan" and
 *   dropped the inner-call args -- all restored from disasm-v3.) */
extern "C" int iSNDvol(int chan, int level)
{
    int vt = chan * 0x2c;
    int outL = 0, outR = 0;

    if ((&DAT_80147a0c)[vt] != 2) {                           /* not playing -> cache the level */
        (&DAT_80147a12)[vt] = (char)level;
        return 0;
    }
    if ((&DAT_80147a0e)[vt] == 0)                             /* absolute L/R from level */
        iSNDatolrv((unsigned)*(unsigned short *)(&DAT_80147a08 + vt), level, &outL, &outR);
    else if ((&DAT_80147a0e)[vt] == 1)                        /* delta from current L/R cache */
        iSNDatodlrv((unsigned)*(unsigned short *)(&DAT_80147a08 + vt), level, &outL, &outR,
                    (int)(signed char)(&DAT_80147a14)[vt], (int)(signed char)(&DAT_80147a15)[vt]);
    (&DAT_80147a14)[vt] = (unsigned char)outL;
    (&DAT_80147a15)[vt] = (unsigned char)outR;
    iSNDsetvol(chan, outL, outR);
    return 0;
}
