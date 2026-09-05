/* GCC-LADDER (W52-A8 2026-08-09): SPCHPSXZ identity = gcc-2.8.0 + maspsx, the default lane.
 * SPCH_AddEvent ladder -- default/2.8.0/2.8.1 all 3 (81/82); 970404 11; 2.7.2 and 2.6.x 29;
 * 2.91.66 80; 2.95.2 57.  The residual that table was measured against is now GONE (source
 * fix, see the fn's seal note), so the reading stands only as the version-axis receipt.
 */
/* eaclib/psx/spchpsxz/spchevnt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 16/16 PASS ***
 *   Indexed queue walks now match SPCH_ClearEventQueue exactly and cut iSPCH_InitEventQueue from 42 to
 *   17 diffs; reconstructing gReparm as one-word callback storage made SPCH_ChooseSpeech PASS.
 *   2026-09-03/04: InitEventQueue, AddEvent and ChooseEvent all sealed SOURCE-ONLY (indexed
 *   addressing + arm statement order); every asm view, fence and force_addr flag is retired.
 *   Source obj : nfs4\eaclib\psx\spchevnt.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   16 fns @[0x800E6E88 .. 0x800E7684].  The speech EVENT QUEUE -- 16 slots (gVoxEvents, base 0x80148060,
 *   stride 0x3c) selected by priority/age/subtick; events are looked up in the bound gEventDats[] blobs.
 *   Ghidra nfs4-f.exe.c (spchevnt) + disasm-v3 (authoritative) + IDA sigs.
 *
 *   The queue is one object (spch_types.h): VoxSlotsStruct {liveCount; dFlag; VoxSlot slots[16]},
 *   each 0x3c-byte record {enabled; subTick; tick; event; args[12]}.  2026-09-04: every walk in
 *   this TU is a plain `gVoxEvents.slots[i].field` -- the SLOT() byte macro, the byte cursors and
 *   the iSPCH_EventBase identity helper they needed are all retired, byte-neutrally.
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
 *   gEventDats    @0x80148048  16   (VoxEventDat *[4] bound event-data blobs)
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
/* ⚠️ ORDER CAVEAT (measured 2026-09-04, nm/objdump): these plain C tentative definitions land
   in .bss correctly, but their ORDER inside the object is chosen by maspsx, not by the source --
   this run comes out {gVoxEvents, gPreLoadTicks, gEventDats, gVoxInGame} instead of retail's
   {gPreLoadTicks, gEventDats, gVoxInGame, gVoxEvents}.  Sizes and section are right, the run's
   internal layout is not.  Falsified cures: `-fno-common` restores declaration order but moves
   the storage to .data (file bytes; these VAs are pure zero-init BSS) and
   `__attribute__((section(".bss")))` is inert on this cc1.  The only spelling that gives BOTH
   is the file-scope asm .bss block this TU used to carry (spchpick.c still does).  Harmless for
   the match lane and for today's src/-linked ROM; it matters whenever recon objects own the
   storage at link (first-light).  DECISION PENDING -- do not re-assert "nm-verified order". */
/* W65-A6 run @0x80148048, now PLAIN C DEFINITIONS (2026-08-31): with this TU at
   -G0 nothing is small-data, so tentative defs stay GLOBAL .bss in declaration
   order -- the same section, order and adjacency the retired __asm__ block
   spelled by hand (nm-verified).  gRepeatCount had no symbol references anywhere
   (every consumer spells it gVoxInGame[1]); it is retail's name for that word. */
/* ✅ 2026-09-04: the last residual of this TU is GONE -- iSPCH_ChooseEvent PASSes 120/120
   from a SINGLE symbol, so the whole file (and the whole library) is byte-exact with no
   asm views, no fences and no per-TU/per-fn flag exceptions.  The former "accepted 2-diff"
   (a preheader lui order attributed to -G0) turned out to be an artifact of the two-view
   spelling: with one symbol the function is a pure $s2<->$s3 allocno swap, cured in source
   by the `bestAge = age` statement order in the winner arm (see the note there). */

#include "../eaclib_types.h"
#include "spch_types.h"
#include "spchinit.h"
#include "spchevnt.h"
#include "spchrand.h"
#include "spchpick.h"

/* W65-A6 DATA-MAT run @0x80148044 -- file-scope asm .bss definition, RESTORED 2026-09-04.
 * ⚠️ LOAD-BEARING FOR DATA LAYOUT (measured, objdump/nm): it is the only spelling that gives
 * BOTH the right section and retail's ORDER.  Plain C tentative definitions land in .bss but
 * maspsx re-orders the run (gVoxEvents jumps to the front); `-fno-common` keeps declaration
 * order but moves the storage to .data (file bytes -- these VAs are pure zero-init BSS);
 * `__attribute__((section(".bss")))` is inert on this cc1.  It also carries the two INTERIOR
 * labels retail has and C cannot express: gRepeatCount (= gVoxInGame[1]) and DAT_80148064
 * (= gVoxEvents.dFlag).  Byte-neutral for code: the C views below stay `extern` (spchevnt.h),
 * so every function keeps its match. */
__asm__("\t.globl\tgPreLoadTicks\n\t.globl\tgEventDats\n\t.globl\tgVoxInGame\n"
        "\t.globl\tgRepeatCount\n\t.globl\tgVoxEvents\n\t.globl\tDAT_80148064\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "gPreLoadTicks:\n\t.space\t4\n"
        "gEventDats:\n\t.space\t16\n"
        "gVoxInGame:\n\t.space\t4\n"
        "gRepeatCount:\n\t.space\t4\n"
        "gVoxEvents:\n\t.space\t4\n"
        "DAT_80148064:\n\t.space\t964\n\t.text");


/* gVoxEvents itself is declared `extern VoxSlotsStruct` in spchevnt.h -- the storage is the
 * asm block above; the struct is the honest C view of the run (header + 16 records). */
/* VIEW RAZOR -- RETIRED 2026-09-04.  Two asm-label views of this storage
   (gVoxEventQueue, then gVoxQueue) existed only to keep iSPCH_ChooseEvent's winner arms
   from being CSE-merged onto the loop cursor.  What that merge actually costs is ONE
   allocno step (cursor 16 refs/66 vs age 12 refs/38), and it is now paid in source by the
   arm's statement order -- so one symbol suffices and the views are gone. */
/* ⚠️ NOT shared via spchinit.h on purpose: spchinit DEFINES this word as `int`, but this TU
 * reads/writes only its low half -- the `unsigned short` view is what emits retail's lhu/sh.
 * Unifying the two spellings would change the access width, so the divergence is load-bearing. */
extern unsigned short gLastSubTick;   /* @0x80148430 sub-tick counter (spchinit owns the storage) */

extern int  gettick(void);                                  /* eaclib timer.obj */

/* gReparm @0x801370A0 : optional "re-parameterize" hook -- if set, retried per index until a sentence
 *   is chosen or the hook returns <=0.  Signature from SPCH_ChooseSpeech's jalr call site. */

/* ---- per-TU static copies of shared helpers (canon in spchdata.obj) ---- */
static int VoxEvent_GetFilterLengthFlag(VoxEvent *e)   /* @0x800E6E88 */
{
    return e->flags & 1;
}

/* VoxEvent_GetKeepTillExpiresFlag @0x800E6E94 : bit 2 of the event flags byte (+0xa). */
unsigned int VoxEvent_GetKeepTillExpiresFlag(VoxEvent *e)
{
    return (unsigned int)e->flags >> 2 & 1;
}

static int iSPCH_GetOffset16(int base, int tableBase, int index)  /* @0x800E6EA8 */
{
    return base + ((int)*(unsigned short *)(tableBase + index * 2) << 2);
}

/* iSPCH_SearchEventDat @0x800E6EC4 : address of the entry in blob `dat` whose id == eventID, or 0. */
VoxEvent *iSPCH_SearchEventDat(VoxEventDat *dat, unsigned int eventID)
{
    unsigned int count = dat->numEvents;
    int table;

    for (table = 0; table < (int)count; table++) {
        VoxEvent *p = (VoxEvent *)iSPCH_GetOffset16((int)dat, (int)dat->eventOffs, table);

        if (p->id == eventID)
            return p;
    }
    return 0;
}

/* iSPCH_FindEvent @0x800E6F4C : search all 4 bound blobs for eventID; returns its entry ptr, or 0. */
VoxEvent *iSPCH_FindEvent(unsigned int eventID)
{
    int i;

    for (i = 0; i < 4; i++) {
        if (gEventDats[i] != 0) {
            VoxEvent *result = iSPCH_SearchEventDat(gEventDats[i], eventID);

            if (result != 0)
                return result;
        }
    }
    return 0;
}

/* iSPCH_InitEventDat @0x800E6FBC : clear the 4 bound event-data blob pointers. */
void iSPCH_InitEventDat(void)
{
    int i;

    for(i = 0; i < 4; i++) {
        gEventDats[i] = 0;
    }
}

/* GetFilterLength @0x800E6FE4 : the filter-length config word from the first bound blob (+4). */
int GetFilterLength(void)
{
    return gEventDats[0]->filterLength;
}

/* GetFilterPriority @0x800E6FFC : the filter-priority config word from the first bound blob (+8). */
int GetFilterPriority(void)
{
    return gEventDats[0]->filterPriority;
}

/* iSPCH_InitEventQueue @0x800E7014 : zero all 16 queue slots (header + 12 eventArgs each) and the ticks. */
void iSPCH_InitEventQueue(void)
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
int iSPCH_FindEventSlot(unsigned int priority)
{
    int result = -1;
    int i;

    /* MATCH: the three loops leave through ONE shared exit (`goto done` + `result`), not three
     * textual `return i;` -- gcc cross-jumps the identical tails only AFTER register allocation,
     * so the direct-return spelling changes REG_N_REFS(result) and re-colors the whole function
     * (measured: 85 diffs at 71 insns, five short of retail's 76).  Same shared-exit law as
     * spchpick's iSPCH_ChooseSentence. */
    if (gVoxEvents.liveCount < VOX_NSLOTS) {
        for (i = 0; i < VOX_NSLOTS; i++) {
            if (gVoxEvents.slots[i].enabled == 0) {
                result = i;
                goto done;
            }
        }
    }
    {
        int tick = gettick();

        for (i = 0; i < VOX_NSLOTS; i++) {
            unsigned short maxAge = gVoxEvents.slots[i].event->maxAge;

            if (maxAge != 0 &&
                maxAge < (unsigned int)(tick - gVoxEvents.slots[i].tick)) {
                gVoxEvents.slots[i].enabled = 0;
                gVoxEvents.liveCount--;
                result = i;
                goto done;
            }
        }
    }
    for (i = 0; i < VOX_NSLOTS; i++) {
        if (priority >= gVoxEvents.slots[i].event->priority) {
            gVoxEvents.slots[i].enabled = 0;
            gVoxEvents.liveCount--;
            result = i;
            goto done;
        }
    }
  done:
    return result;
}

/* SPCH_AddEvent @0x800E71B8 : queue the event identified by table[0] (randomly accepted per its
 *   accept probability), copying table[0..11] into the chosen slot's eventArgs.  Returns 0.
 *   Sealed source-only 2026-09-04 -- see the note in the body. */
int SPCH_AddEvent(unsigned int *table)
{
    VoxEvent *voxEvent = iSPCH_FindEvent(*table);
    if (voxEvent != 0) {
        int acceptProb = voxEvent->acceptProb;
        if (iSPCH_Rand(100) <= acceptProb) {
            int slot = iSPCH_FindEventSlot(voxEvent->priority);
            if (slot > -1) {
                int   tick = gettick();
                unsigned short sub;
                int   j;
                /* ✅ SEALED SOURCE-ONLY (2026-09-04): PASS 82/82 by the INDEXED-ADDRESSING
                 * lever (third confirmation after InitEventQueue and BankMemAlloc).  The
                 * `gVoxEvents.slots[slot].field` spellings make cc1's own giv machinery
                 * materialize retail's preheader copies (`addu t0,v0,zero` base copy -- the
                 * w53-a11 missing-address-copy that no C spelling could keep alive -- and the
                 * `addu a1,v0,zero` off copy), so the PER_FN_FORCE_ADDR splice, BOTH asm
                 * fences, and the whole base/off/tailOff device apparatus are retired at
                 * once.  Full w32..w53 floor archaeology: git history of this comment. */
                if (tick == gLastTick)
                    gLastSubTick++;
                else
                    gLastSubTick = 0;
                gLastTick = tick;
                sub = gLastSubTick;
                gVoxEvents.slots[slot].event   = voxEvent;
                gVoxEvents.slots[slot].tick    = tick;
                gVoxEvents.slots[slot].subTick = sub;
                for (j = 0; j < 12; j++)
                    gVoxEvents.slots[slot].args[j] = table[j];
                gVoxEvents.liveCount++;
                gVoxEvents.slots[slot].enabled = 1;
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
int iSPCH_ChooseEvent(void)
{
    int          winner;
    unsigned int now;
    int          bestPri;
    unsigned short bestSub;
    unsigned int bestAge;
    int          i;
	
    winner = -1;
    now     = gettick() + gPreLoadTicks;
    bestAge = winner;
    bestPri = 0;
    bestSub = 0;
	
    for (i = 0; i < VOX_NSLOTS; i++) {
        if (gVoxEvents.slots[i].enabled) {
            VoxEvent    *event;
            unsigned int age;
            int          expired;
            int          filtered;
            
            event = gVoxEvents.slots[i].event;
            age = now - gVoxEvents.slots[i].tick;
            expired = 0;
            filtered = 0;
            
            if (event->maxAge) {
                unsigned int maxAge = event->maxAge;
                expired = maxAge < age;
            }

            if (gFilterSetting == 1) {
                if ((VoxEvent_GetFilterLengthFlag(event) & 0xff) != 0) {
                    if (event->priority < GetFilterPriority())
                        filtered = 1;
                }
            }
            if (expired || filtered) {
                gVoxEvents.slots[i].enabled = 0;
                gVoxEvents.liveCount -= 1;
            } else if (bestPri < event->priority) {
                /* MATCH (2026-09-04): `bestAge = age` FIRST in this arm is load-bearing --
                 * it ends `age`'s live range one insn earlier (38 -> 37 insns at 12 refs),
                 * lifting its allocno priority 3*12/37 = 0.973 just past the slot cursor's
                 * 4*16/66 = 0.970 so the two land retail's way (age $s2, cursor $s3).  With
                 * the assignment in its "natural" last position the whole function is a pure
                 * $s2<->$s3 swap, 26 diffs at exact 120/120.  Same reordering in the second
                 * arm is NOT equivalent (2 diffs there, 2 with both). */
                bestAge = age;
                winner  = i;
                bestSub = gVoxEvents.slots[winner].subTick;
                bestPri = event->priority;
            } else if (event->priority == bestPri) {
                if (age < bestAge ||
                    (age == bestAge && bestSub < gVoxEvents.slots[i].subTick)) {
                    winner  = i;
                    bestAge = age;
                    bestSub = gVoxEvents.slots[winner].subTick;
                }
            }
        }
    }
    return winner;
}

/* SPCH_ClearEventQueue @0x800E74E0 : disable every active slot. */
void SPCH_ClearEventQueue(void)
{
    int i;
    for(i = 0; i < VOX_NSLOTS; i++) {
        if (gVoxEvents.slots[i].enabled != 0) {
            gVoxEvents.slots[i].enabled = 0;
            gVoxEvents.liveCount--;
        }
    }
}

/* iSPCH_ClearOldEvents @0x800E7528 : disable slots older than the winner (unless keep-till-expires); note a
 *   surviving 'd'-tagged event in DAT_80148064.  Returns 0. */
void iSPCH_ClearOldEvents(int winnerSlot)
{
    unsigned int   winTick = (unsigned int)gVoxEvents.slots[winnerSlot].tick;
    unsigned int   winSub  = (unsigned int)gVoxEvents.slots[winnerSlot].subTick;
    int            i;

    gVoxEvents.dFlag = 0;

    for (i = 0; i < VOX_NSLOTS; i++) {
        int tick;
        unsigned short sub;

        if (i == winnerSlot)
            continue;
        if (gVoxEvents.slots[i].enabled == 0)
            continue;

        tick = gVoxEvents.slots[i].tick;
        sub  = gVoxEvents.slots[i].subTick;
        /* MATCH: the "older than the winner" test must stay ONE expression -- hoisting it into
         * a named flag, or splitting it into two ifs, costs 3 insns (5 diffs @74/71). */
        if (tick < winTick || (tick == winTick && sub < winSub)) {
            if ((VoxEvent_GetKeepTillExpiresFlag(gVoxEvents.slots[i].event) & 0xff) == 0) {
                gVoxEvents.slots[i].enabled = 0;
                gVoxEvents.liveCount--;
            }
        } else if (gVoxEvents.slots[i].event->acceptProb == 'd') {
            gVoxEvents.dFlag = 1;
        }
    }
}

/* SPCH_PlaySpeech @0x800E7644 : if nothing chosen, choose; then play the chosen speech. */
void SPCH_PlaySpeech(void)
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
int SPCH_ChooseSpeech(void)
{
    int result = 0;
    if (gVoxEvents.liveCount != 0) {
        int winner = iSPCH_ChooseEvent();
        if (-1 < winner) {
            unsigned int *eventArgs;
            iSPCH_ClearOldEvents(winner);
            eventArgs = (unsigned int *)gVoxEvents.slots[winner].args;
            result = iSPCH_ChooseSentence(eventArgs);
            if (result == 0) {
                if (gReparm != 0) {
                    int i = 0;
                    int rc;
                    
                    do {
                        rc = ((int (*)(int, unsigned int *))gReparm)(i, eventArgs);
                        if (-1 < rc)
                            result = iSPCH_ChooseSentence(eventArgs);
                        i++;
                        if (result != 0)
                            break;
                    } while (0 < rc);
                }
            }
            if (result < 0)
                result = 0;
            gVoxEvents.liveCount--;
            gVoxEvents.slots[winner].enabled = 0;
        }
    }
    return result;
}
