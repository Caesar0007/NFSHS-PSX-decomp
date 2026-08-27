# ScreenTrackRecords owner type-surface receipt

Date: 2026-08-28

Owner: `ScreenTrackRecords.obj`
Source: `recon/frontend/common/screentrackrecords.cpp`
Pre-change backup: Git commit `bd2ee079`

## Result

- Focused canonical type graph: `OK`.
- Named tags: 155/155 exact.
- Anonymous tags: 2/2 covered.
- Authoritative function matching: 7/7 PASS.
- Frontend/common board after this owner: 34 exact owners, 7 residual owners.

## Restored owner surface

`screentrackrecords_types.h` now replaces the generic project-wide type graph
with the exact owner surface.  It retains the shared rendering/frontend and
FE3d graph, the four-byte `tMenuTextState` enum, `FLARE_PIECE_DEF`, and the
owner's 116-byte `tScreenTrackRecords` class.  It excludes input/player and
`tMenuTextType` enum tags, audio-song data, dialogs, memory-card owner records,
and saved-game structures that are absent from this object.

The source order follows the SYM evidence: `tScreenTrackRecords` first refers
to incomplete `tRecordBuffer`, then the 20-byte record is completed and the
`tSaveRecords[187]` typedef is emitted.  The enum-less source use of
`tMenuTextType` remains an integer spelling, while the external
`FETextRender_FullText` declaration carries its exact retail linkage name.

## SYM declaration proof

`frontend_common_strict_p284_20260828.md` reports:

- 779/779 mapped source definitions.
- 0 mangled source identifiers.
- 0 missing names, extra locals, type findings, or storage-class findings.
- 190/190 object-owned global definitions.
- 0 missing/extra globals, global type findings, or global storage findings.
- 0 functions needing mapping review.

## Binary and repository gates

- `screentrackrecords.cpp`: 7/7 PASS.
- Shared-surface neighbors: `screenmemcard.cpp` 15/15,
  `screentrophyroom.cpp` 9/9, `screencontroller.cpp` 22/22,
  `screentournselect.cpp` 9/9, `feapp.cpp` 15/15, and `fedialog.cpp` 33/33 PASS.
- Call-target audit: 0 proven wrong-call-target sites.
- Relink, both lanes: GREEN; 0 real duplicates, 0 hidden phantoms, and 0
  relocation-referenced unresolved symbols.
- Undefined-call audit: 0 in both `recon` and `src` lanes.
- TU-order audit: 513 objects, 0 inversions.
- Vtable indexing audit: PASS across 1,431 files.
- Text-move audit: source-only policy PASS; no post-compiler rewrites.
- Full phantom audit: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  0 hidden phantoms, and 0 unmatched ownership gaps.

The optional `2.8.1-norcse` ladder rung was unavailable during the full census;
the audit explicitly fell back to each affected TU's configured compiler.  This
does not affect the zero-phantom/zero-gap ownership result or the focused PASS
gates above.
