/* frontend/common/statchk.cpp  --  RECONSTRUCTED  (record-lap / top-time check + save; C++ TU)
 *   5 EXT free functions; C++ linkage (cfront-mangled). Bodies: Ghidra decompiler.
 *   Calls Stattool helpers + tCarManager::GetCarFromSimID (external method, declared free-form).
 */
#include "statchk.h"

int NewRecords[8];   /* 0x... per-slot new-record flags */
int NewBestLap;      /* new best-lap flag */

/* ---- StatChk_IsRecordLapTime  (statchk.cpp:50) ---- */
void * StatChk_IsRecordLapTime(Car_tStats *dummyCars,short nNumCars,short *nBestCarIndex)

{
  bool bCheckLapRecords;
  short idx;
  short nShowTrack;
  tCarInfo *carInfo;
  void *result;
  int *nBestLapTimes;
  short *nRankBestLapTimes;
  tRecordBuffer *TrackRecords;
  int innerIdx;
  int numCars;
  short i;
  tRecordBuffer RecordHolder;
  short bBestLapFlag;
  
  bBestLapFlag = 0;
  idx = Stattool_CheckForHumanCar(dummyCars);
  if (idx == 1) {
    numCars = (int)nNumCars;
    nBestLapTimes = (int *)reservememadr("ranklap",numCars << 2,0x10);
    nRankBestLapTimes = (short *)reservememadr("rankbst",numCars << 1,0x10);
    TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);
    i = 0;
    if (0 < numCars) {
      innerIdx = 0;
      do {
        innerIdx = innerIdx >> 0x10;
        carInfo = GetCarFromSimID(&carManager, (short)dummyCars[innerIdx].carType);
        if ((dummyCars[innerIdx].carFlags & 0x200U) != 0) {
          purgememadr(nBestLapTimes);
          purgememadr(nRankBestLapTimes);
          purgememadr(TrackRecords);
          return (void *)0x0;
        }
        if (carInfo->fCarClass - 7 < 2) {
          nBestLapTimes[innerIdx] = (innerIdx + 1) * 0x23280;
        }
        else {
          nBestLapTimes[innerIdx] = dummyCars[innerIdx].finalBestLap;
        }
        i = i + 1;
        innerIdx = i * 0x10000;
      } while (i * 0x10000 >> 0x10 < numCars);
    }
    if (nNumCars < 2) {
      *nRankBestLapTimes = 0;
    }
    else {
      Stattool_nCreateIndex((int)nNumCars,nBestLapTimes,nRankBestLapTimes);
    }
    i = 0;
    bCheckLapRecords = true;
    if (0 < nNumCars) {
      do {
        idx = *(short *)(((i << 0x10) >> 0xf) + (int)nRankBestLapTimes);
        if (((dummyCars[idx].carFlags & 4U) != 0) &&
           (bCheckLapRecords = true, 0 < dummyCars[nRankBestLapTimes[idx]].finalBestLap)) break;
        i = i + 1;
        bCheckLapRecords = false;
      } while (i * 0x10000 >> 0x10 < (int)nNumCars);
    }
    if (bCheckLapRecords) {
      idx = *(short *)(((i << 0x10) >> 0xf) + (int)nRankBestLapTimes);
      nShowTrack = Front_GetTrackRaced();
      Stattool_GetRecords(nShowTrack,TrackRecords);
      memcpy(&RecordHolder,TrackRecords,0x14);
      if (((dummyCars[idx].finalBestLap < RecordHolder.nBestLap) || (RecordHolder.nBestLap == 0))
         && (0 < dummyCars[idx].finalBestLap)) {
        bBestLapFlag = 1;
      }
      *nBestCarIndex = idx;
    }
    purgememadr(nBestLapTimes);
    purgememadr(nRankBestLapTimes);
    purgememadr(TrackRecords);
    result = (void *)(uint)(ushort)bBestLapFlag;
  }
  else {
    result = (void *)0x0;
  }
  return result;
}

/* ---- StatChk_SaveRecordLapTime  (statchk.cpp:227) ---- */
void StatChk_SaveRecordLapTime(Car_tStats *dummyCars,short nNumCars,short nBestCarIndex)

{
  short track;
  tCarInfo *carInfo;
  tRecordBuffer *TrackRecords;
  char *playerName;
  tRecordBuffer RecordHolder;
  tRecordBuffer DummyRaceResult;
  
  carInfo = GetCarFromSimID(&carManager, (short)dummyCars[nBestCarIndex].carType);
  if (1 < carInfo->fCarClass - 7) {
    TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);
    track = Front_GetTrackRaced();
    Stattool_GetRecords(track,TrackRecords);
    memcpy(&RecordHolder,TrackRecords + 1,0x14);
    if ((dummyCars[nBestCarIndex].finalNumArrests == 0) &&
       (dummyCars[nBestCarIndex].finalFinishType == 2)) {
      DummyRaceResult.nTime = dummyCars[nBestCarIndex].finalTotalTime;
    }
    else {
      DummyRaceResult.nTime = 0;
    }
    DummyRaceResult.nBestLap = dummyCars[nBestCarIndex].finalBestLap;
    DummyRaceResult.nCar = (int)carInfo->fCarID;
    playerName = PlayerName((int)nBestCarIndex);
    strcpy(DummyRaceResult.sName,playerName);
    memcpy(TrackRecords,&DummyRaceResult,0x14);
    track = Front_GetTrackRaced();
    blockmove(TrackRecords,Stats_gTrackRecords + track * 0x11,0x154);
    NewBestLap = 1;
    purgememadr(TrackRecords);
  }
  return;
}

/* ---- StatChk_IsTopTime  (statchk.cpp:285) ---- */
short StatChk_IsTopTime(Car_tStats *dummyCars,short nNumCars)

{
  bool bDoRecordCheck;
  short nCar;
  int k;
  tRecordBuffer *RecordHolders;
  void *nCarTotalTimes;
  void *nRankCarTotalTimes;
  tCarInfo *carInfo;
  int idx;
  short *pSlot;
  uint nLapIndicator;
  ushort retvalue;
  int nCheckTotalTime;
  int LASTPLACE [2];
  int TOPLIST [2];
  int NUMBERONE [2];
  
  bDoRecordCheck = false;
  k = Front_GetLapsForType();
  carInfo = (tCarInfo *)LASTPLACE;
  memset(carInfo,0,8);
  memset(TOPLIST,0,8);
  memset(NUMBERONE,0,8);
  RecordHolders = (tRecordBuffer *)reservememadr("toprcrds",0x168,0x10);
  nCheckTotalTime = (int)(short)nNumCars;
  nCarTotalTimes = (int *)reservememadr("carttime",nCheckTotalTime << 2,0x10);
  nRankCarTotalTimes = (short *)reservememadr("carttrnk",nCheckTotalTime << 1,0x10);
  retvalue = 0;
  if (0 < nCheckTotalTime) {
    idx = 0;
    do {
      *(ushort *)((int)nRankCarTotalTimes + dummyCars[idx >> 0x10].position * 2 + -2) = retvalue;
      retvalue = retvalue + 1;
      idx = (uint)retvalue << 0x10;
    } while ((short)retvalue < nCheckTotalTime);
  }
  nCar = Front_GetTrackRaced();
  Stattool_GetRecords(nCar,RecordHolders);
  nLapIndicator = 9;
  if ((short)k == 2) {
    nLapIndicator = 1;
  }
  nLapIndicator = nLapIndicator << 2 | nLapIndicator;
  for (k = 0; nCheckTotalTime = (k << 0x10) >> 0x10, k << 0x10 < (int)((uint)nNumCars << 0x10);
      k = k + 1) {
    carInfo = GetCarFromSimID(&carManager, (short)dummyCars[nCheckTotalTime].carType);
    nCar = *(short *)(nCheckTotalTime * 2 + (int)nRankCarTotalTimes);
    if ((dummyCars[nCar].carFlags & 0x200U) != 0) {
      purgememadr(RecordHolders);
      purgememadr(nCarTotalTimes);
      purgememadr(nRankCarTotalTimes);
      return 0;
    }
    if (1 < carInfo->fCarClass - 7) {
      if ((((byte)frontEnd.gameMode < 3) && ((dummyCars[nCar].carFlags & 4U) != 0)) &&
         (dummyCars[nCar].finalFinishType == 2)) {
        bDoRecordCheck = true;
      }
      if (bDoRecordCheck) {
        nCar = *(short *)(((k << 0x10) >> 0xf) + (int)nRankCarTotalTimes);
        nCheckTotalTime = dummyCars[nCar].finalTotalTime;
        bDoRecordCheck = false;
        if ((nCheckTotalTime < *(int *)(RecordHolders[6].sName + nLapIndicator * 4 + 0xc)) ||
           ((*(int *)(RecordHolders[7].sName + nLapIndicator * 4 + 0xc) == 0 && (0 < nCheckTotalTime)))) {
          TOPLIST[nCar] = 1;
        }
        else if ((nCheckTotalTime < *(int *)(RecordHolders[7].sName + nLapIndicator * 4 + 0xc)) ||
                ((*(int *)(RecordHolders[7].sName + nLapIndicator * 4 + 0xc) == 0 && (0 < nCheckTotalTime)))) {
          pSlot = (short *)(((k << 0x10) >> 0xf) + (int)nRankCarTotalTimes);
          TOPLIST[*pSlot] = 1;
          LASTPLACE[*pSlot] = 1;
        }
        if ((nCheckTotalTime < *(int *)(RecordHolders->sName + nLapIndicator * 4 + 0xc)) ||
           ((*(int *)(RecordHolders[7].sName + nLapIndicator * 4 + 0xc) == 0 && (0 < nCheckTotalTime)))) {
          pSlot = (short *)(((k << 0x10) >> 0xf) + (int)nRankCarTotalTimes);
          TOPLIST[*pSlot] = 1;
          NUMBERONE[*pSlot] = 1;
        }
      }
    }
  }
  if (LASTPLACE[0] == 0) {
StatChkTop_lastPlace0Check:
    if ((LASTPLACE[1] == 0) || (TOPLIST[0] == 0)) goto StatChkTop_topListJoin;
  }
  else {
    if (LASTPLACE[1] == 0) {
      if (TOPLIST[1] != 0) {
        TOPLIST[0] = 0;
        goto StatChkTop_topListJoin;
      }
      goto StatChkTop_lastPlace0Check;
    }
    if (dummyCars[1].finalTotalTime < dummyCars->finalTotalTime) {
      TOPLIST[0] = 0;
      goto StatChkTop_topListJoin;
    }
  }
  TOPLIST[1] = 0;
StatChkTop_topListJoin:
  if ((NUMBERONE[0] != 0) && (NUMBERONE[1] != 0)) {
    if (dummyCars[1].finalTotalTime < dummyCars->finalTotalTime) {
      NUMBERONE[0] = 0;
    }
    else {
      NUMBERONE[1] = 0;
    }
  }
  retvalue = (ushort)(TOPLIST[0] != 0);
  if (NUMBERONE[0] != 0) {
    retvalue = retvalue | 2;
  }
  if (TOPLIST[1] != 0) {
    retvalue = retvalue | 4;
  }
  if (NUMBERONE[1] != 0) {
    retvalue = retvalue | 8;
  }
  purgememadr(RecordHolders);
  purgememadr(nCarTotalTimes);
  purgememadr(nRankCarTotalTimes);
  return retvalue;
}

/* ---- StatChk_SaveTopTime  (statchk.cpp:464) ---- */
void StatChk_SaveTopTime(Car_tStats *dummyCars,short nNumCars)

{
  bool bDoRecordCheck;
  bool bTopTenFlag;
  short track;
  ushort sortIdx;
  int idx;
  tRecordBuffer *RecordHolders;
  void *nCarTotalTimes;
  void *nRankCarTotalTimes;
  void *buffer;
  tCarInfo *carInfo;
  char *playerName;
  int nCheckTotalTime;
  uint recBase;
  short k;
  ushort rank;
  short *pSlot;
  uint slot;
  short nCar;
  tRecordBuffer *pRec;
  int nTopTenSort [8];
  short nTopTenIndex [8];
  tRecordBuffer DummyRaceResult;
  int topPlacements [2];
  short nLapIndicator;
  short nPlace;
  
  bDoRecordCheck = false;
  k = 0;
  bTopTenFlag = false;
  nPlace = 0;
  idx = 0;
  do {
    *(u_long *)((int)topPlacements + (idx >> 0xe)) = 0;
    k = k + 1;
    idx = k * 0x10000;
  } while (k * 0x10000 >> 0x10 < 2);
  RecordHolders = (tRecordBuffer *)reservememadr("toprcrds",0x168,0x10);
  idx = (int)(short)nNumCars;
  nCarTotalTimes = (int *)reservememadr("carttime",idx << 2,0x10);
  nRankCarTotalTimes = (short *)reservememadr("carttrnk",idx << 1,0x10);
  buffer = (char *)reservememadr("records",0xa0,0x10);
  rank = 0;
  if (0 < idx) {
    k = 0;
    do {
      *(ushort *)((int)nRankCarTotalTimes + dummyCars[k >> 0x10].position * 2 + -2) = rank;
      rank = rank + 1;
      k = (uint)rank << 0x10;
    } while ((short)rank < idx);
  }
  track = Front_GetTrackRaced();
  Stattool_GetRecords(track,RecordHolders);
  idx = Front_GetLapsForType();
  nLapIndicator = 9;
  if (idx == 2) {
    nLapIndicator = 1;
  }
  idx = 0;
  if (0 < (int)((uint)nNumCars << 0x10)) {
    recBase = (uint)(ushort)nLapIndicator;
    pRec = RecordHolders + recBase;
    k = 0;
    do {
      pSlot = (short *)((k >> 0xf) + (int)nRankCarTotalTimes);
      carInfo = GetCarFromSimID(&carManager, (short)dummyCars[*pSlot].carType);
      if (1 < carInfo->fCarClass - 7) {
        if ((byte)frontEnd.gameMode < 3) {
          k = (int)*pSlot;
StatChkSave_validateCarFinish:
          if (((dummyCars[k].carFlags & 4U) != 0) && (dummyCars[k].finalFinishType == 2))
          {
            bDoRecordCheck = true;
          }
        }
        else {
          k = (int)*pSlot;
          if (k == GameSetup_gData.localCar) goto StatChkSave_validateCarFinish;
        }
        if (bDoRecordCheck) {
          pSlot = (short *)(((idx << 0x10) >> 0xf) + (int)nRankCarTotalTimes);
          k = dummyCars[*pSlot].finalTotalTime;
          bDoRecordCheck = false;
          if ((k < pRec[7].nTime) || ((pRec[7].nTime == 0 && (0 < k)))) {
            DummyRaceResult.nCar = (int)carInfo->fCarID;
            slot = (uint)(ushort)nLapIndicator;
            bTopTenFlag = true;
            DummyRaceResult.nBestLap = dummyCars[*pSlot].finalBestLap;
            *(u_long *)pRec[7].sName = *(u_long *)(DummyRaceResult.sName);
            *(u_long *)(pRec[7].sName + 4) = *(u_long *)(DummyRaceResult.sName + 4);
            pRec[7].nCar = DummyRaceResult.nCar;
            pRec[7].nTime = k;
            pRec[7].nBestLap = DummyRaceResult.nBestLap;
            DummyRaceResult.nTime = k;
            if (recBase < recBase + 8) {
              do {
                nCheckTotalTime = (int)(short)slot;
                k = RecordHolders[nCheckTotalTime].nTime;
                nTopTenSort[nCheckTotalTime - recBase] = k;
                if (k == 0) {
                  nTopTenSort[nCheckTotalTime - recBase] = (nCheckTotalTime + 1) * 0x23280;
                }
                slot = slot + 1;
              } while ((int)(slot * 0x10000) >> 0x10 < (int)(recBase + 8));
            }
            Stattool_nCreateIndex(8,nTopTenSort,nTopTenIndex);
            k = 0;
            rank = 0;
            do {
              sortIdx = rank + 1;
              if (*(short *)((int)nTopTenIndex + (k >> 0xf)) == 7) {
                nPlace = rank + 1;
              }
              k = (uint)sortIdx << 0x10;
              rank = sortIdx;
            } while ((short)sortIdx < 8);
            nCheckTotalTime = 0;
            k = 0;
            do {
              k = (int)*(short *)((int)nTopTenIndex + (k >> 0xf));
              if (k == *(short *)(((idx << 0x10) >> 0xf) + (int)nRankCarTotalTimes)) {
                topPlacements[k] = (int)nPlace;
                break;
              }
              nCheckTotalTime = nCheckTotalTime + 1;
              k = nCheckTotalTime * 0x10000;
            } while (nCheckTotalTime * 0x10000 >> 0x10 < 8);
            k = 0;
            playerName = PlayerName((int)*(short *)(((idx << 0x10) >> 0xf) + (int)nRankCarTotalTimes));
            strcpy(DummyRaceResult.sName,playerName);
            *(u_long *)pRec[7].sName = *(u_long *)(DummyRaceResult.sName);
            *(u_long *)(pRec[7].sName + 4) = *(u_long *)(DummyRaceResult.sName + 4);
            pRec[7].nCar = DummyRaceResult.nCar;
            pRec[7].nTime = DummyRaceResult.nTime;
            pRec[7].nBestLap = DummyRaceResult.nBestLap;
            memcpy(buffer,pRec,0xa0);
            nCheckTotalTime = 0;
            do {
              memcpy
                        (RecordHolders + recBase + (nCheckTotalTime >> 0x10),
                         (void *)((int)buffer + nTopTenIndex[nCheckTotalTime >> 0x10] * 0x14),0x14);
              k = k + 1;
              nCheckTotalTime = k * 0x10000;
            } while (k * 0x10000 >> 0x10 < 8);
          }
        }
      }
      idx = idx + 1;
      k = idx * 0x10000;
    } while (idx * 0x10000 < (int)((uint)nNumCars << 0x10));
  }
  if (bTopTenFlag) {
    track = Front_GetTrackRaced();
    blockmove(RecordHolders,Stats_gTrackRecords + track * 0x11,0x154);
  }
  if (topPlacements[0] == topPlacements[1]) {
    topPlacements[1] = topPlacements[0] + 1;
  }
  else if ((topPlacements[1] != 0) && (topPlacements[1] < topPlacements[0])) {
    topPlacements[0] = topPlacements[0] + 1;
  }
  k = 0;
  idx = 0;
  do {
    idx = *(int *)((int)topPlacements + (idx >> 0xe));
    if ((idx != 0) && (idx < 9)) {
      NewRecords[idx + -1] = 1;
    }
    k = k + 1;
    idx = k * 0x10000;
  } while (k * 0x10000 >> 0x10 < 2);
  purgememadr(buffer);
  purgememadr(RecordHolders);
  purgememadr(nCarTotalTimes);
  purgememadr(nRankCarTotalTimes);
  return;
}

/* ---- StatChk_ClearNewRecords  (statchk.cpp:664) ---- */
void StatChk_ClearNewRecords(void)

{
  int *pRec;
  int i;
  
  i = 7;
  pRec = NewRecords + 7;
  do {
    *pRec = 0;
    i = i + -1;
    pRec = pRec + -1;
  } while (-1 < i);
  NewBestLap = 0;
  return;
}

/* end of statchk.cpp */