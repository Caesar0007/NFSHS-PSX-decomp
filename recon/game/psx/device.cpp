/* game/psx/device.cpp -- RECONSTRUCTED (NFS4 PSX input/pad device layer; C++ TU)
 *   10 fns: Device_VerifyType/Fail/Update/StartUp/SetHardCodedKeys, PSXPad/ReadPad/PSXPadMulti/Analog/Null.
 *   GTE-free. Full SYM-locals applied.
 */
#include "device_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
char Device_gPausePortIndex;
int Device_gForcePause;
int Device_gPausePort;
int Device_gPaused;

/* Device_gToggleTime[2] / Device_gPrev[2] are the TU's OWN 8-byte arrays and the
 * oracle reaches them gp-relatively (`%gp_rel(Device_gToggleTime)`,
 * `%gp_rel(Device_gPrev)` + the per-element D_8013D788/D_8013D790), which is
 * only possible with -G8 -- so device.obj is a -G8 object (PER_TU_FLAGS).
 * They were previously hand-split into Device_gToggleTime0/1 + Device_gPrev0/1
 * scalars to fake the gp-rel under -G4; that was a REAL BUG, not just a match
 * device: the duals are DIFFERENT storage from the arrays every other consumer
 * sees through device_externs.h, so Device_StartUp/Device_Update never actually
 * cleared the arrays.  Real arrays restored. */
int Device_gToggleTime[2];
int Device_gPrev[2];

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
 * PASS 42/42 (w41-a5).  🏆 NEW LEVER -- A COMPARISON USED DIRECTLY AS AN ARRAY
 * SUBSCRIPT expands via gcc-2.8's STORE-FLAG path (`sltu; negu; andi 2^k`), NOT via
 * `sll`.  The whole 11-diff residual below was a self-inflicted problem: the recon
 * had hand-written the oracle's `negu`/`andi` byte-math as source (`uVar1 = -isP2;
 * uVar2 = uVar1 & 2;`), and cc1 then FOLDED it back to `sll` because the named local
 * `isP2` provably held 0/1.  Writing the SUBSCRIPT ITSELF as the comparison --
 * `frontEnd.controlType[port != 0]` / `controllerConfig[port != 0]` -- makes
 * expand_expr emit the scale as neg+and for each element size (2 and 4) off ONE
 * CSE'd `negu $a1,$a0`, exactly the oracle, and `$a0` stays the 0/1 call argument.
 * A named `int`/`bool` local for the same comparison keeps the 11-diff `sll` form
 * (measured: 11 both), and mutating the parameter in place is worse (27).
 * ⇒ the w40 note's "gcc always constant-folds this, not permuter-reachable" verdict
 * was fighting a fold that only existed because the source pre-expanded it.
 * The three fabricated locals (pfe/uVar1/uVar2) are gone -- the SYM names none of
 * them (catalog: SYM-empty-locals => DELETE invented temps). */
/* OLD NOTE (superseded, kept for the receipt trail):
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
  if (gUseFrontend != 0) {
    if (Device_gPadBytes[port * 2][4] != '\0') {
      return 0;
    }
    if (Device_gPadBytes[port * 2][5] != frontEnd.controlType[port != 0]) {
      InGame_ResetPSXController(port != 0,
          Device_gControllerConfig[1][port != 0]);
      frontEnd.controlType[port != 0] = Device_gPadBytes[port * 2][5];
      return 1;
    }
  }
  return 1;
}

/* ---- Device_Fail__Fi  [DEVICE.CPP:72-87] SLD-VERIFIED ----
 * PASS 28/28; SYM names only the function-local static failtime[2].  Direct use of the
 * VerifyType result and repeated indexed byte expression lets gcc create the
 * unnamed temporaries, avoiding the fabricated iVar2/bVar1 debug records. */
int Device_Fail(int port)

{
  static u_char failtime[2];   /* @0x8013dde4 STAT (.bss) */

  if (Device_VerifyType(port) != 0) {
    failtime[port != 0] = '\0';
  }
  else {
    if ((u_int)failtime[port != 0] < 9) {
      failtime[port != 0] = failtime[port != 0] + 1;
    }
    else {
      return 1;
    }
  }
  return 0;
}

/* ---- Device_Update__Fv  [DEVICE.CPP:109-160] SLD-VERIFIED ----
 * PASS 56/56.  The call-result iVar2 was removable and is now direct.  The
 * remaining commMode value is a measured PASS carrier: deleting it makes gcc preserve
 * the GameSetup array base in $s0 and reload word 3 after Device_Fail (59
 * instructions), whereas retail preserves the loaded communication mode itself
 * in $s0.  SYM emits no local record; Ghidra and raw instructions independently
 * identify the value as GameSetup_gData.commMode, so its source-only name is
 * semantic rather than a decompiler placeholder. */
void Device_Update(void)

{
  int commMode; /* SYM-CODEGEN-CARRIER: commMode -- removal changes PASS 56 to 59 insns */

  PAD_update();
  if (simVar[2] != 0) {
    Device_gPaused = 1;
    Device_gToggleTime[0] = 0x11;
    Device_gToggleTime[1] = 0x11;
  }
  else if (Device_gPaused != 0) {
    Device_gPaused = 0;
    Device_gPausePort = -1;
    Device_gToggleTime[0] = 0;
    Device_gToggleTime[1] = 0;
  }
  if (simVar[2] == 0) {
    if (Device_Fail(0) != 0) {
      Device_gForcePause = 1;
      Device_gPausePort = 0;
      Device_gPausePortIndex = '\0';
    }
    else {
      commMode = GameSetup_gData[3];
      if ((commMode == 1) && (Device_Fail(4) != 0)) {
        Device_gForcePause = commMode;
        Device_gPausePort = 4;
        Device_gPausePortIndex = (char)commMode;
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

/* ---- Device_PSXPad__FUl  [DEVICE.CPP:244-250] SLD-VERIFIED ----
 * PASS 26/26; SYM names no locals.  The VerifyType call and pad-state load are
 * intentionally direct so their compiler temporaries emit no iVar1/state defs. */
int Device_PSXPad(u_long param)

{
  if (Device_VerifyType(param >> 0x10) == 0) {
    return 0;
  }
  if (((u_short)~*(u_short *)((int)&gPadinfo[0].data.standard.state + 4 +
                              (param >> 0x10) * sizeof(PAD_COMMON)) & param) != 0) {
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
  if (((Device_gPadBytes[port * 2][5] == '#') && ((param & 0xffff) == 0x4000)) &&
     (0x3f < Device_gPadBytes[port * 2][9])) {
    return 1;
  }
  if (((Device_gPadBytes[port * 2][5] == '#') && ((param & 0xffff) == 0x8000)) &&
     (0x3f < Device_gPadBytes[port * 2][10])) {
    return 1;
  }
  analogs = (char *)&((PAD_NEGCON *)&Device_gPadBytes[port * 2][6])->twist;
  if ((Device_gPadBytes[port * 2][5] == 's') && ((param & 0xffff) == 0x80)) {
    if (analogs[0] < 0x41) {
      return 1;
    }
    if (analogs[2] < 0x41) {
      return 1;
    }
  }
  if ((Device_gPadBytes[port * 2][5] == 's') && ((param & 0xffff) == 0x20)) {
    if (0xbf < analogs[0]) {
      return 1;
    }
    if (0xbf < analogs[2]) {
      return 1;
    }
  }
  if ((Device_gPadBytes[port * 2][5] == 's') && ((param & 0xffff) == 0x10)) {
    if (analogs[3] < 0x41) {
      return 1;
    }
    if (analogs[1] < 0x41) {
      return 1;
    }
  }
  if ((Device_gPadBytes[port * 2][5] == 's') && ((param & 0xffff) == 0x40)) {
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
  if (simVar[2] != 0) {
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
  if ((1 < Replay_ReplayMode) || (GameSetup_gData[3] == 1)) {
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
 * PASS (w40-a5, 22 -> 0).  The +12 was NOT a missing denominator local and NOT an
 * un-reachable cross-jump: it was pure BLOCK ORDER.  The three-way chain must place
 * the `min == max` case BETWEEN the two scaling arms --
 *     if (min < max) {...} else if (min == max) { v = 0; } else {...}
 * -- not last (`else if (min != max) {...} else { v = 0; }`).  With the `v = 0` block
 * physically between the arms, gcc's cross-jump merges ALL THREE `v = 0` sites into
 * that one block (.L800BDA5C) AND lets the second arm's divide FALL INTO the shared
 * div+guard block, so the first arm's `j .L800BDA70` is emitted and its 13-insn
 * duplicate div/guard/mflo tail disappears.  Same statements, same semantics, one
 * arm swapped: catalog "a shared goto-target block belongs at the site that FALLS
 * THROUGH into it" / "case BODIES emit in SOURCE order".  No extra locals -- the SYM's
 * three (min $a1, max $a0, v $v1) are exactly what the body still uses, and fsize 32 /
 * mask $80030000 (ra+s0+s1, 16-byte arg area, ZERO stack locals) confirms there never
 * was a hidden AUTO denominator slot. */
int Device_Analog(u_long param)

{
  int min;
  int max;
  int v;

  if (Device_VerifyType(param >> 0x14) == 0) {
    return 0;
  }
  v = (int)*(u_char *)((int)&gPadinfo[param >> 0x14].data + 4 +
                      (param >> 0x10 & 3) + 2);
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
  else if (min == max) {
    v = 0;
  }
  else {
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
  return v;
}

/* ---- Device_Null__FUl  [DEVICE.CPP:393-394] SLD-VERIFIED ---- */
int Device_Null(u_long param)

{
  return 0;
}

/* end of device.cpp */
