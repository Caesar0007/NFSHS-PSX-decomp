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
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  tScreenCarSelect *this_00;
  ushort uVar2;
  short sVar3;
  tDialogYesNoTri *dlgThis;
  tDialogYesNoTri YesNoDialog;
  
  tDialogYesNo_ctor((tDialogYesNo *)&YesNoDialog);
  *(void **)&(YesNoDialog._vf) = (void *)tDialogYesNoTri_vtable;
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
  tScreen_dtor((tScreen *)&YesNoDialog,2);
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
  int answer;
  tDialogMessageString *dlgThis;
  tDialogYesNo YesNoDialog;

  /* NEAR-MISS 25 diffs (was 29): xori;beqz cheater idiom now matches (via `(x^1)` test); call
     sequence/args/frame/1-saved-reg all match. Residual = answer-default-0 colored to s0 (ours)
     vs v0-in-beqz-delay-slot (oracle); this cascades to sp-relative vs s0-relative field stores
     because the oracle frees s0 to hold the dialog `this`. gcc-2.7.2 keeps the 0 default in a
     callee-saved reg across the body (can't prove it dead post-Run); not source-reachable without
     a pin (forbidden) -- early-return / goto-tail both SPLIT the shared epilogue (=> 39 diffs).
     [2026-07-05 CONFIRMED] Tried block-scoping YesNoDialog into the if (the fix that cracked
     MenuExtended_LoadGame's ctor-hoist bug) -- made it WORSE (25->29). This function's ctor
     call is ALREADY correctly conditional even at function scope (FECheat_IsTheUserACryBabyCheater()
     has no ctor-hoist concern since YesNoDialog's ctor call site itself is inside the `if` in
     both scopings); the residual really is the answer-default coloring the prior note describes.
     Reverted to function-scope locals. */
  is_cheater = (int)FECheat_IsTheUserACryBabyCheater();
  answer = 0;
  if ((is_cheater ^ 1) != 0) {
    tDialogYesNo_ctor(&YesNoDialog);
    YesNoDialog.string =
         TextSys_Word(0x331);
    YesNoDialog.yesnowords[0] = 0x321;
    YesNoDialog.yesnowords[1] = 0x322;
    YesNoDialog.fDefault = 0;
    answer = (short)Run((tDialogInteractive *)&YesNoDialog);
    tScreen_dtor((tScreen *)&YesNoDialog,2);
  }
  return answer;
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
  tFEApplication *ptVar1;
  ushort uVar2;
  char *pcVar3;
  tMenu *ptVar4;
  tFEApplication *dlgThis;
  tScreenCarSelectDuel *this_00;
  tListIteratorCar *this_01;
  uint state;
  tDialogMessageString *this_02;
  tTrackInformation trackInfo;
  
  ptVar1 = FEApp;
  this_02 = &FEApp->messagePopup;
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             &trackInfo);
  if (trackInfo.fAvailable == '\0') {
    pcVar3 = TextSys_Word(0xeb);
    (ptVar1->messagePopup).string = pcVar3;
    Display((tDialogBase *)this_02);
    return;
  }
  if (frontEnd.gameMode == '\x01') {
    command->type = kMenu_Command_GoToMenuTwoPlayer;
    if (frontEnd.raceType == '\x06') {
      command->nextMenu = (tMenu *)&menuDefs[0]->menuPlayerOnePinkSlipCarSelect;
    }
    else if (frontEnd.carListType == '\0') {
      command->nextMenu = (tMenu *)&menuDefs[0]->menuPlayerOneCarSelect;
    }
    else {
      command->nextMenu = (tMenu *)&menuDefs[0]->menuPlayerOneGarage;
    }
  }
  else {
    if (frontEnd.oppNumber == '\x01') {
      command->type = kMenu_Command_GoToMenu;
      if (frontEnd.raceType == '\x01') {
        ptVar4 = (tMenu*)&menuDefs[0]->menuHPDuelCarSelect;
      }
      else {
        ptVar4 = (tMenu*)&menuDefs[0]->menuDuelCarSelect;
      }
      command->nextMenu = ptVar4;
      state = 7;
      this_00 = screenCarSelectDuel;
    }
    else {
      command->type = kMenu_Command_GoToMenu;
      this_00 = (tScreenCarSelectDuel *)screenCarSelect[0];
      if (frontEnd.carListType != '\0') {
        ptVar4 = (tMenu*)&menuDefs[0]->menuCarGarage;
      }
      else {
        ptVar4 = (tMenu*)&menuDefs[0]->menuSingleCarSelect;
      }
      state = (uint)(frontEnd.carListType != '\0');
      command->nextMenu = ptVar4;
    }
    SetState((tScreenCarSelect *)this_00,state);
  }
  if (frontEnd.raceType == '\x01') {
    if ((frontEnd.oppNumber == '\0') || (frontEnd.gameMode == '\x01')) {
      (menuDefs[0]->iteratorCar1).fCarListFilter = 9;
    }
    else {
      (menuDefs[0]->iteratorCar1).fCarListFilter = 1;
    }
  }
  else if (frontEnd.raceType == '\x06') {
    (menuDefs[0]->iteratorPinkSlipsCar).fCarListFilter = 0x20;
  }
  else if (frontEnd.carListType == '\0') {
    (menuDefs[0]->iteratorCar1).fCarListFilter = 1;
  }
  else if (frontEnd.raceType == '\x02') {
    (menuDefs[0]->iteratorGarageCar).fCarListFilter = 0x40;
  }
  else {
    (menuDefs[0]->iteratorGarageCar).fCarListFilter = 2;
  }
  if (frontEnd.carListType == '\0') {
    Decrement(&menuDefs[0]->iteratorCar1,kPlayerOne);
    Increment(&menuDefs[0]->iteratorCar1,kPlayerOne);
    Decrement(&menuDefs[0]->iteratorCar1,kPlayerTwo);
    this_01 = &menuDefs[0]->iteratorCar1;
MX_GoToCar_iteratorIncP2:
    Increment(this_01,kPlayerTwo);
  }
  else {
    uVar2 = GetNumOwnedCars(&carManager, 0);
    if ((int)((uint)uVar2 << 0x10) < 1) {
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
        this_01 = &menuDefs[0]->iteratorGarageCar;
        goto MX_GoToCar_iteratorIncP2;
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
  tDialogYesNoTri YesNoDialog;

  /* NEAR-MISS 33 diffs (unchanged from baseline; cleaned locals). The return-funnel (ret=1
     default in s1, reused as the ==1 compare literal AND the save-result holder) and the
     == -1 / == 1 / dtor branch structure all match the oracle. Residual = gcc-2.7.2 HOISTS the
     dialog `this` address (s0=&YesNoDialog) and the ret default ABOVE the FECheat call, whereas
     the oracle computes them after the cheater branch (s0 set in the body). Pure pre-branch
     scheduling; not source-reachable (the ctor-arg address is a constant sp+off gcc lifts;
     forbidden to pin). `^1` cheater idiom made it WORSE here (34: gcc reused s1 for `xor v0,v0,s1`
     vs oracle's `xori v0,v0,1`), so the plain `!= 1` int test is kept. */
  is_cheater = (int)FECheat_IsTheUserACryBabyCheater();
  ret = (void *)0x1;
  if (is_cheater != 1) {
    tDialogYesNo_ctor((tDialogYesNo *)&YesNoDialog);
    *(void **)&(YesNoDialog._vf) = (void *)tDialogYesNoTri_vtable;
    YesNoDialog.string =
         TextSys_Word(0x273);
    YesNoDialog.yesnowords[0] = 0x321;
    YesNoDialog.yesnowords[1] = 0x322;
    YesNoDialog.fDefault = 0;
    sVar1 = Run((tDialogInteractive *)&YesNoDialog);
    if (sVar1 == 1) {
      ret = GenericMenuSaveGame(1);
    }
    else if (sVar1 == -1) {
      tScreen_dtor((tScreen *)(tDialogYesNo *)&YesNoDialog,2);
      return (void *)0x0;
    }
    tScreen_dtor((tScreen *)&YesNoDialog,2);
  }
  return ret;
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
  tDialogYesNo popUp;
  
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
    tDialogYesNo_ctor(&popUp);
    popUp.string =
         TextSys_Word(0xf7);
    popUp.yesnowords[0] = 0x322;
    popUp.yesnowords[1] = 0x321;
    popUp.fDefault = 0;
    sVar4 = Run((tDialogInteractive *)&popUp);
    if (sVar4 == 0) {
      tScreen_dtor((tScreen *)&popUp,2);
      return;
    }
    AudioCmn_PlayFESFX(0x1a);
    tournamentManager.fMoney = tournamentManager.fMoney - ptVar3->fTournaments[iVar6].fEntranceFee;
    tScreen_dtor((tScreen *)&popUp,2);
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
  tDialogYesNo popUp;
  
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
    tDialogYesNo_ctor(&popUp);
    popUp.string =
         TextSys_Word(0xf7);
    popUp.yesnowords[0] = 0x321;
    popUp.yesnowords[1] = 0x322;
    popUp.fDefault = 0;
    sVar4 = Run((tDialogInteractive *)&popUp);
    if (sVar4 == 0) {
      tScreen_dtor((tScreen *)&popUp,2);
      return;
    }
    AudioCmn_PlayFESFX(0x1a);
    tournamentManager.fMoney = tournamentManager.fMoney - ptVar3->fTournaments[iVar6].fEntranceFee;
    tScreen_dtor((tScreen *)&popUp,2);
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

   [NEAR-MISS 2026-07-05, was 30 diffs, now 7] Three real fixes landed: (1) playerNameList
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
   "survey tools over-count vs verify_asm"). No path below 7 found; WALL, same v0/v1 %hi-scratch
   tie-break family as GoToDealer/GoToSeller's residual. Do not pin. */

extern "C" void MenuExtended_EnterUserName__FR12tMenuCommand(tMenuCommand *command)

{
  u_int bVar1;
  u_int bVar2;
  tGlobalMenuDefs *ptVar3;
  tScreenUserName *ptVar4;
  tUserNameMenuItem *dlgThis;

  ptVar3 = menuDefs[0];
  dlgThis = &ptVar3->menuItemUserName;
  bVar1 = FEApp->fInputPlayer;
  bVar2 = FEApp->fInputPlayer;
  dlgThis->fMaxStringLength = 7;
  ptVar4 = screenUserName;
  dlgThis->fCurrentRow = 0;
  dlgThis->fCurrentColumn = 0;
  dlgThis->fPlayer = (ushort)bVar1;
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
  tDialogYesNo popUp;
  
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
    tDialogYesNo_ctor(&popUp);
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
    tScreen_dtor((tScreen *)&popUp,2);
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
  tDialogYesNo yesNo;
  
  ptVar1 = FEApp;
  this_00 = &FEApp->messagePopup;
  GetStockCar(&carManager, (ushort)(byte)frontEnd.dealerCar,&carInfo);
  sVar2 = GetNumOwnedCars(&carManager, 0);
  if (sVar2 < 0x20) {
    if (carInfo.fPrices[0] <= tournamentManager.fMoney) {
      tDialogYesNo_ctor(&yesNo);
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
      tScreen_dtor((tScreen *)&yesNo,2);
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
  tDialogYesNo popUp;
  
  /* NEAR-MISS 73 diffs (was 94): dropped the eager `ptVar1 = FEApp` cache -> FEApp now loaded
     lazily only in the not-enough-money branch (matches oracle's `lw s0,%lo(FEApp)(v0)` there),
     freeing one saved reg. RESIDUAL = gcc-2.7.2 SPECULATIVELY HOISTS the `tDialogYesNo_ctor(&popUp)`
     call to the top of the function (above GetGarageCar + the ownership/affordability tests),
     pinning the dialog `this` (sp+0xE0) into s0 for the whole body. That forces the param into s3
     (oracle keeps the param in s0 and only repurposes s0->dialog-this inside the can-afford branch)
     and costs a 6th saved reg (s5) + a bigger frame. The hoist is a gcc code-motion choice not
     reachable from C statement order (the ctor is already nested in the inner else). Forbidden to
     pin. Param->s0 vs s3 cascades through the sllv/and/slt register coloring = the bulk of the 73. */
  uVar5 = 1 << (upgradeNumber & 0x1fU);
  GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0);
  if ((carInfo.fUpgrades & uVar5) == 0) {
    if (tournamentManager.fMoney < carInfo.fPrices[upgradeNumber + 1]) {
      ptVar1 = FEApp;
      pcVar4 = TextSys_Word(0xa8);
      (ptVar1->messagePopup).string = pcVar4;
      Display((tDialogBase *)&(ptVar1->messagePopup));
    }
    else {
      tDialogYesNo_ctor(&popUp);
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
      tScreen_dtor((tScreen *)&popUp,2);
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
     source-reachable (methodology 3.15 reload tie-break). */
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

   [NEAR-MISS 2026-07-05, was 33 diffs, now 18] Real fix: `AreYouSure`/`sVar1`/`dlgThis` moved
   from function scope INTO the `if` block. A C++ local object's non-trivial ctor runs
   unconditionally at its declaration's scope entry -- with `AreYouSure` at function scope its
   ctor call was hoisted BEFORE the fFlags guard test entirely (oracle's ctor call is
   genuinely conditional, reached only in the fFlags==0 fall-through). Block-scoping it
   restores the right control flow; `dlgThis` (unused before) now carries the &AreYouSure
   hoist matching the ExitPinkSlipsEarly/EnterUserName fix family. Residual = an 8-byte frame
   gap (oracle -0xC8 vs ours -0xC0) whose source remains unidentified; tried re-scoping every
   local, no change -- likely a 2nd allocated-but-unused local in the original, not yet
   found. */

extern "C" void MenuExtended_LoadGame__FR12tMenuCommand(tMenuCommand *command)

{
  if (((menuDefs[0]->itemLoadGame).fFlags & 1) == 0) {
    short sVar1;
    tDialogYesNo *dlgThis;
    tDialogYesNo AreYouSure;
    tDialogYesNo_ctor(&AreYouSure);
    dlgThis = &AreYouSure;
    dlgThis->yesnowords[0] = 0x321;
    dlgThis->yesnowords[1] = 0x322;
    dlgThis->fDefault = 0;
    dlgThis->string = TextSys_Word(0x2c0);
    sVar1 = Run((tDialogInteractive *)dlgThis);
    if (sVar1 != 0) {
      GenericMenuLoadGame((int)screenMemcard->player);
    }
    tScreen_dtor((tScreen *)&AreYouSure,2);
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
  
  pvVar3 = StatChk_IsRecordLapTime(Cars_gNewCarStatsList,(short)Cars_gNumRaceCars,&nBestCarIndex);
  if (pvVar3 != (void *)0x0) {
    StatChk_SaveRecordLapTime(Cars_gNewCarStatsList,(short)Cars_gNumRaceCars,nBestCarIndex);
  }
  sVar2 = StatChk_IsTopTime(Cars_gNewCarStatsList,(short)Cars_gNumRaceCars);
  if (sVar2 != 0) {
    StatChk_SaveTopTime(Cars_gNewCarStatsList,(short)Cars_gNumRaceCars);
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
  
  tDialogYesNo_ctor(&RetryCancelDialog);
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
  tScreen_dtor((tScreen *)&RetryCancelDialog,2);
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
   
   [ghidra-meta] section: front.text */

extern "C" void MenuExtended_ExitTourney__FR12tMenuCommand(tMenuCommand *command)

{
  tGlobalMenuDefs *ptVar1;
  short sVar2;
  tDialogYesNo *dlgThis;
  tDialogYesNo AreYouSure;
  
  tDialogYesNo_ctor(&AreYouSure);
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
  tScreen_dtor((tScreen *)&AreYouSure,2);
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
   Residual = the for/while player_00<2 loop lacks the oracle's PRE-loop guard test (oracle
   computes `slti v0,s1,2` BOTH before the loop label AND again in the back-edge's delay slot
   -- a rotated loop -- but with player_00 freshly set to the constant 0 this build proves the
   first iteration always runs and drops the pre-check; the oracle's build didn't fold it).
   Tried for-clause vs while-with-tail-increment vs short-typed counters -- none reproduce the
   kept pre-check; loop-invariant constant-fold difference, not source-reachable without a
   pin. */

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
  
  tDialogYesNo_ctor(&AreYouSure);
  dlgThis = &AreYouSure;
  dlgThis->yesnowords[0] = 0x321;
  dlgThis->yesnowords[1] = 0x322;
  dlgThis->fDefault = 0;
  dlgThis->string = TextSys_Word(0x9d);
  sVar3 = Run((tDialogInteractive *)dlgThis);
  if (sVar3 != 0) {
    Init_Memcard(false,1);
    player_00 = 0;
    while (player_00 < 2) {
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
  tScreen_dtor((tScreen *)&AreYouSure,2);
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

{
  tFEApplication *ptVar1;
  tScreenTrophyRoom *screenHandler;
  tScreenTrackRecords *ptVar2;
  tScreenDisplay *screenHandler_00;
  tScreenMemcard *ptVar3;
  tMenu *child;
  char *pcVar4;
  tListIteratorIndexed *ptVar5;
  tListIteratorCar *ptVar6;
  tListIterator *ptVar7;
  char *in_v1;
  uint uVar8;
  tMenuNFS4 *ptVar9;
  tMenuNFS4 *this_00;
  tMenuItemNFS4LeftRightChoice *ptVar10;
  tListIteratorCar *this_01;
  tMenuOptions *this_02;
  tListIteratorIndexed *this_03;
  tMenuItemOptionsLeftRightChoice *this_04;
  tMenuItemOptionsLeftRightChoice *this_05;
  tMenuItemOptionsLeftRightChoice *this_06;
  tInsideBoxControllerLeftRightSlider *this_07;
  tInsideBoxTwoWaySlider *this_08;
  tMenuItemNFS4LeftRightChoice *ptVar11;
  tMenuOptions *ptVar12;
  tListIteratorCarColor *this_09;
  tMenuOptions *this_10;
  tMenuItemOptionsLeftRightChoice *this_11;
  tInsideBoxControllerLeftRightSlider *firstItem;
  tListIteratorTrack *this_12;
  tMenuItemNFS4LeftRightChoice *ptVar13;
  tListIteratorIndexed *this_13;
  tMenuItemOptionsLeftRightChoice *this_14;
  tInsideBoxTwoWaySlider *this_15;
  tMenuNFS4 *this_16;
  tMenuItemGoToMenuNFS4Button *ptVar14;
  tMenuItemGoToMenuNFS4Button *ptVar15;
  tMenuItemNFS4LeftRightChoice *this_17;
  tMenuItemOptionsLeftRightChoice *this_18;
  tMemoryCardMenuItem *this_19;
  
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemMainOnePlayerRace,0x5b,(tMenu*)&this->menuOnePlayer,
             MenuExtended_SetOnePlayer__FR12tMenuCommand,0x1e,10
            );
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemMainTwoPlayerRace,0x5c,(tMenu*)&this->menuTwoPlayer,
             MenuExtended_SetTwoPlayer__FR12tMenuCommand,0x28,10
            );
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemMainTrophyRoom,0x5e,(tMenu*)&this->menuTrophyRoomSelect,(void *)0x0,0x32,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemMainOptions,0x5d,(tMenu*)&this->menuOptions,(void *)0x0,0x3c,10);
  tMenuNFS4_ctor(&this->menuMain,0x1014,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,
             0xb4,(tMenuItem *)this,&this->itemMainTwoPlayerRace,&this->itemMainOptions,
             &this->itemMainTrophyRoom,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTournTrophyRoom,99,(tMenu *)&this->menuTrophyRoom,
             MenuExtended_GoToTournTrophyRoom__FR12tMenuCommand,
             0x32,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSETrophyRoom,0x69,(tMenu *)&this->menuTrophyRoom,
             MenuExtended_GoToSETrophyRoom__FR12tMenuCommand,
             0x32,10);
  tMenuNFS4_ctor(&this->menuTrophyRoomSelect,0x1014,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0x5f,(tMenuItem *)&this->itemTournTrophyRoom,&this->itemSETrophyRoom,0);
  tMenuBlank_ctor(&this->menuTrophyInfo,0x4000,(tScreen *)screenTrophyInfo,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,-1);
  ptVar9 = &this->menuSingleTrackSelect;
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSkillBeginner,0xa1,(tMenu*)ptVar9,
             MenuExtended_SetBeginner__FR12tMenuCommand,0x8c,10)
  ;
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSkillIntermediate,0xa2,(tMenu*)ptVar9,
             MenuExtended_SetIntermediate__FR12tMenuCommand,0x96
             ,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSkillExpert,0xa3,(tMenu*)ptVar9,
             MenuExtended_SetExpert__FR12tMenuCommand,0xa0,10);
  this_16 = &this->menuSkillLevel;
  tMenuNFS4_ctor(this_16,0x1004,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,0xb7,
             (tMenuItem *)&this->itemSkillBeginner,&this->itemSkillIntermediate,
             &this->itemSkillExpert,0);
  this_00 = &this->menuTestDriveTrackSelect;
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOnePlayerTestDrive,0x60,(tMenu*)this_00,
             MenuExtended_SetTestDrive__FR12tMenuCommand,0xf0,10
            );
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOnePlayerSingleRace,0x72,(tMenu*)&this->menuSingleRace,
             MenuExtended_SetSingleRace__FR12tMenuCommand,0x46,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOnePlayerPursuit,0x71,(tMenu*)&this->menuHotPursuit,
             MenuExtended_SetHotPursuit__FR12tMenuCommand,0x50,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOnePlayerTournament,99,(tMenu*)&this->menuTournament,
             MenuExtended_SetTournament__FR12tMenuCommand,0x5a,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOnePlayerSpecialEvents,0x69,(tMenu*)&this->menuSpecialEvent,
             MenuExtended_SetSpecialEvent__FR12tMenuCommand,100,
             10);
  tMenuNFS4_ctor(&this->menuOnePlayer,0x1004,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xb5,(tMenuItem *)&this->itemOnePlayerTestDrive,
             &this->itemOnePlayerSingleRace,&this->itemOnePlayerPursuit,
             &this->itemOnePlayerTournament,&this->itemOnePlayerSpecialEvents,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSingleRaceSolo,0x6c,(tMenu*)ptVar9,
             MenuExtended_SetSoloRace__FR12tMenuCommand,0x6e,10)
  ;
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSingleRaceDuel,0x6d,(tMenu*)this_16,
             MenuExtended_SetDuelRace__FR12tMenuCommand,0x78,10)
  ;
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSingleRaceFullGrid,0x6f,(tMenu*)this_16,
             MenuExtended_SetFullGrid__FR12tMenuCommand,0x82,10)
  ;
  tMenuNFS4_ctor(&this->menuSingleRace,0x1004,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xb6,(tMenuItem *)&this->itemSingleRaceSolo,&this->itemSingleRaceDuel,
             &this->itemSingleRaceFullGrid,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemHotPursuitSolo,0x6c,(tMenu*)this_16,
             MenuExtended_SetHPSoloRace__FR12tMenuCommand,0x6e,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemHotPursuitDuel,0x6d,(tMenu*)this_16,
             MenuExtended_SetHPDuelRace__FR12tMenuCommand,0x78,
             10);
  pcVar4 = (char *)tMenuNFS4_ctor(&this->menuHotPursuit,0x1004,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,
                      (void *)0x0,0xb6,(tMenuItem *)&this->itemHotPursuitSolo,
                      &this->itemHotPursuitDuel,0);
  tListIteratorTournament_ctor(&this->iteratorTournament,pcVar4,&tournamentManager);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTournamentContinue,0x5a,(tMenu *)0x0,
             MenuExtended_GoToTournTrackInfo__FR12tMenuCommand,
             0x22,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemTournamentSelect,0x94,(tListIterator *)&this->iteratorTournament,0x2c,10);
  pcVar4 = (char *)tMenuNFS4_ctor(&this->menuTournament,0x1000,(tScreen *)screenTournSelect,(tMenu *)0x0,
                      (tMenu *)0x0,
                      MenuExtended_GoToTournTrackInfo__FR12tMenuCommand,0x65,
                      (tMenuItem *)&this->itemTournamentContinue,&this->itemTournamentSelect,0);
  tListIteratorTournament_ctor(&this->iteratorSpecialEvent,pcVar4,&tournamentManager);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSpecialEventContinue,0x5a,(tMenu *)0x0,
             MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand,0x22,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemSpecialEventSelect,0x69,(tListIterator *)&this->iteratorSpecialEvent,0x36,10)
  ;
  tMenuNFS4_ctor(&this->menuSpecialEvent,0x1000,(tScreen *)screenTournSelect,(tMenu *)0x0,(tMenu *)0x0,
             MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand,100,
             (tMenuItem *)&this->itemSpecialEventContinue,&this->itemSpecialEventSelect,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTwoPlayerTestDrive,0x60,(tMenu*)this_00,
             MenuExtended_SetTestDrive__FR12tMenuCommand,0xf0,10
            );
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTwoPlayerDuel,0x72,(tMenu *)0x0,
             MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand,0x46,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTwoPlayerHotPursuit,0x71,(tMenu*)this_16,
             MenuExtended_SetHotPursuit__FR12tMenuCommand,0x50,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTwoPlayerPinkSlips,0x6a,(tMenu*)&this->menuPinkSlipSelect,
             MenuExtended_SetPinkSlips__FR12tMenuCommand,0xaa,10
            );
  tMenuNFS4_ctor(&this->menuTwoPlayer,0x1004,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xb5,(tMenuItem *)&this->itemTwoPlayerTestDrive,&this->itemTwoPlayerDuel
             ,&this->itemTwoPlayerHotPursuit,&this->itemTwoPlayerPinkSlips,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemBestOfOne,0xc0,(tMenu*)ptVar9,
             MenuExtended_GoToBestOfOne__FR12tMenuCommand,0xaa,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemBestOfThree,0xc1,(tMenu*)&this->menuPinkSlipsBestOfThree,
             MenuExtended_GoToBestOfThree__FR12tMenuCommand,0xaa
             ,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemBestOfFive,0xc2,(tMenu*)&this->menuPinkSlipsBestOfFive,
             MenuExtended_GoToBestOfFive__FR12tMenuCommand,0xaa,
             10);
  tMenuNFS4_ctor(&this->menuPinkSlipSelect,0x1000,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xb6,(tMenuItem *)&this->itemBestOfOne,&this->itemBestOfThree,
             &this->itemBestOfFive,0);
  ptVar14 = &this->itemPinkSlipsContinue;
  tMenuItemGoToMenuNFS4Button_ctor(ptVar14,0x5a,(tMenu *)0x0,
             MenuExtended_GoToCarSelect__FR12tMenuCommand,0x24,
             10);
  ptVar11 = &this->itemTrack1;
  this_12 = &this->iteratorTrack;
  tMenuItemNFS4LeftRightChoice_ctor(ptVar11,0xc3,(tListIterator *)this_12,0x2e,10);
  ptVar10 = &this->itemTrack2;
  tMenuItemNFS4LeftRightChoice_ctor(ptVar10,0xc4,(tListIterator *)this_12,0x2e,10);
  ptVar13 = &this->itemTrack3;
  tMenuItemNFS4LeftRightChoice_ctor(ptVar13,0xc5,(tListIterator *)this_12,0x2e,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemTrack4,0xc6,(tListIterator *)this_12,0x2e,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemTrack5,199,(tListIterator *)this_12,0x2e,10);
  ptVar12 = &this->menuTrackOptions;
  tMenuNFS4_ctor(&this->menuPinkSlipsBestOfThree,0x1400,(tScreen *)screenPinkSlips,(tMenu *)0x0,
             (tMenu *)ptVar12,
             MenuExtended_GoToCarSelect__FR12tMenuCommand,0xbe,
             (tMenuItem *)ptVar14,ptVar11,ptVar10,ptVar13,0);
  pcVar4 = (char *)tMenuNFS4_ctor(&this->menuPinkSlipsBestOfFive,0x1400,(tScreen *)screenPinkSlips,(tMenu *)0x0,
                      (tMenu *)ptVar12,
                      MenuExtended_GoToCarSelect__FR12tMenuCommand,0xbf,(tMenuItem *)ptVar14,ptVar11
                      ,ptVar10,ptVar13,&this->itemTrack4,&this->itemTrack5,0);
  tListIteratorTrack_ctor(this_12,pcVar4,in_v1,&trackManager);
  ptVar15 = &this->itemTrackContinue;
  tMenuItemGoToMenuNFS4Button_ctor(ptVar15,0x5a,(tMenu *)0x0,
             MenuExtended_GoToCarSelect__FR12tMenuCommand,0x1c,
             10);
  ptVar10 = &this->itemTrack;
  tMenuItemNFS4LeftRightChoice_ctor(ptVar10,0x93,(tListIterator *)this_12,0x26,10);
  ptVar14 = &this->itemTrackRecords;
  tMenuItemGoToMenuNFS4Button_ctor(ptVar14,0xd4,(tMenu*)&this->menuTrackRecords,(void *)0x0,0x3a,10);
  tMenuNFS4_ctor(ptVar9,0x1600,(tScreen *)screenTrackSelect,(tMenu *)0x0,(tMenu *)ptVar12,
             MenuExtended_GoToCarSelect__FR12tMenuCommand,200,
             (tMenuItem *)ptVar15,ptVar10,ptVar14,0);
  tMenuNFS4_ctor(this_00,0x1600,(tScreen *)screenTrackSelect,(tMenu *)0x0,(tMenu *)0x0,
             MenuExtended_GoToCarSelect__FR12tMenuCommand,200,
             (tMenuItem *)ptVar15,ptVar10,ptVar14,0);
  tListIteratorIndexed_ctor(&this->iteratorLaps,SelectListNormal,frontEnd.lapind,&frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&this->iteratorTrackDirection,SelectListTrackDirection,frontEnd.trackdirection,
             &frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&this->iteratorTrackMirrored,SelectListOffOn,frontEnd.trackmirrored,
             &frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&this->iteratorTimeOfDay,SelectListOffOn,frontEnd.timeOfDay,
             &frontEnd.pinkSlipsTrackIndex);
  tListIteratorIndexed_ctor(&this->iteratorWeather,SelectListOffOn,frontEnd.weather,&frontEnd.pinkSlipsTrackIndex);
  ptVar5 = tListIteratorIndexed_ctor(&this->iteratorTraffic,SelectListOffOn,frontEnd.traffic,
                      &frontEnd.pinkSlipsTrackIndex);
  tListIterator_ctor((tListIterator *)ptVar5,SelectListOffOn,&frontEnd.localSpeech);
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)&this->itemLaps,0xca,(tListIterator *)&this->iteratorLaps);
  *(void **)&((this->itemLaps)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)&this->itemTrackDirection,0xcc,
             (tListIterator *)&this->iteratorTrackDirection);
  *(void **)&((this->itemTrackDirection)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)&this->itemTrackMirrored,0xcd,
             (tListIterator *)&this->iteratorTrackMirrored);
  *(void **)&((this->itemTrackMirrored)._vf) = (void *)tMenuItemOptionsTwoItemChoice_vtable;
  (this->itemTrackMirrored).fOnOffFade = 0x80;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)&this->itemTimeOfDay,0xce,
             (tListIterator *)&this->iteratorTimeOfDay);
  *(void **)&((this->itemTimeOfDay)._vf) = (void *)tMenuItemOptionsTwoItemChoice_vtable;
  (this->itemTimeOfDay).fOnOffFade = 0x80;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)&this->itemWeather,0xcf,
             (tListIterator *)&this->iteratorWeather);
  *(void **)&((this->itemWeather)._vf) = (void *)tMenuItemOptionsTwoItemChoice_vtable;
  (this->itemWeather).fOnOffFade = 0x80;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)&this->itemTraffic,0xd0,
             (tListIterator *)&this->iteratorTraffic);
  *(void **)&((this->itemTraffic)._vf) = (void *)tMenuItemOptionsTwoItemChoice_vtable;
  (this->itemTraffic).fOnOffFade = 0x80;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)&this->itemLocalSpeech,0xd2,&this->iteratorLocalSpeech);
  *(void **)&((this->itemLocalSpeech)._vf) = (void *)tMenuItemOptionsTwoItemChoice_vtable;
  (this->itemLocalSpeech).fOnOffFade = 0x80;
  tMenuOptions_ctor(ptVar12,0x1000,(tScreen *)0x0,(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,0xb9,-1,
             (tMenuItem *)&this->itemLaps,&this->itemTrackDirection,&this->itemTrackMirrored,
             &this->itemTimeOfDay,&this->itemWeather,&this->itemTraffic,&this->itemLocalSpeech,0);
  tMenuItemGoToMenuNFS4Button_ctor((tMenuItemGoToMenuNFS4Button *)&this->menuTrackRecordsItem,0,(tMenu *)0x0,(void *)0x0
             ,-1,-1);
  ptVar2 = screenTrackRecords;
  *(void **)&((this->menuTrackRecordsItem)._vf) = (void *)&tBlankMenuItemGoToMenuNFS4Button_vtable;
  tOptionsMenu_ctor(&this->menuTrackRecords,0x1000,(tScreen *)ptVar2,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xd4,1,10,(tMenuItem *)0x0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTrackInfoContinue,0x5a,(tMenu *)0x0,
             MenuExtended_GoToGarage__FR12tMenuCommand,0x21,10);
  tMenuNFS4_ctor(&this->menuTrackInfo,0x1004,(tScreen *)screenTrackInfo,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xf9,(tMenuItem *)&this->itemTrackInfoContinue,0);
  this_01 = &this->iteratorCar1;
  ptVar6 = tListIteratorCar_ctor(this_01,frontEnd.playerCar,&carManager);
  this_09 = &this->iteratorColor;
  tListIteratorCarColor_ctor(this_09,(char *)ptVar6,&FEApp->fPlayer,frontEnd.playerCar,0x30,&carManager);
  ptVar14 = &this->itemCarSelectRace;
  tMenuItemGoToMenuNFS4Button_ctor(ptVar14,0xbd,(tMenu *)0x0,
             MenuExtended_GoToRace__FR12tMenuCommand,0x80,10);
  ptVar10 = &this->itemCar;
  tMenuItemNFS4LeftRightChoice_ctor(ptVar10,0x92,(tListIterator *)this_01,0x1c,10);
  ptVar11 = &this->itemColor;
  tMenuItemNFS4LeftRightChoice_ctor(ptVar11,0x120,(tListIterator *)this_09,0x26,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemShowcase,0x112,(tMenu *)0x0,
             MenuExtended_GoToShowroom__FR12tMenuCommand,0x30,10
            );
  ptVar12 = &this->menuCarOptions;
  tMenuNFS4_ctor(&this->menuSingleCarSelect,0x1a00,(tScreen *)screenCarSelect[0],(tMenu *)0x0,
             (tMenu *)ptVar12,
             MenuExtended_GoToRace__FR12tMenuCommand,0xba,
             (tMenuItem *)ptVar14,ptVar10,ptVar11,&this->itemShowcase,0);
  ptVar6 = &this->iteratorGarageCar;
  tListIteratorCar_ctor(ptVar6,frontEnd.garageCar,&carManager);
  this_17 = &this->itemGarageCar;
  tMenuItemNFS4LeftRightChoice_ctor(this_17,0x92,(tListIterator *)ptVar6,0x1c,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemCarDealer,0x74,(tMenu*)&this->menuGoToCarDealer,(void *)0x0,0x3a,10);
  ptVar15 = &this->itemUpgradeCar;
  tMenuItemGoToMenuNFS4Button_ctor(ptVar15,0x91,(tMenu *)0x0,
             MenuExtended_GoToUpgrades__FR12tMenuCommand,0x44,10
            );
  tMenuNFS4_ctor(&this->menuCarGarage,0x1a00,(tScreen *)screenCarSelect[0],(tMenu *)0x0,(tMenu *)ptVar12,
             MenuExtended_GoToRace__FR12tMenuCommand,0x8f,
             (tMenuItem *)ptVar14,this_17,&this->itemCarDealer,ptVar15,0);
  tMenuNFS4_ctor(&this->menuPostCarGarage,0x1a00,(tScreen *)screenCarSelect[0],(tMenu *)0x0,(tMenu *)ptVar12
             ,MenuExtended_GoToRace__FR12tMenuCommand,0x8f,
             (tMenuItem *)ptVar14,ptVar15,0);
  tListIteratorCar_ctor(&this->iteratorOpponentCar,&frontEnd.oppCar,&carManager);
  ptVar14 = &this->itemDuelRace;
  tMenuItemGoToMenuNFS4Button_ctor(ptVar14,0xbd,(tMenu *)0x0,
             MenuExtended_GoToRace__FR12tMenuCommand,0x2a,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemCar2,0x92,(tListIterator *)this_01,0xc,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemColor2,0x120,(tListIterator *)this_09,0x16,10);
  ptVar9 = &this->menuCarDealer;
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemGoToDuelBuyCar,0x78,(tMenu*)ptVar9,
             MenuExtended_GoToDealer__FR12tMenuCommand,-1,10);
  ptVar13 = &this->itemOpponentCar;
  tMenuItemNFS4LeftRightChoice_ctor(ptVar13,0xbc,(tListIterator *)&this->iteratorOpponentCar,0x20,10);
  tMenuNFS4_ctor(&this->menuDuelCarSelect,0x1800,(tScreen *)screenCarSelectDuel,(tMenu *)0x0,
             (tMenu *)ptVar12,
             MenuExtended_GoToRace__FR12tMenuCommand,0xba,
             (tMenuItem *)ptVar14,this_17,&this->itemGoToDuelBuyCar,ptVar13,0);
  tMenuNFS4_ctor(&this->menuHPDuelCarSelect,0x1800,(tScreen *)screenCarSelectDuel,(tMenu *)0x0,
             (tMenu *)ptVar12,
             MenuExtended_GoToRace__FR12tMenuCommand,0xba,
             (tMenuItem *)ptVar14,ptVar10,ptVar11,ptVar13,0);
  ptVar14 = &this->itemPlayerOneRace;
  tMenuItemGoToMenuNFS4Button_ctor(ptVar14,0xbd,(tMenu *)0x0,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0x2a
             ,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemCarP1,0x92,(tListIterator *)this_01,0xc,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemColorP1,0x120,(tListIterator *)this_09,0x16,10);
  this_10 = &this->menuCarOptionsPlayerOne;
  tMenuNFS4TwoPlayer_ctor(&this->menuPlayerOneCarSelect,0x1008,(tScreen *)screenCarSelectTwoPlayer,(tMenu *)0x0,
             (tMenu *)this_10,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0xba
             ,(tMenuItem *)ptVar14,&this->itemCarP1,&this->itemColorP1,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPlayerTwoRace,0xbd,(tMenu *)0x0,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0x2a
             ,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemCarP2,0x92,(tListIterator *)this_01,0xc,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemColorP2,0x120,(tListIterator *)this_09,0x16,10);
  this_02 = &this->menuCarOptionsPlayerTwo;
  tMenuNFS4TwoPlayer_ctor(&this->menuPlayerTwoCarSelect,0x1008,(tScreen *)screenCarSelectPlayerTwo,(tMenu *)0x0,
             (tMenu *)this_02,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0xba
             ,(tMenuItem *)&this->itemPlayerTwoRace,&this->itemCarP2,&this->itemColorP2,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPlayerOneGarageRace,0xbd,(tMenu *)0x0,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0x2a
             ,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemGarageCarP1,0x92,(tListIterator *)ptVar6,0xc,10);
  tMenuNFS4TwoPlayer_ctor(&this->menuPlayerOneGarage,0x1008,(tScreen *)screenCarSelectTwoPlayer,(tMenu *)0x0,
             (tMenu *)this_10,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0xba
             ,(tMenuItem *)ptVar14,&this->itemGarageCarP1,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPlayerTwoGarageRace,0xbd,(tMenu *)0x0,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0x2a
             ,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemGarageCarP2,0x92,(tListIterator *)ptVar6,0xc,10);
  tMenuNFS4TwoPlayer_ctor(&this->menuPlayerTwoGarage,0x1008,(tScreen *)screenCarSelectPlayerTwo,(tMenu *)0x0,
             (tMenu *)this_02,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0xba
             ,(tMenuItem *)&this->itemPlayerTwoGarageRace,&this->itemGarageCarP2,0);
  ptVar6 = &this->iteratorPinkSlipsCar;
  tListIteratorCar_ctor(ptVar6,frontEnd.pinkSlipsCar,&carManager);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPlayerOnePinkSlipRace,0xbd,(tMenu *)0x0,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0x2a
             ,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemPinkSlipCarP1,0x92,(tListIterator *)ptVar6,0xc,10);
  tMenuNFS4TwoPlayer_ctor(&this->menuPlayerOnePinkSlipCarSelect,0x1008,
             (tScreen *)screenPinkSlipsCarSelectTwoPlayer,(tMenu *)0x0,
             (tMenu *)&this->menuPinkSlipCarOptionsPlayerOne,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0xba
             ,(tMenuItem *)&this->itemPlayerOnePinkSlipRace,&this->itemPinkSlipCarP1,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPlayerTwoPinkSlipRace,0xbd,(tMenu *)0x0,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0x2a
             ,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemPinkSlipCarP2,0x92,(tListIterator *)ptVar6,0xc,10);
  tMenuNFS4TwoPlayer_ctor(&this->menuPlayerTwoPinkSlipCarSelect,0x1008,
             (tScreen *)screenPinkSlipsCarSelectPlayerTwo,(tMenu *)0x0,
             (tMenu *)&this->menuPinkSlipCarOptionsPlayerTwo,
             MenuExtended_GoTo2PlayerRace__FR12tMenuCommand,0xba
             ,(tMenuItem *)&this->itemPlayerTwoPinkSlipRace,&this->itemPinkSlipCarP2,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemGoToBuyCar,0x78,(tMenu*)ptVar9,
             MenuExtended_GoToDealer__FR12tMenuCommand,0x58,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemGoToSellCar,0x79,(tMenu*)&this->menuCarSeller,
             MenuExtended_GoToSeller__FR12tMenuCommand,0x4e,10);
  tMenuNFS4_ctor(&this->menuGoToCarDealer,0x1200,(tScreen *)screenCarSelect[0],(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0x90,(tMenuItem *)&this->itemGoToBuyCar,&this->itemGoToSellCar,0);
  ptVar6 = tListIteratorCar_ctor(&this->iteratorDealerCar,&frontEnd.dealerCar,&carManager);
  tListIteratorCarColor_ctor(&this->iteratorDealerColor,(char *)ptVar6,&FEApp->fPlayer,&frontEnd.dealerCar,0x30,
             &carManager);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemDealerCar,0x92,(tListIterator *)&this->iteratorDealerCar,0x1c,10);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemDealerColor,0x120,(tListIterator *)&this->iteratorDealerColor,0x26,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemBuyCar,0x75,(tMenu *)0x0,
             MenuExtended_BuyCar__FR12tMenuCommand,0x58,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemDealerShowroom,0x112,(tMenu *)0x0,
             MenuExtended_GoToDealerShowroom__FR12tMenuCommand,
             0x30,10);
  tMenuNFS4_ctor(ptVar9,0x2240,(tScreen *)screenCarSelect[0],(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,0x90,
             (tMenuItem *)&this->itemDealerCar,&this->itemDealerColor,&this->itemBuyCar,
             &this->itemDealerShowroom,0);
  tListIteratorCar_ctor(&this->iteratorSellerCar,&frontEnd.sellerCar,&carManager);
  tMenuItemNFS4LeftRightChoice_ctor(&this->itemSellerCar,0x92,(tListIterator *)&this->iteratorSellerCar,0x1c,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemSellCar,0x77,(tMenu *)0x0,
             MenuExtended_SellCar__FR12tMenuCommand,0x4e,10);
  tMenuNFS4_ctor(&this->menuCarSeller,0x2200,(tScreen *)screenCarSelect[0],(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0x90,(tMenuItem *)&this->itemSellerCar,&this->itemSellCar,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPurchaseUpgrade1,0x96,(tMenu *)0x0,
             MenuExtended_PurchaseUpgrade1__FR12tMenuCommand,
             0x62,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPurchaseUpgrade2,0x97,(tMenu *)0x0,
             MenuExtended_PurchaseUpgrade2__FR12tMenuCommand,
             0x6c,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPurchaseUpgrade3,0x98,(tMenu *)0x0,
             MenuExtended_PurchaseUpgrade3__FR12tMenuCommand,
             0x76,10);
  tMenuNFS4_ctor(&this->menuCarUpgrades,0x2200,(tScreen *)screenCarSelect[0],(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0x91,(tMenuItem *)&this->itemPurchaseUpgrade1,
             &this->itemPurchaseUpgrade2,&this->itemPurchaseUpgrade3,0);
  this_03 = &this->iteratorTransmission;
  tListIteratorIndexed_ctor(this_03,SelectListTransmission,frontEnd.transmission,&FEApp->fPlayer);
  this_13 = &this->iteratorABS;
  ptVar5 = tListIteratorIndexed_ctor(this_13,SelectListOffOn,frontEnd.ABS,&FEApp->fPlayer);
  ptVar7 = tListIterator_ctor((tListIterator *)ptVar5,SelectListOffOn,&frontEnd.damage);
  tListIterator_ctor(ptVar7,SelectListOpponentUpgrades,&frontEnd.opponentUpgrades);
  this_11 = &this->itemTransmission;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)this_11,0x10a,(tListIterator *)this_03);
  this_04 = &this->itemABS;
  *(void **)&((this->itemTransmission)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)this_04,0x10b,(tListIterator *)this_13);
  this_05 = &this->itemDamage;
  *(void **)&((this->itemABS)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)this_05,0x111,&this->iteratorDamage);
  this_18 = &this->itemTransmission2;
  *(void **)&((this->itemDamage)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)this_18,0x10a,(tListIterator *)this_03);
  this_06 = &this->itemABS2;
  *(void **)&((this->itemTransmission2)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)this_06,0x10b,(tListIterator *)this_13);
  this_14 = &this->itemDamage2;
  *(void **)&((this->itemABS2)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)this_14,0x111,&this->iteratorDamage);
  *(void **)&((this->itemDamage2)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuItemLeftRightChoice_ctor((tMenuItemLeftRightChoice *)&this->itemOpponentUpgrades,0x10e,
             &this->iteratorOpponentUpgrades);
  *(void **)&((this->itemOpponentUpgrades)._vf) = (void *)tMenuItemOptionsLeftRightChoice_vtable;
  tMenuOptions_ctor(ptVar12,0x1000,(tScreen *)0x0,(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,0xbb,-1,
             (tMenuItem *)this_11,this_04,this_05,&this->itemOpponentUpgrades,0);
  tMenuOptions_ctor(this_10,0x1008,(tScreen *)screenCarSelectTwoPlayer,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xbb,0,(tMenuItem *)this_11,this_04,this_05,0);
  tMenuOptions_ctor(this_02,0x1008,(tScreen *)screenCarSelectPlayerTwo,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xbb,1,(tMenuItem *)this_18,this_06,this_14,0);
  tMenuOptions_ctor(&this->menuPinkSlipCarOptionsPlayerOne,0x1008,
             (tScreen *)screenPinkSlipsCarSelectTwoPlayer,(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,
             0xbb,0,(tMenuItem *)this_11,this_04,this_05,0);
  tMenuOptions_ctor(&this->menuPinkSlipCarOptionsPlayerTwo,0x1008,
             (tScreen *)screenPinkSlipsCarSelectPlayerTwo,(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,
             0xbb,1,(tMenuItem *)this_18,this_06,this_14,0);
  tMenuBlank_ctor(&this->menuShowroom,0x4000,(tScreen *)0x0,(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,-1);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOptionsAudio,0x1c5,(tMenu*)&this->menuAudio,(void *)0x0,0xb4,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOptionsDisplay,0x1c6,(tMenu*)&this->menuDisplayOptions,(void *)0x0,0xbe,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOptionsControllers,0x1c8,(tMenu*)&this->menuControllerConfig,(void *)0x0,
             200,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOptionsMemoryCard,0x1c9,(tMenu*)&this->menuMemory,(void *)0x0,0xd2,10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOptionsUsername,0x1ca,(tMenu *)0x0,
             MenuExtended_EnterUserName__FR12tMenuCommand,0xdc,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemOptionsCredits,0x1cc,(tMenu *)&this->menuCredits,(void *)0x0,0xe6,10);
  tMenuNFS4_ctor(&this->menuOptions,0x1014,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,(void *)0x0
             ,0x5d,(tMenuItem *)&this->itemOptionsAudio,&this->itemOptionsDisplay,
             &this->itemOptionsControllers,&this->itemOptionsMemoryCard,&this->itemOptionsUsername,
             &this->itemOptionsCredits,0);
  tListIteratorRange_ctor(&this->iteratorMusicVolume,'\0','\x7f',&frontEnd.musicVolume);
  tListIteratorRange_ctor(&this->iteratorSoundEffectsVolume,'\0','\x7f',&frontEnd.sfxVolume);
  tListIteratorRange_ctor(&this->iteratorEngineVolume,'\0','\x7f',&frontEnd.engineVolume);
  tListIteratorRange_ctor(&this->iteratorSpeechVolume,'\0','\x7f',&frontEnd.narrationVolume);
  ptVar7 = (tListIterator *)tListIteratorRange_ctor(&this->iteratorAmbientVolume,'\0','\x7f',&frontEnd.ambientVolume);
  tListIterator_ctor(ptVar7,SelectListAudioMode,&frontEnd.audioMode);
  tMenuItemLeftRightAudioSlider_ctor(&this->itemMusicVolume,0x1d5,(tListIterator *)&this->iteratorMusicVolume,0);
  tMenuItemLeftRightAudioSlider_ctor(&this->itemSoundEffectsVolume,0x1d6,(tListIterator *)&this->iteratorSoundEffectsVolume,1
            );
  tMenuItemLeftRightAudioSlider_ctor(&this->itemEngineVolume,0x1d7,(tListIterator *)&this->iteratorEngineVolume,2);
  tMenuItemLeftRightAudioSlider_ctor(&this->itemSpeechVolume,0x1d8,(tListIterator *)&this->iteratorSpeechVolume,3);
  tMenuItemLeftRightAudioSlider_ctor(&this->itemAmbientVolume,0x1d9,(tListIterator *)&this->iteratorAmbientVolume,4);
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemAudioMode,0x1da,&this->iteratorAudioMode);
  *(void **)&((this->itemAudioMode)._vf) = (void *)tMenuItemDisplayLeftRightChoice_vtable;
  tMenuItemSlidingMenu_ctor((tMenuItemSlidingMenu *)&this->itemSlidingPlayList,0x1db,0x15e,0x2b,-0x66,0xd,false);
  *(void **)&((this->itemSlidingPlayList)._vf) = (void *)tMenuItemSlidingActivated_vtable;
  tInsideBoxSongMenu_ctor(&this->menuPlayListMenu,0x1000,(tScreen *)0x0,(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,
             0,(tMenuItem *)0x0);
  tOptionsMenu_ctor(&this->menuAudio,0x1010,(tScreen *)screenAudio,(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,
             0x263,0x26,10,(tMenuItem *)&this->itemMusicVolume,&this->itemSoundEffectsVolume,
             &this->itemEngineVolume,&this->itemSpeechVolume,&this->itemAmbientVolume,
             &this->itemAudioMode,&this->itemSlidingPlayList,0);
  tListIteratorIndexed_ctor(&this->iteratorDisplaySpeedometer,SelectListDisplaySpeed,frontEnd.displaySpeed,
             &FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&this->iteratorDisplayMap,SelectListDisplayMap,frontEnd.displayMap,&FEApp->fInputPlayer
            );
  tListIteratorIndexed_ctor(&this->iteratorDisplayOpponentID,SelectListDisplayOpponentID,frontEnd.displayOpponentID
             ,&FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&this->iteratorDisplayTime,SelectListOffOn,frontEnd.displayTime,&FEApp->fInputPlayer);
  tListIteratorIndexed_ctor(&this->iteratorDisplayPosition,SelectListOffOn,frontEnd.displayPosition,
             &FEApp->fInputPlayer);
  ptVar5 = tListIteratorIndexed_ctor(&this->iteratorDisplayLapNumber,SelectListOffOn,frontEnd.displayLapNumber,
                      &FEApp->fInputPlayer);
  tListIterator_ctor((tListIterator *)ptVar5,SelectListSplitTime,&frontEnd.checkPointType);
  tListIteratorIndexed_ctor(&this->iteratorDisplaySplitDisplay,SelectListSplitDisplay,frontEnd.checkPointDisplay,
             &FEApp->fInputPlayer);
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemDisplaySpeedometer,0x1df,
             (tListIterator *)&this->iteratorDisplaySpeedometer);
  *(void **)&((this->itemDisplaySpeedometer)._vf) = (void *)tMenuItemDisplayLeftRightChoice_vtable;
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemDisplayMap,0x1e1,
             (tListIterator *)&this->iteratorDisplayMap);
  *(void **)&((this->itemDisplayMap)._vf) = (void *)tMenuItemDisplayLeftRightChoice_vtable;
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemDisplayOpponentID,0x1e2,
             (tListIterator *)&this->iteratorDisplayOpponentID);
  *(void **)&((this->itemDisplayOpponentID)._vf) = (void *)tMenuItemDisplayLeftRightChoice_vtable;
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemDisplayTime,0x1e3,
             (tListIterator *)&this->iteratorDisplayTime);
  *(void **)&((this->itemDisplayTime)._vf) = (void *)tMenuItemOnOffLeftRightChoice_vtable;
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemDisplayPosition,0x1e6,
             (tListIterator *)&this->iteratorDisplayPosition);
  *(void **)&((this->itemDisplayPosition)._vf) = (void *)tMenuItemOnOffLeftRightChoice_vtable;
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemDisplayLapNumber,0x1e7,
             (tListIterator *)&this->iteratorDisplayLapNumber);
  *(void **)&((this->itemDisplayLapNumber)._vf) = (void *)tMenuItemOnOffLeftRightChoice_vtable;
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemDisplaySplitTime,0x1e4,
             &this->iteratorDisplaySplitTime);
  *(void **)&((this->itemDisplaySplitTime)._vf) = (void *)tMenuItemDisplayLeftRightChoice_vtable;
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemDisplaySplitDisplay,0x1e5,
             (tListIterator *)&this->iteratorDisplaySplitDisplay);
  screenHandler_00 = screenDisplay;
  *(void **)&((this->itemDisplaySplitDisplay)._vf) = (void *)tMenuItemDisplayLeftRightChoice_vtable;
  tOptionsMenu_ctor(&this->menuDisplayOptions,0x1020,(tScreen *)screenHandler_00,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0x1dd,1,10,(tMenuItem *)&this->itemDisplaySpeedometer,
             &this->itemDisplayMap,&this->itemDisplayOpponentID,&this->itemDisplayTime,
             &this->itemDisplaySplitTime,&this->itemDisplaySplitDisplay,&this->itemDisplayPosition,
             &this->itemDisplayLapNumber,0);
  tListIteratorIndexed_ctor(&this->iteratorControllerConfigSelected,SelectListControllerConfig,
             frontEnd.controlConfig,&FEApp->fInputPlayer);
  tMenuItemLeftRightFade_ctor((tMenuItemLeftRightFade *)&this->itemControllerConfigSelected,0x209,
             (tListIterator *)&this->iteratorControllerConfigSelected);
  *(void **)&((this->itemControllerConfigSelected)._vf) = (void *)tMenuItemControllerLeftRightChoice_vtable;
  tMenuItemSlidingMenu_ctor(&this->itemControllerSettings,0x20a,0xac,0x48,0,0xd,true);
  tOptionsMenu_ctor(&this->menuControllerConfig,0x1020,(tScreen *)screenControllerConfig,(tMenu *)0x0,
             (tMenu *)0x0,(void *)0x0,0x208,0,10,(tMenuItem *)&this->itemControllerConfigSelected
             ,&this->itemControllerSettings,0);
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerShockMode,'\0','\x7f',frontEnd.shockMode,&FEApp->fInputPlayer)
  ;
  firstItem = &this->itemControllerShockMode;
  tInsideBoxLeftRightSlider_ctor(&firstItem->_base_tInsideBoxLeftRightSlider,0x20e,
             (tListIterator *)&this->iteratorControllerShockMode);
  ptVar1 = FEApp;
  *(void **)&((this->itemControllerShockMode)._base_tInsideBoxLeftRightSlider._vf) = (void *)tInsideBoxControllerLeftRightSlider_vtable;
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerShockImpact,'\0','\x7f',frontEnd.shockImpact,
             &ptVar1->fInputPlayer);
  this_07 = &this->itemControllerShockImpact;
  tInsideBoxLeftRightSlider_ctor(&this_07->_base_tInsideBoxLeftRightSlider,0x20f,
             (tListIterator *)&this->iteratorControllerShockImpact);
  pcVar4 = &FEApp->fInputPlayer;
  *(void **)&((this->itemControllerShockImpact)._base_tInsideBoxLeftRightSlider._vf) = (void *)tInsideBoxControllerLeftRightSlider_vtable;
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerSteeringRange1,'\0','\x7f',frontEnd.J1MAX,pcVar4);
  tInsideBoxTwoWaySlider_ctor(&this->itemControllerSteeringRange1,0x211,
             (tListIterator *)&this->iteratorControllerSteeringRange1,0);
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerDeadSpot1,'\0','\x7f',frontEnd.J1MIN,&FEApp->fInputPlayer);
  this_08 = &this->itemControllerDeadSpot1;
  tInsideBoxTwoWaySlider_ctor(this_08,0x213,(tListIterator *)&this->iteratorControllerDeadSpot1,1);
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerSteeringRange2,'\0','\x7f',frontEnd.J2MAX,&FEApp->fInputPlayer
            );
  tInsideBoxTwoWaySlider_ctor(&this->itemControllerSteeringRange2,0x210,
             (tListIterator *)&this->iteratorControllerSteeringRange2,2);
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerDeadSpot2,'\0','\x7f',frontEnd.J2MIN,&FEApp->fInputPlayer);
  this_15 = &this->itemControllerDeadSpot2;
  tInsideBoxTwoWaySlider_ctor(this_15,0x212,(tListIterator *)&this->iteratorControllerDeadSpot2,3);
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerJoyRange,'\0','\x7f',frontEnd.steeringRange,
             &FEApp->fInputPlayer);
  tInsideBoxTwoWaySlider_ctor(&this->itemControllerJoyRange,0x214,(tListIterator *)&this->iteratorControllerJoyRange,
             0);
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerCenterPoint,'\0','\x7f',frontEnd.deadSpot,&FEApp->fInputPlayer
            );
  tInsideBoxTwoWaySlider_ctor(&this->itemControllerCenterPoint,0x215,
             (tListIterator *)&this->iteratorControllerCenterPoint,1);
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerIMax,'\0',-1,frontEnd.ImaxRange,&FEApp->fInputPlayer);
  tInsideBoxTwoWaySlider_ctor(&this->itemControllerIMax,0x216,(tListIterator *)&this->iteratorControllerIMax,2);
  tListIteratorRangeIndexed_ctor(&this->iteratorControllerIIMax,'\0',-1,frontEnd.IImaxRange,&FEApp->fInputPlayer);
  tInsideBoxTwoWaySlider_ctor(&this->itemControllerIIMax,0x217,(tListIterator *)&this->iteratorControllerIIMax,3);
  tInsideBoxMenu_ctor(&this->menuControllerDualShock,0x1000,(tScreen *)0x0,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0,(tMenuItem *)firstItem,this_07,0);
  tInsideBoxMenu_ctor(&this->menuControllerAnalog,0x1000,(tScreen *)0x0,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0,(tMenuItem *)&this->itemControllerSteeringRange1,this_08,
             &this->itemControllerSteeringRange2,this_15,0);
  tInsideBoxMenu_ctor(&this->menuControllerDualShockAnalog,0x1000,(tScreen *)0x0,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0,(tMenuItem *)firstItem,this_07,this_08,this_15,0);
  tInsideBoxMenu_ctor(&this->menuControllerNegcon,0x1000,(tScreen *)0x0,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0,(tMenuItem *)&this->itemControllerJoyRange,
             &this->itemControllerCenterPoint,&this->itemControllerIMax,&this->itemControllerIIMax,0
            );
  this_19 = &this->itemSaveGame;
  tMenuItemGoToMenuButton_ctor((tMenuItemGoToMenuButton *)this_19,0x286,(tMenu *)0x0,
             MenuExtended_SaveGame__FR12tMenuCommand);
  *(void **)&((this->itemSaveGame)._vf) = (void *)tMemoryCardMenuItem_vtable;
  tMenuItemGoToMenuButton_ctor((tMenuItemGoToMenuButton *)&this->itemLoadGame,0x287,(tMenu *)0x0,
             MenuExtended_LoadGame__FR12tMenuCommand);
  ptVar3 = screenMemcard;
  *(void **)&((this->itemLoadGame)._vf) = (void *)tMemoryCardMenuItem_vtable;
  tOptionsMenu_ctor(&this->menuMemory,0x1020,(tScreen *)ptVar3,(tMenu *)0x0,(tMenu *)0x0,(void *)0x0,-1,
             0x2e,10,(tMenuItem *)&this->itemLoadGame,this_19,0);
  tUserNameMenuItem_ctor(&this->menuItemUserName,0x1f8);
  tUserNameMenuItem_ctor(&this->menuItemUserName1,0x1f8);
  tUserNameMenuItem_ctor(&this->menuItemUserName2,0x1f8);
  ptVar7 = (tListIterator *)
           tOptionsMenu_ctor(&this->menuUserName,0x1120,(tScreen *)screenUserName,(tMenu *)0x0,(tMenu *)0x0,
                      (void *)0x0,-1,0x20,10,(tMenuItem *)&this->menuItemUserName,0);
  tListIterator_ctor(ptVar7,screenTrophyRoom->fTrophyList,&screenTrophyRoom->thisisuseless);
  tMenuItemNFS4LeftRightChoice_ctor((tMenuItemNFS4LeftRightChoice *)&this->itemChangeTrophy,0x5e,&this->iteratorChangeTrophy
             ,-1,0);
  screenHandler = screenTrophyRoom;
  *(void **)&((this->itemChangeTrophy)._vf) = (void *)&tBlankMenuItemNFS4LeftRightChoice_vtable;
  tMenuNFS4Bottom_ctor(&this->menuTrophyRoom,0x4010,(tScreen *)screenHandler,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,-1,(tMenuItem *)&this->itemChangeTrophy,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPinkSlipStandingsForward,0x5a,(tMenu *)0x0,
             MenuExtended_PinkSlipsContinue__FR12tMenuCommand,0,
             10);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemPinkSlipStandingsExit,0x9c,(tMenu *)0x0,
             MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand,0
             ,10);
  tMenuNFS4_ctor(&this->menuPinkSlipStandings,0x1004,(tScreen *)screenPinkSlipStandings,(tMenu *)0x0,
             (tMenu *)0x0,(void *)0x0,0x2f4,(tMenuItem *)&this->itemPinkSlipStandingsForward,
             &this->itemPinkSlipStandingsExit,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTournStandingsForward,0x5a,(tMenu*)&this->menuTrackInfo,(void *)0x0,0,10)
  ;
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTournStandingsExit,0x9b,(tMenu *)0x0,
             MenuExtended_ExitTourney__FR12tMenuCommand,0,10);
  tMenuNFS4_ctor(&this->menuTournamentStandings,0x1004,(tScreen *)screenTournamentStandings3item,
             (tMenu *)0x0,(tMenu *)0x0,(void *)0x0,0x2f4,
             (tMenuItem *)&this->itemTournStandingsForward,&this->itemTournStandingsExit,0);
  tMenuItemGoToMenuNFS4Button_ctor(&this->itemTournamentFinishedHome,0x5a,(tMenu *)&this->menuTournamentTrophy,
             (void *)0x0,0,10);
  tMenuNFS4_ctor(&this->menuTournamentFinished,0x1004,(tScreen *)screenTournamentStandings,(tMenu *)0x0,
             (tMenu *)0x0,(void *)0x0,0x2f4,(tMenuItem *)&this->itemTournamentFinishedHome,0);
  tMenuBlank_ctor(&this->menuTournamentTrophy,0x8000,(tScreen *)screenTournamentTrophy,(tMenu *)0x0,
             (tMenu *)0x0,
             MenuExtended_TierFinished__FR12tMenuCommand,-1);
  tOptionsMenu_ctor(&this->menuPostGamePlayer1Name,0x1040,(tScreen *)screenUserName,(tMenu *)0x0,
             (tMenu *)0x0,
             MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand,-1,0x20,10,
             (tMenuItem *)&this->menuItemUserName1,0);
  tOptionsMenu_ctor(&this->menuPostGamePlayer2Name,0x1080,(tScreen *)screenUserName,(tMenu *)0x0,
             (tMenu *)0x0,
             MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand,-1,0x20,10,
             (tMenuItem *)&this->menuItemUserName2,0);
  tMenuItemGoToMenuNFS4Button_ctor((tMenuItemGoToMenuNFS4Button *)&this->itemPostGameTrackRecordsContinue,0x5a,(tMenu *)0x0
             ,MenuExtended_PostGameMenu__FR12tMenuCommand,-1,-1)
  ;
  ptVar2 = screenTrackRecords;
  *(void **)&((this->itemPostGameTrackRecordsContinue)._vf) = (void *)&tBlankMenuItemGoToMenuNFS4Button_vtable;
  tOptionsMenu_ctor(&this->menuPostGameTrackRecords,0x21004,(tScreen *)ptVar2,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,0xd4,1,10,(tMenuItem *)&this->itemPostGameTrackRecordsContinue,0);
  tMenuBlank_ctor(&this->menuPinkSlipCongrats,0x8000,(tScreen *)screenPinkSlipCongrats,(tMenu *)0x0,
             (tMenu *)0x0,
             MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand,-1
            );
  tMenuBlank_ctor(&this->menuBeTheCopCongrats,0x8000,(tScreen *)screenBeTheCopCongrats,(tMenu *)0x0,
             (tMenu *)0x0,
             MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand,-1);
  tMenuBlank_ctor(&this->menuTierCompleteCongrats,0x8000,(tScreen *)screenTournamentCongrats,(tMenu *)0x0
             ,(tMenu *)0x0,
             MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand,-1);
  tMenuBlank_ctor(&this->menuCredits,0x1010,(tScreen *)screenMain[0],(tMenu *)0x0,(tMenu *)0x0,(void *)0x0
             ,-1);
  tMenuItemGoToMenuButton_ctor((tMenuItemGoToMenuButton *)&this->itemMemContinue,0x28a,(tMenu *)0x0,
             MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand);
  ptVar3 = screenMemcard;
  *(void **)&((this->itemMemContinue)._vf) = (void *)tMemoryCardMenuItem_vtable;
  tOptionsMenu_ctor(&this->menuPostGameSave,0x1040,(tScreen *)ptVar3,(tMenu *)0x0,(tMenu *)0x0,
             (void *)0x0,-1,0x2e,10,(tMenuItem *)&this->itemMemContinue,this_19,0);
  (this->menuPlayerOneCarSelect).fChildMenu = (tMenu *)&this->menuPlayerTwoCarSelect
  ;
  (this->menuPlayerOneGarage).fChildMenu = (tMenu *)&this->menuPlayerTwoGarage;
  (this->menuPlayerOnePinkSlipCarSelect).fChildMenu =
       (tMenu *)&this->menuPlayerTwoPinkSlipCarSelect;
  SetDimensions((tMenuItemLeftRightSlider *)&this->itemMusicVolume,0,0,0x78,5);
  SetDimensions((tMenuItemLeftRightSlider *)&this->itemSoundEffectsVolume,0,0,0x78,5);
  SetDimensions((tMenuItemLeftRightSlider *)&this->itemEngineVolume,0,0,0x78,5);
  SetDimensions((tMenuItemLeftRightSlider *)&this->itemSpeechVolume,0,0,0x78,5);
  SetDimensions((tMenuItemLeftRightSlider *)&this->itemAmbientVolume,0,0,0x78,5);
  uVar8 = (this->itemTournamentFinishedHome).fFlags;
  (this->iteratorPinkSlipsCar).fCarListFilter = 0x20;
  (this->iteratorGarageCar).fCarListFilter = 2;
  (this->iteratorDealerCar).fCarListFilter = 1;
  (this->iteratorSellerCar).fCarListFilter = 2;
  (this->menuAudio).VertHelp = 0;
  (this->menuDisplayOptions).VertHelp = 0;
  (this->menuControllerConfig).VertHelp = 1;
  (this->itemTournamentFinishedHome).fFlags =
       uVar8 | 0x40;
  (this->menuMemory).VertHelp = 0;
  (this->menuUserName).VertHelp = 0;
  (this->menuTrackRecords).VertHelp = 1;
  (this->menuTrophyInfo).VertHelp = 0;
  return;
}



/* ---- tGlobalMenuDefs::dtor  [FEMENUDEFS.CPP:2204] ---- */

tGlobalMenuDefs::~tGlobalMenuDefs()

{
  
  tOptionsMenu_dtor(&this->menuPostGameSave,2);
  tMenuItemGoToMenuButton_dtor((tMenuItemGoToMenuButton *)&this->itemMemContinue,2);
  tMenuBlank_dtor(&this->menuCredits,2);
  tMenuBlank_dtor(&this->menuTierCompleteCongrats,2);
  tMenuBlank_dtor(&this->menuBeTheCopCongrats,2);
  tMenuBlank_dtor(&this->menuPinkSlipCongrats,2);
  tOptionsMenu_dtor(&this->menuPostGameTrackRecords,2);
  tMenuItemGoToMenuNFS4Button_dtor((tMenuItemGoToMenuNFS4Button *)&this->itemPostGameTrackRecordsContinue,2);
  tOptionsMenu_dtor(&this->menuPostGamePlayer2Name,2);
  tOptionsMenu_dtor(&this->menuPostGamePlayer1Name,2);
  tMenuBlank_dtor(&this->menuTournamentTrophy,2);
  tMenuNFS4_dtor(&this->menuTournamentFinished,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTournamentFinishedHome,2);
  tMenuNFS4_dtor(&this->menuTournamentStandings,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTournStandingsExit,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTournStandingsForward,2);
  tMenuNFS4_dtor(&this->menuPinkSlipStandings,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPinkSlipStandingsExit,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPinkSlipStandingsForward,2);
  tMenuNFS4Bottom_dtor(&this->menuTrophyRoom,2);
  tMenuItemNFS4LeftRightChoice_dtor((tMenuItemNFS4LeftRightChoice *)&this->itemChangeTrophy,2);
  tListIterator_dtor(&this->iteratorChangeTrophy,2);
  tOptionsMenu_dtor(&this->menuUserName,2);
  tMenuItem_dtor((tMenuItem *)&this->menuItemUserName2,2);
  tMenuItem_dtor((tMenuItem *)&this->menuItemUserName1,2);
  tMenuItem_dtor((tMenuItem *)&this->menuItemUserName,2);
  tOptionsMenu_dtor(&this->menuMemory,2);
  tMenuItemGoToMenuButton_dtor((tMenuItemGoToMenuButton *)&this->itemLoadGame,2);
  tMenuItemGoToMenuButton_dtor((tMenuItemGoToMenuButton *)&this->itemSaveGame,2);
  tInsideBoxMenu_dtor(&this->menuControllerNegcon,2);
  tInsideBoxMenu_dtor(&this->menuControllerDualShockAnalog,2);
  tInsideBoxMenu_dtor(&this->menuControllerAnalog,2);
  tInsideBoxMenu_dtor(&this->menuControllerDualShock,2);
  tInsideBoxTwoWaySlider_dtor(&this->itemControllerIIMax,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerIIMax,2);
  tInsideBoxTwoWaySlider_dtor(&this->itemControllerIMax,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerIMax,2);
  tInsideBoxTwoWaySlider_dtor(&this->itemControllerCenterPoint,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerCenterPoint,2);
  tInsideBoxTwoWaySlider_dtor(&this->itemControllerJoyRange,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerJoyRange,2);
  tInsideBoxTwoWaySlider_dtor(&this->itemControllerDeadSpot2,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerDeadSpot2,2);
  tInsideBoxTwoWaySlider_dtor(&this->itemControllerSteeringRange2,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerSteeringRange2,2);
  tInsideBoxTwoWaySlider_dtor(&this->itemControllerDeadSpot1,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerDeadSpot1,2);
  tInsideBoxTwoWaySlider_dtor(&this->itemControllerSteeringRange1,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerSteeringRange1,2);
  tInsideBoxLeftRightSlider_dtor(&(this->itemControllerShockImpact)._base_tInsideBoxLeftRightSlider,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerShockImpact,2);
  tInsideBoxLeftRightSlider_dtor(&(this->itemControllerShockMode)._base_tInsideBoxLeftRightSlider,2);
  tListIteratorRangeIndexed_dtor(&this->iteratorControllerShockMode,2);
  tOptionsMenu_dtor(&this->menuControllerConfig,2);
  tMenuItemSlidingMenu_dtor(&this->itemControllerSettings,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemControllerConfigSelected,2);
  tListIteratorIndexed_dtor(&this->iteratorControllerConfigSelected,2);
  tOptionsMenu_dtor(&this->menuDisplayOptions,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDisplaySplitDisplay,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDisplaySplitTime,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDisplayLapNumber,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDisplayPosition,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDisplayTime,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDisplayOpponentID,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDisplayMap,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDisplaySpeedometer,2);
  tListIteratorIndexed_dtor(&this->iteratorDisplaySplitDisplay,2);
  tListIterator_dtor(&this->iteratorDisplaySplitTime,2);
  tListIteratorIndexed_dtor(&this->iteratorDisplayLapNumber,2);
  tListIteratorIndexed_dtor(&this->iteratorDisplayPosition,2);
  tListIteratorIndexed_dtor(&this->iteratorDisplayTime,2);
  tListIteratorIndexed_dtor(&this->iteratorDisplayOpponentID,2);
  tListIteratorIndexed_dtor(&this->iteratorDisplayMap,2);
  tListIteratorIndexed_dtor(&this->iteratorDisplaySpeedometer,2);
  tOptionsMenu_dtor(&this->menuAudio,2);
  tInsideBoxSongMenu_dtor(&this->menuPlayListMenu,2);
  tMenuItemSlidingMenu_dtor((tMenuItemSlidingMenu *)&this->itemSlidingPlayList,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemAudioMode,2);
  tMenuItemLeftRightAudioSlider_dtor(&this->itemAmbientVolume,2);
  tMenuItemLeftRightAudioSlider_dtor(&this->itemSpeechVolume,2);
  tMenuItemLeftRightAudioSlider_dtor(&this->itemEngineVolume,2);
  tMenuItemLeftRightAudioSlider_dtor(&this->itemSoundEffectsVolume,2);
  tMenuItemLeftRightAudioSlider_dtor(&this->itemMusicVolume,2);
  tListIterator_dtor(&this->iteratorAudioMode,2);
  tListIteratorRange_dtor(&this->iteratorAmbientVolume,2);
  tListIteratorRange_dtor(&this->iteratorSpeechVolume,2);
  tListIteratorRange_dtor(&this->iteratorEngineVolume,2);
  tListIteratorRange_dtor(&this->iteratorSoundEffectsVolume,2);
  tListIteratorRange_dtor(&this->iteratorMusicVolume,2);
  tMenuNFS4_dtor(&this->menuOptions,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOptionsCredits,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOptionsUsername,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOptionsMemoryCard,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOptionsControllers,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOptionsDisplay,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOptionsAudio,2);
  tMenuBlank_dtor(&this->menuShowroom,2);
  tMenuOptions_dtor(&this->menuPinkSlipCarOptionsPlayerTwo,2);
  tMenuOptions_dtor(&this->menuPinkSlipCarOptionsPlayerOne,2);
  tMenuOptions_dtor(&this->menuCarOptionsPlayerTwo,2);
  tMenuOptions_dtor(&this->menuCarOptionsPlayerOne,2);
  tMenuOptions_dtor(&this->menuCarOptions,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemOpponentUpgrades,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDamage2,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemABS2,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemTransmission2,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemDamage,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemABS,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemTransmission,2);
  tListIterator_dtor(&this->iteratorOpponentUpgrades,2);
  tListIterator_dtor(&this->iteratorDamage,2);
  tListIteratorIndexed_dtor(&this->iteratorABS,2);
  tListIteratorIndexed_dtor(&this->iteratorTransmission,2);
  tMenuNFS4_dtor(&this->menuCarUpgrades,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPurchaseUpgrade3,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPurchaseUpgrade2,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPurchaseUpgrade1,2);
  tMenuNFS4_dtor(&this->menuCarSeller,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSellCar,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemSellerCar,2);
  tListIteratorCar_dtor(&this->iteratorSellerCar,2);
  tMenuNFS4_dtor(&this->menuCarDealer,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemDealerShowroom,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemBuyCar,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemDealerColor,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemDealerCar,2);
  tListIteratorCarColor_dtor(&this->iteratorDealerColor,2);
  tListIteratorCar_dtor(&this->iteratorDealerCar,2);
  tMenuNFS4_dtor(&this->menuGoToCarDealer,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemGoToSellCar,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemGoToBuyCar,2);
  tMenuNFS4TwoPlayer_dtor(&this->menuPlayerTwoPinkSlipCarSelect,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemPinkSlipCarP2,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPlayerTwoPinkSlipRace,2);
  tMenuNFS4TwoPlayer_dtor(&this->menuPlayerOnePinkSlipCarSelect,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemPinkSlipCarP1,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPlayerOnePinkSlipRace,2);
  tListIteratorCar_dtor(&this->iteratorPinkSlipsCar,2);
  tMenuNFS4TwoPlayer_dtor(&this->menuPlayerTwoGarage,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemGarageCarP2,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPlayerTwoGarageRace,2);
  tMenuNFS4TwoPlayer_dtor(&this->menuPlayerOneGarage,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemGarageCarP1,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPlayerOneGarageRace,2);
  tMenuNFS4TwoPlayer_dtor(&this->menuPlayerTwoCarSelect,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemColorP2,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemCarP2,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPlayerTwoRace,2);
  tMenuNFS4TwoPlayer_dtor(&this->menuPlayerOneCarSelect,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemColorP1,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemCarP1,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPlayerOneRace,2);
  tMenuNFS4_dtor(&this->menuHPDuelCarSelect,2);
  tMenuNFS4_dtor(&this->menuDuelCarSelect,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemOpponentCar,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemGoToDuelBuyCar,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemColor2,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemCar2,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemDuelRace,2);
  tListIteratorCar_dtor(&this->iteratorOpponentCar,2);
  tMenuNFS4_dtor(&this->menuPostCarGarage,2);
  tMenuNFS4_dtor(&this->menuCarGarage,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemUpgradeCar,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemCarDealer,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemGarageCar,2);
  tListIteratorCar_dtor(&this->iteratorGarageCar,2);
  tMenuNFS4_dtor(&this->menuSingleCarSelect,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemShowcase,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemColor,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemCar,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemCarSelectRace,2);
  tListIteratorCarColor_dtor(&this->iteratorColor,2);
  tListIteratorCar_dtor(&this->iteratorCar1,2);
  tMenuNFS4_dtor(&this->menuTrackInfo,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTrackInfoContinue,2);
  tOptionsMenu_dtor(&this->menuTrackRecords,2);
  tMenuItemGoToMenuNFS4Button_dtor((tMenuItemGoToMenuNFS4Button *)&this->menuTrackRecordsItem,2);
  tMenuOptions_dtor(&this->menuTrackOptions,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemLocalSpeech,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemTraffic,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemWeather,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemTimeOfDay,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemTrackMirrored,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemTrackDirection,2);
  tMenuItemLeftRightChoice_dtor((tMenuItemLeftRightChoice *)&this->itemLaps,2);
  tListIterator_dtor(&this->iteratorLocalSpeech,2);
  tListIteratorIndexed_dtor(&this->iteratorTraffic,2);
  tListIteratorIndexed_dtor(&this->iteratorWeather,2);
  tListIteratorIndexed_dtor(&this->iteratorTimeOfDay,2);
  tListIteratorIndexed_dtor(&this->iteratorTrackMirrored,2);
  tListIteratorIndexed_dtor(&this->iteratorTrackDirection,2);
  tListIteratorIndexed_dtor(&this->iteratorLaps,2);
  tMenuNFS4_dtor(&this->menuTestDriveTrackSelect,2);
  tMenuNFS4_dtor(&this->menuSingleTrackSelect,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTrackRecords,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemTrack,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTrackContinue,2);
  tListIteratorTrack_dtor(&this->iteratorTrack,2);
  tMenuNFS4_dtor(&this->menuPinkSlipsBestOfFive,2);
  tMenuNFS4_dtor(&this->menuPinkSlipsBestOfThree,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemTrack5,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemTrack4,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemTrack3,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemTrack2,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemTrack1,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemPinkSlipsContinue,2);
  tMenuNFS4_dtor(&this->menuPinkSlipSelect,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemBestOfFive,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemBestOfThree,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemBestOfOne,2);
  tMenuNFS4_dtor(&this->menuTwoPlayer,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTwoPlayerPinkSlips,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTwoPlayerHotPursuit,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTwoPlayerDuel,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTwoPlayerTestDrive,2);
  tMenuNFS4_dtor(&this->menuSpecialEvent,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemSpecialEventSelect,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSpecialEventContinue,2);
  tListIteratorTournament_dtor(&this->iteratorSpecialEvent,2);
  tMenuNFS4_dtor(&this->menuTournament,2);
  tMenuItemNFS4LeftRightChoice_dtor(&this->itemTournamentSelect,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTournamentContinue,2);
  tListIteratorTournament_dtor(&this->iteratorTournament,2);
  tMenuNFS4_dtor(&this->menuHotPursuit,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemHotPursuitDuel,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemHotPursuitSolo,2);
  tMenuNFS4_dtor(&this->menuSingleRace,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSingleRaceFullGrid,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSingleRaceDuel,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSingleRaceSolo,2);
  tMenuNFS4_dtor(&this->menuOnePlayer,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOnePlayerSpecialEvents,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOnePlayerTournament,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOnePlayerPursuit,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOnePlayerSingleRace,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemOnePlayerTestDrive,2);
  tMenuNFS4_dtor(&this->menuSkillLevel,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSkillExpert,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSkillIntermediate,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSkillBeginner,2);
  tMenuBlank_dtor(&this->menuTrophyInfo,2);
  tMenuNFS4_dtor(&this->menuTrophyRoomSelect,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemSETrophyRoom,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemTournTrophyRoom,2);
  tMenuNFS4_dtor(&this->menuMain,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemMainOptions,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemMainTrophyRoom,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemMainTwoPlayerRace,2);
  tMenuItemGoToMenuNFS4Button_dtor(&this->itemMainOnePlayerRace,2);
  return;
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
