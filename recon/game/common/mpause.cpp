/* game/common/mpause.cpp -- RECONSTRUCTED (NFS4 PSX mini/in-race pause menu; C++ TU)
 *   10 fns: class tPauseMenuDefs ctor/dtor + 8 free MPause_* (music/
 *   controller/logic/render/init/start/end/kill). GTE-free. Full SYM-locals applied.
 */
#include "mpause_types.h"
#include "../../lib/nfs4_new.h"
#include "mpause_externs.h"

/* The tick-query inline is defined in the owner interface header: retail's
   caller-context block lines must not inherit a source-local helper line. */



/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80055FD0): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* ---- mpause.obj OWNED globals (Ghidra left $gp-relative; SYM names via disasm-proto,
 *   $gp base 0x8013C54C). EXT = external linkage (other TUs extern these); STAT = file-static. */
/* CC1PLPSX emission law: INITIALIZED globals are emitted at their definition
 * point; uninitialized ones are flushed at end-of-file in first-declaration
 * order; uninitialized statics become .lcomm in that same order.  Retail
 * mpause.obj .sdata is 0x8013d240 gMPauseUpdateNextTime / d244 InGame... /
 * d24c SelectListConfig / d254..d264 MPause_MusicLogic's initialized statics /
 * d264 gMPauseUpdate / d268 gPauseMenuDefs, and .sbss 0x8013ddb8 kMovingHighlight
 * / ddba kMovingHighlightDir / ddbc gBackDepth / ddc0 gPauseCurrentMenu. */
bool  gMPauseUpdateNextTime = 0;             /* EXT 0x8013d240 [$gp+0xcf4], SYM BOOL */
short InGameSelectListAudioMode[4] = {0x12, 0x11, 0x13, 0};  /* EXT 0x8013d244 -- retail init (w63-a19 E5) */
short SelectListConfig[4] = {0x17, 0x18, 0x19, 0};           /* EXT 0x8013d24c -- retail init (w63-a19 E5) */
bool  gMPauseUpdate;                         /* EXT 0x8013d264 [$gp+0xd18], SYM BOOL */
tPauseMenuDefs *gPauseMenuDefs;              /* EXT 0x8013d268 [$gp+0xd1c] */
static short  kMovingHighlight;              /* STAT 0x8013ddb8 [$gp+0x186c] */
static short  kMovingHighlightDir;           /* STAT 0x8013ddba [$gp+0x186e] */
static int    gBackDepth;                    /* STAT 0x8013ddbc [$gp+0x1870] */
static tPMenu *gPauseCurrentMenu;            /* STAT 0x8013ddc0 [$gp+0x1874] */
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


/* ---- tPauseMenuDefs  [MPAUSE.CPP:172-264] SLD-VERIFIED ---- */

#line 171 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
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
    iteratorAudioMode(InGameSelectListAudioMode,&GameSetup_gData.userSetting.audioMode),
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
    iteratorConfig(SelectListConfig,&GameSetup_gData.controllerData.controllerConfig[0],
                   &Device_gPausePortIndex),
    itemControllerSettingsTitle(0x14),
    itemControllerConfig(0x15,&iteratorConfig),
    itemControllerShockMode(0x1b,&GameSetup_gData.controllerData.shockMode[0],0x7f,
                            &Device_gPausePortIndex),
    itemControllerShockImpact(0x1c,&GameSetup_gData.controllerData.shockImpact[0],0x7f,
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

#line 267 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
tPauseMenuDefs::~tPauseMenuDefs()
{
}

/* ---- MPause_MusicLogic__Fc  [MPAUSE.CPP:290-371] SLD-VERIFIED ---- */
#line 287 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
void MPause_MusicLogic(char active)


{
  /* initialized => emitted into .sdata at this function (retail 0x8013d254..0x8013d264: 0,0,0,pad / 0x7f / 0 / 0) */
  static char wasActive = 0;
  static char testSFX = 0;
  static char playingSFX = 0;
  static int vol = 0x7f;
  static int SFXHandle = 0;
  static int lastplaytick = 0;
  int sndover;
  int samp;
  sndover = 1;
  samp = 0x10;

  switch (GameSetup_gData.userSetting.audioMode) {
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

  if (active != '\0')
  {
    if (wasActive == '\0') {


      AudioMus_AutoVolume(500,AudioCmn_MusicLevel(gMasterMusicLevel));
    }



    if ((gPauseCurrentMenu->CurrentItem() == 1) || (gPauseCurrentMenu->CurrentItem() == 2)) {
      AudioMus_Volume(AudioCmn_MusicLevel(gMasterMusicLevel));
    }
    testSFX = false;
    if (gPauseCurrentMenu->CurrentItem() == 3) {
      samp = 0x10; vol = gMasterSFXLevel; testSFX = true;
    } if (gPauseCurrentMenu->CurrentItem() == 4) {
      samp = 0x10; vol = gMasterFENarrationLevel; testSFX = true;
    } if (gPauseCurrentMenu->CurrentItem() == 5) {
      samp = 0x10; vol = gMasterEngineLevel; testSFX = true;
    } if (gPauseCurrentMenu->CurrentItem() == 6) {
      samp = 0x10; vol = gMasterAmbientLevel; testSFX = true;
    }
    if ((bool)testSFX != false)
    {
      if (playingSFX == '\0') {
        playingSFX = '\x01';
      }
      else { sndover = SNDover(SFXHandle);
      } if ((sndover != 0) && (0xc0 < gettick() - lastplaytick))
      {
        lastplaytick = gettick();
        SFXHandle = AudioCmn_PlaySound(gSndBnk[3].bnkID,samp,0,vol,0x40) ;
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


  wasActive = active; return;
}

/* ---- MPause_ControllerLogic__Fv  [MPAUSE.CPP:376-385] SLD-VERIFIED ---- */
/* SOURCE-SHAPE RECEIPT: the retail SYM block has no function local here;
   the same inline members are already used by MPause_StartPauseMenu and
   preserve the four transient $s0 item-address webs byte-for-byte without
   inventing a retained local.  Retail SLD puts both disables on one line and
   both enables on one line. */
#line 373 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
void MPause_ControllerLogic(void)


{
  if (PadGetState((u_int)(Device_gPausePortIndex != '\0') << 4) == 2)
  {

    gPauseMenuDefs->itemControllerShockMode.Disable(); gPauseMenuDefs->itemControllerShockImpact.Disable();
  }
  else
  {

    gPauseMenuDefs->itemControllerShockMode.Enable(); gPauseMenuDefs->itemControllerShockImpact.Enable();
  }
}

/* ---- MPause_Logic__Fv  [MPAUSE.CPP:390-486; supplied SYM/SLD contract verified, snapshot source identities open] ---- */
/* SOURCE-REVIEW-UNRESOLVED: oldItem retains real pre-ProcessInput history:
   Up from3 and Down from1 can both finish on2 but need opposite highlight
   offsets. This proves the needed old value, NOT a unique source object,
   local name or qualifier. Current const storage emits no .def and matches
   the supplied binding, but debug elision is not an originality exemption.
   ORIGINAL-NAME-UNRESOLVED: oldItem remains a descriptive reconstruction
   placeholder; no exact original identifier is supplied by current references. */
/* SOURCE-REVIEW-UNRESOLVED: newItem is not proved original by a failed
   reread. ItemEnabledNum's immutable18-word leaf has NO stores or calls;
   its advancing a0 is a register cursor, not selection mutation. The tested
   genuine receiver/argument graph still gives197/199 and18differences.
   ORIGINAL-NAME-UNRESOLVED: recover the actual value-binding producer/name.
   Receipt: build/tmp/v/mpause_selection_20261102_agent/required-value-object-evidence.json. */
#line 387 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
int MPause_Logic(void)


{
  tPMenuCommand command;
  tInputKeyType keyVal;
  bool debounce;
  keyVal = kInput_KeyType_NoKey;
  debounce = gPauseCurrentMenu->Debounce();

  if (Input_Interface(5,1))
    keyVal = kInput_KeyType_Cross;
  else if (Input_Interface(1,1))
    keyVal = kInput_KeyType_Up;
  else if (Input_Interface(2,1))
    keyVal = kInput_KeyType_Down;
  else if (Input_Interface(3,debounce))
    keyVal = kInput_KeyType_Left;
  else if (Input_Interface(4,debounce))
    keyVal = kInput_KeyType_Right;
  else if (Input_Interface(6,1))
    keyVal = kInput_KeyType_Start;
  else if (Input_Interface(0x18,1))
    keyVal = kInput_KeyType_Triangle;

  command.type = kMPause_NoEvent;

  if (kMovingHighlight == 0)



  { if (keyVal != kInput_KeyType_NoKey)
    {
      const int oldItem = gPauseCurrentMenu->CurrentItem();
      gMPauseUpdate = 1;
      gPauseCurrentMenu->ProcessInput(keyVal,command);

      const int newItem = gPauseCurrentMenu->CurrentItem();
      if ((short)oldItem != (short)newItem)
      {
        int start = gPauseCurrentMenu->ItemEnabledNum((short)oldItem) * 0xd + 0x6a;
        int finish = gPauseCurrentMenu->ItemEnabledNum((short)newItem) * 0xd + 0x6a;
        kMovingHighlight = start - finish;
        kMovingHighlightDir = (finish - start) / 10;
      }
    }

    else if (ChangedEnabling != 0)
    MPauseLogic_update: gMPauseUpdate = 1;
    else if (gMPauseUpdateNextTime != 0) {

      gMPauseUpdate = 1;
      gMPauseUpdateNextTime = 0;
    }

    else gMPauseUpdate = 0; } else goto MPauseLogic_update;

  if (command.type != kMPause_NoEvent)
  {

    if ((command.type & kMPause_CommandConfirmationFlag) != 0)
    {
      gPauseMenuDefs->itemConfirmTitle.SetTextDescription(gPauseCurrentMenu->CurrentItemText());
      gPauseMenuDefs->itemConfirmYes.SetCommand((tPMenuCommandType)(command.type & 0xff));
      gPauseMenuDefs->menuConfirmYesNo.SetCurrentItem(0);
      command.type = kMPause_GoToMenu;
      command.nextMenu = &gPauseMenuDefs->menuConfirmYesNo;
    }

    switch (command.type) {

    case kMPause_GoToMenu:
      gBackList[gBackDepth++] = gPauseCurrentMenu;

      gPauseCurrentMenu = command.nextMenu;
      gPauseCurrentMenu->Initialize();
      break;


    case kMPause_BackupMenu:
      if (gBackDepth > 0) {

        --gBackDepth;
        gPauseCurrentMenu = gBackList[gBackDepth];
        gPauseCurrentMenu->Initialize();
      } else {


        command.type = kMPause_Continue;
        return command.type;
      }
      break;

    default: return command.type;
      break;   /* DEVICE (exact-only): conventional case-terminating break; supplies retail's code-less line-91 note (switch end }92) */
    }
  }
  MPause_MusicLogic(gPauseCurrentMenu == (tPMenu *)(((int)gPauseMenuDefs) + 0x1c8));
  MPause_ControllerLogic();
  return 0;
}

/* ---- MPause_Render__Fv  [MPAUSE.CPP:490-530] SLD-VERIFIED ----
 * currentItem is supplied INT REG5 (retail2a14bc), not an unrecorded capture.
 * SOURCE-REVIEW-UNRESOLVED: y computes the real highlight coordinate, but its
 * original source object/name is not supplied. Combine folds it into the HUD
 * argument and drops its debug row; the declaring binding remains. First
 * scheduling makes the supplied31..33 region ZERO-LENGTH at+0xe4, not a
 * call-spanning lifetime. This explains output, not original-object necessity.
 * Existing APIs and same-owner NFS2 Render do not establish another producer.
 * Keep that question open, not an exact-only exemption or a guessed helper.
 * Receipt: build/tmp/v/mpause_render_review_20261102/receipt.md. */
#line 487 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
void MPause_Render(void)


{
  int numItems;
  ChangedEnabling = 0;





  if (kMovingHighlight > 0) {

    kMovingHighlight += kMovingHighlightDir;
    if (kMovingHighlight < 0) kMovingHighlight = 0;
  }
  else if (kMovingHighlight < 0) {

    kMovingHighlight += kMovingHighlightDir;
    if (kMovingHighlight > 0) kMovingHighlight = 0;
  }

  if (kMovingHighlight != 0)
    gPauseCurrentMenu->SetHighlight(false);
  else gPauseCurrentMenu->SetHighlight(true);

  gPauseCurrentMenu->Draw();

  numItems = gPauseCurrentMenu->NumEnabledItems();
  int currentItem = gPauseCurrentMenu->CurrentItem();


  if (kMovingHighlight != 0)
  {
    int y;   /* Source-object identity remains open; see the producer receipt above. */
    y = gPauseCurrentMenu->ItemEnabledNum(currentItem) * 0xd + 0x6a + kMovingHighlight;
    Hud_FBuildF4(1,0x50,y,0xa0,0xd,0,0,0);
  }
  else {

    Hud_FBuildF4(1,0x50,gPauseCurrentMenu->ItemEnabledNum(currentItem) * 0xd + 0x6a,0xa0,0xd,0,0,0);
  }

  Hud_RenderPauseBox(0x50,100,0xa0,(numItems + 1) * 0xd + 0x14);
}

/* ---- MPause_InitMPause__Fv  [MPAUSE.CPP:540-544] ----
 * The same function in NFS2 PC beta SYM records AUTO INT language, initialized
 * from the same GameSetup field in its matched source. This is cross-version
 * name/type evidence, not proof of NFS4's literal original declaration.
 * Stock combine folds the language load into the real call argument on543
 * while retaining the address HIGH note from541. Plain int is sufficient;
 * no const/debug-row suppression is needed. Complete native acceptance:
 * build/tmp/v/source_round_aq_20261102/proof.json. Literal syntax remains open. */
#line 537 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
void MPause_InitMPause(void)


{
  int language = GameSetup_gData.userSetting.language;

  TextSys_LoadInGame(language);
  gPauseMenuDefs = new tPauseMenuDefs;
}

/* ---- MPause_StartPauseMenu__Fv  [MPAUSE.CPP:548-593; supplied SYM/SLD contract verified] ----
 * SOURCE-REVIEW-UNRESOLVED: the music Enable caller contour supplies the
 * main-file579 note before its two real inline contours. Removing it keeps
 * bytes but loses two supplied region events and moves eleven work tags to
 * the preceding569 context. The same void Enable with an early-out guard
 * does not restore the ancestor and fails code matching. This demonstrates
 * the current producer, not the original literal grouping/macro/control
 * context. No fake predicate, declaration, scope-count helper or new API is
 * justified. Receipt: build/tmp/v/mpause_enable_scope_20261102_agent/proof.json. */
#line 545 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
void MPause_StartPauseMenu(void)


{
  gPauseCurrentMenu = &gPauseMenuDefs->menuPause;
  gPauseCurrentMenu->Initialize();

  gBackDepth = 0;



  if ((GameSetup_gData.raceType != RaceType_PinkSlips) && (GameSetup_gData.raceType != RaceType_Tournament))
  { gPauseMenuDefs->itemRestart.Enable(); }
  else
  { gPauseMenuDefs->itemRestart.Disable(); }

  if (GameSetup_gData.raceType == RaceType_PinkSlips)
  {

    gPauseMenuDefs->itemForfeitRace.Enable(); gPauseMenuDefs->itemQuitRace.Disable();
  }
  else
  {

    gPauseMenuDefs->itemForfeitRace.Disable(); gPauseMenuDefs->itemQuitRace.Enable();

  }







  {   /* Supplied caller contour; its original source grouping remains open. */
    gPauseMenuDefs->itemAudioSettingsMusicVolume.Enable();
  }

  if (Replay_ReplayMode >= 2)
  {
    gPauseMenuDefs->itemQuitRace.SetConfirmation(false);
    gPauseMenuDefs->itemRestart.SetConfirmation(false);
    gPauseMenuDefs->itemForfeitRace.SetConfirmation(false);
  }
  else
  {
    gPauseMenuDefs->itemQuitRace.SetConfirmation(true);
    gPauseMenuDefs->itemRestart.SetConfirmation(true);
    gPauseMenuDefs->itemForfeitRace.SetConfirmation(true);
  }
}

/* ---- MPause_EndPauseMenu__Fv  [MPAUSE.CPP:598-600] SLD-VERIFIED ---- */
#line 595 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
void MPause_EndPauseMenu(void)


{
  InGame_ResetPSXController((u_int)(u_char)Device_gPausePortIndex,
      GameSetup_gData.controllerData.controllerConfig[ (u_char)Device_gPausePortIndex]); return;
}

/* ---- MPause_KillMPause__Fv  [MPAUSE.CPP:605-610] SLD-VERIFIED ---- */
#line 602 "C:/nfs4/GAME/COMMON/MPAUSE.CPP"
void MPause_KillMPause(void)


{

  DrawSync(0);
  if (((int)gPauseMenuDefs) != 0) { delete gPauseMenuDefs;
  }
  TextSys_UnloadWords(); return;
}

/* end of mpause.cpp */
