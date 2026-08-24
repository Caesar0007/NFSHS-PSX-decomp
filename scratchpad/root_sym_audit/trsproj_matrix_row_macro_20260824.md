# `TrsProj_SetPsxMatrix` macro-local restoration — 2026-08-24

## Reliable evidence

Trusted SYM function `TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef` begins at
`0x800e1a5c`, has a 56-byte frame, and records top-level parameters `m` and `t`
plus `AUTO MATRIX mpsx`.  Inside the function it records three distinct nested
line-1 blocks.  Every block declares `REG INT r0`, `REG INT r1`, and `REG INT
r2`; the first two assign them to `$v0/$v1/$a1`, while the third assigns
`r2` to `$a0`.  The three block boundaries all share the function-start SLD
address, which is the characteristic debug shape of three macro expansions.

The retail instruction stream independently consists of three repeated groups:
load three `matrixtdef` elements, arithmetic-shift each integer by four, then
store three halfwords into one consecutive `MATRIX` row.  The per-function m2c
body at `C:/Temp/nfs4-psx/nfs4-psx-m2c/functions/FUN_800e1a5c.c` corroborates
the data flow but not the lexical macro boundary.

## Source correction

The previous exact reconstruction used one flat set of `short r0/r1/r2`
locals.  Although byte-matched, that source contradicted all nine repeated SYM
local records and required a `SYM-TYPE-OVERRIDE` disposition.

`recon/game/psx/trsproj.cpp` now defines `TRSPROJ_SET_MATRIX_ROW` with lexical
`int r0`, `int r1`, and `int r2`, and invokes it three times for the three
matrix rows.  The exact macro identifier is descriptive because neither SYM nor
the retail binary retains preprocessor names; the repeated expansion shape,
local names/types, invocation count, and emitted operations are evidence-backed.

The strict audit's `SYM-MACRO-LOCALS` receipt is deliberately validation-based:
it accepts a mapping only when the named macro exists in the same TU, literally
declares every named local, and is called exactly the recorded number of times
inside the audited function.  It does not create a blanket missing-name
exception.

## Verification

- `verify_asm.py`: `TrsProj_SetPsxMatrix` PASS, 60/60 instructions.
- `vdiff.py`: `[ours=60 oracle=60]`, no differences.
- Strict game/PSX SYM audit:
  - 395/395 functions mapped and declaration-clean;
  - missing SYM names 0;
  - extra source locals 0;
  - type findings 0;
  - restored macro-local mappings: `r0`, `r1`, `r2` from three expansions.
- `bulkverify.py recon/game/psx`: 395 functions, 385 PASS, 0 compile failures;
  the same ten pre-existing residuals remain.
- `relink.py --lane both -v`: GREEN; real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved names 0.
- `audit_vtable_indexing.py`: PASS across 926 files.
- `build.py`: final link succeeds; output remains 1,239,008 bytes versus the
  1,239,040-byte retail image, with the independent legacy `-32` layout delta.
