/* game/common/aistate.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Real non-polymorphic C++ inheritance (SS3.23/3.23c conversion, 2026-07-06 -- was
 *   composition-modeled); manual _vf vtable dispatch (8-byte __vtbl_ptr_type entries);
 *   deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aistate_types.h"
#include "aistate_externs.h"

#define AISTATE_SLICE_BYTE(slice, offset) \
    (*(u_char *)(AIState_BWorldSmSlices + (slice) * 0x20 + (offset)))

/* ---- aistate.obj-owned globals (.bss zero) ---- */
static int   AIState_Purgatory_numTrafficCarsInPurgatory;   /* @0x8013dd7c  (bss(zero); SYM STAT) */


/* w60 link-debt fix (W60-A8 finding, user-unblocked): the canonical
 * Execute__17AIState_NonActive / ___17AIState_NonActive pair (@0x8005F624/62C)
 * was over-emitted by THREE objects.  aih_btccop.cpp owns those VAs (its own
 * banners + SLD adjacency); this TU keeps only its VA-suffixed vague-linkage
 * instances (Execute__17AIState_NonActive_80072750 etc., see the tail block).
 * The canonical definitions that lived here were removed; the file's old tail
 * comment ("the canonicals live in THIS TU") is superseded by this note. */


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
/* W62-A9: SEALED 11 -> PASS 66/66 (psyqproof REAL=0 RELOP=0).  The standing
   "pure coloring floor" verdict below was WRONG.  TWO levers, each inert alone:
   (1) THE -G-THRESHOLD GATE-GLOBAL LEVER (new, generalises).  A 4-byte `extern int`
       is at-or-under the -G4 small-data threshold, so cc1plus emits the single
       UNSCHEDULABLE assembler macro `lw $2,D_8011321C`; the retail oracle has the
       SPLIT `lui %hi` (hoisted into the store block) + `lw %lo` pair, which only a
       symbol ABOVE the threshold produces.  Declaring it `extern int D_8011321C[]`
       (3.12 #5 unsized array => unknown size => never small-data) restores the split,
       kills the load-delay `nop` (67 -> 66, count-exact) and lets the `lui` hoist.
       SYMPTOM TO GREP FOR: ours `lw rD,SYM` plus a nop where retail has `lui`..`lw`.
       Alone: 13 diffs (WORSE than the 11 baseline -- it must be paired).
   (2) The both-arms-assign TERNARY for the reverseDirCheck select -- exactly the
       shape the ai.cpp sibling AI_HandleTrafficHonking already uses.  It frees $v0
       (the gate value dies at the branch) so the nor/xori land in $v0 like retail
       instead of $a0.  Alone: 16 diffs.  Together: PASS.
   Also PASSing (equivalent, not landed): the if/else both-arms form; the ternary
   with the gate read into a named `rev` first; an in-place `(int)this->carObj_`
   receiver cast; a read-only fence on `rev`.  FALSIFIED at 11-20 (pre-landing
   basin, listed so nobody re-fights them): gate-read-first alone, inverted default,
   per-arm field re-read, identity launder on `direction`, read-only fence on
   `direction`, named receiver pointer, block-local reverseDirCheck (13A block
   anchor -- INERT here), and the unsized array WITHOUT the ternary. */
/* HISTORICAL, superseded by the receipt above:
   WALL (register-coloring near-miss, insn count now EXACT 66/66; was 8 SHORT before the
   reverseDirCheck fix below): two independent saved-reg swaps remain vs the oracle --
   (carObj<->delayTime) and (relPosition<->nitrousTicks) -- both are short/long-lived params
   that gcc-2.x's global allocator ties differently than the oracle build; every statement
   placement/caching variant tried leaves the same two swaps. Pure §A coloring floor,
   documented near-miss. */

/* D_8011321C == GameSetup_gData.reverseTrack -- standalone-symbol form, same precedent as
 * ai.cpp AI_HandleTrafficHonking / aiinit.cpp AIInit_RestartAICar / hud.cpp Hud_NextPlayer. */
/* W62-A9: declared an UNSIZED ARRAY on purpose -- see the ctor receipt below.
   A 4-byte `extern int` is at-or-under the -G4 small-data threshold, so cc1plus
   emits the single UNSCHEDULABLE assembler macro `lw $2,D_8011321C`; retail's
   split `lui %hi` + `lw %lo` pair proves this object saw the symbol as ABOVE the
   threshold.  The unsized `[]` restores that (unknown size => never small-data). */
extern int D_8011321C[];

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
     doesn't perform here.
     FLOOR (w30-a2, 11 diffs/67 vs 66 insns): shape CONFIRMED -- the oracle loads
     carObj_->direction into ONE register and reuses it for BOTH the nor(~direction) and the
     xori(direction^1), which is why this block caches it in a local `direction` instead of
     re-reading `(this->carObj_)->direction` twice (that re-read version was the pre-w30-a2
     shape and produced the SAME diff count with an extra dead load); the residual now is
     purely which physical register (v0/v1 vs the oracle's v1/v0, with the D_8011321C address
     lui interleaved differently) the allocator/scheduler picks -- a coin-flip already covered
     by the "declaration-scope/order noise" class, not a missing/wrong construct. */
  {
    int direction = (this->carObj_)->direction;
    reverseDirCheck = (D_8011321C[0] == 0) ? (direction ^ 1) : ~direction;
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

    this->murderEndTime_ = AIState_SimGlobalWords[1] + murderTicks;

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

  if ((this->murderMode_ != 0) && (!(AIState_SimGlobalWords[1] < this->murderEndTime_))) {

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



  if ((0 < this->nitrousTicks_) && (AIState_SimGlobalWords[1] >= this->slowDownEndTime_)) {

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
  int targetCarVerySlow;  /* SYM $a0: holds target speed first, then the slow-car boolean */

  

  this->SetUp();

  velocityToHitInTime = fixedmult(this->longMetersBetween_,0x666);

  velocityToHitInTime = __builtin_abs(velocityToHitInTime);

  deltaVelocity =
    this->carObj_->currentSpeed - this->targetCar_->currentSpeed;

  deltaVelocity = __builtin_abs(deltaVelocity);

  far = 0;

  if (deltaVelocity < velocityToHitInTime) {

    int lmAbs;

    lmAbs = this->longMetersBetween_;

    lmAbs = __builtin_abs(lmAbs);

    far = 0x8c0000 < lmAbs;

  }

  targetCarVerySlow = __builtin_abs(this->targetCar_->currentSpeed);

  targetCarVerySlow = !(0x6aaa9 < targetCarVerySlow);

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

  if ((0x1aaaaa < deltaVelocity) || (far != 0) ||
      (0x500000 < __builtin_abs(this->longMetersBetween_))) {
    this->ApproachTargeting(0);
  }
  else {
    this->ApproachTargeting(1);
  }

LAB_800702a0:

  if (AIState_SimGlobalWords[1] < this->slowDownEndTime_) {

    this->DoSlowNitrous();

  }

  /* Remaining 4 diffs are one uncoalesced retail load: currentSpeed enters $v1
     before the subtraction result is assigned to deltaVelocity in $a1. */
  return;

}








/* ---- FarTargeting__13AIState_Chase  AIState_Chase::FarTargeting  [AISTATE.CPP:414-437] SLD-VERIFIED ---- */

void AIState_Chase::FarTargeting()



{

  this->inTargetRegion_ = 0;

  if (AIState_SimGlobalWords[1] > this->noTurnAroundEndTime_) {

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
    int t = this->latMetersBetween_ * dir;
    int x = (this->targetCar_->N).dimension.x;
    if (t < -x) {
      latPos = -1;
    }
    else if (x < t) {
      latPos = 1;
    }
  }

  {
    int t = this->longMetersBetween_ * dir;
    int z = (this->targetCar_->N).dimension.z;
    if (t < 0x20000 - z) {
      longPos = -1;
    }
    else if (z + 0x20000 < t) {
      longPos = 1;
    }
  }

  {
    int t = this->longMetersBetween_ * dir;
    int z = (this->targetCar_->N).dimension.z + 0x20000;
    if (t < -z) {
      bigLongPos = -1;
    }
    else if (z < t) {
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

  desiredSpeed = (this->delayCar_).currentSpeed_;
  if (desiredSpeed < 1) {
    desiredSpeed = -desiredSpeed;
  }

  if ((longPos < longTarget) || (forceLongAction == 1)) {
    desiredSpeed = fixedmult(desiredSpeed,0x16666);
  }
  else if (((longTarget < longPos) || (forceLongAction == -1)) ||
          ((0x140000 < this->longMetersBetween_ &&
           (((0x9ffff < this->longMetersBetween_ || (latPos != 0)) || (latTarget == 0)))))) {
    desiredSpeed = fixedmult(desiredSpeed,this->CalculateCloseTargettingAheadSlowDownFactor());
  }
  else {
    if (forceLongAction != -2) goto LAB_80070704;
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

LAB_80070704:
  AISpeeds_CalcDesiredSpeed(this->carObj_);

  (this->carObj_)->desiredSpeed = __builtin_abs((this->carObj_)->desiredSpeed);

  {
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
    /* NEAR-MISS 78 diffs, count-exact 300/300 (W59-A3 re-gated).  SYM 8c block
     * @0x8007078c (retail line 603) declares EXACTLY these two locals:
     * targettingStrength = REG $8 = t0 and targetLanePosition = REG $4 = a0 -- the two
     * registers the tail diff wants (ours parks them in a3 / v1).  latOffset and
     * slicePtr are Ghidra-invented (06A).  The residual is one uniform saved/caller band
     * rotation running from the first mflo (t0 vs t1) to the two preferredLateralPosition
     * stores.  W59-A3 FALSIFIED: rewriting BOTH clamps in the 09A/5.0c both-arms-assign
     * ternary form (targetLanePosition = (latOffset < targetLanePosition) ?
     * targetLanePosition : latOffset; and the MIN twin) -- which is what the oracle's
     * two extra `addu a0,<tmp>,zero` copies and the SLD 623/624 one-line-per-clamp
     * grouping suggest -- ADDS 3 insns (303/300) and goes 78 -> 89.  The override form
     * is the count-exact one; next lens = the SYM-ordered priority fence (08D) on
     * targetLanePosition/targettingStrength, or qtytrace.
     * W59-A3 also FALSIFIED against the W59-A11 mobile twin (sub_51F8B4): (a) the EA
     * MIN/MAX-macro shape (fresh block temp, if/else, both arms assigning, per-arm
     * args) on both clamps -> 80 diffs / 304 insns; (b) the mobile ladder shape for
     * longPos/bigLongPos (`>= low` guard with a nested no-else inner if and the -1 in
     * the else, dir*longMetersBetween_ and dimension.z recomputed at every use, no
     * hoisted t/z temps) -> 94 diffs.  The PSX oracle keeps our if/else-if ladder and
     * the in-place clamp override; the mobile port diverged here.
     * W61-A12 READ THE RESIDUAL (78 diffs, count-exact 300/300, no probe spent):
     * it is NOT a spill-slot permutation (zero sp-offset diffs, so the W61-A1
     * declaration-order/frame law does not apply here) and NOT one uniform swap.
     * The band rotation starts at the FIRST mflo of the function (ours t0, retail
     * t1) -- i.e. retail already has one more t-register committed there -- and the
     * only STRUCTURAL divergence is in `targetLanePosition = delayCar_.roadPosition_
     * + latOffset * dir`: retail completes the sum EAGERLY (`lw v0,76(s1); mult;
     * lw v0,56(s1); mflo t1; addu a0,v0,t1`, oracle 239-244) while ours defers the
     * mflo and the add past the whole slicePtr limit block (ours 240-258).  Land the
     * eager-sum shape first (a named temp for the product, or the sum split so the
     * roadPosition_ load sits between the mult and the mflo) and re-read the band;
     * the t0/t1 base of the rotation is downstream of who owns the first multiply. */

    targettingStrength = 0xf0000;
    if (this->murderMode_ != 0) {
      targettingStrength = 0x1e0000;
      targetLanePosition = (this->delayCar_).roadPosition_;
    }
    else {
      int latOffset;
      int slicePtr;

      /* W63-A12 SEAL (15 -> PASS 300/300, psyqproof REAL=0).  Retail fills the
       * `beqz $s6` (forceLatAction) delay slot with `lui $v1,0x60000` -- i.e. the
       * bias constant is materialized as its OWN insn in the same basic block, just
       * before the branch, where reorg's simple fill can take it.  Written inline as
       * `dimension.x + 0x60000` cc1 folds the lui into the arm and emits it AFTER the
       * targetCar_ load, leaving the slot to a nop (the whole 15-diff residual, 301 vs
       * 300).  The cure is the DoRearEnder pair: an ASSIGNED local (never
       * decl-with-init -- that is const-propagated straight back) plus a zero-insn
       * OPACITY/IDENTITY fence `__asm__("" : "=r"(x) : "0"(x))` to stop cse folding it.
       * 🔴 PLACEMENT IS THE WHOLE LEVER: with the fence BETWEEN the assignment and the
       * branch it lands 15 -> 3 but the slot STAYS a nop -- an asm is a reorg backward-
       * scan barrier (catalog 06B HARD BOUNDARY), so it walls the lui off from its own
       * delay slot.  Moving the fence BELOW the if/else keeps the pseudo real (cse
       * still cannot fold across it) while leaving the lui as the last insn before the
       * branch => reorg fills the slot => PASS.  General rule: when an opacity fence is
       * used to mint a constant for a DELAY SLOT, the fence must sit AFTER the consumer,
       * never between the def and the branch. */
      int latBias;
      latBias = 0x60000;
      if (forceLatAction != 0) {
        latOffset = (this->targetCar_->N).dimension.x + latBias;
      }
      else {
        latOffset = (this->relPosition_).x;
      }
      __asm__("" : "=r"(latBias) : "0"(latBias));
      targetLanePosition = (this->delayCar_).roadPosition_ + latOffset * dir;
      /* W62-A9 EAGER-SUM BARRIER: retail completes this sum inside the mult
       * latency (`lw v0,76; mult; lw v0,56; mflo t1; addu a0,v0,t1`); without
       * the barrier sched1 hoists the whole slicePtr chain into that window and
       * defers the mflo/add past it, which rotated the entire t/caller band
       * (targettingStrength a3 instead of t0).  78 -> 59 on its own. */
      __asm__("" : : "i"(0));

      slicePtr = ((this->carObj_)->N).simRoadInfo.slice * 0x20 + (int)AIState_BWorldSmSlices;

      /* W62-A9 CLAMP FUNNEL (SYM 8c: retail declares ONLY targettingStrength ($8=t0)
       * and targetLanePosition ($4=a0) -- latOffset/slicePtr are Ghidra-invented, so
       * each clamp used a FRESH block temp and copied BACK into targetLanePosition.
       * That is what mints retail's two `addu a0,<tmp>,zero` funnel copies.  The
       * `<< 0xf` spelling (not `* 0x8000`) keeps the shift on the FIRST factor --
       * with `* 0x8000` gcc reassociates it onto the other operand and swaps the
       * mult's operand registers.  59 -> 27 (funnel) -> 15 (shift form). */
      {
        int limit = -(((u_int)*(u_char *)(slicePtr + 0x1e) << 0xf) * (u_int)(*(u_char *)(slicePtr + 0x1d) >> 4));
        if (limit < targetLanePosition) {
          limit = targetLanePosition;
        }
        targetLanePosition = limit;
      }
      {
        int limit = ((u_int)*(u_char *)(slicePtr + 0x1f) << 0xf) * (u_int)(*(u_char *)(slicePtr + 0x1d) & 0xf);
        if (targetLanePosition < limit) {
          limit = targetLanePosition;
        }
        targetLanePosition = limit;
      }
    }

    (this->carObj_)->preferredLateralPosition = targetLanePosition;
    (this->carObj_)->preferredLateralPositionPower = targettingStrength;
  }

  this->CheckForBarriersAndTargetAroundThem();
  AI_GenericCycle(this->carObj_);
  AI_GenericEndCycle(this->carObj_);
}








/* ---- ApproachTargeting__13AIState_Chasei  AIState_Chase::ApproachTargeting  [AISTATE.CPP:637-713] SLD-VERIFIED ---- */

void AIState_Chase::ApproachTargeting(int intercept)



{
  int xDistance;
  int zDistance;
  int distance;
  int minSpeed;

  int iVar5;
  Car_tObj *pCVar4;

  

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

  iVar5 = AIState_SimGlobalWords[1];

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

  pCVar4 = this->carObj_;

  if (pCVar4->direction == 1) {
    iVar5 = minSpeed;
    if (pCVar4->desiredSpeed < iVar5) {
      iVar5 = pCVar4->desiredSpeed;
    }
  } else {
    iVar5 = -minSpeed;
    if (iVar5 < pCVar4->desiredSpeed) {
      iVar5 = pCVar4->desiredSpeed;
    }
  }
  pCVar4->desiredSpeed = iVar5;

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

  bVar1 = *(u_char *)(mySlice * 0x20 + (int)AIState_BWorldSmSlices + 0x1d);

  targetSlice = (this->targetCar_->N).simRoadInfo.slice;

  targetLane = this->targetCar_->laneIndex;

  if (myLane < 6 - (bVar1 >> 4)) return;

  if ((bVar1 & 0xf) + 7 < myLane) return;

  bVar2 = *(u_char *)(targetSlice * 0x20 + (int)AIState_BWorldSmSlices + 0x1d);

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
/* MATCH: IDA/SYM register allocation and the raw SLD line trace recover both
   mirrored scan scopes. Keeping gNumSlices-6 as an explicit branch-local
   temporary and spelling the non-wrapping return arm first preserves retail's
   v0 result web and branch layout. */

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

  {
    int sliceLoop;

    for (sliceLoop = 0; sliceLoop < 0x53; sliceLoop += 4) {
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
            (6 - (AISTATE_SLICE_BYTE(sliceCheck,0x1d) >> 4) <= currentBarrierLane - 1) &&
            (currentBarrierLane - 1 <=
             (AISTATE_SLICE_BYTE(sliceCheck,0x1d) & 0xf) + 7)) {

          currentBarrierLane--;

        }

        else if ((rightBarrier == 0) ||
                 (currentBarrierLane + 1 <
                  6 - (AISTATE_SLICE_BYTE(sliceCheck,0x1d) >> 4)) ||
                 ((AISTATE_SLICE_BYTE(sliceCheck,0x1d) & 0xf) + 7 <
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
  }

  currentBarrierLane = barrierLane;

  {
    int sliceLoop;

    for (sliceLoop = 0; sliceLoop < 0x53; sliceLoop += 4) {
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
            (6 - (AISTATE_SLICE_BYTE(sliceCheck,0x1d) >> 4) <= currentBarrierLane - 1) &&
            (currentBarrierLane - 1 <=
             (AISTATE_SLICE_BYTE(sliceCheck,0x1d) & 0xf) + 7)) {

          currentBarrierLane--;

        }

        else if ((rightBarrier == 0) ||
                 (currentBarrierLane + 1 <
                  6 - (AISTATE_SLICE_BYTE(sliceCheck,0x1d) >> 4)) ||
                 ((AISTATE_SLICE_BYTE(sliceCheck,0x1d) & 0xf) + 7 <
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
  }

  if (forwardBarrierDistance < backwardsBarrierDistance) {

    if (forwardBarrierEndSlice + 6 < gNumSlices) {
      return forwardBarrierEndSlice + 6;

    }

    {
      int numSlicesLess6 = gNumSlices - 6;
      return forwardBarrierEndSlice - numSlicesLess6;
    }

  }

  if (backwardsBarrierEndSlice - 6 < 0) {
    int numSlicesLess6 = gNumSlices - 6;

    return backwardsBarrierEndSlice + numSlicesLess6;

  }

  return backwardsBarrierEndSlice - 6;

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

  this->targetPosition_ = *(coorddef *)((char *)AIState_BWorldSmSlices + endSlice * 0x20);

  pCVar3 = this->carObj_;

  pCVar3->carFlags = pCVar3->carFlags | 0x800;

  return;

}








/* ---- UnleashIfInRange__15AIState_OffroadP8Car_tObj  AIState_Offroad::UnleashIfInRange  [AISTATE.CPP:926-936] SLD-VERIFIED ---- */
/* IDA's retail register annotations expose the original max-threshold expression:
   a single comparison against a ternary-selected limit. This produces the oracle's
   branch-delay comparison and two separate 0x140000 materializations (30/30 PASS). */

void AIState_Offroad::UnleashIfInRange(Car_tObj *car)



{
  int distanceAbsMeters;
  int releaseDistanceMeters;

  int iVar2;

  

  iVar2 = AIWorld_SplineDistance(this->carObj_,car);

  distanceAbsMeters = __builtin_abs(iVar2);

  releaseDistanceMeters = fixedmult((car->N).speedXZ,this->releaseTime_);

  if (distanceAbsMeters <
      ((releaseDistanceMeters < 0x140000) ? 0x140000 : releaseDistanceMeters)) {
    this->letGo_ = 1;
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
   WALL (register-coloring near-miss) -- same root symptom as the AIState_Offroad dtor (see
   its WALL comment): oracle copies pThis a0->a3 up front (this fn's bigger body needs a3 not
   a2, one more caller-saved reg already in play), ours keeps pThis in a0. Same gcc-2.x
   allocator coin-flip; documented near-miss.
   [w30-a2 re-gate, baselines moved per wave-30 note 1: now 14 diffs/72 insns, both sides --
   someone closed most of the original 79-diff gap since this comment was written; comment
   left/updated rather than deleted since the residual symptom is unchanged. FLOOR confirmed
   again this session: the `iVar2 = Cars_gNumCars-1` reverse-scan loop index lands in a2 (ours)
   vs a0 (oracle) -- a0 is free right after the `pThis` a0->a3 copy on both sides, oracle's
   allocator just prefers the lowest-numbered free temp, ours doesn't; same coin-flip class,
   not a shape bug. */

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
  Car_tObj **sortedList;



  pCVar1 = pThis->carObj_;

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Purgatory_vtable;

  (pCVar1->collision).resetTimer = 0;

  ((pThis->carObj_)->N).collision.disableCollisionTimer = 0;

  pCVar2 = pThis->carObj_;

  pCVar2->AIFlags = pCVar2->AIFlags & 0xfffffffb;

  if (((pThis->carObj_)->carFlags & 0x10U) != 0) {

    AIState_Purgatory_numTrafficCarsInPurgatory = AIState_Purgatory_numTrafficCarsInPurgatory + -1;

  }

  pCVar4 = pThis->carObj_;

  pCVar4->direction = 1;

  pCVar4->desiredDirection = 1;

  /* W54-A15 / LAW 05A: the SLD puts the whole loop header (index init, the sortedList base
   * materialization, the scaled-index add and the `bltz` test) on retail line 1034 -- i.e.
   * AFTER the line-1031 direction/desiredDirection stores; our loop-init statements sat
   * BEFORE them, which flipped the sll-vs-la ready-list order.  The read-only fence is a
   * 0-insn +1 ref on iVar2 (5->6 = the floor_log2 step), the MINIMAL reqdelta dial that
   * swaps iVar2/ppCVar3 onto retail's $a0/$a2 (ours had them reversed).
   * HISTORICAL RESIDUAL 2 diffs (72/72): the `sll v1,a0,2` scheduled before
   * the &Cars_gSortedList base (lui/addiu) in ours, after it in retail -- a pure
   * sched1 ready-list tie.  W56-A16 FALSIFIED: `&Cars_gSortedList[iVar2]`
   * index-form is BYTE-IDENTICAL to the `+iVar2` pointer-form (no change);
   * moving the fence above the ppCVar3 assign regresses (19 diffs).  §4.6
   * qtytrace gap -- not source-reachable.  W59-A3 also FALSIFIED the 09I CAST-INT
   * ARRAY SUBSCRIPT device on this site: both `(Car_tObj**)((iVar2<<2)+(int)Cars_gSortedList)`
   * and the operand-swapped `((int)Cars_gSortedList+(iVar2<<2))` are byte-identical to
   * the pointer form (still 2 diffs) -- address-block-order pinning does not reach a
   * sll-vs-la ready-list tie.
   * W60-A8 r2 showed the SPLIT-INIT (`ppCVar3 = Cars_gSortedList;` then
   * `ppCVar3 = ppCVar3 + iVar2;`) DOES flip the sll/la order to retail's, but floats
   * the whole address block above the line-1031 stores and drops a load-delay nop
   * (15 diffs / 71 insns).  W61-A12 then falsified the obvious completion -- pinning
   * the block's POSITION with a void-tail barrier so the split cannot float:
   * `__asm__("" : : "i"(0))` before the loop init + split -> 21 / 71; the barrier
   * placed between iVar2 and the split -> 19 / 71; the barrier ALONE (no split,
   * baseline shape) -> 24 / 72.  The barrier moves the block itself instead of
   * anchoring it, so a scheduling-barrier device cannot buy the position back.
   * What is needed is a statement-local, NON-barrier ready-list dial.
   * W62-A9: the SOURCE axis is now CLOSED and the fn is SOLVED by a
   * PER_FN_TEXT_MOVES row (probe-verified PASS 72/72, whole-TU 51/52; the
   * EXTRA={} control on the same probe reproduces 2).  ORCHESTRATOR SPEC --
   * a new key inside the "recon/game/common/aistate.cpp" entry of
   * PER_FN_TEXT_MOVES (that file key does not exist yet; create it).  The exact
   * python row is in scratchpad/w62a9/spec_purg.py -- copy it from there, it is
   * regex-escaped: take = the sll of $3 from $4 by 2, after = the addiu of $2
   * carrying %lo(Cars_gSortedList) with a trailing-comment tail.  Both anchors
   * are unique inside the .ent/.end region (12F).
   * WHY no source form reaches it (mechanism, now named): the base is an
   * ARRAY, so `Cars_gSortedList + i` folds to PLUS(MULT, ADDR) -- the address
   * is TREE_CONSTANT and is canonicalised to operand 2, so expand ALWAYS emits
   * the sll first; retail's order needs the ADDR as operand 1.  W62-A9 ALSO
   * FALSIFIED (on top of the earlier index/cast/barrier lists): the plain
   * `iVar2 + Cars_gSortedList` operand swap (2, inert); a 13B IDENTITY-LAUNDER
   * on a `Car_tObj **base` local (19/71); the launder without the ref fence
   * (19/71); split-init plus a launder on ppCVar3 (19/71).  Every split form
   * loses the load-delay nop (71 insns, not 72).
   * W78-root SOURCE PASS 72/72: comma-stage the base assignment into the
   * correctly typed `Car_tObj **sortedList` local inside the final pointer
   * expression.  This preserves the count/allocation and changes expand's
   * operand birth order just enough to emit the retail lui/addiu before sll.
   * No post-cc1 relocation is required. */
  iVar2 = Cars_gNumCars + -1;

  ppCVar3 = (sortedList = Cars_gSortedList, sortedList + iVar2);

  __asm__("" : : "r"(iVar2));

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
  int trafficInWorld;

  if (this->carObj_->physicsModelTimer < 1) {
    trafficInWorld = Cars_gNumTrafficCars - AIState_Purgatory_numTrafficCarsInPurgatory;

    if (trafficInWorld <
        AITune_MaxTraffic[AIState_GameSetupWords[3] == 1][AIState_GameSetupWords[6]]) {

      return 1;

    }

    this->carObj_->physicsModelTimer = 1;

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

  if (((pCVar1->carFlags & 0x20U) == 0) && (0x3bf < AIState_SimGlobalWords[1])) {

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

  /* W54-A15: identity/opacity fence (0 insns) -- gcc otherwise proves the incoming $a1 still
   * holds otherCarObj at the first SplineDistance call and DELETES the arg copy, leaving a
   * nop in the jal slot; retail rematerializes `addu a1,s0,zero` there. */
  __asm__("" : "=r"(otherCarObj) : "0"(otherCarObj));

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

  /* CORRECTNESS (w65-a2, REVERSES the w13-a5 note above it): retail's `blez $s0` at
     0x80071A0C encodes offset 0x000F -> .L80071A4C = the EPILOGUE, NOT the
     `sw $zero,0($s3)` one word earlier (.L80071A48, which only the
     `0xC0000 < distance` guard's `bnez` at 0x80071930 reaches).  So retail leaves
     *status UNTOUCHED on the sum<=0 path; `goto LAB_STATUS0` here wrote a 0 the
     original never wrote.  The gate could never see it (verify_asm normalises every
     branch TARGET to `T`); `tools/brdist.py` reported it as (9, 15, 16).  Bare
     `return;` reproduces retail's branch word and drops the spurious store. */

  if (sum <= 0) return;

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

  Car_tObj *pCVar4;

  int iVar8;

  int iVar9;

  Car_tObj **ppCVar10;

    /* W57-A11: SLD gives ONE retail line (1177) for the whole 3-word copy and the oracle
     uses t0/t1/t2 -- that is gcc's movstrsi 12-byte STRUCT ASSIGNMENT, not three per-field
     statements (catalog 3d(a)). */
  this->carObj_->targetPos = this->path_[this->pathIndex_].position;

  (this->carObj_)->desiredSpeed = this->path_[this->pathIndex_].targetSpeed * 0x7247;

  /* W57-A11: SLD line 1183 = one struct assignment (movstrsi t0/t1/t2). */
  centerBack = *(coorddef *)(AIState_BWorldSmSlices + this->carObj_->N.simRoadInfo.slice * 0x20);

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

  iVar9 = carRelativeForDistance.x >> 0xc;

  carRelativeForDistance.y = this->carObj_->targetPos.y - this->carObj_->N.position.y;

  carRelativeForDistance.z = this->carObj_->targetPos.z - this->carObj_->N.position.z;

  iVar8 = carRelativeForDistance.z >> 0xc;

  carRelativeForDistance.x = iVar9;

  carRelativeForDistance.z = iVar8;

  if (carRelativeForDistance.x * carRelativeForDistance.x +
      carRelativeForDistance.z * carRelativeForDistance.z < 10000) {

    if (this->waitTick_ == 0) {

      this->waitTick_ = AIState_SimGlobalWords[1] + this->path_[this->pathIndex_].waitTime;

    }

    if (AIState_SimGlobalWords[1] < this->waitTick_) {

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

  /* EXIT-IN-THE-MIDDLE (catalog §B row 51/56) -- oracle keeps a single TOP-test
     block reached both by fallthrough and by an unconditional j back-edge; a
     natural while(cond){...} gets ROTATED by gcc to a bottom bnez-test. */

  while (true) {

    if (!(search < Cars_gNumCars && (status == 2))) break;

    pCVar4 = *ppCVar10;

    this->CheckIfCarIsNearbyAndStop(pCVar4,status);

    ppCVar10 = ppCVar10 + 1;

    search = search + 1;

  }

  if (status != 1) {

    status = 2;

    search = (this->carObj_)->sortIndex + -1;

    ppCVar10 = Cars_gSortedList + search;

    while (true) {

      if (!(-1 < search && (status == 2))) break;

      pCVar4 = *ppCVar10;

      this->CheckIfCarIsNearbyAndStop(pCVar4,status);

      ppCVar10 = ppCVar10 + -1;

      search = search + -1;

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
/* PASS (319 insns): IDA's retail register annotations and the SYM SLD line trace
   recovered the real locals, scopes, and statement boundaries.  The candidate
   fence must precede the copy so the copy fills the jump delay slot; spelling
   the slice-table access as an integer byte address gives forwardSlice/result
   v0 and the table base v1, matching retail's allocation. */

void AIState_Donuts::Execute()



{
  coorddef right;
  coorddef forward;
  coorddef targetPos;
  int latPos;
  int slice;
  int forwardDot;



  {
    Car_tObj *carObj = this->carObj_;

    slice = (int)carObj->N.simRoadInfo.slice;

    forwardDot =
        (carObj->N.orientMat.m[6] / 256) * (carObj->N.roadMatrix.m[6] / 256) +
        (carObj->N.orientMat.m[7] / 256) * (carObj->N.roadMatrix.m[7] / 256) +
        (carObj->N.orientMat.m[8] / 256) * (carObj->N.roadMatrix.m[8] / 256);

    if (forwardDot > 0) {

      forwardDot = 1;

    }

    else {

      forwardDot = -1;

    }

    carObj->desiredDirection = carObj->direction = forwardDot;
  }

  if ((this->donutMode_ == 1) || (this->donutMode_ == 3)) {

    int forwardSlice;
    int forwardDot;
    int dCarToCenter;
    int numSlicesLess3;

    forwardDot =
        (this->carObj_->N.orientMat.m[6] / 256) * (this->carObj_->N.roadMatrix.m[6] / 256) +
        (this->carObj_->N.orientMat.m[7] / 256) * (this->carObj_->N.roadMatrix.m[7] / 256) +
        (this->carObj_->N.orientMat.m[8] / 256) * (this->carObj_->N.roadMatrix.m[8] / 256);

    if (0 <= forwardDot)

    {
      int candidateSlice = slice + 3;
      /* W54-A15: identity/opacity fence (0 insns) -- otherwise local-alloc TIES candidateSlice
       * to forwardSlice, the then-arm becomes EMPTY and gcc inverts the branch (ours 317 vs
       * retail 319: retail keeps `addu v0,v1,zero; j` as a real arm and branches `beqz`). */
      if (candidateSlice < gNumSlices) {
        __asm__("" : : "r"(candidateSlice));
        forwardSlice = candidateSlice;
      }
      else {
        numSlicesLess3 = gNumSlices - 3;
        forwardSlice = slice - numSlicesLess3;
      }

    }

    else {

      forwardSlice = slice + -3;
      if (forwardSlice < 0) {
        numSlicesLess3 = gNumSlices - 3;
        forwardSlice = slice + numSlicesLess3;
      }

    }

    {
      coorddef &sliceCenter = *(coorddef *)((forwardSlice << 5) + (int)AIState_BWorldSmSlices);
      targetPos = sliceCenter;
    }

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
          -((AISTATE_SLICE_BYTE(slice,0x1e) << 15) *
            (AISTATE_SLICE_BYTE(slice,0x1d) >> 4))) goto LAB_800722e8;

      goto LAB_800722ec;

    }

    else {

      if (!((AISTATE_SLICE_BYTE(slice,0x1f) << 15) *
            (AISTATE_SLICE_BYTE(slice,0x1d) & 0xf) <
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

    /* W54-A15: retail's two signed arms each build a LIMIT (a2) and a boolean (v0) and then
       share ONE tail `if (inRange) limit = speed; carObj->desiredSpeed = limit;` -- the
       cross-jumped shape (oracle: `bltz a3,Lneg [a2=cap]` / `j Ltest [slt v0,a3,a2]` /
       `negu a2,a0; slt v0,a2,a3` / `beqz v0; nop; addu a2,a3,zero; sw a2`).  The previous
       per-arm field-assignment form duplicated the tail (74 vs 70 insns). */
    {
      Car_tObj *carObj = this->carObj_;
      int desiredSpeed = carObj->desiredSpeed;
      /* W54-A15 REF-STEP (reqdelta): +1 ref on carObj (3->4 = the floor_log2 1->2 step) is the
         MINIMAL dial that moves the speed CAP off $a3 onto retail's $a0 (and desiredSpeed
         a2->a3); 0 insns. */
      __asm__("" : : "r"(carObj));
      int limit;
      int inRange;

      if (desiredSpeed >= 0) {
        limit = cap;
        inRange = desiredSpeed < limit;
      } else {
        limit = -cap;
        inRange = limit < desiredSpeed;
      }
      /* W54-A15 REF-STEP #2 (reqdelta): +1 ref on inRange (3->4 floor_log2 step) rotates the
         desiredSpeed/limit/inRange trio onto retail's $a3/$a2/$v0; 0 insns. */
      __asm__("" : : "r"(inRange));
      if (inRange) {
        limit = desiredSpeed;
      }
      carObj->desiredSpeed = limit;
    }

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

extern "C" void Execute__17AIState_NonActive_80072750(AIState_NonActive *pThis)

{

  return;

}




/* ---- func_80072758  AIState_NonActive's deleting destructor [rule-8, w30-a2] ----
   SECOND compiled instance of ~AIState_NonActive (see func_80072750 comment -- canonical name
   ___17AIState_NonActive already claimed by the instance at 0x8005F62C). Same shape as
   ___17AIState_Purgatory's tail (own-class vtable -> mark carObj_->N.active -> AIState_Base_vtable
   -> conditional delete).
   PROOF: rdata_80054548.rodata.s @0x800555B4 (AIState_NonActive_vtable dtor slot) holds the
   literal word `func_80072758`; the two lui/addiu loads in the oracle (D_800555A0, D_80055640)
   are the exact VAs of AIState_NonActive_vtable and AIState_Base_vtable materialized in
   vtables_aistate.cpp. */

extern "C" void ___17AIState_NonActive_80072758(AIState_NonActive *pThis,int __in_chrg)



{

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_NonActive_vtable;

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




/* ---- func_80072830  AIState_Base::TestForRelease  [rule-8, w30-a2] ----
   SECOND compiled instance of AIState_Base::TestForRelease (canonical name
   TestForRelease__12AIState_Base already claimed by the instance at 0x8005B4C4). This is the
   SHARED default impl (return 0) used by every AIState subclass that does not override
   TestForRelease -- confirmed by rdata_80054548.rodata.s: the literal word `func_80072830`
   fills the TestForRelease slot of AIState_NonActive_vtable (@0x800555BC), AIState_Offroad's
   _vt (@0x800555DC), AIState_Chase's _vt (@0x800555FC), AIState_Idle's _vt (@0x8005561C),
   AIState_Normal's _vt (@0x8005563C) AND AIState_Base_vtable itself (@0x8005565C). */

extern "C" int TestForRelease__12AIState_Base_80072830(AIState_Base *pThis)

{

  return 0;

}




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

extern "C" void ___12AIState_Base_80072838(AIState_Base *pThis,int __in_chrg)



{


  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;

  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }

  return;

}








/* W54-A15: the CANONICAL-mangled AIState_Base::TestForRelease / ~AIState_Base bodies
 * (TestForRelease__12AIState_Base @0x8005B4C4, ___12AIState_Base @0x8005B4CC) belong to
 * the AIHIGH object per configs/symbol_addrs.txt -- MOVED to aihigh.cpp so that unit
 * emits them (they were 0.00% NOT-IN-OBJECT there).  aistate keeps only its own
 * VA-suffixed vague-linkage duplicates at 0x80072830 / 0x80072838 (above). */

/* end of aistate.cpp */
