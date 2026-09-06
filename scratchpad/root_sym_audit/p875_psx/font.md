# P875 font.h public-header receipt

14 corrected public prototypes; 1 file-static declarations removed. All header probes compile. Initial native references: 0/15; repaired: 14/14. Return-type corrections: 1. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/font.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/font.cpp: 15/15 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `Font_TextColor__Fi` | Restore `Font_TextColor` | 3f4d88 / 800cb20c | `void` |
| `Font_TextTint__Fi` | Restore `Font_TextTint` | 3f4da8 / 800cb244 | `void` |
| `Font_SetABR__Fi` | Restore `Font_SetABR` | 3f4dc7 / 800cb264 | `void` |
| `Font_Blit__FiiPviiP12charactertbli` | Restore `Font_Blit` | 3f4de4 / 800cb2ac | `void` |
| `Font_ComputeColors__Fiiic` | Restore `Font_ComputeColors` | 3f4e14 / 800cb388 | `void` |
| `Font_textbsearch__FiPcUlUl` | Remove from public header: native STAT and local object symbol | 3f4e3b / 800cb6a0 | `charactertbl*` |
| `Font_Getcharacter__Fi` | Restore `Font_Getcharacter` | 3f4e72 / 800cb740 | `charactertbl*` |
| `Font_SetBlitter__FPFiiPviiP12charactertbli_v` | Restore `Font_SetBlitter` | 3f4ea4 / 800cb7cc | `void` |
| `Font_ReSetBlitter__Fv` | Restore `Font_ReSetBlitter` | 3f4ede / 800cb7d8 | `void` |
| `Font_SwitchFont__FPc` | Restore `Font_SwitchFont` | 3f4f01 / 800cb7ec | `void` |
| `Font_DeInit__Fv` | Restore `Font_DeInit` | 3f4f23 / 800cb858 | `void` |
| `Font_ExitFromGame__Fv` | Restore `Font_ExitFromGame` | 3f4f40 / 800cb8a8 | `void` |
| `Font_LoadFont__FPciic` | Restore `Font_LoadFont` | 3f4f63 / 800cb8bc | `int` |
| `Font_TextXY__FPcii` | Restore `Font_TextXY` | 3f4f86 / 800cba90 | `void` |
| `Font_GetUVWH__FcPiN41` | Restore `Font_GetUVWH` | 3f4fa6 / 800cbbe8 | `void` |

See `font.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
