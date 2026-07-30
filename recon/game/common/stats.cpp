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
  int roadSlice;
  int *piVar1;
  int iVar2;
  u_int uVar3;
  int r1;
  int iVar4;
  int r2;
  int iVar5;
  int iVar6;
  int r3;
  int iVar7;
  int r4;
  int iVar8;
  Stats_tPosition *pSVar9;
  int j;
  Stats_tPosition *pSVar10;
  int i;
  int currentTime;
  int trackSlices;
  
  iVar5 = gNumSlices;
  iVar6 = simGlobal.gameTicks;
  if ((simGlobal.gameTicks & 1U) == 0) {
    r2 = (carObj->stats).lap;
    if ((r2 < 4) && ((carObj->stats).topSpeed[r2] < (carObj->linearVel_ch).z)) {
      if (((carObj->carFlags & 8U) == 0) || (0x12 < carObj->carInfo->carType)) {
        (carObj->stats).topSpeed[(carObj->stats).lap] = (carObj->linearVel_ch).z;
      }
      else {
        iVar2 = rand();
        iVar4 = (carObj->linearVel_ch).z;
        if (Cars_topSpeedCap[carObj->carInfo->carType] + iVar2 * -3 < iVar4) {
          iVar2 = rand();
          iVar4 = Cars_topSpeedCap[carObj->carInfo->carType] + iVar2 * -3;
        }
        (carObj->stats).topSpeed[r2] = iVar4;
      }
    }
    iVar2 = (carObj->stats).lap;
    if ((iVar2 != carObj->lap) && ((carObj->stats).finishType == 0)) {
      if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
         (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0 ||
          ((Cars_gNumHumanRaceCars == 2 && ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0)))))
         ) {
        (carObj->stats).time[iVar2] = 99999;
      }
      else {
        (carObj->stats).time[(carObj->stats).lap] = iVar6 - (carObj->stats).lapTime;
      }
      iVar2 = carObj->lap;
      (carObj->stats).lapTime = iVar6;
      (carObj->stats).lap = iVar2;
      if ((iVar2 == GameSetup_gData.numLaps) &&
         (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
          (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 &&
           ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0))))
          )))) {
        (carObj->stats).sliceTime = iVar6;
        (carObj->stats).finishType = 2;
        (carObj->stats).lapTime = (carObj->stats).lapTime + -0x200;
        (carObj->stats).sliceTotal = ((carObj->stats).lap + 1) * iVar5;
      }
    }
    if (GameSetup_gData.reverseTrack == 0) {
      iVar2 = (int)(carObj->N).simRoadInfo.slice;
    }
    else {
      iVar2 = (iVar5 - (carObj->N).simRoadInfo.slice) + -1;
    }
    if (((carObj->stats).slice != iVar2) &&
       ((carObj->stats).slice = iVar2, (carObj->stats).finishType == 0)) {
      iVar2 = carObj->unlap;
      (carObj->stats).sliceTime = iVar6;
      (carObj->stats).sliceTotal = ((carObj->stats).lap - iVar2) * iVar5 + (carObj->stats).slice;
    }
    pSVar10 = Stats_racePosition;
    for (iVar6 = 0; iVar6 < Cars_gNumRaceCars; iVar6 = iVar6 + 1) {
      iVar5 = (carObj->stats).sliceTotal;
      iVar2 = Cars_gNumRaceCars + -2;
      if ((pSVar10->slice < iVar5) ||
         ((iVar5 == pSVar10->slice && ((carObj->stats).sliceTime < pSVar10->sliceTime)))) {
        pSVar9 = Stats_racePosition + iVar2;
        iVar5 = iVar2 * 0x10 + 0x10;
        for (; iVar6 <= iVar2; iVar2 = iVar2 + -1) {
          piVar1 = &pSVar9->car;
          iVar4 = pSVar9->slice;
          iVar7 = pSVar9->sliceTime;
          iVar8 = pSVar9->isHuman;
          pSVar9 = pSVar9 + -1;
          *(int *)((int)&Stats_racePosition[0].car + iVar5) = *piVar1;
          *(int *)((int)&Stats_racePosition[0].slice + iVar5) = iVar4;
          *(int *)((int)&Stats_racePosition[0].sliceTime + iVar5) = iVar7;
          *(int *)((int)&Stats_racePosition[0].isHuman + iVar5) = iVar8;
          iVar5 = iVar5 + -0x10;
        }
        iVar6 = (carObj->stats).sliceTotal;
        uVar3 = carObj->carFlags;
        iVar5 = (carObj->stats).sliceTime;
        pSVar10->car = carObj->carIndex;
        pSVar10->slice = iVar6;
        pSVar10->sliceTime = iVar5;
        pSVar10->isHuman = uVar3 & 4;
        return;
      }
      pSVar10 = pSVar10 + 1;
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
  int iVar1;
  int iVar2;
  int iVar3;
  int r1;
  int iVar4;
  int averageLap;
  Car_tObj *pCVar5;
  int y;
  int trackSlices;
  int startingTime;
  int i;
  int iVar6;
  int carindex;
  int x;
  int extrapolatedTime;
  Car_tObj **ppCVar7;
  int j;
  int iVar8;
  int DesiredComparison;
  int iVar9;
  int quick_finish;
  Car_tObj **ppCVar10;
  int DesiredSpeed;
  int PlayerPosition;
  int DesiredSlice;
  int iVar11;
  int Stats_PlayersFinishedRace;
  int PlayerSlice;
  
  Stats_PlayersFinishedRace = 0;
  if (1 < Cars_gNumRaceCars) {
    iVar1 = simGlobal.gameTicks;
    if (simGlobal.gameTicks < 0) {
      iVar1 = simGlobal.gameTicks + 0x3f;
    }
    if ((iVar1 >> 6) << 6 == simGlobal.gameTicks + -1) {
      iVar1 = GameSetup_gData.numLaps * gNumSlices;
      ppCVar10 = Cars_gHumanRaceCarList;
      for (iVar6 = 0; iVar6 < Cars_gNumHumanRaceCars; iVar6 = iVar6 + 1) {
        iVar4 = ((*ppCVar10)->stats).sliceTotal;
        PlayerSlice = iVar1;
        if (iVar4 <= iVar1) {
          PlayerSlice = iVar4;
        }
        iVar2 = Stats_GetPosition(*ppCVar10);
        iVar11 = 0;
        iVar4 = 0;
        if (iVar2 == 1) {
          iVar9 = 2;
        }
        else {
          iVar9 = 1;
          if (GameSetup_gData.checkpointType != 1) {
            iVar9 = iVar2 + -1;
          }
        }
        ppCVar7 = Cars_gRaceCarList;
        for (iVar8 = 0; iVar8 < Cars_gNumRaceCars; iVar8 = iVar8 + 1) {
          iVar3 = Stats_GetPosition(*ppCVar7);
          if (iVar3 == iVar9) {
            iVar4 = ((*ppCVar7)->stats).sliceTotal;
            iVar11 = iVar1;
            if (iVar4 <= iVar1) {
              iVar11 = iVar4;
            }
            if (iVar2 == 1) {
              iVar4 = (Cars_gRaceCarList[iVar8]->linearVel_ch).z;
              if (iVar4 < 0) {
                iVar4 = -iVar4;
              }
              iVar4 = iVar4 >> 0x10;
            }
            else {
              iVar4 = (int)*(short *)((int)&((*ppCVar10)->linearVel_ch).z + 2);
            }
            break;
          }
          ppCVar7 = ppCVar7 + 1;
        }
        ((*ppCVar10)->stats).checkpointUpdate = iVar11 - PlayerSlice;
        if ((iVar4 < 0x10) || (pCVar5 = *ppCVar10, (pCVar5->stats).finishType == 2)) {
          ((*ppCVar10)->stats).checkpointDifference = 0;
          ((*ppCVar10)->stats).checkpointDisplay = 0;
        }
        else {
          iVar11 = (pCVar5->stats).checkpointUpdate * 0x180;
          (pCVar5->stats).checkpointDifference = iVar11 / iVar4;
          ((*ppCVar10)->stats).checkpointDisplay = 1;
        }
        ppCVar10 = ppCVar10 + 1;
      }
    }
  }
  if (simVar.endSimGame == 0) {
    iVar1 = 0;
    if (0 < Cars_gNumHumanRaceCars) {
      trackSlices = (int)Cars_gHumanRaceCarList;
      do {
        if (((1 < *(int *)(*(int *)trackSlices + 0x390)) &&
            (iVar6 = *(int *)(*(int *)trackSlices + 0x354), iVar6 + 0x140 < simGlobal.gameTicks)) &&
           (((CopSpeak_gQueuePlay == CopSpeak_gQueueHead && (CopSpeak_gSpchHandle == -1)) ||
            (iVar6 + 0x280 < simGlobal.gameTicks)))) {
          Stats_PlayersFinishedRace = Stats_PlayersFinishedRace + 1;
        }
        iVar1 = iVar1 + 1;
        trackSlices = trackSlices + 4;
      } while (iVar1 < Cars_gNumHumanRaceCars);
    }
    if (Stats_PlayersFinishedRace == Cars_gNumHumanRaceCars) {
      simVar.endSimGame = 1;
      Stats_ExtrapolateOpponentTimes(2);
    }
  }
  return;
}

/* end of stats.cpp */
