/* game/common/aih_btcperp.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aih_btcperp_types.h"
#include "aih_btcperp_externs.h"

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int NumCars(void) { return Cars_gNumCars; }


/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int GameTicks(void) { return simGlobal.gameTicks; }


/* Retail aih_btcperp.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *, const char *, ...);

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

/* Retail aih_btcperp.obj owns this vague-linkage NonActive vtable copy. */

/* The inline constructor shape is corroborated by the NFSU2 mobile twin and
   the independently matched aih_btccop.cpp AIState_BTCInactive idiom. */

/* ---- aistate.obj-owned globals (.bss zero) ---- */
u_char       strategyChart[5][3] = { 4u, 4u, 4u, 0, 0, 0, 1u, 0, 1u, 1u, 1u, 1u, 2u, 2u, 2u };   /* @0x8010ce7c */
int          AIHigh_BTC_uTurnProb1000Skills[3] = { 3, 4, 5 };   /* @0x8010ce8c */


/* ---- ReleaseCops__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::ReleaseCops  [AIH_BTCPERP.CPP:63-75] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::ReleaseCops()



{

  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {
    Car_tObj *otherCarObj = Cars_gList[carLoop];

    if (((otherCarObj->carFlags & 0x200U) != 0) && ((otherCarObj->N).active != '\0')) {

      ((AIHigh_BTC_HumanCop *)highLevelAIObjs[otherCarObj->carIndex])->ReleaseAndStartChase(this);

    }

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








/* ---- IsFalseArrest__15AIHigh_BTC_Perp [retail AIH_BTCPERP.CPP:93-126; native ownership exact, SLD still open] ---- */

int AIHigh_BTC_Perp::IsFalseArrest()



{
  /* SYM whole-function rewrite (w22-a13): SYM @0x8005f798 names ONLY randNum1000(REG v0),
   * carLoop(REG s5), cop(REG a1), xDot(REG s2), zDot(REG s1), and carCopVector (AUTO
   * coorddef, sp+0x10/14/18) -- NO iVar1..iVar5/delta[3] temps exist in the real source.
   * AUDAI (2026-10-04): pin-free PASS 136/136.  xDot and zDot are both single
   * three-term dot-product expressions, and |xDot| is taken INSIDE the arrest test as
   * `(xDot < 0 ? -xDot : xDot)` rather than by a separate `if (xDot < 0) xDot = -xDot;`
   * statement.  The conditional expression gives retail's `bgez s2; nop; negu s2` with
   * the empty slot and the post-call accumulation order; the old statement form needed
   * three void fences plus the dotTerm/dotTerm2 carriers to reach the same bytes. */
  int randNum1000;




  randtemp = fastRandom * randSeed;

  fastRandom = randtemp & 0xffff;

  randNum1000 = (randtemp >> 8 & 0xffff) * 1000 >> 0x10;

  if (((this->carObj_)->carFlags & 4U) != 0 || randNum1000 <= 0x3d3) {
    return 0;
  }

    for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
      Car_tObj *cop = Cars_gList[carLoop];

      if ((cop->carFlags & 0x200U) != 0) {
        int xDot;
        int zDot;
        coorddef carCopVector;

        carCopVector.x = (cop->N).position.x - ((this->carObj_)->N).position.x;

        carCopVector.y = (cop->N).position.y -

                ((this->carObj_)->N).position.y;

        carCopVector.z = (cop->N).position.z -

                ((this->carObj_)->N).position.z;

        xDot = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[0]) +

               fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[1]) +

               fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[2]);


        zDot = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[6]) +

               fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[7]) +

               fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[8]);

        if (((0x30000 < (xDot < 0 ? -xDot : xDot)) || (0x80000 < zDot)) || (zDot < 0)) {


          AudioClc_HonkHorn(this->carObj_,2,0x80,0x20);

          return 1;

        }

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








inline bool AIHigh_BTC_HumanCop::HasCatchTime() { return timeLeft_ > 5; }

/* ---- HandlePullOver__15AIHigh_BTC_Perp [retail AIH_BTCPERP.CPP:153-222; native ownership exact, SLD open] ---- */
/* MATCH: 118/118 instructions; all three native local records and11 regions.
 * Boolean cop-time query removes the caught/activationCopReady captures.
 * Timer assignment before mode installation removes gameTicks; only the
 * arrest-complete timer read has a retail inline pair. HasCatchTime is an
 * inferred semantic helper name, not a uniquely recovered original spelling. */
void AIHigh_BTC_Perp::HandlePullOver()



{

  if (this->pullOverMode_ != 0) {
    int userReadyToContinue;

    this->NotifyCopsOfArrest();

    this->beatingTicksLeft_ -= AI_elapsedTime;   /* H21: oracle 0x8005FA94 v0=beatingTicksLeft_-AI_elapsedTime, 0x8005FA9C store */

    if ((this->beatingTicksLeft_ < 1) && (this->hudActivated_ == 0)) {

      if (this->IsFalseArrest() != 0) {

        this->lastPullOverTime_ = simGlobal.gameTicks + -0x280;

        this->NotifyCopsOfFalseArrest();

        (this->carObj_)->pullOver = 0;

        this->pullOverMode_ = 0;

        Speech::Mobile(Cars_gList[0])->Lose();

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

      this->lastPullOverTime_ = GameTicks();

      this->basicPerpInfo_.crime_ = 0;

      this->NotifyCopsOfArrestComplete();

      (this->carObj_)->pullOver = 0;

      this->pullOverMode_ = 0;

      this->caught_ = 1;

      this->hudActivated_ = 0;

    }

  }

  else if (this->originalActivationCop_->HasCatchTime() &&
           (this->CheckIfCaught() != 0)) {
    this->carObj_->pullOver = 1;
    this->beatingTicksLeft_ = 0x60;
    this->lastPullOverTime_ = simGlobal.gameTicks;
    this->pullOverMode_ = 2;
  }

  return;

}








/* ---- NotifyCopsOfArrest__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::NotifyCopsOfArrest  [AIH_BTCPERP.CPP:233-245] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::NotifyCopsOfArrest()



{
  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {
    Car_tObj *otherCarObj = Cars_gList[carLoop];

    if (((otherCarObj->carFlags & 0x220U) != 0) &&
        ((otherCarObj->N).active != '\0')) {
      ((AIHigh_BTC_Cop *)highLevelAIObjs[otherCarObj->carIndex])->StartArrest(this);
    }

  }

  return;

}








/* ---- NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::NotifyCopsOfArrestComplete  [AIH_BTCPERP.CPP:251-266] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::NotifyCopsOfArrestComplete()



{

  

  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {
    Car_tObj *otherCarObj = Cars_gList[carLoop];

    if (((otherCarObj->carFlags & 0x220U) != 0) &&
        ((otherCarObj->N).active != '\0')) {

      ((AIHigh_BTC_Cop *)highLevelAIObjs[otherCarObj->carIndex])->FinishArrest(this);

    }

  }

  return;

}








/* ---- NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::NotifyCopsOfFalseArrest  [AIH_BTCPERP.CPP:271-283] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::NotifyCopsOfFalseArrest()



{
  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {
    Car_tObj *otherCarObj = Cars_gList[carLoop];

    if (((otherCarObj->carFlags & 0x220U) != 0) &&
        ((otherCarObj->N).active != '\0')) {

      ((AIHigh_BTC_Cop *)highLevelAIObjs[otherCarObj->carIndex])->FalseArrest(this);

    }

  }

  return;

}








/* ---- NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::NotifyHumanCopsOfArrestHud  [AIH_BTCPERP.CPP:288-301] SLD-VERIFIED ---- */

void AIHigh_BTC_Perp::NotifyHumanCopsOfArrestHud()



{
  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {
    Car_tObj *otherCarObj = Cars_gList[carLoop];

    if (((otherCarObj->carFlags & 0x200U) != 0) &&
        ((otherCarObj->N).active != '\0')) {

      ((AIHigh_BTC_HumanCop *)highLevelAIObjs[otherCarObj->carIndex])->HudOn(this,0,

                 this->lastArrestingCop_);

    }

  }

  return;

}








inline void AIHigh_BTC_HumanCop::SetNeedPerp(int needPerp) { needPerp_ = needPerp; }
inline int AIHigh_BTC_HumanCop::NeedsPerp() { return copIndex_ == 0 ? needPerp_ : 0; }
inline int AIHigh_BTC_HumanCop::CurrentStage() { return currentStage_; }
inline int AIHigh_BTC_HumanCop::InitialDirection() { return initialDirection_; }
inline int AIHigh_BTC_HumanCop::InitialMovement() { return initialMovement_; }
inline void AIHigh_BTC_HumanCop::SetRequestedDesiredSpeed(int speed) { requestedDesiredSpeed_ = speed; }

inline void AICop_BasicPerpInfo::SetCopsAssigned(copType type, int count) {
  copsAssigned_[type] = count;
}
inline void AICop_BasicPerpInfo::ClearCopsAssigned() {
  SetCopsAssigned((copType)0, 0);
  SetCopsAssigned((copType)1, 0);
}

/* ---- ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop [retail AIH_BTCPERP.CPP:304-316; native+SLD exact] ---- */
/* MATCH: 25/25 instructions, all native records/13 scopes, zero SLD tag
 * differences and exact block/end-line deltas. Reset/setter names are inferred
 * from the operations and inline tree; literal original identifiers are open. */
void AIHigh_BTC_Perp::ClearForNewStage(AIHigh_BTC_HumanCop *chaserCop)



{
  this->Clear();

  this->basicPerpInfo_.ClearCopsAssigned();

  this->basicPerpInfo_.SetCrime((crimeType)1);
  this->caught_ = 0;
  this->carObj_->unlap = 0;
  this->carObj_->lap = chaserCop->CarObj()->lap;

  chaserCop->SetNeedPerp(0);

  return;

}








/* ---- CheckForActivation__15AIHigh_BTC_Perp [retail AIH_BTCPERP.CPP:322-354; native ownership exact, SLD open] ---- */
/* MATCH: 66/66 instructions, seven native local records/all13 scope regions.
 * NeedsPerp preserves the integer request, not a normalized Boolean. Both
 * member query spellings are inferred; their receiver records are retail.
 * No caller activationRequested or reconstruction-only NumCars pair remains. */
AIHigh_BTC_HumanCop *
AIHigh_BTC_Perp::CheckForActivation()
{
  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
    Car_tObj *humanCopCarObj = Cars_gList[carLoop];
    if (((humanCopCarObj->carFlags & 0x200U) != 0) &&
        (humanCopCarObj->N.active != '\0')) {
      AIHigh_BTC_HumanCop *carHigh =
          (AIHigh_BTC_HumanCop *)highLevelAIObjs[humanCopCarObj->carIndex];
      if (carHigh->NeedsPerp() != 0) {
        if ((this->carObj_->carFlags & 4U) != 0) {
          return carHigh;
        }
        else {
          int carType = GameSetup_gData.perpInfo[carHigh->CurrentStage()].CarType;
          if (carType == this->carObj_->carInfo->carType) {
            return carHigh;
          }
        }
      }
    }
  }
  return (AIHigh_BTC_HumanCop *)0;
}








/* ---- NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop [retail AIH_BTCPERP.CPP:366-416; native ownership exact, SLD open] ---- */

void AIHigh_BTC_HumanPerp::NewStage(AIHigh_BTC_HumanCop *chaserCop)



{
  int placementSide;
  int placementDirection;
  int humanDirection;
  int newLatPos;
  int throwAway;

  

  humanDirection = chaserCop->InitialDirection();

  this->originalActivationCop_ = chaserCop;

  this->ClearForNewStage(chaserCop);

  this->ReleaseCops();

  randtemp = fastRandom * randSeed;

  placementSide = 1;


  fastRandom = randtemp & 0xffff;

  placementDirection = placementSide;

  this->carObj_->N.simRoadInfo.slice =
      0 <= humanDirection * 0x10
      ? (gNumSlices <= (short)chaserCop->CarObj()->N.simRoadInfo.slice + humanDirection * 0x10
         ? (short)((u_short)chaserCop->CarObj()->N.simRoadInfo.slice + humanDirection * 0x10 - (u_short)gNumSlices)
         : (short)((u_short)chaserCop->CarObj()->N.simRoadInfo.slice + humanDirection * 0x10))
      : ((short)chaserCop->CarObj()->N.simRoadInfo.slice + humanDirection * 0x10 < 0
         ? (short)((u_short)gNumSlices + ((u_short)chaserCop->CarObj()->N.simRoadInfo.slice + humanDirection * 0x10))
         : (short)((u_short)chaserCop->CarObj()->N.simRoadInfo.slice + humanDirection * 0x10));

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

  ((SpeakerVirtualDispatch *)Speech::Mobile(chaserCop->CarObj()))->slot15();

  ((SpeakerVirtualDispatch *)Speech::Dispatch())->slot0(this->carObj_);

  ((SpeakerVirtualDispatch *)Speech::Mobile(chaserCop->CarObj()))->slot0(this->carObj_);

  ((SpeakerVirtualDispatch *)Speech::Mobile(chaserCop->CarObj()))->slot5(this->carObj_);

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
AIHigh_BTC_AIPerp::AIHigh_BTC_AIPerp(Car_tObj *carObj) : AIHigh_BTC_Perp(carObj)
{

  



  this->perpMode_ = 0;

  this->creationTime_ = 0;

  this->madeContactTime_ = 0;

  this->timeUntilContact_ = 64000;

  this->escapeDuration_ = 0;

  this->originalMass_ = (this->carObj_->N).mass;

  this->originalMassInv_ = (this->carObj_->N).massInv;

  this->closestCopCarObj_ = (Car_tObj *)0x0;

  this->closestCopCarDistanceMeters_ = 0;

  return;

}








/* ---- _._17AIHigh_BTC_AIPerp  AIHigh_BTC_AIPerp::dtor  [AIH_BTCPERP.CPP:461-465] SLD-VERIFIED ---- */

AIHigh_BTC_AIPerp::~AIHigh_BTC_AIPerp()



{


  (this->carObj_->N).mass = this->originalMass_;

  ((this->carObj_)->N).massInv =

       this->originalMassInv_;



  return;

}








/* ---- AvoidCops__17AIHigh_BTC_AIPerp  AIHigh_BTC_AIPerp::AvoidCops  [retail AIH_BTCPERP.CPP:488-552; native/byte verified, SLD attribution open] ---- */

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

  

  doBrake = 0;

  if ((this->closestCopCarObj_ != (Car_tObj *)0x0) &&
      (this->closestCopCarObj_->RSControl == 0) &&
      (this->closestCopCarObj_->direction == this->carObj_->direction) &&
      (__builtin_abs(this->closestCopCarDistanceMeters_) < 0x1f40000)) {
    /* Retail owns these four quantities in this compound guard body
     * (+05c..+324), not in separately nested tests. SLD attribution is open. */
    int xPosition;
    int zPosition;
    int xPositionIndex;
    int zPositionIndex;

        xPosition = this->carObj_->roadPosition;
        xPosition -= this->closestCopCarObj_->roadPosition;
        xPosition *= this->closestCopCarObj_->direction;

        zPosition = this->closestCopCarDistanceMeters_ * this->closestCopCarObj_->direction;

        xPositionIndex = doBrake;

        if ((-(this->closestCopCarObj_->N).dimension.x <= xPosition) &&
            (xPositionIndex = 1,
             (this->closestCopCarObj_->N).dimension.x < xPosition)) {

          xPositionIndex = 2;

        }

        zPositionIndex = 0;

        if (zPosition <= 0x190000) {

          zPositionIndex = 1;

          if (zPosition <= (this->closestCopCarObj_->N).dimension.z) {

            zPositionIndex = 4;

            if (-0x190000 <= zPosition) {

              zPositionIndex = 2;

              if (zPosition < -(this->closestCopCarObj_->N).dimension.z) {

                zPositionIndex = 3;

              }

            }

          }

        }

        if ((strategyChart[zPositionIndex][xPositionIndex] & 1) != 0) {

          randtemp = fastRandom * randSeed;

          fastRandom = randtemp & 0xffff;

          if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 <
              (u_int)(AI_elapsedTime * 7 + this->carObj_->pullOver * 500)) {

            if (0x11c71c < __builtin_abs(this->closestCopCarObj_->currentSpeed)) {

              if (0x11c71c < __builtin_abs(this->carObj_->currentSpeed)) {

                doBrake = 1;
                goto apply_brake_choice;

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

/* Semantic reconstructed label; original spelling is unavailable. Selecting
 * braking skips the u-turn random roll before committing pullOver. */
apply_brake_choice:
  if (doBrake) {

    (this->carObj_)->pullOver = 1;

    return;

  }

  (this->carObj_)->pullOver = 0;

  return;

}








/* ---- CalculateTimeTillContact__17AIHigh_BTC_AIPerp [retail AIH_BTCPERP.CPP:557-573; native ownership exact, SLD open] ---- */

void AIHigh_BTC_AIPerp::CalculateTimeTillContact()



{



  if (this->closestCopCarObj_ == (Car_tObj *)0x0 || (u_int)this->perpMode_ >= 2) {
    this->timeUntilContact_ = 64000;
  } else {
    int distance;
    int relVel;

    relVel = (this->carObj_)->currentSpeed -

        this->closestCopCarObj_->currentSpeed;

    distance = this->closestCopCarDistanceMeters_;

    if (0xfffe < relVel + 0x7fffU) {

      this->timeUntilContact_ = -(fixeddiv(distance,relVel) / 0x400);

    } else {

      this->timeUntilContact_ = 0x3e80000;

    }

    if (this->timeUntilContact_ < 0) {
      this->timeUntilContact_ = 64000;
    }
  }

  return;

}








/* ---- FindClosestCop__17AIHigh_BTC_AIPerp  [AIH_BTCPERP.CPP:582-609]
 * Native SYM locals/scopes exact; retail SLD statement regions remain open. ---- */

void AIHigh_BTC_AIPerp::FindClosestCop()
{
  int closestCopInMeters;
  int closestCopInMetersAbs;
  int closestCarIndex;

  {
    int copLoop;
    closestCopInMeters = 0x270f0000;
    closestCopInMetersAbs = 0x270f0000;
    closestCarIndex = -1;
    copLoop = 0;
    while (true) {
      if (Cars_gNumHumanRaceCars <= copLoop) {
        break;
      }
      if ((Cars_gHumanRaceCarList[copLoop]->carFlags & 0x200U) != 0) {
        int longMetersBetween;
        int absLongMetersBetween;
        longMetersBetween = AIWorld_ApxSplineDistance(
            this->carObj_,Cars_gHumanRaceCarList[copLoop]);
        absLongMetersBetween = __builtin_abs(longMetersBetween);
        if (absLongMetersBetween < closestCopInMetersAbs) {
          closestCopInMeters = longMetersBetween;
          closestCopInMetersAbs = absLongMetersBetween;
          closestCarIndex = Cars_gHumanRaceCarList[copLoop]->carIndex;
        }
      }
      copLoop = copLoop + 1;
    }
  }
  if (closestCarIndex == -1) {
    this->closestCopCarObj_ = (Car_tObj *)0x0;
  }
  else {
    this->closestCopCarObj_ = Cars_gList[closestCarIndex];
    this->closestCopCarDistanceMeters_ = closestCopInMeters;
  }
}

inline void AIHigh_Base::SetSchedulingOff(int off) { schedulingOff_ = off; }

/* ---- HighExecute__17AIHigh_BTC_AIPerp [retail AIH_BTCPERP.CPP:620-802; native ownership exact, SLD open] ---- */
/* MATCH: 304/304 instructions, all17 native local records/all67 scope regions.
 * Separate source state-installation expressions in case0 and the caught arm
 * merge into the same physical code. Case/guard ownership and member accessors
 * restore the inline receivers without caller captures or a merge label.
 * Accessor names remain inferred; this is not a literal-source/SLD seal. */
void AIHigh_BTC_AIPerp::HighExecute()



{

  

  if (((this->carObj_)->N).active != '\0') {

    this->FindClosestCop();

    this->CalculateTimeTillContact();

  }

  switch(this->stateType_) {

  case 0: {

    /* SYM-INLINE-LOCAL: carObj = AIState_BTCInactive
       SYM-INLINE-LOCAL: trafficOffset = AIState_BTCInactive */
    this->SetState(new AIState_NonActive(this->carObj_),STATE_NONACTIVE);

    this->perpMode_ = 0;

    break;
  }

  case 1:   /* retail jump table 0x80055040 [1] = the switch END (not case 2's body); the
               label must exist -- with only 4 labels over 0..10 gcc drops to a compare chain */
    break;

  case 2: {

    switch(this->perpMode_) {

    case 0:

    case 3:

    case 5:

      break;

    case 1: {

      if (this->timeUntilContact_ < 0x140) {

        this->madeContactTime_ = simGlobal.gameTicks;

        if (this->perpMode_ != 2) {

          ((SpeakerVirtualDispatch *)Speech::Mobile(this->originalActivationCop_->CarObj()))
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

    }
      break;
    case 2:

      this->perpMode_ = 4;

      break;

    case 4: {

      if (this->escapeDuration_ < simGlobal.gameTicks - this->madeContactTime_) {

        this->perpMode_ = 5;

        this->ReleaseCops();

      }

      if (simGlobal.gameTicks - this->madeContactTime_ > this->escapeDuration_ - 0x40) {

        if (Camera_gInfo[0].forceFocus != 0) {

          ((SpeakerVirtualDispatch *)Speech::Mobile(this->originalActivationCop_->CarObj()))
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

      if (this->originalActivationCop_->CarObj()->direction ==
          this->carObj_->direction) {

        if (0 < AIWorld_ApxSplineDistance(
                    this->carObj_,this->originalActivationCop_->CarObj()) *
                    this->carObj_->direction) {

          this->originalActivationCop_->SetRequestedDesiredSpeed(
              fixedmult(__builtin_abs(this->carObj_->currentSpeed),0xcccc));

        }

      }

      break;

    }
    default:

      break;

    }

    if (this->perpMode_ == 5) {
      this->HandleCops();
      if (this->pullOverMode_ != 2) {
        this->AvoidCops();
      }
      if (this->caught_ != 0) {
        this->SetState(new AIState_NonActive(this->carObj_),STATE_NONACTIVE);
        this->perpMode_ = 0;
      }
    }
  }
    break;

  case 7: {
    AIHigh_BTC_HumanCop *chaserCop = this->CheckForActivation();

    if (chaserCop != (AIHigh_BTC_HumanCop *)0x0) {

      this->NewStage(chaserCop);

      this->SetSchedulingOff(0);

    }

    else {

      this->SetSchedulingOff(1);

    }

  }
    break;

  case 10: {

    if ((this->perpMode_ == 0) && (this->timeUntilContact_ < 0x140)) {

      this->madeContactTime_ = simGlobal.gameTicks;

      if (this->perpMode_ != 2) {

        ((SpeakerVirtualDispatch *)Speech::Mobile(this->originalActivationCop_->CarObj()))
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

      this->SetState(new AIState_Normal(this->carObj_),STATE_NORMAL);

      this->perpMode_ = 4;

    }

  }
  }

  (this->state_)->StateExecute();

  return;

}








/* ---- NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop [retail AIH_BTCPERP.CPP:807-1007; native ownership exact, SLD open] ---- */

/* SYM-local reconstruction: 153 detailed diffs -> PASS (363/363 insns).
 * The retail outer locals are stage, humanCopCarObj,
 * placementDistance/Side/Direction/Speed, randPlacement, humanDirection,
 * humanMovement, the two AUTO lane outputs, and i.  State `newState` and the
 * state temporaries are block-scoped.  Direct virtual calls recover the retail
 * vtable-load form. WRAP_SLICE keeps the positive raw placement distance in
 * v1 while the signed offset is an unnamed a0 temporary. The old GetCarObj
 * facades are now removed without losing the placement return-value copy.
 * placementSide = 1 is set at the head of EACH inner arm: post-reload
 * cse then turns the arm's literal 1s into copies of $a3 (retail's
 * `addu t1,a3` / `addu s4,a3`) and reorg hoists the two identical heads into
 * the bnez delay slot.  No asm, volatile or register pin is used. */


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

  

  stage = chaserCop->CurrentStage();

  humanCopCarObj = chaserCop->CarObj();

  this->originalActivationCop_ = chaserCop;

  this->ClearForNewStage(chaserCop);

  for (int i = 0; i < 10; i++) {

    ((this->carObj_)->N).damage[i] = 0;

  }

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

  humanDirection = chaserCop->InitialDirection();

  AICop_gRoadBlockState = kAICop_RoadBlockState_None;

  fastRandom = randtemp & 0xffff;

  humanMovement = chaserCop->InitialMovement();

  placementSide = -1;

  randPlacement = (randtemp >> 8 & 0xffff) * 1000 >> 0x10;

  if (randPlacement < 0x14d) {

    placementDirection = 0;

    placementSpeed = PLACEMENTSPEED_FAST;

    humanCopCarObj->desiredSpeed = 0xd5555;

    chaserCop->SetRequestedDesiredSpeed(0xd5555);

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

    if (humanMovement == 0) {

      placementSide = 1;

      placementDirection = 0;

      placementSpeed = PLACEMENTSPEED_FAST;

      humanCopCarObj->desiredSpeed = 0x2c71c7;

      placementDistance = 400;

      chaserCop->SetRequestedDesiredSpeed(0x2c71c7);

      this->escapeDuration_ = 0x180;

    }

    else {

      placementSide = 1;

      placementDistance = 0x28;

      placementDirection = placementSide;

      placementSpeed = PLACEMENTSPEED_SLOW;

      humanCopCarObj->desiredSpeed = 0x2c71c7;

      chaserCop->SetRequestedDesiredSpeed(0x2c71c7);

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

  AILife_PlaceCarAtLocation(this->carObj_,(int)this->carObj_->N.simRoadInfo.slice,
                          newLatPos,this->carObj_->direction,
                          placementSpeed == PLACEMENTSPEED_FAST ? 0x1f1c71 : 0x11c71c,0);
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

    this->SetState(new AIState_Normal(this->carObj_), STATE_NORMAL);

    this->perpMode_ = (cruiseMode_t)placementSpeed;

  }

  else {

    this->SetState(new AIState_Cruise(this->carObj_,(cruiseMode_t)1,0x8000), STATE_CRUISE);

    this->perpMode_ = 0;

  }

  ((SpeakerVirtualDispatch *)Speech::Mobile(humanCopCarObj))->slot15();

  ((SpeakerVirtualDispatch *)Speech::Dispatch())->slot0(this->carObj_);

  TrgSfx_RestartTrgSfx();

  return;

}















































/* ==== AIState vague-linkage tail (2026-08-03 name-fix): btcperp's OWN compiled copies of the
 * shared AIState helpers -- retail emitted one instance per .obj (SYM names them identically at
 * distinct VAs; oracle vtable copies D_80055000/D_80055020 are this obj's NonActive/Base vtables,
 * recon binds the shared vtable symbols like every other 100% fn in this TU).  Bodies mirror the
 * aistate.cpp instances (100%-proven spellings). */

/* ---- Execute__17AIState_NonActive_80061370 @0x80061370 : empty per-frame body (real method --
 * the cc1plus demangle guard rejects the mangled name as a plain identifier) ---- */

/* w60 unlock: the surplus canonical `AIState_NonActive::Execute()` member def that
 * lived here collided with aih_btccop's (owner of 0x8005F624) -- removed. */

/* ---- ___17AIState_NonActive_80061378 @0x80061378 : deleting dtor (SYM _._17AIState_NonActive) ---- */

/* ---- TestForRelease__12AIState_Base_800613C4 @0x800613C4 : shared default impl (real method) ---- */

/* w60 unlock: the surplus canonical `AIState_Base::TestForRelease()` member def that
 * lived here collided with aihigh.cpp's (owner of 0x8005B4C4) -- removed. */

/* ---- ___12AIState_Base_800613CC @0x800613CC : deleting dtor (SYM _._12AIState_Base) ---- */

/* end of aih_btcperp.cpp */
