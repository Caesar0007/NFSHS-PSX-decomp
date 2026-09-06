# P875 fe3dmenu.h public-header receipt

3 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/3; repaired: 3/3. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/fe3dmenu.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/fe3dmenu.cpp: 3/3 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Fe3D_InitShowroom__Fv` | Restore `Fe3D_InitShowroom` | 49e715 / 80012938 | `void` |
| `CameraLookAt__FP10matrixtdefP8coorddef` | Restore `CameraLookAt` | 49e738 / 80012ae4 | `void` |
| `Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii` | Restore `Draw_MenuRenderingView` | 49e76c / 80012bf8 | `void` |

See `fe3dmenu.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
