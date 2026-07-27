/* eaclib/psx/spchpsxz/spchevnt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 13/16 PASS ***
 *   Indexed queue walks now match SPCH_ClearEventQueue exactly and cut iSPCH_InitEventQueue from 42 to
 *   17 diffs; reconstructing gReparm as one-word callback storage made SPCH_ChooseSpeech PASS.
 *   Remaining FAILs are iSPCH_InitEventQueue(17), SPCH_AddEvent(18), and iSPCH_ChooseEvent(58).
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
     * to one symbol restores the single `lui` but costs the whole register assignment (31 diffs). */
    int argBase = 0;
    int base = (int)gVoxEvents;
    int slot = (int)gVoxEventQueue;
    int end  = base + 0x3c0;
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
 * is correct, not void. */
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
                if (tick == gLastTick[0])
                    gLastSubTick[0] = gLastSubTick[0] + 1;
                else
                    gLastSubTick[0] = 0;
                sub  = (short)gLastSubTick[0];
                j    = 0;
                base = (int)gVoxEvents;
                p    = table;
                off  = slot * 0x3c;
                gLastTick[0] = tick;
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
                *(short *)((unsigned char *)gVoxEvents + slot * 0x3c + 8) = 1;
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
 * RESIDUAL 14 = two la-pseudo letter pairs (prologue gVoxEvents-HI/gPreLoadTicks = ours
 * {v1,a0} vs retail {a1,v1}; teardown count-la v1-vs-a1) -- the true caller-saved tie-break
 * remainder.  Probed neutral/worse: init order (24), split now accumulation (14). */
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
                gVoxEvents[0] = gVoxEvents[0] - 1;
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
