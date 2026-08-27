# ScreenTournSelect.obj owner-type restoration receipt

## Result

- `recon/frontend/common/screentournselect.cpp`: 9/9 authoritative functions PASS.
- `ScreenTournSelect.obj`: 155/155 named type keys exact, 2/2 anonymous
  records covered, with zero missing, mismatched, or source-extra records.
- Shared-header regressions remain clean: FEApp 15/15 PASS, ScreenMemcard
  15/15 PASS, and FEDialog 33/33 PASS.
- Frontend/common owner-type board: 31 exact, 10 residual owners.

## Source-shape evidence

The restored header uses the exact ScreenMemcard shared graph while excluding
that owner's memory-card, saved-game, audio-song, and FE3d-only records.  It
adds the retail tournament-standings records and the exact 712-byte
`tScreenTournSelect` layout.  Foreign enum tags absent from this owner remain
source constants at the call sites, with explicit retail linkage names at the
extern boundary.

`tGlobalMenuDefs` is owned by FEMenuDefs.obj and has no completed tag in this
owner.  The source therefore uses an exact 0x7a0-byte view exposing only
`iteratorTournament` at 0x6a8 and `iteratorSpecialEvent` at 0x78c.  The audit
accepts this carrier only when its full tag/typedef pair, member graph, size,
offsets, and source origin all match.

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
- Vtable-index audit: zero unsafe row indexing in 970 files.
- Text-move policy: source-only, with no post-compiler text moves or branch
  retargets.

The compiler ladder emitted the known warning that optional `2.8.1-norcse` is
unavailable; no owner changed in this checkpoint depends on that rung.
