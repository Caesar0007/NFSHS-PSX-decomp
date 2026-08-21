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
  crimeType crime = basicPerpInfo_.crime_;
  crimeType originalCrime = crime;
  int legal = AISpeeds_GetLegalSpeed(carObj_->N.simRoadInfo.slice);

  if (simGlobal.gameTicks - lastPullOverTime_ < 0x280)
    return;

  if (carObj_->stats.finishType >= 2)
    return;

  if ((simGlobal.gameTicks - carObj_->N.collision.lastTime < 15) &&
      (carObj_->N.collision.lastOtherObj != 0) &&
      (((Car_tObj *)carObj_->N.collision.lastOtherObj)->carFlags & 0x20)) {
    if (carObj_->N.collision.lastImpulse > 0x140000)
      crime = CRIME_SMASHCOP;
    else if (crime == CRIME_NONE)
      crime = CRIME_BUMPCOP;
  }

  if ((originalCrime != CRIME_NONE) && (crime != CRIME_SMASHCOP))
    return;

  if ((__builtin_abs(carObj_->currentSpeed) > __builtin_abs(legal)) &&
      (crime == CRIME_NONE))
    crime = CRIME_SPEEDER;

  if (AITune_oneWay != 0) {
    int speed = carObj_->currentSpeed;
    int wrongWay;
    if (GameSetup_gData.reverseTrack != 0)
      wrongWay = (u_int)-speed >> 31;
    else
      wrongWay = (u_int)speed >> 31;
    if (wrongWay != 0) {
      if ((__builtin_abs(carObj_->currentSpeed) > 0x40000) &&
          (crime == CRIME_NONE))
        crime = CRIME_WRONGSIDE;
    }
  } else {
    int speed = carObj_->currentSpeed;
    if ((speed * AITune_driveSide) >= 0) {
      if (carObj_->laneIndex >= 7)
        goto crime_checks_done;
    } else if (carObj_->laneIndex < 7) {
      goto crime_checks_done;
    }
    if ((__builtin_abs(speed) > 0x40000) && (crime == CRIME_NONE))
      crime = CRIME_WRONGSIDE;
  }

crime_checks_done:
  if (simGlobal.gameTicks < 0x200)
    crime = CRIME_NONE;

  if (crime != CRIME_NONE) {
    int carLoop;
    for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
      Car_tObj *carObj = Cars_gList[carLoop];
      if ((carObj->carFlags & 0x220) && carObj->N.active) {
        basicPerpInfo_.crime_ = crime;
        return;
      }
    }
  }
}








/* ---- CheckIfCaught__16AIHigh_BasicPerp  AIHigh_BasicPerp::CheckIfCaught  [AIH_BASICPERP.CPP:180-289] SLD-VERIFIED ----
 * MATCH RECEIPT: SYM lists no barrier-byte/lane temporaries, so the direct
 * Trk_NewSlice::laneCount expressions below replace four decompiler-invented
 * locals and recover retail's $a0/$v1 byte handout.  SLD line 274 is a single
 * abs(xDot) threshold, not a destructive two-statement absolute value.
 * Two zero-insn xDot references buy its refs 6->8 allocator boundary.  Moving
 * xDot=0 to its SLD block then shortens it enough to outrank `this`; eleven
 * loop-weighted `this` references buy p80 refs 43->65, crossing the 64-ref
 * floor_log2 boundary and restoring this=$s3/xDot=$s4.  Fence placement before
 * the barrier branch preserves xDot=0 in its retail delay slot.
 * Measured path: 37 -> 13 -> 4 -> 1 -> PASS (380/380). */

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

        diffSpeed = this->carObj_->currentSpeed - cop->currentSpeed;

        validCar = 0;

        if (((((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) &&

             ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||

              ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) &&

            ((cop->carFlags & 0x200U) != 0)) ||

           ((((GameSetup_gData.raceType != RaceType_HotPursuit && (GameSetup_gData.raceType != RaceType_Id5)) ||

             ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0 &&

              ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) == 0)))))) &&

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

          if (__builtin_abs(cop->currentSpeed) >=
              AIHigh_BasicPerp_CopCaughtSpeed[skill]) continue;

          if ((cop->N.position.y - carObj_->N.position.y > 0
                   ? cop->N.position.y - carObj_->N.position.y
                   : carObj_->N.position.y - cop->N.position.y) <
              AIHigh_BasicPerp_PlayerCaughtDeltaY[skill]) {
          } else {
            continue;
          }

          distanceAbsMeters = __builtin_abs(AIWorld_ApxSplineDistance(this->carObj_,cop));

          barrierInWay = 0;

          if (((int)(7 - (u_int)(BWorldSm_slices[(this->carObj_->N).simRoadInfo.slice].laneCount >> 4))
                    <= this->carObj_->laneIndex) &&
              (this->carObj_->laneIndex <=
                    (int)((BWorldSm_slices[(this->carObj_->N).simRoadInfo.slice].laneCount & 0xf) + 6)) &&
              ((int)(7 - (u_int)(BWorldSm_slices[(cop->N).simRoadInfo.slice].laneCount >> 4))
                    <= cop->laneIndex) &&
              (cop->laneIndex <=
                    (int)((BWorldSm_slices[(cop->N).simRoadInfo.slice].laneCount & 0xf) + 6)) &&
              (AIWorld_CheckForBarrierBetweenLanes((int)(cop->N).simRoadInfo.slice,
                    cop->laneIndex,this->carObj_->laneIndex) != 0)) {

            barrierInWay =
                AIWorld_CheckForBarrierBetweenLanes((int)(this->carObj_->N).simRoadInfo.slice,
                    cop->laneIndex,this->carObj_->laneIndex) != 0;

          }

          if (AIHigh_BasicPerp_CaughtDistance[skill] <= distanceAbsMeters) continue;

          __asm__("" : : "r"(this), "r"(this), "r"(this),
                          "r"(this), "r"(this), "r"(this));
          __asm__("" : : "r"(this), "r"(this), "r"(this),
                          "r"(this), "r"(this));
          if (barrierInWay) continue;

          {
          int zDot;

          xDot = 0;
          zDot = 0x10000;

          if (((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) &&

             ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||

              ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {

            coorddef carCopVector;

            carCopVector.x = (cop->N).position.x - ((this->carObj_)->N).position.x;

            carCopVector.y = (cop->N).position.y - ((this->carObj_)->N).position.y;

            carCopVector.z = (cop->N).position.z - ((this->carObj_)->N).position.z;

            xDot = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[0]) +
                   fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[1]) +
                   fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[2]);

            zDot = fixedmult(carCopVector.x,((this->carObj_)->N).orientMat.m[6]) +
                   fixedmult(carCopVector.y,((this->carObj_)->N).orientMat.m[7]) +
                   fixedmult(carCopVector.z,((this->carObj_)->N).orientMat.m[8]);

          }

          if ((!perpUpright) ||

             ((cop->speed < 0x471c7 && ((this->carObj_)->speed < 0x471c7)))) {

            if (this->lastArrestingCop_ == (Car_tObj *)0x0) {

              this->lastArrestingCop_ = cop;

            }

            return 1;

          }

          __asm__("" : : "r"(xDot), "r"(xDot));
          if (0x8ffff < __builtin_abs(xDot)) continue;

          if (zDot < 0) continue;

          if (0x8ffff < zDot) continue;
          }

          if (this->lastArrestingCop_ == (Car_tObj *)0x0) {

            this->lastArrestingCop_ = cop;

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

  piVar2 = this->basicPerpInfo_.copsAssigned_;

  piVar2 = piVar2 + type;

  *piVar2 = *piVar2 + 1;

  pos = 5;

  this->positionVSCopList_[pos].copIndex = copIndex;

  this->positionVSCopList_[pos].carIndex = carIndex;

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

  if (0 < pos) {
    do {
      nextCopIndex = this->positionVSCopList_[pos + -1].copIndex;

      nextCarIndex = this->positionVSCopList_[pos + -1].carIndex;

      /* NEAR-MISS 2 diffs (85/87): retail keeps a defensive `blez s0` (this
         `if(pos<1)break;`, the 2nd of 3 pos<=0 guards) that our build's
         cse/jump.c deletes -- it proves pos>0 from the outer `if(0<pos)` +
         `while(0<pos)`.  W56-A16 FALSIFIED: identity-fence `("":"=r"(pos):
         "0"(pos))` here forces a real copy on the cross-block pseudo pos
         (regress 2->34, +6 callee-saved shuffle); per-fn -fno-thread-jumps
         splice is INERT (probed via monkeypatched build.py: still 85/87) --
         the deletion is a cse/redundant-branch pass, not thread_jumps.  Needs
         a value-range-opaque cse-invalidation the fence toolkit lacks.
         W59-A3 SYM CONFIRMS THE SHAPE and adds two falsifications: the 8c block
         set is {S5 lines 372-396 = the loop body, declaring nextCopIndex+nextCarIndex;
         S6 lines 378-395 = a nested block whose FIRST insn IS the missing blez;
         S7/S8 line 379 = the inlined AIHigh_Base method}, and the SLD puts the blez
         at line 378 -- so retail really did write a redundant pos guard there.
         FALSIFIED (each re-gated): (a) the guard as a positive nested block
         `if (0 < pos) { ...rest of body... }` instead of `break` -> 26 diffs, still
         85 insns (guard STILL deleted) + an s4/s5/s6 saved-band rotation; (b) the
         same with the loop UN-ROTATED to `while (0 < pos) { ... }` (no outer if, no
         do/while) -> the identical 26-diff basin.  So the deletion is independent of
         both the loop shape and break-vs-if, and the extra lexical block alone costs
         the band -- only a cse-invalidating device can restore the branch.
         W60-A8 r2 refuted the "no device exists" half: an OPACITY fence on a fresh
         BLOCK-LOCAL copy of pos DOES restore the guard (15 diffs/86; +`pos = p;`
         11/86), the blocker being that pos is a GLOBAL allocno so combine_regs
         refuses to tie the copy (a real addu).
         W61-A12 FALSIFIED that receipt's own "next, untried" step -- carrying the
         OPAQUE COPY THROUGH THE WHOLE LOOP BODY (every positionVSCopList_ index,
         the guard, the copVSPositionList_ stores and `pos = p + -1` at the bottom):
         fence at the loop TOP -> 19 diffs / 88 insns, fence at the GUARD -> 19 / 88,
         and declaring p at FUNCTION scope -> 50 / 95 (LICM hoists it, +1 saved reg).
         All three keep the guard but pay the same `addu s0,a1,zero` copy plus a
         `bnez`/`j` tail-polarity flip: making p the loop's live value does NOT
         dissolve the copy, because the copy is minted at the fence, not at the use.
         Next lens = local-alloc combine_regs (dies-more-than-once refusal), not a
         source spelling.
         W63-A12 re-gated (2 @ 85/87) and FALSIFIED the one device class the four prior
         waves had NOT tried here: the OPERAND-LESS VOID-TAIL FENCE
         `__asm__("" : : "i"(0));` immediately above the guard.  The rationale was that
         every previous attempt fenced a VALUE (`pos`, or a copy of it) and therefore
         minted the `addu` copy that ruins the count -- an operand-less fence adds no
         ref and can mint no copy, so if the guard's deletion were a pure cse/jump
         barrier question this would restore it for free.  It does NOT: 35 diffs @ 90
         insns (+5).  So the deletion is not reachable by a barrier either, and the
         value-fence family remains the only thing that restores the branch (at the
         price of the copy, because `pos` is a GLOBAL allocno and combine_regs refuses
         to tie a copy whose destination is global).  That leaves exactly one named
         lever untried: make `pos` BLOCK-LOCAL at the guard rather than fencing it --
         i.e. a local-alloc-layer change, which is the qtytrace lane.
         W64-A12 re-gated (2 @ 85/87, unchanged) and adds one NEGATIVE + one POSITIVE
         pointer.  NEGATIVE: the w64 "m"-CONSTRAINT FENCE (the zero-insn device that
         sealed AIPhysic_CheckDesiredDirection this session) does NOT apply here -- it
         buys an extra MEMORY reference off a live %hi pseudo, and this residual is a
         cse VALUE-RANGE record on a REGISTER quantity (cse.c qty_comparison_code /
         _const: the `blez` fall-through records "pos > 0" against pos's qty, and the
         second identical compare against the same constant is then folded).  No memory
         device can invalidate a register qty record; only giving the guard a DIFFERENT
         qty can, which is what the value-fence family does -- at the price of the copy.
         POSITIVE: the qtytrace/local-alloc lane this receipt has been parked on since
         w60 EXISTS as of this wave -- w64-a10's scratchpad/w64a10/{dump.py,copypref.py}
         prints local-alloc ELIGIBILITY directly (local-alloc.c:470-477: a pseudo is
         block-local iff REG_BASIC_BLOCK >= 0 AND REG_N_DEATHS == 1).  That is exactly
         the bit this fn turns on: `pos` fails it, so combine_regs (:1866) refuses to tie
         the opaque copy and it stays a real `addu`.  Run copypref on this TU and read
         `pos`'s line before spending another spelling wave. */
            if (pos < 1) break;

      if (nextCopIndex != -1) {

        if (nextCarIndex != -1) {
          nextCarIndex =
              AIWorld_ApxSplineDistance(highLevelAIObjs[nextCarIndex]->carObj_,
                                        thisCopSlice);

          if (nextCarIndex * (this->carObj_)->direction >= -0xc0000) {
            return pos;
          }

        }

        this->copVSPositionList_[nextCopIndex] = pos;

      }

      this->copVSPositionList_[copIndex] = pos + -1;

      this->positionVSCopList_[pos].copIndex = this->positionVSCopList_[pos + -1].copIndex;

      this->positionVSCopList_[pos].carIndex = this->positionVSCopList_[pos + -1].carIndex;

      this->positionVSCopList_[pos + -1].copIndex = copIndex;

      this->positionVSCopList_[pos + -1].carIndex = carIndex;

      pos = pos + -1;
    } while (0 < pos);
  }

  return pos;

}








/* ---- Clear__16AIHigh_BasicPerp  AIHigh_BasicPerp::Clear  [AIH_BASICPERP.CPP:406-415] SLD-VERIFIED ---- */

void AIHigh_BasicPerp::Clear()



{
  int loop;



  loop = 0;

  do {

    this->positionVSCopList_[loop].copIndex = -1;

    this->positionVSCopList_[loop].carIndex = -1;

    loop = loop + 1;

  } while (loop < 6);

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
