# Game/PSX PASS-lock carrier resolution — seventh wave

Scope: `recon/game/psx`.  Every function named below was confirmed PASS with
`tools/verify_asm.py` before its body was edited and again after the retained
change.  Functions that were not PASS were read only.

## Removed source-only locals

| Function | Removed name | SYM-faithful source form | Gate |
|---|---|---|---|
| `DrawW_SetUpSubdividFacet` | `sVar2` | direct `vN->dvy` field reads | PASS 206/206 |
| `DrawW_NightColorCalc` | `lt` | unused declaration removed | PASS 279/279 |
| `uppercase` | `pbVar2` | indexed `((u_char *)string)[n]` reads/writes | PASS 24/24 |

## Explicit source-only codegen carriers

| Function | Carrier | Evidence | Gate |
|---|---|---|---|
| `Flare_Tri` | `pkt_addr24` | existing OT-link receipt: named mask value preserves retail constant-hoist/order | PASS 39/39 |
| `Flare_2DSpike` | `rgb` | existing receipt: removing/reusing the colour staging value produces 16 diffs | PASS 43/43 |
| `Font_Blit` | `tpage` | unused but required by the blitter callback ABI/signature | PASS 55/55 |
| `Font_LoadFont` | `hdr` | existing receipt: inline header-base spelling reassociates the constant | PASS 117/117 |
| `Horizon_InterpolateLineSCoords` | `pv` | existing receipt: pre-loop read is the zero-insn LICM/reference-shape lever | PASS 80/80 |
| `Hrz_LightningFlicker` | `col` | direct literal stores are count-exact but FAIL 4 (55/55) | PASS 55/55 restored |
| `CarIO_UpdateCarTextureData` | `pmx` | existing receipt: staged index-term-first address produces retail `addu` operand order | PASS 298/298 |
| `DrawC_ReadLightingData` | `trk` | existing receipt: staged `a3` lets the format address schedule between the two global loads | PASS 130/130 |
| `DrawW_kCtrlWorld_High` | `sentinel` | existing receipt: lazy `-1` copy creates the retail `$s3` loop terminator | PASS 32/32 |
| `Sfx_BuildSouffleFacet` | `ds` | raw/SYM receipt: register-base view is required for vertex stores and alias-driven reloads | PASS 938/938 |

## Audit movement

- declaration-clean functions: 263 -> 276
- generic extra source-local names: 768 -> 755
- explicit source-only codegen carriers: 92 -> 102
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

