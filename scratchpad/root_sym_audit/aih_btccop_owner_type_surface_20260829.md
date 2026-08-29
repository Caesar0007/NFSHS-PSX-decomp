# `aih_btccop.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `6529ceeb`.

## Source graph restoration

The retail owner contains 152 distinct named definitions and 10 anonymous
definitions.  `newton.obj` contributes a strict 87-definition semantic subset
with no foreign records; `aih_btccop_types.h` composes that proven surface and
restores only the 65 remaining named definitions plus the exact anonymous
enums and Speech bank aggregates retained by this owner.

The old monolithic `nfs4_types.h` boundary emitted 395 unrelated named types,
one unrelated anonymous type, and 454 unrelated typedef semantics.  The new
owner header removes that leakage.  It also restores eight function typedef
semantics retained in the retail owner and avoids inventing typedef names for
the original anonymous `tPullOverMode`, `tPerpMode`, `tFreezeMode`, and
`tWingmanStatus` enums.

Four declarations were corrected to match the graph actually retained by the
owner:

- `AIHigh_CopGameType` and `AICop_gRoadBlockState` use integer storage plus
  source constants; the retail owner contains neither enum tag.
- `AIDataRecord_TrackCurve` is opaque and its `Get` call uses the canonical
  mangled member symbol without importing the foreign class definition.
- `AIState_Idle` is an owner-external member-offset view rather than a completed
  class tag in this owner.

Six other owner-external globals and the file-local inactive-state constructor
still require aggregate member shapes to preserve the retail instructions.
Their private codegen carriers are pair-locked in the canonical audit by exact
owner, name, size, every member, offset, array bound, and leaf tag.  Any drift
becomes a visible DIFF.

## SYM and matching proof

Focused board `aih_btccop_type_graph_p364_20260829.tsv`:

- named definitions: 152/152 exact;
- anonymous definitions: 10/10 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Retail duplicate tag/typedef multiplicities remain recorded as linked-debug
duplication evidence; they do not justify illegal duplicate C++ definitions.

Both normal repeated gates and the explicit `NFS4_SOURCE_ONLY=1` gate report
`40/40 PASS` for `recon/game/common/aih_btccop.cpp`.

Full board `project_type_graph_p365_20260829.tsv` reports 391 `OK`, 26 `DIFF`,
30 known debug-compile failures, and 11 unresolved owner mappings.  Compared
with p363, exactly one owner changed status: `aih_btccop.cpp` moved from `DIFF`
to `OK`; no owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 984 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
