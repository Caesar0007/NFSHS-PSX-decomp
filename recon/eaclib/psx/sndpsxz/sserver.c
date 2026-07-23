/* eaclib/psx/sndpsxz/sserver.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
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

extern int           sndgs[];
extern int           timerhz;            /* hardware tick rate            */
/* sndgs = 0x80147860 (configs/symbol_addrs.txt); DAT_80147910/DAT_80147912 are FIELDS of sndgs itself
 * (+0xB0 / +0xB2), not separate globals -- confirmed by oracle's lhu/sh %B2(s0) off the SAME &sndgs base
 * used for GB()/GUB() field accesses (iSNDleaveaudio). Both are SHORT (16-bit lhu/sh), not int. */
#define DAT_80147910 (*(short *)((char *)sndgs + 0xB0))   /* last-seen timerhz             */
#define DAT_80147912 (*(short *)((char *)sndgs + 0xB2))   /* deferred-server request count */

extern void SNDI_mutexlock(void);        /* sdfx     */
extern void SNDI_mutexunlock(void);      /* sdfx     */
extern void iSNDserve(void);             /* slib     */
extern int  iSNDcalcpitch(int note);     /* sclcptch */
extern int  iSNDplatformpitch(int chan, int pitch);   /* sdriver */
extern int  iSNDvol(int chan, int level);             /* sdriver */
extern unsigned int iSNDcalcvol(int chan);            /* spatkey */
extern int  SNDstop(unsigned int tag);                /* sstop   */
extern void trap(unsigned int code);

extern void iSNDserver(void);                         /* @0x800EA138 */
extern void iSND100hzserver(void);                    /* @0x800EA254 */
extern void iSNDenteraudio(void);                     /* @0x800EA534 */
extern void iSNDleaveaudio(void);                     /* @0x800EA56C */

#define GB(idx) (((char *)sndgs)[idx])            /* signed byte of sndgs    */
#define GUB(idx) (((unsigned char *)sndgs)[idx])  /* unsigned byte of sndgs  */

/* iSNDserver @0x800EA138 : advance the audio clock -- run iSND100hzserver (sndgs[0x12]) once per elapsed
 *   100 Hz tick to catch sndgs[0x11] up to (real ticks * 100 / timerhz).  Defers if audio is locked. */
extern void iSNDserver(void)
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
extern void iSND100hzserver(void)
{
    int *g;
    int i;
    int chanIdx;
    int *channelBase;
    int *globalBase;
    unsigned int *p;
    int dirty;

    g = sndgs;
    *(volatile int *)(g + 0x11) = *(volatile int *)(g + 0x11) + 1;
    i = 0;
    iSNDserve();
    if (0 < *(signed char *)((char *)g + 0x40)) { /* run the 100 Hz client callbacks */
        int *clientBase = g;
        do {
            (*(void (*)(void))g[0x13])();
            g++;
            i++;
        } while (i < (int)*(signed char *)((char *)clientBase + 0x40));
    }

    channelBase = sndgs;
    i = 0;
    if (*(unsigned char *)((char *)channelBase + 0x11) != 0) { /* over every channel */
        globalBase = channelBase;
        chanIdx = i;
        do {
            p = (unsigned int *)(globalBase[0x25] + chanIdx);
            if (*(signed char *)((int)p + 0xb) == 1 && -1 < (int)*p) { /* held, valid tag */
                if (p[0x15] != 0) {                                 /* pitch LFO active */
                    unsigned char phase = *(unsigned char *)((int)p + 0x3b) + 1;
                    *(unsigned char *)((int)p + 0x3b) = phase;
                    if (*(unsigned char *)((int)p + 0x39) <= phase)
                        *(unsigned char *)((int)p + 0x3b) = 0;
                    *(short *)((int)p + 0x5e) = 0;
                    iSNDcalcpitch(i);
                    iSNDplatformpitch(i, (int)(unsigned)*(unsigned short *)((int)p + 0x62));
                }
                dirty = 0;
                if (p[0x14] != 0) {                                 /* velocity envelope active */
                    unsigned char phase;
                    dirty = 1;
                    phase = *(unsigned char *)((int)p + 0x3a) + 1;
                    *(unsigned char *)((int)p + 0x3a) = phase;
                    if (*(unsigned char *)((int)p + 0x38) <= phase)
                        *(unsigned char *)((int)p + 0x3a) = 0;
                }
                {
                    unsigned int delta = p[5];                        /* portamento step */
                    if (delta != 0) {
                        unsigned int position;
                        int sign;
                        dirty = 1;
                        sign = (int)delta;
                        position = p[7] + delta;
                        delta = position;
                        p[7] = position;
                        if (sign < 0) {
                            if (!((int)p[6] < (int)delta)) {
                                p[7] = p[6];
                                p[5] = 0;
                            }
                        } else if (!((int)delta < (int)p[6])) {
                            p[7] = p[6];
                            p[5] = 0;
                        }
                    }
                    if ((int)p[7] < 0) { SNDstop(*p); goto next_chan; }
                }
                /* portamento done -> pitch sweep */
                if (p[8] != 0) { dirty = 1; p[9] = p[9] + p[8]; }
                if (p[10] == 0) {                                   /* advance to next sweep segment */
                    signed char index = *(unsigned char *)((int)p + 0x31) + 1;
                    *(unsigned char *)((int)p + 0x31) = index;
                    if (!(index < *(signed char *)((int)p + 0x30))) {
                        SNDstop(*p);
                        goto next_chan;
                    } else {
                        int *table = (int *)(p[0x10] + index * 8);
                        p[10] = table[0];
                        if ((int)p[10] < 0)
                            p[10] = 0x7fffffff;
                        p[8] = (table[1] * 0x10000 - (int)p[9]) / (int)p[10];
                    }
                }
                p[10] = p[10] - 1;
                if (dirty) {
                    iSNDcalcvol(i);
                    if (-1 < (int)*p)
                        iSNDvol(i, (int)*(signed char *)((int)p + 0x2d));
                }
            }
next_chan:
            chanIdx += 100;
            i++;
        } while (i < (int)(unsigned)*(unsigned char *)((char *)globalBase + 0x11));
    }
}

/* iSNDenteraudio @0x800EA534 : take the audio re-entrancy lock (mutex + depth++). */
extern void iSNDenteraudio(void)
{
    char *g;
    SNDI_mutexlock();
    g = (char *)sndgs;   /* materialize &sndgs (lui+addiu) AFTER the call so it lands in a caller-saved reg */
    g[0x3f] = g[0x3f] + 1;
}

/* iSNDleaveaudio @0x800EA56C : release the audio lock; at depth 0, flush any servers deferred while held. */
extern void iSNDleaveaudio(void)
{
    char *g = (char *)sndgs;      /* held across the call (oracle: callee-saved $s0) */
    *(volatile unsigned char *)(g + 0x3f) =
        *(volatile unsigned char *)(g + 0x3f) - 1;
    SNDI_mutexunlock();
    if (*(volatile unsigned char *)(g + 0x3f) == 0) {
        while (*(volatile unsigned short *)(g + 0xB2) != 0) {
            *(volatile unsigned short *)(g + 0xB2) =
                *(volatile unsigned short *)(g + 0xB2) - 1;
            iSNDserver();
        }
    }
}

/* iSNDserveradd100hzclient @0x800EA5F0 : register a 100 Hz tick callback `cb`; returns sndgs.
 *   Count read SIGNED (lb) for the index, UNSIGNED (lbu) for the increment-store.
 * MATCH: byte-base cast keeps oracle's sll(lb*4) then addu then sw a0,0x4c(v1) displacement form */
extern short *iSNDserveradd100hzclient(int cb)
{
    /* MATCH: index sndgs by the raw client count ONLY (base = sndgs + count*4, scaled by sizeof(int)
     * with no other term folded into the index) and fold the 0x13-slot (0x4c-byte) client-array
     * offset into the store DISPLACEMENT via a byte-base cast -- oracle emits sll(count*4); addu
     * base; sw a0,0x4c(base). Indexing sndgs[count+0x13] instead adds 0x13 to the INDEX before the
     * *4 scale (extra addiu v1,v1,19 before the sll) -- not what the oracle does. */
    char *base = (char *)sndgs;
    *(int *)(base + (signed char)base[0x40] * 4 + 0x4c) = cb;
    GB(0x40) = GB(0x40) + 1;
    return (short *)sndgs;
}

/* iSNDserverremove100hzclient @0x800EA620 : unregister a 100 Hz callback, compacting the client list. */
extern void iSNDserverremove100hzclient(int cb)
{
    int i;
    int j;
    char *base;
    char *p;

    p = (char *)sndgs;
    if (*(signed char *)(p + 0x40) <= 0)
        return;
    i = 0;
    base = p;
findloop:
    if (*(int *)(base + i * 4 + 0x4c) == cb) {
        *(char *)(base + 0x40) = *(char *)(base + 0x40) - 1;
        if (i < *(signed char *)(base + 0x40)) {
shiftloop:
            j = i * 4;
            i++;
            *(int *)(base + j + 0x4c) = *(int *)(base + i * 4 + 0x4c);
            if (i < *(signed char *)(base + 0x40))
                goto shiftloop;
        }
        return;
    }
    i++;
    if (i < *(signed char *)(base + 0x40))
        goto findloop;
}

/* owning-TU def (link-harness) */
 int request; 
