# `flare.obj` owner/type-graph reconciliation (P142/P246)

- Date: 2026-08-27
- Retail owner: standalone `flare.obj`
- Source: `recon/game/psx/flare.cpp`

## Proven owner surface

The former monolithic includes emitted all 93 retail named types and both
anonymous types, but also leaked 453 unrelated named tags, ten anonymous tags,
and 525 unrelated typedef semantics.  A set comparison against every canonical
owner showed that `color.obj` is a strict subset of `flare.obj`: it contributes
71 of the 93 named records and no extras.  The exact retail delta is 22 records:

- `TCB`, `EXEC`, `DIRENTRY`;
- `POLY_F4`, `POLY_FT4`, `POLY_G3`, `POLY_G4`, `LINE_G2`;
- `DRender_tView`, `Draw_FlareCache`, `Sched_tSchedule`;
- `forceFocus_t`;
- `FLARE_PIECE_DEF`, `FLARE_DEF`, `Flare_tInfo`;
- `CHorizonSpec`, `CSkySpec`, `CNightSpec`, `CWeatherSpec`, `CFogSpec`,
  `CDepthCueSpec`, and `CWorldColor`.

`flare_types.h` includes the already exact `color_types.h` subset and defines
only that delta.  The resulting full-debug graph is OK at 93/93 named, 2/2
anonymous and all typedef semantics covered (176/224 physical rows after exact
duplicate-record canonicalization).  There are zero missing, mismatched, or
source-extra type semantics.

## Source-boundary restoration

- The invented four-byte `Flare_PTag` is removed.  Fifteen packet-link sites
  use the canonical eight-byte PsyQ `P_TAG` through `setaddr` and `getaddr`,
  with cursor increments kept between the two stores where required by retail.
- `GameSetup_gData.commMode` is expressed through an exact-symbol
  `GameSetup_tPerpData` view at offset 12.
- the `TrackSpec_gSpec.skyspec` uses are expressed through a `CSkySpec` view at
  TrackSpec offset 88.
- `simGlobal.gameTicks` is expressed through a `coorddef` view at offset 4.
- the broad `libfns.h` declaration umbrella is replaced by typed declarations
  for the six functions actually called by this owner.

All carrier records used by those views are independently retained by
`flare.obj`; the foreign aggregate bodies are no longer emitted.

## Matching and declaration proof

- complete `flare.cpp`: 8 PASS / 8 NEAR / 11 FAR before and after;
- the eight NEAR counts and lengths remain 7, 12, 14, 14, 14, 14, 14, and 15;
- complete game/PSX type sweep: 24 OK / 4 DIFF;
- strict declaration audit: 395/395 mapped, with zero missing SYM names, type
  findings, storage findings, global type findings, or mapping-review items.

Machine-readable evidence is retained in
`type_graph_flare_p246_20260827.tsv`,
`full_type_graph_game_psx_p246_20260827.tsv`, and
`game_psx_strict_p246_20260827.md`.
