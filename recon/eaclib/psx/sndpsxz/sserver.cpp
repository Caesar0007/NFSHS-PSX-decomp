/* eaclib/psx/sndpsxz/sserver.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
 *   Source obj : nfs4\eaclib\psx\sserver.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   6 fns @[0x800EA138 .. 0x800EA620].  The sound-system tick server: catches the audio clock up to real
 *   time (iSNDserver), runs one 100 Hz tick (iSND100hzserver: per-voice pitch/vol envelopes + portamento +
 *   pitch sweeps), the audio re-entrancy lock (iSNDenteraudio/leaveaudio) and the 100 Hz client list.
 *   Ghidra nfs4-f.exe.c (sserver) + IDA sigs.
 *
 *   sndgs (int[]) fields used here:  [0xf] byte2 (0x3e) = "in server" flag, byte3 (0x3f) = audio-lock depth;
 *   [4] byte1 (0x11) = channel count; [0x10] byte0 (0x40) = 100 Hz client count; [0x11] = audio tick;
 *   [0x12] = serve callback; [0x13..] = 100 Hz client fn-ptrs; [0x25] = channel pool; [0x2b] = real ticks.
 *   Channel slot (sndgs[0x25] + voice*100): +0x0 tag, +0xb state, +0x14 vel-env ptr, +0x15(*0x54) lfo ptr,
 *   +0x20/+0x24/+0x28 sweep step/accum/count, +0x2d vol, +0x30 sweep cnt, +0x31 sweep idx, +0x39/0x3a/0x3b
 *   lfo/vel/pitch phase, +0x40 sweep tbl, +0x5e pitch cache, +0x62 final pitch.
 */

extern "C" int           sndgs[];
extern "C" int           timerhz;            /* hardware tick rate            */
extern "C" short         DAT_80147910;       /* last-seen timerhz             */
extern "C" int           DAT_80147912;       /* deferred-server request count */

extern "C" void SNDI_mutexlock(void);        /* sdfx     */
extern "C" void SNDI_mutexunlock(void);      /* sdfx     */
extern "C" void iSNDserve(void);             /* slib     */
extern "C" int  iSNDcalcpitch(int note);     /* sclcptch */
extern "C" int  iSNDplatformpitch(int chan, int pitch);   /* sdriver */
extern "C" int  iSNDvol(int chan, int level);             /* sdriver */
extern "C" unsigned int iSNDcalcvol(int chan);            /* spatkey */
extern "C" int  SNDstop(unsigned int tag);                /* sstop   */
extern "C" void trap(unsigned int code);

extern "C" void iSNDserver(void);                         /* @0x800EA138 */
extern "C" void iSND100hzserver(void);                    /* @0x800EA254 */
extern "C" void iSNDenteraudio(void);                     /* @0x800EA534 */
extern "C" void iSNDleaveaudio(void);                     /* @0x800EA56C */

#define GB(idx) (((char *)sndgs)[idx])            /* signed byte of sndgs    */
#define GUB(idx) (((unsigned char *)sndgs)[idx])  /* unsigned byte of sndgs  */

/* iSNDserver @0x800EA138 : advance the audio clock -- run iSND100hzserver (sndgs[0x12]) once per elapsed
 *   100 Hz tick to catch sndgs[0x11] up to (real ticks * 100 / timerhz).  Defers if audio is locked. */
extern "C" void iSNDserver(void)
{
    unsigned int target;
    if (GB(0x3e) == 0) {                       /* not already inside the server */
        if (GB(0x3f) == 0) {                   /* audio not locked */
            GB(0x3e) = 1;
            if (timerhz != DAT_80147910) {
                DAT_80147910 = (short)timerhz;
                sndgs[0x11] = 0;
                sndgs[0x2b] = 0;
            }
            sndgs[0x2b] = sndgs[0x2b] + 1;
            if (timerhz == 0)
                trap(0x1c00);
            target = (unsigned int)(sndgs[0x2b] * 100) / (unsigned int)timerhz;
            while ((unsigned int)sndgs[0x11] <= target)
                (*(void (*)(void))sndgs[0x12])();
            GB(0x3e) = 0;
        } else {
            DAT_80147912 = DAT_80147912 + 1;   /* run it later, on leaveaudio */
        }
    }
}

/* iSND100hzserver @0x800EA254 : one 100 Hz tick -- bump the audio clock, run the stream/serve pump and the
 *   registered 100 Hz clients, then for every held voice step its pitch LFO, velocity envelope, portamento
 *   and pitch sweep, recomputing SPU pitch/volume (and stopping voices whose sweep table runs out). */
extern "C" void iSND100hzserver(void)
{
    int          *clientp = sndgs;
    int           i, voice, chanIdx;
    unsigned int *p;
    int           dirty;
    unsigned int  dv, cur, tgt, sw;
    int           keep, num;
    char          ti;
    unsigned int *tbl;
    unsigned char ph;

    sndgs[0x11] = sndgs[0x11] + 1;
    iSNDserve();
    i = 0;
    if (0 < GB(0x40)) {                        /* run the 100 Hz client callbacks */
        do {
            int *cb = clientp + 0x13;
            clientp = clientp + 1;
            (*(void (*)(void))*cb)();
            i++;
        } while (i < (int)GB(0x40));
    }

    voice = 0;
    if (GUB(0x11) != 0) {                       /* over every channel */
        chanIdx = 0;
        do {
            p = (unsigned int *)(sndgs[0x25] + chanIdx);
            if (*(char *)((int)p + 0xb) == 1 && -1 < (int)*p) {     /* held, valid tag */
                if (p[0x15] != 0) {                                 /* pitch LFO active */
                    ph = *(char *)((int)p + 0x3b) + 1;
                    *(unsigned char *)((int)p + 0x3b) = ph;
                    if (*(unsigned char *)((int)p + 0x39) <= ph)
                        *(unsigned char *)((int)p + 0x3b) = 0;
                    *(short *)((int)p + 0x5e) = 0;
                    iSNDcalcpitch(voice);
                    iSNDplatformpitch(voice, (int)(unsigned)*(unsigned short *)((int)p + 0x62));
                }
                dirty = 0;
                if (p[0x14] != 0) {                                 /* velocity envelope active */
                    dirty = 1;
                    ph = *(char *)((int)p + 0x3a) + 1;
                    *(unsigned char *)((int)p + 0x3a) = ph;
                    if ((unsigned char)p[0xe] <= ph)
                        *(unsigned char *)((int)p + 0x3a) = 0;
                }
                dv = p[5];                                          /* portamento step */
                if (dv != 0) {
                    dirty = 1;
                    cur = p[7] + dv;
                    p[7] = cur;
                    tgt = p[6];
                    keep = ((int)dv < 0) ? ((int)tgt < (int)cur) : ((int)cur < (int)tgt);
                    if (!keep) { p[7] = tgt; p[5] = 0; }
                    if ((int)p[7] < 0) { SNDstop(*p); goto next_chan; }
                }
                /* portamento done -> pitch sweep */
                if (p[8] != 0) { dirty = 1; p[9] = p[9] + p[8]; }
                sw = p[10];
                if (sw == 0) {                                      /* advance to next sweep segment */
                    ti = *(char *)((int)p + 0x31) + 1;
                    *(char *)((int)p + 0x31) = ti;
                    if ((int)(char)p[0xc] <= (int)ti) { SNDstop(*p); goto next_chan; }
                    tbl = (unsigned int *)(p[0x10] + ti * 8);
                    sw = tbl[0];
                    p[10] = sw;
                    if ((int)sw < 0) p[10] = 0x7fffffff;
                    sw = p[10];
                    num = tbl[1] * 0x10000 - p[9];
                    if (sw == 0) trap(0x1c00);
                    if (sw == 0xffffffff && num == (int)0x80000000) trap(0x1800);
                    p[8] = num / (int)sw;
                    sw = p[10];
                }
                p[10] = sw - 1;
                if (dirty) {
                    iSNDcalcvol(voice);
                    if (-1 < (int)*p)
                        iSNDvol(voice, (int)*(char *)((int)p + 0x2d));
                }
            }
next_chan:
            chanIdx += 100;
            voice++;
        } while (voice < (int)(unsigned)GUB(0x11));
    }
}

/* iSNDenteraudio @0x800EA534 : take the audio re-entrancy lock (mutex + depth++). */
extern "C" void iSNDenteraudio(void)
{
    SNDI_mutexlock();
    GB(0x3f) = GB(0x3f) + 1;
}

/* iSNDleaveaudio @0x800EA56C : release the audio lock; at depth 0, flush any servers deferred while held. */
extern "C" void iSNDleaveaudio(void)
{
    GB(0x3f) = GB(0x3f) - 1;
    SNDI_mutexunlock();
    if (GB(0x3f) == 0) {
        while (DAT_80147912 != 0) {
            DAT_80147912 = DAT_80147912 - 1;
            iSNDserver();
        }
    }
}

/* iSNDserveradd100hzclient @0x800EA5F0 : register a 100 Hz tick callback `cb`; returns sndgs.
 *   Count read SIGNED (lb) for the index, UNSIGNED (lbu) for the increment-store.
 * MATCH: byte-base cast keeps oracle's sll(lb*4) then addu then sw a0,0x4c(v1) displacement form */
extern "C" short *iSNDserveradd100hzclient(int cb)
{
    /* FLOOR: oracle does sll lb*4 then sw a0,0x4c(v1); our gcc adds 0x13 before sll (semantically
     * identical: (lb+0x13)*4 == lb*4+0x4c) but emits an extra addiu vs oracle's displacement form.
     * maspsx fusion wall — 3-diff floor, not source-reachable. */
    sndgs[(int)(signed char)GB(0x40) + 0x13] = cb;
    GB(0x40) = GB(0x40) + 1;
    return (short *)sndgs;
}

/* iSNDserverremove100hzclient @0x800EA620 : unregister a 100 Hz callback, compacting the client list. */
extern "C" int iSNDserverremove100hzclient(int cb)
{
    int i = 0, off = 0;
    int more;
    if (0 < (int)GB(0x40)) {
        off = 0;
        while (*(int *)((int)sndgs + off + 0x4c) != cb) {     /* find the callback slot */
            i++;
            off = i * 4;
            if (GB(0x40) <= i)
                return off;                                   /* not found */
        }
        GB(0x40) = GB(0x40) - 1;
        more = (i < (int)GB(0x40));
        while (off = 0, more) {                               /* compact the tail down one slot */
            sndgs[i + 0x13] = sndgs[i + 0x14];
            more = (i + 1 < (int)GB(0x40));
            i++;
        }
    }
    return off;
}

/* owning-TU def (link-harness) */
extern "C" { int request; }
