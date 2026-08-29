# `R3DCar.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `181c97a9`.

## Source graph restoration

`r3dcar_types.h` now composes the exact shared `DrawC.obj` graph while
excluding the six DrawC-only definitions `POLY_FT3`, `POLY_FT4`, `POLY_G3`,
`BW_tContext`, `FLARE_PIECE_DEF`, and `DrawC_tEnvMap`. It restores R3DCar's
four owner-only definitions: `AudioMus_tSongEntry`, `DRender_tView`,
`Transformer_zScene`, and `R3DCar_tEnvMapInfo`, plus the owner-visible
`Input_tDeviceCall` function typedef. `Texture_pal8bit` remains only a forward
declaration, matching the absence of its completed body from this owner.

Seven completed foreign-owner tags are absent from the linked `R3DCar.obj`
graph even though the owner dereferences their state: AITune track data,
GameSetup data, camera data, simulation globals, simulation system state,
replay state, and DrawC environment-map rows. Private compiler-boundary views
retain their complete known retail layouts and original field offsets. The
canonical-type audit accepts each view only when its header, private name,
size, members, fields, and implicit C++ typedef pair match the recorded
fingerprint. The explicit `gsData` local's repeated typedef is independently
locked at its use site.

The broad `nfs4_types.h`/`libfns.h` dependency was replaced with the exact
owner surface and the precise pruned runtime declaration subset used by this
translation unit. Preserving the original runtime return types and varargs
boundary is required for the retail allocation in two functions. Fixed
scratchpad cells remain address-bearing lvalue macros and do not claim storage.
No executable statement was added or removed; the only function-body type
change names the exact private GameSetup boundary view for the existing local.

## SYM and matching proof

Focused board `r3dcar_type_graph_p391_20260829.tsv`:

- named definitions: 103/103 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit source-only gate report 27/27 PASS for
`recon/game/common/r3dcar.cpp`, spanning 8 through 1,144 instructions per
function. The neighboring `DrawC.obj` graph was separately regression-checked
at 105/105 named and 2/2 anonymous definitions with zero source extras.

Full board `sym_type_graph_board_p392_20260829.tsv` reports 406 `OK`, 11
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p390, exactly `r3dcar.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 1,000 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
