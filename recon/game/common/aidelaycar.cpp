/* game/common/aidelaycar.cpp -- RECONSTRUCTED (AIDelayCar helper class; C++ TU)
 *   3 fns: AIDelayCar standalone class (ctor/SetNewTargetCar/Update) -- a car that follows
 *   a basis car at a delay/offset. No base, no vtable (60-byte POD-ish). Faithful C++ (option A).
 *   NOT original; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "aidelaycar_types.h"
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
  this->targetCar_ = targetCar;

  this->deltaMeters_ = AIWorld_ApxSplineDistance(this->basisCar_,targetCar);

  this->slice_ = (int)(this->targetCar_->N).simRoadInfo.slice;

  (this->deltaPosition_).x = (this->basisCar_->N).position.x - (this->targetCar_->N).position.x;

  (this->deltaPosition_).y = (this->basisCar_->N).position.y - (this->targetCar_->N).position.y;

  (this->deltaPosition_).z = (this->basisCar_->N).position.z - (this->targetCar_->N).position.z;

  this->position_ = (this->targetCar_->N).position;

  this->deltaRoadPosition_ = this->basisCar_->roadPosition - this->targetCar_->roadPosition;

  this->roadPosition_ = this->targetCar_->roadPosition;

  this->laneIndex_ = this->targetCar_->laneIndex;

  this->currentSpeed_ = this->targetCar_->currentSpeed;

  return;

}








/* ---- Update__10AIDelayCar  AIDelayCar::Update  [AIDELAYCAR.CPP:46-75] SLD-VERIFIED ---- */

void AIDelayCar::Update()



{

  int currentDeltaRoadPosition;

  coorddef currentDeltaPosition;

  coorddef changeDeltaPosition;



  currentDeltaRoadPosition = AIWorld_ApxSplineDistance(this->targetCar_,this->basisCar_);

  currentDeltaRoadPosition = fixedmult(currentDeltaRoadPosition - this->deltaMeters_,this->delayFactor_);

  this->deltaMeters_ = this->deltaMeters_ + currentDeltaRoadPosition;

  currentDeltaRoadPosition = this->deltaMeters_ / 0x60000;

  if (0 <= currentDeltaRoadPosition) {

    /* Preserve the original add operand order emitted by PsyQ cc1plus. */
    currentDeltaRoadPosition = (this->basisCar_->N).simRoadInfo.slice - -currentDeltaRoadPosition;

    if (gNumSlices <= currentDeltaRoadPosition) {

      currentDeltaRoadPosition = currentDeltaRoadPosition - gNumSlices;

    }

  }

  else {

    /* Same compiler-stable addition form as the nonnegative arm. */
    currentDeltaRoadPosition = (this->basisCar_->N).simRoadInfo.slice - -currentDeltaRoadPosition;

    if (currentDeltaRoadPosition < 0) {

      currentDeltaRoadPosition = currentDeltaRoadPosition + gNumSlices;

    }

  }

  this->slice_ = currentDeltaRoadPosition;

  currentDeltaPosition.x = (this->targetCar_->N).position.x - (this->basisCar_->N).position.x;

  currentDeltaPosition.y = (this->targetCar_->N).position.y - (this->basisCar_->N).position.y;

  currentDeltaPosition.z = (this->targetCar_->N).position.z - (this->basisCar_->N).position.z;

  changeDeltaPosition.x = currentDeltaPosition.x - (this->deltaPosition_).x;

  changeDeltaPosition.y = currentDeltaPosition.y - (this->deltaPosition_).y;

  changeDeltaPosition.z = currentDeltaPosition.z - (this->deltaPosition_).z;

  (this->deltaPosition_).x = (this->deltaPosition_).x + fixedmult(changeDeltaPosition.x,this->delayFactor_);

  (this->deltaPosition_).y = (this->deltaPosition_).y + fixedmult(changeDeltaPosition.y,this->delayFactor_);

  (this->deltaPosition_).z = (this->deltaPosition_).z + fixedmult(changeDeltaPosition.z,this->delayFactor_);

  (this->position_).x = (this->basisCar_->N).position.x + (this->deltaPosition_).x;

  (this->position_).y = (this->basisCar_->N).position.y + (this->deltaPosition_).y;

  (this->position_).z = (this->basisCar_->N).position.z + (this->deltaPosition_).z;

  currentDeltaRoadPosition = (this->targetCar_->roadPosition - this->basisCar_->roadPosition) -

                             this->deltaRoadPosition_;

  this->deltaRoadPosition_ = this->deltaRoadPosition_ + fixedmult(currentDeltaRoadPosition,this->delayFactor_);

  this->roadPosition_ = this->basisCar_->roadPosition + this->deltaRoadPosition_;

  this->laneIndex_ = AIWorld_LaneIndex(this->slice_,this->roadPosition_);

  this->currentSpeed_ = this->currentSpeed_ + fixedmult(this->targetCar_->currentSpeed - this->currentSpeed_,this->delayFactor_);

  return;

}







/* end of aidelaycar.cpp */
