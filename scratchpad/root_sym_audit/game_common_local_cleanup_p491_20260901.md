# P491: `audiomus.cpp` one-extra family closure

All eight one-extra-local findings in `audiomus.cpp` are now resolved.

## Exact source restorations

- `AudioMus_GetCurrentSong`: assign the error/request conditional expression
  directly to `curr->index`, removing `iVar2`.
- `AudioMus_InitGlobals`: write all fields through `AudioMus_g` directly,
  removing `pAVar1`.
- `AudioMus_InitDriverGlobals`: retain the SYM-recorded `info` subobject pointer
  but write the music-global fields directly, removing `pAVar1`.
- `AudioMus_StopSong`: write the zero-fade fields through `AudioMus_g` directly,
  removing `pAVar1` even across the optional purge call.
- `AudioMus_BuildPlayList`: use the SYM-recorded loop local `i` instead of the
  duplicate decompiler counter `iVar1`.

## Measured retained carriers

- `AudioMus_Threshold::music`: direct global expressions compile to 35
  instructions and four oracle diffs; the cached pointer gives retail's exact
  33-instruction `$a0` lifetime and backward threshold-return branch.
- `AudioMus_SetEntry::iVar3`: reusing `titlechar` as the buffer index and
  reading `*p` directly produces 36 instructions and 28 oracle diffs.  The
  separate index/current-character values preserve the exact 34-instruction
  rotated parser loop.
- `AudioMus_PlaySong::pick`: the existing modulo-result join value is required
  for one shared divmod block and the retail delay-slot copy into `newsong`;
  its detailed sealed experiment is now recognized by an explicit
  `SYM-CODEGEN-CARRIER` receipt.

## Proof

- `tools/tugate.py recon/game/common/audiomus.cpp`: 23/23 PASS.
- `tools/brdist.py recon/game/common/audiomus.cpp`: 23 functions, zero branch
  distance/count divergences.
- Strict P490 -> P491: declaration-clean functions 811 -> 819; unexplained
  extras 1489 -> 1481; missing names remain 0.
- Explicit codegen carriers: 121 -> 124.
- Type/storage findings remain 0; globals remain 547/547 and vtables remain
  115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: no errors (repository line-ending warning only).

No commit or push was performed.
