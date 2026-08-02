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
  char *analogs;

  PAD_update();
  if (gPadinfo.buf[controller * 4].nopad != '\0') {
    return 0;
  }
  FEInput_VerifyControllerValues(controller);
  analogs = (char *)&gPadinfo.buf[controller * 4].data.negcon.twist;
  if ((gPadinfo.buf[controller * 4].ID == 's') ||
      (gPadinfo.buf[controller * 4].ID == 'S')) {
    switch (key) {
    case 0x800000:
      return (u_char)analogs[0] < 0x40;
    case 0x200000:
      return (u_char)analogs[0] >= 0xc1;
    case 0x100000:
      return (u_char)analogs[1] < 0x40;
    case 0x400000:
      return (u_char)analogs[1] >= 0xc1;
    case (int)0x80000000:
      return (u_char)analogs[2] < 0x40;
    case 0x20000000:
      return (u_char)analogs[2] >= 0xc1;
    case 0x10000000:
      return (u_char)analogs[3] < 0x40;
    case 0x40000000:
      return (u_char)analogs[3] >= 0xc1;
    default:
      return ((~(u_int)gPadinfo.buf[controller * 4].data.standard.state) & key) != 0;
    }
  }
  if (gPadinfo.buf[controller * 4].ID == '#') {
    switch (key) {
    case 0x8000:
      return gPadinfo.buf[controller * 4].data.negcon.buttonII >= 0x41;
    case 0x4000:
      return gPadinfo.buf[controller * 4].data.negcon.buttonI >= 0x41;
    case 0x200000:
      return gPadinfo.buf[controller * 4].data.negcon.twist >= 0xa1;
    case 0x800000:
      return gPadinfo.buf[controller * 4].data.negcon.twist < 0x62;
    default:
      return (((u_int)PAD_state(controller << 2) & 0xffff) & key) != 0;
    }
  }
  return (((u_int)PAD_state(controller << 2) & 0xffff) & key) != 0;
}



/* ---- FEInput_GetDebounceKey  [FEINPUT.CPP:146-179] SLD-VERIFIED ---- */

int FEInput_GetDebounceKey(int key,int controller)

{
  /* SYM (nfs4-f-v3.txt @0x80023B74): key REGPARM $16, controller REGPARM $17,
     and exactly ONE named local -- `int tick` REG $4 (a0), declared at the top of
     the block starting at 0x80023BB8 (the `lw ticks`) and running to 0x80023C38.
     The oracle reads `ticks` ONCE into that local; the old body re-read the global
     at every use.  Branch polarity: the debounce SET path and the debounce CLEAR
     path are both laid out OUT OF LINE after the tick block (oracle `beqz` to
     .L80023C38 / .L80023C50), so both guards must be written as the taken-branch
     case with the tick block falling through. */
  if (FEInput_GetNoDebounceKey(key,controller) != 0) {
    if ((debounce[controller] & key) != 0) {
      int tick = ticks[0];

      if ((((key == 0x10) || (key == 0x80)) || (key == 0x20)) || (key == 0x40)) {
        if (nextTick[0] == 0) {
          nextTick[0] = tick + FeTools_gScrollTicksOut[0] + 10;
        }
        if (tick < nextTick[0]) {
          return 0;
        }
        nextTick[0] = tick + FeTools_gScrollTicksOut[0];
        return 1;
      }
      return 0;
    }
    debounce[controller] = debounce[controller] | key;
    nextTick[0] = 0;
    return 1;
  }
  debounce[controller] = debounce[controller] & ~key;
  return 0;
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
