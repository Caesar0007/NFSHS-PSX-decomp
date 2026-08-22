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
  int     newGear;

  if ((CONTROL_GAME_TICKS & 3U) != 0) {
    return;
  }
  if ((0 < Cars_gNumAICars) && (carObj->carIndex == 0)) {
    AI_Main_OverallSetup();
  }
  InGame_SetRamp();
  (*(void (*)(Car_tObj *))carObj->funcReplay)(carObj);
  if (carObj->RSControl != 0) {
    carObj->control.desiredGasLevel = carObj->RSGasLevel & 0xf8;
    carObj->control.desiredSteering = (carObj->RSSteering / 4) * 4;
    carObj->control.desiredBrakeLevel = 0;
    carObj->control.handBrake = 0;
    carObj->control.horn = 0;
    carObj->control.abort = 0;
    carObj->control.event = 0;
  }
  else {
    (carObj->control).desiredGasLevel = CONTROL_INPUT_GAS & 0xf8;
    (carObj->control).desiredBrakeLevel = CONTROL_INPUT_BRAKE & 0xf8;
    if (CONTROL_MIRROR_TRACK == 1) {
      carObj->control.desiredSteering = (CONTROL_INPUT_STEERING / 4) * -4;
    }
    else {
      carObj->control.desiredSteering = (CONTROL_INPUT_STEERING / 4) * 4;
    }
    (carObj->control).handBrake = CONTROL_INPUT_FLAGS & 1;
    (carObj->control).horn = CONTROL_INPUT_FLAGS >> 1 & 1;
    (carObj->control).abort = CONTROL_INPUT_FLAGS >> 3 == 3;
    (carObj->control).event = CONTROL_INPUT_FLAGS >> 3;
  }
  switch((carObj->control).event) {
  case '\x04':
    if (HudBustedOverlay != 0) break;
    carObj->control.queuedEvent = carObj->control.event;
    Hud_WingmanFlash(carObj->carIndex, 0);
    break;
  case '\x05':
    if (HudBustedOverlay != 0) break;
    carObj->control.queuedEvent = carObj->control.event;
    Hud_WingmanFlash(carObj->carIndex, 1);
    break;
  case '\x06':
    if (HudBustedOverlay != 0) break;
    carObj->control.queuedEvent = carObj->control.event;
    Hud_WingmanFlash(carObj->carIndex, 2);
    break;
  case '\a':
    if (carObj->carInfo->carType - 0x16U >= 6) {
      if ((carObj->control.lights & 8) != 0) {
        carObj->control.lights &= 0xe7;
        carObj->render.signalLight[0] = 0;
        carObj->render.signalLight[1] = 0;
      }
      else {
        carObj->control.lights = (carObj->control.lights | 8) & 0xef;
        carObj->render.signalLight[1] = 0;
        carObj->render.signalLight[0] |= 0x80;
      }
    }
    break;
  case '\b':
    if (5 < carObj->carInfo->carType - 0x16U) {
      if ((carObj->control.lights & 0x10) != 0) {
        carObj->control.lights &= 0xe7;
        carObj->render.signalLight[1] = 0;
        carObj->render.signalLight[0] = 0;
      }
      else {
        carObj->control.lights = (carObj->control.lights | 0x10) & 0xf7;
        carObj->render.signalLight[0] = 0;
        carObj->render.signalLight[1] |= 0x80;
      }
    }
    break;
  case '\v':
    if (carObj->carInfo->carType - 0x16U < 6) {
      if ((carObj->AIFlags & 2) != 0) {
        carObj->AIFlags &= ~2;
      }
      else {
        carObj->AIFlags |= 2;
      }
    }
    else {
      if ((carObj->control.lights & 0x18) == 0) {
        carObj->control.lights |= 0x18;
        carObj->render.signalLight[0] |= 0x80;
        carObj->render.signalLight[1] |= 0x80;
      }
      else {
        carObj->control.lights &= 0xe7;
        carObj->render.signalLight[0] = 0;
        carObj->render.signalLight[1] = 0;
      }
    }
    break;
  case '\f':
    if ((carObj->AIFlags & 2U) == 0) {
      signed char lights;

      lights = carObj->control.lights ^ 3;
      carObj->control.lights = lights;
      if ((lights & 2) != 0) {
        R3DCar_TurnHeadLightOn(carObj,1);
      }
      else {
        R3DCar_TurnHeadLightOff(carObj, (lights &= 4) < 1);
      }
    }
    break;
  case '\x0e':
    carObj->control.lights ^= 4;
    if (((carObj->control.lights & 2) == 0) &&
        ((carObj->AIFlags & 2U) == 0)) {
      if ((carObj->control.lights & 4) != 0) {
        R3DCar_TurnHeadLightOn(carObj,0);
      }
      else {
        R3DCar_TurnHeadLightOff(carObj,1);
      }
    }
    break;
  }
  newGear = Input_Gear((carObj->control).gear,carObj->specs->numGears);
  if ((carObj->flywheelRpm <= carObj->specs->redline) || ((carObj->control).gear <= newGear)) {
    (carObj->control).desiredGear = newGear;
  }
  return;
}
