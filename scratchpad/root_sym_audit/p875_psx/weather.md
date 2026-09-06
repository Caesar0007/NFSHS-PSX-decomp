# P875 weather.h public-header receipt

25 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/25; repaired: 25/25. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/weather.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/weather.cpp: 24/25 PASS
     12  Weather_Init__Fv
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Weather_GetNumParticles__Fi` | Restore `Weather_GetNumParticles` | 486ee5 / 800e1dc0 | `int` |
| `Weather_SetMatrix__FP10matrixtdef` | Restore `Weather_SetMatrix` | 486f0e / 800e1dd0 | `void` |
| `Weather_SetIdentMatrix__Fv` | Restore `Weather_SetIdentMatrix` | 486f3d / 800e1e94 | `void` |
| `Weather_InitSnow__Fv` | Restore `Weather_InitSnow` | 486f65 / 800e1f18 | `void` |
| `Weather_InitRain__Fv` | Restore `Weather_InitRain` | 486f87 / 800e1f78 | `void` |
| `Weather_InitSplats__Fv` | Restore `Weather_InitSplats` | 486fa9 / 800e1fd8 | `void` |
| `Weather_GetNewState__Fv` | Restore `Weather_GetNewState` | 486fcd / 800e20ec | `int` |
| `Weather_ChangeDensityState__Fv` | Restore `Weather_ChangeDensityState` | 486ff2 / 800e212c | `void` |
| `Weather_ChangeIntensityState__Fv` | Restore `Weather_ChangeIntensityState` | 48701e / 800e21a0 | `void` |
| `Weather_ChangeDensityBasedOnTime__Fv` | Restore `Weather_ChangeDensityBasedOnTime` | 48704c / 800e2218 | `void` |
| `Weather_ChangeIntensityBasedOnTime__Fv` | Restore `Weather_ChangeIntensityBasedOnTime` | 48707e / 800e22f0 | `void` |
| `Weather_InitStateControls__Fv` | Restore `Weather_InitStateControls` | 4870b2 / 800e23e8 | `void` |
| `Weather_Restart__Fv` | Restore `Weather_Restart` | 4870dd / 800e24b4 | `void` |
| `Weather_Init__Fv` | Restore `Weather_Init` | 4870fe / 800e2530 | `void` |
| `Weather_DeInit__Fv` | Restore `Weather_DeInit` | 48711c / 800e287c | `void` |
| `Weather_TransformVertex__FP10matrixtdefiP7SVECTOR` | Restore `Weather_TransformVertex` | 48713c / 800e2910 | `void` |
| `Weather_CheckAndResetParticles__FP7SVECTOR` | Restore `Weather_CheckAndResetParticles` | 48717b / 800e29d4 | `short` |
| `Weather_QuickReOrthogonalize__FP10matrixtdefT0` | Restore `Weather_QuickReOrthogonalize` | 4871b3 / 800e2d50 | `void` |
| `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc` | Restore `Weather_ProcessParticles` | 4871ef / 800e2fd0 | `void` |
| `Weather_CreateSnow__FP7SVECTOR` | Restore `Weather_CreateSnow` | 487234 / 800e33bc | `void` |
| `Weather_CreateRain__FP7SVECTORP7DVECTORPc` | Restore `Weather_CreateRain` | 487260 / 800e356c | `void` |
| `Weather_CreateSplat__FP18Weather_tSplatInfo` | Restore `Weather_CreateSplat` | 487297 / 800e3730 | `void` |
| `Weather_DoSplats__FiP18Weather_tSplatInfo` | Restore `Weather_DoSplats` | 4872d0 / 800e3858 | `void` |
| `Weather_DoWeather__FP13DRender_tView` | Restore `Weather_DoWeather` | 487307 / 800e3a1c | `void` |
| `Weather_BuildWeather__FP13DRender_tView` | Restore `Weather_BuildWeather` | 487339 / 800e3d30 | `void` |

See `weather.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
