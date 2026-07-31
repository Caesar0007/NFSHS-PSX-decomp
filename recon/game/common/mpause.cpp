/* game/common/mpause.cpp -- RECONSTRUCTED (NFS4 PSX mini/in-race pause menu; C++ TU)
 *   10 fns: class tPauseMenuDefs (ctor/dtor as free _ct/_dt) + 8 free MPause_* (music/
 *   controller/logic/render/init/start/end/kill). GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "mpause_externs.h"

/* ---- mpause.obj OWNED globals (Ghidra left $gp-relative; SYM names via disasm-proto,
 *   $gp base 0x8013C54C). EXT = external linkage (other TUs extern these); STAT = file-static.
 *   wasActive..lastplaytick are MPause_MusicLogic-private statics (laid out in this block). */
tPauseMenuDefs *gPauseMenuDefs;              /* EXT 0x8013d268 [$gp+0xd1c] */
int   gMPauseUpdate;                         /* EXT 0x8013d264 [$gp+0xd18] */
int   gMPauseUpdateNextTime;                 /* EXT 0x8013d240 [$gp+0xcf4] */
short InGameSelectListAudioMode[4];          /* EXT 0x8013d244 */
short SelectListConfig[4];                   /* EXT 0x8013d24c */
static tPMenu *gPauseCurrentMenu;            /* STAT 0x8013ddc0 [$gp+0x1874] */
static short  kMovingHighlight;              /* STAT 0x8013ddb8 [$gp+0x186c] */
static short  kMovingHighlightDir;           /* STAT 0x8013ddba [$gp+0x186e] */
static int    gBackDepth;                    /* STAT 0x8013ddbc [$gp+0x1870] */
static tPMenu *gBackList[6];                 /* STAT 0x8013e0c0 */
static char   wasActive, testSFX, playingSFX;   /* STAT MusicLogic statics 0x14/0x15/0x16 */
static int    vol, SFXHandle, lastplaytick;     /* STAT MusicLogic statics 0x18/0x1c/0x20 */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void MPause_MusicLogic(char active);
void MPause_ControllerLogic(void);
u_int MPause_Logic(void);
void MPause_Render(void);
void MPause_InitMPause(void);
void MPause_StartPauseMenu(void);
void MPause_EndPauseMenu(void);
void MPause_KillMPause(void);

/* Preserve the retail currentItem staging ($v1 -> $a1 in the branch delay slot). */
static inline int MPause_CurrentItem(tPMenu *menu)
{
  return menu->fCurrentItem;
}

struct MPauseMenuPrefix {
  int fCurrentItem;
  BOOL fHighlight;
  tPMenuItem *fItemList[16];
  tPMenu *fNextMenu;
  int fNumItems;
};

struct MPauseMenuVirtual : public MPauseMenuPrefix {
  virtual void Unknown1(void);
  virtual void Initialize(void);
  virtual void ProcessInput(tInputKeyType &keyVal,tPMenuCommand &command);
  virtual void Draw(void);
};


/* ---- tPauseMenuDefs  [MPAUSE.CPP:172-264] SLD-VERIFIED ---- */
int tPauseMenuDefs_ct(int param_1)

{
  tPMenuItemNonInteractiveText_ct(param_1,0);
  tPMenuItemCommandButton_ct(param_1 + 0xc,1,1);
  tPMenuItemCommandButton_ct(param_1 + 0x1c,2,2);
  tPMenuItemGoToMenuButton_ct(param_1 + 0x2c,3,param_1 + 0xe8,0);
  tPMenuItemCommandButton_ct(param_1 + 0x40,4,4);
  tPMenuItemCommandButton_ct(param_1 + 0x50,5,5);
  tPMenu_ct(param_1 + 0x60,param_1,param_1 + 0xc,param_1 + 0x1c,param_1 + 0x2c,param_1 + 0x40,
                 param_1 + 0x50,0);
  tPMenuItemNonInteractiveText_ct(param_1 + 0xb4,6);
  tPMenuItemGoToMenuButton_ct(param_1 + 0xc0,7,param_1 + 0x1c8,0);
  tPMenuItemGoToMenuButton_ct(param_1 + 0xd4,8,param_1 + 0x278,0);
  tPMenu_ct(param_1 + 0xe8,param_1 + 0xb4,param_1 + 0xc0,param_1 + 0xd4,0);
  tPMenuItemNonInteractiveText_ct(param_1 + 0x13c,10);
  tPListIterator_ct(param_1 + 0x148,InGameSelectListAudioMode,(void *)((char *)&GameSetup_gData + 0xec) /* @0x801132d8 */);
  tPMenuItemLeftRightChoice_ct(param_1 + 0x154,0xb,param_1 + 0x148);
  tPMenuItemLeftRightSlider_ct(param_1 + 0x164,0xc,&gMasterMusicLevel,0x7f);
  tPMenuItemLeftRightSlider_ct(param_1 + 0x178,0xd,&gMasterSFXLevel,0x7f);
  tPMenuItemLeftRightSlider_ct(param_1 + 0x18c,0xe,&gMasterFENarrationLevel,0x7f);
  tPMenuItemLeftRightSlider_ct(param_1 + 0x1a0,0xf,&gMasterEngineLevel,0x7f)
  ;
  tPMenuItemLeftRightSlider_ct(param_1 + 0x1b4,0x10,&gMasterAmbientLevel,0x7f);
  tPMenu_ct(param_1 + 0x1c8,param_1 + 0x13c,param_1 + 0x154,param_1 + 0x164,param_1 + 0x178,
                 param_1 + 0x18c,param_1 + 0x1a0,param_1 + 0x1b4,0);
  tPListIteratorIndexed_ct(param_1 + 0x21c,SelectListConfig,(void *)((char *)&GameSetup_gData + 0x60) /* @0x8011324c */,&Device_gPausePortIndex);
  tPMenuItemNonInteractiveText_ct(param_1 + 0x22c,0x14);
  tPMenuItemLeftRightChoice_ct(param_1 + 0x238,0x15,param_1 + 0x21c);
  tPMenuItemLeftRightSliderIndexed_ct(param_1 + 0x248,0x1b,(void *)((char *)&GameSetup_gData + 0xa8) /* @0x80113294 */,0x7f,&Device_gPausePortIndex);
  tPMenuItemLeftRightSliderIndexed_ct(param_1 + 0x260,0x1c,(void *)((char *)&GameSetup_gData + 0xb0) /* @0x8011329c */,0x7f,&Device_gPausePortIndex);
  tPMenu_ct(param_1 + 0x278,param_1 + 0x22c,param_1 + 0x238,param_1 + 0x248,param_1 + 0x260,0);
  tPMenuItemNonInteractiveText_ct(param_1 + 0x2cc,4);
  tPMenuItemNonInteractiveText_ct(param_1 + 0x2d8,0x24);
  tPMenuItemCommandButton_ct(param_1 + 0x2e4,0x26,7);
  tPMenuItemCommandButton_ct(param_1 + 0x2f4,0x25,7);
  tPMenu_ct(param_1 + 0x304,param_1 + 0x2cc,param_1 + 0x2d8,param_1 + 0x2e4,param_1 + 0x2f4,0);
  return param_1;
}

/* ---- ~tPauseMenuDefs  [MPAUSE.CPP:268-268] SLD-VERIFIED ---- */
extern "C" void ___14tPauseMenuDefs(tPMenuItemNonInteractiveText *param_1,u_int __in_chrg)

{
  tPMenu_dt((tPMenu *)&param_1[0x40].fTextDescription,2);
  tPMenuItemCommandButton_dt((tPMenuItemCommandButton *)(param_1 + 0x3f),2);
  tPMenuItemCommandButton_dt((tPMenuItemCommandButton *)&param_1[0x3d]._vf,2);
  tPMenuItemNonInteractiveText_dt((tPMenuItemNonInteractiveText *)&param_1[0x3c]._vf,2);
  tPMenuItemNonInteractiveText_dt((tPMenuItemNonInteractiveText *)&param_1[0x3b]._vf,2);
  tPMenu_dt((tPMenu *)&param_1[0x34]._vf,2);
  tPMenuItemLeftRightSliderIndexed_dt((tPMenuItemLeftRightSliderIndexed *)&param_1[0x32]._vf,2);
  tPMenuItemLeftRightSliderIndexed_dt((tPMenuItemLeftRightSliderIndexed *)&param_1[0x30]._vf,2);
  tPMenuItemLeftRightChoice_dt((tPMenuItemLeftRightChoice *)&param_1[0x2f].fTextDescription,2);
  tPMenuItemNonInteractiveText_dt((tPMenuItemNonInteractiveText *)&param_1[0x2e].fTextDescription,2);
  tPListIteratorIndexed_dt((tPListIteratorIndexed *)(param_1 + 0x2d),2);
  tPMenu_dt((tPMenu *)(param_1 + 0x26),2);
  tPMenuItemLeftRightSlider_dt((tPMenuItemLeftRightSlider *)&param_1[0x24].fTextDescription,2);
  tPMenuItemLeftRightSlider_dt((tPMenuItemLeftRightSlider *)&param_1[0x22]._vf,2);
  tPMenuItemLeftRightSlider_dt((tPMenuItemLeftRightSlider *)(param_1 + 0x21),2);
  tPMenuItemLeftRightSlider_dt((tPMenuItemLeftRightSlider *)&param_1[0x1f].fTextDescription,2);
  tPMenuItemLeftRightSlider_dt((tPMenuItemLeftRightSlider *)&param_1[0x1d]._vf,2);
  tPMenuItemLeftRightChoice_dt((tPMenuItemLeftRightChoice *)&param_1[0x1c].fTextDescription,2);
  tPListIterator_dt((tPListIterator *)&param_1[0x1b].fTextDescription,2);
  tPMenuItemNonInteractiveText_dt((tPMenuItemNonInteractiveText *)&param_1[0x1a].fTextDescription,2);
  tPMenu_dt((tPMenu *)&param_1[0x13].fTextDescription,2);
  tPMenuItemGoToMenuButton_dt((tPMenuItemGoToMenuButton *)&param_1[0x11]._vf,2);
  tPMenuItemGoToMenuButton_dt((tPMenuItemGoToMenuButton *)(param_1 + 0x10),2);
  tPMenuItemNonInteractiveText_dt(param_1 + 0xf,2);
  tPMenu_dt((tPMenu *)(param_1 + 8),2);
  tPMenuItemCommandButton_dt((tPMenuItemCommandButton *)&param_1[6]._vf,2);
  tPMenuItemCommandButton_dt((tPMenuItemCommandButton *)&param_1[5].fTextDescription,2);
  tPMenuItemGoToMenuButton_dt((tPMenuItemGoToMenuButton *)&param_1[3]._vf,2);
  tPMenuItemCommandButton_dt((tPMenuItemCommandButton *)&param_1[2].fTextDescription,2);
  tPMenuItemCommandButton_dt((tPMenuItemCommandButton *)(param_1 + 1),2);
  tPMenuItemNonInteractiveText_dt(param_1,2);
  if ((__in_chrg & 1) != 0) {
    __builtin_delete(param_1);
  }
  return;
}

/* ---- MPause_MusicLogic__Fc  [MPAUSE.CPP:290-371] SLD-VERIFIED ---- */
void MPause_MusicLogic(char active)

{
  tPMenu *pThis;  /* folded receiver temp (SYM REG `this`) */
  int sndover;
  int samp;
  bool bVar1;
  u_int uVar2;
  int iVar3;
  int iVar4;
  
  iVar4 = 1;
  if (GameSetup_gData.userSetting.audioMode == 1) {
    gStereoMode = 0;
    Audio_direct3davail = 0;
  }
  else if (GameSetup_gData.userSetting.audioMode < 2) {
    if (GameSetup_gData.userSetting.audioMode == 0) {
      gStereoMode = 1;
      Audio_direct3davail = 0;
    }
  }
  else if (GameSetup_gData.userSetting.audioMode == 2) {
    gStereoMode = 1;
    Audio_direct3davail = 1;
  }
  if (active == '\0') {
    if (wasActive != '\0') {
      SNDstop(SFXHandle);
      AudioMus_AutoVolume(500,0);
    }
  }
  else {
    if (wasActive == '\0') {
      uVar2 = AudioCmn_MusicLevel(gMasterMusicLevel);
      AudioMus_AutoVolume(500,uVar2);
    }
    bVar1 = false;
    if ((*((int *)gPauseCurrentMenu) == 1) || (*((int *)gPauseCurrentMenu) == 2)) {
      bVar1 = true;
    }
    if (bVar1) {
      iVar3 = AudioCmn_MusicLevel(gMasterMusicLevel);
      AudioMus_Volume(iVar3);
    }
    if (*((int *)gPauseCurrentMenu) == 3) {
      vol = gMasterSFXLevel;
    }
    iVar3 = *((int *)gPauseCurrentMenu);
    bVar1 = iVar3 == 4;
    if (bVar1) {
      vol = gMasterFENarrationLevel;
      iVar3 = *((int *)gPauseCurrentMenu);
    }
    testSFX = bVar1 || *((int *)gPauseCurrentMenu) == 3;
    if (iVar3 == 5) {
      testSFX = true;
      vol = gMasterEngineLevel;
    }
    if (*((int *)gPauseCurrentMenu) == 6) {
      testSFX = true;
      vol = gMasterAmbientLevel;
    }
    if ((bool)testSFX == false) {
      if (playingSFX == '\x01') {
        SNDstop(SFXHandle);
        playingSFX = '\0';
      }
    }
    else {
      if (playingSFX == '\0') {
        playingSFX = '\x01';
      }
      else {
        iVar4 = SNDover(SFXHandle);
      }
      if ((iVar4 != 0) && (0xc0 < ticks - lastplaytick)) {
        lastplaytick = ticks;
        SFXHandle = AudioCmn_PlaySound(gSndBnk[3].bnkID,0x10,0,vol,0x40)
        ;
      }
    }
  }
  wasActive = active;
  return;
}

/* ---- MPause_ControllerLogic__Fv  [MPAUSE.CPP:376-385] SLD-VERIFIED ---- */
void MPause_ControllerLogic(void)

{
  tPMenuItemLeftRightSliderIndexed *item;

  if (PadGetState((u_int)(Device_gPausePortIndex != '\0') << 4) == 2) {
    item = &gPauseMenuDefs->itemControllerShockMode;
    if (item->IsEnabled()) {
      ChangedEnabling = 1;
      item->fFlags |= 1;
    }
    item = &gPauseMenuDefs->itemControllerShockImpact;
    if (item->IsEnabled()) {
      ChangedEnabling = 1;
      item->fFlags |= 1;
    }
  }
  else {
    item = &gPauseMenuDefs->itemControllerShockMode;
    if (item->IsDisabled()) {
      ChangedEnabling = 1;
      item->fFlags &= ~1U;
    }
    item = &gPauseMenuDefs->itemControllerShockImpact;
    if (item->IsDisabled()) {
      ChangedEnabling = 1;
      item->fFlags &= ~1U;
    }
  }
}

/* ---- MPause_Logic__Fv  [MPAUSE.CPP:390-486] SLD-VERIFIED ---- */
u_int MPause_Logic(void)

{
  tPMenuCommand command;
  tInputKeyType keyVal;
  BOOL debounce;
  int oldItem;
  int newItem;

  keyVal = kInput_KeyType_NoKey;
  debounce = Debounce(gPauseCurrentMenu);
  if (Input_Interface(5,1)) {
    keyVal = kInput_KeyType_Cross;
  }
  else if (Input_Interface(1,1)) {
    keyVal = kInput_KeyType_Up;
  }
  else if (Input_Interface(2,1)) {
    keyVal = kInput_KeyType_Down;
  }
  else if (Input_Interface(3,debounce)) {
    keyVal = kInput_KeyType_Left;
  }
  else if (Input_Interface(4,debounce)) {
    keyVal = kInput_KeyType_Right;
  }
  else if (Input_Interface(6,1)) {
    keyVal = kInput_KeyType_Start;
  }
  else if (Input_Interface(0x18,1)) {
    keyVal = kInput_KeyType_Triangle;
  }

  command.type = kMPause_NoEvent;
  if (kMovingHighlight == 0) {
    if (keyVal != kInput_KeyType_NoKey) {
      tPMenu *pThis;

      gMPauseUpdate = 1;
      pThis = gPauseCurrentMenu;
      oldItem = pThis->fCurrentItem;
      ((MPauseMenuVirtual *)pThis)->ProcessInput(keyVal,command);
      newItem = gPauseCurrentMenu->fCurrentItem;
      if ((short)oldItem != (short)newItem) {
        int start;
        int finish;

        start = ItemEnabledNum(gPauseCurrentMenu,(short)oldItem) * 0xd + 0x6a;
        finish = ItemEnabledNum(gPauseCurrentMenu,(short)newItem) * 0xd + 0x6a;
        kMovingHighlight = start - finish;
        kMovingHighlightDir = (finish - start) / 10;
      }
      goto MPauseLogic_command;
    }
    if (ChangedEnabling == 0) {
      goto MPauseLogic_updateNext;
    }
  }
  gMPauseUpdate = 1;
  goto MPauseLogic_command;

MPauseLogic_updateNext:
  if (gMPauseUpdateNextTime != 0) {
    gMPauseUpdate = 1;
    gMPauseUpdateNextTime = 0;
  }
  else {
    gMPauseUpdate = 0;
  }

MPauseLogic_command:
  if (command.type != kMPause_NoEvent) {
    int backDepth;
    MPauseMenuVirtual *nextMenu;

    if ((command.type & kMPause_CommandConfirmationFlag) != 0) {
      gPauseMenuDefs->itemConfirmTitle.fTextDescription =
          gPauseCurrentMenu->fItemList[gPauseCurrentMenu->fCurrentItem]->fTextDescription;
      gPauseMenuDefs->itemConfirmYes.fCommand = command.type & 0xff;
      gPauseMenuDefs->menuConfirmYesNo.fCurrentItem = 0;
      command.type = kMPause_GoToMenu;
      command.nextMenu = &gPauseMenuDefs->menuConfirmYesNo;
    }

    switch (command.type) {
    case kMPause_GoToMenu:
      backDepth = gBackDepth;
      gBackList[backDepth] = gPauseCurrentMenu;
      nextMenu = (MPauseMenuVirtual *)command.nextMenu;
      backDepth++;
      goto MPauseLogic_initialize;

    case kMPause_BackupMenu:
      backDepth = gBackDepth;
      if (backDepth <= 0) {
        goto MPauseLogic_noBack;
      }
      backDepth--;
      nextMenu = (MPauseMenuVirtual *)gBackList[backDepth];
      goto MPauseLogic_initialize;

    default:
      goto MPauseLogic_returnCommand;
    }

MPauseLogic_initialize:
    gBackDepth = backDepth;
    gPauseCurrentMenu = (tPMenu *)nextMenu;
    nextMenu->Initialize();
    goto MPauseLogic_commandDone;

MPauseLogic_noBack:
    command.type = kMPause_Continue;
    return command.type;

MPauseLogic_returnCommand:
    return command.type;

MPauseLogic_commandDone:
    ;
  }
  MPause_MusicLogic(gPauseCurrentMenu == (tPMenu *)(((int)gPauseMenuDefs) + 0x1c8));
  MPause_ControllerLogic();
  return 0;
}

/* ---- MPause_Render__Fv  [MPAUSE.CPP:490-530] SLD-VERIFIED ---- */
void MPause_Render(void)

{
  int numItems;
  
  ChangedEnabling = 0;
  if (kMovingHighlight > 0) {
    kMovingHighlight += kMovingHighlightDir;
    if (kMovingHighlight < 0) {
      kMovingHighlight = 0;
    }
  }
  else if (kMovingHighlight < 0) {
    kMovingHighlight += kMovingHighlightDir;
    if (kMovingHighlight > 0) {
      kMovingHighlight = 0;
    }
  }

  if (kMovingHighlight != 0) {
    gPauseCurrentMenu->fHighlight = 0;
  } else {
    gPauseCurrentMenu->fHighlight = 1;
  }

  (**(int (**)(...))(((u_int *)gPauseCurrentMenu)[0x14] + 0x24))
            ((int)((u_int *)gPauseCurrentMenu) +
             (int)*(short *)(((u_int *)gPauseCurrentMenu)[0x14] + 0x20));
  numItems = NumEnabledItems(gPauseCurrentMenu);
  int currentItem = MPause_CurrentItem(gPauseCurrentMenu);
  if (kMovingHighlight != 0) {
    int y = gPauseCurrentMenu->ItemEnabledNum(currentItem) * 0xd;
    int offset = kMovingHighlight + 0x6a;
    Hud_FBuildF4(1,0x50,y + offset,0xa0,0xd,0,0,0);
  } else {
    Hud_FBuildF4(1,0x50,
                 gPauseCurrentMenu->ItemEnabledNum(currentItem) * 0xd + 0x6a,
                 0xa0,0xd,0,0,0);
  }
  Hud_RenderPauseBox(0x50,100,0xa0,(numItems + 1) * 0xd + 0x14);
}

/* ---- MPause_InitMPause__Fv  [MPAUSE.CPP:540-544] SLD-VERIFIED ---- */
void MPause_InitMPause(void)

{
  void *pvVar1;
  
  TextSys_LoadInGame(GameSetup_gData.userSetting.language);
  pvVar1 = __builtin_new(0x358);
  gPauseMenuDefs = (tPauseMenuDefs *)tPauseMenuDefs_ct(pvVar1);
  return;
}

/* ---- MPause_StartPauseMenu__Fv  [MPAUSE.CPP:548-593] SLD-VERIFIED ---- */
void MPause_StartPauseMenu(void)

{
  tPMenuItemCommandButton *pThis;  /* folded receiver temp (SYM REG `this`) */
  int iVar1;
  u_int uVar2;
  int iVar3;
  int iVar4;
  
  gPauseCurrentMenu = (tPMenu *)(((int)gPauseMenuDefs) + 0x60);
  (**(int (**)(...))(*(int *)(((int)gPauseMenuDefs) + 0xb0) + 0x14))
            (((int)gPauseCurrentMenu) + *(short *)(*(int *)(((int)gPauseMenuDefs) + 0xb0) + 0x10));
  iVar4 = ((int)gPauseMenuDefs);
  gBackDepth = 0;
  if ((GameSetup_gData.raceType == 6) || (GameSetup_gData.raceType == 2)) {
    iVar1 = IsEnabled(((int)gPauseMenuDefs) + 0x1c);
    if (iVar1 != 0) {
      uVar2 = *(u_int *)(iVar4 + 0x1c) | 1;
      goto MPauseStart_setRestart;
    }
  }
  else {
    iVar1 = IsDisabled(((int)gPauseMenuDefs) + 0x1c);
    if (iVar1 != 0) {
      uVar2 = *(u_int *)(iVar4 + 0x1c) & 0xfffffffe;
MPauseStart_setRestart:
      ChangedEnabling = 1;
      *(u_int *)(iVar4 + 0x1c) = uVar2;
    }
  }
  iVar4 = ((int)gPauseMenuDefs);
  if (GameSetup_gData.raceType == 6) {
    iVar3 = IsDisabled(((int)gPauseMenuDefs) + 0x50);
    iVar1 = ((int)gPauseMenuDefs);
    if (iVar3 != 0) {
      ChangedEnabling = 1;
      *(u_int *)(iVar4 + 0x50) = *(u_int *)(iVar4 + 0x50) & 0xfffffffe;
    }
    iVar4 = IsEnabled(((int)gPauseMenuDefs) + 0x40);
    if (iVar4 == 0) goto MPauseStart_disableAudio;
    uVar2 = *(u_int *)(iVar1 + 0x40) | 1;
  }
  else {
    iVar3 = IsEnabled(((int)gPauseMenuDefs) + 0x50);
    iVar1 = ((int)gPauseMenuDefs);
    if (iVar3 != 0) {
      ChangedEnabling = 1;
      *(u_int *)(iVar4 + 0x50) = *(u_int *)(iVar4 + 0x50) | 1;
    }
    iVar4 = IsDisabled(((int)gPauseMenuDefs) + 0x40);
    if (iVar4 == 0) goto MPauseStart_disableAudio;
    uVar2 = *(u_int *)(iVar1 + 0x40) & 0xfffffffe;
  }
  ChangedEnabling = 1;
  *(u_int *)(iVar1 + 0x40) = uVar2;
MPauseStart_disableAudio:
  iVar4 = ((int)gPauseMenuDefs);
  iVar1 = IsDisabled(((int)gPauseMenuDefs) + 0x164);
  if (iVar1 != 0) {
    ChangedEnabling = 1;
    *(u_int *)(iVar4 + 0x164) = *(u_int *)(iVar4 + 0x164) & 0xfffffffe;
  }
  if (Replay_ReplayMode < 2) {
    *(u_int *)(((int)gPauseMenuDefs) + 0x4c) = *(u_int *)(((int)gPauseMenuDefs) + 0x4c) | 0x100;
    *(u_int *)(((int)gPauseMenuDefs) + 0x28) = *(u_int *)(((int)gPauseMenuDefs) + 0x28) | 0x100;
    uVar2 = *(u_int *)(((int)gPauseMenuDefs) + 0x5c) | 0x100;
  }
  else {
    *(u_int *)(((int)gPauseMenuDefs) + 0x4c) = *(u_int *)(((int)gPauseMenuDefs) + 0x4c) & 0xfffffeff;
    *(u_int *)(((int)gPauseMenuDefs) + 0x28) = *(u_int *)(((int)gPauseMenuDefs) + 0x28) & 0xfffffeff;
    uVar2 = *(u_int *)(((int)gPauseMenuDefs) + 0x5c) & 0xfffffeff;
  }
  *(u_int *)(((int)gPauseMenuDefs) + 0x5c) = uVar2;
  return;
}

/* ---- MPause_EndPauseMenu__Fv  [MPAUSE.CPP:598-600] SLD-VERIFIED ---- */
void MPause_EndPauseMenu(void)

{
  InGame_ResetPSXController((u_int)(u_char)Device_gPausePortIndex,
             GameSetup_gData.controllerData.controllerConfig[(u_char)Device_gPausePortIndex]);
  return;
}

/* ---- MPause_KillMPause__Fv  [MPAUSE.CPP:605-610] SLD-VERIFIED ---- */
void MPause_KillMPause(void)

{
  DrawSync(0);
  if (((int)gPauseMenuDefs) != 0) {
    ___14tPauseMenuDefs(((int)gPauseMenuDefs),3);
  }
  TextSys_UnloadWords();
  return;
}

/* end of mpause.cpp */
