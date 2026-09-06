# P875 audio.h public-header receipt

6 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/6; repaired: 6/6. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/audio.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/audio.cpp: 6/6 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Audio_InitDriver__Fii` | Restore `Audio_InitDriver` | 392096 / 800bbb84 | `void` |
| `Audio_DeInitDriver__Fv` | Restore `Audio_DeInitDriver` | 3920b9 / 800bbc64 | `void` |
| `Audio_CleanUp__Fv` | Restore `Audio_CleanUp` | 3920dd / 800bbcc0 | `void` |
| `Audio_FECleanUp__Fv` | Restore `Audio_FECleanUp` | 3920fc / 800bbd1c | `void` |
| `AudioCmn_AddBank__FPciT0i` | Restore `AudioCmn_AddBank` | 39211d / 800bbd64 | `int` |
| `AudioCmn_LoadBank__FPci` | Restore `AudioCmn_LoadBank` | 392144 / 800bbe8c | `int` |

See `audio.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
