# P875 texture.h public-header receipt

24 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/24; repaired: 24/24. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/texture.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/texture.cpp: 24/24 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Texture_InitPaletteSharing__Fv` | Restore `Texture_InitPaletteSharing` | 46ae2c / 800df5b4 | `void` |
| `Texture_DeInitPaletteSharing__Fv` | Restore `Texture_DeInitPaletteSharing` | 46ae58 / 800df630 | `void` |
| `Texture_ResetPaletteSharing__Fv` | Restore `Texture_ResetPaletteSharing` | 46ae86 / 800df678 | `void` |
| `Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi` | Restore `Texture_CheckForSharedPalette` | 46aeb3 / 800df688 | `int` |
| `Texture_AddSharedPalette__FPcP12Draw_tPixMapi` | Restore `Texture_AddSharedPalette` | 46aef4 / 800df7bc | `void` |
| `Texture_InitClut__Fv` | Restore `Texture_InitClut` | 46af2f / 800df834 | `void` |
| `Texture_GetClutId__FiPiT1` | Restore `Texture_GetClutId` | 46af51 / 800df938 | `void` |
| `Texture_MenuReleaseClutId__Fs` | Restore `Texture_MenuReleaseClutId` | 46af78 / 800df9a4 | `void` |
| `Texture_ColorCarPalette__FPcT0i` | Restore `Texture_ColorCarPalette` | 46afa3 / 800dfa04 | `void` |
| `Texture_CopyPalette__FPciii` | Restore `Texture_CopyPalette` | 46afd0 / 800dfa3c | `void` |
| `Texture_ProcessPaletteCopy__FP15Texture_pal8bitii` | Restore `Texture_ProcessPaletteCopy` | 46aff9 / 800dfa9c | `void` |
| `Texture_LoadImage__FP4RECTPUl` | Restore `Texture_LoadImage` | 46b038 / 800dfb48 | `void` |
| `Texture_Vramf__FP8shapetbliiii` | Restore `Texture_Vramf` | 46b063 / 800dfb8c | `void` |
| `Texture_Vramcf__FP8shapetbliiii` | Restore `Texture_Vramcf` | 46b08f / 800dfd38 | `void` |
| `Texture_GetTranslucencyMode__FP8shapetbl` | Restore `Texture_GetTranslucencyMode` | 46b0bc / 800dfea0 | `int` |
| `Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap` | Restore `Texture_LoadPmx` | 46b0f2 / 800dff18 | `void` |
| `Texture_CloneUVPmx__FP12Draw_tPixMapiT0` | Restore `Texture_CloneUVPmx` | 46b12a / 800e0358 | `void` |
| `Texture_InitTrackTexture__Fv` | Restore `Texture_InitTrackTexture` | 46b15f / 800e04b8 | `void` |
| `Texture_InitMenuClut__Fv` | Restore `Texture_InitMenuClut` | 46b189 / 800e0510 | `void` |
| `Texture_InitMenuTexture__Fv` | Restore `Texture_InitMenuTexture` | 46b1af / 800e0610 | `void` |
| `Texture_CleanupMenuTexture__Fv` | Restore `Texture_CleanupMenuTexture` | 46b1d8 / 800e0638 | `void` |
| `Texture_LoadMenuTexture__Fv` | Restore `Texture_LoadMenuTexture` | 46b204 / 800e0698 | `void` |
| `Texture_KillTrackTexture__Fv` | Restore `Texture_KillTrackTexture` | 46b22d / 800e084c | `void` |
| `Texture_KillMenuTexture__Fv` | Restore `Texture_KillMenuTexture` | 46b257 / 800e0854 | `void` |

See `texture.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
