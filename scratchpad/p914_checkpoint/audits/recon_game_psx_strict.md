# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-decomp\recon\game\psx`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

Strict source-identity mode: matching-only local/global/split-array
carrier annotations do not suppress missing, extra, or array-shape
findings. Carrier receipt categories remain listed for review, not
as original-name proof. Optimized/inline, ABI, canonical, host-only
and explicit type-override categories retain their separate rules
and still require their own evidence. This is not an SLD, foreign
header-interface, source-token, or complete runtime-layout seal.

## Summary

- SYM functions in target TUs: 395
- Mapped to reconstructed definitions: 395 (395 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 0
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 258
- Missing SYM names: 14
- Extra source-local names: 395
- Type-comparison findings: 0
- Recognized ABI/debug-equivalent type encodings: 14
  (c-struct-tag=1, char-debug-signedness=7, generic-function-pointer=2, promoted-stack-argument=4)
- Function storage-class findings: 0
- Implicit aggregate special members (source body correctly absent): 0
- Explicit oracle-receipted carrier mappings: 0
- Explicit restored inline-local mappings: 0
- Explicit restored macro-local mappings: 3
- Explicit compact static-local mappings: 1
- Exact cross-build/canonical name recoveries: 0
- Explicit linkage-proven ABI parameters omitted from SYM: 0
- Explicit source-only codegen carriers: 393
- Explicit oracle-proven function type overrides: 0
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 302
- Compact address-only data records mapped by exact name+VA: 186
- Mapped source global definitions: 251
- Special SYM vtable records mapped: 0/0
- Blob-backed object globals: 51
- Missing/extra global definitions: 0/0
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 0
- Global type findings: 1
- Recognized global debug-equivalent types: 3
  (explicit-signed-char=1, generic-function-pointer=2)
- Explicit measured global array carriers: 0
- Explicit source-only global/data-layout carriers: 0
- Explicit host-only fallback globals: 0
- Explicit linker-folded shared common globals: 0
- Explicit oracle-proven global type overrides: 0

## Review queue

### `CarIO_CopyToShape__FPsT0i` (0x800bc1b4, cario.cpp:244, map=exact)

- Extra source locals: `n0`, `n1`, `n2`, `n3`

### `CarIO_CreateLicense__FPcii` (0x800bc25c, cario.cpp:625, map=exact)

- Extra source locals: `p1`, `p2`, `q1`, `q2`, `r1`, `r2`

### `CarIO_CleanUpLicense__Fi` (0x800bc5f0, cario.cpp:795, map=exact)

- Extra source locals: `plateShape`, `plateSlot`

### `CarIO_LicenseCheck__FiPiT1P8Car_tObji` (0x800bc668, cario.cpp:817, map=exact)

- Extra source locals: `new_sfx_vx`, `new_sfx_vy`

### `CarIO_UpdateCarTextureData__FPcP8Car_tObji` (0x800bceb0, cario.cpp:1410, map=exact)

- Extra source locals: `pmx`

### `Device_Update__Fv` (0x800bd4d8, device.cpp:125, map=exact)

- Extra source locals: `commMode`

### `Draw_SetView__Fiiiiiiiii` (0x800bdac0, draw.cpp:57, map=exact)

- Extra source locals: `viewIndex`

### `Draw_InitViewOT__Fv` (0x800bdbe0, draw.cpp:100, map=exact)

- Extra source locals: `view`

### `Draw_InitViewOTInGame__Fv` (0x800bdc64, draw.cpp:129, map=exact)

- Extra source locals: `view`

### `Draw_DeInitViews__Fv` (0x800bdce0, draw.cpp:154, map=exact)

- Extra source locals: `view`

### `Draw_DeInitViewsInGame__Fv` (0x800bdd68, draw.cpp:188, map=exact)

- Extra source locals: `numViews`, `view`

### `Draw_StartRenderingView__Fi` (0x800be060, draw.cpp:347, map=exact)

- Extra source locals: `midGroundOtzNumerator`

### `Draw_StopRenderingView__Fi` (0x800be118, draw.cpp:405, map=exact)

- Extra source locals: `pal`

### `Draw_StartFrameRender__Fv` (0x800be2c0, draw.cpp:486, map=exact)

- Extra source locals: `view`

### `Draw_StopFrameRender__Fv` (0x800be36c, draw.cpp:551, map=exact)

- Extra source locals: `view`

### `DrawC_ReadLightingData__Fv` (0x800be6f0, drawc.cpp:174, map=exact)

- Extra source locals: `trk`

### `DrawC_NightHeadlight__FP8Car_tObj` (0x800be978, drawc.cpp:244, map=exact)

- Extra source locals: `h0`, `h1`, `h2`, `lightSlotView`

### `DrawC_MenuColorData__FiP8Car_tObji` (0x800beb24, drawc.cpp:533, map=exact)

- Extra source locals: `menuColorSlot`

### `DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache` (0x800bed44, drawc.cpp:651, map=exact)

- Extra source locals: `byteOffset`, `ctd`, `envMapOffset`, `envShift`, `ev`, `evraw`, `pos`, `pz`, `sort_carObj`, `tunnelFlag`

### `DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` (0x800bfd44, drawc.cpp:1616, map=exact)

- Extra source locals: `envmapUV_dst`, `facetValue`, `ff`, `hi`, `overlayRaw`

### `DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` (0x800c155c, drawc.cpp:3172, map=exact)

- Extra source locals: `envmapUV_dst`, `facetValue`, `ff`, `hi`, `midUv01`, `midUv12`, `midUv20`, `midVt01`, `midVt12`, `midVt20`, `overlayRaw`, `uvk`

### `DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` (0x800c32b0, drawc.cpp:4331, map=exact)

- Extra source locals: `facetMask`, `tex`

### `DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache` (0x800c3a30, drawc.cpp:4814, map=exact)

- Extra source locals: `flareType`, `ov`, `ovs`

### `DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache` (0x800c3ed8, drawc.cpp:5120, map=exact)

- Extra source locals: `otp`

### `DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache` (0x800c40dc, drawc.cpp:5190, map=exact)

- Extra source locals: `color`, `otp`

### `DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache` (0x800c4800, drawc.cpp:5404, map=exact)

- Extra source locals: `color`, `drawMode`, `otEntry`

### `DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache` (0x800c4b84, drawc.cpp:5534, map=exact)

- Extra source locals: `hs`, `m1`, `z1`

### `DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31` (0x800c51fc, draww.cpp:419, map=exact)

- Extra source locals: `minz`

### `DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss` (0x800c5284, draww.cpp:516, map=exact)

- Extra source locals: `n0`, `q`, `q1`, `q2`, `t4`

### `Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache` (0x800c5fb8, draww.cpp:1268, map=exact)

- Extra source locals: `lt`

### `DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32` (0x800c609c, draww.cpp:1355, map=exact)

- Missing SYM names: `tempcop`, `tempnight`

### `DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad` (0x800c64f8, draww.cpp:1493, map=exact)

- Extra source locals: `depth_avg`, `primPtr`, `ta`, `tb`, `tc`

### `DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache` (0x800c6e38, draww.cpp:2243, map=exact)

- Extra source locals: `sentinel`

### `DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache` (0x800c6eb8, draww.cpp:2285, map=exact)

- Extra source locals: `pMaterial`

### `DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry` (0x800c6fa0, draww.cpp:2351, map=exact)

- Extra source locals: `four`, `joinQuads`, `lorez`, `lorezN`, `lorezPtr`, `mB`, `negOne`, `off7d`

### `DrawW_GetAnimationTime__FP15Trk_AnimateInst` (0x800c7644, draww.cpp:3006, map=exact)

- Extra source locals: `result`, `tick`

### `DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` (0x800c78a8, draww.cpp:3149, map=exact)

- Extra source locals: `animType`, `g`, `oi`, `zo`

### `DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi` (0x800c7b9c, draww.cpp:3611, map=exact)

- Extra source locals: `anim`, `buildResult`, `g`, `oi`, `skipObject`, `t3`, `transMat`, `zo`

### `DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis` (0x800c7ebc, draww.cpp:4153, map=exact)

- Extra source locals: `drawResult`, `isCullable`, `m`, `posX`, `posY`, `posZ`, `shapeDef_p`, `tX`, `tY`, `tZ`

### `DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi` (0x800c8214, draww.cpp:4289, map=exact)

- Extra source locals: `drawResult`, `isCullable`, `m`, `offsetArg`, `posX`, `posY`, `posZ`, `tX`, `tY`, `tZ`

### `DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` (0x800c8508, draww.cpp:4457, map=exact)

- Extra source locals: `anim`, `t3`

### `ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache` (0x800c8bd0, draww.cpp:4893, map=exact)

- Extra source locals: `clipped`

### `Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark` (0x800c909c, draww.cpp:5312, map=exact)

- Extra source locals: `grey`, `otz94`, `skidIdx`

### `DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache` (0x800c98b8, draww.cpp:6286, map=exact)

- Extra source locals: `g2`

### `DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16` (0x800ca0a4, draww.cpp:6654, map=exact)

- Extra source locals: `rn`

### `DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache` (0x800ca204, draww.cpp:6758, map=exact)

- Extra source locals: `m`, `m2`, `posX`, `posY`, `posZ`, `tx`, `ty`, `tz`

### `DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache` (0x800ca520, draww.cpp:6947, map=exact)

- Extra source locals: `dof`, `p`, `q`, `so`, `vt`

### `Force_Vbl__Fv` (0x800ca998, force.cpp:70, map=exact)

- Extra source locals: `actuator1`, `f`

### `Force_Update__FP8Car_tObj` (0x800cabc0, force.cpp:194, map=exact)

- Extra source locals: `clamped`, `controller`

### `Font_SetABR__Fi` (0x800cb264, font.cpp:70, map=exact)

- Extra source locals: `y`

### `Font_Blit__FiiPviiP12charactertbli` (0x800cb2ac, font.cpp:115, map=exact)

- Extra source locals: `tpage`

### `Font_Getcharacter__Fi` (0x800cb740, font.cpp:267, map=exact)

- Extra source locals: `characterTableBase`

### `Font_SwitchFont__FPc` (0x800cb7ec, font.cpp:330, map=exact)

- Extra source locals: `abr_val`, `arg3`, `base`, `fontShape`

### `Font_LoadFont__FPciic` (0x800cb8bc, font.cpp:395, map=exact)

- Extra source locals: `hdr`

### `Font_TextXY__FPcii` (0x800cba90, font.cpp:455, map=exact)

- Extra source locals: `cfbase`

### `Flare_Tri__FPlN20i` (0x800cbcb0, flare.cpp:131, map=exact)

- Extra source locals: `pkt_addr24`

### `Flare_Spikes__FPli` (0x800cc3b8, flare.cpp:395, map=exact)

- Extra source locals: `rgb`

### `Flare_HexFlare__FPli` (0x800cc694, flare.cpp:500, map=exact)

- Extra source locals: `rgb`

### `Flare_ReflectHexFlare__FPli` (0x800cc868, flare.cpp:553, map=exact)

- Extra source locals: `rgb`

### `Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache` (0x800ccb58, flare.cpp:640, map=exact)

- Extra source locals: `c`, `dtd`, `i`, `j`

### `Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache` (0x800cd530, flare.cpp:890, map=exact)

- Extra source locals: `c`, `dtd`

### `Flare_2DSpike__FPlT0i` (0x800cdec4, flare.cpp:1170, map=exact)

- Extra source locals: `rgb`

### `Flare_PreCalcHexLightBeam__FPli` (0x800ce34c, flare.cpp:1452, map=exact)

- Extra source locals: `rgb`

### `Flare_Quad__FPlP7CVECTORi` (0x800ce420, flare.cpp:1508, map=exact)

- Extra source locals: `color_word`, `pkt_addr24`

### `Flare_QuadNotTransparent__FPlP7CVECTORi` (0x800ce4c4, flare.cpp:1533, map=exact)

- Extra source locals: `color_word`, `pkt_addr24`

### `Flare_QuadRing__FPlP7CVECTORi` (0x800ce568, flare.cpp:1558, map=exact)

- Extra source locals: `innerColor`, `outerColor`

### `Flare_TextureQuad__FPlP7CVECTORci` (0x800ce61c, flare.cpp:1586, map=exact)

- Extra source locals: `color_word`, `pkt_addr24`

### `Flare_LensFlare__FP7DVECTORP15Draw_FlareCache` (0x800ceb6c, flare.cpp:1754, map=exact)

- Extra source locals: `colw`, `cp`, `otSize`, `otz`, `pp`, `vx0`, `vy0`

### `Flare_Sun__FP7SVECTORP15Draw_FlareCache` (0x800cf1d0, flare.cpp:2195, map=exact)

- Extra source locals: `trackSpec`

### `Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache` (0x800d0404, hrzsku.cpp:605, map=exact)

- Extra source locals: `pal`, `pmx`, `slot`, `tag`

### `Hrz_LightningFlicker__Fi` (0x800d0760, hrzsku.cpp:716, map=exact)

- Extra source locals: `col`

### `Hrz_SetDitheringPrim__Fii` (0x800d09b0, hrzsku.cpp:1236, map=exact)

- Extra source locals: `prev_pkt_slot`, `prev_val`

### `Hrz_BuildSky__Fv` (0x800d0a38, hrzsku.cpp:1299, map=exact)

- Extra source locals: `c0`, `slot`

### `Hrz_BuildHorizon__FP13DRender_tView` (0x800d131c, hrzsku.cpp:2289, map=exact)

- Extra source locals: `c1`, `ch`, `cw`, `farCoord`, `fo`, `iv`, `m24`, `nextRingOffset`, `pal`, `pp`, `q`, `ringOffset`, `shape_idx`, `shape_visible`

### `Hud_FBuildSprite__FiiiUli` (0x800d2070, hud.cpp:359, map=exact)

- Extra source locals: `prev_pkt`

### `Hud_FBuildF4__FiiiiiUlcc` (0x800d2984, hud.cpp:584, map=exact)

- Extra source locals: `prev_pkt`

### `Hud_BuildTimeSprites__FP4SPRTPcii` (0x800d2ef8, hud.cpp:830, map=exact)

- Extra source locals: `n`

### `Hud_Init__Fv` (0x800d302c, hud.cpp:938, map=exact)

- Extra source locals: `g4`, `one`, `syc`, `sye`

### `Hud_InitTables__Fv` (0x800d39ec, hud.cpp:1212, map=exact)

- Extra source locals: `positionTable`

### `Hud_BuildTach__Fi` (0x800d3e94, hud.cpp:1645, map=exact)

- Extra source locals: `clutx`, `pal`, `pal2`, `tachNeedle_p`, `tp3`, `tp9`, `ts1`, `ts3`, `ts4`

### `Hud_BuildString__FPciiiib` (0x800d42c8, hud.cpp:1896, map=exact)

- Extra source locals: `as`, `iw1`, `iw2`, `iw3`, `iw4`, `iw5`, `s_`

### `Hud_BuildNumbers0__Fi` (0x800d4624, hud.cpp:2218, map=exact)

- Extra source locals: `eSprt`, `etime`, `last`, `p`, `pal`, `pal_2`, `primAddr`, `y_2`

### `Hud_BuildNumbers__Fi` (0x800d4e70, hud.cpp:2812, map=exact)

- Extra source locals: `m2`, `pal`, `pal_2`, `pal_3`, `xm1`, `xt`

### `Hud_InitMap__Fv` (0x800d5a48, hud.cpp:3073, map=exact)

- Extra source locals: `carCount`

### `Hud_BuildMapMarkers__Fi` (0x800d5ae8, hud.cpp:3303, map=exact)

- Extra source locals: `aiflags`, `car`, `cflags`, `mapx`, `pal`, `pktcell`

### `Hud_BuildWingmanInterface__Fi` (0x800d606c, hud.cpp:3599, map=exact)

- Extra source locals: `fc`, `iconRow`, `now`, `pal`, `two`, `xf`

### `Hud_BuildCdPlayer__Fii` (0x800d63dc, hud.cpp:3912, map=exact)

- Extra source locals: `dxk`, `i`, `lt`, `lt4`, `padState`, `scz`, `showCdPlayer`

### `Hud_BuildRadar__Fi` (0x800d6b48, hud.cpp:4324, map=exact)

- Extra source locals: `pal`

### `Hud_NextPlayer__Fi` (0x800d754c, hud.cpp:4683, map=exact)

- Extra source locals: `humanCar`

### `Hud_NextPlayerNameOrCarOrTime__Fi` (0x800d76b0, hud.cpp:4772, map=exact)

- Extra source locals: `humanCar`

### `Hud_RenderMapView__Fv` (0x800d7838, hud.cpp:4839, map=exact)

- Extra source locals: `pal`, `tp`

### `Hud_BlackThinBox__Fiiii` (0x800d7abc, hud.cpp:4925, map=exact)

- Extra source locals: `CORNERWIDTH`

### `Hud_Draw321Num__Fiiiiii` (0x800d7ca8, hud.cpp:4952, map=exact)

- Extra source locals: `by2`

### `Hud_RenderHudView__Fv` (0x800d82d0, hud.cpp:5367, map=exact)

- Extra source locals: `cdshow`, `otmask`, `pal`, `pw`, `tpageOff`, `viewOff`, `ww2p1`

### `Hud_RenderTacView__Fv` (0x800d8c48, hud.cpp:5918, map=exact)

- Extra source locals: `dh`

### `Hud_ParseTime__FiPc` (0x800d8d64, hud.cpp:5967, map=exact)

- Extra source locals: `centi_total`, `min`, `sec`

### `Hud_Render__Fv` (0x800d9058, hud.cpp:6025, map=exact)

- Extra source locals: `remain`

### `RaceSummary__Fv` (0x800d9a48, overlays.cpp:106, map=exact)

- Extra source locals: `titleX`, `titleY`, `w2`

### `RaceStatistics__Fv` (0x800d9fbc, overlays.cpp:467, map=exact)

- Extra source locals: `colInset`, `colX`, `one`, `pitch`, `rowInset`, `rows`, `sizeH16`, `titleX`, `titleY`

### `Hud_BTCStats__Fsb` (0x800da728, overlays.cpp:1081, map=exact)

- Extra source locals: `postgameInset`, `sizeH`

### `Hud_RenderStatsView__Fv` (0x800dae8c, overlays.cpp:1323, map=exact)

- Extra source locals: `t`

### `Loading_UpdateLoadingScreen__Fi` (0x800db200, loading.cpp:59, map=exact)

- Extra source locals: `tile`, `y`

### `Night_GenerateNextLightningEvent__Fv` (0x800db5cc, night.cpp:678, map=exact)

- Extra source locals: `rmask`, `ticksp`

### `Night_SetEnviroment__FP13DRender_tView` (0x800dc0a8, night.cpp:1377, map=exact)

- Extra source locals: `tgt`, `zn2`

### `Platform_InitMemory__Fv` (0x800dc2b8, platform.cpp:35, map=exact)

- Extra source locals: `m`

### `Platform_ReserveMemory__FiPc` (0x800dc2e8, platform.cpp:78, map=exact)

- Extra source locals: `mem`, `newmem`

### `InGame_GetPSXPadValue__Fii` (0x800dc990, psxcontroller.cpp:266, map=exact)

- Extra source locals: `index`

### `InGame_SetRamp__Fv` (0x800dcd3c, psxcontroller.cpp:606, map=exact)

- Extra source locals: `hb`

### `Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache` (0x800dd598, sfx.cpp:177, map=exact)

- Extra source locals: `addr24`, `ot2`, `w`

### `Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle` (0x800dd790, sfx.cpp:840, map=exact)

- Missing SYM names: `check`, `dest`, `invertedm`, `l0`, `l1`, `l2`, `l3`, `pmx`, `ptrans`, `scale`, `tpage`
- Extra source locals: `ds`, `link`, `m`, `ot2`, `p0f`, `p1f`, `p2f`, `p3f`, `w`

### `Skidmark_CheckChunk__FP8coorddefii` (0x800de9ec, skidmark.cpp:70, map=exact)

- Extra source locals: `d`, `nseg`

### `Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii` (0x800deb98, skidmark.cpp:155, map=exact)

- Extra source locals: `n`

### `Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii` (0x800def6c, skidmark.cpp:220, map=exact)

- Extra source locals: `n`

### `Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi` (0x800df688, texture.cpp:60, map=exact)

- Extra source locals: `count`, `num`

### `Texture_CopyPalette__FPciii` (0x800dfa3c, texture.cpp:266, map=exact)

- Extra source locals: `zero`

### `Texture_Vramf__FP8shapetbliiii` (0x800dfb8c, texture.cpp:335, map=exact)

- Extra source locals: `deadfrm`, `kind`, `nextshp`, `rowpix`, `rowround`

### `Texture_Vramcf__FP8shapetbliiii` (0x800dfd38, texture.cpp:430, map=exact)

- Extra source locals: `h`, `off`, `rowall`, `ybot`

### `Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap` (0x800dff18, texture.cpp:520, map=exact)

- Extra source locals: `fl`

### `Texture_InitMenuClut__Fv` (0x800e0510, texture.cpp:734, map=exact)

- Extra source locals: `cbase`, `clut`, `pal4`, `pal8`

### `TextureProcess_ColorClut__FiiPciii` (0x800e08b8, textureprocess.cpp:34, map=exact)

- Extra source locals: `p`, `spec`

### `Fog_AllocKey__Fv` (0x800e0c80, textureprocess.cpp:177, map=exact)

- Extra source locals: `one`

### `Fog_Update__Fi` (0x800e0d80, textureprocess.cpp:243, map=exact)

- Extra source locals: `slot`, `start`

### `Fog_InitFogTriggers__Fv` (0x800e102c, textureprocess.cpp:364, map=exact)

- Extra source locals: `openkey_walk`, `openval`, `slice_off`

### `TrackSpec_Read__Fi` (0x800e17d0, trackspec.cpp:418, map=exact)

- Extra source locals: `filebuf`, `trk`

### `Weather_InitSplats__Fv` (0x800e1fd8, weather.cpp:201, map=exact)

- Extra source locals: `commModeNetwork`, `gameSetup`, `result`

### `Weather_Init__Fv` (0x800e2530, weather.cpp:475, map=exact)

- Extra source locals: `firstCamMatDest`, `secondCamMatDest`

### `Weather_TransformVertex__FP10matrixtdefiP7SVECTOR` (0x800e2910, weather.cpp:622, map=exact)

- Extra source locals: `next`

### `Weather_CheckAndResetParticles__FP7SVECTOR` (0x800e29d4, weather.cpp:677, map=exact)

- Extra source locals: `rnd`

### `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc` (0x800e2fd0, weather.cpp:822, map=exact)

- Missing SYM names: `pt`
- Extra source locals: `reset`, `tr`

### `Weather_CreateSnow__FP7SVECTOR` (0x800e33bc, weather.cpp:936, map=exact)

- Extra source locals: `addr24`, `next`, `pal`, `palw`

### `Weather_CreateRain__FP7SVECTORP7DVECTORPc` (0x800e356c, weather.cpp:1043, map=exact)

- Extra source locals: `addr24`, `pal`, `palw`

### `Weather_CreateSplat__FP18Weather_tSplatInfo` (0x800e3730, weather.cpp:1131, map=exact)

- Extra source locals: `addr24`, `col`, `next`, `palw`, `pmx`, `sh`, `tp3`

### `Weather_DoSplats__FiP18Weather_tSplatInfo` (0x800e3858, weather.cpp:1360, map=exact)

- Extra source locals: `q`

### `Weather_DoWeather__FP13DRender_tView` (0x800e3a1c, weather.cpp:1457, map=exact)

- Extra source locals: `addr24`, `mode`, `next`, `pal`, `palw`, `plb`, `wdp`

### `textnpixels` (0x800e3d8c, textpix.c:15, map=exact)

- Extra source locals: `fontbase`

### `Fe3D_InitShowroom__Fv` (0x80012938, fe3dmenu.cpp:21, map=exact)

- Extra source locals: `cos_raw`, `trigValue`

### `Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii` (0x80012bf8, fe3dmenu.cpp:101, map=exact)

- Extra source locals: `inShowroom`

## Implicit aggregate special members

## Explicit SYM carrier/optimization mappings


## Explicit restored inline-local mappings


## Explicit compact static-local mappings

- `Device_Fail__Fi`: `failtime` from compact SYM `failtime.98`

## Exact cross-build/canonical name recoveries


## Explicit restored macro-local mappings

- `TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef`: `r0` from `TRSPROJ_SET_MATRIX_ROW x3`, `r1` from `TRSPROJ_SET_MATRIX_ROW x3`, `r2` from `TRSPROJ_SET_MATRIX_ROW x3`

## Explicit linkage-proven ABI parameters omitted from SYM


## Explicit source-only codegen carriers

- `CarIO_CopyToShape__FPsT0i`: `n0`, `n1`, `n2`, `n3`
- `CarIO_CreateLicense__FPcii`: `p1`, `p2`, `q1`, `q2`, `r1`, `r2`
- `CarIO_CleanUpLicense__Fi`: `plateShape`, `plateSlot`
- `CarIO_LicenseCheck__FiPiT1P8Car_tObji`: `new_sfx_vx`, `new_sfx_vy`
- `CarIO_UpdateCarTextureData__FPcP8Car_tObji`: `pmx`
- `Device_Update__Fv`: `commMode`
- `Draw_SetView__Fiiiiiiiii`: `viewIndex`
- `Draw_InitViewOT__Fv`: `view`
- `Draw_InitViewOTInGame__Fv`: `view`
- `Draw_DeInitViews__Fv`: `view`
- `Draw_DeInitViewsInGame__Fv`: `numViews`, `view`
- `Draw_StartRenderingView__Fi`: `midGroundOtzNumerator`
- `Draw_StopRenderingView__Fi`: `pal`
- `Draw_StartFrameRender__Fv`: `view`
- `Draw_StopFrameRender__Fv`: `view`
- `DrawC_ReadLightingData__Fv`: `trk`
- `DrawC_NightHeadlight__FP8Car_tObj`: `h0`, `h1`, `h2`, `lightSlotView`
- `DrawC_MenuColorData__FiP8Car_tObji`: `menuColorSlot`
- `DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache`: `byteOffset`, `ctd`, `envMapOffset`, `envShift`, `ev`, `evraw`, `pos`, `pz`, `sort_carObj`, `tunnelFlag`
- `DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `envmapUV_dst`, `facetValue`, `ff`, `hi`, `overlayRaw`
- `DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `envmapUV_dst`, `facetValue`, `ff`, `hi`, `midUv01`, `midUv12`, `midUv20`, `midVt01`, `midVt12`, `midVt20`, `overlayRaw`, `uvk`
- `DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `facetMask`, `tex`
- `DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache`: `flareType`, `ov`, `ovs`
- `DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache`: `otp`
- `DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache`: `color`, `otp`
- `DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache`: `color`, `drawMode`, `otEntry`
- `DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache`: `hs`, `m1`, `z1`
- `DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31`: `minz`
- `DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss`: `n0`, `q`, `q1`, `q2`, `t4`
- `Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache`: `lt`
- `DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad`: `depth_avg`, `primPtr`, `ta`, `tb`, `tc`
- `DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache`: `sentinel`
- `DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache`: `pMaterial`
- `DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry`: `four`, `joinQuads`, `lorez`, `lorezN`, `lorezPtr`, `mB`, `negOne`, `off7d`
- `DrawW_GetAnimationTime__FP15Trk_AnimateInst`: `result`, `tick`
- `DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo`: `animType`, `g`, `zo`
- `DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi`: `anim`, `buildResult`, `g`, `skipObject`, `t3`, `transMat`, `zo`
- `DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis`: `drawResult`, `isCullable`, `m`, `posX`, `posY`, `posZ`, `shapeDef_p`, `tX`, `tY`, `tZ`
- `DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi`: `drawResult`, `isCullable`, `m`, `offsetArg`, `posX`, `posY`, `posZ`, `stack`, `tX`, `tY`, `tZ`
- `DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo`: `anim`, `t3`
- `ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache`: `clipped`
- `Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark`: `grey`, `otz94`, `skidIdx`
- `DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache`: `g2`
- `DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16`: `rn`
- `DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache`: `m`, `m2`, `posX`, `posY`, `posZ`, `tx`, `ty`, `tz`
- `DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache`: `dof`, `p`, `q`, `so`, `vt`
- `Force_Vbl__Fv`: `actuator1`, `f`
- `Force_Update__FP8Car_tObj`: `clamped`, `controller`
- `Font_SetABR__Fi`: `y`
- `Font_Blit__FiiPviiP12charactertbli`: `tpage`
- `Font_Getcharacter__Fi`: `characterTableBase`
- `Font_SwitchFont__FPc`: `abr_val`, `arg3`, `base`, `fontShape`
- `Font_LoadFont__FPciic`: `hdr`
- `Font_TextXY__FPcii`: `cfbase`
- `Flare_Tri__FPlN20i`: `pkt_addr24`
- `Flare_Spikes__FPli`: `rgb`
- `Flare_HexFlare__FPli`: `rgb`
- `Flare_ReflectHexFlare__FPli`: `rgb`
- `Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache`: `c`, `dtd`, `i`, `j`
- `Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache`: `c`, `dtd`
- `Flare_2DSpike__FPlT0i`: `rgb`
- `Flare_PreCalcHexLightBeam__FPli`: `rgb`
- `Flare_Quad__FPlP7CVECTORi`: `color_word`, `pkt_addr24`
- `Flare_QuadNotTransparent__FPlP7CVECTORi`: `color_word`, `pkt_addr24`
- `Flare_QuadRing__FPlP7CVECTORi`: `innerColor`, `outerColor`
- `Flare_TextureQuad__FPlP7CVECTORci`: `color_word`, `pkt_addr24`
- `Flare_LensFlare__FP7DVECTORP15Draw_FlareCache`: `colw`, `cp`, `otSize`, `otz`, `pp`, `vx0`, `vy0`
- `Flare_Sun__FP7SVECTORP15Draw_FlareCache`: `trackSpec`
- `Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache`: `pal`, `pmx`, `slot`, `tag`
- `Hrz_LightningFlicker__Fi`: `col`
- `Hrz_SetDitheringPrim__Fii`: `prev_pkt_slot`, `prev_val`
- `Hrz_BuildSky__Fv`: `c0`, `slot`
- `Hrz_BuildHorizon__FP13DRender_tView`: `c1`, `ch`, `cw`, `farCoord`, `fo`, `iv`, `m24`, `nextRingOffset`, `pal`, `pp`, `q`, `ringOffset`, `shape_idx`, `shape_visible`
- `Hud_FBuildSprite__FiiiUli`: `prev_pkt`
- `Hud_FBuildF4__FiiiiiUlcc`: `prev_pkt`
- `Hud_BuildTimeSprites__FP4SPRTPcii`: `n`
- `Hud_Init__Fv`: `g4`, `one`, `syc`, `sye`
- `Hud_InitTables__Fv`: `positionTable`
- `Hud_BuildTach__Fi`: `clutx`, `pal`, `pal2`, `tachNeedle_p`, `tp3`, `tp9`, `ts1`, `ts3`, `ts4`
- `Hud_BuildString__FPciiiib`: `as`, `iw1`, `iw2`, `iw3`, `iw4`, `iw5`
- `Hud_BuildNumbers0__Fi`: `eSprt`, `etime`, `last`, `p`, `pal`, `pal_2`, `primAddr`, `y_2`
- `Hud_BuildNumbers__Fi`: `m2`, `pal`, `pal_2`, `pal_3`, `xm1`, `xt`
- `Hud_InitMap__Fv`: `carCount`
- `Hud_BuildMapMarkers__Fi`: `aiflags`, `car`, `cflags`, `mapx`, `pal`, `pktcell`
- `Hud_BuildWingmanInterface__Fi`: `fc`, `iconRow`, `now`, `pal`, `two`, `xf`
- `Hud_BuildCdPlayer__Fii`: `dxk`, `i`, `lt`, `lt4`, `padState`, `scz`, `showCdPlayer`
- `Hud_BuildRadar__Fi`: `pal`
- `Hud_NextPlayer__Fi`: `humanCar`
- `Hud_NextPlayerNameOrCarOrTime__Fi`: `humanCar`
- `Hud_RenderMapView__Fv`: `pal`, `tp`
- `Hud_BlackThinBox__Fiiii`: `CORNERWIDTH`
- `Hud_Draw321Num__Fiiiiii`: `by2`
- `Hud_RenderHudView__Fv`: `cdshow`, `otmask`, `pal`, `pw`, `tpageOff`, `viewOff`, `ww2p1`
- `Hud_RenderTacView__Fv`: `dh`
- `Hud_ParseTime__FiPc`: `centi_total`, `min`, `sec`
- `Hud_Render__Fv`: `remain`
- `RaceSummary__Fv`: `titleX`, `titleY`, `w2`
- `RaceStatistics__Fv`: `colInset`, `colX`, `one`, `pitch`, `rowInset`, `rows`, `sizeH16`, `titleX`, `titleY`
- `Hud_BTCStats__Fsb`: `postgameInset`, `sizeH`
- `Hud_RenderStatsView__Fv`: `t`
- `Loading_UpdateLoadingScreen__Fi`: `tile`, `y`
- `Night_GenerateNextLightningEvent__Fv`: `rmask`, `ticksp`
- `Night_SetEnviroment__FP13DRender_tView`: `tgt`, `zn2`
- `Platform_InitMemory__Fv`: `m`
- `Platform_ReserveMemory__FiPc`: `mem`, `newmem`
- `InGame_GetPSXPadValue__Fii`: `index`
- `InGame_SetRamp__Fv`: `hb`
- `Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache`: `addr24`, `ot2`, `w`
- `Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle`: `ds`, `link`, `m`, `ot2`, `p0f`, `p1f`, `p2f`, `p3f`, `w`
- `Skidmark_CheckChunk__FP8coorddefii`: `d`, `nseg`
- `Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii`: `n`
- `Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii`: `n`
- `Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi`: `count`, `num`
- `Texture_CopyPalette__FPciii`: `zero`
- `Texture_Vramf__FP8shapetbliiii`: `deadfrm`, `kind`, `nextshp`, `rowpix`, `rowround`
- `Texture_Vramcf__FP8shapetbliiii`: `h`, `off`, `rowall`, `ybot`
- `Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap`: `fl`
- `Texture_InitMenuClut__Fv`: `cbase`, `clut`, `pal4`, `pal8`
- `TextureProcess_ColorClut__FiiPciii`: `p`, `spec`
- `Fog_AllocKey__Fv`: `one`
- `Fog_Update__Fi`: `slot`, `start`
- `Fog_InitFogTriggers__Fv`: `openkey_walk`, `openval`, `slice_off`
- `TrackSpec_Read__Fi`: `filebuf`, `trk`
- `Weather_InitSplats__Fv`: `commModeNetwork`, `gameSetup`, `result`
- `Weather_Init__Fv`: `firstCamMatDest`, `secondCamMatDest`
- `Weather_TransformVertex__FP10matrixtdefiP7SVECTOR`: `next`
- `Weather_CheckAndResetParticles__FP7SVECTOR`: `rnd`
- `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc`: `reset`, `tr`
- `Weather_CreateSnow__FP7SVECTOR`: `addr24`, `next`, `pal`, `palw`
- `Weather_CreateRain__FP7SVECTORP7DVECTORPc`: `addr24`, `pal`, `palw`
- `Weather_CreateSplat__FP18Weather_tSplatInfo`: `addr24`, `col`, `next`, `palw`, `pmx`, `sh`, `tp3`
- `Weather_DoSplats__FiP18Weather_tSplatInfo`: `q`
- `Weather_DoWeather__FP13DRender_tView`: `addr24`, `mode`, `next`, `pal`, `palw`, `plb`, `wdp`
- `textnpixels`: `fontbase`
- `Fe3D_InitShowroom__Fv`: `cos_raw`, `trigValue`
- `Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii`: `inShowroom`

## Explicit oracle-proven function type overrides


## Object-owned global/storage review

- `audio.cpp` blob-backed definitions: `backwardsTrackStartTrigger`, `gMusicHandle`
- `cario.cpp` blob-backed definitions: `CarIO_carVRamAdd`, `CarIO_carVRamOffset`, `CarIO_carVRamSlots`, `CarIO_carVRamSlotsMenu`, `CarIO_licensePlate`, `CarIO_licenseSFX_Vram`, `CarIO_textureName`, `inFrontEnd`
- `device.cpp` blob-backed definitions: `Device_gDeviceList`
- `draw.cpp` blob-backed definitions: `Draw_gView`, `gEnviro`
- `drawc.cpp` blob-backed definitions: `DrawC_HeadLightFlash`, `DrawC_SirenFlash`, `DrawC_TailLightFlash`, `DrawC_gEnvMapOffset`, `DrawC_gMatA`, `DrawC_gMenuColor`, `DrawC_gMenuLights`, `DrawC_gOverlay`, `DrawC_gScreenMat`, `hilight_colors`
- `fe3dmenu.cpp` blob-backed definitions: `Fe3D_lightsVertex`, `Fe3D_spotVertex`, `gMenuRotate`, `gShowroomLights`, `showRoomFlag`
- `font.cpp` blob-backed definitions: `colourRGB`, `shpfontclut`
- `loading.cpp` blob-backed definitions: `loading_languageNames`
- `overlays.cpp` blob-backed definitions: `BTCPerpInfo`
- `psxcontroller.cpp` blob-backed definitions: `hoff`, `mappings`
- `textureprocess.cpp` blob-backed definitions: `Fog_gBuf`, `TP_gBlendColor`, `TP_gColorMode`, `Texture_gContrastColor`, `Texture_gWorldColor`, `gClutDepth`, `gContrastScale`, `openkeys`
- `trackspec.cpp` blob-backed definitions: `TrackSpec_gSpec`
- `weather.cpp` blob-backed definitions: `Weather_gDensityTbl`, `Weather_gIntensityTbl`, `Weather_gLastTimeProcessed`, `Weather_gRandomVelocityVectors`, `Weather_gSys`, `Weather_gTrackIntensityLimitTbl`, `prevCamMat`, `prevCamPos`
- `overlays.cpp:15` `StatsTimer` @ 0x8013d998: type SYM `int[2]` vs source `int`
