/* frontend/common/front.cpp -- RECONSTRUCTED (front-end orchestration + tAllScreens ctor/dtor; C++ TU)
 *   43 fns: free Front_* / stream builders / utility fns + tAllScreens ctor (constructs all
 *   screen objects) + dtor. Free fns in ns nfs4::FRONTEND::COMMON::Front.
 */
#include "front.h"

/* ---- Front.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes, .bss=zero) ---- */
/* overRide + ComingIntoTheFrontEndTheVeryFirstTime lead Front.obj's run at
   0x800517e8, BEFORE the two initialised cop-model tables -- a tentative
   definition can never do that (16E), so retail initialised them explicitly.
   gcc-2.8 has no zero-initialized-in-bss pass, so `= 0` keeps them in .data at
   the head of the definition order (17B EXTERN-ORDER LAW). */
int          overRide = 0;   /* @0x800517e8 */
int          ComingIntoTheFrontEndTheVeryFirstTime = 0;   /* @0x800517ec */
static tCarModels regularCopModels[7][5] = { 24, 24, 24, 23, 22, 24, 24, 24, 23, 22, 24, 24, 24, 24, 22, 24, 24, 24, 24, 25, 26, 26, 26, 24, 25, 26, 26, 26, 24, 25, 27, 27, 27, 27, 27 };   /* @0x800517f0; SYM STAT */
static tCarModels superCopModels[7][5] = { 26, 26, 26, 24, 25, 26, 26, 26, 24, 25, 26, 26, 26, 24, 25, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27 };   /* @0x8005187c; SYM STAT */
char         gFE_Cheats[5];   /* @0x80051908  (bss(zero)) */
int          gPSXMemCardFull[1];   /* @0x80051910; SYM-CARRIER: gPSXMemCardFull */
int          colourChosen[8];   /* @0x80051914  (bss(zero)) */
tAllScreens  *gAllScreens[1];   /* @0x80051934; SYM-CARRIER: gAllScreens -- PTR STRUCT, 4 B.
                                   The [0] form emitted NOTHING and let the dead
                                   _usePlayerUpgrades occupy retail's 4 bytes. */
BOOL         memCardReadOK[1];   /* @0x80051938; SYM-CARRIER: memCardReadOK -- BOOL[1] forces retail value-load addressing */
tCarInLineup CarLineup[9];   /* @0x8005193c  (bss(zero)) */
char         picked[11];   /* @0x80051960  (bss(zero)) */


/* The retail headers supplied these tiny default constructors inline.  They
   must be visible before the first `new tAllScreens`: that is where CC1PLPSX
   synthesizes the aggregate's internal-linkage constructor. */
inline tDialogBase::tDialogBase()
{
  *(void **)&_vf = (void *)tDialogBase_vtable;
  MaxW = 0x120;
  currentlyOn = 0;
  reservedheight = 0;
  MaxH = 0;
  OffsetY = 0;
  OffsetX = 0;
  height = 0;
  width = 0;
  top = 0;
  left = 0;
  specificPlayer = -1;
  fDefault = 0;
  timeOutTicks = 0;
}

inline tDialogMessageString::tDialogMessageString()
{
  *(void **)&_vf = (void *)tDialogMessageString_vtable;
  Centerit = 0;
  fFullyOpen = 0;
  timeOutTicks = 0;
  fFadeText = 0x80;
}

inline tDialogBackUpOnly::tDialogBackUpOnly(int)
{
  *(void **)&_vf = (void *)tDialogBackUpOnly_vtable;
}

inline tScreenMain::tScreenMain()
{
  *(void **)&_vf = (void *)tScreenMain_vtable;
}

inline tScreenCarSelectDuel::tScreenCarSelectDuel()
{
  *(void **)&_vf = (void *)tScreenCarSelectDuel_vtable;
}

inline tScreenCarSelectTwoPlayer::tScreenCarSelectTwoPlayer()
  /* The dummy CarDialog argument makes the inherited screen vptr assignment
     occur before the member's inlined construction, matching C++'s real
     compiler-generated vptr phase without changing the reconstructed layout. */
  : CarDialog((*(void **)&_vf = (void *)tScreenCarSelectTwoPlayer_vtable, 0))
{
}

inline tScreenPinkSlipsCarSelect::tScreenPinkSlipsCarSelect()
{
  *(void **)&_vf = (void *)tScreenPinkSlipsCarSelect_vtable;
}

inline tScreenTrackRecords::tScreenTrackRecords()
{
  *(void **)&_vf = (void *)tScreenTrackRecords_vtable;
}

inline tScreenTrackInfo::tScreenTrackInfo()
{
  *(void **)&_vf = (void *)tScreenTrackInfo_vtable;
}

inline tScreenTrackSelect::tScreenTrackSelect()
{
  *(void **)&_vf = (void *)tScreenTrackSelect_vtable;
}

inline tScreenTournamentTrophy::tScreenTournamentTrophy()
{
  *(void **)&_vf = (void *)tScreenTournamentTrophy_vtable;
}

inline tScreenTrophyInfo::tScreenTrophyInfo()
{
  *(void **)&_vf = (void *)tScreenTrophyInfo_vtable;
}

inline tScreenDisplay::tScreenDisplay()
{
  *(void **)&_vf = (void *)tScreenDisplay_vtable;
}

inline tScreenUserName::tScreenUserName()
{
  *(void **)&_vf = (void *)tScreenUserName_vtable;
}

inline tScreenPinkSlipCongrats::tScreenPinkSlipCongrats()
{
  *(void **)&_vf = (void *)tScreenPinkSlipCongrats_vtable;
}

inline tScreenTournamentStandings3item::tScreenTournamentStandings3item()
{
  *(void **)&_vf = (void *)tScreenTournamentStandings3item_vtable;
}

inline tScreenPinkSlipStandings::tScreenPinkSlipStandings()
{
  *(void **)&_vf = (void *)tScreenPinkSlipStandings_vtable;
}

inline tScreenPinkSlips::tScreenPinkSlips()
{
  *(void **)&_vf = (void *)tScreenPinkSlips_vtable;
}

inline tScreenBeTheCopCongrats::tScreenBeTheCopCongrats()
{
  *(void **)&_vf = (void *)tScreenBeTheCopCongrats_vtable;
}

inline tScreenTournamentCongrats::tScreenTournamentCongrats()
{
  *(void **)&_vf = (void *)tScreenTournamentCongrats_vtable;
}


/* ---- Front_ConstructAll  [FRONT.CPP:231-266] ---- */

/* Decoded Phase 83: Front_ConstructAll() - one-shot allocate all menu screens (400 B). Sets up
   gAllScreens[0] layout: screenMain, screenCarSelect, screenCarSelectDuel, screenCarSelectTwoPlayer,
   screenPinkSlips*, screenTrackRecords, screenTrackInfo, screenTrackSelect, screenTournSelect,
   screenTournamentStandings/Trophy, screenTrophyRoom/Info, screenControllerConfig, screenDisplay,
   screenAudio, screenMemcard. These are all the front-end screens linked by gAllScreens[0].
   
   [ghidra-meta] section: front.text */

void Front_ConstructAll(void)

{
  gAllScreens[0] = new tAllScreens;
  /* MATCH: retail publishes screenMain before the remaining sub-screen pointers. */
  screenMain = &gAllScreens[0]->screenMain;
  screenCarSelect = &gAllScreens[0]->screenCarSelect;
  screenCarSelectDuel = &gAllScreens[0]->screenCarSelectDuel;
  screenCarSelectTwoPlayer = &gAllScreens[0]->screenCarSelectTwoPlayer;
  screenCarSelectPlayerTwo = &gAllScreens[0]->screenCarSelectPlayerTwo;
  screenPinkSlipsCarSelectTwoPlayer = &gAllScreens[0]->screenPinkSlipsCarSelectTwoPlayer;
  screenPinkSlipsCarSelectPlayerTwo = &gAllScreens[0]->screenPinkSlipsCarSelectPlayerTwo;
  screenTrackRecords = &gAllScreens[0]->screenTrackRecords;
  screenTrackInfo = &gAllScreens[0]->screenTrackInfo;
  screenTrackSelect = &gAllScreens[0]->screenTrackSelect;
  screenTournSelect = &gAllScreens[0]->screenTournSelect;
  screenTournamentStandings = &gAllScreens[0]->screenTournamentStandings;
  screenTournamentTrophy = &gAllScreens[0]->screenTournamentTrophy;
  screenTrophyRoom = &gAllScreens[0]->screenTrophyRoom;
  screenTrophyInfo = &gAllScreens[0]->screenTrophyInfo;
  screenControllerConfig = &gAllScreens[0]->screenControllerConfig;
  screenDisplay = &gAllScreens[0]->screenDisplay;
  screenAudio = &gAllScreens[0]->screenAudio;
  screenMemcard = &gAllScreens[0]->screenMemcard;
  screenUserName = &gAllScreens[0]->screenUserName;
  screenPinkSlipCongrats = &gAllScreens[0]->screenPinkSlipCongrats;
  screenPinkSlipStandings = &gAllScreens[0]->screenPinkSlipStandings;
  screenTournamentStandings3item = &gAllScreens[0]->screenTournamentStandings3item;
  screenPinkSlips = &gAllScreens[0]->screenPinkSlips;
  screenBeTheCopCongrats = &gAllScreens[0]->screenBeTheCopCongrats;
  screenTournamentCongrats = &gAllScreens[0]->screenTournamentCongrats;
  FEApp[0] = new tFEApplication;
  menuDefs[0] = new tGlobalMenuDefs;
  return;
}



/* ---- Front_DeleteAll  [FRONT.CPP:270-273] ---- */

/* Decoded Phase 83: Front_DeleteAll() - free all FE allocations (100 B). Mirror of
   Front_ConstructAll.
   
   [ghidra-meta] section: front.text */

void Front_DeleteAll(void)

{
  if (gAllScreens[0] != (tAllScreens *)0x0) {
    delete gAllScreens[0];
  }
  if (FEApp[0] != (tFEApplication *)0x0) {
    delete FEApp[0];
  }
  if (menuDefs[0] != (tGlobalMenuDefs *)0x0) {
    delete menuDefs[0];
  }
  return;
}



/* ---- Front_ResetSettingsForCar  [FRONT.CPP:280-284] ---- */

/* Decoded Phase 83: Front_ResetSettingsForCar(int playerIdx, int carID) - reset per-car tuning to
   defaults when car changed (80 B).
   
   [ghidra-meta] section: front.text */

void Front_ResetSettingsForCar(int player,int car)

{
  frontEnd.settingsActive[player] = frontEnd.settingsActive[player] & ~(ushort)(1 << car);
  frontEnd.carDownforce[player][car] = '2';
  frontEnd.suspension[player][car] = '2';
  frontEnd.engineTuning[player][car] = '\x03';
  return;
}



/* ---- Front_ResetSettingsMenu  [FRONT.CPP:288-294] ---- */

/* Decoded Phase 83: Front_ResetSettingsMenu(int) - reset menu-display state (72 B, 2 callers).
   
   [ghidra-meta] section: front.text */

void Front_ResetSettingsMenu(int player)

{
  int i;
  int car;
  
  car = 0;
  do {
    Front_ResetSettingsForCar(player,car);
    car = car + 1;
  } while (car < 0x30);
  return;
}



/* ---- Front_ResetPSXController  [FRONT.CPP:299-309] ---- */

/* Decoded Phase 83: Front_ResetPSXController(int port, int) - revert controller config to defaults(108 B, 6 callers).
   
   [ghidra-meta] section: front.text */

void Front_ResetPSXController(int player,int config)

{
  
  timedwait(10);
  PAD_update();
  frontEnd.controlType[player] = (ushort)gPadinfo.buf[player * 4].ID;
  frontEnd.controlConfig[player] = (char)config;
  return;
}



/* ---- Front_ResetPSXAnalogs  [FRONT.CPP:318-330] ---- */

/* Decoded Phase 83: Front_ResetPSXAnalogs(int port) - reset analog stick calibration (68 B).
   
   [ghidra-meta] section: front.text */

void Front_ResetPSXAnalogs(int player)

{
  frontEnd.steeringRange[player] = 'y';
  frontEnd.deadSpot[player] = '\n';
  frontEnd.ImaxRange[player] = -1;
  frontEnd.IImaxRange[player] = -1;
  frontEnd.J1MAX[player] = '\x7f';
  frontEnd.J1MIN[player] = '\x06';
  frontEnd.J2MAX[player] = '\x7f';
  frontEnd.J2MIN[player] = '\x06';
  return;
}



/* ---- GetPSXPadValue  [FRONT.CPP:333-465] ---- */

/* int GetPSXPadValue(int value, int player)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x80027194 block=CODE size=888B
     Direct callers: 51
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:333
     SYM data: 2 regparms / 0 args / 0 autos
     Sample callers: Front_BuildStream, Controller_SetRamp
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

/* MATCH W63/W64 (2026-08-13): source-shape reconstruction from the raw oracle and
   SLD statement map.  Keep each packed control in a named assignment and put
   bit 0 in the following return; flatten tagged OR trees with the tag before
   the two byte fields.  This recovers retail's shared negative/positive tails
   and cuts the authoritative residual 160 -> 18 (212 -> 222 instructions,
   retail 222).  The no-pad branch needs the zero-instruction fence on the ID
   path: it preserves `bnez; li 0x53; lbu ID; j; nop; type=0` while allowing
   gcc to reuse the single 0x53 materialization at the switch join.  The
   digital positive arm is a two-stage source expression with its low-byte OR
   expressed as a compound assignment in the return.  That makes `newControl`
   the accumulator through the merge, removes its local tail, and restores
   retail's shared `0x274cc` funnel at exact function length.

   W60-A10 -- the 18-diff residual is FULLY CHARACTERISED and is NOT a source
   shape.  It is 6 instructions in 3 un-merged case tails (0x53/0x10000000,
   0x53/0x40000000, 0x23/0x800000): retail writes the LAST `or` back into the
   accumulator's own register (`or a2,a2,a1` then `ori v0,a2,1` in the `j`
   delay slot), ours gives the OR result a fresh dest (`or a0,a2,a1`,
   `ori v0,a0,1`) -- it coalesced the result with the now-dead ADDRESS BASE
   ($a0) instead of with the accumulator.  Everything up to and including the
   preceding sll/subu/or chain is byte-exact and the count is exact (222/222),
   so the whole gap is one local-alloc combine_regs/QTY tie-break
   (local-alloc.c ~1867: the source must be block-local and die exactly once --
   both candidates qualify here, so the numeric scan decides).
   FALSIFIED (all measured against base 18; every one ADDS instructions by
   breaking the cross-jump tail merge): compound-assign accumulator
   `return (newControl |= lo) | 1;` per site 53 / 63 / 20 and all three 52;
   the same split as two plain statements 53 / 63 / 20 / 52; grouping the
   tag+hi terms in parentheses 53; swapping the hi/lo OR operand order
   93 / 51 / 42; folding the `| 1` into the assignment 53.  Yoda
   `return 1 | newControl;` is exactly neutral (18).
   => qtytrace lane, not a spelling. */

/* W61-A17 (base 18, unchanged) -- THE GLOBAL-PSEUDO DIAGNOSIS, read off a
   real CC1PLPSX -dl dump of this TU: `newControl` is reg/v 82, a GLOBAL pseudo
   (refs=30, live=27, hard reg a0) because it is assigned in all 13 case
   blocks, so every case's LAST `or` writes a0 (`or a0,a2,a1`), whereas
   retail's last `or` writes the per-case accumulator (`or a2,a2,a1`) -- its
   last-or dest is a BLOCK-LOCAL pseudo.  The SYM's `REG newControl = $2 (v0)`
   is the RETURN value (`ori v0,a2,1`), i.e. retail's newControl holds the
   value INCLUDING the `| 1`.
   FALSIFIED, all re-gated against base 18.  The three residual sites are the
   MERGED TAILS of 2-3 cases each (G1 .L80027398 = 0x100000 / -0x80000000 /
   0x10000000, G2 .L800273D0 = 0x400000 / 0x20000000 / 0x40000000,
   G4 .L8002744C = 0x53:0x800000 + 0x23:0x800000), which is why a per-site
   spelling breaks the post-reload cross_jump.  Applying the compound-assign to
   EVERY MEMBER of a group at once -- the untried half of the W60-A10 receipt
   -- still loses: G1 all-3 56, G2 all-3 20 (count-exact), G4 both 20,
   G1+G2+G4 30, ALL-13 47.
   Folding the `| 1` into the assignment (`newControl = ... | 1; return
   newControl;`), the shape the SYM implies, lands a DIFFERENT far basin:
   252 for the 11 plain sites, 308 for all 13 (count-exact 222/222).  The
   no-variable spelling `return (expr) | 1;` scores identically, so gcc builds
   the same RTL for both; in that basin the tag constant absorbs the 1
   (0x3000001) and the whole block layout changes, so it is not a partial
   landing.  => the remaining lever is the local-alloc numeric scan (qtytrace
   class), not a spelling.  */

/* W62-A15 (base 18, unchanged) -- QUANTIFIED HARDNESS CERTIFICATE.  The
   handout is now READ OFF the real CC1PLPSX `-dg` dump of this TU (-G0;
   harness scratchpad/w62a15/dumpg.py):

       ;; 9 regs to allocate: 82 83 88 80 252 255 260 325 81
       ;; 82 conflicts:   82 2 29
       ;; 82 preferences: 4 5 6
       ;; Register 82 used 30 times across 27 insns; dies in 12 places
       ;; Register dispositions: ... 82 in 4 ...

   82 = newControl.  Per the 13A SET_PREFERENCE law (global.c:1538/1584) its
   preference set is the accumulation of every SET's FIRST-OPERAND home over
   the 13 case blocks -- {a0, a1, a2} -- and find_reg takes the LOWEST FREE
   PREFERENCE, so a0 wins unconditionally.  Retail agrees with us at 10 of the
   13 sites (a0 there too) and differs ONLY in the 3 merged tails, where its
   dest is op0's OWN register (`or a2,a2,a1` / `or a1,a1,v1` / `or a1,a1,a0`)
   = a LOCAL qty that qty_combine tied to the first operand.  One global
   allocno cannot be a2 at one tail and a1 at two, so retail's three tails are
   genuinely block-local while its other ten are the same a0 global as ours.

   THE OPERAND-ORDER LEAD IS CLOSED: at all three sites ours and retail carry
   the SAME two operands in the SAME order (`or ?,a2,a1`); only the DEST
   differs, so there is no operand order left to swap.

   NEW FALSIFICATIONS (15 measurements, all re-gated here, all reverted).
   Three spellings x five groupings, where G1 = .L80027398 (0x100000 /
   -0x80000000 / 0x10000000), G2 = .L800273D0 (0x400000 / 0x20000000 /
   0x40000000), G4 = .L8002744C (0x53:0x800000 + 0x23:0x800000):

       spelling                            G4   G1   G2  G1+G2  G1+G2+G4
       block-scope `{ int newControl; ... }` 58  112   80    156      206
       anonymous   `return (expr) | 1;`      58  112   80    156      206
       fold        `nc = expr | 1; ret nc`   58  112   80    156      206

   The three spellings are BYTE-IDENTICAL at every grouping => gcc builds the
   same RTL for all of them and this axis is exhausted; do not re-sweep it.
   The whole-function fold (all 11 plain sites) re-measured at 252 diffs /
   224 insns -- +2 over the oracle's 222, an entirely different block layout,
   confirming the W60-A10 reading.
   => the cure needs newControl to be the v0-homed `|1` global at ALL 13 sites
   (which the SYM's `REG newControl = $2 (v0)` says it was) WITHOUT the
   whole-function fold's basin change: a cse/expression-identity device that
   keeps the `1` out of the tag constant, not a spelling and not an allocator
   dial.  Harnesses: scratchpad/w62a15/pad{,2,3,4,5}.py. */
int GetPSXPadValue(int value,int player)

{
  int newControl;
  int type;
  
  PAD_update();
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  __asm__("");
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
  switch (type) {
  case 0x53:
  case 0x73:
    switch (value) {
    case 0x800000:
      newControl = player << 0x1e |
                   (0x7f - (byte)frontEnd.J1MIN[player]) * 0x10000 |
                   (0x7f - (byte)frontEnd.J2MAX[player]) * 0x100;
      return newControl | 1;
    case 0x200000:
      newControl = player << 0x1e |
                   ((byte)frontEnd.J1MIN[player] + 0x80) * 0x10000 |
                   ((byte)frontEnd.J1MAX[player] + 0x80) * 0x100;
      return newControl | 1;
    case 0x100000:
      newControl = player << 0x1e |
                   0x1000000 |
                   (0x7f - (byte)frontEnd.J1MIN[player]) * 0x10000 |
                   (0x7f - (byte)frontEnd.J1MAX[player]) * 0x100;
      return newControl | 1;
    case 0x400000:
      newControl = player << 0x1e |
                   0x1000000 |
                   ((byte)frontEnd.J1MIN[player] + 0x80) * 0x10000 |
                   ((byte)frontEnd.J1MAX[player] + 0x80) * 0x100;
      return newControl | 1;
    case -0x80000000:
      newControl = player << 0x1e |
                   0x2000000 |
                   (0x7f - (byte)frontEnd.J2MIN[player]) * 0x10000 |
                   (0x7f - (byte)frontEnd.J2MAX[player]) * 0x100;
      return newControl | 1;
    case 0x20000000:
      newControl = player << 0x1e |
                   0x2000000 |
                   ((byte)frontEnd.J2MIN[player] + 0x80) * 0x10000 |
                   ((byte)frontEnd.J2MAX[player] + 0x80) * 0x100;
      return newControl | 1;
    case 0x10000000:
      newControl = player << 0x1e |
                   0x3000000 |
                   (0x7f - (byte)frontEnd.J2MIN[player]) * 0x10000 |
                   (0x7f - (byte)frontEnd.J2MAX[player]) * 0x100;
      return newControl | 1;
    case 0x40000000:
      newControl = player << 0x1e |
                   0x3000000 |
                   ((byte)frontEnd.J2MIN[player] + 0x80) * 0x10000 |
                   ((byte)frontEnd.J2MAX[player] + 0x80) * 0x100;
      return newControl | 1;
    }
    break;
  case 0x23:
    switch (value) {
    case 0x800000:
      newControl = player << 0x1e |
                   (0x7f - (byte)frontEnd.deadSpot[player]) * 0x10000 |
                   (0x7f - (byte)frontEnd.steeringRange[player]) * 0x100;
      return newControl | 1;
    case 0x200000:
      newControl = player << 0x1e |
                   ((byte)frontEnd.deadSpot[player] + 0x80) * 0x10000;
      return (newControl |=
              ((byte)frontEnd.steeringRange[player] + 0x80) * 0x100) | 1;
    case 0x4000:
      newControl = player << 0x1e |
                   0x1000000 |
                   (byte)frontEnd.ImaxRange[player] * 0x100;
      return newControl | 1;
    case 0x8000:
      newControl = player << 0x1e |
                   0x2000000 |
                   (byte)frontEnd.IImaxRange[player] * 0x100;
      return newControl | 1;
    case 0x400:
      newControl = player << 0x1e | 0x30aff01;
      return newControl;
    }
    break;
  }
  newControl = player << 0x1a | value << 8 | 2;
  return newControl;
}



/* ---- SetPads  [FRONT.CPP:474-503] ---- */

/* void SetPads()
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002750C block=CODE size=316B
     Direct callers: 2
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:474
     Sample callers: Front_SecondaryMemCardCheck, LoadGame
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

/* W57-A4 (2026-08-09) 37 -> 0, SEALED.  Three source-shape fixes, all SYM-driven:
   (1) the Ghidra-invented `int *pTicks = &ticks[0]` local is NOT in the SYM -- reading
       `ticks[0]` directly lets gcc LICM only the %hi into fp and ride the %lo in the load
       displacement (`lui fp,%hi; lw s0,%lo(fp)`), vs our extra `addiu fp,v0,%lo`.
   (2) the Ghidra-invented `tfrontEnd *ptVar7` pointer-walk is likewise absent from the SYM;
       `frontEnd.AnalogOn[j]` index form gives the SAME strength-reduced $s7 GIV but places
       its init AFTER the LICM hoist (retail's prologue order).
   (3) 🏆 LOOP UN-ROTATION on the PadInfoMode scan: `i = 0; while (1) { if (i >= numoffsets)
       break; ...; i++; }` reproduces retail's head test + unconditional `j` back-edge; a
       plain `for (i=0;i<numoffsets;i++)` rotates to a `blez` zero-trip guard + bottom test.
       This ALSO fixed the whole 3-way {pad,gotone,theanalogoffset} s1/s3/s4 rotation for
       free -- the loop shape was driving the allocation, not the other way round. */
void SetPads(void)

{
  int j;
  int pad;

  j = 0;
  while (j < 2) {
    int LookingFor;
    int starttick;
    LookingFor = 4;
    pad = j << 4;
    if (frontEnd.AnalogOn[j] != 0) {
      LookingFor = 7;
    }
    starttick = ticks[0];
    bool waiting;
    do {
      waiting = false;
      if (ticks[0] - starttick < 0x80) {
        waiting = PadGetState(pad) != 6;
      }
    } while (waiting);
    if (PadGetState(pad) == 6) {
      int theanalogoffset;
      bool gotone;
      int numoffsets;
      int i;
      theanalogoffset = 0;
      gotone = false;
      numoffsets = PadInfoMode(pad,4,-1);
      i = 0;
      while (1) {
        if (i >= numoffsets) break;
        if (PadInfoMode(pad,4,i) == LookingFor) {
          gotone = true;
          theanalogoffset = i;
        }
        i++;
      }
      if (gotone) {
        PadSetMainMode(pad,theanalogoffset,0);
      }
    }
    j++;
  }
  return;
}



/* ---- InitFrontEndStructure  [FRONT.CPP:507-664] ---- */

/* void InitFrontEndStructure()
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x80027648 block=CODE size=760B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:507
     Sample callers: Front_InitialMemCardCheck
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

void InitFrontEndStructure(void)

{
  int j;
  int i;

  frontEnd.randomSeed = 0;
  frontEnd.catchup = '\x01';
  frontEnd.currentPlayer = '\0';
  frontEnd.cheatFlags = 0;
  frontEnd.cheatFlagsActive = 0;
  frontEnd.secretFlags = 0;
  frontEnd.gameMode = '\0';
  frontEnd.raceType = '\0';
  frontEnd.skillLevel = '\0';
  frontEnd.headstart = '\x14';
  for (i = 0; i < 5; i++) {
    frontEnd.track[i] = '\0';
    frontEnd.lapind[i] = '\0';
    frontEnd.trackmirrored[i] = '\0';
    frontEnd.trackdirection[i] = '\0';
    frontEnd.timeOfDay[i] = '\0';
    frontEnd.weather[i] = '\0';
    frontEnd.traffic[i] = '\0';
    frontEnd.situations[i] = '\0';
    frontEnd.checkPointDisplay[i] = '\0';
    frontEnd.playerCar[i] = '\0';
  }
  frontEnd.localSpeech = '\0';
  frontEnd.opponentUpgrades = '\0';
  frontEnd.dealerCar = '\0';
  frontEnd.sellerCar = '\0';
  frontEnd.damage = '\x01';
  frontEnd.laps = '\0';
  frontEnd.recordlaptime =
       Stattool_ReturnRecordLapTime((ushort)(byte)frontEnd.track[0]);
  frontEnd.tractionassist = '\x01';
  frontEnd.bestline = '\x01';
  frontEnd.checkPointType = '\x01';
  frontEnd.tournament = '\0';
  frontEnd.specialevent = '\0';
  frontEnd.tier = '\0';
  frontEnd.upgrade = '\0';
  frontEnd.policeTier = '\0';
  frontEnd.policeMission = '\0';
  frontEnd.measurement = '\0';
  for (i = 0; i < 2; i++) {
    frontEnd.AnalogOn[i] = 1;
    frontEnd.ABS[i] = '\0';
    frontEnd.transmission[i] = '\x01';
    frontEnd.displaySpeed[i] = '\0';
    frontEnd.displayTach[i] = '\x01';
    frontEnd.displayMap[i] = '\x01';
    frontEnd.displayOpponentID[i] = '\x01';
    frontEnd.displayTime[i] = '\x01';
    frontEnd.displayPosition[i] = '\x01';
    frontEnd.displayLapNumber[i] = '\x01';
    frontEnd.displayMirror[i] = '\0';
    frontEnd.pinkSlipsWins[i] = '\0';
    frontEnd.pinkSlipsCash[i] = 0;
    frontEnd.pinkSlipsForfeit = -1;
    frontEnd.cameraType[i][1] = '\x03';
    frontEnd.cameraType[i][2] = '\x06';
    frontEnd.cameraType[i][3] = '\a';
    frontEnd.cameraType[i][0] = '\0';
    frontEnd.playerNameList[i][0] = '\0';
    for (j = 0; j < 4; j++) {
      frontEnd.cameraSway[i][j] = '\0';
    }
    frontEnd.rampSteer[i] = '\x01';
    frontEnd.rampGas[i] = '\x01';
    frontEnd.rampBrake[i] = '\x01';
    for (j = 0; j < 0x30; j++) {
      frontEnd.carColors[i][j] = ((tCarInfo *)carManager.GetCarFromID((short)j))->fDefaultColor;
    }
    frontEnd.controlType[i] = 0x41;
    frontEnd.controlConfig[i] = '\0';
    frontEnd.defaultedPlayerName[i] = '\x01';
    frontEnd.shockMode[i] = 'U';
    frontEnd.shockImpact[i] = 'U';
    Front_ResetPSXAnalogs(i);
    Front_ResetPSXController(i,0);
  }
  frontEnd.numBTracksActivated = '\0';
  Front_ResetSettingsMenu(0);
  Front_ResetSettingsMenu(1);
  frontEnd.oppNumber = '\x01';
  frontEnd.audioMode = '\x02';
  frontEnd.oppCar = '\0';
  frontEnd.language = '\0';
  frontEnd.musicVolume = 'U';
  frontEnd.sfxVolume = 'U';
  frontEnd.narrationVolume = 'U';
  frontEnd.engineVolume = 'U';
  frontEnd.ambientVolume = 'U';
  frontEnd.song = '\0';
  /* MATCH 2026-08-03 (18->PASS): the unsized-array declarations expose
     address pseudos which GCC can schedule and reuse; scalar absolute-store
     macros reserve $at and cannot reproduce retail's four-store sequence. */
  gMasterMusicLevel[0] = 0x55;
  gMasterSFXLevel[0] = 0x55;
  gMasterFENarrationLevel[0] = 0x55;
  gMasterAmbientLevel[0] = 0x55;
  frontEnd.sensitivity = '\0';
  frontEnd.GotAPlayList = 0;
  CreditManager.Setup();
  return;
}



/* ---- LoadConfig  [FRONT.CPP:810-811] ---- */

/* int LoadConfig()
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x80027940 block=CODE size=8B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:811
     Sample callers: Front_Menu
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

int LoadConfig(void)

{
  return 0;
}



/* ---- Front_InitialMemCardCheck  [FRONT.CPP:819-847] ---- */

/* Boot-time memcard state initialization.MEMCARDFRONTENDISINITTED = 0;
     gPSXMemCardFull = 0;
     memCardReadOK = 0;
     Stattool_GetAllDefaultRecords(Stats_gTrackRecords, 0);  // load if empty
     InitFrontEndStructure();
     frontEnd.language = 0;
   
   The fOverride=0 in Stattool_GetAllDefaultRecords means 'load defaults only
   if records are empty'. Cheat 0x14 calls the same fn with fOverride=1 to
   forcibly reset records.Decoded Phase 41.
   
   [ghidra-meta] section: front.text */

void Front_InitialMemCardCheck(void)

{
  MEMCARDFRONTENDISINITTED[0] = 0;
  gPSXMemCardFull[0] = 0;
  memCardReadOK[0] = 0;
  Stattool_GetAllDefaultRecords((tRecordBuffer *)&Stats_gTrackRecords,false);
  InitFrontEndStructure();
  frontEnd.language = '\0';
  return;
}



/* ---- Front_SecondaryMemCardCheck  [FRONT.CPP:852-872] ---- */

/* Decoded Phase 83: Front_SecondaryMemCardCheck() - re-validate memcard on slot 2 (200 B). Used
   during 2-player setup.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-08-16] SYM restores outer loop `j` ($s1, cards 0..1) and nested retry
   loop `i` ($s0, retries 0..2). LoadGame() sets memCardReadOK if successful (sVar1==0); else
   clears. After all retries: continue to next card. After loop: DeInit_Memcard + SetPads +
   MEMCARDFRONTENDISINITTED=1. Note: outer loop has no explicit
   termination - exits via the iVar3>=2 check at top of loop body. */

void Front_SecondaryMemCardCheck(void)

{
  short sVar1;
  int i;
  int j;

  MEMCARDFRONTENDISINITTED[0] = 0;
  Init_Memcard(false,0);
  j = 0;
  /* MATCH: loop-top guard (j<2) with the RARE exit/cleanup pushed OUT-OF-LINE after
     the loop (oracle: beqz skips to the tail block at the bottom; the loop body is the
     fall-through). The equivalent do{if(1<j){exit;return;}...}while(true) shape
     inlined the exit block at the top, duplicating/misplacing it vs the oracle.
     EXIT-IN-THE-MIDDLE keeps the test+unconditional-j-back TOP-TEST shape the oracle uses
     (a plain `while(card_i<2)` rotates to a bottom-test loop instead). */
  while (true) {
    if (!(j < 2)) break;
    i = 0;
    if (memCardReadOK[0] == 0) {
      do {
        sVar1 = LoadGame((short)j,false,0);
        memCardReadOK[0] = (int)(sVar1 == 0);
        i = i + 1;
        if (2 < i) break;
      } while (memCardReadOK[0] == 0);
    }
    memCardReadOK[0] = 0;
    j = j + 1;
  }
  DeInit_Memcard();
  SetPads();
  MEMCARDFRONTENDISINITTED[0] = 1;
}



/* ---- Front_InitGraphics  [FRONT.CPP:880-915] ---- */

/* Decoded Phase 83: Front_InitGraphics() - one-shot front-end graphics init (120 B, 2 callers).Loads font textures, FE shape table from FRONT.BIN.
   
   [ghidra-meta] section: front.text */

void Front_InitGraphics(void)

{
  int iVar1;
  char buffer [40];

  initlinkmode(0,1,1);
  sprintf(buffer,"%szzFE.viv",Paths_Paths[0x23]);
  iVar1 = FILE_addbigsync(buffer,(void *)0x0,100,gFEBigHandle);
  if (iVar1 == 0) {
    do {
                    /* WARNING: Do nothing block with infinite loop */
    } while( true );
  }
  Platform_ResetDCTBuffer();
  Init_PSX_FrontEnd();
  return;
}



/* ---- Front_InitGraphicsAndDisplayLoading  [FRONT.CPP:919-920] ---- */

/* Decoded Phase 83: Front_InitGraphicsAndDisplayLoading() - init graphics + show loading screen (32
   B). Wrapper that calls InitGraphics + posts loading overlay.
   
   [ghidra-meta] section: front.text */

void Front_InitGraphicsAndDisplayLoading(void)

{
  Front_InitGraphics();
  return;
}



/* ---- Front_Menu  [FRONT.CPP:934-1046] ---- */

/* Decoded Phase 83: Front_Menu(tFront_ProcessingType) - top-level front-end menu driver (692 B).Mode dispatcher: SETUP_RACE / RETURN_FROM_RACE / SAVE / LOAD / etc. Handles raceType==2
   (tournament) with replay-replay==0 special path.
   
   [ghidra-meta] section: front.text */

/* MATCH: PASS (173/173).  The retail source is a switch with InitialLoad
   falling through to GameSetup, followed by the PostGame case.  Its car-buy
   guard materializes a zero-initialized condition accumulator, then assigns
   the money comparison only when the owned-car test succeeds.  Compound
   addition preserves the `extraMoney + one` expression tree, while storing
   the loading-text literal before initializing the shared `one` value gives
   retail's address-materialization order and s4 lifetime. */

int Front_Menu(tFront_ProcessingType role)

{
  long extraMoney;
  int result;
  int one;
  int needCar;
  tMenuCommand tempCommand;
  
  result = kApp_Command_StartRace;
  _7tScreen_fSuppressLoadingText = 1;
  one = 1;
  gLargestUnused[0] = largestunused();
  FeAudio_InitCommentary((uint)(byte)frontEnd.language,0);
  InitializeSpinningCars();
  Front_ConstructAll();
  needCar = 0;
  if ((int)((uint)carManager.GetNumOwnedCars(0) << 0x10) < 1) {
    needCar = tournamentManager.fMoney < one;
  }
  if (needCar) {
    extraMoney = carManager.CheapestCarStockPrice();
    tournamentManager.fMoney += extraMoney + one;
  }
  switch (role) {
  case kFront_InitialLoad:
    LoadConfig();
  case kFront_QuitToGameSetup:
    if (gUseFrontend != 0) {
      MenuExtended_TransitionFromPostGameToMainMenu(tempCommand);
      result = FEApp[0]->RunFrontEnd();
    }
    break;
  case kFront_QuitToPostGame:
    gCalculateVictory = (char)one;
    if ((frontEnd.raceType == RaceType_Tournament) && (GameSetup_gData.replayMode == 0)) {
      tournamentManager.AdvanceToNextTrack();
      tournamentManager.UpdateAwardInformation();
    }
    else if ((frontEnd.raceType == RaceType_PinkSlips) && (GameSetup_gData.replayMode == 0)) {
      Car_tStats *dummyCars = Cars_gNewCarStatsList;

      if (((dummyCars[0].finalPosition < 2) && (frontEnd.pinkSlipsForfeit != 0)) ||
          (frontEnd.pinkSlipsForfeit == 1)) {
        frontEnd.pinkSlipsWinner[(byte)frontEnd.pinkSlipsTrackIndex] = 0;
        frontEnd.pinkSlipsWins[0] = frontEnd.pinkSlipsWins[0] + '\x01';
      }
      else {
        frontEnd.pinkSlipsWinner[(byte)frontEnd.pinkSlipsTrackIndex] = 1;
        frontEnd.pinkSlipsWins[1] = frontEnd.pinkSlipsWins[1] + '\x01';
      }
    }
    result = FEApp[0]->RunPostGame();
    break;
  }
  Front_DeleteAll();
  FeAudio_DeInitCommentary();
  Audio_FECleanUp();
  TextSys_UnloadWords();
  FeTools_deinit();
  PSXExitFrontend();
  FILE_delbigsync((char *)gFEBigHandle[0],(void *)0x64);
  gFEBigHandle[0] = 0;
  frontEnd.recordlaptime =
       Stattool_ReturnRecordLapTime((ushort)(byte)frontEnd.track[0]);
  gLargestUnused[0] = largestunused();
  return result;
}



/* ---- OutputDisplaySettings__FPiiiR17tTrackInformation  [FRONT.CPP:1171-1204] ---- */

/* int * OutputDisplaySettings__FPiiiR17tTrackInformation(int * d, int c, int player,
   tTrackInformation * trackInfo)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x80027DA8 block=CODE size=536B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:1171
     SYM data: 4 regparms / 0 args / 0 autos
     Sample callers: Front_AppendPlayerCarData__FPiR9tFEStream
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

int *OutputDisplaySettings(int *d,int c,int player,tTrackInformation &trackInfo)

{
  /* W64 (2026-08-10): 159 diffs -> PASS (134/134).  SYM's lone local is the
     initialized switch result; the output is the original post-incrementing
     word stream.  CountryMeasurement is a short table despite its extern
     declaration, and cameraType is indexed by the player row. */
  int valtopass = 0;

  switch (frontEnd.displaySpeed[player]) {
  case 0:
    valtopass = ((short *)CountryMeasurement)[trackInfo.fSpeedoCountry];
    break;
  case 1:
    break;
  case 2:
    valtopass = 1;
    break;
  default:
    valtopass = 2;
    break;
  }
  *d++ = 0x11a;
  *d++ = c;
  *d++ = valtopass;
  *d++ = 0x11b;
  *d++ = c;
  *d++ = (uint)(frontEnd.displaySpeed[player] != '\x03');
  *d++ = 0x11c;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.displayMap[player];
  *d++ = 0x11d;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.displayOpponentID[player];
  *d++ = 0x11e;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.displayTime[player];
  *d++ = 0x11f;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.displayLapNumber[player];
  *d++ = 0x120;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.displayPosition[player];
  *d++ = 0x121;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.displayMirror[player];
  *d++ = 0x126;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.cameraType[player][0];
  *d++ = 0x127;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.cameraType[player][1];
  *d++ = 0x128;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.cameraType[player][2];
  *d++ = 0x129;
  *d++ = c;
  *d++ = (uint)(byte)frontEnd.cameraType[player][3];
  return d;
}



/* ---- Front_GetLapsForType  [FRONT.CPP:1210-1223] ---- */

/* Decoded Phase 83: Front_GetLapsForType() - return default lap count for current raceType (168 B,
   5 callers). Single race=2, tournament round=N from tier table.
   
   [ghidra-meta] section: front.text */

int Front_GetLapsForType(void)

{
  uint uVar1;
  short lapconv [2];

  lapconv[0] = 2;
  lapconv[1] = 4;
  if (frontEnd.raceType != RaceType_Tournament) {
    uVar1 = (uint)lapconv[(byte)frontEnd.lapind[(byte)frontEnd.pinkSlipsTrackIndex]];
  }
  else {
    uVar1 = (uint)((tournamentManager.fDefinition)->fTournaments +
                  ((uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset + tournamentManager.fTournament))->fNumLaps;
  }
  return uVar1;
}



/* ---- Front_InitStream__FR9tFEStream  [FRONT.CPP:1231-1235] ---- */

/* Decoded Phase 83: Front_InitStream__FR9tFEStream(tFEStream&) - clear tFEStream to safe initial state (48 B).Called first in BuildStream pipeline.
   SYM-CONFORM (2026-08-16): the mangled text is the GCC-v2 linkage name,
   not the retail C++ identifier.  Restored `Front_InitStream(tFEStream&)`;
   gcc regenerates `Front_InitStream__FR9tFEStream` and both this function
   (12/12) and its Front_BuildStream caller (1000/1000) remain PASS.
   
   [ghidra-meta] section: front.text */

static void Front_InitStream(tFEStream &streamData)

{
  streamData.totalCars = 0;
  streamData.totalModels = 0;
  streamData.currentCar = 0;
  carManager.InitializeIngameCarList();
  return;
}



/* ---- Front_InitPlayerCars__FR9tFEStream  [FRONT.CPP:1241-1324] ---- */

/* Decoded Phase 83: Front_InitPlayerCars__FR9tFEStream(tFEStream&) - populate playerCars[] from garage state (964
   B). raceType==2 (tournament): garageCar[0] from save. raceType!=6: standard car select. Reads
   carColors[i*0x18][carID] to pick skin from selection menu state.
   
   [ghidra-meta] section: front.text */

static void Front_InitPlayerCars(tFEStream &streamData)

{
  uchar uVar1;
  short sVar2;
  char *pcVar3;
  void *pvVar4;
  tCarInfo *carInfo;
  tCarInfo *ptVar6;
  short i;
  tCarModels carModel;
  char carColor;
  
  streamData.numPlayers = 0;
  /* MATCH: EACH arm carries its OWN `carInfo->fColor = fColorOrder[fColor]; numPlayers++`
     tail (retail's 1998 shape), NOT one shared fall-through tail.  gcc then CROSS-JUMPS the
     raceType==2 tail into the pinkslips arm's SECOND tail (the `j` at the end of the
     tournament arm targets it), while a shared fall-through tail instead makes the pinkslips
     arm jump AWAY and drops its own copy -- an 18-insn block the oracle has and we lacked. */
  if (frontEnd.raceType == RaceType_Tournament) {
    carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[0],*streamData.playerCars,0);
    carInfo = &streamData.playerCars[streamData.numPlayers];
    carInfo->fColor = carInfo->fColorOrder[carInfo->fColor];
    streamData.numPlayers = streamData.numPlayers + 1;
  }
  /* MATCH: the PINK-SLIPS arm is the FALL-THROUGH and the stock/garage do-loop is
     laid out out-of-line (oracle `bne raceType,6 -> .L800281DC`, with `i = 0` stolen
     into that branch's delay slot).  Writing it as `if (!=6) {loop} pinkslips;`
     inverts the layout. */
  else if (frontEnd.raceType == RaceType_PinkSlips) {
    carManager.GetPinkSlipsCar((ushort)(byte)frontEnd.pinkSlipsCar[0],*streamData.playerCars,0);
    /* MATCH: SYM local `carInfo` REG $5 (a1) -- a real tCarInfo* local forces the
       playerCars member offset (+8) INTO the pointer (`addiu v0,v0,8; addu a1,s1,v0`);
       an inline `streamData.playerCars[n].field` folds the +8 into every field
       displacement instead (+205 vs the oracle's +197). */
    carInfo = &streamData.playerCars[streamData.numPlayers];
    carInfo->fColor = carInfo->fColorOrder[carInfo->fColor];
    sVar2 = streamData.numPlayers + 1;
    streamData.numPlayers = sVar2;
    carManager.GetPinkSlipsCar((ushort)(byte)frontEnd.pinkSlipsCar[1],*(streamData.playerCars + sVar2),1);
    carInfo = &streamData.playerCars[streamData.numPlayers];
    carInfo->fColor = carInfo->fColorOrder[carInfo->fColor];
    streamData.numPlayers = streamData.numPlayers + 1;
  }
  else {
    i = 0;
    {
      do {
        if (frontEnd.carListType == '\0') {
          carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[i],
                     *(streamData.playerCars + streamData.numPlayers));
          carInfo = &streamData.playerCars[streamData.numPlayers];
          /* MATCH: `carColors[i]`, NOT the Ghidra `carColors[i * 0x18]` -- carColors is
             char[2][48], so Ghidra's flattened byte index multiplied the row stride twice
             (ours i*24*48=1152, retail i*48). Same for carCountry below. */
          pcVar3 = carInfo->fShapeName + ((byte)frontEnd.carColors[i][carInfo->fCarID] - 8)
          ;
        }
        else {
          carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[i],
                     *(streamData.playerCars + streamData.numPlayers),i);
          carInfo = &streamData.playerCars[streamData.numPlayers];
          pcVar3 = carInfo->fShapeName + (carInfo->fColor - 8);
        }
        carInfo->fColor = pcVar3[0xaf];
        /* MATCH: retail leaves the load-delay `nop` after the fColorOrder read and stores
           BEFORE reading fCarClass; our sched1 hoists the fCarClass load over the fColor
           store (it disambiguates the two char fields). The barrier restores the order. */
        __asm__ __volatile__("" : : "i"(0));
        if (carInfo->fCarClass == '\a') {
          uVar1 = frontEnd.carCountry[streamData.numPlayers][carInfo->fCarID];
          carInfo->fColor = '\0';
          carInfo->fCountry = uVar1;
        }
        streamData.numPlayers = streamData.numPlayers + 1;
        /* MATCH: the increment lives IN the condition, AFTER the gameMode test (retail
           tests gameMode first, then `addu v0,s2,v0` reusing the `li v0,1` the gameMode
           compare just materialized). A body-level `i = i + 1` precomputes i+1 into the
           bne's delay slot and needs its own constant. */
      } while ((frontEnd.gameMode == '\x01') && (++i < 2));
    }
  }
  i = 0;
  /* MATCH: EXIT-IN-THE-MIDDLE (top test + unconditional `j` back-edge, no
     rotation) -- same shape as InitPerps/InitTraffic; a for/while gets rotated. */
  while (1) {
    tCarModels carModel;   /* SYM: block AUTOs at sp+0x10 / sp+0x14 */
    char carColor;

    /* MATCH: `i >= numPlayers` (i FIRST) -- operand order decides which side gcc
       sign-extends first; `numPlayers <= (int)i` loads the field before the sll/sra. */
    if ((int)i >= streamData.numPlayers) break;
    /* MATCH: fCarID is signed here -- the oracle reads it with `lb`, and plain
       `char` is UNSIGNED on this build. */
    carModel = (tCarModels)(signed char)streamData.playerCars[i].fCarID;
    carColor = streamData.playerCars[i].fColor;
    if (!carManager.IsCarAnAddedModel(carModel,carColor) && (streamData.totalModels < 0xd)) {
      streamData.totalModels = streamData.totalModels + 6;
    }
    carManager.AddCarToIngameList(carModel,carColor);
    streamData.totalCars = streamData.totalCars + 2;
    streamData.carLineup[i].isPlayerCar = 1;
    streamData.carLineup[i].carModel = carModel;
    streamData.carLineup[i].carColor = carColor;
    streamData.carLineup[i].carUpgrades = streamData.playerCars[i].fUpgrades;
    i = i + 1;
  }
  return;
}



/* ---- Front_InitTourneyTraffic__FR9tFEStream  [FRONT.CPP:1329-1358] ---- */

/* Decoded Phase 83: Front_InitTourneyTraffic__FR9tFEStream(tFEStream&) - tournament-mode traffic init (372 B).Different traffic profile per tournament tier.
   
   [ghidra-meta] section: front.text */

static void Front_InitTourneyTraffic(tFEStream &streamData)

{
  short i;
  short maxTraffic;
  tTourneyInfo *tourn;
  tCarModels carModel;
  char carColor;

  maxTraffic = 3;
  carColor = '\0';
  /* MATCH (SLD/oracle): retail materializes the &fTournaments[idx] POINTER BEFORE the
     raceType test -- the whole index chain sits above the `bne raceType,2` guard and the
     traffic flag is read as `tourn->fTraffic` (one `lbu 4(a1)`), not as a fresh
     fTournaments[(uint)tournOffset + tournament] expression inside the `&&` (which
     re-masks the byte offset with `andi 0xff` and re-does the *84 chain below the test). */
  tourn = tournamentManager.fDefinition->fTournaments +
          (tournamentManager.fDefinition->fTiers[tournamentManager.fTier].fTournOffset +
           tournamentManager.fTournament);
  streamData.numTraffic = 0;
  if ((frontEnd.raceType == RaceType_Tournament) && (tourn->fTraffic != '\0'))
  {
    /* MATCH: same shape as Front_InitTraffic -- SYM has ONE short `i` (REG $17),
       the postfix `fTrafficCars[i++]` gives the oracle's old-i copy + increment
       pair, and `i = 0;` first so reorg steals it into the guard's delay slot. */
    i = 0;
    do {
      carModel = (tCarModels)(byte)streamData.trackInfo.fTrafficCars[i++];
      if (5 < (int)i) {
        i = 0;
      }
      if (!carManager.IsCarAnAddedModel(carModel,carColor)) {
        streamData.totalModels = streamData.totalModels + 1;
        carManager.AddCarToIngameList(carModel,carColor);
      }
      streamData.trafficCars[streamData.numTraffic] = (u_short)carModel;
      streamData.totalCars = streamData.totalCars + 1;
    } while (++streamData.numTraffic < maxTraffic);
  }
  return;
}



/* ---- Front_InitOpponentCars__FR9tFEStream  [FRONT.CPP:1366-1529] ---- */

/* Decoded Phase 83: Front_InitOpponentCars__FR9tFEStream(tFEStream&) - allocate AI opponent cars (1428 B). For
   tournament (raceType==2) AND special (oppNumber==2): full 5-opponent grid. Otherwise 0..N from
   frontEnd.opponents[] picks. Sets numOpponents=0 first, then conditionally adds based on raceType
   + grid size. Each opp gets carID + skin color from grid CSV.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-05-10 bulk] Bulk-renamed Ghidra SSA temps to type-hinted user-names (ti=int,
   tu=uint, ts=short, tb=byte, tstr=char*, tp=void*, etc.) for audit cleanliness. Generic but
   preserves type info; these are minor secondary-effect register temps that did not warrant
   individual semantic naming. */

/* W57-A4 (2026-08-09) 129 -> 127.  Landed: an `int` temp forces the WORD load of
   tournamentManager.fNumRacers (retail `lw`; assigning straight into the `short`
   numOpponents narrows it to `lhu`).  A SECOND `lhu v0,16(s0)` vs `lw` site remains in the
   raceType==2 fixup block (`numOpponents = (short)fNumRacers - 1`) -- same fix applies.
   RESIDUAL 127 is diffuse and needs an SLD-first rewrite, not spot levers.  Named angles:
   (1) `lbu v1,4(a0)` off a materialized `&frontEnd` vs retail's FUSED `lui %hi(frontEnd+4);
       lbu %lo(...)` + a SEPARATE later `la fp,frontEnd` -- something in this body takes the
       address of frontEnd once and reuses it; retail re-materializes per use.
   (2) a systematic s0<->s1 swap in the opponent loop and an s3/s4/s5 rotation in the
       carLineup copy block (SYM: i $17=s1, carLineup $16=s0, numOpponents $23=s7).
   (3) ordering around the `sw a1,248(sp)` / `lhu a1,248(sp)` carModel spill: retail stores
       the byte straight from the load into the jal delay slot, we round-trip via memory. */
/* W61-A17 (base 115, unchanged) -- PRICED ALLOCATOR CERTIFICATE.  The whole
   residual is a uniform s0<->s1 swap plus its knock-ons: the SYM 8c block gives
   retail's handout (streamData=$0x12 s2, i=$0x11 s1, carLineup=$0x10 s0,
   numOpponents=$0x17 s7, and in the block carInfo=$0x10 s0, opponentClass=$3
   v1, tourn=$0x13 s3; carModel/carColor/usePlayerUpgrades are AUTO at sp+248/
   252/264).  Ours puts i in s0 and carInfo in s1.
   allocsim MATCHES this function 26/26 (order-vs-dump IDENTICAL), so the model
   is validated here: p81 (= i, refs=29 live=145, pri 0.8000) outranks p82
   (= carInfo, refs=11 live=88 calls=4, pri 0.3750) and therefore takes the
   first free callee-saved reg.  reqdelta --want p81=s1,p82=s0 finds NO single
   dial and NO two-dial (refs+live, +-40) delta on either pseudo: carInfo must
   out-prioritise i, i.e. floor_log2(r)*r/88 > 0.8 => r >= 18 (+7 refs).
   FALSIFIED: a read-only ref fence on carInfo after its last in-loop use with
   3 / 4 / 5 / 6 operands -- all four score 137 IDENTICALLY, i.e. the operand
   count never moved the handout (the fence changes the loop's scheduling
   instead of buying priced refs here), unlike the 12C fence-count dial.
   NEXT: the frame census is already identical to retail (19 slots, no
   permutation), so this is not the W61-A1 declaration-order class; the open
   angle is a source shape that raises carInfo's REF COUNT naturally -- e.g.
   retail reading carInfo->fColorOrder / fDefaultColor through the pointer more
   often than our carColor temp does -- or that shortens i's live range.  */
/* 🏆 W64-A17 (2026-08-15): 111 -> PASS 357/357.  TWO source-shape edits; the
   W61-A17 "+7 refs on carInfo" allocator certificate was aimed at a SYMPTOM.
   (1) 111 -> 6 @357/357 -- THE FN-SCOPE ALIAS WAS THE WHOLE HANDOUT.  The
       `carLineup = streamData.carLineup;` alias in the oppNumber==1 arm was a
       Ghidra artifact: retail addresses that arm's slots straight off
       streamData (`sw zero,440(s2)`/`sb v1,428(s2)`... == 420+N), never
       emitting `addiu sN,s2,420`.  Deleting it removed the +1 insn AND
       collapsed the s0<->s1 swap the certificate priced -- because the alias
       stretched the FN-SCOPE carLineup pseudo's live range across a whole arm
       that never needed it, which is what pushed `i` ahead of carInfo in
       QTY_CMP_PRI.  LAW (catalog candidate): before pricing a priority dial,
       check whether one of the two contested pseudos is live in a region the
       SOURCE does not require -- a fn-scope local aliasing a struct member is
       the cheapest way to inflate a live range invisibly, and the allocator
       certificate reads as a hard floor while it is present.
   (2) 6 -> PASS -- `numOpponents = 5` moved into an explicit ELSE ARM.  With
       the pre-assigned default, gcc materialised `&frontEnd` as a la at the
       raceType guard and read the field off it (`addiu a0,v0,0; lbu v1,4(a0)`),
       then copied that reg into the loop's `fp` (`addu fp,a0,zero`); retail
       keeps the guard read FUSED (`lbu %lo(frontEnd+4)(v0)`) and materialises
       `&frontEnd` fresh in the preheader (`lui v0,0; addiu fp,v0,0`).  Same
       count either way -- it is purely which lo_sum cse2 gets to share.
   FALSIFIED from the 6 basin (all re-gated): `(byte)frontEnd.raceType == 2`
   guard cast 6 (neutral); swapping the in-loop `tier`/`raceType` test order 14;
   an explicit `tfrontEnd *fe = &frontEnd;` local for the three in-loop reads 8.
   Also measured: declaring carLineup inside arm 1 instead of at fn scope = 6,
   identical to keeping the SYM's fn-scope declaration -- so the SYM-true
   declaration was kept. */
static void Front_InitOpponentCars(tFEStream &streamData)

{
  short i;
  tCarLineup *carLineup;
  short numOpponents;

  streamData.numOpponents = 0;
  if ((frontEnd.raceType == RaceType_Tournament) ||
     ((frontEnd.raceType == RaceType_SingleRace && (frontEnd.oppNumber == '\x02')))) {
    tCarInfo *carInfo;
    tCarModels carModel;
    char carColor;
    tCarClassType opponentClass;
    BOOL usePlayerUpgrades;
    tTourneyInfo *tourn;

    usePlayerUpgrades = 0;
    if (frontEnd.raceType == RaceType_Tournament) {
      /* MATCH W62-A15: 12D-A7 / W60-A6 INDEX-TERM-FIRST address spelling.
         Retail closes this element address with the INDEX as operand 0
         (`addu v0,v0,a1` then `lbu v1,39(v0)`); a plain `arr[idx].field`
         subscript canonicalises the POINTER first (`addu a1,a1,v0`,
         `lbu v1,39(a1)`) because qty_combine ties the dest to op0 and gcc
         puts the base first in a pointer sum.  Writing the whole address as
         an INT sum with the scaled index leading restores retail's operand
         order and the register that follows it: 115 -> 111 diffs (358/357).
         SITE-SELECTIVE, exactly as the W60-A6 row warns -- the same rewrite
         applied to the two sibling `fTournaments[...]` sites below is a
         REGRESSION: +this site only 111, +the cct_OpenClass tourn 113,
         +the else-arm tourn 115, all three 117, the two tourn sites alone
         121.  Price every site, never blanket. */
      opponentClass = (tCarClassType)((tTourneyInfo *)
              (((uint)tournamentManager.fDefinition->fTiers[tournamentManager.fTier].fTournOffset +
                tournamentManager.fTournament) * sizeof(tTourneyInfo)
               + (int)tournamentManager.fDefinition->fTournaments))->fOpponentCarClass;
    }
    else {
      opponentClass = cct_OpenClass;
    }
    if (opponentClass == cct_OpenClass) {
      usePlayerUpgrades = 1;
      tourn = &tournamentManager.fDefinition->fTournaments
              [(uint)tournamentManager.fDefinition->fTiers[2].fTournOffset +
               (uint)(byte)streamData.playerCars[0].fCarID];
    }
    else {
      tourn = &tournamentManager.fDefinition->fTournaments
              [(uint)tournamentManager.fDefinition->fTiers[tournamentManager.fTier].fTournOffset +
               tournamentManager.fTournament];
    }
    /* MATCH W64-A17: the 5 is the ELSE ARM, not a pre-assigned default.  A
       top-of-block `numOpponents = 5;` followed by a bare `if` makes gcc
       materialise the 5 ahead of the raceType guard and reuse the guard's
       own `&frontEnd` lo_sum for the field read (`addiu a0,v0,0; lbu v1,4(a0)`
       + a later `addu fp,a0,zero`); the two-armed form lets the guard read
       stay FUSED (`lbu %lo(frontEnd+4)(v0)`) and rematerialise `&frontEnd`
       fresh in the loop preheader, exactly as retail does.  6 -> PASS.
       (§5.0c "explicit else x = N" / 13C inverted-default, applied to the
       constant arm rather than the computed one.) */
    if (frontEnd.raceType == RaceType_Tournament) {
      /* MATCH: an `int` temp forces the WORD load of fNumRacers (retail `lw`); assigning
         the expression straight into the `short` lets gcc narrow it to `lhu`. */
      int numRacers = tournamentManager.fNumRacers;
      numOpponents = numRacers + -1;
    }
    else {
      numOpponents = 5;
    }
    i = 0;
    if (0 < numOpponents) {
      do {
      carModel = (tCarModels)tourn->fOpponentCar[i];
      carInfo = carManager.GetCarFromID((ushort)carModel);
      carColor = carInfo->fDefaultColor;
      if (!carManager.IsCarAnAddedModel(carModel,carColor) && (streamData.totalModels < 0x10)) {
        streamData.totalModels = streamData.totalModels + 3;
      }
      carManager.FindSimilarCar(carModel,carColor,0,(tCarModels *)0x0);
      carManager.AddCarToIngameList(carModel,carColor);
      streamData.carLineup[i + 1].isPlayerCar = 0;
      streamData.carLineup[i + 1].carModel = carModel;
      streamData.carLineup[i + 1].carColor = carInfo->fColorOrder[(byte)carColor];
      if (usePlayerUpgrades) {
        streamData.carLineup[i + 1].carUpgrades = streamData.playerCars[0].fUpgrades;
      }
      else {
        streamData.carLineup[i + 1].carUpgrades = tourn->fOpponentUpgrades[i];
      }
      if ((frontEnd.raceType == RaceType_Tournament) && (frontEnd.tier == '\0')) {
        void *pvVar5 = FECheat_IsCheatEnabled(cheat_FinishedTournament);
        if ((pvVar5 != (void *)0x0) && (frontEnd.opponentUpgrades != '\0')) {
          streamData.carLineup[i + 1].carUpgrades = tourn->fOpponentUpgrades[i];
        }
        else {
          streamData.carLineup[i + 1].carUpgrades = '\0';
        }
      }
      i = i + 1;
      streamData.totalCars = streamData.totalCars + 2;
      streamData.numOpponents = streamData.numOpponents + 1;
      } while (i < numOpponents);
    }
    if (frontEnd.raceType == RaceType_Tournament) {
      tournamentManager.UpdateCarLineup();
      /* MATCH: same int-temp WORD-load fix as the raceType==2 block above (retail `lw`). */
      int numRacers2 = tournamentManager.fNumRacers;
      streamData.numOpponents = numRacers2 + -1;
      carLineup = tournamentManager.fCarLineup;
      for (i = 0; i < numOpponents + 1; i = i + 1) {
        streamData.carLineup[i].personality = carLineup[i].personality;
        streamData.carLineup[i].position = carLineup[i].position;
      }
    }
    else {
      for (i = 0; i < 5; i = i + 1) {
        streamData.carLineup[i + kPersonalityBlurrr].personality = (tPersonalities)i;
        streamData.carLineup[i + kPersonalityBlurrr].position = (char)(i + 1);
      }
      streamData.carLineup[0].position = '\x06';
    }
  }
  else if (((byte)frontEnd.raceType < RaceType_Tournament) && (frontEnd.oppNumber == '\x01')) {
    tCarInfo carInfo;
    tCarModels carModel;
    char carColor;
    tCarModels modelList [3];

    /* MATCH W64-A17: NO carLineup alias in this arm -- retail addresses every
       slot straight off streamData (`sw zero,440(s2)` .. `sb v1,428(s2)`,
       i.e. 420+N), never materialising `addiu sN,s2,420`.  The alias was a
       Ghidra artifact; it cost one insn AND (by stretching the fn-scope
       carLineup pseudo's live range across this arm) inverted the whole
       s0/s1 handout the W61-A17 certificate priced.  111 -> 6 @357/357. */
    carManager.GetStockCar((ushort)(byte)frontEnd.oppCar,carInfo);
    carModel = (tCarModels)(int)*(signed char *)&carInfo.fCarID;
    carColor = carInfo.fColorOrder[carInfo.fDefaultColor];
    if (!carManager.IsCarAnAddedModel(carModel,carColor)) {
      if (streamData.totalModels < 0x10) {
        streamData.totalModels = streamData.totalModels + 3;
      }
      else {
        carManager.GetClassList((tCarClassType)carInfo.fCarClass,3,modelList);
        carManager.FindSimilarCar(carModel,carColor,3,modelList);
      }
    }
    streamData.numOpponents = streamData.numOpponents + 1;
    streamData.carLineup[1].isPlayerCar = 0;
    streamData.carLineup[1].personality = kPersonalityNemesis;
    streamData.carLineup[1].carModel = carModel;
    streamData.carLineup[1].carColor = carColor;
    streamData.carLineup[1].carUpgrades = streamData.playerCars[0].fUpgrades;
    streamData.carLineup[1].position = '\x01';
    streamData.carLineup[0].position = (char)streamData.numOpponents + '\x01';
    carManager.AddCarToIngameList(carModel,carColor);
    streamData.totalCars = streamData.totalCars + 2;
  }
  else {
    streamData.carLineup[0].position = '\x01';
    streamData.carLineup[1].position = '\x02';
  }
  return;
}



/* ---- Front_InitMissions__FR9tFEStream  [FRONT.CPP:1536-1579] ---- */

/* Decoded Phase 83: Front_InitMissions__FR9tFEStream(tFEStream&) - tournament mission setup (304 B). Reads
   tMissionManager state to populate per-tier objectives.
   
   [ghidra-meta] section: front.text */

static void Front_InitMissions(tFEStream &streamData)

{
  int cVar1;
  char cVar2;
  char cVar3;
  short i;
  int iVar4;
  int cVar5;
  tCarModels fBestCar;
  char oldTier;
  char oldMission;
  
  streamData.pMission = (tMissionInfo *)0x0;
  streamData.pStages = (tStageInfo *)0x0;
  cVar5 = '\0';
  if (frontEnd.raceType == RaceType_HotPursuit) {
    /* MATCH: a plain short-counter `for` -- retail's zero-trip guard is
       `slt i,numPlayers` (i's initial 0 shares the register with cVar5's 0), NOT
       the `blez numPlayers` a literal `0 < numPlayers` if-guard produces, and the
       bound is LICM-hoisted because the body has no aliasing store. */
    for (i = 0; i < streamData.numPlayers; i = i + 1) {            /* 1552 */
      if (streamData.playerCars[i].fCarClass != '\a') {               /* 1557 */
        return;                                                          /* 1559 */
      }
      cVar1 = *(signed char *)&streamData.playerCars[i].fCarID;                        /* 1561 */
      if (cVar5 < cVar1) {                                              /* 1562 */
        cVar5 = cVar1;                                                  /* 1563 */
      }
    }
    /* SLD statements 1567/1568 then 1576/1577: the policeTier/policeMission
       save AND restore both live INSIDE the raceType==1 arm, which is why retail
       holds &frontEnd in a callee-saved reg ($s0) across the three calls instead
       of rematerialising %hi/%lo for the restores. */
    cVar2 = frontEnd.policeTier;                                        /* 1567 */
    cVar3 = frontEnd.policeMission;                                     /* 1568 */
    frontEnd.policeTier = cVar5 + -0x16;                                /* 1569 */
    frontEnd.policeMission = '\0';                                      /* 1570 */
    missionManager.LoadDescription(true);                              /* 1572 */
    missionManager.GetMissionToRace(&streamData.pMission);            /* 1573 */
    missionManager.GetMissionStages((ushort)(byte)frontEnd.policeTier,
               (ushort)(byte)frontEnd.policeMission,&streamData.pStages); /* 1574 */
    frontEnd.policeTier = cVar2;                                        /* 1576 */
    frontEnd.policeMission = cVar3;                                     /* 1577 */
  }
  return;
}



/* ---- Front_InitCopCars__FR9tFEStream  [FRONT.CPP:1606-1696] ---- */

/* Decoded Phase 83: Front_InitCopCars__FR9tFEStream(tFEStream&) - populate cop cars (960 B). Picks cop count +
   types based on raceType + selected difficulty. Reserves AI slots for cops separate from
   opponents.
   
   [ghidra-meta] section: front.text */

/* SYM (nfs4-f-v3.txt @0x80028c94) `8c Function start` gives the EXACT local set:
     streamData = REGPARM $18 (s2)
     block (fn-scope, line=1..89): fBestModel = REG $5 (a1, tCarModels), fBestClass =
     REG $6 (a2, tCarClassType), i = REG $19 (s3, SHORT -- ONE counter reused across
     ALL FOUR loops), copModel = AUTO -0x30 (tCarModels), copColor = AUTO -0x2c (CHAR).
     Everything else the old Ghidra body invented (uVar1/ptVar2/pvVar3/sVar4/iVar5/
     tVar6/uVar7/tVar8/uVar9/iVar10) was a compiler temp / the classic short-index
     `i<<16`/`>>16` rendering artifact -- do not reintroduce it; `i` is a plain short
     used directly as the array index in every loop. */
static void Front_InitCopCars(tFEStream &streamData)

{
  tCarModels fBestModel;
  tCarClassType fBestClass;
  short i;
  tCarModels copModel;
  char copColor;

  fBestModel = cm_MercedesSLK;
  i = 0;
  fBestClass = cct_Roadster;
  copModel = cm_CapriceCop;
  copColor = '\0';
  streamData.numCops = 0;
  streamData.numSuperCops = 0;
  for (i = 0; i < streamData.numPlayers; i = i + 1) {
    if ((int)fBestModel < (int)(signed char)streamData.playerCars[i].fCarID) {
      fBestModel = (tCarModels)(signed char)streamData.playerCars[i].fCarID;
    }
    if ((int)fBestClass < (int)streamData.playerCars[i].fCarClass) {
      fBestClass = streamData.playerCars[i].fCarClass;
    }
  }
  /* MATCH: physical layout -- the oracle places the (pMission!=0 && pStages!=0)
     body INLINE/fall-through right after the compound OR-test (jumped-to only
     when EITHER pointer is null), and the raceType body OUT-OF-LINE. Writing
     the De Morgan-equivalent `if (A&&B) {...} else if (raceType) {...}` (rather
     than the original `if (A||B) { if(raceType) {...} }`) reproduces that
     layout -- swapping which block is "then" vs "else" moves ~30 insns from
     out-of-line to fall-through and matches. */
  if ((streamData.pMission != (tMissionInfo *)0x0) && (streamData.pStages != (tStageInfo *)0x0)) {
    if (frontEnd.gameMode == '\x01') {
      return;
    }
    for (i = 0; i < (short)(uint)streamData.pMission->fNumStages; i = i + 1) {
      if ((-1 < streamData.pStages[i].fWingman) || (-1 < streamData.pStages[i].fBlockadeCop)) {
        streamData.copCars[streamData.numCops] = fBestModel;
        streamData.copCountry[streamData.numCops] = (ushort)streamData.playerCars[0].fCountry;
        streamData.numCops = streamData.numCops + 1;
        streamData.totalCars = streamData.totalCars + 2;
        return;
      }
    }
  }
  else if (frontEnd.raceType == RaceType_HotPursuit) {
    for (i = 0; i < streamData.numPlayers; i = i + 1) {
      if (streamData.playerCars[i].fCarClass == '\a') {
        return;
      }
    }
    if ((streamData.numPlayers == 1) && (streamData.numOpponents == 0)) {
      streamData.numCops = 2;
      streamData.numSuperCops = 1;
    }
    else if (streamData.numPlayers == 2) {
      streamData.numCops = 0;
      streamData.numSuperCops = 2;
    }
    else {
      streamData.numCops = 4;
      streamData.numSuperCops = 0;
    }
    for (i = 0; i < streamData.numCops + streamData.numSuperCops; i = i + 1) {
      if (i < streamData.numSuperCops) {
        copModel = superCopModels[fBestClass][(byte)(streamData.trackInfo).fCountry];
      }
      else {
        copModel = regularCopModels[fBestClass][(byte)(streamData.trackInfo).fCountry];
      }
      if (!carManager.IsCarAnAddedModel(copModel,copColor)) {
        streamData.totalModels = streamData.totalModels + 3;
        carManager.AddCarToIngameList(copModel,copColor);
      }
      streamData.copCars[i] = copModel;
      streamData.totalCars = streamData.totalCars + 2;
      streamData.copCountry[i] = (ushort)(byte)(streamData.trackInfo).fCountry;
    }
  }
  return;
}



/* ---- Front_InitPerps__FR9tFEStream  [FRONT.CPP:1702-1747] ---- */

/* Decoded Phase 83: Front_InitPerps__FR9tFEStream(tFEStream&) - allocate Behind-The-Cop perp slots (456 B).
   
   [ghidra-meta] section: front.text */

static void Front_InitPerps(tFEStream &streamData)

{
  /* SYM (nfs4-f-v3.txt @0x80029054) `8c Function start` gives the EXACT local set:
       streamData = REGPARM $16 (s0)
       block: i = REG $17 (s1, SHORT), j = REG $3 (v1, SHORT),
              carInfo = REG $5 (a1, tCarInfo *)
       inner block (line +12): carModel = AUTO -0x28 (= sp+0x10, ENUM tCarModels),
                               carColor = AUTO -0x24 (= sp+0x14, CHAR)
     Everything else in the old Ghidra body (bVar1/iVar3/iVar4/pvVar5/sVar7) was a
     compiler temp -- do not reintroduce it. */
  short i;
  short j;
  tCarInfo *carInfo;

  streamData.numPerpObjects = 0;
  streamData.numPerps = 0;
  if (streamData.pMission != (tMissionInfo *)0x0) {
    i = 0;
    /* MATCH: EXIT-IN-THE-MIDDLE keeps the bound test at the TOP with an unconditional
       `j` back-edge (the oracle is un-rotated, no peeled guard) while STILL being a
       real loop for loop.c -- which is required here: the oracle hoists `lui
       %hi(carManager)`, `&carManager`, `&carModel` and `&carColor` into s5/s4/s3/s2.
       A label+goto loop kills loop.c's LICM and loses all four hoists. */
    while (1) {
      tCarModels carModel;   /* SYM: declared in the loop-body block, not fn scope */
      char carColor;

      if ((int)(uint)streamData.pMission->fNumStages <= (int)i) break;
      carModel = (tCarModels)streamData.pStages[i].fCarModel;
      carColor = streamData.pStages[i].fColor;
      carInfo = carManager.GetCarFromID(carModel);
      j = 0;
      /* MATCH: `fColorOrder` is declared plain `char` in the shared header, which is
         UNSIGNED on this build (lbu); the oracle reads it with `lb` -> signed cast. */
      while (1) {
        if ((int)(signed char)carInfo->fColorOrder[j] == (int)(byte)carColor) break;
        j = j + 1;
        if (0x10 <= (int)j) break;
      }
      carColor = (char)j;
      if (!carManager.IsCarAnAddedModel(carModel,carColor)) {
        if (streamData.totalModels < 0x10) {
          streamData.totalModels = streamData.totalModels + 6;
        }
        carManager.AddCarToIngameList(carModel,carColor);
        streamData.totalCars = streamData.totalCars + 2;
        streamData.perps[streamData.numPerpObjects].carModel = carModel;
        streamData.perps[streamData.numPerpObjects].carColor = streamData.pStages[i].fColor;
        streamData.numPerpObjects = streamData.numPerpObjects + 1;
      }
      streamData.numPerps = streamData.numPerps + 1;
      i = i + 1;
    }
  }
  return;
}



/* ---- Front_InitTrack__FR9tFEStream  [FRONT.CPP:1754-1801] ---- */

/* Decoded Phase 83: Front_InitTrack__FR9tFEStream(tFEStream&) - serialize selected track data (452 B). trackId +
   numLaps + Weather + timeOfDay + reverse.
   
   [ghidra-meta] section: front.text */

static void Front_InitTrack(tFEStream &streamData)

{
  tTrackInformation *src;
  int iVar1;
  tTrackInfo *tournTrack;
  
  if (frontEnd.raceType == RaceType_Tournament) {
    tournamentManager.GetTrackToRace(streamData.track);
    src = trackManager.GetTrackByID((short)(signed char)streamData.track.fTrackNumber);
    blockmove(src,&streamData.trackInfo,0x30);
  }
  else {
    trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               streamData.trackInfo);
    streamData.track.fTrackNumber = streamData.trackInfo.fTrackID;
    /* MATCH: local pointer to &streamData.track materialized ONCE before the branch
       (in the branch's delay slot in the oracle) and reused by BOTH arms -- reproduces
       the oracle's shared v1=&track pointer + offset stores instead of per-field
       absolute streamData-relative offsets. */
    tTrackInfo *pTrack = &streamData.track;
    if ((frontEnd.carListType == '\x01') || (frontEnd.raceType == RaceType_HotPursuit)) {
      pTrack->fDirection = frontEnd.trackdirection[(byte)frontEnd.pinkSlipsTrackIndex];
      pTrack->fMirrored = frontEnd.trackmirrored[(byte)frontEnd.pinkSlipsTrackIndex];
      pTrack->fTimeOfDay = frontEnd.timeOfDay[(byte)frontEnd.pinkSlipsTrackIndex];
      pTrack->fWeather = frontEnd.weather[(byte)frontEnd.pinkSlipsTrackIndex];
    }
    else {
      pTrack->fWeather = '\0';
      pTrack->fTimeOfDay = '\0';
      pTrack->fMirrored = '\0';
      pTrack->fDirection = '\0';
    }
    streamData.track.fDifficulty = 0x10000;
  }
  if (1 < streamData.track.fDirection) {
    iVar1 = rand();
    streamData.track.fDirection = (byte)iVar1 & 1;
  }
  if (1 < streamData.track.fMirrored) {
    iVar1 = rand();
    streamData.track.fMirrored = (byte)iVar1 & 1;
  }
  if (1 < streamData.track.fTimeOfDay) {
    iVar1 = rand();
    streamData.track.fTimeOfDay = (byte)iVar1 & 1;
  }
  if (1 < streamData.track.fWeather) {
    iVar1 = rand();
    streamData.track.fWeather = (byte)iVar1 & 1;
  }
  return;
}



/* ---- Front_InitTraffic__FR9tFEStream  [FRONT.CPP:1809-1879] ---- */

/* Decoded Phase 83: Front_InitTraffic__FR9tFEStream(tFEStream&) - allocate traffic-car slots (568 B). Count from
   track BWorld + Weather (rain reduces traffic).
   
   [ghidra-meta] section: front.text */

static void Front_InitTraffic(tFEStream &streamData)

{
  /* SYM (nfs4-f-v3.txt @0x800293E0) `8c Function start`: streamData REGPARM $19
     (s3), i REG $16 (s0, SHORT), bTraffic REG $4 (a0, BOOL), maxTraffic REG $6
     (a2, SHORT), carModel AUTO -0x28 (sp+0x10), carColor AUTO -0x24 (sp+0x14).
     The Ghidra bVar1/sVar2/iVar3/iVar5/sVar6 temps are NOT real locals. */
  bool bTraffic;
  short maxTraffic;
  short i;
  tCarModels carModel;
  char carColor;

  carColor = '\0';
  maxTraffic = 6;
  if (frontEnd.gameMode == '\x01') {
    maxTraffic = 3;
  }
  if (frontEnd.raceType == RaceType_HotPursuit) {
    maxTraffic = 2;
    if (streamData.track.fTimeOfDay == '\x01') {
      maxTraffic = 1;
    }
  }
  bTraffic = frontEnd.traffic[(byte)frontEnd.pinkSlipsTrackIndex] != '\0';
  /* MATCH: a SWITCH, not an if/else chain -- the oracle dispatches with
     `bltz raceType,default` + `slti raceType,2` + `beq raceType,6`, i.e. gcc's
     emit_case_nodes bound test against the PROMOTED int index type (an if-chain
     on the `char` field can never emit the bltz, and `(byte)x < 2` gives sltiu).
     The empty `case 6:` is required for the 3-node tree. */
  switch (frontEnd.raceType) {
  case RaceType_SingleRace:
  case RaceType_HotPursuit:
    if ((frontEnd.carListType == '\0') && (frontEnd.raceType == RaceType_SingleRace)) {
      bTraffic = true;
    }
    else if (frontEnd.raceType == RaceType_HotPursuit) {
      bTraffic = frontEnd.traffic[0] != '\0';
    }
    if (2 < streamData.trackInfo.fTrackDifficulty) {
      bTraffic = false;
    }
    if (streamData.trackInfo.fIsEgg != '\0') {
      bTraffic = false;
    }
    if (frontEnd.gameMode == '\x01') {
      if (frontEnd.raceType == RaceType_HotPursuit) {
        bTraffic = false;
      }
    }
    else if (frontEnd.oppNumber == '\x02') {
      bTraffic = false;
    }
    break;
  case RaceType_PinkSlips:
    break;
  default:
    bTraffic = false;
    break;
  }
  if (bTraffic) {
    i = 0;
    streamData.numTraffic = 0;
    if (maxTraffic != 0) {
      do {
        carModel = (tCarModels)(byte)streamData.trackInfo.fTrafficCars[i++];
        if (5 < (int)i) {
          i = 0;
        }
        if (!carManager.IsCarAnAddedModel(carModel,carColor)) {
          carManager.AddCarToIngameList(carModel,carColor);
        }
        streamData.trafficCars[streamData.numTraffic] = (u_short)carModel;
        streamData.numTraffic = streamData.numTraffic + 1;
      } while (streamData.numTraffic < maxTraffic);
    }
  }
  return;
}



/* ---- Front_AppendPlayerCarData__FPiR9tFEStream  [FRONT.CPP:1889-1963] ---- */

/* Decoded Phase 83: Front_AppendPlayerCarData__FPiR9tFEStream(int* outStream, tFEStream&) - serialize player car
   data into stream (1252 B). Writes per-player: currentCar, position, fSimNumber, color (from
   carManager). Also handles 2-player split-screen with two adjacent records.
   
   [ghidra-meta] section: front.text */

static int *Front_AppendPlayerCarData(int *stream,tFEStream &streamData)

{
  int iVar1;
  uint uVar2;
  tCarInfo *carInfo;
  tCarLineup *carLineup;
  short i;

  /* MATCH: SYM-implied `short i` loop counter (index form) + pointer-increment stores
     (*stream++ = v;), same idiom as the sibling Append* fns.
     W56-A6: removed the redundant `sVar3 = i` copy (was an extra `addu t0,s1,zero`), and
     rewrote both ABS/Traction if-blocks as the De-Morgan complement with arms swapped so the
     store-1 arm is the fall-through/`j` and store-0 is the `bne fCarID` target (retail's
     `beqz ABS; bnez fABSAvail; bne fCarID` layout). 86->69 diffs.
     W57-A4 (2026-08-09) 69 -> 0, SEALED.  Three fixes, all source-shape:
     (a) the two 2-arm value selects (fCarClass 0x41/1, fUpgrades tires) put the `*stream++`
         store INSIDE each arm instead of using a shared iVar1/uVar2 temp -- gcc cross-jumps
         the identical tail store back to ONE insn while the differing `li v0,K` stays
         per-arm, so the constant lands in $v0 (a shared temp merges BOTH stores and parks
         the value in $a2).  The tires test also flips to `!= 0` polarity (retail `beqz`),
         which keeps the `2` arm-local -> `andi v0,v0,2` instead of a CSE'd `li v1,2; and`.
     (b) the fColorList byte-2 term spelled `word >> 0x10 & 0xff` (the same array element as
         the other two terms; gcc narrows it to the `lbu +2` itself), NOT
         `*(byte*)((int)fColorList + fColor*4 + 2)` -- the cast spelling builds a SECOND
         address expression and flips the whole v0/v1 coloring plus the `addu` operand
         order.  This is exactly the sibling Front_AppendOpponentData's (matching) spelling.
     (c) a top-of-function void fence pins the a0->a3 cursor parm copy at prologue insn #1;
         without it sched2 sinks it and reorg steals it into the blez delay slot. */
  __asm__ __volatile__("" : : "i"(0));   /* MATCH: pins the a0->a3 cursor parm copy at the
        top of the prologue (retail insn #1); without it sched2 sinks the copy to just
        before the numPlayers guard and reorg then steals it into the blez delay slot,
        displacing retail's `addu s1,zero,zero`. */
  if (0 < streamData.numPlayers) {
    i = 0;
    do {
      carLineup = &streamData.carLineup[i];
      *stream++ = 0x119;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (int)(signed char)carLineup->position;
      *stream++ = 0x104;
      *stream++ = (int)streamData.currentCar;
      carInfo = streamData.playerCars + i;
      *stream++ = (uint)carInfo->fSimNumber;
      *stream++ = 0x106;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)(byte)frontEnd.transmission[i];
      *stream++ = 0x10a;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)carInfo->fColor;
      *stream++ = 0x10b;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x111;
      *stream++ = (int)streamData.currentCar;
      /* MATCH: written as the De-Morgan complement with the arms swapped so the store-1
         block is the fall-through/`j` arm and store-0 is the `bne fCarID` target -- retail's
         exact `beqz ABS; bnez fABSAvail; bne fCarID` short-circuit layout. */
      if (((frontEnd.ABS[i] != '\0') && (carInfo->fABSAvailable != '\0')) ||
         ((signed char)carInfo->fCarID == '\x1c')) {
        *stream++ = 1;
      }
      else {
        *stream++ = 0;
      }
      *stream++ = 0x115;
      *stream++ = (int)streamData.currentCar;
      if (((frontEnd.ABS[i] != '\0') && (carInfo->fTractionAvailable != '\0')) ||
         ((signed char)carInfo->fCarID == '\x1c')) {
        *stream++ = 1;
      }
      else {
        *stream++ = 0;
      }
      *stream++ = 0x110;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (byte)carLineup->carUpgrades >> 2 & 1;
      *stream++ = 0x112;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (byte)carLineup->carUpgrades >> 1 & 1;
      *stream++ = 0x10d;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (byte)carLineup->carUpgrades & 1;
      *stream++ = 0x10c;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x122;
      *stream++ = (int)streamData.currentCar;
      /* MATCH: all three terms spelled as the SAME array element (retail's byte-2 read is
         `word >> 16 & 0xff`, which gcc narrows to the `lbu +2` itself) -- identical to the
         sibling Front_AppendOpponentData, which byte-matches.  The `(byte*)(int)base+idx*4+2`
         cast spelling makes a SECOND address expression and flips the v0/v1 coloring plus the
         `addu` operand order. */
      *stream++ = carInfo->fColorList[carInfo->fColor] >> 0x10 & 0xff |
                    carInfo->fColorList[carInfo->fColor] & 0xff00 |
                    (carInfo->fColorList[carInfo->fColor] & 0xff) << 0x10;
      *stream++ = 0x123;
      *stream++ = (int)streamData.currentCar;
      *stream++ = carInfo->fHudColor[(streamData.track).fTimeOfDay];
      *stream++ = 0x124;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)carInfo->fSpeechColors[carInfo->fColor];
      *stream++ = 0x125;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)carInfo->fCountry;
      /* MATCH: the value store lives INSIDE each arm (no shared iVar1 temp) -- gcc
         cross-jump-merges the common tail `*stream++` back into ONE store while the
         differing `li v0,K` stays per-arm, so the constant lands in $v0 (retail).  A
         shared temp instead merges BOTH stores and parks the value in $a2. */
      if (carInfo->fCarClass == '\a') {
        *stream++ = 0x105;
        *stream++ = (int)streamData.currentCar;
        *stream++ = 0x41;
      }
      else {
        *stream++ = 0x105;
        *stream++ = (int)streamData.currentCar;
        *stream++ = 1;
      }
      *stream++ = 0x113;
      *stream++ = (int)streamData.currentCar;
      /* MATCH: `!= 0` polarity (retail `beqz`: the ==0/fDefaultTires arm is OUT-OF-LINE,
         the `2` arm falls through) + per-arm store, which also keeps the `2` arm-local so
         the flag test emits `andi v0,v0,2` instead of a CSE'd `li v1,2; and`. */
      if ((carInfo->fUpgrades & 2) != 0) {
        *stream++ = 2;
      }
      else {
        *stream++ = (uint)carInfo->fDefaultTires;
      }
      *stream++ = 0x107;
      iVar1 = (int)i;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)(byte)frontEnd.rampSteer[iVar1];
      *stream++ = 0x108;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)(byte)frontEnd.rampGas[iVar1];
      *stream++ = 0x109;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)(byte)frontEnd.rampBrake[iVar1];
      stream = OutputDisplaySettings(stream,(int)streamData.currentCar,iVar1,streamData.trackInfo);
      i = i + 1;
      streamData.currentCar = streamData.currentCar + 1;
    } while (i < streamData.numPlayers);
  }
  *stream++ = 0x1d;
  *stream++ = (int)streamData.numPlayers;
  *stream++ = 0x1e;
  *stream++ = (int)streamData.numOpponents;
  *stream++ = 0xe;
  *stream++ = 0;
  return stream;
}



/* ---- Front_AppendOpponentData__FPiR9tFEStream  [FRONT.CPP:1968-1998] ---- */

/* Decoded Phase 83: Front_AppendOpponentData__FPiR9tFEStream(int*, tFEStream&) - serialize opponent cars into
   stream (820 B). Each opponent: carID + personality + skill + color + grid position.
   
   [ghidra-meta] section: front.text */

static int *Front_AppendOpponentData(int *stream,tFEStream &streamData)

{
  byte bVar1;
  tCarInfo *carInfo;
  int iVar2;
  tCarInfo *ptVar3;
  tCarLineup *carLineup;
  short i;

  /* MATCH: SYM-implied `short i` loop counter (index form) + pointer-increment stores
     (*stream++ = v;), same idiom as the sibling Append* fns. Materialize p=stream FIRST (before
     the if), like Front_AppendPerpData -- the oracle copies the incoming arg into its
     callee-saved cursor reg immediately, not just when the branch is taken. */
  __asm__("" : : "i"(0));  /* parm-spill pin: keep s1 save+parm copy in prologue group */
  if (0 < streamData.numOpponents) {
    i = 0;
    do {
      iVar2 = (int)i + (int)streamData.numPlayers;
      /* MATCH: hoist &streamData.carLineup[iVar2] into its own pointer, used for every
         field access below -- the oracle materializes ONE base (`addiu s0,s0,0x1A4` = the
         carLineup[] field offset) and reads each member via a SMALL displacement off it,
         rather than re-deriving `&carLineup[iVar2].field` (base+0x1A4+fieldOff) at every
         access. */
      carLineup = &streamData.carLineup[iVar2];
      ptVar3 = carManager.GetCarFromID((short)carLineup->carModel);
      *stream++ = 0x119;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (int)(signed char)carLineup->position;
      *stream++ = 0x104;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)ptVar3->fSimNumber;
      *stream++ = 0x106;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 1;
      *stream++ = 0x105;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 2;
      *stream++ = 0x114;
      *stream++ = (int)streamData.currentCar;
      *stream++ = carLineup->personality;
      *stream++ = 0x118;
      *stream++ = (int)streamData.currentCar;
      *stream++ = carLineup->personality;
      *stream++ = 0x10a;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)(byte)carLineup->carColor;
      *stream++ = 0x10b;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x110;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (byte)carLineup->carUpgrades & 1;
      *stream++ = 0x112;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (byte)carLineup->carUpgrades >> 1 & 1;
      *stream++ = 0x10d;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (byte)carLineup->carUpgrades >> 2 & 1;
      *stream++ = 0x10c;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x125;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x122;
      *stream++ = (int)streamData.currentCar;
      bVar1 = carLineup->carColor;
      *stream++ = ptVar3->fColorList[bVar1] >> 0x10 & 0xff | ptVar3->fColorList[bVar1] & 0xff00 |
             (ptVar3->fColorList[bVar1] & 0xff) << 0x10;
      *stream++ = 0x123;
      *stream++ = (int)streamData.currentCar;
      *stream++ = ptVar3->fHudColor[(streamData.track).fTimeOfDay];
      *stream++ = 0x124;
      *stream++ = (int)streamData.currentCar;
      i = i + 1;
      *stream++ = (uint)ptVar3->fSpeechColors[(byte)carLineup->carColor];
      streamData.currentCar = streamData.currentCar + 1;
    } while (i < streamData.numOpponents);
  }
  return stream;
}



/* ---- Front_AppendCopData__FPiR9tFEStream  [FRONT.CPP:2003-2035] ---- */

/* Decoded Phase 83: Front_AppendCopData__FPiR9tFEStream(int*, tFEStream&) - serialize cop data (596 B). Per-cop:
   carID + chase-strategy + initial slice.
   
   [ghidra-meta] section: front.text */

static int *Front_AppendCopData(int *stream,tFEStream &streamData)

{
  tCarInfo *ptVar1;
  int iVar2;
  short i;

  if (0 < (int)streamData.numCops + (int)streamData.numSuperCops) {
    *stream++ = 0xc;
    *stream++ = 1;
  }
  /* MATCH: pointer-increment stores (*stream++ = v;), not indexed stream[N]=v -- the oracle
     re-walks the stream cursor with `addiu s0,s0,4` after EVERY word (tag+value pairs),
     rematerializing the address each time rather than computing fixed offsets from an
     unchanging base. Same idiom as Front_AppendTrackData. */
  /* MATCH (LAW 05A/lever #15a): retail's loop is NOT rotated -- the bound is
     re-loaded and the counter re-sign-extended at the loop HEAD each pass and the
     back edge is an unconditional `j`.  An exit-in-the-middle while(1) reproduces
     that; a `for`/`while` condition gets loop-rotated to a bottom test. */
  /* MATCH (W56-A6): the missing `i = i + 1` increment was restored (oracle `addiu s3,s3,1`),
     and the bound test is written `i >= sum` (i first) so gcc sign-extends i BEFORE loading the
     two bound shorts -- filling the load-delay slot with the `sra` exactly as retail (30->5 diffs).
     NEAR-SEAL FLOOR (5 diffs, 1 extra insn): the iVar2 (`*stream++`) store slot. Retail pre-saves
     the cursor in v1 before the numSuperCops branch and fills that branch's delay slot with the
     NEXT increment (`addu v1,s0,zero; ...; sw a0,0(v1)`); ours fills the delay slot with THIS
     store's own increment (`sw a0,0(s0); addiu s0,s0,4`). Pure reorg delay-slot-fill choice
     (§3.21 family) -- receipted, needs PER_FN delay-slot control or a qtytrace-class instrument. */
  i = 0;
  while (1) {
    if (i >= (int)streamData.numCops + (int)streamData.numSuperCops) break;
    ptVar1 = carManager.GetCarFromID((short)streamData.copCars[i]);
    *stream++ = 0x104;
    iVar2 = 8;
    *stream++ = (int)streamData.currentCar;
    *stream++ = (uint)ptVar1->fSimNumber;
    *stream++ = 0x106;
    *stream++ = (int)streamData.currentCar;
    *stream++ = 1;
    *stream++ = 0x105;
    *stream++ = (int)streamData.currentCar;
    {
      int *slot = stream++;
      if (i < streamData.numSuperCops) {
        iVar2 = 0x10;
      }
      *slot = iVar2;
    }
    *stream++ = 0x118;
    *stream++ = (int)streamData.currentCar;
    *stream++ = (byte)frontEnd.skillLevel + 5;
    *stream++ = 0x10a;
    *stream++ = (int)streamData.currentCar;
    *stream++ = 0;
    *stream++ = 0x10b;
    *stream++ = (int)streamData.currentCar;
    *stream++ = 0;
    *stream++ = 0x10c;
    *stream++ = (int)streamData.currentCar;
    *stream++ = 0;
    *stream++ = 0x125;
    *stream++ = (int)streamData.currentCar;
    *stream++ = (int)streamData.copCountry[i];
    *stream++ = 0x110;
    *stream++ = (int)streamData.currentCar;
    *stream++ = 0;
    *stream++ = 0x112;
    *stream++ = (int)streamData.currentCar;
    *stream++ = 0;
    *stream++ = 0x10d;
    *stream++ = (int)streamData.currentCar;
    *stream++ = 0;
    i = i + 1;
    streamData.currentCar = streamData.currentCar + 1;
  }
  return stream;
}



/* ---- Front_AppendPerpData__FPiR9tFEStream  [FRONT.CPP:2040-2076] ---- */

/* Decoded Phase 83: Front_AppendPerpData__FPiR9tFEStream(int*, tFEStream&) - serialize perp (Behind-The-Cop chase
   target) data (664 B). Writes per-perp carID + escape route + initial speed.
   
   [ghidra-meta] section: front.text */

static int *Front_AppendPerpData(int *stream,tFEStream &streamData)

{
  tCarInfo *ptVar1;
  tCarManager *carManagerPtr;
  int iVar2;
  int *piVar3;
  short i;

  /* MATCH: pointer-increment stores here too (same idiom as the rest of the fn). Branch
     polarity/arm order flipped vs the natural null-check-first form -- the oracle's `beqz`
     skips the RARE (pMission==NULL) case out-of-line and falls through the common
     (pMission!=NULL) case. Materialize piVar3=stream FIRST and write through piVar3 for the
     WHOLE function (never touch `stream` again) -- the oracle copies the incoming arg into its
     callee-saved cursor reg immediately, before the if/else, not just before the loop. */
  piVar3 = stream;
  if (streamData.pMission != (tMissionInfo *)0x0) {
    *piVar3++ = 0x25;
    *piVar3++ = (uint)streamData.pMission->fNumStages;
    *piVar3++ = 0x26;
    *piVar3++ = (uint)streamData.pMission->fStageOffset;
  }
  else {
    *piVar3++ = 0x25;
    *piVar3++ = 0;
    *piVar3++ = 0x26;
    *piVar3++ = 0;
  }
  /* MATCH: SYM-implied `short i` loop counter and pointer-increment stores. IDA's retail
     allocation shows s0 holding the complete streamData+i*8 per-perp base, reused by the
     16-bit carModel and byte carColor reads. Materializing carManagerPtr before that base
     calculation also gives GCC's scheduler the oracle's early lui placement. */
  i = 0;
  if (0 < streamData.numPerpObjects) {
    do {
      carManagerPtr = &carManager;
      iVar2 = (int)&streamData + ((i << 0x10) >> 0xd);
      ptVar1 = carManagerPtr->GetCarFromID(*(short *)(iVar2 + 608));
      *piVar3++ = 0x104;
      i = i + 1;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = (uint)ptVar1->fSimNumber;
      *piVar3++ = 0x106;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 1;
      *piVar3++ = 0x10a;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = (uint)*(byte *)(iVar2 + 612);
      *piVar3++ = 0x10b;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 0;
      *piVar3++ = 0x105;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 2;
      *piVar3++ = 0x118;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 0;
      *piVar3++ = 0x10c;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 1;
      *piVar3++ = 0x125;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 0;
      *piVar3++ = 0x110;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 0;
      *piVar3++ = 0x112;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 0;
      *piVar3++ = 0x10d;
      *piVar3++ = (int)streamData.currentCar;
      *piVar3++ = 0;
      streamData.currentCar = streamData.currentCar + 1;
    } while (i < streamData.numPerpObjects);
  }
  *piVar3++ = 0x25;
  *piVar3++ = (int)streamData.numPerps;
  return piVar3;
}



/* ---- Front_AppendTrafficData__FPiR9tFEStream  [FRONT.CPP:2081-2109] ---- */

/* Decoded Phase 83: Front_AppendTrafficData__FPiR9tFEStream(int*, tFEStream&) - serialize traffic cars (592 B).Type + density + spawn-rate from track tuning.
   
   [ghidra-meta] section: front.text */

static int *Front_AppendTrafficData(int *stream,tFEStream &streamData)

{
  tCarInfo *ptVar1;
  int density;
  int traffic;
  short i;

  /* MATCH: use the SYM-implied `short i` loop counter directly (index the short array by it)
     instead of the decompiler's `int iVar2` + manual `(i<<0x10)>>0xf`/`*0x10000>>0x10`
     sign-extend-emulation byte-offset cast -- and pointer-increment stores (*stream++ = v;)
     matching the oracle's per-word `addiu`, same idiom as the sibling Append* fns.
     GCC 2.8.1 also needs a distinct 32-bit `traffic` temporary and a ternary minimum clamp:
     together they prevent a narrow-subreg sign-extension of the quotient and retain retail's
     density result-copy allocation. */
  i = 0;
  if (0 < streamData.numTraffic) {
    do {
      ptVar1 = carManager.GetCarFromID(streamData.trafficCars[i]);
      *stream++ = 0x104;
      i = i + 1;
      *stream++ = (int)streamData.currentCar;
      *stream++ = (uint)ptVar1->fSimNumber;
      *stream++ = 0x106;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 1;
      *stream++ = 0x10a;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x10b;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x105;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 4;
      *stream++ = 0x118;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 8;
      *stream++ = 0x10c;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 1;
      *stream++ = 0x125;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x110;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x112;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      *stream++ = 0x10d;
      *stream++ = (int)streamData.currentCar;
      *stream++ = 0;
      streamData.currentCar = streamData.currentCar + 1;
    } while (i < streamData.numTraffic);
  }
  traffic = streamData.numTraffic;
  density = traffic / 3;
  if (0 < streamData.numTraffic) {
    density = (density < 1) ? 1 : density;
  }
  *stream++ = 0xd;
  *stream++ = density;
  return stream;
}



/* ---- Front_AppendTrackData__FPiR9tFEStream  [FRONT.CPP:2114-2146] ---- */

/* Decoded Phase 83: Front_AppendTrackData__FPiR9tFEStream(int*, tFEStream&) - serialize track data (320 B).
   
   [ghidra-meta] section: front.text */

static int *Front_AppendTrackData(int *stream,tFEStream &streamData)

{
  int valtopass;
  int speedMode;
  tTrackInformation trackInfo;
  
  trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             trackInfo);
  valtopass = 0;
  speedMode = frontEnd.displaySpeed[0];
  if (speedMode == 1) goto track_value_ready;
  /* MATCH: retail has three explicit tests and one shared measurement block. The gotos
     preserve its `slti; bnez`, `bne`, and case-2 `j` CFG; the signed int pseudo is required
     for GCC 2.8.1 to select `slti` rather than the unsigned-char `sltiu` form. */
  if (speedMode < 2) goto use_country_measurement;
  if (speedMode != 2) goto use_country_measurement;
  valtopass = 1;
  goto track_value_ready;
use_country_measurement:
  /* CountryMeasurement is really `short[8]` (fetracks.cpp) but front_externs.h declares
     it `extern int CountryMeasurement[16]` (a cross-TU type mismatch we can't fix here --
     out of scope, only front.cpp is owned by this pass). Cast at the use site to the true
     element type/stride so the load matches the oracle's `lh`+short-stride index. */
  valtopass = (int)((short *)CountryMeasurement)[trackInfo.fSpeedoCountry];
track_value_ready:
  /* MATCH: pointer-increment stores (*stream++ = v;), not indexed stream[N]=v -- the oracle
     re-walks the stream cursor with `addiu s1,s1,4` after EVERY word (tag+value pairs),
     rematerializing the address each time rather than computing N fixed offsets from one
     unchanging base. Same family as the index-vs-pointer-walk lever, applied to a serializer. */
  *stream++ = 0x1a;
  *stream++ = valtopass;
  *stream++ = 0x18;
  *stream++ = (uint)streamData.track.fMirrored;
  *stream++ = 0x19;
  *stream++ = (uint)streamData.track.fDirection;
  *stream++ = 0x14;
  *stream++ = (uint)streamData.track.fWeather;
  *stream++ = 0x17;
  *stream++ = (uint)streamData.track.fTimeOfDay;
  *stream++ = 0x12;
  *stream++ = (uint)streamData.trackInfo.fSimNumber;
  *stream++ = 0xb;
  *stream++ = streamData.track.fDifficulty;
  return stream;
  /* NEAR-SEAL FLOOR (4 diffs, local-alloc/sched gap §4.6 qtytrace): the final
     fDifficulty temp colors to v1 here vs v0 in the oracle. Oracle order is
     load(v0)->incr->store->return(reuse v0); ours is incr->load(v1)->return(v0)->store,
     so the return-value pseudo occupies v0 and forces the temp to v1. Falsified:
     `*stream=x;return stream+1` (no change, same schedule). This is a sched1-driven
     coloring outcome outside allocsim/reqdelta -- receipted, not a spelling floor. */
}



/* ---- Front_EnableLocalSpeech  [FRONT.CPP:2269-2290] ---- */

/* FE-side hook to enable speech for the local player. 2 FE callers.Sets up gSpeech->speechEnabled flag and routes audio for the player
   channel.Decoded Phase 49.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. FE local-speech-enable test. Returns
   1 if pinkslip-mode (raceType==1) AND track's language differs from current AND track lang in {<3,
   6}. Conditions: ret=0 default; if raceType==1: GetTrack populates trackInfo; check lang!=current
   AND (lang<3 OR lang==6) - then ret=1. Used by Front_BuildStream to switch speech-bank for race
   intros (e.g., German driver on French track plays the host's local language). result is
   caller-side spill. */

void * Front_EnableLocalSpeech(void)

{
  byte result;
  void *ret;
  tTrackInformation trackInfo;
  
  int lang;

  ret = (void *)0x0;
  if (frontEnd.raceType == RaceType_HotPursuit) {
    trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               trackInfo);
    lang = (byte)trackInfo.fLanguage;
    if ((lang != (byte)frontEnd.language) && (0 <= lang) && (lang < 3 || lang == 6)) {
      ret = (void *)0x1;
    }
  }
  return ret;
}



/* ---- Front_BuildStream  [FRONT.CPP:2299-2722] ---- */

/* Decoded Phase 83: Front_BuildStream(int* outStream) - build complete tFEStream race-setup blob(4000 B - biggest Front fn). Composes player cars + opponent cars + cops + traffic + perps +
   missions + track data + tourney traffic into a single contiguous int-stream buffer that gets
   passed to GameSetup at race transition. Calls Front_InitStream__FR9tFEStream + all Init*+Append* sub-builders
   in order. Drives entire game-->race handoff.
   
   [ghidra-meta] section: front.text */

int * Front_BuildStream(int *stream)

{
  void *pvVar1;
  int colourLoop;
  int j, type;
  int iVar3;
  uint uVar6;
  int numplaylistsongs;
  int *d;
  int trackLang;
  int gameLang;
  int config;
  tFEStream streamData;
  
  Front_InitStream(streamData);
  Front_InitPlayerCars(streamData);
  Front_InitTrack(streamData);
  Front_InitTourneyTraffic(streamData);
  Front_InitOpponentCars(streamData);
  Front_InitMissions(streamData);
  Front_InitCopCars(streamData);
  Front_InitPerps(streamData);
  Front_InitTraffic(streamData);
  seedrandom(frontEnd.randomSeed = (short)*(volatile int *)ticks);
  for (colourLoop = 7; 0 <= colourLoop; colourLoop--) {
    colourChosen[colourLoop] = 0;
  }
  Controller_SetRamp();
  d = stream + 0x35;
  resizememadr(stream,0x10000);
  *stream = 0x34;
  stream[1] = (uint)(byte)frontEnd.controlConfig[0];
  stream[2] = 0x35;
  stream[3] = (uint)(byte)frontEnd.deadSpot[0];
  stream[4] = 0x36;
  stream[5] = (uint)(byte)frontEnd.steeringRange[0];
  stream[6] = 0x37;
  stream[7] = (uint)(byte)frontEnd.IImaxRange[0];
  stream[8] = 0x38;
  stream[9] = (uint)(byte)frontEnd.ImaxRange[0];
  stream[10] = 0x39;
  stream[0xb] = (uint)(byte)frontEnd.J1MAX[0];
  stream[0xc] = 0x3a;
  stream[0xd] = (uint)(byte)frontEnd.J1MIN[0];
  stream[0xe] = 0x3b;
  stream[0xf] = (uint)(byte)frontEnd.J2MAX[0];
  stream[0x10] = 0x3c;
  stream[0x11] = (uint)(byte)frontEnd.J2MIN[0];
  stream[0x12] = 0x3d;
  stream[0x13] = (uint)(byte)frontEnd.shockMode[0];
  stream[0x14] = 0x3e;
  stream[0x15] = (uint)(byte)frontEnd.shockImpact[0];
  stream[0x16] = 0x3f;
  stream[0x17] = (uint)(byte)frontEnd.controlConfig[1];
  stream[0x18] = 0x40;
  stream[0x19] = (uint)(byte)frontEnd.deadSpot[1];
  stream[0x1a] = 0x41;
  stream[0x1b] = (uint)(byte)frontEnd.steeringRange[1];
  stream[0x1c] = 0x42;
  stream[0x1d] = (uint)(byte)frontEnd.IImaxRange[1];
  stream[0x1e] = 0x43;
  stream[0x1f] = (uint)(byte)frontEnd.ImaxRange[1];
  stream[0x20] = 0x44;
  stream[0x21] = (uint)(byte)frontEnd.J1MAX[1];
  stream[0x22] = 0x45;
  stream[0x23] = (uint)(byte)frontEnd.J1MIN[1];
  stream[0x24] = 0x46;
  stream[0x25] = (uint)(byte)frontEnd.J2MAX[1];
  stream[0x26] = 0x47;
  stream[0x27] = (uint)(byte)frontEnd.J2MIN[1];
  stream[0x28] = 0x48;
  stream[0x29] = (uint)(byte)frontEnd.shockMode[1];
  stream[0x2a] = 0x49;
  stream[0x2b] = (uint)(byte)frontEnd.shockImpact[1];
  stream[0x2c] = 0x21;
  stream[0x2d] = -1;
  stream[0x2e] = 3;
  stream[0x2f] = 1;
  stream[0x30] = 0x1b;
  iVar3 = (int)frontEnd.randomSeed;
  stream[0x32] = 0x4a;
  stream[0x33] = 0;
  stream[0x34] = 0x24;
  stream[0x31] = iVar3;
  gameLang = (uint)(byte)frontEnd.language;
  trackLang = (uint)(byte)streamData.trackInfo.fLanguage;
  if ((frontEnd.localSpeech != '\0') &&
     (pvVar1 = Front_EnableLocalSpeech(), pvVar1 != (void *)0x0)) {
    stream[0x35] = trackLang;
    d = stream + 0x36;
  }
  else {
    *d++ = gameLang;
  }
  *d++ = 0x27;
  *d++ = (uint)(byte)frontEnd.language;
  *d++ = 0x28;
  *d++ = (uint)(byte)frontEnd.measurement;
  *d++ = 0x11;
  *d++ = 0;
  *d++ = 9;
  *d++ = (uint)(byte)frontEnd.skillLevel;
  *d++ = 10;
  *d++ = (uint)(byte)frontEnd.gameMode;
  *d++ = 7;
  *d++ = (uint)(byte)frontEnd.raceType;
  *d++ = 0x115;
  *d++ = 0;
  *d++ = 0;
  *d++ = 0x117;
  *d++ = 0;
  *d++ = 0;
  *d++ = 0xf;
  *d++ = (uint)(byte)frontEnd.catchup;
  d = Front_AppendTrackData(d,streamData);
  *d++ = 0x13;
  *d++ = (uint)(byte)frontEnd.song;
  *d++ = 0x2a;
  *d++ = (uint)(byte)frontEnd.audioMode;
  *d++ = 0x2b;
  *d++ = (uint)(byte)frontEnd.musicVolume;
  *d++ = 0x2c;
  *d++ = (uint)(byte)frontEnd.sfxVolume;
  *d++ = 0x2d;
  *d++ = (uint)(byte)frontEnd.engineVolume;
  *d++ = 0x2e;
  *d++ = (uint)(byte)frontEnd.narrationVolume;
  *d++ = 0x2f;
  *d++ = (uint)(byte)frontEnd.ambientVolume;
  *d++ = 0x16;
  if ((signed char)streamData.playerCars[0].fCarID == 0x1c) {
    *d++ = 0;
  }
  else {
    if (frontEnd.raceType != RaceType_Tournament) {
      *d++ = (uint)(byte)frontEnd.damage;
    }
    else {
      *d++ = 1;
    }
  }
  numplaylistsongs = 0;
  for (j = 0; j < 0x28; j++) {
    if (frontEnd.FEPlayList[j] != 0) {
      numplaylistsongs++;
    }
  }
  *d++ = 0x30;
  *d++ = numplaylistsongs;
  *d++ = 0x4c;
  *d++ = numplaylistsongs;
  for (j = 0; j < 0x28; j++) {
    if (frontEnd.FEPlayList[j] != 0) {
      *d++ = j;
    }
  }
  *d++ = 0x29;
  iVar3 = Stattool_ReturnRecordLapTime((short)(signed char)streamData.track.fTrackNumber);
  *d++ = iVar3;
  *d++ = 8;
  if ((frontEnd.raceType == RaceType_SingleRace) && (frontEnd.carListType == '\0')) {
    *d++ = 1;
  }
  else {
    *d++ = Front_GetLapsForType();
  }
  if (((streamData.playerCars[0].fCarClass == '\a') || (streamData.playerCars[1].fCarClass == '\a'))
     || ((frontEnd.raceType == RaceType_SingleRace && ((frontEnd.oppNumber == '\0' && (frontEnd.gameMode == '\0')))
         ))) {
    *d++ = 0x20;
    *d++ = 0;
    *d++ = 0x32;
    *d++ = 0;
    *d++ = 0x33;
    *d++ = 0;
  }
  else {
    *d++ = 0x20;
    *d++ = (uint)(byte)frontEnd.checkPointType;
    *d++ = 0x32;
    *d++ = (frontEnd.checkPointDisplay[0] == '\x01')
               ? ((((short *)CountryMeasurement)[streamData.trackInfo.fSpeedoCountry] != 0) ? 1 : 2)
               : 0;
    *d++ = 0x33;
    *d++ = (frontEnd.checkPointDisplay[1] == '\x01')
               ? ((((short *)CountryMeasurement)[streamData.trackInfo.fSpeedoCountry] != 0) ? 1 : 2)
               : 0;
  }
  d = Front_AppendPlayerCarData(d,streamData);
  d = Front_AppendOpponentData(d,streamData);
  d = Front_AppendPerpData(d,streamData);
  d = Front_AppendCopData(d,streamData);
  d = Front_AppendTrafficData(d,streamData);
  *d++ = 0x1c;
  *d++ = (int)streamData.numPlayers + (int)streamData.numOpponents + (int)streamData.numCops +
              (int)streamData.numSuperCops + (int)streamData.numPerpObjects +
              (int)streamData.numTraffic;
  *d++ = 0xe5;
  *d++ = GetPSXPadValue(1,0);
  *d++ = 0xeb;
  *d++ = GetPSXPadValue(8,0);
  *d++ = 0xe8;
  *d++ = GetPSXPadValue(0x80,0);
  *d++ = 0xe9;
  *d++ = GetPSXPadValue(0x20,0);
  *d++ = 0xe6;
  *d++ = GetPSXPadValue(0x10,0);
  *d++ = 0xe7;
  *d++ = GetPSXPadValue(0x40,0);
  *d++ = 0xea;
  *d++ = GetPSXPadValue(0x4000,0);
  config = (uint)(byte)frontEnd.controlConfig[0];
  type = (short)frontEnd.controlType[0];
  type = (type == 0x23) ? 0 : (((type == 0x53) || (type == 0x73)) ? 1 : 2);
  *d++ = 0x4f;
  *d++ = GetPSXPadValue(mappings[config][0][type],0);
  *d++ = 0x50;
  *d++ = GetPSXPadValue(mappings[config][1][type],0);
  *d++ = 0x51;
  *d++ = GetPSXPadValue(mappings[config][2][type],0);
  *d++ = 0x52;
  *d++ = GetPSXPadValue(mappings[config][3][type],0);
  *d++ = 0xfb;
  *d++ = GetPSXPadValue(mappings[config][8][type],0);
  *d++ = 0x53;
  *d++ = GetPSXPadValue(mappings[config][4][type],0);
  *d++ = 0x66;
  *d++ = GetPSXPadValue(mappings[config][5][type],0);
  *d++ = 0x67;
  *d++ = GetPSXPadValue(mappings[config][6][type],0);
  *d++ = 0x68;
  *d++ = GetPSXPadValue(mappings[config][0xc][type],0);
  if (streamData.track.fTimeOfDay != '\0') {
    *d++ = 0x73;
    *d++ = GetPSXPadValue(mappings[config][9][type],0);
    *d++ = 0x54;
    uVar6 = 0;
    if (type == 1) {
      uVar6 = 6;
    }
  }
  else {
    *d++ = 0x73;
    *d++ = 0;
    *d++ = 0x54;
    uVar6 = mappings[config][9][type];
    if (type == 1) {
      uVar6 = uVar6 | 6;
    }
  }
  *d++ = GetPSXPadValue(uVar6,0);
  *d++ = 0x4d;
  *d++ = GetPSXPadValue(mappings[config][0xb][type],0);
  *d++ = 0x75;
  *d++ = GetPSXPadValue(mappings[config][7][type],0);
  *d++ = 0x65;
  *d++ = GetPSXPadValue(mappings[config][7][type],0);
  *d++ = 0x85;
  *d++ = GetPSXPadValue(0x800,0);
  if (streamData.playerCars[0].fCarClass == '\a') {
    if (frontEnd.gameMode != '\x01') {
      *d++ = 0x7a;
      *d++ = GetPSXPadValue(0x8000,0);
      *d++ = 0x7b;
      *d++ = GetPSXPadValue(0x2000,0);
      *d++ = 0x7c;
      *d++ = GetPSXPadValue(0x1000,0);
    }
    *d++ = 0x81;
    uVar6 = mappings[config][10][type];
    if (type == 1) {
      uVar6 = uVar6 | 6;
    }
  }
  else {
    *d++ = 0x82;
    uVar6 = mappings[config][10][type];
    if (type == 1) {
      uVar6 = uVar6 | 6;
    }
    *d++ = GetPSXPadValue(uVar6,0);
    *d++ = 0x7d;
    *d++ = GetPSXPadValue(mappings[config][0][type],0);
    *d++ = 0x7e;
    *d++ = GetPSXPadValue(mappings[config][1][type],0);
    *d++ = 0x81;
    uVar6 = 0x40;
  }
  *d++ = GetPSXPadValue(uVar6,0);
  if (frontEnd.gameMode == '\x01') {
    config = (uint)(byte)frontEnd.controlConfig[1];
    type = (short)frontEnd.controlType[1];
    type = (type == 0x23) ? 0 : (((type == 0x53) || (type == 0x73)) ? 1 : 2);
    *d++ = 0x9b;
    *d++ = GetPSXPadValue(mappings[config][0][type],1);
    *d++ = 0x9c;
    *d++ = GetPSXPadValue(mappings[config][1][type],1);
    *d++ = 0x9d;
    *d++ = GetPSXPadValue(mappings[config][2][type],1);
    *d++ = 0x9e;
    *d++ = GetPSXPadValue(mappings[config][3][type],1);
    *d++ = 0xfc;
    *d++ = GetPSXPadValue(mappings[config][8][type],1);
    *d++ = 0x9f;
    *d++ = GetPSXPadValue(mappings[config][4][type],1);
    *d++ = 0xb2;
    *d++ = GetPSXPadValue(mappings[config][5][type],1);
    *d++ = 0xb3;
    *d++ = GetPSXPadValue(mappings[config][6][type],1);
    *d++ = 0xb4;
    *d++ = GetPSXPadValue(mappings[config][0xc][type],1);
    if (streamData.track.fTimeOfDay != '\0') {
      *d++ = 0xbf;
      *d++ = GetPSXPadValue(mappings[config][9][type],1);
      *d++ = 0xa0;
      uVar6 = 0;
      if (type == 1) {
        uVar6 = 6;
      }
    }
    else {
      *d++ = 0xbf;
      *d++ = 0;
      *d++ = 0xa0;
      uVar6 = mappings[config][9][type];
      if (type == 1) {
        uVar6 = uVar6 | 6;
      }
    }
    *d++ = GetPSXPadValue(uVar6,1);
    *d++ = 0x99;
    *d++ = GetPSXPadValue(mappings[config][0xb][type],1);
    *d++ = 0xc1;
    *d++ = GetPSXPadValue(mappings[config][7][type],1);
    *d++ = 0xb1;
    *d++ = GetPSXPadValue(mappings[config][7][type],1);
    *d++ = 0xd1;
    *d++ = GetPSXPadValue(0x800,1);
    if (streamData.playerCars[1].fCarClass == '\a') {
      *d++ = 0xcd;
      uVar6 = mappings[config][10][type];
      if (type == 1) {
        uVar6 = uVar6 | 6;
      }
    }
    else {
      *d++ = 0xce;
      uVar6 = mappings[config][10][type];
      if (type == 1) {
        uVar6 = uVar6 | 6;
      }
      *d++ = GetPSXPadValue(uVar6,1);
      *d++ = 0xc9;
      *d++ = GetPSXPadValue(mappings[config][0][type],1);
      *d++ = 0xca;
      *d++ = GetPSXPadValue(mappings[config][1][type],1);
      *d++ = 0xcd;
      uVar6 = 0x40;
    }
    *d++ = GetPSXPadValue(uVar6,1);
  }
  *d++ = 0;
  resizememadr(stream,(int)d - (int)stream);
  return stream;
}



/* ---- Front_GetInGameVars  [FRONT.CPP:2728-2752] ---- */

/* Decoded Phase 83: Front_GetInGameVars() - copy GameSetup_gData controller fields into frontEnd
   struct (244 B). Imports controllerData, deadSpot, steeringRange, ImaxRange/IImaxRange, shockMode,
   shockImpact, pinkSlips state for menu display.
   
   [ghidra-meta] section: front.text */

void Front_GetInGameVars(void)

{
  /* MATCH 2026-08-03 (29->PASS): SLD records only `int i`; direct indexed
     controller arrays recover retail's induction variable and address
     lifetimes.  Array views of the volume globals likewise expose their
     address pseudos.  Assigning musicVolume directly (instead of inventing a
     local absent from SLD) creates the frontEnd base before the music-global
     base and resolves the final prologue scheduler tie. */
  int i;
  
  frontEnd.musicVolume = (char)gMasterMusicLevel[0];
  AudioMus_Volume((int)((uint)(byte)frontEnd.musicVolume * 0x23) >> 6);
  frontEnd.sfxVolume = (char)gMasterSFXLevel[0];
  frontEnd.engineVolume = (char)gMasterEngineLevel[0];
  frontEnd.narrationVolume = (char)gMasterFENarrationLevel[0];
  frontEnd.ambientVolume = (char)gMasterAmbientLevel[0];
  frontEnd.pinkSlipsForfeit = (short)GameSetup_gData.pinkSlipsForfeit;
  i = 0;
  do {
    frontEnd.controlConfig[i] = (char)GameSetup_gData.controllerData.controllerConfig[i];
    frontEnd.deadSpot[i] = (char)GameSetup_gData.controllerData.deadSpot[i];
    frontEnd.steeringRange[i] = (char)GameSetup_gData.controllerData.steeringRange[i];
    frontEnd.IImaxRange[i] = (char)GameSetup_gData.controllerData.IImaxRange[i];
    frontEnd.ImaxRange[i] = (char)GameSetup_gData.controllerData.ImaxRange[i];
    frontEnd.shockMode[i] = (char)GameSetup_gData.controllerData.shockMode[i];
    frontEnd.shockImpact[i] = (char)GameSetup_gData.controllerData.shockImpact[i];
    i = i + 1;
  } while (i < 2);
  return;
}



/* ---- SetLicensePlate  [FRONT.CPP:2762-2771] ---- */

/* void SetLicensePlate()
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002B7CC block=CODE size=168B
     Direct callers: 3
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2762
     Sample callers: Initialize__16tScreenCarSelect, DoMemCardStuff__25tScreenPinkSlipsCarSelect,
   Initialize__15tScreenCongrats
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md.
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. Sets license-plate text for both
   players. Loop p=0..1 (2 players, sign-extended via *0x10000 >> 0x10 dance for compiler): fmt =
   PlayerName(p); s = &frontEnd.licensePlate[p*4] (4-char plate buffer per player). sprintf(plate,
   name) -> raw name. UpperCaseItKeepingInMindThoseBloodySpecialCharacters (sic) normalizes accented
   Latin chars. s_lower (then re-lowercases? - likely creates mixed case). CarIO_CleanUpLicense +
   CarIO_CreateLicense generate the plate texture for car rendering. */

void SetLicensePlate(void)

{
  char *fmt;
  char *s;
  short i;

  i = 0;
  do {
    fmt = PlayerName(i);
    s = frontEnd.licensePlate[i];
    sprintf(s,fmt);
    StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(s);
    s_lower(s);
    CarIO_CleanUpLicense(i);
    CarIO_CreateLicense(s,0,i);
    i = i + 1;
  } while (i < 2);
  return;
}



/* ---- SetPlayList  [FRONT.CPP:2777-2811] ---- */

/* void SetPlayList(int ivealreadygotone)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002B874 block=CODE size=236B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2777
     SYM data: 1 regparms / 0 args / 0 autos
     Sample callers: Init_PSX_FrontEnd
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

void SetPlayList(int ivealreadygotone)

{
  int i;
  AudioMus_tSongList *songlist;

  AudioMus_SysCleanUp();
  AudioMus_SysStartUp(0xc000,0x18000,"ymus");
  songlist = AudioMus_GetSongList("game*",0);
  if (ivealreadygotone == 0) {
    i = 0x27;
    do {
      frontEnd.FEPlayList[i] = 0;
      i = i + -1;
    } while (-1 < i);
    i = 0;
    if (0 < songlist->numsongs) {
      do {
        frontEnd.FEPlayList[songlist[i * 8 + 4].currentsong] = 1;
        i = i + 1;
      } while (i < songlist->numsongs);
    }
  }
  frontEnd.GotAPlayList = 1;
  purgememadr(songlist);
  AudioMus_SysCleanUp();
  AudioMus_SysStartUp(0xd800,0x18000,"amus");
  return;
}



/* ---- Front_GetTrackRaced  [FRONT.CPP:2815-2830] ---- */

/* Decoded Phase 83: Front_GetTrackRaced() - return track ID for current race (112 B, 10 callers -
   hot). raceType==2 (tournament): track from tourney progress; otherwise from menu selection.
   
   [ghidra-meta] section: front.text */

short Front_GetTrackRaced(void)

{
  short trackraced;
  short sVar1;
  tTrackInformation trackInfo;
  
  if (frontEnd.raceType == RaceType_Tournament) {
    sVar1 = tournamentManager.GetLastTrackRaced();
  }
  else {
    trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               trackInfo);
    sVar1 = (short)(signed char)trackInfo.fTrackID;
  }
  return sVar1;
}



/* ---- PlayerNameExist  [FRONT.CPP:2834-2837] ---- */

/* void * PlayerNameExist(int player)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002B9D0 block=CODE size=44B
     Direct callers: 2
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2834
     SYM data: 1 regparms / 0 args / 0 autos
     Sample callers: Init_MemcardFile,
   Cars_InitializeCarTablesFlagsAndCounters
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

void * PlayerNameExist(int player)

{
  uint uVar1;
  
  uVar1 = strlen(frontEnd.playerNameList[player]);
  return (void *)(uint)(uVar1 != 0);
}



/* ---- PlayerName  [FRONT.CPP:2841-2850] ---- */

/* char * PlayerName(int player)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002B9FC block=CODE size=140B
     Direct callers: 17
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2841
     SYM data: 1 regparms / 0 args / 0 autos
     Sample callers: Init_MemcardFile, MainLoop__14tFEApplicationP5tMenu,
   SavePinkSlipsCarsWithErrorDialogs, StatChk_SaveRecordLapTime
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md.
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. Returns ALL-UPPER player name. s =
   &frontEnd.allUpperCasedPlayerNameList[player*4]. sprintf(*s, frontEnd.playerNameList[player*4])
   copies the raw name. name_len = strlen(*s); on empty: same default fallback as
   PlayerNameMixedCase (wordnum = 0x4E or player+0x50 from TextSys). Else:
   StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters in-place uppercases (handles
   accented Latin chars). Returns *s. Mirror of PlayerNameMixedCase but enforces uppercase output.
    */

char * PlayerName(int player)

{
  uint name_len;
  char (*s)[8];
  int wordnum;
  
  s = frontEnd.allUpperCasedPlayerNameList + player;
  sprintf(*s,frontEnd.playerNameList[player]);
  name_len = strlen(*s);
  if (name_len != 0) {
    StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(*s);
    return *s;
  }
  wordnum = 0x4e;
  if (frontEnd.gameMode == '\x01') {
    wordnum = player + 0x50;
  }
  return (char *)TextSys_Word(wordnum);
}



/* ---- PlayerNameMixedCase  [FRONT.CPP:2859-2866] ---- */

/* char * PlayerNameMixedCase(int player)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002BA88 block=CODE size=108B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2859
     SYM data: 1 regparms / 0 args / 0 autos
     Sample callers: Cars_InitializeCarTablesFlagsAndCounters
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md.
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. Returns mixed-case player name (with
   default fallback). s = &frontEnd.playerNameList[player*4]. name_len = strlen(*s). On empty name:
   wordnum = 0x4E (= 'PLAYER' default text-id); for 2-player mode: wordnum = player + 0x50 (=
   'PLAYER ONE' / 'PLAYER TWO'); s = TextSys_Word(wordnum). Returns *s (= the displayed name).Mixed-case = 'Foo' rather than the 'FOO' variant in PlayerName (which forces uppercase via
   StatTool helper). */

char * PlayerNameMixedCase(int player)

{
  uint name_len;
  char (*s)[8];
  int wordnum;
  
  s = frontEnd.playerNameList + player;
  name_len = strlen(*s);
  if (name_len != 0) {
    return *s;
  }
  wordnum = 0x4e;
  if (frontEnd.gameMode == '\x01') {
    wordnum = player + 0x50;
  }
  return (char *)TextSys_Word(wordnum);
}



/* end of front.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
/* _usePlayerUpgrades REMOVED W66-A5: no reference anywhere in recon and no SYM
   record in ANY obj block -- an invention that was silently occupying
   gAllScreens' 4 retail bytes in Front.obj's .data run. */
