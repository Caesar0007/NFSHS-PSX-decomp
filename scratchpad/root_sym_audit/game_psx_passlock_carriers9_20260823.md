# Game/PSX PASS-lock carrier resolution — ninth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and again after the retained form. Unmatched functions
were regression-checked read-only.

## Removed source-only locals

| Function | Removed name | SYM-faithful source form | Gate |
|---|---|---|---|
| `DrawC_ShadowPrim` | `iVar1` | assign and test `sd->otz` directly | PASS 129/129 |
| `DrawW_CalcSubdivision` | `iVar1` | remove the unused decompiler result-funnel declaration | PASS 34/34 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `CarIO_CleanUpLicense` | `ppPlate1`, `psVar1` | the shared element-address/load shape is exact; the previously measured direct index form is FAIL 6 | PASS 30/30 |
| `CarIO_LicenseCheck` | `sVar1`, `sVar2` | reusing canonical `sfx_vx/sfx_vy` is count-exact but changes a retail byte load into a word load, FAIL 2 (39/39) | PASS 39/39 restored |
| `DrawC_ShadowPrim` | `otp` | the existing receipt shows one shared OT-cell address is needed for the retail index copy and three uses | PASS 129/129 |
| `DrawW_CalcSubdivision` | `minz` | the existing receipt requires a running-min funnel before the descending direct-return guard chain | PASS 34/34 |
| `Hud_FBuildSprite` | `prev_pkt` | the existing allocation receipt shows dropping the cached palette-link cell regresses the exact OT-RMW | PASS 37/37 |
| `Hud_FBuildF4` | `prev_pkt` | the cached palette-link cell is part of the exact single-block OT-RMW source shape | PASS 48/48 |

## Audit movement

- declaration-clean functions: 286 -> 292
- generic extra source-local names: 741 -> 731
- explicit source-only codegen carriers: 109 -> 117
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `cario.cpp`: 10/11 PASS; unchanged locked `CarIO_ReadInCarTextureData` FAIL 19.
- `drawc.cpp`: 19/20 PASS; unchanged locked `DrawC_PrimClip` FAIL 49.
- `draww.cpp`: 31/35 PASS; unchanged locked `DrawW_SubdividFacet` FAIL 8,
  `DrawW_DoTrough` FAIL 9, `Draw_kCtrlSkidmark` FAIL 20, and
  `DrawW_OnyxLinePrim` FAIL 66.
- `hud.cpp`: 59/62 PASS; unchanged locked `Hud_BuildCdPlayer` FAIL 1,
  `Hud_RenderTacView` FAIL 11, and `Hud_BuildNumbers` FAIL 188.

No unmatched function body was edited in this wave.
