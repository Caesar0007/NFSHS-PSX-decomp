/* W52-A8 2026-08-09 -- GCC-LADDER identity probe (04U lane); see the block below.
 * W52-A8 GCC-LADDER: SPCHPSXZ identity = gcc-2.8.0 + maspsx (the DEFAULT lane).  UNCHANGED
 * source; forced-2.8.0 = CONTROL (the lane also swaps the assembler route to direct GNU-as
 * reorder, no maspsx).
 *
 *   lane            SPCH_AddEvent
 *   default          3 (81/82)
 *   2.6.0           29 (83/82)
 *   2.6.3           29 (83/82)
 *   2.7.2-970404    11 (81/82)
 *   2.7.2           29 (83/82)
 *   2.8.0 CONTROL    3 (81/82)
 *   2.8.1            3 (81/82)
 *   2.91.66         80 (76/82)
 *   2.95.2          57 (79/82)
 *
 * READING: 2.8.0 and 2.8.1 tie the default; every other rung is far worse.  The residual-3
 * (BASE's preheader `la` copy that update_equiv_regs generates straight into base's own
 * pseudo, so no copy insn exists for local-alloc to preserve) is therefore NOT reachable by
 * a compiler-version change either -- the axis the w47-a2 / w50-a9 notes had not yet tested.
 * ALSO MEASURED (and negative) this wave: forcing the missing insn via build.py's
 * PER_FN_EPILOGUE_UNFILL reaches count PARITY (6 @82/82) but supplies a `nop` where retail
 * has the `addu t0,v0,zero` copy -- the right count, the wrong instruction.
 */
/* eaclib/psx/spchpsxz/spchevnt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 15/16 PASS ***
 *   Indexed queue walks now match SPCH_ClearEventQueue exactly and cut iSPCH_InitEventQueue from 42 to
 *   17 diffs; reconstructing gReparm as one-word callback storage made SPCH_ChooseSpeech PASS.
 *   w49-a9: iSPCH_InitEventQueue 12 -> PASS and SPCH_AddEvent 16 -> 3 (opacity/use fences, see notes).
 *   The only remaining FAIL is SPCH_AddEvent(3 = one preheader reg-reg copy).
 *   Source obj : nfs4\eaclib\psx\spchevnt.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   16 fns @[0x800E6E88 .. 0x800E7684].  The speech EVENT QUEUE -- 16 slots (gVoxEvents, base 0x80148060,
 *   stride 0x3c) selected by priority/age/subtick; events are looked up in the bound gEventDats[] blobs.
 *   Ghidra nfs4-f.exe.c (spchevnt) + disasm-v3 (authoritative) + IDA sigs.
 *
 *   Slot layout (0x3c) @ &gVoxEvents + i*0x3c:  +0x8 enabled(short) +0xa subTick(short) +0xc insertTick(int)
 *     +0x10 voxEvent(int ptr) +0x14 eventArgs[12](int).  gVoxEvents itself = the live-count (slot[0] +0).
 *   VoxEvent fields: +2 maxAge(u16) +4 priority(u16) +9 acceptProb/'d'(char) +0xa flags.
 *
 *   Ghidra-isms resolved (from updated disasm-v3): iSPCH_ChooseEvent returns the winner slot in $s4 which
 *   Ghidra DROPPED; GetFilterLength/Priority were EMPTIED; FindEventSlot/AddEvent drop the gettick() capture
 *   (iVar=gettick, not =0/=slotIdx); ChooseSpeech's `winnerSlot=&DAT_80150000` is really =iSPCH_ChooseEvent().
 *   VoxEvent_GetFilterLengthFlag / iSPCH_GetOffset16 are per-TU `static` copies (canon in spchdata.obj).
 */

/* ======================== W65-A6 DATA-MAT: the spchpsxz BSS run @0x80148044 ================
 * gPreLoadTicks / gEventDats / gVoxInGame / gVoxEvents were extern-only tree-wide (4+10+10+44
 * = 68 reloc-referenced undefined sites).  All four VAs are > t_addr+t_size (0x8013E000) so
 * they carry NO file bytes -- pure zero-init BSS.  Sizes are exact, not guessed: the run is
 * fully accounted, 0x80148428 (gGameNum) - 0x80148044 = 0x3E4 = 4 + 16 + 8 + 968.
 *   gPreLoadTicks @0x80148044   4
 *   gEventDats    @0x80148048  16   (int[4] bound event-data blobs)
 *   gVoxInGame    @0x80148058   8   (+ interior gRepeatCount @0x8014805C == gVoxInGame[1])
 *   gVoxEvents    @0x80148060 968   (+ interior DAT_80148064 == gVoxEvents+4)
 * OWNERSHIP: the four are INTERLEAVED in VA with each other while being referenced from four
 * different TUs (spchevnt/spchrand/spchinit/spchpick), and ld places whole object sections --
 * so retail had them in ONE object, and only one owner is possible.  spchevnt.obj is that
 * owner on the reference evidence (3 of the 4 are referenced here, and gVoxEvents -- 92% of
 * the run's bytes -- is spchevnt-only).
 * DEVICE = file-scope asm .bss definition, keeping every C view `extern` UNSIZED: three of the
 * four are <= the TU's -G4 (a C tentative def would land in `.sbss` as a LOCAL symbol via
 * maspsx and flip cc1 to gp-relative addressing, while the oracle has ZERO %gp_rel sites for
 * any of them), and the unsized-array shape is documented load-bearing on the decls below.
 * Byte-neutral by construction: 16/16 PASS unchanged.
 * `gRepeatCount` also drops its stale 4-byte tentative definition in spchinit.c (it was an
 * UNREFERENCED `.comm` -> a private local .sbss object at the wrong address).
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\tgPreLoadTicks\n\t.globl\tgEventDats\n\t.globl\tgVoxInGame\n"
        "\t.globl\tgRepeatCount\n\t.globl\tgVoxEvents\n\t.globl\tDAT_80148064\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "gPreLoadTicks:\n\t.space\t4\n"
        "gEventDats:\n\t.space\t16\n"
        "gVoxInGame:\n\t.space\t4\n"
        "gRepeatCount:\n\t.space\t4\n"
        "gVoxEvents:\n\t.space\t4\n"
        "DAT_80148064:\n\t.space\t964\n\t.text");
extern int            gVoxEvents[];      /* @0x80148060 : live event count + base of the 16-slot queue */
/* gVoxEventQueue: a SECOND declaration of the same storage (co-equal XDEF / asm-label view, catalog
 * wave-13 "unsized-array asm-label view").  The 0x80148060 block is a deliberate OVERLAY -- slot 0's
 * first two words (its fields start at +8) double as the live-count and the 'd'-flag -- so the queue
 * array and the counter were two named objects in EA's source.  Keeping them DISTINCT symbol_refs is
 * load-bearing for iSPCH_ChooseEvent: with one symbol, cse merges the slot cursor's base pseudo with
 * the count/SLOT() base and emits a preheader copy `reg91 = reg160` -- a ref of the cursor pseudo that
 * is rematerialized away (no instruction) but still counted by flow, taking the cursor to 16 weighted
 * REG_N_REFS.  16 is a floor_log2 razor edge: prio 4*16/73 = 0.877 beats `age`'s 3*12/45 = 0.800 and
 * the two swap $s2/$s3 vs retail.  With the separate view the cursor drops to 15 refs (3*15/73 = 0.616)
 * and the whole callee-saved assignment matches retail exactly (46 -> 35 diffs).  ⚠ the SLOT()/count
 * sites must STAY on `gVoxEvents` -- routing them through the queue view costs 22 diffs here and
 * breaks SPCH_ChooseSpeech's PASS. */
extern unsigned char  gVoxEventQueue[] __asm__("gVoxEvents");
/* Typed view of the same queue for iSPCH_ChooseEvent: a 0x3c-byte slot whose named fields start
 * at +8 (the first two words overlay the live count / 'd' flag, see above). */
typedef struct {
    int            _ovl0;        /* +0x0 (slot 0: live event count) */
    int            _ovl4;        /* +0x4 (slot 0: 'd'-event flag)   */
    unsigned short enabled;      /* +0x8  */
    unsigned short subTick;      /* +0xa  */
    int            tick;         /* +0xc  insert tick */
    int            event;        /* +0x10 VoxEvent ptr */
    int            args[10];     /* +0x14 .. 0x3c */
} VoxSlot;
extern VoxSlot        gVoxQueue[] __asm__("gVoxEvents");
extern int            DAT_80148064;   /* @0x80148064 : "kept a 'd' event" flag */
extern int            gLastTick[];    /* last insert tick (array decl -> explicit lui+%lo) */
extern unsigned short gLastSubTick[]; /* sub-tick counter for same-tick inserts */
extern int            gPreLoadTicks;  /* speech pre-load tick offset */
extern int            gFilterSetting[]; /* active filter mode (1 = length/priority filter on) */
extern int            gEventDats[];   /* @0x80148048 : int[4] bound event-data blobs (spchrand-owned) */

extern int  gettick(void);                                  /* eaclib timer.obj */
extern int  iSPCH_Rand(int n);                              /* spchrand */
extern int  iSPCH_OneChosen(void);                          /* spchpick */
extern void iSPCH_PlayChosen(void);                         /* spchpick */
extern int  iSPCH_ChooseSentence(unsigned int *eventArgs);  /* spchpick (returns chosen-count) */

/* gReparm @0x801370A0 : optional "re-parameterize" hook -- if set, retried per index until a sentence
 *   is chosen or the hook returns <=0.  Signature from SPCH_ChooseSpeech's jalr call site. */
extern int gReparm[];  /* one-word callback storage; cast to its callable signature at use */

/* ---- per-TU static copies of shared helpers (canon in spchdata.obj) ---- */
static int VoxEvent_GetFilterLengthFlag(int e)   /* @0x800E6E88 */
{
    return (int)*(unsigned char *)(e + 0xa) & 1;
}
static int iSPCH_GetOffset16(int base, int tableBase, int index)  /* @0x800E6EA8 */
{
    return base + ((int)*(unsigned short *)(tableBase + index * 2) << 2);
}
static inline int *iSPCH_EventBase(int *base)
{
    /* Identity keeps the winner lookup's base materialization ahead of its index arithmetic. */
    return base;
}

extern unsigned int VoxEvent_GetKeepTillExpiresFlag(int e);            /* @0x800E6E94 */
extern int  iSPCH_SearchEventDat(int dat, unsigned int eventID);      /* @0x800E6EC4 */
extern int  iSPCH_FindEvent(unsigned int eventID);                    /* @0x800E6F4C */
extern void iSPCH_InitEventDat(void);                                 /* @0x800E6FBC */
extern int  GetFilterLength(void);                                    /* @0x800E6FE4 */
extern int  GetFilterPriority(void);                                  /* @0x800E6FFC */
extern void iSPCH_InitEventQueue(void);                               /* @0x800E7014 */
extern int  iSPCH_FindEventSlot(unsigned int priority);              /* @0x800E7088 */
extern int  SPCH_AddEvent(unsigned int *table);                      /* @0x800E71B8 */
extern int  iSPCH_ChooseEvent(void);                                 /* @0x800E7300 */
extern void SPCH_ClearEventQueue(void);                              /* @0x800E74E0 */
extern void iSPCH_ClearOldEvents(int winnerSlot);                    /* @0x800E7528 */
extern void SPCH_PlaySpeech(void);                                   /* @0x800E7644 */
extern int  SPCH_ChooseSpeech(void);                                 /* @0x800E7684 */

#define SLOT(i)  ((unsigned char *)gVoxEvents + (i) * 0x3c)

/* VoxEvent_GetKeepTillExpiresFlag @0x800E6E94 : bit 2 of the event flags byte (+0xa). */
extern unsigned int VoxEvent_GetKeepTillExpiresFlag(int e)
{
    return (unsigned int)*(unsigned char *)(e + 10) >> 2 & 1;
}

/* iSPCH_SearchEventDat @0x800E6EC4 : address of the entry in blob `dat` whose id == eventID, or 0. */
extern int iSPCH_SearchEventDat(int dat, unsigned int eventID)
{
    unsigned int count = *(unsigned short *)(dat + 2);
    int table = 0;
    if (count != 0) {
        do {
            unsigned short *p = (unsigned short *)iSPCH_GetOffset16(dat, dat + 0xc, table);
            table = table + 1;
            if (*p == eventID)
                return (int)p;
        } while (table < (int)count);
    }
    return 0;
}

/* iSPCH_FindEvent @0x800E6F4C : search all 4 bound blobs for eventID; returns its entry ptr, or 0. */
extern int iSPCH_FindEvent(unsigned int eventID)
{
    int  i = 0;
    int *p = gEventDats;
    int  result;
    while (*p == 0 || (result = iSPCH_SearchEventDat(*p, eventID), result == 0)) {
        i = i + 1;
        p = p + 1;
        if (3 < i)
            return 0;
    }
    return result;
}

/* iSPCH_InitEventDat @0x800E6FBC : clear the 4 bound event-data blob pointers. */
extern void iSPCH_InitEventDat(void)
{
    int i = 3;
    do {
        gEventDats[i] = 0;
        i = i - 1;
    } while (-1 < i);
}

/* GetFilterLength @0x800E6FE4 : the filter-length config word from the first bound blob (+4). */
extern int GetFilterLength(void)
{
    return *(int *)(gEventDats[0] + 4);
}

/* GetFilterPriority @0x800E6FFC : the filter-priority config word from the first bound blob (+8). */
extern int GetFilterPriority(void)
{
    return *(int *)(gEventDats[0] + 8);
}

/* iSPCH_InitEventQueue @0x800E7014 : zero all 16 queue slots (header + 12 eventArgs each) and the ticks. */
extern void iSPCH_InitEventQueue(void)
{
    /* Residual 17: the indexed outer walk and volatile ascending argument clear recover the oracle's
     * offsets/up-count loop; gcc still folds the separate base, slot, and end induction values together.
     *
     * w32-a9 INVESTIGATION (kept as a floor + a toolchain-identity data point, source form NOT changed):
     * the retail SHAPE is a label+goto double loop with SIX live values -- argBase($a2), base($a3),
     * slot($a0), end($t0), j($a1), off($v1) -- i.e. it never went through loop.c (no biv elimination,
     * no giv reduction of `base+off`, no up-count->down-count reversal).  Writing both loops as
     * label+goto reproduces that shape EXACTLY: 28/29 insns, every instruction in the oracle's order,
     * every value in its own register.  It is REJECTED here only because the ALLOCATION order differs
     * and costs more textual diffs than this form (31 vs 17):
     *   cc1 -dl says slot = 11 refs / 21 insns => prio floor_log2(11)*11/21 = 1.57  -> takes $v1 (1st)
     *                off  =  4 refs / 12 insns => prio            2*4/12 = 0.67  -> takes $a0 (3rd)
     *   retail has the REVERSE (off=$v1 first, slot=$a0 second), which this priority formula cannot
     *   produce for ANY spelling of the same six values: with slot at 9-11 refs it would need
     *   live_length(slot) > 3.4x live_length(off), impossible in a 29-insn function.  => retail's cc1
     *   weights SHORT LIVE RANGE over REF COUNT more strongly than psq43 cc1 does; same family as the
     *   catalog's suspected `allocno_compare` delta (sbdload/purge/start/serve).  Additionally retail
     *   keeps a redundant `addu a3,v0,zero` copy of the la result that our cc1 always fuses into the
     *   `addiu` (the known no-copy-prop identity gap) -- that is the 29th instruction.
     *
     * w33-a10 RE-VERDICT: FLOOR HOLDS, and a9's derivation can no longer be reopened with SLD --
     * SPCHPSXZ has NO SLD records at all (see SPCH_AddEvent's note), so there is no independent
     * statement-segmentation evidence to test the label+goto hypothesis against.  Two build-lane
     * probes are also negative: -mno-split-addresses (the flag that turned out to be PAD.OBJ's
     * identity) takes this fn 17 -> 40, and the per-function -fno-delayed-branch splice takes it
     * 17 -> 22 -- though note the splice DOES reach exact insn parity 29/29, i.e. it supplies the
     * two missing instructions but puts them in the wrong places.  PROTOTYPE AUDIT: void(void)
     * confirmed -- no $aN is read before being written and $v0 holds only a leftover %hi at the
     * epilogue.
     * w34-a9 NEW MEASUREMENTS (form NOT changed; the baseline do-while stays at 17).
     * A HYBRID that a9/a10 had not tried -- OUTER loop label+goto (kills the giv
     * anchor / keeps the retail shape) with the INNER loop left a natural do-while
     * (so its refs still get the loop-depth doubling) -- compiles to 28 insns in the
     * oracle's exact instruction ORDER, 31 diffs.  cc1 -dl/-dg for it: slot(r83)
     * 11 refs/21 insns = 1.571 -> $v1, off(r86) 7/11 = 1.273 -> $a0, j(r85) 7/12 =
     * 1.167 -> $a1, argBase(r80) 4/23 = 0.348 -> $a2, base(r81) 3/40 = 0.075 -> $a3,
     * end(r84) 2/38 = 0.053 -> $t0.  Retail is off->$v1, slot->$a0 with the rest
     * identical, i.e. it needs prio(off) > prio(slot): off at 8 refs would give
     * 3*8/11 = 2.18, or slot at <= 8 refs would give 3*8/21 = 1.14.  A diagnostic
     * that DOES flip it -- writing the outer-loop bump as `argBase = off + 0xc`
     * instead of `argBase += 0x3c` (one extra off ref) -- gives slot=$a0 correctly
     * but then cc1 MERGES off and argBase into one induction pseudo, losing the
     * `addu $v1,$a2,$zero` copy (27 insns, 22 diffs).  Making BOTH loops natural
     * re-introduces the giv anchor (`addiu a1,a2,16` + -8/-6/-4/0 displacements,
     * 30 insns / 41 diffs).  The 29th instruction retail has and we never emit is
     * the second la copy (`addu $a0,$a3,$zero`): our cc1 copy-propagates
     * `base -> slot` because `base` is never modified, and only the copy that
     * SURVIVES a modification (`addu a3,v1,zero`) is kept.  Same no-copy-prop
     * identity as SPCH_AddEvent's two preheader copies.
     * w34-a9 BEST SHAPE FOUND (29 diffs / 28 insns -- still worse than this 17-diff
     * short form, so NOT kept, but it is the one to hand a permuter): a NATURAL
     * do-while outer loop over a `slot` walker + `end` bound, with the four header
     * stores marked `volatile`.  The volatile qualifier is what kills the giv anchor
     * (28 insns, not 30) WITHOUT giving up the loop notes -- so the inner loop's refs
     * keep their loop-depth weighting, which is the whole point: it lifts off from
     * 7/11 (goto-outer) to 11/11 = 3.00.  Remaining blocker is one allocno step:
     * slot 16 refs / 20 insns = 4*16/20 = 3.20 still edges out off's 3.00, and 16 is
     * again an exact floor_log2 razor edge -- slot at <= 15 refs collapses to
     * 3*15/20 = 2.25, or off at >= 12 refs rises to 3*12/11 = 3.27.  Sourcing BOTH
     * `end` and the `gVoxEvents[1]` store from `base` (not from `slot`) already took
     * slot 18 -> 16 refs and 31 -> 29 diffs; the last ref cannot be shed without
     * changing an instruction retail has (the outer test is `slt slot,end`, the four
     * header stores and the `addiu slot,slot,0x3c` are all retail's).  Falsified for
     * the off side: `argBase = off + 0xc` (cc1 then MERGES off and argBase into one
     * induction pseudo, 27 insns / 34 diffs) and a named `a = off + base` address
     * temp (neutral, 29). */
    /* w35-a4 (17 -> 12, and insn parity is now EXACT 29/29; every register matches retail and the
     * ONLY residual is the 6-insn prologue).  a9's "best shape" was right; what it lacked was the
     * two REF DIALS that make the allocator produce retail's assignment:
     *   (1) the six-value retail shape, with the INNER loop written label+goto so loop.c never sees
     *       it (a natural inner do-while gets REVERSED to a down-counter `li 11; addiu -1; bgez`,
     *       because with `off` carrying the address `j` is a pure counter) and the four header
     *       stores `volatile` so the giv anchor never forms.
     *   (2) `slot` taken from a SEPARATE declaration of the storage (gVoxEventQueue, see the decl
     *       comment) so cse cannot fuse it with `base`.  With one symbol our cc1 copy-propagates
     *       base -> slot, which BOTH loses retail's `addu $a0,$a3,$zero` copy AND moves the
     *       `sw zero,4(base)` onto slot's register -- costing `base` the ref that lifts it over
     *       `end`.  Two views: base 4 refs/36 = 0.222 > end 3/42 = 0.071, so base takes $a3 and
     *       end $t0 exactly as retail.
     *   (3) `end = base + 0x3c0` instead of `slot + 0x3c0`.  Retail computes it off slot
     *       (`addiu $t0,$a0,0x3C0`) but that OUT-OF-LOOP ref is slot's 16th weighted REG_N_REFS,
     *       and 16 is a floor_log2 razor edge: 4*16/22 = 2.909 beats off's 3*8/11 = 2.18 and the
     *       two swap $v1/$a0.  Sourcing `end` from `base` sheds it: slot 3*15/22 = 2.045, which
     *       lands BETWEEN off (2.18) and j (2.00) -- the exact retail order
     *       off=$v1, slot=$a0, j=$a1, argBase=$a2, base=$a3, end=$t0.  Cost: one operand diff on
     *       the `addiu $t0` (a3 vs a0).  (Falsified on the way: moving `off = argBase` below the
     *       header stores does not shorten its live range, 30 unchanged.)
     * RESIDUAL 12 = the prologue only: retail materializes the address ONCE and makes two copies
     * (`lui $v1; addiu $v0; addu $a3,$v0; addu $a0,$a3; addiu $t0,$a0; sw $zero,%lo($v1)`), we
     * materialize it twice (one `lui/addiu` per view) and keep no copies -- the per-obj
     * no-copy-prop identity (catalog SSG) crossed with the two-view requirement above.  Reverting
     * to one symbol restores the single `lui` but costs the whole register assignment (31 diffs).
     * w47-a2 MECHANISM SHARPENED (still 12; NEW NAMED ANGLE for whoever takes it next): the two
     * missing insns are NOT a copy-PROPAGATION difference, they are `delete_noop_moves`.  A
     * `(set (reg d) (reg s))` whose source DIES there is tied by local-alloc's combine_regs into
     * ONE quantity, both ends land in the same hard reg, and flow deletes the now-noop move -- which
     * is exactly what happens to every copy-chain spelling.  Retail's `addu $a3,$v0,$zero` +
     * `addu $a0,$a3,$zero` survive only because its allocator gave the two ends DIFFERENT hard regs,
     * i.e. combine_regs did NOT tie them.  So the reachable lever is anything that BLOCKS the tie
     * (source still live after the copy, or a qty conflict) -- not another spelling of the copy.
     * Falsified this wave (mini-TU probe scratch/w47_a2_ieq.py, all 28 insns / 33 diffs, i.e. the
     * copy deleted): addr->base->slot chains with the store through `addr`, with `end` off `slot`
     * or off `base`, and with the chain rooted at either view.  Flag axis also swept and CLOSED
     * (19 -f/-m options): only -fno-schedule-insns moves the count (29, but it trades the inner
     * bound test `slti`->`slt`); -fno-delayed-branch 32 insns, -fno-omit-frame-pointer 35, every
     * cse/loop/inline/defer-pop/function-cse/caller-saves/peephole switch is diff-neutral. */
    /* MATCH (w49-a9, 12 -> PASS 29/29): the w47-a2 "delete_noop_moves / combine_regs tie" angle,
     * landed with the w47-a1/a4/a5 OPACITY FENCE (`__asm__("" : "=r"(x) : "0"(x))` = a zero-insn
     * value-numbering barrier).  Retail materializes the address ONCE and keeps TWO reg-reg copies
     * (`lui $v1,%hi; addiu $v0,$v1,%lo; addu $a3,$v0; addu $a0,$a3; addiu $t0,$a0,0x3C0`).  The old
     * two-view form (gVoxEvents + gVoxEventQueue) got every REGISTER right but materialized the
     * address TWICE (the 12-diff prologue).  A plain single-symbol addr->base->slot chain loses the
     * copies (combine_regs ties a copy whose SOURCE DIES, then flow deletes the noop move) -- which
     * is what every w47-a2 probe measured.  The fences block exactly that tie at zero instructions:
     *   fence(addr)  keeps `addu $a3,$v0,$zero` alive (addr would otherwise die into base),
     *   fence(slot)  keeps `addu $a0,$a3,$zero` alive (slot is a pure copy of base at that point).
     * With the chain single-symbol, `end = slot + 0x3c0` is now the RIGHT source (retail's
     * `addiu $t0,$a0,0x3C0`): the w35-a4 note that `end` had to come from `base` was BASIN-RELATIVE
     * (it was shedding slot's 16th weighted ref in the two-view form; with the fenced chain slot no
     * longer needs the diet).  Falsified on the way, all at exact 29 or 30 insns: fence on `base`
     * instead of `slot` (+1 insn, a third copy, 3), fence(addr) alone (2 -- `sw zero,4()` goes
     * through $a0), fence(addr)+fence(slot) with `end = base + 0x3c0` (2 -- `addiu $t0,$a3`),
     * hoisting the `base+4` store above `slot = base` (2), and the whole-chain fence variants
     * without the `addr` step (30, register rotation: slot 19 refs -> $v1 ahead of off's 8/11). */
    int argBase = 0;
    int addr = (int)gVoxEvents;
    int base;
    int slot;
    int end;
    __asm__("" : "=r"(addr) : "0"(addr));
    base = addr;
    slot = base;
    __asm__("" : "=r"(slot) : "0"(slot));
    end  = slot + 0x3c0;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;   /* DAT_80148064: stored via base+4 (oracle sw 0,4(a3)) */
    do {
        int j = 0;
        int off = argBase;
        *(volatile short *)(slot + 8)  = 0;
        *(volatile short *)(slot + 0xa) = 0;
        *(volatile int *)(slot + 0xc)  = 0;
        *(volatile int *)(slot + 0x10) = 0;
      inner:
        *(int *)(off + base + 0x14) = 0;
        j = j + 1;
        off = off + 4;
        if (j < 0xc)
            goto inner;
        slot = slot + 0x3c;
        argBase = argBase + 0x3c;
    } while (slot < end);
    gLastTick[0]    = 0;
    gLastSubTick[0] = 0;
}

/* iSPCH_FindEventSlot @0x800E7088 : pick a slot for a new event of `priority` -- first a free slot, else the
 *   first expired slot, else evict the first slot with priority <= `priority`.  Returns the index, or -1. */
extern int iSPCH_FindEventSlot(unsigned int priority)
{
    int result = -1;
    int i;
    if (gVoxEvents[0] < 0x10) {
        i = 0;
        do {
            unsigned char *slot = (unsigned char *)gVoxEvents + i * 0x3c;
            if (*(unsigned short *)(slot + 8) == 0) {
                result = i;
                goto done;
            }
            i = i + 1;
        } while (i < 0x10);
    }
    {
        int tick = gettick();
        i = 0;
        do {
            unsigned char *slot     = (unsigned char *)gVoxEvents + i * 0x3c;
            int            voxEvent = *(int *)(slot + 0x10);
            unsigned short maxAge   = *(unsigned short *)(voxEvent + 2);
            if (maxAge != 0 &&
                maxAge < (unsigned int)(tick - *(int *)(slot + 0xc))) {
                *(short *)(slot + 8) = 0;
                result = i;
                gVoxEvents[0] = gVoxEvents[0] - 1;
                goto done;
            }
            i  = i + 1;
        } while (i < 0x10);
    }
    i = 0;
    do {
        unsigned char *slot       = (unsigned char *)gVoxEvents + i * 0x3c;
        int            voxEvent   = *(int *)(slot + 0x10);
        unsigned int   evPriority = (unsigned int)*(unsigned short *)(voxEvent + 4);
        if (priority >= evPriority) {
            *(short *)(slot + 8) = 0;
            result = i;
            gVoxEvents[0] = gVoxEvents[0] - 1;
            goto done;
        }
        i = i + 1;
    } while (i < 0x10);
  done:
    return result;
}

/* SPCH_AddEvent @0x800E71B8 : queue the event identified by table[0] (randomly accepted per its accept
 *   probability), copying table[0..11] into the chosen slot's eventArgs.  Returns 0.
 *   MATCH (w32-a9, 18 -> 16 diffs): the slot address is built OFFSET-FIRST (`off + base`, both plain
 *   ints) -- the oracle's per-iteration `addu v0,a1,t0` has the byte offset as operand 0, and C
 *   pointer arithmetic (`base + off`, base a `char *`) always canonicalises the POINTER to operand 0,
 *   giving the reversed `addu v0,t0,a1`.  RESIDUAL 16 (80/82) = the two redundant preheader COPIES
 *   retail keeps and our cc1 fuses (`lui;addiu v0;addu t0,v0,zero` vs our `lui;addiu t0,v0`, and
 *   `sll v0,v0,2;addu a1,v0,zero` vs our `sll a1,v0,2`) -- the per-obj no-copy-prop identity
 *   (catalog SSG), not a source shape. */
/* SPCH_AddEvent RESIDUAL 16 diffs, ours 80 / oracle 82 -- FLOOR RE-CONFIRMED
 * (w33-a10, against three fresh levers; none moved it):
 *   - SLD is UNAVAILABLE for this TU. D:\nfs4\EACLIB\PSX\PAD.C is the ONLY
 *     eaclib C file with SLD line records in nfs4-f-v3.txt; every SPCHPSXZ /
 *     EACPSXZ / SNDPSXZ member is debug-stripped (the only other SLD in the
 *     whole 0x800E4000-0x8010C000 span is C:\LIB\PSX\*.ASM). So the wave's
 *     "did the two preheader copies come from source statements?" question
 *     CANNOT be settled from debug info -- it has to be settled by codegen.
 *   - -mno-split-addresses (the new PER_TU_FLAGS key that fixed pad.c): a
 *     whole-TU probe REGRESSES every FAILing function here and breaks 9
 *     PASSes. SPCHPSXZ.OBJ was definitively built WITH split addresses.
 *   - per-function -fno-delayed-branch splice: 16 -> 31 (85 insns). No.
 *   - a3's giv-anchor levers: index form with power-of-2 stride
 *     `((unsigned int *)(off + base))[5]` = NEUTRAL (16 diffs, same insns);
 *     anonymous `(int)gVoxEvents` re-eval in the pre-loop stores = 28;
 *     anonymous re-eval inside the loop = 25 (81 insns); a dead
 *     `anchor = off + base` eval = neutral.
 * The 2-insn gap is exactly the oracle's two preheader COPIES
 * (`addu $t0,$v0,$zero` for base, `addu $a1,$v0,$zero` for off) which our cc1
 * always fuses into the producing `addiu`/`sll`; the remaining textual diffs
 * are the tail's `addu $v0,$v0,$v1` vs our `addu $v1,$v1,$v0` (dying-operand
 * choice, which then flips the `li 1` and `sh` registers -- source-level
 * operand order is canonicalized away, verified). This is the w32-a7
 * "coalesce-with-dying-pseudo vs fresh reg" irreducible core, not a shape
 * error. PROTOTYPE AUDIT (w33-a10): 1 arg -- $a1..$a3 are never read before
 * being written; returns a literal 0 in $v0 at the single epilogue, so `int`
 * is correct, not void.
 * w47-a2 MECHANISM SHARPENED (same class as iSPCH_InitEventQueue's prologue, see its note):
 * the two missing insns are `delete_noop_moves`, not copy propagation.  Retail computes BOTH
 * values into the SAME scratch ($v0) and then moves each to its home ($t0 base, $a1 off), i.e.
 * the producing insn's dest is a separate BLOCK-LOCAL pseudo and the variable is a GLOBAL
 * allocno; local-alloc's combine_regs REFUSES to tie a local qty to a global pseudo
 * (`if (reg_qty[sreg] >= -1) return 0`), so the copy survives with two different hard regs.
 * Ours produces the value straight into the variable's own pseudo, so there is no copy to keep.
 * The reachable lever is therefore "make the PRODUCER's destination a distinct short-lived
 * pseudo", which needs a second live use of that temp (cse/make_regs_eqv otherwise makes the
 * long-lived variable canonical and the move becomes a noop).  No faithful source form found
 * this wave; the falsified spelling list above stands and the flag axis is closed for the TU
 * (-mno-split-addresses breaks 9 PASSes here). */
extern int SPCH_AddEvent(unsigned int *table)
{
    int voxEvent = iSPCH_FindEvent(*table);
    if (voxEvent != 0) {
        int acceptProb = *(signed char *)(voxEvent + 9);
        if (iSPCH_Rand(100) <= acceptProb) {
            int slot = iSPCH_FindEventSlot((unsigned int)*(unsigned short *)(voxEvent + 4));
            if (-1 < slot) {
                int            tick = gettick();
                short          sub;
                int            j;
                int            base;
                int            off;
                unsigned int  *p;
                int            baseTmp;
                int            offTmp;
                int            tailOff;
                /* MATCH (w49-a9, 16 -> 3, insns 80 -> 81/82).  Three independent fixes, all from the
                 * w45/w47 fence + expression-shape rows; the old note's "no source form found" was
                 * BASIN-RELATIVE:
                 *  (a) OFF's preheader copy (`sll $v0,..; addu $a1,$v0,$zero`) is recovered by the
                 *      w47-a1/a4/a5 OPACITY FENCE on a distinct producer temp -- `offTmp` is a
                 *      short-lived pseudo, the fence stops cse/make_regs_eqv making it canonical, so
                 *      `off = offTmp` survives as a real copy instead of the `sll` writing $a1 direct.
                 *  (b) the gLastSubTick READ is scheduled AFTER the gLastTick store in retail; our
                 *      `sub = ...` sat before `j = 0` and got hoisted with its own %hi.  Moving the
                 *      assignment below `gLastTick[0] = tick;` puts it in retail's slot (-5 diffs).
                 *  (c) the TAIL `sh 1,8()` store: retail mutates the OFFSET register
                 *      (`addu $v0,$v0,$v1`), ours mutated the base (`addu $v1,$v1,$v0`).  The w45
                 *      EXPRESSION-vs-MUTATION sharpening applies -- a spelling change to the single
                 *      expression is canonicalized away (verified again), but writing the add as an
                 *      in-place mutation OF THE OFFSET temp reproduces it exactly (-6 diffs).
                 * RESIDUAL 3 = BASE's preheader copy only (`lui $v0; addiu $v0,$v0,%lo; addu $t0,$v0`
                 * vs our 2-insn `lui $v0; addiu $t0,$v0,%lo`): the split-address lo_sum is generated
                 * straight into base's own pseudo.  The `__asm__("" : : "r"(baseTmp))` USE fence below
                 * keeps baseTmp live past the copy (that is what pins the `lui` to $v0 and holds the
                 * rest of the fn at 3) but cc1 still lowers the lo_sum into base.  Falsified this pass,
                 * each measured: opacity fence on baseTmp (17 -- adds 2 refs, rotates base/tick $t0<->
                 * $a3), opacity fence on `base` after the copy (17), opacity+use fence together (17),
                 * no fence at all (5).  The base/tick rotation those forms cause IS dialable -- a
                 * zero-insn `__asm__("" : : "r"(tick))` after the tick store takes 17 -> 5 (allocno
                 * receipt: base 4 refs/22 = .3636 vs tick 4/23 = .3478, one tick ref flips it) -- but
                 * the copy itself never appears.  Named angle for the next pass: force the lo_sum into
                 * a pseudo distinct from `base` (a cse DOUBLE-EVALUATION of the address, w45 row),
                 * not another spelling of the copy.
                 * 🔴 w50-a9 2026-08-09: that named angle is FALSIFIED, together with the whole
                 * "give baseTmp a second live use" family.  Measured, all at ours 81 / oracle 82
                 * unless noted -- i.e. the copy NEVER appears:
                 *   - baseTmp given a REAL second use (the three pre-loop stores at +0x10/+0xc/+0xa
                 *     rewritten off baseTmp instead of base) = 5;  same with only the in-loop store
                 *     off baseTmp = 5;  either + an opacity fence on baseTmp = 17;
                 *   - opacity fence on baseTmp alone = 17, + a use fence = 17, + the receipted
                 *     `__asm__("" : : "r"(tick))` rotation dial = 5 (ours `lui $t0; addiu $t0,$t0`
                 *     -- the whole `la` still lands in base's own home register);
                 *   - ZERO-COST REF INFLATORS on the copy statement (catalog w44, the family that
                 *     cracked spchbank this wave): depth-2 `do{}while(0)` wrapper on
                 *     `base = baseTmp;` = 3 (neutral); arm-dup `base = baseTmp; base = baseTmp;`
                 *     = 3 (neutral).  Inflators steer WHICH register a pseudo wins; they cannot
                 *     mint a pseudo that does not exist -- and here the copy does not exist.
                 *   - DISTINCT SYMBOL VIEWS of the same storage (this TU already carries the
                 *     gVoxEventQueue / gVoxQueue asm-label views): baseTmp off the byte view = 3
                 *     (cse merges the symbol_refs anyway); base off a DIFFERENT view than baseTmp
                 *     = 5 at 83 insns -- two full materializations, i.e. +2, the wrong extra insn;
                 *   - `(int)&gVoxEvents[0]` and a pointer-typed `unsigned char *bp` intermediate = 3.
                 * MECHANISM SHARPENED: the `off` half of this very preheader IS fence-fixable
                 * (fix (a) above) because `slot * 0x3c` is a COMPUTED value with no REG_EQUIV; an
                 * ADDRESS carries one, so cse/update_equiv_regs rewrites `base = <addr>` and the
                 * lo_sum is generated straight into base's pseudo -- there is no copy insn for
                 * local-alloc's combine_regs (or the w47-a2 global-allocno refusal) to preserve.
                 * Any C form cse can prove equal collapses to ONE `la` into `base`; any form it
                 * cannot costs a second `lui/addiu` PAIR instead of retail's one-insn copy.
                 * NEXT: an instrumented -dl/-dg read to confirm the copy is absent from RTL before
                 * local-alloc (=> an update_equiv_regs question, not a combine_regs one). */
                /* *** SOLVED w53-a11 (2026-08-09): 3 -> PASS 82/82 with `-fforce-addr`, via the
                 * EXISTING per-fn dual-compile splice mechanism (build.py PER_FN_FORCE_ADDR).
                 * WIRING (orchestrator, this worker is barred from tools/):
                 *     PER_FN_FORCE_ADDR["recon/eaclib/psx/spchpsxz/spchevnt.c"] = {"SPCH_AddEvent"}
                 * Whole-TU gate under the splice: 15/16 -> 16/16, totaldiffs 3 -> 0, ZERO
                 * regressions (the splice only rewrites this fn's .ent/.end region).
                 * MECHANISM -- it is exactly the mechanism the note above named and could not
                 * reach from C: -fforce-addr makes cc1 force an address into a REGISTER before
                 * use, so the `la gVoxEvents` lo_sum is generated into its OWN pseudo instead of
                 * straight into `base`'s (update_equiv_regs never rewrites `base = <addr>`), and
                 * the `addu $t0,$v0,$zero` copy survives -- retail's missing 82nd instruction.
                 * The `__asm__("" : : "r"(baseTmp))` use fence above is STILL REQUIRED (dropping
                 * it under the splice is 5 @81/82); the two cooperate.
                 * Also probed w53-a11 and NEGATIVE on this fn: PER_FN_NO_THREAD_JUMPS (3, inert).
                 * Flag axis for the whole TU stays closed (g_value 0/8, -mno-split-addresses,
                 * cc1_ver 2.8.1 all inert-or-worse, w53-a11 matrix). */
                if (tick == gLastTick[0])
                    gLastSubTick[0] = gLastSubTick[0] + 1;
                else
                    gLastSubTick[0] = 0;
                j    = 0;
                baseTmp = (int)gVoxEvents;
                base = baseTmp;
                __asm__("" : : "r"(baseTmp));
                p    = table;
                offTmp = slot * 0x3c;
                __asm__("" : "=r"(offTmp) : "0"(offTmp));
                off  = offTmp;
                gLastTick[0] = tick;
                sub  = (short)gLastSubTick[0];
                *(int *)(off + base + 0x10)  = voxEvent;
                *(int *)(off + base + 0xc)   = tick;
                *(short *)(off + base + 0xa) = sub;
                do {
                    *(unsigned int *)(off + base + 0x14) = *p;
                    p   = p + 1;
                    off = off + 4;
                    j   = j + 1;
                } while (j < 0xc);
                gVoxEvents[0] = gVoxEvents[0] + 1;
                tailOff = slot * 0x3c;
                tailOff = tailOff + (int)gVoxEvents;   /* MATCH (c): mutate the OFFSET, not the base */
                *(short *)(tailOff + 8) = 1;
            }
        }
    }
    return 0;
}

/* iSPCH_ChooseEvent @0x800E7300 : pick the best pending event slot (highest priority, then lowest age, then
 *   lowest subtick), disabling any expired/filtered slots along the way.  Returns the slot index, or -1. */
/* 🔄 2026-07-27 FROM-SCRATCH REWRITE (user directive: "rewrite it like a human wrote it") --
 * 26 -> 14 diffs @120/120, replacing the whole device stack the function had accumulated
 * (the on-stack `L` aggregate, (int)(unsigned int) cast chains, the dead-`tick` reuse copy,
 * the do{}while(0) store wrapper, the goto funnel).  What the honest form proved:
 *   - now/bestPri/bestSub spill to sp+0x10/0x14/0x18 NATURALLY -- the loop's own locals
 *     (winner, bestAge, i, cursor, event, age, expired, filtered, the filter pri temp)
 *     consume all nine callee-saved registers, so the allocator stack-homes the three
 *     lowest-priority values exactly as retail did.  The L-struct was never needed.
 *   - the $a1 stack reloads (now/bestPri/bestSub) fall out for free -- the "reload-scratch
 *     identity floor" filed after the heavy trace was an ARTIFACT of the hacked body.
 *   - the winner arms' SLOT recompute is just `((VoxSlot *)(gVoxEventQueue + winner*0x3c))
 *     ->subTick` -- the cast keeps +0xa as the lhu displacement, and the byte-math form
 *     gives retail's ((x<<4)-x)<<2 multiply (a typed gVoxQueue[winner] indexes with the
 *     64-4 decomposition instead).
 *   - `& 0xff` on the flag helper and the named `maxAge` block-local (double-read -> the
 *     cse copy) are the remaining EA-source fingerprints, both natural.
 * ✅ PASS 120/120 (2026-07-27): the last 14 (two la-pseudo letter pairs) fell when the
 * teardown's live-count decrement was written through the QUEUE view's own slot 0 --
 * `gVoxQueue[0]._ovl0--` -- i.e. exactly what the storage overlay IS.  With the arm's la
 * referencing the same symbol_ref family as the loop cursor, the allocator reproduces
 * retail's {a1,v1} prologue pair and a1 teardown la.  EA's source evidently decremented
 * the count through the queue record, not a separate counter symbol.  (One-symbol-only
 * variant is still WRONG: 26 -- the gVoxEvents/gVoxEventQueue two-view split for
 * cursor-vs-bestSub stays load-bearing.  u16 maxAge: 65.  Init reorder: 24.) */
extern int iSPCH_ChooseEvent(void)
{
    int          winner = -1;
    unsigned int now;
    int          bestPri;
    unsigned short bestSub;
    unsigned int bestAge;
    int          i;

    now     = gettick() + gPreLoadTicks;
    bestAge = winner;
    bestPri = 0;
    bestSub = 0;
    for (i = 0; i < 16; i++) {
        VoxSlot *slot = &gVoxQueue[i];
        if (slot->enabled != 0) {
            int          event   = slot->event;
            unsigned int age     = now - slot->tick;
            int          expired = 0;
            int          filtered = 0;
            if (*(unsigned short *)(event + 2) != 0) {
                unsigned int maxAge = *(unsigned short *)(event + 2);
                expired = maxAge < age;
            }
            if (gFilterSetting[0] == 1) {
                if ((VoxEvent_GetFilterLengthFlag(event) & 0xff) != 0) {
                    if (*(unsigned short *)(event + 4) < GetFilterPriority())
                        filtered = 1;
                }
            }
            if (expired || filtered) {
                slot->enabled = 0;
                gVoxQueue[0]._ovl0 = gVoxQueue[0]._ovl0 - 1;
            } else if (bestPri < *(unsigned short *)(event + 4)) {
                winner  = i;
                bestSub = ((VoxSlot *)(gVoxEventQueue + winner * 0x3c))->subTick;
                bestAge = age;
                bestPri = *(unsigned short *)(event + 4);
            } else if (*(unsigned short *)(event + 4) == bestPri) {
                if (age < bestAge ||
                    (age == bestAge && bestSub < slot->subTick)) {
                    winner  = i;
                    bestAge = age;
                    bestSub = ((VoxSlot *)(gVoxEventQueue + winner * 0x3c))->subTick;
                }
            }
        }
    }
    return winner;
}

/* SPCH_ClearEventQueue @0x800E74E0 : disable every active slot. */
extern void SPCH_ClearEventQueue(void)
{
    /* MATCH: indexing by i before strength reduction keeps the walking pointer at the slot base. */
    int            i = 0;
    do {
        unsigned char *slot = (unsigned char *)gVoxEvents + i * 0x3c;
        if (*(unsigned short *)(slot + 8) != 0) {
            *(short *)(slot + 8) = 0;
            gVoxEvents[0] = gVoxEvents[0] - 1;
        }
        i = i + 1;
    } while (i < 0x10);
}

/* iSPCH_ClearOldEvents @0x800E7528 : disable slots older than the winner (unless keep-till-expires); note a
 *   surviving 'd'-tagged event in DAT_80148064.  Returns 0. */
extern void iSPCH_ClearOldEvents(int winnerSlot)
{
    /* MATCH: the inlined identity above moves the base copy into the oracle's early schedule. */
    unsigned char *win     = (unsigned char *)iSPCH_EventBase(gVoxEvents) + winnerSlot * 0x3c;
    unsigned int   winTick = (unsigned int)*(int *)(win + 0xc);
    unsigned int   winSub  = (unsigned int)*(unsigned short *)(win + 0xa);
    unsigned char *base    = (unsigned char *)gVoxEvents;
    int            i       = 0;
    *(int *)(base + 4) = 0;   /* DAT_80148064: stored via base+4 (oracle sw 0,4(s4)) */
    do {
        unsigned char *slot = base + i * 0x3c;
        if (i == winnerSlot)
            goto cont;
        if (*(unsigned short *)(slot + 8) == 0)
            goto cont;
        {
            unsigned int tick = (unsigned int)*(int *)(slot + 0xc);
            unsigned int sub  = (unsigned int)*(unsigned short *)(slot + 0xa);
            if (tick < winTick)
                goto disable;
            if (tick != winTick)
                goto dcheck;
            if (sub >= winSub)
                goto dcheck;
          disable:
            if ((VoxEvent_GetKeepTillExpiresFlag(*(int *)(slot + 0x10)) & 0xff) != 0)
                goto cont;
            *(short *)(slot + 8) = 0;
            gVoxEvents[0] = gVoxEvents[0] - 1;
            goto cont;
          dcheck:
            if (*(signed char *)(*(int *)(slot + 0x10) + 9) == 'd')
                *(int *)(base + 4) = 1;
        }
      cont:
        i = i + 1;
    } while (i < 0x10);
}

/* SPCH_PlaySpeech @0x800E7644 : if nothing chosen, choose; then play the chosen speech. */
extern void SPCH_PlaySpeech(void)
{
    if (iSPCH_OneChosen() != 0) {
        iSPCH_PlayChosen();
        return;
    }
    if (SPCH_ChooseSpeech() != 0)
        iSPCH_PlayChosen();
}

/* SPCH_ChooseSpeech @0x800E7684 : pick the winning event, clear the events it supersedes, and hand its
 *   eventArgs to the sentence picker.  If no sentence is chosen and a gReparm hook is installed, retry
 *   per index until one is chosen or the hook gives up.  Returns the chosen-sentence count. */
extern int SPCH_ChooseSpeech(void)
{
    int result = 0;
    if (gVoxEvents[0] != 0) {
        int winner = iSPCH_ChooseEvent();
        if (-1 < winner) {
            unsigned int *eventArgs;
            iSPCH_ClearOldEvents(winner);
            eventArgs = (unsigned int *)(SLOT(winner) + 0x14);
            result = iSPCH_ChooseSentence(eventArgs);
            if (result == 0) {
                if (gReparm[0] != 0) {
                    int i = 0;
                    int rc;
                    do {
                        rc = ((int (*)(int, unsigned int *))gReparm[0])(i, eventArgs);
                        if (-1 < rc)
                            result = iSPCH_ChooseSentence(eventArgs);
                        i = i + 1;
                        if (result != 0)
                            break;
                    } while (0 < rc);
                }
            }
            if (result < 0)
                result = 0;
            {
                unsigned char *g = (unsigned char *)gVoxEvents;
                ((int *)g)[0] = ((int *)g)[0] - 1;
                *(short *)(g + winner * 0x3c + 8) = 0;
            }
        }
    }
    return result;
}
