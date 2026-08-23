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
- Declaration-clean mapped functions: 350
- Missing SYM names: 0
- Extra source-local names: 525
- Type-comparison findings: 1
- Recognized ABI/debug-equivalent type encodings: 14
  (c-struct-tag=1, char-debug-signedness=7, generic-function-pointer=2, promoted-stack-argument=4)
- Function storage-class findings: 0
- Compiler-generated aggregate functions without source bodies: 0
- Explicit oracle-receipted carrier mappings: 15
- Explicit source-only codegen carriers: 193
- Explicit oracle-proven function type overrides: 7
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 302
- Mapped source global definitions: 250
- Blob-backed object globals: 52
- Missing/extra global definitions: 0/94
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 1
- Global type findings: 0
- Recognized global debug-equivalent types: 3
  (explicit-signed-char=1, generic-function-pointer=2)
- Explicit measured global array carriers: 12
- Explicit oracle-proven global type overrides: 0

## Review queue

### `CarIO_CreateLicense__FPcii` (0x800bc25c, cario.cpp:625, map=exact)

- Extra source locals: `f1`, `f2`, `hdr`, `p1`, `p2`, `q1`, `q2`, `r1`, `r2`, `tu3`

### `DrawC_MenuColorData__FiP8Car_tObji` (0x800beb24, drawc.cpp:540, map=exact)

- Extra source locals: `carType0`, `iVar3`, `menuColorSlot`, `pGVar4`, `palCopy`, `sVar1`

### `DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache` (0x800bed44, drawc.cpp:667, map=exact)

- Extra source locals: `carTypeOffRange`, `ctd`, `damageLevel`, `drawEnv_p`, `eIndexEnvMap`, `eIndexShadow`, `envColor`, `envColor2`, `envExtra`, `envMapBigBit`, `envMapTex`, `envMap_align_a`, `envMap_align_b`, `envMap_w0`, `envMap_w3`, `envShift`, `envSpeed`, `envTexShape`, `evraw`, `g1b`, `g1c`, `halfTransp`, `headLight_bits`, `iVar3`, `lightAvgScaled`, `matPart_a`, `matPart_b`, `menuPmx_w0`, `menuPmx_w1`, `menuPmx_w2`, `menuPmx_w3`, `mir`, `nabr_blend`, `pDVar2`, `puVar4`, `pz`, `quadB`, `reflMap_iter`, `shadExtra`, `shadowAbsOffs`, `shadowMap_w1`, `shadowMap_w2`, `shadowQuad`, `shadowTex`, `shadow_align_a`, `shadow_align_b`, `shapeData_p`, `shapeIdx`, `sub_otSize_local`, `sub_ot_p`, `sub_otz_h2`, `sub_otz_x4`, `t8`, `tc`, `tp1`, `tp11`, `tp12`, `tp17`, `tp2`, `tp20`, `tp3`, `tp4`, `tp8`, `tu12`, `tu14`, `tu15`, `tu27`, `tunnelFlag`, `uVar1`, `uVar5`, `vertCount`

### `DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` (0x800bfd44, drawc.cpp:1669, map=exact)

- Extra source locals: `absZ`, `bfctResult_b`, `cVar1`, `e1`, `e2`, `e3`, `envmapMode`, `envmapUV_dst`, `facetByteOff`, `facet_p_v3`, `ff`, `hi`, `iVar13`, `iVar14`, `iVar8`, `loopDoneTag`, `matRow0_w1`, `matRow1_x`, `matRow_temp`, `otzSum`, `overlayRaw`, `primTypeByte_b`, `psVar12`, `psVar6`, `puVar17`, `tV_dst`, `tc6`, `ti34`, `ts10`, `ts7`, `tu1`, `tu11`, `tu12`, `tu14`, `tu15`, `tu19`, `tu21`, `tu4`, `tvx`, `uVar10`, `uVar8_00`, `vertex_iter`

### `DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache` (0x800c12f8, drawc.cpp:2914, map=exact)

- Extra source locals: `iVar6`, `puVar10`, `puVar5`, `puVar7`, `sVar1`, `sVar2`, `uVar3`, `uVar4`, `uVar8`, `uVar9`

### `DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` (0x800c155c, drawc.cpp:3309, map=exact)

- Extra source locals: `absZ_envmap`, `e1`, `e2`, `e3`, `envmapUV_dst`, `ff`, `hi`, `noSub`, `otzSum`, `overlayRaw`, `tvx`, `u2_00`, `uvk`, `vt1`, `vt2`, `vt2_00`
- Type: facetFlag: SYM ['short'] vs source ['int']

### `DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache` (0x800c40dc, drawc.cpp:5328, map=exact)

- Extra source locals: `iVar4`, `mhi`, `mlo`, `puVar6`, `puVar7`, `uVar1`, `uVar2`, `uVar3`, `uVar5`

### `DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss` (0x800c5284, draww.cpp:520, map=exact)

- Extra source locals: `pal`, `q`

### `DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad` (0x800c64f8, draww.cpp:1474, map=exact)

- Extra source locals: `depth_avg`, `geomVerts_p`, `iVar2`, `p`, `pal`, `primPtr`, `q0`, `q1`, `q2`, `q3`, `sVar1`, `ta`, `tb`, `tc`, `ti18`, `ti5`, `tp1`, `tp2`, `tp20`, `tp36`, `tp6`, `ts27`, `ts31`, `tu1`, `tu24`, `tu27`, `tu28`, `tu29`, `tu30`, `tu46`, `tu47`, `tu48`, `tu49`, `tu5`, `uVar3_00`, `vert0_proj_x`, `vert0_proj_y`, `vert1_idx`, `vert1_proj_x`, `vert1_proj_y`, `vert2_proj_x`, `vert2_proj_y`, `vert3_proj_x`, `vert3_proj_y`, `vertProj_idx`, `vertProj_p`, `vert_x_pack`, `vert_y_pack`

### `DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry` (0x800c6fa0, draww.cpp:2338, map=exact)

- Extra source locals: `cx2`, `cz2`, `dist2`, `four`, `gteFlag`, `joinQuads`, `lorez`, `lorezN`, `lorezPtr`, `mB`, `negOne`, `off7d`, `posX`, `posY`, `posZ`, `px`, `pz`, `vx`, `vy`, `vz`

### `DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` (0x800c78a8, draww.cpp:3158, map=exact)

- Extra source locals: `animType`, `clipRes`, `distSq`, `g`, `zo`

### `DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi` (0x800c7b9c, draww.cpp:3621, map=exact)

- Extra source locals: `bVar7`, `buildResult`, `g`, `instData_p`, `objDef_p`, `pOVar5`, `t3`, `tc5`, `transMat`, `zo`

### `DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis` (0x800c7ebc, draww.cpp:4171, map=exact)

- Extra source locals: `drawResult`, `isCullable`, `m`, `mat_local`, `posX`, `posY`, `posZ`, `shapeDef_p`, `tX`, `tY`, `tZ`

### `DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi` (0x800c8214, draww.cpp:4297, map=exact)

- Extra source locals: `drawResult`, `isCullable`, `m`, `posX`, `posY`, `posZ`, `shapeDef_p`, `tX`, `tY`, `tZ`

### `Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark` (0x800c909c, draww.cpp:5313, map=exact)

- Extra source locals: `bVar2`, `ccount_local`, `color_pack`, `depth_skid`, `grey`, `neg1`, `otz94`, `primPtr`, `skidChunk_p`, `skidIdx`, `ti2`, `tx`, `ty`, `tz`, `vert_count`, `vt_y`

### `DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache` (0x800ca204, draww.cpp:6737, map=exact)

- Extra source locals: `bVar1`, `m`, `m2`, `posX`, `posY`, `posZ`, `tx`, `ty`, `tz`

### `DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache` (0x800ca520, draww.cpp:6917, map=exact)

- Extra source locals: `dof`, `p`, `q`, `sdG`, `so`, `vt`

### `Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache` (0x800ccb58, flare.cpp:651, map=exact)

- Extra source locals: `addr24_0`, `c`, `dtd`, `i`, `j`, `pkt24`, `slot`

### `Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache` (0x800cd530, flare.cpp:907, map=exact)

- Extra source locals: `addr24_0`, `addr24_1`, `c`, `dtd`, `pkt24`, `sd`, `slot`

### `Flare_2DHalo__Fiiiii` (0x800cdf70, flare.cpp:1225, map=exact)

- Extra source locals: `addr24_0`, `addr24_1`, `pal`, `pkt24`, `slot`

### `Flare_LensFlare__FP7DVECTORP15Draw_FlareCache` (0x800ceb6c, flare.cpp:1804, map=exact)

- Extra source locals: `addr24_0`, `colw`, `cp`, `otSize`, `otz`, `pkt24`, `pp`, `slot`, `vx0`, `vy0`

### `Hrz_GetHorizonPixMap__FP12Draw_tPixMap` (0x800d0064, hrzsku.cpp:542, map=exact)

- Extra source locals: `dst_off`, `extra_pmx`, `p_walk`, `pixmap_base`, `pixmap_base2`, `skytbl_walk`, `src_off`, `tp2`, `tp3`

### `Hrz_BuildSky__Fv` (0x800d0a38, hrzsku.cpp:1392, map=exact)

- Extra source locals: `c0`, `hpb`, `slot`, `tag`

### `Hrz_BuildHorizon__FP13DRender_tView` (0x800d131c, hrzsku.cpp:2394, map=exact)

- Extra source locals: `c1`, `ch`, `cw`, `fo`, `iVar15`, `iVar18`, `iVar6`, `m24`, `p`, `pSVar12`, `pal`, `pp`, `puVar1`, `puVar14`, `q`, `rowDelta`, `shape_idx`, `shape_overlap`, `shape_short`, `shape_visible`, `shape_w_idx`

### `Hud_BuildSprite__FP4SPRTiiiUli` (0x800d1f98, hud.cpp:348, map=exact)

- Extra source locals: `pHVar3`, `tu1`, `uVar1`, `uVar2`, `uVar4`, `uVar5`

### `Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl` (0x800d2288, hud.cpp:437, map=exact)

- Extra source locals: `tpage_clut`, `tu2`, `uVar1`, `uVar2`, `uVar3`, `uv23_pack`, `w_h_pack`

### `Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` (0x800d2334, hud.cpp:465, map=exact)

- Extra source locals: `tu2`, `tu3`, `tu4`, `tu5`, `uVar1`, `uVar2`, `uVar3`

### `Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` (0x800d2424, hud.cpp:491, map=exact)

- Extra source locals: `tu2`, `tu3`, `tu4`, `tu5`, `uVar1`, `uVar2`, `uVar3`, `uVar4`

### `Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` (0x800d2528, hud.cpp:520, map=exact)

- Extra source locals: `tu2`, `tu3`, `uVar1`, `uVar2`, `uVar3`, `uVar4`

### `Hud_BuildTimeSprites__FP4SPRTPcii` (0x800d2ef8, hud.cpp:888, map=exact)

- Extra source locals: `bVar3`, `bVar4`, `bVar5`, `cVar2`, `n`, `pcVar6`, `uVar7`

### `Hud_BuildTach__Fi` (0x800d3e94, hud.cpp:1693, map=exact)

- Extra source locals: `clutx`, `pal`, `pal2`, `tachNeedle_p`, `tp3`, `tp9`, `ts1`, `ts3`, `ts4`

### `Hud_BuildString__FPciiiib` (0x800d42c8, hud.cpp:1940, map=exact)

- Extra source locals: `as`, `iw1`, `iw2`, `iw3`, `iw4`, `iw5`

### `Hud_BuildNumbers0__Fi` (0x800d4624, hud.cpp:2255, map=exact)

- Extra source locals: `eSprt`, `etime`, `last`, `p`, `pal_2`, `primAddr`, `y_2`

### `Hud_BuildNumbers__Fi` (0x800d4e70, hud.cpp:2806, map=exact)

- Extra source locals: `pal`, `pal_2`, `pal_3`, `xt`

### `Hud_BuildMapMarkers__Fi` (0x800d5ae8, hud.cpp:3291, map=exact)

- Extra source locals: `aiflags`, `car`, `cflags`, `mapx`, `pal`, `pktcell`

### `Hud_BuildWingmanInterface__Fi` (0x800d606c, hud.cpp:3585, map=exact)

- Extra source locals: `fc`, `iconRow`, `now`, `pal`, `two`, `xf`

### `Hud_BuildCdPlayer__Fii` (0x800d63dc, hud.cpp:3891, map=exact)

- Extra source locals: `arg1`, `bVar2`, `dxk`, `i`, `lt`, `lt4`, `scz`, `uVar5`, `wordId`

### `Hud_BuildReplay__Fv` (0x800d7250, hud.cpp:4518, map=exact)

- Extra source locals: `pal`, `palL`, `tSs1`, `tSs1_2`, `tSs1_3`

### `Hud_NextPlayer__Fi` (0x800d754c, hud.cpp:4665, map=exact)

- Extra source locals: `carObj_00`, `iVar1`, `iVar4`, `uVar3`, `uVar5`

### `Hud_NextPlayerNameOrCarOrTime__Fi` (0x800d76b0, hud.cpp:4756, map=exact)

- Extra source locals: `carObj_00`, `iVar1`, `iVar2`, `iVar3`, `uVar4`

### `Hud_RenderHudView__Fv` (0x800d82d0, hud.cpp:5349, map=exact)

- Extra source locals: `cdshow`, `otmask`, `pal`, `pw`, `tagp`, `tpageOff`, `viewOff`, `viewp`, `ww2p1`

### `Hud_RenderTacView__Fv` (0x800d8c48, hud.cpp:5899, map=exact)

- Extra source locals: `dh`, `j4`, `pal`, `tp`

### `Hud_Perp_OverlayOff__Fi` (0x800d9950, hud.cpp:6331, map=exact)

- Extra source locals: `artist`, `cenX`, `cenZ`, `cos`, `flashTicks`, `langSec`, `lx`, `offy`, `ox`, `rpm`, `rx`, `sec`, `sin`, `slice`, `speed`, `temp1`, `ten`, `title`, `u`, `v`, `w7`, `yo`

### `RaceStatistics__Fv` (0x800d9fbc, overlays.cpp:438, map=exact)

- Extra source locals: `barH`, `barH8`, `colInset`, `halfH`, `nh`, `one`, `pitch`, `posy`, `posyL`, `rowInset`, `sizeH16`, `titleX`, `titleY`

### `Weather_Init__Fv` (0x800e2530, weather.cpp:525, map=exact)

- Extra source locals: `iVar6`, `iVar7`, `iVar8`, `pSVar10`, `pcVar2`, `piVar3`, `pmVar4`, `pmVar5`, `psVar9`, `uVar1`

## Explicit SYM carrier/optimization mappings

- `DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32`: `tempcop`, `tempnight`
- `Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle`: `check`, `dest`, `invertedm`, `l0`, `l1`, `l2`, `l3`, `pmx`, `pt`, `ptrans`, `scale`, `tpage`
- `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc`: `pt`

## Explicit source-only codegen carriers

- `CarIO_CopyToShape__FPsT0i`: `n0`, `n1`, `n2`, `n3`
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
- `DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache`: `rawFlag`, `tex`
- `DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache`: `ov`, `ovs`, `uVar8`
- `DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache`: `otp`
- `DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache`: `color`, `pDVar7`, `puVar8`
- `DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache`: `hs`, `m1`, `z1`
- `DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31`: `minz`
- `Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache`: `lt`
- `DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache`: `sentinel`
- `DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache`: `pMaterial`
- `DrawW_GetAnimationTime__FP15Trk_AnimateInst`: `iVar2`, `tick`
- `DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo`: `anim`, `t3`
- `ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache`: `pvVar3`
- `DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16`: `rn`
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
- `Flare_2DSpike__FPlT0i`: `rgb`
- `Flare_PreCalcHexLightBeam__FPli`: `rgb`
- `Flare_Quad__FPlP7CVECTORi`: `color_word`, `pkt_addr24`
- `Flare_QuadNotTransparent__FPlP7CVECTORi`: `color_word`, `pkt_addr24`
- `Flare_QuadRing__FPlP7CVECTORi`: `innerColor`, `outerColor`
- `Flare_TextureQuad__FPlP7CVECTORci`: `color_word`, `pkt_addr24`
- `Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii`: `pv`
- `Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache`: `pal`, `pmx`, `slot`, `tag`
- `Hrz_LightningFlicker__Fi`: `col`
- `Hrz_SetDitheringPrim__Fii`: `prev_pkt_slot`, `prev_val`
- `Hud_FBuildSprite__FiiiUli`: `prev_pkt`
- `Hud_FBuildF4__FiiiiiUlcc`: `prev_pkt`
- `Hud_Init__Fv`: `syc`, `sye`
- `Hud_InitTables__Fv`: `patVar1`
- `Hud_BuildNumbers0__Fi`: `pal`
- `Hud_InitMap__Fv`: `iVar4`
- `Hud_BuildRadar__Fi`: `pal`
- `Hud_RenderMapView__Fv`: `pal`, `tp`
- `Hud_BlackThinBox__Fiiii`: `CORNERWIDTH`
- `Hud_Draw321Num__Fiiiiii`: `by2`
- `Hud_ParseTime__FiPc`: `centi_total`, `min`, `sec`
- `Hud_Render__Fv`: `remain`
- `RaceSummary__Fv`: `titleX`, `titleY`, `w2`
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
- `drawc.cpp` extra definitions: `SP`
- `draww.cpp` extra definitions: `DrawWTrough_scratchVec`, `DrawW_gChunkGeomRez`, `DrawW_gChunkInd`, `DrawW_gChunkObjFlag`, `DrawW_gChunkQuadCount`, `DrawW_gChunkRelX`, `DrawW_gChunkRelY`, `DrawW_gChunkRelZ`, `DrawW_gChunkStripBuf`, `DrawW_gChunkVtxBuf`, `DrawW_gFog_init`, `DrawW_gGroupCount`, `DrawW_gGroupPtr`, `DrawW_gInitialArtPtr`, `DrawW_gMatID_tmp`, `DrawW_gMaterialLUT`, `DrawW_gNightFlags`, `DrawW_gNightTmpFlag`, `DrawW_gObjScratch_148`
- `hrzsku.cpp` extra definitions: `Hrz_gLightningPosInSky_pad`, `Hrz_gLightningPosInSky_vx`, `Hrz_gLightningPosInSky_vy`, `Hrz_gLightningPosInSky_vz`, `Hrz_gProjResultZ0`, `Hrz_gProjScratch_9C`, `Hrz_gSkyVtx_A0`, `Hrz_gSkyVtx_A1`, `Hrz_gSkyVtx_B0`, `Hrz_gSkyVtx_B1`
- `hrzskuw76.cpp` extra definitions: `Hrz_gLightningPosInSky_pad`, `Hrz_gLightningPosInSky_vx`, `Hrz_gLightningPosInSky_vy`, `Hrz_gLightningPosInSky_vz`, `Hrz_gProjResultZ0`, `Hrz_gProjScratch_9C`, `Hrz_gSaveCol`, `Hrz_gSkyVtx_A0`, `Hrz_gSkyVtx_A1`, `Hrz_gSkyVtx_B0`, `Hrz_gSkyVtx_B1`, `Hrz_gTrackSpec`, `Sky_gTrackSpec`, `gHorizonExtraSkyPixmaps`, `gHorizonPixmap`, `gHrzRingColor`, `gHrz_Lightning`, `gRngCoordTop`, `gSkyColor`, `gSkyMesh`, `gSkyPixmapIndex`, `gfxPmxHeightPercentage`, `gpPmx`, `moonPosInSky_pad`, `moonPosInSky_vx`, `moonPosInSky_vy`, `moonPosInSky_vz`, `starColors`, `starPosInSky`, `sunPosInSky_pad`, `sunPosInSky_vx`, `sunPosInSky_vy`, `sunPosInSky_vz`
- `loading.cpp` extra definitions: `D_8013D9D4`
- `night.cpp` extra definitions: `D_8013D9F4`, `D_8013DA50`, `D_8013DA8C`, `lightningInit`
- `overlays.cpp` extra definitions: `D_8013D99C`
- `platform.cpp` extra definitions: `D_8013DAA0`, `gDctBuffer`, `gEAMemPoolBase`, `gPlatformInitMem`
- `sfx.cpp` extra definitions: `Sfx_gCache`
- `skidmark.cpp` extra definitions: `Skid_gCtrlPoint_0`, `Skid_gCtrlPoint_1`, `Skid_gCtrlPoint_2`, `Skid_gCtrlPoint_3`, `Skid_gCtrlPoint_4`, `Skid_gCtrlPoint_5`, `Skid_gCtrlPoint_6`, `Skid_gCtrlScratch_94`, `Skid_gCtrlScratch_98`, `Skid_gScratchPos1`, `Skid_gScratchPos2`
- `textureprocess.cpp` extra definitions: `D_8013DB84`, `fogstrspc`
- `weather.cpp` extra definitions: `Weather_gDrawnServer1`, `Weather_gLastProcessTime1`, `Weather_gPServer1`, `Weather_gPrevPServer1`, `Weather_gSplatInfoServer1`, `prevCameraMode`, `prevLookBehind`

