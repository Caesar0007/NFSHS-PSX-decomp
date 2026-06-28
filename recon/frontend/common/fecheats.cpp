/* frontend/common/fecheats.cpp -- RECONSTRUCTED (cheat / bonus-code system; C++ TU)
 *   10 free fns (ns nfs4::FRONTEND::COMMON::FECheats): HandleActivation (per-cheat effect
 *   switch), EncodeString/EncodeString2 (bit-shuffle obfuscation of typed codes),
 *   Activate{Cheat,Bonus,BonusByCode}, IsCheatEnabled, Save/LoadBonus, IsTheUserACryBabyCheater.
 *   + static cheatList[10]/bonusList[3] (tCheat) code tables, byte-exact from retail binary.
 */
#include "fecheats.h"

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
      output[iVar6] = output[iVar6] | (u_char)((*pbVar4 & 1) << (uVar5 & 0x1f));
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
  int iVar6;
  int i;
  u_int uVar7;
  char buffer [8];
  
  iVar6 = 0;
  pbVar5 = (u_char *)input;
  do {
    buffer[iVar6] = ~*pbVar5;
    pbVar4 = (u_char *)(output + iVar6);
    iVar6 = iVar6 + 1;
    *pbVar4 = ~*pbVar5;
    pbVar5 = (u_char *)(input + iVar6);
  } while (iVar6 < 8);
  uVar7 = 0;
  do {
    pbVar5 = (u_char *)(output + uVar7);
    *output = *output ^ (u_char)(((int)(u_int)(u_char)*output >> (uVar7 & 0x1f) & 1U) << (uVar7 & 0x1f));
    *pbVar5 = *pbVar5 ^ (u_char)(((int)(u_int)*pbVar5 >> (uVar7 & 0x1f) & 1U) << (uVar7 & 0x1f));
    *output = *output | (u_char)(((int)(u_int)(u_char)buffer[uVar7] >> (uVar7 & 0x1f) & 1U) <<
                              (uVar7 & 0x1f));
    uVar2 = uVar7 & 0x1f;
    uVar1 = uVar7 & 0x1f;
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
    bVar3 = bVar3 ^ (u_char)(((int)(u_int)bVar3 >> (uVar7 & 0x1f) & 1U) << (uVar7 & 0x1f));
    *pbVar4 = bVar3;
    bVar3 = bVar3 | (u_char)((int)(u_int)*pbVar5 >> (uVar7 & 0x1f)) & 1;
    *pbVar4 = bVar3;
    iVar6 = iVar6 + 1;
    *pbVar4 = bVar3 | (u_char)((*pbVar5 & 1) << (uVar7 & 0x1f));
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
  tFEApplication *ptVar1;
  tFEApplication *ptVar2;
  int iVar3;
  char *pcVar4;
  int j;
  int iVar5;
  int iVar6;
  tDialogMessageString *dlgThis;
  u_char result;
  int i;
  int iVar7;
  char buffer [8];
  
  FECheat_EncodeString(cheat,buffer);
  iVar7 = 0;
  iVar6 = 0;
  do {
    iVar5 = 0;
    iVar3 = iVar6;
    if (9 < iVar7) {
      return (void *)0x0;
    }
    do {
      if (cheatList[0].name[iVar3] != buffer[iVar5]) break;
      iVar5 = iVar5 + 1;
      iVar3 = iVar5 + iVar6;
    } while (iVar5 < 8);
    iVar6 = iVar6 + 0xc;
    if (iVar5 == 8) {
      AudioCmn_PlayFESFX(0x1a);
      ptVar1 = FEApp;
      pcVar4 = TextSys_Word(0x27a);
      ptVar2 = FEApp;
      (ptVar1->MemCardDialog).string = pcVar4;
      ((tDialogBase *)&ptVar2->MemCardDialog)->Display();
      FECheat_HandleActivation((tCheatCode)cheatList[iVar7].cheat);
      gFECheats = gFECheats | 1 << (cheatList[iVar7].cheat & cheat_NumCheats);
      return (void *)0x1;
    }
    iVar7 = iVar7 + 1;
  } while( true );
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
    if ((gFEBonus & 1 << (i_2 & cheat_NumCheats)) != 0) {
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
  int iVar1;
  int j;
  int iVar2;
  int iVar3;
  int iVar4;
  int i;
  tCheat *ptVar5;
  u_char result;
  char buffer [8];
  
  FECheat_EncodeString2(code,buffer);
  iVar4 = 0;
  ptVar5 = bonusList;
  iVar3 = 0;
  do {
    iVar2 = 0;
    iVar1 = iVar3;
    do {
      if (bonusList[0].name[iVar1] != buffer[iVar2]) break;
      iVar2 = iVar2 + 1;
      iVar1 = iVar2 + iVar3;
    } while (iVar2 < 8);
    iVar4 = iVar4 + 1;
    if (iVar2 == 8) {
      AudioCmn_PlayFESFX(0x1a);
      FECheat_ActivateBonus((tCheatCode)ptVar5->cheat);
      return (void *)0x1;
    }
    ptVar5 = ptVar5 + 1;
    iVar3 = iVar3 + 0xc;
    if (2 < iVar4) {
      return (void *)0x0;
    }
  } while( true );
}



/* end of fecheats.cpp */
