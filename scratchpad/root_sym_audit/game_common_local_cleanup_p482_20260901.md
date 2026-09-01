# P482: `MobileSpeaker::Catch` inline-source closure

`MobileSpeaker::Catch` is now expressed through the source-level `Speaker`
operations represented by its dense nested SLD scopes rather than raw vtable
and event-argument temporaries.

## Restoration

- replaced every raw vtable row 27 call with `VirtualPerp()`;
- replaced both raw row 30 calls with `VirtualCallSign()`;
- restored trivial `Location()`, `Distance()`, and `Colour()` field accessors;
- replaced dispatch row 19 with `VirtualClearPerp(Car_tObj*)`.  The recovered
  `DispatchSpeaker` vtable independently identifies row 19 as
  `ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj`;
- removed `pa_Var1`, `iVar2`, `distance`, `colour`, `dispatchThis`, and
  `dispatchVf`;
- consumed the SLD `carObj` debug quantity directly from `fCarObj`, with an
  explicit optimized-quantity receipt.  Materializing it as a C++ local (or
  routing it through a member setter) reverses the retail RHS/LHS load order
  and produces six diffs;
- retained the existing `Arrest` optimized receipt: retail reuses incoming
  `ticket` in `$s0` for the inlined arrest-phrase operation.

The helper spellings for fully inlined accessors remain source-shape
inferences.  Their receivers, vtable rows, fields, call counts, semantics, and
generated instructions are proven; no standalone linkage spelling survives.

Result: PASS 175/175.

## SLD inline scopes

Thirteen concrete `SYM-INLINE-THIS` receipts now account for the visible
`Speaker *this` expansions in the two large line-14/27 inline regions:

- `VirtualPerp` x6;
- `VirtualCallSign` x2;
- `Location` x2;
- `Distance` x1;
- `Colour` x1;
- `VirtualClearPerp` x1.

## Audit movement

- declaration-clean functions: 728 -> 729;
- unexplained extra source locals: 1648 -> 1642;
- restored inline-local mappings: 15 -> 28;
- missing SYM names: 0;
- function/type/storage findings: 0.

## Proof

- `tools/verify_asm.py`: `Catch` PASS 175/175.
- `tools/tugate.py recon/game/common/speech.cpp`: 102/102 PASS.
- `tools/brdist.py recon/game/common/speech.cpp`: 102 functions checked, 0
  branch-offset/count divergences.
- strict game/common audit: 1193/1193 functions mapped, 547/547 globals,
  115/115 vtables, 0 missing names.
