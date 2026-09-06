# P875 psxcontroller.h public-header receipt

4 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/4; repaired: 4/4. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/psxcontroller.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/psxcontroller.cpp: 4/4 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `InGame_ResetPSXController__Fii` | Restore `InGame_ResetPSXController` | 4547ea / 800dc4cc | `void` |
| `InGame_GetPSXPadValue__Fii` | Restore `InGame_GetPSXPadValue` | 454816 / 800dc990 | `int` |
| `InGame_GetDevice__Fi` | Restore `InGame_GetDevice` | 45483e / 800dcd34 | `int` |
| `InGame_SetRamp__Fv` | Restore `InGame_SetRamp` | 454860 / 800dcd3c | `void` |

See `psxcontroller.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
