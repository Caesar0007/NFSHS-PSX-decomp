# `ScreenCarSelect.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `ScreenCarSelect.obj`

Source TU: `recon/frontend/common/screencarselect.cpp`

`screencarselect_types.h` composes FEDialog's already exact shared frontend,
physics, tournament, dialog, memory-card, and PsyQ graph while suppressing the
five FEDialog-only records `helpKeyData`, `tHelpData`, `tDialogYesNoMem`,
`tDialogYesNoTri`, and the completed `tMenuCommand` tag.  It restores the 13
ScreenCarSelect additions: `AudioMus_tSongEntry`, `DR_AREA`,
`PinkSlipsCarSelectState`, `tCarStatType`, `tDrawShapeExtended`, `tOverlay`,
the four car-select classes, the two standings classes, and `tVideoWall`.

The source spellings `BOOL`, `uchar`, `tScreen_TransitionType`,
`tMenuTextType`, `tMenuTextState`, and `tCheatCode` are macros in this owner,
because its linked graph retains none of those typedef or completed enum
records.  Explicit GCC-v2 asm labels preserve the real enum-bearing callee
symbols without inventing foreign debug types.  `FEVECTOR` and `FEMATRIX` are
retained as the two array typedefs present in the retail owner.

ScreenCarSelect directly reads three foreign singletons whose completed tags
are absent from its linked graph: `GameSetup_gData.track`, `gPadinfo.buf[0]`,
and selected members of `tGlobalMenuDefs`.  Their 64-byte, 68-byte, and
8,408-byte sparse views are accepted only as exact tag/typedef pairs with
every member, gap, offset, leaf tag, size, and source origin locked in the
canonical audit.  The named four-byte PsyQ primitive-link carrier is locked
the same way.  The one 204-byte anonymous union is a 59/59-PASS stack alias
between `tCarInfo carInfo` and `signed char signedCarID`; the audit accepts it
only with that exact owner, size, members, tags, and offsets.  Any carrier
drift therefore reappears as a graph failure.  The audit tool's pre-change
backup is pushed commit `fc30a9cd`.

Strict compiler-emitted comparison:

- named records: 179/179 exact
- anonymous records: 2/2 exact
- source-only named records: 0 after exact foreign/codegen locks
- source-only anonymous records: 0 after the exact stack-union lock
- source-only typedef semantics: 0 after exact pair-locks
- result: `OK`

Verification:

- repeated `python tools/tugate.py recon/frontend/common/screencarselect.cpp`
  runs: 59/59 PASS
- exact-neighbor regressions: FEDialog 33/33 PASS, ScreenMemcard 15/15 PASS,
  ScreenDisplay 3/3 PASS; their focused canonical graphs remain `OK`
- focused graph: `screencarselect_type_graph_p278_20260828.tsv`
- full frontend/common sweep: 28 exact owners, 13 remaining visibility
  residuals
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing names, extras, type findings,
  storage findings, or mapping-review entries
