/* game/common/aidelaycar.cpp -- RECONSTRUCTED (AIDelayCar helper class; C++ TU)
 *   3 fns: AIDelayCar standalone class (ctor/SetNewTargetCar/Update) -- a car that follows
 *   a basis car at a delay/offset. No base, no vtable (60-byte POD-ish). Faithful C++ (option A).
 *   NOT original; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../nfs4_types.h"
#include "aidelaycar_externs.h"


/* ---- __10AIDelayCarP8Car_tObjT1i  AIDelayCar::ctor  [AIDELAYCAR.CPP:20-25] SLD-VERIFIED ---- */
AIDelayCar::AIDelayCar(Car_tObj *basisCar,Car_tObj *targetCar,int delayFactor)



{

  this->basisCar_ = basisCar;

  this->delayFactor_ = delayFactor;

  this->SetNewTargetCar(targetCar);

  return;

}








/* ---- SetNewTargetCar__10AIDelayCarP8Car_tObj  AIDelayCar::SetNewTargetCar  [AIDELAYCAR.CPP:29-42] SLD-VERIFIED ---- */

void AIDelayCar::SetNewTargetCar(Car_tObj *targetCar)



{

  int iVar1;

  Car_tObj *pCVar2;

  int iVar3;

  

  this->targetCar_ = targetCar;

  iVar1 = AIWorld_ApxSplineDistance(this->basisCar_,targetCar);

  this->deltaMeters_ = iVar1;

  this->slice_ = (int)(this->targetCar_->N).simRoadInfo.slice;

  (this->deltaPosition_).x = (this->basisCar_->N).position.x - (this->targetCar_->N).position.x;

  (this->deltaPosition_).y = (this->basisCar_->N).position.y - (this->targetCar_->N).position.y;

  pCVar2 = this->targetCar_;

  (this->deltaPosition_).z = (this->basisCar_->N).position.z - (this->targetCar_->N).position.z;

  iVar1 = (pCVar2->N).position.y;

  iVar3 = (pCVar2->N).position.z;

  (this->position_).x = (pCVar2->N).position.x;

  (this->position_).y = iVar1;

  (this->position_).z = iVar3;

  pCVar2 = this->targetCar_;

  this->deltaRoadPosition_ = this->basisCar_->roadPosition - this->targetCar_->roadPosition;

  this->roadPosition_ = pCVar2->roadPosition;

  this->laneIndex_ = pCVar2->laneIndex;

  this->currentSpeed_ = pCVar2->currentSpeed;

  return;

}








/* ---- Update__10AIDelayCar  AIDelayCar::Update  [AIDELAYCAR.CPP:46-75] SLD-VERIFIED ---- */

void AIDelayCar::Update()



{

  int iVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int currentDeltaRoadPosition;

  Car_tObj *pCVar7;

  int iVar8;

  coorddef currentDeltaPosition;

  coorddef changeDeltaPosition;

  

  iVar1 = AIWorld_ApxSplineDistance(this->targetCar_,this->basisCar_);

  iVar1 = fixedmult(iVar1 - this->deltaMeters_,this->delayFactor_);

  iVar1 = this->deltaMeters_ + iVar1;

  this->deltaMeters_ = iVar1;

  iVar1 = iVar1 / 0x60000;

  if (iVar1 < 0) {

    iVar1 = (this->basisCar_->N).simRoadInfo.slice + iVar1;

    if (iVar1 < 0) {

      iVar1 = iVar1 + gNumSlices;

    }

  }

  else {

    iVar1 = (this->basisCar_->N).simRoadInfo.slice + iVar1;

    if (gNumSlices <= iVar1) {

      iVar1 = iVar1 - gNumSlices;

    }

  }

  this->slice_ = iVar1;

  iVar8 = (this->targetCar_->N).position.y;

  iVar1 = (this->basisCar_->N).position.y;

  iVar6 = (this->targetCar_->N).position.z;

  iVar2 = (this->basisCar_->N).position.z;

  iVar3 = (this->deltaPosition_).y;

  iVar4 = (this->deltaPosition_).z;

  iVar5 = fixedmult(((this->targetCar_->N).position.x - (this->basisCar_->N).position.x) -

                     (this->deltaPosition_).x,this->delayFactor_);

  (this->deltaPosition_).x = (this->deltaPosition_).x + iVar5;

  iVar1 = fixedmult((iVar8 - iVar1) - iVar3,this->delayFactor_);

  iVar3 = this->delayFactor_;

  (this->deltaPosition_).y = (this->deltaPosition_).y + iVar1;

  iVar1 = fixedmult((iVar6 - iVar2) - iVar4,iVar3);

  pCVar7 = this->basisCar_;

  (this->deltaPosition_).z = (this->deltaPosition_).z + iVar1;

  (this->position_).x = (pCVar7->N).position.x + (this->deltaPosition_).x;

  (this->position_).y = (pCVar7->N).position.y + (this->deltaPosition_).y;

  iVar1 = this->delayFactor_;

  (this->position_).z = (pCVar7->N).position.z + (this->deltaPosition_).z;

  iVar1 = fixedmult((this->targetCar_->roadPosition - pCVar7->roadPosition) -

                     this->deltaRoadPosition_,iVar1);

  iVar1 = this->deltaRoadPosition_ + iVar1;

  this->deltaRoadPosition_ = iVar1;

  iVar1 = this->basisCar_->roadPosition + iVar1;

  this->roadPosition_ = iVar1;

  iVar1 = AIWorld_LaneIndex(this->slice_,iVar1);

  this->laneIndex_ = iVar1;

  iVar1 = fixedmult(this->targetCar_->currentSpeed - this->currentSpeed_,this->delayFactor_);

  this->currentSpeed_ = this->currentSpeed_ + iVar1;

  return;

}







/* end of aidelaycar.cpp */
