# P875 force.h public-header receipt

9 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/9; repaired: 9/9. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/force.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/force.cpp: 9/9 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Force_Vbl__Fv` | Restore `Force_Vbl` | 3f1520 / 800ca998 | `void` |
| `Force_Update__FP8Car_tObj` | Restore `Force_Update` | 3f153b / 800cabc0 | `void` |
| `Force_StartUp__Fv` | Restore `Force_StartUp` | 3f1562 / 800cb018 | `void` |
| `Force_Disable__Fv` | Restore `Force_Disable` | 3f1581 / 800cb0e4 | `void` |
| `Force_IsForceOn__FP8Car_tObj` | Restore `Force_IsForceOn` | 3f15a0 / 800cb158 | `int` |
| `Force_Pause__Fv` | Restore `Force_Pause` | 3f15ca / 800cb1b4 | `void` |
| `Force_UnPause__Fv` | Restore `Force_UnPause` | 3f15e7 / 800cb1f4 | `void` |
| `Force_HitSign__FP8Car_tObj` | Restore `Force_HitSign` | 3f1606 / 800cb1fc | `void` |
| `Force_HitWall__Fi` | Restore `Force_HitWall` | 3f162e / 800cb204 | `void` |

See `force.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
