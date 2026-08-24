# `DrawController` inlined `range` restoration — 2026-08-24

## Evidence

The trusted SLD/SYM stream places the final controller-axis calculation in a
source block beginning at retail VA `0x80044994`.  Nested line-1 blocks record
exactly `player` as `REG INT` and `range` as `REG SHORT`; both nested blocks end
before the enclosing source block ends at `0x80044a5c`.  `range` is therefore
not a flat `DrawController` function-scope `int`: it belongs to an inlined
helper whose result is promoted in the caller.

The helper's source identifier is not retained by this SYM record.  The
reconstruction uses the descriptive name `ControllerTwistRange`; its local and
parameter spellings/types are the recoverable evidence.

## Correction

`screencontroller.cpp` now expresses the retail boundary as a `static inline
short ControllerTwistRange(int player)` with lexical `short range`.  The caller
stores the promoted result in a separate `int rangeValue` code-generation
carrier.  This removes the old `SYM-TYPE-OVERRIDE` disposition: spelling the
caller carrier itself `short` was the wrong scope and generated a 55-difference
837/836 body.

The read-only SYM audit now supports the narrow annotation
`SYM-INLINE-LOCAL: local = Helper`.  It accepts the mapping only when ctags
finds exactly one same-TU helper that really declares the named local, so the
annotation cannot hide a missing declaration or an arbitrary type conflict.

## Receipts

- `DrawController__23tScreenControllerConfig`: PASS, 836/836 instructions.
- strict frontend/common audit: zero missing SYM names, zero type findings,
  zero function-storage findings; one restored inline-local mapping and only
  one remaining function type override (`DrawCurrCredit::y`).
- frontend/common bulk gate: 835/838 PASS, zero compile failures; the same two
  2-difference residuals and one pre-existing far constructor remain.
- vtable indexing audit: PASS across 926 files.
- relink, both lanes: GREEN, with zero genuine relocation-referenced unresolved
  names, zero real duplicate owners, and zero hidden phantoms.
- complete production build: final link succeeds with no undefined references;
  the independent image-layout metric remains 21.14%, first difference `0x878`,
  size delta `-32`.
