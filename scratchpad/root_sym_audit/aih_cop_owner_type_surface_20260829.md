# `aih_cop.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `1663262f`.

## Source graph restoration

`aih_cop_types.h` now composes the exact shared AI hierarchy and restores the
owner's complete 137-definition named graph and 11 anonymous definitions. Its
owner delta includes `AIHigh_Cop`, `AIState_Chase`, `AIState_GotoSlice`, the
PSYQ `POLY_GT4` / `TCB` / `EXEC` / `DIRENTRY` records, track-art and material
records, skidmark records, and the Speech bank/tag surface retained by SYM.

Six foreign globals use exact member-shaped compiler-boundary views. The
linked owner omits their completed tags, so the audit pair-locks their precise
owner header, name, size, offsets, members, and implicit typedef identity.
The placement-constructed foreign `AIState_Purgatory` and `AIState_Offroad`
classes are locked the same way. The trigger-manager view's three used member
declarations retain the canonical `AITrigger_TriggerManager` link symbols via
declaration-level assembler names; no instruction body or post-compiler rewrite
is involved.

## SYM and matching proof

Focused board `aih_cop_type_graph_p379_20260829.tsv`:

- named definitions: 137/137 exact;
- anonymous definitions: 11/11 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 9/9 PASS
for `recon/game/common/aih_cop.cpp`. This includes the 1,460-instruction
`AIHigh_Cop::HighExecute`, the 202-instruction trigger scan, and every smaller
owner function.

Full board `sym_type_graph_board_p380_20260829.tsv` reports 400 `OK`, 17
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p378, exactly `aih_cop.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 994 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
