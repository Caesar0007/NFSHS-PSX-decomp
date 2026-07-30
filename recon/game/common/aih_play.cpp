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
char         gBlockadeTypes[5] = { 5, 6, 4, 2, 0 };   /* @0x8013c568 */


/* ---- CheckIfABlockadeCanBeSetup__13AIHigh_Player  AIHigh_Player::CheckIfABlockadeCanBeSetup  [AIH_PLAY.CPP:55-170] SLD-VERIFIED ---- */

int AIHigh_Player::CheckIfABlockadeCanBeSetup()



{
  int copLoop;
  copLevel_t*pLevel;
  int nCopsNeeded[2];
  int ready[2];
  int assigned[2];
  int split;
  AIHigh_Cop*thisCop;

  bool bVar1;

  int iVar2;

  int iVar3;

  Car_tObj *pCVar4;

  int *piVar5;

  AIHigh_Base *pAVar6;

  int iVar7;

  Car_tObj **ppCVar8;

  copLevel_t *pcVar9;

  int local_28 [4];

  int local_18;

  int local_14;

  

  pcVar9 = (this->perpChaseInfo_).chaseLevel_;

  memset((u_char *)(local_28 + 2),'\0',8);

  memset((u_char *)(local_28 + 4),'\0',8);

  iVar7 = Cars_gNumCopCars;

  bVar1 = false;

  if ((((pcVar9->numBlockaders == 0) || ((this->perpChaseInfo_).blockadeDone_ != 0)) ||

      ((this->basicPerpInfo_.copsAssigned_[0] < pcVar9->copChasers[0] &&

       (Cars_gNumHumanRaceCars != 2)))) ||

     ((this->basicPerpInfo_.copsAssigned_[1] < pcVar9->copChasers[1] &&

      (Cars_gNumHumanRaceCars != 2)))) {

    bVar1 = true;

  }

  iVar3 = 0;

  if (!bVar1) {

    local_28[0] = pcVar9->copBlockaders[0];

    local_28[1] = pcVar9->copBlockaders[1];

    ppCVar8 = Cars_gCopCarList;

    for (iVar3 = 0; iVar2 = Cars_gNumCopCars, iVar3 < iVar7; iVar3 = iVar3 + 1) {

      pAVar6 = highLevelAIObjs[(*ppCVar8)->carIndex];

      if (((*ppCVar8)->AIFlags & 0xcU) == 0xc) {

        pCVar4 = pAVar6[1].carObj_;

        piVar5 = local_28 + (int)&(pCVar4->N).oldSlice;

        if (*piVar5 < local_28[(int)pCVar4]) {

          local_28[(int)((int)&(pCVar4->N).objID + 2)] =

               local_28[(int)((int)&(pCVar4->N).objID + 2)] + 1;

          *piVar5 = *piVar5 + 1;

          pAVar6[1].stateType_ = 1;

          pAVar6[1].schedulingOff_ = (int)this;

        }

      }

      ppCVar8 = ppCVar8 + 1;

    }

    iVar7 = 0;

    if ((local_18 < local_28[0]) || (local_14 < local_28[1])) {

      ppCVar8 = Cars_gCopCarList;

      for (; iVar7 < iVar2; iVar7 = iVar7 + 1) {

        pAVar6 = highLevelAIObjs[(*ppCVar8)->carIndex];

        if ((((*ppCVar8)->AIFlags & 0xcU) == 8) && (pAVar6[1].stateType_ != 2)) {

          iVar3 = local_28[(int)&((pAVar6[1].carObj_)->N).oldSlice];

          if (iVar3 < local_28[(int)pAVar6[1].carObj_]) {

            local_28[(int)&((pAVar6[1].carObj_)->N).oldSlice] = iVar3 + 1;

            pAVar6[1].stateType_ = 1;

            pAVar6[1].schedulingOff_ = (int)this;

          }

        }

        ppCVar8 = ppCVar8 + 1;

      }

    }

    iVar7 = Cars_gNumCopCars;

    if ((Cars_gNumHumanRaceCars != 1) && (iVar3 = 0, local_14 < local_28[1])) {

      ppCVar8 = Cars_gCopCarList;

      for (; iVar3 < iVar7; iVar3 = iVar3 + 1) {

        pAVar6 = highLevelAIObjs[(*ppCVar8)->carIndex];

        if ((((((*ppCVar8)->AIFlags & 0xcU) == 8) && (pAVar6[1].carObj_ == (Car_tObj *)0x0)) &&

            (local_14 < local_28[1])) && (local_14 == 0)) {

          local_14 = 1;

          pAVar6[1].stateType_ = 4;

          pAVar6[1].schedulingOff_ = (int)this;

        }

        ppCVar8 = ppCVar8 + 1;

      }

    }

    iVar3 = 0;

    if ((local_28[0] <= local_28[2]) && (iVar3 = 1, local_28[3] < local_28[1])) {

      iVar3 = 0;

    }

  }

  return iVar3;

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

  short sVar1;

  bool bVar2;

  int iVar4;

  Speaker *pSVar5;

  int iVar7;

  int (*pcVar8)(...);

  int iVar15;

  u_int uVar19;

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

  if (blockadeHandle != -1) {

    blockade = triggerManagerCops->GetTrigger(blockadeHandle,&used);
    loop = 0;
    do {
      if ((AILife_IsSliceInAnyVisibleArea(blockade->roadblock.slice) != 0) ||
          (AILife_IsSliceCloseToAnyCopCar(blockade->roadblock.slice) != 0)) {
        blockadeHandle = blockade->roadblock.slice + 1;
        if (gNumSlices <= blockadeHandle) {
          blockadeHandle = blockade->roadblock.slice - (gNumSlices - 1);
        }
      }
      else {
        break;
      }
      blockadeHandle = triggerManagerCops->CheckForClosestTriggerOfType(
          blockadeHandle,(triggerType)2,this->carObj_->direction);
      if (blockadeHandle == -1) goto LAB_80062130;

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

    randtemp = fastRandom * randSeed;

    posIndex = 0;

    saySpikeBelt = false;

    fastRandom = randtemp & 0xffff;

    blockadeFlags =
        (u_int)(u_char)"\x05\x06\x04\x02"[(randtemp >> 8 & 0xffff) % 5];

    blockadeCar = (AIHigh_Cop *)0x0;
    {
      AIHigh_Cop *thisCop;
      blockade_t *copBlockade;
      for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {

      thisCop = (AIHigh_Cop *)highLevelAIObjs[Cars_gCopCarList[copLoop]->carIndex];
      copBlockade = &thisCop->blockade_;
      if (((Cars_gCopCarList[copLoop]->AIFlags & 4U) != 0) &&
          (thisCop->blockade_.mode == 1)) {

        if ((thisCop->type_ == 1) && (nCopsNeeded[1] != 0)) {
          int addToSlice;

          if (blockadeCar == (AIHigh_Cop *)0x0) {

            blockadeCar = thisCop;

          }

          nCopsNeeded[1] = nCopsNeeded[1] + -1;

          copBlockade->blockadeSpeechFlags = 0;
          copBlockade->flags = blockadeFlags;
          copBlockade->chaseLevel = this->perpChaseInfo_.chaseLevelIndex_;
          copBlockade->mode = 2;

          addToSlice = ((posIndex / 2) * 2 + 3) * this->carObj_->direction;
          copBlockade->slice = blockadeSlice + addToSlice;
          if (copBlockade->slice < 0) {
            copBlockade->slice = copBlockade->slice + gNumSlices;
          }
          else if (gNumSlices <= copBlockade->slice) {
            copBlockade->slice = copBlockade->slice - gNumSlices;
          }

          copBlockade->direction = this->carObj_->direction;

          iVar7 = copBlockade->slice * 0x20 + (int)BWorldSm_slices;

          iVar15 = (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

          uVar19 = iVar15 + (u_int)*(u_char *)(iVar7 + 0x1f) * 0x8000 * (*(u_char *)(iVar7 + 0x1d) & 0xf)

          ;

          if ((nCopsAvail[1] == 1) && (nCopsAvail[0] == 0)) {

            copBlockade->latPos = (uVar19 >> 1) - iVar15;

            iVar4 = 0xff;

          }

          else {

            iVar15 = (int)uVar19 >> 2;

            if ((posIndex & 1) == 0) {

              iVar7 = copBlockade->slice * 0x20 + (int)BWorldSm_slices;

              copBlockade->latPos =

                   iVar15 - (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 *

                            (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

              iVar4 = 0xbe;

            }

            else {

              iVar7 = copBlockade->slice * 0x20 + (int)BWorldSm_slices;

              iVar4 = -0xbe;

              copBlockade->latPos =

                   iVar15 * 3 -

                   (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

            }

          }

          copBlockade->rotation = iVar4;

          randtemp = fastRandom * randSeed;

          copBlockade->target = this;
          copBlockade->reverse = 0;
          copBlockade->releaseTime =
              ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999;

          fastRandom = randtemp & 0xffff;

          saySpikeBelt = true;

          iVar15 = AIWorld_ApxSplineDistance(this->carObj_,copBlockade->slice);

          if (iVar15 < 0) {

            iVar15 = iVar15 + 0xffff;

          }

          copBlockade->initialPlayerDistanceMetersInt = -(iVar15 >> 0x10);

          if (-(iVar15 >> 0x10) * (this->carObj_)->direction < 0) {

            copBlockade->initialPlayerDistanceMetersInt = 0;

          }

        }

        else {
          int addToSlice;

          if (nCopsNeeded[0] == 0) goto LAB_800620e8;

          if (blockadeCar == (AIHigh_Cop *)0x0) {

            blockadeCar = thisCop;

          }

          nCopsNeeded[0] = nCopsNeeded[0] + -1;

          copBlockade->blockadeSpeechFlags = 0;
          copBlockade->flags = blockadeFlags;
          copBlockade->chaseLevel = this->perpChaseInfo_.chaseLevelIndex_;
          copBlockade->mode = 2;

          addToSlice = ((posIndex / 2) * 2 + 3) * this->carObj_->direction;
          copBlockade->slice = blockadeSlice + addToSlice;
          if (copBlockade->slice < 0) {
            copBlockade->slice = copBlockade->slice + gNumSlices;
          }
          else if (gNumSlices <= copBlockade->slice) {
            copBlockade->slice = copBlockade->slice - gNumSlices;
          }

          randtemp = fastRandom * randSeed;

          copBlockade->direction = this->carObj_->direction;

          fastRandom = randtemp & 0xffff;

          if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 < 300) {

            copBlockade->reverse = 1;

          }

          else {

            copBlockade->reverse = 0;

          }

          randtemp = fastRandom * randSeed;

          copBlockade->releaseTime =
              ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999;

          fastRandom = randtemp & 0xffff;

          saySpikeBelt = true;

          iVar15 = AIWorld_ApxSplineDistance(this->carObj_,copBlockade->slice);

          if (iVar15 < 0) {

            iVar15 = iVar15 + 0xffff;

          }

          copBlockade->initialPlayerDistanceMetersInt = -(iVar15 >> 0x10);

          if (-(iVar15 >> 0x10) * (this->carObj_)->direction < 0) {

            copBlockade->initialPlayerDistanceMetersInt = 0;

          }

          iVar7 = copBlockade->slice * 0x20 + (int)BWorldSm_slices;

          iVar15 = (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

          uVar19 = iVar15 + (u_int)*(u_char *)(iVar7 + 0x1f) * 0x8000 * (*(u_char *)(iVar7 + 0x1d) & 0xf)

          ;

          if ((nCopsAvail[0] == 1) && (nCopsAvail[1] == 0)) {

            copBlockade->latPos = (uVar19 >> 1) - iVar15;

            iVar4 = 0xff;

          }

          else {

            iVar15 = (int)uVar19 >> 2;

            if ((posIndex & 1) == 0) {

              iVar7 = copBlockade->slice * 0x20 + (int)BWorldSm_slices;

              copBlockade->latPos =

                   iVar15 - (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 *

                            (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

              iVar4 = 0xbe;

            }

            else {

              iVar7 = copBlockade->slice * 0x20 + (int)BWorldSm_slices;

              iVar4 = -0xbe;

              copBlockade->latPos =

                   iVar15 * 3 -

                   (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

            }

          }

          copBlockade->rotation = iVar4;

          copBlockade->target = this;

        }

        if (requestSpikeBeltAtSlice != -1) {
          saySpikeBelt = true;
          copBlockade->requestSpikeBeltAtSlice = requestSpikeBeltAtSlice;
          requestSpikeBeltAtSlice = -1;
        }

        (this->perpChaseInfo_).blockadeDone_ = 1;

        posIndex = posIndex + 1;

      }

LAB_800620e8: ;   /* empty stmt: gcc2.7.2 label before brace */

      }
    }

    if (blockadeCar != (AIHigh_Cop *)0x0) {

      blockadeCar->blockade_.blockadeSpeechFlags = 1;

      if (!saySpikeBelt) {

        pSVar5 = (Speaker *)Speech_Mobile(blockadeCar->carObj_);

        sVar1 = (*pSVar5->_vf)[11].delta;

        pcVar8 = (*pSVar5->_vf)[11].pfn;

      }

      else {

        pSVar5 = (Speaker *)Speech_Mobile(blockadeCar->carObj_);

        sVar1 = (*pSVar5->_vf)[10].delta;

        pcVar8 = (*pSVar5->_vf)[10].pfn;

      }

      (*pcVar8)((int)pSVar5 + (int)sVar1);

      pSVar5 = (Speaker *)Speech_Mobile(blockadeCar->carObj_);

      (*(*pSVar5->_vf)[6].pfn)((int)pSVar5 + (*pSVar5->_vf)[6].delta,

                 this->carObj_);

      pSVar5 = (Speaker *)Speech_Dispatch();

      (*(*pSVar5->_vf)[4].pfn)((int)pSVar5 + (*pSVar5->_vf)[4].delta);

      pSVar5 = (Speaker *)Speech_Dispatch();

      (*(*pSVar5->_vf)[5].pfn)((int)pSVar5 + (*pSVar5->_vf)[5].delta,

                 blockadeCar->carObj_);

    }
  }
  else {
LAB_80062130:
    this->CheckForNewLevel(1);
  }

  return;

}








/* ---- CheckForNewLevel__13AIHigh_Playeri  AIHigh_Player::CheckForNewLevel  [AIH_PLAY.CPP:434-511] SLD-VERIFIED ---- */

void AIHigh_Player::CheckForNewLevel(int force)



{
  int chaseLevel;
  int oldChaseLevel;
  int level;

  __vtbl_ptr_type (*pa_Var1) [3];

  copLevel_t *pcVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int a;

  AICop_PerpChaseInfo *pInfo;



  pInfo = &this->perpChaseInfo_;

  iVar4 = pInfo->chaseLevelIndex_;

  if (1 < ((this->carObj_)->stats).finishType) {

    pInfo->chaseLevelIndex_ = 0;

    if (pInfo->bestChaseLevelIndex_ < 0) {

      pInfo->bestChaseLevelIndex_ = 0;

    }

    pcVar2 = (pInfo->copGameInfo_)->levels + pInfo->chaseLevelIndex_

    ;

    pInfo->chaseLevel_ = pcVar2;

    iVar4 = pcVar2->engagementLapFraction * AITune_gRoughLapTime;

    if (iVar4 < 0) {

      iVar4 = iVar4 + 0xffff;

    }

    iVar3 = (iVar4 >> 0x10) << 5;

    iVar5 = 0x10000 / iVar3;


    pInfo->engagementTime_ = (iVar4 >> 0x10) << 0x15;

    pInfo->engagementPercentIncreasePerTick_ = iVar5;

    if (GameSetup_gData.numLaps == 2) {

      iVar4 = 0x13333;

    }

    else {

      iVar4 = 0xa8f5;

      if (GameSetup_gData.numLaps != 4) goto LAB_80062328;

    }

    iVar4 = fixedmult(iVar5,iVar4);

    pInfo->engagementPercentIncreasePerTick_ = iVar4;

LAB_80062328:

    pInfo->blockadeDone_ = 0;

    this->basicPerpInfo_.crime_ = 0;

    return;

  }

  pa_Var1 = this->_vf;

  (**(int (**)(...))((char *)pa_Var1 + 28))

            ((int)this + *(short *)((char *)pa_Var1 + 24));

  if (this->basicPerpInfo_.crime_ == 0) goto LAB_8006249c;

  if (force == 0) {

    iVar3 = pInfo->engagementTime_;

    if (iVar3 < 0) {

      iVar3 = iVar3 + 0xffff;

    }

    if (0 < iVar3 >> 0x10) goto LAB_8006249c;

  }

  iVar3 = (pInfo->copGameInfo_)->numLevels;

  iVar5 = iVar4 + 1;

  if (iVar3 <= iVar5) {

    iVar5 = iVar3 + -2;

  }

  pInfo->chaseLevelIndex_ = iVar5;

  if (pInfo->bestChaseLevelIndex_ < iVar5) {

    pInfo->bestChaseLevelIndex_ = iVar5;

  }

  pcVar2 = (pInfo->copGameInfo_)->levels + pInfo->chaseLevelIndex_;

  pInfo->chaseLevel_ = pcVar2;

  iVar3 = pcVar2->engagementLapFraction * AITune_gRoughLapTime;

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xffff;

  }

  iVar5 = (iVar3 >> 0x10) << 5;

  a = 0x10000 / iVar5;


  pInfo->engagementTime_ = (iVar3 >> 0x10) << 0x15;

  pInfo->engagementPercentIncreasePerTick_ = a;

  if (GameSetup_gData.numLaps == 2) {

    iVar3 = 0x13333;

LAB_80062488:

    iVar3 = fixedmult(a,iVar3);

    pInfo->engagementPercentIncreasePerTick_ = iVar3;

  }

  else {

    iVar3 = 0xa8f5;

    if (GameSetup_gData.numLaps == 4) goto LAB_80062488;

  }

  pInfo->blockadeDone_ = 0;

LAB_8006249c:

  if (iVar4 == pInfo->chaseLevelIndex_) {

    return;

  }

  this->newTriggerProb_ =

       triggerManagerCops->invNumTriggers_ * (pInfo->chaseLevel_)->copsPerLap;

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

  if (AICop_gRoadBlockState != 0) {

    AICop_gRoadBlockState = 2;

  }

  pSVar1 = (Speaker *)Speech_Mobile(Cars_gList[highestRankedCopIndex]);

  (*(*pSVar1->_vf)[9].pfn)((int)pSVar1 + (*pSVar1->_vf)[9].delta,iVar3);

  return;

}








/* ---- MaintainAvailableCops__13AIHigh_Player  AIHigh_Player::MaintainAvailableCops  [AIH_PLAY.CPP:669-744] SLD-VERIFIED ---- */

void AIHigh_Player::MaintainAvailableCops()



{
  bool bVar1;

  int iVar2;

  u_int uVar3;

  stateType_t sVar4;

  Car_tObj *pCVar5;

  AIHigh_Base *pAVar6;

  Car_tObj **ppCVar7;

  int iVar8;

  int iVar9;

  int iVar10;

  int local_18 [4];

  

  memset((u_char *)local_18,'\0',8);

  memset((u_char *)(local_18 + 2),'\0',8);

  iVar10 = 3;

  if ((Cars_gNumRaceCars != 1) && (iVar10 = 4, Cars_gNumHumanRaceCars == 2)) {

    iVar10 = 2;

  }

  iVar8 = 0;

  ppCVar7 = Cars_gRaceCarList;

  while (bVar1 = iVar8 < Cars_gNumRaceCars, iVar8 = iVar8 + 1, bVar1) {

    pAVar6 = highLevelAIObjs[(*ppCVar7)->carIndex];

    local_18[0] = local_18[0] + *(int *)(pAVar6[6].schedulingOff_ + 0xc) +

                  *(int *)pAVar6[6].schedulingOff_;

    ppCVar7 = ppCVar7 + 1;

    local_18[1] = local_18[1] + *(int *)(pAVar6[6].schedulingOff_ + 0x10) +

                  *(int *)(pAVar6[6].schedulingOff_ + 4);

  }

  ppCVar7 = Cars_gCopCarList;

  iVar8 = 0;

  /* MATCH: oracle DEFERS Cars_gNumCopCars's load to right before this loop (0x80062740),
     not up-front after the memsets -- iVar9's single use is this loop's exit test. */
  iVar9 = Cars_gNumCopCars;

  while (true) {

    iVar2 = Cars_gNumCopCars;

    if (iVar9 <= iVar8) break;

    pCVar5 = *ppCVar7;

    bVar1 = false;

    if ((((pCVar5->AIFlags & 4U) == 0) ||

        (sVar4 = highLevelAIObjs[pCVar5->carIndex][1].stateType_, sVar4 == 1)) || (sVar4 == 2)) {

      bVar1 = true;

    }

    if (bVar1) {

      local_18[(int)((int)&((highLevelAIObjs[pCVar5->carIndex][1].carObj_)->N).objID + 2)] =

           local_18[(int)((int)&((highLevelAIObjs[pCVar5->carIndex][1].carObj_)->N).objID + 2)] + 1;

      iVar10 = iVar10 + -1;

      uVar3 = pCVar5->AIFlags | 8;

    }

    else {

      uVar3 = pCVar5->AIFlags & 0xfffffff7;

    }

    pCVar5->AIFlags = uVar3;

    ppCVar7 = ppCVar7 + 1;

    iVar8 = iVar8 + 1;

  }

  ppCVar7 = Cars_gCopCarList;

  iVar9 = 0;

  while (true) {

    if (!(0 < iVar10 && (iVar9 < iVar2))) break;

    pCVar5 = *ppCVar7;

    if ((pCVar5->AIFlags & 8U) == 0) {

      iVar8 = local_18[(int)((int)&((highLevelAIObjs[pCVar5->carIndex][1].carObj_)->N).objID + 2)];

      if (iVar8 < local_18[(int)highLevelAIObjs[pCVar5->carIndex][1].carObj_]) {

        local_18[(int)((int)&((highLevelAIObjs[pCVar5->carIndex][1].carObj_)->N).objID + 2)] =

             iVar8 + 1;

        iVar10 = iVar10 + -1;

        pCVar5->AIFlags = pCVar5->AIFlags | 8;

      }

    }

    ppCVar7 = ppCVar7 + 1;

    iVar9 = iVar9 + 1;

  }

  return;

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

  if (GameSetup_gData.commMode == 1) {

    iVar1 = 2;

  }

  else {

    iVar1 = (u_int)(0 < Cars_gNumAIRaceCars) << 2;

  }

  iVar1 = iVar1 + (u_int)(GameSetup_gData.numLaps != 2);

  pInfo->copGameInfo_ = copGame + iVar1;

  pInfo->chaseLevelIndex_ = 0;

  pInfo->engagementTime_ = 0;

  pInfo->bestChaseLevelIndex_ = 0;

  pcVar3 = copGame[iVar1].levels;

  pInfo->blockadeDone_ = 0;

  pInfo->copFreeTicks_ = 0;

  pInfo->totalEngagementPercent_ = 0;

  pInfo->engagementPercentIncreasePerTick_ = 0;

  pInfo->chaseLevel_ = pcVar3 + pInfo->chaseLevelIndex_;

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

  this->lastTriggerCheckSlice_ = (int)(pCVar2->N).simRoadInfo.slice;

  pInfo2->chaseLevelIndex_ = 0;

  if (pInfo2->bestChaseLevelIndex_ < 0) {

    pInfo2->bestChaseLevelIndex_ = 0;

  }

  pcVar3 = (pInfo2->copGameInfo_)->levels + pInfo2->chaseLevelIndex_;

  pInfo2->chaseLevel_ = pcVar3;

  iVar1 = pcVar3->engagementLapFraction * AITune_gRoughLapTime;

  if (iVar1 < 0) {

    iVar1 = iVar1 + 0xffff;

  }

  iVar4 = (iVar1 >> 0x10) << 5;

  a = 0x10000 / iVar4;


  pInfo2->engagementTime_ = (iVar1 >> 0x10) << 0x15;

  pInfo2->engagementPercentIncreasePerTick_ = a;

  if (GameSetup_gData.numLaps == 2) {

    iVar1 = 0x13333;

  }

  else {

    iVar1 = 0xa8f5;

    if (GameSetup_gData.numLaps != 4) goto LAB_80062aa8;

  }

  iVar1 = fixedmult(a,iVar1);

  pInfo2->engagementPercentIncreasePerTick_ = iVar1;

LAB_80062aa8:

  pInfo2->blockadeDone_ = 0;

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

void AIHigh_Player::HandlePullOver()



{
  int chaseTime;
  int lapIndex;

  bool bVar1;

  int iVar2;

  int _Var3;

  Car_tObj *pCVar4;

  int iVar5;

  copLevel_t *pcVar6;

  int a;

  

  if (this->pullOverMode_ == 0) {

    iVar2 = this->CheckIfCaught();

    if (iVar2 == 0) {

      return;

    }

    (this->carObj_)->pullOver = 1;

    this->CleanupBlockaders(1);

    pcVar6 = (this->perpChaseInfo_).chaseLevel_;

    iVar2 = pcVar6->engagementLapFraction * AITune_gRoughLapTime;

    if (iVar2 < 0) {

      iVar2 = iVar2 + 0xffff;

    }

    iVar5 = (this->perpChaseInfo_).engagementTime_;

    if (iVar5 < 0) {

      iVar5 = iVar5 + 0xffff;

    }

    this->beatingTicksLeft_ = pcVar6->beatingTicks;

    this->lastPullOverTime_ = simGlobal.gameTicks;

    bVar1 = false;

    if (((this->basicPerpInfo_.crime_ != 4) &&

        (((this->carObj_)->stats).numFines == 0)) &&

       (((this->perpChaseInfo_).copGameInfo_)->levels[(this->perpChaseInfo_).bestChaseLevelIndex_].

        numWarningsAdded != 0)) {

      bVar1 = (iVar2 >> 0x10) * 0x20 - (iVar5 >> 0x10) <

              ((this->perpChaseInfo_).chaseLevel_)->warningTicks;

    }

    if ((bVar1) && (this->numWarnings_ < 2)) {

      pCVar4 = this->carObj_;

      this->numWarnings_ =

           this->numWarnings_ + ((this->perpChaseInfo_).chaseLevel_)->numWarningsAdded;

      (pCVar4->stats).numWarnings = (pCVar4->stats).numWarnings + 1;

      _Var3 = 1;

    }

    else {

      pCVar4 = this->carObj_;

      this->numBusts_ = this->numBusts_ + 1;

      (pCVar4->stats).numFines = (pCVar4->stats).numFines + 1;

      iVar2 = 2;

      if (GameSetup_gData.numLaps == 2) {

        iVar2 = 0;

      }

      else if (GameSetup_gData.numLaps == 4) {

        iVar2 = 1;

      }

      if ((AIHigh_Player_kNumArrestsByLap[iVar2] <= this->numBusts_) ||

         ((_Var3 = 2,

          (this->perpChaseInfo_).bestChaseLevelIndex_ ==

          ((this->perpChaseInfo_).copGameInfo_)->numLevels + -1 &&

          (_Var3 = 2, Cars_gNumHumanRaceCars == 1)))) {

        this->pullOverMode_ = 3;

        pCVar4 = this->carObj_;

        this->beatingTicksLeft_ =

             this->beatingTicksLeft_ + 0xc0;

        (pCVar4->stats).numArrests = (pCVar4->stats).numArrests + 1;

        goto LAB_8006322c;

      }

    }

    this->pullOverMode_ = _Var3;

LAB_8006322c:

    this->HandleSpeech();

    return;

  }

  iVar2 = this->beatingTicksLeft_ - AI_elapsedTime;   /* H29: decrement dropped (m2c self-assign fold); oracle 0x80062DA0-B8 store+test the decremented value */

  this->beatingTicksLeft_ = iVar2;

  if (0 < iVar2) {

    return;

  }

  iVar2 = (this->carObj_)->carIndex;

  if (iVar2 < 2) {

    Hud_Perp_OverlayOff(iVar2);

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

  (this->perpChaseInfo_).chaseLevelIndex_ = 0;

  if ((this->perpChaseInfo_).bestChaseLevelIndex_ < 0) {

    (this->perpChaseInfo_).bestChaseLevelIndex_ = 0;

  }

  pcVar6 = ((this->perpChaseInfo_).copGameInfo_)->levels + (this->perpChaseInfo_).chaseLevelIndex_;

  (this->perpChaseInfo_).chaseLevel_ = pcVar6;

  iVar2 = pcVar6->engagementLapFraction * AITune_gRoughLapTime;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xffff;

  }

  iVar5 = (iVar2 >> 0x10) << 5;

  a = 0x10000 / iVar5;


  (this->perpChaseInfo_).engagementTime_ = (iVar2 >> 0x10) << 0x15;

  (this->perpChaseInfo_).engagementPercentIncreasePerTick_ = a;

  if (GameSetup_gData.numLaps == 2) {

    iVar2 = 0x13333;

  }

  else {

    iVar2 = 0xa8f5;

    if (GameSetup_gData.numLaps != 4) goto LAB_80062f48;

  }

  iVar2 = fixedmult(a,iVar2);

  (this->perpChaseInfo_).engagementPercentIncreasePerTick_ = iVar2;

LAB_80062f48:

  (this->perpChaseInfo_).blockadeDone_ = 0;

  this->basicPerpInfo_.crime_ = 0;

  this->RemoveCloseCops();

  if (((this->pullOverMode_ != 3) || (Cars_gNumHumanRaceCars != 1)) ||

     (((this->carObj_)->carFlags & 8U) != 0)) {

    Cars_ResetCollidedCars(this->carObj_,1,1);

  }

  if (this->pullOverMode_ == 3) {

    if ((Cars_gNumHumanRaceCars == 2) && (AICop_numArrestedHumans != 2)) {

      DashHUD_gInfo.showhud[(this->carObj_)->carIndex] = 0;

    }

  }

  else {

    (this->carObj_)->pullOver = 0;

  }

  this->pullOverMode_ = 0;

  return;

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
