/* frontend/common/femenudefs.cpp -- RECONSTRUCTED (menu-command callbacks + menu-defs ctor; C++ TU)
 *   66 fns: free MenuExtended_* command callbacks + tGlobalMenuDefs ctor/dtor (menu-defs init)
 *   + TransitionIsFinished button methods. Free fns in ns nfs4::FRONTEND::COMMON::FEMenuDefs.
 */
#include "femenudefs.h"


inline tDialogMessageString *tDialogMessageString::SetString(int word)
{
  string = TextSys_Word(word);
  return this;
}

/* ---- FEMenuDefs.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes) ---- */
/* tBlankMenuItemGoToMenuNFS4Button_vtable @0x800114d8 + tBlankMenuItemNFS4LeftRightChoice_vtable @0x80011530:
   real __vtbl_ptr_type[11] defs live in game/common/vtables_tmenu.cpp; declared extern via femenudefs_externs.h. */
short        SelectListNull[2] = { 0, 0 };   /* @0x80051970: precedes the initialized SelectList*
                                             tables in retail .data, so it is emitted at its
                                             definition (initialized), not deferred */
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
static tCarModels gCarActivation[6][5] = { 25, 25, 25, 25, 25, 24, 24, 24, 24, 24, 26, 26, 26, 27, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 28, 28, 28, 28, 28 };   /* @0x800519e0; SYM STAT */
/* P872: native SYM 5ba0c1 is a scalar PTR tGlobalMenuDefs (4 B).
   Frontend -G0 preserves the original addressing without an array carrier. */
tGlobalMenuDefs *menuDefs;   /* @0x80051a58 base VA */


/* ---- MenuExtended_SetOnePlayer__FR12tMenuCommand  [FEMENUDEFS.CPP:145-153] ---- */

/* Decoded Phase 83: MenuExtended_SetOnePlayer__FR12tMenuCommand(tMenuCommand&) - set numPlayers=1 (76 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

void MenuExtended_SetOnePlayer(tMenuCommand &command)

{
  if (FEApp->fInputPlayer == '\x01') {
    command.type = kMenu_Command_None;
  }
  else {
    frontEnd.gameMode = '\0';
    screenMain->SwapBackground(-1);
  }
  return;
}



/* ---- MenuExtended_SetTwoPlayer__FR12tMenuCommand  [FEMENUDEFS.CPP:158-167] ---- */

/* Decoded Phase 83: MenuExtended_SetTwoPlayer__FR12tMenuCommand(tMenuCommand&) - set numPlayers=2 (split-screen) (80
   B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

void MenuExtended_SetTwoPlayer(tMenuCommand &command)

{
  if (gPadinfo.buf[4].nopad != '\0') {
    command.type = kMenu_Command_None;
  }
  else {
    frontEnd.gameMode = '\x01';
    frontEnd.oppNumber = '\0';
    screenMain->SwapBackground(-1);
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

void MenuExtended_SetTestDrive(tMenuCommand &)

{
  frontEnd.carListType = '\0';
  frontEnd.oppNumber = '\0';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = RaceType_SingleRace;
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

void MenuExtended_SetSingleRace(tMenuCommand &)

{
  frontEnd.carListType = '\x01';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = RaceType_SingleRace;
  screenMain->SwapBackground(-1);
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

void MenuExtended_SetTournament(tMenuCommand &)

{
  frontEnd.carListType = '\x01';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.tier = '\0';
  frontEnd.raceType = RaceType_Tournament;
  screenMain->SwapBackground(-1);
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

void MenuExtended_SetSpecialEvent(tMenuCommand &)

{
  frontEnd.carListType = '\x01';
  frontEnd.tier = '\x01';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = RaceType_Tournament;
  screenMain->SwapBackground(-1);
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

void MenuExtended_SetSoloRace(tMenuCommand &)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\0';
  frontEnd.oppNumber = '\0';
  frontEnd.carListType = '\x01';
}



/* ---- MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand  [FEMENUDEFS.CPP:221-245] ---- */

/* Enter the two-player single-race menu flow (276 retail bytes).
   2026-10-14: implicit construction and ordinary fallthrough also unlock
   the natural nextMenu-store / SetState-call statements. All 69 instructions
   PASS without carSelectScreen/nextMenu/screenState, an empty ASM fence,
   the do/while note dial, or an assignment embedded in the call argument.
   Older separate-statement failures did not test this recovered source basin.
   Retail records command, YesNoDialog and the nested constructor receiver;
   the existing inferred dialog helper names are not original-name receipts.
   The source statement/brace layout reproduces all 69 retail instruction
   tags, block lines and the 24-line end delta. Keep audit notes out of the
   body; no blank padding, #line or post-compiler changes are involved.
   Actual target-address linking also matches all 276 executable bytes.
   Original helper spellings/cross-TU body visibility are not uniquely proved.
   Implicit construction plus ordinary fallthrough reproduce all 13 retail
   scopes; scope destruction supplies the sole destructor call. */

void MenuExtended_GoToTwoPlayerSingleRace(tMenuCommand &command)
{
  tDialogYesNoTri YesNoDialog;

  if ((short)carManager.GetNumOwnedCars(0) < 1)
  { YesNoDialog.SetString(TextSys_Word(0x42));
    YesNoDialog.SetChoices(0x321,
                           0x322,
                           0);
    if (YesNoDialog.Run() == 1)
    {
      frontEnd.raceType = '\0';
      command.type = kMenu_Command_GoToMenu;
      menuDefs->iteratorDealerCar.Decrement(kPlayerBoth);
      menuDefs->iteratorDealerCar.Increment(kPlayerBoth);
      command.nextMenu = &menuDefs->menuCarDealer;
      screenCarSelect->SetState(2);
    }
  }
  else
  {
    MenuExtended_SetSoloRace(command);
    command.type = kMenu_Command_GoToMenu;
    command.nextMenu = &menuDefs->menuSingleTrackSelect;
  }
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

void MenuExtended_SetDuelRace(tMenuCommand &)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\0';
  frontEnd.oppNumber = '\x01';
  screenMain->SwapBackground(-1);
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

void MenuExtended_SetFullGrid(tMenuCommand &)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\0';
  frontEnd.oppNumber = '\x02';
  screenMain->SwapBackground(-1);
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
  if ((FECheat_IsTheUserACryBabyCheater() ^ 1) != 0) {
    tDialogYesNo YesNoDialog;
    int answer;
    tDialogYesNo *const dialog = Dialog_AsYesNo(YesNoDialog.SetString(TextSys_Word(0x331)));
    dialog->yesnowords[0] = 0x321;
    dialog->yesnowords[1] = 0x322;
    dialog->fDefault = 0;
    answer = (short)((tDialogInteractive *)dialog)->Run();





    return answer;
  }
  return 0;
}



/* ---- MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand  [FEMENUDEFS.CPP:295-297] ---- */

/* Decoded Phase 83: MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand(tMenuCommand&) - return to main
   menu without saving (28 B)
   
   [ghidra-meta] section: front.text */

/* P874: native SYM 5b47bd records only command. With scalar menuDefs,
   the two original statements need no menuDefsBase carrier. SLD296 assigns
   nextMenu before SLD297 assigns type: PASS7/exact-g, all line groups exact. */
void MenuExtended_TransitionFromPostGameToMainMenu(tMenuCommand &command)

{
  command.nextMenu = &menuDefs->menuMain;
  command.type = kMenu_Command_GoToMenuOneWay;
}



/* ---- MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand  [FEMENUDEFS.CPP:301-308] ---- */

/* Decoded Phase 83: MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame__FR12tMenuCommand(tMenuCommand&) -
   auto-save then return to main menu (76 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [SYM/SLD 2026-08-25] Retail records only `command`.  Calling the predicate
   directly removes the former iVar2 without code change.  Spelling nextMenu
   before type makes GCC load menuDefs before the independent type store and is
   exact PASS 19/19; the opposite source order is FAIL 5 (20/19). */

void MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame(tMenuCommand &command)

{
  if (AskTheUserToSaveTheGame() != 0) {

    command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuPostGameSave;
    command.type = kMenu_Command_GoToMenuOneWay;
  }
  else {
    MenuExtended_TransitionFromPostGameToMainMenu(command);
  }
}



/* ---- MenuExtended_GoToCarSelect__FR12tMenuCommand  [FEMENUDEFS.CPP:313-420] ---- */

/* Decoded Phase 83: MenuExtended_GoToCarSelect__FR12tMenuCommand(tMenuCommand&) - transition to car-select screen;
   sets up garage car list (916 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   2026-10-14: MessagePopup/SetString and seven SetFilter expansions restore
   the retail inline producers. They also unlock ordinary branch-local menu
   stores and SetState calls: nextMenu/screen/state declarations are gone at
   229 PASS, not proven necessary by the older direct-statement failures.
   Native names/types/homes/owners and all 34 scope pairs match. The shortcut
   enters before the combined guard; entering inside its body did not match.
   Complete SLD remains under recovery.
   SOURCE-REVIEW-UNRESOLVED: dialog is now debug-elided after the real getter
   and setter calls, but that does not certify a distinct original object.
   Its value is the popup address held across GetTrack; no new variable name,
   qualifier, fake use, ASM or scope wrapper is used to hide the uncertainty. */

void MenuExtended_GoToCarSelect(tMenuCommand &command)

{
  tDialogMessageString *dialog = FEApp->MessagePopup();
  tTrackInformation trackInfo;
  
  trackManager.GetTrack(frontEnd.track[frontEnd.pinkSlipsTrackIndex], trackInfo);
  if (trackInfo.fAvailable == '\0')
  {
    dialog->SetString(TextSys_Word(0xeb));
    dialog->tDialogBase::Display();
    return;
  }
  if (frontEnd.gameMode == '\x01') {
    command.type = kMenu_Command_GoToMenuTwoPlayer;
    if (frontEnd.raceType != RaceType_PinkSlips) {
      if (frontEnd.carListType == '\0') {
        command.nextMenu = (tMenu *)&menuDefs->menuPlayerOneCarSelect;
      }
      else {
        command.nextMenu = (tMenu *)&menuDefs->menuPlayerOneGarage;
      }
    }
    else {
      command.nextMenu = (tMenu *)&menuDefs->menuPlayerOnePinkSlipCarSelect;
    }
  }
  else {
    if (frontEnd.oppNumber == '\x01') {
      command.type = kMenu_Command_GoToMenu;
      if (frontEnd.raceType == RaceType_HotPursuit) {
        command.nextMenu = (tMenu*)&menuDefs->menuHPDuelCarSelect;
      }
      else {
        command.nextMenu = (tMenu*)&menuDefs->menuDuelCarSelect;
      }
      ((tScreenCarSelect *)screenCarSelectDuel)->SetState(7);
    }
    else {
      command.type = kMenu_Command_GoToMenu;
      if (frontEnd.carListType == '\0') {
        command.nextMenu = &menuDefs->menuSingleCarSelect;
        screenCarSelect->SetState(0);
      }
      else {
        command.nextMenu = &menuDefs->menuCarGarage;
        screenCarSelect->SetState(1);
      }
    }
  }
  switch (frontEnd.raceType) {
  case '\x01':
    if ((frontEnd.oppNumber == '\0') || (frontEnd.gameMode == '\x01')) {
      menuDefs->iteratorCar1.SetFilter(9);
    }
    else {
      menuDefs->iteratorCar1.SetFilter(1);
    }
    break;
  case '\x06':
    menuDefs->iteratorPinkSlipsCar.SetFilter(0x20);
    break;
  default:
    if (frontEnd.carListType == '\0') {
      menuDefs->iteratorCar1.SetFilter(1);
    }
    else if (frontEnd.raceType == RaceType_Tournament) {
      menuDefs->iteratorGarageCar.SetFilter(0x40);
    }
    else {
      menuDefs->iteratorGarageCar.SetFilter(2);
    }
    break;
  }
  if (frontEnd.carListType == '\0') {
    menuDefs->iteratorCar1.Decrement(kPlayerOne);
    menuDefs->iteratorCar1.Increment(kPlayerOne);
    menuDefs->iteratorCar1.Decrement(kPlayerTwo);
    menuDefs->iteratorCar1.Increment(kPlayerTwo);
  }
  else {
    if ((int)((uint)carManager.GetNumOwnedCars(0) << 0x10) < 1) {
      if (frontEnd.raceType == RaceType_HotPursuit) {
        if (frontEnd.oppNumber == '\x01') goto MX_GoToCar_oppFilterSetup;
        goto MX_GoToCar_garageIter;
      }
    }
    else {
MX_GoToCar_garageIter:
      menuDefs->iteratorGarageCar.Decrement(kPlayerOne);
      menuDefs->iteratorGarageCar.Increment(kPlayerOne);
      if (frontEnd.gameMode == '\x01') {
        menuDefs->iteratorGarageCar.Decrement(kPlayerTwo);
        menuDefs->iteratorGarageCar.Increment(kPlayerTwo);
      }
    }
  }
MX_GoToCar_oppFilterSetup:
  if (frontEnd.oppNumber == '\x01' && frontEnd.raceType != RaceType_Tournament) {
    menuDefs->iteratorOpponentCar.Decrement(kPlayerBoth);
    menuDefs->iteratorOpponentCar.Increment(kPlayerBoth);
    menuDefs->iteratorOpponentCar.SetFilter(1);
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

/* [W57-A1 2026-08-09, 10->8] The v0/v1 const-vs-pointer swap declared a "genuine gcc scratch tie
   -> accept" above is NOT a floor -- it is a local-alloc QTY PRIORITY tie and the dial is the
   constant's LIVE RANGE.  QTY_CMP_PRI = floor_log2(refs)*refs*size/(death-birth): with `1`
   materialized at its store its range is ~2 insns -> priority 10000 -> it wins the numeric scan
   and takes v0; the menuDefs pointer (range ~4) gets v1.  Naming the constant and holding it from
   the top of the fn behind a 0-insn opacity fence (a bare `cmdType = 1;` is folded straight back
   into the store by cse and changes nothing -- measured) lengthens its range, drops its priority
   below the pointer's, and the whole {v0,v1} pair flips to the oracle's assignment.  The remaining
   four independent setup operations are restored to retail order by the scoped build recipe.
   [2026-08-25] Re-gating disproved the stale MATCH claim: that form was eight
   diffs.  A second named call-state value and ONE combined two-output opacity
   fence preserve both allocation decisions together and reduce the residual
   to two (26/26 instructions); only `li v1,1` is scheduled early. */

/* P872 supersedes the historical allocation recipes above: native SYM
   5b4c92 records only command (REGPARM a2), no locals. Restoring scalar
   menuDefs and the five retail statements removes all five source carriers
   and both absorption inflators, with PASS26/exact-g and SLD423-428 groups.
   P872 needed a scalar-equivalent screenCarSelect load because its extern
   still used an array view. P873 corrects that complete declaration graph
   to native SYM 64b0d0 PTR tScreenCarSelect, permitting the ordinary receiver.
   With the old array extern, [0] gave FAIL11 and staged scalar code FAIL14.
   No helper, new local, asm, volatile, or postcompile rewrite is involved. */
static void MenuExtended_GoToDealer(tMenuCommand &command)

{
  command.type = kMenu_Command_GoToMenu;
  command.nextMenu = &menuDefs->menuCarDealer;
  screenCarSelect->SetState(2);
  menuDefs->iteratorDealerCar.Decrement(kPlayerBoth);
  menuDefs->iteratorDealerCar.Increment(kPlayerBoth);
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

/* [W57-A1 2026-08-09, 10->8; corrected 2026-08-25] Same allocation family as
   GoToDealer.  The old PASS receipt was stale; the combined state/cmdType
   fence below reduces the authoritative residual to two at 26/26 instructions. */

/* P872: the same scalar-source repair as GoToDealer gives PASS26/exact-g,
   zero locals/inflators, and the native SLD432-437 statement groups.
   P873 also replaces its scalar-punning view with the native declaration. */
static void MenuExtended_GoToSeller(tMenuCommand &command)

{
  command.type = kMenu_Command_GoToMenu;
  command.nextMenu = &menuDefs->menuCarSeller;
  screenCarSelect->SetState(3);
  menuDefs->iteratorSellerCar.Decrement(kPlayerBoth);
  menuDefs->iteratorSellerCar.Increment(kPlayerBoth);
}



/* ---- MenuExtended_GoToUpgrades__FR12tMenuCommand  [FEMENUDEFS.CPP:441-444] ---- */

/* Decoded Phase 83: MenuExtended_GoToUpgrades__FR12tMenuCommand(tMenuCommand&) - transition to upgrades-purchase
   screen (64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

/* P874: scalar menuDefs/screenCarSelect make the old FAIL7 array-view receipt
   obsolete. Native SYM records only command, so retain the three statements
   and no menuDefsBase alias. PASS16/exact-g; every SLD441-444 group matches.
   GoToShowroom and GoToDealerShowroom use the same source shape below. */
static void MenuExtended_GoToUpgrades(tMenuCommand &command)

{
  command.type = kMenu_Command_GoToMenu;
  command.nextMenu = &menuDefs->menuCarUpgrades;
  screenCarSelect->SetState(4);
}



/* ---- GenericMenuSaveGame  [FEMENUDEFS.CPP:448-478] ---- */

/* Decoded Phase 86: FE-GenericMenuSaveGame (284 B): execute generic save-game flow from
   menu.
   
   [ghidra-meta] section: front.text */

/* 2026-10-14: the word-ID SetString overload computes TextSys_Word inside
   its actual receiver lifetime, restoring retail's tDialogMessageString this
   in s0 without a noInput capture. Ordinary condition-tested polling and the
   direct post-loop Redraw match 71 words without an app capture or loop dial.
   All six native declarations/owners and all 12 retail scopes agree.
   Older capture/rotation failures were source-basin-specific, not proof of
   separate original objects. Helper spelling/complete SLD remain unsealed.
   successful and uninitafter have their recorded value roles, and the two
   SetMessage calls restore the actual nested tScreenMemcard receivers. */

/* [SYM 2026-08-16] retail `Def class EXT type FCN BOOL` @0x8002c9a0 -> bool, not void*.
   The result temp only stays a plain move (`addu s0,v0,zero`, not a `sltu` bool
   normalisation) because SaveGame is ALSO BOOL in the SYM (@0x80034988) -- the
   femenudefs_externs.h decl was corrected in the same pass. */
bool GenericMenuSaveGame(int showdialog)
{
  bool successful;
  bool uninitafter;   /* SYM: REG BOOL uninitafter */

  screenMemcard->SetMessage(0x27e);
  FEApp->Redraw();
  uninitafter = false;
  if ((MEMCARD_INITIALIZED == 0) || (showdialog != 0)) {
    FEApp->NoInputMemCardDialog.SetString(0x282);
    FEApp->NoInputMemCardDialog.tDialogBase::Display();
    while (!Dialog_FullyOpen(&FEApp->NoInputMemCardDialog)) {
      FEApp->Redraw();
    }
    FEApp->Redraw();
    if (MEMCARD_INITIALIZED == 0) {
      uninitafter = true;
      Init_Memcard(true,0);
    }
  }
  successful = SaveGame(0);
  screenMemcard->SetMessage(-1);
  if (uninitafter) {
    DeInit_Memcard();
  }
  FEApp->NoInputMemCardDialog.tDialogBase::Hide();
  return successful;
}



/* ---- PinkSlipsPreSave  [FEMENUDEFS.CPP:484-504] ---- */

/* Decoded Phase 86: FE-PinkSlipsPreSave (200 B): pre-save hook for Pink Slips mode.
   
   [ghidra-meta] section: front.text */

/* [SYM 2026-08-16] retail `Def class EXT type FCN BOOL` @0x8002cabc;
   the SYM also names the result local `REG BOOL ret`.
   [2026-10-15] Actual SetString/SetChoices/Run calls remove dlgThis.
   Initialize ret before constructing YesNoDialog in the same lexical owner;
   assigning it after construction was two schedule differences at50 words.
   Explicit else preserves retail's outer binding endpoint. All four ordered
   declaration/home/type/owner records and all native scope pairs match;
   all200 linked bytes are exact. Full SLD remains unresolved (42/50 tags,
   end delta17 versus20); this is not a literal-original-text certificate. */
bool PinkSlipsPreSave(void)

{
  if ((FECheat_IsTheUserACryBabyCheater() ^ 1) != 0) {
    bool ret = true;
    tDialogYesNoTri YesNoDialog;
    int answer;
    YesNoDialog.SetString(TextSys_Word(0x273));
    YesNoDialog.SetChoices(0x321,0x322,0);
    answer = YesNoDialog.Run();
    if (answer == 1) {
      ret = GenericMenuSaveGame(1);
    }
    else if (answer == -1) {
      return false;
    }
    return ret;
  }
  else
    return true;
}



/* ---- MenuExtended_GoToBestOfOne__FR12tMenuCommand  [FEMENUDEFS.CPP:508-519] ---- */

/* Decoded Phase 83: MenuExtended_GoToBestOfOne__FR12tMenuCommand(tMenuCommand&) - set tournament length to best-of-1
   (92 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

/* SYM/SLD family receipt (One/Three/Five): retail records only `command`.
   Calling PinkSlipsPreSave directly removes pvVar2, while spelling nextMenu
   before type lets GCC load menuDefs before the independent command store.
   This local-free shape is exact PASS 23/23 in all three clones. */

void MenuExtended_GoToBestOfOne(tMenuCommand &command)

{

  if (PinkSlipsPreSave()) {
    command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuSingleTrackSelect;
    command.type = kMenu_Command_GoToMenu;
  }
  else {
    command.type = kMenu_Command_None;
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

void MenuExtended_GoToBestOfThree(tMenuCommand &command)

{
  if (PinkSlipsPreSave()) {
    command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuPinkSlipsBestOfThree;
    command.type = kMenu_Command_GoToMenu;
  }
  else {
    command.type = kMenu_Command_None;
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

void MenuExtended_GoToBestOfFive(tMenuCommand &command)

{
  if (PinkSlipsPreSave()) {
    command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuPinkSlipsBestOfFive;
    command.type = kMenu_Command_GoToMenu;
  }
  else {
    command.type = kMenu_Command_None;
  }
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.pinkSlipsNumTracks = '\x05';
  return;
}



/* ---- MenuExtended_GoToRace__FR12tMenuCommand  [FEMENUDEFS.CPP:551-607] ---- */

/* Decoded Phase 83: MenuExtended_GoToRace__FR12tMenuCommand(tMenuCommand&) - commit settings and transition into race(calls Front_BuildStream) (348 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

  /* [W57-A1 rewrite] The oracle materializes the word id STRAIGHT INTO $a0 in each guard's
     branch delay slot (`li a0,170/241/242/243`) and cross-jump-merges four IDENTICAL
     `string = TextSys_Word(K); Display(popUp); command.type = 0; return;` tails -- so retail
     duplicated that tail per branch instead of funnelling one `wordnum` local (which forces a
     callee-saved reg because the pseudo crosses the other guards' calls: ours was 6 s-regs /
     frame 256 vs the oracle's 4 / 248).  Plus the 08D messagePopup ANCHOR: `popUp = &FEApp->
     messagePopup` materialized EARLY (the oracle puts `addiu s1,v1,44` in the first guard's
     delay slot) and reused for both the store and the Display arg. */
  /* [SYM restoration 2026-08-26, PASS 87/87] Reliable SYM names only
     command/popUp/carInfo in the caller.  MessagePopup restores the initial
     tFEApplication receiver and the four SetString calls restore its four
     nested dialog receivers.  Direct call-result tests eliminate uVar2;
     dlgThis, ptVar1, pcVar3, and wordnum were decompiler residue.  Optimized
     SYM does not preserve the private MessagePopup identifier.
     2026-10-15: nested real guards recover all27 retail scope pairs and
     named owners. The declared short count results need no decompiler-style
     unsigned shift test; direct comparisons retain87PASS. Full SLD is open. */

void MenuExtended_GoToRace(tMenuCommand &command)

{
  tDialogMessageString *popUp;
  tCarInfo carInfo;
  command.type = kMenu_Command_StartRace;
  popUp = FEApp->MessagePopup();
  if (frontEnd.carListType == '\x01') {
    if ((carManager.GetNumOwnedCars(0) <= 0) &&
        (frontEnd.raceType != RaceType_HotPursuit) &&
        (frontEnd.raceType != RaceType_PinkSlips)) {
      popUp->SetString(TextSys_Word(0xaa));
      popUp->tDialogBase::Display();
      command.type = kMenu_Command_None;
      return;
    }
  }
  if (frontEnd.raceType == RaceType_Tournament) {
    if (carManager.GetNumTourneyCars(0) < 1) {
      popUp->SetString(TextSys_Word(0xf1));
      popUp->tDialogBase::Display();
      command.type = kMenu_Command_None;
      return;
    }
  }
  if (frontEnd.raceType == RaceType_HotPursuit) {
    carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[0],carInfo);
    if (carInfo.fPursuitAvailable == '\x00') {
      popUp->SetString(TextSys_Word(0xf2));
      popUp->tDialogBase::Display();
      command.type = kMenu_Command_None;
      return;
    }
  }
  if (frontEnd.carListType == '\x00') {
    carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[0],carInfo);
    if (carInfo.fAvailable == '\x00') {
      popUp->SetString(TextSys_Word(0xf3));
      popUp->tDialogBase::Display();
      command.type = kMenu_Command_None;
    }
  }
}



/* ---- MenuExtended_GoTo2PlayerRace__FR12tMenuCommand  [FEMENUDEFS.CPP:610-655] ---- */

/* Decoded Phase 83: MenuExtended_GoTo2PlayerRace__FR12tMenuCommand(tMenuCommand&) - enter 2-player split-screen race
   setup flow (332 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

  /* [W57-A1 rewrite] Same shape as the twin GoToRace: the oracle drops the `wordnum` funnel
     (which needed 2 extra callee-saved regs -- ours 6 s-regs/frame 256 vs 4/248) and instead
     materializes `li a0,K` in each guard's delay slot, cross-jump-merging four identical
     `TextSys_Word/Display/type=0` tails; + the 08D messagePopup anchor materialized early
     (oracle `addiu s2,v0,44` in the raceType==6 guard's delay slot). */
  /* [SYM restoration 2026-08-26, PASS 83/83] Reliable caller locals are only
     command/popUp/carInfo.  MessagePopup, three SetString calls, and two
     CurrentPlayer reads account for every nested receiver; direct call-result
     testing removes uVar2 and the remaining four decompiler identities.  The
     two inferred tFEApplication helper names are descriptive, not token-exact.
     2026-10-15: separate car-list/availability/pursuit guards recover all25
     retail scope pairs and named owners. Direct short-result comparison
     retains83PASS without the unsigned-shift transcription. Full SLD is open. */

void MenuExtended_GoTo2PlayerRace(tMenuCommand &command)

{

  tDialogMessageString *popUp;
  tCarInfo carInfo;
  command.type = kMenu_Command_Start2PlayerRace;
  popUp = FEApp->MessagePopup();
  if (frontEnd.raceType == RaceType_PinkSlips) {
    return;
  }
  if (frontEnd.carListType == '\x01') {

    if ((carManager.GetNumOwnedCars(0) <= 0) &&
        (frontEnd.raceType != RaceType_HotPursuit)) {


      popUp->SetString(TextSys_Word(0xaa));
      popUp->tDialogBase::Display();
      command.type = kMenu_Command_None;
      return;
    }
  }
  if (frontEnd.carListType == '\x00') {
    carManager.GetStockCar(
        (ushort)(byte)frontEnd.playerCar[(byte)FEApp->CurrentPlayer()],carInfo);
    if (carInfo.fAvailable == '\x00') {

      popUp->SetString(TextSys_Word(0xf3));
      popUp->tDialogBase::Display();
      command.type = kMenu_Command_None;
      return;


    }
  }
  if (frontEnd.raceType == RaceType_HotPursuit) {
    carManager.GetStockCar(
        (ushort)(byte)frontEnd.playerCar[(byte)FEApp->CurrentPlayer()],carInfo);
    if (carInfo.fPursuitAvailable == '\x00') {
      popUp->SetString(TextSys_Word(0xf2));

      popUp->tDialogBase::Display();
      command.type = kMenu_Command_None;

    }
  }
}



/* ---- MenuExtended_GoToTournTrackInfo__FR12tMenuCommand  [FEMENUDEFS.CPP:658-693] ---- */

/* Decoded Phase 83: MenuExtended_GoToTournTrackInfo__FR12tMenuCommand(tMenuCommand&) - transition to tournament-round
   track info screen (360 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

/* MATCH/SYM (2026-08-26): exact PASS 90/90.  Reliable records identify
   command in s3, tourn in s2, amount in v1, stack popUp, and the receivers
   inlined from DisplayMessage/SetString.  Restoring those member calls removes
   ptVar1, this_00, pcVar5, pp, and sVar4; direct expressions remove ptVar3,
   iVar6, and the duplicate iVar7 amount carrier. The earlier allocation
   workarounds are superseded by the verified2026-10-15 source query below. */
/* P878: the corrected scalar menuDefs declaration makes the ordinary final
   command stores exact; no additional menus alias is needed. */
/* 2026-10-15: amount is the expanded LONG debit parameter, not a caller local.
   SubtractMoney restores its parameter/body pair; the explicit affordability
   else restores popUp/amount depths and endpoints at90PASS. Literal inline
   spelling remains inferred. The parameterized CurrentTourney/GetMoney queries
   now remove all four caller aliases and both fences at90PASS; all32 retail
   scope pairs and six named declaration owners match. Full SLD is open. */

void MenuExtended_GoToTournTrackInfo(tMenuCommand &command)

{
  tTourneyInfo *tourn;
  frontEnd.tier = '\0';
  tourn = tournamentManager.CurrentTourney(0,frontEnd.tournament);
  if (0 < tourn->fEntranceFee) {
    if (tourn->fEntranceFee > tournamentManager.GetMoney()) {
      FEApp->MessagePopup()->SetString(0xf6)->tDialogBase::Display();
      return;
    }
    else {
      tDialogYesNo popUp;

      popUp.SetString(TextSys_Word(0xf7));
      popUp.SetChoices(0x322,0x321,0);
      if (popUp.Run() != 0) {
        AudioCmn_PlayFESFX(0x1a);
        tournamentManager.SubtractMoney(tourn->fEntranceFee);
      } else {
        return;
      }
    }
  }
  tournamentManager.StartNewTournament(0,frontEnd.tournament);
  command.type = kMenu_Command_GoToMenu;
  command.nextMenu = &menuDefs->menuTrackInfo;
  return;
}



/* ---- MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand  [FEMENUDEFS.CPP:696-731] ---- */

/* Decoded Phase 83: MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand(tMenuCommand&) - transition to
   special-event track info screen (364 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

/* MATCH/SYM (2026-08-26): exact PASS 91/91.  Reliable records identify
   command in s3, tourn in s2, amount in v1, stack popUp, and the receivers
   inlined from DisplayMessage/SetString.  Restored member calls and direct
   expressions remove eight decompiler identities; the earlier allocation
   workarounds are superseded by the verified2026-10-15 source query below. */
/* P878: ordinary final command stores now match with the corrected scalar
   menuDefs interface. The former menus carrier and its obsolete failure
   receipt are removed. */
/* 2026-10-15: the money mutator/explicit else recover amount's LONG REG3
   parameter/body pair and popUp's retail depth/endpoints at91PASS. Literal
   inline spelling remains inferred. Parameterized CurrentTourney/GetMoney
   remove the three caller aliases and both fences at91PASS; all32 retail
   scope pairs and six named declaration owners match. Full SLD remains open. */

void MenuExtended_GoToSpecialEventTrackInfo(tMenuCommand &command)

{
  tTourneyInfo *tourn;
  frontEnd.tier = '\x01';
  tourn = tournamentManager.CurrentTourney(1,frontEnd.specialevent);
  if (0 < tourn->fEntranceFee) {
    if (tourn->fEntranceFee > tournamentManager.GetMoney()) {
      FEApp->MessagePopup()->SetString(0xf6)->tDialogBase::Display();
      return;
    }
    else {
      tDialogYesNo popUp;

      popUp.SetString(TextSys_Word(0xf7));
      popUp.SetChoices(0x321,0x322,0);
      if (popUp.Run() != 0) {
        AudioCmn_PlayFESFX(0x1a);
        tournamentManager.SubtractMoney(tourn->fEntranceFee);
      } else {
        return;
      }
    }
  }
  tournamentManager.StartNewTournament(1,frontEnd.specialevent);
  command.type = kMenu_Command_GoToMenu;
  command.nextMenu = &menuDefs->menuTrackInfo;
  return;
}



/* ---- MenuExtended_EnterUserName__FR12tMenuCommand  [FEMENUDEFS.CPP:734-739] ---- */

/* Prompt initial-profile user-name entry (100 B).

   [SYM restoration 2026-08-26, PASS 25/25] Retail records only caller parameter
   `command`.  Its two nested line-2 scopes are exact inline receipts:
   tUserNameMenuItem `this` in a1 with `data` in v1, then tScreenUserName `this`
   in v0 with `m` in a2.  The reconstructed member operations reproduce those
   scopes and the complete retail instruction stream.  Their private inline
   identifiers are absent from the optimized SYM, so the descriptive names in
   nfs4_types.h are explicitly inferred rather than claimed as recovered text.

   P879 supersedes the former player/defs workaround: direct arguments and
   the corrected scalar menuDefs interface preserve both byte loads and all 25
   instructions without either caller local or the volatile read. Native
   command/inline-this/data/m records and statement grouping are retained;
   the private inline identifiers remain inferred, not recovered spellings. */

void MenuExtended_EnterUserName(tMenuCommand &command)

{
  /* SYM-INLINE-THIS: SetUserNameData
     SYM-INLINE-LOCAL: data = SetUserNameData */
  menuDefs->menuItemUserName.SetUserNameData(
      FEApp->fInputPlayer, frontEnd.playerNameList[FEApp->fInputPlayer]);
  /* SYM-INLINE-THIS: SetCallingMenu
     SYM-INLINE-LOCAL: m = SetCallingMenu */
  screenUserName->SetCallingMenu(&menuDefs->menuUserName);
  command.type = kMenu_Command_GoToMenu;
  command.nextMenu = (tMenu *)&menuDefs->menuUserName;
  return;
}



/* ---- MenuExtended_GoToShowroom__FR12tMenuCommand  [FEMENUDEFS.CPP:750-753] ---- */

/* Decoded Phase 83: MenuExtended_GoToShowroom__FR12tMenuCommand(tMenuCommand&) - transition to player's garage 3D
   showroom view (64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

/* P874: no caller locals in SYM5b649c; PASS16/exact-g, exact SLD750-753. */
void MenuExtended_GoToShowroom(tMenuCommand &command)

{
  command.type = kMenu_Command_GoToMenu;
  command.nextMenu = &menuDefs->menuShowroom;
  screenCarSelect->SetState(5);
}



/* ---- MenuExtended_GoToDealerShowroom__FR12tMenuCommand  [FEMENUDEFS.CPP:757-760] ---- */

/* Decoded Phase 83: MenuExtended_GoToDealerShowroom__FR12tMenuCommand(tMenuCommand&) - transition to dealer 3D
   showroom view (64 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

/* P874: no caller locals in SYM5b6547; PASS16/exact-g, exact SLD757-760. */
void MenuExtended_GoToDealerShowroom(tMenuCommand &command)

{
  command.type = kMenu_Command_GoToMenu;
  command.nextMenu = &menuDefs->menuShowroom;
  screenCarSelect->SetState(6);
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

void MenuExtended_SetHPSoloRace(tMenuCommand &)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\x01';
  frontEnd.oppNumber = '\0';
  CarIterator_SetFilter(menuDefs->iteratorCar1, 0xb);
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

void MenuExtended_SetHPDuelRace(tMenuCommand &)

{
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\x01';
  frontEnd.oppNumber = '\x01';
  CarIterator_SetFilter(menuDefs->iteratorCar1, 1);
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

void MenuExtended_SetHotPursuit(tMenuCommand &)

{
  frontEnd.carListType = '\0';
  frontEnd.pinkSlipsTrackIndex = '\0';
  frontEnd.raceType = '\x01';
  if (frontEnd.gameMode == '\x01') {
    CarIterator_SetFilter(menuDefs->iteratorCar1, 9);
  }
  else {
    CarIterator_SetFilter(menuDefs->iteratorCar1, 1);
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

/* [W57-A1 2026-08-09, 32->6, count EXACT 86/86] SYM 8c (fsize 200, mask 0x80070000 = ra+s0..s2)
   lists exactly ONE fn-scope local: `money`, class REG $10 = s0, type LONG.  So retail
   ACCUMULATED into it (`money = fMoney; money += CalcUsedPrice(...)`) -- the oracle's
   `addu s0,s0,v0` -- instead of keeping the used-car price in a 4th saved reg and summing at the
   compare (ours was 4 s-regs / frame 208).  That also collapses the `(1<n) || (cheapest <= sum)`
   OR from `slt;xori 1;beqz` to the oracle's direct `slt v0,s0,v0; bnez`.  Plus the `pp` anchor on
   the string/fDefault stores (was sp-relative), and `bVar1 = false` MOVED after the CalcUsedPrice
   statement so gcc emits it into that jal's delay slot instead of at the top of the fn (which
   also fixes the prologue save ORDER: s1,s0,s2,ra).

   [2026-08-26 source-only/SYM restoration, 6 -> PASS 86/86] Removed the remaining
   decompiler aliases: retail SYM names only function-scope `long money`, block-local
   `tDialogYesNo popUp`, and the two inlined receivers.  The comma-staged self-assignment
   is load-bearing: it keeps the retail fMoney load in s0 before CalcUsedPrice while making
   GCC birth the final addition after both GetNumOwnedCars argument moves, so reorg selects
   that addition for the call delay slot.  The source-level tFEApplication::DisplayMessage
   inline restores the line-811 receiver shape.  No asm, volatile, added caller local, or
   post-compilation modification is used. MATCH: 86/86. */

/* [2026-10-15] The retail initial money-read pair permits the field getter:
   ordinary money assignment/accumulation now match without comma staging.
   Credit uses SubtractMoney on the unsigned negated sale result. Getter
   spelling remains inferred. The unnamed callback parameter and implicit
   fallthrough remove unrecorded metadata. Chained SetString/base Display
   preserves the retail inline endpoint; all22 scope pairs and named owners
   match. Full SLD/literal original source text remain unresolved. */
void MenuExtended_SellCar(tMenuCommand &)

{
  long money;
  money = tournamentManager.GetMoney();
  money += carManager.CalcUsedPrice((ushort)(byte)frontEnd.garageCar[0]);
  if ((carManager.GetNumOwnedCars(kPlayerOne) > 1) ||
      (money >= carManager.CheapestCarStockPrice())) {
    tDialogYesNo popUp;

    popUp.SetString(TextSys_Word(0xa5));
    popUp.SetChoices(0x321,0x322,0);
    if (popUp.Run() != 0) {
      tournamentManager.SubtractMoney(
          -(u_long)carManager.SellCar((ushort)(byte)frontEnd.sellerCar,0));
      menuDefs->iteratorSellerCar.Decrement(kPlayerOne);
      menuDefs->iteratorSellerCar.Increment(kPlayerOne);
      AudioCmn_PlayFESFX(0x1a);
    }
  }
  else {
    FEApp->MessagePopup()->SetString(0xa9)->tDialogBase::Display();
  }
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

/* [W57-A1 2026-08-09, 14->7] The oracle uses TWO pseudos for `&FEApp->messagePopup`: s0 (the
   if-arm's "not enough money" store + Display) and s1, a COPY of s0 that reorg steals into the
   `beqz` delay slot for the else-arm.  Reproducing it needs the copy to be a GLOBAL allocno (a
   copy made INSIDE the else block is block-local -> local-alloc's combine_regs merges it right
   back, and the two arms then cross-jump into one tail): so `popUp = dialogAnchor;` is made BEFORE the
   branch and held apart from dialogAnchor with a 0-insn opacity fence (cse otherwise copy-propagates
   dialogAnchor into every popUp use and the split vanishes -- measured 14 either way without it).
   Also the compare written `tournamentManager.fMoney >= carInfo.fPrices[0]` so the money load is
   issued first (05H compare-operand order = load order).  RESIDUAL 7 = the fence blocks reorg's
   backward scan so the copy stays ahead of the branch instead of in its delay slot (+1 insn), and
   the if-arm's `addu a0,s0,zero` lands in a 2nd tail block rather than the `j` slot. */

/* [W59-A12 2026-08-14, 7->0 PASS] The last two residuals were ONE shape each.
   (a) TAIL: both arms must END in their own `Display(); return;` (the else-arm
   de-nested to straight-line fall-out).  gcc then cross-jump-merges the two
   `jal Display`+epilogue tails and each arm keeps only its own receiver setup --
   the if-arm`s `addu a0,s0,zero` rides the `j` delay slot (oracle) instead of our
   old shared-tail form, which parked the STORE in that slot and needed an extra
   `addu a0,s0,zero` block (= the +1 insn, ours 86 vs oracle 85).
   (b) FENCE PLACEMENT: the opacity fence must sit on `dialogAnchor` BEFORE the copy,
   not on `popUp` after it.  Any asm stops reorg`s backward delay-slot scan, so a
   fence AFTER the copy pins `addu s1,s0,zero` ahead of the branch; moved ahead of
   the copy it still keeps the two pseudos apart (cse cannot launder through it)
   while leaving the copy as the last movable insn -> reorg fills the `beqz` slot
   with it, exactly as retail.  Measured: tail-only 47, fence-only 12, no-fence 12,
   BOTH -> PASS 85/85. */

/* [2026-10-15] The historical anchor/fence necessity claims above are
   superseded on the restored method-call source: MessagePopup, Display,
   SetString and SetChoices remove dialogAnchor, pp and the absorption identity
   together at85PASS. Ordinary if/else fallthrough restores recorded receiver
   depths. The unused callback parameter has no retail declaration record;
   leave it unnamed without changing the real reference signature.
   The GetMoney/SubtractMoney operations and split text/base Display now
   recover all27 retail scope pairs and all named declaration owners, still
   85PASS. Getter/mutator literal spellings remain inferred; full SLD is open. */
void MenuExtended_BuyCar(tMenuCommand &)

{
  tCarInfo carInfo;
  tDialogMessageString *popUp;
  popUp = FEApp->MessagePopup();
  carManager.GetStockCar((ushort)(byte)frontEnd.dealerCar,carInfo);
  if (carManager.GetNumOwnedCars(0) < 0x20) {
    if (tournamentManager.GetMoney() >= carInfo.fPrices[0]) {
      tDialogYesNo yesNo;
      yesNo.SetString(TextSys_Word(0xa4));
      yesNo.SetChoices(0x321,0x322,0);
      if (yesNo.Run() != 0) {
        tournamentManager.SubtractMoney(carManager.PurchaseCar(
            (short)carInfo.fCarID,
            (ushort)(byte)frontEnd.carColors[0][carInfo.fCarID],0));
        AudioCmn_PlayFESFX(0x1a);
      }
    }
    else {
      AudioCmn_PlayFESFX(10);
      popUp->SetString(0xa7)->tDialogBase::Display();
    }
  }
  else {
    popUp->SetString(0x4b)->tDialogBase::Display();
  }
}



/* ---- MenuExtended_PurchaseUpgrade  [FEMENUDEFS.CPP:854-877] ---- */

/* Decoded Phase 83: MenuExtended_PurchaseUpgrade(int upgradeIdx) - shared core purchase logic
   called by PurchaseUpgrade1/2/3 wrappers (320 B, 3 callers). Validates cash, debits, applies
   upgrade modifier to current car.
   
   [ghidra-meta] section: front.text */

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
     than before.

     [W56-A3 2026-08-09, 27->2 diffs, count-exact 80/80] The prior "branch polarity flip"
     was NOT reg-alloc noise -- it was ARM ORDER. Oracle lays the yes/no (else) block as the
     FALL-THROUGH and the insufficient-funds message popup at the branch target (bnez, not beqz;
     w42 physical-block-order). Fix = keep `fPrices <= fMoney` semantics but write the arms
     swapped (yesno first / message in else). Then three anchor+sched levers: (a) messagePopup
     anchored via the SYM `this` pointer local -- `dlgThis = &ptVar1->messagePopup` reused for
     the .string store AND the Display arg (w42 anchor, +44/+144 split); (b) MIXED popUp anchor
     -- `pp=&popUp` used ONLY for the two yesnowords stores (oracle anchors those in s0 but keeps
     .string/.fDefault sp-relative; anchoring all or none is each 8 diffs, the split is 4);
     (c) compute `dlgThis` BEFORE the TextSys_Word(0xa8) call so reorg fills that jal's delay slot
     with `addiu s0,s0,44` instead of the arg li.  Reusing the SYM-recorded `upgradeFlag`
     for the bit mask removes the non-SYM `uVar5` carrier without changing code.
     [SOURCE PASS 2026-08-26, 2->0 diffs, 80/80] Keep the affordability test in two tiny
     inlined expressions.  The by-value `++priceIndex` prevents GCC from folding the +1 into
     the final member offset (retail has addiu/sll and offset 48, not sll and offset 52).
     Passing `(fMoney, pricePointer)` then forms the indexed stack address before the manager
     address, while the inlined predicate loads fMoney before dereferencing the price pointer.
     This is pure C++, without asm, volatile, register pins or output rewrites.
     2026-10-15 supersedes the old helper necessity claim: price <= GetMoney()
     with an ordinary upgradeNumber+1 subscript and the real money mutator
     preserves80PASS, without either helper or its three extra parameters.
     Chained SetString/base Display restores text setup independently of display.
     Literal getter spellings/full SLD remain unresolved. */

void MenuExtended_PurchaseUpgrade(int upgradeNumber)

{
  tCarInfo carInfo;
  int upgradeFlag;
  upgradeFlag = 1 << (upgradeNumber);
  carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[0],carInfo,0);
  if ((carInfo.fUpgrades & upgradeFlag) == 0) {
    if (carInfo.fPrices[upgradeNumber + 1] <= tournamentManager.GetMoney()) {
      tDialogYesNo popUp;

      popUp.SetString(TextSys_Word(0xa6));
      popUp.SetChoices(0x321,0x322,0);
      if (popUp.Run() != 0) {
        tournamentManager.SubtractMoney(
            carManager.PurchaseUpgrade((ushort)(byte)frontEnd.garageCar[0],
                                       (short)upgradeFlag,0));
        AudioCmn_PlayFESFX(0x1a);
      }
    }
    else {
      FEApp->MessagePopup()->SetString(0xa8)->tDialogBase::Display();
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

void MenuExtended_PurchaseUpgrade1(tMenuCommand &)

{
  MenuExtended_PurchaseUpgrade(1);
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

void MenuExtended_PurchaseUpgrade2(tMenuCommand &)

{
  MenuExtended_PurchaseUpgrade(2);
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

void MenuExtended_PurchaseUpgrade3(tMenuCommand &)

{
  MenuExtended_PurchaseUpgrade(0);
}



/* ---- MenuExtended_SaveGame__FR12tMenuCommand  [FEMENUDEFS.CPP:898-901] ---- */

/* Decoded Phase 83: MenuExtended_SaveGame__FR12tMenuCommand(tMenuCommand&) - save game state to memcard (80 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [Sig-callgraph 2026-05-08] PRIOR-SESSION ARG LOSS: 0->1. Mangled-name authority + vtable-dispatch
   context (body/caller-prep masked by indirect-call pattern). Generic param names; refine later.
   
   [Sig-fix 2026-05-11 PCSX-runtime R4] Was 'int MenuExtended_SaveGame__FR12tMenuCommand(int arg0)'.Fixed via m2c body (arg0 = struct deref) + PCSX runtime (a0 = consistent ptr) + sibling pattern.
    */

void MenuExtended_SaveGame(tMenuCommand &)

{
  if ((CURRENTLYUSINGMEMCARD == 0) &&
     MenuItem_IsEnabled(menuDefs->itemSaveGame)) {
    GenericMenuSaveGame(0);
  }
}



/* ---- GenericMenuLoadGame  [FEMENUDEFS.CPP:922-941] ---- */

/* Decoded Phase 86: FE-GenericMenuLoadGame (148 B): execute generic load-game flow from
   menu.
   
   [ghidra-meta] section: front.text */

/* MATCH (2026-08-13, 8->PASS, 37/37): a zero-byte memory-input fence births FEApp's address
   quantity before screenMemcard's, giving retail s0/s1. Explicit app-then-mc volatile reloads
   on both sides of LoadGame reproduce retail's value registers and scheduling. */

void GenericMenuLoadGame(int player)
{
  if (CURRENTLYUSINGMEMCARD == 0) {

    screenMemcard->SetMessage(0x27d);
    FEApp->Redraw();
    LoadGame((short)player,false,1);
    screenMemcard->SetMessage(-1);
    ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();










  }
  ((tDialogBase *)&FEApp->NoInputMemCardDialog)->Hide();
}



/* ---- MenuExtended_LoadGame__FR12tMenuCommand  [FEMENUDEFS.CPP:945-957] ---- */

/* Decoded Phase 83: MenuExtended_LoadGame__FR12tMenuCommand(tMenuCommand&) - load save from memcard via Front_*;
   populate game state (152 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text
   
   [SYM restoration 2026-08-26, PASS 38/38] The `FR12tMenuCommand` linkage proves
   the callback's reference parameter; the missing REGPARM record does not
   recover its original source spelling. The early-return guard keeps the sole
   SYM AUTO (`tDialogYesNo AreYouSure`, 168 bytes at sp+16) in function scope but
   constructs it only on the enabled path.  `SetChoices` reconstructs the SYM's
   inlined tDialogYesNo receiver in s0; the original private helper identifier is
   not recoverable.  Consuming Run directly removes the decompiler-invented result
   local.
   SOURCE-REVIEW-UNRESOLVED (2026-10-15): tMenuCommand() is an unproved
   frame-padding temporary, not recovered original source. It supplies8 bytes
   and one extra native scope absent from retail. Removing it with ordinary
   dialog methods or an actual IsDisabled member guard preserves38 words but
   shortens frame200to192 (12 differences). Failed probes restored; the real
   slot producer still needs recovery. Normal PASS is not a native/SLD seal,
   and no substitute dummy object, zero identity or fake use is justified. */

void MenuExtended_LoadGame(tMenuCommand &)
{
  if (MenuItem_IsDisabled(menuDefs->itemLoadGame)) {
    return;
  }
  tDialogYesNo AreYouSure;
  tMenuCommand();
  Dialog_SetText(AreYouSure.SetChoices(0x321, 0x322, 0), TextSys_Word(0x2c0));
  if (AreYouSure.Run() != 0) {
    GenericMenuLoadGame((int)screenMemcard->player);
  }
}



/* ---- MenuExtended_TierFinished__FR12tMenuCommand  [FEMENUDEFS.CPP:960-976] ---- */

/* Decoded Phase 83: MenuExtended_TierFinished__FR12tMenuCommand(tMenuCommand&) - tournament tier complete; advance to
   next tier (128 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [Match 2026-07-05] Branch-polarity flip (oracle emits the else/congrats block as
   fall-through, the if/AskUser block as the branch target -- both nested ifs written
   inverted vs the natural Ghidra reading) -> byte-match, 32/32 insns.
   [SYM 2026-08-25] Retail declares only `command` and stack `award`; direct
   predicate use plus branch-local command.nextMenu assignments remove the former
   iVar1/ptVar2 while preserving exact PASS 32/32 and the exact -g twin. */

void MenuExtended_TierFinished(tMenuCommand &command)

{
  tAwardInformation award;
  
  command.type = kMenu_Command_GoToMenuOneWay;
  tournamentManager.GetAwardInformation(award);
  if (award.fCompletedTier != 0) {
    command.nextMenu = (tMenu *)&menuDefs->menuTierCompleteCongrats;
  }
  else {
    if (AskTheUserToSaveTheGame() != 0) {
      command.nextMenu = (tMenu*)&menuDefs->menuPostGameSave;
    }
    else {
      command.nextMenu = (tMenu*)&menuDefs->menuMain;
    }
  }
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

/* [W57-A1 2026-08-09, 71->PASS] see the SYM note in the body: real `result` local (SYM class REG
   $13 = s3, type BOOL) + FULLY NESTED ifs with ONE `return result;`.  The early-return form was
   tried first and FAILED (28 diffs): with per-guard `return result;` gcc const-propagates the
   provably-0 value into each exit (`addu v0,zero,zero`), which SHORTENS result's live range so it
   coalesces with `activateCar` into one saved reg (3 s-regs / frame 240 vs the oracle's 4 / 248).
   The single-return form keeps result live across the GetCarFromID block -> the two conflict ->
   separate regs, and reorg then STEALS the shared epilogue's `addu v0,s3,zero` into each guard's
   delay slot, reproducing all four copies.  Also `(signed char)` on carInfo.fCarID and on
   frontEnd.carCountry[0][id] where they feed the INDEX arithmetic (oracle `lb`, ours `lbu`; the
   later byte-COPY of the same field legitimately stays `lbu` -- 08C), and the perp compare
   written `finalPerpArrests > numPerps` so the 440 load is issued before the 428 one.
   Return type corrected void*->int (SYM BOOL; not declared in any header, single in-TU caller). */

/* [SYM 2026-08-16] retail `Def class STAT type FCN BOOL` @0x8002d9e8 -> bool (the earlier
   void*->int correction stopped one step short); STAT confirms the `static`. */
static bool MenuExtended_DidUserWinBeTheCop(void)

{
  tCarInfo carInfo;
  tCarInfo *activateCar;
  bool result;

  /* [W57-A1] SYM 8c budget (fsize 248, mask 0x800f0000): exactly TWO named locals besides
     carInfo -- activateCar (class REG $10 = s0) and result (class REG $13 = s3, SYM BOOL;
     this compiler's C++ `bool`).  The old `pvVar1 = 0` repeated inside an `&&` chain never produced a
     long-lived result pseudo (it landed in $a0); a real `result` local + flat early-return
     guard chain (04T `return VARIABLE;` keeps DISTINCT return sites -> the oracle's
     `addu v0,s3,zero` in each guard's delay slot) reproduces the 4-saved-reg frame. */
  result = 0;
  carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[0],carInfo);
  if (carInfo.fCarClass == '\a') {
    if (frontEnd.raceType == RaceType_HotPursuit) {
      if (frontEnd.gameMode != '\x01') {
        if (GameSetup_gData.finalPerpArrests > GameSetup_gData.numPerps) {
          activateCar = carManager.GetCarFromID(
                                     (short)gCarActivation[(signed char)carInfo.fCarID + -0x16]
                                         [(signed char)frontEnd.carCountry[0][(signed char)carInfo.fCarID]]);
          if (activateCar->fAvailable == '\0') {
            carManager.SetCarAvailable((tCarModels)activateCar->fCarID,true);
            frontEnd.congratsCopCar = activateCar->fCarID;
            frontEnd.congratsCopCountry = frontEnd.carCountry[0][(signed char)carInfo.fCarID];
            result = 1;
          }
        }
      }
    }
  }
  return result;
}



/* ---- MenuExtended_PostGameMenu__FR12tMenuCommand  [FEMENUDEFS.CPP:1040-1082] ---- */

/* Decoded Phase 83: MenuExtended_PostGameMenu__FR12tMenuCommand(tMenuCommand&) - show post-game menu(continue/save/restart/quit) (256 B)
   
   [ghidra-meta] section: front.text */

/* [SYM restoration 2026-08-26, PASS 64/64] Retail records only the `command`
   REGPARM in s0.  Both call results are consumed directly.  The two nested
   `this` records in v1 are restored by the inline SetDrawMoney operation; SYM
   preserves its receiver type and store but not the private helper identifier.
   Direct per-case nextMenu assignments remove the decompiler's synthetic menu
   pointer and let gcc cross-jump their identical store/return tails exactly as
   retail did. The case order2/6/1 and case-1 fallthrough preserve dispatch.
   2026-10-15: an explicit case2 if/else with break recovers both receiver
   owners and all10 retail scope pairs at64PASS. Retail EXT5c91d6 returns
   SHORT, not BOOL: correct the owner-specific import and use its real type.
   Native declaration/tree exactness is not complete SLD/source-text proof. */

void MenuExtended_PostGameMenu(tMenuCommand &command)

{
  StatChk_ClearNewRecords();
  command.type = kMenu_Command_GoToMenuOneWay;
  switch (frontEnd.raceType) {
  case 2:
    if (tournamentManager.IsTournamentFinished() != 0) {
      command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuTournamentFinished;
      /* SYM-INLINE-THIS: SetDrawMoney */
      screenTournamentStandings->SetDrawMoney();
    }
    else {
      command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuTournamentStandings;
      screenTournamentStandings3item->SetDrawMoney();
    }
    break;
  case 6:
    command.nextMenu = (tMenu *)&menuDefs->menuPinkSlipStandings;
    return;
  case 1:
    if (MenuExtended_DidUserWinBeTheCop()) {
      command.nextMenu = (tMenu *)&menuDefs->menuBeTheCopCongrats;
      return;
    }
    /* fall through */
  default:
    command.nextMenu = (tMenu *)&menuDefs->menuMain;
  }
  return;
}



/* ---- MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand  [FEMENUDEFS.CPP:1090-1120] ---- */

/* Decoded Phase 83: MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand(tMenuCommand&) - after race, prompt P1 for
   name entry (high score etc) (272 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

/* [W57-A1 2026-08-09, 57->PASS] Three levers: (1) the if/else ARMS SWAPPED to
   `if (needName[1] != 0 && gotName[1] == 0) {name-entry} else {records}` -- the oracle's two
   guards both branch AWAY to the records block, so the name-entry block is the fall-through and
   is laid out FIRST; (2) `dlgThis = &ptVar2->menuItemUserName2` ANCHOR (oracle holds
   `addiu v1,a0,12868` and stores at 128/28/32/36/34(v1); ours emitted absolute 12996/12896/...
   off the menuDefs base); (3) `ptVar2 = menuDefs[0]` moved INSIDE that arm, which drops the
   `lui s3` hoist (an entire 4th saved reg + 8 bytes of frame). */
/* [SYM restoration 2026-08-26, PASS 68/68] Reliable caller identities are
   command/dummyCars/nBestCarIndex.  The records arm now genuinely assigns and
   reuses dummyCars while its two call-result temporaries fold away.  The
   post-game name setup is one inferred SetPostGameNameData expansion followed
   by SetCallingMenu (including its recorded `m` formal). P879's corrected
   scalar menuDefs context makes direct repeated member access exact at 68/68;
   the obsolete defs carrier and its earlier context-specific miss are gone. */

void MenuExtended_FinishedPlayer1GetName(tMenuCommand &command)

{
  /* SYM: dummyCars and nBestCarIndex belong to the else block, not fn scope. */
  command.type = kMenu_Command_GoToMenuOneWay;
  if ((FEApp->needName[1] != 0) && (FEApp->gotName[1] == 0)) {
    /* SYM-INLINE-THIS: SetPostGameNameData */
    menuDefs->menuItemUserName2.SetPostGameNameData(
        1, frontEnd.playerNameList[1]);   /* retail frontEnd+0x36c (same defect as feapp MainLoop) */
    /* SYM-INLINE-THIS: SetCallingMenu
       SYM-INLINE-LOCAL: m = SetCallingMenu */
    screenUserName->SetCallingMenu(&menuDefs->menuPostGamePlayer2Name);
    command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuPostGamePlayer2Name;
  }
  else {
    Car_tStats *dummyCars;
    short nBestCarIndex;

    dummyCars = Cars_NewCarStatsList();
    if (StatChk_IsRecordLapTime(dummyCars,(short)Cars_gNumRaceCars,&nBestCarIndex)) {
      StatChk_SaveRecordLapTime(dummyCars,(short)Cars_gNumRaceCars,nBestCarIndex);
    }
    if (StatChk_IsTopTime(dummyCars,(short)Cars_gNumRaceCars) != 0) {
      StatChk_SaveTopTime(dummyCars,(short)Cars_gNumRaceCars);
    }
    command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuPostGameTrackRecords;
  }
  return;
}



/* ---- MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand  [FEMENUDEFS.CPP:1125-1142] ---- */

/* Decoded Phase 83: MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand(tMenuCommand&) - after race, prompt P2 for
   name entry (160 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer
   
   [ghidra-meta] section: front.text */

void MenuExtended_FinishedPlayer2GetName(tMenuCommand &command)

{
  /* P879: direct scalar menuDefs use removes the unrecorded final-menu base. */
  Car_tStats *dummyCars;
  short nBestCarIndex;

  /* SYM: `dummyCars` is the real REG Car_tStats pointer in $s1 and is reused
     across all four stat-tool calls; `nBestCarIndex` is its recorded AUTO. */
  dummyCars = Cars_NewCarStatsList();
  if (StatChk_IsRecordLapTime(dummyCars,(short)Cars_gNumRaceCars,&nBestCarIndex)) {
    StatChk_SaveRecordLapTime(dummyCars,(short)Cars_gNumRaceCars,nBestCarIndex);
  }
  if (StatChk_IsTopTime(dummyCars,(short)Cars_gNumRaceCars) != 0) {
    StatChk_SaveTopTime(dummyCars,(short)Cars_gNumRaceCars);
  }
  command.type = kMenu_Command_GoToMenuOneWay;
  command.nextMenu = (tMenu *)(tMenu*)&menuDefs->menuPostGameTrackRecords;
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

void MenuExtended_SetPinkSlips(tMenuCommand &)

{
  short i;

  screenMain->SwapBackground(-1);
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

/* 2026-10-14: ordinary string/word setters, the Winner getter, original
   short-parameter manager methods and condition-tested polling restore all
   nine retail declarations/owners and all 19 scopes at 138 instructions PASS.
   dlgThis3/dialogAnchor/playerNum, the manager identity/tied-player fences,
   and the three asm-name int-argument aliases are removed, not required by
   their old source-basin failures. mess is the recorded string-setter pointer
   parameter, not a caller snapshot of the formatting word. Only ordinary
   scope destruction runs: no manual second destructor or terminal return.
   Winner's literal getter name and word-setter signature remain inferred;
   full statement-line attribution is still under restoration. */

void MenuExtended_AwardPinkSlipsCar(tMenuCommand &command)

{
  char string [80];
  tDialogYesNo RetryCancelDialog;
  int fWinner;
  tCarInfo carInfo;
  RetryCancelDialog.SetChoices(0x291,0x292,1);
  fWinner = screenPinkSlipCongrats->Winner();
  sprintf(string,TextSys_Word(0x29a),PlayerName(fWinner),fWinner + 1);
  FEApp->NoInputMemCardDialog.SetString(string)->tDialogBase::Display();
  while (!Dialog_FullyOpen(&FEApp->NoInputMemCardDialog)) {
    FEApp->Redraw();
  }
  FEApp->Redraw();
  Init_Memcard(false,1);
  carManager.GetPinkSlipsCar((ushort)(byte)frontEnd.pinkSlipsCar[1 - fWinner],carInfo,
             (short)(1 - fWinner));
  carManager.AddToPinkSlipsList(carInfo.fCarID, carInfo.fColor, fWinner);
  carManager.AddUpgradesToPinkSlipsList(frontEnd.pinkSlipsCar[fWinner],carInfo.fUpgrades,fWinner);
  SavePinkSlipsCarsWithErrorDialogs(fWinner,2,-1);
  FEApp->NoInputMemCardDialog.tDialogBase::Hide();
  command.type = kMenu_Command_GoToMenuOneWay;
  command.nextMenu = &menuDefs->menuMain;
  FEApp->NoInputMemCardDialog.SetString(0x274);
  FEApp->NoInputMemCardDialog.tDialogBase::Display();
  while (!Dialog_FullyOpen(&FEApp->NoInputMemCardDialog)) {
    FEApp->Redraw();
  }
  FEApp->Redraw();
  GenericMenuLoadGame(0);
  DeInit_Memcard();
  FEApp->NoInputMemCardDialog.tDialogBase::Hide();
  command.type = kMenu_Command_GoToMenuOneWay;
  command.nextMenu = &menuDefs->menuMain;
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

/* P873: with native scalar screenCarSelect, the old ternary becomes FAIL8
   at 42/42. The explicit if/else assignments below restore PASS42 and
   the retail SLD1228/1229/1230 condition/then/else partition. The existing
   garageIterator carrier still represents an unrecovered inline this scope. */
void MenuExtended_GoToGarage(tMenuCommand &command)
{
  frontEnd.carListType = '\x01';
  menuDefs->iteratorGarageCar.SetFilter(0x40);
  menuDefs->iteratorGarageCar.tListIteratorCar::Decrement(kPlayerBoth);
  menuDefs->iteratorGarageCar.Increment(kPlayerBoth);
  command.type = kMenu_Command_GoToMenu;
  if (Tournament_CurrentTrack(tournamentManager) == 0) {
    command.nextMenu = (tMenu *)&menuDefs->menuCarGarage;
  } else {
    command.nextMenu = (tMenu *)&menuDefs->menuPostCarGarage;
  }
  screenCarSelect->SetState(1);
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

void MenuExtended_GoToTournTrophyRoom(tMenuCommand &)

{
  frontEnd.tier = '\0';
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

void MenuExtended_GoToSETrophyRoom(tMenuCommand &)

{
  frontEnd.tier = '\x01';
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

void MenuExtended_SetBeginner(tMenuCommand &)

{
  frontEnd.skillLevel = '\0';
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

void MenuExtended_SetIntermediate(tMenuCommand &)

{
  frontEnd.skillLevel = '\x01';
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

void MenuExtended_SetExpert(tMenuCommand &)

{
  frontEnd.skillLevel = '\x02';
}



/* ---- MenuExtended_ExitTourney__FR12tMenuCommand  [FEMENUDEFS.CPP:1260-1271] ---- */

/* Decoded Phase 83: MenuExtended_ExitTourney__FR12tMenuCommand(tMenuCommand&) - abandon current tournament, return to
   main menu (144 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [SYM restoration 2026-08-25] The caller SYM records only `command` and the
   stack object `AreYouSure`.  Consuming Run directly removes the unrecorded
   result local at exact 36/36.  Spelling nextMenu before type removes the
   unrecorded menu pointer while the scheduler retains retail's type-first
   store order. P880 removes the remaining dialog carrier through the existing
   inline setup boundary; raw direct field stores alone did not preserve it. */

/* 2026-10-15: ordinary void fallthrough removes the extra destructor contour
   at36PASS; no scope wrapper or replacement variable is required. */
void MenuExtended_ExitTourney(tMenuCommand &command)

{
  tDialogYesNo AreYouSure;
  AreYouSure.SetChoices(0x321,0x322,0);
  AreYouSure.SetString(TextSys_Word(0x9d));
  if (AreYouSure.Run() != 0) {
    command.nextMenu = &menuDefs->menuMain;
    command.type = kMenu_Command_GoToMenuOneWay;
  }
  else {
    command.type = kMenu_Command_None;
  }
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

/* [W57-A1 2026-08-09, 18->PASS] Two levers: (a) GOTO BACK-EDGE loop (`nextPlayer: if (player<2)
   {...; goto nextPlayer;}`) instead of `while(true){if(2<=p)break;...}` -- it defeats LICM's
   hoist of `%hi(FEApp)` into a 4th saved reg (s3), which was the whole +2-insn / extra-s-reg
   delta; (b) the loop-invariant `&string` hoisted BY HAND into `msg` before the loop, because the
   same goto shape also suppresses LICM for THAT address (oracle materializes `addiu s2,sp,184`
   once, pre-loop).  So: LICM off for the global, on (manually) for the frame address. */

/* [2026-10-15] Real for-loop and dialog SetString remove msg at76PASS.
   Retail's player belongs to the for region, not a caller-level counter.
   Implicit void fallthrough removes the extra destructor contour. The older
   goto/hand-hoisted-address necessity claim above was source-shape-relative;
   no artificial scope, new helper name or replacement pointer is required. */
void MenuExtended_ExitPinkSlipsEarly(tMenuCommand &command)

{
  tDialogYesNo AreYouSure;
  
  AreYouSure.SetChoices(0x321,0x322,0);
  AreYouSure.SetString(TextSys_Word(0x9d));
  if (AreYouSure.Run() != 0) {
    char string [80];

    Init_Memcard(false,1);
    for (int player = 0; player < 2; player++) {
      sprintf(string,TextSys_Word(0x297),PlayerName(player),player + 1);
      FEApp->NoInputMemCardDialog.SetString(string);
      SavePinkSlipsCarsWithErrorDialogs((short)player,1,-1);
    }
    DeInit_Memcard();
    FEApp->NoInputMemCardDialog.tDialogBase::Hide();
    command.type = kMenu_Command_GoToMenuOneWay;
    command.nextMenu = &menuDefs->menuMain;
    frontEnd.raceType = '\0';
  }
}



/* ---- MenuExtended_PinkSlipsContinue__FR12tMenuCommand  [FEMENUDEFS.CPP:1304-1315] ---- */

/* Decoded Phase 83: MenuExtended_PinkSlipsContinue__FR12tMenuCommand(tMenuCommand&) - after pinkslips win, continue
   to next race (108 B)
   [zero direct xref] Menu command callback - registered via tMenuCommand fn pointer

   [ghidra-meta] section: front.text

   [SYM/source 2026-08-25] Retail records only `command`. Repeating the promoted
   track-threshold expression lets GCC CSE it while retaining signed `slt` for
   both byte-field comparisons. Spelling nextMenu before type loads menuDefs only
   on the GoToMenuOneWay path and removes ptVar1. The physical block-order swap
   (else-body first, win-body reached via the trailing goto) preserves retail
   polarity. This local-free form is exact PASS 27/27 with an exact -g twin. */

void MenuExtended_PinkSlipsContinue(tMenuCommand &command)

{
  if ((byte)frontEnd.pinkSlipsWins[0] <
      ((byte)frontEnd.pinkSlipsNumTracks >> 1) + 1) {
    if ((byte)frontEnd.pinkSlipsWins[1] <
        ((byte)frontEnd.pinkSlipsNumTracks >> 1) + 1) {
      goto winCase;
    }
  }
  command.nextMenu = (tMenu *)&menuDefs->menuPinkSlipCongrats;
  command.type = kMenu_Command_GoToMenuOneWay;
  return;
winCase:
  frontEnd.pinkSlipsTrackIndex = frontEnd.pinkSlipsTrackIndex + '\x01';
  command.type = kMenu_Command_StartRace;
  return;
}



/* ---- tGlobalMenuDefs::ctor  [FEMENUDEFS.CPP:1353-2200] ---- */

/* [W59-A12 2026-08-14] CTOR DIFF-SHAPE DIAGNOSIS -- re-gated 3365 (the 5176/86.19%
   board row is stale).  ours 3180 insns / oracle 3207.  THIS IS NOT A DATA PROBLEM:
     * the `jal` MULTISET *and* the `jal` ORDER are IDENTICAL (254 calls, same targets,
       same counts, same sequence) -- the 254 sub-object constructions are already in
       retail order with retail's arguments;
     * erase spill-slot numbers and register names from both streams and only 729 of
       2619 normalized diffs survive => ~63% of the mass is REGISTER NAMING, ~11% is
       spill-slot NUMBERING, ~26% is structure/scheduling;
     * register confusion matrix over the aligned stream: 4884 register slots compared,
       82.1% identical; the mismatches are dominated by ONE GLOBAL t0<->t1 rotation
       (587 slots) plus s2<->s3 (45+) -- a single allocation-order phase difference,
       not 250 independent errors.  Dest-register histograms are otherwise equal
       (ours t1 634 / t0 618 / s2 77, oracle t1 644 / t0 633 / s3 75).
   FRAME (SYM 8c: fp=29 fsize=640 retreg=31 mask=$c0ff0000 = s0-s7+fp+ra, both sides):
   the oracle's spill area is 72..592 (131 slots), ours 128..596 (118).  The 13-slot
   deficit is why `compilerFramePad[56]` exists: it restores the 640-byte total so the
   245 `lw ...,640(sp)` this-reloads and the whole prologue/epilogue match.  Pad swept
   4,8,16,24,32,40,48,52,56,60,64,72,80,108,112 -> 52/56 are the optimum (3365); 32/40
   =3595, 4/8=3703, 16=3745.  The deficit itself is visible alignment-free: the oracle
   has +13 `sw N(sp)` / +12 `lw N(sp)` exactly where ours has +18 `addu R,R,R` and
   rematerialized constants (`li 0x80` x4, `li 50`) -- retail SPILLS long-lived member
   addresses and parks constants in callee-saved regs, we copy/rematerialize.
   SLD (only 22 records): line 1353 covers insns 0..920, 2163 covers 921..3128,
   2168-2172 are the FIVE SetDimensions calls (the last five calls in the function),
   2200 the trailing store block, 2180 is emitted last.  Our body-statement order
   already reproduces retail's tail exactly (child stores, 5x SetDimensions, the four
   fCarListFilter stores, the VertHelp block with the fFlags|=0x40 in the middle).
   SYM: 36 inline-ctor `this` records plus root `this` ARG:sp+0, total 37;
   also 3 `tMenu *child` REG $2, total 40 named records -> three fChildMenu
   stores were an inline SetChildMenu-style member call (codegen-identical here).
   FALSIFIED this wave (measured, all reverted): (a) moving the two
   tInsideBoxControllerLeftRightSlider vptr stores INLINE to their objects'
   construction via a comma-expression in the next member's args = 3467 (worse);
   first-only = 3523; dropping them entirely = 3361 but semantically wrong (the vptr
   would never be set).  (b) `(tMenuItem *)this` -> `(tMenuItem *)&itemMainOnePlayerRace`
   in menuMain = codegen-neutral.  (c) moving the two vptr stores to the end of the
   body = codegen-neutral.
   HISTORICAL ANGLE: the local-only explanation below is not valid currently.
   Verified 2026-10-14: global allocation evicts local s2 for itemTrack4; CSE
   splits and local handouts determine its victims. See sym-match.md receipts
   and diff the QTY order at the FIRST divergence (our insn 41 / oracle 42): ours emits
   TWO `lw this,640(sp)` and keeps this+0x58 in a caller-saved temp, retail emits ONE
   and parks this+0x58 in s3 across the call because menuMain later takes
   &itemMainTrophyRoom (lever #16 shape, but it must be dialed at the QTY layer).
   SHARED-HEADER REPORT (not applied -- nfs4_types.h is report-only for this agent):
   nfs4_types.h:4894 `tInsideBoxControllerLeftRightSlider(unsigned int, tListIterator*)`
   does NOT set its vptr, which is why this file sets it from the body.  Retail sets it
   INSIDE the object's construction: oracle 0x80030ADC/0x80030AFC/0x80030B34
   `lui/addiu $s0,%hi/%lo(_vt_35tInsideBoxControllerLeftRightSlider); sw $s0,0x18(obj)`
   immediately after the `jal __25tInsideBoxLeftRightSliderUiP13tListIterator` base
   ctor -- exactly what the sibling ctors at nfs4_types.h:4577 / :4586 already do for
   tMenuItemOptionsLeftRightChoice / tMenuItemOptionsTwoItemChoice.  Recommended diff:
   add `{ *(void **)&_base_tInsideBoxLeftRightSlider._vf =
   (void *)&tInsideBoxControllerLeftRightSlider_vtable; }` to that ctor and delete the
   two body stores here.  (Probed indirectly via the comma-expression form above, which
   is NOT the same shape -- the header form is untested and may re-basin the fn.)

   [W64-A16 2026-08-15] Re-gated on a fresh --skip-asm build: 3365 (3180/3207),
   unchanged from W59-A12 / W63-A16; the board's 86.19% row is stale (it is not a
   residual count).  Nothing probed this wave; the two live receipts stand and are
   NOT re-opened: (a) W63-A16's alpha-rename triage -- renaming every register to a
   per-stream first-appearance index does not move the LCS diff by one instruction
   (1744 raw == 1744 alpha), so the residual is NOT an allocator rotation and every
   qty/allocno instrument is the wrong tool here; (b) the frame receipt -- retail's
   spill area is 72..592 and ours 128..596, and a DECLARED local can never occupy
   72..127 because gcc assigns declared locals at expand and reload spill slots
   later from one upward-growing frame_offset, so `compilerFramePad` necessarily
   buys the 640 total at the price of mis-siting every spill.  The open angle is
   still the one named above: retail derives N sub-object addresses from ONE
   `lw this,640(sp)` with FRESH destinations (`addiu s3,t1,88` / `addiu t0,t1,388`)
   while we mutate the reload in place and re-load `this` per address -- a
   post-RELOAD effect on compiler-generated `this + offset` operands of an
   initializer list, i.e. not spellable from the init list itself.  The
   highest-value remaining action is the SHARED-HEADER diff recommended above
   (move the tInsideBoxControllerLeftRightSlider vptr store into its own ctor in
   nfs4_types.h); it is deliberately NOT applied here -- a shared-header edit
   mid-wave forces a full-tree re-gate and would collide with concurrent belts.

   [W71-A16 2026-08-21] !!! EVERYTHING ABOVE THAT CALLS THIS FN "ALLOCATOR-BOUND"
   WAS WRONG.  The residual was NOT coloring -- FOUR ARGUMENTS WERE SEMANTICALLY
   WRONG, and each wrong argument destroyed a compiler ADDRESS-CSE ANCHOR that
   retail derives dozens of later frontEnd field addresses from.  Baseline 3473
   (3182/3207) -> 1840 (3199/3207), TU 65/66 PASS throughout, ZERO regressions.
   THE INSTRUMENT that found them (reusable, ~40 lines, scratchpad/A16_*.py):
   diff the ORDERED %hi(SYM) reloc sequence of our object (objdump -dr via
   tools/ourdis.py, R_MIPS_HI16 lines) against the oracle's %hi(...) sequence,
   then re-window it PER `jal` so every ctor call gets its own symbol multiset.
   verify_asm is reloc-NAME lenient and LO16-zeroing, so a wrong argument that
   still resolves to *some* symbol is INVISIBLE to the gate -- only the symbol
   COUNT/identity audit sees it.  Run this audit on ANY data-driven ctor before
   touching the allocator.
   THE FOUR BUGS (oracle addresses; frontEnd = 0x80114600):
     * iteratorTournament  arg1 was `(char *)&menuHotPursuit` (a this-relative
       member!) -- retail passes `&frontEnd.tournament`   (D_80114720 = fE+0x120)
     * iteratorSpecialEvent arg1 was `(char *)&menuTournament`
       -- retail passes `&frontEnd.specialevent`          (D_80114720 + 1)
     * iteratorColor       arg1 was `(char *)&iteratorCar1`
       -- retail passes `frontEnd.carColors[0]`           (D_80114660 = fE+0x60)
     * iteratorDealerColor arg1 was `(char *)&iteratorDealerCar` -- same fix.
   WHY ONE OF THEM WAS WORTH ~1500 DIFFS: gcc-2.8 CSEs a struct-address into ONE
   `lui/addiu` ANCHOR and reaches every other field of that struct with a single
   `addiu rD,anchor,delta` (delta may be NEGATIVE).  Retail's anchor is
   frontEnd+0x120, established by the FIRST frontEnd address in the function --
   the iteratorTournament argument.  With that argument wrong we anchored
   elsewhere, so all ~55 later frontEnd field materializations used different
   deltas.  Post-fix our anchor deltas are byte-identical to retail's
   (-0xFD/-0xF3/-0xEE/-0xE9/-0x10A/-0x105 ...) and `%hi(frontEnd)` count is
   55 == 55.  Also fixed (§3.12 #12, gate-invisible because the LO16 addend is
   normalized away): an earlier relocation-only inference said
   MenuExtended_GoToDealer / _GoToSeller / _GoToUpgrades should not be
   `static`.  CORRECTED 2026-08-25: trusted SYM records all three as class
   STAT, so file-local linkage is the original source and is retained.
   FRAME: with the arg fixes the natural spill area GREW, so the pad optimum moved
   52/56 -> 25..32 (all give 1840; 33 -> 2518, 0 -> 1974).  It is now 32.  Our
   spills sit at 104..596 vs retail 72..592 -- a 32-byte (8-slot) deficit, i.e.
   retail still spills 8 more pseudos than we do.  Costed offline: re-siting the
   spills alone is worth ~440 of the remaining ~1740 LCS units.
   REMAINING 1840, decomposed offline (LCS units, base 1740):
     ~440  spill-slot NUMBERING  (the 32-byte pad offset; needs 8 real spills)
     ~930  register naming, almost all a t0<->t1 PHASE that is now correct for
           insns 0..1085 and flips only 32 times (was 60+); s2, s3, s0 and the a/v regs now
           match EXACTLY (s3 121==121, s2 5==5) -- the old "s2<->s3 rotation"
           receipt is DEAD, it was a symptom of the anchor bug.
     ~274  genuine structure, in 98 runs of 1-3 insns.
   THE THREE SURVIVING STRUCTURAL SHAPES (all allocator-side, none spellable from
   an initializer list -- documented so the next wave does not re-derive them):
     1. fp TIE-BREAK: ours parks `this+0x20D8` (&menuCarOptions) in $fp and needs
        no spill; retail parks `this+0x12E8` (&itemGarageCar) and SPILLS the other
        (`sw t0,268(sp)` + reloads).  Reference counts and offsets are identical
        on both sides, so this is a pure global_alloc priority tie-break.
     2. %hi(FEApp) HOIST: retail keeps `%hi(FEApp)` in $s0 across the last six
        tListIteratorRangeIndexed ctors and re-does only `lw v0,%lo(FEApp)($s0)`;
        we emit a fresh `lui` each time (+6 lui = the whole `lui` delta 244 vs
        238).  Same family as catalog §A row 41 but the anchor is compiler-made.
     3. TAIL POINTER-REUSE: retail writes menuMemory/menuUserName VertHelp through
        SPILLED member pointers (`lw t1,0x234(sp); nop; sh zero,0x64(t1)` -- both
        oracle `nop`s live here) where we use `sh zero,12560(this)`.  Our tail
        statement ORDER already matches retail; gcc merely sinks our
        `ori v1,v1,64; sw v1,0x35AC` to the epilogue.  Three tail reorderings were
        measured (compound |=, flags-first, split temp) -- all 1840 or worse.
   FALSIFIED THIS WAVE (do not retry): pad sizes 0..96 in steps of 4 plus 25..35
   (32 is optimal); `int` pad instead of `char`; the `__asm__` frame anchor moved
   to the top of the body; the three `child` blocks flattened to direct stores;
   the three tail reorderings above.
   NEXT: (a) the shared-header tInsideBoxControllerLeftRightSlider vptr diff still
   stands (see above, still not applied); (b) the only lever left with real mass is
   making gcc spill 8 more pseudos so the pad can go to 0 and the whole spill area
   re-sites -- that is a register-pressure question, not a source-text one.

   [W72-A6 2026-08-22]  1840 -> 1257 (-583, -32%), TU 65/66 PASS throughout,
   ZERO regressions.  W71-A16's item (b) is DONE: the extra spills were bought,
   `compilerFramePad` is GONE, and the frame is now 640 == 640 NATURALLY.
   Metrics (all from scratchpad/W72_A6_metric.py -- LCS on the verify_asm streams
   under four normalizations; the last one is the true structural residual):
                        insns    raw   reg-blind   reg+spill-blind
     W71-A16 base        3199   1740      938           206
     W72-A6 landed       3214   1169      275           207   (oracle 3207)
   1. THE %hi AUDIT WAS RE-RUN AND IS CLEAN -- no more wrong arguments.
      scratchpad/W72_A6_hiaudit.py upgrades A16_callaudit.py from a per-`jal`
      HI16 *count* check to an ordered RESOLVED-ADDRESS diff: every (%hi,%lo)
      pair on both sides is resolved to an absolute address (symbol_addrs +
      D_xxxxxxxx + the addend split across the HI16/LO16 immediates) and the two
      sequences are diffed.  237 oracle sites vs 243 ours; after mapping our
      `Foo_vtable` spelling onto the oracle's `_vt_<len><Foo>` the ONLY multiset
      deltas are FEApp (+6, shape #2 below) and a 3-for-3 anchor swap
      (frontEnd+0x5E vs frontEnd+0x320, same FINAL addresses).  D_800114D8 /
      D_80011530 are just unnamed `_vt_32tBlankMenuItemGoToMenuNFS4Button` /
      `_vt_33tBlankMenuItemNFS4LeftRightChoice` (proved from
      asm/data/rdata_80010000_r04.rodata.s) -- a symbol_addrs naming gap, not a bug.
      scratchpad/W72_A6_immaudit.py does the SAME audit for the this-relative
      arguments the %hi audit cannot see (register-blind ordered `addiu rD,rS,K`
      and `li rD,K` sequences): 494 vs 492 addiu sites, multiset delta = only the
      3 anchor sites + the one duplicated `addiu 8408`; `li` delta = one `li 1`.
      ==> THE ARGUMENT SET OF THIS CTOR IS NOW PROVEN BYTE-CORRECT.  Do not spend
      another wave hunting wrong arguments here.
   2. SHAPE 1 (fp TIE-BREAK) SOLVED -- and it was NOT a tie.  The -dg/-dl dumps
      name the two rivals exactly (tools/rtl_dump.py + tools/prio.py on
      "tGlobalMenuDefs::tGlobalMenuDefs()"): p573 = this+0x20D8 (&menuCarOptions)
      refs=6 live=134 pri=896, p586 = this+0x12E8 (&itemGarageCar) refs=4 live=108
      pri=741 -- p573 wins $fp on merit, so ours parks the wrong one.  RETAIL's
      p573 is a MUCH longer allocno: the oracle reaches the menuCarOptions member
      ctor itself with `lw $a0,0x10C($sp)` (0x800300EC) -- one pseudo from
      0x8002F49C to 0x800300EC, spilled and reloaded 5x -- while our cse
      rematerializes `this+0x20D8` for that ctor (hence `addiu 8408` x2 vs x1).
      Not spellable (the member ctor call is compiler-generated), so the fix is a
      +1-ref READ-ONLY FENCE on the rival (catalog 21A#1) inside the initializer
      list, delivered through a GNU STATEMENT-EXPRESSION -- cc1plus 2.8 accepts
      `({ ... })` in a mem-initializer argument (NEW: this is the only way to put
      an RTL device inside an initializer list; it opens every data-driven ctor).
      refs 4->5 makes pri 2*5/109 = 917 > 896 and $fp flips.  ALL ELEVEN $fp
      writes then match the oracle's, offsets AND registers
      (`addiu fp,t1,4840` @1110 == oracle @1110).
      SITE MATTERS: the fence on the menuCarGarage use is +64; the same fence on
      the menuDuelCarSelect use flips $fp just as well but costs +224 (it fixes
      insns 1000-1800 and inverts the t0/t1 phase for 1800-3200).
   3. SHAPE 3 (TAIL POINTER-REUSE) SOLVED, and it is what buys the spills.
      `(menuMemory).VertHelp = 0;` compiles to `sh zero,0x3110(this)`; retail has
      `lw t1,0x234(sp); nop; sh zero,0x64(t1)` -- i.e. retail keeps &menuMemory in
      a pseudo from its ctor to the end of the body and SPILLS it.  A LAUNDER
      (`{ tMenu *p = &m; __asm__("" : "=r"(p) : "0"(p)); p->VertHelp = 0; }`,
      catalog 20B) makes the value opaque so the store must use the pointer form,
      and the pointer's function-long live range makes reload spill it.  That
      alone moves ours from 3199 to EXACTLY 3207 insns and re-sites the whole
      spill area.  DIAGNOSTIC THAT FOUND IT: a memory-DISPLACEMENT census over
      the two streams (op, displacement, non-sp base) -- the ONLY deltas in the
      whole 3200-insn function were `sh 100` (oracle x2) vs `sh 12560` / `sh 13108`
      (ours).  Run that census on any big ctor before theorising.
   4. SHAPE 2 (%hi(FEApp) HOIST) SOLVED, and it is the SAME FACT as "retail spills
      8 more pseudos".  Retail holds %hi(FEApp) in $s0 across the last six
      tListIteratorRangeIndexed ctors, which DENIES $s0 to the iterator addresses,
      which is why retail spills them (`sw t0,520(sp)` ... `lw a2,520(sp)`) where
      we did `addu a2,s0,zero`.  Cure = the 'm'-OPERAND fence (catalog 21A#5)
      `__asm__("" : : "m"(FEApp))` on the `&FEApp->fInputPlayer` argument, again
      via a statement-expression.  COUNT IS A SHARP DIAL: the last EIGHT
      iterators (SteeringRange1..IIMax) = 1261; last 7 = 1908; last 6 = 2355;
      last 9/10/all-controller = 2412/2434/2472; all 18 = 3466.
   5. `compilerFramePad` IS RETIRED.  With 3+4 landed the natural spill area is
      52..592 and the frame is 640 without any pad; the pad now HURTS (pad 0 =
      1261, pad 4..32 = 2151..2259, because the declared local perturbs the
      allocation, not just the numbering).  Deleting the array AND its
      `__asm__("" : : "m"(compilerFramePad))` anchor is gate-neutral vs pad[0]
      (both 1261) and is the honest source, so the array is gone.
      Slot check: ours 157 frame slots vs oracle 156; sp-displacement mismatches
      on aligned insns dropped 307 -> 59 and the uniform -24 (frame 616 vs 640)
      class is DEAD.
   REMAINING 1261, decomposed:
     ~277 (reg-blind) genuine structure, concentrated in 2500-2700 (the slider
          ctor block: our `addu a1,zero,zero; li a2,127; lui` order vs retail's)
          plus the four small hunks at 959 / 1140 / 1221 / 2400.
     the rest is ONE t0<->t1 PHASE.  It is now measurable as RUNS (script in
     the receipt trail): ok 3..1142, FLIPPED 1143..1160, ok 1162..1224,
     FLIPPED 1227..1867 (640 insns -- THE ONE THAT MATTERS), ok 1872..2527,
     then only short flips.  ROOT OF THE BIG RUN, read off the streams:
     at the itemGoToDuelBuyCar ctor retail SCHEDULES `addiu v0,zero,-1; sw v0,
     0x10(sp)` BEFORE the two `addiu this,+0x14F8/+0x1D48`, so $t0 is still live
     and the -1 takes $v0; ours schedules the -1 AFTER `sw t0,0x120(sp)`, $t0 is
     dead, and the -1 reuses $t0 -- from there the t0/t1 quantity phase is
     inverted for 640 insns.  Same 13 insns, same multiset, pure sched1 order.
     MIPS has no REG_ALLOC_ORDER (config/mips/mips.h), so local-alloc scans
     $0..$31 and $v0 would win if it were free at the -1's birth -- it IS free in
     our window (no v0 reference in 1150..1300), which proves the cause is the
     SCHEDULE, not occupancy.  ==> the next wave's lever is a luid/order dial on
     that one stack-argument store, NOT an allocator device.
   FALSIFIED THIS WAVE (measured, do not retry): hard-register CLOBBER devices on
   the -1 (`: "$8"` / `: "$9"`) -- reload1.c puts every asm-clobbered reg into
   bad_spill_regs FUNCTION-WIDE, so the whole function migrates to $t2 and $fp
   becomes `addiu fp,t2,...` (3601 / 2733); a plain launder on the -1 is inert
   (1271); `__asm__("" : : "r"(this))` at the head, tail, or both of the body is
   inert (1261 unchanged, deleted as dead per 21A#3); the NON-VOLATILE launder
   form of the itemGarageCar fence (2210 vs the read-only fence's 1776); the
   read-only fence at BOTH itemGarageCar uses (2202); any pad != 0 on top of the
   landed shape; 'm'-fencing the seven iteratorDisplay* FEApp arguments (3466).
   NEXT (in value order): (a) the sched1 dial on the itemGoToDuelBuyCar `-1`
   stack-argument store -- worth the 640-insn t0/t1 run; (b) the 2500-2700 slider
   block order; (c) the tail's last 3 insns (retail's this-reload lands in $v0 so
   the ctor's `return this` needs no `addu v0,t0,zero`; ours puts the constant 2
   in $v0 and this in $t0 -- a local-alloc qty ORDER question); (d) the
   shared-header tInsideBoxControllerLeftRightSlider vptr diff, still not applied.
   TOOLS (all untracked, scratchpad/): W72_A6_hiaudit.py (resolved-address %hi
   audit), W72_A6_immaudit.py (register-blind immediate audit), W72_A6_metric.py
   (the 4-metric decomposition), W72_A6_class.py (diff-hunk classifier),
   W72_A6_ctx.py (windowed stream dump), W72_A6_probe.py (variant+pad probe
   harness that always restores from W72_A6_base.cpp).

   [W74-A6 2026-08-22/23]  1257 -> 1238, TU 65/66 PASS on both gate runs, ZERO
   regressions.  ONE edit landed (the fence move documented at the menuCarGarage
   line below); the wave's real product is that W72-A6's named item (a) is now
   MECHANISM-CORRECTED and re-aimed.
   1. !!! ITEM (a) IS NOT A SCHED1 DIAL -- IT IS A RELOAD SCRATCH PICK.  Read off the
      RTL dumps (tools/rtl_dump.py -dc -dS -dl -dg -dR on this TU):
        * COMBINE dump (pre-sched1): `(insn 1990 (set (reg 571) (const_int -1)))`
          ALREADY sits ~1550 dump-lines from its ONLY use.  It is the -1 pseudo
          EXPAND created for menuTrackOptions' sp+28 argument; cse then served THAT
          store from an older -1 pseudo (reg 194) and forwarded reg 571 to the
          itemGoToDuelBuyCar sp+16 store instead.  So the long live range is a CSE
          artifact that exists BEFORE sched1 ever runs.
        * NEW: LAW (gcc-2.8.1 sched.c:1765, sched_analyze_1):
            if (REG_N_CALLS_CROSSED (regno) == 0 && last_function_call)
              add_dependence (insn, last_function_call, REG_DEP_ANTI);
          A pseudo that crosses ZERO calls gets an anti-dep on the last CALL_INSN,
          which pins its def inside the current call's argument block.  A pseudo that
          ALREADY crosses a call gets NO such dep, so its def has LOG_LINKS == nil,
          so priority() (sched.c:1453) returns the floor value 1, and the BACKWARD
          list scheduler picks it LAST = emits it FIRST in the region.  That is the
          whole reason our -1 def floats ~83 insns above its use.
        * reg 571 therefore gets no hard register: reload deletes insn 1990 and
          REMATERIALIZES the constant at the use (greg dump: insn 2575 becomes
          `(set (reg t0) (const_int -1))` plus a fresh store insn 7584).
        * Retail does exactly the same EVERYWHERE: a stream-wide census of all `-1`
          materializations is 19 ours vs 19 oracle and register-IDENTICAL at 18 of
          them; only insn 1226/1221 differs (ours $t0, retail $v0).  ==> the residual
          is reload1.c:5031 allocate_reload_reg -- round-robin from `last_spill_reg`,
          two passes, pass 0 restricted to regs already in `reload_reg_used_at_all`.
          The downstream 640-insn t0<->t1 run is the textbook "one different reload
          allocation rotates the pool cursor" signature (catalog 22A#4).
        * THE CONTRAST THAT PROVES IT: the structurally identical sibling
          `itemCarDealer(0x74, &menuGoToCarDealer, 0, 0x3a, 10)` (ours == oracle,
          insns 1113..1127) materializes its 0x3a into a FRESH pseudo (657) whose def
          DOES carry `REG_DEP_ANTI` on the preceding call, stays short, wins $v0 from
          local-alloc's numeric scan, and sched2 then hoists `li v0,58; sw v0,16(sp)`
          above both address computations -- retail's exact shape at BOTH sites.
      FALSIFIED ON THE -1 (all gate-measured, all worse; do NOT retry): read-only
      fence 2010 | doubled read-only fence 2010 | launder+read-only 2007 | identity
      launder 1271 (re-measured 1252 in the new basin AND objdump-confirmed the
      constant STILL lands in $t0 -- the launder does not move a reload pick) |
      void-tail `__asm__("" : : "i"(0))` barrier planted at itemGoToDuelBuyCar /
      itemColor2 / itemCar2 / itemDuelRace / itemOpponentCar = 1253 / 1247 / 1247 /
      1257 / 1243, each +1 insn | read-only fences on the PRECEDING -1 literals as
      cse constant-sharing breakers (menuTrackOptions 1535, menuTrackRecordsItem
      2296, combinations worse).
      NEXT ANGLE (named, and it is an INSTRUMENT not a spelling): the instrumented
      cc1 at C:\Temp\nfs4-instr-cc1 traces find_reg / allocno_compare / qty_compare
      but NOT `allocate_reload_reg`.  A `[reload_pick]` trace printing spill_regs
      order, last_spill_reg, the pass number and reload_reg_used_at_all per reload
      decides in ONE run whether ours diverges by POOL ORDER, by free-ness, or by
      used-at-all -- and it is the same instrument every "uniform +-1 scratch
      rotation" residual in this project has been waiting for.
   2. STALE RECEIPT LINES CORRECTED ABOVE: (d) "the shared-header
      tInsideBoxControllerLeftRightSlider vptr diff, still not applied" is FALSE --
      nfs4_types.h:5041 already stores the vptr inside that ctor (a w64 landing), and
      the two `sw s0,24(obj)` in the 2500-2700 block are that INLINED ctor's own
      store; the residual there is emission ORDER only.  "moves ours to EXACTLY 3207
      insns" is also stale (3214 before this wave, 3215 after).  "All eleven $fp
      writes match" is stale (8 of 11).
   3. REMAINING STRUCTURE, reg+spill-blind (256 units; script
      scratchpad/W74_A6_ctx.py, `sbs` / `phase` / `find` modes):
        insn  959 and 3041  -- `addu a3,zero,zero / lui v0 / lw a2,0(v0)` 3-insn
                               rotation, twice, identical shape
        insn 1221-1227      -- the -1 reload pick above
        insn 1753 / 1870-1874 / 2401-2407 -- 1-2 insn order
        insn 2500-2700      -- THE BIGGEST MASS: eight repetitions of ONE shape --
                               retail hoists `addu a1,zero,zero; li a2,127|255` (and
                               the anchor `lui`) to the TOP of each
                               tListIteratorRangeIndexed argument block, right after
                               the previous jal; ours emits them at the BOTTOM next
                               to the call.  Same multiset at every site, ~5-7 diffs
                               each.  Measured this wave: moving the eight m"(FEApp)"
                               fences onto those ctors' 1st/2nd/3rd argument fixes a
                               lot of that STRUCTURE (reg-blind 256 -> 249) but
                               collapses the coloring (gate 1901, +5 insns); one
                               fence per site instead of two = 1242.  So the shape is
                               reachable -- it needs a NON-barrier ref dial.
        insn 2714-2743      -- `li a1,4096` / `sw ..,28(sp)` / `sw zero,16(sp)` order
        insn 3110-3135      -- `li t0,-1` vs `li t1,46` order (+1 insn)
        insn 3171-3200 tail -- ours `li v0,2` where retail `li a0,2`; ours
                               `addu v0,t0,zero` (this into the return reg) and
                               `addu t0,t1,zero` (a copy of a still-live 1) where
                               retail has `nop` and `li t1,1`; our two tail
                               caller-save slots are 568/580 vs retail's 564/576.
                               Tail cse-constant probe: read-only fence on the LAST
                               `VertHelp = 1` = 1235 but +1 insn; launder = 1238
                               (neutral); fence on the FIRST occurrence = 1240/1241.
                               NOT landed -- 3 diffs is not worth an instruction.
   4. AUDITS RE-RUN AFTER THE LANDING (W72-A6 item (d)).  W72_A6_hiaudit.py: the only
      multiset deltas are FEApp +2 (our own m-fences), the frontEnd+0x5E vs
      frontEnd+0x320 anchor swap (13/12 and 7/8, identical FINAL addresses) and the
      two vtable naming gaps (D_800114D8 / D_80011530).  W72_A6_immaudit.py:
      `addiu 0` +2 (the same fences), one 757-vs-51 anchor pair, and the known
      duplicated `addiu 8408`.  THE ARGUMENT SET REMAINS PROVEN BYTE-CORRECT.
      WARNING: W72_A6_hiaudit.py reads scratchpad/W72_A6_ourdis.txt -- REGENERATE it with
      `python tools/ourdis.py recon/frontend/common/femenudefs.cpp __15tGlobalMenuDefs`
      before every run or the audit silently scores a stale object.
   5. TOOLS ADDED (scratchpad/): W74_A6_ctx.py (aligned side-by-side, t0/t1 phase-run
      report, cross-stream grep -- all over the two verify_asm streams, no stale
      snapshots), W74_A6_probe.py + W74_A6_probe2.py (variant harnesses that always
      restore from W74_A6_base.cpp / W74_A6_base2.cpp).

   [W75-A1 2026-08-23]  1238 -> 1138 (-100, -8.1%), reg-blind structure 256 -> 200,
   reg+spill-blind 196 -> 144.  TU 65/66 PASS on both gate runs, ZERO regressions,
   instruction count UNCHANGED (3215).  The landing is a SHARED-HEADER edit, not a
   TU edit -- see the W75-A1 block at nfs4_types.h (tBlankMenuItemNFS4LeftRightChoice).
   1. THE LANDED LEVER -- THE VPTR-STORE ALIAS DIAL (gcc-2.8.1 sched.c
      true_dependence(), :846-875).  Ten inline ctors in nfs4_types.h wrote the
      manual vtable pointer as `*(void **)&_vf = (void *)&X_vtable;`.  That is an
      INDIRECT_REF through a cast, so MEM_IN_STRUCT_P is CLEAR on the store.
      true_dependence only DROPS a MEM conflict when
        MEM_IN_STRUCT_P(store) && rtx_addr_varies_p(store) && mode != QImode
        && !MEM_IN_STRUCT_P(read) && !rtx_addr_varies_p(read)
      so with the cast form every `lui vN; lw aN,%lo(global)(vN)` argument load of
      the NEXT member ctor was pinned BELOW the vptr store of the previous one.
      Retail hoists those loads above the store.  Writing the store as the plain
      member assignment `_vf = (__typeof__(_vf))&X_vtable;` (a COMPONENT_REF =>
      MEM_IN_STRUCT_P set) restores retail's order at every site.  Same address
      stored; the cast was a reconstruction artifact.  Staged measurement:
      1 site (tBlankMenuItemGoToMenuNFS4Button) 1238 -> 1190; all 9 `&_vf` sites
      1238 -> 1148; + the 10th (`_base_tInsideBoxLeftRightSlider._vf`) -> 1138.
      Blast radius is EXACTLY the six TUs that construct these classes and all six
      gate clean (femenudefs 65/66, femenuoptions 92/92, femenuextended 57/57,
      screencarselect 59/59, fememcard 18/18, vtables_tmenu / vtables_tpausemenu
      0/0); `build.py --skip-asm` is green.
      REUSABLE: ~90 more `*(void **)&...->_vf = ...` sites exist across recon/**.cpp;
      each is a candidate wherever a near-miss shows an argument load ordered after
      a vptr store.  (They were NOT converted here -- they sit in PASSing functions.)
   2. !!! THE t0/t1 PHASE IS NOT A RELOAD SCRATCH PICK.  W74-A6 item 1 is CORRECTED.
      It is gcc's CSE 1000-INSN HASH-TABLE FLUSH KLUDGE, cited:
        gcc-2.8.1 cse.c:8626-8644, cse_basic_block():
          (comment in cse.c) "If we have processed 1,000 insns, flush the hash
          table to avoid extreme quadratic behavior. ??? This is a real kludge"
          if (num_insns++ > 1000) { <invalidate every REG elt, remove every other
                                     elt>; num_insns = 0; }
      `num_insns` is a per-BASIC-BLOCK counter (cse.c:8590) and the loop increments
      it for EVERY rtx in the chain (insns AND notes).  This ctor is ONE basic block
      (`;; Processing block from 2 to 0, 3610 sets.`), so cse's constant table is
      wiped every 1001 chain objects.  MEASURED on the -dj (cse input) dump: the
      function contains exactly FOUR surviving `(set (reg) (const_int -1))` defs, at
      chain ordinals 131 / 986 / 2019 / 3008 -- one per 1001-object run; every other
      -1 is CSE-forwarded to its run's first one.  Consequence chain for the residual:
        * pre-cse the itemGoToDuelBuyCar -1 is a FRESH pseudo (jump dump insn 2573,
          `(set (reg 703) (const_int -1))`) used one insn later at 2575;
        * cse rewrites 2575's source to reg 570 (def at ordinal 986, ~320 objects
          back, same flush run) and deletes 2573;
        * .lreg then reports `Register 570 used 2 times across 100 insns ... crosses
          5 calls` => it can take neither a caller-saved reg (call-crossing) nor a
          callee-saved one (priority floor_log2(2)*2/100), so it gets NO hard reg;
        * reload rematerializes it into a SPILL register.  This function's spill pool
          is EXACTLY {$t0,$t1}: a census of the .greg dump finds 443 reload-created
          register sets, 228 $t0 + 215 $t1 and NOTHING else.  Round-robin hands it
          $t0, the following `10` gets $t1, and from insn 1227 the whole t0/t1
          quantity phase is inverted for ~382 instructions (~770 of the 1138).
        * RETAIL's -1 is in $v0 -- a register that is NOT in any possible spill pool
          here -- so retail's pseudo was ALLOCATED, i.e. SHORT, i.e. retail's cse
          flush boundary fell between the previous -1 def and this site.
      ==> the dial is the RTL-object count of everything before this point, not any
      allocator device.  A20's [reload_pick] instrument CANNOT answer it (see 4).
   3. FALSIFIED THIS WAVE (all gate-measured; do NOT retry):
      * reload-pool cursor rotation via a far-away zero-insn hard-reg clobber
        (catalog 22D#2) -- `__asm__("" : : "i"(0) : "$N")` at the body tail for
        N = $v1,$t2..$t9: ALL gate-INERT (1238), because those registers are not in
        the pool; N = $s1..$s7: 3046..3419 (catastrophic).  The pool is 2 members and
        both are already used, so no rotation can ever produce retail's $v0.
      * cse-boundary shifting by a head pad of K zero-machine-instruction RTL objects
        -- `__asm__("" : : "i"(0))` x K in the first mem-initializer: K=1..4 -> 1253/
        1254 (each is a sched1 barrier, so large K measures barriers not boundaries);
        K=6..960 -> 1982..4224.  Non-barrier variant (K dead stores to one local, 0
        machine insns, cse never deletes a dead set): K=1 -> 1238 (validity check,
        byte-identical), K=2..1000 -> 2650..4469.  The baseline sits in a good local
        optimum; the boundary is not reachable by padding.
      * PER-TU COMPILER FLAGS -- the control (-O2 -G0) is OPTIMAL and this axis is now
        CLOSED for this fn: -g1 1256 / -g 2075 (both DO change codegen, so retail's
        debug-note count is a real dial, just not this one) / -mno-split-addresses
        3672 / -fno-schedule-insns 4883 / -fno-schedule-insns2 4133 /
        -fno-delayed-branch 1875 / -fno-strength-reduce INERT.
        (Harness: scratchpad/w75/A1_dbg.py -- runs the REAL compile_cpp with an extra
        cc1plus flag injected + COFF-debug stripped, without touching tools/.)
      * slider-block (2500-2700) dials: a THIRD "m"(FEApp) fence per site 1138
        (saturated, inert); an added / leading / only `"m"(frontEnd)` fence
        2648 / 2648 / 1614 / 1470; a NON-barrier identity launder on the FEApp
        pointer 1698, and that launder ON TOP of the two m-fences 1270.  The
        first-two-argument literal SPELLING is completely inert (char literals vs
        0,127 vs (char) casts vs hex: all 1138) -- they fold to the same constant.
      * the READ side of the same alias dial: rewriting the ten `screenMain[0]` and
        eight `screenCarSelect[0]` argument reads as `*screenMain` / `*screenCarSelect`
        (INDIRECT_REF instead of ARRAY_REF) is INERT (1138) at every site.
   4. THE NAMED [reload_pick] INSTRUMENT ASK IS ANSWERED -- NEGATIVELY, TWICE OVER.
      (a) LAB FIDELITY IS ZERO for this function.  The instrumented FSF cc1plus
      (C:\Temp\nfs4-instr-cc1\cc1plus-ecoff.exe, -O2 -G0 -fno-exceptions -fno-rtti on
      the REAL pipeline .i) emits 2957 insns vs CC1PLPSX's 3155, 3490 LCS diff units,
      and the COMMON PREFIX IS ZERO INSTRUCTIONS (`subu $sp,$sp,600` vs `,640`).  No
      trace from that lane is a receipt in this basin.  (To reach the ICE-free state
      at all, the .i needs two edits: drop the brace-elided `gCarActivation[6][5]`
      initialiser and cast the two `command.type = cmdType` int->enum assignments.)
      (b) Even with a perfect lab it would answer the wrong question: our pick IS the
      correct round-robin answer from a 2-member pool; retail's $v0 is not a pool
      member at all.
   5. RE-PRICED IN THE NEW BASIN (catalog 04Z basin-relativity): every W72/W74 device
      still landed here remains OPTIMAL after the alias-dial landing -- removing the
      menuPostCarGarage read-only fence costs +101 (1239), one m-fence per site
      instead of two costs +4 (1142), three per site is inert (1138), and the two
      -1-site devices are still worse (read-only 1663, launder 1152).
   6. TOOLS (untracked, scratchpad/w75/): A1_probe.py + A1_variants.py (variant
      harness, always restores from A1_base.cpp), A1_dbg.py (flag-injection lab),
      rtl_base/ (protected -dj/-ds/-dl/-dg/-dR/-dS dumps of the landed TU).
      WARNING: tools/rtl_dump.py writes a FIXED path -- copy before re-dumping. */


/* [2026-08-10] Retail constructs every iterator in declaration order between its
   surrounding menu members.  Keeping those members in the initializer list fixes
   the complete 254-call sequence (the old body deferred them all until the end),
   including three wrong destination objects. Retail records a 640-byte frame;
   the full-debug source restoration is documented at the constructor body below. */

/* SYM-INLINE-LOCAL: child = tMenu::SetChildMenu (setter spelling inferred)
   Retail's body contains three child pairs plus thirteen receiver-free pairs.
   Member field updates reproduce that entire body tree without pointer locals.
   The helper spellings remain inferred, not uniquely recovered original text;
   initializer shaping regions are removed; full debug is the retail build input. */
/* [W82-A3] SLD-LICENSED STATEMENT ORDER.  The trusted SYM's SLD line map puts
   ALL FOUR SetCarFilter calls and the three VertHelp stores below on ONE retail
   source line (2200; the whole 3207-instruction constructor carries 18 SLD
   records at just 10 distinct addresses, and everything before the body -- all
   3129 member-init instructions -- carries only TWO).  Their source order is
   therefore a free variable the SLD cannot constrain -- and it is the last dial:
   GarageCar first makes cc1 materialize the shared constant 2 as the FIRST
   instruction of the tail block (retail's `li a0,2` at oracle 3171, tagged to the
   PREVIOUS statement's line 2172), which flips the const-2 / fFlags-load pair
   onto retail's registers ($a0 / $v1).  Measured over all 24 permutations of the
   four calls: 1023 (this one) = PASS, 3021 = 4, 0123 (old) = 14, worst 21. */
tGlobalMenuDefs::tGlobalMenuDefs()
 : itemMainOnePlayerRace(0x5b, (tMenu*)&menuOnePlayer, (void (*)(tMenuCommand&))MenuExtended_SetOnePlayer, 0x1e, 10)   /* +0x0 tMenuItemGoToMenuNFS4Button */













































































































































































































































































































































































































































































































































































 , itemMainTwoPlayerRace(0x5c, (tMenu*)&menuTwoPlayer, (void (*)(tMenuCommand&))MenuExtended_SetTwoPlayer, 0x28, 10)   /* +0x2C tMenuItemGoToMenuNFS4Button */
 , itemMainTrophyRoom(0x5e, (tMenu*)&menuTrophyRoomSelect, 0, 0x32, 10)   /* +0x58 tMenuItemGoToMenuNFS4Button */
 , itemMainOptions(0x5d, (tMenu*)&menuOptions, 0, 0x3c, 10)   /* +0x84 tMenuItemGoToMenuNFS4Button */
 , menuMain(0x1014, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0xb4, (tMenuItem *)&itemMainOnePlayerRace, &itemMainTwoPlayerRace, &itemMainOptions, &itemMainTrophyRoom, 0)   /* +0xB0 tMenuNFS4 */
 , itemTournTrophyRoom(99, (tMenu *)&menuTrophyRoom, (void (*)(tMenuCommand&))MenuExtended_GoToTournTrophyRoom, 0x32, 10)   /* +0x12C tMenuItemGoToMenuNFS4Button */
 , itemSETrophyRoom(0x69, (tMenu *)&menuTrophyRoom, (void (*)(tMenuCommand&))MenuExtended_GoToSETrophyRoom, 0x32, 10)   /* +0x158 tMenuItemGoToMenuNFS4Button */
 , menuTrophyRoomSelect(0x1014, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0x5f, (tMenuItem *)&itemTournTrophyRoom, &itemSETrophyRoom, 0)   /* +0x184 tMenuNFS4 */
 , menuTrophyInfo(0x4000, (tScreen *)screenTrophyInfo, (tMenu *)0x0, (tMenu *)0x0, 0, -1)   /* +0x200 tMenuBlank */
 , itemSkillBeginner(0xa1, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetBeginner, 0x8c, 10)   /* +0x27C tMenuItemGoToMenuNFS4Button */
 , itemSkillIntermediate(0xa2, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetIntermediate, 0x96, 10)   /* +0x2A8 tMenuItemGoToMenuNFS4Button */
 , itemSkillExpert(0xa3, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetExpert, 0xa0, 10)   /* +0x2D4 tMenuItemGoToMenuNFS4Button */
 , menuSkillLevel(0x1004, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0xb7, (tMenuItem *)&itemSkillBeginner, &itemSkillIntermediate, &itemSkillExpert, 0)   /* +0x300 tMenuNFS4 */
 , itemOnePlayerTestDrive(0x60, (tMenu*)&menuTestDriveTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetTestDrive, 0xf0, 10)   /* +0x37C tMenuItemGoToMenuNFS4Button */
 , itemOnePlayerSingleRace(0x72, (tMenu*)&menuSingleRace, (void (*)(tMenuCommand&))MenuExtended_SetSingleRace, 0x46, 10)   /* +0x3A8 tMenuItemGoToMenuNFS4Button */
 , itemOnePlayerPursuit(0x71, (tMenu*)&menuHotPursuit, (void (*)(tMenuCommand&))MenuExtended_SetHotPursuit, 0x50, 10)   /* +0x3D4 tMenuItemGoToMenuNFS4Button */
 , itemOnePlayerTournament(99, (tMenu*)&menuTournament, (void (*)(tMenuCommand&))MenuExtended_SetTournament, 0x5a, 10)   /* +0x400 tMenuItemGoToMenuNFS4Button */
 , itemOnePlayerSpecialEvents(0x69, (tMenu*)&menuSpecialEvent, (void (*)(tMenuCommand&))MenuExtended_SetSpecialEvent, 100, 10)   /* +0x42C tMenuItemGoToMenuNFS4Button */
 , menuOnePlayer(0x1004, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0xb5, (tMenuItem *)&itemOnePlayerTestDrive, &itemOnePlayerSingleRace, &itemOnePlayerPursuit, &itemOnePlayerTournament, &itemOnePlayerSpecialEvents, 0)   /* +0x458 tMenuNFS4 */
 , itemSingleRaceSolo(0x6c, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetSoloRace, 0x6e, 10)   /* +0x4D4 tMenuItemGoToMenuNFS4Button */
 , itemSingleRaceDuel(0x6d, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetDuelRace, 0x78, 10)   /* +0x500 tMenuItemGoToMenuNFS4Button */
 , itemSingleRaceFullGrid(0x6f, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetFullGrid, 0x82, 10)   /* +0x52C tMenuItemGoToMenuNFS4Button */
 , menuSingleRace(0x1004, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0xb6, (tMenuItem *)&itemSingleRaceSolo, &itemSingleRaceDuel, &itemSingleRaceFullGrid, 0)   /* +0x558 tMenuNFS4 */
 , itemHotPursuitSolo(0x6c, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetHPSoloRace, 0x6e, 10)   /* +0x5D4 tMenuItemGoToMenuNFS4Button */
 , itemHotPursuitDuel(0x6d, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetHPDuelRace, 0x78, 10)   /* +0x600 tMenuItemGoToMenuNFS4Button */
 , menuHotPursuit(0x1004, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0xb6, (tMenuItem *)&itemHotPursuitSolo, &itemHotPursuitDuel, 0)   /* +0x62C tMenuNFS4 */
 , iteratorTournament(&frontEnd.tournament, &tournamentManager)   /* +0x6A8 tListIteratorTournament */
 , itemTournamentContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToTournTrackInfo, 0x22, 10)   /* +0x6BC tMenuItemGoToMenuNFS4Button */
 , itemTournamentSelect(0x94, (tListIterator *)&iteratorTournament, 0x2c, 10)   /* +0x6E8 tMenuItemNFS4LeftRightChoice */
 , menuTournament(0x1000, (tScreen *)screenTournSelect, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToTournTrackInfo, 0x65, (tMenuItem *)&itemTournamentContinue, &itemTournamentSelect, 0)   /* +0x710 tMenuNFS4 */
 , iteratorSpecialEvent(&frontEnd.specialevent, &tournamentManager)   /* +0x78C tListIteratorTournament */
 , itemSpecialEventContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToSpecialEventTrackInfo, 0x22, 10)   /* +0x7A0 tMenuItemGoToMenuNFS4Button */
 , itemSpecialEventSelect(0x69, (tListIterator *)&iteratorSpecialEvent, 0x36, 10)   /* +0x7CC tMenuItemNFS4LeftRightChoice */
 , menuSpecialEvent(0x1000, (tScreen *)screenTournSelect, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToSpecialEventTrackInfo, 100, (tMenuItem *)&itemSpecialEventContinue, &itemSpecialEventSelect, 0)   /* +0x7F4 tMenuNFS4 */
 , itemTwoPlayerTestDrive(0x60, (tMenu*)&menuTestDriveTrackSelect, (void (*)(tMenuCommand&))MenuExtended_SetTestDrive, 0xf0, 10)   /* +0x870 tMenuItemGoToMenuNFS4Button */
 , itemTwoPlayerDuel(0x72, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToTwoPlayerSingleRace, 0x46, 10)   /* +0x89C tMenuItemGoToMenuNFS4Button */
 , itemTwoPlayerHotPursuit(0x71, (tMenu*)&menuSkillLevel, (void (*)(tMenuCommand&))MenuExtended_SetHotPursuit, 0x50, 10)   /* +0x8C8 tMenuItemGoToMenuNFS4Button */
 , itemTwoPlayerPinkSlips(0x6a, (tMenu*)&menuPinkSlipSelect, (void (*)(tMenuCommand&))MenuExtended_SetPinkSlips, 0xaa, 10)   /* +0x8F4 tMenuItemGoToMenuNFS4Button */
 , menuTwoPlayer(0x1004, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0xb5, (tMenuItem *)&itemTwoPlayerTestDrive, &itemTwoPlayerDuel, &itemTwoPlayerHotPursuit, &itemTwoPlayerPinkSlips, 0)   /* +0x920 tMenuNFS4 */
 , itemBestOfOne(0xc0, (tMenu*)&menuSingleTrackSelect, (void (*)(tMenuCommand&))MenuExtended_GoToBestOfOne, 0xaa, 10)   /* +0x99C tMenuItemGoToMenuNFS4Button */
 , itemBestOfThree(0xc1, (tMenu*)&menuPinkSlipsBestOfThree, (void (*)(tMenuCommand&))MenuExtended_GoToBestOfThree, 0xaa, 10)   /* +0x9C8 tMenuItemGoToMenuNFS4Button */
 , itemBestOfFive(0xc2, (tMenu*)&menuPinkSlipsBestOfFive, (void (*)(tMenuCommand&))MenuExtended_GoToBestOfFive, 0xaa, 10)   /* +0x9F4 tMenuItemGoToMenuNFS4Button */
 , menuPinkSlipSelect(0x1000, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0xb6, (tMenuItem *)&itemBestOfOne, &itemBestOfThree, &itemBestOfFive, 0)   /* +0xA20 tMenuNFS4 */
 , itemPinkSlipsContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect, 0x24, 10)   /* +0xA9C tMenuItemGoToMenuNFS4Button */
 , itemTrack1(0xc3, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xAC8 tMenuItemNFS4LeftRightChoice */
 , itemTrack2(0xc4, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xAF0 tMenuItemNFS4LeftRightChoice */
 , itemTrack3(0xc5, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xB18 tMenuItemNFS4LeftRightChoice */
 , itemTrack4(0xc6, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xB40 tMenuItemNFS4LeftRightChoice */
 , itemTrack5(199, (tListIterator *)&iteratorTrack, 0x2e, 10)   /* +0xB68 tMenuItemNFS4LeftRightChoice */
 , menuPinkSlipsBestOfThree(0x1400, (tScreen *)screenPinkSlips, (tMenu *)0x0, (tMenu *)&menuTrackOptions, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect, 0xbe, (tMenuItem *)&itemPinkSlipsContinue, &itemTrack1, &itemTrack2, &itemTrack3, 0)   /* +0xB90 tMenuNFS4 */
 , menuPinkSlipsBestOfFive(0x1400, (tScreen *)screenPinkSlips, (tMenu *)0x0, (tMenu *)&menuTrackOptions, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect, 0xbf, (tMenuItem *)&itemPinkSlipsContinue, &itemTrack1, &itemTrack2, &itemTrack3, &itemTrack4, &itemTrack5, 0)   /* +0xC0C tMenuNFS4 */
 , iteratorTrack(frontEnd.track, &frontEnd.pinkSlipsTrackIndex, &trackManager)   /* +0xC88 tListIteratorTrack */
 , itemTrackContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect, 0x1c, 10)   /* +0xCA0 tMenuItemGoToMenuNFS4Button */
 , itemTrack(0x93, (tListIterator *)&iteratorTrack, 0x26, 10)   /* +0xCCC tMenuItemNFS4LeftRightChoice */
 , itemTrackRecords(0xd4, (tMenu*)&menuTrackRecords, 0, 0x3a, 10)   /* +0xCF4 tMenuItemGoToMenuNFS4Button */
 , menuSingleTrackSelect(0x1600, (tScreen *)screenTrackSelect, (tMenu *)0x0, (tMenu *)&menuTrackOptions, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect, 200, (tMenuItem *)&itemTrackContinue, &itemTrack, &itemTrackRecords, 0)   /* +0xD20 tMenuNFS4 */
 , menuTestDriveTrackSelect(0x1600, (tScreen *)screenTrackSelect, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToCarSelect, 200, (tMenuItem *)&itemTrackContinue, &itemTrack, &itemTrackRecords, 0)   /* +0xD9C tMenuNFS4 */
 , iteratorLaps(SelectListNormal, frontEnd.lapind, &frontEnd.pinkSlipsTrackIndex)   /* +0xE18 tListIteratorIndexed */
 , iteratorTrackDirection(SelectListTrackDirection, frontEnd.trackdirection, &frontEnd.pinkSlipsTrackIndex)   /* +0xE2C */
 , iteratorTrackMirrored(SelectListOffOn, frontEnd.trackmirrored, &frontEnd.pinkSlipsTrackIndex)   /* +0xE40 */
 , iteratorTimeOfDay(SelectListOffOn, frontEnd.timeOfDay, &frontEnd.pinkSlipsTrackIndex)   /* +0xE54 */
 , iteratorWeather(SelectListOffOn, frontEnd.weather, &frontEnd.pinkSlipsTrackIndex)   /* +0xE68 */
 , iteratorTraffic(SelectListOffOn, frontEnd.traffic, &frontEnd.pinkSlipsTrackIndex)   /* +0xE7C */
 , iteratorLocalSpeech(SelectListOffOn, &frontEnd.localSpeech)   /* +0xE90 tListIterator */
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
 , itemTrackInfoContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToGarage, 0x21, 10)   /* +0x10C4 tMenuItemGoToMenuNFS4Button */
 , menuTrackInfo(0x1004, (tScreen *)screenTrackInfo, (tMenu *)0x0, (tMenu *)0x0, 0, 0xf9, (tMenuItem *)&itemTrackInfoContinue, 0)   /* +0x10F0 tMenuNFS4 */
 , iteratorCar1(frontEnd.playerCar, &carManager)   /* +0x116C tListIteratorCar */
 , iteratorColor(frontEnd.carColors[0], &FEApp->fPlayer, frontEnd.playerCar, 0x30, &carManager)   /* +0x1188 tListIteratorCarColor */
 , itemCarSelectRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToRace, 0x80, 10)   /* +0x11A8 tMenuItemGoToMenuNFS4Button */
 , itemCar(0x92, (tListIterator *)&iteratorCar1, 0x1c, 10)   /* +0x11D4 tMenuItemNFS4LeftRightChoice */
 , itemColor(0x120, (tListIterator *)&iteratorColor, 0x26, 10)   /* +0x11FC tMenuItemNFS4LeftRightChoice */
 , itemShowcase(0x112, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToShowroom, 0x30, 10)   /* +0x1224 tMenuItemGoToMenuNFS4Button */
 , menuSingleCarSelect(0x1a00, (tScreen *)screenCarSelect, (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace, 0xba, (tMenuItem *)&itemCarSelectRace, &itemCar, &itemColor, &itemShowcase, 0)   /* +0x1250 tMenuNFS4 */

 , iteratorGarageCar(frontEnd.garageCar, &carManager)   /* +0x12CC tListIteratorCar */
 , itemGarageCar(0x92, (tListIterator *)&iteratorGarageCar, 0x1c, 10)   /* +0x12E8 tMenuItemNFS4LeftRightChoice */
 , itemCarDealer(0x74, (tMenu*)&menuGoToCarDealer, 0, 0x3a, 10)   /* +0x1310 tMenuItemGoToMenuNFS4Button */
 , itemUpgradeCar(0x91, (tMenu *)0x0, MenuExtended_GoToUpgrades, 0x44, 10)   /* +0x133C tMenuItemGoToMenuNFS4Button */
 , menuCarGarage(0x1a00, (tScreen *)screenCarSelect, (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace, 0x8f, (tMenuItem *)&itemCarSelectRace, &itemGarageCar, &itemCarDealer, &itemUpgradeCar, 0)   /* +0x1368 tMenuNFS4 */
 , menuPostCarGarage(0x1a00, (tScreen *)screenCarSelect, (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace, 0x8f, (tMenuItem *)&itemCarSelectRace, &itemUpgradeCar, 0)   /* +0x13E4 tMenuNFS4 */
 , iteratorOpponentCar(&frontEnd.oppCar, &carManager)   /* +0x1460 tListIteratorCar */
 , itemDuelRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToRace, 0x2a, 10)   /* +0x147C tMenuItemGoToMenuNFS4Button */
 , itemCar2(0x92, (tListIterator *)&iteratorCar1, 0xc, 10)   /* +0x14A8 tMenuItemNFS4LeftRightChoice */
 , itemColor2(0x120, (tListIterator *)&iteratorColor, 0x16, 10)   /* +0x14D0 tMenuItemNFS4LeftRightChoice */
 , itemGoToDuelBuyCar(0x78, (tMenu*)&menuCarDealer, MenuExtended_GoToDealer, -1, 10)   /* +0x14F8 tMenuItemGoToMenuNFS4Button */
 , itemOpponentCar(0xbc, (tListIterator *)&iteratorOpponentCar, 0x20, 10)   /* +0x1524 tMenuItemNFS4LeftRightChoice */
 , menuDuelCarSelect(0x1800, (tScreen *)screenCarSelectDuel, (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace, 0xba, (tMenuItem *)&itemDuelRace, &itemGarageCar, &itemGoToDuelBuyCar, &itemOpponentCar, 0)   /* +0x154C tMenuNFS4 */
 , menuHPDuelCarSelect(0x1800, (tScreen *)screenCarSelectDuel, (tMenu *)0x0, (tMenu *)&menuCarOptions, (void (*)(tMenuCommand&))MenuExtended_GoToRace, 0xba, (tMenuItem *)&itemDuelRace, &itemCar, &itemColor, &itemOpponentCar, 0)   /* +0x15C8 tMenuNFS4 */
 , itemPlayerOneRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0x2a, 10)   /* +0x1644 tMenuItemGoToMenuNFS4Button */
 , itemCarP1(0x92, (tListIterator *)&iteratorCar1, 0xc, 10)   /* +0x1670 tMenuItemNFS4LeftRightChoice */
 , itemColorP1(0x120, (tListIterator *)&iteratorColor, 0x16, 10)   /* +0x1698 tMenuItemNFS4LeftRightChoice */
 , menuPlayerOneCarSelect(0x1008, (tScreen *)screenCarSelectTwoPlayer, (tMenu *)0x0, (tMenu *)&menuCarOptionsPlayerOne, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0xba, (tMenuItem *)&itemPlayerOneRace, &itemCarP1, &itemColorP1, 0)   /* +0x16C0 tMenuNFS4TwoPlayer */
 , itemPlayerTwoRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0x2a, 10)   /* +0x173C tMenuItemGoToMenuNFS4Button */
 , itemCarP2(0x92, (tListIterator *)&iteratorCar1, 0xc, 10)   /* +0x1768 tMenuItemNFS4LeftRightChoice */
 , itemColorP2(0x120, (tListIterator *)&iteratorColor, 0x16, 10)   /* +0x1790 tMenuItemNFS4LeftRightChoice */
 , menuPlayerTwoCarSelect(0x1008, (tScreen *)screenCarSelectPlayerTwo, (tMenu *)0x0, (tMenu *)&menuCarOptionsPlayerTwo, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0xba, (tMenuItem *)&itemPlayerTwoRace, &itemCarP2, &itemColorP2, 0)   /* +0x17B8 tMenuNFS4TwoPlayer */
 , itemPlayerOneGarageRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0x2a, 10)   /* +0x1834 tMenuItemGoToMenuNFS4Button */
 , itemGarageCarP1(0x92, (tListIterator *)&iteratorGarageCar, 0xc, 10)   /* +0x1860 tMenuItemNFS4LeftRightChoice */
 , menuPlayerOneGarage(0x1008, (tScreen *)screenCarSelectTwoPlayer, (tMenu *)0x0, (tMenu *)&menuCarOptionsPlayerOne, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0xba, (tMenuItem *)&itemPlayerOneRace, &itemGarageCarP1, 0)   /* +0x1888 tMenuNFS4TwoPlayer */
 , itemPlayerTwoGarageRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0x2a, 10)   /* +0x1904 tMenuItemGoToMenuNFS4Button */
 , itemGarageCarP2(0x92, (tListIterator *)&iteratorGarageCar, 0xc, 10)   /* +0x1930 tMenuItemNFS4LeftRightChoice */
 , menuPlayerTwoGarage(0x1008, (tScreen *)screenCarSelectPlayerTwo, (tMenu *)0x0, (tMenu *)&menuCarOptionsPlayerTwo, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0xba, (tMenuItem *)&itemPlayerTwoGarageRace, &itemGarageCarP2, 0)   /* +0x1958 tMenuNFS4TwoPlayer */
 , iteratorPinkSlipsCar(frontEnd.pinkSlipsCar, &carManager)   /* +0x19D4 tListIteratorCar */
 , itemPlayerOnePinkSlipRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0x2a, 10)   /* +0x19F0 tMenuItemGoToMenuNFS4Button */
 , itemPinkSlipCarP1(0x92, (tListIterator *)&iteratorPinkSlipsCar, 0xc, 10)   /* +0x1A1C tMenuItemNFS4LeftRightChoice */
 , menuPlayerOnePinkSlipCarSelect(0x1008, (tScreen *)screenPinkSlipsCarSelectTwoPlayer, (tMenu *)0x0, (tMenu *)&menuPinkSlipCarOptionsPlayerOne, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0xba, (tMenuItem *)&itemPlayerOnePinkSlipRace, &itemPinkSlipCarP1, 0)   /* +0x1A44 tMenuNFS4TwoPlayer */
 , itemPlayerTwoPinkSlipRace(0xbd, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0x2a, 10)   /* +0x1AC0 tMenuItemGoToMenuNFS4Button */
 , itemPinkSlipCarP2(0x92, (tListIterator *)&iteratorPinkSlipsCar, 0xc, 10)   /* +0x1AEC tMenuItemNFS4LeftRightChoice */
 , menuPlayerTwoPinkSlipCarSelect(0x1008, (tScreen *)screenPinkSlipsCarSelectPlayerTwo, (tMenu *)0x0, (tMenu *)&menuPinkSlipCarOptionsPlayerTwo, (void (*)(tMenuCommand&))MenuExtended_GoTo2PlayerRace, 0xba, (tMenuItem *)&itemPlayerTwoPinkSlipRace, &itemPinkSlipCarP2, 0)   /* +0x1B14 tMenuNFS4TwoPlayer */
 , itemGoToBuyCar(0x78, (tMenu*)&menuCarDealer, MenuExtended_GoToDealer, 0x58, 10)   /* +0x1B90 tMenuItemGoToMenuNFS4Button */
 , itemGoToSellCar(0x79, (tMenu*)&menuCarSeller, MenuExtended_GoToSeller, 0x4e, 10)   /* +0x1BBC tMenuItemGoToMenuNFS4Button */
 , menuGoToCarDealer(0x1200, (tScreen *)screenCarSelect, (tMenu *)0x0, (tMenu *)0x0, 0, 0x90, (tMenuItem *)&itemGoToBuyCar, &itemGoToSellCar, 0)   /* +0x1BE8 tMenuNFS4 */
 , iteratorDealerCar(&frontEnd.dealerCar, &carManager)   /* +0x1C64 tListIteratorCar */
 , iteratorDealerColor(frontEnd.carColors[0], &FEApp->fPlayer, &frontEnd.dealerCar, 0x30, &carManager)   /* +0x1C80 tListIteratorCarColor */
 , itemDealerCar(0x92, (tListIterator *)&iteratorDealerCar, 0x1c, 10)   /* +0x1CA0 tMenuItemNFS4LeftRightChoice */
 , itemDealerColor(0x120, (tListIterator *)&iteratorDealerColor, 0x26, 10)   /* +0x1CC8 tMenuItemNFS4LeftRightChoice */
 , itemBuyCar(0x75, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_BuyCar, 0x58, 10)   /* +0x1CF0 tMenuItemGoToMenuNFS4Button */
 , itemDealerShowroom(0x112, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_GoToDealerShowroom, 0x30, 10)   /* +0x1D1C tMenuItemGoToMenuNFS4Button */
 , menuCarDealer(0x2240, (tScreen *)screenCarSelect, (tMenu *)0x0, (tMenu *)0x0, 0, 0x90, (tMenuItem *)&itemDealerCar, &itemDealerColor, &itemBuyCar, &itemDealerShowroom, 0)   /* +0x1D48 tMenuNFS4 */
 , iteratorSellerCar(&frontEnd.sellerCar, &carManager)   /* +0x1DC4 tListIteratorCar */
 , itemSellerCar(0x92, (tListIterator *)&iteratorSellerCar, 0x1c, 10)   /* +0x1DE0 tMenuItemNFS4LeftRightChoice */
 , itemSellCar(0x77, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_SellCar, 0x4e, 10)   /* +0x1E08 tMenuItemGoToMenuNFS4Button */
 , menuCarSeller(0x2200, (tScreen *)screenCarSelect, (tMenu *)0x0, (tMenu *)0x0, 0, 0x90, (tMenuItem *)&itemSellerCar, &itemSellCar, 0)   /* +0x1E34 tMenuNFS4 */
 , itemPurchaseUpgrade1(0x96, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PurchaseUpgrade1, 0x62, 10)   /* +0x1EB0 tMenuItemGoToMenuNFS4Button */
 , itemPurchaseUpgrade2(0x97, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PurchaseUpgrade2, 0x6c, 10)   /* +0x1EDC tMenuItemGoToMenuNFS4Button */
 , itemPurchaseUpgrade3(0x98, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PurchaseUpgrade3, 0x76, 10)   /* +0x1F08 tMenuItemGoToMenuNFS4Button */
 , menuCarUpgrades(0x2200, (tScreen *)screenCarSelect, (tMenu *)0x0, (tMenu *)0x0, 0, 0x91, (tMenuItem *)&itemPurchaseUpgrade1, &itemPurchaseUpgrade2, &itemPurchaseUpgrade3, 0)   /* +0x1F34 tMenuNFS4 */
 , iteratorTransmission(SelectListTransmission, frontEnd.transmission, &FEApp->fPlayer)   /* +0x1FB0 tListIteratorIndexed */
 , iteratorABS(SelectListOffOn, frontEnd.ABS, &FEApp->fPlayer)   /* +0x1FC4 tListIteratorIndexed */
 , iteratorDamage(SelectListOffOn, &frontEnd.damage)   /* +0x1FD8 tListIterator */
 , iteratorOpponentUpgrades(SelectListOpponentUpgrades, &frontEnd.opponentUpgrades)   /* +0x1FE8 tListIterator */
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
 , itemOptionsUsername(0x1ca, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_EnterUserName, 0xdc, 10)   /* +0x2498 tMenuItemGoToMenuNFS4Button */
 , itemOptionsCredits(0x1cc, (tMenu *)&menuCredits, 0, 0xe6, 10)   /* +0x24C4 tMenuItemGoToMenuNFS4Button */
 , menuOptions(0x1014, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, 0x5d, (tMenuItem *)&itemOptionsAudio, &itemOptionsDisplay, &itemOptionsControllers, &itemOptionsMemoryCard, &itemOptionsUsername, &itemOptionsCredits, 0)   /* +0x24F0 tMenuNFS4 */
 , iteratorMusicVolume('\0', '\x7f', &frontEnd.musicVolume)   /* +0x256C tListIteratorRange */
 , iteratorSoundEffectsVolume('\0', '\x7f', &frontEnd.sfxVolume)   /* +0x257C */
 , iteratorEngineVolume('\0', '\x7f', &frontEnd.engineVolume)   /* +0x258C */
 , iteratorSpeechVolume('\0', '\x7f', &frontEnd.narrationVolume)   /* +0x259C */
 , iteratorAmbientVolume('\0', '\x7f', &frontEnd.ambientVolume)   /* +0x25AC */
 , iteratorAudioMode(SelectListAudioMode, &frontEnd.audioMode)   /* +0x25BC tListIterator */
 , itemMusicVolume(0x1d5, (tListIterator *)&iteratorMusicVolume, 0)   /* +0x25CC tMenuItemLeftRightAudioSlider */
 , itemSoundEffectsVolume(0x1d6, (tListIterator *)&iteratorSoundEffectsVolume, 1)   /* +0x2604 tMenuItemLeftRightAudioSlider */
 , itemEngineVolume(0x1d7, (tListIterator *)&iteratorEngineVolume, 2)   /* +0x263C tMenuItemLeftRightAudioSlider */
 , itemSpeechVolume(0x1d8, (tListIterator *)&iteratorSpeechVolume, 3)   /* +0x2674 tMenuItemLeftRightAudioSlider */
 , itemAmbientVolume(0x1d9, (tListIterator *)&iteratorAmbientVolume, 4)   /* +0x26AC tMenuItemLeftRightAudioSlider */
 , itemAudioMode(0x1da, &iteratorAudioMode)   /* +0x26E4 tMenuItemDisplayLeftRightChoice */
 , itemSlidingPlayList(0x1db, 0x15e, 0x2b, -0x66, 0xd, false)   /* +0x2710 tMenuItemSlidingActivated */
 , menuPlayListMenu(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)0x0)   /* +0x2758 tInsideBoxSongMenu */
 , menuAudio(0x1010, (tScreen *)screenAudio, (tMenu *)0x0, (tMenu *)0x0, 0, 0x263, 0x26, 10, (tMenuItem *)&itemMusicVolume, &itemSoundEffectsVolume, &itemEngineVolume, &itemSpeechVolume, &itemAmbientVolume, &itemAudioMode, &itemSlidingPlayList, 0)   /* +0x27E0 tOptionsMenu */
 , iteratorDisplaySpeedometer(SelectListDisplaySpeed, frontEnd.displaySpeed, &FEApp->fInputPlayer)   /* +0x2860 tListIteratorIndexed */
 , iteratorDisplayMap(SelectListDisplayMap, frontEnd.displayMap, &FEApp->fInputPlayer)   /* +0x2874 */
 , iteratorDisplayOpponentID(SelectListDisplayOpponentID, frontEnd.displayOpponentID, &FEApp->fInputPlayer)   /* +0x2888 */
 , iteratorDisplayTime(SelectListOffOn, frontEnd.displayTime, &FEApp->fInputPlayer)   /* +0x289C */
 , iteratorDisplayPosition(SelectListOffOn, frontEnd.displayPosition, &FEApp->fInputPlayer)   /* +0x28B0 */
 , iteratorDisplayLapNumber(SelectListOffOn, frontEnd.displayLapNumber, &FEApp->fInputPlayer)   /* +0x28C4 */
 , iteratorDisplaySplitTime(SelectListSplitTime, &frontEnd.checkPointType)   /* +0x28D8 tListIterator */
 , iteratorDisplaySplitDisplay(SelectListSplitDisplay, frontEnd.checkPointDisplay, &FEApp->fInputPlayer)   /* +0x28E8 tListIteratorIndexed */
 , itemDisplaySpeedometer(0x1df, (tListIterator *)&iteratorDisplaySpeedometer)   /* +0x28FC tMenuItemDisplayLeftRightChoice */
 , itemDisplayMap(0x1e1, (tListIterator *)&iteratorDisplayMap)   /* +0x2928 tMenuItemDisplayLeftRightChoice */
 , itemDisplayOpponentID(0x1e2, (tListIterator *)&iteratorDisplayOpponentID)   /* +0x2954 tMenuItemDisplayLeftRightChoice */
 , itemDisplayTime(0x1e3, (tListIterator *)&iteratorDisplayTime)   /* +0x2980 tMenuItemOnOffLeftRightChoice */

 , itemDisplayPosition(0x1e6, (tListIterator *)&iteratorDisplayPosition)   /* +0x29B0 tMenuItemOnOffLeftRightChoice */
 , itemDisplayLapNumber(0x1e7, (tListIterator *)&iteratorDisplayLapNumber)   /* +0x29E0 tMenuItemOnOffLeftRightChoice */
 , itemDisplaySplitTime(0x1e4, &iteratorDisplaySplitTime)   /* +0x2A10 tMenuItemDisplayLeftRightChoice */
 , itemDisplaySplitDisplay(0x1e5, (tListIterator *)&iteratorDisplaySplitDisplay)   /* +0x2A3C tMenuItemDisplayLeftRightChoice */
 , menuDisplayOptions(0x1020, (tScreen *)screenDisplay, (tMenu *)0x0, (tMenu *)0x0, 0, 0x1dd, 1, 10, (tMenuItem *)&itemDisplaySpeedometer, &itemDisplayMap, &itemDisplayOpponentID, &itemDisplayTime, &itemDisplaySplitTime, &itemDisplaySplitDisplay, &itemDisplayPosition, &itemDisplayLapNumber, 0)   /* +0x2A68 tOptionsMenu */
 , iteratorControllerConfigSelected(SelectListControllerConfig, frontEnd.controlConfig, &FEApp->fInputPlayer)   /* +0x2AE8 tListIteratorIndexed */
 , itemControllerConfigSelected(0x209, (tListIterator *)&iteratorControllerConfigSelected)   /* +0x2AFC tMenuItemControllerLeftRightChoice */
 , itemControllerSettings(0x20a, 0xac, 0x48, 0, 0xd, true)   /* +0x2B28 tMenuItemSlidingMenu */
 , menuControllerConfig(0x1020, (tScreen *)screenControllerConfig, (tMenu *)0x0, (tMenu *)0x0, 0, 0x208, 0, 10, (tMenuItem *)&itemControllerConfigSelected, &itemControllerSettings, 0)   /* +0x2B6C tOptionsMenu */
 , iteratorControllerShockMode('\0', '\x7f', frontEnd.shockMode, &FEApp->fInputPlayer)   /* +0x2BEC tListIteratorRangeIndexed */
 , itemControllerShockMode(0x20e, (tListIterator *)&iteratorControllerShockMode)   /* +0x2C00 tInsideBoxControllerLeftRightSlider */
 , iteratorControllerShockImpact('\0', '\x7f', frontEnd.shockImpact, &FEApp->fInputPlayer)   /* +0x2C28 tListIteratorRangeIndexed */
 , itemControllerShockImpact(0x20f, (tListIterator *)&iteratorControllerShockImpact)   /* +0x2C3C tInsideBoxControllerLeftRightSlider */

 , iteratorControllerSteeringRange1('\0', '\x7f', frontEnd.J1MAX, &FEApp->fInputPlayer)   /* +0x2C64 tListIteratorRangeIndexed */
 , itemControllerSteeringRange1(0x211, (tListIterator *)&iteratorControllerSteeringRange1, 0)   /* +0x2C78 tInsideBoxTwoWaySlider */
 , iteratorControllerDeadSpot1('\0', '\x7f', frontEnd.J1MIN, &FEApp->fInputPlayer)   /* +0x2CA8 */
 , itemControllerDeadSpot1(0x213, (tListIterator *)&iteratorControllerDeadSpot1, 1)   /* +0x2CBC tInsideBoxTwoWaySlider */
 , iteratorControllerSteeringRange2('\0', '\x7f', frontEnd.J2MAX, &FEApp->fInputPlayer)   /* +0x2CEC */
 , itemControllerSteeringRange2(0x210, (tListIterator *)&iteratorControllerSteeringRange2, 2)   /* +0x2D00 tInsideBoxTwoWaySlider */
 , iteratorControllerDeadSpot2('\0', '\x7f', frontEnd.J2MIN, &FEApp->fInputPlayer)   /* +0x2D30 */
 , itemControllerDeadSpot2(0x212, (tListIterator *)&iteratorControllerDeadSpot2, 3)   /* +0x2D44 tInsideBoxTwoWaySlider */
 , iteratorControllerJoyRange('\0', '\x7f', frontEnd.steeringRange, &FEApp->fInputPlayer)   /* +0x2D74 */
 , itemControllerJoyRange(0x214, (tListIterator *)&iteratorControllerJoyRange, 0)   /* +0x2D88 tInsideBoxTwoWaySlider */
 , iteratorControllerCenterPoint('\0', '\x7f', frontEnd.deadSpot, &FEApp->fInputPlayer)   /* +0x2DB8 */
 , itemControllerCenterPoint(0x215, (tListIterator *)&iteratorControllerCenterPoint, 1)   /* +0x2DCC tInsideBoxTwoWaySlider */
 , iteratorControllerIMax('\0', -1, frontEnd.ImaxRange, &FEApp->fInputPlayer)   /* +0x2DFC */
 , itemControllerIMax(0x216, (tListIterator *)&iteratorControllerIMax, 2)   /* +0x2E10 tInsideBoxTwoWaySlider */
 , iteratorControllerIIMax('\0', -1, frontEnd.IImaxRange, &FEApp->fInputPlayer)   /* +0x2E40 */
 , itemControllerIIMax(0x217, (tListIterator *)&iteratorControllerIIMax, 3)   /* +0x2E54 tInsideBoxTwoWaySlider */
 , menuControllerDualShock(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)&itemControllerShockMode, &itemControllerShockImpact, 0)   /* +0x2E84 tInsideBoxMenu */
 , menuControllerAnalog(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)&itemControllerSteeringRange1, &itemControllerDeadSpot1, &itemControllerSteeringRange2, &itemControllerDeadSpot2, 0)   /* +0x2EF8 tInsideBoxMenu */
 , menuControllerDualShockAnalog(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)&itemControllerShockMode, &itemControllerShockImpact, &itemControllerDeadSpot1, &itemControllerDeadSpot2, 0)   /* +0x2F6C tInsideBoxMenu */
 , menuControllerNegcon(0x1000, (tScreen *)0x0, (tMenu *)0x0, (tMenu *)0x0, 0, 0, (tMenuItem *)&itemControllerJoyRange, &itemControllerCenterPoint, &itemControllerIMax, &itemControllerIIMax, 0)   /* +0x2FE0 tInsideBoxMenu */
 , itemSaveGame(0x286, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_SaveGame)   /* +0x3054 tMemoryCardMenuItem */
 , itemLoadGame(0x287, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_LoadGame)   /* +0x3080 tMemoryCardMenuItem */
 , menuMemory(0x1020, (tScreen *)screenMemcard, (tMenu *)0x0, (tMenu *)0x0, 0, -1, 0x2e, 10, (tMenuItem *)&itemLoadGame, &itemSaveGame, 0)   /* +0x30AC tOptionsMenu */
 , menuItemUserName(0x1f8)   /* +0x312C tUserNameMenuItem */
 , menuItemUserName1(0x1f8)   /* +0x31B8 tUserNameMenuItem */
 , menuItemUserName2(0x1f8)   /* +0x3244 tUserNameMenuItem */
 , menuUserName(0x1120, (tScreen *)screenUserName, (tMenu *)0x0, (tMenu *)0x0, 0, -1, 0x20, 10, (tMenuItem *)&menuItemUserName, 0)   /* +0x32D0 tOptionsMenu */
 , iteratorChangeTrophy(screenTrophyRoom->fTrophyList, &screenTrophyRoom->thisisuseless)   /* +0x3350 tListIterator */
 , itemChangeTrophy(0x5e, &iteratorChangeTrophy, -1, 0)   /* +0x3360 tBlankMenuItemNFS4LeftRightChoice */
 , menuTrophyRoom(0x4010, (tScreen *)screenTrophyRoom, (tMenu *)0x0, (tMenu *)0x0, 0, -1, (tMenuItem *)&itemChangeTrophy, 0)   /* +0x3388 tMenuNFS4Bottom */
 , itemPinkSlipStandingsForward(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PinkSlipsContinue, 0, 10)   /* +0x3404 tMenuItemGoToMenuNFS4Button */
 , itemPinkSlipStandingsExit(0x9c, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_ExitPinkSlipsEarly, 0, 10)   /* +0x3430 tMenuItemGoToMenuNFS4Button */
 , menuPinkSlipStandings(0x1004, (tScreen *)screenPinkSlipStandings, (tMenu *)0x0, (tMenu *)0x0, 0, 0x2f4, (tMenuItem *)&itemPinkSlipStandingsForward, &itemPinkSlipStandingsExit, 0)   /* +0x345C tMenuNFS4 */
 , itemTournStandingsForward(0x5a, (tMenu*)&menuTrackInfo, 0, 0, 10)   /* +0x34D8 tMenuItemGoToMenuNFS4Button */
 , itemTournStandingsExit(0x9b, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_ExitTourney, 0, 10)   /* +0x3504 tMenuItemGoToMenuNFS4Button */
 , menuTournamentStandings(0x1004, (tScreen *)screenTournamentStandings3item, (tMenu *)0x0, (tMenu *)0x0, 0, 0x2f4, (tMenuItem *)&itemTournStandingsForward, &itemTournStandingsExit, 0)   /* +0x3530 tMenuNFS4 */
 , itemTournamentFinishedHome(0x5a, (tMenu *)&menuTournamentTrophy, 0, 0, 10)   /* +0x35AC tMenuItemGoToMenuNFS4Button */
 , menuTournamentFinished(0x1004, (tScreen *)screenTournamentStandings, (tMenu *)0x0, (tMenu *)0x0, 0, 0x2f4, (tMenuItem *)&itemTournamentFinishedHome, 0)   /* +0x35D8 tMenuNFS4 */
 , menuTournamentTrophy(0x8000, (tScreen *)screenTournamentTrophy, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_TierFinished, -1)   /* +0x3654 tMenuBlank */
 , menuPostGamePlayer1Name(0x1040, (tScreen *)screenUserName, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_FinishedPlayer1GetName, -1, 0x20, 10, (tMenuItem *)&menuItemUserName1, 0)   /* +0x36D0 tOptionsMenu */
 , menuPostGamePlayer2Name(0x1080, (tScreen *)screenUserName, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_FinishedPlayer2GetName, -1, 0x20, 10, (tMenuItem *)&menuItemUserName2, 0)   /* +0x3750 tOptionsMenu */
 , itemPostGameTrackRecordsContinue(0x5a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_PostGameMenu, -1, -1)   /* +0x37D0 tBlankMenuItemGoToMenuNFS4Button */
 , menuPostGameTrackRecords(0x21004, (tScreen *)screenTrackRecords, (tMenu *)0x0, (tMenu *)0x0, 0, 0xd4, 1, 10, (tMenuItem *)&itemPostGameTrackRecordsContinue, 0)   /* +0x37FC tOptionsMenu */
 , menuPinkSlipCongrats(0x8000, (tScreen *)screenPinkSlipCongrats, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_AwardPinkSlipsCar, -1)   /* +0x387C tMenuBlank */
 , menuBeTheCopCongrats(0x8000, (tScreen *)screenBeTheCopCongrats, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame, -1)   /* +0x38F8 tMenuBlank */
 , menuTierCompleteCongrats(0x8000, (tScreen *)screenTournamentCongrats, (tMenu *)0x0, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_TransitionFromPostGameToMainMenuAndSaveGame, -1)   /* +0x3974 tMenuBlank */
 , menuCredits(0x1010, (tScreen *)screenMain, (tMenu *)0x0, (tMenu *)0x0, 0, -1)   /* +0x39F0 tMenuBlank */
 , itemMemContinue(0x28a, (tMenu *)0x0, (void (*)(tMenuCommand&))MenuExtended_TransitionFromPostGameToMainMenu)   /* +0x3A6C tMemoryCardMenuItem */
 , menuPostGameSave(0x1040, (tScreen *)screenMemcard, (tMenu *)0x0, (tMenu *)0x0, 0, -1, 0x2e, 10, (tMenuItem *)&itemMemContinue, &itemSaveGame, 0)   /* +0x3A98 tOptionsMenu */
 {

  menuPlayerOneCarSelect.SetChildMenu(&menuPlayerTwoCarSelect);
  menuPlayerOneGarage.SetChildMenu(&menuPlayerTwoGarage);
  menuPlayerOnePinkSlipCarSelect.SetChildMenu(&menuPlayerTwoPinkSlipCarSelect);
  ((tMenuItemLeftRightSlider *)&itemMusicVolume)->SetDimensions(0,0,0x78,5);
  ((tMenuItemLeftRightSlider *)&itemSoundEffectsVolume)->SetDimensions(0,0,0x78,5);
  ((tMenuItemLeftRightSlider *)&itemEngineVolume)->SetDimensions(0,0,0x78,5);
  ((tMenuItemLeftRightSlider *)&itemSpeechVolume)->SetDimensions(0,0,0x78,5);
  ((tMenuItemLeftRightSlider *)&itemAmbientVolume)->SetDimensions(0,0,0x78,5);
  iteratorGarageCar.SetFilter(2);
  iteratorPinkSlipsCar.SetFilter(0x20);
  iteratorDealerCar.SetFilter(1);
  iteratorSellerCar.SetFilter(2);
  menuAudio.SetVerticalHelp(0);
  menuDisplayOptions.SetVerticalHelp(0);
  menuControllerConfig.SetVerticalHelp(1);
  itemTournamentFinishedHome.SetFlags(itemTournamentFinishedHome.GetFlags() | 0x40);



  /* [2026-10-14] Retail's receiver-free tail inline pairs permit actual member
     updates instead of memoryMenu/userNameMenu captures. All seven VertHelp
     setters and the flag getter/setter reproduce the complete body scope tree,
     with no additional local, and preserve the normal 3207-instruction PASS.
     Their spellings are inferred from recorded fields and update behavior;
     identical optimized bytes/scopes do not certify unique original text.
     The old W72 plain-store failure (~950 diffs) did not test this producer tree.
     Native full-debug now preserves the retail 640-byte frame. No frame pad,
     launder, dummy use or replacement pointer object has been added here.
     Initializer expression shapers and garageCarItem are removed. Literal
     original spelling and full relative SLD still require verification. */
  menuMemory.SetVerticalHelp(0);
  menuUserName.SetVerticalHelp(0);
  menuTrackRecords.SetVerticalHelp(1);
  /* [2026-08-24] Zero-insn tail scheduling boundary: 874 -> 872 diffs in the
     current constructor basin, with the instruction count unchanged at 3223. */
  menuTrophyInfo.SetVerticalHelp(0);
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



/* The tBlank* classes are ALL-INLINE (screendisplay_types.h): TransitionIsFinished / Draw bodies and the synthesized
 * destructors are emitted by the compiler as the deferred-inline batch that closes this object --
 *   TIF32, Draw32(iib), Draw32(b), ~32, TIF33, Draw33(iib), ~33  (reverse class order, declaration order inside). */

/* W60-A10: the three tBlankMenuItem::Draw nullsub exports that used to sit HERE were moved
   up into their retail VA slots (see the notes at 0x800321C8 / 0x80032200); the mis-mangled
   member definitions they shadowed were deleted. */
