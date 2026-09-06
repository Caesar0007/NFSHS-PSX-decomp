# P875 hud.h public-header receipt

61 corrected public prototypes; 1 file-static declarations removed. All header probes compile. Initial native references: 0/62; repaired: 61/61. Return-type corrections: 1. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/hud.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/hud.cpp: 62/62 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Hud_CreateHudViews__Fv` | Restore `Hud_CreateHudViews` | 41fff1 / 800d1a80 | `void` |
| `Hud_GoTpage__Fi` | Restore `Hud_GoTpage` | 420015 / 800d1d6c | `void` |
| `Hud_DebugInfo__Fv` | Restore `Hud_DebugInfo` | 420032 / 800d1dfc | `void` |
| `Hud_DebugCrap__Fv` | Restore `Hud_DebugCrap` | 420051 / 800d1f90 | `void` |
| `Hud_BuildSprite__FP4SPRTiiiUli` | Restore `Hud_BuildSprite` | 420070 / 800d1f98 | `void` |
| `Hud_BuildSprite2__FP4SPRTiii` | Restore `Hud_BuildSprite2` | 42009c / 800d2044 | `void` |
| `Hud_FBuildSprite__FiiiUli` | Restore `Hud_FBuildSprite` | 4200c6 / 800d2070 | `void` |
| `Hud_BuildSpriteFromFont__FP4SPRTcii` | Restore `Hud_BuildSpriteFromFont` | 4200ed / 800d2104 | `void` |
| `Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl` | Restore `Hud_BuildF3` | 42011e / 800d21c4 | `void` |
| `Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl` | Restore `Hud_BuildGT4` | 420157 / 800d2288 | `void` |
| `Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` | Restore `Hud_BuildFT4` | 420192 / 800d2334 | `void` |
| `Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` | Restore `Hud_BuildMirrorFT4` | 4201ce / 800d2424 | `void` |
| `Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` | Restore `Hud_BuildMapMirrorFT4` | 420210 / 800d2528 | `void` |
| `Hud_BuildF4__FP7POLY_F4iiiiiUl` | Restore `Hud_BuildF4` | 420255 / 800d2634 | `void` |
| `Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl` | Restore `Hud_BuildG4` | 420281 / 800d26d8 | `void` |
| `Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc` | Restore `Hud_BuildF4o` | 4202b3 / 800d2794 | `void` |
| `Hud_FBuildGT4__FP13HudPmx_tShapeiiUl` | Restore `Hud_FBuildGT4` | 4202e4 / 800d2868 | `void` |
| `Hud_FBuildFT4__FP13HudPmx_tShapeiiUl` | Restore `Hud_FBuildFT4` | 420316 / 800d28f4 | `void` |
| `Hud_FBuildF4__FiiiiiUlcc` | Restore `Hud_FBuildF4` | 420348 / 800d2984 | `void` |
| `uppercase__FPc` | Remove from public header: native STAT and local object symbol | 42036e / 800d2a44 | `void` |
| `Hud_Kill__Fv` | Restore `Hud_Kill` | 42038a / 800d2aa4 | `void` |
| `Hud_Init0__Fv` | Restore `Hud_Init0` | 4203a4 / 800d2af4 | `void` |
| `Hud_InitMapFrame__Fii` | Restore `Hud_InitMapFrame` | 4203bf / 800d2b4c | `void` |
| `Hud_BuildTimeSprites__FP4SPRTPcii` | Restore `Hud_BuildTimeSprites` | 4203e2 / 800d2ef8 | `void` |
| `Hud_Init__Fv` | Restore `Hud_Init` | 420411 / 800d302c | `void` |
| `Hud_InitTables__Fv` | Restore `Hud_InitTables` | 42042b / 800d39ec | `void` |
| `Hud_BuildETimeString__FP4SPRTi` | Restore `Hud_BuildETimeString` | 42044b / 800d3a18 | `void` |
| `Hud_BuildDistanceString__FP4SPRTi` | Restore `Hud_BuildDistanceString` | 420477 / 800d3ba4 | `bool` |
| `Hud_BuildTimeString__FP4SPRTi` | Restore `Hud_BuildTimeString` | 4204a6 / 800d3d44 | `void` |
| `Hud_BuildTach__Fi` | Restore `Hud_BuildTach` | 4204d1 / 800d3e94 | `void` |
| `Hud_BuildString__FPciiiib` | Restore `Hud_BuildString` | 4204f0 / 800d42c8 | `int` |
| `Hud_BuildNumbers0__Fi` | Restore `Hud_BuildNumbers0` | 420517 / 800d4624 | `void` |
| `Hud_BuildNumbers__Fi` | Restore `Hud_BuildNumbers` | 42053a / 800d4e70 | `void` |
| `Hud_InitMap__Fv` | Restore `Hud_InitMap` | 42055c / 800d5a48 | `void` |
| `Hud_BuildMapMarkers__Fi` | Restore `Hud_BuildMapMarkers` | 420579 / 800d5ae8 | `void` |
| `Hud_WingmanFlash__Fii` | Restore `Hud_WingmanFlash` | 42059e / 800d5fb8 | `void` |
| `Hud_BuildWingmanInterface__Fi` | Restore `Hud_BuildWingmanInterface` | 4205c1 / 800d606c | `void` |
| `Hud_InitCdPlayer__Fv` | Restore `Hud_InitCdPlayer` | 4205ec / 800d63b8 | `void` |
| `Hud_BuildCdPlayer__Fii` | Restore `Hud_BuildCdPlayer` | 42060e / 800d63dc | `void` |
| `Hud_BuildRadar__Fi` | Restore `Hud_BuildRadar` | 420632 / 800d6b48 | `int` |
| `Hud_BuildReplay__Fv` | Restore `Hud_BuildReplay` | 420652 / 800d7250 | `void` |
| `Hud_NextPlayer__Fi` | Restore `Hud_NextPlayer` | 420673 / 800d754c | `int` |
| `Hud_NextPlayerNameOrCarOrTime__Fi` | Restore `Hud_NextPlayerNameOrCarOrTime` | 420693 / 800d76b0 | `char*` |
| `Hud_RenderMapView__Fv` | Restore `Hud_RenderMapView` | 4206c2 / 800d7838 | `void` |
| `Hud_BlackThinBox__Fiiii` | Restore `Hud_BlackThinBox` | 4206e5 / 800d7abc | `void` |
| `Hud_Draw321Num__Fiiiiii` | Restore `Hud_Draw321Num` | 42070a / 800d7ca8 | `void` |
| `Hud_Render321Go__Fv` | Restore `Hud_Render321Go` | 42072f / 800d7e64 | `void` |
| `BigBTCTime__Fi` | Restore `BigBTCTime` | 420750 / 800d7fb0 | `void` |
| `Hud_RenderHudView__Fv` | Restore `Hud_RenderHudView` | 42076c / 800d82d0 | `void` |
| `Hud_RenderTacView__Fv` | Restore `Hud_RenderTacView` | 42078f / 800d8c48 | `void` |
| `Hud_ParseTime__FiPc` | Restore `Hud_ParseTime` | 4207b2 / 800d8d64 | `void` |
| `Hud_RenderPauseBox__Fiiii` | Restore `Hud_RenderPauseBox` | 4207d3 / 800d8ed0 | `void` |
| `Hud_Render__Fv` | Restore `Hud_Render` | 4207fa / 800d9058 | `void` |
| `Hud_PositionMap__Fv` | Restore `Hud_PositionMap` | 420816 / 800d94c0 | `void` |
| `Hud_BTC_Update__FPcib` | Restore `Hud_BTC_Update` | 420837 / 800d95c8 | `void` |
| `Hud_BustedOverlayOn__FiPcbs` | Restore `Hud_BustedOverlayOn` | 42085a / 800d962c | `void` |
| `Hud_BustedOverlayOff__Fv` | Restore `Hud_BustedOverlayOff` | 420883 / 800d97e4 | `void` |
| `Hud_Reset__Fv` | Restore `Hud_Reset` | 4208a9 / 800d97f0 | `void` |
| `Hud_BTC_QuitOut__Fv` | Restore `Hud_BTC_QuitOut` | 4208c4 / 800d9848 | `void` |
| `Hud_BTC_BonusTime__Fl` | Restore `Hud_BTC_BonusTime` | 4208e5 / 800d990c | `void` |
| `Hud_Perp_OverlayOn__Fii` | Restore `Hud_Perp_OverlayOn` | 420908 / 800d9924 | `void` |
| `Hud_Perp_OverlayOff__Fi` | Restore `Hud_Perp_OverlayOff` | 42092d / 800d9950 | `void` |

See `hud.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
