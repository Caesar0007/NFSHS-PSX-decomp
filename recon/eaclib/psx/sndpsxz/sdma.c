/* eaclib/psx/sndpsxz/sdma.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 PASS ***
 *   Source obj : nfs4\eaclib\psx\sdma.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   6 fns @[0x8010A880 .. 0x8010AE6C]. RAM->SPU DMA queue -- up to 10 pending transfers serviced by
 *   priority, driven from the SPU IRQ / per-tick service.  Ghidra nfs4-f.exe.c (sdma) + disasm-v3 for the
 *   args Ghidra dropped: iSNDdmqueue is 5-ARG (ram_source,spu_address,len,prio,flag) and iSNDdmqueuesplit forwards
 *   (ram_source,spu_address,chunk,prio,0), advancing both addresses per 4 KB chunk (Ghidra showed only the 1-arg call).
 *
 *   DMA QUEUE entry (DAT_80147928, 0x14 stride, 10 slots):
 *     +0x00 handle(int, 0==free)  +0x04 RAM source pointer  +0x08 SPU address>>3(u16)  +0x0a len/64(u8)
 *     +0x0b priority(u8)  +0x0c flag(u8)  +0x10 deadline(int, = sndgs[0x11]+0xf)
 *   State: DAT_80147920 handle counter, DAT_80147924 in-flight count, DAT_80147925 active slot,
 *          DAT_80147926 busy flag, DAT_80147919 pre-load guard (shared with sdpacket).
 */
#include "sdata.h"
#include "sdma.h"
#include "slib.h"
#include "snd_state.h"
#include "sndspuregpriv.h"
#include "sndhookpriv.h"
#include "snddmapriv.h"

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
/* SYM-HOST-ONLY: g_sr -- portable stand-in for the target COP0 Status register. */
static unsigned int g_sr = 0;
static inline unsigned int rd_sr(void) { return g_sr; }
static inline void wr_sr(unsigned int s) { g_sr = s; }
#define MASK_INTERRUPTS_SR(sr) do { (sr) = rd_sr(); wr_sr((sr) & 0xfffffbfe); } while (0)
#endif

/* iSNDdmtransfer @0x8010A880 : pick the highest-priority queued transfer and kick the SPU-write DMA for it. */
void iSNDdmtransfer(void)
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
    inflight = ((struct SndDmaQueueStateView *)pd)->in_flight_count.v;
    MASK_INTERRUPTS_SR(sr);
    inflightValue = (int)((unsigned)inflight << 0x18);
    bestHandle = 0xffffffff;
    if (inflightValue < 1) {                               /* nothing queued */
        wr_sr(sr);
        return;
    }
    bestPrio = 0;
    ((struct SndDmaQueueStateView *)pd)->transfer_busy.plain = 1;
    i = bestPrio;
    scanBase = pd;
    scanEntry = ((struct SndDmaQueueEntriesView *)scanBase)->entries;
    for (; i < 10; i++, scanEntry++) {
        if (scanEntry->handle) {                     /* active entry */
            if (bestPrio < scanEntry->priority) {
                ((struct SndDmaQueueStateView *)scanBase)->active_slot.plain = (signed char)i;
                bestHandle = scanEntry->handle;
                bestPrio = scanEntry->priority;
            } else if (scanEntry->priority == bestPrio &&
                       (unsigned)scanEntry->handle < bestHandle) {
                ((struct SndDmaQueueStateView *)scanBase)->active_slot.plain = (signed char)i;
                bestHandle = scanEntry->handle;
            }
        }
    }

    {
        unsigned char *tailBase = sndpd;
        unsigned char *qbase;
        activeEntry = (struct SNDDmaEntry *)
            (((((int)((struct SndDmaQueueStateView *)tailBase)->active_slot.v) << 24) >> 24) * (int)sizeof(struct SNDDmaEntry)
             + (int)(unsigned int)(qbase = tailBase + 0x10));
        if (activeEntry->flag) {
            void (*hook)(void) = ((struct SndDriverHookStateView *)tailBase)->hooks.preload;
            ((struct SndDmaQueueStateView *)tailBase)->callback_guard.v = 1;
            if (hook)
                (*hook)();
        }
    }
    {
        unsigned char *gsAddr = (unsigned char *)sndgs;
        unsigned char *hwBase = sndpd;
        unsigned char *ctrl;
        volatile unsigned int *dpcr;
        activeEntry->deadline = *(volatile int *)(gsAddr + 0x44) + 0xf;
        ctrl = *(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)hwBase)->registers.control_base;
        *(volatile unsigned short *)(ctrl + 0x1a6) = activeEntry->spu_address_8;
        ctrl = *(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)hwBase)->registers.control_base;
        *(volatile unsigned short *)(ctrl + 0x1aa) =
            *(volatile unsigned short *)(ctrl + 0x1aa) & 0xffcf | 0x20;
        dpcr = ((struct SndSpuRegisterBasesStateView *)hwBase)->registers.address_4fc;
        *dpcr = *dpcr & 0xf0ffffff | 0x20000000;
        *(((struct SndSpuRegisterBasesStateView *)hwBase)->registers.dma4_madr) = (unsigned int)activeEntry->ram_source;
        *(((struct SndSpuRegisterBasesStateView *)hwBase)->registers.dma4_bcr) =
            (unsigned int)activeEntry->len64 << 0x10 | 0x10;
        *(((struct SndSpuRegisterBasesStateView *)hwBase)->registers.dma4_chcr) = 0x1000201;
    }
    wr_sr(sr);
}

/* iSNDdmcallback @0x8010AA64 : DMA-done handler -- settle SPUCNT, retire the active entry, fire the next. */
void iSNDdmcallback(void)
{
    unsigned int sr;
    volatile int i;
    volatile int mult = 13;
    signed char slot;
    int active, wait;
    unsigned char *ctrl;
    unsigned char *pd;
    void (*hook)(void);

    /* MATCH: this is NOT a plain counter -- gcc round-trips a dummy multiply AND the counter through
     * the stack every iteration (a real busy-wait/settle delay technique), not a simple spin++. Both
     * `mult` and `i` must be volatile to force the store/reload each pass. */
    for (i = 0; i < 0x2ee; i++)
        mult = mult * 13;
    /* MATCH (w50-a8, 4 -> PASS): the sndpd base must be a BLOCK-LOCAL `base`, not the fn-scope
     * two-role `wait`.  w49-a8 named the mechanism: local-alloc's combine_regs REFUSES to tie
     * the address's %hi pseudo into a GLOBAL allocno (`if (reg_qty[sreg] >= -1) return 0`), so a
     * fn-scope `wait` can never produce retail's IN-PLACE `lui v1 / addiu v1,v1` -- it emits
     * `lui v0 / addiu v1,v0`.  A block-local base does tie, but with only THREE local qtys the
     * block hits gcc-2.8's hand-rolled next_qty<=3 path (local-alloc.c:1588 -- not a priority
     * sort at all) and loses the v0/v1 order: 14 diffs.  THE ESCAPE IS A 4TH QTY, and the
     * natural one is a block-local `c` for the FIRST SPUCNT pointer read (the second read is a
     * genuinely separate volatile load that stays in the fn-scope `ctrl`).  With next_qty == 4
     * the block takes the qsort/priority path and lands retail's handout exactly.
     * Falsified at 14 (all 111/111): block-local base alone; + a do{}while(0) wrapper on the
     * masked store; + a named mask temp.  Wrapping the whole block collapses it (106/111, 21). */
    {
        unsigned char *base = sndpd;
        unsigned char *c;   /* the 4th qty -- see above; do not fold back into ctrl */
        c = (unsigned char *)((struct SndSpuRegisterBasesStateView *)base)->registers.control_base;
        *(volatile unsigned short *)(c + 0x1aa) =
            *(volatile unsigned short *)(c + 0x1aa) & 0xffcf;
        ctrl = (unsigned char *)((struct SndSpuRegisterBasesStateView *)base)->registers.control_base;
    }
    wait = 0;
    while ((*(volatile unsigned short *)(ctrl + 0x1aa) & 0x30) != 0) {
        wait++;
        if (wait > 4000)
            break;
    }
    /* NOTE (superseded by the w50-a8 block above): `wait` used to carry the sndpd base through both
     * SPUCNT accesses before becoming the settle-loop counter; the base is now a block-local so the
     * %hi can be tied in place, and `wait` is the counter only.
     * A signed-char slot local preserves each oracle lbu/sll24/sra24 chain in one
     * register instead of introducing a separate integer-conversion temporary.
     *
     * The active-entry VALUE is loaded BEFORE the critical section is entered (mfc0 -- the
     * oracle's ONLY SR-save mfc0 in this function sits here, not at function entry); sr is captured
     * at this exact point, not earlier.  MASK_INTERRUPTS_SR spells the required mfc0/mtc0 hazard
     * sequence explicitly.  Detailed residual: 4 diffs, 111/111 instructions (only the initial
     * sndpd lui/addiu temporary coalescing differs). */
    pd = sndpd;
    slot = ((struct SndDmaQueueStateView *)pd)->active_slot.v;
    active = ((struct SndDmaQueueEntriesView *)pd)->entries[slot].handle;
    MASK_INTERRUPTS_SR(sr);
    if (active) {        /* active entry present */
        if (((struct SndDmaQueueStateView *)pd)->callback_guard.v) {
            hook = ((struct SndDriverHookStateView *)pd)->hooks.preload;
            ((struct SndDmaQueueStateView *)pd)->callback_guard.v = 0;
            if (hook)
                (*hook)();
        }
        pd = sndpd;
        slot = ((struct SndDmaQueueStateView *)pd)->active_slot.v;
        ((struct SndDmaQueueEntriesView *)pd)->entries[slot].handle = 0; /* free the slot */
        ((struct SndDmaQueueStateView *)pd)->in_flight_count.plain = ((struct SndDmaQueueStateView *)pd)->in_flight_count.plain - 1;
        if ((int)((unsigned)((struct SndDmaQueueStateView *)pd)->in_flight_count.v << 0x18) < 1) { /* queue now empty */
            ((struct SndDmaQueueStateView *)pd)->transfer_busy.v = 0;
            wr_sr(sr);
            return;
        }
    }
    wr_sr(sr);
    iSNDdmtransfer();
}

/* iSNDdmservice @0x8010AC20 : per-tick pump -- start a transfer if idle, or complete one past its deadline. */
void iSNDdmservice(void)
{
    unsigned char *pd = sndpd;
    if (!((struct SndDmaQueueStateView *)pd)->transfer_busy.plain)
        iSNDdmtransfer();
    else {
        int *gs = sndgs;
        int slot = ((int)((struct SndDmaQueueStateView *)pd)->active_slot.v << 24) >> 24;
        /* `entry` is the byte cursor at the slot-relative state base; the record view begins at +0x10. */
        unsigned char *entry = pd + slot * (int)sizeof(struct SNDDmaEntry);
        /* MATCH: the volatile clock read keeps &sndgs materialized and, named before deadline,
         * fills the oracle's latency window with the two loads in their original order. */
        unsigned int now = *(volatile int *)&gs[0x11];
        unsigned int deadline = ((struct SNDDmaEntry *)(entry + 0x10))->deadline;
        if (deadline <= now)
            iSNDdmcallback();
    }
}

/* iSNDdmqueue @0x8010ACA0 : enqueue a RAM->SPU transfer (len rounded to 64 bytes), returning its handle (or
 *   0 if the 10-slot queue is full). Arg1 is the RAM byte-source pointer; arg2 is the SPU byte address
 *   stored in address/8 units. The five arguments are full ABI words; the queue stores only the low
 *   bytes of prio/flag. Reusing the saved Status value and walking sndpd+0x10 fixes the earlier
 *   critical-section and split-storage bugs. Snapshotting the new handle before the verified interrupt-mask
 *   sequence preserves the oracle's load and all three COP0 hazard slots (39->28 detailed diffs). */
int iSNDdmqueue(const unsigned char *ram_source, unsigned char *spu_address, int len, int prio, int flag)
{
    int queuedFlag = flag;
    int i;
    volatile int *raw;
    volatile struct SNDDmaEntry *ent;
    unsigned char *pd;
    unsigned int sr;
    int handleSnapshot;

    if (len & 0x3f)
        len += 0x40;

    raw = (volatile int *)sndpd;
    ((struct SndDmaQueueStateView *)raw)->next_handle = ((struct SndDmaQueueStateView *)raw)->next_handle + 1;
    handleSnapshot = ((struct SndDmaQueueStateView *)raw)->next_handle;
    MASK_INTERRUPTS_SR(sr);
    if (!handleSnapshot)
        ((struct SndDmaQueueStateView *)raw)->next_handle = 1;

    /* MATCH (w34-a5, 5->0 PASS).  The w31/w33 "no-copy-prop identity" residual was NOT an identity
     * -- it took THREE cooperating source facts, and the w33 negative results were all measured with
     * one of the other two still wrong (they only pay off together; cf. the BLOCKING-REGISTER-CASCADE
     * rule -- re-test shelved leads after any structural fix):
     *   1. SEPARATE WALKER PSEUDO `ent` (not the head's `raw` re-pointed).  With one shared pseudo the
     *      head base is still LIVE past the `pd = raw` copy, so cse's canon_reg keeps the SOURCE
     *      canonical and emits `addiu v1,v1,16`.  A distinct `ent` makes the head base DIE at the
     *      copy, so the copy `pd` outlives its source and BECOMES canonical -> oracle `addiu v1,s0,16`
     *      (make_regs_eqv steering, w33 catalog).  (w31 recorded a separate `entry` local as always
     *      colouring $t0; that was true only while the id load still sat below the dst store.)
     *   2. VOLATILE in-flight-count RMW `*(volatile u_char*)(pd+0xc) += 1` -- pins the lbu/addiu/sb
     *      trio (with its unfilled load-delay nop) so the id `lw` cannot hoist above it.  Dropping
     *      the volatile lets the whole head re-colour into $t1-$t3 (23 diffs, 60/61 insns).
     *   3. The id load REUSES the now-dead `handleSnapshot` local and is written ABOVE the dst store
     *      (oracle: `lw v0,8(s0); sw a0,4(v1); sw v0,0(v1)` -- the dst store fills the load-delay
     *      slot).  A FRESH named temp here is the w33 51-diff blowup; repurposing the dead variable
     *      reuses its register exactly like retail (catalog "dead-variable staging reuse").
     * Still load-bearing from w31: `i = 0` sits RIGHT AFTER the if (reorg copies it into the bnez
     * delay slot AND keeps the fall-through copy -- the oracle's duplicated zero-init); the walker
     * stays volatile so the entry stores are not scheduler-sunk. */
    i = 0;
    pd = (unsigned char *)raw;
    ent = (volatile struct SNDDmaEntry *)(pd + 0x10);
scan:
    if (!ent->handle) {
        ((struct SndDmaQueueStateView *)pd)->in_flight_count.v = ((struct SndDmaQueueStateView *)pd)->in_flight_count.v + 1;
        handleSnapshot = ((struct SndDmaQueueStateView *)pd)->next_handle;
        ent->ram_source = ram_source;
        ent->handle = handleSnapshot;
        ent->spu_address_8 = (unsigned short)((unsigned int)spu_address >> 3);
        ent->len64 = (unsigned char)(len >> 6);
        ent->priority = (unsigned char)prio;
        ent->flag = (unsigned char)queuedFlag;
        wr_sr(sr);
        iSNDdmservice();
        return ((struct SndDmaQueueStateView *)pd)->next_handle;
    }
    i++;
    if (i < 10) {
        ent++;
        goto scan;
    }
    wr_sr(sr);
    return 0;
}

/* iSNDdmqueuesplit @0x8010AD94 : enqueue a large transfer as 4 KB chunks, draining the queue when it backs
 *   up (>3 in flight). The RAM source advances bytewise; the SPU address remains a scalar device address.
 *   Returns the last chunk's handle. MATCH (54/54): signed queue depth, strict 4 KB chunk selection,
 *   raw integer priority and the pre-tested service loop all follow the oracle. */
int iSNDdmqueuesplit(const unsigned char *ram_source, unsigned char *spu_address, int len, int prio)
{
    int r = 0, chunk;
    if (len > 0) {
        unsigned char *pd = sndpd;
        int slots = 10;
        for (;;) {
            chunk = 0x1000;
            if (len < chunk)
                chunk = len;
            for (;;) {
                int inflight = ((int)((struct SndDmaQueueStateView *)pd)->in_flight_count.v << 24) >> 24;
                if (7 <= slots - inflight)
                    break;
                iSNDdmservice();
            }
            r = iSNDdmqueue(ram_source, spu_address, chunk, prio, 0);
            ram_source += chunk;
            len -= chunk;
            spu_address += chunk;
            if (len <= 0)
                return r;
        }
    }
    return r;
}

/* iSNDdmcomplete @0x8010AE6C : has the transfer with handle `handle` finished?  Services the queue, then
 *   scans for the handle -- returns 0 if still pending, 1 if done/absent. */
int iSNDdmcomplete(int handle)
{
    int i, result;
    unsigned char *base;
    iSNDdmservice();
    base = sndpd;
    i = 0;
    if (!(0 < (int)((unsigned)((struct SndDmaQueueStateView *)base)->in_flight_count.plain << 0x18)))
        return 1;
    for (; i < 10; i++) {
        if (((struct SndDmaQueueEntriesView *)base)->entries[i].handle == handle)
            return 0;
    }
    return 1;
}
