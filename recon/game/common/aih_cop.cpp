/* game/common/aih_cop.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aih_cop_types.h"
#include "aih_cop_externs.h"

extern int AI_elapsedTime;   /* H22: ai.cpp @0x8013C554 (not in this TU's externs).
                              W57-A8: the `volatile` here was WRONG (it forced a re-LOAD of
                              AI_elapsedTime every CheckForWipeOut iteration = 4 spurious
                              insns). The oracle loads it ONCE into $a2 in the loop preheader
                              and computes `AI_elapsedTime * 89` inside the loop; gcc's LICM
                              hoists all but the LAST insn of the synth-multiply chain
                              (`addu $v1,$t1,$a2`), which is what the retail body shows. */
extern int D_8011E0B0[];   /* == &simGlobal.gameTicks (distinct alias symbol the oracle addresses
                              directly for a gameTicks re-read the compiler can't CSE against the
                              nearby simGlobal.gameTicks store -- see aih_basiccop.cpp/aiphysic.cpp) */

/* ---- aistate.obj-owned globals (.bss zero) ---- */
/* @0x8005516c jtbl: gcc now emits its own jump table for HighExecute's switch (11 cases,
 * bodies laid out in oracle VA order 0,1,2,4,3,5,{6,7,8,10,default},9) — placeholder removed. */
/* SYM tag ._144 is anonymous: the five named fields belong to this global's
   inline struct, not to a source-level tCopMurderThresholds type. */
struct {
  int ticksInChaseRegionForMurder;
  int minLatMetersDistanceForMurder;
  int minLongMetersDistanceForMurder;
  int murderTicks;
  int nitrousTicks;
} AIHigh_Cop_AggressionData[3] = {
  {10, 655360, 851968, 512, 512},
  {8, 917504, 983040, 768, 512},
  {4, 1179648, 1179648, 1152, 1024}
};   /* @0x8010cea4 */
int          AICop_skillDelay[3] = { 3276, 6553, 65536 };   /* @0x8010cee0 */
coorddef     AIH_Cop_chasePositions[3][6] = { { {0, 0, 524288}, {-393216, 0, 524288}, {393216, 0, 0}, {0, 0, -655360}, {0, 0, -655360}, {0, 0, -655360} }, { {0, 0, 327680}, {-262144, 0, 327680}, {262144, 0, 327680}, {0, 0, -327680}, {0, 0, -327680}, {0, 0, -327680} }, { {0, 0, 327680}, {-262144, 0, 327680}, {262144, 0, 327680}, {0, 0, -327680}, {0, 0, -327680}, {0, 0, -327680} } };   /* @0x8010ceec */
int          NitroDistanceMeters[2][2] = { 3932160, 1638400, 3932160, 1638400 };   /* @0x8010cfc4 */


/* ---- __10AIHigh_CopP8Car_tObji  AIHigh_Cop::ctor  [AIH_COP.CPP:95-105] SLD-VERIFIED ---- */
AIHigh_Cop::AIHigh_Cop(Car_tObj *carObj,int copIndex)



{

  (new((AIHigh_BasicCop *)this) AIHigh_BasicCop(carObj,copIndex));

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_Cop_vtable;

  this->perpTarget_ = (AIHigh_Player *)0x0;

  this->chaseIndex_ = 0;

  this->requestSpikeBeltAtSlice_ = -1;

  this->forcePurgatory_ = 0;

  this->aggressionLevel_ = 0;

  return;

}








/* ---- SetTuningLevers__10AIHigh_Cop  AIHigh_Cop::SetTuningLevers  [AIH_COP.CPP:110-123] SLD-VERIFIED ---- */

void AIHigh_Cop::SetTuningLevers()



{
  int carTypeIndex;



  carTypeIndex = this->carObj_->carInfo->carType;

  if (this->type_ == 1) {

    this->carObj_->copTopSpeed = copTuningInfo[carTypeIndex + -0x16].superCopTopSpeedCap;

    (this->carObj_)->copAccMult =

         copTuningInfo[carTypeIndex + -0x16].superCopAccMultiplier;

    return;

  }

  this->carObj_->copTopSpeed = copTuningInfo[carTypeIndex + -0x16].regularCopTopSpeedCap;

  (this->carObj_)->copAccMult =

       copTuningInfo[carTypeIndex + -0x16].regularCopAccMultiplier;

  return;

}








/* ---- HighExecute__10AIHigh_Cop  AIHigh_Cop::HighExecute  [AIH_COP.CPP:147-816] SLD-VERIFIED ---- */
/* ==== W71-A19: 69 -> 41 diffs (ours 1461 / oracle 1460).  TWO landings, both cited
   at their sites: (1) the perpTarget_ address-CSE break in the roadblock-release test
   (69->55, the fn's only >=6-insn mismatched run), (2) the AICop_spikeBelt store order
   giving this->requestSpikeBeltAtSlice_ retail's early luid (55->41).
   RESIDUAL 41 = 16 mismatched insns in 10 runs, NONE longer than 3, and the fn is now
   only +1 insn (the wrongWay island's unfilled load-delay nop).  The five sites, all
   SLD-anchored (tools/sldall.py):
     A ours[215:222] SLD 303  wrongWay: ours loads roadblock.dir BEFORE the reverseTrack
       global (leaving its load-delay slot nop'd) where retail loads the global first and
       fills the slot with the dir load.  RE-FALSIFIED IN THIS BASIN (each re-gated from
       55): if/else, inverted if/else, ternary, if/else + a shared dir local (all 55 but
       +4 insns), a global-into-local read first (55, byte-identical), volatile on the
       reverseTrack read (55), volatile on either dir read (55 @+2), a void-tail fence
       above the pair (58), a read-only fence on the global between them (57).
     B ours[362:367] SLD 369  the INNER (mode==1)||(mode==4): retail re-materializes
       `li v0,4` INTO the first beq's delay slot and loads mode into $v1; ours reuses the
       outer test's callee-saved $s2 and nops the slot.  The two halves are COUPLED --
       our inner mode read takes $v0, so $v0 is not free for a fresh 4.  Re-falsified
       here: spelling the inner test as a direct this->blockade_.mode re-read = 53.
     C ours[894:900] SLD 615  `(this->carObj_)->AIFlags | 2`: retail pointer->$v1 /
       value->$v0 (reusing the two regs the preceding mode==2 test just killed), ours the
       reverse.  INERT here (all 41): compound `|=`, operand flip `2 | x`, a named
       block-scoped `Car_tObj *co`, an unsigned-typed RMW.
     D ours[1084:1086]  the 0x471c7 compare's DEST reg ($v0 ours / $v1 retail).
       `speed > 0x471c7` is byte-identical (canonicalised).
     E ours[1126]  one compare-operand order on the chaseLevelIndex_ test; flipping the
       source operands is WORSE (61) -- do not retry.
   READING: C and D (and B's second half) are all the SAME shape -- a two-qty block where
   retail hands $v0 to the value and $v1 to the pointer/base and ours does the reverse.
   That is local_alloc, not global_alloc: the next lens is the 14C 3-QTY LADDER LAW
   (local-alloc.c:1638-52 -- blocks with next_qty<=3 skip the qsort and compare RAW QTY
   NUMBERS, so no ref/live dial can reorder them; the only dial is crossing the 3<->4
   boundary with a DISTINCT extra qty).  Run tools/copypref.py / qtyprio.py on these
   three blocks before spending another spelling wave. ====
   ==== W72-A11: 41 -> 20 AND COUNT-EXACT 1460/1460 (was +1).  All three landings are
   the SAME device -- the zero-insn OPACITY/IDENTITY fence `("" : "=r"(x) : "0"(x))` --
   used for THREE DIFFERENT jobs, and every one of them sits verbatim inside a previous
   wave's falsification list (04Z basin-relativity at full strength: the W71 lists were
   measured in the 55/69 basins, all three were re-tried here and all three landed).
     A (SLD 303 wrongWay, the fn's +1 insn):  `int rev = GameSetup_gData.reverseTrack;`
       + an identity fence, then test `rev == 0`.  W71 falsified "a global-into-local read
       first (55, byte-identical)" -- the PLAIN local really is inert; the FENCED local
       gives the reverseTrack load an earlier luid that sched2 honours, so the dir load
       sinks into its load-delay slot exactly like retail.  41 -> 38, count exact.
       Then naming `dir` as well AND fencing it (plain `dir` local = inert 38) took the
       island's register handout to retail's: 38 -> 32.
     C (SLD 615 AIFlags|2):  a block-local `Car_tObj *co = this->carObj_;` with an
       identity fence on the POINTER, then `co->AIFlags = co->AIFlags | 2;`.  W71 recorded
       the un-fenced named pointer as INERT -- again the plain/fenced distinction (15B).
       Fencing the VALUE instead is inert (38); it is the pointer that must stop being
       cse-equal to `this->carObj_`.  38 -> 26.  A7 and C3 compose: 20.
   RESIDUAL 20, four sites, all pure register handout at exact count:
     A'  the rev load: ours $a0 / retail $v0.
     B   the inner (mode==1)||(mode==4): retail `li v0,4` in the first beq's delay slot,
         ours re-uses the outer test's callee-saved $s2 and nops the slot.
     D   the 0x471c7 compare's DEST reg ($v0 ours / $v1 retail).
     E   one bne operand order on the chaseLevelIndex_ test.
   FALSIFIED IN THIS BASIN (each re-gated from its stated base):
     A: plain `rev` local 41; if/else on rev!=0 41 @1465; if/else on rev==0 41 @1465;
        `rev` read-only fence 27 @1461; a SECOND identity fence on rev inert (20).
     B: 21E-5 cse-constant-sharing breaker aimed at the OUTER 4 (a fenced
        `blockadeMode_t four`) 53 @1461; a void-tail fence before the inner test 50;
        both together 63.  So B is NOT a cse constant-table question the way the W63
        note assumed -- breaking the outer's 4 costs more than the inner's fresh `li`
        buys.  NEXT LENS for B: $s2 is a GLOBAL allocno (the 4 is live across the whole
        fn); the reachable question is why our inner mode read takes $v0 (leaving no
        free caller-saved reg for a fresh 4), i.e. the two-qty handout of that block.
     C: value-local + fence 38; ptr-local + value-local (both fenced) 38.
     D: named boolean + identity fence inert (20).
     E: operand flip 26 (WORSE, third confirmation -- do not retry).
   INSTRUMENT NOTE: the instrumented cc1plus (C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe)
   ICEs on THIS function (aih_cop.cpp:264, "Internal compiler error") and therefore
   truncates the TU trace after SetTuningLevers -- the [qty_order]/[find_free_reg] lens is
   NOT available for HighExecute.  Harness scratchpad/W72_A11/A11_trace.py reports the
   fidelity table and leaves the partial trace; the real CC1PLPSX still accepts -dl/-dg.
   READ THE LADDER LAW CORRECTLY (gcc-2.8.1 local-alloc.c:1588-1610, read this wave):
   the raw-qty-number bug is in the `case 3:` arm ONLY -- its second comparison
   `qty_compare (1, 2)` compares QTYS 1 and 2 while the EXCHANGE permutes qty_ORDER.
   `case 2:` is a correct two-element sort, so a genuinely 2-qty block IS priority
   ordered and the floor_log2 ref/live dial DOES reach it.  Count the block's qtys before
   quoting 14C.
   ==== W74-A11 re-gated (20 @1460/1460) and CLOSED THE 20B/12A PREFERENCE-KILLER AXIS ON
   SITE A' with a clean negative.  A' is `lui v0; lw a0,0(v0); bnez a0` where retail
   SELF-TEMPS (`lw v0,0(v0); bnez v0`), i.e. purely "rev's home is $a0, retail's is $v0",
   which is textbook 20B: a zero-insn hard-register denial on the existing identity
   launder.  It does NOTHING.  Measured, each re-gated from 20 and each byte-identical
   (1460 insns, 20 diffs): the rev launder with `: "$4"`, with `: "$4","$5"`, with
   `: "$4","$5","$6","$7"`; the dir launder with `: "$4"`; both launders clobbering $a0.
   A SECOND launder on rev placed after `wrongWay = ~dir;` costs +2 insns (28 @1462)
   whether it clobbers $a0, all four arg regs, or nothing -- the clobber is again inert.
   READING (this is the transferable part): 20B's killer denies local-alloc's COPY
   PREFERENCE, which only exists for a BLOCK-LOCAL qty; `rev` is read in a different block
   from where it is set, so it is a GLOBAL allocno and its seat comes from global.c's
   find_reg, where an asm clobber changes nothing it can act on.  Before spending a wave
   on a 20B clobber walk, check which allocator owns the pseudo (a clobber that is inert
   across EVERY register set is the tell, and it is cheap: three variants).
   ALSO FALSIFIED this wave on SITE D (the 0x471c7 slt dest, each re-gated from 20): a
   named `int lim_ = 0x471c7;` before the test 20 (byte-identical -- 15B's "a plain named
   constant is const-propagated back = provably inert"), the same with an identity launder
   20, the same with a read-only fence 20; an identity launder on `speed` itself 23 @1461.
   So D is not reachable by naming or fencing either operand.  D and A' remain the two-qty
   handout question; per the ladder law above, COUNT THE BLOCK'S QTYS FIRST (case 3 is the
   buggy arm, case 2 sorts correctly) -- that census is still the untaken step, and the
   instrumented cc1plus still ICEs on this TU (use ICE-blanking, 22D(1)).
   Probe file: scratchpad/W74_A11_cop.py.
   ==== W75-A9 re-gated (20 @1460/1460) and TOOK THE CENSUS STEP W72/W74 kept naming
   but never ran, plus gave the residual its honest metric.
   POSMIS (tools/posmis.py, the count-exact metric): 9 positional mismatches, not 20 --
   the LCS-20 is inflated (21E-3).  The nine, verbatim:
     A'  215 ours `lw a0,0(v0)` / retail `lw v0,0(v0)`; 217 `bnez a0` / `bnez v0`
     B   361 `lw v0,32(s1)` / `lw v1,32(s1)`; 363 `beq v0,a1` / `beq v1,a1`;
         364 ours NOP / retail `li v0,4`; 365 `beq v0,s2` / `beq v1,v0`
     D  1083 `slt v0,v0,v1` / `slt v1,v0,v1`; 1084 `beqz v0` / `beqz v1`
     E  1125 `bne v1,v0` / `bne v0,v1`
   So B is FOUR of the nine and is the only cluster with a structural component (retail
   materializes a fresh `li v0,4` in the beq delay slot; ours nops it and reuses $s2).
   THE QTY CENSUS IS NOW AVAILABLE, no ICE needed: the REAL CC1PLPSX prints -dl, and
   tools/copypref.py reads it directly --
     python tools/rtl_dump.py recon/game/common/aih_cop.cpp -dl
     python tools/copypref.py scratch/rtl/aih_cop.i.lreg "AIHigh_Cop::HighExecute"
   (a saved copy of that table is scratchpad/w75/A9_cop_qty.txt).  Headline facts for the
   next agent, which decide whether 14C applies at all: HighExecute has 104 local-alloc
   blocks and 61 of them carry <= 3 qtys, i.e. MOST of this function sits in local-alloc.c
   `case 3:`/`case 2:` territory -- count the qtys of the block you are pricing before
   quoting either arm.  copypref also flags where its own model and the compiler disagree
   (the `!!` rows); several of those are exactly the v0/v1 two-qty handouts of sites
   A'/C/D, so `--why <pseudo>` on them is the concrete next command.
   NOTHING LANDED THIS WAVE on this fn (budget went to the belt's other four); the census
   above plus posmis=9 is the deliverable.  Do not re-run site E's operand flip (three
   confirmations that it is worse) or the 20B clobber walk on A' (W74 closed it). ==== */
/* ==== W76-A1 2026-08-24 -- PASS 1460/1460, source-level only; no post-compile
   rewrite.  Temporary regressions above 30 diffs were allowed while crossing into
   the correct allocation basin; only this exact result is retained.
   A': bind reverseTrack to retail $v0 and reuse that dead value for the wrongWay
       selection.  The bnez delay slot can then overwrite rev in place with `nor`.
   B:  replace only the fresh inner mode load with `lw $v1,32($s1)`, then express
       the short circuit as nested ifs.  A block-local `$v0` modeFour assigned by
       plain C gives reorg the natural `li $v0,4` first-branch delay-slot filler.
       The NFSU2-mobile twin confirms the two independent mode guards semantically;
       its literal flattened shape is an 18-diff PSX basin, so the nested form is
       the necessary PSX compiler carrier.
   D:  assign the 0x471c7 comparison back into the now-dead speed local, reproducing
       retail's in-place `slt $v1,$v0,$v1` without asm.
   E:  a last-resort four-instruction source asm block preserves retail's `li/store`
       statement boundary and the two pinned loads ($v0 blockade level, $v1 target
       level); the equality branch remains compiler-generated as `bne $v0,$v1`.
   Detailed verify_asm PASS, slotcheck bad=0, full game/common regression clean. ==== */
/* NEAR-MISS 69 diffs, ours 1457 / oracle 1460 (W64-A12 re-gated; w63-a12 landed 77->69
   with the fenced boolean + the 09I volatile-on-the-test-read, both halves ablated and
   both load-bearing).  ONE named residual is now isolated and its cheapest angle is
   FALSIFIED, so the next agent can skip it:
   THE SITE: the two nested `(mode == 1) || (mode == 4)` tests on this->blockade_.mode
   (source ~line 814 outer / ~818 inner; oracle idx 348-353 and 361-365).  The OUTER test
   already matches byte-for-byte (`li a1,1` / `li s2,4` fresh).  At the INNER test retail
   RE-MATERIALIZES the 4 into a caller-saved temp *inside the branch delay slot*
   (`li v0,4; beq v1,v0`) while ours re-uses the callee-saved $s2 and nops the slot --
   that is one of the three missing instructions, and it also pins $s2 for the whole fn.
   FALSIFIED (each re-gated from the 69 baseline, all WORSE):
     inner test through a fresh named local `int m4 = 4;`            -> 81 @1457
     ... same + an opacity/identity fence on it                      -> 82 @1458
     inner test through a freshly re-read `blockadeMode_t mode1b`    -> 81 @1457
   Reading: naming the constant creates an allocno that LICM/cse parks somewhere, which
   costs more than the rematerialization buys (the same shape that failed on DoRearEnder
   before __builtin_abs retired the whole device there).  What retail has is TWO separate
   constant pseudos with cse declining to share across the intervening branch -- a cse
   constant-table question, so the lens is the -dl/-dg pair (or w64-a10 copypref.py) on
   the block pair, not another spelling.  The remaining ~64 diffs are the scattered
   caller-saved naming bands the w63 multidial program was working through. */

void AIHigh_Cop::HighExecute()



{
  (this->carObj_)->unlap = 0;

  (this->carObj_)->lap = 0;

  this->CheckSpikeBelt();

  this->CheckForWipeOut();

  this->SetTuningLevers();

  switch(this->stateType_) {

  case 0:
    {
    this->AssignToPlayer((AIHigh_Player *)0x0);

    (this->carObj_)->AIFlags = (this->carObj_)->AIFlags & 0xfffffffd;

    if (((this->carObj_)->carFlags & 0x400U) != 0) {
      /* Idle arm = oracle FALL-THROUGH (beqz jumps to the Purgatory arm) */
      AIState_Base *newState;

      AIState_Base *oldState;

      newState = operator new(0x10);

      (new(newState) AIState_Base(this->carObj_));

      newState->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

      newState[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      this->state_ = newState;

      this->stateType_ = (stateType_t)3;

      return;
    }

    {
      AIState_Base *newState;

      AIState_Base *oldState;

      AIState_Purgatory *p;

      p = operator new(8);

      newState = (AIState_Base *) (new(p) AIState_Purgatory(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      this->state_ = newState;

      this->stateType_ = (stateType_t)1;

      return;
    }
    }

  case 1:
    {
    blockadeMode_t mode;

    (this->carObj_)->AIFlags = (this->carObj_)->AIFlags & 0xfffffffd;

    mode = this->blockade_.mode;

    this->requestSpikeBeltAtSlice_ = -1;

    this->driveAway_ = 0;

    if (mode == 4) {

      this->blockade_.mode = 0;

    }

    {
    blockadeMode_t mode2;

    mode2 = this->blockade_.mode;

    if (mode2 == 2) {

      AIState_Base *newState;

      AIState_Base *oldState;

      this->AssignToPlayer(this->blockade_.target);

      newState = operator new(0x10);

      (new(newState) AIState_Base(this->carObj_));

      newState->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

      newState[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      {
        int rotation;

        rotation = this->blockade_.rotation;

        this->state_ = newState;

        this->stateType_ = (stateType_t)3;

        AILife_ReencarnateCopByLatPosAndRotation(this->carObj_,this->blockade_.slice
                   ,this->blockade_.direction,
                   this->blockade_.latPos,rotation);
      }

      this->requestSpikeBeltAtSlice_ = this->blockade_.requestSpikeBeltAtSlice;

    }

    else if ((((this->carObj_)->AIFlags & 8U) != 0) && (mode2 != 1))

    {

      trigger_t *pNewTrigger;

      pNewTrigger = this->CheckForNewTriggers();

      if (pNewTrigger != (trigger_t *)0x0) {

        int forceForwardTrigger;

        trigger_t newTrigger;

        forceForwardTrigger = 0;

        newTrigger = *pNewTrigger;

        if (Cars_gNumHumanRaceCars == 2) {

          int distanceMeters;

          distanceMeters = __builtin_abs(AIWorld_ApxSplineDistance(Cars_gHumanRaceCarList[0],Cars_gHumanRaceCarList[1]));

          if (distanceMeters < 0x12c0000) {

            forceForwardTrigger = 1;

          }

        }

        if (forceForwardTrigger) {

          int oldSlice;

          oldSlice = newTrigger.roadblock.slice;

          newTrigger.roadblock.type = 1;

          newTrigger.roadblock.spikeBelt = 1;

          newTrigger.roadblock.dir = 1;

          newTrigger.roadblock.numCars = 1;

          newTrigger.roadblock.slice = oldSlice;

        }

        triggerManagerCops->DescribeTrigger(&newTrigger);

        /* W61-A12: retail is NOT a switch here -- the oracle's test order
           (beq==1 -> body1 | slti<2 -> out | beq==2 -> out | bne!=3 -> out |
           fall -> body3) is byte-for-byte gcc-2.8's lowering of THIS nested
           if-chain (scratchpad/w61a12/swlab.c V10, CC1PLPSX-verified).  A
           3-case switch cannot produce it: balance_case_nodes (stmt.c:6059-6095)
           splits any 3-node list at the MIDDLE (root=2) and use_cost_table is 0
           here because estimate_case_costs rejects control-character case values
           (cost_table[1..3] < 0, stmt.c:5957-5960).  An `&&` chain folds the two
           guards away (swlab V12) -- they must be NESTED ifs.  84 -> 80 diffs. */
        if (newTrigger.roadblock.type != 1) {
          if (newTrigger.roadblock.type > 1) {
            if (newTrigger.roadblock.type != 2) {
              if (newTrigger.roadblock.type == 3) {
          {
          /* W83-A11 (PIN-REMOVAL BELT) -- W72-A11's note here described two zero-insn
             opacity fences; by the time of this edit the rev half had become a
             `register int rev asm("$2")` PIN (methodology 3.13 forbids those).  The pin
             is DEAD: `int rev` alone re-gates PASS 1460/1460 on its own and in the
             all-six-pins-removed candidate (W83-A11 step (b), cells A_rev_plain and
             base5).  Plain locals, no fence, no pin. */
          int rev = GameSetup_gData.reverseTrack;
          int dir = newTrigger.roadblock.dir;

          if (rev == 0) {

            rev = dir ^ 1;

          }
          else {

            rev = ~dir;

          }

          /* W61-A12 RESIDUAL ISLAND (5 of the fn's 61 diff insns).  Retail's SLD puts
             the reverseTrack select AND this test on ONE line (303) and emits
             `bnez G; nor(delay); xori; sltiu v0,v0,1; bnez v0 -> body` plus a RELOAD
             of roadblock.dir from the frame for the second operand; ours branches
             straight off the xori (`beqz`) and keeps dir in a register -- 2 insns
             shorter.  FALSIFIED spellings (standalone CC1PLPSX lab,
             scratchpad/w61a12/wlab*.c, all emit our `beq r,0` form): w == 0 / w <= 0
             / w < 1 / !w with w unsigned, the same with w signed, a materialized
             `int c = (w == 0)` temp, the if/else select instead of the
             default-then-override, and the ternary-inside-the-test one-liner.
             Only the BITWISE `|` form reproduces the sltiu -- but it materializes
             BOTH operands (no short circuit), which retail does not.  So the
             materialization comes from something structural on retail line 303 that
             the four natural spellings do not express.
             ==== W63-A12 (77 -> 69, ours 1455 -> 1457 / oracle 1460): THE ISLAND IS
             CLOSED STRUCTURALLY -- chunkdiff now reports ZERO mismatched runs >= 6 for
             the whole function (it was one 7-insn run here).  It took a PAIR, and each
             half is measured on the other's basin:
               baseline (neither)                                  77  @1455
               boolean materialized only                           78  @1456
               dir re-read forced only                             70  @1456
               BOTH                                                69  @1457
             (a) THE sltiu IS THE BOOLEAN AS A VALUE, and the device is the same one
                 that sealed CloseTargeting and DoRearEnder this session: an ASSIGNED
                 local plus a zero-insn OPACITY/IDENTITY fence
                 `__asm__("" : "=r"(x) : "0"(x))`.  W61-A12's lab list is NOT refuted --
                 a PLAIN `int c = (w == 0)` temp really does fold back to `beq r,0`;
                 what the lab never tried is the fenced form, which cse cannot collapse
                 into the branch.  (This is the third independent confirmation this
                 session that "named constant/boolean" and "named constant/boolean +
                 identity fence" are DIFFERENT levers -- do not read a falsified plain
                 temp as closing the axis.)
             (b) RETAIL RE-LOADS `roadblock.dir` FROM THE FRAME for the second `||`
                 operand (`lw v0,0x48(sp)`), which our cse shares out of the register
                 holding the first read.  `newTrigger` is an address-escaping local
                 (DescribeTrigger takes &newTrigger), so the honest device is the
                 09I volatile-on-the-TEST-read: `*(volatile int *)&newTrigger.roadblock.dir`.
                 Per the volatile-dial rule the alternatives are receipted above (every
                 non-volatile spelling of a second read is CSE'd by construction -- that
                 IS the diff) and the ablation table above shows the final authoritative
                 result needs it: dropping it costs 5 diffs.
             RESIDUAL 69 is now spread over the smaller islands B-F of the W62-A10
             census with NO run >= 6 insns anywhere; ours is still 3 insns short overall.
             Two shapes measured INERT here this session: hoisting the reverseTrack read
             into its own local ahead of the `~dir` (an attempt at retail's load order
             `lw reverseTrack; lw dir` vs ours `lw dir; lw reverseTrack; nop`) -- gcc
             reschedules to the same stream, 69 unchanged. ==== */
          int wrongWayHit;
          wrongWayHit = (rev == 0);
          __asm__("" : "=r"(wrongWayHit) : "0"(wrongWayHit));

          if (wrongWayHit || (*(int *)&newTrigger.roadblock.dir == 0)) {

            AIState_Offroad *newState;

            AIState_Base *oldState;

            this->AssignToPlayer((AIHigh_Player *)0x0);

            newState = operator new(0x68);

            newState = (new(newState) AIState_Offroad(this->carObj_,newTrigger.offroad.slice,
                                &newTrigger.offroad.position,&newTrigger.offroad.orientation,
                                newTrigger.offroad.maxSpeed,newTrigger.offroad.releaseTime,newTrigger.offroad.endSlice));

            oldState = this->state_;

            if (oldState != (AIState_Base *)0x0) {

              (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

            }

            this->state_ = (AIState_Base*)newState;

            this->stateType_ = (stateType_t)5;

            AILife_ReencarnateCopByPosition(this->carObj_,newTrigger.offroad.slice,1,
                       &newTrigger.offroad.position,&newTrigger.offroad.orientation);

          }
          }

              }
            }
          }
        } else {
          {
          int direction;

          randtemp = fastRandom * randSeed;

          fastRandom = randtemp & 0xffff;

          direction = -1;

          if (GameSetup_gData.reverseTrack == 0) {

            direction = 1;

          }

          if (newTrigger.roadblock.spikeBelt != 0) {
            /* Normal arm = oracle FALL-THROUGH */
            AIState_Base *newState;

            AIState_Base *oldState;

            AIState_Normal *p;

            this->AssignToPlayer((AIHigh_Player *)0x0);

            p = operator new(8);

            newState = (AIState_Base*)(new(p) AIState_Normal(this->carObj_));

            oldState = this->state_;

            if (oldState != (AIState_Base *)0x0) {

              (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

            }

            this->state_ = newState;

            this->stateType_ = (stateType_t)2;

          }

          else {

            AIState_Base *newState;

            AIState_Base *oldState;

            this->AssignToPlayer((AIHigh_Player *)0x0);

            newState = operator new(0x10);

            (new(newState) AIState_Base(this->carObj_));

            newState->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

            newState[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

            oldState = this->state_;

            if (oldState != (AIState_Base *)0x0) {

              (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

            }

            this->state_ = newState;

            this->stateType_ = (stateType_t)3;

          }

          AILife_ReencarnateCopBySlice(this->carObj_,newTrigger.roadblock.slice,direction,direction,
                     newTrigger.roadblock.spikeBelt);
          }

        }

      }

    }
    }

    goto stateExecuteAndReturn;
    }

  case 2:
    {
    /* MATCH (W83-A11) -- THREE COOPERATING CELLS, ALL NECESSARY, NO PINS.
       Retail re-materialises the `4` of the SECOND mode guard (`li $v0,4` in the
       `beq $v1,$a1` delay slot) while REUSING the `1` in $a1 and the earlier `4` in
       $s2.  Mechanism: gcc-2.8 cse.c `cse_end_of_basic_block` normally SKIPS the
       AIFlags block (the "AROUND" path, cse.c:8329 -- taken because the skip label
       has LABEL_NUSES==1 and no CODE_LABEL lies between), so its value table -- and
       with it the constant 4 -- survives into the second guard and cse canonicalises
       the second `4` onto $s2, leaving a bare `nop` in the slot.
         (a) BLOCK BOUNDARY: a dead `static void *... = &&label;` (jump.c:238 puts the
             label in forced_labels so it reaches cse as a real CODE_LABEL; zero
             instructions, 4 bytes of .sdata) breaks `no_labels_between_p` -> the cse
             block ENDS at the join -> both guards re-materialise their constants.
         (b) `one`: a NAMED 1 spanning both guards keeps that constant one GLOBAL
             pseudo in $a1 (untouched by the AIFlags block, which clobbers $v0/$v1/$a0)
             so reload_cse_regs deletes the re-materialised `li $a1,1` as a no-op set
             (catalog 29A-1) -- retail's `nop`.  Without it: FAIL 12.
         (c) `chaseState`: the 4 of the FIRST guard and of `stateType_ = STATE_CHASE`
             are ONE named local (retail's $s2 spans both, oracle 0x80064244 ->
             0x8006437C), and it must be ASSIGNED INSIDE this `if`, not decl-inited at
             case scope -- an early `li $s2,4` gets scheduled into the first guard's
             delay slot where retail has a `nop` (FAIL 1).  Without it: FAIL 30.
       Necessity grid (each cell dropped from the sealed body): boundary 10, `one` 12,
       `chaseState` 30, keeping the old `asm("$2")` pin 12.  DO NOT "SIMPLIFY". */
    blockadeMode_t mode;
    blockadeMode_t one;

    this->requestSpikeBeltAtSlice_ = -1;

    mode = this->blockade_.mode;

    one = (blockadeMode_t)1;

    if (mode != one) {

      stateType_t chaseState;
      chaseState = (stateType_t)4;

      if (mode != chaseState) {
        /* cell (a): zero-instruction cse-block boundary -- see the case head. */
        static void *aihCopFlagsBoundary_ = &&aih_cop_flagsGuard;

        (this->carObj_)->AIFlags = (this->carObj_)->AIFlags & 0xfffffffd;

      aih_cop_flagsGuard: ;
      }

      {
      /* W83-A11: the re-read of blockade_.mode was an `__asm__("lw %0,32(%1)")` with a
         `register ... asm("$3")` pin on its output.  With the (a) boundary in place the
         plain field re-read is emitted by itself (cse cannot carry the first load past
         the join either), so both the asm and the pin are gone and the invented `mode2`
         local -- which the SYM does not list for this block -- goes with them. */
      if (this->blockade_.mode != one) {

      if ((this->blockade_.mode != 4) && (this->CheckForNewTarget() != 0)) {

        coorddef pos;

        AIState_Chase *newState;

        AIState_Base *oldState;

        Car_tObj *carObj;

        Speaker *speaker;

        this->GetCheckChasePosition(&pos);

        newState = operator new(0x94);

        /* W57-A8: arg2 via the inline GetCarObj() accessor (NOT the raw ->carObj_
           field): the accessor form makes gcc evaluate the perpTarget deref EARLY
           into its own scratch like retail, instead of parking perpTarget_ in $a2
           across the whole 9-arg setup and dereferencing in place. Same edit at all
           three AIState_Chase construction sites: 168 -> 84 diffs. */
        newState = (new(newState) AIState_Chase(this->carObj_,
                             this->perpTarget_->GetCarObj(),&pos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[(int)GameSetup_gData.skill]));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

        }

        carObj = this->carObj_;

        this->state_ = (AIState_Base*)newState;

        this->stateType_ = chaseState;

        speaker = (Speaker *)Speech_Mobile(carObj);

        (**(int (**)(...))((char *)speaker->_vf + 52))
                  ((int)&(speaker->fPosition).flags + (int)*(short *)((char *)speaker->_vf + 48),
                   (this->perpTarget_)->carObj_);

      }
      }
      }

    }

    if ((this->forcePurgatory_ == 0) &&
       (AILife_EvaluateLife(this->carObj_) == 0))

    goto stateExecuteAndReturn;

    {
      AIState_Base *newState;

      AIState_Base *oldState;

      AIState_Purgatory *p;

      Car_tObj *carObj;

      Speaker *speaker;

      carObj = this->carObj_;

      this->forcePurgatory_ = 0;

      speaker = (Speaker *)Speech_Mobile(carObj);

      (**(int (**)(...))((char *)speaker->_vf + 132))
                ((int)&(speaker->fPosition).flags + (int)*(short *)((char *)speaker->_vf + 128));

      this->AssignToPlayer((AIHigh_Player *)0x0);

      p = operator new(8);

      newState = (AIState_Base *) (new(p) AIState_Purgatory(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      this->state_ = newState;

      this->stateType_ = (stateType_t)1;
    }

    goto stateExecuteAndReturn;
    }

  case 4:
    {
    AIState_Chase *chaseState;

    coorddef newPos;

    blockadeMode_t mode;

    {
      Car_tObj *carObj;

      carObj = this->carObj_;

      chaseState = (AIState_Chase *)this->state_;

      carObj->AIFlags = carObj->AIFlags | 2;
    }

    if (0xa0 < chaseState->barrierTicks32_) {

      int endSlice;

      AIState_GotoSlice *newState;

      AIState_Base *oldState;

      Car_tObj *carObj;

      Speaker *speaker;

      endSlice = (chaseState)->FindBarrierEndSlice();

      newState = operator new(0x10);

      newState = (new(newState) AIState_GotoSlice(this->carObj_,endSlice,0));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      carObj = this->carObj_;

      this->state_ = (AIState_Base *)newState;

      this->stateType_ = (stateType_t)9;

      speaker = (Speaker *)Speech_Mobile(carObj);

      (**(int (**)(...))((char *)speaker->_vf + 60))
                ((int)&(speaker->fPosition).flags + (int)*(short *)((char *)speaker->_vf + 56));

    }

    {
      int *copChasers;

      copChasers = ((this->perpTarget_->perpChaseInfo_).chaseLevel_)->copChasers +
                this->type_;

      if ((*copChasers == 0) && (copChasers[3] == 0)) {

        chaseState->nitrousTicks_ = 0;

      }
    }

    this->requestSpikeBeltAtSlice_ = -1;

    {
      int needy;

      needy = 0;

      if (simGlobal.gameTicks >= chaseState->slowDownEndTime_) {

        needy = this->CheckForNeedyPlayers() != -1;

      }

      if (needy) {

        /* SYM-OPTIMIZED: slowDownEndTime -- the inlined AIState_Chase setter's
           parameter is the gameTicks-plus-delay value stored directly below. */
        chaseState->slowDownEndTime_ = simGlobal.gameTicks + 0x3c0;

      }
    }

    this->HandleBlockadeSpeech();

    {
      int retarget;

      retarget = 0;

      if (this->GetCheckChasePosition(&newPos) != 0) {

        retarget = chaseState->murderMode_ == 0;

      }

      if (retarget) {

        (chaseState)->SetTarget((this->perpTarget_)->carObj_,&newPos);

      }
    }

    {
      int minTimeInZone;

      int minLatMetersDistance;

      int minLongMetersDistance;

      int murder;

      minTimeInZone = AIHigh_Cop_AggressionData[this->aggressionLevel_].ticksInChaseRegionForMurder;

      minLatMetersDistance = AIHigh_Cop_AggressionData[this->aggressionLevel_].minLatMetersDistanceForMurder;

      minLongMetersDistance = AIHigh_Cop_AggressionData[this->aggressionLevel_].minLongMetersDistanceForMurder;

      murder = 0;

      if (minTimeInZone < chaseState->inTargetRegion_) {

        int meters;

        meters = __builtin_abs(chaseState->latMetersBetween_);

        if (meters < minLatMetersDistance) {

          meters = __builtin_abs(chaseState->longMetersBetween_);

          murder = meters < minLongMetersDistance;

        }

      }

      if (murder) {

        (chaseState)->SetMurderMode(1,AIHigh_Cop_AggressionData[this->aggressionLevel_].murderTicks);

      }
    }

    {
      int cutOff;

      cutOff = 0;

      if (((AIHigh_BasicCop *)this)->ShouldIPerformCutOffBlock(0x4000,
                          (this->perpTarget_)->carObj_) != 0) {

        cutOff = chaseState->murderMode_ == 0;

      }

      if (cutOff) {

        coorddef zero;

        memset((u_char *)&zero,'\0',0xc);

        (chaseState)->SetTarget((this->perpTarget_)->carObj_,&zero);

        (chaseState)->SetMurderMode(1,0x20);

      }
    }

    if (this->CheckForNewTarget() != 0) {

      coorddef pos;

      this->GetCheckChasePosition(&pos);

      (chaseState)->SetTarget((this->perpTarget_)->carObj_,&pos);

    }

    mode = this->blockade_.mode;

    if ((((mode == 1) || (mode == 4)) || (this->perpTarget_ == (AIHigh_Player *)0x0)) ||

            (1 < (((this->perpTarget_)->carObj_)->stats).finishType)) {

      if ((mode == 1) || (mode == 4)) {

        Car_tObj *carObj;

        int direction;

        direction = 1;

        carObj = this->carObj_;

        if (GameSetup_gData.reverseTrack == 0) {

          direction = -1;

        }

        carObj->desiredDirection = direction;

        (this->carObj_)->driveDirection = 1;

      }

      {
        AIState_Base *newState;

        AIState_Base *oldState;

        AIState_Normal *p;

        this->AssignToPlayer((AIHigh_Player *)0x0);

        p = operator new(8);

        newState = (AIState_Base*)(new(p) AIState_Normal(this->carObj_));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

        }

        this->state_ = newState;

        this->stateType_ = (stateType_t)2;
      }

    }

    if ((this->forcePurgatory_ != 0) ||
       (AILife_EvaluateLife(this->carObj_) != 0)) {

    if ((AILife_EvaluateLife(this->carObj_) != 0) && (this->driveAway_ == 0)) {

      Speaker *speaker;

      speaker = (Speaker *)Speech_Mobile(this->carObj_);

      (**(int (**)(...))((char *)speaker->_vf + 60))
                ((int)&(speaker->fPosition).flags + (int)*(short *)((char *)speaker->_vf + 56));

    }

    {
      AIState_Base *newState;

      AIState_Base *oldState;

      AIState_Purgatory *p;

      Speaker *speaker;

      speaker = (Speaker *)Speech_Mobile(this->carObj_);

      (**(int (**)(...))((char *)speaker->_vf + 132))
                ((int)&(speaker->fPosition).flags + (int)*(short *)((char *)speaker->_vf + 128));

      this->forcePurgatory_ = 0;

      this->AssignToPlayer((AIHigh_Player *)0x0);

      p = operator new(8);

      newState = (AIState_Base *) (new(p) AIState_Purgatory(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      this->state_ = newState;

      this->stateType_ = (stateType_t)1;
    }

    goto stateExecuteAndReturn;

    }

    if (this->driveAway_ == 0) goto stateExecuteAndReturn;

    goto LAB_80064a0c;
    }

  case 3:
    {
    blockadeMode_t mode;

    mode = this->blockade_.mode;

    if ((mode == 1) || (mode == 4)) {

      {
        int direction;

        Car_tObj *carObj;

        direction = 1;

        carObj = this->carObj_;

        if (GameSetup_gData.reverseTrack == 0) {

          direction = -1;

        }

        carObj->desiredDirection = direction;

        (this->carObj_)->driveDirection = 1;
      }

      {
        AIState_Base *newState;

        AIState_Base *oldState;

        AIState_Normal *p;

        this->AssignToPlayer((AIHigh_Player *)0x0);

        p = operator new(8);

        newState = (AIState_Base*)(new(p) AIState_Normal(this->carObj_));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

        }

        this->state_ = newState;

        this->stateType_ = (stateType_t)2;
      }

    }

    if (this->forcePurgatory_ != 0) {

      AIState_Base *newState;

      AIState_Base *oldState;

      AIState_Purgatory *p;

      Car_tObj *carObj;

      Speaker *speaker;

      carObj = this->carObj_;

      this->forcePurgatory_ = 0;

      speaker = (Speaker *)Speech_Mobile(carObj);

      (**(int (**)(...))((char *)speaker->_vf + 132))
                ((int)&(speaker->fPosition).flags + (int)*(short *)((char *)speaker->_vf + 128));

      this->AssignToPlayer((AIHigh_Player *)0x0);

      p = operator new(8);

      newState = (AIState_Base *) (new(p) AIState_Purgatory(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      this->state_ = newState;

      this->stateType_ = (stateType_t)1;

      goto stateExecuteAndReturn;

    }

    if (this->driveAway_ != 0) {

LAB_80064a0c:

      {
        AIState_Base *newState;

        AIState_Base *oldState;

        AIState_Normal *p;

        AIHigh_tDriveAwayMode driveAway;

        {
          Car_tObj *carObj;

          int direction;

          direction = 1;

          carObj = this->carObj_;

          if (GameSetup_gData.reverseTrack == 0) {

            direction = -1;

          }

          carObj->desiredDirection = direction;

          (this->carObj_)->driveDirection = 1;
        }

        this->AssignToPlayer((AIHigh_Player *)0x0);

        p = operator new(8);

        newState = (AIState_Base*)(new(p) AIState_Normal(this->carObj_));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

        }

        driveAway = this->driveAway_;

        this->state_ = newState;

        this->stateType_ = (stateType_t)2;

        if (driveAway == 1) {

          Cars_ResetCollidedCars(this->carObj_,1,1);

        }

        this->driveAway_ = 0;

        goto stateExecuteAndReturn;
      }

    }

    {
    blockadeMode_t mode2;

    mode2 = this->blockade_.mode;

    if (mode2 == 2) {

      coorddef newPos;

      int rbDistanceMeters;

      int rbAbsDistanceMeters;

      int release;

      /* 🔴 W72-A11 -- ZERO-INSN OPACITY FENCE on the POINTER, DO NOT "SIMPLIFY": it stops
         cse proving `co == this->carObj_`, which flips retail's ptr->$v1 / value->$v0
         handout for this RMW (38 -> 26; the un-fenced named pointer is inert, and fencing
         the VALUE instead is inert). */
      { Car_tObj *co = this->carObj_;
        __asm__("" : "=r"(co) : "0"(co));
        co->AIFlags = co->AIFlags | 2; }

      {
        int requestSlice;

        requestSlice = this->requestSpikeBeltAtSlice_;

        release = 0;

        if ((requestSlice != -1) && (AICop_spikeBelt.active_ == 0)) {

          int size;

          int left;

          int right;

          /* W61-A12: test INVERTED (was `skill == 0` first).  Retail puts the
             0xb333 arm in its own block AFTER the else arm and reaches it by the
             beqz, with the else arm ending `j <merge>; li s0,0xcccc` -- our
             then-first form let reorg sink `li s0,0xb333` into the beqz delay slot
             and fall through, 1 insn short.  Inverting the arms reproduces retail's
             block order exactly.  80 -> 77 diffs (fn is 84 -> 77 with the trigger
             if-chain above). */
          if (GameSetup_gData.skill != 0) {

            size = 0xe666;

            if (GameSetup_gData.skill == 1) {

              size = 0xcccc;

            }

          }

          else {

            size = 0xb333;

          }

          left = fixedmult((*(u_char *)(this->requestSpikeBeltAtSlice_ * 0x20 + (int)BWorldSm_slices + 0x1e) << 15) *
                             (*(u_char *)(this->requestSpikeBeltAtSlice_ * 0x20 + (int)BWorldSm_slices + 0x1d) >> 4),size);

          right = fixedmult((*(u_char *)(this->requestSpikeBeltAtSlice_ * 0x20 + (int)BWorldSm_slices + 0x1f) << 15) *
                             (*(u_char *)(this->requestSpikeBeltAtSlice_ * 0x20 + (int)BWorldSm_slices + 0x1d) & 0xf),size);

          /* MATCH (W71-A19, 55->41): retail loads this->requestSpikeBeltAtSlice_
             EARLY in this store block (oracle idx 948 `lw t0,0x64(s1)`, right after
             the &AICop_spikeBelt addiu and BEFORE the D_8011E0B0 %hi) -- sched1's
             ready-list tie follows source luid order (16C).  Writing the slice_
             store FIRST gives that load the earlier luid; gcc reschedules the four
             STORES back to retail's 8/12/0/4/16 order for free, and the whole
             t0/a3/a2 band falls in with it.  (An invented `int reqSlice` read at
             the top of the block measures the same 41 -- prefer the store order,
             the SYM lists no such local.) */
          AICop_spikeBelt.slice_ = this->requestSpikeBeltAtSlice_;

          AICop_spikeBelt.leftLatPos_ = -left;

          AICop_spikeBelt.rightLatPos_ = right;

          AICop_spikeBelt.active_ = 1;

          /* SYM-OPTIMIZED: timeNow -- the inlined spike-belt freshen operation
             names this direct gameTicks value; it has no separate caller slot. */
          AICop_spikeBelt.freshenTime_ = D_8011E0B0[0];

          /* SYM-OPTIMIZED: slice -- BWorld_SetSpikeBelt's inlined slice
             parameter aliases requestSpikeBeltAtSlice_ at this call site.
             SYM-OPTIMIZED: rightLatPos -- its inlined third parameter aliases
             the caller's exact `right` local in the sum below. */
          BWorld_SetSpikeBelt(this->requestSpikeBeltAtSlice_,-left,
                     left + right);

          requestSlice = this->requestSpikeBeltAtSlice_;

        }

        AICop_gRoadBlockState = kAICop_RoadBlockState_WaitingForPerp;

        if ((requestSlice != -1) && (AICop_spikeBelt.slice_ == requestSlice)) {

          AICop_spikeBelt.freshenTime_ = D_8011E0B0[0];

        }
      }

      if (this->blockade_.flags != 0) {

        if (stackSpeedUpEnbabledFlag != 0) {

          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 0;

          this->SetupBlockadeElements(&this->blockade_);

          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 1;

        }

        else {

          this->SetupBlockadeElements(&this->blockade_);

        }

      }

      {
        AIHigh_Player *perp;

        AICop_PerpChaseInfo *chaseInfo;

        int engagement;

        int perTick;

        int factor;

        perp = this->perpTarget_;

        chaseInfo = &perp->perpChaseInfo_;

        engagement = (chaseInfo->chaseLevel_)->engagementLapFraction *
                 AITune_gRoughLapTime;

        if (engagement < 0) {

          engagement = engagement + 0xffff;

        }

        perTick = 0x10000 / ((engagement >> 0x10) << 5);

        chaseInfo->engagementTime_ = (engagement >> 0x10) << 0x15;

        chaseInfo->engagementPercentIncreasePerTick_ = perTick;

        if (GameSetup_gData.numLaps == 2) {

          factor = 0x13333;

        }

        else if (GameSetup_gData.numLaps == 4) {

          factor = 0xa8f5;

        }

        else goto LAB_80064d34;

        chaseInfo->engagementPercentIncreasePerTick_ = fixedmult(perTick,factor);

LAB_80064d34:;
      }

      this->GetCheckChasePosition(&newPos);

      rbDistanceMeters = AIWorld_ApxSplineDistance(this->carObj_,
                         (this->perpTarget_)->carObj_);

      rbAbsDistanceMeters = __builtin_abs(rbDistanceMeters);

      if (0x31ffff < rbAbsDistanceMeters) {

        if (rbAbsDistanceMeters < 0x12c0000) {

          int speed;

          int timeToRB;

          speed = ((this->perpTarget_)->carObj_)->currentSpeed;

          if (speed < 1) {

            speed = -speed;

          }

          speed = 0x471c7 < speed;

          if ((speed &&

              /* MATCH (W71-A19, 69->55): retail RE-DERIVES the whole chain here
                 (oracle 0x80064DBC-DCC `lw v0,0x58(s1); lw v0,0(v0); lw a1,0x564(v0)`)
                 while our cse keeps the carObj_ pointer live across the abs branch and
                 re-loads only the field (`lw a1,1380(a1)`) -- 4 insns short + a band
                 shift.  A volatile view on the perpTarget_ READ defeats the ADDRESS-CSE
                 (w22-a10 / 05E) and restores retail's fresh chain.  Measured, each
                 re-gated from 69: volatile on carObj_ alone 67; on the field alone 69
                 (inert); on perpTarget_ 55; on both links 55; both reads volatile 55.
                 Non-volatile alternatives are strictly worse: identity-launder of a
                 fresh `AIHigh_Player *pt` copy 65 (in- or out-of-chain), read-only
                 fence on `this` 69 (inert), nested-ifs / block-scoped pointer locals
                 for either read 69 (all inert). */
              (timeToRB = fixeddiv(rbDistanceMeters,
                   (*(AIHigh_Player *volatile *)&this->perpTarget_)->carObj_->currentSpeed),
                   0 < timeToRB)) &&

             (timeToRB < this->blockade_.releaseTime)) {

            release = 1;

          }

        }

      }

      else {

        release = 1;

      }

      if (!release) {

        int distance;

        distance = AIWorld_ApxSplineDistance((this->perpTarget_)->carObj_,
                            this->blockade_.slice);

        if (distance < 0) {

          distance = distance + 0xffff;

        }

        if (this->blockade_.initialPlayerDistanceMetersInt * (distance >> 0x10) <

            1) goto stateExecuteAndReturn;

      }

      /* MATCH (W83-A11): this was a 4-instruction `__asm__ volatile` block with THREE
         `register ... asm("$N")` pins ($4/$2/$3) standing in for plain field access.
         Pure C reproduces it exactly -- but the STATEMENT ORDER is load-bearing: the
         -1 store first, then the chaseLevelIndex_ read, then the chaseLevel read.
         Measured on the pinned base: this order PASS 1460; blockLevel-before-
         targetLevel FAIL 8; both reads as decl-inits ahead of the store FAIL 12. */
      AIHigh_Player *chaseTarget = this->perpTarget_;
      int blockLevel;
      int targetLevel;

      this->requestSpikeBeltAtSlice_ = -1;
      targetLevel = chaseTarget->perpChaseInfo_.chaseLevelIndex_;
      blockLevel = this->blockade_.chaseLevel;

      if (blockLevel == targetLevel) {

        (chaseTarget->perpChaseInfo_).engagementTime_ = 0;

      }

      this->blockade_.mode = 0;

      {
        AIState_Chase *newState;

        AIState_Base *oldState;

        int reverse;

        newState = operator new(0x94);

        newState = (new(newState) AIState_Chase(this->carObj_,
                             this->perpTarget_->GetCarObj(),&newPos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[(int)GameSetup_gData.skill]));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

        }

        reverse = this->blockade_.reverse;

        this->state_ = (AIState_Base*)newState;

        this->stateType_ = (stateType_t)4;

        if (reverse != 0) {

          AIPhysic_ChangeDirection(this->carObj_,0x40);

        }
      }

      goto stateExecuteAndReturn;

    }

    else {

      (this->carObj_)->AIFlags = (this->carObj_)->AIFlags & 0xfffffffd;

      if (this->CheckForNewTarget() != 0) {

      blockadeMode_t mode3;

      mode3 = this->blockade_.mode;

      if ((mode3 != 1) && (mode3 != 4)) {

        coorddef pos;

        AIState_Chase *newState;

        AIState_Base *oldState;

        Car_tObj *carObj;

        Speaker *speaker;

        this->GetCheckChasePosition(&pos);

        newState = operator new(0x94);

        newState = (new(newState) AIState_Chase(this->carObj_,
                             this->perpTarget_->GetCarObj(),&pos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[(int)GameSetup_gData.skill]));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

        }

        carObj = this->carObj_;

        this->state_ = (AIState_Base*)newState;

        this->stateType_ = (stateType_t)4;

        speaker = (Speaker *)Speech_Mobile(carObj);

        (**(int (**)(...))((char *)speaker->_vf + 52))
                  ((int)&(speaker->fPosition).flags + (int)*(short *)((char *)speaker->_vf + 48),
                   (this->perpTarget_)->carObj_);

        goto stateExecuteAndReturn;

      }

      }

      if (AILife_EvaluateLife(this->carObj_) == 0) goto stateExecuteAndReturn;

      {
        AIState_Base *newState;

        AIState_Base *oldState;

        AIState_Purgatory *p;

        this->AssignToPlayer((AIHigh_Player *)0x0);

        p = operator new(8);

        newState = (AIState_Base *) (new(p) AIState_Purgatory(this->carObj_));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

        }

        this->state_ = newState;

        this->stateType_ = (stateType_t)1;
      }

      goto stateExecuteAndReturn;

    }
    }
    }

  case 5:
    {
    int hLoop;

    {
      Car_tObj *carObj;

      carObj = this->carObj_;

      if ((carObj->N).simOptz == '\0') {

        carObj->extraWallCollisionAllowance = 0;

      }

      else {

        carObj->extraWallCollisionAllowance = 0x18000;

      }
    }

    this->requestSpikeBeltAtSlice_ = -1;

    hLoop = 0;

    while (true) {

      if (Cars_gNumRaceCars <= hLoop) break;

      {
        Car_tObj *thisPlayerObj;
        AIHigh_Player *thisPlayer;

        thisPlayerObj = Cars_gRaceCarList[hLoop];
        thisPlayer = (AIHigh_Player *)highLevelAIObjs[thisPlayerObj->carIndex];

        if (thisPlayer->basicPerpInfo_.crime_ != 0) {

          ((AIState_Offroad *)this->state_)->UnleashIfInRange(thisPlayerObj);

        }
      }

      hLoop = hLoop + 1;

    }

    {
      Car_tObj *carObj;

      int slices;

      carObj = this->carObj_;

      slices = (carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices;

      if (((int)-((*(u_char *)(slices + 0x1e) << 15) * (*(u_char *)(slices + 0x1d) >> 4)) <=

           carObj->roadPosition) &&

         (carObj->roadPosition <=

          (*(u_char *)(slices + 0x1f) << 15) * (*(u_char *)(slices + 0x1d) & 0xf))) {

        AIState_Base *newState;

        AIState_Base *oldState;

        AIState_Normal *p;

        carObj->extraWallCollisionAllowance = 0;

        this->AssignToPlayer((AIHigh_Player *)0x0);

        p = operator new(8);

        newState = (AIState_Base*)(new(p) AIState_Normal(this->carObj_));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

        }

        this->state_ = newState;

        this->stateType_ = (stateType_t)2;

      }
    }

    if ((this->forcePurgatory_ == 0) &&
       (AILife_EvaluateLife(this->carObj_) == 0))

    goto stateExecuteAndReturn;

    {
      AIState_Base *newState;

      AIState_Base *oldState;

      AIState_Purgatory *p;

      (this->carObj_)->extraWallCollisionAllowance = 0;

      this->forcePurgatory_ = 0;

      this->AssignToPlayer((AIHigh_Player *)0x0);

      p = operator new(8);

      newState = (AIState_Base *) (new(p) AIState_Purgatory(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      this->state_ = newState;

      this->stateType_ = (stateType_t)1;
    }

    goto stateExecuteAndReturn;
    }

  case 6:

  case 7:

  case 8:

  case 10:

  default:

    goto stateExecuteAndReturn;

  case 9:
    {
    AIState_GotoSlice *gotoState;

    AIState_Base *newState;

    AIState_Base *oldState;

    AIState_Normal *p;

    gotoState = (AIState_GotoSlice *)this->state_;

    this->AssignToPlayer((AIHigh_Player *)0x0);

    if ((gotoState)->InTargetSliceRange(0xa0000) == 0) goto stateExecuteAndReturn;

    p = operator new(8);

    newState = (AIState_Base*)(new(p) AIState_Normal(this->carObj_));

    oldState = this->state_;

    if (oldState != (AIState_Base *)0x0) {

      (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

    }

    this->state_ = newState;

    this->stateType_ = (stateType_t)2;
    }

  }

stateExecuteAndReturn:

  (this->state_)->StateExecute()

  ;

  return;

}








/* ---- CheckForNeedyPlayers__10AIHigh_Cop  AIHigh_Cop::CheckForNeedyPlayers  [AIH_COP.CPP:819-835] SLD-VERIFIED ---- */

int AIHigh_Cop::CheckForNeedyPlayers()



{
  /* SYM-OPTIMIZED: thisPlayer -- retail keeps the named AIHigh_Player value in
   * the indexed highLevelAIObjs expression; no distinct source carrier remains. */
  int needy;

  int hLoop;

  Car_tObj *thisPlayerObj;

  needy = -1;

  hLoop = 0;

  while (true) {

    if (Cars_gNumHumanRaceCars <= hLoop) break;

    thisPlayerObj = Cars_gHumanRaceCarList[hLoop];

    if (800 < (int)highLevelAIObjs[thisPlayerObj->carIndex][7].state_) {

      if (0x140000 < __builtin_abs(thisPlayerObj->currentSpeed)) {

        needy = thisPlayerObj->carIndex;

      }

    }

    hLoop = hLoop + 1;

  }

  return needy;

}








/* ---- CheckForWipeOut__10AIHigh_Cop  AIHigh_Cop::CheckForWipeOut  [AIH_COP.CPP:845-885] SLD-VERIFIED ---- */

void AIHigh_Cop::CheckForWipeOut()



{
  int perTickProb;

  int randVal;

  int thisTargetLevel;

  bool bVar1;

  int iVar2;

  AIHigh_Player *pAVar3;

  

  if (this->stateType_ != 4) {

    return;

  }

  pAVar3 = this->perpTarget_;

  bVar1 = false;

  if (pAVar3 != (AIHigh_Player *)0x0) {

    if ((((pAVar3)->carObj_)->carFlags & 8U) != 0) {

      /* W57-A8 08E: operand order is the load order -- `gameTicks >= wipeOutEndTick`
         (gameTicks FIRST) makes gcc schedule the D_8011E0B0 load into the load-delay
         gap after `lw carObj_`; the `wipeOutEndTick <= gameTicks` spelling emits a nop
         there instead and rotated the whole a0/a1 band. 25 -> PASS. */
      if (D_8011E0B0[0] >= (this->carObj_)->wipeOutEndTick) {

        iVar2 = (pAVar3->perpChaseInfo_).engagementTime_;

        if (iVar2 < 0) {

          iVar2 = iVar2 + 0xffff;

        }

        if (iVar2 >> 0x10 < 2) goto LAB_800654b8;

      }

    }

  }

  bVar1 = true;

LAB_800654b8:

  if (!bVar1) {
    /* W57-A8 05A: SLD statement map -- 861 = the RAND() statement, 865 = the whole `for`
       (its preheader owns every LICM-hoisted insn: the highLevelAIObjs/simGlobal base
       materializations, the AI_elapsedTime load, Cars_gNumHumanRaceCars, the perpTarget_
       re-read + thisTargetLevel load, and 5 of the 6 insns of `AI_elapsedTime * 89`),
       867/868 = the two list lookups, 877 = the paired guard (the multiply's LAST insn
       `addu $v1,$t1,$a2` lands in its delay slot), 879 = the store, 884 = the bump. */
    int hLoop;

    randtemp = fastRandom * randSeed;

    randVal = (int)((randtemp >> 8) & 0xffff);

    fastRandom = randtemp & 0xffff;

    thisTargetLevel = (this->perpTarget_->perpChaseInfo_).chaseLevelIndex_;

    hLoop = 0;

    while (true) {

      if (Cars_gNumHumanRaceCars <= hLoop) break;

      Car_tObj *thisPlayerObj;

      AIHigh_Player *thisPlayer;

      thisPlayerObj = Cars_gHumanRaceCarList[hLoop];

      thisPlayer = (AIHigh_Player *)highLevelAIObjs[thisPlayerObj->carIndex];

      perTickProb = AI_elapsedTime * 89;

      if (thisTargetLevel < (thisPlayer->perpChaseInfo_).chaseLevelIndex_) {

        if (randVal < perTickProb) {

          (this->carObj_)->wipeOutEndTick = simGlobal.gameTicks + 0x280;

        }

      }

      hLoop = hLoop + 1;

    }

  }

  return;

}








/* ---- CheckForNewTarget__10AIHigh_Cop  AIHigh_Cop::CheckForNewTarget  [AIH_COP.CPP:891-968] SLD-VERIFIED ---- */

int AIHigh_Cop::CheckForNewTarget()



{
  bool bVar1;
  blockadeMode_t bVar3;

  AIHigh_Player *newTarget;
  int newTargetDistance;
  int playerLoop;
  AIHigh_Player *old;

  

  newTarget = (AIHigh_Player *)0x0;

  newTargetDistance = 0x27100000;

  bVar3 = this->blockade_.mode;

  old = this->perpTarget_;

  bVar1 = false;

  if (((bVar3 == 1) || (bVar3 == 4)) || (bVar3 == 2)) {

    bVar1 = true;

  }

  if (bVar1) {

    return 0;

  }

  playerLoop = 0;

  while (true) {

    int thisCarIndex;
    AIHigh_Player *thisPlayer;
    int needs;
    int got;

    if (Cars_gNumRaceCars <= playerLoop) break;

    thisCarIndex = Cars_gRaceCarList[playerLoop]->carIndex;
    thisPlayer = (AIHigh_Player *)highLevelAIObjs[thisCarIndex];

    needs = 0;

    if (thisPlayer->basicPerpInfo_.crime_ != 0) {

      needs = thisPlayer->perpChaseInfo_.chaseLevel_->copChasers[this->type_];

    }

    {
      copType type = (copType)this->type_;
      got = thisPlayer->basicPerpInfo_.copsAssigned_[type];
    }

    if ((this->perpTarget_ != (AIHigh_Player *)0x0) &&
        (this->perpTarget_ == thisPlayer)) {

      got = got + -1;

    }

    if (got < needs) {

      int copToTargetDistanceMeters;

      copToTargetDistanceMeters = AIWorld_ApxSplineDistance(this->carObj_,

                         thisPlayer->carObj_);

      copToTargetDistanceMeters = __builtin_abs(copToTargetDistanceMeters);

      if (copToTargetDistanceMeters < newTargetDistance) {

        newTargetDistance = copToTargetDistanceMeters;

        newTarget = thisPlayer;

      }

    }

    playerLoop = playerLoop + 1;

  }

  playerLoop = 0;

  if (newTarget == (AIHigh_Player *)0x0) {

    while (true) {

      int thisCarIndex;
      AIHigh_Player *thisPlayer;
      int copToTargetDistanceMeters;

      if (Cars_gNumRaceCars <= playerLoop) break;

      thisCarIndex = Cars_gRaceCarList[playerLoop]->carIndex;
      thisPlayer = (AIHigh_Player *)highLevelAIObjs[thisCarIndex];

      copToTargetDistanceMeters = AIWorld_ApxSplineDistance(this->carObj_,

                         thisPlayer->carObj_);

      copToTargetDistanceMeters = __builtin_abs(copToTargetDistanceMeters);

      if ((copToTargetDistanceMeters < newTargetDistance) &&
          (thisPlayer->basicPerpInfo_.crime_ != 0)) {

        newTargetDistance = copToTargetDistanceMeters;

        newTarget = thisPlayer;

      }

      playerLoop = playerLoop + 1;

    }

    if (newTarget == (AIHigh_Player *)0x0) goto LAB_800657c0;

  }

  if (newTarget != old) {

    this->AssignToPlayer(newTarget);

    this->aggressionLevel_ =

         ((newTarget->perpChaseInfo_).chaseLevel_)->copAggression[this->type_];

    return 1;

  }

LAB_800657c0:

  if ((old != (AIHigh_Player *)0x0) &&
      (newTarget == (AIHigh_Player *)0x0)) {

    this->AssignToPlayer((AIHigh_Player *)0x0);

  }

  return 0;

}








/* ---- AssignToPlayer__10AIHigh_CopP13AIHigh_Player  AIHigh_Cop::AssignToPlayer  [AIH_COP.CPP:975-989] SLD-VERIFIED ---- */

void AIHigh_Cop::AssignToPlayer(AIHigh_Player *target)



{

  if (this->perpTarget_ != (AIHigh_Player *)0x0) {

    ((AIHigh_BasicPerp *)this->perpTarget_)->RemoveChaser(this->copIndex_,

               (this->carObj_)->carIndex,(copType)this->type_

              );

  }

  if ((target == (AIHigh_Player *)0x0) && (this->blockade_.mode != 1)) {

    this->blockade_.mode = 0;

  }

  this->perpTarget_ = target;

  if (target != (AIHigh_Player *)0x0) {

    ((AIHigh_BasicPerp *)target)->AddChaser(this->copIndex_,

               (this->carObj_)->carIndex,(copType)this->type_

              );

  }

  return;

}








/* ---- GetCheckChasePosition__10AIHigh_CopP8coorddef  AIHigh_Cop::GetCheckChasePosition  [AIH_COP.CPP:995-1014] SLD-VERIFIED ---- */

int AIHigh_Cop::GetCheckChasePosition(coorddef *pos)



{
  int changed;

  int newPosition;



  changed = 0;

  newPosition = ((AIHigh_BasicPerp *)this->perpTarget_)->CheckChaserPosition(this->copIndex_,

                     (this->carObj_)->carIndex);

  if (newPosition != this->chaseIndex_) {

    changed = 1;

    this->chaseIndex_ = newPosition;

  }

  /* H23: per-aggression stride is 72B = one [6] row (oracle 0x800658F0 aggressionLevel_*72);
     whole-struct copy (matches oracle's 3-word block load/store), NOT field-by-field. */
  *pos = AIH_Cop_chasePositions[this->aggressionLevel_][this->chaseIndex_];

  return (u_int)changed;

}








static inline copLevel_t *AIHigh_Player_ChaseLevel(AIHigh_Player *player)
{
  return *(copLevel_t * volatile *)&player->perpChaseInfo_.chaseLevel_;
}

static inline int AIHigh_Player_LastPullOverTime(AIHigh_Player *player)
{
  return player->lastPullOverTime_;
}

/* ---- CheckForNewTriggers__10AIHigh_Cop  AIHigh_Cop::CheckForNewTriggers  [AIH_COP.CPP:1021-1166] SLD-VERIFIED ---- */

trigger_t * AIHigh_Cop::CheckForNewTriggers()
{
  /* W57-A8 05A/06A rewrite: SYM 8c local set (sortedLoop=$30 testCar=$21 dir=$3
     thisPlayer=$16 needs=$4 got=AUTO-44 pLevel=$6 thisSlice=$3 startSlice=$4
     endSlice=$20 fRandomChance=$18 | newSlice=$3 temp=$5 sliceLoop=$17
     triggerHere=$19 iRandomChance=$18 randomValue=$16 unused=AUTO-48), statements
     in SLD order (1034/1041/1043/1044/1047/1060/1066/1069/1073/1084/1087/1093/
     1097/1100/1102/1115/1120/1122/1123/1138/1145/1152/1163/1165/1166).
     REAL BUG FIXED: fRandomChance is thisPlayer->newTriggerProb_ (+0x84) and the
     gate is basicPerpInfo_.crime_ (+0x78) -- the prior recon had the two SWAPPED
     (it doubled perpInfo[2] and gated on +0x84).
     2026-08-12 FORK/SLD RECEIPT: the SYM's nested AIHigh_Player scopes were
     real inline accessors.  Reconstructing the chase-level and last-pull-over
     accessors creates the retail a1->a2 copy and the later a3 simGlobal base.
     The decisive final lever is a paired volatile read on the chase-level
     pointer and cop type.  Either volatile read alone is score-neutral at 4
     diffs; together they give sched2 the retail load priority/order, preserve
     the a1->a2 copy in its retail slot, and produce byte-exact PASS (202/202).
     No empty-asm scheduling boundaries or register pins remain in this block.
     Authoritative progression: 29 -> 15 -> 9 -> 8 -> 2 -> PASS.  Falsified
     follow-ups: raw/pLevel identity 14, empty-loop boundary 5/10, accessor
     wrapper 16/19, pointer keepalive 8, and tied-output fences 7/51. */
  int sortedLoop;
  int numCars;
  Car_tObj *testCar;
  int initialGameTicks;
  Sim_tSimGlobalVar *pSimGlobalInitial = &simGlobal;   /* oracle materializes &simGlobal as a
                              value (lui/addiu + disp-4 load) at BOTH sites, not the
                              folded lui/%lo(simGlobal+4) a direct member access gives */
  initialGameTicks = pSimGlobalInitial->gameTicks;

  if (0x5bf < initialGameTicks) {
    numCars = Cars_gNumCars;
    for (sortedLoop = numCars - 1; -1 < sortedLoop; sortedLoop = sortedLoop - 1) {
      testCar = Cars_gTotalSortedList[sortedLoop];
      if ((testCar->carFlags & 1U) != 0) {
        int dir;
        AIHigh_Player *thisPlayer;
        int needs;
        int got;
        copLevel_t *pLevel;
        int thisSlice;
        int startSlice;
        int endSlice;
        int fRandomChance;
        int crime;
        copType type;
        int typeOffset;
        int *gotPtr;
        AICop_BasicPerpInfo *perpInfo;

        thisPlayer = (AIHigh_Player *)highLevelAIObjs[testCar->carIndex];
        perpInfo = &thisPlayer->basicPerpInfo_;
        pLevel = AIHigh_Player_ChaseLevel(thisPlayer);
        type = *(volatile copType *)&this->type_;
        fRandomChance = thisPlayer->newTriggerProb_;
        typeOffset = type << 2;
        gotPtr = (int *)((char *)perpInfo->copsAssigned_ + typeOffset);
        crime = perpInfo->crime_;
        got = *gotPtr;
        if (crime == 0) {
          fRandomChance = fRandomChance * 2;
          if ((0 < *(int *)((char *)pLevel->copChasers + typeOffset)) &&
              (AICop_NoCopsInArea((int)(thisPlayer->GetCarObj()->N).simRoadInfo.slice, 0x1f40000) != 0)) {
            needs = 1;
          }
          else {
            needs = 0;
          }
        }
        else {
          needs = *(int *)((char *)pLevel->copChasers + typeOffset);
        }
        if (GameSetup_gData.skill == 2) {
          fRandomChance = 0x10000;
        }
        if (0x1bf < simGlobal.gameTicks -
                      AIHigh_Player_LastPullOverTime(thisPlayer)) {
          if (got < needs) {
            int newSlice;

            dir = -1;
            if (-1 < testCar->currentSpeed) {
              dir = 1;
            }
            thisSlice = dir * 0x1f;
            if (-1 < thisSlice) {
              newSlice = (testCar->N).simRoadInfo.slice + thisSlice;
              if (gNumSlices <= newSlice) {
                newSlice = newSlice - gNumSlices;
              }
            }
            else {
              newSlice = (testCar->N).simRoadInfo.slice + thisSlice;
              if (newSlice < 0) {
                newSlice = newSlice + gNumSlices;
              }
            }
            {
              int temp;

              temp = thisPlayer->lastTriggerCheckSlice_;
              thisPlayer->lastTriggerCheckSlice_ = newSlice;
              if (temp < newSlice) {
                startSlice = temp;
                endSlice = newSlice;
              }
              else {
                startSlice = newSlice;
                endSlice = temp;
              }
            }
            for (int sliceLoop = startSlice;
                 (sliceLoop < endSlice) && (endSlice - startSlice < 6);
                 sliceLoop++) {
              int triggerHere;

              triggerHere = triggerManagerCops->CheckForTriggerAtSlice(testCar->carIndex, sliceLoop);
              if (triggerHere != -1) {
                int iRandomChance;
                int randomValue;

                iRandomChance = (fRandomChance * 100) / 0x10000;
                randtemp = fastRandom * randSeed;
                fastRandom = randtemp & 0xffff;
                randomValue = (int)(((randtemp >> 8) & 0xffff) * 0x19 >> 0xe);
                if (AILife_IsSliceInAnyVisibleArea(sliceLoop) == (Car_tObj *)0x0) {
                  if ((got != 0) || (randomValue < iRandomChance)) {
                    int unused;

                    return triggerManagerCops->GetTrigger(triggerHere, &unused);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return (trigger_t *)0x0;
}


/* end of aih_cop.cpp */

/* cont.35 B3b: base-forward dtor re-attributed from main.c (�3.23 simple variant);
   oracle = jal ___11AIHigh_Base; extern-C free fn exports the exact symbol. */
extern "C" {
void ___11AIHigh_Base(void *);
void ___10AIHigh_Cop(void *thisp) { ___11AIHigh_Base(thisp); }
}
