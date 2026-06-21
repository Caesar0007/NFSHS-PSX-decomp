/* game/common/aistate.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
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

    AIScript_ProcessActionsAndReactions(&pCVar1->script,0);

  }

  (*(*this->_vf)[1].pfn)((int)&this->carObj_ + (int)(*this->_vf)[1].delta);

  return;

}








/* ---- __12AIState_BaseP8Car_tObj  AIState_Base::ctor  [AISTATE.CPP:73-74] SLD-VERIFIED ---- */

AIState_Base::AIState_Base(Car_tObj *carObj)



{

  this->_vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Base_vtable + 8);

  this->carObj_ = carObj;

  return;

}








/* ---- Execute__14AIState_Normal  AIState_Normal::Execute  [AISTATE.CPP:94-101] SLD-VERIFIED ---- */

void AIState_Normal::Execute()



{

  AISpeeds_CalcDesiredSpeed((this->_base_AIState_Base).carObj_);

  AI_GenericBeginCycle((this->_base_AIState_Base).carObj_);

  AI_GenericCycle((this->_base_AIState_Base).carObj_);

  AI_GenericEndCycle((this->_base_AIState_Base).carObj_);

  return;

}








/* ---- __14AIState_NormalP8Car_tObj  AIState_Normal::ctor  [AISTATE.CPP:105-110] SLD-VERIFIED ---- */

AIState_Normal::AIState_Normal(Car_tObj *carObj)
  : _base_AIState_Base(carObj)
{

  Car_tObj *pCVar1;

  


  pCVar1 = (this->_base_AIState_Base).carObj_;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_Normal_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  ((this->_base_AIState_Base).carObj_)->targetLatPos = 0;

  (((this->_base_AIState_Base).carObj_)->N).active = '\x01';

  return;

}








/* ---- Execute__12AIState_Idle  AIState_Idle::Execute  [AISTATE.CPP:129-149] SLD-VERIFIED ---- */

void AIState_Idle::Execute()



{
  int off;

  int iVar1;

  Car_tObj *pCVar2;

  

  if (this->idleInPlaceFlag_ == 0) {

    pCVar2 = (this->_base_AIState_Base).carObj_;

    if ((pCVar2->roadPosition - this->roadPosition_) + 0xffffU < 0x1ffff) {

      pCVar2->desiredSpeed = 0;

    }

    else {

      AISpeeds_CalcDesiredSpeed(pCVar2);

      pCVar2 = (this->_base_AIState_Base).carObj_;

      iVar1 = pCVar2->desiredSpeed;

      if (iVar1 < 0) {

        iVar1 = iVar1 + 3;

      }

      pCVar2->desiredSpeed = iVar1 >> 2;

    }

    ((this->_base_AIState_Base).carObj_)->desiredLatPos = this->roadPosition_;

  }

  else {

    ((this->_base_AIState_Base).carObj_)->desiredSpeed = 0;

    pCVar2 = (this->_base_AIState_Base).carObj_;

    pCVar2->desiredLatPos = pCVar2->roadPosition;

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

AIState_Chase::AIState_Chase(Car_tObj *carObj,Car_tObj *targetCar,coorddef *relPosition,

          int nitrousTicks,int nitrousMinForeDistance,int nitrousMinAftDistance,int aggressionLevel,

          int delayTime)
  : _base_AIState_Base(carObj), delayCar_(carObj,targetCar,delayTime)
{


  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_Chase_vtable;

  /* delayCar_ AIDelayCar(carObj,targetCar,delayTime) constructed in member-init list above (was flat __10AIDelayCarP8Car_tObjT1i) */

  this->nitrousTicks_ = nitrousTicks;

  this->SetTarget(targetCar,relPosition);

  ((this->_base_AIState_Base).carObj_)->accNitrous = 0x10000;

  ((this->_base_AIState_Base).carObj_)->speedNitrous = 0x10000;

  this->nitrousMinForeDistance_ = nitrousMinForeDistance;

  this->nitrousMinAftDistance_ = nitrousMinAftDistance;

  this->aggressionLevel_ = aggressionLevel;

  this->slowDownEndTime_ = 0;

  this->noTurnAroundEndTime_ = 0;

  this->barrierTicks32_ = 0;

  return;

}








/* ---- _._13AIState_Chase  AIState_Chase::dtor  [AISTATE.CPP:205-212] SLD-VERIFIED ---- */

AIState_Chase::~AIState_Chase()



{

  Car_tObj *pCVar1;


  

  pCVar1 = (this->_base_AIState_Base).carObj_;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_Chase_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  ((this->_base_AIState_Base).carObj_)->targetLatPos = 0;

  ((this->_base_AIState_Base).carObj_)->preferredLateralPosition = 0;

  ((this->_base_AIState_Base).carObj_)->preferredLateralPositionPower = 0;

  ((this->_base_AIState_Base).carObj_)->accNitrous = 0x10000;

  ((this->_base_AIState_Base).carObj_)->speedNitrous = 0x10000;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Chase_vtable + 8);


  return;

}








/* ---- SetTarget__13AIState_ChaseP8Car_tObjP8coorddef  AIState_Chase::SetTarget  [AISTATE.CPP:216-237] SLD-VERIFIED ---- */

void AIState_Chase::SetTarget(Car_tObj *targetCar,coorddef *relPosition)



{

  int iVar1;

  int iVar2;

  int iVar3;

  

  if (this->targetCar_ != targetCar) {

    (&this->delayCar_)->SetNewTargetCar(targetCar)

    ;

  }

  this->targetCar_ = targetCar;

  iVar2 = relPosition->y;

  iVar3 = relPosition->z;

  (this->relPosition_).x = relPosition->x;

  (this->relPosition_).y = iVar2;

  (this->relPosition_).z = iVar3;

  this->longTargetRegion_ = 0;

  this->latTargetRegion_ = 0;

  iVar1 = (this->targetCar_->N).dimension.x;

  iVar3 = (this->relPosition_).x;

  iVar2 = -1;

  if ((iVar3 < -iVar1) || (iVar2 = 1, iVar1 < iVar3)) {

    this->latTargetRegion_ = iVar2;

  }

  iVar1 = (this->targetCar_->N).dimension.z;

  iVar3 = (this->relPosition_).z;

  iVar2 = -1;

  if ((iVar3 < -iVar1) || (iVar2 = 1, iVar1 < iVar3)) {

    this->longTargetRegion_ = iVar2;

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

  int iVar2;

  coorddef local_20;

  

  (&this->delayCar_)->Update();

  iVar2 = -1;

  if (-1 < ((this->_base_AIState_Base).carObj_)->currentSpeed) {

    iVar2 = 1;

  }

  this->carDir_ = iVar2;

  iVar2 = -1;

  if (-1 < (this->delayCar_).currentSpeed_) {

    iVar2 = 1;

  }

  pCVar1 = (this->_base_AIState_Base).carObj_;

  this->targetDir_ = iVar2;

  this->latMetersBetween_ = pCVar1->roadPosition - (this->delayCar_).roadPosition_;

  local_20.x = (this->delayCar_).position_.x;

  local_20.y = (this->delayCar_).position_.y;

  local_20.z = (this->delayCar_).position_.z;

  iVar2 = AIWorld_SplineDistance((this->_base_AIState_Base).carObj_,(this->delayCar_).slice_,&local_20);

  pCVar1 = (this->_base_AIState_Base).carObj_;

  this->longMetersBetween_ = iVar2;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  ((this->_base_AIState_Base).carObj_)->targetLatPos = 0;

  if ((this->murderMode_ != 0) && (this->murderEndTime_ <= simGlobal.gameTicks)) {

    this->murderMode_ = 0;

    this->murderEndTime_ = 0;

  }

  if (((this->_base_AIState_Base).carObj_)->accNitrous != 0x10000) {

    this->nitrousTicks_ = this->nitrousTicks_;

  }

  ((this->_base_AIState_Base).carObj_)->accNitrous = 0x10000;

  ((this->_base_AIState_Base).carObj_)->speedNitrous = 0x10000;

  ((this->_base_AIState_Base).carObj_)->preferredLateralPosition = 0;

  ((this->_base_AIState_Base).carObj_)->preferredLateralPositionPower = 0;

  return;

}








/* ---- DoSlowNitrous__13AIState_Chase  AIState_Chase::DoSlowNitrous  [AISTATE.CPP:287-292] SLD-VERIFIED ---- */

void AIState_Chase::DoSlowNitrous()



{

  ((this->_base_AIState_Base).carObj_)->accNitrous = 0x8000;

  ((this->_base_AIState_Base).carObj_)->speedNitrous = 0xc000;

  return;

}








/* ---- DoNitrous__13AIState_Chasei  AIState_Chase::DoNitrous  [AISTATE.CPP:296-318] SLD-VERIFIED ---- */

void AIState_Chase::DoNitrous(int checkForHumans)



{
  int humanLoop;
  int distanceMeters;

  int iVar1;

  Car_tObj *pCVar2;

  Car_tObj **ppCVar3;

  int iVar4;

  

  if ((0 < this->nitrousTicks_) && (this->slowDownEndTime_ <= simGlobal.gameTicks)) {

    ((this->_base_AIState_Base).carObj_)->accNitrous = 0x30000;

    ppCVar3 = Cars_gHumanRaceCarList;

    ((this->_base_AIState_Base).carObj_)->speedNitrous = 0x28000;

    for (iVar4 = 0; (checkForHumans != 0 && (iVar4 < Cars_gNumHumanRaceCars)); iVar4 = iVar4 + 1) {

      iVar1 = AIWorld_ApxSplineDistance((this->_base_AIState_Base).carObj_,*ppCVar3);

      pCVar2 = (this->_base_AIState_Base).carObj_;

      iVar1 = iVar1 * pCVar2->direction;

      if ((0 < iVar1) && (iVar1 < this->nitrousMinForeDistance_)) {

        pCVar2->accNitrous = 0x10000;

        ((this->_base_AIState_Base).carObj_)->speedNitrous = 0x10000;

      }

      if ((iVar1 < 0) && (-this->nitrousMinAftDistance_ < iVar1)) {

        ((this->_base_AIState_Base).carObj_)->accNitrous = 0x10000;

        ((this->_base_AIState_Base).carObj_)->speedNitrous = 0x10000;

      }

      ppCVar3 = ppCVar3 + 1;

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

  bool bVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  

  this->SetUp();

  iVar2 = fixedmult(this->longMetersBetween_,0x666);

  iVar3 = this->targetCar_->currentSpeed;

  if (iVar2 < 0) {

    iVar2 = -iVar2;

  }

  iVar4 = ((this->_base_AIState_Base).carObj_)->currentSpeed - iVar3;

  if (iVar4 < 0) {

    iVar4 = -iVar4;

  }

  bVar1 = false;

  if (iVar4 < iVar2) {

    iVar2 = this->longMetersBetween_;

    if (iVar2 < 0) {

      iVar2 = -iVar2;

    }

    bVar1 = 0x8c0000 < iVar2;

  }

  if (iVar3 < 0) {

    iVar3 = -iVar3;

  }

  if (bVar1) {

LAB_80070244:

    this->FarTargeting();

    goto LAB_800702a0;

  }

  if ((this->carDir_ * this->targetDir_ == 1) && (0x6aaa9 < iVar3)) {

    this->CloseTargeting();

    goto LAB_800702a0;

  }

  if ((-1 < this->carDir_ * this->longMetersBetween_) && (0x6aaa9 < iVar3)) goto LAB_80070244;

  if (iVar4 < 0x1aaaab) {

    iVar2 = this->longMetersBetween_;

    if (iVar2 < 0) {

      iVar2 = -iVar2;

    }

    iVar3 = 1;

    if (0x500000 < iVar2) goto LAB_80070290;

  }

  else {

LAB_80070290:

    iVar3 = 0;

  }

  this->ApproachTargeting(iVar3);

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

  if (this->noTurnAroundEndTime_ < simGlobal.gameTicks) {

    if (this->longMetersBetween_ < 1) {

      ((this->_base_AIState_Base).carObj_)->desiredDirection = 1;

    }

    else {

      ((this->_base_AIState_Base).carObj_)->desiredDirection = -1;

    }

  }

  this->DoNitrous(1);

  AISpeeds_CalcDesiredSpeed((this->_base_AIState_Base).carObj_);

  AI_GenericBeginCycle((this->_base_AIState_Base).carObj_);

  this->CheckForBarriersAndTargetAroundThem();

  AI_GenericCycle((this->_base_AIState_Base).carObj_);

  AI_GenericEndCycle((this->_base_AIState_Base).carObj_);

  return;

}








/* ---- CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase  AIState_Chase::CalculateCloseTargettingAheadSlowDownFactor  [AISTATE.CPP:443-457] SLD-VERIFIED ---- */

int AIState_Chase::CalculateCloseTargettingAheadSlowDownFactor()



{
  int absLongMetersBetween;
  int slowDown;

  int iVar1;

  int iVar2;

  

  iVar1 = this->longMetersBetween_;

  if (iVar1 < 0) {

    iVar1 = -iVar1;

  }

  iVar2 = 0x9999;

  if (iVar1 < 0x1e0000) {

    iVar2 = 0xf333;

  }

  else if ((iVar1 < 0x320000) || (iVar1 < 0x640000)) {

    iVar2 = 0xcccc;

  }

  else if (iVar1 < 0x960000) {

    iVar2 = 0xc000;

  }

  else if (iVar1 < 0xc80000) {

    iVar2 = 0xb333;

  }

  return iVar2;

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

  iVar10 = ((this->_base_AIState_Base).carObj_)->direction;

  this->DoNitrous(1);

  iVar4 = 0;

  if (this->murderMode_ == 0) {

    iVar6 = this->latTargetRegion_;

    iVar5 = this->longTargetRegion_;

  }

  else {

    iVar5 = 0;

    iVar6 = 0;

    this->DoNitrous(0);

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

    this->inTargetRegion_ = this->inTargetRegion_;

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

  AISpeeds_CalcDesiredSpeed((this->_base_AIState_Base).carObj_);

  pCVar2 = (this->_base_AIState_Base).carObj_;

  iVar7 = pCVar2->desiredSpeed;

  if (iVar7 < 0) {

    iVar7 = -iVar7;

  }

  pCVar2->desiredSpeed = iVar7;

  pCVar2 = (this->_base_AIState_Base).carObj_;

  iVar7 = pCVar2->desiredSpeed;

  if (iVar4 < iVar7) {

    iVar7 = iVar4;

  }

  iVar4 = 0x50000;

  if (0x4ffff < iVar7) {

    iVar4 = iVar7;

  }

  pCVar2->desiredSpeed = iVar4 * iVar10;

  AI_GenericBeginCycle((this->_base_AIState_Base).carObj_);

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

      iVar10 = (((this->_base_AIState_Base).carObj_)->N).simRoadInfo.slice * 0x20 + BWorldSm_slices;

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

    ((this->_base_AIState_Base).carObj_)->preferredLateralPosition = iVar8;

    ((this->_base_AIState_Base).carObj_)->preferredLateralPositionPower = iVar4;

  }

  this->CheckForBarriersAndTargetAroundThem();

  AI_GenericCycle((this->_base_AIState_Base).carObj_);

  AI_GenericEndCycle((this->_base_AIState_Base).carObj_);

  return;

}








/* ---- ApproachTargeting__13AIState_Chasei  AIState_Chase::ApproachTargeting  [AISTATE.CPP:637-713] SLD-VERIFIED ---- */

void AIState_Chase::ApproachTargeting(int intercept)



{
  int xDistance;
  int zDistance;
  int distance;
  int minSpeed;

  bool bVar1;

  int iVar2;

  Car_tObj *pCVar3;

  Car_tObj *pCVar4;

  int iVar5;

  int iVar6;

  

  pCVar4 = (this->_base_AIState_Base).carObj_;

  iVar6 = (pCVar4->N).position.x - (this->targetCar_->N).position.x;

  if (iVar6 < 0) {

    iVar6 = -iVar6;

  }

  iVar2 = (pCVar4->N).position.z - (this->targetCar_->N).position.z;

  if (iVar2 < 0) {

    iVar2 = -iVar2;

  }

  if (iVar2 < iVar6) {

    iVar6 = iVar6 + (iVar2 >> 2);

  }

  else {

    iVar6 = iVar2 + (iVar6 >> 2);

  }

  this->inTargetRegion_ = 0;

  if (this->noTurnAroundEndTime_ < simGlobal.gameTicks) {

    if (this->longMetersBetween_ < 1) {

      ((this->_base_AIState_Base).carObj_)->desiredDirection = 1;

    }

    else {

      ((this->_base_AIState_Base).carObj_)->desiredDirection = -1;

    }

  }

  AISpeeds_CalcDesiredSpeed((this->_base_AIState_Base).carObj_);

  iVar2 = this->aggressionLevel_;

  if (iVar2 == 1) {

    iVar5 = 0x3c0000;

    if ((((0x960000 < iVar6) || (iVar5 = 0x320000, 0x640000 < iVar6)) ||

        (iVar5 = 0x280000, 0x320000 < iVar6)) || (iVar5 = 0x230000, 0x190000 < iVar6))

    goto LAB_80070adc;

    iVar5 = 0xa0000;

  }

  else {

    if (1 < iVar2) {

      iVar5 = 0x190000;

      if ((((iVar2 == 2) && (iVar5 = 0x500000, iVar6 < 0x960001)) &&

          ((iVar5 = 0x460000, iVar6 < 0x640001 &&

           ((iVar5 = 0x320000, iVar6 < 0x320001 && (iVar5 = 0x280000, iVar6 < 0x190001)))))) &&

         ((iVar5 = 0xe0000, iVar6 < 0xa0001 && (iVar5 = 0, 0x60000 < iVar6)))) {

        iVar5 = 0x60000;

      }

      goto LAB_80070adc;

    }

    iVar5 = 0x190000;

    if ((((iVar2 != 0) || (iVar5 = 0x3c0000, 0x960000 < iVar6)) ||

        (iVar5 = 0x320000, 0x640000 < iVar6)) ||

       ((iVar5 = 0x280000, 0x320000 < iVar6 || (iVar5 = 0x230000, 0x190000 < iVar6))))

    goto LAB_80070adc;

    iVar5 = 0x140000;

  }

  if ((iVar6 < 0xa0001) && (iVar5 = 0, 0x60000 < iVar6)) {

    iVar5 = 0x30000;

  }

LAB_80070adc:

  pCVar4 = (this->_base_AIState_Base).carObj_;

  iVar6 = -iVar5;

  if (pCVar4->direction == 1) {

    iVar2 = pCVar4->desiredSpeed;

    bVar1 = iVar2 < iVar5;

    iVar6 = iVar5;

  }

  else {

    iVar2 = pCVar4->desiredSpeed;

    bVar1 = iVar6 < iVar2;

  }

  if (bVar1) {

    iVar6 = iVar2;

  }

  pCVar4->desiredSpeed = iVar6;

  AI_GenericBeginCycle((this->_base_AIState_Base).carObj_);

  this->CheckForBarriersAndTargetAroundThem();

  AI_GenericCycle((this->_base_AIState_Base).carObj_);

  AI_GenericEndCycle((this->_base_AIState_Base).carObj_);

  if (intercept != 0) {

    pCVar3 = (this->_base_AIState_Base).carObj_;

    pCVar4 = this->targetCar_;

    iVar6 = (pCVar4->N).position.y;

    iVar2 = (pCVar4->N).position.z;

    (pCVar3->targetPos).x = (pCVar4->N).position.x;

    (pCVar3->targetPos).y = iVar6;

    (pCVar3->targetPos).z = iVar2;

    ((this->_base_AIState_Base).carObj_)->targetLatPos = this->targetCar_->roadPosition;

    ((this->_base_AIState_Base).carObj_)->preferredLateralPosition = this->targetCar_->roadPosition;

    ((this->_base_AIState_Base).carObj_)->preferredLateralPositionPower = 0xf0000;

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

  u_char bVar1;

  int iVar2;

  Car_tObj *pCVar3;

  int iVar4;

  int lane0;

  int slice;

  

  iVar2 = this->longMetersBetween_;

  if (iVar2 < 0) {

    iVar2 = -iVar2;

  }

  if (iVar2 < 0x1f40001) {

    pCVar3 = (this->_base_AIState_Base).carObj_;

    slice = (int)(pCVar3->N).simRoadInfo.slice;

    iVar4 = pCVar3->laneIndex;

    bVar1 = *(u_char *)(slice * 0x20 + BWorldSm_slices + 0x1d);

    iVar2 = (int)(this->targetCar_->N).simRoadInfo.slice;

    lane0 = this->targetCar_->laneIndex;

    if (((((int)(6 - (u_int)(bVar1 >> 4)) <= iVar4) && (iVar4 <= (int)((bVar1 & 0xf) + 7))) &&

        (bVar1 = *(u_char *)(iVar2 * 0x20 + BWorldSm_slices + 0x1d),

        (int)(6 - (u_int)(bVar1 >> 4)) <= lane0)) && (lane0 <= (int)((bVar1 & 0xf) + 7))) {

      iVar2 = AIWorld_CheckForBarrierBetweenLanes(iVar2,lane0,iVar4)

      ;

      iVar4 = AIWorld_CheckForBarrierBetweenLanes(slice,lane0,iVar4)

      ;

      if (iVar2 == 0) {

        this->barrierTicks32_ = 0;

      }

      else if (iVar4 == 0) {

        pCVar3 = (this->_base_AIState_Base).carObj_;

        this->barrierTicks32_ = 0;

        AI_TargetLane(pCVar3,lane0);

        AI_TargetLane((this->_base_AIState_Base).carObj_,lane0);

        AI_TargetLane((this->_base_AIState_Base).carObj_,lane0);

      }

      else {

        this->barrierTicks32_ = this->barrierTicks32_;

      }

    }

  }

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

  

  pCVar3 = (this->_base_AIState_Base).carObj_;

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

         (bVar1 = *(u_char *)(slice * 0x20 + BWorldSm_slices + 0x1d),

         iVar9 < (int)(6 - (u_int)(bVar1 >> 4)))) ||

        (iVar6 = iVar9, (int)((bVar1 & 0xf) + 7) < iVar9)))) {

      iVar9 = iVar10;

      if ((uVar2 & 1) == 0) break;

      bVar1 = *(u_char *)(slice * 0x20 + BWorldSm_slices + 0x1d);

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

         (bVar1 = *(u_char *)(iVar8 * 0x20 + BWorldSm_slices + 0x1d),

         iVar10 < (int)(6 - (u_int)(bVar1 >> 4)))) ||

        (iVar9 = iVar10, (int)((bVar1 & 0xf) + 7) < iVar10)))) {

      iVar10 = iVar5;

      if ((uVar2 & 1) == 0) break;

      bVar1 = *(u_char *)(iVar8 * 0x20 + BWorldSm_slices + 0x1d);

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

AIState_Offroad::~AIState_Offroad()



{

  Car_tObj *pCVar1;


  

  pCVar1 = (this->_base_AIState_Base).carObj_;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_Offroad_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  ((this->_base_AIState_Base).carObj_)->targetLatPos = 0;

  pCVar1 = (this->_base_AIState_Base).carObj_;

  pCVar1->carFlags = pCVar1->carFlags & 0xfffff7ff;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Offroad_vtable + 8);


  return;

}








/* ---- __15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii  AIState_Offroad::ctor  [AISTATE.CPP:896-920] SLD-VERIFIED ---- */

AIState_Offroad::AIState_Offroad(Car_tObj *carObj,int startSlice,coorddef *position,

          matrixtdef *orientation,int maxSpeedKPH,int releaseTime,int endSlice)
  : _base_AIState_Base(carObj)
{

  int *piVar1;

  matrixtdef *pmVar2;

  Car_tObj *pCVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  


  pmVar2 = &this->startOrientation_;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_Offroad_vtable;

  this->letGo_ = 0;

  this->startSlice_ = startSlice;

  iVar4 = position->y;

  iVar5 = position->z;

  (this->startPosition_).x = position->x;

  (this->startPosition_).y = iVar4;

  (this->startPosition_).z = iVar5;

  piVar1 = orientation->m;

  do {

    iVar4 = *(int *)((int)orientation + 4);

    iVar5 = *(int *)((int)orientation + 8);

    iVar6 = *(int *)((int)orientation + 0xc);

    pmVar2->m[0] = orientation->m[0];

    pmVar2->m[1] = iVar4;

    pmVar2->m[2] = iVar5;

    pmVar2->m[3] = iVar6;

    orientation = (matrixtdef *)((int)orientation + 0x10);

    pmVar2 = (matrixtdef *)(pmVar2->m + 4);

  } while (orientation != (matrixtdef *)(piVar1 + 8));

  pmVar2->m[0] = *(int *)orientation;

  iVar4 = (this->startOrientation_).m[7];

  iVar5 = (this->startOrientation_).m[8];

  (this->startHeading_).x = (this->startOrientation_).m[6];

  (this->startHeading_).y = iVar4;

  (this->startHeading_).z = iVar5;

  this->maxSpeedMPS_ = maxSpeedKPH * 0x4700;

  iVar4 = BWorldSm_slices;

  this->targetSlice_ = endSlice;

  this->releaseTime_ = releaseTime;

  piVar1 = (int *)(endSlice * 0x20 + iVar4);

  iVar4 = piVar1[1];

  iVar5 = piVar1[2];

  (this->targetPosition_).x = *piVar1;

  (this->targetPosition_).y = iVar4;

  (this->targetPosition_).z = iVar5;

  pCVar3 = (this->_base_AIState_Base).carObj_;

  pCVar3->carFlags = pCVar3->carFlags | 0x800;

  return;

}








/* ---- UnleashIfInRange__15AIState_OffroadP8Car_tObj  AIState_Offroad::UnleashIfInRange  [AISTATE.CPP:926-936] SLD-VERIFIED ---- */

void AIState_Offroad::UnleashIfInRange(Car_tObj *car)



{
  int distanceAbsMeters;
  int releaseDistanceMeters;

  bool bVar1;

  int iVar2;

  int iVar3;

  

  iVar2 = AIWorld_SplineDistance((this->_base_AIState_Base).carObj_,car);

  if (iVar2 < 0) {

    iVar2 = -iVar2;

  }

  iVar3 = fixedmult((car->N).speedXZ,this->releaseTime_);

  bVar1 = iVar2 < iVar3;

  if (iVar3 < 0x140000) {

    bVar1 = iVar2 < 0x140000;

  }

  if (bVar1) {

    this->letGo_ = 1;

  }

  return;

}








/* ---- Execute__15AIState_Offroad  AIState_Offroad::Execute  [AISTATE.CPP:944-978] SLD-VERIFIED ---- */

void AIState_Offroad::Execute()



{
  coorddef zero;

  Car_tObj *pCVar1;

  matrixtdef *pmVar2;

  matrixtdef *pmVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int local_18;

  int local_14;

  int local_10;

  

  if (this->letGo_ == 0) {

    memset((u_char *)&local_18,'\0',0xc);

    pCVar1 = (this->_base_AIState_Base).carObj_;

    (pCVar1->N).linearVel.x = local_18;

    (pCVar1->N).linearVel.y = local_14;

    (pCVar1->N).linearVel.z = local_10;

    pCVar1 = (this->_base_AIState_Base).carObj_;

    (pCVar1->N).angularVel.x = local_18;

    (pCVar1->N).angularVel.y = local_14;

    (pCVar1->N).angularVel.z = local_10;

    ((this->_base_AIState_Base).carObj_)->desiredSpeed = 0;

    pCVar1 = (this->_base_AIState_Base).carObj_;

    pmVar3 = &this->startOrientation_;

    iVar4 = (this->startPosition_).y;

    iVar5 = (this->startPosition_).z;

    (pCVar1->N).position.x = (this->startPosition_).x;

    (pCVar1->N).position.y = iVar4;

    (pCVar1->N).position.z = iVar5;

    pmVar2 = &(((this->_base_AIState_Base).carObj_)->N).orientMat;

    do {

      iVar4 = pmVar3->m[1];

      iVar5 = pmVar3->m[2];

      iVar6 = pmVar3->m[3];

      pmVar2->m[0] = pmVar3->m[0];

      pmVar2->m[1] = iVar4;

      pmVar2->m[2] = iVar5;

      pmVar2->m[3] = iVar6;

      pmVar3 = (matrixtdef *)(pmVar3->m + 4);

      pmVar2 = (matrixtdef *)(pmVar2->m + 4);

    } while (pmVar3 != (matrixtdef *)((this->startOrientation_).m + 8));

    pmVar2->m[0] = pmVar3->m[0];

    pCVar1 = (this->_base_AIState_Base).carObj_;

    (pCVar1->targetPos).z = 0;

    (pCVar1->targetPos).y = 0;

    (pCVar1->targetPos).x = 0;

  }

  else {

    iVar4 = AIWorld_ApxSplineDistance((this->_base_AIState_Base).carObj_,this->targetSlice_);

    pCVar1 = (this->_base_AIState_Base).carObj_;

    this->longMetersBetween_ = iVar4;

    pCVar1->desiredSpeed = this->maxSpeedMPS_;

    if (this->longMetersBetween_ < 1) {

      ((this->_base_AIState_Base).carObj_)->desiredDirection = 1;

    }

    else {

      ((this->_base_AIState_Base).carObj_)->desiredDirection = -1;

      pCVar1 = (this->_base_AIState_Base).carObj_;

      pCVar1->desiredSpeed = -pCVar1->desiredSpeed;

    }

    AI_GenericBeginCycle((this->_base_AIState_Base).carObj_);

    AI_GenericCycle((this->_base_AIState_Base).carObj_);

    AI_GenericEndCycle((this->_base_AIState_Base).carObj_);

    pCVar1 = (this->_base_AIState_Base).carObj_;

    iVar4 = (this->targetPosition_).y;

    iVar5 = (this->targetPosition_).z;

    (pCVar1->targetPos).x = (this->targetPosition_).x;

    (pCVar1->targetPos).y = iVar4;

    (pCVar1->targetPos).z = iVar5;

  }

  ((this->_base_AIState_Base).carObj_)->targetLatPos = 0;

  return;

}








/* ---- __17AIState_PurgatoryP8Car_tObj  AIState_Purgatory::ctor  [AISTATE.CPP:1001-1017] SLD-VERIFIED ---- */

AIState_Purgatory::AIState_Purgatory(Car_tObj *carObj)



{
  coorddef trafficOffset;
  int lifeTimer;

  u_int uVar1;

  bool bVar2;

  int iVar3;

  Car_tObj *pCVar4;

  coorddef cStack_20;

  

  (this->_base_AIState_NonActive)._base_AIState_Base.carObj_ = carObj;

  (this->_base_AIState_NonActive)._base_AIState_Base._vf =

       (__vtbl_ptr_type (*) [4])((char *)AIState_Purgatory_vtable + 8);

  memset((u_char *)&cStack_20,'\0',0xc);

  cStack_20.y = carObj->carIndex * 0xa0000;

  Newton_SetInitialSlicePositionOrientationEtc(&((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->N,0,&cStack_20,1);

  (((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->N).active = '\0';

  uVar1 = randSeed;

  (this->_base_AIState_NonActive)._base_AIState_Base._vf = (__vtbl_ptr_type (*) [4])AIState_Purgatory_vtable;

  uVar1 = fastRandom * uVar1;

  ((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->basisCar = (Car_tObj *)0x0;

  bVar2 = false;

  randtemp = uVar1;

  ((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->physicsModelTimer =

       (AITune_LifeTimer[Cars_gNumTrafficCars] * (uVar1 >> 8 & 0xffff) >> 0x10) + 1;

  fastRandom = uVar1 & 0xffff;

  iVar3 = strcmp(((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->carName,"SBUS");

  if ((iVar3 == 0) ||

     (iVar3 = strcmp(((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->carName,"TBUS"),

     iVar3 == 0)) {

    bVar2 = true;

  }

  if (bVar2) {

    pCVar4 = (this->_base_AIState_NonActive)._base_AIState_Base.carObj_;

    pCVar4->physicsModelTimer = pCVar4->physicsModelTimer * 5;

  }

  pCVar4 = (this->_base_AIState_NonActive)._base_AIState_Base.carObj_;

  pCVar4->AIFlags = pCVar4->AIFlags | 4;

  if ((((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->carFlags & 0x10U) != 0) {

    AIState_Purgatory_numTrafficCarsInPurgatory = AIState_Purgatory_numTrafficCarsInPurgatory + 1;

  }

  return;

}








/* ---- _._17AIState_Purgatory  AIState_Purgatory::dtor  [AISTATE.CPP:1021-1041] SLD-VERIFIED ---- */

AIState_Purgatory::~AIState_Purgatory()



{
  /* removed unused `int __in_chrg;` — shadowed cfront's implicit dtor in-charge param */
  int search;
  Car_tObj*test;

  Car_tObj *pCVar1;

  int iVar2;


  Car_tObj **ppCVar3;

  

  pCVar1 = (this->_base_AIState_NonActive)._base_AIState_Base.carObj_;

  (this->_base_AIState_NonActive)._base_AIState_Base._vf = (__vtbl_ptr_type (*) [4])AIState_Purgatory_vtable;

  (pCVar1->collision).resetTimer = 0;

  (((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->N).collision.disableCollisionTimer = 0;

  pCVar1 = (this->_base_AIState_NonActive)._base_AIState_Base.carObj_;

  pCVar1->AIFlags = pCVar1->AIFlags & 0xfffffffb;

  if ((((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->carFlags & 0x10U) != 0) {

    AIState_Purgatory_numTrafficCarsInPurgatory = AIState_Purgatory_numTrafficCarsInPurgatory + -1;

  }

  iVar2 = Cars_gNumCars + -1;

  ppCVar3 = Cars_gSortedList + iVar2;

  pCVar1 = (this->_base_AIState_NonActive)._base_AIState_Base.carObj_;

  pCVar1->direction = 1;

  pCVar1->desiredDirection = 1;

  do {

    if (iVar2 < 0) {

LAB_80071718:

      pCVar1 = (this->_base_AIState_NonActive)._base_AIState_Base.carObj_;

      (this->_base_AIState_NonActive)._base_AIState_Base._vf =

           (__vtbl_ptr_type (*) [4])((char *)AIState_Purgatory_vtable + 8);

      (pCVar1->N).active = '\x01';

      (this->_base_AIState_NonActive)._base_AIState_Base._vf =

           (__vtbl_ptr_type (*) [4])((char *)AIState_Purgatory_vtable + 8);


      return;

    }

    pCVar1 = *ppCVar3;

    ppCVar3 = ppCVar3 + -1;

    if ((pCVar1->carFlags & 0x100U) != 0) {

      ((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->basisCar = pCVar1;

      goto LAB_80071718;

    }

    iVar2 = iVar2 + -1;

  } while( true );

}








/* ---- TestForRelease__17AIState_Purgatory  AIState_Purgatory::TestForRelease  [AISTATE.CPP:1048-1063] SLD-VERIFIED ---- */

int AIState_Purgatory::TestForRelease()



{
  int trafficInWorld;

  int iVar1;

  Car_tObj *pCVar2;

  

  pCVar2 = (this->_base_AIState_NonActive)._base_AIState_Base.carObj_;

  if (pCVar2->physicsModelTimer < 1) {

    iVar1 = GameSetup_gData.trafficDensity * 4;

    if (GameSetup_gData.commMode == 1) {

      iVar1 = iVar1 + 0x10;

    }

    if (Cars_gNumTrafficCars - AIState_Purgatory_numTrafficCarsInPurgatory < *(int *)((int)AITune_MaxTraffic[0] + iVar1)) {

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

  

  (((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->collision).resetTimer = 0;

  (((this->_base_AIState_NonActive)._base_AIState_Base.carObj_)->N).collision.disableCollisionTimer = 0;

  pCVar1 = (this->_base_AIState_NonActive)._base_AIState_Base.carObj_;

  if (((pCVar1->carFlags & 0x20U) == 0) && (0x3bf < simGlobal.gameTicks)) {

    pCVar1->physicsModelTimer = pCVar1->physicsModelTimer;

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
  : _base_AIState_Base(carObj)
{

  int iVar1;

  Car_tObj *pCVar2;

  


  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_RovingTraffic_vtable;

  pCVar2 = (this->_base_AIState_Base).carObj_;

  this->path_ = *(trigger_pathPosition_t **)(trigger + 0x3c);

  iVar1 = *(int *)(trigger + 0x38);

  this->pathIndex_ = 0;

  this->waitTick_ = 0;

  this->numPathPoints_ = iVar1;

  pCVar2->carFlags = pCVar2->carFlags | 0x800;

  return;

}








/* ---- CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi  AIState_RovingTraffic::CheckIfCarIsNearbyAndStop  [AISTATE.CPP:1130-1169] SLD-VERIFIED ---- */

void AIState_RovingTraffic::CheckIfCarIsNearbyAndStop(Car_tObj *otherCarObj,int *status)



{
  int distance;
  coorddef posDiff;

  int iVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  Car_tObj *carObj;

  int iVar5;

  

  carObj = (this->_base_AIState_Base).carObj_;

  if ((carObj == otherCarObj) || ((otherCarObj->N).active == '\0')) {

LAB_80071a40:

    *status = 2;

  }

  else {

    iVar1 = AIWorld_SplineDistance(carObj,otherCarObj);

    if (iVar1 < 1) {

      iVar1 = AIWorld_SplineDistance((this->_base_AIState_Base).carObj_,otherCarObj);

      iVar1 = -iVar1;

    }

    else {

      iVar1 = AIWorld_SplineDistance((this->_base_AIState_Base).carObj_,otherCarObj);

    }

    if (0xc0000 < iVar1) {

      *status = 0;

      return;

    }

    iVar5 = ((this->_base_AIState_Base).carObj_)->roadPosition;

    iVar1 = iVar5 - otherCarObj->roadPosition;

    if (iVar1 < 1) {

      if (0x9ffff < otherCarObj->roadPosition - iVar5) goto LAB_80071a40;

    }

    else if (0x9ffff < iVar1) {

      *status = 2;

      return;

    }

    iVar1 = (otherCarObj->N).position.y;

    iVar3 = (((this->_base_AIState_Base).carObj_)->N).position.y;

    iVar5 = (otherCarObj->N).position.z;

    iVar4 = (((this->_base_AIState_Base).carObj_)->N).position.z;

    iVar2 = fixedmult((((this->_base_AIState_Base).carObj_)->N).orientMat.m[6],

                       (otherCarObj->N).position.x - (((this->_base_AIState_Base).carObj_)->N).position.x)

    ;

    iVar1 = fixedmult((((this->_base_AIState_Base).carObj_)->N).orientMat.m[7],iVar1 - iVar3);

    iVar5 = fixedmult((((this->_base_AIState_Base).carObj_)->N).orientMat.m[8],iVar5 - iVar4);

    if (0 < iVar2 + iVar1 + iVar5) {

      AudioClc_HonkHorn((this->_base_AIState_Base).carObj_,4,0x10,8);

      ((this->_base_AIState_Base).carObj_)->desiredSpeed = 0;

      *status = 1;

    }

  }

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

  int *piVar2;

  int iVar3;

  Car_tObj *pCVar4;

  int iVar5;

  int iVar6;

  int iVar7;

  int iVar8;

  int iVar9;

  Car_tObj **ppCVar10;

  int local_20 [2];

  

  pCVar4 = (this->_base_AIState_Base).carObj_;

  ptVar1 = this->path_ + this->pathIndex_;

  iVar8 = (ptVar1->position).y;

  iVar9 = (ptVar1->position).z;

  (pCVar4->targetPos).x = (ptVar1->position).x;

  (pCVar4->targetPos).y = iVar8;

  (pCVar4->targetPos).z = iVar9;

  ((this->_base_AIState_Base).carObj_)->desiredSpeed = this->path_[this->pathIndex_].targetSpeed * 0x7247;

  piVar2 = (int *)((((this->_base_AIState_Base).carObj_)->N).simRoadInfo.slice * 0x20 + BWorldSm_slices);

  iVar8 = (((this->_base_AIState_Base).carObj_)->targetPos).x - *piVar2;

  iVar9 = (((this->_base_AIState_Base).carObj_)->targetPos).y - piVar2[1];

  iVar3 = (((this->_base_AIState_Base).carObj_)->targetPos).z - piVar2[2];

  pCVar4 = (this->_base_AIState_Base).carObj_;

  iVar5 = (pCVar4->N).roadMatrix.m[0];

  if (iVar5 < 0) {

    iVar5 = iVar5 + 0xff;

  }

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar6 = (pCVar4->N).roadMatrix.m[1];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  if (iVar9 < 0) {

    iVar9 = iVar9 + 0xff;

  }

  iVar7 = (pCVar4->N).roadMatrix.m[2];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  pCVar4->targetLatPos =

       (iVar5 >> 8) * (iVar8 >> 8) + (iVar6 >> 8) * (iVar9 >> 8) + (iVar7 >> 8) * (iVar3 >> 8);

  pCVar4 = (this->_base_AIState_Base).carObj_;

  iVar9 = (pCVar4->targetPos).x - (pCVar4->N).position.x >> 0xc;

  pCVar4 = (this->_base_AIState_Base).carObj_;

  iVar8 = (pCVar4->targetPos).z - (pCVar4->N).position.z >> 0xc;

  if (iVar9 * iVar9 + iVar8 * iVar8 < 10000) {

    if (this->waitTick_ == 0) {

      this->waitTick_ = simGlobal.gameTicks + this->path_[this->pathIndex_].waitTime;

    }

    if (simGlobal.gameTicks < this->waitTick_) {

      ((this->_base_AIState_Base).carObj_)->desiredSpeed = 0;

    }

    else {

      this->waitTick_ = 0;

      this->pathIndex_ = this->pathIndex_ + 1;

    }

  }

  local_20[0] = 2;

  iVar8 = ((this->_base_AIState_Base).carObj_)->sortIndex + 1;

  ppCVar10 = Cars_gSortedList + iVar8;

  while ((iVar8 < Cars_gNumCars && (local_20[0] == 2))) {

    pCVar4 = *ppCVar10;

    ppCVar10 = ppCVar10 + 1;

    iVar8 = iVar8 + 1;

    this->CheckIfCarIsNearbyAndStop(pCVar4,local_20);

  }

  if (local_20[0] != 1) {

    local_20[0] = 2;

    iVar8 = ((this->_base_AIState_Base).carObj_)->sortIndex + -1;

    ppCVar10 = Cars_gSortedList + iVar8;

    while ((-1 < iVar8 && (local_20[0] == 2))) {

      pCVar4 = *ppCVar10;

      ppCVar10 = ppCVar10 + -1;

      iVar8 = iVar8 + -1;

      this->CheckIfCarIsNearbyAndStop(pCVar4,local_20);

    }

  }

  return;

}








/* ---- _._14AIState_Donuts  AIState_Donuts::dtor  [AISTATE.CPP:1248-1253] SLD-VERIFIED ---- */

AIState_Donuts::~AIState_Donuts()



{

  Car_tObj *pCVar1;


  

  pCVar1 = (this->_base_AIState_Base).carObj_;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_Donuts_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  ((this->_base_AIState_Base).carObj_)->targetLatPos = 0;

  ((this->_base_AIState_Base).carObj_)->donutMode = 0;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Donuts_vtable + 8);


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

  coorddef local_20;

  

  pCVar10 = (this->_base_AIState_Base).carObj_;

  iVar7 = (pCVar10->N).orientMat.m[6];

  iVar11 = (int)(pCVar10->N).simRoadInfo.slice;

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar1 = (pCVar10->N).roadMatrix.m[6];

  if (iVar1 < 0) {

    iVar1 = iVar1 + 0xff;

  }

  iVar8 = (pCVar10->N).orientMat.m[7];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar2 = (pCVar10->N).roadMatrix.m[7];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar9 = (pCVar10->N).orientMat.m[8];

  if (iVar9 < 0) {

    iVar9 = iVar9 + 0xff;

  }

  iVar3 = (pCVar10->N).roadMatrix.m[8];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar4 = 1;

  if ((iVar7 >> 8) * (iVar1 >> 8) + (iVar8 >> 8) * (iVar2 >> 8) + (iVar9 >> 8) * (iVar3 >> 8) < 1) {

    iVar4 = -1;

  }

  pCVar10->direction = iVar4;

  pCVar10->desiredDirection = iVar4;

  if ((this->donutMode_ == 1) || (this->donutMode_ == 3)) {

    pCVar10 = (this->_base_AIState_Base).carObj_;

    iVar7 = (pCVar10->N).orientMat.m[6];

    if (iVar7 < 0) {

      iVar7 = iVar7 + 0xff;

    }

    iVar1 = (pCVar10->N).roadMatrix.m[6];

    if (iVar1 < 0) {

      iVar1 = iVar1 + 0xff;

    }

    iVar8 = (pCVar10->N).orientMat.m[7];

    if (iVar8 < 0) {

      iVar8 = iVar8 + 0xff;

    }

    iVar2 = (pCVar10->N).roadMatrix.m[7];

    if (iVar2 < 0) {

      iVar2 = iVar2 + 0xff;

    }

    iVar9 = (pCVar10->N).orientMat.m[8];

    if (iVar9 < 0) {

      iVar9 = iVar9 + 0xff;

    }

    iVar3 = (pCVar10->N).roadMatrix.m[8];

    if (iVar3 < 0) {

      iVar3 = iVar3 + 0xff;

    }

    iVar4 = iVar11 + 3;

    if ((iVar7 >> 8) * (iVar1 >> 8) + (iVar8 >> 8) * (iVar2 >> 8) + (iVar9 >> 8) * (iVar3 >> 8) < 0)

    {

      iVar4 = iVar11 + -3;

      if (iVar4 < 0) {

        iVar4 = iVar11 + gNumSlices + -3;

      }

    }

    else if (gNumSlices <= iVar4) {

      iVar4 = iVar11 - (gNumSlices + -3);

    }

    piVar5 = (int *)(iVar4 * 0x20 + BWorldSm_slices);

    local_20.x = *piVar5;

    local_20.y = piVar5[1];

    local_20.z = piVar5[2];

    iVar7 = ((this->_base_AIState_Base).carObj_)->roadPosition;

    if (iVar7 < 0) {

      iVar7 = -iVar7;

    }

    iVar1 = 0;

    if ((this->donutMode_ == 1) && (iVar7 < 0x28000)) {

      this->donutMode_ = 2;

    }

  }

  else {

    iVar7 = this->donutLookForward_ + -0x10000;

    this->donutLookForward_ = iVar7;

    if (iVar7 < 0x8000) {

      randtemp = fastRandom * randSeed;

      fastRandom = randtemp & 0xffff;

      this->donutLookForward_ = ((randtemp >> 8 & 0xffff) * 5 >> 0xe) * 0x10000 + 0x140000;

    }

    pCVar10 = (this->_base_AIState_Base).carObj_;

    iVar1 = (pCVar10->N).orientMat.m[1];

    iVar8 = (pCVar10->N).orientMat.m[2];

    pCVar6 = (this->_base_AIState_Base).carObj_;

    iVar2 = (pCVar6->N).orientMat.m[6];

    iVar9 = (pCVar6->N).orientMat.m[7];

    iVar3 = (pCVar6->N).orientMat.m[8];

    iVar7 = fixedmult(0x60000,(pCVar10->N).orientMat.m[0]);

    iVar1 = fixedmult(0x60000,iVar1);

    iVar8 = fixedmult(0x60000,iVar8);

    iVar2 = fixedmult(this->donutLookForward_,iVar2);

    iVar9 = fixedmult(this->donutLookForward_,iVar9);

    local_20.z = fixedmult(this->donutLookForward_,iVar3);

    local_20.x = (((this->_base_AIState_Base).carObj_)->N).position.x + iVar7 + iVar2;

    local_20.y = (((this->_base_AIState_Base).carObj_)->N).position.y + iVar1 + iVar9;

    local_20.z = (((this->_base_AIState_Base).carObj_)->N).position.z + iVar8 + local_20.z;

    pCVar10 = (this->_base_AIState_Base).carObj_;

    iVar1 = Newton_CalculateRoadPositionFromSliceAndPosition((int)(pCVar10->N).simRoadInfo.slice,&local_20,&(pCVar10->N).roadMatrix);

    iVar7 = ((this->_base_AIState_Base).carObj_)->roadPosition;

    if (iVar7 < 0) {

      iVar11 = iVar11 * 0x20 + BWorldSm_slices;

      if ((int)-((u_int)*(u_char *)(iVar11 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar11 + 0x1d) >> 4)) <=

          iVar7 + -0x20000) goto LAB_800722ec;

    }

    else {

      iVar11 = iVar11 * 0x20 + BWorldSm_slices;

      if (iVar7 + 0x20000 <=

          (int)((u_int)*(u_char *)(iVar11 + 0x1f) * 0x8000 * (*(u_char *)(iVar11 + 0x1d) & 0xf)))

      goto LAB_800722ec;

    }

    this->donutMode_ = 1;

  }

LAB_800722ec:

  ((this->_base_AIState_Base).carObj_)->donutMode = this->donutMode_;

  AI_GenericBeginCycle((this->_base_AIState_Base).carObj_);

  AI_GenericCycle((this->_base_AIState_Base).carObj_);

  AI_GenericEndCycle((this->_base_AIState_Base).carObj_);

  pCVar10 = (this->_base_AIState_Base).carObj_;

  (pCVar10->targetPos).x = local_20.x;

  (pCVar10->targetPos).y = local_20.y;

  (pCVar10->targetPos).z = local_20.z;

  ((this->_base_AIState_Base).carObj_)->targetLatPos = iVar1;

  ((this->_base_AIState_Base).carObj_)->desiredSpeed = 0x471c7;

  return;

}








/* ---- __17AIState_GotoSliceP8Car_tObjii  AIState_GotoSlice::ctor  [AISTATE.CPP:1348-1351] SLD-VERIFIED ---- */

AIState_GotoSlice::AIState_GotoSlice(Car_tObj *carObj,int targetSlice,int stopWhenArrivedAtSlice)
  : _base_AIState_Normal(carObj)
{


  (this->_base_AIState_Normal)._base_AIState_Base._vf = (__vtbl_ptr_type (*) [4])AIState_GotoSlice_vtable;

  this->targetSlice_ = targetSlice;

  this->stopWhenArrivedAtSlice_ = stopWhenArrivedAtSlice;

  return;

}








/* ---- Execute__17AIState_GotoSlice  AIState_GotoSlice::Execute  [AISTATE.CPP:1355-1388] SLD-VERIFIED ---- */

void AIState_GotoSlice::Execute()



{
  int longMetersBetween;
  int distMeters;
  int cap;

  bool bVar1;

  int iVar2;

  Car_tObj *pCVar3;

  int iVar4;

  

  iVar2 = AIWorld_ApxSplineDistance(this->targetSlice_,(this->_base_AIState_Normal)._base_AIState_Base.carObj_);

  if (iVar2 < 0) {

    ((this->_base_AIState_Normal)._base_AIState_Base.carObj_)->desiredDirection = -1;

  }

  else {

    ((this->_base_AIState_Normal)._base_AIState_Base.carObj_)->desiredDirection = 1;

  }

  this->_base_AIState_Normal.Execute();

  if (this->stopWhenArrivedAtSlice_ != 0) {

    if (iVar2 < 0) {

      iVar2 = -iVar2;

    }

    iVar4 = 0xc80000;

    if (iVar2 < 0xc0000) {

      iVar4 = 0x40000;

    }

    else if (iVar2 < 0x320000) {

      iVar4 = 0x140000;

    }

    else if (iVar2 < 0x960000) {

      iVar4 = 0x280000;

    }

    else if (iVar2 < 0x1900000) {

      iVar4 = 0x500000;

    }

    pCVar3 = (this->_base_AIState_Normal)._base_AIState_Base.carObj_;

    iVar2 = pCVar3->desiredSpeed;

    if (iVar2 < 0) {

      iVar4 = -iVar4;

      bVar1 = iVar4 < iVar2;

    }

    else {

      bVar1 = iVar2 < iVar4;

    }

    if (bVar1) {

      iVar4 = iVar2;

    }

    pCVar3->desiredSpeed = iVar4;

  }

  return;

}








/* ---- InTargetSliceRange__17AIState_GotoSlicei  AIState_GotoSlice::InTargetSliceRange  [AISTATE.CPP:1395-1398] SLD-VERIFIED ---- */

int AIState_GotoSlice::InTargetSliceRange(int rangeMeters)



{
  int distanceMeters;

  int iVar1;

  

  iVar1 = AIWorld_ApxSplineDistance((this->_base_AIState_Normal)._base_AIState_Base.carObj_,this->targetSlice_);

  if (iVar1 < 0) {

    iVar1 = -iVar1;

  }

  return (u_int)(iVar1 < rangeMeters);

}








/* ---- __14AIState_CruiseP8Car_tObj12cruiseMode_ti  AIState_Cruise::ctor  [AISTATE.CPP:1403-1408] SLD-VERIFIED ---- */

AIState_Cruise::AIState_Cruise(Car_tObj *carObj,cruiseMode_t cruiseMode,int speedOrFactor)
  : _base_AIState_Normal(carObj)
{


  (this->_base_AIState_Normal)._base_AIState_Base._vf = (__vtbl_ptr_type (*) [4])AIState_Cruise_vtable;

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

  if (cVar2 == 1) {

    AISpeeds_CalcDesiredSpeed((this->_base_AIState_Normal)._base_AIState_Base.carObj_);

    iVar1 = fixedmult(((this->_base_AIState_Normal)._base_AIState_Base.carObj_)->desiredSpeed,

                       this->cruiseFactor_);

    ((this->_base_AIState_Normal)._base_AIState_Base.carObj_)->desiredSpeed = iVar1;

  }

  else if ((int)cVar2 < 2) {

    if (cVar2 == 0) {

      pCVar3 = (this->_base_AIState_Normal)._base_AIState_Base.carObj_;

      pCVar3->desiredSpeed = this->cruiseSpeed_ * pCVar3->direction;

    }

  }

  else if (cVar2 == 2) {

    AISpeeds_CalcTrafficTopSpeed((this->_base_AIState_Normal)._base_AIState_Base.carObj_);

  }

  AI_GenericBeginCycle((this->_base_AIState_Normal)._base_AIState_Base.carObj_);

  AI_GenericCycle((this->_base_AIState_Normal)._base_AIState_Base.carObj_);

  AI_GenericEndCycle((this->_base_AIState_Normal)._base_AIState_Base.carObj_);

  return;

}








/* ---- _._14AIState_Cruise  AIState_Cruise::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

AIState_Cruise::~AIState_Cruise()



{


  

  (this->_base_AIState_Normal)._base_AIState_Base._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Cruise_vtable + 8);


  return;

}








/* ---- _._17AIState_GotoSlice  AIState_GotoSlice::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

AIState_GotoSlice::~AIState_GotoSlice()



{


  

  (this->_base_AIState_Normal)._base_AIState_Base._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_GotoSlice_vtable + 8);


  return;

}








/* ---- TestForRelease__21AIState_RovingTraffic  AIState_RovingTraffic::TestForRelease  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

int AIState_RovingTraffic::TestForRelease()



{

  return this->pathIndex_ < this->numPathPoints_ ^ 1;

}








/* ---- _._21AIState_RovingTraffic  AIState_RovingTraffic::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

AIState_RovingTraffic::~AIState_RovingTraffic()



{

  Car_tObj *pCVar1;


  

  pCVar1 = (this->_base_AIState_Base).carObj_;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_RovingTraffic_vtable;

  (pCVar1->targetPos).z = 0;

  (pCVar1->targetPos).y = 0;

  (pCVar1->targetPos).x = 0;

  ((this->_base_AIState_Base).carObj_)->targetLatPos = 0;

  pCVar1 = (this->_base_AIState_Base).carObj_;

  pCVar1->carFlags = pCVar1->carFlags & 0xfffff7ff;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_RovingTraffic_vtable + 8);


  return;

}








/* ---- Execute__17AIState_NonActive  AIState_NonActive::Execute  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

void AIState_NonActive::Execute()



{

  return;

}








/* ---- _._17AIState_NonActive  AIState_NonActive::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

AIState_NonActive::~AIState_NonActive()



{


  

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_NonActive_vtable + 8);

  (((this->_base_AIState_Base).carObj_)->N).active = '\x01';

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_NonActive_vtable + 8);


  return;

}








/* ---- _._12AIState_Idle  AIState_Idle::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

AIState_Idle::~AIState_Idle()



{

  Car_tObj *pCVar1;


  

  pCVar1 = (this->_base_AIState_Base).carObj_;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

  pCVar1->carFlags = pCVar1->carFlags & 0xfffffbff;

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Idle_vtable + 8);


  return;

}








/* ---- _._14AIState_Normal  AIState_Normal::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

AIState_Normal::~AIState_Normal()



{


  

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Normal_vtable + 8);


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

  int forwardSlice;

  int distMeters;

  int cap;


  int trafficInWorld;

  int xDistance;

  int placementSide;

  int targettingStrength;

  int doBrake;

  int distanceAbsMeters;

  int slice;

  int currentBarrierLane;

  int sliceLoop;

  int barrierLane;

  int longPos;

  int backwardsBarrierEndSlice;

  int forwardBarrierEndSlice;

  coorddef centerBack;

  coorddef right;

  coorddef forward;

  coorddef targetPos;

  

  this->_vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Base_vtable + 8);


  return;

}







/* end of aistate.cpp */
