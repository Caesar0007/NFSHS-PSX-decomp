# Game/PSX PASS-lock carrier resolution — nineteenth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## SYM-source restoration

Twenty source-only local names were removed from five byte-matched functions.
The retained source uses canonical PsyQ tag fields, direct object/member
expressions, and the exact SYM local names.

| Function | Removed name(s) | Gate |
|---|---|---|
| `Flare_2DHalo` | `addr24_0`, `addr24_1`, `pal`, `pkt24`, `slot` | PASS 247/247 |
| `Hud_BuildReplay` | `pal`, `palL`, `tSs1`, `tSs1_2`, `tSs1_3` | PASS 191/191 |
| `Hud_NextPlayer` | `iVar1`, `iVar4`, `uVar3`, `uVar5` | PASS 89/89 |
| `Hud_NextPlayerNameOrCarOrTime` | `iVar1`, `iVar2`, `iVar3`, `uVar4` | PASS 98/98 |
| `DrawW_BuildObjectFacets` | `clipRes`, `distSq` | PASS 189/189 |

## Explicit source-only codegen carriers

| Function | Carrier | Evidence | Gate |
|---|---|---|---|
| `Hud_NextPlayer` | `carObj_00` | merging it into canonical `carObj` is FAIL 78 (87/89 instructions) | PASS 89/89 restored |
| `Hud_NextPlayerNameOrCarOrTime` | `carObj_00` | merging it into canonical `carObj` is FAIL 59 (97/98 instructions) | PASS 98/98 restored |
| `DrawW_BuildObjectFacets` | `animType` | direct member tests are FAIL 2 at 189/189 (`sltiu` instead of retail `slti`) | PASS 189/189 restored |
| `DrawW_BuildObjectFacets` | `zo`, `g` | measured three-part joint cell: index birth, scheduling fence, and a second pointer SET prevent `loop.c` hoisting and preserve the retail local-allocation order | PASS 189/189 retained |

## Audit movement

- declaration-clean functions: 350 -> 355
- generic extra source-local names: 525 -> 501
- explicit source-only codegen carriers: 193 -> 198
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

The five target functions resolve twenty-five prior generic discrepancies:
twenty names were removed and five were classified as measured codegen
carriers. The generated audit's net generic movement is twenty-four because it
reflects the complete live dirty tree rather than only this scoped wave.

## Whole-translation-unit regression gates

- `flare.cpp`: 27/27 PASS.
- `hud.cpp`: 59/62 PASS; unchanged locked failures:
  `Hud_BuildCdPlayer` FAIL 1, `Hud_RenderTacView` FAIL 11, and
  `Hud_BuildNumbers` FAIL 188.
- `draww.cpp`: 31/35 PASS; unchanged locked failures:
  `DrawW_SubdividFacet` FAIL 8, `DrawW_DoTrough` FAIL 9,
  `Draw_kCtrlSkidmark` FAIL 20, and `DrawW_OnyxLinePrim` FAIL 66.

No unmatched function body was edited in this wave.
