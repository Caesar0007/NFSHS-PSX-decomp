/* frontend/common/statchk.cpp  --  RECONSTRUCTED  (record-lap / top-time check + save; C++ TU)
 *   5 EXT free functions; C++ linkage (cfront-mangled). Bodies: Ghidra decompiler.
 *   Calls Stattool helpers + tCarManager::GetCarFromSimID (external method, declared free-form).
 */
#include "statchk.h"

extern "C" int sprintf(char *buffer, char *fmt, ...);


/* Retail records71db85/71dba4 declare BOOL[8] and scalar BOOL; the matching
   definitions below already own those exact objects. The old int[] alias
   views and asm labels were reconstruction-only,not original data shapes.
   This TU's existing-G0 identity preserves their absolute addressing. */
extern bool NewRecords[8];
extern bool NewBestLap;

/* ---- StatChk_IsRecordLapTime  (statchk.cpp:50) ---- */
#line 47 "C:/nfs4/FRONTEND/COMMON/STATCHK.CPP"
bool StatChk_IsRecordLapTime(Car_tStats *dummyCars,short nNumCars,short *nBestCarIndex)


{ tCarInfo *devLocal_tCarInfo; /* DEVICE (exact-only): record-less unused local; retail statchk.obj type record #244 (TPDEF tCarInfo) between tCarModels and tOwnedCarInfo, inside StatChk_IsRecordLapTime__FP10Car_tStatssPs's record run (locals-before-params, GSDATA_state 7h) */

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




    return 0;
  }




    nBestLapTimes = (int *)reservememadr("ranklap",nNumCars * sizeof(int),0x10);
    nRankBestLapTimes = (short *)reservememadr("rankbst",nNumCars * sizeof(short),0x10);
    TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);


    for (i = 0; i < nNumCars; i++) {

      carInfo = carManager.GetCarFromSimID((short)dummyCars[i].carType);


      if ((dummyCars[i].carFlags & 0x200U) != 0) {

    purgememadr(nBestLapTimes);
    purgememadr(nRankBestLapTimes);
    purgememadr(TrackRecords);
        return 0; }




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
    else { *nRankBestLapTimes = 0;
    }

















    for (nNewRecordHolder = 0; nNewRecordHolder < nNumCars; nNewRecordHolder++) {





        nBestCarIndexTemp = nRankBestLapTimes[nNewRecordHolder]; if (((dummyCars[nBestCarIndexTemp].carFlags & 4U) != 0) && (0 < dummyCars[nRankBestLapTimes[nBestCarIndexTemp]].finalBestLap)) {
          bCheckLapRecords = 1;
          break;
        }
        bCheckLapRecords = 0;







    }



    if (bCheckLapRecords) goto CheckRecord;
    purgememadr(nBestLapTimes);






    goto PurgeRest;



    CheckRecord: nBestCarIndexTemp = nRankBestLapTimes[nNewRecordHolder];





      Stattool_GetRecords(Front_GetTrackRaced(),TrackRecords);
      memcpy(&RecordHolder,TrackRecords,0x14);
      if (((dummyCars[nBestCarIndexTemp].finalBestLap < RecordHolder.nBestLap) || (RecordHolder.nBestLap == 0))









         && (0 < dummyCars[nBestCarIndexTemp].finalBestLap)) {




        bBestLapFlag = 1;
      }

      *nBestCarIndex = nBestCarIndexTemp;


    purgememadr(nBestLapTimes);
PurgeRest: purgememadr(nRankBestLapTimes);
    purgememadr(TrackRecords);



    return (u_short)bBestLapFlag;
}

/* ---- StatChk_SaveRecordLapTime  (statchk.cpp:227) ---- */
#line 224 "C:/nfs4/FRONTEND/COMMON/STATCHK.CPP"
void StatChk_SaveRecordLapTime(Car_tStats *dummyCars,short nNumCars,short nBestCarIndex)


{
  /* W86-S4: the four real locals are now in the SYM's own `8c` order
     (RecordHolder AUTO sp+16, DummyRaceResult AUTO sp+40, TrackRecords REG $17
     s1, carInfo REG $18 s2); the unresolved value capture follows.
     Re-gated PASS. */
  tRecordBuffer RecordHolder;
  tRecordBuffer DummyRaceResult;
  tRecordBuffer *TrackRecords;
  tCarInfo *carInfo;


  carInfo = carManager.GetCarFromSimID((short)dummyCars[nBestCarIndex].carType);

  if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {


    TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);


    Stattool_GetRecords(Front_GetTrackRaced(),TrackRecords);
    memcpy(&RecordHolder,TrackRecords + 1,0x14);
    if ((dummyCars[nBestCarIndex].finalNumArrests == 0) &&


       (dummyCars[nBestCarIndex].finalFinishType == 2)) {
      DummyRaceResult.nTime = dummyCars[nBestCarIndex].finalTotalTime;
    }
    else { DummyRaceResult.nTime = 0;
    }
    DummyRaceResult.nBestLap = dummyCars[nBestCarIndex].finalBestLap;
    DummyRaceResult.nCar = *(signed char *)&carInfo->fCarID;   /* MATCH: lb, plain char is unsigned here */

    strcpy(DummyRaceResult.sName,PlayerName((int)nBestCarIndex));






    memcpy(TrackRecords,&DummyRaceResult,0x14);


    carInfo = (tCarInfo *)(1 << (int)carInfo);

    blockmove(TrackRecords,Stats_gTrackRecords + Front_GetTrackRaced() * 0x11,0x154);
    NewBestLap = 1;


    purgememadr(TrackRecords); } return;




}

/* ---- StatChk_IsTopTime  (statchk.cpp:285) ---- */
#line 282 "C:/nfs4/FRONTEND/COMMON/STATCHK.CPP"
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
  short *nRankCarTotalTimes; tRecordBuffer *RecordHolders; int LASTPLACE [2]; int TOPLIST [2]; int NUMBERONE [2]; bDoRecordCheck = 0;
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


  nCar = Front_GetTrackRaced(); Stattool_GetRecords(nCar,RecordHolders);
  nLapIndicator = 9;

  if (nLaps == 2) {

    nLapIndicator = 1;
  }












  for (nCar = 0; nCar < nNumCars; nCar++) {
    tCarInfo *carInfo;

    carInfo = carManager.GetCarFromSimID((short)dummyCars[nCar].carType);

    k = nRankCarTotalTimes[nCar]; if ((dummyCars[k].carFlags & 0x200U) != 0) {

      purgememadr(RecordHolders);
      purgememadr(nCarTotalTimes);
      purgememadr(nRankCarTotalTimes);
      return 0;
    }


    if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {   /* MATCH: unsigned sltiu range fold */

      if ((byte)frontEnd.gameMode < 3) {

        if (((dummyCars[k].carFlags & 4U) != 0) && (dummyCars[k].finalFinishType == 2)) {

          bDoRecordCheck = 1;
        } }









      if (bDoRecordCheck == 1) {




        k = nRankCarTotalTimes[nCar]; nCheckTotalTime = dummyCars[k].finalTotalTime;
        bDoRecordCheck = 0;
        if ((nCheckTotalTime < RecordHolders[nLapIndicator + 6].nTime) ||






           ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {

          TOPLIST[k] = 1;
        }
        else if ((nCheckTotalTime < RecordHolders[nLapIndicator + 7].nTime) ||

                ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {

          TOPLIST[nRankCarTotalTimes[nCar]] = 1;
          LASTPLACE[nRankCarTotalTimes[nCar]] = 1;
        }
        if ((nCheckTotalTime < RecordHolders[nLapIndicator].nTime) ||


           ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {

          TOPLIST[nRankCarTotalTimes[nCar]] = 1;
          NUMBERONE[nRankCarTotalTimes[nCar]] = 1;
        }
      }
    }

  }




  if ((LASTPLACE[0] != 0) && (LASTPLACE[1] != 0)) {



    if (!(dummyCars->finalTotalTime > dummyCars[1].finalTotalTime)) {
      TOPLIST[1] = 0;
    }
    else {

      TOPLIST[0] = 0;
    }
  } else if ((LASTPLACE[0] != 0) && (TOPLIST[1] != 0)) {

    TOPLIST[0] = 0;
  }
  else if ((LASTPLACE[1] != 0) && (TOPLIST[0] != 0)) {

    TOPLIST[1] = 0;
  }

  if ((NUMBERONE[0] != 0) && (NUMBERONE[1] != 0)) {


    if (!(dummyCars->finalTotalTime > dummyCars[1].finalTotalTime)) {

      NUMBERONE[1] = 0;
    }
    else {
      NUMBERONE[0] = 0;
    }
  }

  retvalue = (ushort)(TOPLIST[0] != 0);
  if (NUMBERONE[0] != 0) { retvalue = retvalue | 2;
  } if (TOPLIST[1] != 0) { retvalue = retvalue | 4;
  } if (NUMBERONE[1] != 0) { retvalue = retvalue | 8;
  }

  purgememadr(RecordHolders);
  purgememadr(nCarTotalTimes);
  purgememadr(nRankCarTotalTimes);


  return retvalue;
}

/* ---- StatChk_SaveTopTime  (statchk.cpp:464) ---- */
#line 461 "C:/nfs4/FRONTEND/COMMON/STATCHK.CPP"
void StatChk_SaveTopTime(Car_tStats *dummyCars,short nNumCars)


{
  bool bTopTenFlag; bool bDoRecordCheck; short nLapIndicator; short nPlace; int nTopTenSort [8]; short nTopTenIndex [8]; int nCheckTotalTime; short k; short nCar; char *buffer; int *nCarTotalTimes; short *nRankCarTotalTimes; tRecordBuffer DummyRaceResult; tRecordBuffer *RecordHolders; tCarInfo *carInfo; int topPlacements [2]; unsigned int uRecSz; uRecSz = sizeof(tRecordBuffer); bTopTenFlag = false;
  bDoRecordCheck = false;

  nPlace = 0;


















  for (k = 0; k < 2; k = k + 1) {
    topPlacements[k] = 0; }






  RecordHolders = (tRecordBuffer *)reservememadr("toprcrds",uRecSz * 18,0x10);
  nCarTotalTimes = (int *)reservememadr("carttime",nNumCars * sizeof(int),0x10);
  nRankCarTotalTimes = (short *)reservememadr("carttrnk",nNumCars * sizeof(short),0x10);
  buffer = (char *)reservememadr("records",uRecSz * 8,0x10);


  for (k = 0; k < nNumCars; k = k + 1) {

    nRankCarTotalTimes[dummyCars[k].position - 1] = k;

  }


  Stattool_GetRecords(Front_GetTrackRaced(),RecordHolders);


  if (Front_GetLapsForType() == 2) {

    nLapIndicator = 1;
  }
  else {

    nLapIndicator = 9;
  }








  for (nCar = 0; nCar < nNumCars; nCar = nCar + 1) {
      carInfo = carManager.GetCarFromSimID((short)dummyCars[nRankCarTotalTimes[nCar]].carType);
      if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {   /* MATCH: unsigned sltiu range fold */


        if ((byte)frontEnd.gameMode < 3) {
          if (((dummyCars[nRankCarTotalTimes[nCar]].carFlags & 4U) != 0) &&
              (dummyCars[nRankCarTotalTimes[nCar]].finalFinishType == 2))
          {
            bDoRecordCheck = true;
          }
        }


        else if (nRankCarTotalTimes[nCar] == GameSetup_LocalCar) { if (((dummyCars[nRankCarTotalTimes[nCar]].carFlags & 4U) != 0) && (dummyCars[nRankCarTotalTimes[nCar]].finalFinishType == 2))
          {
            bDoRecordCheck = true;
          }
        }

        if (bDoRecordCheck == true) {




          nCheckTotalTime = dummyCars[nRankCarTotalTimes[nCar]].finalTotalTime;
          bDoRecordCheck = false;
          if ((nCheckTotalTime < RecordHolders[nLapIndicator + 7].nTime) ||








             ((RecordHolders[nLapIndicator + 7].nTime == 0) && (0 < nCheckTotalTime))) {


            bTopTenFlag = true;

            DummyRaceResult.nTime = nCheckTotalTime;
            DummyRaceResult.nCar = *(signed char *)&carInfo->fCarID;   /* MATCH: lb, plain char is unsigned here */
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
            strcpy(DummyRaceResult.sName,


                   PlayerName((int)nRankCarTotalTimes[nCar]));


            RecordHolders[nLapIndicator + 7] = DummyRaceResult;


            memcpy(buffer,&RecordHolders[nLapIndicator],uRecSz * 8);
            for (k = 0; k < 8; k = k + 1) {
              memcpy((tRecordBuffer *)
                          ((nLapIndicator + k) * (int)sizeof(tRecordBuffer) +
                           (int)RecordHolders),
                          buffer + nTopTenIndex[k] * uRecSz,uRecSz);

            }
          }
        }
      } }

  if (bTopTenFlag == true) {

    blockmove(RecordHolders,Stats_gTrackRecords + Front_GetTrackRaced() * 0x11,0x154);
  }







  if (topPlacements[0] == topPlacements[1]) {
    topPlacements[1] = topPlacements[0] + 1;
  } else if ((topPlacements[1] != 0) && (topPlacements[1] < topPlacements[0])) {
    topPlacements[0] = topPlacements[0] + 1;
  }
  for (k = 0; k < 2; k = k + 1) {

    if ((topPlacements[k] != 0) && (topPlacements[k] < 9)) {
      NewRecords[topPlacements[k] - 1] = 1;
    } }


  purgememadr(buffer);
  purgememadr(RecordHolders);
  purgememadr(nCarTotalTimes);
  purgememadr(nRankCarTotalTimes); return;
}

/* ---- StatChk_ClearNewRecords  (statchk.cpp:664) ---- */
/* W86-S4: the SYM's `8c` block records exactly ONE local here,
   `REG i $3 v1 INT` -- the former `int *pRec` walk-pointer carrier was a hard
   fiction.  Folded into the down-counting index loop; the split
   `la NewRecords` + `addiu 0x1C` shape it was buying comes out of the index
   form for free.  Re-gated PASS. */
#line 661 "C:/nfs4/FRONTEND/COMMON/STATCHK.CPP"
void StatChk_ClearNewRecords(void)


{
  int i;
  for (i = 7; -1 < i; i = i + -1) {
    NewRecords[i] = 0; }
  NewBestLap = 0;
}

/* end of statchk.cpp */

bool NewRecords[8];   /* @0x80052978; SYM EXT BOOL[8] */
bool NewBestLap;      /* @0x80052998; SYM EXT BOOL */
