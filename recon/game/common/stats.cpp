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
  int iVar1;
  int dist;
  Car_tObj *pCVar2;
  Car_tObj **ppCVar3;
  int i;
  int iVar4;
  Stats_tPosition *pSVar5;
  int humanLeader;
  int iVar6;
  
  iVar6 = 99;
  iVar4 = 0;
  if (0 < Cars_gNumRaceCars) {
    pSVar5 = Stats_racePosition;
    ppCVar3 = Cars_gRaceCarList;
    do {
      iVar1 = Stats_GetPosition(*ppCVar3);
      ((*ppCVar3)->stats).position = iVar1;
      if ((pSVar5->isHuman != 0) && (iVar6 == 99)) {
        iVar6 = iVar4;
      }
      pSVar5 = pSVar5 + 1;
      iVar4 = iVar4 + 1;
      ppCVar3 = ppCVar3 + 1;
    } while (iVar4 < Cars_gNumRaceCars);
  }
  if ((GameSetup_gData.catchupLogic != 0) && (GameSetup_gData.commMode == 1)) {
    ppCVar3 = Cars_gHumanRaceCarList;
    if (((Cars_gHumanRaceCarList[0]->stats).finishType == 2) ||
       ((Cars_gHumanRaceCarList[1]->stats).finishType == 2)) {
      Cars_gHumanRaceCarList[0]->glue = 0x10000;
      Cars_gHumanRaceCarList[1]->glue = 0x10000;
    }
    else {
      iVar4 = 0;
      if (0 < Cars_gNumHumanRaceCars) {
        do {
          pCVar2 = *ppCVar3;
          iVar1 = Stats_racePosition[iVar6].slice - (pCVar2->stats).sliceTotal;
          if (iVar1 < 5) {
            pCVar2->glue = 0x10000;
          }
          else {
            if (iVar1 < 10) {
              iVar1 = 0x10666;
            }
            else if (iVar1 < 0x1e) {
              iVar1 = 0x10ccc;
            }
            else if (iVar1 < 0x3c) {
              iVar1 = 0x11333;
            }
            else {
              iVar1 = 0x11999;
            }
            pCVar2->glue = iVar1;
          }
          iVar4 = iVar4 + 1;
          ppCVar3 = ppCVar3 + 1;
        } while (iVar4 < Cars_gNumHumanRaceCars);
      }
    }
  }
  return;
}

/* ---- Stats_ClearPosition__Fv  [STATS.CPP:112-120] SLD-VERIFIED ---- */
void Stats_ClearPosition(void)

{
  Stats_tPosition *pSVar1;
  int iVar2;
  int i;
  
  iVar2 = 0;
  pSVar1 = Stats_racePosition;
  do {
    pSVar1->car = -1;
    pSVar1->slice = -99999;
    pSVar1->sliceTime = 0;
    pSVar1->isHuman = 0;
    iVar2 = iVar2 + 1;
    pSVar1 = pSVar1 + 1;
  } while (iVar2 < 6);
  return;
}

/* ---- Stats_GetPosition__FP8Car_tObj  [STATS.CPP:126-139] SLD-VERIFIED ---- */
int Stats_GetPosition(Car_tObj *carObj)

{
  Stats_tPosition *pSVar1;
  int iVar2;
  int i;
  int position;
  int carindex;
  
  iVar2 = 0;
  if (0 < Cars_gNumRaceCars) {
    pSVar1 = Stats_racePosition;
    do {
      if (pSVar1->car == carObj->carIndex) {
        return iVar2 + 1;
      }
      iVar2 = iVar2 + 1;
      pSVar1 = pSVar1 + 1;
    } while (iVar2 < Cars_gNumRaceCars);
  }
  return 0;
}

/* ---- Stats_GetNumOpponents__Fv  [STATS.CPP:145-155] SLD-VERIFIED ---- */
int Stats_GetNumOpponents(void)

{
  Stats_tPosition *pSVar1;
  int iVar2;
  int numCars;
  int iVar3;
  int i;
  
  iVar3 = 0;
  iVar2 = 0;
  if (0 < Cars_gNumRaceCars) {
    pSVar1 = Stats_racePosition;
    do {
      if (pSVar1->car != -1) {
        iVar2 = iVar2 + 1;
      }
      iVar3 = iVar3 + 1;
      pSVar1 = pSVar1 + 1;
    } while (iVar3 < Cars_gNumRaceCars);
  }
  return iVar2;
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
  int j;
  int startingTime;
  int sliceTotal;
  int m;
  int *piVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  int averageLap;
  int iVar5;
  int iVar6;
  int y;
  Car_tObj *pCVar7;
  int position;
  int iVar8;
  Car_tObj **ppCVar9;
  int x;
  int extrapolatedTime;
  Car_tObj **ppCVar10;
  int i;
  int quick_finish;
  int iVar11;
  
  iVar3 = Input_Interface(3,0);
  bVar2 = iVar3 != 0;
  ppCVar10 = Cars_gHumanRaceCarList;
  for (iVar3 = 0; iVar3 < Cars_gNumHumanRaceCars; iVar3 = iVar3 + 1) {
    pCVar7 = *ppCVar10;
    if ((pCVar7->stats).finishType != 2) {
      iVar5 = (pCVar7->stats).sliceTotal;
      if (iVar5 < 1) {
        iVar5 = 1;
      }
      iVar8 = (pCVar7->stats).sliceTime + -0x200;
      if (iVar5 < 100) {
        iVar8 = iVar5 * 0xd;
      }
      iVar8 = iVar8 * (gNumSlices * GameSetup_gData.numLaps + (pCVar7->stats).extractSlice);
      iVar11 = iVar8 / iVar5;
      if (bVar2) {
        (pCVar7->stats).lapTime = iVar11;
      }
      else {
        (pCVar7->stats).lapTime = iVar11 << 1;
      }
      if ((GameSetup_gData.raceType != 2) || (GameSetup_gData.localCar == iVar3)) {
        if (bVar2) {
          ((*ppCVar10)->stats).finishType = 2;
        }
        else {
          ((*ppCVar10)->stats).finishType = 1;
        }
      }
    }
    if (type == 1) {
      if (GameSetup_gData.raceType == 2) {
        pCVar7 = *ppCVar10;
        if (((pCVar7->stats).finishType != 2) && (GameSetup_gData.localCar == iVar3)) {
          if (bVar2) {
            (pCVar7->stats).finishType = 2;
          }
          else {
            (pCVar7->stats).finishType = 1;
          }
        }
      }
      else if (bVar2) {
        ((*ppCVar10)->stats).finishType = 2;
      }
      else if (((*ppCVar10)->stats).finishType != 2) {
        ((*ppCVar10)->stats).finishType = 1;
      }
      iVar5 = Stats_GetPosition(*ppCVar10);
      ((*ppCVar10)->stats).finalPosition = iVar5;
      ((*ppCVar10)->stats).finalTotalTime = ((*ppCVar10)->stats).lapTime;
      iVar5 = 0;
      if (0 < GameSetup_gData.numLaps) {
        do {
          ((*ppCVar10)->stats).finalLapTime[iVar5] = ((*ppCVar10)->stats).time[iVar5];
          iVar5 = iVar5 + 1;
        } while (iVar5 < GameSetup_gData.numLaps);
      }
    }
    iVar5 = Stats_GetPosition(*ppCVar10);
    ((*ppCVar10)->stats).finalPosition = iVar5;
    iVar5 = Stats_GetPosition(*ppCVar10);
    ((*ppCVar10)->stats).finalPosition = iVar5;
    ((*ppCVar10)->stats).finalTotalTime = ((*ppCVar10)->stats).lapTime;
    ((*ppCVar10)->stats).finalFinishType = ((*ppCVar10)->stats).finishType;
    ((*ppCVar10)->stats).finalBestLap = ((*ppCVar10)->stats).time[0];
    ((*ppCVar10)->stats).finalNumWarnings = ((*ppCVar10)->stats).numWarnings;
    ((*ppCVar10)->stats).finalNumFines = ((*ppCVar10)->stats).numFines;
    iVar5 = 0;
    ((*ppCVar10)->stats).finalNumArrests = ((*ppCVar10)->stats).numArrests;
    ((*ppCVar10)->stats).finalDamage = 0;
    do {
      pCVar7 = *ppCVar10;
      piVar1 = (pCVar7->N).damage + iVar5;
      iVar5 = iVar5 + 1;
      (pCVar7->stats).finalDamage = (pCVar7->stats).finalDamage + *piVar1;
    } while (iVar5 < 10);
    iVar5 = 0;
    if (0 < GameSetup_gData.numLaps) {
      do {
        ((*ppCVar10)->stats).finalLapTime[iVar5] = ((*ppCVar10)->stats).time[iVar5];
        pCVar7 = *ppCVar10;
        iVar8 = (pCVar7->stats).finalLapTime[iVar5];
        if ((iVar8 < (pCVar7->stats).finalBestLap) && (iVar8 != 0)) {
          (pCVar7->stats).finalBestLap = iVar8;
        }
        iVar5 = iVar5 + 1;
      } while (iVar5 < GameSetup_gData.numLaps);
    }
    ppCVar10 = ppCVar10 + 1;
  }
  ppCVar10 = Cars_gAIRaceCarList;
  for (iVar3 = 0; iVar5 = Cars_gNumRaceCars, iVar3 < Cars_gNumAIRaceCars; iVar3 = iVar3 + 1) {
    pCVar7 = *ppCVar10;
    if ((pCVar7->stats).finishType != 2) {
      iVar5 = (pCVar7->stats).sliceTotal;
      if (iVar5 < 1) {
        iVar5 = 1;
      }
      iVar8 = (pCVar7->stats).sliceTime + -0x200;
      if (iVar5 < 100) {
        iVar8 = iVar5 * 0xd;
      }
      iVar8 = iVar8 * (gNumSlices * GameSetup_gData.numLaps + (pCVar7->stats).extractSlice);
      iVar11 = iVar8 / iVar5;
      if ((bVar2) || ((Cars_gHumanRaceCarList[0]->stats).finishType == 2)) {
        ((*ppCVar10)->stats).lapTime = iVar11;
      }
      else {
        iVar5 = rand();
        iVar5 = GameSetup_gData.numLaps * iVar5;
        if (iVar5 < 0) {
          iVar5 = iVar5 + 0x7f;
        }
        ((*ppCVar10)->stats).lapTime = iVar11 + (iVar5 >> 7);
      }
      ((*ppCVar10)->stats).finishType = 2;
    }
    iVar5 = Stats_GetPosition(*ppCVar10);
    ((*ppCVar10)->stats).finalPosition = iVar5;
    ((*ppCVar10)->stats).finalTotalTime = ((*ppCVar10)->stats).lapTime;
    ((*ppCVar10)->stats).finalFinishType = ((*ppCVar10)->stats).finishType;
    ((*ppCVar10)->stats).finalNumArrests = ((*ppCVar10)->stats).numArrests;
    ((*ppCVar10)->stats).finalBestLap = 99999;
    iVar5 = 0;
    if (0 < GameSetup_gData.numLaps) {
      do {
        pCVar7 = *ppCVar10;
        iVar8 = (pCVar7->stats).time[iVar5];
        if ((iVar8 < (pCVar7->stats).finalBestLap) && (0 < iVar8)) {
          (pCVar7->stats).finalBestLap = iVar8;
        }
        iVar5 = iVar5 + 1;
      } while (iVar5 < GameSetup_gData.numLaps);
    }
    iVar5 = rand();
    pCVar7 = *ppCVar10;
    iVar8 = (pCVar7->stats).finalTotalTime;
    iVar5 = iVar8 / GameSetup_gData.numLaps - iVar5 / 0x30;
    if (iVar5 < (pCVar7->stats).finalBestLap) {
      (pCVar7->stats).finalBestLap = iVar5;
    }
    iVar5 = 0;
    if (0 < GameSetup_gData.numLaps) {
      do {
        ((*ppCVar10)->stats).finalLapTime[iVar5] = ((*ppCVar10)->stats).time[iVar5];
        pCVar7 = *ppCVar10;
        iVar8 = (pCVar7->stats).finalLapTime[iVar5];
        if ((iVar8 < (pCVar7->stats).finalBestLap) && (iVar8 != 0)) {
          (pCVar7->stats).finalBestLap = iVar8;
        }
        iVar5 = iVar5 + 1;
      } while (iVar5 < GameSetup_gData.numLaps);
    }
    ppCVar10 = ppCVar10 + 1;
  }
  iVar3 = 0;
  if (!bVar2) {
    ppCVar10 = Cars_gRaceCarList;
    for (; iVar8 = 1, iVar3 < iVar5; iVar3 = iVar3 + 1) {
      iVar11 = 0;
      ppCVar9 = Cars_gRaceCarList;
      if (0 < iVar5) {
        do {
          if (iVar3 != iVar11) {
            iVar6 = ((*ppCVar10)->stats).finalTotalTime;
            iVar4 = ((*ppCVar9)->stats).finalTotalTime;
            if ((iVar4 < iVar6) || ((iVar6 == iVar4 && (iVar11 < iVar3)))) {
              iVar8 = iVar8 + 1;
            }
          }
          iVar11 = iVar11 + 1;
          ppCVar9 = ppCVar9 + 1;
        } while (iVar11 < Cars_gNumRaceCars);
      }
      pCVar7 = *ppCVar10;
      ppCVar10 = ppCVar10 + 1;
      (pCVar7->stats).finalPosition = iVar8;
    }
  }
  return;
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
