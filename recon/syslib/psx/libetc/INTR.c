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
extern IntrState g_intr __asm__("D_80134AF8");  /* @0x80134AF8 -- storage owned by the splat
                                                 * data blob; see the W65-A6 note at EOF */
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
extern IntrHooks       *g_hooks_ptr __asm__("D_80135B80");         /* @0x80135B80 : = &g_hooks */
extern volatile unsigned short *g_istat_ptr __asm__("D_80135B84"); /* @0x80135B84 : = 0x1F801070 */
extern volatile unsigned short *g_imask_ptr __asm__("D_80135B88"); /* @0x80135B88 : = 0x1F801074 */
extern volatile unsigned int   *g_dpcr_ptr __asm__("D_80135B8C");  /* @0x80135B8C : = 0x1F8010F0 */
extern int g_intr_timeout __asm__("D_80135B90");                   /* @0x80135B90 */

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
 * stores (6, inert), `(&g_hooks_ptr[0])->` index form on both (6, inert); ladder as above.
 * W71-A10 (2026-08-21) RE-GATED 6 @54/54; the W63-A8 diagnosis re-measured and CONFIRMED
 * (qty272: block-4 qtys 84/86/87/89/91 ALL tie at refs2 live4 pri5000, so the handout falls
 * through to the qty NUMBER tie-break and 91 reuses $v1 only because 89 is already dead).
 * FALSIFIED this pass (all gated, all reverted): the first hooks pointer hoisted into a
 * named `h1` assigned BEFORE `g_intr.inited = 1` (20 @56 -- h1 then crosses the jal and is
 * forced to an s-reg), a named `dm` temp for the startIntrDMA result (6, inert),
 * `g_hooks_ptr[0].dma_setter` (6, inert), `(&g_hooks_ptr[0])->` re-test (6, inert).  The
 * W63-A8 intruder angle is unchanged and still needs a value BORN AFTER `jal startIntrDMA`
 * and DEAD BEFORE its store; no zero-insn C form for one exists (the 0-insn void-tail
 * fence carries no register, and an `"r"` fence needs a live value -- the missing thing).
 * W72-A19 (2026-08-22) RE-GATED 6 @54/54; the 21A/20B instrument set (which postdates every
 * note above) is now swept here and is NEGATIVE.  Reading the stream first pins the target
 * exactly: both hooks_ptr address pseudos are SHORT-LIVED and do NOT cross a call -- reorg
 * puts each store in the FOLLOWING jal's delay slot (`lui/lw $v1; jal startIntrDMA;
 * sw $v0,20($v1)` stores the PREVIOUS call's result), so pseudo #2 lives only insns 43-46
 * and simply takes the first free reg, $v1, because #1 died at 42.  Retail has $a0 there,
 * i.e. something occupied $v1 across those four insns.  FALSIFIED (all gated, all reverted):
 * 'm'-operand fences on `g_hooks_ptr` / `->dma_setter` / `->vsync_setter` / `*g_hooks_ptr` /
 * `->entry` at all three positions (before the vsync statement / between / after the dma
 * statement) -- 6 (inert) in 7 of the 15 cells, 10-13 @56-57 in the rest; a `IntrSetter
 * *slot = &g_hooks_ptr->dma_setter;` block with a 20B clobber launder ("$3" 36 @56, "$2"
 * 35 @57), with a read-only fence + "$3" (38 @56), with a plain identity launder (32 @56),
 * and the bare `slot` block with no fence at all (20 @54); a mirrored `vslot` for the vsync
 * store as well (41 @59); the 20A void clobber `__asm__(" " : : : "$3")` BETWEEN the two
 * statements 10 @54 (it lands BEFORE pseudo #2 is born, so it denies nothing -- exactly the
 * boundary 21A-1 states).  The angle is CONFIRMED AND SHARPENED, not retired: the intruder
 * must be born INSIDE the 4-insn window between the `lw` of `g_hooks_ptr` and the delay-slot
 * store, and no C statement boundary exists there -- the vehicles left are a build-side
 * per-fn mechanism (TEXT_MOVES is useless here, the registers are already assigned) or an
 * instrumented-cc1 read of local-alloc's block-4 handout (C:/Temp/nfs4-instr-cc1). */
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
     * the `jal`, which forces a callee-saved register and grows the frame.
     * W63-A8 (2026-08-15) qty272.py NAMES THE DIAL, and it is NEITHER refs NOR live length.
     * The two hooks_ptr loads are block-4 local qtys 89 and 91.  EVERY block-4 qty ties at
     * refs 2 / live 4 / pri 5000 (84, 86, 87, 89, 91), so the qsort key is DEGENERATE and
     * local-alloc falls through to its NUMBER tie-break (14C: "qty = block birth order") --
     * measured handout 84 $v0, 86 $s0, 87 $v0, 89 $v1, 91 $v1.  91 reuses $v1 purely because
     * 89 is already DEAD when 91 is born.  => no ref-step and no live-length dial can move 91
     * (both feed a priority that is already tied), which is exactly why the three forms in the
     * list above all failed the SAME way: they lengthen 89 ACROSS the `jal startIntrDMA`, which
     * promotes it out of the caller-saved pool entirely instead of merely overlapping 91.
     * THE NAMED ANGLE (untried, 14C INTRUDER-EVICTION): retail's $a0 needs $v0 AND $v1 both BUSY
     * over 91's 4-insn window.  $v0 already holds the call result; the missing piece is a THIRD
     * short-lived block-4 value holding $v1 across those four insns WITHOUT crossing the jal --
     * an intruder born after the call and dead before the store, not a longer-lived 89.
     * 04Z ladder (never run before this; the TU is wired cc1_272): 2.6.3 6, 2.7.2 6,
     * 2.7.2-970404 65 @53, 2.8.0 65 @53, 2.8.1 65 @53 -- the VERSION AXIS IS CLOSED here. */
    g_hooks_ptr->vsync_setter = (IntrSetter)startIntrVSync();
    /* MATCH (W74-A17, 2026-08-23): 6 -> PASS 54/54.  THE INTRUDER THE W63/W71/W72 NOTES
     * ASKED FOR, BUILT WITH THE 20B/22B-2 DEVICE.  In RTL the second hooks-pointer load
     * lives for exactly TWO insns AFTER `jal startIntrDMA` (reorg later back-fills the
     * store into the jal's delay slot and hoists the `lw` above it), so it never crosses
     * the call: $v0 holds the call result, $v1 is free, and local-alloc's numeric scan
     * hands it $v1.  Retail has $a0 there, i.e. $v1 was ALSO busy.  A named call-result
     * temp creates the statement boundary the window lacked, and a ZERO-INSN clobber
     * launder on it denies $v1 -- the pointer then takes $a0 and the block is byte-exact.
     * `d` (not a pointer local) is the carrier: a named `IntrHooks *h` alone is 6 (inert)
     * and `h` + the same launder is also PASS, so the temp is only the vehicle for the
     * clobber.  MEASURED (all gated): launder+"$3" on `d` PASS * launder+"$3" on a named
     * `h` PASS * read-only fence `"r"(h):"$3"` PASS * both stores converted PASS *
     * launder on `h` with NO clobber 6 (inert -- the clobber is the whole dial) *
     * void clobber `__volatile__("" : : : "$3")` after `h` 3 @55 (+1 insn: output-less
     * asm is a sched1 barrier, 20A) * the same launder clobbering "$2" 7 @55. */
    {
        IntrSetter d = (IntrSetter)startIntrDMA();
        __asm__("" : "=r"(d) : "0"(d) : "$3");
        g_hooks_ptr->dma_setter = d;
    }
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
     * W62-A7 (2026-08-15) 44 -> 30, still count-EXACT 116/116.  THE TIMEOUT BLOCK'S
     * ADDRESS ANCHOR (see the `int *tp` note below) closed that whole 14-diff cluster.
     * RESIDUAL (30) = three clusters, ALL the same shape: the three values of the pend
     * expression are BORN in the wrong order, and local-alloc hands $a0 / $v1 / $v0 to
     * the 1st / 2nd / 3rd born (the `li 1` constant takes $v0 in between and dies):
     *   retail birth order  I_STAT ptr ($a0), enabled ($v1), I_MASK ptr ($v0)
     *   ours                I_MASK ptr ($a0), I_STAT ptr ($v1), enabled ($v0)
     * plus the closing test's two `lhu` in the opposite pair (4 of the 30).
     * 12D-A7 CONFIRMS THE SHIPPED TREE IS RETAIL'S: the inner AND's dest is enabled's
     * reg and the outer's is I_MASK's, i.e. `I_MASK & (enabled & I_STAT)`.
     * FALSIFIED W62-A7 (all gated + reverted, on THIS basin -- 04Z re-pricing of the
     * whole w60-a1/w61-a8/w61-a20 spelling list plus new ones):
     *  - THE UNTRIED CELL (the device lab's re-diagnosis, hoist ALONE on the shipped
     *    tree): `en = state[0x18];` above `state[1] = 1;` = 35 (`unsigned short en` 36).
     *    The two converging diagnoses are now BOTH measured and BOTH falsified.
     *  - ALL SIX operand permutations of the 3-way AND at both sites: stat_en_mask 30,
     *    stat_mask_en 32, en_stat_mask 36, en_mask_stat 36, mask_stat_en 32, flat forms
     *    42 / 36; entry-only and loop-only 30.  DECISIVE: a side-by-side of the 30-scoring
     *    permutation is BYTE-IDENTICAL to the shipped form's -- fold CANONICALISES the
     *    commutative operands, so the tree spelling cannot reorder the two pointer
     *    materialisations AT ALL (this is stronger than w61-a8's count-based reading).
     *  - forcing the I_STAT pointer to be born first in its own statement:
     *    `volatile u_short *sp = g_istat_ptr;` before the store 30 (INERT), at the loop
     *    site 32, both 32; the I_MASK mirror (`mp = g_imask_ptr;` after the store) 30;
     *    both together 30; the I_STAT VALUE in a local before the store 38.
     *  - the inner AND as its own statement 30 (inert) / both sites 32 / loop only 32;
     *    the closing test's operand order swapped 32; naming I_STAT first 38.
     * ANGLE: the birth order is fixed BEFORE any source-visible choice (fold + sched1),
     * so this needs the 2.7.2 scheduler dump (-dS/-dR on CC1PSX.EXE, 12A) or a
     * zero-insn preference killer -- not another spelling sweep.
     * W63-A8 (2026-08-15): ran the instrument the W62 angle named (qty272.py).  TWO results.
     *  (1) THE TARGET IS RE-STATED, AND THE W62 READING OF IT IS WRONG.  Both pend blocks
     *      (entry = block 2, loop = block 11) carry SIX local qtys, so the 14C 3-QTY LADDER
     *      LAW does NOT apply (checked before spending on it) -- they take the qsort path and
     *      every one of them has refs == 2, so the handout is decided by LIVE LENGTH ALONE.
     *      The measured live->home map in block 2 is  live 6 -> $v1,  live 8 -> $v0,
     *      live 10 -> $a0  (pri 3333 / 2500 / 2000, allocated last-to-first up the register
     *      scan).  Inverting it gives retail's REQUIRED live lengths, which is NOT the birth
     *      order the w62 receipt read off the oracle's post-sched instruction order:
     *        required   I_STAT ptr live 10 ($a0),  I_MASK ptr live 8 ($v0),  enabled live 6 ($v1)
     *        ours       I_MASK ptr live 10 ($a0),  enabled   live 8 ($v0),  I_STAT ptr live 6 ($v1)
     *      i.e. the two POINTERS must trade live lengths AND `enabled` must become the
     *      SHORTEST-lived of the three -- a 3-way LIVE-LENGTH permutation, not a 2-way swap.
     *      That is why every w62 spelling that only reorders the two pointer materialisations
     *      (`sp = g_istat_ptr` before the store, the `mp` mirror, both together) measured 30
     *      INERT: they attack a two-element permutation that was never the target.
     *  (2) 04Z LADDER (the fn had never been laddered; the TU is wired cc1_272):
     *        cc1_272 / 2.7.2 rung  30 @116/116   (identical -- 04W: PsyQ 4.0 CC1PSX == FSF 2.7.2)
     *        2.6.3                 26 @116/116   <-- kills the closing-test `lhu` pair outright
     *        2.7.2-970404         112 @114       2.8.0 112 @114       2.8.1 112 @114
     *      The 2.6.3 rung removes the 4-diff closing-test cluster (the two `lhu` in the
     *      opposite pair) at COUNT-EXACT parity and leaves the two birth-order clusters
     *      untouched => ORCHESTRATOR WIRING candidate, whole-TU receipt in scratchpad/w63a8/
     *      (INTR.c 10/13 PASS with and without the splice, all 13 fns gated, zero regressions).
     *      It is a -4 partial, NOT a seal: land it only if the wiring debt is judged worth it.
     *  (3) CORPUS ANGLES FROM sotn-decomp + PE2 -- ALL FOUR FALSIFIED HERE (w63-a18 relay).
     *      sotn `src/main/psxsdk/libetc/intr.c :: trapIntr` is a FULLY MATCHED body for this
     *      exact function, but it is `$Id: intr.c,v 1.73 1995/11/10` (PsyQ 3.x) against our
     *      v1.76 (PsyQ 4.3), and its shape does not survive the generation gap.  Measured, all
     *      gated and reverted, against the shipped 30 @116/116 COUNT-EXACT baseline:
     *        - sotn's NO-BASE-POINTER shape (drop the `state` alias + its opacity fence, read
     *          `g_intr.inited` / `g_intr.in_handler` / `g_intr.enabled` / `g_intr.cb` by name):
     *          32 @118  -- and dropping the fence alone is the same 32 @118, so the alias is
     *          carrying two insns, not one.  The named-`enabled`-only half-step: 29 @117.
     *          Every variant goes COUNT-OVER; the shipped RR-transplant form is the only
     *          count-exact one, so all are rejected under the 14E count bar.
     *        - sotn's INDEX-FORM callback walk (`base[i]` instead of the `p++` walk): 32 @116
     *          (count-exact but +2) -- the pointer walk stays.
     *        - sotn's POST-INCREMENT timeout compare (`if ((*tp)++ >= 0x801)` replacing the
     *          4-statement read-then-store): 39 @115 -- it deletes the very copy the w60-a1
     *          note says retail keeps, confirming that receipt from the other direction.
     *        - PE2's `T* volatile` (pointer-volatile) on g_istat_ptr / g_imask_ptr, the relayed
     *          "untried birth-order lever": 51 @119, the worst of the set.
     *      => The birth-order residual survives the ONLY fully-matched corpus body in existence
     *      for this function.  That is a strong (not terminal) result: it bounds the remaining
     *      search to the 2.7.2 scheduler dumps (-dS/-dR, 12A) plus the live-length permutation
     *      named in (1), and it retires the corpus axis.
     * W67-A2 (2026-08-15) BYTE-TRUTH CERTIFICATE + revision map CORRECTION:
     *  - The PsyQ 4.3 vendor member (C:/Temp/nfs4-clean/psyq43/extracted/LIBETC/obj/INTR.obj,
     *    .text+0x26C) is BYTE-IDENTICAL to our oracle 116/116 incl. every reloc word/addend
     *    (scratchpad/w67a2/objtruth.py find/relocs).  Its .rdata $Id is **v1.75 1997/02/07**
     *    == NFS4's retail rdata string EXACTLY; the PsyQ 4.0 member is v1.76 1997/02/12 and
     *    its trapIntr (122w vs our 116w) DRIFTS 66/116 -- so 4.3 ships an OLDER-dated revision
     *    than 4.0 (rollback/branch) and every earlier "ours = v1.76" receipt line is wrong.
     *    The reloc truth confirms both access devices: entry-site `enabled` via 48($s1),
     *    loop-tail via its OWN absolute lui/lhu (.data+0x88 = g_intr+0x30) with the base LIVE
     *    in $s1 -- both already reproduced by this body; residual = pure handout, certified.
     *  - xenogears WIP trapIntr shape (their commented-out body; v1.76-era, never matched
     *    even there) gated AS-IS per 04T: 51 @117 -- FALSIFIED, count-over, worse than every
     *    sotn cell above.  The corpus axis stays retired at BOTH neighboring revisions.
     * W71-A10 (2026-08-21) 30 -> 24, COUNT STILL EXACT 116/116.  THE PEND RESIDUAL IS
     * SOURCE-REACHABLE AFTER ALL, AND THE W63-A8 READING OF THE TARGET WAS WRONG.
     *  (1) RE-STATEMENT OF THE TARGET (measured with qty272.py on the shipped body, NOT
     *      inferred from the oracle's post-sched order).  The I_STAT pointer is ALREADY
     *      $a0 in both builds -- it never had to move.  Block 2's three long qtys are
     *      88 ptr live10 -> $a0, 90 HImode live8 -> $v0, 89 ptr live6 -> $v1, and the
     *      priority ladder (pri = refs*10000/live: 2000 / 2500 / 3333) hands out
     *      $a0 / $v0 / $v1 in exactly that order in BOTH builds.  So the whole residual is
     *      a TWO-element LIVE-LENGTH swap: retail's `enabled` is the live-6 qty ($v1) and
     *      its I_MASK pointer the live-8 one ($v0); ours has them the other way round.
     *      W63-A8's "3-way permutation, the two pointers must trade" is FALSIFIED --
     *      it read the birth order off the oracle's post-sched2 stream instead of the
     *      lreg dump, and the I_STAT pointer is not in play at all.
     *  (2) THE DIAL IS THE PRE-SCHED1 BIRTH ORDER, AND NAMED LOCALS EXPOSE IT.  With all
     *      three operands read into function-scope locals BEFORE the `state[1] = 1` store,
     *      the block's pseudo birth order becomes source-controlled and the AND tree stops
     *      being re-associated by fold (with the operands as plain pseudos the emitted tree
     *      is EXACTLY the source tree -- see (4)).  Shipped form: `mp; sp; en;` then
     *      `pend = en & (*sp & *mp)`, at BOTH sites.  This is the same lever class as the
     *      `int *tp` timeout anchor W62-A7 landed 12 lines below (hold the address in a
     *      named local), not a fence and not a pin.
     *  (3) FULL SWEEP RECEIPTS (every cell gated; 12 AND-spellings x hoist-set x scope):
     *        no hoist        : 30 best (MA&(EN&ST) and ST&(EN&MA) tie; 32/36/42 elsewhere)
     *        en only         : 28 best   sp+mp only (no en) : 32   mp+en (no sp) : 28
     *        sp+en           : 26 best (and this is where the emitted TREE first equals
     *                          retail's MA&(EN&ST), with only the two homes left wrong)
     *        mp+sp+en        : 24  <-- SHIPPED.  All 6 birth orders x 12 trees swept:
     *                          a hard plateau at 24 for every EN-outer tree, 40/46 for the
     *                          rest; store-position sweep adds nothing.
     *      FALSIFIED THIS PASS (all gated, all reverted): per-site copies of the temps
     *      (en1/en2, sp1/sp2, mp1/mp2 -- 30 best, and 30 even with only en/sp split), BLOCK
     *      scopes for the temps (36-38, i.e. the catalog's "scoping only ADDS slots" law
     *      holds here), `int`/`long` for en (26), `int`/`u_int` for pend (24, inert),
     *      closing-test rewrites on the 24 basin (reuse sp/mp there 40, MA&ST swap 26),
     *      and the TU flag axis: -mno-split-addresses does not exist in this lane at all
     *      (CC1PSX 2.7.2 rejects it), -fno-schedule-insns 34 @118, -fno-strength-reduce 30.
     *  (4) STANDING NOTE CORRECTED: W62-A7's "fold CANONICALISES the commutative operands,
     *      so the tree spelling cannot reorder the two pointer materialisations AT ALL" is
     *      true ONLY while the operands are still MEM-off-SYMBOL expressions.  Once they are
     *      pseudos the tree is verbatim, which is what makes (2) work.
     * W72-A19 (2026-08-22) RE-GATED 24 @116/116.  The three axes the W71 note left open are
     * now measured with the 21A/20B instrument set (which postdates it), and all three are
     * NEGATIVE -- the residual survives every zero-insn device this campaign owns:
     *  (a) THE JOINT GRID the 21A-5 "per-axis minima hide joint cells" law asks for: all
     *      6 assignment orders x 4 store positions x 6 AND-trees = 144 cells, gated.  Hard
     *      plateau at 24 for every EN-outer tree at any store position; MA-outer 42, ST-outer
     *      38, (ST&MA)-outer 28, flat forms 28-42.  The store position is provably inert.
     *  (b) THE mp-INLINE (26-diff) BASIN RE-OPENED AND READ OFF.  With `sp`+`en` hoisted and
     *      `mp` left inline the emitted TREE IS RETAIL'S (`*mp & (en & *sp)`, both `and`
     *      dests correct) at 26 @116, so 26 is STRUCTURALLY closer than the shipped 24 --
     *      and qty272.py names the exact remaining delta: block 2's locals then hold $v0 AND
     *      $v1 (93/92 -> $v0, 94/91 -> $v1), so the global allocno `en` (rank 6, pri 10000)
     *      cannot get $v1 and falls to $a1.  Retail's block-2 locals occupy only $v0 and $a0
     *      (its `*sp` load REUSES sp's own $a0 and its `*mp` load reuses mp's $v0), leaving
     *      $v1 free for `en`.  So the target is: keep TWO registers for four local qtys.
     *      Falsified toward it: per-site `en`/`sp`/`mp` copies (32-36 -- they become extra
     *      local qtys and take MORE registers, the opposite of what is needed), `int en` 46
     *      @118, `mp` assigned after the store 38, entry `en` read as `g_intr.enabled` 27
     *      @117, loop `en` read as `state[0x18]` 55 @117, `en` read after the store 26.
     *  (c) THE ZERO-INSN DEVICE SWEEP, all inert or worse: a 20B clobber launder on `en`
     *      ("$4" 30 @118, "$4"+"$5" 30 @118, entry-only 27 @117, loop-only 29 @117 -- the
     *      launder MINTS a copy because `en` is a two-block global, so every cell goes
     *      count-over); the same on `mp` ("$3" 29 @117, "$2" 27 @117); a read-only fence with
     *      "$4" 30 @118; the 20A void clobber `__asm__("" : : : "$4")` / "$4","$5" / "$3"
     *      inside either pend block -- BIT-FOR-BIT INERT at 24 (a bare CLOBBER does not enter
     *      global.c's conflict set for an allocno that local-alloc never saw); an 'm'-operand
     *      fence on `g_intr.inited` before the pend expression 48-52 @120 (the instrument
     *      that sealed `_set_intr_callback` below is CATASTROPHIC here -- 21A-5's "inert on
     *      already-correct seats" boundary, this fn's address allocnos are already right);
     *      an 'm' fence on `g_imask_ptr` 24 (inert, both basins); read-only fences on `en`
     *      32 / on `sp` 26.
     *  NAMED NEXT ANGLE (unchanged in kind, now precisely bounded): the 26 basin, not the 24
     *  one, is the place to stand -- it needs ONE device that makes a local qty's dest REUSE
     *  its dying source register (the `lhu $a0,0($a0)` / `lhu $v0,0($v0)` shape) so block 2
     *  spends two registers instead of four.  That is local-alloc.c's combine_regs /
     *  reg_qty tie (C:/Temp/gcc-2.8.1-src/extracted, local-alloc.c:1866), i.e. the 06E
     *  instrument gap again -- but with a 2-register target and a readable comparator.
     *  RESIDUAL 24, three clusters, all the same two-element handout: `en` takes $a0 (it is
     *  a GLOBAL allocno -- used at both pend sites -- so global.c, not local-alloc, homes it)
     *  where retail has $v1; the I_MASK pointer takes $v1 where retail has $v0; and the
     *  closing test's two `lhu` are in the opposite pair (4 of the 24, untouched by every
     *  spelling and killed outright only by the 2.6.3 rung, W63-A8 (2)).  NAMED NEXT ANGLE:
     *  `en` must become a BLOCK-LOCAL qty at each site WITHOUT paying the extra frame slot a
     *  C block scope costs -- i.e. the 06E local-alloc handout again, but now with a
     *  two-element target and a live-length dial that is known to work.
     * W74-A17 (2026-08-23) RE-GATED 24 @116/116 (twice).  ~90 further cells measured, none
     * better; but the TARGET IS NOW READ OFF THE TWO STREAMS EXACTLY and the W72 reading of
     * the 26 basin is CORRECTED.
     *  (1) RETAIL'S PEND BLOCK, decoded (identical shape at BOTH sites -- and note the gate
     *      is reloc-name lenient, so which of g_istat_ptr/g_imask_ptr is which does NOT
     *      affect the score; only the SHAPE does):
     *          lui/lw $a0   = ptrX (the INNER and's pointer)
     *          lhu $v1,48($s1) = en                      <-- born SECOND, before `state[1]=1`
     *          li $v0,1 ; sh $v0,2($s1)
     *          lui/lw $v0   = ptrY (the OUTER and's pointer)
     *          lhu $a0,0($a0)   = *ptrX  -- REUSES ptrX's own dying $a0
     *          lhu $v0,0($v0)   = *ptrY  -- REUSES ptrY's own dying $v0
     *          and $v1,$v1,$a0  = en & *ptrX ; and $v0,$v0,$v1 = *ptrY & inner
     *      i.e. retail's tree is `*ptrY & (en & *ptrX)` = EN-INNER, and the two derefs each
     *      reuse their own pointer's register, so the block spends exactly $a0 + $v0 and
     *      leaves $v1 to `en`.  OURS emits the two pointer loads first, then the derefs into
     *      the two LOWEST free caller-saved regs ($v0,$v1), and `en` LAST into whatever is
     *      left ($a0).
     *  (2) WHY (mechanism, from local-alloc.c): `en` is fn-scope and used at BOTH pend sites
     *      => it is a GLOBAL allocno, and global.c runs AFTER local_alloc.  A not-yet-
     *      allocated global pseudo occupies NOTHING in find_free_reg's `regs_live_at` scan
     *      (local-alloc.c:2214), so it cannot make $v1 busy for the derefs; the derefs take
     *      the lowest free regs and `en` gets the leftovers.  THE DEREF-REUSES-ITS-POINTER
     *      SHAPE NEEDS NO combine_regs (local-alloc.c:1866 is NOT the gate here -- a load's
     *      memory operand has an 'm' constraint, so block_alloc never even calls combine_regs
     *      with the base register): a pointer qty dying as an INPUT at insn N gets
     *      qty_death = 2N (wipe_dead_reg, :2160) and the loaded value born as an OUTPUT gets
     *      qty_birth = 2N+1, so the ranges are DISJOINT by construction and the reuse is
     *      purely a question of which register the numeric scan finds free.
     *  (3) THE 26 BASIN'S TREE IS *NOT* RETAIL'S (W72-A19 (b) corrected).  Re-measured:
     *      the mp-inline cell emits `en & (*A & *B)` = EN-OUTER at both sites, same as the
     *      shipped 24.  What DOES emit retail's EN-INNER tree is `pend = *mp & (en & *sp)`
     *      with the operands as pseudos -- and that basin is 38 (order sp,en,mp) / 40 / 42 /
     *      46, because the homes then rotate.  Its stream is retail's INSTRUCTION-FOR-
     *      INSTRUCTION with a 3-register rotation (ours {en=$a1, ptrY=$v1, *ptrX=$v0} vs
     *      retail {en=$v1, ptrY=$v0, *ptrX=$a0}).
     *  (4) MAKING `en` BLOCK-LOCAL DOES BUY THE REUSE, and is the closest structural cell
     *      found: a per-site `{ unsigned short en = ...; }` block gives `lhu $a0,0($a0)`
     *      (the deref reusing its own pointer, exactly (1)) and a stream that is retail's
     *      modulo ONE swap -- ours emits ptrY's `lui/lw` at slot 24-25 and `en` at 28, retail
     *      emits `en` at 24 and ptrY at 27-28; the register pair follows the emission order.
     *      Score 30 (best of a 36-cell grid: 6 pointer-assignment orders x 6 AND-trees).  The
     *      whole remaining question is therefore a SCHED1 TIE between `en`'s `lhu` and ptrY's
     *      `lw` (equal chain depth 3), not an allocator question.
     *  FALSIFIED THIS PASS (all gated, all reverted): the 36-cell block-local grid (best 30);
     *  per-site fn-scope en1/en2 32 (24 basin) / 32 (retail-tree basin); all three temps
     *  block-scoped 36; retail-tree x 4 assignment orders 38/40/42/46; retail tree with mp
     *  inline 26 / with sp inline 40; a read-only fence or a 20B launder on `en` inside the
     *  block-local basin 40 (both are sched barriers or mint a copy); a void `"i"(0)` fence
     *  32 (inert); and THE DEVICE THAT SEALED `_initIntr` ABOVE -- a named deref temp
     *  (`unsigned short sv = *sp;`) plus a zero-insn clobber launder, swept over clobbers
     *  $2..$7 on both `*sp` and `*mp` -- ALL go COUNT-OVER at 118 (best 24 @118, i.e. the
     *  named volatile-deref temp mints an extra insn here) and are rejected under the 14E
     *  count bar.
     *  NAMED NEXT ANGLE (sharpened): stand in the BLOCK-LOCAL 30 basin and swap the sched1
     *  emission order of `en`'s `lhu` against the second pointer's `lw` -- equal INSN_PRIORITY
     *  chain depth, so the tie falls to luid/source order, and every source reorder tried so
     *  far is inert because fold decides which pointer is the inner operand.  The instrument
     *  is the sched1 dump ([sched_pick], C:/Temp/nfs4-instr-cc1), not another spelling sweep.
     * 🏆 W75-A16 (2026-08-23) 24 -> 20 @116/116, gated 2x, whole TU 11/13 unchanged.  THE
     * CLOSING-TEST CLUSTER IS CLOSED -- by WIRING, not by a spelling: a per-fn 2.6.3 rung
     * (PER_FN_CC1_VER_SPLICE_272 row in tools/build.py).  Three results, all receipts:
     *  (1) THE RUNG DIFFERENCE IS NOW CHARACTERISED, not just scored.  Diffing the two
     *      cc1 outputs for the WHOLE function (scratchpad/w75/a16_intrhand_272.s vs
     *      a16_intrhand_263.s, 166 lines each) the ONLY codegen difference is the closing
     *      test's register pair: 2.7.2 emits `lhu $3,0($5); lhu $2,0($6)`, 2.6.3 emits
     *      `lhu $2,0($5); lhu $3,0($6)` == retail (the first deref takes $v0, the second
     *      $v1).  Every other delta is `move $d,$s` vs `addu $d,$s,$0`, which the gate
     *      normalises.  So the "2.6.3 -4" banked since W63-A8 is exactly this cluster and
     *      nothing else -- the rung cannot be masking a source lever.
     *  (2) THE RUNG IS ORTHOGONAL TO THE PEND RESIDUAL (measured, 5 basins x 3 rungs):
     *      shipped 24->20, mp-inline 26->22, block-local-en 32->28, sp/en/mp order 28->24,
     *      retail-EN-INNER-tree 38->34; 2.6.0 == 2.6.3 everywhere; 970404/2.8.0/2.8.1 all
     *      110 @114 (count-OFF) on every basin.  => -4 is a constant offset, so future
     *      source work on the pend blocks re-prices unchanged under the rung.
     *  (3) NOT VACUOUS (the W74-A19 LM/.loc trap does NOT reach this lane): the strip fix
     *      lives only in _apply_cc1_ver_splice (default lane).  It is not needed in the 272
     *      lane because _compile_c_272's cc1_flags are `-quiet -O2 -G<n> -mgas` with NO
     *      `-g1`, so the sub-2.8 rungs emit no COFF debug at all -- verified 0 `LM<n>:` and
     *      0 `.loc` in the rung's .s, and the gate reads the full 116/116.  Every earlier
     *      272-lane sub-2.8 ver-splice number (incl. W63-A8's ladder) was therefore REAL.
     * W75-A16 PEND-BLOCK WORK (all gated, all reverted; nothing beat 24 in-lane), plus TWO
     * corrections to banked mechanism claims:
     *  🔴 CORRECTION to W72-A19(c): "a bare CLOBBER does not enter global.c's conflict set"
     *     is FALSE as a mechanism.  global.c:1384 mark_reg_clobber -> :1239 record_one_conflict
     *     DOES set hard_reg_conflicts[j] for every allocno LIVE AT THAT INSN, hard regs
     *     included.  The real reason those cells read inert is placement: a clobber-ONLY
     *     `__asm__("" : : : "$N")` has zero operands, and sched.c:1987 gates the
     *     everything-barrier on `code != ASM_OPERANDS || MEM_VOLATILE_P (x)` -- a
     *     non-volatile ASM_OPERANDS with no inputs has NO dependences at all, so the insn
     *     floats to the TOP of the block (verified in the .s: the #APP lands before the
     *     first pointer load), i.e. OUTSIDE `en`'s live range, where the conflict is a
     *     no-op.  Re-measured here: "$2"/"$3"/"$4"/"$5"/"$4","$5"/"$4","$5","$6" ALL 24,
     *     bit-for-bit.  The forms that DO stay put cost insns: `__asm__ __volatile__(""
     *     : : : "$4")` 36 @118, bare `__volatile__("")` 30 @118, read-only `("" : : "r"(en)
     *     : "$N")` 28-40 @118 (the fence pulls `en`'s load out of the load-delay gap that
     *     `lhu a0,48(s1)` was filling, so each site mints a nop).
     *  🆕 NEW LAW -- WHY THE TWO POINTER LOADS HOIST ABOVE `state[1] = 1` (sched.c:830
     *     true_dependence): a read X after a store MEM is dependence-FREE when
     *     `MEM_IN_STRUCT_P (mem) && rtx_addr_varies_p (mem) && !MEM_IN_STRUCT_P (x) &&
     *     !rtx_addr_varies_p (x)`.  `state[1] = 1` is an ARRAY_REF (/s) at a pseudo base
     *     (varying); `g_imask_ptr` is a plain VAR_DECL (no /s) at a symbol (fixed) -- the
     *     exclusion fires exactly, so sched1 is free to hoist BOTH pointer loads above the
     *     store no matter where the source puts them (this is why every mp/sp statement
     *     reorder measured inert since W62).  RESPELLING THE STORE AS A CAST INDIRECT_REF
     *     `*(unsigned short *)((char *)state + 2) = 1;` removes its MEM_IN_STRUCT_P, the
     *     exclusion stops firing, and the hoist DISAPPEARS -- at zero insns.  With the
     *     `sp; en; store; mp` order that reproduces retail's entry-block SHAPE for the
     *     first time in this campaign: `lui/lw $a0`(sp) | store | `lui/lw`(mp) | derefs,
     *     i.e. sp lands in retail's own $a0 and mp is materialised AFTER the store (28 ->
     *     24; a `("" : : "r"(sp) : "$2","$3")` fence reaches the same 24 without the cast).
     *     It is NOT landed because it ties the shipped 24 -- the LAST divergence is that
     *     `en` is a fn-scope (GLOBAL) allocno, so global.c homes it after local_alloc and
     *     it takes the leftover; retail's block spends only $a0+$v0 on locals, leaving $v1
     *     for `en`, while ours spends $a0+$v0+$v1 because `*sp` (higher priority, refs 2 /
     *     live 3) grabs $v0 before mp can reuse the dead `li $v0,1` register.
     *  NAMED NEXT ANGLE (re-aimed, and now a 1-element target): stand in the CAST-STORE
     *  `sp; en; store; mp` basin (24, structurally retail's) and make `*sp` land in $a0 --
     *  it needs $v0 AND $v1 unavailable at its birth, which is what retail's live `en`($v1)
     *  + `mp`($v0) provide.  The only vehicle left that does not cost an insn is a hard-reg
     *  conflict placed INSIDE `*sp`'s live range but OUTSIDE `mp`'s -- impossible with a
     *  clobber (they overlap), so it is either (a) an allocation-ORDER dial that demotes
     *  `*sp` below `mp` in local-alloc's qsort (refs/live-length, tools/qty272.py), or
     *  (b) making `en` a per-site LOCAL that local_alloc actually seats in $v1 (the
     *  block-local grid is 30-36 today; the cast-store basin has never been crossed with
     *  it).  FALSIFIED THIS PASS on top of everything above: cast-store x {EN-OUTER,
     *  EN-INNER} x {no fence, sp-fence, en-fence x 6 clobbers} (24 best, 28-46 elsewhere);
     *  block-local `en` x cast store 32-36 (40-44 @118 when `en` is read as
     *  `g_intr.enabled`); per-fn -fno-schedule-insns 26 @116 (and it does NOT stop the
     *  hoist -- the hoist is a DEPENDENCE fact, not a scheduling one), -fno-schedule-insns2
     *  30, -fno-strength-reduce 24, -fno-cse-follow-jumps 24, -fno-delayed-branch 29 @119.
     * W75-A16 LANE FACTS for the next agent on this TU (both verified in tools/build.py):
     *  - 3.25-3b (aspsx-filled slots) does NOT apply to either target: both are already
     *    count-exact, and -fno-delayed-branch mints an insn at each (_intrhand 29 @119,
     *    _set_intr_callback 17 @83).  The TU's PER_FN_NO_DELAYED_BRANCH set stays as is.
     *  - 🔴 RAW40 SCOPE RULE: PER_FN_RAW40_SPLICE is INERT for any `cc1_272` TU, twice
     *    over.  (1) compile_c returns from _compile_c_272 (build.py:2699) long before the
     *    raw40 block (:2751), so a row here would silently do nothing; (2) even if it ran,
     *    CC1_PSYQ40 and _resolve_cc1_272 resolve to the SAME binary on the dev box
     *    (C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE) -- the 272 lane already IS the
     *    raw-4.0 macro-form cc1 assembled by the lane's own GNU as.  Do not add RAW40 rows
     *    to INTR.c; the equivalent axis here is the ver-splice rung. */
    unsigned short *state;
    unsigned short s0;
    long pend;
    long i;
    long c;
    long t;
    long one;
    int *p;
    int *base;
    /* W71-A10 (2026-08-21) 30 -> 24, count still EXACT 116/116.  THE PEND BLOCK'S THREE
     * OPERAND ANCHORS.  See the "W71-A10" note below for the receipt; these three are the
     * same lever class as the `int *tp` timeout anchor that W62-A7 landed in this function
     * (hold the address / the value in a named local so the block's pseudo BIRTH ORDER is
     * source-controlled), not fences and not pins.  They MUST stay function-scope and
     * SHARED between the two pend sites: per-site copies score 30, block scopes 36-38. */
    unsigned short en;                  /* the enabled-IRQ mask, read once per pend site  */
    volatile unsigned short *sp;        /* I_STAT anchor                                   */
    volatile unsigned short *mp;        /* I_MASK anchor                                   */

    state = (unsigned short *)&g_intr;
    __asm__("" : "=r"(state) : "0"(state));  /* zero-insn opacity fence: keep the base a REGISTER */
    if (state[0] == 0) {
        printf("unexpected interrupt(%04x)\n", I_STAT);
        ReturnFromException();
    }
    mp = g_imask_ptr;
    sp = g_istat_ptr;
    en = state[0x18];
    state[1] = 1;
    pend = en & (*sp & *mp);
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
            mp = g_imask_ptr;
            sp = g_istat_ptr;
            en = g_intr.enabled;
            pend = en & (*sp & *mp);
            s0 = (unsigned short)pend;
        } while (pend != 0);
    }
    if ((I_STAT & I_MASK) != 0) {
        /* MATCH (w60-a1): retail MUTATES the loaded pseudo IN PLACE for the store and
         * keeps a COPY of the pre-increment value for the compare
         * (`lw t; addu c,t,zero; addiu t,t,1; slti c,c,2049; ...; sw t`).  Reading
         * straight into `c` and storing `c + 1` coalesces that copy away and lands the
         * whole fn ONE INSTRUCTION SHORT (115 vs 116).  This shape is count-EXACT. */
        /* MATCH (w62-a7): 44 -> 30 in one edit, count still EXACT.  Retail HOLDS
         * &g_intr_timeout in a register (`lui v0; addiu v0,v0,%lo`) and uses it for
         * BOTH the read and the write-back (`lw v1,0(v0)` ... `sw v1,0(v0)`); reading
         * and writing the bare global self-temps the %hi for the load and then pays
         * the assembler's $at macro for the store, and the whole 9-insn block plus its
         * register assignment diverges.  A block-local address pointer reproduces it
         * byte-for-byte (incl. retail's v1/a0 pair) and is COUNT-NEUTRAL (la = 2 insns
         * replaces lui + lui-at).  Scoped to this block so the two `g_intr_timeout = 0`
         * $at-macro stores below are untouched.
         * FALSIFIED here: the catalog's store-side $at lever (`g_intr_timeout` as an
         * unsized `[]`) RE-TESTED on this basin = 49 -- it still subtracts where retail
         * wants a held ADDRESS (w60-a1 law 5 holds); the pointer used for the STORE
         * only = 44 (inert), i.e. the anchor must carry BOTH accesses. */
        int *tp = &g_intr_timeout;
        t = *tp;
        c = t;
        t = t + 1;
        *tp = t;
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
    /* MATCH (W67-A2, 2026-08-15): 25 -> 12 -- BODY REPLACED with the xenogears-decomp
     * matched `setIntr` (src/slus_006.64/psyq/libetc/intr.c, v1.76; sotn's matched v1.73
     * is statement-identical), gated AS-IS per the 04T law.  BYTE-TRUTH provenance: the
     * PsyQ 4.3 vendor member (C:/Temp/nfs4-clean/psyq43/extracted/LIBETC/obj/INTR.obj,
     * .text+0x43C) is BYTE-IDENTICAL to our oracle 82/82 (reloc-masked; scratchpad/w67a2/
     * objtruth.py), so retail == the 4.3 lib build and the twins' source shape is the
     * real one.  The PsyQ 4.0 member (nfs3-clean/psyq400/extracted, local syms visible:
     * setIntr 85w) drifts 36/82 -- the fn was REBUILT between 4.0 and 4.3; xenogears
     * matched the 4.0-era build with gcc-2.7.2 + their flags.
     * What the transplant fixed: the (a0=base,a1=slot)<->(a1=base,a0=slot) register web
     * (the OLD Rage-Racer-transplant shape with 5 identity fences colored it backwards;
     * all fences now GONE), and the extra `andi v1,v1,0xFFFF` (old cluster (a)).
     * RESIDUAL 12 @84 vs 82, all ONE cse asymmetry, named from the vendor relocs:
     *   retail derives a SECOND base `addiu a2,a1,-4` (= &g_intr) in the `beqz` delay
     *   slot, writes the enable arm's mask via `lhu/sh 0x30(a2)` and FOLDS the disable
     *   arm onto the cb base (`lhu/sh 0x2C(a1)`); ours folds the ENABLE arm onto a1
     *   (44(a1)) and goes ABSOLUTE (lui/lui-at) in the disable arm (branch-target block,
     *   cse cold), plus keeps a 2nd `addu v0,s4,zero` return copy.  No reloc on any of
     *   those words (vendor truth) => derived-pointer reading confirmed, w63a8's
     *   "cse NON-MERGE, 3.25-3b weaker-cse family" verdict stands.
     * FALSIFIED THIS WAVE (all on this body, each gated): the whole xenogears flag set
     *   one-by-one and combined (-fpeephole/-ffunction-cse/-fpcc-struct-return/
     *   -mips1 -mcpu=3000/-msoft-float/-G8: ALL 12, inert); -fcse-follow-jumps/
     *   -fcse-skip-blocks +/- (12; both-off 36); fn-scope `IntrState *ctl` assigned in
     *   the enable arm (31 @87 -- the la materializes its own address + head recolor);
     *   `((u_short*)g_intr.cb)[22]` disable spelling (12, provably inert -- constant
     *   addresses canonicalize identically).  04Z re-ladder ON THIS BODY: 2.6.0/2.6.3
     *   = 12 @84; 970404/2.8.0/2.8.1/2.91.66 = 64 @82 COUNT-EXACT (the only count-exact
     *   basin, param web s1->s2 shifted); 2.95.2 = 77; 2.8.x|-mno-split-addresses 75 @85;
     *   2.8.0 nosplit+no-sched 83 @83.  NAMED NEXT ANGLE: re-derive the source inside
     *   the 2.8.x count-exact basin (w63a8 PADCMD precedent), or a non-asm anti-fold
     *   for `(plus (plus base -4) 48)` upstream of cse1 (unchanged from w64a8).
     * W71-A10 (2026-08-21) THE 2-INSN OVERAGE IS NAMED, BY EXPERIMENT: it is cse
     * BASIC-BLOCK COLDNESS, and retail had BOTH arms warm.  Still 12 @84; no source form
     * found, but the mechanism is now a receipt instead of a guess.
     *  - THE DIAGNOSTIC (cheap, reproducible): SWAP THE ARMS in source
     *    (`if (handler == 0) {disable} else {enable}`).  The two absolute accesses MOVE
     *    WITH THE ARM: the now-fall-through DISABLE arm emits retail's exact
     *    `lhu $v1,44($a1)` / `sh $v1,44($a1)` and the now-branch-target ENABLE arm goes
     *    absolute (`lui;lhu` + `lui $at;sh`).  Score 22 @84 -- the overage is UNCHANGED,
     *    it just relocated.  => our cc1's cse warms exactly ONE arm (the fall-through path
     *    it walks), and the cold arm has no base register in its table, so `g_intr.enabled`
     *    is materialized absolutely (+1 insn on the load, +1 on the `$at` store).
     *  - RETAIL HAS BOTH: enable arm `0x30($a2)` where `$a2 = addiu $a2,$a1,-4` (= &g_intr,
     *    computed in the DOMINATING block and stolen into the `beqz $v0` delay slot), and
     *    disable arm `0x2C($a1)` off the cb-array base.  Two different bases for the SAME
     *    field in the two arms is the fingerprint of a cse table that survived into the
     *    branch-target block -- a PASS-level (compiler-version) property, which is exactly
     *    why the 2.8.x rungs are the only COUNT-EXACT ones (04Z, above).  It also explains
     *    the delay-slot diff: ours has nothing to put there so reorg re-stages the return
     *    value (`addu $v0,$s4,$zero`), retail parks the second base there.
     *  - FALSIFIED THIS PASS (all gated, all reverted, all trying to give the cold arm a
     *    base): fn-scope `IntrState *ctl = &g_intr;` used in both arms, assigned at the top
     *    of the if-body 31 @87 * the same but whole-function (`ctl->cb[idx]`, `ctl->inited`,
     *    `ctl->enabled`) 36 @86 * `unsigned short *en = &g_intr.enabled;` before the arms,
     *    `*en |= / *en &=` 36 @84 * the if/else split into two sequential `if`s so the
     *    disable arm becomes fall-through-reachable 31 @87.  ROOT CAUSE OF ALL FOUR: cse
     *    NEVER rewrites a SET whose source is a symbolic ADDRESS into `addiu reg,base,off`
     *    (find_best_addr only fires inside a MEM), so every explicit pointer local pays its
     *    own 2-insn `la` AND steals the cb anchor, which recolors the head.  Retail's
     *    `addiu $a2,$a1,-4` therefore is NOT a source-level pointer variable.
     *  - Also re-confirmed here: -mno-split-addresses (the w48 syslib identity) DOES NOT
     *    EXIST in this lane -- CC1PSX 2.7.2 rejects the option outright.
     * 🏆 W72-A19 (2026-08-22) 12 @84 -> 4, COUNT NOW EXACT 82/82.  The W71 diagnosis was
     * right about the MECHANISM (retail's cse kept BOTH arms warm: two bases for one field)
     * and wrong about the vehicle -- the missing base is not a source pointer variable at
     * all, it is an ADDRESS ALLOCNO, and the catalog's 21A-5 'm'-OPERAND FENCE is the one
     * instrument that mints one at ZERO INSNS.  `__asm__("" : : "m"(g_intr.inited));` placed
     * once, in the guard body BEFORE the two arms, makes gcc materialise `&g_intr` -- and
     * because `&g_intr.cb` is already live in $a1 it does so as retail's own
     * `addiu $a2,$a1,-4` (insn 20, in the `beqz` delay slot, exactly where retail has it).
     * With that second base alive, the COLD arm (`handler == 0`) stops rematerialising
     * `g_intr.enabled` absolutely (`lui/lhu` + `lui $at/sh`, +2 insns) and reaches it by
     * displacement off $a1 like retail.  This is precisely the note's own "cse only rewrites
     * inside a MEM" observation used constructively: an "m" operand IS a MEM, so it enters
     * cse's table as an address without emitting a symbolic-address SET.
     * OPERAND CHOICE IS THE WHOLE DIAL (all gated, all reverted): "m"(g_intr.inited) 4 @82 *
     * "m"(g_intr.enabled) 9 @83 * "m"(g_intr.enabled)+"m"(g_intr.inited) in either order 9/4 *
     * "m"(g_intr.in_handler) 12 (inert) * "m"(g_intr.saved_imask) 12 (inert) * "m"(g_intr)
     * 12 (inert) * "m"(g_intr.cb[0]) 12 (inert).  POSITION matters too: the same fence at an
     * arm HEAD is 21-23 @81/85, in BOTH arm heads 37, after the arms 12 (inert), inside the
     * `if (handler != 0)` head 10 @84.  A `"r"` fence on a `&g_intr.enabled` local instead
     * is 29 @83 (it emits the symbolic SET the mechanism must avoid).
     * RESIDUAL 4 = the ARM-1 half of the same pair: retail reads/writes `enabled` as
     * `48($a2)` (struct base) while ours uses `44($a1)` (cb base) -- both bases are now live
     * and both spellings are legal, so it is a cse "cheapest equivalent base" tie inside one
     * arm.  Address SPELLINGS are provably inert on it (all 4 @82: `(char *)&g_intr + 48`,
     * `(char *)&g_intr.inited + 48`, `(char *)&g_intr.cb[-1] + 48`, `((u_short *)&g_intr.cb)[22]`
     * -- fold canonicalises them all), and a second 'm' fence at the arm head costs an insn.
     * NAMED NEXT ANGLE: make `&g_intr` the CHEAPER of the two bases inside arm 1 (a cost /
     * equivalence-class-order question in cse.c, readable in C:/Temp/gcc-2.8.1-src), or find
     * the natural 1997 source shape that reads `inited` through the struct base and the cb
     * array through its own -- the fence is standing in for whatever did that in retail.
     * W74-A17 (2026-08-23) RE-GATED 4 @82/82.  THE NAMED ANGLE WAS RUN -- cse.c is READ, and
     * the answer is that the SWITCH THIS RESIDUAL NEEDS CANNOT FIRE, for a reason that is a
     * general law rather than a property of this function:
     *  🔴 CSE CANNOT RE-BASE A `(plus REG small_const)` ADDRESS ONTO AN EQUIVALENT BASE.
     *    find_best_addr's expensive arm (cse.c:2813, gated on flag_expensive_optimizations)
     *    is the only path that could rewrite `44($a1)` into `48($a2)`: it looks up the BASE
     *    register's equivalence class and re-forms `cse_gen_binary(PLUS, equiv, const)`.  It
     *    accepts the new form only when `ADDRESS_COST(new) < best` OR (equal cost AND
     *    `(COST(new)+1)>>1 > best_rtx_cost`) -- STRICTLY GREATER.  On MIPS,
     *    mips_address_cost(PLUS(reg, SMALL_INT)) == 1 for BOTH forms (mips.c:1954) and their
     *    rtx_costs are identical, so `found_better` never becomes 1 and the incumbent base
     *    always wins.  => once the address exists as base+disp, NO source spelling can move
     *    it to the other base; the base is fixed at the moment the address is first formed.
     *    (The first arm of find_best_addr is unreachable here anyway: `(const (plus sym K))`
     *    is CONSTANT_ADDRESS_P on mips ABI_32 (mips.h:2595) and returns at cse.c:2707.)
     *  THE NO-FENCE STREAM, READ OFF (this corrects the W71/W72 "which arm is cold" wording):
     *    WITHOUT the 'm' fence ours is 12 @84 and it is ARM 2 that goes absolute
     *    (`lui $v1; lhu $v1,0($v1)` + `lui $at; sh $v1,0($at)`, +2 insns); ARM 1 is ALREADY
     *    `44($a1)` in both the fenced and unfenced builds.  So the fence's entire job is to
     *    give the branch-target arm a register base, and `a2` is DEAD in our object -- it
     *    exists only because the fence's MEM operand forced the address into a register (via
     *    cse's use_related_value on the `(set a2 (const sym))`, cse.c:6672), and it lands in
     *    the `beqz` delay slot by accident of reorg, matching retail's insn 20 exactly.
     *  FALSIFIED THIS PASS (22 more cells, all gated + reverted, all 4 @82 = INERT unless
     *  noted): arm-1 statement order enabled-before-nNewMask 4 / enabled-first 24; a SECOND
     *  'm' fence on `g_intr.enabled` after the cb store 6, at the arm-1 TAIL 4, at the arm-1
     *  HEAD 4; an arm-1-local `unsigned short *ep = &g_intr.enabled;` 4; one asm carrying
     *  both "m" operands in either order 4; an explicit read-modify-write temp in arm 1 4;
     *  `"=m"(g_intr.enabled)` as an OUTPUT plus the "m"(inited) input 4; `"m"(*(char*)&g_intr)`
     *  4; `"m"(inited)+"r"(&g_intr)` 4; the fence duplicated 4; `"m"(inited)+"m"(cb[idx])` 4;
     *  fence position anywhere inside the guard body (before `nMask = I_MASK`, after
     *  `I_MASK = 0`) 4, but at FUNCTION head 22 @88.  MORE FENCE OPERANDS (all 12 @84, i.e.
     *  they mint no base at all): saved_imask, saved_dpcr, jmpbuf[0], evcb[0], cb[10] -- only
     *  offset 0 (`inited`) works, because only there is the address the bare SYMBOL_REF that
     *  use_related_value can rewrite as `(plus $a1 -4)` in ONE insn.
     *  NAMED NEXT ANGLE (re-aimed by the law above): stop trying to re-base arm 1.  The base
     *  is decided where the address is FORMED, so the only reachable vehicles are (a) a source
     *  shape in which arm 1's `enabled` address is formed from `&g_intr` in the first place --
     *  which needs `&g_intr` to be a live REGISTER VALUE with a real use in arm 1, not a dead
     *  fence artifact -- or (b) a build-side per-fn textual rewrite (TEXT_MOVES cannot express
     *  it: the two words differ in base register AND displacement, not in position).
     * W75-A16 (2026-08-23) RE-GATED 4 @82/82 (twice).  The W74 angle "(b) a build-side
     * per-fn textual rewrite" is now DEAD BY POLICY (user, 2026-08-23: post-recompile
     * instruction rewrites -- PER_FN_TEXT_MOVES / RA_SINK -- are forbidden); angle (a) was
     * run to its mechanism and the target is RE-STATED one layer deeper than W74 left it:
     *  🔑 THE CHOOSER IS `use_related_value` (cse.c:1812), AND IT IS OLDEST-WINS.
     *    W74 proved find_best_addr cannot RE-base an existing `(plus reg K)`.  What FORMS
     *    the address in the first place is use_related_value, reached from cse_insn:6672
     *    under the guard `src_const && (GET_CODE (src_const) == CONST || (src_const_elt &&
     *    src_const_elt->related_value != 0))`.  It starts at the class RELT of the bare
     *    SYMBOL_REF, and on the FIRST iteration takes any REG in that class (=> `48($a2)`,
     *    retail's form); only if the symbol class has NO register does it step to
     *    `p = p->related_value`.  insert() (cse.c:1458-1460) links each new CONST just
     *    BEFORE the base, "so the element that follows SUBELT is the OLDEST one" => the
     *    step lands on the OLDEST related constant that owns a register.  Here that is
     *    `&g_intr.cb` = sym+4 in $a1, minted at insn 5 for `oldCallback = g_intr.cb[idx]`
     *    -- hence ours `44($a1)`, and hence also the guard's `lhu $v0,-4($a1)` (which BOTH
     *    builds share: same rule, offset 0-4).
     *  🔴 WHY OUR $a2 DOES NOT COUNT: the 21A-5 'm' fence's base is materialised for the
     *    "m" constraint AFTER cse, so cse never sees a `(set reg (symbol_ref g_intr))` and
     *    the symbol class stays register-less.  => the residual is NOT a cost tie inside
     *    cse (the W72/W74 "cheapest equivalent base" reading) but a TABLE-CONTENT fact:
     *    retail's cse had a REG in the symbol class at that point and ours does not.
     *  FALSIFIED THIS PASS (all gated + reverted; the 4 @82 control re-measured each run):
     *    every vehicle that puts `&g_intr` in a register in SOURCE pays for a full `la`
     *    because cc1 does NOT route the asm/pointer address through use_related_value --
     *    `__asm__("" : : "r"(&g_intr))` 15 @85 (the .s carries `la $6,D_80134AF8`, two
     *    machine words, and arm 1 STILL reads `44($a1)`, so even a live $a2 is inert while
     *    it is outside the symbol class), the same with `__volatile__` 16 @86,
     *    `"r"(&g_intr.in_handler)` 15 @85, `"r"(&g_intr.enabled)` 15 @85, the 'm' fence
     *    PLUS any of those 4-7 @82/83, `IntrState *ctl = &g_intr` assigned in the guard
     *    body and used in arm 1 only 9 @85 / in both arms 30 @86 / declared inside arm 1
     *    9 @85 (fence) and 31 @87 (no fence), an 'm' fence on `g_intr.enabled` at the arm-1
     *    head 4 (inert).  AXES re-priced on the 4-basin and all inert or worse: rungs
     *    2.6.0 / 2.6.3 / 2.7.2 = 4, 970404 / 2.8.0 / 2.8.1 = 64 @82; per-fn flags -G4 4,
     *    -G8 4, -fno-expensive-optimizations 4 (independently re-confirming W74's reading
     *    that find_best_addr's expensive arm is not the path), -fno-schedule-insns 20 @80,
     *    -fno-schedule-insns2 20 @82; `-mno-split-addresses` re-confirmed REJECTED by the
     *    lane's CC1PSX ("Invalid option `no-split-addresses'").
     *  NAMED NEXT ANGLE (sharpened to one question): get a REG into cse's bare-SYMBOL_REF
     *  equivalence class for `g_intr` before arm 1's address is formed, WITHOUT paying a
     *  `la`.  The only known zero-cost producer of such a REG is use_related_value itself
     *  rewriting a `(set reg (symbol_ref))` into `addiu reg,$a1,-4` -- which is exactly the
     *  insn retail has at slot 20 -- so the question is which construct in cc1 2.7.2 still
     *  reaches cse_insn:6672 with `src_const == (symbol_ref g_intr)`.  Read the RTL before
     *  cse (-dc / rtl_dump) for the `"r"(&g_intr)` cell and find out whether the address is
     *  already expanded to a lui/lo_sum pair at that point (in which case the answer is a
     *  rung/flag that leaves it unsplit, and none of the 2.6/2.7 rungs accept the switch)
     *  or whether src_const is set but the symbol class is simply absent (in which case a
     *  cheap earlier offset-0 REFERENCE -- not an address-take -- is the vehicle). */
    int oldCallback;
    unsigned short nMask;
    int nNewMask;

    oldCallback = g_intr.cb[idx];
    if ((handler != oldCallback) && g_intr.inited) {
        nMask = I_MASK;
        I_MASK = 0;
        nNewMask = nMask & 0xFFFF;
        /* W72-A19 (12 @84 -> 4 @82): the zero-insn 21A-5 'm'-operand fence that mints
         * retail's SECOND base `addiu $a2,$a1,-4` (= &g_intr) so BOTH arms stay warm.
         * Operand and position are both load-bearing -- see the MATCH block above. */
        __asm__("" : : "m"(g_intr.inited));
        if (handler != 0) {
            g_intr.cb[idx] = handler;
            nNewMask = nNewMask | (1 << idx);
            g_intr.enabled |= (1 << idx);
        } else {
            g_intr.cb[idx] = 0;
            nNewMask = nNewMask & ~(1 << idx);
            g_intr.enabled &= ~(1 << idx);
        }
        /* @0x800F2CC0-D20: ChangeClearRCnt(<per-IRQ root-counter index>, handler==0). */
        if (idx == 0) {
            ChangeClearPAD(handler == 0);
            ChangeClearRCnt(3, handler == 0);
        }
        if (idx == 4) ChangeClearRCnt(0, handler == 0);
        if (idx == 5) ChangeClearRCnt(1, handler == 0);
        if (idx == 6) ChangeClearRCnt(2, handler == 0);
        I_MASK = nNewMask;
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

/* W65-A6: the `IntrState g_intr;` tentative definition that stood here was WRONG twice over.
 * (1) This TU is on the cc1_272 lane (no maspsx), so it stayed a genuine `.comm g_intr,4200`
 *     = a COMMON symbol, and ld -- not the object -- places COMMONs, so it could never reach
 *     0x80134AF8 (W62-A18 T6: the largest of the 37 tree-wide COMMONs).
 * (2) 0x80134AF8 is INSIDE the initialised image (< t_addr+t_size 0x8013E000), i.e. it is NOT
 *     bss at all -- it is real, in-file data that the splat blob already owns and emits
 *     (asm/data/data_8010CCD4_r17.data.s, `dlabel D_80134AF8` and the run after it).  A 4200-byte
 *     zero-filled COMMON would have shadowed 4200 bytes of the retail image with zeros.
 * FIX = the project's asm-label alias device (W64-A19 sec.2.1) on the DECLARATION: the readable
 * name and every `&g_intr` / `g_intr.field` access are untouched, only the emitted relocation
 * NAME changes, so it is byte-neutral by construction and creates no blob-vs-TU duplicate.
 * The declaration at the top of this file carries the alias; nothing is defined here.
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
