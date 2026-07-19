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
  int carLoop;
  Car_tObj*carObj;

  int iVar1;

  BO_tNewtonObj *pBVar2;

  Car_tObj *pCVar3;

  int iVar4;

  Car_tObj **ppCVar5;

  crimeType cVar6;

  crimeType cVar7;

  

  cVar6 = (this->basicPerpInfo_).crime_;

  iVar1 = AISpeeds_GetLegalSpeed((int)((this->carObj_)->N).simRoadInfo.slice);

  if (simGlobal.gameTicks - this->lastPullOverTime_ < 0x280) {

    return;

  }

  pCVar3 = this->carObj_;

  if (1 < (pCVar3->stats).finishType) {

    return;

  }

  cVar7 = cVar6;

  if (((simGlobal.gameTicks - (pCVar3->N).collision.lastTime < 0xf) &&

      (pBVar2 = (pCVar3->N).collision.lastOtherObj, pBVar2 != (BO_tNewtonObj *)0x0)) &&

     ((pBVar2[1].simRoadInfo.quadPts[1].y & 0x20U) != 0)) {

    if ((pCVar3->N).collision.lastImpulse < 0x140001) {

      if (cVar6 == 0) {

        cVar7 = 3;

      }

    }

    else {

      cVar7 = 4;

    }

  }

  if ((cVar6 != 0) && (cVar7 != 4)) {

    return;

  }

  iVar4 = (this->carObj_)->currentSpeed;

  if (iVar1 < 0) {

    iVar1 = -iVar1;

  }

  if (iVar4 < 0) {

    iVar4 = -iVar4;

  }

  if ((iVar1 < iVar4) && (cVar7 == 0)) {

    cVar7 = 1;

  }

  if (AITune_oneWay == 0) {

    pCVar3 = this->carObj_;

    iVar1 = pCVar3->currentSpeed;

    if (iVar1 * AITune_driveSide < 0) {

      if (pCVar3->laneIndex < 7) goto LAB_8005b700;

    }

    else if (6 < pCVar3->laneIndex) goto LAB_8005b700;

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

  if ((0x40000 < iVar1) && (cVar7 == 0)) {

    cVar7 = 2;

  }

LAB_8005b700:

  if (simGlobal.gameTicks < 0x200) {

    cVar7 = 0;

  }

  iVar1 = 0;

  if (cVar7 != 0) {

    ppCVar5 = Cars_gList;

    for (; iVar1 < Cars_gNumCars; iVar1 = iVar1 + 1) {

      if ((((*ppCVar5)->carFlags & 0x220U) != 0) && (((*ppCVar5)->N).active != '\0')) {

        (this->basicPerpInfo_).crime_ = cVar7;

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
  int absSpeed;
  int perpUpright;
  int skill;
  int carLoop;
  Car_tObj*cop;
  int diffSpeed;
  int validCar;
  int distanceAbsMeters;
  int barrierInWay;
  int xDot;
  int zDot;
  coorddef carCopVector;

  u_char bVar1;

  bool bVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int iVar7;

  Car_tObj *pCVar8;

  Car_tObj *pCVar9;

  int iVar10;

  int a;

  int iVar11;

  int iVar12;

  

  iVar3 = GameSetup_gData.skill;

  pCVar9 = this->carObj_;

  if ((pCVar9->carFlags & 2U) == 0) {

    iVar4 = (pCVar9->N).speedXZ;

  }

  else {

    iVar4 = pCVar9->currentSpeed;

    if (iVar4 < 0) {

      iVar4 = -iVar4;

    }

  }

  if ((this->basicPerpInfo_).crime_ != 0) {

    if (AIHigh_BasicPerp_PlayerCaughtSpeed[GameSetup_gData.skill] < iVar4) {

      return 0;

    }

    if (simGlobal.gameTicks - this->lastPullOverTime_ < 0x3c0) {

      return 0;

    }

    pCVar9 = this->carObj_;

    iVar4 = 0;

    if ((pCVar9->stats).finishType < 2) {

      iVar6 = (pCVar9->N).orientMat.m[4];

      do {

        while( true ) {

          if (Cars_gNumCars <= iVar4) {

            return 0;

          }

          pCVar9 = Cars_gList[iVar4];

          bVar2 = false;

          if (((((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&

               ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||

                ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) &&

              ((pCVar9->carFlags & 0x200U) != 0)) ||

             ((((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||

               ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0 &&

                ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0)))))) &&

              ((pCVar9->carFlags & 0x20U) != 0)))) {

            bVar2 = true;

          }

          if (((((bVar2) && ((pCVar9->AIFlags & 2U) != 0)) && ((pCVar9->N).flightTime == 0)) &&

              (((pCVar9->N).active != '\0' && ((pCVar9->AIFlags & 4U) == 0)))) &&

             ((0x9999 < (pCVar9->N).orientMat.m[4] &&

              ((this->carObj_)->currentSpeed - pCVar9->currentSpeed <

               AIHigh_BasicPerp_MinDeltaSpeed[iVar3])))) break;

LAB_8005bd40:

          iVar4 = iVar4 + 1;

        }

        iVar7 = pCVar9->currentSpeed;

        if (iVar7 < 0) {

          iVar7 = -iVar7;

        }

        if (AIHigh_BasicPerp_CopCaughtSpeed[iVar3] <= iVar7) goto LAB_8005bd40;

        iVar11 = (pCVar9->N).position.y;

        iVar10 = ((this->carObj_)->N).position.y;

        iVar7 = iVar11 - iVar10;

        if (iVar7 < 1) {

          iVar7 = iVar10 - iVar11;

        }

        if (AIHigh_BasicPerp_PlayerCaughtDeltaY[iVar3] <= iVar7) goto LAB_8005bd40;

        iVar7 = AIWorld_ApxSplineDistance(this->carObj_,pCVar9);

        if (iVar7 < 0) {

          iVar7 = -iVar7;

        }

        pCVar8 = this->carObj_;

        bVar1 = *(u_char *)((pCVar8->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0x1d);

        iVar10 = pCVar8->laneIndex;

        bVar2 = false;

        if (((int)(7 - (u_int)(bVar1 >> 4)) <= iVar10) && (iVar10 <= (int)((bVar1 & 0xf) + 6))) {

          iVar11 = (int)(pCVar9->N).simRoadInfo.slice;

          bVar1 = *(u_char *)(iVar11 * 0x20 + (int)BWorldSm_slices + 0x1d);

          iVar12 = pCVar9->laneIndex;

          if (((int)(7 - (u_int)(bVar1 >> 4)) <= iVar12) &&

             ((iVar12 <= (int)((bVar1 & 0xf) + 6) &&

              (iVar10 = AIWorld_CheckForBarrierBetweenLanes(iVar11,iVar12,iVar10), iVar10 != 0)))) {

            pCVar8 = this->carObj_;

            iVar10 = AIWorld_CheckForBarrierBetweenLanes((int)(pCVar8->N).simRoadInfo.slice,pCVar9->laneIndex,

                                pCVar8->laneIndex);

            bVar2 = iVar10 != 0;

          }

        }

        if ((AIHigh_BasicPerp_CaughtDistance[iVar3] <= iVar7) || (iVar7 = 0, bVar2))

        goto LAB_8005bd40;

        iVar10 = 0x10000;

        if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&

           ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||

            ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {

          a = (pCVar9->N).position.x - ((this->carObj_)->N).position.x;

          iVar10 = (pCVar9->N).position.y - ((this->carObj_)->N).position.y;

          iVar11 = (pCVar9->N).position.z - ((this->carObj_)->N).position.z;

          iVar12 = fixedmult(a,((this->carObj_)->N).orientMat.m[0]);

          iVar5 = fixedmult(iVar10,((this->carObj_)->N).orientMat.m[1]);

          iVar7 = fixedmult(iVar11,((this->carObj_)->N).orientMat.m[2]);

          iVar7 = iVar12 + iVar5 + iVar7;

          iVar12 = fixedmult(a,((this->carObj_)->N).orientMat.m[6]);

          iVar5 = fixedmult(iVar10,((this->carObj_)->N).orientMat.m[7]);

          iVar10 = fixedmult(iVar11,((this->carObj_)->N).orientMat.m[8]);

          iVar10 = iVar12 + iVar5 + iVar10;

        }

        if ((iVar6 < 0x999a) ||

           ((pCVar9->speed < 0x471c7 && ((this->carObj_)->speed < 0x471c7)))) break;

        if (iVar7 < 0) {

          iVar7 = -iVar7;

        }

        if ((0x8ffff < iVar7) || (iVar10 < 0)) goto LAB_8005bd40;

        iVar4 = iVar4 + 1;

      } while (0x8ffff < iVar10);

      if (this->lastArrestingCop_ == (Car_tObj *)0x0) {

        this->lastArrestingCop_ = pCVar9;

        return 1;

      }

      return 1;

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

  Car_tObj **ppCVar5;



  iVar6 = 0;

  ppCVar5 = Cars_gCopCarList;

  while( true ) {

    if (Cars_gNumCopCars <= iVar6) break;

    carObj = *ppCVar5;

    if ((carObj->AIFlags & 4U) == 0) {

      iVar1 = AIWorld_ApxSplineDistance(carObj,this->carObj_);

      if (iVar1 < 0) {

        iVar1 = -iVar1;

      }

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

    ppCVar5 = ppCVar5 + 1;

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



  thisCopSlice = (highLevelAIObjs[carIndex]->carObj_->N).simRoadInfo.slice;

  pos = this->copVSPositionList_[copIndex];

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
