/* game/psx/drawc.cpp -- RECONSTRUCTED (NFS4 PSX world-geometry draw; C++ TU)
 *   35 fns: subdivision facets, world matrix/translation setup, night colour calc, DrawW_DrawQuad,
 *   object/chunk facet builders, object transforms, skidmarks, lines/spike-belt, anim timers, depth cue.
 *   GTE-heavy (142 cop2 stubs -> gte_ intrinsics). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "drawc_externs.h"

/* ---- EA DMPSX-analog OT-link templates (2026-07-09, see fastmovf.c + hub) ----
 * Variant A (FT3 alloc): prim = sd->PrimPtr; slot = sub_ot+otz; PrimPtr += 0x20;
 *   prim->tag = slot->addr24 | 7<<24; slot->addr24 = prim.  prim -> OUTPUT reg.
 * Variant B (12-byte mode packet): copy 3 words from sd+OFF (prebuilt DR_MODE
 *   packet, word0 already carries the len byte); FUSED 24-bit link (extract/insert
 *   shifts cancel).  Fully fixed regs incl. $s0 (forces the s0 save). */
#define DRAWC_OTLINK_FT3(sd_, primout_) __asm__ volatile( \
    "lw\t%0,4(%1)\n\tlw\t$t4,60(%1)\n\tlw\t$t5,56(%1)\n\taddiu\t$t6,%0,32\n\tsll\t$t4,$t4,2\n\taddu\t$t5,$t5,$t4\n\tsw\t$t6,4(%1)\n\tlwl\t$t6,2($t5)\n\tlui\t$t4,0x0700\n\tsrl\t$t6,$t6,8\n\tor\t$t6,$t6,$t4\n\tsll\t$t4,%0,8\n\tsw\t$t6,0(%0)\n\tswl\t$t4,2($t5)" \
    : "=&r"(primout_) : "r"(sd_) : "$12", "$13", "$14", "memory")
/* split form: prim pre-loaded by COMPILER code (retail interleaves that lw with
 * neighbouring reg math, e.g. the overlay pTVar23 compute -- an atomic 14-insn
 * asm can't reproduce that); the asm does the remaining 13-insn link tail. */
#define DRAWC_OTLINK_FT3B(sd_, prim_) __asm__ volatile( \
    "lw\t$t4,60(%1)\n\tlw\t$t5,56(%1)\n\taddiu\t$t6,%0,32\n\tsll\t$t4,$t4,2\n\taddu\t$t5,$t5,$t4\n\tsw\t$t6,4(%1)\n\tlwl\t$t6,2($t5)\n\tlui\t$t4,0x0700\n\tsrl\t$t6,$t6,8\n\tor\t$t6,$t6,$t4\n\tsll\t$t4,%0,8\n\tsw\t$t6,0(%0)\n\tswl\t$t4,2($t5)" \
    : : "r"(prim_), "r"(sd_) : "$12", "$13", "$14", "memory")
/* srcoff passed as THREE pre-folded string offsets ("84","88","92") -- a
 * "OFF+4(%0)" sum displacement makes the assembler expand the lui-$at
 * address macro (3 insns) instead of a direct load (CONT 2026-07-09b). */
#define DRAWC_OTLINK_MODE(sd_, off0_, off1_, off2_) __asm__ volatile( \
    "lw\t$t4,4(%0)\n\tlw\t$t5,60(%0)\n\tlw\t$t6,56(%0)\n\taddiu\t$t7,$t4,12\n\tsll\t$t5,$t5,2\n\taddu\t$t6,$t6,$t5\n\tsw\t$t7,4(%0)\n\tlw\t$t5," off0_ "(%0)\n\tlw\t$t7," off1_ "(%0)\n\tlw\t$s0," off2_ "(%0)\n\tsw\t$t5,0($t4)\n\tsw\t$t7,4($t4)\n\tsw\t$s0,8($t4)\n\tlwl\t$t5,2($t6)\n\tsll\t$t7,$t4,8\n\tswl\t$t5,2($t4)\n\tswl\t$t7,2($t6)" \
    : : "r"(sd_) : "$12", "$13", "$14", "$15", "$16", "memory")

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
DrawC_tEnvMap *DrawC_gEnvMap;
DrawC_tEnvMap *DrawC_gShadow;
int DrawC_gEnvMapMax;
int DrawC_gMenuLightsDirection;
int DrawC_gShadowMax;
int DrawC_gWetRoad;
short DrawC_gReflectOffset;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void ChangeTPage(u_short *tpage,int nabr);
void DrawC_SetEnviroment(void);
void DrawC_ReadLightingData(void);
void DrawC_ReadeMapData(void);
void DrawC_BuildRenderingData(void);
void DrawC_KillRenderingData(void);
void DrawC_NightHeadlight(Car_tObj *carObj);
void DrawC_MenuColorData(int color,Car_tObj *carObj,int player);
int DrawC_PrimStart(Draw_tVertex *center,Car_tObj *carObj,int lightAvg,Draw_CarCache *sd);
void DrawC_PrimStop(Car_tObj *carObj,Draw_CarCache *sd);
void DrawC_ShadowPrim(Draw_tVertex *shadowVT,Draw_CarCache *sd);
void DrawC_ShadowPrimClip(Draw_tVertex *shadowVT,Draw_CarCache *sd);
void DrawC_SpotPrims(matrixtdef *m,coorddef *t,Draw_CarCache *sd);
void DrawC_ShowroomPrims(matrixtdef *m,coorddef *t,Draw_CarCache *sd);


/* ---- ChangeTPage__FPUsi  [DRAWC.CPP:112-114] SLD-VERIFIED ---- */
void ChangeTPage(u_short *tpage,int nabr)

{
  *tpage = *tpage & 0xff9f | (u_short)(nabr << 5);
  return;
}

/* ---- DrawC_SetEnviroment__Fv  [DRAWC.CPP:119-120] SLD-VERIFIED ---- */
void DrawC_SetEnviroment(void)

{
  return;
}

/* ---- DrawC_ReadLightingData__Fv  [DRAWC.CPP:123-177] SLD-VERIFIED ---- */
void DrawC_ReadLightingData(void)

{
  int i;
  char *ScaneData;
  char *RenderingFileData;
  char name [256];

  sprintf(name,"%sTr%02d.env",Paths_Paths[6],GameSetup_gData.track);
  RenderingFileData = (char *)loadfileadr(name,0x10);
  ScaneData = RenderingFileData;
  DrawC_gEnvMapMax = Risk_ReadNextValue(&ScaneData);
  DrawC_gEnvMap = reservememadr("envmap",DrawC_gEnvMapMax * 6,0);
  if (0 < DrawC_gEnvMapMax) {
    i = 0;
    do {
      DrawC_gEnvMap[i].slice = (short)Risk_ReadNextValue(&ScaneData);
      DrawC_gEnvMap[i].tex = (short)Risk_ReadNextValue(&ScaneData);
      DrawC_gEnvMap[i].extra = (short)(Risk_ReadNextValue(&ScaneData) << 8);
      DrawC_gEnvMap[i].extra = DrawC_gEnvMap[i].extra + (short)Risk_ReadNextValue(&ScaneData);
      if (DrawC_gEnvMap[i].slice < 0) {
        DrawC_gEnvMap[i].slice = 0x7fff;
        break;
      }
      i = i + 1;
    } while (i < DrawC_gEnvMapMax);
  }
  DrawC_gShadowMax = Risk_ReadNextValue(&ScaneData);
  DrawC_gShadow = reservememadr("Shadow",DrawC_gShadowMax * 6,0);
  if (0 < DrawC_gShadowMax) {
    i = 0;
    do {
      DrawC_gShadow[i].slice = (short)Risk_ReadNextValue(&ScaneData);
      DrawC_gShadow[i].tex = (short)Risk_ReadNextValue(&ScaneData);
      DrawC_gShadow[i].extra = (short)(Risk_ReadNextValue(&ScaneData) << 8);
      DrawC_gShadow[i].extra = DrawC_gShadow[i].extra + (short)Risk_ReadNextValue(&ScaneData);
      if (DrawC_gShadow[i].slice < 0) {
        DrawC_gShadow[i].slice = 0x7fff;
        break;
      }
      i = i + 1;
    } while (i < DrawC_gShadowMax);
  }
  purgememadr(RenderingFileData);
  return;
}

/* ---- DrawC_ReadeMapData__Fv  [DRAWC.CPP:181-182] SLD-VERIFIED ---- */
void DrawC_ReadeMapData(void)

{
  R3DCcar_ReadeMapData();
  return;
}

/* ---- DrawC_BuildRenderingData__Fv  [DRAWC.CPP:190-198] SLD-VERIFIED ---- */
void DrawC_BuildRenderingData(void)

{
  DrawC_ReadLightingData();
  DrawC_ReadeMapData();
  R3DCcar_ReadTrackShadow();
  return;
}

/* ---- DrawC_KillRenderingData__Fv  [DRAWC.CPP:208-210] SLD-VERIFIED ---- */
void DrawC_KillRenderingData(void)

{
  purgememadr(DrawC_gEnvMap);
  purgememadr(DrawC_gShadow);
  return;
}

/* ---- DrawC_NightHeadlight__FP8Car_tObj  [DRAWC.CPP:214-265] SLD-VERIFIED ---- */
void DrawC_NightHeadlight(Car_tObj *carObj)

{
  int i;
  short newB;
  Car_tObj **ppCVar1;
  coorddef *pos;
  short newG;
  short newR;
  MATRIX nightMat;
  VECTOR nightV;
  PCOORD16 zero;
  coorddef tmp;
  coorddef tmp2;
  int *light;

  /* @0x800BE9A8-AC: light = &carObj->render.light, set unconditionally (before the lights&6 test);
   * used by the Night_AdditiveNightCalc call and by the lightning-tint block below. `pos` (SYM REG
   * $a2) = &carObj->N.position, likewise materialized unconditionally (the compiler schedules the
   * pure-address addiu into the branch's delay slot regardless of source position). */
  light = (int *)&(carObj->render).light;
  if (((Cars_gList[gCView.player]->control).lights & 6U) != 0) {
    pos = &(carObj->N).position;
    ppCVar1 = Cars_gHumanRaceCarList + gCView.player;
    tmp.x = (carObj->N).position.x - ((*ppCVar1)->N).position.x;
    tmp.y = pos->y - ((*ppCVar1)->N).position.y;
    tmp.z = pos->z - ((*ppCVar1)->N).position.z;
    transform(&tmp.x,gNightMat.m,&tmp2.x);
    DrawW_WorldSetUpTranslation(&tmp2,&nightMat);
    DrawW_WorldSetUpMatrix(&gNightMat,&nightMat);
    zero.z = 0;
    zero.y = 0;
    zero.x = 0;
    gte_ldv0(&zero);
    gte_rt();
    gte_stlvnl(&nightV);
    Night_AdditiveNightCalc(&nightV,(CVECTOR *)light);
  }
  /* @0x800BEA80-EB10: weather/lightning RGB tint -- ALWAYS runs (fall-through from the lights&6 test).
   * Adds Night_gWeatherColor[Night_gLightningType] (read as 3 bytes R/G/B) to the low 3 bytes of the
   * `light` local, clamps each channel to 0xFF, and writes back. The binary reads/writes the bytes of
   * the `light` POINTER slot itself (104+$sp = &light), NOT *light -- gcc-2.7.2 preserved these stores
   * because &light escapes. Reproduced byte-faithfully; this whole block was missing (H46). */
  if (Night_gDrawLightning != '\0') {
    newR = (short)((int)*(u_char *)&light +
                   (int)*(u_char *)&Night_gWeatherColor[Night_gLightningType]);
    newG = (short)((int)((u_char *)&light)[1] +
                   (int)((u_char *)&Night_gWeatherColor[Night_gLightningType])[1]);
    newB = (short)((int)((u_char *)&light)[2] +
                   (int)((u_char *)&Night_gWeatherColor[Night_gLightningType])[2]);
    if (0xff < newR) {
      newR = 0xff;
    }
    if (0xff < newG) {
      newG = 0xff;
    }
    if (0xff < newB) {
      newB = 0xff;
    }
    *(char *)&light = (char)newR;
    ((char *)&light)[1] = (char)newG;
    ((char *)&light)[2] = (char)newB;
  }
  return;
}

/* ---- DrawC_MenuColorData__FiP8Car_tObji  [DRAWC.CPP:388-527] SLD-VERIFIED ---- */
void DrawC_MenuColorData(int color,Car_tObj *carObj,int player)

{
  int menuColor;
  int sVar1;
  int carType;
  int carType0;
  int iVar3;
  GameSetup_tCarData *pGVar4;
  Texture_pal8bit *palCopy;
  char *shpfile;
  char filename [10];
  char infilename [100];

  pGVar4 = carObj->carInfo;
  carType0 = pGVar4->carType;
  if (carObj->async_handle == 0) {
    if ((int)(carObj->render).currentCarType != carType0) {
      return;
    }
    (carObj->render).upgradeFlags =
         (char)pGVar4->EngineMods + (char)pGVar4->WeightTransfer * '\x02' +
         (char)pGVar4->GroundEffects * '\x04';
    if ((u_int)((u_short)(carObj->render).currentCarType - 0x10) < 3) {
      (carObj->render).upgradeFlags = '\a';
    }
    menuColor = color + ((u_int)(u_char)(carObj->render).upgradeFlags & 1) * 0x100 +
                ((u_int)(u_char)(carObj->render).upgradeFlags & 2) * 0x100;
    int *menuColorSlot = DrawC_gMenuColor + player;
    if (*menuColorSlot == menuColor) {
      return;
    }
    *menuColorSlot = menuColor;
    DrawSync(0);
    carType = (int)(carObj->render).currentCarType;
    if (carType < 0x1c) {
      if ((color & 8U) != ((u_short)(carObj->render).colorIndex & 8)) {
        R3DCar_GetCarName(filename,carType,carObj->carInfo->Country);
        if (color >= 8) {
          strcat(filename,"d");
        }
        else {
          strcat(filename,"l");
        }
        strcpy(infilename,Paths_Paths[0x18]);
        strcat(infilename,filename);
        strcat(infilename,".psh");
        shpfile = (char *)loadfileadr(infilename,0x10);
        CarIO_UpdateCarTextureData(shpfile,carObj,player);
        purgememadr(shpfile);
        DrawSync(0);
      }
      Texture_CarColor = (color & 7U) + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
      Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,0,1);
      iVar3 = 1;
      palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
      sVar1 = (carObj->render).palNum;
      Texture_CarColor = (color & 7U) + ((u_char)(carObj->render).upgradeFlags & 1) * 8;
    }
    else {
      iVar3 = 0;
      palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
      sVar1 = (carObj->render).palNum;
      Texture_CarColor = color & 7;
    }
    Texture_ProcessPaletteCopy(palCopy,iVar3,sVar1);
  }
  (carObj->render).colorIndex = (short)color;
  return;
}

/* ---- DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache  [DRAWC.CPP:1148-1531] SLD-VERIFIED ---- */
int DrawC_PrimStart(Draw_tVertex *center,Car_tObj *carObj,int lightAvg,Draw_CarCache *sd)

{
  int i;
  int cop_flag;
  int half;
  int mirror;
  int overlay;
  int eSpeed;
  int quad;
  short envMap;
  int eColor;
  int eColor2;
  u_int uVar1;
  Draw_tPixMap *pDVar2;
  short tu12;
  int envColor2;
  int sub_ot_p;
  int sub_otz_x4;
  int lightTable;
  int drawEnv_p;
  int envTexShape;
  int tunnelFlag;
  int shapeData_p;
  short extraShadow;
  int sub_otz_h2;
  int sub_otOffset;
  short extraEnvMap;
  int iVar3;
  short shadow;
  u_char *puVar4;
  int lightAvgScaled;
  int envColor;
  u_int uVar5;
  int shadowQuad;
  int matPart_a;
  int menuPmx_w2;
  int matPart_b;
  int menuPmx_w3;
  int menuPmx_w0;
  int menuPmx_w1;
  int sub_otz;
  int shapeIdx;
  int vertBuf_p;
  int carType;
  int vertCount;
  DRAWENV *LEnv;
  int tpageShadow;
  int nabr_blend;
  int envSpeed;
  int shadowAbsOffs;
  int halfTransp;
  void *tp1;
  u_int shadowTex;
  Draw_tPixMap *reflMap_iter;
  u_int envMapTex;
  u_int shadow_align_a;
  u_int envMap_w0;
  short eIndexEnvMap;
  u_int envMap_w3;
  short eIndexShadow;
  short headLight_bits;
  u_char envMapBigBit;
  int tp2;
  void *tp3;
  short ts13;
  short tu14;
  short tu15;
  u_int envMap_align_a;
  u_int shadowMap_w1;
  u_char carTypeOffRange;
  int tp8;
  u_int envMap_align_b;
  int tp12;
  u_int shadowMap_w2;
  int tp11;
  long sub_otSize_local;
  u_int shadow_align_b;
  u_int *tp17;
  u_char *tp20;
  u_char *tp4;
  u_short tu27;
  
  envMapBigBit = false;
  vertCount = (int)(carObj->render).currentCarType;
  matPart_a = (int)&DrawC_gScreenMat;
  carTypeOffRange = vertCount - 0x16U < 6;
gte_SetRotMatrix(&DrawC_gScreenMat);
  matPart_b = (int)&DrawC_gScreenMat;
gte_SetTransMatrix(&DrawC_gScreenMat);
  gte_ldv0(center);
  gte_rtps();
  /* oracle reads SZ3 via `mfc2 reg,$19` (not swc2) -> a normal sw; no psx_gte.h macro fits, so
   * use the faithful inline cop2-move read (host stub: 0). [@0x800BEDF4 mfc2 $t4,$19]
   * KNOWN BUG -- FIXED at the store sites below (2026-07-11 consolidation; costs ~17 fuzzy
   * diffs because our cc1plus CSEs away a redundant memory round-trip the PsyQ compiler kept):
   * oracle immediately does `sra $t4,$t4,2` BEFORE the `sw $t4,0x40($s3)` store, i.e. the true
   * source is `sd->sub_otz = shapeIdx >> 2;` (we store the RAW unshifted value here). Oracle then
   * RELOADS sd->sub_otz from memory and does `sra $v1,$s0,1` for sub_otz_h2 (true source:
   * `sub_otz_h2 = sd->sub_otz >> 1;`, i.e. shapeIdx>>3 -- we use `shapeIdx>>1`, an extra factor of
   * 4 too large). Downstream at line ~419 oracle computes `(carObj->render).sub_otz = sub_otz_x4 +
   * sub_otOffset - ((shapeIdx>>2)<<2)` (mask off the low 2 bits of the raw SZ3, i.e. `-(shapeIdx &
   * ~3)`) -- our `+ shapeIdx * -4` scales by -4 instead, a materially different (and wrong) value
   * feeding carObj->render.sub_otz, the depth-sort key used by DrawC_PrimStop/other OT-link code.
   * This was a genuine rendering-visible bug; both fixes are now APPLIED below. */
#if defined(__mips__)
  __asm__ volatile ("mfc2 %0, $19" : "=r"(shapeIdx));
#else
  shapeIdx = 0;
#endif
  /* [2026-07-11 consolidation] APPLIED the depth-sort-key fix documented above (correctness
     over byte-match per project policy): shapeIdx (raw SZ3) is scaled >>2 before the store,
     sub_otz_h2 derives from the STORED value (>>1 of that), and the downstream
     carObj->render.sub_otz subtracts (shapeIdx>>2)<<2, not shapeIdx*4. Oracle-evidenced:
     `sra $t4,$t4,2` before `sw 0x40($s3)` @0x800BEDF8. Costs ~17 fuzzy diffs (our cc1plus
     CSEs a reload the PsyQ compiler kept) -- accepted. */
  shapeIdx = shapeIdx >> 2;
  sd->sub_otz = shapeIdx;
  sub_otz_h2 = sd->sub_otz >> 1;
  if (R3DCar_InMenu == 0) {
    sd->sub_otz = sub_otz_h2;
    if ((sub_otz_h2 < 0) || (Draw_gViewOtSize + -3 < sub_otz_h2)) {
      return -1;
    }
  }
  else {
    sd->sub_otz = 0;
  }
  puVar4 = (carObj->render).sort_carObj;
  (carObj->render).world_otz = sd->sub_otz;
  if (puVar4 == (u_char *)0x0) {
    sub_ot_p = (int)(carObj->render).sub_ot;
    sd->sub_ot = (u_long *)sub_ot_p;
    sub_otSize_local = (carObj->render).sub_otSize;
    sd->sub_otSize = sub_otSize_local;
    ClearOTagR((u_long *)sub_ot_p,sub_otSize_local);
    sd->sub_otz = 0;
    sub_otOffset = (carObj->render).sub_otOffset;
  }
  else {
    sd->sub_ot = *(u_long **)(puVar4 + 0x86c);
    sd->sub_otSize = *(int *)(puVar4 + 0x870);
    sd->sub_otz = (sd->sub_otz - *(int *)(puVar4 + 0x864)) * 2;
    sub_otOffset = *(int *)(puVar4 + 0x874);
  }
  sub_otz_x4 = sd->sub_otz * 4;
  sd->sub_otz = sub_otz_x4;
  (carObj->render).sub_otz = sub_otz_x4 + sub_otOffset - (shapeIdx << 2);
  sd->sub_otSize = sd->sub_otSize + -1;
  sd->pmxStart = CarIO_carPixMap + (carObj->render).textureStartIndex;
  sd->offsetU0 = (u_char)(carObj->render).textureOffsetU;
  sd->offsetV0 = (u_char)(carObj->render).textureOffsetV;
  sd->offsetU1 = (carObj->render).licenseOffsetU[0];
  sd->offsetV1 = (carObj->render).licenseOffsetV[0];
  lightAvgScaled = 0x32;
  sd->offsetU2 = (carObj->render).licenseOffsetU[1];
  lightTable = -0x7fee0a94;
  sd->offsetV2 = (carObj->render).licenseOffsetV[1];
  do {
    *(u_short *)lightTable = 0;
    lightAvgScaled = lightAvgScaled + -1;
    lightTable = lightTable + -2;
  } while (-1 < lightAvgScaled);
  if (R3DCar_InMenu == 0) {
    int damageLevel = (carObj->N).damage[0];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 1;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 1;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 2;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 2;
    }
    damageLevel = (carObj->N).damage[2];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 0x100;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x100;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[0] = DrawC_gOverlay[0] | 0x200;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x200;
    }
    damageLevel = (carObj->N).damage[3];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x400;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x800;
    }
    damageLevel = (carObj->N).damage[4];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 0x100;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x1000;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 0x200;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x2000;
    }
    damageLevel = (carObj->N).damage[6];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 1;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x10;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[1] = DrawC_gOverlay[1] | 2;
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 0x20;
    }
    damageLevel = (carObj->N).damage[7];
    if (0x1e0001 <= damageLevel) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 4;
    }
    else if (0xa0000 < damageLevel) {
      DrawC_gOverlay[2] = DrawC_gOverlay[2] | 8;
    }
    if (0x30000 < (carObj->N).damage[8]) {
      DrawC_gOverlay[4] = DrawC_gOverlay[4] | 0x101;
    }
    if (((carObj->render).brakeLight & 1U) != 0) {
      if ((DrawC_gOverlay[1] & 1U) == 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x81;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x81;
      }
      if ((DrawC_gOverlay[1] & 0x100U) == 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x8100;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x8100;
      }
    }
    if ((carObj->control).gear == '\0') {
      if ((DrawC_gOverlay[1] & 1U) == 0) {
        DrawC_gOverlay[0x1a] = DrawC_gOverlay[0x1a] | 0x80;
      }
      if ((DrawC_gOverlay[1] & 0x100U) == 0) {
        DrawC_gOverlay[0x1a] = DrawC_gOverlay[0x1a] | 0x8000;
      }
    }
    headLight_bits = (carObj->render).headLight;
    if ((headLight_bits & 0x11U) != 0) {
      if (((headLight_bits & 0x40U) != 0) || ((DrawC_gOverlay[0] & 1U) == 0)) {
        DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] | 0x81;
      }
      if ((((carObj->render).headLight & 4U) != 0) || ((DrawC_gOverlay[0] & 0x100U) == 0)) {
        DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] | 0x8100;
      }
    }
    if (((carObj->render).brakeLight & 2U) != 0) {
      if ((DrawC_gOverlay[1] & 1U) == 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x80;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x80;
      }
      if ((DrawC_gOverlay[1] & 0x100U) == 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x8000;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x8000;
      }
    }
    ts13 = DrawC_gOverlay[0x18];
    if (!carTypeOffRange) {
      shadow_align_b = (sd->head).mirror;
      if (((carObj->render).signalLight[shadow_align_b] & 0x80U) != 0) {
        DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x40;
      }
      if (((carObj->render).signalLight[shadow_align_b] & 8U) != 0) {
        if ((DrawC_gOverlay[0] & 1U) == 0) {
          DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 0x80;
        }
        if ((DrawC_gOverlay[1] & 1U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x81;
        }
      }
      if (((carObj->render).signalLight[shadow_align_b ^ 1] & 0x80U) != 0) {
        DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x4000;
      }
      if (((carObj->render).signalLight[shadow_align_b ^ 1] & 8U) != 0) {
        if ((DrawC_gOverlay[0] & 0x100U) == 0) {
          DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 0x8000;
        }
        if ((DrawC_gOverlay[1] & 0x100U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | 0x8100;
        }
      }
      if (1 < (u_char)""[vertCount]) {
        if ((DrawC_gOverlay[0x1c] & 0x40U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | DrawC_gOverlay[0x18] & 0xffU;
        }
        if ((DrawC_gOverlay[0x1c] & 0x4000U) == 0) {
          DrawC_gOverlay[0x1c] = DrawC_gOverlay[0x1c] | DrawC_gOverlay[0x18] & 0xff00U;
        }
      }
      if (""[vertCount] == '\x03') {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x1c];
        DrawC_gOverlay[0x1c] = ts13;
      }
      goto DrawCPrimStart_carTypeOff;
    }
  }
  else {
DrawCPrimStart_carTypeOff:
    if (!carTypeOffRange) goto DrawCPrimStart_camRotMatrix;
  }
  tu14 = DrawC_gOverlay[0x1b] | 2U;
  tu15 = DrawC_gOverlay[0x1c] | 0x200U;
  if (DrawC_gOverlay[4] == 0) {
    tu12 = DrawC_gOverlay[0x1b] | 0x83;
    DrawC_gOverlay[0x1b] = DrawC_gOverlay[0x1b] | 2U;
    tu27 = DrawC_gOverlay[0x1c] | 0x200U;
    if (DrawC_SirenFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) {
      DrawC_gOverlay[0x1b] = tu12;
      tu27 = DrawC_gOverlay[0x1c] | 0x281;
    }
    DrawC_gOverlay[0x1c] = tu27;
    tu14 = DrawC_gOverlay[0x1b];
    tu15 = DrawC_gOverlay[0x1c];
    if (DrawC_SirenFlash[(u_short)(carObj->render).signalLight[1] & 0xf] != 0) {
      tu14 = DrawC_gOverlay[0x1b] | 0x8100;
      tu15 = DrawC_gOverlay[0x1c] | 0x8100;
    }
  }
  DrawC_gOverlay[0x1c] = tu15;
  DrawC_gOverlay[0x1b] = tu14;
  if ((R3DCar_InMenu != 0) || ((carObj->AIFlags & 2U) != 0)) {
    DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] & 0x7e7e;
    if (((carObj->render).brakeLight & 1U) == 0) {
      DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] & 0x7f7f;
      DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] & 0x7f7f;
    }
    if ((DrawC_HeadLightFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) &&
       ((((carObj->render).headLight & 0x40U) != 0 || ((DrawC_gOverlay[0] & 1U) == 0)))) {
      DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] | 0x81;
    }
    if ((DrawC_HeadLightFlash[(u_short)(carObj->render).signalLight[1] & 0xf] != 0) &&
       ((((carObj->render).headLight & 4U) != 0 || ((DrawC_gOverlay[0] & 0x100U) == 0)))) {
      DrawC_gOverlay[0x1d] = DrawC_gOverlay[0x1d] | 0x8100;
    }
    if ((DrawC_gOverlay[1] & 1U) == 0) {
      if (DrawC_TailLightFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x80;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x80;
      }
      if (DrawC_HeadLightFlash[(u_short)(carObj->render).signalLight[0] & 0xf] != 0) {
        DrawC_gOverlay[0x1a] = DrawC_gOverlay[0x1a] | 0x80;
      }
    }
    if ((DrawC_gOverlay[1] & 0x100U) == 0) {
      if (DrawC_TailLightFlash[(u_short)(carObj->render).signalLight[1] & 0xf] != 0) {
        DrawC_gOverlay[0x18] = DrawC_gOverlay[0x18] | 0x8000;
        DrawC_gOverlay[0x19] = DrawC_gOverlay[0x19] | 0x8000;
      }
      if (DrawC_HeadLightFlash[(u_short)(carObj->render).signalLight[1] & 0xf] != 0) {
        DrawC_gOverlay[0x1a] = DrawC_gOverlay[0x1a] | 0x8000;
      }
    }
  }
DrawCPrimStart_camRotMatrix:
  {
    SVECTOR r;
    r.vx = 0;
    r.vz = 0;
    r.vy = R3DCar_yawCam;
    RotMatrix(&r,&DrawC_gMatA);
  }
  DrawC_gMatA.t[2] = 0;
  DrawC_gMatA.t[1] = 0;
  DrawC_gMatA.t[0] = 0;
  DrawC_gWetRoad = 0;
  if (R3DCar_InMenu == 0) {
    shadowAbsOffs = 3;
    drawEnv_p = (int)Draw_GetDRAWENV(gCView.id,gFlip);
    eIndexEnvMap = (carObj->N).eIndexEnvMap;
    eIndexShadow = (carObj->N).eIndexShadow;
    iVar3 = (int)(carObj->N).simRoadInfo.quad;
    uVar5 = (u_int)(u_short)DrawC_gEnvMap[eIndexEnvMap].tex;
    shadow_align_b = (u_int)(u_short)DrawC_gShadow[eIndexShadow].tex;
    nabr_blend = 2;
    if (iVar3 < (int)((u_short)DrawC_gEnvMap[eIndexEnvMap].extra & 0xff)) {
      uVar5 = (int)((u_int)(u_short)DrawC_gEnvMap[eIndexEnvMap].extra << 0x10) >> 0x18;
    }
    if (iVar3 < (int)((u_short)DrawC_gShadow[eIndexShadow].extra & 0xff)) {
      shadow_align_b = (int)((u_int)(u_short)DrawC_gShadow[eIndexShadow].extra << 0x10) >> 0x18;
    }
    envMapBigBit = 10 < (short)uVar5;
    if ((bool)envMapBigBit) {
      uVar5 = uVar5 - 10;
    }
    if ((int)(shadow_align_b << 0x10) < 0) {
      shadowAbsOffs = 0;
      shadow_align_b = -shadow_align_b;
    }
    if (10 < (short)shadow_align_b) {
      shadow_align_b = shadow_align_b - 10;
      nabr_blend = 1;
    }
    iVar3 = (int)((uVar5 - 1) * 0x10000) >> 0x10;
    if (iVar3 < 0) {
      (sd->ePmx0).u0 = '\0';
      (sd->ePmx0).v0 = '\0';
      (sd->ePmx0).clut = 0;
    }
    else {
      /* MATCH: whole-struct copy (both sides Draw_tPixMap) -- gcc's own unaligned
       * struct-assignment codegen (lwl/lwr/swl/swr) reproduces the oracle's
       * 16-byte movstrsi-style block; the old byte/word-peeled shift-mask form
       * was a Ghidra decompile artifact, not the true source shape. */
      sd->ePmx0 = Track_gReflectionMaps[iVar3];
    }
    iVar3 = (int)((shadow_align_b - 1) * 0x10000) >> 0x10;
    if (iVar3 < 0) {
      (sd->ePmx1).u0 = '\0';
      (sd->ePmx1).v0 = '\0';
      (sd->ePmx1).clut = 0;
    }
    else {
      RECT tw;
      vertBuf_p = (int)(Track_gReflectionMaps + iVar3);
      tw.x = (short)*(u_char *)vertBuf_p;
      tw.w = 0x80;
      tw.h = 0x40;
      tw.y = (short)Track_gReflectionMaps[iVar3].v0;
      SetDrawMode(&sd->drawModeOn,(u_int)*(u_char *)(drawEnv_p + 0x17),0,
                 (u_int)Track_gReflectionMaps[iVar3].tpage,&tw);
      tw.h = 0;
      tw.w = 0;
      tw.y = 0;
      tw.x = 0;
      SetDrawMode(&sd->drawModeOff,(u_int)*(u_char *)(drawEnv_p + 0x17),0,
                 (u_int)*(u_short *)(drawEnv_p + 0x14),&tw);
      /* MATCH: whole-struct copy (both sides Draw_tPixMap); see ePmx0 above. */
      sd->ePmx1 = Track_gReflectionMaps[iVar3];
      ChangeTPage(&(sd->ePmx1).tpage,nabr_blend);
    }
    sd->eAddZ = ((int)(carObj->N).positionXZ >> shadowAbsOffs + 3 & 0x3fU) +
                (int)DrawC_gEnvMapOffset[(sd->ePmx1).v0 >> 6];
    if (((GameSetup_gData.Weather != 0) &&
        (tunnelFlag = (int)BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo), tunnelFlag != 1)) &&
       (Cars_kSkidMarkSurface[(carObj->N).driveSurfaceType] == 1)) {
      DrawC_gWetRoad = 1;
    }
    DrawC_gReflectOffset =
         (short)((u_int)(((carObj->N).dimension.y * 3 >> 1) + (carObj->N).objAltitude) >> 8);
  }
  else {
    shapeData_p = (int)Draw_GetDRAWENV(gCView.id,gFlip);
    SetDrawMode(&sd->drawModeOn,(u_int)*(u_char *)(shapeData_p + 0x17),1,
               (u_int)*(u_short *)(shapeData_p + 0x14),(RECT *)0x0);
    SetDrawMode(&sd->drawModeOff,(u_int)*(u_char *)(shapeData_p + 0x17),0,
               (u_int)*(u_short *)(shapeData_p + 0x14),(RECT *)0x0);
    /* MATCH: whole-struct copy (both sides Draw_tPixMap); see ePmx0 above. */
    sd->ePmx0 = *gMenuPixmap[0];
  }
  ChangeTPage(&(sd->ePmx0).tpage,1);
  if (R3DCar_InMenu == 0) {
    iVar3 = (int)((lightAvg >> 2) * (u_int)R3DCar_eMapColour.r) >> 7;
    if ((bool)envMapBigBit) {
      iVar3 = (iVar3 << 1) / 3;
    }
    sd->eColor2 = (iVar3 * 3 >> 2) * 0x10101;
  }
  else {
    iVar3 = lightAvg >> 1;
  }
  sd->eColor0 = iVar3 * 0x10101;
  if ((carObj->render).currentCarType != 1) {
    iVar3 = iVar3 * 3;
  }
  sd->eColor1 = (iVar3 >> 2) * 0x10101;
  return (carObj->render).world_otz;
}

/* ---- DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache  [DRAWC.CPP:1535-1563] SLD-VERIFIED ---- */
void DrawC_PrimStop(Car_tObj *carObj,Draw_CarCache *sd)

{
  Car_tObj *sort_carObj;
  int worldZ;
  int sub_otSize;

  if (carObj->render.sort_flag != 0) {
    return;
  }
  sort_carObj = (Car_tObj *)carObj->render.sort_carObj;
  if (sort_carObj != (Car_tObj *)0x0) {
    if ((sort_carObj->render.sort_flag != 0) &&
       (sort_carObj->render.sort_flag = sort_carObj->render.sort_flag + -1,
        sort_carObj->render.sort_flag != 0)) {
      return;
    }
    sub_otSize = sort_carObj->render.sub_otSize + -1;
    worldZ = sort_carObj->render.world_otz;
  }
  else {
    sub_otSize = carObj->render.sub_otSize + -1;
    worldZ = carObj->render.world_otz;
  }
  *sd->sub_ot = *sd->sub_ot & 0xff000000 | sd->head.cprim.LastPrim[worldZ] & 0xffffff;
  sd->head.cprim.LastPrim[worldZ] =
       sd->head.cprim.LastPrim[worldZ] & 0xff000000 | (u_long)(sd->sub_ot + sub_otSize) & 0xffffff;
  return;
}

/* ---- DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache  [DRAWC.CPP:1772-2543] SLD-VERIFIED ---- */
void DrawC_Prim(matrixtdef *m,coorddef *t,Transformer_zObj *obj,Transformer_zOverlay *overlay,
               int envmap,Draw_CarCache *sd)

{
  COORD16 * Nvertice;
  COORD16 * vt;
  int u;
  short t1;
  short t2;
  short t3;
  int r0;
  int r1;
  int r2;
  PCOORD16 * tV;
  POLY_FT3 * prim;
  Transformer_zFacet * facet;
  int id0;
  int id1;
  int id2;
  int bfct;
  u_long color;
  Draw_tPixMap * pmx;
  u_char offsetU;
  u_char offsetV;
  u_char u0;
  u_char u1;
  u_char u2;
  u_char v0;
  u_char v1;
  u_char v2;
  u_short uv0;
  u_short uv1;
  short * z;
  long xy0;
  long xy1;
  long xy2;
  int overlayFlag;
  int facet_flag;
  int sd_otz;
  int index;
  int which;
  Transformer_zOverlay * facetOverlay;
  char cVar1;
  u_char bVar2;
  u_char uVar3;
  u_int uVar4;
  u_int *puVar5;
  u_char primTypeByte_d;
  u_short clut;
  int absZ;
  short matRow1_x;
  int vertA_matBPtr;
  int tps22;
  short *vert_xyz_iter;
  short *psVar6;
  int otz_check_a;
  u_short tpage;
  int matRow0_w1;
  int matRow_temp;
  int envmapMode;
  int bfctResult_c;
  int otz_check_b;
  int tD19;
  int bfctResult_b;
  u_char primTypeByte;
  int ti34;
  int bfctResult_a;
  u_int facetIdx_dec;
  int dvx1_word;
  u_short uv2;
  u_int ot_offs_alt;
  u_char primTypeByte_b;
  u_char code;
  int iVar7;
  int facetByteOff;
  int iVar8;
  int vertB_matBPtr;
  u_int uVar9;
  u_int uVar10;
  u_char v;
  int iVar11;
  u_int *primOut;
  char *envmapUV_dst;
  short *psVar12;
  int iVar13;
  int iVar14;
  u_short *facet_p_v1;
  Transformer_zOverlay *overlay_entry;
  u_int ot_offs_byte;
  u_int uVar15;
  Transformer_zOverlay *pTVar16;
  COORD16 *vertex_iter;
  u_int *puVar17;
  Transformer_zFacet *facet_iter;
  int tV_dst;
  int facet_p_v3;
  int facet_p_v2;
  u_short *puVar18;
  short facetFlag;
  int i;
  int remVerts;
  int vertCounter;
  u_int facetIdx;
  int vertIdx2;
  int loopDoneTag;
  int primTypeByte_c;
  u_int *ot_stitch_p;
  int primOut_drm;
  int primOut_drmOff;
  int primOut_drm2;
  int sub_ot_alias2;
  int sub_ot_alias;
  u_int drmode_tag;
  u_long *puVar19;
  int drmodeOff_w0;
  u_long *puVar20;
  int drmodeOn_tag;
  u_char ePmx1_uOff;
  u_char ePmx0_uOff;
  u_char ePmx1_uOff2;
  char vert_uv_b;
  u_long *sub_ot_p;
  u_char ePmx1_vOff;
  char vert_v_byte;
  u_long uVar21;
  int DrawC_gOvl_p;
  int drmodeOff_w1;
  u_long drmode_w0;
  u_long drmode_w1;
  int drmodeOff_w2;
  int drmodeOn_w1;
  COORD16 *Nvertex_buf;
  int vertIdx1;
  int vertIdx0;
  short tu8;
  short tu9;
  u_char tc7;
  u_char vert_a_idx2;
  short ts9;
  short ts10;
  u_char tu1;
  u_char tu4;
  u_char vert_c_idx;
  short tu19;
  int tu20;
  int ot_stitch_pb;
  short tu11;
  short tu12;
  short tu14;
  short tu15;
  u_char tu3;
  u_char vert_b_idx;
  u_char vert_c_idx2;
  short ts6;
  u_char tu2;
  short tu7;
  int tu10;
  int ot_stitch_pa;
  short *vert_yz_iter;
  u_char vert_a_idx;
  char tc6;
  short ts24;
  short ts7;
  u_short tu21;
  u_short tu23;
  u_int tu26;
  u_short tu27;
  u_char tu5;
  u_short uVar8_00;
  
  iVar7 = *(u_int *)&sd->ePmx0;   /* field-fusion: ePmx0.{u0,v0,clut} are a contiguous
                                    * 4-byte packed field -- oracle reads it as ONE lw */
  Nvertice = obj->Nvertex;
  if ((iVar7 == 0) &&
     (iVar8 = *(u_int *)&sd->ePmx1,
     iVar8 == 0)) {
    envmap = envmap & 0xbe;
  }
  if ((envmap & 1U) != 0) {
    psVar6 = (short *)Nvertice;
gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    remVerts = (int)obj->numVertex;
    loopDoneTag = -1;
    envmapUV_dst = &sd->tV[0].v;
    vert_yz_iter = &Nvertice->z;
    while (remVerts = remVerts + -1, remVerts != loopDoneTag) {
      ts9 = vert_yz_iter[-1];
      ts6 = *vert_yz_iter;
      (sd->vt0).x = *psVar6;
      (sd->vt0).y = ts9;
      (sd->vt0).z = ts6;
gte_ldv0((char *)sd + 0xac);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      absZ = (sd->tv).vz;
      if (absZ < 0) {
        absZ = -absZ;
      }
      vert_yz_iter = vert_yz_iter + 3;
      psVar6 = psVar6 + 3;
      envmapUV_dst[-1] = (char)(sd->tv).vx;
      *envmapUV_dst = (char)absZ;
      envmapUV_dst = envmapUV_dst + 8;
    }
  }
  TrsProj_SetTransPrecision(8);
  matRow0_w1 = m->m[3];
  iVar7 = m->m[6];
  (sd->matB).m[0][0] = (short)(m->m[0] >> 4);
  (sd->matB).m[0][1] = (short)(matRow0_w1 >> 4);
  (sd->matB).m[0][2] = (short)(iVar7 >> 4);
  matRow_temp = m->m[4];
  facetByteOff = m->m[7];
  matRow1_x = (short)(m->m[1] >> 4);
  (sd->matB).m[1][0] = matRow1_x;
  (sd->matB).m[1][1] = (short)(matRow_temp >> 4);
  (sd->matB).m[1][2] = (short)(facetByteOff >> 4);
  iVar7 = m->m[2];
  iVar8 = m->m[5];
  iVar11 = m->m[8];
  (sd->matB).m[1][0] = -matRow1_x;
  ts7 = (sd->matB).m[1][1];
  (sd->matB).m[2][0] = (short)(iVar7 >> 4);
  ts10 = (sd->matB).m[1][2];
  (sd->matB).m[2][1] = (short)(iVar8 >> 4);
  (sd->matB).m[2][2] = (short)(iVar11 >> 4);
  (sd->matB).m[1][1] = -ts7;
  (sd->matB).m[1][2] = -ts10;
  iVar7 = TrsProj_precision;
  (sd->matB).t[0] = t->x >> (TrsProj_precision);
  (sd->matB).t[1] = -(t->y >> (iVar7));
  (sd->matB).t[2] = t->z >> (iVar7);
  TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
  tV_dst = (int)sd->tV;
  psVar12 = &sd->tV[0].vt.z;
  vertex_iter = obj->vertex;
  vertCounter = (int)obj->numVertex;
  psVar6 = &vertex_iter->z;
  while( true ) {
    vertCounter = vertCounter + -1;
    envmapMode = envmap & 9;
    if (vertCounter == -1) break;
    tu11 = psVar6[-1];
    tu12 = *psVar6;
    psVar6 = psVar6 + 3;
    tu14 = vertex_iter->x;
    vertex_iter = vertex_iter + 1;
    *(short *)tV_dst = tu14;
    psVar12[-1] = tu11;
    *psVar12 = tu12;
    psVar12 = psVar12 + 4;
    tV_dst = tV_dst + 8;
  }
  facetIdx = (u_int)obj->numFacet;
  switch (envmapMode) {
  case 0:
      if ((envmap & 2U) != 0) {
        iVar7 = facetIdx * 0xc;
DrawC_Prim_envmap0AltPath:
        do {
          iVar8 = iVar7;
          uVar10 = facetIdx - 1;
          do {
            do {
              do {
                facetIdx = uVar10;
                iVar7 = iVar8 + -0xc;
                if (facetIdx == 0xffffffff) {
                  return;
                }
                facet_p_v3 = (int)&obj->facet[-1].flag + iVar8;
                iVar8 = iVar7;
                uVar10 = facetIdx - 1;
              } while ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr);
              iVar14 = (int)(sd->matB).m + (u_int)*(u_char *)(facet_p_v3 + 3) * 8 + -0x14;
              iVar13 = (int)(sd->matB).m + (u_int)*(u_char *)(facet_p_v3 + 4) * 8 + -0x14;
              iVar11 = (int)(sd->matB).m + (u_int)*(u_char *)(facet_p_v3 + 5) * 8 + -0x14;
              gte_ldVXY0m(*(u_int *)(iVar14 + 0xd0));
              gte_ldVZ0m(*(u_int *)(iVar14 + 0xd4));
              gte_ldVXY1m(*(u_int *)(iVar13 + 0xd0));
              gte_ldVZ1m(*(u_int *)(iVar13 + 0xd4));
              gte_ldVXY2m(*(u_int *)(iVar11 + 0xd0));
              gte_ldVZ2m(*(u_int *)(iVar11 + 0xd4));
              gte_rtpt();
              gte_nclip();
              gte_stMAC0m(sd->bfct);
              bfctResult_b = sd->bfct;
              if ((sd->head).mirror != 0) {
                bfctResult_b = -bfctResult_b;
              }
              uVar10 = facetIdx - 1;
            } while (bfctResult_b < 1);
            gte_avsz3();
            gte_stOTZm(sd->otz);
            ti34 = sd->otz + sd->sub_otz;
            sd->otz = ti34;
            if (ti34 < 0) goto DrawC_Prim_envmap0AltPath;
            uVar10 = facetIdx - 1;
          } while (sd->sub_otSize < ti34);
          puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
          DRAWC_OTLINK_FT3B(sd, puVar17);
          gte_stsxy3((char *)puVar17 + 0x8,(char *)puVar17 + 0x10,(char *)puVar17 + 0x18);
          primTypeByte_b = 0x24;
          if ((*(u_short *)facet_p_v3 & 1) != 0) {
            primTypeByte_b = 0x26;
          }
          puVar17[1] = sd->color;
          *(u_char *)((int)puVar17 + 7) = primTypeByte_b;
          if ((*(u_short *)facet_p_v3 & 1) == 0) {
            tu1 = sd->offsetU0;
            tu4 = sd->offsetV0;
            tu15 = sd->pmxStart[*(u_char *)(facet_p_v3 + 2)].tpage;
            *(u_short *)((int)puVar17 + 0xe) = sd->pmxStart[*(u_char *)(facet_p_v3 + 2)].clut;
            *(short *)((int)puVar17 + 0x16) = tu15;
            cVar1 = *(char *)(facet_p_v3 + 8);
            tc6 = *(char *)(facet_p_v3 + 10);
            *(u_char *)(puVar17 + 3) = *(char *)(facet_p_v3 + 6) + tu1;
            *(u_char *)(puVar17 + 5) = cVar1 + tu1;
            *(u_char *)(puVar17 + 7) = tc6 + tu1;
            cVar1 = *(char *)(facet_p_v3 + 9);
            tc6 = *(char *)(facet_p_v3 + 0xb);
            *(u_char *)((int)puVar17 + 0xd) = *(char *)(facet_p_v3 + 7) + tu4;
            *(u_char *)((int)puVar17 + 0x15) = cVar1 + tu4;
            *(u_char *)((int)puVar17 + 0x1d) = tc6 + tu4;
          }
          else {
            tu21 = sd->pmxStart[*(u_char *)(facet_p_v3 + 2)].tpage;
            *(u_short *)((int)puVar17 + 0xe) = sd->pmxStart[*(u_char *)(facet_p_v3 + 2)].clut;
            *(u_short *)((int)puVar17 + 0x16) = tu21;
            uVar8_00 = *(u_short *)(facet_p_v3 + 8);
            tu19 = *(short *)(facet_p_v3 + 10);
            *(u_short *)(puVar17 + 3) = *(u_short *)(facet_p_v3 + 6);
            *(u_short *)(puVar17 + 5) = uVar8_00;
            *(short *)(puVar17 + 7) = tu19;
          }
        } while( true );
      }
      primTypeByte_c = 0x24;
      iVar7 = facetIdx * 0xc;
DrawC_Prim_envmap1AltGT3:
      do {
        iVar8 = iVar7;
        uVar10 = facetIdx - 1;
        do {
          do {
            do {
              facetIdx = uVar10;
              iVar7 = iVar8 + -0xc;
              if (facetIdx == 0xffffffff) {
                return;
              }
              iVar11 = (int)&obj->facet[-1].flag + iVar8;
              iVar8 = iVar7;
              uVar10 = facetIdx - 1;
            } while ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr);
            iVar13 = (int)(sd->matB).m + (u_int)*(u_char *)(iVar11 + 3) * 8 + -0x14;
            vertB_matBPtr = (int)(sd->matB).m + (u_int)*(u_char *)(iVar11 + 5) * 8 + -0x14;
            gte_ldVXY0m(*(u_int *)(iVar13 + 0xd0));
            gte_ldVZ0m(*(u_int *)(iVar13 + 0xd4));
            gte_ldVXY1m(*(u_int *)&sd->tV[*(u_char *)(iVar11 + 4)].vt.x);
            gte_ldVZ1m(*(u_int *)&sd->tV[*(u_char *)(iVar11 + 4)].vt.z);
            gte_ldVXY2m(*(u_int *)(vertB_matBPtr + 0xd0));
            gte_ldVZ2m(*(u_int *)(vertB_matBPtr + 0xd4));
            gte_rtpt();
            gte_nclip();
            gte_stMAC0m(sd->bfct);
            bfctResult_c = sd->bfct;
            if ((sd->head).mirror != 0) {
              bfctResult_c = -bfctResult_c;
            }
            uVar10 = facetIdx - 1;
          } while (bfctResult_c < 1);
          gte_avsz3();
          gte_stOTZm(sd->otz);
          otz_check_b = sd->otz + sd->sub_otz;
          sd->otz = otz_check_b;
          if (otz_check_b < 0) goto DrawC_Prim_envmap1AltGT3;
          uVar10 = facetIdx - 1;
        } while (sd->sub_otSize < otz_check_b);
        primOut = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, primOut);
        gte_stsxy3((char *)primOut + 0x8,(char *)primOut + 0x10,(char *)primOut + 0x18);
        primOut[1] = sd->color;
        *(char *)((int)primOut + 7) = (char)primTypeByte_c;
        tD19 = (int)sd->pmxStart;
        iVar8 = tD19 + (u_int)*(u_char *)(iVar11 + 2) * 0x10;
        if ((*(u_short *)(iVar8 + 0xe) & 0x7f) == 0) {
          uVar8_00 = *(u_short *)(iVar8 + 6);
          *(u_short *)((int)primOut + 0xe) = *(u_short *)(iVar8 + 2);
          *(u_short *)((int)primOut + 0x16) = uVar8_00;
          tu8 = *(short *)(iVar11 + 8);
          tu9 = *(short *)(iVar11 + 10);
          *(u_short *)(primOut + 3) = *(u_short *)(iVar11 + 6);
          *(short *)(primOut + 5) = tu8;
          *(short *)(primOut + 7) = tu9;
        }
        else {
          tu2 = sd->offsetU1;
          tu3 = sd->offsetV1;
          if ((*(u_short *)(iVar8 + 0xe) & 2) != 0) {
            tu2 = sd->offsetU2;
            tu3 = sd->offsetV2;
          }
          tu7 = *(short *)(iVar8 + 6);
          *(u_short *)((int)primOut + 0xe) = *(u_short *)(iVar8 + 2);
          *(short *)((int)primOut + 0x16) = tu7;
          cVar1 = *(char *)(iVar11 + 8);
          tc6 = *(char *)(iVar11 + 10);
          *(u_char *)(primOut + 3) = *(char *)(iVar11 + 6) + tu2;
          *(u_char *)(primOut + 5) = cVar1 + tu2;
          *(u_char *)(primOut + 7) = tc6 + tu2;
          cVar1 = *(char *)(iVar11 + 9);
          tc6 = *(char *)(iVar11 + 0xb);
          *(u_char *)((int)primOut + 0xd) = *(char *)(iVar11 + 7) + tu3;
          *(u_char *)((int)primOut + 0x15) = cVar1 + tu3;
          *(u_char *)((int)primOut + 0x1d) = tc6 + tu3;
        }
      } while( true );
    break;
  case 1:
    iVar7 = facetIdx * 0xc;
DrawC_Prim_envmap1MainLoop:
    do {
      uVar10 = facetIdx - 1;
      iVar8 = iVar7;
      do {
        do {
          do {
            facetIdx = uVar10;
            iVar7 = iVar8 + -0xc;
            if (facetIdx == 0xffffffff) {
              return;
            }
            facet_p_v1 = (u_short *)((int)&obj->facet[-1].flag + iVar8);
            vert_a_idx = *(u_char *)((int)facet_p_v1 + 3);
            vert_b_idx = (u_char)facet_p_v1[2];
            vert_c_idx = *(u_char *)((int)facet_p_v1 + 5);
            uVar10 = facetIdx - 1;
            iVar8 = iVar7;
          } while ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr);
          gte_ldVXY0m(*(u_int *)&sd->tV[vert_a_idx].vt.x);
          gte_ldVZ0m(*(u_int *)&sd->tV[vert_a_idx].vt.z);
          gte_ldVXY1m(*(u_int *)&sd->tV[vert_b_idx].vt.x);
          gte_ldVZ1m(*(u_int *)&sd->tV[vert_b_idx].vt.z);
          gte_ldVXY2m(*(u_int *)&sd->tV[vert_c_idx].vt.x);
          gte_ldVZ2m(*(u_int *)&sd->tV[vert_c_idx].vt.z);
          gte_rtpt();
          gte_nclip();
          gte_stMAC0m(sd->bfct);
          iVar11 = sd->bfct;
          if ((sd->head).mirror != 0) {
            iVar11 = -iVar11;
          }
          uVar10 = facetIdx - 1;
        } while (iVar11 < 1);
        gte_stSXY0m(sd->dvx0);
        gte_stSXY1m(sd->dvx1);
        gte_stSXY2m(sd->dvx2);
        gte_avsz3();
        gte_stOTZm(sd->otz);
        iVar11 = sd->otz + sd->sub_otz;
        sd->otz = iVar11;
        if (iVar11 < 0) goto DrawC_Prim_envmap1MainLoop;
        uVar10 = facetIdx - 1;
      } while (sd->sub_otSize < iVar11);
      if (((*facet_p_v1 & 0x3f3) != 0) &&
         (iVar11 = *(u_int *)&sd->ePmx1, iVar11 != 0)) {   /* field-fusion (single lw) */
        psVar6 = (short *)(Nvertice + (u_int)*(u_char *)((int)facet_p_v1 + 3));
        ts7 = psVar6[1];
        ts24 = psVar6[2];
        (sd->vt0).x = *psVar6;
        (sd->vt0).y = ts7;
        (sd->vt0).z = ts24;
        psVar6 = (short *)(Nvertice + (u_int)(u_char)facet_p_v1[2]);
        ts7 = psVar6[1];
        ts24 = psVar6[2];
        (sd->vt1).x = *psVar6;
        (sd->vt1).y = ts7;
        (sd->vt1).z = ts24;
        psVar6 = (short *)(Nvertice + (u_int)*(u_char *)((int)facet_p_v1 + 5));
        ts7 = psVar6[1];
        ts24 = psVar6[2];
        (sd->vt2).x = *psVar6;
        (sd->vt2).y = ts7;
        (sd->vt2).z = ts24;
        DRAWC_OTLINK_MODE(sd, "84", "88", "92");
        puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, puVar17);
        DRAWC_OTLINK_MODE(sd, "72", "76", "80");
        uVar10 = *(u_int *)&sd->dvx1;
        uVar15 = *(u_int *)&sd->dvx2;
        puVar17[2] = *(u_int *)&sd->dvx0;
        puVar17[4] = uVar10;
        puVar17[6] = uVar15;
        puVar17[1] = sd->eColor0;
        *(u_char *)((int)puVar17 + 7) = 0x26;
        tu21 = (sd->ePmx1).tpage;
        *(u_short *)((int)puVar17 + 0xe) = (sd->ePmx1).clut;
        *(u_short *)((int)puVar17 + 0x16) = tu21;
        ePmx1_uOff = (sd->ePmx1).u0 + 0x40;
        ePmx1_vOff = (sd->ePmx1).v0 + (char)sd->eAddZ;
        ts7 = (sd->vt0).z;
        *(u_char *)(puVar17 + 3) = (char)(sd->vt0).y + ePmx1_uOff;
        *(u_char *)((int)puVar17 + 0xd) = (char)ts7 + ePmx1_vOff;
        ts7 = (sd->vt1).z;
        *(u_char *)(puVar17 + 5) = (char)(sd->vt1).y + ePmx1_uOff;
        *(u_char *)((int)puVar17 + 0x15) = (char)ts7 + ePmx1_vOff;
        ts7 = (sd->vt2).z;
        *(u_char *)(puVar17 + 7) = (char)(sd->vt2).y + ePmx1_uOff;
        *(u_char *)((int)puVar17 + 0x1d) = (char)ts7 + ePmx1_vOff;
      }
      iVar13 = *(u_int *)&sd->ePmx0;   /* field-fusion (single lw) */
      if (iVar13 != 0) {
        puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
        DRAWC_OTLINK_FT3B(sd, puVar17);
        uVar10 = *(u_int *)&sd->dvx1;
        uVar15 = *(u_int *)&sd->dvx2;
        puVar17[2] = *(u_int *)&sd->dvx0;
        puVar17[4] = uVar10;
        puVar17[6] = uVar15;
        puVar17[1] = sd->eColor0;
        *(u_char *)((int)puVar17 + 7) = 0x26;
        tu21 = (sd->ePmx0).tpage;
        *(u_short *)((int)puVar17 + 0xe) = (sd->ePmx0).clut;
        *(u_short *)((int)puVar17 + 0x16) = tu21;
        tu5 = (sd->ePmx0).v0;
        ePmx0_uOff = (sd->ePmx0).u0 + 0x40;
        cVar1 = sd->tV[vert_a_idx].v;
        *(u_char *)(puVar17 + 3) = sd->tV[vert_a_idx].u + ePmx0_uOff;
        *(u_char *)((int)puVar17 + 0xd) = cVar1 + tu5;
        cVar1 = sd->tV[vert_b_idx].v;
        *(u_char *)(puVar17 + 5) = sd->tV[vert_b_idx].u + ePmx0_uOff;
        *(u_char *)((int)puVar17 + 0x15) = cVar1 + tu5;
        cVar1 = sd->tV[vert_c_idx].v;
        *(u_char *)(puVar17 + 7) = sd->tV[vert_c_idx].u + ePmx0_uOff;
        *(u_char *)((int)puVar17 + 0x1d) = cVar1 + tu5;
      }
      puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
      DRAWC_OTLINK_FT3B(sd, puVar17);
      uVar10 = *(u_int *)&sd->dvx1;
      uVar15 = *(u_int *)&sd->dvx2;
      puVar17[2] = *(u_int *)&sd->dvx0;
      puVar17[4] = uVar10;
      puVar17[6] = uVar15;
      puVar17[1] = sd->color;
      *(u_char *)((int)puVar17 + 7) = 0x24;
      tu21 = sd->pmxStart[(u_char)facet_p_v1[1]].tpage;
      *(u_short *)((int)puVar17 + 0xe) = sd->pmxStart[(u_char)facet_p_v1[1]].clut;
      *(u_short *)((int)puVar17 + 0x16) = tu21;
      tu21 = facet_p_v1[4];
      tu27 = facet_p_v1[5];
      *(u_short *)(puVar17 + 3) = facet_p_v1[3];
      *(u_short *)(puVar17 + 5) = tu21;
      *(u_short *)(puVar17 + 7) = tu27;
    } while( true );
    break;
  case 8:
      DrawC_gOvl_p = (int)DrawC_gOverlay;
      iVar7 = facetIdx * 0xc;
DrawC_Prim_envmap8OverlayTop:
      uVar10 = facetIdx - 1;
      iVar8 = iVar7;
DrawC_Prim_envmap8InnerLoop:
      while( true ) {
        do {
          do {
            facetIdx = uVar10;
            iVar7 = iVar8 + -0xc;
            if (facetIdx == 0xffffffff) {
              return;
            }
            facet_p_v2 = (int)&obj->facet[-1].flag + iVar8;
            uVar10 = facetIdx - 1;
            iVar8 = iVar7;
          } while ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr);
          uVar15 = (int)(sd->matB).m + (u_int)*(u_char *)(facet_p_v2 + 3) * 8 + -0x14;
          gte_ldVXY0m(*(u_int *)(uVar15 + 0xd0));
          gte_ldVZ0m(*(u_int *)(uVar15 + 0xd4));
          gte_ldVXY1m(*(u_int *)&sd->tV[(u_char)*(u_short *)(facet_p_v2 + 4)].vt.x);
          gte_ldVZ1m(*(u_int *)&sd->tV[(u_char)*(u_short *)(facet_p_v2 + 4)].vt.z);
          gte_ldVXY2m(*(u_int *)&sd->tV[*(u_char *)(facet_p_v2 + 5)].vt.x);
          gte_ldVZ2m(*(u_int *)&sd->tV[*(u_char *)(facet_p_v2 + 5)].vt.z);
          gte_rtpt();
          gte_nclip();
          gte_stMAC0m(sd->bfct);
          iVar11 = sd->bfct;
          if ((sd->head).mirror != 0) {
            iVar11 = -iVar11;
          }
          uVar10 = facetIdx - 1;
        } while (iVar11 < 1);
        gte_avsz3();
        gte_stOTZm(sd->otz);
        iVar11 = (u_int)*(u_short *)((u_int)(u_char)*(u_short *)(facet_p_v2 + 2) * 2 + DrawC_gOvl_p) <<
                 0x10;
        uVar9 = iVar11 >> 0x10;
        if (uVar9 == 0) break;
        uVar15 = (u_int)(short)*(u_short *)facet_p_v2;
        uVar9 = uVar9 & 0xff;
        if ((int)uVar15 < 0) {
          uVar9 = iVar11 >> 0x18;
        }
        iVar11 = sd->otz + sd->sub_otz;
        if ((uVar9 & 0x40) != 0) {
          iVar11 = iVar11 + -2;
        }
        uVar10 = facetIdx - 1;
        if ((-1 < iVar11) && (uVar10 = facetIdx - 1, iVar11 <= sd->sub_otSize)) {
          uVar10 = uVar15 & 0xfff;
          if (((uVar15 & 0x3f0) != 0) && (uVar9 = uVar9 & uVar10 >> 4, uVar9 != 0)) {
            for (; (uVar9 & 3) == 0; uVar9 = (int)uVar9 >> 2) {
            }
          }
          sd->otz = iVar11;
          goto DrawC_Prim_otStitch24Emit;
        }
      }
      iVar11 = sd->otz + sd->sub_otz;
      sd->otz = iVar11;
      if (-1 < iVar11) goto cfLbl1;
      goto DrawC_Prim_envmap8OverlayTop;
    break;
  case 9:
      iVar7 = facetIdx * 0xc;
DrawC_Prim_envmap9LoopTop:
      uVar10 = facetIdx - 1;
      iVar8 = iVar7;
DrawC_Prim_envmap9InnerLoop:
      while (facetIdx = uVar10, iVar7 = iVar8 + -0xc, facetIdx != 0xffffffff) {
        puVar18 = (u_short *)((int)&obj->facet[-1].flag + iVar8);
        vert_a_idx2 = *(u_char *)((int)puVar18 + 3);
        bVar2 = (u_char)puVar18[2];
        vert_c_idx2 = *(u_char *)((int)puVar18 + 5);
        uVar10 = facetIdx - 1;
        iVar8 = iVar7;
        if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
          gte_ldVXY0m(*(u_int *)&sd->tV[vert_a_idx2].vt.x);
          gte_ldVZ0m(*(u_int *)&sd->tV[vert_a_idx2].vt.z);
          gte_ldVXY1m(*(u_int *)&sd->tV[bVar2].vt.x);
          gte_ldVZ1m(*(u_int *)&sd->tV[bVar2].vt.z);
          gte_ldVXY2m(*(u_int *)&sd->tV[vert_c_idx2].vt.x);
          gte_ldVZ2m(*(u_int *)&sd->tV[vert_c_idx2].vt.z);
          gte_rtpt();
          gte_nclip();
          gte_stMAC0m(sd->bfct);
          bfctResult_a = sd->bfct;
          if ((sd->head).mirror != 0) {
            bfctResult_a = -bfctResult_a;
          }
          uVar10 = facetIdx - 1;
          if (0 < bfctResult_a) {
            gte_stSXY0m(sd->dvx0);
            gte_stSXY1m(sd->dvx1);
            gte_stSXY2m(sd->dvx2);
            gte_avsz3();
            gte_stOTZm(sd->otz);
            ot_offs_byte = (int)((u_int)(u_short)DrawC_gOverlay[(u_char)puVar18[1]] << 0x10) >> 0x10;
            if (ot_offs_byte == 0) {
              iVar11 = sd->otz + sd->sub_otz;
              sd->otz = iVar11;
              if (-1 < iVar11) goto cfLbl2;
              goto DrawC_Prim_envmap9LoopTop;
            }
            uVar9 = (u_int)(short)*puVar18;
            uVar15 = ot_offs_byte & 0xff;
            if ((int)uVar9 < 0) {
              uVar15 = (int)((u_int)(u_short)DrawC_gOverlay[(u_char)puVar18[1]] << 0x10) >> 0x18;
            }
            iVar11 = sd->otz + sd->sub_otz;
            uVar10 = facetIdx - 1;
            if ((-1 < iVar11) && (uVar10 = facetIdx - 1, iVar11 <= sd->sub_otSize)) {
              facetIdx_dec = uVar9 & 0xfff;
              if (((uVar9 & 0x3f0) != 0) && (uVar15 = uVar15 & facetIdx_dec >> 4, uVar15 != 0)) {
                for (; (uVar15 & 3) == 0; uVar15 = (int)uVar15 >> 2) {
                }
              }
              sd->otz = iVar11;
              goto DrawC_Prim_ePmx1UVEmit;
            }
          }
        }
      }
    break;
  }
  return;
cfLbl1:   /* @0x800c0a7c  (-f-build goto label) */
  uVar10 = facetIdx - 1;
  if (iVar11 <= sd->sub_otSize) goto cfLbl3;
  goto DrawC_Prim_envmap8InnerLoop;
cfLbl3:   /* @0x800c0a90  (-f-build goto label) */
  uVar10 = *(u_short *)facet_p_v2 & 0xfff;
  uVar9 = 0;
DrawC_Prim_otStitch24Emit:
  if ((uVar9 & 3) == 0) {
    puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
    DRAWC_OTLINK_FT3B(sd, puVar17);
    gte_stsxy3((char *)puVar17 + 0x8,(char *)puVar17 + 0x10,(char *)puVar17 + 0x18);
    uVar15 = 0x808080;
    if ((uVar9 & 0x80) == 0) {
      uVar15 = sd->color;
    }
    primTypeByte = 0x24;
    if ((uVar10 & 1) != 0) {
      primTypeByte = 0x26;
    }
    puVar17[1] = uVar15;
    *(u_char *)((int)puVar17 + 7) = primTypeByte;
    tu21 = sd->pmxStart[*(u_char *)(facet_p_v2 + 2)].tpage;
    *(u_short *)((int)puVar17 + 0xe) = sd->pmxStart[*(u_char *)(facet_p_v2 + 2)].clut;
    *(u_short *)((int)puVar17 + 0x16) = tu21;
    uVar8_00 = *(u_short *)(facet_p_v2 + 8);
    tu23 = *(u_short *)(facet_p_v2 + 10);
    *(u_short *)(puVar17 + 3) = *(u_short *)(facet_p_v2 + 6);
    *(u_short *)(puVar17 + 5) = uVar8_00;
    *(u_short *)(puVar17 + 7) = tu23;
  }
  else {
    puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
    overlay_entry = overlay + (u_int)(u_char)*(u_short *)(facet_p_v2 + 2) * 3 + ((uVar9 & 3) - 1);
    DRAWC_OTLINK_FT3B(sd, puVar17);
    gte_stsxy3((char *)puVar17 + 0x8,(char *)puVar17 + 0x10,(char *)puVar17 + 0x18);
    uVar15 = 0x808080;
    if ((uVar9 & 0x80) == 0) {
      uVar15 = sd->color;
    }
    primTypeByte_d = 0x24;
    if ((uVar10 & 1) != 0) {
      primTypeByte_d = 0x26;
    }
    puVar17[1] = uVar15;
    *(u_char *)((int)puVar17 + 7) = primTypeByte_d;
    tu5 = overlay_entry->u;
    uVar3 = overlay_entry->v;
    iVar8 = (u_int)(u_char)*(u_short *)(facet_p_v2 + 2) + (int)overlay_entry->offset;
    tu21 = sd->pmxStart[iVar8].tpage;
    *(u_short *)((int)puVar17 + 0xe) = sd->pmxStart[iVar8].clut;
    *(u_short *)((int)puVar17 + 0x16) = tu21;
    tu21 = *(u_short *)(facet_p_v2 + 8);
    tu27 = *(u_short *)(facet_p_v2 + 10);
    *(u_char *)(puVar17 + 3) = (char)*(u_short *)(facet_p_v2 + 6) + tu5;
    *(u_char *)(puVar17 + 5) = (char)tu21 + tu5;
    *(u_char *)(puVar17 + 7) = (char)tu27 + tu5;
    cVar1 = *(char *)(facet_p_v2 + 9);
    tc7 = *(u_char *)(facet_p_v2 + 0xb);
    *(u_char *)((int)puVar17 + 0xd) = *(char *)(facet_p_v2 + 7) + uVar3;
    *(u_char *)((int)puVar17 + 0x15) = cVar1 + uVar3;
    *(u_char *)((int)puVar17 + 0x1d) = tc7 + uVar3;
  }
  goto DrawC_Prim_envmap8OverlayTop;
cfLbl2:   /* @0x800c0df4  (-f-build goto label) */
  uVar10 = facetIdx - 1;
  if (iVar11 <= sd->sub_otSize) goto cfLbl4;
  goto DrawC_Prim_envmap9InnerLoop;
cfLbl4:   /* @0x800c0e08  (-f-build goto label) */
  facetIdx_dec = *puVar18 & 0xfff;
  uVar15 = 0;
DrawC_Prim_ePmx1UVEmit:
  if (((facetIdx_dec & 0x3f3) != 0) &&
     (vertA_matBPtr = *(u_int *)&sd->ePmx1, vertA_matBPtr != 0)) {   /* field-fusion (single lw) */
    tps22 = (int)(Nvertice + (u_int)*(u_char *)((int)puVar18 + 3));
    ts7 = *(short *)(tps22 + 2);
    ts24 = *(short *)(tps22 + 4);
    (sd->vt0).x = *(short *)tps22;
    (sd->vt0).y = ts7;
    (sd->vt0).z = ts24;
    vert_xyz_iter = (short *)(Nvertice + (u_int)(u_char)puVar18[2]);
    ts7 = vert_xyz_iter[1];
    ts24 = vert_xyz_iter[2];
    (sd->vt1).x = *vert_xyz_iter;
    (sd->vt1).y = ts7;
    (sd->vt1).z = ts24;
    psVar6 = (short *)(Nvertice + (u_int)*(u_char *)((int)puVar18 + 5));
    ts7 = psVar6[1];
    ts24 = psVar6[2];
    (sd->vt2).x = *psVar6;
    (sd->vt2).y = ts7;
    (sd->vt2).z = ts24;
    DRAWC_OTLINK_MODE(sd, "84", "88", "92");
    puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
    DRAWC_OTLINK_FT3B(sd, puVar17);
    DRAWC_OTLINK_MODE(sd, "72", "76", "80");
    dvx1_word = *(int *)&sd->dvx1;
    uVar10 = *(u_int *)&sd->dvx2;
    puVar17[2] = *(u_int *)&sd->dvx0;
    puVar17[4] = dvx1_word;
    puVar17[6] = uVar10;
    puVar17[1] = sd->eColor0;
    *(u_char *)((int)puVar17 + 7) = 0x26;
    tu21 = (sd->ePmx1).tpage;
    *(u_short *)((int)puVar17 + 0xe) = (sd->ePmx1).clut;
    *(u_short *)((int)puVar17 + 0x16) = tu21;
    ePmx1_uOff2 = (sd->ePmx1).u0 + 0x40;
    vert_v_byte = (sd->ePmx1).v0 + (char)sd->eAddZ;
    ts7 = (sd->vt0).z;
    *(u_char *)(puVar17 + 3) = (char)(sd->vt0).y + ePmx1_uOff2;
    *(char *)((int)puVar17 + 0xd) = (char)ts7 + vert_v_byte;
    ts7 = (sd->vt1).z;
    *(u_char *)(puVar17 + 5) = (char)(sd->vt1).y + ePmx1_uOff2;
    *(char *)((int)puVar17 + 0x15) = (char)ts7 + vert_v_byte;
    ts7 = (sd->vt2).z;
    *(u_char *)(puVar17 + 7) = (char)(sd->vt2).y + ePmx1_uOff2;
    *(char *)((int)puVar17 + 0x1d) = (char)ts7 + vert_v_byte;
  }
  otz_check_a = *(u_int *)&sd->ePmx0;   /* field-fusion (single lw) */
  if (otz_check_a != 0) {
    puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
    DRAWC_OTLINK_FT3B(sd, puVar17);
    ot_offs_alt = *(u_int *)&sd->dvx1;
    uVar10 = *(u_int *)&sd->dvx2;
    puVar17[2] = *(u_int *)&sd->dvx0;
    puVar17[4] = ot_offs_alt;
    puVar17[6] = uVar10;
    if ((uVar15 & 1) == 0) {
      if ((facetIdx_dec & 4) == 0) {
        puVar17[1] = sd->eColor0;
      }
      else {
        puVar17[1] = sd->eColor1;
      }
    }
    else {
      puVar17[1] = sd->eColor2;
    }
    *(u_char *)((int)puVar17 + 7) = 0x26;
    tu21 = (sd->ePmx0).tpage;
    *(u_short *)((int)puVar17 + 0xe) = (sd->ePmx0).clut;
    *(u_short *)((int)puVar17 + 0x16) = tu21;
    tu5 = (sd->ePmx0).v0;
    vert_uv_b = (sd->ePmx0).u0 + '@';
    cVar1 = sd->tV[vert_a_idx2].v;
    *(char *)(puVar17 + 3) = sd->tV[vert_a_idx2].u + vert_uv_b;
    *(u_char *)((int)puVar17 + 0xd) = cVar1 + tu5;
    cVar1 = sd->tV[bVar2].v;
    *(char *)(puVar17 + 5) = sd->tV[bVar2].u + vert_uv_b;
    *(u_char *)((int)puVar17 + 0x15) = cVar1 + tu5;
    cVar1 = sd->tV[vert_c_idx2].v;
    *(char *)(puVar17 + 7) = sd->tV[vert_c_idx2].u + vert_uv_b;
    *(u_char *)((int)puVar17 + 0x1d) = cVar1 + tu5;
  }
  if ((uVar15 & 3) == 0) {
    puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
    DRAWC_OTLINK_FT3B(sd, puVar17);
    uVar10 = *(u_int *)&sd->dvx1;
    uVar15 = *(u_int *)&sd->dvx2;
    puVar17[2] = *(u_int *)&sd->dvx0;
    puVar17[4] = uVar10;
    puVar17[6] = uVar15;
    primTypeByte_b = 0x24;
    if ((facetIdx_dec & 1) != 0) {
      primTypeByte_b = 0x26;
    }
    puVar17[1] = sd->color;
    *(u_char *)((int)puVar17 + 7) = primTypeByte_b;
    tu21 = sd->pmxStart[(u_char)puVar18[1]].tpage;
    *(u_short *)((int)puVar17 + 0xe) = sd->pmxStart[(u_char)puVar18[1]].clut;
    *(u_short *)((int)puVar17 + 0x16) = tu21;
    tu21 = puVar18[4];
    tu27 = puVar18[5];
    *(u_short *)(puVar17 + 3) = puVar18[3];
    *(u_short *)(puVar17 + 5) = tu21;
    *(u_short *)(puVar17 + 7) = tu27;
  }
  else {
    puVar17 = (u_int *)(sd->head).cprim.PrimPtr;
    pTVar16 = overlay + (u_int)(u_char)puVar18[1] * 3 + ((uVar15 & 3) - 1);
    DRAWC_OTLINK_FT3B(sd, puVar17);
    uVar10 = *(u_int *)&sd->dvx1;
    uVar15 = *(u_int *)&sd->dvx2;
    puVar17[2] = *(u_int *)&sd->dvx0;
    puVar17[4] = uVar10;
    puVar17[6] = uVar15;
    primTypeByte_b = 0x24;
    if ((facetIdx_dec & 1) != 0) {
      primTypeByte_b = 0x26;
    }
    puVar17[1] = sd->color;
    *(u_char *)((int)puVar17 + 7) = primTypeByte_b;
    tu5 = pTVar16->u;
    uVar3 = pTVar16->v;
    iVar8 = (u_int)(u_char)puVar18[1] + (int)pTVar16->offset;
    tu21 = sd->pmxStart[iVar8].tpage;
    *(u_short *)((int)puVar17 + 0xe) = sd->pmxStart[iVar8].clut;
    *(u_short *)((int)puVar17 + 0x16) = tu21;
    tu21 = puVar18[4];
    tu27 = puVar18[5];
    *(u_char *)(puVar17 + 3) = (char)puVar18[3] + tu5;
    *(u_char *)(puVar17 + 5) = (char)tu21 + tu5;
    *(u_char *)(puVar17 + 7) = (char)tu27 + tu5;
    cVar1 = *(char *)((int)puVar18 + 9);
    tc6 = *(char *)((int)puVar18 + 0xb);
    *(u_char *)((int)puVar17 + 0xd) = *(char *)((int)puVar18 + 7) + uVar3;
    *(u_char *)((int)puVar17 + 0x15) = cVar1 + uVar3;
    *(u_char *)((int)puVar17 + 0x1d) = tc6 + uVar3;
  }
  goto DrawC_Prim_envmap9LoopTop;
}

/* ---- DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache  [DRAWC.CPP:2554-2644] SLD-VERIFIED ---- */
void DrawC_DividePrim(COORD16 *vt0,COORD16 *vt1,COORD16 *vt2,u_short *u0,u_short *u1,u_short *u2,
               Draw_tPixMap *pmx,Draw_CarCache *sd)

{
  POLY_FT3 * prim;
  int bfct;
  long xy0;
  long xy1;
  long xy2;
  u_long color;
  u_char code;
  u_short uv1;
  u_short uv2;
  int sVar1;      /* clipW held as INT (oracle: lh, no per-use re-extension) */
  int sVar2;      /* clipH likewise */
  u_short uVar3;
  u_short uVar4;
  u_int *puVar5;
  u_short clut;
  int clipW;
  u_short tpage;
  int iVar6;
  u_int *puVar7;
  u_short uv0;
  u_int uVar8;
  u_int uVar9;
  int clipH;
  u_long *puVar10;
  
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
gte_ldv3(vt0,vt1,vt2);
    gte_rtpt();
    gte_nclip();
    gte_stMAC0m(sd->bfct);   /* m-form: swc2 $24,0x44(sd) direct displacement (EA-expander site) */
    iVar6 = sd->bfct;
    if ((sd->head).mirror != 0) {
      iVar6 = -iVar6;
    }
    if (0 < iVar6) {
      gte_stSXY0m(sd->dvx0);   /* m-form: swc2 $12,0xC4(sd) etc. */
      gte_stSXY1m(sd->dvx1);
      gte_stSXY2m(sd->dvx2);
      sVar1 = (sd->head).clipW;
      sVar2 = (sd->head).clipH;
      if (((((((sd->dvx0 <= sVar1) || (sd->dvx1 <= sVar1)) || (sd->dvx2 <= sVar1)) &&
            (((-1 < sd->dvx0 || (-1 < sd->dvx1)) || (-1 < sd->dvx2)))) &&
           (((sd->dvy0 <= sVar2 || (sd->dvy1 <= sVar2)) || (sd->dvy2 <= sVar2)))) &&
          (((-1 < sd->dvy0 || (-1 < sd->dvy1)) || (-1 < sd->dvy2)))) &&
         (((-1 < vt0->z || (-1 < vt1->z)) || (-1 < vt2->z)))) {
        gte_avsz3();
        gte_stOTZm(sd->otz);
        iVar6 = sd->otz + sd->sub_otz;
        sd->otz = iVar6;
        if ((-1 < iVar6) && (iVar6 <= sd->sub_otSize)) {
          /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE variant A / FULL BLOCK (2026-07-09):
           * prim = sd->PrimPtr; slot = sd->sub_ot + sd->otz; sd->PrimPtr += 0x20;
           * prim->tag = slot->addr24 | (7<<24); slot->addr24 = prim.
           * $t4/$t5/$t6 hardcoded (the expander's temps); prim is the asm OUTPUT. */
          __asm__ volatile(
              "lw	%0,4(%1)
	lw	$t4,60(%1)
	lw	$t5,56(%1)
	addiu	$t6,%0,32
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4(%1)
	lwl	$t6,2($t5)
	lui	$t4,0x0700
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,%0,8
	sw	$t6,0(%0)
	swl	$t4,2($t5)"
              : "=&r"(puVar7) : "r"(sd)
              : "$12", "$13", "$14", "memory");
          uVar8 = *(u_int *)&sd->dvx1;
          uVar9 = *(u_int *)&sd->dvx2;
          puVar7[2] = *(u_int *)&sd->dvx0;
          puVar7[4] = uVar8;
          puVar7[6] = uVar9;
          puVar7[1] = sd->color;
          *(u_char *)((int)puVar7 + 7) = 0x24;
          clut  = pmx->clut;                       /* clut first (v0), tpage second (a0) */
          tpage = pmx->tpage;
          *(u_short *)((int)puVar7 + 0xe) = clut;
          *(u_short *)((int)puVar7 + 0x16) = tpage;
          uv1 = *u1;                               /* u1 loads FIRST (a0) */
          uv0 = *u0;                               /* then u0 (a1) */
          uv2 = *u2;                               /* then u2 (v0) */
          *(u_short *)(puVar7 + 3) = uv0;
          *(u_short *)(puVar7 + 5) = uv1;
          *(u_short *)(puVar7 + 7) = uv2;
        }
      }
    }
  }
  return;
}

/* ---- DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache  [DRAWC.CPP:2647-3495] SLD-VERIFIED ---- */
void DrawC_PrimClip(matrixtdef *m,coorddef *t,Transformer_zObj *obj,Transformer_zOverlay *overlay,
               int envmap,Draw_CarCache *sd)

{
  COORD16 * vt;
  PCOORD16 * tV;
  int x;
  int y;
  int z;
  Transformer_zFacet * facet;
  int bfct;
  int clipW;
  int clipH;
  u_long color;
  u_char u0;
  u_char v0;
  u_char v1;
  u_char v2;
  char cVar1;
  u_char bVar3;
  short sVar4;
  short sVar5;
  u_short uVar6;
  u_short clut;
  int tu20;
  int tD21;
  int ePmx1_pack;
  int ePmx0_pack;
  int absZ;
  int tps22;
  short *vert_xyz_iter;
  u_char primTypeByte;
  short *psVar8;
  int ti16;
  u_short tpage;
  u_int facetIdx_dec;
  u_char primTypeByte_b;
  int bfctResult_b;
  int bfctResult_c;
  int tu21;
  int tD22;
  int tD23;
  int bfctResult_a;
  int tu25;
  u_int tu40;
  u_int uVar9;
  u_char uVar10;
  u_char u;
  int iVar11;
  int iVar12;
  Draw_CarVertex *pDVar13;
  u_int uVar14;
  u_int uVar15;
  u_int uVar16;
  u_char uVar17;
  u_char bVar18;
  u_char v;
  Draw_tPixMap *pDVar19;
  int iVar20;
  u_char uVar21;
  u_short *puVar23;
  Transformer_zOverlay *pTVar24;
  u_int uVar25;
  int ot_offs_byte;
  u_int uVar26;
  int facet_p_v3;
  int overlay_entry;
  int facet_p_v4;
  u_int *primOut;
  u_int *puVar27;
  int facet_p_v2;
  u_short *facet_p_v1;
  int tu41;
  u_char ePmx1_uOff;
  u_char tc45;
  char vert_v_byte;
  u_char ePmx0_uOff;
  char tc57;
  u_char ePmx1_vOff;
  u_int facetIdx;
  int Nvertex_p;
  u_char *u2;
  int vt2_00;
  int u2_00;
  u_char *u1;
  int vt1;
  int vt2;
  short tu10;
  short tu11;
  u_char ePmx0_vOff;
  u_char vert_a_idx;
  u_char vert_c_idx;
  u_short tpage_alt;
  short clipW_or_vz;
  short clipH_or_vz;
  u_short uv_pack_alt;
  u_char bVar2;
  short ts3;
  short ts4;
  u_char bVar1;
  short tu7;
  short ts8;
  short ts9;
  u_char tu6;
  u_char tc7;
  u_char bVar8;
  short ts10;
  u_char vert_a_idx2;
  u_char vert_b_idx2;
  u_char tu5;
  short tu15;
  short tu16;
  u_short tu19;
  short ts11;
  short tu14;
  u_char vert_b_idx;
  short ts14;
  short ts15;
  u_short tu33;
  u_short uv_pack_b;

  iVar11 = *(int *)&sd->ePmx0;
  Nvertex_p = (int)obj->Nvertex;
  if ((iVar11 == 0) &&
     ((iVar12 = *(int *)&sd->ePmx1),
     iVar12 == 0)) {
    envmap = envmap & 0xbe;
  }
  if ((envmap & 1U) != 0) {
    /* SYM block-scope rebuild (SEAL rule 8c): this whole envmap-UV loop is its
     * OWN nested SYM block chain (line=18/19/27/31, va 0x800c15c8-0x800c16bc)
     * distinct from psVar8's later, unrelated facet-vertex uses -- give it a
     * fresh block-scoped 'vt' pseudo (shadowing the outer psVar8) instead of
     * reusing the function-scope one, matching the oracle's short-lived reg. */
    short *psVar8 = (short *)Nvertex_p;
gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    int loopDoneTag = -1;
    char *envmapUV_dst = &sd->tV[0].v;
    short *vert_yz_iter = (short *)(Nvertex_p + 4);
    int facetCount = (int)obj->numVertex;
    while (facetCount = facetCount + -1, facetCount != loopDoneTag) {
      short matRow_y = vert_yz_iter[-1];
      short matRow_z = *vert_yz_iter;
      (sd->vt0).x = *psVar8;
      (sd->vt0).y = matRow_y;
      (sd->vt0).z = matRow_z;
gte_ldv0((char *)sd + 0xac);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      int absZ_envmap = (sd->tv).vz;
      if (absZ_envmap < 0) {
        absZ_envmap = -absZ_envmap;
      }
      vert_yz_iter = vert_yz_iter + 3;
      psVar8 = psVar8 + 3;
      envmapUV_dst[-1] = (char)(sd->tv).vx;
      *envmapUV_dst = (char)absZ_envmap;
      envmapUV_dst = envmapUV_dst + 8;
    }
  }
  TrsProj_SetTransPrecision(8);
  /* SYM block-scope rebuild: SYM shows THREE separate {r0,r1,r2} block
   * scopes (one per matB row, va 0x800c16bc x3) -- fresh locals per row
   * instead of the shared iVar11/iVar12 function-scope scratch (which is
   * reused 30+/40+ times elsewhere and must stay untouched there). */
  {
    int matRowA1 = m->m[3];
    int matRowA2 = m->m[6];
    (sd->matB).m[0][0] = (short)(m->m[0] >> 4);
    (sd->matB).m[0][1] = (short)(matRowA1 >> 4);
    (sd->matB).m[0][2] = (short)(matRowA2 >> 4);
  }
  {
    int matRowB1 = m->m[4];
    int matRowB2 = m->m[7];
    (sd->matB).m[1][0] = (short)(m->m[1] >> 4);
    (sd->matB).m[1][1] = (short)(matRowB1 >> 4);
    (sd->matB).m[1][2] = (short)(matRowB2 >> 4);
  }
  {
    int matRowC1 = m->m[5];
    int matRowC2 = m->m[8];
    (sd->matB).m[2][0] = (short)(m->m[2] >> 4);
    (sd->matB).m[2][1] = (short)(matRowC1 >> 4);
    (sd->matB).m[2][2] = (short)(matRowC2 >> 4);
  }
  iVar11 = TrsProj_precision;
  (sd->matB).t[0] = t->x >> (TrsProj_precision);
  (sd->matB).t[1] = t->y >> (iVar11);
  (sd->matB).t[2] = t->z >> (iVar11);
  TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
  /* SYM block-scope rebuild: SYM's {vt,tV} block (va 0x800c16bc-0x800c1840)
   * wraps a nested {x,y,z}/{t1,t2,t3} loop block chain -- fresh block-scoped
   * locals here (psVar8 shadows the outer/later-reused function-scope one;
   * tV_dst/vertex_p/vertCounter/psVar22/vert_y/vert_z/vy_word/vz_word are
   * ONLY used in this loop, so they move down entirely). */
  {
    short *psVar8 = &sd->tV[0].vt.z;
    int tV_dst = (int)sd->tV;
    int loopDoneTag2 = -1;
    int vertex_p = (int)obj->vertex;
    int vertCounter = (int)obj->numVertex;
    short *psVar22 = (short *)(vertex_p + 4);
    while (vertCounter = vertCounter + -1, vertCounter != loopDoneTag2) {
      short vert_y = psVar22[-1];
      short vert_z = *psVar22;
      (((Draw_CarVertex *)tV_dst)->vt).x = *(short *)vertex_p;
      psVar8[-1] = vert_y;
      *psVar8 = vert_z;
gte_ldv0((char *)sd + 0xd0);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      psVar22 = psVar22 + 3;
      int vy_word = (sd->tv).vy;
      int vz_word = (sd->tv).vz;
      vertex_p = vertex_p + 6;
      *(short *)tV_dst = (short)(sd->tv).vx;
      psVar8[-1] = (short)vy_word;
      *psVar8 = (short)vz_word;
      psVar8 = psVar8 + 4;
      tV_dst = tV_dst + 8;
    }
  }
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  facetIdx = (u_int)obj->numFacet;
  facetIdx_dec = envmap & 9;
  if (facetIdx_dec == 1) {
    iVar11 = facetIdx * 0xc;
DrawC_PrimClip_envmap9Eq1Loop:
    do {
      iVar12 = iVar11;
      uVar9 = facetIdx - 1;
      do {
        do {
          do {
            do {
              facetIdx = uVar9;
              iVar11 = iVar12 + -0xc;
              if (facetIdx == 0xffffffff) {
                return;
              }
              puVar23 = (u_short *)((int)&obj->facet[-1].flag + iVar12);
              bVar18 = *(u_char *)((int)puVar23 + 3);
              vert_b_idx = (u_char)puVar23[2];
              bVar3 = *(u_char *)((int)puVar23 + 5);
              iVar12 = iVar11;
              uVar9 = facetIdx - 1;
            } while ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr);
            gte_ldVXY0m(*(u_int *)&sd->tV[bVar18].vt.x);
            gte_ldVZ0m(*(u_int *)&sd->tV[bVar18].vt.z);
            gte_ldVXY1m(*(u_int *)&sd->tV[vert_b_idx].vt.x);
            gte_ldVZ1m(*(u_int *)&sd->tV[vert_b_idx].vt.z);
            gte_ldVXY2m(*(u_int *)&sd->tV[bVar3].vt.x);
            gte_ldVZ2m(*(u_int *)&sd->tV[bVar3].vt.z);
            gte_rtpt();
            gte_nclip();
            gte_stMAC0m(sd->bfct);
            iVar20 = sd->bfct;
            if ((sd->head).mirror != 0) {
              iVar20 = -iVar20;
            }
            uVar9 = facetIdx - 1;
          } while (iVar20 < 1);
          gte_stSXY0m(sd->dvx0);
          gte_stSXY1m(sd->dvx1);
          gte_stSXY2m(sd->dvx2);
          sVar4 = sd->tV[vert_b_idx].vt.z;
          sVar5 = sd->tV[bVar3].vt.z;
          (sd->vt0).z = sd->tV[bVar18].vt.z;
          (sd->vt1).z = sVar4;
          (sd->vt2).z = sVar5;
          sVar4 = (sd->head).clipW;
          sVar5 = (sd->head).clipH;
        } while ((((((sVar4 < sd->dvx0) && (sVar4 < sd->dvx1)) &&
                   (uVar9 = facetIdx - 1, sVar4 < sd->dvx2)) ||
                  (((sd->dvx0 < 0 && (sd->dvx1 < 0)) && (uVar9 = facetIdx - 1, sd->dvx2 < 0)))) ||
                 (((sVar5 < sd->dvy0 && (sVar5 < sd->dvy1)) &&
                  (uVar9 = facetIdx - 1, sVar5 < sd->dvy2)))) ||
                ((((sd->dvy0 < 0 && (sd->dvy1 < 0)) && (uVar9 = facetIdx - 1, sd->dvy2 < 0)) ||
                 ((((sd->vt0).z < 0 && ((sd->vt1).z < 0)) && (uVar9 = facetIdx - 1, (sd->vt2).z < 0)
                  )))));
        gte_avsz3();
        gte_stOTZm(sd->otz);
        iVar20 = sd->otz + sd->sub_otz;
        sd->otz = iVar20;
        if (iVar20 < 0) goto DrawC_PrimClip_envmap9Eq1Loop;
        uVar9 = facetIdx - 1;
      } while (sd->sub_otSize < iVar20);
      if (((*puVar23 & 0x3f3) != 0) &&
         ((ePmx1_pack = *(int *)&sd->ePmx1), ePmx1_pack != 0)) {
        psVar8 = (short *)(Nvertex_p + (u_int)*(u_char *)((int)puVar23 + 3) * 6);
        sVar4 = psVar8[1];
        sVar5 = psVar8[2];
        (sd->vt0).x = *psVar8;
        (sd->vt0).y = sVar4;
        (sd->vt0).z = sVar5;
        psVar8 = (short *)(Nvertex_p + (u_int)(u_char)puVar23[2] * 6);
        sVar4 = psVar8[1];
        sVar5 = psVar8[2];
        (sd->vt1).x = *psVar8;
        (sd->vt1).y = sVar4;
        (sd->vt1).z = sVar5;
        psVar8 = (short *)(Nvertex_p + (u_int)*(u_char *)((int)puVar23 + 5) * 6);
        sVar4 = psVar8[1];
        sVar5 = psVar8[2];
        (sd->vt2).x = *psVar8;
        (sd->vt2).y = sVar4;
        (sd->vt2).z = sVar5;
        DRAWC_OTLINK_MODE(sd, "84", "88", "92");
        DRAWC_OTLINK_FT3(sd, puVar27);
        DRAWC_OTLINK_MODE(sd, "72", "76", "80");
        uVar9 = *(u_int *)&sd->dvx1;
        uVar26 = *(u_int *)&sd->dvx2;
        puVar27[2] = *(u_int *)&sd->dvx0;
        puVar27[4] = uVar9;
        puVar27[6] = uVar26;
        puVar27[1] = sd->eColor0;
        *(u_char *)((int)puVar27 + 7) = 0x26;
        uVar6 = (sd->ePmx1).tpage;
        *(u_short *)((int)puVar27 + 0xe) = (sd->ePmx1).clut;
        *(u_short *)((int)puVar27 + 0x16) = uVar6;
        ePmx1_uOff = (sd->ePmx1).u0 + 0x40;
        ePmx1_vOff = (sd->ePmx1).v0 + (char)sd->eAddZ;
        sVar4 = (sd->vt0).z;
        *(u_char *)(puVar27 + 3) = (char)(sd->vt0).y + ePmx1_uOff;
        *(u_char *)((int)puVar27 + 0xd) = (char)sVar4 + ePmx1_vOff;
        sVar4 = (sd->vt1).z;
        *(u_char *)(puVar27 + 5) = (char)(sd->vt1).y + ePmx1_uOff;
        *(u_char *)((int)puVar27 + 0x15) = (char)sVar4 + ePmx1_vOff;
        sVar4 = (sd->vt2).z;
        *(u_char *)(puVar27 + 7) = (char)(sd->vt2).y + ePmx1_uOff;
        *(u_char *)((int)puVar27 + 0x1d) = (char)sVar4 + ePmx1_vOff;
      }
      ePmx0_pack = *(int *)&sd->ePmx0;
      if (ePmx0_pack != 0) {
        DRAWC_OTLINK_FT3(sd, puVar27);
        uVar9 = *(u_int *)&sd->dvx1;
        uVar26 = *(u_int *)&sd->dvx2;
        puVar27[2] = *(u_int *)&sd->dvx0;
        puVar27[4] = uVar9;
        puVar27[6] = uVar26;
        puVar27[1] = sd->eColor0;
        *(u_char *)((int)puVar27 + 7) = 0x26;
        uVar6 = (sd->ePmx0).tpage;
        *(u_short *)((int)puVar27 + 0xe) = (sd->ePmx0).clut;
        *(u_short *)((int)puVar27 + 0x16) = uVar6;
        uVar17 = (sd->ePmx0).v0;
        ePmx0_uOff = (sd->ePmx0).u0 + 0x40;
        cVar1 = sd->tV[bVar18].v;
        *(u_char *)(puVar27 + 3) = sd->tV[bVar18].u + ePmx0_uOff;
        *(u_char *)((int)puVar27 + 0xd) = cVar1 + uVar17;
        cVar1 = sd->tV[vert_b_idx].v;
        *(u_char *)(puVar27 + 5) = sd->tV[vert_b_idx].u + ePmx0_uOff;
        *(u_char *)((int)puVar27 + 0x15) = cVar1 + uVar17;
        cVar1 = sd->tV[bVar3].v;
        *(u_char *)(puVar27 + 7) = sd->tV[bVar3].u + ePmx0_uOff;
        *(u_char *)((int)puVar27 + 0x1d) = cVar1 + uVar17;
      }
      DRAWC_OTLINK_FT3(sd, puVar27);
      uVar9 = *(u_int *)&sd->dvx1;
      uVar26 = *(u_int *)&sd->dvx2;
      puVar27[2] = *(u_int *)&sd->dvx0;
      puVar27[4] = uVar9;
      puVar27[6] = uVar26;
      puVar27[1] = sd->color;
      *(u_char *)((int)puVar27 + 7) = 0x24;
      uVar6 = sd->pmxStart[(u_char)puVar23[1]].tpage;
      *(u_short *)((int)puVar27 + 0xe) = sd->pmxStart[(u_char)puVar23[1]].clut;
      *(u_short *)((int)puVar27 + 0x16) = uVar6;
      uVar6 = puVar23[4];
      uv_pack_alt = puVar23[5];
      *(u_short *)(puVar27 + 3) = puVar23[3];
      *(u_short *)(puVar27 + 5) = uVar6;
      *(u_short *)(puVar27 + 7) = uv_pack_alt;
    } while( true );
  }
  if (facetIdx_dec < 2) {
    if (facetIdx_dec == 0) {
      vt1 = (int)&sd->vt3;
      if ((envmap & 0x20U) == 0) {
        iVar11 = facetIdx * 0xc;
DrawC_PrimClip_envmap20Main:
        do {
          iVar12 = iVar11;
          uVar9 = facetIdx - 1;
          do {
            do {
              do {
                do {
                  facetIdx = uVar9;
                  iVar11 = iVar12 + -0xc;
                  if (facetIdx == 0xffffffff) {
                    return;
                  }
                  facet_p_v2 = (int)&obj->facet[-1].flag + iVar12;
                  vert_a_idx2 = *(u_char *)(facet_p_v2 + 3);
                  vert_b_idx2 = *(u_char *)(facet_p_v2 + 4);
                  bVar1 = *(u_char *)(facet_p_v2 + 5);
                  iVar12 = iVar11;
                  uVar9 = facetIdx - 1;
                } while ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr);
                gte_ldVXY0m(*(u_int *)&sd->tV[vert_a_idx2].vt.x);
                gte_ldVZ0m(*(u_int *)&sd->tV[vert_a_idx2].vt.z);
                gte_ldVXY1m(*(u_int *)&sd->tV[vert_b_idx2].vt.x);
                gte_ldVZ1m(*(u_int *)&sd->tV[vert_b_idx2].vt.z);
                gte_ldVXY2m(*(u_int *)&sd->tV[bVar1].vt.x);
                gte_ldVZ2m(*(u_int *)&sd->tV[bVar1].vt.z);
                gte_rtpt();
                gte_nclip();
                gte_stMAC0m(sd->bfct);
                bfctResult_b = sd->bfct;
                if ((sd->head).mirror != 0) {
                  bfctResult_b = -bfctResult_b;
                }
                uVar9 = facetIdx - 1;
              } while (bfctResult_b < 1);
              gte_stSXY0m(sd->dvx0);
              gte_stSXY1m(sd->dvx1);
              gte_stSXY2m(sd->dvx2);
              clipW_or_vz = sd->tV[vert_b_idx2].vt.z;
              clipH_or_vz = sd->tV[bVar1].vt.z;
              (sd->vt0).z = sd->tV[vert_a_idx2].vt.z;
              (sd->vt1).z = clipW_or_vz;
              (sd->vt2).z = clipH_or_vz;
              sVar4 = (sd->head).clipW;
              sVar5 = (sd->head).clipH;
            } while (((((sVar4 < sd->dvx0) && (sVar4 < sd->dvx1)) &&
                      (uVar9 = facetIdx - 1, sVar4 < sd->dvx2)) ||
                     (((sd->dvx0 < 0 && (sd->dvx1 < 0)) && (uVar9 = facetIdx - 1, sd->dvx2 < 0))))
                    || ((((sVar5 < sd->dvy0 && (sVar5 < sd->dvy1)) &&
                         (uVar9 = facetIdx - 1, sVar5 < sd->dvy2)) ||
                        ((((sd->dvy0 < 0 && (sd->dvy1 < 0)) && (uVar9 = facetIdx - 1, sd->dvy2 < 0))
                         || ((((sd->vt0).z < 0 && ((sd->vt1).z < 0)) &&
                             (uVar9 = facetIdx - 1, (sd->vt2).z < 0))))))));
            gte_avsz3();
            gte_stOTZm(sd->otz);
            bfctResult_c = sd->otz + sd->sub_otz;
            sd->otz = bfctResult_c;
            if (bfctResult_c < 0) goto DrawC_PrimClip_envmap20Main;
            uVar9 = facetIdx - 1;
          } while (sd->sub_otSize < bfctResult_c);
          DRAWC_OTLINK_FT3(sd, facet_p_v3);
          tu20 = *(int *)&sd->dvx0;
          tu21 = *(int *)&sd->dvx1;
          *(u_int *)(facet_p_v3 + 0x18) = *(u_int *)&sd->dvx2;
          *(int *)(facet_p_v3 + 8) = tu20;
          *(int *)(facet_p_v3 + 0x10) = tu21;
          uVar10 = 0x24;
          if ((*(u_short *)facet_p_v2 & 1) != 0) {
            uVar10 = 0x26;
          }
          *(long *)(facet_p_v3 + 4) = sd->color;
          *(u_char *)(facet_p_v3 + 7) = uVar10;
          if (((envmap & 2U) == 0) || ((*(u_short *)facet_p_v2 & 1) != 0)) {
            tD22 = (int)sd->pmxStart;
            iVar12 = tD22 + (u_int)*(u_char *)(facet_p_v2 + 2) * 0x10;
            if ((*(u_short *)(iVar12 + 0xe) & 0x7f) == 0) {
              uv_pack_b = *(u_short *)(iVar12 + 6);
              *(u_short *)(facet_p_v3 + 0xe) = *(u_short *)(iVar12 + 2);
              *(u_short *)(facet_p_v3 + 0x16) = uv_pack_b;
              uv_pack_b = *(u_short *)(facet_p_v2 + 8);
              tu15 = *(short *)(facet_p_v2 + 10);
              *(u_short *)(facet_p_v3 + 0xc) = *(u_short *)(facet_p_v2 + 6);
              *(u_short *)(facet_p_v3 + 0x14) = uv_pack_b;
              *(short *)(facet_p_v3 + 0x1c) = tu15;
              goto DrawC_PrimClip_envmap20Main;
            }
            uVar17 = sd->offsetU1;
            uVar21 = sd->offsetV1;
            if ((*(u_short *)(iVar12 + 0xe) & 2) != 0) {
              uVar17 = sd->offsetU2;
              uVar21 = sd->offsetV2;
            }
            tu14 = *(short *)(iVar12 + 6);
            *(u_short *)(facet_p_v3 + 0xe) = *(u_short *)(iVar12 + 2);
            *(short *)(facet_p_v3 + 0x16) = tu14;
          }
          else {
            uVar17 = sd->offsetU0;
            uVar21 = sd->offsetV0;
            tu7 = sd->pmxStart[*(u_char *)(facet_p_v2 + 2)].tpage;
            *(u_short *)(facet_p_v3 + 0xe) = sd->pmxStart[*(u_char *)(facet_p_v2 + 2)].clut;
            *(short *)(facet_p_v3 + 0x16) = tu7;
          }
          cVar1 = *(char *)(facet_p_v2 + 8);
          tc57 = *(char *)(facet_p_v2 + 10);
          *(u_char *)(facet_p_v3 + 0xc) = *(char *)(facet_p_v2 + 6) + uVar17;
          *(u_char *)(facet_p_v3 + 0x14) = cVar1 + uVar17;
          *(u_char *)(facet_p_v3 + 0x1c) = tc57 + uVar17;
          cVar1 = *(char *)(facet_p_v2 + 9);
          tc57 = *(char *)(facet_p_v2 + 0xb);
          *(u_char *)(facet_p_v3 + 0xd) = *(char *)(facet_p_v2 + 7) + uVar21;
          *(u_char *)(facet_p_v3 + 0x15) = cVar1 + uVar21;
          *(u_char *)(facet_p_v3 + 0x1d) = tc57 + uVar21;
        } while( true );
      }
      vt2 = (int)&sd->vt5;
      u1 = &sd->u3;
      u2_00 = (int)&sd->u5;
      vt2_00 = (int)&sd->vt4;
      u2 = &sd->u4;
      iVar11 = facetIdx * 0xc;
      while( true ) {
        facetIdx = facetIdx - 1;
        iVar11 = iVar11 + -0xc;
        if (facetIdx == 0xffffffff) break;
        overlay_entry = (int)obj->facet;
        iVar12 = overlay_entry + iVar11;
        vert_a_idx = *(u_char *)(iVar12 + 5);
        bVar2 = *(u_char *)(iVar12 + 2);
        tD21 = (int)(sd->tV + *(u_char *)(iVar12 + 3));
        tD23 = (int)(sd->tV + *(u_char *)(iVar12 + 4));
        sVar4 = *(short *)(tD21 + 2);
        sVar5 = *(short *)(tD21 + 4);
        (sd->vt0).x = *(short *)tD21;
        (sd->vt0).y = sVar4;
        (sd->vt0).z = sVar5;
        sVar4 = *(short *)(tD23 + 2);
        sVar5 = *(short *)(tD23 + 4);
        pDVar13 = sd->tV + vert_a_idx;
        (sd->vt1).x = *(short *)tD23;
        (sd->vt1).y = sVar4;
        (sd->vt1).z = sVar5;
        ts8 = (pDVar13->vt).x;
        ts9 = (pDVar13->vt).y;
        sVar4 = (sd->vt0).x;
        sVar5 = (sd->vt1).x;
        ts3 = (sd->vt0).y;
        (sd->vt2).z = (pDVar13->vt).z;
        ts4 = (sd->vt1).y;
        (sd->vt3).x = (short)((int)sVar4 + (int)sVar5 + 1 >> 1);
        sVar4 = (sd->vt0).z;
        (sd->vt2).x = ts8;
        (sd->vt2).y = ts9;
        sVar5 = (sd->vt1).z;
        (sd->vt3).y = (short)((int)ts3 + (int)ts4 + 1 >> 1);
        ts10 = (sd->vt1).x;
        ts11 = (sd->vt2).x;
        (sd->vt3).z = (short)((int)sVar4 + (int)sVar5 + 1 >> 1);
        pDVar19 = sd->pmxStart;
        (sd->vt4).x = (short)((int)ts10 + (int)ts11 + 1 >> 1);
        sVar4 = (sd->vt2).z;
        sVar5 = (sd->vt1).z;
        (sd->vt4).y = (short)((int)(sd->vt1).y + (int)(sd->vt2).y + 1 >> 1);
        ts14 = (sd->vt2).x;
        ts15 = (sd->vt0).x;
        (sd->vt4).z = (short)((int)sVar5 + (int)sVar4 + 1 >> 1);
        sVar4 = (sd->vt2).y;
        sVar5 = (sd->vt0).y;
        (sd->vt5).x = (short)((int)ts14 + (int)ts15 + 1 >> 1);
        ts14 = (sd->vt2).z;
        ts15 = (sd->vt0).z;
        (sd->vt5).y = (short)((int)sVar4 + (int)sVar5 + 1 >> 1);
        (sd->vt5).z = (short)((int)ts14 + (int)ts15 + 1 >> 1);
        uv_pack_b = *(u_short *)(iVar12 + 6);
        tu10 = *(short *)(iVar12 + 8);
        tu11 = *(short *)(iVar12 + 10);
        sd->u0 = (char)uv_pack_b;
        sd->v0 = (char)((u_short)uv_pack_b >> 8);
        sd->u1 = (char)tu10;
        sd->v1 = (char)((u_short)tu10 >> 8);
        sd->u2 = (char)tu11;
        sd->v2 = (char)((u_short)tu11 >> 8);
        pDVar19 = pDVar19 + bVar2;
        if ((envmap & 2U) != 0) {
          tu5 = sd->offsetU0;
          tu6 = sd->offsetV0;
          sd->u0 = sd->u0 + tu5;
          sd->v0 = sd->v0 + tu6;
          sd->u1 = sd->u1 + tu5;
          sd->v1 = sd->v1 + tu6;
          sd->u2 = sd->u2 + tu5;
          sd->v2 = sd->v2 + tu6;
        }
        sd->u3 = (u_char)((int)((u_int)sd->u0 + (u_int)sd->u1 + 1) >> 1);
        sd->v3 = (u_char)((int)((u_int)sd->v0 + (u_int)sd->v1 + 1) >> 1);
        sd->u4 = (u_char)((int)((u_int)sd->u1 + (u_int)sd->u2 + 1) >> 1);
        sd->v4 = (u_char)((int)((u_int)sd->v1 + (u_int)sd->v2 + 1) >> 1);
        sd->u5 = (u_char)((int)((u_int)sd->u2 + (u_int)sd->u0 + 1) >> 1);
        sd->v5 = (u_char)((int)((u_int)sd->v2 + (u_int)sd->v0 + 1) >> 1);
        DrawC_DividePrim(&sd->vt0,(COORD16 *)vt1,(COORD16 *)vt2,(u_short *)&sd->u0,(u_short *)u1,
                   (u_short *)u2_00,pDVar19,sd);
        DrawC_DividePrim((COORD16 *)vt1,&sd->vt1,(COORD16 *)vt2_00,(u_short *)u1,(u_short *)&sd->u1,
                   (u_short *)u2,pDVar19,sd);
        DrawC_DividePrim((COORD16 *)vt2,(COORD16 *)vt2_00,&sd->vt2,(u_short *)u2_00,(u_short *)u2,
                   (u_short *)&sd->u2,pDVar19,sd);
        DrawC_DividePrim((COORD16 *)vt2,(COORD16 *)vt1,(COORD16 *)vt2_00,(u_short *)u2_00,(u_short *)u1,
                   (u_short *)u2,pDVar19,sd);
      }
    }
  }
  else {
    if (facetIdx_dec == 8) {
      iVar11 = facetIdx * 0xc;
DrawC_PrimClip_envmap9Eq8Top:
      iVar12 = iVar11;
      uVar9 = facetIdx - 1;
DrawC_PrimClip_envmap9Eq8Inner:
      while( true ) {
        do {
          do {
            do {
              facetIdx = uVar9;
              iVar11 = iVar12 + -0xc;
              if (facetIdx == 0xffffffff) {
                return;
              }
              facet_p_v1 = (u_short *)((int)&obj->facet[-1].flag + iVar12);
              bVar18 = *(u_char *)((int)facet_p_v1 + 3);
              bVar3 = (u_char)facet_p_v1[2];
              vert_c_idx = *(u_char *)((int)facet_p_v1 + 5);
              iVar12 = iVar11;
              uVar9 = facetIdx - 1;
            } while ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr);
            gte_ldVXY0m(*(u_int *)&sd->tV[bVar18].vt.x);
            gte_ldVZ0m(*(u_int *)&sd->tV[bVar18].vt.z);
            gte_ldVXY1m(*(u_int *)&sd->tV[bVar3].vt.x);
            gte_ldVZ1m(*(u_int *)&sd->tV[bVar3].vt.z);
            gte_ldVXY2m(*(u_int *)&sd->tV[vert_c_idx].vt.x);
            gte_ldVZ2m(*(u_int *)&sd->tV[vert_c_idx].vt.z);
            gte_rtpt();
            gte_nclip();
            gte_stMAC0m(sd->bfct);
            iVar20 = sd->bfct;
            if ((sd->head).mirror != 0) {
              iVar20 = -iVar20;
            }
            uVar9 = facetIdx - 1;
          } while (iVar20 < 1);
          gte_stSXY0m(sd->dvx0);
          gte_stSXY1m(sd->dvx1);
          gte_stSXY2m(sd->dvx2);
          sVar4 = sd->tV[bVar3].vt.z;
          sVar5 = sd->tV[vert_c_idx].vt.z;
          (sd->vt0).z = sd->tV[bVar18].vt.z;
          (sd->vt1).z = sVar4;
          (sd->vt2).z = sVar5;
          sVar4 = (sd->head).clipW;
          sVar5 = (sd->head).clipH;
        } while ((((((sVar4 < sd->dvx0) && (sVar4 < sd->dvx1)) &&
                   (uVar9 = facetIdx - 1, sVar4 < sd->dvx2)) ||
                  (((sd->dvx0 < 0 && (sd->dvx1 < 0)) && (uVar9 = facetIdx - 1, sd->dvx2 < 0)))) ||
                 ((((sVar5 < sd->dvy0 && (sVar5 < sd->dvy1)) &&
                   (uVar9 = facetIdx - 1, sVar5 < sd->dvy2)) ||
                  (((sd->dvy0 < 0 && (sd->dvy1 < 0)) && (uVar9 = facetIdx - 1, sd->dvy2 < 0)))))) ||
                ((((sd->vt0).z < 0 && ((sd->vt1).z < 0)) && (uVar9 = facetIdx - 1, (sd->vt2).z < 0))
                ));
        gte_avsz3();
        gte_stOTZm(sd->otz);
        uVar26 = (int)((u_int)(u_short)DrawC_gOverlay[(u_char)facet_p_v1[1]] << 0x10) >> 0x10;
        if (uVar26 == 0) break;
        uVar15 = (u_int)(short)*facet_p_v1;
        uVar26 = uVar26 & 0xff;
        if ((int)uVar15 < 0) {
          uVar26 = (int)((u_int)(u_short)DrawC_gOverlay[(u_char)facet_p_v1[1]] << 0x10) >> 0x18;
        }
        iVar20 = sd->otz + sd->sub_otz;
        if ((uVar26 & 0x40) != 0) {
          iVar20 = iVar20 + -2;
        }
        uVar9 = facetIdx - 1;
        if ((-1 < iVar20) && (uVar9 = facetIdx - 1, iVar20 <= sd->sub_otSize)) {
          uVar9 = uVar15 & 0xfff;
          if (((uVar15 & 0x3f0) != 0) && (uVar26 = uVar26 & uVar9 >> 4, uVar26 != 0)) {
            for (; (uVar26 & 3) == 0; uVar26 = (int)uVar26 >> 2) {
            }
          }
          sd->otz = iVar20;
          goto DrawC_PrimClip_otStitch24Emit;
        }
      }
      iVar20 = sd->otz + sd->sub_otz;
      sd->otz = iVar20;
      if (-1 < iVar20) goto cfLbl5;
      goto DrawC_PrimClip_envmap9Eq8Top;
    }
    if (facetIdx_dec == 9) {
      iVar11 = facetIdx * 0xc;
DrawC_PrimClip_envmap9Eq9Top:
      uVar9 = facetIdx - 1;
      iVar12 = iVar11;
DrawC_PrimClip_envmap9Eq9Inner:
      do {
        do {
          do {
            do {
              facetIdx = uVar9;
              iVar11 = iVar12 + -0xc;
              if (facetIdx == 0xffffffff) {
                return;
              }
              puVar23 = (u_short *)((int)&obj->facet[-1].flag + iVar12);
              bVar18 = *(u_char *)((int)puVar23 + 3);
              bVar3 = (u_char)puVar23[2];
              bVar8 = *(u_char *)((int)puVar23 + 5);
              uVar9 = facetIdx - 1;
              iVar12 = iVar11;
            } while ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr);
            gte_ldVXY0m(*(u_int *)&sd->tV[bVar18].vt.x);
            gte_ldVZ0m(*(u_int *)&sd->tV[bVar18].vt.z);
            gte_ldVXY1m(*(u_int *)&sd->tV[bVar3].vt.x);
            gte_ldVZ1m(*(u_int *)&sd->tV[bVar3].vt.z);
            gte_ldVXY2m(*(u_int *)&sd->tV[bVar8].vt.x);
            gte_ldVZ2m(*(u_int *)&sd->tV[bVar8].vt.z);
            gte_rtpt();
            gte_nclip();
            gte_stMAC0m(sd->bfct);
            bfctResult_a = sd->bfct;
            if ((sd->head).mirror != 0) {
              bfctResult_a = -bfctResult_a;
            }
            uVar9 = facetIdx - 1;
          } while (bfctResult_a < 1);
          gte_stSXY0m(sd->dvx0);
          gte_stSXY1m(sd->dvx1);
          gte_stSXY2m(sd->dvx2);
          sVar4 = sd->tV[bVar3].vt.z;
          sVar5 = sd->tV[bVar8].vt.z;
          (sd->vt0).z = sd->tV[bVar18].vt.z;
          (sd->vt1).z = sVar4;
          (sd->vt2).z = sVar5;
          sVar4 = (sd->head).clipW;
          sVar5 = (sd->head).clipH;
        } while (((((((sVar4 < sd->dvx0) && (sVar4 < sd->dvx1)) &&
                    (uVar9 = facetIdx - 1, sVar4 < sd->dvx2)) ||
                   (((sd->dvx0 < 0 && (sd->dvx1 < 0)) && (uVar9 = facetIdx - 1, sd->dvx2 < 0)))) ||
                  (((sVar5 < sd->dvy0 && (sVar5 < sd->dvy1)) &&
                   (uVar9 = facetIdx - 1, sVar5 < sd->dvy2)))) ||
                 (((sd->dvy0 < 0 && (sd->dvy1 < 0)) && (uVar9 = facetIdx - 1, sd->dvy2 < 0)))) ||
                ((((sd->vt0).z < 0 && ((sd->vt1).z < 0)) && (uVar9 = facetIdx - 1, (sd->vt2).z < 0))
                ));
        gte_avsz3();
        gte_stOTZm(sd->otz);
        ot_offs_byte = (int)((u_int)(u_short)DrawC_gOverlay[(u_char)puVar23[1]] << 0x10) >> 0x10;
        if (ot_offs_byte == 0) {
          iVar20 = sd->otz + sd->sub_otz;
          sd->otz = iVar20;
          if (iVar20 < 0) goto DrawC_PrimClip_envmap9Eq9Top;
          uVar9 = facetIdx - 1;
          if (sd->sub_otSize < iVar20) goto DrawC_PrimClip_envmap9Eq9Inner;
          tu25 = *puVar23 & 0xfff;
          uVar26 = 0;
        }
        else {
          uVar15 = (u_int)(short)*puVar23;
          uVar26 = ot_offs_byte & 0xff;
          if ((int)uVar15 < 0) {
            uVar26 = (int)((u_int)(u_short)DrawC_gOverlay[(u_char)puVar23[1]] << 0x10) >> 0x18;
          }
          iVar20 = sd->otz + sd->sub_otz;
          uVar9 = facetIdx - 1;
          if ((iVar20 < 0) || (uVar9 = facetIdx - 1, sd->sub_otSize < iVar20))
          goto DrawC_PrimClip_envmap9Eq9Inner;
          tu25 = uVar15 & 0xfff;
          if (((uVar15 & 0x3f0) != 0) && (uVar26 = uVar26 & (u_int)tu25 >> 4, uVar26 != 0)) {
            for (; (uVar26 & 3) == 0; uVar26 = (int)uVar26 >> 2) {
            }
          }
          sd->otz = iVar20;
        }
        if (((envmap & 0x20U) == 0) || (uVar9 = facetIdx - 1, (tu25 & 1U) == 0))
        goto DrawC_PrimClip_ePmx1UVEmit;
      } while( true );
    }
  }
  return;
cfLbl5:   /* @0x800c28a8  (-f-build goto label) */
  uVar9 = facetIdx - 1;
  if (iVar20 <= sd->sub_otSize) goto cfLbl6;
  goto DrawC_PrimClip_envmap9Eq8Inner;
cfLbl6:   /* @0x800c28bc  (-f-build goto label) */
  uVar9 = *facet_p_v1 & 0xfff;
  uVar26 = 0;
DrawC_PrimClip_otStitch24Emit:
  if ((uVar26 & 3) == 0) {
    DRAWC_OTLINK_FT3(sd, puVar27);
    uVar15 = *(u_int *)&sd->dvx1;
    uVar14 = *(u_int *)&sd->dvx2;
    uVar25 = 0x808080;
    puVar27[2] = *(u_int *)&sd->dvx0;
    puVar27[4] = uVar15;
    puVar27[6] = uVar14;
    if ((uVar26 & 0x80) == 0) {
      uVar25 = sd->color;
    }
    primTypeByte_b = 0x24;
    if ((uVar9 & 1) != 0) {
      primTypeByte_b = 0x26;
    }
    puVar27[1] = uVar25;
    *(u_char *)((int)puVar27 + 7) = primTypeByte_b;
    uVar6 = sd->pmxStart[(u_char)facet_p_v1[1]].tpage;
    *(u_short *)((int)puVar27 + 0xe) = sd->pmxStart[(u_char)facet_p_v1[1]].clut;
    *(u_short *)((int)puVar27 + 0x16) = uVar6;
    uVar6 = facet_p_v1[4];
    tu33 = facet_p_v1[5];
    *(u_short *)(puVar27 + 3) = facet_p_v1[3];
    *(u_short *)(puVar27 + 5) = uVar6;
    *(u_short *)(puVar27 + 7) = tu33;
  }
  else {
    puVar27 = (u_int *)(sd->head).cprim.PrimPtr;
    pTVar24 = overlay + (u_int)(u_char)facet_p_v1[1] * 3 + ((uVar26 & 3) - 1);
    DRAWC_OTLINK_FT3B(sd, puVar27);
    uVar15 = *(u_int *)&sd->dvx1;
    uVar14 = *(u_int *)&sd->dvx2;
    tu41 = 0x808080;
    puVar27[2] = *(u_int *)&sd->dvx0;
    puVar27[4] = uVar15;
    puVar27[6] = uVar14;
    if ((uVar26 & 0x80) == 0) {
      tu41 = sd->color;
    }
    primTypeByte = 0x24;
    if ((uVar9 & 1) != 0) {
      primTypeByte = 0x26;
    }
    puVar27[1] = tu41;
    *(u_char *)((int)puVar27 + 7) = primTypeByte;
    uVar17 = pTVar24->u;
    uVar21 = pTVar24->v;
    iVar12 = (u_int)(u_char)facet_p_v1[1] + (int)pTVar24->offset;
    uVar6 = sd->pmxStart[iVar12].tpage;
    *(u_short *)((int)puVar27 + 0xe) = sd->pmxStart[iVar12].clut;
    *(u_short *)((int)puVar27 + 0x16) = uVar6;
    uVar6 = facet_p_v1[4];
    tu33 = facet_p_v1[5];
    *(u_char *)(puVar27 + 3) = (char)facet_p_v1[3] + uVar17;
    *(u_char *)(puVar27 + 5) = (char)uVar6 + uVar17;
    *(u_char *)(puVar27 + 7) = (char)tu33 + uVar17;
    cVar1 = *(char *)((int)facet_p_v1 + 9);
    tc7 = *(u_char *)((int)facet_p_v1 + 0xb);
    *(u_char *)((int)puVar27 + 0xd) = *(char *)((int)facet_p_v1 + 7) + uVar21;
    *(u_char *)((int)puVar27 + 0x15) = cVar1 + uVar21;
    *(u_char *)((int)puVar27 + 0x1d) = tc7 + uVar21;
  }
  goto DrawC_PrimClip_envmap9Eq8Top;
DrawC_PrimClip_ePmx1UVEmit:
  if (((tu25 & 0x3f3U) != 0) &&
     ((absZ = *(int *)&sd->ePmx1), absZ != 0)) {
    tps22 = Nvertex_p + (u_int)*(u_char *)((int)puVar23 + 3) * 6;
    sVar4 = *(short *)(tps22 + 2);
    sVar5 = *(short *)(tps22 + 4);
    (sd->vt0).x = *(short *)tps22;
    (sd->vt0).y = sVar4;
    (sd->vt0).z = sVar5;
    vert_xyz_iter = (short *)(Nvertex_p + (u_int)(u_char)puVar23[2] * 6);
    sVar4 = vert_xyz_iter[1];
    sVar5 = vert_xyz_iter[2];
    (sd->vt1).x = *vert_xyz_iter;
    (sd->vt1).y = sVar4;
    (sd->vt1).z = sVar5;
    psVar8 = (short *)(Nvertex_p + (u_int)*(u_char *)((int)puVar23 + 5) * 6);
    sVar4 = psVar8[1];
    sVar5 = psVar8[2];
    (sd->vt2).x = *psVar8;
    (sd->vt2).y = sVar4;
    (sd->vt2).z = sVar5;
    DRAWC_OTLINK_MODE(sd, "84", "88", "92");
    DRAWC_OTLINK_FT3(sd, facet_p_v4);
    DRAWC_OTLINK_MODE(sd, "72", "76", "80");
    tu40 = *(u_int *)&sd->dvx1;
    uVar16 = *(u_int *)&sd->dvx2;
    *(u_int *)(facet_p_v4 + 8) = *(u_int *)&sd->dvx0;
    *(u_int *)(facet_p_v4 + 0x10) = tu40;
    *(u_int *)(facet_p_v4 + 0x18) = uVar16;
    *(long *)(facet_p_v4 + 4) = sd->eColor0;
    *(u_char *)(facet_p_v4 + 7) = 0x26;
    tu16 = (sd->ePmx1).tpage;
    *(u_short *)(facet_p_v4 + 0xe) = (sd->ePmx1).clut;
    *(short *)(facet_p_v4 + 0x16) = tu16;
    tc45 = (sd->ePmx1).u0 + 0x40;
    vert_v_byte = (sd->ePmx1).v0 + (char)sd->eAddZ;
    sVar4 = (sd->vt0).z;
    *(u_char *)(facet_p_v4 + 0xc) = (char)(sd->vt0).y + tc45;
    *(char *)(facet_p_v4 + 0xd) = (char)sVar4 + vert_v_byte;
    sVar4 = (sd->vt1).z;
    *(u_char *)(facet_p_v4 + 0x14) = (char)(sd->vt1).y + tc45;
    *(char *)(facet_p_v4 + 0x15) = (char)sVar4 + vert_v_byte;
    sVar4 = (sd->vt2).z;
    *(u_char *)(facet_p_v4 + 0x1c) = (char)(sd->vt2).y + tc45;
    *(char *)(facet_p_v4 + 0x1d) = (char)sVar4 + vert_v_byte;
  }
  ti16 = *(int *)&sd->ePmx0;
  if (ti16 != 0) {
    DRAWC_OTLINK_FT3(sd, primOut);
    uVar9 = *(u_int *)&sd->dvx1;
    uVar15 = *(u_int *)&sd->dvx2;
    primOut[2] = *(u_int *)&sd->dvx0;
    primOut[4] = uVar9;
    primOut[6] = uVar15;
    if ((uVar26 & 1) == 0) {
      if ((tu25 & 4U) == 0) {
        primOut[1] = sd->eColor0;
      }
      else {
        primOut[1] = sd->eColor1;
      }
    }
    else {
      primOut[1] = sd->eColor2;
    }
    *(u_char *)((int)primOut + 7) = 0x26;
    tpage_alt = (sd->ePmx0).tpage;
    *(u_short *)((int)primOut + 0xe) = (sd->ePmx0).clut;
    *(u_short *)((int)primOut + 0x16) = tpage_alt;
    ePmx0_vOff = (sd->ePmx0).v0;
    tc57 = (sd->ePmx0).u0 + '@';
    cVar1 = sd->tV[bVar18].v;
    *(char *)(primOut + 3) = sd->tV[bVar18].u + tc57;
    *(u_char *)((int)primOut + 0xd) = cVar1 + ePmx0_vOff;
    cVar1 = sd->tV[bVar3].v;
    *(char *)(primOut + 5) = sd->tV[bVar3].u + tc57;
    *(u_char *)((int)primOut + 0x15) = cVar1 + ePmx0_vOff;
    cVar1 = sd->tV[bVar8].v;
    *(char *)(primOut + 7) = sd->tV[bVar8].u + tc57;
    *(u_char *)((int)primOut + 0x1d) = cVar1 + ePmx0_vOff;
  }
  if ((uVar26 & 3) == 0) {
    DRAWC_OTLINK_FT3(sd, puVar27);
    uVar9 = *(u_int *)&sd->dvx1;
    uVar26 = *(u_int *)&sd->dvx2;
    puVar27[2] = *(u_int *)&sd->dvx0;
    puVar27[4] = uVar9;
    puVar27[6] = uVar26;
    uVar10 = 0x24;
    if ((tu25 & 1U) != 0) {
      uVar10 = 0x26;
    }
    puVar27[1] = sd->color;
    *(u_char *)((int)puVar27 + 7) = uVar10;
    uVar6 = sd->pmxStart[(u_char)puVar23[1]].tpage;
    *(u_short *)((int)puVar27 + 0xe) = sd->pmxStart[(u_char)puVar23[1]].clut;
    *(u_short *)((int)puVar27 + 0x16) = uVar6;
    uVar6 = puVar23[4];
    tu33 = puVar23[5];
    *(u_short *)(puVar27 + 3) = puVar23[3];
    *(u_short *)(puVar27 + 5) = uVar6;
    *(u_short *)(puVar27 + 7) = tu33;
  }
  else {
    puVar27 = (u_int *)(sd->head).cprim.PrimPtr;
    pTVar24 = overlay + (u_int)(u_char)puVar23[1] * 3 + ((uVar26 & 3) - 1);
    DRAWC_OTLINK_FT3B(sd, puVar27);
    uVar9 = *(u_int *)&sd->dvx1;
    uVar26 = *(u_int *)&sd->dvx2;
    puVar27[2] = *(u_int *)&sd->dvx0;
    puVar27[4] = uVar9;
    puVar27[6] = uVar26;
    bVar18 = 0x24;
    if ((tu25 & 1U) != 0) {
      bVar18 = 0x26;
    }
    puVar27[1] = sd->color;
    *(u_char *)((int)puVar27 + 7) = bVar18;
    if ((tu25 & 1U) != 0) {
      *(u_char *)((int)puVar27 + 7) = bVar18 | 2;
    }
    uVar17 = pTVar24->u;
    uVar21 = pTVar24->v;
    iVar12 = (u_int)(u_char)puVar23[1] + (int)pTVar24->offset;
    uVar6 = sd->pmxStart[iVar12].tpage;
    *(u_short *)((int)puVar27 + 0xe) = sd->pmxStart[iVar12].clut;
    *(u_short *)((int)puVar27 + 0x16) = uVar6;
    uVar6 = puVar23[4];
    tu19 = puVar23[5];
    *(u_char *)(puVar27 + 3) = (char)puVar23[3] + uVar17;
    *(u_char *)(puVar27 + 5) = (char)uVar6 + uVar17;
    *(u_char *)(puVar27 + 7) = (char)tu19 + uVar17;
    cVar1 = *(char *)((int)puVar23 + 9);
    tc57 = *(char *)((int)puVar23 + 0xb);
    *(u_char *)((int)puVar27 + 0xd) = *(char *)((int)puVar23 + 7) + uVar21;
    *(u_char *)((int)puVar27 + 0x15) = cVar1 + uVar21;
    *(u_char *)((int)puVar27 + 0x1d) = tc57 + uVar21;
  }
  goto DrawC_PrimClip_envmap9Eq9Top;
}

/* ---- DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache  [DRAWC.CPP:3551-3869] SLD-VERIFIED ---- */
void DrawC_PrimMenu(matrixtdef *m,coorddef *t,Transformer_zObj *obj,Transformer_zOverlay *overlay,
               int envmap,Draw_CarCache *sd)

{
  COORD16 * Nvertice;
  COORD16 * vt;
  short t1;
  short t2;
  short t3;
  int r0;
  int r1;
  int r2;
  PCOORD16 * tV;
  POLY_FT3 * prim;
  int overlayFlag;
  int id2;
  int bfct;
  long xy0;
  long xy1;
  long xy2;
  u_long color;
  u_char code;
  int index;
  int which;
  Transformer_zOverlay * facetOverlay;
  Draw_tPixMap * pmx;
  u_char u0;
  u_char u1;
  u_char u2;
  u_char v0;
  u_char v1;
  u_char v2;
  u_short uv0;
  u_short uv1;
  u_int bVar1;   /* SYM id0/id1/id2 (INT): facet vertex idx (lbu, no re-mask), then MUTATED
                  * in place into the slot base sd+id*8 (oracle addu t2,t2,s1) -- 90s
                  * ints-holding-addresses; tV fields read at +0xD0..0xD7 off it */
  u_int bVar2;
  u_int bVar3;
  u_char uVar4;
  char cVar5;
  u_char uVar6;
  short sVar7;
  u_short uVar8;
  u_int uVar9;
  u_int *puVar10;
  short *psVar11;
  u_short clut;
  short sVar12;
  u_short uVar13;
  int iVar14;
  u_short tpage;
  u_short uv2;
  COORD16 *pCVar15;
  u_char u;
  int iVar16;
  u_char uVar17;
  u_char v;
  short *psVar18;
  short *pOvl;
  int fOff;    /* facet byte offset, facet-loop scope (oracle t9) */
  int iVar19;
  u_int uVar20;
  char *pcVar21;
  short *psVar22;
  Transformer_zOverlay *pTVar23;
  Transformer_zFacet *facet;
  Draw_CarVertex *pDVar24;
  u_short *puVar25;
  int id1;
  int id0;
  u_int uVar26;
  short facetFlag;
  u_int *puVar27;
  u_int *puVar28;
  u_long *puVar29;
  char cVar30;
  u_long *puVar31;
  u_int uVar32;
  int i;
  u_int uVar33;

  pCVar15 = obj->Nvertex;
  if ((envmap & 1U) != 0) {
gte_SetRotMatrix(&DrawC_gMatA);
gte_SetTransMatrix(&DrawC_gMatA);
    i = (u_int)obj->numVertex;   /* SYM: ONE fn-scope `i` (t8) counts ALL 3 loops */
    pcVar21 = &sd->tV[0].v;
    psVar18 = &pCVar15->z;
    /* exit-in-the-middle: keeps the top dec+test + unconditional j back (no rotation),
     * and the after-join reg-reg compare beats the nor/~x const-fold */
    while (1) {
      i = i - 1;
      if (i == -1) break;   /* literal: SYM names no sentinel local */
      sVar12 = psVar18[-1];
      sVar7 = *psVar18;
      (sd->vt0).x = pCVar15->x;
      (sd->vt0).y = sVar12;
      (sd->vt0).z = sVar7;
gte_ldv0((char *)sd + 0xac);
      gte_rt();
gte_stlvnl((char *)sd + 0x9c);
      iVar14 = (sd->tv).vz;
      iVar16 = (sd->tv).vx;   /* named int temp: full lw batched before the abs branch */
      if (iVar14 < 0) {
        iVar14 = -iVar14;
      }
      psVar18 = psVar18 + 3;
      pCVar15 = pCVar15 + 1;
      pcVar21[-1] = (char)iVar16;
      *pcVar21 = (char)iVar14;
      pcVar21 = pcVar21 + 8;
    }
  }
  TrsProj_SetTransPrecision(8);
  /* load-3/shift-3/store-3 per row (oracle batches lw x3 -> sra x3 -> sh x3);
   * row1 stored POSITIVE first, then the middle column negated: [1][0] via the
   * still-live temp (negu reg), [1][1]/[1][2] via lhu read-modify-write. */
  r0 = m->m[0] >> 4;
  r1 = m->m[3] >> 4;
  r2 = m->m[6] >> 4;
  (sd->matB).m[0][0] = (short)r0;
  (sd->matB).m[0][1] = (short)r1;
  (sd->matB).m[0][2] = (short)r2;
  r0 = m->m[1] >> 4;
  r1 = m->m[4] >> 4;
  r2 = m->m[7] >> 4;
  (sd->matB).m[1][0] = (short)r0;
  (sd->matB).m[1][1] = (short)r1;
  (sd->matB).m[1][2] = (short)r2;
  r1 = m->m[2] >> 4;
  r2 = m->m[5] >> 4;
  iVar19 = m->m[8] >> 4;
  (sd->matB).m[1][0] = (short)-r0;
  (sd->matB).m[1][1] = -(sd->matB).m[1][1];
  (sd->matB).m[2][0] = (short)r1;
  (sd->matB).m[1][2] = -(sd->matB).m[1][2];
  (sd->matB).m[2][1] = (short)r2;
  (sd->matB).m[2][2] = (short)iVar19;
  /* TrsProj_precision loaded AT-USE, one lw CSE'd across the 3 sravs; the former
   * `& 0x1f` shift-count masks were a Ghidra transcription artifact (catalog SC) */
  (sd->matB).t[0] = t->x >> TrsProj_precision;
  (sd->matB).t[1] = -(t->y >> TrsProj_precision);
  (sd->matB).t[2] = t->z >> TrsProj_precision;
  TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
  pDVar24 = sd->tV;
  psVar22 = &sd->tV[0].vt.z;
  pCVar15 = obj->vertex;
  i = (u_int)obj->numVertex;
  psVar18 = &pCVar15->z;
  while (1) {
    i = i - 1;
    if (i == -1) break;
    sVar12 = psVar18[-1];
    sVar7 = *psVar18;
    psVar18 = psVar18 + 3;
    psVar11 = &pCVar15->x;
    pCVar15 = pCVar15 + 1;
    (pDVar24->vt).x = *psVar11;
    psVar22[-1] = sVar12;
    *psVar22 = sVar7;
    psVar22 = psVar22 + 4;
    pDVar24 = pDVar24 + 1;
  }
  i = (u_int)obj->numFacet;   /* gOverlay base: NO local (SYM) -- gcc LIM hoists the la */
  /* flat facet loop (oracle .L800C3550/.L800C3554): dec+test at top with a FRESH -1
   * temp each iteration (not hoisted); every skip path is a plain `continue` -- gcc's
   * delay-slot compensation reproduces the dec-in-slot / undo split by itself.
   * NO explicit byte offset: SYM names no such local -- `obj->facet + i` and gcc's
   * strength reduction creates the t9 giv (i*12, decremented alongside the counter) */
  for (;;) {
    i = i - 1;
    if (i == -1) {
      return;
    }
    puVar25 = (u_short *)(obj->facet + i);
    bVar1 = *(u_char *)((int)puVar25 + 3);
    bVar2 = (u_char)puVar25[2];
    bVar3 = *(u_char *)((int)puVar25 + 5);
    if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) continue;
    /* index -> slot-base IN-PLACE (oracle sll t2,3; addu t2,t2,s1 -- same reg morphs;
     * the bases then feed the lwc2 disps 0xD0/0xD4 AND the envmap uv lbu's 0xD6/0xD7
     * across the OT templates) */
    bVar1 = bVar1 * 8;   /* TWO in-place stmts per vertex: same pseudo -> sll t2,t2,3;
                          * addu t2,t2,s1 (a fused a*8+b stages through a fresh temp) */
    bVar1 = bVar1 + (u_int)sd;
    bVar2 = bVar2 * 8;
    bVar2 = bVar2 + (u_int)sd;
    bVar3 = bVar3 * 8;
    bVar3 = bVar3 + (u_int)sd;
    gte_ldVXY0m(*(u_int *)(bVar1 + 0xD0));
    gte_ldVZ0m(*(u_int *)(bVar1 + 0xD4));
    gte_ldVXY1m(*(u_int *)(bVar2 + 0xD0));
    gte_ldVZ1m(*(u_int *)(bVar2 + 0xD4));
    gte_ldVXY2m(*(u_int *)(bVar3 + 0xD0));
    gte_ldVZ2m(*(u_int *)(bVar3 + 0xD4));
    gte_rtpt();
    gte_nclip();
    gte_stMAC0m(sd->bfct);
    iVar19 = sd->bfct;
    if ((sd->head).mirror != 0) {
      iVar19 = -iVar19;
    }
    if (iVar19 < 1) continue;
    gte_stSXY0m(sd->dvx0);
    gte_stSXY1m(sd->dvx1);
    gte_stSXY2m(sd->dvx2);
    gte_avsz3();
    gte_stOTZm(sd->otz);
    iVar19 = sd->otz + sd->sub_otz;
    sd->otz = iVar19;
    if (iVar19 < 0) continue;
    if (sd->sub_otSize < iVar19) continue;
    overlayFlag = (int)((u_int)(u_short)DrawC_gOverlay[(u_char)puVar25[1]] << 0x10) >> 0x10;
    uVar13 = *puVar25;   /* flag lhu lands in the overlay-lhu load-delay slot */
    /* SYM truth: NO `which` at this scope -- the decode MUTATES overlayFlag in
     * place (one pseudo, oracle a1 throughout); `which` is an overlay-arm local */
    if (overlayFlag != 0) {
      overlayFlag = overlayFlag & 0x3f;
      if ((int)((u_int)uVar13 << 0x10) < 0) {
        overlayFlag = (int)((u_int)(u_short)DrawC_gOverlay[(u_char)puVar25[1]] << 0x10) >> 0x18;
      }
      if (((uVar13 & 0x3f0) != 0) &&
          (overlayFlag = overlayFlag & (uVar13 & 0xfff) >> 4, overlayFlag != 0)) {
        for (; (overlayFlag & 3) == 0; overlayFlag = (int)overlayFlag >> 2) {
        }
      }
    }
    if ((envmap & 1U) != 0) {
      /* mode-packet OT-link: variant B template (drawModeOff @ sd+0x54) */
      DRAWC_OTLINK_MODE(sd, "84", "88", "92");
      /* FT3 OT-link: split form (prim lw = compiler code at EVERY retail site) */
      puVar27 = (u_int *)(sd->head).cprim.PrimPtr;
      DRAWC_OTLINK_FT3B(sd, puVar27);
      /* mode-packet OT-link: variant B template (drawModeOn @ sd+0x48) */
      DRAWC_OTLINK_MODE(sd, "72", "76", "80");
      xy0 = *(u_int *)&sd->dvx0;
      xy1 = *(u_int *)&sd->dvx1;
      xy2 = *(u_int *)&sd->dvx2;
      puVar27[2] = xy0;
      puVar27[4] = xy1;
      puVar27[6] = xy2;
      if ((uVar13 & 4) != 0) {   /* fall-through = the !=0 arm (oracle beqz polarity) */
        puVar27[1] = sd->eColor1;
      }
      else {
        puVar27[1] = sd->eColor0;
      }
      *(u_char *)((int)puVar27 + 7) = 0x26;
      uVar8 = (sd->ePmx0).tpage;
      *(u_short *)((int)puVar27 + 0xe) = (sd->ePmx0).clut;
      *(u_short *)((int)puVar27 + 0x16) = uVar8;
      /* base u/v pair first (lbu u0; lbu v0; addiu +0x40), then per-vertex u,v
       * lbu pairs off the CSE'd tV bases (oracle 0xD6/0xD7 disp reuse) */
      cVar30 = (sd->ePmx0).u0;
      uVar4 = (sd->ePmx0).v0;
      cVar30 = cVar30 + '@';   /* +0x40 AFTER both base lbu's (oracle order) */
      u0 = *(u_char *)(bVar1 + 0xD6);
      v0 = *(u_char *)(bVar1 + 0xD7);
      *(u_char *)((int)puVar27 + 0xc) = u0 + cVar30;
      *(u_char *)((int)puVar27 + 0xd) = v0 + uVar4;
      u1 = *(u_char *)(bVar2 + 0xD6);
      v1 = *(u_char *)(bVar2 + 0xD7);
      *(u_char *)((int)puVar27 + 0x14) = u1 + cVar30;
      *(u_char *)((int)puVar27 + 0x15) = v1 + uVar4;
      u2 = *(u_char *)(bVar3 + 0xD6);
      v2 = *(u_char *)(bVar3 + 0xD7);
      *(u_char *)((int)puVar27 + 0x1c) = u2 + cVar30;
      *(u_char *)((int)puVar27 + 0x1d) = v2 + uVar4;
    }
    if ((overlayFlag & 3) != 0) {   /* fall-through = the overlay arm (oracle beqz) */
      which = (overlayFlag & 3) - 1;   /* SYM `which` (a0): the dispatch andi minus 1,
                                        * lands in the beqz delay slot */
      index = (u_char)puVar25[1];      /* SYM `index` (v1): facet texture byte */
      puVar27 = (u_int *)(sd->head).cprim.PrimPtr;   /* prim lw = compiler code here:
                                    * retail schedules it INTO the facetOverlay math */
      /* index sum grouped BEFORE the pointer scale (oracle: index*3 + which, ONE <<2) */
      pTVar23 = overlay + ((u_int)index * 3 + which);
      /* FT3 OT-link: variant A, split form */
      DRAWC_OTLINK_FT3B(sd, puVar27);
      xy0 = *(u_int *)&sd->dvx0;
      xy1 = *(u_int *)&sd->dvx1;
      xy2 = *(u_int *)&sd->dvx2;
      puVar27[2] = xy0;
      puVar27[4] = xy1;
      puVar27[6] = xy2;
      puVar27[1] = sd->color;
      if ((uVar13 & 1) != 0) {
        uVar17 = 0x26;
      }
      else {
        uVar17 = 0x24;   /* else-arm default -> lands in the beqz delay slot */
      }
      *(u_char *)((int)puVar27 + 7) = uVar17;
      uVar4 = pTVar23->u;
      uVar6 = pTVar23->v;
      iVar16 = (u_int)(u_char)puVar25[1] + (int)pTVar23->offset;
      pmx = &sd->pmxStart[iVar16];   /* SYM pmx (Draw_tPixMap*) block local */
      uVar13 = pmx->tpage;
      *(u_short *)((int)puVar27 + 0xe) = pmx->clut;
      *(u_short *)((int)puVar27 + 0x16) = uVar13;
      /* full tail duplicated with the SAME temps: colors identically -> gcc
       * cross-jump-merges into the retail jump-into-middle form (SLD: per-arm
       * one-line macros at 3866/3869 whose expansions merged) */
      uVar13 = puVar25[4];
      uVar8 = puVar25[5];
      *(u_char *)(puVar27 + 3) = (char)puVar25[3] + uVar4;
      *(u_char *)(puVar27 + 5) = (char)uVar13 + uVar4;
      *(u_char *)(puVar27 + 7) = (char)uVar8 + uVar4;
      cVar5 = *(char *)((int)puVar25 + 9);
      cVar30 = *(char *)((int)puVar25 + 0xb);
      *(u_char *)((int)puVar27 + 0xd) = *(char *)((int)puVar25 + 7) + uVar6;
      *(u_char *)((int)puVar27 + 0x15) = cVar5 + uVar6;
      *(u_char *)((int)puVar27 + 0x1d) = cVar30 + uVar6;
      continue;
    }
    else {
      /* FT3 OT-link: split form */
      puVar27 = (u_int *)(sd->head).cprim.PrimPtr;
      DRAWC_OTLINK_FT3B(sd, puVar27);
      xy0 = *(u_int *)&sd->dvx0;
      xy1 = *(u_int *)&sd->dvx1;
      xy2 = *(u_int *)&sd->dvx2;
      puVar27[2] = xy0;
      puVar27[4] = xy1;
      puVar27[6] = xy2;
      puVar27[1] = sd->color;
      if ((uVar13 & 1) != 0) {
        uVar17 = 0x26;
      }
      else {
        uVar17 = 0x24;
      }
      *(u_char *)((int)puVar27 + 7) = uVar17;
      if (((envmap & 2U) == 0) || ((uVar13 & 1) != 0)) {
        pmx = &sd->pmxStart[(u_char)puVar25[1]];
        uVar13 = pmx->tpage;
        *(u_short *)((int)puVar27 + 0xe) = pmx->clut;
        *(u_short *)((int)puVar27 + 0x16) = uVar13;
        uVar13 = puVar25[4];
        uVar8 = puVar25[5];
        *(u_short *)(puVar27 + 3) = puVar25[3];
        *(u_short *)(puVar27 + 5) = uVar13;
        *(u_short *)(puVar27 + 7) = uVar8;
        continue;
      }
      uVar4 = sd->offsetU0;
      uVar6 = sd->offsetV0;
      pmx = &sd->pmxStart[(u_char)puVar25[1]];
      uVar13 = pmx->tpage;
      *(u_short *)((int)puVar27 + 0xe) = pmx->clut;
    }
    *(u_short *)((int)puVar27 + 0x16) = uVar13;
    uVar13 = puVar25[4];
    uVar8 = puVar25[5];
    *(u_char *)(puVar27 + 3) = (char)puVar25[3] + uVar4;
    *(u_char *)(puVar27 + 5) = (char)uVar13 + uVar4;
    *(u_char *)(puVar27 + 7) = (char)uVar8 + uVar4;
    cVar5 = *(char *)((int)puVar25 + 9);
    cVar30 = *(char *)((int)puVar25 + 0xb);
    *(u_char *)((int)puVar27 + 0xd) = *(char *)((int)puVar25 + 7) + uVar6;
    *(u_char *)((int)puVar27 + 0x15) = cVar5 + uVar6;
    *(u_char *)((int)puVar27 + 0x1d) = cVar30 + uVar6;
  }
}

/* ---- DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache  [DRAWC.CPP:3881-3990] SLD-VERIFIED ---- */
void DrawC_PrimHalo(matrixtdef *m,coorddef *t,Transformer_zObj *obj,int type,int index,int reflect,
               Draw_CarCache *sd)

{
  Transformer_zFacet * facet;
  u_short id0;
  short * z;
  short t1;
  int bfct;
  short sVar1;
  short t3;
  short sVar2;
  short *psVar3;
  int overlayFlag;
  short t2;
  int iVar4;
  u_int uVar5;
  u_short id1;
  int iVar6;
  int uVar8;
  u_short id2;
  u_int uVar9;
  short *psVar10;
  int real_type;
  u_long *copyLastPrim;
  u_long *puVar11;
  int i;
  int uVar12;
  COORD16 *vertice;
  int iVar13;

  iVar13 = *(int *)(((int)obj) + 0x10);
  TrsProj_SetTransPrecision(8);
  {
    int r0,r1,r2;
    r0 = m->m[0];
    r1 = m->m[3];
    r2 = m->m[6];
    (sd->matB).m[0][0] = (short)(r0 >> 4);
    (sd->matB).m[0][1] = (short)(r1 >> 4);
    (sd->matB).m[0][2] = (short)(r2 >> 4);
  }
  {
    int r0,r1,r2;
    r0 = m->m[1];
    r1 = m->m[4];
    r2 = m->m[7];
    (sd->matB).m[1][0] = sVar2 = (short)(r0 >> 4);
    (sd->matB).m[1][1] = (short)(r1 >> 4);
    (sd->matB).m[1][2] = (short)(r2 >> 4);
  }
  {
    int r0,r1,r2;
    r0 = m->m[2];
    r1 = m->m[5];
    r2 = m->m[8];
    (sd->matB).m[1][0] = -sVar2;
    sVar2 = (sd->matB).m[1][1];
    (sd->matB).m[2][0] = (short)(r0 >> 4);
    sVar1 = (sd->matB).m[1][2];
    (sd->matB).m[2][1] = (short)(r1 >> 4);
    (sd->matB).m[2][2] = (short)(r2 >> 4);
    (sd->matB).m[1][1] = -sVar2;
    (sd->matB).m[1][2] = -sVar1;
  }
  (sd->matB).t[0] = t->x >> TrsProj_precision;
  (sd->matB).t[1] = -(t->y >> TrsProj_precision);
  (sd->matB).t[2] = t->z >> TrsProj_precision;
  TrsProj_ResetTransPrecision();
  uVar12 = (u_int)*(u_short *)(((int)obj) + 2);
  iVar4 = uVar12 * 0xc;
DrawCHalo_facetLoopTop:
  do {
    uVar8 = uVar12 - 1;
    do {
      do {
        do {
          uVar12 = uVar8;
          iVar4 = iVar4 + -0xc;
          if (uVar12 == -1) {
            return;
          }
          psVar10 = (short *)(*(int *)(((int)obj) + 0x18) + iVar4);
          uVar8 = (u_int)*(u_char *)(psVar10 + 2);
          uVar9 = (u_int)*(u_char *)((int)psVar10 + 5);
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
          {
            short *z; short t1,t2,t3;
            z = (short *)(iVar13 + ((u_int)*(u_char *)((int)psVar10 + 3)) * 6);
            t1 = *z;
            t2 = z[1];
            t3 = z[2];
            (sd->vt0).z = t3;
            (sd->vt0).x = t1;
            (sd->vt0).y = t2;
          }
          {
            short *z; short t1,t2,t3;
            z = (short *)(iVar13 + uVar8 * 6);
            t1 = *z;
            t2 = z[1];
            t3 = z[2];
            (sd->vt1).z = t3;
            (sd->vt1).x = t1;
            (sd->vt1).y = t2;
          }
          {
            short *z; short t1,t2,t3;
            z = (short *)(iVar13 + uVar9 * 6);
            t1 = *z;
            t2 = z[2];
            t3 = z[1];
            (sd->vt2).y = t3;
            (sd->vt2).x = t1;
            (sd->vt2).z = t2;
          }
gte_ldv0((char *)sd + 0xac);
gte_ldv1((char *)sd + 0xb4);
gte_ldv2((char *)sd + 0xbc);
          gte_rtpt();
          gte_nclip();
          gte_stMAC0m(sd->bfct);
          iVar6 = sd->bfct;
          if ((sd->head).mirror != 0) {
            iVar6 = -iVar6;
          }
          uVar8 = uVar12 - 1;
        } while (iVar6 < 1);
        gte_avsz3();
        gte_stOTZm(sd->otz);
        iVar6 = sd->otz + sd->sub_otz;
        sd->otz = iVar6;
        if (iVar6 < 0) goto DrawCHalo_facetLoopTop;
        uVar8 = uVar12 - 1;
      } while (sd->sub_otSize < iVar6);
      uVar9 = ((u_int)type) & 0xffbf;
      if (index < 0) goto DrawCHalo_emitFlare;
      if (*psVar10 < 0) {
        uVar5 = (int)((u_int)(u_short)DrawC_gOverlay[index] << 0x10) >> 0x18;
      }
      else {
        uVar5 = (int)((u_int)(u_short)DrawC_gOverlay[index] << 0x10) >> 0x10 & 0xff;
      }
      if (((((u_int)type) & 0x40) != 0) && ((uVar5 & 0x40) == 0)) {
        if (*psVar10 < 0) {
          uVar5 = (int)((u_int)(u_short)DrawC_gOverlay[0x18] << 0x10) >> 0x18;
        }
        else {
          uVar5 = (int)((u_int)(u_short)DrawC_gOverlay[0x18] << 0x10) >> 0x10 & 0xff;
        }
      }
      uVar8 = uVar12 - 1;
    } while ((uVar5 & 0x81) == 0);
    uVar8 = ((u_int)type) & 0xbf;
    if (((uVar5 & 3) != 1) && ((((u_int)type) & 0x7f00) != 0)) {
      uVar9 = (int)uVar9 >> 8;
DrawCHalo_emitFlare:
      uVar8 = uVar9 & 0xff;
    }
    puVar11 = (sd->head).cprim.LastPrim;
    (sd->head).cprim.LastPrim = sd->sub_ot;
    Flare_CarShapedHalo(uVar8,&sd->vt0,&sd->vt1,&sd->vt2,*psVar10,sd->otz,(Draw_FlareCache *)sd);
    if (((0 < reflect) || ((reflect == -1 && (uVar8 == 5)))) || ((reflect == -2 && (uVar8 != 5)))) {
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
      Flare_CarShapedHalo(uVar9 & 0xff | 0x100,&sd->vt0,&sd->vt1,&sd->vt2,*psVar10,sd->otz,
                 (Draw_FlareCache *)sd);
    }
    (sd->head).cprim.LastPrim = puVar11;
  } while( true );
}

/* ---- DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache  [DRAWC.CPP:3997-4051] SLD-VERIFIED ---- */
void DrawC_ShadowPrim(Draw_tVertex *shadowVT,Draw_CarCache *sd)

{
  POLY_FT4 *prim;
  int iVar1;
  Draw_tPixMap *shadowPmx;

  shadowPmx = gShadowPixmap[0];
  if (R3DCar_InMenu != 0) {
    shadowPmx = gMenuPixmap[1];
  }
  ChangeTPage(&shadowPmx->tpage,2);
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
gte_ldv0(shadowVT);
    gte_rtps();
    prim = (POLY_FT4 *)Render_gPacketPtr;
gte_swc2(0xe,(char *)prim + 0x8);
gte_ldv3((char *)shadowVT + 0x8,(char *)shadowVT + 0x18,(char *)shadowVT + 0x10);
    gte_rtpt();
gte_stsxy3((char *)prim + 0x10,(char *)prim + 0x20,(char *)prim + 0x18);
    gte_avsz4();
    gte_stOTZm(sd->otz);
    iVar1 = (sd->otz >> 1) + 0x28;
    sd->otz = iVar1;
    if ((-1 < iVar1) && (iVar1 <= Draw_gViewOtSize + -3)) {
      u_long *ot;
      {
      u_long l0;
      u_long l1;
      u_long l2;
      u_long l3;
      prim = (POLY_FT4 *)(sd->head).cprim.PrimPtr;
      ot = (sd->head).cprim.LastPrim;
      (sd->head).cprim.PrimPtr = (char *)prim + 0x28;
      l0 = *(u_long *)prim & 0xff000000 | ot[iVar1] & 0xffffff;
      ot[iVar1] = ot[iVar1] & 0xff000000 | (u_long)prim & 0xffffff;
      *(u_long *)prim = l0;
      l1 = sd->color;
      *(u_char *)((char *)prim + 3) = 9;
      *(u_long *)&prim->r0 = l1;
      *(u_char *)((char *)prim + 7) = 0x2e;
      l1 = *(u_long *)&shadowPmx->u1;
      l2 = *(u_long *)&shadowPmx->u2;
      l3 = *(u_long *)&shadowPmx->u3;
      *(u_long *)&prim->u0 = *(u_long *)shadowPmx;
      *(u_long *)&prim->u1 = l1;
      *(u_long *)&prim->u2 = l2;
      *(u_long *)&prim->u3 = l3;
      }
    }
  }
  return;
}

/* ---- DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache  [DRAWC.CPP:4056-4114] SLD-VERIFIED ---- */
void DrawC_DivideShadowPrim(COORD16 *vt0,COORD16 *vt1,COORD16 *vt2,COORD16 *vt3,u_short *u0,u_short *u1,u_short *u2
               ,u_short *u3,Draw_tPixMap *pmx,Draw_CarCache *sd)

{
  void *tp8;
  u_int mlo;      /* 0x00FFFFFF addr mask (oracle: $a1) */
  u_int mhi;      /* 0xFF000000 len mask  (oracle: $a2) */
  POLY_FT4 * prim;
  u_long * ot;
  u_short uv2;
  u_short uv3;
  u_short uVar1;
  u_short uVar2;
  u_short uVar3;
  u_short clut;
  u_short tpage;
  int iVar4;
  u_int uVar5;
  u_short uv1;
  u_short uv0;
  u_long *puVar6;
  u_int *puVar7;
  u_int *puVar8;

  if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
gte_ldv0(vt0);
    gte_rtps();
    /* scratchpad SXY staging = EA-expander template block (scratches $t0/$v0/$v1/$a0 --
     * the reason vt0 is copied out of $a0 up-front). Two asm halves share the packet
     * cursor via tp8; low-reg clobbers steer the cursor into $t0 like retail. */
    __asm__ volatile(
        "lui	%0,0x1f80
	lw	%0,4(%0)
	addiu	$v0,%0,8
	swc2	$14,0($v0)"
        : "=&r"(tp8) : : "$2", "$3", "$4", "memory");
gte_ldv3(vt1,vt2,vt3);
    gte_rtpt();
    __asm__ volatile(
        "addiu	$a0,%0,16
	addiu	$v1,%0,32
	addiu	$v0,%0,24
	"
        "swc2	$12,0($a0)
	swc2	$13,0($v1)
	swc2	$14,0($v0)"
        : : "r"(tp8) : "$2", "$3", "$4", "memory");
    if (R3DCar_InMenu != 0) {                /* fall-through arm = InMenu (oracle beqz jumps to avsz4) */
      sd->otz = 0;
    }
    else {
      gte_avsz4();
      gte_stOTZm(sd->otz);
      iVar4 = (sd->otz >> 3) + 0x28;
      sd->otz = iVar4;
      if (iVar4 < 0) {
        return;
      }
      if (Draw_gViewOtSize + -3 < iVar4) {
        return;
      }
    }
    if ((((-1 < *(short *)(((int)vt0) + 4)) || (-1 < vt1->z)) || (-1 < vt2->z)) || (-1 < vt3->z)) {
      mlo = 0xffffff;                          /* masks FIRST (oracle: a1/a2 hoisted before the loads,
                                                * first lui even sits in the z-chain delay slot) */
      mhi = 0xff000000;
      puVar8 = (u_int *)(sd->head).cprim.PrimPtr;
      puVar6 = (sd->head).cprim.LastPrim;
      (sd->head).cprim.PrimPtr = (char *)(puVar8 + 10);
      /* volatile: the oracle reloads sd->otz fresh here (stored just above) */
      puVar7 = (u_int *)(puVar6 + *(int volatile *)&sd->otz);
      *puVar8 = *puVar8 & mhi | *puVar7 & mlo;
      *puVar7 = *puVar7 & mhi | (u_int)puVar8 & mlo;
      uVar5 = sd->color;
      *(u_char *)((int)puVar8 + 3) = 9;
      puVar8[1] = uVar5;
      *(u_char *)((int)puVar8 + 7) = 0x2e;
      uVar1 = pmx->tpage;
      *(u_short *)((int)puVar8 + 0xe) = pmx->clut;
      *(u_short *)((int)puVar8 + 0x16) = uVar1;
      uv0 = *u0;                    /* oracle load order: u0, u1, u3, u2 */
      uv1 = *u1;
      uv3 = *u3;
      uv2 = *u2;
      *(u_short *)(puVar8 + 3) = uv0;
      *(u_short *)(puVar8 + 5) = uv1;
      *(u_short *)(puVar8 + 7) = uv3;    /* EA swap: prim u2 slot <- *u3 */
      *(u_short *)(puVar8 + 9) = uv2;

    }
  }
  return;
}

/* ---- DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache  [DRAWC.CPP:4117-4184] SLD-VERIFIED ---- */
void DrawC_ShadowPrimClip(Draw_tVertex *shadowVT,Draw_CarCache *sd)

{
  short t3;
  short * z;
  short sVar1;
  short sVar2;
  short sVar3;
  short sVar4;
  short sVar5;
  u_short uv0;
  u_short uv1;
  short t2;
  short t1;
  u_short uv2;
  u_short uv3;
  u_char *u2;
  COORD16 *vt2;
  Draw_tPixMap *shadowPmx;
  Draw_tPixMap *pmx;
  
  pmx = gShadowPixmap[0];
  if (R3DCar_InMenu != 0) {
    pmx = gMenuPixmap[1];
  }
  ChangeTPage(&pmx->tpage,2);
gte_SetRotMatrix(&DrawC_gScreenMat);
gte_SetTransMatrix(&DrawC_gScreenMat);
  vt2 = &sd->vt8;
  sVar1 = (shadowVT->sv).y;
  sVar2 = (shadowVT->sv).z;
  (sd->vt0).x = (shadowVT->sv).x;
  (sd->vt0).y = sVar1;
  (sd->vt0).z = sVar2;
  sVar1 = shadowVT[1].sv.x;
  sVar2 = shadowVT[1].sv.y;
  (sd->vt1).z = shadowVT[1].sv.z;
  (sd->vt1).x = sVar1;
  (sd->vt1).y = sVar2;
  sVar1 = shadowVT[3].sv.y;
  sVar2 = shadowVT[3].sv.z;
  (sd->vt2).x = shadowVT[3].sv.x;
  (sd->vt2).y = sVar1;
  (sd->vt2).z = sVar2;
  sVar1 = shadowVT[2].sv.x;
  sVar2 = shadowVT[2].sv.y;
  sVar3 = shadowVT[2].sv.z;
  (sd->vt0).x = (sd->vt0).x << 2;
  sVar4 = (sd->vt0).y;
  (sd->vt0).z = (sd->vt0).z << 2;
  sVar5 = (sd->vt1).y;
  u2 = &sd->offsetU2;
  (sd->vt3).x = sVar1;
  (sd->vt3).y = sVar2;
  (sd->vt3).z = sVar3;
  (sd->vt0).y = sVar4 << 2;
  (sd->vt1).x = (sd->vt1).x << 2;
  (sd->vt1).y = sVar5 << 2;
  sVar4 = (sd->vt2).x;
  (sd->vt1).z = (sd->vt1).z << 2;
  (sd->vt2).x = sVar4 << 2;
  (sd->vt2).y = (sd->vt2).y << 2;
  (sd->vt2).z = (sd->vt2).z << 2;
  (sd->vt3).y = sVar2 << 2;
  (sd->vt3).x = sVar1 << 2;
  sVar1 = (sd->vt0).x;
  sVar2 = (sd->vt1).x;
  (sd->vt3).z = sVar3 << 2;
  sVar3 = (sd->vt0).y;
  sVar4 = (sd->vt1).y;
  (sd->vt4).x = (short)((int)sVar1 + (int)sVar2 + 1 >> 1);
  sVar1 = (sd->vt0).z;
  sVar2 = (sd->vt1).z;
  (sd->vt4).y = (short)((int)sVar3 + (int)sVar4 + 1 >> 1);
  sVar3 = (sd->vt1).x;
  sVar4 = (sd->vt2).x;
  (sd->vt4).z = (short)((int)sVar1 + (int)sVar2 + 1 >> 1);
  sVar1 = (sd->vt1).y;
  sVar2 = (sd->vt2).y;
  (sd->vt5).x = (short)((int)sVar3 + (int)sVar4 + 1 >> 1);
  sVar3 = (sd->vt1).z;
  sVar4 = (sd->vt2).z;
  (sd->vt5).y = (short)((int)sVar1 + (int)sVar2 + 1 >> 1);
  sVar1 = (sd->vt2).x;
  sVar2 = (sd->vt3).x;
  (sd->vt5).z = (short)((int)sVar3 + (int)sVar4 + 1 >> 1);
  (sd->vt6).x = (short)((int)sVar1 + (int)sVar2 + 1 >> 1);
  sVar1 = (sd->vt3).z;
  sVar2 = (sd->vt2).z;
  (sd->vt6).y = (short)((int)(sd->vt2).y + (int)(sd->vt3).y + 1 >> 1);
  sVar3 = (sd->vt3).x;
  sVar4 = (sd->vt0).x;
  (sd->vt6).z = (short)((int)sVar2 + (int)sVar1 + 1 >> 1);
  sVar1 = (sd->vt3).y;
  sVar2 = (sd->vt0).y;
  (sd->vt7).x = (short)((int)sVar3 + (int)sVar4 + 1 >> 1);
  sVar3 = (sd->vt3).z;
  sVar4 = (sd->vt0).z;
  (sd->vt7).y = (short)((int)sVar1 + (int)sVar2 + 1 >> 1);
  sVar1 = (sd->vt0).x;
  sVar2 = (sd->vt2).x;
  (sd->vt7).z = (short)((int)sVar3 + (int)sVar4 + 1 >> 1);
  sVar3 = (sd->vt2).y;
  sVar4 = (sd->vt0).y;
  (sd->vt8).x = (short)((int)sVar1 + (int)sVar2 + 1 >> 1);
  sVar1 = (sd->vt2).z;
  sVar2 = (sd->vt0).z;
  (sd->vt8).y = (short)((int)sVar4 + (int)sVar3 + 1 >> 1);
  (sd->vt8).z = (short)((int)sVar2 + (int)sVar1 + 1 >> 1);
  uv0 = *(u_short *)&pmx->u0;
  uv1 = *(u_short *)&pmx->u1;
  uv3 = *(u_short *)&pmx->u3;
  uv2 = *(u_short *)&pmx->u2;
  *(u_short *)&sd->u0 = uv0;
  *(u_short *)&sd->u1 = uv1;
  *(u_short *)&sd->u2 = uv3;
  *(u_short *)&sd->u3 = uv2;
  sd->u4 = (u_char)((int)((u_int)sd->u0 + (u_int)sd->u1 + 1) >> 1);
  sd->v4 = (u_char)((int)((u_int)sd->v0 + (u_int)sd->v1 + 1) >> 1);
  sd->u5 = (u_char)((int)((u_int)sd->u1 + (u_int)sd->u2 + 1) >> 1);
  sd->v5 = (u_char)((int)((u_int)sd->v1 + (u_int)sd->v2 + 1) >> 1);
  sd->offsetU0 = (u_char)((int)((u_int)sd->u2 + (u_int)sd->u3 + 1) >> 1);
  sd->offsetV0 = (u_char)((int)((u_int)sd->v2 + (u_int)sd->v3 + 1) >> 1);
  sd->offsetU1 = (u_char)((int)((u_int)sd->u3 + (u_int)sd->u0 + 1) >> 1);
  sd->offsetV1 = (u_char)((int)((u_int)sd->v3 + (u_int)sd->v0 + 1) >> 1);
  sd->offsetU2 = (u_char)((int)((u_int)sd->u0 + (u_int)sd->u2 + 1) >> 1);
  sd->offsetV2 = (u_char)((int)((u_int)sd->v0 + (u_int)sd->v2 + 1) >> 1);
  DrawC_DivideShadowPrim(&sd->vt0,&sd->vt4,vt2,&sd->vt7,(u_short *)&sd->u0,(u_short *)&sd->u4,(u_short *)u2,
             (u_short *)&sd->offsetU1,pmx,sd);
  DrawC_DivideShadowPrim(&sd->vt4,&sd->vt1,&sd->vt5,vt2,(u_short *)&sd->u4,(u_short *)&sd->u1,(u_short *)&sd->u5,
             (u_short *)u2,pmx,sd);
  DrawC_DivideShadowPrim(&sd->vt7,vt2,&sd->vt6,&sd->vt3,(u_short *)&sd->offsetU1,(u_short *)u2,
             (u_short *)&sd->offsetU0,(u_short *)&sd->u3,pmx,sd);
  DrawC_DivideShadowPrim(&sd->vt8,&sd->vt5,&sd->vt2,&sd->vt6,(u_short *)u2,(u_short *)&sd->u5,(u_short *)&sd->u2,
             (u_short *)&sd->offsetU0,pmx,sd);
  return;
}

/* ---- DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache  [DRAWC.CPP:4189-4254] SLD-VERIFIED ---- */
void DrawC_SpotPrims(matrixtdef *m,coorddef *t,Draw_CarCache *sd)

{
  int i;

  TrsProj_SetTransPrecision(8);
  {
    int r0 = m->m[0];
    int r1 = m->m[3];
    int r2 = m->m[6];
    (sd->matB).m[0][0] = (short)(r0 >> 4);
    (sd->matB).m[0][1] = (short)(r1 >> 4);
    (sd->matB).m[0][2] = (short)(r2 >> 4);
  }
  {
    int r0 = m->m[1];
    int r1 = m->m[4];
    int r2 = m->m[7];
    (sd->matB).m[1][0] = (short)(r0 >> 4);
    (sd->matB).m[1][1] = (short)(r1 >> 4);
    (sd->matB).m[1][2] = (short)(r2 >> 4);
  }
  {
    int r0 = m->m[2];
    int r1 = m->m[5];
    int r2 = m->m[8];
    (sd->matB).m[1][0] = -(sd->matB).m[1][0];
    (sd->matB).m[2][0] = (short)(r0 >> 4);
    (sd->matB).m[2][1] = (short)(r1 >> 4);
    (sd->matB).m[2][2] = (short)(r2 >> 4);
    (sd->matB).m[1][1] = -(sd->matB).m[1][1];
    (sd->matB).m[1][2] = -(sd->matB).m[1][2];
  }
  (sd->matB).t[0] = t->x >> TrsProj_precision;
  (sd->matB).t[1] = -(t->y >> TrsProj_precision);
  (sd->matB).t[2] = t->z >> TrsProj_precision;
  TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
  {
    DR_MODE *pDVar7;
    u_long *ot;
    pDVar7 = (DR_MODE *)(sd->head).cprim.PrimPtr;
    ot = (sd->head).cprim.LastPrim;
    sd->otz = 0;
    (sd->head).cprim.PrimPtr = (char *)(pDVar7 + 1);
    {
      u_int *puVar8 = (u_int *)(ot + sd->otz);
      pDVar7->tag = (u_long *)((u_int)pDVar7->tag & 0xff000000 | *puVar8 & 0xffffff);
      *puVar8 = *puVar8 & 0xff000000 | (u_int)pDVar7 & 0xffffff;
    }
    SetDrawMode(pDVar7,0,0,0x120,(RECT *)0x0);
  }
  {
    short *z = (short *)&Fe3D_spotVertex[0x20];
    short t1 = z[0];
    short t2 = z[1];
    short t3 = z[2];
    (sd->vt0).x = t1;
    (sd->vt0).y = t2;
    (sd->vt0).z = t3;
  }
  {
    COORD16 *pCVar13;
    COORD16 *pCVar14;
    i = 0;
    pCVar13 = Fe3D_spotVertex;
    pCVar14 = pCVar13;
    while (1) {
      int iPlus = i + 1;
      if (0x20 <= i) break;
      if (iPlus == 0x20) {
        iPlus = 0;
      }
      if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
        {
          short t1 = pCVar13->x;
          short t2 = pCVar13->y;
          short t3 = pCVar13->z;
          (sd->vt1).x = t1;
          (sd->vt1).y = t2;
          (sd->vt1).z = t3;
        }
        {
          COORD16 *z = pCVar14 + iPlus;
          short t1 = z->x;
          short t2 = z->y;
          short t3 = z->z;
          (sd->vt2).x = t1;
          (sd->vt2).y = t2;
          (sd->vt2).z = t3;
        }
        gte_ldv3(&sd->vt0,&sd->vt1,&sd->vt2);
        gte_rtpt();
        {
          u_int *puVar9 = (u_int *)(sd->head).cprim.PrimPtr;
          (sd->head).cprim.PrimPtr = (char *)(puVar9 + 7);
          {
            u_long *ot = (u_long *)((sd->head).cprim.LastPrim + sd->otz);
            *puVar9 = *puVar9 & 0xff000000 | *ot & 0xffffff;
            *ot = *ot & 0xff000000 | (u_int)puVar9 & 0xffffff;
          }
          gte_stsxy3_g3(puVar9);
          {
            u_int color = sd->color;
            *(u_char *)((int)puVar9 + 3) = 6;
            puVar9[3] = 0;
            puVar9[5] = 0;
            puVar9[1] = color;
            *(u_char *)((int)puVar9 + 7) = 0x32;
          }
        }
      }
      pCVar13 = pCVar13 + 1;
      i = i + 1;
    }
  }
  {
    DR_MODE *pDVar7 = (DR_MODE *)(sd->head).cprim.PrimPtr;
    u_long *ot = (sd->head).cprim.LastPrim;
    (sd->head).cprim.PrimPtr = (char *)(pDVar7 + 1);
    {
      u_int *puVar8 = (u_int *)(ot + sd->otz);
      pDVar7->tag = (u_long *)((u_int)pDVar7->tag & 0xff000000 | *puVar8 & 0xffffff);
      *puVar8 = *puVar8 & 0xff000000 | (u_int)pDVar7 & 0xffffff;
    }
    SetDrawMode(pDVar7,0,1,0x120,(RECT *)0x0);
  }
  return;
}

/* ---- DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache  [DRAWC.CPP:4260-4378] SLD-VERIFIED ---- */
void DrawC_ShowroomPrims(matrixtdef *m,coorddef *t,Draw_CarCache *sd)

{
  int i;
  int j;
  char hilight_state [32];
  int hilight [2];
  int hilight_direction [2];
  int index;
  POLY_FT4 *prim;
  Draw_tPixMap *lightPmx;

  lightPmx = gMenuPixmap[3];
  if (gShowroomLights != 0) {
    int iVar4;
    int iVar5;
    char *pcVar6;
    COORD16 *pCVar7;
    u_int uVar8;
    int iVar11;
    u_long *puVar18;
    char *pcVar15;

    iVar4 = gettick();
    iVar5 = iVar4 / 256;
    hilight[0] = (iVar4 - (iVar5 << 8)) >> 3;
    hilight_direction[0] = -1;
    if (DrawC_gMenuLightsDirection == 0) {
      hilight[1] = hilight[0] + 0x10U & 0x1f;
      hilight_direction[1] = -1;
    }
    else {
      hilight[1] = 0x20 - hilight[0];
      hilight_direction[1] = 1;
    }
    iVar5 = 0x1f;
    pcVar6 = hilight_state + 0x1f;
    do {
      *pcVar6 = -1;
      iVar5 = iVar5 + -1;
      pcVar6 = pcVar6 + -1;
    } while (-1 < iVar5);
    j = 0;
    {
      int *piVar14 = hilight_direction;
      int *prim2 = hilight;
      do {
        i = 0;
        do {
          if ((signed char)hilight_state[*prim2 + i * *piVar14 & 0x1f] < i) {
            hilight_state[*prim2 + i * *piVar14 & 0x1f] = (char)i;
          }
          i = i + 1;
        } while (i < 5);
        piVar14 = piVar14 + 1;
        j = j + 1;
        prim2 = prim2 + 1;
      } while (j < 2);
    }
    ChangeTPage(&lightPmx->tpage,1);
    TrsProj_SetTransPrecision(8);
    {
      int r0 = m->m[0];
      int r1 = m->m[3];
      int r2 = m->m[6];
      (sd->matB).m[0][0] = (short)(r0 >> 4);
      (sd->matB).m[0][1] = (short)(r1 >> 4);
      (sd->matB).m[0][2] = (short)(r2 >> 4);
    }
    {
      int r0 = m->m[1];
      int r1 = m->m[4];
      int r2 = m->m[7];
      (sd->matB).m[1][0] = (short)(r0 >> 4);
      (sd->matB).m[1][1] = (short)(r1 >> 4);
      (sd->matB).m[1][2] = (short)(r2 >> 4);
    }
    {
      int r0 = m->m[2];
      int r1 = m->m[5];
      int r2 = m->m[8];
      (sd->matB).m[1][0] = -(sd->matB).m[1][0];
      (sd->matB).m[2][0] = (short)(r0 >> 4);
      (sd->matB).m[2][1] = (short)(r1 >> 4);
      (sd->matB).m[2][2] = (short)(r2 >> 4);
      (sd->matB).m[1][1] = -(sd->matB).m[1][1];
      (sd->matB).m[1][2] = -(sd->matB).m[1][2];
    }
    (sd->matB).t[0] = t->x >> TrsProj_precision;
    (sd->matB).t[1] = -(t->y >> TrsProj_precision);
    (sd->matB).t[2] = t->z >> TrsProj_precision;
    TrsProj_ResetTransPrecision();
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
    pcVar6 = hilight_state;
    sd->otz = 0;
    for (index = 0; index < 0x20; index = index + 1) {
      int iPlus = index * 2 + 2;
      if (iPlus == 0x40) {
        iPlus = 0;
      }
      iVar11 = 0;
      if ((sd->head).cprim.MPrimPtr <= (sd->head).cprim.PrimPtr) {
        return;
      }
      {
        short t1 = Fe3D_lightsVertex[index * 2].x;
        short t2 = Fe3D_lightsVertex[index * 2].y;
        short t3 = Fe3D_lightsVertex[index * 2].z;
        (sd->vt0).x = t1;
        (sd->vt0).y = t2;
        (sd->vt0).z = t3;
      }
      pCVar7 = Fe3D_lightsVertex + iPlus;
      {
        short t1 = pCVar7->x;
        short t2 = pCVar7->y;
        short t3 = pCVar7->z;
        (sd->vt1).x = t1;
        (sd->vt1).y = t2;
        (sd->vt1).z = t3;
      }
      pcVar15 = pcVar6 + index;
      {
        short t2 = Fe3D_lightsVertex[index * 2 + 1].y;
        short t3 = Fe3D_lightsVertex[index * 2 + 1].z;
        short t1 = Fe3D_lightsVertex[index * 2 + 1].x;
        (sd->vt2).x = t1;
        (sd->vt2).y = t2;
        (sd->vt2).z = t3;
      }
      {
        COORD16 *z = &Fe3D_lightsVertex[iPlus + 1];
        short t1 = z->x;
        short t2 = z->y;
        short t3 = z->z;
        (sd->vt3).x = t1;
        (sd->vt3).y = t2;
        (sd->vt3).z = t3;
      }
      puVar18 = hilight_colors;
      for (; iVar11 < 2; iVar11 = iVar11 + 1) {
        if ((iVar11 == 0) || (-1 < (signed char)*pcVar15)) {
gte_ldv0((char *)sd + 0xac);
          gte_rtps();
          prim = (POLY_FT4 *)(sd->head).cprim.PrimPtr;
          (sd->head).cprim.PrimPtr = (char *)(prim + 1);
          {
            u_long *ot = (u_long *)((sd->head).cprim.LastPrim + sd->otz);
            prim->tag = prim->tag & 0xff000000 | *ot & 0xffffff;
            *ot = *ot & 0xff000000 | (u_int)prim & 0xffffff;
          }
gte_swc2(0xe,(char *)prim + 0x8);
gte_ldv3((char *)sd + 0xb4,(char *)sd + 0x3d0,(char *)sd + 0xbc);
          gte_rtpt();
gte_stsxy3((char *)prim + 0x10,(char *)prim + 0x20,(char *)prim + 0x18);
          if (iVar11 == 0) {
            uVar8 = 0x300a00;
          }
          else {
            uVar8 = puVar18[(signed char)*pcVar15];
          }
          *(u_int *)&prim->r0 = uVar8;
          prim->code = 0x2e;
          *(u_char *)((int)prim + 3) = 9;
          {
            u_long l0 = *(u_int *)lightPmx;
            u_long l1 = *(u_int *)&lightPmx->u1;
            u_long l2 = *(u_int *)&lightPmx->u2;
            u_long l3 = *(u_int *)&lightPmx->u3;
            *(u_int *)&prim->u0 = l0;
            *(u_int *)&prim->u1 = l1;
            *(u_int *)&prim->u2 = l2;
            *(u_int *)&prim->u3 = l3;
          }
        }
      }
    }
  }
  return;
}

/* end of draww.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
char SP[64];  /* FIXME size approx */
