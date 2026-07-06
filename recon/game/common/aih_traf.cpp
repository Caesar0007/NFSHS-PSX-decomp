/* game/common/aih_traf.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_traf_externs.h"


/* ---- CheckForCops__14AIHigh_TrafficPi  AIHigh_Traffic::CheckForCops  [AIH_TRAF.CPP:32-56] SLD-VERIFIED ---- */
Car_tObj *

AIHigh_Traffic::CheckForCops(int *closestDistance)



{
  int copLoop;
  Car_tObj*closestCop;
  Car_tObj*cop;
  int sliceDistance;

  int iVar1;

  Car_tObj *otherCarObj;

  Car_tObj **ppCVar2;

  int iVar3;

  Car_tObj *pCVar4;

  

  pCVar4 = (Car_tObj *)0x0;

  *closestDistance = 0x4e200000;

  ppCVar2 = Cars_gCopCarList;

  for (iVar3 = 0; iVar3 < Cars_gNumCopCars; iVar3 = iVar3 + 1) {

    otherCarObj = *ppCVar2;

    if ((otherCarObj->AIFlags & 4U) == 0) {

      iVar1 = AIWorld_ApxSplineDistance(this->carObj_,otherCarObj);

      if (iVar1 < 0) {

        iVar1 = -iVar1;

      }

      if (iVar1 < *closestDistance) {

        *closestDistance = iVar1;

        pCVar4 = otherCarObj;

      }

    }

    ppCVar2 = ppCVar2 + 1;

  }

  return pCVar4;

}








/* ---- CopCheck__14AIHigh_TrafficPi  AIHigh_Traffic::CopCheck  [AIH_TRAF.CPP:61-121] SLD-VERIFIED ---- */
AIHigh_Cop *

AIHigh_Traffic::CopCheck(int *blockade)



{
  Car_tObj*closest;
  int closestDistance;
  int speed;
  AIHigh_Cop*cop;

  Car_tObj *pCVar1;

  int iVar2;

  AIHigh_Cop *pAVar3;

  int local_18 [2];

  

  *blockade = 0;

  pAVar3 = (AIHigh_Cop *)0x0;

  if (Cars_gNumCopCars != 0) {

    pCVar1 = this->CheckForCops(local_18);

    pAVar3 = (AIHigh_Cop *)0x0;

    if (pCVar1 != (Car_tObj *)0x0) {

      iVar2 = pCVar1->currentSpeed;

      if (iVar2 < 0) {

        iVar2 = -iVar2;

      }

      if ((iVar2 < 0x20000) && (local_18[0] < 0x4b0000)) {

        *blockade = 1;

        pAVar3 = (AIHigh_Cop *)highLevelAIObjs[pCVar1->carIndex];

        if (((AIHigh_Cop *)highLevelAIObjs[pCVar1->carIndex])->perpTarget_ == (AIHigh_Player *)0x0)

        {

          pAVar3 = (AIHigh_Cop *)0x0;

        }

      }

      else {

        pAVar3 = (AIHigh_Cop *)0x0;

        if ((0x20000 < iVar2) && (pAVar3 = (AIHigh_Cop *)0x0, local_18[0] < 0x4b0000)) {

          pAVar3 = (AIHigh_Cop *)highLevelAIObjs[pCVar1->carIndex];

        }

      }

    }

  }

  return pAVar3;

}








/* ---- HighExecute__14AIHigh_Traffic  AIHigh_Traffic::HighExecute  [AIH_TRAF.CPP:129-340] SLD-VERIFIED ---- */

void AIHigh_Traffic::HighExecute()



{
  trigger_t *pNewTrigger;
  coorddef trafficOffset;
  AIState_Base*newState;
  BWorldSm_Pos spos;
  int blockade;
  int cRand;
  AIState_Idle*idleState;
  int slice;

  bool bVar1;

  trigger_t *trigger;

  AIState_RovingTraffic *pAVar2;

  AIState_Idle *this_00;

  AIHigh_Cop *pAVar3;

  int iVar4;

  AIState_Purgatory *pAVar5;

  AIState_Base *pAVar6;

  stateType_t sVar7;

  __vtbl_ptr_type (*pa_Var8) [4];

  AIState_Normal *pAVar9;

  Car_tObj *pCVar10;

  u_int uVar11;

  AIState_Base *pAVar12;

  coorddef local_c0;

  BWorldSm_Pos local_b0;

  int local_28;

  int iStack_24;

  int local_20;

  

  (this->carObj_)->unlap = 0;

  (this->carObj_)->lap = 0;

  switch(this->stateType_) {

  case 0:

    local_c0.x = 0;

    local_c0.y = 0x640000;

    local_c0.z = 0;

    if (((this->carObj_)->carFlags & 0x400U) == 0) {

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      sVar7 = 1;

    }

    else {

      pAVar6 = operator new(0x10);

      (new(pAVar6) AIState_Base(this->carObj_));

      pAVar6->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

      pAVar6[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      sVar7 = 3;

    }

    this->state_ = pAVar6;

    this->stateType_ = sVar7;

    Newton_SetInitialSlicePositionOrientationEtc(&(this->carObj_)->N,0,&local_c0,1);

    return;

  case 1:

    bVar1 = false;

    if (this->accidentData_ == (SceneElem *)0x0) {

      pAVar6 = this->state_;

      pa_Var8 = pAVar6->_vf;

      iVar4 = (*(int (*)(...))pa_Var8[7])((int)&pAVar6->carObj_ + (int)*(short *)pa_Var8[6]);

      if (iVar4 != 0) {

        bVar1 = this->forcePurgatory_ == 0;

      }

      if (bVar1) {

        trigger = this->CheckForNewTriggers();

        if (trigger == (trigger_t *)0x0) {

          pAVar9 = operator new(8);

          pAVar6 = (AIState_Base*)(new(pAVar9) AIState_Normal(this->carObj_));

          pAVar12 = this->state_;

          if (pAVar12 != (AIState_Base *)0x0) {

            (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

          }

          this->state_ = pAVar6;

          this->stateType_ = 2;

          AILife_ReencarnateTraffic(this->carObj_);

        }

        else {

          triggerManagerTraffic->DescribeTrigger(trigger);

          if (*(int *)trigger == 5) {

            pAVar2 = operator new(0x18);

            pAVar2 = (new(pAVar2) AIState_RovingTraffic(this->carObj_,trigger));

            pAVar6 = this->state_;

            if (pAVar6 != (AIState_Base *)0x0) {

              (*(int (*)(...))pAVar6->_vf[5])((int)&pAVar6->carObj_ + (int)*(short *)pAVar6->_vf[4],3);

            }

            this->stateType_ = 6;

            this->state_ = (AIState_Base*)pAVar2;

            AILife_ReencarnateTrafficByPosition(this->carObj_,*(int *)(trigger + 4),1,

                       *(coorddef **)(trigger + 0x3c),(matrixtdef *)(trigger + 0xc));

          }

        }

      }

    }

    else {

      pAVar6 = operator new(0x10);

      (new(pAVar6) AIState_Base(this->carObj_));

      pAVar6->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

      pAVar6[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      this->state_ = pAVar6;

      this->stateType_ = 3;

      local_b0.slice = 0;

      BWorldSm_FindClosestSlice(&this->accidentData_->cp,&local_b0);

      AILife_ReencarnateTrafficByPosition(this->carObj_,(int)local_b0.slice,1,&this->accidentData_->cp,

                 &this->accidentData_->orient);

      pCVar10 = this->carObj_;

      pCVar10->carFlags = pCVar10->carFlags | 0x400;

      this->accidentData_ = (SceneElem *)0x0;

    }

    goto switchD_80065ec8_caseD_4;

  case 2:

    iVar4 = AILife_EvaluateLife(this->carObj_);

    if (iVar4 == 0) {

      if (this->forcePurgatory_ == 0) {

        pAVar3 = this->CopCheck(&local_28);

        if (pAVar3 == (AIHigh_Cop *)0x0) {

          this->ignoreCops_ = 0;

          goto switchD_80065ec8_caseD_4;

        }

        if (this->ignoreCops_ != 0) goto switchD_80065ec8_caseD_4;

        randtemp = fastRandom * randSeed;

        fastRandom = randtemp & 0xffff;

        uVar11 = (randtemp >> 8 & 0xffff) * 5 >> 0xf;

        if (local_28 == 0) {

          if (uVar11 == 0) {

            pAVar6 = operator new(0x10);

            (new(pAVar6) AIState_Base(this->carObj_))

            ;

            pAVar6->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

            pAVar6[1]._vf = (__vtbl_ptr_type (*) [4])0x1;

            pAVar12 = this->state_;

            if (pAVar12 != (AIState_Base *)0x0) {

              (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

            }

            sVar7 = 3;

            break;

          }

          if (7 < uVar11) {

            this->ignoreCops_ = 1;

            goto switchD_80065ec8_caseD_4;

          }

          iVar4 = (int)((this->carObj_)->N).simRoadInfo.slice;

          this_00 = operator new(0x10);

          (new((AIState_Base*)this_00) AIState_Base(this->carObj_));

          (this_00)->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

          this_00->idleInPlaceFlag_ = 1;

          pAVar6 = this->state_;

          if (pAVar6 != (AIState_Base *)0x0) {

            (*(int (*)(...))pAVar6->_vf[5])((int)&pAVar6->carObj_ + (int)*(short *)pAVar6->_vf[4],3);

          }

          this->state_ = (AIState_Base*)this_00;

          this->stateType_ = 3;

          if ((this->carObj_)->direction != 1) goto LAB_800664c4;

          iVar4 = iVar4 * 0x20 + BWorldSm_slices;

          local_20 = (u_int)*(u_char *)(iVar4 + 0x1f) << 0xf;

          uVar11 = *(u_char *)(iVar4 + 0x1d) & 0xf;

        }

        else {

          iVar4 = (int)((this->carObj_)->N).simRoadInfo.slice;

          this_00 = operator new(0x10);

          (new((AIState_Base*)this_00) AIState_Base(this->carObj_));

          (this_00)->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

          this_00->idleInPlaceFlag_ = 1;

          pAVar6 = this->state_;

          if (pAVar6 != (AIState_Base *)0x0) {

            (*(int (*)(...))pAVar6->_vf[5])((int)&pAVar6->carObj_ + (int)*(short *)pAVar6->_vf[4],3);

          }

          this->state_ = (AIState_Base*)this_00;

          this->stateType_ = 3;

          if ((this->carObj_)->direction == 1) {

            iVar4 = iVar4 * 0x20 + BWorldSm_slices;

            local_20 = (u_int)*(u_char *)(iVar4 + 0x1f) << 0xf;

            uVar11 = *(u_char *)(iVar4 + 0x1d) & 0xf;

          }

          else {

LAB_800664c4:

            iVar4 = iVar4 * 0x20 + BWorldSm_slices;

            local_20 = (u_int)*(u_char *)(iVar4 + 0x1e) << 0xf;

            uVar11 = (u_int)(*(u_char *)(iVar4 + 0x1d) >> 4);

          }

        }

        local_20 = local_20 * uVar11;

        (this_00)->SetIdlePosition(local_20);

        goto switchD_80065ec8_caseD_4;

      }

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      sVar7 = 1;

    }

    else {

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      sVar7 = 1;

    }

    break;

  case 3:

    iVar4 = AILife_EvaluateLife(this->carObj_);

    if (iVar4 == 0) {

      pAVar3 = this->CopCheck(&iStack_24);

      if ((pAVar3 != (AIHigh_Cop *)0x0) || (((this->carObj_)->carFlags & 0x400U) != 0)

         ) goto switchD_80065ec8_caseD_4;

LAB_80066684:

      pAVar9 = operator new(8);

      pAVar6 = (AIState_Base*)(new(pAVar9) AIState_Normal(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      sVar7 = 2;

    }

    else {

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      sVar7 = 1;

    }

    break;

  default:

    goto switchD_80065ec8_caseD_4;

  case 6:

    iVar4 = AILife_EvaluateLife(this->carObj_);

    if (iVar4 == 0) {

      if (this->forcePurgatory_ == 0) {

        pAVar6 = this->state_;

        pa_Var8 = pAVar6->_vf;

        iVar4 = (*(int (*)(...))pa_Var8[7])((int)&pAVar6->carObj_ + (int)*(short *)pa_Var8[6]);

        if (iVar4 == 0) goto switchD_80065ec8_caseD_4;

        goto LAB_80066684;

      }

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      sVar7 = 1;

    }

    else {

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(int (*)(...))pAVar12->_vf[5])((int)&pAVar12->carObj_ + (int)*(short *)pAVar12->_vf[4],3);

      }

      sVar7 = 1;

    }

  }

  this->state_ = pAVar6;

  this->stateType_ = sVar7;

switchD_80065ec8_caseD_4:

  (this->state_)->StateExecute();

  return;

}








/* ---- __14AIHigh_TrafficP8Car_tObj  AIHigh_Traffic::ctor  [AIH_TRAF.CPP:343-347] SLD-VERIFIED ---- */
AIHigh_Traffic::AIHigh_Traffic(Car_tObj *carObj)



{

  (new((AIHigh_Base *)this) AIHigh_Base(carObj));

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_Traffic_vtable;

  this->ignoreCops_ = 0;

  this->forcePurgatory_ = 0;

  this->accidentData_ = (SceneElem *)0x0;

  return;

}








/* ---- CheckForNewTriggers__14AIHigh_Traffic  AIHigh_Traffic::CheckForNewTriggers  [AIH_TRAF.CPP:353-433] SLD-VERIFIED ---- */

trigger_t * AIHigh_Traffic::CheckForNewTriggers()



{
  int sortedLoop;
  Car_tObj*testCar;
  int dir;
  AIHigh_Base*thisPlayer;
  int thisSlice;
  int startSlice;
  int endSlice;
  int fRandomChance;
  int newSlice;
  int temp;
  int sliceLoop;
  int triggerHere;
  int iRandomChance;
  int randomValue;
  int unused;

  int trigger;

  Car_tObj *pCVar1;

  trigger_t *ptVar2;

  u_int uVar3;

  int iVar4;

  int iVar5;

  int slice;

  Car_tObj *pCVar6;

  int iVar7;

  int iStack_30;

  Car_tObj **local_2c;

  

  iVar7 = Cars_gNumCars + -1;

  local_2c = Cars_gTotalSortedList + iVar7;

  do {

    if (iVar7 < 0) {

      return (trigger_t *)0x0;

    }

    pCVar6 = *local_2c;

    iVar4 = -1;

    if ((pCVar6->carFlags & 0x204U) != 0) {

      if (-1 < pCVar6->currentSpeed) {

        iVar4 = 1;

      }

      iVar4 = iVar4 * 0x2d;

      if (iVar4 < 0) {

        iVar4 = (pCVar6->N).simRoadInfo.slice + iVar4;

        if (iVar4 < 0) {

          iVar4 = iVar4 + gNumSlices;

        }

      }

      else {

        iVar4 = (pCVar6->N).simRoadInfo.slice + iVar4;

        if (gNumSlices <= iVar4) {

          iVar4 = iVar4 - gNumSlices;

        }

      }

      iVar5 = highLevelAIObjs[pCVar6->carIndex]->lastTrafficTriggerCheckSlice_;

      highLevelAIObjs[pCVar6->carIndex]->lastTrafficTriggerCheckSlice_ = iVar4;

      slice = iVar4;

      if (iVar5 < iVar4) {

        slice = iVar5;

        iVar5 = iVar4;

      }

      iVar4 = iVar5 - slice;

      while ((slice < iVar5 && (iVar4 < 0x32))) {

        trigger = triggerManagerTraffic->CheckForTriggerAtSlice(pCVar6->carIndex, slice);

        if (trigger != -1) {

          randtemp = fastRandom * randSeed;

          fastRandom = randtemp & 0xffff;

          uVar3 = randtemp >> 8;

          pCVar1 = AILife_IsSliceInAnyVisibleArea(slice);

          if ((pCVar1 == (Car_tObj *)0x0) && ((uVar3 & 0xffff) * 0x19 >> 0xe < 5000)) {

            ptVar2 = triggerManagerTraffic->GetTrigger(trigger, &iStack_30);

            return ptVar2;

          }

        }

        slice = slice + 1;

      }

    }

    iVar7 = iVar7 + -1;

    local_2c = local_2c + -1;

  } while( true );

}







/* end of aistate.cpp */

/* cont.35 B3b: base-forward dtor re-attributed from main.c (§3.23 simple variant);
   oracle = jal ___11AIHigh_Base; extern-C free fn exports the exact symbol. */
extern "C" {
void ___11AIHigh_Base(void *);
void ___14AIHigh_Traffic(void *thisp) { ___11AIHigh_Base(thisp); }
}
