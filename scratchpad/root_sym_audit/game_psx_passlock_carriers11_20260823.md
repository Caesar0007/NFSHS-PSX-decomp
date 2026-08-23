# Game/PSX PASS-lock carrier resolution — eleventh wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Removed source-only locals

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `Flare_SingleColorTex` | `sVar1`, `sVar2` | repeat direct `(short)width` and `(short)height` casts | PASS 41/41 |
| `Hud_BuildF3` | `uVar1`, `iVar2`, `iVar3` | direct half-height expressions at the two coordinate stores | PASS 49/49 |
| `Hud_BuildF4o` | `uVar1`, `uVar2`, `uVar3`, `uVar4` | direct packed-coordinate expressions at all four stores | PASS 53/53 |
| `Hud_ParseTime` | `iVar1` | direct `D_801132CC[0]` indices at the two character reads | PASS 91/91 |
| `Night_GenerateNextLightningEvent` | `r`, `fork` | direct `random()` calls where no shared staging is required | PASS 29/29 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `DrawW_BuildChunkObjectFacets` | `anim`, `t3` | existing arm-local-anchor receipt fixes the vtable dispatch copy; split fixedmult results preserve retail call/store scheduling | PASS 434/434 |
| `Hud_Init` | `sye`, `syc` | existing receipt: named splitY offsets produce the retail field-first `addu` operand order | PASS 624/624 |
| `Hud_BTCStats` | `sizeH`, `postgameInset` | existing GCC-fold receipt: hoisted minuend fixes s1/s2 roles and the mutable in-loop constant escapes fold while CSE restores `addiu 8` | PASS 473/473 |
| `Hud_RenderStatsView` | `t` | existing receipt: distinct clamp result produces both retail global stores; in-place clamp is FAIL 15 | PASS 139/139 |
| `CarIO_CopyToShape` | `n0`, `n1`, `n2`, `n3` | the measured 576-cell assignment/OR sweep requires four named parallel nibble chains | PASS 42/42 |
| `Hud_ParseTime` | `centi_total`, `min`, `sec` | direct nTime mutation is FAIL 13 (92/91); the quotients remain live through remainder calculation/formatting | PASS 91/91 restored |
| `Night_GenerateNextLightningEvent` | `rmask`, `ticksp` | direct delay expressions are FAIL 8 (29/29); direct gameTicks global is FAIL 2 (29/29) | PASS 29/29 restored |

## Audit movement

- declaration-clean functions: 303 -> 313
- generic extra source-local names: 709 -> 681
- explicit source-only codegen carriers: 131 -> 147
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `cario.cpp`: 10/11 PASS; unchanged locked `CarIO_ReadInCarTextureData` FAIL 19.
- `draww.cpp`: 31/35 PASS; unchanged locked `DrawW_SubdividFacet` FAIL 8,
  `DrawW_DoTrough` FAIL 9, `Draw_kCtrlSkidmark` FAIL 20, and
  `DrawW_OnyxLinePrim` FAIL 66.
- `flare.cpp`: 27/27 PASS.
- `hud.cpp`: 59/62 PASS; unchanged locked `Hud_BuildCdPlayer` FAIL 1,
  `Hud_RenderTacView` FAIL 11, and `Hud_BuildNumbers` FAIL 188.
- `night.cpp`: 18/19 PASS; unchanged locked `Night_CreateNightTableElement` FAIL 26.
- `overlays.cpp`: 4/5 PASS; unchanged locked `RaceStatistics` FAIL 71.

No unmatched function body was edited in this wave.
