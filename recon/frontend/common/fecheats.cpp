/* frontend/common/fecheats.cpp -- RECONSTRUCTED (cheat / bonus-code system; C++ TU)
 *   10 free fns (ns nfs4::FRONTEND::COMMON::FECheats): HandleActivation (per-cheat effect
 *   switch), EncodeString/EncodeString2 (bit-shuffle obfuscation of typed codes),
 *   Activate{Cheat,Bonus,BonusByCode}, IsCheatEnabled, Save/LoadBonus, IsTheUserACryBabyCheater.
 *   + static cheatList[10]/bonusList[3] (tCheat) code tables, byte-exact from retail binary.
 */
#include "fecheats.h"

/* MATCH (w35-a10): UNSIZED-ARRAY ASM-LABEL VIEWS of the two cheat bitmasks.
   Both are strong .sdata symbols (asm/data/sdata_8013C54C.sdata.s) that every
   oracle reaches with an absolute %hi/%lo pair sharing ONE gcc-allocated base
   register across a read+write pair; a bare `extern unsigned int` leaves
   cc1plus emitting the `lw $2,sym` / `sw $2,sym` assembler macros, which
   GNU-as expands per-access (self-temp load + $at store).  The array view
   turns %hi back into an RTL pseudo (catalog wave-13 lever). */
/* MATCH (w35-a10): unsized-array asm-label views -- these globals are reached
   ABSOLUTELY by every oracle (%hi/%lo as an RTL pseudo, CSE-able and
   delay-slot schedulable); a plain extern leaves cc1plus emitting the lw/sw
   assembler macro, which GNU-as expands per-access (self-temp / $at). */
extern tRecordBuffer *A_Stats_gTrackRecords[] __asm__("Stats_gTrackRecords");
#define Stats_gTrackRecords A_Stats_gTrackRecords[0]

extern tFEApplication *A_FEApp[] __asm__("FEApp");
#define FEApp A_FEApp[0]
extern unsigned int A_gFECheats[] __asm__("gFECheats");
extern unsigned int A_gFEBonus[]  __asm__("gFEBonus");
#define gFECheats A_gFECheats[0]
#define gFEBonus  A_gFEBonus[0]

static tCheat cheatList[10] = {   /* @0x80051628, byte-exact from retail binary */
    {{0x59,0x68,0x06,0x06,0x60,0x7e,0x7f,0x00}, 11},
    {{0x59,0x58,0x16,0x16,0x60,0x7e,0x7f,0x00}, 12},
    {{0x61,0x70,0x0e,0x26,0x58,0x7e,0x7f,0x00}, 13},
    {{0x1b,0x06,0x0f,0x17,0x10,0x1e,0x1f,0x00}, 14},
    {{0x2d,0x41,0x34,0x02,0x50,0x7e,0x7f,0x00}, 19},
    {{0x0e,0x05,0x01,0x02,0x05,0x0e,0x0f,0x00}, 23},
    {{0x24,0x1f,0x2c,0x1c,0x12,0x3e,0x3f,0x00}, 30},
    {{0x13,0x29,0x1c,0x06,0x29,0x3e,0x3f,0x00}, 29},
    {{0x03,0x03,0x0f,0x06,0x00,0x0e,0x0f,0x00}, 28},
    {{0x1e,0x1f,0x3f,0x1b,0x00,0x3e,0x3f,0x00}, 27},
};
static tCheat bonusList[3] = {   /* @0x800516a0, byte-exact from retail binary */
    {{0x9d,0x99,0x88,0x86,0x93,0xaf,0x92,0xff}, 20},
    {{0x87,0xdf,0xdf,0xab,0x9d,0x8f,0xd8,0xff}, 21},
    {{0xf6,0x9c,0x8c,0x9f,0xff,0xff,0xbf,0xff}, 22},
};


/* ---- FECheat_HandleActivation  [FECHEATS.CPP:89-152] SLD-VERIFIED ---- */

void FECheat_HandleActivation(tCheatCode cheat)

{
  int i;
  int iVar1;
  short num;
  short sVar2;
  int iVar3;
  
  switch(cheat) {
  case cheat_Roadster:
  case cheat_Pony:
  case cheat_Saloon:
  case cheat_Sports:
  case cheat_SuperCar:
  case cheat_GTRCar:
  case cheat_BonusCar:
  case cheat_CopCar:
    carManager.SetClassAvailable((tCarClassType)cheat,true);
    break;
  case cheat_AllCars:
    iVar3 = 0;
    iVar1 = 0;
    do {
      FECheat_HandleActivation((tCheatCode)(iVar1 >> 0x10));
      iVar3 = iVar3 + 1;
      iVar1 = iVar3 * 0x10000;
    } while (iVar3 * 0x10000 >> 0x10 < 7);
    break;
  case cheat_AllTracks:
    trackManager.SetClassAvailable(tct_Beginner,true);
    trackManager.SetClassAvailable(tct_Intermediate,true);
    trackManager.SetClassAvailable(tct_Expert,true);
    trackManager.SetClassAvailable(tct_GTR,true);
    trackManager.SetClassAvailable(tct_Bonus,true);
    break;
  case cheat_MoreMoney:
  case cheat_BonusMoney:
    tournamentManager.fMoney = tournamentManager.fMoney + 50000;
    break;
  case cheat_AllCheats:
    gFECheats = 0xffffffff;
    iVar3 = 0;
    i = 0;
    do {
      if (i >> 0x10 != cheat_AllCheats) {
        FECheat_HandleActivation((tCheatCode)(i >> 0x10));
      }
      iVar3 = iVar3 + 1;
      i = iVar3 * 0x10000;
    } while (iVar3 * 0x10000 >> 0x10 < 0x1f);
    break;
  case cheat_NFSTeamRecords:
    Stattool_GetAllDefaultRecords(Stats_gTrackRecords,true);
    break;
  case cheat_LotsaMoney:
    tournamentManager.fMoney = tournamentManager.fMoney + 100000000;
    break;
  case cheat_AllNotRaced:
  case cheat_AllGold:
  case cheat_AllSilver:
  case cheat_AllBronze:
    for (sVar2 = 0; sVar2 < 0x40; sVar2 = sVar2 + 1) {
      tournamentManager.fBestPlacement[sVar2] = (char)cheat + -0x1b;
    }
  }
  return;
}



/* ---- FECheat_EncodeString  [FECHEATS.CPP:159-181] SLD-VERIFIED ---- */

void FECheat_EncodeString(char *input,char *output)

{
  char *pcVar1;
  char *pcVar2;
  char *pcVar3;
  u_char *pbVar4;
  int j;
  u_int uVar5;
  int iVar6;
  int i;
  char buffer [8];
  
  iVar6 = 0;
  do {
    pcVar3 = buffer + iVar6;
    pcVar1 = input + iVar6;
    pcVar2 = output + iVar6;
    iVar6 = iVar6 + 1;
    *pcVar3 = *pcVar1;
    *pcVar2 = '\0';
  } while (iVar6 < 8);
  iVar6 = 0;
  do {
    uVar5 = 0;
    do {
      pbVar4 = (u_char *)(buffer + uVar5);
      output[iVar6] = output[iVar6] | (u_char)((*pbVar4 & 1) << uVar5);
      uVar5 = uVar5 + 1;
      *pbVar4 = *pbVar4 >> 1;
    } while ((int)uVar5 < 8);
    iVar6 = iVar6 + 1;
  } while (iVar6 < 8);
  return;
}



/* ---- FECheat_EncodeString2  [FECHEATS.CPP:188-221] SLD-VERIFIED ---- */

void FECheat_EncodeString2(char *input,char *output)

{
  u_int uVar1;
  u_int uVar2;
  u_char bVar3;
  u_char *pbVar4;
  u_char *pbVar5;
  u_char *inBase;
  u_char *outBase;
  int iVar6;
  int i;
  u_int uVar7;
  char buffer [8];

  iVar6 = 0;
  inBase = (u_char *)input;
  outBase = (u_char *)output;
  do {
    pbVar5 = inBase + iVar6;
    buffer[iVar6] = ~*pbVar5;
    pbVar4 = outBase + iVar6;
    iVar6 = iVar6 + 1;
    *pbVar4 = ~*pbVar5;
  } while (iVar6 < 8);
  uVar7 = 0;
  do {
    pbVar5 = (u_char *)(output + uVar7);
    *output = *output ^ (u_char)(((int)(u_int)(u_char)*output >> uVar7 & 1U) << uVar7);
    *pbVar5 = *pbVar5 ^ (u_char)(((int)(u_int)*pbVar5 >> uVar7 & 1U) << uVar7);
    *output = *output | (u_char)(((int)(u_int)(u_char)buffer[uVar7] >> uVar7 & 1U) <<
                              uVar7);
    uVar2 = uVar7;
    uVar1 = uVar7;
    uVar7 = uVar7 + 1;
    *pbVar5 = *pbVar5 | (u_char)(((int)(u_int)(u_char)buffer[0] >> uVar2 & 1U) << uVar1);
  } while ((int)uVar7 < 8);
  iVar6 = 1;
  do {
    pbVar4 = (u_char *)(output + iVar6);
    uVar7 = iVar6 - 1;
    pbVar5 = (u_char *)(buffer + iVar6);
    bVar3 = *pbVar4 & 0xfe;
    *pbVar4 = bVar3;
    bVar3 = bVar3 ^ (u_char)(((int)(u_int)bVar3 >> uVar7 & 1U) << uVar7);
    *pbVar4 = bVar3;
    bVar3 = bVar3 | (u_char)((int)(u_int)*pbVar5 >> uVar7) & 1;
    *pbVar4 = bVar3;
    iVar6 = iVar6 + 1;
    *pbVar4 = bVar3 | (u_char)((*pbVar5 & 1) << uVar7);
  } while (iVar6 < 8);
  return;
}



/* ---- FECheat_ActivateBonus  [FECHEATS.CPP:232-234] SLD-VERIFIED ---- */

void FECheat_ActivateBonus(tCheatCode cheat)

{

  FECheat_HandleActivation(cheat);
  gFEBonus = gFEBonus | 1 << cheat;   /* no & cheat_NumCheats: sllv masks to 5 bits; oracle has no andi */
  return;
}



/* ---- FECheat_ActivateCheat  [FECHEATS.CPP:242-271] SLD-VERIFIED ---- */

void * FECheat_ActivateCheat(char *cheat)

{
  tFEApplication *ptVar2;
  char *pcVar4;
  tDialogMessageString *dlgThis;
  int i;
  int j;
  int result;
  char buffer [8];

  /* MATCH: ONE result var (retail $s1) with a single return at the end; the
     `1` it holds is REUSED as the shift base of the gFECheats mask
     (shared-constant, methodology 3.12 #17).  Outer loop is exit-in-the-middle
     so gcc does NOT rotate it (top slti + unconditional `j` back-edge). */
  result = 0;
  FECheat_EncodeString(cheat,buffer);
  i = 0;
  while (true) {
    if (9 < i) break;
    for (j = 0; j < 8; j = j + 1) {
      if (cheatList[0].name[j + i * 12] != buffer[j]) break;
    }
    if (j == 8) {
      AudioCmn_PlayFESFX(0x1a);
      dlgThis = &FEApp->MemCardDialog;
      pcVar4 = TextSys_Word(0x27a);
      ptVar2 = FEApp;
      dlgThis->string = pcVar4;
      ((tDialogBase *)&ptVar2->MemCardDialog)->Display();
      FECheat_HandleActivation((tCheatCode)cheatList[i].cheat);
      result = 1;
      gFECheats = gFECheats | result << cheatList[i].cheat;
      break;
    }
    i = i + 1;
  }
  return (void *)result;
}




/* ---- FECheat_IsCheatEnabled  [FECHEATS.CPP:277-278] SLD-VERIFIED ---- */

void * FECheat_IsCheatEnabled(tCheatCode cheat)

{
  return (void *)(u_int)(((gFECheats | gFEBonus) & 1 << cheat) != 0);
}



/* ---- FECheat_SaveBonus  [FECHEATS.CPP:285-286] SLD-VERIFIED ---- */

void FECheat_SaveBonus(u_long &cheat)

{
  cheat = gFEBonus;
  return;
}



/* ---- FECheat_LoadBonus  [FECHEATS.CPP:293-305] SLD-VERIFIED ---- */

void FECheat_LoadBonus(u_long &cheat)

{
  int i;
  u_int i_2;
  i_2 = 0;
  gFEBonus = cheat;
  gFECheats = 0;
  do {
    if ((gFEBonus & 1 << i_2) != 0) {
      FECheat_HandleActivation((tCheatCode)(i_2));
    }
    i_2 = i_2 + cheat_Pony;
  } while ((int)i_2 < 0x1f);
  return;
}



/* ---- FECheat_IsTheUserACryBabyCheater  [FECHEATS.CPP:312-316] SLD-VERIFIED ---- */

void * FECheat_IsTheUserACryBabyCheater(void)

{
  return (void *)(u_int)(gFECheats != 0);
}



/* ---- FECheat_ActivateBonusByCode  [FECHEATS.CPP:324-349] SLD-VERIFIED ---- */

void * FECheat_ActivateBonusByCode(char *code)

{
  int i;
  int j;
  int result;
  char buffer [8];

  /* MATCH: twin of FECheat_ActivateCheat -- one result var + single return,
     rotated `for` inner compare loop.  Here the OUTER loop is a real
     do{}while(i<3) (bottom slti) with TWO ivs: the tCheat* walker and the
     byte offset. */
  result = 0;
  FECheat_EncodeString2(code,buffer);
  i = 0;
  do {
    for (j = 0; j < 8; j = j + 1) {
      if (bonusList[i].name[j] != buffer[j]) break;
    }
    if (j == 8) {
      AudioCmn_PlayFESFX(0x1a);
      FECheat_ActivateBonus((tCheatCode)bonusList[i].cheat);
      result = 1;
      break;
    }
    i = i + 1;
  } while (i < 3);
  return (void *)result;
}




/* end of fecheats.cpp */
