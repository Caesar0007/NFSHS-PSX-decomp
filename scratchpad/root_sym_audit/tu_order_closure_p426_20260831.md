# Translation-unit text-order closure

Date: 2026-08-31

## Recovered source fact

Retail function VAs prove the definition order within each owning translation
unit. Nine reconstructed bodies were emitted after higher-VA functions even
though every individual body was byte-exact. Their unchanged definitions are
now placed in retail order:

- `spchevnt.c`: `VoxEvent_GetKeepTillExpiresFlag` between the two shared-helper
  static copies;
- `physics.cpp`: `Physics_CheckGamedata` before
  `Physics_AttenuateVelocity`;
- `hud.cpp`: `Hud_DebugCrap` before `Hud_BuildSprite`, `Hud_BuildF4o` before
  `Hud_FBuildGT4`, and `uppercase` before `Hud_Kill`;
- `weather.cpp`: `Weather_GetNumParticles` before `Weather_SetMatrix`;
- `INTR_DMA.c`: `startIntrDMA`, `_dma_isr`, `setIntrDMA`, then the local
  `_bzero_w` helper.

No function body, statement, declaration type, compiler flag, or post-compile
instruction was changed to obtain this order.

## Audit correctness

Natural exported speech names are co-equal with address-suffixed oracle aliases
at one text offset. The old TU-order and call-target audits incorrectly treated
the natural name's first config VA as this exported copy. Both audit tools now
resolve such a group only when exactly one co-equal alias suffix encodes its
configured retail VA. Ambiguous groups are counted and excluded rather than
guessed. The call-target audit now also returns failure when it finds a proven
wrong target. The pre-change tools are recoverable as documented in
`tu_order_audit_backup_p426_20260831.md`.

## Matching proof

All moved boundaries remain detailed PASS:

- speech: 5 and 34 instructions;
- physics: 2 and 279 instructions;
- HUD: 2, 43, 53, 35, 24, and 20 instructions;
- weather: 4 and 49 instructions;
- `INTR_DMA`: 19, 96, 43, and 9 instructions.

The authoritative TU-order audit now covers 521 objects with zero inversions,
resolves two co-equal alias groups, and excludes zero ambiguous groups.

Whole-tree regressions remain clean:

- call-target audit: 466 units, zero proven wrong targets; 14 co-equal
  definition aliases resolved, zero ambiguous;
- undefined-call audit: 15,781 call relocations, zero undefined;
- both relink lanes GREEN with zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- phantom audit: 518/518 TUs compile, all 3,491 oracle names exactly owned,
  zero hidden phantoms and zero ownership gaps;
- source-only text-move and unsafe-vtable-indexing audits PASS.

Durable relink evidence:
`tu_order_closure_relink_p426_20260831.json`.
