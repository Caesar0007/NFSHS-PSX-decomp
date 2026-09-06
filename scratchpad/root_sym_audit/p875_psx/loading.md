# P875 loading.h public-header receipt

3 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/3; repaired: 3/3. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/loading.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/loading.cpp: 3/3 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Loading_DrawLoadingScreen__Fv` | Restore `Loading_DrawLoadingScreen` | 4312e4 / 800db0b8 | `void` |
| `Loading_UpdateLoadingScreen__Fi` | Restore `Loading_UpdateLoadingScreen` | 43130f / 800db200 | `void` |
| `Loading_GetInitialMemory__Fv` | Restore `Loading_GetInitialMemory` | 43133c / 800db2f8 | `void` |

See `loading.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
