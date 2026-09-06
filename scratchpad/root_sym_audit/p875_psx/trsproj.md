# P875 trsproj.h public-header receipt

11 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/11; repaired: 11/11. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/trsproj.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/trsproj.cpp: 11/11 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `TrsProj_SetTransPrecision__Fi` | Restore `TrsProj_SetTransPrecision` | 47f303 / 800e192c | `void` |
| `TrsProj_ResetTransPrecision__Fv` | Restore `TrsProj_ResetTransPrecision` | 47f32e / 800e1938 | `void` |
| `TrsProj_SetProjection__Fiiii` | Restore `TrsProj_SetProjection` | 47f35b / 800e1948 | `void` |
| `TrsProj_SetMenuProjection__Fiiii` | Restore `TrsProj_SetMenuProjection` | 47f385 / 800e19c8 | `void` |
| `TrsProj_SetViewTrsProjEnviro__FP13DRender_tView` | Restore `TrsProj_SetViewTrsProjEnviro` | 47f3b3 / 800e1a08 | `void` |
| `TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef` | Restore `TrsProj_SetPsxMatrix` | 47f3f0 / 800e1a5c | `void` |
| `TrsProj_SetPsxTrans__FP8coorddef` | Restore `TrsProj_SetPsxTrans` | 47f42c / 800e1b4c | `void` |
| `TrsProj_SetPsxTransZero__Fv` | Restore `TrsProj_SetPsxTransZero` | 47f45a / 800e1b9c | `void` |
| `TrsProj_TransPt__FP8coorddefT0` | Restore `TrsProj_TransPt` | 47f483 / 800e1bcc | `void` |
| `TrsProj_TransPtN16__FP10RelCoord16P8coorddefi` | Restore `TrsProj_TransPtN16` | 47f4af / 800e1c58 | `void` |
| `TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex` | Restore `TrsProj_TransformProjectVertex` | 47f4ea / 800e1ce0 | `void` |

See `trsproj.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
