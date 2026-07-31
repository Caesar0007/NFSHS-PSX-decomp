/* game/psx/stats.cpp -- RECONSTRUCTED (NFS4 PSX race statistics; C++ TU)
 *   7 fns: Stats_DoPlayerGlue/ClearPosition/GetPosition/GetNumOpponents/TrackStats/
 *   ExtrapolateOpponentTimes/TrackEndGame. GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "stats_externs.h"

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
  int iVar2;

  iVar2 = 0;
  do {
    Stats_racePosition[iVar2].car = -1;
    Stats_racePosition[iVar2].slice = -99999;
    Stats_racePosition[iVar2].sliceTime = 0;
    Stats_racePosition[iVar2].isHuman = 0;
    iVar2 = iVar2 + 1;
  } while (iVar2 < 6);
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
        ((carObj->stats).topSpeed[(carObj->stats).lap] <
         (carObj->linearVel_ch).z)) {
      if (((carObj->carFlags & 8U) == 0) || (0x12 < carObj->carInfo->carType)) {
        (carObj->stats).topSpeed[(carObj->stats).lap] = (carObj->linearVel_ch).z;
      }
      else {
        if (Cars_topSpeedCap[carObj->carInfo->carType] - rand() * 3 <
            (carObj->linearVel_ch).z) {
          (carObj->stats).topSpeed[(carObj->stats).lap] =
              Cars_topSpeedCap[carObj->carInfo->carType] - rand() * 3;
        }
        else {
          (carObj->stats).topSpeed[(carObj->stats).lap] =
              (carObj->linearVel_ch).z;
        }
      }
    }
    if (((carObj->stats).lap != carObj->lap) &&
        ((carObj->stats).finishType == 0)) {
      if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
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
         (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
          (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 &&
           ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0))))
          )))) {
        (carObj->stats).sliceTime = currentTime;
        (carObj->stats).finishType = 2;
        (carObj->stats).lapTime -= 0x200;
        (carObj->stats).sliceTotal =
            ((carObj->stats).lap + 1) * trackSlices;
      }
    }
    {
      int roadSlice;

      if (GameSetup_gData.reverseTrack == 0) {
        roadSlice = (int)(carObj->N).simRoadInfo.slice;
      }
      else {
        roadSlice = trackSlices - (carObj->N).simRoadInfo.slice - 1;
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
        if ((Stats_racePosition[i].slice < (carObj->stats).sliceTotal) ||
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
          startingTime * (gNumSlices * GameSetup_gData.numLaps +
                          Cars_gHumanRaceCarList[i]->stats.extractSlice) /
          sliceTotal;
      if (quick_finish) {
        Cars_gHumanRaceCarList[i]->stats.lapTime = extrapolatedTime;
      }
      else {
        Cars_gHumanRaceCarList[i]->stats.lapTime = extrapolatedTime << 1;
      }
      if (GameSetup_gData.raceType != 2) {
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
      if (GameSetup_gData.raceType != 2) {
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
          }
        }
      }

      Cars_gRaceCarList[x]->stats.finalPosition = position;
    }
  }
}

/* ---- Stats_TrackEndGame__Fv  [STATS.CPP:470-550] SLD-VERIFIED ---- */
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

        PlayerSlice = Cars_gHumanRaceCarList[i]->stats.sliceTotal;
        if (trackSlices < PlayerSlice) {
          PlayerSlice = trackSlices;
        }

        PlayerPosition = Stats_GetPosition(Cars_gHumanRaceCarList[i]);
        DesiredSlice = 0;
        DesiredSpeed = 0;

        if (PlayerPosition == 1) {
          DesiredComparison = 2;
        }
        else {
          DesiredComparison = 1;
          if (GameSetup_gData.checkpointType != 1) {
            DesiredComparison = PlayerPosition - 1;
          }
        }

        for (int j = 0; j < Cars_gNumRaceCars; j++) {
          if (Stats_GetPosition(Cars_gRaceCarList[j]) == DesiredComparison) {
            DesiredSlice = Cars_gRaceCarList[j]->stats.sliceTotal;
            if (trackSlices < DesiredSlice) {
              DesiredSlice = trackSlices;
            }

            if (PlayerPosition == 1) {
              DesiredSpeed =
                  ((Car_tObj * volatile *)Cars_gRaceCarList)[j]
                      ->linearVel_ch.z;
              if (DesiredSpeed < 0) {
                DesiredSpeed = -DesiredSpeed;
              }
              DesiredSpeed >>= 16;
            }
            else {
              DesiredSpeed =
                  *(short *)((char *)&Cars_gHumanRaceCarList[i]->linearVel_ch.z + 2);
            }
            break;
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
