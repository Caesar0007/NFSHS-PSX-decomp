/* game/common/dashhud.cpp -- RECONSTRUCTED (NFS4 PSX dash HUD init/calc; C++ TU)
 *   6 free fns: DashHUD_InitHUD/KillHUD/ResetHUD/ToggleHud/CheckWrongWay/HUDCalc. GTE-free.
 */
#include "../../nfs4_types.h"
#include "dashhud_externs.h"

/* ---- dashhud.obj OWNED globals (EXT; SYM Globals.jsonl) ---- */
int          resethud;        /* 0x8013ddb0 [$gp+0x1864] reset/toggle flag */
dashhud_info DashHUD_gInfo;    /* 0x80112730 */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void DashHUD_InitHUD(void);
void DashHUD_KillHUD(void);
void DashHUD_ResetHUD(void);
void DashHUD_ToggleHud(int player);
void DashHUD_CheckWrongWay(int player);
void DashHUD_HUDCalc(int player);


/* ---- DashHUD_InitHUD__Fv  [DASHHUD.CPP:38-91] SLD-VERIFIED ---- */
void DashHUD_InitHUD(void)

{
  int i;
  int iVar1;
  int iVar2;
  GameSetup_tData *pGVar3;
  
  iVar2 = 0;
  pGVar3 = &GameSetup_gData;
  DashHUD_gInfo.splitscreen = (int)(GameSetup_gData.commMode == 1);
  do {
    iVar1 = pGVar3->carInfo[0].HudSpeed;
    if (iVar1 == 0) {
      pGVar3->carInfo[0].HudSpeedMult = 0x23ca5;
    }
    else if (iVar1 == 1) {
      pGVar3->carInfo[0].HudSpeedMult = 0x39999;
    }
    iVar2 = iVar2 + 1;
    pGVar3 = (GameSetup_tData *)((pGVar3->controllerData).shockImpact + 1);
  } while (iVar2 <= DashHUD_gInfo.splitscreen);
  DashHUD_gInfo.showhud[0] = 1;
  DashHUD_gInfo.showhud[1] = 1;
  if (DashHUD_gInfo.splitscreen != 0) {
    DashHUD_gInfo.showmap[1] = 0;
  }
  DashHUD_gInfo.showmap[0] = (int)(DashHUD_gInfo.splitscreen == 0);
  DashHUD_gInfo.wrongway[0] = 0;
  DashHUD_gInfo.wrongway[1] = 0;
  if (Replay_ReplayMode < 2) {
    DashHUD_gInfo.record = GameSetup_gData.userSetting.bestlap;
  }
  else {
    DashHUD_gInfo.record = 0;
  }
  DashHUD_gInfo.tutor = 0;
  DashHUD_gInfo.warning[0] = 0;
  DashHUD_gInfo.warning[1] = 0;
  DashHUD_gInfo.maxlaps = GameSetup_gData.numLaps;
  HudPmx_InitTextures();
  Hud_Init0();
  Hud_Init();
  Hud_PositionMap();
  return;
}

/* ---- DashHUD_KillHUD__Fv  [DASHHUD.CPP:101-102] SLD-VERIFIED ---- */
void DashHUD_KillHUD(void)

{
  Hud_Kill();
  return;
}

/* ---- DashHUD_ResetHUD__Fv  [DASHHUD.CPP:106-118] SLD-VERIFIED ---- */
void DashHUD_ResetHUD(void)

{
  if (Replay_ReplayMode < 2) {
    DashHUD_gInfo.record = GameSetup_gData.userSetting.bestlap;
  }
  else {
    DashHUD_gInfo.record = 0;
  }
  DashHUD_gInfo.warning[0] = 0;
  DashHUD_gInfo.warning[1] = 0;
  if (Replay_ReplayMode < 2) {
    DashHUD_gInfo.showhud[0] = 1;
    DashHUD_gInfo.showhud[1] = 1;
  }
  return;
}

/* ---- DashHUD_ToggleHud__Fi  [DASHHUD.CPP:125-127] SLD-VERIFIED ---- */
void DashHUD_ToggleHud(int player)

{
  DashHUD_gInfo.showhud[player] = DashHUD_gInfo.showhud[player] ^ 1;
  return;
}

/* ---- DashHUD_CheckWrongWay__Fi  [DASHHUD.CPP:151-164] SLD-VERIFIED ---- */
void DashHUD_CheckWrongWay(int player)

{
  int wrongway;
  Car_tObj * car;
  BO_tNewtonObj *pBVar1;
  int iVar2;
  
  pBVar1 = Camera_gInfo[player].anchor[1].collision.lastOtherObj;
  iVar2 = 0;
  if ((0x3f < (int)pBVar1) && (iVar2 = 2, (int)pBVar1 < 0x94)) {
    iVar2 = 1;
  }
  if (iVar2 != DashHUD_gInfo.wrongway[player]) {
    DashHUD_gInfo.wrongway[player] = iVar2;
  }
  return;
}

/* ---- DashHUD_HUDCalc__Fi  [DASHHUD.CPP:171-258] SLD-VERIFIED ---- */
void DashHUD_HUDCalc(int player)

{
  Car_tObj * car;
  int iVar1;
  Car_tObj *carObj;
  
  carObj = Cars_gHumanRaceCarList[player];
  DashHUD_gInfo.lap = (carObj->stats).lap + 1;
  if (DashHUD_gInfo.lap < 1) {
    DashHUD_gInfo.lap = 1;
  }
  if (DashHUD_gInfo.maxlaps < DashHUD_gInfo.lap) {
    DashHUD_gInfo.lap = DashHUD_gInfo.maxlaps;
  }
  if (simGlobal.gameTicks < 0x200) {
    DashHUD_gInfo.laptime = 0;
    DashHUD_gInfo.flashtime = 0;
    goto DashHudCalc_lapTimeCheck;
  }
  iVar1 = (carObj->stats).lap;
  if ((iVar1 == 0) ||
     ((0x13f < simGlobal.gameTicks - (carObj->stats).lapTime && ((carObj->stats).finishType != 2))))
  {
    DashHUD_gInfo.flashtime = 0;
    DashHUD_gInfo.laptime = simGlobal.gameTicks - (carObj->stats).lapTime;
  }
  else {
    DashHUD_gInfo.laptime = (carObj->stats).time[iVar1 + -1];
    if (((GameSetup_gData.raceType != 4) && (Replay_ReplayMode < 2)) &&
       ((DashHUD_gInfo.record == 0 ||
        ((DashHUD_gInfo.laptime < DashHUD_gInfo.record || (GameSetup_gData.checkpointType == 4))))))
    {
      DashHUD_gInfo.flashtime = 1;
      DashHUD_gInfo.record = DashHUD_gInfo.laptime;
      goto DashHudCalc_lapTimeCheck;
    }
    if (DashHUD_gInfo.record == DashHUD_gInfo.laptime) {
      DashHUD_gInfo.flashtime = 1;
    }
    if ((carObj->stats).sliceTime + 0xc0 < simGlobal.gameTicks) {
      DashHUD_gInfo.flashtime = 0;
    }
    if ((DashHUD_gInfo.flashtime != 0) && ((simGlobal.gameTicks & 0x10U) != 0)) {
      if (resethud == 0) {
        resethud = 1;
      }
      goto DashHudCalc_lapTimeCheck;
    }
  }
  if (resethud != 0) {
    resethud = 0;
  }
DashHudCalc_lapTimeCheck:
  if ((simGlobal.gameTicks - (carObj->stats).lapTime < 0x140) &&
     (DashHUD_gInfo.lap == DashHUD_gInfo.maxlaps)) {
    DashHUD_gInfo.flashlap = 1;
  }
  else {
    DashHUD_gInfo.flashlap = 0;
  }
  DashHUD_gInfo.position = Stats_GetPosition(carObj);
  DashHUD_gInfo.opponents = Stats_GetNumOpponents();
  Cars_InitDashData(carObj,(int *)((char *)&DashHUD_gInfo + 0x44) /* @0x80112774 */,(int *)((char *)&DashHUD_gInfo + 0x50) /* @0x80112780 */);
  Cars_GetDashData(carObj,(int *)((char *)&DashHUD_gInfo + 0x40) /* @0x80112770 */,(int *)((char *)&DashHUD_gInfo + 0x48) /* @0x80112778 */,(int *)((char *)&DashHUD_gInfo + 0x4c) /* @0x8011277c */);
  if (DashHUD_gInfo.speed < 0) {
    DashHUD_gInfo.speed = -DashHUD_gInfo.speed;
  }
  DashHUD_gInfo.topspeed = (int)(*(u_short *)((u_char *)&(DashHUD_gInfo.topspeed) + 2));
  return;
}

/* end of dashhud.cpp */
