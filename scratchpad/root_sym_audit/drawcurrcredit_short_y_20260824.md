# `DrawCurrCredit` `SHORT y` restoration — 2026-08-24

## Evidence

The trusted function record for `DrawCurrCredit__14tCreditManager` identifies
top-level `y` as `REG SHORT` in register `$s3`.  Retail loads its initial value
with `lhu $s3,0xe($s1)`, passes it through the signed `sll`/`sra` argument idiom,
and advances the same register throughout the text loop.

The previous exact reconstruction declared `uint y` because changing that one
token to `short` exposed eight instruction-order differences in the
`rollthedice` loop.  The mismatch was not a compiler floor.  The source had
three duplicated branch-local final `y += 8` statements.  Retail control flow
instead proves one common statement after the jaguar/rollthedice/normal join:
GCC tail-duplicates it into the jaguar and rollthedice jump delay slots and
emits it directly on the normal path.

## Correction

- restore `short y` exactly as recorded by SYM;
- express the 25-line `rollthedice` body as the nested `for (int rtd ...)`
  scope indicated by SLD block records;
- replace the three branch-local final increments with one post-join
  `y += 8`;
- replace fabricated `textY` and `nextY` locals with the direct field test and
  unsigned source load that emit retail's distinct `lh` and `lhu` operations.

No asm, volatile declaration, compiler modification, or post-build rewrite is
used by this correction.

## Receipts

- `DrawCurrCredit__14tCreditManager`: PASS, 451/451 instructions.
- strict frontend/common audit: zero missing SYM names, zero type findings,
  zero function-storage findings, zero function type overrides, and zero
  mapping-review functions.
- frontend/common bulk gate: 835/838 PASS with zero compile failures; the same
  two 2-difference residuals and one pre-existing far constructor remain.
- relink, both lanes: GREEN, with zero genuine relocation-referenced unresolved
  names, zero real duplicate owners, and zero hidden phantoms.
- vtable indexing audit: PASS across 926 files.
- complete production build: every TU compiles and the final link succeeds;
  the independent image-layout metric remains 21.14%, first difference `0x878`,
  size delta `-32`.
