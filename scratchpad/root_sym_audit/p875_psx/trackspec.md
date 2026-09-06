# P875 trackspec.h public-header receipt

5 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/5; repaired: 5/5. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/trackspec.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/trackspec.cpp: 5/5 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `TrackSpec_SetDefault__FP10CTrackSpec` | Restore `TrackSpec_SetDefault` | 47a55f / 800e1544 | `void` |
| `TrackSpec_SetUp__Fv` | Restore `TrackSpec_SetUp` | 47a591 / 800e177c | `void` |
| `read__FPPcPvi` | Restore `read` | 47a5b2 / 800e17a0 | `void` |
| `TrackSpec_Read__Fi` | Restore `TrackSpec_Read` | 47a5cd / 800e17d0 | `void` |
| `TrackSpec_Load__Fii` | Restore `TrackSpec_Load` | 47a5ed / 800e18cc | `void` |

See `trackspec.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
