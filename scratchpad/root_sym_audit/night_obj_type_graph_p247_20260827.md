# `night.obj` owner/type-graph reconciliation (P143/P247)

- Date: 2026-08-27
- Retail owner: standalone `night.obj`
- Source: `recon/game/psx/night.cpp`

## Proven owner surface

The former `nfs4_types.h`/`libfns.h` umbrellas covered all 92 retail named
types and both anonymous types only by leaking 454 unrelated named tags, ten
anonymous tags, and 520 unrelated typedef semantics.  Canonical owner-set
comparison proves that the already exact `color.obj` graph is a strict subset
of `night.obj`.  The exact named delta contains 21 records:

- `TCB`, `EXEC`, `DIRENTRY`, and `POLY_GT4`;
- `DRender_tView`, `Draw_SubdivStruct`, `Track_tArtresource`, and
  `Track_tMaterial`;
- `Skidmark_Segment`, `Skidmark_Chunk`, and `forceFocus_t`;
- `CHorizonSpec`, `CSkySpec`, `CNightSpec`, `CWeatherSpec`, `CFogSpec`,
  `CDepthCueSpec`, and `CWorldColor`;
- `Sched_tSchedule`, `tCompRGB`, and `tNightInitCache`.

`night_types.h` includes the proven `color_types.h` subset, reconstructs only
that delta, and restores the three owner typedefs `Night_tLightingTable`,
`Night_tWeatherLightingTable`, and `Night_tCopLightingTable`.  The unused
reconstruction-only `NightCopTablePair` tag/typedef is removed.  Full-debug
comparison is now OK at 92/92 named and 2/2 anonymous records, with all typedef
semantics covered (159/206 physical rows after exact duplicate-record
canonicalization).  No missing, mismatched, or source-extra type semantics
remain.

## Foreign-symbol boundary and camera proof

GameSetup, simGlobal, TrackSpec, Weather, and Camera owner bodies are absent
from the retail night graph.  Their live fields are represented by exact-symbol
views at the linked-SYM offsets:

- GameSetup `commMode`, `cops`, `Weather`, and `Time`: +12, +20, +72, +84;
- simGlobal `gameTicks`: +4;
- TrackSpec `nightspec` and `depthcuespec`: +236 and +240;
- Camera `target` and `slicePos`: +4 and +140, with a 272-byte row;
- Weather state: the four-byte `Weather_gType` cell.

Raw-byte camera expressions are not codegen-equivalent: CC1PLUS folds +140
into the `Camera_gInfo+140` relocation and emits `lh ...,0(base)`, while retail
materializes `Camera_gInfo` and emits `lh ...,140(base)`.  The same distinction
exists for `target`: a byte cast emits `lw ...,0(base+4)` while retail uses
`lw ...,4(base)`.  The private 272-byte `Night_CameraCodegenView` therefore
models the proven prefix (`anchor`, `target`, padding, `slicePos`) and restores
the component-MEM RTL.  Its tag is not present in the retail SYM, so the
canonical audit excludes it only when owner, name, total size, all four member
types/sizes/names/offsets, and the implicit typedef agree exactly.  Any drift
remains a visible DIFF.  This is an explicit source-codegen carrier, not a
claim that the unrecoverable private camera prefix spelling is original.

The broad `libfns.h` umbrella is replaced with typed declarations for the
eight runtime functions actually called by `night.cpp`.

## Matching and regression proof

- authoritative detailed `verify_asm`: all 19/19 functions PASS, including
  `Night_SetEnviroment` at 68 instructions and
  `Night_GenerateAllLightTables` at 165;
- complete game/PSX type sweep: 25 OK / 3 DIFF; only `drawc`, `draww`, and
  `hud` remain;
- strict declaration audit: 395/395 functions mapped, zero missing SYM names,
  type findings, storage findings, global type findings, or mapping review;
- both relink lanes GREEN, with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: 15,782 recon and 15,779 source-lane calls, zero
  undefined targets;
- TU order: 513 objects, zero inversions; call-target audit: 460 units, zero
  proven wrong targets; vtable indexing: 934 files PASS;
- phantom audit: 513/513 TUs compile, all 3,484 declared names exactly owned,
  zero hidden phantoms or ownership gaps; `__Fe` census remains zero;
- source-only policy audit: no post-compiler text moves or branch retargets.

Machine-readable evidence is retained in `type_graph_night_p247.tsv`,
`full_type_graph_game_psx_p247_20260827.tsv`, and
`game_psx_strict_p247_20260827.md`.
