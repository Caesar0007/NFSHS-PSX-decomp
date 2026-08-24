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
- Declaration-clean mapped functions: 395
- Missing SYM names: 0
- Extra source-local names: 0
- Type-comparison findings: 0
- Recognized ABI/debug-equivalent type encodings: 14
  (c-struct-tag=1, char-debug-signedness=7, generic-function-pointer=2, promoted-stack-argument=4)
- Function storage-class findings: 0
- Compiler-generated aggregate functions without source bodies: 0
- Explicit oracle-receipted carrier mappings: 15
- Explicit source-only codegen carriers: 384
- Explicit oracle-proven function type overrides: 9
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 302
- Mapped source global definitions: 250
- Blob-backed object globals: 52
- Missing/extra global definitions: 0/59
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 1
- Global type findings: 0
- Recognized global debug-equivalent types: 3
  (explicit-signed-char=1, generic-function-pointer=2)
- Explicit measured global array carriers: 12
- Explicit oracle-proven global type overrides: 0

## Review queue

## Explicit SYM carrier/optimization mappings

- `DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32`: `tempcop`, `tempnight`
- `Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle`: `check`, `dest`, `invertedm`, `l0`, `l1`, `l2`, `l3`, `pmx`, `pt`, `ptrans`, `scale`, `tpage`
- `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc`: `pt`

## Explicit source-only codegen carriers

- `CarIO_CopyToShape__FPsT0i`: `n0`, `n1`, `n2`, `n3`
- `CarIO_CreateLicense__FPcii`: `f2`, `p1`, `p2`, `q1`, `q2`, `r1`, `r2`
- `CarIO_CleanUpLicense__Fi`: `ppPlate1`, `psVar1`
- `CarIO_LicenseCheck__FiPiT1P8Car_tObji`: `sVar1`, `sVar2`
- `CarIO_UpdateCarTextureData__FPcP8Car_tObji`: `pmx`
- `Device_Update__Fv`: `iVar1`
- `Draw_SetView__Fiiiiiiiii`: `iVar2`
- `Draw_InitViewOT__Fv`: `pDVar2`
- `Draw_InitViewOTInGame__Fv`: `pDVar2`
- `Draw_DeInitViews__Fv`: `pDVar1`
- `Draw_DeInitViewsInGame__Fv`: `iVar2`, `pDVar3`
- `Draw_StartRenderingView__Fi`: `iVar1`
- `Draw_StopRenderingView__Fi`: `pal`
- `Draw_StartFrameRender__Fv`: `pDVar4`
- `Draw_StopFrameRender__Fv`: `pDVar2`
- `DrawC_ReadLightingData__Fv`: `trk`
- `DrawC_NightHeadlight__FP8Car_tObj`: `h0`, `h1`, `h2`, `lp`, `wc`
- `DrawC_MenuColorData__FiP8Car_tObji`: `menuColorSlot`
- `DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache`: `ctd`, `envShift`, `evraw`, `pz`, `sort_carObj`, `tunnelFlag`
- `DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `envmapUV_dst`, `ff`, `hi`, `overlayRaw`
- `DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `envmapUV_dst`, `ff`, `hi`, `overlayRaw`, `u1`, `u2`, `u2_00`, `uvk`, `vt1`, `vt2`, `vt2_00`
- `DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `rawFlag`, `tex`
- `DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache`: `ov`, `ovs`, `uVar8`
- `DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache`: `otp`
- `DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache`: `color`, `otp`
- `DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache`: `color`, `pDVar7`, `puVar8`
- `DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache`: `hs`, `m1`, `z1`
- `DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31`: `minz`
- `DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss`: `q`
- `Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache`: `lt`
- `DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad`: `depth_avg`, `primPtr`, `ta`, `tb`, `tc`
- `DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache`: `sentinel`
- `DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache`: `pMaterial`
- `DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry`: `four`, `gteFlag`, `joinQuads`, `lorez`, `lorezN`, `lorezPtr`, `mB`, `negOne`, `off7d`
- `DrawW_GetAnimationTime__FP15Trk_AnimateInst`: `iVar2`, `tick`
- `DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo`: `animType`, `g`, `zo`
- `DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi`: `anim`, `bVar7`, `buildResult`, `g`, `t3`, `transMat`, `zo`
- `DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis`: `drawResult`, `isCullable`, `m`, `posX`, `posY`, `posZ`, `shapeDef_p`, `tX`, `tY`, `tZ`
- `DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi`: `drawResult`, `isCullable`, `m`, `posX`, `posY`, `posZ`, `tX`, `tY`, `tZ`
- `DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo`: `anim`, `t3`
- `ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache`: `pvVar3`
- `Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark`: `grey`, `neg1`, `otz94`, `skidIdx`
- `DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16`: `rn`
- `DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache`: `m`, `m2`, `posX`, `posY`, `posZ`, `tx`, `ty`, `tz`
- `DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache`: `dof`, `p`, `q`, `so`, `vt`
- `Force_Vbl__Fv`: `actuator1`, `f`
- `Force_Update__FP8Car_tObj`: `clamped`, `controller`
- `Font_SetABR__Fi`: `y`
- `Font_Blit__FiiPviiP12charactertbli`: `tpage`
- `Font_Getcharacter__Fi`: `base_00`
- `Font_SwitchFont__FPc`: `abr_val`, `arg3`, `base`, `pv1`
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
- `Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii`: `pv`
- `Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache`: `pal`, `pmx`, `slot`, `tag`
- `Hrz_LightningFlicker__Fi`: `col`
- `Hrz_SetDitheringPrim__Fii`: `prev_pkt_slot`, `prev_val`
- `Hrz_BuildSky__Fv`: `c0`, `hpb`, `slot`, `tag`
- `Hrz_BuildHorizon__FP13DRender_tView`: `c1`, `ch`, `cw`, `fo`, `iVar15`, `iVar18`, `m24`, `pSVar12`, `pal`, `pp`, `q`, `shape_idx`, `shape_visible`
- `Hud_FBuildSprite__FiiiUli`: `prev_pkt`
- `Hud_FBuildF4__FiiiiiUlcc`: `prev_pkt`
- `Hud_BuildTimeSprites__FP4SPRTPcii`: `n`
- `Hud_Init__Fv`: `syc`, `sye`
- `Hud_InitTables__Fv`: `patVar1`
- `Hud_BuildTach__Fi`: `clutx`, `pal`, `pal2`, `tachNeedle_p`, `tp3`, `tp9`, `ts1`, `ts3`, `ts4`
- `Hud_BuildString__FPciiiib`: `as`, `iw1`, `iw2`, `iw3`, `iw4`, `iw5`
- `Hud_BuildNumbers0__Fi`: `eSprt`, `etime`, `last`, `p`, `pal`, `pal_2`, `primAddr`, `y_2`
- `Hud_BuildNumbers__Fi`: `m2`, `pal`, `pal_2`, `pal_3`, `xm1`, `xt`
- `Hud_InitMap__Fv`: `iVar4`
- `Hud_BuildMapMarkers__Fi`: `aiflags`, `car`, `cflags`, `mapx`, `pal`, `pktcell`
- `Hud_BuildWingmanInterface__Fi`: `fc`, `iconRow`, `now`, `pal`, `two`, `xf`
- `Hud_BuildCdPlayer__Fii`: `bVar2`, `dxk`, `i`, `lt`, `lt4`, `scz`, `uVar5`
- `Hud_BuildRadar__Fi`: `pal`
- `Hud_NextPlayer__Fi`: `carObj_00`
- `Hud_NextPlayerNameOrCarOrTime__Fi`: `carObj_00`
- `Hud_RenderMapView__Fv`: `pal`, `tp`
- `Hud_BlackThinBox__Fiiii`: `CORNERWIDTH`
- `Hud_Draw321Num__Fiiiiii`: `by2`
- `Hud_RenderHudView__Fv`: `cdshow`, `otmask`, `pal`, `pw`, `tpageOff`, `viewOff`, `ww2p1`
- `Hud_RenderTacView__Fv`: `dh`
- `Hud_ParseTime__FiPc`: `centi_total`, `min`, `sec`
- `Hud_Render__Fv`: `remain`
- `RaceSummary__Fv`: `titleX`, `titleY`, `w2`
- `RaceStatistics__Fv`: `colInset`, `colX`, `nh`, `one`, `pitch`, `rowInset`, `sizeH16`, `titleX`, `titleY`
- `Hud_BTCStats__Fsb`: `postgameInset`, `sizeH`
- `Hud_RenderStatsView__Fv`: `t`
- `Loading_UpdateLoadingScreen__Fi`: `tile`, `y`
- `Night_GenerateNextLightningEvent__Fv`: `rmask`, `ticksp`
- `Night_SetEnviroment__FP13DRender_tView`: `tgt`, `zn2`
- `Platform_InitMemory__Fv`: `m`
- `Platform_ReserveMemory__FiPc`: `mem`, `newmem`
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
- `Weather_Init__Fv`: `pmVar4`, `pmVar5`
- `Weather_TransformVertex__FP10matrixtdefiP7SVECTOR`: `next`
- `Weather_CheckAndResetParticles__FP7SVECTOR`: `rnd`
- `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc`: `reset`, `tr`
- `Weather_CreateSnow__FP7SVECTOR`: `addr24`, `next`, `pal`, `palw`
- `Weather_CreateRain__FP7SVECTORP7DVECTORPc`: `addr24`, `pal`, `palw`
- `Weather_CreateSplat__FP18Weather_tSplatInfo`: `addr24`, `col`, `next`, `palw`, `pmx`, `tp3`
- `Weather_DoSplats__FiP18Weather_tSplatInfo`: `q`
- `Weather_DoWeather__FP13DRender_tView`: `addr24`, `cm`, `mode`, `next`, `one`, `pal`, `palw`, `plb`
- `textnpixels`: `fontbase`
- `Fe3D_InitShowroom__Fv`: `cos_raw`, `iVar1`, `sVar4`, `sh`
- `Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii`: `bVar1`

## Explicit oracle-proven function type overrides

- `DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `facetFlag`
- `DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `facetFlag`
- `DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `facetFlag`
- `DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `tV`
- `Sky_InitStars__Fv`: `starBright`
- `TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef`: `r0`
- `TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef`: `r1`
- `TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef`: `r2`
- `Fe3D_InitShowroom__Fv`: `iPlus`

## Object-owned global/storage review

- `audio.cpp` blob-backed definitions: `backwardsTrackStartTrigger`, `gMusicHandle`
- `cario.cpp` blob-backed definitions: `CarIO_carVRamAdd`, `CarIO_carVRamOffset`, `CarIO_carVRamSlots`, `CarIO_carVRamSlotsMenu`, `CarIO_licensePlate`, `CarIO_licenseSFX_Vram`, `CarIO_textureName`, `inFrontEnd`
- `device.cpp` blob-backed definitions: `Device_gDeviceList`
- `draw.cpp` blob-backed definitions: `Draw_gView`, `gEnviro`
- `drawc.cpp` blob-backed definitions: `DrawC_HeadLightFlash`, `DrawC_SirenFlash`, `DrawC_TailLightFlash`, `DrawC_gEnvMapOffset`, `DrawC_gMatA`, `DrawC_gMenuColor`, `DrawC_gMenuLights`, `DrawC_gOverlay`, `DrawC_gScreenMat`, `hilight_colors`
- `fe3dmenu.cpp` blob-backed definitions: `Fe3D_lightsVertex`, `Fe3D_spotVertex`, `gMenuRotate`, `gShowroomLights`, `showRoomFlag`
- `font.cpp` blob-backed definitions: `colourRGB`, `shpfontclut`
- `hrzsku.cpp` blob-backed definitions: `Hrz_gLightningPosInSky`
- `loading.cpp` blob-backed definitions: `loading_languageNames`
- `overlays.cpp` blob-backed definitions: `BTCPerpInfo`
- `psxcontroller.cpp` blob-backed definitions: `hoff`, `mappings`
- `textureprocess.cpp` blob-backed definitions: `Fog_gBuf`, `TP_gBlendColor`, `TP_gColorMode`, `Texture_gContrastColor`, `Texture_gWorldColor`, `gClutDepth`, `gContrastScale`, `openkeys`
- `trackspec.cpp` blob-backed definitions: `TrackSpec_gSpec`
- `weather.cpp` blob-backed definitions: `Weather_gDensityTbl`, `Weather_gIntensityTbl`, `Weather_gLastTimeProcessed`, `Weather_gRandomVelocityVectors`, `Weather_gSys`, `Weather_gTrackIntensityLimitTbl`, `prevCamMat`, `prevCamPos`
- `draww.cpp` extra definitions: `DrawWTrough_scratchVec`, `DrawW_gChunkGeomRez`, `DrawW_gChunkInd`, `DrawW_gChunkObjFlag`, `DrawW_gChunkQuadCount`, `DrawW_gChunkRelX`, `DrawW_gChunkRelY`, `DrawW_gChunkRelZ`, `DrawW_gChunkStripBuf`, `DrawW_gChunkVtxBuf`, `DrawW_gFog_init`, `DrawW_gGroupCount`, `DrawW_gGroupPtr`, `DrawW_gInitialArtPtr`, `DrawW_gMatID_tmp`, `DrawW_gMaterialLUT`, `DrawW_gNightFlags`, `DrawW_gNightTmpFlag`, `DrawW_gObjScratch_148`
- `hrzsku.cpp` extra definitions: `Hrz_gLightningPosInSky_pad`, `Hrz_gLightningPosInSky_vx`, `Hrz_gLightningPosInSky_vy`, `Hrz_gLightningPosInSky_vz`, `Hrz_gProjResultZ0`, `Hrz_gProjScratch_9C`, `Hrz_gSkyVtx_A0`, `Hrz_gSkyVtx_A1`, `Hrz_gSkyVtx_B0`, `Hrz_gSkyVtx_B1`
- `loading.cpp` extra definitions: `D_8013D9D4`
- `night.cpp` extra definitions: `D_8013D9F4`, `D_8013DA50`, `D_8013DA8C`, `lightningInit`
- `overlays.cpp` extra definitions: `D_8013D99C`
- `platform.cpp` extra definitions: `D_8013DAA0`, `gDctBuffer`, `gEAMemPoolBase`, `gPlatformInitMem`
- `skidmark.cpp` extra definitions: `Skid_gCtrlPoint_0`, `Skid_gCtrlPoint_1`, `Skid_gCtrlPoint_2`, `Skid_gCtrlPoint_3`, `Skid_gCtrlPoint_4`, `Skid_gCtrlPoint_5`, `Skid_gCtrlPoint_6`, `Skid_gCtrlScratch_94`, `Skid_gCtrlScratch_98`, `Skid_gScratchPos1`, `Skid_gScratchPos2`
- `textureprocess.cpp` extra definitions: `D_8013DB84`, `fogstrspc`
- `weather.cpp` extra definitions: `Weather_gDrawnServer1`, `Weather_gLastProcessTime1`, `Weather_gPServer1`, `Weather_gPrevPServer1`, `Weather_gSplatInfoServer1`, `prevCameraMode`, `prevLookBehind`

