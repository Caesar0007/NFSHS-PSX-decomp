# Game/PSX PASS-lock carrier resolution — eighteenth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Canonical PsyQ addPrim restoration

The hand-written mask/OR ordering-table links were replaced by the actual PsyQ
24-bit `P_TAG` field spelling. This restores the source-level
`setaddr(p,getaddr(ot)), setaddr(ot,p)` expansion and lets gcc generate the same
mask order without fabricated local names.

| Function | Removed name(s) | Gate |
|---|---|---|
| `Flare_OctFlare` | `addr24`, `pal`, `pkt24`, `slot` | PASS 136/136 |
| `Flare_OctFlareSpikes` | `addr24_0`, `addr24_1`, `pal`, `pkt24`, `slot` | PASS 225/225 |
| `Flare_Spikes` | `addr24`, `pal`, `pkt24`, `slot` | PASS 183/183 |
| `Flare_HexFlare` | `addr24`, `pal`, `pkt24`, `slot` | PASS 117/117 |
| `Flare_ReflectHexFlare` | `addr24`, `pal`, `pkt24`, `slot` | PASS 117/117 |
| `Flare_PreCalcHexLightBeam` | `addr24`, `pal`, `pkt24`, `slot` | PASS 53/53 |
| `Flare_Sun` | `addr24_0`, `addr24_1`, `pkt24`, `slot` | PASS 187/187 |
| `Sky_RenderStars` | `pal`, `pkt24`, `slot`, `tag` | PASS 111/111 |

## Explicit source-only codegen carriers

| Function | Carrier | Evidence | Gate |
|---|---|---|---|
| `Flare_Spikes` | `rgb` | direct `gfrgb2` load/store is FAIL 5 and 184/183 instructions | PASS 183/183 restored |
| `Flare_HexFlare` | `rgb` | direct `gfrgb` load/store is FAIL 5 and 118/117 instructions | PASS 117/117 restored |
| `Flare_ReflectHexFlare` | `rgb` | direct `gfrgb` load/store is FAIL 5 and 118/117 instructions | PASS 117/117 restored |
| `Flare_PreCalcHexLightBeam` | `rgb` | direct `gfrgb2` load/store is FAIL 7 and 54/53 instructions | PASS 53/53 restored |

## Audit movement

- declaration-clean functions: 342 -> 350
- generic extra source-local names: 562 -> 525
- explicit source-only codegen carriers: 189 -> 193
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `flare.cpp`: 27/27 PASS.
- `hrzsku.cpp`: 20/22 PASS; unchanged locked failures:
  `Hrz_BuildHorizon` FAIL 12 and `Hrz_BuildSky` FAIL 146.

No unmatched function body was edited in this wave.
