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
  AIHigh_Cop*thisCop;
  int addToSlice;

  short sVar1;

  bool bVar2;

  trigger_t *ptVar3;

  int iVar4;

  Speaker *pSVar5;

  AIState_Base *pAVar6;

  int iVar7;

  int (*pcVar8)(...);

  Car_tObj *pCVar9;

  AIHigh_Base *pAVar10;

  Car_tObj **ppCVar11;

  Car_tObj *pCVar12;

  u_int uVar13;

  int iVar14;

  int iVar15;

  Car_tObj *pCVar16;

  copLevel_t *pcVar17;

  AIHigh_Base *pAVar18;

  u_int uVar19;

  int local_50;

  int local_4c;

  Car_tObj *local_48 [2];

  int local_40;

  int local_3c;

  Car_tObj *pCStack_38;

  int local_34;

  Car_tObj *local_30;

  

  pCVar9 = this->carObj_;

  pcVar17 = (this->perpChaseInfo_).chaseLevel_;

  iVar14 = pCVar9->direction * 0x53;

  if (iVar14 < 0) {

    iVar14 = (pCVar9->N).simRoadInfo.slice + iVar14;

    if (iVar14 < 0) {

      iVar14 = iVar14 + gNumSlices;

    }

  }

  else {

    iVar14 = (pCVar9->N).simRoadInfo.slice + iVar14;

    if (gNumSlices <= iVar14) {

      iVar14 = iVar14 - gNumSlices;

    }

  }

  local_50 = pcVar17->copBlockaders[0];

  local_4c = pcVar17->copBlockaders[1];

  iVar14 = triggerManagerCops->CheckForClosestTriggerOfType(iVar14, (triggerType)2, (this->carObj_)->direction);

  if (iVar14 == -1) {

LAB_80062130:

    this->CheckForNewLevel(1);

  }

  else {

    iVar15 = 0;

    ptVar3 = triggerManagerCops->GetTrigger(iVar14, (int *)(local_48 + 4));

    do {

      bVar2 = false;

      pCVar9 = AILife_IsSliceInAnyVisibleArea(*(int *)(ptVar3 + 4));

      if ((pCVar9 != (Car_tObj *)0x0) ||

         (pCVar9 = AILife_IsSliceCloseToAnyCopCar(*(int *)(ptVar3 + 4))

         , pCVar9 != (Car_tObj *)0x0)) {

        bVar2 = true;

      }

      if (!bVar2) break;

      iVar14 = *(int *)(ptVar3 + 4) + 1;

      if (gNumSlices <= iVar14) {

        iVar14 = *(int *)(ptVar3 + 4) - (gNumSlices + -1);

      }

      iVar14 = triggerManagerCops->CheckForClosestTriggerOfType(iVar14, (triggerType)2, (this->carObj_)->direction);

      if (iVar14 == -1) goto LAB_80062130;

      iVar15 = iVar15 + 1;

      ptVar3 = triggerManagerCops->GetTrigger(iVar14, (int *)(local_48 + 4));

    } while (iVar15 < 4);

    pCVar16 = *(Car_tObj **)(ptVar3 + 4);

    pCVar9 = (Car_tObj *)0xffffffff;

    if (pcVar17->spikeBelt != 0) {

      pCVar9 = pCVar16;

    }

    ppCVar11 = Cars_gCopCarList;

    local_48[0] = (Car_tObj *)0x0;

    local_48[1] = (Car_tObj *)0x0;

    local_40 = local_50;

    local_3c = local_4c;

    for (iVar14 = 0; pAVar18 = (AIHigh_Base *)0x0, iVar14 < Cars_gNumCopCars; iVar14 = iVar14 + 1) {

      pAVar18 = highLevelAIObjs[(*ppCVar11)->carIndex];

      bVar2 = false;

      if ((((*ppCVar11)->AIFlags & 4U) != 0) && (pAVar18[1].stateType_ == 1)) {

        bVar2 = local_48[(int)((int)&((pAVar18[1].carObj_)->N).objID + 2)] != (Car_tObj *)0x0;

      }

      if (bVar2) {

        local_48[(int)((int)&((pAVar18[1].carObj_)->N).objID + 2)] =

             (Car_tObj *)

             ((int)&local_48[(int)((int)&((pAVar18[1].carObj_)->N).objID + 2)][-1].async_handle + 3)

        ;

        local_48[(int)pAVar18[1].carObj_] =

             (Car_tObj *)((int)&(local_48[(int)pAVar18[1].carObj_]->N).objID + 1);

      }

      ppCVar11 = ppCVar11 + 1;

    }

    randtemp = fastRandom * randSeed;

    uVar13 = 0;

    pCVar12 = (Car_tObj *)0x1;

    local_34 = 0;

    fastRandom = randtemp & 0xffff;

    uVar19 = (u_int)(u_char)"\x05\x06\x04\x02"[(randtemp >> 8 & 0xffff) % 5];

    for (iVar14 = 0; iVar14 < Cars_gNumCopCars; iVar14 = iVar14 + 1) {

      pAVar10 = highLevelAIObjs[Cars_gCopCarList[iVar14]->carIndex];

      if (((Cars_gCopCarList[iVar14]->AIFlags & 4U) != 0) &&

         ((Car_tObj *)pAVar10[1].stateType_ == pCVar12)) {

        if ((pAVar10[1].carObj_ == pCVar12) && (local_4c != 0)) {

          if (pAVar18 == (AIHigh_Base *)0x0) {

            pAVar18 = pAVar10;

          }

          local_4c = local_4c + -1;

          *(u_short *)&pAVar10[3].stateType_ = 0;

          pAVar10[1].lastTrafficTriggerCheckSlice_ = uVar19;

          pAVar10[1]._vf = (__vtbl_ptr_type (*) [3])(this->perpChaseInfo_).chaseLevelIndex_;

          pAVar10[1].stateType_ = 2;

          iVar15 = (((int)uVar13 / 2) * 2 + 3) *

                   (this->carObj_)->direction;

          if (iVar15 < 0) {

            pAVar6 = (AIState_Base *)((int)(pCVar16->N).simRoadInfo.quadPts + iVar15 + -0x10);

            if ((int)pAVar6 < 0) {

              pAVar6 = (AIState_Base *)((int)&pAVar6->carObj_ + gNumSlices);

            }

          }

          else {

            pAVar6 = (AIState_Base *)((int)(pCVar16->N).simRoadInfo.quadPts + iVar15 + -0x10);

            if (gNumSlices <= (int)pAVar6) {

              pAVar6 = (AIState_Base *)((int)pAVar6 - gNumSlices);

            }

          }

          pAVar10[2].state_ = pAVar6;

          pAVar10[2].stateType_ = (this->carObj_)->direction;

          iVar7 = (int)pAVar10[2].state_ * 0x20 + BWorldSm_slices;

          iVar15 = (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

          uVar19 = iVar15 + (u_int)*(u_char *)(iVar7 + 0x1f) * 0x8000 * (*(u_char *)(iVar7 + 0x1d) & 0xf)

          ;

          if ((local_48[1] == pCVar12) && (local_48[0] == (Car_tObj *)0x0)) {

            pAVar10[2].schedulingOff_ = (uVar19 >> 1) - iVar15;

            iVar4 = 0xff;

          }

          else {

            iVar15 = (int)uVar19 >> 2;

            if ((uVar13 & 1) == 0) {

              iVar7 = (int)pAVar10[2].state_ * 0x20 + BWorldSm_slices;

              pAVar10[2].schedulingOff_ =

                   iVar15 - (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 *

                            (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

              iVar4 = 0xbe;

            }

            else {

              iVar7 = (int)pAVar10[2].state_ * 0x20 + BWorldSm_slices;

              iVar4 = -0xbe;

              pAVar10[2].schedulingOff_ =

                   iVar15 * 3 -

                   (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

            }

          }

          pAVar10[2].lastTrafficTriggerCheckSlice_ = iVar4;

          randtemp = fastRandom * randSeed;

          pAVar6 = pAVar10[2].state_;

          pAVar10[1].schedulingOff_ = (int)this;

          pAVar10[2]._vf = (__vtbl_ptr_type (*) [3])0x0;

          pAVar10[3].carObj_ = (Car_tObj *)(((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999);

          fastRandom = randtemp & 0xffff;

          local_30 = pCVar12;

          iVar15 = AIWorld_ApxSplineDistance(this->carObj_,(int)pAVar6);

          if (iVar15 < 0) {

            iVar15 = iVar15 + 0xffff;

          }

          pAVar10[3].state_ = (AIState_Base *)-(iVar15 >> 0x10);

          if (-(iVar15 >> 0x10) * (this->carObj_)->direction < 0) {

            pAVar10[3].state_ = (AIState_Base *)0x0;

          }

        }

        else {

          if (local_50 == 0) goto LAB_800620e8;

          if (pAVar18 == (AIHigh_Base *)0x0) {

            pAVar18 = pAVar10;

          }

          local_50 = local_50 + -1;

          *(u_short *)&pAVar10[3].stateType_ = 0;

          pAVar10[1].lastTrafficTriggerCheckSlice_ = uVar19;

          pAVar10[1]._vf = (__vtbl_ptr_type (*) [3])(this->perpChaseInfo_).chaseLevelIndex_;

          pAVar10[1].stateType_ = 2;

          iVar15 = (((int)uVar13 / 2) * 2 + 3) *

                   (this->carObj_)->direction;

          if (iVar15 < 0) {

            pAVar6 = (AIState_Base *)((int)(pCVar16->N).simRoadInfo.quadPts + iVar15 + -0x10);

            if ((int)pAVar6 < 0) {

              pAVar6 = (AIState_Base *)((int)&pAVar6->carObj_ + gNumSlices);

            }

          }

          else {

            pAVar6 = (AIState_Base *)((int)(pCVar16->N).simRoadInfo.quadPts + iVar15 + -0x10);

            if (gNumSlices <= (int)pAVar6) {

              pAVar6 = (AIState_Base *)((int)pAVar6 - gNumSlices);

            }

          }

          pAVar10[2].state_ = pAVar6;

          uVar19 = fastRandom * randSeed;

          pAVar10[2].stateType_ = (this->carObj_)->direction;

          fastRandom = uVar19 & 0xffff;

          if ((uVar19 >> 8 & 0xffff) * 1000 >> 0x10 < 300) {

            pAVar10[2]._vf = (__vtbl_ptr_type (*) [3])pCVar12;

          }

          else {

            pAVar10[2]._vf = (__vtbl_ptr_type (*) [3])0x0;

          }

          randtemp = fastRandom * randSeed;

          pAVar6 = pAVar10[2].state_;

          pAVar10[3].carObj_ = (Car_tObj *)(((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999);

          fastRandom = randtemp & 0xffff;

          local_30 = pCVar12;

          iVar15 = AIWorld_ApxSplineDistance(this->carObj_,(int)pAVar6);

          if (iVar15 < 0) {

            iVar15 = iVar15 + 0xffff;

          }

          pAVar10[3].state_ = (AIState_Base *)-(iVar15 >> 0x10);

          if (-(iVar15 >> 0x10) * (this->carObj_)->direction < 0) {

            pAVar10[3].state_ = (AIState_Base *)0x0;

          }

          iVar7 = (int)pAVar10[2].state_ * 0x20 + BWorldSm_slices;

          iVar15 = (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

          uVar19 = iVar15 + (u_int)*(u_char *)(iVar7 + 0x1f) * 0x8000 * (*(u_char *)(iVar7 + 0x1d) & 0xf)

          ;

          if ((local_48[0] == local_30) && (local_48[1] == (Car_tObj *)0x0)) {

            pAVar10[2].schedulingOff_ = (uVar19 >> 1) - iVar15;

            iVar4 = 0xff;

          }

          else {

            iVar15 = (int)uVar19 >> 2;

            if ((uVar13 & 1) == 0) {

              iVar7 = (int)pAVar10[2].state_ * 0x20 + BWorldSm_slices;

              pAVar10[2].schedulingOff_ =

                   iVar15 - (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 *

                            (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

              iVar4 = 0xbe;

            }

            else {

              iVar7 = (int)pAVar10[2].state_ * 0x20 + BWorldSm_slices;

              iVar4 = -0xbe;

              pAVar10[2].schedulingOff_ =

                   iVar15 * 3 -

                   (u_int)*(u_char *)(iVar7 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar7 + 0x1d) >> 4);

            }

          }

          pAVar10[2].lastTrafficTriggerCheckSlice_ = iVar4;

          pAVar10[1].schedulingOff_ = (int)this;

        }

        uVar19 = 0;

        if (pCVar9 != (Car_tObj *)0xffffffff) {

          local_34 = 1;

          pAVar10[2].carObj_ = pCVar9;

          pCVar9 = (Car_tObj *)0xffffffff;

        }

        (this->perpChaseInfo_).blockadeDone_ = (int)local_30;

        uVar13 = uVar13 + 1;

        pCVar12 = local_30;

      }

LAB_800620e8: ;   /* empty stmt: gcc2.7.2 label before brace */

    }

    if (pAVar18 != (AIHigh_Base *)0x0) {

      *(u_short *)&pAVar18[3].stateType_ = 1;

      if (local_34 == 0) {

        pSVar5 = (Speaker *)Speech_Mobile(pAVar18->carObj_);

        sVar1 = (*pSVar5->_vf)[11].delta;

        pcVar8 = (*pSVar5->_vf)[11].pfn;

      }

      else {

        pSVar5 = (Speaker *)Speech_Mobile(pAVar18->carObj_);

        sVar1 = (*pSVar5->_vf)[10].delta;

        pcVar8 = (*pSVar5->_vf)[10].pfn;

      }

      (*pcVar8)((int)pSVar5 + (int)sVar1);

      pSVar5 = (Speaker *)Speech_Mobile(pAVar18->carObj_);

      (*(*pSVar5->_vf)[6].pfn)((int)pSVar5 + (*pSVar5->_vf)[6].delta,

                 this->carObj_);

      pSVar5 = (Speaker *)Speech_Dispatch();

      (*(*pSVar5->_vf)[4].pfn)((int)pSVar5 + (*pSVar5->_vf)[4].delta);

      pSVar5 = (Speaker *)Speech_Dispatch();

      (*(*pSVar5->_vf)[5].pfn)((int)pSVar5 + (*pSVar5->_vf)[5].delta,

                 pAVar18->carObj_);

    }

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

  iVar9 = Cars_gNumCopCars;

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

  for (iVar8 = 0; iVar2 = Cars_gNumCopCars, iVar8 < iVar9; iVar8 = iVar8 + 1) {

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

  }

  ppCVar7 = Cars_gCopCarList;

  for (iVar9 = 0; (0 < iVar10 && (iVar9 < iVar2)); iVar9 = iVar9 + 1) {

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

  pCVar2 = this->carObj_;

  this->newTriggerProb_ =

       triggerManagerCops->invNumTriggers_ * (pInfo->chaseLevel_)->copsPerLap;

  this->lastTriggerCheckSlice_ = (int)(pCVar2->N).simRoadInfo.slice;

  pInfo->chaseLevelIndex_ = 0;

  if (pInfo->bestChaseLevelIndex_ < 0) {

    pInfo->bestChaseLevelIndex_ = 0;

  }

  pcVar3 = (pInfo->copGameInfo_)->levels + pInfo->chaseLevelIndex_;

  pInfo->chaseLevel_ = pcVar3;

  iVar1 = pcVar3->engagementLapFraction * AITune_gRoughLapTime;

  if (iVar1 < 0) {

    iVar1 = iVar1 + 0xffff;

  }

  iVar4 = (iVar1 >> 0x10) << 5;

  a = 0x10000 / iVar4;


  pInfo->engagementTime_ = (iVar1 >> 0x10) << 0x15;

  pInfo->engagementPercentIncreasePerTick_ = a;

  if (GameSetup_gData.numLaps == 2) {

    iVar1 = 0x13333;

  }

  else {

    iVar1 = 0xa8f5;

    if (GameSetup_gData.numLaps != 4) goto LAB_80062aa8;

  }

  iVar1 = fixedmult(a,iVar1);

  pInfo->engagementPercentIncreasePerTick_ = iVar1;

LAB_80062aa8:

  pInfo->blockadeDone_ = 0;

  return;

}








/* ---- HandleCops__13AIHigh_Player  AIHigh_Player::HandleCops  [AIH_PLAY.CPP:808-868] SLD-VERIFIED ---- */

void AIHigh_Player::HandleCops()



{
  copLevel_t*pLevel;
  int ticks;
  int totalCopsEngaged;

  int iVar1;

  int iVar2;

  copLevel_t *pcVar3;

  AICop_PerpChaseInfo *pInfo;



  pInfo = &this->perpChaseInfo_;

  pcVar3 = pInfo->chaseLevel_;

  if (Cars_gNumCopCars != 0) {

    this->MaintainAvailableCops();

    iVar1 = this->CheckIfABlockadeCanBeSetup();

    if (iVar1 != 0) {

      this->SetupBlockade();

    }

    if (pcVar3->numBlockaders == 0) {

      this->CleanupBlockaders(0);

    }

    {
      Car_tObj *pCar = this->carObj_;
      int prodSlipYaw;
      int elapsed;

      /* H26 setup: product computed UNCONDITIONALLY here (oracle 0x80062B30-60), the
         AI_elapsedTime load likewise (oracle 0x80062B54-58) -- both live across the
         copsAssigned_ branch below and are reused in the engagementTime_ shift-select. */
      prodSlipYaw = *(int *)((char *)pCar + 1380) * *(int *)((char *)pCar + 1364);

      elapsed = AI_elapsedTime;

    if (0 < this->basicPerpInfo_.copsAssigned_[0] +

            this->basicPerpInfo_.copsAssigned_[1]) {

      pInfo->copFreeTicks_ = 0;

      iVar2 = pInfo->engagementTime_;

      iVar1 = iVar2;

      if (iVar2 < 0) {

        iVar1 = iVar2 + 0xffff;

      }

      if (-2 < iVar1 >> 0x10) {

        /* H26: decrement dropped (m2c self-assign fold). Oracle 0x80062BA4: engagementTime_ = iVar2 -
           (AI_elapsedTime << shift), shift = 0xF if carObj[1380]*carObj[1364] < 0 else 0x10 (the
           0x80062B9C <<0xF delay slot is used on the product<0 path; 0x80062BA0 <<0x10 otherwise). */
        pInfo->engagementTime_ = iVar2 - (elapsed << (prodSlipYaw < 0 ? 0xF : 0x10));

        iVar1 = pInfo->engagementTime_;

        if (iVar1 < 0) {

          iVar1 = iVar1 + 0xffff;

        }

        iVar2 = (pInfo->chaseLevel_)->engagementLapFraction * AITune_gRoughLapTime;

        if (iVar2 < 0) {

          iVar2 = iVar2 + 0xffff;

        }

        if (iVar1 >> 0x10 < (iVar2 >> 0x10) * 0x20 + -0x80) {

          pInfo->totalEngagementPercent_ =

               pInfo->totalEngagementPercent_ +
               pInfo->engagementPercentIncreasePerTick_ * elapsed;   /* H27: += dropped (m2c self-assign fold); oracle 0x80062C08-24 */

        }

      }

    }

    else {

      pInfo->copFreeTicks_ = pInfo->copFreeTicks_ + elapsed;   /* H28: += dropped (m2c self-assign fold); oracle 0x80062C28-34 */

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
  Car_tObj **ppCVar4;
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

  ppCVar4 = Cars_gCopCarList;

  for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop = copLoop + 1) {

    thisCop = (AIHigh_Cop *)highLevelAIObjs[(*ppCVar4)->carIndex];

    blockade = &thisCop->blockade_;

    bVar3 = (blockadeMode_t)blockade->mode;

    if ((((bVar3 == 1) || (bVar3 == 4)) || ((bVar3 == 2 && (clearWaitingBlockaders)))) &&

       (blockade->target == this)) {

      blockade->mode = 0;

      thisCop->AssignToPlayer((AIHigh_Player *)0x0);

    }

    ppCVar4++;

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







/* end of aih_play.cpp */
