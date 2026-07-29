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

    cop = (AIHigh_Cop *)0x0;

    if (closest != (Car_tObj *)0x0) {

      /* The retail inline abs form is required to retain the SLD allocation:
       * closest in $a0 and speed in $a1. */
      speed = __builtin_abs(closest->currentSpeed);

      if ((speed < 0x20000) && (closestDistance < 0x4b0000)) {

        *blockade = 1;

        cop = (AIHigh_Cop *)highLevelAIObjs[closest->carIndex];

        if (((AIHigh_Cop *)highLevelAIObjs[closest->carIndex])->perpTarget_ == (AIHigh_Player *)0x0)

        {

          cop = (AIHigh_Cop *)0x0;

        }

      }

      else if ((0x20000 < speed) && (closestDistance < 0x4b0000)) {

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
  carObj_->unlap = 0;
  carObj_->lap = 0;

  switch ((stateType_t)stateType_) {
  case STATE_NONE:
    {
      coorddef trafficOffset = D_800551A4;

      if ((carObj_->carFlags & 0x400U) != 0) {
        AIState_Idle *idleState = operator new(0x10);
        new((AIState_Base *)idleState) AIState_Base(carObj_);
        idleState->_vf = (__vtbl_ptr_type (*)[4])AIState_Idle_vtable;
        idleState->idleInPlaceFlag_ = 1;
        SetState((AIState_Base *)idleState,STATE_IDLE);
      }
      else {
        AIState_Purgatory *purgatoryState = operator new(8);
        AIState_Base *newState =
          (AIState_Base *)new(purgatoryState) AIState_Purgatory(carObj_);
        SetState(newState,STATE_PURGATORY);
      }

      Newton_SetInitialSlicePositionOrientationEtc(&carObj_->N,0,&trafficOffset,1);
      return;
    }

  case STATE_PURGATORY:
    {
      if (accidentData_ != (SceneElem *)0x0) {
        BWorldSm_Pos spos;
        AIState_Idle *idleState = operator new(0x10);
        new((AIState_Base *)idleState) AIState_Base(carObj_);
        idleState->_vf = (__vtbl_ptr_type (*)[4])AIState_Idle_vtable;
        idleState->idleInPlaceFlag_ = 1;
        SetState((AIState_Base *)idleState,STATE_IDLE);

        spos.slice = 0;
        BWorldSm_FindClosestSlice(&accidentData_->cp,&spos);
        AILife_ReencarnateTrafficByPosition
          (carObj_,(int)spos.slice,1,&accidentData_->cp,&accidentData_->orient);
        carObj_->carFlags = carObj_->carFlags | 0x400U;
        accidentData_ = (SceneElem *)0x0;
      }
      else {
        int release = 0;
        if ((*(*state_->_vf)[3].pfn)
              ((int)&state_->carObj_ + (*state_->_vf)[3].delta) != 0) {
          release = forcePurgatory_ == 0;
        }
        if (release != 0) {
          trigger_t *trigger = CheckForNewTriggers();

          if (trigger != (trigger_t *)0x0) {
            triggerManagerTraffic->DescribeTrigger(trigger);
            if (*(int *)trigger == 5) {
              SetState(
                (AIState_Base *)new((AIState_RovingTraffic *)operator new(0x18))
                  AIState_RovingTraffic(carObj_,trigger),
                STATE_ROVING_TRAFFIC);
              AILife_ReencarnateTrafficByPosition
                (carObj_,*(int *)((char *)trigger + 4),1,
                 *(coorddef **)((char *)trigger + 0x3c),
                 (matrixtdef *)((char *)trigger + 0xc));
            }
          }
          else {
            AIState_Normal *normalState = operator new(8);
            AIState_Base *newState =
              (AIState_Base *)new(normalState) AIState_Normal(carObj_);
            SetState(newState,STATE_NORMAL);
            AILife_ReencarnateTraffic(carObj_);
          }
        }
      }
      break;
    }

  case STATE_NORMAL:
    {
      int blockade;

      if (AILife_EvaluateLife(carObj_) != 0) {
        AIState_Purgatory *purgatoryState = operator new(8);
        AIState_Base *newState =
          (AIState_Base *)new(purgatoryState) AIState_Purgatory(carObj_);
        SetState(newState,STATE_PURGATORY);
        break;
      }

      if (forcePurgatory_ != 0) {
        AIState_Purgatory *purgatoryState = operator new(8);
        AIState_Base *newState =
          (AIState_Base *)new(purgatoryState) AIState_Purgatory(carObj_);
        SetState(newState,STATE_PURGATORY);
        break;
      }

      if (CopCheck(&blockade) != (AIHigh_Cop *)0x0) {
        if (ignoreCops_ != 0) {
          break;
        }

        randtemp = fastRandom * randSeed;
        fastRandom = randtemp & 0xffff;
        int cRand = ((randtemp >> 8) & 0xffff) * 5 >> 0xf;

        if (blockade != 0) {
          AIState_Idle *idleState;
          int slice = (int)carObj_->N.simRoadInfo.slice;
          idleState = operator new(0x10);
          new((AIState_Base *)idleState) AIState_Base(carObj_);
          idleState->_vf = (__vtbl_ptr_type (*)[4])AIState_Idle_vtable;
          idleState->idleInPlaceFlag_ = 1;
          SetState((AIState_Base *)idleState,STATE_IDLE);

          (idleState = idleState)->SetIdlePosition(
            carObj_->direction == 1 ?
              ((u_int)BWorldSm_slices[slice].avgPavedWidthRt << 0xf) *
                (BWorldSm_slices[slice].laneCount & 0xf) :
              ((u_int)BWorldSm_slices[slice].avgPavedWidthLf << 0xf) *
                ((u_int)BWorldSm_slices[slice].laneCount >> 4));
        }
        else if (cRand <= 0) {
          AIState_Idle *idleState = operator new(0x10);
          new((AIState_Base *)idleState) AIState_Base(carObj_);
          idleState->_vf = (__vtbl_ptr_type (*)[4])AIState_Idle_vtable;
          idleState->idleInPlaceFlag_ = 1;
          SetState((AIState_Base *)idleState,STATE_IDLE);
        }
        else if (cRand < 8) {
          AIState_Idle *idleState;
          int slice = (int)carObj_->N.simRoadInfo.slice;
          idleState = operator new(0x10);
          new((AIState_Base *)idleState) AIState_Base(carObj_);
          idleState->_vf = (__vtbl_ptr_type (*)[4])AIState_Idle_vtable;
          idleState->idleInPlaceFlag_ = 1;
          SetState((AIState_Base *)idleState,STATE_IDLE);

          (idleState = idleState)->SetIdlePosition(
            carObj_->direction == 1 ?
              ((u_int)BWorldSm_slices[slice].avgPavedWidthRt << 0xf) *
                (BWorldSm_slices[slice].laneCount & 0xf) :
              ((u_int)BWorldSm_slices[slice].avgPavedWidthLf << 0xf) *
                ((u_int)BWorldSm_slices[slice].laneCount >> 4));
        }
        else {
          ignoreCops_ = 1;
        }
      }
      else {
        ignoreCops_ = 0;
      }
      break;
    }

  case STATE_IDLE:
    {
      int blockade;
      if (AILife_EvaluateLife(carObj_) != 0) {
        AIState_Purgatory *purgatoryState = operator new(8);
        AIState_Base *newState =
          (AIState_Base *)new(purgatoryState) AIState_Purgatory(carObj_);
        SetState(newState,STATE_PURGATORY);
      }
      else if ((CopCheck(&blockade) == (AIHigh_Cop *)0x0) &&
               ((carObj_->carFlags & 0x400U) == 0)) {
        AIState_Normal *normalState = operator new(8);
        AIState_Base *newState =
          (AIState_Base *)new(normalState) AIState_Normal(carObj_);
        SetState(newState,STATE_NORMAL);
      }
      break;
    }

  case STATE_ROVING_TRAFFIC:
    {
      if (AILife_EvaluateLife(carObj_) != 0) {
        AIState_Purgatory *purgatoryState = operator new(8);
        AIState_Base *newState =
          (AIState_Base *)new(purgatoryState) AIState_Purgatory(carObj_);
        SetState(newState,STATE_PURGATORY);
      }
      else if (forcePurgatory_ != 0) {
        AIState_Purgatory *purgatoryState = operator new(8);
        AIState_Base *newState =
          (AIState_Base *)new(purgatoryState) AIState_Purgatory(carObj_);
        SetState(newState,STATE_PURGATORY);
      }
      else if ((*(*state_->_vf)[3].pfn)
                 ((int)&state_->carObj_ + (*state_->_vf)[3].delta) != 0) {
        AIState_Normal *normalState = operator new(8);
        AIState_Base *newState =
          (AIState_Base *)new(normalState) AIState_Normal(carObj_);
        SetState(newState,STATE_NORMAL);
      }
      break;
    }

  case STATE_CHASE:
  case STATE_OFFROAD:
  case STATE_NONACTIVE:
  case STATE_DONUTS:
  case STATE_GOTOSLICE:
  case STATE_CRUISE:
  default:
    break;
  }

  state_->StateExecute();
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
  Car_tObj **sortedCar;

  sortedLoop = Cars_gNumCars - 1;
  sortedCar = Cars_gTotalSortedList + sortedLoop;

  while (sortedLoop >= 0) {
    Car_tObj *testCar = *sortedCar;

    if ((testCar->carFlags & 0x204U) != 0) {
      int dir = -1;
      AIHigh_Base *thisPlayer =
        (AIHigh_Base *)highLevelAIObjs[testCar->carIndex];
      int thisSlice;
      int startSlice;
      int endSlice;
      int fRandomChance = 0x320000;

      if (testCar->currentSpeed >= 0) {
        dir = 1;
      }

      thisSlice = dir * 0x2d;
      if (thisSlice >= 0) {
        thisSlice =
          testCar->N.simRoadInfo.slice + (thisSlice = thisSlice);
        if (thisSlice >= gNumSlices) {
          thisSlice -= gNumSlices;
        }
      }
      else {
        thisSlice =
          testCar->N.simRoadInfo.slice + (thisSlice = thisSlice);
        if (thisSlice < 0) {
          thisSlice += gNumSlices;
        }
      }

      {
        int temp = thisPlayer->lastTrafficTriggerCheckSlice_;
        thisPlayer->lastTrafficTriggerCheckSlice_ = thisSlice;
        if (temp < thisSlice) {
          startSlice = temp;
          endSlice = thisSlice;
        }
        else {
          startSlice = thisSlice;
          endSlice = temp;
        }
      }

      int sliceLoop = startSlice;
      while ((sliceLoop < endSlice) &&
             ((endSlice - startSlice) < 0x32)) {
        int triggerHere =
          triggerManagerTraffic->CheckForTriggerAtSlice
            (testCar->carIndex,sliceLoop);

        if (triggerHere != -1) {
          int iRandomChance = ((fRandomChance * 0x19) << 2) / 0x10000;
          randtemp = fastRandom * randSeed;
          fastRandom = randtemp & 0xffff;
          int randomValue = (((randtemp >> 8) & 0xffff) * 0x19) >> 0xe;

          if ((AILife_IsSliceInAnyVisibleArea(sliceLoop) ==
               (Car_tObj *)0x0) &&
              (randomValue < iRandomChance)) {
            int unused;
            return triggerManagerTraffic->GetTrigger(triggerHere,&unused);
          }
        }
        sliceLoop = sliceLoop + 1;
      }
    }

    sortedLoop = sortedLoop - 1;
    sortedCar = sortedCar - 1;
  }

  return (trigger_t *)0x0;

}







/* end of aistate.cpp */

/* cont.35 B3b: base-forward dtor re-attributed from main.c (�3.23 simple variant);
   oracle = jal ___11AIHigh_Base; extern-C free fn exports the exact symbol. */
extern "C" {
void ___11AIHigh_Base(void *);
void ___14AIHigh_Traffic(void *thisp) { ___11AIHigh_Base(thisp); }
}
