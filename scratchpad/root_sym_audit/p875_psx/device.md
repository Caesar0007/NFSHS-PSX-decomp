# P875 device.h public-header receipt

10 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/10; repaired: 10/10. Return-type corrections: 1. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/device.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/device.cpp: 10/10 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Device_VerifyType__Fi` | Restore `Device_VerifyType` | 3a9947 / 800bd3c0 | `int` |
| `Device_Fail__Fi` | Restore `Device_Fail` | 3a996a / 800bd468 | `int` |
| `Device_Update__Fv` | Restore `Device_Update` | 3a9987 / 800bd4d8 | `void` |
| `Device_StartUp__Fv` | Restore `Device_StartUp` | 3a99a6 / 800bd5b8 | `void` |
| `Device_SetHardCodedKeys__Fv` | Restore `Device_SetHardCodedKeys` | 3a99c6 / 800bd5e0 | `void` |
| `Device_PSXPad__FUl` | Restore `Device_PSXPad` | 3a99ef / 800bd644 | `int` |
| `Device_ReadPad__FiUl` | Restore `Device_ReadPad` | 3a9a0f / 800bd6ac | `bool` |
| `Device_PSXPadMulti__FUl` | Restore `Device_PSXPadMulti` | 3a9a31 / 800bd8dc | `int` |
| `Device_Analog__FUl` | Restore `Device_Analog` | 3a9a56 / 800bd9b8 | `int` |
| `Device_Null__FUl` | Restore `Device_Null` | 3a9a76 / 800bdab8 | `int` |

See `device.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
