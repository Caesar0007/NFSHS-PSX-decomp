/* game/psx/device.cpp -- RECONSTRUCTED (NFS4 PSX input/pad device layer; C++ TU)
 *   10 fns: Device_VerifyType/Fail/Update/StartUp/SetHardCodedKeys, PSXPad/ReadPad/PSXPadMulti/Analog/Null.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "device_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
char Device_gPausePortIndex;
int Device_gForcePause;
int Device_gPausePort;
int Device_gPaused;

/* Device_gToggleTime[2]/Device_gPrev[2] (device_externs.h) are declared as ONE 8-byte
 * array each, but the Device_StartUp/Device_Update oracles reach every access -- all
 * CONSTANT-index [0]/[1] -- as TWO INDEPENDENT %gp_rel(SYM)/%gp_rel(D_..) globals, no
 * address materialization at all (8 bytes is over this build's -G4 small-data threshold
 * as ONE object, but each 4-byte element alone qualifies; both D_ syms are listed in
 * configs/gp_rel_symbols.txt). Same fix as weather.cpp's Weather_gLastProcessTime0/1
 * precedent (section 3.12 #6, applied per-element): model the TRUE per-element storage
 * as real tentative-def scalars for these constant-index sites. Neither array has any
 * OTHER (variable-index) reference anywhere in the project's oracle set, so no residual
 * array-form duality to keep in sync here. */
int Device_gToggleTime0;
int Device_gToggleTime1;
#define DEVICE_GTOGGLETIME0 Device_gToggleTime0
#define DEVICE_GTOGGLETIME1 Device_gToggleTime1
u_long Device_gPrev0;
u_long Device_gPrev1;
#define DEVICE_GPREV0 Device_gPrev0
#define DEVICE_GPREV1 Device_gPrev1

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


/* ---- Device_VerifyType__Fi  [DEVICE.CPP:51-66] SLD-VERIFIED ----
 * NEAR-MISS (was 31 diffs -> now 11, ours 41/oracle 42): the two structural bugs are
 * fixed -- (a) controllerConfig access is now the array-index form GameSetup_gData.
 * controllerData.controllerConfig[isP2] (mined from the sealed sibling MPause_
 * EndPauseMenu's identical idiom via tools/pattern_suggest.py); (b) the controlType
 * short access now correctly reads/writes SIGNED (was wrongly u_short) at the oracle's
 * real field offset 0x35E(s1) with s1=&frontEnd+uVar2 (the reinterpret-cast-through-
 * pfe form reproduces the oracle's base-materializes-BEFORE-mask instruction order).
 * RESIDUAL (11 diffs, pure reg/algebraic, all content already matches -- both sides
 * carry the same 862-offset load/store, just via a different index computation): the
 * oracle computes uVar2/uVar1&4 via sltu+negu+andi (an un-simplified -(bool)&N mask,
 * exactly the source form below), but THIS gcc-2.8.0 always constant-folds that same
 * source expression down to a shift (bool<<1 / bool<<2) once it can prove isP2 is a
 * strict 0/1 boolean -- confirmed the fold happens at every source variant tried:
 * shared named bool, inline recomputation, pre-materialized base pointer, volatile
 * uVar1 (that regressed further, +stack spill). Not a permuter target either (90-iter
 * run plateaued >=100, natural basin has no downhill path per section 3.13 -- would
 * need a hand multi-basin re-seed, not attempted this pass). Parking as an honest
 * near-miss; the remaining lever to try next session is a source form where isP2's
 * boolean range is NOT directly provable at the mask computation (e.g. route it
 * through an opaque/indirect load) rather than fighting the optimizer's own proof. */
int Device_VerifyType(int port)

{
  tfrontEnd *pfe;
  u_int isP2;
  u_int uVar1;
  u_int uVar2;

  if (gUseFrontend != 0) {
    if (gPadinfo.buf[port].nopad != '\0') {
      return 0;
    }
    pfe = &frontEnd;
    isP2 = (u_int)(port != 0);
    uVar1 = -isP2;
    uVar2 = uVar1 & 2;
    if (gPadinfo.buf[port].ID != ((tfrontEnd *)((char *)pfe + uVar2))->controlType[0]) {
      InGame_ResetPSXController(isP2, GameSetup_gData.controllerData.controllerConfig[isP2]);
      ((tfrontEnd *)((char *)pfe + uVar2))->controlType[0] = gPadinfo.buf[port].ID;
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
  if (iVar2 != 0) {
    failtime[port != 0] = '\0';
  }
  else {
    bVar1 = failtime[port != 0];
    if ((u_int)bVar1 < 9) {
      failtime[port != 0] = bVar1 + 1;
    }
    else {
      return 1;
    }
  }
  return 0;
}

/* ---- Device_Update__Fv  [DEVICE.CPP:109-160] SLD-VERIFIED ---- */
void Device_Update(void)

{
  int iVar1;
  int iVar2;
  
  PAD_update();
  if (simVar.pauseSim != 0) {
    Device_gPaused = 1;
    DEVICE_GTOGGLETIME0 = 0x11;
    DEVICE_GTOGGLETIME1 = 0x11;
  }
  else if (Device_gPaused != 0) {
    Device_gPaused = 0;
    Device_gPausePort = -1;
    DEVICE_GTOGGLETIME0 = 0;
    DEVICE_GTOGGLETIME1 = 0;
  }
  if (simVar.pauseSim == 0) {
    iVar2 = Device_Fail(0);
    if (iVar2 != 0) {
      Device_gForcePause = 1;
      Device_gPausePort = 0;
      Device_gPausePortIndex = '\0';
    }
    else {
      iVar1 = GameSetup_gData.commMode;
      if ((iVar1 == 1) && (iVar2 = Device_Fail(4), iVar2 != 0)) {
        Device_gForcePause = iVar1;
        Device_gPausePort = 4;
        Device_gPausePortIndex = (char)iVar1;
      }
      else {
        Device_gForcePause = 0;
      }
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
  DEVICE_GTOGGLETIME0 = 0;
  DEVICE_GTOGGLETIME1 = 0;
  DEVICE_GPREV0 = 0;
  DEVICE_GPREV1 = 0;
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
  u_short state;

  iVar1 = Device_VerifyType(param >> 0x10);
  if (iVar1 == 0) {
    return 0;
  }
  state = *(u_short *)((char *)&gPadinfo.buf[0].data.standard.state +
                        (param >> 0x10) * sizeof(PAD_COMMON));
  if (((u_short)~state & param) != 0) {
    return 0xff;
  }
  return 0;
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

/* ---- Device_PSXPadMulti__FUl  [DEVICE.CPP:306-342] SLD-VERIFIED ----
 * NEAR-MISS (was 46 diffs -> now 17, ours 56/oracle 55): outer if/else branch polarity
 * inverted to match the oracle's beqz-pauseSim==0 fall-through (same class as Device_
 * Update); the inner "port 0 found" if/else polarity flipped to match too; dropped a
 * redundant `iVar2=0` comma side-effect from the Replay_ReplayMode||commMode==1 gate
 * (was forcing an xori-based != codegen -- oracle uses a plain bne). RESIDUAL (17
 * diffs, all content-identical, pure v0/v1/a0 register-coloring): at all 3
 * Device_ReadPad call sites the oracle caches the raw call return into a FRESH reg
 * (addu v1,v0,zero) before testing it, freeing v0 to stage the 0xff/0 return value
 * directly; ours tests the call return in-place (v0) and stages 0xff/0 via a0 with an
 * extra move at the epilogue. Tried: void*->u_int retype (no effect), ternary for the
 * first block's iVar2 select (no net improvement, shifts which sub-block loses),
 * direct early-return for the first block (regressed, +1 insn + wrong polarity there).
 * Permuter (100-iter run) plateaued at base score 135, same basin, no downhill path
 * found. Parking as an honest near-miss; the call-result-caching habit repeats
 * identically at all 3 ReadPad sites so a single source-level lever (if found) should
 * clear the whole residual at once -- worth another dedicated pass. */
int Device_PSXPadMulti(u_long param)

{
  void *pvVar1;
  int iVar2;

  if (simVar.pauseSim != 0) {
    pvVar1 = Device_ReadPad(Device_gPausePort,param);
    iVar2 = 0xff;
    if (pvVar1 == (void *)0x0) {
      iVar2 = 0;
    }
  }
  else {
    pvVar1 = Device_ReadPad(0,param);
    if (pvVar1 != (void *)0x0) {
      iVar2 = 0xff;
      if ((param & 0xffff) == 8) {
        Device_gPausePort = 0;
        Device_gPausePortIndex = '\0';
      }
    }
    else {
      if ((1 < Replay_ReplayMode) || (GameSetup_gData.commMode == 1)) {
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
      else {
        iVar2 = 0;
      }
    }
  }
  return iVar2;
}

/* ---- Device_Analog__FUl  [DEVICE.CPP:352-384] SLD-VERIFIED ----
 * NEAR-MISS (was 63 diffs -> now 57, ours 67/oracle 64): uVar2/uVar4/uVar5 retyped
 * u_int->int -- the oracle's clamp compares are SIGNED (slt), but these were declared
 * u_int so the compare chain emitted sltu; fixed all 3 comparison sites at once (a
 * whole cluster of "slt" vs "sltu" diffs vanished). RESIDUAL (57 diffs): a persistent
 * beqz/bnez branch-POLARITY mismatch on the outer Device_VerifyType==0 early-return
 * (oracle: bnez-continue/fall-through-return0; ours: beqz-return0/fall-through-
 * continue) -- tried both `if(iVar1==0)return 0;` (early-return) and the inverted
 * `if(iVar1!=0){...whole body...}return 0;` wrap; BOTH compile to the identical beqz
 * shape (gcc folds the wrap back to the early-return form regardless of source
 * polarity, similar to the shift-simplification seen on Device_VerifyType). The
 * downstream subtract/divide-guard chain (DevAnalog_scaledByteCalc goto-merge, the
 * div-by-INT_MIN/-1 break guard) carries its own separate scheduling residuals not
 * yet investigated in isolation. v/max/min are declared-but-unused locals (present
 * before this pass, left untouched per the "unused local can be load-bearing"
 * caution -- section 3.12 #15 -- not confirmed either way this session). */
int Device_Analog(u_long param)

{
  int iVar1;
  int v;
  int uVar2;
  int iVar3;
  int max;
  int uVar4;
  int min;
  int uVar5;
  int iVar6;

  iVar1 = Device_VerifyType(param >> 0x14);
  if (iVar1 == 0) {
    return 0;
  }
  uVar2 = (int)*(u_char *)((int)&gPadinfo.buf[param >> 0x14].data + (param >> 0x10 & 3) + 2);
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
