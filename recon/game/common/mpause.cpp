/* game/common/mpause.cpp -- RECONSTRUCTED (NFS4 PSX mini/in-race pause menu; C++ TU)
 *   10 fns: class tPauseMenuDefs ctor/dtor + 8 free MPause_* (music/
 *   controller/logic/render/init/start/end/kill). GTE-free. Full SYM-locals applied.
 */
#include "mpause_types.h"
#include "../../lib/nfs4_new.h"
#include "mpause_externs.h"

/* ---- mpause.obj OWNED globals (Ghidra left $gp-relative; SYM names via disasm-proto,
 *   $gp base 0x8013C54C). EXT = external linkage (other TUs extern these); STAT = file-static. */
tPauseMenuDefs *gPauseMenuDefs;              /* EXT 0x8013d268 [$gp+0xd1c] */
bool  gMPauseUpdate;                         /* EXT 0x8013d264 [$gp+0xd18], SYM BOOL */
bool  gMPauseUpdateNextTime;                 /* EXT 0x8013d240 [$gp+0xcf4], SYM BOOL */
short InGameSelectListAudioMode[4] = {0x12, 0x11, 0x13, 0};  /* EXT 0x8013d244 -- retail init (w63-a19 E5) */
short SelectListConfig[4] = {0x17, 0x18, 0x19, 0};           /* EXT 0x8013d24c -- retail init (w63-a19 E5) */
static tPMenu *gPauseCurrentMenu;            /* STAT 0x8013ddc0 [$gp+0x1874] */
static short  kMovingHighlight;              /* STAT 0x8013ddb8 [$gp+0x186c] */
static short  kMovingHighlightDir;           /* STAT 0x8013ddba [$gp+0x186e] */
static int    gBackDepth;                    /* STAT 0x8013ddbc [$gp+0x1870] */
static tPMenu *gBackList[6];                 /* STAT 0x8013e0c0 */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void MPause_MusicLogic(char active);
void MPause_ControllerLogic(void);
int MPause_Logic(void);
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

static inline void MPause_InitializeMenu(tPMenu *menu)
{
  __vtbl_ptr_type *vf = *menu->_vf;
  int delta = vf[2].delta;
  void (*pfn)(...) = (void (*)(...))vf[2].pfn;
  (*pfn)((int)menu + delta);
}

static inline void MPause_EnableItem(tPMenuItem *item)
{
  if (item->IsDisabled()) {
    ChangedEnabling = 1;
    item->fFlags &= ~1U;
  }
}

static inline void MPause_DisableItem(tPMenuItem *item)
{
  if (item->IsEnabled()) {
    ChangedEnabling = 1;
    item->fFlags |= 1;
  }
}

static inline void MPause_SetCommandPlayer(tPMenuItemCommandButton *item, int player)
{
  if (player == 0) {
    item->fCommand &= ~0x100;
  } else {
    item->fCommand |= 0x100;
  }
}


/* ---- tPauseMenuDefs  [MPAUSE.CPP:172-264] SLD-VERIFIED ---- */
tPauseMenuDefs::tPauseMenuDefs()
  : itemGamePaused(0),
    itemContinue(1,kMPause_Continue),
    itemRestart(2,kMPause_Restart),
    itemOptions(3,&menuOptions,0),
    itemQuitRace(4,kMPause_QuitToRaceSummary),
    itemForfeitRace(5,kMPause_ForfeitToRaceSummary),
    menuPause(&itemGamePaused,&itemContinue,&itemRestart,&itemOptions,&itemQuitRace,
              &itemForfeitRace,0),
    itemOptionsTitle(6),
    itemAudioSettings(7,&menuAudioSettings,0),
    itemControllerSettings(8,&menuControllerConfig,0),
    menuOptions(&itemOptionsTitle,&itemAudioSettings,&itemControllerSettings,0),
    itemAudioSettingsTitle(10),
    iteratorAudioMode(InGameSelectListAudioMode,&MPause_GameSetupWords[59]),
    itemAudioSettingsAudioMode(0xb,&iteratorAudioMode),
    itemAudioSettingsMusicVolume(0xc,&gMasterMusicLevel,0x7f),
    itemAudioSettingsFXVolume(0xd,&gMasterSFXLevel,0x7f),
    itemAudioSettingsSpeechVolume(0xe,&gMasterFENarrationLevel,0x7f),
    itemAudioSettingsEngineVolume(0xf,&gMasterEngineLevel,0x7f),
    itemAudioSettingsAmbientVolume(0x10,&gMasterAmbientLevel,0x7f),
    menuAudioSettings(&itemAudioSettingsTitle,&itemAudioSettingsAudioMode,
                      &itemAudioSettingsMusicVolume,&itemAudioSettingsFXVolume,
                      &itemAudioSettingsSpeechVolume,&itemAudioSettingsEngineVolume,
                      &itemAudioSettingsAmbientVolume,0),
    iteratorConfig(SelectListConfig,&MPause_GameSetupWords[24],
                   &Device_gPausePortIndex),
    itemControllerSettingsTitle(0x14),
    itemControllerConfig(0x15,&iteratorConfig),
    itemControllerShockMode(0x1b,&MPause_GameSetupWords[42],0x7f,
                            &Device_gPausePortIndex),
    itemControllerShockImpact(0x1c,&MPause_GameSetupWords[44],0x7f,
                              &Device_gPausePortIndex),
    menuControllerConfig(&itemControllerSettingsTitle,&itemControllerConfig,
                         &itemControllerShockMode,&itemControllerShockImpact,0),
    itemConfirmTitle(4),
    itemConfirmAreYouSure(0x24),
    itemConfirmNo(0x26,kMPause_BackupMenu),
    itemConfirmYes(0x25,kMPause_BackupMenu),
    menuConfirmYesNo(&itemConfirmTitle,&itemConfirmAreYouSure,&itemConfirmNo,
                     &itemConfirmYes,0)
{
}

/* ---- ~tPauseMenuDefs  [MPAUSE.CPP:268-268] SLD-VERIFIED ---- */
tPauseMenuDefs::~tPauseMenuDefs()
{
}

/* ---- MPause_MusicLogic__Fc  [MPAUSE.CPP:290-371] SLD-VERIFIED ---- */
void MPause_MusicLogic(char active)

{
  static char wasActive;
  static char testSFX;
  static char playingSFX;
  static int vol;
  static int SFXHandle;
  static int lastplaytick;
  tPMenu *pThis;  /* folded receiver temp (SYM REG `this`) */
  int sndover;
  int samp;
  bool bVar1;
  u_int uVar2;
  int iVar3;
  
  sndover = 1;
  samp = 0x10;
  switch (MPause_GameSetupWords[59]) {
    case 0:
      gStereoMode = 1;
      Audio_direct3davail = 0;
      break;
    case 1:
      gStereoMode = 0;
      Audio_direct3davail = 0;
      break;
    case 2:
      gStereoMode = 1;
      Audio_direct3davail = 1;
      break;
  }
  if (active != '\0') {
    if (wasActive == '\0') {
      uVar2 = AudioCmn_MusicLevel(gMasterMusicLevel);
      AudioMus_AutoVolume(500,uVar2);
    }
    bVar1 = false;
    iVar3 = *((int *)gPauseCurrentMenu);
    if (iVar3 == 1) {
      bVar1 = true;
    }
    else if (iVar3 == 2) {
      bVar1 = true;
    }
    if (bVar1) {
      iVar3 = AudioCmn_MusicLevel(gMasterMusicLevel);
      AudioMus_Volume(iVar3);
    }
    iVar3 = *((int *)gPauseCurrentMenu);
    testSFX = false;
    if (iVar3 == 3) {
      samp = 0x10;
      vol = gMasterSFXLevel;
      testSFX = true;
    }
    if (*((int *)gPauseCurrentMenu) == 4) {
      samp = 0x10;
      vol = gMasterFENarrationLevel;
      testSFX = true;
    }
    iVar3 = *((int *)gPauseCurrentMenu);
    if (iVar3 == 5) {
      samp = 0x10;
      vol = gMasterEngineLevel;
      testSFX = true;
    }
    if (*((int *)gPauseCurrentMenu) == 6) {
      samp = 0x10;
      vol = gMasterAmbientLevel;
      testSFX = true;
    }
    if ((bool)testSFX != false) {
      if (playingSFX == '\0') {
        playingSFX = '\x01';
      }
      else {
        sndover = SNDover(SFXHandle);
      }
      if ((sndover != 0) && (0xc0 < ticks - lastplaytick)) {
        lastplaytick = *(volatile int *)&ticks;
        SFXHandle = AudioCmn_PlaySound(MPause_SndBnkWords[3][0],samp,0,vol,0x40)
        ;
      }
    }
    else if (playingSFX == '\x01') {
      SNDstop(SFXHandle);
      playingSFX = '\0';
    }
  }
  else if (wasActive != '\0') {
    SNDstop(SFXHandle);
    AudioMus_AutoVolume(500,0);
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
int MPause_Logic(void)

{
  tPMenuCommand command;
  tInputKeyType keyVal;
  bool debounce;
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
      pThis->VirtualProcessInput(keyVal,command);
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
      gBackList[gBackDepth++] = gPauseCurrentMenu;
      gPauseCurrentMenu = command.nextMenu;
      MPause_InitializeMenu(gPauseCurrentMenu);
      break;

    case kMPause_BackupMenu:
      if (gBackDepth > 0) {
        --gBackDepth;
        gPauseCurrentMenu = gBackList[gBackDepth];
        MPause_InitializeMenu(gPauseCurrentMenu);
      } else {
        command.type = kMPause_Continue;
        return command.type;
      }
      break;

    default:
      return command.type;
    }
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
  TextSys_LoadInGame(MPause_GameSetupWords[56]);
  gPauseMenuDefs = new tPauseMenuDefs;
  return;
}

/* ---- MPause_StartPauseMenu__Fv  [MPAUSE.CPP:548-593] SLD-VERIFIED ---- */
void MPause_StartPauseMenu(void)

{
  gPauseCurrentMenu = &gPauseMenuDefs->menuPause;
  MPause_InitializeMenu(gPauseCurrentMenu);
  gBackDepth = 0;

  if ((MPause_GameSetupWords[0] != RaceType_PinkSlips) && (MPause_GameSetupWords[0] != RaceType_Tournament)) {
    MPause_EnableItem(&gPauseMenuDefs->itemRestart);
  } else {
    MPause_DisableItem(&gPauseMenuDefs->itemRestart);
  }

  if (MPause_GameSetupWords[0] == RaceType_PinkSlips) {
    MPause_EnableItem(&gPauseMenuDefs->itemForfeitRace);
    MPause_DisableItem(&gPauseMenuDefs->itemQuitRace);
  }
  else {
    MPause_DisableItem(&gPauseMenuDefs->itemForfeitRace);
    MPause_EnableItem(&gPauseMenuDefs->itemQuitRace);
  }

  MPause_EnableItem(&gPauseMenuDefs->itemAudioSettingsMusicVolume);

  if (Replay_ReplayMode >= 2) {
    MPause_SetCommandPlayer(&gPauseMenuDefs->itemQuitRace, 0);
    MPause_SetCommandPlayer(&gPauseMenuDefs->itemRestart, 0);
    MPause_SetCommandPlayer(&gPauseMenuDefs->itemForfeitRace, 0);
  } else {
    MPause_SetCommandPlayer(&gPauseMenuDefs->itemQuitRace, 1);
    MPause_SetCommandPlayer(&gPauseMenuDefs->itemRestart, 1);
    MPause_SetCommandPlayer(&gPauseMenuDefs->itemForfeitRace, 1);
  }
}

/* ---- MPause_EndPauseMenu__Fv  [MPAUSE.CPP:598-600] SLD-VERIFIED ---- */
void MPause_EndPauseMenu(void)

{
  {
    int *deviceSetup = (int *)((char *)MPause_GameSetupWords +
                              ((u_char)Device_gPausePortIndex << 2));
    InGame_ResetPSXController((u_int)(u_char)Device_gPausePortIndex,
                              deviceSetup[24]);
  }
  return;
}

/* ---- MPause_KillMPause__Fv  [MPAUSE.CPP:605-610] SLD-VERIFIED ---- */
void MPause_KillMPause(void)

{
  DrawSync(0);
  if (((int)gPauseMenuDefs) != 0) {
    delete gPauseMenuDefs;
  }
  TextSys_UnloadWords();
  return;
}

/* end of mpause.cpp */
