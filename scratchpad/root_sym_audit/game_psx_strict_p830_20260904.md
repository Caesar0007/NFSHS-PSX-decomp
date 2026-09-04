# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-decomp\recon\game\psx`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

## Summary

- SYM functions in target TUs: 395
- Mapped to reconstructed definitions: 395 (395 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 0
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 392
- Missing SYM names: 0
- Extra source-local names: 3
- Type-comparison findings: 0
- Recognized ABI/debug-equivalent type encodings: 14
  (c-struct-tag=1, char-debug-signedness=7, generic-function-pointer=2, promoted-stack-argument=4)
- Function storage-class findings: 0
- Implicit aggregate special members (source body correctly absent): 0
- Explicit oracle-receipted carrier mappings: 15
- Explicit restored inline-local mappings: 0
- Explicit restored macro-local mappings: 3
- Explicit compact static-local mappings: 1
- Exact cross-build/canonical name recoveries: 0
- Explicit linkage-proven ABI parameters omitted from SYM: 0
- Explicit source-only codegen carriers: 397
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
- Global type findings: 0
- Recognized global debug-equivalent types: 3
  (explicit-signed-char=1, generic-function-pointer=2)
- Explicit measured global array carriers: 1
- Explicit source-only global/data-layout carriers: 0
- Explicit host-only fallback globals: 0
- Explicit linker-folded shared common globals: 0
- Explicit oracle-proven global type overrides: 0

## Review queue

### `DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` (0x800c78a8, draww.cpp:3149, map=exact)

- Extra source locals: `oi`

### `DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi` (0x800c7b9c, draww.cpp:3611, map=exact)

- Extra source locals: `oi`

### `Hud_BuildString__FPciiiib` (0x800d42c8, hud.cpp:1917, map=exact)

- Extra source locals: `s_`

## Implicit aggregate special members

## Explicit SYM carrier/optimization mappings

- `DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32`: `tempcop`, `tempnight`
- `Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle`: `check`, `dest`, `invertedm`, `l0`, `l1`, `l2`, `l3`, `pmx`, `pt`, `ptrans`, `scale`, `tpage`
- `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc`: `pt`

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
- `Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii`: `pv`
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
- `Weather_InitSplats__Fv`: `commModeNetwork`, `gs`, `result`
- `Weather_Init__Fv`: `cameraWords`, `firstCamMatDest`, `secondCamMatDest`
- `Weather_TransformVertex__FP10matrixtdefiP7SVECTOR`: `next`
- `Weather_CheckAndResetParticles__FP7SVECTOR`: `rnd`
- `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc`: `reset`, `tr`
- `Weather_CreateSnow__FP7SVECTOR`: `addr24`, `next`, `pal`, `palw`
- `Weather_CreateRain__FP7SVECTORP7DVECTORPc`: `addr24`, `pal`, `palw`
- `Weather_CreateSplat__FP18Weather_tSplatInfo`: `addr24`, `col`, `next`, `palw`, `pmx`, `sh`, `tp3`
- `Weather_DoSplats__FiP18Weather_tSplatInfo`: `q`
- `Weather_DoWeather__FP13DRender_tView`: `addr24`, `cm`, `mode`, `next`, `one`, `pal`, `palw`, `plb`, `wdp`
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
- No ownership, storage-class, or type findings.
