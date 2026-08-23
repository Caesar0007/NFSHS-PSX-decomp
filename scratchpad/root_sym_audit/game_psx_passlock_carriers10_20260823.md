# Game/PSX PASS-lock carrier resolution — tenth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Removed source-only locals

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `DrawC_ShadowPrimClip` | `u2`, `vt2` | direct `sd->offsetU2` and `sd->vt8` addresses at the four calls | PASS 335/335 |
| `Hud_BuildRadar` | `tag` | remove the unused decompiler declaration | PASS 450/450 |
| `Hud_PositionMap` | `track` | direct `GameSetup_gData.track` indices; compiler CSE preserves retail code | PASS 66/66 |
| `Hud_Reset` | `psVar1`, `iVar2` | remove the unused pointer and use canonical SYM `i` as the loop counter | PASS 22/22 |
| `Night_DoLightningEffect` | `r`, `tunnel` | consume `random()` and `BWorldSm_TunnelFlagSm()` directly | PASS 97/97 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `DrawC_PrimMenu` | `rawFlag`, `tex` | existing allocation/fence receipt: separate raw flag plus a tex-only USE fence seals retail scheduling; including rawFlag in the fence is FAIL 14 | PASS 480/480 |
| `Flare_Quad` | `color_word`, `pkt_addr24` | direct color is FAIL 5 (42/41); removing both stages is FAIL 9 (42/41) | PASS 41/41 restored |
| `Flare_QuadNotTransparent` | `color_word`, `pkt_addr24` | direct color is FAIL 5 (42/41); removing both stages is FAIL 9 (42/41) | PASS 41/41 restored |
| `Hrz_SetDitheringPrim` | `prev_pkt_slot`, `prev_val` | direct slot expressions are FAIL 24 (36/34); removing the staged value is FAIL 4 (34/34) | PASS 34/34 restored |
| `Hud_BuildRadar` | `pal` | existing addPrim allocation receipt requires the shared palette-link cell | PASS 450/450 |
| `Hud_RenderMapView` | `pal`, `tp` | per-block palette bases prevent scratch-base LICM; one computed `gTPage1` cell avoids a second +0x30 GIV | PASS 161/161 |
| `Weather_ProcessParticles` | `reset`, `tr` | `reset` carries the call result across retail writeback/increment; direct translation fields/source are FAIL 22 (251/251) | PASS 251/251 restored |

## Audit movement

- declaration-clean functions: 292 -> 303
- generic extra source-local names: 731 -> 709
- explicit source-only codegen carriers: 117 -> 131
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `drawc.cpp`: 19/20 PASS; unchanged locked `DrawC_PrimClip` FAIL 49.
- `flare.cpp`: 27/27 PASS.
- `hrzsku.cpp`: 20/22 PASS; unchanged locked `Hrz_BuildHorizon` FAIL 12 and
  `Hrz_BuildSky` FAIL 146.
- `hud.cpp`: 59/62 PASS; unchanged locked `Hud_BuildCdPlayer` FAIL 1,
  `Hud_RenderTacView` FAIL 11, and `Hud_BuildNumbers` FAIL 188.
- `night.cpp`: 18/19 PASS; unchanged locked `Night_CreateNightTableElement` FAIL 26.
- `weather.cpp`: 25/25 PASS.

No unmatched function body was edited in this wave.
