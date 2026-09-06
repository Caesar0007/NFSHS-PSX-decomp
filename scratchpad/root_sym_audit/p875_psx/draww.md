# P875 draww.h public-header receipt

35 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/35; repaired: 35/35. Return-type corrections: 1. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/draww.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/draww.cpp: 35/35 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache` | Restore `DrawW_AddSubdividPrimGT4` | 3e0aa2 / 800c5028 | `void` |
| `DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache` | Restore `DrawW_AddSubdividPrimGT3` | 3e0b03 / 800c50b4 | `void` |
| `DrawW_DivVertice__FP12Draw_SVertexN20` | Restore `DrawW_DivVertice` | 3e0b64 / 800c5124 | `void` |
| `DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31` | Restore `DrawW_CalcSubdivision` | 3e0b97 / 800c51fc | `int` |
| `DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss` | Restore `DrawW_SubdividFacet` | 3e0beb / 800c5284 | `void` |
| `DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR` | Restore `DrawW_LoadPrecVECTOR` | 3e0c40 / 800c5bb4 | `void` |
| `DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache` | Restore `DrawW_SetUpSubdividFacet` | 3e0c7c / 800c5be0 | `void` |
| `Night_NightCopCalc__FP6VECTORPs` | Restore `Night_NightCopCalc` | 3e0cc2 / 800c5f18 | `void` |
| `Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache` | Restore `Night_NightCalc` | 3e0cef / 800c5fb8 | `void` |
| `DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32` | Restore `DrawW_NightColorCalc` | 3e0d35 / 800c609c | `void` |
| `DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad` | Restore `DrawW_DrawQuad` | 3e0d8d / 800c64f8 | `void` |
| `DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache` | Restore `DrawW_kCtrlWorld_High` | 3e0dd2 / 800c6e38 | `void` |
| `DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache` | Restore `DrawW_StripDraw_High` | 3e0e14 / 800c6eb8 | `void` |
| `DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry` | Restore `DrawW_DoTrough` | 3e0e55 / 800c6fa0 | `void` |
| `DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX` | Restore `DrawW_WorldSetUpMatrix` | 3e0e92 / 800c753c | `void` |
| `DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX` | Restore `DrawW_WorldSetUpTranslation` | 3e0ece / 800c75d8 | `void` |
| `DrawW_ResetAnimationTimer__Fv` | Restore `DrawW_ResetAnimationTimer` | 3e0f0c / 800c761c | `void` |
| `DrawW_GetAnimationTime__FP15Trk_AnimateInst` | Restore `DrawW_GetAnimationTime` | 3e0f37 / 800c7644 | `int` |
| `DrawW_SetAnimationTime__FP15Trk_AnimateInstPii` | Restore `DrawW_SetAnimationTime` | 3e0f70 / 800c76c8 | `void` |
| `DrawW_DoObjectAnimations__Fv` | Restore `DrawW_DoObjectAnimations` | 3e0fac / 800c7808 | `void` |
| `DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` | Restore `DrawW_BuildObjectFacets` | 3e0fd6 / 800c78a8 | `int` |
| `DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi` | Restore `DrawW_BuildCustomObjectFacets` | 3e1020 / 800c7b9c | `int` |
| `DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis` | Restore `DrawObjectTransform` | 3e1084 / 800c7ebc | `int` |
| `DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi` | Restore `DrawObjectSimple` | 3e10ef / 800c8214 | `int` |
| `DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` | Restore `DrawW_BuildChunkObjectFacets` | 3e1149 / 800c8508 | `int` |
| `ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache` | Restore `ObjectClipped` | 3e1198 / 800c8bd0 | `bool` |
| `DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry` | Restore `DrawW_DoObjects` | 3e11ed / 800c8cc4 | `void` |
| `Draw_CircleClip__FP8coorddefT0i` | Restore `Draw_CircleClip` | 3e122b / 800c903c | `int` |
| `Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark` | Restore `Draw_kCtrlSkidmark` | 3e1258 / 800c909c | `void` |
| `DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache` | Restore `DrawW_SetUpSubdividFacet_Line` | 3e1290 / 800c9620 | `void` |
| `DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache` | Restore `DrawW_OnyxLinePrim` | 3e12da / 800c98b8 | `void` |
| `DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16` | Restore `DrawW_BuildChunkCenterLineFacets` | 3e132e / 800ca0a4 | `void` |
| `DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache` | Restore `DrawW_DoLines` | 3e1392 / 800ca204 | `void` |
| `DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache` | Restore `DrawW_BuildSpikeBelt` | 3e13dc / 800ca520 | `void` |
| `DepthCue_Init__Fv` | Restore `DepthCue_Init` | 3e1420 / 800ca950 | `void` |

See `draww.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
