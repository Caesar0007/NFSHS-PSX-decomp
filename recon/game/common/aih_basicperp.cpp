/* game/common/aih_basicperp.cpp -- RECONSTRUCTED (base perp AI class; C++ TU)
 *   8 fns: AIHigh_BasicPerp base class (ctor/CheckForCrimes/CheckIfCaught/RemoveCloseCops/
 *   RemoveChaser/AddChaser/CheckChaserPosition/Clear). Composition-modeled inheritance
 *   (_base_AIHigh_Base); manual _vf vtable. Faithful C++ (option A). NOT original;
 *   SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_basicperp_externs.h"

/* ---- aih_basicperp.obj-owned globals (.bss zero) ---- */
int          AIHigh_BasicPerp_PlayerCaughtSpeed[3] = { 1019448, 1165084, 1310720 };   /* @0x8010cd5c */
int          AIHigh_BasicPerp_PlayerCaughtDeltaY[3] = { 327680, 425984, 524288 };   /* @0x8010cd68 */
int          AIHigh_BasicPerp_MinDeltaSpeed[3] = { 582542, 728177, 873813 };   /* @0x8010cd74 */
int          AIHigh_BasicPerp_CopCaughtSpeed[3] = { 728177, 932067, 1165084 };   /* @0x8010cd80 */
int          AIHigh_BasicPerp_CaughtDistance[3] = { 1966080, 2949120, 3932160 };   /* @0x8010cd8c */


/* ---- CheckForCrimes__16AIHigh_BasicPerp  AIHigh_BasicPerp::CheckForCrimes  [AIH_BASICPERP.CPP:43-136] SLD-VERIFIED ---- */

void AIHigh_BasicPerp::CheckForCrimes()



{
  int crime;
  int originalCrime;
  int legal;

  BO_tNewtonObj *pBVar2;

  Car_tObj *pCVar3;

  int iVar4;

  int iVar1;



  crime = (this->basicPerpInfo_).crime_;

  originalCrime = crime;

  legal = AISpeeds_GetLegalSpeed((int)((this->carObj_)->N).simRoadInfo.slice);

  if (simGlobal.gameTicks - this->lastPullOverTime_ < 0x280) {

    return;

  }

  pCVar3 = this->carObj_;

  if (1 < (pCVar3->stats).finishType) {

    return;

  }

  if (((simGlobal.gameTicks - (pCVar3->N).collision.lastTime < 0xf) &&

      (pBVar2 = (pCVar3->N).collision.lastOtherObj, pBVar2 != (BO_tNewtonObj *)0x0)) &&

     ((pBVar2[1].simRoadInfo.quadPts[1].y & 0x20U) != 0)) {

    if ((pCVar3->N).collision.lastImpulse < 0x140001) {

      if (crime == 0) {

        originalCrime = 3;

      }

    }

    else {

      originalCrime = 4;

    }

  }

  if ((crime != 0) && (originalCrime != 4)) {

    return;

  }

  iVar4 = (this->carObj_)->currentSpeed;

  if (legal < 0) {

    legal = -legal;

  }

  if (iVar4 < 0) {

    iVar4 = -iVar4;

  }

  if ((legal < iVar4) && (originalCrime == 0)) {

    originalCrime = 1;

  }

  if (AITune_oneWay == 0) {

    pCVar3 = this->carObj_;

    iVar1 = pCVar3->currentSpeed;

    if (iVar1 * AITune_driveSide >= 0) {

      if (6 < pCVar3->laneIndex) goto LAB_8005b700;

    }

    else if (pCVar3->laneIndex < 7) goto LAB_8005b700;

    if (iVar1 < 0) {

      iVar1 = -iVar1;

    }

  }

  else {

    iVar1 = (this->carObj_)->currentSpeed;

    if (GameSetup_gData.reverseTrack != 0) {

      iVar1 = -iVar1;

    }

    if (-1 < iVar1) goto LAB_8005b700;

    iVar1 = (this->carObj_)->currentSpeed;

    if (iVar1 < 0) {

      iVar1 = -iVar1;

    }

  }

  if ((0x40000 < iVar1) && (originalCrime == 0)) {

    originalCrime = 2;

  }

LAB_8005b700:

  if (simGlobal.gameTicks < 0x200) {

    originalCrime = 0;

  }

  if (originalCrime != 0) {

    int carLoop;
    Car_tObj **ppCVar5;

    carLoop = 0;

    ppCVar5 = Cars_gList;

    for (; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {

      Car_tObj *carObj;

      carObj = *ppCVar5;

      if (((carObj->carFlags & 0x220U) != 0) && ((carObj->N).active != '\0')) {

        (this->basicPerpInfo_).crime_ = originalCrime;

        return;

      }

      ppCVar5 = ppCVar5 + 1;

    }

  }

  return;

}








/* ---- CheckIfCaught__16AIHigh_BasicPerp  AIHigh_BasicPerp::CheckIfCaught  [AIH_BASICPERP.CPP:180-289] SLD-VERIFIED ---- */

int AIHigh_BasicPerp::CheckIfCaught()



{
  int skill;
  int absSpeed;

  skill = GameSetup_gData.skill;

  if ((this->carObj_->carFlags & 2U) != 0) {

    absSpeed = __builtin_abs(this->carObj_->currentSpeed);

  }

  else {

    absSpeed = this->carObj_->N.speedXZ;

  }

  if ((this->basicPerpInfo_).crime_ != 0) {

    if (AIHigh_BasicPerp_PlayerCaughtSpeed[skill] < absSpeed) {

      return 0;

    }

    if (simGlobal.gameTicks - this->lastPullOverTime_ < 0x3c0) {

      return 0;

    }

    if ((this->carObj_->stats).finishType < 2) {

      int perpUpright;
      int carLoop;

      perpUpright = 0x9999 < this->carObj_->N.orientMat.m[4];

      for (carLoop = 0; ; carLoop = carLoop + 1) {

        Car_tObj *cop;
        int validCar;
        int diffSpeed;
        int xDot;

        if (Cars_gNumCars <= carLoop) {

          return 0;

        }

        cop = Cars_gList[carLoop];

        xDot = 0;

        diffSpeed = this->carObj_->currentSpeed - cop->currentSpeed;

        validCar = 0;

        if (((((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&

             ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||

              ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) &&

            ((cop->carFlags & 0x200U) != 0)) ||

           ((((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||

             ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0 &&

              ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0)))))) &&

            ((cop->carFlags & 0x20U) != 0)))) {

          validCar = 1;

        }

        if (validCar == 0) continue;

        if (((((cop->AIFlags & 2U) != 0) && ((cop->N).flightTime == 0)) &&

            (((cop->N).active != '\0' && ((cop->AIFlags & 4U) == 0)))) &&

           ((0x9999 < (cop->N).orientMat.m[4] &&

            (diffSpeed < AIHigh_BasicPerp_MinDeltaSpeed[skill])))) {

          int distanceAbsMeters;
          int barrierInWay;

          {
            int iVar7;

            iVar7 = cop->currentSpeed;

            if (iVar7 < 0) {

              iVar7 = -iVar7;

            }

            if (AIHigh_BasicPerp_CopCaughtSpeed[skill] <= iVar7) continue;
          }

          {
            int iVar10;
            int iVar11;
            int iVar7;
            int threshY;

            threshY = AIHigh_BasicPerp_PlayerCaughtDeltaY[skill];

            iVar11 = (cop->N).position.y;

            iVar10 = ((this->carObj_)->N).position.y;

            iVar7 = iVar11 - iVar10;

            if (iVar7 < 1) {

              iVar7 = iVar10 - iVar11;

            }

            if (threshY <= iVar7) continue;
          }

          distanceAbsMeters = __builtin_abs(AIWorld_ApxSplineDistance(this->carObj_,cop));

          {
            u_char bVar1;
            int iVar10;

            bVar1 = *(u_char *)((this->carObj_->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0x1d);

            iVar10 = this->carObj_->laneIndex;

            barrierInWay = 0;

            if (((int)(7 - (u_int)(bVar1 >> 4)) <= iVar10) && (iVar10 <= (int)((bVar1 & 0xf) + 6))) {

              int iVar11;
              int iVar12;

              iVar11 = (int)(cop->N).simRoadInfo.slice;

              bVar1 = *(u_char *)(iVar11 * 0x20 + (int)BWorldSm_slices + 0x1d);

              iVar12 = cop->laneIndex;

              if (((int)(7 - (u_int)(bVar1 >> 4)) <= iVar12) &&

                 ((iVar12 <= (int)((bVar1 & 0xf) + 6) &&

                  (iVar10 = AIWorld_CheckForBarrierBetweenLanes(iVar11,iVar12,iVar10), iVar10 != 0)))) {

                iVar10 = AIWorld_CheckForBarrierBetweenLanes((int)(this->carObj_->N).simRoadInfo.slice,cop->laneIndex,

                                    this->carObj_->laneIndex);

                barrierInWay = iVar10 != 0;

              }

            }
          }

          if (AIHigh_BasicPerp_CaughtDistance[skill] <= distanceAbsMeters) continue;

          if (barrierInWay) continue;

          {
          int zDot;

          zDot = 0x10000;

          if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&

             ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||

              ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {

            coorddef carCopVector;
            int iVar12;
            int iVar5;

            carCopVector.x = (cop->N).position.x - ((this->carObj_)->N).position.x;

            carCopVector.y = (cop->N).position.y - ((this->carObj_)->N).position.y;

            carCopVector.z = (cop->N).position.z - ((this->carObj_)->N).position.z;

            iVar12 = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[0]);

            iVar5 = fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[1]);

            xDot = fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[2]);

            xDot = iVar12 + iVar5 + xDot;

            iVar12 = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[6]);

            iVar5 = fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[7]);

            zDot = fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[8]);

            zDot = iVar12 + iVar5 + zDot;

          }

          if ((!perpUpright) ||

             ((cop->speed < 0x471c7 && ((this->carObj_)->speed < 0x471c7)))) {

            if (this->lastArrestingCop_ == (Car_tObj *)0x0) {

              this->lastArrestingCop_ = cop;

              return 1;

            }

            return 1;

          }

          if (xDot < 0) {

            xDot = -xDot;

          }

          if (0x8ffff < xDot) continue;

          if (zDot < 0) continue;

          if (0x8ffff < zDot) continue;
          }

          if (this->lastArrestingCop_ == (Car_tObj *)0x0) {

            this->lastArrestingCop_ = cop;

            return 1;

          }

          return 1;

        }

      }

    }

  }

  return 0;

}








/* ---- RemoveCloseCops__16AIHigh_BasicPerp  AIHigh_BasicPerp::RemoveCloseCops  [AIH_BASICPERP.CPP:296-325] SLD-VERIFIED ---- */

void AIHigh_BasicPerp::RemoveCloseCops()



{
  int copLoop;
  Car_tObj*cop;
  int distance;
  AIHigh_Cop*thisCop;

  int iVar1;

  Speaker *pSVar2;

  AIHigh_Base *pAVar3;

  int iVar4;

  Car_tObj *carObj;

  int iVar6;



  iVar6 = 0;

  while( true ) {

    if (Cars_gNumCopCars <= iVar6) break;

    carObj = Cars_gCopCarList[iVar6];

    if ((carObj->AIFlags & 4U) == 0) {

      iVar1 = AIWorld_ApxSplineDistance(carObj,this->carObj_);

      iVar1 = __builtin_abs(iVar1);

      if (iVar1 < 0x960000) {

        pAVar3 = highLevelAIObjs[carObj->carIndex];

        iVar4 = 1;

        if (GameSetup_gData.reverseTrack == 0) {

          iVar4 = -1;

        }

        carObj->direction = iVar4;

        carObj->desiredDirection = iVar4;

        carObj->driveDirection = 1;

        if (iVar1 < 0x1e0000) {

          pAVar3[3].schedulingOff_ = 1;

        }

        else {

          pAVar3[3].schedulingOff_ = 2;

        }

        pSVar2 = (Speaker *)Speech_Mobile(pAVar3->carObj_);

        /* manual-vtable slot 16 (raw byte offsets from the oracle jalr/lh -- __vtbl_ptr_type
           is 8 bytes, so a typed _vf[N] index/pointer-add is 8x too large; decay to a byte
           base and use the RAW displacement, §3.12 lever #10). */
        (**(int (**)(...))((char *)pSVar2->_vf + 0x84))

                  ((int)&(pSVar2->fPosition).flags + (int)*(short *)((char *)pSVar2->_vf + 0x80));

      }

    }

    iVar6 = iVar6 + 1;

  }

  return;

}








/* ---- RemoveChaser__16AIHigh_BasicPerpii7copType  AIHigh_BasicPerp::RemoveChaser  [AIH_BASICPERP.CPP:331-337] SLD-VERIFIED ---- */

void AIHigh_BasicPerp::RemoveChaser(int copIndex,int carIndex,copType type)



{
  int pos;

  int iVar1;

  int *piVar2;

  int *piBase;

  

  iVar1 = this->copVSPositionList_[copIndex];

  piBase = (this->basicPerpInfo_).copsAssigned_;

  piVar2 = piBase + type;

  *piVar2 = *piVar2 + -1;

  this->positionVSCopList_[iVar1].copIndex = -1;

  this->positionVSCopList_[iVar1].carIndex = -1;

  return;

}








/* ---- AddChaser__16AIHigh_BasicPerpii7copType  AIHigh_BasicPerp::AddChaser  [AIH_BASICPERP.CPP:343-355] SLD-VERIFIED ---- */

int AIHigh_BasicPerp::AddChaser(int copIndex,int carIndex,copType type)



{
  int pos;

  int iVar1;

  int *piVar2;

  tCopCarPair *pPVar3;



  piVar2 = this->basicPerpInfo_.copsAssigned_;

  piVar2 = piVar2 + type;

  *piVar2 = *piVar2 + 1;

  pPVar3 = (tCopCarPair *)&this->positionVSCopList_[1].carIndex;

  pos = 5;

  *(int *)((char *)pPVar3 + 0x1C) = copIndex;

  *(int *)((char *)pPVar3 + 0x20) = carIndex;

  this->copVSPositionList_[copIndex] = pos;

  iVar1 = this->CheckChaserPosition(copIndex,carIndex);

  return iVar1;

}








/* ---- CheckChaserPosition__16AIHigh_BasicPerpii  AIHigh_BasicPerp::CheckChaserPosition  [AIH_BASICPERP.CPP:359-400] SLD-VERIFIED ---- */

int AIHigh_BasicPerp::CheckChaserPosition(int copIndex,int carIndex)



{
  int pos;
  int thisCopSlice;
  int nextCopIndex;
  int nextCarIndex;



  pos = this->copVSPositionList_[copIndex];

  thisCopSlice = (highLevelAIObjs[carIndex]->carObj_->N).simRoadInfo.slice;

  while( true ) {

    if (pos < 1) {

      return pos;

    }

    nextCopIndex = this->positionVSCopList_[pos + -1].copIndex;

    nextCarIndex = this->positionVSCopList_[pos + -1].carIndex;

    if (pos < 1) break;

    if (nextCopIndex != -1) {

      if ((nextCarIndex != -1) &&

         (nextCarIndex = AIWorld_ApxSplineDistance(highLevelAIObjs[nextCarIndex]->carObj_,thisCopSlice),

         nextCarIndex * (this->carObj_)->direction >= -0xc0000)) {

        /* oracle: the found/matched path returns 0, not pos -- the raw
           delay-slot "$v0 = $s0" that would set the return to pos is
           reached ONLY on the not-matched fallthrough (which continues
           into the shift/adjust block, so it's dead there); the matched
           branch jumps DIRECTLY to the epilogue restore with $v0 still
           holding the slt-comparison result (0). CORRECTNESS FIX vs
           prior recon (which wrongly returned pos here). */
        return 0;

      }

      this->copVSPositionList_[nextCopIndex] = pos;

    }

    this->copVSPositionList_[copIndex] = pos + -1;

    this->positionVSCopList_[pos].copIndex = this->positionVSCopList_[pos + -1].copIndex;

    this->positionVSCopList_[pos].carIndex = this->positionVSCopList_[pos + -1].carIndex;

    this->positionVSCopList_[pos + -1].copIndex = copIndex;

    this->positionVSCopList_[pos + -1].carIndex = carIndex;

    pos = pos + -1;

  }

  return pos;

}








/* ---- Clear__16AIHigh_BasicPerp  AIHigh_BasicPerp::Clear  [AIH_BASICPERP.CPP:406-415] SLD-VERIFIED ---- */

void AIHigh_BasicPerp::Clear()



{
  int iVar2;



  iVar2 = 0;

  do {

    this->positionVSCopList_[iVar2].copIndex = -1;

    this->positionVSCopList_[iVar2].carIndex = -1;

    iVar2 = iVar2 + 1;

  } while (iVar2 < 6);

  this->pullOverMode_ = 0;

  this->beatingTicksLeft_ = 0;

  this->lastPullOverTime_ = -0x280;

  this->lastArrestingCop_ = (Car_tObj *)0x0;

  return;

}








/* ---- __16AIHigh_BasicPerpP8Car_tObj  AIHigh_BasicPerp::ctor  [AIH_BASICPERP.CPP:419-421] SLD-VERIFIED ---- */
AIHigh_BasicPerp::AIHigh_BasicPerp(Car_tObj *carObj)



{

  (new((AIHigh_Base *)this) AIHigh_Base(carObj));

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_BasicPerp_vtable;

  (this->basicPerpInfo_).copsAssigned_[0] = 0;

  (this->basicPerpInfo_).copsAssigned_[1] = 0;

  (this->basicPerpInfo_).crime_ = 0;

  this->Clear();

  return;

}







/* end of aih_basicperp.cpp */

/* cont.35 B3b: base-forward dtor re-attributed from main.c (�3.23 simple variant);
   oracle = jal ___11AIHigh_Base; extern-C free fn exports the exact symbol. */
extern "C" {
void ___11AIHigh_Base(void *);
void ___16AIHigh_BasicPerp(void *thisp) {
  *(void**)((char*)thisp + 0x14) = (void*)AIHigh_BasicPerp_vtable;
  ___11AIHigh_Base(thisp);
}
}
