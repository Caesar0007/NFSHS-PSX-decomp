# P875 skidmark.h public-header receipt

11 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/11; repaired: 11/11. Return-type corrections: 1. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/skidmark.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/skidmark.cpp: 11/11 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i` | Restore `CalcStartSegment` | 465f70 / 800de6f4 | `void` |
| `CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i` | Restore `CalcOneSegment` | 465fb4 / 800de8c4 | `void` |
| `Skidmark_CheckChunk__FP8coorddefii` | Restore `Skidmark_CheckChunk` | 465ff4 / 800de9ec | `Skidmark_Chunk*` |
| `Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii` | Restore `Skidmark_Add` | 466035 / 800deb98 | `void` |
| `Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii` | Restore `Skidmark_AddStretch` | 46606f / 800def6c | `void` |
| `Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii` | Restore `Skidmark_Stretch` | 4660c6 / 800df308 | `void` |
| `Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii` | Restore `Skidmark_EndStretch` | 466117 / 800df388 | `void` |
| `Skidmark_OnyxBuildFacets__FP13DRender_tView` | Restore `Skidmark_OnyxBuildFacets` | 46616b / 800df464 | `void` |
| `Skidmark_InitSkidmark__Fv` | Restore `Skidmark_InitSkidmark` | 4661a4 / 800df504 | `void` |
| `Skidmark_RestartSkidmark__Fv` | Restore `Skidmark_RestartSkidmark` | 4661cb / 800df578 | `void` |
| `Skidmark_KillSkidmark__Fv` | Restore `Skidmark_KillSkidmark` | 4661f5 / 800df58c | `void` |

See `skidmark.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
