/* syslib/psx/libetc/INTR.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra; verified vs disasm, IDA unreliable
 *   for libetc).  obj INTR.obj ; libetc.lib.  The PsyQ interrupt-callback manager: init/teardown, the
 *   _intrhand IRQ dispatcher (longjmp'd to from the BIOS entry-int vector via the setjmp buffer), and the
 *   per-IRQ callback registration API.  IRQ regs: I_STAT=0x1F801070, I_MASK=0x1F801074, DPCR=0x1F8010F0.
 *   EvCB block @0x80134AF8 (0x41a words) modelled as IntrState so _bzero_w clears the exact region; the
 *   vsync/dma slot-setters returned by startIntr{VSync,DMA} are cached in g_vsync_setter/g_dma_setter.
 */

typedef int (*IntrSetter)(int, int);

extern int  printf(const char *fmt, ...);          /* C63 */
extern void ReturnFromException(void);             /* A23 */
extern void ChangeClearPAD(int v);                 /* A91 */
extern int  ChangeClearRCnt(int t, int m);         /* L10 */
extern int  setjmp(long *env);                     /* C19 */
extern void HookEntryInt(void *h);                 /* A25 */
extern int  EnterCriticalSection(void);            /* A36 */
extern void ExitCriticalSection(void);             /* A37 */
extern void ResetEntryInt(void);                   /* A24 */
extern void _96_remove(void);                      /* C114 */
extern void *startIntrVSync(void);                 /* INTR_VB */
extern void *startIntrDMA(void);                   /* INTR_DMA */

extern void _intrhand(void);
extern int  _set_intr_callback(unsigned int idx, int handler);

/* EvCB block @0x80134AF8 (0x41a words) */
typedef struct {
    unsigned short inited;                 /* +0x00  @0x80134AF8 */
    unsigned short in_handler;             /* +0x02  @0x80134AFA */
    int   cb[11];                          /* +0x04  @0x80134AFC : IRQ callbacks 0..10 */
    unsigned short enabled;                /* +0x30  @0x80134B28 : enabled-IRQ mask */
    unsigned short saved_imask;            /* +0x32  @0x80134B2A */
    int   saved_dpcr;                      /* +0x34  @0x80134B2C */
    long  jmpbuf[(0x1018 - 0x38) / 4];     /* +0x38  @0x80134B30 : setjmp buf + filler */
    int   evcb[(0x1068 - 0x1018) / 4];     /* +0x1018 @0x80135B10 : BIOS EvCB table */
} IntrState;
extern IntrState g_intr;               /* @0x80134AF8 */
extern IntrState *_initIntr(void);

/* MATCH (structural): the libetc callback API dispatches through a HOOK TABLE --
 * D_80135B60 = 8-slot struct {entry, dma_setter, set_cb, reset, stop, vsync_setter,
 * restart, &g_intr}, D_80135B80 = POINTER to it; every public fn loads the pointer and
 * jalr's the slot (lw v0,%lo(D_80135B80); lw v0,OFF(v0); jalr).  The former separate
 * g_dma_setter/g_vsync_setter globals @0x80135B64/74 ARE the +0x04/+0x14 slots. */
typedef struct {
    int        (*entry)();                        /* +0x00 @0x80135B60 : 0x80056F4C (static init) */
    IntrSetter   dma_setter;                      /* +0x04 : filled by _initIntr (startIntrDMA) */
    int        (*set_cb)(unsigned int, int);      /* +0x08 : _set_intr_callback */
    IntrState *(*reset)(void);                    /* +0x0C : _initIntr */
    IntrState *(*stop)(void);                     /* +0x10 : StopCallback */
    IntrSetter   vsync_setter;                    /* +0x14 : filled by _initIntr (startIntrVSync) */
    void       (*restart)(void);                  /* +0x18 : RestartCallback */
    IntrState   *state;                           /* +0x1C : &g_intr */
} IntrHooks;
extern IntrHooks        g_hooks;             /* @0x80135B60 */
extern IntrHooks       *g_hooks_ptr;         /* @0x80135B80 : = &g_hooks */
extern volatile unsigned short *g_istat_ptr; /* @0x80135B84 : = 0x1F801070 */
extern volatile unsigned short *g_imask_ptr; /* @0x80135B88 : = 0x1F801074 */
extern volatile unsigned int   *g_dpcr_ptr;  /* @0x80135B8C : = 0x1F8010F0 */
extern int g_intr_timeout;                   /* @0x80135B90 */

#define I_STAT (*g_istat_ptr)
#define I_MASK (*g_imask_ptr)
#define DPCR   (*g_dpcr_ptr)

/* HIDDEN-PHANTOM FIX (w14-a2): oracle name is the bare "_bzero_w" (no __F mangling suffix), but
 * this `static` C++ fn got C++-mangled to _bzero_w__FPii, a NAME MISMATCH invisible to the gate
 * ("NOT IN OBJECT" forever). `static`+`extern "C"` can't combine as adjacent storage-class
 * specifiers on this compiler -- wrap in an `extern "C" { }` block instead.
 * W60-A1 (2026-08-14): the DEFINITION moved to EOF -- retail puts _bzero_w LAST in the obj
 * (@0x800F2E70, after RestartCallback); this forward decl keeps _initIntr's call site valid. */
static void _bzero_w(int *p, int n);

extern void ResetCallback(void)        /* @0x800F284C */
{
    g_hooks_ptr->reset();
}

extern void InterruptCallback(unsigned int idx, int handler)   /* @0x800F287C */
{
    g_hooks_ptr->set_cb(idx, handler);
}

extern int DMACallback(int ch, int func)   /* @0x800F28AC */
{
    return g_hooks_ptr->dma_setter(ch, func);
}

extern int VSyncCallback(int func)     /* @0x800F28DC */
{
    return g_hooks_ptr->vsync_setter(4, func);
}

extern int VSyncCallbacks(int idx, int func)   /* @0x800F2910 */
{
    return g_hooks_ptr->vsync_setter(idx, func);
}

/* @0x800F2940 -- returns g_intr.in_handler (D_80134AFA); lhu = unsigned read */
extern int CheckCallback(void)
{
    return (unsigned short)g_intr.in_handler;
}

extern int SetIntrMask(int mask)   /* @0x800F2950 */
{
    /* MATCH: oracle uses g_imask_ptr (D_80135B88) indirection → lw ptr; lhu *ptr; sh a0,*ptr in jr delay */
    unsigned short *p = (unsigned short *)g_imask_ptr;
    int old = *p;
    *p = (unsigned short)mask;
    return old;
}

/* W59-A13 (2026-08-14) RE-GATE 6 @54/54.  The WHOLE fn is byte-exact except ONE address
 * pseudo: the second `g_hooks_ptr` reload (for `dma_setter`, offset +4) lands in $v1 for us
 * and $a0 in retail, while the FIRST one (`vsync_setter`, +0x14) is $v1 in both.  Two
 * consecutive one-block address qtys where retail's second one skips the free low regs =
 * the local-alloc QTY handout (06E gap).  FALSIFIED: a local `IntrHooks *h` for the dma
 * store (20), naming both call results in temps (6, inert), a void fence between the two
 * stores (6, inert), `(&g_hooks_ptr[0])->` index form on both (6, inert); ladder as above. */
extern IntrState *_initIntr(void)       /* @0x800F2968 */
{
    if (g_intr.inited != 0)
        return 0;

    I_STAT = I_MASK = 0;
    DPCR = 0x33333333;
    _bzero_w((int *)&g_intr, 0x41a);
    if (setjmp(g_intr.jmpbuf) != 0)
        _intrhand();
    g_intr.jmpbuf[1] = (long)g_intr.evcb;
    HookEntryInt(g_intr.jmpbuf);
    g_intr.inited = 1;
    /* RESIDUAL 6 (w61-a8), count-EXACT 54/54: the SECOND `g_hooks_ptr` load lands in
     * $v1 where retail uses $a0 (the first one is $v1 in both) -- two identical
     * local-alloc QTYs where retail's second conflicts with the first and ours does
     * not.  The defining expression is a MEM off a SYMBOL_REF, so w61-a20's
     * set_preference records nothing and only the numeric scan runs; the only way in
     * is to make $v1 busy.  FALSIFIED (all gated): one shared `IntrHooks *` local
     * across both stores 20, two separate named locals 27, a read-only fence on the
     * first pointer after the second store 20 -- each makes the pointer live across
     * the `jal`, which forces a callee-saved register and grows the frame. */
    g_hooks_ptr->vsync_setter = (IntrSetter)startIntrVSync();
    g_hooks_ptr->dma_setter   = (IntrSetter)startIntrDMA();
    _96_remove();
    ExitCriticalSection();
    return &g_intr;
}

extern void _intrhand(void)            /* @0x800F2A40 */
{
    /* MATCH (w51-a7): shape TRANSPLANTED from the byte-exact Rage Racer PsyQ decomp
     * (C:/Temp/rage-racer-decomp/src/main/PAL/lib/libapi/interrupt_dispatch.c :: intrDispatch).
     * The oracle IS that source: a `u_short *state` base parked in $s1, `one`/`base` hoisted
     * ABOVE the outer do/while, a redundant `if (s0 != 0)` guard in front of the inner
     * `while ((s0 != 0) && (i < 0xB))`, a POINTER WALK `p++` over the callback slots (not
     * `cb[i]` indexing), and the stuck-counter read-then-store
     * `c = t; t = c + 1; if (c >= 0x801)`.  $s1 gets reused as the counter `i` exactly because
     * `state` dies at `base = &state[2]`.
     *
     * W60-A1 (2026-08-14) 49 @115/116 -> 44 @116/116 (COUNT-EXACT).  TWO named mechanisms, both
     * instances of the delete_noop_moves / combine_regs identity (catalog w47 sec A: "combine_regs
     * REFUSES to tie when the destination is a GLOBAL allocno -- make the PRODUCER's destination a
     * distinct short-lived pseudo"):
     *   (1) THE `pend` TEMP.  Retail computes the pending-IRQ mask into a BLOCK-LOCAL pseudo,
     *       tests THAT, and copies it into the loop-carried `s0` in the branch's DELAY SLOT
     *       (`and v0,v0,v1; beqz v0,T; addu s0,v0,zero`) -- at BOTH sites (the entry test and the
     *       outer do-while back-edge).  Assigning the AND result straight into `s0` (a multi-block
     *       global allocno) makes the copy the noop-move that flow deletes, leaving a bare `nop`
     *       in each slot.  A separate `long pend` restores both copies.
     *   (2) THE TIMEOUT READ-THEN-COPY (see its own note below) -- the missing 116th instruction.
     * FALSIFIED at this basin (all gated, all reverted): pend expression spellings
     * `(state[0x18] & I_STAT) & I_MASK` 50, `state&I_STAT` then `&I_MASK` as two statements 46,
     * `I_MASK & pend` as two statements 46, `I_STAT & (state & I_MASK)` 44 (ties, kept the
     * I_MASK-outer form); `(I_MASK & I_STAT)` for the closing timeout test 46.
     * FALSIFIED w61-a8 (with w61-a20's DEVICES.md in hand; all gated, all reverted):
     *  - the qty-ORDER attack from the OTHER side -- instead of hoisting the `enabled`
     *    read above `state[1] = 1` (A20: 46/49/46), LENGTHEN the constant's live range so
     *    it still owns $v0 when `enabled` is born: reuse the already-declared `one` for
     *    the store (`one = 1; state[1] = (u_short)one;`) with the loop-side `one = 1`
     *    dropped 51, kept 51, on one line 51;
     *  - the hoist crossed with the w61-a20 DEVICE-1b mode dial: `long en` 49,
     *    `int en` 49, `unsigned short en` 50 (qty_size does not decide this tie);
     *  - the hoist crossed with every AND-tree spelling: `(en & I_STAT) & I_MASK` 46,
     *    `I_MASK & (en & I_STAT)` 49, and retail's OWN tree read off the oracle
     *    (`lhu v1,48(s1); lhu a0,0(a0); and v1,v1,a0; and v0,v0,v1` = 
     *    `I_STAT & (enabled & I_MASK)`) 49 hoisted / 44 un-hoisted (ties the shipped
     *    form at both sites, entry-only and loop-only).  So the tree is NOT the dial:
     *    every spelling that keeps the count also keeps the two-qty swap.
     * FALSIFIED in the OLD 115-insn basin (04Z: basin-relative, re-test if the basin moves):
     * g_intr_timeout as an unsized `[]` / sized `[1]`/`[2]`/`[4]` array (the catalog's store-side
     * $at lever) all 48 @114/116 -- they REMOVE an instruction here, they do not add retail's
     * copy; `volatile int []` 53.
     * RESIDUAL (44, count-exact): pure register ASSIGNMENT -- ours puts the AND chain in
     * {v0,a0} where retail uses {v1,v0}, and the two `lhu` of I_STAT/I_MASK for the closing
     * test land in the opposite pair.  Same class as the fn's SYM-less local-alloc QTY handout
     * (06E gap) -- qtytrace/allocsim territory, not another spelling sweep. */
    unsigned short *state;
    unsigned short s0;
    long pend;
    long i;
    long c;
    long t;
    long one;
    int *p;
    int *base;

    state = (unsigned short *)&g_intr;
    __asm__("" : "=r"(state) : "0"(state));  /* zero-insn opacity fence: keep the base a REGISTER */
    if (state[0] == 0) {
        printf("unexpected interrupt(%04x)\n", I_STAT);
        ReturnFromException();
    }
    state[1] = 1;
    pend = I_MASK & (state[0x18] & I_STAT);
    s0 = (unsigned short)pend;
    if (pend != 0) {
        one = 1;
        base = (int *)&state[2];
        do {
            i = 0;
            if (s0 != 0) {
                p = base;
                while ((s0 != 0) && (i < 0xB)) {
                    if (s0 & 1) {
                        I_STAT = (unsigned short)~(one << i);
                        if (*p != 0)
                            ((void (*)())*p)();
                    }
                    p++;
                    s0 >>= 1;
                    i++;
                }
            }
            pend = I_MASK & (g_intr.enabled & I_STAT);
            s0 = (unsigned short)pend;
        } while (pend != 0);
    }
    if ((I_STAT & I_MASK) != 0) {
        /* MATCH (w60-a1): retail MUTATES the loaded pseudo IN PLACE for the store and
         * keeps a COPY of the pre-increment value for the compare
         * (`lw t; addu c,t,zero; addiu t,t,1; slti c,c,2049; ...; sw t`).  Reading
         * straight into `c` and storing `c + 1` coalesces that copy away and lands the
         * whole fn ONE INSTRUCTION SHORT (115 vs 116).  This shape is count-EXACT. */
        t = g_intr_timeout;
        c = t;
        t = t + 1;
        g_intr_timeout = t;
        if (c >= 0x801) {
            printf("intr timeout(%04x:%04x)\n", I_STAT, I_MASK);
            g_intr_timeout = 0;
            I_STAT = 0;
        }
    } else {
        g_intr_timeout = 0;
    }
    g_intr.in_handler = 0;
    ReturnFromException();
}

/* W59-A13 (2026-08-14) RE-GATE 27 @83/82; FALSIFIED THIS PASS (all gated, all reverted):
 *  - fence removals: no pendingValue fence 28 @82/82 | no `st` fence 25 | no `base` fence 28 @86
 *    | no `index` fence 47 | no `callback` fence 32 | no `bit` fence 35 | no pend+no st 26 @82
 *    | no st + void fence at the else-arm head 25 | + void fence before the final return 25/26.
 *  - REF dials on `slot` (05C): fence after `oldCallback = *slot` (27, inert), 2-operand (27),
 *    in each arm (28 @84), all three (28) -- the a0/a1/a2 rotation does not move.
 *  - LADDER (04Z, whole TU): current cc1_272 lane 10/13 PASS is best; 2.6.3 10/13 (_intrhand 45,
 *    the rest identical), 2.7.2-970404 7/13, 2.8.0 alt 2/13.
 * RESIDUAL CLASS: ours {base=$a0, slot=$a2, st=$a1} vs retail {base=$a1, slot=$a0, st=$a2} --
 * a THREE-pseudo rotation inside one block (local-alloc QTY handout, the 06E instrument gap),
 * plus retail computing `st` in the `beqz $v0` delay slot where ours re-stages the return value,
 * plus one extra `andi $v1,0xffff` (dropping the pendingValue opacity fence removes it but costs
 * more elsewhere).  Needs qtytrace, not another spelling sweep. */
extern int _set_intr_callback(unsigned int idx, int handler)   /* @0x800F2C10 */
{
    /* MATCH (w51-a7): shape TRANSPLANTED from the byte-exact Rage Racer PsyQ decomp
     * (C:/Temp/rage-racer-decomp/src/main/PAL/lib/libapi/interrupt_callbacks.c ::
     * SetKernelInterruptCallback).  Load-bearing details taken from there:
     *   - the slot address is built INDEX-FIRST (`offset + (long)base`) -> `addu rd,offset,base`;
     *   - the `inited` test is spelled off the callback-array base (`*((u_short *)base - 2)`)
     *     with an EMPTY then-arm, i.e. the whole body is the `else` (branch polarity);
     *   - the enable arm updates the mask word through `base + 11` (== &g_intr.enabled) while
     *     the disable arm goes through the GLOBAL -- an asymmetry that is in the original;
     *   - `bit` is a u_long, and the running mask is `pendingValue & 0xFFFF`.
     * RR's `register ... asm("$N")` pins are NOT copied (project hard rule); the zero-insn
     * opacity fences it also carries are kept where re-pricing says so (see the `st` one,
     * removed below), since they are the pin-free device.
     * RESIDUAL 25 (w61-a8): ours 83 insns vs oracle 82.  Two clusters:
     *  (a) ONE extra `andi v1,v1,0xFFFF` before the `andi s3,v1,0xFFFF` retail keeps --
     *      the pendingValue identity fence makes cse forget the `lhu` already proved
     *      the range, so the mask is materialised twice.  Dropping that fence removes
     *      the insn but costs more elsewhere (26/28 in both basins).
     *  (b) a 3-way ADDRESS-REGISTER rotation: ours {a0 = table base, a1 = slot},
     *      retail {a1 = base, a0 = slot, a2 = base-4}.  FALSIFIED as zero-insn dials
     *      (w61-a20 DEVICE 2a, preference = first operand of the defining expr):
     *      `(long)base + offset` operand swap, `&base[index]` index form, and
     *      read-only / identity fences on `slot` and on `base` -- all 25, inert. */
    long index;
    int callback;
    int *base;
    long offset;
    int *slot;
    int oldCallback;
    unsigned long pendingValue;
    unsigned long pendingMask;
    long disabled;
    unsigned short *st;
    volatile unsigned short *maskPtr;

    index = (long)idx;
    __asm__("" : "=r"(index) : "0"(index));
    callback = handler;
    __asm__("" : "=r"(callback) : "0"(callback));
    base = g_intr.cb;
    __asm__("" : "=r"(base) : "0"(base));
    offset = index << 2;
    slot = (int *)(offset + (long)base);
    oldCallback = *slot;

    if (callback == oldCallback)
        return oldCallback;

    if (*((unsigned short *)base - 2) == 0) {
    } else {
        /* MATCH (w61-a8): the transplanted identity fence on `st` is REMOVED, 27 -> 25.
         * It is structurally right and measurably wrong: it forces retail's separate
         * `addiu a2,a1,-4` pointer (without it gcc folds `st[0x18]` into `44(base)`),
         * but an asm also stops reorg's backward delay-slot scan, and that very addiu
         * is what retail puts in the `beqz` slot -- so the fence buys the pointer and
         * loses the slot, net +2.  FALSIFIED (all gated): the fence moved after the
         * maskPtr load / after `*maskPtr = 0` / after the `& 0xFFFF` (27 each -- the
         * position is NOT the dial here), and read-only instead of identity (25, i.e.
         * no better than removing it).  04Z: this fence came from the Rage Racer
         * transplant and was never re-priced after the basin moved. */
        st = (unsigned short *)base - 2;
        maskPtr = (volatile unsigned short *)g_imask_ptr;
        pendingValue = *maskPtr;
        __asm__("" : "=r"(pendingValue) : "0"(pendingValue));
        *maskPtr = 0;
        pendingMask = pendingValue & 0xFFFF;

        if (callback != 0) {
            unsigned long bit;

            bit = 1 << index;
            __asm__("" : "=r"(bit) : "0"(bit));
            pendingMask |= bit;
            *slot = callback;
            {
                unsigned long value;

                value = st[0x18];
                value |= bit;
                st[0x18] = (unsigned short)value;
            }
        } else {
            unsigned long bit;

            bit = 1 << index;
            bit = ~bit;
            *slot = callback;
            pendingValue = *(unsigned short *)(base + 11);
            pendingMask &= bit;
            pendingValue &= bit;
            *(unsigned short *)(base + 11) = (unsigned short)pendingValue;
        }

        /* @0x800F2CC0-D20: ChangeClearRCnt(<per-IRQ root-counter index>, handler==0). $a0 = the timer
         * id (idx0->RCnt3, idx4->0, idx5->1, idx6->2), $a1 = $s0 = (handler<1) = (handler==0) = the
         * clear flag. */
        if (index == 0) {
            disabled = callback == 0;
            ChangeClearPAD(disabled);
            ChangeClearRCnt(3, disabled);
        }
        if (index == 4) ChangeClearRCnt(0, callback == 0);
        if (index == 5) ChangeClearRCnt(1, callback == 0);
        if (index == 6) ChangeClearRCnt(2, callback == 0);

        I_MASK = (unsigned short)pendingMask;
    }
    return oldCallback;
}

extern IntrState *StopCallback(void)   /* @0x800F2D58 */
{
    /* MATCH (w51-a7, methodology 3.12 #16 HOLD-GLOBAL-ADDR-ACROSS-CALL): the oracle keeps
     * &g_intr in the callee-saved $s0 for the WHOLE function (`lui/addiu $s0` in the prologue,
     * `lhu 0($s0)`, `sh 0x32($s0)`, `sw 0x34($s0)`, and the return `addu $v0,$s0,$zero`).  Under
     * the gcc-2.7.2 lane a bare `g_intr.field` rematerializes the address per access
     * (`lui $at; sh 0($at)`); a named pointer local live across EnterCriticalSection forces the
     * $s0 hoist. */
    IntrState *cb = &g_intr;
    __asm__("" : "=r"(cb) : "0"(cb));   /* zero-insn opacity fence (W49): keep cb a REGISTER base */
    if (cb->inited == 0)
        return 0;
    EnterCriticalSection();
    cb->saved_imask = I_MASK;
    cb->saved_dpcr  = DPCR;
    /* MATCH (w48-a7): CHAINED assignment -- the oracle stores 0 to I_MASK and then RE-READS it
     * (`sh $zero,0($v0); lhu $v0,0($v0); sh $v0,0($a0)`).  That re-read is exactly gcc's
     * volatile handling of `a = b = 0` (the value of the inner assignment is fetched back from
     * the volatile lvalue); two separate `= 0` statements emit two independent stores. */
    I_STAT = I_MASK = 0;
    /* MATCH (methodology 3.25-3c): the oracle puts this store in the `jal ResetEntryInt` DELAY
     * SLOT; gcc's reorg will not slot-fill a volatile MEM, so the store side drops volatile. */
    *(unsigned int *)g_dpcr_ptr = DPCR & 0x77777777;
    ResetEntryInt();
    cb->inited = 0;
    return cb;
}

extern int RestartCallback(void)       /* @0x800F2DF8 */
{
    /* MATCH (w48-a7) branch POLARITY: the oracle skips AWAY on the already-running case
     * (`bnez $v0,.L800F2E5C`) and falls straight through into the body, with the `return 0`
     * block out-of-line just before the epilogue.  The `if (inited == 0) {body} return 0;`
     * spelling inverts that (beqz to the body, `return 0` inline right after the test). */
    /* MATCH (w51-a7, 3.12 #16 + the W49 opacity fence): &g_intr lives in $s0 for the whole fn
     * (`addiu $a0,$s0,0x38` for the jmpbuf arg, `lhu 0x32($s0)`, `lw 0x34($s0)`, and the tail
     * `addu $v0,$s0,$zero`).  Under the gcc-2.7.2 lane a plain `&g_intr` is const-folded back
     * into per-access `sym`-macros (`lui $at; ...`); the fence keeps cb a register base. */
    IntrState *cb = &g_intr;
    __asm__("" : "=r"(cb) : "0"(cb));
    if (cb->inited != 0)
        return 0;
    HookEntryInt(cb->jmpbuf);
    cb->inited = 1;
    I_MASK = cb->saved_imask;
    /* MATCH (methodology 3.25-3c): this store sits in the `jal ExitCriticalSection` DELAY SLOT
     * in the oracle; reorg will not slot-fill a volatile MEM, so the store side drops volatile. */
    *(unsigned int *)g_dpcr_ptr = cb->saved_dpcr;
    ExitCriticalSection();
    return (int)cb;
    /* RESIDUAL 1 (w53-a9) -- MECHANISM SOLVED, NEEDS A BUILD-SIDE WIRING, NOT A SOURCE CHANGE.
     * The single diff is a `nop` the oracle carries between `lw $2,52($s0)` and the
     * `jal ExitCriticalSection`.  Root cause: OUR cc1 fills the jal's delay slot ITSELF
     * (it emits the `.set noreorder/nomacro; jal; sw $2,0($3)` block), so gas never sees a
     * load-use hazard.  Retail's cc1 left the slot to the assembler: with `-fno-delayed-branch`
     * this exact cc1 emits `lw $2,52($16); #nop; sw $2,0($3); jal ...` in reorder mode -- gas
     * then inserts the load-use nop AND hoists the `sw` into the jal slot, reproducing the
     * oracle's `lw; nop; jal; sw` verbatim (A/B'd on the wired 2.7.2 lane, 2026-08-09).
     * ORCHESTRATOR ACTION: probe a per-fn no-delayed-branch splice (or whole-TU
     * `no_delayed_branch` measured across all 11 INTR.c fns) for RestartCallback.
     * No C spelling reaches it -- the slot is filled before the assembler runs. */
}

static void _bzero_w(int *p, int n)        /* @0x800F2E70 */
{
    int i = n - 1;
    if (n != 0) { do { *p = 0; i = i - 1; p = p + 1; } while (i != -1); }
}

 IntrState g_intr;   /* owning-TU def (BSS) -- at EOF for type visibility */
