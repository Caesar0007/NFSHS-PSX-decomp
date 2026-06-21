/* game/common/control.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   control.obj (C:\nfs4\GAME\COMMON\CONTROL.CPP) = 2 fns, owns NO data.
 *     Control_AI    @0x80091fdc (line 40-72)  -- empty stub (AI cars driven elsewhere).
 *     Control_Human @0x80091fe4 (line 80-277) -- per-tick human-car input -> control struct.
 *   SYM: Control_AI(carObj REGPARM); Control_Human(carObj REGPARM, local newGear REG INT).
 *   NOT original source; SYM-faithful, self-contained, recompilable.
 */
#include "control.h"
#include "control_externs.h"

/* @0x80091fdc  Control_AI(Car_tObj *carObj) -- line 40 */
void Control_AI(Car_tObj *carObj)
{
  return;
}

/* @0x80091fe4  Control_Human(Car_tObj *carObj) -- line 80 */
void Control_Human(Car_tObj *carObj)
{
  u_short uVar1;
  char    cVar2;
  u_char  bVar3;
  int     iVar4;
  int     newGear;
  int     index;
  u_int   uVar5;

  if ((simGlobal.gameTicks & 3U) != 0) {
    return;
  }
  if ((0 < Cars_gNumAICars) && (carObj->carIndex == 0)) {
    AI_Main_OverallSetup();
  }
  InGame_SetRamp();
  (*(void (*)(Car_tObj *))carObj->funcReplay)(carObj);
  if (carObj->RSControl == 0) {
    (carObj->control).desiredGasLevel = Input_gSim.gas & 0xf8;
    (carObj->control).desiredBrakeLevel = Input_gSim.brake & 0xf8;
    if (GameSetup_gData.mirrorTrack == 1) {
      iVar4 = (int)Input_gSim.steering;
      if (iVar4 < 0) {
        iVar4 = iVar4 + 3;
      }
      iVar4 = (iVar4 >> 2) * -4;
    }
    else {
      iVar4 = (int)Input_gSim.steering;
      if (iVar4 < 0) {
        iVar4 = iVar4 + 3;
      }
      iVar4 = (iVar4 >> 2) << 2;
    }
    (carObj->control).desiredSteering = iVar4;
    (carObj->control).handBrake = Input_gSim.flags & 1;
    (carObj->control).horn = Input_gSim.flags >> 1 & 1;
    (carObj->control).abort = Input_gSim.flags >> 3 == 3;
    (carObj->control).event = Input_gSim.flags >> 3;
  }
  else {
    iVar4 = carObj->RSSteering;
    (carObj->control).desiredGasLevel = carObj->RSGasLevel & 0xf8;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 3;
    }
    (carObj->control).desiredSteering = (iVar4 >> 2) << 2;
    (carObj->control).desiredBrakeLevel = '\0';
    (carObj->control).handBrake = '\0';
    (carObj->control).horn = '\0';
    (carObj->control).abort = '\0';
    (carObj->control).event = '\0';
  }
  switch((carObj->control).event) {
  case '\x04':
    if (HudBustedOverlay != 0) goto update_gear;
    iVar4 = carObj->carIndex;
    cVar2 = (carObj->control).event;
    index = 0;
    break;
  case '\x05':
    if (HudBustedOverlay != 0) goto update_gear;
    iVar4 = carObj->carIndex;
    cVar2 = (carObj->control).event;
    index = 1;
    break;
  case '\x06':
    if (HudBustedOverlay != 0) goto update_gear;
    iVar4 = carObj->carIndex;
    cVar2 = (carObj->control).event;
    index = 2;
    break;
  case '\a':
    if (carObj->carInfo->carType - 0x16U < 6) goto update_gear;
    bVar3 = (carObj->control).lights;
    if ((bVar3 & 8) == 0) {
      uVar1 = (carObj->render).signalLight[0];
      (carObj->control).lights = bVar3 & 0xef | 8;
      (carObj->render).signalLight[1] = 0;
      (carObj->render).signalLight[0] = uVar1 | 0x80;
      goto update_gear;
    }
    goto signal_clear;
  case '\b':
    if (5 < carObj->carInfo->carType - 0x16U) {
      bVar3 = (carObj->control).lights;
      if ((bVar3 & 0x10) == 0) {
        uVar1 = (carObj->render).signalLight[1];
        (carObj->control).lights = bVar3 & 0xf7 | 0x10;
        (carObj->render).signalLight[0] = 0;
        (carObj->render).signalLight[1] = uVar1 | 0x80;
      }
      else {
        (carObj->control).lights = bVar3 & 0xe7;
        (carObj->render).signalLight[1] = 0;
        (carObj->render).signalLight[0] = 0;
      }
    }
  default:
    goto update_gear;
  case '\v':
    if (carObj->carInfo->carType - 0x16U < 6) {
      uVar5 = carObj->AIFlags;
      if ((uVar5 & 2) == 0) {
        carObj->AIFlags = uVar5 | 2;
      }
      else {
        carObj->AIFlags = uVar5 & 0xfffffffd;
      }
      goto update_gear;
    }
    bVar3 = (carObj->control).lights;
    if ((bVar3 & 0x18) == 0) {
      (carObj->control).lights = bVar3 | 0x18;
      uVar1 = (carObj->render).signalLight[1];
      (carObj->render).signalLight[0] = (carObj->render).signalLight[0] | 0x80;
      (carObj->render).signalLight[1] = uVar1 | 0x80;
      goto update_gear;
    }
signal_clear:
    (carObj->control).lights = bVar3 & 0xe7;
    (carObj->render).signalLight[0] = 0;
    (carObj->render).signalLight[1] = 0;
    goto update_gear;
  case '\f':
    if ((carObj->AIFlags & 2U) != 0) goto update_gear;
    bVar3 = (carObj->control).lights ^ 3;
    (carObj->control).lights = bVar3;
    if ((bVar3 & 2) != 0) {
      R3DCar_TurnHeadLightOn(carObj,1);
      goto update_gear;
    }
    uVar5 = (u_int)((bVar3 & 4) == 0);
    goto headlight_off;
  case '\x0e':
    bVar3 = (carObj->control).lights ^ 4;
    (carObj->control).lights = bVar3;
    if (((bVar3 & 2) != 0) || ((carObj->AIFlags & 2U) != 0)) goto update_gear;
    if ((bVar3 & 4) != 0) {
      R3DCar_TurnHeadLightOn(carObj,0);
      goto update_gear;
    }
    uVar5 = 1;
headlight_off:
    R3DCar_TurnHeadLightOff(carObj,uVar5);
    goto update_gear;
  }
  (carObj->control).queuedEvent = cVar2;
  Hud_WingmanFlash(iVar4,index);
update_gear:
  newGear = Input_Gear((carObj->control).gear,carObj->specs->numGears);
  if ((carObj->flywheelRpm <= carObj->specs->redline) || ((u_char)(carObj->control).gear <= (u_char)newGear)) {
    (carObj->control).desiredGear = newGear;
  }
  return;
}
