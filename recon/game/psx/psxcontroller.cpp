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
  u_char id;
  int type;
  int *map;
  int *h;
  u_int v;

  id = gPadinfo.buf[player * 4].ID;
  if (id == 0x23) {
    type = 0;
  }
  else if ((id == 0x53) || (id == 0x73)) {
    type = 1;
  }
  else {
    type = 2;
  }
  if (frontEnd.controlType[player] != (u_short)gPadinfo.buf[player * 4].ID) {
    frontEnd.controlType[player] = (u_short)gPadinfo.buf[player * 4].ID;
  }
  GameSetup_gData.controllerData.controllerConfig[player] = config;
  map = mappings[config][0] + type;
  h = hoff + player;
  Input_gHandler[0x4f - *h] = InGame_GetPSXPadValue(*map,player);
  Input_gHandler[0x50 - *h] = InGame_GetPSXPadValue(mappings[config][1][type],player);
  Input_gHandler[0x51 - *h] = InGame_GetPSXPadValue(mappings[config][2][type],player);
  Input_gHandler[0x52 - *h] = InGame_GetPSXPadValue(mappings[config][3][type],player);
  Input_gHandler[player + 0xae] = InGame_GetPSXPadValue(mappings[config][8][type],player);
  Input_gHandler[0x75 - *h] = InGame_GetPSXPadValue(mappings[config][7][type],player);
  Input_gHandler[0x65 - *h] = InGame_GetPSXPadValue(mappings[config][7][type],player);
  Input_gHandler[0x53 - *h] = InGame_GetPSXPadValue(mappings[config][4][type],player);
  if ((Cars_gHumanRaceCarList[player]->carFlags & 0x200U) == 0) {
    Input_gHandler[0x7d - *h] = InGame_GetPSXPadValue(*map,0);
    Input_gHandler[0x7e - *h] = InGame_GetPSXPadValue(mappings[config][1][type],0);
    v = mappings[config][10][type];
    if (type == 1) {
      v = v | 6;
    }
    Input_gHandler[0x82 - *h] = InGame_GetPSXPadValue(v,player);
  }
  else {
    v = mappings[config][10][type];
    if (type == 1) {
      v = v | 6;
    }
    Input_gHandler[0x81 - *h] = InGame_GetPSXPadValue(v,player);
  }
  if (GameSetup_gData.Time == 0) {
    Input_gHandler[0x73 - *h] = InGame_GetPSXPadValue(0,player);
    v = mappings[config][9][type];
    if (type == 1) {
      v = v | 6;
    }
  }
  else {
    Input_gHandler[0x73 - *h] = InGame_GetPSXPadValue(mappings[config][9][type],player);
    v = (type == 1) ? 6 : 0;
  }
  Input_gHandler[0x54 - *h] = InGame_GetPSXPadValue(v,player);
  Input_gHandler[0x66 - *h] = InGame_GetPSXPadValue(mappings[config][5][type],player);
  Input_gHandler[0x67 - *h] = InGame_GetPSXPadValue(mappings[config][6][type],player);
  Input_gHandler[0x68 - *h] = InGame_GetPSXPadValue(mappings[config][0xc][type],player);
  Input_gHandler[0x4d - *h] = InGame_GetPSXPadValue(mappings[config][0xb][type],player);
  return;
}

/* ---- InGame_GetPSXPadValue__Fii  [PSXCONTROLLER.CPP:197-332] SLD-VERIFIED ---- */
int InGame_GetPSXPadValue(int value,int player)

{
  int newControl;
  int c;
  u_char type;
  u_int pack;
  int hi;
  u_int pack2;
  
  PAD_update();
  if (gPadinfo.buf[player * 4].nopad == '\0') {
    type = gPadinfo.buf[player * 4].ID;
  }
  else {
    type = 0;
  }
  if (type != 0x53) {
    if (type < 0x54) {
      if (type == 0x23) {
        if (value == 0x8000) {
          c = GameSetup_gData.controllerData.IImaxRange[player];
          pack = 0x2000000;
        }
        else {
          if (0x8000 < value) {
            if (value != 0x200000) {
              if (value != 0x800000) goto cfLbl1;
              c = GameSetup_gData.controllerData.deadSpot[player];
              hi = GameSetup_gData.controllerData.steeringRange[player];
              goto InGamePad_returnJ1J2neg;
            }
            pack2 = player << 0x1e |
                    (GameSetup_gData.controllerData.deadSpot[player] + 0x80) * 0x10000;
            pack = (GameSetup_gData.controllerData.steeringRange[player] + 0x80) * 0x100;
            goto InGamePad_returnJ1Inverted;
          }
          if (value == 0x400) {
            newControl = player << 0x1e | 0x30aff01;
            return newControl;
          }
          if (value != 0x4000) goto cfLbl1;
          c = GameSetup_gData.controllerData.ImaxRange[player];
          pack = 0x1000000;
        }
        pack2 = player << 0x1e;
        pack = c << 8 | pack;
        goto InGamePad_returnJ1Inverted;
      }
      goto cfLbl1;
    }
    if (type != 0x73) goto cfLbl1;
  }
  if (value == 0x400000) {
    pack = (GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000 | 0x1000000;
    c = GameSetup_gData.controllerData.J1MAX[player];
InGamePad_returnJ1Pos:
    newControl = player << 0x1e | pack | (c + 0x80) * 0x100 | 1;
    return newControl;
  }
  if (value < 0x400001) {
    if (value == 0x100000) {
      pack = (0x80 - GameSetup_gData.controllerData.J1MIN[player]) * 0x10000 | 0x1000000;
      c = GameSetup_gData.controllerData.J1MAX[player];
      goto InGamePad_returnJ2;
    }
    if (0x100000 < value) {
      if (value == 0x200000) {
        pack2 = player << 0x1e | (GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000;
        pack = (GameSetup_gData.controllerData.J1MAX[player] + 0x80) * 0x100;
InGamePad_returnJ1Inverted:
        newControl = pack2 | pack | 1;
        return newControl;
      }
cfLbl1:   /* @0x800dc9f4  (-f-build goto label) */
      newControl = player << 0x1a | value << 8 | 2;
      return newControl;
    }
    if (value != -0x80000000) goto cfLbl1;
    c = GameSetup_gData.controllerData.J2MIN[player];
    pack = 0x2000000;
  }
  else {
    if (value != 0x10000000) {
      if (value < 0x10000001) {
        if (value == 0x800000) {
          c = GameSetup_gData.controllerData.J1MIN[player];
          hi = GameSetup_gData.controllerData.J1MAX[player];
InGamePad_returnJ1J2neg:
          newControl = player << 0x1e | (0x80 - c) * 0x10000 | (0x80 - hi) * 0x100 | 1;
          return newControl;
        }
        goto cfLbl1;
      }
      if (value == 0x20000000) {
        c = GameSetup_gData.controllerData.J2MIN[player];
        pack = 0x2000000;
      }
      else {
        if (value != 0x40000000) goto cfLbl1;
        c = GameSetup_gData.controllerData.J2MIN[player];
        pack = 0x3000000;
      }
      pack = (c + 0x80) * 0x10000 | pack;
      c = GameSetup_gData.controllerData.J2MAX[player];
      goto InGamePad_returnJ1Pos;
    }
    c = GameSetup_gData.controllerData.J2MIN[player];
    pack = 0x3000000;
  }
  pack = (0x80 - c) * 0x10000 | pack;
  c = GameSetup_gData.controllerData.J2MAX[player];
InGamePad_returnJ2:
  newControl = player << 0x1e | pack | (0x80 - c) * 0x100 | 1;
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
  int i;
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
