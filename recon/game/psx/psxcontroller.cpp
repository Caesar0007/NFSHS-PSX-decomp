/* game/psx/psxcontroller.cpp -- RECONSTRUCTED (NFS4 in-game PSX controller mapping; C++ TU)
 *   4 fns: InGame_ResetPSXController (map pad+config -> Input_gHandler[]), InGame_GetPSXPadValue
 *   (axis selector -> packed control word, per controller type + per-player range cal),
 *   InGame_GetDevice (control & 0xff), InGame_SetRamp (digital-input -> disable analog ramp). No GTE.
 */
#include "../../nfs4_types.h"
#include "psxcontroller_externs.h"


/* ---- InGame_ResetPSXController__Fii  [PSXCONTROLLER.CPP:97-163] SLD-VERIFIED ---- */
void InGame_ResetPSXController(int player,int config)

{
  int type;
  int *h;
  u_int v;

  type = gPadinfo.buf[player * 4].ID;
  if (type == 0x23) {
    type = 0;
  }
  else if ((type == 0x53) || (type == 0x73)) {
    type = 1;
  }
  else {
    type = 2;
  }
  if (frontEnd.controlType[player] != (u_short)gPadinfo.buf[player * 4].ID) {
    frontEnd.controlType[player] = (u_short)gPadinfo.buf[player * 4].ID;
  }
  GameSetup_gData.controllerData.controllerConfig[player] = config;
  h = Input_gHandler;
  h[0x4f - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0][type],player);
  h[0x50 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][1][type],player);
  h[0x51 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][2][type],player);
  h[0x52 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][3][type],player);
  h[player + 0xae] = InGame_GetPSXPadValue(mappings[config][8][type],player);
  h[0x75 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][7][type],player);
  h[0x65 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][7][type],player);
  h[0x53 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][4][type],player);
  if ((Cars_gHumanRaceCarList[player]->carFlags & 0x200U) == 0) {
    h[0x7d - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0][type],0);
    h[0x7e - hoff[player]] = InGame_GetPSXPadValue(mappings[config][1][type],0);
    v = mappings[config][10][type];
    if (type == 1) {
      v = v | 6;
    }
    h[0x82 - hoff[player]] = InGame_GetPSXPadValue(v,player);
  }
  else {
    v = mappings[config][10][type];
    if (type == 1) {
      v = v | 6;
    }
    h[0x81 - hoff[player]] = InGame_GetPSXPadValue(v,player);
  }
  if (GameSetup_gData.Time == 0) {
    h[0x73 - hoff[player]] = InGame_GetPSXPadValue(0,player);
    v = mappings[config][9][type];
    if (type == 1) {
      v = v | 6;
    }
  }
  else {
    h[0x73 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][9][type],player);
    v = (type == 1) ? 6 : 0;
  }
  h[0x54 - hoff[player]] = InGame_GetPSXPadValue(v,player);
  h[0x66 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][5][type],player);
  h[0x67 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][6][type],player);
  h[0x68 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0xc][type],player);
  h[0x4d - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0xb][type],player);
  return;
}

/* ---- InGame_GetPSXPadValue__Fii  [PSXCONTROLLER.CPP:197-332] SLD-VERIFIED ----
 * w38-a9: rewritten as the NESTED SWITCH the oracle proves.  The oracle's
 * dispatch on `type` is gcc-2.8 `balance_case_nodes` output for exactly THREE
 * case nodes: root 0x53 (`beq`), bound test `slti $v0,$v1,0x54`, left child
 * 0x23, right child 0x73 -- a signature only a `switch` produces (an if-chain
 * has no reason to emit the `< 0x54` bound test).  Likewise the two inner
 * dispatches on `value`: 8 nodes (root 0x400000, signed `slt`, so 0x80000000
 * sorts FIRST as INT_MIN) and 5 nodes (root 0x8000, 2-node leaves stay
 * linear).  Case BODIES emit in SOURCE order, so the case order below is read
 * straight off the oracle's block VAs (0x800000, 0x200000, 0x100000, 0x400000,
 * 0x80000000, 0x20000000, 0x10000000, 0x40000000 / 0x800000, 0x200000, 0x4000,
 * 0x8000, 0x400); the shared tails (.L800DCC68 / .L800DCB9C / .L800DCBAC /
 * .L800DCBD8 / .L800DCBE8 / .L800DCCEC / .L800DCCF4) are gcc CROSS-JUMPING the
 * inline per-case expressions -- do NOT hand-funnel them.
 * SYM locals = exactly {c $s0, newControl $v0, type $v1} -> `type` is an INT
 * (oracle `slti ...,0x54` is SIGNED and there is no `andi 0xff` re-mask; a
 * u_char local emitted both). */
int InGame_GetPSXPadValue(int value,int player)

{
  int newControl;
  int c;
  int type;

  PAD_update();
  if (gPadinfo.buf[player * 4].nopad == '\0') {
    type = gPadinfo.buf[player * 4].ID;
  }
  else {
    type = 0;
  }
  switch (type) {
  case 0x53:
  case 0x73:
    switch (value) {
    case 0x800000:
      newControl = player << 0x1e |
                   (0x80 - GameSetup_gData.controllerData.J1MIN[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.J1MAX[player]) * 0x100 | 1;
      return newControl;
    case 0x200000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.J1MAX[player] + 0x80) * 0x100 | 1;
      return newControl;
    case 0x100000:
      newControl = player << 0x1e |
                   ((0x80 - GameSetup_gData.controllerData.J1MIN[player]) * 0x10000 | 0x1000000) |
                   (0x80 - GameSetup_gData.controllerData.J1MAX[player]) * 0x100 | 1;
      return newControl;
    case 0x400000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000 | 0x1000000) |
                   (GameSetup_gData.controllerData.J1MAX[player] + 0x80) * 0x100 | 1;
      return newControl;
    case -0x80000000:
      newControl = player << 0x1e |
                   ((0x80 - GameSetup_gData.controllerData.J2MIN[player]) * 0x10000 | 0x2000000) |
                   (0x80 - GameSetup_gData.controllerData.J2MAX[player]) * 0x100 | 1;
      return newControl;
    case 0x20000000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J2MIN[player] + 0x80) * 0x10000 | 0x2000000) |
                   (GameSetup_gData.controllerData.J2MAX[player] + 0x80) * 0x100 | 1;
      return newControl;
    case 0x10000000:
      newControl = player << 0x1e |
                   ((0x80 - GameSetup_gData.controllerData.J2MIN[player]) * 0x10000 | 0x3000000) |
                   (0x80 - GameSetup_gData.controllerData.J2MAX[player]) * 0x100 | 1;
      return newControl;
    case 0x40000000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J2MIN[player] + 0x80) * 0x10000 | 0x3000000) |
                   (GameSetup_gData.controllerData.J2MAX[player] + 0x80) * 0x100 | 1;
      return newControl;
    }
    break;
  case 0x23:
    switch (value) {
    case 0x800000:
      newControl = player << 0x1e |
                   (0x80 - GameSetup_gData.controllerData.deadSpot[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.steeringRange[player]) * 0x100 | 1;
      return newControl;
    case 0x200000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.deadSpot[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.steeringRange[player] + 0x80) * 0x100 | 1;
      return newControl;
    case 0x4000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.ImaxRange[player] * 0x100 | 0x1000000) | 1;
      return newControl;
    case 0x8000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.IImaxRange[player] * 0x100 | 0x2000000) | 1;
      return newControl;
    case 0x400:
      newControl = player << 0x1e | 0x30aff01;
      return newControl;
    }
    break;
  }
  newControl = player << 0x1a | value << 8 | 2;
  return newControl;
}

/* ---- InGame_GetDevice__Fi  [PSXCONTROLLER.CPP:338-339] SLD-VERIFIED ---- */
int InGame_GetDevice(int control)

{
  return control & 0xff;
}

/* ---- InGame_SetRamp__Fv  [PSXCONTROLLER.CPP:349-365] SLD-VERIFIED ---- */
void InGame_SetRamp(void)

{
  short i;   /* SYM: REG $s3, type SHORT -- an int counter cost 8 insns */
  int *h;
  int ctrl;

  if (Replay_ReplayMode < 2) {
    for (i = 0; i < Cars_gNumHumanRaceCars; i = i + 1) {
      ctrl = *(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288);
      *(int *)(ctrl + 0x1c) = 1;
      *(int *)(ctrl + 0x20) = 1;
      *(int *)(ctrl + 0x18) = 1;
      h = hoff + i;
      if (InGame_GetDevice(Input_gHandler[0x4f - *h]) == 1) {
        *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x18) = 0;
      }
      if (InGame_GetDevice(Input_gHandler[0x51 - *h]) == 1) {
        *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x1c) = 0;
      }
      if (InGame_GetDevice(Input_gHandler[0x52 - *h]) == 1) {
        *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x20) = 0;
      }
    }
  }
  return;
}

/* end of psxcontroller.cpp */
