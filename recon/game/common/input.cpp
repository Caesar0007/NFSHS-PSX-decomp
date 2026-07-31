/* game/common/input.cpp -- RECONSTRUCTED (NFS4 PSX controller input layer; C++ TU)
 *   8 free fns: Input_StartUp/WingCommandMode/Update/Store/Fetch/Gear/Interface/MainExitKey.
 *   Full SYM-locals applied. Device fn-ptr dispatch via Device_gDeviceList[].devicefunc.
 */
#include "../../nfs4_types.h"
#include "input_externs.h"

/* ---- input.obj OWNED globals (EXT; SYM names already resolved by Ghidra; Globals.jsonl) ---- */
int             Input_gHandler[184];          /* 0x8013... */
u_long          Input_gDBFlags[8];
u_long          Input_gInterfaceResults[32];
int             Input_gPressTime[2][17];
int             Input_gTime;
Input_tResults  Input_gResults[2];
Input_tResults  Input_gSim;                   /* 0x8013d22c; .flags @+3 = Ghidra bGp00000ce3 */
int             Input_gLookBehind[2];
int             Input_gMode[2];
extern Input_tResults D_8013D228[];

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
int * Input_StartUp(void);
int Input_WingCommandMode(int player);
void Input_Update(void);
void Input_Store(void);
void Input_Fetch(int humanIndex);
char Input_Gear(char currentGear,int numGears);
int Input_Interface(u_long key,int debounce);
u_int Input_MainExitKey(void);


/* ---- Input_StartUp__Fv  [INPUT.CPP:55-77] SLD-VERIFIED ---- */
int * Input_StartUp(void)

{
  int * h;
  int i;

  Device_StartUp();
  h = Input_gHandler;
  i = 0xb7;
  do {
    *h = 0;
    i = i + -1;
    h = h + 1;
  } while (-1 < i);
  for (i = 0; i < 2; i = i + 1) {
    int j;
    Input_gDBFlags[i] = 0;
    Input_gMode[i] = 0;
    for (j = 0; j < 0x11; j = j + 1) {
      Input_gPressTime[i][j] = 0;
    }
  }
  i = 0x1f;
  h = (int *)Input_gInterfaceResults;
  h = h + 0x1f;
  do {
    *h = 0;
    i = i + -1;
    h = h + -1;
  } while (-1 < i);
  return Input_gHandler;
}

/* ---- Input_WingCommandMode__Fi  [INPUT.CPP:84-93] SLD-VERIFIED ---- */
int Input_WingCommandMode(int player)

{
  int * h;
  int mode;

  h = Input_gHandler + 0x2d;
  if (player != 0) {
    h = h + 0x4c;
  }
  if (*h != 0) {
    mode = player & 1;
    goto checkMode;
  }
  if (h[1] != 0) {
    mode = player & 1;
    goto checkMode;
  }
  if (h[2] == 0) {
    goto falseResult;
  }
  mode = player & 1;
checkMode:
  if (Input_gMode[mode] == 1) {
    goto trueResult;
  }
falseResult:
  return 0;

trueResult:
  return 1;
}

/* ---- Input_Update__Fv  [INPUT.CPP:104-430] SLD-VERIFIED ---- */
void Input_Update(void)

{
  int *h;
  Input_tResults *r;
  u_long acc;
  u_long menukeys;
  int i;
  int j;
  int k;
  int left;
  int right;
  char iactive[32];
  int modeOffset;

  Device_Update();

  {
    char *activePtr;

    i = 31;
    activePtr = &iactive[31];
    do {
      *activePtr = 1;
      i--;
      activePtr--;
    } while (i >= 0);
  }

  h = Input_gHandler;
  r = Input_gResults;
  menukeys = 0;
  modeOffset = 0;

  for (i = 0; i < 2; i++) {
    int mode;

    mode = 0;
    for (j = 0; j < 2; j++) {
      if ((*h != 0) &&
          ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) >= 65)) {
        mode = j + 1;
      }
      h++;
    }
    *(int *)((char *)Input_gMode + modeOffset) = mode;

    if (mode == 0) {
      char active[17];

      left = (*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8);
      h++;
      right = (*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8);
      h++;
      r->steering = (char)((right - left) / 2);
      r->gas = (*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8);
      h++;
      r->brake = (*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8);
      h++;

      for (j = 0; j < 2; j++) {
        if ((*h != 0) &&
            ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) >= 65)) {
          r->flags |= (1 << j);
        } else {
          r->flags &= ~(1 << j);
        }
        h++;
      }

      acc = 0;
      r->flags &= 7;
      {
        char *activePtr;

        activePtr = &active[16];
        for (k = 16; k >= 0; k--) {
          *activePtr = 1;
          activePtr--;
        }
      }

      for (j = 0; j < 17; j++) {
        if (*h != 0) {
          if ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) >= 65) {
            Input_gPressTime[i][j]++;
            if (Input_gPressTime[i][j] >= 6) {
              if ((Input_gDBFlags[i] & (1 << j)) == 0) {
                acc = j + 1;
                Input_gDBFlags[i] |= (1 << j);
              }
            }
            for (k = 0; k < 17; k++) {
              if (h[k - (j - 17)] == *h) {
                active[k] = 0;
                Input_gPressTime[i][k] = Input_gPressTime[i][j];
              }
            }
          } else {
            Input_gDBFlags[i] &= ~(1 << j);
            Input_gPressTime[i][j] = 0;
          }
        }
        h++;
      }

      for (j = 0; j < 17; j++) {
        if (*h != 0) {
          if ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) < 65) {
            if ((u_int)(Input_gPressTime[i][j] - 1) < 5) {
              if ((Input_gDBFlags[i] & (1 << j)) == 0) {
                acc = j + 1;
                Input_gDBFlags[i] |= (1 << j);
              }
              Input_gPressTime[i][j] = 0;
            } else {
              Input_gDBFlags[i] &= ~(1 << j);
            }
          } else if ((active[j] != 0) && ((Input_gDBFlags[i] & (1 << j)) == 0)) {
            acc = j + 1;
            Input_gDBFlags[i] |= (1 << j);
          }
        }
        h++;
      }

      {
        int m;
        int k;

        for (m = 0; m < 2; m++) {
          for (k = 0; k < 17; k++) {
            if (*h != 0) {
              if ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) >= 65) {
                Input_gDBFlags[i] |= (1 << k);
              } else {
                Input_gDBFlags[i] &= ~(1 << k);
              }
            }
            h++;
          }
        }
      }
    } else {
      char active[40];

      {
        char *activePtr;

        activePtr = &active[39];
        for (j = 39; j >= 0; j--) {
          *activePtr = 1;
          activePtr--;
        }
      }

      for (j = 0; j < 40; j++) {
        for (k = 0; k < 17; k++) {
          if (h[j] == h[mode * 17 + k + 23]) {
            active[j] = 0;
          }
        }
      }

      for (j = 0; j < 32; j++) {
        for (k = 0; k < 17; k++) {
          if (Input_gHandler[j + 152] == h[mode * 17 + k + 23]) {
            iactive[j] = 0;
          }
        }
      }

      left = (*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8);
      h++;
      right = (*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8);
      h++;
      if ((active[0] != 0) && (active[1] != 0)) {
        r->steering = (char)((right - left) / 2);
      }
      if (active[2] != 0) {
        r->gas = (*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8);
      }
      h++;
      if (active[3] != 0) {
        r->brake = (*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8);
      }
      h++;

      for (j = 0; j < 2; j++) {
        if (active[j + 4] != 0) {
          if ((*h != 0) &&
              ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) >= 65)) {
            r->flags |= (1 << j);
          } else {
            r->flags &= ~(1 << j);
          }
        }
        h++;
      }

      {
        char hactive[17];

        acc = 0;
        r->flags &= 7;
        {
          char *activePtr;

          activePtr = &hactive[16];
          for (k = 16; k >= 0; k--) {
            *activePtr = 1;
            activePtr--;
          }
        }

        for (j = 0; j < 17; j++) {
          if (*h != 0) {
            if ((active[j + 6] != 0) &&
                ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) >= 65)) {
              Input_gPressTime[i][j]++;
              if (Input_gPressTime[i][j] >= 6) {
                if ((Input_gDBFlags[i] & (1 << j)) == 0) {
                  acc = j + 1;
                  Input_gDBFlags[i] |= (1 << j);
                }
              }
              for (k = 0; k < 17; k++) {
                if (h[k - (j - 17)] == *h) {
                  hactive[k] = 0;
                  Input_gPressTime[i][k] = Input_gPressTime[i][j];
                }
              }
            } else {
              Input_gDBFlags[i] &= ~(1 << j);
              Input_gPressTime[i][j] = 0;
            }
          }
          h++;
        }

        for (j = 0; j < 17; j++) {
          if (*h != 0) {
            if (active[j + 23] != 0) {
              if ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) >= 65) {
                if (((Input_gDBFlags[i] & (1 << j)) == 0) && (hactive[j] != 0)) {
                  acc = j + 1;
                  Input_gDBFlags[i] |= (1 << j);
                }
                h++;
                continue;
              }
              if (Input_gPressTime[i][j] > 0) {
                if (Input_gPressTime[i][j] < 6) {
                  if ((Input_gDBFlags[i] & (1 << j)) == 0) {
                    acc = j + 1;
                    Input_gDBFlags[i] |= (1 << j);
                  }
                  Input_gPressTime[i][j] = 0;
                  h++;
                  continue;
                }
              }
            }
            Input_gDBFlags[i] &= ~(1 << j);
          }
          h++;
        }
      }

      h += (mode - 1) * 17;
      for (j = 0; j < 17; j++) {
        if (*h != 0) {
          if ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) < 65) {
            Input_gDBFlags[i] &= ~(1 << j);
          } else if ((Input_gDBFlags[i] & (1 << j)) == 0) {
            acc = j + 1;
            Input_gDBFlags[i] |= (1 << j);
          }
        }
        h++;
      }
      h += (2 - mode) * 17;
    }

    *(volatile u_char *)&r->flags |= (acc << 3);
    switch (r->flags >> 3) {
      case 15:
        r->flags &= 7;
        menukeys |= 0x200000;
        break;
      case 16:
        r->flags &= 7;
        menukeys |= (1 << (i + 26));
        break;
      case 17:
        r->flags &= 7;
        menukeys |= (1 << (i + 28));
        break;
    }

    r++;
    if (GameSetup_gData.numPlayerRaceCars == 1) {
      h += 76;
      modeOffset += 4;
      i++;
    }
    modeOffset += 4;
  }

  for (i = 0; i < 32; i++) {
    if ((iactive[i] != 0) && (*h != 0) &&
        ((*(int (*)(...))Device_gDeviceList[*h & 0xff].devicefunc)(*h >> 8) >= 65)) {
      menukeys |= (1 << i);
    }
    h++;
  }

  Input_gTime += 2;
  Input_gInterfaceResults[Input_gTime & 0x1f] = menukeys;
  Input_gInterfaceResults[(Input_gTime + 1) & 0x1f] = menukeys;
}

/* ---- Input_Store__Fv  [INPUT.CPP:436-450] SLD-VERIFIED ---- */
void Input_Store(void)

{
  if (gSimQueue_BlockSelf == 0) {
    if (1 < GameSetup_gData.numPlayerRaceCars) {
      if (SimQueue_Put(0,Input_gResults) == 0) {
        return;
      }
      SimQueue_Put(1,D_8013D228);
    }
    else if (GameSetup_gData.commMode == 0) {
      SimQueue_Put(GameSetup_gData.localCar,Input_gResults);
    }
  }
  return;
}

/* ---- Input_Fetch__Fi  [INPUT.CPP:456-457] SLD-VERIFIED ---- */
void Input_Fetch(int humanIndex)

{
  SimQueue_GetCurrentInput(humanIndex,&Input_gSim);
  return;
}

/* ---- Input_Gear__Fci  [INPUT.CPP:466-479] SLD-VERIFIED ---- */
char Input_Gear(char currentGear,int numGears)

{
  if (Input_gSim.flags >> 3 == 1) {
    if ((int)(u_int)currentGear < numGears + -1) {
      currentGear = currentGear + 1;
    }
    return currentGear;
  }
  if (Input_gSim.flags >> 3 == 2) {
    if (currentGear != 0) {
      currentGear = currentGear - 1;
    }
    return currentGear;
  }
  return currentGear;
}

/* ---- Input_Interface__FUli  [INPUT.CPP:488-499] SLD-VERIFIED ---- */
int Input_Interface(u_long key,int debounce)

{
  if (debounce == 0) {
    goto no_debounce;
  }
  if ((Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1 << key &
       ~Input_gInterfaceResults[simGlobal.time32Hz - 1U & 0x1f]) == 0) {
    goto return_zero;
  }
  return 1;

no_debounce:
  if ((Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1 << key) != 0) {
    return 1;
  }
return_zero:
  return 0;
}

/* ---- Input_MainExitKey__Fv  [INPUT.CPP:543-544] SLD-VERIFIED ---- */
u_int Input_MainExitKey(void)

{
  return Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1;
}

/* end of input.cpp */
