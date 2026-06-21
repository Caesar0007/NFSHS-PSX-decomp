/* game/psx/device.cpp -- RECONSTRUCTED (NFS4 PSX input/pad device layer; C++ TU)
 *   10 fns: Device_VerifyType/Fail/Update/StartUp/SetHardCodedKeys, PSXPad/ReadPad/PSXPadMulti/Analog/Null.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "device_externs.h"

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
int Device_VerifyType(int port);
int Device_Fail(int port);
void Device_Update(void);
void Device_StartUp(void);
void Device_SetHardCodedKeys(void);
int Device_PSXPad(u_long param);
void * Device_ReadPad(int port,u_long param);
int Device_PSXPadMulti(u_long param);
int Device_Analog(u_long param);
int Device_Null(u_long param);


/* ---- Device_VerifyType__Fi  [DEVICE.CPP:51-66] SLD-VERIFIED ---- */
int Device_VerifyType(int port)

{
  u_int uVar1;
  u_int uVar2;
  
  if (gUseFrontend != 0) {
    if (gPadinfo.buf[port].nopad != '\0') {
      return 0;
    }
    uVar1 = -(u_int)(port != 0);
    uVar2 = uVar1 & 2;
    if ((u_short)gPadinfo.buf[port].ID != *(u_short *)((int)frontEnd.controlType + uVar2)) {
      InGame_ResetPSXController((u_int)(port != 0),
                 *(int *)((int)GameSetup_gData.controllerData.controllerConfig + (uVar1 & 4)));
      *(u_short *)((int)frontEnd.controlType + uVar2) = (u_short)gPadinfo.buf[port].ID;
      return 1;
    }
  }
  return 1;
}

/* ---- Device_Fail__Fi  [DEVICE.CPP:72-87] SLD-VERIFIED ---- */
int Device_Fail(int port)

{
  static u_char failtime[2];   /* @0x8013dde4 STAT (.bss) */
  u_char bVar1;
  int iVar2;

  iVar2 = Device_VerifyType(port);
  if (iVar2 == 0) {
    bVar1 = failtime[port != 0];
    if (8 < bVar1) {
      return 1;
    }
    failtime[port != 0] = bVar1 + 1;
  }
  else {
    failtime[port != 0] = '\0';
  }
  return 0;
}

/* ---- Device_Update__Fv  [DEVICE.CPP:109-160] SLD-VERIFIED ---- */
void Device_Update(void)

{
  int iVar1;
  int iVar2;
  
  PAD_update();
  if (simVar.pauseSim == 0) {
    if (Device_gPaused != 0) {
      Device_gPaused = 0;
      Device_gPausePort = -1;
      Device_gToggleTime[0] = 0;
      Device_gToggleTime[1] = 0;
    }
  }
  else {
    Device_gPaused = 1;
    Device_gToggleTime[0] = 0x11;
    Device_gToggleTime[1] = 0x11;
  }
  if (simVar.pauseSim == 0) {
    iVar2 = Device_Fail(0);
    iVar1 = GameSetup_gData.commMode;
    if (iVar2 == 0) {
      if ((GameSetup_gData.commMode == 1) && (iVar2 = Device_Fail(4), iVar2 != 0)) {
        Device_gForcePause = iVar1;
        Device_gPausePort = 4;
        Device_gPausePortIndex = '\x01';
      }
      else {
        Device_gForcePause = 0;
      }
    }
    else {
      Device_gForcePause = 1;
      Device_gPausePort = 0;
      Device_gPausePortIndex = '\0';
    }
  }
  return;
}

/* ---- Device_StartUp__Fv  [DEVICE.CPP:169-176] SLD-VERIFIED ---- */
void Device_StartUp(void)

{
  Device_gPaused = 0;
  Device_gForcePause = 0;
  Device_gPausePort = -1;
  Device_gToggleTime[0] = 0;
  Device_gToggleTime[1] = 0;
  Device_gPrev[0] = 0;
  Device_gPrev[1] = 0;
  return;
}

/* ---- Device_SetHardCodedKeys__Fv  [DEVICE.CPP:195-205] SLD-VERIFIED ---- */
void Device_SetHardCodedKeys(void)

{
  Input_gHandler[0x99] = 0x1003;
  Input_gHandler[0x9a] = 0x4003;
  Input_gHandler[0x9b] = 0x8003;
  Input_gHandler[0x9c] = 0x2003;
  Input_gHandler[0x9e] = 0x803;
  Input_gHandler[0x9d] = 0x400003;
  Input_gHandler[0xb0] = 0x100003;
  Input_gHandler[0xb1] = 0x800003;
  Input_gHandler[0xa0] = 0x103;
  Input_gHandler[0x98] = 0;
  return;
}

/* ---- Device_PSXPad__FUl  [DEVICE.CPP:244-250] SLD-VERIFIED ---- */
int Device_PSXPad(u_long param)

{
  int iVar1;
  
  iVar1 = Device_VerifyType(param >> 0x10);
  if ((iVar1 == 0) ||
     (iVar1 = 0xff, (~(u_int)gPadinfo.buf[param >> 0x10].data.standard.state & 0xffff & param) == 0))
  {
    iVar1 = 0;
  }
  return iVar1;
}

/* ---- Device_ReadPad__FiUl  [DEVICE.CPP:261-302] SLD-VERIFIED ---- */
void * Device_ReadPad(int port,u_long param)

{
  int iVar1;
  void *pvVar2;
  u_int uVar3;
  char *analogs;
  
  iVar1 = Device_VerifyType(port);
  if (iVar1 == 0) {
    return (void *)0x0;
  }
  if (gPadinfo.buf[port].ID == '#') {
    if (((param & 0xffff) != 0x4000) || (gPadinfo.buf[port].data.negcon.buttonI < 0x40)) {
      if ((gPadinfo.buf[port].ID == '#') &&
         (((param & 0xffff) == 0x8000 && (0x3f < gPadinfo.buf[port].data.negcon.buttonII)))) {
        return (void *)0x1;
      }
      goto DevReadPad_negconPath;
    }
DevReadPad_defaultRet:
    pvVar2 = (void *)0x1;
  }
  else {
DevReadPad_negconPath:
    if (gPadinfo.buf[port].ID == 's') {
      if ((param & 0xffff) == 0x80) {
        if (gPadinfo.buf[port].data.negcon.twist < 0x41) goto DevReadPad_defaultRet;
        if (gPadinfo.buf[port].data.negcon.buttonII < 0x41) {
          return (void *)0x1;
        }
      }
      if (gPadinfo.buf[port].ID == 's') {
        if ((param & 0xffff) == 0x20) {
          if (0xbf < gPadinfo.buf[port].data.negcon.twist) {
            return (void *)0x1;
          }
          if (0xbf < gPadinfo.buf[port].data.negcon.buttonII) {
            return (void *)0x1;
          }
        }
        if (gPadinfo.buf[port].ID == 's') {
          if ((param & 0xffff) == 0x10) {
            if (gPadinfo.buf[port].data.negcon.leftshift < 0x41) {
              return (void *)0x1;
            }
            if (gPadinfo.buf[port].data.negcon.buttonI < 0x41) {
              return (void *)0x1;
            }
          }
          if ((gPadinfo.buf[port].ID == 's') && ((param & 0xffff) == 0x40)) {
            if (0xbf < gPadinfo.buf[port].data.negcon.leftshift) {
              return (void *)0x1;
            }
            if (0xbf < gPadinfo.buf[port].data.negcon.buttonI) {
              return (void *)0x1;
            }
          }
        }
      }
    }
    uVar3 = PAD_state(port);
    pvVar2 = (void *)(u_int)((uVar3 & 0xffff & param) != 0);
  }
  return pvVar2;
}

/* ---- Device_PSXPadMulti__FUl  [DEVICE.CPP:306-342] SLD-VERIFIED ---- */
int Device_PSXPadMulti(u_long param)

{
  void *pvVar1;
  int iVar2;
  
  if (simVar.pauseSim == 0) {
    pvVar1 = Device_ReadPad(0,param);
    if (pvVar1 == (void *)0x0) {
      if ((1 < Replay_ReplayMode) || (iVar2 = 0, GameSetup_gData.commMode == 1)) {
        pvVar1 = Device_ReadPad(4,param);
        if (pvVar1 == (void *)0x0) {
          iVar2 = 0;
        }
        else {
          if ((param & 0xffff) == 8) {
            Device_gPausePortIndex = '\x01';
            Device_gPausePort = 4;
          }
          iVar2 = 0xff;
        }
      }
    }
    else {
      iVar2 = 0xff;
      if ((param & 0xffff) == 8) {
        Device_gPausePort = 0;
        Device_gPausePortIndex = '\0';
      }
    }
  }
  else {
    pvVar1 = Device_ReadPad(Device_gPausePort,param);
    iVar2 = 0xff;
    if (pvVar1 == (void *)0x0) {
      iVar2 = 0;
    }
  }
  return iVar2;
}

/* ---- Device_Analog__FUl  [DEVICE.CPP:352-384] SLD-VERIFIED ---- */
int Device_Analog(u_long param)

{
  int iVar1;
  int v;
  u_int uVar2;
  int iVar3;
  int max;
  u_int uVar4;
  int min;
  u_int uVar5;
  int iVar6;
  
  iVar1 = Device_VerifyType(param >> 0x14);
  if (iVar1 == 0) {
    return 0;
  }
  uVar2 = (u_int)*(u_char *)((int)&gPadinfo.buf[param >> 0x14].data + (param >> 0x10 & 3) + 2);
  uVar5 = param >> 8 & 0xff;
  uVar4 = param & 0xff;
  if (uVar5 < uVar4) {
    if (uVar5 <= uVar2) {
      iVar1 = uVar2 - uVar5;
      if (uVar4 < uVar2) {
        return 0xff;
      }
      iVar3 = uVar4 - uVar5;
DevAnalog_scaledByteCalc:
      /* @0x800BDA34-38 / 0x800BDA64-68: numerator = raw analog byte uVar2 * 0xff ($v1<<8 - $v1),
       * NOT the min-subtracted iVar1. iVar1 (=uVar2-uVar5 / uVar5-uVar2) is the MIPS dead-store at
       * 0x800BDA28 / 0x800BDA58 that is overwritten by 0xFF/0 on the clamp paths and never reaches
       * the (signed) divide. Reconstruction fed iVar1*0xff into the scale instead of uVar2*0xff (H45). */
      iVar6 = ((int)uVar2 * 0xff) / iVar3;
      if (iVar3 == 0) {
        trap(0x1c00);
      }
      if (iVar3 == -1) {
        if ((int)uVar2 * 0xff == -0x80000000) {
          trap(0x1800);
          return iVar6;
        }
        return iVar6;
      }
      return iVar6;
    }
  }
  else if (uVar5 != uVar4) {
    if (uVar2 < uVar4) {
      return 0xff;
    }
    iVar1 = uVar5 - uVar2;
    if (uVar2 <= uVar5) {
      iVar3 = uVar5 - uVar4;
      goto DevAnalog_scaledByteCalc;
    }
  }
  return 0;
}

/* ---- Device_Null__FUl  [DEVICE.CPP:393-394] SLD-VERIFIED ---- */
int Device_Null(u_long param)

{
  return 0;
}

/* end of device.cpp */
