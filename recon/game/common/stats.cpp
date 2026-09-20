/* game/psx/stats.cpp -- RECONSTRUCTED (NFS4 PSX race statistics; C++ TU)
 *   7 fns: Stats_DoPlayerGlue/ClearPosition/GetPosition/GetNumOpponents/TrackStats/
 *   ExtrapolateOpponentTimes/TrackEndGame. GTE-free. Full SYM-locals applied.
 */
#include "stats_types.h"
#include "stats_externs.h"

#define MIN(a,b) (((a) > (b)) ? (b) : (a))

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

  if ((STATS_CATCHUP_LOGIC != 0) && (STATS_COMMMODE == 1)) {
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
  if ((STATS_GAME_TICKS & 1U) == 0) {
    int trackSlices;
    int currentTime;

    trackSlices = gNumSlices;
    currentTime = STATS_GAME_TICKS;
    if (((carObj->stats).lap < 4) &&
        ((carObj->linearVel_ch).z >
         (carObj->stats).topSpeed[(carObj->stats).lap])) {
      if (((carObj->carFlags & 8U) != 0) && (carObj->carInfo->carType < 0x13)) {
        (carObj->stats).topSpeed[(carObj->stats).lap] =
            MIN((carObj->linearVel_ch).z,
                Cars_topSpeedCap[carObj->carInfo->carType] - rand() * 3);
      }
      else {
        (carObj->stats).topSpeed[(carObj->stats).lap] = (carObj->linearVel_ch).z;
      }
    }
    if (((carObj->stats).lap != carObj->lap) &&
        ((carObj->stats).finishType == 0)) {
      if (((STATS_RACE_TYPE == RaceType_HotPursuit) || (STATS_RACE_TYPE == RaceType_Id5)) &&
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
      if (((carObj->stats).lap == STATS_NUM_LAPS) &&
         (((STATS_RACE_TYPE != RaceType_HotPursuit && (STATS_RACE_TYPE != RaceType_Id5)) ||
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

      if (STATS_REVERSE_TRACK != 0) {
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
        if (((carObj->stats).sliceTotal > Stats_racePosition[i].slice) ||
            (((carObj->stats).sliceTotal == Stats_racePosition[i].slice) &&
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
          startingTime * (gNumSlices * STATS_NUM_LAPS +
                          Cars_gHumanRaceCarList[i]->stats.extractSlice) /
          sliceTotal;
      if (quick_finish) {
        Cars_gHumanRaceCarList[i]->stats.lapTime = extrapolatedTime;
      }
      else {
        Cars_gHumanRaceCarList[i]->stats.lapTime = extrapolatedTime << 1;
      }
      if (STATS_RACE_TYPE != RaceType_Tournament) {
        if (quick_finish) {
          Cars_gHumanRaceCarList[i]->stats.finishType = 2;
        }
        else {
          Cars_gHumanRaceCarList[i]->stats.finishType = 1;
        }
      }
      else if (STATS_LOCAL_CAR == i) {
        if (quick_finish) {
          Cars_gHumanRaceCarList[i]->stats.finishType = 2;
        }
        else {
          Cars_gHumanRaceCarList[i]->stats.finishType = 1;
        }
      }
    }

    if (type == 1) {
      if (STATS_RACE_TYPE != RaceType_Tournament) {
        if (quick_finish) {
          Cars_gHumanRaceCarList[i]->stats.finishType = 2;
        }
        else if (Cars_gHumanRaceCarList[i]->stats.finishType != 2) {
          Cars_gHumanRaceCarList[i]->stats.finishType = 1;
        }
      }
      else {
        if ((Cars_gHumanRaceCarList[i]->stats.finishType != 2) &&
            (STATS_LOCAL_CAR == i)) {
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
      for (j = 0; j < STATS_NUM_LAPS; j++) {
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
    for (j = 0; j < STATS_NUM_LAPS; j++) {
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
          startingTime * (gNumSlices * STATS_NUM_LAPS +
                          Cars_gAIRaceCarList[i]->stats.extractSlice) /
          sliceTotal;
      if (!quick_finish &&
          (Cars_gHumanRaceCarList[0]->stats.finishType != 2)) {
        Cars_gAIRaceCarList[i]->stats.lapTime =
            extrapolatedTime +
            STATS_NUM_LAPS * rand() / 0x80;
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
    for (j = 0; j < STATS_NUM_LAPS; j++) {
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
              STATS_NUM_LAPS -
          rand() / 0x30;
      if (averageLap < Cars_gAIRaceCarList[i]->stats.finalBestLap) {
        Cars_gAIRaceCarList[i]->stats.finalBestLap = averageLap;
      }
    }

    for (j = 0; j < STATS_NUM_LAPS; j++) {
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
          /* MATCH (W85-S2, device removal): the a2/a3 handout used to be bought
             with a read-only fence `__asm__("" : : "r"(position),"r"(position))`
             (p772 refs 10->16).  The fence is DELETED; the SAME +6 refs come
             from the natural two-arm source -- `if (>) p++; else if (== && <) p++;`
             counts `position` FOUR times at loop depth 3 (10 -> 16 refs, the
             floor_log2 step 3->4 that outranks the y-walk giv p839), and gcc's
             final cross-jump pass merges the two identical increments back into
             the ONE `addiu a2,a2,1` retail has.  Zero instructions, zero devices;
             the `||` one-arm spelling scores 12 @493 (a pure a2<->a3 swap). */
          if (Cars_gRaceCarList[x]->stats.finalTotalTime >
              Cars_gRaceCarList[y]->stats.finalTotalTime) {
            position++;
          }
          else if ((Cars_gRaceCarList[x]->stats.finalTotalTime ==
                    Cars_gRaceCarList[y]->stats.finalTotalTime) &&
                   (y < x)) {
            position++;
          }
        }
      }

      Cars_gRaceCarList[x]->stats.finalPosition = position;
    }
  }
}

/* ---- Stats_TrackEndGame__Fv [STATS.CPP:470-550] ---- */
/* @0x800B8DB8 Native-C restoration, 2026-09-20: both minima use the
 * field-first MIN operand order. The compiler now supplies the original
 * register/stack allocation without pins, asm or non-SYM scratch locals.
 * PASS 232/232; all seven Stats functions and their branch targets retained.
 * Opposite MIN order: 234 instructions /142 diff lines; two-store override:
 * 223/95. Earlier device experiments are preserved in the scratch backup.
 * Exact named SYM locations are verified; remaining empty-scope/SLD details
 * are recorded separately in scratchpad/stats_native_20260920/README.md. */
void Stats_TrackEndGame(void)
{
  int i;
  int Stats_PlayersFinishedRace;
  Stats_PlayersFinishedRace = 0;
  if ((Cars_gNumRaceCars > 1) && ((STATS_GAME_TICKS % 64) == 1)) {
    int trackSlices;
    trackSlices = STATS_NUM_LAPS * gNumSlices;
    for (i = 0; i < Cars_gNumHumanRaceCars; i++) {
      int PlayerSlice;
      int PlayerPosition;
      int DesiredComparison;
      int DesiredSlice;
      int DesiredSpeed;
      PlayerSlice = MIN(Cars_gHumanRaceCarList[i]->stats.sliceTotal, trackSlices);
      PlayerPosition = Stats_GetPosition(Cars_gHumanRaceCarList[i]);
      DesiredSlice = 0;
      DesiredSpeed = 0;
      if (PlayerPosition == 1) {
        DesiredComparison = 2;
      } else if (STATS_CHECKPOINT_TYPE == 1) {
        DesiredComparison = 1;
      } else {
        DesiredComparison = PlayerPosition - 1;
      }
      {
        int j;
        j = 0;
        while (1) {
          if (j >= Cars_gNumRaceCars) {
            break;
          }
          if (Stats_GetPosition(Cars_gRaceCarList[j]) == DesiredComparison) {
            DesiredSlice = MIN(Cars_gRaceCarList[j]->stats.sliceTotal, trackSlices);
            if (PlayerPosition == 1) {
              DesiredSpeed = __builtin_abs(Cars_gRaceCarList[j]->linearVel_ch.z) >> 16;
            } else {
              DesiredSpeed = Cars_gHumanRaceCarList[i]->linearVel_ch.z >> 16;
            }
            break;
          }
          j++;
        }
      }
      Cars_gHumanRaceCarList[i]->stats.checkpointUpdate = DesiredSlice - PlayerSlice;
      if ((DesiredSpeed >= 16) && (Cars_gHumanRaceCarList[i]->stats.finishType != 2)) {
        Cars_gHumanRaceCarList[i]->stats.checkpointDifference =
            Cars_gHumanRaceCarList[i]->stats.checkpointUpdate * 0x180 / DesiredSpeed;
        Cars_gHumanRaceCarList[i]->stats.checkpointDisplay = 1;
      } else {
        Cars_gHumanRaceCarList[i]->stats.checkpointDifference = 0;
        Cars_gHumanRaceCarList[i]->stats.checkpointDisplay = 0;
      }
    }
  }
  if (STATS_END_SIM_GAME == 0) {
    for (i = 0; i < Cars_gNumHumanRaceCars; i++) {
      if ((Cars_gHumanRaceCarList[i]->stats.finishType > 1) && (Cars_gHumanRaceCarList[i]->stats.sliceTime + 0x140 < STATS_GAME_TICKS)) {
        if (((CopSpeak_gQueuePlay == CopSpeak_gQueueHead) && (CopSpeak_gSpchHandle == -1)) || (Cars_gHumanRaceCarList[i]->stats.sliceTime + 0x280 < STATS_GAME_TICKS)) {
          Stats_PlayersFinishedRace++;
        }
      }
    }
    if (Stats_PlayersFinishedRace == Cars_gNumHumanRaceCars) {
      STATS_END_SIM_GAME = 1;
      Stats_ExtrapolateOpponentTimes(2);
    }
  }
}

/* end of stats.cpp */
