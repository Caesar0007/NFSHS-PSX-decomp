/* eaclib/psx/sndpsxz/sdplapat.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdplapat.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010BA48.  iSNDplatformplay -- the per-voice SPU launcher for a sound patch (the patch-side
 *   twin of sdpacket's iSNDplatformpacketplay): parse the patch's tag stream into the voice-state table and
 *   key the voice.  Ghidra nfs4-f.exe.c (sdplapat) + IDA sig (7-arg; Ghidra showed 3 + in_a3/in_stack_*).
 *   Tags: 0x82 channel count, 0x84 sample rate, 0x85 loop length, 0x8a sample-data ptr, 0x92 output mode.
 *   iSNDgettag is 4-arg (Ghidra dropped to 2); the iSNDplaytaggedtimbre caller's 7-arg form reconciles here.
 */

extern int sndgs[];
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

extern int iSNDplatformplay(int chan, int voice, int level, int pitch, int a5, int fx, int volAngle);

/* iSNDplatformplay @0x8010BA48 : launch `voice` playing the patch whose tag stream starts at `chan`. */
extern int iSNDplatformplay(int chan, int voice, int level, int pitch, int a5, int fx, int volAngle)
{
    int           vt = voice * 0x2c;
    int           sampleData = 0;          /* 0x8a tag -> ptr to the sample header */
    int           loopVal = 0;             /* 0x85 tag */
    int           rate = 0x5622;           /* 0x84 tag (default) */
    unsigned char nch = 1;                 /* 0x82 tag */
    unsigned int  id;
    int           val, ptr, r, v, p;
    int           cur[4];
    (void)a5;

    cur[0] = chan;
    (&DAT_80147a11)[vt] = 0;
    (&DAT_80147a10)[vt] = 0xff;
    (&DAT_80147a0e)[vt] = 0;

    for (;;) {                                          /* outer: re-armed on a 0x82 channel-count tag */
        (&DAT_80147a0f)[vt] = nch;
        r = rate; v = loopVal; p = sampleData;
        for (;;) {                                      /* inner: breaks on 0x82 */
            for (;;) {                                  /* innermost: loops on 0x8a / 0x85 */
                sampleData = p; loopVal = v; rate = r;
                if (iSNDgettag(cur, &id, &val, &ptr) == 0 || id == 0xfe)
                    goto finalize;
                r = rate; v = loopVal; p = ptr;
                if (id == 0x8a) continue;               /* p = sample-data ptr */
                if (id == 0x85) { v = val; p = sampleData; continue; }   /* loop length */
                break;
            }
            nch = (unsigned char)val;
            if (id == 0x82) break;                      /* channel count -> outer */
            r = val;                                    /* 0x84 = sample rate */
            if (id != 0x84 && (r = rate, id == 0x92))
                (&DAT_80147a0e)[vt] = (unsigned char)val;   /* output mode */
        }
    }

finalize:
    *(int *)(&DAT_801479f4 + vt) = loopVal;
    (&DAT_80147a12)[vt] = (char)level;
    *(unsigned short *)(&DAT_80147a08 + vt) = (unsigned short)volAngle;
    (&DAT_80147a13)[vt] = (unsigned char)fx;
    *(int *)(&DAT_801479f0 + vt) = *(int *)sampleData;
    *(int *)(&DAT_801479fc + vt) = 0;
    (&DAT_80147a00)[voice * 0xb] = 0;
    *(int *)(&DAT_80147a04 + vt) = loopVal << 0xc;
    *(short *)(&DAT_80147a0a + vt) = (short)((unsigned int)(rate * 0x17c7) >> 0x10);
    if (1 < (unsigned char)(&DAT_80147a0f)[vt]) {       /* arm the linked partner voice */
        (&DAT_80147a10)[vt] = *(unsigned char *)(voice * 100 + sndgs[0x25] + 4);
        (&DAT_80147a11)[(char)(&DAT_80147a10)[vt] * 0x2c] = 1;
        *(int *)(&DAT_801479fc + (char)(&DAT_80147a10)[vt] * 0x2c) = 0;
        (&DAT_80147a00)[(char)(&DAT_80147a10)[vt] * 0xb] = 0;
        *(int *)(&DAT_80147a04 + (char)(&DAT_80147a10)[vt] * 0x2c) = *(int *)(&DAT_80147a04 + vt);
    }
    iSNDplatformpitch(voice, pitch);
    (&DAT_80147a0c)[vt] = 1;                             /* playstate = playing */
    return 0;
}
