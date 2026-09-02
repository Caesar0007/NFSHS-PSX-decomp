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
 * MATCH (W31, was 32 diffs): (1) the tag parser is a NATURAL `while` loop, not a goto chain -- real
 * loop notes weight the in-loop defs' ref counts, which is what allocates sampleData->s3 / voice->s4
 * in oracle order (goto form left them swapped); (2) plain `slot[0x1f] = 1` + in-loop re-store lets
 * gcc cross-jump the two identical sb's into the oracle's shared store; (3) the 0x1f stores are
 * volatile like the record's other stores, which keeps gcc's reorg from stealing the shared sb into
 * the 0x82 case's j delay slot (oracle has the unfilled nop); (4) `slot[0x20] = -1` needs a signed
 * char store (plain char is unsigned under ccpsx). IDA sub_8010BA48 supplied the loop/store shape. */
extern int iSNDplatformplay(int chan, int voice, int level, int pitch, int a5, int fx,
                            int volAngle, int pitchOffset)
{
    int           *sampleData = 0;         /* 0x8a tag -> sample-header ptr */
    int           vt;
    unsigned char *slot;
    int           rate = 0x5622;           /* 0x84 tag (default) */
    int           loopVal = 0;             /* 0x85 tag */
    unsigned int  id;
    int           val;
    int           *ptr;
    (void)a5;
    (void)pitchOffset;

    vt = voice << 1;
    vt = vt + voice;
    vt = vt << 2;
    vt = vt - voice;
    vt = vt << 2;
    slot = &DAT_801479f0 + vt;

    *(volatile unsigned char *)(slot + 0x21) = 0;
    *(volatile signed char *)(slot + 0x20) = -1;
    slot[0x1e] = 0;
    *(volatile unsigned char *)(slot + 0x1f) = 1;
    while (iSNDgettag(&chan, &id, &val, (int *)&ptr) != 0 && id != 0xfe) {
        if (id == 0x8a) {
            sampleData = ptr;
            continue;
        }
        if (id == 0x85) {
            loopVal = val;
            continue;
        }
        if (id == 0x82) {
            *(volatile unsigned char *)(slot + 0x1f) = *(unsigned char *)&val;
            continue;
        }
        if (id == 0x84) {
            rate = val;
            continue;
        }
        if (id == 0x92)
            *(volatile unsigned char *)(slot + 0x1e) = (unsigned char)val;
    }

    *(volatile int *)(slot + 0x04) = loopVal;
    *(volatile unsigned char *)(slot + 0x22) = (char)level;
    *(volatile unsigned short *)(slot + 0x18) = (unsigned short)volAngle;
    *(volatile unsigned char *)(slot + 0x23) = (unsigned char)fx;
    *(volatile int *)(slot + 0x00) = *sampleData;
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
