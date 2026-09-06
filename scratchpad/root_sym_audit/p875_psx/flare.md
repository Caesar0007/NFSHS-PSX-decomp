# P875 flare.h public-header receipt

27 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/27; repaired: 27/27. Return-type corrections: 0. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/flare.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/flare.cpp: 27/27 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Flare_Tri__FPlN20i` | Restore `Flare_Tri` | 402840 / 800cbcb0 | `void` |
| `Flare_SetMatrix__FP10matrixtdef` | Restore `Flare_SetMatrix` | 402860 / 800cbd4c | `void` |
| `Flare_IdentMatrix__FP6MATRIX` | Restore `Flare_IdentMatrix` | 40288d / 800cbdf8 | `void` |
| `Flare_OctFlare__FPli` | Restore `Flare_OctFlare` | 4028b7 / 800cbe14 | `void` |
| `Flare_OctFlareSpikes__FPli` | Restore `Flare_OctFlareSpikes` | 4028d9 / 800cc034 | `void` |
| `Flare_Spikes__FPli` | Restore `Flare_Spikes` | 402901 / 800cc3b8 | `void` |
| `Flare_HexFlare__FPli` | Restore `Flare_HexFlare` | 402921 / 800cc694 | `void` |
| `Flare_ReflectHexFlare__FPli` | Restore `Flare_ReflectHexFlare` | 402943 / 800cc868 | `void` |
| `Flare_QuadFlare__FPli` | Restore `Flare_QuadFlare` | 40296c / 800cca3c | `void` |
| `Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache` | Restore `Flare_CarShapedHalo` | 40298f / 800ccb58 | `void` |
| `Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache` | Restore `Flare_Halo2` | 4029d4 / 800cd530 | `void` |
| `Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache` | Restore `Flare_Halo` | 402a20 / 800cde9c | `void` |
| `Flare_2DSpike__FPlT0i` | Restore `Flare_2DSpike` | 402a69 / 800cdec4 | `void` |
| `Flare_2DHalo__Fiiiii` | Restore `Flare_2DHalo` | 402a8c / 800cdf70 | `void` |
| `Flare_PreCalcHexLightBeam__FPli` | Restore `Flare_PreCalcHexLightBeam` | 402aae / 800ce34c | `void` |
| `Flare_Quad__FPlP7CVECTORi` | Restore `Flare_Quad` | 402adb / 800ce420 | `void` |
| `Flare_QuadNotTransparent__FPlP7CVECTORi` | Restore `Flare_QuadNotTransparent` | 402b02 / 800ce4c4 | `void` |
| `Flare_QuadRing__FPlP7CVECTORi` | Restore `Flare_QuadRing` | 402b37 / 800ce568 | `void` |
| `Flare_TextureQuad__FPlP7CVECTORci` | Restore `Flare_TextureQuad` | 402b62 / 800ce61c | `void` |
| `Flare_SingleColorTex__FP7DVECTORP7CVECTORiici` | Restore `Flare_SingleColorTex` | 402b91 / 800ce6f8 | `void` |
| `Flare_SingleColorHex__FP7DVECTORP7CVECTORiii` | Restore `Flare_SingleColorHex` | 402bcc / 800ce79c | `void` |
| `Flare_SingleColorOct__FP7DVECTORP7CVECTORiii` | Restore `Flare_SingleColorOct` | 402c06 / 800ce8b0 | `void` |
| `Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii` | Restore `Flare_SingleColorOctRing` | 402c40 / 800ce988 | `void` |
| `Flare_InitLensFlare__Fv` | Restore `Flare_InitLensFlare` | 402c7e / 800ceb44 | `void` |
| `Flare_LensFlare__FP7DVECTORP15Draw_FlareCache` | Restore `Flare_LensFlare` | 402ca3 / 800ceb6c | `void` |
| `Flare_Sun__FP7SVECTORP15Draw_FlareCache` | Restore `Flare_Sun` | 402cde / 800cf1d0 | `void` |
| `Flare_Moon__FP7SVECTORP15Draw_FlareCache` | Restore `Flare_Moon` | 402d13 / 800cf4bc | `void` |

See `flare.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
