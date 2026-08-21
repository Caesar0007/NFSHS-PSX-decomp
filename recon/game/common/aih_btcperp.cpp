/* game/common/aih_btcperp.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_btcperp_externs.h"

extern int AI_elapsedTime;   /* H21: ai.cpp @0x8013C554 (not in this TU's externs) */

#define WRAP_SLICE(a,b) (((a) >= 0) \
    ? ((((b) + (a)) >= gNumSlices) ? ((b) + (a)) - gNumSlices : ((b) + (a))) \
    : ((((b) + (a)) < 0) ? ((b) + (a)) + gNumSlices : ((b) + (a))))

struct SpeakerVirtualDispatch {
  char data[76];
  virtual int slot0(Car_tObj *carObj);
  virtual int slot1();
  virtual int slot2();
  virtual int slot3();
  virtual int slot4();
  virtual int slot5(Car_tObj *carObj);
  virtual int slot6();
  virtual int slot7();
  virtual int slot8();
  virtual int slot9();
  virtual int slot10();
  virtual int slot11();
  virtual int slot12();
  virtual int slot13();
  virtual int slot14();
  virtual int slot15();
};

/* ---- aistate.obj-owned globals (.bss zero) ---- */
u_char       strategyChart[5][3] = { 4u, 4u, 4u, 0, 0, 0, 1u, 0, 1u, 1u, 1u, 1u, 2u, 2u, 2u };   /* @0x8010ce7c */
int          AIHigh_BTC_uTurnProb1000Skills[3] = { 3, 4, 5 };   /* @0x8010ce8c */


/* ---- ReleaseCops__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::ReleaseCops  [AIH_BTCPERP.CPP:63-75] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::ReleaseCops()



{
  int carLoop;

  Car_tObj *otherCarObj;

  Car_tObj **ppCVar2;



  carLoop = 0;
  while (true) {

    if (Cars_gNumCars <= carLoop) {
      break;
    }

    otherCarObj = Cars_gList[carLoop];

    if (((otherCarObj->carFlags & 0x200U) != 0) && ((otherCarObj->N).active != '\0')) {

      ((AIHigh_BTC_HumanCop *)highLevelAIObjs[otherCarObj->carIndex])->ReleaseAndStartChase(this);

    }

    carLoop = carLoop + 1;

  }

  (this->carObj_)->forceNoSimOptz = 0;

  return;

}








/* ---- HandleCops__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::HandleCops  [AIH_BTCPERP.CPP:82-86] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::HandleCops()



{

  this->HandlePullOver();

  return;

}








/* ---- IsFalseArrest__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::IsFalseArrest  [AIH_BTCPERP.CPP:93-126] SLD-VERIFIED ---- */

int AIHigh_BTC_Perp::IsFalseArrest()



{
  /* SYM whole-function rewrite (w22-a13): SYM @0x8005f798 names ONLY randNum1000(REG v0),
   * carLoop(REG s5), cop(REG a1), xDot(REG s2), zDot(REG s1), and carCopVector (AUTO
   * coorddef, sp+0x10/14/18) -- NO iVar1..iVar5/delta[3] temps exist in the real source.
   * xDot uses incremental accumulation while zDot remains one expression: this gives the
   * closest allocator shape found (6 detailed diffs, down from 11). Per-term iVarN temps
   * still force a substantially worse combine-afterward shape.
   * w54-a12 SEALED (6 -> PASS 136/136). Three receipts, all needed (each removal re-fails):
   *  (1) xDot's 2nd/3rd terms are NAMED temps (dotTerm/dotTerm2) issued BEFORE the two
   *      accumulate statements, so the term-2 value is live across the term-3 call ->
   *      retail's `addu s0,v0,zero` copy into a callee-saved reg lands in that jal's
   *      delay slot and `addu s2,s2,s0` sits AFTER the call.
   *  (2) a VOID FENCE (`__asm__("" : : "i"(0))`, 0 insns, implicitly volatile = scheduling
   *      barrier -- catalog 05H/w48-a1) before the two `xDot +=` statements pins them
   *      below the term-3 call; without it sched1/reorg hoists `xDot += dotTerm` into the
   *      call's delay slot and we come out 1 insn short.
   *  (3) two more void fences at the HEADS of the `if (xDot < 0)` test and of the join
   *      block after it -- they defeat reorg's eager-steal into the `bgez`/`negu` delay
   *      slots (retail leaves `nop` there). Do NOT "simplify" these away. */
  int randNum1000;

  int carLoop;

  Car_tObj *cop;

  Car_tObj **ppCVar7;

  int xDot;

  int zDot;

  int dotTerm;

  int dotTerm2;

  coorddef carCopVector;



  randtemp = fastRandom * randSeed;

  fastRandom = randtemp & 0xffff;

  randNum1000 = (randtemp >> 8 & 0xffff) * 1000 >> 0x10;

  if ((((this->carObj_)->carFlags & 4U) == 0) &&

     (0x3d3 < randNum1000)) {

    carLoop = 0;
    ppCVar7 = Cars_gList;
    while (true) {

      if (Cars_gNumCars <= carLoop) {
        break;
      }

      cop = *ppCVar7;

      if ((cop->carFlags & 0x200U) != 0) {

        carCopVector.x = (cop->N).position.x - ((this->carObj_)->N).position.x;

        carCopVector.y = (cop->N).position.y -

                ((this->carObj_)->N).position.y;

        carCopVector.z = (cop->N).position.z -

                ((this->carObj_)->N).position.z;

        xDot = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[0]);

        dotTerm = fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[1]);

        dotTerm2 = fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[2]);

        __asm__("" : : "i"(0));

        xDot += dotTerm;

        xDot += dotTerm2;

        zDot = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[6]) +

               fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[7]) +

               fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[8]);

        __asm__("" : : "i"(0));

        if (xDot < 0) {

          xDot = -xDot;

        }

        __asm__("" : : "i"(0));

        if (((0x30000 < xDot) || (0x80000 < zDot)) || (zDot < 0)) {

          AudioClc_HonkHorn(this->carObj_,2,0x80,0x20);

          return 1;

        }

      }

      ppCVar7 = ppCVar7 + 1;

      carLoop = carLoop + 1;

    }

  }

  return 0;

}








/* ---- CheckForControlsPressed__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::CheckForControlsPressed  [AIH_BTCPERP.CPP:130-147] SLD-VERIFIED ---- */

int AIHigh_BTC_Perp::CheckForControlsPressed()



{
  int pressed;



  pressed = 0;

  if (((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0) {
    Car_tControl *control = &Cars_gHumanRaceCarList[0]->control;
    if (*(u_short *)control != 0 || control->handBrake == '\x01') {

      pressed = 1;

    }
  }

  /* H20: player-2 check must read Cars_gHumanRaceCarList[1] (oracle 0x8005FA10 base 0x8010FA4C = list+4), not [0] */
  if ((Cars_gNumHumanRaceCars == 2) &&
      (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)) {
    Car_tControl *control = &Cars_gHumanRaceCarList[1]->control;
    if (*(u_short *)control != 0 || control->handBrake == '\x01') {

      pressed = 1;

    }
  }

  return pressed;

}








/* ---- HandlePullOver__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::HandlePullOver  [AIH_BTCPERP.CPP:153-222] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::HandlePullOver()



{
  int userReadyToContinue;

  bool bVar1;

  int iVar2;

  Speaker *pSVar3;

  

  if (this->pullOverMode_ != 0) {

    this->NotifyCopsOfArrest();

    this->beatingTicksLeft_ -= AI_elapsedTime;   /* H21: oracle 0x8005FA94 v0=beatingTicksLeft_-AI_elapsedTime, 0x8005FA9C store */

    iVar2 = this->beatingTicksLeft_;

    if ((iVar2 < 1) && (this->hudActivated_ == 0)) {

      iVar2 = this->IsFalseArrest();

      if (iVar2 != 0) {

        this->lastPullOverTime_ = simGlobal.gameTicks + -0x280;

        this->NotifyCopsOfFalseArrest();

        (this->carObj_)->pullOver = 0;

        this->pullOverMode_ = 0;

        pSVar3 = (Speaker *)Speech_Mobile(Cars_gList[0]);

        (**(int (**)(...))((int)*pSVar3->_vf + 0x3c))

                  ((int)&(pSVar3->fPosition).flags + (int)*(short *)((int)*pSVar3->_vf + 0x38));

      }

      else {

        if (this->hudActivated_ == 0) {

          this->NotifyHumanCopsOfArrestHud();

          this->hudActivated_ = 1;

        }

      }

    }

    userReadyToContinue = this->CheckForControlsPressed();

    if ((((this->beatingTicksLeft_ < 1) &&

         (this->pullOverMode_ != 0)) && (userReadyToContinue != 0)) &&

       ((this->hudActivated_ == 1 &&

        (0x140 < simGlobal.gameTicks - this->lastPullOverTime_)))) {

      this->lastPullOverTime_ = simGlobal.gameTicks;

      this->basicPerpInfo_.crime_ = 0;

      this->NotifyCopsOfArrestComplete();

      (this->carObj_)->pullOver = 0;

      this->pullOverMode_ = 0;

      this->caught_ = 1;

      this->hudActivated_ = 0;

    }

  }

  else {

    int cond5 = 5 < this->originalActivationCop_->timeLeft_;  /* MATCH: materialized bool (slti+xori, 2 uses) */
    bVar1 = cond5 && (this->CheckIfCaught() != 0);  /* MATCH: &&-value funnel into a FRESH var — sltu joins in v1, beqz v1, no copy */

    if (bVar1) {

      (this->carObj_)->pullOver = 1;

      this->beatingTicksLeft_ = 0x60;

      iVar2 = simGlobal.gameTicks;

      this->pullOverMode_ = 2;

      this->lastPullOverTime_ = iVar2;

    }

  }

  return;

}








/* ---- NotifyCopsOfArrest__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::NotifyCopsOfArrest  [AIH_BTCPERP.CPP:233-245] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::NotifyCopsOfArrest()



{
  int carLoop;
  Car_tObj*otherCarObj;

  Car_tObj *pCVar1;

  Car_tObj **ppCVar2;

  int iVar3;

  

  iVar3 = 0;
  while (true) {

    if (Cars_gNumCars <= iVar3) {
      break;
    }

    pCVar1 = Cars_gList[iVar3];

    if (((pCVar1->carFlags & 0x220U) != 0) && ((pCVar1->N).active != '\0')) {

      ((AIHigh_BTC_Cop *)highLevelAIObjs[pCVar1->carIndex])->StartArrest(this);

    }

    iVar3 = iVar3 + 1;

  }

  return;

}








/* ---- NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::NotifyCopsOfArrestComplete  [AIH_BTCPERP.CPP:251-266] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::NotifyCopsOfArrestComplete()



{
  int carLoop;
  Car_tObj*otherCarObj;

  Car_tObj *pCVar1;

  Car_tObj **ppCVar2;

  int iVar3;

  

  iVar3 = 0;
  while (true) {

    if (Cars_gNumCars <= iVar3) {
      break;
    }

    pCVar1 = Cars_gList[iVar3];

    if (((pCVar1->carFlags & 0x220U) != 0) && ((pCVar1->N).active != '\0')) {

      ((AIHigh_BTC_Cop *)highLevelAIObjs[pCVar1->carIndex])->FinishArrest(this);

    }

    iVar3 = iVar3 + 1;

  }

  return;

}








/* ---- NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::NotifyCopsOfFalseArrest  [AIH_BTCPERP.CPP:271-283] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::NotifyCopsOfFalseArrest()



{
  int carLoop;
  Car_tObj*otherCarObj;

  Car_tObj *pCVar1;

  Car_tObj **ppCVar2;

  int iVar3;

  

  iVar3 = 0;
  while (true) {

    if (Cars_gNumCars <= iVar3) {
      break;
    }

    pCVar1 = Cars_gList[iVar3];

    if (((pCVar1->carFlags & 0x220U) != 0) && ((pCVar1->N).active != '\0')) {

      ((AIHigh_BTC_Cop *)highLevelAIObjs[pCVar1->carIndex])->FalseArrest(this);

    }

    iVar3 = iVar3 + 1;

  }

  return;

}








/* ---- NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::NotifyHumanCopsOfArrestHud  [AIH_BTCPERP.CPP:288-301] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::NotifyHumanCopsOfArrestHud()



{
  int carLoop;
  Car_tObj*otherCarObj;

  Car_tObj *pCVar1;

  Car_tObj **ppCVar2;

  int iVar3;

  

  iVar3 = 0;
  while (true) {

    if (Cars_gNumCars <= iVar3) {
      break;
    }

    pCVar1 = Cars_gList[iVar3];

    if (((pCVar1->carFlags & 0x200U) != 0) && ((pCVar1->N).active != '\0')) {

      ((AIHigh_BTC_HumanCop *)highLevelAIObjs[pCVar1->carIndex])->HudOn(this,0,

                 this->lastArrestingCop_);

    }

    iVar3 = iVar3 + 1;

  }

  return;

}








/* ---- ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop  AIHigh_BTC_Perp::ClearForNewStage  [AIH_BTCPERP.CPP:304-316] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::ClearForNewStage(AIHigh_BTC_HumanCop *chaserCop)



{

  Car_tObj *pCVar1;

  

  this->Clear();

  pCVar1 = this->carObj_;

  this->basicPerpInfo_.copsAssigned_[0] = 0;

  this->basicPerpInfo_.copsAssigned_[1] = 0;

  this->basicPerpInfo_.crime_ = 1;

  this->caught_ = 0;

  pCVar1->unlap = 0;

  (this->carObj_)->lap =

       ((chaserCop)->carObj_)->lap;

  chaserCop->needPerp_ = 0;

  return;

}








/* ---- CheckForActivation__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::CheckForActivation  [AIH_BTCPERP.CPP:322-354] SLD-VERIFIED ---- */
AIHigh_BTC_HumanCop *

AIHigh_BTC_Perp::CheckForActivation()



{
  int carLoop;
  Car_tObj*humanCopCarObj;
  AIHigh_BTC_HumanCop*carHigh;
  int carType;

  Car_tObj *pCVar1;

  int iVar2;

  AIHigh_BTC_HumanCop *pAVar3;

  Car_tObj **ppCVar4;

  int iVar5;

  Car_tObj *pCVar6;

  

  iVar5 = 0;

  while (true) {

    if (Cars_gNumCars <= iVar5) {

      break;

    }

    pCVar1 = Cars_gList[iVar5];

    if (((pCVar1->carFlags & 0x200U) != 0) && ((pCVar1->N).active != '\0')) {

      pAVar3 = (AIHigh_BTC_HumanCop *)highLevelAIObjs[pCVar1->carIndex];

      iVar2 = 0;

      if ((pAVar3)->copIndex_ == 0) {

        iVar2 = pAVar3->needPerp_;

      }

      if (iVar2 != 0) {

        pCVar6 = this->carObj_;

        if ((pCVar6->carFlags & 4U) != 0) {

          return pAVar3;

        }

        if (GameSetup_gData.perpInfo[pAVar3->currentStage_].CarType == pCVar6->carInfo->carType) {

          return pAVar3;

        }

      }

    }

    iVar5 = iVar5 + 1;

  }

  return (AIHigh_BTC_HumanCop *)0x0;

}








/* ---- NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop  AIHigh_BTC_HumanPerp::NewStage  [AIH_BTCPERP.CPP:366-416] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanPerp::NewStage(AIHigh_BTC_HumanCop *chaserCop)



{
  int placementSide;
  int placementDirection;
  int humanDirection;
  int newLatPos;
  int throwAway;
  Car_tObj *carObj;

  

  humanDirection = chaserCop->initialDirection_;

  this->originalActivationCop_ = chaserCop;

  this->ClearForNewStage(chaserCop);

  this->ReleaseCops();

  randtemp = fastRandom * randSeed;

  placementSide = 1;

  carObj = this->carObj_;

  fastRandom = randtemp & 0xffff;

  placementDirection = placementSide;

  if (0 <= humanDirection * 0x10) {
    short wrappedSlice;

    if (gNumSlices <=
        (short)(chaserCop->carObj_->N).simRoadInfo.slice +
            humanDirection * 0x10) {

      wrappedSlice = (u_short)(chaserCop->carObj_->N).simRoadInfo.slice +
                     humanDirection * 0x10 - (u_short)gNumSlices;
      goto storePositiveSlice;

    }

    wrappedSlice = (u_short)(chaserCop->carObj_->N).simRoadInfo.slice +
                   humanDirection * 0x10;

  storePositiveSlice:
    (carObj->N).simRoadInfo.slice = wrappedSlice;

  }

  else {

    short wrappedSlice;

    if ((short)(chaserCop->carObj_->N).simRoadInfo.slice +
            humanDirection * 0x10 < 0) {

      wrappedSlice = (u_short)gNumSlices +
                     ((u_short)(chaserCop->carObj_->N).simRoadInfo.slice +
                      humanDirection * 0x10);

    }

    else {

      wrappedSlice = (u_short)(chaserCop->carObj_->N).simRoadInfo.slice +
                     humanDirection * 0x10;

    }

    (carObj->N).simRoadInfo.slice = wrappedSlice;

  }

  if (placementDirection == 1) {

    (this->carObj_)->desiredDirection = placementSide * humanDirection;

  }

  else {

    (this->carObj_)->desiredDirection = -(placementSide * humanDirection);

  }

  this->carObj_->direction = this->carObj_->desiredDirection;

  newLatPos = 0;

  throwAway = 0;

  AIWorld_FindBarrierLessLaneAndPosition(this->carObj_,&throwAway,&newLatPos);

  AILife_PlaceCarAtLocation(this->carObj_,

             (int)(this->carObj_->N).simRoadInfo.slice,newLatPos,
             this->carObj_->direction,0,0);

  ((SpeakerVirtualDispatch *)Speech_Mobile(chaserCop->carObj_))->slot15();

  ((SpeakerVirtualDispatch *)Speech_Dispatch())->slot0(this->carObj_);

  ((SpeakerVirtualDispatch *)Speech_Mobile(chaserCop->carObj_))->slot0(this->carObj_);

  ((SpeakerVirtualDispatch *)Speech_Mobile(chaserCop->carObj_))->slot5(this->carObj_);

  TrgSfx_RestartTrgSfx();

  return;

}








/* ---- HighExecute__20AIHigh_BTC_HumanPerp  AIHigh_BTC_HumanPerp::HighExecute  [AIH_BTCPERP.CPP:421-427] SLD-VERIFIED ---- */

void AIHigh_BTC_HumanPerp::HighExecute()



{

  AIHigh_BTC_HumanCop *chaserCop;

  

  if ((this->caught_ == 1) &&

     (chaserCop = this->CheckForActivation(),

     chaserCop != (AIHigh_BTC_HumanCop *)0x0)) {

    this->NewStage(chaserCop);

  }

  else {

    this->HandleCops();

  }

  return;

}








/* ---- __17AIHigh_BTC_AIPerpP8Car_tObj  AIHigh_BTC_AIPerp::ctor  [AIH_BTCPERP.CPP:441-454] SLD-VERIFIED ---- */
AIHigh_BTC_AIPerp::AIHigh_BTC_AIPerp(Car_tObj *carObj)



{

  Car_tObj *pCVar1;

  int iVar2;

  

  (new((AIHigh_BasicPerp *)this) AIHigh_BasicPerp(carObj));

  this->_vf =

       (__vtbl_ptr_type (*) [3])(AIHigh_BTC_HumanPerp_vtable + 8);

  this->caught_ = 1;

  pCVar1 = this->carObj_;

  this->_vf =

       (__vtbl_ptr_type (*) [3])AIHigh_BTC_AIPerp_vtable;

  this->hudActivated_ = 0;

  this->originalActivationCop_ = (AIHigh_BTC_HumanCop *)0x0;

  this->perpMode_ = 0;

  this->creationTime_ = 0;

  this->madeContactTime_ = 0;

  this->timeUntilContact_ = 64000;

  this->escapeDuration_ = 0;

  this->originalMass_ = (pCVar1->N).mass;

  iVar2 = (pCVar1->N).massInv;

  this->closestCopCarObj_ = (Car_tObj *)0x0;

  this->closestCopCarDistanceMeters_ = 0;

  this->originalMassInv_ = iVar2;

  return;

}








/* ---- _._17AIHigh_BTC_AIPerp  AIHigh_BTC_AIPerp::dtor  [AIH_BTCPERP.CPP:461-465] SLD-VERIFIED ---- */

AIHigh_BTC_AIPerp::~AIHigh_BTC_AIPerp()



{

  int iVar1;

  Car_tObj *pCVar2;

  

  pCVar2 = this->carObj_;

  iVar1 = this->originalMass_;

  this->_vf =

       (__vtbl_ptr_type (*) [3])AIHigh_BTC_AIPerp_vtable;

  (pCVar2->N).mass = iVar1;

  ((this->carObj_)->N).massInv =

       this->originalMassInv_;

  this->_vf =

       (__vtbl_ptr_type (*) [3])AIHigh_BasicPerp_vtable;


  return;

}








/* ---- AvoidCops__17AIHigh_BTC_AIPerp  AIHigh_BTC_AIPerp::AvoidCops  [AIH_BTCPERP.CPP:488-552] SLD-VERIFIED ---- */

/* PASS (209/209 insns; was 200 diffs).  Retail's missing first-roll threshold is
 * `AI_elapsedTime * 7 + pullOver * 500`.  The SYM starts xPosition, zPosition,
 * xPositionIndex, and zPositionIndex in the nested block at 0x80060428; using
 * precisely that scope fixes the caller-register interference graph.  Spelling
 * xPosition as load, subtract, then multiply keeps it in retail's $v1 through
 * the multiply.  Direct __builtin_abs comparisons recover the branch shapes.
 * No volatile, register pin, or empty-asm allocation fence is required. */

void AIHigh_BTC_AIPerp::AvoidCops()



{
  int doBrake;

  bool bVar1;

  int iVar2;

  Car_tObj *pCVar3;

  int iVar4;

  Car_tObj *pCVar5;

  int iVar6;

  int iVar7;

  

  bVar1 = false;

  if ((this->closestCopCarObj_ != (Car_tObj *)0x0) &&
      (this->closestCopCarObj_->RSControl == 0)) {

    if (this->closestCopCarObj_->direction == this->carObj_->direction) {

      if (__builtin_abs(this->closestCopCarDistanceMeters_) < 0x1f40000) {
        int xPosition;
        int zPosition;
        int xPositionIndex;
        int zPositionIndex;

        xPosition = this->carObj_->roadPosition;
        xPosition -= this->closestCopCarObj_->roadPosition;
        xPosition *= this->closestCopCarObj_->direction;

        zPosition = this->closestCopCarDistanceMeters_ * this->closestCopCarObj_->direction;

        iVar4 = (this->closestCopCarObj_->N).dimension.x;

        xPositionIndex = bVar1;

        if ((-iVar4 <= xPosition) && (xPositionIndex = 1, iVar4 < xPosition)) {

          xPositionIndex = 2;

        }

        zPositionIndex = 0;

        if (zPosition <= 0x190000) {

          iVar2 = (this->closestCopCarObj_->N).dimension.z;

          zPositionIndex = 1;

          if (zPosition <= iVar2) {

            zPositionIndex = 4;

            if (-0x190000 <= zPosition) {

              zPositionIndex = 2;

              if (zPosition < -iVar2) {

                zPositionIndex = 3;

              }

            }

          }

        }

        if ((strategyChart[zPositionIndex][xPositionIndex] & 1) != 0) {

          randtemp = fastRandom * randSeed;

          pCVar3 = this->carObj_;

          fastRandom = randtemp & 0xffff;

          if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 <
              (u_int)(AI_elapsedTime * 7 + pCVar3->pullOver * 500)) {

            if (0x11c71c < __builtin_abs(this->closestCopCarObj_->currentSpeed)) {

              if (0x11c71c < __builtin_abs(pCVar3->currentSpeed)) {

                bVar1 = true;

                goto LAB_800606f0;

              }

            }

          }

        }

        if ((strategyChart[zPositionIndex][xPositionIndex] & 2) != 0) {

          randtemp = fastRandom * randSeed;

          fastRandom = randtemp & 0xffff;

          /* H-AVOID2: u-turn probability roll (was a stub -- oracle 0x80060600-0x800606EC does a
             full skill/elapsed-time-scaled random roll + dual speed-threshold check + direction flip) */
          if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 <
              (u_int)(AIHigh_BTC_uTurnProb1000Skills[GameSetup_gData.skill] * AI_elapsedTime)) {

            if (0x11c71c < __builtin_abs(this->closestCopCarObj_->currentSpeed)) {

              if (0x11c71c < __builtin_abs((this->carObj_)->currentSpeed)) {

                if ((this->carObj_)->direction == (this->carObj_)->desiredDirection) {

                  (this->carObj_)->desiredDirection = -(this->carObj_)->direction;

                }

              }

            }

          }

        }

      }

    }

  }

LAB_800606f0:

  if (bVar1) {

    (this->carObj_)->pullOver = 1;

    return;

  }

  (this->carObj_)->pullOver = 0;

  return;

}








/* ---- CalculateTimeTillContact__17AIHigh_BTC_AIPerp  AIHigh_BTC_AIPerp::CalculateTimeTillContact  [AIH_BTCPERP.CPP:557-573] SLD-VERIFIED ---- */

void AIHigh_BTC_AIPerp::CalculateTimeTillContact()



{
  int distance;
  int relVel;



  if ((this->closestCopCarObj_ != (Car_tObj *)0x0) && ((u_int)this->perpMode_ < 2)) {

    relVel = (this->carObj_)->currentSpeed -

        this->closestCopCarObj_->currentSpeed;

    int copDistance = this->closestCopCarDistanceMeters_;   /* MATCH: hoisted above the if (oracle loads it unconditionally, before the sltu range check) */

    if (0xfffe < relVel + 0x7fffU) {

      distance = fixeddiv(copDistance,relVel);

      if (distance < 0) {

        distance = distance + 0x3ff;

      }

      this->timeUntilContact_ = -(distance >> 10);

    } else {

      this->timeUntilContact_ = 0x3e80000;

    }

    if (-1 < this->timeUntilContact_) {

      return;

    }

  }

  this->timeUntilContact_ = 64000;

  return;

}








/* ---- FindClosestCop__17AIHigh_BTC_AIPerp  AIHigh_BTC_AIPerp::FindClosestCop  [AIH_BTCPERP.CPP:582-609] SLD-VERIFIED ---- */

void AIHigh_BTC_AIPerp::FindClosestCop()



{
  int closestCopInMeters;
  int closestCopInMetersAbs;
  int closestCarIndex;
  int copLoop;
  int longMetersBetween;
  int absLongMetersBetween;

  Car_tObj *pCVar2;

  Car_tObj **ppCVar4;



  closestCopInMeters = 0x270f0000;

  closestCopInMetersAbs = 0x270f0000;

  closestCarIndex = -1;

  copLoop = 0;

  ppCVar4 = Cars_gHumanRaceCarList;

  while (true) {

    if (Cars_gNumHumanRaceCars <= copLoop) {
      break;
    }

    if (((*ppCVar4)->carFlags & 0x200U) != 0) {

      longMetersBetween = AIWorld_ApxSplineDistance(this->carObj_,*ppCVar4);

      absLongMetersBetween = __builtin_abs(longMetersBetween);

      if (absLongMetersBetween < closestCopInMetersAbs) {

        closestCopInMeters = longMetersBetween;

        closestCopInMetersAbs = absLongMetersBetween;

        closestCarIndex = (*ppCVar4)->carIndex;

      }

    }

    ppCVar4 = ppCVar4 + 1;

    copLoop = copLoop + 1;

  }

  if (closestCarIndex == -1) {

    this->closestCopCarObj_ = (Car_tObj *)0x0;

  }

  else {

    pCVar2 = Cars_gList[closestCarIndex];

    this->closestCopCarDistanceMeters_ = closestCopInMeters;

    this->closestCopCarObj_ = pCVar2;

  }

  return;

}








/* ---- HighExecute__17AIHigh_BTC_AIPerp  AIHigh_BTC_AIPerp::HighExecute  [AIH_BTCPERP.CPP:620-802] SLD-VERIFIED ---- */

void AIHigh_BTC_AIPerp::HighExecute()



{
  Car_tObj*carObj;
  coorddef trafficOffset;
  AIState_Base*newState;

  int iVar1;

  AIHigh_BTC_HumanCop *chaserCop;

  AIState_Normal *this_00;

  AIState_Base *pAVar3;

  int _Var4;

  AIState_Base *pAVar5;

  Car_tObj *otherCarObj;

  

  if (((this->carObj_)->N).active != '\0') {

    this->FindClosestCop();

    this->CalculateTimeTillContact();

  }

  switch(this->stateType_) {

  case 1:   /* MATCH: oracle's compare-chain routes stateType_==1 into the SAME body as case 2 */

  case 2:

    _Var4 = this->perpMode_;

    switch(_Var4) {

    case 0:

    case 3:

    case 5:

      break;

    case 1:

      if (this->timeUntilContact_ < 0x140) {

        this->madeContactTime_ = simGlobal.gameTicks;

        if (this->perpMode_ != 2) {

          ((SpeakerVirtualDispatch *)Speech_Mobile(((this->originalActivationCop_))->carObj_))
              ->slot0(this->carObj_);

        }

        this->perpMode_ = 2;

        Camera_gInfo[0].forceFocus = 2;

        Camera_gInfo[0].focusOnAICar =

             (char)(this->carObj_)->carIndex;

        Camera_gInfo[1].forceFocus = 2;

        Camera_gInfo[1].focusOnAICar =

             (char)(this->carObj_)->carIndex;

      }

      break;

    case 2:

      this->perpMode_ = 4;

      break;

    case 4:

      if (this->escapeDuration_ < simGlobal.gameTicks - this->madeContactTime_) {

        this->perpMode_ = 5;

        this->ReleaseCops();

      }

      if (simGlobal.gameTicks - this->madeContactTime_ > this->escapeDuration_ - 0x40) {

        if (Camera_gInfo[0].forceFocus != 0) {

          ((SpeakerVirtualDispatch *)Speech_Mobile(((this->originalActivationCop_))->carObj_))
              ->slot5(this->carObj_);

          Camera_ResetRelPos(3);

        }

        Camera_gInfo[0].forceFocus = 0;

        Camera_gInfo[0].focusOnAICar =

             (char)(this->carObj_)->carIndex;

        Camera_gInfo[1].forceFocus = 0;

        Camera_gInfo[1].focusOnAICar =

             (char)(this->carObj_)->carIndex;

      }

      otherCarObj = ((this->originalActivationCop_))->carObj_;

      if (otherCarObj->direction == this->carObj_->direction) {

        iVar1 = AIWorld_ApxSplineDistance(this->carObj_,otherCarObj);

        if (0 < iVar1 * this->carObj_->direction) {

          iVar1 = this->carObj_->currentSpeed;

          if (iVar1 < 0) {

            iVar1 = -iVar1;

          }

          iVar1 = fixedmult(iVar1,0xcccc);

          (this->originalActivationCop_)->requestedDesiredSpeed_ = iVar1;

        }

      }

      break;

    default:

      goto perpMode_merge;

    }

    _Var4 = this->perpMode_;

perpMode_merge:

    if (_Var4 != 5) break;

    this->HandleCops();

    if (this->pullOverMode_ != 2) {

      this->AvoidCops();

    }

    if (this->caught_ == 0) break;

  case 0:

    pAVar3 = operator new(8);

    carObj = this->carObj_;

    (new(pAVar3) AIState_Base(carObj));

    pAVar3->_vf = (__vtbl_ptr_type (*) [4])AIHigh_BTC_AIPerp_vtable;

    memset((u_char *)&trafficOffset,'\0',0xc);

    trafficOffset.y = carObj->carIndex * 0xa0000;

    Newton_SetInitialSlicePositionOrientationEtc(&pAVar3->carObj_->N,0,&trafficOffset,1);

    (pAVar3->carObj_->N).active = '\0';

    pAVar5 = this->state_;

    if (pAVar5 != (AIState_Base *)0x0) {

      (*(*pAVar5->_vf)[2].pfn)((int)&pAVar5->carObj_ + (int)(*pAVar5->_vf)[2].delta,3);

    }

    this->state_ = pAVar3;

    this->stateType_ = 7;

    this->perpMode_ = 0;

    break;

  case 7:

    chaserCop = this->CheckForActivation();

    if (chaserCop != (AIHigh_BTC_HumanCop *)0x0) {

      this->NewStage(chaserCop);

      this->schedulingOff_ = 0;

    }

    else {

      this->schedulingOff_ = 1;

    }

    break;

  case 10:

    if ((this->perpMode_ == 0) && (this->timeUntilContact_ < 0x140)) {

      this->madeContactTime_ = simGlobal.gameTicks;

      if (this->perpMode_ != 2) {

        ((SpeakerVirtualDispatch *)Speech_Mobile(((this->originalActivationCop_))->carObj_))
            ->slot0(this->carObj_);

      }

      this->perpMode_ = 2;

      Camera_gInfo[0].forceFocus = 2;

      Camera_gInfo[0].focusOnAICar =

           (char)(this->carObj_)->carIndex;

      Camera_gInfo[1].forceFocus = 2;

      Camera_gInfo[1].focusOnAICar =

           (char)(this->carObj_)->carIndex;

    }

    else if (this->perpMode_ == 2) {

      this_00 = operator new(8);

      newState = (AIState_Base*)(new(this_00) AIState_Normal(this->carObj_));

      pAVar5 = this->state_;

      if (pAVar5 != (AIState_Base *)0x0) {

        (*(*pAVar5->_vf)[2].pfn)((int)&pAVar5->carObj_ + (int)(*pAVar5->_vf)[2].delta,3);

      }

      this->state_ = newState;

      this->stateType_ = 2;

      this->perpMode_ = 4;

    }

  }

  (this->state_)->StateExecute();

  return;

}








/* ---- NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop  AIHigh_BTC_AIPerp::NewStage  [AIH_BTCPERP.CPP:807-1007] SLD-VERIFIED ---- */

/* SYM-local reconstruction: 153 detailed diffs -> PASS (363/363 insns).
 * The retail outer locals are stage, humanCopCarObj,
 * placementDistance/Side/Direction/Speed, randPlacement, humanDirection,
 * humanMovement, the two AUTO lane outputs, and i.  State `newState` and the
 * state temporaries are block-scoped.  Direct virtual calls recover the retail
 * vtable-load form.  WRAP_SLICE keeps the positive raw placement distance in
 * v1 while the signed offset is an unnamed a0 temporary, and repeated inline
 * GetCarObj calls recover the retail return-value copy before the placement
 * call.  One branch-local, pin-free identity fence prevents placementSide's
 * known value from folding away the retail a3-to-t1 copy.  No volatile or
 * register pin is used. */

void AIHigh_BTC_AIPerp::NewStage(AIHigh_BTC_HumanCop *chaserCop)



{
  int stage;
  Car_tObj*humanCopCarObj;
  int placementDistance;
  int placementSide;
  int placementDirection;
  enum {
    PLACEMENTSPEED_SLOW,
    PLACEMENTSPEED_FAST
  } placementSpeed;
  int randPlacement;
  int humanDirection;
  int humanMovement;
  int newLatPos;
  int throwAway;
  int i;

  

  stage = chaserCop->currentStage_;

  humanCopCarObj = chaserCop->carObj_;

  this->originalActivationCop_ = chaserCop;

  this->ClearForNewStage(chaserCop);

  i = 0;

  do {

    ((this->carObj_)->N).damage[i] = 0;

    i++;

  } while (i < 10);

  ((this->carObj_)->render).headLight = 0;

  ((this->carObj_)->render).brakeLight = 0;

  if (GameSetup_gData.Time != 0) {

    ((this->carObj_)->render).headLight = 0x33;

    ((this->carObj_)->render).brakeLight = 2;

  }

  ((this->carObj_)->render).signalLight[0] = 0;

  ((this->carObj_)->render).signalLight[1] = 0;

  ((this->carObj_)->render).damageParts = 0;

  (this->carObj_)->forceNoSimOptz = 1;

  Camera_gInfo[0].forceFocus = 1;

  Camera_gInfo[0].focusOnAICar =

       (char)(this->carObj_)->carIndex;

  Camera_gInfo[1].forceFocus = 1;

  Camera_gInfo[1].focusOnAICar =

       (char)(this->carObj_)->carIndex;

  Object_ClearCustomObjects();

  randtemp = fastRandom * randSeed;

  humanDirection = chaserCop->initialDirection_;

  AICop_gRoadBlockState = kAICop_RoadBlockState_None;

  fastRandom = randtemp & 0xffff;

  humanMovement = chaserCop->initialMovement_;

  placementSide = -1;

  randPlacement = (randtemp >> 8 & 0xffff) * 1000 >> 0x10;

  if (randPlacement < 0x14d) {

    placementDirection = 0;

    placementSpeed = PLACEMENTSPEED_FAST;

    humanCopCarObj->desiredSpeed = 0xd5555;

    chaserCop->requestedDesiredSpeed_ = 0xd5555;

    if (humanMovement != 0) {

      this->escapeDuration_ = 0x280;

      placementDistance = 0xe1;

    }

    else {

      this->escapeDuration_ = 0x180;

      placementDistance = 400;

    }

  }

  else {

    placementSide = 1;

    if (humanMovement == 0) {

      placementDirection = 0;

      placementSpeed = PLACEMENTSPEED_FAST;

      humanCopCarObj->desiredSpeed = 0x2c71c7;

      placementDistance = 400;

      chaserCop->requestedDesiredSpeed_ = 0x2c71c7;

      this->escapeDuration_ = 0x180;

    }

    else {

      placementDistance = 0x28;

      __asm__("" : "=r"(placementSide) : "0"(placementSide));
      placementDirection = placementSide;

      placementSpeed = PLACEMENTSPEED_SLOW;

      humanCopCarObj->desiredSpeed = 0x2c71c7;

      chaserCop->requestedDesiredSpeed_ = 0x2c71c7;

      this->escapeDuration_ = 0x1e0;

    }

  }

  (this->carObj_->N).simRoadInfo.slice = WRAP_SLICE(
      (placementDistance / 6) * placementSide * humanDirection,
      (humanCopCarObj->N).simRoadInfo.slice);

  if (placementDirection == 1) {

    (this->carObj_)->desiredDirection = placementSide * humanDirection;

  }

  else {

    (this->carObj_)->desiredDirection = -(placementSide * humanDirection);

  }

  this->carObj_->direction = this->carObj_->desiredDirection;

  newLatPos = 0;

  throwAway = 0;

  AIWorld_FindBarrierLessLaneAndPosition(this->carObj_,&throwAway,&newLatPos);

  {
    AILife_PlaceCarAtLocation(this->carObj_,

               (int)(this->GetCarObj()->N).simRoadInfo.slice,newLatPos,
               this->GetCarObj()->direction,
               placementSpeed == PLACEMENTSPEED_FAST ? 0x1f1c71 : 0x11c71c,0);
  }

  Camera_Update();

  (this->carObj_)->btcGlueModifier =
      fixedmult(GameSetup_gData.perpInfo[stage].GlueFactor,
                AITune_BTC[GameSetup_gData.skill].glueMult);

  (this->carObj_)->speedFactor =
      fixedmult(GameSetup_gData.perpInfo[stage].SpeedFactor,
                AITune_BTC[GameSetup_gData.skill].speedMult);

  ((this->carObj_)->N).mass =
      fixedmult(fixedmult(this->originalMass_,
                          GameSetup_gData.perpInfo[stage].WeightFactor),
                AITune_BTC[GameSetup_gData.skill].weightMult);

  ((this->carObj_)->N).massInv = fixeddiv(0x10000,((this->carObj_)->N).mass);

  AIPerson_SetPersonality(this->carObj_,

             GameSetup_gData.perpInfo[stage].Personality);

  R3DCar_ChangeTrafficColor(this->carObj_,

             GameSetup_gData.perpInfo[stage].Colour);

  (this->carObj_)->carInfo->SpeechColour =

       GameSetup_gData.perpInfo[stage].SpeechColour;

  (this->carObj_)->carInfo->HudColour =

       GameSetup_gData.perpInfo[stage].HudColour;

  Hud_InitMap();

  this->creationTime_ = simGlobal.gameTicks;

  if (placementSpeed == PLACEMENTSPEED_FAST) {

    AIState_Base *newState;

    AIState_Normal *this_00;

    this_00 = operator new(8);

    newState = (AIState_Base*)(new(this_00) AIState_Normal(this->carObj_));

    if (this->state_ != (AIState_Base *)0x0) {

      (*(int (**)(...))((int)this->state_->_vf + 0x14))
          ((int)&this->state_->carObj_ + (int)*(short *)((int)this->state_->_vf + 0x10),3);

    }

    this->state_ = newState;

    this->stateType_ = 2;

    this->perpMode_ = (cruiseMode_t)placementSpeed;

  }

  else {

    AIState_Base *newState;

    AIState_Cruise *pAVar5;

    pAVar5 = operator new(0x14);

    pAVar5 = (new(pAVar5) AIState_Cruise(this->carObj_,(cruiseMode_t)1,0x8000

                       ));

    newState = (AIState_Base *)pAVar5;

    if (this->state_ != (AIState_Base *)0x0) {

      (*(int (**)(...))((int)this->state_->_vf + 0x14))
          ((int)&this->state_->carObj_ + (int)*(short *)((int)this->state_->_vf + 0x10),3);

    }

    this->state_ = newState;

    this->stateType_ = 10;

    this->perpMode_ = 0;

  }

  ((SpeakerVirtualDispatch *)Speech_Mobile(humanCopCarObj))->slot15();

  ((SpeakerVirtualDispatch *)Speech_Dispatch())->slot0(this->carObj_);

  TrgSfx_RestartTrgSfx();

  return;

}








/* ---- _._20AIHigh_BTC_HumanPerp  AIHigh_BTC_HumanPerp::dtor  [AIH_BTCPERP.CPP:?] SLD-FLAG:NO_SLD ---- */

AIHigh_BTC_HumanPerp::~AIHigh_BTC_HumanPerp()



{

  this->_vf =

       (__vtbl_ptr_type (*) [3])AIHigh_BasicPerp_vtable;


  return;

}








/* ---- ___15AIHigh_BTC_Perp_80061348 @0x80061348 : AIHigh_BTC_Perp dtor, THIS obj's
 * vague-linkage instance (w60 unlock: was spelled as the canonical member dtor, which
 * collides with AIHIGH.OBJ's canonical @0x8005B438 -- oracles byte-identical 10/10).
 * cfront chain: own-base vtable store in the jal delay slot + tail call of the next
 * NON-TRIVIAL base dtor (___11AIHigh_Base, ONE arg -- same device as aih_basicperp). ---- */

extern "C" void ___11AIHigh_Base_1arg(void *) __asm__("___11AIHigh_Base");
extern "C" void ___15AIHigh_BTC_Perp_80061348(AIHigh_BTC_Perp *pThis)



{

  pThis->_vf = (__vtbl_ptr_type (*) [3])AIHigh_BasicPerp_vtable;

  ___11AIHigh_Base_1arg(pThis);

  return;

}







































/* ==== AIState vague-linkage tail (2026-08-03 name-fix): btcperp's OWN compiled copies of the
 * shared AIState helpers -- retail emitted one instance per .obj (SYM names them identically at
 * distinct VAs; oracle vtable copies D_80055000/D_80055020 are this obj's NonActive/Base vtables,
 * recon binds the shared vtable symbols like every other 100% fn in this TU).  Bodies mirror the
 * aistate.cpp instances (100%-proven spellings). */
extern __vtbl_ptr_type AIState_NonActive_vtable[], AIState_Base_vtable[];

/* ---- Execute__17AIState_NonActive_80061370 @0x80061370 : empty per-frame body (real method --
 * the cc1plus demangle guard rejects the mangled name as a plain identifier) ---- */
extern "C" void Execute__17AIState_NonActive_80061370(AIState_NonActive *pThis)
{
  return;
}

/* w60 unlock: the surplus canonical `AIState_NonActive::Execute()` member def that
 * lived here collided with aih_btccop's (owner of 0x8005F624) -- removed. */

/* ---- ___17AIState_NonActive_80061378 @0x80061378 : deleting dtor (SYM _._17AIState_NonActive) ---- */
extern "C" void ___17AIState_NonActive_80061378(AIState_NonActive *pThis,int __in_chrg)
{
  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_NonActive_vtable;
  ((pThis->carObj_)->N).active = '\x01';
  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;
}

/* ---- TestForRelease__12AIState_Base_800613C4 @0x800613C4 : shared default impl (real method) ---- */
extern "C" int TestForRelease__12AIState_Base_800613C4(AIState_Base *pThis)
{
  return 0;
}

/* w60 unlock: the surplus canonical `AIState_Base::TestForRelease()` member def that
 * lived here collided with aihigh.cpp's (owner of 0x8005B4C4) -- removed. */

/* ---- ___12AIState_Base_800613CC @0x800613CC : deleting dtor (SYM _._12AIState_Base) ---- */
extern "C" void ___12AIState_Base_800613CC(AIState_Base *pThis,int __in_chrg)
{
  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_Base_vtable;
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;
}

/* end of aih_btcperp.cpp */
