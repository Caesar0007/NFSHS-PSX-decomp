/* eaclib/psx/sndpsxz/sdma.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
 *   Source obj : nfs4\eaclib\psx\sdma.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   6 fns @[0x8010A880 .. 0x8010AE6C].  RAM->SPU DMA queue -- up to 10 pending transfers serviced by
 *   priority, driven from the SPU IRQ / per-tick service.  Ghidra nfs4-f.exe.c (sdma) + disasm-v3 for the
 *   args Ghidra dropped: iSNDdmqueue is 5-ARG (dst_spu,src_ram,len,prio,flag) and iSNDdmqueuesplit forwards
 *   (dst,src,chunk,prio,0) advancing both dst+src per 4 KB chunk (Ghidra showed only the 1-arg call).
 *
 *   DMA QUEUE entry (DAT_80147928, 0x14 stride, 10 slots):
 *     +0x00 handle(int, 0==free)  +0x04 dst_spu(int)  +0x08 src_ram>>3(u16)  +0x0a len/64(u8)
 *     +0x0b priority(u8)  +0x0c flag(u8)  +0x10 deadline(int, = sndgs[0x11]+0xf)
 *   State: DAT_80147920 handle counter, DAT_80147924 in-flight count, DAT_80147925 active slot,
 *          DAT_80147926 busy flag, DAT_80147919 pre-load guard (shared with sdpacket).
 */

extern "C" int            sndgs[];
extern "C" unsigned char  sndpd;                /* voice/queue base @0x80147918 (shared) */
extern "C" unsigned char  DAT_80147919;         /* pre-load guard */
extern "C" int            DAT_80147920;         /* rolling DMA handle id */
extern "C" signed char    DAT_80147924;         /* in-flight transfer count */
extern "C" char           DAT_80147925;         /* active queue slot index  */
extern "C" char           DAT_80147926;         /* DMA-busy flag            */
extern "C" int            DAT_80147928;         /* DMA queue table base (int[]) */
extern "C" int            DAT_8014792c;         /* entry +0x04 dst_spu      */
extern "C" unsigned short DAT_80147930;         /* entry +0x08 src>>3 (SPU xfer addr) */
extern "C" unsigned char  DAT_80147932;         /* entry +0x0a len/64 (DMA BCR) */
extern "C" unsigned char  DAT_80147934;         /* entry +0x0c flag         */
extern "C" int            DAT_80147938;         /* entry +0x10 deadline     */
extern "C" int            DAT_80147e2c;         /* SPU control reg base (address) */
extern "C" unsigned int  *DAT_80147e14;         /* DMA4 ctrl reg ptr  */
extern "C" unsigned int  *DAT_80147e18;         /* DMA4 MADR reg ptr  */
extern "C" unsigned int  *DAT_80147e1c;         /* DMA4 BCR  reg ptr  */
extern "C" unsigned int  *DAT_80147e20;         /* DMA4 CHCR reg ptr  */
extern "C" void (*gPreLoadTicks)(void);         /* pre-load tick hook @0x80148040 */

extern "C" void iSNDdmtransfer(void);                                              /* @0x8010A880 */
extern "C" void iSNDdmcallback(void);                                              /* @0x8010AA64 */
extern "C" void iSNDdmservice(void);                                               /* @0x8010AC20 */
extern "C" int  iSNDdmqueue(int dst_spu, unsigned int src_ram, int len,
                            unsigned char prio, unsigned char flag);               /* @0x8010ACA0 */
extern "C" int  iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, unsigned char prio);

/* cop0 Status read/write -- the queue mutations run with interrupts masked on target (host: plain). */
#if defined(__mips__)
static inline unsigned int rd_sr(void) { unsigned int s; __asm__ volatile("mfc0 %0,$12" : "=r"(s)); return s; }
static inline void wr_sr(unsigned int s) { __asm__ volatile("mtc0 %0,$12" : : "r"(s)); }
#else
static unsigned int g_sr = 0;
static inline unsigned int rd_sr(void) { return g_sr; }
static inline void wr_sr(unsigned int s) { g_sr = s; }
#endif

/* iSNDdmtransfer @0x8010A880 : pick the highest-priority queued transfer and kick the SPU-write DMA for it. */
extern "C" void iSNDdmtransfer(void)
{
    unsigned int sr = rd_sr();
    int  *e;
    int   i, slot, so;
    unsigned char bestPrio;
    unsigned int  bestHandle;

    wr_sr(rd_sr() & 0xfffffbfe);
    bestHandle = 0xffffffff;
    if ((int)((unsigned)DAT_80147924 << 0x18) < 1) {     /* nothing queued */
        wr_sr(rd_sr());
        return;
    }
    bestPrio = 0;
    DAT_80147926 = 1;
    i = 0;
    e = &DAT_80147928;
    do {
        if (*e != 0) {                                   /* active entry */
            if (bestPrio < *(unsigned char *)((int)e + 0xb)) {
                bestHandle = *e;
                bestPrio = *(unsigned char *)((int)e + 0xb);
                DAT_80147925 = (char)i;
            } else if (*(unsigned char *)((int)e + 0xb) == bestPrio && (unsigned)*e < bestHandle) {
                bestHandle = *e;
                DAT_80147925 = (char)i;
            }
        }
        i++;
        e += 5;
    } while (i < 10);

    slot = (int)DAT_80147925;
    so = slot * 0x14;
    if ((&DAT_80147934)[so] != 0 && (DAT_80147919 = 1, gPreLoadTicks != 0))
        (*gPreLoadTicks)();
    *(int *)(&DAT_80147938 + so) = sndgs[0x11] + 0xf;                       /* deadline */
    *(unsigned short *)(DAT_80147e2c + 0x1a6) = (&DAT_80147930)[slot * 10]; /* SPU transfer addr */
    *(unsigned short *)(DAT_80147e2c + 0x1aa) =
        *(unsigned short *)(DAT_80147e2c + 0x1aa) & 0xffcf | 0x20;          /* SPUCNT: DMA write */
    *DAT_80147e14 = *DAT_80147e14 & 0xf0ffffff | 0x20000000;                /* DPCR */
    *DAT_80147e18 = (&DAT_8014792c)[slot * 5];                              /* MADR */
    *DAT_80147e1c = (unsigned int)(unsigned char)(&DAT_80147932)[so] << 0x10 | 0x10;  /* BCR */
    *DAT_80147e20 = 0x1000201;                                             /* CHCR: start */
    wr_sr(sr);
}

/* iSNDdmcallback @0x8010AA64 : DMA-done handler -- settle SPUCNT, retire the active entry, fire the next. */
extern "C" void iSNDdmcallback(void)
{
    unsigned int sr = rd_sr();
    int i, spin = 0;

    do { spin++; } while (spin < 0x2ee);                 /* settle delay */
    *(unsigned short *)(DAT_80147e2c + 0x1aa) = *(unsigned short *)(DAT_80147e2c + 0x1aa) & 0xffcf;
    if ((*(unsigned short *)(DAT_80147e2c + 0x1aa) & 0x30) != 0) {
        i = 1;
        do {
            if (4000 < i) break;
            i++;
        } while ((*(unsigned short *)(DAT_80147e2c + 0x1aa) & 0x30) != 0);
    }
    wr_sr(rd_sr() & 0xfffffbfe);
    if ((&DAT_80147928)[DAT_80147925 * 5] != 0) {        /* active entry present */
        if (DAT_80147919 != 0 && (DAT_80147919 = 0, gPreLoadTicks != 0))
            (*gPreLoadTicks)();
        (&DAT_80147928)[DAT_80147925 * 5] = 0;           /* free the slot */
        DAT_80147924 = DAT_80147924 - 1;
        if ((int)((unsigned)DAT_80147924 << 0x18) < 1) { /* queue now empty */
            wr_sr(sr);
            DAT_80147926 = 0;
            return;
        }
    }
    wr_sr(sr);
    iSNDdmtransfer();
}

/* iSNDdmservice @0x8010AC20 : per-tick pump -- start a transfer if idle, or complete one past its deadline. */
extern "C" void iSNDdmservice(void)
{
    if (DAT_80147926 == 0)
        iSNDdmtransfer();
    else if (*(unsigned int *)(&DAT_80147938 + DAT_80147925 * 0x14) <= (unsigned int)sndgs[0x11])
        iSNDdmcallback();
}

/* iSNDdmqueue @0x8010ACA0 : enqueue a RAM->SPU transfer (len rounded to 64 bytes), returning its handle (or
 *   0 if the 10-slot queue is full).  5-arg (Ghidra dropped src_ram/len/prio/flag). */
extern "C" int iSNDdmqueue(int dst_spu, unsigned int src_ram, int len, unsigned char prio, unsigned char flag)
{
    int *e;
    int  id, i = 0;
    if ((len & 0x3f) != 0)
        len = len + 0x40;
    DAT_80147920 = DAT_80147920 + 1;
    wr_sr(rd_sr() & 0xfffffbfe);
    if (DAT_80147920 == 0)
        DAT_80147920 = 1;
    id = DAT_80147920;
    e = &DAT_80147928;
    do {
        i++;
        if (*e == 0) {
            DAT_80147924 = DAT_80147924 + 1;
            e[1] = dst_spu;
            *e = id;
            *(short *)(e + 2) = (short)(src_ram >> 3);
            *(char *)((int)e + 10) = (char)(len >> 6);
            *(unsigned char *)((int)e + 0xb) = prio;
            *(unsigned char *)(e + 3) = flag;
            wr_sr(rd_sr());
            iSNDdmservice();
            return DAT_80147920;
        }
        e += 5;
    } while (i < 10);
    wr_sr(rd_sr());
    return 0;
}

/* iSNDdmqueuesplit @0x8010AD94 : enqueue a large transfer as 4 KB chunks, draining the queue when it backs
 *   up (>3 in flight).  Returns the last chunk's handle.  (Ghidra dropped the per-chunk iSNDdmqueue args.) */
extern "C" int iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, unsigned char prio)
{
    int r = 0, chunk;
    while (0 < len) {
        chunk = (len < 0x1000) ? len : 0x1000;
        while (10 - (int)DAT_80147924 < 7)
            iSNDdmservice();
        r = iSNDdmqueue(dst_spu, src_ram, chunk, prio, 0);
        dst_spu += chunk;
        len -= chunk;
        src_ram += chunk;
    }
    return r;
}

/* iSNDdmcomplete @0x8010AE6C : has the transfer with handle `handle` finished?  Services the queue, then
 *   scans for the handle -- returns 0 if still pending, 1 if done/absent. */
extern "C" int iSNDdmcomplete(int handle)
{
    unsigned char *p;
    int i = 0;
    iSNDdmservice();
    p = &sndpd;
    if (0 < (int)((unsigned)DAT_80147924 << 0x18)) {
        do {
            i++;
            if (*(int *)(p + 0x10) == handle)
                return 0;
            p += 0x14;
        } while (i < 10);
    }
    return 1;
}
