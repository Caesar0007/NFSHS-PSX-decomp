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
 * W82-root: the source-only resolution is the whole-object compiler input
 * `-fforce-addr`.  It emits SPCH_AddEvent's retail address copy; moving
 * iSPCH_InitEventQueue's existing address-use fence to the real copy boundary
 * preserves its retail v0->a3->a0 chain.  Strict whole-TU gate: 16/16 PASS.
 */
/* eaclib/psx/spchpsxz/spchevnt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 16/16 PASS ***
 *   Indexed queue walks now match SPCH_ClearEventQueue exactly and cut iSPCH_InitEventQueue from 42 to
 *   17 diffs; reconstructing gReparm as one-word callback storage made SPCH_ChooseSpeech PASS.
 *   w49-a9: iSPCH_InitEventQueue 12 -> PASS and SPCH_AddEvent 16 -> 3 (opacity/use fences, see notes).
 *   w82-root: whole-TU -fforce-addr plus the queue copy-boundary fix seals the remaining 3.
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
/* W65-A6 run @0x80148048, now PLAIN C DEFINITIONS (2026-08-31): with this TU at
   -G0 nothing is small-data, so tentative defs stay GLOBAL .bss in declaration
   order -- the same section, order and adjacency the retired __asm__ block
   spelled by hand (nm-verified).  gRepeatCount had no symbol references anywhere
   (every consumer spells it gVoxInGame[1]); it is retail's name for that word. */
/* ⚠️ KNOWN 2-DIFF (2026-08-31, accepted by user call): iSPCH_ChooseEvent, count
   EXACT 120/120.  The -G0 flag itself (not the decl conversion) flips the ORDER
   of the two preheader luis -- retail births %hi(gVoxEvents) BEFORE the
   gPreLoadTicks hi/lw pair, ours after.  A sched1 tie re-broken by the -G
   flag's SYMBOL_REF path; the -G4 build tied it retail's way.  NOT source-
   reachable -- falsified, all exactly 2: split `now = gettick(); now += ...`,
   every init-order permutation, an explicit `VoxSlot *q = gVoxQueue;` born
   between the call and the preload add OR after the inits.  Candidate cure =
   a one-way sched fence of the SPCH_Init &&label family at the preheader. */

#include "../eaclib_types.h"

int gPreLoadTicks;        /* @0x80148044 */
int gEventDats[4];        /* @0x80148048 bound event-data blob table */
int gVoxInGame[2];        /* @0x80148058; [1] is retail's gRepeatCount @0x8014805C */
#define VOX_NSLOTS 16
/* EA's TRUE record (2026-09-03, user model): the queue header is the run's first 8 bytes and
 * the 16 records start at run+8, stride 0x3c -- args[12] fills a record EXACTLY (2+2+4+4+48),
 * no cross-slot overlay games.  MEASURED: with INDEXED addressing this honest spelling is
 * codegen-identical to the old -8-shifted window (cc1 anchors the giv base at run+0 and folds
 * the +8 into the field displacements). */
typedef struct {
    unsigned short enabled;      /* +0x0 (run-relative +0x8)  */
    unsigned short subTick;      /* +0x2 (+0xa)  */
    int            tick;         /* +0x4 (+0xc)  insert tick */
    int            event;        /* +0x8 (+0x10) VoxEvent ptr */
    int            args[12];     /* +0xc..0x3b (+0x14..+0x43) */
} VoxSlot;                       /* 0x3c */
typedef struct {
    int     liveCount;           /* +0x0 number of enabled slots (AddEvent ++, FindEventSlot/
                                  * ClearEventQueue/ClearOldEvents/ChooseEvent/ChooseSpeech --,
                                  * gated `< 16` / `!= 0`) */
    int     dFlag;               /* +0x4 "a 'd'-tagged event survived" flag (set by
                                  * ClearOldEvents, read by spchpick's filter bump;
                                  * retail's DAT_80148064) */
    VoxSlot slots[VOX_NSLOTS];   /* +0x8 the 16 records */
} VoxSlotsStruct;                /* 8 + 16*0x3c = 968 */
VoxSlotsStruct gVoxEvents;    /* @0x80148060, 968 bytes (the whole retail run is this ONE
                               * struct; the old `int words[242]` union view retired 2026-09-03
                               * -- nothing referenced it after the liveCount/dFlag migration) */
extern VoxSlotsStruct gVoxQueue __asm__("gVoxEvents");
/* VIEW RAZOR (re-measured 2026-08-31 in the -G0/in-TU-definition basin): the
   winner arms and the slot cursor must reach the queue through DIFFERENT
   declarations, or cse merges their base pseudos and the cursor's weighted
   refs cross the floor_log2 razor (iSPCH_ChooseEvent 2 -> 26, the s2/s3 swap).
   TWO declarations suffice -- the definition itself (gVoxEvents, used by the
   winner arms below via a byte cast) plus the ONE typed view gVoxQueue for the
   cursor/count.  The former SECOND view (`unsigned char gVoxEventQueue[]
   __asm__("gVoxEvents")`) is retired: arms straight off gVoxEvents measure
   IDENTICALLY (2), and every all-one-decl form measures 26. */
extern int            gLastTick;      /* last insert tick (spchinit-owned) */
extern unsigned short gLastSubTick;   /* sub-tick counter (spchinit owns it as int; low half) */
extern int            gFilterSetting; /* active filter mode (1 = length/priority filter on) */

extern int  gettick(void);                                  /* eaclib timer.obj */
extern int  iSPCH_Rand(int n);                              /* spchrand */
extern int  iSPCH_OneChosen(void);                          /* spchpick */
extern void iSPCH_PlayChosen(void);                         /* spchpick */
extern int  iSPCH_ChooseSentence(unsigned int *eventArgs);  /* spchpick (returns chosen-count) */

/* gReparm @0x801370A0 : optional "re-parameterize" hook -- if set, retried per index until a sentence
 *   is chosen or the hook returns <=0.  Signature from SPCH_ChooseSpeech's jalr call site. */
extern int gReparm;    /* one-word callback storage; cast to its callable signature at use */

/* ---- per-TU static copies of shared helpers (canon in spchdata.obj) ---- */
static int VoxEvent_GetFilterLengthFlag(int e)   /* @0x800E6E88 */
{
    return (int)*(unsigned char *)(e + 0xa) & 1;
}

/* VoxEvent_GetKeepTillExpiresFlag @0x800E6E94 : bit 2 of the event flags byte (+0xa). */
extern unsigned int VoxEvent_GetKeepTillExpiresFlag(int e)
{
    return (unsigned int)*(unsigned char *)(e + 10) >> 2 & 1;
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

#define SLOT(i)  ((unsigned char *)&gVoxEvents + (i) * 0x3c)

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
    /* ✅ SEALED SOURCE-ONLY (2026-09-03, user's hand-written form): PASS 29/29 with ZERO
     * devices -- no -fforce-addr, no asm fences, no absorption identities, no label+goto.
     * THE LEVER IS INDEXED ADDRESSING: `gVoxEvents.slots[i].field` / `.args[j]` make loop.c
     * strength-reduce the addresses into ITS OWN giv pseudos, and the giv preheader
     * initializations ARE retail's two address copies (`addu a3,v0,zero` / `addu a0,a3,zero`)
     * -- the copies no pointer-cursor spelling could keep alive (REG_EQUIV rewrote single-set
     * address copies, combine folded every absorption chain; ~25 falsified forms + the whole
     * w32..w47 floor saga, see git history of this comment).  The indexed inner loop also stays
     * FORWARD (its giv hangs off the outer walk, blocking check_dbra_loop's reversal that
     * turned every cursor spelling into a down-counter `addiu -4`).
     * 2026-09-03 HONEST-MODEL MIGRATION (user's design): VoxSlot is now EA's true +8-based
     * record (args[12], no _ovl fields) inside VoxSlotsStruct {header; slots[16]} -- so this
     * clear has NO overlay games at all and the run is zeroed exactly (968 bytes).
     * ⚠️ PITFALL BANKED: a NAMED per-iteration pointer (`VoxSlot *s = &gVoxEvents.slots[i]`)
     * pins run+8 into a register and re-encodes every field store (displacements 0/2/4/8 vs
     * retail 8/10/12/16 -- measured 24 diffs in ChooseEvent); DIRECT indexed field access
     * lets the giv fold the +8 into displacements and byte-matches.
     * NEXT: SPCH_AddEvent still rides PER_FN_FORCE_ADDR for the SAME missing-copy class
     * (3 diffs without the splice) -- try this same indexed lever there. */
    int i;
    
    gVoxEvents.liveCount = 0;
    gVoxEvents.dFlag = 0;

    for(i = 0; i < VOX_NSLOTS; i++) {
        int j;
        
        gVoxEvents.slots[i].enabled = 0;
        gVoxEvents.slots[i].subTick = 0;
        gVoxEvents.slots[i].tick    = 0;
        gVoxEvents.slots[i].event   = 0;

        for (j = 0; j < 12; j++)
            gVoxEvents.slots[i].args[j] = 0;
    }

    gLastTick    = 0;
    gLastSubTick = 0;
}

/* iSPCH_FindEventSlot @0x800E7088 : pick a slot for a new event of `priority` -- first a free slot, else the
 *   first expired slot, else evict the first slot with priority <= `priority`.  Returns the index, or -1. */
extern int iSPCH_FindEventSlot(unsigned int priority)
{
    int result = -1;
    int i;
    if (gVoxEvents.liveCount < 0x10) {
        i = 0;
        do {
            unsigned char *slot = SLOT(i);
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
            unsigned char *slot     = SLOT(i);
            int            voxEvent = *(int *)(slot + 0x10);
            unsigned short maxAge   = *(unsigned short *)(voxEvent + 2);
            if (maxAge != 0 &&
                maxAge < (unsigned int)(tick - *(int *)(slot + 0xc))) {
                *(short *)(slot + 8) = 0;
                result = i;
                gVoxEvents.liveCount = gVoxEvents.liveCount - 1;
                goto done;
            }
            i  = i + 1;
        } while (i < 0x10);
    }
    i = 0;
    do {
        unsigned char *slot       = SLOT(i);
        int            voxEvent   = *(int *)(slot + 0x10);
        unsigned int   evPriority = (unsigned int)*(unsigned short *)(voxEvent + 4);
        if (priority >= evPriority) {
            *(short *)(slot + 8) = 0;
            result = i;
            gVoxEvents.liveCount = gVoxEvents.liveCount - 1;
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
 *     anonymous `(int)&gVoxEvents` re-eval in the pre-loop stores = 28;
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
                 *      assignment below `gLastTick = tick;` puts it in retail's slot (-5 diffs).
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
                 *   - `(int)&gVoxEvents.words[0]` and a pointer-typed `unsigned char *bp` intermediate = 3.
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
                if (tick == gLastTick)
                    gLastSubTick = gLastSubTick + 1;
                else
                    gLastSubTick = 0;
                j    = 0;
                baseTmp = (int)&gVoxEvents;
                base = baseTmp;
                __asm__("" : : "r"(baseTmp));
                p    = table;
                offTmp = slot * 0x3c;
                __asm__("" : "=r"(offTmp) : "0"(offTmp));
                off  = offTmp;
                gLastTick = tick;
                sub  = (short)gLastSubTick;
                *(int *)(off + base + 0x10)  = voxEvent;
                *(int *)(off + base + 0xc)   = tick;
                *(short *)(off + base + 0xa) = sub;
                do {
                    *(unsigned int *)(off + base + 0x14) = *p;
                    p   = p + 1;
                    off = off + 4;
                    j   = j + 1;
                } while (j < 0xc);
                gVoxEvents.liveCount = gVoxEvents.liveCount + 1;
                tailOff = slot * 0x3c;
                tailOff = tailOff + (int)&gVoxEvents;   /* MATCH (c): mutate the OFFSET, not the base */
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
/* 2026-09-03 honest-model migration: the per-iteration cursor `VoxSlot *slot = &...slots[i]`
 * had to become DIRECT indexed accesses (`gVoxEvents.slots[i].field`) -- the named pointer
 * pinned run+8 as the base register and re-encoded all displacements (24 diffs); the indexed
 * form folds +8 into the displacements and lands back on the accepted 2.  The view razor is
 * unchanged in substance: loop side reads via gVoxEvents (union), winner arms via the
 * gVoxQueue view (second name for the same storage). */
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
        if (gVoxEvents.slots[i].enabled != 0) {
            int          event   = gVoxEvents.slots[i].event;
            unsigned int age     = now - gVoxEvents.slots[i].tick;
            int          expired = 0;
            int          filtered = 0;
            if (*(unsigned short *)(event + 2) != 0) {
                unsigned int maxAge = *(unsigned short *)(event + 2);
                expired = maxAge < age;
            }
            if (gFilterSetting == 1) {
                if ((VoxEvent_GetFilterLengthFlag(event) & 0xff) != 0) {
                    if (*(unsigned short *)(event + 4) < GetFilterPriority())
                        filtered = 1;
                }
            }
            if (expired || filtered) {
                gVoxEvents.slots[i].enabled = 0;
                gVoxEvents.liveCount = gVoxEvents.liveCount - 1;
            } else if (bestPri < *(unsigned short *)(event + 4)) {
                winner  = i;
                bestSub = gVoxQueue.slots[winner].subTick;
                bestAge = age;
                bestPri = *(unsigned short *)(event + 4);
            } else if (*(unsigned short *)(event + 4) == bestPri) {
                if (age < bestAge ||
                    (age == bestAge && bestSub < gVoxEvents.slots[i].subTick)) {
                    winner  = i;
                    bestAge = age;
                    bestSub = gVoxQueue.slots[winner].subTick;
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
        unsigned char *slot = (unsigned char *)&gVoxEvents + i * 0x3c;
        if (*(unsigned short *)(slot + 8) != 0) {
            *(short *)(slot + 8) = 0;
            gVoxEvents.liveCount = gVoxEvents.liveCount - 1;
        }
        i = i + 1;
    } while (i < 0x10);
}

/* iSPCH_ClearOldEvents @0x800E7528 : disable slots older than the winner (unless keep-till-expires); note a
 *   surviving 'd'-tagged event in DAT_80148064.  Returns 0. */
extern void iSPCH_ClearOldEvents(int winnerSlot)
{
    /* MATCH: the inlined identity above moves the base copy into the oracle's early schedule. */
    unsigned char *win     = (unsigned char *)iSPCH_EventBase(&gVoxEvents.liveCount) + winnerSlot * 0x3c;
    unsigned int   winTick = (unsigned int)*(int *)(win + 0xc);
    unsigned int   winSub  = (unsigned int)*(unsigned short *)(win + 0xa);
    unsigned char *base    = (unsigned char *)&gVoxEvents;
    int            i       = 0;
    gVoxEvents.dFlag = 0;
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
            gVoxEvents.liveCount = gVoxEvents.liveCount - 1;
            goto cont;
          dcheck:
            if (*(signed char *)(*(int *)(slot + 0x10) + 9) == 'd')
                ((VoxSlotsStruct *)base)->dFlag = 1;
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
    if (gVoxEvents.liveCount != 0) {
        int winner = iSPCH_ChooseEvent();
        if (-1 < winner) {
            unsigned int *eventArgs;
            iSPCH_ClearOldEvents(winner);
            eventArgs = (unsigned int *)(SLOT(winner) + 0x14);
            result = iSPCH_ChooseSentence(eventArgs);
            if (result == 0) {
                if (gReparm != 0) {
                    int i = 0;
                    int rc;
                    do {
                        rc = ((int (*)(int, unsigned int *))gReparm)(i, eventArgs);
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
            gVoxEvents.liveCount = gVoxEvents.liveCount - 1;
            gVoxEvents.slots[winner].enabled = 0;
        }
    }
    return result;
}
