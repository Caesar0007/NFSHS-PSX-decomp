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
  short bBestLapFlag;
  short bCheckLapRecords;
  short i;
  int *nBestLapTimes;
  short *nRankBestLapTimes;
  short nBestCarIndexTemp;
  short nNewRecordHolder;
  tRecordBuffer RecordHolder;
  tRecordBuffer *TrackRecords;
  tCarInfo *carInfo;
  
  bBestLapFlag = 0;
  bCheckLapRecords = Stattool_CheckForHumanCar(dummyCars);
  if (bCheckLapRecords != 1) {
    return (void *)0x0;
  }
    nBestLapTimes = (int *)reservememadr("ranklap",nNumCars * sizeof(int),0x10);
    nRankBestLapTimes = (short *)reservememadr("rankbst",nNumCars * sizeof(short),0x10);
    TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);
    for (i = 0; i < nNumCars; i++) {
      carInfo = GetCarFromSimID(&carManager, (short)dummyCars[i].carType);
      if ((dummyCars[i].carFlags & 0x200U) != 0) {
        goto InvalidCar;
      }
      if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {
        nBestLapTimes[i] = dummyCars[i].finalBestLap;
      }
      else {
        nBestLapTimes[i] = (i + 1) * 0x23280;
      }
    }
    if (nNumCars >= 2) {
      Stattool_nCreateIndex((int)nNumCars,nBestLapTimes,nRankBestLapTimes);
    }
    else {
      *nRankBestLapTimes = 0;
    }
    for (nNewRecordHolder = 0; nNewRecordHolder < nNumCars; nNewRecordHolder++) {
        nBestCarIndexTemp = nRankBestLapTimes[nNewRecordHolder];
        if (((dummyCars[nBestCarIndexTemp].carFlags & 4U) != 0) &&
           (0 < dummyCars[nRankBestLapTimes[nBestCarIndexTemp]].finalBestLap)) {
          bCheckLapRecords = 1;
          break;
        }
        bCheckLapRecords = 0;
    }
    if (bCheckLapRecords) goto CheckRecord;
    purgememadr(nBestLapTimes);
    goto PurgeRest;
InvalidCar:
    purgememadr(nBestLapTimes);
    purgememadr(nRankBestLapTimes);
    purgememadr(TrackRecords);
    return (void *)0x0;
CheckRecord:
      nBestCarIndexTemp = nRankBestLapTimes[nNewRecordHolder];
      Stattool_GetRecords(Front_GetTrackRaced(),TrackRecords);
      memcpy_call(&RecordHolder,TrackRecords,0x14);
      if (((dummyCars[nBestCarIndexTemp].finalBestLap < RecordHolder.nBestLap) || (RecordHolder.nBestLap == 0))
         && (0 < dummyCars[nBestCarIndexTemp].finalBestLap)) {
        bBestLapFlag = 1;
      }
      *nBestCarIndex = nBestCarIndexTemp;
    purgememadr(nBestLapTimes);
PurgeRest:
    purgememadr(nRankBestLapTimes);
    purgememadr(TrackRecords);
    return (void *)(uint)(ushort)bBestLapFlag;
}

/* ---- StatChk_SaveRecordLapTime  (statchk.cpp:227) ---- */
void StatChk_SaveRecordLapTime(Car_tStats *dummyCars,short nNumCars,short nBestCarIndex)

{
  short track;
  int newBestLap;
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
    /* MATCH: materialize the value before forming the global lvalue. GCC 2.8.1 then gives
       the shorter-lived NewBestLap address $v0 and this value $v1, matching retail. */
    newBestLap = 1;
    NewBestLap = newBestLap;
    purgememadr(TrackRecords);
  }
  return;
}

/* ---- StatChk_IsTopTime  (statchk.cpp:285) ---- */
short StatChk_IsTopTime(Car_tStats *dummyCars,short nNumCars)

{
  int retvalue;
  short bDoRecordCheck;
  short nLaps;
  short nLapIndicator;
  int nCheckTotalTime;
  short k;
  short nCar;
  int *nCarTotalTimes;
  short *nRankCarTotalTimes;
  tRecordBuffer *RecordHolders;
  int LASTPLACE [2];
  int TOPLIST [2];
  int NUMBERONE [2];
  
  bDoRecordCheck = 0;
  nLaps = Front_GetLapsForType();
  memset(LASTPLACE,0,sizeof(LASTPLACE));
  memset(TOPLIST,0,sizeof(TOPLIST));
  memset(NUMBERONE,0,sizeof(NUMBERONE));
  RecordHolders = (tRecordBuffer *)reservememadr("toprcrds",0x168,0x10);
  nCarTotalTimes = (int *)reservememadr("carttime",nNumCars * sizeof(int),0x10);
  nRankCarTotalTimes = (short *)reservememadr("carttrnk",nNumCars * sizeof(short),0x10);
  retvalue = 0;
  for (k = 0; k < nNumCars; k++) {
    nRankCarTotalTimes[dummyCars[k].position - 1] = k;
  }
  nCar = Front_GetTrackRaced();
  Stattool_GetRecords(nCar,RecordHolders);
  nLapIndicator = 9;
  if (nLaps == 2) {
    nLapIndicator = 1;
  }
  for (k = 0; k < nNumCars; k++) {
    tCarInfo *carInfo;
    carInfo = GetCarFromSimID(&carManager, (short)dummyCars[k].carType);
    nCar = nRankCarTotalTimes[k];
    if ((dummyCars[nCar].carFlags & 0x200U) != 0) {
      purgememadr(RecordHolders);
      purgememadr(nCarTotalTimes);
      purgememadr(nRankCarTotalTimes);
      return 0;
    }
    if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {   /* MATCH: unsigned sltiu range fold */
      if ((((byte)frontEnd.gameMode < 3) && ((dummyCars[nCar].carFlags & 4U) != 0)) &&
         (dummyCars[nCar].finalFinishType == 2)) {
        bDoRecordCheck = 1;
      }
      if (bDoRecordCheck) {
        nCar = nRankCarTotalTimes[k];
        nCheckTotalTime = dummyCars[nCar].finalTotalTime;
        bDoRecordCheck = 0;
        if ((nCheckTotalTime < RecordHolders[nLapIndicator + 6].nTime) ||
           ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {
          TOPLIST[nCar] = 1;
        }
        else if ((nCheckTotalTime < RecordHolders[nLapIndicator + 7].nTime) ||
                ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {
          TOPLIST[nRankCarTotalTimes[k]] = 1;
          LASTPLACE[nRankCarTotalTimes[k]] = 1;
        }
        if ((nCheckTotalTime < RecordHolders[nLapIndicator].nTime) ||
           ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {
          TOPLIST[nRankCarTotalTimes[k]] = 1;
          NUMBERONE[nRankCarTotalTimes[k]] = 1;
        }
      }
    }
  }
  if (LASTPLACE[0] != 0) {
    if (LASTPLACE[1] != 0) {
      if (dummyCars[1].finalTotalTime < dummyCars->finalTotalTime) {
        TOPLIST[0] = 0;
      }
      else {
        TOPLIST[1] = 0;
      }
    }
    else if (TOPLIST[1] != 0) {
      TOPLIST[0] = 0;
    }
  }
  else if ((LASTPLACE[1] != 0) && (TOPLIST[0] != 0)) {
    TOPLIST[1] = 0;
  }
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
  int nCheckTotalTime;
  unsigned int uRecSz;
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

  uRecSz = sizeof(tRecordBuffer);
  RecordHolders = (tRecordBuffer *)reservememadr("toprcrds",uRecSz * 18,0x10);
  nCarTotalTimes = (int *)reservememadr("carttime",nNumCars * sizeof(int),0x10);
  nRankCarTotalTimes = (short *)reservememadr("carttrnk",nNumCars * sizeof(short),0x10);
  buffer = (char *)reservememadr("records",uRecSz * 8,0x10);

  for (k = 0; k < nNumCars; k = k + 1) {
    nRankCarTotalTimes[dummyCars[k].position - 1] = k;
  }

  Stattool_GetRecords(Front_GetTrackRaced(),RecordHolders);

  nLapIndicator = 9;
  if (Front_GetLapsForType() == 2) {
    nLapIndicator = 1;
  }

  for (nCar = 0; nCar < nNumCars; nCar = nCar + 1) {
      carInfo = GetCarFromSimID(&carManager,
                 (short)dummyCars[nRankCarTotalTimes[nCar]].carType);
      if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {   /* MATCH: unsigned sltiu range fold */
        if ((byte)frontEnd.gameMode < 3) {
StatChkSave_validateCarFinish:
          if (((dummyCars[nRankCarTotalTimes[nCar]].carFlags & 4U) != 0) &&
              (dummyCars[nRankCarTotalTimes[nCar]].finalFinishType == 2))
          {
            bDoRecordCheck = true;
          }
        }
        else if (nRankCarTotalTimes[nCar] == GameSetup_gData.localCar) {
          goto StatChkSave_validateCarFinish;
        }
        if (bDoRecordCheck == true) {
          nCheckTotalTime = dummyCars[nRankCarTotalTimes[nCar]].finalTotalTime;
          bDoRecordCheck = false;
          if ((nCheckTotalTime < RecordHolders[nLapIndicator + 7].nTime) ||
             ((RecordHolders[nLapIndicator + 7].nTime == 0) && (0 < nCheckTotalTime))) {
            DummyRaceResult.nTime = nCheckTotalTime;
            DummyRaceResult.nCar = *(signed char *)&carInfo->fCarID;   /* MATCH: lb, plain char is unsigned here */
            bTopTenFlag = true;
            DummyRaceResult.nBestLap = dummyCars[nRankCarTotalTimes[nCar]].finalBestLap;
            RecordHolders[nLapIndicator + 7] = DummyRaceResult;
            for (k = nLapIndicator; k < nLapIndicator + 8; k = k + 1) {
              nTopTenSort[k - nLapIndicator] = RecordHolders[k].nTime;
              if (nTopTenSort[k - nLapIndicator] == 0) {
                nTopTenSort[k - nLapIndicator] = (k + 1) * 0x23280;
              }
            }
            Stattool_nCreateIndex(8,nTopTenSort,nTopTenIndex);
            for (k = 0; k < 8; k = k + 1) {
              if (nTopTenIndex[k] == 7) {
                nPlace = k + 1;
              }
            }
            for (k = 0; k < 8; k = k + 1) {
              if (nTopTenIndex[k] == nRankCarTotalTimes[nCar]) {
                topPlacements[nRankCarTotalTimes[nCar]] = (int)nPlace;
                break;
              }
            }
            strcpy(DummyRaceResult.sName,PlayerName((int)nRankCarTotalTimes[nCar]));
            RecordHolders[nLapIndicator + 7] = DummyRaceResult;
            uRecSz = sizeof(tRecordBuffer);
            memcpy_call(buffer,&RecordHolders[nLapIndicator],uRecSz * 8);
            for (k = 0; k < 8; k = k + 1) {
              uRecSz = sizeof(tRecordBuffer);
              memcpy(&RecordHolders[nLapIndicator + k],
                     buffer + nTopTenIndex[k] * uRecSz,uRecSz);
            }
          }
        }
      }
  }
  if (bTopTenFlag == true) {
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
