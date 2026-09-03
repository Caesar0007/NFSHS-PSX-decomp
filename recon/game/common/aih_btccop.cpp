/* game/common/aih_btccop.cpp -- RECONSTRUCTED (Beat-the-Clock cop AI hierarchy; C++ TU)
 *   40 fns across 3 classes (AIHigh_BTC_Cop -> AIHigh_BTC_HumanCop; AIHigh_BTC_Wingman)
 *   + AIState_NonActive tail. Composition-modeled inheritance (_base_ members); manual _vf
 *   vtable dispatch (8-byte __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs
 *   AIHigh_BTC_<C>_vtable. Faithful C++ (option A). NOT original; SYM-faithful, recompilable.
 *   vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aih_btccop_types.h"
#include "aih_btccop_externs.h"

extern int AI_elapsedTime;   /* H19: ai.cpp @0x8013C554 (not in this TU's externs) */
extern char gBlockadeTypes[5];

/* ---- aih_btccop.obj-owned .data statics (8-byte run @0x8013c560, byte-exact vs NFS4.EXE = {0,1}) ---- */
/* SYM/MAP: _19AIHigh_BTC_HumanCop.lastInputRequestTick_. */
int AIHigh_BTC_HumanCop::lastInputRequestTick_ = 0;   /* @0x8013c560 */
/* anonymous file-static toggle (no SYM name) immediately following; image value 1 (engaged). */
/* SYM-GLOBAL-CARRIER: AIH_BTCCop_freezeToggle_8013c564
   The retail load/stores and initialized word at 0x8013c564 prove this object,
   but neither SYM nor MAP retains its original source identifier. */
int   AIH_BTCCop_freezeToggle_8013c564 = 1;               /* @0x8013c564 */

/* ---- aih_btccop.obj-owned globals (.bss zero) ---- */
int          AIH_BTC_Cop_1HC1HP_StageTimes[3] = { 60, 60, 60 };   /* @0x8010cd98 */
coorddef     AIH_BTCCop_chasePositions[3][6] = { { {0, 0, 720896}, {-524288, 0, 0}, {0, 0, -983040}, {0, 0, -983040}, {0, 0, -983040}, {0, 0, -983040} }, { {0, 0, 524288}, {-393216, 0, 524288}, {393216, 0, 0}, {0, 0, -655360}, {0, 0, -655360}, {0, 0, -655360} }, { {0, 0, 327680}, {-262144, 0, 327680}, {262144, 0, 327680}, {0, 0, -327680}, {0, 0, -327680}, {0, 0, -327680} } };   /* @0x8010cda4 */


/* ---- __14AIHigh_BTC_CopP8Car_tObji  AIHigh_BTC_Cop::ctor  [AIH_BTCCOP.CPP:107-111] SLD-VERIFIED ---- */
AIHigh_BTC_Cop::AIHigh_BTC_Cop(Car_tObj *carObj,int copIndex)



{

  (new((AIHigh_BasicCop *)this) AIHigh_BasicCop(carObj,copIndex));

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_BTC_Cop_vtable;

  this->perpTarget_ = (AIHigh_BTC_Perp *)0x0;

  this->chaseIndex_ = 0;

  this->freezeMode_ = 0;

  return;

}








/* ---- AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::AssignToPlayer  [AIH_BTCCOP.CPP:115-126] SLD-VERIFIED ---- */

void AIHigh_BTC_Cop::AssignToPlayer(AIHigh_BTC_Perp *target)



{

  if (this->perpTarget_ != (AIHigh_BTC_Perp *)0x0) {

    ((AIHigh_BasicPerp *)this->perpTarget_)->RemoveChaser(this->copIndex_,

               (this->carObj_)->carIndex,(copType)this->type_);

  }

  this->perpTarget_ = target;

  if (target != (AIHigh_BTC_Perp *)0x0) {

    ((AIHigh_BasicPerp *)target)->AddChaser(this->copIndex_,

               (this->carObj_)->carIndex,(copType)this->type_);

  }

  return;

}








/* ---- GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef  AIHigh_BTC_Cop::GetCheckChasePosition  [AIH_BTCCOP.CPP:130-148] SLD-VERIFIED ---- */

int AIHigh_BTC_Cop::GetCheckChasePosition(coorddef *pos)



{
  int newPosition;
  int changed;



  changed = 0;

  if ((newPosition = ((AIHigh_BasicPerp *)this->perpTarget_)->CheckChaserPosition(this->copIndex_,

                     (this->carObj_)->carIndex)) != this->chaseIndex_) {

    changed = 1;

    this->chaseIndex_ = newPosition;

  }

  *pos = AIH_BTCCop_chasePositions[0][this->chaseIndex_];

  return changed;

}








/* ---- CheckForNewTarget__14AIHigh_BTC_Cop  AIHigh_BTC_Cop::CheckForNewTarget  [AIH_BTCCOP.CPP:154-206] SLD-VERIFIED ---- */

int AIHigh_BTC_Cop::CheckForNewTarget()



{
  AIHigh_BTC_Perp*newTarget;
  int newTargetDistance;
  int perpLoop;
  AIHigh_BTC_Perp*old;

  newTarget = (AIHigh_BTC_Perp *)0x0;

  newTargetDistance = 0x27100000;

  old = this->perpTarget_;

  for (perpLoop = 0; perpLoop < Cars_gNumRaceCars; perpLoop = perpLoop + 1) {

    Car_tObj*testPerpCarObj;
    int thisPerpCarIndex;
    AIHigh_BTC_Perp*thisPerpHigh;

    testPerpCarObj = Cars_gRaceCarList[perpLoop];

    if ((((testPerpCarObj->N).active != '\0') && ((testPerpCarObj->carFlags & 0x200U) == 0)) &&

       (thisPerpCarIndex = testPerpCarObj->carIndex,

       thisPerpHigh = (AIHigh_BTC_Perp *)highLevelAIObjs[thisPerpCarIndex],

       (thisPerpHigh)->basicPerpInfo_.crime_ != 0)) {

      int copToTargetDistanceMeters;

      copToTargetDistanceMeters = __builtin_abs(AIWorld_ApxSplineDistance(this->carObj_,testPerpCarObj));

      if (copToTargetDistanceMeters < newTargetDistance) {

        newTargetDistance = copToTargetDistanceMeters;

        newTarget = thisPerpHigh;

      }

    }

  }

  if ((newTarget != (AIHigh_BTC_Perp *)0x0) && (newTarget != old)) {

    this->AssignToPlayer(newTarget);

    return 1;

  }

  else {

    if ((old != (AIHigh_BTC_Perp *)0x0) && (newTarget == (AIHigh_BTC_Perp *)0x0)) {

      this->AssignToPlayer((AIHigh_BTC_Perp *)0x0);

    }

    return 0;

  }

}








/* ---- StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::StartArrest  [AIH_BTCCOP.CPP:213-250] SLD-VERIFIED ---- */

void AIHigh_BTC_Cop::StartArrest(AIHigh_BTC_Perp *arrestMe)



{
  if (this->freezeMode_ == 0) {
    this->freezeMode_ = 3;

    if ((this->carObj_->carFlags & 0x200U) != 0) {
      Speech_Mobile(this->carObj_)->Catch(1);

    }

  }

  return;

}








/* ---- FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::FinishArrest  [AIH_BTCCOP.CPP:253-280] SLD-VERIFIED ---- */

void AIHigh_BTC_Cop::FinishArrest(AIHigh_BTC_Perp *arrestMe)



{
  if ((this->freezeMode_ == 3) || (this->freezeMode_ == 0)) {
    this->freezeMode_ = 4;

    (**(int (**)(...))((int)*this->_vf + 0x1c))

              ((int)&this->carObj_ + (int)*(short *)((int)*this->_vf + 0x18));

    this->HudOff();

  }

  return;

}








/* ---- FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::FalseArrest  [AIH_BTCCOP.CPP:283-293] SLD-VERIFIED ---- */

void AIHigh_BTC_Cop::FalseArrest(AIHigh_BTC_Perp *cantArrestMe)



{

  if (this->perpTarget_ == cantArrestMe) {

    this->freezeMode_ = 2;

  }

  return;

}








/* ---- FreezeAndEndChase__14AIHigh_BTC_Cop  AIHigh_BTC_Cop::FreezeAndEndChase  [AIH_BTCCOP.CPP:296-302] SLD-VERIFIED ---- */

void AIHigh_BTC_Cop::FreezeAndEndChase()



{

  return;

}








/* ---- HudOff__14AIHigh_BTC_Cop  AIHigh_BTC_Cop::HudOff  [AIH_BTCCOP.CPP:305-311] SLD-VERIFIED ---- */

void AIHigh_BTC_Cop::HudOff()



{

  if (this->copIndex_ == 0) {

    Hud_BustedOverlayOff();

  }

  return;

}








/* ---- __19AIHigh_BTC_HumanCopP8Car_tObji  AIHigh_BTC_HumanCop::ctor  [AIH_BTCCOP.CPP:326-369] SLD-VERIFIED ---- */
AIHigh_BTC_HumanCop::AIHigh_BTC_HumanCop(Car_tObj *carObj,int copIndex)



{
  int startMovement;
  int startDirection;
  int startSlice;
  int addToSlice;
  int bend;

  

  (new((AIHigh_BTC_Cop *)this) AIHigh_BTC_Cop(carObj,copIndex));

  this->_vf =

       (__vtbl_ptr_type (*) [3])AIHigh_BTC_HumanCop_vtable;

  this->initialMovement_ = 1;

  this->currentStage_ = -1;

  this->stageTimeMultiplier_ = 0x10000;

  this->needPerp_ = 0;

  this->initialDirection_ = 0;

  this->requestedDesiredSpeed_ = 0;

  this->stageRepeatCount_ = 0;

  this->timeLeft_ = AITune_BTC[GameSetup_gData.skill].baseChaseTime;

  this->carObj_->unlap = 0;

  lastInputRequestTick_ = 0;

  AILife_PlaceCarAtLocation(this->carObj_,0,0,1,0,0);

  if (copIndex == 0) {

    startDirection = -1;

    randtemp = fastRandom * randSeed;

    fastRandom = randtemp & 0xffff;

    if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 500) {

      startDirection = 1;

    }

    randtemp = fastRandom * randSeed;

    fastRandom = randtemp & 0xffff;

    startMovement = 0;

    if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 0x2ee) {

      startMovement = (u_int)(AIHigh_CopGameType != COP_GAME_BTC_1HC1HP);

    }

    startSlice = this->FindRandomBarrierFreeArea(0,100,500);

    if (((this->currentStage_ + 1) & 1) == 0) {

      addToSlice = startDirection * 7;

    } else {

      addToSlice = -(startDirection * 7);

    }

    __asm__("" : : "r" (addToSlice), "r" (startSlice));  /* liveness fence: original keeps the dead slice-adjust calc */

    bend = AIWorld_CalcRoadBend(this->carObj_,3);

    if (bend < 0) {

      bend = -bend;

    }

    if ((0x5eb8 < bend) && (AIHigh_CopGameType != COP_GAME_BTC_1HC1HP)) {

      startMovement = 1;

    }

    this->NewStage((int)((this->carObj_)->N).simRoadInfo.slice,startDirection,startMovement);

  }

  return;

}








/* ---- FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii  AIHigh_BTC_HumanCop::FindRandomBarrierFreeArea  [AIH_BTCCOP.CPP:379-392] SLD-VERIFIED ---- */

int AIHigh_BTC_HumanCop::FindRandomBarrierFreeArea(int startSlice,int safetyZone,int randomDistance)



{
  int newOffset;
  int newSlice;



  randtemp = fastRandom * randSeed;

  fastRandom = randtemp & 0xffff;

  /* SYM-CODEGEN-CARRIER: doubledFraction -- absent from retail debug locals,
   * but direct expression folding produces 4 oracle diffs. */
  int doubledFraction;

  doubledFraction = (randtemp >> 8 & 0xffff) * 2;

  newOffset = (int)((u_int)(randomDistance * doubledFraction) >> 0x10) - randomDistance;

  if (0 <= newOffset) {

    newSlice = startSlice + newOffset;

    if (gNumSlices <= newSlice) {

      newSlice = newSlice - gNumSlices;

    }

  }

  else {

    newSlice = startSlice + newOffset;

    if (newSlice < 0) {

      newSlice = newSlice + gNumSlices;

    }

  }

  {
    int maxRuns;

    maxRuns = 0;
    while (maxRuns < 30) {
      int startCheckSlice;
      int leftLaneFree;
      int rightLaneFree;

      startCheckSlice = newSlice - safetyZone;

    if (0 <= -safetyZone) {

      if (gNumSlices <= startCheckSlice) {

        startCheckSlice = startCheckSlice - gNumSlices;

      }

    }

    else {

      if (startCheckSlice < 0) {

        startCheckSlice = startCheckSlice + gNumSlices;

      }

    }

    leftLaneFree = AIWorld_IsDriveableLaneInSliceRange(startCheckSlice,safetyZone << 1,1,6);

    rightLaneFree = AIWorld_IsDriveableLaneInSliceRange(startCheckSlice,safetyZone << 1,1,7);

    if ((leftLaneFree != 0) && (rightLaneFree != 0)) {

      break;

    }

    if (0 <= safetyZone / 5) {

      newSlice = (newSlice + safetyZone / 5 < gNumSlices) ?
                 newSlice + safetyZone / 5 :
                 newSlice + safetyZone / 5 - gNumSlices;

    }

    else {

      newSlice = (0 <= newSlice + safetyZone / 5) ?
                 newSlice + safetyZone / 5 :
                 newSlice + safetyZone / 5 + gNumSlices;

    }

      maxRuns++;
    }
  }

  return newSlice;
}








/* ---- ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp  AIHigh_BTC_HumanCop::ReleaseAndStartChase  [AIH_BTCCOP.CPP:399-419] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::ReleaseAndStartChase(AIHigh_BTC_Perp *newPerp)



{

  this->carObj_->AIFlags = this->carObj_->AIFlags | 2;

  this->CheckForNewTarget();

  if (this->perpTarget_ == newPerp) {

    this->freezeMode_ = 2;

    this->chaseStartTime_ = simGlobal.gameTicks;

  }

  this->ResetClearTrafficToPurgatory();

  return;

}








/* ---- FreezeAndEndChase__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::FreezeAndEndChase  [AIH_BTCCOP.CPP:425-456] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::FreezeAndEndChase()



{
  if (this->copIndex_ == 0) {
    int startDirection;
    int startSlice;
    int startMovement;
    int addToSlice;

    startDirection = -1;

    randtemp = fastRandom * randSeed;

    fastRandom = randtemp & 0xffff;

    if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 500) {

      startDirection = 1;

    }

    randtemp = fastRandom * randSeed;

    fastRandom = randtemp & 0xffff;

    startMovement = 0;

    if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 0x2ee) {

      startMovement = (AIHigh_CopGameType != COP_GAME_BTC_1HC1HP);

    }

    startSlice = AIDataRecord_TrackCurve_Get(AIDataRecord_TrackCurve,
                                       (int)((this->carObj_)->N).simRoadInfo.slice);

    if ((0x41 < startSlice) && (AIHigh_CopGameType != COP_GAME_BTC_1HC1HP)) {

      startMovement = 1;

    }

    startSlice = this->FindRandomBarrierFreeArea((int)((this->carObj_)->N).simRoadInfo.slice,100,1);

    if ((this->currentStage_ + 1U & 1) == 0) {

      addToSlice = startDirection * 7;

    }

    else {

      addToSlice = startDirection * -7;

    }

    if (addToSlice >= 0) {

      startSlice = startSlice + addToSlice;

      if (gNumSlices <= startSlice) {

        startSlice = startSlice - gNumSlices;

      }

    }

    else {

      startSlice = startSlice + addToSlice;

      if (startSlice < 0) {

        startSlice = startSlice + gNumSlices;

      }

    }

    ((this->carObj_)->N).simRoadInfo.slice =

         (short)startSlice;

    this->NewStage(startSlice,startDirection,startMovement);

  }

  return;

}








/* ---- CheckConditionWithCop0__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::CheckConditionWithCop0  [AIH_BTCCOP.CPP:461-485] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::CheckConditionWithCop0()



{
  if (this->copIndex_ != 0) {
    AIHigh_BTC_HumanCop *leadCop;

    leadCop = (AIHigh_BTC_HumanCop *)highLevelAIObjs[0];

    if (this->currentStage_ < leadCop->currentStage_) {
      int startDirection;
      int startSlice;
      int startMovement;
      int addToSlice;

      startDirection = leadCop->initialDirection_;

      startMovement = leadCop->initialMovement_;

      startSlice = (int)(leadCop->carObj_->N).simRoadInfo.slice;

      if ((this->currentStage_ + 1U & 1) != 0) {

        addToSlice = startDirection * 0xe;

      }

      else {

        addToSlice = startDirection * -0xe;

      }

      if (0 <= addToSlice) {

        startSlice = startSlice + addToSlice;

        if (gNumSlices <= startSlice) {

          startSlice = startSlice - gNumSlices;

        }

      }

      else {

        startSlice = startSlice + addToSlice;

        if (startSlice < 0) {

          startSlice = startSlice + gNumSlices;

        }

      }

      this->NewStage(startSlice,startDirection,startMovement);

    }

    (this->carObj_)->desiredSpeed =

         leadCop->carObj_->desiredSpeed;

  }

  return;

}








/* ---- NewStage__19AIHigh_BTC_HumanCopiii  AIHigh_BTC_HumanCop::NewStage  [AIH_BTCCOP.CPP:490-618] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::NewStage(int copSlice,int direction,int movement)



{
  /* W57-A11: SYM 8c fn-scope REG locals are ONLY nextStageTime ($10) plus the two AUTOs;
     rightPos/leftPos are BLOCK-scoped in the third arm and iVar3/uVar4/iVar5/iVar6 are
     Ghidra inventions (an unlisted local costs a callee-saved reg + frame bytes).
     2026-08-11 PASS RECEIPT: removing the invented post-scale iVar2 and mutating
     nextStageTime in place recovered its SLD-authoritative s0 lifetime (32 -> 20).
     Short-lived rightWidth/leftWidth identities preserve `byte << 15` before each
     multiply without perturbing the slice pointer, reducing 20 -> 2; spelling the
     stage comparison currentStage_ >= numPerps restores retail load order and PASS
     (220/220).  The direct shifted-expression + leftPos-anchor basin ended at 48
     and was fully unwound. */
  int nextStageTime;
  int initialDirection;
  int initialMovement;

  int newLatPos;

  int throwAway;



  this->currentStage_ = this->currentStage_ + 1;

  GameSetup_gData.perpArrests = GameSetup_gData.perpArrests + 1;

  if ((((u_int)(AIHigh_CopGameType - COP_GAME_BTC_1HC) < 2) && (this->currentStage_ >= GameSetup_gData.numPerps)) ||

     ((AIHigh_CopGameType == COP_GAME_BTC_1HC1HP && (2 < this->currentStage_)))) {

    simVar.endSimGame = 1;

    return;

  }

  BWorld_InitSpikeBelt();

  AICop_spikeBelt.active_ = 0;

  Object_ClearCustomObjects();

  initialDirection = direction;

  initialMovement = movement;

  this->initialDirection_ = initialDirection;

  this->initialMovement_ = initialMovement;

  (this->carObj_->N).simRoadInfo.slice = (short)copSlice;

  (this->carObj_)->direction = direction;

  AICop_gRoadBlockState = kAICop_RoadBlockState_None;

  throwAway = 0;

  newLatPos = 0;

  AIWorld_FindBarrierLessLaneAndPosition(this->carObj_,&newLatPos,&throwAway);

  /* W57-A11: the oracle sets up the AILife_PlaceCarAtLocation ARGS inside EACH arm
     (per-arm `lw a2,0x1C(sp)` + `sw ..,0x10/0x14(sp)` stack args, SLD 542/551) and only
     cross-jump-merges the `lw a0; jal; addu a3` triple at .L8005D8CC -- the single shared
     call + goto form hoisted the last two args into callee-saved regs and lost 7 insns. */
  if (AIHigh_CopGameType == COP_GAME_BTC_1HC1HP) {

    AILife_PlaceCarAtLocation(this->carObj_,copSlice,throwAway,direction,0,0);

  }

  else if (movement != 0) {

    AILife_PlaceCarAtLocation(this->carObj_,copSlice,throwAway,direction,
               direction * 0xd5555,0);

  }

  else {

  /* W57-A11: SYM 8c -- this arm's REAL locals are BLOCK-SCOPED `rightPos` ($11=s1) and
     `leftPos` ($10=s0); iVar3/uVar4/the IsDriveableLane results are anonymous temps. */
  int rightPos;

  int leftPos;

  /* SYM-CODEGEN-CARRIER: laneBits -- the retained high-nibble value is the
   * oracle's anonymous $a3. Re-reading the field at each use changes the
   * local-allocation handout despite identical semantics. */
  u_int laneBits;

  /* SYM-CODEGEN-CARRIER: leftWidth -- keeping the byte-to-FIX15 conversion
   * separate reproduces the oracle's multiply destination. Folding it into
   * `leftPos` keeps 220 instructions but produces 40 register diffs. */
  u_int leftWidth;

  rightPos = ((u_int)BWorldSm_slices[copSlice].avgPavedWidthRt << 15) *
             (BWorldSm_slices[copSlice].laneCount & 0xf);

  laneBits = (u_int)(BWorldSm_slices[copSlice].laneCount >> 4);

  leftWidth = (u_int)BWorldSm_slices[copSlice].avgPavedWidthLf;

  leftWidth = leftWidth << 15;

  leftPos = leftWidth * laneBits;

  {

    /* W57-A11: retail holds each MIN's limit in its OWN caller-saved temp (a1 / v1) and
       copies into rightPos/leftPos at the end; one shared temp merges the two ranges. */
    /* SYM-CODEGEN-CARRIER: limitR -- the retail MIN expansion holds this
     * bound in its own caller-saved register before copying it to rightPos.
     * A direct MIN macro grows the body to 225 instructions/173 diffs. */
    int limitR = BWorldSm_slices[copSlice].rightDrive * 0x100 + -0x8000;

    if (rightPos < limitR) {

      limitR = rightPos;

    }

    rightPos = limitR;

  }

  {

    /* SYM-CODEGEN-CARRIER: limitL -- the second retail MIN expansion likewise
     * has a distinct caller-saved bound; sharing the first carrier changes
     * the branch/delay-slot allocation. */
    int limitL = BWorldSm_slices[copSlice].leftDrive * 0x100 + -0x8000;

    if (leftPos < limitL) {

      limitL = leftPos;

    }

    leftPos = limitL;

  }

  if (AIWorld_IsDriveableLane(copSlice,6 - laneBits) == 0) {

    leftPos = leftPos + -0x20000;

  }

  if (AIWorld_IsDriveableLane(copSlice,(BWorldSm_slices[copSlice].laneCount & 0xf) + 7) == 0) {

    rightPos = rightPos + -0x20000;

  }

  /* W57-A11: retail branches on the POSITIVE test into the shared A block
     (`beq driveSide,1 -> .L8005D8A0` / `bne driveSide,-1 -> .L8005D8B4`) and carries a
     SEPARATE call in each arm (three `addu a1,s3,zero` copSlice setups survive). */
  if (this->copIndex_ == 0) {

    if (AITune_driveSide == 1) goto LAB_8005d8a0;

    goto LAB_8005d8b8;

  }

  if (AITune_driveSide != -1) goto LAB_8005d8b8;

LAB_8005d8a0:

  AILife_PlaceCarAtLocation(this->carObj_,copSlice,rightPos,direction,0,
             direction * 0x100 + 0x200);

  goto LAB_8005d8d8;

LAB_8005d8b8:

  AILife_PlaceCarAtLocation(this->carObj_,copSlice,-leftPos,direction,0,
             0x200 - direction * 0x100);

LAB_8005d8d8:

  ;

  }

  if (AIHigh_CopGameType == COP_GAME_BTC_1HC1HP) {

    /* W57-A11: the `<< 5` lives in EACH arm (oracle `sll s0,v0,5` twice) -- a shared
       post-if shift makes the load land directly in nextStageTime's reg. */
    nextStageTime = AIH_BTC_Cop_1HC1HP_StageTimes[this->currentStage_] << 5;

  }

  else {

    nextStageTime = GameSetup_gData.perpInfo[this->currentStage_].TimeLimit << 5;

  }

  if (nextStageTime < 0) {

    nextStageTime = 0;

  }


  /* W57-A11: the /0x10000 form keeps retail's SINGLE in-place `sra s0,a0,16`. */
  nextStageTime = (nextStageTime * this->stageTimeMultiplier_) / 0x10000;

  if (this->copIndex_ == 0) {

    Hud_BTC_BonusTime(nextStageTime << 1);

  }

  this->needPerp_ = 1;

  this->chaseStartTime_ = 0;

  this->wingmanStatus_ = 0;

  this->freezeMode_ = 1;

  this->timeLeft_ = this->timeLeft_ + nextStageTime;

  TrgSfx_RestartTrgSfx();

  return;

}








/* ---- UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::UpdateAndCheckTimeLeft  [AIH_BTCCOP.CPP:624-650] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::UpdateAndCheckTimeLeft()



{
  static bool sayLose;

  if ((this->freezeMode_ != 3) && (this->freezeMode_ != 1)) {

    this->timeLeft_ = this->timeLeft_ - AI_elapsedTime;   /* H19: subtraction dropped (m2c self-assign fold); oracle 0x8005D9E8-FC timeLeft_ -= AI_elapsedTime */

  }

  /* MATCH: TWO calls in source — gcc tail-merges them into one jal + per-arm arg setup
     (a0=carInfo+0x5C self-add in then-arm; a0=0/a1=a0-copy zeros in else; shared sltiu in the jal slot) */
  if (this->perpTarget_ != (AIHigh_BTC_Perp *)0x0) {

    Hud_BTC_Update(((this->perpTarget_)->carObj_)->carInfo->driver,this->timeLeft_,
                   (void *)(u_int)((this->carObj_)->RSControl == 0));

  }

  else {

    Hud_BTC_Update((char *)0x0,0,(void *)(u_int)((this->carObj_)->RSControl == 0));

  }

  if (this->timeLeft_ < 0) {

    if (AIH_BTCCop_freezeToggle_8013c564 != 0) {
      Speech_Mobile(this->carObj_)->Lose();

      AIH_BTCCop_freezeToggle_8013c564 = 0;

    }

    if (this->timeLeft_ < -0xa0) {

      AIH_BTCCop_freezeToggle_8013c564 = 1;  /* MATCH: gp-store first materializes the shared 1 (li v1,1) before the lui */

      simVar.endSimGame = 1;

      this->HudOn(this->perpTarget_,1,

                 this->carObj_);

    }

  }

  return;

}








/* ---- UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::UpdateFreezeModeAndPullOverMode  [AIH_BTCCOP.CPP:692-722] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::UpdateFreezeModeAndPullOverMode()



{

  if (this->timeLeft_ < 0) {

    AIInit_forceHumanHandBrake = 1;

    this->carObj_->RSControl = this->carObj_->direction;

    this->requestedDesiredSpeed_ = 0;

    return;

  }

  if (this->freezeMode_ == 3) {

    (this->carObj_)->RSControl = 0;

    (this->carObj_)->pullOver = 1;

    this->requestedDesiredSpeed_ = 0;

    return;

  }

  if (this->freezeMode_ == 1) {

    this->carObj_->AIFlags = this->carObj_->AIFlags & 0xfffffffd;

    /* SYM-CODEGEN-CARRIER: startingDirection -- the direct field assignment
     * is 6 oracle diffs; the explicit value preserves retail scheduling. */
    int startingDirection = this->initialDirection_;

    (this->carObj_)->RSControl = startingDirection;

    (this->carObj_)->pullOver =

         (u_int)(this->initialMovement_ == 0);

    if ((this->carObj_)->pullOver != 0) {

      this->requestedDesiredSpeed_ = 0;

      return;

    }

  }

  else {

    if ((this->carObj_->pullOver == 1) || (this->carObj_->RSControl != 0)) {

      this->carObj_->AIFlags = this->carObj_->AIFlags | 2;

    }

    this->requestedDesiredSpeed_ = 0;

    this->freezeMode_ = 0;

    this->carObj_->RSControl = 0;

    (this->carObj_)->pullOver = 0;

  }

  return;

}








/* ---- RequestWingman__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::RequestWingman  [AIH_BTCCOP.CPP:727-749] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::RequestWingman()



{
  int wingmanActivationTime;



  if (1 < (u_int)(this->freezeMode_ - 3)) {

    wingmanActivationTime = GameSetup_gData.perpInfo[this->currentStage_].WingmanTime * 0x40 +

            AITune_BTC[GameSetup_gData.skill].wingmanTime;

    Speech_Mobile(this->carObj_)->Backup();

    if (this->chaseStartTime_ == 0) goto LAB_dispatch;

    if (wingmanActivationTime == 0) goto LAB_dispatch;

    if (simGlobal.gameTicks - this->chaseStartTime_ <= wingmanActivationTime) goto LAB_dispatch;

    if (this->wingmanStatus_ != 4) {

      this->wingmanStatus_ = 1;

      goto LAB_end;

    }

LAB_dispatch:
    Speech_Dispatch()->Deny();

LAB_end: ;

  }

  return;

}








/* ---- RequestBlockader__19AIHigh_BTC_HumanCopi  AIHigh_BTC_HumanCop::RequestBlockader  [AIH_BTCCOP.CPP:752-781] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::RequestBlockader(int spikeBeltRequest)



{
  int availableTime;



  if (1 < (u_int)(this->freezeMode_ - 3)) {

    if (spikeBeltRequest != 0) {
      Speech_Mobile(this->carObj_)->SpikeBelt();

      availableTime = GameSetup_gData.perpInfo[this->currentStage_].SpikeBeltTime * 0x40 +

                      AITune_BTC[GameSetup_gData.skill].spikeBeltTime;

    }

    else {
      Speech_Mobile(this->carObj_)->RoadBlock();

      availableTime = GameSetup_gData.perpInfo[this->currentStage_].BlockadeCopTime * 0x40 +

                      AITune_BTC[GameSetup_gData.skill].blockaderTime;

    }

    if (this->chaseStartTime_ == 0) goto LAB_dispatch;

    if (availableTime < 1) goto LAB_dispatch;

    if (simGlobal.gameTicks - this->chaseStartTime_ <= availableTime) goto LAB_dispatch;

    if (this->wingmanStatus_ != 5) {
      Speech_Dispatch()->Grant();

      if (spikeBeltRequest != 0) {

        this->wingmanStatus_ = 3;

      }

      else {

        this->wingmanStatus_ = 2;

      }

      goto LAB_end;

    }

LAB_dispatch:
    Speech_Dispatch()->Deny();

LAB_end: ;

  }

  return;

}








/* ---- CheckForWingmanRequest__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::CheckForWingmanRequest  [AIH_BTCCOP.CPP:785-790] SLD-VERIFIED ---- */

int AIHigh_BTC_HumanCop::CheckForWingmanRequest()



{

  if (this->wingmanStatus_ != 1) {

    return 0;

  }

  this->wingmanStatus_ = 4;

  return 1;

}








/* ---- CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi  AIHigh_BTC_HumanCop::CheckForBlockaderRequest  [AIH_BTCCOP.CPP:794-808] SLD-VERIFIED ---- */

int AIHigh_BTC_HumanCop::CheckForBlockaderRequest(int *spikeBeltRequest)



{

  *spikeBeltRequest = 0;

  if ((u_int)(this->wingmanStatus_ - 2) < 2) {

    if (this->wingmanStatus_ == 3) {

      *spikeBeltRequest = 1;

    }

    this->wingmanStatus_ = 5;

    return 1;

  }

  return 0;

}








/* ---- UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role  AIHigh_BTC_HumanCop::UpdateWingmanRole  [AIH_BTCCOP.CPP:812-821] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::UpdateWingmanRole(Wingman_Role currentRole)



{

  switch ((int)currentRole) {
  case 0:
    this->wingmanStatus_ = 0;
    return;
  case 1:
    this->wingmanStatus_ = 4;
    return;
  case 2:
  case 3:
    this->wingmanStatus_ = 5;
    return;
  default:
    return;
  }

}








/* ---- ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::ClearTrafficToPurgatory  [AIH_BTCCOP.CPP:832-838] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::ClearTrafficToPurgatory()



{
  int trafficLoop;
  Car_tObj*testTrafficCarObj;
  AIHigh_Traffic*testTrafficHigh;

  trafficLoop = 0;

  while (1) {

    if (Cars_gNumTrafficCars <= trafficLoop) break;

    testTrafficCarObj = Cars_gTrafficCarList[trafficLoop];

    trafficLoop = trafficLoop + 1;

    testTrafficHigh = (AIHigh_Traffic *)highLevelAIObjs[testTrafficCarObj->carIndex];

    testTrafficHigh->forcePurgatory_ = 1;

  }

  return;

}








/* ---- ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::ResetClearTrafficToPurgatory  [AIH_BTCCOP.CPP:842-848] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::ResetClearTrafficToPurgatory()



{
  int trafficLoop;
  Car_tObj*testTrafficCarObj;
  AIHigh_Traffic*testTrafficHigh;

  trafficLoop = 0;

  while (1) {

    if (Cars_gNumTrafficCars <= trafficLoop) break;

    testTrafficCarObj = Cars_gTrafficCarList[trafficLoop];

    trafficLoop = trafficLoop + 1;

    testTrafficHigh = (AIHigh_Traffic *)highLevelAIObjs[testTrafficCarObj->carIndex];

    testTrafficHigh->forcePurgatory_ = 0;

  }

  return;

}








/* ---- SetDesiredSpeed__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::SetDesiredSpeed  [AIH_BTCCOP.CPP:854-858] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::SetDesiredSpeed()



{
  int curveSpeed;

  if (this->carObj_->RSControl != 0) {

    curveSpeed = AISpeeds_CalcHumanTopSpeed(this->carObj_);

    this->carObj_->desiredSpeed =
        this->requestedDesiredSpeed_ < curveSpeed
            ? this->requestedDesiredSpeed_ : curveSpeed;

  }

  return;

}








/* ---- HighExecute__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::HighExecute  [AIH_BTCCOP.CPP:863-931] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::HighExecute()



{
  coorddef notUsed;



  if ((this->copIndex_ == 0) &&

     (this->freezeMode_ == 1)) {

    this->ClearTrafficToPurgatory();

  }

  if ((this->perpTarget_ != (AIHigh_BTC_Perp *)0x0) && (this->freezeMode_ != 1)) {

    (this->carObj_)->desiredDirection =

         ((this->perpTarget_)->carObj_)->direction;

  }

  this->SetDesiredSpeed();

  this->CheckConditionWithCop0();

  this->UpdateFreezeModeAndPullOverMode();

  this->UpdateAndCheckTimeLeft();

  this->CheckForNewTarget();

  if (this->perpTarget_ != (AIHigh_BTC_Perp *)0x0) {

    this->GetCheckChasePosition(&notUsed);

  }

  if (AIHigh_CopGameType == COP_GAME_BTC_1HC) {

    if (0x281 <= simGlobal.gameTicks - lastInputRequestTick_) {

      if (((this->carObj_)->control).queuedEvent ==

          '\x04') {

        this->RequestWingman();

        ((this->carObj_)->control).queuedEvent = '\0';

        lastInputRequestTick_ = simGlobal.gameTicks;

      }

      if (((this->carObj_)->control).queuedEvent ==

          '\x05') {

        this->RequestBlockader(0);

        ((this->carObj_)->control).queuedEvent = '\0';

        lastInputRequestTick_ = simGlobal.gameTicks;

      }

      if (((this->carObj_)->control).queuedEvent ==

          '\x06') {

        this->RequestBlockader(1);

        ((this->carObj_)->control).queuedEvent = '\0';

        lastInputRequestTick_ = simGlobal.gameTicks;

      }

    }

    else {
      if ((u_int)(u_char)(this->carObj_->control).queuedEvent - 4 < 3) {

        (this->carObj_->control).queuedEvent = '\0';

      }

    }

  }

  (this->state_)->StateExecute();

  return;

}








/* ---- HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj  AIHigh_BTC_HumanCop::HudOn  [AIH_BTCCOP.CPP:938-947] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::HudOn(AIHigh_BTC_Perp *arrestMe,int gameOver,

               Car_tObj *arrestingCop)



{
  Car_tObj*arrestingHumanCop;

  if ((arrestingCop->carFlags & 2U) != 0) {

    arrestingCop = Cars_gHumanRaceCarList[0];

  }

  if ((this->copIndex_ == 0) || (gameOver != 0)) {

    arrestingHumanCop = arrestMe->carObj_;

    Hud_BustedOverlayOn(simGlobal.gameTicks - this->chaseStartTime_,

               arrestingHumanCop->carInfo->driver,

               (void *)(u_int)(gameOver == 0),(short)arrestingCop->carIndex);

  }

  return;

}








/* ---- __18AIHigh_BTC_WingmanP8Car_tObji  AIHigh_BTC_Wingman::ctor  [AIH_BTCCOP.CPP:964-971] SLD-VERIFIED ---- */
AIHigh_BTC_Wingman::AIHigh_BTC_Wingman(Car_tObj *carObj,int copIndex)



{

  (new((AIHigh_BTC_Cop *)this) AIHigh_BTC_Cop(carObj,copIndex));

  this->_vf =

       (__vtbl_ptr_type (*) [3])AIHigh_BTC_Wingman_vtable;

  this->spikeBeltPlaced_ = 0;

  this->spikeBeltSlice_ = 0;

  this->spikeBeltInterceptReleaseTime_ = 0;

  this->currentRole_ = 0;

  this->newRole_ = 0;

  this->newHumanBoss_ = (AIHigh_BTC_HumanCop *)0x0;

  return;

}








/* ---- HighExecute__18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::HighExecute  [AIH_BTCCOP.CPP:976-1266] SLD-VERIFIED ---- */

#if 0
void AIHigh_BTC_Wingman::HighExecute()



{
  coorddef pos;
  coorddef newPos;
  coorddef trafficOffset;
  coorddef *offset;

  AIState_Base *newState;
  AIState_Base *oldState;
  Car_tObj *carObj;

  bool bVar1;

  Speaker *pSVar2;

  int a;

  int iVar3;

  stateType_t sVar6;

  Wingman_Role WVar7;



  ((AIHigh_BasicCop *)this)->CheckSpikeBelt();

  this->CheckForActivation();

  switch(this->stateType_) {

  case 0:

    this->carObj_->AIFlags = this->carObj_->AIFlags & 0xfffffffd;

    newState = operator new(8);

    carObj = this->carObj_;

    (new(newState) AIState_Base(carObj));

    newState->_vf = (__vtbl_ptr_type (*) [4])AIHigh_BTC_Wingman_vtable;

    memset((u_char *)&pos,'\0',0xc);

    pos.y = carObj->carIndex * 0xa0000;

    Newton_SetInitialSlicePositionOrientationEtc(&newState->carObj_->N,0,&pos,1);

    (newState->carObj_->N).active = '\0';

    oldState = this->state_;

    if (oldState != (AIState_Base *)0x0) {

      (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

    }

    sVar6 = 7;

    this->state_ = newState;

    goto LAB_8005eda0;

  case 10:

  default:

    goto stateExecuteAndReturn;

  case 2:

    this->carObj_->AIFlags = this->carObj_->AIFlags & 0xfffffffd;

    if ((this->newRole_ == this->currentRole_) || (1 < this->newRole_ - 2)) {

      this->CheckForNewTarget();

      if (this->perpTarget_ != (AIHigh_BTC_Perp *)0x0) {

        this->GetCheckChasePosition(&pos);

        newState = operator new(0x94);

        newState = (AIState_Base*)(new((AIState_Chase*)newState) AIState_Chase(this->carObj_,

                             ((this->perpTarget_))->carObj_,&pos,0x200,0x3c0000,0x190000,2,0x10000));

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

        }

        sVar6 = 4;

        goto LAB_8005e5d8;

      }

    }

    else {

      carObj = AILife_IsCarInAnyVisibleArea(this->carObj_);

      if (carObj == (Car_tObj *)0x0) {

        pSVar2 = (Speaker *)Speech_Mobile(this->carObj_);

        (**(int (**)(...))((int)*pSVar2->_vf + 0x84))

                  ((int)&(pSVar2->fPosition).flags + (int)*(short *)((int)*pSVar2->_vf + 0x80));

        this->currentRole_ = this->newRole_;

        this->SetupBlockader(this->newHumanBoss_,(u_int)(this->newRole_ == 3));

        newState = operator new(0x10);

        (new(newState) AIState_Base(this->carObj_));

        newState->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

        ((AIState_Idle *)newState)->roadPosition_ = 1;

        oldState = this->state_;

        if (oldState != (AIState_Base *)0x0) {

          (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

        }

        sVar6 = 3;

LAB_8005e5d8:

        this->state_ = newState;

        this->stateType_ = sVar6;

      }

    }

    iVar3 = this->UpdateFreezeModeAndPullOverMode();

    if (iVar3 == 0) goto stateExecuteAndReturn;

    this->AssignToPlayer((AIHigh_BTC_Perp *)0x0)

    ;

    newState = operator new(8);

    carObj = this->carObj_;

    (new(newState) AIState_Base(carObj));

    newState->_vf = (__vtbl_ptr_type (*) [4])AIHigh_BTC_Wingman_vtable;

    memset((u_char *)&pos,'\0',0xc);

    offset = &pos;

    pos.y = carObj->carIndex * 0xa0000;

    break;

  case 3:

    this->carObj_->AIFlags = this->carObj_->AIFlags | 2;

    this->CheckForNewTarget();

    bVar1 = false;

    if (this->perpTarget_ == (AIHigh_BTC_Perp *)0x0) {

      this->newRole_ = 1;

      this->currentRole_ = 1;

      newState = operator new(8);

      newState = (AIState_Base*)(new(newState) AIState_Normal(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

      }

      this->state_ = newState;

      this->stateType_ = 2;

      return;

    }

    this->GetCheckChasePosition(&pos);

    if ((this->spikeBeltPlaced_ != 0) && (AICop_spikeBelt.slice_ == this->spikeBeltSlice_)) {

      AICop_spikeBelt.freshenTime_ = simGlobal.gameTicks;

    }

    a = AIWorld_ApxSplineDistance(this->carObj_,

                   ((this->perpTarget_))->carObj_);

    iVar3 = a;

    if (a < 0) {

      iVar3 = -a;

    }

    if (iVar3 < 0x320000) {

LAB_8005ea9c:

      bVar1 = true;

    }

    else if (iVar3 < 0x12c0000) {

      iVar3 = (((this->perpTarget_))->carObj_)->currentSpeed;

      if (iVar3 < 1) {

        iVar3 = -iVar3;

      }

      if (((0x471c7 < iVar3) &&

          (iVar3 = fixeddiv(a,(((this->perpTarget_))->carObj_)->currentSpeed), 0 < iVar3)) &&

         (iVar3 < this->spikeBeltInterceptReleaseTime_)) goto LAB_8005ea9c;

    }

    if (bVar1) {

      this->spikeBeltPlaced_ = 0;

      this->newRole_ = 1;

      this->currentRole_ = 1;

      newState = operator new(0x94);

      newState = (AIState_Base*)(new((AIState_Chase*)newState) AIState_Chase(this->carObj_,

                           ((this->perpTarget_))->carObj_,&pos,0x200,0x3c0000,0x190000,2,0x10000));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

      }

      this->state_ = newState;

      this->stateType_ = 4;

    }

    if ((this->newRole_ != this->currentRole_) && (this->newRole_ == 1)) {

      this->currentRole_ = 1;

      newState = operator new(8);

      newState = (AIState_Base*)(new(newState) AIState_Normal(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

      }

      this->state_ = newState;

      this->stateType_ = 2;

    }

    iVar3 = this->UpdateFreezeModeAndPullOverMode();

    if (iVar3 == 0) goto stateExecuteAndReturn;

    this->AssignToPlayer((AIHigh_BTC_Perp *)0x0)

    ;

    newState = operator new(8);

    carObj = this->carObj_;

    (new(newState) AIState_Base(carObj));

    newState->_vf = (__vtbl_ptr_type (*) [4])AIHigh_BTC_Wingman_vtable;

    memset((u_char *)&newPos,'\0',0xc);

    offset = &newPos;

    newPos.y = carObj->carIndex * 0xa0000;

    break;

  case 4:

    newState = this->state_;

    this->carObj_->AIFlags = this->carObj_->AIFlags | 2;

    ((AIHigh_BasicCop *)this)->HandleBlockadeSpeech();

    iVar3 = this->GetCheckChasePosition(&pos);

    if (iVar3 != 0) {

      ((AIState_Chase *)newState)->SetTarget(((this->perpTarget_))->carObj_,&pos);

    }

    if (0xa0 < ((AIState_Chase *)newState)->barrierTicks32_) {

      iVar3 = ((AIState_Chase *)newState)->FindBarrierEndSlice();

      carObj = (Car_tObj *)operator new(0x10);

      carObj = (Car_tObj *)(new((AIState_GotoSlice *)carObj) AIState_GotoSlice(this->carObj_,iVar3,

                           0));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

      }

      this->state_ = (AIState_Base *)carObj;

      this->stateType_ = 9;

    }

    iVar3 = this->CheckForNewTarget();

    if (iVar3 != 0) {

      this->GetCheckChasePosition(&newPos);

      ((AIState_Chase *)newState)->SetTarget(((this->perpTarget_))->carObj_,&newPos);

    }

    bVar1 = false;

    if (8 < ((AIState_Chase *)newState)->inTargetRegion_) {

      iVar3 = ((AIState_Chase *)newState)->latMetersBetween_;

      if (iVar3 < 0) {

        iVar3 = -iVar3;

      }

      if (iVar3 < 0xe0000) {

        iVar3 = ((AIState_Chase *)newState)->longMetersBetween_;

        if (iVar3 < 0) {

          iVar3 = -iVar3;

        }

        bVar1 = iVar3 < 0xf0000;

      }

    }

    if (bVar1) {

      ((AIState_Chase *)newState)->SetMurderMode(1,0x300);

    }

    if (this->perpTarget_ == (AIHigh_BTC_Perp *)0x0) {

      this->AssignToPlayer((AIHigh_BTC_Perp *)0x0);

      newState = operator new(8);

      newState = (AIState_Base*)(new(newState) AIState_Normal(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

      }

      this->state_ = newState;

      this->stateType_ = 2;

    }

    if ((this->newRole_ != this->currentRole_) && (this->newRole_ - 2 < 2)) {

      this->carObj_->desiredDirection = -this->carObj_->desiredDirection;

      this->AssignToPlayer((AIHigh_BTC_Perp *)0x0);

      newState = operator new(8);

      newState = (AIState_Base*)(new(newState) AIState_Normal(this->carObj_));

      oldState = this->state_;

      if (oldState != (AIState_Base *)0x0) {

        (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

      }

      this->state_ = newState;

      this->stateType_ = 2;

      pSVar2 = (Speaker *)Speech_Mobile(this->carObj_);

      (**(int (**)(...))((int)*pSVar2->_vf + 0x3c))

                ((int)&(pSVar2->fPosition).flags + (int)*(short *)((int)*pSVar2->_vf + 0x38));

    }

    iVar3 = this->UpdateFreezeModeAndPullOverMode();

    if (iVar3 == 0) goto stateExecuteAndReturn;

    this->AssignToPlayer((AIHigh_BTC_Perp *)0x0)

    ;

    newState = operator new(8);

    carObj = this->carObj_;

    (new(newState) AIState_Base(carObj));

    newState->_vf = (__vtbl_ptr_type (*) [4])AIHigh_BTC_Wingman_vtable;

    memset((u_char *)&trafficOffset,'\0',0xc);

    offset = &trafficOffset;

    trafficOffset.y = carObj->carIndex * 0xa0000;

    break;

  case 7:

    this->carObj_->AIFlags = this->carObj_->AIFlags & 0xfffffffd;

    WVar7 = this->newRole_;

    if (this->currentRole_ == WVar7) goto stateExecuteAndReturn;

    if (WVar7 == 1) {

      this->currentRole_ = 1;

      this->SetupWingman(this->newHumanBoss_);

      goto LAB_8005ed58;

    }

    if (1 < WVar7 - 2) goto stateExecuteAndReturn;

    this->currentRole_ = WVar7;

    this->SetupBlockader(this->newHumanBoss_,(u_int)(this->newRole_ == 3));

    newState = operator new(0x10);

    (new(newState) AIState_Base(this->carObj_));

    newState->_vf = (__vtbl_ptr_type (*) [4])AIState_Idle_vtable;

    ((AIState_Idle *)newState)->roadPosition_ = 1;

    oldState = this->state_;

    if (oldState != (AIState_Base *)0x0) {

      (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

    }

    sVar6 = 3;

    goto LAB_8005ed9c;

  case 9:

    carObj = (Car_tObj *)this->state_;

    this->AssignToPlayer((AIHigh_BTC_Perp *)0x0)

    ;

    iVar3 = ((AIState_GotoSlice *)carObj)->InTargetSliceRange(0xa0000);

    if (iVar3 == 0) goto stateExecuteAndReturn;

LAB_8005ed58:

    newState = operator new(8);

    newState = (AIState_Base*)(new(newState) AIState_Normal(this->carObj_));

    oldState = this->state_;

    if (oldState != (AIState_Base *)0x0) {

      (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

    }

    sVar6 = 2;

LAB_8005ed9c:

    this->state_ = newState;

LAB_8005eda0:

    this->stateType_ = sVar6;

    goto stateExecuteAndReturn;

  }

  Newton_SetInitialSlicePositionOrientationEtc(&newState->carObj_->N,0,offset,1);

  (newState->carObj_->N).active = '\0';

  oldState = this->state_;

  if (oldState != (AIState_Base *)0x0) {

    (*(int (*)(...))((int)*oldState->_vf + 0x14))((int)&oldState->carObj_ + (int)*(short *)((int)*oldState->_vf + 0x10),3);

  }

  this->state_ = newState;

  this->stateType_ = 7;

  this->newRole_ = 0;

  this->currentRole_ = 0;

stateExecuteAndReturn:

  (this->state_)->StateExecute();

  return;

}
#endif

/* NEAR-MISS 4 diffs (675/675): two of the three `Newton_SetInitial...` arms
   reuse memset's return (v0=&trafficOffset) as arg a2 where retail
   rematerializes `addiu a2,sp,N`.  W56-A16 FALSIFIED: changing arms 2/3 to pass
   `&trafficOffset` (matching arm 1 which PASSES) regresses frame -104->-112
   (489 diffs) -- the `offset=memset(...)` capture is frame-layout load-bearing.
   The remat-vs-reuse is coupled to where `carObj->carIndex*0xa0000`'s multiply
   result lands (clobber of v0 forces remat in arm 1); coloring, -fno-builtin
   inert.
   W61-A12 mapped the two basins.  The 4 diffs are exactly the two arms that PASS
   `offset` (the memset return) to Newton; the two arms that pass `&trafficOffset`
   already remat and PASS.  EVERY spelling that stops feeding the call the returned
   pointer lands in the SAME wrong basin -- frame -112 (vs retail -104), `this`
   rotated $s1->$s2 and one extra callee-saved $s3, ~489 diffs of pure rotation:
   drop the capture + pass &trafficOffset (both arms) 489/698; keep the capture,
   change only the arg 489/698; ONE arm only 506/697 resp. 497/716; `offset =
   &trafficOffset;` assigned before, between or after the memset 489/698.  So the
   `offset` pseudo (which coalesces into the call's $v0 and costs no allocno) is
   what holds the retail frame; any address-valued pseudo costs one.
   ALSO FALSIFIED: this build has NO memset builtin to exploit -- giving libfns.h a
   TYPED prototype (void*,int,int / unsigned int / unsigned long) or even a
   `#define memset(a,b,c) __builtin_memset(...)` shim leaves the gate at exactly
   4 diffs (gcc-2.8 has no BUILT_IN_MEMSET; the dest/return equivalence in retail
   therefore came from the SOURCE, not from builtin knowledge).
   Next lens: reach retail's remat WITHOUT minting an allocno -- i.e. the arg must
   be an address expression whose reload rematerializes, while the other three arms
   keep their current allocation.  That is a reload/REG_EQUIV question, not a
   spelling one.
   W62-A10 REFUTED THE "OFFSET MUST STAY LIVE" READING (3 new falsifications, each
   re-gated, baseline 4 diffs / 675 insns).  The hypothesis was that the 489/698 basin
   came from `offset` going DEAD once the call stops using it, so `offset` was kept
   alive by a zero-byte fence while the arg became `&trafficOffset`:
     read-only fence on offset BEFORE the .y store   -> 489 diffs / 698 insns
     read-only fence on offset AFTER  the .y store   -> 500 diffs / 699 insns
     identity fence ("" : "=r"(offset) : "0"(offset)) -> 489 diffs / 698 insns
   The first and third land on EXACTLY the same 489/698 as simply dropping the capture,
   W63-A12 re-gated (4 @ 675/675) and adds TWO measurements.  (i) NEW FALSIFICATION:
   reordering all three arms to `offset = &X; memset((u_char *)offset,'\0',0xc);` (so the
   address pseudo is BORN before the call and must survive it, the classic REG_EQUIV
   remat trigger) is INERT -- 4 diffs, byte-identical.  (ii) THE RESIDUAL IS SHARPENED
   TO AN ALLOCATION FACT, not a remat one: the oracle sets the arg IN THE ARM
   (`addiu $a2,$sp,0x48` @0x8005E904 and `addiu $a2,$sp,0x38` @0x8005EBF8, both several
   insns BEFORE the `j` to the shared Newton block), i.e. retail's `offset` pseudo is
   simply ALLOCATED TO $a2, so each arm's `offset = &X` IS the arg setup and no copy
   exists.  Ours allocates it elsewhere and copies (`addu a2,v0,zero`) at the call.
   Note the THIRD arm (sp+0x28, three sites) already matches -- so the ask is a
   per-pseudo handout (offset -> $a2), and allocsim reports MATCH 45/45 on this fn with
   NO pseudo homed in $v0, i.e. the losing address pseudo is a LOCAL-ALLOC qty, outside
   allocsim/reqdelta's model.  Next lens = qtytrace, exactly as for CheckDesiredDirection.
   so `offset`'s liveness is IRRELEVANT: the basin flip is caused solely by the CALL ARG
   being an address-valued expression.  That sharpens the standing verdict -- the device
   needed is one that makes reload rematerialize `addiu a2,sp,N` from a REG_EQUIV
   without the address ever becoming an allocno; no fence in the toolkit does that
   (a fence can add refs or opacity, never remove an allocno).
   W64-A12 re-gated (4 @ 675/675) and re-confirmed the standing basin fact on TODAY's
   tree: passing `&trafficOffset` at BOTH remaining arms is still exactly 489 @698
   (frame -104 -> -112, `this` $s1->$s2, one extra callee-saved) -- unchanged across
   two more waves of surrounding edits, so it is basin-independent.
   THE NAMED NEXT LENS IS NOW AVAILABLE: w64-a10 built the 12A local-alloc instrument,
   and it RUNS on this TU --
     python scratchpad/w64a10/dump.py recon/game/common/aih_btccop.cpp -dl
     python scratchpad/w64a10/copypref.py <dump>.lreg "AIHigh_BTC_Wingman::HighExecute"
   (my table is saved at scratchpad/w64a12/wing_qty.txt).  It prints, per block-local
   qty: refs / birth / death / QTY_CMP_PRI / copy_sugg / arith sugg / predicted vs
   ACTUAL hard reg, plus `--why <pseudo>` (the find_free_reg window + the BLOCKED and
   FREE sets) and `--want <pseudo>=<reg>`.  That is exactly the "per-pseudo handout
   (offset -> $a2)" question this receipt has been parked on since w63.  ONE caution
   from my pass: do NOT start from the pseudos whose copy_sugg merely CONTAINS a2
   (p198 block 23, p212 block 27) -- `--why 198` shows those CROSS A CALL, so the
   whole caller-saved bank is excluded from their window by construction and $a2 was
   never reachable for them.  The offset pseudo to chase is the 2-ref one BORN at the
   memset return and DYING at the `addu a2,v0,zero`.
   W71-A19 re-gated 4 @675/675 and CLOSED the 12A/20B PREFERENCE-KILLER angle on it --
   the one device invented since w64 that is aimed exactly at this ask (deny local-alloc's
   $v0 copy-preference on the memset-return pseudo at ZERO insns, non-volatile so it is
   not a sched barrier).  Applied to BOTH failing arms, each re-gated from 4:
     __asm__("" : "=r"(offset) : "0"(offset) : "$2")        -> 8 @675
     ... : "$2","$3"                                         -> 8 @675
     ... : "v0"   (ABI spelling of the same clobber)          -> 8 @675
     identity launder with NO clobber                          -> 8 @675
     read-only fence  __asm__("" : : "r"(offset))            -> 4 @675 (inert)
   So the clobber DOES move the pseudo off $v0 but never onto $a2 -- consistent with the
   w63 reading that this is a local-alloc QTY handout outside allocsim/reqdelta's model,
   and with the 20B LIMIT (the killer cannot beat an availability/eviction constraint).
   The qtytrace/copypref lane named in w64 is still the only untried lens.
   ==== W72-A11 re-gated 4 @675/675 and CORRECTED THE MECHANISM RECORD (two errors in
   this receipt, both falsifiable from primary sources):
   (1) 🔴 "this build has NO memset builtin to exploit" is WRONG.  gcc-2.8.1 expr.c:9042
       has BUILT_IN_MEMSET, and its expansion ENDS `dest_addr = clear_storage (...); if
       (dest_addr == 0) dest_addr = force_operand (dest_rtx, NULL_RTX); return dest_addr;`
       (expr.c:9099-9104).  For a 12-byte clear that clear_storage lowers to the LIBCALL,
       dest_addr IS the libcall's value register -- so `offset = (coorddef *)memset(...)`
       is not "a capture that costs no allocno", it is literally the call's $v0, which is
       exactly the `move a2,v0` we emit.  Any future reasoning here must start from that.
       The pair-with-it: because clear_storage's OTHER exit (an inlined movstrsi) returns
       0 and gcc then emits `force_operand(dest_rtx)` = a real `addiu` with a REG_EQUIV,
       the rematerialization retail shows is the NON-libcall exit of this same code path.
       Retail still emits `jal memset`, so it took the libcall exit too -- i.e. retail's
       source did NOT feed the call's value to Newton.
   (2) 🔴 THE DEAD-CODE TRAP: lines 1847-2448 of this file are inside `#if 0`, and they
       contain a SECOND, older copy of AIHigh_BTC_Wingman::HighExecute (def at 1848) whose
       arms spell the same statements differently (`memset(...); offset = &X;`).  Three of
       W72's first four probe ladders edited THAT copy and read as "inert" -- the live
       definition is at 2535.  ALWAYS resolve the definition line before anchoring
       (`awk '/^#if|^#endif/{print NR": "$0}'`), and treat a whole ladder that measures
       byte-identical as a MISSED-ANCHOR alarm, not a result.
   RE-MEASURED ON THE LIVE FUNCTION (all three sites, each re-gated from 4): the 20B/12A
   clobber walk UP the ascending find_free_reg scan -- identity launder with clobber sets
   {$2}, {$2,$3}, {$2,$3,$4}, {$2,$3,$4,$5} -- is 8 @675 for EVERY set, identical to the
   identity launder with NO clobber (8 @675); the read-only fence with the same clobber
   sets is 9 @676.  So the pseudo leaves $v0 on the launder alone and the clobber walk
   buys nothing: $a2 is not merely "later in the scan", it is UNAVAILABLE in this qty's
   window.  That is an availability/eviction fact (20B LIMIT), and it is the reason the
   preference-killer family cannot finish this fn.  NEXT LENS unchanged and now sharper:
   dump the qty's find_free_reg window and read WHY $a2 is in `used` -- either
   regs_live_at over [birth,death) (the arm sets $a1 before the copy; if $a2's live range
   already starts at the arm's own `j` the whole caller-saved bank above $a1 is barred) or
   a nonzero qty_n_calls making local-alloc OR in call_used_reg_set.  copypref.py --why
   answers exactly that; the instrumented cc1plus ICEs on aih_cop but should be re-tried
   on THIS TU (scratchpad/W72_A11/A11_trace.py prints the per-fn fidelity table first).
   Probe files: scratchpad/W72_A11/v_wing4.py (live), v_wing{,2,3}.py (the dead-copy
   ladders, kept only as the anchor-trap record).
   ==== W74-A11 re-gated (4 @675/675) and CORRECTED THE MECHANISM RECORD AGAIN, then
   closed the address-passing axis at ARM granularity.
   (1) 🔴 THE BUILTIN IS NOT INVOLVED AT ALL.  W72's correction (1) above assumed
       BUILT_IN_MEMSET expands here and that its clear_storage/TARGET_MEM_FUNCTIONS exit
       is what puts the address in $v0.  MEASURED: routing all four arms through a cast
       function POINTER -- `#define EA_memset ((void *(*)(u_char *,int,int))memset)`,
       which cannot be builtin-expanded and emits the identical `jal memset` -- is
       BYTE-IDENTICAL (4 @675).  libfns.h declares `void * memset(...)`, whose type does
       not match the builtin's, so gcc never treated our calls as BUILT_IN_MEMSET in the
       first place.  The `addu a2,v0,zero` is therefore NOT a cse/builtin artifact: it is
       simply our source PASSING `offset`, the call's return value, at those two arms.
   (2) THE ORACLE, READ PROPERLY, SAYS ALL FOUR ARMS REMATERIALIZE.  The .s has four
       `jal memset` (idx 46/202/394/595) and each is followed by
       `addiu $a2,$sp,{0x28,0x28,0x48,0x38}`; three of the four then `j .L8005EC0C`, one
       shared Newton tail.  Our two PASSING arms are the 0x28 pair (they pass
       `&trafficOffset`); the two FAILING arms are 0x48/0x38 -- the ones whose source
       passes `offset`.  Frame slots already agree, so the ONLY question is the a2 value.
   (3) THE ADDRESS-PASSING AXIS IS CLOSED, at arm granularity and across six spellings.
       Each re-gated from 4, live definition only (line-scoped harness so the dead copy
       cannot absorb an anchor): both arms -> `&trafficOffset` 489 @698; the same with the
       capture removed 489 @698; the same with the calls de-builtined 489 @698; arm D
       ALONE -> `&trafficOffset` 497 @716; arm D alone -> `(coorddef *)&trafficOffset.x`
       497 @716; arm D alone -> `(coorddef *)(int)&trafficOffset` 497 @716; arm D alone ->
       an identity-laundered address local 491 @716.  EVERY one of them adds a callee-saved
       register (s3 appears, frame -104 -> -112, `this` s1 -> s2) and 23-41 insns.  So it
       is not a spelling axis: passing the call's VALUE register is what holds the arms'
       tails textually identical (they cross-jump-merge) and keeps the conflict set at four
       saved regs.  Retail merges too, but merges BELOW its per-arm `addiu a2` + per-arm
       `sw v0,off(sp)` -- our build cannot reach that merge point without paying the extra
       allocno.  NEXT LENS: the extra saved register is the thing to explain, not the
       address spelling -- dump -dg for the 698 variant and read which allocno s3 carries
       (the receipt's own qtytrace/copypref ask, now with a concrete control pair to diff:
       the 4-diff build vs the 489 build differ by ONE source token per arm).
       Probe files: scratchpad/W74_A11_wing{,2,3}.py.
   ==== W75-A9 re-gated (4 @675/675, posmis 4) and CLOSED THE ADDRESS-ARG AXIS FOR GOOD
   with four MORE spellings, including the one the W75 orchestrator handed down from the
   A20 tree sweep ("ctor-return-vs-address remat: re-take &obj after the call / hold the
   address in a named local, 3.12 #16").  Every one of them lands in the SAME 489 basin:
     Y1 both arms -> &trafficOffset (the A20 shape, control)          489 @698
     Y3 offset = &trafficOffset re-assigned right BEFORE the call     489 @698
     Y5 memset(...); offset = &trafficOffset;  (3.12 #16 proper)      489 @698
     Y8 offset = &X; memset((u_char *)offset,...); pass offset        489 @698
     Y9 arg spelled (coorddef *)((char *)&trafficOffset)              489 @698
     Y2 store via offset->y AND pass &trafficOffset                   503 @684
     Y7 offset = &X; memset(offset); offset->y; pass offset           497 @684
   ONE NEW DATUM worth keeping: Y6 (keep the capture, store via offset->y, still PASS
   offset) is 19 @662 -- the FIRST basin this function has ever had that is SHORTER than
   the oracle (-13), i.e. `trafficOffset.y = ...` vs `offset->y = ...` at the two arms is
   worth 13 insns.  Not a landing, but it is a different direction from every 489/497/503
   measurement and is the only under-count base on record.
   CORRECTION TO THE W63 RECEIPT ABOVE: its "(i) NEW FALSIFICATION: reordering all three
   arms to `offset = &X; memset((u_char *)offset,0,0xc);` is INERT -- 4 diffs, byte-
   identical" is VOID.  W63 predates the W72 dead-copy discovery; re-measured on the LIVE
   definition only (compound 4-line anchor, count asserted == 2) that shape is 489 @698,
   not inert.  Treat any pre-W72 "inert" on this function as a missed-anchor alarm.
   STANDING VERDICT unchanged and now six-spelling-strong: passing the CALL RETURN VALUE
   is what keeps the two arms textually identical so they cross-jump-merge; any
   address-valued arg de-merges them, costs one callee-saved register (s3 appears, frame
   -104 -> -112, this s1 -> s2) and +9..23 insns.  W74 NEXT LENS still stands and is the
   right one: -dg the 489 variant and read WHICH allocno s3 carries; the 4-diff and 489
   builds differ by ONE source token per arm, so it is a clean control pair.
   Probe: scratchpad/w75/A9_v7.py, A9_v8.py (A9_probe.py harness, multi-count anchors). ==== */
/* ==== W76-A9 SEALED CLEAN (PASS 675/675, posmis 0) -- THE 7-WAVE a2 WALL WAS AN
   INLINED TU-LOCAL DERIVED-STATE CTOR, proven from the NFSU2-mobile x86 twin
   (nfsu2_x86_1.1.5/nfsu2.dll: AIHigh_BTC_Wingman::HighExecute @0x1015fa??
   calls ctor 0x10161850 = base-ctor + vf store + {coorddef local; zero-init;
   .y = carIndex*0xa0000; Newton_SetInitialSlicePositionOrientationEtc(&carObj_->N,
   0,&local,1);} + carObj_->N.active=0, then SetState(p,7) @0x101619b0).
   EA wrote a file-local class (its own D_80054F24 NonActive-vtable copy) whose
   INLINE CTOR holds the memset/Newton payload; integrate.c inline expansion is
   why retail rematerializes `addiu a2,sp,OFF` per arm with NO shared address
   pseudo (every flattened-source spelling either copies the memset return --
   addu a2,v0 -- or CSEs (plus fp K) across the call into a callee-saved = the
   489 basin; W74/W75 receipts above).  The two flattened freeze arms are now
   placement-new of this class; their leftover `coorddef *offset;` and shadow
   `coorddef trafficOffset;` decls MUST stay deleted (each unused decl re-grows
   the frame 104->120 and shifts every traffic slot +16).  The case-0 and case-2
   arms stay open-coded (they already gate PASS; W75 falsification history kept
   above).  Probe: scratchpad/w76/A9_btc_I4.variant, A9_btc_I4_posmis.txt. ==== */
struct AIState_BTCInactive : public AIState_Base {
    AIState_BTCInactive(Car_tObj *carObj) : AIState_Base(carObj) {
        coorddef trafficOffset;
        _vf = (__vtbl_ptr_type (*)[4])D_80054F24;
        memset((u_char *)&trafficOffset,0,12);
        trafficOffset.y = carObj->carIndex * 0xa0000;
        Newton_SetInitialSlicePositionOrientationEtc(&carObj_->N,0,&trafficOffset,1);
        carObj_->N.active = 0;
    }
};
void AIHigh_BTC_Wingman::HighExecute()
{
  ((AIHigh_BasicCop *)this)->CheckSpikeBelt();
  this->CheckForActivation();

  switch (this->stateType_) {
  case 0:
    {
      Car_tObj *carObj;
      AIState_Base *newState;
      coorddef trafficOffset;

      this->carObj_->AIFlags &= ~2;
      newState = operator new(8);
      carObj = this->carObj_;
      new(newState) AIState_Base(carObj);
      newState->_vf = (__vtbl_ptr_type (*)[4])D_80054F24;
      memset((u_char *)&trafficOffset,0,12);
      trafficOffset.y = carObj->carIndex * 0xa0000;
      Newton_SetInitialSlicePositionOrientationEtc(
          &newState->carObj_->N,0,&trafficOffset,1);
      newState->carObj_->N.active = 0;
      this->SetState(newState,(stateType_t)7);
    }
    goto stateExecuteAndReturn;

  case 2:
    {
      this->carObj_->AIFlags &= ~2;

      if ((this->newRole_ != this->currentRole_) &&
          ((u_int)(this->newRole_ - 2) < 2)) {
        if (AILife_IsCarInAnyVisibleArea(this->carObj_) == 0) {
          AIState_Base *newState;

          Speech_Mobile(this->carObj_)->Purge();
          this->currentRole_ = this->newRole_;
          this->SetupBlockader(this->newHumanBoss_,this->newRole_ == 3);

          newState = operator new(0x10);
          new(newState) AIState_Base(this->carObj_);
          newState->_vf = (__vtbl_ptr_type (*)[4])AIState_Idle_vtable;
          ((AIState_Idle *)newState)->idleInPlaceFlag_ = 1;
          this->SetState(newState,(stateType_t)3);
        }
      } else {
        this->CheckForNewTarget();
        if (this->perpTarget_ != 0) {
          coorddef pos;
          AIState_Chase *newState;

          this->GetCheckChasePosition(&pos);
          newState = operator new(0x94);
          newState = new(newState) AIState_Chase(
              this->carObj_,this->perpTarget_->GetCarObj(),&pos,
              0x200,0x3c0000,0x190000,2,0x10000);
          this->SetState((AIState_Base *)newState,(stateType_t)4);
        }
      }

      if (this->UpdateFreezeModeAndPullOverMode() != 0) {
        Car_tObj *carObj;
        AIState_Base *newState;
        coorddef trafficOffset;

        this->AssignToPlayer(0);
        newState = operator new(8);
        carObj = this->carObj_;
        new(newState) AIState_Base(carObj);
        newState->_vf = (__vtbl_ptr_type (*)[4])D_80054F24;
        memset((u_char *)&trafficOffset,0,12);
        trafficOffset.y = carObj->carIndex * 0xa0000;
        Newton_SetInitialSlicePositionOrientationEtc(
            &newState->carObj_->N,0,&trafficOffset,1);
        newState->carObj_->N.active = 0;
        this->SetState(newState,(stateType_t)7);
        this->newRole_ = 0;
        this->currentRole_ = 0;
        goto stateExecuteAndReturn;
      }
    }
    goto stateExecuteAndReturn;

  case 4:
    {
      coorddef newPos;
      coorddef pos;
      AIState_Chase *chaseState;

      chaseState = (AIState_Chase *)this->state_;
      this->carObj_->AIFlags |= 2;
      ((AIHigh_BasicCop *)this)->HandleBlockadeSpeech();

      if (this->GetCheckChasePosition(&newPos) != 0) {
        chaseState->SetTarget(this->perpTarget_->carObj_,&newPos);
      }

      if (0xa0 < chaseState->barrierTicks32_) {
        int endSlice;
        AIState_GotoSlice *newState;

        endSlice = chaseState->FindBarrierEndSlice();
        newState = operator new(0x10);
        newState =
            new(newState) AIState_GotoSlice(this->carObj_,endSlice,0);
        this->SetState((AIState_Base *)newState,(stateType_t)9);
      }

      if (this->CheckForNewTarget() != 0) {
        this->GetCheckChasePosition(&pos);
        chaseState->SetTarget(this->perpTarget_->carObj_,&pos);
      }

      {
        /* SYM-CODEGEN-CARRIER: minTimeInZone -- the three named threshold
         * values reproduce retail's constant allocation; folding all three
         * literals into the tests preserves 675 instructions but causes 24
         * diffs. */
        int minTimeInZone;
        /* SYM-CODEGEN-CARRIER: minLatMetersDistance */
        int minLatMetersDistance;
        /* SYM-CODEGEN-CARRIER: minLongMetersDistance */
        int minLongMetersDistance;
        /* SYM-CODEGEN-CARRIER: murder -- SYM records the three threshold
         * values but not this boolean. Removing it preserves the 675-
         * instruction body yet causes eight allocation/branch diffs: the
         * retail zero in a0 disappears and the first comparison moves from
         * v0 to a0. Both compound and nested direct tests give that same
         * receipt, so this carrier is required by the retail code shape. */
        int murder;

        minTimeInZone = 8;
        minLatMetersDistance = 0xe0000;
        minLongMetersDistance = 0xf0000;
        murder = 0;
        if (minTimeInZone < chaseState->inTargetRegion_) {
          if (__builtin_abs(chaseState->latMetersBetween_) <
              minLatMetersDistance) {
            if (__builtin_abs(chaseState->longMetersBetween_) <
                minLongMetersDistance) {
              murder = 1;
            }
          }
        }
        if (murder) {
          chaseState->SetMurderMode(1,0x300);
        }
      }

      if (this->perpTarget_ == 0) {
        AIState_Base *newState;

        this->AssignToPlayer(0);
        newState = operator new(8);
        newState =
            (AIState_Base *)new(newState) AIState_Normal(this->carObj_);
        this->SetState(newState,(stateType_t)2);
      }

      if ((this->newRole_ != this->currentRole_) &&
          ((u_int)(this->newRole_ - 2) < 2)) {
        AIState_Base *newState;

        this->carObj_->desiredDirection = -this->carObj_->desiredDirection;
        this->AssignToPlayer(0);
        newState = operator new(8);
        newState =
            (AIState_Base *)new(newState) AIState_Normal(this->carObj_);
        this->SetState(newState,(stateType_t)2);
        Speech_Mobile(this->carObj_)->Lose();
      }

      if (this->UpdateFreezeModeAndPullOverMode() != 0) {
        Car_tObj *carObj;
        AIState_Base *newState;

        this->AssignToPlayer(0);
        newState = operator new(8);
        carObj = this->carObj_;
        new(newState) AIState_BTCInactive(carObj);
        this->SetState(newState,(stateType_t)7);
        this->newRole_ = 0;
        this->currentRole_ = 0;
        goto stateExecuteAndReturn;
      }
    }
    goto stateExecuteAndReturn;

  case 3:
    {
      coorddef newPos;
      int rbDistanceMeters;
      int rbAbsDistanceMeters;
      int release;

      this->carObj_->AIFlags |= 2;
      this->CheckForNewTarget();
      release = 0;

      if (this->perpTarget_ == 0) {
        AIState_Base *newState;

        this->newRole_ = 1;
        this->currentRole_ = 1;
        newState = operator new(8);
        newState =
            (AIState_Base *)new(newState) AIState_Normal(this->carObj_);
        this->SetState(newState,(stateType_t)2);
        return;
      }

      this->GetCheckChasePosition(&newPos);
      if ((this->spikeBeltPlaced_ != 0) &&
          (AICop_spikeBelt.slice_ == this->spikeBeltSlice_)) {
        int timeNow = simGlobal.gameTicks;
        AICop_spikeBelt.freshenTime_ = timeNow;
      }

      rbDistanceMeters = AIWorld_ApxSplineDistance(
          this->carObj_,this->perpTarget_->carObj_);
      rbAbsDistanceMeters = __builtin_abs(rbDistanceMeters);

      if (rbAbsDistanceMeters < 0x320000) {
        release = 1;
      } else if (rbAbsDistanceMeters < 0x12c0000) {
        /* SYM-CODEGEN-CARRIER: speed -- a direct abs expression plus the
         * boundary fence builds only 674 instructions/15 diffs because GCC
         * fills the speed-load delay slot with the threshold constant. This
         * carrier restores retail's nop and bgtz/lui ordering. */
        int speed;
        int timeToRB;

        speed = this->perpTarget_->GetCarObj()->currentSpeed;
        if (speed <= 0) {
          speed = -speed;
        }
        speed = 0x471c7 < speed;
        if (speed) {
          /* MATCH: zero-instruction SLD-boundary fence. Without it GCC keeps
           * the first target chain live into line 189, producing 671
           * instructions/12 diffs. The retail body re-derives the complete
           * perpTarget_/carObj_/currentSpeed chain before fixeddiv. */
          __asm__("" : : : "memory");
          if (((timeToRB = fixeddiv(
                    rbDistanceMeters,
                    this->perpTarget_->GetCarObj()->currentSpeed)) > 0) &&
              (timeToRB < this->spikeBeltInterceptReleaseTime_)) {
            release = 1;
          }
        }
      }

      if (release) {
        AIState_Chase *newState;

        this->spikeBeltPlaced_ = 0;
        this->newRole_ = 1;
        this->currentRole_ = 1;
        newState = operator new(0x94);
        newState = new(newState) AIState_Chase(
            this->carObj_,this->perpTarget_->GetCarObj(),&newPos,
            0x200,0x3c0000,0x190000,2,0x10000);
        this->SetState((AIState_Base *)newState,(stateType_t)4);
      }

      if ((this->newRole_ != this->currentRole_) &&
          (this->newRole_ == 1)) {
        AIState_Base *newState;

        this->currentRole_ = 1;
        newState = operator new(8);
        newState =
            (AIState_Base *)new(newState) AIState_Normal(this->carObj_);
        this->SetState(newState,(stateType_t)2);
      }

      if (this->UpdateFreezeModeAndPullOverMode() != 0) {
        Car_tObj *carObj;
        AIState_Base *newState;

        this->AssignToPlayer(0);
        newState = operator new(8);
        carObj = this->carObj_;
        new(newState) AIState_BTCInactive(carObj);
        this->SetState(newState,(stateType_t)7);
        this->newRole_ = 0;
        this->currentRole_ = 0;
        goto stateExecuteAndReturn;
      }
    }
    goto stateExecuteAndReturn;

#if 0
  case 4:
    {
      coorddef newPos;
      AIState_Chase *chaseState;

      chaseState = (AIState_Chase *)this->state_;
      this->carObj_->AIFlags |= 2;
      ((AIHigh_BasicCop *)this)->HandleBlockadeSpeech();

      if (this->GetCheckChasePosition(&newPos) != 0) {
        chaseState->SetTarget(this->perpTarget_->carObj_,&newPos);
      }

      if (0xa0 < chaseState->barrierTicks32_) {
        int endSlice;
        AIState_GotoSlice *newState;
        AIState_Base *oldState;

        endSlice = chaseState->FindBarrierEndSlice();
        newState = operator new(0x10);
        newState =
            new(newState) AIState_GotoSlice(this->carObj_,endSlice,0);
        oldState = this->state_;
        if (oldState != 0) {
          (*(int (**)(...))((char *)oldState->_vf + 20))(
              (int)&oldState->carObj_ +
                  (int)*(short *)((int)*oldState->_vf + 0x10),3);
        }
        this->state_ = (AIState_Base *)newState;
        this->stateType_ = (stateType_t)9;
      }

      if (this->CheckForNewTarget() != 0) {
        coorddef pos;
        this->GetCheckChasePosition(&pos);
        chaseState->SetTarget(this->perpTarget_->carObj_,&pos);
      }

      {
        int murder;
        murder = 0;
        if (8 < chaseState->inTargetRegion_) {
          int meters;
          meters = chaseState->latMetersBetween_;
          if (meters < 0) {
            meters = -meters;
          }
          if (meters < 0xe0000) {
            meters = chaseState->longMetersBetween_;
            if (meters < 0) {
              meters = -meters;
            }
            murder = meters < 0xf0000;
          }
        }
        if (murder) {
          chaseState->SetMurderMode(1,0x300);
        }
      }

      if (this->perpTarget_ == 0) {
        AIState_Base *newState;
        AIState_Base *oldState;

        this->AssignToPlayer(0);
        newState = operator new(8);
        newState =
            (AIState_Base *)new(newState) AIState_Normal(this->carObj_);
        oldState = this->state_;
        if (oldState != 0) {
          (*(int (**)(...))((char *)oldState->_vf + 20))(
              (int)&oldState->carObj_ +
                  (int)*(short *)((int)*oldState->_vf + 0x10),3);
        }
        this->state_ = newState;
        this->stateType_ = (stateType_t)2;
      }

      if ((this->newRole_ != this->currentRole_) &&
          ((u_int)(this->newRole_ - 2) < 2)) {
        AIState_Base *newState;
        AIState_Base *oldState;
        Speaker *speaker;

        this->carObj_->desiredDirection = -this->carObj_->desiredDirection;
        this->AssignToPlayer(0);
        newState = operator new(8);
        newState =
            (AIState_Base *)new(newState) AIState_Normal(this->carObj_);
        oldState = this->state_;
        if (oldState != 0) {
          (*(int (**)(...))((char *)oldState->_vf + 20))(
              (int)&oldState->carObj_ +
                  (int)*(short *)((int)*oldState->_vf + 0x10),3);
        }
        this->state_ = newState;
        this->stateType_ = (stateType_t)2;
        speaker = (Speaker *)Speech_Mobile(this->carObj_);
        (**(int (**)(...))((int)*speaker->_vf + 0x3c))(
            (int)&speaker->fPosition.flags +
                (int)*(short *)((int)*speaker->_vf + 0x38));
      }

      if (this->UpdateFreezeModeAndPullOverMode() != 0) {
        Car_tObj *carObj;
        coorddef trafficOffset;

        this->AssignToPlayer(0);
        newState = operator new(8);
        carObj = this->carObj_;
        new(newState) AIState_Base(carObj);
        newState->_vf = (__vtbl_ptr_type (*)[4])D_80054F24;
        memset((u_char *)&trafficOffset,0,12);
        offset = &trafficOffset;
        trafficOffset.y = carObj->carIndex * 0xa0000;
        break;
      }
    }
    goto stateExecuteAndReturn;

#endif
  case 7:
    {
      this->carObj_->AIFlags &= ~2;
      if (this->currentRole_ == this->newRole_) {
        goto stateExecuteAndReturn;
      }

      if (this->newRole_ == 1) {
        this->currentRole_ = 1;
        this->SetupWingman(this->newHumanBoss_);
      } else {
        AIState_Base *newState;

        if (1 < (u_int)(this->newRole_ - 2)) {
          goto stateExecuteAndReturn;
        }
        this->currentRole_ = this->newRole_;
        this->SetupBlockader(
            this->newHumanBoss_,this->newRole_ == 3);
        newState = operator new(0x10);
        new(newState) AIState_Base(this->carObj_);
        newState->_vf = (__vtbl_ptr_type (*)[4])AIState_Idle_vtable;
        ((AIState_Idle *)newState)->idleInPlaceFlag_ = 1;
        this->SetState(newState,(stateType_t)3);
        goto stateExecuteAndReturn;
      }

      {
        AIState_Base *newState;
        newState = operator new(8);
        newState =
            (AIState_Base *)new(newState) AIState_Normal(this->carObj_);
        this->SetState(newState,(stateType_t)2);
      }
    }
    goto stateExecuteAndReturn;

  case 9:
    {
      AIState_GotoSlice *gotoState;
      AIState_Base *newState;

      gotoState = (AIState_GotoSlice *)this->state_;
      this->AssignToPlayer(0);
      if (gotoState->InTargetSliceRange(0xa0000) == 0) {
        goto stateExecuteAndReturn;
      }
      newState = operator new(8);
      newState =
          (AIState_Base *)new(newState) AIState_Normal(this->carObj_);
      this->SetState(newState,(stateType_t)2);
    }
    goto stateExecuteAndReturn;

  case 10:
  default:
    goto stateExecuteAndReturn;
  }

stateExecuteAndReturn:
  this->state_->StateExecute();
}








/* ---- CheckForActivation__18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::CheckForActivation  [AIH_BTCCOP.CPP:1270-1305] SLD-VERIFIED ---- */

int AIHigh_BTC_Wingman::CheckForActivation()



{
  int spikeBeltRequest;
  int carLoop;

  carLoop = 0;

  spikeBeltRequest = 0;

  while (true) {
    Car_tObj *otherCarObj;

    if (Cars_gNumCars <= carLoop) break;

    otherCarObj = Cars_gList[carLoop];

    if (((otherCarObj->carFlags & 0x200U) != 0) && ((otherCarObj->N).active != '\0')) {
      AIHigh_BTC_HumanCop *copHigh;

      copHigh = (AIHigh_BTC_HumanCop *)highLevelAIObjs[otherCarObj->carIndex];

      if ((copHigh)->CheckForWingmanRequest() != 0) {

        this->newRole_ = 1;

        this->newHumanBoss_ = copHigh;

      }

      if ((copHigh)->CheckForBlockaderRequest(&spikeBeltRequest) != 0) {

        this->newRole_ = spikeBeltRequest != 0 ?
            ROLE_BLOCKADER_SPIKEBELT : ROLE_BLOCKADER;

        this->newHumanBoss_ = copHigh;

      }

    }

    carLoop = carLoop + 1;

  }

  if (this->newHumanBoss_ != (AIHigh_BTC_HumanCop *)0x0) {

    (this->newHumanBoss_)->UpdateWingmanRole((Wingman_Role)this->currentRole_);

  }

  return (u_int)(this->currentRole_ != this->newRole_);

}








/* ---- UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::UpdateFreezeModeAndPullOverMode  [AIH_BTCCOP.CPP:1311-1329] SLD-FLAG:NONMONO ---- */

int AIHigh_BTC_Wingman::UpdateFreezeModeAndPullOverMode()



{
  /* SYM-CODEGEN-CARRIER: oldFreezeMode -- the retail sequence preserves the
   * pre-clear value across `freezeMode_ = 0` and compares it afterwards.
   * Expanding the result as control flow produces 20 instructions/20 diffs. */
  int oldFreezeMode;

  if (this->freezeMode_ == 3) {

    (this->carObj_)->pullOver = 1;

    return 0;

  }

  (this->carObj_)->pullOver = 0;

  oldFreezeMode = this->freezeMode_;

  this->freezeMode_ = 0;

  return (u_int)(oldFreezeMode == 4);

}








/* ---- SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop  AIHigh_BTC_Wingman::SetupWingman  [AIH_BTCCOP.CPP:1334-1346] SLD-VERIFIED ---- */

void AIHigh_BTC_Wingman::SetupWingman(AIHigh_BTC_HumanCop *humanCop)



{
  Car_tObj *otherCarObj;

  int side;

  int perpSide;

  otherCarObj = (humanCop)->carObj_;

  side = -1;

  if (-1 < otherCarObj->currentSpeed) {

    side = 1;

  }

  randtemp = fastRandom * randSeed;

  fastRandom = randtemp & 0xffff;

  perpSide = -1;

  if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 < 500) {

    perpSide = 1;

  }

  /* SYM-CODEGEN-CARRIER: sideTimes28 -- preserving the scaled side as a
   * distinct expression value keeps the retail side/perpSide register handout;
   * both direct product associations produce six register diffs. */
  int sideTimes28;

  sideTimes28 = side * 0x1c;

  perpSide = perpSide * sideTimes28;

  if (perpSide >= 0) {

    perpSide = (otherCarObj->N).simRoadInfo.slice - -perpSide;

    if (gNumSlices <= perpSide) {

      perpSide = perpSide - gNumSlices;

    }

  }

  else {

    perpSide = (otherCarObj->N).simRoadInfo.slice - -perpSide;

    if (perpSide < 0) {

      perpSide = perpSide + gNumSlices;

    }

  }

  AILife_PlaceCarAtLocation(this->carObj_,perpSide,0,side,

             otherCarObj->currentSpeed,0);

  Speech_Dispatch()->Ready(this->carObj_);

  return;

}








/* ---- SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi  AIHigh_BTC_Wingman::SetupBlockader  [AIH_BTCCOP.CPP:1352-1484] SLD-VERIFIED ---- */

void AIHigh_BTC_Wingman::SetupBlockader(AIHigh_BTC_HumanCop *humanCop,int spikeBeltRequest)



{
  /* PASS RECEIPT 2026-08-13 (340/340): division/clamp boundaries recovered
     the retail rematerialization and upper-clamp allocation (103 -> 95).
     The real gBlockadeTypes table plus SLD-ordered RNG locals reduced 95 -> 58;
     distinct selector/product and branch-local slice shapes reduced 58 -> 16.
     Finally, direct Trk_NewSlice width/lane field expressions (width << 15),
     with no redundant address snapshots, reproduce both spike-belt calls and
     close 16 -> PASS.  Falsified: long-lived volatile belt snapshots, result
     fences, and explicit width/lane locals. */
  int initSlice;
  Car_tObj*copObj;
  int blockadeType;

  /* SYM-CODEGEN-CARRIER: blockadeDirection -- snapshotting the car direction
   * prevents a second member load and preserves the delayed blockade_.direction
   * store. Direct field use grows the body to 342 instructions/20 diffs. */
  int blockadeDirection;

  /* SYM-CODEGEN-CARRIER: blockadeFlags -- the selected table byte is distinct
   * from the recorded blockadeType selector. Folding the lookup into
   * blockadeType preserves length but causes ten address-allocation diffs. */
  u_char blockadeFlags;

  /* SYM-CODEGEN-CARRIER: sliceOffset -- the distance-to-slice conversion
   * occupies the oracle's anonymous $a1. Reusing the recorded
   * initializationDistance local instead produces 22 register diffs. */
  int sliceOffset;

  /* SYM-CODEGEN-CARRIER: blockadeSlice -- retail wraps the candidate in an
   * anonymous caller-saved value and stores blockade_.slice only after the RNG
   * setup. Updating the member in place preserves length but causes 30 diffs. */
  int blockadeSlice;

  /* SYM-CODEGEN-CARRIER: perpDistance -- preserving the spline-distance
   * result separately leaves the recorded spikeBeltSide in $v1. Folding the
   * call into the sign test causes 18 allocation diffs. */
  int perpDistance;

  copObj = humanCop->GetCarObj();

  if (humanCop->perpTarget_ != (AIHigh_BTC_Perp *)0x0) {

    int perpToHumanDistance;
    int side;
    int initializationDistance;
    Car_tObj*perpObj;

    perpObj = humanCop->perpTarget_->GetCarObj();

    side = -1;

    if (-1 < perpObj->currentSpeed) {

      side = 1;

    }

    perpToHumanDistance = AIWorld_ApxSplineDistance(perpObj,copObj);

    initializationDistance = 0x1f40000;
    if (initializationDistance < __builtin_abs(perpToHumanDistance)) {
      initializationDistance = __builtin_abs(perpToHumanDistance);
    }
    /* SYM-CODEGEN-CARRIER: maximumDistance -- materializing the upper clamp
     * independently reproduces the oracle's compare/copy form. A literal
     * conditional shrinks the body to 337 instructions and causes nine diffs. */
    int maximumDistance = 0x5dc0000;
    initializationDistance =
        (initializationDistance < maximumDistance) ?
        initializationDistance : maximumDistance;

    if (perpToHumanDistance * side < 0) {

      sliceOffset = (initializationDistance / 0x60000) * side;

      if (-1 < sliceOffset) {

        initSlice = (copObj->N).simRoadInfo.slice + sliceOffset;

      if (gNumSlices <= initSlice) {

        initSlice = initSlice - gNumSlices;

      }

      }

      else {

        initSlice = (copObj->N).simRoadInfo.slice + sliceOffset;

        if (initSlice < 0) {

          initSlice = initSlice + gNumSlices;

        }

      }

    }

    else {

      sliceOffset = (initializationDistance / 0x60000) * side;

      if (-1 < sliceOffset) {

        initSlice = (perpObj->N).simRoadInfo.slice + sliceOffset;

        if (gNumSlices <= initSlice) {

          initSlice = initSlice - gNumSlices;

        }

      }

      else {

        initSlice = (perpObj->N).simRoadInfo.slice + sliceOffset;

      if (initSlice < 0) {

        initSlice = initSlice + gNumSlices;

      }

      }

    }

    this->blockade_.blockadeSpeechFlags = 1;

    this->blockade_.target =

         (AIHigh_Player *)(humanCop)->perpTarget_;

  }

  else {

    int side = -1;

    if (-1 < copObj->currentSpeed) {

      side = 1;

    }

    /* SYM-CODEGEN-CARRIER: initializationSliceDistance -- keeping the 0x53
     * scale as a value emits the retail multiply. A literal is strength-
     * reduced, grows the body to 343 instructions, and causes nine diffs. */
    int initializationSliceDistance = 0x53;
    side = side * initializationSliceDistance;

    /* SYM-CODEGEN-CARRIER: initSliceCandidate -- the two branch-local
     * candidates preserve the retail copy into initSlice. Direct initSlice
     * updates shrink the body to 338 instructions and cause 32 diffs.
     * W85-S1 (device clearance): the `+r` identity fence on the FIRST branch's
     * candidate is DEAD (removed -> 40/40 PASS byte-identical) and is gone; the
     * one on the ELSE branch's candidate is LIVE (removing it costs 20 diffs on
     * SetupBlockader), as is the `+r` fence on `slice` further down (28 diffs). */
    if (-1 < side) {

      int initSliceCandidate = (copObj->N).simRoadInfo.slice + side;
      __asm__("" : "+r"(initSliceCandidate));
      /* SYM-CODEGEN-CARRIER: numSlices -- the saved wrap bound moves the
       * global load ahead of initSlice's copy; using gNumSlices directly leaves
       * a 341-instruction/5-diff schedule. */
      int numSlices = gNumSlices;
      initSlice = initSliceCandidate;

      if (numSlices <= initSlice) {

        initSlice = initSlice - numSlices;

      }

    }

    else {

      int initSliceCandidate = (copObj->N).simRoadInfo.slice + side;

      if (initSliceCandidate < 0) {

        initSlice = initSliceCandidate + gNumSlices;
      }
      else {
        initSlice = initSliceCandidate;
      }

    }

    this->blockade_.blockadeSpeechFlags = 0;

    this->blockade_.target = (AIHigh_Player *)0x0;

  }

LAB_8005f268:

  blockadeDirection = copObj->direction;

  this->blockade_.direction = blockadeDirection;

  if (0 <= -blockadeDirection) {

    blockadeSlice = initSlice - blockadeDirection;

    if (gNumSlices <= blockadeSlice) {

      blockadeSlice = blockadeSlice - gNumSlices;

    }

  }

  else {

    blockadeSlice = initSlice - blockadeDirection;

    if (blockadeSlice < 0) {

      blockadeSlice = blockadeSlice + gNumSlices;

    }

  }

  randtemp = fastRandom * randSeed;

  this->blockade_.slice = blockadeSlice;

  AICop_gRoadBlockState = kAICop_RoadBlockState_WaitingForPerp;

  fastRandom = randtemp & 0xffff;

  blockadeType = (randtemp >> 8 & 0xffff) % 5;
  blockadeFlags = gBlockadeTypes[blockadeType];

  this->blockade_.flags = blockadeFlags;

  if (blockadeFlags != 0) {

    if (stackSpeedUpEnbabledFlag != 0) {

      gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
            stackSpeedUpEnbabledFlag = 0;

      ((AIHigh_BasicCop *)this)->SetupBlockadeElements(&this->blockade_);

      gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
            stackSpeedUpEnbabledFlag = 1;

    }

    else {

      ((AIHigh_BasicCop *)this)->SetupBlockadeElements(&this->blockade_);

    }

  }

  AILife_ReencarnateCopByLatPosAndRotation(this->carObj_,initSlice,

             ((humanCop)->carObj_)->direction,0,0x100);

  if (spikeBeltRequest != 0) {

    int spikeBeltSide;
    int left;
    int right;
    int slice;
    int rightLatPos;
    int timeNow;

    perpDistance = AIWorld_ApxSplineDistance(this->carObj_,copObj);

    spikeBeltSide = -1;

    if (-1 < perpDistance) {

      spikeBeltSide = 1;

    }

    spikeBeltSide = spikeBeltSide * 6;

    if (-1 < spikeBeltSide) {

      slice = ((this->carObj_)->N).simRoadInfo.slice +

              spikeBeltSide;

      if (gNumSlices <= slice) {

        slice = slice - gNumSlices;

      }

    }

    else {

      slice = ((this->carObj_)->N).simRoadInfo.slice +

              spikeBeltSide;

      if (slice < 0) {

        slice = slice + gNumSlices;

      }

    }

    /* MATCH: zero-insn identity fence keeps the SYM-recorded `slice` live in
     * the retail caller-saved register across the member store/RNG sequence.
     * Removing it preserves 340 instructions but causes 28 diffs; replacing
     * following member reads with the local shrinks to 337/173 diffs. */
    __asm__("" : "+r"(slice));
    this->spikeBeltSlice_ = slice;

    randtemp = fastRandom * randSeed;

    fastRandom = randtemp & 0xffff;

    this->spikeBeltInterceptReleaseTime_ = ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999;

    left = fixedmult(((u_int)BWorldSm_slices[this->spikeBeltSlice_].avgPavedWidthLf << 15) *
                     (BWorldSm_slices[this->spikeBeltSlice_].laneCount >> 4)

                       ,0xcccc);

    right =

         fixedmult(((u_int)BWorldSm_slices[this->spikeBeltSlice_].avgPavedWidthRt << 15) *
                   (BWorldSm_slices[this->spikeBeltSlice_].laneCount & 0xf),0xcccc)

    ;

    rightLatPos = right;

    /* SYM-CODEGEN-CARRIER: beltSlice -- snapshotting the member preserves the
     * retail ordering of the global spike-belt stores. Reading the member at
     * the slice store keeps 340 instructions but causes 16 scheduling diffs. */
    int beltSlice = this->spikeBeltSlice_;

    AICop_spikeBelt.leftLatPos_ = -left;

    AICop_spikeBelt.rightLatPos_ = rightLatPos;

    AICop_spikeBelt.active_ = 1;

    AICop_spikeBelt.slice_ = beltSlice;

    timeNow = simGlobal.gameTicks;

    AICop_spikeBelt.freshenTime_ = timeNow;

    BWorld_SetSpikeBelt(this->spikeBeltSlice_,AICop_spikeBelt.leftLatPos_,

               left + rightLatPos);

    this->spikeBeltPlaced_ = 1;

  }

  Speech_Dispatch()->Ready(this->carObj_);

  return;

}








/* ---- _._18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::dtor  [AIH_BTCCOP.CPP:?] SLD-FLAG:NO_SLD ---- */

AIHigh_BTC_Wingman::~AIHigh_BTC_Wingman()



{


  return;

}








/* ---- _._19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::dtor  [AIH_BTCCOP.CPP:?] SLD-FLAG:NO_SLD ---- */

AIHigh_BTC_HumanCop::~AIHigh_BTC_HumanCop()



{


  return;

}








/* ---- _._14AIHigh_BTC_Cop  AIHigh_BTC_Cop::dtor  [AIH_BTCCOP.CPP:?] SLD-FLAG:NO_SLD ---- */

/* The empty source destructor naturally emits retail's base-forward
   `___14AIHigh_BTC_Cop` and supplies implicit `this`; no free-function receiver
   name is needed. */
AIHigh_BTC_Cop::~AIHigh_BTC_Cop()
{
}







































/* ==== AIState vague-linkage tail (2026-08-03 name-fix): btccop's OWN compiled copies of the
 * shared AIState helpers -- retail emitted one instance per .obj (SYM names them identically at
 * distinct VAs; oracle vtable copies D_80054F24/D_80054F44 are this obj's NonActive/Base vtables,
 * recon binds the shared vtable symbols like every other 100% fn in this TU).  Bodies mirror the
 * aistate.cpp instances (100%-proven spellings). */
extern __vtbl_ptr_type AIState_NonActive_vtable[], AIState_Base_vtable[];

/* ---- Execute__17AIState_NonActive @0x8005F624 : empty per-frame body (real method --
 * the cc1plus demangle guard rejects the mangled name as a plain identifier) ---- */
void AIState_NonActive::Execute()
{
  return;
}

/* ---- ___17AIState_NonActive @0x8005F62C : deleting dtor (SYM _._17AIState_NonActive) ---- */
AIState_NonActive::~AIState_NonActive()
{
  this->_vf = (__vtbl_ptr_type (*) [4])AIState_NonActive_vtable;
  ((this->carObj_)->N).active = '\x01';
  this->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;
  return;
}

/* ---- TestForRelease__12AIState_Base_8005F678 @0x8005F678 : shared default impl (real method) ---- */
extern "C" int TestForRelease__12AIState_Base_8005F678(AIState_Base *)
{
  return 0;
}

/* w60 unlock: the surplus canonical `AIState_Base::TestForRelease()` member def that
 * lived here collided with aihigh.cpp's (owner of 0x8005B4C4) -- removed. */

/* ---- ___12AIState_Base_8005F680 @0x8005F680 : deleting dtor (SYM _._12AIState_Base) ---- */
extern "C" void ___12AIState_Base_8005F680(AIState_Base *pThis,int __in_chrg)
{
  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;
}

/* end of aih_btccop.cpp */
