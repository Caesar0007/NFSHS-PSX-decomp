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

extern int AI_elapsedTime;   /* H22: ai.cpp @0x8013C554 (not in this TU's externs).
                              W57-A8: the `volatile` here was WRONG (it forced a re-LOAD of
                              AI_elapsedTime every CheckForWipeOut iteration = 4 spurious
                              insns). The oracle loads it ONCE into $a2 in the loop preheader
                              and computes `AI_elapsedTime * 89` inside the loop; gcc's LICM
                              hoists all but the LAST insn of the synth-multiply chain
                              (`addu $v1,$t1,$a2`), which is what the retail body shows. */
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

          distanceMeters = __builtin_abs(AIWorld_ApxSplineDistance(Cars_gHumanRaceCarList[0],Cars_gHumanRaceCarList[1]));

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

        /* W61-A12: retail is NOT a switch here -- the oracle's test order
           (beq==1 -> body1 | slti<2 -> out | beq==2 -> out | bne!=3 -> out |
           fall -> body3) is byte-for-byte gcc-2.8's lowering of THIS nested
           if-chain (scratchpad/w61a12/swlab.c V10, CC1PLPSX-verified).  A
           3-case switch cannot produce it: balance_case_nodes (stmt.c:6059-6095)
           splits any 3-node list at the MIDDLE (root=2) and use_cost_table is 0
           here because estimate_case_costs rejects control-character case values
           (cost_table[1..3] < 0, stmt.c:5957-5960).  An `&&` chain folds the two
           guards away (swlab V12) -- they must be NESTED ifs.  84 -> 80 diffs. */
        if (newTrigger.roadblock.type != 1) {
          if (newTrigger.roadblock.type > 1) {
            if (newTrigger.roadblock.type != 2) {
              if (newTrigger.roadblock.type == 3) {
          {
          u_int wrongWay;

          wrongWay = ~newTrigger.roadblock.dir;

          if (GameSetup_gData.reverseTrack == 0) {

            wrongWay = newTrigger.roadblock.dir ^ 1;

          }

          /* W61-A12 RESIDUAL ISLAND (5 of the fn's 61 diff insns).  Retail's SLD puts
             the reverseTrack select AND this test on ONE line (303) and emits
             `bnez G; nor(delay); xori; sltiu v0,v0,1; bnez v0 -> body` plus a RELOAD
             of roadblock.dir from the frame for the second operand; ours branches
             straight off the xori (`beqz`) and keeps dir in a register -- 2 insns
             shorter.  FALSIFIED spellings (standalone CC1PLPSX lab,
             scratchpad/w61a12/wlab*.c, all emit our `beq r,0` form): w == 0 / w <= 0
             / w < 1 / !w with w unsigned, the same with w signed, a materialized
             `int c = (w == 0)` temp, the if/else select instead of the
             default-then-override, and the ternary-inside-the-test one-liner.
             Only the BITWISE `|` form reproduces the sltiu -- but it materializes
             BOTH operands (no short circuit), which retail does not.  So the
             materialization comes from something structural on retail line 303 that
             the four natural spellings do not express. */
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

              }
            }
          }
        } else {
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

        /* W57-A8: arg2 via the inline GetCarObj() accessor (NOT the raw ->carObj_
           field): the accessor form makes gcc evaluate the perpTarget deref EARLY
           into its own scratch like retail, instead of parking perpTarget_ in $a2
           across the whole 9-arg setup and dereferencing in place. Same edit at all
           three AIState_Chase construction sites: 168 -> 84 diffs. */
        newState = (new(newState) AIState_Chase(this->carObj_,
                             this->perpTarget_->GetCarObj(),&pos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[(int)GameSetup_gData.skill]));

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

      if (simGlobal.gameTicks >= chaseState->slowDownEndTime_) {

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

        meters = __builtin_abs(chaseState->latMetersBetween_);

        if (meters < minLatMetersDistance) {

          meters = __builtin_abs(chaseState->longMetersBetween_);

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

        Car_tObj *carObj;

        int direction;

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
          Car_tObj *carObj;

          int direction;

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

          /* W61-A12: test INVERTED (was `skill == 0` first).  Retail puts the
             0xb333 arm in its own block AFTER the else arm and reaches it by the
             beqz, with the else arm ending `j <merge>; li s0,0xcccc` -- our
             then-first form let reorg sink `li s0,0xb333` into the beqz delay slot
             and fall through, 1 insn short.  Inverting the arms reproduces retail's
             block order exactly.  80 -> 77 diffs (fn is 84 -> 77 with the trigger
             if-chain above). */
          if (GameSetup_gData.skill != 0) {

            size = 0xe666;

            if (GameSetup_gData.skill == 1) {

              size = 0xcccc;

            }

          }

          else {

            size = 0xb333;

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

        if (stackSpeedUpEnbabledFlag != 0) {

          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 0;

          this->SetupBlockadeElements(&this->blockade_);

          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 1;

        }

        else {

          this->SetupBlockadeElements(&this->blockade_);

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

        }

        else if (GameSetup_gData.numLaps == 4) {

          factor = 0xa8f5;

        }

        else goto LAB_80064d34;

        chaseInfo->engagementPercentIncreasePerTick_ = fixedmult(perTick,factor);

LAB_80064d34:;
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

      if ((this->perpTarget_->perpChaseInfo_).chaseLevelIndex_ ==

          this->blockade_.chaseLevel) {

        (this->perpTarget_->perpChaseInfo_).engagementTime_ = 0;

      }

      this->blockade_.mode = 0;

      {
        AIState_Chase *newState;

        AIState_Base *oldState;

        int reverse;

        newState = operator new(0x94);

        newState = (new(newState) AIState_Chase(this->carObj_,
                             this->perpTarget_->GetCarObj(),&newPos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[(int)GameSetup_gData.skill]));

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
                             this->perpTarget_->GetCarObj(),&pos,
                             AIHigh_Cop_AggressionData[this->aggressionLevel_].nitrousTicks,
                             NitroDistanceMeters[this->type_][0],
                             NitroDistanceMeters[this->type_][1],
                             this->aggressionLevel_,AICop_skillDelay[(int)GameSetup_gData.skill]));

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

    while (true) {

      if (Cars_gNumRaceCars <= hLoop) break;

      {
        Car_tObj *thisPlayerObj;

        thisPlayerObj = Cars_gRaceCarList[hLoop];

        if (highLevelAIObjs[thisPlayerObj->carIndex][5].carObj_ != (Car_tObj *)0x0) {

          ((AIState_Offroad *)this->state_)->UnleashIfInRange(thisPlayerObj);

        }
      }

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

      /* W57-A8 08E: operand order is the load order -- `gameTicks >= wipeOutEndTick`
         (gameTicks FIRST) makes gcc schedule the D_8011E0B0 load into the load-delay
         gap after `lw carObj_`; the `wipeOutEndTick <= gameTicks` spelling emits a nop
         there instead and rotated the whole a0/a1 band. 25 -> PASS. */
      if (D_8011E0B0[0] >= (this->carObj_)->wipeOutEndTick) {

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
    /* W57-A8 05A: SLD statement map -- 861 = the RAND() statement, 865 = the whole `for`
       (its preheader owns every LICM-hoisted insn: the highLevelAIObjs/simGlobal base
       materializations, the AI_elapsedTime load, Cars_gNumHumanRaceCars, the perpTarget_
       re-read + thisTargetLevel load, and 5 of the 6 insns of `AI_elapsedTime * 89`),
       867/868 = the two list lookups, 877 = the paired guard (the multiply's LAST insn
       `addu $v1,$t1,$a2` lands in its delay slot), 879 = the store, 884 = the bump. */
    int hLoop;

    randtemp = fastRandom * randSeed;

    randVal = (int)((randtemp >> 8) & 0xffff);

    fastRandom = randtemp & 0xffff;

    thisTargetLevel = (this->perpTarget_->perpChaseInfo_).chaseLevelIndex_;

    hLoop = 0;

    while (true) {

      if (Cars_gNumHumanRaceCars <= hLoop) break;

      Car_tObj *thisPlayerObj;

      AIHigh_Player *thisPlayer;

      thisPlayerObj = Cars_gHumanRaceCarList[hLoop];

      thisPlayer = (AIHigh_Player *)highLevelAIObjs[thisPlayerObj->carIndex];

      perTickProb = AI_elapsedTime * 89;

      if (thisTargetLevel < (thisPlayer->perpChaseInfo_).chaseLevelIndex_) {

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








static inline copLevel_t *AIHigh_Player_ChaseLevel(AIHigh_Player *player)
{
  return *(copLevel_t * volatile *)&player->perpChaseInfo_.chaseLevel_;
}

static inline int AIHigh_Player_LastPullOverTime(AIHigh_Player *player)
{
  return player->lastPullOverTime_;
}

/* ---- CheckForNewTriggers__10AIHigh_Cop  AIHigh_Cop::CheckForNewTriggers  [AIH_COP.CPP:1021-1166] SLD-VERIFIED ---- */

trigger_t * AIHigh_Cop::CheckForNewTriggers()
{
  /* W57-A8 05A/06A rewrite: SYM 8c local set (sortedLoop=$30 testCar=$21 dir=$3
     thisPlayer=$16 needs=$4 got=AUTO-44 pLevel=$6 thisSlice=$3 startSlice=$4
     endSlice=$20 fRandomChance=$18 | newSlice=$3 temp=$5 sliceLoop=$17
     triggerHere=$19 iRandomChance=$18 randomValue=$16 unused=AUTO-48), statements
     in SLD order (1034/1041/1043/1044/1047/1060/1066/1069/1073/1084/1087/1093/
     1097/1100/1102/1115/1120/1122/1123/1138/1145/1152/1163/1165/1166).
     REAL BUG FIXED: fRandomChance is thisPlayer->newTriggerProb_ (+0x84) and the
     gate is basicPerpInfo_.crime_ (+0x78) -- the prior recon had the two SWAPPED
     (it doubled perpInfo[2] and gated on +0x84).
     2026-08-12 FORK/SLD RECEIPT: the SYM's nested AIHigh_Player scopes were
     real inline accessors.  Reconstructing the chase-level and last-pull-over
     accessors creates the retail a1->a2 copy and the later a3 simGlobal base.
     The decisive final lever is a paired volatile read on the chase-level
     pointer and cop type.  Either volatile read alone is score-neutral at 4
     diffs; together they give sched2 the retail load priority/order, preserve
     the a1->a2 copy in its retail slot, and produce byte-exact PASS (202/202).
     No empty-asm scheduling boundaries or register pins remain in this block.
     Authoritative progression: 29 -> 15 -> 9 -> 8 -> 2 -> PASS.  Falsified
     follow-ups: raw/pLevel identity 14, empty-loop boundary 5/10, accessor
     wrapper 16/19, pointer keepalive 8, and tied-output fences 7/51. */
  int sortedLoop;
  int numCars;
  Car_tObj *testCar;
  int initialGameTicks;
  Sim_tSimGlobalVar *pSimGlobalInitial = &simGlobal;   /* oracle materializes &simGlobal as a
                              value (lui/addiu + disp-4 load) at BOTH sites, not the
                              folded lui/%lo(simGlobal+4) a direct member access gives */
  initialGameTicks = pSimGlobalInitial->gameTicks;

  if (0x5bf < initialGameTicks) {
    __asm__("" : : "r"(pSimGlobalInitial));
    numCars = Cars_gNumCars;
    __asm__("" : : "r"(numCars));
    for (sortedLoop = numCars - 1; -1 < sortedLoop; sortedLoop = sortedLoop - 1) {
      testCar = Cars_gTotalSortedList[sortedLoop];
      if ((testCar->carFlags & 1U) != 0) {
        int dir;
        AIHigh_Player *thisPlayer;
        int needs;
        int got;
        copLevel_t *pLevel;
        int thisSlice;
        int startSlice;
        int endSlice;
        int fRandomChance;
        int crime;
        int rawType;
        int typeOffset;
        int *gotPtr;
        AICop_BasicPerpInfo *perpInfo;

        thisPlayer = (AIHigh_Player *)highLevelAIObjs[testCar->carIndex];
        perpInfo = &thisPlayer->basicPerpInfo_;
        pLevel = AIHigh_Player_ChaseLevel(thisPlayer);
        rawType = *(volatile int *)&this->type_;
        fRandomChance = thisPlayer->newTriggerProb_;
        typeOffset = rawType << 2;
        gotPtr = (int *)((char *)perpInfo->copsAssigned_ + typeOffset);
        crime = perpInfo->crime_;
        got = *gotPtr;
        if (crime == 0) {
          fRandomChance = fRandomChance * 2;
          if ((0 < *(int *)((char *)pLevel->copChasers + typeOffset)) &&
              (AICop_NoCopsInArea((int)(thisPlayer->GetCarObj()->N).simRoadInfo.slice, 0x1f40000) != 0)) {
            needs = 1;
          }
          else {
            needs = 0;
          }
        }
        else {
          needs = *(int *)((char *)pLevel->copChasers + typeOffset);
        }
        if (GameSetup_gData.skill == 2) {
          fRandomChance = 0x10000;
        }
        if (0x1bf < simGlobal.gameTicks -
                      AIHigh_Player_LastPullOverTime(thisPlayer)) {
          if (got < needs) {
            int newSlice;

            dir = -1;
            if (-1 < testCar->currentSpeed) {
              dir = 1;
            }
            thisSlice = dir * 0x1f;
            if (-1 < thisSlice) {
              newSlice = (testCar->N).simRoadInfo.slice + thisSlice;
              if (gNumSlices <= newSlice) {
                newSlice = newSlice - gNumSlices;
              }
            }
            else {
              newSlice = (testCar->N).simRoadInfo.slice + thisSlice;
              if (newSlice < 0) {
                newSlice = newSlice + gNumSlices;
              }
            }
            {
              int temp;

              temp = thisPlayer->lastTriggerCheckSlice_;
              thisPlayer->lastTriggerCheckSlice_ = newSlice;
              if (temp < newSlice) {
                startSlice = temp;
                endSlice = newSlice;
              }
              else {
                startSlice = newSlice;
                endSlice = temp;
              }
            }
            for (int sliceLoop = startSlice;
                 (sliceLoop < endSlice) && (endSlice - startSlice < 6);
                 sliceLoop++) {
              int triggerHere;

              triggerHere = triggerManagerCops->CheckForTriggerAtSlice(testCar->carIndex, sliceLoop);
              if (triggerHere != -1) {
                int iRandomChance;
                int randomValue;

                iRandomChance = (fRandomChance * 100) / 0x10000;
                randtemp = fastRandom * randSeed;
                fastRandom = randtemp & 0xffff;
                randomValue = (int)(((randtemp >> 8) & 0xffff) * 0x19 >> 0xe);
                if (AILife_IsSliceInAnyVisibleArea(sliceLoop) == (Car_tObj *)0x0) {
                  if ((got != 0) || (randomValue < iRandomChance)) {
                    int unused;

                    return triggerManagerCops->GetTrigger(triggerHere, &unused);
                  }
                }
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
