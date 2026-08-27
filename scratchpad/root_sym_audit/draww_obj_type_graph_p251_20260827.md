# `DrawW.obj` owner/type-graph reconciliation (P250/P251)

- Date: 2026-08-27
- Retail owner: standalone `DrawW.obj`
- Source: `recon/game/psx/draww.cpp`

## Exact source-visible type surface

The former `nfs4_types.h` and `libfns.h` umbrella includes covered all 120
retail named records but leaked 427 unrelated named tags, ten unrelated
anonymous tags, and 486 unrelated typedef semantics.  Canonical owner-set
comparison proves that `color.obj` is an exact 71-name subset of `DrawW.obj`.
The new `draww_types.h` starts from that subset and restores precisely the
49-name DrawW delta plus its independent SDK typedef lane.

The focused canonical gate is now `OK`: 120/120 named records and 2/2
anonymous records are exact, with zero missing, mismatched, or source-extra
semantics.  The 349/424 typedef coverage count is a duplicate-emission count,
not a missing-semantic count: both retail and source retain 245 duplicate
typedef rows after canonicalization, and the report contains no semantic
typedef finding.

The complete `game/psx` sweep improves from 27 `OK` / 1 `DIFF` to 28/28
`OK`.  There are no remaining type-graph DIFF owners in that directory.

## Canonical SDK and foreign-symbol boundaries

The local four-byte `DrawW_PTag` reconstruction is replaced by the canonical
PsyQ `P_TAG`/`addPrim` carrier in `psyq_prim_macros.h`.  The canonical audit
already validates and filters that exact SDK macro type.

DrawW consumes member-shaped data from five foreign owners whose aggregate
tags are absent from retail `DrawW.obj`: `BWorldSm_slices`, `Camera_gInfo`,
`GameSetup_gData`, `simGlobal`, and `TrackSpec_gSpec`.  Raw byte/word views
alter component-MEM address formation, so `draww_externs.h` supplies five
layout-locked exact-symbol views.  The unaligned eight-byte quaternion copy
likewise retains one explicit local `DrawW_Pack8CodegenView` because it is the
source-only shape that emits retail's `lwl/lwr/swl/swr` move.

These six names are reconstruction/codegen evidence, not claims about
original private source spellings.  `audit_sym_canonical_types.py` excludes
them only when owner path, name, total size, every member kind/name/size/
offset/leaf tag, and matching implicit typedef are simultaneously exact.  The
unfiltered P252 report proved that these six tags and their six typedefs were
the complete synthetic boundary; after pair-locked validation, the owner is
strictly exact.

The broad `libfns.h` dependency is replaced by typed declarations for the nine
runtime/PsyQ functions actually used.  Pointer-only `Draw_FlareCache` remains
an incomplete declaration and therefore contributes no foreign type body.

## SYM declarations and matching

`ObjectClipped` now uses native `bool` for the SYM `BOOL` local and remains
byte-exact at 61 instructions.  The strict declaration audit improves from
392/395 to 393/395 clean functions.  `DrawObjectSimple::offsetArg` is no longer
a generic review disposition: retail records both the fifth stack argument
and GCC's promoted register copy as `offset`, while the authentic single-name
spelling measures FAIL 5 at 190/189.  The explicit alias spelling is retained
because it sinks the reload and remains PASS189; its source-name discrepancy
is documented as an active codegen carrier, not misrepresented as restored
source.  The only generic declaration findings remaining in `game/psx` are
the two already-isolated weather carriers (`cameraWords` and `wdp`).

All 35 detailed DrawW functions were freshly checked.  The result is unchanged
at 31 PASS and four open residuals:

- `DrawW_SubdividFacet`: 8 diffs, 588/588 instructions;
- `DrawW_DoTrough`: 9 diffs, 358/359 instructions;
- `Draw_kCtrlSkidmark`: 20 diffs, 353/353 instructions;
- `DrawW_OnyxLinePrim`: 66 diffs, 507/507 instructions.

No prior PASS regressed and none of the four residuals is claimed as a floor.

## Full regression proof

- source-only policy: no post-compiler text moves or branch retargets;
- TU order: 513 objects, zero inversions;
- call-target audit: 460 units, zero proven wrong targets;
- vtable indexing: 937 files PASS;
- undefined calls: 15,782 recon and 15,779 source-lane call relocations, zero
  undefined targets;
- both relink lanes GREEN, with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- full phantom audit: 513/513 TUs compiled, all 3,484 distinct declared names
  exactly owned, zero hidden phantoms or ownership gaps.

The phantom run warned that the optional `2.8.1-norcse` ladder rung was absent
and `FONT.c` therefore used its normal TU compiler.  This does not weaken the
ownership result: all 513 TUs compiled and all phantom/ownership counts are
zero; it only means unrelated FONT function match numbers would drift in that
particular full-tree build.

Machine-readable evidence:

- `type_graph_draww_baseline_p250_20260827.tsv`;
- `type_graph_draww_p251_20260827.tsv`;
- `draww_full_verify_baseline_p250_20260827.txt` (the fresh P251 run reproduced
  every line/status/count);
- `game_psx_type_graph_p251_20260827.tsv`;
- `game_psx_strict_p252_20260827.md`.
