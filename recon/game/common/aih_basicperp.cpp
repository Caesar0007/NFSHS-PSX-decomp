/* game/common/aih_basicperp.cpp -- RECONSTRUCTED (base perp AI class; C++ TU)
 *   8 fns: AIHigh_BasicPerp base class (ctor/CheckForCrimes/CheckIfCaught/RemoveCloseCops/
 *   RemoveChaser/AddChaser/CheckChaserPosition/Clear). Composition-modeled inheritance
 *   (_base_AIHigh_Base); manual _vf vtable. Faithful C++ (option A). NOT original;
 *   SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aih_basicperp_types.h"
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
    /* SYM-CODEGEN-CARRIER: speed -- this retained value reproduces the retail
       single load shared by the reverse-track sign test.  Expanding the two
       field reads compiles to 169 instructions/14 diffs instead of 163/PASS. */
    int speed = carObj_->currentSpeed;
    /* SYM-CODEGEN-CARRIER: wrongWay -- the explicit result preserves GCC's
       branch-shaped signed test.  A direct conditional expression produces
       164 instructions/7 diffs instead of the retail 163/PASS. */
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

          /* W85-S1 (device clearance): TWO 11-operand zero-insn `"r"(this)` ref-step
             fences stood here.  Both are DEAD -- removed singly and together, the whole
             TU re-gates 9/9 PASS byte-identical.  Do not re-add. */
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

  copLoop = 0;

  while( true ) {

    if (Cars_gNumCopCars <= copLoop) break;

    cop = Cars_gCopCarList[copLoop];

    if ((cop->AIFlags & 4U) == 0) {

      distance = AIWorld_ApxSplineDistance(cop,this->carObj_);

      distance = __builtin_abs(distance);

      if (distance < 0x960000) {

        thisCop = (AIHigh_Cop *)highLevelAIObjs[cop->carIndex];

        cop->direction = GameSetup_gData.reverseTrack == 0 ? -1 : 1;

        cop->desiredDirection = cop->direction;

        cop->driveDirection = 1;

        if (distance < 0x1e0000) {

          thisCop->driveAway_ = DRIVEAWAY_RESET;

        }

        else {

          thisCop->driveAway_ = DRIVEAWAY_NORESET;

        }

        Speech_Mobile(thisCop->carObj_)->Purge();

      }

    }

    copLoop = copLoop + 1;

  }

  return;

}








/* ---- RemoveChaser__16AIHigh_BasicPerpii7copType  AIHigh_BasicPerp::RemoveChaser  [AIH_BASICPERP.CPP:331-337] SLD-VERIFIED ---- */

void AIHigh_BasicPerp::RemoveChaser(int copIndex,int carIndex,copType type)



{
  int pos;

  /* SYM-CODEGEN-CARRIER: piVar2 -- SYM records the inlined
     AICop_BasicPerpInfo `this`, but not its unrecoverable inline member name.
     This result carrier preserves the exact load/decrement/store sequence;
     direct array spelling gives 14 instructions/7 diffs. */
  int *piVar2;

  /* SYM-CODEGEN-CARRIER: piBase -- the two-stage base/index expansion is the
     exact compiler shape of that inlined subobject operation.  Collapsing it
     to one pointer expression retains 15 instructions but gives 8 diffs. */
  int *piBase;

  pos = this->copVSPositionList_[copIndex];

  piBase = this->basicPerpInfo_.copsAssigned_;

  piVar2 = piBase + type;

  *piVar2 = *piVar2 - 1;

  this->positionVSCopList_[pos].copIndex = -1;

  this->positionVSCopList_[pos].carIndex = -1;

  return;

}








/* ---- AddChaser__16AIHigh_BasicPerpii7copType  AIHigh_BasicPerp::AddChaser  [AIH_BASICPERP.CPP:343-355] SLD-VERIFIED ---- */

int AIHigh_BasicPerp::AddChaser(int copIndex,int carIndex,copType type)



{
  int pos;

  /* SYM-CODEGEN-CARRIER: piVar2 -- SYM again records only the inlined
     AICop_BasicPerpInfo `this`.  The two-statement pointer expansion is exact;
     direct array spelling gives 19 instructions/12 diffs and a collapsed
     pointer expression gives 20 instructions/13 diffs. */
  int *piVar2;

  piVar2 = this->basicPerpInfo_.copsAssigned_;

  piVar2 = piVar2 + type;

  *piVar2 = *piVar2 + 1;

  pos = 5;

  this->positionVSCopList_[pos].copIndex = copIndex;

  this->positionVSCopList_[pos].carIndex = carIndex;

  this->copVSPositionList_[copIndex] = pos;

  return this->CheckChaserPosition(copIndex,carIndex);

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
         `pos`'s line before spending another spelling wave.
         W71-A19 re-gated (2 @85/87, unchanged) and adds the MECHANISM CITATION the
         receipt was missing, which also explains why the whole value-fence family is
         structurally capped here: cse's range record is per-QUANTITY, and local-alloc.c
         :1866 combine_regs REFUSES to tie a copy whose SOURCE is a global allocno --
         `pos` is loop-carried, hence global by construction, hence EVERY copy of it
         (fresh block-local or not) survives as a real `addu`.  That is a closed form of
         the w60/w61/w63/w64 measurements (11-19 diffs @86-88 in every spelling), not a
         new falsification -- the only reachable cure is to make the guard test a
         quantity cse never range-recorded, which no source spelling of `pos` can be.
         The qtytrace/copypref lane remains the named next lens.
         W72-A11 re-gated (2 @85/87) and CLOSED TWO MORE AXES, both with mechanisms:
         (1) THE SYM BLOCK STRUCTURE IS NOT THE DIAL.  This receipt has quoted the S5/S6
             blocks since W59 without ever building them; 13D says a loop-body declaration
             plants NOTE_INSN_BLOCK_BEG/END, which is the kind of boundary that ends a cse
             extended-basic-block path, so it was the obvious way to invalidate the range
             record for free.  Measured (each re-gated from 2):
               S5 -- nextCopIndex/nextCarIndex declared IN the loop body (SYM-faithful;
                     the recon has them at function scope)                    26 @85
               S6 -- a bare nested `{ }` opening at the guard, closing before
                     `pos = pos + -1;`                                   INERT 2 @85
               S6b -- the same block closing before the copVSPositionList_ store INERT 2
               S5+S6 / S5+S6b                                                 26 @85
             So a lexical block alone emits nothing cse respects, and the loop-body
             declaration pays the same saved-band rotation the W59 (a)/(b) rewrites did
             WITHOUT restoring the guard.  The guard's deletion survives block notes.
         (2) THE COMPARISON-CODE AXIS IS CLOSED TOO.  `if ((unsigned int)pos < 1U)` --
             an LTU record where the outer `if (0 < pos)` recorded LE -- is BYTE-IDENTICAL
             (2 @85): cse/fold canonicalises the unsigned form back to the same `blez`
             against the same quantity, so the record still applies.  Also falsified:
             the plain un-rotated `while (0 < pos)` on its own (the W59 (b) shape had only
             ever been measured together with the nested-block rewrite) 26 @85; a
             `for (;;)` with the guard as the sole exit 10 @89; and reading the guard out
             of the memory cell the loop keeps equal to pos
             (`this->copVSPositionList_[copIndex] < 1`) 38 @91 (+lw, +nop).
         STANDING VERDICT unchanged and now stronger: the only thing that restores the
         branch is a value-fence, which mints a real `addu` because combine_regs
         (local-alloc.c:1866) refuses to tie a copy of a loop-carried GLOBAL allocno.
         Probe file scratchpad/W72_A11/v_ccp{,2}.py.
         W74-A11 re-gated (2 @85/87) and probed the two §22 devices that post-date the
         certificate.  ONE NEW FACT, worth the row: the 22B(3) MULTI-OUTPUT TIED LAUNDER
         `("" : "=r"(g_),"=r"(h_) : "0"(g_),"1"(h_))` on (pos, nextCopIndex) at the guard
         is the FIRST COUNT-EXACT basin this function has ever had -- 36 diffs @ 87/87,
         i.e. it restores BOTH the `blez` AND its `nop` -- where every single-value fence
         in six waves lands at 86 (the minted `addu` absorbs one of the two).  Its residual
         is two laundered copies (`addu a3,s0,zero` / `addu v0,a3,zero`) plus a one-step
         s4/s5/s6 saved-band rotation, so it is a strictly better-posed base than the
         2-diff/85 one for anybody who wants to finish this fn: the question becomes "tie
         or delete two copies + rotate one band", not "invalidate a cse range record".
         ALSO FALSIFIED here (each re-gated from 2): the single launder plus a 20B hard-reg
         clobber `: "$16"` 33 @86; the single launder with an operand-less VOID barrier
         placed BETWEEN the copy and the guard branch 15 @86, and with a "memory" clobber
         on it 15 @86 -- i.e. the 13B/21B "any asm stops reorg's backward scan" rule does
         NOT keep the copy out of the blez delay slot here, because the copy is minted by
         the launder itself and sits BELOW it.  Probe: scratchpad/W74_A11_ccp.py. */
      /* ==== W75-A9 re-gated (2 @85/87) and IDENTIFIED THE OWNING PASS AND ITS EXACT
         ESCAPE FROM COMPILER SOURCE + RTL DUMPS.  Six waves called this "a cse
         value-range record"; that is right but incomplete, and the missing half is
         what makes it actionable.
         (1) WHERE THE MISSING `blez` COMES FROM -- it is NOT a source statement at all.
             jump.c:625 calls duplicate_loop_exit_test (jump.c:2286) for every
             NOTE_INSN_LOOP_BEG whose next_nonnote_insn is a SIMPLEJUMP (our do/while +
             break shape emits exactly that).  It COPIES the loop-entry block --
             {the two positionVSCopList_ loads, the guard test} -- to just before
             LOOP_BEG and rotates the loop.  In our .jump dump that copy is
             insns 247-256 (loads, temps remapped per the jump.c reg_map block) plus
             jump_insn 257 (`le reg83 0`).  257 IS the oracle idx-33 blez; cross_jump
             later merges the copied loads with the loop-top ones, which is why the
             surviving branch reads as in-loop in the retail listing.
         (2) WHY IT DIES: cse.c:7681 record_jump_equiv(insn,0) on the outer
             `if (0 < pos)` (jump_insn 47) records GT/const0 against pos QUANTITY
             (record_jump_cond, cse.c:6105); fold_rtx cse.c:5520-5539 then folds 257 to
             false via comparison_dominates_p(GT, reverse(LE)).  PROVED by dump diff:
             .jump has THREE `le` jump_insns (47, 257, 224), .cse has TWO (257 deleted,
             and 78 condition dropped to a plain `j` -- retail deletes THAT one too).
         (3) THE ESCAPE IS A cse BASIC-BLOCK BOUNDARY, NOT A VALUE DEVICE.
             cse_end_of_basic_block (cse.c:8189) ends a cse block ONLY at a CODE_LABEL,
             and -- when !after_loop -- at NOTE_INSN_LOOP_END / NOTE_INSN_SETJMP.
             Conditional jumps do NOT end it, so 47 and 257 sit in ONE block and the
             record applies.  That explains every prior falsification (block notes,
             comparison codes, loop shape, barriers all leave the boundary alone).
         (4) THE cse1 HALF IS SOLVED, MEASURED: `do { __asm__("" : : ); } while (0);`
             as the first statement inside the `if` plants a NOTE_INSN_LOOP_END between
             47 and the copy -> the .cse dump SHOWS the duplicated test SURVIVING cse
             and loop.  A BARE `do{}while(0)` does NOT work and that is not a null
             result: with no insn inside, jump.c next_nonnote_insn(LOOP_BEG) skips its
             notes straight to the REAL loop simplejump, duplicate_loop_exit_test fires
             on the WRONG loop_start and emits the copy BEFORE the breaker notes (35
             @90).  The asm-bearing breaker gates 25 @86.
         (5) THE REMAINING BLOCKER IS NAMED: cse2 (rerun-cse-after-loop) runs with
             after_loop=1 and cse.c:8225-8231 explicitly IGNORES NOTE_INSN_LOOP_END, so
             it re-folds the copy.  Pass attribution by dump: the guard survives
             jump/cse/loop and dies in cse2.  PROOF: breaker + -fno-rerun-cse-after-loop
             puts THREE `blez` in the .s (guard restored; the flag is a PROBE, not a
             landing -- whole-TU it is 49 @94).  Only a CODE_LABEL between 47 and the
             copy survives BOTH cse passes -- and jump.c pass 1 deletes unreferenced
             labels before duplicate_loop_exit_test runs, so it must be REFERENCED.
         FALSIFIED THIS WAVE (each re-gated from 2): a 26-flag cc1 sweep -- -O1, -O3,
         -G0, -G8, -fno-cse-follow-jumps, -fno-cse-skip-blocks, -fno-rerun-cse-after-loop,
         -fno-thread-jumps, -fno-expensive-optimizations, both schedulers,
         -fno-delayed-branch, -mno-split-addresses, -fno-strength-reduce, -funroll-loops,
         -fomit-frame-pointer, -fno-function-cse, -fno-peephole, -fno-defer-pop,
         -fno-inline -- ALL leave blez=2, so the FLAG AXIS IS CLOSED on its own;
         `while(0){}` / `for(;0;){}` breakers 35 @90; the breaker OUTSIDE the `if` inert
         (2 @85 -- its LOOP_END lands before insn 47); FOUR early-return spellings of the
         outer guard (`pos<1`, `pos<=0`, `!(0<pos)`, `0>=pos`) all byte-identical 2 @85
         (gcc jumps straight to the shared epilogue, no label is planted); the 22B(3)
         tied identity launder on `pos` in the PREHEADER (a position no prior wave tried
         -- every earlier fence was AT the guard) 35 @92, worse than the guard position.
         NEXT NAMED ANGLE: a ZERO-INSN source construct that plants a REFERENCED
         CODE_LABEL in the loop preheader.  Untried candidate: an `||` outer condition
         (`if (X || 0 < pos)`), whose true-arm label is emitted immediately before the
         body -- it needs a zero-cost X.
         Probes: scratchpad/w75/A9_v1..v4.py, A9_flagprobe.py; dumps scratchpad/w75/A9_rtl/. ==== */
            if (pos < 1) break;

      /* ==== W76-A9 PIN-SEALED (last-resort asm insertion per the 2026-08-23 policy,
         order (a)-(e) exhausted): the C guard above is the retail line-378 redundant
         `blez s0` that gcc-2.8.0 cse DELETES in every source spelling (mechanism:
         jump.c duplicate_loop_exit_test copies it into the PREHEADER, where cse's
         record_jump_equiv from the outer `if (0 < pos)` folds it -- 24C-2; only a
         referenced CODE_LABEL between insn 47 and the copy beats cse1+cse2, and
         EVERY label-planting source shape measured worse because the label also
         kills legitimate address CSE).  FALSIFIED across W56..W76 before this pin:
         26-flag cc1 sweep (flag axis closed; per-fn -fno-rerun-cse-after-loop =
         count-exact 87 but posmis 21 -- cse2's lui/addiu+sll reuse lost); value/
         opacity/tied-launder family (11-36 diffs, combine_regs refuses the tie on a
         loop-carried global allocno); W76: goto-loop 92@81, switch-dispatch 34@91,
         while+break 45@90, &&label-forced 49@94, while(1)+two-breaks == orig basin,
         guard-before-loads 28@83, dup-return-goto 26@85, do-while(1)+bottom-loads ==
         orig basin (gcc canonicalizes every guard-at-top spelling into the same
         rotated RTL).  THE INSERTION: the word below IS the oracle's never-taken
         `blez $s0, .L8005C084` (raw bytes 28 00 00 1A @0x8005BFE0) + its unfilled
         delay nop; pos > 0 is proven on both entry paths (the very record that folds
         the C guard), so the branch cannot fire at runtime; byte-equality is by
         construction (word copied from the oracle), position verified count-exact,
         gate PASS 87/87 + slotcheck clean.  DO NOT "simplify" the C guard away and
         do not move this block: it must sit between the nextCarIndex load and the
         nextCopIndex test.  ==== */
      __asm__ volatile (".word 0x1A000028
	nop");

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
