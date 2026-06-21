/* frontend/common/feinput.cpp -- RECONSTRUCTED (front-end controller input; C++ TU)
 *   4 free fns: FEInput_VerifyControllerValues (pad-id sanity), FEInput_GetNoDebounceKey
 *   (raw key read, incl negCon analog thresholds), FEInput_GetDebounceKey (edge+repeat),
 *   FEInput_GetKeyFromPlayer (PSX->FE key mapping). ns nfs4::FRONTEND::COMMON::FEInput.
 */
#include "feinput.h"

/* ---- FEInput.obj-OWNED data -- DEFINED here (self-contained; real NFS4.EXE bytes).
   nextTick/debounce are fn-static state (materialized in-fn); getKeyMappings is the PSX->FE
   key-map table (16 x tPSXToFEMapping). ---- */
tPSXToFEMapping getKeyMappings[16] = { {16, 512}, {128, 2048}, {32, 4096}, {64, 1024}, {1024, 32}, {256, 64}, {2048, 128}, {512, 256}, {1048576, 512}, {8388608, 2048}, {2097152, 4096}, {4194304, 1024}, {268435456, 512}, {-2147483648, 2048}, {536870912, 4096}, {1073741824, 1024} };   /* @0x8005173c */


/* ---- FEInput_VerifyControllerValues  [FEINPUT.CPP:28-38] SLD-VERIFIED ---- */

void FEInput_VerifyControllerValues(int controller)

{
  if ((gPadinfo.buf[controller * 4].nopad == '\0') &&
     (frontEnd.controlType[controller] != (u_short)gPadinfo.buf[controller * 4].ID)) {
    Front_ResetPSXController(controller,0);
  }
  return;
}



/* ---- FEInput_GetNoDebounceKey  [FEINPUT.CPP:44-142] SLD-VERIFIED ---- */

int FEInput_GetNoDebounceKey(int key,int controller)

{
  u_char uVar1;
  bool bVar2;
  u_int uVar3;
  char *analogs;
  
  PAD_update();
  if (gPadinfo.buf[controller * 4].nopad != '\0') {
    return 0;
  }
  FEInput_VerifyControllerValues(controller);
  uVar1 = gPadinfo.buf[controller * 4].ID;
  if ((uVar1 == 's') || (uVar1 == 'S')) {
    if (key == 0x400000) {
      bVar2 = gPadinfo.buf[controller * 4].data.negcon.buttonI < 0xc1;
      goto FEInpNoDeb_negconButtonII;
    }
    if (key < 0x400001) {
      if (key == 0x100000) {
        bVar2 = gPadinfo.buf[controller * 4].data.negcon.buttonI < 0x40;
FEInpNoDeb_negconButtonI:
        if (!bVar2) {
          return 0;
        }
        return 1;
      }
      if (key < 0x100001) {
        if (key == (int)0x80000000) {
          bVar2 = gPadinfo.buf[controller * 4].data.negcon.buttonII < 0x40;
          goto FEInpNoDeb_negconButtonI;
        }
      }
      else if (key == 0x200000) {
        bVar2 = gPadinfo.buf[controller * 4].data.negcon.twist < 0xc1;
        goto FEInpNoDeb_negconButtonII;
      }
    }
    else {
      if (key == 0x10000000) {
        bVar2 = gPadinfo.buf[controller * 4].data.negcon.leftshift < 0x40;
        goto FEInpNoDeb_negconButtonI;
      }
      if (key < 0x10000001) {
        if (key == 0x800000) {
          bVar2 = gPadinfo.buf[controller * 4].data.negcon.twist < 0x40;
          goto FEInpNoDeb_negconButtonI;
        }
      }
      else {
        if (key == 0x20000000) {
          bVar2 = gPadinfo.buf[controller * 4].data.negcon.buttonII < 0xc1;
FEInpNoDeb_negconButtonII:
          if (!bVar2) {
            return 1;
          }
          return 0;
        }
        if (key == 0x40000000) {
          bVar2 = gPadinfo.buf[controller * 4].data.negcon.leftshift < 0xc1;
          goto FEInpNoDeb_negconButtonII;
        }
      }
    }
    uVar3 = ~(u_int)gPadinfo.buf[controller * 4].data.standard.state;
  }
  else {
    if (uVar1 != '#') {
      uVar3 = PAD_state(controller << 2);
      if ((uVar3 & 0xffff & key) != 0) {
        return 1;
      }
      return 0;
    }
    if (key == 0x8000) {
      bVar2 = gPadinfo.buf[controller * 4].data.negcon.buttonII < 0x41;
      goto FEInpNoDeb_negconButtonII;
    }
    if (key < 0x8001) {
      if (key == 0x4000) {
        bVar2 = gPadinfo.buf[controller * 4].data.negcon.buttonI < 0x41;
        goto FEInpNoDeb_negconButtonII;
      }
    }
    else {
      if (key == 0x200000) {
        bVar2 = gPadinfo.buf[controller * 4].data.negcon.twist < 0xa1;
        goto FEInpNoDeb_negconButtonII;
      }
      if (key == 0x800000) {
        bVar2 = gPadinfo.buf[controller * 4].data.negcon.twist < 0x62;
        goto FEInpNoDeb_negconButtonI;
      }
    }
    uVar3 = PAD_state(controller << 2);
    uVar3 = uVar3 & 0xffff;
  }
  if ((uVar3 & key) != 0) {
    return 1;
  }
  return 0;
}



/* ---- FEInput_GetDebounceKey  [FEINPUT.CPP:146-179] SLD-VERIFIED ---- */

int FEInput_GetDebounceKey(int key,int controller)

{
  int iVar1;
  
  iVar1 = FEInput_GetNoDebounceKey(key,controller);
  if (iVar1 == 0) {
    iVar1 = 0;
    debounce[controller] = debounce[controller] & ~key;
  }
  else {
    if ((debounce[controller] & key) == 0) {
      iVar1 = 1;
      debounce[controller] = debounce[controller] | key;
      nextTick = 0;
    }
    else if ((((key == 0x10) || (key == 0x80)) || (key == 0x20)) || (iVar1 = 0, key == 0x40)) {
      if (nextTick == 0) {
        nextTick = ticks + FeTools_gScrollTicksOut + 10;
      }
      iVar1 = 0;
      if (nextTick <= ticks) {
        iVar1 = 1;
        nextTick = ticks + FeTools_gScrollTicksOut;
      }
    }
  }
  return iVar1;
}



/* ---- FEInput_GetKeyFromPlayer  [FEINPUT.CPP:214-319] SLD-VERIFIED ---- */
tInputKeyType
FEInput_GetKeyFromPlayer(tPlayer player,long debounce)

{
  bool bVar1;
  int iVar2;
  tInputKeyType tVar3;
  u_short i;
  u_short uVar4;
  
  uVar4 = 0;
  while( true ) {
    bVar1 = false;
    iVar2 = FEInput_GetDebounceKey(getKeyMappings[uVar4].PSXKey,player);
    if ((iVar2 != 0) ||
       (((debounce & getKeyMappings[uVar4].FEKey) == kInput_KeyType_NoKey &&
        (iVar2 = FEInput_GetNoDebounceKey(getKeyMappings[uVar4].PSXKey,player), iVar2 != 0))))
    {
      bVar1 = true;
    }
    if (bVar1) break;
    uVar4 = uVar4 + 1;
    if (0xf < uVar4) {
      iVar2 = FEInput_GetDebounceKey(0x4000,player);
      tVar3 = kInput_KeyType_Cross;
      if (iVar2 == 0) {
        iVar2 = FEInput_GetDebounceKey(0x1000,player);
        tVar3 = kInput_KeyType_Triangle;
        if (iVar2 == 0) {
          iVar2 = FEInput_GetDebounceKey(0x2000,player);
          tVar3 = kInput_KeyType_Circle;
          if (iVar2 == 0) {
            iVar2 = FEInput_GetDebounceKey(0x8000,player);
            if (iVar2 == 0) {
              iVar2 = FEInput_GetDebounceKey(8,player);
              tVar3 = (tInputKeyType)((u_int)(iVar2 != 0) << 0xd);
            }
            else {
              tVar3 = kInput_KeyType_Square;
            }
          }
        }
      }
      return tVar3;
    }
  }
  return (tInputKeyType)getKeyMappings[uVar4].FEKey;
}



/* end of feinput.cpp */
