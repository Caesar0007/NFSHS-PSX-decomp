# ScreenTrophyRoom owner type-surface receipt

Date: 2026-08-28

Owner: `ScreenTrophyRoom.obj`
Source: `recon/frontend/common/screentrophyroom.cpp`
Pre-change backup: Git commit `1463fe30`

## Result

- Focused canonical type graph: `OK`.
- Named tags: 153/153 exact.
- Anonymous tags: 2/2 covered.
- Authoritative function matching: 9/9 PASS.
- Frontend/common board after this owner: 33 exact owners, 8 residual owners.

## Restored owner surface

`screentrophyroom_types.h` now exposes the owner-specific debug graph instead
of the full generic frontend graph.  It retains the shared ScreenMemcard base,
`AudioMus_tSongEntry`, full `tPlayer`/`tInputKeyType`, and the exact
`tMenuCommandType`/`tMenuCommand` boundary.  It excludes saved-game records,
FE3d types, and dialog types that are not present in `ScreenTrophyRoom.obj`.

The exact 344-byte `tScreenTrophyRoom` layout is declared with the retail field
order and offsets.  Its two incomplete foreign-owner views are represented as
source-only codegen carriers and pair-locked in the canonical audit:

- `ScreenTrophyRoom_GlobalMenuDefsCodegenView`: 636 bytes (`0x27c`), with
  `menuTrophyInfo` at offset `0x200`.
- `ScreenTrophyRoom_PadCodegenView`: 84 bytes, with `initialized` at 0,
  `buf[8]` at 4, and the remaining state bytes at 68.

The enum-bearing `FETextRender_MenuTextPositionedJustifyFade` declaration uses
its retail linkage label, preserving both the demangled source signature and
the exact call target.  `purgememadr` and `systemtask` retain explicit C linkage.

## SYM declaration proof

`frontend_common_strict_p283_20260828.md` reports:

- 779/779 mapped source definitions.
- 0 mangled source identifiers.
- 0 missing names, extra locals, type findings, or storage-class findings.
- 190/190 object-owned global definitions.
- 0 missing/extra globals, global type findings, or global storage findings.
- 0 functions needing mapping review.

## Binary and repository gates

- `screentrophyroom.cpp`: 9/9 PASS.
- `screencontroller.cpp`: 22/22 PASS.
- `screentournselect.cpp`: 9/9 PASS.
- `feapp.cpp`: 15/15 PASS.
- `screenmemcard.cpp`: 15/15 PASS.
- `fedialog.cpp`: 33/33 PASS.
- Call-target audit: 0 proven wrong-call-target sites.
- Relink, both lanes: GREEN; 0 real duplicates, 0 hidden phantoms, and 0
  relocation-referenced unresolved symbols.
- Undefined-call audit: 0 in both `recon` and `src` lanes.
- TU-order audit: 513 objects, 0 inversions.
- Vtable indexing audit: PASS across 1,430 files.
- Text-move audit: source-only policy PASS; no post-compiler rewrites.
- Full phantom audit: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  0 hidden phantoms, and 0 unmatched ownership gaps.

The optional `2.8.1-norcse` ladder rung was unavailable during the full census;
the audit explicitly fell back to each affected TU's configured compiler.  This
does not affect the zero-phantom/zero-gap ownership result or the focused PASS
gates above.
