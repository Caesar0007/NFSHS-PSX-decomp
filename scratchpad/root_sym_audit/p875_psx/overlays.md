# P875 overlays.h public-header receipt

5 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/5; repaired: 5/5. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/overlays.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/overlays.cpp: 5/5 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `OptionsBarThing__Fiiii` | Restore `OptionsBarThing` | 42de4c / 800d9968 | `void` |
| `RaceSummary__Fv` | Restore `RaceSummary` | 42de70 / 800d9a48 | `void` |
| `RaceStatistics__Fv` | Restore `RaceStatistics` | 42de8d / 800d9fbc | `void` |
| `Hud_BTCStats__Fsb` | Restore `Hud_BTCStats` | 42dead / 800da728 | `void` |
| `Hud_RenderStatsView__Fv` | Restore `Hud_RenderStatsView` | 42decc / 800dae8c | `void` |

See `overlays.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
