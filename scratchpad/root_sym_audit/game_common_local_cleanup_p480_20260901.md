# P480: `DispatchSpeaker::Ready` inline-source closure

`DispatchSpeaker::Ready` is now expressed with its sole outer SYM local and
the inlined `Speaker` operations proven by the nested SLD scopes.

## Restoration

- restored `Wing` as the result of `Speech::Mobile(carObj)`;
- removed `pSVar1`, `pSVar3`, `pa_Var2`, `src_pos`, and `doSwap`;
- restored the inlined `HasDifferentSub(Wing)` predicate.  Its materialized
  boolean explains retail's `xor`/`sltu` sequence and the nested `this` scope;
- restored `SetBlockade(int Blockade)`, binding SYM's inner `Blockade` record
  to the real helper parameter;
- restored named `VirtualPerp` and `VirtualEngage` operations for vtable rows
  27 and 6.

Result: PASS 43/43.

The direct compound condition was rejected: it compiles to 40 instructions
and differs at five oracle rows because GCC branches directly instead of
materializing the inlined predicate result.  The helper form is therefore
both the SLD-consistent source shape and the exact binary match.

The names of fully inlined helpers remain explicit source-shape inferences;
their receivers, argument names, vtable rows, semantics, and generated code
are all independently proven, while separate linkage spellings are absent by
construction.

## Proof

- `tugate.py recon/game/common/speech.cpp`: PASS, 102/102.
- strict game/common audit: 1193/1193 functions mapped, 0 missing names,
  547/547 globals mapped, 115/115 vtables mapped.
- declaration-clean functions: 725 -> 726.
- unexplained extra source locals: 1661 -> 1656.
- restored inline-local mappings: 11 -> 12 (`Blockade` from `SetBlockade`).
- relink `recon`: GREEN, 757 objects, 0 real duplicates/unresolved.
- relink `src`: GREEN, 706 objects, 0 real duplicates/unresolved.
- data-only payload audit: PASS, 11/11 byte exact.
- `git diff --check`: no errors; line-ending notices only.
