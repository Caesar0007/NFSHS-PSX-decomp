/* game/common/aistate.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Real non-polymorphic C++ inheritance (SS3.23/3.23c conversion, 2026-07-06 -- was
 *   composition-modeled); manual _vf vtable dispatch (8-byte __vtbl_ptr_type entries);
 *   deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aistate_externs.h"

/* ---- aistate.obj-owned globals (.bss zero) ---- */
int          AIState_Purgatory_numTrafficCarsInPurgatory;   /* @0x8013dd7c  (bss(zero)) */


/* ---- AIState_StartUp__Fv  AIState_StartUp  [AISTATE.CPP:25-26] SLD-VERIFIED ---- */

void AIState_StartUp(void)



{

  AIState_Purgatory::StartUp();

  return;

}








/* ---- AIState_Restart__Fv  AIState_Restart  [AISTATE.CPP:30-31] SLD-VERIFIED ---- */

void AIState_Restart(void)



{

  AIState_Purgatory::StartUp();

  return;

}








/* ---- AIState_CleanUp__Fv  AIState_CleanUp  [AISTATE.CPP:36-37] SLD-VERIFIED ---- */

void AIState_CleanUp(void)



{

  return;

}








/* ---- StateExecute__12AIState_Base  AIState_Base::StateExecute  [AISTATE.CPP:56-66] SLD-VERIFIED ---- */

void AIState_Base::StateExecute()



{

  Car_tObj *pCVar1;

  

  pCVar1 = this->carObj_;

  if ((((pCVar1->N).active != '\0') && ((pCVar1->carFlags & 4U) == 0)) &&

     ((pCVar1->N).deadTimer == 0)) {

    AIScript_ProcessActionsAndReactions(&pCVar1->script,AI_elapsedTime);

  }

  (*(*this->_vf)[1].pfn)((int)&this->carObj_ + (int)(*this->_vf)[1].delta);

  return;

}








/* ---- __12AIState_BaseP8Car_tObj  AIState_Base::ctor  [AISTATE.CPP:73-74] SLD-VERIFIED ---- */

AIState_Base::AIState_Base(Car_tObj *carObj)



{

  this->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  this->carObj_ = carObj;

  return;

}








/* ---- Execute__14AIState_Normal  AIState_Normal::Execute  [AISTATE.CPP:94-101] SLD-VERIFIED ---- */

void AIState_Normal::Execute()



{

  AISpeeds_CalcDesiredSpeed(this->carObj_);

  AI_GenericBeginCycle(this->carObj_);

  AI_GenericCycle(this->carObj_);

  AI_GenericEndCycle(this->carObj_);

  return;

}








/* ---- __14AIState_NormalP8Car_tObj  AIState_Normal::ctor  [AISTATE.CPP:105-110] SLD-VERIFIED ---- */

AIState_Normal::AIState_Normal(Car_tObj *carObj)
  : AIState_Base(carObj)
{

  Car_tObj *pCVar1;

  


  pCVar1 = this->carObj_;

  this->_vf = (__vtbl_ptr_type (*) [4])AIState_Normal_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  (this->carObj_)->targetLatPos = 0;

  ((this->carObj_)->N).active = '\x01';

  return;

}








/* ---- Execute__12AIState_Idle  AIState_Idle::Execute  [AISTATE.CPP:129-149] SLD-VERIFIED ---- */

void AIState_Idle::Execute()



{
  int off;

  int iVar1;

  Car_tObj *pCVar2;



  if (this->idleInPlaceFlag_ != 0) {

    (this->carObj_)->desiredSpeed = 0;

    (this->carObj_)->desiredLatPos = (this->carObj_)->roadPosition;

  }

  else {

    pCVar2 = this->carObj_;

    if ((pCVar2->roadPosition - this->roadPosition_) + 0xffffU < 0x1ffff) {

      pCVar2->desiredSpeed = 0;

    }

    else {

      AISpeeds_CalcDesiredSpeed(pCVar2);

      iVar1 = (this->carObj_)->desiredSpeed;

      if (iVar1 < 0) {

        iVar1 = iVar1 + 3;

      }

      (this->carObj_)->desiredSpeed = iVar1 >> 2;

    }

    (this->carObj_)->desiredLatPos = this->roadPosition_;

  }

  return;

}








/* ---- SetIdlePosition__12AIState_Idlei  AIState_Idle::SetIdlePosition  [AISTATE.CPP:154-156] SLD-VERIFIED ---- */

void AIState_Idle::SetIdlePosition(int roadPosition)



{

  this->roadPosition_ = roadPosition;

  this->idleInPlaceFlag_ = 0;

  return;

}








/* ---- __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii  AIState_Chase::ctor  [AISTATE.CPP:180-201] SLD-VERIFIED ---- */
/* WALL (register-coloring near-miss, insn count now EXACT 66/66; was 8 SHORT before the
   reverseDirCheck fix below): two independent saved-reg swaps remain vs the oracle --
   (carObj<->delayTime) and (relPosition<->nitrousTicks) -- both are short/long-lived params
   that gcc-2.x's global allocator ties differently than the oracle build; every statement
   placement/caching variant tried leaves the same two swaps. Pure §A coloring floor,
   documented near-miss. */

/* D_8011321C == GameSetup_gData.reverseTrack -- standalone-symbol form, same precedent as
 * ai.cpp AI_HandleTrafficHonking / aiinit.cpp AIInit_RestartAICar / hud.cpp Hud_NextPlayer. */
extern int D_8011321C;

AIState_Chase::AIState_Chase(Car_tObj *carObj,Car_tObj *targetCar,coorddef *relPosition,

          int nitrousTicks,int nitrousMinForeDistance,int nitrousMinAftDistance,int aggressionLevel,

          int delayTime)
  : AIState_Base(carObj)
{

  int reverseDirCheck;

  this->_vf = (__vtbl_ptr_type (*) [4])AIState_Chase_vtable;

  /* MATCH: delayCar_ constructed via placement-new IN THE BODY (after the _vf store) --
     the oracle schedules the _vf store into the AIDelayCar ctor's arg setup, which is
     only reachable when the member ctor call FOLLOWS the store (init-list form calls it
     before any body stmt). AIDelayCar() default ctor is empty inline -> no extra code. */

  new ((AIDelayCar *)&this->delayCar_) AIDelayCar(carObj,targetCar,delayTime);

  this->nitrousTicks_ = nitrousTicks;

  this->SetTarget(targetCar,relPosition);

  (this->carObj_)->accNitrous = 0x10000;

  (this->carObj_)->speedNitrous = 0x10000;

  this->nitrousMinForeDistance_ = nitrousMinForeDistance;

  this->nitrousMinAftDistance_ = nitrousMinAftDistance;

  this->aggressionLevel_ = aggressionLevel;

  this->slowDownEndTime_ = 0;

  /* tail-merged identical arms (catalog SSD): oracle computes the honk-check idiom (exact same
     shape as AI_HandleTrafficHonking, recon/game/common/ai.cpp:1208-1211) purely as a branch
     CONDITION whose two arms both reset noTurnAroundEndTime_ to 0 -- gcc2.8's cross-jump pass
     merges the byte-identical arm bodies into ONE shared store, but the branch test (and the
     nor/xori computing it) survives because branch removal is a separate optimization gcc
     doesn't perform here. */
  reverseDirCheck = ~(this->carObj_)->direction;

  if (D_8011321C == 0) {

    reverseDirCheck = (this->carObj_)->direction ^ 1;

  }

  if (reverseDirCheck) {

    this->noTurnAroundEndTime_ = 0;

  } else {

    this->noTurnAroundEndTime_ = 0;

  }

  this->barrierTicks32_ = 0;

  return;

}








/* ---- _._13AIState_Chase  AIState_Chase::dtor  [AISTATE.CPP:205-212] SLD-VERIFIED ---- */
/* reconstructed as extern "C" ___13AIState_Chase(AIState_Chase*,int) free fn (SaveSurface/
   ObjectFinishedSignAnim pattern): the oracle is a REAL per-class deleting dtor (__in_chrg +
   andi&1 + __builtin_delete), not a base-forward; a real C++ member dtor for this non-
   polymorphic single-inheritance shape always compiles to gcc's default simple base-forward
   (proven empirically), so the ABI-shape is hand-written. */

extern "C" void ___13AIState_Chase(AIState_Chase *pThis,int __in_chrg)



{

  Car_tObj *pCVar1;




  pCVar1 = pThis->carObj_;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Chase_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  (pThis->carObj_)->targetLatPos = 0;

  (pThis->carObj_)->preferredLateralPosition = 0;

  (pThis->carObj_)->preferredLateralPositionPower = 0;

  (pThis->carObj_)->accNitrous = 0x10000;

  (pThis->carObj_)->speedNitrous = 0x10000;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- SetTarget__13AIState_ChaseP8Car_tObjP8coorddef  AIState_Chase::SetTarget  [AISTATE.CPP:216-237] SLD-VERIFIED ---- */

void AIState_Chase::SetTarget(Car_tObj *targetCar,coorddef *relPosition)



{

  int iVar1;

  int iVar3;



  if (this->targetCar_ != targetCar) {

    (&this->delayCar_)->SetNewTargetCar(targetCar)

    ;

  }

  this->targetCar_ = targetCar;

  this->relPosition_ = *relPosition;

  this->longTargetRegion_ = 0;

  this->latTargetRegion_ = 0;

  iVar1 = ((*(Car_tObj *volatile *)&this->targetCar_)->N).dimension.x;

  iVar3 = *(volatile int *)&(this->relPosition_).x;

  if (iVar3 < -iVar1) {

    this->latTargetRegion_ = -1;

  }

  else if (iVar1 < iVar3) {

    this->latTargetRegion_ = 1;

  }

  iVar1 = ((*(Car_tObj *volatile *)&this->targetCar_)->N).dimension.z;

  iVar3 = *(volatile int *)&(this->relPosition_).z;

  if (iVar3 < -iVar1) {

    this->longTargetRegion_ = -1;

  }

  else if (iVar1 < iVar3) {

    this->longTargetRegion_ = 1;

  }

  this->murderMode_ = 0;

  this->murderEndTime_ = 0;

  this->inTargetRegion_ = 0;

  this->SetUp();

  return;

}








/* ---- SetMurderMode__13AIState_Chaseii  AIState_Chase::SetMurderMode  [AISTATE.CPP:240-249] SLD-VERIFIED ---- */

void AIState_Chase::SetMurderMode(int murderMode,int murderTicks)



{

  if (this->murderMode_ == 0) {

    this->murderMode_ = murderMode;

    this->murderEndTime_ = simGlobal.gameTicks + murderTicks;

  }

  return;

}








/* ---- SetUp__13AIState_Chase  AIState_Chase::SetUp  [AISTATE.CPP:252-282] SLD-VERIFIED ---- */

void AIState_Chase::SetUp()



{
  coorddef targetCarPosition;

  Car_tObj *pCVar1;

  Car_tObj *pCVar2;

  int iVar2;

  AIDelayCar *dc;



  /* MATCH (w13-a5): &delayCar_ held in a SAVED reg across the Update() call (lever #16),
     then SELECTIVE caching -- currentSpeed_/roadPosition_/slice_ read via dc (s1), but the
     position_ struct copy reads via this (s0 + 40) exactly as the oracle does. */

  dc = &this->delayCar_;

  dc->Update();

  iVar2 = -1;

  if (-1 < (this->carObj_)->currentSpeed) {

    iVar2 = 1;

  }

  this->carDir_ = iVar2;

  iVar2 = -1;

  if (-1 < dc->currentSpeed_) {

    iVar2 = 1;

  }

  this->targetDir_ = iVar2;

  this->latMetersBetween_ = (this->carObj_)->roadPosition - dc->roadPosition_;

  targetCarPosition = (this->delayCar_).position_;

  iVar2 = AIWorld_SplineDistance(this->carObj_,dc->slice_,&targetCarPosition);

  pCVar2 = this->carObj_;

  this->longMetersBetween_ = iVar2;

  (pCVar2->targetPos).z = 0;

  (pCVar2->targetPos).y = 0;

  (pCVar2->targetPos).x = 0;

  (this->carObj_)->targetLatPos = 0;

  if ((this->murderMode_ != 0) && (!(simGlobal.gameTicks < this->murderEndTime_))) {

    this->murderMode_ = 0;

    this->murderEndTime_ = 0;

  }

  if ((this->carObj_)->accNitrous != 0x10000) {

    this->nitrousTicks_ = this->nitrousTicks_ - AI_elapsedTime;

  }

  (this->carObj_)->accNitrous = 0x10000;

  (this->carObj_)->speedNitrous = 0x10000;

  (this->carObj_)->preferredLateralPosition = 0;

  (this->carObj_)->preferredLateralPositionPower = 0;

  return;

}








/* ---- DoSlowNitrous__13AIState_Chase  AIState_Chase::DoSlowNitrous  [AISTATE.CPP:287-292] SLD-VERIFIED ---- */

void AIState_Chase::DoSlowNitrous()



{

  (this->carObj_)->accNitrous = 0x8000;

  (this->carObj_)->speedNitrous = 0xc000;

  return;

}








/* ---- DoNitrous__13AIState_Chasei  AIState_Chase::DoNitrous  [AISTATE.CPP:296-318] SLD-VERIFIED ---- */

void AIState_Chase::DoNitrous(int checkForHumans)



{
  int humanLoop;
  int distanceMeters;

  Car_tObj *pCVar2;



  if ((0 < this->nitrousTicks_) && (simGlobal.gameTicks >= this->slowDownEndTime_)) {

    (this->carObj_)->accNitrous = 0x30000;

    (this->carObj_)->speedNitrous = 0x28000;

    humanLoop = 0;

    while (true) {

      if (checkForHumans == 0) {

        break;

      }

      if (Cars_gNumHumanRaceCars <= humanLoop) {

        break;

      }

      distanceMeters = AIWorld_ApxSplineDistance(this->carObj_,Cars_gHumanRaceCarList[humanLoop]);

      pCVar2 = this->carObj_;

      distanceMeters = distanceMeters * pCVar2->direction;

      if ((0 < distanceMeters) && (distanceMeters < this->nitrousMinForeDistance_)) {

        pCVar2->accNitrous = 0x10000;

        (this->carObj_)->speedNitrous = 0x10000;

      }

      if ((distanceMeters < 0) && (-this->nitrousMinAftDistance_ < distanceMeters)) {

        (this->carObj_)->accNitrous = 0x10000;

        (this->carObj_)->speedNitrous = 0x10000;

      }

      humanLoop = humanLoop + 1;

    }

  }

  return;

}








/* ---- Execute__13AIState_Chase  AIState_Chase::Execute  [AISTATE.CPP:327-401] SLD-VERIFIED ---- */

void AIState_Chase::Execute()



{
  int far;
  int velocityToHitInTime;
  int deltaVelocity;
  int targetCarVerySlow;

  int iVar3;

  

  this->SetUp();

  velocityToHitInTime = fixedmult(this->longMetersBetween_,0x666);

  deltaVelocity = this->carObj_->currentSpeed;

  iVar3 = this->targetCar_->currentSpeed;

  velocityToHitInTime = __builtin_abs(velocityToHitInTime);

  deltaVelocity = deltaVelocity - iVar3;

  deltaVelocity = __builtin_abs(deltaVelocity);

  far = 0;

  if (deltaVelocity < velocityToHitInTime) {

    int lmAbs;

    lmAbs = this->longMetersBetween_;

    lmAbs = __builtin_abs(lmAbs);

    far = 0x8c0000 < lmAbs;

  }

  iVar3 = __builtin_abs(iVar3);

  targetCarVerySlow = !(0x6aaa9 < iVar3);

  if (far != 0) goto LAB_80070244;

  if ((this->carDir_ * this->targetDir_ == 1) && (targetCarVerySlow == 0)) {

    this->CloseTargeting();

    goto LAB_800702a0;

  }

  if ((-1 < this->carDir_ * this->longMetersBetween_) && (targetCarVerySlow == 0)) {

LAB_80070244:

    this->FarTargeting();

    goto LAB_800702a0;

  }

  /* NOTE: the far re-test is provably false on this path (far!=0 branched to FarTargeting
     above) but the ORACLE EMITS IT (bnez a2 @+0x104) -- original source re-tested it. */

  if (0x1aaaaa < deltaVelocity) goto LAB_8007028C;

  if (far != 0) goto LAB_80070290;

  if (!(0x500000 < __builtin_abs(this->longMetersBetween_))) {

    deltaVelocity = 1;

    goto LAB_80070294;

  }

LAB_8007028C:;

LAB_80070290:

  deltaVelocity = 0;

LAB_80070294:

  this->ApproachTargeting(deltaVelocity);

LAB_800702a0:

  if (simGlobal.gameTicks < this->slowDownEndTime_) {

    this->DoSlowNitrous();

  }

  return;

}








/* ---- FarTargeting__13AIState_Chase  AIState_Chase::FarTargeting  [AISTATE.CPP:414-437] SLD-VERIFIED ---- */

void AIState_Chase::FarTargeting()



{

  this->inTargetRegion_ = 0;

  if (simGlobal.gameTicks > this->noTurnAroundEndTime_) {

    if (0 < this->longMetersBetween_) {

      (this->carObj_)->desiredDirection = -1;

    }

    else {

      (this->carObj_)->desiredDirection = 1;

    }

  }

  this->DoNitrous(1);

  AISpeeds_CalcDesiredSpeed(this->carObj_);

  AI_GenericBeginCycle(this->carObj_);

  this->CheckForBarriersAndTargetAroundThem();

  AI_GenericCycle(this->carObj_);

  AI_GenericEndCycle(this->carObj_);

  return;

}








/* ---- CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase  AIState_Chase::CalculateCloseTargettingAheadSlowDownFactor  [AISTATE.CPP:443-457] SLD-VERIFIED ---- */

int AIState_Chase::CalculateCloseTargettingAheadSlowDownFactor()



{
  int slowDown;
  int absLongMetersBetween;



  absLongMetersBetween = __builtin_abs(this->longMetersBetween_);

  slowDown = 0x9999;

  if (absLongMetersBetween < 0x1e0000) {

    slowDown = 0xf333;

  }

  else if (absLongMetersBetween < 0x320000) {

    slowDown = 0xcccc;

  }

  else if (absLongMetersBetween < 0x640000) {

    slowDown = 0xcccc;

  }

  else if (absLongMetersBetween < 0x960000) {

    slowDown = 0xc000;

  }

  else if (absLongMetersBetween < 0xc80000) {

    slowDown = 0xb333;

  }

  return slowDown;

}








/* ---- CloseTargeting__13AIState_Chase  AIState_Chase::CloseTargeting  [AISTATE.CPP:462-632] SLD-VERIFIED ---- */

void AIState_Chase::CloseTargeting()



{
  int latPos;
  int longPos;
  int bigLongPos;
  int forceLatAction;
  int doLatAction;
  int forceLongAction;
  int dir;
  int desiredSpeed;
  int latTarget;
  int longTarget;
  int superSlowDown;
  int targettingStrength;
  int targetLanePosition;

  bool bVar1;

  Car_tObj *pCVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int iVar7;

  int iVar8;

  int iVar9;

  int iVar10;

  

  iVar7 = 0;

  iVar8 = 0;

  iVar10 = (this->carObj_)->direction;

  this->DoNitrous(1);

  iVar4 = 0;

  if (this->murderMode_ != 0) {

    iVar5 = 0;

    iVar6 = 0;

    this->DoNitrous(0);

  }

  else {

    iVar6 = this->latTargetRegion_;

    iVar5 = this->longTargetRegion_;

  }

  iVar9 = this->latMetersBetween_ * iVar10;

  iVar3 = (this->targetCar_->N).dimension.x;

  if (iVar9 < -iVar3) {

    iVar7 = -1;

  }

  else if (iVar3 < iVar9) {

    iVar7 = 1;

  }

  iVar9 = this->longMetersBetween_ * iVar10;

  iVar3 = (this->targetCar_->N).dimension.z;

  if (iVar9 < 0x20000 - iVar3) {

    iVar8 = -1;

  }

  else if (iVar3 + 0x20000 < iVar9) {

    iVar8 = 1;

  }

  iVar9 = this->longMetersBetween_ * iVar10;

  iVar3 = (this->targetCar_->N).dimension.z + 0x20000;

  if (iVar9 < -iVar3) {

    iVar4 = -1;

  }

  else if (iVar3 < iVar9) {

    iVar4 = 1;

  }

  if ((iVar7 == iVar6) && (iVar8 == iVar5)) {

    this->inTargetRegion_ = this->inTargetRegion_ + AI_elapsedTime;

  }

  else {

    this->inTargetRegion_ = 0;

  }

  iVar3 = 0;

  iVar9 = 0;

  bVar1 = true;

  if (iVar4 * iVar5 == -1) {

    iVar9 = iVar6;

    if (iVar6 == 0) {

      iVar9 = -1;

    }

  }

  else if ((iVar7 * iVar6 == -1) && (iVar4 == 0)) {

    iVar3 = -1;

    bVar1 = false;

  }

  else if ((iVar6 == 0) && ((iVar4 == 0 && (this->murderMode_ == 0)))) {

    bVar1 = false;

  }

  else if ((iVar5 == 1) && (((iVar4 == 1 && (iVar7 == 0)) && (this->longMetersBetween_ < 0x140000)))

          ) {

    iVar3 = -2;

  }

  iVar4 = (this->delayCar_).currentSpeed_;

  if (iVar4 < 1) {

    iVar4 = -iVar4;

  }

  if ((iVar8 < iVar5) || (iVar3 == 1)) {

    iVar7 = 0x16666;

  }

  else if (((iVar5 < iVar8) || (iVar3 == -1)) ||

          ((0x140000 < this->longMetersBetween_ &&

           (((0x9ffff < this->longMetersBetween_ || (iVar7 != 0)) || (iVar6 == 0)))))) {

    iVar7 = this->CalculateCloseTargettingAheadSlowDownFactor();

  }

  else {

    if (iVar3 != -2) goto LAB_80070704;

    if (this->aggressionLevel_ == 0) {

      iVar7 = 0xca3d;

    }

    else {

      iVar7 = 0xa666;

      if (this->aggressionLevel_ == 1) {

        iVar7 = 0xbae1;

      }

    }

  }

  iVar4 = fixedmult(iVar4,iVar7);

LAB_80070704:

  AISpeeds_CalcDesiredSpeed(this->carObj_);

  pCVar2 = this->carObj_;

  iVar7 = pCVar2->desiredSpeed;

  if (iVar7 < 0) {

    iVar7 = -iVar7;

  }

  pCVar2->desiredSpeed = iVar7;

  pCVar2 = this->carObj_;

  iVar7 = pCVar2->desiredSpeed;

  if (iVar4 < iVar7) {

    iVar7 = iVar4;

  }

  iVar4 = 0x50000;

  if (0x4ffff < iVar7) {

    iVar4 = iVar7;

  }

  pCVar2->desiredSpeed = iVar4 * iVar10;

  AI_GenericBeginCycle(this->carObj_);

  if (bVar1) {

    iVar4 = 0xf0000;

    if (this->murderMode_ == 0) {

      if (iVar9 == 0) {

        iVar7 = (this->relPosition_).x;

      }

      else {

        iVar7 = (this->targetCar_->N).dimension.x + 0x60000;

      }

      iVar8 = (this->delayCar_).roadPosition_ + iVar7 * iVar10;

      iVar10 = ((this->carObj_)->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices;

      iVar7 = -((u_int)*(u_char *)(iVar10 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar10 + 0x1d) >> 4));

      if (iVar7 < iVar8) {

        iVar7 = iVar8;

      }

      iVar8 = (u_int)*(u_char *)(iVar10 + 0x1f) * 0x8000 * (*(u_char *)(iVar10 + 0x1d) & 0xf);

      if (iVar7 < iVar8) {

        iVar8 = iVar7;

      }

    }

    else {

      iVar4 = 0x1e0000;

      iVar8 = (this->delayCar_).roadPosition_;

    }

    (this->carObj_)->preferredLateralPosition = iVar8;

    (this->carObj_)->preferredLateralPositionPower = iVar4;

  }

  this->CheckForBarriersAndTargetAroundThem();

  AI_GenericCycle(this->carObj_);

  AI_GenericEndCycle(this->carObj_);

  return;

}








/* ---- ApproachTargeting__13AIState_Chasei  AIState_Chase::ApproachTargeting  [AISTATE.CPP:637-713] SLD-VERIFIED ---- */

void AIState_Chase::ApproachTargeting(int intercept)



{
  int xDistance;
  int zDistance;
  int distance;
  int minSpeed;

  int clamped;

  int speed;

  bool bVar1;

  int iVar2;

  Car_tObj *pCVar3;

  Car_tObj *pCVar4;

  int iVar5;

  int iVar6;

  

  xDistance = (this->carObj_->N).position.x - (this->targetCar_->N).position.x;

  xDistance = __builtin_abs(xDistance);

  zDistance = (this->carObj_->N).position.z - (this->targetCar_->N).position.z;

  zDistance = __builtin_abs(zDistance);

  if (zDistance < xDistance) {

    distance = xDistance + (zDistance >> 2);

  }

  else {

    distance = zDistance + (xDistance >> 2);

  }

  this->inTargetRegion_ = 0;

  iVar5 = simGlobal.gameTicks;

  if (this->noTurnAroundEndTime_ < iVar5) {

    if (0 < this->longMetersBetween_) {

      (this->carObj_)->desiredDirection = -1;

    }

    else {

      (this->carObj_)->desiredDirection = 1;

    }

  }

  AISpeeds_CalcDesiredSpeed(this->carObj_);

  /* MATCH (w13-a5): flat descending guard-chains, per-arm minSpeed assignment + goto ADC
     (assignments land in the bnez delay slots); block order = oracle VA order
     (C0 @.L9B8, C1 @.LA10, shared 0x60000 tail @.LA60, C2 @.LA78). */

  iVar5 = this->aggressionLevel_;

  if (iVar5 == 1) goto LAB_CHAIN1;

  if (!(iVar5 < 2)) goto LAB_GE2;

  if (iVar5 == 0) goto LAB_CHAIN0;

  minSpeed = 0x190000;

  goto LAB_80070adc;

LAB_GE2:

  if (iVar5 == 2) goto LAB_CHAIN2;

  minSpeed = 0x190000;

  goto LAB_80070adc;

LAB_CHAIN0:

  if (0x960000 < distance) { minSpeed = 0x3c0000; goto LAB_80070adc; }

  if (0x640000 < distance) { minSpeed = 0x320000; goto LAB_80070adc; }

  if (0x320000 < distance) { minSpeed = 0x280000; goto LAB_80070adc; }

  if (0x190000 < distance) { minSpeed = 0x230000; goto LAB_80070adc; }

  if (!(0xa0000 < distance)) goto LAB_A60;

  minSpeed = 0x140000;

  goto LAB_80070adc;

LAB_CHAIN1:

  if (0x960000 < distance) { minSpeed = 0x3c0000; goto LAB_80070adc; }

  if (0x640000 < distance) { minSpeed = 0x320000; goto LAB_80070adc; }

  if (0x320000 < distance) { minSpeed = 0x280000; goto LAB_80070adc; }

  if (0x190000 < distance) { minSpeed = 0x230000; goto LAB_80070adc; }

  if (0xa0000 < distance) { minSpeed = 0xa0000; goto LAB_80070adc; }

LAB_A60:

  minSpeed = 0;

  if (!(0x60000 < distance)) goto LAB_80070adc;

  minSpeed = 0x30000;

  goto LAB_80070adc;

LAB_CHAIN2:

  if (0x960000 < distance) { minSpeed = 0x500000; goto LAB_80070adc; }

  if (0x640000 < distance) { minSpeed = 0x460000; goto LAB_80070adc; }

  if (0x320000 < distance) { minSpeed = 0x320000; goto LAB_80070adc; }

  if (0x190000 < distance) { minSpeed = 0x280000; goto LAB_80070adc; }

  if (0xa0000 < distance) { minSpeed = 0xe0000; goto LAB_80070adc; }

  minSpeed = 0;

  if (!(0x60000 < distance)) goto LAB_80070adc;

  minSpeed = 0x60000;

LAB_80070adc:

  pCVar4 = this->carObj_;

  clamped = -minSpeed;

  if (pCVar4->direction == 1) {

    speed = pCVar4->desiredSpeed;

    clamped = minSpeed;

    if (speed < clamped) {

      clamped = speed;

    }

  }

  else {

    speed = pCVar4->desiredSpeed;

    if (clamped < speed) {

      clamped = speed;

    }

  }

  pCVar4->desiredSpeed = clamped;

  AI_GenericBeginCycle(this->carObj_);

  this->CheckForBarriersAndTargetAroundThem();

  AI_GenericCycle(this->carObj_);

  AI_GenericEndCycle(this->carObj_);

  if (intercept != 0) {

    (this->carObj_)->targetPos = (this->targetCar_->N).position;

    (this->carObj_)->targetLatPos = this->targetCar_->roadPosition;

    (this->carObj_)->preferredLateralPosition = this->targetCar_->roadPosition;

    (this->carObj_)->preferredLateralPositionPower = 0xf0000;

  }

  return;

}








/* ---- CheckForBarriersAndTargetAroundThem__13AIState_Chase  AIState_Chase::CheckForBarriersAndTargetAroundThem  [AISTATE.CPP:718-761] SLD-VERIFIED ---- */

void AIState_Chase::CheckForBarriersAndTargetAroundThem()



{
  int mySlice;
  int targetSlice;
  int barrierBesideTarget;
  int barrierBesideMe;
  int myLane;
  int targetLane;

  int lm;

  u_char bVar1;

  u_char bVar2;

  Car_tObj *pCVar3;

  

  lm = this->longMetersBetween_;

  lm = __builtin_abs(lm);

  if (0x1f40000 < lm) return;

  pCVar3 = this->carObj_;

  mySlice = (pCVar3->N).simRoadInfo.slice;

  myLane = pCVar3->laneIndex;

  bVar1 = *(u_char *)(mySlice * 0x20 + (int)BWorldSm_slices + 0x1d);

  targetSlice = (this->targetCar_->N).simRoadInfo.slice;

  targetLane = this->targetCar_->laneIndex;

  if (myLane < 6 - (bVar1 >> 4)) return;

  if ((bVar1 & 0xf) + 7 < myLane) return;

  bVar2 = *(u_char *)(targetSlice * 0x20 + (int)BWorldSm_slices + 0x1d);

  if (targetLane < 6 - (bVar2 >> 4)) return;

  if ((bVar2 & 0xf) + 7 < targetLane) return;

  barrierBesideTarget = AIWorld_CheckForBarrierBetweenLanes(targetSlice,targetLane,myLane);

  barrierBesideMe = AIWorld_CheckForBarrierBetweenLanes(mySlice,targetLane,myLane);

  if (barrierBesideTarget == 0) goto LAB_TICKS0;

  if (barrierBesideMe != 0) goto LAB_ELAPSED;

  this->barrierTicks32_ = 0;

  AI_TargetLane(this->carObj_,targetLane);

  AI_TargetLane(this->carObj_,targetLane);

  AI_TargetLane(this->carObj_,targetLane);

  return;

LAB_ELAPSED:

  /* CORRECTNESS (w13-a5): oracle's middle arm is barrierTicks32_ += AI_elapsedTime
     (@.L80070CD8) -- recon previously had a self-assignment placeholder. */

  this->barrierTicks32_ = this->barrierTicks32_ + AI_elapsedTime;

  return;

LAB_TICKS0:

  this->barrierTicks32_ = 0;

  return;

}








/* ---- FindBarrierEndSlice__13AIState_Chase  AIState_Chase::FindBarrierEndSlice  [AISTATE.CPP:764-866] SLD-VERIFIED ---- */

int AIState_Chase::FindBarrierEndSlice()



{
  int mySlice;
  int myLane;
  int targetLane;
  int leftLane;
  int rightLane;
  int barrierLane;
  int currentBarrierLane;
  int forwardBarrierEndSlice;
  int forwardBarrierDistance;
  int backwardsBarrierEndSlice;
  int backwardsBarrierDistance;
  int sliceLoop;
  int sliceCheck;
  int temp;
  int leftBarrier;
  int hereBarrier;
  int rightBarrier;

  u_char bVar1;

  u_int uVar2;

  Car_tObj *pCVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int iVar7;

  int slice;

  int iVar8;

  int iVar9;

  int iVar10;

  int slice_00;

  int local_30;

  int local_2c;

  

  pCVar3 = this->carObj_;

  iVar7 = pCVar3->laneIndex;

  iVar5 = this->targetCar_->laneIndex;

  slice_00 = (int)(pCVar3->N).simRoadInfo.slice;

  iVar4 = iVar7;

  if (iVar5 < iVar7) {

    iVar4 = iVar5;

    iVar5 = iVar7;

  }

  while ((iVar4 < iVar5 &&

         (iVar7 = AIWorld_CheckForBarrierBetweenLanes(slice_00,iVar4,iVar4), iVar7 == 0))) {

    iVar4 = iVar4 + 1;

  }

  iVar5 = slice_00 + 0x53;

  local_2c = 0x53;

  local_30 = 0x53;

  if (gNumSlices <= iVar5) {

    iVar5 = iVar5 - gNumSlices;

  }

  iVar7 = slice_00 + -0x53;

  if (iVar7 < 0) {

    iVar7 = iVar7 + gNumSlices;

  }

  iVar8 = iVar4;

  for (iVar10 = 0; slice = iVar5, iVar9 = local_30, iVar10 < 0x53; iVar10 = iVar10 + 4) {

    slice = slice_00 + iVar10;

    if (iVar10 < 0) {

      iVar9 = gNumSlices;

      if (slice < 0) goto LAB_80070e34;

    }

    else if (gNumSlices <= slice) {

      iVar9 = -gNumSlices;

LAB_80070e34:

      slice = slice + iVar9;

    }

    iVar9 = iVar8 + -1;

    uVar2 = AIWorld_CheckForBarrierBetweenLanes(slice,iVar8 + 1,iVar9);

    iVar6 = iVar8;

    if (((uVar2 & 2) == 0) &&

       ((((uVar2 & 4) == 0 ||

         (bVar1 = *(u_char *)(slice * 0x20 + (int)BWorldSm_slices + 0x1d),

         iVar9 < (int)(6 - (u_int)(bVar1 >> 4)))) ||

        (iVar6 = iVar9, (int)((bVar1 & 0xf) + 7) < iVar9)))) {

      iVar9 = iVar10;

      if ((uVar2 & 1) == 0) break;

      bVar1 = *(u_char *)(slice * 0x20 + (int)BWorldSm_slices + 0x1d);

      iVar6 = iVar8 + 1;

      if ((iVar6 < (int)(6 - (u_int)(bVar1 >> 4))) || ((int)((bVar1 & 0xf) + 7) < iVar6)) break;

    }

    iVar8 = iVar6;

  }

  local_30 = iVar9;

  for (iVar5 = 0; iVar8 = iVar7, iVar10 = local_2c, iVar5 < 0x53; iVar5 = iVar5 + 4) {

    iVar8 = slice_00 - iVar5;

    if (-iVar5 < 0) {

      iVar10 = gNumSlices;

      if (iVar8 < 0) goto LAB_80070f54;

    }

    else if (gNumSlices <= iVar8) {

      iVar10 = -gNumSlices;

LAB_80070f54:

      iVar8 = iVar8 + iVar10;

    }

    iVar10 = iVar4 + -1;

    uVar2 = AIWorld_CheckForBarrierBetweenLanes(iVar8,iVar4 + 1,iVar10);

    iVar9 = iVar4;

    if (((uVar2 & 2) == 0) &&

       ((((uVar2 & 4) == 0 ||

         (bVar1 = *(u_char *)(iVar8 * 0x20 + (int)BWorldSm_slices + 0x1d),

         iVar10 < (int)(6 - (u_int)(bVar1 >> 4)))) ||

        (iVar9 = iVar10, (int)((bVar1 & 0xf) + 7) < iVar10)))) {

      iVar10 = iVar5;

      if ((uVar2 & 1) == 0) break;

      bVar1 = *(u_char *)(iVar8 * 0x20 + (int)BWorldSm_slices + 0x1d);

      iVar9 = iVar4 + 1;

      if ((iVar9 < (int)(6 - (u_int)(bVar1 >> 4))) || ((int)((bVar1 & 0xf) + 7) < iVar9)) break;

    }

    iVar4 = iVar9;

  }

  local_2c = iVar10;

  iVar4 = slice + 6;

  if (local_30 < local_2c) {

    if (gNumSlices <= iVar4) {

      iVar4 = slice - (gNumSlices + -6);

    }

  }

  else {

    iVar4 = iVar8 + -6;

    if (iVar4 < 0) {

      iVar4 = iVar8 + gNumSlices + -6;

    }

  }

  return iVar4;

}








/* ---- _._15AIState_Offroad  AIState_Offroad::dtor  [AISTATE.CPP:887-891] SLD-VERIFIED ---- */
/* reconstructed as extern "C" ___15AIState_Offroad(AIState_Offroad*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle).
   MATCH: the carFlags RMW must go through a FRESH local (pCVar2), not reuse pCVar1 --
   the 3 carObj_ re-reads are 3 DISTINCT pseudos in the original; reusing pCVar1 merged
   webs and kept pThis in a0 (oracle: carObj web takes a0, pThis copied to a2). 25->0. */

extern "C" void ___15AIState_Offroad(AIState_Offroad *pThis,int __in_chrg)



{

  Car_tObj *pCVar1;

  Car_tObj *pCVar2;



  pCVar1 = pThis->carObj_;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Offroad_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  (pThis->carObj_)->targetLatPos = 0;

  pCVar2 = pThis->carObj_;

  pCVar2->carFlags = pCVar2->carFlags & 0xfffff7ff;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- __15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii  AIState_Offroad::ctor  [AISTATE.CPP:896-920] SLD-VERIFIED ---- */

AIState_Offroad::AIState_Offroad(Car_tObj *carObj,int startSlice,coorddef *position,

          matrixtdef *orientation,int maxSpeedKPH,int releaseTime,int endSlice)
  : AIState_Base(carObj)
{

  Car_tObj *pCVar3;



  this->_vf = (__vtbl_ptr_type (*) [4])AIState_Offroad_vtable;

  this->letGo_ = 0;

  this->startSlice_ = startSlice;

  /* MATCH (w13-a5): plain struct assignments -- gcc movstrsi expands the 36-byte matrix
     copy as the oracle's 4-word/iter loop + 1-word tail + end-ptr compare, and the
     12-byte coorddef copies as grouped lw t0-t2 / sw triples (load-3/store-3). */

  this->startPosition_ = *position;

  this->startOrientation_ = *orientation;

  this->startHeading_ = *(coorddef *)((this->startOrientation_).m + 6);

  this->maxSpeedMPS_ = maxSpeedKPH * 0x4700;

  this->releaseTime_ = releaseTime;

  this->targetSlice_ = endSlice;

  this->targetPosition_ = *(coorddef *)((char *)BWorldSm_slices + endSlice * 0x20);

  pCVar3 = this->carObj_;

  pCVar3->carFlags = pCVar3->carFlags | 0x800;

  return;

}








/* ---- UnleashIfInRange__15AIState_OffroadP8Car_tObj  AIState_Offroad::UnleashIfInRange  [AISTATE.CPP:926-936] SLD-VERIFIED ---- */

void AIState_Offroad::UnleashIfInRange(Car_tObj *car)



{
  int distanceAbsMeters;
  int releaseDistanceMeters;

  int iVar2;

  

  iVar2 = AIWorld_SplineDistance(this->carObj_,car);

  distanceAbsMeters = __builtin_abs(iVar2);

  releaseDistanceMeters = fixedmult((car->N).speedXZ,this->releaseTime_);

  {
    int cmp;

    cmp = 0x140000;

    if (releaseDistanceMeters < cmp) {

      cmp = 0x140000;

      if (distanceAbsMeters < cmp) {

        this->letGo_ = 1;

      }

    }

    else {

      if (distanceAbsMeters < releaseDistanceMeters) {

        this->letGo_ = 1;

      }

    }
  }

  return;

}








/* ---- Execute__15AIState_Offroad  AIState_Offroad::Execute  [AISTATE.CPP:944-978] SLD-VERIFIED ---- */

void AIState_Offroad::Execute()



{
  coorddef zero;

  Car_tObj *pCVar1;

  Car_tObj *pCVar2;

  Car_tObj *pCVar3;

  int iVar4;

  

  if (this->letGo_ == 0) {

    memset((u_char *)&zero,'\0',0xc);

    (this->carObj_->N).linearVel = zero;

    (this->carObj_->N).angularVel = zero;

    (this->carObj_)->desiredSpeed = 0;

    (this->carObj_->N).position = this->startPosition_;

    (this->carObj_->N).orientMat = this->startOrientation_;

    pCVar3 = this->carObj_;

    (pCVar3->targetPos).z = 0;

    (pCVar3->targetPos).y = 0;

    (pCVar3->targetPos).x = 0;

  }

  else {

    iVar4 = AIWorld_ApxSplineDistance(this->carObj_,this->targetSlice_);

    pCVar1 = this->carObj_;

    this->longMetersBetween_ = iVar4;

    pCVar1->desiredSpeed = this->maxSpeedMPS_;

    if (0 < this->longMetersBetween_) {

      (this->carObj_)->desiredDirection = -1;

      pCVar2 = this->carObj_;

      pCVar2->desiredSpeed = -pCVar2->desiredSpeed;

    }

    else {

      (this->carObj_)->desiredDirection = 1;

    }

    AI_GenericBeginCycle(this->carObj_);

    AI_GenericCycle(this->carObj_);

    AI_GenericEndCycle(this->carObj_);

    (this->carObj_)->targetPos = this->targetPosition_;

  }

  (this->carObj_)->targetLatPos = 0;

  return;

}








/* ---- __17AIState_PurgatoryP8Car_tObj  AIState_Purgatory::ctor  [AISTATE.CPP:1001-1017] SLD-VERIFIED ---- */

AIState_Purgatory::AIState_Purgatory(Car_tObj *carObj)
  : AIState_NonActive(carObj)


{
  coorddef trafficOffset;
  int lifeTimer;

  u_int uVar1;

  bool bVar2;

  int iVar3;

  Car_tObj *pCVar4;

  Car_tObj *pCVar5;



  memset((u_char *)&trafficOffset,'\0',0xc);

  trafficOffset.y = carObj->carIndex * 0xa0000;

  Newton_SetInitialSlicePositionOrientationEtc(&(this->carObj_)->N,0,&trafficOffset,1);

  ((this->carObj_)->N).active = '\0';

  this->_vf = (__vtbl_ptr_type (*) [4])AIState_Purgatory_vtable;

  uVar1 = fastRandom * randSeed;

  /* CORRECTNESS (w13-a5): oracle stores the VALUE of Cars_gList (= Cars_gList[0], the head
     car) into basisCar -- recon previously stored NULL. lw %lo(Cars_gList) in the oracle. */

  (this->carObj_)->basisCar = Cars_gList[0];

  bVar2 = false;

  randtemp = uVar1;

  lifeTimer = AITune_LifeTimer[Cars_gNumTrafficCars];

  (this->carObj_)->physicsModelTimer =

       (lifeTimer * (uVar1 >> 8 & 0xffff) >> 0x10) + 1;

  fastRandom = uVar1 & 0xffff;

  iVar3 = strcmp((this->carObj_)->carName,"SBUS");

  if ((iVar3 == 0) ||

     (iVar3 = strcmp((this->carObj_)->carName,"TBUS"),

     iVar3 == 0)) {

    bVar2 = true;

  }

  if (bVar2) {

    pCVar4 = this->carObj_;

    pCVar4->physicsModelTimer = pCVar4->physicsModelTimer * 5;

  }

  pCVar5 = this->carObj_;

  pCVar5->AIFlags = pCVar5->AIFlags | 4;

  if (((this->carObj_)->carFlags & 0x10U) != 0) {

    AIState_Purgatory_numTrafficCarsInPurgatory = AIState_Purgatory_numTrafficCarsInPurgatory + 1;

  }

  return;

}








/* ---- _._17AIState_Purgatory  AIState_Purgatory::dtor  [AISTATE.CPP:1021-1041] SLD-VERIFIED ---- */
/* reconstructed as extern "C" ___17AIState_Purgatory(AIState_Purgatory*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle); __in_chrg
   is now a real usable param (was previously unreachable/removed from a true member dtor).
   WALL (register-coloring near-miss, 79 diffs 69/72 insns) -- same root symptom as the
   AIState_Offroad dtor (see its WALL comment): oracle copies pThis a0->a3 up front (this
   fn's bigger body needs a3 not a2, one more caller-saved reg already in play), ours keeps
   pThis in a0. Same gcc-2.x allocator coin-flip; documented near-miss. */

extern "C" void ___17AIState_Purgatory(AIState_Purgatory *pThis,int __in_chrg)



{
  int search;
  Car_tObj*test;

  Car_tObj *pCVar1;

  Car_tObj *pCVar2;

  Car_tObj *pCVar4;

  Car_tObj *pCVar6;

  int iVar2;


  Car_tObj **ppCVar3;



  pCVar1 = pThis->carObj_;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Purgatory_vtable;

  (pCVar1->collision).resetTimer = 0;

  ((pThis->carObj_)->N).collision.disableCollisionTimer = 0;

  pCVar2 = pThis->carObj_;

  pCVar2->AIFlags = pCVar2->AIFlags & 0xfffffffb;

  if (((pThis->carObj_)->carFlags & 0x10U) != 0) {

    AIState_Purgatory_numTrafficCarsInPurgatory = AIState_Purgatory_numTrafficCarsInPurgatory + -1;

  }

  iVar2 = Cars_gNumCars + -1;

  ppCVar3 = Cars_gSortedList + iVar2;

  pCVar4 = pThis->carObj_;

  pCVar4->direction = 1;

  pCVar4->desiredDirection = 1;

LOOP_800716DC:

  if (-1 < iVar2) {

    test = *ppCVar3;

    ppCVar3 = ppCVar3 + -1;

    if ((test->carFlags & 0x100U) == 0) {

      iVar2 = iVar2 + -1;

      goto LOOP_800716DC;

    }

    (pThis->carObj_)->basisCar = test;

  }

  pCVar6 = pThis->carObj_;

  pThis->_vf =

       (__vtbl_ptr_type (*) [4])((char *)AIState_NonActive_vtable + 8);

  (pCVar6->N).active = '\x01';

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- TestForRelease__17AIState_Purgatory  AIState_Purgatory::TestForRelease  [AISTATE.CPP:1048-1063] SLD-VERIFIED ---- */

int AIState_Purgatory::TestForRelease()



{
  Car_tObj *pCVar2;

  int trafficInWorld;

  int iVar1;

  int *limitp;



  pCVar2 = this->carObj_;

  if (pCVar2->physicsModelTimer < 1) {

    iVar1 = GameSetup_gData.trafficDensity * 4;

    trafficInWorld = Cars_gNumTrafficCars - AIState_Purgatory_numTrafficCarsInPurgatory;

    limitp = (int *)((int)AITune_MaxTraffic + iVar1);

    if (GameSetup_gData.commMode == 1) {

      iVar1 = iVar1 + 0x10;

      limitp = (int *)((int)AITune_MaxTraffic + iVar1);

    }

    if (trafficInWorld < *limitp) {

      return 1;

    }

    pCVar2->physicsModelTimer = 1;

  }

  return 0;

}








/* ---- Execute__17AIState_Purgatory  AIState_Purgatory::Execute  [AISTATE.CPP:1068-1087] SLD-VERIFIED ---- */

void AIState_Purgatory::Execute()



{

  Car_tObj *pCVar1;

  

  ((this->carObj_)->collision).resetTimer = 0;

  ((this->carObj_)->N).collision.disableCollisionTimer = 0;

  pCVar1 = this->carObj_;

  if (((pCVar1->carFlags & 0x20U) == 0) && (0x3bf < simGlobal.gameTicks)) {

    pCVar1->physicsModelTimer = pCVar1->physicsModelTimer - AI_elapsedTime;

  }

  return;

}








/* ---- StartUp__17AIState_Purgatory  AIState_Purgatory::StartUp  [AISTATE.CPP:1090-1091] SLD-VERIFIED ---- */

void AIState_Purgatory::StartUp(void)



{

  AIState_Purgatory_numTrafficCarsInPurgatory = 0;

  return;

}








/* ---- __21AIState_RovingTrafficP8Car_tObjP9trigger_t  AIState_RovingTraffic::ctor  [AISTATE.CPP:1103-1109] SLD-VERIFIED ---- */

AIState_RovingTraffic::AIState_RovingTraffic(Car_tObj *carObj,trigger_t *trigger)
  : AIState_Base(carObj)
{

  int iVar1;

  Car_tObj *pCVar2;

  


  this->_vf = (__vtbl_ptr_type (*) [4])AIState_RovingTraffic_vtable;

  pCVar2 = this->carObj_;

  this->path_ = *(trigger_pathPosition_t **)((char *)trigger + 0x3c);

  iVar1 = *(int *)((char *)trigger + 0x38);

  this->pathIndex_ = 0;

  this->waitTick_ = 0;

  this->numPathPoints_ = iVar1;

  pCVar2->carFlags = pCVar2->carFlags | 0x800;

  return;

}








/* ---- CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi  AIState_RovingTraffic::CheckIfCarIsNearbyAndStop  [AISTATE.CPP:1130-1169] SLD-VERIFIED ---- */

void AIState_RovingTraffic::CheckIfCarIsNearbyAndStop(Car_tObj *otherCarObj,int &status_r)



{
  int *status = &status_r;   /* R-ref param; alias keeps the pointer-form body codegen-identical */
  int distance;
  coorddef posDiff;

  int iVar1;

  int iVar2;

  int iVar5;

  int sum;

  Car_tObj *carObj;

  

  carObj = this->carObj_;

  if (carObj == otherCarObj) goto LAB_STATUS2;

  if ((otherCarObj->N).active == '\0') goto LAB_STATUS2;

  distance = AIWorld_SplineDistance(carObj,otherCarObj);

  if (0 < distance) {

    distance = AIWorld_SplineDistance(this->carObj_,otherCarObj);

  }

  else {

    distance = -AIWorld_SplineDistance(this->carObj_,otherCarObj);

  }

  if (0xc0000 < distance) goto LAB_STATUS0;

  iVar5 = otherCarObj->roadPosition;

  iVar2 = (this->carObj_)->roadPosition;

  iVar1 = iVar2 - iVar5;

  if (0 < iVar1) {

    if (0x9ffff < iVar1) {

      *status = 2;

      return;

    }

  }

  else {

    if (0x9ffff < iVar5 - iVar2) goto LAB_STATUS2;

  }

  posDiff.x = (otherCarObj->N).position.x - ((this->carObj_)->N).position.x;

  posDiff.y = (otherCarObj->N).position.y - ((this->carObj_)->N).position.y;

  posDiff.z = (otherCarObj->N).position.z - ((this->carObj_)->N).position.z;

  sum = fixedmult(((this->carObj_)->N).orientMat.m[6],posDiff.x) +

        fixedmult(((this->carObj_)->N).orientMat.m[7],posDiff.y) +

        fixedmult(((this->carObj_)->N).orientMat.m[8],posDiff.z);

  /* CORRECTNESS (w13-a5): oracle stores *status = 0 on the sum<=0 path (blez -> sw zero)
     -- recon previously left *status unwritten there. */

  if (sum <= 0) goto LAB_STATUS0;

  AudioClc_HonkHorn(this->carObj_,4,0x10,8);

  (this->carObj_)->desiredSpeed = 0;

  *status = 1;

  return;

LAB_STATUS2:

  *status = 2;

  return;

LAB_STATUS0:

  *status = 0;

  return;

}








/* ---- Execute__21AIState_RovingTraffic  AIState_RovingTraffic::Execute  [AISTATE.CPP:1172-1224] SLD-VERIFIED ---- */

void AIState_RovingTraffic::Execute()
{
  int search;
  int status;
  coorddef centerBack;
  coorddef carRelativeForLatPos;
  coorddef carRelativeForDistance;

  trigger_pathPosition_t *ptVar1;

  Car_tObj *pCVar4;

  int iVar3;

  int iVar5;

  int iVar6;

  int iVar7;

  int iVar8;

  int iVar9;

  Car_tObj **ppCVar10;

  /* pCVar2 rule: this->carObj_ is re-read fresh at nearly every use in the oracle
     (13 separate reloads of *(int*)this over the function) rather than cached once --
     each block below re-derives pCVar4 to reproduce that liveness shape. */

  ptVar1 = this->path_ + this->pathIndex_;

  pCVar4 = this->carObj_;

  /* load-3/store-3 grouped temps (catalog §A row 38/§54): oracle batches the 3 loads through
     t0/t1/t2 THEN the 3 stores, not per-field load+store -- avoids a load-delay nop per field. */

  iVar5 = (ptVar1->position).x;

  iVar6 = (ptVar1->position).y;

  iVar7 = (ptVar1->position).z;

  (pCVar4->targetPos).x = iVar5;

  (pCVar4->targetPos).y = iVar6;

  (pCVar4->targetPos).z = iVar7;

  (this->carObj_)->desiredSpeed = this->path_[this->pathIndex_].targetSpeed * 0x7247;

  iVar3 = (int)BWorldSm_slices + ((this->carObj_)->N).simRoadInfo.slice * 0x20;

  iVar5 = ((Trk_NewSlice *)iVar3)->center[0];

  iVar6 = ((Trk_NewSlice *)iVar3)->center[1];

  iVar7 = ((Trk_NewSlice *)iVar3)->center[2];

  centerBack.x = iVar5;

  centerBack.y = iVar6;

  centerBack.z = iVar7;

  pCVar4 = this->carObj_;

  carRelativeForLatPos.x = (pCVar4->targetPos).x - centerBack.x;

  pCVar4 = this->carObj_;

  carRelativeForLatPos.y = (pCVar4->targetPos).y - centerBack.y;

  pCVar4 = this->carObj_;

  carRelativeForLatPos.z = (pCVar4->targetPos).z - centerBack.z;

  pCVar4 = this->carObj_;

  /* gcc-2.x signed /256 idiom (bgez;addiu 0xFF;sra 8) -- write the plain division,
     not a hand-rolled if(x<0)x+=0xff;x>>=8 -- reference_mips_isa_asm.md MULT/DIV section.
     Statement order matches the oracle's interleave: div-pair, mult, div-pair, mult, ... */

  iVar5 = (pCVar4->N).roadMatrix.m[0] / 256;

  iVar8 = carRelativeForLatPos.x / 256;

  iVar6 = (pCVar4->N).roadMatrix.m[1] / 256;

  iVar3 = iVar5 * iVar8;

  iVar9 = carRelativeForLatPos.y / 256;

  iVar7 = (pCVar4->N).roadMatrix.m[2] / 256;

  iVar3 = iVar3 + iVar6 * iVar9;

  iVar8 = carRelativeForLatPos.z / 256;

  iVar3 = iVar3 + iVar7 * iVar8;

  pCVar4->targetLatPos = iVar3;

  pCVar4 = this->carObj_;

  carRelativeForDistance.x = (pCVar4->targetPos).x - (pCVar4->N).position.x;

  iVar9 = carRelativeForDistance.x >> 0xc;

  pCVar4 = this->carObj_;

  carRelativeForDistance.y = (pCVar4->targetPos).y - (pCVar4->N).position.y;

  pCVar4 = this->carObj_;

  carRelativeForDistance.z = (pCVar4->targetPos).z - (pCVar4->N).position.z;

  iVar8 = carRelativeForDistance.z >> 0xc;

  if (iVar9 * iVar9 + iVar8 * iVar8 < 10000) {

    if (this->waitTick_ == 0) {

      this->waitTick_ = simGlobal.gameTicks + this->path_[this->pathIndex_].waitTime;

    }

    if (simGlobal.gameTicks < this->waitTick_) {

      (this->carObj_)->desiredSpeed = 0;

    }

    else {

      this->waitTick_ = 0;

      this->pathIndex_ = this->pathIndex_ + 1;

    }

  }

  status = 2;

  search = (this->carObj_)->sortIndex + 1;

  ppCVar10 = Cars_gSortedList + search;

  while ((search < Cars_gNumCars && (status == 2))) {

    pCVar4 = *ppCVar10;

    ppCVar10 = ppCVar10 + 1;

    search = search + 1;

    this->CheckIfCarIsNearbyAndStop(pCVar4,status);

  }

  if (status != 1) {

    status = 2;

    search = (this->carObj_)->sortIndex + -1;

    ppCVar10 = Cars_gSortedList + search;

    while ((-1 < search && (status == 2))) {

      pCVar4 = *ppCVar10;

      ppCVar10 = ppCVar10 + -1;

      search = search + -1;

      this->CheckIfCarIsNearbyAndStop(pCVar4,status);

    }

  }

  return;

}








/* ---- _._14AIState_Donuts  AIState_Donuts::dtor  [AISTATE.CPP:1248-1253] SLD-VERIFIED ---- */
/* reconstructed as extern "C" ___14AIState_Donuts(AIState_Donuts*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle). */

extern "C" void ___14AIState_Donuts(AIState_Donuts *pThis,int __in_chrg)



{

  Car_tObj *pCVar1;



  pCVar1 = pThis->carObj_;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Donuts_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  (pThis->carObj_)->targetLatPos = 0;

  (pThis->carObj_)->donutMode = 0;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- Execute__14AIState_Donuts  AIState_Donuts::Execute  [AISTATE.CPP:1256-1334] SLD-VERIFIED ---- */

void AIState_Donuts::Execute()



{
  coorddef right;
  coorddef forward;
  coorddef targetPos;
  int latPos;
  int slice;
  int forwardDot;
  int forwardSlice;
  int dCarToCenter;

  int iVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  int *piVar5;

  Car_tObj *pCVar6;

  int iVar7;

  int iVar8;

  int iVar9;

  Car_tObj *pCVar10;

  int iVar11;

  u_int uVar12;



  pCVar10 = this->carObj_;

  iVar11 = (int)(pCVar10->N).simRoadInfo.slice;

  /* gcc-2.x signed /256 idiom -- plain division, not a hand-rolled correction+shift
     (reference_mips_isa_asm.md; catalog §C). */

  iVar7 = (pCVar10->N).orientMat.m[6] / 256;

  iVar1 = (pCVar10->N).roadMatrix.m[6] / 256;

  iVar8 = (pCVar10->N).orientMat.m[7] / 256;

  iVar2 = (pCVar10->N).roadMatrix.m[7] / 256;

  iVar9 = (pCVar10->N).orientMat.m[8] / 256;

  iVar3 = (pCVar10->N).roadMatrix.m[8] / 256;

  iVar4 = 1;

  if (iVar7 * iVar1 + iVar8 * iVar2 + iVar9 * iVar3 < 1) {

    iVar4 = -1;

  }

  pCVar10->direction = iVar4;

  pCVar10->desiredDirection = iVar4;

  if ((this->donutMode_ == 1) || (this->donutMode_ == 3)) {

    pCVar10 = this->carObj_;

    iVar7 = (pCVar10->N).orientMat.m[6] / 256;

    iVar1 = (pCVar10->N).roadMatrix.m[6] / 256;

    iVar8 = (pCVar10->N).orientMat.m[7] / 256;

    iVar2 = (pCVar10->N).roadMatrix.m[7] / 256;

    iVar9 = (pCVar10->N).orientMat.m[8] / 256;

    iVar3 = (pCVar10->N).roadMatrix.m[8] / 256;

    iVar4 = iVar11 + 3;

    if (0 <= iVar7 * iVar1 + iVar8 * iVar2 + iVar9 * iVar3)

    {

      if (gNumSlices <= iVar4) {

        iVar4 = iVar11 - (gNumSlices + -3);

      }

    }

    else {

      iVar4 = iVar11 + -3;

      if (iVar4 < 0) {

        iVar4 = iVar11 + gNumSlices + -3;

      }

    }

    piVar5 = (int *)(iVar4 * 0x20 + (int)BWorldSm_slices);

    /* load-3/store-3 grouped temps (catalog §A/38,54) */

    iVar7 = *piVar5;

    iVar1 = piVar5[1];

    iVar8 = piVar5[2];

    targetPos.x = iVar7;

    targetPos.y = iVar1;

    targetPos.z = iVar8;

    iVar7 = (this->carObj_)->roadPosition;

    if (iVar7 < 0) {

      iVar7 = -iVar7;

    }

    latPos = 0;

    if ((this->donutMode_ == 1) && (iVar7 < 0x28000)) {

      this->donutMode_ = 2;

    }

  }

  else {

    iVar7 = this->donutLookForward_ + -0x10000;

    this->donutLookForward_ = iVar7;

    if (iVar7 < 0x8000) {

      uVar12 = fastRandom * randSeed;

      randtemp = uVar12;

      fastRandom = uVar12 & 0xffff;

      this->donutLookForward_ = ((uVar12 >> 8 & 0xffff) * 5 >> 0xe) * 0x10000 + 0x140000;

    }

    pCVar10 = this->carObj_;

    /* SYM: right/forward/targetPos are real coorddef locals -- right = scaled local
       right-axis (orientMat row0), forward = scaled local forward-axis (orientMat row2
       via donutLookForward_), targetPos = position + right + forward. */

    right.x = (pCVar10->N).orientMat.m[0];

    right.y = (pCVar10->N).orientMat.m[1];

    right.z = (pCVar10->N).orientMat.m[2];

    pCVar6 = this->carObj_;

    forward.x = (pCVar6->N).orientMat.m[6];

    forward.y = (pCVar6->N).orientMat.m[7];

    forward.z = (pCVar6->N).orientMat.m[8];

    right.x = fixedmult(0x60000,right.x);

    right.y = fixedmult(0x60000,right.y);

    right.z = fixedmult(0x60000,right.z);

    forward.x = fixedmult(this->donutLookForward_,forward.x);

    forward.y = fixedmult(this->donutLookForward_,forward.y);

    forward.z = fixedmult(this->donutLookForward_,forward.z);

    targetPos.x = ((this->carObj_)->N).position.x + right.x;

    targetPos.y = ((this->carObj_)->N).position.y + right.y;

    targetPos.x = targetPos.x + forward.x;

    targetPos.z = ((this->carObj_)->N).position.z + right.z;

    targetPos.y = targetPos.y + forward.y;

    targetPos.z = targetPos.z + forward.z;

    pCVar10 = this->carObj_;

    latPos = Newton_CalculateRoadPositionFromSliceAndPosition((int)(pCVar10->N).simRoadInfo.slice,&targetPos,&(pCVar10->N).roadMatrix);

    iVar7 = (this->carObj_)->roadPosition;

    if (iVar7 < 0) {

      iVar11 = iVar11 * 0x20 + (int)BWorldSm_slices;

      if ((int)-((u_int)*(u_char *)(iVar11 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar11 + 0x1d) >> 4)) <=

          iVar7 + -0x20000) goto LAB_800722ec;

    }

    else {

      iVar11 = iVar11 * 0x20 + (int)BWorldSm_slices;

      if (iVar7 + 0x20000 <=

          (int)((u_int)*(u_char *)(iVar11 + 0x1f) * 0x8000 * (*(u_char *)(iVar11 + 0x1d) & 0xf)))

      goto LAB_800722ec;

    }

    this->donutMode_ = 1;

  }

LAB_800722ec:

  (this->carObj_)->donutMode = this->donutMode_;

  AI_GenericBeginCycle(this->carObj_);

  AI_GenericCycle(this->carObj_);

  AI_GenericEndCycle(this->carObj_);

  pCVar10 = this->carObj_;

  iVar7 = targetPos.x;

  iVar1 = targetPos.y;

  iVar8 = targetPos.z;

  (pCVar10->targetPos).x = iVar7;

  (pCVar10->targetPos).y = iVar1;

  (pCVar10->targetPos).z = iVar8;

  (this->carObj_)->targetLatPos = latPos;

  (this->carObj_)->desiredSpeed = 0x471c7;

  return;

}








/* ---- __17AIState_GotoSliceP8Car_tObjii  AIState_GotoSlice::ctor  [AISTATE.CPP:1348-1351] SLD-VERIFIED ---- */

AIState_GotoSlice::AIState_GotoSlice(Car_tObj *carObj,int targetSlice,int stopWhenArrivedAtSlice)
  : AIState_Normal(carObj)
{


  this->_vf = (__vtbl_ptr_type (*) [4])AIState_GotoSlice_vtable;

  this->targetSlice_ = targetSlice;

  this->stopWhenArrivedAtSlice_ = stopWhenArrivedAtSlice;

  return;

}








/* ---- Execute__17AIState_GotoSlice  AIState_GotoSlice::Execute  [AISTATE.CPP:1355-1388] SLD-VERIFIED ---- */

void AIState_GotoSlice::Execute()



{
      
  int bVar1;

  int distMeters;

  int absd;

  Car_tObj *pCVar3;

  int cap;

  int speed;

  int clamped;

  

  distMeters = AIWorld_ApxSplineDistance(this->targetSlice_,this->carObj_);

  if (-1 < distMeters) {

    (this->carObj_)->desiredDirection = 1;

  }

  else {

    (this->carObj_)->desiredDirection = -1;

  }

  this->AIState_Normal::Execute();

  if (this->stopWhenArrivedAtSlice_ != 0) {

    absd = __builtin_abs(distMeters);

    cap = 0xc80000;

    if (absd < 0xc0000) {

      cap = 0x40000;

    }

    else if (absd < 0x320000) {

      cap = 0x140000;

    }

    else if (absd < 0x960000) {

      cap = 0x280000;

    }

    else if (absd < 0x1900000) {

      cap = 0x500000;

    }

    pCVar3 = this->carObj_;

    speed = pCVar3->desiredSpeed;

    clamped = cap;

    if (-1 < speed) {

      bVar1 = speed < clamped;

    }

    else {

      clamped = -cap;

      bVar1 = clamped < speed;

    }

    if (bVar1) {

      clamped = speed;

    }

    pCVar3->desiredSpeed = clamped;

  }

  return;

}








/* ---- InTargetSliceRange__17AIState_GotoSlicei  AIState_GotoSlice::InTargetSliceRange  [AISTATE.CPP:1395-1398] SLD-VERIFIED ---- */

int AIState_GotoSlice::InTargetSliceRange(int rangeMeters)



{
  int distanceMeters;

  int iVar1;

  

  iVar1 = AIWorld_ApxSplineDistance(this->carObj_,this->targetSlice_);

  if (iVar1 < 0) {

    iVar1 = -iVar1;

  }

  return (u_int)(iVar1 < rangeMeters);

}








/* ---- __14AIState_CruiseP8Car_tObj12cruiseMode_ti  AIState_Cruise::ctor  [AISTATE.CPP:1403-1408] SLD-VERIFIED ---- */

AIState_Cruise::AIState_Cruise(Car_tObj *carObj,cruiseMode_t cruiseMode,int speedOrFactor)
  : AIState_Normal(carObj)
{


  this->_vf = (__vtbl_ptr_type (*) [4])AIState_Cruise_vtable;

  this->cruiseMode_ = cruiseMode;

  if (cruiseMode == 0) {

    this->cruiseSpeed_ = speedOrFactor;

  }

  else if (cruiseMode == 1) {

    this->cruiseFactor_ = speedOrFactor;

  }

  return;

}








/* ---- Execute__14AIState_Cruise  AIState_Cruise::Execute  [AISTATE.CPP:1414-1434] SLD-VERIFIED ---- */

void AIState_Cruise::Execute()



{

  int iVar1;

  cruiseMode_t cVar2;

  Car_tObj *pCVar3;

  

  cVar2 = this->cruiseMode_;

  switch (cVar2) {

  case CRUISE_ATSETSPEED:

    pCVar3 = this->carObj_;

    pCVar3->desiredSpeed = this->cruiseSpeed_ * pCVar3->direction;

    break;

  case CRUISE_ATFACTOR:

    AISpeeds_CalcDesiredSpeed(this->carObj_);

    iVar1 = fixedmult((this->carObj_)->desiredSpeed,

                       this->cruiseFactor_);

    (this->carObj_)->desiredSpeed = iVar1;

    break;

  case CRUISE_ATTRAFFICSPEED:

    AISpeeds_CalcTrafficTopSpeed(this->carObj_);

    break;

  }

  AI_GenericBeginCycle(this->carObj_);

  AI_GenericCycle(this->carObj_);

  AI_GenericEndCycle(this->carObj_);

  return;

}








/* ---- _._14AIState_Cruise  AIState_Cruise::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */
/* reconstructed as extern "C" ___14AIState_Cruise(AIState_Cruise*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle). */

extern "C" void ___14AIState_Cruise(AIState_Cruise *pThis,int __in_chrg)



{


  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- _._17AIState_GotoSlice  AIState_GotoSlice::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */
/* reconstructed as extern "C" ___17AIState_GotoSlice(AIState_GotoSlice*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle). */

extern "C" void ___17AIState_GotoSlice(AIState_GotoSlice *pThis,int __in_chrg)



{


  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- TestForRelease__21AIState_RovingTraffic  AIState_RovingTraffic::TestForRelease  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

int AIState_RovingTraffic::TestForRelease()



{

  return this->pathIndex_ < this->numPathPoints_ ^ 1;

}








/* ---- _._21AIState_RovingTraffic  AIState_RovingTraffic::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */
/* reconstructed as extern "C" ___21AIState_RovingTraffic(AIState_RovingTraffic*,int) free fn
   -- see AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle).
   MATCH: fresh pCVar2 for the carFlags RMW (3 distinct carObj_ pseudos) -- see the
   AIState_Offroad dtor MATCH note. 25->0. */

extern "C" void ___21AIState_RovingTraffic(AIState_RovingTraffic *pThis,int __in_chrg)



{

  Car_tObj *pCVar1;

  Car_tObj *pCVar2;



  pCVar1 = pThis->carObj_;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_RovingTraffic_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  (pThis->carObj_)->targetLatPos = 0;

  pCVar2 = pThis->carObj_;

  pCVar2->carFlags = pCVar2->carFlags & 0xfffff7ff;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- Execute__17AIState_NonActive  AIState_NonActive::Execute  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

void AIState_NonActive::Execute()



{

  return;

}








/* ---- _._17AIState_NonActive  AIState_NonActive::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */
/* reconstructed as extern "C" ___17AIState_NonActive(AIState_NonActive*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle). */

extern "C" void ___17AIState_NonActive(AIState_NonActive *pThis,int __in_chrg)



{


  pThis->_vf = (__vtbl_ptr_type (*) [4])((char *)AIState_NonActive_vtable + 8);

  ((pThis->carObj_)->N).active = '\x01';

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- _._12AIState_Idle  AIState_Idle::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */
/* reconstructed as extern "C" ___12AIState_Idle(AIState_Idle*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle). */

extern "C" void ___12AIState_Idle(AIState_Idle *pThis,int __in_chrg)



{

  Car_tObj *pCVar1;



  pCVar1 = pThis->carObj_;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

  pCVar1->carFlags = pCVar1->carFlags & 0xfffffbff;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- _._14AIState_Normal  AIState_Normal::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */
/* reconstructed as extern "C" ___14AIState_Normal(AIState_Normal*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle). */

extern "C" void ___14AIState_Normal(AIState_Normal *pThis,int __in_chrg)



{


  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* ---- TestForRelease__12AIState_Base  AIState_Base::TestForRelease  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

int AIState_Base::TestForRelease()



{

  return 0;

}








/* ---- _._12AIState_Base  AIState_Base::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

AIState_Base::~AIState_Base()
{
  this->_vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Base_vtable + 8);
  return;
}







/* end of aistate.cpp */
