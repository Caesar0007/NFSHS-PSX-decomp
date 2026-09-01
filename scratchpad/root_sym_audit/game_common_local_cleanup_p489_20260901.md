# P489: `track.cpp` compact-source restoration

Four generic extra-local findings in `track.cpp` were replaced with the source
shapes supported by the retail SYM scopes while retaining exact output:

- `AllocArtResource`: assign the `BWAllocMem` result directly to `artRes->pPmx`
  instead of routing it through `pDVar1`.
- `KillFile_OpenRead`: pass `Track_MakeTrackPathName(".kil")` directly to
  `sprintf` and return `loadfileadrz` directly, removing `pcVar1`.
- `Track_GetProperMultiPalShapeIndex`: restore an indexed `for` loop over
  `gTempMultiPalInfo[t]`, matching the sole SYM local `t` and removing the
  decompiler pointer walker `pTVar1`.
- `LoadShapesAndMakePmx_EnvMap`: pass literal `-1` arguments directly, removing
  the unrecorded `negOne` temporary.

`Track_DeInit` was also resolved from the generic queue.  A direct-global
spelling without `deleteMe` produced 50 instructions and 15 oracle diffs.  The
retained cached pointer gives the exact 53-instruction saved-register lifetime
across `purgememadr` and `__builtin_delete`, so it now carries an explicit
measured `SYM-CODEGEN-CARRIER` receipt.

## Proof

- `tools/tugate.py recon/game/common/track.cpp`: 29/29 PASS.
- `tools/brdist.py recon/game/common/track.cpp`: 29 functions, zero branch
  distance/count divergences.
- Strict P488 -> P489: declaration-clean functions 798 -> 803; unexplained
  extras 1502 -> 1497; missing names remain 0.
- Explicit codegen carriers: 118 -> 119.
- Function type/storage findings remain 0; globals remain 547/547 and vtables
  remain 115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, 11/11 members byte exact.
- `git diff --check`: no errors (repository line-ending warning only).

No commit or push was performed.
