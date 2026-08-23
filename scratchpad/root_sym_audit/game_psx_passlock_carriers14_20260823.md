# Game/PSX PASS-lock carrier resolution — fourteenth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Removed source-only locals

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `Night_SetWeatherColors` | `colorH`, `color_walk`, `wtbl`, `wtblp` | direct indexing of the two correctly sized retail arrays by canonical SYM `i` | PASS 31/31 |
| `Night_SetEnviroment` | `mode`, `zn` | delete unused decompiler declarations absent from the SYM | PASS 68/68 |
| `DrawC_PrimHalo` | `iVar6` | update and test canonical `sd->otz` directly | PASS 298/298 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `DrawC_NightHeadlight` | `h0`, `h1`, `h2` | existing allocation receipt: three distinct immediate-lifetime subtrahends permit retail dead-register reuse; one reused quantity produced the measured register rotation | PASS 107/107 |
| `DrawC_NightHeadlight` | `lp`, `wc` | direct per-channel expressions rematerialize the two bases; fully inline weather/light expressions are FAIL 48 (109/107) in the retained fence basin | PASS 107/107 |
| `DrawC_PrimHalo` | `uVar8` | mutating and reusing canonical `real_type` is FAIL 97 (295/298) | PASS 298/298 restored |
| `DrawC_PrimHalo` | `ov`, `ovs` | existing measured receipt: the staged halfword plus fresh shifted value and two zero-insn fences reproduce the retail shared load, load-delay nops, and joined allocation; fused/direct forms were 33–45 diffs | PASS 298/298 |
| `Night_SetEnviroment` | `tgt` | direct `Camera_gInfo[Vi->player].target` access is count-exact FAIL 6 (68/68) | PASS 68/68 restored |
| `Night_SetEnviroment` | `zn2` | direct constant store is count-exact FAIL 8 (68/68) and rotates the target/constant registers | PASS 68/68 restored |

## Audit movement

- declaration-clean functions: 325 -> 329
- generic extra source-local names: 643 -> 626
- explicit source-only codegen carriers: 160 -> 170
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `drawc.cpp`: 19/20 PASS; unchanged locked `DrawC_PrimClip` FAIL 49.
- `night.cpp`: 18/19 PASS; unchanged locked `Night_CreateNightTableElement`
  FAIL 26.

No unmatched function body was edited in this wave.
