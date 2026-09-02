/* game/common/aih_play.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aih_play_types.h"
#include "aih_play_externs.h"

extern int AI_elapsedTime;   /* H26-H29: ai.cpp @0x8013C554 (not in this TU's externs) */

/* ---- aistate.obj-owned globals (.bss zero) ---- */
int          AIHigh_Player_kNumArrestsByLap[3] = { 3, 5, 8 };   /* @0x8010ce98 */
/* MATCH (w66-a6): retail keeps this 5-byte table INSIDE the .sdata run
 * (0x8013C54C..0x8013DD7C) but -G4 exiles anything over 4 bytes to .data.  The
 * per-fn -G8 splice cannot reach data (it substitutes only the .ent/.end TEXT
 * region -- proven by splicing all 48 fns of audiocmn with the objects still in
 * .data), and a whole-TU -G8 changes every address materialization.  The
 * section attribute is the storage-only cure: TEXT byte-identical, gate 10/10
 * held.  This was the LAST row of the tree-wide -G8 tell census
 * (scratchpad/w66a6/GCENSUS.txt). */
char         gBlockadeTypes[5] __attribute__((section(".sdata"))) = { 5, 6, 4, 2, 0 };   /* @0x8013c568 */

/* AIH_PLAY.CPP's SLD maps every instruction in both expanded copies to one
 * caller line and records an inlined AICop_PerpChaseInfo `this`; the second
 * copy additionally records `level` in $s0.  This is therefore the original
 * inline member boundary rather than duplicated caller source.  SYM proves
 * the signatures and behavior but does not retain linkage names for inline-
 * only members; the descriptive getter/setter spellings below are therefore
 * sole remaining non-unique part of this recovered interface. */
inline int AICop_PerpChaseInfo::GetChaseLevelIndex()
{
  return chaseLevelIndex_;
}

inline int AICop_PerpChaseInfo::GetNumLevels()
{
  return copGameInfo_->numLevels;
}

inline copLevel_t *AICop_PerpChaseInfo::GetChaseLevel()
{
  return chaseLevel_;
}

inline int AICop_PerpChaseInfo::GetChaseTime()
{
  return (GetChaseLevel()->engagementLapFraction * AITune_gRoughLapTime) /
             0x10000 * 0x20 -
         engagementTime_ / 0x10000;
}

inline int AICop_PerpChaseInfo::IsLastChaseLevel()
{
  return bestChaseLevelIndex_ == copGameInfo_->numLevels - 1;
}

inline void AICop_PerpChaseInfo::SetChaseLevel(int level)
{
  int lapTicks;

  chaseLevelIndex_ = level;
  if (bestChaseLevelIndex_ < level) {
    bestChaseLevelIndex_ = level;
  }
  chaseLevel_ = copGameInfo_->levels + chaseLevelIndex_;
  lapTicks = (chaseLevel_->engagementLapFraction * AITune_gRoughLapTime) /
             0x10000;
  engagementTime_ = lapTicks << 0x15;
  engagementPercentIncreasePerTick_ = 0x10000 / (lapTicks << 5);
  if (GameSetup_gData.numLaps == 2) {
    engagementPercentIncreasePerTick_ =
        fixedmult(engagementPercentIncreasePerTick_, 0x13333);
  }
  else if (GameSetup_gData.numLaps == 4) {
    engagementPercentIncreasePerTick_ =
        fixedmult(engagementPercentIncreasePerTick_, 0xa8f5);
  }
  blockadeDone_ = 0;
}


/* ---- CheckIfABlockadeCanBeSetup__13AIHigh_Player  AIHigh_Player::CheckIfABlockadeCanBeSetup  [AIH_PLAY.CPP:55-170] SLD-VERIFIED ---- */

int AIHigh_Player::CheckIfABlockadeCanBeSetup()



{
  int copLoop;
  copLevel_t*pLevel;
  int nCopsNeeded[2];
  int ready[2];
  int assigned[2];
  int split;
  /* SYM-CODEGEN-CARRIER: chaseInfo -- optimized SYM retains the corresponding
     inlined AICop_PerpChaseInfo `this` receiver in s1 but not its source
     spelling.  Repeating `this->perpChaseInfo_` removes the s1 CSE and changes
     31 instructions (222 versus the 225-instruction retail body). */
  AICop_PerpChaseInfo *chaseInfo;
  /* SYM-CODEGEN-CARRIER: cannotSetup -- folding this materialized short-circuit
     result into the return guard changes 16 instructions and emits only 221;
     SYM and retail prove its lifetime, but do not preserve the source name. */
  bool cannotSetup;

  chaseInfo = &this->perpChaseInfo_;
  pLevel = chaseInfo->chaseLevel_;

  memset(ready,0,sizeof(ready));
  memset(assigned,0,sizeof(assigned));

  cannotSetup = false;
  split = Cars_gNumHumanRaceCars == 2;
  if ((pLevel->numBlockaders == 0) ||
      (chaseInfo->blockadeDone_ != 0) ||
      ((this->basicPerpInfo_.copsAssigned_[0] < pLevel->copChasers[0]) && !split) ||
      ((this->basicPerpInfo_.copsAssigned_[1] < pLevel->copChasers[1]) && !split)) {
    cannotSetup = true;
  }
  if (cannotSetup) {
    goto return_false;
  }

  nCopsNeeded[0] = pLevel->copBlockaders[0];
  nCopsNeeded[1] = pLevel->copBlockaders[1];

  for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {
    AIHigh_Cop *thisCop;
    thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
    if ((Cars_gCopCarList[copLoop]->AIFlags & 0xcU) == 0xc) {
      /* SYM-CODEGEN-CARRIER: type -- the typed snapshots reproduce the
         repeated inlined AIHigh_BasicCop receiver ranges in SYM.  Direct
         member indexing changes 55 instructions and emits 228 instead of
         retail's 225; the enum type itself is fixed by the class record. */
      copType type = thisCop->type_;
      if (nCopsNeeded[type] > assigned[type]) {
        ready[type] = ready[type] + 1;
        assigned[type] = assigned[type] + 1;
        thisCop->blockade_.mode = 1;
        thisCop->blockade_.target = this;
      }
    }
  }

  if ((nCopsNeeded[0] > assigned[0]) || (nCopsNeeded[1] > assigned[1])) {
    AIHigh_Cop *thisCop;
    for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {
      thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
      if (((Cars_gCopCarList[copLoop]->AIFlags & 0xcU) == 8) &&
          (thisCop->blockade_.mode != 2)) {
        copType type = thisCop->type_;
        if (nCopsNeeded[type] > assigned[type]) {
          assigned[type] = assigned[type] + 1;
          thisCop->blockade_.mode = 1;
          thisCop->blockade_.target = this;
        }
      }
    }
  }

  if ((Cars_gNumHumanRaceCars != 1) && (nCopsNeeded[1] > assigned[1])) {
    for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {
      AIHigh_Cop *thisCop;
      thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
      if (((Cars_gCopCarList[copLoop]->AIFlags & 0xcU) == 8) &&
          (thisCop->type_ == 0) &&
          (nCopsNeeded[1] > assigned[1]) &&
          (assigned[1] == 0)) {
        assigned[1] = 1;
        thisCop->blockade_.mode = 4;
        thisCop->blockade_.target = this;
      }
    }
  }

  if (ready[0] < nCopsNeeded[0]) {
    goto return_false;
  }
  if (ready[1] >= nCopsNeeded[1]) {
    return 1;
  }
return_false:
  return 0;

}








/* ---- SetupBlockade__13AIHigh_Player  AIHigh_Player::SetupBlockade  [AIH_PLAY.CPP:184-431] SLD-VERIFIED ---- */

void AIHigh_Player::SetupBlockade()



{
  int copLoop;
  int blockadeHandle;
  copLevel_t*pLevel;
  trigger_t *blockade;
  int used;
  int nCopsNeeded[2];
  int requestSpikeBeltAtSlice;
  int nCopsAvail[2];
  int totalRoadWidth;
  int blockadeSlice;
  int blockadeType;
  int blockadeFlags;
  bool saySpikeBelt;
  AIHigh_Cop*blockadeCar;
  int posIndex;
  int loop;
  int needed[2];

  pLevel = this->perpChaseInfo_.chaseLevel_;
  totalRoadWidth = this->carObj_->direction * 0x53;
  if (totalRoadWidth >= 0) {
    blockadeSlice = this->carObj_->N.simRoadInfo.slice + totalRoadWidth;
    if (gNumSlices <= blockadeSlice) {
      blockadeSlice = blockadeSlice - gNumSlices;
    }
  }
  else {
    blockadeSlice = this->carObj_->N.simRoadInfo.slice + totalRoadWidth;
    if (blockadeSlice < 0) {
      blockadeSlice = blockadeSlice + gNumSlices;
    }
  }

  nCopsNeeded[0] = pLevel->copBlockaders[0];
  nCopsNeeded[1] = pLevel->copBlockaders[1];
  blockadeHandle = triggerManagerCops->CheckForClosestTriggerOfType(
      blockadeSlice,(triggerType)2,this->carObj_->direction);

  if (blockadeHandle == -1) {
    this->CheckForNewLevel(1);
    return;
  }
  {

    blockade = triggerManagerCops->GetTrigger(blockadeHandle,&used);
    loop = 0;
    do {
      /* SYM-CODEGEN-CARRIER: manager -- repeating the global receiver at the
         call site emits 673 rather than 674 instructions and changes 19,
         including the retail saved receiver and slice-wrap allocation. */
      AITrigger_TriggerManager *manager;
      if ((AILife_IsSliceInAnyVisibleArea(blockade->roadblock.slice) != 0) ||
          (AILife_IsSliceCloseToAnyCopCar(blockade->roadblock.slice) != 0)) {
        manager = triggerManagerCops;
        blockadeHandle = blockade->roadblock.slice + 1;
        if (gNumSlices <= blockadeHandle) {
          /* SYM-CODEGEN-CARRIER: lastSlice -- inline `gNumSlices - 1` keeps
             674 instructions but changes eight allocation/combiner choices;
             the named value preserves retail's separate addiu/subu sequence. */
          int lastSlice = gNumSlices - 1;
          blockadeHandle = blockade->roadblock.slice - lastSlice;
        }
      }
      else {
        break;
      }
      blockadeHandle = manager->CheckForClosestTriggerOfType(
          blockadeHandle,(triggerType)2,this->carObj_->direction);
      if (blockadeHandle == -1) {
        this->CheckForNewLevel(1);
        return;
      }

      blockade = triggerManagerCops->GetTrigger(blockadeHandle,&used);
      loop = loop + 1;
    } while (loop < 4);

    blockadeSlice = blockade->roadblock.slice;
    requestSpikeBeltAtSlice = -1;
    if (pLevel->spikeBelt != 0) {
      requestSpikeBeltAtSlice = blockadeSlice;
    }

    nCopsAvail[0] = 0;

    nCopsAvail[1] = 0;

    needed[0] = nCopsNeeded[0];

    needed[1] = nCopsNeeded[1];

    {
      AIHigh_Cop *thisCop;
      for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {
        /* SYM-CODEGEN-CARRIER: bVar2 -- folding this short-circuit result into
           the update guard emits 669 rather than 674 instructions and changes
           121 by reshaping the array bases and the following long loop. */
        bool bVar2;
        thisCop = (AIHigh_Cop *)highLevelAIObjs[
            Cars_gCopCarList[copLoop]->carIndex];
        bVar2 = false;
        if (((Cars_gCopCarList[copLoop]->AIFlags & 4U) != 0) &&
            (thisCop->blockade_.mode == 1)) {
          bVar2 = needed[thisCop->type_] != 0;
        }
        if (bVar2) {
          needed[thisCop->type_] = needed[thisCop->type_] - 1;
          nCopsAvail[thisCop->type_] = nCopsAvail[thisCop->type_] + 1;
        }
      }
    }

    blockadeCar = (AIHigh_Cop *)0x0;

    randtemp = fastRandom * randSeed;

    posIndex = 0;

    saySpikeBelt = false;

    fastRandom = randtemp & 0xffff;

    blockadeType = (randtemp >> 8 & 0xffff) % 5;
    blockadeFlags = (u_int)(u_char)"\x05\x06\x04\x02"[blockadeType];

    {
      /* SYM-CODEGEN-CARRIER: chaseInfo -- SYM retains the corresponding
         inlined AICop_PerpChaseInfo receiver in fp but not a source spelling.
         Direct member accesses emit 671 rather than 674 instructions and
         change 123, collapsing fp and the long-loop allocation. */
      AICop_PerpChaseInfo *chaseInfo;
      AIHigh_Cop *thisCop;
      blockade_t *blockade;
      /* SYM-CODEGEN-CARRIER: one -- replacing this shared loop pseudo with
         integer literals keeps 674 instructions but moves retail's `li a3,1`,
         producing the final two scheduling diffs. */
      int one;
      for (copLoop = 0, one = 1, chaseInfo = &this->perpChaseInfo_;
           copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {

      thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
      if (((Cars_gCopCarList[copLoop]->AIFlags & 4U) != 0) &&
          (thisCop->blockade_.mode == one)) {

        if ((thisCop->type_ == one) && (nCopsNeeded[1] != 0)) {
          int addToSlice;
          /* SYM-CODEGEN-CARRIER: distance -- reusing the recorded addToSlice
             scratch keeps 674 instructions but changes 16 result-register
             uses (retail v1 versus v0) across the two symmetric branches. */
          int distance;

          blockade = &thisCop->blockade_;

          if (blockadeCar == (AIHigh_Cop *)0x0) {

            blockadeCar = thisCop;

          }

          nCopsNeeded[1] = nCopsNeeded[1] + -1;

          blockade->blockadeSpeechFlags = 0;
          blockade->flags = blockadeFlags;
          blockade->chaseLevel = chaseInfo->chaseLevelIndex_;
          blockade->mode = 2;

          addToSlice = ((posIndex / 2) * 2 + 3) * this->carObj_->direction;
          blockadeFlags = 0;
          blockade->slice = addToSlice >= 0
              ? (blockadeSlice + addToSlice >= gNumSlices
                    ? blockadeSlice + addToSlice - gNumSlices
                    : blockadeSlice + addToSlice)
              : (blockadeSlice + addToSlice < 0
                    ? blockadeSlice + addToSlice + gNumSlices
                    : blockadeSlice + addToSlice);

          blockade->direction = this->carObj_->direction;

          totalRoadWidth =
                       (BWorldSm_slices[blockade->slice].avgPavedWidthLf << 15) *
                       (BWorldSm_slices[blockade->slice].laneCount >> 4) +
                       (BWorldSm_slices[blockade->slice].avgPavedWidthRt << 15) *
                       (BWorldSm_slices[blockade->slice].laneCount & 0xf);

          if ((nCopsAvail[1] == one) && (nCopsAvail[0] == 0)) {

            blockade->latPos = ((u_int)totalRoadWidth >> 1) -
                (BWorldSm_slices[blockade->slice].avgPavedWidthLf << 15) *
                (BWorldSm_slices[blockade->slice].laneCount >> 4);

            blockade->rotation = 0xff;

          }

          else {

            if ((posIndex & 1) == 0) {
              blockade->latPos =

                   -((BWorldSm_slices[blockade->slice].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[blockade->slice].laneCount >> 4)) +
                   totalRoadWidth / 4;

              blockade->rotation = 0xbe;

            }

            else {

              blockade->latPos =

                   -((BWorldSm_slices[blockade->slice].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[blockade->slice].laneCount >> 4)) +
                   (totalRoadWidth / 4) * 3;

              blockade->rotation = -0xbe;

            }

          }

          randtemp = fastRandom * randSeed;

          blockade->target = this;
          blockade->reverse = 0;
          blockade->releaseTime =
              ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999;

          fastRandom = randtemp & 0xffff;

          distance = AIWorld_ApxSplineDistance(this->carObj_,blockade->slice);

          if (distance < 0) {

            distance = distance + 0xffff;

          }

          blockade->initialPlayerDistanceMetersInt = -(distance >> 0x10);

          if (-(distance >> 0x10) * (this->carObj_)->direction < 0) {

            blockade->initialPlayerDistanceMetersInt = 0;

          }

        }

        else {
          int addToSlice;
          int distance;

          if (nCopsNeeded[0] == 0) goto LAB_800620e8;

          blockade = &thisCop->blockade_;

          if (blockadeCar == (AIHigh_Cop *)0x0) {

            blockadeCar = thisCop;

          }

          nCopsNeeded[0] = nCopsNeeded[0] + -1;

          blockade->blockadeSpeechFlags = 0;
          blockade->flags = blockadeFlags;
          blockade->chaseLevel = chaseInfo->chaseLevelIndex_;
          blockade->mode = 2;

          addToSlice = ((posIndex / 2) * 2 + 3) * this->carObj_->direction;
          blockadeFlags = 0;
          blockade->slice = addToSlice >= 0
              ? (blockadeSlice + addToSlice >= gNumSlices
                    ? blockadeSlice + addToSlice - gNumSlices
                    : blockadeSlice + addToSlice)
              : (blockadeSlice + addToSlice < 0
                    ? blockadeSlice + addToSlice + gNumSlices
                    : blockadeSlice + addToSlice);

          randtemp = fastRandom * randSeed;

          blockade->direction = this->carObj_->direction;

          fastRandom = randtemp & 0xffff;

          if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 < 300) {

            blockade->reverse = one;

          }

          else {

            blockade->reverse = 0;

          }

          randtemp = fastRandom * randSeed;

          blockade->releaseTime =
              ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999;

          fastRandom = randtemp & 0xffff;

          distance = AIWorld_ApxSplineDistance(this->carObj_,blockade->slice);

          if (distance < 0) {

            distance = distance + 0xffff;

          }

          blockade->initialPlayerDistanceMetersInt = -(distance >> 0x10);

          if (-(distance >> 0x10) * (this->carObj_)->direction < 0) {

            blockade->initialPlayerDistanceMetersInt = 0;

          }

          totalRoadWidth =
                       (BWorldSm_slices[blockade->slice].avgPavedWidthLf << 15) *
                       (BWorldSm_slices[blockade->slice].laneCount >> 4) +
                       (BWorldSm_slices[blockade->slice].avgPavedWidthRt << 15) *
                       (BWorldSm_slices[blockade->slice].laneCount & 0xf);

          if ((nCopsAvail[0] == one) && (nCopsAvail[1] == 0)) {

            blockade->latPos = ((u_int)totalRoadWidth >> 1) -
                (BWorldSm_slices[blockade->slice].avgPavedWidthLf << 15) *
                (BWorldSm_slices[blockade->slice].laneCount >> 4);

            blockade->rotation = 0xff;

          }

          else {

            if ((posIndex & 1) == 0) {
              blockade->latPos =

                   -((BWorldSm_slices[blockade->slice].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[blockade->slice].laneCount >> 4)) +
                   totalRoadWidth / 4;

              blockade->rotation = 0xbe;

            }

            else {

              blockade->latPos =

                   -((BWorldSm_slices[blockade->slice].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[blockade->slice].laneCount >> 4)) +
                   (totalRoadWidth / 4) * 3;

              blockade->rotation = -0xbe;

            }

          }

          blockade->target = this;

        }

        if (requestSpikeBeltAtSlice != -1) {
          saySpikeBelt = true;
          blockade->requestSpikeBeltAtSlice = requestSpikeBeltAtSlice;
          requestSpikeBeltAtSlice = -1;
        }

        chaseInfo->blockadeDone_ = one;

        posIndex = posIndex + 1;

      }

LAB_800620e8: ;   /* empty stmt: gcc2.7.2 label before brace */

      }
      /* MATCH: retail keeps requestSpikeBeltAtSlice in s6 and the shared
       * chaseInfo base in fp.  The seven spike-slice refs cross its measured
       * global-alloc priority step; the chaseInfo ref gives the base fp over
       * the loop's shared `one` pseudo.  Empty-template fence: zero insns. */
      __asm__("" : : "r"(requestSpikeBeltAtSlice),
                       "r"(requestSpikeBeltAtSlice),
                       "r"(requestSpikeBeltAtSlice),
                       "r"(requestSpikeBeltAtSlice),
                       "r"(requestSpikeBeltAtSlice),
                       "r"(requestSpikeBeltAtSlice),
                       "r"(requestSpikeBeltAtSlice),
                       "r"(chaseInfo));
    }

    if (blockadeCar != (AIHigh_Cop *)0x0) {

      blockadeCar->blockade_.blockadeSpeechFlags = 1;

      if (saySpikeBelt) {
        Speech_Mobile(blockadeCar->carObj_)->SpikeBelt();

      }

      else {
        Speech_Mobile(blockadeCar->carObj_)->RoadBlock();

      }

      Speech_Mobile(blockadeCar->carObj_)->Engage(this->carObj_);

      Speech_Dispatch()->Grant();

      Speech_Dispatch()->Ready(blockadeCar->carObj_);

    }
  }

  return;

}








/* ---- CheckForNewLevel__13AIHigh_Playeri  AIHigh_Player::CheckForNewLevel  [AIH_PLAY.CPP:434-511] SLD-VERIFIED ---- */

void AIHigh_Player::CheckForNewLevel(int force)

{
  int chaseLevel;
  int oldChaseLevel;

  /* W57-A11: SLD/SYM-shaped rewrite.  The retail SYM 8c block lists exactly TWO
     int locals (chaseLevel $10=s0, oldChaseLevel $13=s3) plus a chain of INLINED
     AICop_PerpChaseInfo methods, each contributing its own block-scoped `this`
     pseudo ($3=v1, $10=s0, $4=a0, $11=s1) and one `level` parameter ($10=s0).
     Restoring the inline accessors produces those separate retail receivers;
     a single decompiler pointer spanning the body instead becomes a 12-ref
     global allocno, occupies $s1, and displaces oldChaseLevel into $s4.
     SLD map: 434 prologue | 438 init+finishType test | 439 the whole first
     inlined SetChaseLevel chunk | 443 crime_=0 + return | 475 vf call |
     476 crime test | 490 force/engagementTime gate | 491-493 level bump |
     494 the second inlined SetChaseLevel chunk | 503 index compare |
     504-505 newTriggerProb_ | 511 close.  */

  oldChaseLevel = this->perpChaseInfo_.GetChaseLevelIndex();

  chaseLevel = oldChaseLevel;

  if (1 < ((this->carObj_)->stats).finishType) {

    /* SYM-INLINE-LOCAL: level = SetChaseLevel */
    this->perpChaseInfo_.SetChaseLevel(0);

    this->basicPerpInfo_.crime_ = 0;

    return;

  }

  /* Retail AIHigh_Player_vtable[3] @0x800550b0 is
     CheckForCrimes__16AIHigh_BasicPerp @0x8005b500.  Keep the ABI-shaped call
     local until the explicit AIHigh hierarchy vptr is restored as C++ virtual
     source; the former pa_Var1 decompiler alias is not required for codegen. */
  (**(int (**)(...))((char *)this->_vf + 28))

            ((int)this + *(short *)((char *)this->_vf + 24));

  if (this->basicPerpInfo_.crime_ != 0) {

    if (force == 0) {

      /* SYM-CODEGEN-CARRIER: doIt -- the optimized SYM omits this boolean's
         source name, but retail materializes its 0/1 value in $a0 and tests it
         with a second branch.  Folding it into the condition emits 182 rather
         than 184 instructions and leaves eight authoritative diffs. */
      bool doIt = false;

      if (this->perpChaseInfo_.engagementTime_ / 0x10000 <= 0) {

        doIt = true;

      }

      if (!doIt) goto LAB_8006249c;

    }

    {

      chaseLevel = chaseLevel + 1;

      if (this->perpChaseInfo_.GetNumLevels() <= chaseLevel) {

        chaseLevel = this->perpChaseInfo_.GetNumLevels() + -2;

      }

      this->perpChaseInfo_.SetChaseLevel(chaseLevel);

    }

  }

LAB_8006249c:
  {

    if (oldChaseLevel == this->perpChaseInfo_.GetChaseLevelIndex()) {

      return;

    }

    this->newTriggerProb_ =

         triggerManagerCops->invNumTriggers_ *
         this->perpChaseInfo_.GetChaseLevel()->copsPerLap;

  }

  return;

}








/* ---- HandleSpeech__13AIHigh_Player  AIHigh_Player::HandleSpeech  [AIH_PLAY.CPP:517-663] SLD-VERIFIED ---- */

void AIHigh_Player::HandleSpeech()



{
  int highestRankedCopIndex;
  int arrestType;
  int player;

  if (this->positionVSCopList_[0].carIndex == -1) {

    highestRankedCopIndex = (*(int *)((char *)Cars_gCopCarList[0] + 0x254));

  }

  else {

    highestRankedCopIndex = this->positionVSCopList_[0].carIndex;

  }

  if ((this->positionVSCopList_[1].carIndex != -1) &&
      (this->positionVSCopList_[1].carIndex < highestRankedCopIndex)) {

    highestRankedCopIndex = this->positionVSCopList_[1].carIndex;

  }

  if ((this->positionVSCopList_[2].carIndex != -1) &&
      (this->positionVSCopList_[2].carIndex < highestRankedCopIndex)) {

    highestRankedCopIndex = this->positionVSCopList_[2].carIndex;

  }

  player = (this->carObj_)->carIndex;

  if (this->pullOverMode_ == 1) goto LAB_pullover_flag;

  if (1 < (int)this->pullOverMode_) {

    if (this->pullOverMode_ == 2) goto LAB_pullover_arrest;

    if (this->pullOverMode_ == 3) goto LAB_pullover_evade;

  }

  arrestType = 4;

  goto LAB_800625d0;

LAB_pullover_flag:

  Hud_Perp_OverlayOn(player,0);

  arrestType = 2;

  goto LAB_800625d0;

LAB_pullover_arrest:

  Hud_Perp_OverlayOn(player,1);

  arrestType = 8;

  if (2 < this->numBusts_) {

    arrestType = this->numBusts_ + 6;

  }

  goto LAB_800625d0;

LAB_pullover_evade:

  Hud_Perp_OverlayOn(player,2);

  arrestType = 1;

LAB_800625d0:

  if (AICop_gRoadBlockState != kAICop_RoadBlockState_None) {

    AICop_gRoadBlockState = kAICop_RoadBlockState_PerpPassed;

  }

  Speech_Mobile(Cars_gList[highestRankedCopIndex])->Catch(arrestType);

  return;

}








/* ---- MaintainAvailableCops__13AIHigh_Player  AIHigh_Player::MaintainAvailableCops  [AIH_PLAY.CPP:669-744] SLD-VERIFIED ---- */

void AIHigh_Player::MaintainAvailableCops()



{
  int need[2];
  int got[2];
  int availableCops;

  memset((u_char *)need, '\0', sizeof(need));
  memset((u_char *)got, '\0', sizeof(got));

  availableCops = 3;
  if (Cars_gNumRaceCars != 1) {
    availableCops = 4;
    if (Cars_gNumHumanRaceCars == 2) {
      availableCops = 2;
    }
  }

  {
    int playLoop;

    for (playLoop = 0; playLoop < Cars_gNumRaceCars; playLoop++) {
      Car_tObj *playerCarObj;
      AIHigh_Player *playerHighObj;
      /* SYM-CODEGEN-CARRIER: pInfo -- the retail SLD records an inlined
         AICop_PerpChaseInfo `this` receiver here, but not the unrecoverable
         helper name. Direct field spelling is 161/162 with nine base-address
         and load-form diffs; this receiver restores the exact +0x8c view. */
      AICop_PerpChaseInfo *pInfo;

      playerCarObj = Cars_gRaceCarList[playLoop];
      playerHighObj = (AIHigh_Player *)highLevelAIObjs[playerCarObj->carIndex];
      pInfo = &playerHighObj->perpChaseInfo_;
      need[0] += pInfo->chaseLevel_->copBlockaders[0];
      need[1] += pInfo->chaseLevel_->copBlockaders[1];
      need[0] += pInfo->chaseLevel_->copChasers[0];
      need[1] += pInfo->chaseLevel_->copChasers[1];
    }
  }

  {
    int copLoop;
    int playLoop;

    for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop++) {
      Car_tObj *copCarObj;
      AIHigh_Cop *copHighObj;
      /* SYM-CODEGEN-CARRIER: available -- retail materializes the combined
         inline-state predicate although no result name survives. Using the
         condition directly shrinks 162 to 159 instructions and changes 63
         allocation/control-flow instructions. */
      bool available;

      copCarObj = Cars_gCopCarList[copLoop];
      copHighObj = (AIHigh_Cop *)highLevelAIObjs[copCarObj->carIndex];
      available = (copCarObj->AIFlags & 4U) == 0 ||
                  highLevelAIObjs[copCarObj->carIndex][1].stateType_ == STATE_PURGATORY ||
                  highLevelAIObjs[copCarObj->carIndex][1].stateType_ == STATE_NORMAL;
      if (available) {
        playLoop = copHighObj->type_;
        got[playLoop]++;
        availableCops--;
        copCarObj->AIFlags |= 8;
      }
      else {
        copCarObj->AIFlags &= ~8U;
      }
    }
  }

  {
    int copLoop;

    for (copLoop = 0;
         availableCops > 0 && copLoop < Cars_gNumCopCars;
         copLoop++) {
      Car_tObj *copCarObj;

      copCarObj = Cars_gCopCarList[copLoop];
      if ((copCarObj->AIFlags & 8U) == 0) {
        AIHigh_Cop *copHighObj;
        int playLoop;

        copHighObj = (AIHigh_Cop *)highLevelAIObjs[copCarObj->carIndex];
        playLoop = copHighObj->type_;
        if (need[playLoop] > got[playLoop]) {
          got[playLoop]++;
          availableCops--;
          copCarObj->AIFlags |= 8;
        }
      }
    }
  }

}








/* ---- __13AIHigh_PlayerP8Car_tObj  AIHigh_Player::ctor  [AIH_PLAY.CPP:750-762] SLD-VERIFIED ---- */
AIHigh_Player::AIHigh_Player(Car_tObj *carObj)



{
  int gameIndex;
  int lapIndex;
  copGame_t*copGameInfo;

  /* SYM-CODEGEN-CARRIER: pInfo -- the inlined chase-info constructor's retail
     receiver stays in $a1 across its branch and initialization sequence.
     Repeating the member expression emits 127 instead of 129 instructions and
     changes 28 branch/address/store instructions. */
  AICop_PerpChaseInfo *pInfo;

  (new((AIHigh_BasicPerp *)this) AIHigh_BasicPerp(carObj));

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_Player_vtable;

  pInfo = &this->perpChaseInfo_;

  /* w54-a12 (85 -> 67 diffs): SYM's own unused locals gameIndex/lapIndex/copGameInfo ARE
   * the original variables.  The numLaps test must be evaluated BEFORE the commMode branch
   * and used arithmetically -- retail is branchless there (`xori v0,v0,2; sltu a0,zero,v0`
   * then `addu idx,4*(0<numAI),thatBit`); folding it into `iVar1 + (numLaps != 2)` AFTER
   * the if made gcc emit a second branch + a duplicated `sll idx,3`.  Also: derive `levels`
   * from the copGameInfo POINTER (not `copGame[idx].levels`, which recomputes the address)
   * and keep that read AT its use in the chaseLevel_ statement -- moving it earlier costs
   * ~16 diffs.  Residual: the a0/v1 rotation + retail's `addu v0,v1,zero` pointer copy. */
  lapIndex = (u_int)(GameSetup_gData.numLaps != 2);

  if (GameSetup_gData.commMode == 1) {

    gameIndex = 2;

  }

  else {

    gameIndex = (u_int)(0 < Cars_gNumAIRaceCars) << 2;

  }

  copGameInfo = copGame + (gameIndex + lapIndex);

  pInfo->copGameInfo_ = copGameInfo;
  /* SYM-CODEGEN-CARRIER: copGameInfoCopy -- retail stores the selected pointer
     through the inline receiver and then copies it from $v1 to $v0 before the
     remaining initialization.  Plain C emits 128 rather than 129 instructions
     with 17 scheduling/allocation diffs.  These guide-authorized empty fences
     emit no opcodes; they retain the measured GCC source-level dependency. */
  __asm__ __volatile__("" : : : "memory");

  copGame_t *copGameInfoCopy = copGameInfo;
  __asm__("" : "=r"(copGameInfoCopy) : "0"(copGameInfoCopy));

  pInfo->chaseLevelIndex_ = 0;

  pInfo->engagementTime_ = 0;

  /* SYM-CODEGEN-CARRIER: chaseIndex -- retaining the initialized index before
     the best-level store schedules retail's load at 0x80062944.  Reading the
     field only at the final addition moves that load and leaves two ordered
     instruction diffs. */
  int chaseIndex = pInfo->chaseLevelIndex_;

  pInfo->bestChaseLevelIndex_ = 0;

  /* SYM-CODEGEN-CARRIER: levels -- separating this early load preserves the
     retail copGameInfo copy in $v0, levels in $a0, and final sum/store in
     $v1.  Embedding the field read in the assignment produces eight register
     and dataflow diffs at the same 129 instructions. */
  copLevel_t *levels = copGameInfoCopy->levels;

  pInfo->blockadeDone_ = 0;

  pInfo->copFreeTicks_ = 0;

  pInfo->totalEngagementPercent_ = 0;

  pInfo->engagementPercentIncreasePerTick_ = 0;

  pInfo->chaseLevel_ = levels + chaseIndex;

  /* MATCH: the named chaseIndex/levels split shortens the copied copGameInfo
   * lifetime, giving its copy v0, the index v1, and levels a0.  Retail's SLD
   * statement order also initializes bestChaseLevelIndex_ before levels. */

  this->numWarnings_ = 0;

  this->numBusts_ = 0;

  if (GameSetup_gData.cops == 0) {

    return;

  }

  {
    /* SYM line 7 begins a fresh AICop_PerpChaseInfo inline receiver in $a1;
       the direct GetChaseLevel call expresses that boundary without a named
       decompiler alias. */
    this->newTriggerProb_ =

         triggerManagerCops->invNumTriggers_ *
         this->perpChaseInfo_.GetChaseLevel()->copsPerLap;

    /* SYM-CODEGEN-CARRIER: pInfo3 -- the line-12 inline receiver is copied
       from the line-7 $a1 view into retail $s0 before SetChaseLevel's
       fixedmult call.  Calling SetChaseLevel through the earlier receiver
       directly keeps 129 instructions but changes 16 receiver/product
       instructions. */
    AICop_PerpChaseInfo *pInfo3 = &this->perpChaseInfo_;

    this->lastTriggerCheckSlice_ =
        (int)(this->carObj_->N).simRoadInfo.slice;

    /* SYM-INLINE-LOCAL: level = SetChaseLevel */
    pInfo3->SetChaseLevel(0);

    return;
  }

}








/* ---- HandleCops__13AIHigh_Player  AIHigh_Player::HandleCops  [AIH_PLAY.CPP:808-868] SLD-VERIFIED ---- */

void AIHigh_Player::HandleCops()



{
  copLevel_t *pLevel;
  int ticks;
  int totalCopsEngaged;

  /* SYM-CODEGEN-CARRIER: pInfo -- the SLD records the corresponding inlined
     AICop_PerpChaseInfo `this` receivers but not their original helper names.
     Direct member spelling shrinks 104 to 98 instructions and changes 76
     frame/allocation/load instructions; the two lexical receivers reproduce
     the retail $s0/$a1 views. */
  AICop_PerpChaseInfo *pInfo;



  pInfo = &this->perpChaseInfo_;

  pLevel = pInfo->chaseLevel_;

  if (Cars_gNumCopCars != 0) {

    this->MaintainAvailableCops();

    if (this->CheckIfABlockadeCanBeSetup()) {

      this->SetupBlockade();

    }

    if (pLevel->numBlockaders == 0) {

      this->CleanupBlockaders(0);

    }

    {
      AICop_PerpChaseInfo *pInfo = &this->perpChaseInfo_;
      /* SYM-CODEGEN-CARRIER: prodSlipYawNeg -- directly embedding the product
         sign in the shift selection yields 102/104 instructions with 44
         allocation/scheduling diffs. The optimized predicate preserves the
         retail precomputed sign and subsequent shift-count selection. */
      u_int prodSlipYawNeg;

      prodSlipYawNeg =
          (u_int)(*(int *)((char *)this->carObj_ + 1380) *
                  *(int *)((char *)this->carObj_ + 1364)) >> 31;
      ticks = AI_elapsedTime;
      totalCopsEngaged = this->basicPerpInfo_.copsAssigned_[0] +
                         this->basicPerpInfo_.copsAssigned_[1];
      if (0 < totalCopsEngaged) {
        pInfo->copFreeTicks_ = 0;
        if (-2 < pInfo->engagementTime_ / 0x10000) {
          this->perpChaseInfo_.engagementTime_ -=
              ticks << (prodSlipYawNeg ? 0xf : 0x10);
          if (pInfo->engagementTime_ / 0x10000 <
              (pInfo->chaseLevel_->engagementLapFraction * AITune_gRoughLapTime /
               0x10000) * 0x20 - 0x80) {
            pInfo->totalEngagementPercent_ +=
                pInfo->engagementPercentIncreasePerTick_ * ticks;
          }
        }
      }
      else {
        pInfo->copFreeTicks_ += ticks;
      }
    }

    this->CheckForNewLevel(0);

    this->HandlePullOver();

  }

  return;

}








/* ---- CleanupBlockaders__13AIHigh_Playeri  AIHigh_Player::CleanupBlockaders  [AIH_PLAY.CPP:871-902] SLD-VERIFIED ---- */

void AIHigh_Player::CleanupBlockaders(int forceClearAll)



{
  int clearWaitingBlockaders;
  int copLoop;
  AIHigh_Cop*thisCop;
  blockade_t*blockade;

  clearWaitingBlockaders = 0;

  if ((0 < (this->carObj_->stats).numArrests) ||
      (1 < (this->carObj_->stats).finishType) || (forceClearAll != 0)) {

    clearWaitingBlockaders = 1;

  }

  copLoop = 0;

  while (true) {

    if (Cars_gNumCopCars <= copLoop) break;

    /* MATCH: SYM shows no walking-pointer local in this fn's block scopes (only
       copLoop/thisCop/blockade) -- oracle indexes Cars_gCopCarList[copLoop] directly
       (gcc strength-reduces to the same pointer-walk body, but the LICM preheader then
       hoists highLevelAIObjs's base BEFORE Cars_gCopCarList's, matching the oracle order). */
    thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];

    blockade = &thisCop->blockade_;

    if (((((blockadeMode_t)blockade->mode == 1) ||
          ((blockadeMode_t)blockade->mode == 4)) ||
         (((blockadeMode_t)blockade->mode == 2 && clearWaitingBlockaders))) &&

       (blockade->target == this)) {

      blockade->mode = 0;

      thisCop->AssignToPlayer((AIHigh_Player *)0x0);

    }

    copLoop = copLoop + 1;

  }

  return;

}








/* ---- HandlePullOver__13AIHigh_Player  AIHigh_Player::HandlePullOver  [AIH_PLAY.CPP:906-1014] SLD-VERIFIED ---- */

void AIHigh_Player::HandlePullOver()
{
  int chaseTime;
  bool bVar1;
  if (this->pullOverMode_ != 0) {
    this->beatingTicksLeft_ -= AI_elapsedTime;
    if (0 < this->beatingTicksLeft_) {
      return;
    }
    if ((this->carObj_)->carIndex < 2) {
      Hud_Perp_OverlayOff((this->carObj_)->carIndex);
    }
    this->lastPullOverTime_ = simGlobal.gameTicks;
    if (this->pullOverMode_ == 3) {
      if (((this->carObj_)->carFlags & 4U) != 0) {
        AICop_numArrestedHumans = AICop_numArrestedHumans + 1;
      }
      ((this->carObj_)->stats).finishType = 3;
    }
    if (AICop_numArrestedHumans == Cars_gNumHumanRaceCars) {
      simVar.endSimGame = 1;
      Stats_ExtrapolateOpponentTimes(2);
    }
    /* SYM-INLINE-LOCAL: level = SetChaseLevel */
    this->perpChaseInfo_.SetChaseLevel(0);
    this->basicPerpInfo_.crime_ = 0;
    this->RemoveCloseCops();
    if (((this->pullOverMode_ != 3) || (Cars_gNumHumanRaceCars != 1)) ||
        (((this->carObj_)->carFlags & 8U) != 0)) {
      Cars_ResetCollidedCars(this->carObj_,1,1);
    }
    if (this->pullOverMode_ != 3) {
      (this->carObj_)->pullOver = 0;
    }
    else if ((Cars_gNumHumanRaceCars == 2) && (AICop_numArrestedHumans != 2)) {
      DashHUD_gInfo.showhud[(this->carObj_)->carIndex] = 0;
    }
    this->pullOverMode_ = 0;
    return;
  }

  if (!this->CheckIfCaught()) {
    return;
  }
  (this->carObj_)->pullOver = 1;
  this->CleanupBlockaders(1);
  {
    /* SYM-CODEGEN-CARRIER: chaseInfo -- this source alias materializes the
       nested inline receivers in the retail $a3/$a1 allocation.  Repeating
       the member expression moves them to $a1/$a2 and produces 26 diffs. */
    AICop_PerpChaseInfo *chaseInfo = &this->perpChaseInfo_;

    chaseTime = chaseInfo->GetChaseTime();
    this->beatingTicksLeft_ = chaseInfo->GetChaseLevel()->beatingTicks;
    this->lastPullOverTime_ = simGlobal.gameTicks;
    /* SYM-CODEGEN-CARRIER: bVar1 -- retail materializes this short-circuit
       result in $a2.  Folding it into the following guard keeps 307
       instructions but changes 18 authoritative instructions/registers. */
    bVar1 = false;
    if (((this->basicPerpInfo_.crime_ != 4) &&
         (((this->carObj_)->stats).numFines == 0)) &&
        (chaseInfo->copGameInfo_->levels[chaseInfo->bestChaseLevelIndex_]
             .numWarningsAdded != 0)) {
      bVar1 = chaseTime < chaseInfo->GetChaseLevel()->warningTicks;
    }
  }
    if ((bVar1) && (this->numWarnings_ < 2)) {
      this->numWarnings_ =
          this->numWarnings_ + (this->perpChaseInfo_).chaseLevel_->numWarningsAdded;
      (this->carObj_->stats).numWarnings = (this->carObj_->stats).numWarnings + 1;
      this->pullOverMode_ = 1;
      goto LAB_8006322c;
    }
    else {
      this->numBusts_ = this->numBusts_ + 1;
      (this->carObj_->stats).numFines = (this->carObj_->stats).numFines + 1;
      int lapIndex;
      /* w54-a12 (27 -> PASS 307/307): the ternary must land in a NAMED index variable and
       * the subscript must use that variable -- a ternary written INSIDE the subscript lets
       * gcc constant-fold each arm into a pre-scaled BYTE offset (li 8 / 0 + addu base) and
       * loses retail's `sll idx,2; addu idx,base` index form.  Paired with the compare
       * written numBusts_-FIRST (`numBusts_ >= table[i]`, catalog 05H "compare-operand order
       * IS load order"): that is what puts retail's `lw numBusts` before `lw table[i]` and
       * settles the idx/base v1-vs-v0 coloring. Do not "simplify" either back. */
      lapIndex = GameSetup_gData.numLaps == 2
                     ? 0
                     : (GameSetup_gData.numLaps == 4 ? 1 : 2);
      if ((this->numBusts_ >= AIHigh_Player_kNumArrestsByLap[lapIndex]) ||
          (this->perpChaseInfo_.IsLastChaseLevel() &&
           Cars_gNumHumanRaceCars == 1)) {
        this->pullOverMode_ = 3;
        this->beatingTicksLeft_ = this->beatingTicksLeft_ + 0xc0;
        (this->carObj_->stats).numArrests =
            (this->carObj_->stats).numArrests + 1;
        goto LAB_8006322c;
      }
      this->pullOverMode_ = 2;
    }
LAB_8006322c:
  this->HandleSpeech();
}







/* ---- ___13AIHigh_Player  AIHigh_Player::~AIHigh_Player  @0x80063248 ----
 * Reconstructed 2026-07-11 (wave-5 consolidation): declared in aihigh.h + oracle .s existed but
 * the fn was defined NOWHERE in the tree (rule-8 unreconstructed-fn class, found by the aih agent).
 * Oracle: set vptr(+0x14) = _vt_16AIHigh_BasicPerp (the BASE class vtable -- gcc2.8 dtor of
 * AIHigh_Player collapses the inlined ~AIHigh_BasicPerp body, which resets its own vptr), then
 * jal ___11AIHigh_Base with the vptr store in the delay slot. Same extern-C free-fn recipe as
 * ___10AIHigh_Cop (aih_cop.cpp:2090). */
extern "C" {
extern char _vt_16AIHigh_BasicPerp[];
void ___11AIHigh_Base(void *);
void ___13AIHigh_Player(void *thisp)
{
  *(char **)((char *)thisp + 0x14) = _vt_16AIHigh_BasicPerp;
  ___11AIHigh_Base(thisp);
}
}

/* end of aih_play.cpp */
