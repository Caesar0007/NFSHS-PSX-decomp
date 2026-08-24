# `Sky_InitStars` brightness type restoration — 2026-08-24

## Evidence and correction

Trusted SYM records `starBright` as `REG INT` in the loop's nested line-11
block, with retail home `$a0`.  The exact reconstruction instead declared it
as `u_int` because a bare signed remainder generated `div` and GCC's signed
INT_MIN/-1 guard, while retail uses `divu`.

That codegen observation does not require an unsigned local.  The source now
keeps `int starBright` and spells the constrained operation as:

```cpp
starBright = Sky_gTrackSpec->starBrightMin +
             (u_int)starBright %
             (Sky_gTrackSpec->starBrightMax - Sky_gTrackSpec->starBrightMin);
```

The cast expresses unsigned remainder semantics at the operation where the
retail ISA proves them.  GCC emits the same `divu` sequence while the lexical
local now agrees with SYM.

## Verification

- `verify_asm.py`: PASS, 122/122 instructions.
- `vdiff.py`: `[ours=122 oracle=122]`, no differences.
- Strict game/PSX audit: 395/395 declaration-clean, zero missing names, zero
  extra locals, zero type findings; explicit function-type overrides 6 -> 5.
- Full game/PSX gate: 395 functions, 385 PASS, zero compile failures, with the
  same ten pre-existing residuals.
- Both relink lanes: GREEN; real duplicates 0, hidden phantoms 0, genuine
  relocation-referenced unresolved names 0.
- Vtable indexing audit: PASS across 926 files.
- Full production build: final link succeeds; output remains 1,239,008 bytes
  versus retail 1,239,040 bytes, retaining the independent legacy `-32`
  section-layout delta.
