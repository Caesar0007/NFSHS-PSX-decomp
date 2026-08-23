# Game/PSX PASS-lock carrier resolution — twenty-second wave

Scope: one Hud helper and two large Flare functions. Every directly edited
function was freshly confirmed PASS before modification and after the retained
form. Unmatched function bodies were not edited.

## SYM-source restoration

| Function | Resolution | Gate |
|---|---|---|
| `Hud_BuildTimeSprites` | removed six dead decompiler declarations; classified indexed-GIV `n` | PASS 77/77 |
| `Flare_CarShapedHalo` | replaced `slot`/`pkt24`/`addr24_0` hand masks with canonical `Flare_PTag`; classified `c`, `dtd`, `i`, `j` | PASS 630/630 |
| `Flare_Halo2` | canonicalized both OT links; removed the unprovable unused final parameter name while preserving its ABI type/arity; classified `c`, `dtd` | PASS 603/603 |

The Flare carrier classifications are backed by the existing in-source
compiler receipts: serial color-copy anti-dependence, masked-index allocation,
and the `VAR_DECL` barrier that prevents GCC fold from rewriting the draw-mode
test into a shift/bit expression.

## Audit movement

- declaration-clean functions: 361 -> 364
- generic extra source-local names: 461 -> 442
- explicit source-only codegen carriers: 204 -> 211
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains
  `DrawC_PrimClip::facetFlag`.

The three target functions resolve twenty-one prior generic discrepancies.
The generated audit's net movement is nineteen because it reflects the entire
live dirty tree rather than only this scoped wave.

## Whole-translation-unit regression gates

- `flare.cpp`: 27/27 PASS.
- `hud.cpp`: **60/62 PASS**. `Hud_BuildNumbers`, whose body was not edited in
  this wave, moved from FAIL 188 to independently verified PASS 758/758 after
  the preceding PASS-only TU source cleanup. The only remaining locked failures
  are `Hud_BuildCdPlayer` FAIL 1 and `Hud_RenderTacView` FAIL 11.
- vtable indexing audit: PASS across 926 files.

No unmatched function body was edited in this wave.
