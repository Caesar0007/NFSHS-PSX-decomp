# Game/PSX PASS-lock carrier resolution — fifteenth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Removed source-only locals

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `DrawW_StripDraw_High` | `bVar1`, `pTVar4`, `sVar2` | canonical SYM `stripPtr`; direct quad-count conversion and direct `sd->numStrips` update/test | PASS 58/58 |
| `DrawW_SetUpSubdividFacet_Line` | `cw_a`, `cw_b`, `ts2`, `ts4`, `ts6` | exact nested SYM `a,b` color block and direct repeated `dvy` member reads | PASS 166/166 |
| `Hud_BustedOverlayOn` | `pcVar1`, `iVar2`, `iVar4`, `psVar3` | direct `Hud_NextPerp[i]` indexing, leaving exactly the sole SYM-named local `i` | PASS 110/110 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `DrawW_StripDraw_High` | `pMaterial` | existing measured receipt: a dedicated +4 halfword cursor reproduces the retail inner-loop addressing and frees `$s2`; re-deriving the indexed material address does not | PASS 58/58 |
| `Hrz_TextureQuad` | `pmx` | the shared pixmap pointer preserves the retail four-word load group followed by four stores | PASS 76/76 |
| `Hrz_TextureQuad` | `pal` | caching the fixed scratchpad palette pointer once prevents a second fixed-address dereference | PASS 76/76 |
| `Hrz_TextureQuad` | `slot`, `tag` | staged index-first OT RMW keeps `Render_gPacketPtr`'s store between the slot load/store; base-first was FAIL 26 and direct parameter mutation FAIL 83 in the recorded basin | PASS 76/76 |

## Audit movement

- declaration-clean functions: 329 -> 333
- generic extra source-local names: 626 -> 609
- explicit source-only codegen carriers: 170 -> 175
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `draww.cpp`: 31/35 PASS; unchanged locked failures:
  `DrawW_SubdividFacet` FAIL 8, `DrawW_DoTrough` FAIL 9,
  `Draw_kCtrlSkidmark` FAIL 20, and `DrawW_OnyxLinePrim` FAIL 66.
- `hud.cpp`: 59/62 PASS; unchanged locked failures:
  `Hud_BuildCdPlayer` FAIL 1, `Hud_RenderTacView` FAIL 11, and
  `Hud_BuildNumbers` FAIL 188.
- `hrzsku.cpp`: 20/22 PASS; unchanged locked failures:
  `Hrz_BuildHorizon` FAIL 12 and `Hrz_BuildSky` FAIL 146.

No unmatched function body was edited in this wave.
