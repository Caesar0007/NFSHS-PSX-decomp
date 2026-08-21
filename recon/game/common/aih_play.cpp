/* game/common/aih_play.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
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


/* ---- CheckIfABlockadeCanBeSetup__13AIHigh_Player  AIHigh_Player::CheckIfABlockadeCanBeSetup  [AIH_PLAY.CPP:55-170] SLD-VERIFIED ---- */

int AIHigh_Player::CheckIfABlockadeCanBeSetup()



{
  int copLoop;
  copLevel_t*pLevel;
  int nCopsNeeded[2];
  int ready[2];
  int assigned[2];
  int split;
  AICop_PerpChaseInfo *chaseInfo;
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
    Car_tObj *copCar = Cars_gCopCarList[copLoop];
    thisCop = (AIHigh_Cop *)highLevelAIObjs[copCar->carIndex];
    if ((copCar->AIFlags & 0xcU) == 0xc) {
      int type = thisCop->type_;
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
      Car_tObj *copCar = Cars_gCopCarList[copLoop];
      thisCop = (AIHigh_Cop *)highLevelAIObjs[copCar->carIndex];
      if (((copCar->AIFlags & 0xcU) == 8) &&
          (thisCop->blockade_.mode != 2)) {
        int type = thisCop->type_;
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
      Car_tObj *copCar = Cars_gCopCarList[copLoop];
      thisCop = (AIHigh_Cop *)highLevelAIObjs[copCar->carIndex];
      if (((copCar->AIFlags & 0xcU) == 8) &&
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
      AITrigger_TriggerManager *manager;
      if ((AILife_IsSliceInAnyVisibleArea(blockade->roadblock.slice) != 0) ||
          (AILife_IsSliceCloseToAnyCopCar(blockade->roadblock.slice) != 0)) {
        manager = triggerManagerCops;
        blockadeHandle = blockade->roadblock.slice + 1;
        if (gNumSlices <= blockadeHandle) {
          /* w54-a12 (27 -> 19 diffs): the `gNumSlices - 1` MUST be a named temp. Written
           * inline, gcc-2.8 cse/combine reassociates `slice - (n-1)` into `(slice+1) - n`
           * (reusing the just-computed blockadeHandle) and drops retail's `addiu v0,v1,-1`
           * + `subu a1,a2,v0` pair, which also frees the original `slice` load's register.
           * Catalog "keep arithmetic UN-simplified" (methodology 3.14). */
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
      AICop_PerpChaseInfo *chaseInfo;
      AIHigh_Cop *thisCop;
      blockade_t *copBlockade;
      int one;
      for (copLoop = 0, one = 1, chaseInfo = &this->perpChaseInfo_;
           copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {

      thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
      if (((Cars_gCopCarList[copLoop]->AIFlags & 4U) != 0) &&
          (thisCop->blockade_.mode == one)) {

        if ((thisCop->type_ == one) && (nCopsNeeded[1] != 0)) {
          int addToSlice;
          int distance;

          copBlockade = &thisCop->blockade_;

          if (blockadeCar == (AIHigh_Cop *)0x0) {

            blockadeCar = thisCop;

          }

          nCopsNeeded[1] = nCopsNeeded[1] + -1;

          copBlockade->blockadeSpeechFlags = 0;
          copBlockade->flags = blockadeFlags;
          copBlockade->chaseLevel = chaseInfo->chaseLevelIndex_;
          copBlockade->mode = 2;

          addToSlice = ((posIndex / 2) * 2 + 3) * this->carObj_->direction;
          blockadeFlags = 0;
          copBlockade->slice = addToSlice >= 0
              ? (blockadeSlice + addToSlice >= gNumSlices
                    ? blockadeSlice + addToSlice - gNumSlices
                    : blockadeSlice + addToSlice)
              : (blockadeSlice + addToSlice < 0
                    ? blockadeSlice + addToSlice + gNumSlices
                    : blockadeSlice + addToSlice);

          copBlockade->direction = this->carObj_->direction;

          totalRoadWidth =
                       (BWorldSm_slices[copBlockade->slice].avgPavedWidthLf << 15) *
                       (BWorldSm_slices[copBlockade->slice].laneCount >> 4) +
                       (BWorldSm_slices[copBlockade->slice].avgPavedWidthRt << 15) *
                       (BWorldSm_slices[copBlockade->slice].laneCount & 0xf);

          if ((nCopsAvail[1] == one) && (nCopsAvail[0] == 0)) {

            copBlockade->latPos = ((u_int)totalRoadWidth >> 1) -
                (BWorldSm_slices[copBlockade->slice].avgPavedWidthLf << 15) *
                (BWorldSm_slices[copBlockade->slice].laneCount >> 4);

            copBlockade->rotation = 0xff;

          }

          else {

            if ((posIndex & 1) == 0) {
              copBlockade->latPos =

                   -((BWorldSm_slices[copBlockade->slice].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[copBlockade->slice].laneCount >> 4)) +
                   totalRoadWidth / 4;

              copBlockade->rotation = 0xbe;

            }

            else {

              copBlockade->latPos =

                   -((BWorldSm_slices[copBlockade->slice].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[copBlockade->slice].laneCount >> 4)) +
                   (totalRoadWidth / 4) * 3;

              copBlockade->rotation = -0xbe;

            }

          }

          randtemp = fastRandom * randSeed;

          copBlockade->target = this;
          copBlockade->reverse = 0;
          copBlockade->releaseTime =
              ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999;

          fastRandom = randtemp & 0xffff;

          distance = AIWorld_ApxSplineDistance(this->carObj_,copBlockade->slice);

          if (distance < 0) {

            distance = distance + 0xffff;

          }

          copBlockade->initialPlayerDistanceMetersInt = -(distance >> 0x10);

          if (-(distance >> 0x10) * (this->carObj_)->direction < 0) {

            copBlockade->initialPlayerDistanceMetersInt = 0;

          }

        }

        else {
          int addToSlice;
          int distance;

          if (nCopsNeeded[0] == 0) goto LAB_800620e8;

          copBlockade = &thisCop->blockade_;

          if (blockadeCar == (AIHigh_Cop *)0x0) {

            blockadeCar = thisCop;

          }

          nCopsNeeded[0] = nCopsNeeded[0] + -1;

          copBlockade->blockadeSpeechFlags = 0;
          copBlockade->flags = blockadeFlags;
          copBlockade->chaseLevel = chaseInfo->chaseLevelIndex_;
          copBlockade->mode = 2;

          addToSlice = ((posIndex / 2) * 2 + 3) * this->carObj_->direction;
          blockadeFlags = 0;
          copBlockade->slice = addToSlice >= 0
              ? (blockadeSlice + addToSlice >= gNumSlices
                    ? blockadeSlice + addToSlice - gNumSlices
                    : blockadeSlice + addToSlice)
              : (blockadeSlice + addToSlice < 0
                    ? blockadeSlice + addToSlice + gNumSlices
                    : blockadeSlice + addToSlice);

          randtemp = fastRandom * randSeed;

          copBlockade->direction = this->carObj_->direction;

          fastRandom = randtemp & 0xffff;

          if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 < 300) {

            copBlockade->reverse = one;

          }

          else {

            copBlockade->reverse = 0;

          }

          randtemp = fastRandom * randSeed;

          copBlockade->releaseTime =
              ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999;

          fastRandom = randtemp & 0xffff;

          distance = AIWorld_ApxSplineDistance(this->carObj_,copBlockade->slice);

          if (distance < 0) {

            distance = distance + 0xffff;

          }

          copBlockade->initialPlayerDistanceMetersInt = -(distance >> 0x10);

          if (-(distance >> 0x10) * (this->carObj_)->direction < 0) {

            copBlockade->initialPlayerDistanceMetersInt = 0;

          }

          totalRoadWidth =
                       (BWorldSm_slices[copBlockade->slice].avgPavedWidthLf << 15) *
                       (BWorldSm_slices[copBlockade->slice].laneCount >> 4) +
                       (BWorldSm_slices[copBlockade->slice].avgPavedWidthRt << 15) *
                       (BWorldSm_slices[copBlockade->slice].laneCount & 0xf);

          if ((nCopsAvail[0] == one) && (nCopsAvail[1] == 0)) {

            copBlockade->latPos = ((u_int)totalRoadWidth >> 1) -
                (BWorldSm_slices[copBlockade->slice].avgPavedWidthLf << 15) *
                (BWorldSm_slices[copBlockade->slice].laneCount >> 4);

            copBlockade->rotation = 0xff;

          }

          else {

            if ((posIndex & 1) == 0) {
              copBlockade->latPos =

                   -((BWorldSm_slices[copBlockade->slice].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[copBlockade->slice].laneCount >> 4)) +
                   totalRoadWidth / 4;

              copBlockade->rotation = 0xbe;

            }

            else {

              copBlockade->latPos =

                   -((BWorldSm_slices[copBlockade->slice].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[copBlockade->slice].laneCount >> 4)) +
                   (totalRoadWidth / 4) * 3;

              copBlockade->rotation = -0xbe;

            }

          }

          copBlockade->target = this;

        }

        if (requestSpikeBeltAtSlice != -1) {
          saySpikeBelt = true;
          copBlockade->requestSpikeBeltAtSlice = requestSpikeBeltAtSlice;
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
        Speaker *speaker = (Speaker *)Speech_Mobile(blockadeCar->carObj_);
        (*(*speaker->_vf)[11].pfn)
            ((int)speaker + (*speaker->_vf)[11].delta);

      }

      else {
        Speaker *speaker = (Speaker *)Speech_Mobile(blockadeCar->carObj_);
        (*(*speaker->_vf)[10].pfn)
            ((int)speaker + (*speaker->_vf)[10].delta);

      }

      {
        Speaker *speaker = (Speaker *)Speech_Mobile(blockadeCar->carObj_);
        (*(*speaker->_vf)[6].pfn)((int)speaker + (*speaker->_vf)[6].delta,
                    this->carObj_);
      }

      {
        Speaker *speaker = (Speaker *)Speech_Dispatch();
        (*(*speaker->_vf)[4].pfn)((int)speaker + (*speaker->_vf)[4].delta);
      }

      {
        Speaker *speaker = (Speaker *)Speech_Dispatch();
        (*(*speaker->_vf)[5].pfn)((int)speaker + (*speaker->_vf)[5].delta,
                    blockadeCar->carObj_);
      }

    }
  }

  return;

}








/* ---- CheckForNewLevel__13AIHigh_Playeri  AIHigh_Player::CheckForNewLevel  [AIH_PLAY.CPP:434-511] SLD-VERIFIED ---- */

void AIHigh_Player::CheckForNewLevel(int force)

{
  int chaseLevel;
  int oldChaseLevel;

  __vtbl_ptr_type (*pa_Var1) [3];



  /* W57-A11: SLD/SYM-shaped rewrite.  The retail SYM 8c block lists exactly TWO
     int locals (chaseLevel $10=s0, oldChaseLevel $13=s3) plus a chain of INLINED
     AICop_PerpChaseInfo methods, each contributing its own block-scoped `this`
     pseudo ($3=v1, $10=s0, $4=a0, $11=s1) and one `level` parameter ($10=s0).
     The former single fn-scope `pInfo` pointer was ONE global allocno spanning
     the whole body (w46 STORAGE-SCOPE LAW) -- split per region below.
     SLD map: 434 prologue | 438 init+finishType test | 439 the whole first
     inlined SetChaseLevel chunk | 443 crime_=0 + return | 475 vf call |
     476 crime test | 490 force/engagementTime gate | 491-493 level bump |
     494 the second inlined SetChaseLevel chunk | 503 index compare |
     504-505 newTriggerProb_ | 511 close.  */

  AICop_PerpChaseInfo *pci = &this->perpChaseInfo_;

  oldChaseLevel = pci->chaseLevelIndex_;

  chaseLevel = oldChaseLevel;

  if (1 < ((this->carObj_)->stats).finishType) {

    AICop_PerpChaseInfo *p = pci;

    int lapTicks;

    p->chaseLevelIndex_ = 0;

    if (p->bestChaseLevelIndex_ < 0) {

      p->bestChaseLevelIndex_ = 0;

    }

    p->chaseLevel_ = (p->copGameInfo_)->levels + p->chaseLevelIndex_;

    lapTicks = ((p->chaseLevel_)->engagementLapFraction * AITune_gRoughLapTime)
               / 0x10000;

    p->engagementTime_ = lapTicks << 0x15;

    p->engagementPercentIncreasePerTick_ = 0x10000 / (lapTicks << 5);

    if (GameSetup_gData.numLaps == 2) {

      p->engagementPercentIncreasePerTick_ =
          fixedmult(p->engagementPercentIncreasePerTick_,0x13333);

    }

    else if (GameSetup_gData.numLaps == 4) {

      p->engagementPercentIncreasePerTick_ =
          fixedmult(p->engagementPercentIncreasePerTick_,0xa8f5);

    }

    p->blockadeDone_ = 0;

    this->basicPerpInfo_.crime_ = 0;

    return;

  }

  pa_Var1 = this->_vf;

  (**(int (**)(...))((char *)pa_Var1 + 28))

            ((int)this + *(short *)((char *)pa_Var1 + 24));

  if (this->basicPerpInfo_.crime_ != 0) {

    if (force == 0) {

      int doIt = 0;

      if (this->perpChaseInfo_.engagementTime_ / 0x10000 <= 0) {

        doIt = 1;

      }

      if (doIt == 0) goto LAB_8006249c;

    }

    {

      AICop_PerpChaseInfo *pi = &this->perpChaseInfo_;

      int numLevels;

      numLevels = (pi->copGameInfo_)->numLevels;

      chaseLevel = chaseLevel + 1;

      if (numLevels <= chaseLevel) {

        chaseLevel = numLevels + -2;

      }

      {

        AICop_PerpChaseInfo *p = pi;

        /* SYM-OPTIMIZED: level -- SetChaseLevel's inlined parameter aliases
           chaseLevel in $s0; it has no independent source storage here. */

        int lapTicks;

        p->chaseLevelIndex_ = chaseLevel;

        if (p->bestChaseLevelIndex_ < chaseLevel) {

          p->bestChaseLevelIndex_ = chaseLevel;

        }

        p->chaseLevel_ = (p->copGameInfo_)->levels + p->chaseLevelIndex_;

        lapTicks = ((p->chaseLevel_)->engagementLapFraction * AITune_gRoughLapTime)
                   / 0x10000;

        p->engagementTime_ = lapTicks << 0x15;

        p->engagementPercentIncreasePerTick_ = 0x10000 / (lapTicks << 5);

        if (GameSetup_gData.numLaps == 2) {

          p->engagementPercentIncreasePerTick_ =
              fixedmult(p->engagementPercentIncreasePerTick_,0x13333);

        }

        else if (GameSetup_gData.numLaps == 4) {

          p->engagementPercentIncreasePerTick_ =
              fixedmult(p->engagementPercentIncreasePerTick_,0xa8f5);

        }

        p->blockadeDone_ = 0;

      }

    }

  }

LAB_8006249c:
  {

    AICop_PerpChaseInfo *pt = &this->perpChaseInfo_;

    if (oldChaseLevel == pt->chaseLevelIndex_) {

      return;

    }

    this->newTriggerProb_ =

         triggerManagerCops->invNumTriggers_ *
         (pt->chaseLevel_)->copsPerLap;

  }

  return;

}








/* ---- HandleSpeech__13AIHigh_Player  AIHigh_Player::HandleSpeech  [AIH_PLAY.CPP:517-663] SLD-VERIFIED ---- */

void AIHigh_Player::HandleSpeech()



{
  int highestRankedCopIndex;
  int arrestType;
  int player;

  Speaker *pSVar1;

  int iVar3;

  int _Var4;



  player = this->positionVSCopList_[0].carIndex;

  if (player == -1) {

    highestRankedCopIndex = (*(int *)((char *)Cars_gCopCarList[0] + 0x254));

  }

  else {

    highestRankedCopIndex = player;

  }

  player = this->positionVSCopList_[1].carIndex;

  if ((player != -1) && (player < highestRankedCopIndex)) {

    highestRankedCopIndex = player;

  }

  player = this->positionVSCopList_[2].carIndex;

  if ((player != -1) && (player < highestRankedCopIndex)) {

    highestRankedCopIndex = player;

  }

  _Var4 = this->pullOverMode_;

  arrestType = (this->carObj_)->carIndex;

  if (_Var4 == 1) goto LAB_pullover_flag;

  if (1 < (int)_Var4) {

    if (_Var4 == 2) goto LAB_pullover_arrest;

    if (_Var4 == 3) goto LAB_pullover_evade;

  }

  iVar3 = 4;

  goto LAB_800625d0;

LAB_pullover_flag:

  Hud_Perp_OverlayOn(arrestType,0);

  iVar3 = 2;

  goto LAB_800625d0;

LAB_pullover_arrest:

  Hud_Perp_OverlayOn(arrestType,1);

  iVar3 = 8;

  if (2 < this->numBusts_) {

    iVar3 = this->numBusts_ + 6;

  }

  goto LAB_800625d0;

LAB_pullover_evade:

  Hud_Perp_OverlayOn(arrestType,2);

  iVar3 = 1;

LAB_800625d0:

  if (AICop_gRoadBlockState != kAICop_RoadBlockState_None) {

    AICop_gRoadBlockState = kAICop_RoadBlockState_PerpPassed;

  }

  pSVar1 = (Speaker *)Speech_Mobile(Cars_gList[highestRankedCopIndex]);

  (*(*pSVar1->_vf)[9].pfn)((int)pSVar1 + (*pSVar1->_vf)[9].delta,iVar3);

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

  int iVar1;

  Car_tObj *pCVar2;

  copLevel_t *pcVar3;

  int iVar4;

  int a;

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
  /* MATCH: keep the copGameInfo_ store ahead of the retail pointer copy.
   * The memory barrier and identity fence are both empty-template/zero-insn;
   * together they preserve retail's `sw v1,4(a1); addu v0,v1,zero`. */
  __asm__ __volatile__("" : : : "memory");

  copGame_t *copGameInfoCopy = copGameInfo;
  __asm__("" : "=r"(copGameInfoCopy) : "0"(copGameInfoCopy));

  pInfo->chaseLevelIndex_ = 0;

  pInfo->engagementTime_ = 0;

  int chaseIndex = pInfo->chaseLevelIndex_;

  pInfo->bestChaseLevelIndex_ = 0;

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
    /* MATCH: SYM shows pInfo's live range ENDS after the copGameInfo_/chaseLevel_ init above;
       a FRESH "this"-named AICop_PerpChaseInfo* is re-declared at block scope 0x800629a0
       (reg $a1, later copied to the callee-saved $s0 to survive the fixedmult() jal) rather
       than keeping the first pInfo alive across the whole ctor. Re-derive it here. */
    AICop_PerpChaseInfo *pInfo2 = &this->perpChaseInfo_;

  pCVar2 = this->carObj_;

  this->newTriggerProb_ =

       triggerManagerCops->invNumTriggers_ * (pInfo2->chaseLevel_)->copsPerLap;

  AICop_PerpChaseInfo *pInfo3 = pInfo2;

  this->lastTriggerCheckSlice_ = (int)(pCVar2->N).simRoadInfo.slice;

  pInfo3->chaseLevelIndex_ = 0;

  if (pInfo3->bestChaseLevelIndex_ < 0) {

    pInfo3->bestChaseLevelIndex_ = 0;

  }

  {

    /* W57-A11: same inlined AICop_PerpChaseInfo::SetChaseLevel chunk as
       CheckForNewLevel -- the /0x10000 form gives retail's SINGLE in-place
       `sra v1,v1,16` (a named `iVar1>>16` used twice duplicates the shift into
       the branch delay slot), and DUPLICATING the fixedmult call in both arms
       lets cross_jump merge them while each arm materializes its constant
       straight into $a1 (a shared temp goes through a callee-saved reg). */
    int lapTicks;
    pInfo3->chaseLevel_ = (pInfo3->copGameInfo_)->levels + pInfo3->chaseLevelIndex_;

    lapTicks = ((pInfo3->chaseLevel_)->engagementLapFraction * AITune_gRoughLapTime)
               / 0x10000;

    pInfo3->engagementTime_ = lapTicks << 0x15;

    pInfo3->engagementPercentIncreasePerTick_ = 0x10000 / (lapTicks << 5);

    if (GameSetup_gData.numLaps == 2) {

      pInfo3->engagementPercentIncreasePerTick_ =
          fixedmult(pInfo3->engagementPercentIncreasePerTick_,0x13333);

    }

    else if (GameSetup_gData.numLaps == 4) {

      pInfo3->engagementPercentIncreasePerTick_ =
          fixedmult(pInfo3->engagementPercentIncreasePerTick_,0xa8f5);

    }

    pInfo3->blockadeDone_ = 0;

  }

  return;
  }

}








/* ---- HandleCops__13AIHigh_Player  AIHigh_Player::HandleCops  [AIH_PLAY.CPP:808-868] SLD-VERIFIED ---- */

void AIHigh_Player::HandleCops()



{
  copLevel_t *pLevel;
  int ticks;
  int totalCopsEngaged;

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

  Car_tObj *pCVar2;

  blockadeMode_t bVar3;



  pCVar2 = this->carObj_;

  clearWaitingBlockaders = 0;

  if ((0 < (pCVar2->stats).numArrests) || (1 < (pCVar2->stats).finishType) || (forceClearAll != 0)) {

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

    bVar3 = (blockadeMode_t)blockade->mode;

    if ((((bVar3 == 1) || (bVar3 == 4)) || ((bVar3 == 2 && (clearWaitingBlockaders)))) &&

       (blockade->target == this)) {

      blockade->mode = 0;

      thisCop->AssignToPlayer((AIHigh_Player *)0x0);

    }

    copLoop = copLoop + 1;

  }

  return;

}








/* ---- HandlePullOver__13AIHigh_Player  AIHigh_Player::HandlePullOver  [AIH_PLAY.CPP:906-1014] SLD-VERIFIED ---- */

static inline int AICop_IsLastChaseLevel(AICop_PerpChaseInfo *info)
{
  return info->bestChaseLevelIndex_ == info->copGameInfo_->numLevels - 1;
}

void AIHigh_Player::HandlePullOver()
{
  int chaseTime;
  bool bVar1;
  int iVar2;
  int iVar5;
  int a;
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
    {
      AICop_PerpChaseInfo *chaseInfo = &this->perpChaseInfo_;
      int engagementLapTime;

      chaseInfo->chaseLevelIndex_ = 0;
      if (chaseInfo->bestChaseLevelIndex_ < 0) {
        chaseInfo->bestChaseLevelIndex_ = 0;
      }
      chaseInfo->chaseLevel_ =
          chaseInfo->copGameInfo_->levels + chaseInfo->chaseLevelIndex_;
      engagementLapTime =
          chaseInfo->chaseLevel_->engagementLapFraction * AITune_gRoughLapTime;
      if (engagementLapTime < 0) {
        engagementLapTime = engagementLapTime + 0xffff;
      }
      iVar5 = (engagementLapTime >> 0x10) << 5;
      a = 0x10000 / iVar5;
      chaseInfo->engagementTime_ = (engagementLapTime >> 0x10) << 0x15;
      chaseInfo->engagementPercentIncreasePerTick_ = a;
      if (GameSetup_gData.numLaps == 2) {
        iVar2 = 0x13333;
      }
      else if (GameSetup_gData.numLaps == 4) {
        iVar2 = 0xa8f5;
      }
      else {
        goto LAB_80062f48;
      }
      iVar2 = fixedmult(a,iVar2);
      chaseInfo->engagementPercentIncreasePerTick_ = iVar2;
LAB_80062f48:
      chaseInfo->blockadeDone_ = 0;
    }
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

  iVar2 = this->CheckIfCaught();
  if (iVar2 == 0) {
    return;
  }
  (this->carObj_)->pullOver = 1;
  this->CleanupBlockaders(1);
  {
    AICop_PerpChaseInfo *chaseInfo = &this->perpChaseInfo_;
    copLevel_t *pcVar6;
    int engagementLapTime;
    int chaseLapTime;

    pcVar6 = chaseInfo->chaseLevel_;
    engagementLapTime = pcVar6->engagementLapFraction * AITune_gRoughLapTime;
    if (engagementLapTime < 0) {
      engagementLapTime = engagementLapTime + 0xffff;
    }
    chaseLapTime = (engagementLapTime >> 0x10) * 0x20;
    iVar5 = chaseInfo->engagementTime_;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xffff;
    }
    chaseTime = chaseLapTime - (iVar5 >> 0x10);
    this->beatingTicksLeft_ = pcVar6->beatingTicks;
    this->lastPullOverTime_ = simGlobal.gameTicks;
    bVar1 = false;
    if (((this->basicPerpInfo_.crime_ != 4) &&
         (((this->carObj_)->stats).numFines == 0)) &&
        (chaseInfo->copGameInfo_->levels[chaseInfo->bestChaseLevelIndex_]
             .numWarningsAdded != 0)) {
      bVar1 = chaseTime < chaseInfo->chaseLevel_->warningTicks;
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
      iVar5 = GameSetup_gData.numLaps;
      /* w54-a12 (27 -> PASS 307/307): the ternary must land in a NAMED index variable and
       * the subscript must use that variable -- a ternary written INSIDE the subscript lets
       * gcc constant-fold each arm into a pre-scaled BYTE offset (li 8 / 0 + addu base) and
       * loses retail's `sll idx,2; addu idx,base` index form.  Paired with the compare
       * written numBusts_-FIRST (`numBusts_ >= table[i]`, catalog 05H "compare-operand order
       * IS load order"): that is what puts retail's `lw numBusts` before `lw table[i]` and
       * settles the idx/base v1-vs-v0 coloring. Do not "simplify" either back. */
      lapIndex = iVar5 == 2 ? 0 : (iVar5 == 4 ? 1 : 2);
      if ((this->numBusts_ >= AIHigh_Player_kNumArrestsByLap[lapIndex]) ||
          (AICop_IsLastChaseLevel(&this->perpChaseInfo_) &&
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
