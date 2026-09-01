# P476: `speech.cpp` constructor/reset/dispatch closure

This round reconstructs four more functions from their exact SYM blocks and
named class layout while preserving the complete translation-unit oracle.

## Restored functions

- `DispatchSpeaker::Grant`: removed `pSVar1`, `vs_RDBLK_SSTRP`, and `CONFIRM`;
  the two source guards and speech macro now use the actual `fSub`, `fBlockade`,
  and `fConfirm` expressions.  PASS 25/25.
- `DispatchSpeaker::Activate`: restored the sole SYM local `i`, the descending
  `fPerp` loop, named `Speaker`/`DispatchSpeaker` fields, and a source-level
  virtual CallSign operation.  PASS 39/39.
- `Speech::Reset`: removed the raw `iVar5` pointer walker and the `speech` and
  `dispatch` aliases.  The explicit-break loop over `fMobile[i]->fCarObj` is
  the source shape that preserves retail's pre-test branch.  PASS 103/103.
- `Speech::Speech`: removed the non-SYM sample-rate local by nesting
  `SPCH_GetSampleDataRate` in `SPCH_Init`.  PASS 232/232.

## Measured carrier evidence

- `DispatchSpeaker::Activate::iVar1`: retaining the inlined virtual CallSign
  result and reusing it for `GameSetup.track` is required by the recovered
  explicit-vtable model.  Direct chaining grows 39 to 43 instructions and
  changes 60 instructions.
- `Speech::Speech::dispatch`: the explicit allocation-result carrier models
  the implicit object construction.  Re-reading `fDispatch` adds two
  instructions and changes 14.
- `Speech::Speech::mobile`: the analogous per-iteration allocation result is
  required; re-reading `fMobile[i]` adds four instructions and changes 28.

Each retained carrier now has an in-source `SYM-CODEGEN-CARRIER` receipt.
No generic disposition was substituted for the failed experiment.

## Proof

- `tugate.py recon/game/common/speech.cpp`: PASS, 102/102.
- strict game/common audit: 1193/1193 functions mapped, 0 missing names,
  547/547 globals mapped, 115/115 vtables mapped.
- declaration-clean functions: 715 -> 719.
- unexplained extra source locals: 1706 -> 1694.
- relink `recon`: GREEN, 757 objects, 0 real duplicates/unresolved.
- relink `src`: GREEN, 706 objects, 0 real duplicates/unresolved.
- data-only payload audit: PASS, 11/11 byte exact.
- `git diff --check`: no errors; line-ending notices only.

The attempted direct-field rewrite of `LocationBank::Distance` was rejected:
it added two instructions and changed 26.  Its exact 37-instruction baseline
was restored; its four unresolved locals remain in the review queue for a
future full source-shape reconstruction.
