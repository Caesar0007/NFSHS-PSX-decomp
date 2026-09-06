# P875 platform.h public-header receipt

8 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/8; repaired: 8/8. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/platform.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/platform.cpp: 8/8 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Platform_InitMemory__Fv` | Restore `Platform_InitMemory` | 447bc1 / 800dc2b8 | `void` |
| `Platform_ReserveMemory__FiPc` | Restore `Platform_ReserveMemory` | 447be6 / 800dc2e8 | `char*` |
| `Platform_TempReserveMemory__FiPc` | Restore `Platform_TempReserveMemory` | 447c10 / 800dc334 | `char*` |
| `Platform_SysStartUp__Fv` | Restore `Platform_SysStartUp` | 447c3e / 800dc378 | `void` |
| `Platform_DebuggerPollHost__Fv` | Restore `Platform_DebuggerPollHost` | 447c63 / 800dc450 | `void` |
| `nfs2eacinit__Fv` | Restore `nfs2eacinit` | 447c8e / 800dc458 | `void` |
| `Platform_ResetDCTBuffer__Fv` | Restore `Platform_ResetDCTBuffer` | 447cab / 800dc4a0 | `void` |
| `Platform_GetDCTBuffer__FiPc` | Restore `Platform_GetDCTBuffer` | 447cd4 / 800dc4b4 | `char*` |

See `platform.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
