/* frontend/common/screencontroller.cpp  --  RECONSTRUCTED  (controller-config screen; C++ TU)
 *   8 MEMBER fns of tScreenController : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
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
  uchar curtime;
  byte pulse;
  uchar newtime;
  
  newtime = '@';
  if (this->fResetShakeTimeOut == 0) {
    curtime = (this->fShaker).time;
    newtime = curtime + 0xff;
    if (curtime == '\0') goto SetActuators_clearAndRet;
  }
  else {
    this->fResetShakeTimeOut = 0;
  }
  (this->fShaker).time = newtime;
  if ((this->fShaker).time != '\0') {
    pulse = ""[ticks >> 2 & 0xff];
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
  int device;
  int devType;
  int config;
  int type_idx;
  short i;
  short p;
  short ctrl_type;
  byte config_idx;
  
  for (p = 0; p < 2; p = p + 1) {
    ctrl_type = frontEnd.controlType[p];
    if (ctrl_type == 0x23) {
      type_idx = 0;
    }
    else if ((ctrl_type == 0x53) || (ctrl_type == 0x73)) {
      type_idx = 1;
    }
    else {
      type_idx = 2;
    }
    config_idx = frontEnd.controlConfig[p];
    frontEnd.rampGas[p] = '\x01';
    frontEnd.rampBrake[p] = '\x01';
    frontEnd.rampSteer[p] = '\x01';
    device = GetPSXPadValue(mappings[config_idx][0][type_idx],0);
    devType = InGame_GetDevice(device);
    if (devType == 1) {
      frontEnd.rampSteer[p] = '\0';
    }
    devType = GetPSXPadValue(mappings[config_idx][2][type_idx],0);
    devType = InGame_GetDevice(devType);
    if (devType == 1) {
      frontEnd.rampGas[p] = '\0';
    }
    devType = GetPSXPadValue(mappings[config_idx][3][type_idx],0);
    devType = InGame_GetDevice(devType);
    if (devType == 1) {
      frontEnd.rampBrake[p] = '\0';
    }
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
  if (padState == 6) {
    if ((this->fShaker).active == '\0') {
      (this->fShaker).active = '\x01';
      PadSetAct(padnum,(this->fShaker).actuator,2);
      PadSetActAlign(padnum,"");
    }
  }
  else {
    if (padState < 4) {
      (this->fShaker).active = '\0';
    }
    this->ClearActuators();
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
  byte config;
  byte prevConfig;
  short animVal;
  int cmp;
  
  if (this->fCurrentController == this->fPrevController) {
    if ((uint)(byte)frontEnd.controlConfig[this->player] == (uint)(byte)this->fPrevConfig) {
      return;
    }
    Front_ResetPSXController(this->player,(uint)(byte)frontEnd.controlConfig[this->player]);
    if ((*(int *)this->fFade == 0) && (this->fAnim == 0)) {
      this->fAnim = 1;
      this->fAnimController = (ushort)(byte)this->fCurrentController;
      config = frontEnd.controlConfig[this->player];
      prevConfig = this->fPrevConfig;
      if (((prevConfig < config) && ((config != 2 || (prevConfig != 0)))) || ((config == 0 && (prevConfig == 2)))) {
        animVal = this->AnimKeyPoints(true,1);
        this->fAnimStart = animVal;
        animVal = this->AnimKeyPoints(true,0);
        this->fAnimStop = animVal;
        animVal = 1;
      }
      else {
        animVal = this->AnimKeyPoints(false,1);
        this->fAnimStart = animVal;
        animVal = this->AnimKeyPoints(false,0);
        this->fAnimStop = animVal;
        animVal = -1;
      }
      this->fAnimStep = animVal;
      this->fAnimFrame = this->fAnimStart;
    }
    this->fPrevConfig = frontEnd.controlConfig[this->player];
    return;
  }
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
    if (this->fAnimFade != 0) {
      return;
    }
    config = this->fCurrentController;
    animVal = this->fArrowFade;
    this->fSwap = 1;
    this->fFade[1] = 1;
    this->fFadeController[1] = (ushort)config;
  }
  else {
    if ((this->CurrentlyLoadedArt != -1) &&
       (cmp = strcmp
                          (fileNames[(byte)this->fCurrentController],
                           fileNames[this->CurrentlyLoadedArt]), cmp == 0)) {
      this->fFadeTextOut = 1;
      if (((this->fPrevController == '\x05') || (this->fPrevController == '\x03')) &&
         ((this->fCurrentController == '\x04' || (this->fCurrentController == '\x06')))) {
        this->SwapInController();
      }
      goto ChkConfigs_savePrevCtrl;
    }
    if (this->fAnimFade != 0) {
      return;
    }
    config = this->fPrevController;
    prevConfig = this->fCurrentController;
    animVal = this->fArrowFade;
    this->fFade[0] = 1;
    this->fSwap = 1;
    this->fFade[1] = 1;
    this->fFadeController[0] = (ushort)config;
    this->fFadeController[1] = (ushort)prevConfig;
  }
  if (0x7f < animVal) {
    this->fTextController = this->fCurrentController;
  }
  if (this->fTextController == '\x06') {
    this->fTextController = '\x05';
  }
ChkConfigs_savePrevCtrl:
  this->fPrevController = this->fCurrentController;
  return;
}

/* ---- tScreenControllerConfig::SwapInController  (screencontroller.cpp:934) ---- */
void tScreenControllerConfig::SwapInController()

{
  int cmp;
  char *fileName;
  
  if ((this->CurrentlyLoadedArt == -1) ||
     (cmp = strcmp(fileNames[(byte)this->fCurrentController],
                         fileNames[this->CurrentlyLoadedArt]), cmp != 0)) {
    AsyncLoadSwapShapeFile(&this->_base_tScreen,fileName);
    this->CurrentlyLoadedArt = (ushort)(byte)this->fCurrentController;
  }
  return;
}

/* ---- tScreenControllerConfig::SetCurrentController  (screencontroller.cpp:943) ---- */
void tScreenControllerConfig::SetCurrentController(bool firsttime)

{
  byte padID;
  bool dialogIdle;
  uint playerMask;
  bool setmenutonull;
  tGlobalMenuDefs *menus;
  short choice;
  char *word;
  uint padOffset;
  int padState;
  char ctrlType;
  tInsideBoxMenu *fSetMenu;
  int firsttimeU;
  
  firsttimeU = firsttime;
  fSetMenu = (tInsideBoxMenu *)0x0;
  word = TextSys_Word(0x20b);
  (this->negconPopUp)._base_tDialogInteractive._base_tDialogMessageString.string = word;
  (this->negconPopUp).yesnowords[0] = 0x20c;
  (this->negconPopUp).yesnowords[1] = 0x20d;
  (this->negconPopUp)._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase.fDefault = 1;
  playerMask = -(uint)(this->player != 0);
  padOffset = playerMask & 0x20;
  setmenutonull = false;
  if ((&gPadinfo.buf[0].nopad)[padOffset] != '\0') {
    this->fCurrentController = '\0';
    if (0x7f < this->fArrowFade) {
      this->CurrentlyLoadedArt = 0;
    }
    setmenutonull = true;
    goto SetCurCtrl_menuSetVertHelp;
  }
  padID = (&gPadinfo.buf[0].ID)[padOffset];
  if (padID == 0x53) {
SetCurCtrl_dualShockDetected:
    this->fTimeOutStartTick = 0;
    padState = PadGetState((uint)(this->player != 0) << 4);
    if (padState == 6) {
      this->fCurrentController = '\x06';
      fSetMenu = &menuDefs[0]->menuControllerDualShockAnalog;
    }
    else {
      padState = PadGetState((uint)(this->player != 0) << 4);
      if (padState == 2) {
        this->fCurrentController = '\x05';
        fSetMenu = &menuDefs[0]->menuControllerAnalog;
      }
    }
  }
  else {
    if (padID < 0x54) {
      if (padID == 0x23) {
        this->fTimeOutStartTick = 0;
        if (((firsttimeU == 0) && (this->fCurrentController != '\x02')) &&
           (this->fCurrentController != '\x01')) {
          dialogIdle = false;
          if ((this->negconPopUp)._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase.currentlyOn ==
              0) {
            dialogIdle = (this->negconPopUp)._base_tDialogInteractive.fCurrentlyRunning == 0;
          }
          if ((dialogIdle) && (this->negconChoice == -1)) {
            this->fCurrentController = '\0';
            this->fArrowFade = 0x80;
            choice = Run(&(this->negconPopUp)._base_tDialogInteractive);
            this->negconChoice = choice;
            ctrlType = '\x01';
            if (choice != 0) {
              ctrlType = '\x02';
            }
            this->fCurrentController = ctrlType;
            menus = menuDefs[0];
            this->negconChoice = -1;
            fSetMenu = &menus->menuControllerNegcon;
          }
          else {
            setmenutonull = true;
            firsttimeU = 1;
            this->fArrowFade = 0x80;
            this->fCurrentController = '\0';
          }
        }
        else {
          fSetMenu = &menuDefs[0]->menuControllerNegcon;
        }
        goto SetCurCtrl_menuSetVertHelp;
      }
      if (padID == 0x41) {
        padState = PadGetState(playerMask & 0x10);
        dialogIdle = false;
        if (padState == 6) {
          this->fCurrentController = '\x04';
          menus = menuDefs[0];
          this->fTimeOutStartTick = 0;
          fSetMenu = &menus->menuControllerDualShock;
          goto SetCurCtrl_menuSetVertHelp;
        }
        padState = PadGetState((uint)(this->player != 0) << 4);
        if ((padState == 2) ||
           (((this->fTimeOutStartTick != 0 &&
             (padState = PadGetState((uint)(this->player != 0) << 4),
             padState == 1)) && (0x60 < ticks - this->fTimeOutStartTick)))) {
          dialogIdle = true;
        }
        if ((!dialogIdle) && (this->fCurrentController != '\x03')) {
          if (this->fTimeOutStartTick == 0) {
            this->fTimeOutStartTick = ticks;
          }
          goto SetCurCtrl_menuSetVertHelp;
        }
      }
    }
    else if (padID == 0x73) goto SetCurCtrl_dualShockDetected;
    setmenutonull = true;
    this->fTimeOutStartTick = 0;
    this->fCurrentController = '\x03';
  }
SetCurCtrl_menuSetVertHelp:
  if ((fSetMenu != (tInsideBoxMenu *)0x0) || (setmenutonull)) {
    SetMenu(&menuDefs[0]->itemControllerSettings,firsttimeU,fSetMenu);
  }
  if (((byte)this->fCurrentController - 5 < 2) && ((byte)this->fTextConfig < 2)) {
    (menuDefs[0]->menuControllerConfig)._base_tMenu.VertHelp = 1;
  }
  else {
    (menuDefs[0]->menuControllerConfig)._base_tMenu.VertHelp = 0;
  }
  return;
}

/* ---- tScreenControllerConfig::CalcAnimFrame  (screencontroller.cpp:1086) ---- */
int tScreenControllerConfig::CalcAnimFrame(int frame)

{
  int bound;
  
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
      bound = 0x16;
      if ((frame < 0x14) || (bound = 0x38, 0x1e < frame)) {
        frame = bound - frame;
      }
      else {
        bound = frame + -0x14;
        if (9 < bound) {
          bound = 9;
        }
        frame = bound + 0x10;
      }
    }
  }
  return frame;
}

/* ---- tScreenControllerConfig::ActualDrawController  (screencontroller.cpp:1105) ---- */
void tScreenControllerConfig::ActualDrawController(int frame,int fadelevelmain,int fadeleveltop,
               int shakex,int shakey)

{
  short *pX;
  short *pY;
  byte ofs;
  int shakeOff;
  int shapeIdx;
  int scaleIdx;
  int i;
  int shapeFlags;
  int shapeX;
  int shapeY;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended drawFlags2;
  
  if (this->CurrentlyLoadedArt == 0) {
    return;
  }
  drawFlags.custom_shapes = (this->_base_tScreen).fSwapShapes.fShapes;
  if ((frame == 0) && (this->CurrentlyLoadedArt != 1)) {
    ofs = Offset[this->CurrentlyLoadedArt][0];
  }
  else {
    ScaleShapeExtended(scaleIdx,shapeFlags,shapeX,shapeY,fadelevelmain,0,
               &drawFlags);
    ofs = Offset[2][0];
    if (this->CurrentlyLoadedArt != 2) goto ActDrawCtrl_emitShape;
  }
  shakeOff = (uint)ofs + shakex;
  DrawShapeExtended
            (shapeIdx,shapeFlags,shapeX,shapeY,fadelevelmain,0,&drawFlags)
  ;
  if (this->CurrentlyLoadedArt == 2) {
    i = 0x30;
    drawFlags2.tint[0] = CalcFadeVal(0xc8c8c8,shakeOff);
    DrawShapeExtended
              (shapeIdx,shapeFlags,shapeX,shapeY,0,1,&drawFlags2);
    DrawShapeExtended
              (shapeIdx,shapeFlags,shapeX,shapeY,0,1,&drawFlags2);
    DrawShapeExtended
              (shapeIdx,shapeFlags,shapeX,shapeY,0,1,&drawFlags2);
    DrawShapeExtended
              (shapeIdx,shapeFlags,shapeX,shapeY,0,1,&drawFlags2);
    shakeOff = -0x7ffadcbc;
    do {
      pX = (short *)(shakeOff + 4);
      pY = (short *)(shakeOff + 6);
      shakeOff = shakeOff + 0xc;
      i = i + 1;
      PSXDrawSquare
                (drawFlags2.tint[0],*pX + -2,*pY + -2,5,3);
    } while (i < 0x36);
    return;
  }
ActDrawCtrl_emitShape:
  DrawShapeExtended
            (shapeIdx,shapeFlags,shapeX,shapeY,fadeleveltop,0,&drawFlags);
  return;
}

/* ---- tScreenControllerConfig::DrawController  (screencontroller.cpp:1156) ---- */
void tScreenControllerConfig::DrawController()

{
  bool bShockActive;
  short maxshakex;
  short maxshakey;
  int fadelevel;
  uint frame;
  int absA;
  int player;
  int axisB;
  int div13hi;
  int t;
  short shakey;
  short shakex;
  float f12;
  double fd;
  float f14;
  int shapeFlags;
  int shapeX;
  int shapeY;
  tDrawShapeExtended drawFlags;
  
  shakex = 0;
  shakey = 0;
  maxshakex = 0;
  maxshakey = 0;
  drawFlags.custom_shapes = (this->_base_tScreen).fSwapShapes.fShapes;
  bShockActive = false;
  if ((((this->fCurrentController == '\x04') &&
       ((short)(menuDefs[0]->menuControllerDualShock)._base_tMenu.fCurrentItem == 0)) ||
      ((this->fCurrentController == '\x06' &&
       ((short)(menuDefs[0]->menuControllerDualShockAnalog)._base_tMenu.fCurrentItem == 0)))) &&
     ((short)(menuDefs[0]->menuControllerConfig)._base_tMenu.fCurrentItem == 1)) {
    bShockActive = true;
  }
  if ((bShockActive) && (frontEnd.shockMode[this->player] != '\0')) {
    if (this->fShakingItem != 0) {
      this->fShakingItem = 0;
      this->fResetShakeTimeOut = 1;
    }
    this->SetActuators((uint)(byte)frontEnd.shockMode[this->player] << 1);
    maxshakex = ((byte)frontEnd.shockMode[this->player] >> 5) + 2;
    maxshakey = ((byte)frontEnd.shockMode[this->player] >> 6) + 2;
  }
  else {
    bShockActive = false;
    if ((((this->fCurrentController == '\x04') &&
         ((short)(menuDefs[0]->menuControllerDualShock)._base_tMenu.fCurrentItem == 1)) ||
        ((this->fCurrentController == '\x06' &&
         ((short)(menuDefs[0]->menuControllerDualShockAnalog)._base_tMenu.fCurrentItem == 1)))) &&
       ((short)(menuDefs[0]->menuControllerConfig)._base_tMenu.fCurrentItem == 1)) {
      bShockActive = true;
    }
    if ((bShockActive) && ((byte)frontEnd.shockImpact[this->player] != 0)) {
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
  t = (int)maxshakex;
  if ((t != 0) || (maxshakey != 0)) {
    fadelevel = rand();
    shakex = (short)(fadelevel % t) - (maxshakex >> 1);
    t = rand();
    fadelevel = (int)maxshakey;
    shakey = (short)(t % fadelevel) - (maxshakey >> 1);
  }
  IsShapeFileLoaded(&this->_base_tScreen,&(this->_base_tScreen).fSwapShapes);
  if ((this->_base_tScreen).fSwapShapes.fFile != (char *)0x0) {
    UploadSwapShapes(&this->_base_tScreen,0x42);
    return;
  }
  if (((this->_base_tScreen).fSwapShapes.fFlags & 1) == 0) {
    this->fGotTick = 0;
    return;
  }
  if (((((byte)this->fCurrentController - 5 < 2) && (this->fAnim == 0)) &&
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
    t = 0;
    do {
      fadelevel = flare_intensity;
      if (flare_intensity < 0) {
        fadelevel = flare_intensity + 3;
      }
      Flare_2DHalo((uint)Offset[(byte)this->fCurrentController][0] + shakex + 0x7e,
                 (uint)Offset[(byte)this->fCurrentController][1] + t + 0x3f + (int)shakey,
                 flare_intensity,fadelevel >> 2,0x15);
      t = t + 1;
    } while (t < 2);
  }
  if ((this->fFade[0] == 0) || (this->fAnimFade != 0)) {
    if (this->fFade[1] == 0) {
DrawCtrl_fadeOpacity:
      if (this->fFade[0] == 0) {
        if ((this->fFade[1] == 0) || (this->fAnimFade != 1)) goto DrawCtrl_ticksUpdate;
        maxshakex = this->fSwap;
        this->fFade[1] = 0;
      }
      else {
DrawCtrl_swapDoneA:
        maxshakex = this->fSwap;
        this->fFade[0] = 0;
      }
DrawCtrl_swapCheck:
      if (maxshakex == 0) goto DrawCtrl_ticksUpdate;
      this->SwapInController();
    }
    else {
      if (this->fAnimFade == 0) {
        maxshakex = this->fFadeController[1];
        this->fFade[1] = 0;
        this->fAnimFade = 1;
        this->fAnimFadeController = maxshakex;
        maxshakex = this->AnimKeyPoints(true,1);
        this->fAnimFadeStart = maxshakex;
        maxshakey = this->AnimKeyPoints(true,0);
        maxshakex = this->fSwap;
        this->fAnimFadeStop = maxshakey;
        this->fAnimFadeFrame = this->fAnimFadeStart;
        goto DrawCtrl_swapCheck;
      }
      if (this->fAnimFade != 1) goto DrawCtrl_fadeOpacity;
      if (this->fFade[0] != 0) goto DrawCtrl_swapDoneA;
      maxshakex = this->fFadeController[1];
      this->fFade[1] = 0;
      this->fAnimFade = 1;
      this->fAnimFadeController = maxshakex;
      maxshakex = this->AnimKeyPoints(true,1);
      this->fAnimFadeStart = maxshakex;
      maxshakex = this->AnimKeyPoints(true,0);
      this->fAnimFadeStop = maxshakex;
      this->fAnimFadeFrame = this->fAnimFadeStart;
      if (this->fSwap == 0) goto DrawCtrl_ticksUpdate;
      this->SwapInController();
      this->fGotTick = 0;
    }
    this->fSwap = 0;
  }
  else {
    this->fFade[0] = 0;
    this->fAnimFade = -1;
    this->fAnimFadeController = this->fFadeController[0];
    maxshakex = this->AnimKeyPoints(false,1);
    this->fAnimFadeStart = maxshakex;
    maxshakex = this->AnimKeyPoints(false,0);
    this->fAnimFadeStop = maxshakex;
    this->fAnimFadeFrame = this->fAnimFadeStart;
  }
DrawCtrl_ticksUpdate:
  t = ticks;
  if (this->fAnimFade != 0) {
    if (this->fGotTick == 0) {
      this->fGotTick = 1;
      this->fPlayedInSound = 0;
      this->fStartTick = t;
    }
    if (((10 < ticks - this->fStartTick) && (this->fPlayedInSound == 0)) && (this->fAnimFade == 1))
    {
      AudioCmn_PlayFESFX(0xf);
      this->fPlayedInSound = 1;
    }
    t = (uint)(ushort)this->fAnimFadeStart +
            ((ticks - this->fStartTick) / 6) * (int)this->fAnimFade;
    this->fAnimFadeFrame = (short)t;
    t = t * 0x10000 >> 0x10;
    if (((this->fAnimFadeStop < t) && (this->fAnimFade == 1)) ||
       ((t < this->fAnimFadeStop && (this->fAnimFade == -1)))) {
      this->fGotTick = 0;
      this->fAnimFadeFrame = this->fAnimFadeStop;
      if (this->fAnimFade == 1) {
        this->fTextTypeOn = 0;
        this->fArrowFade = 0x80;
      }
    }
    fadelevel = ((int)this->fAnimFadeFrame - (int)this->fAnimFadeStart) * 0x80;
    axisB = (int)this->fAnimFadeStop - (int)this->fAnimFadeStart;
    t = fadelevel / axisB;
    if (t < 0) {
      t = -t;
    }
    fadelevel = t << 1;
    if (this->SuperFastFadeOut != 0) {
      fadelevel = t << 2;
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
    frame = this->CalcAnimFrame((int)this->fAnimFadeFrame);
    t = fadelevel;
    goto DrawCtrl_callActual;
  }
  if (this->fAnim != 0) {
    if (this->fGotTick == 0) {
      AudioCmn_PlayFESFX(0xf);
      t = ticks;
      this->fGotTick = 1;
      this->fStartTick = t;
    }
    t = (uint)(ushort)this->fAnimStart + ((ticks - this->fStartTick) / 6) * (int)this->fAnimStep
    ;
    this->fAnimFrame = (short)t;
    t = t * 0x10000 >> 0x10;
    if (((this->fAnimStop < t) && (this->fAnimStep == 1)) ||
       ((t < this->fAnimStop && (this->fAnimStep == -1)))) {
      this->fAnim = 0;
      this->fGotTick = 0;
      this->fAnimFrame = this->fAnimStop;
    }
    t = this->fStartTick;
    f12 = __floatsisf(ticks - t);
    fadelevel = this->fAnimStep * 6;
    f14 = __floatsisf(((int)this->fAnimStop - (int)this->fAnimStart) * fadelevel);
    f12 = __divsf3(f12,f14);
    fd = __extendsfdf2(f12);
    fd = __muldf3(fd,256.0);   /* 2nd operand (scale const) lost to decompiler -> inferred 0x100 */
    t = __fixdfsi(fd);
    fadelevel = t;
    if (0x100 < t) {
      fadelevel = 0x100;
    }
    if (0x80 < t) {
      fadelevel = 0x100 - fadelevel;
    }
    fadelevel = fadelevel + 10;
    t = fadelevel;
    if (fadelevel < 0) {
      t = 0;
    }
    if (0x80 < fadelevel) {
      t = 0x80;
    }
    frame = this->CalcAnimFrame((int)this->fAnimFrame);
    fadelevel = 0;
    goto DrawCtrl_callActual;
  }
  if ((byte)this->fCurrentController - 5 < 2) {
    frame = 0;
    if (((menuDefs[0]->itemControllerSteeringRange2).fActive != 0) ||
       ((menuDefs[0]->itemControllerDeadSpot2).fActive != 0)) {
      fadelevel = 0x80 - (uint)gPadinfo.buf[this->player * 4].data.negcon.leftshift;
      axisB = 0x80 - (uint)gPadinfo.buf[this->player * 4].data.negcon.buttonII;
      t = axisB;
      if (axisB < 0) {
        t = -axisB;
      }
      absA = fadelevel;
      if (fadelevel < 0) {
        absA = -fadelevel;
      }
      if (absA < t) {
        fadelevel = axisB;
      }
      t = (int)(short)fadelevel;
      if (t < 0) {
        div13hi = (int)((unsigned long long)((long long)-t * 0x4ec4ec4f /* =ceil(2^34/13): hi32 of x*M; x*M>>34 == x/13 */) >> 0x20);
        frame = -t / 0xd + 0x24;
      }
      else {
        div13hi = (int)((unsigned long long)((long long)t * 0x4ec4ec4f /* =ceil(2^34/13): hi32 of x*M; x*M>>34 == x/13 */) >> 0x20);
        frame = t / 0xd + 0x1a;
      }
    }
    if (((menuDefs[0]->itemControllerSteeringRange1).fActive != 0) ||
       ((menuDefs[0]->itemControllerDeadSpot1).fActive != 0)) {
      fadelevel = 0x80 - (uint)gPadinfo.buf[this->player * 4].data.negcon.buttonI;
      axisB = 0x80 - (uint)gPadinfo.buf[this->player * 4].data.negcon.twist;
      t = axisB;
      if (axisB < 0) {
        t = -axisB;
      }
      absA = fadelevel;
      if (fadelevel < 0) {
        absA = -fadelevel;
      }
      if (absA < t) {
        fadelevel = axisB;
      }
      t = (int)(short)fadelevel;
      if (t < 0) {
        div13hi = (int)((unsigned long long)((long long)-t * 0x4ec4ec4f /* =ceil(2^34/13): hi32 of x*M; x*M>>34 == x/13 */) >> 0x20);
        frame = -t / 0xd + 0x38;
      }
      else {
        div13hi = (int)((unsigned long long)((long long)t * 0x4ec4ec4f /* =ceil(2^34/13): hi32 of x*M; x*M>>34 == x/13 */) >> 0x20);
        frame = t / 0xd + 0x2e;
      }
    }
    if ((frame & 0xff) != 0) {
      DrawShapeExtended(div13hi,shapeFlags,shapeX,shapeY,0,0,&drawFlags);
    }
  }
  frame = (uint)(byte)this->fCurrentController;
  if ((1 < frame - 1) ||
     (((menuDefs[0]->itemControllerJoyRange).fActive == 0 &&
      ((menuDefs[0]->itemControllerCenterPoint).fActive == 0)))) {
    if (this->fCurrentController != '\0') {
      this->ActualDrawController(0,0,0,(int)shakex,(int)shakey);
      return;
    }
    this->fTextController = '\0';
    this->fArrowFade = 0x80;
    this->fTextTypeOn = 0;
    return;
  }
  t = gPadinfo.buf[this->player * 4].data.negcon.twist - 0x80;
  if (t < 0xb) {
    fadelevel = 0x23;
    if (t < -10) {
      t = -t;
      if (frame != 2) goto DrawCtrl_calcModeOther;
      fadelevel = 0x10;
      goto DrawCtrl_calcModeTwo;
    }
    frame = (uint)(frame == 2);
  }
  else {
    fadelevel = 0x1a;
    if (frame == 2) {
      fadelevel = 2;
DrawCtrl_calcModeTwo:
      frame = fadelevel + (t * 0xd) / 0x81;
    }
    else {
DrawCtrl_calcModeOther:
      frame = fadelevel + (t << 3) / 0x81;
    }
  }
  fadelevel = 0;
  t = fadelevel;
DrawCtrl_callActual:
  this->ActualDrawController(frame,fadelevel,t,0,0);
  return;
}

/* ---- tScreenControllerConfig::HorzVertLine  (screencontroller.cpp:1518) ---- */
void tScreenControllerConfig::HorzVertLine(short *ArrowLoc,bool type)

{
  short length;
  int amount;
  int endx;
  int lineX;
  int lineY;
  int extrabit;
  int startx;
  uint extrabit2;
  int starty;
  int endy;
  int col;
  
  amount = type;
  startx = (int)ArrowLoc[2];
  endx = (int)ArrowLoc[4];
  starty = (int)ArrowLoc[3];
  endy = (int)ArrowLoc[5];
  if (amount != 0) {
    startx = (int)*ArrowLoc;
    starty = (int)ArrowLoc[1];
    endx = (int)ArrowLoc[2];
    endy = (int)ArrowLoc[3];
  }
  col = 0x1e1e1e;
  if (0 < this->fArrowFadeDir) {
    col = CalcFadeVal(0x1e1e1e,amount);
  }
  length = (short)(endx - startx);
  if (startx == endx) {
    extrabit = 0;
    if (amount == 0) {
      extrabit = endy < starty ^ 1;
    }
    extrabit2 = 0;
    if (amount == 1) {
      extrabit2 = endy < starty ^ 1;
    }
    length = (short)(endy - starty);
    if (this->mult != 0x40) {
      startx = ((endy - starty) * 0x10000 >> 0x10) * (int)this->mult >> 6;
      length = (short)startx;
      PSXDrawTransSquare(0xffffff,lineX,lineY,2,-((startx << 0x10) >> 0x13),2);
    }
    endx = 2;
    startx = -(((int)length - extrabit) + extrabit2);
  }
  else {
    starty = (endx < startx ^ 1) * 2;
    if (this->mult != 0x40) {
      endx = ((endx - startx) * 0x10000 >> 0x10) * (int)this->mult >> 6;
      length = (short)endx;
      endx = endx << 0x10;
      startx = endx >> 0x10;
      if (startx < 0) {
        startx = -startx;
      }
      if (startx <= starty) {
        return;
      }
      PSXDrawTransSquare(0xffffff,lineX,lineY,-((endx >> 0x13) + starty),1,2);
    }
    endx = (int)length;
    startx = endx;
    if (endx < 0) {
      startx = -endx;
    }
    if (startx <= starty) {
      return;
    }
    endx = -(endx + starty);
    startx = 1;
  }
  PSXDrawTransSquare(col,lineX,lineY,endx,startx,2);
  return;
}

/* ---- tScreenControllerConfig::DrawArrow  (screencontroller.cpp:1571) ---- */
void tScreenControllerConfig::DrawArrow(short *ArrowLoc)

{
  short clampVal;
  int fadeCalc;
  short m;
  int hi;
  short *abr;
  
  this->mult = 0;
  abr = ArrowLoc;
  settrans(1);
  FeDraw_SetABRMode((int)abr);
  if (*ArrowLoc != 0) {
    if (this->fArrowFadeDir < 0) {
      fadeCalc = 0x40 - (uint)(ushort)this->fArrowFade;
      this->mult = (short)fadeCalc;
      if (fadeCalc * 0x10000 < 0) {
        this->mult = 0;
      }
    }
    else {
      this->mult = 0x40;
    }
    this->HorzVertLine(ArrowLoc,true);
  }
  clampVal = 0x40;
  if (this->fArrowFadeDir < 0) {
    fadeCalc = 0x80 - (uint)(ushort)this->fArrowFade;
    hi = fadeCalc * 0x10000 >> 0x10;
    m = (short)fadeCalc;
    this->mult = m;
    if (((hi < 1) || (clampVal = 0x40, hi < 0x40)) && (clampVal = m, hi < 0)) {
      clampVal = 0;
    }
  }
  this->mult = clampVal;
  this->HorzVertLine(ArrowLoc,false);
  FeDraw_SetABRMode((int)ArrowLoc);
  settrans(0);
  return;
}

/* ---- tScreenControllerConfig::DrawBackground  (screencontroller.cpp:1608) ---- */
void tScreenControllerConfig::DrawBackground()

{
  short fade;
  short animStart;
  short animStop;
  void *transDone;
  void *trans2;
  int scaleIdx;
  int i;
  int shapeFlags;
  int shapeX;
  int shapeY;
  
  fade = (short)((menuDefs[0]->menuControllerConfig).fScreenFade >> 1);
  if (0x80 < fade) {
    fade = 0x80;
  }
  if ((this->fTransitionedIn == 0) &&
     (transDone = TransitionIsFinished(&menuDefs[0]->menuControllerConfig),
     transDone != (void *)0x0)) {
    this->fTransitionedIn = 1;
  }
  if (((fade < 0x81) && (this->fTransitioningIn == 0)) && (this->fCurrentController != '\0')
     ) {
    this->fAnimFade = 1;
    animStart = this->AnimKeyPoints(true,1);
    this->fAnimFadeStart = animStart;
    animStop = this->AnimKeyPoints(true,0);
    this->fAnimFadeStop = animStop;
    this->fTransitioningIn = 1;
    this->fAnimFadeFrame = this->fAnimFadeStart;
    this->fAnimFadeController = (ushort)(byte)this->fCurrentController;
  }
  trans2 = TransitionIsFinished(&menuDefs[0]->menuControllerConfig);
  if ((trans2 != (void *)0x1) && (this->fTransitionedIn != 0)) {
    if (this->fTransitioningOut != 0) goto ForceVbl_drawCtrlCheck;
    if (this->fCurrentController != '\0') {
      this->fAnimFade = -1;
      animStop = this->AnimKeyPoints(false,1);
      this->fAnimFadeStart = animStop;
      animStop = this->AnimKeyPoints(false,0);
      this->fAnimFadeStop = animStop;
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
    ScaleShapeExtended(scaleIdx,shapeFlags,shapeX,shapeY,(int)fade,0,
               (tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 0xc);
  return;
}

/* ---- tScreenControllerConfig::DrawForeground  (screencontroller.cpp:1659) ---- */
void tScreenControllerConfig::DrawForeground()

{
  char ch;
  bool flag;
  ushort arrowFade;
  short i;
  short j;
  short fadeDir;
  int TextIndex;
  void *transDone;
  int ColText;
  char *astringpointer;
  uint slen;
  int howfarout;
  short *pTextLoc;
  short coord;
  int k;
  short *pTL;
  int ColText2;
  short (*pNumTexts) [3];
  int shapeFlags;
  int shapeX;
  int shapeY;
  short TL [5];
  char string1 [40];
  char string2 [40];
  char brightstring [2];
  
  this->SetCurrentController(false);
  this->CheckConfigs();
  brightstring[1] = '\0';
  fadeDir = 8;
  if ((((this->fFadeTextOut == 0) && (fadeDir = 8, this->fAnim == 0)) &&
      (fadeDir = 8, this->fAnimFade == 0)) && (fadeDir = 8, *(int *)this->fFade == 0)) {
    transDone = TransitionIsFinished(&menuDefs[0]->menuControllerConfig);
    fadeDir = 8;
    if (((transDone != (void *)0x0) && (fadeDir = 8, this->fTransitioningOut == 0)) &&
       (fadeDir = -8, 0 < this->fArrowFadeDir)) {
      this->fTextTypeOn = 0;
    }
  }
  this->fArrowFadeDir = fadeDir;
  arrowFade = this->fArrowFade + this->fArrowFadeDir;
  this->fArrowFade = arrowFade;
  if ((int)((uint)arrowFade << 0x10) < 0) {
    this->fArrowFade = 0;
  }
  if (this->fArrowFade < 0x80) {
    if (this->fArrowFade == 0) {
      this->fTextTypeOn = this->fTextTypeOn + 1;
    }
    if (100 < this->fTextTypeOn) {
      this->fTextTypeOn = 100;
    }
    if (this->fArrowFade != 0) {
      FETextRender_SetABR(1,true);
    }
    if (this->fTextController != '\0') {
      ColText2 = 100;
      fadeDir = 0;
      TextIndex = kRGBVals[(byte)textDefinitions[0xb][3]];
      ColText = CalcFadeVal(TextIndex,0xffffff,100,(int)this->fArrowFade);
      ColText2 = CalcFadeVal(TextIndex,ColText2);
      while( true ) {
        pNumTexts = NumTexts;
        TextIndex = (byte)this->fTextController - 1;
        if ((int)NumTexts[TextIndex][(byte)this->fTextConfig] <= (int)fadeDir) break;
        TextIndex = (int)ControllerItemIndex[TextIndex][(byte)this->fTextConfig][fadeDir][0];
        pTL = TL;
        if (TextIndex != -1) {
          k = 4;
          pTextLoc = TextLocations[TextIndex];
          do {
            coord = *pTextLoc;
            pTextLoc = pTextLoc + 1;
            k = k + -1;
            *pTL = coord;
            pTL = pTL + 1;
          } while (k != -1);
          astringpointer = TextSys_Word((int)TL[2]);
          slen = strlen(astringpointer);
          i = (short)slen;
          TextIndex = (int)i;
          coord = this->fTextTypeOn;
          if (TextIndex < this->fTextTypeOn) {
            coord = i;
          }
          k = (int)coord;
          if (this->fTextTypeOn < TextIndex) {
            astringpointer = TextSys_Word((int)TL[2]);
            sprintf(string2,astringpointer);
            howfarout = slen - k;
            coord = (short)howfarout;
            if (TL[3] == 0) {
              TextIndex = 0;
              coord = 0;
              if (0 < this->fTextTypeOn) {
                do {
                  coord = (short)TextIndex;
                  slen = strlen(string2);
                  k = TextIndex << 0x10;
                  howfarout = k >> 0x10;
                  TextIndex = TextIndex + 1;
                  if ((int)(slen << 0x10) <= k) break;
                  string1[howfarout] = string2[howfarout];
                  coord = (short)TextIndex;
                } while (TextIndex * 0x10000 >> 0x10 < (int)this->fTextTypeOn);
              }
              string1[coord] = '\0';
              brightstring[0] = string1[coord + -1];
            }
            else {
              if (howfarout * 0x10000 >> 0x10 < TextIndex) {
                do {
                  j = (short)howfarout;
                  howfarout = howfarout + 1;
                  coord = (short)howfarout;
                  string1[(int)j - (TextIndex - k)] = string2[j];
                } while (howfarout * 0x10000 >> 0x10 < TextIndex);
              }
              string1[(int)coord - (i - k)] = '\0';
              brightstring[0] = string1[0];
            }
            FETextRender_SetFont(0);
            k = (int)TL[0];
            TextIndex = textpixels(string1);
            slen = strlen(string1);
            TextIndex = TextIndex - slen;
            if (TL[3] == 1) {
              TextIndex = -TextIndex;
            }
            astringpointer = string1;
            FETextRender_FullTextRGB(brightstring,(short)((uint)((k + TextIndex) * 0x10000) >> 0x10),TL[1],ColText
                       ,'\0',(ushort)(TL[3] == 0));
          }
          else {
            astringpointer = TextSys_Word((int)TL[2]);
          }
          FETextRender_FullTextRGB
                    (astringpointer,TL[0],TL[1],ColText2,'\0',TL[3]);
          TextIndex = textpixels(astringpointer);
          slen = strlen(astringpointer);
          TextIndex = TextIndex - slen;
          if (TL[3] != 0) {
            TextIndex = -TextIndex;
          }
          PSXDrawSquare(0,(int)TL[0],(int)TL[1],TextIndex,7);
        }
        fadeDir = fadeDir + 1;
      }
    }
    fadeDir = 0;
    while( true ) {
      ColText = (byte)this->fTextController - 1;
      if ((int)NumTexts[ColText][(byte)this->fTextConfig] <= (int)fadeDir) break;
      flag = false;
      if ((this->negconPopUp)._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase.currentlyOn == 0)
      {
        flag = (this->negconPopUp)._base_tDialogInteractive.fCurrentlyRunning == 0;
      }
      if (((flag) && (-1 < ColText)) &&
         (ColText = (int)ControllerItemIndex[ColText][(byte)this->fTextConfig][fadeDir][1], ColText != -1))
      {
        this->DrawArrow(ArrowLocations[ColText]);
      }
      fadeDir = fadeDir + 1;
    }
    FETextRender_SetABR(0,false);
    fadeDir = (short)((menuDefs[0]->menuControllerConfig).fScreenFade >> 1);
    ColText = 0;
    if (0x80 < fadeDir) {
      fadeDir = 0x80;
    }
    do {
      ScaleShapeExtended
                ((int)pNumTexts,shapeFlags,shapeX,shapeY,(int)fadeDir,0,
                 (tDrawShapeExtended *)0x0);
      ColText = ColText + 1;
    } while (ColText * 0x10000 >> 0x10 < 2);
  }
  else {
    this->fArrowFade = 0x80;
    this->fTextController = this->fCurrentController;
    if (this->fCurrentController == '\x06') {
      this->fTextController = '\x05';
    }
    ch = frontEnd.controlConfig[this->player];
    this->fFadeTextOut = 0;
    this->fTextConfig = ch;
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
  this->_base_tScreen.Initialize();
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
  this->_base_tScreen.Cleanup();
  return;
}

/* ---- tScreenControllerConfig::tScreenControllerConfig  (screencontroller.cpp:1889) ---- */
tScreenControllerConfig::tScreenControllerConfig()
  /* base _base_tScreen + member negconPopUp(tDialogYesNo @+0xB8) constructed implicitly by g++ */
{
  this->fGotTick = 0;
  this->fAnim = 0;
  this->fFade[1] = 0;
  this->fFade[0] = 0;
  this->player = 0;
  (this->_base_tScreen)._vf = (__vtbl_ptr_type (*)[10])tScreenControllerConfig_vtable;   /* vptr @0x60 */
  return;
}

/* ---- tScreenControllerConfig::GetHelpText  (screencontroller.cpp:1897) ---- */
int tScreenControllerConfig::GetHelpText()

{
  byte isNegcon;
  
  isNegcon = this->fCurrentController;
  if (isNegcon == 2) {
    return 0x21a;
  }
  if (isNegcon < 3) {
    if (isNegcon == 1) {
      return 0x219;
    }
  }
  else if ((isNegcon < 7) && (4 < isNegcon)) {
    return 0x218;
  }
  return -1;
}

/* ---- tScreenControllerConfig::~tScreenControllerConfig  (screencontroller.cpp:177) ---- */
tScreenControllerConfig::~tScreenControllerConfig()

{
  return;
}

/* end of screencontroller.cpp */