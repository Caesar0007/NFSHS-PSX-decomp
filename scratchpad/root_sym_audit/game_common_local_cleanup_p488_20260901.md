# P488: compact return/interpolation SYM cleanup

This round removes six decompiler-only temporaries from four compact source
families and resolves one additional generic review item with measured oracle
evidence.

## Exact source restorations

- `Quatern_VecInterpolate` and `Quatern_Interpolate`: write the fixed-point
  interpolation expressions directly, removing the unrecorded `iVar1` local
  from each empty retail SYM scope.
- `__builtin_new` and `__builtin_vec_new`: return `reservememadr` directly,
  removing the unrecorded `pvVar1` local from both runtime wrappers.
- `SimpleMem::FeignAlloc`: return `Alloc(len, 1)` directly, removing `pvVar1`.
- `BWAllocMem`: retain the SYM-recorded function-static `totalMem` and return
  `Platform_GetDCTBuffer` directly, removing `pcVar1`.

All six changes are ordinary C/C++ source shapes and remain byte-exact.

## Measured retained carrier

`Anim_FreeHandle` records only parameter `handle` in SYM.  Removing
`deleteMe` and repeating `animSlots[handle]` produced 33 instructions and 19
oracle diffs; the retained pointer gives the exact 32-instruction retail body
and its saved-register/base-address schedule.  The declaration now has an
explicit `SYM-CODEGEN-CARRIER` receipt rather than remaining a generic review
item.

## Audit movement and proof

- Strict audit P487 -> P488: declaration-clean functions 791 -> 798;
  unexplained extras 1509 -> 1502; missing names remain 0.
- Explicit measured codegen carriers: 117 -> 118.
- Function type/storage findings remain 0; globals remain 547/547 and vtables
  remain 115/115.
- Exact instruction checks:
  - quaternion interpolation: 44/44 and 66/66;
  - allocation wrappers: 10/10, 10/10, 8/8, and 12/12;
  - `Anim_FreeHandle`: 32/32.
- TU gates: `mathnfs` 10/10, `quatern` 4/4, `new` 4/4, `simplemem` 3/3,
  `bworld` 21/21, and `anim` 18/18 PASS.
- Branch-distance gates: zero divergences in all six TUs.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: no errors (repository line-ending warnings only).

No commit or push was performed.
