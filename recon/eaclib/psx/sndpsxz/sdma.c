/* eaclib/psx/sndpsxz/sdma.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/6 PASS ***
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
struct SNDDmaEntry {
    volatile int handle;
    int dstSpu;
    unsigned short srcHi;
    unsigned char len64;
    volatile unsigned char priority;
    unsigned char flag;
    unsigned char pad[3];
    volatile int deadline;
};
extern unsigned int  *DAT_80147e14;         /* DMA4 ctrl reg ptr  */
extern unsigned int  *DAT_80147e18;         /* DMA4 MADR reg ptr  */
extern unsigned int  *DAT_80147e1c;         /* DMA4 BCR  reg ptr  */
extern unsigned int  *DAT_80147e20;         /* DMA4 CHCR reg ptr  */
extern void (*gPreLoadTicks)(void);         /* pre-load tick hook @0x80148040 */

extern void iSNDdmtransfer(void);                                              /* @0x8010A880 */
extern void iSNDdmcallback(void);                                              /* @0x8010AA64 */
extern void iSNDdmservice(void);                                               /* @0x8010AC20 */
extern int  iSNDdmqueue(int dst_spu, unsigned int src_ram, int len,
                            int prio, int flag);                                    /* @0x8010ACA0 */
extern int  iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, int prio);

/* cop0 Status read/write -- the queue mutations run with interrupts masked on target (host: plain).
 * The callback uses one explicit CP0 transaction macro because the R3000 Status write requires three
 * architectural hazard slots.  Keeping that handwritten instruction sequence localized here also
 * preserves the oracle's fixed $at mask / $t0 result registers without putting asm in the C logic. */
#if defined(__mips__)
static inline unsigned int rd_sr(void) { unsigned int s; __asm__ volatile("mfc0 %0,$12" : "=r"(s)); return s; }
static inline void wr_sr(unsigned int s) { __asm__ volatile("mtc0 %0,$12" : : "r"(s)); }
#define MASK_INTERRUPTS_SR(sr)                                                   \
    __asm__ volatile(                                                           \
        "mfc0 %0,$12\n\t"                                                      \
        "nop\n\t"                                                               \
        "li $1,-1026\n\t"                                                      \
        "and $8,%0,$1\n\t"                                                     \
        "mtc0 $8,$12\n\t"                                                      \
        "nop\n\t"                                                               \
        "nop\n\t"                                                               \
        "nop"                                                                   \
        : "=r"(sr) : : "$1", "$8", "memory")
#else
static unsigned int g_sr = 0;
static inline unsigned int rd_sr(void) { return g_sr; }
static inline void wr_sr(unsigned int s) { g_sr = s; }
#define MASK_INTERRUPTS_SR(sr) do { (sr) = rd_sr(); wr_sr((sr) & 0xfffffbfe); } while (0)
#endif

/* iSNDdmtransfer @0x8010A880 : pick the highest-priority queued transfer and kick the SPU-write DMA for it. */
extern void iSNDdmtransfer(void)
{
    unsigned int sr;
    int i;
    unsigned char inflight;
    int inflightValue;
    unsigned int bestPrio;
    unsigned int bestHandle;
    unsigned char *pd;
    unsigned char *scanBase;
    struct SNDDmaEntry *scanEntry;
    struct SNDDmaEntry *activeEntry;

    /* MATCH: retain one sndpd base through the queue scan, but use separate scan-entry and active-entry
     * pointers so only the latter crosses the optional preload-hook call in $s0.  Volatile handle/priority
     * fields suppress gcc's extra strength-reduced priority pointer and reproduce the oracle's repeated
     * fixed-offset loads.  The inflight byte is loaded before the explicit CP0 transaction and shifted
     * afterwards, filling the Status-register hazard window exactly.  The post-hook hardware block uses
     * fresh sndpd/sndgs bases and volatile register-pointer loads in their observed order.
     * MATCH (w34-a5, 14->0 PASS): the active-slot address is TWO cooperating levers, both required:
     *   1. EMBEDDED ASSIGNMENT on the queue base -- `idx*0x14 + (qbase = (int)tailBase + 0x10)`.
     *      A plain `(struct SNDDmaEntry *)(tailBase + 0x10) + idx` lets fold() REASSOCIATE the
     *      constants into the index chain (`sll;addu;sll; addiu v0,v0,16; addu s0,v0,a0`), where
     *      the oracle keeps base+0x10 as its OWN late `addiu v0,a0,16` added to the scaled index
     *      (`addu s0,v1,v0`).  The MODIFY_EXPR blocks the reassociation AND gives qbase a later
     *      luid so the add lands after the multiply chain.
     *   2. The sign-extend + scale must be ONE ANONYMOUS EXPRESSION -- a named `activeIndex`
     *      (fn- or block-scope) carries a scope (use reg) marker that sched1 hoists above the def,
     *      bloating its live range into a hard-reg conflict -> `sll v1,v0,24` (copy form) plus a
     *      uniform v0<->v1 swap over the whole address chain.  Anonymous ties in local-alloc ->
     *      in-place `sll v0,v0,24; sra v0,v0,24` exactly like the oracle.  (Same lever the sibling
     *      sdpacket.c iSNDpacketgetirq needed in w31.) */
    pd = sndpd;
    inflight = *(volatile unsigned char *)(pd + 0xc);
    MASK_INTERRUPTS_SR(sr);
    inflightValue = (int)((unsigned)inflight << 0x18);
    bestHandle = 0xffffffff;
    if (inflightValue < 1) {                               /* nothing queued */
        wr_sr(sr);
        return;
    }
    bestPrio = 0;
    pd[0xe] = 1;
    i = bestPrio;
    scanBase = pd;
    scanEntry = (struct SNDDmaEntry *)(scanBase + 0x10);
    do {
        if (scanEntry->handle != 0) {                     /* active entry */
            if (bestPrio < scanEntry->priority) {
                scanBase[0xd] = (signed char)i;
                bestHandle = scanEntry->handle;
                bestPrio = scanEntry->priority;
            } else if (scanEntry->priority == bestPrio &&
                       (unsigned)scanEntry->handle < bestHandle) {
                scanBase[0xd] = (signed char)i;
                bestHandle = scanEntry->handle;
            }
        }
        i++;
        scanEntry++;
    } while (i < 10);

    {
        unsigned char *tailBase = sndpd;
        int qbase;
        activeEntry = (struct SNDDmaEntry *)
            (((((int)*(volatile unsigned char *)(tailBase + 0xd)) << 24) >> 24) * 0x14
             + (qbase = (int)tailBase + 0x10));
        if (activeEntry->flag != 0) {
            void (*hook)(void) = *(void (**)(void))(tailBase + 0x728);
            *(volatile unsigned char *)(tailBase + 1) = 1;
            if (hook != 0)
                (*hook)();
        }
    }
    {
        int gsAddr = (int)sndgs;
        unsigned char *hwBase = sndpd;
        int ctrl;
        volatile unsigned int *dpcr;
        activeEntry->deadline = *(volatile int *)(gsAddr + 0x44) + 0xf;
        ctrl = *(volatile int *)(hwBase + 0x514);
        *(volatile unsigned short *)(ctrl + 0x1a6) = activeEntry->srcHi;
        ctrl = *(volatile int *)(hwBase + 0x514);
        *(volatile unsigned short *)(ctrl + 0x1aa) =
            *(volatile unsigned short *)(ctrl + 0x1aa) & 0xffcf | 0x20;
        dpcr = *(volatile unsigned int **)(hwBase + 0x4fc);
        *dpcr = *dpcr & 0xf0ffffff | 0x20000000;
        *(volatile unsigned int *)(*(volatile int *)(hwBase + 0x500)) = activeEntry->dstSpu;
        *(volatile unsigned int *)(*(volatile int *)(hwBase + 0x504)) =
            (unsigned int)activeEntry->len64 << 0x10 | 0x10;
        *(volatile unsigned int *)(*(volatile int *)(hwBase + 0x508)) = 0x1000201;
    }
    wr_sr(sr);
}

/* iSNDdmcallback @0x8010AA64 : DMA-done handler -- settle SPUCNT, retire the active entry, fire the next. */
extern void iSNDdmcallback(void)
{
    unsigned int sr;
    volatile int i;
    volatile int mult = 13;
    signed char slot;
    int active, ctrl, wait;
    unsigned char *pd;
    void (*hook)(void);

    /* MATCH: this is NOT a plain counter -- gcc round-trips a dummy multiply AND the counter through
     * the stack every iteration (a real busy-wait/settle delay technique), not a simple spin++. Both
     * `mult` and `i` must be volatile to force the store/reload each pass. */
    for (i = 0; i < 0x2ee; i++)
        mult = mult * 13;
    wait = (int)sndpd;
    ctrl = *(volatile int *)(wait + 0x514);
    *(volatile unsigned short *)(ctrl + 0x1aa) =
        *(volatile unsigned short *)(ctrl + 0x1aa) & 0xffcf;
    ctrl = *(volatile int *)(wait + 0x514);
    wait = 0;
    while ((*(volatile unsigned short *)(ctrl + 0x1aa) & 0x30) != 0) {
        wait++;
        if (4000 < wait)
            break;
    }
    /* MATCH: `wait` first carries the sndpd base through both SPUCNT accesses, then becomes the
     * settle-loop counter.  That non-overlapping lifetime gives the base/counter the oracle's shared
     * v1 allocation.  A signed-char slot local preserves each oracle lbu/sll24/sra24 chain in one
     * register instead of introducing a separate integer-conversion temporary.
     *
     * The active-entry VALUE is loaded BEFORE the critical section is entered (mfc0 -- the
     * oracle's ONLY SR-save mfc0 in this function sits here, not at function entry); sr is captured
     * at this exact point, not earlier.  MASK_INTERRUPTS_SR spells the required mfc0/mtc0 hazard
     * sequence explicitly.  Detailed residual: 4 diffs, 111/111 instructions (only the initial
     * sndpd lui/addiu temporary coalescing differs). */
    pd = sndpd;
    slot = *(volatile unsigned char *)(pd + 0xd);
    active = *(volatile int *)(pd + 0x10 + slot * 0x14);
    MASK_INTERRUPTS_SR(sr);
    if (active != 0) {        /* active entry present */
        if (*(volatile unsigned char *)(pd + 1) != 0) {
            hook = *(void (**)(void))(pd + 0x728);
            *(volatile unsigned char *)(pd + 1) = 0;
            if (hook != 0)
                (*hook)();
        }
        pd = sndpd;
        slot = *(volatile unsigned char *)(pd + 0xd);
        *(int *)(pd + 0x10 + slot * 0x14) = 0;      /* free the slot */
        *(unsigned char *)(pd + 0xc) = *(unsigned char *)(pd + 0xc) - 1;
        if ((int)((unsigned)*(volatile unsigned char *)(pd + 0xc) << 0x18) < 1) { /* queue now empty */
            *(volatile unsigned char *)(pd + 0xe) = 0;
            wr_sr(sr);
            return;
        }
    }
    wr_sr(sr);
    iSNDdmtransfer();
}

/* iSNDdmservice @0x8010AC20 : per-tick pump -- start a transfer if idle, or complete one past its deadline. */
extern void iSNDdmservice(void)
{
    unsigned char *pd = sndpd;
    if (*(unsigned char *)(pd + 0xe) == 0)
        iSNDdmtransfer();
    else {
        int *gs = sndgs;
        int slot = ((int)*(volatile unsigned char *)(pd + 0xd) << 24) >> 24;
        int *entry = (int *)(pd + slot * 0x14);
        /* MATCH: the volatile clock read keeps &sndgs materialized and, named before deadline,
         * fills the oracle's latency window with the two loads in their original order. */
        unsigned int now = (unsigned int)*(volatile int *)&gs[0x11];
        unsigned int deadline = (unsigned int)*(int *)((char *)entry + 0x20);
        if (deadline <= now)
            iSNDdmcallback();
    }
}

/* iSNDdmqueue @0x8010ACA0 : enqueue a RAM->SPU transfer (len rounded to 64 bytes), returning its handle (or
 *   0 if the 10-slot queue is full).  The five arguments are full ABI words; the queue stores only the
 *   low bytes of prio/flag. Reusing the saved Status value and walking sndpd+0x10 fixes the earlier
 *   critical-section and split-storage bugs. Snapshotting the new handle before the verified interrupt-mask
 *   sequence preserves the oracle's load and all three COP0 hazard slots (39->28 detailed diffs). */
extern int iSNDdmqueue(int dst_spu, unsigned int src_ram, int len, int prio, int flag)
{
    int queuedFlag = flag;
    int i;
    volatile int *raw;
    unsigned char *pd;
    unsigned int sr;
    int handleSnapshot;

    if ((len & 0x3f) != 0)
        len = len + 0x40;

    raw = (volatile int *)sndpd;
    raw[2] = raw[2] + 1;
    handleSnapshot = raw[2];
    MASK_INTERRUPTS_SR(sr);
    if (handleSnapshot == 0)
        raw[2] = 1;

    /* RESIDUAL (w31, 28->5): two sites left, both allocation-coupled and resistant to reshaping
     * (every alternative tried -- named id temp, handleSnapshot reuse, plain-store reorder --
     * re-colors the whole head, 25-51 diffs; w33-a6 re-ran the sweep on the current base and
     * CONFIRMS the local optimum: `&pd[0x10]`, a volatile-qualified pd, and taking pd straight from
     * the global instead of from `raw` are ALL diff-neutral at 5, while hoisting the id load into a
     * named temp above the dst store -- or dropping its volatile so it can hoist by itself -- costs
     * 60/61 insns at 51 diffs.  Diff (1) is the sndpsxz no-copy-prop identity in miniature: retail
     * reads the FRESH pd copy, our cc1 copy-propagates back to the source register):
     * (1) walker init emits `addiu v1,v1,16` (cse picks
     * the older equivalent raw reg) vs oracle `addiu v1,s0,16` (reads the pd copy); (2) the id
     * `lw` sits below the volatile dst store (+nop) vs oracle's lw;sw4;sw0 -- our volatile id
     * load cannot hoist over the volatile raw[1] store. Permuter candidate from this basin.
     * MATCH (w31): `i = 0` sits RIGHT AFTER the if (reorg copies it into the bnez delay slot AND
     * keeps the fall-through copy -- the oracle's duplicated zero-init), and the slot WALKER is the
     * SAME `raw` variable re-pointed at the entry table (one pseudo raw->walker inherits $v1 with
     * the combined ref count; a separate `entry` local always colored $t0 with $v0/$v1 conflicts).
     * The walker stays volatile -- the entry stores must not be scheduler-sunk (oracle keeps the
     * id store adjacent to the dst store) and the id-test load keeps its bare load-delay nop. */
    i = 0;
    pd = (unsigned char *)raw;
    raw = (volatile int *)(pd + 0x10);
scan:
    if (*raw != 0)
        goto occupied;
    pd[0xc] = pd[0xc] + 1;
    raw[1] = dst_spu;
    raw[0] = *(volatile int *)(pd + 8);   /* MATCH: volatile id read -- keeps the lw below the
                                            * pd[0xc] RMW (unhoisted), freeing $v0 for the temp
                                            * so the walker can take $v1 (same shared dmid word
                                            * the head re-reads through volatile raw[2]) */
    *(volatile unsigned short *)((unsigned char *)raw + 8) = (unsigned short)(src_ram >> 3);
    ((volatile unsigned char *)raw)[0xa] = (unsigned char)(len >> 6);
    ((volatile unsigned char *)raw)[0xb] = (unsigned char)prio;
    ((volatile unsigned char *)raw)[0xc] = (unsigned char)queuedFlag;
    wr_sr(sr);
    iSNDdmservice();
    return *(volatile int *)(pd + 8);
occupied:
    i++;
    if (i < 10) {
        raw = (volatile int *)((unsigned char *)raw + 0x14);
        goto scan;
    }
    wr_sr(sr);
    return 0;
}

/* iSNDdmqueuesplit @0x8010AD94 : enqueue a large transfer as 4 KB chunks, draining the queue when it backs
 *   up (>3 in flight).  Returns the last chunk's handle. MATCH (54/54): signed queue depth, strict
 *   4 KB chunk selection, raw integer priority and the pre-tested service loop all follow the oracle. */
extern int iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, int prio)
{
    int r = 0, chunk;
    if (0 < len) {
        unsigned char *pd = sndpd;
        int slots = 10;
        for (;;) {
            chunk = 0x1000;
            if (len < chunk)
                chunk = len;
            for (;;) {
                int inflight = ((int)*(volatile unsigned char *)(pd + 0xc) << 24) >> 24;
                if (7 <= slots - inflight)
                    break;
                iSNDdmservice();
            }
            r = iSNDdmqueue(dst_spu, src_ram, chunk, prio, 0);
            dst_spu += chunk;
            len -= chunk;
            src_ram += chunk;
            if (len <= 0)
                return r;
        }
    }
    return r;
}

/* iSNDdmcomplete @0x8010AE6C : has the transfer with handle `handle` finished?  Services the queue, then
 *   scans for the handle -- returns 0 if still pending, 1 if done/absent. */
extern int iSNDdmcomplete(int handle)
{
    int i, result;
    unsigned char *base;
    iSNDdmservice();
    base = sndpd;
    i = 0;
    if (0 < (int)((unsigned)base[0xc] << 0x18))
        goto scan;
    result = 1;
    goto done;
found:
    result = 0;
    goto done;
scan:
    do {
        if (*(int *)(base + 0x10) == handle)
            goto found;
        i++;
        base += 0x14;
    } while (i < 10);
    result = 1;
done:
    return result;
}
