/* frontend/common/statchk.cpp  --  RECONSTRUCTED  (record-lap / top-time check + save; C++ TU)
 *   5 EXT free functions; C++ linkage (cfront-mangled). Bodies: Ghidra decompiler.
 *   Calls Stattool helpers + tCarManager::GetCarFromSimID (external method, declared free-form).
 */
#include "statchk.h"

/* MATCH (w35-a10): cc1plus expands a constant-size `memcpy` inline (movstrsi);
   retail emits a real `jal memcpy`.  Calling it under a different C name with
   an asm label defeats the builtin recognition while emitting the same
   symbol/relocation. */
extern "C" void *memcpy_call(void *dst, const void *src, int n) __asm__("memcpy");

/* MATCH (w35-a10): both are STRONG DATA symbols in front_data.data.s and every
   oracle reaches them absolutely (0 %gp_rel uses tree-wide).  A TU-owned
   tentative def makes NewBestLap small-common -> .sbss -> %gp_rel; the
   unsized-array asm-label view keeps %hi an RTL pseudo (catalog wave-13). */
extern int A_NewRecords[] __asm__("NewRecords");
extern int A_NewBestLap[] __asm__("NewBestLap");
#define NewRecords  A_NewRecords
#define NewBestLap  A_NewBestLap[0]

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
        if ((carInfo->fCarClass == 7) || (carInfo->fCarClass == 8)) {   /* MATCH: unsigned sltiu range fold */
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
      memcpy_call(&RecordHolder,TrackRecords,0x14);
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
  /* MATCH: the != pair range-folds to the oracle's UNSIGNED sltiu(x-7,2);
     a `1 < x - 7` spelling emits the signed slti. */
  if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {
    TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);
    track = Front_GetTrackRaced();
    Stattool_GetRecords(track,TrackRecords);
    memcpy_call(&RecordHolder,TrackRecords + 1,0x14);
    if ((dummyCars[nBestCarIndex].finalNumArrests == 0) &&
       (dummyCars[nBestCarIndex].finalFinishType == 2)) {
      DummyRaceResult.nTime = dummyCars[nBestCarIndex].finalTotalTime;
    }
    else {
      DummyRaceResult.nTime = 0;
    }
    DummyRaceResult.nBestLap = dummyCars[nBestCarIndex].finalBestLap;
    DummyRaceResult.nCar = *(signed char *)&carInfo->fCarID;   /* MATCH: lb, plain char is unsigned here */
    playerName = PlayerName((int)nBestCarIndex);
    strcpy(DummyRaceResult.sName,playerName);
    memcpy_call(TrackRecords,&DummyRaceResult,0x14);
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
    if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {   /* MATCH: unsigned sltiu range fold */
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

/* ---- StatChk_SaveTopTime  (statchk.cpp:464) ----
 * REWRITE (w36-a10): SYM 8c gives fsize=176, mask=$c0ff0000, and the EXACT
 * 17-local set below (bTopTenFlag AUTO, bDoRecordCheck REG $17, nLapIndicator
 * AUTO, nPlace AUTO, nTopTenSort[8]/nTopTenIndex[8]/topPlacements[2] AUTO,
 * nCheckTotalTime REG $3, k REG $10, nCar REG $12, buffer/nCarTotalTimes
 * AUTO, nRankCarTotalTimes REG $15, DummyRaceResult AUTO, RecordHolders
 * REG $16, carInfo REG $6). The prior Ghidra recon fabricated 9 extra
 * locals (track/sortIdx/idx/playerName/recBase/rank/pSlot/slot/pRec) that
 * inflated the frame to 192 B vs the SYM's 176 B. Every fabricated temp
 * below folds into a real SYM local by tracing that its value is IDENTICAL
 * to an already-live real local at that point (e.g. Ghidra's "k=*pSlot"
 * reassignment always equals the already-computed "nCar"; "recBase"/"pRec"
 * are always "nLapIndicator" itself, never copied). Single flat SYM scope
 * (Block start line=1 .. Block end line=188) => k/nCar/nCheckTotalTime are
 * each ONE real C variable reused sequentially across the function's
 * several small loops (classic C89 "declare once at top, reuse" style),
 * matching the sibling StatChk_IsTopTime in this same file. */
void StatChk_SaveTopTime(Car_tStats *dummyCars,short nNumCars)

{
  BOOL bTopTenFlag;
  BOOL bDoRecordCheck;
  short nLapIndicator;
  short nPlace;
  int nTopTenSort [8];
  short nTopTenIndex [8];
  Car_tStats *cars = dummyCars;
  int nCheckTotalTime;
  unsigned int uRecSz = sizeof(tRecordBuffer);
  short k;
  short nCar;
  char *buffer;
  int *nCarTotalTimes;
  short *nRankCarTotalTimes;
  tRecordBuffer DummyRaceResult;
  tRecordBuffer *RecordHolders;
  tCarInfo *carInfo;
  int topPlacements [2];

  bDoRecordCheck = false;
  bTopTenFlag = false;
  nPlace = 0;
  for (k = 0; k < 2; k = k + 1) {
    topPlacements[k] = 0;
  }

  RecordHolders = (tRecordBuffer *)reservememadr("toprcrds",uRecSz * 18,0x10);
  nCarTotalTimes = (int *)reservememadr("carttime",nNumCars * sizeof(int),0x10);
  nRankCarTotalTimes = (short *)reservememadr("carttrnk",nNumCars * sizeof(short),0x10);
  buffer = (char *)reservememadr("records",uRecSz * 8,0x10);

  for (k = 0; k < nNumCars; k = k + 1) {
    nRankCarTotalTimes[cars[k].position - 1] = k;
  }

  Stattool_GetRecords(Front_GetTrackRaced(),RecordHolders);

  nLapIndicator = 9;
  if (Front_GetLapsForType() == 2) {
    nLapIndicator = 1;
  }

  for (k = 0; k < nNumCars; k = k + 1) {
      nCar = nRankCarTotalTimes[k];
      carInfo = GetCarFromSimID(&carManager, (short)cars[nCar].carType);
      if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {   /* MATCH: unsigned sltiu range fold */
        if ((byte)frontEnd.gameMode < 3) {
StatChkSave_validateCarFinish:
          if (((cars[nCar].carFlags & 4U) != 0) && (cars[nCar].finalFinishType == 2))
          {
            bDoRecordCheck = true;
          }
        }
        else if (nCar == GameSetup_gData.localCar) {
          goto StatChkSave_validateCarFinish;
        }
        if (bDoRecordCheck) {
          nCheckTotalTime = cars[nCar].finalTotalTime;
          bDoRecordCheck = false;
          if ((nCheckTotalTime < RecordHolders[nLapIndicator + 7].nTime) ||
             ((RecordHolders[nLapIndicator + 7].nTime == 0) && (0 < nCheckTotalTime))) {
            DummyRaceResult.nCar = *(signed char *)&carInfo->fCarID;   /* MATCH: lb, plain char is unsigned here */
            bTopTenFlag = true;
            DummyRaceResult.nBestLap = cars[nCar].finalBestLap;
            *(u_long *)RecordHolders[nLapIndicator + 7].sName = *(u_long *)DummyRaceResult.sName;
            *(u_long *)(RecordHolders[nLapIndicator + 7].sName + 4) = *(u_long *)(DummyRaceResult.sName + 4);
            RecordHolders[nLapIndicator + 7].nCar = DummyRaceResult.nCar;
            RecordHolders[nLapIndicator + 7].nTime = nCheckTotalTime;
            RecordHolders[nLapIndicator + 7].nBestLap = DummyRaceResult.nBestLap;
            DummyRaceResult.nTime = nCheckTotalTime;
            for (nCheckTotalTime = nLapIndicator; nCheckTotalTime < nLapIndicator + 8;
                 nCheckTotalTime = nCheckTotalTime + 1) {
              nTopTenSort[nCheckTotalTime - nLapIndicator] = RecordHolders[nCheckTotalTime].nTime;
              if (RecordHolders[nCheckTotalTime].nTime == 0) {
                nTopTenSort[nCheckTotalTime - nLapIndicator] = (nCheckTotalTime + 1) * 0x23280;
              }
            }
            Stattool_nCreateIndex(8,nTopTenSort,nTopTenIndex);
            for (nCheckTotalTime = 0; nCheckTotalTime < 8; nCheckTotalTime = nCheckTotalTime + 1) {
              if (nTopTenIndex[nCheckTotalTime] == 7) {
                nPlace = nCheckTotalTime + 1;
              }
            }
            for (nCheckTotalTime = 0; nCheckTotalTime < 8; nCheckTotalTime = nCheckTotalTime + 1) {
              if (nTopTenIndex[nCheckTotalTime] == nCar) {
                topPlacements[nCar] = (int)nPlace;
                break;
              }
            }
            strcpy(DummyRaceResult.sName,PlayerName((int)nCar));
            *(u_long *)RecordHolders[nLapIndicator + 7].sName = *(u_long *)DummyRaceResult.sName;
            *(u_long *)(RecordHolders[nLapIndicator + 7].sName + 4) = *(u_long *)(DummyRaceResult.sName + 4);
            RecordHolders[nLapIndicator + 7].nCar = DummyRaceResult.nCar;
            RecordHolders[nLapIndicator + 7].nTime = DummyRaceResult.nTime;
            RecordHolders[nLapIndicator + 7].nBestLap = DummyRaceResult.nBestLap;
            memcpy_call(buffer,&RecordHolders[nLapIndicator],uRecSz * 8);
            for (nCheckTotalTime = 0; nCheckTotalTime < 8; nCheckTotalTime = nCheckTotalTime + 1) {
              memcpy(&RecordHolders[nLapIndicator + nCheckTotalTime],
                     buffer + nTopTenIndex[nCheckTotalTime] * uRecSz,uRecSz);
            }
          }
        }
      }
  }
  if (bTopTenFlag) {
    blockmove(RecordHolders,Stats_gTrackRecords + Front_GetTrackRaced() * 0x11,0x154);
  }
  if (topPlacements[0] == topPlacements[1]) {
    topPlacements[1] = topPlacements[0] + 1;
  }
  else if ((topPlacements[1] != 0) && (topPlacements[1] < topPlacements[0])) {
    topPlacements[0] = topPlacements[0] + 1;
  }
  for (k = 0; k < 2; k = k + 1) {
    if ((topPlacements[k] != 0) && (topPlacements[k] < 9)) {
      NewRecords[topPlacements[k] - 1] = 1;
    }
  }
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
  pRec = NewRecords;
  pRec = pRec + 7;   /* MATCH: split -> la NewRecords + separate addiu 0x1C (oracle unfused) */
  do {
    *pRec = 0;
    i = i + -1;
    pRec = pRec + -1;
  } while (-1 < i);
  NewBestLap = 0;
  return;
}

/* end of statchk.cpp */