# Remaining `DrawC` short `facetFlag` restoration — 2026-08-24

## Reliable evidence

The trusted SLD/SYM records `short facetFlag` in both repeated case blocks of
`DrawC_Prim` and in the facet loop of `DrawC_PrimMenu`.  The previous exact
source widened those declarations to integer types to avoid GCC 2.8.1's
HImode reload and allocation cascades.  Those were the final two explicit
game/PSX function-type overrides after the equivalent `DrawC_PrimClip`
correction.

## Source corrections

`DrawC_Prim` now uses the same proven assignment-promotion shape as
`DrawC_PrimClip` at both sites:

```cpp
short facetFlag;
int facetValue;
facetValue = (facetFlag = facet->flag);
```

The sign test and masks consume the explicit integer-promotion carrier.  This
retains one signed halfword load and preserves the exact W75 register/delay-slot
allocation while restoring the lexical `SHORT` record.

`DrawC_PrimMenu` now declares and directly uses `short facetFlag`.  The former
unsigned `rawFlag` carrier is removed.  A source-only `u_int facetMask` holds
the low-twelve-bit result that retail keeps in `$t3`; all later bit tests use
that value.  Separating the reliable source local from the compiler's SI-mode
mask CSE restores the type without changing any instruction.

All `facetValue` and `facetMask` declarations are explicitly documented as
`SYM-CODEGEN-CARRIER` values.  The full debug compile optimizes those carriers
out of the named graph and retains the retail `SHORT facetFlag` records.

## Verification

- `DrawC_Prim`: PASS, 1389/1389 instructions.
- `DrawC_PrimClip`: PASS, 1877/1877 instructions.
- `DrawC_PrimMenu`: PASS, 480/480 instructions.
- `vdiff.py`: no differences for all changed functions.
- Debug type-graph probe for `drawc.cpp`: all 105/105 retail named records
  exact; both anonymous records covered.
- Strict game/PSX declaration audit: 395/395 declaration-clean, zero missing
  names, zero extra locals, zero type findings, and zero explicit function-type
  overrides (2 -> 0).
- Full game/PSX gate: 395 functions, 385 PASS, zero compile failures, with the
  same ten pre-existing residuals.
- Both relink lanes: GREEN; real duplicates 0, hidden phantoms 0, genuine
  relocation-referenced unresolved names 0.
- Vtable indexing audit: PASS across 926 files.
- Full production link succeeds at 1,239,008 bytes versus retail 1,239,040
  bytes.  The newly landed, unrelated frontend `fetourn.cpp` deobfuscation is
  skipped by the reconstruction compiler because its int-to-enum conversion
  warning is fatal in that lane; the link output and legacy `-32` layout delta
  remain unchanged.
