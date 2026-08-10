/* frontend/common/screencontroller.cpp  --  RECONSTRUCTED  (controller-config screen; C++ TU)
 *   8 MEMBER fns of tScreenController : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "../../lib/nfs4_new.h"
#include "screencontroller.h"

/* ScreenController.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes via
   gen_owned_defs: screenControllerConfig + max_fi/max_fidir + the 4 Arrow/Text/NumTexts/Controller
   tables). The manual zero-init versions were a faithfulness gap -- now real binary data. */
int          max_fi = 3750;   /* @0x800528C8 */
int          max_fidir = 250;   /* @0x800528CC */
short        ArrowLocations[55][6] = { 0, 0, 290, 37, 290, 47, 0, 0, 290, 85, 290, 58, 0, 0, 413, 37, 413, 47, 0, 0, 413, 85, 413, 58, 153, 143, 193, 143, 193, 160, 153, 163, 181, 163, 181, 167, 153, 183, 193, 183, 193, 175, 153, 203, 205, 203, 205, 168, 237, 213, 242, 213, 242, 175, 272, 213, 265, 213, 265, 175, 351, 143, 314, 143, 314, 158, 351, 163, 329, 163, 329, 167, 351, 183, 314, 183, 314, 175, 351, 203, 298, 203, 298, 168, 0, 0, 290, 37, 290, 47, 0, 0, 290, 85, 290, 58, 0, 0, 415, 37, 415, 47, 0, 0, 415, 85, 415, 58, 153, 143, 193, 143, 193, 161, 153, 163, 182, 163, 182, 167, 153, 183, 193, 183, 193, 174, 153, 203, 205, 203, 205, 167, 231, 215, 238, 215, 238, 165, 280, 215, 271, 215, 271, 165, 351, 143, 317, 143, 317, 158, 351, 163, 332, 163, 332, 167, 351, 183, 318, 183, 318, 178, 351, 203, 302, 203, 302, 168, 351, 193, 302, 193, 302, 168, 233, 130, 239, 130, 239, 165, 280, 130, 271, 130, 271, 165, 215, 215, 225, 215, 225, 180, 215, 209, 225, 209, 225, 180, 296, 215, 285, 215, 285, 180, 0, 0, 288, 40, 288, 60, 0, 0, 428, 40, 428, 60, 150, 146, 189, 146, 189, 168, 150, 166, 179, 166, 179, 173, 150, 186, 189, 186, 189, 180, 150, 206, 200, 206, 200, 173, 352, 146, 310, 146, 310, 166, 352, 166, 327, 166, 327, 175, 352, 186, 310, 186, 310, 183, 352, 206, 290, 206, 290, 175, 195, 220, 214, 220, 214, 183, 292, 160, 292, 170, 172, 170, 167, 150, 172, 145, 172, 170, 167, 200, 172, 200, 172, 171, 0, 0, 292, 100, 292, 136, 0, 0, 300, 65, 300, 138, 0, 0, 308, 30, 308, 143, 0, 0, 378, 30, 378, 143, 0, 0, 386, 65, 386, 138, 0, 0, 394, 100, 394, 136, 167, 210, 341, 210, 341, 170 };   /* @0x80052104 */
short        TextLocations[80][5] = { 335, 29, 570, 1, 0, 335, 85, 543, 1, 0, 365, 29, 569, 0, 0, 365, 85, 568, 0, 0, 335, 29, 569, 1, 0, 365, 29, 568, 0, 0, 365, 85, 570, 0, 0, 150, 140, 558, 1, 0, 150, 148, 559, 1, 0, 150, 160, 555, 1, 0, 150, 200, 556, 1, 0, 232, 210, 554, 1, 0, 277, 210, 552, 0, 0, 354, 140, 547, 0, 0, 354, 148, 548, 0, 0, 354, 160, 550, 0, 0, 354, 200, 564, 0, 0, 354, 180, 557, 0, 0, 354, 140, 557, 0, 0, 354, 208, 548, 0, 0, 354, 160, 564, 0, 0, 354, 200, 547, 0, 0, 354, 180, 550, 0, 0, 354, 180, 564, 0, 0, 354, 200, 557, 0, 0, 335, 85, 567, 1, 0, 375, 29, 543, 0, 0, 226, 212, 554, 1, 0, 283, 212, 552, 0, 0, 228, 127, 554, 1, 0, 281, 127, 552, 0, 0, 210, 212, 572, 1, 0, 210, 204, 574, 1, 0, 210, 212, 573, 1, 0, 210, 220, 564, 1, 0, 210, 206, 576, 1, 0, 301, 212, 572, 0, 0, 301, 212, 575, 0, 0, 301, 220, 567, 0, 0, 147, 140, 557, 1, 0, 147, 180, 565, 1, 0, 147, 188, 545, 1, 0, 357, 190, 558, 0, 0, 357, 198, 559, 0, 0, 330, 33, 543, 1, 0, 370, 33, 571, 0, 0, 370, 33, 553, 0, 0, 148, 143, 566, 1, 0, 148, 183, 567, 1, 0, 148, 163, 558, 1, 0, 148, 171, 559, 1, 0, 148, 203, 554, 1, 0, 148, 203, 570, 1, 0, 353, 183, 557, 0, 0, 353, 203, 564, 0, 0, 353, 203, 557, 0, 0, 353, 183, 564, 0, 0, 353, 143, 547, 0, 0, 353, 151, 548, 0, 0, 353, 163, 550, 0, 0, 195, 217, 552, 1, 0, 352, 20, 570, 0, 0, 352, 20, 554, 0, 0, 326, 20, 543, 1, 0, 326, 54, 565, 1, 0, 326, 54, 557, 1, 0, 326, 68, 545, 1, 0, 352, 54, 547, 0, 0, 352, 68, 548, 0, 0, 326, 90, 557, 1, 0, 326, 90, 544, 1, 0, 326, 104, 545, 1, 0, 352, 90, 550, 0, 0, 156, 146, 566, 1, 0, 156, 159, 567, 1, 0, 156, 170, 558, 1, 0, 156, 178, 559, 1, 0, 156, 189, 554, 1, 0, 156, 189, 570, 1, 0, 162, 207, 552, 1, 0 };   /* @0x80052398 */
short        NumTexts[7][3] = { 13, 13, 13, 14, 14, 14, 15, 15, 15, 15, 15, 15, 14, 14, 14, 0, 0, 0, 0, 0, 0 };   /* @0x800526b8 */
char         ControllerItemIndex[5][3][16][2] = { 44, 34, 45, 35, 47, 36, 48, 38, 49, 37, 50, -1, 51, 39, 53, 42, 54, 43, 57, 41, 58, -1, 59, 40, 60, 44, 0, 0, 0, 0, 0, 0, 44, 34, 46, 35, 47, 36, 48, 38, 49, 37, 50, -1, 52, 39, 53, 42, 54, 43, 57, 41, 58, -1, 59, 40, 60, 44, 0, 0, 0, 0, 0, 0, 44, 34, 45, 35, 47, 36, 48, 38, 49, 37, 50, -1, 51, 39, 55, 42, 56, 43, 57, 41, 58, -1, 59, 40, 60, 44, 0, 0, 0, 0, 0, 0, 63, 50, 61, 51, 73, 45, 74, 46, 75, 47, 76, -1, 77, -1, 69, 48, 64, 49, 66, -1, 67, 52, 68, -1, 72, 53, 79, 54, 0, 0, 0, 0, 63, 50, 62, 51, 73, 45, 74, 46, 75, 47, 76, -1, 78, -1, 69, 48, 64, 49, 66, -1, 67, 52, 68, -1, 72, 53, 79, 54, 0, 0, 0, 0, 63, 50, 61, 51, 73, 45, 74, 46, 75, 47, 76, -1, 77, -1, 65, 48, 70, 49, 71, -1, 67, 52, 68, -1, 72, 53, 79, 54, 0, 0, 0, 0, 0, 1, 1, 0, 2, 3, 3, 2, 7, 4, 8, -1, 9, 5, 10, 7, 11, 8, 12, 9, 13, 10, 14, -1, 15, 11, 16, 12, 17, 13, 0, 0, 0, 1, 1, 0, 2, 17, 3, 16, 7, 4, 8, -1, 9, 5, 10, 7, 11, 8, 12, 9, 13, 10, 14, -1, 15, 11, 23, 12, 24, 13, 0, 0, 4, 1, 1, 0, 5, 3, 6, 2, 7, 4, 8, -1, 9, 5, 10, 7, 11, 8, 12, 9, 13, 10, 14, -1, 15, 11, 16, 12, 17, 13, 0, 0, 0, 15, 1, 14, 2, 17, 3, 16, 7, 18, 8, -1, 9, 19, 10, 21, 27, 22, 28, 23, 13, 24, 14, -1, 15, 25, 16, 26, 17, 27, 0, 0, 0, 15, 1, 14, 2, 17, 3, 16, 7, 18, 8, -1, 9, 19, 10, 21, 27, 22, 28, 23, 13, 24, 14, -1, 15, 25, 23, 26, 24, 27, 0, 0, 4, 15, 1, 14, 5, 17, 6, 16, 7, 18, 8, -1, 9, 19, 10, 21, 27, 22, 28, 23, 13, 24, 14, -1, 15, 25, 16, 26, 17, 27, 0, 0, 29, 29, 30, 30, 31, 31, 0, 15, 1, 14, 2, 17, 3, 16, 7, 18, 8, -1, 13, 24, 14, -1, 15, 25, 16, 26, 17, 27, 0, 0, 0, 0, 29, 29, 30, 30, 32, 31, 33, -1, 34, -1, 37, 33, 38, -1, 0, 15, 1, 14, 7, 18, 8, -1, 13, 24, 14, -1, 15, 25, 0, 0, 0, 0, 29, 29, 30, 30, 31, 31, 4, 15, 1, 14, 5, 17, 6, 16, 7, 18, 8, -1, 13, 24, 14, -1, 15, 25, 16, 26, 17, 27, 0, 0, 0, 0 };   /* @0x800526e4 */
tScreenControllerConfig *screenControllerConfig;   /* @0x800528d0  (bss(zero)) */
/* fn-static state gen omits -- materialized byte-exact from NFS4.EXE (Offset @0x800520d8,
   fileNames @0x800520e8 -> .rodata strings; flare_intensity = persistent accumulator). */
static unsigned char Offset[7][2] = {{0,0},{133,117},{228,117},{130,117},{130,117},{130,117},{130,117}};
static char *fileNames[7] = {"None","Neg","Whl","Ctrl","aCtrl","aCtrl","aCtrl"};
static int flare_intensity;            /* DrawForeground flare accumulator (persists) */

/* ---- tScreenControllerConfig::ClearActuators  (screencontroller.cpp:41) ---- */
void tScreenControllerConfig::ClearActuators()

{
  (this->fShaker).actuator[0] = '\0';
  (this->fShaker).actuator[1] = '\0';
  return;
}

/* ---- tScreenControllerConfig::SetActuators  (screencontroller.cpp:47) ---- */
void tScreenControllerConfig::SetActuators(int max)

{
  /* MATCH: direct member updates (rather than decompiler byte temporaries)
     expose the common timer store and retail branch layout.  The full-width
     pulse removes a redundant mask; tickValue orders the two independent
     global-address pseudos exactly as retail. */
  int tickValue;
  uint pulse;

  if (this->fResetShakeTimeOut != 0) {
    this->fResetShakeTimeOut = 0;
    (this->fShaker).time = 0x40;
  }
  else {
    if ((this->fShaker).time == '\0') goto SetActuators_clearAndRet;
    (this->fShaker).time = (this->fShaker).time - 1;
  }
  if (*(volatile uchar *)&(this->fShaker).time != '\0') {
    tickValue = ticks;
    pulse = Force_rand_256[tickValue >> 2 & 0xff];   /* @0x80043180 lbu Force_rand_256((ticks>>2)&0xff) */
    (this->fShaker).actuator[1] = (uchar)max;
    (this->fShaker).actuator[0] = (int)(uint)pulse < max;
    return;
  }
SetActuators_clearAndRet:
  this->ClearActuators();
  return;
}

/* ---- Controller_SetRamp  (screencontroller.cpp:791) ---- */
void Controller_SetRamp(void)

{
  /* MATCH (06A, SYM 8c @0x80043250): the recovered semantic locals are `i`
     (SHORT, loop counter, REG s2), `type` (INT), and `config` (INT).
     device/devType/ctrl_type were Ghidra-fabricated and remain inlined. */
  short i;
  int type;
  int config;

  /* MATCH (SLD 794): the oracle re-tests at the TOP of every iteration
     (sll/sra/slti/beqz before the body) -- a plain `for` gets loop-rotated and
     fuses the sign-extend into the address (sra ..,15). */
  i = 0;
  while (1) {
    int one;

    if (i >= 2) break;
    /* MATCH (SLD 797 = ONE source line): a nested ternary -- the if/else-if
       chain lays the `0` arm out inline, the oracle has it LAST. */
    type = frontEnd.controlType[i] == 0x23 ? 0 :
           ((frontEnd.controlType[i] == 0x53 || frontEnd.controlType[i] == 0x73) ? 1 : 2);
    config = frontEnd.controlConfig[i];
    /* MATCH (2026-08-10, 26 -> PASS 83/83): plain literals let LICM hoist the
       store-only 1 into $s4, which adds an $s6 save and two instructions.  `one`
       is only an identity-fence carrier: the empty template retains retail's
       per-iteration `li $v0,1` without emitting code.  The read-only `config`
       fence immediately before it preserves retail's `lbu $v1,866($s0)` then
       `li $v0,1` schedule.  Retail still hoists the comparison constant 1 into
       $s3 across the three calls.  A plain void scheduling barrier and literal
       type changes were neutral and reverted. */
    __asm__("" : : "r"(config));
    one = 1;
    __asm__("" : "=r"(one) : "0"(one));
    frontEnd.rampGas[i] = (char)one;
    frontEnd.rampBrake[i] = (char)one;
    frontEnd.rampSteer[i] = (char)one;
    if (InGame_GetDevice(GetPSXPadValue(mappings[config][0][type],0)) == 1) {
      frontEnd.rampSteer[i] = '\0';
    }
    if (InGame_GetDevice(GetPSXPadValue(mappings[config][2][type],0)) == 1) {
      frontEnd.rampGas[i] = '\0';
    }
    if (InGame_GetDevice(GetPSXPadValue(mappings[config][3][type],0)) == 1) {
      frontEnd.rampBrake[i] = '\0';
    }
    i = i + 1;
  }
  return;
}

/* ---- tScreenControllerConfig::TurnOffShakers  (screencontroller.cpp:70) ---- */
void tScreenControllerConfig::TurnOffShakers()

{
  (this->fShaker).active = '\0';
  return;
}

/* ---- tScreenControllerConfig::ShakeIt  (screencontroller.cpp:76) ---- */
void tScreenControllerConfig::ShakeIt()

{
  int padState;
  int padnum;
  
  padnum = this->player << 4;
  padState = PadGetState(padnum);
  if (padState != 6) {
    if (padState < 4) {
      (this->fShaker).active = '\0';
    }
    this->ClearActuators();
  }
  else if ((this->fShaker).active == '\0') {
    (this->fShaker).active = '\x01';
    PadSetAct(padnum,(this->fShaker).actuator,2);
    PadSetActAlign(padnum,"");
  }
  return;
}

/* ---- tScreenControllerConfig::AnimKeyPoints  (screencontroller.cpp:817) ---- */
short tScreenControllerConfig::AnimKeyPoints(bool forward,bool pt)

{
  short result;

  if (this->fCurrentController == '\x02') {
    if (forward != 0) {
      result = 0x14;
      if (pt != 0) {
        return 0;
      }
    }
    else {
      result = 0x14;
      if (pt != 0) {
        return 0x28;
      }
    }
  }
  else {
    if ((pt & forward) != 0) {
      return 0;
    }
    if ((pt != 0) || (result = 0, forward != 0)) {
      return 0x18;
    }
  }
  return result;
}

/* ---- tScreenControllerConfig::CheckConfigs  (screencontroller.cpp:833) ---- */
void tScreenControllerConfig::CheckConfigs()

{
  int ctrlCur;
  int swapPrev;
  int swapCur;
  int cmp;

  /* MATCH (2026-08-10, 18 -> PASS 187/187; SLD-driven block order,
     oracle 0x80043400..0x800436EC): allocsim exactly reproduced all 10 global
     handouts and proved that the old function-wide `arrowDim` pseudo (p81=$v0)
     could not reach retail's $v1 by any refs/live dial.  IDA's gold annotations
     instead show arm-local controller snapshots in $a0/$a1 and the comparison in
     $v1.  Giving each arm its own `armArrowDim`, then targeting the common text
     tail, lets GCC local-allocate those values and cross-jump-merge the identical
     branch.  In that basin the SLD/IDA [0]-then-[1] controller-store order is exact.
     `short` snapshot types, `bool`/`register` comparison types, and declaration
     permutations were neutral and reverted.
     - top-level guard is `!=` with the CHANGED-controller arm INLINE
       (oracle `beq v1,v0,.L800435B8` jumps AWAY to the unchanged arm);
     - the strcmp-hit "swap in" body is OUT OF LINE at the end (oracle
       `beqz $v0,.L80043570` branches FORWARD past the fTextController block),
       so it must be a `goto` target, not an inline if-body;
     - the two fade arms each compute `slti fArrowFade,0x80` locally and share
       ONE `bnez` at .L80043544 (cross-jump-merged `ChkConfigs_textDone` tail).
     SLD: 835 guard / 837 TurnOffShakers / 840 fAnim / 843 curr==0 /
          853 prev==0 / 869 strcmp / 871-879 fades / 880-883 fTextController /
          888-892 swap-in / 899-926 unchanged arm. */
  if (this->fCurrentController != this->fPrevController) {
    this->TurnOffShakers();
    Front_ResetPSXController(this->player,(uint)(byte)frontEnd.controlConfig[this->player]);
    if (this->fAnim != 0) {
      return;
    }
    if (this->fCurrentController == '\0') {
      if (this->fAnimFade != 0) {
        return;
      }
      this->fFade[0] = 1;
      this->fFadeController[0] = (ushort)(byte)this->fPrevController;
      this->fPrevController = this->fCurrentController;
      return;
    }
    if (this->fPrevController == '\0') {
      int armArrowDim;

      if (this->fAnimFade != 0) {
        return;
      }
      ctrlCur = (byte)this->fCurrentController;
      armArrowDim = this->fArrowFade < 0x80;
      this->fSwap = 1;
      this->fFade[1] = 1;
      this->fFadeController[1] = (ushort)ctrlCur;
      if (armArrowDim) {
        goto ChkConfigs_textDone;
      }
    }
    else {
      int armArrowDim;

      if ((this->CurrentlyLoadedArt != -1) &&
         (cmp = strcmp
                            (fileNames[(byte)this->fCurrentController],
                             fileNames[this->CurrentlyLoadedArt]), cmp == 0)) {
        goto ChkConfigs_swapIn;
      }
      if (this->fAnimFade != 0) {
        return;
      }
      swapPrev = (byte)this->fPrevController;
      swapCur = (byte)this->fCurrentController;
      armArrowDim = this->fArrowFade < 0x80;
      this->fFade[0] = 1;
      this->fSwap = 1;
      this->fFade[1] = 1;
      this->fFadeController[0] = (ushort)swapPrev;
      this->fFadeController[1] = (ushort)swapCur;
      if (armArrowDim) {
        goto ChkConfigs_textDone;
      }
    }
    this->fTextController = this->fCurrentController;
ChkConfigs_textDone:
    if (this->fTextController == 6) {
      this->fTextController = 5;
    }
    this->fPrevController = this->fCurrentController;
    return;
ChkConfigs_swapIn:
    this->fFadeTextOut = 1;
    if (((this->fPrevController == 5) || (this->fPrevController == 3)) &&
       ((this->fCurrentController == 4 || (this->fCurrentController == 6)))) {
      this->SwapInController();
    }
    this->fPrevController = this->fCurrentController;
    return;
  }
  if ((uint)(byte)frontEnd.controlConfig[this->player] == (uint)(byte)this->fPrevConfig) {
    return;
  }
  Front_ResetPSXController(this->player,(uint)(byte)frontEnd.controlConfig[this->player]);
  if ((*(int *)this->fFade == 0) && (this->fAnim == 0)) {
    this->fAnim = 1;
    this->fAnimController = (ushort)(byte)this->fCurrentController;
    /* MATCH: SLD 911 owns BOTH byte loads AND the whole compare chain -> retail
       read the two config bytes INSIDE the if-expression (no line-267/268 locals);
       that alone fixes the config-vs-prevConfig load order. */
    if (((frontEnd.controlConfig[this->player] > this->fPrevConfig) &&
         ((frontEnd.controlConfig[this->player] != 2 || (this->fPrevConfig != 0)))) ||
        ((frontEnd.controlConfig[this->player] == 0 && (this->fPrevConfig == 2)))) {
      this->fAnimStart = this->AnimKeyPoints(true,1);
      this->fAnimStop = this->AnimKeyPoints(true,0);
      this->fAnimStep = 1;   /* MATCH: store the step DIRECTLY per arm (no shared
                                animVal local) -- gcc colors each to $v0 and
                                cross-jump-merges only the `sh $v0,0x86` tail. */
    }
    else {
      this->fAnimStart = this->AnimKeyPoints(false,1);
      this->fAnimStop = this->AnimKeyPoints(false,0);
      this->fAnimStep = -1;
    }
    this->fAnimFrame = this->fAnimStart;
  }
  this->fPrevConfig = frontEnd.controlConfig[this->player];
  return;
}

/* ---- tScreenControllerConfig::SwapInController  (screencontroller.cpp:934) ---- */
void tScreenControllerConfig::SwapInController()

{
  /* MATCH: SLD reports a 24-byte frame with only ra/s0 saved and no locals.
     Passing the table entry directly removes the decompiler's uninitialized
     fileName pseudo and lets GCC rematerialize fileNames after strcmp. */
  if ((this->CurrentlyLoadedArt == -1) ||
     (strcmp(fileNames[(byte)this->fCurrentController],
             fileNames[this->CurrentlyLoadedArt]) != 0)) {
    ::AsyncLoadSwapShapeFile((tScreen *)this,
                             fileNames[(byte)this->fCurrentController]);
    this->CurrentlyLoadedArt = (ushort)(byte)this->fCurrentController;
  }
  return;
}

/* ---- tScreenControllerConfig::SetCurrentController  (screencontroller.cpp:943) ---- */
void tScreenControllerConfig::SetCurrentController(bool firsttime)

{
  bool setmenutonull;
  tInsideBoxMenu *fSetMenu;
  tDialogYesNo *dialog;

  fSetMenu = (tInsideBoxMenu *)0x0;
  dialog = (tDialogYesNo *)this->negconPopUp;
  dialog->string = TextSys_Word(0x20b);
  dialog->yesnowords[0] = 0x20c;
  dialog->yesnowords[1] = 0x20d;
  dialog->fDefault = 1;
  setmenutonull = false;
  if (gPadinfo.buf[(this->player != 0) * 4].nopad != '\0') {
    this->fCurrentController = '\0';
    if (0x7f < this->fArrowFade) {
      this->CurrentlyLoadedArt = 0;
    }
    setmenutonull = true;
    goto SetCurCtrl_menuSetVertHelp;
  }
  switch (gPadinfo.buf[(this->player != 0) * 4].ID) {
  case 0x23:
    {
      bool dialogIdle;
      int choice;

      this->fTimeOutStartTick = 0;
      if (((firsttime == 0) && (this->fCurrentController != '\x02')) &&
         (this->fCurrentController != '\x01')) {
        dialogIdle = false;
        if (dialog->currentlyOn == 0) {
          dialogIdle = dialog->fCurrentlyRunning == 0;
        }
        if (dialogIdle) {
          choice = this->negconChoice;
          if (choice != -1) {
            goto SetCurCtrl_noNegconDialog;
          }
          this->fCurrentController = '\0';
          this->fArrowFade = 0x80;
          this->negconChoice = Run((tDialogInteractive *)dialog);
          {
            char ctrlType = '\x01';
            if (this->negconChoice != 0) {
              ctrlType = '\x02';
            }
            this->fCurrentController = ctrlType;
          }
          {
            tGlobalMenuDefs *menus = menuDefs[0];

            this->negconChoice = choice;
            fSetMenu = &menus->menuControllerNegcon;
          }
          goto SetCurCtrl_menuSetVertHelp;
        }
SetCurCtrl_noNegconDialog:
        {
          setmenutonull = true;
          firsttime = true;
          this->fArrowFade = 0x80;
          this->fCurrentController = '\0';
        }
      }
      else {
        fSetMenu = &menuDefs[0]->menuControllerNegcon;
      }
      goto SetCurCtrl_menuSetVertHelp;
    }
  case 0x41:
    {
      if (PadGetState(-(uint)(this->player != 0) & 0x10) == 6) {
        tGlobalMenuDefs *menus;

        this->fCurrentController = '\x04';
        menus = menuDefs[0];
        this->fTimeOutStartTick = 0;
        fSetMenu = &menus->menuControllerDualShock;
        goto SetCurCtrl_menuSetVertHelp;
      }
      if ((PadGetState((this->player != 0) * 0x10) == 2) ||
          (((this->fTimeOutStartTick != 0) &&
            (PadGetState((this->player != 0) * 0x10) == 1)) &&
           (0x60 < ticks - this->fTimeOutStartTick)) ||
          (this->fCurrentController == '\x03')) {
        setmenutonull = true;
        goto SetCurCtrl_unknown;
      }
      if (this->fTimeOutStartTick == 0) {
        this->fTimeOutStartTick = ticks;
      }
      goto SetCurCtrl_menuSetVertHelp;
    }
  case 0x53:
  case 0x73:
SetCurCtrl_dualShockDetected:
    this->fTimeOutStartTick = 0;
    if (PadGetState((this->player != 0) * 0x10) == 6) {
      this->fCurrentController = '\x06';
      fSetMenu = &menuDefs[0]->menuControllerDualShockAnalog;
    }
    else {
      if (PadGetState((this->player != 0) * 0x10) == 2) {
        this->fCurrentController = '\x05';
        fSetMenu = &menuDefs[0]->menuControllerAnalog;
      }
    }
    break;
  default:
    setmenutonull = true;
SetCurCtrl_unknown:
    this->fTimeOutStartTick = 0;
    this->fCurrentController = '\x03';
    break;
  }
SetCurCtrl_menuSetVertHelp:
  if ((fSetMenu != (tInsideBoxMenu *)0x0) || (setmenutonull)) {
    SetMenu(&menuDefs[0]->itemControllerSettings,firsttime,fSetMenu);
  }
  if (((uint)((byte)this->fCurrentController - 5) < 2U) &&
      ((byte)this->fTextConfig < 2)) {
    (menuDefs[0]->menuControllerConfig).VertHelp = 1;
  }
  else {
    (menuDefs[0]->menuControllerConfig).VertHelp = 0;
  }
  return;
}

/* ---- tScreenControllerConfig::CalcAnimFrame  (screencontroller.cpp:1086) ---- */
int tScreenControllerConfig::CalcAnimFrame(int frame)

{
  /* MATCH: SLD has no `bound` local.  Keeping the low/high reflections as
     separate tails lets GCC cross-jump their subtraction and select $v0 for
     the 0x16/0x38 constants, matching retail's 35-instruction CFG. */
  if (this->fCurrentController == '\x02') {
    if (((frame == 0) || (frame == 0x14)) || (frame == 0x28)) {
      frame = 1;
    }
    else if (frame < 0xb) {
      if (9 < frame) {
        frame = 9;
      }
      frame = frame + 2;
    }
    else {
      if (frame < 0x14) goto CalcAnimFrame_low;
      if (0x1e < frame) goto CalcAnimFrame_high;
      frame = frame + -0x14;
      if (9 < frame) {
        frame = 9;
      }
      frame = frame + 0x10;
      goto CalcAnimFrame_done;
CalcAnimFrame_low:
      frame = 0x16 - frame;
      goto CalcAnimFrame_done;
CalcAnimFrame_high:
      frame = 0x38 - frame;
    }
  }
CalcAnimFrame_done:
  return frame;
}

/* ---- tScreenControllerConfig::ActualDrawController  (screencontroller.cpp:1105) ---- */
void tScreenControllerConfig::ActualDrawController(int frame,int fadelevelmain,int fadeleveltop,
               int shakex,int shakey)

{
  /* MATCH W64 PASS (40->0): keep frame+1 in the call argument, spell the
     flag selects with the retail branch polarity, and lay out the non-art-2
     final draw before the art-2 arrow block. */
  /* SYM (nfs4-f-v3.txt @0x80043b7c) shows NO locals besides the args and one
   * fn-scope `drawFlags` (tDrawShapeExtended); a SECOND `drawFlags` + `i` are
   * declared in a nested block starting at the CurrentlyLoadedArt==2 arm --
   * everything else (scaleIdx/shapeFlags/shapeX/shapeY/ofs/shakeOff/pX/pY)
   * was Ghidra-fabricated. Rewritten as a literal transcription of the raw
   * oracle: two mutually-exclusive first-draw arms (frame!=0||art==1 vs
   * art!=1&&frame==0) that both feed the SAME cross-jump-merged
   * DrawShapeExtended call, then a shared art==2 check that either emits the
   * arrow/fade block or falls through to the final generic-shape draw. */
  /* MATCH (80->40): `offTbl` was invented -- hoisting `Offset` into a local
     materializes `lui/addiu` in the ENTRY block; retail builds the %hi/%lo
     base inside the arm that uses it. */
  tDrawShapeExtended drawFlags;

  if (this->CurrentlyLoadedArt == 0) {
    return;
  }
  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  /* MATCH (W57, 138 @180 insns -> 80 @154 EXACT): all four "0x600 vs 0x601"
     if/else pairs are ONE call with a SELECT on the flags argument -- the
     oracle emits `addiu $a1,$zero,0x600; beqz $s3,L; <ds>; addiu $a1,$zero,
     0x601; L:` and then ONE shared arg setup (w48-a4 value-select-in-a-call-
     arg).  Also `frame + 1` is UNCONDITIONAL: retail's `addiu $a0,$a0,0x1`
     sits in that select branch's DELAY SLOT, so it runs on both paths (the
     Ghidra body had it only in the fadelevelmain!=0 arm -- a real bug). */
  if ((frame != 0) || (this->CurrentlyLoadedArt == 1)) {
    ScaleShapeExtended(frame + 1,fadelevelmain != 0 ? 0x601 : 0x600,
               Offset[this->CurrentlyLoadedArt][0],
               Offset[this->CurrentlyLoadedArt][1],fadelevelmain,0,&drawFlags);
    if (this->CurrentlyLoadedArt == 2) {
      DrawShapeExtended(0,fadelevelmain != 0 ? 0x601 : 0x600,
                 Offset[2][0] + shakex,Offset[2][1] + shakey,fadelevelmain,0,&drawFlags);
    }
  }
  else {
    DrawShapeExtended(1,fadelevelmain != 0 ? 0x601 : 0x600,
               Offset[this->CurrentlyLoadedArt][0] + shakex,
               Offset[this->CurrentlyLoadedArt][1] + shakey,fadelevelmain,0,&drawFlags);
  }
  if (this->CurrentlyLoadedArt != 2) {
    DrawShapeExtended(0,fadeleveltop != 0 ? 0x201 : 0x200,0,0,fadeleveltop,0,&drawFlags);
    return;
  }
  {
    tDrawShapeExtended drawFlags;
    int i;

    drawFlags.tint[0] = CalcFadeVal(0xc8c8c8,this->fArrowFade);
    i = 0x30;
    DrawShapeExtended(0x1a,0x18,0x9e,0x92,0,1,&drawFlags);
    DrawShapeExtended(0x1b,0x18,0x9e,0xa1,0,1,&drawFlags);
    DrawShapeExtended(0x1c,0x18,0x9e,0xac,0,1,&drawFlags);
    DrawShapeExtended(0x1d,0x18,0x9e,0xbb,0,1,&drawFlags);
    do {
      PSXDrawSquare(drawFlags.tint[0],ArrowLocations[i][2] + -2,ArrowLocations[i][3] + -2,5,3);
      i = i + 1;
    } while (i < 0x36);
    return;
  }
}

/* ---- tScreenControllerConfig::DrawController  (screencontroller.cpp:1156) ---- */
/* MATCH: 77 -> 44. `flare_intensity / 4` restores gcc's signed-division bias,
   `__builtin_abs` restores the retail absolute-value branch/copy shape, and
   explicit flare x/Offset temporaries reduce the halo loop to allocation/order
   differences.  2026-08-10: splitting the reused shock boolean into the two
   source-arm values shown by IDA (v7=$a0 for shockMode, v10=$a1 for shockImpact)
   removes 6 diffs with no code-size change. Remaining hotspots are the halo
   argument register order, one float-denominator load order, and the final
   NegCon mode CFG. Falsified in this basin: one shared controller-offset pointer
   (neutral), pointer/read fences (extra scheduling instruction), explicit
   animStep/animRange locals (whole-function s1/s2 swap), and a direct SYM-local
   NegCon rewrite (853/836 instructions); all were reverted. */
void tScreenControllerConfig::DrawController()

{
  tDrawShapeExtended drawFlags;
  short shakex;
  short shakey;
  short maxshakex;
  short maxshakey;
  int fadelevel;
  bool shockModeActive;
  
  shakex = 0;
  shakey = 0;
  maxshakex = 0;
  maxshakey = 0;
  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  shockModeActive = false;
  if ((((this->fCurrentController == '\x04') &&
       ((short)(menuDefs[0]->menuControllerDualShock).fCurrentItem == 0)) ||
      ((this->fCurrentController == '\x06' &&
       ((short)(menuDefs[0]->menuControllerDualShockAnalog).fCurrentItem == 0)))) &&
     ((short)(menuDefs[0]->menuControllerConfig).fCurrentItem == 1)) {
    shockModeActive = true;
  }
  if ((shockModeActive) && (frontEnd.shockMode[this->player] != '\0')) {
    if (this->fShakingItem != 0) {
      this->fShakingItem = 0;
      this->fResetShakeTimeOut = 1;
    }
    this->SetActuators((uint)(byte)frontEnd.shockMode[this->player] << 1);
    maxshakex = ((byte)frontEnd.shockMode[this->player] >> 5) + 2;
    maxshakey = ((byte)frontEnd.shockMode[this->player] >> 6) + 2;
  }
  else {
    bool shockImpactActive;

    shockImpactActive = false;
    if ((((this->fCurrentController == '\x04') &&
         ((short)(menuDefs[0]->menuControllerDualShock).fCurrentItem == 1)) ||
        ((this->fCurrentController == '\x06' &&
         ((short)(menuDefs[0]->menuControllerDualShockAnalog).fCurrentItem == 1)))) &&
       ((short)(menuDefs[0]->menuControllerConfig).fCurrentItem == 1)) {
      shockImpactActive = true;
    }
    if ((shockImpactActive) && ((byte)frontEnd.shockImpact[this->player] != 0)) {
      this->SetActuators((uint)(byte)frontEnd.shockImpact[this->player] << 1);
      maxshakex = ((byte)frontEnd.shockImpact[this->player] >> 5) + 2;
      maxshakey = ((byte)frontEnd.shockImpact[this->player] >> 6) + 2;
      if (this->fShakingItem != 1) {
        this->fShakingItem = 1;
        this->fResetShakeTimeOut = 1;
      }
    }
    else {
      this->fShakingItem = -1;
      this->ClearActuators();
    }
  }
  this->ShakeIt();
  if ((maxshakex != 0) || (maxshakey != 0)) {
    fadelevel = rand();
    shakex = (short)(fadelevel % maxshakex) - (maxshakex >> 1);
    fadelevel = rand();
    shakey = (short)(fadelevel % maxshakey) - (maxshakey >> 1);
  }
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if (this->fSwapShapes.fFile != (char *)0x0) {
    ::UploadSwapShapes((tScreen *)this,0x42);
    return;
  }
  if ((this->fSwapShapes.fFlags & 1) == 0) {
    this->fGotTick = 0;
    return;
  }
  if (((((u_int)((byte)this->fCurrentController - 5) < 2) && (this->fAnim == 0)) &&
      (*(int *)this->fFade == 0)) && (this->fAnimFade == 0)) {
    flare_intensity = flare_intensity + 0xfa;
    if (max_fi <= flare_intensity) {
      max_fi = max_fi + max_fidir;
      if (0x128e < max_fi) {
        max_fi = 0x128e;
        max_fidir = -0x37;
      }
      if (max_fi < 0xea6) {
        max_fi = 0xea6;
        max_fidir = 0x37;
      }
      flare_intensity = max_fi;
    }
  }
  else {
    max_fi = 0xea6;
    flare_intensity = flare_intensity + -0xfa;
    if (flare_intensity < 0) {
      flare_intensity = 0;
    }
  }
  if (0 < flare_intensity) {
    int ii = 0;
    unsigned char (*offsets)[2] = Offset;
    int x = (int)shakex + 0x7e;
    do {
      Flare_2DHalo(x + (uint)offsets[(byte)this->fCurrentController][0],
                 (uint)offsets[(byte)this->fCurrentController][1] +
                   (ii + 0x3f) + (int)shakey,
                 flare_intensity,flare_intensity / 4,0x15);
      ii++;
    } while (ii < 2);
  }
  if ((this->fFade[0] != 0) && (this->fAnimFade == 0)) {
    this->fFade[0] = 0;
    this->fAnimFade = -1;
    this->fAnimFadeController = this->fFadeController[0];
    this->fAnimFadeStart = this->AnimKeyPoints(false,1);
    this->fAnimFadeStop = this->AnimKeyPoints(false,0);
    this->fAnimFadeFrame = this->fAnimFadeStart;
    goto DrawCtrl_ticksUpdate;
  }
  if (this->fFade[1] != 0) {
    if (this->fAnimFade == 0) {
      this->fFade[1] = 0;
      this->fAnimFade = 1;
      this->fAnimFadeController = this->fFadeController[1];
      this->fAnimFadeStart = this->AnimKeyPoints(true,1);
      this->fAnimFadeStop = this->AnimKeyPoints(true,0);
      this->fAnimFadeFrame = this->fAnimFadeStart;
      if (this->fSwap == 0) goto DrawCtrl_ticksUpdate;
      goto DrawCtrl_swapController;
    }
    if (this->fAnimFade == 1) {
      if (this->fFade[0] != 0) goto DrawCtrl_clearFade0;
      this->fFade[1] = 0;
      this->fAnimFade = 1;
      this->fAnimFadeController = this->fFadeController[1];
      this->fAnimFadeStart = this->AnimKeyPoints(true,1);
      this->fAnimFadeStop = this->AnimKeyPoints(true,0);
      this->fAnimFadeFrame = this->fAnimFadeStart;
      if (this->fSwap == 0) goto DrawCtrl_ticksUpdate;
      this->SwapInController();
      this->fGotTick = 0;
      goto DrawCtrl_clearSwap;
    }
  }
  if (this->fFade[0] != 0) {
DrawCtrl_clearFade0:
    this->fFade[0] = 0;
    if (this->fSwap == 0) goto DrawCtrl_ticksUpdate;
    goto DrawCtrl_swapController;
  }
  if ((this->fFade[1] != 0) && (this->fAnimFade == 1)) {
    this->fFade[1] = 0;
    if (this->fSwap == 0) goto DrawCtrl_ticksUpdate;
DrawCtrl_swapController:
    this->SwapInController();
DrawCtrl_clearSwap:
    this->fSwap = 0;
  }
DrawCtrl_ticksUpdate:
  if (this->fAnimFade != 0) {
    if (this->fGotTick == 0) {
      this->fGotTick = 1;
      this->fPlayedInSound = 0;
      this->fStartTick = ticks;
    }
    if (((10 < ticks - this->fStartTick) && (this->fPlayedInSound == 0)) && (this->fAnimFade == 1))
    {
      AudioCmn_PlayFESFX(0xf);
      this->fPlayedInSound = 1;
    }
    this->fAnimFadeFrame = (u_short)this->fAnimFadeStart +
            ((ticks - this->fStartTick) / 6) * (int)this->fAnimFade;
    if (((this->fAnimFadeStop < this->fAnimFadeFrame) && (this->fAnimFade == 1)) ||
       ((this->fAnimFadeFrame < this->fAnimFadeStop && (this->fAnimFade == -1)))) {
      this->fGotTick = 0;
      this->fAnimFadeFrame = this->fAnimFadeStop;
      if (this->fAnimFade == 1) {
        this->fTextTypeOn = 0;
        this->fArrowFade = 0x80;
      }
    }
    fadelevel = __builtin_abs(
        (((int)this->fAnimFadeFrame - (int)this->fAnimFadeStart) * 0x80) /
        ((int)this->fAnimFadeStop - (int)this->fAnimFadeStart));
    fadelevel = fadelevel << 1;
    if (this->SuperFastFadeOut != 0) {
      fadelevel = fadelevel << 1;
    }
    if (0x80 < fadelevel) {
      fadelevel = 0x80;
    }
    if (this->fAnimFade == 1) {
      fadelevel = 0x80 - fadelevel;
    }
    if (this->fGotTick == 0) {
      this->fAnimFade = 0;
    }
    this->ActualDrawController(this->CalcAnimFrame((int)this->fAnimFadeFrame),
                               fadelevel,fadelevel,0,0);
    return;
  }
  if (this->fAnim != 0) {
    if (this->fGotTick == 0) {
      AudioCmn_PlayFESFX(0xf);
      this->fGotTick = 1;
      this->fStartTick = ticks;
    }
    this->fAnimFrame = (u_short)this->fAnimStart +
                       ((ticks - this->fStartTick) / 6) * (int)this->fAnimStep;
    if (((this->fAnimStop < this->fAnimFrame) && (this->fAnimStep == 1)) ||
       ((this->fAnimFrame < this->fAnimStop && (this->fAnimStep == -1)))) {
      this->fAnim = 0;
      this->fGotTick = 0;
      this->fAnimFrame = this->fAnimStop;
    }
    fadelevel = (int)(((float)(ticks - this->fStartTick) /
                       (float)(((int)this->fAnimStep * 6) *
                               ((int)this->fAnimStop - (int)this->fAnimStart))) * 256.0);
    if (0x100 < fadelevel) {
      fadelevel = 0x100;
    }
    if (0x80 < fadelevel) {
      fadelevel = 0x100 - fadelevel;
    }
    fadelevel = fadelevel + 10;
    if (fadelevel < 0) {
      fadelevel = 0;
    }
    if (0x80 < fadelevel) {
      fadelevel = 0x80;
    }
    this->ActualDrawController(this->CalcAnimFrame((int)this->fAnimFrame),0,fadelevel,0,0);
    return;
  }
  if ((u_int)((byte)this->fCurrentController - 5) < 2) {
    char frame = 0;
    if (((menuDefs[0]->itemControllerSteeringRange2).fActive != 0) ||
       ((menuDefs[0]->itemControllerDeadSpot2).fActive != 0)) {
      int player = this->player;
      int range2 = 0x80 - (uint)gPadinfo.buf[player * 4].data.negcon.leftshift;
      int range1 = 0x80 - (uint)gPadinfo.buf[player * 4].data.negcon.buttonII;
      short ret = (short)range2;
      if (((range1 < 0) ? -range1 : range1) >
          ((range2 < 0) ? -range2 : range2)) {
        ret = (short)range1;
      }
      if (ret >= 0) {
        frame = ret / 0xd + 0x1a;
      }
      else {
        frame = -ret / 0xd + 0x24;
      }
    }
    if (((menuDefs[0]->itemControllerSteeringRange1).fActive != 0) ||
       ((menuDefs[0]->itemControllerDeadSpot1).fActive != 0)) {
      int player = this->player;
      int range2 = 0x80 - (uint)gPadinfo.buf[player * 4].data.negcon.buttonI;
      int range1 = 0x80 - (uint)gPadinfo.buf[player * 4].data.negcon.twist;
      short ret = (short)range2;
      if (((range1 < 0) ? -range1 : range1) >
          ((range2 < 0) ? -range2 : range2)) {
        ret = (short)range1;
      }
      if (ret >= 0) {
        frame = ret / 0xd + 0x2e;
      }
      else {
        frame = -ret / 0xd + 0x38;
      }
    }
    if ((frame & 0xff) != 0) {
      /* CORRECTNESS FIX: oracle @0x8004494C reuses the SAME masked a0 (frame&0xff,
       * already materialized for the guard test above) as the shape index, with
       * a1=0x600 literal and a2/a3=Offset[CurrentlyLoadedArt][0/1] -- the prior
       * prior reconstruction passed unrelated decompiler temporaries. */
      DrawShapeExtended(frame & 0xff,0x600,Offset[this->CurrentlyLoadedArt][0],
                 Offset[this->CurrentlyLoadedArt][1],0,0,&drawFlags);
    }
  }
  int frame = (uint)(byte)this->fCurrentController;
  int axisB;
  int modeBase;
  if (((u_int)(frame - 1) < 2) &&
      (((menuDefs[0]->itemControllerJoyRange).fActive != 0 ||
       ((menuDefs[0]->itemControllerCenterPoint).fActive != 0)))) {
    axisB = gPadinfo.buf[this->player * 4].data.negcon.twist - 0x80;
    if (axisB < 0xb) goto DrawCtrl_smallAxis;
    modeBase = 0x1a;
    if (frame == 2) {
      modeBase = 2;
DrawCtrl_calcModeTwo:
      frame = modeBase + (axisB * 0xd) / 0x81;
      goto DrawCtrl_axisDone;
    }
    goto DrawCtrl_calcModeOther;
DrawCtrl_smallAxis:
    modeBase = 0x23;
    if (axisB < -10) {
      axisB = -axisB;
      if (frame != 2) goto DrawCtrl_calcModeOther;
      modeBase = 0x10;
      goto DrawCtrl_calcModeTwo;
    }
    frame = (uint)(frame == 2);
    goto DrawCtrl_axisDone;
DrawCtrl_calcModeOther:
    frame = modeBase + (axisB << 3) / 0x81;
DrawCtrl_axisDone:
    this->ActualDrawController(frame,0,0,0,0);
    return;
  }
  if (this->fCurrentController != '\0') {
    this->ActualDrawController(0,0,0,(int)shakex,(int)shakey);
    return;
  }
  this->fTextController = '\0';
  this->fArrowFade = 0x80;
  this->fTextTypeOn = 0;
  return;
}

/* ---- tScreenControllerConfig::HorzVertLine  (screencontroller.cpp:1518) ---- */
void tScreenControllerConfig::HorzVertLine(short *ArrowLoc,bool type)

{
  int startx;
  int starty;
  int endx;
  int endy;
  int LineCol;
  
  startx = (int)ArrowLoc[2];
  starty = (int)ArrowLoc[3];
  endx = (int)ArrowLoc[4];
  endy = (int)ArrowLoc[5];
  if (type) {
    startx = (int)*ArrowLoc;
    starty = (int)ArrowLoc[1];
    endx = (int)ArrowLoc[2];
    endy = (int)ArrowLoc[3];
  }
  LineCol = 0x1e1e1e;
  if (0 < this->fArrowFadeDir) {
    LineCol = CalcFadeVal(0x1e1e1e,this->fArrowFade);
  }
  if (startx == endx) {
    int extrabitoff;
    int extrabit;
    short length;

    extrabitoff = 0;
    if (!type) {
      extrabitoff = endy >= starty;
    }
    extrabit = 0;
    if (type == true) {
      extrabit = endy >= starty;
    }
    length = (short)(endy - starty);
    if (this->mult != 0x40) {
      int brightlength;

      brightlength = ((int)length * (int)this->mult) >> 6;
      length = (short)brightlength;
      PSXDrawTransSquare(0xffffff,endx,
          endy - ((short)brightlength - ((short)brightlength >> 3) -
                  extrabitoff + extrabit),
          2,-((short)brightlength >> 3),2);
    }
    PSXDrawTransSquare(LineCol,endx,endy + extrabit,2,
                       -((int)length - extrabitoff + extrabit),2);
  }
  else {
    int extrabit;
    short length;

    extrabit = (endx >= startx) * 2;
    length = (short)(endx - startx);
    if (this->mult != 0x40) {
      length = (short)(((int)length * (int)this->mult) >> 6);
      if (extrabit < ((length < 0) ? -(int)length : (int)length)) {
        int brightlength;

        brightlength = (int)length >> 3;
        PSXDrawTransSquare(0xffffff,
            endx - ((int)length - brightlength) + extrabit,starty,
            -(brightlength + extrabit),1,2);
      }
    }
    if (extrabit < ((length < 0) ? -(int)length : (int)length)) {
      PSXDrawTransSquare(LineCol,endx + extrabit,endy,
                         -((int)length + extrabit),1,2);
    }
  }
  return;
}

/* ---- tScreenControllerConfig::DrawArrow  (screencontroller.cpp:1571) ---- */
void tScreenControllerConfig::DrawArrow(short *ArrowLoc)

{
  /* MATCH (06A): the SYM 8c block for this fn declares NO locals at all (only the
     `this`/`ArrowLoc` REGPARMs), so every intermediate is the FIELD itself --
     `this->mult` is stored and then READ BACK (cse forwards the stored register,
     giving the oracle's `sh` before the `sll/bgez` sign test instead of our
     sunk-into-the-delay-slot store off a separate `fadeCalc` int). */
  short clampVal;
  int hi;
  this->mult = 0;
  settrans(1);
  /* MATCH: the oracle passes the literal mode (a0 = 0 here, a0 = 1 at the tail);
     the decompiler had aliased them to the ArrowLoc pointer. */
  FeDraw_SetABRMode(0);
  if (*ArrowLoc != 0) {
    if (this->fArrowFadeDir < 0) {
      this->mult = (short)(0x40 - (uint)(ushort)this->fArrowFade);
      if (this->mult < 0) {
        this->mult = 0;
      }
    }
    else {
      this->mult = 0x40;
    }
    this->HorzVertLine(ArrowLoc,true);
  }
  if (this->fArrowFadeDir < 0) {
    this->mult = (short)(0x80 - (uint)(ushort)this->fArrowFade);
    hi = this->mult;
    /* MATCH (SLD 1593 = ONE source line): the >=0x40 arm is OUT OF LINE (oracle
       `beqz` jumps straight to the store with 0x40 in its delay slot) and the
       low clamp is a plain if/else whose `clampVal = this->mult` rides the
       `bgez` slot (oracle `addu v0,v1,zero` = a copy of the just-stored value). */
    if (0 < hi) {
      if (0x40 <= hi) { clampVal = 0x40; goto DA_store; }
    }
    /* MATCH (W57, 12->10): PRE-SET THE DEFAULT BEFORE THE TEST (w47) -- the
       oracle's `bgez $a0,.L..E08` carries `addu $v0,$v1,$zero` in its delay
       slot with `addu $v0,$zero,$zero` as the FALL-THROUGH, i.e. the copy is
       the default assigned before the guard, not an if/else arm (the if/else
       form emits the inverted `bltz`).  RESIDUAL 10 = the two `0x40` arms
       cross-jump-merge into ONE pseudo (oracle rematerializes `addiu
       $v0,$zero,0x40` in BOTH branch delay slots), which lengthens the
       constant's live range past the `slti` result and costs it $v0 -> $a1.
       De-merge attempts (void fence in either arm, &&-nogoto, nested-nogoto,
       int clampVal, decl-order swap, clampVal=(short)hi) all measured WORSE
       (14/24/20/25/10/28) -- next angle = reorg dual-slot duplication
       (w44 compare-operand-order row) or qtytrace. */
    clampVal = this->mult;
    if (hi < 0) {
      clampVal = 0;
    }
  }
  else {
    /* MATCH: the 0x40 default is the ELSE ARM (it rides the `bgez` delay slot);
       a pre-set before the if hoists it and kills the in-arm rematerialization. */
    clampVal = 0x40;
  }
DA_store:
  this->mult = clampVal;
  this->HorzVertLine(ArrowLoc,false);
  FeDraw_SetABRMode(1);
  settrans(0);
  return;
}

/* ---- tScreenControllerConfig::DrawBackground  (screencontroller.cpp:1608) ---- */
void tScreenControllerConfig::DrawBackground()

{
  /* MATCH (W57, 58->36, count 145->137 EXACT): the SYM 8c block lists only
     `fade` ($s1), an inlined tOptionsMenu `this` ($a0) and `i` ($s0) -- every
     other local here was a Ghidra invention costing a callee-saved reg + frame
     bytes (06A).  animStart/animStop/transDone/trans2 inlined; and the loop's
     scaleIdx/shapeFlags/shapeX/shapeY were UNINITIALISED READS (real bug) --
     the oracle's `addiu $a0,$s0,0xA` + three `addu ?,$zero,$zero` shows the
     call is ScaleShapeExtended(i + 10, 0, 0, 0, fade, 0, NULL). */
  short fade;
  int i;

  /* MATCH (36->27): the SYM's inlined tOptionsMenu `this` ($a0) is a real
     pointer -- the oracle materializes `addiu $a0,$v0,11116` and then reads
     fScreenFade by DISPLACEMENT `lw $v0,116($a0)`; the folded
     `menuDefs[0]->menuControllerConfig.fScreenFade` form emits one fused load.
     Only the fade read goes through it (routing the two TransitionIsFinished
     calls through `om` too measured 48 @135 insns). */
  /* MATCH (W64, 27->PASS): TransitionIsFinished is a normalized 0/1 result,
     but its ABI-neutral declaration is `void *`.  Expressing the `!= true`
     test as the corresponding integer XOR restores retail's immediate `xori`;
     a pointer comparison made gcc retain constant 1 in $s1 across calls,
     displaced `fade` to $s2, and added an unnecessary saved register. */
  tOptionsMenu *om = &menuDefs[0]->menuControllerConfig;
  fade = (short)(om->fScreenFade >> 1);
  if (0x80 < fade) {
    fade = 0x80;
  }
  if ((this->fTransitionedIn == 0) &&
     (::TransitionIsFinished(&menuDefs[0]->menuControllerConfig) != (void *)0x0)) {
    this->fTransitionedIn = 1;
  }
  if (((fade < 0x81) && (this->fTransitioningIn == 0)) && (this->fCurrentController != '\0')
     ) {
    this->fAnimFade = 1;
    this->fAnimFadeStart = this->AnimKeyPoints(true,1);
    this->fAnimFadeStop = this->AnimKeyPoints(true,0);
    this->fTransitioningIn = 1;
    this->fAnimFadeFrame = this->fAnimFadeStart;
    this->fAnimFadeController = (ushort)(byte)this->fCurrentController;
  }
  if ((((int)(long)::TransitionIsFinished(&menuDefs[0]->menuControllerConfig) ^ 1) != 0) &&
      (this->fTransitionedIn != 0)) {
    if (this->fTransitioningOut != 0) goto ForceVbl_drawCtrlCheck;
    if (this->fCurrentController != '\0') {
      this->fAnimFade = -1;
      this->fAnimFadeStart = this->AnimKeyPoints(false,1);
      this->fAnimFadeStop = this->AnimKeyPoints(false,0);
      this->fTransitioningOut = 1;
      this->SuperFastFadeOut = 1;
      this->fAnimFadeFrame = this->fAnimFadeStart;
      this->fAnimFadeController = (ushort)(byte)this->fCurrentController;
    }
  }
  if (this->fTransitioningOut == 0) {
    this->SetCurrentController(false);
    this->CheckConfigs();
  }
ForceVbl_drawCtrlCheck:
  if (((this->fAnimFade != 0) || (this->fTransitioningOut == 0)) && (this->fTransitioningIn != 0)) {
    this->DrawController();
  }
  i = 0;
  do {
    ScaleShapeExtended(i + 10,0,0,0,(int)fade,0,(tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 0xc);
  return;
}

/* ---- tScreenControllerConfig::DrawForeground  (screencontroller.cpp:1659) ---- */
/* W63 (2026-08-10): 167 diffs -> PASS (410/410 insns).  SLD/SYM and the IDA
   register annotations exposed five decompiler artifacts: fArrowFadeDir is
   written directly in the two arms (after testing its old value); string1/2
   are addressed as arrays rather than through invented pointer locals; the
   text-loop index starts after the first fade call; the embedded negcon dialog
   has one shared base pointer; and both pixel widths are explicit temporaries,
   with the square width selected inside the call expression.  A full-width
   text length plus a short candidate restores the sl/k handoff; declaring the
   copy destination, counter, and source in retail order seals the last
   scheduling difference without an assembly workaround. */
void tScreenControllerConfig::DrawForeground()

{
  short TL [5];
  short i;
  short j;
  char string1 [40];
  char string2 [40];
  char brightstring [2];
  char *astringpointer;
  int brightX;
  short sl;
  short fade;

  this->SetCurrentController(false);
  this->CheckConfigs();
  brightstring[1] = '\0';
  if ((this->fFadeTextOut == 0) && (this->fAnim == 0) &&
      (this->fAnimFade == 0) && (*(int *)this->fFade == 0) &&
      (::TransitionIsFinished(&menuDefs[0]->menuControllerConfig) != 0) &&
      (this->fTransitioningOut == 0)) {
    if (0 < this->fArrowFadeDir) {
      this->fTextTypeOn = 0;
    }
    this->fArrowFadeDir = -8;
  }
  else {
    this->fArrowFadeDir = 8;
  }
  this->fArrowFade = this->fArrowFade + this->fArrowFadeDir;
  if (this->fArrowFade < 0) {
    this->fArrowFade = 0;
  }
  if (0x7f < this->fArrowFade) {
    char controller = this->fCurrentController;

    this->fArrowFade = 0x80;
    this->fTextController = controller;
    if (controller == '\x06') {
      this->fTextController = '\x05';
    }
    char config = frontEnd.controlConfig[this->player];
    this->fFadeTextOut = 0;
    this->fTextConfig = config;
  }
  else {
    if (this->fArrowFade == 0) {
      this->fTextTypeOn = this->fTextTypeOn + 1;
    }
    if (100 < this->fTextTypeOn) {
      this->fTextTypeOn = 100;
    }
    if (this->fArrowFade != 0) {
      FETextRender_SetABR(1,true);
    }
    {
      if (this->fTextController != '\0') {
        int ColText;
        int ColText2;

        ColText = kRGBVals[(byte)textDefinitions[0xb][3]];
        ColText2 = CalcFadeVal(ColText,0xffffff,100,(int)this->fArrowFade);
        i = 0;
        ColText = CalcFadeVal(ColText,(int)this->fArrowFade);
        for (; i < NumTexts[(byte)this->fTextController - 1][(byte)this->fTextConfig]; i++) {
          int TextIndex = (signed char)ControllerItemIndex[(byte)this->fTextController - 1]
                                                          [(byte)this->fTextConfig][i][0];

          if (TextIndex != -1) {
            short *pTL = TL;
            int n = 4;
            short *pTextLoc = TextLocations[TextIndex];

            do {
              *pTL++ = *pTextLoc++;
              n--;
            } while (n != -1);
            int k;
            int textLength = strlen(TextSys_Word((int)TL[2]));
            sl = (short)textLength;
            short candidate = this->fTextTypeOn;
            if ((short)textLength < candidate) {
              candidate = textLength;
            }
            k = candidate;
            if (this->fTextTypeOn < (short)textLength) {
              int howfarout;

              sprintf(string2,TextSys_Word((int)TL[2]));
              if (TL[3] == 0) {
                j = 0;
                if (j < this->fTextTypeOn) {
                  do {
                    if (j >= (short)strlen(string2)) {
                      break;
                    }
                    string1[j] = string2[j];
                    j++;
                  } while (j < this->fTextTypeOn);
                }
                string1[j] = '\0';
                brightstring[0] = string1[j - 1];
              }
              else {
                howfarout = textLength - k;
                for (j = howfarout; j < sl; j++) {
                  string1[j - (sl - k)] = string2[j];
                }
                string1[j - (sl - k)] = '\0';
                brightstring[0] = string1[0];
              }
              FETextRender_SetFont(0);
              brightX = TL[0];
              int textWidth = textpixels(string1) - strlen(string1);
              if (TL[3] == 1) {
                brightX = brightX - textWidth;
              }
              else {
                brightX = brightX + textWidth;
              }
              FETextRender_FullTextRGB(brightstring,(short)brightX,TL[1],ColText2,
                                       '\0',(ushort)(TL[3] == 0));
              astringpointer = string1;
            }
            else {
              astringpointer = TextSys_Word((int)TL[2]);
            }
            FETextRender_FullTextRGB(astringpointer,TL[0],TL[1],ColText,'\0',TL[3]);
            int squareWidth = textpixels(astringpointer) - strlen(astringpointer);
            PSXDrawSquare(0,(int)TL[0],(int)TL[1],
                          (TL[3] != 0) ? -squareWidth : squareWidth,7);
          }
        }
      }
    }
    for (i = 0;
         i < NumTexts[(byte)this->fTextController - 1][(byte)this->fTextConfig];
         i++) {
      int TextIndex = (byte)this->fTextController - 1;
      bool flag = false;
      tDialogYesNo *dialog = (tDialogYesNo *)this->negconPopUp;

      if (dialog->currentlyOn == 0) {
        flag = dialog->fCurrentlyRunning == 0;
      }
      if (flag && (TextIndex >= 0)) {
        TextIndex = (signed char)ControllerItemIndex[TextIndex][(byte)this->fTextConfig][i][1];
        if (TextIndex != -1) {
          this->DrawArrow(ArrowLocations[TextIndex]);
        }
      }
    }
    FETextRender_SetABR(0,false);
    fade = (short)((menuDefs[0]->menuControllerConfig).fScreenFade >> 1);
    if (0x80 < fade) {
      fade = 0x80;
    }
    for (i = 0; i < 2; i++) {
      ScaleShapeExtended(i + 0x16,0,0,0,(int)fade,0,
                         (tDrawShapeExtended *)0x0);
    }
  }
  return;
}

/* ---- tScreenControllerConfig::GetShapeInfo  (screencontroller.cpp:1819) ---- */
void tScreenControllerConfig::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  numPermShapes = 0x18;
  *permFileName = "zpCtrl";
  numSwapShapes = 0x42;
  *swapFileName = "aCtrl";
  return;
}

/* ---- tScreenControllerConfig::Initialize  (screencontroller.cpp:1831) ---- */
void tScreenControllerConfig::Initialize()

{
  uint b;
  char mode;

  (this->fShaker).active = '\0';
  this->TurnOffShakers();
  this->ClearActuators();
  this->fResetShakeTimeOut = 1;
  this->fShakingItem = -1;
  b = (uint)(byte)FEApp->fInputPlayer;
  this->fTimeOutStartTick = 0;
  this->CurrentlyLoadedArt = -1;
  this->negconChoice = -1;
  this->player = b;
  this->Initialize();
  this->fCurrentController = '\0';
  SetMenu(&menuDefs[0]->itemControllerSettings,true,(tInsideBoxMenu *)0x0);
  this->SetCurrentController(true);
  this->SwapInController();
  this->fPrevController = this->fCurrentController;
  if (0x7f < this->fArrowFade) {
    this->fTextController = this->fCurrentController;
  }
  if (this->fTextController == '\x06') {
    this->fTextController = '\x05';
  }
  mode = frontEnd.controlConfig[this->player];
  this->fPrevConfig = mode;
  this->fTextConfig = mode;
  this->CheckConfigs();
  this->fGotTick = 0;
  this->fAnim = 0;
  this->fAnimFade = 0;
  this->fFade[0] = 0;
  this->fFade[1] = 0;
  this->fArrowFade = 0x80;
  this->fArrowFadeDir = 0;
  this->fTextTypeOn = 0;
  this->fPlayedInSound = 0;
  this->fTransitionedIn = 0;
  this->fTransitioningIn = 0;
  this->fTransitioningOut = 0;
  this->SuperFastFadeOut = 0;
  return;
}

/* ---- tScreenControllerConfig::Cleanup  (screencontroller.cpp:1881) ---- */
void tScreenControllerConfig::Cleanup()

{
  
  this->ClearActuators();
  this->TurnOffShakers();
  PadStartCom();
  this->Cleanup();
  return;
}

/* ---- tScreenControllerConfig::tScreenControllerConfig  (screencontroller.cpp:1889) ---- */
tScreenControllerConfig::tScreenControllerConfig()
  /* base tScreen is implicit; negconPopUp is explicitly constructed below so
     the derived vptr store can precede its constructor, as in retail. */
{
  this->_vf = (__vtbl_ptr_type (*)[10])tScreenControllerConfig_vtable;   /* vptr @0x60 */
  new ((tDialogYesNo *)this->negconPopUp) tDialogYesNo();
  this->fGotTick = 0;
  this->fAnim = 0;
  this->fFade[1] = 0;
  this->fFade[0] = 0;
  this->player = 0;
  return;
}

/* ---- tScreenControllerConfig::GetHelpText  (screencontroller.cpp:1897) ---- */
int tScreenControllerConfig::GetHelpText()

{
  /* MATCH: a real switch, NOT an if-chain.  The oracle's dispatch is gcc-2.8's
     balance_case_nodes TREE over 3 case nodes {1},{2},{5..6} (root == 2, then
     slti 3 / slti 7 / slti 5) with the case BODIES in SOURCE order
     (5|6, 1, 2) and the default -1 as a shared funnel block.  Switching on the
     field directly (int-promoted) also drops the `andi 0xff` a u_char local
     re-mask emitted.  [SLD 1897=switch, 1899/1903/1906=case bodies, 1912=-1] */
  switch (this->fCurrentController) {
  case 5:
  case 6:
    return 0x218;
  case 1:
    return 0x219;
  case 2:
    return 0x21a;
  default:
    return -1;
  }
}

/* ---- ___23tScreenControllerConfig  (screencontroller.cpp:177) ----
 * MATCH 2026-07-11 (dtor-surgery): tScreenControllerConfig::~tScreenControllerConfig() is now
 * declared INLINE-in-class (nfs4_types.h) with an empty body, so gcc fully expands/collapses it
 * at every implicit member/base-teardown call site (e.g. tAllScreens::~tAllScreens(), which the
 * oracle shows INLINING this class's own negconPopUp + base(tScreen) teardown directly rather
 * than calling this symbol -- ___11tAllScreens FAIL 104->PASS via this surgery).
 *
 * The class's OWN standalone out-of-line destructor symbol (___23tScreenControllerConfig) STILL
 * genuinely exists in the retail binary (used elsewhere, e.g. the manually-materialized vtable's
 * dtor slot in vtables_tscreen2.cpp needs a real, addressable function at this exact VA/name) --
 * gcc-2.8/CC1PLPSX has NO mechanism to emit both an inlined-everywhere copy AND a real named
 * out-of-line copy from ONE C++ destructor declaration (empirically verified: an inline dtor
 * NEVER produces a standalone symbol under this compiler, at any call site, in any TU -- see the
 * dtor-surgery session notes). So the standalone symbol is TRANSCRIBED VERBATIM as a file-scope
 * __asm__ (same technique as blockmove/_patch_gte): this is BYTE-IDENTICAL to what the old
 * out-of-line C++ definition (`tScreenControllerConfig::~tScreenControllerConfig(){ return; }`)
 * used to compile to -- confirmed PASS (17 insns) before AND after this transcription; only the
 * MECHANISM producing those bytes changed (compiler-generated -> hand-transcribed), the bytes
 * did not. Destructs the negconPopUp member (offset 0xB8, tDialogYesNo -> collapses to
 * ___7tScreen) then forwards to the tScreen base (in_chrg propagated via $s1). */
#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as */
    "\t.globl ___23tScreenControllerConfig\n"
    "___23tScreenControllerConfig:\n"
    "\taddiu $sp, $sp, -32\n"
    "\tsw    $s0, 16($sp)\n"
    "\taddu  $s0, $a0, $zero\n"
    "\tsw    $s1, 20($sp)\n"
    "\taddu  $s1, $a1, $zero\n"
    "\taddiu $a0, $s0, 184\n"     /* &this->negconPopUp (+0xB8) */
    "\tsw    $ra, 24($sp)\n"
    "\tjal   ___7tScreen\n"
    "\t addiu $a1, $zero, 2\n"     /* delay slot: member sub-object, not in charge */
    "\taddu  $a0, $s0, $zero\n"
    "\tjal   ___7tScreen\n"        /* base tScreen part */
    "\t addu  $a1, $s1, $zero\n"   /* delay slot: forward the original in_chrg */
    "\tlw    $ra, 24($sp)\n"
    "\tlw    $s1, 20($sp)\n"
    "\tlw    $s0, 16($sp)\n"
    "\tjr    $ra\n"
    "\t addiu $sp, $sp, 32\n"
    "\t.set pop\n"
    "\t.set\treorder\n"  /* maspsx tracks .set linearly (no push/pop): restore nop-insertion for the rest of the file (gcc2.8 HOISTS toplevel asm above all fns) */);
#endif

/* end of screencontroller.cpp */
