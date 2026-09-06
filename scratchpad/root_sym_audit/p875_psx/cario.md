# P875 cario.h public-header receipt

11 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/11; repaired: 11/11. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/cario.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/cario.cpp: 11/11 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `CarIO_StartUp__Fv` | Restore `CarIO_StartUp` | 39b732 / 800bbf10 | `void` |
| `CarIO_CleanUp__Fv` | Restore `CarIO_CleanUp` | 39b751 / 800bbf7c | `void` |
| `CarIO_ReStart__Fv` | Restore `CarIO_ReStart` | 39b770 / 800bbfa4 | `void` |
| `CarIO_CopyFromShape__FPsT0iiii` | Restore `CarIO_CopyFromShape` | 39b78f / 800bbff0 | `void` |
| `CarIO_CopyToShape__FPsT0i` | Restore `CarIO_CopyToShape` | 39b7bb / 800bc1b4 | `void` |
| `CarIO_CreateLicense__FPcii` | Restore `CarIO_CreateLicense` | 39b7e2 / 800bc25c | `void` |
| `CarIO_CleanUpLicense__Fi` | Restore `CarIO_CleanUpLicense` | 39b80a / 800bc5f0 | `void` |
| `CarIO_LicenseCheck__FiPiT1P8Car_tObji` | Restore `CarIO_LicenseCheck` | 39b830 / 800bc668 | `void` |
| `CarIO_ReadInCarTextureData__FPcP8Car_tObjii` | Restore `CarIO_ReadInCarTextureData` | 39b863 / 800bc704 | `void` |
| `CarIO_UpdateCarTextureData__FPcP8Car_tObji` | Restore `CarIO_UpdateCarTextureData` | 39b89c / 800bceb0 | `void` |
| `CarIO_ReleaseCarCluts__FP8Car_tObj` | Restore `CarIO_ReleaseCarCluts` | 39b8d4 / 800bd358 | `void` |

See `cario.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
