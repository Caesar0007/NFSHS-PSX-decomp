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
- Declaration-clean mapped functions: 243
- Missing SYM names: 0
- Extra source-local names: 834
- Type-comparison findings: 1
- Recognized ABI/debug-equivalent type encodings: 14
  (c-struct-tag=1, char-debug-signedness=7, generic-function-pointer=2, promoted-stack-argument=4)
- Function storage-class findings: 0
- Compiler-generated aggregate functions without source bodies: 0
- Explicit oracle-receipted carrier mappings: 15
- Explicit source-only codegen carriers: 28
- Explicit oracle-proven function type overrides: 7
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 302
- Mapped source global definitions: 250
- Blob-backed object globals: 52
- Missing/extra global definitions: 0/134
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 1
- Global type findings: 0
- Recognized global debug-equivalent types: 3
  (explicit-signed-char=1, generic-function-pointer=2)
- Explicit measured global array carriers: 12
- Explicit oracle-proven global type overrides: 0

## Review queue

### `CarIO_CopyToShape__FPsT0i` (0x800bc1b4, cario.cpp:244, map=exact)

- Extra source locals: `n0`, `n1`, `n2`, `n3`

### `CarIO_CreateLicense__FPcii` (0x800bc25c, cario.cpp:625, map=exact)

- Extra source locals: `f1`, `f2`, `hdr`, `p1`, `p2`, `q1`, `q2`, `r1`, `r2`, `tu3`

### `CarIO_CleanUpLicense__Fi` (0x800bc5f0, cario.cpp:808, map=exact)

- Extra source locals: `ppPlate1`, `psVar1`

### `CarIO_LicenseCheck__FiPiT1P8Car_tObji` (0x800bc668, cario.cpp:830, map=exact)

- Extra source locals: `sVar1`, `sVar2`

### `CarIO_UpdateCarTextureData__FPcP8Car_tObji` (0x800bceb0, cario.cpp:1424, map=exact)

- Extra source locals: `pmx`

### `DrawC_ReadLightingData__Fv` (0x800be6f0, drawc.cpp:181, map=exact)

- Extra source locals: `trk`

### `DrawC_NightHeadlight__FP8Car_tObj` (0x800be978, drawc.cpp:251, map=exact)

- Extra source locals: `h0`, `h1`, `h2`, `lp`, `wc`

### `DrawC_MenuColorData__FiP8Car_tObji` (0x800beb24, drawc.cpp:536, map=exact)

- Extra source locals: `carType0`, `iVar3`, `menuColorSlot`, `pGVar4`, `palCopy`, `sVar1`

### `DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache` (0x800bed44, drawc.cpp:663, map=exact)

- Extra source locals: `carTypeOffRange`, `ctd`, `damageLevel`, `drawEnv_p`, `eIndexEnvMap`, `eIndexShadow`, `envColor`, `envColor2`, `envExtra`, `envMapBigBit`, `envMapTex`, `envMap_align_a`, `envMap_align_b`, `envMap_w0`, `envMap_w3`, `envShift`, `envSpeed`, `envTexShape`, `evraw`, `g1b`, `g1c`, `halfTransp`, `headLight_bits`, `iVar3`, `lightAvgScaled`, `matPart_a`, `matPart_b`, `menuPmx_w0`, `menuPmx_w1`, `menuPmx_w2`, `menuPmx_w3`, `mir`, `nabr_blend`, `pDVar2`, `puVar4`, `pz`, `quadB`, `reflMap_iter`, `shadExtra`, `shadowAbsOffs`, `shadowMap_w1`, `shadowMap_w2`, `shadowQuad`, `shadowTex`, `shadow_align_a`, `shadow_align_b`, `shapeData_p`, `shapeIdx`, `sub_otSize_local`, `sub_ot_p`, `sub_otz_h2`, `sub_otz_x4`, `t8`, `tc`, `tp1`, `tp11`, `tp12`, `tp17`, `tp2`, `tp20`, `tp3`, `tp4`, `tp8`, `tu12`, `tu14`, `tu15`, `tu27`, `tunnelFlag`, `uVar1`, `uVar5`, `vertCount`

### `DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` (0x800bfd44, drawc.cpp:1665, map=exact)

- Extra source locals: `absZ`, `bfctResult_b`, `cVar1`, `e1`, `e2`, `e3`, `envmapMode`, `envmapUV_dst`, `facetByteOff`, `facet_p_v3`, `ff`, `hi`, `iVar13`, `iVar14`, `iVar8`, `loopDoneTag`, `matRow0_w1`, `matRow1_x`, `matRow_temp`, `otzSum`, `overlayRaw`, `primTypeByte_b`, `psVar12`, `psVar6`, `puVar17`, `tV_dst`, `tc6`, `ti34`, `ts10`, `ts7`, `tu1`, `tu11`, `tu12`, `tu14`, `tu15`, `tu19`, `tu21`, `tu4`, `tvx`, `uVar10`, `uVar8_00`, `vertex_iter`

### `DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache` (0x800c12f8, drawc.cpp:2910, map=exact)

- Extra source locals: `iVar6`, `puVar10`, `puVar5`, `puVar7`, `sVar1`, `sVar2`, `uVar3`, `uVar4`, `uVar8`, `uVar9`

### `DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` (0x800c155c, drawc.cpp:3288, map=exact)

- Extra source locals: `absZ_envmap`, `e1`, `e2`, `e3`, `envmapUV_dst`, `ff`, `hi`, `noSub`, `otzSum`, `overlayRaw`, `tvx`, `u2_00`, `vt1`, `vt2`, `vt2_00`
- Type: facetFlag: SYM ['short'] vs source ['int']

### `DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache` (0x800c32b0, drawc.cpp:4379, map=exact)

- Extra source locals: `rawFlag`, `tex`

### `DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache` (0x800c3a30, drawc.cpp:4881, map=exact)

- Extra source locals: `iVar6`, `ov`, `ovs`, `uVar8`

### `DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache` (0x800c3ed8, drawc.cpp:5186, map=exact)

- Extra source locals: `iVar1`, `otp`

### `DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache` (0x800c40dc, drawc.cpp:5258, map=exact)

- Extra source locals: `iVar4`, `mhi`, `mlo`, `puVar6`, `puVar7`, `uVar1`, `uVar2`, `uVar3`, `uVar5`

### `DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache` (0x800c42c4, drawc.cpp:5353, map=exact)

- Extra source locals: `u2`, `vt2`

### `DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache` (0x800c4800, drawc.cpp:5480, map=exact)

- Extra source locals: `color`, `pDVar7`, `puVar8`

### `DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache` (0x800c4b84, drawc.cpp:5610, map=exact)

- Extra source locals: `hs`, `m1`, `z1`

### `DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31` (0x800c51fc, draww.cpp:424, map=exact)

- Extra source locals: `iVar1`, `minz`

### `DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss` (0x800c5284, draww.cpp:521, map=exact)

- Extra source locals: `pal`, `q`

### `DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache` (0x800c5be0, draww.cpp:1033, map=exact)

- Extra source locals: `sVar2`

### `Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache` (0x800c5fb8, draww.cpp:1233, map=exact)

- Extra source locals: `lt`

### `DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32` (0x800c609c, draww.cpp:1320, map=exact)

- Extra source locals: `lt`

### `DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad` (0x800c64f8, draww.cpp:1459, map=exact)

- Extra source locals: `depth_avg`, `geomVerts_p`, `iVar2`, `p`, `pal`, `primPtr`, `q0`, `q1`, `q2`, `q3`, `sVar1`, `ta`, `tb`, `tc`, `ti18`, `ti5`, `tp1`, `tp2`, `tp20`, `tp36`, `tp6`, `ts27`, `ts31`, `tu1`, `tu24`, `tu27`, `tu28`, `tu29`, `tu30`, `tu46`, `tu47`, `tu48`, `tu49`, `tu5`, `uVar3_00`, `vert0_proj_x`, `vert0_proj_y`, `vert1_idx`, `vert1_proj_x`, `vert1_proj_y`, `vert2_proj_x`, `vert2_proj_y`, `vert3_proj_x`, `vert3_proj_y`, `vertProj_idx`, `vertProj_p`, `vert_x_pack`, `vert_y_pack`

### `DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache` (0x800c6e38, draww.cpp:2215, map=exact)

- Extra source locals: `sentinel`

### `DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache` (0x800c6eb8, draww.cpp:2257, map=exact)

- Extra source locals: `bVar1`, `pMaterial`, `pTVar4`, `sVar2`

### `DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry` (0x800c6fa0, draww.cpp:2327, map=exact)

- Extra source locals: `cx2`, `cz2`, `dist2`, `four`, `gteFlag`, `joinQuads`, `lorez`, `lorezN`, `lorezPtr`, `mB`, `negOne`, `off7d`, `posX`, `posY`, `posZ`, `px`, `pz`, `vx`, `vy`, `vz`

### `DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX` (0x800c75d8, draww.cpp:2937, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `DrawW_GetAnimationTime__FP15Trk_AnimateInst` (0x800c7644, draww.cpp:2971, map=exact)

- Extra source locals: `iVar2`, `tick`

### `DrawW_DoObjectAnimations__Fv` (0x800c7808, draww.cpp:3084, map=exact)

- Extra source locals: `iVar2`, `ppTVar1`, `table`, `time_00`

### `DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` (0x800c78a8, draww.cpp:3119, map=exact)

- Extra source locals: `animType`, `clipRes`, `distSq`, `g`, `zo`

### `DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi` (0x800c7b9c, draww.cpp:3582, map=exact)

- Extra source locals: `bVar7`, `buildResult`, `g`, `instData_p`, `objDef_p`, `pOVar5`, `t3`, `tc5`, `transMat`, `zo`

### `DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis` (0x800c7ebc, draww.cpp:4132, map=exact)

- Extra source locals: `drawResult`, `isCullable`, `m`, `mat_local`, `posX`, `posY`, `posZ`, `shapeDef_p`, `tX`, `tY`, `tZ`

### `DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi` (0x800c8214, draww.cpp:4258, map=exact)

- Extra source locals: `drawResult`, `isCullable`, `m`, `posX`, `posY`, `posZ`, `shapeDef_p`, `tX`, `tY`, `tZ`

### `DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` (0x800c8508, draww.cpp:4420, map=exact)

- Extra source locals: `anim`, `t3`

### `ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache` (0x800c8bd0, draww.cpp:4855, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `pvVar3`

### `Draw_CircleClip__FP8coorddefT0i` (0x800c903c, draww.cpp:5242, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark` (0x800c909c, draww.cpp:5281, map=exact)

- Extra source locals: `bVar2`, `ccount_local`, `color_pack`, `depth_skid`, `grey`, `neg1`, `otz94`, `primPtr`, `skidChunk_p`, `skidIdx`, `ti2`, `tx`, `ty`, `tz`, `vert_count`, `vt_y`

### `DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache` (0x800c9620, draww.cpp:6068, map=exact)

- Extra source locals: `cw_a`, `cw_b`, `ts2`, `ts4`, `ts6`

### `DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16` (0x800ca0a4, draww.cpp:6538, map=exact)

- Extra source locals: `bVar10`, `curLine`, `rn`

### `DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache` (0x800ca204, draww.cpp:6645, map=exact)

- Extra source locals: `bVar1`, `m`, `m2`, `posX`, `posY`, `posZ`, `tx`, `ty`, `tz`

### `DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache` (0x800ca520, draww.cpp:6825, map=exact)

- Extra source locals: `dof`, `p`, `q`, `sdG`, `so`, `vt`

### `Force_Vbl__Fv` (0x800ca998, force.cpp:70, map=exact)

- Extra source locals: `actuator1`, `f`

### `Force_Update__FP8Car_tObj` (0x800cabc0, force.cpp:194, map=exact)

- Extra source locals: `clamped`, `controller`, `uVar3`

### `Font_Blit__FiiPviiP12charactertbli` (0x800cb2ac, font.cpp:120, map=exact)

- Extra source locals: `tpage`

### `Font_SwitchFont__FPc` (0x800cb7ec, font.cpp:334, map=exact)

- Extra source locals: `abr_val`, `arg3`, `base`, `pv1`

### `Font_LoadFont__FPciic` (0x800cb8bc, font.cpp:400, map=exact)

- Extra source locals: `hdr`

### `Font_TextXY__FPcii` (0x800cba90, font.cpp:460, map=exact)

- Extra source locals: `cfbase`

### `Flare_Tri__FPlN20i` (0x800cbcb0, flare.cpp:136, map=exact)

- Extra source locals: `pkt_addr24`

### `Flare_OctFlare__FPli` (0x800cbe14, flare.cpp:198, map=exact)

- Extra source locals: `addr24`, `pal`, `pkt24`, `slot`

### `Flare_OctFlareSpikes__FPli` (0x800cc034, flare.cpp:263, map=exact)

- Extra source locals: `addr24_0`, `addr24_1`, `pal`, `pkt24`, `slot`

### `Flare_Spikes__FPli` (0x800cc3b8, flare.cpp:422, map=exact)

- Extra source locals: `addr24`, `pal`, `pkt24`, `rgb`, `slot`

### `Flare_HexFlare__FPli` (0x800cc694, flare.cpp:535, map=exact)

- Extra source locals: `addr24`, `pal`, `pkt24`, `rgb`, `slot`

### `Flare_ReflectHexFlare__FPli` (0x800cc868, flare.cpp:596, map=exact)

- Extra source locals: `addr24`, `pal`, `pkt24`, `rgb`, `slot`

### `Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache` (0x800ccb58, flare.cpp:691, map=exact)

- Extra source locals: `addr24_0`, `c`, `dtd`, `i`, `j`, `pkt24`, `slot`

### `Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache` (0x800cd530, flare.cpp:947, map=exact)

- Extra source locals: `addr24_0`, `addr24_1`, `c`, `dtd`, `pkt24`, `sd`, `slot`

### `Flare_2DSpike__FPlT0i` (0x800cdec4, flare.cpp:1239, map=exact)

- Extra source locals: `rgb`

### `Flare_2DHalo__Fiiiii` (0x800cdf70, flare.cpp:1265, map=exact)

- Extra source locals: `addr24_0`, `addr24_1`, `pal`, `pkt24`, `slot`

### `Flare_PreCalcHexLightBeam__FPli` (0x800ce34c, flare.cpp:1543, map=exact)

- Extra source locals: `addr24`, `pal`, `pkt24`, `rgb`, `slot`

### `Flare_Quad__FPlP7CVECTORi` (0x800ce420, flare.cpp:1605, map=exact)

- Extra source locals: `color_word`, `pkt_addr24`

### `Flare_QuadNotTransparent__FPlP7CVECTORi` (0x800ce4c4, flare.cpp:1630, map=exact)

- Extra source locals: `color_word`, `pkt_addr24`

### `Flare_QuadRing__FPlP7CVECTORi` (0x800ce568, flare.cpp:1655, map=exact)

- Extra source locals: `innerColor`, `outerColor`, `prev_pkt_slot`

### `Flare_TextureQuad__FPlP7CVECTORci` (0x800ce61c, flare.cpp:1685, map=exact)

- Extra source locals: `color_word`, `pkt_addr24`, `shape_p`

### `Flare_SingleColorTex__FP7DVECTORP7CVECTORiici` (0x800ce6f8, flare.cpp:1727, map=exact)

- Extra source locals: `sVar1`, `sVar2`

### `Flare_SingleColorOct__FP7DVECTORP7CVECTORiii` (0x800ce8b0, flare.cpp:1774, map=exact)

- Extra source locals: `iVar1`, `iVar4`, `pDVar3`, `pSVar2`

### `Flare_LensFlare__FP7DVECTORP15Draw_FlareCache` (0x800ceb6c, flare.cpp:1872, map=exact)

- Extra source locals: `addr24_0`, `colw`, `cp`, `otSize`, `otz`, `pkt24`, `pp`, `slot`, `vx0`, `vy0`

### `Flare_Sun__FP7SVECTORP15Draw_FlareCache` (0x800cf1d0, flare.cpp:2300, map=exact)

- Extra source locals: `addr24_0`, `addr24_1`, `pkt24`, `slot`

### `Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii` (0x800cf574, hrzsku.cpp:107, map=exact)

- Extra source locals: `pv`

### `Hrz_GetHorizonPixMap__FP12Draw_tPixMap` (0x800d0064, hrzsku.cpp:539, map=exact)

- Extra source locals: `dst_off`, `extra_pmx`, `p_walk`, `pixmap_base`, `pixmap_base2`, `skytbl_walk`, `src_off`, `tp2`, `tp3`

### `Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache` (0x800d0404, hrzsku.cpp:694, map=exact)

- Extra source locals: `pal`, `pmx`, `slot`, `tag`

### `Hrz_LightningFlicker__Fi` (0x800d0760, hrzsku.cpp:804, map=exact)

- Extra source locals: `col`

### `Hrz_SetDitheringPrim__Fii` (0x800d09b0, hrzsku.cpp:1324, map=exact)

- Extra source locals: `prev_pkt_slot`, `prev_val`

### `Hrz_BuildSky__Fv` (0x800d0a38, hrzsku.cpp:1387, map=exact)

- Extra source locals: `c0`, `hpb`, `slot`, `tag`

### `Sky_RenderStars__FP13Draw_SkyCachei` (0x800d1160, hrzsku.cpp:1889, map=exact)

- Extra source locals: `pal`, `pkt24`, `slot`, `tag`

### `Hrz_BuildHorizon__FP13DRender_tView` (0x800d131c, hrzsku.cpp:2396, map=exact)

- Extra source locals: `c1`, `ch`, `cw`, `fo`, `iVar15`, `iVar18`, `iVar6`, `m24`, `p`, `pSVar12`, `pal`, `pp`, `puVar1`, `puVar14`, `q`, `rowDelta`, `shape_idx`, `shape_overlap`, `shape_short`, `shape_visible`, `shape_w_idx`

### `Hud_GoTpage__Fi` (0x800d1d6c, hud.cpp:310, map=exact)

- Extra source locals: `addr_24`, `p`, `tp1`, `tp1_hi`

### `Hud_BuildSprite__FP4SPRTiiiUli` (0x800d1f98, hud.cpp:357, map=exact)

- Extra source locals: `pHVar3`, `tu1`, `uVar1`, `uVar2`, `uVar4`, `uVar5`

### `Hud_FBuildSprite__FiiiUli` (0x800d2070, hud.cpp:396, map=exact)

- Extra source locals: `prev_pkt`

### `Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl` (0x800d21c4, hud.cpp:434, map=exact)

- Extra source locals: `iVar2`, `iVar3`, `uVar1`

### `Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl` (0x800d2288, hud.cpp:452, map=exact)

- Extra source locals: `tpage_clut`, `tu2`, `uVar1`, `uVar2`, `uVar3`, `uv23_pack`, `w_h_pack`

### `Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` (0x800d2334, hud.cpp:480, map=exact)

- Extra source locals: `tu2`, `tu3`, `tu4`, `tu5`, `uVar1`, `uVar2`, `uVar3`

### `Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` (0x800d2424, hud.cpp:506, map=exact)

- Extra source locals: `tu2`, `tu3`, `tu4`, `tu5`, `uVar1`, `uVar2`, `uVar3`, `uVar4`

### `Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli` (0x800d2528, hud.cpp:535, map=exact)

- Extra source locals: `tu2`, `tu3`, `uVar1`, `uVar2`, `uVar3`, `uVar4`

### `Hud_BuildF4__FP7POLY_F4iiiiiUl` (0x800d2634, hud.cpp:564, map=exact)

- Extra source locals: `uVar3`

### `Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl` (0x800d26d8, hud.cpp:581, map=exact)

- Extra source locals: `uVar3`

### `Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc` (0x800d2794, hud.cpp:602, map=exact)

- Extra source locals: `uVar1`, `uVar2`, `uVar3`, `uVar4`

### `Hud_FBuildGT4__FP13HudPmx_tShapeiiUl` (0x800d2868, hud.cpp:626, map=exact)

- Extra source locals: `pkt_addr24`, `prev_hi`, `prev_pkt`

### `Hud_FBuildFT4__FP13HudPmx_tShapeiiUl` (0x800d28f4, hud.cpp:645, map=exact)

- Extra source locals: `pkt_addr24`, `prev_hi`, `prev_pkt`

### `Hud_FBuildF4__FiiiiiUlcc` (0x800d2984, hud.cpp:688, map=exact)

- Extra source locals: `prev_pkt`

### `uppercase__FPc` (0x800d2a44, hud.cpp:702, map=exact)

- Extra source locals: `pbVar2`

### `Hud_BuildTimeSprites__FP4SPRTPcii` (0x800d2ef8, hud.cpp:935, map=exact)

- Extra source locals: `bVar3`, `bVar4`, `bVar5`, `cVar2`, `n`, `pcVar6`, `uVar7`

### `Hud_Init__Fv` (0x800d302c, hud.cpp:1049, map=exact)

- Extra source locals: `syc`, `sye`

### `Hud_InitTables__Fv` (0x800d39ec, hud.cpp:1291, map=exact)

- Extra source locals: `patVar1`

### `Hud_BuildTach__Fi` (0x800d3e94, hud.cpp:1724, map=exact)

- Extra source locals: `clutx`, `pal`, `pal2`, `tachNeedle_p`, `tp3`, `tp9`, `ts1`, `ts3`, `ts4`

### `Hud_BuildString__FPciiiib` (0x800d42c8, hud.cpp:1971, map=exact)

- Extra source locals: `as`, `iw1`, `iw2`, `iw3`, `iw4`, `iw5`

### `Hud_BuildNumbers0__Fi` (0x800d4624, hud.cpp:2286, map=exact)

- Extra source locals: `eSprt`, `etime`, `last`, `p`, `pal`, `pal_2`, `primAddr`, `y_2`

### `Hud_BuildNumbers__Fi` (0x800d4e70, hud.cpp:2837, map=exact)

- Extra source locals: `pal`, `pal_2`, `pal_3`, `xt`

### `Hud_InitMap__Fv` (0x800d5a48, hud.cpp:3090, map=exact)

- Extra source locals: `iVar4`

### `Hud_BuildMapMarkers__Fi` (0x800d5ae8, hud.cpp:3320, map=exact)

- Extra source locals: `aiflags`, `car`, `cflags`, `mapx`, `pal`, `pktcell`

### `Hud_BuildWingmanInterface__Fi` (0x800d606c, hud.cpp:3614, map=exact)

- Extra source locals: `fc`, `iconRow`, `now`, `pal`, `two`, `xf`

### `Hud_BuildCdPlayer__Fii` (0x800d63dc, hud.cpp:3920, map=exact)

- Extra source locals: `arg1`, `bVar2`, `dxk`, `i`, `lt`, `lt4`, `scz`, `uVar5`, `wordId`

### `Hud_BuildRadar__Fi` (0x800d6b48, hud.cpp:4331, map=exact)

- Extra source locals: `pal`, `tag`

### `Hud_BuildReplay__Fv` (0x800d7250, hud.cpp:4548, map=exact)

- Extra source locals: `pal`, `palL`, `tSs1`, `tSs1_2`, `tSs1_3`

### `Hud_NextPlayer__Fi` (0x800d754c, hud.cpp:4695, map=exact)

- Extra source locals: `carObj_00`, `iVar1`, `iVar4`, `uVar3`, `uVar5`

### `Hud_NextPlayerNameOrCarOrTime__Fi` (0x800d76b0, hud.cpp:4786, map=exact)

- Extra source locals: `carObj_00`, `iVar1`, `iVar2`, `iVar3`, `uVar4`

### `Hud_RenderMapView__Fv` (0x800d7838, hud.cpp:4857, map=exact)

- Extra source locals: `pal`, `tp`

### `Hud_BlackThinBox__Fiiii` (0x800d7abc, hud.cpp:4940, map=exact)

- Extra source locals: `CORNERWIDTH`, `side_h`, `side_y`, `top_w`, `x_left`, `x_right`, `y_bottom`

### `Hud_Draw321Num__Fiiiiii` (0x800d7ca8, hud.cpp:4970, map=exact)

- Extra source locals: `arg4`, `arg5`, `by2`

### `Hud_Render321Go__Fv` (0x800d7e64, hud.cpp:5178, map=exact)

- Extra source locals: `flare_intensity_00`, `num_00`, `uVar1`, `y_00`

### `Hud_RenderHudView__Fv` (0x800d82d0, hud.cpp:5380, map=exact)

- Extra source locals: `cdshow`, `otmask`, `pal`, `pw`, `tagp`, `tpageOff`, `viewOff`, `viewp`, `ww2p1`

### `Hud_RenderTacView__Fv` (0x800d8c48, hud.cpp:5888, map=exact)

- Extra source locals: `dh`, `j4`, `pal`, `tp`

### `Hud_ParseTime__FiPc` (0x800d8d64, hud.cpp:5943, map=exact)

- Extra source locals: `centi_total`, `iVar1`, `min`, `sec`

### `Hud_Render__Fv` (0x800d9058, hud.cpp:6003, map=exact)

- Extra source locals: `iface`, `j`, `remain`

### `Hud_PositionMap__Fv` (0x800d94c0, hud.cpp:6156, map=exact)

- Extra source locals: `track`

### `Hud_BustedOverlayOn__FiPcbs` (0x800d962c, hud.cpp:6186, map=exact)

- Extra source locals: `iVar2`, `iVar4`, `pcVar1`, `psVar3`

### `Hud_Reset__Fv` (0x800d97f0, hud.cpp:6268, map=exact)

- Extra source locals: `iVar2`, `psVar1`

### `Hud_BTC_QuitOut__Fv` (0x800d9848, hud.cpp:6296, map=exact)

- Extra source locals: `name_tail`, `perp_idx`, `row_base`, `row_off`, `slot_i`

### `Hud_Perp_OverlayOff__Fi` (0x800d9950, hud.cpp:6339, map=exact)

- Extra source locals: `artist`, `cenX`, `cenZ`, `cos`, `flashTicks`, `langSec`, `lx`, `offy`, `ox`, `rpm`, `rx`, `sec`, `sin`, `slice`, `speed`, `temp1`, `ten`, `title`, `u`, `v`, `w7`, `yo`

### `RaceSummary__Fv` (0x800d9a48, overlays.cpp:108, map=exact)

- Extra source locals: `barH`, `halfH`, `titleX`, `titleY`, `w2`

### `RaceStatistics__Fv` (0x800d9fbc, overlays.cpp:441, map=exact)

- Extra source locals: `barH`, `barH8`, `colInset`, `halfH`, `nh`, `one`, `pitch`, `posy`, `posyL`, `rowInset`, `sizeH16`, `titleX`, `titleY`

### `Hud_BTCStats__Fsb` (0x800da728, overlays.cpp:1055, map=exact)

- Extra source locals: `postgameInset`, `sizeH`

### `Hud_RenderStatsView__Fv` (0x800dae8c, overlays.cpp:1297, map=exact)

- Extra source locals: `t`

### `Night_GenerateNextLightningEvent__Fv` (0x800db5cc, night.cpp:701, map=exact)

- Extra source locals: `fork`, `r`, `rmask`, `ticksp`

### `Night_DoLightningEffect__FP13DRender_tView` (0x800db6c4, night.cpp:753, map=exact)

- Extra source locals: `r`, `tunnel`

### `Night_SetWeatherColors__Fi` (0x800dbad4, night.cpp:991, map=exact)

- Extra source locals: `colorH`, `color_walk`, `wtbl`, `wtblp`

### `Night_RestartNightDriving__Fv` (0x800dc020, night.cpp:1202, map=exact)

- Extra source locals: `r`

### `Night_SetEnviroment__FP13DRender_tView` (0x800dc0a8, night.cpp:1410, map=exact)

- Extra source locals: `mode`, `tgt`, `zn`, `zn2`

### `Platform_ReserveMemory__FiPc` (0x800dc2e8, platform.cpp:87, map=exact)

- Extra source locals: `mem`, `newmem`

### `Platform_SysStartUp__Fv` (0x800dc378, platform.cpp:134, map=exact)

- Extra source locals: `userRam`

### `Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle` (0x800dd790, sfx.cpp:841, map=exact)

- Extra source locals: `ds`, `link`, `m`, `ot2`, `p0f`, `p1f`, `p2f`, `p3f`, `w`

### `Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii` (0x800deb98, skidmark.cpp:172, map=exact)

- Extra source locals: `n`

### `Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii` (0x800def6c, skidmark.cpp:237, map=exact)

- Extra source locals: `n`

### `Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi` (0x800df688, texture.cpp:60, map=exact)

- Extra source locals: `count`, `num`

### `Texture_Vramf__FP8shapetbliiii` (0x800dfb8c, texture.cpp:335, map=exact)

- Extra source locals: `deadfrm`, `kind`, `nextshp`, `rowpix`, `rowround`

### `Texture_Vramcf__FP8shapetbliiii` (0x800dfd38, texture.cpp:430, map=exact)

- Extra source locals: `h`, `off`, `rowall`, `ybot`

### `Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap` (0x800dff18, texture.cpp:520, map=exact)

- Extra source locals: `fl`

### `Texture_InitMenuClut__Fv` (0x800e0510, texture.cpp:733, map=exact)

- Extra source locals: `cbase`, `clut`, `pal4`, `pal8`

### `TextureProcess_ColorClut__FiiPciii` (0x800e08b8, textureprocess.cpp:41, map=exact)

- Extra source locals: `p`, `spec`

### `Fog_Update__Fi` (0x800e0d80, textureprocess.cpp:247, map=exact)

- Extra source locals: `slot`, `start`

### `Fog_InitFogTriggers__Fv` (0x800e102c, textureprocess.cpp:365, map=exact)

- Extra source locals: `openkey_walk`, `openval`, `slice_off`

### `Weather_InitSplats__Fv` (0x800e1fd8, weather.cpp:257, map=exact)

- Extra source locals: `commModeNetwork`, `gs`, `result`, `rnd`, `splat_i`, `uVar1`, `y_max`

### `Weather_Init__Fv` (0x800e2530, weather.cpp:530, map=exact)

- Extra source locals: `iVar6`, `iVar7`, `iVar8`, `pSVar10`, `pcVar2`, `piVar3`, `pmVar4`, `pmVar5`, `psVar9`, `uVar1`

### `Weather_CheckAndResetParticles__FP7SVECTOR` (0x800e29d4, weather.cpp:767, map=exact)

- Extra source locals: `pt_reg`, `reset_flag`, `rnd`, `sVar3`, `sVar4`, `uVar1`, `uVar2`, `z_off`

### `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc` (0x800e2fd0, weather.cpp:933, map=exact)

- Extra source locals: `reset`, `tr`

### `Weather_CreateSnow__FP7SVECTOR` (0x800e33bc, weather.cpp:1048, map=exact)

- Extra source locals: `addr24`, `next`, `pal`, `palw`

### `Weather_CreateRain__FP7SVECTORP7DVECTORPc` (0x800e356c, weather.cpp:1152, map=exact)

- Extra source locals: `addr24`, `pal`, `palw`

### `Weather_CreateSplat__FP18Weather_tSplatInfo` (0x800e3730, weather.cpp:1240, map=exact)

- Extra source locals: `addr24`, `col`, `next`, `palw`, `pmx`, `tp3`

### `Weather_DoSplats__FiP18Weather_tSplatInfo` (0x800e3858, weather.cpp:1461, map=exact)

- Extra source locals: `q`

### `Weather_DoWeather__FP13DRender_tView` (0x800e3a1c, weather.cpp:1546, map=exact)

- Extra source locals: `addr24`, `cm`, `mode`, `next`, `one`, `pal`, `palw`, `plb`

### `Fe3D_InitShowroom__Fv` (0x80012938, fe3dmenu.cpp:54, map=exact)

- Extra source locals: `cos_raw`, `iVar1`, `pCVar6`, `sVar4`, `sh`

### `Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii` (0x80012bf8, fe3dmenu.cpp:171, map=exact)

- Extra source locals: `bVar1`, `m`, `mr`

## Explicit SYM carrier/optimization mappings

- `DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32`: `tempcop`, `tempnight`
- `Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle`: `check`, `dest`, `invertedm`, `l0`, `l1`, `l2`, `l3`, `pmx`, `pt`, `ptrans`, `scale`, `tpage`
- `Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc`: `pt`

## Explicit source-only codegen carriers

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
- `Font_SetABR__Fi`: `y`
- `Font_Getcharacter__Fi`: `base_00`
- `Loading_UpdateLoadingScreen__Fi`: `tile`, `y`
- `Platform_InitMemory__Fv`: `m`
- `InGame_SetRamp__Fv`: `hb`
- `Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache`: `addr24`, `ot2`, `w`
- `Skidmark_CheckChunk__FP8coorddefii`: `d`, `nseg`
- `Texture_CopyPalette__FPciii`: `zero`
- `Fog_AllocKey__Fv`: `one`
- `TrackSpec_Read__Fi`: `filebuf`, `trk`
- `Weather_TransformVertex__FP10matrixtdefiP7SVECTOR`: `next`
- `textnpixels`: `fontbase`

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
- `drawc_w76a7.cpp` extra definitions: `DrawC_gEnvMap`, `DrawC_gEnvMapMax`, `DrawC_gMenuLightsDirection`, `DrawC_gReflectOffset`, `DrawC_gShadow`, `DrawC_gShadowMax`, `DrawC_gWetRoad`, `SP`
- `draww.cpp` extra definitions: `DrawWTrough_scratchVec`, `DrawW_gChunkGeomRez`, `DrawW_gChunkInd`, `DrawW_gChunkObjFlag`, `DrawW_gChunkQuadCount`, `DrawW_gChunkRelX`, `DrawW_gChunkRelY`, `DrawW_gChunkRelZ`, `DrawW_gChunkStripBuf`, `DrawW_gChunkVtxBuf`, `DrawW_gFog_init`, `DrawW_gGroupCount`, `DrawW_gGroupPtr`, `DrawW_gInitialArtPtr`, `DrawW_gMatID_tmp`, `DrawW_gMaterialLUT`, `DrawW_gNightFlags`, `DrawW_gNightTmpFlag`, `DrawW_gObjScratch_148`
- `draww__a5probe.cpp` extra definitions: `DrawWTrough_scratchVec`, `DrawW_gChunkGeomRez`, `DrawW_gChunkInd`, `DrawW_gChunkObjFlag`, `DrawW_gChunkQuadCount`, `DrawW_gChunkRelX`, `DrawW_gChunkRelY`, `DrawW_gChunkRelZ`, `DrawW_gChunkStripBuf`, `DrawW_gChunkVtxBuf`, `DrawW_gFog_init`, `DrawW_gGroupCount`, `DrawW_gGroupPtr`, `DrawW_gInitialArtPtr`, `DrawW_gMatID_tmp`, `DrawW_gMaterialLUT`, `DrawW_gNightFlags`, `DrawW_gNightTmpFlag`, `DrawW_gObjScratch_148`, `animation_timer`, `gChunkObjInfo`, `gDiv`, `gIdentTemplate`, `gSD_gt3counter`, `gSD_gt4counter`, `gVertex3d`, `gVi`, `gWSavePtr`, `goffsets`, `stackSpeedUpEnbabledFlag`, `trk0`, `trk4`
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

