/* game/common/aih_opp.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_opp_externs.h"

extern int          AI_elapsedTime;     /* H24: ai.cpp @0x8013C554 (not in this TU's externs) */
extern AIHigh_Base *highLevelAIObjs[];  /* H24: @0x8010CD38 (not in this TU's externs) */


/* ---- CheckForWipeOut__15AIHigh_Opponent  AIHigh_Opponent::CheckForWipeOut  [AIH_OPP.CPP:38-94] SLD-VERIFIED ---- */

void AIHigh_Opponent::CheckForWipeOut()



{
  int perTickProb;
  int new_var;    /* w59-a17: the 116 multiplier as a pre-loop local -- 68->51 (placement load-bearing: top-of-fn init = 77) */
  int randVal;
  int oppLevel;
  int oppFines;
  AICop_PerpChaseInfo *pInfo;   /* SYM: 2nd "this" (REG this PTR STRUCT AICop_PerpChaseInfo) --
                                    dumpsym names any locally-materialized base pointer "this";
                                    the oracle computes &this->perpChaseInfo_ ONCE (addiu v1,t0,0x8C)
                                    and derives BOTH copGameInfo_ and bestChaseLevelIndex_ off it. */
  int hLoop;
  Car_tObj*thisPlayerObj;
  AIHigh_Player*thisPlayer;
  int numRacers;   /* SYM-ABSENT loop-bound carrier -- NOT the SYM's playFines (see receipt) */

  bool bVar1;

  oppLevel = *(int *)((char *)this + 148);                    /* $t7, unconditional prologue load */
  oppFines = *(int *)((char *)this->carObj_ + 932);           /* $t6, unconditional prologue load (via carObj_ = $v1) */

  if ((Cars_gNumCopCars != 0) &&

     (simGlobal.gameTicks >=

      (this->carObj_)->wipeOutEndTick)) {

    bVar1 = false;

    if ((this->basicPerpInfo_.crime_ == 0) ||

       (this->basicPerpInfo_.copsAssigned_[0] +

        this->basicPerpInfo_.copsAssigned_[1] == 0)) {

      bVar1 = true;

    }

    if ((!bVar1) &&

       (0x27f < simGlobal.gameTicks -

                (this->carObj_)->wipeOutEndTick)) {

      /* ==== W63-A12 (51 -> 50, ours 118 / oracle 120).  THE LICM QUESTION IS ANSWERED AND
         THE WHOLE $t-BAND IS NOW RETAIL-EXACT; the residual is ONE named razor.
         (a) THE LOOP.C HOIST STOP IS *NOT* A BUDGET QUESTION.  -dL says the two 116*ae
             movables carry savings 4 / life 4; move_movables' test is
             threshold*savings*lifetime >= insn_count with threshold ~62 decaying 3 per
             move and insn_count = 49, so 4x4 can NEVER be declined.  Retail kept them
             in the loop because they were NOT MOVABLES AT ALL: loop.c only builds a
             movable for a reg with n_times_set == 1.  Writing the product into ONE
             NAMED LOCAL assigned in BOTH arms (`perTickProb = new_var * 4;`) makes the
             pseudo set twice -> no movable -> retail's in-loop `sll a0,t2,2` + the
             single cross-jumped `slt` return.  76 -> 64, count-exact.  (This retires the
             volatile-read device that the 51-diff basin used for the same job.)
         (b) THE BAND IS ALLOCSIM/REQDELTA WORK, NOT A SPELLING SEARCH.  allocsim MATCHes
             17/17 on this fn.  reqdelta priced retail's handout
             (this=$t0 randVal=$t1 29ae=$t2 numRacers=$t3 simGlobalBase=$t4
              highLevelAIObjs=$t5 oppFines=$t6 oppLevel=$t7) at THREE deltas:
               p137 (loop bound)  refs 3->4          [floor_log2 step over the sim-base copy]
               p82  (new_var)     live 41->54..60    [birth earlier]
               p147 (hlAIObjs)    live 100->=<97
             All three landed: the bound now goes through the SYM-declared `playFines`
             carrier + a ZERO-INSN read-only fence (+1 out-of-loop ref -- fencing the
             GLOBAL directly does NOT work, it mints a fresh load: +2 insns, refs
             unchanged), and `new_var` moved up.  Band = retail-exact, 64 -> 50.
         (c) THE LAST RAZOR, quantified.  p82 and p83 (randVal) die on the SAME insn, so
             live(p83) = live(p82) + gap where gap = luid distance between their defs
             (currently 12).  pri(p83) > pri(p82) needs 12L/(L+g) > 10L/L, i.e. L > 5g,
             i.e. live(p82) > 60 at g=12.  Only moving new_var's def ABOVE the pre-loop
             `wipeOutEndTick` store reaches that -- and THAT store is exactly what makes
             retail RE-LOAD AI_elapsedTime in the preheader (`lui v1;lw v1` @0x80063430,
             two loads in the oracle).  So the 50-diff basin buys the band by losing that
             reload (118 vs 120).  scratchpad/w63a12/aih_opp.cpp.wipe52 keeps the
             COUNT-EXACT 120/120 sibling (52 diffs) with new_var after the store and only
             the p82/p83 pair inverted -- structurally the truer base for the next pass.
             Closing that pair needs g <= 10 (two fewer insns between randVal's def and
             new_var's def) or a p83 refs/live dial that keeps it under p80's .1930;
             every fence/wrapper tried moves BOTH pseudos equally (they span the same
             region) and so cannot change their ORDER.  FALSIFIED this session: the
             single-store shared-RANDGATE shape (goto and else-continue forms, both 61)
             -- it does drop the sim-base copy's refs 5->3 as wanted, but the smaller
             loop then lets loop.c hoist the 0xd5554 literal that retail rematerializes
             per iteration.
         ==== W64-A12: A STRUCTURALLY TRUER BASIN FOUND AND BANKED (not landed -- it gates
         55, worse than this 50, but it is the one the next pass should price).  Baseline
         re-gated 50 @118/120; the 2 missing insns are retail's preheader `addu t4,a2,zero`
         and its SECOND `lui/lw` of AI_elapsedTime.
         BASIN x1 = scratchpad/w64a12/aih_opp.cpp.x1_55 : DELETE the pre-loop `new_var`
         statement entirely and write `perTickProb = AI_elapsedTime * 116;` in BOTH arms.
         The w63 movable-existence law then does the whole job by itself: perTickProb is
         set twice so loop.c builds no movable for it, but the 29*ae SUBCHAIN is a
         once-set cse temp, so loop.c hoists exactly that -- reproducing retail's preheader
         BYTE-FOR-BYTE (`lui v1;lw v1` fresh reload + sll3/subu/sll2/addu, oracle 74-81)
         AND keeping `sll a0,t2,2` in the loop duplicated into both branch delay slots
         (oracle 103/107).  No `new_var` variable, no volatile, and the w63 REF-STEP fence
         is still needed (dropping it = 64 @120).  Residual there = 55 @121: ONE stray
         beq-slot nop plus a clean 3-WAY $t ROTATION (ours this=t1 randVal=t2 29ae=t0 vs
         retail this=t0 randVal=t1 29ae=t2) -- i.e. an allocno-order job for
         allocsim/reqdelta/multidial on a structurally correct base, which is strictly
         better posed than this 50-basin's "two pseudos dying on one insn" impossibility.
         FALSIFIED on top of x1 (each re-gated): naming the hoisted product back into a
         loop-body local (`int inv = AI_elapsedTime*29;` inside the loop, or assigning the
         fn-scope new_var there) = 88 @122 -- gcc then keeps it as a real in-loop set;
         dropping the now-unused new_var declaration = inert (55, decl order is not the
         dial here); `AI_elapsedTime*29*4` == `*116` exactly; dropping the playFines fence
         = 64 @120; reading the global directly in the for-condition = 67 @121.
         Also re-measured in THIS basin: new_var after the if-block (the w63 "wipe52")
         = 52 @120 count-exact, new_var after `pInfo =` = 52, inside the guard = 61/61/55.
         ==== W71-A19: THE x1 BASIN IS NOW COUNT-EXACT (54 @120/120) AND ITS RESIDUAL IS A
         QUANTIFIED HARDNESS CERTIFICATE.  Baseline re-gated 50 @118/120.
         (1) THE MISSING 2 INSNS IN x1 WERE ONE REORG FILL, AND IT IS SOURCE-REACHABLE:
             retail puts `hLoop = 0` (addu $a3,$zero,$zero) in the guard's `beq` DELAY SLOT
             (oracle idx 68).  Ours nop-filled it because the for-init was emitted AFTER the
             pre-loop bound load, out of fill_simple_delay_slots' backward-scan reach (13B:
             "a fence can only BLOCK slot theft, never SUPPLY it -- the filler must be hoisted
             into reorg's scan range").  Writing `hLoop = 0;` as the FIRST statement inside
             the guarded block (SYM-faithful: the 8c `hLoop` block starts @0x8006341c, inside
             the guard) + `for (; hLoop < numRacers; ...)` gives x1 54 @120/120 EXACT.
             (Above the guard = identical 54; after the bound load = 55 @121.)
         (2) THE 54-BASIN RESIDUAL IS EXACTLY THREE CLUSTERS, side-by-side-verified 1:1:
             (a) the $t 3-cycle (ours this=t1 randVal=t2 29ae=t0 vs retail t0/t1/t2),
             (b) preheader ORDER (ours emits the bound load 1st, retail 5th among the loop.c
                 hoists, and retail keeps the Cars_gHumanRaceCarList lui/addiu adjacent),
             (c) a $v0/$v1 swap on the carIndex/field1380 pair at the loop head.
         (3) (a) IS PRICED AND UNREACHABLE IN THE PRIORITY MODEL.  allocsim MATCHes 17/17;
             pseudoid: p80=this(refs13/live204), p83=randVal(6/65), p159=29ae(5/41).
             reqdelta AND dialsearch (depth 3 over {p80,p83,p159} and depth 2 over a 6-pseudo
             pool) both return a SINGLE minimal solution: p159 live 41 -> 55, |d|=14.  p159 is
             the loop.c-hoisted 29*ae; its def is the LAST insn of the preheader in BOTH builds,
             so +14 live means moving the def 14 insns earlier = above the guard = out of the
             preheader = a different insn stream.  Hand-enumerated alternatives all fail on the
             floor_log2 steps: p80 refs 13->16 alone lands this=$t0 but leaves randVal/29ae
             swapped (p83 cannot be priced into (.2439,.3137): refs<=7 caps at .2154 and refs 8
             jumps to .369), and p159 refs 5->4 is unreachable (1 out-of-loop def + 2 in-loop
             uses = 5 by construction).  => PRIORITY MODEL EXHAUSTED (09K): the next lens is the
             conflict/preference graph (find_free_reg windows), not any refs/live dial.
         (4) (b) IS A -dL BUDGET FACT, NOT A SPELLING.  With the bound read directly in the
             for-condition the .loop dump says `Insn 177: regno 132 (life 1), savings 1 not
             desirable` -- move_movables' `threshold*savings*lifetime >= insn_count` with
             threshold=(no call)2*(3+n_non_fixed_regs)~56 vs insn_count 59.  It is a razor:
             shrinking the loop below the threshold DOES hoist it (computing perTickProb once
             at the loop top instead of in both arms -> 120 insns again, but 78 diffs because
             retail duplicates `sll a0,t2,2` into both delay slots).  So retail's bound movable
             had lifetime>=2 or savings>=2; ours is life 1 / savings 1 because the load feeds
             the `slt` immediately.  ANGLE: give that load a second in-loop consumer or a
             1-insn separation from its compare, WITHOUT growing the loop.
         FALSIFIED this wave (each re-gated, on x1+i0 = 54): SYM-name-faithful loop head with
         the bound read from the global 67 @121; same keeping the carrier 63-64 @123-124;
         inlining the abs load at the compare site 64 @120; inlining `state` 63 @123; swapping
         the field1380/tableEntry declaration order INERT (54).  x1 basin file:
         scratchpad/A19/v_wipe*.py (A19_gate.py harness).
         ==== W72-A11: LANDED 50 -> 15 (ours 121 / oracle 120).  The W71 "PRIORITY MODEL
         EXHAUSTED" verdict was RIGHT ABOUT ITS PAIR AND WRONG ABOUT THE PROBLEM: reqdelta
         had been asked to reorder only {p80,p83,p159}, but the retail handout is a FIVE-
         pseudo ranking, and once all five are priced the ref-step family reaches it.
         Measured allocno table of the x1+i0 basin (scratchpad/W72_A11/A11_dump.py, which
         prints refs/live/pri/hard-reg/preferences straight off cc1's own -dl/-dg):
             p186 list base .3111 -> $a2   p87 hLoop  .2456 -> $a3
             p159 29*ae     .2439 -> $t0   p80 this   .1912 -> $t1
             p83  randVal   .1846 -> $t2   p90 numRacers .1538 -> $t3
         retail wants 186 > 87 > 80 > 83 > 159 > 90 (= $a2 $a3 $t0 $t1 $t2 $t3).  Lifting
         p80/p83 over p159 is the ONLY priority route (p159's own live dial needs 41->55,
         and its def is the last preheader insn), but it ALSO lifts them over p186 and p87
         -- which is exactly why every earlier two-operand experiment looked like it made
         things worse (this+7/rv+2 alone = 70 @120, dump-confirmed 80->$a2, 83->$a3).
         THE LANDED DIAL, all four steps predicted from floor_log2(refs)*refs/live and then
         confirmed against the dump:
           p80  refs 13->20  (7 "r"(this) operands, out-of-loop)   .3922
           p83  refs  6-> 8  (2 "r"(randVal) operands)             .3692
           p87  refs  7-> 8  (1 "r"(hLoop) operand)                .4211
           p186 refs  7-> 8  -- p186 is the loop.c-hoisted list-base ADDRESS pseudo, so all
                its references are IN-LOOP, and EVERY in-loop asm in this loop costs +2
                insns (measured 4x: "r"(randVal), "m"(list[hLoop]) x1 and x2, and the m-fence
                alone -- the barrier breaks both branch delay-slot fills).  The zero-insn
                substitute is the do{}while(0) DEPTH WRAPPER on the single source use:
                flow.c weights a ref 1+loop_depth, so depth 1 -> 2 becomes 3 (+1 ref), and
                loop.c strips the phony loop, so no note survives to the scheduler.  .5333
         Result: the whole $a/$t band is retail-exact (side-by-side 1:1) and the two W71
         clusters (a)+(c) are GONE.  gcc-2.8 caps an asm at 10 operands -> two adjacent
         out-of-loop asms (a third asm insn would add +1 live to everything; adjacent is
         free here).  RESIDUAL 15 = W71's cluster (b) ONLY, now sharpened to ONE nop:
           - preheader: ours emits the numRacers load 1st (it is a pre-loop SOURCE
             statement and loop.c APPENDS its hoists after everything already there);
             retail emits it 5th/LAST and keeps the list-base lui/addiu adjacent;
           - loop head: retail fills the `lw a0,0(a2)` load-delay slot with the 0xd5554 low
             half (`ori a1,a1,21844`) and completes the highLevelAIObjs address before the
             abs test; ours nops that slot and issues the ori two slots later.  That nop IS
             the 121st insn.
         FALSIFIED in this basin (each re-gated from 15; 04Z basin-relativity respected --
         several of these were also falsified in the 54-basin and were re-tried anyway):
           swap field1380/tableEntry decl order 25; tableEntry+state first 27;
           `int lim = 0xd5554;` as the first loop statement 78 @124, after carObj_h 78 @124
           (naming the constant hands LICM a movable);
           bound read straight from the global in the for-condition 30 @122 (and +lim 91).
         NEXT LENS unchanged from W71(4): the -dL move_movables budget for the bound load
         (`life 1, savings 1, not desirable`) -- it must become a hoisted movable to land
         5th, which needs lifetime>=2 without growing the loop.  Harness/tables:
         scratchpad/W72_A11/{A11_dump.py,A11_apply.py,v_wipe_[abcdef].py}.
         ==== W74-A11: LANDED 15 -> 9.  W71's cluster (b) IS CLOSED and the whole $a/$t
         band is now retail-exact side-by-side; the residual is ONE cluster (the loop-head
         schedule) instead of three.  Three coupled edits, all cited at their sites:
         (1) THE BOUND LOAD IS NOW A loop.c MOVABLE (21B-3 executed).  W72 named the lens
             correctly but priced it as unreachable; the pricing was wrong because it read
             move_movables' budget as needing `savings>=2 OR lifetime>=2` and then hunted
             for a second in-loop consumer.  loop.c:600 copies n_times_SET into
             n_times_used and :795 sets m->savings from it, so savings == 1 for EVERY
             movable BY CONSTRUCTION (a reg set twice is not a movable at all) -- LIFETIME
             is the only dial, and :793 computes it from REGNO_FIRST_UID/REGNO_LAST_UID,
             i.e. the FUNCTION-WIDE luid span, not the in-loop distance.  So the bound does
             not need a second in-loop use: assigning it through `numRacers`, which the
             zero-insn fences already reference on both sides of the loop, spans the whole
             loop and clears `threshold*savings*lifetime >= insn_count` with the loop
             unchanged.  Reading the bound STRAIGHT from the global in the condition is the
             W72-measured 30 @122 (life 1, "not desirable", load stays in the loop) -- the
             carrier is the whole difference.  Preheader is now byte-exact: list base,
             sim base, the 29*ae chain, then `lui t3;lw t3` LAST, exactly retail.
         (2) hlai AS A REAL PRE-LOOP LOCAL.  With (1) alone the residual was a t5/t6 swap
             whose cause the -dl/-dg dump names exactly: p85 (oppFines) and p142 (the
             loop.c-hoisted highLevelAIObjs address) BOTH price .0300 (refs 3 / live 100),
             an EXACT tie, and 16A's tie-break is the allocno NUMBER -- the compiler-created
             p142 can never win it.  A depth wrapper on the array read would buy the ref
             (3->4 = .08) but costs +2 insns here (every in-loop wrapper breaks the two
             branch delay-slot fills).  Making the base a SOURCE local emits the identical
             first-preheader `lui;addiu` while giving it an early pseudo number and a
             fence-dialable ref count.
         (3) numRacers refs 5 -> 6 (the post-loop fence's SECOND operand).  With (2) the
             swap moved to numRacers vs the sim-base copy (p90 .1031 vs p164 .1020 -- a
             second near-tie); one floor_log2 step (.1237) settles it.  ONE operand there
             loses $t3; two is the measured minimum.
         RESIDUAL 9 = the loop head ONLY, and it is exactly the W72 description: retail
         fills the `lw a0,0(a2)` load-delay slot with the 0xd5554 low half
         (`ori a1,a1,21844`) and completes the highLevelAIObjs address (`lw v0,596(a0)`,
         `sll`, `addu`) BEFORE the abs branch; ours nops the slot and issues that whole
         chain in the merge block after `negu`.  That nop is the 121st insn.  This is a
         cross-BLOCK placement question (retail's 596 chain is in the pre-branch block,
         ours in the post-branch one), NOT a within-block scheduler tie.
         FALSIFIED in the 9-basin (each re-gated): carIndex read hoisted above field1380
         19; carIndex read between field1380 and tableEntry 9 (inert); a `slot` pointer
         local for the array element 9 (inert).  FALSIFIED on the way to it (re-gated from
         15, i.e. 04Z-refreshed against the W72 lists): statement-order swaps
         596-first 25 / 596+state-first 27 / 596+fines-first 25; a do-while depth wrapper
         on the tableEntry read 103 @123 (the wrapper itself is +2 insns here, unlike the
         carObj_h one); the same via a statement-expression 103 @123; folding the
         tableEntry read into the existing carObj_h wrapper 27 @123; splitting the
         tableEntry decl from its initializer alone INERT.  Harness:
         scratchpad/W74_A11_{gate,sbs,wipe}.py. */
      /* ==== */
      /* ---- W62-A10 (51 diffs, ours 121 / oracle 120) -- SUPERSEDED by the block above;
         kept for its falsification list.  The residual is now ONE
         NAMED gcc question, not a spelling search.  NEW MEASUREMENTS this session
         (each re-gated through scratchpad/w62a10/p_wipe*.py, baseline 51):
         (1) THE x29 CHAIN IS REPRODUCIBLE.  A plain (non-volatile) `AI_elapsedTime * 116`
             at both sites makes cc1 emit retail's EXACT strength-reduction preheader
             (`lui;lw` of AI_elapsedTime, `sll v0,v1,3 / subu v0,v0,v1 / sll v0,v0,2 /
             addu t2,v0,v1` = 29*ae) -- byte-for-byte the oracle's insns 74-81.  The ONLY
             remaining structural divergence is the HOIST BOUNDARY: our loop.c also lifts
             the final `sll <<2` AND the `slt` into the preheader (one loop-invariant flag),
             where retail keeps `sll a0,t2,2` inside the loop and lets reorg copy it into
             BOTH branch delay slots (oracle 103 + 107) with a single shared `slt` (108).
             So this is a loop.c move_movables STOP-POINT question, not a multiplier
             spelling.  Scores: plain *116 -> 83 (123/120); `*29*4` -> 83 (123/120);
             both with the perTickProb dead store removed -> 87 (121/120).
         (2) COUNT-EXACT SHAPE FOUND: `new_var = AI_elapsedTime * 29;` pre-loop with
             `new_var * 4` at the sites AND the perTickProb dead store dropped gives
             120/120 EXACT at 76 diffs; the residual there is (a) the same LICM hoist and
             (b) a whole-function saved/temp band rotation t0<->t1, t6<->t7, t2<->t4.
             Per 13A that band is an allocno-NUMBER (= declaration-order) dial, so the
             honest landing pair is (loop.c hoist stop) + (decl reorder), together.
         (3) THE perTickProb DEAD STORE IS THE `xori`.  Ours emits `slti;xori;beqz` where
             retail has `slti;bnez` -- the assignment materializes the boolean.  Dropping
             it alone -> 57 diffs at 119/120 (loses 2, gains diffs), so it must NOT be
             dropped on its own; it is only right in combination with (2).
         Nothing landed: every combination measured is worse than 51 on the authoritative
         gate.  Next lens = loop.c's move_movables threshold (why retail stops hoisting
         after the `addu t2,v0,v1`), then the 13A declaration-order band fix.  ---------- */
      /* H24: reconstructed pre-loop roll + per-human-race-car wipe-out loop (oracle 0x800633AC-0x800634D8;
         recon had an EMPTY loop AND dropped the pre-loop conditional store -> wipe-out timer never re-armed).
         The oracle materializes `this` into a stable base reg ($t0 = $a0) at entry and RE-LOADS
         this->carObj_ fresh at EACH wipeOutEndTick write site off that base, rather than caching
         carObj_ itself in one register across the whole function -- write through
         this->carObj_->wipeOutEndTick directly at each site, don't cache carObj_ into a local. */
      randtemp    = fastRandom * randSeed;                        /* 0x800633AC */
      perTickProb = AI_elapsedTime * 2 + AI_elapsedTime;          /* $a0 = 3*ae, 0x800633BC-C0 -- scheduled into the mult->mflo latency gap */
      fastRandom  = randtemp & 0xffff;                            /* 0x800633C8/E4 */
      randVal     = (int)(randtemp >> 8) & 0xffff;                /* $t1, 0x800633D4-D8 */
      if (randVal < perTickProb) {                                /* 0x800633DC-E8 */
        this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;      /* 0x800633EC-F8 */
      }
      hLoop = 0;
      pInfo = &this->perpChaseInfo_;
      if (pInfo->bestChaseLevelIndex_ != (pInfo->copGameInfo_)->numLevels + -1) {
        AIHigh_Base **hlai = highLevelAIObjs;   /* 🔴 W74-A11: the array BASE as a real pre-loop
                                       local, NOT a loop.c hoist.  Both spellings emit the same
                                       `lui;addiu` as the FIRST preheader insn, but a source local is
                                       an early-numbered pseudo that a zero-insn fence can dial; the
                                       hoisted one tied EXACTLY with oppFines (both .0300) and lost
                                       $t5 on the allocno-number tie-break (16A). */
        /* 🔴 W72-A11 REF-STEP DIAL -- ZERO INSNS, DO NOT "SIMPLIFY".  These two read-only
           fences carry the whole five-pseudo ranking that gives retail's $a2/$a3/$t0..$t3
           band (receipt above): each operand = +1 out-of-loop REG_N_REFS, and the
           floor_log2(refs)*refs/live steps are what order the allocnos.
             numRacers x1  refs 3->4   (w63: over the simGlobal-base copy -> $t3)
             this      x7  refs 13->20 (.3922, wins $t0)
             randVal   x2  refs  6->8  (.3692, wins $t1)
             hLoop     x1  refs  7->8  (.4211, keeps $a3 ahead of this/randVal)
           gcc-2.8 caps an asm at 10 operands, hence two adjacent statements. */
        __asm__("" : : "r"(numRacers),"r"(this),"r"(this),"r"(this),"r"(this),"r"(this),"r"(this),"r"(this));
        __asm__("" : : "r"(randVal),"r"(randVal),"r"(hLoop),"r"(hlai));
        /* 🔴 W74-A11 BORN-IN-THE-LOOP (21B-3).  The bound READ lives in the loop condition, so
           loop.c builds a MOVABLE for it and move_movables emits it LAST among the hoists --
           retail's preheader order (`lui t3;lw t3` 6th, after the list base, the sim base and
           the 29*ae chain).  Written as a pre-loop statement it is an ENTRY-BLOCK insn and can
           only land FIRST, which was the whole W71/W72 cluster (b).
           The budget: move_movables needs threshold*savings*lifetime >= insn_count and
           savings == n_times_set == 1 for ANY movable (loop.c:600/795), so LIFETIME is the only
           dial -- and it is the FUNCTION-WIDE luid span (REGNO_FIRST/LAST_UID).  Read straight
           from the global the load feeds its `slt` immediately => life 1, "not desirable"
           (measured: 30 @122, the load stays in the loop).  Assigning through `numRacers`, which
           the zero-insn fences reference on BOTH sides of the loop, spans the whole loop => the
           movable clears the budget with the loop unchanged. */
        for (; hLoop < (numRacers = Cars_gNumHumanRaceCars); hLoop = hLoop + 1) {   /* 0x80063450 */
          Car_tObj    *carObj_h;
          /* 🔴 W72-A11: the do{}while(0) is a ZERO-INSN REF DIAL, not a stray brace.
             flow.c weights a reference by 1 + loop_depth, so wrapping this ONE use lifts
             it 2 -> 3 = +1 ref on the loop.c-hoisted Cars_gHumanRaceCarList BASE pseudo
             (refs 7 -> 8, pri .3111 -> .5333), which is what keeps that base in retail's
             $a2 ahead of `this`.  loop.c strips the phony loop, so no note reaches the
             scheduler.  It is the only zero-insn way to add an IN-LOOP ref here: every
             in-loop asm in this loop costs +2 insns (measured 4x -- the barrier breaks
             both branch delay-slot fills).  Unwrapping it costs ~40 diffs. */
          do { carObj_h = Cars_gHumanRaceCarList[hLoop]; } while (0);       /* 0x8006345C */
          int          field1380    = *(int *)((char *)carObj_h + 1380);       /* 0x80063468 */
          AIHigh_Base *tableEntry   = hlai[*(int *)((char *)carObj_h + 596)]; /* carIndex, 0x80063464-84 */
          int          playFines    = *(int *)((char *)carObj_h + 932);        /* SYM REG $3=$v1, 0x80063488 */
          int          state        = *(int *)((char *)tableEntry + 148);      /* 0x8006348C */
          if (0xd5554 < ((field1380 < 0) ? -field1380 : field1380)) {          /* 0x80063480/90: permuter-found
                                            double-roll -- oracle RE-DERIVES the ternary at the compare site
                                            instead of reusing absField1380 (740 vs 1015 base permuter score) */
            if (state < 2 && !(oppLevel < 3)) {                                /* 0x80063494-A0: skips the fines check */
              /* branch 0x800634A0's DELAY SLOT (0x800634A4 $a0=$t2<<2=116*ae) runs before reaching RANDGATE.
                 oracle recomputes `AI_elapsedTime*116` FRESH at EACH branch's delay slot (byte-identical
                 `sll a0,t2,2` at both 0x800634A4 and 0x800634B4) instead of hoisting ONE shared boolean
                 out of the loop; a plain (non-volatile) read here lets gcc CSE+LICM the whole compare to a
                 single flag computed before the loop even starts. The volatile read defeats that CSE/LICM
                 (real semantic effect: this->AI_elapsedTime is a per-tick global gcc must not treat as
                 provably loop-invariant across this branch merge) and reproduces the oracle's per-branch
                 recompute shape (107->86 diffs measured). */
              perTickProb = AI_elapsedTime * 116;
              if (randVal < perTickProb)           /* 0x800634B8 */
                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */
            } else if (2 <= playFines - oppFines) {                          /* 0x800634A8-B0 (skip if <2) */
              perTickProb = AI_elapsedTime * 116;
              if (randVal < perTickProb)          /* $t2<<2, 0x800634B4-BC */
                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */
            }
          }
        }
        /* 🔴 W74-A11: the POST-loop half of the numRacers live range (zero insns).  It does two
           jobs: (1) it is the movable's REGNO_LAST_UID, so the bound load's lifetime spans the
           loop (see the for-header receipt); (2) the two operands are the ref-step that keeps
           numRacers in retail's $t3 ahead of the sim-base copy -- refs 5->6 crosses a
           floor_log2 step (.1020 -> .1237 vs the base's .1020).  One operand loses $t3. */
        __asm__("" : : "r"(numRacers),"r"(numRacers));
      }

    }

  }

  return;

}








/* ---- DoRearEnder__15AIHigh_Opponent  AIHigh_Opponent::DoRearEnder  [AIH_OPP.CPP:97-146] SLD-VERIFIED ----
 * MATCH (185 -> PASS 181/181, w64-a12): restoring the SYM block scopes separates
 * attackIndex from the loop counter/list walk; explicit shifted road bounds preserve
 * the retail byte/multiply handout; builtin_abs fixes both speed paths AND both
 * latDistance sign tests (see the block receipt below -- that was the seal); and
 * splitting the two probability tests restores the retail early-return CFG. */

int AIHigh_Opponent::DoRearEnder()



{
  int attackIndex;



  attackIndex = AIScript_DoReAction(&(this->carObj_)->script,0x100);   /* SYM: attackIndex is REG $s1,
                                            held live across the AIWorld_SplineDistance call below --
                                            rewired from anonymous iVar1 per the SYM ground truth. */

  if (attackIndex != -1) {
    Car_tObj *otherCarObj;
    int longDistance;
    int latDistance;
    /* ==== W64-A12: SEALED, PASS 181/181 (was 50).  THE LEVER WAS THE ABS FORM AT
       THE *OTHER* SITE.  Retail defers the `mflo` of longDistance*direction PAST the
       latDistance sign test at BOTH sites (oracle idx 38 / 127), which no scheduler can
       do while the abs is a real branch: a hand-rolled `if (x<0) x = -x;` splits the
       region into three basic blocks, so the mult/mflo pair is pinned in the first one.
       `__builtin_abs` is ONE RTL insn (its bgez/nop/negu is an asm template, invisible to
       the CFG), so the whole region stays ONE basic block and sched2 places the mflo after
       it, exactly like retail -- and the two 32-bit range constants then fall into the
       roadPosition load-delay slots for free.
       ORDER OF LANDING IS LOAD-BEARING (measured, this basin): the IN-LOOP site (~line 352)
       first = 50 -> 24; site 1 alone = 60; BOTH at once from the 50-basin = 34.  Only after
       the in-loop site was landed did site 1 pay: 24 -> PASS.
       THE W63 FENCE SCAFFOLDING IS RETIRED BY THIS.  The named+opacity-fenced lo1/hi1
       constants (w63-a12, 54 -> 50) were a WORKAROUND for the constant-hoist that the
       branchy abs made necessary; with __builtin_abs they are actively harmful --
       re-measured on the post-site-2 basin: plain literals 24 -> PASS, named+fenced 34,
       named-unfenced PASS, fence order reversed 30, single fence 34.  Landed form = plain
       literal constants, zero asm, zero named temps (09L: __builtin_abs is the retail
       spelling; 04Z: the W59 "__builtin_abs makes it WORSE (58)" receipt was measured in a
       basin where the other site still had the branchy abs).  W59/W60/W61/W63 near-miss
       receipts for this fn (constant-hoist family, ~20 falsified spellings) are all
       superseded and deleted with this seal. ==== */

    otherCarObj = Cars_gList[attackIndex];

    longDistance = AIWorld_SplineDistance(otherCarObj,this->carObj_);

    longDistance = longDistance * this->carObj_->direction;

    latDistance = this->carObj_->roadPosition - otherCarObj->roadPosition;

    {

    latDistance = __builtin_abs(latDistance);

    if (((u_int)(longDistance - 0x10001) <= 0x26fffeU) && (latDistance < longDistance * 2)) {

      int speed = __builtin_abs(otherCarObj->currentSpeed);

      if (0xb1c71 < speed) {

        return attackIndex;

      }

    }
    }

  }

  Car_tObj *pCVar4 = this->carObj_;

  if ((pCVar4->N).simOptz == '\0') {

    int iVar1 = __builtin_abs(pCVar4->currentSpeed);

    if (0x140000 < iVar1) {

      int racerLoop = 0;
      Car_tObj **ppCVar7;
      Sim_tSimGlobalVar *tickPtr;

      tickPtr = &simGlobal;   /* §3.12 lever #16: hold the &simGlobal BASE in a callee-saved $s4 across
                                            the AIWorld_SplineDistance call (H26 FIX: oracle keeps the
                                            STRUCT BASE, not a pre-offset &simGlobal.gameTicks -- it
                                            re-applies the +4 gameTicks field offset as the LOAD
                                            DISPLACEMENT at both mask-check sites: `lw v1,4(s4)`, not
                                            `lw v1,0(s4)`. Confirmed via Sim_tSimGlobalVar layout
                                            (gameTicks @+4). */
      ppCVar7 = Cars_gHumanRaceCarList;

      for (; racerLoop < Cars_gNumHumanRaceCars; racerLoop = racerLoop + 1) {   /* SYM: racerLoop is a
                                            SEPARATE local from the pre-loop longDistance check (2nd SYM
                                            decl block re-declares otherCarObj/longDistance/latDistance but
                                            NOT attackIndex/racerLoop -- racerLoop is the outer-scope loop
                                            var, conflating it with the pre-loop longDistance temp forces
                                            them into ONE callee-saved reg for the whole function). */

        Car_tObj *otherCarObj = *ppCVar7;   /* SYM: otherCarObj is REG $s0, RE-DECLARED (fresh block-scope
                                     pseudo) inside this loop -- same physical slot as section 1's
                                     otherCarObj, rewired from anonymous pCVar4. */

        int sliceAddress = (otherCarObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices;

        if (((int)-(((u_int)*(u_char *)(sliceAddress + 0x1e) << 15) *
                    (u_int)(*(u_char *)(sliceAddress + 0x1d) >> 4)) <=
             otherCarObj->roadPosition) &&
            (otherCarObj->roadPosition <=
             (int)(((u_int)*(u_char *)(sliceAddress + 0x1f) << 15) *
                   (*(u_char *)(sliceAddress + 0x1d) & 0xf)))) {

          int longDistance = AIWorld_SplineDistance(otherCarObj,this->carObj_);

          Car_tObj *pCVar6 = this->carObj_;

          longDistance = longDistance * pCVar6->direction;

          int latDistance = pCVar6->roadPosition - otherCarObj->roadPosition;   /* SYM: latDistance REG $a1,
                                     re-declared fresh in this block (same reg as section 1's). */

          latDistance = __builtin_abs(latDistance);   /* MATCH (w64-a12, THE seal lever, 50 -> 24):
                                     __builtin_abs is ONE RTL insn, so this whole region stays ONE
                                     basic block and sched2 can put the longDistance*direction `mflo`
                                     AFTER the sign test like retail; the branchy `if (x<0) x=-x;`
                                     splits the region and pins the mflo before it. */

          if ((longDistance - 0x10001U < 0x26ffff) &&
              (latDistance < longDistance * 2)) {
            u_int mask = pCVar6->personality->rearBumpProbMask;
            if ((tickPtr->gameTicks + pCVar6->carIndex * 0x7b & mask) == mask) {
              return otherCarObj->carIndex;
            }
          }
          if (longDistance + 0x3ffffU < 0x7ffff) {
            Car_tObj *smackCarObj = this->carObj_;
            u_int mask = smackCarObj->personality->smackProbMask;
            if ((tickPtr->gameTicks + smackCarObj->carIndex * 0x7b & mask) == mask) {
              return otherCarObj->carIndex;
            }
          }

        }

        ppCVar7 = ppCVar7 + 1;

      }

    }

  }

  return -1;

}








/* ---- HighExecute__15AIHigh_Opponent  AIHigh_Opponent::HighExecute  [AIH_OPP.CPP:150-247] SLD-VERIFIED ---- */

void AIHigh_Opponent::HighExecute()



{
  switch ((stateType_t)stateType_) {

  case STATE_PURGATORY:
  case STATE_IDLE:
  case STATE_OFFROAD:
  case STATE_ROVING_TRAFFIC:
  case STATE_NONACTIVE:
  case STATE_DONUTS:
  case STATE_GOTOSLICE:
  case STATE_CRUISE:
    break;

  case STATE_NONE:
    {
      AIState_Base *newState =
        (AIState_Base *)new((AIState_Normal *)operator new(8))
          AIState_Normal(carObj_);
      SetState(newState,STATE_NORMAL);
    }
    return;

  case STATE_NORMAL:
    {
    int attackIndex;

    this->HandleCops();

    this->CheckForWipeOut();

    if ((attackIndex = AIScript_DoReAction(&carObj_->script,0x40)) != -1) {
      this->attackMode_ = SCRIPT_ATTACK;
    }
    else if ((attackIndex = DoRearEnder()) != -1) {
      this->attackMode_ = REAR_END;
    }
    else if ((attackIndex = DoProvokedAttack()) != -1) {
      this->attackMode_ = PROVOKED_ATTACK;
    }

    if (this->attackMode_ != 0) {
      coorddef pos;

      memset((u_char *)&pos,0,0xc);

      int aggression = attackMode_ - 1;
      aggression = aggression < 2 ? 2 : aggression;

      SetState(
        (AIState_Base *)new((AIState_Chase *)operator new(0x94))
          AIState_Chase(carObj_,Cars_gList[attackIndex],&pos,0x20,
                        0x960000,0x960000,aggression,0x10000),
        STATE_CHASE);

    }

    break;
    }

  case STATE_CHASE:
    {
    AIState_Chase *attackState = (AIState_Chase *)state_;

    this->HandleCops();

    this->CheckForWipeOut();

    attackState->SetMurderMode(1,0xf);

    switch (attackMode_) {
    case SCRIPT_ATTACK:
      if (AIScript_DoReAction(&carObj_->script,0x40) == -1) {
        attackMode_ = NO_ATTACK;
      }
      break;

    case REAR_END:
      if (DoRearEnder() == -1) {
        attackMode_ = NO_ATTACK;
      }
      break;

    case PROVOKED_ATTACK:
      attackTicksLeft_ -= AI_elapsedTime;
      if (attackTicksLeft_ <= 0) {
        attackMode_ = NO_ATTACK;
      }
      break;
    }

    if (attackMode_ == NO_ATTACK) {
      carObj_->desiredDirection =
        GameSetup_gData.reverseTrack == 0 ? 1 : -1;

      SetState(
        (AIState_Base *)new((AIState_Normal *)operator new(8))
          AIState_Normal(carObj_),
        STATE_NORMAL);

      attackMode_ = NO_ATTACK;
    }
    break;
    }

  }

  (this->state_)->StateExecute();

  return;

}








/* ---- __15AIHigh_OpponentP8Car_tObj  AIHigh_Opponent::ctor  [AIH_OPP.CPP:250-255] SLD-VERIFIED ---- */
AIHigh_Opponent::AIHigh_Opponent(Car_tObj *carObj)



{

  (new((AIHigh_Player *)this) AIHigh_Player(carObj));

  this->_vf =

       (__vtbl_ptr_type (*) [3])AIHigh_Opponent_vtable;

  this->attackMode_ = 0;

  this->lastHumanHitter_ = (Car_tObj *)0x0;

  this->hitCount_ = 0;

  this->attackTicksLeft_ = 0;

  return;

}








/* ---- DoProvokedAttack__15AIHigh_Opponent  AIHigh_Opponent::DoProvokedAttack  [AIH_OPP.CPP:260-280] SLD-VERIFIED ---- */

int AIHigh_Opponent::DoProvokedAttack()



{

  int iVar1;

  Car_tObj *myCarObj;

  Car_tObj *pCVar3;

  Car_tObj *oppCarObj;

  int iVar4;



  myCarObj = this->carObj_;

  if (((simGlobal.gameTicks - (myCarObj->N).collision.lastTime < 0xf) &&

      (pCVar3 = (Car_tObj *)(myCarObj->N).collision.lastOtherObj, pCVar3 != (Car_tObj *)0x0)) &&

     ((pCVar3->carFlags & 4U) != 0)) {

    if (this->lastHumanHitter_ != pCVar3) {

      this->lastHumanHitter_ = pCVar3;

      this->hitCount_ = 0;

    }

    iVar1 = ++this->hitCount_;

    oppCarObj = this->carObj_;

    iVar4 = oppCarObj->personality;

    if (*(int *)(iVar4 + 0x24) < iVar1) {

      iVar1 = *(int *)(iVar4 + 0x28);

      this->hitCount_ = 0;

      this->attackTicksLeft_ = iVar1;

      return pCVar3->carIndex;

    }

  }

  return -1;

}







/* end of aih_opp.cpp */

/* cont.35 B3b: base-forward dtor re-attributed from main.c (�3.23 simple variant);
   oracle = jal ___11AIHigh_Base; extern-C free fn exports the exact symbol. */
extern "C" {
void ___11AIHigh_Base(void *);
}
extern __vtbl_ptr_type AIHigh_BasicPerp_vtable[];   /* owned by aih_basicperp.obj */
extern "C" {
void ___15AIHigh_Opponent(void *thisp) {
  *(void**)((char*)thisp + 0x14) = (void*)AIHigh_BasicPerp_vtable;
  ___11AIHigh_Base(thisp);
}
}
