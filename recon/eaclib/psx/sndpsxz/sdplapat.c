/* eaclib/psx/sndpsxz/sdplapat.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdplapat.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010BA48.  iSNDplatformplay -- the per-voice SPU launcher for a sound patch (the patch-side
 *   twin of sdpacket's iSNDplatformpacketplay): parse the patch's tag stream into the voice-state table and
 *   key the voice.  Ghidra nfs4-f.exe.c (sdplapat) + the call-site oracle establish an 8-arg ABI
 *   (the callee does not read the eighth argument; Ghidra showed only 3 + in_a3/in_stack_*).
 *   Tags: 0x82 channel count, 0x84 sample rate, 0x85 loop length, 0x8a sample-data ptr, 0x92 output mode.
 *   iSNDgettag is 4-arg (Ghidra dropped to 2).
 */

extern int sndgs[];
extern unsigned char sndpd[];
extern unsigned char DAT_801479f0;   /* voice base (+0x00) */
extern unsigned char DAT_801479f4;   /* +0x04 */
extern unsigned char DAT_801479fc;   /* +0x0c */
extern unsigned char DAT_80147a00;   /* +0x10 */
extern unsigned char DAT_80147a04;   /* +0x14 */
extern unsigned char DAT_80147a08;   /* +0x18 vol angle */
extern unsigned char DAT_80147a0a;   /* +0x1a pitch base */
extern unsigned char DAT_80147a0c;   /* +0x1c playstate */
extern unsigned char DAT_80147a0e;   /* +0x1e output mode */
extern unsigned char DAT_80147a0f;   /* +0x1f channels */
extern unsigned char DAT_80147a10;   /* +0x20 link */
extern unsigned char DAT_80147a11;   /* +0x21 link flag */
extern unsigned char DAT_80147a12;   /* +0x22 level */
extern unsigned char DAT_80147a13;   /* +0x23 fx level */

extern int iSNDgettag(int *cursor, unsigned int *outId, int *outVal, int *outPtr);  /* sgettag */
extern int iSNDplatformpitch(int chan, int pitch);                                  /* sdriver */

extern int iSNDplatformplay(int chan, int voice, int level, int pitch, int a5, int fx,
                            int volAngle, int pitchOffset);

/* iSNDplatformplay @0x8010BA48 : launch `voice` playing the patch whose tag stream starts at `chan`.
 * Rebuilt around the real 0x2c-byte voice record and the oracle's direct tag-state machine. The record
 * writes are volatile because this state is consumed by the SPU/service layer asynchronously; that also
 * preserves the oracle's load-delay nops. Pure-C near miss: 171/171, 32 diffs. The residual is primarily
 * a sample-data/voice register-coloring swap that cascades through the second half, plus the 0x82 store's
 * delay-slot placement. No register-pinning assembly is used. */
extern int iSNDplatformplay(int chan, int voice, int level, int pitch, int a5, int fx,
                            int volAngle, int pitchOffset)
{
    int           sampleData = 0;          /* 0x8a tag -> sample-header ptr */
    int           vt;
    unsigned char *slot;
    int           rate = 0x5622;           /* 0x84 tag (default) */
    int           loopVal = 0;             /* 0x85 tag */
    int           empty = -1;
    unsigned int  id;
    int           val, ptr;
    (void)a5;
    (void)pitchOffset;

    vt = voice << 1;
    vt = vt + voice;
    vt = vt << 2;
    vt = vt - voice;
    vt = vt << 2;
    slot = &DAT_801479f0 + vt;

    *(volatile unsigned char *)(slot + 0x21) = 0;
    *(volatile unsigned char *)(slot + 0x20) = empty;
    slot[0x1e] = 0;
    slot[0x1f] = 1;
parse_tag:
    if (iSNDgettag(&chan, &id, &val, &ptr) == 0 || id == 0xfe)
        goto finalize;
    if (id == 0x8a) {
        sampleData = ptr;
        goto parse_tag;
    }
    if (id == 0x85) {
        loopVal = val;
        goto parse_tag;
    }
    if (id == 0x82) {
        slot[0x1f] = (unsigned char)val;
        goto parse_tag;
    }
    if (id == 0x84) {
        rate = val;
        goto parse_tag;
    }
    if (id == 0x92)
        *(volatile unsigned char *)(slot + 0x1e) = (unsigned char)val;
    goto parse_tag;

finalize:
    *(volatile int *)(slot + 0x04) = loopVal;
    *(volatile unsigned char *)(slot + 0x22) = (char)level;
    *(volatile unsigned short *)(slot + 0x18) = (unsigned short)volAngle;
    *(volatile unsigned char *)(slot + 0x23) = (unsigned char)fx;
    *(volatile int *)(slot + 0x00) = *(int *)sampleData;
    *(volatile int *)(slot + 0x0c) = 0;
    *(volatile int *)(slot + 0x10) = 0;
    *(volatile int *)(slot + 0x14) = loopVal << 0xc;
    *(volatile short *)(slot + 0x1a) = (short)((rate * 0x17c7) >> 0x10);
    if (1 < (unsigned char)*(volatile unsigned char *)(slot + 0x1f)) { /* arm linked voice */
        unsigned char *voiceBase = sndpd;
        slot[0x20] = *(unsigned char *)(voice * 100 + sndgs[0x25] + 4);
        voiceBase[(((int)(unsigned)*(volatile unsigned char *)(slot + 0x20) << 24) >> 24) * 0x2c + 0xf9] = 1;
        *(int *)(voiceBase + (((int)(unsigned)*(volatile unsigned char *)(slot + 0x20) << 24) >> 24) * 0x2c + 0xe4) = 0;
        *(int *)(voiceBase + (((int)(unsigned)*(volatile unsigned char *)(slot + 0x20) << 24) >> 24) * 0x2c + 0xe8) = 0;
        *(int *)(voiceBase + (((int)(unsigned)*(volatile unsigned char *)(slot + 0x20) << 24) >> 24) * 0x2c + 0xec) = *(int *)(slot + 0x14);
    }
    iSNDplatformpitch(voice, pitch);
    slot[0x1c] = 1;                                     /* playstate = playing */
    return 0;
}
