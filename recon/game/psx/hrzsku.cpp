/* game/psx/hrzsku.cpp -- RECONSTRUCTED (NFS4 PSX in-race HUD; C++ TU)
 *   62 fns: sprite/poly builders, tachometer, number rasterizer, mini-map + radar,
 *   CD player, wingman interface, render views (hud/tac/map/stats), 3-2-1-GO, BTC/busted.
 *   Reconstructed with full SYM-locals applied (audited).
 */
#include "../../nfs4_types.h"
#include "hrzsku_externs.h"

/* ---- link-harness owned-global definition (extern-declared, never defined) ---- */
int Hrz_gProjResultZ0; int Hrz_gProjScratch_9C;  /* HrzSku.obj-owned projection scratch (BSS) */

/* ---- HrzSku.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
Draw_tPixMap *gHorizonPixmap[16];   /* @0x801202f8  (bss(zero)) */
Draw_tPixMap gHorizonExtraSkyPixmaps[4];   /* @0x80120338  (bss(zero)) */
SVECTOR      gSkyMesh[85];   /* @0x80120378  (bss(zero)) */
CVECTOR      gSkyColor[85];   /* @0x80120620  (bss(zero)) */
char         gSkyPixmapIndex[64];   /* @0x80120774  (bss(zero)) */
Draw_tPixMap *gpPmx[16];   /* @0x801207b4  (bss(zero)) */
CVECTOR      gHrzRingColor[2][17];   /* @0x801207f4  (bss(zero)) */
int          gfxPmxHeightPercentage[16];   /* @0x8012087c  (bss(zero)) */
tHrz_Lightning gHrz_Lightning;   /* @0x801208bc  (bss(zero)) */
SVECTOR      *starPosInSky;   /* @0x8013d878  (bss(zero)) */
CVECTOR      *starColors;   /* @0x8013d87c  (bss(zero)) */
CHorizonSpec *Hrz_gTrackSpec;   /* @0x8013d888  (bss(zero)) */
CSkySpec     *Sky_gTrackSpec;   /* @0x8013d88c  (bss(zero)) */
SVECTOR      *gRngCoordTop;   /* @0x8013d890  (bss(zero)) */
SVECTOR      Hrz_gLightningPosInSky;   /* @0x8013d894  (bss(zero)) */
SVECTOR      sunPosInSky;   /* @0x8013ddf0  (bss(zero)) */
SVECTOR      moonPosInSky;   /* @0x8013ddf8  (bss(zero)) */
CVECTOR      Hrz_gSaveCol[4];   /* @0x8013e380  (bss?) */
/* hrzsku-internal lost-symbol globals (NOT in SYM Globals; 4 contiguous ints, sky double-buffer
   vertex counts, accessed via (&A0)[i]). DEFINED here for self-containment (was extern-only). */
int Hrz_gSkyVtx_A0, Hrz_gSkyVtx_A1, Hrz_gSkyVtx_B0, Hrz_gSkyVtx_B1;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Horizon_InterpolateLineSCoords(DVECTOR *sc,DVECTOR *s0,DVECTOR *s1,int *percentage,int n,int bPercentageArray);
void Sky_InitStars(void);
void Sky_KillStars(void);
void Hrz_InitSkyColor(void);
void Hrz_InitSky(void);
void Hrz_Init2DRing(void);
void Hrz_GetHorizonPixMap(Draw_tPixMap *p);
void Hrz_InitHorizon(void);
void Hrz_KillHorizon(void);
void Hrz_LightningAddFork(char direction,char column,char row);
void Hrz_CalculateLightning(void);
void Hrz_TextureQuad(DVECTOR *pt,char type,char bright,Draw_DCache *sd);
void Hrz_SetLightingPosInSky(DRender_tView *Vi);
void Hrz_BuildForkLightning(Draw_DCache *sd);
void Hrz_LightningFlicker(int on);
void HrzSetPsxMatrix(matrixtdef *m);
void HrzSetPsxTranslation(coorddef *t);
void Hrz_RotProj16(int n, SVECTOR *s, int *z, DVECTOR *p);
void Hrz_SetDitheringPrim(int dither,int otz);
void Hrz_BuildSky(void);
void Sky_RenderStars(Draw_SkyCache *sd,int otz);
void Hrz_BuildHorizon(DRender_tView *Vi);


/* ---- Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii  [HRZSKU.CPP:128-156] SLD-VERIFIED ---- */
void Horizon_InterpolateLineSCoords(DVECTOR *sc,DVECTOR *s0,DVECTOR *s1,int *percentage,int n,int bPercentageArray)

{
  int iVar1;
  int iVar2;
  short *pScOut;
  int p;
  int i;
  int iVar3;
  
  pScOut = (short *)sc;
  if (bPercentageArray == 0) {
    iVar3 = *percentage;
    iVar1 = 0;
    if (0 < n) {
      do {
        iVar2 = iVar3 * ((int)s1->vx - (int)s0->vx);
        if (iVar2 < 0) {
          iVar2 = iVar2 + 0xffff;
        }
        *pScOut = s0->vx + (short)((u_int)iVar2 >> 0x10);
        iVar2 = iVar3 * ((int)s1->vy - (int)s0->vy);
        if (iVar2 < 0) {
          iVar2 = iVar2 + 0xffff;
        }
        pScOut[1] = s0->vy + (short)((u_int)iVar2 >> 0x10);
        s0 = s0 + 1;
        s1 = s1 + 1;
        iVar1 = iVar1 + 1;
        pScOut = pScOut + 2;
      } while (iVar1 < n);
      return;
    }
  }
  else {
    iVar3 = 0;
    if (0 < n) {
      do {
        iVar1 = *percentage * ((int)s1->vx - (int)s0->vx);
        if (iVar1 < 0) {
          iVar1 = iVar1 + 0xffff;
        }
        *pScOut = s0->vx + (short)((u_int)iVar1 >> 0x10);
        iVar1 = *percentage * ((int)s1->vy - (int)s0->vy);
        if (iVar1 < 0) {
          iVar1 = iVar1 + 0xffff;
        }
        pScOut[1] = s0->vy + (short)((u_int)iVar1 >> 0x10);
        percentage = percentage + 1;
        s0 = s0 + 1;
        s1 = s1 + 1;
        iVar3 = iVar3 + 1;
        pScOut = pScOut + 2;
      } while (iVar3 < n);
    }
  }
  return;
}

/* ---- Sky_InitStars__Fv  [HRZSKU.CPP:185-211] SLD-VERIFIED ---- */
void Sky_InitStars(void)

{
  int seed;
  u_int uVar1;
  u_int uVar2;
  int iVar3;
  int iVar4;
  u_int uVar5;
  SVECTOR *pSVar6;
  int starBright;
  int heightAngle;
  int iVar7;
  int radius;
  int height;
  int latAngle;
  int i;
  int iVar8;
  long oldSeed;
  
  if (starPosInSky == (SVECTOR *)0x0) {
    seed = random();
    seedrandom(Sky_gTrackSpec->starRandomSeed);
    starPosInSky = reservememadr("stars",Sky_gTrackSpec->numStars << 3,0);
    starColors = reservememadr("starCols",Sky_gTrackSpec->numStars << 2,0);
    for (iVar8 = 0; iVar8 < Sky_gTrackSpec->numStars; iVar8 = iVar8 + 1) {
      uVar1 = random();
      uVar2 = random();
      uVar5 = Sky_gTrackSpec->starAngleHigh - Sky_gTrackSpec->starAngleLow;
      if (uVar5 == 0) {
        trap(0x1c00);
      }
      iVar7 = Sky_gTrackSpec->starAngleLow + uVar2 % uVar5;
      iVar3 = fixedsin(iVar7);
      iVar3 = fixedmult(iVar3,1000);
      iVar7 = fixedcos(iVar7);
      iVar7 = fixedmult(iVar7,1000);
      iVar4 = fixedsin(uVar1 & 0xffff);
      iVar4 = fixedmult(iVar4,iVar7);
      pSVar6 = starPosInSky + iVar8;
      pSVar6->vx = (short)iVar4;
      pSVar6->vy = (short)iVar3;
      iVar3 = fixedcos(uVar1 & 0xffff);
      iVar3 = fixedmult(iVar3,iVar7);
      starPosInSky[iVar8].vz = (short)iVar3;
      uVar1 = random();
      uVar2 = Sky_gTrackSpec->starBrightMax - Sky_gTrackSpec->starBrightMin;
      if (uVar2 == 0) {
        trap(0x1c00);
      }
      uVar1 = Sky_gTrackSpec->starBrightMin + uVar1 % uVar2;
      (*(u_long *)&starColors[iVar8]) = uVar1 * 0x10000 | uVar1 * 0x100 | uVar1;
    }
    seedrandom(seed);
  }
  return;
}

/* ---- Sky_KillStars__Fv  [HRZSKU.CPP:216-222] SLD-VERIFIED ---- */
void Sky_KillStars(void)

{
  if (starPosInSky != (SVECTOR *)0x0) {
    purgememadr(starPosInSky);
  }
  if (starColors != (u_long *)0x0) {
    purgememadr(starColors);
  }
  starPosInSky = (SVECTOR *)0x0;
  starColors = (CVECTOR *)0x0;
  return;
}

/* ---- Hrz_InitSkyColor__Fv  [HRZSKU.CPP:227-252] SLD-VERIFIED ---- */
void Hrz_InitSkyColor(void)
{
  int i, j, k, l;
  CVECTOR rounddiff, cur_bk, cur_fr;
  CVECTOR *pCVar9;

  k = 0;
  for (i = 0; i < 5; i++) {
    cur_bk = Sky_gTrackSpec->backcolors[i];
    cur_fr = Sky_gTrackSpec->frontcolors[i];
    j = cur_bk.r - cur_fr.r;  if (j < 0) j = j + 7;  rounddiff.r = (u_char)(j >> 3);
    j = cur_bk.g - cur_fr.g;  if (j < 0) j = j + 7;  rounddiff.g = (u_char)(j >> 3);
    j = cur_bk.b - cur_fr.b;  if (j < 0) j = j + 7;  rounddiff.b = (u_char)(j >> 3);
    pCVar9 = gSkyColor + k;
    for (l = 0; l < 0x11; l++) {
      j = l;
      if (8 < l) j = 0x10 - l;
      pCVar9->r = cur_fr.r + (char)rounddiff.r * (char)j;
      pCVar9->g = cur_fr.g + (char)rounddiff.g * (char)j;
      pCVar9->b = cur_fr.b + (char)rounddiff.b * (char)j;
      pCVar9 = pCVar9 + 1;
      k = k + 1;
    }
  }
}

/* ---- Hrz_InitSky__Fv  [HRZSKU.CPP:257-332] SLD-VERIFIED ---- */
void Hrz_InitSky(void)

{
  CSkySpec *pCVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int angle;
  int iVar5;
  int angle_00;
  int j;
  int iVar6;
  SVECTOR *pSVar7;
  int i;
  int iVar8;
  int height;
  int radius;
  int k;
  
  iVar2 = fixedcos(Sky_gTrackSpec->sunAngleInSky);
  iVar2 = fixedmult(iVar2,1000);
  sunPosInSky.vx = (short)iVar2;
  iVar2 = fixedsin(Sky_gTrackSpec->sunAngleInSky);
  iVar2 = fixedmult(iVar2,1000);
  sunPosInSky.vz = (short)iVar2;
  sunPosInSky.vy =
       (short)TrackSpec_gSpec.skyspec.sunHeightInSky + (short)TrackSpec_gSpec.skyspec.yoffset;
  iVar2 = fixedcos(Sky_gTrackSpec->moonAngleInSky);
  iVar2 = fixedmult(iVar2,1000);
  moonPosInSky.vx = (short)iVar2;
  iVar2 = fixedsin(Sky_gTrackSpec->moonAngleInSky);
  iVar2 = fixedmult(iVar2,1000);
  moonPosInSky.vz = (short)iVar2;
  moonPosInSky.vy =
       (short)TrackSpec_gSpec.skyspec.moonHeightInSky + (short)TrackSpec_gSpec.skyspec.yoffset;
  iVar2 = Draw_gPlayer1View;
  if (GameSetup_gData.commMode == 1) {
    Draw_SetViewColor(Draw_gPlayer1View,(u_int)(Sky_gTrackSpec->clearcolor).r,
               (u_int)(Sky_gTrackSpec->clearcolor).g,(u_int)(Sky_gTrackSpec->clearcolor).b);
    iVar2 = Draw_gPlayer2View;
  }
  iVar8 = 0;
  Draw_SetViewColor(iVar2,(u_int)(Sky_gTrackSpec->clearcolor).r,(u_int)(Sky_gTrackSpec->clearcolor).g,
             (u_int)(Sky_gTrackSpec->clearcolor).b);
  iVar2 = 0;
  do {
    if ((Sky_gTrackSpec->flags & 0x80U) == 0) {
      if (((Sky_gTrackSpec->flags & 2U) == 0) || (iVar3 = iVar8 << 0xb, 3 < iVar8)) {
        iVar3 = iVar8 << 0xc;
      }
      iVar4 = fixedcos(iVar3);
      iVar4 = fixedmult(iVar4,1000);
    }
    else {
      iVar3 = fixedcos(Sky_gTrackSpec->ringAngles[iVar8]);
      iVar4 = fixedmult(iVar3,1000);
      iVar3 = Sky_gTrackSpec->ringAngles[iVar8];
    }
    iVar6 = 0;
    iVar3 = fixedsin(iVar3);
    iVar3 = fixedmult(iVar3,1000);
    pSVar7 = gSkyMesh + iVar2;
    do {
      iVar5 = iVar6 * 0x1000;
      iVar6 = iVar6 + 1;
      angle_00 = (iVar5 - Sky_gTrackSpec->sunAngleInSky) + 0x4000;
      iVar5 = fixedsin(angle_00);
      iVar5 = fixedmult(iVar5,iVar4);
      pCVar1 = Sky_gTrackSpec;
      iVar2 = iVar2 + 1;
      pSVar7->vx = (short)iVar5;
      pSVar7->vy = (short)pCVar1->yoffset + (short)iVar3;
      iVar5 = fixedcos(angle_00);
      iVar5 = fixedmult(iVar5,iVar4);
      pSVar7->vz = (short)iVar5;
      pSVar7 = pSVar7 + 1;
    } while (iVar6 < 0x11);
    iVar8 = iVar8 + 1;
  } while (iVar8 < 5);
  iVar2 = 0;
  if (Sky_gTrackSpec->type == 1) {
    iVar8 = 0;
    do {
      iVar3 = 0;
      do {
        iVar4 = iVar3;
        if (iVar3 < 0) {
          iVar4 = iVar3 + 3;
        }
        iVar4 = iVar3 + (iVar4 >> 2) * -4;
        iVar3 = iVar3 + 1;
        gSkyPixmapIndex[iVar8] = *(char *)((int)Sky_gTrackSpec + iVar4 + iVar2 * 4 + 0x6c) + '\b';
        iVar8 = iVar8 + 1;
      } while (iVar3 < 0x10);
      iVar2 = iVar2 + 1;
    } while (iVar2 < 4);
    if ((Sky_gTrackSpec->type == 1) && ((Sky_gTrackSpec->flags & 0x20U) == 0))
    goto HrzInitSky_initLensFlare;
  }
  Hrz_InitSkyColor();
HrzInitSky_initLensFlare:
  Flare_InitLensFlare();
  return;
}

/* ---- Hrz_Init2DRing__Fv  [HRZSKU.CPP:337-414] SLD-VERIFIED ---- */
void Hrz_Init2DRing(void)

{
  int ringCount;
  int shapeWidth;
  int ti12;
  int pmx_p;
  int atan_in;
  int iVar6_b;
  int rowMaxX;
  int shape_p;
  int shapeStride;
  int ringEntry_pp;
  int rowOff_p;
  int ti10;
  int j;
  int ringByte_p;
  int rowBuf_p;
  int ring_step;
  int nMaxPmxHeight_InPixels;
  int pnPmxHeight_InPixels [16];
  int iVar14_field;
  int row_array_p;
  int level;
  int iVar1;
  int reg_t5;
  int u_idx;
  int u_idx2;
  int angle;
  int uVar18_pack;
  int i;
  int ring_x;
  int ring_x2;
  int row_advance;
  int row_idx;
  CVECTOR cur_bk;
  CVECTOR cur_fr;
  CVECTOR rounddiff;
  int loc_10;
  int loc_c;
  int loc_8;
  CHorizonSpec *tC3;
  CVECTOR tu5;
  int tp3;
  int tu6;
  void *tp1;
  int tp2;
  int CVar1;
  u_char *tp4;
  u_int tu7;
  u_int tu8;
  
  iVar1 = 0;
  do {
    uVar18_pack = iVar1 * 0x1000 + Hrz_gTrackSpec->angle;
    ringCount = fixedsin(uVar18_pack);
    shapeWidth = fixedmult(ringCount,32000);
    shape_p = (int)(gRngCoordTop + iVar1);
    *(short *)shape_p = (short)shapeWidth;
    *(u_short *)(shape_p + 2) = 0;
    ti12 = fixedcos(uVar18_pack);
    ti12 = fixedmult(ti12,32000);
    ring_x = iVar1 + 1;
    gRngCoordTop[iVar1].vz = (short)ti12;
    tC3 = Hrz_gTrackSpec;
    ti12 = 1;
    iVar1 = ring_x;
  } while (ring_x < 0x11);
  ringByte_p = (int)pnPmxHeight_InPixels;
  ringEntry_pp = (int)gpPmx;
  for (ring_x2 = 0; ring_x2 < 0x10; ring_x2 = ring_x2 + 1) {
    pmx_p = (int)gHorizonPixmap[(u_char)tC3->ringPMX[ring_x2] & 7];
    *(int *)ringEntry_pp = pmx_p;
    shapeStride = (u_int)*(u_char *)(pmx_p + 9) - (u_int)*(u_char *)(pmx_p + 5);
    *(int *)ringByte_p = shapeStride;
    if (ti12 < shapeStride) {
      ti12 = shapeStride;
    }
    ringByte_p = ringByte_p + 4;
    ringEntry_pp = ringEntry_pp + 4;
  }
  row_advance = 0;
  rowBuf_p = (int)gfxPmxHeightPercentage;
  rowOff_p = (int)&cur_bk;
  do {
    ((u_char *)&(atan_in))[0] = ((CVECTOR *)rowOff_p)->r;
    ((u_char *)&(atan_in))[1] = ((CVECTOR *)rowOff_p)->g;
    ((u_char *)&(atan_in))[2] = ((CVECTOR *)rowOff_p)->b;
    ((u_char *)&(atan_in))[3] = ((CVECTOR *)rowOff_p)->cd;
    if (ti12 == 0) {
      trap(0x1c00);
    }
    if ((ti12 == -1) && (atan_in << 0x10 == -0x80000000)) {
      trap(0x1800);
    }
    rowOff_p = rowOff_p + 4;
    row_advance = row_advance + 1;
    *(int *)rowBuf_p = (atan_in << 0x10) / ti12;
    rowBuf_p = rowBuf_p + 4;
  } while (row_advance < 0x10);
  row_array_p = (int)gHrzRingColor;
  ti12 = 0;
  for (iVar1 = 0; row_idx = 0, iVar1 < 2; iVar1 = iVar1 + 1) {
    tp3 = (int)&Hrz_gTrackSpec->backColor[iVar1].cd;
    tu7 = tp3 & 3;
    tu6 = (u_int)(Hrz_gTrackSpec->backColor + iVar1) & 3;
    u_idx = (*(int *)(tp3 - tu7) << (3 - tu7) * 8 | reg_t5 & 0xffffffffU >> (tu7 + 1) * 8) &
            -1 << (4 - tu6) * 8 |
            *(u_int *)((int)(Hrz_gTrackSpec->backColor + iVar1) - tu6) >> tu6 * 8;
    tp1 = &cur_bk.cd;
    tu7 = (u_int)tp1 & 3;
    *(u_int *)((int)tp1 - tu7) =
         *(u_int *)((int)tp1 - tu7) & -1 << (tu7 + 1) * 8 | (u_int)u_idx >> (3 - tu7) * 8;
    cur_bk.r = (char)u_idx;
    cur_bk.g = (char)((u_int)u_idx >> 8);
    cur_bk.b = (char)((u_int)u_idx >> 0x10);
    cur_bk.cd = (char)((u_int)u_idx >> 0x18);
    tp4 = &Hrz_gTrackSpec->frontColor[iVar1].cd;
    tu7 = (u_int)tp4 & 3;
    tu8 = (u_int)(Hrz_gTrackSpec->frontColor + iVar1) & 3;
    u_idx2 = (*(int *)(tp4 + -tu7) << (3 - tu7) * 8 | u_idx & 0xffffffffU >> (tu7 + 1) * 8) &
             -1 << (4 - tu8) * 8 |
             *(u_int *)((int)(Hrz_gTrackSpec->frontColor + iVar1) - tu8) >> tu8 * 8;
    tu7 = (u_int)&cur_fr.cd & 3;
    tp4 = &cur_fr.cd + -tu7;
    *(u_int *)tp4 = *(u_int *)tp4 & -1 << (tu7 + 1) * 8 | (u_int)u_idx2 >> (3 - tu7) * 8;
    cur_fr.r = (char)u_idx2;
    cur_fr.g = (char)((u_int)u_idx2 >> 8);
    cur_fr.b = (char)((u_int)u_idx2 >> 0x10);
    cur_fr.cd = (char)((u_int)u_idx2 >> 0x18);
    tu5 = cur_fr;
    iVar14_field = ti12;
    reg_t5 = u_idx2;
    for (; row_idx < 0x10; row_idx = row_idx + 1) {
      ring_step = row_idx;
      if (8 < row_idx) {
        ring_step = 0x10 - row_idx;
      }
      cur_fr.r = (u_char)u_idx2;
      iVar6_b = (u_idx & 0xffU) - (u_idx2 & 0xffU);
      if (iVar6_b < 0) {
        iVar6_b = iVar6_b + 7;
      }
      cur_fr.g = (u_char)((u_int)u_idx2 >> 8);
      rowMaxX = ((u_int)u_idx >> 8 & 0xff) - (u_int)cur_fr.g;
      if (rowMaxX < 0) {
        rowMaxX = rowMaxX + 7;
      }
      cur_fr.b = (u_char)((u_int)u_idx2 >> 0x10);
      ti10 = ((u_int)u_idx >> 0x10 & 0xff) - (u_int)cur_fr.b;
      if (ti10 < 0) {
        ti10 = ti10 + 7;
      }
      (&gHrzRingColor[0][0].r)[iVar14_field] = cur_fr.r + (char)(iVar6_b >> 3) * (char)ring_step;
      (&gHrzRingColor[0][0].g)[iVar14_field] = cur_fr.g + (char)(rowMaxX >> 3) * (char)ring_step;
      reg_t5 = (ti10 >> 3 & 0xffU) * ring_step;
      (&gHrzRingColor[0][0].b)[iVar14_field] = cur_fr.b + (char)reg_t5;
      iVar14_field = iVar14_field + 4;
    }
    CVar1 = *(int *)row_array_p;
    tu7 = row_array_p + 0x43U & 3;
    tp2 = (row_array_p + 0x43U) - tu7;
    *(u_int *)tp2 = *(u_int *)tp2 & -1 << (tu7 + 1) * 8 | (u_int)CVar1 >> (3 - tu7) * 8;
    *(int *)(row_array_p + 0x40) = CVar1;
    row_array_p = row_array_p + 0x44;
    ti12 = ti12 + 0x44;
    cur_fr = tu5;
  }
  Hrz_InitSky();
  Hrz_gSaveCol[1] = Sky_gTrackSpec->frontcolors[0];
  return;
}

/* ---- Hrz_GetHorizonPixMap__FP12Draw_tPixMap  [HRZSKU.CPP:419-428] SLD-VERIFIED ---- */
void Hrz_GetHorizonPixMap(Draw_tPixMap *p)

{
  int skytbl_walk;
  void *tp2;
  int tp3;
  Draw_tPixMap *p_walk;
  int extra_pmx;
  int i;
  int i_back;
  int i_fwd;
  int src_off;
  int dst_off;
  
  i_back = 0xb;
  skytbl_walk = -0x7fedfcdc;
  p_walk = p + 0xb;
  do {
    *(Draw_tPixMap **)skytbl_walk = p_walk;
    skytbl_walk = skytbl_walk + -4;
    i_back = i_back + -1;
    p_walk = p_walk + -1;
  } while (-1 < i_back);
  i_fwd = 0;
  dst_off = 0x30;
  extra_pmx = (int)&gHorizonExtraSkyPixmaps;
  src_off = 0x20;
  do {
    tp2 = (void *)((int)&gHorizonPixmap + src_off);
    src_off = src_off + 4;
    i_fwd = i_fwd + 1;
    Texture_CloneUVPmx(*(Draw_tPixMap **)tp2,0,(Draw_tPixMap *)extra_pmx);
    tp3 = (int)&gHorizonPixmap + dst_off;
    dst_off = dst_off + 4;
    *(int *)tp3 = extra_pmx;
    extra_pmx = extra_pmx + 0x10;
  } while (i_fwd < 4);
  return;
}

/* ---- Hrz_InitHorizon__Fv  [HRZSKU.CPP:432-443] SLD-VERIFIED ---- */
void Hrz_InitHorizon(void)

{
  Hrz_gTrackSpec = &TrackSpec_gSpec.horizonspec;
  Sky_gTrackSpec = &TrackSpec_gSpec.skyspec;
  gRngCoordTop = reservememadr("gRngCoordTop",0x88,0);
  Hrz_Init2DRing();
  if ((TrackSpec_gSpec.skyspec.flags & 0x10U) != 0) {
    Sky_InitStars();
  }
  return;
}

/* ---- Hrz_KillHorizon__Fv  [HRZSKU.CPP:447-450] SLD-VERIFIED ---- */
void Hrz_KillHorizon(void)

{
  purgememadr(gRngCoordTop);
  Sky_KillStars();
  return;
}

/* ---- Hrz_LightningAddFork__FScScSc  [HRZSKU.CPP:783-822] SLD-VERIFIED ---- */
void Hrz_LightningAddFork(char direction,char column,char row)

{
  u_char bVar1;
  int iVar2;
  u_int uVar3;
  u_int uVar4;
  char type;
  u_int uVar5;
  tHrz_LightningFork *fork;
  u_int uVar6;
  
  uVar5 = (u_int)(u_char)column;
  uVar3 = (u_int)(u_char)direction;
  if (row == '\0') {
    uVar6 = 3;
  }
  else {
    uVar6 = 2;
    if (row < '\x03') {
      uVar6 = random();
      uVar6 = uVar6 % 3;
    }
  }
  uVar4 = (u_int)(u_char)gHrz_Lightning.numForks;
  gHrz_Lightning.numForks = gHrz_Lightning.numForks + '\x01';
  gHrz_Lightning.forks[uVar4].pos.vx = column * 0xf;
  gHrz_Lightning.forks[uVar4].pos.vy = row * 0xf;
  if (uVar6 == 1) {
    Hrz_LightningAddFork(-1,(char)((uVar5 - 1) * 0x1000000 >> 0x18),row + '\x01');
    Hrz_LightningAddFork('\x01',(char)((uVar5 + 1) * 0x1000000 >> 0x18),row + '\x01');
    bVar1 = 6;
  }
  else if (uVar6 < 2) {
    if (uVar6 != 0) {
      iVar2 = uVar3 << 0x18;
      goto HrzLightFork_setPmxIdx;
    }
    Hrz_LightningAddFork(direction,(char)((uVar5 + uVar3) * 0x1000000 >> 0x18),row + '\x01');
    iVar2 = random();
    bVar1 = ((u_char)iVar2 & 1) + 2;
  }
  else if (uVar6 == 2) {
    iVar2 = random();
    bVar1 = ((u_char)iVar2 & 1) + 4;
  }
  else {
    iVar2 = uVar3 << 0x18;
    if (uVar6 != 3) goto HrzLightFork_setPmxIdx;
    uVar3 = random();
    uVar3 = (uVar3 & 1) * -2 + 1;
    Hrz_LightningAddFork((char)(uVar3 * 0x1000000 >> 0x18),(char)((uVar5 + uVar3) * 0x1000000 >> 0x18),
               row + '\x01');
    iVar2 = random();
    bVar1 = (u_char)iVar2 & 1;
  }
  gHrz_Lightning.forks[uVar4].pmxIndex = bVar1;
  iVar2 = uVar3 << 0x18;
HrzLightFork_setPmxIdx:
  if (iVar2 < 0) {
    gHrz_Lightning.forks[uVar4].pmxIndex = gHrz_Lightning.forks[uVar4].pmxIndex + '\b';
  }
  return;
}

/* ---- Hrz_CalculateLightning__Fv  [HRZSKU.CPP:826-829] SLD-VERIFIED ---- */
void Hrz_CalculateLightning(void)

{
  gHrz_Lightning.numForks = '\0';
  gHrz_Lightning.brightness = 200;
  Hrz_LightningAddFork('\x01','\0','\0');
  return;
}

/* ---- Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache  [HRZSKU.CPP:833-856] SLD-VERIFIED ---- */
void Hrz_TextureQuad(DVECTOR *pt,char type,char bright,Draw_DCache *sd)

{
  u_long l3;
  int pDVar1;
  int pixmap_w3;
  u_long l0;
  u_long l1;
  u_int uVar1;
  u_long l2;
  u_int uVar2;
  int pkt_addr24;
  u_char *cur_pkt;
  u_char *prev_pkt;
  void *prim;
  
  cur_pkt = Render_gPacketPtr;
  prim = cur_pkt;
  prev_pkt = Render_gPalettePtr;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 |
       *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x28;
  *(u_int *)(prev_pkt + sd->otz * 4) = *(u_int *)(prev_pkt + sd->otz * 4) & 0xff000000 | pkt_addr24;
  cur_pkt[3] = 9;
  cur_pkt[7] = 0x2e;
  cur_pkt[6] = bright;
  cur_pkt[5] = bright;
  cur_pkt[4] = bright;
  *(short *)(cur_pkt + 8) = pt->vx;
  *(short *)(cur_pkt + 10) = pt->vy;
  *(short *)(cur_pkt + 0x18) = pt->vx;
  *(short *)(cur_pkt + 0x1a) = pt->vy + 0x10;
  *(short *)(cur_pkt + 0x10) = pt->vx + 0x10;
  *(short *)(cur_pkt + 0x12) = pt->vy;
  *(short *)(cur_pkt + 0x20) = pt->vx + 0x10;
  *(short *)(cur_pkt + 0x22) = pt->vy + 0x10;
  pDVar1 = (int)&gLightningPixmap[(u_char)type];
  uVar1 = *(u_int *)(pDVar1 + 4);
  uVar2 = *(u_int *)(pDVar1 + 8);
  pixmap_w3 = *(int *)(pDVar1 + 0xc);
  *(u_int *)(cur_pkt + 0xc) = *(u_int *)pDVar1;
  *(u_int *)(cur_pkt + 0x14) = uVar1;
  *(u_int *)(cur_pkt + 0x1c) = uVar2;
  *(int *)(cur_pkt + 0x24) = pixmap_w3;
  return;
}

/* ---- Hrz_SetLightingPosInSky__FP13DRender_tView  [HRZSKU.CPP:862-867] SLD-VERIFIED ---- */
void Hrz_SetLightingPosInSky(DRender_tView *Vi)

{
  u_int uVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  coorddef forwardVec;
  
  iVar2 = (Vi->cview).mrotation.m[6];
  iVar3 = (Vi->cview).mrotation.m[7];
  iVar4 = (Vi->cview).mrotation.m[8];
  uVar1 = random();
  Hrz_gLightningPosInSky.vx =
       (short)(iVar2 >> 2) + (short)uVar1 + (short)(uVar1 / 8000) * -8000 + -4000;
  uVar1 = random();
  Hrz_gLightningPosInSky.vy =
       (short)(iVar3 >> 2) + 8000 + (short)uVar1 + (short)(uVar1 / 3000) * -3000;
  uVar1 = random();
  Hrz_gLightningPosInSky.vz =
       (short)(iVar4 >> 2) + (short)uVar1 + (short)(uVar1 / 8000) * -8000 + -4000;
  return;
}

/* ---- Hrz_BuildForkLightning__FP11Draw_DCache  [HRZSKU.CPP:872-898] SLD-VERIFIED ---- */
void Hrz_BuildForkLightning(Draw_DCache *sd)

{
  tHrz_LightningFork *fork;
  char i;
  u_char bVar1;
  u_char bVar2;
  DVECTOR pos;
  DVECTOR screenPos;
  coorddef trans;
  
  if (0 < gHrz_Lightning.brightness) {
    sd->otz = Draw_gViewOtSize + -2;
    memset(&trans,0,0xc);
    HrzSetPsxTranslation(&trans);
    gte_ldv0(&Hrz_gLightningPosInSky);
    gte_rtps();
    gte_stSXY2(&screenPos);
    bVar1 = 0;
    if (gHrz_Lightning.numForks != '\0') {
      do {
        bVar2 = bVar1 + 1;
        pos.vx = gHrz_Lightning.forks[bVar1].pos.vx + screenPos.vx;
        pos.vy = gHrz_Lightning.forks[bVar1].pos.vy + screenPos.vy;
        Hrz_TextureQuad(&pos,gHrz_Lightning.forks[bVar1].pmxIndex,(char)gHrz_Lightning.brightness,sd);
        bVar1 = bVar2;
      } while (bVar2 < (u_char)gHrz_Lightning.numForks);
    }
    gHrz_Lightning.brightness = gHrz_Lightning.brightness + -0x10;
  }
  return;
}

/* ---- Hrz_LightningFlicker__Fi  [HRZSKU.CPP:901-954] SLD-VERIFIED ---- */
void Hrz_LightningFlicker(int on)

{
  CSkySpec *pCVar1;
  CVECTOR *pCVar2;
  int i;
  int iVar3;
  
  if (on == 0) {
    Sky_gTrackSpec->frontcolors[0] = Hrz_gSaveCol[1];
    Hrz_InitSkyColor();
  }
  else {
    pCVar1 = Sky_gTrackSpec;
    if (on == 1) {
      if (Night_gShowForks == '\0') {
        iVar3 = 0x54;
        pCVar2 = gSkyColor + 0x54;
        pCVar1->frontcolors[0].r = 0xc0;
        pCVar1->frontcolors[0].g = 0xc0;
        pCVar1->frontcolors[0].b = 0xff;
        pCVar1->frontcolors[0].cd = '\0';
        do {
          pCVar2->r = 0xc0;
          pCVar2->g = 0xc0;
          pCVar2->b = 0xff;
          pCVar2->cd = '\0';
          iVar3 = iVar3 + -1;
          pCVar2 = pCVar2 + -1;
        } while (-1 < iVar3);
      }
    }
    else if (Night_gShowForks == '\0') {
      iVar3 = 0x54;
      pCVar2 = gSkyColor + 0x54;
      pCVar1->frontcolors[0].r = '(';
      pCVar1->frontcolors[0].g = '(';
      pCVar1->frontcolors[0].b = 0xc0;
      pCVar1->frontcolors[0].cd = '\0';
      do {
        pCVar2->r = '(';
        pCVar2->g = '(';
        pCVar2->b = 0xc0;
        pCVar2->cd = '\0';
        iVar3 = iVar3 + -1;
        pCVar2 = pCVar2 + -1;
      } while (-1 < iVar3);
    }
  }
  return;
}

/* ---- HrzSetPsxMatrix__FP10matrixtdef  [HRZSKU.CPP:982-1017] SLD-VERIFIED ---- */
void HrzSetPsxMatrix(matrixtdef *m)
{
  int r2, r0, r1, t2, t1, t3;
  MATRIX mpsx;
  matrixtdef temp;
  int *mm = (int *)m;

  mpsx.m[0][0] = (short)(mm[0] >> 4);
  mpsx.m[0][1] = (short)(mm[3] >> 4);
  mpsx.m[0][2] = (short)(mm[6] >> 4);
  mpsx.m[1][0] = (short)(-mm[1] >> 4);
  mpsx.m[1][1] = (short)(-mm[4] >> 4);
  mpsx.m[1][2] = (short)(-mm[7] >> 4);
  mpsx.m[2][0] = (short)(mm[2] >> 4);
  mpsx.m[2][1] = (short)(mm[5] >> 4);
  mpsx.m[2][2] = (short)(mm[8] >> 4);
  gte_SetRotMatrix(&mpsx);
}

/* ---- HrzSetPsxTranslation__FP8coorddef  [HRZSKU.CPP:1021-1028] SLD-VERIFIED ---- */
void HrzSetPsxTranslation(coorddef *t)
{
  MATRIX mpsx;
  int *tt = (int *)t;

  mpsx.t[0] = tt[0] >> 10;
  mpsx.t[1] = tt[1] >> 10;
  mpsx.t[2] = tt[2] >> 10;
  gte_SetTransMatrix(&mpsx);
}

/* ---- Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR  [HRZSKU.CPP:1032-1045] SLD-VERIFIED ---- */
void Hrz_RotProj16(int n, SVECTOR *s, int *z, DVECTOR *p)
{
  int i;

  if (n != 0) {
    i = n - 1;
    do {
      gte_ldv0(s);                  /* load vx,vy,vz into VXY0/VZ0 */
      gte_rtps();                   /* rotate / transform / perspective */
      s = s + 1;
      gte_stSXY2(p);                /* store screen XY -> DVECTOR (SXY2) */
      p = p + 1;
      gte_swc2(0x1b, z);            /* store screen Z (MAC3) -> int  [no canonical macro] */
      i = i - 1;
      z = z + 1;
    } while (i != -1);
  }
}

/* ---- Hrz_SetDitheringPrim__Fii  [HRZSKU.CPP:1050-1055] SLD-VERIFIED ---- */
void Hrz_SetDitheringPrim(int dither,int otz)

{
  DR_MODE *prim;
  u_int *prev_pkt_slot;
  int pkt_addr24;
  int loc_10;
  int loc_8;
  u_char *p;
  
  p = Render_gPacketPtr;
  prev_pkt_slot = (u_int *)(Render_gPalettePtr + otz * 4);
  *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *prev_pkt_slot & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *prev_pkt_slot = *prev_pkt_slot & 0xff000000 | pkt_addr24;
  SetDrawMode((DR_MODE *)p,0,dither,0x100,(RECT *)0x0);
  return;
}

/* ---- Hrz_BuildSky__Fv  [HRZSKU.CPP:1060-1277] SLD-VERIFIED ---- */
void Hrz_BuildSky(void)
{
  coorddef trans;
  VECTOR transformed;
  Draw_DCache *sd;
  DVECTOR *pSkyMesh;
  int *pSkyZ;
  DVECTOR *scnt;
  SVECTOR *pcnt;
  int *zcnt;
  int n, otz_old, pshift, i, temp;
  POLY_GT4 *prim;
  Draw_tPixMap *pmx;
  int ti1, ti2, skyColIdx, skyRowIdx, tu7, CVar8, CVar4, skyTexPmx_p, tD8;
  int tC2, tC1, skyMesh_iter;
  u_char *tp2, *tp3;
  CSkySpec *tC4;
  CVECTOR CVar3;

  sd = (Draw_DCache *)0x1f800000;        /* PSX scratchpad base */
  pSkyMesh = (DVECTOR *)0x1f800014;      /* projected screen-XY buffer */
  pSkyZ = (int *)0x1f800168;             /* projected screen-Z buffer  */
  otz_old = 0x78;
  if (GameSetup_gData.commMode == 1) {
    otz_old = 0x3c;
  }
  pshift = otz_old;
  if ((Sky_gTrackSpec->flags & 1U) != 0) {
    /* RTPT fast path: 3 vertices per pass (0x55 total) + RTPS tail. */
    memset(&trans,0,0xc);
    HrzSetPsxTranslation(&trans);
    pcnt = (SVECTOR *)&gSkyMesh /* @0x80120378 */;
    n = 0x55;
    scnt = (DVECTOR *)((char *)sd + 8);
    zcnt = (int *)((char *)sd + 0x15c);
    do {
      gte_ldv3(pcnt, pcnt + 1, pcnt + 2);
      gte_rtpt();
      pcnt = pcnt + 3;
      n = n + -3;
      scnt = scnt + 3;
      zcnt = zcnt + 3;
      gte_stsxy3(&scnt[0],&scnt[1],&scnt[2]);
      gte_swc2(0x11,&zcnt[0]);   /* SZ1 -> no canonical macro */
      gte_swc2(0x12,&zcnt[1]);   /* SZ2 -> no canonical macro */
      gte_swc2(0x13,&zcnt[2]);   /* SZ3 */
    } while (2 < n);
    scnt = &scnt[2];
    n = n + -1;
    zcnt = &zcnt[2];
    if (n != -1) {
      do {
        gte_ldv0(pcnt);
        gte_rtps();
        pcnt = pcnt + 1;
        scnt = scnt + 1;
        zcnt = zcnt + 1;
        gte_stSXY2(scnt);
        gte_stsz(zcnt);
        n = n + -1;
      } while (n != -1);
    }
  }
  else {
    /* RTPS path: 1 vertex per pass (0x54 total), screen row pinned at otz_old. */
    memset(&trans,0,0xc);
    HrzSetPsxTranslation(&trans);
    pcnt = (SVECTOR *)&gSkyMesh /* @0x80120378 */;
    scnt = pSkyMesh + -1;
    zcnt = pSkyZ + -1;
    n = 0x54;
    do {
      gte_ldv0(pcnt);
      gte_rtps();
      pcnt = pcnt + 1;
      scnt = scnt + 1;
      zcnt = zcnt + 1;
      gte_stlvnl(&transformed.vx);
      gte_stSXY2(scnt);
      scnt->vy = (short)(transformed.vy >> 2) + (short)otz_old;
      gte_stsz(zcnt);
      n = n + -1;
    } while (n != -1);
  }
  if ((Sky_gTrackSpec->flags & 0x40U) != 0) {
    Hrz_SetDitheringPrim(0,Draw_gViewOtSize + -2);
  }
  ti1 = Skid_gCtrlScratch_94;
  if ((TrackSpec_gSpec.skyspec.flags & 4U) != 0) {
    Flare_Sun(&sunPosInSky,(Draw_FlareCache *)&Render_gPalettePtr);
  }
  i = 0;
  skyMesh_iter = (int)&gSkyPixmapIndex;
  Skid_gCtrlScratch_94 = ti1;
  do {
    tC4 = Sky_gTrackSpec;
    ti1 = Draw_gViewOtSize;
    tp2 = Render_gPacketPtr;
    tp3 = Render_gPalettePtr;
    prim = (POLY_GT4 *)tp2;
    if (0x3f < i) {
      if ((Sky_gTrackSpec->flags & 0x40U) != 0) {
        Hrz_SetDitheringPrim(1,Draw_gViewOtSize + -2);
      }
      return;
    }
    ti2 = i * 0x11;
    if (ti2 < 0) {
      ti2 = ti2 + 0xf;
    }
    temp = ti2 >> 4;
    if (((((&Hrz_gSkyVtx_B0)[temp] != 0) || ((&Hrz_gSkyVtx_B1)[temp] != 0)) ||
        ((&Hrz_gSkyVtx_A1)[temp] != 0)) || ((&Hrz_gSkyVtx_A0)[temp] != 0)) {
      if ((((short)Render_gCopMat.m[temp + 1] <= (short)Render_gPacketLenLo) ||
          ((short)Render_gCopMat.m[temp + 2] <= (short)Render_gPacketLenLo)) ||
         (((short)Render_gWorldMat.t[temp + -4] <= (short)Render_gPacketLenLo ||
          (Render_gWorldMat.m[0][temp * 2] <= (short)Render_gPacketLenLo)))) {
        if ((((-1 < (short)Render_gCopMat.m[temp + 1]) ||
             (-1 < (short)Render_gCopMat.m[temp + 2])) ||
            ((-1 < (short)Render_gWorldMat.t[temp + -4] ||
             (-1 < Render_gWorldMat.m[0][temp * 2])))) &&
           (((((skyColIdx = temp * 4,
               *(short *)((int)Render_gCopMat.m + skyColIdx + 6) <= (short)Render_gPacketLenHi ||
               (*(short *)((int)Render_gCopMat.m + skyColIdx + 10) <= (short)Render_gPacketLenHi))
              || (*(short *)((int)Render_gWorldMat.t + skyColIdx + -0xe) <=
                  (short)Render_gPacketLenHi)) ||
             (*(short *)((int)Render_gWorldMat.t + skyColIdx + -0x12) <= (short)Render_gPacketLenHi)
             ) && (((skyRowIdx = temp * 4,
                    -1 < *(short *)((int)Render_gCopMat.m + skyRowIdx + 6) ||
                    (-1 < *(short *)((int)Render_gCopMat.m + skyRowIdx + 10))) ||
                   ((-1 < *(short *)((int)Render_gWorldMat.t + skyRowIdx + -0xe) ||
                    (-1 < (int)((u_int)*(u_short *)((int)Render_gWorldMat.t + skyRowIdx + -0x12) <<
                               0x10))))))))) {
          if (Sky_gTrackSpec->type == 1) {
            if ((Sky_gTrackSpec->flags & 0x20U) != 0) {
              pmx = gHorizonPixmap[*(u_char *)skyMesh_iter];
              skyTexPmx_p = (int)pmx;
              *(u_int *)Render_gPacketPtr =
                   *(u_int *)Render_gPacketPtr & 0xff000000 |
                   *(u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4 + -8) & 0xffffff;
              *(u_int *)(tp3 + ti1 * 4 + -8) =
                   *(u_int *)(tp3 + ti1 * 4 + -8) & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
              tC2 = (int)Render_gPacketPtr + 4;
              Render_gPacketPtr = Render_gPacketPtr + 0x34;
              *(CVECTOR *)tC2 = gSkyColor[temp + 0x11];
              *(CVECTOR *)(tp2 + 0x10) = gSkyColor[temp + 0x12];
              *(CVECTOR *)(tp2 + 0x1c) = gSkyColor[temp];
              CVar8 = *(int *)(gSkyColor + temp + 1);
              tp2[3] = 0xc;
              tp2[7] = 0x3c;
              *(int *)(tp2 + 0x28) = CVar8;
              *(u_int *)(tp2 + 0xc) = *(u_int *)skyTexPmx_p;
              *(u_int *)(tp2 + 0x18) = *(u_int *)(skyTexPmx_p + 4);
              *(u_int *)(tp2 + 0x24) = *(u_int *)(skyTexPmx_p + 8);
              *(u_int *)(tp2 + 0x30) = *(u_int *)(skyTexPmx_p + 0xc);
              *(int *)(tp2 + 8) = Render_gCopMat.m[temp + 1];
              *(int *)(tp2 + 0x14) = Render_gCopMat.m[temp + 2];
              *(u_int *)(tp2 + 0x20) = *(u_int *)(Render_gWorldMat.m[0] + temp * 2)
              ;
              *(long *)(tp2 + 0x2c) = Render_gWorldMat.t[temp + -4];
              goto HrzBuildSky_meshIterNext;
            }
            pmx = gHorizonPixmap[*(u_char *)skyMesh_iter];
            tD8 = (int)pmx;
            *(u_int *)Render_gPacketPtr =
                 *(u_int *)Render_gPacketPtr & 0xff000000 |
                 *(u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4 + -8) & 0xffffff;
            tu7 = (u_int)Render_gPacketPtr & 0xffffff;
            Render_gPacketPtr = Render_gPacketPtr + 0x28;
            *(u_int *)(tp3 + ti1 * 4 + -8) = *(u_int *)(tp3 + ti1 * 4 + -8) & 0xff000000 | tu7;
            CVar4 = *(int *)tC4->frontcolors;
            tp2[3] = 9;
            *(int *)(tp2 + 4) = CVar4;
            tp2[7] = 0x2c;
            *(u_int *)(tp2 + 0xc) = *(u_int *)tD8;
            *(u_int *)(tp2 + 0x14) = *(u_int *)(tD8 + 4);
            *(u_int *)(tp2 + 0x1c) = *(u_int *)(tD8 + 8);
            *(u_int *)(tp2 + 0x24) = *(u_int *)(tD8 + 0xc);
          }
          else {
            *(u_int *)Render_gPacketPtr =
                 *(u_int *)Render_gPacketPtr & 0xff000000 |
                 *(u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4 + -8) & 0xffffff;
            *(u_int *)(tp3 + ti1 * 4 + -8) =
                 *(u_int *)(tp3 + ti1 * 4 + -8) & 0xff000000 | (u_int)Render_gPacketPtr & 0xffffff;
            tC1 = (int)Render_gPacketPtr + 4;
            Render_gPacketPtr = Render_gPacketPtr + 0x24;
            *(CVECTOR *)tC1 = gSkyColor[temp + 0x11];
            *(CVECTOR *)(tp2 + 0xc) = gSkyColor[temp + 0x12];
            *(CVECTOR *)(tp2 + 0x14) = gSkyColor[temp];
            CVar3 = gSkyColor[temp + 1];
            tp2[3] = 8;
            tp2[7] = 0x38;
            *(CVECTOR *)(tp2 + 0x1c) = CVar3;
          }
          *(int *)(tp2 + 8) = Render_gCopMat.m[temp + 1];
          *(int *)(tp2 + 0x10) = Render_gCopMat.m[temp + 2];
          *(u_int *)(tp2 + 0x18) = *(u_int *)(Render_gWorldMat.m[0] + temp * 2);
          *(long *)(tp2 + 0x20) = Render_gWorldMat.t[temp + -4];
        }
      }
    }
HrzBuildSky_meshIterNext:
    skyMesh_iter = skyMesh_iter + 1;
    i = i + 1;
  } while( true );
}

/* ---- Sky_RenderStars__FP13Draw_SkyCachei  [HRZSKU.CPP:1284-1330] SLD-VERIFIED ---- */
void Sky_RenderStars(Draw_SkyCache *sd,int otz)

{
  int iVar1;
  u_int uVar2;
  u_long uVar3;
  u_int *puVar4;
  void *prim;
  u_int *puVar5;
  int n;
  int iVar6;
  u_int uVar7;
  void *ppuVar8;
  u_int uVar8;
  SVECTOR *pcnt;
  int pshift;
  int iVar9;
  coorddef trans;
  DVECTOR scnt;
  VECTOR transformed;
  int zcnt;
  
  iVar9 = 0x78;
  if (GameSetup_gData.commMode == 1) {
    iVar9 = 0x3c;
  }
  memset(&trans,0,0xc);
  HrzSetPsxTranslation(&trans);
  iVar6 = 0;
  if (0 < Sky_gTrackSpec->numStars) {
    ppuVar8 = &Render_gPacketPtr;
    pcnt = starPosInSky;
    uVar7 = 0xffffff;
    uVar8 = 0xff000000;
    do {
      gte_ldv0(pcnt);
      gte_rtps();
      pcnt = pcnt + 1;
      gte_stsz(&zcnt);
      if (0 < zcnt) {
        gte_stSXY2(&scnt);
        gte_stlvnl(&transformed.vx);
        iVar1 = (transformed.vy >> 2) + iVar9;
        scnt.vy = (short)iVar1;
        if ((((scnt.vx <= (sd->head).clipW) && (-1 < scnt.vx)) &&
            (iVar1 = iVar1 * 0x10000 >> 0x10, iVar1 <= (sd->head).clipH)) && (-1 < iVar1)) {
          puVar4 = *(u_int **)ppuVar8;
          prim = puVar4;
          puVar5 = (u_int *)(Render_gPalettePtr + otz * 4);
          *puVar4 = *puVar4 & uVar8 | *puVar5 & uVar7;
          uVar2 = *puVar5;
          *(u_int **)ppuVar8 = puVar4 + 3;
          *puVar5 = uVar2 & uVar8 | (u_int)puVar4 & uVar7;
          uVar3 = (*(u_long *)&starColors[iVar6]);
          *(u_char *)((int)puVar4 + 3) = 2;
          puVar4[1] = uVar3;
          *(u_char *)((int)puVar4 + 7) = 0x68;
          *(DVECTOR *)(puVar4 + 2) = scnt;
        }
      }
      iVar6 = iVar6 + 1;
    } while (iVar6 < Sky_gTrackSpec->numStars);
  }
  return;
}

/* ---- Hrz_BuildHorizon__FP13DRender_tView  [HRZSKU.CPP:1338-1557] SLD-VERIFIED ---- */
void Hrz_BuildHorizon(DRender_tView *Vi)

{
  u_int *puVar1;
  u_int uVar2;
  u_int uVar3;
  u_int uVar4;
  u_char *puVar5;
  u_char *p;
  POLY_GT4 *prim;
  int iVar6;
  DVECTOR DVar7;
  int iVar8;
  int iVar9;
  u_int auVar10;
  short shape_short;
  int r2;
  int r0;
  int dy;
  int *zval;
  SVECTOR *pSVar12;
  int dx;
  int Zmax;
  SVECTOR *pcnt;
  int shape_visible;
  int shape_idx;
  int rowDelta;
  int shape_overlap;
  int shape_w_idx;
  int farIdx;
  int farI;
  int t1;
  DVECTOR *pDVar13;
  int t3;
  Draw_tPixMap *pmx;
  u_int *puVar14;
  int height;
  int iVar15;
  int latAngle;
  int iVar16;
  int i;
  int iVar17;
  int oldSeed;
  int iVar18;
  Draw_HorizonCache *hsd;
  int loc_70;
  int loc_6c;
  coorddef trans;
  coorddef trans2;
  u_int auStack_4c;
  DVECTOR right;
  SVECTOR p_;
  DVECTOR DStack_38;
  int fxOverlapPercentage;
  long hrz_projchange;
  VECTOR transformed;
  SVECTOR updown [2];
  DVECTOR temp2d [2];
  DVECTOR mpts [4];
  long s_;
  void *tp1;
  short ts3;
  int tp2;
  int tu5;
  short ts4;
  int tp6;
  int tu8;
  short tu7;
  int tp9;
  void *tp3;
  short tu6;
  short ts5;
  u_int *tp10;
  u_char *tp4;
  u_int tu9;
  
  dy = (int)&trans;
  fxOverlapPercentage = 0x107ae;
  memset((void *)dy,0,0xc);
  hrz_projchange = 0;
  if (700 < Camera_gGeomScreen) {
    hrz_projchange = Camera_gGeomScreen;
    SetGeomScreen(700);
  }
  HrzSetPsxMatrix(&(Vi->cview).mrotationInv);
  HrzSetPsxTranslation(&trans);
  Hrz_RotProj16(0x11,gRngCoordTop,&Hrz_gProjResultZ0,(DVECTOR *)(Render_gCopMat.m + 1));
  farI = 0;
  Zmax = 0;
  zval = &Hrz_gProjResultZ0;
  rowDelta = 0;
  do {
    if (Zmax < *zval) {
      Zmax = *zval;
      farI = rowDelta;
    }
    rowDelta = rowDelta + 1;
    zval = zval + 1;
  } while (rowDelta < 0x10);
  pSVar12 = gRngCoordTop + farI;
  shape_short = (short)Hrz_gTrackSpec->yoffset + (short)Hrz_gTrackSpec->height;
  trans2.x = CONCAT22(shape_short,pSVar12->vx);
  trans2.y = CONCAT22((*(u_short *)((u_char *)&(trans2.y) + 2)),pSVar12->vz);
  p_.vx = pSVar12->vx;
  p_.vy = (short)Hrz_gTrackSpec->yoffset;
  trans2.z = CONCAT22(p_.vy,p_.vx);
  (*(u_short *)&(auStack_4c)) = pSVar12->vz;
  tp1 = (void *)((int)&p_.vy + 1);
  tu5 = (u_int)tp1 & 3;
  *(u_int *)((int)tp1 - tu5) =
       *(u_int *)((int)tp1 - tu5) & -1 << (tu5 + 1) * 8 | (u_int)trans2.z >> (3 - tu5) * 8;
  tp2 = (int)&p_.pad + 1;
  tu8 = tp2 & 3;
  tp6 = tp2 - tu8;
  *(u_int *)tp6 = *(u_int *)tp6 & -1 << (tu8 + 1) * 8 | (u_int)auStack_4c >> (3 - tu8) * 8;
  p_.vz = (*(u_short *)&(auStack_4c));
  p_.pad = (*(u_short *)((u_char *)&(auStack_4c) + 2));
  gte_ldv0(&p_);
  gte_rtps();
  gte_stSXY2(&DStack_38);
  tp3 = (void *)((int)&p_.vy + 1);
  tu9 = (u_int)tp3 & 3;
  tp9 = (int)tp3 - tu9;
  *(u_int *)tp9 = *(u_int *)tp9 & -1 << (tu9 + 1) * 8 | (u_int)trans2.x >> (3 - tu9) * 8;
  p_.vx = (short)trans2.x;
  p_.vy = (*(u_short *)((u_char *)&(trans2.x) + 2));
  tp4 = (u_char *)((int)&p_.pad + 1);
  tu9 = (u_int)tp4 & 3;
  tp10 = (u_int *)(tp4 + -tu9);
  *tp10 = *tp10 & -1 << (tu9 + 1) * 8 | (u_int)trans2.y >> (3 - tu9) * 8;
  p_.vz = (short)trans2.y;
  p_.pad = (*(u_short *)((u_char *)&(trans2.y) + 2));
  pDVar13 = (DVECTOR *)trans2.x;
  gte_ldv0(&p_);
  gte_rtps();
  gte_stSXY2(&DStack_38);
  shape_overlap = 0;
  shape_visible = 0x1f800000;
  right = DStack_38;
  DVar7 = right;
  right.vx = DStack_38.vx;
  iVar17 = Render_gCopMat.m[farI + 1];
  right.vy = DStack_38.vy;
  ts3 = *(short *)((int)Render_gCopMat.m + farI * 4 + 6);
  do {
    if (0 < *(int *)(shape_visible + 0x124)) {
      *(short *)(shape_visible + 0x14) =
           *(short *)(shape_visible + 0x58) + (right.vx - (short)iVar17);
      *(short *)(shape_visible + 0x16) = *(short *)(shape_visible + 0x5a) + (right.vy - ts3);
    }
    shape_overlap = shape_overlap + 1;
    shape_visible = shape_visible + 4;
  } while (shape_overlap < 0x11);
  shape_w_idx = 0;
  shape_idx = 0x1f800000;
  iVar17 = Render_gCopMat.m[farI + 1];
  ts5 = *(short *)((int)Render_gCopMat.m + farI * 4 + 6);
  do {
    if (0 < *(int *)(shape_idx + 0x124)) {
      *(short *)(shape_idx + 0x58) = *(short *)(shape_idx + 0x58) + (right.vx - (short)iVar17);
      *(short *)(shape_idx + 0x5a) = *(short *)(shape_idx + 0x5a) + (right.vy - ts5);
    }
    shape_w_idx = shape_w_idx + 1;
    shape_idx = shape_idx + 4;
  } while (shape_w_idx < 0x11);
  right = DVar7;
  Horizon_InterpolateLineSCoords(pDVar13,(DVECTOR *)(Render_gCopMat.m + 1),(DVECTOR *)&Render_gWorldMat,
             gfxPmxHeightPercentage,0x10,1);
  Horizon_InterpolateLineSCoords(pDVar13,(DVECTOR *)(Render_gCopMat.m + 2),(DVECTOR *)(Render_gWorldMat.m[0] + 2),
             gfxPmxHeightPercentage,0x10,1);
  iVar17 = 0;
  if (TrackSpec_gSpec.horizonstate != 0) {
    iVar16 = 0x1f800000;
    iVar15 = 0;
    iVar18 = 4;
    for (; iVar17 < 0x10; iVar17 = iVar17 + 1) {
      if ((15999 < *(int *)(iVar16 + 0x124)) ||
         (tu9 = trans2.x, iVar8 = trans2.y, iVar9 = trans2.z, auVar10 = auStack_4c,
         15999 < *(int *)((int)&Hrz_gProjResultZ0 + iVar18))) {
        tu9 = *(u_int *)(iVar16 + 0x9c);
        tp4 = (u_char *)((int)&trans2.x + 3);
        uVar2 = (u_int)tp4 & 3;
        tp10 = (u_int *)(tp4 + -uVar2);
        *tp10 = *tp10 & -1 << (uVar2 + 1) * 8 | tu9 >> (3 - uVar2) * 8;
        uVar2 = *(u_int *)(iVar16 + 0xe0);
        tp4 = (u_char *)((int)&trans2.y + 3);
        uVar3 = (u_int)tp4 & 3;
        tp10 = (u_int *)(tp4 + -uVar3);
        *tp10 = *tp10 & -1 << (uVar3 + 1) * 8 | uVar2 >> (3 - uVar3) * 8;
        trans2.y = uVar2;
        iVar8 = trans2.y;
        uVar3 = *(u_int *)((int)Render_gCopMat.m + iVar18 + 4);
        tp4 = (u_char *)((int)&trans2.z + 3);
        uVar4 = (u_int)tp4 & 3;
        tp10 = (u_int *)(tp4 + -uVar4);
        *tp10 = *tp10 & -1 << (uVar4 + 1) * 8 | uVar3 >> (3 - uVar4) * 8;
        trans2.z = uVar3;
        iVar9 = trans2.z;
        pDVar13 = *(DVECTOR **)(iVar16 + 0x58);
        tp4 = (u_char *)&auStack_4c + 3;
        uVar4 = (u_int)tp4 & 3;
        *(u_int *)(tp4 + -uVar4) =
             *(u_int *)(tp4 + -uVar4) & -1 << (uVar4 + 1) * 8 | (u_int)pDVar13 >> (3 - uVar4) * 8;
        auStack_4c = (u_int)pDVar13;
        auVar10 = auStack_4c;
        (*(u_short *)&(trans2.x)) = (short)tu9;
        (*(u_short *)&(trans2.y)) = (short)uVar2;
        (*(u_short *)&(trans2.z)) = (short)uVar3;
        (*(u_short *)&(auStack_4c)) = SUB42(pDVar13,0);
        if (((((-1 < (short)trans2.x) ||
              (((-1 < (short)trans2.y || (-1 < (short)trans2.z)) || (-1 < (short)(*(u_short *)&(auStack_4c)))))
              ) && (((((short)trans2.x <= (short)Render_gPacketLenLo ||
                      ((short)trans2.y <= (short)Render_gPacketLenLo)) ||
                     ((short)trans2.z <= (short)Render_gPacketLenLo)) ||
                    ((short)(*(u_short *)&(auStack_4c)) <= (short)Render_gPacketLenLo)))) &&
            ((((*(u_short *)((u_char *)&(trans2.x) + 2)) = (short)(tu9 >> 0x10), (*(u_short *)((u_char *)&(trans2.y) + 2)) = (short)(uVar2 >> 0x10),
              (*(u_short *)((u_char *)&(trans2.z) + 2)) = (short)(uVar3 >> 0x10),
              (*(u_short *)((u_char *)&(auStack_4c) + 2)) = (u_short)((u_int)pDVar13 >> 0x10), -1 < (int)tu9 ||
              (-1 < (int)uVar2)) || ((-1 < (int)uVar3 || (-1 < (int)pDVar13)))))) &&
           (((((*(u_short *)((u_char *)&(trans2.x) + 2)) <= (short)Render_gPacketLenHi ||
              ((*(u_short *)((u_char *)&(trans2.y) + 2)) <= (short)Render_gPacketLenHi)) ||
             ((*(u_short *)((u_char *)&(trans2.z) + 2)) <= (short)Render_gPacketLenHi)) ||
            ((short)(*(u_short *)((u_char *)&(auStack_4c) + 2)) <= (short)Render_gPacketLenHi)))) {
          trans2.x = tu9;
          trans2.y = iVar8;
          trans2.z = iVar9;
          auStack_4c = auVar10;
          Horizon_InterpolateLineSCoords(pDVar13,(DVECTOR *)((int)&Hrz_gProjScratch_9C + iVar15),
                     (DVECTOR *)((int)&DrawW_gChunkVtxBuf + iVar15),&fxOverlapPercentage,1,0);
          iVar6 = Draw_gViewOtSize;
          p = Render_gPacketPtr;
    prim = (POLY_GT4 *)p;
          puVar5 = Render_gPalettePtr;
          puVar14 = *(u_int **)((int)gpPmx + iVar15);
          tu9 = trans2.x;
          iVar8 = trans2.y;
          iVar9 = trans2.z;
          auVar10 = auStack_4c;
          if (Hrz_gTrackSpec->ringPMX[iVar17] != '\x10') {
            *(u_int *)Render_gPacketPtr =
                 *(u_int *)Render_gPacketPtr & 0xff000000 |
                 *(u_int *)(Render_gPalettePtr + Draw_gViewOtSize * 4 + -8) & 0xffffff;
            *(u_int *)(puVar5 + iVar6 * 4 + -8) =
                 *(u_int *)(puVar5 + iVar6 * 4 + -8) & 0xff000000 |
                 (u_int)Render_gPacketPtr & 0xffffff;
            puVar1 = (u_int *)(Render_gPacketPtr + 4);
            Render_gPacketPtr = Render_gPacketPtr + 0x34;
            *puVar1 = *(u_int *)(&gHrzRingColor[1][0].r + iVar15);
            *(u_int *)(p + 0x10) = *(u_int *)(&gHrzRingColor[1][1].r + iVar15);
            *(u_int *)(p + 0x1c) = *(u_int *)(&gHrzRingColor[0][0].r + iVar15);
            *(u_int *)(p + 0x28) = *(u_int *)(&gHrzRingColor[0][1].r + iVar15);
            SetPolyGT4((POLY_GT4 *)p);
            *(u_int *)(p + 0xc) = *puVar14;
            *(u_int *)(p + 0x18) = puVar14[1];
            *(u_int *)(p + 0x24) = puVar14[2];
            *(u_int *)(p + 0x30) = puVar14[3];
            iVar8 = trans2.y;
            iVar9 = trans2.z;
            auVar10 = auStack_4c;
            tu9 = trans2.x;
            if ((u_char)Hrz_gTrackSpec->ringPMX[iVar17] < 8) {
              *(u_int *)(p + 8) = *(u_int *)((int)&Hrz_gProjScratch_9C + iVar15);
              *(DVECTOR *)(p + 0x14) = right;
              *(u_int *)(p + 0x20) = *(u_int *)((int)Render_gCopMat.m + iVar15 + 4);
              *(u_int *)(p + 0x2c) = *(u_int *)((int)Render_gCopMat.m + iVar15 + 8);
            }
            else {
              *(DVECTOR *)(p + 8) = right;
              *(u_int *)(p + 0x14) = *(u_int *)(iVar16 + 0x9c);
              *(u_int *)(p + 0x20) = *(u_int *)(iVar16 + 0x5c);
              *(u_int *)(p + 0x2c) = *(u_int *)(iVar16 + 0x58);
            }
          }
        }
      }
      auStack_4c = auVar10;
      trans2.z = iVar9;
      trans2.y = iVar8;
      trans2.x = tu9;
      iVar16 = iVar16 + 4;
      iVar15 = iVar15 + 4;
      iVar18 = iVar18 + 4;
    }
  }
  if ((Night_gLightning != 0) && (Night_gShowForks != '\0')) {
    Hrz_BuildForkLightning((Draw_DCache *)&Render_gPalettePtr);
  }
  if ((TrackSpec_gSpec.skyspec.flags & 8U) != 0) {
    memset(&trans2,0,0xc);
    HrzSetPsxTranslation(&trans2);
    Flare_Moon(&moonPosInSky,(Draw_FlareCache *)&Render_gPalettePtr);
  }
  if ((TrackSpec_gSpec.skyspec.flags & 0x10U) != 0) {
    Sky_RenderStars((Draw_SkyCache *)&Render_gPalettePtr,Draw_gViewOtSize + -2);
  }
  if (TrackSpec_gSpec.skystate != 0) {
    Hrz_BuildSky();
  }
  if (hrz_projchange != 0) {
    SetGeomScreen(hrz_projchange);
  }
  return;
}

/* end of hrzsku.cpp */
