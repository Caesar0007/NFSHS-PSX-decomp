# P875 draw.h public-header receipt

25 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/25; repaired: 25/25. Return-type corrections: 1. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/draw.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/draw.cpp: 25/25 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Draw_SetView__Fiiiiiiiii` | Restore `Draw_SetView` | 3adde5 / 800bdac0 | `int` |
| `Draw_InitViews__Fv` | Restore `Draw_InitViews` | 3ade0b / 800bdbd4 | `void` |
| `Draw_InitViewOT__Fv` | Restore `Draw_InitViewOT` | 3ade2b / 800bdbe0 | `void` |
| `Draw_InitViewOTInGame__Fv` | Restore `Draw_InitViewOTInGame` | 3ade4c / 800bdc64 | `void` |
| `Draw_DeInitViews__Fv` | Restore `Draw_DeInitViews` | 3ade73 / 800bdce0 | `void` |
| `Draw_DeInitViewsInGame__Fv` | Restore `Draw_DeInitViewsInGame` | 3ade95 / 800bdd68 | `void` |
| `Draw_GetDRAWENV__Fii` | Restore `Draw_GetDRAWENV` | 3adebd / 800bdd9c | `DRAWENV*` |
| `Draw_SetViewMemBudget__Fii` | Restore `Draw_SetViewMemBudget` | 3adee9 / 800bddd8 | `void` |
| `Draw_SetViewColor__Fiiii` | Restore `Draw_SetViewColor` | 3adf11 / 800bde00 | `void` |
| `AllocatePrimitivesBuffer__Fv` | Restore `AllocatePrimitivesBuffer` | 3adf37 / 800bde60 | `void` |
| `ClearPrimitivesBuffer__Fv` | Restore `ClearPrimitivesBuffer` | 3adf61 / 800bdf9c | `void` |
| `ClearPlatformPrimitivesBuffer__Fv` | Restore `ClearPlatformPrimitivesBuffer` | 3adf88 / 800be004 | `void` |
| `Draw_StartRenderingView__Fi` | Restore `Draw_StartRenderingView` | 3adfb7 / 800be060 | `void` |
| `Draw_StopRenderingView__Fi` | Restore `Draw_StopRenderingView` | 3adfe0 / 800be118 | `void` |
| `Draw_CheckFirstFrameRender__Fv` | Restore `Draw_CheckFirstFrameRender` | 3ae008 / 800be230 | `void` |
| `Draw_StartFrameRender__Fv` | Restore `Draw_StartFrameRender` | 3ae034 / 800be2c0 | `void` |
| `Draw_SetDrawSyncCallback__FPFv_v` | Restore `Draw_SetDrawSyncCallback` | 3ae05b / 800be360 | `void` |
| `Draw_StopFrameRender__Fv` | Restore `Draw_StopFrameRender` | 3ae089 / 800be36c | `void` |
| `Draw_DrawDirectScreen__FP8shapetblii` | Restore `Draw_DrawDirectScreen` | 3ae0af / 800be450 | `void` |
| `Draw_DirectSetEnvironment__Fiiiiiiiiii` | Restore `Draw_DirectSetEnvironment` | 3ae0e1 / 800be478 | `void` |
| `Draw_SetEnvironment__Fiiiiiiii` | Restore `Draw_SetEnvironment` | 3ae115 / 800be57c | `void` |
| `Draw_InitRenderEngine__Fiiiiii` | Restore `Draw_InitRenderEngine` | 3ae141 / 800be5d8 | `void` |
| `Draw_RestartRenderEngine__Fv` | Restore `Draw_RestartRenderEngine` | 3ae16d / 800be67c | `void` |
| `Draw_DeInitRenderEngine__Fv` | Restore `Draw_DeInitRenderEngine` | 3ae197 / 800be684 | `void` |
| `Draw_InitLibRender__Fv` | Restore `Draw_InitLibRender` | 3ae1c0 / 800be6a8 | `void` |

See `draw.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
