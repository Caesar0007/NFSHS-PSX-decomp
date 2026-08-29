# `aih_btcperp.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `49f4fa1d`.

## Source graph restoration

`aih_btcperp_types.h` now composes the exact shared AI hierarchy and restores
the owner's 29-definition delta.  Relative to `aih_basiccop.obj`, the exact
graph removes `Trk_SFX` and `FLARE_PIECE_DEF`, adds `forceFocus_t`,
`AIHigh_BTC_HumanPerp`, and `AIHigh_BTC_AIPerp`, and otherwise retains the
shared animation, Speech, and pursuit definitions unchanged.

The function-local `PLACEMENTSPEED_SLOW` / `PLACEMENTSPEED_FAST` enum remains
inside `AIHigh_BTC_AIPerp::NewStage`, matching its retail anonymous definition.
The `perpMode_` member directly reuses the common anonymous PERPMODE enum type,
so neither reconstruction emits an invented named enum or an extra typedef.

Four foreign globals use exact member-shaped views.  `GameSetup` retains its
full 2600-byte extent, canonical `mirrorTrack` +44 / `reverseTrack` +48 pair,
and the ten 52-byte perpetrator records at +444.  The camera view retains the
272-byte row stride and the observed +128/+132 focus fields.  The constructed
`AIState_Cruise` and the vtable-bearing Speech dispatch carrier are likewise
locked by owner, complete layout, and implicit typedef identity.

## SYM and matching proof

Focused board `aih_btcperp_type_graph_p377_20260829.tsv`:

- named definitions: 137/137 exact;
- anonymous definitions: 11/11 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 26/26 PASS
for `recon/game/common/aih_btcperp.cpp`.  The proof includes the 363-instruction
AI-perp `NewStage`, 304-instruction `HighExecute`, and every vague-linkage
destructor/helper copy owned by this translation unit.

Full board `sym_type_graph_board_p378_20260829.tsv` reports 399 `OK`, 18
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p376, exactly `aih_btcperp.cpp` moved from `DIFF` to `OK`; no
owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 993 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
