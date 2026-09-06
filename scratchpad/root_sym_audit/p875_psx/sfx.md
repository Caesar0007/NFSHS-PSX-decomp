# P875 sfx.h public-header receipt

7 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/7; repaired: 7/7. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/sfx.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/sfx.cpp: 7/7 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Sfx_Transform__FP8coorddefP7SVECTORT0` | Restore `Sfx_Transform` | 45b502 / 800dd050 | `void` |
| `Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap` | Restore `Sfx_BuildSmokeFacet` | 45b535 / 800dd1a4 | `void` |
| `Sfx_ThickenXZ__FP7SVECTORP8coorddefN21` | Restore `Sfx_ThickenXZ` | 45b589 / 800dd370 | `void` |
| `Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2` | Restore `Sfx_BuildFastDisolveFacet` | 45b5bd / 800dd528 | `void` |
| `Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache` | Restore `Sfx_AdditivePrim` | 45b619 / 800dd598 | `void` |
| `Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle` | Restore `Sfx_BuildSouffleFacet` | 45b661 / 800dd790 | `void` |
| `Sfx_Add__FP17Souffle_tISouffle` | Restore `Sfx_Add` | 45b6ab / 800de638 | `void` |

See `sfx.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
