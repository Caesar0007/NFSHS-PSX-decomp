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
  /* retail: this TU's .rodata opens with an UNREFERENCED "SimpleMem" literal ahead of this
   * function's own constants (the dead tag string most objects carry); the constant-false
   * call keeps the string and adds no code. */
  if (0) reservememadr("SimpleMem",0,0);

  /* SYM 8c @0x8004A868: nNumber REGPARM $11=$s1, nInput $13=$s3, nIndex $12=$s2;
     locals are EXACTLY i($06) j($10) nADummy($08) nBDummy($0b) nTemp($04) -- the
     walking pointers in the Ghidra body (pIdx/pVal/pIdxScan/pValScan) are compiler
     GIVs, not source variables, so this is the index-form insertion sort.  (W55-A15)
     Retail i is the inner scan; retail j is the initial/outer loop counter.
     Two further levers were needed for the SYM's 4-saved-reg mask ($800f0000, fsize 40):
       * `j = 0;` BEFORE the reservememadr call -- that makes j CALL-CROSSING, so it gets a
         callee-saved home ($s0) instead of the caller-saved $t0 a post-call init lands in;
       * the explicit `if (nNumber != 1)` wrapper -- the oracle really does test `beq $s1,1`
         ahead of the ordinary `slt` zero-trip guard, and no `for` spelling emits it.
     108 -> 2 diffs, count-exact 77/77.
     W57-A7 SEAL (2 -> PASS 77/77): the last residual was ours `addu $s0,$v0,$zero` copying
     the guard's live `li $v0,1` into j where retail re-materializes `li $s0,1` in the beq
     delay slot.  It was NOT the 3.25-3b no-copy-prop identity -- it is plain cse constant
     sharing, and the OPACITY/IDENTITY FENCE (catalog 04-a4/a5, zero insns) breaks it: with
     `one` laundered (SYM-CODEGEN-CARRIER: one), cse can no longer prove the
     compare's register holds 1, so `j = 1`
     re-materializes.  Falsified at this basin BEFORE the fence: j=1 hoisted above the guard,
     j=1 inside the guard, guard spelled against j.
     W86-S4 re-priced dropping the fence and the `one` carrier (plain
     `if (nNumber != 1)`) in today's PASS basin: exactly 2 diffs, unchanged.
     `one` therefore stays as a SYM-absent carrier; a pure-C replacement for the
     cse opacity it buys is device-lane work, not a declaration question. */
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
  {
  int one = 1;
  __asm__ ("" : "=r" (one) : "0" (one));
  if (nNumber != one) {
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
  }
  }
  purgememadr(nTemp);
  return;
}

/* ---- Stattool_ParseTime  (stattool.cpp:190) ---- */
void Stattool_ParseTime(int nTime,char *sLapTime)

{
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
  short min;
  short sec;

  nTime = (int)((float)nTime / 0.64f);
  min = nTime / 6000;
  nTime = nTime - min * 6000;
  sec = nTime / 100;
  nTime = nTime - sec * 100;
  sprintf(sLapTime,"%02d%c%02d%c%02d",min,(uint)(byte)minChar[(byte)frontEnd.language],sec,
             (uint)(byte)secChar[(byte)frontEnd.language],(short)nTime);
  return;
}

/* ---- UserNameUpperCaseOneLetter  (stattool.cpp:211) ---- */
void UserNameUpperCaseOneLetter(char *c)

{
  /* MATCH: plain `char` is UNSIGNED on this build, so the a..z guard folds to
     the oracle's `addiu v0,v1,-0x61 / sltiu v0,v0,0x1A` range test and the
     switch index is the UNSIGNED byte (0xE0..0xFC, 0x1D wide).  All stored
     constants are written as their unsigned byte values -- a signed spelling
     (-0x3c) emits `li -60`, the oracle has `li 196`.  The case bodies are in
     the ORACLE'S PHYSICAL BLOCK ORDER (gcc emits switch arms in source order);
     the two fallthroughs (0xE8 -> 0xEC, 0xF9 -> end) are retail's own missing
     breaks, kept verbatim.  In the 0xE8 arm the two constants are stored
     DIRECTLY (`if (..) *c = 0xC8; else *c = 0x45;`) and gcc cross-jumps the
     two `sb`s into one -- a `char upperE` temp instead lands in $a1 where
     retail reuses $v0 (6-diff near-miss). */
  if (('a' <= *c) && (*c <= 'z')) {
    *c = *c + 0xE0;
    return;
  }
  switch(*c) {
  case 0xE4:
    *c = 0xC4;
    return;
  case 0xF6:
    *c = 0xD6;
    return;
  case 0xFC:
    *c = 0xDC;
    return;
  case 0xE9:
    *c = 0x45;
    return;
  case 0xE1:
    *c = 0x41;
    return;
  case 0xED:
    *c = 0x49;
    return;
  case 0xF3:
    *c = 0x4F;
    return;
  case 0xFA:
    *c = 0x55;
    return;
  case 0xF1:
    *c = 0xD1;
    return;
  case 0xE5:
    *c = 0xC5;
    return;
  case 0xE0:
    *c = 0xC0;
    return;
  case 0xE8:
    if (frontEnd.language == 4) {
      *c = 0xC8;
    }
    else {
      *c = 0x45;
    }
    /* FALLTHROUGH (retail) */
  case 0xEC:
    *c = 0xCC;
    return;
  case 0xF2:
    *c = 0xD2;
    return;
  case 0xF9:
    *c = 0xD9;
    /* FALLTHROUGH (retail) */
  default:
    return;
  }
}

/* ---- Stattool_SamNelsonsUpperLowerStringConverterForRecords  (stattool.cpp:250) ---- */
void Stattool_SamNelsonsUpperLowerStringConverterForRecords(char *string)

{
  char previousLetter;

  s_lower(string);
  previousLetter = *string;
  UserNameUpperCaseOneLetter(string);
  string = string + 1;
  while (*string != '\0') {
    if (previousLetter == ' ') {
      UserNameUpperCaseOneLetter(string);
    }
    previousLetter = *string;
    string = string + 1;
  }
  return;
}

/* ---- StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters  (stattool.cpp:269) ---- */
void StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(char *string)

{
  while (*string != '\0') {
    UserNameUpperCaseOneLetter(string);
    string = string + 1;
  }
  return;
}

/* ---- Stattool_GetAllDefaultRecords  (stattool.cpp:279) ---- */
/* Retail SYM: i is the inner $s2 counter, n the outer $s4 counter;
   declaration order is i, n, s, AllRecords. */
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
void Stattool_ReadDefaultRecords(tRecordBuffer *Records,bool cheatones)

{
  char filename [80];
  
  cheatones ? sprintf(filename,"%sznfsrec.dat",Paths_Paths[0x24]) :
              sprintf(filename,"%szrecord.dat",Paths_Paths[0x24]);
  if (filesize(filename) == 0xe9c)
    loadfileatadrz(filename,Records);
  else
    blockclear(Records,0xe9c);
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
short Stattool_CheckForHumanCar(Car_tStats *dummyCars)

{
  /* SYM-CODEGEN-CARRIER: nNumCars -- NFS4 SYM records only `k` and
   * `bHumanFlag`, but the matched NFS2 PC beta source restores this exact
   * local name and early-break loop.  Its `short` type is oracle-significant:
   * this form is PASS 34/34, while `int` is FAIL 5. */
  short k;
  short bHumanFlag;
  short nNumCars;
  
  bHumanFlag = 0;
  nNumCars = (short)GameSetup_NumPlayerRaceCars +
             (short)GameSetup_NumOpponentRaceCars;
  k = 0;
  do {
    if (k >= nNumCars) {
      break;
    }
    if ((dummyCars[k].carFlags & 4U) != 0) {
      bHumanFlag = 1;
    }
    k = k + 1;
  } while (bHumanFlag != 1);
  return bHumanFlag;
}

/* ---- Stattool_GetAINameFromPersonality  (stattool.cpp:456) ---- */
char * Stattool_GetAINameFromPersonality(tPersonalities personality)

{
  if ((unsigned int)personality >= (kPersonalityTraffic|kPersonalityCop3))
    return TextSys_Word(0x2ee);
  return GameSetup_gPersonalityNames[personality];
}

/* end of stattool.cpp */
