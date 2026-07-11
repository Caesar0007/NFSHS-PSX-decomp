/* game/common/aih_cop.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_cop_externs.h"

extern int AI_elapsedTime;   /* H22: ai.cpp @0x8013C554 (not in this TU's externs) */
extern int D_8011E0B0[];   /* == &simGlobal.gameTicks (distinct alias symbol the oracle addresses
                              directly for a gameTicks re-read the compiler can't CSE against the
                              nearby simGlobal.gameTicks store -- see aih_basiccop.cpp/aiphysic.cpp) */

/* ---- aistate.obj-owned globals (.bss zero) ---- */
int          *AIHigh_Cop_HighExecute_jt[11];   /* @0x8005516c */
tCopMurderThresholds AIHigh_Cop_AggressionData[3] = { {10, 655360, 851968, 512, 512}, {8, 917504, 983040, 768, 512}, {4, 1179648, 1179648, 1152, 1024} };   /* @0x8010cea4 */
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
  Car_tObj *pCVar1;

  int iVar2;



  pCVar1 = this->carObj_;

  iVar2 = pCVar1->carInfo->carType;

  if (this->type_ == 1) {

    pCVar1->copTopSpeed = copTuningInfo[iVar2 + -0x16].superCopTopSpeedCap;

    (this->carObj_)->copAccMult =

         copTuningInfo[iVar2 + -0x16].superCopAccMultiplier;

    return;

  }

  pCVar1->copTopSpeed = copTuningInfo[iVar2 + -0x16].regularCopTopSpeedCap;

  (this->carObj_)->copAccMult =

       copTuningInfo[iVar2 + -0x16].regularCopAccMultiplier;

  return;

}








/* ---- HighExecute__10AIHigh_Cop  AIHigh_Cop::HighExecute  [AIH_COP.CPP:147-816] SLD-VERIFIED ---- */

void AIHigh_Cop::HighExecute()



{
  bool bVar1;

  coorddef *pcVar2;

  trigger_t *ptVar3;

  trigger_t *ptVar4;

  trigger_t *ptVar5;

  u_int uVar6;

  AIState_Offroad *pAVar7;

  Speaker *pSVar8;

  int iVar9;

  u_long uVar10;

  AIState_Purgatory *pAVar11;

  int iVar12;

  AIState_Normal *pAVar13;

  AIState_Base *pAVar14;

  stateType_t sVar15;

  coorddef *pcVar16;

  int *piVar17;

  blockadeMode_t bVar18;

  AIHigh_tDriveAwayMode AVar19;

  int iVar20;

  Car_tObj *pCVar21;

  AIState_Base *pAVar22;

  AIHigh_Player *pAVar23;

  Car_tObj **ppCVar24;

  AIState_GotoSlice *pAVar25;

  AIState_Chase *pAVar26;

  coorddef local_60;

  u_char local_54 [8];

  int local_4c;

  matrixtdef mStack_48;

  int local_24;

  int local_20;

  int local_1c;

  

  (this->carObj_)->unlap = 0;

  (this->carObj_)->lap = 0;

  this->CheckSpikeBelt();

  this->CheckForWipeOut();

  this->SetTuningLevers();

  switch(this->stateType_) {

  case 0:
    {
    AIState_Base *newState;

    AIState_Base *oldState;

    stateType_t newStateType;

    this->AssignToPlayer((AIHigh_Player *)0x0);

    pCVar21 = this->carObj_;

    pCVar21->AIFlags = pCVar21->AIFlags & 0xfffffffd;

    if (((this->carObj_)->carFlags & 0x400U) == 0) {

      pAVar11 = operator new(8);

      newState = (AIState_Base *) (new(pAVar11) AIState_Purgatory(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      newStateType = 1;

    }

    else {

      newState = operator new(0x10);

      (new(newState) AIState_Base(this->carObj_));

      newState->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

      newState[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)oldState->_vf + 20))((int)&oldState->carObj_ + (int)*(short *)((char *)oldState->_vf + 16),3);

      }

      newStateType = 3;

    }

    this->state_ = newState;

    this->stateType_ = newStateType;

    return;
    }

  case 1:

    pCVar21 = this->carObj_;

    pCVar21->AIFlags = pCVar21->AIFlags & 0xfffffffd;

    bVar18 = this->blockade_.mode;

    this->requestSpikeBeltAtSlice_ = -1;

    this->driveAway_ = 0;

    if (bVar18 == 4) {

      this->blockade_.mode = 0;

    }

    bVar18 = this->blockade_.mode;

    if (bVar18 == 2) {

      this->AssignToPlayer(this->blockade_.target);

      pAVar14 = operator new(0x10);

      (new(pAVar14) AIState_Base(this->carObj_));

      pAVar14->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

      pAVar14[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

      pAVar22 = this->state_;

      if (pAVar22 != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

      }

      iVar12 = this->blockade_.rotation;

      this->state_ = pAVar14;

      this->stateType_ = 3;

      AILife_ReencarnateCopByLatPosAndRotation(this->carObj_,this->blockade_.slice

                 ,this->blockade_.direction,

                 this->blockade_.latPos,iVar12);

      this->requestSpikeBeltAtSlice_ = this->blockade_.requestSpikeBeltAtSlice;

    }

    else if ((((this->carObj_)->AIFlags & 8U) != 0) && (bVar18 != 1))

    {

      ptVar3 = this->CheckForNewTriggers();

      bVar1 = false;

      if (ptVar3 != (trigger_t *)0x0) {

        ptVar5 = ptVar3;

        pcVar2 = &local_60;

        do {

          pcVar16 = pcVar2;

          ptVar4 = ptVar5;

          iVar12 = *(int *)(ptVar4 + 4);

          iVar9 = *(int *)(ptVar4 + 8);

          iVar20 = *(int *)(ptVar4 + 0xc);

          pcVar16->x = *(int *)ptVar4;

          pcVar16->y = iVar12;

          pcVar16->z = iVar9;

          pcVar16[1].x = iVar20;

          ptVar5 = ptVar4 + 0x10;

          pcVar2 = (coorddef *)&pcVar16[1].y;

        } while (ptVar5 != ptVar3 + 0x40);

        iVar12 = *(int *)(ptVar4 + 0x14);

        pcVar16[1].y = *(int *)ptVar5;

        pcVar16[1].z = iVar12;

        if (Cars_gNumHumanRaceCars == 2) {

          iVar12 = AIWorld_ApxSplineDistance((Car_tObj *)0x0,(Car_tObj *)0x0);

          if (iVar12 < 0) {

            iVar12 = -iVar12;

          }

          if (iVar12 < 0x12c0000) {

            bVar1 = true;

          }

        }

        if (bVar1) {

          local_60.x = 1;

          (*(int *)((u_char *)&(local_54) + 4)) = 1;

          local_60.z = 1;

          (*(int *)&(local_54)) = 1;

        }

        triggerManagerCops->DescribeTrigger((trigger_t *)&local_60);

        if (local_60.x == 1) {

          randtemp = fastRandom * randSeed;

          fastRandom = randtemp & 0xffff;

          iVar12 = -1;

          if (GameSetup_gData.reverseTrack == 0) {

            iVar12 = 1;

          }

          if ((*(int *)((u_char *)&(local_54) + 4)) == 0) {

            this->AssignToPlayer((AIHigh_Player *)0x0);

            pAVar14 = operator new(0x10);

            (new(pAVar14) AIState_Base(this->carObj_));

            pAVar14->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

            pAVar14[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

            pAVar22 = this->state_;

            if (pAVar22 != (AIState_Base *)0x0) {

              (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

            }

            sVar15 = 3;

          }

          else {

            this->AssignToPlayer((AIHigh_Player *)0x0);

            pAVar13 = operator new(8);

            pAVar14 = (AIState_Base*)(new(pAVar13) AIState_Normal(this->carObj_))

            ;

            pAVar22 = this->state_;

            if (pAVar22 != (AIState_Base *)0x0) {

              (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

            }

            sVar15 = 2;

          }

          this->state_ = pAVar14;

          this->stateType_ = sVar15;

          AILife_ReencarnateCopBySlice(this->carObj_,local_60.y,iVar12,iVar12,

                     (*(int *)((u_char *)&(local_54) + 4)));

        }

        else if (((1 < local_60.x) && (local_60.x != 2)) && (local_60.x == 3)) {

          uVar6 = ~local_60.z;

          if (GameSetup_gData.reverseTrack == 0) {

            uVar6 = local_60.z ^ 1;

          }

          if ((uVar6 == 0) || (local_60.z == 0)) {

            this->AssignToPlayer((AIHigh_Player *)0x0);

            pAVar7 = operator new(0x68);

            pAVar7 = (new(pAVar7) AIState_Offroad(this->carObj_,local_60.y,

                                (coorddef *)local_54,&mStack_48,local_24,local_20,local_1c));

            pAVar14 = this->state_;

            if (pAVar14 != (AIState_Base *)0x0) {

              (*(int (**)(...))((char *)pAVar14->_vf + 20))((int)&pAVar14->carObj_ + (int)*(short *)((char *)pAVar14->_vf + 16),3);

            }

            this->state_ = (AIState_Base*)pAVar7;

            this->stateType_ = 5;

            AILife_ReencarnateCopByPosition(this->carObj_,local_60.y,1,(coorddef *)local_54

                       ,&mStack_48);

          }

        }

      }

    }

    goto stateExecuteAndReturn;

  case 2:

    this->requestSpikeBeltAtSlice_ = -1;

    bVar18 = this->blockade_.mode;

    if (bVar18 != 1) {

      if (bVar18 != 4) {

        pCVar21 = this->carObj_;

        pCVar21->AIFlags = pCVar21->AIFlags & 0xfffffffd;

      }

      bVar18 = this->blockade_.mode;

      if (((bVar18 != 1) && (bVar18 != 4)) &&

         (iVar12 = this->CheckForNewTarget(), iVar12 != 0)) {

        this->GetCheckChasePosition(&local_60);

        pAVar26 = operator new(0x94);

        pAVar26 = (new(pAVar26) AIState_Chase(this->carObj_,

                             (this->perpTarget_)->carObj_,&local_60,

                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,

                             NitroDistanceMeters[this->type_][0],

                             NitroDistanceMeters[this->type_][1],

                             this->aggressionLevel_,AICop_skillDelay[GameSetup_gData.skill]));

        pAVar14 = this->state_;

        if (pAVar14 != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)pAVar14->_vf + 20))((int)&pAVar14->carObj_ + (int)*(short *)((char *)pAVar14->_vf + 16),3);

        }

        pCVar21 = this->carObj_;

        this->state_ = (AIState_Base*)pAVar26;

        this->stateType_ = 4;

        pSVar8 = (Speaker *)Speech_Mobile(pCVar21);

        (**(int (**)(...))((char *)pSVar8->_vf + 52))

                  ((int)&(pSVar8->fPosition).flags + (int)*(short *)((char *)pSVar8->_vf + 48),

                   (this->perpTarget_)->carObj_);

      }

    }

    if ((this->forcePurgatory_ == 0) &&

       (iVar12 = AILife_EvaluateLife(this->carObj_), iVar12 == 0))

    goto stateExecuteAndReturn;

    pCVar21 = this->carObj_;

    this->forcePurgatory_ = 0;

    pSVar8 = (Speaker *)Speech_Mobile(pCVar21);

    (**(int (**)(...))((char *)pSVar8->_vf + 132))

              ((int)&(pSVar8->fPosition).flags + (int)*(short *)((char *)pSVar8->_vf + 128));

    this->AssignToPlayer((AIHigh_Player *)0x0);

    pAVar11 = operator new(8);

    pAVar14 = (AIState_Base *) (new(pAVar11) AIState_Purgatory(this->carObj_));

    pAVar22 = this->state_;

    if (pAVar22 != (AIState_Base *)0x0) {

      (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

    }

    sVar15 = 1;

    break;

  case 3:

    bVar18 = this->blockade_.mode;

    if ((bVar18 == 1) || (bVar18 == 4)) {

      iVar12 = 1;

      if (GameSetup_gData.reverseTrack == 0) {

        iVar12 = -1;

      }

      (this->carObj_)->desiredDirection = iVar12;

      (this->carObj_)->driveDirection = 1;

      this->AssignToPlayer((AIHigh_Player *)0x0);

      pAVar13 = operator new(8);

      pAVar14 = (AIState_Base*)(new(pAVar13) AIState_Normal(this->carObj_));

      pAVar22 = this->state_;

      if (pAVar22 != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

      }

      this->state_ = pAVar14;

      this->stateType_ = 2;

    }

    if (this->forcePurgatory_ == 0) {

      if (this->driveAway_ == 0) {

        if (this->blockade_.mode != 2) {

          pCVar21 = this->carObj_;

          pCVar21->AIFlags = pCVar21->AIFlags & 0xfffffffd;

          iVar12 = this->CheckForNewTarget();

          if (((iVar12 != 0) && (bVar18 = this->blockade_.mode, bVar18 != 1)) &&

             (bVar18 != 4)) {

            this->GetCheckChasePosition(&local_60);

            pAVar26 = operator new(0x94);

            pAVar26 = (new(pAVar26) AIState_Chase(this->carObj_,

                                 (this->perpTarget_)->carObj_,&local_60

                                 ,AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,

                                 NitroDistanceMeters[this->type_][0],

                                 NitroDistanceMeters[this->type_][1],

                                 this->aggressionLevel_,AICop_skillDelay[GameSetup_gData.skill]));

            pAVar14 = this->state_;

            if (pAVar14 != (AIState_Base *)0x0) {

              (*(int (**)(...))((char *)pAVar14->_vf + 20))((int)&pAVar14->carObj_ + (int)*(short *)((char *)pAVar14->_vf + 16),3);

            }

            pCVar21 = this->carObj_;

            this->state_ = (AIState_Base*)pAVar26;

            this->stateType_ = 4;

            pSVar8 = (Speaker *)Speech_Mobile(pCVar21);

            (**(int (**)(...))((char *)pSVar8->_vf + 52))

                      ((int)&(pSVar8->fPosition).flags + (int)*(short *)((char *)pSVar8->_vf + 48),

                       (this->perpTarget_)->carObj_);

            goto stateExecuteAndReturn;

          }

          iVar12 = AILife_EvaluateLife(this->carObj_);

          if (iVar12 == 0) goto stateExecuteAndReturn;

          this->AssignToPlayer((AIHigh_Player *)0x0);

          pAVar11 = operator new(8);

          pAVar14 = (AIState_Base *) (new(pAVar11) AIState_Purgatory(this->carObj_));

          pAVar22 = this->state_;

          if (pAVar22 != (AIState_Base *)0x0) {

            (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

          }

          sVar15 = 1;

          break;

        }

        pCVar21 = this->carObj_;

        pCVar21->AIFlags = pCVar21->AIFlags | 2;

        iVar12 = this->requestSpikeBeltAtSlice_;

        bVar1 = false;

        if ((iVar12 != -1) && (AICop_spikeBelt.active_ == 0)) {

          if (GameSetup_gData.skill == 0) {

            iVar12 = 0xb333;

          }

          else {

            iVar12 = 0xe666;

            if (GameSetup_gData.skill == 1) {

              iVar12 = 0xcccc;

            }

          }

          iVar9 = this->requestSpikeBeltAtSlice_ * 0x20 + BWorldSm_slices;

          iVar9 = fixedmult((u_int)*(u_char *)(iVar9 + 0x1e) * 0x8000 *

                             (u_int)(*(u_char *)(iVar9 + 0x1d) >> 4),iVar12);

          iVar20 = this->requestSpikeBeltAtSlice_ * 0x20 + BWorldSm_slices;

          AICop_spikeBelt.rightLatPos_ =

               fixedmult((u_int)*(u_char *)(iVar20 + 0x1f) * 0x8000 * (*(u_char *)(iVar20 + 0x1d) & 0xf)

                          ,iVar12);

          AICop_spikeBelt.leftLatPos_ = -iVar9;

          AICop_spikeBelt.slice_ = this->requestSpikeBeltAtSlice_;

          AICop_spikeBelt.active_ = 1;

          AICop_spikeBelt.freshenTime_ = simGlobal.gameTicks;

          BWorld_SetSpikeBelt(this->requestSpikeBeltAtSlice_,AICop_spikeBelt.leftLatPos_,

                     iVar9 + AICop_spikeBelt.rightLatPos_);

          iVar12 = this->requestSpikeBeltAtSlice_;

        }

        AICop_gRoadBlockState = 1;

        if ((iVar12 != -1) && (AICop_spikeBelt.slice_ == iVar12)) {

          AICop_spikeBelt.freshenTime_ = simGlobal.gameTicks;

        }

        if (this->blockade_.flags != 0) {

          if (stackSpeedUpEnbabledFlag == 0) {

            this->SetupBlockadeElements(&this->blockade_);

          }

          else {

            gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
            stackSpeedUpEnbabledFlag = 0;

            this->SetupBlockadeElements(&this->blockade_);

            gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
            stackSpeedUpEnbabledFlag = 1;

          }

        }

        pAVar23 = this->perpTarget_;

        iVar12 = ((pAVar23->perpChaseInfo_).chaseLevel_)->engagementLapFraction *

                 AITune_gRoughLapTime;

        if (iVar12 < 0) {

          iVar12 = iVar12 + 0xffff;

        }

        iVar9 = (iVar12 >> 0x10) << 5;

        iVar20 = 0x10000 / iVar9;

        if (iVar9 == 0) {

          trap(0x1c00);

        }

        (pAVar23->perpChaseInfo_).engagementTime_ = (iVar12 >> 0x10) << 0x15;

        (pAVar23->perpChaseInfo_).engagementPercentIncreasePerTick_ = iVar20;

        if (GameSetup_gData.numLaps == 2) {

          iVar12 = 0x13333;

LAB_80064d28:

          iVar12 = fixedmult(iVar20,iVar12);

          (pAVar23->perpChaseInfo_).engagementPercentIncreasePerTick_ = iVar12;

        }

        else {

          iVar12 = 0xa8f5;

          if (GameSetup_gData.numLaps == 4) goto LAB_80064d28;

        }

        this->GetCheckChasePosition(&local_60);

        iVar9 = AIWorld_ApxSplineDistance(this->carObj_,

                           (this->perpTarget_)->carObj_);

        iVar12 = iVar9;

        if (iVar9 < 0) {

          iVar12 = -iVar9;

        }

        if (iVar12 < 0x320000) {

LAB_80064df8:

          bVar1 = true;

        }

        else if (iVar12 < 0x12c0000) {

          iVar12 = ((this->perpTarget_)->carObj_)->currentSpeed;

          if (iVar12 < 1) {

            iVar12 = -iVar12;

          }

          if (((0x471c7 < iVar12) &&

              (iVar12 = fixeddiv(iVar9,((this->perpTarget_)->carObj_)

                                         ->currentSpeed), 0 < iVar12)) &&

             (iVar12 < this->blockade_.releaseTime)) goto LAB_80064df8;

        }

        if (!bVar1) {

          iVar12 = AIWorld_ApxSplineDistance((this->perpTarget_)->carObj_,

                              this->blockade_.slice);

          if (iVar12 < 0) {

            iVar12 = iVar12 + 0xffff;

          }

          if (this->blockade_.initialPlayerDistanceMetersInt * (iVar12 >> 0x10) <

              1) goto stateExecuteAndReturn;

        }

        this->requestSpikeBeltAtSlice_ = -1;

        if (this->blockade_.chaseLevel ==

            (this->perpTarget_->perpChaseInfo_).chaseLevelIndex_) {

          (this->perpTarget_->perpChaseInfo_).engagementTime_ = 0;

        }

        this->blockade_.mode = 0;

        pAVar26 = operator new(0x94);

        pAVar26 = (new(pAVar26) AIState_Chase(this->carObj_,

                             (this->perpTarget_)->carObj_,&local_60,

                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,

                             NitroDistanceMeters[this->type_][0],

                             NitroDistanceMeters[this->type_][1],

                             this->aggressionLevel_,AICop_skillDelay[GameSetup_gData.skill]));

        pAVar14 = this->state_;

        if (pAVar14 != (AIState_Base *)0x0) {

          (*(int (**)(...))((char *)pAVar14->_vf + 20))((int)&pAVar14->carObj_ + (int)*(short *)((char *)pAVar14->_vf + 16),3);

        }

        iVar12 = this->blockade_.reverse;

        this->state_ = (AIState_Base*)pAVar26;

        this->stateType_ = 4;

        if (iVar12 != 0) {

          AIPhysic_ChangeDirection(this->carObj_,0x40);

        }

        goto stateExecuteAndReturn;

      }

LAB_80064a0c:

      iVar12 = 1;

      if (GameSetup_gData.reverseTrack == 0) {

        iVar12 = -1;

      }

      (this->carObj_)->desiredDirection = iVar12;

      (this->carObj_)->driveDirection = 1;

      this->AssignToPlayer((AIHigh_Player *)0x0);

      pAVar13 = operator new(8);

      pAVar14 = (AIState_Base*)(new(pAVar13) AIState_Normal(this->carObj_));

      pAVar22 = this->state_;

      if (pAVar22 != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

      }

      AVar19 = this->driveAway_;

      this->state_ = pAVar14;

      this->stateType_ = 2;

      if (AVar19 == 1) {

        Cars_ResetCollidedCars(this->carObj_,1,1);

      }

      this->driveAway_ = 0;

      goto stateExecuteAndReturn;

    }

    pCVar21 = this->carObj_;

    this->forcePurgatory_ = 0;

    pSVar8 = (Speaker *)Speech_Mobile(pCVar21);

    (**(int (**)(...))((char *)pSVar8->_vf + 132))

              ((int)&(pSVar8->fPosition).flags + (int)*(short *)((char *)pSVar8->_vf + 128));

    this->AssignToPlayer((AIHigh_Player *)0x0);

    pAVar11 = operator new(8);

    pAVar14 = (AIState_Base *) (new(pAVar11) AIState_Purgatory(this->carObj_));

    pAVar22 = this->state_;

    if (pAVar22 != (AIState_Base *)0x0) {

      (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

    }

    sVar15 = 1;

    break;

  case 4:

    pCVar21 = this->carObj_;

    pAVar26 = (AIState_Chase *)this->state_;

    pCVar21->AIFlags = pCVar21->AIFlags | 2;

    if (0xa0 < pAVar26->barrierTicks32_) {

      iVar12 = (pAVar26)->FindBarrierEndSlice();

      pAVar25 = operator new(0x10);

      pAVar25 = (new(pAVar25) AIState_GotoSlice(this->carObj_,iVar12,0));

      pAVar14 = this->state_;

      if (pAVar14 != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)pAVar14->_vf + 20))((int)&pAVar14->carObj_ + (int)*(short *)((char *)pAVar14->_vf + 16),3);

      }

      pCVar21 = this->carObj_;

      this->state_ = (AIState_Base *)pAVar25;

      this->stateType_ = 9;

      pSVar8 = (Speaker *)Speech_Mobile(pCVar21);

      (**(int (**)(...))((char *)pSVar8->_vf + 60))

                ((int)&(pSVar8->fPosition).flags + (int)*(short *)((char *)pSVar8->_vf + 56));

    }

    piVar17 = ((this->perpTarget_->perpChaseInfo_).chaseLevel_)->copChasers +

              this->type_;

    if ((*piVar17 == 0) && (piVar17[3] == 0)) {

      pAVar26->nitrousTicks_ = 0;

    }

    this->requestSpikeBeltAtSlice_ = -1;

    bVar1 = false;

    if (pAVar26->slowDownEndTime_ <= simGlobal.gameTicks) {

      iVar12 = this->CheckForNeedyPlayers();

      bVar1 = iVar12 != -1;

    }

    if (bVar1) {

      pAVar26->slowDownEndTime_ = simGlobal.gameTicks + 0x3c0;

    }

    this->HandleBlockadeSpeech();

    bVar1 = false;

    iVar12 = this->GetCheckChasePosition(&local_60);

    if (iVar12 != 0) {

      bVar1 = pAVar26->murderMode_ == 0;

    }

    if (bVar1) {

      (pAVar26)->SetTarget((this->perpTarget_)->carObj_,&local_60);

    }

    iVar12 = this->aggressionLevel_;

    bVar1 = false;

    if (AIHigh_Cop_AggressionData[iVar12].ticksInChaseRegionForMurder < pAVar26->inTargetRegion_) {

      iVar9 = pAVar26->latMetersBetween_;

      if (iVar9 < 0) {

        iVar9 = -iVar9;

      }

      if (iVar9 < AIHigh_Cop_AggressionData[iVar12].minLatMetersDistanceForMurder) {

        iVar9 = pAVar26->longMetersBetween_;

        if (iVar9 < 0) {

          iVar9 = -iVar9;

        }

        bVar1 = iVar9 < AIHigh_Cop_AggressionData[iVar12].minLongMetersDistanceForMurder;

      }

    }

    if (bVar1) {

      (pAVar26)->SetMurderMode(1,AIHigh_Cop_AggressionData[this->aggressionLevel_].murderTicks);

    }

    bVar1 = false;

    iVar12 = ((AIHigh_BasicCop *)this)->ShouldIPerformCutOffBlock(0x4000,

                        (this->perpTarget_)->carObj_);

    if (iVar12 != 0) {

      bVar1 = pAVar26->murderMode_ == 0;

    }

    if (bVar1) {

      memset((u_char *)(local_54 + 4),'\0',0xc);

      (pAVar26)->SetTarget((this->perpTarget_)->carObj_,

                 (coorddef *)(local_54 + 4));

      (pAVar26)->SetMurderMode(1,0x20);

    }

    iVar12 = this->CheckForNewTarget();

    if (iVar12 != 0) {

      this->GetCheckChasePosition((coorddef *)(local_54 + 4));

      (pAVar26)->SetTarget((this->perpTarget_)->carObj_,

                 (coorddef *)(local_54 + 4));

    }

    bVar18 = this->blockade_.mode;

    if (bVar18 == 1) {

LAB_80064750:

      iVar12 = 1;

      if (GameSetup_gData.reverseTrack == 0) {

        iVar12 = -1;

      }

      (this->carObj_)->desiredDirection = iVar12;

      (this->carObj_)->driveDirection = 1;

LAB_80064778:

      this->AssignToPlayer((AIHigh_Player *)0x0);

      pAVar13 = operator new(8);

      pAVar14 = (AIState_Base*)(new(pAVar13) AIState_Normal(this->carObj_));

      pAVar22 = this->state_;

      if (pAVar22 != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

      }

      this->state_ = pAVar14;

      this->stateType_ = 2;

    }

    else if (((bVar18 == 4) || (this->perpTarget_ == (AIHigh_Player *)0x0)) ||

            (1 < (((this->perpTarget_)->carObj_)->stats).finishType)) {

      if ((bVar18 == 1) || (bVar18 == 4)) goto LAB_80064750;

      goto LAB_80064778;

    }

    if ((this->forcePurgatory_ == 0) &&

       (iVar12 = AILife_EvaluateLife(this->carObj_), iVar12 == 0)) {

      if (this->driveAway_ == 0) goto stateExecuteAndReturn;

      goto LAB_80064a0c;

    }

    iVar12 = AILife_EvaluateLife(this->carObj_);

    if ((iVar12 != 0) && (this->driveAway_ == 0)) {

      pSVar8 = (Speaker *)Speech_Mobile(this->carObj_);

      (**(int (**)(...))((char *)pSVar8->_vf + 60))

                ((int)&(pSVar8->fPosition).flags + (int)*(short *)((char *)pSVar8->_vf + 56));

    }

    pSVar8 = (Speaker *)Speech_Mobile(this->carObj_);

    (**(int (**)(...))((char *)pSVar8->_vf + 132))

              ((int)&(pSVar8->fPosition).flags + (int)*(short *)((char *)pSVar8->_vf + 128));

    this->forcePurgatory_ = 0;

    this->AssignToPlayer((AIHigh_Player *)0x0);

    pAVar11 = operator new(8);

    pAVar14 = (AIState_Base *) (new(pAVar11) AIState_Purgatory(this->carObj_));

    pAVar22 = this->state_;

    if (pAVar22 != (AIState_Base *)0x0) {

      (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

    }

    sVar15 = 1;

    break;

  case 5:

    pCVar21 = this->carObj_;

    if ((pCVar21->N).simOptz == '\0') {

      pCVar21->extraWallCollisionAllowance = 0;

    }

    else {

      pCVar21->extraWallCollisionAllowance = 0x18000;

    }

    this->requestSpikeBeltAtSlice_ = -1;

    ppCVar24 = Cars_gRaceCarList;

    for (iVar12 = 0; iVar12 < Cars_gNumRaceCars; iVar12 = iVar12 + 1) {

      if (highLevelAIObjs[(*ppCVar24)->carIndex][5].carObj_ != (Car_tObj *)0x0) {

        ((AIState_Offroad *)this->state_)->UnleashIfInRange(*ppCVar24);

      }

      ppCVar24 = ppCVar24 + 1;

    }

    pCVar21 = this->carObj_;

    iVar12 = (pCVar21->N).simRoadInfo.slice * 0x20 + BWorldSm_slices;

    if (((int)-((u_int)*(u_char *)(iVar12 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar12 + 0x1d) >> 4)) <=

         pCVar21->roadPosition) &&

       (pCVar21->roadPosition <=

        (int)((u_int)*(u_char *)(iVar12 + 0x1f) * 0x8000 * (*(u_char *)(iVar12 + 0x1d) & 0xf)))) {

      pCVar21->extraWallCollisionAllowance = 0;

      this->AssignToPlayer((AIHigh_Player *)0x0);

      pAVar13 = operator new(8);

      pAVar14 = (AIState_Base*)(new(pAVar13) AIState_Normal(this->carObj_));

      pAVar22 = this->state_;

      if (pAVar22 != (AIState_Base *)0x0) {

        (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

      }

      this->state_ = pAVar14;

      this->stateType_ = 2;

    }

    if ((this->forcePurgatory_ == 0) &&

       (iVar12 = AILife_EvaluateLife(this->carObj_), iVar12 == 0))

    goto stateExecuteAndReturn;

    (this->carObj_)->extraWallCollisionAllowance = 0;

    this->forcePurgatory_ = 0;

    this->AssignToPlayer((AIHigh_Player *)0x0);

    pAVar11 = operator new(8);

    pAVar14 = (AIState_Base *) (new(pAVar11) AIState_Purgatory(this->carObj_));

    pAVar22 = this->state_;

    if (pAVar22 != (AIState_Base *)0x0) {

      (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

    }

    sVar15 = 1;

    break;

  case 6:

  case 7:

  case 8:

  case 10:

  default:

    goto stateExecuteAndReturn;

  case 9:

    pAVar25 = (AIState_GotoSlice *)this->state_;

    this->AssignToPlayer((AIHigh_Player *)0x0);

    iVar12 = (pAVar25)->InTargetSliceRange(0xa0000);

    if (iVar12 == 0) goto stateExecuteAndReturn;

    pAVar13 = operator new(8);

    pAVar14 = (AIState_Base*)(new(pAVar13) AIState_Normal(this->carObj_));

    pAVar22 = this->state_;

    if (pAVar22 != (AIState_Base *)0x0) {

      (*(int (**)(...))((char *)pAVar22->_vf + 20))((int)&pAVar22->carObj_ + (int)*(short *)((char *)pAVar22->_vf + 16),3);

    }

    sVar15 = 2;

  }

  this->state_ = pAVar14;

  this->stateType_ = sVar15;

stateExecuteAndReturn:

  (this->state_)->StateExecute()

  ;

  return;

}








/* ---- CheckForNeedyPlayers__10AIHigh_Cop  AIHigh_Cop::CheckForNeedyPlayers  [AIH_COP.CPP:819-835] SLD-VERIFIED ---- */

int AIHigh_Cop::CheckForNeedyPlayers()



{
  int needy;

  int hLoop;

  Car_tObj *thisPlayerObj;

  int iVar1;

  Car_tObj **ppCVar3;



  needy = -1;

  hLoop = 0;

  ppCVar3 = Cars_gHumanRaceCarList;

  while (true) {

    if (Cars_gNumHumanRaceCars <= hLoop) break;

    thisPlayerObj = *ppCVar3;

    if (800 < (int)highLevelAIObjs[thisPlayerObj->carIndex][7].state_) {

      iVar1 = thisPlayerObj->currentSpeed;

      if (iVar1 < 0) {

        iVar1 = -iVar1;

      }

      if (0x140000 < iVar1) {

        needy = thisPlayerObj->carIndex;

      }

    }

    ppCVar3 = ppCVar3 + 1;

    hLoop = hLoop + 1;

  }

  return needy;

}








/* ---- CheckForWipeOut__10AIHigh_Cop  AIHigh_Cop::CheckForWipeOut  [AIH_COP.CPP:845-885] SLD-VERIFIED ---- */

void AIHigh_Cop::CheckForWipeOut()



{
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

      if ((this->carObj_)->wipeOutEndTick <= D_8011E0B0[0]) {

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

  iVar2 = 0;

  if (!bVar1) {
    int perTickProb;

    int perTickProbBase;

    int randVal;

    int thisTargetLevel;

    int hLoop;

    Car_tObj *thisPlayerObj;

    AIHigh_Player *thisPlayer;

    randtemp = fastRandom * randSeed;

    perTickProbBase = AI_elapsedTime * 88;

    thisTargetLevel = (this->perpTarget_->perpChaseInfo_).chaseLevelIndex_;

    randVal = (int)((randtemp >> 8) & 0xffff);

    fastRandom = randtemp & 0xffff;

    hLoop = 0;

    while (true) {

      if (Cars_gNumHumanRaceCars <= hLoop) break;

      thisPlayerObj = Cars_gHumanRaceCarList[hLoop];

      thisPlayer = (AIHigh_Player *)highLevelAIObjs[thisPlayerObj->carIndex];

      if (thisTargetLevel < (thisPlayer->perpChaseInfo_).chaseLevelIndex_) {

        /* perTickProb == AI_elapsedTime*89, split as (AI_elapsedTime*88)+AI_elapsedTime -- reproduces the
           oracle's own strength-reduction: the *88 partial product is loop-invariant (hoisted once as
           perTickProbBase), the final +1x add is redone fresh each iteration from the same cached value. */
        perTickProb = perTickProbBase + AI_elapsedTime;

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

  int iVar2;

  blockadeMode_t bVar3;

  int iVar4;

  AIHigh_Player *pAVar5;

  int iVar7;

  AIHigh_Player *target;

  int iVar8;

  AIHigh_Player *pAVar9;

  

  target = (AIHigh_Player *)0x0;

  iVar8 = 0x27100000;

  bVar3 = this->blockade_.mode;

  pAVar9 = this->perpTarget_;

  bVar1 = false;

  if (((bVar3 == 1) || (bVar3 == 4)) || (bVar3 == 2)) {

    bVar1 = true;

  }

  if (bVar1) {

    return 0;

  }

  iVar7 = 0;

  while (true) {

    if (Cars_gNumRaceCars <= iVar7) break;

    pAVar5 = (AIHigh_Player *)highLevelAIObjs[Cars_gRaceCarList[iVar7]->carIndex];

    iVar4 = 0;

    if ((pAVar5)->basicPerpInfo_.crime_ != 0) {

      iVar4 = ((pAVar5->perpChaseInfo_).chaseLevel_)->copChasers[this->type_];

    }

    iVar2 = (pAVar5)->basicPerpInfo_.copsAssigned_[this->type_];

    if ((this->perpTarget_ != (AIHigh_Player *)0x0) && (this->perpTarget_ == pAVar5)) {

      iVar2 = iVar2 + -1;

    }

    if (iVar2 < iVar4) {

      iVar4 = AIWorld_ApxSplineDistance(this->carObj_,

                         (pAVar5)->carObj_);

      iVar4 = __builtin_abs(iVar4);

      if (iVar4 < iVar8) {

        iVar8 = iVar4;

        target = pAVar5;

      }

    }

    iVar7 = iVar7 + 1;

  }

  iVar7 = 0;

  if (target == (AIHigh_Player *)0x0) {

    while (true) {

      if (Cars_gNumRaceCars <= iVar7) break;

      pAVar5 = (AIHigh_Player *)highLevelAIObjs[Cars_gRaceCarList[iVar7]->carIndex];

      iVar4 = AIWorld_ApxSplineDistance(this->carObj_,

                         (pAVar5)->carObj_);

      iVar4 = __builtin_abs(iVar4);

      if ((iVar4 < iVar8) && ((pAVar5)->basicPerpInfo_.crime_ != 0)) {

        iVar8 = iVar4;

        target = pAVar5;

      }

      iVar7 = iVar7 + 1;

    }

    if (target == (AIHigh_Player *)0x0) goto LAB_800657c0;

  }

  if (target != pAVar9) {

    this->AssignToPlayer(target);

    this->aggressionLevel_ =

         ((target->perpChaseInfo_).chaseLevel_)->copAggression[this->type_];

    return 1;

  }

LAB_800657c0:

  if ((pAVar9 != (AIHigh_Player *)0x0) && (target == (AIHigh_Player *)0x0)) {

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








/* ---- CheckForNewTriggers__10AIHigh_Cop  AIHigh_Cop::CheckForNewTriggers  [AIH_COP.CPP:1021-1166] SLD-VERIFIED ---- */

trigger_t * AIHigh_Cop::CheckForNewTriggers()



{
  copType cVar1;

  int iVar2;

  int trigger;

  Car_tObj *pCVar3;

  trigger_t *ptVar4;

  u_int uVar5;

  int iVar6;

  int iVar7;

  int iVar8;

  AIHigh_Base *pAVar9;

  int iVar10;

  Car_tObj *pCVar11;

  int iVar12;

  int iStack_30;

  int local_2c;

  

  if (0x5bf < simGlobal.gameTicks) {

    iVar12 = Cars_gNumCars;

    while (iVar12 = iVar12 + -1, -1 < iVar12) {

      pCVar11 = Cars_gTotalSortedList[iVar12];

      if ((pCVar11->carFlags & 1U) != 0) {

        pAVar9 = highLevelAIObjs[pCVar11->carIndex];

        cVar1 = this->type_;

        iVar10 = pAVar9[5].schedulingOff_;

        iVar6 = cVar1 * 4;

        local_2c = (&pAVar9[4].lastTrafficTriggerCheckSlice_)[cVar1];

        if (pAVar9[5].carObj_ == (Car_tObj *)0x0) {

          iVar10 = iVar10 << 1;

          if (0 < *(int *)(pAVar9[6].schedulingOff_ + iVar6)) {

            iVar2 = AICop_NoCopsInArea((int)(pAVar9->carObj_->N).simRoadInfo.slice,0x1f40000);

            iVar6 = 1;

            if (iVar2 != 0) goto LAB_80065a54;

          }

          iVar6 = 0;

        }

        else {

          iVar6 = *(int *)(pAVar9[6].schedulingOff_ + iVar6);

        }

LAB_80065a54:

        if (GameSetup_gData.skill == 2) {

          iVar10 = 0x10000;

        }

        if ((0x1bf < (int)(simGlobal.gameTicks - pAVar9[4].stateType_)) && (local_2c < iVar6)) {

          iVar6 = -1;

          if (-1 < pCVar11->currentSpeed) {

            iVar6 = 1;

          }

          iVar6 = iVar6 * 0x1f;

          if (iVar6 < 0) {

            iVar6 = (pCVar11->N).simRoadInfo.slice + iVar6;

            if (iVar6 < 0) {

              iVar6 = iVar6 + gNumSlices;

            }

          }

          else {

            iVar6 = (pCVar11->N).simRoadInfo.slice + iVar6;

            if (gNumSlices <= iVar6) {

              iVar6 = iVar6 - gNumSlices;

            }

          }

          iVar7 = pAVar9[5].lastTrafficTriggerCheckSlice_;

          pAVar9[5].lastTrafficTriggerCheckSlice_ = iVar6;

          iVar2 = iVar6;

          if (iVar7 < iVar6) {

            iVar2 = iVar7;

            iVar7 = iVar6;

          }

          iVar6 = iVar7 - iVar2;

          while ((iVar2 < iVar7 && (iVar6 < 6))) {

            trigger = triggerManagerCops->CheckForTriggerAtSlice(pCVar11->carIndex, iVar2);

            iVar8 = iVar10 * 100;

            if (trigger == -1) {

LAB_80065c28:

              iVar2 = iVar2 + 1;

            }

            else {

              if (iVar8 < 0) {

                iVar8 = iVar8 + 0xffff;

              }

              randtemp = fastRandom * randSeed;

              fastRandom = randtemp & 0xffff;

              uVar5 = randtemp >> 8;

              pCVar3 = AILife_IsSliceInAnyVisibleArea(iVar2);

              if (pCVar3 != (Car_tObj *)0x0) goto LAB_80065c28;

              if ((local_2c != 0) ||

                 (iVar2 = iVar2 + 1, (int)((uVar5 & 0xffff) * 0x19 >> 0xe) < iVar8 >> 0x10)) {

                ptVar4 = triggerManagerCops->GetTrigger(trigger, &iStack_30);

                return ptVar4;

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
