# P875 hrzsku.h public-header receipt

22 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/22; repaired: 22/22. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/hrzsku.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/hrzsku.cpp: 22/22 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii` | Restore `Horizon_InterpolateLineSCoords` | 40d7e5 / 800cf574 | `void` |
| `Sky_InitStars__Fv` | Restore `Sky_InitStars` | 40d824 / 800cf6b4 | `void` |
| `Sky_KillStars__Fv` | Restore `Sky_KillStars` | 40d843 / 800cf89c | `void` |
| `Hrz_InitSkyColor__Fv` | Restore `Hrz_InitSkyColor` | 40d862 / 800cf8e0 | `void` |
| `Hrz_InitSky__Fv` | Restore `Hrz_InitSky` | 40d884 / 800cfa3c | `void` |
| `Hrz_Init2DRing__Fv` | Restore `Hrz_Init2DRing` | 40d8a1 / 800cfd80 | `void` |
| `Hrz_GetHorizonPixMap__FP12Draw_tPixMap` | Restore `Hrz_GetHorizonPixMap` | 40d8c1 / 800d0064 | `void` |
| `Hrz_InitHorizon__Fv` | Restore `Hrz_InitHorizon` | 40d8f5 / 800d0118 | `void` |
| `Hrz_KillHorizon__Fv` | Restore `Hrz_KillHorizon` | 40d916 / 800d0184 | `void` |
| `Hrz_LightningAddFork__FScScSc` | Restore `Hrz_LightningAddFork` | 40d937 / 800d01b0 | `void` |
| `Hrz_CalculateLightning__Fv` | Restore `Hrz_CalculateLightning` | 40d962 / 800d03c8 | `void` |
| `Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache` | Restore `Hrz_TextureQuad` | 40d98a / 800d0404 | `void` |
| `Hrz_SetLightingPosInSky__FP13DRender_tView` | Restore `Hrz_SetLightingPosInSky` | 40d9c3 / 800d0534 | `void` |
| `Hrz_BuildForkLightning__FP11Draw_DCache` | Restore `Hrz_BuildForkLightning` | 40d9fb / 800d0644 | `void` |
| `Hrz_LightningFlicker__Fi` | Restore `Hrz_LightningFlicker` | 40da30 / 800d0760 | `void` |
| `HrzSetPsxMatrix__FP10matrixtdef` | Restore `HrzSetPsxMatrix` | 40da56 / 800d083c | `void` |
| `HrzSetPsxTranslation__FP8coorddef` | Restore `HrzSetPsxTranslation` | 40da83 / 800d091c | `void` |
| `Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR` | Restore `Hrz_RotProj16` | 40dab2 / 800d096c | `void` |
| `Hrz_SetDitheringPrim__Fii` | Restore `Hrz_SetDitheringPrim` | 40dae5 / 800d09b0 | `void` |
| `Hrz_BuildSky__Fv` | Restore `Hrz_BuildSky` | 40db0c / 800d0a38 | `void` |
| `Sky_RenderStars__FP13Draw_SkyCachei` | Restore `Sky_RenderStars` | 40db2a / 800d1160 | `void` |
| `Hrz_BuildHorizon__FP13DRender_tView` | Restore `Hrz_BuildHorizon` | 40db5b / 800d131c | `void` |

See `hrzsku.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
