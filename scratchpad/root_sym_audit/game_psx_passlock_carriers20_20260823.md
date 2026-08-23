# Game/PSX PASS-lock carrier resolution — twentieth wave

Scope: `recon/game/psx/hud.cpp`. Both edited functions were freshly confirmed
PASS before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Canonical SYM restoration

`Hud_BuildSprite` now uses its sole SYM local, `shape`, directly. Six
decompiler-only names (`pHVar3`, `tu1`, `uVar1`, `uVar2`, `uVar4`, and `uVar5`)
were removed while preserving PASS 43/43. The color and packed-position values
are expressed directly at their stores.

## Explicit source-only codegen carriers

`Hud_BuildString` remains PASS 215/215 and is now declaration-clean by explicit
disposition of all six non-SYM names:

| Carrier | Rejected direct form |
|---|---|
| `iw1` | FAIL 8, 217/215 instructions |
| `iw2` | FAIL 30, 217/215 instructions |
| `iw3` | FAIL 8, 217/215 instructions |
| `iw4` | FAIL 8, 217/215 instructions |
| `iw5` | FAIL 12, 217/215 instructions |
| `as` | existing measured allocation receipt: naming the glyph index changes the residual 26 -> 9 before the final PASS levers |

The five `iw*` stages preserve the retail load-delay/cross-jump shape. Each was
tested independently and its failing direct-expression form was reverted.

## Audit movement

- declaration-clean functions: 355 -> 357
- generic extra source-local names: 501 -> 489
- explicit source-only codegen carriers: 198 -> 204
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gate

- `hud.cpp`: 59/62 PASS; unchanged locked failures:
  `Hud_BuildCdPlayer` FAIL 1, `Hud_RenderTacView` FAIL 11, and
  `Hud_BuildNumbers` FAIL 188.

No unmatched function body was edited in this wave.
