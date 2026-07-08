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
  int j;
  int *piVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  u_long *puVar5;
  int iVar6;
  
  Device_StartUp();
  piVar1 = Input_gHandler;
  iVar4 = 0xb7;
  do {
    *piVar1 = 0;
    iVar4 = iVar4 + -1;
    piVar1 = piVar1 + 1;
  } while (-1 < iVar4);
  iVar6 = 0;
  piVar1 = Input_gMode;
  puVar5 = Input_gDBFlags;
  for (iVar4 = 0; iVar3 = 0, iVar4 < 2; iVar4 = iVar4 + 1) {
    *puVar5 = 0;
    *piVar1 = 0;
    iVar2 = iVar6;
    do {
      *(u_int *)((int)Input_gPressTime[0] + iVar2) = 0;
      iVar3 = iVar3 + 1;
      iVar2 = iVar2 + 4;
    } while (iVar3 < 0x11);
    iVar6 = iVar6 + 0x44;
    piVar1 = piVar1 + 1;
    puVar5 = puVar5 + 1;
  }
  iVar4 = 0x1f;
  puVar5 = Input_gInterfaceResults + 0x1f;
  do {
    *puVar5 = 0;
    iVar4 = iVar4 + -1;
    puVar5 = puVar5 + -1;
  } while (-1 < iVar4);
  return Input_gHandler;
}

/* ---- Input_WingCommandMode__Fi  [INPUT.CPP:84-93] SLD-VERIFIED ---- */
int Input_WingCommandMode(int player)

{
  int * h;
  int *piVar1;
  
  piVar1 = Input_gHandler + 0x2d;
  if (player != 0) {
    piVar1 = Input_gHandler + 0x79;
  }
  if ((((*piVar1 != 0) || (piVar1[1] != 0)) || (piVar1[2] != 0)) && (Input_gMode[player & 1] == 1))
  {
    return 1;
  }
  return 0;
}

/* ---- Input_Update__Fv  [INPUT.CPP:104-430] SLD-VERIFIED ---- */
void Input_Update(void)

{
  int right;
  int active;
  u_char bVar1;
  u_long *puVar2;
  u_long *puVar3;
  u_char bVar4;
  char *pcVar5;
  int iVar6;
  int iVar7;
  int *piVar8;
  int k;
  u_int uVar9;
  u_int uVar10;
  int iVar11;
  int iVar12;
  u_int *puVar13;
  int j;
  int iVar14;
  int left;
  int *h;
  int *piVar15;
  u_int *puVar16;
  int m;
  u_char *puVar17;
  u_long acc;
  int mode;
  int iVar18;
  int i;
  int iVar19;
  char iactive [32];
  char hactive [17];
  char acStack_70 [40];
  Input_tResults *r;
  u_long menukeys;
  char *pcStack_40;
  u_long *puStack_3c;
  int iStack_38;
  int iStack_34;
  int iStack_30;
  
  Device_Update();
  iVar19 = 0x1f;
  pcVar5 = iactive + 0x1f;
  do {
    *pcVar5 = '\x01';
    iVar19 = iVar19 + -1;
    pcVar5 = pcVar5 + -1;
  } while (-1 < iVar19);
  piVar15 = Input_gHandler;
  iVar19 = 0;
  r = Input_gResults;
  puVar17 = &Input_gResults[0].flags;
  menukeys = 0;
  pcStack_40 = hactive;
  puStack_3c = Input_gDBFlags;
  iStack_38 = 0;
  iStack_34 = 0;
  do {
    iVar18 = 0;
    if (1 < iVar19) {
      uVar9 = 0;
      do {
        if (iactive[uVar9] != '\0') {
          uVar10 = *piVar15;
          if (uVar10 != 0) {
            iVar19 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8);
            if (0x40 < iVar19) {
              menukeys = menukeys | 1 << (uVar9);
            }
          }
        }
        uVar9 = uVar9 + 1;
        piVar15 = piVar15 + 1;
      } while ((int)uVar9 < 0x20);
      uVar10 = Input_gTime + 2;
      uVar9 = Input_gTime + 3;
      Input_gTime = uVar10;
      Input_gInterfaceResults[uVar10 & 0x1f] = menukeys;
      Input_gInterfaceResults[uVar9 & 0x1f] = menukeys;
      return;
    }
    iVar14 = 0;
    do {
      puVar16 = (u_int *)piVar15;
      uVar9 = *puVar16;
      if ((uVar9 != 0) &&
         (iVar6 = (*(int (*)(...))Device_gDeviceList[uVar9 & 0xff].devicefunc)((int)uVar9 >> 8),
         0x40 < iVar6)) {
        iVar18 = iVar14 + 1;
      }
      iVar14 = iVar14 + 1;
      piVar15 = (int *)(puVar16 + 1);
    } while (iVar14 < 2);
    *(int *)((int)Input_gMode + iStack_38) = iVar18;
    if (iVar18 == 0) {
      uVar9 = 0;
      iVar18 = (*(int (*)(...))Device_gDeviceList[*piVar15 & 0xff].devicefunc)(*piVar15 >> 8);
      iVar14 = (*(int (*)(...))Device_gDeviceList[puVar16[2] & 0xff].devicefunc)((int)puVar16[2] >> 8);
      r->steering = (char)((iVar14 - iVar18) / 2);
      bVar4 = (*(int (*)(...))Device_gDeviceList[puVar16[3] & 0xff].devicefunc)((int)puVar16[3] >> 8);
      puVar17[-2] = bVar4;
      piVar15 = (int *)(puVar16 + 5);
      bVar4 = (*(int (*)(...))Device_gDeviceList[puVar16[4] & 0xff].devicefunc)((int)puVar16[4] >> 8);
      puVar17[-1] = bVar4;
      do {
        uVar10 = *piVar15;
        if ((uVar10 == 0) ||
           (iVar18 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8),
           iVar18 < 0x41)) {
          *puVar17 = *puVar17 & ~(u_char)(1 << (uVar9));
        }
        else {
          *puVar17 = *puVar17 | (u_char)(1 << (uVar9));
        }
        iVar18 = iStack_34;
        puVar2 = puStack_3c;
        uVar9 = uVar9 + 1;
        piVar15 = piVar15 + 1;
      } while ((int)uVar9 < 2);
      iVar6 = 0;
      iVar14 = 0x10;
      pcVar5 = pcStack_40 + 0x10;
      *puVar17 = *puVar17 & 7;
      do {
        *pcVar5 = '\x01';
        iVar14 = iVar14 + -1;
        pcVar5 = pcVar5 + -1;
      } while (-1 < iVar14);
      iVar14 = iStack_34;
      for (uVar9 = 0; puVar3 = puStack_3c, (int)uVar9 < 0x11; uVar9 = uVar9 + 1) {
        uVar10 = *piVar15;
        if (uVar10 != 0) {
          iVar7 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8);
          if (iVar7 < 0x41) {
            *puVar2 = *puVar2 & ~(1 << (uVar9));
            *(u_int *)((int)Input_gPressTime[0] + iVar14) = 0;
          }
          else {
            piVar8 = (int *)((int)Input_gPressTime[0] + iVar14);
            iVar7 = *piVar8 + 1;
            *piVar8 = iVar7;
            if ((5 < iVar7) && (uVar10 = 1 << (uVar9), (*puVar2 & uVar10) == 0)) {
              iVar6 = uVar9 + 1;
              *puVar2 = *puVar2 | uVar10;
            }
            iVar11 = 0;
            iVar7 = iVar18;
            do {
              if (piVar15[iVar11 - (uVar9 - 0x11)] == *piVar15) {
                pcStack_40[iVar11] = '\0';
                *(u_int *)((int)Input_gPressTime[0] + iVar7) =
                     *(u_int *)((int)Input_gPressTime[0] + iVar14);
              }
              iVar11 = iVar11 + 1;
              iVar7 = iVar7 + 4;
            } while (iVar11 < 0x11);
          }
        }
        piVar15 = piVar15 + 1;
        iVar14 = iVar14 + 4;
      }
      uVar9 = 0;
      do {
        uVar10 = *piVar15;
        if (uVar10 != 0) {
          iVar18 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8);
          if (iVar18 < 0x41) {
            piVar8 = (int *)((int)Input_gPressTime[0] + uVar9 * 4 + iStack_34);
            uVar10 = 1 << (uVar9);
            if (*piVar8 - 1U < 5) {
              if ((*puVar3 & uVar10) == 0) {
                iVar6 = uVar9 + 1;
                *puVar3 = *puVar3 | uVar10;
              }
              *piVar8 = 0;
            }
            else {
              *puVar3 = *puVar3 & ~(1 << (uVar9));
            }
          }
          else {
            uVar10 = 1 << (uVar9);
            if ((pcStack_40[uVar9] != '\0') && ((*puVar3 & uVar10) == 0)) {
              iVar6 = uVar9 + 1;
              *puVar3 = *puVar3 | uVar10;
            }
          }
        }
        puVar2 = puStack_3c;
        uVar9 = uVar9 + 1;
        piVar15 = piVar15 + 1;
      } while ((int)uVar9 < 0x11);
      iVar18 = 0;
      uVar9 = 0;
      while( true ) {
        do {
          uVar10 = *piVar15;
          if (uVar10 != 0) {
            iVar14 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8);
            uVar10 = 1 << (uVar9);
            if (iVar14 < 0x41) {
              uVar10 = *puVar2 & ~uVar10;
            }
            else {
              uVar10 = *puVar2 | uVar10;
            }
            *puVar2 = uVar10;
          }
          uVar9 = uVar9 + 1;
          piVar15 = piVar15 + 1;
        } while ((int)uVar9 < 0x11);
        iVar18 = iVar18 + 1;
        if (1 < iVar18) break;
        uVar9 = 0;
      }
    }
    else {
      iVar14 = 0x27;
      pcVar5 = acStack_70 + 0x27;
      do {
        *pcVar5 = '\x01';
        iVar14 = iVar14 + -1;
        pcVar5 = pcVar5 + -1;
      } while (-1 < iVar14);
      iVar14 = 0;
      puVar13 = (u_int *)piVar15;
      do {
        iVar7 = 0;
        iVar6 = iVar18 * 0x11;
        do {
          if (*puVar13 == piVar15[iVar6 + 0x17]) {
            acStack_70[iVar14] = '\0';
          }
          iVar7 = iVar7 + 1;
          iVar6 = iVar18 * 0x11 + iVar7;
        } while (iVar7 < 0x11);
        iVar14 = iVar14 + 1;
        puVar13 = puVar13 + 1;
      } while (iVar14 < 0x28);
      iVar6 = 0;
      iVar14 = 0x260;
      do {
        iVar11 = 0;
        iVar7 = iVar18 * 0x11;
        do {
          if (*(u_int *)((int)Input_gHandler + iVar14) == piVar15[iVar7 + 0x17]) {
            iactive[iVar6] = '\0';
          }
          iVar11 = iVar11 + 1;
          iVar7 = iVar18 * 0x11 + iVar11;
        } while (iVar11 < 0x11);
        iVar6 = iVar6 + 1;
        iVar14 = iVar14 + 4;
      } while (iVar6 < 0x20);
      iVar14 = (*(int (*)(...))Device_gDeviceList[*piVar15 & 0xff].devicefunc)(*piVar15 >> 8);
      iVar6 = (*(int (*)(...))Device_gDeviceList[puVar16[2] & 0xff].devicefunc)((int)puVar16[2] >> 8);
      if ((acStack_70[0] != '\0') && (acStack_70[1] != '\0')) {
        r->steering = (char)((iVar6 - iVar14) / 2);
      }
      if (acStack_70[2] != '\0') {
        bVar4 = (*(int (*)(...))Device_gDeviceList[puVar16[3] & 0xff].devicefunc)((int)puVar16[3] >> 8);
        puVar17[-2] = bVar4;
      }
      if (acStack_70[3] != '\0') {
        bVar4 = (*(int (*)(...))Device_gDeviceList[puVar16[4] & 0xff].devicefunc)((int)puVar16[4] >> 8);
        puVar17[-1] = bVar4;
      }
      puVar16 = puVar16 + 5;
      uVar9 = 0;
      do {
        if (acStack_70[uVar9 + 4] != '\0') {
          uVar10 = *puVar16;
          if ((uVar10 == 0) ||
             (iVar14 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8),
             iVar14 < 0x41)) {
            *puVar17 = *puVar17 & ~(u_char)(1 << (uVar9));
          }
          else {
            *puVar17 = *puVar17 | (u_char)(1 << (uVar9));
          }
        }
        puVar2 = puStack_3c;
        uVar9 = uVar9 + 1;
        puVar16 = puVar16 + 1;
      } while ((int)uVar9 < 2);
      iVar6 = 0;
      iVar14 = 0x10;
      pcVar5 = pcStack_40 + 0x10;
      *puVar17 = *puVar17 & 7;
      do {
        *pcVar5 = '\x01';
        iVar14 = iVar14 + -1;
        pcVar5 = pcVar5 + -1;
      } while (-1 < iVar14);
      iVar14 = iStack_34;
      iVar7 = iStack_34;
      for (uVar9 = 0; puVar3 = puStack_3c, (int)uVar9 < 0x11; uVar9 = uVar9 + 1) {
        uVar10 = *puVar16;
        if (uVar10 != 0) {
          if ((acStack_70[uVar9 + 6] == '\0') ||
             (iStack_30 = iVar14,
             iVar11 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8),
             iVar14 = iStack_30, iVar11 < 0x41)) {
            *puVar2 = *puVar2 & ~(1 << (uVar9));
            *(u_int *)((int)Input_gPressTime[0] + iVar7) = 0;
          }
          else {
            piVar15 = (int *)((int)Input_gPressTime[0] + iVar7);
            iVar11 = *piVar15 + 1;
            *piVar15 = iVar11;
            if ((5 < iVar11) && (uVar10 = 1 << (uVar9), (*puVar2 & uVar10) == 0)) {
              iVar6 = uVar9 + 1;
              *puVar2 = *puVar2 | uVar10;
            }
            iVar12 = 0;
            iVar11 = iStack_30;
            do {
              if (puVar16[iVar12 - (uVar9 - 0x11)] == *puVar16) {
                pcStack_40[iVar12] = '\0';
                *(u_int *)((int)Input_gPressTime[0] + iVar11) =
                     *(u_int *)((int)Input_gPressTime[0] + iVar7);
              }
              iVar12 = iVar12 + 1;
              iVar11 = iVar11 + 4;
            } while (iVar12 < 0x11);
          }
        }
        puVar16 = puVar16 + 1;
        iVar7 = iVar7 + 4;
      }
      uVar9 = 0;
      do {
        uVar10 = *puVar16;
        if (uVar10 != 0) {
          if (acStack_70[uVar9 + 0x17] != '\0') {
            iVar14 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8);
            uVar10 = 1 << (uVar9);
            if (0x40 < iVar14) {
              if (((*puVar3 & uVar10) == 0) && (pcStack_40[uVar9] != '\0')) {
                iVar6 = uVar9 + 1;
                *puVar3 = *puVar3 | uVar10;
              }
              goto InputUpd_bitLoopNext;
            }
            if (acStack_70[uVar9 + 0x17] != '\0') {
              piVar15 = (int *)((int)Input_gPressTime[0] + uVar9 * 4 + iStack_34);
              iVar14 = *piVar15;
              if ((0 < iVar14) && (uVar10 = 1 << (uVar9), iVar14 < 6)) {
                if ((*puVar3 & uVar10) == 0) {
                  iVar6 = uVar9 + 1;
                  *puVar3 = *puVar3 | uVar10;
                }
                *piVar15 = 0;
                goto InputUpd_bitLoopNext;
              }
            }
          }
          *puVar3 = *puVar3 & ~(1 << (uVar9));
        }
InputUpd_bitLoopNext:
        puVar2 = puStack_3c;
        uVar9 = uVar9 + 1;
        puVar16 = puVar16 + 1;
      } while ((int)uVar9 < 0x11);
      puVar16 = puVar16 + (iVar18 + -1) * 0x11;
      uVar9 = 0;
      do {
        uVar10 = *puVar16;
        if (uVar10 != 0) {
          iVar14 = (*(int (*)(...))Device_gDeviceList[uVar10 & 0xff].devicefunc)((int)uVar10 >> 8);
          if (iVar14 < 0x41) {
            *puVar2 = *puVar2 & ~(1 << (uVar9));
          }
          else {
            uVar10 = 1 << (uVar9);
            if ((*puVar2 & uVar10) == 0) {
              iVar6 = uVar9 + 1;
              *puVar2 = *puVar2 | uVar10;
            }
          }
        }
        uVar9 = uVar9 + 1;
        puVar16 = puVar16 + 1;
      } while ((int)uVar9 < 0x11);
      piVar15 = (int *)(puVar16 + (2 - iVar18) * 0x11);
    }
    *puVar17 = *puVar17 | (u_char)(iVar6 << 3);
    bVar4 = *puVar17;
    bVar1 = bVar4 >> 3;
    if (bVar1 == 0x10) {
      *puVar17 = bVar4 & 7;
      uVar9 = iVar19 + 0x1a;
InputUpd_menukeysShift:
      uVar9 = 1 << (uVar9);
InputUpd_menukeysOr:
      menukeys = menukeys | uVar9;
    }
    else if (bVar1 < 0x11) {
      if (bVar1 == 0xf) {
        *puVar17 = bVar4 & 7;
        uVar9 = 0x200000;
        goto InputUpd_menukeysOr;
      }
    }
    else if (bVar1 == 0x11) {
      *puVar17 = bVar4 & 7;
      uVar9 = iVar19 + 0x1c;
      goto InputUpd_menukeysShift;
    }
    puVar17 = puVar17 + 4;
    r = r + 1;
    if (GameSetup_gData.numPlayerRaceCars == 1) {
      puStack_3c = puStack_3c + 1;
      piVar15 = piVar15 + 0x4c;
      iStack_38 = iStack_38 + 4;
      iVar19 = iVar19 + 1;
      iStack_34 = iStack_34 + 0x44;
    }
    puStack_3c = puStack_3c + 1;
    iStack_38 = iStack_38 + 4;
    iVar19 = iVar19 + 1;
    iStack_34 = iStack_34 + 0x44;
  } while( true );
}

/* ---- Input_Store__Fv  [INPUT.CPP:436-450] SLD-VERIFIED ---- */
void Input_Store(void)

{
  int iVar1;
  Input_tResults *val;
  
  if (gSimQueue_BlockSelf == 0) {
    if (GameSetup_gData.numPlayerRaceCars < 2) {
      if (GameSetup_gData.commMode != 0) {
        return;
      }
      val = Input_gResults;
      iVar1 = GameSetup_gData.localCar;
    }
    else {
      iVar1 = SimQueue_Put(0,Input_gResults);
      if (iVar1 == 0) {
        return;
      }
      val = Input_gResults + 1;
      iVar1 = 1;
    }
    SimQueue_Put(iVar1,val);
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
  }
  else {
    if (Input_gSim.flags >> 3 != 2) {
      return currentGear;
    }
    if (currentGear != 0) {
      currentGear = currentGear - 1;
    }
  }
  return currentGear;
}

/* ---- Input_Interface__FUli  [INPUT.CPP:488-499] SLD-VERIFIED ---- */
int Input_Interface(u_long key,int debounce)

{
  int iVar1;
  
  if (debounce == 0) {
    iVar1 = 1;
    if ((Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1 << (key)) == 0) {
      iVar1 = 0;
    }
  }
  else {
    iVar1 = 0;
    if ((Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1 << (key) &
        ~Input_gInterfaceResults[simGlobal.time32Hz - 1U & 0x1f]) != 0) {
      return 1;
    }
  }
  return iVar1;
}

/* ---- Input_MainExitKey__Fv  [INPUT.CPP:543-544] SLD-VERIFIED ---- */
u_int Input_MainExitKey(void)

{
  return Input_gInterfaceResults[simGlobal.time32Hz & 0x1f] & 1;
}

/* end of input.cpp */
