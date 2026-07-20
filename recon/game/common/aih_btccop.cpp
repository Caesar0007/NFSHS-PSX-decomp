/* game/common/aih_btccop.cpp -- RECONSTRUCTED (Beat-the-Clock cop AI hierarchy; C++ TU)
 *   40 fns across 3 classes (AIHigh_BTC_Cop -> AIHigh_BTC_HumanCop; AIHigh_BTC_Wingman)
 *   + AIState_NonActive tail. Composition-modeled inheritance (_base_ members); manual _vf
 *   vtable dispatch (8-byte __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs
 *   AIHigh_BTC_<C>_vtable. Faithful C++ (option A). NOT original; SYM-faithful, recompilable.
 *   vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_btccop_externs.h"

extern int AI_elapsedTime;   /* H19: ai.cpp @0x8013C554 (not in this TU's externs) */

/* ---- aih_btccop.obj-owned .data statics (8-byte run @0x8013c560, byte-exact vs NFS4.EXE = {0,1}) ---- */
/* cfront fn-local static AIHigh_BTC_HumanCop::lastInputRequestTick_ (dotted SYM
   _19AIHigh_BTC_HumanCop.lastInputRequestTick_). Image value 0; reset to 0 each ::reset. */
int          _19AIHigh_BTC_HumanCop_lastInputRequestTick_ = 0;   /* @0x8013c560 */
/* anonymous file-static toggle (no SYM name) immediately following; image value 1 (engaged). */
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

  int iVar2;



  changed = 0;

  iVar2 = ((AIHigh_BasicPerp *)this->perpTarget_)->CheckChaserPosition(this->copIndex_,

                     (this->carObj_)->carIndex);

  if (iVar2 != this->chaseIndex_) {

    changed = 1;

    this->chaseIndex_ = iVar2;

  }

  newPosition = this->chaseIndex_;

  *pos = AIH_BTCCop_chasePositions[0][newPosition];

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

  Speaker *pSVar1;

  Car_tObj *carObj;

  

  if (this->freezeMode_ == 0) {

    carObj = this->carObj_;

    this->freezeMode_ = 3;

    if ((carObj->carFlags & 0x200U) != 0) {

      pSVar1 = (Speaker *)Speech_Mobile(carObj);

      (**(int (**)(...))((int)*pSVar1->_vf + 0x4c))

                ((int)&(pSVar1->fPosition).flags + (int)*(short *)((int)*pSVar1->_vf + 0x48),1);

    }

  }

  return;

}








/* ---- FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::FinishArrest  [AIH_BTCCOP.CPP:253-280] SLD-VERIFIED ---- */

void AIHigh_BTC_Cop::FinishArrest(AIHigh_BTC_Perp *arrestMe)



{

  __vtbl_ptr_type (*pa_Var1) [3];

  

  if ((this->freezeMode_ == 3) || (this->freezeMode_ == 0)) {

    pa_Var1 = this->_vf;

    this->freezeMode_ = 4;

    (**(int (**)(...))((int)*pa_Var1 + 0x1c))

              ((int)&this->carObj_ + (int)*(short *)((int)*pa_Var1 + 0x18));

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

  Car_tObj *pCVar2;

  

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

  pCVar2 = this->carObj_;

  pCVar2->unlap = 0;

  _19AIHigh_BTC_HumanCop_lastInputRequestTick_ = 0;

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

      startMovement = (u_int)(AIHigh_CopGameType != 4);

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

    if ((0x5eb8 < bend) && (AIHigh_CopGameType != 4)) {

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
  int maxRuns;

  int slideAmount;

  int startCheckSlice;
  int leftLaneFree;
  int rightLaneFree;



  randtemp = fastRandom * randSeed;

  fastRandom = randtemp & 0xffff;

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

  slideAmount = safetyZone / 5;

  maxRuns = 0;

  do {

    if (0x1d < maxRuns) {

      return newSlice;

    }

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

      return newSlice;

    }

    newSlice = newSlice + slideAmount;

    if (0 <= slideAmount) {

      if (gNumSlices <= newSlice) {

        newSlice = newSlice - gNumSlices;

      }

    }

    else {

      if (newSlice < 0) {

        newSlice = newSlice + gNumSlices;

      }

    }

    maxRuns = maxRuns + 1;

  } while( true );

}








/* ---- ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp  AIHigh_BTC_HumanCop::ReleaseAndStartChase  [AIH_BTCCOP.CPP:399-419] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::ReleaseAndStartChase(AIHigh_BTC_Perp *newPerp)



{

  Car_tObj *pCVar1;

  

  pCVar1 = this->carObj_;

  pCVar1->AIFlags = pCVar1->AIFlags | 2;

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
  int startDirection;
  int startSlice;
  int startMovement;
  int addToSlice;

  int iVar1;

  int iVar2;

  int direction;

  u_int movement;

  

  if (this->copIndex_ == 0) {

    direction = -1;

    randtemp = fastRandom * randSeed;

    fastRandom = randtemp & 0xffff;

    if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 500) {

      direction = 1;

    }

    randtemp = fastRandom * randSeed;

    fastRandom = randtemp & 0xffff;

    movement = 0;

    if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 0x2ee) {

      movement = (u_int)(AIHigh_CopGameType != 4);

    }

    iVar1 = AIDataRecord_TrackCurve->Get((int)((this->carObj_)->N).simRoadInfo.slice);

    if ((0x41 < iVar1) && (AIHigh_CopGameType != 4)) {

      movement = 1;

    }

    iVar1 = this->FindRandomBarrierFreeArea((int)((this->carObj_)->N).simRoadInfo.slice,100,1);

    if ((this->currentStage_ + 1U & 1) == 0) {

      iVar2 = direction * 7;

    }

    else {

      iVar2 = direction * -7;

    }

    if (iVar2 >= 0) {

      iVar1 = iVar1 + iVar2;

      if (gNumSlices <= iVar1) {

        iVar1 = iVar1 - gNumSlices;

      }

    }

    else {

      iVar1 = iVar1 + iVar2;

      if (iVar1 < 0) {

        iVar1 = iVar1 + gNumSlices;

      }

    }

    ((this->carObj_)->N).simRoadInfo.slice =

         (short)iVar1;

    this->NewStage(iVar1,direction,movement);

  }

  return;

}








/* ---- CheckConditionWithCop0__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::CheckConditionWithCop0  [AIH_BTCCOP.CPP:461-485] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::CheckConditionWithCop0()



{
  AIHigh_BTC_HumanCop*leadCop;
  int startDirection;
  int startSlice;
  int startMovement;
  int addToSlice;

  AIHigh_Base *pAVar1;

  int iVar2;

  int iVar3;

  stateType_t direction;

  

  if (this->copIndex_ != 0) {

    pAVar1 = highLevelAIObjs[0];

    if (this->currentStage_ < (int)highLevelAIObjs[0][4].state_) {

      int movement;

      direction = highLevelAIObjs[0][5].stateType_;

      movement = highLevelAIObjs[0][5].schedulingOff_;

      iVar3 = (int)(highLevelAIObjs[0]->carObj_->N).simRoadInfo.slice;

      if ((this->currentStage_ + 1U & 1) != 0) {

        iVar2 = direction * 0xe;

      }

      else {

        iVar2 = direction * -0xe;

      }

      if (0 <= iVar2) {

        iVar3 = iVar3 + iVar2;

        if (gNumSlices <= iVar3) {

          iVar3 = iVar3 - gNumSlices;

        }

      }

      else {

        iVar3 = iVar3 + iVar2;

        if (iVar3 < 0) {

          iVar3 = iVar3 + gNumSlices;

        }

      }

      this->NewStage(iVar3,direction,movement);

    }

    (this->carObj_)->desiredSpeed =

         pAVar1->carObj_->desiredSpeed;

  }

  return;

}








/* ---- NewStage__19AIHigh_BTC_HumanCopiii  AIHigh_BTC_HumanCop::NewStage  [AIH_BTCCOP.CPP:490-618] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::NewStage(int copSlice,int direction,int movement)



{
  int nextStageTime;
  int initialDirection;
  int initialMovement;
  int rightPos;
  int leftPos;

  Car_tObj *pCVar1;

  int iVar2;

  int iVar3;

  u_int uVar4;

  int iVar5;

  int iVar6;

  int newLatPos;

  int throwAway;



  this->currentStage_ = this->currentStage_ + 1;

  GameSetup_gData.perpArrests = GameSetup_gData.perpArrests + 1;

  if ((((u_int)(AIHigh_CopGameType - 2) < 2) && (GameSetup_gData.numPerps <= this->currentStage_)) ||

     ((AIHigh_CopGameType == 4 && (2 < this->currentStage_)))) {

    simVar.endSimGame = 1;

    return;

  }

  BWorld_InitSpikeBelt();

  AICop_spikeBelt.active_ = 0;

  Object_ClearCustomObjects();

  pCVar1 = this->carObj_;

  this->initialDirection_ = direction;

  this->initialMovement_ = movement;

  (pCVar1->N).simRoadInfo.slice = (short)copSlice;

  (this->carObj_)->direction = direction;

  AICop_gRoadBlockState = 0;

  throwAway = 0;

  newLatPos = 0;

  AIWorld_FindBarrierLessLaneAndPosition(this->carObj_,&newLatPos,&throwAway);

  iVar2 = throwAway;

  if (AIHigh_CopGameType == 4) {

    iVar5 = 0;

    iVar6 = 0;

    goto LAB_8005d8cc;

  }

  if (movement != 0) {

    iVar5 = direction * 0xd5555;

    iVar6 = 0;

    goto LAB_8005d8cc;

  }

  iVar3 = copSlice * 0x20 + (int)BWorldSm_slices;

  iVar6 = (u_int)*(u_char *)(iVar3 + 0x1f) * 0x8000 * (*(u_char *)(iVar3 + 0x1d) & 0xf);

  uVar4 = (u_int)(*(u_char *)(iVar3 + 0x1d) >> 4);

  iVar5 = (u_int)*(u_char *)(iVar3 + 0x1e) * 0x8000 * uVar4;

  iVar2 = *(short *)(iVar3 + 0x1a) * 0x100 + -0x8000;

  if (iVar6 < iVar2) {

    iVar2 = iVar6;

  }

  iVar6 = *(short *)(iVar3 + 0x18) * 0x100 + -0x8000;

  if (iVar5 < iVar6) {

    iVar6 = iVar5;

  }

  iVar5 = AIWorld_IsDriveableLane(copSlice,6 - uVar4);

  if (iVar5 == 0) {

    iVar6 = iVar6 + -0x20000;

  }

  iVar5 = AIWorld_IsDriveableLane(copSlice,(*(u_char *)(copSlice * 0x20 + (int)BWorldSm_slices + 0x1d) & 0xf) + 7);

  if (iVar5 == 0) {

    iVar2 = iVar2 + -0x20000;

  }

  if (this->copIndex_ == 0) {

    if (AITune_driveSide != 1) goto LAB_8005d8b8;

LAB_8005d8a0:

    iVar6 = direction * 0x100;

  }

  else {

    if (AITune_driveSide == -1) goto LAB_8005d8a0;

LAB_8005d8b8:

    iVar2 = -iVar6;

    iVar6 = direction * -0x100;

  }

  iVar6 = iVar6 + 0x200;

  iVar5 = 0;

LAB_8005d8cc:

  AILife_PlaceCarAtLocation(this->carObj_,copSlice,iVar2,direction,

             iVar5,iVar6);

  if (AIHigh_CopGameType == 4) {

    iVar2 = AIH_BTC_Cop_1HC1HP_StageTimes[this->currentStage_];

  }

  else {

    iVar2 = GameSetup_gData.perpInfo[this->currentStage_].TimeLimit;

  }

  iVar2 = iVar2 << 5;

  if (iVar2 < 0) {

    iVar2 = 0;

  }

  iVar2 = iVar2 * this->stageTimeMultiplier_;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xffff;

  }

  if (this->copIndex_ == 0) {

    Hud_BTC_BonusTime((iVar2 >> 0x10) << 1);

  }

  iVar6 = this->timeLeft_;

  this->needPerp_ = 1;

  this->chaseStartTime_ = 0;

  this->wingmanStatus_ = 0;

  this->freezeMode_ = 1;

  this->timeLeft_ = iVar6 + (iVar2 >> 0x10);

  TrgSfx_RestartTrgSfx();

  return;

}








/* ---- UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::UpdateAndCheckTimeLeft  [AIH_BTCCOP.CPP:624-650] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::UpdateAndCheckTimeLeft()



{
  static bool sayLose;

  AIHigh_BTC_Perp *pAVar1;

  Speaker *pSVar2;

  int _Var3;

  char *perpname;

  int timeleft;

  int iVar4;

  

  _Var3 = this->freezeMode_;

  if ((_Var3 != 3) && (_Var3 != 1)) {

    this->timeLeft_ = this->timeLeft_ - AI_elapsedTime;   /* H19: subtraction dropped (m2c self-assign fold); oracle 0x8005D9E8-FC timeLeft_ -= AI_elapsedTime */

  }

  pAVar1 = this->perpTarget_;

  /* MATCH: TWO calls in source — gcc tail-merges them into one jal + per-arm arg setup
     (a0=carInfo+0x5C self-add in then-arm; a0=0/a1=a0-copy zeros in else; shared sltiu in the jal slot) */
  if (pAVar1 != (AIHigh_BTC_Perp *)0x0) {

    Hud_BTC_Update(((pAVar1)->carObj_)->carInfo->driver,this->timeLeft_,
                   (void *)(u_int)((this->carObj_)->RSControl == 0));

  }

  else {

    Hud_BTC_Update((char *)0x0,0,(void *)(u_int)((this->carObj_)->RSControl == 0));

  }

  if (this->timeLeft_ < 0) {

    if (AIH_BTCCop_freezeToggle_8013c564 != 0) {

      pSVar2 = (Speaker *)Speech_Mobile(this->carObj_);

      (**(int (**)(...))((int)*pSVar2->_vf + 0x3c))

                ((int)&(pSVar2->fPosition).flags + (int)*(short *)((int)*pSVar2->_vf + 0x38));

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

  Speaker *pSVar1;

  Speaker *pSVar3;

  int iVar2;



  if (1 < (u_int)(this->freezeMode_ - 3)) {

    iVar2 = GameSetup_gData.perpInfo[this->currentStage_].WingmanTime * 0x40 +

            AITune_BTC[GameSetup_gData.skill].wingmanTime;

    pSVar1 = (Speaker *)Speech_Mobile(this->carObj_);

    (**(int (**)(...))((int)*pSVar1->_vf + 0x64))

              ((int)&(pSVar1->fPosition).flags + (int)*(short *)((int)*pSVar1->_vf + 0x60));

    if (this->chaseStartTime_ == 0) goto LAB_dispatch;

    if (iVar2 == 0) goto LAB_dispatch;

    if (simGlobal.gameTicks - this->chaseStartTime_ <= iVar2) goto LAB_dispatch;

    if (this->wingmanStatus_ != 4) {

      this->wingmanStatus_ = 1;

      goto LAB_end;

    }

LAB_dispatch:

    pSVar3 = (Speaker *)Speech_Dispatch();

    (**(int (**)(...))((int)*pSVar3->_vf + 0x1c))

              ((int)&(pSVar3->fPosition).flags + (int)*(short *)((int)*pSVar3->_vf + 0x18));

LAB_end: ;

  }

  return;

}








/* ---- RequestBlockader__19AIHigh_BTC_HumanCopi  AIHigh_BTC_HumanCop::RequestBlockader  [AIH_BTCCOP.CPP:752-781] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::RequestBlockader(int spikeBeltRequest)



{
  int availableTime;

  Speaker *pSVar1;

  Speaker *pSVar2;

  Speaker *pSVar4;

  Speaker *pSVar5;



  if (1 < (u_int)(this->freezeMode_ - 3)) {

    if (spikeBeltRequest != 0) {

      pSVar1 = (Speaker *)Speech_Mobile(this->carObj_);

      (**(int (**)(...))((int)*pSVar1->_vf + 0x5c))

                ((int)&(pSVar1->fPosition).flags + (int)*(short *)((int)*pSVar1->_vf + 0x58));

      availableTime = GameSetup_gData.perpInfo[this->currentStage_].SpikeBeltTime * 0x40 +

                      AITune_BTC[GameSetup_gData.skill].spikeBeltTime;

    }

    else {

      pSVar2 = (Speaker *)Speech_Mobile(this->carObj_);

      (**(int (**)(...))((int)*pSVar2->_vf + 0x54))

                ((int)&(pSVar2->fPosition).flags + (int)*(short *)((int)*pSVar2->_vf + 0x50));

      availableTime = GameSetup_gData.perpInfo[this->currentStage_].BlockadeCopTime * 0x40 +

                      AITune_BTC[GameSetup_gData.skill].blockaderTime;

    }

    if (this->chaseStartTime_ == 0) goto LAB_dispatch;

    if (availableTime < 1) goto LAB_dispatch;

    if (simGlobal.gameTicks - this->chaseStartTime_ <= availableTime) goto LAB_dispatch;

    if (this->wingmanStatus_ != 5) {

      pSVar4 = (Speaker *)Speech_Dispatch();

      (**(int (**)(...))((int)*pSVar4->_vf + 0x24))

                ((int)&(pSVar4->fPosition).flags + (int)*(short *)((int)*pSVar4->_vf + 0x20));

      if (spikeBeltRequest != 0) {

        this->wingmanStatus_ = 3;

      }

      else {

        this->wingmanStatus_ = 2;

      }

      goto LAB_end;

    }

LAB_dispatch:

    pSVar5 = (Speaker *)Speech_Dispatch();

    (**(int (**)(...))((int)*pSVar5->_vf + 0x1c))

              ((int)&(pSVar5->fPosition).flags + (int)*(short *)((int)*pSVar5->_vf + 0x18));

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

  Car_tObj *pCVar3;

  Car_tObj **ppCVar4;

  int iVar5;



  iVar5 = 0;

  while (1) {

    if (Cars_gNumTrafficCars <= iVar5) break;

    pCVar3 = Cars_gTrafficCarList[iVar5];

    iVar5 = iVar5 + 1;

    highLevelAIObjs[pCVar3->carIndex][1].state_ = (AIState_Base *)0x1;

  }

  return;

}








/* ---- ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::ResetClearTrafficToPurgatory  [AIH_BTCCOP.CPP:842-848] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::ResetClearTrafficToPurgatory()



{
  int trafficLoop;
  Car_tObj*testTrafficCarObj;
  AIHigh_Traffic*testTrafficHigh;

  Car_tObj *pCVar3;

  int iVar5;



  iVar5 = 0;

  while (1) {

    if (Cars_gNumTrafficCars <= iVar5) break;

    pCVar3 = Cars_gTrafficCarList[iVar5];

    iVar5 = iVar5 + 1;

    highLevelAIObjs[pCVar3->carIndex][1].state_ = (AIState_Base *)0x0;

  }

  return;

}








/* ---- SetDesiredSpeed__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::SetDesiredSpeed  [AIH_BTCCOP.CPP:854-858] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::SetDesiredSpeed()



{
  int curveSpeed;

  int iVar1;

  Car_tObj *carObj;

  

  carObj = this->carObj_;

  if (carObj->RSControl != 0) {

    iVar1 = AISpeeds_CalcHumanTopSpeed(carObj);

    carObj = this->carObj_;

    if (this->requestedDesiredSpeed_ < iVar1) {

      iVar1 = this->requestedDesiredSpeed_;

    }

    carObj->desiredSpeed = iVar1;

  }

  return;

}








/* ---- HighExecute__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::HighExecute  [AIH_BTCCOP.CPP:863-931] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::HighExecute()



{
  Car_tObj *pCVar1;

  AIHigh_BTC_Perp *pAVar2;

  coorddef notUsed;



  if ((this->copIndex_ == 0) &&

     (this->freezeMode_ == 1)) {

    this->ClearTrafficToPurgatory();

  }

  pAVar2 = this->perpTarget_;

  if ((pAVar2 != (AIHigh_BTC_Perp *)0x0) && (this->freezeMode_ != 1)) {

    (this->carObj_)->desiredDirection =

         ((pAVar2)->carObj_)->direction;

  }

  this->SetDesiredSpeed();

  this->CheckConditionWithCop0();

  this->UpdateFreezeModeAndPullOverMode();

  this->UpdateAndCheckTimeLeft();

  this->CheckForNewTarget();

  if (this->perpTarget_ != (AIHigh_BTC_Perp *)0x0) {

    this->GetCheckChasePosition(&notUsed);

  }

  if (AIHigh_CopGameType == 2) {

    if (0x281 <= simGlobal.gameTicks - _19AIHigh_BTC_HumanCop_lastInputRequestTick_) {

      if (((this->carObj_)->control).queuedEvent ==

          '\x04') {

        this->RequestWingman();

        ((this->carObj_)->control).queuedEvent = '\0';

        _19AIHigh_BTC_HumanCop_lastInputRequestTick_ = simGlobal.gameTicks;

      }

      if (((this->carObj_)->control).queuedEvent ==

          '\x05') {

        this->RequestBlockader(0);

        ((this->carObj_)->control).queuedEvent = '\0';

        _19AIHigh_BTC_HumanCop_lastInputRequestTick_ = simGlobal.gameTicks;

      }

      if (((this->carObj_)->control).queuedEvent ==

          '\x06') {

        this->RequestBlockader(1);

        ((this->carObj_)->control).queuedEvent = '\0';

        _19AIHigh_BTC_HumanCop_lastInputRequestTick_ = simGlobal.gameTicks;

      }

    }

    else {

      pCVar1 = this->carObj_;

      if ((u_int)(u_char)(pCVar1->control).queuedEvent - 4 < 3) {

        (pCVar1->control).queuedEvent = '\0';

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

    Car_tObj *pCVar1 = (arrestMe)->carObj_;

    Hud_BustedOverlayOn(simGlobal.gameTicks - this->chaseStartTime_,

               pCVar1->carInfo->driver,

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








/* ---- CheckForActivation__18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::CheckForActivation  [AIH_BTCCOP.CPP:1270-1305] SLD-VERIFIED ---- */

int AIHigh_BTC_Wingman::CheckForActivation()



{
  int spikeBeltRequest;
  int carLoop;
  Car_tObj*otherCarObj;
  AIHigh_BTC_HumanCop*copHigh;

  int iVar1;

  Wingman_Role WVar3;

  Car_tObj **ppCVar4;

  AIHigh_Base **copTable;



  carLoop = 0;

  spikeBeltRequest = 0;

  copTable = highLevelAIObjs;

  ppCVar4 = Cars_gList;

  while (true) {

    if (Cars_gNumCars <= carLoop) break;

    otherCarObj = *ppCVar4;

    if (((otherCarObj->carFlags & 0x200U) != 0) && ((otherCarObj->N).active != '\0')) {

      copHigh = (AIHigh_BTC_HumanCop *)copTable[otherCarObj->carIndex];

      iVar1 = (copHigh)->CheckForWingmanRequest();

      if (iVar1 != 0) {

        this->newRole_ = 1;

        this->newHumanBoss_ = copHigh;

      }

      iVar1 = (copHigh)->CheckForBlockaderRequest(&spikeBeltRequest);

      if (iVar1 != 0) {

        WVar3 = 2;

        if (spikeBeltRequest != 0) {

          WVar3 = 3;

        }

        this->newRole_ = WVar3;

        this->newHumanBoss_ = copHigh;

      }

    }

    ppCVar4 = ppCVar4 + 1;

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

  int _Var1;

  

  if (this->freezeMode_ == 3) {

    (this->carObj_)->pullOver = 1;

    return 0;

  }

  (this->carObj_)->pullOver = 0;

  _Var1 = this->freezeMode_;

  this->freezeMode_ = 0;

  return (u_int)(_Var1 == 4);

}








/* ---- SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop  AIHigh_BTC_Wingman::SetupWingman  [AIH_BTCCOP.CPP:1334-1346] SLD-VERIFIED ---- */

void AIHigh_BTC_Wingman::SetupWingman(AIHigh_BTC_HumanCop *humanCop)



{
  Car_tObj *otherCarObj;

  int side;

  int perpSide;

  Speaker *pSVar1;



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

  int sideTimes28;

  sideTimes28 = side * 0x1c;

  perpSide = perpSide * sideTimes28;

  if (perpSide >= 0) {

    perpSide = (otherCarObj->N).simRoadInfo.slice + perpSide;

    if (gNumSlices <= perpSide) {

      perpSide = perpSide - gNumSlices;

    }

  }

  else {

    perpSide = (otherCarObj->N).simRoadInfo.slice + perpSide;

    if (perpSide < 0) {

      perpSide = perpSide + gNumSlices;

    }

  }

  AILife_PlaceCarAtLocation(this->carObj_,perpSide,0,side,

             otherCarObj->currentSpeed,0);

  pSVar1 = (Speaker *)Speech_Dispatch();

  (**(int (**)(...))((int)*pSVar1->_vf + 0x2c))

            ((int)&(pSVar1->fPosition).flags + (int)*(short *)((int)*pSVar1->_vf + 0x28),

             this->carObj_);

  return;

}








/* ---- SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi  AIHigh_BTC_Wingman::SetupBlockader  [AIH_BTCCOP.CPP:1352-1484] SLD-VERIFIED ---- */

void AIHigh_BTC_Wingman::SetupBlockader(AIHigh_BTC_HumanCop *humanCop,int spikeBeltRequest)



{
  int initSlice;
  Car_tObj*copObj;
  int blockadeType;
  int perpToHumanDistance;
  int side;
  int initializationDistance;
  Car_tObj*perpObj;
  int spikeBeltSide;
  int left;
  int right;
  int slice;
  int rightLatPos;
  int timeNow;

  u_char bVar1;

  short sVar2;

  int iVar3;

  u_long uVar4;

  Speaker *pSVar5;

  int iVar6;

  int iVar7;

  AIHigh_BTC_Perp *pAVar8;

  Car_tObj *carObj;

  int iVar9;

  Car_tObj *otherCarObj;

  

  pAVar8 = (humanCop)->perpTarget_;

  otherCarObj = (humanCop)->carObj_;

  if (pAVar8 != (AIHigh_BTC_Perp *)0x0) {

    carObj = (pAVar8)->carObj_;

    perpObj = carObj;

    side = -1;

    if (-1 < carObj->currentSpeed) {

      side = 1;

    }

    iVar3 = AIWorld_ApxSplineDistance(carObj,otherCarObj);

    iVar7 = iVar3;

    if (iVar3 < 0) {

      iVar7 = -iVar3;

    }

    iVar6 = 0x1f40000;

    if (0x1f40000 < iVar7) {

      iVar6 = iVar7;

    }

    iVar7 = 0x5dc0000;

    if (iVar6 < 0x5dc0000) {

      iVar7 = iVar6;

    }

    if (iVar3 * side < 0) {

      initSlice = (iVar7 / 0x60000) * side;

      if (initSlice < 0) {

        initSlice = (otherCarObj->N).simRoadInfo.slice + initSlice;

        goto LAB_8005f1bc;

      }

      sVar2 = (otherCarObj->N).simRoadInfo.slice;

LAB_8005f190:

      initSlice = sVar2 + initSlice;

      if (gNumSlices <= initSlice) {

        initSlice = initSlice - gNumSlices;

      }

    }

    else {

      initSlice = (iVar7 / 0x60000) * side;

      if (-1 < initSlice) {

        sVar2 = (perpObj->N).simRoadInfo.slice;

        goto LAB_8005f190;

      }

      initSlice = (perpObj->N).simRoadInfo.slice + initSlice;

LAB_8005f1bc:

      if (initSlice < 0) {

        initSlice = initSlice + gNumSlices;

      }

    }

    this->blockade_.blockadeSpeechFlags = 1;

    this->blockade_.target =

         (AIHigh_Player *)(humanCop)->perpTarget_;

  }

  else {

    initSlice = -1;

    if (-1 < otherCarObj->currentSpeed) {

      initSlice = 1;

    }

    initSlice = initSlice * 0x53;

    if (initSlice < 0) {

      initSlice = (otherCarObj->N).simRoadInfo.slice + initSlice;

      if (initSlice < 0) {

        initSlice = initSlice + gNumSlices;

      }

    }

    else {

      initSlice = (otherCarObj->N).simRoadInfo.slice + initSlice;

      if (gNumSlices <= initSlice) {

        initSlice = initSlice - gNumSlices;

      }

    }

    this->blockade_.blockadeSpeechFlags = 0;

    this->blockade_.target = (AIHigh_Player *)0x0;

  }

LAB_8005f268:

  iVar7 = otherCarObj->direction;

  this->blockade_.direction = iVar7;

  if (0 <= -iVar7) {

    iVar7 = initSlice - iVar7;

    if (gNumSlices <= iVar7) {

      iVar7 = iVar7 - gNumSlices;

    }

  }

  else {

    iVar7 = initSlice - iVar7;

    if (iVar7 < 0) {

      iVar7 = iVar7 + gNumSlices;

    }

  }

  randtemp = fastRandom * randSeed;

  this->blockade_.slice = iVar7;

  AICop_gRoadBlockState = 1;

  fastRandom = randtemp & 0xffff;

  bVar1 = "\x05\x06\x04\x02"[(randtemp >> 8 & 0xffff) % 5];

  this->blockade_.flags = (u_int)bVar1;

  if (bVar1 != 0) {

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

    iVar9 = AIWorld_ApxSplineDistance(this->carObj_,otherCarObj);

    iVar7 = -1;

    if (-1 < iVar9) {

      iVar7 = 1;

    }

    iVar7 = iVar7 * 6;

    if (-1 < iVar7) {

      iVar7 = ((this->carObj_)->N).simRoadInfo.slice +

              iVar7;

      if (gNumSlices <= iVar7) {

        iVar7 = iVar7 - gNumSlices;

      }

    }

    else {

      iVar7 = ((this->carObj_)->N).simRoadInfo.slice +

              iVar7;

      if (iVar7 < 0) {

        iVar7 = iVar7 + gNumSlices;

      }

    }

    this->spikeBeltSlice_ = iVar7;

    randtemp = fastRandom * randSeed;

    fastRandom = randtemp & 0xffff;

    this->spikeBeltInterceptReleaseTime_ = ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999;

    iVar9 = *(volatile int *)&this->spikeBeltSlice_ * 0x20 + (int)BWorldSm_slices;

    iVar9 = fixedmult((u_int)*(u_char *)(iVar9 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar9 + 0x1d) >> 4)

                       ,0xcccc);

    iVar7 = *(volatile int *)&this->spikeBeltSlice_ * 0x20 + (int)BWorldSm_slices;

    AICop_spikeBelt.rightLatPos_ =

         fixedmult((u_int)*(u_char *)(iVar7 + 0x1f) * 0x8000 * (*(u_char *)(iVar7 + 0x1d) & 0xf),0xcccc)

    ;

    AICop_spikeBelt.leftLatPos_ = -iVar9;

    AICop_spikeBelt.slice_ = this->spikeBeltSlice_;

    AICop_spikeBelt.active_ = 1;

    AICop_spikeBelt.freshenTime_ = simGlobal.gameTicks;

    BWorld_SetSpikeBelt(this->spikeBeltSlice_,AICop_spikeBelt.leftLatPos_,

               iVar9 + AICop_spikeBelt.rightLatPos_);

    this->spikeBeltPlaced_ = 1;

  }

  pSVar5 = (Speaker *)Speech_Dispatch();

  (**(int (**)(...))((int)*pSVar5->_vf + 0x2c))

            ((int)&(pSVar5->fPosition).flags + (int)*(short *)((int)*pSVar5->_vf + 0x28),

             this->carObj_);

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

AIHigh_BTC_Cop::~AIHigh_BTC_Cop()



{


  return;

}







































/* end of aih_btccop.cpp */
