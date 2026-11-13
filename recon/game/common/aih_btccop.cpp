/* game/common/aih_btccop.cpp -- RECONSTRUCTED (Beat-the-Clock cop AI hierarchy; C++ TU)
 *   40 fns across 3 classes (AIHigh_BTC_Cop -> AIHigh_BTC_HumanCop; AIHigh_BTC_Wingman)
 *   + AIState_NonActive tail. Real C++ inheritance; real virtual
 *   vtable dispatch (8-byte __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs
 *   AIHigh_BTC_<C>_vtable. Faithful C++ (option A). NOT original; SYM-faithful, recompilable.
 *   vs disasm-v2.
 */
#include "../../link_stripped.h"
#include "../../lib/nfs4_new.h"
#include "aih_btccop_types.h"
#include "aih_btccop_externs.h"

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int NumRaceCars(void) { return Cars_gNumRaceCars; }


/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int GameTicks(void) { return simGlobal.gameTicks; }
/* spike-belt helpers: retail records their inline pairs (parameters slice/rightLatPos/timeNow, no `this`) */
static inline void SpikeBelt_SetActive(int active) { AICop_spikeBelt.active_ = active; }
/* SpikeBelt_Slice lives in aih_btccop_externs.h: retail records its inline pair at the caller's line (header inline) */
static inline void SpikeBelt_Set(int slice, int leftLatPos, int rightLatPos) {
    AICop_spikeBelt.leftLatPos_ = leftLatPos;
    AICop_spikeBelt.rightLatPos_ = rightLatPos;
    AICop_spikeBelt.active_ = 1;
    AICop_spikeBelt.slice_ = slice;
}
static inline void SpikeBelt_SetFreshenTime(int timeNow) { AICop_spikeBelt.freshenTime_ = timeNow; }
static inline void SpikeBelt_Freshen(int timeNow) { SpikeBelt_SetFreshenTime(timeNow); }
/* slice arithmetic with wrap-around (a macro: retail records no locals or inline pairs for it, and every
   use of its slice argument expands again -- six CarObj() pairs on one line in SetupBlockader) */
#define SLICE_ADD(slice, delta) \
    ((delta) >= 0 ? ((slice) + (delta) >= gNumSlices ? (slice) + (delta) - gNumSlices : (slice) + (delta)) \
                  : ((slice) + (delta) < 0 ? (slice) + (delta) + gNumSlices : (slice) + (delta)))


/* Retail aih_btccop.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *buffer, char *fmt, ...);

extern int AI_elapsedTime;   /* H19: ai.cpp @0x8013C554 (not in this TU's externs) */
extern char gBlockadeTypes[5];

/* aih_btccop.obj .sdata opens with lastInputRequestTick_=0 @8013c560 and
 * UpdateAndCheckTimeLeft's initialized function-static sayLose=true @8013c564.
 * Retail's STAT numeric value4 is the object-relative small-data offset. */
/* SYM/MAP: _19AIHigh_BTC_HumanCop.lastInputRequestTick_. */
int AIHigh_BTC_HumanCop::lastInputRequestTick_ = 0;   /* @0x8013c560 */

/* ---- aih_btccop.obj-owned globals (.bss zero) ---- */
int          AIH_BTC_Cop_1HC1HP_StageTimes[3] = { 60, 60, 60 };   /* @0x8010cd98 */
coorddef     AIH_BTCCop_chasePositions[3][6] = { { {0, 0, 720896}, {-524288, 0, 0}, {0, 0, -983040}, {0, 0, -983040}, {0, 0, -983040}, {0, 0, -983040} }, { {0, 0, 524288}, {-393216, 0, 524288}, {393216, 0, 0}, {0, 0, -655360}, {0, 0, -655360}, {0, 0, -655360} }, { {0, 0, 327680}, {-262144, 0, 327680}, {262144, 0, 327680}, {0, 0, -327680}, {0, 0, -327680}, {0, 0, -327680} } };   /* @0x8010cda4 */


/* ---- __14AIHigh_BTC_CopP8Car_tObji  AIHigh_BTC_Cop::ctor  [AIH_BTCCOP.CPP:107-111] SLD-VERIFIED ---- */

/* SYM (retail): fn-scope locals are only initSlice/copObj/blockadeType.  The accessor pairs
     (humanCop->CarObj(), PerpTarget(), the spike belt's Set/Freshen), the SLICE_ADD wrap macro and
     plain field stores reproduce the 340 retail instructions without the former carrier locals
     (blockadeDirection, blockadeFlags, sliceOffset, blockadeSlice, perpDistance, slice, the
     else-arm candidates) and without the identity asm fences. */
/* a named bound (gcc propagates it away, so it leaves no record): the literal form is folded to
       MIN_EXPR(x, K) and clamps in place, while retail computes MIN(K, x) in a temporary. */















































/* ==== AIState vague-linkage tail (2026-08-03 name-fix): btccop's OWN compiled copies of the
 * shared AIState helpers -- retail emitted one instance per .obj (SYM names them identically at
 * distinct VAs; oracle vtable copies D_80054F24/D_80054F44 are this obj's NonActive/Base vtables,
 * recon binds the shared vtable symbols like every other 100% fn in this TU).  Bodies mirror the
 * aistate.cpp instances (100%-proven spellings). */

/* ---- Execute__17AIState_NonActive @0x8005F624 : empty per-frame body (real method --
 * the cc1plus demangle guard rejects the mangled name as a plain identifier) ---- */

/* ---- ___17AIState_NonActive @0x8005F62C : deleting dtor (SYM _._17AIState_NonActive) ---- */

/* ---- TestForRelease__12AIState_Base_8005F678 @0x8005F678 : shared default impl (real method) ---- */

/* w60 unlock: the surplus canonical `AIState_Base::TestForRelease()` member def that
 * lived here collided with aihigh.cpp's (owner of 0x8005B4C4) -- removed. */

/* ---- ___12AIState_Base_8005F680 @0x8005F680 : deleting dtor (SYM _._12AIState_Base) ---- */

/* end of aih_btccop.cpp */
#line 107 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
AIHigh_BTC_Cop::AIHigh_BTC_Cop(Car_tObj *carObj,int copIndex) : AIHigh_BasicCop(carObj,copIndex)
{
  this->perpTarget_ = (AIHigh_BTC_Perp *)0x0;
  this->chaseIndex_ = 0;
  this->freezeMode_ = 0;
}








/* ---- AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::AssignToPlayer  [AIH_BTCCOP.CPP:115-126] SLD-VERIFIED ---- */

#line 110 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Cop::AssignToPlayer(AIHigh_BTC_Perp *target)




{

  if (this->perpTarget_ != (AIHigh_BTC_Perp *)0x0) { ((AIHigh_BasicPerp *)this->perpTarget_)->RemoveChaser(this->copIndex_,
               (this->carObj_)->carIndex,(copType)this->type_); } this->perpTarget_ = target;






  if (target != (AIHigh_BTC_Perp *)0x0) { ((AIHigh_BasicPerp *)target)->AddChaser(this->copIndex_,
               (this->carObj_)->carIndex,(copType)this->type_); } return; }








/* ---- GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef  AIHigh_BTC_Cop::GetCheckChasePosition  [AIH_BTCCOP.CPP:130-148] SLD-VERIFIED ---- */

#line 125 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
int AIHigh_BTC_Cop::GetCheckChasePosition(coorddef *pos)




{ int newPosition; int changed; changed = 0; newPosition = ((AIHigh_BasicPerp *)this->perpTarget_)->CheckChaserPosition(this->copIndex_,





                     (this->carObj_)->carIndex);

  if (newPosition != this->chaseIndex_) {

    changed = 1;
    this->chaseIndex_ = newPosition; }





  *pos = AIH_BTCCop_chasePositions[0][this->chaseIndex_];
  return changed; }








/* ---- CheckForNewTarget__14AIHigh_BTC_Cop  AIHigh_BTC_Cop::CheckForNewTarget  [AIH_BTCCOP.CPP:154-206] SLD-VERIFIED ---- */

#line 149 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
int AIHigh_BTC_Cop::CheckForNewTarget()




{ AIHigh_BTC_Perp*newTarget; int newTargetDistance; int perpLoop; AIHigh_BTC_Perp*old;

  newTarget = (AIHigh_BTC_Perp *)0x0;
  newTargetDistance = 0x27100000;

  old = this->perpTarget_;









  for (perpLoop = 0; perpLoop < Cars_gNumRaceCars; perpLoop = perpLoop + 1) { Car_tObj *testPerpCarObj; int thisPerpCarIndex; AIHigh_BTC_Perp *thisPerpHigh;

    testPerpCarObj = Cars_gRaceCarList[perpLoop];
    if (testPerpCarObj->N.active == '\0' || (testPerpCarObj->carFlags & 0x200U) != 0) continue;



    thisPerpCarIndex = testPerpCarObj->carIndex;
    thisPerpHigh = (AIHigh_BTC_Perp *)highLevelAIObjs[thisPerpCarIndex];

    if (thisPerpHigh->basicPerpInfo_.GetCrime() != 0)
    { int copToTargetDistanceMeters;
      const int distanceMeters = AIWorld_ApxSplineDistance(this->carObj_,testPerpCarObj);
      copToTargetDistanceMeters = __builtin_abs(distanceMeters);
      if (copToTargetDistanceMeters < newTargetDistance) {

        newTargetDistance = copToTargetDistanceMeters;
        newTarget = thisPerpHigh; } }





  }


  if ((newTarget != (AIHigh_BTC_Perp *)0x0) && (newTarget != old)) {

    this->AssignToPlayer(newTarget);
    return 1; } else {





    if ((old != (AIHigh_BTC_Perp *)0x0) && (newTarget == (AIHigh_BTC_Perp *)0x0)) {
      this->AssignToPlayer((AIHigh_BTC_Perp *)0x0); }
    return 0; } }








/* ---- StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::StartArrest  [AIH_BTCCOP.CPP:213-250] SLD-VERIFIED ---- */

#line 208 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Cop::StartArrest(AIHigh_BTC_Perp *arrestMe)




{





  if (this->freezeMode_ != 0) return;





















  this->freezeMode_ = 3;




  if ((this->carObj_->carFlags & 0x200U) != 0) {
    Speech::Mobile(this->carObj_)->Catch(1);
  }

}








/* ---- FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::FinishArrest  [AIH_BTCCOP.CPP:253-280] SLD-VERIFIED ---- */

#line 248 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Cop::FinishArrest(AIHigh_BTC_Perp *arrestMe)




{








  if ((this->freezeMode_ != 3) && (this->freezeMode_ != 0)) return;







  this->freezeMode_ = 4;

  this->FreezeAndEndChase();
  this->HudOff();






}








/* ---- FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp  AIHigh_BTC_Cop::FalseArrest  [AIH_BTCCOP.CPP:283-293] SLD-VERIFIED ---- */

#line 278 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Cop::FalseArrest(AIHigh_BTC_Perp *cantArrestMe)




{




  if (this->perpTarget_ == cantArrestMe) {


    this->freezeMode_ = 2;
  } return;
}








/* ---- FreezeAndEndChase__14AIHigh_BTC_Cop  AIHigh_BTC_Cop::FreezeAndEndChase  [AIH_BTCCOP.CPP:296-302] SLD-VERIFIED ---- */

#line 291 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Cop::FreezeAndEndChase()




{





}








/* ---- HudOff__14AIHigh_BTC_Cop  AIHigh_BTC_Cop::HudOff  [AIH_BTCCOP.CPP:305-311] SLD-VERIFIED ---- */

#line 300 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Cop::HudOff()




{




  if (this->copIndex_ == 0) {
    Hud_BustedOverlayOff(); }
}








/* ---- __19AIHigh_BTC_HumanCopP8Car_tObji  AIHigh_BTC_HumanCop::ctor  [AIH_BTCCOP.CPP:326-369] SLD-VERIFIED ---- */

#line 326 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
AIHigh_BTC_HumanCop::AIHigh_BTC_HumanCop(Car_tObj *carObj,int copIndex) : AIHigh_BTC_Cop(carObj,copIndex)
{ this->SetInitialMovement(1);
  this->needPerp_ = 0; this->SetInitialDirection(0); this->SetRequestedDesiredSpeed(0);




  lastInputRequestTick_ = 0;
  this->currentStage_ = -1;
  this->stageRepeatCount_ = 0;
  this->stageTimeMultiplier_ = 0x10000;
  this->timeLeft_ = AITune_BTC[GameSetup_gData[0][2] /* skill */].baseChaseTime;

  this->carObj_->unlap = 0;

  AILife_PlaceCarAtLocation(this->carObj_,0,0,1,0,0);

  if (copIndex == 0)
  { int startDirection; int startMovement; int startSlice; int addToSlice; int bend; startDirection = -1;



    randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 500) {
      startDirection = 1; }



    randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; startMovement = 0; if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 0x2ee) { startMovement = (u_int)(AIHigh_CopGameType != COP_GAME_BTC_1HC1HP); }




    startSlice = this->FindRandomBarrierFreeArea(0,100,500);
    if (((this->currentStage_ + 1) & 1) == 0) { addToSlice = startDirection * 7; } else { addToSlice = -(startDirection * 7); } startSlice = addToSlice >= 0 ? (startSlice + addToSlice >= gNumSlices ? startSlice + addToSlice - gNumSlices : startSlice + addToSlice) : (startSlice + addToSlice < 0 ? startSlice + addToSlice + gNumSlices : startSlice + addToSlice);




    bend = AIWorld_CalcRoadBend(this->carObj_,3);
    if (bend < 0) { bend = -bend; }
    if ((0x5eb8 < bend) && (AIHigh_CopGameType != COP_GAME_BTC_1HC1HP)) {
      startMovement = 1; }

    this->NewStage((int)((this->carObj_)->N).simRoadInfo.slice,startDirection,startMovement); } return; }
/* ASMF1 2026-11-07: fence gone -- the dead slice wrap (aih_play ternary form, result unused) is retail: bytes/SYM/SLD exact with it; the wrap compares vanish after flow, leaving only the addToSlice calc and the a0 copy. */








/* ---- FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii  [AIH_BTCCOP.CPP:379-392] ---- */
/* 2026-10-12 MATCH116/116: the recorded newOffset holds the doubled random
 * fraction, then the signed offset. No separate doubledFraction object is
 * necessary. Ordered native local/type/home/depth and scope tuples agree;
 * complete SLD/literal original staging spelling remains source-review work.
 * No const alias, qualifier, fence or output rewrite replaces the capture. */

#line 374 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
int AIHigh_BTC_HumanCop::FindRandomBarrierFreeArea(int startSlice,int safetyZone,int randomDistance)




{ int newOffset; int newSlice;
  randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; newOffset = (randtemp >> 8 & 0xffff) * 2; newOffset = (int)((u_int)(randomDistance * newOffset) >> 0x10) - randomDistance;
  if (0 <= newOffset) { newSlice = startSlice + newOffset; if (gNumSlices <= newSlice) { newSlice = newSlice - gNumSlices; } } else { newSlice = startSlice + newOffset; if (newSlice < 0) { newSlice = newSlice + gNumSlices; } }
  for (int maxRuns = 0; maxRuns < 30; maxRuns++) { int startCheckSlice; int leftLaneFree; int rightLaneFree; startCheckSlice = newSlice - safetyZone;

    if (0 <= -safetyZone) { if (gNumSlices <= startCheckSlice) { startCheckSlice = startCheckSlice - gNumSlices; } } else { if (startCheckSlice < 0) { startCheckSlice = startCheckSlice + gNumSlices; } }
    leftLaneFree = AIWorld_IsDriveableLaneInSliceRange(startCheckSlice,safetyZone << 1,1,6);
    rightLaneFree = AIWorld_IsDriveableLaneInSliceRange(startCheckSlice,safetyZone << 1,1,7);
    if ((leftLaneFree != 0) && (rightLaneFree != 0)) { break; }

    if (0 <= safetyZone / 5) { newSlice = (newSlice + safetyZone / 5 < gNumSlices) ? newSlice + safetyZone / 5 : newSlice + safetyZone / 5 - gNumSlices; } else { newSlice = (0 <= newSlice + safetyZone / 5) ? newSlice + safetyZone / 5 : newSlice + safetyZone / 5 + gNumSlices; }
    }

  return newSlice; }








/* ---- ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp  AIHigh_BTC_HumanCop::ReleaseAndStartChase  [AIH_BTCCOP.CPP:399-419] SLD-VERIFIED ---- */

#line 394 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::ReleaseAndStartChase(AIHigh_BTC_Perp *newPerp)




{





  this->carObj_->AIFlags = this->carObj_->AIFlags | 2;

  this->CheckForNewTarget();

  if (this->perpTarget_ == newPerp) {





    this->freezeMode_ = 2;

    this->chaseStartTime_ = simGlobal.gameTicks; }

  this->ResetClearTrafficToPurgatory(); return; }








/* ---- FreezeAndEndChase__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::FreezeAndEndChase  [AIH_BTCCOP.CPP:425-456] SLD-VERIFIED ---- */

#line 420 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::FreezeAndEndChase()




{








  if (this->copIndex_ == 0)
  { int startDirection; int startSlice; int startMovement; int addToSlice; startDirection = -1;



    randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 500) {
      startDirection = 1; }



    randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; startMovement = 0; if (((randtemp & 0xffff00) >> 8) * 1000 >> 0x10 < 0x2ee) { startMovement = (AIHigh_CopGameType != COP_GAME_BTC_1HC1HP); } startSlice = AIDataRecord_TrackCurve_Get(AIDataRecord_TrackCurve,




                                       (int)((this->carObj_)->N).simRoadInfo.slice); if ((0x41 < startSlice) && (AIHigh_CopGameType != COP_GAME_BTC_1HC1HP)) {
      startMovement = 1; }

    startSlice = this->FindRandomBarrierFreeArea((int)((this->carObj_)->N).simRoadInfo.slice,100,1);
    if ((this->currentStage_ + 1U & 1) == 0) { addToSlice = startDirection * 7; } else { addToSlice = startDirection * -7; }
    if (addToSlice >= 0) { startSlice = startSlice + addToSlice; if (gNumSlices <= startSlice) { startSlice = startSlice - gNumSlices; } } else { startSlice = startSlice + addToSlice; if (startSlice < 0) { startSlice = startSlice + gNumSlices; } } ((this->carObj_)->N).simRoadInfo.slice =
         (short)startSlice;
    this->NewStage(startSlice,startDirection,startMovement); } return; }








/* ---- CheckConditionWithCop0__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::CheckConditionWithCop0  [AIH_BTCCOP.CPP:461-485] SLD-VERIFIED ---- */

#line 456 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::CheckConditionWithCop0()




{



  if (this->copIndex_ != 0)
  {
    AIHigh_BTC_HumanCop *leadCop = (AIHigh_BTC_HumanCop *)highLevelAIObjs[0];
    if (leadCop->CurrentStage() > this->CurrentStage())
    { int startDirection = leadCop->InitialDirection(); int startSlice; int startMovement = leadCop->InitialMovement(); int addToSlice;






      startSlice = leadCop->CarObj()->N.simRoadInfo.slice;
      if ((this->currentStage_ + 1U & 1) != 0) addToSlice = startDirection * 0xe; else addToSlice = startDirection * -0xe;
      if (0 <= addToSlice) { startSlice = startSlice + addToSlice; if (gNumSlices <= startSlice) startSlice = startSlice - gNumSlices; } else { startSlice = startSlice + addToSlice; if (startSlice < 0) startSlice = startSlice + gNumSlices; }
      this->NewStage(startSlice,startDirection,startMovement); }





    this->carObj_->desiredSpeed = leadCop->CarObj()->desiredSpeed; } }








/* ---- NewStage__19AIHigh_BTC_HumanCopiii  AIHigh_BTC_HumanCop::NewStage  [AIH_BTCCOP.CPP:490-618] SLD-VERIFIED ---- */

#line 485 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::NewStage(int copSlice,int direction,int movement)




{ int nextStageTime; int newLatPos; int throwAway;
  this->currentStage_ = this->currentStage_ + 1;
  GameSetup_gData[0][109] /* perpArrests */ = GameSetup_gData[0][109] /* perpArrests */ + 1; if ((((u_int)(AIHigh_CopGameType - COP_GAME_BTC_1HC) < 2) && (this->currentStage_ >= GameSetup_gData[0][107] /* numPerps */)) ||









     ((AIHigh_CopGameType == COP_GAME_BTC_1HC1HP && (2 < this->currentStage_)))) {







    simVar.endSimGame = 1;
    return; }




  BWorld_InitSpikeBelt(); SpikeBelt_SetActive(0);



  Object_ClearCustomObjects(); this->SetInitialDirection(direction); this->SetInitialMovement(movement);
  AICop_gRoadBlockState = kAICop_RoadBlockState_None;







  newLatPos = 0; throwAway = 0;

  (this->carObj_->N).simRoadInfo.slice = (short)copSlice;
  (this->carObj_)->direction = direction;
  AIWorld_FindBarrierLessLaneAndPosition(this->carObj_,&throwAway,&newLatPos);

  if (AIHigh_CopGameType == COP_GAME_BTC_1HC1HP) {






    AILife_PlaceCarAtLocation(this->carObj_,copSlice,newLatPos,direction,0,0); }

  else if (movement != 0) { AILife_PlaceCarAtLocation(this->carObj_,copSlice,newLatPos,direction,






               direction * 0xd5555,0); } else


  { int rightPos; int leftPos;
  rightPos = (BWorldSm_slices[copSlice].avgPavedWidthRt << 15) * (BWorldSm_slices[copSlice].laneCount & 0xf);
  leftPos = (BWorldSm_slices[copSlice].avgPavedWidthLf << 15) * (BWorldSm_slices[copSlice].laneCount >> 4);
  rightPos = rightPos < BWorldSm_slices[copSlice].rightDrive * 0x100 + -0x8000 ? rightPos : BWorldSm_slices[copSlice].rightDrive * 0x100 + -0x8000;
  leftPos = leftPos < BWorldSm_slices[copSlice].leftDrive * 0x100 + -0x8000 ? leftPos : BWorldSm_slices[copSlice].leftDrive * 0x100 + -0x8000;

  if (AIWorld_IsDriveableLane(copSlice,6 - (BWorldSm_slices[copSlice].laneCount >> 4)) == 0) {
    leftPos = leftPos + -0x20000; }
  if (AIWorld_IsDriveableLane(copSlice,(BWorldSm_slices[copSlice].laneCount & 0xf) + 7) == 0) {
    rightPos = rightPos + -0x20000; }

  if (this->copIndex_ == 0) { if (AITune_driveSide == 1) goto LAB_8005d8a0; goto LAB_8005d8b8; } if (AITune_driveSide != -1) goto LAB_8005d8b8; LAB_8005d8a0: AILife_PlaceCarAtLocation(this->carObj_,copSlice,rightPos,direction,0,





             direction * 0x100 + 0x200); goto LAB_8005d8d8; LAB_8005d8b8: AILife_PlaceCarAtLocation(this->carObj_,copSlice,-leftPos,direction,0,






             0x200 - direction * 0x100); LAB_8005d8d8: ; }


  if (AIHigh_CopGameType == COP_GAME_BTC_1HC1HP) {
    nextStageTime = AIH_BTC_Cop_1HC1HP_StageTimes[this->currentStage_] << 5; } else {

    nextStageTime = GameSetup_gData[this->currentStage_][116] /* perpInfo[this->currentStage_].TimeLimit */ << 5; }
  if (nextStageTime < 0) {
    nextStageTime = 0; }



  nextStageTime = (nextStageTime * this->stageTimeMultiplier_) / 0x10000;

  if (this->copIndex_ == 0) {
    Hud_BTC_BonusTime(nextStageTime << 1); }

  this->timeLeft_ = this->timeLeft_ + nextStageTime;






  this->needPerp_ = 1;


  this->chaseStartTime_ = 0;


  this->wingmanStatus_ = 0;

  this->freezeMode_ = 1;






  TrgSfx_RestartTrgSfx(); return;
}
/* SYM (retail): fn-scope locals are nextStageTime plus the AUTOs newLatPos/throwAway (the lane search
     writes throwAway first); rightPos/leftPos are block-scoped in the third arm.  The accessor pairs
     (spike belt SetActive, SetInitialDirection/SetInitialMovement) and the plain ternary MINs are
     byte-exact without the earlier laneBits/leftWidth/limitR/limitL carrier locals. */
/* W57-A11: the oracle sets up the AILife_PlaceCarAtLocation ARGS inside EACH arm
     (per-arm `lw a2,0x1C(sp)` + `sw ..,0x10/0x14(sp)` stack args, SLD 542/551) and only
     cross-jump-merges the `lw a0; jal; addu a3` triple at .L8005D8CC -- the single shared
     call + goto form hoisted the last two args into callee-saved regs and lost 7 insns. */
/* W57-A11: SYM 8c -- this arm's REAL locals are BLOCK-SCOPED `rightPos` ($11=s1) and
     `leftPos` ($10=s0); iVar3/uVar4/the IsDriveableLane results are anonymous temps. */
/* W57-A11: retail branches on the POSITIVE test into the shared A block
     (`beq driveSide,1 -> .L8005D8A0` / `bne driveSide,-1 -> .L8005D8B4`) and carries a
     SEPARATE call in each arm (three `addu a1,s3,zero` copSlice setups survive). */
/* W57-A11: the `<< 5` lives in EACH arm (oracle `sll s0,v0,5` twice) -- a shared
       post-if shift makes the load land directly in nextStageTime's reg. */
/* W57-A11: the /0x10000 form keeps retail's SINGLE in-place `sra s0,a0,16`. */








/* ---- UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop  [AIH_BTCCOP.CPP:624-650] ---- */
/* 2026-10-12 MATCH69/69: sayLose is the actual initialized BOOL at8013c564,
 * tested before Lose(), cleared after that call, and rearmed on timeout.
 * Restoring its function-static declaration removes the invented file-global
 * freezeToggle and the unused/discarded-BSS placeholder. Native STAT BOOL
 * value4 matches retail, and all33 common TU functions/10840 linked raw bytes
 * plus both8 initialized sdata bytes are retail-identical. Three unlinked
 * GPREL16 addends change0->4 when the relocation names the local .sdata base;
 * the ignored byte reference was archived and refreshed only after this
 * independent link proof (build/nc12/ref_archive_sayLose). No compiled code/
 * data is rewritten and no fixture change excuses a linked-byte difference.
 * 2026-10-12 native+SLD EXACT69 words: all instruction tags, block lines and
 * end26/26 match. The unbraced single-call HUD arms and ordinary Allman-style
 * conditional blocks recover the statement groups; the source separator
 * between the independent speech-latch and endgame phases matches retail's
 * untagged gap. Historical comments/blank runs were removed from the body,
 * not replaced by fake statements, line directives or arbitrary filler.
 * SOURCE-REVIEW: matching this complete covered contract does not uniquely
 * certify the original literal spelling/comments or the rest of the project. */


#line 623 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::UpdateAndCheckTimeLeft()
{
  static bool sayLose = true;

  if ((this->freezeMode_ != 3) && (this->freezeMode_ != 1))
  {
    this->timeLeft_ = this->timeLeft_ - AI_elapsedTime;
  }

  if (this->perpTarget_ != (AIHigh_BTC_Perp *)0x0)
    Hud_BTC_Update(AIHigh_GetCarObj(this->perpTarget_)->carInfo->driver,this->timeLeft_,(void *)(u_int)((this->carObj_)->RSControl == 0));
  else
    Hud_BTC_Update((char *)0x0,0,(void *)(u_int)((this->carObj_)->RSControl == 0));

  if (this->timeLeft_ < 0)
  {
    if (sayLose != 0)
    {
      Speech::Mobile(this->carObj_)->Lose();
      sayLose = false;
    }

    if (this->timeLeft_ < -0xa0)
    {
      sayLose = true;
      simVar.endSimGame = 1;
      this->HudOn(this->perpTarget_,1,
                  this->carObj_);
    }
  }
}








/* ---- UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::UpdateFreezeModeAndPullOverMode  [AIH_BTCCOP.CPP:692-722] SLD-VERIFIED ---- */

#line 687 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::UpdateFreezeModeAndPullOverMode()




{

  if (this->timeLeft_ < 0)
  {
    this->carObj_->RSControl = this->carObj_->direction;

    AIInit_forceHumanHandBrake = 1; this->SetRequestedDesiredSpeed(0); }

  else if (this->freezeMode_ == 3)
  {
    this->carObj_->RSControl = 0;
    this->carObj_->pullOver = 1;
    this->SetRequestedDesiredSpeed(0); }


  else if (this->freezeMode_ == 1)
  {
    this->carObj_->AIFlags = this->carObj_->AIFlags & 0xfffffffd;
    this->carObj_->RSControl = this->InitialDirection();
    this->carObj_->pullOver = (u_int)(this->InitialMovement() == 0);
    if (this->carObj_->pullOver != 0)
      this->SetRequestedDesiredSpeed(0); } else


  {
    if (this->carObj_->pullOver == 1 || this->carObj_->RSControl != 0)
      this->carObj_->AIFlags = this->carObj_->AIFlags | 2; this->SetRequestedDesiredSpeed(0);

    this->freezeMode_ = 0;
    this->carObj_->RSControl = 0;
    this->carObj_->pullOver = 0; } }








/* ---- RequestWingman__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::RequestWingman  [AIH_BTCCOP.CPP:727-749] SLD-VERIFIED ---- */

#line 722 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::RequestWingman()




{ int wingmanActivationTime;
  if (1 < (u_int)(this->freezeMode_ - 3)) { wingmanActivationTime = GameSetup_gData[this->currentStage_][117] /* perpInfo[this->currentStage_].WingmanTime */ * 0x40 +


            AITune_BTC[GameSetup_gData[0][2] /* skill */].wingmanTime;


    Speech::Mobile(this->carObj_)->Backup();

    if (this->chaseStartTime_ == 0) goto LAB_dispatch; if (wingmanActivationTime == 0) goto LAB_dispatch; if (simGlobal.gameTicks - this->chaseStartTime_ <= wingmanActivationTime) goto LAB_dispatch; if (this->wingmanStatus_ != 4) { this->wingmanStatus_ = 1;



      goto LAB_end; } LAB_dispatch:



    Speech::Dispatch()->Deny(); LAB_end: ; } return;




}








/* ---- RequestBlockader__19AIHigh_BTC_HumanCopi  AIHigh_BTC_HumanCop::RequestBlockader  [AIH_BTCCOP.CPP:752-781] SLD-VERIFIED ---- */

#line 747 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::RequestBlockader(int spikeBeltRequest)




{ int availableTime;


  if (1 < (u_int)(this->freezeMode_ - 3)) {

    if (spikeBeltRequest != 0) {

      Speech::Mobile(this->carObj_)->SpikeBelt(); availableTime = GameSetup_gData[this->currentStage_][118] /* perpInfo[this->currentStage_].SpikeBeltTime */ * 0x40 +
                      AITune_BTC[GameSetup_gData[0][2] /* skill */].spikeBeltTime; } else {



      Speech::Mobile(this->carObj_)->RoadBlock(); availableTime = GameSetup_gData[this->currentStage_][119] /* perpInfo[this->currentStage_].BlockadeCopTime */ * 0x40 +
                      AITune_BTC[GameSetup_gData[0][2] /* skill */].blockaderTime; }


    if (this->chaseStartTime_ == 0) goto LAB_dispatch; if (availableTime < 1) goto LAB_dispatch; if (simGlobal.gameTicks - this->chaseStartTime_ <= availableTime) goto LAB_dispatch; if (this->wingmanStatus_ != 5) {

      Speech::Dispatch()->Grant();




      if (spikeBeltRequest != 0) { this->wingmanStatus_ = 3; } else { this->wingmanStatus_ = 2; } goto LAB_end; } LAB_dispatch:



    Speech::Dispatch()->Deny(); LAB_end: ; } return;

}








/* ---- CheckForWingmanRequest__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::CheckForWingmanRequest  [AIH_BTCCOP.CPP:785-790] SLD-VERIFIED ---- */

#line 780 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
int AIHigh_BTC_HumanCop::CheckForWingmanRequest()




{
  if (this->wingmanStatus_ != 1) {
    return 0;
  }
  this->wingmanStatus_ = 4;
  return 1;
}








/* ---- CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi  AIHigh_BTC_HumanCop::CheckForBlockaderRequest  [AIH_BTCCOP.CPP:794-808] SLD-VERIFIED ---- */

#line 789 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
int AIHigh_BTC_HumanCop::CheckForBlockaderRequest(int *spikeBeltRequest)




{
  *spikeBeltRequest = 0;


  if ((u_int)(this->wingmanStatus_ - 2) < 2) {


    if (this->wingmanStatus_ == 3)
      *spikeBeltRequest = 1;
    this->wingmanStatus_ = 5;
    return 1;

  }

  return 0;

}








/* ---- UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role  AIHigh_BTC_HumanCop::UpdateWingmanRole  [AIH_BTCCOP.CPP:812-821] SLD-VERIFIED ---- */

#line 807 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::UpdateWingmanRole(Wingman_Role currentRole)




{
  switch ((int)currentRole) {
  case 0:

    this->wingmanStatus_ = 0;
    return;
  case 1:

    this->wingmanStatus_ = 4;
    return;
  case 2: case 3:
    this->wingmanStatus_ = 5;
    return;
  default:
    return; } }








/* ---- ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::ClearTrafficToPurgatory  [AIH_BTCCOP.CPP:832-838] SLD-VERIFIED ---- */

#line 827 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::ClearTrafficToPurgatory()




{
  for (int trafficLoop = 0; trafficLoop < Cars_gNumTrafficCars; trafficLoop++) {

    Car_tObj *testTrafficCarObj = Cars_gTrafficCarList[trafficLoop];
    AIHigh_Traffic *testTrafficHigh = (AIHigh_Traffic *)highLevelAIObjs[testTrafficCarObj->carIndex];
    testTrafficHigh->SetForcePurgatory(1);
  }
}








/* ---- ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::ResetClearTrafficToPurgatory  [AIH_BTCCOP.CPP:842-848] SLD-VERIFIED ---- */

#line 837 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::ResetClearTrafficToPurgatory()




{
  for (int trafficLoop = 0; trafficLoop < Cars_gNumTrafficCars; trafficLoop++) {

    Car_tObj *testTrafficCarObj = Cars_gTrafficCarList[trafficLoop];
    AIHigh_Traffic *testTrafficHigh = (AIHigh_Traffic *)highLevelAIObjs[testTrafficCarObj->carIndex];
    testTrafficHigh->SetForcePurgatory(0);
  }
}








/* ---- SetDesiredSpeed__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::SetDesiredSpeed  [AIH_BTCCOP.CPP:854-858] SLD-VERIFIED ---- */

#line 849 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::SetDesiredSpeed()




{
  if (this->carObj_->RSControl != 0)
  {
    int curveSpeed = AISpeeds_CalcHumanTopSpeed(this->carObj_);
    this->carObj_->desiredSpeed = this->RequestedDesiredSpeed() < curveSpeed ? this->RequestedDesiredSpeed() : curveSpeed;
  } }








/* ---- HighExecute__19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanCop::HighExecute  [AIH_BTCCOP.CPP:863-931] SLD-VERIFIED ---- */

#line 858 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_HumanCop::HighExecute()




{ if ((this->copIndex_ == 0) &&


     (this->freezeMode_ == 1)) {
    this->ClearTrafficToPurgatory(); }


  if ((this->perpTarget_ != (AIHigh_BTC_Perp *)0x0) && (this->freezeMode_ != 1))
  {









    (this->carObj_)->desiredDirection = AIHigh_GetCarObj(this->perpTarget_)->direction; }




  this->SetDesiredSpeed();
  this->CheckConditionWithCop0();
  this->UpdateFreezeModeAndPullOverMode();
  this->UpdateAndCheckTimeLeft();
  this->CheckForNewTarget();
  if (this->perpTarget_ != (AIHigh_BTC_Perp *)0x0)
  { coorddef notUsed;

    this->GetCheckChasePosition(&notUsed); }

  if (AIHigh_CopGameType == COP_GAME_BTC_1HC) {

    if (0x281 <= simGlobal.gameTicks - lastInputRequestTick_) { if (((this->carObj_)->control).queuedEvent ==


          '\x04') {


        this->RequestWingman();
        ((this->carObj_)->control).queuedEvent = '\0';
        lastInputRequestTick_ = simGlobal.gameTicks; } if (((this->carObj_)->control).queuedEvent ==

          '\x05') {

        this->RequestBlockader(0);
        ((this->carObj_)->control).queuedEvent = '\0';
        lastInputRequestTick_ = simGlobal.gameTicks; } if (((this->carObj_)->control).queuedEvent ==

          '\x06') {

        this->RequestBlockader(1);
        ((this->carObj_)->control).queuedEvent = '\0';
        lastInputRequestTick_ = simGlobal.gameTicks; } } else {






      if ((u_int)(u_char)(this->carObj_->control).queuedEvent - 4 < 3) {
        (this->carObj_->control).queuedEvent = '\0'; } } }




  (this->state_)->StateExecute(); return; }








/* ---- HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj  AIHigh_BTC_HumanCop::HudOn  [AIH_BTCCOP.CPP:938-947] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanCop::HudOn(AIHigh_BTC_Perp *arrestMe,int gameOver,

#line 933 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
               Car_tObj *arrestingCop)




{
  Car_tObj *arrestingHumanCop = arrestingCop;



  if ((arrestingCop->carFlags & 2U) != 0)
    arrestingHumanCop = Cars_gHumanRaceCarList[0];

  if (this->copIndex_ == 0 || gameOver != 0)
    Hud_BustedOverlayOn(simGlobal.gameTicks - this->chaseStartTime_,arrestMe->CarObj()->carInfo->driver,(void *)(u_int)(gameOver == 0),(short)arrestingHumanCop->carIndex);
}








/* ---- __18AIHigh_BTC_WingmanP8Car_tObji  AIHigh_BTC_Wingman::ctor  [AIH_BTCCOP.CPP:964-971] SLD-VERIFIED ---- */

#line 964 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
AIHigh_BTC_Wingman::AIHigh_BTC_Wingman(Car_tObj *carObj,int copIndex) : AIHigh_BTC_Cop(carObj,copIndex)
{
  this->spikeBeltPlaced_ = 0;
  this->spikeBeltSlice_ = 0;
  this->spikeBeltInterceptReleaseTime_ = 0;
  this->currentRole_ = 0;
  this->newRole_ = 0;
  this->newHumanBoss_ = (AIHigh_BTC_HumanCop *)0x0;
}








/* ---- HighExecute__18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::HighExecute  [AIH_BTCCOP.CPP:976-1266] SLD-VERIFIED ---- */

#line 975 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Wingman::HighExecute()
{



  ((AIHigh_BasicCop *)this)->CheckSpikeBelt();
  this->CheckForActivation();



  switch (this->stateType_)
  {
    case 0:
    {
      this->carObj_->AIFlags &= ~2;
      this->SetState(new AIState_NonActive(this->carObj_),(stateType_t)7); }



    break; case 2:

    {
      this->carObj_->AIFlags &= ~2; if ((this->newRole_ != this->currentRole_) &&
          ((u_int)(this->newRole_ - 2) < 2))
      {
        if (AILife_IsCarInAnyVisibleArea(this->carObj_) == 0)
        {

          Speech::Mobile(this->carObj_)->Purge();
          this->currentRole_ = this->newRole_;
          this->SetupBlockader(this->newHumanBoss_,this->newRole_ == 3);
          this->SetState(new AIState_Idle(this->carObj_,1),(stateType_t)3);
          (void)0; } } else



      {
        this->CheckForNewTarget();
        if (this->perpTarget_ != 0)
        { coorddef pos;



          this->GetCheckChasePosition(&pos); this->SetState(new AIState_Chase(this->carObj_,this->perpTarget_->CarObj(),&pos,


                                           0x200,0x3c0000,0x190000,2,0x10000),(stateType_t)4);
          (void)0; } }


      if (this->UpdateFreezeModeAndPullOverMode() != 0)
      {
        this->AssignToPlayer(0);
        this->SetState(new AIState_NonActive(this->carObj_),(stateType_t)7); this->newRole_ = 0; this->currentRole_ = 0; } }









    break;

    case 4:
    { coorddef newPos; AIState_Chase *chaseState;

      chaseState = (AIState_Chase *)this->state_;
      this->carObj_->AIFlags |= 2;


      ((AIHigh_BasicCop *)this)->HandleBlockadeSpeech();


      if (this->GetCheckChasePosition(&newPos) != 0)
      {
        chaseState->SetTarget(this->perpTarget_->CarObj(),&newPos); }



      if (chaseState->BarrierTicks32() > 0xa0)
      {
        int endSlice = chaseState->FindBarrierEndSlice();

        this->SetState(new AIState_GotoSlice(this->carObj_,endSlice,0),(stateType_t)9);
        (void)0; }



      if (this->CheckForNewTarget() != 0)
      { coorddef pos;

        this->GetCheckChasePosition(&pos);
        chaseState->SetTarget(this->perpTarget_->CarObj(),&pos); }


      if (chaseState->InMurderRange(8,0xe0000,


                                    0xf0000)) {

        chaseState->SetMurderMode(1,0x300); }



      if (this->perpTarget_ == 0)
      {

        this->AssignToPlayer(0);
        this->SetState(new AIState_Normal(this->carObj_),(stateType_t)2);
        (void)0; }


      if (this->newRole_ != this->currentRole_)
      {


        if ((u_int)(this->newRole_ - 2) < 2)
        {

          this->carObj_->desiredDirection = -this->carObj_->desiredDirection;
          this->AssignToPlayer(0);
          this->SetState(new AIState_Normal(this->carObj_),(stateType_t)2);

          Speech::Mobile(this->carObj_)->Lose(); } }



      if (this->UpdateFreezeModeAndPullOverMode() != 0)
      {
        this->AssignToPlayer(0);
        this->SetState(new AIState_NonActive(this->carObj_),(stateType_t)7); this->newRole_ = 0; this->currentRole_ = 0; } }








    break;

    case 3:
    { int rbDistanceMeters; int rbAbsDistanceMeters; int release; coorddef newPos;


      release = 0;


      this->carObj_->AIFlags |= 2;

      this->CheckForNewTarget();


      if (this->perpTarget_ == 0)
      {
        this->newRole_ = 1; this->currentRole_ = 1;



        this->SetState(new AIState_Normal(this->carObj_),(stateType_t)2);

        return; }





      this->GetCheckChasePosition(&newPos); if ((this->spikeBeltPlaced_ != 0) &&


          (SpikeBelt_Slice() == this->spikeBeltSlice_))
      {
        SpikeBelt_SetFreshenTime(simGlobal.gameTicks); }




      rbDistanceMeters = AIWorld_ApxSplineDistance(this->carObj_,this->perpTarget_->CarObj());
      rbAbsDistanceMeters = __builtin_abs(rbDistanceMeters);



      if (rbAbsDistanceMeters < 0x320000) { release = 1; } else



      if (rbAbsDistanceMeters < 0x12c0000 && (this->perpTarget_->CarObj()->currentSpeed > 0 ? this->perpTarget_->CarObj()->currentSpeed : -this->perpTarget_->CarObj()->currentSpeed) > 0x471c7)
      {


        int timeToRB = fixeddiv(rbDistanceMeters,this->perpTarget_->CarObj()->currentSpeed);
        if (timeToRB > 0 && timeToRB < this->spikeBeltInterceptReleaseTime_) {

          release = 1; } }







      if (release)
      {

        this->spikeBeltPlaced_ = 0;




        this->newRole_ = 1; this->currentRole_ = 1; this->SetState(new AIState_Chase(this->carObj_,this->perpTarget_->CarObj(),&newPos,





                                         0x200,0x3c0000,0x190000,2,0x10000),(stateType_t)4);
        (void)0; }



      if ((this->newRole_ != this->currentRole_) && (this->newRole_ == 1))
      {

        this->currentRole_ = 1;
        this->SetState(new AIState_Normal(this->carObj_),(stateType_t)2);
        (void)0; }



      if (this->UpdateFreezeModeAndPullOverMode() != 0)
      {
        this->AssignToPlayer(0);
        this->SetState(new AIState_NonActive(this->carObj_),(stateType_t)7);

        this->newRole_ = 0; this->currentRole_ = 0; } }







    break;
    case 7:



    {
      this->carObj_->AIFlags &= ~2;
      if (this->currentRole_ != this->newRole_)
      {
        if (this->newRole_ == 1)
        {

          this->currentRole_ = 1;
          this->SetupWingman(this->newHumanBoss_);
          this->SetState(new AIState_Normal(this->carObj_),(stateType_t)2);
          (void)0; } else

        { if ((u_int)(this->newRole_ - 2) < 2)
          {

            this->currentRole_ = this->newRole_;
            this->SetupBlockader(this->newHumanBoss_,this->newRole_ == 3);
            this->SetState(new AIState_Idle(this->carObj_,1),(stateType_t)3); } } } }






    break;
    case 9:

    { AIState_GotoSlice *gotoState;
      gotoState = (AIState_GotoSlice *)this->state_;
      this->AssignToPlayer(0);
      if (gotoState->InTargetSliceRange(0xa0000) != 0)
      {
        this->SetState(new AIState_Normal(this->carObj_),(stateType_t)2);
        (void)0; } } break;


    case 10: default: break; }




  this->state_->StateExecute();
}








/* ---- CheckForActivation__18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::CheckForActivation  [AIH_BTCCOP.CPP:1270-1305] SLD-VERIFIED ---- */

#line 1265 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
int AIHigh_BTC_Wingman::CheckForActivation()




{ int spikeBeltRequest;

  spikeBeltRequest = 0;



  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop++) { Car_tObj *otherCarObj;

    otherCarObj = Cars_gList[carLoop];
    if (((otherCarObj->carFlags & 0x200U) != 0) && ((otherCarObj->N).active != '\0'))
    { AIHigh_BTC_HumanCop *copHigh;
      copHigh = (AIHigh_BTC_HumanCop *)highLevelAIObjs[otherCarObj->carIndex];

      if ((copHigh)->CheckForWingmanRequest() != 0) {

        this->newRole_ = 1;
        this->newHumanBoss_ = copHigh; }



      if ((copHigh)->CheckForBlockaderRequest(&spikeBeltRequest) != 0) { this->newRole_ = spikeBeltRequest != 0 ?

            ROLE_BLOCKADER_SPIKEBELT : ROLE_BLOCKADER;
        this->newHumanBoss_ = copHigh; }
      (void)0; } /* DEVICE (exact-only): code-less note on the `}` line -> retail block ends 25 */


  }

  if (this->newHumanBoss_ != (AIHigh_BTC_HumanCop *)0x0) {
    (this->newHumanBoss_)->UpdateWingmanRole((Wingman_Role)this->currentRole_); }

  if (this->currentRole_ != this->newRole_)
    return 1;

  return 0; }





/* ---- UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman  AIHigh_BTC_Wingman::UpdateFreezeModeAndPullOverMode  [AIH_BTCCOP.CPP:1311-1329] SLD-FLAG:NONMONO ---- */

#line 1306 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
int AIHigh_BTC_Wingman::UpdateFreezeModeAndPullOverMode()




{

  if (this->freezeMode_ == 3) {

    this->carObj_->pullOver = 1;
    return 0;
  }
  else {
    int result;


    this->carObj_->pullOver = 0;

    result = this->freezeMode_ == 4;


    this->freezeMode_ = 0;

    return result;
  } }








/* ---- SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop  [AIH_BTCCOP.CPP:1334-1346] ---- */
/* 2026-10-12 MATCH79/79: directly widen the actual multiply then narrow its
 * result to int, eliminating sideTimes28. Both signs are assigned +/-1, so
 * every reachable product is +/-28 with no overflow/truncation difference.
 * Ordinary direct multiplication is six register differences at79 words;
 * the widened form preserves side/perpSide's retail homes and all native
 * local/scope records without another object or fence. Its literal original
 * cast/expression spelling and full SLD are not uniquely proved by PASS. */

#line 1329 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Wingman::SetupWingman(AIHigh_BTC_HumanCop *humanCop)




{ Car_tObj *otherCarObj; int side; int perpSide; otherCarObj = AIHigh_GetCarObj(humanCop); side = -1;


  if (-1 < otherCarObj->currentSpeed) { side = 1; }
  randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; perpSide = -1; if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 < 500) { perpSide = 1; }






  perpSide = (int)((long long)perpSide * (side * 0x1c)); if (perpSide >= 0) { perpSide = (otherCarObj->N).simRoadInfo.slice - -perpSide; if (gNumSlices <= perpSide) { perpSide = perpSide - gNumSlices; } } else { perpSide = (otherCarObj->N).simRoadInfo.slice - -perpSide; if (perpSide < 0) { perpSide = perpSide + gNumSlices; } } AILife_PlaceCarAtLocation(this->carObj_,perpSide,0,side, otherCarObj->currentSpeed,0);
  Speech::Dispatch()->Ready(this->carObj_); return; }








/* ---- SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi  AIHigh_BTC_Wingman::SetupBlockader  [AIH_BTCCOP.CPP:1352-1484] SLD-VERIFIED ---- */

#line 1347 "C:/nfs4/GAME/COMMON/AIH_BTCCOP.CPP"
void AIHigh_BTC_Wingman::SetupBlockader(AIHigh_BTC_HumanCop *humanCop,int spikeBeltRequest)




{ int initSlice; Car_tObj*copObj; int blockadeType; copObj = humanCop->CarObj();














  if (humanCop->PerpTarget() != (AIHigh_BTC_Perp *)0x0)
  { int perpToHumanDistance; int side; int initializationDistance; Car_tObj*perpObj; perpObj = humanCop->PerpTarget()->CarObj();








    if (-1 < perpObj->currentSpeed)
      side = 1;
    else
      side = -1;


    perpToHumanDistance = AIWorld_ApxSplineDistance(perpObj,copObj);





    initializationDistance = 0x1f40000; if (initializationDistance < __builtin_abs(perpToHumanDistance)) { initializationDistance = __builtin_abs(perpToHumanDistance); } int maximumDistance = 0x5dc0000; initializationDistance = (initializationDistance < maximumDistance) ?
        initializationDistance : maximumDistance;

    if (perpToHumanDistance * side < 0) {





      initSlice = SLICE_ADD(copObj->N.simRoadInfo.slice, (initializationDistance / 0x60000) * side); } else {







      initSlice = SLICE_ADD(perpObj->N.simRoadInfo.slice, (initializationDistance / 0x60000) * side); }


    this->blockade_.blockadeSpeechFlags = 1;




    this->blockade_.target = (AIHigh_Player *)humanCop->PerpTarget(); } else


    {

      int side = -1; if (-1 < humanCop->CarObj()->currentSpeed)
      side = 1;

      else side = -1; /* DEVICE (exact-only): redundant else store; cse drops it, its code-less note is the retail if-scope end (71) */ int initializationDistance = 0x1f40000;
    initSlice = SLICE_ADD(humanCop->CarObj()->N.simRoadInfo.slice, initializationDistance / 0x60000 * side);

    this->blockade_.blockadeSpeechFlags = 0;
    this->blockade_.target = (AIHigh_Player *)0x0; }


  this->blockade_.direction = copObj->direction;
  this->blockade_.slice = SLICE_ADD(initSlice, -this->blockade_.direction);

  AICop_gRoadBlockState = kAICop_RoadBlockState_WaitingForPerp;

  randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; blockadeType = (randtemp >> 8 & 0xffff) % 5;

  this->blockade_.flags = gBlockadeTypes[blockadeType];

  if (this->blockade_.flags != 0) {

    if (stackSpeedUpEnbabledFlag != 0) {

      gWSavePtr = (u_long)SetSp((void *)gWSavePtr); stackSpeedUpEnbabledFlag = 0;

      ((AIHigh_BasicCop *)this)->SetupBlockadeElements(&this->blockade_);
      gWSavePtr = (u_long)SetSp((void *)gWSavePtr); stackSpeedUpEnbabledFlag = 1; } else {

      ((AIHigh_BasicCop *)this)->SetupBlockadeElements(&this->blockade_); } } AILife_ReencarnateCopByLatPosAndRotation(this->carObj_,initSlice,








             humanCop->CarObj()->direction,0,0x100);


  if (spikeBeltRequest != 0)
  { int spikeBeltSide; int left; int right;



    if (AIWorld_ApxSplineDistance(this->carObj_,copObj) >= 0)
      spikeBeltSide = 1;
    else spikeBeltSide = -1;


    spikeBeltSide = spikeBeltSide * 6; this->spikeBeltSlice_ = SLICE_ADD(this->carObj_->N.simRoadInfo.slice, spikeBeltSide);
    randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; this->spikeBeltInterceptReleaseTime_ = ((randtemp >> 8 & 0xffff) * 0x14ccd >> 0x10) + 0xd999; left = fixedmult(((u_int)BWorldSm_slices[this->spikeBeltSlice_].avgPavedWidthLf << 15) * (BWorldSm_slices[this->spikeBeltSlice_].laneCount >> 4)


                       ,0xcccc); right = fixedmult(((u_int)BWorldSm_slices[this->spikeBeltSlice_].avgPavedWidthRt << 15) * (BWorldSm_slices[this->spikeBeltSlice_].laneCount & 0xf),0xcccc)
    ;

    SpikeBelt_Set(this->spikeBeltSlice_, -left, right);
    SpikeBelt_Freshen(simGlobal.gameTicks); BWorld_SetSpikeBelt(this->spikeBeltSlice_,AICop_spikeBelt.leftLatPos_,

               left + right);

    this->spikeBeltPlaced_ = 1; }


  Speech::Dispatch()->Ready(this->carObj_); return; }























/* EOF source layout is significant for synthesized destructor metadata. */
