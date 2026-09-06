# P875 textureprocess.h public-header receipt

16 corrected public prototypes; 0 file-static declarations removed. All header probes compile. Initial native references: 0/16; repaired: 16/16. Return-type corrections: 3. No unresolved candidate in this bounded header queue.

Native source: `C:/Temp/nfs4-clean/nfs4-f-v3.txt`. Actual source/export: `recon/game/psx/textureprocess.cpp`. 1677 source/header files scanned; zero literal consumers and zero dynamic includes. Existing source-only misses below are unrelated to this header-only change. Both before/after probes retain the pre-existing `nfs4_types.h` CurrentPlayer char-to-tPlayer conversion warning; no compiler errors.

Owning TU gate:

```text
__none__: NO ORACLE
recon/game/psx/textureprocess.cpp: 16/16 PASS
```

Before-probe source freezes the original prototype surface, making the double-mangling receipt reproducible after header repair. Its emitted references were compared to the initial real-header probe and are identical. After-probe includes the live repaired header. Both use real CPP and CC1PLPSX; no assembly rewriting.

| Native identity | Decision | Native record / VA | Return type |
| --- | --- | --- | --- |
| `TextureProcess_TransColorCheck__FPci` | Restore `TextureProcess_TransColorCheck` | 475dcf / 800e0884 | `int` |
| `TextureProcess_ColorClut__FiiPciii` | Restore `TextureProcess_ColorClut` | 475e01 / 800e08b8 | `void` |
| `TextureProcess_DepthColorCluts__FPci` | Restore `TextureProcess_DepthColorCluts` | 475e31 / 800e0ac0 | `int` |
| `Fog_CheckRange__FiP6FogKey` | Restore `Fog_CheckRange` | 475e63 / 800e0b98 | `FogKey*` |
| `Fog_FindKey__FiP6FogKey` | Restore `Fog_FindKey` | 475e94 / 800e0bec | `FogKey*` |
| `Fog_AllocKey__Fv` | Restore `Fog_AllocKey` | 475ec2 / 800e0c80 | `FogKey*` |
| `Fog_AddKey__Fii` | Restore `Fog_AddKey` | 475ee9 / 800e0ccc | `void` |
| `Fog_Update__Fi` | Restore `Fog_Update` | 475f06 / 800e0d80 | `void` |
| `Fog_MakeTrackPathName__FPc` | Restore `Fog_MakeTrackPathName` | 475f22 / 800e0ec4 | `char*` |
| `Fog_ReadFogKeys__Fv` | Restore `Fog_ReadFogKeys` | 475f4a / 800e0f14 | `int` |
| `Fog_InitFogTriggers__Fv` | Restore `Fog_InitFogTriggers` | 475f6b / 800e102c | `void` |
| `Fog_DeInitFogTriggers__Fv` | Restore `Fog_DeInitFogTriggers` | 475f90 / 800e1110 | `void` |
| `TextureProcess_Init__Fv` | Restore `TextureProcess_Init` | 475fb7 / 800e1134 | `void` |
| `CV_ProcessWorldColors_FINAL__FiP7CVECTORs` | Restore `CV_ProcessWorldColors_FINAL` | 475fdc / 800e1148 | `void` |
| `CV_ColorTracks__Fiii` | Restore `CV_ColorTracks` | 476013 / 800e1308 | `void` |
| `CV_InitColorVertices__Fv` | Restore `CV_InitColorVertices` | 476035 / 800e1510 | `void` |

See `textureprocess.json` for original/final signatures, individual emitted symbols, compiler commands, hashes, exact source definitions, and private-symbol evidence.
