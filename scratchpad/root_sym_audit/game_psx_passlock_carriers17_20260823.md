# Game/PSX PASS-lock carrier resolution — seventeenth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Removed source-only locals

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `Hud_BTC_QuitOut` | `name_tail`, `perp_idx`, `row_base`, `row_off`, `slot_i` | canonical SYM `i` and natural `BTCPerpInfo[i][Hud_NextPerp[i]]` indexing | PASS 49/49 |
| `RaceSummary` | `barH`, `halfH` | direct `HUD_STATS_SIZE_H` expressions, preserving retail statement order | PASS 349/349 |
| `Weather_CheckAndResetParticles` | `pt_reg`, `reset_flag`, `rnd` (old first-arm temporary), `sVar3`, `sVar4`, `uVar2`, `z_off` | canonical SYM `flag`, direct `random()` expressions, and direct signed `zfar / 2` divisor | PASS 223/223 |
| `Hud_BlackThinBox` | `side_h`, `side_y`, `top_w`, `x_left`, `x_right`, `y_bottom` | direct coordinate/span expressions; gcc recovers the same anonymous common subexpressions | PASS 123/123 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `RaceSummary` | `titleX`, `titleY`, `w2` | direct `titleX` is FAIL 79 (350/349); direct `titleY` expressions are FAIL 87 (344/349); the existing masked-width carrier preserves retail's `lhu` plus copy | PASS 349/349 restored |
| `Weather_CheckAndResetParticles` | `rnd` | the z-near arm must retain `random()` before computing `zfar / 2`; direct modulo is FAIL 77 (222/223) | PASS 223/223 restored |
| `Hud_BlackThinBox` | `CORNERWIDTH` | direct repeated shape-width expressions are FAIL 126 and six instructions short (117/123), because the intervening draw calls prevent retention | PASS 123/123 restored |

## Audit movement

- declaration-clean functions: 338 -> 342
- generic extra source-local names: 586 -> 562
- explicit source-only codegen carriers: 184 -> 189
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `hud.cpp`: 59/62 PASS; unchanged locked failures:
  `Hud_BuildCdPlayer` FAIL 1, `Hud_RenderTacView` FAIL 11, and
  `Hud_BuildNumbers` FAIL 188.
- `overlays.cpp`: 4/5 PASS; the unchanged locked `RaceStatistics` is FAIL 71.
- `weather.cpp`: 25/25 PASS.

No unmatched function body was edited in this wave.
