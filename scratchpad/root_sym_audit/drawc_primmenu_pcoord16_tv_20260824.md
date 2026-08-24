# `DrawC_PrimMenu` PCOORD16 cache walker restoration — 2026-08-24

## Reliable evidence

The trusted SYM records `PCOORD16 *tV` in the second vertex-loop block of
`DrawC_PrimMenu`.  `PCOORD16` is the eight-byte debug type
`{ short x, y, z, p; }`.  The retail loop advances this pointer by eight bytes;
the first cache loop stores texture bytes at offsets 6 and 7, while the second
loop stores transformed coordinates at offsets 0, 2, and 4.

The previous exact source described the same storage with the reconstruction
type `Draw_CarVertex *` and carried an explicit SYM type override.  That was a
layout-compatible code-generation explanation, but it did not reproduce the
type graph recorded by the debug data.

## Source correction

Both cache walkers are now declared as `PCOORD16 *tV` and initialized from
`sd->tV` with an explicit layout cast.  The coordinate loop writes `x`, `y`,
and `z` directly.  The texture loop addresses the two bytes of the `p` halfword
through `char *`, preserving the retail byte stores without inventing an
alternate lexical structure type.

The eight-byte typed stride still lets GCC eliminate the loop induction
variable and place the preheader giv exactly as retail.  The former
`SYM-TYPE-OVERRIDE: tV` is therefore removed.

## Verification

- `verify_asm.py`: PASS, 480/480 instructions.
- `vdiff.py`: `[ours=480 oracle=480]`, no differences.
- Strict game/PSX audit: 395/395 declaration-clean, zero missing names, zero
  extra locals, zero type findings; explicit function-type overrides 4 -> 3.
- Full game/PSX gate: 395 functions, 385 PASS, zero compile failures, with the
  same ten pre-existing residuals.
- Both relink lanes: GREEN; real duplicates 0, hidden phantoms 0, genuine
  relocation-referenced unresolved names 0.
- Vtable indexing audit: PASS across 926 files.
- Full production build: final link succeeds; output remains 1,239,008 bytes
  versus retail 1,239,040 bytes, retaining the independent legacy `-32`
  section-layout delta.
