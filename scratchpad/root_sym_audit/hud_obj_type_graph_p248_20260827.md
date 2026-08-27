# `hud.obj` owner/type-graph reconciliation (P144/P248)

- Date: 2026-08-27
- Retail owner: standalone `hud.obj`
- Source: `recon/game/psx/hud.cpp`

## Exact source-visible type surface

The former `nfs4_types.h`/`libfns.h` umbrella made the HUD compile by exposing
many foreign-owner tags that `hud.obj` does not contain.  Canonical owner-set
comparison proves that `psxcontroller.obj` is an exact 86-name subset of the
103 named types retained by `hud.obj`.  `hud_types.h` includes that proven
subset and restores precisely the 17-name delta:

- `AIDataRecord_AccTable_t`, `AIDataRecord_CurveSpeedTable_t`,
  `AIDataRecord_RecordMethod_t`, and `AIDataRecord_t`;
- `AudioMus_tCurrentSong` and `AudioMus_tSongEntry`;
- `FLARE_PIECE_DEF`, `forceFocus_t`, `HudPmx_tShape`, and
  `Sched_tSchedule`;
- `POLY_F3`, `POLY_F4`, `POLY_FT4`, `POLY_G4`, `POLY_GT4`, `SPRT`, and
  `tSmallCoordXY`.

The independent typedef lane also identified the otherwise-unused
`CarLogic_tObservations` as `int[1][3]`; that exact typedef is now present.
The focused type gate is therefore OK at 103/103 named and 2/2 anonymous
records, with no missing, mismatched, or source-extra type semantics.  It
retains the physical duplicate-emission evidence separately: 209/291 typedef
rows are unique semantics after canonicalization, while the report lists all
retail/source multiplicity differences instead of hiding them.

The complete `game/psx` sweep improves from 25 OK / 3 DIFF to 26 OK / 2 DIFF.
Only `drawc.obj` and `draww.obj` remain non-exact in this directory.

## Foreign-symbol boundary and layout proof

HUD instructions access fields of GameSetup, simGlobal, Camera, DashHUD, pad,
replay, simVar, and gCView objects whose owning aggregate tags are deliberately
absent from `hud.obj`.  Raw word/byte expressions recover offsets but alter
CC1PLUS component-MEM RTL by folding member offsets into relocations; this
broke previously byte-exact functions.  `hud_externs.h` therefore provides
eight private, exact-symbol codegen views with fully measured sizes and member
offsets:

- `Hud_CViewCodegenView` (140 bytes) -> `gCView`;
- `Hud_GameSetupCodegenView` (2,600 bytes) -> `GameSetup_gData`;
- `Hud_SimGlobalCodegenView` (24 bytes) -> `simGlobal`;
- `Hud_CameraCodegenView` (272 bytes) -> `Camera_gInfo`;
- `Hud_DashCodegenView` (108 bytes) -> `DashHUD_gInfo`;
- `Hud_PadCodegenView` (84 bytes) -> `gPadinfo`;
- `Hud_ReplayCodegenView` (32 bytes) -> `Replay_ReplayInterface`;
- `Hud_SimVarCodegenView` (28 bytes) -> `simVar`.

These tags are explicit reconstruction/codegen evidence, not claims about
unrecoverable original private type spellings.  The canonical audit suppresses
them only when the owner header, tag name, total size, every member kind/name/
size/offset/leaf tag, and the matching typedef are simultaneously exact.  The
struct and typedef are pair-locked; one-sided drift remains visible.  The
unfiltered report proves that exactly these eight tags/typedefs, and no others,
form the synthetic boundary.

Two additional symbol views preserve retail address algebra without inventing
absent aggregate tags:

- `BTCPerpInfo` is represented as an exact-symbol `int[][10][4]` view;
- `BWorldSm_slices` is represented as a pointer to 32-byte integer rows.

The GameSetup layout audit also corrected `checkpointType` to byte offset 188
(word 47), which restored `Hud_BuildNumbers0` exactly.  Typed runtime and PsyQ
declarations replace the broad `libfns.h` include.

## SYM declarations and low-opcode ownership

The strict declaration audit maps every one of the 395 functions in
`recon/game/psx` to its demangled SYM definition.  It reports zero missing SYM
names, type findings, function/global storage findings, global type findings,
or mapping-review cases.  HUD itself has no remaining generic review row.
`Hud_Init`'s `g4`/`one` scheduling identities and every other non-SYM HUD local
are explicitly marked as source-only codegen carriers with in-source oracle
receipts; adding the missing marker did not alter its 624-instruction PASS.

The opcode-6 ledger independently identifies HUD's `uppercase` as a typed
static function and `day_needle`, `night_needle`, and
`BTC_playedsoundalready` as typed static data owned by `hud.obj`.  The source
audit reports no HUD-owned global omission, type contradiction, or storage
contradiction.

## Matching and regression proof

The consolidated detailed `verify_asm` log covers all 62 functions, including
the local `uppercase`:

- 61/62 functions PASS byte-for-byte;
- `Hud_BuildCdPlayer` improves from its former one-diff residual to PASS at
  475 instructions;
- `Hud_RenderTacView` remains the sole residual at 11 normalized diff lines,
  ours 72 instructions versus retail 71.  The differences are confined to
  three `%hi/%lo` scratch-register identity sites around `DashHUD_gInfo`; all
  other instructions and the saved-register/frame shape agree.  This is an
  explicit open matching target, not a claimed floor.

Full safety gates after rebuilding HUD:

- source-only policy: no post-compiler text moves or branch retargets;
- TU order: 513 objects, zero inversions;
- call-target audit: 460 units, zero proven wrong targets;
- vtable indexing: 935 files PASS;
- undefined calls: 15,782 recon and 15,779 source-lane call relocations, zero
  undefined targets;
- both relink lanes GREEN, with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- phantom ownership: 513/513 TUs compile, all 3,484 declared names exactly
  owned, zero hidden phantoms or ownership gaps.

Machine-readable evidence:

- `type_graph_hud_p248.tsv`;
- `type_graph_hud_codegen_unfiltered_p248.tsv`;
- `hud_owner_type_delta_p248_20260827.txt`;
- `hud_full_verify_p248_20260827.txt`;
- `full_type_graph_game_psx_p248_20260827.tsv`;
- `game_psx_strict_p248_20260827.md`.
