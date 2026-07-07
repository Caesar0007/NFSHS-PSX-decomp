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
  int randNum1000;
  int carLoop;
  Car_tObj*cop;
  int xDot;
  int zDot;
  coorddef carCopVector;

  int iVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int a;

  Car_tObj *pCVar6;

  Car_tObj **ppCVar7;

  int iVar8;

  

  randtemp = fastRandom * randSeed;

  fastRandom = randtemp & 0xffff;

  if ((((this->carObj_)->carFlags & 4U) == 0) &&

     (0x3d3 < (randtemp >> 8 & 0xffff) * 1000 >> 0x10)) {

    iVar8 = 0;
    ppCVar7 = Cars_gList;
    while (true) {

      if (Cars_gNumCars <= iVar8) {
        break;
      }

      pCVar6 = *ppCVar7;

      if ((pCVar6->carFlags & 0x200U) != 0) {

        a = (pCVar6->N).position.x - ((this->carObj_)->N).position.x;

        iVar1 = (pCVar6->N).position.y -

                ((this->carObj_)->N).position.y;

        iVar2 = (pCVar6->N).position.z -

                ((this->carObj_)->N).position.z;

        iVar3 = fixedmult(a,((this->carObj_)->N).orientMat.m[0]);

        iVar4 = fixedmult(iVar1,((this->carObj_)->N).orientMat.m[1])

        ;

        iVar5 = fixedmult(iVar2,((this->carObj_)->N).orientMat.m[2])

        ;

        iVar5 = iVar3 + iVar4 + iVar5;

        iVar3 = fixedmult(a,((this->carObj_)->N).orientMat.m[6]);

        iVar1 = fixedmult(iVar1,((this->carObj_)->N).orientMat.m[7])

        ;

        iVar2 = fixedmult(iVar2,((this->carObj_)->N).orientMat.m[8])

        ;

        iVar2 = iVar3 + iVar1 + iVar2;

        if (iVar5 < 0) {

          iVar5 = -iVar5;

        }

        if (((0x30000 < iVar5) || (0x80000 < iVar2)) || (iVar2 < 0)) {

          AudioClc_HonkHorn(this->carObj_,2,0x80,0x20);

          return 1;

        }

      }

      ppCVar7 = ppCVar7 + 1;

      iVar8 = iVar8 + 1;

    }

  }

  return 0;

}








/* ---- CheckForControlsPressed__15AIHigh_BTC_Perp  AIHigh_BTC_Perp::CheckForControlsPressed  [AIH_BTCPERP.CPP:130-147] SLD-VERIFIED ---- */

int AIHigh_BTC_Perp::CheckForControlsPressed()



{
  int iVar1;

  Car_tControl *ctrl;



  iVar1 = 0;

  if ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0) && ((ctrl = &Cars_gHumanRaceCarList[0]->control, *(u_short *)ctrl) != 0 || ctrl->handBrake == '\x01')) {

    iVar1 = 1;

  }

  /* H20: player-2 check must read Cars_gHumanRaceCarList[1] (oracle 0x8005FA10 base 0x8010FA4C = list+4), not [0] */
  if (((Cars_gNumHumanRaceCars == 2) && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)) &&

     ((ctrl = &Cars_gHumanRaceCarList[1]->control, *(u_short *)ctrl) != 0 || ctrl->handBrake == '\x01')) {

    iVar1 = 1;

  }

  return iVar1;

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

    bVar1 = false;
    if (5 < this->originalActivationCop_->timeLeft_) {
      bVar1 = this->CheckIfCaught() != 0;
    }

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

  short sVar1;

  short sVar2;

  Car_tObj *pCVar3;

  Speaker *pSVar4;

  int iVar5;

  Car_tObj *pCVar6;

  int iVar7;

  int local_18;

  int local_14;

  

  iVar7 = chaserCop->initialDirection_;

  this->originalActivationCop_ = chaserCop;

  this->ClearForNewStage(chaserCop);

  this->ReleaseCops();

  randtemp = fastRandom * randSeed;

  pCVar6 = this->carObj_;

  iVar5 = iVar7 * 0x10;

  fastRandom = randtemp & 0xffff;

  sVar1 = (short)iVar5;

  if (iVar5 < 0) {

    pCVar3 = (chaserCop)->carObj_;

    sVar2 = (pCVar3->N).simRoadInfo.slice;

    if ((pCVar3->N).simRoadInfo.slice + iVar5 < 0) {

      sVar2 = (short)gNumSlices + sVar2 + sVar1;

    }

    else {

      sVar2 = sVar2 + sVar1;

    }

    (pCVar6->N).simRoadInfo.slice = sVar2;

  }

  else {

    pCVar3 = (chaserCop)->carObj_;

    sVar2 = (pCVar3->N).simRoadInfo.slice;

    if ((pCVar3->N).simRoadInfo.slice + iVar5 < gNumSlices) {

      sVar2 = sVar2 + sVar1;

    }

    else {

      sVar2 = (sVar2 + sVar1) - (short)gNumSlices;

    }

    (pCVar6->N).simRoadInfo.slice = sVar2;

  }

  (this->carObj_)->desiredDirection = iVar7;

  pCVar6 = this->carObj_;

  pCVar6->direction = pCVar6->desiredDirection;

  local_14 = 0;

  local_18 = 0;

  AIWorld_FindBarrierLessLaneAndPosition(this->carObj_,&local_18,&local_14);

  pCVar6 = this->carObj_;

  AILife_PlaceCarAtLocation(this->carObj_,

             (int)(pCVar6->N).simRoadInfo.slice,local_14,pCVar6->direction,0,0);

  pSVar4 = (Speaker *)Speech_Mobile((chaserCop)->carObj_);

  (**(int (**)(...))((int)*pSVar4->_vf + 0x84))

            ((int)&(pSVar4->fPosition).flags + (int)*(short *)((int)*pSVar4->_vf + 0x80));

  pSVar4 = (Speaker *)Speech_Dispatch();

  (**(int (**)(...))((int)*pSVar4->_vf + 0xc))

            ((int)&(pSVar4->fPosition).flags + (int)*(short *)((int)*pSVar4->_vf + 8),

             this->carObj_);

  pSVar4 = (Speaker *)Speech_Mobile((chaserCop)->carObj_);

  (**(int (**)(...))((int)*pSVar4->_vf + 0xc))

            ((int)&(pSVar4->fPosition).flags + (int)*(short *)((int)*pSVar4->_vf + 8),

             this->carObj_);

  pSVar4 = (Speaker *)Speech_Mobile((chaserCop)->carObj_);

  (**(int (**)(...))((int)*pSVar4->_vf + 0x34))

            ((int)&(pSVar4->fPosition).flags + (int)*(short *)((int)*pSVar4->_vf + 0x30),

             this->carObj_);

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

void AIHigh_BTC_AIPerp::AvoidCops()



{
  int doBrake;
  int xPosition;
  int zPosition;
  int xPositionIndex;
  int zPositionIndex;

  bool bVar1;

  int iVar2;

  Car_tObj *pCVar3;

  int iVar4;

  Car_tObj *pCVar5;

  int iVar6;

  int iVar7;

  

  pCVar3 = this->closestCopCarObj_;

  bVar1 = false;

  if ((pCVar3 != (Car_tObj *)0x0) && (pCVar3->RSControl == 0)) {

    pCVar5 = this->carObj_;

    iVar4 = pCVar3->direction;

    if (iVar4 == pCVar5->direction) {

      iVar6 = this->closestCopCarDistanceMeters_;

      iVar2 = iVar6;

      if (iVar6 < 0) {

        iVar2 = -iVar6;

      }

      if (iVar2 < 0x1f40000) {

        iVar2 = (pCVar5->roadPosition - pCVar3->roadPosition) * iVar4;

        iVar6 = iVar6 * iVar4;

        iVar4 = (pCVar3->N).dimension.x;

        iVar7 = 0;

        if ((-iVar4 <= iVar2) && (iVar7 = 1, iVar4 < iVar2)) {

          iVar7 = 2;

        }

        iVar4 = 0;

        if (iVar6 < 0x190001) {

          iVar2 = (this->closestCopCarObj_->N).dimension.z;

          iVar4 = 1;

          if (((iVar6 <= iVar2) && (iVar4 = 4, -0x190001 < iVar6)) && (iVar4 = 2, iVar6 < -iVar2)) {

            iVar4 = 3;

          }

        }

        if ((strategyChart[iVar4][iVar7] & 1) != 0) {

          randtemp = fastRandom * randSeed;

          pCVar3 = this->carObj_;

          fastRandom = randtemp & 0xffff;

          if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 < (u_int)(pCVar3->pullOver * 500)) {

            iVar6 = this->closestCopCarObj_->currentSpeed;

            if (iVar6 < 0) {

              iVar6 = -iVar6;

            }

            if (0x11c71c < iVar6) {

              iVar6 = pCVar3->currentSpeed;

              if (iVar6 < 0) {

                iVar6 = -iVar6;

              }

              if (0x11c71c < iVar6) {

                bVar1 = true;

                goto LAB_800606f0;

              }

            }

          }

        }

        if ((strategyChart[iVar4][iVar7] & 2) != 0) {

          randtemp = fastRandom * randSeed;

          fastRandom = randtemp & 0xffff;

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

    distance = 0x3e80000;

    if (0xfffe < relVel + 0x7fffU) {

      distance = fixeddiv(this->closestCopCarDistanceMeters_,relVel);

      if (distance < 0) {

        distance = distance + 0x3ff;

      }

      distance = -(distance >> 10);

    }

    this->timeUntilContact_ = distance;

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

  ppCVar4 = Cars_gHumanRaceCarList;

  for (copLoop = 0; copLoop < Cars_gNumHumanRaceCars; copLoop = copLoop + 1) {

    if (((*ppCVar4)->carFlags & 0x200U) != 0) {

      longMetersBetween = AIWorld_ApxSplineDistance(this->carObj_,*ppCVar4);

      absLongMetersBetween = longMetersBetween;

      if (longMetersBetween < 0) {

        absLongMetersBetween = -longMetersBetween;

      }

      if (absLongMetersBetween < closestCopInMetersAbs) {

        closestCarIndex = (*ppCVar4)->carIndex;

        closestCopInMetersAbs = absLongMetersBetween;

        closestCopInMeters = longMetersBetween;

      }

    }

    ppCVar4 = ppCVar4 + 1;

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

  Speaker *pSVar2;

  AIState_Normal *this_00;

  AIState_Base *pAVar3;

  int _Var4;

  AIState_Base *pAVar5;

  Car_tObj *otherCarObj;

  Car_tObj *pCVar6;

  coorddef cStack_20;

  

  if (((this->carObj_)->N).active != '\0') {

    this->FindClosestCop();

    this->CalculateTimeTillContact();

  }

  switch(this->stateType_) {

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

          pSVar2 = (Speaker *)Speech_Mobile(((this->originalActivationCop_))->carObj_);

          (**(int (**)(...))((int)*pSVar2->_vf + 0xc))

                    ((int)&(pSVar2->fPosition).flags + (int)*(short *)((int)*pSVar2->_vf + 8),

                     this->carObj_);

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

      if (this->escapeDuration_ + -0x40 < simGlobal.gameTicks - this->madeContactTime_) {

        if (Camera_gInfo[0].forceFocus != 0) {

          pSVar2 = (Speaker *)Speech_Mobile(((this->originalActivationCop_))->carObj_);

          (**(int (**)(...))((int)*pSVar2->_vf + 0x34))

                    ((int)&(pSVar2->fPosition).flags + (int)*(short *)((int)*pSVar2->_vf + 0x30),

                     this->carObj_);

          Camera_ResetRelPos(3);

        }

        Camera_gInfo[0].forceFocus = 0;

        Camera_gInfo[0].focusOnAICar =

             (char)(this->carObj_)->carIndex;

        Camera_gInfo[1].forceFocus = 0;

        Camera_gInfo[1].focusOnAICar =

             (char)(this->carObj_)->carIndex;

      }

      pCVar6 = this->carObj_;

      otherCarObj = ((this->originalActivationCop_))->carObj_;

      if (otherCarObj->direction == pCVar6->direction) {

        iVar1 = AIWorld_ApxSplineDistance(pCVar6,otherCarObj);

        pCVar6 = this->carObj_;

        if (0 < iVar1 * pCVar6->direction) {

          iVar1 = pCVar6->currentSpeed;

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

    pCVar6 = this->carObj_;

    (new(pAVar3) AIState_Base(pCVar6));

    pAVar3->_vf = (__vtbl_ptr_type (*) [4])AIHigh_BTC_AIPerp_vtable;

    memset((u_char *)&cStack_20,'\0',0xc);

    cStack_20.y = pCVar6->carIndex * 0xa0000;

    Newton_SetInitialSlicePositionOrientationEtc(&pAVar3->carObj_->N,0,&cStack_20,1);

    (pAVar3->carObj_->N).active = '\0';

    pAVar5 = this->state_;

    if (pAVar5 != (AIState_Base *)0x0) {

      (*(int (*)(...))((int)pAVar5->_vf + 0x14))((int)&pAVar5->carObj_ + (int)*(short *)((int)pAVar5->_vf + 0x10),3);

    }

    this->state_ = pAVar3;

    this->stateType_ = 7;

    this->perpMode_ = 0;

    break;

  case 7:

    chaserCop = this->CheckForActivation();

    if (chaserCop == (AIHigh_BTC_HumanCop *)0x0) {

      this->schedulingOff_ = 1;

    }

    else {

      this->NewStage(chaserCop);

      this->schedulingOff_ = 0;

    }

    break;

  case 10:

    if ((this->perpMode_ == 0) && (this->timeUntilContact_ < 0x140)) {

      this->madeContactTime_ = simGlobal.gameTicks;

      if (this->perpMode_ != 2) {

        pSVar2 = (Speaker *)Speech_Mobile(((this->originalActivationCop_))->carObj_);

        (**(int (**)(...))((int)*pSVar2->_vf + 0xc))

                  ((int)&(pSVar2->fPosition).flags + (int)*(short *)((int)*pSVar2->_vf + 8),

                   this->carObj_);

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

      pAVar3 = (AIState_Base*)(new(this_00) AIState_Normal(this->carObj_));

      pAVar5 = this->state_;

      if (pAVar5 != (AIState_Base *)0x0) {

        (*(int (*)(...))((int)pAVar5->_vf + 0x14))((int)&pAVar5->carObj_ + (int)*(short *)((int)pAVar5->_vf + 0x10),3);

      }

      this->state_ = pAVar3;

      this->stateType_ = 2;

      this->perpMode_ = 4;

    }

  }

  (this->state_)->StateExecute();

  return;

}








/* ---- NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop  AIHigh_BTC_AIPerp::NewStage  [AIH_BTCPERP.CPP:807-1007] SLD-VERIFIED ---- */

void AIHigh_BTC_AIPerp::NewStage(AIHigh_BTC_HumanCop *chaserCop)



{
  int stage;
  Car_tObj*humanCopCarObj;
  int placementDistance;
  int placementSide;
  int placementDirection;
  int placementSpeed;
  int randPlacement;
  int humanDirection;
  int humanMovement;
  int newLatPos;
  int throwAway;
  int i;
  AIState_Base*newState;

  bool bVar1;

  short sVar2;

  bool bVar3;

  AIState_Normal *this_00;

  AIState_Base *pAVar4;

  AIState_Cruise *pAVar5;

  Speaker *pSVar6;

  u_int uVar7;

  AIState_Base *pAVar8;

  int iVar9;

  short sVar10;

  int iVar11;

  Car_tObj *pCVar12;

  int iVar13;

  int iVar14;

  Car_tObj *carObj;

  int local_28;

  int local_24;

  

  iVar14 = chaserCop->currentStage_;

  carObj = (chaserCop)->carObj_;

  this->originalActivationCop_ = chaserCop;

  this->ClearForNewStage(chaserCop);

  iVar11 = 0;

  do {

    iVar9 = iVar11 + 1;

    ((this->carObj_)->N).damage[iVar11] = 0;

    iVar11 = iVar9;

  } while (iVar9 < 10);

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

  iVar13 = chaserCop->initialDirection_;

  AICop_gRoadBlockState = 0;

  fastRandom = randtemp & 0xffff;

  iVar9 = chaserCop->initialMovement_;

  iVar11 = -1;

  if ((randtemp >> 8 & 0xffff) * 1000 >> 0x10 < 0x14d) {

    bVar1 = false;

    bVar3 = true;

    carObj->desiredSpeed = 0xd5555;

    chaserCop->requestedDesiredSpeed_ = 0xd5555;

    if (iVar9 == 0) {

      this->escapeDuration_ = 0x180;

      uVar7 = 400;

    }

    else {

      this->escapeDuration_ = 0x280;

      uVar7 = 0xe1;

    }

  }

  else {

    bVar1 = iVar9 != 0;

    iVar11 = 1;

    if (bVar1) {

      uVar7 = 0x28;

      carObj->desiredSpeed = 0x2c71c7;

      chaserCop->requestedDesiredSpeed_ = 0x2c71c7;

      iVar9 = 0x1e0;

    }

    else {

      uVar7 = 400;

      carObj->desiredSpeed = 0x2c71c7;

      chaserCop->requestedDesiredSpeed_ = 0x2c71c7;

      iVar9 = 0x180;

    }

    bVar3 = !bVar1;

    this->escapeDuration_ = iVar9;

  }

  iVar9 = (uVar7 / 6) * iVar11 * iVar13;

  pCVar12 = this->carObj_;

  if (iVar9 < 0) {

    sVar2 = (carObj->N).simRoadInfo.slice;

    sVar10 = sVar2 + (short)iVar9;

    if (sVar2 + iVar9 < 0) {

      sVar10 = (short)gNumSlices + sVar10;

    }

    (pCVar12->N).simRoadInfo.slice = sVar10;

  }

  else {

    sVar2 = (carObj->N).simRoadInfo.slice;

    sVar10 = sVar2 + (short)iVar9;

    if (gNumSlices <= sVar2 + iVar9) {

      sVar10 = sVar10 - (short)gNumSlices;

    }

    (pCVar12->N).simRoadInfo.slice = sVar10;

  }

  iVar11 = iVar11 * iVar13;

  if (bVar1) {

    (this->carObj_)->desiredDirection = iVar11;

  }

  else {

    (this->carObj_)->desiredDirection = -iVar11;

  }

  pCVar12 = this->carObj_;

  pCVar12->direction = pCVar12->desiredDirection;

  local_24 = 0;

  local_28 = 0;

  AIWorld_FindBarrierLessLaneAndPosition(this->carObj_,&local_28,&local_24);

  pCVar12 = this->carObj_;

  if (bVar3) {

    iVar11 = 0x1f1c71;

  }

  else {

    iVar11 = 0x11c71c;

  }

  AILife_PlaceCarAtLocation(this->carObj_,

             (int)(pCVar12->N).simRoadInfo.slice,local_24,pCVar12->direction,iVar11,0);

  Camera_Update();

  iVar11 = fixedmult(GameSetup_gData.perpInfo[iVar14].GlueFactor,

                      AITune_BTC[GameSetup_gData.skill].glueMult);

  (this->carObj_)->btcGlueModifier = iVar11;

  iVar11 = fixedmult(GameSetup_gData.perpInfo[iVar14].SpeedFactor,

                      AITune_BTC[GameSetup_gData.skill].speedMult);

  (this->carObj_)->speedFactor = iVar11;

  iVar11 = fixedmult(this->originalMass_,GameSetup_gData.perpInfo[iVar14].WeightFactor);

  iVar11 = fixedmult(iVar11,AITune_BTC[GameSetup_gData.skill].weightMult);

  ((this->carObj_)->N).mass = iVar11;

  iVar11 = fixeddiv(0x10000,((this->carObj_)->N).mass);

  ((this->carObj_)->N).massInv = iVar11;

  AIPerson_SetPersonality(this->carObj_,

             GameSetup_gData.perpInfo[iVar14].Personality);

  R3DCar_ChangeTrafficColor(this->carObj_,

             GameSetup_gData.perpInfo[iVar14].Colour);

  (this->carObj_)->carInfo->SpeechColour =

       GameSetup_gData.perpInfo[iVar14].SpeechColour;

  (this->carObj_)->carInfo->HudColour =

       GameSetup_gData.perpInfo[iVar14].HudColour;

  Hud_InitMap();

  this->creationTime_ = simGlobal.gameTicks;

  if (bVar3) {

    this_00 = operator new(8);

    pAVar4 = (AIState_Base*)(new(this_00) AIState_Normal(this->carObj_));

    pAVar8 = this->state_;

    if (pAVar8 != (AIState_Base *)0x0) {

      (*(int (*)(...))((int)pAVar8->_vf + 0x14))((int)&pAVar8->carObj_ + (int)*(short *)((int)pAVar8->_vf + 0x10),3);

    }

    this->state_ = pAVar4;

    this->stateType_ = 2;

    this->perpMode_ = 1;

  }

  else {

    pAVar5 = operator new(0x14);

    pAVar5 = (new(pAVar5) AIState_Cruise(this->carObj_,(cruiseMode_t)1,0x8000

                       ));

    pAVar4 = this->state_;

    if (pAVar4 != (AIState_Base *)0x0) {

      (*(int (*)(...))((int)pAVar4->_vf + 0x14))((int)&pAVar4->carObj_ + (int)*(short *)((int)pAVar4->_vf + 0x10),3);

    }

    this->state_ = (AIState_Base *)pAVar5;

    this->stateType_ = 10;

    this->perpMode_ = 0;

  }

  pSVar6 = (Speaker *)Speech_Mobile(carObj);

  (**(int (**)(...))((int)*pSVar6->_vf + 0x84))

            ((int)&(pSVar6->fPosition).flags + (int)*(short *)((int)*pSVar6->_vf + 0x80));

  pSVar6 = (Speaker *)Speech_Dispatch();

  (**(int (**)(...))((int)*pSVar6->_vf + 0xc))

            ((int)&(pSVar6->fPosition).flags + (int)*(short *)((int)*pSVar6->_vf + 8),

             this->carObj_);

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








/* ---- _._15AIHigh_BTC_Perp  AIHigh_BTC_Perp::dtor  [AIH_BTCPERP.CPP:?] SLD-FLAG:NO_SLD ---- */

AIHigh_BTC_Perp::~AIHigh_BTC_Perp()



{

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_BasicPerp_vtable;


  return;

}







































/* end of aih_btcperp.cpp */
