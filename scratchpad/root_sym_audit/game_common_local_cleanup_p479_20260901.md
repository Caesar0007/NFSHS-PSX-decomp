# P479: `Speech::CheckCallSignBank` inline-source closure

The call-sign bank routine is now expressed with its exact outer SYM locals
and the three inlined bank mutations proven by the nested SLD blocks.

## Restoration

- restored `d` as the call-sign description base;
- restored `dispatchName` as the track-dependent dispatch-name index;
- retained the top-tested `i` loop required by retail;
- removed `pThis`, `lVar1`, `iVar2`, `iVar3`, `iVar4`, and `pSVar6`;
- restored inlined `CallSignBank::SetAllUnits`, `SetDispatch`, and `SetMobile`;
  their `this`, `bankid`, and `unit` arguments account for the three nested SLD
  setter scopes without fake caller locals;
- nested `strlen`/`strncmp` expressions compile to the same call and result
  sequence as the temporary-heavy decompilation.

Result: PASS 78/78.

The setter spellings are explicit source-shape inferences.  SYM retains their
inline receivers/argument names and raw assembly proves each store, but no
separate linkage name survives for a fully inlined member.

## Proof

- `tugate.py recon/game/common/speech.cpp`: PASS, 102/102.
- strict game/common audit: 1193/1193 functions mapped, 0 missing names,
  547/547 globals mapped, 115/115 vtables mapped.
- declaration-clean functions: 724 -> 725.
- unexplained extra source locals: 1667 -> 1661.
- restored inline-local mappings: 9 -> 11 (`bankid`/`unit` from `SetMobile`).
- relink `recon`: GREEN, 757 objects, 0 real duplicates/unresolved.
- relink `src`: GREEN, 706 objects, 0 real duplicates/unresolved.
- data-only payload audit: PASS, 11/11 byte exact.
- `git diff --check`: no errors; line-ending notices only.
