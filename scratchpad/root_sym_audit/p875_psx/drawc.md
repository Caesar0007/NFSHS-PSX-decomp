# P875 drawc.h public-header receipt

20 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/20; repaired: 20/20. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/drawc.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/drawc.cpp: 20/20 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `ChangeTPage__FPUsi` | Restore `ChangeTPage` | 3c0dd1 / 800be6d0 | `void` |
| `DrawC_SetEnviroment__Fv` | Restore `DrawC_SetEnviroment` | 3c0df1 / 800be6e8 | `void` |
| `DrawC_ReadLightingData__Fv` | Restore `DrawC_ReadLightingData` | 3c0e16 / 800be6f0 | `void` |
| `DrawC_ReadeMapData__Fv` | Restore `DrawC_ReadeMapData` | 3c0e3e / 800be8f8 | `void` |
| `DrawC_BuildRenderingData__Fv` | Restore `DrawC_BuildRenderingData` | 3c0e62 / 800be918 | `void` |
| `DrawC_KillRenderingData__Fv` | Restore `DrawC_KillRenderingData` | 3c0e8c / 800be948 | `void` |
| `DrawC_NightHeadlight__FP8Car_tObj` | Restore `DrawC_NightHeadlight` | 3c0eb5 / 800be978 | `void` |
| `DrawC_MenuColorData__FiP8Car_tObji` | Restore `DrawC_MenuColorData` | 3c0ee4 / 800beb24 | `void` |
| `DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache` | Restore `DrawC_PrimStart` | 3c0f14 / 800bed44 | `int` |
| `DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache` | Restore `DrawC_PrimStop` | 3c0f5e / 800bfc84 | `void` |
| `DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` | Restore `DrawC_Prim` | 3c0f97 / 800bfd44 | `void` |
| `DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache` | Restore `DrawC_DividePrim` | 3c1004 / 800c12f8 | `void` |
| `DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` | Restore `DrawC_PrimClip` | 3c1056 / 800c155c | `void` |
| `DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` | Restore `DrawC_PrimMenu` | 3c10c7 / 800c32b0 | `void` |
| `DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache` | Restore `DrawC_PrimHalo` | 3c1138 / 800c3a30 | `void` |
| `DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache` | Restore `DrawC_ShadowPrim` | 3c1194 / 800c3ed8 | `void` |
| `DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache` | Restore `DrawC_DivideShadowPrim` | 3c11d4 / 800c40dc | `void` |
| `DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache` | Restore `DrawC_ShadowPrimClip` | 3c122c / 800c42c4 | `void` |
| `DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache` | Restore `DrawC_SpotPrims` | 3c1270 / 800c4800 | `void` |
| `DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache` | Restore `DrawC_ShowroomPrims` | 3c12b7 / 800c4b84 | `void` |

See `drawc.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
