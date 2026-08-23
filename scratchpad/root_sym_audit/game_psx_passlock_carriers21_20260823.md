# Game/PSX PASS-lock carrier resolution — twenty-first wave

Scope: four small byte-matched builders in `recon/game/psx/hud.cpp`. Every
function was freshly confirmed PASS before modification and after the retained
form. Unmatched functions were regression-checked read-only.

## Removed decompiler declarations

All twenty-eight names were unused source declarations absent from the SYM.
Removing them does not change generated code.

| Function | Removed name(s) | Gate |
|---|---|---|
| `Hud_BuildGT4` | `uVar1`, `uVar2`, `uVar3`, `tu2`, `uv23_pack`, `tpage_clut`, `w_h_pack` | PASS 43/43 |
| `Hud_BuildFT4` | `uVar1`, `uVar2`, `uVar3`, `tu2`, `tu3`, `tu4`, `tu5` | PASS 60/60 |
| `Hud_BuildMirrorFT4` | `uVar1`, `uVar2`, `uVar3`, `uVar4`, `tu2`, `tu3`, `tu4`, `tu5` | PASS 65/65 |
| `Hud_BuildMapMirrorFT4` | `uVar1`, `uVar2`, `uVar3`, `uVar4`, `tu2`, `tu3` | PASS 67/67 |

Each function is now declaration-clean: the SYM records no function-scope
locals for these direct packet builders.

## Audit movement

- declaration-clean functions: 357 -> 361
- generic extra source-local names: 489 -> 461
- explicit source-only codegen carriers: 204 (unchanged)
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gate

- `hud.cpp`: 59/62 PASS; unchanged locked failures:
  `Hud_BuildCdPlayer` FAIL 1, `Hud_RenderTacView` FAIL 11, and
  `Hud_BuildNumbers` FAIL 188.

No unmatched function body was edited in this wave.
