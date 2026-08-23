# Game/PSX PASS-lock carrier resolution — twelfth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Removed source-only locals

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `DrawW_DoObjectAnimations` | `time_00`, `ppTVar1`, `iVar2`, `table` | canonical SYM `track`, `trackPtr`, `i`, and `time` locals | PASS 40/40 |
| `ObjectClipped` | `iVar1`, `iVar2` | direct comparisons of `tmp2.x` and `tmp2.z` | PASS 61/61 |
| `Hud_GoTpage` | `addr_24`, `tp1_hi`, `p`, `tp1` | canonical `P_TAG`/`addPrim` source shape using SYM local `prim` | PASS 36/36 |
| `Hud_FBuildGT4` | `pkt_addr24`, `prev_hi`, `prev_pkt` | canonical `P_TAG`/`addPrim` source shape | PASS 35/35 |
| `Hud_FBuildFT4` | `pkt_addr24`, `prev_hi`, `prev_pkt` | canonical `P_TAG`/`addPrim` source shape | PASS 36/36 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `DrawC_ShowroomPrims` | `m1`, `hs`, `z1` | existing measured receipts: named fill sentinel materializes before the counter; reverse walker reproduces the down-counting GIV; address GIV avoids an offset GIV plus per-iteration add | PASS 297/297 |
| `DrawC_SpotPrims` | `color` | direct packet color store is FAIL 7 (226/225); staging supplies the retail load-delay slot | PASS 225/225 restored |
| `DrawC_SpotPrims` | `pDVar7`, `puVar8` | reusing the outer primitive pointer and mutating the OT pointer is FAIL 74 (227/225); distinct mode-packet and OT-cell pointers are required | PASS 225/225 restored |
| `ObjectClipped` | `pvVar3` | direct returns are FAIL 6 (61/61); the result funnel preserves retail branch polarity | PASS 61/61 restored |

## Audit movement

- declaration-clean functions: 313 -> 320
- generic extra source-local names: 681 -> 658
- explicit source-only codegen carriers: 147 -> 154
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `drawc.cpp`: 19/20 PASS; unchanged locked `DrawC_PrimClip` FAIL 49.
- `draww.cpp`: 31/35 PASS; unchanged locked `DrawW_SubdividFacet` FAIL 8,
  `DrawW_DoTrough` FAIL 9, `Draw_kCtrlSkidmark` FAIL 20, and
  `DrawW_OnyxLinePrim` FAIL 66.
- `hud.cpp`: 59/62 PASS; unchanged locked `Hud_BuildCdPlayer` FAIL 1,
  `Hud_RenderTacView` FAIL 11, and `Hud_BuildNumbers` FAIL 188.

No unmatched function body was edited in this wave.
