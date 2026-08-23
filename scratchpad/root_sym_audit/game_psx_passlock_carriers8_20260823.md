# Game/PSX PASS-lock carrier resolution — eighth wave

Scope: `recon/game/psx`. Every function below was freshly confirmed PASS with
`tools/verify_asm.py` before its body was edited and again after the retained
change. Functions that were not PASS were read only.

## Removed source-only locals

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `DrawW_WorldSetUpTranslation` | `iVar1`, `iVar2` | canonical SYM locals `ty` and `tz` hold the field values directly | PASS 17/17 |
| `Draw_CircleClip` | `iVar1`, `iVar2` | canonical SYM locals `dx` and `dz` hold the absolute coordinate differences | PASS 24/24 |
| `Hud_BuildF4` | `uVar3` | duplicate the direct `(y + h) * 0x10000` expression at the two packet stores | PASS 41/41 |
| `Hud_BuildG4` | `uVar3` | duplicate the direct `(y + h) * 0x10000` expression at the two packet stores | PASS 47/47 |
| `Night_RestartNightDriving` | `r` | consume each `random()` result directly in its masked assignment | PASS 34/34 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `Night_NightCalc` | `lt` | the existing identity-laundering receipt moves the table-byte load to the retail issue slot | PASS 57/57 |
| `DrawW_GetAnimationTime` | `iVar2`, `tick` | the distinct result funnel and block-local load temporary preserve retail's redundant copy/allocation shape | PASS 33/33 |
| `Hud_InitTables` | `patVar1` | direct per-arm table-base assignments are FAIL 12 (15/11); the default-then-override pointer funnel is exact | PASS 11/11 |
| `Hud_InitMap` | `iVar4` | direct global bounds are FAIL 22 (46/40); the cached bound preserves the retail dual-GIV loop | PASS 40/40 |
| `Fog_Update` | `slot` | direct indexed load/store is count-exact but FAIL 4 (81/81), changing load/index issue order | PASS 81/81 |
| `Fog_Update` | `start` | direct per-arm global stores are FAIL 11 (82/81); the branch-result join gives retail's single final store | PASS 81/81 |

## Audit movement

- declaration-clean functions: 276 -> 286
- generic extra source-local names: 755 -> 741
- explicit source-only codegen carriers: 102 -> 109
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `draww.cpp`: 31/35 PASS. The four unchanged locked baselines are
  `DrawW_SubdividFacet` FAIL 8, `DrawW_DoTrough` FAIL 9,
  `Draw_kCtrlSkidmark` FAIL 20, and `DrawW_OnyxLinePrim` FAIL 66.
- `hud.cpp`: 59/62 PASS. The three unchanged locked baselines are
  `Hud_BuildCdPlayer` FAIL 1, `Hud_RenderTacView` FAIL 11, and
  `Hud_BuildNumbers` FAIL 188.
- `night.cpp`: 18/19 PASS. The unchanged locked baseline is
  `Night_CreateNightTableElement` FAIL 26.
- `textureprocess.cpp`: 16/16 PASS.

No unmatched function body was edited in this wave.
