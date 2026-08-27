# ScreenController.obj owner-type restoration receipt

## Result

- `recon/frontend/common/screencontroller.cpp`: 22/22 authoritative functions PASS.
- `ScreenController.obj`: 158/158 named type keys exact, 2/2 anonymous
  records covered, with zero missing, mismatched, or source-extra records.
- Shared-header regressions remain clean: ScreenTournSelect 9/9 PASS, FEApp
  15/15 PASS, ScreenMemcard 15/15 PASS, and FEDialog 33/33 PASS.
- Frontend/common owner-type board: 32 exact, 9 residual owners.

## Source-shape evidence

The owner header reuses the exact shared ScreenMemcard graph while excluding
memory-card, saved-game, and song-only records.  It retains the FE3d graph and
adds the retail `FLARE_PIECE_DEF`, `Force_tGlobal`, and exact 380-byte
`tScreenControllerConfig` records.  The owner retains `tMenuCommandType` and
`tInputKeyType`, but only an incomplete `tMenuCommand` reference and no foreign
`tPlayer` enum; the source surface now reproduces that boundary.

Three external aggregates are represented only by fields this owner reads:
the FE application input-player byte, the 84-byte pad state, and the controller
section of global menu definitions.  The latter preserves the retail offsets
from `itemControllerSettings` at 0x2b28 through `menuControllerNegcon` ending
at 0x3054.  The audit accepts these carriers only as exact tag/typedef pairs
with their complete sizes, member types, offsets, and source origin locked.

## Full-scope validation

- Strict declaration audit: 779/779 reconstructed definitions declaration-clean;
  190/190 object-owned globals mapped; zero declaration, type, storage, or
  mapping-review findings.
- Full phantom audit: 513/513 reconstruction TUs compiled, 3484/3484 declared
  oracle names exact, zero hidden phantoms, and zero unmatched ownership gaps.
- Relink and undefined-call gates: both lanes green, zero real duplicates,
  hidden phantoms, unresolved references, or undefined calls.
- Call-target audit: zero proven wrong-target calls.
- TU-order audit: 513 objects, zero inversions.
- Vtable-index audit: zero unsafe row indexing in 971 files.
- Text-move policy: source-only, with no post-compiler text moves or branch
  retargets.

The compiler ladder emitted the known warning that optional `2.8.1-norcse` is
unavailable; no owner changed in this checkpoint depends on that rung.
