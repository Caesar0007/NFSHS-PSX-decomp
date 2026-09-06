# P875 night.h public-header receipt

19 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/19; repaired: 19/19. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/night.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/night.cpp: 18/19 PASS
     56  Night_CreateNightTableElement__FiliPUc
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Night_FindClosestColor__FG7CVECTORPi` | Restore `Night_FindClosestColor` | 43b827 / 800db318 | `int` |
| `Night_CreateNightTableElement__FiliPUc` | Restore `Night_CreateNightTableElement` | 43b859 / 800db3e0 | `void` |
| `Night_CreateNightTable__FiliPA256_A16_Uc` | Restore `Night_CreateNightTable` | 43b88d / 800db5a4 | `void` |
| `Night_GenerateNextLightningEvent__Fv` | Restore `Night_GenerateNextLightningEvent` | 43b8c3 / 800db5cc | `void` |
| `Night_PauseLightningEffect__Fi` | Restore `Night_PauseLightningEffect` | 43b8f5 / 800db640 | `void` |
| `Night_DoLightningEffect__FP13DRender_tView` | Restore `Night_DoLightningEffect` | 43b921 / 800db6c4 | `void` |
| `Night_SetCopColor__FP18GameSetup_tCarData` | Restore `Night_SetCopColor` | 43b959 / 800db848 | `void` |
| `Night_InitPlayerHeadLightColor__Fi` | Restore `Night_InitPlayerHeadLightColor` | 43b990 / 800db8dc | `void` |
| `Night_SetPlayerHeadLightColor__Fiii` | Restore `Night_SetPlayerHeadLightColor` | 43b9c0 / 800db938 | `void` |
| `Night_InitCopLightColors__Fv` | Restore `Night_InitCopLightColors` | 43b9f1 / 800db974 | `void` |
| `Night_SetCopLightColors__Fii` | Restore `Night_SetCopLightColors` | 43ba1b / 800db9d0 | `void` |
| `Night_InitWeatherTables__Fv` | Restore `Night_InitWeatherTables` | 43ba45 / 800dba50 | `void` |
| `Night_SetWeatherColors__Fi` | Restore `Night_SetWeatherColors` | 43ba6e / 800dbad4 | `void` |
| `Night_GenerateAllLightTables__Fv` | Restore `Night_GenerateAllLightTables` | 43ba96 / 800dbb50 | `void` |
| `Night_InitNightDriving__Fv` | Restore `Night_InitNightDriving` | 43bac4 / 800dbde4 | `void` |
| `Night_KillNightDriving__Fv` | Restore `Night_KillNightDriving` | 43baec / 800dbf80 | `void` |
| `Night_RestartNightDriving__Fv` | Restore `Night_RestartNightDriving` | 43bb14 / 800dc020 | `void` |
| `Night_SetEnviroment__FP13DRender_tView` | Restore `Night_SetEnviroment` | 43bb3f / 800dc0a8 | `void` |
| `Night_AdditiveNightCalc__FP6VECTORP7CVECTOR` | Restore `Night_AdditiveNightCalc` | 43bb73 / 800dc1b8 | `void` |

See `night.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
