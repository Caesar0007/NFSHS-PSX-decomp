# Game/PSX PASS-lock carrier resolution — twenty-third wave

Scope: four byte-matched Hud functions with extensive existing compiler
receipts. Every function was freshly verified before and after disposition.

## Explicit source-only codegen carriers

| Function | Carrier set | Evidence summary | Gate |
|---|---|---|---|
| `Hud_BuildNumbers` | `pal`, `pal_2`, `pal_3`, `xt`, `m2`, `xm1` | palette live-range splitting plus three statement-granular fold barriers; all have measured residual reductions in the function receipt | PASS 758/758 |
| `Hud_BuildTach` | `clutx`, `pal`, `pal2`, `tachNeedle_p`, `tp3`, `tp9`, `ts1`, `ts3`, `ts4` | packet-link range splitting, scheduling fixpoints, and store-forward staging; direct `tachNeedle_p` removal independently fails by 14 at 269/269 | PASS 269/269 |
| `Hud_BuildMapMarkers` | `aiflags`, `car`, `cflags`, `mapx`, `pal`, `pktcell` | cross-loop CSE break, load positioning, and the measured paired car/carFlags lever | PASS 308/308 |
| `Hud_BuildWingmanInterface` | `fc`, `iconRow`, `now`, `pal`, `two`, `xf` | recorded evaluation-order, scope-split, constant-birth, and fold-barrier levers | PASS 211/211 |

These twenty-seven names are absent from the SYM but cannot be removed without
losing the retail compiler shape. They are now explicit proof-bearing carriers
rather than generic audit dispositions.

## Audit movement

- declaration-clean functions: 364 -> 368
- generic extra source-local names: 442 -> 415
- explicit source-only codegen carriers: 211 -> 238
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0.

## Whole-translation-unit gate

- `hud.cpp`: 60/62 PASS; unchanged locked failures:
  `Hud_BuildCdPlayer` FAIL 1 and `Hud_RenderTacView` FAIL 11.

No unmatched function body was edited.
