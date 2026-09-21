/* game/common/aidelaycar.cpp -- RECONSTRUCTED (AIDelayCar helper class; C++ TU)
 *   3 fns: AIDelayCar standalone class (ctor/SetNewTargetCar/Update) -- a car that follows
 *   a basis car at a delay/offset. No base, no vtable (60-byte POD-ish). Faithful C++ (option A).
 *   NOT original; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "aidelaycar_types.h"
#include "aidelaycar_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80054DB0): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* EA slice wrapping, also retained in the symbol-bearing NFS2 source. */
#define WRAP_SLICE(a,b) (((a) >= 0) \
    ? ((((b) + (a)) >= gNumSlices) ? ((b) + (a)) - gNumSlices : ((b) + (a))) \
    : ((((b) + (a)) < 0) ? ((b) + (a)) + gNumSlices : ((b) + (a))))


/* ---- __10AIDelayCarP8Car_tObjT1i  AIDelayCar::ctor  [AIDELAYCAR.CPP:20-25] SLD-VERIFIED ---- */
AIDelayCar::AIDelayCar(Car_tObj *basisCar,Car_tObj *targetCar,int delayFactor)
{


  this->delayFactor_ = delayFactor;
  this->basisCar_ = basisCar;
  this->SetNewTargetCar(targetCar);
}








/* ---- SetNewTargetCar__10AIDelayCarP8Car_tObj  AIDelayCar::SetNewTargetCar  [AIDELAYCAR.CPP:29-42] SLD-VERIFIED ---- */

void AIDelayCar::SetNewTargetCar(Car_tObj *targetCar)
{


  this->targetCar_ = targetCar;
  this->deltaMeters_ = AIWorld_ApxSplineDistance(this->basisCar_,targetCar);
  this->slice_ = (int)(this->targetCar_->N).simRoadInfo.slice;

  (this->deltaPosition_).x = (this->basisCar_->N).position.x - (this->targetCar_->N).position.x, (this->deltaPosition_).y = (this->basisCar_->N).position.y - (this->targetCar_->N).position.y, (this->deltaPosition_).z = (this->basisCar_->N).position.z - (this->targetCar_->N).position.z;
  this->position_ = (this->targetCar_->N).position;

  this->deltaRoadPosition_ = this->basisCar_->roadPosition - this->targetCar_->roadPosition;
  this->roadPosition_ = this->targetCar_->roadPosition;
  this->laneIndex_ = this->targetCar_->laneIndex;
  this->currentSpeed_ = this->targetCar_->currentSpeed;
}








/* ---- Update__10AIDelayCar  AIDelayCar::Update  [AIDELAYCAR.CPP:46-75] SLD-VERIFIED ---- */

void AIDelayCar::Update()
{
  coorddef currentDeltaPosition, changeDeltaPosition;
  int currentDeltaMeters = AIWorld_ApxSplineDistance(this->targetCar_,this->basisCar_); /* Inferred result name; SLD48/50 separates distance query and correction. Optimized out of native debug records. */

  this->deltaMeters_ += fixedmult(currentDeltaMeters - this->deltaMeters_,this->delayFactor_);

  this->slice_ = WRAP_SLICE(this->deltaMeters_ / 0x60000,(int)(this->basisCar_->N).simRoadInfo.slice);



  currentDeltaPosition.x = (this->targetCar_->N).position.x - (this->basisCar_->N).position.x, currentDeltaPosition.y = (this->targetCar_->N).position.y - (this->basisCar_->N).position.y, currentDeltaPosition.z = (this->targetCar_->N).position.z - (this->basisCar_->N).position.z;

  changeDeltaPosition.x = currentDeltaPosition.x - (this->deltaPosition_).x, changeDeltaPosition.y = currentDeltaPosition.y - (this->deltaPosition_).y, changeDeltaPosition.z = currentDeltaPosition.z - (this->deltaPosition_).z;

  (this->deltaPosition_).x = (this->deltaPosition_).x + fixedmult(changeDeltaPosition.x,this->delayFactor_);
  (this->deltaPosition_).y = (this->deltaPosition_).y + fixedmult(changeDeltaPosition.y,this->delayFactor_);
  (this->deltaPosition_).z = (this->deltaPosition_).z + fixedmult(changeDeltaPosition.z,this->delayFactor_);

  (this->position_).x = (this->basisCar_->N).position.x + (this->deltaPosition_).x, (this->position_).y = (this->basisCar_->N).position.y + (this->deltaPosition_).y, (this->position_).z = (this->basisCar_->N).position.z + (this->deltaPosition_).z;


  int currentDeltaRoadPosition = this->targetCar_->roadPosition - this->basisCar_->roadPosition;

  this->deltaRoadPosition_ += fixedmult(currentDeltaRoadPosition - this->deltaRoadPosition_,this->delayFactor_);
  this->roadPosition_ = this->basisCar_->roadPosition + this->deltaRoadPosition_;

  this->laneIndex_ = AIWorld_LaneIndex(this->slice_,this->roadPosition_);


  this->currentSpeed_ = this->currentSpeed_ + fixedmult(this->targetCar_->currentSpeed - this->currentSpeed_,this->delayFactor_);
}







/* end of aidelaycar.cpp */
