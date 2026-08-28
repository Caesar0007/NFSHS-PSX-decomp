# ScreenPost owner type-surface receipt

Date: 2026-08-28

Owner: `ScreenPost.obj`
Source: `recon/frontend/common/screenpost.cpp`
Pre-change backup: Git commit `b49bf64f`

## Result

- Focused canonical type graph: `OK`.
- Unique named tags: 156/156 exact.
- Anonymous tags: 2/2 covered.
- Authoritative function matching: 12/13 PASS, preserving the pre-change
  baseline exactly.
- The sole residual remains three instructions in
  `DrawBackground__26tScreenTournamentStandings` (562 ours / 561 retail): one
  redundant tournament-manager address copy and its dependent load register.
- Frontend/common board after this owner: 38 exact owners, 3 residual owners.

## Restored owner surface

`screenpost_types.h` now emits only the records attributed to ScreenPost by the
retail SYM.  It reuses the exact ScreenTournSelect shared graph, restores the
owner's `tPlayer`, `tMenuCommand`, `tMenuTextState`, `tMenuTextType`, and
`tScreenPinkSlipStandings` records, and suppresses foreign memory-card dialog,
stream, trophy, and ScreenTournSelect owner records.

The public `tSaveRecords[187]` typedef is retained through the exact 20-byte
`tRecordBuffer` element definition required by CC1PL; the linked SYM attributes
that already-seen completed element body elsewhere.  The reconstruction's
eight-byte `__nfs4_vtbl_ptr_t` is pair-locked as a compiler-boundary carrier
for GCC's unavailable built-in C++ vtable-entry type.  Any field, type, size,
or source-owner drift in either carrier remains visible to the audit.

The private PsyQ `_physadr` referent is now incomplete only on this owner
surface, matching ScreenPost's retained public pointer typedef without
inventing a completed tag.  The former catch-all extern header was reduced to
the globals and calls actually referenced by this translation unit.

## Proof gates

- Strict source audit: 779/779 functions and 190/190 globals mapped; zero
  name, local, type, storage, or review findings.
- `screenpost.cpp`: 12/13 PASS; the single FAIL remains exactly 3 diffs.
- Shared neighbors: `screentournselect.cpp` 9/9,
  `screenpinkslips.cpp` 8/8, `screentracks.cpp` 10/10, and
  `screenmemcard.cpp` 15/15 PASS.
- Call-target audit: 0 proven wrong targets.
- Relink both lanes: GREEN; 0 real duplicates, hidden phantoms, or unresolved
  relocation references.
- Undefined-call audit: 0 in both lanes.
- TU order: 513 objects, 0 inversions.
- Vtable audit: PASS across 977 source files.
- Source-only text-move policy: PASS.
- Full phantom audit: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  0 hidden phantoms, and 0 unmatched ownership gaps.

The generated focused graph is `screenpost_type_graph_p288_20260828.tsv`; the
regenerated whole-cluster graph and strict audit are
`frontend_common_type_graph_p288_20260828.tsv` and
`frontend_common_strict_p288_20260828.md`.

The optional `2.8.1-norcse` rung was unavailable during the phantom census, so
affected TUs used their configured compiler fallback; the focused ScreenPost
matching result and zero-phantom/zero-gap ownership proof are unaffected.
