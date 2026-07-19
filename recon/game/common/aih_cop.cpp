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

extern volatile int AI_elapsedTime;   /* H22: ai.cpp @0x8013C554 (not in this TU's externs).
                              volatile: defeats gcc's over-aggressive LICM hoist of
                              "randVal < perTickProb+AI_elapsedTime" fully out of the
                              CheckForWipeOut loop -- oracle recomputes it every iter
                              (permuter-discovered device, catalog EA-DMPSX family). */
extern int D_8011E0B0[];   /* == &simGlobal.gameTicks (distinct alias symbol the oracle addresses
                              directly for a gameTicks re-read the compiler can't CSE against the
                              nearby simGlobal.gameTicks store -- see aih_basiccop.cpp/aiphysic.cpp) */

/* ---- aistate.obj-owned globals (.bss zero) ---- */
/* @0x8005516c jtbl: gcc now emits its own jump table for HighExecute's switch (11 cases,
 * bodies laid out in oracle VA order 0,1,2,4,3,5,{6,7,8,10,default},9) — placeholder removed. */
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

          distanceMeters = AIWorld_ApxSplineDistance(Cars_gHumanRaceCarList[0],Cars_gHumanRaceCarList[1]);

          if (distanceMeters < 0) {

            distanceMeters = -distanceMeters;

          }

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

        switch (newTrigger.roadblock.type) {

        case 3:
          {
          u_int wrongWay;

          wrongWay = ~newTrigger.roadblock.dir;

          if (GameSetup_gData.reverseTrack == 0) {

            wrongWay = newTrigger.roadblock.dir ^ 1;

          }

          if ((wrongWay == 0) || (newTrigger.roadblock.dir == 0)) {

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

          break;

        case 1:
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

          break;

        }

      }

    }
    }

    goto stateExecuteAndReturn;
    }

  case 2:
    {
    blockadeMode_t mode;

    this->requestSpikeBeltAtSlice_ = -1;

    mode = this->blockade_.mode;

    if (mode != 1) {

      if (mode != 4) {

        (this->carObj_)->AIFlags = (this->carObj_)->AIFlags & 0xfffffffd;

      }

      {
      blockadeMode_t mode2;

      mode2 = this->blockade_.mode;

      if (((mode2 != 1) && (mode2 != 4)) && (this->CheckForNewTarget() != 0)) {

        coorddef pos;

        AIState_Chase *newState;

        AIState_Base *oldState;

        Car_tObj *carObj;

        Speaker *speaker;

        this->GetCheckChasePosition(&pos);

        newState = operator new(0x94);

        newState = (new(newState) AIState_Chase(this->carObj_,
                             (this->perpTarget_)->carObj_,&pos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[GameSetup_gData.skill]));

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

      if (chaseState->slowDownEndTime_ <= simGlobal.gameTicks) {

        needy = this->CheckForNeedyPlayers() != -1;

      }

      if (needy) {

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

        meters = chaseState->latMetersBetween_;

        if (meters < 0) {

          meters = -meters;

        }

        if (meters < minLatMetersDistance) {

          meters = chaseState->longMetersBetween_;

          if (meters < 0) {

            meters = -meters;

          }

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

      (this->carObj_)->AIFlags = (this->carObj_)->AIFlags | 2;

      {
        int requestSlice;

        requestSlice = this->requestSpikeBeltAtSlice_;

        release = 0;

        if ((requestSlice != -1) && (AICop_spikeBelt.active_ == 0)) {

          int size;

          int left;

          int rightLatPos;

          if (GameSetup_gData.skill == 0) {

            size = 0xb333;

          }

          else {

            size = 0xe666;

            if (GameSetup_gData.skill == 1) {

              size = 0xcccc;

            }

          }

          left = fixedmult((*(u_char *)(this->requestSpikeBeltAtSlice_ * 0x20 + (int)BWorldSm_slices + 0x1e) << 15) *
                             (*(u_char *)(this->requestSpikeBeltAtSlice_ * 0x20 + (int)BWorldSm_slices + 0x1d) >> 4),size);

          rightLatPos = fixedmult((*(u_char *)(this->requestSpikeBeltAtSlice_ * 0x20 + (int)BWorldSm_slices + 0x1f) << 15) *
                             (*(u_char *)(this->requestSpikeBeltAtSlice_ * 0x20 + (int)BWorldSm_slices + 0x1d) & 0xf),size);

          AICop_spikeBelt.leftLatPos_ = -left;

          AICop_spikeBelt.rightLatPos_ = rightLatPos;

          AICop_spikeBelt.slice_ = this->requestSpikeBeltAtSlice_;

          AICop_spikeBelt.active_ = 1;

          AICop_spikeBelt.freshenTime_ = D_8011E0B0[0];

          BWorld_SetSpikeBelt(this->requestSpikeBeltAtSlice_,-left,
                     left + rightLatPos);

          requestSlice = this->requestSpikeBeltAtSlice_;

        }

        AICop_gRoadBlockState = 1;

        if ((requestSlice != -1) && (AICop_spikeBelt.slice_ == requestSlice)) {

          AICop_spikeBelt.freshenTime_ = D_8011E0B0[0];

        }
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

LAB_80064d28:

          chaseInfo->engagementPercentIncreasePerTick_ = fixedmult(perTick,factor);

        }

        else {

          factor = 0xa8f5;

          if (GameSetup_gData.numLaps == 4) goto LAB_80064d28;

        }
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

          if (((0x471c7 < speed) &&

              (timeToRB = fixeddiv(rbDistanceMeters,((this->perpTarget_)->carObj_)
                                         ->currentSpeed), 0 < timeToRB)) &&

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

      this->requestSpikeBeltAtSlice_ = -1;

      if (this->blockade_.chaseLevel ==

          (this->perpTarget_->perpChaseInfo_).chaseLevelIndex_) {

        (this->perpTarget_->perpChaseInfo_).engagementTime_ = 0;

      }

      this->blockade_.mode = 0;

      {
        AIState_Chase *newState;

        AIState_Base *oldState;

        int reverse;

        newState = operator new(0x94);

        newState = (new(newState) AIState_Chase(this->carObj_,
                             (this->perpTarget_)->carObj_,&newPos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[GameSetup_gData.skill]));

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
                             (this->perpTarget_)->carObj_,&pos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[GameSetup_gData.skill]));

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
    Car_tObj **ppCar;

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

    ppCar = Cars_gRaceCarList;

    while (true) {

      if (Cars_gNumRaceCars <= hLoop) break;

      {
        Car_tObj *thisPlayerObj;

        thisPlayerObj = *ppCar;

        if (highLevelAIObjs[thisPlayerObj->carIndex][5].carObj_ != (Car_tObj *)0x0) {

          ((AIState_Offroad *)this->state_)->UnleashIfInRange(thisPlayerObj);

        }
      }

      ppCar = ppCar + 1;

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
  int needy;

  int hLoop;

  Car_tObj *thisPlayerObj;

  int iVar1;



  needy = -1;

  hLoop = 0;

  while (true) {

    if (Cars_gNumHumanRaceCars <= hLoop) break;

    thisPlayerObj = Cars_gHumanRaceCarList[hLoop];

    if (800 < (int)highLevelAIObjs[thisPlayerObj->carIndex][7].state_) {

      iVar1 = thisPlayerObj->currentSpeed;

      if (iVar1 < 0) {

        iVar1 = -iVar1;

      }

      if (0x140000 < iVar1) {

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

  if (!bVar1) {
    int hLoop;

    randtemp = fastRandom * randSeed;

    perTickProb = AI_elapsedTime * 88;

    thisTargetLevel = (this->perpTarget_->perpChaseInfo_).chaseLevelIndex_;

    randVal = (int)((randtemp >> 8) & 0xffff);

    fastRandom = randtemp & 0xffff;

    hLoop = 0;

    while (true) {

      if (Cars_gNumHumanRaceCars <= hLoop) break;

      Car_tObj *thisPlayerObj;

      AIHigh_Player *thisPlayer;

      thisPlayerObj = Cars_gHumanRaceCarList[hLoop];

      thisPlayer = (AIHigh_Player *)highLevelAIObjs[thisPlayerObj->carIndex];

      if (thisTargetLevel < (thisPlayer->perpChaseInfo_).chaseLevelIndex_) {

        if (randVal < perTickProb + AI_elapsedTime) {

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

  Sim_tSimGlobalVar *pSimGlobal;

  pSimGlobal = &simGlobal;

  if (0x5bf < pSimGlobal->gameTicks) {

    for (iVar12 = Cars_gNumCars - 1; -1 < iVar12; iVar12 = iVar12 - 1) {

      pCVar11 = Cars_gTotalSortedList[iVar12];

      if ((pCVar11->carFlags & 1U) != 0) {

        pAVar9 = highLevelAIObjs[pCVar11->carIndex];

        {
        int *perpInfo;

        int *pLevel;

        perpInfo = &pAVar9[4].lastTrafficTriggerCheckSlice_;

        pLevel = (int *)pAVar9[6].schedulingOff_;

        cVar1 = this->type_;

        iVar10 = perpInfo[2];

        iVar6 = cVar1 * 4;

        local_2c = perpInfo[cVar1];

        if (((AIHigh_Player *)pAVar9)->newTriggerProb_ == 0) {   /* @0x84: was mis-offset
                     as pAVar9[5].carObj_ (0x78=basicPerpInfo_.crime_) -- oracle loads 0x84
                     (AIHigh_Player::newTriggerProb_); pAVar9[5]-stride breaks past AIHigh_Base's
                     repeat region once into AIHigh_Player's own field extension. */

          iVar10 = iVar10 << 1;

          if (0 < *(int *)((int)pLevel + iVar6)) {

            iVar2 = AICop_NoCopsInArea((int)(pAVar9->carObj_->N).simRoadInfo.slice,0x1f40000);

            iVar6 = 1;

            if (iVar2 != 0) goto LAB_80065a54;

          }

          iVar6 = 0;

        }

        else {

          iVar6 = *(int *)((int)pLevel + iVar6);

        }
        }

LAB_80065a54:

        if (GameSetup_gData.skill == 2) {

          iVar10 = 0x10000;

        }

        if ((0x1bf < (int)(pSimGlobal->gameTicks - pAVar9[4].stateType_)) && (local_2c < iVar6)) {

          int dir;

          int thisSlice;

          int startSlice;

          int endSlice;

          int sliceLoop;

          dir = -1;

          if (-1 < pCVar11->currentSpeed) {

            dir = 1;

          }

          thisSlice = dir * 0x1f;

          if (-1 < thisSlice) {

            thisSlice = (pCVar11->N).simRoadInfo.slice + thisSlice;

            if (gNumSlices <= thisSlice) {

              thisSlice = thisSlice - gNumSlices;

            }

          }

          else {

            thisSlice = (pCVar11->N).simRoadInfo.slice + thisSlice;

            if (thisSlice < 0) {

              thisSlice = thisSlice + gNumSlices;

            }

          }

          {
            int temp;

            temp = pAVar9[5].lastTrafficTriggerCheckSlice_;

            pAVar9[5].lastTrafficTriggerCheckSlice_ = thisSlice;

            if (temp < thisSlice) {

              startSlice = temp;

              endSlice = thisSlice;

            }

            else {

              startSlice = thisSlice;

              endSlice = temp;

            }
          }

          sliceLoop = startSlice;

          while ((sliceLoop < endSlice) && (endSlice - startSlice < 6)) {

            int triggerHere;

            triggerHere = triggerManagerCops->CheckForTriggerAtSlice(pCVar11->carIndex, sliceLoop);

            if (triggerHere == -1) {

LAB_80065c28:

              sliceLoop = sliceLoop + 1;

            }

            else {

              int iRandomChance;

              u_int randomValue;

              iRandomChance = iVar10 * 100;

              if (iRandomChance < 0) {

                iRandomChance = iRandomChance + 0xffff;

              }

              randtemp = fastRandom * randSeed;

              fastRandom = randtemp & 0xffff;

              randomValue = randtemp >> 8;

              if (AILife_IsSliceInAnyVisibleArea(sliceLoop) != (Car_tObj *)0x0) goto LAB_80065c28;

              if ((local_2c != 0) ||

                 (sliceLoop = sliceLoop + 1, (int)((randomValue & 0xffff) * 0x19 >> 0xe) < iRandomChance >> 0x10)) {

                return triggerManagerCops->GetTrigger(triggerHere, &iStack_30);

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
