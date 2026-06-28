/* eaclib/psx/sndpsxz/sdpacket.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 13/13 ***
 *   Source obj : nfs4\eaclib\psx\sdpacket.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   13 fns @[0x80103784 .. 0x801046C8].  THE SPU/DMA HARDWARE FLOOR of the EA packet player -- the
 *   platform layer iSNDstream/spktplay call to actually stream ADPCM packets into the PSX SPU voice
 *   buffers via DMA, plus the SPU-IRQ-driven double-buffer service loop.
 *   Ghidra nfs4-f.exe.c (sdpacket) + disasm-v3 L<80103784+> -- disasm AUTHORITATIVE for every dropped arg:
 *     iSNDpsxzerospu(addr,LEN) [Ghidra in_a1]; iSNDpacketpurgeframes(p,byteoff,count) [Ghidra __thiscall];
 *     iSNDfillspuwithpackets(p,chunk) + its local frameSize is iSNDpacketget's 3rd (out) arg [Ghidra
 *     local_30]; iSNDplatformpacketplay is 8-ARG (p,note,volAngle:u16,level:u8,pitch:int,a6:int,fx:u8,
 *     hdr:u16*) [Ghidra dropped a3..a8 -> in_a2/in_a3/in_stack_*]; iSNDplatformpacketoverhead RETURNS a
 *     computed size [Ghidra emptied the delay-slot return]; iSNDpacketget(this,chanIdx,&frameSize) 3-arg.
 *
 *   PACKET-VOICE STATE TABLE @0x801479F0 (0x2c byte / 0xb int stride per voice, indexed [voice]):
 *     int +0x00 (DAT_801479f0) hdr-word0   int +0x04 (DAT_801479f4)   int +0x0c (DAT_801479fc) bytePos<<12
 *     int +0x10 (DAT_80147a00) servedPos   int +0x14 (DAT_80147a04) loopLen<<12
 *     u16 +0x18 (DAT_80147a08) volAngle    u16 +0x1a (DAT_80147a0a) pitch base
 *     b   +0x1c (DAT_80147a0c) playstate   b +0x1e (DAT_80147a0e) route   b +0x1f (DAT_80147a0f) channels
 *     b   +0x20 (DAT_80147a10) link        b +0x21 (DAT_80147a11) linkflag  b +0x22/0x23 (a12/a13) lvl/fx
 *     b   +0x27 (DAT_80147a17) voice-done flag (bit7 set == done)
 *   PER-PLAYER ctx (pp = (&DAT_80147e10)[player], malloc'd in create, int-indexed):
 *     +0x00 spuAddr  +0x04 spuSize  +0x0c bufBytes  +0x14 writePos  +0x18 servePos  +0x1c lastNewPos
 *     +0x20 dmaHandle  +0x2c frameSizeTbl  +0x34..0x46 fill state  +0x42(b) activeNote(-1 idle)
 *     +0x44(u16) blockBytes  +0x46(u16) framesPerBlock  +0x48.. per-channel SPU buffer ptrs
 */

extern "C" int           sndgs[];
extern "C" int           sndpp;                 /* current-player IRQ cursor                 */
extern "C" int           DAT_80147e10;          /* per-player ctx ptr array  @0x80147e10     */
extern "C" int           DAT_80147e2c;          /* SPU control reg base (address) @0x80147e2c */
extern "C" int           DAT_801234e4;          /* SPU ctx malloc size        @0x801234e4    */
extern "C" unsigned char DAT_80147919;          /* setirq re-entry guard byte @0x80147919    */

/* packet-voice state table fields (byte base; cast for int/short views) */
extern "C" unsigned char DAT_801479f0;          /* +0x00 */
extern "C" unsigned char DAT_801479f4;          /* +0x04 */
extern "C" unsigned char DAT_801479fc;          /* +0x0c */
extern "C" unsigned char DAT_80147a00;          /* +0x10 */
extern "C" unsigned char DAT_80147a04;          /* +0x14 */
extern "C" unsigned char DAT_80147a08;          /* +0x18 */
extern "C" unsigned char DAT_80147a0a;          /* +0x1a */
extern "C" unsigned char DAT_80147a0c;          /* +0x1c playstate */
extern "C" unsigned char DAT_80147a0e;          /* +0x1e route     */
extern "C" unsigned char DAT_80147a0f;          /* +0x1f channels  */
extern "C" unsigned char DAT_80147a10;          /* +0x20 link      */
extern "C" unsigned char DAT_80147a11;          /* +0x21 link flag */
extern "C" unsigned char DAT_80147a12;          /* +0x22 level     */
extern "C" unsigned char DAT_80147a13;          /* +0x23 fx level  */
extern "C" unsigned char DAT_80147a17;          /* +0x27 voice-done flag */

/* host/IRQ hooks (function-pointer globals installed by play/stop) */
extern "C" void (*snd_voice_done_hook)(void *voice);   /* @0x8014803c */
extern "C" { void (*snd_voice_done_hook)(void *voice) = 0;  /* def @0x8014803c */
             void  *snd_user_serve_hook = 0; }              /* def @0x80148038 */
extern "C" void  *snd_user_serve_hook;                 /* @0x80148038 */
extern "C" void  *gPreLoadTicks;                       /* @0x80148040 (fn-ptr) */

/* sibling-obj dependencies */
extern "C" int  iSNDpsxmalloc(int size);                       /* sdmemman */
extern "C" void iSNDpsxfree(void *p);                          /* sdmemman */
extern "C" void iSNDpsxdisablespuirq(void);                    /* sdspuirq */
extern "C" void iSNDpsxenablespuirq(void);                     /* sdspuirq */
extern "C" void InterruptCallback(void);                       /* syslib INTR */
extern "C" int  iSNDpacketget(int p, int chanIdx, int *frameSizeOut);   /* spktplay */
extern "C" void iSNDpacketfreeframes(int p);                   /* spktplay */
extern "C" void iSNDstreamhotroddatachunks(void);              /* sst */
extern "C" int  iSNDdmqueue(int spuBuf);                       /* sdma */
extern "C" int  iSNDdmcomplete(int dmaHandle);                 /* sdma */
extern "C" void blockmove(int *dst, int *src, unsigned int len);  /* blkmov */
extern "C" int  iSNDplatformpitch(int chan, int pitch);        /* sdriver */
extern "C" void trap(unsigned int code);                       /* compiler div-by-zero break */

/* forward decls (mutually referential within this obj) */
extern "C" void iSNDpacketgetirq(void);
extern "C" void iSNDpacketsetirq(void);
extern "C" int  iSNDfillspuwithpackets(int p, int chunk);
extern "C" unsigned int iSNDpacketpurgeframes(int p, unsigned int byteoff, int count);
extern "C" int  iSNDpsxpacketstop(int p);
extern "C" void iSNDpsxzerospu(int *addr, int len);

#define VB(base,idx)  ((&(base))[idx])                 /* byte at base+idx        */
#define VI(base,idx)  (*(int *)(&(base) + (idx)))      /* int  at base+idx        */
#define VH(base,idx)  (*(short *)(&(base) + (idx)))    /* short at base+idx       */
#define VUH(base,idx) (*(unsigned short *)(&(base) + (idx)))

/* cop0-Status critical section wrapping the SPU-IRQ re-arm (target-only; host calls through). */
static void sdpacket_setirq_cs(void)
{
#if defined(__mips__)
    unsigned int sr;
    __asm__ volatile("mfc0 %0,$12" : "=r"(sr));
    __asm__ volatile("mtc0 %0,$12" : : "r"(sr & 0xfffffbfe));   /* mask IEc */
    iSNDpacketsetirq();
    __asm__ volatile("mtc0 %0,$12" : : "r"(sr));
#else
    iSNDpacketsetirq();
#endif
}

/* iSNDpacketgetirq @0x80103784 : on the SPU end-of-block IRQ, latch the current play byte-position of the
 *   active voice (and its linked partner) into the served-position slot, clamping at loop bounds. */
extern "C" void iSNDpacketgetirq(void)
{
    int pp = (&DAT_80147e10)[sndpp];
    int note = (int)*(char *)(pp + 0x42);
    int vt, link;
    if (note < 0)
        return;
    vt = note * 0x2c;
    if ((VI(DAT_801479fc, vt) >> 0xc <= (unsigned)*(unsigned short *)(pp + 0x40)) ||
        ((unsigned)(*(int *)(pp + 0xc) - (unsigned)*(unsigned short *)(pp + 0x40)) <=
         VI(DAT_801479fc, vt) >> 0xc)) {
        if ((unsigned)(VI(DAT_801479fc, vt) >> 0xb) < (unsigned)*(int *)(pp + 0xc)) {
            VI(DAT_80147a00, note * 0xb) = VI(DAT_801479fc, vt);
            if (-1 < (int)((unsigned)VB(DAT_80147a10, vt) << 0x18)) {
                link = (char)VB(DAT_80147a10, vt);
                VI(DAT_80147a00, link * 0xb) = VI(DAT_801479fc, vt);
            }
        } else {
            VI(DAT_801479fc, vt) = 0;
            if (-1 < (int)((unsigned)VB(DAT_80147a10, vt) << 0x18)) {
                link = (char)VB(DAT_80147a10, vt);
                VI(DAT_801479fc, link * 0x2c) = 0;
            }
        }
    }
}

/* iSNDpacketsetirq @0x801038BC : advance to the next playing player and arm the SPU IRQ on its next block
 *   boundary (writes the SPU IRQ-address register and re-installs the InterruptCallback). */
extern "C" void iSNDpacketsetirq(void)
{
    int i = 0;
    int pp;
    iSNDpsxdisablespuirq();
    if (DAT_80147919 == 0) {
        do {
            sndpp = sndpp + 1;
            if (0 < sndpp)
                sndpp = 0;                              /* single player -> wrap to 0 */
            pp = (&DAT_80147e10)[sndpp];
            if (pp != 0 && -1 < *(char *)(pp + 0x42)) {
                *(short *)(DAT_80147e2c + 0x1a4) = (short)(*(int *)pp + 8 >> 3);
                InterruptCallback();
                iSNDpsxenablespuirq();
                return;
            }
            i++;
        } while (i < 2);
    }
}

/* iSNDpacketirqcallback @0x8010399C : the SPU IRQ handler -- latch positions then re-arm. */
extern "C" void iSNDpacketirqcallback(void)
{
    iSNDpacketgetirq();
    iSNDpacketsetirq();
}

/* iSNDpsxzerospu @0x801039C4 : write SPU "silent loop" ADPCM (0x200 flag word + zero data) over `len`
 *   bytes at `addr`.  (Ghidra dropped the length arg as in_a1.) */
extern "C" void iSNDpsxzerospu(int *addr, int len)
{
    int i = 0;
    if (0 < len >> 2) {
        do {
            addr[0] = 0x200;
            addr[1] = 0;
            addr[2] = 0;
            addr[3] = 0;
            i += 4;
            addr += 4;
        } while (i < len >> 2);
    }
}

/* iSNDpacketpurgeframes @0x801039FC : release the packet frames that have finished playing, walking the
 *   ring from byte offset `byteoff` for `count` bytes and calling iSNDpacketfreeframes per channel as each
 *   frame's outstanding-byte counter drains.  Returns whether the cursor stayed within the buffer.
 *   (Ghidra rendered as __thiscall(this,p,arg2): this=player, p=byteoff, arg2=count.) */
extern "C" unsigned int iSNDpacketpurgeframes(int p, unsigned int byteoff, int count)
{
    int          pp = (&DAT_80147e10)[p];
    int          vt = *(char *)(pp + 0x42) * 0x2c;
    unsigned int blk, span, taken, wrapped;
    unsigned short *fcnt;
    unsigned short n;
    int          i;

    do {
        blk = (unsigned)*(unsigned short *)(pp + 0x46);
        span = (byteoff / blk + 1) * blk - byteoff;     /* bytes to next block boundary */
        if (count < (int)span)
            span = count;
        fcnt = (unsigned short *)((byteoff / blk) * 2 + *(int *)(pp + 0x2c));
        n = *fcnt;
        taken = span;
        if ((int)(unsigned)n < (int)span)
            taken = (unsigned)n;
        *fcnt = n - (unsigned short)taken;
        if (taken != 0 && VB(DAT_80147a0f, vt) != 0) {
            i = 0;
            do {
                iSNDpacketfreeframes(p);
                i++;
            } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
        }
        byteoff = byteoff + span;
        wrapped = (unsigned)(byteoff < *(unsigned int *)(pp + 0xc));
        /* @0x80103B14-1C: count -= span AND byteoff = 0 happen ONLY in the wrapped==0 (byteoff>=limit)
         * fall-through. The recon decremented count UNCONDITIONALLY, so the purge consumed `count` on
         * every step instead of only on a buffer wrap (M07). */
        if (wrapped == 0) {
            count = count - span;
            byteoff = 0;
        }
    } while (0 < count);
    return wrapped;
}

/* iSNDfillspuwithpackets @0x80103B54 : the core DMA pump -- pull packet frames (iSNDpacketget), block-move
 *   their ADPCM into each channel's SPU buffer, set the ADPCM loop/end flags for `chunk` of the double
 *   buffer, and queue the SPU DMA (iSNDdmqueue).  (Ghidra __thiscall(this,p): this=player, p=chunk; the
 *   uninit local_30 is iSNDpacketget's frameSize out-param.) */
extern "C" int iSNDfillspuwithpackets(int p, int chunk)
{
    int  pp = (&DAT_80147e10)[p];
    int  vt = *(char *)(pp + 0x42) * 0x2c;
    int  i, ch, dma;
    short rem;
    unsigned short take;
    int  *cbuf;
    short *ringp;
    int  frameSize = 0;
    int  avail;

    if (*(short *)(pp + 0x3c) == 0) {
        *(short *)(pp + 0x3e) = 0;
        *(short *)(pp + 0x3c) = *(short *)(pp + 0x44);
        *(short *)(chunk * 2 + *(int *)(pp + 0x2c)) = 0;
    }
    if (*(int *)(pp + 0x14) == 0) {                     /* fresh start -> silence all SPU channels */
        i = 0; ch = pp;
        if (VB(DAT_80147a0f, vt) != 0) {
            do { iSNDpsxzerospu(*(int **)(ch + 0x48), 0); i++; ch += 4; }
            while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
        }
        *(short *)(pp + 0x3e) = *(short *)(pp + 0x3e) + 0x10;
        *(short *)(pp + 0x3c) = *(short *)(pp + 0x3c) - 0x10;
    }
    rem = *(short *)(pp + 0x3c);
    for (;;) {
        if (rem == 0)
            goto queue_dma;
        take = *(unsigned short *)(pp + 0x34);
        if (take == 0) {                                /* need a new packet frame */
            i = 0; ch = pp;
            if (VB(DAT_80147a0f, vt) != 0) {
                do {
                    *(int *)(ch + 0x24) = iSNDpacketget(p, i, &frameSize);
                    i++; ch += 4;
                } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
            }
            if (*(int *)(pp + 0x24) == 0) {             /* no frame available -> finish/flush */
                avail = *(int *)(pp + 0x14) - *(int *)(pp + 0x18);
                if ((int)(unsigned)*(unsigned short *)(pp + 0x40) < avail)
                    return avail;
                if (*(unsigned short *)(pp + 0x38) < *(unsigned short *)(pp + 0x36))
                    goto advance;
                if (*(unsigned short *)(pp + 0x36) < 2) {     /* mark SPU loop-back */
                    i = 0; ch = pp;
                    if (VB(DAT_80147a0f, vt) != 0) {
                        do {
                            cbuf = (int *)(ch + 0x48); ch += 4;
                            iSNDpsxzerospu((int *)(*cbuf + (unsigned)*(unsigned short *)(pp + 0x3e)), 0);
                            i++;
                        } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
                    }
                } else {                                      /* mark SPU end (flag byte = 2) */
                    i = 0; ch = pp;
                    if (VB(DAT_80147a0f, vt) != 0) {
                        do {
                            *(char *)(*(int *)(ch + 0x48) + 1) = 2;
                            i++;
                            *(char *)((unsigned)*(unsigned short *)(pp + 0x44) + *(int *)(ch + 0x48) - 0xf) = 2;
                            ch += 4;
                        } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
                    }
                }
                if (*(short *)(pp + 0x3e) == 0)
                    *(short *)(pp + 0x36) = *(short *)(pp + 0x36) + 1;
                *(short *)(pp + 0x3c) = 0;
queue_dma:
                if (chunk == 0) {                        /* first chunk -> set SPU loop-start flag (|4) */
                    i = 0; ch = pp;
                    if (VB(DAT_80147a0f, vt) != 0) {
                        do {
                            cbuf = (int *)(ch + 0x48); ch += 4;
                            *(unsigned char *)(*cbuf + 1) |= 4;
                            i++;
                        } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
                    }
                } else if (chunk == *(unsigned short *)(pp + 0x38) - 1) {   /* last chunk -> loop-end (|1) */
                    i = 0; ch = pp;
                    if (VB(DAT_80147a0f, vt) != 0) {
                        do {
                            int e = (unsigned)*(unsigned short *)(pp + 0x44) + *(int *)(ch + 0x48);
                            *(unsigned char *)(e - 0xf) |= 1;
                            i++; ch += 4;
                        } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
                    }
                }
                i = 0; ch = pp;                          /* kick the SPU DMA for each channel */
                if (VB(DAT_80147a0f, vt) != 0) {
                    do {
                        dma = iSNDdmqueue(*(int *)(ch + 0x48));
                        *(int *)(pp + 0x20) = dma;
                        i++; ch += 4;
                    } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
                }
advance:
                *(short *)(pp + 0x3a) = (short)chunk;
                *(int *)(pp + 0x14) = *(int *)(pp + 0x14) + (unsigned)*(unsigned short *)(pp + 0x46);
                return *(int *)(pp + 0x14);
            }
            *(short *)(pp + 0x36) = 0;
            *(short *)(pp + 0x32) = 0;
            *(short *)(pp + 0x34) = (short)((frameSize * 4) / 7);   /* ADPCM bytes per chunk */
            *(short *)(pp + 0x30) = *(short *)(pp + 0x34);
            take = *(unsigned short *)(pp + 0x34);
        }
        if (take >= *(unsigned short *)(pp + 0x3c))
            take = *(unsigned short *)(pp + 0x3c);
        ringp = (short *)(chunk * 2 + *(int *)(pp + 0x2c));
        *ringp = *ringp + (short)((int)((unsigned)take * 7) >> 2);
        i = 0; ch = pp;
        if (VB(DAT_80147a0f, vt) != 0) {
            do {
                blockmove((int *)(*(int *)(pp + 0x24) + (unsigned)*(unsigned short *)(pp + 0x32) +
                                  (unsigned)*(unsigned short *)(pp + 0x30) * i),
                          (int *)(*(int *)(ch + 0x48) + (unsigned)*(unsigned short *)(pp + 0x3e)),
                          (unsigned)take);
                i++; ch += 4;
            } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
        }
        *(unsigned short *)(pp + 0x3e) = *(short *)(pp + 0x3e) + take;
        *(unsigned short *)(pp + 0x32) = *(short *)(pp + 0x32) + take;
        *(unsigned short *)(pp + 0x3c) = *(short *)(pp + 0x3c) - take;
        rem = *(short *)(pp + 0x3c);
        *(unsigned short *)(pp + 0x34) = *(short *)(pp + 0x34) - take;
    }
}

/* iSNDpacketserve @0x80104024 : per-tick service -- pull fresh stream chunks, advance each player's served
 *   position from the SPU play-cursor, purge finished frames, and top up the SPU double buffer. */
extern "C" void iSNDpacketserve(void)
{
    int p;
    iSNDstreamhotroddatachunks();
    for (p = 0; p < 1; p++) {
        int pp = (&DAT_80147e10)[p];
        if (pp != 0 && -1 < *(char *)(pp + 0x42)) {
            int servePos = *(int *)(pp + 0x1c);
            int newPos = (int)(*(unsigned int *)(&DAT_801479fc + *(char *)(pp + 0x42) * 0x2c) / 0x1c000) * 0x1c;
            unsigned int adv = (newPos < servePos) ? (unsigned)((newPos + *(int *)(pp + 0xc)) - servePos)
                                                   : (unsigned)(newPos - servePos);
            if (0x70ffffff < *(int *)(pp + 0x18)) {     /* keep the 64-bit-ish byte counters from overflowing */
                *(int *)(pp + 0x18) -= 0x70000000;
                *(int *)(pp + 0x14) -= 0x70000000;
            }
            *(int *)(pp + 0x18) += adv;
            iSNDpacketpurgeframes(p, (unsigned)servePos, (int)adv);
            /* @0x80104148-415C: *(pp+0x1c)=newPos (served-position advance) is stored ONLY when the
             * buffer-level check passes (bufLevel < threshold), BEFORE the iSNDdmcomplete refill gate.
             * The recon stored newPos UNCONDITIONALLY (before the check), advancing the served pos even
             * when the buffer was full enough that no refill was due (M08). */
            if (*(int *)(pp + 0x14) - *(int *)(pp + 0x18) < *(int *)(pp + 0x10)) {
                *(int *)(pp + 0x1c) = newPos;
                if (iSNDdmcomplete(*(int *)(pp + 0x20)) != 0) {
                    unsigned int idx = (unsigned)*(unsigned short *)(pp + 0x3a) + 1;
                    if (*(unsigned short *)(pp + 0x38) <= idx)
                        idx -= *(unsigned short *)(pp + 0x38);
                    iSNDfillspuwithpackets(p, (int)idx);
                }
            }
        }
    }
}

/* iSNDplatformpacketoverhead @0x801041B8 : per-player SPU-context byte overhead (the malloc'd voice ctx
 *   sized from DAT_801234e4, /4096 rounded up to 4, *2, + 0x1050).  (Ghidra emptied the delay-slot return.) */
extern "C" int iSNDplatformpacketoverhead(void)
{
    int v = DAT_801234e4;
    if (v < 0)
        v += 0xfff;
    v >>= 0xc;
    return ((v + 3) & ~3) * 2 + 0x1050;
}

/* iSNDplatformcalcdatarate @0x801041EC : bytes/second for a sample of rate `sample_rate[0]` and channel
 *   count `sample_rate[1]`, scaled by 0x92/256 (ADPCM ratio). */
extern "C" int iSNDplatformcalcdatarate(unsigned short *sample_rate)
{
    return (int)((unsigned)*sample_rate * (unsigned)(unsigned char)sample_rate[1] * 0x92) >> 8;
}

/* iSNDplatformpacketplaycreate @0x8010421C : allocate a player's SPU context, install the voice-done hook,
 *   register the ctx in DAT_80147e10[p].  Returns 0 / -9 on malloc failure. */
extern "C" int iSNDplatformpacketplaycreate(int p, int *mem)
{
    int r;
    snd_voice_done_hook = (void (*)(void *))iSNDpsxpacketstop;
    *(unsigned char *)((int)mem + 0x42) = 0xff;
    mem[0xb] = (int)(mem + 0x414);
    mem[0] = iSNDpsxmalloc(DAT_801234e4);
    mem[1] = DAT_801234e4;
    if (mem[0] == 0) {
        r = -9;
    } else {
        (&DAT_80147e10)[p] = (int)mem;
        r = 0;
    }
    return r;
}

/* iSNDplatformpacketplaydestroy @0x801042C0 : free a player's SPU context and clear its slot. */
extern "C" int iSNDplatformpacketplaydestroy(int p)
{
    int *pp = (int *)(&DAT_80147e10)[p];
    iSNDpsxfree((void *)*pp);
    (&DAT_80147e10)[p] = 0;
    return (int)pp;
}

/* iSNDplatformpacketplay @0x80104304 : start a voice playing a packet stream -- program the voice state
 *   table, derive the SPU block geometry from the player ctx, prime two buffers via iSNDfillspuwithpackets,
 *   install the serve + IRQ hooks, set initial pitch, and key the voice.  8-arg (Ghidra dropped a3..a8). */
extern "C" int iSNDplatformpacketplay(int p, int note, unsigned short volAngle, unsigned char level,
                                      int pitch, int a6, unsigned char fxlevel, unsigned short *hdr)
{
    int  vt = note * 0x2c;
    int *pp = (int *)(&DAT_80147e10)[p];
    unsigned int chunkBytes, frames, perCh;
    int  blockSamps;
    int  i;
    (void)a6;

    VB(DAT_80147a11, vt) = 0;
    VB(DAT_80147a10, vt) = 0xff;
    VB(DAT_80147a0e, vt) = 0;
    VB(DAT_80147a0f, vt) = (unsigned char)hdr[1];        /* channel count */
    VI(DAT_801479f4, vt) = 0;
    VUH(DAT_80147a08, vt) = volAngle;
    VB(DAT_80147a12, vt) = level;
    VB(DAT_80147a13, vt) = fxlevel;
    VI(DAT_801479f0, vt) = pp[0];
    VB(DAT_80147a17, vt) = (unsigned char)p;

    chunkBytes = 0x1000 / (unsigned char)VB(DAT_80147a0f, vt);
    *(short *)(pp + 0x11) = (short)chunkBytes;
    *(short *)((int)pp + 0x46) = (short)((int)(chunkBytes * 0x1c) >> 4);
    {
        unsigned char ch = (unsigned char)VB(DAT_80147a0f, vt);
        pp[0x12] = (int)(pp + 0x14);
        *(char *)((int)pp + 0x43) = (char)(0xd - ch);
        pp[0x13] = (int)pp + *(unsigned short *)(pp + 0x11) + 0x50;
        blockSamps = (int)pp[1] >> (0xd - ch & 0x1f);
    }
    *(short *)(pp + 0xe) = (short)blockSamps;
    frames = (unsigned)(blockSamps & 0xffff);
    perCh = (unsigned char)VB(DAT_80147a0f, vt);
    *(short *)(pp + 0xe) = (short)(frames / perCh);
    {
        int total = (int)(frames / perCh) * *(unsigned short *)((int)pp + 0x46);
        *(short *)(pp + 0x10) = *(short *)((int)pp + 0x46);
        *(char *)((int)pp + 0x42) = (char)note;
        *(short *)((int)pp + 0x36) = 0;
        *(short *)(pp + 0xc) = 0;
        *(short *)(pp + 0xd) = 0;
        *(short *)((int)pp + 0x32) = 0;
        *(short *)(pp + 0xf) = 0;
        pp[9] = 0; pp[8] = 0; pp[7] = 0; pp[6] = 0; pp[5] = 0;
        pp[2] = (unsigned)*(unsigned short *)(pp + 0xe) << (*(unsigned char *)((int)pp + 0x43) & 0x1f);
        pp[3] = total;
        pp[4] = total - (unsigned)*(unsigned short *)((int)pp + 0x46);
    }
    i = 0;
    do {
        while (iSNDdmcomplete(pp[8]) == 0) { }
        iSNDfillspuwithpackets(p, i);
        i++;
    } while (i < 2);

    snd_user_serve_hook = (void *)iSNDpacketserve;
    gPreLoadTicks = (void *)iSNDpacketsetirq;
    VI(DAT_801479fc, vt) = 0;
    VI(DAT_80147a00, note * 0xb) = 0;
    VI(DAT_80147a04, vt) = pp[3] << 0xc;
    VH(DAT_80147a0a, vt) = (short)((unsigned)*hdr * 0x17c7 >> 0x10);
    if (1 < (unsigned char)VB(DAT_80147a0f, vt)) {       /* arm the linked partner voice */
        VB(DAT_80147a10, vt) = *(unsigned char *)(note * 100 + sndgs[0x25] + 4);
        VB(DAT_80147a11, (char)VB(DAT_80147a10, vt) * 0x2c) = 1;
        VI(DAT_801479fc, (char)VB(DAT_80147a10, vt) * 0x2c) = 0;
        VI(DAT_80147a00, (char)VB(DAT_80147a10, vt) * 0xb) = 0;
        VI(DAT_80147a04, (char)VB(DAT_80147a10, vt) * 0x2c) = VI(DAT_80147a04, vt);
    }
    iSNDplatformpitch(note, pitch);
    sdpacket_setirq_cs();
    VB(DAT_80147a0c, vt) = 1;                             /* playstate = playing */
    return 0;
}

/* iSNDpsxpacketstop @0x801046C8 : tear down a finished voice -- mark its player + voice slot idle, and if no
 *   voices remain active, drop the serve hook and point the pre-load tick back at the bare IRQ re-arm. */
extern "C" int iSNDpsxpacketstop(int p)
{
    int pp = (&DAT_80147e10)[(int)(signed char)*(unsigned char *)(p + 0x27)];
    int i, active = 0;
    *(char *)(pp + 0x42) = (char)0xff;
    *(char *)(p + 0x27)  = (char)0xff;
    if (((unsigned char *)sndgs)[0x11] != 0) {           /* sndgs[4]._1_1_ = channel count */
        for (i = 0; i < (int)(unsigned)((unsigned char *)sndgs)[0x11]; i++)
            if (-1 < (int)((unsigned)VB(DAT_80147a17, i * 0x2c) << 0x18))   /* bit7 clear == still active */
                active++;
    }
    if (active == 0) {
        snd_user_serve_hook = 0;
        gPreLoadTicks = (void *)iSNDpacketsetirq;
    }
    sdpacket_setirq_cs();
    return pp;
}
