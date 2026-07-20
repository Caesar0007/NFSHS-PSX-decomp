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
  Car_tObj*closestCop;
  int copLoop;



  closestCop = (Car_tObj *)0x0;

  *closestDistance = 0x4e200000;

  copLoop = 0;

  while (true) {

    Car_tObj*cop;
    int currentBest;
    int sliceDistance;

    if (Cars_gNumCopCars <= copLoop) break;

    cop = Cars_gCopCarList[copLoop];

    if ((cop->AIFlags & 4U) == 0) {

      sliceDistance = AIWorld_ApxSplineDistance(this->carObj_,cop);

      currentBest = *closestDistance;

      sliceDistance = __builtin_abs(sliceDistance);

      if (sliceDistance < currentBest) {

        closestCop = cop;

        *closestDistance = sliceDistance;

      }

    }

    copLoop = copLoop + 1;

  }

  return closestCop;

}








/* ---- CopCheck__14AIHigh_TrafficPi  AIHigh_Traffic::CopCheck  [AIH_TRAF.CPP:61-121] SLD-VERIFIED ---- */
AIHigh_Cop *

AIHigh_Traffic::CopCheck(int *blockade)



{
  Car_tObj*closest;
  int closestDistance;
  int speed;
  AIHigh_Cop*cop;



  *blockade = 0;

  cop = (AIHigh_Cop *)0x0;

  if (Cars_gNumCopCars != 0) {

    closest = this->CheckForCops(&closestDistance);

    if (closest != (Car_tObj *)0x0) {

      speed = closest->currentSpeed;

      if (speed < 0) {

        speed = -speed;

      }

      if ((speed <= 0x1ffff) && (closestDistance <= 0x4affff)) {

        *blockade = 1;

        cop = (AIHigh_Cop *)highLevelAIObjs[closest->carIndex];

        if (((AIHigh_Cop *)highLevelAIObjs[closest->carIndex])->perpTarget_ == (AIHigh_Player *)0x0)

        {

          cop = (AIHigh_Cop *)0x0;

        }

      }

      else if (speed <= 0x1ffff) {

        return cop;

      }

      else if (0x4affff < closestDistance) {

        return cop;

      }

      else {

        cop = (AIHigh_Cop *)highLevelAIObjs[closest->carIndex];

      }

    }

  }

  return cop;

}








/* TU-local rodata: the case-0 initial offset {0, 0x640000, 0}. Oracle @0x800551A4 loads this
 * via 3 `lw`s and stores to the stack, NOT via 3 immediate `li`/`sw`s -- confirming the source
 * assigns from a named const struct, not per-field literals. Sits immediately before this TU's
 * own _vt_14AIHigh_Traffic in rodata -> TU-owned, not a cross-module extern. */
static const coorddef D_800551A4 = { 0, 0x640000, 0 };

/* ---- HighExecute__14AIHigh_Traffic  AIHigh_Traffic::HighExecute  [AIH_TRAF.CPP:129-340] SLD-VERIFIED ---- */

void AIHigh_Traffic::HighExecute()



{
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

  int uVar11;

  AIState_Base *pAVar12;

  coorddef trafficOffset;

  BWorldSm_Pos spos;

  int local_28;

  int iStack_24;

  int local_20;



  (this->carObj_)->unlap = 0;

  (this->carObj_)->lap = 0;

  switch(this->stateType_) {

  case 0:

    trafficOffset = D_800551A4;

    if (((this->carObj_)->carFlags & 0x400U) == 0) {

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

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

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

      }

      sVar7 = 3;

    }

    this->state_ = pAVar6;

    this->stateType_ = sVar7;

    Newton_SetInitialSlicePositionOrientationEtc(&(this->carObj_)->N,0,&trafficOffset,1);

    return;

  case 1:

    bVar1 = false;

    if (this->accidentData_ == (SceneElem *)0x0) {

      pAVar6 = this->state_;

      pa_Var8 = pAVar6->_vf;

      iVar4 = (*(*pa_Var8)[3].pfn)((int)&pAVar6->carObj_ + (*pa_Var8)[3].delta);

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

            (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

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

              (*(*pAVar6->_vf)[2].pfn)((int)&pAVar6->carObj_ + (*pAVar6->_vf)[2].delta,3);

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

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

      }

      this->state_ = pAVar6;

      this->stateType_ = 3;

      spos.slice = 0;

      BWorldSm_FindClosestSlice(&this->accidentData_->cp,&spos);

      AILife_ReencarnateTrafficByPosition(this->carObj_,(int)spos.slice,1,&this->accidentData_->cp,

                 &this->accidentData_->orient);

      pCVar10 = this->carObj_;

      pCVar10->carFlags = pCVar10->carFlags | 0x400;

      this->accidentData_ = (SceneElem *)0x0;

    }

    goto stateExecuteAndReturn;

  case 2:

    iVar4 = AILife_EvaluateLife(this->carObj_);

    if (iVar4 == 0) {

      if (this->forcePurgatory_ == 0) {

        pAVar3 = this->CopCheck(&local_28);

        if (pAVar3 == (AIHigh_Cop *)0x0) {

          this->ignoreCops_ = 0;

          goto stateExecuteAndReturn;

        }

        if (this->ignoreCops_ != 0) goto stateExecuteAndReturn;

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

              (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

            }

            sVar7 = 3;

            break;

          }

          if (7 < uVar11) {

            this->ignoreCops_ = 1;

            goto stateExecuteAndReturn;

          }

          iVar4 = (int)((this->carObj_)->N).simRoadInfo.slice;

          this_00 = operator new(0x10);

          (new((AIState_Base*)this_00) AIState_Base(this->carObj_));

          (this_00)->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

          this_00->idleInPlaceFlag_ = 1;

          pAVar6 = this->state_;

          if (pAVar6 != (AIState_Base *)0x0) {

            (*(*pAVar6->_vf)[2].pfn)((int)&pAVar6->carObj_ + (*pAVar6->_vf)[2].delta,3);

          }

          this->state_ = (AIState_Base*)this_00;

          this->stateType_ = 3;

          if ((this->carObj_)->direction != 1) goto LAB_800664c4;

          iVar4 = iVar4 * 0x20 + (int)BWorldSm_slices;

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

            (*(*pAVar6->_vf)[2].pfn)((int)&pAVar6->carObj_ + (*pAVar6->_vf)[2].delta,3);

          }

          this->state_ = (AIState_Base*)this_00;

          this->stateType_ = 3;

          if ((this->carObj_)->direction == 1) {

            iVar4 = iVar4 * 0x20 + (int)BWorldSm_slices;

            local_20 = (u_int)*(u_char *)(iVar4 + 0x1f) << 0xf;

            uVar11 = *(u_char *)(iVar4 + 0x1d) & 0xf;

          }

          else {

LAB_800664c4:

            iVar4 = iVar4 * 0x20 + (int)BWorldSm_slices;

            local_20 = (u_int)*(u_char *)(iVar4 + 0x1e) << 0xf;

            uVar11 = (u_int)(*(u_char *)(iVar4 + 0x1d) >> 4);

          }

        }

        local_20 = local_20 * uVar11;

        (this_00)->SetIdlePosition(local_20);

        goto stateExecuteAndReturn;

      }

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

      }

      sVar7 = 1;

    }

    else {

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

      }

      sVar7 = 1;

    }

    break;

  case 3:

    iVar4 = AILife_EvaluateLife(this->carObj_);

    if (iVar4 == 0) {

      pAVar3 = this->CopCheck(&iStack_24);

      if ((pAVar3 != (AIHigh_Cop *)0x0) || (((this->carObj_)->carFlags & 0x400U) != 0)

         ) goto stateExecuteAndReturn;

LAB_80066684:

      pAVar9 = operator new(8);

      pAVar6 = (AIState_Base*)(new(pAVar9) AIState_Normal(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

      }

      sVar7 = 2;

    }

    else {

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

      }

      sVar7 = 1;

    }

    break;

  case 4:

  case 5:

  case 7:

  case 8:

  case 9:

  case 10:

  default:

    goto stateExecuteAndReturn;

  case 6:

    iVar4 = AILife_EvaluateLife(this->carObj_);

    if (iVar4 == 0) {

      if (this->forcePurgatory_ == 0) {

        pAVar6 = this->state_;

        pa_Var8 = pAVar6->_vf;

        iVar4 = (*(*pa_Var8)[3].pfn)((int)&pAVar6->carObj_ + (*pa_Var8)[3].delta);

        if (iVar4 == 0) goto stateExecuteAndReturn;

        goto LAB_80066684;

      }

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

      }

      sVar7 = 1;

    }

    else {

      pAVar5 = operator new(8);

      pAVar6 = (AIState_Base *) (new(pAVar5) AIState_Purgatory(this->carObj_));

      pAVar12 = this->state_;

      if (pAVar12 != (AIState_Base *)0x0) {

        (*(*pAVar12->_vf)[2].pfn)((int)&pAVar12->carObj_ + (*pAVar12->_vf)[2].delta,3);

      }

      sVar7 = 1;

    }

  }

  this->state_ = pAVar6;

  this->stateType_ = sVar7;

stateExecuteAndReturn:

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
  int chanceBase;
  int temp;
  int sliceLoop;
  int triggerHere;
  int iRandomChance;
  int randomValue;
  int loopOk;

  Car_tObj *pCVar1;

  trigger_t *ptVar2;

  u_int uVar3;

  int iStack_30;

  Car_tObj **local_2c;



  sortedLoop = Cars_gNumCars + -1;

  local_2c = Cars_gTotalSortedList + sortedLoop;

  do {

    if (sortedLoop < 0) {

      return (trigger_t *)0x0;

    }

    testCar = *local_2c;

    dir = -1;

    if ((testCar->carFlags & 0x204U) != 0) {

      thisPlayer = (AIHigh_Base *)highLevelAIObjs[testCar->carIndex];

      fRandomChance = 0x320000;

      if (-1 < testCar->currentSpeed) {

        dir = 1;

      }

      thisSlice = dir * 0x2d;

      if (thisSlice >= 0) {

        thisSlice = (testCar->N).simRoadInfo.slice + thisSlice;

        if (gNumSlices <= thisSlice) {

          thisSlice = thisSlice - gNumSlices;

        }

      }

      else {

        thisSlice = (testCar->N).simRoadInfo.slice + thisSlice;

        if (thisSlice < 0) {

          thisSlice = thisSlice + gNumSlices;

        }

      }

      temp = thisPlayer->lastTrafficTriggerCheckSlice_;

      thisPlayer->lastTrafficTriggerCheckSlice_ = thisSlice;

      if (temp < thisSlice) {

        startSlice = temp;

        endSlice = thisSlice;

      }

      else {

        startSlice = thisSlice;

        endSlice = temp;

      }

      sliceLoop = startSlice;

      loopOk = (endSlice - sliceLoop) < 0x32;

      chanceBase = fRandomChance * 0x19;

      while (sliceLoop < endSlice) {

        if (!loopOk) break;

        triggerHere = triggerManagerTraffic->CheckForTriggerAtSlice(testCar->carIndex, sliceLoop);

        if (triggerHere != -1) {

          iRandomChance = (chanceBase << 2) / 0x10000;

          randtemp = fastRandom * randSeed;

          fastRandom = randtemp & 0xffff;

          uVar3 = randtemp >> 8;

          randomValue = (uVar3 & 0xffff) * 0x19 >> 0xe;

          pCVar1 = AILife_IsSliceInAnyVisibleArea(sliceLoop);

          if ((pCVar1 == (Car_tObj *)0x0) && (randomValue < iRandomChance)) {

            ptVar2 = triggerManagerTraffic->GetTrigger(triggerHere, &iStack_30);

            return ptVar2;

          }

        }

        sliceLoop = sliceLoop + 1;

      }

    }

    sortedLoop = sortedLoop + -1;

    local_2c = local_2c + -1;

  } while( true );

}







/* end of aistate.cpp */

/* cont.35 B3b: base-forward dtor re-attributed from main.c (�3.23 simple variant);
   oracle = jal ___11AIHigh_Base; extern-C free fn exports the exact symbol. */
extern "C" {
void ___11AIHigh_Base(void *);
void ___14AIHigh_Traffic(void *thisp) { ___11AIHigh_Base(thisp); }
}
