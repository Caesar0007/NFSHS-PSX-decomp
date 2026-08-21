/* game/psx/stats.cpp -- RECONSTRUCTED (NFS4 PSX race statistics; C++ TU)
 *   7 fns: Stats_DoPlayerGlue/ClearPosition/GetPosition/GetNumOpponents/TrackStats/
 *   ExtrapolateOpponentTimes/TrackEndGame. GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "stats_externs.h"

/* stats.obj-owned race-order scratch table.
 * SYM: EXT Stats_tPosition[6], 96 bytes at 0x8011E0E0.  The retail image is
 * entirely zero-initialized, and CC1PLPSX emits this tentative aggregate in
 * .data; the reconstruction linker substitutes it for only that residual run. */
Stats_tPosition Stats_racePosition[6];

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Stats_DoPlayerGlue(void);
void Stats_ClearPosition(void);
int Stats_GetPosition(Car_tObj *carObj);
int Stats_GetNumOpponents(void);
void Stats_TrackStats(Car_tObj *carObj);
void Stats_ExtrapolateOpponentTimes(int type);
void Stats_TrackEndGame(void);


/* ---- Stats_DoPlayerGlue__Fv  [STATS.CPP:52-107] SLD-VERIFIED ---- */
void Stats_DoPlayerGlue(void)

{
  int i;
  int dist;
  int humanLeader;

  humanLeader = 99;
  for (i = 0; i < Cars_gNumRaceCars; i++) {
    Cars_gRaceCarList[i]->stats.position =
        Stats_GetPosition(Cars_gRaceCarList[i]);
    if ((Stats_racePosition[i].isHuman != 0) && (humanLeader == 99)) {
      humanLeader = i;
    }
  }

  if ((GameSetup_gData.catchupLogic != 0) && (GameSetup_gData.commMode == 1)) {
    if (((Cars_gHumanRaceCarList[0]->stats).finishType == 2) ||
       ((Cars_gHumanRaceCarList[1]->stats).finishType == 2)) {
      Cars_gHumanRaceCarList[0]->glue = 0x10000;
      Cars_gHumanRaceCarList[1]->glue = 0x10000;
    }
    else {
      for (i = 0; i < Cars_gNumHumanRaceCars; i++) {
        dist = Stats_racePosition[humanLeader].slice -
               Cars_gHumanRaceCarList[i]->stats.sliceTotal;
        if (dist < 5) {
          Cars_gHumanRaceCarList[i]->glue = 0x10000;
        }
        else {
          if (dist < 10) {
            Cars_gHumanRaceCarList[i]->glue = 0x10666;
          }
          else if (dist < 30) {
            Cars_gHumanRaceCarList[i]->glue = 0x10ccc;
          }
          else if (dist < 60) {
            Cars_gHumanRaceCarList[i]->glue = 0x11333;
          }
          else {
            Cars_gHumanRaceCarList[i]->glue = 0x11999;
          }
        }
      }
    }
  }
}

/* ---- Stats_ClearPosition__Fv  [STATS.CPP:112-120] SLD-VERIFIED ---- */
void Stats_ClearPosition(void)

{
  int i;

  i = 0;
  do {
    Stats_racePosition[i].car = -1;
    Stats_racePosition[i].slice = -99999;
    Stats_racePosition[i].sliceTime = 0;
    Stats_racePosition[i].isHuman = 0;
    i = i + 1;
  } while (i < 6);
  return;
}

/* ---- Stats_GetPosition__FP8Car_tObj  [STATS.CPP:126-139] SLD-VERIFIED ---- */
int Stats_GetPosition(Car_tObj *carObj)

{
  int position;
  int carindex;

  position = 0;
  carindex = carObj->carIndex;
  {
    int i;

    for (i = 0; i < Cars_gNumRaceCars; i++) {
      if (Stats_racePosition[i].car == carindex) {
        position = i + 1;
        break;
      }
    }
  }
  return position;
}

/* ---- Stats_GetNumOpponents__Fv  [STATS.CPP:145-155] SLD-VERIFIED ---- */
int Stats_GetNumOpponents(void)

{
  int i;
  int numCars;
  
  numCars = 0;
  for (i = 0; i < Cars_gNumRaceCars; i++) {
    if (Stats_racePosition[i].car != -1) {
      numCars = numCars + 1;
    }
  }
  return numCars;
}

/* ---- Stats_TrackStats__FP8Car_tObj  [STATS.CPP:161-273] SLD-VERIFIED ---- */
void Stats_TrackStats(Car_tObj *carObj)

{
  if ((simGlobal.gameTicks & 1U) == 0) {
    int trackSlices;
    int currentTime;

    trackSlices = gNumSlices;
    currentTime = simGlobal.gameTicks;
    if (((carObj->stats).lap < 4) &&
        ((carObj->linearVel_ch).z >
         (carObj->stats).topSpeed[(carObj->stats).lap])) {
      if (((carObj->carFlags & 8U) != 0) && (carObj->carInfo->carType < 0x13)) {
        (carObj->stats).topSpeed[(carObj->stats).lap] =
            Cars_topSpeedCap[carObj->carInfo->carType] - rand() * 3 <
                    (carObj->linearVel_ch).z
                ? Cars_topSpeedCap[carObj->carInfo->carType] - rand() * 3
                : (carObj->linearVel_ch).z;
      }
      else {
        (carObj->stats).topSpeed[(carObj->stats).lap] = (carObj->linearVel_ch).z;
      }
    }
    if (((carObj->stats).lap != carObj->lap) &&
        ((carObj->stats).finishType == 0)) {
      if (((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) &&
         (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0 ||
          ((Cars_gNumHumanRaceCars == 2 && ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0)))))
         ) {
        (carObj->stats).time[(carObj->stats).lap] = 99999;
      }
      else {
        (carObj->stats).time[(carObj->stats).lap] =
            currentTime - (carObj->stats).lapTime;
      }
      (carObj->stats).lapTime = currentTime;
      (carObj->stats).lap = carObj->lap;
      if (((carObj->stats).lap == GameSetup_gData.numLaps) &&
         (((GameSetup_gData.raceType != RaceType_HotPursuit && (GameSetup_gData.raceType != RaceType_Id5)) ||
          (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 &&
           ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0))))
          )))) {
        (carObj->stats).finishType = 2;
        (carObj->stats).sliceTime = currentTime;
        (carObj->stats).lapTime -= 0x200;
        (carObj->stats).sliceTotal =
            ((carObj->stats).lap + 1) * trackSlices;
      }
    }
    {
      int roadSlice;

      if (GameSetup_gData.reverseTrack != 0) {
        roadSlice = trackSlices - (carObj->N).simRoadInfo.slice - 1;
      }
      else {
        roadSlice = (int)(carObj->N).simRoadInfo.slice;
      }
      if ((carObj->stats).slice != roadSlice) {
        (carObj->stats).slice = roadSlice;
        if ((carObj->stats).finishType == 0) {
          (carObj->stats).sliceTime = currentTime;
          (carObj->stats).sliceTotal =
              ((carObj->stats).lap - carObj->unlap) * trackSlices +
              (carObj->stats).slice;
        }
      }
    }
    {
      int i;

      for (i = 0; i < Cars_gNumRaceCars; i++) {
        int sliceTotal = (carObj->stats).sliceTotal;
        int raceSlice = Stats_racePosition[i].slice;

        if ((raceSlice < sliceTotal) ||
            ((sliceTotal == raceSlice) &&
             ((carObj->stats).sliceTime < Stats_racePosition[i].sliceTime))) {
          int j;

          for (j = Cars_gNumRaceCars - 2; i <= j; j--) {
            int r1;
            int r2;
            int r3;
            int r4;

            r1 = Stats_racePosition[j].car;
            r2 = Stats_racePosition[j].slice;
            r3 = Stats_racePosition[j].sliceTime;
            r4 = Stats_racePosition[j].isHuman;
            Stats_racePosition[j + 1].car = r1;
            Stats_racePosition[j + 1].slice = r2;
            Stats_racePosition[j + 1].sliceTime = r3;
            Stats_racePosition[j + 1].isHuman = r4;
          }
          {
            int r1;
            int r2;
            int r3;
            int r4;

            r1 = carObj->carIndex;
            r2 = (carObj->stats).sliceTotal;
            r3 = (carObj->stats).sliceTime;
            r4 = carObj->carFlags & 4;
            Stats_racePosition[i].car = r1;
            Stats_racePosition[i].slice = r2;
            Stats_racePosition[i].sliceTime = r3;
            Stats_racePosition[i].isHuman = r4;
          }
          return;
        }
      }
    }
  }
  return;
}

/* ---- Stats_ExtrapolateOpponentTimes__Fi  [STATS.CPP:278-463] SLD-VERIFIED ---- */
void Stats_ExtrapolateOpponentTimes(int type)
{
  int i;
  int j;
  int extrapolatedTime;
  int quick_finish;

  quick_finish = Input_Interface(3,0) != 0;
  for (i = 0; i < Cars_gNumHumanRaceCars; i++) {
    if (Cars_gHumanRaceCarList[i]->stats.finishType != 2) {
      int sliceTotal;
      int startingTime;

      sliceTotal = Cars_gHumanRaceCarList[i]->stats.sliceTotal;
      if (sliceTotal < 1) {
        sliceTotal = 1;
      }
      startingTime = Cars_gHumanRaceCarList[i]->stats.sliceTime - 0x200;
      if (sliceTotal < 100) {
        startingTime = sliceTotal * 13;
      }
      extrapolatedTime =
          startingTime * (gNumSlices * GameSetup_gData.numLaps +
                          Cars_gHumanRaceCarList[i]->stats.extractSlice) /
          sliceTotal;
      if (quick_finish) {
        Cars_gHumanRaceCarList[i]->stats.lapTime = extrapolatedTime;
      }
      else {
        Cars_gHumanRaceCarList[i]->stats.lapTime = extrapolatedTime << 1;
      }
      if (GameSetup_gData.raceType != RaceType_Tournament) {
        if (quick_finish) {
          Cars_gHumanRaceCarList[i]->stats.finishType = 2;
        }
        else {
          Cars_gHumanRaceCarList[i]->stats.finishType = 1;
        }
      }
      else if (GameSetup_gData.localCar == i) {
        if (quick_finish) {
          Cars_gHumanRaceCarList[i]->stats.finishType = 2;
        }
        else {
          Cars_gHumanRaceCarList[i]->stats.finishType = 1;
        }
      }
    }

    if (type == 1) {
      if (GameSetup_gData.raceType != RaceType_Tournament) {
        if (quick_finish) {
          Cars_gHumanRaceCarList[i]->stats.finishType = 2;
        }
        else if (Cars_gHumanRaceCarList[i]->stats.finishType != 2) {
          Cars_gHumanRaceCarList[i]->stats.finishType = 1;
        }
      }
      else {
        if ((Cars_gHumanRaceCarList[i]->stats.finishType != 2) &&
            (GameSetup_gData.localCar == i)) {
          if (quick_finish) {
            Cars_gHumanRaceCarList[i]->stats.finishType = 2;
          }
          else {
            Cars_gHumanRaceCarList[i]->stats.finishType = 1;
          }
        }
      }

      Cars_gHumanRaceCarList[i]->stats.finalPosition =
          Stats_GetPosition(Cars_gHumanRaceCarList[i]);
      Cars_gHumanRaceCarList[i]->stats.finalTotalTime =
          Cars_gHumanRaceCarList[i]->stats.lapTime;
      for (j = 0; j < GameSetup_gData.numLaps; j++) {
        Cars_gHumanRaceCarList[i]->stats.finalLapTime[j] =
            Cars_gHumanRaceCarList[i]->stats.time[j];
      }
    }

    Cars_gHumanRaceCarList[i]->stats.finalPosition =
        Stats_GetPosition(Cars_gHumanRaceCarList[i]);
    Cars_gHumanRaceCarList[i]->stats.finalPosition =
        Stats_GetPosition(Cars_gHumanRaceCarList[i]);
    Cars_gHumanRaceCarList[i]->stats.finalTotalTime =
        Cars_gHumanRaceCarList[i]->stats.lapTime;
    Cars_gHumanRaceCarList[i]->stats.finalFinishType =
        Cars_gHumanRaceCarList[i]->stats.finishType;
    Cars_gHumanRaceCarList[i]->stats.finalBestLap =
        Cars_gHumanRaceCarList[i]->stats.time[0];
    Cars_gHumanRaceCarList[i]->stats.finalNumWarnings =
        Cars_gHumanRaceCarList[i]->stats.numWarnings;
    Cars_gHumanRaceCarList[i]->stats.finalNumFines =
        Cars_gHumanRaceCarList[i]->stats.numFines;
    Cars_gHumanRaceCarList[i]->stats.finalNumArrests =
        Cars_gHumanRaceCarList[i]->stats.numArrests;
    Cars_gHumanRaceCarList[i]->stats.finalDamage = 0;
    {
      int m;
      for (m = 0; m < 10; m++) {
        Cars_gHumanRaceCarList[i]->stats.finalDamage +=
            Cars_gHumanRaceCarList[i]->N.damage[m];
      }
    }
    for (j = 0; j < GameSetup_gData.numLaps; j++) {
      Cars_gHumanRaceCarList[i]->stats.finalLapTime[j] =
          Cars_gHumanRaceCarList[i]->stats.time[j];
      if ((Cars_gHumanRaceCarList[i]->stats.finalLapTime[j] <
           Cars_gHumanRaceCarList[i]->stats.finalBestLap) &&
          (Cars_gHumanRaceCarList[i]->stats.finalLapTime[j] != 0)) {
        Cars_gHumanRaceCarList[i]->stats.finalBestLap =
            Cars_gHumanRaceCarList[i]->stats.finalLapTime[j];
      }
    }
  }

  for (i = 0; i < Cars_gNumAIRaceCars; i++) {
    if (Cars_gAIRaceCarList[i]->stats.finishType != 2) {
      int sliceTotal;
      int startingTime;

      sliceTotal = Cars_gAIRaceCarList[i]->stats.sliceTotal;
      if (sliceTotal < 1) {
        sliceTotal = 1;
      }
      startingTime = Cars_gAIRaceCarList[i]->stats.sliceTime - 0x200;
      if (sliceTotal < 100) {
        startingTime = sliceTotal * 13;
      }
      extrapolatedTime =
          startingTime * (gNumSlices * GameSetup_gData.numLaps +
                          Cars_gAIRaceCarList[i]->stats.extractSlice) /
          sliceTotal;
      if (!quick_finish &&
          (Cars_gHumanRaceCarList[0]->stats.finishType != 2)) {
        Cars_gAIRaceCarList[i]->stats.lapTime =
            extrapolatedTime +
            GameSetup_gData.numLaps * rand() / 0x80;
      }
      else {
        Cars_gAIRaceCarList[i]->stats.lapTime = extrapolatedTime;
      }
      Cars_gAIRaceCarList[i]->stats.finishType = 2;
    }

    Cars_gAIRaceCarList[i]->stats.finalPosition =
        Stats_GetPosition(Cars_gAIRaceCarList[i]);
    Cars_gAIRaceCarList[i]->stats.finalTotalTime =
        Cars_gAIRaceCarList[i]->stats.lapTime;
    Cars_gAIRaceCarList[i]->stats.finalFinishType =
        Cars_gAIRaceCarList[i]->stats.finishType;
    Cars_gAIRaceCarList[i]->stats.finalNumArrests =
        Cars_gAIRaceCarList[i]->stats.numArrests;
    Cars_gAIRaceCarList[i]->stats.finalBestLap = 99999;
    for (j = 0; j < GameSetup_gData.numLaps; j++) {
      if ((Cars_gAIRaceCarList[i]->stats.finalBestLap >
           Cars_gAIRaceCarList[i]->stats.time[j]) &&
          (Cars_gAIRaceCarList[i]->stats.time[j] > 0)) {
        Cars_gAIRaceCarList[i]->stats.finalBestLap =
            Cars_gAIRaceCarList[i]->stats.time[j];
      }
    }

    {
      int averageLap;

      averageLap =
          Cars_gAIRaceCarList[i]->stats.finalTotalTime /
              GameSetup_gData.numLaps -
          rand() / 0x30;
      if (averageLap < Cars_gAIRaceCarList[i]->stats.finalBestLap) {
        Cars_gAIRaceCarList[i]->stats.finalBestLap = averageLap;
      }
    }

    for (j = 0; j < GameSetup_gData.numLaps; j++) {
      Cars_gAIRaceCarList[i]->stats.finalLapTime[j] =
          Cars_gAIRaceCarList[i]->stats.time[j];
      if ((Cars_gAIRaceCarList[i]->stats.finalLapTime[j] <
           Cars_gAIRaceCarList[i]->stats.finalBestLap) &&
          (Cars_gAIRaceCarList[i]->stats.finalLapTime[j] != 0)) {
        Cars_gAIRaceCarList[i]->stats.finalBestLap =
            Cars_gAIRaceCarList[i]->stats.finalLapTime[j];
      }
    }
  }

  if (!quick_finish) {
    for (int x = 0; x < Cars_gNumRaceCars; x++) {
      int position = 1;

      for (int y = 0; y < Cars_gNumRaceCars; y++) {
        if (x != y) {
          if ((Cars_gRaceCarList[x]->stats.finalTotalTime >
               Cars_gRaceCarList[y]->stats.finalTotalTime) ||
              ((Cars_gRaceCarList[x]->stats.finalTotalTime ==
                Cars_gRaceCarList[y]->stats.finalTotalTime) &&
               (y < x))) {
            position++;
            /* MATCH (reqdelta receipt): p772(position) refs 10->16 flips the
             * a2/a3 handout vs the y-walk giv p839. Two depth-3 refs, 0 insns. */
            __asm__("" : : "r"(position), "r"(position));
          }
        }
      }

      Cars_gRaceCarList[x]->stats.finalPosition = position;
    }
  }
}

/* ---- Stats_TrackEndGame__Fv  [STATS.CPP:470-550] SLD-VERIFIED ----
   W57-A12 05A(SLD)+rule-8(SYM 8c) pass: 113 -> 80 diffs (231 -> 226 insns / oracle 232).
   SYM 8c @800b8db8 (fsize 72, mask $c0ff0000 = s0-s7+fp+ra) local list, block by block:
     fn scope : i (REG $6=$a2), Stats_PlayersFinishedRace (AUTO -0x38 = 16(sp))
     line 11  : trackSlices (REG $5=$a1)
     line 14  : PlayerSlice (AUTO -0x34 = 20(sp)), PlayerPosition (REG $0x15=$s5),
                DesiredComparison (REG $0x12=$s2), DesiredSlice (REG $0x17=$s7),
                DesiredSpeed (REG $0x14=$s4)
     line 31  : j (REG $0x11=$s1)
   Applied: (a) the invented `Car_tObj **raceCar` walk local is NOT in the SYM -> dropped; the
   oracle's `addiu s0,s0,4` is gcc's own GIV off `Cars_gRaceCarList[j]`, and the SURVIVING
   `sll s6,s1,2` index proves the source used the INDEX form (06A eliminated-biv tell).
   (b) SLD 492-497 is a three-arm if/else-if/else (`li s2,1` carries its own line 495), not
   default+override. (c) SLD 485 and 505 are each ONE statement = a MIN ternary (the oracle
   assigns the result in BOTH arms from a temp). (d) SLD 507 is ONE statement = abs()>>16 over
   the index form -> __builtin_abs. (e) SLD 500/512 = TOP test + UNCONDITIONAL `j` back-edge ->
   exit-in-the-middle while(1)/break (a `for` lets gcc prove entry and rotate; measured 97 vs 80).
   W59-A14: 80 -> 44 diffs, INSN COUNT NOW EXACT 232/232, and the W57-A12 "PlayerSlice is an
   allocator SPILL choice" verdict is REFUTED -- PlayerSlice now spills to 20(sp) by itself.
   ROOT CAUSE of the whole 6-insn gap was ONE over-CSE: gcc merged the abs arm's
   `Cars_gRaceCarList[j]` with the sliceTotal read above it (ours `lw v0,1056(a0)`, 1 insn, vs
   retail's 5-insn base+index rematerialization), so our build had ONE FEWER global allocno
   than retail -- and that spare callee-saved register is exactly what PlayerSlice took.
   (f) THE UN-MERGE DEVICE = an IDENTITY FENCE on the index at the LOOP-BODY TOP
   (`jj = j; __asm__("" : "=r"(jj) : "0"(jj));` then index with `jj`): laundering j makes the
   arm's address cse-opaque AND loop.c-opaque, so it materializes base+scaled-index like retail
   and adds the missing allocno. Placement is the dial: the SAME fence INSIDE the arm scores 82
   (the `sll` then sits in the arm, not the loop head).
   (g) SLD 485 (the FIRST min) is an OVERRIDE, not a ternary: `PlayerSlice = trackSlices;
   if (trackSlices >= sliceTotal) PlayerSlice = sliceTotal;` -- that puts the then-store in the
   `bnez` delay slot and both stores on the slot, exactly like retail (54 -> 44).
   FALSIFIED here (do not retry): cast-int address arithmetic on the abs (folds back, 80);
   `Car_tObj *volatile *` view (breaks the load cse but keeps the WALKER address, 66/228);
   arm-swap `if (PlayerPosition != 1)` polarity (109, trackSlices leaves $a1); the same
   override shape on the SECOND min at SLD 505 (115, frame grows to 80); a named `sliceTot`
   temp for the second min (coalesced, diff-neutral 44); `jj = j << 2` + cast-int address
   (150-154, frame grows to 80 -- the scaled launder costs a whole extra allocno);
   swapping the `DesiredSlice = 0 / DesiredSpeed = 0` order (54); moving the identity fence
   from the loop-body TOP down into the matched `if` block (65, and ours goes 1 insn short).
   RESIDUAL (44) = a PRICED 4-way callee-saved permutation, allocsim MATCH 31/31 (model valid):
     ours   p101 PlayerPosition=s4  p103 DesiredSlice=s5  p104 DesiredSpeed=s6  p130 jj=s7
     retail p104 DesiredSpeed=s4    p101 PlayerPosition=s5 p130 temp=s6         p103 DesiredSlice=s7
   REQUIRED DELTA (verified by allocsim --what-if, no SINGLE-pseudo dial exists at +-40):
     p101 live 28 -> 29  AND  p103 live 41 -> 43   (equivalently p103 refs 13 -> 12)
   i.e. two ZERO-INSN dials at once; every fence that buys refs also buys the wrong priority
   step here (p130 refs 5->6 jumps pri to 1.09 and steals $s3). Next lever = a live-range-only
   dial (def moved one insn earlier / last use one insn later) on PlayerPosition + one weighted
   ref removed from DesiredSlice. Dumps: scratch/rtl/stats.i.{greg,lreg}.

   W62-A12 (2026-08-15) -- QUANTIFIED HARDNESS CERTIFICATE (12A form).  Re-gated 44.
   Pseudo numbering has drifted +6 since W59-A14: PlayerPosition=p107(refs 9,live 29),
   DesiredSlice=p109(13,42), DesiredSpeed=p110(13,42), jj=p136(5,11), and the s3 holder
   p305(19,80).  allocsim MATCH 30/30 (model valid).  RETAIL'S HANDOUT IS EXACTLY
   REACHED at p110=(refs 14,live 45) or (15,48) with p109 demoted below p136 --
   verified by allocsim --what-if, which prints the full retail band
   p305=s3 p110=s4 p107=s5 p136=s6 p109=s7.  So the target is a SINGLE CELL, and:
     * p110 CANNOT stay at refs 13.  Its window is (pri p107, pri p305) =
       (0.9310, 0.9500); 39/41=0.9512 and 39/42=0.9286 straddle it, no integer live
       exists.  A refs change is mandatory.
     * every ref this function can buy is worth TWO (loop depth), measured not
       assumed: one read-only fence OPERAND on DesiredSpeed moves refs 13 -> 15.
       refs 14 is therefore UNREACHABLE from inside the i-loop.
     * so the only cell left is refs 15 / live 48, and EVERY statement boundary in
       the guard block was measured: fence before the guard 43, then-arm head 43,
       after the divide 44, then-arm tail 46, else-arm head 43, else-arm tail 47,
       loop tail 50-51.  48 is not on the list.
     * and each fence is an RTL insn: it lengthens p305 (80->81->82), dropping the
       s3 holder's priority to 0.9382 then 0.9268 and closing the window further.
   MEASURED THIS WAVE (all real gate runs, all restored):
     DesiredSlice fence at the loop tail alone (p109 -> s7, correct!) ....... 58 @232
     + DesiredSpeed operand, 5 positions ................................. 58-62 @232-234
     2-operand single fence at the tail ................................... 58 @232
     second-min as a two-store override + named temp (the retail SHAPE, 11D
       joint-pair re-test of two individually-falsified axes) ............ 115 @229
     same without braces 115 @229; opposite polarity 44; named temp + ternary 44;
     named temp + if/else both-arms 45 @233
     SCALED identity launder `jj = j << 2` with the abs read as
       `*(Car_tObj **)(jj + (int)Cars_gRaceCarList)` -- NOTE this now holds the
       count EXACT (232/232, the W59 "frame grows to 80" note is stale) but 150;
       base-term-first 150; raw byte-offset field 156; joint with the override 91 @229.
   ORACLE FACTS worth keeping (read off the sbs, they constrain any future attempt):
   retail's s6 holds `j << 2` (`sll s6,s1,2` in the loop-guard's delay slot) and
   rematerializes the Cars_gRaceCarList base per use (`lui t5` in the `beq` slot,
   then `addiu t5,t5 ; addu v0,s6,t5`); retail's second min loads sliceTotal into a
   TEMP ($v1) and stores the result TWICE (`addu s7,a1,zero` in the `bnez` slot,
   `addu s7,v1,zero` on the fall-through), where ours loads straight into the result
   register and stores once.
   ROUTE: not a fence dial -- the cell is closed.  Either a structural change that
   moves DesiredSpeed's live range by 3 WITHOUT adding an insn, or the 06E
   local-alloc/qtytrace instrument.  Do not spend more fence positions.

   🔴 W64-A15 (2026-08-15) -- THE W62 CERTIFICATE IS CORRECT BUT AIMED AT THE WRONG
   PSEUDO.  W62 proved only that *DesiredSpeed's* cell is empty; it never enumerated
   the OTHER band members.  A complete two-pseudo sweep over the band
   (scratchpad/w64a15/statscells.py -- allocsim/reqdelta directly; multidial's
   --search is greedy AND refs-only, so it cannot see a live-only pair) finds
   **180 solution cells**, and every cheap one is on PlayerPosition + DesiredSlice,
   not DesiredSpeed.  Current numbering (re-dumped, drifted BACK to the W59 set):
     p285=s3 (19,78)  p101=PlayerPosition=s4 (9,28)  p103=DesiredSlice=s5 (13,41)
     p104=DesiredSpeed=s6 (13,41)  p130=jj=s7 (5,11)   want p104=s4 p101=s5 p130=s6 p103=s7
   SOLO cells: NONE (confirmed by exhaustive single-pseudo sweep, refs +-4 x live -6..+8).
   CHEAPEST PAIRS (cost = 2*|dRefs| + |dLive|):
     cost 3   p101 live +1  AND  p103 refs -1
     cost 3   p101 live +1  AND  p103 live +2
     cost 4   p101 live +1  AND  p103 refs -1 live +-1
     cost 8   p103 refs -1  AND  p104 live -4          (the only pair NOT touching p101)
   `p101 live +1` appears in every cell under cost 8 -- it is effectively mandatory,
   and it is a razor (live 30 already breaks the band: p101 falls under p130).
   MEASURED (each a real gate run + a fresh -dl/-dg dump, all restored):
     (1) FOREIGN-OPERAND FENCE, zero-insn, aimed at p101's live range --
         `__asm__("" : : "r"(trackSlices));` immediately after PlayerPosition's def
         (operand chosen OUTSIDE the band so no band ref moves):
           gate 52 @232/232 (COUNT STAYS EXACT), and the handout becomes
           p103=s3(13,40) p104=s4(13,40) p285=s5(19,79) p130=s6(5,11) p101=s7(9,31)
         => **p104=s4 and p130=s6 are now RETAIL-CORRECT (2 of 4, was 0 of 4).**
         🔴 AND THE 15A "+1 live for everything live across it" MODEL IS WRONG HERE:
         measured deltas are p101 +3, p103 -1, p104 -1, p285 +1 -- the fence RE-TIMES
         several ranges, it does not uniformly lengthen them.  Any future live dial on
         this fn must be re-measured from the dump, never predicted from the +1 rule.
     (2) second-min through a fenced `sliceTot` temp (to buy p103 refs -1):
         153 @233 -- the identity fence MATERIALIZES here (+1 insn), so it is not a
         zero-cost ref dial at this site.  Paired with (1): 157 @233.
   NOT LANDED (52/153/157 all > 44).  ROUTE, sharpened: from the (1) basin the
   remaining question is only `p101 live 31 -> 29` and `p103 below p130`, with p285
   restored above p104 -- i.e. re-run statscells.py ON THE (1) DUMP (the cell table is
   basin-relative, 04Z) and look for a fence POSITION whose measured re-timing lands
   that cell.  Do NOT go back to DesiredSpeed: its cell really is closed.

   ===== W71-A22 (2026-08-21).  Re-gated 44 @232/232.  Fresh -dl/-dg dump: the
   numbering is UNCHANGED from W64-A15 (p285=s3 19/78, p101=s4 9/28, p103=s5 13/41,
   p104=s6 13/41, p130=s7 5/11) and allocsim still MATCHes.  reqdelta on the full
   want `p104=s4,p101=s5,p130=s6,p103=s7`: no single-pseudo dial at +-40 and no
   same-pseudo refs+live pair -- W64-A15's two-PSEUDO cell table stands.
   THE CELL ARITHMETIC, written out so nobody re-derives it:
     p101 live 28->29 -> pri 27/29 = 0.9310 ; p103 refs 13->12 -> pri 36/41 = 0.8780
     gives the order p285 .9743 > p104 .9512 > p101 .9310 > p130 .9090 > p103 .8780
     = s3 s4 s5 s6 s7 = EXACTLY retail's band.
   🔴 LAW CORRECTION (gcc source, not inference) -- the W62 premise
   "every ref this function can buy is worth TWO (loop depth)" is FALSE HERE:
   flow.c:1969/2218/2404/2616 do `REG_N_REFS (regno) += loop_depth`, and
   find_basic_blocks starts `depth = 1` (flow.c:402), so a ref costs
   1 outside any loop, 2 in the i-loop, and **3 in the inner j-loop**.  A +-1 ref
   delta on p103 IS therefore constructible -- trade ONE j-loop (depth-3) ref for
   ONE i-loop (depth-2) ref.  MEASURED construction: assign DesiredSlice ONCE in
   the j-loop through a temp (-3) + a read-only fence operand on DesiredSlice at
   i-loop level (+2) = refs 12.  It reaches the ref cell and STILL fails, because
   the temp-min form drops the insn count to 230 (SA/SB 76@230, SC/SD 92@230).
   So the blocker is not the ref arithmetic; it is that no spelling holds 232
   while giving DesiredSlice one fewer weighted ref.
   🏆 NEW BEST BASIN, NAMED AND MEASURED (not landed -- see why):
     a ZERO-OPERAND fence placed IMMEDIATELY AFTER the second-min statement,
     `__asm__("" : : "i"(0));`, gates **25 @233** and pulls p285/p101/p104 onto
     retail's s3/s4/s5 -- 19 of the 44 diffs gone in one line.  An identity
     launder on DesiredComparison at the same point measures IDENTICALLY (25@233),
     so the effect is NOT the barrier property (20B): it is the extra RTL insn's
     re-timing of the band.
     RESIDUAL IN THE 25-BASIN = exactly three things: (a) DesiredSlice s6 vs
     retail s7 swapped with the jj carrier; (b) retail's carrier holds `j << 2`
     (`sll s6,s1,2`) where ours holds `j`; (c) the +1 insn is the second min's
     `beqz` DELAY-SLOT NOP -- retail fills it with the DEFAULT store of an
     override (`bnez ...; addu s7,a1,zero` then `addu s7,v1,zero`).
     🔴 NOT LANDED: 233 vs the oracle's 232.  Count-exactness is the stronger
     invariant (the project rejects lower-diff/count-inexact forms), and the
     baseline is count-EXACT.  The 25-basin's remaining ask is precise: keep this
     allocation AND get the min's default store into the branch slot without
     losing the two stores.
   FALSIFIED THIS WAVE (every one a real gate run, all restored):
     temp-min (assign DesiredSlice once) 76@230; the same with a sliceTot temp
     76@230; either + an i-loop DesiredSlice fence 92@230; that fence alone
     62@232; a read-only fence on PlayerSlice right after PlayerPosition's def
     125@233; all three together 77@231.
     Retail-shaped OVERRIDE for the second min, four spellings (temp/plain/
     `>=`/`<=`), each with AND without the 25-basin fence: 115@229 without,
     81@231 with -- gcc merges the two stores in every one, so the override
     cannot be reached from source in either basin.  Swapped-operand ternary
     (`sliceTotal < trackSlices ? sliceTotal : trackSlices`) 81@231.
     Foreign-operand fence POSITION sweep (operand `trackSlices`, 6 positions):
     j-loop head 45@233, after-min 25@233, before-break 56@232, after-j++ 47@233,
     after-the-j-block 62@232, after `DesiredSlice = 0` 64@232.
     OPERAND sweep at the winning after-min position: i 105@231, j 55@233,
     jj 71@233, PlayerSlice 104@234, DesiredComparison 25@233, PlayerPosition
     63@233, DesiredSlice 63@233, `"i"(0)` 25@233.
     In the 25-basin: SCALED carrier `jj = j << 2` + cast-int address, index-first
     151@233 and base-first 151@233; dropping the carrier entirely 81@227;
     a second fence 140@234. */
void Stats_TrackEndGame(void)

{
  int i;
  int Stats_PlayersFinishedRace;

  Stats_PlayersFinishedRace = 0;
  if (Cars_gNumRaceCars > 1) {
    if ((simGlobal.gameTicks % 64) == 1) {
      int trackSlices;

      trackSlices = GameSetup_gData.numLaps * gNumSlices;
      for (i = 0; i < Cars_gNumHumanRaceCars; i++) {
        int PlayerSlice;
        int PlayerPosition;
        int DesiredComparison;
        int DesiredSlice;
        int DesiredSpeed;

        /* SLD 485: ONE statement -- a MIN (both arms assign, oracle stores each to the slot). */
        PlayerSlice = trackSlices;
        if (trackSlices >= Cars_gHumanRaceCarList[i]->stats.sliceTotal) {
          PlayerSlice = Cars_gHumanRaceCarList[i]->stats.sliceTotal;
        }

        PlayerPosition = Stats_GetPosition(Cars_gHumanRaceCarList[i]);
        DesiredSlice = 0;
        DesiredSpeed = 0;

        /* MATCH/SLD 492-497: a three-arm if/else-if/else (the `li s2,1` carries SLD 495 = its
           OWN source line), NOT `DesiredComparison = 1;` + an override test. */
        if (PlayerPosition == 1) {
          DesiredComparison = 2;
        }
        else if (GameSetup_gData.checkpointType == 1) {
          DesiredComparison = 1;
        }
        else {
          DesiredComparison = PlayerPosition - 1;
        }

        {
          int j;
          int jj; /* SYM-CODEGEN-CARRIER: jj -- measured register-band dial; see receipt above. */

          /* SLD 500/512: TOP test + UNCONDITIONAL `j` back-edge -> exit-in-the-middle
             (a `for` lets gcc prove entry and ROTATE to a bottom test). */
          j = 0;
          while (1) {
            if (j >= Cars_gNumRaceCars) {
              break;
            }
            jj = j;
            __asm__("" : "=r"(jj) : "0"(jj));
            if (Stats_GetPosition(Cars_gRaceCarList[j]) == DesiredComparison) {
              /* SLD 505: ONE statement -- a MIN, so both arms assign from a temp. */
              DesiredSlice = trackSlices < Cars_gRaceCarList[j]->stats.sliceTotal ?
                             trackSlices : Cars_gRaceCarList[j]->stats.sliceTotal;

              if (PlayerPosition == 1) {
                /* SLD 507: ONE statement -- abs()>>16 over the INDEX form. */
                DesiredSpeed = __builtin_abs(Cars_gRaceCarList[jj]->linearVel_ch.z) >> 16;
              }
              else {
                DesiredSpeed =
                    *(short *)((char *)&Cars_gHumanRaceCarList[i]->linearVel_ch.z + 2);
              }
              break;
            }
            j++;
          }
        }

        Cars_gHumanRaceCarList[i]->stats.checkpointUpdate =
            DesiredSlice - PlayerSlice;
        if ((DesiredSpeed >= 16) &&
            (Cars_gHumanRaceCarList[i]->stats.finishType != 2)) {
          Cars_gHumanRaceCarList[i]->stats.checkpointDifference =
              Cars_gHumanRaceCarList[i]->stats.checkpointUpdate * 0x180 /
              DesiredSpeed;
          Cars_gHumanRaceCarList[i]->stats.checkpointDisplay = 1;
        }
        else {
          Cars_gHumanRaceCarList[i]->stats.checkpointDifference = 0;
          Cars_gHumanRaceCarList[i]->stats.checkpointDisplay = 0;
        }
      }
    }
  }

  if (simVar.endSimGame == 0) {
    for (i = 0; i < Cars_gNumHumanRaceCars; i++) {
      if ((Cars_gHumanRaceCarList[i]->stats.finishType > 1) &&
          (Cars_gHumanRaceCarList[i]->stats.sliceTime + 0x140 <
           simGlobal.gameTicks) &&
          (((CopSpeak_gQueuePlay == CopSpeak_gQueueHead) &&
            (CopSpeak_gSpchHandle == -1)) ||
           (Cars_gHumanRaceCarList[i]->stats.sliceTime + 0x280 <
            simGlobal.gameTicks))) {
        Stats_PlayersFinishedRace++;
      }
    }

    if (Stats_PlayersFinishedRace == Cars_gNumHumanRaceCars) {
      simVar.endSimGame = 1;
      Stats_ExtrapolateOpponentTimes(2);
    }
  }
  return;
}

/* end of stats.cpp */
