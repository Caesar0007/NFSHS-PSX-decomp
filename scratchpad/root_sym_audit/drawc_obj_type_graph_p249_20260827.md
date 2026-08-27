# `DrawC.obj` owner/type-graph reconciliation (P145/P249)

- Date: 2026-08-27
- Retail owner: standalone `DrawC.obj`
- Source: `recon/game/psx/drawc.cpp`

## Exact source-visible type surface

The former `nfs4_types.h` and `libfns.h` umbrellas covered all 105 retail
named types but leaked 441 unrelated named tags, ten unrelated anonymous tags,
and 499 unrelated typedef semantics.  Canonical owner-set comparison proves
that `psxcontroller.obj` is an exact 86-name subset of `DrawC.obj`.
`drawc_types.h` includes that subset and restores precisely the 19-name delta:

- `BW_tContext`, `Draw_CarCache`, `Draw_SubdivStruct`, `Draw_tVertex`, and
  `DrawC_tEnvMap`;
- `Track_tArtresource`, `Track_tMaterial`, `Skidmark_Chunk`, and
  `Skidmark_Segment`;
- `TCB`, `EXEC`, and `DIRENTRY`;
- `POLY_FT3`, `POLY_FT4`, `POLY_G3`, and `POLY_GT4`;
- `FLARE_PIECE_DEF`, `forceFocus_t`, and `Sched_tSchedule`.

The independent typedef lane adds the four semantic rows not visible in that
named comparison: `CarLogic_tObservations`, `Night_tLightingTable`,
`Night_tWeatherLightingTable`, and `Night_tCopLightingTable`.  Conversely,
`Input_tDeviceCall` belongs to the shared GameSetup/PSXController owner surface
but is absent from retail DrawC.  A documented, DrawC-only include switch now
suppresses exactly that typedef; all other users of `gmesetup_types.h` retain
the previous surface.

The focused canonical gate is now OK at 105/105 named and 2/2 anonymous types,
with no missing, mismatched, or source-extra type semantics.  Physical
duplicate-emission evidence remains explicit: 307/389 typedef rows represent
covered unique semantics after canonicalization, and the report retains the
retail/source multiplicity differences.

The complete `game/psx` sweep improves from 26 OK / 2 DIFF to 27 OK / 1 DIFF.
Only `draww.obj` remains non-exact in this directory.

## Canonical primitive and foreign-symbol boundary

The synthetic anonymous `DrawC_tTag` is removed.  All ten OT-link casts now
use the canonical PsyQ `P_TAG` carrier from `psyq_prim_macros.h`; representative
OT-link functions remain byte-exact.

DrawC accesses only the `track`/`Weather` members of `GameSetup_gData` and the
`id`/`player` prefix of `gCView`, while the owning `GameSetup_tData` and
`DRender_tView` tags are absent from retail `DrawC.obj`.  Raw integer-array
views alter component-MEM address formation, so `drawc_externs.h` supplies two
layout-locked exact-symbol views:

- `DrawC_GameSetupCodegenView` (2,600 bytes) -> `GameSetup_gData`;
- `DrawC_CViewCodegenView` (140 bytes) -> `gCView`.

These are explicit reconstruction/codegen evidence, not claims about original
private type spellings.  The canonical audit excludes them only when owner,
name, total size, every member kind/name/size/offset/leaf tag, and the matching
typedef are simultaneously exact.  The unfiltered report proves these two
tags/typedefs are the complete synthetic boundary.  Typed declarations for the
twelve runtime/PsyQ functions actually used replace the broad `libfns.h`
interface; pointer-only foreign argument types remain incomplete declarations
and emit no spurious type definitions.

## SYM declarations and matching

The strict declaration audit maps all 395 `game/psx` functions and reports
zero missing names, type/storage/global findings, or mapping-review cases.
DrawC's former generic review row is closed: `DrawC_PrimStart`'s `pos`, `ev`,
`byteOffset`, and `envMapOffset` are now explicitly tied to their existing
W71/W76 allocation receipts.  The function remains PASS at 976 instructions.

The consolidated detailed gate covers all 20 DrawC functions:

- 19/20 functions PASS byte-for-byte, unchanged from the prior owner baseline;
- `DrawC_NightHeadlight` remains the explicit open target at four normalized
  scheduling diff lines, with an exact 107/107 instruction count.  The
  residual is the ordering of the `Night_gWeatherColor` `%lo` materialization
  and the first `light`-slot byte load.  It is not claimed as a floor.

## Full regression proof

- source-only policy: no post-compiler text moves or branch retargets;
- TU order: 513 objects, zero inversions;
- call-target audit: 460 units, zero proven wrong targets;
- vtable indexing: 936 files PASS;
- undefined calls: 15,782 recon and 15,779 source-lane call relocations, zero
  undefined targets;
- both relink lanes GREEN, with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- full shared-header phantom audit: 513/513 TUs compiled, all 3,484 declared
  names exactly owned, zero hidden phantoms or ownership gaps.

Machine-readable evidence:

- `type_graph_drawc_p249.tsv`;
- `type_graph_drawc_codegen_unfiltered_p249.tsv`;
- `drawc_owner_type_delta_p249_20260827.txt`;
- `drawc_full_verify_p249_20260827.txt`;
- `full_type_graph_game_psx_p249_20260827.tsv`;
- `game_psx_strict_p249_20260827.md`.
