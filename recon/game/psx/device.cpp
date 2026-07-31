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
bool Device_ReadPad(int port,u_long param);
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

/* ---- Device_ReadPad__FiUl  [DEVICE.CPP:261-302] SLD-VERIFIED ----
 * PASS (140/140, was 138 diffs).  REWRITTEN from the SYM + raw oracle (w38-a6).
 * SYM @0x800bd6ac: REGPARMs port($10=s0), param($11=s1) and ONE named local -- `analogs`,
 * class REG $4 = $a0, type PTR CHAR.  In the oracle `analogs` is materialized at
 * .L800BD758 as `addiu $a0,$a1,2` off the shared base $a1 = &gPadinfo.buf[port].data
 * (splat's D_8013E8A2 = gPadinfo+6), i.e. &data.negcon.twist; every negcon test after that
 * point indexes it analogs[0..3] (twist/buttonI/buttonII/leftshift) and the ID byte is
 * read off the SAME base as `lbu $v1,-1($v0)`.  The `if (ID == X && ...)` tests are SIX
 * FLAT STATEMENTS, each re-loading gPadinfo.buf[port].ID; gcc's jump threading is what
 * makes a failed ID test branch straight past all later same-ID statements
 * (.L800BD758 / .L800BD8B4), which is why the previous nested-if + goto reconstruction
 * came out 12 insns SHORT (128 vs 140).  Return type is BOOL per the SYM
 * (`Def class EXT type FCN BOOL`); the mangled name __FiUl is unaffected. */
bool Device_ReadPad(int port,u_long param)

{
  char *analogs;

  if (Device_VerifyType(port) == 0) {
    return 0;
  }
  if (((gPadinfo.buf[port].ID == '#') && ((param & 0xffff) == 0x4000)) &&
     (0x3f < gPadinfo.buf[port].data.negcon.buttonI)) {
    return 1;
  }
  if (((gPadinfo.buf[port].ID == '#') && ((param & 0xffff) == 0x8000)) &&
     (0x3f < gPadinfo.buf[port].data.negcon.buttonII)) {
    return 1;
  }
  analogs = (char *)&gPadinfo.buf[port].data.negcon.twist;
  if ((gPadinfo.buf[port].ID == 's') && ((param & 0xffff) == 0x80)) {
    if (analogs[0] < 0x41) {
      return 1;
    }
    if (analogs[2] < 0x41) {
      return 1;
    }
  }
  if ((gPadinfo.buf[port].ID == 's') && ((param & 0xffff) == 0x20)) {
    if (0xbf < analogs[0]) {
      return 1;
    }
    if (0xbf < analogs[2]) {
      return 1;
    }
  }
  if ((gPadinfo.buf[port].ID == 's') && ((param & 0xffff) == 0x10)) {
    if (analogs[3] < 0x41) {
      return 1;
    }
    if (analogs[1] < 0x41) {
      return 1;
    }
  }
  if ((gPadinfo.buf[port].ID == 's') && ((param & 0xffff) == 0x40)) {
    if (0xbf < analogs[3]) {
      return 1;
    }
    if (0xbf < analogs[1]) {
      return 1;
    }
  }
  return (PAD_state(port) & 0xffff & param) != 0;
}

/* ---- Device_PSXPadMulti__FUl  [DEVICE.CPP:306-342] SLD-VERIFIED ----
 * PASS (55/55, was 17 diffs).  SYM @0x800bd8dc lists REGPARM param ($10=s0) and NO named
 * locals at all -- so the recon's cached-result + result-funnel variables were fabricated:
 * they pinned the return value into $a0 and added a trailing `addu $v0,$a0,$zero`.  Writing
 * every arm as a DIRECT `return 0xff;` / `return 0;` on the call expression makes gcc stage
 * the constants straight into $v0 and copy the call result into $v1, exactly like retail.
 * ---- historical note (superseded) ----
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
  if (simVar.pauseSim != 0) {
    if (Device_ReadPad(Device_gPausePort,param) != 0) {
      return 0xff;
    }
    return 0;
  }
  if (Device_ReadPad(0,param) != 0) {
    if ((param & 0xffff) == 8) {
      Device_gPausePort = 0;
      Device_gPausePortIndex = '\0';
    }
    return 0xff;
  }
  if ((1 < Replay_ReplayMode) || (GameSetup_gData.commMode == 1)) {
    if (Device_ReadPad(4,param) == 0) {
      return 0;
    }
    if ((param & 0xffff) == 8) {
      Device_gPausePortIndex = '\x01';
      Device_gPausePort = 4;
    }
    return 0xff;
  }
  return 0;
}

/* ---- Device_Analog__FUl  [DEVICE.CPP:352-384] SLD-VERIFIED ----
 * REWRITTEN from the SYM + raw oracle (w38-a6).  SYM `8c Function start` @0x800bd9b8 lists
 * EXACTLY THREE named locals -- min ($5=a1), max ($4=a0), v ($3=v1) -- plus REGPARM param
 * ($10=s0); every other value in the oracle is a compiler temp.  The previous recon carried
 * 9 fabricated locals + a hand-written div guard + a goto-merged tail.
 * 🔴 CORRECTNESS BUG FIXED (the old in-source note had it exactly backwards): the numerator
 * is the MIN-SUBTRACTED value, not the raw byte.  At 0x800BDA24 `beqz $v0,.L800BDA34` the
 * DELAY SLOT 0x800BDA28 `subu $v1,$v1,$a1` (v -= min) executes on BOTH paths, and .L800BDA34
 * -- the TAKEN path -- then does `sll $v0,$v1,8; subu $v0,$v0,$v1` = (v-min)*255.  It is dead
 * only on the fall-through (the `return 0xff` clamp).  Same on the mirrored arm at
 * 0x800BDA58/.L800BDA64 = (min-v)*255 over (min-max).  So this is the normal
 * "scale [min,max] onto [0,255]" formula; the old code divided the UNSHIFTED raw byte,
 * i.e. every analog axis read was biased by min*255/(max-min) at runtime.
 * The div guards (`bnez $v1 / break 7`, the -1 / INT_MIN `break 6` pair) are maspsx
 * --expand-div's automatic expansion of a plain C `/` -- never write them by hand.
 * RESIDUAL 22 diffs (ours 76 / oracle 64 = +12): retail CROSS-JUMPS the two arms'
 * divide tails into ONE shared `div` block (`j .L800BDA70` out of the min<max arm);
 * our cc1plus keeps both copies.  w39-a5 probes (all WORSE, do not retry):
 *   explicit `goto` to a shared divide + denominator folded into `max`   44 (62/64)
 *   split `v = v - min;` then `v = (v*0xff)/(max-min);`                  62 (76/64)
 *   early-`return 0/0xff` guards instead of if/else arms                 37 (77/64)
 * The goto form DOES produce the single shared divide (62 vs 64 insns) but re-colors
 * min/max out of their SYM homes because `max` is then mutated; there is no spelling
 * that shares the tail without inventing a denominator local the SYM does not have. */
int Device_Analog(u_long param)

{
  int min;
  int max;
  int v;

  if (Device_VerifyType(param >> 0x14) == 0) {
    return 0;
  }
  v = (int)*(u_char *)((int)&gPadinfo.buf[param >> 0x14].data + (param >> 0x10 & 3) + 2);
  min = param >> 8 & 0xff;
  max = param & 0xff;
  if (min < max) {
    if (v < min) {
      v = 0;
    }
    else if (max < v) {
      v = 0xff;
    }
    else {
      v = ((v - min) * 0xff) / (max - min);
    }
  }
  else if (min != max) {
    if (v < max) {
      v = 0xff;
    }
    else if (min < v) {
      v = 0;
    }
    else {
      v = ((min - v) * 0xff) / (min - max);
    }
  }
  else {
    v = 0;
  }
  return v;
}

/* ---- Device_Null__FUl  [DEVICE.CPP:393-394] SLD-VERIFIED ---- */
int Device_Null(u_long param)

{
  return 0;
}

/* end of device.cpp */
