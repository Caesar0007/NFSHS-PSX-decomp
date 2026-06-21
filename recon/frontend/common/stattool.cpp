/* frontend/common/stattool.cpp  --  RECONSTRUCTED  (records/stats/time/string utilities; C++ TU)
 *   11 EXT free functions; C++ linkage (cfront-mangled). Bodies: Ghidra decompiler.
 *   minChar/secChar = the per-language time separators ParseTime inlined as string literals.
 */
#include "stattool.h"

char minChar[6] = { ':',':',':',':',':',':' };   /* 0x800125ac region; minute seps */
char secChar[6] = { '.',':','.','.','.','.' };   /* centisecond seps */

/* ---- Stattool_nCreateIndex  (stattool.cpp:110) ---- */
void Stattool_nCreateIndex(int nNumber,int *nInput,short *nIndex)

{
  short curIdx;
  int *nTemp;
  int j;
  short *pIdx;
  int *pValScan;
  int i;
  int *pVal;
  short *pIdxScan;
  int cur;
  
  nTemp = (int *)reservememadr("TempSort",(nNumber + 1) * 4,0x10);
  i = 0;
  pIdx = nIndex;
  pVal = nTemp;
  if (0 < nNumber) {
    do {
      *pIdx = (short)i;
      j = *nInput;
      nInput = nInput + 1;
      i = i + 1;
      *pVal = j;
      pIdx = pIdx + 1;
      pVal = pVal + 1;
    } while (i < nNumber);
  }
  i = 1;
  if ((nNumber != 1) && (pVal = nTemp, pIdx = nIndex, 1 < nNumber)) {
    do {
      j = i + -1;
      cur = pVal[1];
      curIdx = pIdx[1];
      if (-1 < j) {
        pIdxScan = nIndex + j;
        pValScan = nTemp + j;
        do {
          if (*pValScan <= cur) break;
          pValScan[1] = *pValScan;
          pValScan = pValScan + -1;
          j = j + -1;
          pIdxScan[1] = *pIdxScan;
          pIdxScan = pIdxScan + -1;
        } while (-1 < j);
      }
      i = i + 1;
      nTemp[j + 1] = cur;
      nIndex[j + 1] = curIdx;
      pVal = pVal + 1;
      pIdx = pIdx + 1;
    } while (i < nNumber);
  }
  purgememadr(nTemp);
  return;
}

/* ---- Stattool_ParseTime  (stattool.cpp:190) ---- */
void Stattool_ParseTime(int nTime,char *sLapTime)

{
  int centi;
  int min;
  int sec;
  int remCenti;
  float fTime;
  float fDiv;
  
  __floatsisf(nTime);
  __divsf3(fTime,fDiv);
  centi = __fixsfsi(fTime);
  min = (centi / 6000) * 0x10000 >> 0x10;
  remCenti = centi + min * -6000;
  sec = (remCenti / 100) * 0x10000 >> 0x10;
  sprintf(sLapTime,"%02d%c%02d%c%02d",min,(uint)(byte)minChar[(byte)frontEnd.language],sec,
             (uint)(byte)secChar[(byte)frontEnd.language],(remCenti + sec * -100) * 0x10000 >> 0x10);
  return;
}

/* ---- UserNameUpperCaseOneLetter  (stattool.cpp:211) ---- */
void UserNameUpperCaseOneLetter(char *c)

{
  char upperE;
  
  if (0x19 < (byte)*c - 0x61) {
    switch(*c) {
    case -0x20:
      *c = -0x40;
      return;
    case -0x1f:
      *c = 'A';
      return;
    default:
      return;
    case -0x1c:
      *c = -0x3c;
      return;
    case -0x1b:
      *c = -0x3b;
      return;
    case -0x18:
      upperE = 'E';
      if (frontEnd.language == '\x04') {
        upperE = -0x38;
      }
      *c = upperE;
uname_setAccentUpper:
      *c = -0x34;
      return;
    case -0x17:
      *c = 'E';
      return;
    case -0x14:
      goto uname_setAccentUpper;
    case -0x13:
      *c = 'I';
      return;
    case -0xf:
      *c = -0x2f;
      return;
    case -0xe:
      *c = -0x2e;
      return;
    case -0xd:
      *c = 'O';
      return;
    case -10:
      *c = -0x2a;
      return;
    case -7:
      *c = -0x27;
      return;
    case -6:
      *c = 'U';
      return;
    case -4:
      *c = -0x24;
      return;
    }
  }
  *c = *c - 0x20;
  return;
}

/* ---- Stattool_SamNelsonsUpperLowerStringConverterForRecords  (stattool.cpp:250) ---- */
void Stattool_SamNelsonsUpperLowerStringConverterForRecords(char *string)

{
  char previousLetter;
  char cur_ch;

  s_lower(string);
  previousLetter = *string;
  UserNameUpperCaseOneLetter(string);
  string = string + 1;
  cur_ch = *string;
  while (cur_ch != '\0') {
    if (previousLetter == ' ') {
      UserNameUpperCaseOneLetter(string);
    }
    previousLetter = *string;
    string = string + 1;
    cur_ch = *string;
  }
  return;
}

/* ---- StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters  (stattool.cpp:269) ---- */
void StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(char *string)

{
  char ch;
  
  ch = *string;
  while (ch != '\0') {
    UserNameUpperCaseOneLetter(string);
    string = string + 1;
    ch = *string;
  }
  return;
}

/* ---- Stattool_GetAllDefaultRecords  (stattool.cpp:279) ---- */
void Stattool_GetAllDefaultRecords(tRecordBuffer *TrackRecords,bool cheatones)

{
  tRecordBuffer *Records;
  int idx;
  tRecordBuffer *src;
  tRecordBuffer *dest;
  int i;
  int n;
  int base;
  
  Records = (tRecordBuffer *)reservememadr("records",0xe9c,0x10);
  Stattool_ReadDefaultRecords(Records,cheatones);
  i = 0;
  base = 0;
  do {
    n = 0;
    do {
      idx = base + n;
      dest = TrackRecords + idx;
      src = Records + idx;
      strcpy(dest->sName,src->sName);
      Stattool_SamNelsonsUpperLowerStringConverterForRecords(dest->sName);
      dest->nCar = src->nCar;
      dest->nTime = src->nTime;
      n = n + 1;
      dest->nBestLap = src->nBestLap;
    } while (n < 0x11);
    i = i + 1;
    base = base + 0x11;
  } while (i < 0xb);
  purgememadr(Records);
  return;
}

/* ---- Stattool_ReadDefaultRecords  (stattool.cpp:323) ---- */
void Stattool_ReadDefaultRecords(tRecordBuffer *Records,bool cheatones)

{
  int fsize;
  char *fmt;
  char filename [80];
  
  if (cheatones == 0) {
    fmt = "%szrecord.dat";
  }
  else {
    fmt = "%sznfsrec.dat";
  }
  sprintf(filename,fmt,Paths_Paths[0x24]);
  fsize = filesize(filename);
  if (fsize == 0xe9c) {
    loadfileatadrz(filename,Records);
  }
  else {
    blockclear(Records,0xe9c);
  }
  return;
}

/* ---- Stattool_GetRecords  (stattool.cpp:364) ---- */
void Stattool_GetRecords(short nShowTrack,tRecordBuffer *TrackRecords)

{
  blockmove(Stats_gTrackRecords + nShowTrack * 0x11,TrackRecords,0x154);
  return;
}

/* ---- Stattool_ReturnRecordLapTime  (stattool.cpp:377) ---- */
int Stattool_ReturnRecordLapTime(short nTrack)

{
  tRecordBuffer *TrackRecords;
  tRecordBuffer RecordLapHolder;
  
  TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);
  Stattool_GetRecords(nTrack,TrackRecords);
  memcpy(&RecordLapHolder,TrackRecords,0x14);
  purgememadr(TrackRecords);
  return RecordLapHolder.nBestLap;
}

/* ---- Stattool_CheckForHumanCar  (stattool.cpp:413) ---- */
short Stattool_CheckForHumanCar(Car_tStats *dummyCars)

{
  int kIdx;
  int numCars;
  short k;
  short bHumanFlag;
  
  bHumanFlag = 0;
  numCars = (int)(((uint)(ushort)GameSetup_gData.numPlayerRaceCars +
                (uint)(ushort)GameSetup_gData.numOpponentRaceCars) * 0x10000) >> 0x10;
  k = 0;
  if (0 < numCars) {
    kIdx = 0;
    bHumanFlag = 0;
    do {
      k = k + 1;
      if ((dummyCars[kIdx >> 0x10].carFlags & 4U) != 0) {
        bHumanFlag = 1;
      }
    } while ((bHumanFlag != 1) && (kIdx = k * 0x10000, k * 0x10000 >> 0x10 < numCars));
  }
  return bHumanFlag;
}

/* ---- Stattool_GetAINameFromPersonality  (stattool.cpp:456) ---- */
char * Stattool_GetAINameFromPersonality(tPersonalities personality)

{
  char (*namePtr) [8];
  
  if ((unsigned int)personality < (kPersonalityTraffic|kPersonalityCop3)) {
    namePtr = GameSetup_gPersonalityNames + personality;
  }
  else {
    namePtr = (char (*) [8])TextSys_Word(0x2ee);
  }
  return *namePtr;
}

/* end of stattool.cpp */