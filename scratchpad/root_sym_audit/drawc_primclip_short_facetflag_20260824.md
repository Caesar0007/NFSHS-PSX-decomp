# `DrawC_PrimClip` short `facetFlag` restoration — 2026-08-24

## Reliable evidence

The trusted SLD/SYM opens two repeated case-local blocks in
`DrawC_PrimClip`, at retail addresses `0x800C25D0` (source line 449) and
`0x800C2AB4` (source line 609).  Each records `short facetFlag`; the first is
annotated in `$t2` and the second in `$t8`.  `Transformer_zFacet::flag` is
also a signed 16-bit field.

The previous byte-exact reconstruction declared both locals as `int` because
a direct `short facetFlag; facetFlag = facet->flag;` makes GCC 2.8.1 reload
the HImode value twice: `lh` for the sign test and `lhu` for the low-bit masks.
That direct correction measured FAIL 15 at 1878/1877 instructions at either
site.  Retail instead has one `lh`, keeps its sign-extended value in an
integer-mode pseudo, and derives both masks from it.

## Source correction

Both lexical declarations are restored to `short facetFlag`.  The assignment
result is immediately promoted into an explicit source-only `int facetValue`
carrier:

```cpp
facetValue = (facetFlag = facet->flag);
```

The sign test and the two masks consume `facetValue`.  This expresses the
ordinary integer promotion directly, retains the reliable source declaration,
and makes GCC emit retail's single signed load.  `facetValue` is marked as a
`SYM-CODEGEN-CARRIER`; the full `-O2 -g` type-graph compilation confirms it is
optimized out of the debug graph while both named `facetFlag` records retain
their exact `SHORT` type.

## Verification

- `verify_asm.py`: `DrawC_PrimClip` PASS, 1877/1877 instructions.
- `vdiff.py`: `[ours=1877 oracle=1877]`, no differences.
- Exact neighbors remain PASS: `DrawC_Prim` 1389/1389 and
  `DrawC_PrimMenu` 480/480.
- Debug type-graph probe for `drawc.cpp`: all 105/105 retail named records
  exact; both anonymous records covered.
- Strict game/PSX declaration audit: 395/395 declaration-clean, zero missing
  names, zero extra locals, zero type findings; explicit function-type
  overrides 3 -> 2.
- Full game/PSX gate: 395 functions, 385 PASS, zero compile failures, with the
  same ten pre-existing residuals.
- Both relink lanes: GREEN; real duplicates 0, hidden phantoms 0, genuine
  relocation-referenced unresolved names 0.
- Vtable indexing audit: PASS across 926 files.
- Full production build links successfully at 1,239,008 bytes versus retail
  1,239,040 bytes, retaining the independent legacy `-32` section-layout delta.
