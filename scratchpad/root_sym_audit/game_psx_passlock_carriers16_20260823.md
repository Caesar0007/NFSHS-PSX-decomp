# Game/PSX PASS-lock carrier resolution — sixteenth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Removed source-only locals

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `Flare_TextureQuad` | `shape_p` | direct repeated `gFlarePixmap[(u_char)type]` expressions; gcc creates the anonymous shared pointer required by the four-word copy | PASS 55/55 |
| `Flare_SingleColorOct` | `iVar1`, `iVar4`, `pDVar3`, `pSVar2` | canonical SYM `i` plus `pt[8]`; natural signed `/ 256` and indexed arrays reproduce the correction and strength-reduced cursors | PASS 54/54 |
| `Hud_Render321Go` | `flare_intensity_00`, `num_00`, `uVar1`, `y_00` | canonical SYM `flare_intensity`, `num`, `currentTick`, and `y` | PASS 83/83 |
| `Weather_InitSplats` | `rnd`, `splat_i`, `uVar1`, `y_max` | canonical SYM `i/ySize` and direct `random()` call expressions | PASS 69/69 |
| `Fe3D_InitShowroom` | `pCVar6` | delete unused decompiler pointer absent from SYM | PASS 107/107 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `Flare_TextureQuad` | `color_word` | direct color load/store is FAIL 5 and 56/55 instructions | PASS 55/55 restored |
| `Flare_TextureQuad` | `pkt_addr24` | staged OT high word preserves the retail potentially-aliasing load/store schedule, matching the already sealed sibling idiom | PASS 55/55 |
| `Weather_InitSplats` | `gs`, `commModeNetwork` | direct `Weather_GameSetupWords[3] == 1` is FAIL 15 and 66/69 instructions | PASS 69/69 restored |
| `Weather_InitSplats` | `result` | the measured result-variable exit-in-the-middle form is required for the retail no-rotation loop | PASS 69/69 |
| `Fe3D_InitShowroom` | `iVar1` | direct-call algebra is FAIL 22 and 105/107 instructions | PASS 107/107 restored |
| `Fe3D_InitShowroom` | `cos_raw`, `sVar4`, `sh` | existing statement-placement, shared sign-extension, and allocation receipts show these stages are required for the exact 107-instruction schedule | PASS 107/107 |

## Audit movement

- declaration-clean functions: 333 -> 338
- generic extra source-local names: 609 -> 586
- explicit source-only codegen carriers: 175 -> 184
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `flare.cpp`: 27/27 PASS.
- `weather.cpp`: 25/25 PASS.
- `fe3dmenu.cpp`: 3/3 PASS.
- `hud.cpp`: 59/62 PASS; unchanged locked failures:
  `Hud_BuildCdPlayer` FAIL 1, `Hud_RenderTacView` FAIL 11, and
  `Hud_BuildNumbers` FAIL 188.

No unmatched function body was edited in this wave.
