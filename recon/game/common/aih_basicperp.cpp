/* game/common/aih_basicperp.cpp -- RECONSTRUCTED (base perp AI class; C++ TU)
 *   8 fns: AIHigh_BasicPerp base class (ctor/CheckForCrimes/CheckIfCaught/RemoveCloseCops/
 *   RemoveChaser/AddChaser/CheckChaserPosition/Clear). Real C++ inheritance
 *   (AIHigh_Base); compiler-built vtables. Faithful C++ (option A). NOT original;
 *   SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aih_basicperp_types.h"
#include "aih_basicperp_externs.h"

/* Retail aih_basicperp.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *, const char *, ...);

/* Semantic reconstruction names: retail SYM retains the inlined receiver
   scopes, but not the inline method identifiers. Owner-only bodies in the
   type surface avoid out-of-line copies in the key-function TUs. */

/* ---- aih_basicperp.obj-owned globals (.bss zero) ---- */
int          AIHigh_BasicPerp_PlayerCaughtSpeed[3] = { 1019448, 1165084, 1310720 };   /* @0x8010cd5c */
int          AIHigh_BasicPerp_PlayerCaughtDeltaY[3] = { 327680, 425984, 524288 };   /* @0x8010cd68 */
int          AIHigh_BasicPerp_MinDeltaSpeed[3] = { 582542, 728177, 873813 };   /* @0x8010cd74 */
int          AIHigh_BasicPerp_CopCaughtSpeed[3] = { 728177, 932067, 1165084 };   /* @0x8010cd80 */
int          AIHigh_BasicPerp_CaughtDistance[3] = { 1966080, 2949120, 3932160 };   /* @0x8010cd8c */


/* ---- CheckForCrimes__16AIHigh_BasicPerp [retail AIH_BASICPERP.CPP:43-136;
 * 163/163 byte PASS, native ownership exact, full SLD attribution open] ---- */
/* One-way sign correction: unsigned x + (reverse ? -2*x : 0) selects x/-x
 * modulo2^32 without a captured speed object. The first x is expanded before
 * the condition; CSE reuses it and combine reduces x-2*x to -x. This preserves
 * retail's common input/sign-result funnel, unlike the direct conditional
 * field reads (169/163). All seven local records/all11 native regions match.
 * This spelling is a verified source representation, not uniquely recovered
 * original macro text; do not silently simplify it without re-gating. */

#line 38 "C:/nfs4/GAME/COMMON/AIH_BASICPERP.CPP"
void AIHigh_BasicPerp::CheckForCrimes()




{ crimeType crime = basicPerpInfo_.GetCrime(); crimeType originalCrime = crime;


  int legal = AISpeeds_GetLegalSpeed(carObj_->N.simRoadInfo.slice);










  if (simGlobal.gameTicks - lastPullOverTime_ < 0x280) return; if (carObj_->stats.finishType >= 2) return; if ((simGlobal.gameTicks - carObj_->N.collision.lastTime < 15) && (carObj_->N.collision.lastOtherObj != 0) &&





      (((Car_tObj *)carObj_->N.collision.lastOtherObj)->carFlags & 0x20)) {

    if (carObj_->N.collision.lastImpulse > 0x140000)

      crime = CRIME_SMASHCOP;

    else if (crime == CRIME_NONE)

      crime = CRIME_BUMPCOP; }




  if ((originalCrime != CRIME_NONE) && (crime != CRIME_SMASHCOP)) return; if ((__builtin_abs(carObj_->currentSpeed) > __builtin_abs(legal)) &&





      (crime == CRIME_NONE))

    crime = CRIME_SPEEDER;




  if (AITune_oneWay != 0) { switch (((u_int)carObj_->currentSpeed + (GameSetup_gData[12] /* reverseTrack */ != 0

             ? -2U * (u_int)carObj_->currentSpeed : 0U)) >> 31) { case 0: break; default: if ((__builtin_abs(carObj_->currentSpeed) > 0x40000) && (crime == CRIME_NONE))

        crime = CRIME_WRONGSIDE; } } else {




    if ((carObj_->currentSpeed * AITune_driveSide) >= 0) { if ((carObj_->laneIndex < 7) && (__builtin_abs(carObj_->currentSpeed) > 0x40000) &&

          (crime == CRIME_NONE))

        crime = CRIME_WRONGSIDE; } else { if ((carObj_->laneIndex >= 7) && (__builtin_abs(carObj_->currentSpeed) > 0x40000) &&




          (crime == CRIME_NONE))

        crime = CRIME_WRONGSIDE; } }





  if (simGlobal.gameTicks < 0x200)

    crime = CRIME_NONE;


  if (crime != CRIME_NONE)
  { int carLoop;



    for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {

      Car_tObj *carObj = Cars_gList[carLoop];
      if ((carObj->carFlags & 0x220) && carObj->N.active) { basicPerpInfo_.SetCrime(crime);


        return; }

    } }

  return;
}








/* ---- CheckIfCaught__16AIHigh_BasicPerp [retail AIH_BASICPERP.CPP:180-289;
 * native ownership exact, full SLD attribution open] ----
 * MATCH: 380/380 instructions without allocation fences. Direct laneCount
 * expressions replace the old barrier-byte/lane captures. For-owned carLoop,
 * the complete eligibility guard, and the positive distance/barrier guard
 * restore all13 local records and all12 retail scope regions. The old fence
 * necessity receipt no longer describes this source. not_caught is an
 * inferred shared-fallback label; its literal original spelling is unknown. */

#line 175 "C:/nfs4/GAME/COMMON/AIH_BASICPERP.CPP"
int AIHigh_BasicPerp::CheckIfCaught()




{ int absSpeed; int perpUpright; int skill;


  skill = GameSetup_gData[2] /* skill */;


  if ((this->carObj_->carFlags & 2U) != 0) {
    absSpeed = __builtin_abs(this->carObj_->currentSpeed); } else {

    absSpeed = this->carObj_->N.speedXZ; }



  if (this->basicPerpInfo_.GetCrime() == 0)
    return 0;

    if (AIHigh_BasicPerp_PlayerCaughtSpeed[skill] < absSpeed) { return 0; }



    if (simGlobal.gameTicks - this->lastPullOverTime_ < 0x3c0) { return 0; } if ((this->carObj_->stats).finishType >= 2) goto not_caught;





      perpUpright = 0x9999 < this->carObj_->N.orientMat.m[4];


      for (int carLoop = 0; ; carLoop = carLoop + 1) { Car_tObj *cop; int diffSpeed; int validCar; if (Cars_gNumCars <= carLoop) { return 0; }

        cop = Cars_gList[carLoop];
        diffSpeed = this->carObj_->currentSpeed - cop->currentSpeed; validCar = 0; if (((((GameSetup_gData[0] /* raceType */ == RaceType_HotPursuit) || (GameSetup_gData[0] /* raceType */ == RaceType_Id5)) && (((Cars_gHumanRaceCarList[0]->carFlags & 0x200) != 0 || ((Cars_gNumHumanRaceCars == 2 && ((Cars_gHumanRaceCarList[1]->carFlags & 0x200) != 0))))))



            && ((cop->carFlags & 0x200U) != 0)))
          validCar = 1;
        else if (((((GameSetup_gData[0] /* raceType */ != RaceType_HotPursuit && (GameSetup_gData[0] /* raceType */ != RaceType_Id5)) || (((Cars_gHumanRaceCarList[0]->carFlags & 0x200) == 0 && ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200) == 0)))))) && ((cop->carFlags & 0x20U) != 0)))) {
          validCar = 1; }
















        if ((validCar != 0) && (((((cop->AIFlags & 2U) != 0) && ((cop->N).flightTime == 0)) && (((cop->N).active != '\0' && ((cop->AIFlags & 4U) == 0)))) && ((0x9999 < (cop->N).orientMat.m[4] && (diffSpeed < AIHigh_BasicPerp_MinDeltaSpeed[skill])))) && (__builtin_abs(cop->currentSpeed) < AIHigh_BasicPerp_CopCaughtSpeed[skill]) && ((cop->N.position.y - carObj_->N.position.y > 0 ? cop->N.position.y - carObj_->N.position.y : carObj_->N.position.y - cop->N.position.y) <








              AIHigh_BasicPerp_PlayerCaughtDeltaY[skill]))
        { int distanceAbsMeters; int barrierInWay;
          const int distanceMeters = AIWorld_ApxSplineDistance(this->carObj_,cop); barrierInWay = 0; /* DEVICE (exact-only): record-less const temp = retail call@67 / abs@68 split (PHYS5 law) */
          distanceAbsMeters = __builtin_abs(distanceMeters);

            if (((int)(7 - (u_int)(BWorldSm_slices[(this->carObj_->N).simRoadInfo.slice].laneCount >> 4)) <= this->carObj_->laneIndex) && (this->carObj_->laneIndex <= (int)((BWorldSm_slices[(this->carObj_->N).simRoadInfo.slice].laneCount & 0xf) + 6)) && ((int)(7 - (u_int)(BWorldSm_slices[(cop->N).simRoadInfo.slice].laneCount >> 4)) <= cop->laneIndex) && (cop->laneIndex <= (int)((BWorldSm_slices[(cop->N).simRoadInfo.slice].laneCount & 0xf) + 6)))
            if (AIWorld_CheckForBarrierBetweenLanes((int)(cop->N).simRoadInfo.slice, cop->laneIndex,this->carObj_->laneIndex) != 0) { barrierInWay = AIWorld_CheckForBarrierBetweenLanes((int)(this->carObj_->N).simRoadInfo.slice, cop->laneIndex,this->carObj_->laneIndex) != 0; }


            if ((distanceAbsMeters < AIHigh_BasicPerp_CaughtDistance[skill]) && (barrierInWay == 0))
            { int xDot; int zDot;

              xDot = 0; zDot = 0x10000; if (((GameSetup_gData[0] /* raceType */ == RaceType_HotPursuit) || (GameSetup_gData[0] /* raceType */ == RaceType_Id5)) && (((Cars_gHumanRaceCarList[0]->carFlags & 0x200) != 0 ||


              ((Cars_gNumHumanRaceCars == 2 && ((Cars_gHumanRaceCarList[1]->carFlags & 0x200) != 0))))))
              { coorddef carCopVector;

            carCopVector.x = (cop->N).position.x - ((this->carObj_)->N).position.x; carCopVector.y = (cop->N).position.y - ((this->carObj_)->N).position.y; carCopVector.z = (cop->N).position.z - ((this->carObj_)->N).position.z; xDot = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[0]) + fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[1]) +
                   fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[2]); zDot = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[6]) + fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[7]) +
                   fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[8]); } if ((!perpUpright) ||








             ((cop->speed < 0x471c7 && ((this->carObj_)->speed < 0x471c7)))) { if (this->lastArrestingCop_ == (Car_tObj *)0x0) { this->lastArrestingCop_ = cop; } return 1; } if (0x8ffff < __builtin_abs(xDot)) continue; if (zDot < 0) continue; if (0x8ffff < zDot) continue;







          if (this->lastArrestingCop_ == (Car_tObj *)0x0) { this->lastArrestingCop_ = cop; }
          return 1; } }




      } not_caught:
  return 0; }








/* ---- RemoveCloseCops__16AIHigh_BasicPerp  AIHigh_BasicPerp::RemoveCloseCops
 * [AIH_BASICPERP.CPP:296-325] ---- */
/* Retail SYM scopes the channel loop, its cop/distance pair, and the two
   inlined drive-away setters plus base car accessor. Inline names are inferred;
   their receiver types/homes and exact block addresses come from retail.
   A for/continue source removes the unsupported nextCop LABEL and restores
   the native scope tree at 84/84 bytes. The tail's relative SLD lines still
   differ at 13 instructions; complete statement attribution remains open. */


#line 295 "C:/nfs4/GAME/COMMON/AIH_BASICPERP.CPP"
void AIHigh_BasicPerp::RemoveCloseCops()
{
  for (int copLoop = 0; copLoop < Cars_gNumCopCars; copLoop++) {

    Car_tObj *cop = Cars_gCopCarList[copLoop]; int distance;

    if ((cop->AIFlags & 4U) != 0) continue;

    distance = AIWorld_ApxSplineDistance(cop,this->carObj_);
    distance = __builtin_abs(distance);

    if (distance < 0x960000)
    {
      AIHigh_Cop *thisCop = (AIHigh_Cop *)highLevelAIObjs[cop->carIndex];

      cop->desiredDirection = cop->direction = GameSetup_gData[12] /* reverseTrack */ == 0 ? -1 : 1; cop->driveDirection = 1;


      if (distance < 0x1e0000)
      { thisCop->SetDriveAway(DRIVEAWAY_RESET); }

      else { thisCop->SetDriveAway(DRIVEAWAY_NORESET); }

      Speech::Mobile(thisCop->GetCarObj())->Purge(); }



    else {}


  } }








/* ---- RemoveChaser__16AIHigh_BasicPerpii7copType  AIHigh_BasicPerp::RemoveChaser  [AIH_BASICPERP.CPP:331-337] SLD-VERIFIED ---- */


#line 330 "C:/nfs4/GAME/COMMON/AIH_BASICPERP.CPP"
void AIHigh_BasicPerp::RemoveChaser(int copIndex,int carIndex,copType type)
{
  int pos = this->copVSPositionList_[copIndex];
  this->basicPerpInfo_.RemoveCop(type);


  this->positionVSCopList_[pos].copIndex = -1;
  this->positionVSCopList_[pos].carIndex = -1;
}








/* ---- AddChaser__16AIHigh_BasicPerpii7copType  AIHigh_BasicPerp::AddChaser  [AIH_BASICPERP.CPP:343-355] SLD-VERIFIED ---- */

#line 338 "C:/nfs4/GAME/COMMON/AIH_BASICPERP.CPP"
int AIHigh_BasicPerp::AddChaser(int copIndex,int carIndex,copType type)




{
  int pos;

  this->basicPerpInfo_.AddCop(type);


  pos = 5;
  this->positionVSCopList_[pos].copIndex = copIndex;
  this->positionVSCopList_[pos].carIndex = carIndex;
  this->copVSPositionList_[copIndex] = pos;

  int result = this->CheckChaserPosition(copIndex,carIndex);
  return result;
}








/* ---- CheckChaserPosition__16AIHigh_BasicPerpii  AIHigh_BasicPerp::CheckChaserPosition  [AIH_BASICPERP.CPP:359-400] SLD-VERIFIED ---- */

/* BYTE+SYM+SLD EXACT (GAME9 2026-11-07; the .word blez pin is gone): retail = `if (0 < pos) { decls+loads;
   while (pos >= 1 && (.. || GetCarObj distance < K)) { ...; if (pos <= 0) break; reloads } }`. The while
   cond-scope (kept: GetCarObj nest) blocks expand_end_loop rotation -> top-tested loop whose top label
   keeps the redundant `pos >= 1` blez out of cse reach; the bottom reloads cross-jump (jump2) with the
   pre-loop loads -> `v0 = pos-1; j <loads>`. The W56..W76 receipts are superseded. */
#line 354 "C:/nfs4/GAME/COMMON/AIH_BASICPERP.CPP"
int AIHigh_BasicPerp::CheckChaserPosition(int copIndex,int carIndex)




{ int pos; int thisCopSlice;


  pos = this->copVSPositionList_[copIndex];

  thisCopSlice = (highLevelAIObjs[carIndex]->GetCarObj()->N).simRoadInfo.slice;





  if (0 < pos)
  {

      int nextCopIndex = this->positionVSCopList_[pos + -1].copIndex;
      int nextCarIndex = this->positionVSCopList_[pos + -1].carIndex;


      while (
             pos >= 1 && (nextCopIndex == -1 || nextCarIndex == -1 || AIWorld_ApxSplineDistance(highLevelAIObjs[nextCarIndex]->GetCarObj(), thisCopSlice) * (this->carObj_)->direction < -0xc0000))
      {


        if (nextCopIndex != -1) this->copVSPositionList_[nextCopIndex] = pos;

      this->copVSPositionList_[copIndex] = pos + -1;

      this->positionVSCopList_[pos].copIndex = this->positionVSCopList_[pos + -1].copIndex;
      this->positionVSCopList_[pos].carIndex = this->positionVSCopList_[pos + -1].carIndex;

      this->positionVSCopList_[pos + -1].copIndex = copIndex; this->positionVSCopList_[pos + -1].carIndex = carIndex;

      pos = pos + -1;
      if (pos <= 0) break;

      nextCopIndex = this->positionVSCopList_[pos + -1].copIndex;
      nextCarIndex = this->positionVSCopList_[pos + -1].carIndex;
  } }



  return pos; }








/* ---- Clear__16AIHigh_BasicPerp  AIHigh_BasicPerp::Clear  [AIH_BASICPERP.CPP:406-415] SLD-VERIFIED ---- */
/* Retail SYM scopes `loop` to the for statement (source lines 2..6). */

#line 405 "C:/nfs4/GAME/COMMON/AIH_BASICPERP.CPP"
void AIHigh_BasicPerp::Clear()
{
  for (int loop = 0; loop < 6; loop++) {

    this->positionVSCopList_[loop].copIndex = -1;
    this->positionVSCopList_[loop].carIndex = -1;
  }
  this->pullOverMode_ = 0;
  this->beatingTicksLeft_ = 0;
  this->lastPullOverTime_ = -0x280;
  this->lastArrestingCop_ = (Car_tObj *)0x0;
}




















/* ---- __16AIHigh_BasicPerpP8Car_tObj [retail AIH_BASICPERP.CPP:419-421;
 * 18/18 byte PASS, native+SLD exact] ---- */
/* basicPerpInfo_ default construction owns the pre-body inline/reset tree.
 * The body only clears the high-level state; reset-helper names are inferred. */

#line 419 "C:/nfs4/GAME/COMMON/AIH_BASICPERP.CPP"
AIHigh_BasicPerp::AIHigh_BasicPerp(Car_tObj *carObj) : AIHigh_Base(carObj)
{
  this->Clear();
}







/* end of aih_basicperp.cpp */

