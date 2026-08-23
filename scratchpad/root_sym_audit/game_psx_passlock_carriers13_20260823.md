# Game/PSX PASS-lock carrier resolution — thirteenth wave

Scope: `recon/game/psx`. Every edited function was freshly confirmed PASS
before modification and after the retained form. Unmatched functions were
regression-checked read-only.

## Removed source-only names

| Function | Removed name(s) | SYM-faithful source form | Gate |
|---|---|---|---|
| `Draw_MenuRenderingView` | `mr`, `m` | direct `Vi->cview.mrotation` and `mrotationInv` member addresses | PASS 234/234 |
| `DrawW_BuildChunkCenterLineFacets` | `bVar10`, `curLine` | direct loop condition and canonical SYM `lineQuad` walker, reset before the call | PASS 88/88 |
| `Flare_QuadRing` | `prev_pkt_slot` | direct zero store to the packet's `+0x0c` field | PASS 45/45 |
| `Hud_Draw321Num` | `arg4`, `arg5` | retain the mangling-proven six-`int` ABI while omitting unproven names for the two unused formals | PASS 111/111 |
| `Hud_Render` | `iface`, `j` | delete unused declaration and reuse canonical SYM `i` for the disjoint second loop | PASS 282/282 |

## Explicit source-only codegen carriers

| Function | Carrier(s) | Evidence | Gate |
|---|---|---|---|
| `Draw_MenuRenderingView` | `bVar1` | direct `showRoomFlag` retest is FAIL 19 (237/234), adding three instructions and rotating the following register web | PASS 234/234 restored |
| `DrawW_BuildChunkCenterLineFacets` | `rn` | existing measured receipt: direct `right[0..2]` access is 29 diffs and one instruction short; the named pointer reproduces the in-place slice-base mutation | PASS 88/88 |
| `Flare_QuadRing` | `innerColor` | direct first color store is FAIL 5 (46/45) | PASS 45/45 restored |
| `Flare_QuadRing` | `outerColor` | direct second color store is FAIL 9 (46/45); removing both is FAIL 7 (46/45) | PASS 45/45 restored |
| `Hud_Draw321Num` | `by2` | merging loop-2 storage into canonical `by` is count-exact FAIL 16 (111/111), swapping the retail `$s4/$s5` walker allocation | PASS 111/111 restored |
| `Hud_Render` | `remain` | a source-level two-arm clamp without the staged difference is FAIL 16 (284/282); the staging gives the retail one-store `subu/bgez` funnel | PASS 282/282 restored |

## Audit movement

- declaration-clean functions: 320 -> 325
- generic extra source-local names: 658 -> 643
- explicit source-only codegen carriers: 154 -> 160
- missing SYM names: 0
- function/global storage findings: 0/0
- function/global type findings: 1/0; the sole function finding remains the
  locked unmatched `DrawC_PrimClip::facetFlag` row.

## Whole-translation-unit regression gates

- `fe3dmenu.cpp`: 3/3 PASS.
- `draww.cpp`: 31/35 PASS; unchanged locked `DrawW_SubdividFacet` FAIL 8,
  `DrawW_DoTrough` FAIL 9, `Draw_kCtrlSkidmark` FAIL 20, and
  `DrawW_OnyxLinePrim` FAIL 66.
- `flare.cpp`: 27/27 PASS.
- `hud.cpp`: 59/62 PASS; unchanged locked `Hud_BuildCdPlayer` FAIL 1,
  `Hud_RenderTacView` FAIL 11, and `Hud_BuildNumbers` FAIL 188.

No unmatched function body was edited in this wave.
