/* frontend/common/stattool.cpp  --  RECONSTRUCTED  (records/stats/time/string utilities; C++ TU)
 *   11 EXT free functions; C++ linkage (cfront-mangled). Bodies: Ghidra decompiler.
 *   minChar/secChar = the per-language time separators ParseTime inlined as string literals.
 */
#include "stattool.h"

char minChar[6] = { ':',':',':',':',':',':' };   /* 0x800125ac region; minute seps */
char secChar[6] = { '.',':','.','.','.','.' };   /* centisecond seps */

/* ---- Stattool_nCreateIndex  (stattool.cpp:110) ---- */
  /* Retail @0x8004A868 records only i/j/nADummy/nBDummy/nTemp at homes
     $6/$16/$8/$11/$4. The walked addresses are compiler induction values.
     Matched NFS2 source has a real singleton cleanup path and a separate
     sorting cleanup path. That shape also reproduces all77 NFS4 words:
     the two purge calls merge, while j receives its own literal1 in the
     comparison's delay slot. No one capture or empty assembly fence is needed.
     Initialization, named value roles and statement phases remain supplied
     by NFS4's own SYM/SLD; NFS2's debug assertions are not imported.
     Implicit void fallthrough after the final purge keeps root end180 and
     the epilogue's180 tag distinct from the purge's179 tag. These matching
     facts do not uniquely recover original punctuation or macro text. */
#line 107 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
void Stattool_nCreateIndex(int nNumber,int *nInput,short *nIndex)


{
  /* retail: this TU's .rodata opens with an UNREFERENCED "SimpleMem" literal ahead of this
   * function's own constants (the dead tag string most objects carry); the constant-false
   * call keeps the string and adds no code. */
  if (0) reservememadr("SimpleMem",0,0);
  int i;
  int j;
  int nADummy;
  int nBDummy;
  int *nTemp;
  j = 0;






















  nTemp = (int *)reservememadr("TempSort",(nNumber + 1) * 4,0x10);







  while (j < nNumber) {

    nIndex[j] = (short)j;
    nTemp[j] = nInput[j];
    j++;
  }

  if (nNumber == 1) { purgememadr(nTemp); return; }





  for (j = 1; j < nNumber; j++) {

    nADummy = nTemp[j];
    nBDummy = nIndex[j];

    for (i = j - 1; i >= 0 && nADummy < nTemp[i]; i--) {

      nTemp[i + 1] = nTemp[i];
      nIndex[i + 1] = nIndex[i];
    }
    nTemp[i + 1] = nADummy;
    nIndex[i + 1] = (short)nBDummy;

  }

  purgememadr(nTemp);
}

/* ---- Stattool_ParseTime  (stattool.cpp:190) ---- */
/* MATCH (W55-A15, 56 -> PASS): retail keeps the SECOND remainder as its own
   statement before the sprintf -- the oracle's "subu $t2,$t2,$v1" lands BEFORE
   the two minChar/secChar lbu loads, mutating the nTime REGPARM in place.
   Folding it into the last sprintf argument sinks the whole sec*100 multiply
   chain past those loads and pushes nTime off its SYM-declared home
   (8c block @0x8004A99C: nTime REGPARM $0a = $t2, sLapTime REGPARM $10 = $s0,
   and ZERO declared locals -- SYM-CODEGEN-CARRIER: min and
   SYM-CODEGEN-CARRIER: sec are compiler temps).
   W86-S4 re-priced the fold (both recomputed inside the sprintf argument
   list, so the body carries no locals at all, as the SYM says): 90 diffs.
   The two carriers stay. */
#line 187 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
void Stattool_ParseTime(int nTime,char *sLapTime)


{



  short min;
  short sec;
  nTime = (int)((float)nTime / 0.64f);

  min = nTime / 6000;
  nTime = nTime - min * 6000;
  sec = nTime / 100;
  nTime = nTime - sec * 100;



  sprintf(sLapTime,"%02d%c%02d%c%02d",min,(uint)(byte)minChar[(byte)frontEnd.language],sec,
             (uint)(byte)secChar[(byte)frontEnd.language],(short)nTime); return;
}

/* ---- UserNameUpperCaseOneLetter  (stattool.cpp:211) ---- */
/* MATCH: plain `char` is UNSIGNED on this build, so the a..z guard folds to
   the oracle's `addiu v0,v1,-0x61 / sltiu v0,v0,0x1A` range test and the
   switch index is the UNSIGNED byte (0xE0..0xFC, 0x1D wide).  All stored
   constants are written as their unsigned byte values.  The case bodies are in
   the ORACLE'S PHYSICAL BLOCK ORDER (gcc emits switch arms in source order);
   the two fallthroughs (0xE8 -> 0xEC, 0xF9 -> end) are retail's own missing
   breaks.  In the 0xE8 arm both constants are stored directly and gcc
   cross-jumps the two `sb`s into one (retail tags it on the else line 28).
   SLD (FRONT5): one case per retail line, exact 0/71, blocks exact. */
#line 208 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
void UserNameUpperCaseOneLetter(char *c)


{

  if (('a' <= *c) && (*c <= 'z')) {
    *c = *c + 0xE0;
    return;
  }


  switch(*c) {


  case 0xE4: *c = 0xC4; return;
  case 0xF6: *c = 0xD6; return;
  case 0xFC: *c = 0xDC; return;
  case 0xE9: *c = 0x45; return;
  case 0xE1: *c = 0x41; return;
  case 0xED: *c = 0x49; return;
  case 0xF3: *c = 0x4F; return;
  case 0xFA: *c = 0x55; return;
  case 0xF1: *c = 0xD1; return;
  case 0xE5: *c = 0xC5; return;

  case 0xE0: *c = 0xC0; return;

  case 0xE8: if (frontEnd.language == 4) {
      *c = 0xC8;
    }
    else {
      *c = 0x45;
    } /* FALLTHROUGH (retail) */
  case 0xEC: *c = 0xCC; return;
  case 0xF2: *c = 0xD2; return;
  case 0xF9: *c = 0xD9; /* FALLTHROUGH (retail) */ default: return; } }

/* ---- Stattool_SamNelsonsUpperLowerStringConverterForRecords  (stattool.cpp:250) ---- */
#line 247 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
void Stattool_SamNelsonsUpperLowerStringConverterForRecords(char *string)


{
  char previousLetter; s_lower(string);
  previousLetter = *string;

  UserNameUpperCaseOneLetter(string);
  string = string + 1;

  while (*string != '\0') {

    if (previousLetter == ' ') {

      UserNameUpperCaseOneLetter(string);
    }
    previousLetter = *string;
    string = string + 1; } return; }

/* ---- StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters  (stattool.cpp:269) ---- */
#line 266 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
void StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(char *string)


{
  while (*string != '\0') {

    UserNameUpperCaseOneLetter(string);
    string = string + 1; } return; }

/* ---- Stattool_GetAllDefaultRecords  (stattool.cpp:279) ---- */
/* Retail SYM: i is the inner $s2 counter, n the outer $s4 counter;
   declaration order is i, n, s, AllRecords. */
#line 276 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
void Stattool_GetAllDefaultRecords(tRecordBuffer *TrackRecords,bool cheatones)


{
  int i;
  int n;
  int s;
  tRecordBuffer *AllRecords;
  
  AllRecords = (tRecordBuffer *)reservememadr("records",0xe9c,0x10);
  Stattool_ReadDefaultRecords(AllRecords,cheatones);
  n = 0; do {


    i = 0;
    do {
      s = n * 0x11 + i;
      strcpy(TrackRecords[s].sName,AllRecords[s].sName);
      Stattool_SamNelsonsUpperLowerStringConverterForRecords(TrackRecords[s].sName);
      TrackRecords[s].nCar = AllRecords[s].nCar;
      TrackRecords[s].nTime = AllRecords[s].nTime;
      TrackRecords[s].nBestLap = AllRecords[s].nBestLap;
    } while (++i < 0x11);
  } while (++n < 0xb);

  purgememadr(AllRecords);
}

/* ---- Stattool_ReadDefaultRecords  (stattool.cpp:323) ---- */
#line 320 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
void Stattool_ReadDefaultRecords(tRecordBuffer *Records,bool cheatones)


{
  char filename [80];


  if (cheatones)

    sprintf(filename,"%sznfsrec.dat",Paths_Paths[0x24]);

  else

    sprintf(filename,"%szrecord.dat",Paths_Paths[0x24]);

  if (filesize(filename) == 0xe9c)

    loadfileatadrz(filename,Records);











  else
    blockclear(Records,0xe9c);
}

/* ---- Stattool_GetRecords  (stattool.cpp:364) ---- */
#line 361 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
void Stattool_GetRecords(short nShowTrack,tRecordBuffer *TrackRecords)


{







  blockmove(Stats_gTrackRecords + nShowTrack * 0x11,TrackRecords,0x154);
}

/* ---- Stattool_ReturnRecordLapTime  (stattool.cpp:377) ---- */
#line 374 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
int Stattool_ReturnRecordLapTime(short nTrack)


{












  /* W86-S4: SYM `8c` declaration order restored (RecordLapHolder AUTO sp+16,
     TrackRecords REG $16 s0).  Re-gated PASS. */
  tRecordBuffer RecordLapHolder;
  tRecordBuffer *TrackRecords;
  
  TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);


  Stattool_GetRecords(nTrack,TrackRecords);
  memcpy(&RecordLapHolder,TrackRecords,0x14);


  purgememadr(TrackRecords);

  return RecordLapHolder.nBestLap;
}

/* ---- Stattool_CheckForHumanCar  (stattool.cpp:413) ---- */
/* FRONT5: the nNumCars carrier (EXTRA SYM local) is gone: retail = a for loop
   with the count on line 5 (record-less const temp, DEVICE exact-only), k
   incremented before the early break.  BYTES/SYM/SLD exact. */
#line 410 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
short Stattool_CheckForHumanCar(Car_tStats *dummyCars)


{
  short k;
  short bHumanFlag;
  bHumanFlag = 0;

  const short nNumCars = (short)(GameSetup_NumPlayerRaceCars + GameSetup_NumOpponentRaceCars); /* DEVICE (exact-only): retail computes the count on line 5; const temp, no SYM record */



  for (k = 0; k < nNumCars; ) {



    if ((dummyCars[k].carFlags & 4U) != 0) {




      bHumanFlag = 1;
    }

    k = k + 1; if (bHumanFlag == 1) {
      break;
    } }



  return bHumanFlag;
}

/* ---- Stattool_GetAINameFromPersonality  (stattool.cpp:456) ---- */
#line 453 "C:/nfs4/FRONTEND/COMMON/STATTOOL.CPP"
char * Stattool_GetAINameFromPersonality(tPersonalities personality)


{
  if ((unsigned int)personality >= (kPersonalityTraffic|kPersonalityCop3))
    return TextSys_Word(0x2ee);
  return GameSetup_gPersonalityNames[personality];
}

/* end of stattool.cpp */
