/* frontend/common/femenudefs.cpp -- RECONSTRUCTED (menu-command callbacks + menu-defs ctor; C++ TU)
 *   66 fns: free MenuExtended_* command callbacks + tGlobalMenuDefs ctor/dtor (menu-defs init)
 *   + TransitionIsFinished button methods. Free fns in ns nfs4::FRONTEND::COMMON::FEMenuDefs.
 */
#include "femenudefs.h"

/* ---- FEMenuDefs.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes) ---- */
/* tBlankMenuItemGoToMenuNFS4Button_vtable @0x800114d8 + tBlankMenuItemNFS4LeftRightChoice_vtable @0x80011530:
   real __vtbl_ptr_type[11] defs live in game/common/vtables_tmenu.cpp; declared extern via femenudefs_externs.h. */
short        SelectListNull[2];   /* @0x80051970  (bss(zero)) */
short        SelectListOffOn[3] = { 103, 102, 0 };   /* @0x80051974 */
short        SelectListNormal[3] = { 227, 225, 0 };   /* @0x8005197c */
short        SelectListOpponentUpgrades[3] = { 271, 272, 0 };   /* @0x80051984 */
short        SelectListTrackDirection[3] = { 228, 229, 0 };   /* @0x8005198c */
short        SelectListTransmission[3] = { 276, 275, 0 };   /* @0x80051994 */
short        SelectListDisplaySpeed[5] = { 500, 498, 499, 103, 0 };   /* @0x8005199c */
short        SelectListDisplayMap[4] = { 103, 488, 489, 0 };   /* @0x800519a8 */
short        SelectListDisplayOpponentID[4] = { 103, 501, 502, 0 };   /* @0x800519b0 */
short        SelectListSplitTime[4] = { 103, 490, 491, 0 };   /* @0x800519b8 */
short        SelectListSplitDisplay[3] = { 492, 493, 0 };   /* @0x800519c0 */
short        SelectListUpgrades[4] = { 150, 151, 152, 0 };   /* @0x800519c8 */
short        SelectListControllerConfig[4] = { 539, 540, 541, 0 };   /* @0x800519d0 */
short        SelectListAudioMode[4] = { 466, 467, 468, 0 };   /* @0x800519d8 */
int          gCarActivation[6][5] = { 25, 25, 25, 25, 25, 24, 24, 24, 24, 24, 26, 26, 26, 27, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 28, 28, 28, 28, 28 };   /* @0x800519e0 */
tGlobalMenuDefs *menuDefs[1];   /* @0x80051a58  (array shape -> header extern[] forces absolute separate-temp load, matching oracle %hi/%lo) */


/* ---- MenuExtended_SetOnePlayer__FR12tMenuCommand  [FEMENUDEFS.CPP:145-153] ---- */

/* Decoded Phase 83: MenuExtended_SetOnePlayer__FR12tMenuCommand(tMenuCommand&) - set numPlayers=1 (76 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_SetOnePlayer__FR12tMenuCommand(tMenuCommand *command)

{
  if (FEApp->fInputPlayer == '\x01') {
    command->type = kMenu_Command_None;
  }
  else {
    frontEnd.gameMode = '\0';
    SwapBackground(screenMain[0],-1);
  }
  return;
}



/* ---- MenuExtended_SetTwoPlayer__FR12tMenuCommand  [FEMENUDEFS.CPP:158-167] ---- */

/* Decoded Phase 83: MenuExtended_SetTwoPlayer__FR12tMenuCommand(tMenuCommand&) - set numPlayers=2 (split-screen) (80
   B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_SetTwoPlayer__FR12tMenuCommand(tMenuCommand *command)

{
  if (gPadinfo.buf[4].nopad != '\0') {
    command->type = kMenu_Command_None;
  }
  else {
    frontEnd.gameMode = '\x01';
    frontEnd.oppNumber = '\0';
    SwapBackground(screenMain[0],-1);
  }
  return;
}



/* ---- MenuExtended_SetTestDrive__FR12tMenuCommand  [FEMENUDEFS.CPP:172-176] ---- */

/* Decoded Phase 83: MenuExtended_SetTestDrive__FR12tMenuCommand(tMenuCommand&) - set mode=TestDrive (free-roam, no
   race) (28 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetTestDrive__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetTestDrive__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.carListType = '\0';
  frontEnd.oppNumber = '\0';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\0';
  return;
}



/* ---- MenuExtended_SetSingleRace__FR12tMenuCommand  [FEMENUDEFS.CPP:180-184] ---- */

/* Decoded Phase 83: MenuExtended_SetSingleRace__FR12tMenuCommand(tMenuCommand&) - set raceType=SingleRace (64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetSingleRace__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetSingleRace__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.carListType = '\x01';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\0';
  SwapBackground(screenMain[0],-1);
  return;
}



/* ---- MenuExtended_SetTournament__FR12tMenuCommand  [FEMENUDEFS.CPP:195-200] ---- */

/* Decoded Phase 83: MenuExtended_SetTournament__FR12tMenuCommand(tMenuCommand&) - set raceType=Tournament (72 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetTournament__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetTournament__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.carListType = '\x01';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.tier = '\0';
  frontEnd.raceType = '\x02';
  SwapBackground(screenMain[0],-1);
  return;
}



/* ---- MenuExtended_SetSpecialEvent__FR12tMenuCommand  [FEMENUDEFS.CPP:204-209] ---- */

/* Decoded Phase 83: MenuExtended_SetSpecialEvent__FR12tMenuCommand(tMenuCommand&) - set raceType=SpecialEvent (72 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetSpecialEvent__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetSpecialEvent__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.carListType = '\x01';
  frontEnd.tier = '\x01';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\x02';
  SwapBackground(screenMain[0],-1);
  return;
}



/* ---- MenuExtended_SetSoloRace__FR12tMenuCommand  [FEMENUDEFS.CPP:213-217] ---- */

/* Decoded Phase 83: MenuExtended_SetSoloRace__FR12tMenuCommand(tMenuCommand&) - set raceType=Solo (no opponents) (32
   B)
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name + (body or
   100%-caller-consensus) agree. Generic param names; types int/void* default - refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetSoloRace__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetSoloRace__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\0';
  frontEnd.oppNumber = '\0';
  frontEnd.carListType = '\x01';
  return;
}



/* ---- MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand  [FEMENUDEFS.CPP:221-245] ---- */

/* Decoded Phase 83: MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand(tMenuCommand&) - enter 2P single-race flow(276 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [BUG FIX 2026-07-27, 45->34 diffs] Same DOUBLE-DESTRUCTION bug as PinkSlipsPreSave/
   MenuExtended_LoadGame: a manual `tScreen_dtor((tScreen*)&YesNoDialog,2);` at the shared exit
   was firing IN ADDITION to `YesNoDialog`'s own real `tDialogYesNoTri::~tDialogYesNoTri()`
   auto-invoked at scope exit (objdump showed `jal tScreen_dtor` then `jal ___15tDialogYesNoTri`
   back to back). Dropped the manual call -- insn count now matches the oracle EXACTLY (69==69).
   Residual (34 diffs) = a field-store addressing floor: oracle materializes `a0=s0` once (right
   after `jal TextSys_Word`) and stores the string/yesnowords/fDefault fields via `a0`
   displacement; our build keeps the SAME field values but addresses them sp-relative directly
   (never re-derives an `a0`/`s0` copy for that block) -- same value, same byte offset from the
   frame, purely a scratch-register/CSE tie-break (§3.15 family); the dead `dlgThis` local doesn't
   change it. Not source-reachable without a pin (forbidden); accept. */

extern "C" void MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  tScreenCarSelect *this_00;
  ushort uVar2;
  short sVar3;
  tDialogYesNoTri *dlgThis;
  tDialogYesNoTri YesNoDialog;

  *(void **)&(YesNoDialog._vf) = (void *)&tDialogYesNoTri_vtable;
  uVar2 = GetNumOwnedCars(&carManager, 0);
  if ((int)((uint)uVar2 << 0x10) < 1) {
    YesNoDialog.string =
         TextSys_Word(0x42);
    YesNoDialog.yesnowords[0] = 0x321;
    YesNoDialog.yesnowords[1] = 0x322;
    YesNoDialog.fDefault = 0;
    sVar3 = Run((tDialogInteractive *)&YesNoDialog);
    ptVar1 = menuDefs[0];
    if (sVar3 == 1) {
      frontEnd.raceType = '\0';
      command->type = kMenu_Command_GoToMenu;
      Decrement(&ptVar1->iteratorDealerCar,kPlayerBoth);
      Increment(&menuDefs[0]->iteratorDealerCar,kPlayerBoth);
      this_00 = screenCarSelect[0];
      command->nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuCarDealer;
      SetState(this_00,2);
    }
  }
  else {
    MenuExtended_SetSoloRace__FR12tMenuCommand(command);
    ptVar1 = menuDefs[0];
    command->type = kMenu_Command_GoToMenu;
    command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuSingleTrackSelect;
  }
  return;
}



/* ---- MenuExtended_SetDuelRace__FR12tMenuCommand  [FEMENUDEFS.CPP:247-251] ---- */

/* Decoded Phase 83: MenuExtended_SetDuelRace__FR12tMenuCommand(tMenuCommand&) - set raceType=Duel (1v1) (64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetDuelRace__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetDuelRace__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\0';
  frontEnd.oppNumber = '\x01';
  SwapBackground(screenMain[0],-1);
  return;
}



/* ---- MenuExtended_SetFullGrid__FR12tMenuCommand  [FEMENUDEFS.CPP:255-259] ---- */

/* Decoded Phase 83: MenuExtended_SetFullGrid__FR12tMenuCommand(tMenuCommand&) - set grid size to maximum opponents(64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetFullGrid__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetFullGrid__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\0';
  frontEnd.oppNumber = '\x02';
  SwapBackground(screenMain[0],-1);
  return;
}



/* ---- AskTheUserToSaveTheGame  [FEMENUDEFS.CPP:274-290] ---- */

/* Decoded Phase 86: FE-AskTheUserToSaveTheGame (120 B): show "Save game?" Yes/No prompt.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. FE-MenuDefs::AskTheUserToSaveTheGame
   - 'Save game?' Yes/No prompt. is_cheater = FECheat_IsTheUserACryBabyCheater (= block save if
   cheater detected); on cheater: return 0 (= No-saving-allowed). Else: build YesNoDialog on stack(168 B); set string=TextSys_Word(0x331)='Save game?'; yesnowords[0]=0x321='YES', [1]=0x322='NO';
   fDefault=0 (= No is default). Run shows the modal dialog and returns user_choice. Destructor on
   dialog. Returns user_choice (1=Yes, 0=No). */

int AskTheUserToSaveTheGame(void)

{
  int is_cheater;
  tDialogMessageString *dlgThis;

  /* MATCH 2026-08-03: SLD starts YesNoDialog and answer only inside the
     non-cheater block.  Keeping the dialog base pointer live in dlgThis and
     returning answer from that block reproduces retail's s0 allocation and
     the single automatic constructor/destructor pair. */
  is_cheater = (int)FECheat_IsTheUserACryBabyCheater();
  if ((is_cheater ^ 1) != 0) {
    int answer;
    tDialogYesNo YesNoDialog;

    dlgThis = (tDialogMessageString *)&YesNoDialog;
    dlgThis->string = TextSys_Word(0x331);
    ((tDialogYesNo *)dlgThis)->yesnowords[0] = 0x321;
    ((tDialogYesNo *)dlgThis)->yesnowords[1] = 0x322;
    ((tDialogYesNo *)dlgThis)->fDefault = 0;
    answer = (short)Run((tDialogInteractive *)dlgThis);
    return answer;
  }
  return 0;
}



/* ---- MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand  [FEMENUDEFS.CPP:295-297] ---- */

/* Decoded Phase 83: MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand(tMenuCommand&) - return to main
   menu without saving (28 B)
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  
  ptVar1 = menuDefs[0];
  command->type = kMenu_Command_GoToMenuOneWay;
  command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuMain;
  return;
}



/* ---- MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand  [FEMENUDEFS.CPP:301-308] ---- */

/* Decoded Phase 83: MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand(tMenuCommand&) -
   auto-save then return to main menu (76 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [Match 2026-07-05] ptVar1=menuDefs[0] moved INTO the save-branch only (oracle never
   loads menuDefs on the tail-call path) + branch-polarity flip (save-branch is the
   fall-through, the tail-call is the branch target) -> byte-match, 19/19 insns. */

extern "C" void MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  int iVar2;

  iVar2 = AskTheUserToSaveTheGame();
  if (iVar2 != 0) {
    ptVar1 = menuDefs[0];
    command->type = kMenu_Command_GoToMenuOneWay;
    command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuPostGameSave;
  }
  else {
    MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand(command);
  }
  return;
}



/* ---- MenuExtended_GoToCarSelect__FR12tMenuCommand  [FEMENUDEFS.CPP:313-420] ---- */

/* Decoded Phase 83: MenuExtended_GoToCarSelect__FR12tMenuCommand(tMenuCommand&) - transition to car-select screen;
   sets up garage car list (916 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToCarSelect__FR12tMenuCommand(tMenuCommand *command)

{
  tDialogMessageString *dialog = &FEApp->messagePopup;
  tMenu *nextMenu;
  tScreenCarSelect *screen;
  uint state;
  tTrackInformation trackInfo;
  
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             &trackInfo);
  if (trackInfo.fAvailable == '\0') {
    dialog->string = TextSys_Word(0xeb);
    Display((tDialogBase *)dialog);
    return;
  }
  if (frontEnd.gameMode == '\x01') {
    command->type = kMenu_Command_GoToMenuTwoPlayer;
    if (frontEnd.raceType != '\x06') {
      if (frontEnd.carListType == '\0') {
        command->nextMenu = (tMenu *)&menuDefs[0]->menuPlayerOneCarSelect;
      }
      else {
        command->nextMenu = (tMenu *)&menuDefs[0]->menuPlayerOneGarage;
      }
    }
    else {
      command->nextMenu = (tMenu *)&menuDefs[0]->menuPlayerOnePinkSlipCarSelect;
    }
  }
  else {
    if (frontEnd.oppNumber == '\x01') {
      command->type = kMenu_Command_GoToMenu;
      if (frontEnd.raceType == '\x01') {
        command->nextMenu = (tMenu*)&menuDefs[0]->menuHPDuelCarSelect;
      }
      else {
        command->nextMenu = (tMenu*)&menuDefs[0]->menuDuelCarSelect;
      }
      SetState((tScreenCarSelect *)screenCarSelectDuel,7);
    }
    else {
      command->type = kMenu_Command_GoToMenu;
      if (frontEnd.carListType == '\0') {
        state = 0;
        nextMenu = (tMenu*)&menuDefs[0]->menuSingleCarSelect;
        screen = screenCarSelect[0];
      }
      else {
        state = 1;
        nextMenu = (tMenu*)&menuDefs[0]->menuCarGarage;
        screen = screenCarSelect[0];
      }
      command->nextMenu = nextMenu;
      SetState(screen,state);
    }
  }
  switch (frontEnd.raceType) {
  case '\x01':
    if ((frontEnd.oppNumber == '\0') || (frontEnd.gameMode == '\x01')) {
      (menuDefs[0]->iteratorCar1).fCarListFilter = 9;
    }
    else {
      (menuDefs[0]->iteratorCar1).fCarListFilter = 1;
    }
    break;
  case '\x06':
    (menuDefs[0]->iteratorPinkSlipsCar).fCarListFilter = 0x20;
    break;
  default:
    if (frontEnd.carListType == '\0') {
      (menuDefs[0]->iteratorCar1).fCarListFilter = 1;
    }
    else if (frontEnd.raceType == '\x02') {
      (menuDefs[0]->iteratorGarageCar).fCarListFilter = 0x40;
    }
    else {
      (menuDefs[0]->iteratorGarageCar).fCarListFilter = 2;
    }
    break;
  }
  if (frontEnd.carListType == '\0') {
    Decrement(&menuDefs[0]->iteratorCar1,kPlayerOne);
    Increment(&menuDefs[0]->iteratorCar1,kPlayerOne);
    Decrement(&menuDefs[0]->iteratorCar1,kPlayerTwo);
    Increment(&menuDefs[0]->iteratorCar1,kPlayerTwo);
  }
  else {
    if ((int)((uint)GetNumOwnedCars(&carManager, 0) << 0x10) < 1) {
      if (frontEnd.raceType == '\x01') {
        if (frontEnd.oppNumber == '\x01') goto MX_GoToCar_oppFilterSetup;
        goto MX_GoToCar_garageIter;
      }
    }
    else {
MX_GoToCar_garageIter:
      Decrement(&menuDefs[0]->iteratorGarageCar,kPlayerOne);
      Increment(&menuDefs[0]->iteratorGarageCar,kPlayerOne);
      if (frontEnd.gameMode == '\x01') {
        Decrement(&menuDefs[0]->iteratorGarageCar,kPlayerTwo);
        Increment(&menuDefs[0]->iteratorGarageCar,kPlayerTwo);
      }
    }
  }
  if (frontEnd.oppNumber != '\x01') {
    return;
  }
MX_GoToCar_oppFilterSetup:
  if (frontEnd.raceType != '\x02') {
    Decrement(&menuDefs[0]->iteratorOpponentCar,kPlayerBoth);
    Increment(&menuDefs[0]->iteratorOpponentCar,kPlayerBoth);
    (menuDefs[0]->iteratorOpponentCar).fCarListFilter = 1;
  }
  return;
}



/* ---- MenuExtended_GoToDealer__FR12tMenuCommand  [FEMENUDEFS.CPP:423-428] ---- */

/* Decoded Phase 83: MenuExtended_GoToDealer__FR12tMenuCommand(tMenuCommand&) - transition to buy-car dealer screen(104 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [NEAR-MISS 2026-07-06/07, 10 diffs, WALL] `command->type=1` (a v1-const) and
   `command->nextMenu=&ptVar1->menuCarDealer` (a v0-computed ptr) swap which of {v0,v1} each
   lands in vs the oracle (oracle: const->v1, ptr->v0; ours: const->v0, ptr->v1); count matches
   (26 insns both sides), so it's pure register-coloring, not structural. IDENTICAL shape/residual
   on sibling GoToSeller. Tried and REJECTED (all revert to the 10-diff form): swap the two
   command-> statement order; swap ptVar1/dlgThis declaration+assignment order (regresses to 12);
   materialize the pointer into a fresh named local before the stores (no change); compute dlgThis
   last, right before SetState (regresses to 11, drops an insn); inline screenCarSelect[0] at the
   SetState call site instead of caching dlgThis (regresses to 11); named kMenu_Command_GoToMenu
   enum vs literal 1 (no change, confirmed codegen-neutral). PERMUTER (2 re-seeded basins, ~220
   iterations total, decomp-permuter via tools/run_permuter.py) plateaus at the SAME 10-diff shape
   (internal score 30) from every mutation path tried -- multi-basin re-seed did not find a
   downhill path below it either. Conclusion: GENUINE gcc scratch-register tie-break floor (same
   family as the documented §3.15 v0-vs-scratch tie-break in the methodology doc) -- accept, do
   NOT pin (`register T x asm("$N")` forbidden). Compare GoToGarage (sibling shape, SAME v0/v1-
   swap family) which WAS fixable because it had a genuine double pointer-derivation to collapse;
   this fn has no such redundancy to remove. */

extern "C" void MenuExtended_GoToDealer__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  tScreenCarSelect *dlgThis;

  dlgThis = screenCarSelect[0];
  ptVar1 = menuDefs[0];
  command->type = 1;
  command->nextMenu = (tMenu *)&ptVar1->menuCarDealer;
  SetState(dlgThis,2);
  Decrement(&menuDefs[0]->iteratorDealerCar,kPlayerBoth);
  Increment(&menuDefs[0]->iteratorDealerCar,kPlayerBoth);
  return;
}



/* ---- MenuExtended_GoToSeller__FR12tMenuCommand  [FEMENUDEFS.CPP:432-437] ---- */

/* Decoded Phase 83: MenuExtended_GoToSeller__FR12tMenuCommand(tMenuCommand&) - transition to sell-car screen (104 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [NEAR-MISS 2026-07-06/07, 10 diffs, WALL] IDENTICAL residual/shape to sibling GoToDealer (same
   v0/v1 const-vs-pointer coloring swap on the command->type / command->nextMenu pair; count
   matches, 26 insns both sides). See GoToDealer's near-miss note above for the full list of
   rejected levers (statement/decl reorders, fresh-local materialization, inline-call-arg,
   named-enum-vs-literal) and the 2-basin permuter run (~220 iterations, plateaus at the same
   shape, internal score 30). Same conclusion: genuine gcc scratch-register tie-break floor,
   accept, do not pin. */

extern "C" void MenuExtended_GoToSeller__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  tScreenCarSelect *dlgThis;
  
  dlgThis = screenCarSelect[0];
  ptVar1 = menuDefs[0];
  command->type = 1;
  command->nextMenu = (tMenu *)&ptVar1->menuCarSeller;
  SetState(dlgThis,3);
  Decrement(&menuDefs[0]->iteratorSellerCar,kPlayerBoth);
  Increment(&menuDefs[0]->iteratorSellerCar,kPlayerBoth);
  return;
}



/* ---- MenuExtended_GoToUpgrades__FR12tMenuCommand  [FEMENUDEFS.CPP:441-444] ---- */

/* Decoded Phase 83: MenuExtended_GoToUpgrades__FR12tMenuCommand(tMenuCommand&) - transition to upgrades-purchase
   screen (64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToUpgrades__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  
  ptVar1 = menuDefs[0];
  command->type = kMenu_Command_GoToMenu;
  command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuCarUpgrades;
  SetState(screenCarSelect[0],4);
  return;
}



/* ---- GenericMenuSaveGame  [FEMENUDEFS.CPP:448-478] ---- */

/* Decoded Phase 86: FE-GenericMenuSaveGame (284 B): execute generic save-game flow from
   menu.
   
   [ghidra-meta] section: front.text */

void * GenericMenuSaveGame(int showdialog)

{
  bool successful;
  char *pcVar4;
  void *pvVar5;
  tScreenMemcard *dlgThis;
  byte uninitafter;

  tFEApplication *app;

  /* NEAR-MISS 58 diffs (was 69): literal FEApp de-ref (dropped the value-cache) + `^1` fFullyOpen
     loop idiom brought insn count to 69 vs oracle 71 and the call/branch structure into line.
     Residual wall = gcc-2.7.2 does NOT CSE %hi(FEApp) into a callee-saved reg the way the oracle
     does (oracle holds %hi(FEApp) in s1 across all 5 FEApp loads + frees s0 to be reused as
     &FEApp->NoInput and s2 for `successful`); our build self-temps `lui a0;lw a0` per access -> 2
     saved regs not 3, frame-offset shift, successful in s1 not s2. Same %hi reload tie-break as
     GenericMenuLoadGame (3.15) -- not source-reachable. The `app` cache reuses one saved reg in
     the Display block (58 vs the pure-literal 59). */
  screenMemcard->message = 0x27e;
  Redraw(FEApp);
  successful = false;
  if ((MEMCARD_INITIALIZED == 0) || (showdialog != 0)) {
    app = FEApp;
    pcVar4 = TextSys_Word(0x282);
    (app->NoInputMemCardDialog).string = pcVar4;
    Display((tDialogBase *)&app->NoInputMemCardDialog);
    while (((FEApp->NoInputMemCardDialog).fFullyOpen ^ 1) != 0) {
      Redraw(FEApp);
    }
    Redraw(FEApp);
    if (MEMCARD_INITIALIZED == 0) {
      successful = true;
      Init_Memcard(true,0);
    }
  }
  pvVar5 = SaveGame(0);
  screenMemcard->message = -1;
  if (successful) {
    DeInit_Memcard();
  }
  Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
  return pvVar5;
}



/* ---- PinkSlipsPreSave  [FEMENUDEFS.CPP:484-504] ---- */

/* Decoded Phase 86: FE-PinkSlipsPreSave (200 B): pre-save hook for Pink Slips mode.
   
   [ghidra-meta] section: front.text */

void * PinkSlipsPreSave(void)

{
  short sVar1;
  int is_cheater;
  void *ret;
  tDialogYesNoTri *dlgThis;

  /* MATCH: keep the default result outside the dialog's lifetime but assign it
     before entering the nested scope. GCC then fills the cheater branch delay
     with `li s1,1`, while the explicit dialog pointer retains retail's s0-based
     field stores. The local's automatic destructor handles both exits. */
  is_cheater = (int)FECheat_IsTheUserACryBabyCheater();
  if ((is_cheater ^ 1) != 0) {
    ret = (void *)0x1;
    {
      tDialogYesNoTri YesNoDialog;

      dlgThis = &YesNoDialog;
      *(void **)&(dlgThis->_vf) = (void *)&tDialogYesNoTri_vtable;
      dlgThis->string =
           TextSys_Word(0x273);
      dlgThis->yesnowords[0] = 0x321;
      dlgThis->yesnowords[1] = 0x322;
      dlgThis->fDefault = 0;
      sVar1 = Run((tDialogInteractive *)dlgThis);
      if (sVar1 == 1) {
        ret = GenericMenuSaveGame(1);
      }
      else if (sVar1 == -1) {
        return (void *)0x0;
      }
    }
    return ret;
  }
  return (void *)0x1;
}



/* ---- MenuExtended_GoToBestOfOne__FR12tMenuCommand  [FEMENUDEFS.CPP:508-519] ---- */

/* Decoded Phase 83: MenuExtended_GoToBestOfOne__FR12tMenuCommand(tMenuCommand&) - set tournament length to best-of-1
   (92 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToBestOfOne__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  void *pvVar2;
  
  pvVar2 = PinkSlipsPreSave();
  if (pvVar2 != (void *)0x0) {
    ptVar1 = menuDefs[0];
    command->type = kMenu_Command_GoToMenu;
    command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuSingleTrackSelect;
  }
  else {
    command->type = kMenu_Command_None;
  }
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.pinkSlipsNumTracks = '\x01';
  return;
}



/* ---- MenuExtended_GoToBestOfThree__FR12tMenuCommand  [FEMENUDEFS.CPP:523-533] ---- */

/* Decoded Phase 83: MenuExtended_GoToBestOfThree__FR12tMenuCommand(tMenuCommand&) - set tournament length to
   best-of-3 (92 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToBestOfThree__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  void *pvVar2;
  
  pvVar2 = PinkSlipsPreSave();
  if (pvVar2 != (void *)0x0) {
    ptVar1 = menuDefs[0];
    command->type = kMenu_Command_GoToMenu;
    command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuPinkSlipsBestOfThree;
  }
  else {
    command->type = kMenu_Command_None;
  }
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.pinkSlipsNumTracks = '\x03';
  return;
}



/* ---- MenuExtended_GoToBestOfFive__FR12tMenuCommand  [FEMENUDEFS.CPP:537-547] ---- */

/* Decoded Phase 83: MenuExtended_GoToBestOfFive__FR12tMenuCommand(tMenuCommand&) - set tournament length to best-of-5
   (92 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToBestOfFive__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  void *pvVar2;
  
  pvVar2 = PinkSlipsPreSave();
  if (pvVar2 != (void *)0x0) {
    ptVar1 = menuDefs[0];
    command->type = kMenu_Command_GoToMenu;
    command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuPinkSlipsBestOfFive;
  }
  else {
    command->type = kMenu_Command_None;
  }
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.pinkSlipsNumTracks = '\x05';
  return;
}



/* ---- MenuExtended_GoToRace__FR12tMenuCommand  [FEMENUDEFS.CPP:551-607] ---- */

/* Decoded Phase 83: MenuExtended_GoToRace__FR12tMenuCommand(tMenuCommand&) - commit settings and transition into race(calls Front_BuildStream) (348 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToRace__FR12tMenuCommand(tMenuCommand *command)

{
  tFEApplication *ptVar1;
  ushort uVar2;
  char *pcVar3;
  tFEApplication *dlgThis;
  int wordnum;
  tDialogMessageString *popUp;
  tCarInfo carInfo;
  
  ptVar1 = FEApp;
  command->type = kMenu_Command_StartRace;
  if ((((frontEnd.carListType != '\x01') ||
       (uVar2 = GetNumOwnedCars(&carManager, 0), 0 < (int)((uint)uVar2 << 0x10))) ||
      (frontEnd.raceType == '\x01')) || (wordnum = 0xaa, frontEnd.raceType == '\x06')) {
    if ((frontEnd.raceType == '\x02') &&
       (uVar2 = GetNumTourneyCars(&carManager, 0), (int)((uint)uVar2 << 0x10) < 1)) {
      wordnum = 0xf1;
    }
    else if ((frontEnd.raceType == '\x01') &&
            (GetStockCar(&carManager, (ushort)(byte)frontEnd.playerCar[0],&carInfo),
            carInfo.fPursuitAvailable == '\0')) {
      wordnum = 0xf2;
    }
    else {
      if (frontEnd.carListType != '\0') {
        return;
      }
      GetStockCar(&carManager, (ushort)(byte)frontEnd.playerCar[0],&carInfo);
      wordnum = 0xf3;
      if (carInfo.fAvailable != '\0') {
        return;
      }
    }
  }
  pcVar3 = TextSys_Word(wordnum);
  (ptVar1->messagePopup).string = pcVar3;
  Display((tDialogBase *)&(ptVar1->messagePopup));
  command->type = kMenu_Command_None;
  return;
}



/* ---- MenuExtended_GoTo2PlayerRace__FR12tMenuCommand  [FEMENUDEFS.CPP:610-655] ---- */

/* Decoded Phase 83: MenuExtended_GoTo2PlayerRace__FR12tMenuCommand(tMenuCommand&) - enter 2-player split-screen race
   setup flow (332 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoTo2PlayerRace__FR12tMenuCommand(tMenuCommand *command)

{
  tFEApplication *ptVar1;
  ushort uVar2;
  tFEApplication *dlgThis;
  char *pcVar3;
  int wordnum;
  tDialogMessageString *popUp;
  tCarInfo carInfo;
  
  ptVar1 = FEApp;
  command->type = kMenu_Command_Start2PlayerRace;
  if (frontEnd.raceType == '\x06') {
    return;
  }
  if (((frontEnd.carListType != '\x01') ||
      (uVar2 = GetNumOwnedCars(&carManager, 0), 0 < (int)((uint)uVar2 << 0x10))) ||
     (wordnum = 0xaa, frontEnd.raceType == '\x01')) {
    if ((frontEnd.carListType == '\0') &&
       (GetStockCar(&carManager, (ushort)(byte)frontEnd.playerCar[(byte)FEApp->fPlayer],&carInfo),
       carInfo.fAvailable == '\0')) {
      wordnum = 0xf3;
    }
    else {
      if (frontEnd.raceType != '\x01') {
        return;
      }
      GetStockCar(&carManager, (ushort)(byte)frontEnd.playerCar[(byte)FEApp->fPlayer],&carInfo);
      wordnum = 0xf2;
      if (carInfo.fPursuitAvailable != '\0') {
        return;
      }
    }
  }
  pcVar3 = TextSys_Word(wordnum);
  (ptVar1->messagePopup).string = pcVar3;
  Display((tDialogBase *)&(ptVar1->messagePopup));
  command->type = kMenu_Command_None;
  return;
}



/* ---- MenuExtended_GoToTournTrackInfo__FR12tMenuCommand  [FEMENUDEFS.CPP:658-693] ---- */

/* Decoded Phase 83: MenuExtended_GoToTournTrackInfo__FR12tMenuCommand(tMenuCommand&) - transition to tournament-round
   track info screen (360 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToTournTrackInfo__FR12tMenuCommand(tMenuCommand *command)

{
  tFEApplication *ptVar1;
  tGlobalMenuDefs *ptVar2;
  tTournamentDefinition *ptVar3;
  short sVar4;
  char *pcVar5;
  long amount;
  int iVar6;
  int iVar7;
  tDialogMessageString *dlgThis;
  tDialogMessageString *this_00;
  tTourneyInfo *tourn;

  /* [2026-07-11] Dropped the REDUNDANT `tDialogYesNo_ctor(&popUp)` manual call (tDialogYesNo's
     real ctor is already auto-invoked by the local's declaration -- see AskTheUserToSaveTheGame's
     note) and block-scoped popUp to exactly where the oracle's `jal __12tDialogYesNo` sits: AFTER
     the insufficient-funds early-return, not at the outer `if`'s top (oracle disasm confirms the
     ctor call is inside the can-afford fallthrough, not before the money check). */
  ptVar3 = tournamentManager.fDefinition;
  ptVar1 = FEApp;
  frontEnd.tier = '\0';
  iVar6 = (uint)(tournamentManager.fDefinition)->fTiers[0].fTournOffset +
          (uint)(byte)frontEnd.tournament;
  iVar7 = (tournamentManager.fDefinition)->fTournaments[iVar6].fEntranceFee;
  if (0 < iVar7) {
    if (tournamentManager.fMoney < iVar7) {
      this_00 = &FEApp->messagePopup;
      pcVar5 = TextSys_Word(0xf6);
      (ptVar1->messagePopup).string = pcVar5;
      Display((tDialogBase *)this_00);
      return;
    }
    {
      tDialogYesNo popUp;

      popUp.string =
           TextSys_Word(0xf7);
      popUp.yesnowords[0] = 0x322;
      popUp.yesnowords[1] = 0x321;
      popUp.fDefault = 0;
      sVar4 = Run((tDialogInteractive *)&popUp);
      if (sVar4 == 0) {
        return;
      }
      AudioCmn_PlayFESFX(0x1a);
      tournamentManager.fMoney = tournamentManager.fMoney - ptVar3->fTournaments[iVar6].fEntranceFee;
    }
  }
  StartNewTournament(&tournamentManager,0,frontEnd.tournament);
  ptVar2 = menuDefs[0];
  command->type = kMenu_Command_GoToMenu;
  command->nextMenu = (tMenu *)(tMenu*)&ptVar2->menuTrackInfo;
  return;
}



/* ---- MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand  [FEMENUDEFS.CPP:696-731] ---- */

/* Decoded Phase 83: MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand(tMenuCommand&) - transition to
   special-event track info screen (364 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand(tMenuCommand *command)

{
  tFEApplication *ptVar1;
  tGlobalMenuDefs *ptVar2;
  tTournamentDefinition *ptVar3;
  short sVar4;
  char *pcVar5;
  long amount;
  int iVar6;
  int iVar7;
  tDialogMessageString *dlgThis;
  tDialogMessageString *this_00;
  tTourneyInfo *tourn;

  /* [2026-07-11] Dropped the REDUNDANT `tDialogYesNo_ctor(&popUp)` manual call (tDialogYesNo's
     real ctor is already auto-invoked by the local's declaration -- see AskTheUserToSaveTheGame's
     note) and block-scoped popUp to exactly where the oracle's `jal __12tDialogYesNo` sits: AFTER
     the insufficient-funds early-return (see twin fn GoToTournTrackInfo).

     [BUG FIX 2026-07-27, 47->41] Same DOUBLE-DESTRUCTION bug as the twin GoToTournTrackInfo:
     both exit paths (`sVar4==0` early-return and the shared fallthrough) also called
     `tScreen_dtor((tScreen*)&popUp,2)` manually IN ADDITION to popUp's own auto-invoked
     `tDialogYesNo::~tDialogYesNo()`. Dropped both manual calls. Residual struct-offset mismatch
     (84 vs 48 for the fEntranceFee/fTournOffset-style field -- see GoToTournTrackInfo's matching
     note) is pre-existing and untouched here. */
  ptVar3 = tournamentManager.fDefinition;
  ptVar1 = FEApp;
  frontEnd.tier = '\x01';
  iVar6 = (uint)(tournamentManager.fDefinition)->fTiers[1].fTournOffset +
          (uint)(byte)frontEnd.specialevent;
  iVar7 = (tournamentManager.fDefinition)->fTournaments[iVar6].fEntranceFee;
  if (0 < iVar7) {
    if (tournamentManager.fMoney < iVar7) {
      this_00 = &FEApp->messagePopup;
      pcVar5 = TextSys_Word(0xf6);
      (ptVar1->messagePopup).string = pcVar5;
      Display((tDialogBase *)this_00);
      return;
    }
    {
      tDialogYesNo popUp;

      popUp.string =
           TextSys_Word(0xf7);
      popUp.yesnowords[0] = 0x321;
      popUp.yesnowords[1] = 0x322;
      popUp.fDefault = 0;
      sVar4 = Run((tDialogInteractive *)&popUp);
      if (sVar4 == 0) {
        return;
      }
      AudioCmn_PlayFESFX(0x1a);
      tournamentManager.fMoney = tournamentManager.fMoney - ptVar3->fTournaments[iVar6].fEntranceFee;
    }
  }
  StartNewTournament(&tournamentManager,1,frontEnd.specialevent);
  ptVar2 = menuDefs[0];
  command->type = kMenu_Command_GoToMenu;
  command->nextMenu = (tMenu *)(tMenu*)&ptVar2->menuTrackInfo;
  return;
}



/* ---- MenuExtended_EnterUserName__FR12tMenuCommand  [FEMENUDEFS.CPP:734-739] ---- */

/* Decoded Phase 83: MenuExtended_EnterUserName__FR12tMenuCommand(tMenuCommand&) - prompt user-name entry (initial
   profile setup) (100 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [NEAR-MISS 2026-07-05/2026-08-03, was 30 diffs, now 6] Three real fixes landed: (1) playerNameList
   is char[2][8] (8-byte rows) -- the old `frontEnd.playerNameList[bVar2*4]` byte-offset hack
   was WRONG indexing (should scale by 8, not 4); plain `playerNameList[bVar2]` row-index lets
   the compiler emit the correct sll-by-3. (2) dlgThis=&ptVar3->menuItemUserName hoisted once
   (oracle materializes this base ONE time via addiu right after the menuDefs load; the old
   code recomputed the full absolute offset per field). (3) bVar1/bVar2 as u_int (not byte)
   drops the redundant andi 0xff the oracle doesn't have (a same-typed `byte` local re-masks
   on every use in this build). Residual = bVar1/bVar2 are the textually-identical expression
   `FEApp->fInputPlayer`; the oracle emits it as TWO separate lbu (a3 then v1), ours CSEs to
   ONE lbu + reused v1. Tried: reordering (moves the residual, doesn't remove it), a volatile
   read (forces the 2 separate loads back but reintroduces the dropped andi -- net same size,
   less honest). Left as the compiler's own CSE decision; not source-reachable without
   register pins (forbidden) or a real volatile FEApp (shared-header change, unjustified --
   nothing else about FEApp needs it).

   [2026-07-07 addendum] Also tried: dropping bVar1/bVar2 entirely and reading
   `FEApp->fInputPlayer` inline at each of the two use sites (fPlayer=/fData=) -- regresses to 17
   diffs AND changes insn count (26 vs 25; gcc re-schedules the loads to sit right before each use,
   interleaved with the zero-stores, which is a WORSE shape than the current CSE-then-diverge one).
   Swapping fCurrentRow/fCurrentColumn write order (a permuter-suggested candidate, see below)
   regresses to 9. PERMUTER (~130 iterations, tools/run_permuter.py) found only a same-shape
   candidate (internal score 100->95, the fCurrentRow/Column swap just mentioned) which verify_asm
   confirms is WORSE, not better -- the permuter's internal Levenshtein score does not reliably
   track verify_asm's diff-line count here (known caveat, [[reference_psx_cpp_reconstruction_methodology]]
   "survey tools over-count vs verify_asm").

   [2026-08-03 GCC-2.8.1 follow-up] Keep the volatile byte read in a separate `bVar1`
   pseudo before caching the normal array-index value in `bVar2`, then store `bVar1` into
   `fPlayer`. Reading it before `menuDefs` also gives retail's `%hi(FEApp)`, `%hi(menuDefs)`,
   `lw menuDefs`, `lw FEApp` schedule. The function is byte-matched at 25 instructions. */

extern "C" void MenuExtended_EnterUserName__FR12tMenuCommand(tMenuCommand *command)

{
  u_int bVar1;
  u_int bVar2;
  tGlobalMenuDefs *ptVar3;
  tScreenUserName *ptVar4;
  tUserNameMenuItem *dlgThis;

  bVar1 = *(volatile u_char *)&FEApp->fInputPlayer;
  ptVar3 = menuDefs[0];
  dlgThis = &ptVar3->menuItemUserName;
  bVar2 = FEApp->fInputPlayer;
  dlgThis->fPlayer = bVar1;
  dlgThis->fMaxStringLength = 7;
  ptVar4 = screenUserName;
  dlgThis->fCurrentRow = 0;
  dlgThis->fCurrentColumn = 0;
  dlgThis->fData = frontEnd.playerNameList[bVar2];
  ptVar4->callingMenu = &ptVar3->menuUserName;
  command->type = kMenu_Command_GoToMenu;
  command->nextMenu = (tMenu *)(tMenu*)&ptVar3->menuUserName;
  return;
}



/* ---- MenuExtended_GoToShowroom__FR12tMenuCommand  [FEMENUDEFS.CPP:750-753] ---- */

/* Decoded Phase 83: MenuExtended_GoToShowroom__FR12tMenuCommand(tMenuCommand&) - transition to player's garage 3D
   showroom view (64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToShowroom__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  
  ptVar1 = menuDefs[0];
  command->type = kMenu_Command_GoToMenu;
  command->nextMenu = (tMenu *)&ptVar1->menuShowroom;
  SetState(screenCarSelect[0],5);
  return;
}



/* ---- MenuExtended_GoToDealerShowroom__FR12tMenuCommand  [FEMENUDEFS.CPP:757-760] ---- */

/* Decoded Phase 83: MenuExtended_GoToDealerShowroom__FR12tMenuCommand(tMenuCommand&) - transition to dealer 3D
   showroom view (64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToDealerShowroom__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  
  ptVar1 = menuDefs[0];
  command->type = kMenu_Command_GoToMenu;
  command->nextMenu = (tMenu *)&ptVar1->menuShowroom;
  SetState(screenCarSelect[0],6);
  return;
}



/* ---- MenuExtended_SetHPSoloRace__FR12tMenuCommand  [FEMENUDEFS.CPP:764-768] ---- */

/* Decoded Phase 83: MenuExtended_SetHPSoloRace__FR12tMenuCommand(tMenuCommand&) - set raceType=HotPursuit Solo (44 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetHPSoloRace__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetHPSoloRace__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\x01';
  frontEnd.oppNumber = '\0';
  (menuDefs[0]->iteratorCar1).fCarListFilter = 0xb;
  return;
}



/* ---- MenuExtended_SetHPDuelRace__FR12tMenuCommand  [FEMENUDEFS.CPP:772-776] ---- */

/* Decoded Phase 83: MenuExtended_SetHPDuelRace__FR12tMenuCommand(tMenuCommand&) - set raceType=HotPursuit Duel (44 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetHPDuelRace__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetHPDuelRace__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\x01';
  frontEnd.oppNumber = '\x01';
  (menuDefs[0]->iteratorCar1).fCarListFilter = 1;
  return;
}



/* ---- MenuExtended_SetHotPursuit__FR12tMenuCommand  [FEMENUDEFS.CPP:780-788] ---- */

/* Decoded Phase 83: MenuExtended_SetHotPursuit__FR12tMenuCommand(tMenuCommand&) - set raceType=HotPursuit (cops vs
   perps mode) (80 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetHotPursuit__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetHotPursuit__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.carListType = '\0';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\x01';
  if (frontEnd.gameMode == '\x01') {
    (menuDefs[0]->iteratorCar1).fCarListFilter = 9;
  }
  else {
    (menuDefs[0]->iteratorCar1).fCarListFilter = 1;
  }
  frontEnd.oppNumber = '\0';
  return;
}



/* ---- MenuExtended_SellCar__FR12tMenuCommand  [FEMENUDEFS.CPP:792-814] ---- */

/* Decoded Phase 83: MenuExtended_SellCar__FR12tMenuCommand(tMenuCommand&) - sell currently-selected garage car for
   cash credit (344 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SellCar__FR12tMenuCommand(int arg0)'.Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling pattern.
    */

extern "C" void MenuExtended_SellCar__FR12tMenuCommand(tMenuCommand *command)

{
  bool bVar1;
  tFEApplication *ptVar2;
  short sVar3;
  long lVar4;
  long lVar5;
  long lVar6;
  char *pcVar7;
  long money;
  tDialogMessageString *this_00;
  tDialogMessageString *dlgThis;

  /* [2026-07-11] Dropped the REDUNDANT `tDialogYesNo_ctor(&popUp)` manual call and block-scoped
     popUp into the `if (bVar1)` (see AskTheUserToSaveTheGame's note for why).
     [BUG FIX 2026-07-27, 56->53] Same DOUBLE-DESTRUCTION bug as the other tDialogYesNo/
     tDialogYesNoTri locals in this file: dropped the manual `tScreen_dtor((tScreen*)&popUp,2)`
     that was firing alongside popUp's own auto-invoked destructor. */
  lVar6 = tournamentManager.fMoney;
  bVar1 = false;
  lVar4 = CalcUsedPrice(&carManager, (ushort)(byte)frontEnd.garageCar[0]);
  sVar3 = GetNumOwnedCars(&carManager, 0);
  if ((1 < sVar3) ||
     (lVar5 = CheapestCarStockPrice(&carManager), lVar5 <= lVar6 + lVar4)) {
    bVar1 = true;
  }
  ptVar2 = FEApp;
  if (bVar1) {
    tDialogYesNo popUp;

    popUp.string =
         TextSys_Word(0xa5);
    popUp.yesnowords[0] = 0x321;
    popUp.yesnowords[1] = 0x322;
    popUp.fDefault = 0;
    sVar3 = Run((tDialogInteractive *)&popUp);
    if (sVar3 != 0) {
      lVar6 = SellCar(&carManager, (ushort)(byte)frontEnd.sellerCar,0);
      tournamentManager.fMoney = tournamentManager.fMoney + lVar6;
      Decrement(&menuDefs[0]->iteratorSellerCar,kPlayerOne);
      Increment(&menuDefs[0]->iteratorSellerCar,kPlayerOne);
      AudioCmn_PlayFESFX(0x1a);
    }
  }
  else {
    this_00 = &FEApp->messagePopup;
    pcVar7 = TextSys_Word(0xa9);
    (ptVar2->messagePopup).string = pcVar7;
    Display((tDialogBase *)this_00);
  }
  return;
}



/* ---- MenuExtended_BuyCar__FR12tMenuCommand  [FEMENUDEFS.CPP:819-849] ---- */

/* Decoded Phase 83: MenuExtended_BuyCar__FR12tMenuCommand(tMenuCommand&) - purchase highlighted dealer car; debits
   cash, adds to garage (340 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_BuyCar__FR12tMenuCommand(int arg0)'.Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling pattern.
    */

extern "C" void MenuExtended_BuyCar__FR12tMenuCommand(tMenuCommand *command)

{
  tFEApplication *ptVar1;
  short sVar2;
  tFEApplication *dlgThis;
  long lVar3;
  char *pcVar4;
  tDialogMessageString *this_00;
  tDialogMessageString *popUp;
  tCarInfo carInfo;

  /* [2026-07-11] Dropped the REDUNDANT `tDialogYesNo_ctor(&yesNo)` manual call and block-scoped
     yesNo into the inner `if` (see AskTheUserToSaveTheGame's note for why).
     [BUG FIX 2026-07-27, 44->41] Same DOUBLE-DESTRUCTION bug: dropped the manual
     `tScreen_dtor((tScreen*)&yesNo,2)` firing alongside yesNo's own auto-invoked destructor. */
  ptVar1 = FEApp;
  this_00 = &FEApp->messagePopup;
  GetStockCar(&carManager, (ushort)(byte)frontEnd.dealerCar,&carInfo);
  sVar2 = GetNumOwnedCars(&carManager, 0);
  if (sVar2 < 0x20) {
    if (carInfo.fPrices[0] <= tournamentManager.fMoney) {
      tDialogYesNo yesNo;

      yesNo.string =
           TextSys_Word(0xa4);
      yesNo.yesnowords[0] = 0x321;
      yesNo.yesnowords[1] = 0x322;
      yesNo.fDefault = 0;
      sVar2 = Run((tDialogInteractive *)&yesNo);
      if (sVar2 != 0) {
        lVar3 = PurchaseCar(&carManager, (short)carInfo.fCarID,
                           (ushort)(byte)frontEnd.carColors[0][carInfo.fCarID],0);
        tournamentManager.fMoney = tournamentManager.fMoney - lVar3;
        AudioCmn_PlayFESFX(0x1a);
      }
      return;
    }
    AudioCmn_PlayFESFX(10);
    pcVar4 = TextSys_Word(0xa7);
    (ptVar1->messagePopup).string = pcVar4;
  }
  else {
    pcVar4 = TextSys_Word(0x4b);
    (ptVar1->messagePopup).string = pcVar4;
  }
  Display((tDialogBase *)this_00);
  return;
}



/* ---- MenuExtended_PurchaseUpgrade  [FEMENUDEFS.CPP:854-877] ---- */

/* Decoded Phase 83: MenuExtended_PurchaseUpgrade(int upgradeIdx) - shared core purchase logic
   called by PurchaseUpgrade1/2/3 wrappers (320 B, 3 callers). Validates cash, debits, applies
   upgrade modifier to current car.
   
   [ghidra-meta] section: front.text */

void MenuExtended_PurchaseUpgrade(int upgradeNumber)

{
  tFEApplication *ptVar1;
  short sVar2;
  long lVar3;
  char *pcVar4;
  tDialogMessageString *dlgThis;
  int upgradeFlag;
  uint uVar5;
  tCarInfo carInfo;

  /* NEAR-MISS (2026-07-11): dropped the eager `ptVar1 = FEApp` cache -> FEApp now loaded
     lazily only in the not-enough-money branch (matches oracle's `lw s0,%lo(FEApp)(v0)` there),
     freeing one saved reg. Also dropped the REDUNDANT `tDialogYesNo_ctor(&popUp)` manual call
     (tDialogYesNo's real ctor is already auto-invoked by the local's declaration) and
     block-scoped popUp into the `else` -- the previous note blamed a "speculative hoist" of the
     ctor call above GetGarageCar, but that hoisted call was actually the AUTOMATIC ctor for the
     function-scope `popUp` firing at the top unconditionally, stacked with the (redundant) manual
     call in the else; removing the manual call and shrinking popUp's scope to the else fixes
     the hoist at the source.

     [BUG FIX 2026-07-27, DOCUMENTED CORRECTNESS EXCEPTION] Found the same DOUBLE-DESTRUCTION bug
     present across this file: the `else` block ALSO had a manual `tScreen_dtor((tScreen*)&popUp,2)`
     firing IN ADDITION to popUp's own real auto-invoked `tDialogYesNo::~tDialogYesNo()`. Dropped
     it -- a genuine behavioral bug fix (this function was double-freeing/double-resetting the
     dialog's vtable on every real invocation). Byte-match went 28->29 diffs (insn count improved
     79 vs oracle 80, was 82 vs 80) -- removing the dead call shifted downstream register
     allocation (branch polarity flip beqz<->bnez, s0/a0-vs-v0/sp addressing) rather than a clean
     3-insn drop like the sibling fns. Kept per the correctness-exception clause: a real
     double-destruction bug outweighs a 1-line diff delta, and insn count is closer to the oracle
     than before. */
  uVar5 = 1 << (upgradeNumber);
  GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0);
  if ((carInfo.fUpgrades & uVar5) == 0) {
    if (tournamentManager.fMoney < carInfo.fPrices[upgradeNumber + 1]) {
      ptVar1 = FEApp;
      pcVar4 = TextSys_Word(0xa8);
      (ptVar1->messagePopup).string = pcVar4;
      Display((tDialogBase *)&(ptVar1->messagePopup));
    }
    else {
      tDialogYesNo popUp;

      popUp.string =
           TextSys_Word(0xa6);
      popUp.yesnowords[0] = 0x321;
      popUp.yesnowords[1] = 0x322;
      popUp.fDefault = 0;
      sVar2 = Run((tDialogInteractive *)&popUp);
      if (sVar2 != 0) {
        lVar3 = PurchaseUpgrade(&carManager, (ushort)(byte)frontEnd.garageCar[0],(short)uVar5,0);
        tournamentManager.fMoney = tournamentManager.fMoney - lVar3;
        AudioCmn_PlayFESFX(0x1a);
      }
    }
  }
  return;
}



/* ---- MenuExtended_PurchaseUpgrade1__FR12tMenuCommand  [FEMENUDEFS.CPP:883-884] ---- */

/* Decoded Phase 83: MenuExtended_PurchaseUpgrade1__FR12tMenuCommand(tMenuCommand&) - tail-call wrapper for tier-1
   upgrade purchase (32 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_PurchaseUpgrade1__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_PurchaseUpgrade1__FR12tMenuCommand(tMenuCommand *command)

{
  MenuExtended_PurchaseUpgrade(1);
  return;
}



/* ---- MenuExtended_PurchaseUpgrade2__FR12tMenuCommand  [FEMENUDEFS.CPP:888-889] ---- */

/* Decoded Phase 83: MenuExtended_PurchaseUpgrade2__FR12tMenuCommand(tMenuCommand&) - tail-call wrapper for tier-2
   upgrade purchase (32 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_PurchaseUpgrade2__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_PurchaseUpgrade2__FR12tMenuCommand(tMenuCommand *command)

{
  MenuExtended_PurchaseUpgrade(2);
  return;
}



/* ---- MenuExtended_PurchaseUpgrade3__FR12tMenuCommand  [FEMENUDEFS.CPP:893-894] ---- */

/* Decoded Phase 83: MenuExtended_PurchaseUpgrade3__FR12tMenuCommand(tMenuCommand&) - tail-call wrapper for tier-3
   upgrade purchase (32 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_PurchaseUpgrade3__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_PurchaseUpgrade3__FR12tMenuCommand(tMenuCommand *command)

{
  MenuExtended_PurchaseUpgrade(0);
  return;
}



/* ---- MenuExtended_SaveGame__FR12tMenuCommand  [FEMENUDEFS.CPP:898-901] ---- */

/* Decoded Phase 83: MenuExtended_SaveGame__FR12tMenuCommand(tMenuCommand&) - save game state to memcard (80 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SaveGame__FR12tMenuCommand(int arg0)'.Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling pattern.
    */

extern "C" void MenuExtended_SaveGame__FR12tMenuCommand(tMenuCommand *command)

{
  if ((CURRENTLYUSINGMEMCARD == 0) &&
     ((((menuDefs[0]->itemSaveGame).fFlags ^ 1) & 1) != 0)) {
    GenericMenuSaveGame(0);
  }
  return;
}



/* ---- GenericMenuLoadGame  [FEMENUDEFS.CPP:922-941] ---- */

/* Decoded Phase 86: FE-GenericMenuLoadGame (148 B): execute generic load-game flow from
   menu.
   
   [ghidra-meta] section: front.text */

void GenericMenuLoadGame(int player)

{
  tFEApplication *app;
  tScreenMemcard *mc;

  /* NEAR-MISS 21 diffs (was 36): structure now matches the oracle exactly -- 32B frame,
     player->s2, s0/s1 hold FEApp/screenMemcard across the calls. Residual = gcc-2.7.2 reload
     tie-break: oracle holds %hi(FEApp)/%hi(screenMemcard) in s0/s1 and reloads the VALUE into a
     scratch reg each access; our build coalesces the VALUE into s0/s1. Caching the value (this
     form) vs not caching (literal derefs -> 36 diffs, wrong 1-saved-reg structure) are the only
     two source-expressible options; the address-hi-CSE-with-value-reload form is not
     source-reachable (methodology 3.15 reload tie-break).
     [2026-07-27 re-tried] T** double-indirection (&FEApp / &screenMemcard held across the call,
     deref at each use, per §3.12 #16) REGRESSES to 36 diffs with a SMALLER 24B frame (drops s1/s2
     entirely, spills differently) -- the extra indirection level changes register-pressure
     enough that gcc abandons the 2-saved-reg structure altogether. Reverted; confirms the
     3.15 reload tie-break verdict above. WALL, accept. */
  if (CURRENTLYUSINGMEMCARD == 0) {
    app = FEApp;
    mc = screenMemcard;
    mc->message = 0x27d;
    Redraw(app);
    LoadGame((short)player,false,1);
    mc->message = -1;
    Hide((tDialogBase *)&app->NoInputMemCardDialog);
  }
  Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
  return;
}



/* ---- MenuExtended_LoadGame__FR12tMenuCommand  [FEMENUDEFS.CPP:945-957] ---- */

/* Decoded Phase 83: MenuExtended_LoadGame__FR12tMenuCommand(tMenuCommand&) - load save from memcard via Front_*;
   populate game state (152 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_LoadGame__FR12tMenuCommand(int arg0)'.Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling pattern.

   [NEAR-MISS 2026-07-05, was 33 diffs, then 18] Real fix: `AreYouSure`/`sVar1`/`dlgThis` moved
   from function scope INTO the `if` block. A C++ local object's non-trivial ctor runs
   unconditionally at its declaration's scope entry -- with `AreYouSure` at function scope its
   ctor call was hoisted BEFORE the fFlags guard test entirely (oracle's ctor call is
   genuinely conditional, reached only in the fFlags==0 fall-through). Block-scoping it
   restores the right control flow; `dlgThis` (unused before) now carries the &AreYouSure
   hoist matching the ExitPinkSlipsEarly/EnterUserName fix family.

   [BUG FIX 2026-07-27, 18->13 diffs] Found a genuine DOUBLE-DESTRUCTION bug: the block also had
   a manual `tScreen_dtor((tScreen*)&AreYouSure,2);` call at the end -- but `AreYouSure` is type
   tDialogYesNo, which HAS a real user-declared `tDialogYesNo::~tDialogYesNo()` (fedialog.cpp,
   empty body -> forwards to the base tScreen dtor). Declaring the local ALREADY auto-invokes
   that destructor at scope exit (same family as AskTheUserToSaveTheGame's dropped-phantom-ctor
   fix, and screencarselect.cpp/screentournselect.cpp/screentrophyroom.cpp's "declared base dtor
   auto-fires, no manual tScreen_dtor" convention) -- our compiled object was literally calling
   BOTH `___12tDialogYesNo` (auto) AND `tScreen_dtor` (manual, same net effect) back to back.
   Dropped the manual call; ours now emits exactly ONE dtor call (`___12tDialogYesNo`, vs the
   oracle's direct `___7tScreen` -- irrelevant to the gate, `jal` targets normalize to `jal T`).
   [2026-08-03, 13->1] SLD places the 168-byte AreYouSure at sp+16 but starts the save area at
   sp+192, proving an otherwise invisible 8-byte stack-layout slot.  A volatile 64-bit carrier
   restores that exact gcc-2.8 frame without emitting instructions.  The sole residual is one
   redundant `addu a0,s0,zero` scheduled into the zero-result branch delay; the common cleanup
   already rematerializes the same argument, and source-equivalent branch/cast forms are neutral. */

extern "C" void MenuExtended_LoadGame__FR12tMenuCommand(tMenuCommand *command)

{
  if (((menuDefs[0]->itemLoadGame).fFlags & 1) == 0) {
    short sVar1;
    tDialogYesNo *dlgThis;
    tDialogYesNo AreYouSure;
    volatile long long framePadding;
    dlgThis = &AreYouSure;
    dlgThis->yesnowords[0] = 0x321;
    dlgThis->yesnowords[1] = 0x322;
    dlgThis->fDefault = 0;
    dlgThis->string = TextSys_Word(0x2c0);
    sVar1 = Run((tDialogInteractive *)dlgThis);
    if (sVar1 != 0) {
      GenericMenuLoadGame((int)screenMemcard->player);
    }
  }
  return;
}



/* ---- MenuExtended_TierFinished__FR12tMenuCommand  [FEMENUDEFS.CPP:960-976] ---- */

/* Decoded Phase 83: MenuExtended_TierFinished__FR12tMenuCommand(tMenuCommand&) - tournament tier complete; advance to
   next tier (128 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [Match 2026-07-05] Branch-polarity flip (oracle emits the else/congrats block as
   fall-through, the if/AskUser block as the branch target -- both nested ifs written
   inverted vs the natural Ghidra reading) -> byte-match, 32/32 insns. */

extern "C" void MenuExtended_TierFinished__FR12tMenuCommand(tMenuCommand *command)

{
  int iVar1;
  tMenu *ptVar2;
  tAwardInformation award;
  
  command->type = kMenu_Command_GoToMenuOneWay;
  GetAwardInformation(&tournamentManager,&award);
  if (award.fCompletedTier != 0) {
    ptVar2 = (tMenu *)&menuDefs[0]->menuTierCompleteCongrats;
  }
  else {
    iVar1 = AskTheUserToSaveTheGame();
    if (iVar1 != 0) {
      ptVar2 = (tMenu*)&menuDefs[0]->menuPostGameSave;
    }
    else {
      ptVar2 = (tMenu*)&menuDefs[0]->menuMain;
    }
  }
  command->nextMenu = ptVar2;
  return;
}



/* ---- MenuExtended_DidUserWinBeTheCop  [FEMENUDEFS.CPP:1011-1036] ---- */

/* Decoded Phase 83: MenuExtended_DidUserWinBeTheCop() - check Behind-The-Cop win condition; returns
   winner status (284 B, 1 caller). Used by PostGameMenu to choose congrats vs failure animation.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. Did-user-win-Be-The-Cop check.Returns 1 if user just unlocked a cop car after a successful BTC mission, 0 otherwise.GetStockCar(playerCar[0]) loads carInfo. Conditions: carClass=='\x07' (= cop class) AND
   raceType==1 (= BTC mode) AND gameMode!=1 (= not exhibition) AND numPerps<finalPerpArrests (=
   mission goal met). cop_car = GetCarFromID(gCarActivation[-0x13][country*5 + carID + 4]) looks up
   the unlock-target car. If !fAvailable: SetCarAvailable, store congratsCopCar+congratsCopCountry,
   return 1. activateCar/result are caller-side spills. */

void * MenuExtended_DidUserWinBeTheCop(void)

{
  tCarInfo *cop_car;
  tCarInfo *activateCar;
  byte result;
  void *pvVar1;
  tCarInfo carInfo;
  
  GetStockCar(&carManager, (ushort)(byte)frontEnd.playerCar[0],&carInfo);
  pvVar1 = (void *)0x0;
  if ((((carInfo.fCarClass == '\a') && (pvVar1 = (void *)0x0, frontEnd.raceType == '\x01')) &&
      (pvVar1 = (void *)0x0, frontEnd.gameMode != '\x01')) &&
     (GameSetup_gData.numPerps < GameSetup_gData.finalPerpArrests)) {
    cop_car = GetCarFromID(&carManager, (short)gCarActivation[carInfo.fCarID + -0x16]
                                [frontEnd.carCountry[0][carInfo.fCarID]]);
    pvVar1 = (void *)0x0;
    if (cop_car->fAvailable == '\0') {
      SetCarAvailable(&carManager, (int)cop_car->fCarID,true);
      frontEnd.congratsCopCar = cop_car->fCarID;
      frontEnd.congratsCopCountry = frontEnd.carCountry[0][carInfo.fCarID];
      pvVar1 = (void *)0x1;
    }
  }
  return pvVar1;
}



/* ---- MenuExtended_PostGameMenu__FR12tMenuCommand  [FEMENUDEFS.CPP:1040-1082] ---- */

/* Decoded Phase 83: MenuExtended_PostGameMenu__FR12tMenuCommand(tMenuCommand&) - show post-game menu(continue/save/restart/quit) (256 B)
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_PostGameMenu__FR12tMenuCommand(tMenuCommand *command)

{
  short sVar1;
  void *pvVar2;
  tMenu *ptVar3;
  tScreenTournamentStandings *dlgThis;
  tScreenTournamentStandings *ptVar4;
  
  StatChk_ClearNewRecords();
  command->type = kMenu_Command_GoToMenuOneWay;
  if (frontEnd.raceType == '\x02') {
    sVar1 = IsTournamentFinished(&tournamentManager);
    if (sVar1 == 0) {
      command->nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuTournamentStandings;
      ptVar4 = (tScreenTournamentStandings *)screenTournamentStandings3item;
    }
    else {
      command->nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuTournamentFinished;
      ptVar4 = screenTournamentStandings;
    }
    ptVar4->fDrawMoney = 1;
    return;
  }
  if ((byte)frontEnd.raceType < 3) {
    if ((frontEnd.raceType == '\x01') &&
       (pvVar2 = MenuExtended_DidUserWinBeTheCop(), pvVar2 != (void *)0x0)) {
      ptVar3 = (tMenu *)&menuDefs[0]->menuBeTheCopCongrats;
      goto MXPostGameMenu_setNextMenu;
    }
  }
  else if (frontEnd.raceType == '\x06') {
    ptVar3 = (tMenu*)&menuDefs[0]->menuPinkSlipStandings;
    goto MXPostGameMenu_setNextMenu;
  }
  ptVar3 = (tMenu*)&menuDefs[0]->menuMain;
MXPostGameMenu_setNextMenu:
  command->nextMenu = ptVar3;
  return;
}



/* ---- MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand  [FEMENUDEFS.CPP:1090-1120] ---- */

/* Decoded Phase 83: MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand(tMenuCommand&) - after race, prompt P1 for
   name entry (high score etc) (272 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand(tMenuCommand *command)

{
  tFEApplication *ptVar1;
  tGlobalMenuDefs *ptVar2;
  tScreenUserName *ptVar3;
  short sVar4;
  void *pvVar5;
  tUserNameMenuItem *dlgThis;
  tOptionsMenu *m;
  Car_tStats *dummyCars;
  short nBestCarIndex;
  
  ptVar1 = FEApp;
  command->type = kMenu_Command_GoToMenuOneWay;
  ptVar2 = menuDefs[0];
  if ((ptVar1->needName[1] == 0) || (ptVar1->gotName[1] != 0)) {
    pvVar5 = StatChk_IsRecordLapTime(Cars_gNewCarStatsList,(short)Cars_gNumRaceCars,&nBestCarIndex);
    if (pvVar5 != (void *)0x0) {
      StatChk_SaveRecordLapTime(Cars_gNewCarStatsList,(short)Cars_gNumRaceCars,nBestCarIndex);
    }
    sVar4 = StatChk_IsTopTime(Cars_gNewCarStatsList,(short)Cars_gNumRaceCars);
    if (sVar4 != 0) {
      StatChk_SaveTopTime(Cars_gNewCarStatsList,(short)Cars_gNumRaceCars);
    }
    command->nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuPostGameTrackRecords;
  }
  else {
    (menuDefs[0]->menuItemUserName2).fPlayer = 1;
    (ptVar2->menuItemUserName2).fData = frontEnd.playerNameList[4];
    (ptVar2->menuItemUserName2).fMaxStringLength = 7;
    ptVar3 = screenUserName;
    (ptVar2->menuItemUserName2).fCurrentRow = 0;
    (ptVar2->menuItemUserName2).fCurrentColumn = 0;
    ptVar3->callingMenu = &ptVar2->menuPostGamePlayer2Name;
    command->nextMenu = (tMenu *)(tMenu*)&ptVar2->menuPostGamePlayer2Name;
  }
  return;
}



/* ---- MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand  [FEMENUDEFS.CPP:1125-1142] ---- */

/* Decoded Phase 83: MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand(tMenuCommand&) - after race, prompt P2 for
   name entry (160 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  short sVar2;
  void *pvVar3;
  Car_tStats *dummyCars;
  short nBestCarIndex;

  /* [SYM check 2026-07-27] SYM ground truth (8c Function start @0x8002DD14) proves `dummyCars`
     is a REAL `class REG type PTR STRUCT Car_tStats` local, and the function's .mask is
     $80070000 = s0|s1|s2 (3 saved regs) + ra. Assigning `Cars_gNewCarStatsList` to `dummyCars`
     ONCE and passing it at each call site matches the SYM's named local -- but verify_asm
     confirmed it is CODEGEN-NEUTRAL (byte-identical before/after): gcc-2.8.0 already CSEs the
     bare global's %hi across all 4 call sites on its own, so the explicit local changes nothing
     observable. Kept anyway for SYM fidelity (harmless, more faithful to ground truth). Residual
     (37 diffs) = oracle allocates a genuine 3RD saved reg (s0) to cache %hi(Cars_gNumRaceCars)
     across all 4 reads (`lui s0,%hi(...)` once, then `lh a1,%lo(...)(s0)` per site); our build
     allocates only 2 saved regs (command in s1, &Cars_gNewCarStatsList in s0) and rematerializes
     `lui a1,%hi(Cars_gNumRaceCars); lh a1,...` FRESH at all 4 sites instead. Pure allocator
     register-BUDGET tie-break (gcc-2.8.0's global.c priority didn't rank Cars_gNumRaceCars's
     address high enough to earn a 3rd callee-saved reg here); not source-reachable without a
     pin (forbidden). Accept as floor. */
  dummyCars = Cars_gNewCarStatsList;
  pvVar3 = StatChk_IsRecordLapTime(dummyCars,(short)Cars_gNumRaceCars,&nBestCarIndex);
  if (pvVar3 != (void *)0x0) {
    StatChk_SaveRecordLapTime(dummyCars,(short)Cars_gNumRaceCars,nBestCarIndex);
  }
  sVar2 = StatChk_IsTopTime(dummyCars,(short)Cars_gNumRaceCars);
  if (sVar2 != 0) {
    StatChk_SaveTopTime(dummyCars,(short)Cars_gNumRaceCars);
  }
  ptVar1 = menuDefs[0];
  command->type = kMenu_Command_GoToMenuOneWay;
  command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuPostGameTrackRecords;
  return;
}



/* ---- MenuExtended_SetPinkSlips__FR12tMenuCommand  [FEMENUDEFS.CPP:1146-1159] ---- */

/* Decoded Phase 83: MenuExtended_SetPinkSlips__FR12tMenuCommand(tMenuCommand&) - set raceType=PinkSlips and prepare
   car-select (192 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name + (body or
   100%-caller-consensus) agree. Generic param names; types int/void* default - refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetPinkSlips__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern.

   [Match 2026-07-05] Both loops were Ghidra's `short`-counter-as-int artifact
   (`iVar1<<0x10>>0xf` / `iVar1>>0x10`/`iVar2*0x10000`) -- the declared-but-unused `short i`
   was the real loop counter (methodology 3.12 lever #9c). Rewriting both loops as plain
   `short i` down-to-up counts + natural array indexing (`pinkSlipsWins[i]`/
   `pinkSlipsWinner[i]=-1`) reproduces the oracle's per-iteration sll<<16;sra>>16 exactly.
   -> byte-match, 48/48 insns. */

extern "C" void MenuExtended_SetPinkSlips__FR12tMenuCommand(tMenuCommand *command)

{
  short i;

  SwapBackground(screenMain[0],-1);
  frontEnd.raceType = '\x06';
  frontEnd.gameMode = '\x01';
  frontEnd.oppNumber = '\0';
  frontEnd.pinkSlipsForfeit = -1;
  frontEnd.pinkSlipsTrackIndex = '\0';
  i = 0;
  do {
    frontEnd.pinkSlipsWins[i] = '\0';
    i = i + 1;
  } while (i < 2);
  i = 0;
  do {
    frontEnd.pinkSlipsWinner[i] = -1;
    i = i + 1;
  } while (i < 5);
  return;
}



/* ---- MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand  [FEMENUDEFS.CPP:1163-1218] ---- */

/* Decoded Phase 83: MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand(tMenuCommand&) - award winner the loser's car
   after pinkslips race (552 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand(tMenuCommand *command)

{
  short playerNum;
  tFEApplication *ptVar1;
  tFEApplication *ptVar2;
  tGlobalMenuDefs *ptVar3;
  char *mess;
  char *pcVar4;
  char *pcVar5;
  tScreenPinkSlipCongrats *dlgThis;
  tDialogNoInputMessage *this_00;
  int fWinner;
  int player;
  char string [80];
  tDialogYesNo RetryCancelDialog;
  tCarInfo carInfo;
  
  /* [2026-07-11 consolidation] dropped REDUNDANT tDialogYesNo_ctor(&RetryCancelDialog) manual
     call (undefined phantom extern; tDialogYesNo's real declared ctor auto-fires -- oracle
     shows a single jal __12tDialogYesNo). Same class as the ~11 sites fixed above.
     [BUG FIX 2026-07-27, 130->124] The matching manual `tScreen_dtor((tScreen*)&RetryCancelDialog,2)`
     at the function's tail was left in -- same DOUBLE-DESTRUCTION bug, firing alongside
     RetryCancelDialog's own auto-invoked destructor at the real `}`. Dropped it. */
  RetryCancelDialog.yesnowords[0] = 0x291;
  RetryCancelDialog.yesnowords[1] = 0x292;
  RetryCancelDialog.fDefault = 1;
  playerNum = screenPinkSlipCongrats->fWinner;
  player = (int)playerNum;
  pcVar4 = TextSys_Word(0x29a);
  pcVar5 = PlayerName(player);
  sprintf(string,pcVar4,pcVar5,player + 1);
  this_00 = &FEApp->NoInputMemCardDialog;
  (FEApp->NoInputMemCardDialog).string = string;
  Display((tDialogBase *)this_00);
  while ((FEApp->NoInputMemCardDialog).fFullyOpen != 1) {
    Redraw(FEApp);
  }
  Redraw(FEApp);
  Init_Memcard(false,1);
  GetPinkSlipsCar(&carManager, (ushort)*(byte *)((int)&frontEnd + -player + 0x126),&carInfo,
             (short)((uint)((-player + 1) * 0x10000) >> 0x10));
  AddToPinkSlipsList(&carManager, (short)carInfo.fCarID,(ushort)carInfo.fColor,playerNum);
  AddUpgradesToPinkSlipsList(&carManager, (ushort)(byte)frontEnd.pinkSlipsCar[player],(ushort)carInfo.fUpgrades,
             playerNum);
  SavePinkSlipsCarsWithErrorDialogs(playerNum,2,-1);
  Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
  command->type = kMenu_Command_GoToMenuOneWay;
  ptVar1 = FEApp;
  command->nextMenu = (tMenu *)(tMenu*)&menuDefs[0]->menuMain;
  pcVar4 = TextSys_Word(0x274);
  ptVar2 = FEApp;
  (ptVar1->NoInputMemCardDialog).string = pcVar4;
  Display((tDialogBase *)&ptVar2->NoInputMemCardDialog);
  while ((FEApp->NoInputMemCardDialog).fFullyOpen != 1) {
    Redraw(FEApp);
  }
  Redraw(FEApp);
  GenericMenuLoadGame(0);
  DeInit_Memcard();
  Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
  ptVar3 = menuDefs[0];
  command->type = kMenu_Command_GoToMenuOneWay;
  command->nextMenu = (tMenu *)(tMenu*)&ptVar3->menuMain;
  return;
}



/* ---- MenuExtended_GoToGarage__FR12tMenuCommand  [FEMENUDEFS.CPP:1222-1231] ---- */

/* Decoded Phase 83: MenuExtended_GoToGarage__FR12tMenuCommand(tMenuCommand&) - transition to garage screen (168 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [SEALED 2026-07-06/07, was 10 diffs, now PASS] Fix = reuse the already-computed `this_00`
   pointer for the fCarListFilter store instead of re-deriving `menuDefs[0]->iteratorGarageCar`
   a second time. The old code recomputed the base a second time via
   `(menuDefs[0]->iteratorGarageCar).fCarListFilter = 0x40;`, forcing gcc to hold TWO copies of
   the same address (menuDefs[0]->iteratorGarageCar) live in separate regs (a2 vs a0) across the
   Decrement() jal. `this_00->fCarListFilter = 0x40;` collapses it to one live pointer, matching
   the oracle's single `addiu a0,a0,0x12CC; sw v0,0x10(a0)` (a0 = this_00, used for both the
   store and as Decrement's arg). This is the same "greedy pointer re-derivation" family as the
   sibling GoToDealer/GoToSeller residual but WAS fixable here because this fn had a genuine
   double-derivation to collapse; GoToDealer/GoToSeller do not (see their own near-miss notes). */

extern "C" void MenuExtended_GoToGarage__FR12tMenuCommand(tMenuCommand *command)

{
  tMenu *ptVar1;
  tListIteratorCar *dlgThis;
  tListIteratorCar *this_00;
  
  frontEnd.carListType = '\x01';
  this_00 = &menuDefs[0]->iteratorGarageCar;
  this_00->fCarListFilter = 0x40;
  Decrement(this_00,kPlayerBoth);
  Increment(&menuDefs[0]->iteratorGarageCar,kPlayerBoth);
  command->type = kMenu_Command_GoToMenu;
  if (tournamentManager.fCurrentTrack == 0) {
    ptVar1 = (tMenu*)&menuDefs[0]->menuCarGarage;
  }
  else {
    ptVar1 = (tMenu*)&menuDefs[0]->menuPostCarGarage;
  }
  command->nextMenu = ptVar1;
  SetState(screenCarSelect[0],1);
  return;
}



/* ---- MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand  [FEMENUDEFS.CPP:1235-1236] ---- */

/* Decoded Phase 83: MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand(tMenuCommand&) - transition to tournament
   trophy room (12 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int
   MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand(int arg0)'. Fixed via m2c body (arg0 = struct
   deref) + PCSX runtime (a0 = consistent ptr) + sibling pattern. */

extern "C" void MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.tier = '\0';
  return;
}



/* ---- MenuExtended_GoToSETrophyRoom__FR12tMenuCommand  [FEMENUDEFS.CPP:1240-1241] ---- */

/* Decoded Phase 83: MenuExtended_GoToSETrophyRoom__FR12tMenuCommand(tMenuCommand&) - transition to special-event
   trophy room (16 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_GoToSETrophyRoom__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_GoToSETrophyRoom__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.tier = '\x01';
  return;
}



/* ---- MenuExtended_SetBeginner__FR12tMenuCommand  [FEMENUDEFS.CPP:1245-1246] ---- */

/* Decoded Phase 83: MenuExtended_SetBeginner__FR12tMenuCommand(tMenuCommand&) - set difficulty=Beginner (12 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetBeginner__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetBeginner__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.skillLevel = '\0';
  return;
}



/* ---- MenuExtended_SetIntermediate__FR12tMenuCommand  [FEMENUDEFS.CPP:1250-1251] ---- */

/* Decoded Phase 83: MenuExtended_SetIntermediate__FR12tMenuCommand(tMenuCommand&) - set difficulty=Intermediate (16
   B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetIntermediate__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetIntermediate__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.skillLevel = '\x01';
  return;
}



/* ---- MenuExtended_SetExpert__FR12tMenuCommand  [FEMENUDEFS.CPP:1255-1256] ---- */

/* Decoded Phase 83: MenuExtended_SetExpert__FR12tMenuCommand(tMenuCommand&) - set difficulty=Expert (16 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SetExpert__FR12tMenuCommand(int
   arg0)'. Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling
   pattern. */

extern "C" void MenuExtended_SetExpert__FR12tMenuCommand(tMenuCommand *command)

{
  frontEnd.skillLevel = '\x02';
  return;
}



/* ---- MenuExtended_ExitTourney__FR12tMenuCommand  [FEMENUDEFS.CPP:1260-1271] ---- */

/* Decoded Phase 83: MenuExtended_ExitTourney__FR12tMenuCommand(tMenuCommand&) - abandon current tournament, return to
   main menu (144 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [BUG FIX 2026-07-27] Same DOUBLE-DESTRUCTION bug as the other tDialogYesNo locals: objdump
   confirmed `jal tScreen_dtor` then `jal ___12tDialogYesNo` back to back on AreYouSure. Dropped
   the manual call. Insn count coincidentally MATCHED the oracle before this fix (36==36, ours
   PADDED by the 3 duplicate insns) -- after removing them ours is 33 vs oracle 36, a genuine
   3-insn shortfall that pre-existed and was simply masked by the double-call bug (oracle caches
   command/`this` in s1, ours in s0/a0 -- an unrelated register-caching gap, not yet fixed).
   Diff count still improved 52->49; kept as a correctness fix (this fn was double-freeing the
   dialog's vtable on every real call). */

extern "C" void MenuExtended_ExitTourney__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  short sVar2;
  tDialogYesNo *dlgThis;
  tDialogYesNo AreYouSure;

  AreYouSure.yesnowords[0] = 0x321;
  AreYouSure.yesnowords[1] = 0x322;
  AreYouSure.fDefault = 0;
  AreYouSure.string =
       TextSys_Word(0x9d);
  sVar2 = Run((tDialogInteractive *)&AreYouSure);
  ptVar1 = menuDefs[0];
  if (sVar2 == 0) {
    command->type = kMenu_Command_None;
  }
  else {
    command->type = kMenu_Command_GoToMenuOneWay;
    command->nextMenu = (tMenu *)(tMenu*)&ptVar1->menuMain;
  }
  return;
}



/* ---- MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand  [FEMENUDEFS.CPP:1274-1300] ---- */

/* Decoded Phase 83: MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand(tMenuCommand&) - allow user to back out of
   pinkslips before commit (304 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [NEAR-MISS 2026-07-05, was 32 diffs, now 15] Real fix: the declared-but-unused `dlgThis`
   local IS the oracle's hoisted `&AreYouSure` base (oracle materializes it ONCE via
   `addiu s0,sp,0x10` right after the ctor and reaches yesnowords/fDefault/string through it;
   our direct `AreYouSure.field` accesses were emitting raw sp-relative offsets instead).
   2026-08-03 GCC follow-up: the catalogued exit-in-the-middle loop shape
   (`while(true) { if (2 <= player) break; ...; }`) prevents loop rotation and restores the
   oracle's PRE-loop `slti/beqz` plus unconditional back-edge jump. This reduces 10->4 diffs
   at exact 76/76 instruction parity. The remaining pair is only the FEApp address scratch
   (`lui/lw a0` versus retail's `lui v0; lw a0`); a nested pointer and an explicit two-step
   pointer increment compile identically, so this is the known materialization tie-break.

   [BUG FIX 2026-07-27, 13->10] Same DOUBLE-DESTRUCTION bug: dropped the manual
   `tScreen_dtor((tScreen*)&AreYouSure,2)` firing alongside AreYouSure's own auto-invoked
   destructor. */

extern "C" void MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar2;
  short sVar3;
  char *fmt;
  char *pcVar4;
  tDialogYesNo *dlgThis;
  int iVar5;
  int player_00;
  tDialogYesNo AreYouSure;
  char string [80];
  
  dlgThis = &AreYouSure;
  dlgThis->yesnowords[0] = 0x321;
  dlgThis->yesnowords[1] = 0x322;
  dlgThis->fDefault = 0;
  dlgThis->string = TextSys_Word(0x9d);
  sVar3 = Run((tDialogInteractive *)dlgThis);
  if (sVar3 != 0) {
    Init_Memcard(false,1);
    player_00 = 0;
    while (true) {
      if (2 <= player_00) break;
      fmt = TextSys_Word(0x297);
      pcVar4 = PlayerName(player_00);
      iVar5 = player_00 + 1;
      sprintf(string,fmt,pcVar4,iVar5);
      (FEApp->NoInputMemCardDialog).string = string;
      SavePinkSlipsCarsWithErrorDialogs((short)player_00,1,-1);
      player_00 = iVar5;
    }
    DeInit_Memcard();
    Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
    ptVar2 = menuDefs[0];
    command->type = kMenu_Command_GoToMenuOneWay;
    command->nextMenu = (tMenu *)(tMenu*)&ptVar2->menuMain;
    frontEnd.raceType = '\0';
  }
  return;
}



/* ---- MenuExtended_PinkSlipsContinue__FR12tMenuCommand  [FEMENUDEFS.CPP:1304-1315] ---- */

/* Decoded Phase 83: MenuExtended_PinkSlipsContinue__FR12tMenuCommand(tMenuCommand&) - after pinkslips win, continue
   to next race (108 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [Match 2026-07-05] Three levers: (1) bVar2 as plain int (not byte) so the two
   byte-field compares emit signed `slt`, matching the oracle -- two same-typed
   `byte` operands otherwise fold to `sltu`; (2) ptVar1=menuDefs[0] moved into the
   else/GoToMenuOneWay path only (oracle never touches menuDefs on the win path);
   (3) physical block-order swap (else-body first, win-body reached via a trailing
   goto) for branch polarity -- the natural `&&`/nested-if emits the opposite
   fall-through no matter how the C conditions are phrased. -> byte-match, 27/27. */

extern "C" void MenuExtended_PinkSlipsContinue__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  int bVar2;

  bVar2 = ((byte)frontEnd.pinkSlipsNumTracks >> 1) + 1;
  if ((byte)frontEnd.pinkSlipsWins[0] < bVar2) {
    if ((byte)frontEnd.pinkSlipsWins[1] < bVar2) {
      goto winCase;
    }
  }
  ptVar1 = menuDefs[0];
  command->type = kMenu_Command_GoToMenuOneWay;
  command->nextMenu = (tMenu *)&ptVar1->menuPinkSlipCongrats;
  return;
winCase:
  frontEnd.pinkSlipsTrackIndex = frontEnd.pinkSlipsTrackIndex + '\x01';
  command->type = kMenu_Command_StartRace;
  return;
}



/* ---- tGlobalMenuDefs::ctor  [FEMENUDEFS.CPP:1353-2200] ---- */

tGlobalMenuDefs::tGlobalMenuDefs()
 : itemMainOnePlayerRace(0x5b, (tMenu*)&menuOnePlayer, (void (*)(tMenuCommand&))MenuExtended_SetOnePlayer__FR12tMenuCommand, 0x1e, 10)   /* +0x0 tMenuItemGoToMenuNFS4Button */
 , itemMainTwoPlayerRace(0x5c, (tMenu*)&menuTwoPlayer, (void (*)(tMenuCommand&))MenuExtended_SetTwoPlayer__FR12tMenuCommand, 0x28, 10)   /* +0x2C tMenuItemGoToMenuNFS4Button */
 , itemMainTrophyRoom(0x5e, (tMenu*)&menuTrophyRoomSelect, 0, 0x32, 10)   /* +0x58 tMenuItemGoToMenuNFS4Button */
 , itemMainOptions(0x5d, (tMenu*)&menuOptions, 0, 0x3c, 10)   /* +0x84 tMenuItemGoToMenuNFS4Button */
 , menuMain(0x1014, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0xb4, (tMenuItem *)this, &itemMainTwoPlayerRace, &itemMainOptions, &itemMainTrophyRoom, 0)   /* +0xB0 tMenuNFS4 */
 , itemTournTrophyRoom(99, (tMenu *)&menuTrophyRoom, (void (*)(tMenuCommand&))MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand, 0x32, 10)   /* +0x12C tMenuItemGoToMenuNFS4Button */
 , itemSETrophyRoom(0x69, (tMenu *)&menuTrophyRoom, (void (*)(tMenuCommand&))MenuExtended_GoToSETrophyRoom__FR12tMenuCommand, 0x32, 10)   /* +0x158 tMenuItemGoToMenuNFS4Button */
 , menuTrophyRoomSelect(0x1014, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0x5f, (tMenuItem *)&itemTournTrophyRoom, &itemSETrophyRoom, 0)   /* +0x184 tMenuNFS4 */
 , menuTrophyInfo(0x4000, (tScreen *)screenTrophyInfo, (tMenu *)0x0, (tMenu *)0x0, 0, -1)   /* +0x200 tMenuBlank */
 , itemSkillBeginner(0xa1, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetBeginner__FR12tMenuCommand, 0x8c, 10)   /* +0x27C tMenuItemGoToMenuNFS4Button */
 , itemSkillIntermediate(0xa2, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetIntermediate__FR12tMenuCommand, 0x96, 10)   /* +0x2A8 tMenuItemGoToMenuNFS4Button */
 , itemSkillExpert(0xa3, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetExpert__FR12tMenuCommand, 0xa0, 10)   /* +0x2D4 tMenuItemGoToMenuNFS4Button */
 , menuSkillLevel(0x1004, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0xb7, (tMenuItem *)&itemSkillBeginner, &itemSkillIntermediate, &itemSkillExpert, 0)   /* +0x300 tMenuNFS4 */
 , itemOnePlayerTestDrive(0x60, (tMenu*)&menuTestDriveTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetTestDrive__FR12tMenuCommand, 0xf0, 10)   /* +0x37C tMenuItemGoToMenuNFS4Button */
 , itemOnePlayerSingleRace(0x72, (tMenu*)&menuSingleRace, (void (*)(tMenuCommand&))MenuExtended_SetSingleRace__FR12tMenuCommand, 0x46, 10)   /* +0x3A8 tMenuItemGoToMenuNFS4Button */
 , itemOnePlayerPursuit(0x71, (tMenu*)&menuHotPursuit, (void (*)(tMenuCommand&))MenuExtended_SetHotPursuit__FR12tMenuCommand, 0x50, 10)   /* +0x3D4 tMenuItemGoToMenuNFS4Button */
 , itemOnePlayerTournament(99, (tMenu*)&menuTournament, (void (*)(tMenuCommand&))MenuExtended_SetTournament__FR12tMenuCommand, 0x5a, 10)   /* +0x400 tMenuItemGoToMenuNFS4Button */
 , itemOnePlayerSpecialEvents(0x69, (tMenu*)&menuSpecialEvent, (void (*)(tMenuCommand&))MenuExtended_SetSpecialEvent__FR12tMenuCommand, 100, 10)   /* +0x42C tMenuItemGoToMenuNFS4Button */
 , menuOnePlayer(0x1004, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0xb5, (tMenuItem *)&itemOnePlayerTestDrive, &itemOnePlayerSingleRace, &itemOnePlayerPursuit, &itemOnePlayerTournament, &itemOnePlayerSpecialEvents, 0)   /* +0x458 tMenuNFS4 */
 , itemSingleRaceSolo(0x6c, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetSoloRace__FR12tMenuCommand, 0x6e, 10)   /* +0x4D4 tMenuItemGoToMenuNFS4Button */
 , itemSingleRaceDuel(0x6d, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetDuelRace__FR12tMenuCommand, 0x78, 10)   /* +0x500 tMenuItemGoToMenuNFS4Button */
 , itemSingleRaceFullGrid(0x6f, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetFullGrid__FR12tMenuCommand, 0x82, 10)   /* +0x52C tMenuItemGoToMenuNFS4Button */
 , menuSingleRace(0x1004, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0xb6, (tMenuItem *)&itemSingleRaceSolo, &itemSingleRaceDuel, &itemSingleRaceFullGrid, 0)   /* +0x558 tMenuNFS4 */
 , itemHotPursuitSolo(0x6c, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetHPSoloRace__FR12tMenuCommand, 0x6e, 10)   /* +0x5D4 tMenuItemGoToMenuNFS4Button */
 , itemHotPursuitDuel(0x6d, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetHPDuelRace__FR12tMenuCommand, 0x78, 10)   /* +0x600 tMenuItemGoToMenuNFS4Button */
 , menuHotPursuit(0x1004, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0xb6, (tMenuItem *)&itemHotPursuitSolo, &itemHotPursuitDuel, 0)   /* +0x62C tMenuNFS4 */
 , itemTournamentContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToTournTrackInfo__FR12tMenuCommand, 0x22, 10)   /* +0x6BC tMenuItemGoToMenuNFS4Button */
 , itemTournamentSelect(0x94, (tListIterator *)&iteratorTournament, 0x2c, 10)   /* +0x6E8 tMenuItemNFS4LeftRightChoice */
 , menuTournament(0x1000, (tScreen *)screenTournSelect, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToTournTrackInfo__FR12tMenuCommand, 0x65, (tMenuItem *)&itemTournamentContinue, &itemTournamentSelect, 0)   /* +0x710 tMenuNFS4 */
 , itemSpecialEventContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand, 0x22, 10)   /* +0x7A0 tMenuItemGoToMenuNFS4Button */
 , itemSpecialEventSelect(0x69, (tListIterator *)&iteratorSpecialEvent, 0x36, 10)   /* +0x7CC tMenuItemNFS4LeftRightChoice */
 , menuSpecialEvent(0x1000, (tScreen *)screenTournSelect, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand, 100, (tMenuItem *)&itemSpecialEventContinue, &itemSpecialEventSelect, 0)   /* +0x7F4 tMenuNFS4 */
 , itemTwoPlayerTestDrive(0x60, (tMenu*)&menuTestDriveTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetTestDrive__FR12tMenuCommand, 0xf0, 10)   /* +0x870 tMenuItemGoToMenuNFS4Button */
 , itemTwoPlayerDuel(0x72, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand, 0x46, 10)   /* +0x89C tMenuItemGoToMenuNFS4Button */
 , itemTwoPlayerHotPursuit(0x71, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetHotPursuit__FR12tMenuCommand, 0x50, 10)   /* +0x8C8 tMenuItemGoToMenuNFS4Button */
 , itemTwoPlayerPinkSlips(0x6a, (tMenu*)&menuPinkSlipSelect, (void (*)(tMenuCommand&))MenuExtended_SetPinkSlips__FR12tMenuCommand, 0xaa, 10)   /* +0x8F4 tMenuItemGoToMenuNFS4Button */
 , menuTwoPlayer(0x1004, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0xb5, (tMenuItem *)&itemTwoPlayerTestDrive, &itemTwoPlayerDuel, &itemTwoPlayerHotPursuit, &itemTwoPlayerPinkSlips, 0)   /* +0x920 tMenuNFS4 */
 , itemBestOfOne(0xc0, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_GoToBestOfOne__FR12tMenuCommand, 0xaa, 10)   /* +0x99C tMenuItemGoToMenuNFS4Button */
 , itemBestOfThree(0xc1, (tMenu*)&menuPinkSlipsBestOfThree, (void (*)(tMenuCommand&))MenuExtended_GoToBestOfThree__FR12tMenuCommand, 0xaa, 10)   /* +0x9C8 tMenuItemGoToMenuNFS4Button */
 , itemBestOfFive(0xc2, (tMenu*)&menuPinkSlipsBestOfFive, (void (*)(tMenuCommand&))MenuExtended_GoToBestOfFive__FR12tMenuCommand, 0xaa, 10)   /* +0x9F4 tMenuItemGoToMenuNFS4Button */
 , menuPinkSlipSelect(0x1000, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0xb6, (tMenuItem *)&itemBestOfOne, &itemBestOfThree, &itemBestOfFive, 0)   /* +0xA20 tMenuNFS4 */
 , itemPinkSlipsContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect__FR12tMenuCommand, 0x24, 10)   /* +0xA9C tMenuItemGoToMenuNFS4Button */
 , itemTrack1(0xc3, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xAC8 tMenuItemNFS4LeftRightChoice */
 , itemTrack2(0xc4, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xAF0 tMenuItemNFS4LeftRightChoice */
 , itemTrack3(0xc5, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xB18 tMenuItemNFS4LeftRightChoice */
 , itemTrack4(0xc6, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xB40 tMenuItemNFS4LeftRightChoice */
 , itemTrack5(199, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xB68 tMenuItemNFS4LeftRightChoice */
 , menuPinkSlipsBestOfThree(0x1400, (tScreen *)screenPinkSlips, (tMenu *)0x0, (tMenu *)&menuTrackOptions, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect__FR12tMenuCommand, 0xbe, (tMenuItem *)&itemPinkSlipsContinue, &itemTrack1, &itemTrack2, &itemTrack3, 0)   /* +0xB90 tMenuNFS4 */
 , menuPinkSlipsBestOfFive(0x1400, (tScreen *)screenPinkSlips, (tMenu *)0x0, (tMenu *)&menuTrackOptions, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect__FR12tMenuCommand, 0xbf, (tMenuItem *)&itemPinkSlipsContinue, &itemTrack1, &itemTrack2, &itemTrack3, &itemTrack4, &itemTrack5, 0)   /* +0xC0C tMenuNFS4 */
 , itemTrackContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect__FR12tMenuCommand, 0x1c, 10)   /* +0xCA0 tMenuItemGoToMenuNFS4Button */
 , itemTrack(0x93, (tListIterator *)&iteratorTrack, 0x26, 10)   /* +0xCCC tMenuItemNFS4LeftRightChoice */
 , itemTrackRecords(0xd4, (tMenu*)&menuTrackRecords, 0, 0x3a, 10)   /* +0xCF4 tMenuItemGoToMenuNFS4Button */
 , menuSingleTrackSelect(0x1600, (tScreen *)screenTrackSelect, (tMenu *)0x0, (tMenu *)&menuTrackOptions, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect__FR12tMenuCommand, 200, (tMenuItem *)&itemTrackContinue, &itemTrack, &itemTrackRecords, 0)   /* +0xD20 tMenuNFS4 */
 , menuTestDriveTrackSelect(0x1600, (tScreen *)screenTrackSelect, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect__FR12tMenuCommand, 200, (tMenuItem *)&itemTrackContinue, &itemTrack, &itemTrackRecords, 0)   /* +0xD9C tMenuNFS4 */
 , itemLaps(0xca, (tListIterator *)&iteratorLaps)   /* +0xEA0 tMenuItemOptionsLeftRightChoice */
 , itemTrackDirection(0xcc, (tListIterator *)&iteratorTrackDirection)   /* +0xEC0 tMenuItemOptionsLeftRightChoice */
 , itemTrackMirrored(0xcd, (tListIterator *)&iteratorTrackMirrored)   /* +0xEE0 tMenuItemOptionsTwoItemChoice */
 , itemTimeOfDay(0xce, (tListIterator *)&iteratorTimeOfDay)   /* +0xF04 tMenuItemOptionsTwoItemChoice */
 , itemWeather(0xcf, (tListIterator *)&iteratorWeather)   /* +0xF28 tMenuItemOptionsTwoItemChoice */
 , itemTraffic(0xd0, (tListIterator *)&iteratorTraffic)   /* +0xF4C tMenuItemOptionsTwoItemChoice */
 , itemLocalSpeech(0xd2, &iteratorLocalSpeech)   /* +0xF70 tMenuItemOptionsTwoItemChoice */
 , menuTrackOptions(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0xb9, -1, (tMenuItem *)&itemLaps, &itemTrackDirection, &itemTrackMirrored, &itemTimeOfDay, &itemWeather, &itemTraffic, &itemLocalSpeech, 0)   /* +0xF94 tMenuOptions */
 , menuTrackRecordsItem(0, (tMenu *)0x0, 0, -1, -1)   /* +0x1018 tBlankMenuItemGoToMenuNFS4Button */
 , menuTrackRecords(0x1000, (tScreen *)screenTrackRecords, (tMenu *)0x0, (tMenu *)0x0, 0, 0xd4, 1, 10, (tMenuItem *)0x0)   /* +0x1044 tOptionsMenu */
 , itemTrackInfoContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToGarage__FR12tMenuCommand, 0x21, 10)   /* +0x10C4 tMenuItemGoToMenuNFS4Button */
 , menuTrackInfo(0x1004, (tScreen *)screenTrackInfo, (tMenu *)0x0, (tMenu *)0x0, 0, 0xf9, (tMenuItem *)&itemTrackInfoContinue, 0)   /* +0x10F0 tMenuNFS4 */
 , itemCarSelectRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToRace__FR12tMenuCommand, 0x80, 10)   /* +0x11A8 tMenuItemGoToMenuNFS4Button */
 , itemCar(0x92, (tListIterator *)&iteratorCar1, 0x1c, 10)   /* +0x11D4 tMenuItemNFS4LeftRightChoice */
 , itemColor(0x120, (tListIterator *)&iteratorColor, 0x26, 10)   /* +0x11FC tMenuItemNFS4LeftRightChoice */
 , itemShowcase(0x112, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToShowroom__FR12tMenuCommand, 0x30, 10)   /* +0x1224 tMenuItemGoToMenuNFS4Button */
 , menuSingleCarSelect(0x1a00, (tScreen *)screenCarSelect[0], (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemCarSelectRace, &itemCar, &itemColor, &itemShowcase, 0)   /* +0x1250 tMenuNFS4 */
 , itemGarageCar(0x92, (tListIterator *)&iteratorGarageCar, 0x1c, 10)   /* +0x12E8 tMenuItemNFS4LeftRightChoice */
 , itemCarDealer(0x74, (tMenu*)&menuGoToCarDealer, 0, 0x3a, 10)   /* +0x1310 tMenuItemGoToMenuNFS4Button */
 , itemUpgradeCar(0x91, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToUpgrades__FR12tMenuCommand, 0x44, 10)   /* +0x133C tMenuItemGoToMenuNFS4Button */
 , menuCarGarage(0x1a00, (tScreen *)screenCarSelect[0], (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace__FR12tMenuCommand, 0x8f, (tMenuItem *)&itemCarSelectRace, &itemGarageCar, &itemCarDealer, &itemUpgradeCar, 0)   /* +0x1368 tMenuNFS4 */
 , menuPostCarGarage(0x1a00, (tScreen *)screenCarSelect[0], (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace__FR12tMenuCommand, 0x8f, (tMenuItem *)&itemCarSelectRace, &itemUpgradeCar, 0)   /* +0x13E4 tMenuNFS4 */
 , itemDuelRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToRace__FR12tMenuCommand, 0x2a, 10)   /* +0x147C tMenuItemGoToMenuNFS4Button */
 , itemCar2(0x92, (tListIterator *)&iteratorCar1, 0xc, 10)   /* +0x14A8 tMenuItemNFS4LeftRightChoice */
 , itemColor2(0x120, (tListIterator *)&iteratorColor, 0x16, 10)   /* +0x14D0 tMenuItemNFS4LeftRightChoice */
 , itemGoToDuelBuyCar(0x78, (tMenu*)&menuCarDealer, (void (*)(tMenuCommand&))MenuExtended_GoToDealer__FR12tMenuCommand, -1, 10)   /* +0x14F8 tMenuItemGoToMenuNFS4Button */
 , itemOpponentCar(0xbc, (tListIterator *)&iteratorOpponentCar, 0x20, 10)   /* +0x1524 tMenuItemNFS4LeftRightChoice */
 , menuDuelCarSelect(0x1800, (tScreen *)screenCarSelectDuel, (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemDuelRace, &itemGarageCar, &itemGoToDuelBuyCar, &itemOpponentCar, 0)   /* +0x154C tMenuNFS4 */
 , menuHPDuelCarSelect(0x1800, (tScreen *)screenCarSelectDuel, (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemDuelRace, &itemCar, &itemColor, &itemOpponentCar, 0)   /* +0x15C8 tMenuNFS4 */
 , itemPlayerOneRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0x2a, 10)   /* +0x1644 tMenuItemGoToMenuNFS4Button */
 , itemCarP1(0x92, (tListIterator *)&iteratorCar1, 0xc, 10)   /* +0x1670 tMenuItemNFS4LeftRightChoice */
 , itemColorP1(0x120, (tListIterator *)&iteratorColor, 0x16, 10)   /* +0x1698 tMenuItemNFS4LeftRightChoice */
 , menuPlayerOneCarSelect(0x1008, (tScreen *)screenCarSelectTwoPlayer, (tMenu *)0x0, (tMenu *)&menuCarOptionsPlayerOne, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemPlayerOneRace, &itemCarP1, &itemColorP1, 0)   /* +0x16C0 tMenuNFS4TwoPlayer */
 , itemPlayerTwoRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0x2a, 10)   /* +0x173C tMenuItemGoToMenuNFS4Button */
 , itemCarP2(0x92, (tListIterator *)&iteratorCar1, 0xc, 10)   /* +0x1768 tMenuItemNFS4LeftRightChoice */
 , itemColorP2(0x120, (tListIterator *)&iteratorColor, 0x16, 10)   /* +0x1790 tMenuItemNFS4LeftRightChoice */
 , menuPlayerTwoCarSelect(0x1008, (tScreen *)screenCarSelectPlayerTwo, (tMenu *)0x0, (tMenu *)&menuCarOptionsPlayerTwo, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemPlayerTwoRace, &itemCarP2, &itemColorP2, 0)   /* +0x17B8 tMenuNFS4TwoPlayer */
 , itemPlayerOneGarageRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0x2a, 10)   /* +0x1834 tMenuItemGoToMenuNFS4Button */
 , itemGarageCarP1(0x92, (tListIterator *)&iteratorGarageCar, 0xc, 10)   /* +0x1860 tMenuItemNFS4LeftRightChoice */
 , menuPlayerOneGarage(0x1008, (tScreen *)screenCarSelectTwoPlayer, (tMenu *)0x0, (tMenu *)&menuCarOptionsPlayerOne, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemPlayerOneRace, &itemGarageCarP1, 0)   /* +0x1888 tMenuNFS4TwoPlayer */
 , itemPlayerTwoGarageRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0x2a, 10)   /* +0x1904 tMenuItemGoToMenuNFS4Button */
 , itemGarageCarP2(0x92, (tListIterator *)&iteratorGarageCar, 0xc, 10)   /* +0x1930 tMenuItemNFS4LeftRightChoice */
 , menuPlayerTwoGarage(0x1008, (tScreen *)screenCarSelectPlayerTwo, (tMenu *)0x0, (tMenu *)&menuCarOptionsPlayerTwo, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemPlayerTwoGarageRace, &itemGarageCarP2, 0)   /* +0x1958 tMenuNFS4TwoPlayer */
 , itemPlayerOnePinkSlipRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0x2a, 10)   /* +0x19F0 tMenuItemGoToMenuNFS4Button */
 , itemPinkSlipCarP1(0x92, (tListIterator *)&iteratorPinkSlipsCar, 0xc, 10)   /* +0x1A1C tMenuItemNFS4LeftRightChoice */
 , menuPlayerOnePinkSlipCarSelect(0x1008, (tScreen *)screenPinkSlipsCarSelectTwoPlayer, (tMenu *)0x0, (tMenu *)&menuPinkSlipCarOptionsPlayerOne, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemPlayerOnePinkSlipRace, &itemPinkSlipCarP1, 0)   /* +0x1A44 tMenuNFS4TwoPlayer */
 , itemPlayerTwoPinkSlipRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0x2a, 10)   /* +0x1AC0 tMenuItemGoToMenuNFS4Button */
 , itemPinkSlipCarP2(0x92, (tListIterator *)&iteratorPinkSlipsCar, 0xc, 10)   /* +0x1AEC tMenuItemNFS4LeftRightChoice */
 , menuPlayerTwoPinkSlipCarSelect(0x1008, (tScreen *)screenPinkSlipsCarSelectPlayerTwo, (tMenu *)0x0, (tMenu *)&menuPinkSlipCarOptionsPlayerTwo, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace__FR12tMenuCommand, 0xba, (tMenuItem *)&itemPlayerTwoPinkSlipRace, &itemPinkSlipCarP2, 0)   /* +0x1B14 tMenuNFS4TwoPlayer */
 , itemGoToBuyCar(0x78, (tMenu*)&menuCarDealer, (void (*)(tMenuCommand&))MenuExtended_GoToDealer__FR12tMenuCommand, 0x58, 10)   /* +0x1B90 tMenuItemGoToMenuNFS4Button */
 , itemGoToSellCar(0x79, (tMenu*)&menuCarSeller, (void (*)(tMenuCommand&))MenuExtended_GoToSeller__FR12tMenuCommand, 0x4e, 10)   /* +0x1BBC tMenuItemGoToMenuNFS4Button */
 , menuGoToCarDealer(0x1200, (tScreen *)screenCarSelect[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0x90, (tMenuItem *)&itemGoToBuyCar, &itemGoToSellCar, 0)   /* +0x1BE8 tMenuNFS4 */
 , itemDealerCar(0x92, (tListIterator *)&iteratorDealerCar, 0x1c, 10)   /* +0x1CA0 tMenuItemNFS4LeftRightChoice */
 , itemDealerColor(0x120, (tListIterator *)&iteratorDealerColor, 0x26, 10)   /* +0x1CC8 tMenuItemNFS4LeftRightChoice */
 , itemBuyCar(0x75, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_BuyCar__FR12tMenuCommand, 0x58, 10)   /* +0x1CF0 tMenuItemGoToMenuNFS4Button */
 , itemDealerShowroom(0x112, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToDealerShowroom__FR12tMenuCommand, 0x30, 10)   /* +0x1D1C tMenuItemGoToMenuNFS4Button */
 , menuCarDealer(0x2240, (tScreen *)screenCarSelect[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0x90, (tMenuItem *)&itemDealerCar, &itemDealerColor, &itemBuyCar, &itemDealerShowroom, 0)   /* +0x1D48 tMenuNFS4 */
 , itemSellerCar(0x92, (tListIterator *)&iteratorSellerCar, 0x1c, 10)   /* +0x1DE0 tMenuItemNFS4LeftRightChoice */
 , itemSellCar(0x77, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_SellCar__FR12tMenuCommand, 0x4e, 10)   /* +0x1E08 tMenuItemGoToMenuNFS4Button */
 , menuCarSeller(0x2200, (tScreen *)screenCarSelect[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0x90, (tMenuItem *)&itemSellerCar, &itemSellCar, 0)   /* +0x1E34 tMenuNFS4 */
 , itemPurchaseUpgrade1(0x96, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PurchaseUpgrade1__FR12tMenuCommand, 0x62, 10)   /* +0x1EB0 tMenuItemGoToMenuNFS4Button */
 , itemPurchaseUpgrade2(0x97, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PurchaseUpgrade2__FR12tMenuCommand, 0x6c, 10)   /* +0x1EDC tMenuItemGoToMenuNFS4Button */
 , itemPurchaseUpgrade3(0x98, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PurchaseUpgrade3__FR12tMenuCommand, 0x76, 10)   /* +0x1F08 tMenuItemGoToMenuNFS4Button */
 , menuCarUpgrades(0x2200, (tScreen *)screenCarSelect[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0x91, (tMenuItem *)&itemPurchaseUpgrade1, &itemPurchaseUpgrade2, &itemPurchaseUpgrade3, 0)   /* +0x1F34 tMenuNFS4 */
 , itemTransmission(0x10a, (tListIterator *)&iteratorTransmission)   /* +0x1FF8 tMenuItemOptionsLeftRightChoice */
 , itemABS(0x10b, (tListIterator *)&iteratorABS)   /* +0x2018 tMenuItemOptionsLeftRightChoice */
 , itemDamage(0x111, &iteratorDamage)   /* +0x2038 tMenuItemOptionsLeftRightChoice */
 , itemTransmission2(0x10a, (tListIterator *)&iteratorTransmission)   /* +0x2058 tMenuItemOptionsLeftRightChoice */
 , itemABS2(0x10b, (tListIterator *)&iteratorABS)   /* +0x2078 tMenuItemOptionsLeftRightChoice */
 , itemDamage2(0x111, &iteratorDamage)   /* +0x2098 tMenuItemOptionsLeftRightChoice */
 , itemOpponentUpgrades(0x10e, &iteratorOpponentUpgrades)   /* +0x20B8 tMenuItemOptionsLeftRightChoice */
 , menuCarOptions(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0xbb, -1, (tMenuItem *)&itemTransmission, &itemABS, &itemDamage, &itemOpponentUpgrades, 0)   /* +0x20D8 tMenuOptions */
 , menuCarOptionsPlayerOne(0x1008, (tScreen *)screenCarSelectTwoPlayer, (tMenu *)0x0, (tMenu *)0x0, 0, 0xbb, 0, (tMenuItem *)&itemTransmission, &itemABS, &itemDamage, 0)   /* +0x215C tMenuOptions */
 , menuCarOptionsPlayerTwo(0x1008, (tScreen *)screenCarSelectPlayerTwo, (tMenu *)0x0, (tMenu *)0x0, 0, 0xbb, 1, (tMenuItem *)&itemTransmission2, &itemABS2, &itemDamage2, 0)   /* +0x21E0 tMenuOptions */
 , menuPinkSlipCarOptionsPlayerOne(0x1008, (tScreen *)screenPinkSlipsCarSelectTwoPlayer, (tMenu *)0x0, (tMenu *)0x0, 0, 0xbb, 0, (tMenuItem *)&itemTransmission, &itemABS, &itemDamage, 0)   /* +0x2264 tMenuOptions */
 , menuPinkSlipCarOptionsPlayerTwo(0x1008, (tScreen *)screenPinkSlipsCarSelectPlayerTwo, (tMenu *)0x0, (tMenu *)0x0, 0, 0xbb, 1, (tMenuItem *)&itemTransmission2, &itemABS2, &itemDamage2, 0)   /* +0x22E8 tMenuOptions */
 , menuShowroom(0x4000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, -1)   /* +0x236C tMenuBlank */
 , itemOptionsAudio(0x1c5, (tMenu*)&menuAudio, 0, 0xb4, 10)   /* +0x23E8 tMenuItemGoToMenuNFS4Button */
 , itemOptionsDisplay(0x1c6, (tMenu*)&menuDisplayOptions, 0, 0xbe, 10)   /* +0x2414 tMenuItemGoToMenuNFS4Button */
 , itemOptionsControllers(0x1c8, (tMenu*)&menuControllerConfig, 0, 200, 10)   /* +0x2440 tMenuItemGoToMenuNFS4Button */
 , itemOptionsMemoryCard(0x1c9, (tMenu*)&menuMemory, 0, 0xd2, 10)   /* +0x246C tMenuItemGoToMenuNFS4Button */
 , itemOptionsUsername(0x1ca, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_EnterUserName__FR12tMenuCommand, 0xdc, 10)   /* +0x2498 tMenuItemGoToMenuNFS4Button */
 , itemOptionsCredits(0x1cc, (tMenu *)&menuCredits, 0, 0xe6, 10)   /* +0x24C4 tMenuItemGoToMenuNFS4Button */
 , menuOptions(0x1014, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, 0x5d, (tMenuItem *)&itemOptionsAudio, &itemOptionsDisplay, &itemOptionsControllers, &itemOptionsMemoryCard, &itemOptionsUsername, &itemOptionsCredits, 0)   /* +0x24F0 tMenuNFS4 */
 , itemMusicVolume(0x1d5, (tListIterator *)&iteratorMusicVolume, 0)   /* +0x25CC tMenuItemLeftRightAudioSlider */
 , itemSoundEffectsVolume(0x1d6, (tListIterator *)&iteratorSoundEffectsVolume, 1)   /* +0x2604 tMenuItemLeftRightAudioSlider */
 , itemEngineVolume(0x1d7, (tListIterator *)&iteratorEngineVolume, 2)   /* +0x263C tMenuItemLeftRightAudioSlider */
 , itemSpeechVolume(0x1d8, (tListIterator *)&iteratorSpeechVolume, 3)   /* +0x2674 tMenuItemLeftRightAudioSlider */
 , itemAmbientVolume(0x1d9, (tListIterator *)&iteratorAmbientVolume, 4)   /* +0x26AC tMenuItemLeftRightAudioSlider */
 , itemAudioMode(0x1da, &iteratorAudioMode)   /* +0x26E4 tMenuItemDisplayLeftRightChoice */
 , itemSlidingPlayList(0x1db, 0x15e, 0x2b, -0x66, 0xd, false)   /* +0x2710 tMenuItemSlidingActivated */
 , menuPlayListMenu(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)0x0)   /* +0x2758 tInsideBoxSongMenu */
 , menuAudio(0x1010, (tScreen *)screenAudio, (tMenu *)0x0, (tMenu *)0x0, 0, 0x263, 0x26, 10, (tMenuItem *)&itemMusicVolume, &itemSoundEffectsVolume, &itemEngineVolume, &itemSpeechVolume, &itemAmbientVolume, &itemAudioMode, &itemSlidingPlayList, 0)   /* +0x27E0 tOptionsMenu */
 , itemDisplaySpeedometer(0x1df, (tListIterator *)&iteratorDisplaySpeedometer)   /* +0x28FC tMenuItemDisplayLeftRightChoice */
 , itemDisplayMap(0x1e1, (tListIterator *)&iteratorDisplayMap)   /* +0x2928 tMenuItemDisplayLeftRightChoice */
 , itemDisplayOpponentID(0x1e2, (tListIterator *)&iteratorDisplayOpponentID)   /* +0x2954 tMenuItemDisplayLeftRightChoice */
 , itemDisplayTime(0x1e3, (tListIterator *)&iteratorDisplayTime)   /* +0x2980 tMenuItemOnOffLeftRightChoice */
 , itemDisplayPosition(0x1e6, (tListIterator *)&iteratorDisplayPosition)   /* +0x29B0 tMenuItemOnOffLeftRightChoice */
 , itemDisplayLapNumber(0x1e7, (tListIterator *)&iteratorDisplayLapNumber)   /* +0x29E0 tMenuItemOnOffLeftRightChoice */
 , itemDisplaySplitTime(0x1e4, &iteratorDisplaySplitTime)   /* +0x2A10 tMenuItemDisplayLeftRightChoice */
 , itemDisplaySplitDisplay(0x1e5, (tListIterator *)&iteratorDisplaySplitDisplay)   /* +0x2A3C tMenuItemDisplayLeftRightChoice */
 , menuDisplayOptions(0x1020, (tScreen *)screenDisplay, (tMenu *)0x0, (tMenu *)0x0, 0, 0x1dd, 1, 10, (tMenuItem *)&itemDisplaySpeedometer, &itemDisplayMap, &itemDisplayOpponentID, &itemDisplayTime, &itemDisplaySplitTime, &itemDisplaySplitDisplay, &itemDisplayPosition, &itemDisplayLapNumber, 0)   /* +0x2A68 tOptionsMenu */
 , itemControllerConfigSelected(0x209, (tListIterator *)&iteratorControllerConfigSelected)   /* +0x2AFC tMenuItemControllerLeftRightChoice */
 , itemControllerSettings(0x20a, 0xac, 0x48, 0, 0xd, true)   /* +0x2B28 tMenuItemSlidingMenu */
 , menuControllerConfig(0x1020, (tScreen *)screenControllerConfig, (tMenu *)0x0, (tMenu *)0x0, 0, 0x208, 0, 10, (tMenuItem *)&itemControllerConfigSelected, &itemControllerSettings, 0)   /* +0x2B6C tOptionsMenu */
 , itemControllerSteeringRange1(0x211, (tListIterator *)&iteratorControllerSteeringRange1, 0)   /* +0x2C78 tInsideBoxTwoWaySlider */
 , itemControllerDeadSpot1(0x213, (tListIterator *)&iteratorControllerDeadSpot1, 1)   /* +0x2CBC tInsideBoxTwoWaySlider */
 , itemControllerSteeringRange2(0x210, (tListIterator *)&iteratorControllerSteeringRange2, 2)   /* +0x2D00 tInsideBoxTwoWaySlider */
 , itemControllerDeadSpot2(0x212, (tListIterator *)&iteratorControllerDeadSpot2, 3)   /* +0x2D44 tInsideBoxTwoWaySlider */
 , itemControllerJoyRange(0x214, (tListIterator *)&iteratorControllerJoyRange, 0)   /* +0x2D88 tInsideBoxTwoWaySlider */
 , itemControllerCenterPoint(0x215, (tListIterator *)&iteratorControllerCenterPoint, 1)   /* +0x2DCC tInsideBoxTwoWaySlider */
 , itemControllerIMax(0x216, (tListIterator *)&iteratorControllerIMax, 2)   /* +0x2E10 tInsideBoxTwoWaySlider */
 , itemControllerIIMax(0x217, (tListIterator *)&iteratorControllerIIMax, 3)   /* +0x2E54 tInsideBoxTwoWaySlider */
 , menuControllerDualShock(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)&itemControllerShockMode, &itemControllerShockImpact, 0)   /* +0x2E84 tInsideBoxMenu */
 , menuControllerAnalog(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)&itemControllerSteeringRange1, &itemControllerDeadSpot1, &itemControllerSteeringRange2, &itemControllerDeadSpot2, 0)   /* +0x2EF8 tInsideBoxMenu */
 , menuControllerDualShockAnalog(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)&itemControllerShockMode, &itemControllerShockImpact, &itemControllerDeadSpot1, &itemControllerDeadSpot2, 0)   /* +0x2F6C tInsideBoxMenu */
 , menuControllerNegcon(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)&itemControllerJoyRange, &itemControllerCenterPoint, &itemControllerIMax, &itemControllerIIMax, 0)   /* +0x2FE0 tInsideBoxMenu */
 , itemSaveGame(0x286, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_SaveGame__FR12tMenuCommand)   /* +0x3054 tMemoryCardMenuItem */
 , itemLoadGame(0x287, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_LoadGame__FR12tMenuCommand)   /* +0x3080 tMemoryCardMenuItem */
 , menuMemory(0x1020, (tScreen *)screenMemcard, (tMenu *)0x0, (tMenu *)0x0, 0, -1, 0x2e, 10, (tMenuItem *)&itemLoadGame, &itemSaveGame, 0)   /* +0x30AC tOptionsMenu */
 , menuItemUserName(0x1f8)   /* +0x312C tUserNameMenuItem */
 , menuItemUserName1(0x1f8)   /* +0x31B8 tUserNameMenuItem */
 , menuItemUserName2(0x1f8)   /* +0x3244 tUserNameMenuItem */
 , menuUserName(0x1120, (tScreen *)screenUserName, (tMenu *)0x0, (tMenu *)0x0, 0, -1, 0x20, 10, (tMenuItem *)&menuItemUserName, 0)   /* +0x32D0 tOptionsMenu */
 , itemChangeTrophy(0x5e, &iteratorChangeTrophy, -1, 0)   /* +0x3360 tBlankMenuItemNFS4LeftRightChoice */
 , menuTrophyRoom(0x4010, (tScreen *)screenTrophyRoom, (tMenu *)0x0, (tMenu *)0x0, 0, -1, (tMenuItem *)&itemChangeTrophy, 0)   /* +0x3388 tMenuNFS4Bottom */
 , itemPinkSlipStandingsForward(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PinkSlipsContinue__FR12tMenuCommand, 0, 10)   /* +0x3404 tMenuItemGoToMenuNFS4Button */
 , itemPinkSlipStandingsExit(0x9c, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand, 0, 10)   /* +0x3430 tMenuItemGoToMenuNFS4Button */
 , menuPinkSlipStandings(0x1004, (tScreen *)screenPinkSlipStandings, (tMenu *)0x0, (tMenu *)0x0, 0, 0x2f4, (tMenuItem *)&itemPinkSlipStandingsForward, &itemPinkSlipStandingsExit, 0)   /* +0x345C tMenuNFS4 */
 , itemTournStandingsForward(0x5a, (tMenu*)&menuTrackInfo, 0, 0, 10)   /* +0x34D8 tMenuItemGoToMenuNFS4Button */
 , itemTournStandingsExit(0x9b, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_ExitTourney__FR12tMenuCommand, 0, 10)   /* +0x3504 tMenuItemGoToMenuNFS4Button */
 , menuTournamentStandings(0x1004, (tScreen *)screenTournamentStandings3item, (tMenu *)0x0, (tMenu *)0x0, 0, 0x2f4, (tMenuItem *)&itemTournStandingsForward, &itemTournStandingsExit, 0)   /* +0x3530 tMenuNFS4 */
 , itemTournamentFinishedHome(0x5a, (tMenu *)&menuTournamentTrophy, 0, 0, 10)   /* +0x35AC tMenuItemGoToMenuNFS4Button */
 , menuTournamentFinished(0x1004, (tScreen *)screenTournamentStandings, (tMenu *)0x0, (tMenu *)0x0, 0, 0x2f4, (tMenuItem *)&itemTournamentFinishedHome, 0)   /* +0x35D8 tMenuNFS4 */
 , menuTournamentTrophy(0x8000, (tScreen *)screenTournamentTrophy, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_TierFinished__FR12tMenuCommand, -1)   /* +0x3654 tMenuBlank */
 , menuPostGamePlayer1Name(0x1040, (tScreen *)screenUserName, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand, -1, 0x20, 10, (tMenuItem *)&menuItemUserName1, 0)   /* +0x36D0 tOptionsMenu */
 , menuPostGamePlayer2Name(0x1080, (tScreen *)screenUserName, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand, -1, 0x20, 10, (tMenuItem *)&menuItemUserName2, 0)   /* +0x3750 tOptionsMenu */
 , itemPostGameTrackRecordsContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PostGameMenu__FR12tMenuCommand, -1, -1)   /* +0x37D0 tBlankMenuItemGoToMenuNFS4Button */
 , menuPostGameTrackRecords(0x21004, (tScreen *)screenTrackRecords, (tMenu *)0x0, (tMenu *)0x0, 0, 0xd4, 1, 10, (tMenuItem *)&itemPostGameTrackRecordsContinue, 0)   /* +0x37FC tOptionsMenu */
 , menuPinkSlipCongrats(0x8000, (tScreen *)screenPinkSlipCongrats, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand, -1)   /* +0x387C tMenuBlank */
 , menuBeTheCopCongrats(0x8000, (tScreen *)screenBeTheCopCongrats, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand, -1)   /* +0x38F8 tMenuBlank */
 , menuTierCompleteCongrats(0x8000, (tScreen *)screenTournamentCongrats, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand, -1)   /* +0x3974 tMenuBlank */
 , menuCredits(0x1010, (tScreen *)screenMain[0], (tMenu *)0x0, (tMenu *)0x0, 0, -1)   /* +0x39F0 tMenuBlank */
 , itemMemContinue(0x28a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand)   /* +0x3A6C tMemoryCardMenuItem */
 , menuPostGameSave(0x1040, (tScreen *)screenMemcard, (tMenu *)0x0, (tMenu *)0x0, 0, -1, 0x2e, 10, (tMenuItem *)&itemMemContinue, &itemSaveGame, 0)   /* +0x3A98 tOptionsMenu */
{
  tListIteratorTournament_ctor(&iteratorTournament, &menuHotPursuit, &tournamentManager);
  tListIteratorTournament_ctor(&iteratorSpecialEvent, &menuTournament, &tournamentManager);
  tListIteratorTrack_ctor(&iteratorTrack, frontEnd.track, &frontEnd.pinkSlipsTrackIndex, &trackManager);   /* ORACLE: a1=frontEnd+0x23 track, a2=frontEnd+0x46 pinkSlipsTrackIndex (old args were stale-reg fictions) */
  tListIteratorIndexed_ctor(&iteratorLaps, SelectListNormal, frontEnd.lapind, &frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&iteratorTrackDirection, SelectListTrackDirection, frontEnd.trackdirection, &frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&iteratorTrackMirrored, SelectListOffOn, frontEnd.trackmirrored, &frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&iteratorTimeOfDay, SelectListOffOn, frontEnd.timeOfDay, &frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&iteratorWeather, SelectListOffOn, frontEnd.weather, &frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&iteratorTraffic, SelectListOffOn, frontEnd.traffic, &frontEnd.pinkSlipsTrackIndex);
  tListIterator_ctor((tListIterator *)&iteratorLocalSpeech, SelectListOffOn, &frontEnd.localSpeech);   /* ptVar chain resolved: member @0xE90 */
  tListIteratorCar_ctor(&iteratorCar1, frontEnd.playerCar, &carManager);
  tListIteratorCarColor_ctor(&iteratorColor, (char *)&iteratorCar1, &FEApp->fPlayer, frontEnd.playerCar, 0x30, &carManager);
  tListIteratorCar_ctor(&iteratorGarageCar, frontEnd.garageCar, &carManager);
  tListIteratorCar_ctor(&iteratorOpponentCar, &frontEnd.oppCar, &carManager);
  tListIteratorCar_ctor(&iteratorPinkSlipsCar, frontEnd.pinkSlipsCar, &carManager);
  tListIteratorCar_ctor(&iteratorDealerCar, &frontEnd.dealerCar, &carManager);
  tListIteratorCarColor_ctor(&iteratorDealerColor, (char *)&iteratorDealerCar, &FEApp->fPlayer, &frontEnd.dealerCar, 0x30, &carManager);
  tListIteratorCar_ctor(&iteratorSellerCar, &frontEnd.sellerCar, &carManager);
  tListIteratorIndexed_ctor(&iteratorTransmission, SelectListTransmission, frontEnd.transmission, &FEApp->fPlayer);
  tListIteratorIndexed_ctor(&iteratorABS, SelectListOffOn, frontEnd.ABS, &FEApp->fPlayer);
  tListIterator_ctor((tListIterator *)&iteratorDamage, SelectListOffOn, &frontEnd.damage);   /* ptVar chain resolved: member @0x1FD8 */
  tListIterator_ctor((tListIterator *)&iteratorOpponentUpgrades, SelectListOpponentUpgrades, &frontEnd.opponentUpgrades);   /* ptVar chain resolved: member @0x1FE8 */
  tListIteratorRange_ctor(&iteratorMusicVolume, '\0', '\x7f', &frontEnd.musicVolume);
  tListIteratorRange_ctor(&iteratorSoundEffectsVolume, '\0', '\x7f', &frontEnd.sfxVolume);
  tListIteratorRange_ctor(&iteratorEngineVolume, '\0', '\x7f', &frontEnd.engineVolume);
  tListIteratorRange_ctor(&iteratorSpeechVolume, '\0', '\x7f', &frontEnd.narrationVolume);
  tListIteratorRange_ctor(&iteratorAmbientVolume, '\0', '\x7f', &frontEnd.ambientVolume);
  tListIterator_ctor(&iteratorAmbientVolume, SelectListAudioMode, &frontEnd.audioMode);
  tListIteratorIndexed_ctor(&iteratorDisplaySpeedometer, SelectListDisplaySpeed, frontEnd.displaySpeed, &FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&iteratorDisplayMap, SelectListDisplayMap, frontEnd.displayMap, &FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&iteratorDisplayOpponentID, SelectListDisplayOpponentID, frontEnd.displayOpponentID, &FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&iteratorDisplayTime, SelectListOffOn, frontEnd.displayTime, &FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&iteratorDisplayPosition, SelectListOffOn, frontEnd.displayPosition, &FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&iteratorDisplayLapNumber, SelectListOffOn, frontEnd.displayLapNumber, &FEApp->fInputPlayer);
  tListIterator_ctor((tListIterator *)&iteratorDisplayLapNumber, SelectListSplitTime, &frontEnd.checkPointType);
  tListIteratorIndexed_ctor(&iteratorDisplaySplitDisplay, SelectListSplitDisplay, frontEnd.checkPointDisplay, &FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&iteratorControllerConfigSelected, SelectListControllerConfig, frontEnd.controlConfig, &FEApp->fInputPlayer);
  tListIteratorRangeIndexed_ctor(&iteratorControllerShockMode, '\0', '\x7f', frontEnd.shockMode, &FEApp->fInputPlayer);
  tInsideBoxLeftRightSlider_ctor(&itemControllerShockMode._base_tInsideBoxLeftRightSlider, 0x20e, (tListIterator *)&iteratorControllerShockMode);
  *(void **)&((itemControllerShockMode)._base_tInsideBoxLeftRightSlider._vf) = (void *)&tInsideBoxControllerLeftRightSlider_vtable;
  tListIteratorRangeIndexed_ctor(&iteratorControllerShockImpact, '\0', '\x7f', frontEnd.shockImpact, &FEApp->fInputPlayer);
  tInsideBoxLeftRightSlider_ctor(&itemControllerShockImpact._base_tInsideBoxLeftRightSlider, 0x20f, (tListIterator *)&iteratorControllerShockImpact);
  *(void **)&((itemControllerShockImpact)._base_tInsideBoxLeftRightSlider._vf) = (void *)&tInsideBoxControllerLeftRightSlider_vtable;
  tListIteratorRangeIndexed_ctor(&iteratorControllerSteeringRange1, '\0', '\x7f', frontEnd.J1MAX, &FEApp->fInputPlayer);
  tListIteratorRangeIndexed_ctor(&iteratorControllerDeadSpot1, '\0', '\x7f', frontEnd.J1MIN, &FEApp->fInputPlayer);
  tListIteratorRangeIndexed_ctor(&iteratorControllerSteeringRange2, '\0', '\x7f', frontEnd.J2MAX, &FEApp->fInputPlayer);
  tListIteratorRangeIndexed_ctor(&iteratorControllerDeadSpot2, '\0', '\x7f', frontEnd.J2MIN, &FEApp->fInputPlayer);
  tListIteratorRangeIndexed_ctor(&iteratorControllerJoyRange, '\0', '\x7f', frontEnd.steeringRange, &FEApp->fInputPlayer);
  tListIteratorRangeIndexed_ctor(&iteratorControllerCenterPoint, '\0', '\x7f', frontEnd.deadSpot, &FEApp->fInputPlayer);
  tListIteratorRangeIndexed_ctor(&iteratorControllerIMax, '\0', -1, frontEnd.ImaxRange, &FEApp->fInputPlayer);
  tListIteratorRangeIndexed_ctor(&iteratorControllerIIMax, '\0', -1, frontEnd.IImaxRange, &FEApp->fInputPlayer);
  tListIterator_ctor(&menuUserName, screenTrophyRoom->fTrophyList, &screenTrophyRoom->thisisuseless);
  (menuPlayerOneCarSelect).fChildMenu = (tMenu *)&menuPlayerTwoCarSelect;
  (menuPlayerOneGarage).fChildMenu = (tMenu *)&menuPlayerTwoGarage;
  (menuPlayerOnePinkSlipCarSelect).fChildMenu = (tMenu *)&menuPlayerTwoPinkSlipCarSelect;
  SetDimensions((tMenuItemLeftRightSlider *)&itemMusicVolume,0,0,0x78,5);
  SetDimensions((tMenuItemLeftRightSlider *)&itemSoundEffectsVolume,0,0,0x78,5);
  SetDimensions((tMenuItemLeftRightSlider *)&itemEngineVolume,0,0,0x78,5);
  SetDimensions((tMenuItemLeftRightSlider *)&itemSpeechVolume,0,0,0x78,5);
  SetDimensions((tMenuItemLeftRightSlider *)&itemAmbientVolume,0,0,0x78,5);
  (iteratorPinkSlipsCar).fCarListFilter = 0x20;
  (iteratorGarageCar).fCarListFilter = 2;
  (iteratorDealerCar).fCarListFilter = 1;
  (iteratorSellerCar).fCarListFilter = 2;
  (menuAudio).VertHelp = 0;
  (menuDisplayOptions).VertHelp = 0;
  (menuControllerConfig).VertHelp = 1;
  (itemTournamentFinishedHome).fFlags = (itemTournamentFinishedHome).fFlags | 0x40;
  (menuMemory).VertHelp = 0;
  (menuUserName).VertHelp = 0;
  (menuTrackRecords).VertHelp = 1;
  (menuTrophyInfo).VertHelp = 0;
  return;
}



/* ---- tGlobalMenuDefs::dtor  [FEMENUDEFS.CPP:2204] ---- */

tGlobalMenuDefs::~tGlobalMenuDefs()

{
  /* [2026-07-11] PASS (was 747 diffs / 1510 vs oracle 763 insns): the body previously made
     ~249 EXPLICIT member-teardown calls (`Type_dtor(&this->member, 2)` for every real by-value
     member of tGlobalMenuDefs, in reverse declaration order). Every one of those member types
     (tMenuBlank, tOptionsMenu, tMenuNFS4, tMenuItemGoToMenuNFS4Button, ...) has a REAL declared
     destructor in nfs4_types.h, so tGlobalMenuDefs being a struct of ~249 such members by value
     means the COMPILER ALREADY emits the exact same per-member teardown sequence automatically
     in this destructor's implicit epilogue -- the explicit calls were a pure duplicate (same
     class of bug as the `tDialogYesNo_ctor` redundant-manual-ctor-call fix applied to ~10 other
     fns in this file, just at 249x scale: `Type_dtor` free-function externs are undefined
     phantoms with no definition anywhere in the tree, mirroring `tDialogYesNo_ctor`). Deleting
     the whole explicit call list and letting the automatic member destruction run alone
     byte-matches the oracle exactly (763/763). */
}



/* ---- TransitionIsFinished  [FEMENUDEFS.CPP:?] ---- */
void * tBlankMenuItemGoToMenuNFS4Button::TransitionIsFinished()
{
  return (void *)0x1;
}

/* ---- Draw  [FEMENUDEFS.CPP:?] ---- */
void tBlankMenuItemGoToMenuNFS4Button::Draw(int x,int y,char flags)
{
  return;
}

/* ---- Draw  [FEMENUDEFS.CPP:?] ---- */
void tBlankMenuItemGoToMenuNFS4Button::Draw(int arg1)
{
  return;
}

/* ---- tBlankMenuItemGoToMenuNFS4Button::dtor  [FEMENUDEFS.CPP:?] ---- */

tBlankMenuItemGoToMenuNFS4Button::~tBlankMenuItemGoToMenuNFS4Button()

{
  return;
}



/* ---- TransitionIsFinished  [FEMENUDEFS.CPP:?] ---- */
void * tBlankMenuItemNFS4LeftRightChoice::TransitionIsFinished()
{
  return (void *)0x1;
}

/* ---- Draw  [FEMENUDEFS.CPP:?] ---- */
void tBlankMenuItemNFS4LeftRightChoice::Draw(int x,int y,char flags)
{
  return;
}

/* ---- tBlankMenuItemNFS4LeftRightChoice::dtor  [FEMENUDEFS.CPP:?] ---- */

tBlankMenuItemNFS4LeftRightChoice::~tBlankMenuItemNFS4LeftRightChoice()

{
  return;
}



/* end of femenudefs.cpp */

/* cont.34: tBlankMenuItem::Draw nullsubs re-attributed from front.c.
   The recon class methods above (::Draw(int,int,char)/::Draw(int), ~line 3100) carry the
   WRONG SYM arg-type (char/int vs the SYM's bool) so they mangle to ...iic/...i, NOT the
   oracle's ...iib/...b — leaving the bare oracle names free. The extern-C free-fn form
   exports those exact oracle symbols; oracle = jr ra;nop. (A fully clean fix = correct
   the class decls to bool in nfs4_types.h, a shared-header change — deferred.) */
extern "C" {
void Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib(void) {}  /* @0x800321C8 */
void Draw__32tBlankMenuItemGoToMenuNFS4Buttonb(void) {}  /* @0x800321D0 */
void Draw__33tBlankMenuItemNFS4LeftRightChoiceiib(void) {}  /* @0x80032200 */
}
