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

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int NumRaceCars(void) { return Cars_gNumRaceCars; }


/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int NumHumanRaceCars(void) { return Cars_gNumHumanRaceCars; }


/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int GameTicks(void) { return simGlobal.gameTicks; }


/* Retail aih_play.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *, const char *, ...);

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
extern char gBlockadeTypes[];   /* UNSIZED before its definition (end of file): retail addresses this
                                   small-data table absolutely (lui/addiu 0x8013c568) */

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

inline int AICop_PerpChaseInfo::ConfiguredEngagementLapTime()
{
  return (GetChaseLevel()->engagementLapFraction * AITune_gRoughLapTime) / 0x10000;
}
inline void AICop_PerpChaseInfo::ApplyChaseLapFactor()
{
  if (GameSetup_gData.numLaps == 2)
    engagementPercentIncreasePerTick_ =
      fixedmult(engagementPercentIncreasePerTick_,0x13333);
  else if (GameSetup_gData.numLaps == 4)
    engagementPercentIncreasePerTick_ =
      fixedmult(engagementPercentIncreasePerTick_,0xa8f5);
}
inline void AICop_PerpChaseInfo::InitializeChaseTimer(int lapTime)
{
  engagementTime_ = lapTime << 0x15;
  engagementPercentIncreasePerTick_ = 0x10000 / (lapTime << 5);
  ApplyChaseLapFactor();
}
inline int AICop_PerpChaseInfo::RemainingEngagementTime() { return engagementTime_ / 0x10000; }
inline void AICop_PerpChaseInfo::SetChaseLevel(int level)
{
  /* Candidate source decomposition: computes the same lap value once and
     removes the old lapTicks debug objects, but its receiver tree is still
     under review against retail. No literal original helper names are claimed. */
  chaseLevelIndex_ = level;
  if (bestChaseLevelIndex_ < level)
    bestChaseLevelIndex_ = level;
  chaseLevel_ = copGameInfo_->levels + chaseLevelIndex_;
  InitializeChaseTimer(ConfiguredEngagementLapTime());
  blockadeDone_ = 0;
}


inline bool AICop_PerpChaseInfo::BlockadeDone() { return blockadeDone_ != 0; }

/* ---- CheckIfABlockadeCanBeSetup__13AIHigh_Player [retail AIH_PLAY.CPP:55-170;
 * 225/225 byte PASS, native ownership exact, full SLD attribution open] ---- */
/* Actual info/cop getters replace chaseInfo/cannotSetup and recover every
 * receiver. Type-return copies are optimized out without added qualifiers;
 * the final flags/type guard owns two separate retail regions. Literal helper
 * and caller-copy spellings are not uniquely proved by this native contract. */
int AIHigh_Player::CheckIfABlockadeCanBeSetup()



{

  int copLoop;
  copLevel_t*pLevel;
  int nCopsNeeded[2];
  int ready[2];
  int assigned[2];
  int split;
  pLevel = this->perpChaseInfo_.GetChaseLevel();

  memset(ready,0,sizeof(ready));
  memset(assigned,0,sizeof(assigned));

  split = Cars_gNumHumanRaceCars == 2;
  if ((pLevel->numBlockaders == 0) || this->perpChaseInfo_.BlockadeDone() ||
      ((basicPerpInfo_.CopsAssigned(COP_REGULAR) < pLevel->copChasers[0]) && !split) ||
      ((basicPerpInfo_.CopsAssigned(COP_SUPER) < pLevel->copChasers[1]) && !split))
    goto return_false;

  nCopsNeeded[0] = pLevel->copBlockaders[0];
  nCopsNeeded[1] = pLevel->copBlockaders[1];

  for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {
    AIHigh_Cop *thisCop;
    thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
    if ((Cars_gCopCarList[copLoop]->AIFlags & 0xcU) == 0xc) {
      copType type = thisCop->Type();
      if (nCopsNeeded[type] > assigned[type]) {
        ready[type] = ready[type] + 1;
        assigned[type] = assigned[type] + 1;
        thisCop->blockade_.mode = 1;
        thisCop->Blockade()->target = this;
      }
    }
  }

  if ((nCopsNeeded[0] > assigned[0]) || (nCopsNeeded[1] > assigned[1])) {
    for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {
      AIHigh_Cop *thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
      if (((Cars_gCopCarList[copLoop]->AIFlags & 0xcU) == 8) &&
          (thisCop->BlockadeMode() != 2)) {
        copType type = thisCop->Type();
        if (nCopsNeeded[type] > assigned[type]) {
          assigned[type] = assigned[type] + 1;
          thisCop->blockade_.mode = 1;
          thisCop->Blockade()->target = this;
        }
      }
    }
  }

  if ((Cars_gNumHumanRaceCars != 1) && (nCopsNeeded[1] > assigned[1])) {
    for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {
      AIHigh_Cop *thisCop;
      thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
      if ((Cars_gCopCarList[copLoop]->AIFlags & 0xcU) == 8) {
        copType type = thisCop->Type();
        if ((type == COP_REGULAR) &&
            (nCopsNeeded[1] > assigned[1]) && (assigned[1] == 0)) {
          assigned[1] = 1;
          thisCop->blockade_.mode = 4;
          thisCop->Blockade()->target = this;
        }
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
        /* SOURCE-RECOVERY CARRIER: needsBlockadeCop -- folding this short-circuit result into
           the update guard emits 669 rather than 674 instructions and changes
           121 by reshaping the array bases and the following long loop. */
        bool needsBlockadeCop;
        thisCop = (AIHigh_Cop *)highLevelAIObjs[
            Cars_gCopCarList[copLoop]->carIndex];
        needsBlockadeCop = false;
        if (((Cars_gCopCarList[copLoop]->AIFlags & 4U) != 0) &&
            (thisCop->blockade_.mode == 1)) {
          needsBlockadeCop = needed[thisCop->type_] != 0;
        }
        if (needsBlockadeCop) {
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
    blockadeFlags = (u_int)(u_char)gBlockadeTypes[blockadeType];

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
        Speech::Mobile(blockadeCar->carObj_)->SpikeBelt();

      }

      else {
        Speech::Mobile(blockadeCar->carObj_)->RoadBlock();

      }

      Speech::Mobile(blockadeCar->carObj_)->Engage(this->carObj_);

      Speech::Dispatch()->Grant();

      Speech::Dispatch()->Ready(blockadeCar->carObj_);

    }
  }

  return;

}








/* ---- CheckForNewLevel__13AIHigh_Playeri [retail AIH_PLAY.CPP:434-511;
 * 184/184 byte PASS, native/source/SLD recovery still open] ---- */

inline int AITrigger_TriggerManager::InvNumTriggers() { return invNumTriggers_; }

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

    this->basicPerpInfo_.SetCrime(CRIME_NONE);

    return;

  }

  /* Retail AIHigh_Player_vtable[3] @0x800550b0 is
     CheckForCrimes__16AIHigh_BasicPerp @0x8005b500.  Keep the ABI-shaped call
     local until the explicit AIHigh hierarchy vptr is restored as C++ virtual
     source; the former pa_Var1 decompiler alias is not required for codegen. */
  this->CheckForCrimes();

  if (this->basicPerpInfo_.GetCrime() != CRIME_NONE) {

    if (force == 0) {

      /* UNRESOLVED RECONSTRUCTION: doIt has no retail caller record. Current
         direct/Boolean-query forms lose two result-funnel instructions
         (8dif/182 versus184); that does not prove an original object existed. */
      bool doIt = false;

      if (this->perpChaseInfo_.RemainingEngagementTime() <= 0) {

        doIt = true;

      }

      if (!doIt) goto check_level_changed;

    }

    {

      chaseLevel = chaseLevel + 1;

      if (this->perpChaseInfo_.GetNumLevels() <= chaseLevel) {

        chaseLevel = this->perpChaseInfo_.GetNumLevels() + -2;

      }

      this->perpChaseInfo_.SetChaseLevel(chaseLevel);

    }

  }

/* Semantic fallback label, not a recovered original spelling. */
check_level_changed:
  if (oldChaseLevel != this->perpChaseInfo_.GetChaseLevelIndex()) {
    this->newTriggerProb_ = triggerManagerCops->InvNumTriggers() *
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

  Speech::Mobile(Cars_gList[highestRankedCopIndex])->Catch(arrestType);

  return;

}








/* ---- MaintainAvailableCops__13AIHigh_Player [AIH_PLAY.CPP:669-744;
 * byte PASS, declaration order and full SLD recovery remain open] ---- */

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
  for (int playLoop = 0; playLoop < Cars_gNumRaceCars; playLoop++) {
    Car_tObj *playerCarObj = Cars_gRaceCarList[playLoop];
    AIHigh_Player *playerHighObj = (AIHigh_Player *)highLevelAIObjs[playerCarObj->carIndex];
    need[0] += playerHighObj->perpChaseInfo_.GetChaseLevel()->copBlockaders[0];
    need[1] += playerHighObj->perpChaseInfo_.GetChaseLevel()->copBlockaders[1];
    need[0] += playerHighObj->perpChaseInfo_.GetChaseLevel()->copChasers[0];
    need[1] += playerHighObj->perpChaseInfo_.GetChaseLevel()->copChasers[1];
  }
  for (int copLoop = 0, playLoop; copLoop < Cars_gNumCopCars; copLoop++) {
    Car_tObj *copCarObj = Cars_gCopCarList[copLoop];
    AIHigh_Cop *copHighObj = (AIHigh_Cop *)highLevelAIObjs[copCarObj->carIndex];
    if ((copCarObj->AIFlags & 4U) == 0 || copHighObj->BlockadeMode() == 1 || copHighObj->BlockadeMode() == 2) {
      playLoop = copHighObj->Type();
      got[playLoop]++;
      availableCops--;
      copCarObj->AIFlags |= 8;
    }
    else {
      copCarObj->AIFlags &= ~8U;
    }
  }
  for (int copLoop = 0; availableCops > 0 && copLoop < Cars_gNumCopCars; copLoop++) {
    Car_tObj *copCarObj = Cars_gCopCarList[copLoop];
    if ((copCarObj->AIFlags & 8U) == 0) {
      AIHigh_Cop *copHighObj = (AIHigh_Cop *)highLevelAIObjs[copCarObj->carIndex];
      int playLoop = copHighObj->Type();
      if (need[playLoop] > got[playLoop]) {
        got[playLoop]++;
        availableCops--;
        copCarObj->AIFlags |= 8;
      }
    }
  }
}








/* Candidate chase-info initializer boundaries: all four old caller captures
 * are absent at129/129, but the nested stored-pointer home and receiver tree
 * still differ from retail. No original helper spelling is asserted. */
static inline copLevel_t *CopGameLevelAt(copGame_t *copGameInfo,int index)
{
  return copGameInfo->levels + index;
}
inline void AICop_PerpChaseInfo::SetCopGameInfo(copGame_t *copGameInfo)
{
  copGameInfo_ = copGameInfo;
  chaseLevelIndex_ = 0;
  engagementTime_ = 0;
  bestChaseLevelIndex_ = 0;
  chaseLevel_ = CopGameLevelAt(copGameInfo_,GetChaseLevelIndex());
  blockadeDone_ = 0;
  copFreeTicks_ = 0;
  totalEngagementPercent_ = 0;
  engagementPercentIncreasePerTick_ = 0;
}

inline AICop_PerpChaseInfo::AICop_PerpChaseInfo()
{
  copGame_t*copGameInfo;
  int lapIndex;
  int gameIndex;




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

  SetCopGameInfo(copGameInfo);

}

/* ---- __13AIHigh_PlayerP8Car_tObj [retail AIH_PLAY.CPP:750-762;
 * 129/129 byte PASS, native/source/SLD recovery still open] ---- */
AIHigh_Player::AIHigh_Player(Car_tObj *carObj) : AIHigh_BasicPerp(carObj)
{
  this->numWarnings_ = 0;

  this->numBusts_ = 0;

  if (GameSetup_gData.cops != 0) {
    this->newTriggerProb_ = triggerManagerCops->InvNumTriggers() *
                           this->perpChaseInfo_.GetChaseLevel()->copsPerLap;
    this->lastTriggerCheckSlice_ = (int)this->carObj_->N.simRoadInfo.slice;
    this->perpChaseInfo_.SetChaseLevel(0);
  }

}








/* ---- HandleCops__13AIHigh_Player [retail AIH_PLAY.CPP:808-868;
 * 104/104 byte PASS, native/source/SLD recovery still open] ---- */

void AIHigh_Player::HandleCops()



{
  copLevel_t *pLevel;




  pLevel = this->perpChaseInfo_.GetChaseLevel();

  if (Cars_gNumCopCars == 0) return;


    this->MaintainAvailableCops();

    if (this->CheckIfABlockadeCanBeSetup()) {

      this->SetupBlockade();

    }

    if (pLevel->numBlockaders == 0) {

      this->CleanupBlockaders(0);

    }

    {
      int ticks;
      int totalCopsEngaged;
      /* UNRESOLVED RECONSTRUCTION: pInfo still stands in for an original
         receiver boundary; candidate timer APIs do not yet preserve its store/reload. */
      AICop_PerpChaseInfo *pInfo = &this->perpChaseInfo_;
      /* UNRESOLVED RECONSTRUCTION: this is the reverse-motion bit from
         currentSpeed*direction, not a yaw quantity. It has no retail local
         record; direct shift selection is44dif/102 versus104 on this shape. */
      u_int prodSlipYawNeg;

      prodSlipYawNeg =
          (u_int)(this->carObj_->currentSpeed * this->carObj_->direction) >> 31;
      ticks = AI_elapsedTime;
      totalCopsEngaged = this->basicPerpInfo_.copsAssigned_[0] +
                         this->basicPerpInfo_.copsAssigned_[1];
      if (0 < totalCopsEngaged) {
        pInfo->copFreeTicks_ = 0;
        if (-2 < pInfo->engagementTime_ / 0x10000) {
          this->perpChaseInfo_.engagementTime_ -=
              ticks << (prodSlipYawNeg ? 0xf : 0x10);
          if (pInfo->RemainingEngagementTime() <
              pInfo->ConfiguredEngagementLapTime() * 0x20 - 0x80) {
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

  return;
}








/* ---- CleanupBlockaders__13AIHigh_Playeri  AIHigh_Player::CleanupBlockaders  [AIH_PLAY.CPP:871-902] SLD-VERIFIED ---- */

void AIHigh_Player::CleanupBlockaders(int forceClearAll)
{
  int clearWaitingBlockaders = 0;
  if ((0 < (this->carObj_->stats).numArrests) ||
      (1 < (this->carObj_->stats).finishType) || (forceClearAll != 0)) {
    clearWaitingBlockaders = 1;
  }
  for (int copLoop = 0; copLoop < Cars_gNumCopCars; copLoop++) {
    AIHigh_Cop *thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
    blockade_t *blockade = thisCop->Blockade();
    if (((blockade->mode == 1) || (blockade->mode == 4) ||
         ((blockade->mode == 2) && clearWaitingBlockaders)) &&
        (blockade->target == this)) {
      blockade->mode = (blockadeMode_t)0;
      thisCop->AssignToPlayer((AIHigh_Player *)0x0);
    }
  }
}








/* ---- HandlePullOver__13AIHigh_Player  AIHigh_Player::HandlePullOver  [AIH_PLAY.CPP:906-1014] SLD-VERIFIED ---- */

void AIHigh_Player::HandlePullOver()
{
  int chaseTime;
  bool shouldIssueWarning;
  if (this->pullOverMode_ != 0) {
    this->beatingTicksLeft_ -= AI_elapsedTime;
    if (0 < this->beatingTicksLeft_) {
      return;
    }
    if ((this->carObj_)->carIndex < 2) {
      Hud_Perp_OverlayOff((this->carObj_)->carIndex);
    }
    this->lastPullOverTime_ = GameTicks();
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
    this->lastPullOverTime_ = GameTicks();
    /* SOURCE-RECOVERY CARRIER: shouldIssueWarning -- retail materializes this short-circuit
       result in $a2.  Folding it into the following guard keeps 307
       instructions but changes 18 authoritative instructions/registers. */
    shouldIssueWarning = false;
    if (((this->basicPerpInfo_.crime_ != 4) &&
         (((this->carObj_)->stats).numFines == 0)) &&
        (chaseInfo->copGameInfo_->levels[chaseInfo->bestChaseLevelIndex_]
             .numWarningsAdded != 0)) {
      shouldIssueWarning = chaseTime < chaseInfo->GetChaseLevel()->warningTicks;
    }
  }
    if ((shouldIssueWarning) && (this->numWarnings_ < 2)) {
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








/* end of aih_play.cpp */

char gBlockadeTypes[5] = { 5, 6, 4, 2, 0 };   /* @0x8013c568 (.sdata at -G8); shared with aih_btccop */
