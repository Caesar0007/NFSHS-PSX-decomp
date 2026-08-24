# `Fe3D_InitShowroom` short-index restoration — 2026-08-24

## Reliable evidence

Trusted SYM records only these retail locals:

- outer `REG INT i` in `$s2` and `REG LONG angle` in `$s1`;
- nested line-15 `REG SHORT iPlus` in `$s3`;
- nested line-25 `REG LONG angle_sin` in `$s0` and `REG LONG angle_cos` in
  `$v0`.

Retail assembly begins each second-loop iteration with `sll $v1,$s3,16`, then
computes `$a1 = $s3 + 1`, copies the old shifted value to `$a2`, and commits
`$s3 = $a1 + 1`.  The old first-vertex index is sign-extended separately for
the `.x/.y` address and the rematerialized `.z` address; `$a1` is later
sign-extended for the second vertex.

## Source correction

The previous exact form manufactured that lifetime using `short sVar4`,
`int sh`, integer-typed `iPlus`, and an identity asm fence.  Simply changing the
local to short while retaining three ordinary stores produced 8 differences at
101/107 instructions because GCC reused the `.x/.y` address for `.z`.

The source now uses the sole SYM local directly:

```cpp
Fe3D_lightsVertex[iPlus].x = ...;
Fe3D_lightsVertex[iPlus].y = 0;
Fe3D_lightsVertex[iPlus++].z = ...;
Fe3D_lightsVertex[iPlus].x = ...;
Fe3D_lightsVertex[iPlus].y = 0;
Fe3D_lightsVertex[iPlus++].z = ...;
```

Each post-increment makes the old short index survive the update, so GCC emits
the retail copy, two sign extensions, rematerialized address, and early
`iPlus + 2` update without any fence or fabricated index carrier.

## Verification

- `verify_asm.py`: PASS, 107/107 instructions.
- `vdiff.py`: `[ours=107 oracle=107]`, no differences.
- Strict game/PSX audit: 395/395 declaration-clean, zero missing names, zero
  extra locals, zero type findings; explicit function-type overrides 5 -> 4.
- Full game/PSX gate: 395 functions, 385 PASS, zero compile failures, with the
  same ten pre-existing residuals.
- Both relink lanes: GREEN; real duplicates 0, hidden phantoms 0, genuine
  relocation-referenced unresolved names 0.
- Vtable indexing audit: PASS across 926 files.
- Full production build: final link succeeds; output remains 1,239,008 bytes
  versus retail 1,239,040 bytes, retaining the independent legacy `-32`
  section-layout delta.
