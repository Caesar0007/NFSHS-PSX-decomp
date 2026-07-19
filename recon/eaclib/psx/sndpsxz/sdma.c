/* eaclib/psx/sndpsxz/sdma.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
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

extern int            sndgs[];
extern unsigned char  sndpd[];              /* voice/queue state base @0x80147918 (shared) -- UNSIZED
                                              * array: forces the oracle's `lui;addiu &sndpd; op N(base)`
                                              * base+offset shape instead of folding each field into its
                                              * own absolute symbol (same lever as spatkey.c). ALL the
                                              * DMA-queue state below is really `sndpd+offset`, confirmed
                                              * byte-for-byte from the raw oracle (e.g. iSNDdmcallback's
                                              * `lbu v1,0xD(a0)` where a0=sndpd -- NOT a separately
                                              * materialized DAT_80147925 symbol). */
#define SNDPD_PRELOAD    (*(unsigned char *)(sndpd + 0x1))    /* pre-load guard (shared w/ sdpacket) */
#define SNDPD_HANDLEID   (*(int *)(sndpd + 0x8))              /* rolling DMA handle id */
#define SNDPD_INFLIGHT   (*(signed char *)(sndpd + 0xC))      /* in-flight transfer count */
#define SNDPD_ACTIVESLOT (*(signed char *)(sndpd + 0xD))      /* active queue slot index (SIGNED) */
#define SNDPD_BUSY       (*(unsigned char *)(sndpd + 0xE))    /* DMA-busy flag */
/* DMA QUEUE entry (sndpd+0x10, 0x14 stride, 10 slots):
 *   +0x00 handle(int,0==free) +0x04 dst_spu(int) +0x08 src_ram>>3(u16) +0x0a len/64(u8)
 *   +0x0b priority(u8) +0x0c flag(u8) +0x10 deadline(int) */
#define SNDPD_Q_HANDLE(off)   (*(int *)(sndpd + 0x10 + (off)))
#define SNDPD_Q_DSTSPU(off)   (*(int *)(sndpd + 0x14 + (off)))
#define SNDPD_Q_SRCHI(off)    (*(unsigned short *)(sndpd + 0x18 + (off)))
#define SNDPD_Q_LEN64(off)    (*(unsigned char *)(sndpd + 0x1A + (off)))
#define SNDPD_Q_PRIO(off)     (*(unsigned char *)(sndpd + 0x1B + (off)))
#define SNDPD_Q_FLAG(off)     (*(unsigned char *)(sndpd + 0x1C + (off)))
#define SNDPD_Q_DEADLINE(off) (*(int *)(sndpd + 0x20 + (off)))
#define SNDPD_CTRLREG    (*(int *)(sndpd + 0x514))            /* SPU control reg base (address) */
extern unsigned int  *DAT_80147e14;         /* DMA4 ctrl reg ptr  */
extern unsigned int  *DAT_80147e18;         /* DMA4 MADR reg ptr  */
extern unsigned int  *DAT_80147e1c;         /* DMA4 BCR  reg ptr  */
extern unsigned int  *DAT_80147e20;         /* DMA4 CHCR reg ptr  */
extern void (*gPreLoadTicks)(void);         /* pre-load tick hook @0x80148040 */

extern void iSNDdmtransfer(void);                                              /* @0x8010A880 */
extern void iSNDdmcallback(void);                                              /* @0x8010AA64 */
extern void iSNDdmservice(void);                                               /* @0x8010AC20 */
extern int  iSNDdmqueue(int dst_spu, unsigned int src_ram, int len,
                            unsigned char prio, unsigned char flag);               /* @0x8010ACA0 */
extern int  iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, unsigned char prio);

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
extern void iSNDdmtransfer(void)
{
    unsigned int sr = rd_sr();
    int   i, slot, so;
    unsigned char bestPrio;
    unsigned int  bestHandle;

    wr_sr(rd_sr() & 0xfffffbfe);
    bestHandle = 0xffffffff;
    if ((int)((unsigned)SNDPD_INFLIGHT << 0x18) < 1) {     /* nothing queued */
        wr_sr(rd_sr());
        return;
    }
    bestPrio = 0;
    SNDPD_BUSY = 1;
    i = 0;
    do {
        so = i * 0x14;
        if (SNDPD_Q_HANDLE(so) != 0) {                    /* active entry */
            if (bestPrio < SNDPD_Q_PRIO(so)) {
                bestHandle = SNDPD_Q_HANDLE(so);
                bestPrio = SNDPD_Q_PRIO(so);
                SNDPD_ACTIVESLOT = (signed char)i;
            } else if (SNDPD_Q_PRIO(so) == bestPrio && (unsigned)SNDPD_Q_HANDLE(so) < bestHandle) {
                bestHandle = SNDPD_Q_HANDLE(so);
                SNDPD_ACTIVESLOT = (signed char)i;
            }
        }
        i++;
    } while (i < 10);

    slot = (int)SNDPD_ACTIVESLOT;
    so = slot * 0x14;
    if (SNDPD_Q_FLAG(so) != 0 && (SNDPD_PRELOAD = 1, gPreLoadTicks != 0))
        (*gPreLoadTicks)();
    SNDPD_Q_DEADLINE(so) = sndgs[0x11] + 0xf;                                /* deadline */
    *(unsigned short *)(SNDPD_CTRLREG + 0x1a6) = SNDPD_Q_SRCHI(so);          /* SPU transfer addr */
    *(unsigned short *)(SNDPD_CTRLREG + 0x1aa) =
        *(unsigned short *)(SNDPD_CTRLREG + 0x1aa) & 0xffcf | 0x20;         /* SPUCNT: DMA write */
    *DAT_80147e14 = *DAT_80147e14 & 0xf0ffffff | 0x20000000;                /* DPCR */
    *DAT_80147e18 = SNDPD_Q_DSTSPU(so);                                     /* MADR */
    *DAT_80147e1c = (unsigned int)SNDPD_Q_LEN64(so) << 0x10 | 0x10;         /* BCR */
    *DAT_80147e20 = 0x1000201;                                             /* CHCR: start */
    wr_sr(sr);
}

/* iSNDdmcallback @0x8010AA64 : DMA-done handler -- settle SPUCNT, retire the active entry, fire the next. */
extern void iSNDdmcallback(void)
{
    unsigned int sr;
    volatile int i;
    volatile int mult = 13;
    int active;

    /* MATCH: this is NOT a plain counter -- gcc round-trips a dummy multiply AND the counter through
     * the stack every iteration (a real busy-wait/settle delay technique), not a simple spin++. Both
     * `mult` and `i` must be volatile to force the store/reload each pass. */
    for (i = 0; i < 0x2ee; i++)
        mult = mult * 13;
    *(unsigned short *)(SNDPD_CTRLREG + 0x1aa) = *(unsigned short *)(SNDPD_CTRLREG + 0x1aa) & 0xffcf;
    if ((*(unsigned short *)(SNDPD_CTRLREG + 0x1aa) & 0x30) != 0) {
        i = 1;
        do {
            if (4000 < i) break;
            i++;
        } while ((*(unsigned short *)(SNDPD_CTRLREG + 0x1aa) & 0x30) != 0);
    }
    /* MATCH: the active-entry VALUE is loaded BEFORE the critical section is entered (mfc0 -- the
     * oracle's ONLY SR-save mfc0 in this function sits here, not at function entry); sr is captured
     * at this exact point, not earlier. */
    active = SNDPD_Q_HANDLE(SNDPD_ACTIVESLOT * 0x14);
    sr = rd_sr();
    wr_sr(sr & 0xfffffbfe);
    if (active != 0) {        /* active entry present */
        if (SNDPD_PRELOAD != 0 && (SNDPD_PRELOAD = 0, gPreLoadTicks != 0))
            (*gPreLoadTicks)();
        SNDPD_Q_HANDLE(SNDPD_ACTIVESLOT * 0x14) = 0;      /* free the slot */
        SNDPD_INFLIGHT = SNDPD_INFLIGHT - 1;
        if ((int)((unsigned)SNDPD_INFLIGHT << 0x18) < 1) { /* queue now empty */
            wr_sr(sr);
            SNDPD_BUSY = 0;
            return;
        }
    }
    wr_sr(sr);
    iSNDdmtransfer();
}

/* iSNDdmservice @0x8010AC20 : per-tick pump -- start a transfer if idle, or complete one past its deadline. */
extern void iSNDdmservice(void)
{
    if (SNDPD_BUSY == 0)
        iSNDdmtransfer();
    else if ((unsigned int)SNDPD_Q_DEADLINE(SNDPD_ACTIVESLOT * 0x14) <= (unsigned int)sndgs[0x11])
        iSNDdmcallback();
}

/* iSNDdmqueue @0x8010ACA0 : enqueue a RAM->SPU transfer (len rounded to 64 bytes), returning its handle (or
 *   0 if the 10-slot queue is full).  5-arg (Ghidra dropped src_ram/len/prio/flag). */
extern int iSNDdmqueue(int dst_spu, unsigned int src_ram, int len, unsigned char prio, unsigned char flag)
{
    int  id, i = 0, so;
    if ((len & 0x3f) != 0)
        len = len + 0x40;
    SNDPD_HANDLEID = SNDPD_HANDLEID + 1;
    wr_sr(rd_sr() & 0xfffffbfe);
    if (SNDPD_HANDLEID == 0)
        SNDPD_HANDLEID = 1;
    id = SNDPD_HANDLEID;
    do {
        so = i * 0x14;
        i++;
        if (SNDPD_Q_HANDLE(so) == 0) {
            SNDPD_INFLIGHT = SNDPD_INFLIGHT + 1;
            SNDPD_Q_DSTSPU(so) = dst_spu;
            SNDPD_Q_HANDLE(so) = id;
            SNDPD_Q_SRCHI(so) = (unsigned short)(src_ram >> 3);
            SNDPD_Q_LEN64(so) = (unsigned char)(len >> 6);
            SNDPD_Q_PRIO(so) = prio;
            SNDPD_Q_FLAG(so) = flag;
            wr_sr(rd_sr());
            iSNDdmservice();
            return SNDPD_HANDLEID;
        }
    } while (i < 10);
    wr_sr(rd_sr());
    return 0;
}

/* iSNDdmqueuesplit @0x8010AD94 : enqueue a large transfer as 4 KB chunks, draining the queue when it backs
 *   up (>3 in flight).  Returns the last chunk's handle.  (Ghidra dropped the per-chunk iSNDdmqueue args.) */
extern int iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, unsigned char prio)
{
    int r = 0, chunk;
    while (0 < len) {
        chunk = (len < 0x1000) ? len : 0x1000;
        while (10 - (int)SNDPD_INFLIGHT < 7)
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
extern int iSNDdmcomplete(int handle)
{
    int i = 0, so;
    iSNDdmservice();
    if (0 < (int)((unsigned)SNDPD_INFLIGHT << 0x18)) {
        do {
            so = i * 0x14;
            i++;
            if (SNDPD_Q_HANDLE(so) == handle)
                return 0;
        } while (i < 10);
    }
    return 1;
}
