/* Retail supplies this TU identity. Keep it ahead of local inline definitions
 * as well as callers:mixing checkout/retail filenames changes inline debug
 * scope attribution. Only separately verified function coordinates are sealed;
 * this boundary does not certify the original full-file text or layout. */
#line 1 "C:/nfs4/GAME/COMMON/AISTATE.CPP"
/* game/common/aistate.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Polymorphic C++ inheritance (the former composition model was converted in July).
 *   GCC-v2 vtable/destructor ABI; retained explicit ABI bridges are documented per body.
 *   Reconstructed C++: original source spelling/layout remains separately reviewable.
 *   Only current per-function receipts certify byte/SYM/SLD matching;no whole-file claim.
 */
#include "../../lib/nfs4_new.h"
#include "aistate_types.h"
#include "aistate_externs.h"

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int GameTicks(void) { return simGlobal.gameTicks; }


/* Retail aistate.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


/* ---- aistate.obj-owned globals (.bss zero) ---- */
static int   AIState_Purgatory_numTrafficCarsInPurgatory;   /* @0x8013dd7c  (bss(zero); SYM STAT) */


/* w60 link-debt fix (W60-A8 finding, user-unblocked): the canonical
 * Execute__17AIState_NonActive / ___17AIState_NonActive pair (@0x8005F624/62C)
 * was over-emitted by THREE objects.  aih_btccop.cpp owns those VAs (its own
 * banners + SLD adjacency); this TU keeps only its VA-suffixed vague-linkage
 * instances (Execute__17AIState_NonActive_80072750 etc., see the tail block).
 * The canonical definitions that lived here were removed; the file's old tail
 * comment ("the canonicals live in THIS TU") is superseded by this note. */


/* ---- AIState_StartUp__Fv  AIState_StartUp  [AISTATE.CPP:25-26] ----
 * One call and implicit void fallthrough: 8/8 instructions and 0/8 retail
 * relative SLD differences, with exact block/function-end line records. */
#line 25 "C:/nfs4/GAME/COMMON/AISTATE.CPP"
void AIState_StartUp(void) {
  AIState_Purgatory::StartUp(); }








/* ---- AIState_Restart__Fv  AIState_Restart  [AISTATE.CPP:30-31] ----
 * Same source shape and exact 8-word / native-SYM / relative-SLD receipt as
 * AIState_StartUp; literal whitespace of the original text is unknown. */
void AIState_Restart(void) {
  AIState_Purgatory::StartUp(); }








/* ---- AIState_CleanUp__Fv  AIState_CleanUp  [AISTATE.CPP:36-37] SLD-VERIFIED ---- */

void AIState_CleanUp(void) {
}








/* ---- StateExecute__12AIState_Base  AIState_Base::StateExecute  [AISTATE.CPP:56-66] SLD-VERIFIED ---- */

void AIState_Base::StateExecute()



{
  if ((((this->carObj_->N).active != '\0') && ((this->carObj_->carFlags & 4U) == 0)) &&





     ((this->carObj_->N).deadTimer == 0)) {
    AIScript_ProcessActionsAndReactions(&this->carObj_->script,AI_elapsedTime);
  }
  this->Execute();
}








/* ---- __12AIState_BaseP8Car_tObj  AIState_Base::ctor  [AISTATE.CPP:73-74] SLD-VERIFIED ---- */

AIState_Base::AIState_Base(Car_tObj *carObj) {
  this->carObj_ = carObj;
}








/* ---- Execute__14AIState_Normal  AIState_Normal::Execute  [AISTATE.CPP:94-101] SLD-VERIFIED ---- */

void AIState_Normal::Execute()



{

  AISpeeds_CalcDesiredSpeed(this->carObj_);


  AI_GenericBeginCycle(this->carObj_);
  AI_GenericCycle(this->carObj_);
  AI_GenericEndCycle(this->carObj_);
}








/* ---- __14AIState_NormalP8Car_tObj  AIState_Normal::ctor  [AISTATE.CPP:105-110] SLD-VERIFIED ---- */

AIState_Normal::AIState_Normal(Car_tObj *carObj)
  : AIState_Base(carObj)
{

  (this->carObj_)->targetPos.x = (this->carObj_)->targetPos.y = (this->carObj_)->targetPos.z = 0;
  (this->carObj_)->targetLatPos = 0;
  ((this->carObj_)->N).active = '\x01';
}








/* ---- Execute__12AIState_Idle  AIState_Idle::Execute  [retail AISTATE.CPP:129-149; native/byte verified, SLD attribution open] ---- */

void AIState_Idle::Execute()



{



  if (this->idleInPlaceFlag_ != 0) {

    (this->carObj_)->desiredSpeed = 0;

    (this->carObj_)->desiredLatPos = (this->carObj_)->roadPosition;

  }

  else {
    int off;
    /* Retail owns off in this else region (+040..+0ac), not at root. */
    if (((this->carObj_)->roadPosition - this->roadPosition_) + 0xffffU < 0x1ffff) {

      (this->carObj_)->desiredSpeed = 0;

    }

    else {

      AISpeeds_CalcDesiredSpeed(this->carObj_);

      off = (this->carObj_)->desiredSpeed;

      if (off < 0) {

        off = off + 3;

      }

      (this->carObj_)->desiredSpeed = off >> 2;

    }

    (this->carObj_)->desiredLatPos = this->roadPosition_;

  }

  return;

}








/* ---- SetIdlePosition__12AIState_Idlei  AIState_Idle::SetIdlePosition  [AISTATE.CPP:154-156] SLD-VERIFIED ---- */

void AIState_Idle::SetIdlePosition(int roadPosition) {
  this->roadPosition_ = roadPosition;
  this->idleInPlaceFlag_ = 0;
}








/* ---- __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii [AISTATE.CPP:180-201] ---- */
/* 2026-10-16: real member initialization and the sibling AI direction comparison
 * remove placement-new, reverseDirCheck and direction without changing any
 * normal-object byte. Retail has fourteen parameter records and one root
 * region, no caller locals or inline allocation/default-constructor pairs.
 * Old carrier/placement necessity claims were shape-specific; prior source
 * and receipts survive in build/nc12/aistate_before_chase_member_init_20261016.cpp.
 * One epilogue instruction tag and the closing block's line remain unsealed;
 * do not add line padding or claim that native declaration PASS recovers text. */

AIState_Chase::AIState_Chase(Car_tObj *carObj,Car_tObj *targetCar,coorddef *relPosition,
          int nitrousTicks,int nitrousMinForeDistance,int nitrousMinAftDistance,int aggressionLevel,
          int delayTime)
  : AIState_Base(carObj),
    delayCar_(carObj,targetCar,delayTime)
{
  this->nitrousTicks_ = nitrousTicks;

  this->SetTarget(targetCar,relPosition);
  (this->carObj_)->accNitrous = 0x10000;
  (this->carObj_)->speedNitrous = 0x10000;
  this->nitrousMinForeDistance_ = nitrousMinForeDistance;
  this->nitrousMinAftDistance_ = nitrousMinAftDistance;
  this->aggressionLevel_ = aggressionLevel;
  this->slowDownEndTime_ = 0;
  if (this->carObj_->direction != (GameSetup_gData.reverseTrack == 0 ? 1 : -1))
  {
    this->noTurnAroundEndTime_ = 0;
  }
  else
  {
    this->noTurnAroundEndTime_ = 0;
  }
  this->barrierTicks32_ = 0;
  return;
}








/* ---- _._13AIState_Chase  AIState_Chase::dtor  [AISTATE.CPP:205-212] SLD-VERIFIED ---- */
/* The owner graph now exposes this as the real member destructor; GCC supplies
   its implicit receiver and in-charge deletion sequence. */

AIState_Chase::~AIState_Chase()



{

  (this->carObj_)->targetPos.x =
      (this->carObj_)->targetPos.y =
      (this->carObj_)->targetPos.z = 0;

  (this->carObj_)->targetLatPos = 0;

  (this->carObj_)->preferredLateralPosition = 0;

  (this->carObj_)->preferredLateralPositionPower = 0;

  (this->carObj_)->accNitrous = 0x10000;

  (this->carObj_)->speedNitrous = 0x10000;


  return;

}








/* ---- SetTarget__13AIState_ChaseP8Car_tObjP8coorddef  AIState_Chase::SetTarget  [AISTATE.CPP:216-237] SLD-VERIFIED ---- */

void AIState_Chase::SetTarget(Car_tObj *targetCar,coorddef *relPosition)



{
  if (this->targetCar_ != targetCar) {

    (&this->delayCar_)->SetNewTargetCar(targetCar)

    ;

  }

  this->targetCar_ = targetCar;

  this->relPosition_ = *relPosition;

  this->longTargetRegion_ = 0;

  this->latTargetRegion_ = 0;

  if (this->relPosition_.x < -this->targetCar_->N.dimension.x) {

    this->latTargetRegion_ = -1;

  }

  else if (this->targetCar_->N.dimension.x < this->relPosition_.x) {

    this->latTargetRegion_ = 1;

  }

  if (this->relPosition_.z < -this->targetCar_->N.dimension.z) {

    this->longTargetRegion_ = -1;

  }

  else if (this->targetCar_->N.dimension.z < this->relPosition_.z) {

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
}








/* ---- SetUp__13AIState_Chase [retail AISTATE.CPP:252-282;87-word complete supplied contract] ---- */

/* Retail has four variable-free inline pairs,not their literal API names.
   Real speed/road/slice reads and the lateral-distance store reproduce them.
   Names are inferred from actual field operations;computed arguments leave
   no caller capture. The existing road-position member replaces a wrapper. */
static inline void AIState_SetLateralDistance(int &destination, int distance) { destination = distance; }
static inline int DelayCarSpeed(AIDelayCar *d) { return d->currentSpeed_; }
inline int AIDelayCar::GetRoadPosition() { return roadPosition_; }
static inline int DelayCarSlice(AIDelayCar *d) { return d->slice_; }

/* 2026-10-30: joint real getter/store ownership fixes the old pair mismatch.
 * All87 tags,18 block records,provided locals/frame/end match. Reuse of the
 * existing member also removes one excess AIDelayCar completed-type record.
 * Literal inline API/header/macro identity is not uniquely retained.
 * Receipt:build/nc12/aistate_setup_source_20261030/final-proof.json. */
#line 251 "C:/nfs4/GAME/COMMON/AISTATE.CPP"
void AIState_Chase::SetUp()
{
  coorddef targetCarPosition;
  this->delayCar_.Update();
  this->carDir_ = (-1 < this->carObj_->currentSpeed) ? 1 : -1;
  this->targetDir_ = (-1 < DelayCarSpeed(&this->delayCar_)) ? 1 : -1;
  AIState_SetLateralDistance(this->latMetersBetween_, this->carObj_->roadPosition - this->delayCar_.GetRoadPosition()); targetCarPosition = this->delayCar_.position_;




  this->longMetersBetween_ = AIWorld_SplineDistance(this->carObj_,DelayCarSlice(&this->delayCar_),&targetCarPosition);

  this->carObj_->targetPos.x = this->carObj_->targetPos.y = this->carObj_->targetPos.z = 0;
  this->carObj_->targetLatPos = 0;
  if ((this->murderMode_ != 0) && (!(simGlobal.gameTicks < this->murderEndTime_))) {

    this->murderMode_ = 0;
    this->murderEndTime_ = 0;
  }


  if (this->carObj_->accNitrous != 0x10000) {

    this->nitrousTicks_ = this->nitrousTicks_ - AI_elapsedTime;
  }


  this->carObj_->accNitrous = 0x10000;
  this->carObj_->speedNitrous = 0x10000;
  this->carObj_->preferredLateralPosition = 0;
  this->carObj_->preferredLateralPositionPower = 0; return; }








/* ---- DoSlowNitrous__13AIState_Chase  AIState_Chase::DoSlowNitrous  [AISTATE.CPP:287-292] SLD-VERIFIED ---- */

void AIState_Chase::DoSlowNitrous()



{



  (this->carObj_)->accNitrous = 0x8000;
  (this->carObj_)->speedNitrous = 0xc000;
}








/* ---- DoNitrous__13AIState_Chasei [AISTATE.CPP:296-318;83-word PASS,
 * native declarations/scopes exact; full SLD remains open] ----
 * The real integer timer predicate removes the unrecorded currentTick capture
 * while retaining tick-before-deadline loads and the inline Chase receiver.
 * IsSlowingDown's name/signature are inferred from that operation, not a
 * surviving method symbol. A bool-returning version was3dif/84; the direct
 * two-operand comparison was2dif/83 due to inline expansion/load ordering.
 * No reference fence, dummy use, qualifier or output rewrite is required. */

void AIState_Chase::DoNitrous(int checkForHumans)



{
  if (this->nitrousTicks_ > 0 && !this->IsSlowingDown()) {

    (this->carObj_)->accNitrous = 0x30000;

    (this->carObj_)->speedNitrous = 0x28000;

    for (int humanLoop = 0; ; humanLoop++) {
      int distanceMeters;

      if (checkForHumans == 0) {

        break;

      }

      if (Cars_gNumHumanRaceCars <= humanLoop) {

        break;

      }

      distanceMeters = AIWorld_ApxSplineDistance(this->carObj_,Cars_gHumanRaceCarList[humanLoop]);
      distanceMeters = distanceMeters * this->carObj_->direction;

      if ((0 < distanceMeters) && (distanceMeters < this->nitrousMinForeDistance_)) {

        (this->carObj_)->accNitrous = 0x10000;

        (this->carObj_)->speedNitrous = 0x10000;

      }

      if ((distanceMeters < 0) && (-this->nitrousMinAftDistance_ < distanceMeters)) {

        (this->carObj_)->accNitrous = 0x10000;

        (this->carObj_)->speedNitrous = 0x10000;

      }

    }

  }

}








/* ---- Execute__13AIState_Chase [AISTATE.CPP:327-401;93-word PASS] ----
 * 2026-10-30: ordinary targeting branches remove both unprovided address
 * labels. Two genuine FarTargeting calls merge to the original shared call;
 * no new source object or artificial control/work is involved. All supplied
 * names,homes,owners,frame,regions and93 absolute word/file tags match.
 * IsSlowingDown still names an inferred real timer predicate;its original
 * inline spelling/signature and literal macro/comments are not uniquely
 * retained. Receipt:build/nc12/aistate_chase_source_20261030/final-proof.json. */

#line 326 "C:/nfs4/GAME/COMMON/AISTATE.CPP"
void AIState_Chase::Execute()
{
  int far;
  int velocityToHitInTime;
  int deltaVelocity;
  int targetCarVerySlow;
  this->SetUp();









  velocityToHitInTime = fixedmult(this->longMetersBetween_,0x666);
  velocityToHitInTime = __builtin_abs(velocityToHitInTime);
  deltaVelocity = this->carObj_->currentSpeed - this->targetCar_->currentSpeed;
  deltaVelocity = __builtin_abs(deltaVelocity);



  far = (deltaVelocity < velocityToHitInTime) && (0x8c0000 < __builtin_abs(this->longMetersBetween_));




  targetCarVerySlow = __builtin_abs(this->targetCar_->currentSpeed); targetCarVerySlow = !(0x6aaa9 < targetCarVerySlow);



  if (far != 0) {
    this->FarTargeting();






  } else if ((this->carDir_ * this->targetDir_ == 1) && (targetCarVerySlow == 0)) {




    this->CloseTargeting();


  } else if ((-1 < this->carDir_ * this->longMetersBetween_) && (targetCarVerySlow == 0)) {




    this->FarTargeting();




  } else if ((0x1aaaaa < deltaVelocity) || (far != 0) || (0x500000 < __builtin_abs(this->longMetersBetween_))) {




    this->ApproachTargeting(0);





  } else {
    this->ApproachTargeting(1);

  }

  if (this->IsSlowingDown()) {
    this->DoSlowNitrous(); } return; }








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
  int absLongMetersBetween;
  int slowDown;



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








/* ---- CloseTargeting__13AIState_Chase [AISTATE.CPP:462-632; source/SLD recovery open] ---- */
/* 2026-10-16: three actual speed-getter calls in one conditional expression
 * restore retail's three receiver-free inline pairs. The positive force-long
 * guard restores superSlowDown's depth and removes the old jump label, with
 * the entire normal ELF unchanged. A missing sibling region still changes
 * its owner path; t and full SLD remain unresolved. Road-position getters
 * and signed bound-first clamps now remove all four lateral carriers and
 * both fences without changing any normal-object byte.
 * Historical measurements below are not original-source/object exemptions. */

/* Inferred accessor spelling: the surviving inline records do not name it. */
inline int AIDelayCar::GetCurrentSpeed() { return currentSpeed_; }


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
  latPos = 0;
  longPos = 0;
  dir = (this->carObj_)->direction;

  this->DoNitrous(1);

  bigLongPos = 0;
  if (this->murderMode_ != 0) {
    longTarget = 0;
    latTarget = 0;
    this->DoNitrous(0);
  }
  else {
    latTarget = this->latTargetRegion_;
    longTarget = this->longTargetRegion_;
  }

  {
    if (this->latMetersBetween_ * dir < -(this->targetCar_->N).dimension.x) {
      latPos = -1;
    }
    else if ((this->targetCar_->N).dimension.x < this->latMetersBetween_ * dir) {
      latPos = 1;
    }
  }

  {
    if (this->longMetersBetween_ * dir < 0x20000 - (this->targetCar_->N).dimension.z) {
      longPos = -1;
    }
    else if ((this->targetCar_->N).dimension.z + 0x20000 < this->longMetersBetween_ * dir) {
      longPos = 1;
    }
  }

  {
    if (this->longMetersBetween_ * dir < -((this->targetCar_->N).dimension.z + 0x20000)) {
      bigLongPos = -1;
    }
    else if ((this->targetCar_->N).dimension.z + 0x20000 < this->longMetersBetween_ * dir) {
      bigLongPos = 1;
    }
  }

  if ((latPos == latTarget) && (longPos == longTarget)) {
    this->inTargetRegion_ = this->inTargetRegion_ + AI_elapsedTime;
  }
  else {
    this->inTargetRegion_ = 0;
  }

  forceLongAction = 0;
  forceLatAction = 0;
  doLatAction = 1;

  if (bigLongPos * longTarget == -1) {
    forceLatAction = latTarget;
    if (latTarget == 0) {
      forceLatAction = -1;
    }
  }
  else if ((latPos * latTarget == -1) && (bigLongPos == 0)) {
    forceLongAction = -1;
    doLatAction = 0;
  }
  else if ((latTarget == 0) && ((bigLongPos == 0 && (this->murderMode_ == 0)))) {
    doLatAction = 0;
  }
  else if ((longTarget == 1) && (((bigLongPos == 1 && (latPos == 0)) && (this->longMetersBetween_ < 0x140000)))
          ) {
    forceLongAction = -2;
  }

  desiredSpeed = this->delayCar_.GetCurrentSpeed() > 0
      ? this->delayCar_.GetCurrentSpeed() : -this->delayCar_.GetCurrentSpeed();

  if ((longPos < longTarget) || (forceLongAction == 1)) {
    desiredSpeed = fixedmult(desiredSpeed,0x16666);
  }
  else if (((longTarget < longPos) || (forceLongAction == -1)) ||
          ((0x140000 < this->longMetersBetween_ &&
           (((0x9ffff < this->longMetersBetween_ || (latPos != 0)) || (latTarget == 0)))))) {
    desiredSpeed = fixedmult(desiredSpeed,this->CalculateCloseTargettingAheadSlowDownFactor());
  }
  else {
    if (forceLongAction == -2)
    {
      int superSlowDown;
      if (this->aggressionLevel_ != 0) {
        superSlowDown = 0xa666;
        if (this->aggressionLevel_ == 1) {
          superSlowDown = 0xbae1;
        }
      }
      else {
        superSlowDown = 0xca3d;
      }
      desiredSpeed = fixedmult(desiredSpeed,superSlowDown);
    }
  }

  AISpeeds_CalcDesiredSpeed(this->carObj_);

  (this->carObj_)->desiredSpeed = __builtin_abs((this->carObj_)->desiredSpeed);

  {
    /* SOURCE-REVIEW-UNRESOLVED: t has no retail caller-local record. After
       restoring the speed getter, direct clamp forms still differ (22/300,
       split assignment13/299, void-arm products121/305). Those finite
       failures do not prove that an original source object was required. */
    int t = (this->carObj_)->desiredSpeed;
    if (desiredSpeed < t) {
      t = desiredSpeed;
    }
    desiredSpeed = t;
    t = 0x50000;
    if (0x4ffff < desiredSpeed) {
      t = desiredSpeed;
    }
    desiredSpeed = t * dir;
    (this->carObj_)->desiredSpeed = desiredSpeed;
  }

  AI_GenericBeginCycle(this->carObj_);

  if (doLatAction) {
    int targettingStrength;
    int targetLanePosition;
    /* Retail has only these two lateral locals. The three getter call sites
       reproduce its guarded inline groups; their original name is unknown.
       Previous staged-offset/fence necessity claims were source-shape-specific;
       the prior body is backed up in build/nc12/aistate_before_lateral_getters_20261016.cpp. */

    targettingStrength = 0xf0000;
    if (this->murderMode_ != 0) {
      targettingStrength = 0x1e0000;
      targetLanePosition = this->delayCar_.GetRoadPosition();
    }
    else {
      if (forceLatAction != 0) {
        targetLanePosition = this->delayCar_.GetRoadPosition() +
            ((this->targetCar_->N).dimension.x + 0x60000) * dir;
      }
      else {
        targetLanePosition = this->delayCar_.GetRoadPosition() + this->relPosition_.x * dir;
      }

      /* Bounds are unsigned byte-field products, but retail compares signed.
         Cast the bounded products to int
         and evaluate each bound first; no source-only limit object is needed. */
      targetLanePosition = -(int)(((u_int)BWorldSm_slices[this->carObj_->N.simRoadInfo.slice].avgPavedWidthLf << 15) *
          (u_int)(BWorldSm_slices[this->carObj_->N.simRoadInfo.slice].laneCount >> 4)) >? targetLanePosition;
      targetLanePosition = (int)(((u_int)BWorldSm_slices[this->carObj_->N.simRoadInfo.slice].avgPavedWidthRt << 15) *
          (u_int)(BWorldSm_slices[this->carObj_->N.simRoadInfo.slice].laneCount & 15)) <? targetLanePosition;
    }

    (this->carObj_)->preferredLateralPosition = targetLanePosition;
    (this->carObj_)->preferredLateralPositionPower = targettingStrength;
  }

  this->CheckForBarriersAndTargetAroundThem();
  AI_GenericCycle(this->carObj_);
  AI_GenericEndCycle(this->carObj_);
}








/* ---- ApproachTargeting__13AIState_Chasei [AISTATE.CPP:637-713;
 * 195/195 byte PASS and native ownership exact; full source/SLD still open] ---- */
/* Actual clamp side effects are grouped into the desiredSpeed assignment,
 * using only the recorded zDistance quantity. Void-arm conditionals avoid
 * MIN/MAX folding and preserve both branch paths without chaseCar. The
 * literal original macro/label spelling remains unresolved; no asm/qualifier
 * or fake use replaces the old pointer capture. The tick comparison spells
 * the actual global operand first, removing its debug-elided snapshot too. */

void AIState_Chase::ApproachTargeting(int intercept)



{
  int xDistance;
  int zDistance;
  int distance;
  int minSpeed;


  

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

  if (simGlobal.gameTicks > this->noTurnAroundEndTime_) {

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

  if (this->aggressionLevel_ == 1) goto LAB_CHAIN1;

  if (!(this->aggressionLevel_ < 2)) goto LAB_GE2;

  if (this->aggressionLevel_ == 0) goto LAB_CHAIN0;

  minSpeed = 0x190000;

  goto LAB_80070adc;

LAB_GE2:

  if (this->aggressionLevel_ == 2) goto LAB_CHAIN2;

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

  /* Keep the equal-valued threshold and result in separate blocks: retail
     materializes 0xA0000 independently in v0 and a0. */
  if (0xa0000 < distance) goto LAB_MIN_A;

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

  goto LAB_80070adc;

LAB_MIN_A:

  minSpeed = 0xa0000;

  goto LAB_80070adc;

LAB_80070adc:

  /* Retail zDistance is dead after the geometric distance phase. Reusing its
     REG:$3 quantity for this clamp removes the unrecorded selectedSpeed object
     while preserving all 195 words and the recorded local homes. Literal
     original reuse is not uniquely proved by that register reuse. */
  this->carObj_->desiredSpeed = (
      this->carObj_->direction == 1
        ? (zDistance = minSpeed,
           this->carObj_->desiredSpeed < zDistance
             ? (void)(zDistance = this->carObj_->desiredSpeed) : (void)0)
        : (zDistance = -minSpeed,
           zDistance < this->carObj_->desiredSpeed
             ? (void)(zDistance = this->carObj_->desiredSpeed) : (void)0),
      zDistance);

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

  if (0x1f40000 < __builtin_abs(this->longMetersBetween_)) return;

  mySlice = (this->carObj_->N).simRoadInfo.slice;

  myLane = this->carObj_->laneIndex;

  targetSlice = (this->targetCar_->N).simRoadInfo.slice;

  targetLane = this->targetCar_->laneIndex;

  if (myLane < 6 - (BWorldSm_slices[mySlice].laneCount >> 4)) return;

  if ((BWorldSm_slices[mySlice].laneCount & 0xf) + 7 < myLane) return;

  if (targetLane < 6 - (BWorldSm_slices[targetSlice].laneCount >> 4)) return;

  if ((BWorldSm_slices[targetSlice].laneCount & 0xf) + 7 < targetLane) return;

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
/* MATCH: IDA/SYM register allocation and the raw SLD line trace recover both
   mirrored scan scopes. Each final wrap occupies one retail SLD line. The
   widened inner subtraction preserves the gNumSlices-6 arithmetic tree until
   the final int return; this spelling is a compiler-shape inference, not a
   recovered source quote. No extra wrap local is present in SYM. */

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

  myLane = this->carObj_->laneIndex;
  targetLane = this->targetCar_->laneIndex;
  mySlice = (int)this->carObj_->N.simRoadInfo.slice;

  if (targetLane < myLane) {

    leftLane = targetLane;
    rightLane = myLane;

  }

  else {

    leftLane = myLane;
    rightLane = targetLane;

  }

  barrierLane = leftLane;

  while (barrierLane < rightLane) {

    if (AIWorld_CheckForBarrierBetweenLanes(mySlice,barrierLane,barrierLane) != 0) {

      break;

    }

    barrierLane++;

  }

  forwardBarrierDistance = backwardsBarrierDistance = 0x53;

  forwardBarrierEndSlice = mySlice + 0x53;

  if (gNumSlices <= forwardBarrierEndSlice) {

    forwardBarrierEndSlice -= gNumSlices;

  }

  backwardsBarrierEndSlice = mySlice - 0x53;

  if (backwardsBarrierEndSlice < 0) {

    backwardsBarrierEndSlice += gNumSlices;

  }

  currentBarrierLane = barrierLane;

  for (int sliceLoop = 0; sliceLoop < 0x53; sliceLoop += 4) {
    int sliceCheck;
    int temp;
    int leftBarrier;
    int hereBarrier;
    int rightBarrier;

    sliceCheck = mySlice + sliceLoop;

    if (0 <= sliceLoop) {

      if (gNumSlices <= sliceCheck) {

        sliceCheck -= gNumSlices;

      }

    }

    else if (sliceCheck < 0) {

      sliceCheck += gNumSlices;

    }

    temp = AIWorld_CheckForBarrierBetweenLanes(
        sliceCheck,currentBarrierLane + 1,currentBarrierLane - 1);
    leftBarrier = temp & 4;
    hereBarrier = temp & 2;
    rightBarrier = temp & 1;

    if (hereBarrier == 0) {

      if ((leftBarrier != 0) &&
          (6 - (BWorldSm_slices[sliceCheck].laneCount >> 4) <= currentBarrierLane - 1) &&
          (currentBarrierLane - 1 <=
           (BWorldSm_slices[sliceCheck].laneCount & 0xf) + 7)) {

        currentBarrierLane--;

      }

      else if ((rightBarrier == 0) ||
               (currentBarrierLane + 1 <
                6 - (BWorldSm_slices[sliceCheck].laneCount >> 4)) ||
               ((BWorldSm_slices[sliceCheck].laneCount & 0xf) + 7 <
                currentBarrierLane + 1)) {

        forwardBarrierEndSlice = sliceCheck;
        forwardBarrierDistance = sliceLoop;
        break;

      }

      else {

        currentBarrierLane++;

      }

    }

  }

  currentBarrierLane = barrierLane;

  for (int sliceLoop = 0; sliceLoop < 0x53; sliceLoop += 4) {
    int sliceCheck;
    int temp;
    int leftBarrier;
    int hereBarrier;
    int rightBarrier;

    sliceCheck = mySlice - sliceLoop;

    if (0 <= -sliceLoop) {

      if (gNumSlices <= sliceCheck) {

        sliceCheck -= gNumSlices;

      }

    }

    else if (sliceCheck < 0) {

      sliceCheck += gNumSlices;

    }

    temp = AIWorld_CheckForBarrierBetweenLanes(
        sliceCheck,currentBarrierLane + 1,currentBarrierLane - 1);
    leftBarrier = temp & 4;
    hereBarrier = temp & 2;
    rightBarrier = temp & 1;

    if (hereBarrier == 0) {

      if ((leftBarrier != 0) &&
          (6 - (BWorldSm_slices[sliceCheck].laneCount >> 4) <= currentBarrierLane - 1) &&
          (currentBarrierLane - 1 <=
           (BWorldSm_slices[sliceCheck].laneCount & 0xf) + 7)) {

        currentBarrierLane--;

      }

      else if ((rightBarrier == 0) ||
               (currentBarrierLane + 1 <
                6 - (BWorldSm_slices[sliceCheck].laneCount >> 4)) ||
               ((BWorldSm_slices[sliceCheck].laneCount & 0xf) + 7 <
                currentBarrierLane + 1)) {

        backwardsBarrierEndSlice = sliceCheck;
        backwardsBarrierDistance = sliceLoop;
        break;

      }

      else {

        currentBarrierLane++;

      }

    }

  }

  if (forwardBarrierDistance < backwardsBarrierDistance) {

    return (forwardBarrierEndSlice + 6 < gNumSlices) ? forwardBarrierEndSlice + 6 : forwardBarrierEndSlice - (long long)(gNumSlices - 6);

  }

  return (backwardsBarrierEndSlice - 6 < 0) ? backwardsBarrierEndSlice + (long long)(gNumSlices - 6) : backwardsBarrierEndSlice - 6;

}








/* ---- _._15AIState_Offroad  AIState_Offroad::dtor  [AISTATE.CPP:887-891] SLD-VERIFIED ---- */
/* The real member destructor supplies implicit receiver/in-charge handling.
   MATCH: the carFlags RMW must use a fresh direct `carObj_` expression after
   the chained target-position assignment.  Sharing one cached base across the
   two statements merges webs and changes 25 instructions. */

AIState_Offroad::~AIState_Offroad()



{

  (this->carObj_)->targetPos.x =
      (this->carObj_)->targetPos.y =
      (this->carObj_)->targetPos.z = 0;

  (this->carObj_)->targetLatPos = 0;

  this->carObj_->carFlags = this->carObj_->carFlags & 0xfffff7ff;


  return;

}








/* ---- __15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii  AIState_Offroad::ctor  [AISTATE.CPP:896-920] SLD-VERIFIED ---- */

AIState_Offroad::AIState_Offroad(Car_tObj *carObj,int startSlice,coorddef *position,

          matrixtdef *orientation,int maxSpeedKPH,int releaseTime,int endSlice)
  : AIState_Base(carObj)
{
  /* MATCH (w13-a5): plain struct assignments -- gcc movstrsi expands the 36-byte matrix
     copy as the oracle's 4-word/iter loop + 1-word tail + end-ptr compare, and the
     12-byte coorddef copies as grouped lw t0-t2 / sw triples (load-3/store-3). */





  this->letGo_ = 0;
  this->startSlice_ = startSlice;
  this->startPosition_ = *position;
  this->startOrientation_ = *orientation;
  this->startHeading_ = *(coorddef *)((this->startOrientation_).m + 6);
  this->maxSpeedMPS_ = maxSpeedKPH * 0x4700;
  this->releaseTime_ = releaseTime;

  this->targetSlice_ = endSlice;
  this->targetPosition_ = *(coorddef *)BWorldSm_slices[endSlice].center;




  this->carObj_->carFlags = this->carObj_->carFlags | 0x800;
}








/* ---- UnleashIfInRange__15AIState_OffroadP8Car_tObj  AIState_Offroad::UnleashIfInRange  [retail AISTATE.CPP:926-936; native/byte verified, SLD attribution open] ---- */
/* Retail names the clamped result releaseDistanceMeters in v1. The bound-first
   in-place conditional preserves the branch-delay comparison and both threshold
   materializations. Its final store has an inline receiver/body scope pair;
   MarkLetGo is an inferred setter spelling, not a surviving retail name. */

void AIState_Offroad::UnleashIfInRange(Car_tObj *car)
{
  int distanceAbsMeters = AIWorld_SplineDistance(this->carObj_,car);
  distanceAbsMeters = __builtin_abs(distanceAbsMeters);

  int releaseDistanceMeters = fixedmult((car->N).speedXZ,this->releaseTime_);

  releaseDistanceMeters = (0x140000 <= releaseDistanceMeters) ? releaseDistanceMeters : 0x140000;

  if (distanceAbsMeters < releaseDistanceMeters) {
    this->MarkLetGo();
  }
}








/* ---- Execute__15AIState_Offroad  AIState_Offroad::Execute  [retail AISTATE.CPP:944-978; native/byte verified, SLD attribution open] ---- */

void AIState_Offroad::Execute()



{

  

  if (this->letGo_ == 0) {
    coorddef zero;
    /* Retail owns zero only in the hold branch. The targetLatPos clears
     * in both arms compile to one shared store while preserving the outer
     * scope through +19c. Native/byte receipt: run-_pn_5wry. */

    memset((u_char *)&zero,'\0',0xc);

    (this->carObj_->N).linearVel = zero;

    (this->carObj_->N).angularVel = zero;

    (this->carObj_)->desiredSpeed = 0;

    (this->carObj_->N).position = this->startPosition_;

    (this->carObj_->N).orientMat = this->startOrientation_;

    (this->carObj_)->targetPos.x =
        (this->carObj_)->targetPos.y =
        (this->carObj_)->targetPos.z = 0;

    (this->carObj_)->targetLatPos = 0;
  }

  else {

    this->longMetersBetween_ = AIWorld_ApxSplineDistance(this->carObj_,this->targetSlice_);

    this->carObj_->desiredSpeed = this->maxSpeedMPS_;

    if (0 < this->longMetersBetween_) {

      (this->carObj_)->desiredDirection = -1;

      this->carObj_->desiredSpeed = -this->carObj_->desiredSpeed;

    }

    else {

      (this->carObj_)->desiredDirection = 1;

    }

    AI_GenericBeginCycle(this->carObj_);

    AI_GenericCycle(this->carObj_);

    AI_GenericEndCycle(this->carObj_);

    (this->carObj_)->targetPos = this->targetPosition_;

    (this->carObj_)->targetLatPos = 0;
  }

  return;

}








/* ---- __17AIState_PurgatoryP8Car_tObj  AIState_Purgatory::ctor  [AISTATE.CPP:1001-1017] SLD-VERIFIED ---- */
/* CORRECTNESS (w13-a5): oracle stores the VALUE of Cars_gList (= Cars_gList[0], the head
   car) into basisCar -- recon previously stored NULL. lw %lo(Cars_gList) in the oracle. */

AIState_Purgatory::AIState_Purgatory(Car_tObj *carObj)
  : AIState_NonActive(carObj)

{
  int lifeTimer;
  (this->carObj_)->basisCar = Cars_gList[0];

  lifeTimer = AITune_LifeTimer[Cars_gNumTrafficCars];
  randtemp = fastRandom * randSeed; (this->carObj_)->physicsModelTimer = (lifeTimer * (randtemp >> 8 & 0xffff) >> 0x10) + 1; fastRandom = randtemp & 0xffff;


  if ((strcmp((this->carObj_)->carName,"SBUS") == 0) || (strcmp((this->carObj_)->carName,"TBUS") == 0)) {

    this->carObj_->physicsModelTimer = this->carObj_->physicsModelTimer * 5;
  }
  this->carObj_->AIFlags = this->carObj_->AIFlags | 4;
  if (((this->carObj_)->carFlags & 0x10U) != 0) {
    AIState_Purgatory_numTrafficCarsInPurgatory = AIState_Purgatory_numTrafficCarsInPurgatory + 1;
  }
}








/* ---- _._17AIState_Purgatory [AISTATE.CPP:1021-1041; 72-word byte PASS,
 * original source/ownership/SLD still unresolved] ---- */
/* 2026-10-16: a real while(1) search with an exit-at-top test regenerates
 * retail's unrotated index loop, removing both pointer captures and the old
 * absorption identity. Ordinary for/while-condition forms were71words; the
 * for(;;) spelling also differs under this old C++ frontend. No source-text
 * uniqueness or full SLD seal is claimed; see the native receipt in sym-match.md. */

AIState_Purgatory::~AIState_Purgatory()



{
  int search;
  Car_tObj*test;

  (this->carObj_->collision).resetTimer = 0;

  ((this->carObj_)->N).collision.disableCollisionTimer = 0;

  this->carObj_->AIFlags = this->carObj_->AIFlags & 0xfffffffb;

  if (((this->carObj_)->carFlags & 0x10U) != 0) {

    AIState_Purgatory_numTrafficCarsInPurgatory = AIState_Purgatory_numTrafficCarsInPurgatory + -1;

  }

  this->carObj_->desiredDirection = this->carObj_->direction = 1;

  search = Cars_gNumCars - 1;
  while (1) {
    if (search < 0)
      break;
    test = Cars_gSortedList[search];
    if ((test->carFlags & 0x100U) != 0) {
      this->carObj_->basisCar = test;
      break;
    }
    --search;
  }


  /* carObj_->N.active = 1 now comes from the inlined ~AIState_NonActive (real dtor chain). */


  return;

}








/* ---- TestForRelease__17AIState_Purgatory  AIState_Purgatory::TestForRelease  [retail AISTATE.CPP:1048-1063; native/byte verified, SLD attribution open] ---- */

int AIState_Purgatory::TestForRelease()



{
  if (this->carObj_->physicsModelTimer < 1) {
    int trafficInWorld;
    /* Retail declares this count in the timer-expired body (+018..+06c). */
    trafficInWorld = Cars_gNumTrafficCars - AIState_Purgatory_numTrafficCarsInPurgatory;

    if (trafficInWorld <
        AITune_MaxTraffic[GameSetup_gData.commMode == 1]
                         [GameSetup_gData.trafficDensity]) {

      return 1;

    }

    this->carObj_->physicsModelTimer = 1;

  }

  return 0;

}








/* ---- Execute__17AIState_Purgatory  AIState_Purgatory::Execute  [AISTATE.CPP:1068-1087] SLD-VERIFIED ---- */

void AIState_Purgatory::Execute()



{
  ((this->carObj_)->collision).resetTimer = 0;

  ((this->carObj_)->N).collision.disableCollisionTimer = 0;

  if ((((this->carObj_)->carFlags & 0x20U) == 0) &&
      (0x3bf < simGlobal.gameTicks)) {

    (this->carObj_)->physicsModelTimer =
        (this->carObj_)->physicsModelTimer - AI_elapsedTime;

  }

  return;

}








/* ---- StartUp__17AIState_Purgatory  AIState_Purgatory::StartUp  [AISTATE.CPP:1090-1091] SLD-VERIFIED ---- */

void AIState_Purgatory::StartUp(void) {
  AIState_Purgatory_numTrafficCarsInPurgatory = 0;
}








/* ---- __21AIState_RovingTrafficP8Car_tObjP9trigger_t  AIState_RovingTraffic::ctor  [AISTATE.CPP:1103-1109] SLD-VERIFIED ---- */

AIState_RovingTraffic::AIState_RovingTraffic(Car_tObj *carObj,trigger_t *trigger)
  : AIState_Base(carObj)
{
  this->path_ = *(trigger_pathPosition_t **)((char *)trigger + 0x3c);
  this->numPathPoints_ = *(int *)((char *)trigger + 0x38);
  this->pathIndex_ = 0;
  this->waitTick_ = 0;
  this->carObj_->carFlags = this->carObj_->carFlags | 0x800;
}








/* ---- CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi  AIState_RovingTraffic::CheckIfCarIsNearbyAndStop  [retail AISTATE.CPP:1130-1169; native/byte verified, SLD attribution open] ---- */

void AIState_RovingTraffic::CheckIfCarIsNearbyAndStop(Car_tObj *otherCarObj,int &status)



{
  int distance;

  if (this->carObj_ == otherCarObj) { status = 2; return; }

  if ((otherCarObj->N).active == '\0') { status = 2; return; }

  distance = AIWorld_SplineDistance(this->carObj_,otherCarObj);

  if (0 < distance) {

    distance = AIWorld_SplineDistance(this->carObj_,otherCarObj);

  }

  else {

    distance = -AIWorld_SplineDistance(this->carObj_,otherCarObj);

  }

  if (distance <= 0xc0000) {
    if (0 < this->carObj_->roadPosition - otherCarObj->roadPosition ?
        this->carObj_->roadPosition - otherCarObj->roadPosition <= 0x9ffff :
        otherCarObj->roadPosition - this->carObj_->roadPosition <= 0x9ffff) {
      coorddef posDiff;

      posDiff.x = (otherCarObj->N).position.x - ((this->carObj_)->N).position.x;
      posDiff.y = (otherCarObj->N).position.y - ((this->carObj_)->N).position.y;
      posDiff.z = (otherCarObj->N).position.z - ((this->carObj_)->N).position.z;

      /* Retail blez at 80071a0c targets the epilogue, not the nearby status=0
       * store. Leave status untouched on this path. The full byte gate checks
       * that branch displacement, not only its normalized target spelling. */
      if (fixedmult(this->carObj_->N.orientMat.m[6],posDiff.x) +
          fixedmult(this->carObj_->N.orientMat.m[7],posDiff.y) +
          fixedmult(this->carObj_->N.orientMat.m[8],posDiff.z) <= 0) return;

      AudioClc_HonkHorn(this->carObj_,4,0x10,8);
      (this->carObj_)->desiredSpeed = 0;
      status = 1;
      return;
    } else {
      status = 2;
      return;
    }
  } else {
    status = 0;
  }

  return;

}








/* 2026-10-13 loop-owner review: ordinary condition-bearing for loops are
 * 47 differences at234/233; testing status first is26 at227/233. Positive
 * bounds guards inside the existing exit-in-body loops are233/233 PASS,
 * but still emit only the root region (retail has seven). All bodies
 * restored. Control-flow equivalence does not identify the missing source
 * region producers; no dummy declarations or padding scopes retained. */
/* ---- Execute__21AIState_RovingTraffic  AIState_RovingTraffic::Execute  [AISTATE.CPP:1172-1224; source/SLD review open] ----
 * Store all three raw components before shifting X/Z in place: 233/233 PASS,
 * with no scaledDistanceX/Z captures and exact named homes. Earlier early
 * shifts lost instructions; fused subtract/shift assignments are 38 diffs
 * at 231/233. The six missing loop/guard scopes and full SLD remain open.
 * Exit-in-body for loops preserve the non-rotated oracle without new locals. */

void AIState_RovingTraffic::Execute()
{
  int search;
  int status;
  coorddef centerBack;
  coorddef carRelativeForLatPos;
  coorddef carRelativeForDistance;

    /* W57-A11: SLD gives ONE retail line (1177) for the whole 3-word copy and the oracle
     uses t0/t1/t2 -- that is gcc's movstrsi 12-byte STRUCT ASSIGNMENT, not three per-field
     statements (catalog 3d(a)). */
  this->carObj_->targetPos = this->path_[this->pathIndex_].position;

  (this->carObj_)->desiredSpeed = this->path_[this->pathIndex_].targetSpeed * 0x7247;

  /* W57-A11: SLD line 1183 = one struct assignment (movstrsi t0/t1/t2). */
  centerBack = *(coorddef *)BWorldSm_slices[this->carObj_->N.simRoadInfo.slice].center;

  carRelativeForLatPos.x = this->carObj_->targetPos.x - centerBack.x;

  carRelativeForLatPos.y = this->carObj_->targetPos.y - centerBack.y;

  carRelativeForLatPos.z = this->carObj_->targetPos.z - centerBack.z;

  /* gcc-2.x signed /256 idiom (bgez;addiu 0xFF;sra 8) -- write the plain division,
     not a hand-rolled if(x<0)x+=0xff;x>>=8 -- reference_mips_isa_asm.md MULT/DIV section.
     Statement order matches the oracle's interleave: div-pair, mult, div-pair, mult, ... */

  this->carObj_->targetLatPos =
      this->carObj_->N.roadMatrix.m[0] / 256 * (carRelativeForLatPos.x / 256) +
      this->carObj_->N.roadMatrix.m[1] / 256 * (carRelativeForLatPos.y / 256) +
      this->carObj_->N.roadMatrix.m[2] / 256 * (carRelativeForLatPos.z / 256);

  carRelativeForDistance.x = this->carObj_->targetPos.x - this->carObj_->N.position.x;

  carRelativeForDistance.y = this->carObj_->targetPos.y - this->carObj_->N.position.y;

  carRelativeForDistance.z = this->carObj_->targetPos.z - this->carObj_->N.position.z;

  carRelativeForDistance.x >>= 0xc;
  carRelativeForDistance.z >>= 0xc;

  if (carRelativeForDistance.x * carRelativeForDistance.x +
      carRelativeForDistance.z * carRelativeForDistance.z < 10000) {

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

  /* Keep the test in the for body: a condition-bearing loop rotates the
     oracle's shared top test. This form preserves all 233 instructions but
     does not yet recover retail's empty scope regions. */

  for (search = (this->carObj_)->sortIndex + 1; ; search++) {

    if (!(search < Cars_gNumCars && (status == 2))) break;

    this->CheckIfCarIsNearbyAndStop(Cars_gSortedList[search],status);

  }

  if (status != 1) {

    status = 2;

    for (search = (this->carObj_)->sortIndex - 1; ; search--) {

      if (!(-1 < search && (status == 2))) break;

      this->CheckIfCarIsNearbyAndStop(Cars_gSortedList[search],status);

    }

  }

  return;

}








/* ---- _._14AIState_Donuts  AIState_Donuts::dtor  [AISTATE.CPP:1248-1253] SLD-VERIFIED ---- */
/* Ordinary member form supplies the implicit receiver and in-charge handling. */

AIState_Donuts::~AIState_Donuts()



{

  (this->carObj_)->targetPos.x =
      (this->carObj_)->targetPos.y =
      (this->carObj_)->targetPos.z = 0;

  (this->carObj_)->targetLatPos = 0;

  (this->carObj_)->donutMode = 0;


  return;

}








/* ---- Execute__14AIState_Donuts  AIState_Donuts::Execute  [AISTATE.CPP:1256-1334; source/SLD review open] ---- */
/* 2026-10-16: branch-local chained direction stores cross-jump to retail's
   one tail, without an unrecorded carObj alias. A post-join direct store
   reloads the car pointer (321words); a scalar ternary has one extra copy
   (320words). Native compiler pass receipts identify these distinct graphs.
   No caller temporary, asm, qualifier or fake reference is needed here;
   full scope/SLD restoration is checked separately, not implied by319PASS. */

void AIState_Donuts::Execute()



{
  coorddef right;
  coorddef forward;
  coorddef targetPos;
  int latPos;
  int slice;
  int forwardDot;



    slice = (int)this->carObj_->N.simRoadInfo.slice;

    forwardDot =
        (this->carObj_->N.orientMat.m[6] / 256) * (this->carObj_->N.roadMatrix.m[6] / 256) +
        (this->carObj_->N.orientMat.m[7] / 256) * (this->carObj_->N.roadMatrix.m[7] / 256) +
        (this->carObj_->N.orientMat.m[8] / 256) * (this->carObj_->N.roadMatrix.m[8] / 256);

    if (forwardDot > 0) {

      this->carObj_->desiredDirection = this->carObj_->direction = 1;

    }

    else {

      this->carObj_->desiredDirection = this->carObj_->direction = -1;

    }

  if ((this->donutMode_ == 1) || (this->donutMode_ == 3)) {

    int forwardSlice;
    int forwardDot;
    int dCarToCenter;
    /* Each wrap is one retail SLD statement (1281/1283). As in
     * FindBarrierEndSlice, widening the inner subtraction preserves its
     * arithmetic tree without adding an unrecorded source local. */

    forwardDot =
        (this->carObj_->N.orientMat.m[6] / 256) * (this->carObj_->N.roadMatrix.m[6] / 256) +
        (this->carObj_->N.orientMat.m[7] / 256) * (this->carObj_->N.roadMatrix.m[7] / 256) +
        (this->carObj_->N.orientMat.m[8] / 256) * (this->carObj_->N.roadMatrix.m[8] / 256);

    if (0 <= forwardDot)

    {
      forwardSlice = (slice + 3 < gNumSlices) ? slice + 3 : slice - (long long)(gNumSlices - 3);

    }

    else {

      forwardSlice = (slice - 3 < 0) ? slice + (long long)(gNumSlices - 3) : slice - 3;

    }

    targetPos = *(coorddef *)BWorldSm_slices[forwardSlice].center;

    dCarToCenter = __builtin_abs(this->carObj_->roadPosition);

    latPos = 0;

    if ((this->donutMode_ == 1) && (dCarToCenter < 0x28000)) {

      this->donutMode_ = 2;

    }

  }

  else {

    this->donutLookForward_ -= 0x10000;

    if (this->donutLookForward_ < 0x8000) {

      randtemp = fastRandom * randSeed;

      fastRandom = randtemp & 0xffff;

      this->donutLookForward_ = ((randtemp >> 8 & 0xffff) * 5 >> 0xe) * 0x10000 + 0x140000;

    }

    /* SYM: right/forward/targetPos are real coorddef locals -- right = scaled local
       right-axis (orientMat row0), forward = scaled local forward-axis (orientMat row2
       via donutLookForward_), targetPos = position + right + forward. */

    right = *(coorddef *)&this->carObj_->N.orientMat.m[0];

    forward = *(coorddef *)&this->carObj_->N.orientMat.m[6];

    right.x = fixedmult(0x60000,right.x);

    right.y = fixedmult(0x60000,right.y);

    right.z = fixedmult(0x60000,right.z);

    forward.x = fixedmult(this->donutLookForward_,forward.x);

    forward.y = fixedmult(this->donutLookForward_,forward.y);

    forward.z = fixedmult(this->donutLookForward_,forward.z);

    targetPos.x = ((this->carObj_)->N).position.x + right.x;

    targetPos.y = ((this->carObj_)->N).position.y + right.y;

    targetPos.z = ((this->carObj_)->N).position.z + right.z;

    targetPos.x = targetPos.x + forward.x;

    targetPos.y = targetPos.y + forward.y;

    targetPos.z = targetPos.z + forward.z;

    latPos = Newton_CalculateRoadPositionFromSliceAndPosition(
        (int)this->carObj_->N.simRoadInfo.slice,&targetPos,&this->carObj_->N.roadMatrix);

    if (this->carObj_->roadPosition < 0) {

      if (this->carObj_->roadPosition - 0x20000 <
          -((BWorldSm_slices[slice].avgPavedWidthLf << 15) *
            (BWorldSm_slices[slice].laneCount >> 4))) goto LAB_800722e8;

      goto LAB_800722ec;

    }

    else {

      if (!((BWorldSm_slices[slice].avgPavedWidthRt << 15) *
            (BWorldSm_slices[slice].laneCount & 0xf) <
            this->carObj_->roadPosition + 0x20000)) goto LAB_800722ec;

    }

LAB_800722e8:

    this->donutMode_ = 1;

  }

LAB_800722ec:

  (this->carObj_)->donutMode = this->donutMode_;

  AI_GenericBeginCycle(this->carObj_);

  AI_GenericCycle(this->carObj_);

  AI_GenericEndCycle(this->carObj_);

  this->carObj_->targetPos = targetPos;

  (this->carObj_)->targetLatPos = latPos;

  (this->carObj_)->desiredSpeed = 0x471c7;

  return;

}








/* ---- __17AIState_GotoSliceP8Car_tObjii  AIState_GotoSlice::ctor  [AISTATE.CPP:1348-1351] SLD-VERIFIED ---- */

AIState_GotoSlice::AIState_GotoSlice(Car_tObj *carObj,int targetSlice,int stopWhenArrivedAtSlice)
  : AIState_Normal(carObj),
    targetSlice_(targetSlice),
    stopWhenArrivedAtSlice_(stopWhenArrivedAtSlice)
{
}








/* ---- Execute__17AIState_GotoSlice [AISTATE.CPP:1355-1388; source/SLD review open] ---- */
/* 2026-10-16: per-arm field stores with the positive arm returning let GCC
   cross-jump the signed clamp into one tail. The previous post-join direct
   ternary was68words; this removes the final unrecorded speed capture at70.
   Native owner/SLD receipts are separate from instruction equality. */

void AIState_GotoSlice::Execute()



{
  int longMetersBetween;

  longMetersBetween = AIWorld_ApxSplineDistance(this->targetSlice_,this->carObj_);

  if (-1 < longMetersBetween) {

    (this->carObj_)->desiredDirection = 1;

  }

  else {

    (this->carObj_)->desiredDirection = -1;

  }

  this->AIState_Normal::Execute();

  if (this->stopWhenArrivedAtSlice_ != 0) {
    int distMeters;
    int cap;

    distMeters = __builtin_abs(longMetersBetween);

    cap = 0xc80000;

    if (distMeters < 0xc0000) {

      cap = 0x40000;

    }

    else if (distMeters < 0x320000) {

      cap = 0x140000;

    }

    else if (distMeters < 0x960000) {

      cap = 0x280000;

    }

    else if (distMeters < 0x1900000) {

      cap = 0x500000;

    }

    if (this->carObj_->desiredSpeed >= 0) {
      this->carObj_->desiredSpeed = this->carObj_->desiredSpeed < cap
          ? this->carObj_->desiredSpeed : cap;
      return;
    }
    this->carObj_->desiredSpeed = this->carObj_->desiredSpeed > -cap
        ? this->carObj_->desiredSpeed : -cap;

  }

  return;

}








/* ---- InTargetSliceRange__17AIState_GotoSlicei  AIState_GotoSlice::InTargetSliceRange
 * [AISTATE.CPP:1395-1398] ----
 * Assigning the built-in absolute value to retail's distanceMeters keeps
 * its v0 debug row and zero-length root block while matching 17 instructions.
 * Three successive source statements also reproduce all 17 retail relative
 * SLD tags and the function-end line delta (3). Literal spelling is unknown. */

int AIState_GotoSlice::InTargetSliceRange(int rangeMeters) {
  int distanceMeters = AIWorld_ApxSplineDistance(this->carObj_,this->targetSlice_);
  distanceMeters = __builtin_abs(distanceMeters);
  return (u_int)(distanceMeters < rangeMeters);
}








/* ---- __14AIState_CruiseP8Car_tObj12cruiseMode_ti  AIState_Cruise::ctor  [AISTATE.CPP:1403-1408] SLD-VERIFIED ---- */

AIState_Cruise::AIState_Cruise(Car_tObj *carObj,cruiseMode_t cruiseMode,int speedOrFactor)
  : AIState_Normal(carObj)
{
  this->cruiseMode_ = cruiseMode; if (cruiseMode == 0) {
    this->cruiseSpeed_ = speedOrFactor;
  } else if (cruiseMode == 1) {
    this->cruiseFactor_ = speedOrFactor;
  }
}








/* ---- Execute__14AIState_Cruise  AIState_Cruise::Execute  [AISTATE.CPP:1414-1434] SLD-VERIFIED ---- */

void AIState_Cruise::Execute()



{
  switch (this->cruiseMode_) {

  case CRUISE_ATSETSPEED:

    this->carObj_->desiredSpeed =
        this->cruiseSpeed_ * this->carObj_->direction;

    break;

  case CRUISE_ATFACTOR:

    AISpeeds_CalcDesiredSpeed(this->carObj_);

    (this->carObj_)->desiredSpeed =
        fixedmult((this->carObj_)->desiredSpeed,this->cruiseFactor_);

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
/* Ordinary member form supplies the implicit receiver and in-charge handling. */

AIState_Cruise::~AIState_Cruise()



{



  return;

}








/* ---- _._17AIState_GotoSlice  AIState_GotoSlice::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */
/* Ordinary member form supplies the implicit receiver and in-charge handling. */

AIState_GotoSlice::~AIState_GotoSlice()



{



  return;

}








/* ---- TestForRelease__21AIState_RovingTraffic  AIState_RovingTraffic::TestForRelease  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

int AIState_RovingTraffic::TestForRelease()



{

  return this->pathIndex_ < this->numPathPoints_ ^ 1;

}








/* ---- _._21AIState_RovingTraffic  AIState_RovingTraffic::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ----
   An ordinary member destructor exposes the real source cleanup and lets GCC
   provide its implicit receiver/in-charge handling. */
AIState_RovingTraffic::~AIState_RovingTraffic()



{


  (this->carObj_)->targetPos.x =
      (this->carObj_)->targetPos.y =
      (this->carObj_)->targetPos.z = 0;

  this->carObj_->targetLatPos = 0;

  this->carObj_->carFlags &= 0xfffff7ff;


  return;

}








/* ---- func_80072750  AIState_NonActive::Execute  [rule-8, w30-a2] ----
   SECOND compiled instance of AIState_NonActive::Execute (empty body) -- the OLD-ABI
   vague-linkage duplicate sitting immediately next to func_80072758/func_80072830/func_80072838
   below. Every canonical name (Execute__17AIState_NonActive/___17AIState_NonActive/
   TestForRelease__12AIState_Base) is already claimed by a DIFFERENT VA
   (0x8005F624/0x8005F62C/0x8005B4C4 -- see configs/symbol_addrs.txt), so this instance keeps
   its func_<VA> identity (extern-C name can't collide) with the real identity in this comment.
   [2026-08-03 NAME-FIX: the four same-TU duplicates now carry VA-SUFFIXED real names
   (Execute__17AIState_NonActive_80072750 etc.) on BOTH sides -- unique at the symbol level
   (one obj cannot hold two same-named globals; the canonicals live in THIS TU), real at the
   display level; renamed in symbol_addrs + asm labels/refs/rodata vtable words + expected
   obj (objcopy).  The four banners keep their historical func_ text.]
   PROOF: asm/data/rdata_80054548.rodata.s @0x800555AC (AIState_NonActive_vtable Execute slot,
   D_800555A0+0xC) holds the literal word `func_80072750`. */





/* ---- func_80072758  AIState_NonActive's deleting destructor [rule-8, w30-a2] ----
   SECOND compiled instance of ~AIState_NonActive (see func_80072750 comment -- canonical name
   ___17AIState_NonActive already claimed by the instance at 0x8005F62C). Same shape as
   ___17AIState_Purgatory's tail (own-class vtable -> mark carObj_->N.active -> AIState_Base_vtable
   -> conditional delete).
   PROOF: rdata_80054548.rodata.s @0x800555B4 (AIState_NonActive_vtable dtor slot) holds the
   literal word `func_80072758`; the two lui/addiu loads in the oracle (D_800555A0, D_80055640)
   are the exact VAs of AIState_NonActive_vtable and AIState_Base_vtable materialized in
   vtables_aistate.cpp. */





/* ---- _._12AIState_Idle  AIState_Idle::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ----
   Ordinary member form removes the reconstructed receiver, in-charge parameter,
   and cached-car placeholder from the source surface. */








/* ---- _._14AIState_Normal  AIState_Normal::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */
/* reconstructed as extern "C" ___14AIState_Normal(AIState_Normal*,int) free fn -- see
   AIState_Chase dtor comment for why (real per-class deleting dtor in the oracle). */





/* ---- func_80072830  AIState_Base::TestForRelease  [rule-8, w30-a2] ----
   SECOND compiled instance of AIState_Base::TestForRelease (canonical name
   TestForRelease__12AIState_Base already claimed by the instance at 0x8005B4C4). This is the
   SHARED default impl (return 0) used by every AIState subclass that does not override
   TestForRelease -- confirmed by rdata_80054548.rodata.s: the literal word `func_80072830`
   fills the TestForRelease slot of AIState_NonActive_vtable (@0x800555BC), AIState_Offroad's
   _vt (@0x800555DC), AIState_Chase's _vt (@0x800555FC), AIState_Idle's _vt (@0x8005561C),
   AIState_Normal's _vt (@0x8005563C) AND AIState_Base_vtable itself (@0x8005565C). */





/* ---- func_80072838  AIState_Base's deleting destructor (___12AIState_Base) [rule-8, w30-a2] ----
   aistate.h forward-declares `void ___12AIState_Base(AIState_Base*,int __in_chrg)` (used by
   vtables_aistate.cpp's AIState_Base_vtable dtor-slot comment) but NO TU ever defines it --
   this VA is that real, previously-missing body (canonical name kept free for a future single
   real definition; this instance keeps its func_<VA> identity per the func_80072750 comment
   above, since configs/symbol_addrs.txt already reserves ___12AIState_Base for the OTHER
   duplicate instance at 0x8005B4CC). Same minimal shape as ___14AIState_Normal (no per-class
   cleanup, straight chain to AIState_Base_vtable then conditional delete) -- AIState_Base has
   no data members to clear.
   PROOF: rdata_80054548.rodata.s @0x80055654 (AIState_Base_vtable's OWN dtor slot) holds the
   literal word `func_80072838`. */









/* W54-A15: the CANONICAL-mangled AIState_Base::TestForRelease / ~AIState_Base bodies
 * (TestForRelease__12AIState_Base @0x8005B4C4, ___12AIState_Base @0x8005B4CC) belong to
 * the AIHIGH object per configs/symbol_addrs.txt -- MOVED to aihigh.cpp so that unit
 * emits them (they were 0.00% NOT-IN-OBJECT there).  aistate keeps only its own
 * VA-suffixed vague-linkage duplicates at 0x80072830 / 0x80072838 (above). */

/* end of aistate.cpp */
