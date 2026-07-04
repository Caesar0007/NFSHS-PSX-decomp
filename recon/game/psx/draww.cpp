/* game/psx/draww.cpp -- RECONSTRUCTED (NFS4 PSX world-geometry draw; C++ TU)
 *   35 fns: subdivision facets, world matrix/translation setup, night colour calc, DrawW_DrawQuad,
 *   object/chunk facet builders, object transforms, skidmarks, lines/spike-belt, anim timers, depth cue.
 *   GTE-heavy (142 cop2 stubs -> gte_ intrinsics). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "draww_externs.h"

/* ---- DrawW.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
char         offsets[8] = { 125, 125, 50, 15, -1, 125, 0, 0 };   /* @0x8013D828 */
MATRIX       gIdentTemplate = {4096, 0};   /* @0x8011f570 */
int          trk0[9][2] = { 410, 530, 800, 850, 800, 850, 800, 850, 800, 850, 800, 850, 815, 885, 815, 885, 815, 885 };   /* @0x8011f590 */
int          trk4[10][2] = { 300, 440, 300, 440, 300, 440, 300, 440, 300, 440, 705, 910, 705, 910, 705, 910, 705, 910, 705, 910 };   /* @0x8011f5d8 */
Draw_SubdivStruct gDiv;   /* @0x8011f628  (bss(zero)) */
int          animation_timer[12];   /* @0x8011f718  (bss(zero)) */
ChunkObjectInfo gChunkObjInfo;   /* @0x8011f748  (bss(zero)) */
CCOORD16     gVertex3d[160];   /* @0x8011f760  (bss(zero)) */
int          stackSpeedUpEnbabledFlag;   /* @0x8013d81c  (bss(zero)) */
char         goffsets[8] = { 125, 125, 50, 15, -1, 125, 0, 0 };   /* @0x8013d820 */
u_long       gWSavePtr;   /* @0x8013d830  (bss(zero)) */
int          gSD_gt4counter;   /* @0x8013d834  (bss(zero)) */
int          gSD_gt3counter;   /* @0x8013d838  (bss(zero)) */
DRender_tView *gVi;   /* @0x8013d83c  (bss(zero)) */

/* ---- DrawW-owned scratch/state globals -- lost-symbols (Ghidra-named, NOT in SYM; .bss zero).
   draww.cpp is canonical owner of the DrawW_/DrawWTrough_ namespace; consumers extern these. ---- */
int    DrawW_gChunkGeomRez, DrawW_gChunkInd, DrawW_gChunkObjFlag, DrawW_gChunkQuadCount;
int    DrawW_gChunkRelX, DrawW_gChunkRelY, DrawW_gChunkRelZ;
int    DrawW_gFog_init, DrawW_gGroupCount, DrawW_gMatID_tmp, DrawW_gNightFlags, DrawW_gNightTmpFlag;
int   *DrawW_gChunkStripBuf;
Group *DrawW_gChunkVtxBuf, *DrawW_gGroupPtr;
Track_tArtresource *DrawW_gInitialArtPtr;
Track_tMaterial    *DrawW_gMaterialLUT;
int    DrawW_gObjScratch_148, DrawWTrough_scratchVec[3];

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void DrawW_DivVertice(Draw_SVertex *v0,Draw_SVertex *v1,Draw_SVertex *v2);
void DrawW_LoadPrecVECTOR(Draw_SVertex *v,VECTOR *dv);
void DrawW_SetUpSubdividFacet(int face,Draw_tGiveShelbyMoreCache *sd);
void Night_NightCopCalc(VECTOR *v,short *idx);
void Night_NightCalc(VECTOR *v,short *idx,Draw_tGiveShelbyMoreCache *sd);
void DrawW_DrawQuad(Draw_tGiveShelbyMoreCache *sd,Trk_Quad *inQuad);
void DrawW_kCtrlWorld_High(Draw_tGiveShelbyMoreCache *sd);
void DrawW_StripDraw_High(Draw_tGiveShelbyMoreCache *sd);
void DrawW_DoTrough(DRender_tView *Vi,tBuildEntry *buildList);
void DrawW_WorldSetUpMatrix(matrixtdef *m,MATRIX *mat);
void DrawW_WorldSetUpTranslation(coorddef *t,MATRIX *mat);
void DrawW_ResetAnimationTimer(void);
int DrawW_GetAnimationTime(Trk_AnimateInst *animInst);
void DrawW_SetAnimationTime(Trk_AnimateInst *animInst,int *table,int time);
void DrawW_DoObjectAnimations(void);
int DrawW_BuildObjectFacets(DRender_tView *Vi,ChunkObjectInfo *gObjInfo);
int DrawW_BuildCustomObjectFacets(DRender_tView *Vi,Draw_DCache *sd,Trk_SimObject *simObjs,Group *group,int zClipSq);
int DrawObjectSimple(DRender_tView *Vi,Draw_DCache *sd,Trk_ObjectDef *objDef,coorddef *pCp,int offset);
int DrawW_BuildChunkObjectFacets(DRender_tView *Vi,ChunkObjectInfo *gObjInfo);
void * ObjectClipped(DRender_tView *Vi,int ind,coorddef *pCp,Draw_tGiveShelbyMoreCache *sd);
void DrawW_DoObjects(DRender_tView *Vi,tBuildEntry *buildList);
int Draw_CircleClip(coorddef *pt1,coorddef *pt2,int r);
void Draw_kCtrlSkidmark(Draw_tCtrlSkidmark *fskid);
void DrawW_SetUpSubdividFacet_Line(Draw_tGiveShelbyMoreCache *sd);
void DrawW_OnyxLinePrim(CCOORD16 *geomVertices,Trk_Line *lineQuad,int count,Draw_tGiveShelbyMoreCache *sd);
void DrawW_BuildChunkCenterLineFacets(Chunk *chunkDat,Group *group,Draw_tGiveShelbyMoreCache *sd,COORD16 *trans);
void DrawW_DoLines(DRender_tView *Vi,tBuildEntry *buildList,Draw_DCache *sd);
void DrawW_BuildSpikeBelt(DRender_tView *Vi,int scale,Draw_DCache *sd);
void DepthCue_Init(void);


/* ---- DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:235-282] SLD-VERIFIED ---- */
void DrawW_AddSubdividPrimGT4(POLY_GT4 *prim,Draw_SVertex *v0,Draw_SVertex *v1,Draw_SVertex *v2,Draw_SVertex *v3,
               Draw_tGiveShelbyMoreCache *sd)

{
  u_int c0,c1,c2,c3, p0,p1,p2,p3;
  u_short t0,t1,t2,t3;
  u_char code;
  u_short tpage, clut;

  /* MATCH: field-fusion + load-4/store-4 (see GT3).  POLY_GT4 stores v2 in slot 3 (+0x28)
     and v3 in slot 2 (+0x1C) -- the screen-quad vertex order. */
  *(u_char *)((int)&prim->tag + 3) = 0xc;
  c0 = *(u_int *)&v0->r;  c1 = *(u_int *)&v1->r;  c2 = *(u_int *)&v2->r;  c3 = *(u_int *)&v3->r;
  *(u_int *)&prim->r0 = c0;  *(u_int *)&prim->r1 = c1;  *(u_int *)&prim->r3 = c2;  *(u_int *)&prim->r2 = c3;
  p0 = *(u_int *)&v0->dvx;  p1 = *(u_int *)&v1->dvx;  p2 = *(u_int *)&v2->dvx;  p3 = *(u_int *)&v3->dvx;
  *(u_int *)&prim->x0 = p0;  *(u_int *)&prim->x1 = p1;  *(u_int *)&prim->x3 = p2;  *(u_int *)&prim->x2 = p3;
  t0 = *(u_short *)&v0->u;  t1 = *(u_short *)&v1->u;  t2 = *(u_short *)&v2->u;  t3 = *(u_short *)&v3->u;
  *(u_short *)&prim->u0 = t0;  *(u_short *)&prim->u1 = t1;  *(u_short *)&prim->u3 = t2;  *(u_short *)&prim->u2 = t3;
  code = (sd->GT4Prim).code;  tpage = (sd->GT4Prim).tpage;  clut = (sd->GT4Prim).clut;
  prim->code = code;  prim->tpage = tpage;  prim->clut = clut;
  return;
}

/* ---- DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:316-357] SLD-VERIFIED ---- */
void DrawW_AddSubdividPrimGT3(POLY_GT3 *prim,Draw_SVertex *v0,Draw_SVertex *v1,Draw_SVertex *v2,
               Draw_tGiveShelbyMoreCache *sd)

{
  u_int c0,c1,c2, p0,p1,p2;
  u_short t0,t1,t2;
  u_char code;
  u_short tpage, clut;

  /* MATCH: field-fusion + load-3/store-3 -- the oracle copies each vertex's RGBA as one
     32-bit word (v+0xC), XY as one word (v+0x8), UV as one halfword (v+0x6).  Loading all
     three vertices into SEPARATE temps before storing avoids the load-delay nop that
     `lw v0;nop;sw v0` (single-reg reuse) emits per copy. */
  *(u_char *)((int)&prim->tag + 3) = 9;
  c0 = *(u_int *)&v0->r;  c1 = *(u_int *)&v1->r;  c2 = *(u_int *)&v2->r;
  *(u_int *)&prim->r0 = c0;  *(u_int *)&prim->r1 = c1;  *(u_int *)&prim->r2 = c2;
  p0 = *(u_int *)&v0->dvx;  p1 = *(u_int *)&v1->dvx;  p2 = *(u_int *)&v2->dvx;
  *(u_int *)&prim->x0 = p0;  *(u_int *)&prim->x1 = p1;  *(u_int *)&prim->x2 = p2;
  t0 = *(u_short *)&v0->u;  t1 = *(u_short *)&v1->u;  t2 = *(u_short *)&v2->u;
  *(u_short *)&prim->u0 = t0;  *(u_short *)&prim->u1 = t1;  *(u_short *)&prim->u2 = t2;
  code = (sd->GT4Prim).code;  tpage = (sd->GT4Prim).tpage;  clut = (sd->GT4Prim).clut;
  prim->code = code;  prim->tpage = tpage;  prim->clut = clut;
  return;
}

/* ---- DrawW_DivVertice__FP12Draw_SVertexN20  [DRAWW.CPP:387-398] SLD-VERIFIED ---- */
void DrawW_DivVertice(Draw_SVertex *v0,Draw_SVertex *v1,Draw_SVertex *v2)

{
  v0->vx = (short)((int)v1->vx + (int)v2->vx + 1 >> 1);
  v0->vy = (short)((int)v1->vy + (int)v2->vy + 1 >> 1);
  v0->vz = (short)((int)v1->vz + (int)v2->vz + 1 >> 1);
  v0->u = (u_char)((int)((u_int)v1->u + (u_int)v2->u + 1) >> 1);
  v0->v = (u_char)((int)((u_int)v1->v + (u_int)v2->v + 1) >> 1);
  v0->r = (u_char)((int)((u_int)v1->r + (u_int)v2->r) >> 1);
  v0->g = (u_char)((int)((u_int)v1->g + (u_int)v2->g) >> 1);
  v0->b = (u_char)((int)((u_int)v1->b + (u_int)v2->b) >> 1);
  return;
}

/* ---- DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31  [DRAWW.CPP:402-418] SLD-VERIFIED ---- */
int DrawW_CalcSubdivision(Draw_tGiveShelbyMoreCache *sd,Draw_SVertex *v0,Draw_SVertex *v1,Draw_SVertex *v2,
              Draw_SVertex *v3)

{
  int iVar1;
  int z0;
  int iVar2;
  int z1;
  int z2;
  int z3;
  
  iVar2 = (int)v0->vz;
  if ((int)v1->vz < (int)v0->vz) {
    iVar2 = (int)v1->vz;
  }
  if (v2->vz < iVar2) {
    iVar2 = (int)v2->vz;
  }
  if (v3->vz < iVar2) {
    iVar2 = (int)v3->vz;
  }
  iVar2 = iVar2 + sd->offsubdivid;
  if (0x800 < iVar2) {
    return 0;
  }
  if (iVar2 < 0x501) {
    iVar1 = 2;
    if (iVar2 < 0x201) {
      return 3;
    }
  }
  else {
    iVar1 = 1;
  }
  return iVar1;
}

/* ---- DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss  [DRAWW.CPP:425-590] SLD-VERIFIED ---- */
void DrawW_SubdividFacet(Draw_tGiveShelbyMoreCache *sd,int l,Draw_SVertex *v0,Draw_SVertex *v1,
               Draw_SVertex *v2,Draw_SVertex *v3,short n,short subDivide)

{
  int midX_01;
  int newVert_y0;
  int newVert_y1;
  u_int tu1;
  int iVar1;
  int v0_00;
  int newVert_p;
  int newVert_p2;
  u_int *tp2;
  int subFacet_p;
  int otz;
  int subOtz_local;
  Draw_SVertex *v4;
  int v0_01;
  POLY_GT4 *prim;
  int l_00;
  Draw_SVertex *v5;
  int v0_02;
  Draw_SVertex *v7;
  int v0_03;
  Draw_SVertex *v6;
  int v0_04;
  short n_00;
  int tD13;
  int loc_68;
  int loc_64;
  int loc_60;
  int loc_5c;
  int flag;
  int loc_54;
  int loc_50;
  int loc_4c;
  int iStack_48;
  long bfct;
  short loc_40;
  short loc_38;
  Draw_SVertex *v8;
  short ts1;
  int tu2;
  u_char *tp4;
  short ts2;
  int tu3;
  u_char *tp5;
  u_char *tp3;
  u_char *prim_00;
  
  ts1 = (sd->head).clipW;
  if ((((ts1 < v0->dvx) && (ts1 < v1->dvx)) && (ts1 < v2->dvx)) && (ts1 < v3->dvx)) {
    return;
  }
  if (((v0->dvx < 0) && (v1->dvx < 0)) && ((v2->dvx < 0 && (v3->dvx < 0)))) {
    return;
  }
  ts2 = (sd->head).clipH;
  if (((ts2 < v0->dvy) && (ts2 < v1->dvy)) && ((ts2 < v2->dvy && (ts2 < v3->dvy)))) {
    return;
  }
  if ((((v0->dvy < 0) && (v1->dvy < 0)) && (v2->dvy < 0)) && (v3->dvy < 0)) {
    return;
  }
  if (((v0->vz < 0) && (v1->vz < 0)) && ((v2->vz < 0 && (v3->vz < 0)))) {
    return;
  }
  midX_01 = DrawW_CalcSubdivision(sd,v0,v1,v2,v3);
  if (l < midX_01) {
  n_00 = n + 5;
  v0_01 = (int)&gDiv.v[0].vx + ((int)((u_int)(u_short)n << 0x10) >> 0xc);
  v0_02 = (int)&gDiv.v[0].vx + ((int)((u_int)(u_short)(n + 1) << 0x10) >> 0xc);
  v0_04 = (int)&gDiv.v[0].vx + ((int)((u_int)(u_short)(n + 2) << 0x10) >> 0xc);
  v0_03 = (int)&gDiv.v[0].vx + ((int)((u_int)(u_short)(n + 3) << 0x10) >> 0xc);
  v0_00 = (int)&gDiv.v[0].vx + ((int)((u_int)(u_short)(n + 4) << 0x10) >> 0xc);
  DrawW_DivVertice((Draw_SVertex *)v0_01,v0,v1);
gte_ldv0((int *)(v0_01));
  gte_rtps();
  DrawW_DivVertice((Draw_SVertex *)v0_02,v1,v2);
gte_stflg(&flag);
  if (flag < 0) {
    ((Draw_SVertex *)v0_01)->a = '\x01';
  }
  else {
    ((Draw_SVertex *)v0_01)->a = '\0';
  }
gte_swc2(0xe,((char *)&CF_DVLC + 0x1));
gte_ldv0((int *)(v0_02));
  gte_rtps();
  DrawW_DivVertice((Draw_SVertex *)v0_04,v2,v3);
gte_stflg(&loc_54);
  if (loc_54 < 0) {
    ((Draw_SVertex *)v0_02)->a = '\x01';
  }
  else {
    ((Draw_SVertex *)v0_02)->a = '\0';
  }
gte_swc2(0xe,((char *)&CF_DVLC + 0x1));
gte_ldv0((int *)(v0_04));
  gte_rtps();
  DrawW_DivVertice((Draw_SVertex *)v0_03,v3,v0);
gte_stflg(&loc_50);
  if (loc_50 < 0) {
    ((Draw_SVertex *)v0_04)->a = '\x01';
  }
  else {
    ((Draw_SVertex *)v0_04)->a = '\0';
  }
gte_swc2(0xe,((char *)&CF_DVLC + 0x1));
gte_ldv0((int *)(v0_03));
  gte_rtps();
  DrawW_DivVertice((Draw_SVertex *)v0_00,v0,v2);
gte_stflg(&loc_4c);
  if (loc_4c < 0) {
    ((Draw_SVertex *)v0_03)->a = '\x01';
  }
  else {
    ((Draw_SVertex *)v0_03)->a = '\0';
  }
gte_swc2(0xe,((char *)&CF_DVLC + 0x1));
  iVar1 = v0_00;
gte_ldv0((int *)(iVar1));
  gte_rtps();
gte_stflg(&iStack_48);
  if (iStack_48 < 0) {
    *(u_char *)(iVar1 + 0xf) = 1;
  }
  else {
    ((Draw_SVertex *)v0_00)->a = '\0';
  }
  if (sd->doublelayer == 0) goto DrawWSubdiv_recurse;
  (sd->GT4Prim).code = (sd->GT4Prim).code & 0xf7;
  tp3 = Render_gPacketPtr;
  subOtz_local = sd->otz + 8;
  if (v0->a == '\0') {
    if (v1->a == '\0') {
      if (((Draw_SVertex *)v0_01)->a == '\0') {
        newVert_p = subOtz_local * 4 + (int)Render_gPalettePtr;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)newVert_p & 0xffffff;
        newVert_y0 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x28;
        *(u_int *)newVert_p = *(u_int *)newVert_p & 0xff000000 | newVert_y0;
        DrawW_AddSubdividPrimGT3((POLY_GT3 *)tp3,v0,v1,(Draw_SVertex *)v0_01,sd);
      }
      goto DrawWSubdiv_testV1;
    }
DrawWSubdiv_testV2:
    tp5 = Render_gPacketPtr;
    if (v2->a != '\0') goto DrawWSubdiv_testV3;
    if (v3->a == '\0') {
      if (((Draw_SVertex *)v0_04)->a == '\0') {
        tp2 = (u_int *)(Render_gPalettePtr + subOtz_local * 4);
        *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *tp2 & 0xffffff;
        tu1 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x28;
        *tp2 = *tp2 & 0xff000000 | tu1;
        DrawW_AddSubdividPrimGT3((POLY_GT3 *)tp5,v2,v3,(Draw_SVertex *)v0_04,sd);
      }
      goto DrawWSubdiv_testV3;
    }
  }
  else {
DrawWSubdiv_testV1:
    tp4 = Render_gPacketPtr;
    if (v1->a != '\0') goto DrawWSubdiv_testV2;
    if (v2->a == '\0') {
      if (((Draw_SVertex *)v0_02)->a == '\0') {
        newVert_p2 = subOtz_local * 4 + (int)Render_gPalettePtr;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)newVert_p2 & 0xffffff;
        newVert_y1 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x28;
        *(u_int *)newVert_p2 = *(u_int *)newVert_p2 & 0xff000000 | newVert_y1;
        DrawW_AddSubdividPrimGT3((POLY_GT3 *)tp4,v1,v2,(Draw_SVertex *)v0_02,sd);
      }
      goto DrawWSubdiv_testV2;
    }
DrawWSubdiv_testV3:
    prim_00 = Render_gPacketPtr;
    if (((v3->a == '\0') && (v0->a == '\0')) && (((Draw_SVertex *)v0_03)->a == '\0')) {
      tp2 = (u_int *)(Render_gPalettePtr + subOtz_local * 4);
      *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *tp2 & 0xffffff;
      tu1 = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x28;
      *tp2 = *tp2 & 0xff000000 | tu1;
      DrawW_AddSubdividPrimGT3((POLY_GT3 *)prim_00,v3,v0,(Draw_SVertex *)v0_03,sd);
    }
  }
  (sd->GT4Prim).code = (sd->GT4Prim).code | 8;
DrawWSubdiv_recurse:
  l_00 = l + 1;
  tD13 = v0_00;
gte_swc2(0xe,((char *)v2 + 0xc));
  DrawW_SubdividFacet(sd,l_00,v0,(Draw_SVertex *)v0_01,(Draw_SVertex *)tD13,(Draw_SVertex *)v0_03,n_00,
             subDivide);
  DrawW_SubdividFacet(sd,l_00,(Draw_SVertex *)v0_01,v1,(Draw_SVertex *)v0_02,(Draw_SVertex *)v0_00,n_00,
             subDivide);
  DrawW_SubdividFacet(sd,l_00,(Draw_SVertex *)v0_00,(Draw_SVertex *)v0_02,v2,(Draw_SVertex *)v0_04,n_00,
             subDivide);
  DrawW_SubdividFacet(sd,l_00,(Draw_SVertex *)v0_03,(Draw_SVertex *)v0_00,(Draw_SVertex *)v0_04,v3,n_00,
             subDivide);
  return;
  }
    if (subDivide != 0) {
      iVar1 = 1;
      gte_ldsxy3(*(int *)&v0->dvx,*(int *)&v1->dvx,*(int *)&v2->dvx);
      gte_nclip();
gte_swc2(0x18,&bfct);
      if ((sd->head).mirror == iVar1) {
        bfct = -bfct;
      }
      if (bfct < 0) {
        gte_ldsxy3(*(int *)&v0->dvx,*(int *)&v2->dvx,*(int *)&v3->dvx);
        gte_nclip();
gte_swc2(0x18,&bfct);
        if ((sd->head).mirror == iVar1) {
          bfct = -bfct;
        }
        if (bfct < 0) {
          return;
        }
      }
    }
    prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;
    subFacet_p = (int)(sd->head).cprim.LastPrim;
    iVar1 = subFacet_p + sd->otz * 4;
    (sd->head).cprim.PrimPtr = (char *)(prim + 1);
    tu1 = iVar1 + 2;
    tu2 = tu1 & 3;
    prim->tag = (u_long *)
                ((*(int *)(tu1 - tu2) << (3 - tu2) * 8 |
                 (u_int)(prim + 1) & 0xffffffffU >> (tu2 + 1) * 8) >> 8 | 0xc000000);
    tu1 = iVar1 + 2;
    tu3 = tu1 & 3;
    tp2 = (u_int *)(tu1 - tu3);
    *tp2 = *tp2 & -1 << (tu3 + 1) * 8 | (u_int)((int)prim << 8) >> (3 - tu3) * 8;
    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);
    return;
}

/* ---- DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR  [DRAWW.CPP:593-606] SLD-VERIFIED ---- */
void DrawW_LoadPrecVECTOR(Draw_SVertex *v,VECTOR *dv)

{
  int x;
  int y;
  int z;

  /* MATCH (§3.12 #15b split-load): load all three FIRST, then shift-assign -- this
     groups the three shifts (vx<<2, vy<<18, vz<<2) the way the oracle does, instead of
     fusing load+shift (which schedules vz's sll after the sw). Mask AFTER the shift;
     pack vx:vy as one word. Form from DataPlusProgram decomp.me/scratch/ODvI7 (score 0). */
  x = dv->vx;
  y = dv->vy;
  z = dv->vz;
  x <<= 2;
  y <<= 0x12;
  z <<= 2;
  *(u_int *)&v->vx = y | (x & 0xffffU);
  v->vz = (short)z;
  return;
}

/* ---- DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:612-696] SLD-VERIFIED ---- */
void DrawW_SetUpSubdividFacet(int face,Draw_tGiveShelbyMoreCache *sd)

{
  long t0;
  long t1;
  long t2;
  long t3;
  short sVar1;
  short sVar2;
  short sVar3;
  short sVar4;
  short sVar5;
  short sVar6;
  short sVar7;
  u_char uVar8;
  u_char uVar9;
  u_char uVar10;
  u_char uVar11;
  u_char uVar12;
  u_char uVar13;
  u_char uVar14;
  u_char uVar15;
  u_char uVar16;
  u_char uVar17;
  u_char uVar18;
  u_char uVar19;
  u_char uVar20;
  u_char uVar21;
  u_char uVar22;
  short u3;
  short u0;
  short u1;
  short u2;
  POLY_GT4 *prim;
  POLY_GT4 *pPVar23;
  Draw_SVertex *v2;
  Draw_SVertex *v3;
  Draw_SVertex *v1;
  Draw_SVertex *v0;
  
  DrawW_LoadPrecVECTOR(&sd->v0,&sd->tVn0);
  DrawW_LoadPrecVECTOR(&sd->v1,&sd->tVn1);
  DrawW_LoadPrecVECTOR(&sd->v2,&sd->tVn2);
  DrawW_LoadPrecVECTOR(&sd->v3,&sd->tVn3);
  pPVar23 = &sd->GT4Prim;
  sVar1 = (sd->GT4Prim).y0;
  sVar2 = (sd->GT4Prim).x1;
  sVar3 = (sd->GT4Prim).y1;
  sVar4 = (sd->GT4Prim).x3;
  sVar5 = (sd->GT4Prim).y3;
  sVar6 = (sd->GT4Prim).x2;
  sVar7 = (sd->GT4Prim).y2;
  (sd->v0).dvx = (sd->GT4Prim).x0;
  (sd->v0).dvy = sVar1;
  (sd->v1).dvx = sVar2;
  (sd->v1).dvy = sVar3;
  (sd->v2).dvx = sVar4;
  (sd->v2).dvy = sVar5;
  (sd->v3).dvx = sVar6;
  (sd->v3).dvy = sVar7;
  if ((sd->tVn0).vz < 0x140) {
gte_ldv0(((char *)sd + 0x14c));
    gte_rtps();
gte_swc2(0xe,((char *)sd + 0x154));
  }
  if ((sd->tVn1).vz < 0x140) {
gte_ldv0(((char *)sd + 0x15c));
    gte_rtps();
gte_swc2(0xe,((char *)sd + 0x164));
  }
  if ((sd->tVn2).vz < 0x140) {
gte_ldv0(((char *)sd + 0x16c));
    gte_rtps();
gte_swc2(0xe,((char *)sd + 0x174));
  }
  if ((sd->tVn3).vz < 0x140) {
gte_ldv0(((char *)sd + 0x17c));
    gte_rtps();
gte_swc2(0xe,((char *)sd + 0x184));
  }
  uVar8 = pPVar23->g0;
  uVar9 = pPVar23->b0;
  uVar10 = pPVar23->code;
  uVar11 = pPVar23->r1;
  uVar12 = pPVar23->g1;
  uVar13 = pPVar23->b1;
  uVar14 = pPVar23->p1;
  uVar15 = pPVar23->r3;
  uVar16 = pPVar23->g3;
  uVar17 = pPVar23->b3;
  uVar18 = pPVar23->p3;
  uVar19 = pPVar23->r2;
  uVar20 = pPVar23->g2;
  uVar21 = pPVar23->b2;
  uVar22 = pPVar23->p2;
  (sd->v0).r = pPVar23->r0;
  (sd->v0).g = uVar8;
  (sd->v0).b = uVar9;
  (sd->v0).a = uVar10;
  (sd->v1).r = uVar11;
  (sd->v1).g = uVar12;
  (sd->v1).b = uVar13;
  (sd->v1).a = uVar14;
  (sd->v2).r = uVar15;
  (sd->v2).g = uVar16;
  (sd->v2).b = uVar17;
  (sd->v2).a = uVar18;
  (sd->v3).r = uVar19;
  (sd->v3).g = uVar20;
  (sd->v3).b = uVar21;
  (sd->v3).a = uVar22;
  uVar8 = pPVar23->v0;
  uVar9 = pPVar23->u1;
  uVar10 = pPVar23->v1;
  uVar13 = pPVar23->u2;
  uVar14 = pPVar23->v2;
  uVar11 = pPVar23->u3;
  uVar12 = pPVar23->v3;
  (sd->v0).u = pPVar23->u0;
  (sd->v0).v = uVar8;
  (sd->v1).u = uVar9;
  (sd->v1).v = uVar10;
  (sd->v2).u = uVar11;
  (sd->v2).v = uVar12;
  (sd->v3).u = uVar13;
  (sd->v3).v = uVar14;
  sVar1 = (sd->v0).dvx;
  (sd->v0).a = '\0';
  if (sVar1 < 0x3e9) {
    sVar2 = (sd->v0).dvy;
    if ((((1000 < sVar2) || (sVar1 < -1000)) || (sVar2 < -1000)) || ((sd->v0).vz < 0x65))
    goto DrW_SubSetup_v0Alpha;
  }
  else {
DrW_SubSetup_v0Alpha:
    (sd->v0).a = '\x01';
  }
  sVar1 = (sd->v1).dvx;
  (sd->v1).a = '\0';
  if (sVar1 < 0x3e9) {
    sVar2 = (sd->v1).dvy;
    if (((1000 < sVar2) || (sVar1 < -1000)) || ((sVar2 < -1000 || ((sd->v1).vz < 0x65))))
    goto DrW_SubSetup_v1Alpha;
  }
  else {
DrW_SubSetup_v1Alpha:
    (sd->v1).a = '\x01';
  }
  sVar1 = (sd->v2).dvx;
  (sd->v2).a = '\0';
  if (sVar1 < 0x3e9) {
    sVar2 = (sd->v2).dvy;
    if (((1000 < sVar2) || (sVar1 < -1000)) || ((sVar2 < -1000 || ((sd->v2).vz < 0x65))))
    goto DrW_SubSetup_v2Alpha;
  }
  else {
DrW_SubSetup_v2Alpha:
    (sd->v2).a = '\x01';
  }
  sVar1 = (sd->v3).dvx;
  (sd->v3).a = '\0';
  if (sVar1 < 0x3e9) {
    sVar2 = (sd->v3).dvy;
    if ((((sVar2 < 0x3e9) && (-0x3e9 < sVar1)) && (-0x3e9 < sVar2)) && (100 < (sd->v3).vz))
    goto DrW_SubSetup_callSubdiv;
  }
  (sd->v3).a = '\x01';
DrW_SubSetup_callSubdiv:
  DrawW_SubdividFacet(sd,0,&sd->v0,&sd->v1,&sd->v2,&sd->v3,0,(u_short)(face == 0));
  return;
}

/* ---- Night_NightCopCalc__FP6VECTORPs  [DRAWW.CPP:711-744] SLD-VERIFIED ---- */
void Night_NightCopCalc(VECTOR *v,short *idx)

{
  int z;
  int neg;
  int x;

  /* MATCH: bounds via (u_int)(z+0x7FF)<0xFFF (Ghidra's [0][0][0xff]+7 idiom); sign as a
     bgez branch (neg flag) not a srl-31; lbu+sra via (int)(u_char) (no u_int -> unsigned). */
  z = v->vz;
  x = v->vx;
  if (((u_int)(z + 0x7ff) < 0xfff) && ((u_int)(x + 0x3ff) < 0x7ff)) {
    neg = 0;
    if (z < 0) {
      z = -z;
      neg = 1;
    }
    *idx = (u_short)(*Night_gCopColor[neg])[(short)*idx]
                     [(int)(u_char)Night_gNightTbl[(z >> 5) * 0x40 + ((x + 0x400) >> 5)] >> 1];
  }
  return;
}

/* ---- Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:750-788] SLD-VERIFIED ---- */
void Night_NightCalc(VECTOR *v,short *idx,Draw_tGiveShelbyMoreCache *sd)

{
  int index;
  int xdist;
  u_char bVar1;
  int lookup;
  int iVar2;
  int x;
  int iVar3;
  int iVar4;
  int z;
  int znear;
  int iVar5;
  int zfar;
  
  bVar1 = sd->night_ZDistShift;
  iVar4 = v->vz;
  iVar5 = (int)sd->night_ZNear;
  if (sd->night_DrawLightning != '\0') {
    *idx = (u_short)(*Night_gWeatherLightingTable[sd->night_LightningType])[*idx];
  }
  if ((iVar5 < iVar4) && (iVar4 < iVar5 + (1 << (bVar1 + 6 & 0x1f)))) {
    iVar3 = v->vx;
    iVar2 = 1 << (sd->night_XDistShift + 5 & 0x1f);
    if ((-iVar2 < iVar3) && (iVar3 < iVar2)) {
      *idx = (u_short)(*Night_gCurrentNightColor)[*idx]
                     [(u_char)Night_gNightTbl
                            [(iVar4 - iVar5 >> (sd->night_ZDistShift & 0x1f)) * 0x40 +
                             (iVar3 + iVar2 >> (sd->night_XDistShift & 0x1f))]];
    }
  }
  return;
}

/* ---- DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32  [DRAWW.CPP:802-894] SLD-VERIFIED ---- */
void DrawW_NightColorCalc(Draw_tGiveShelbyMoreCache *sd,POLY_GT4 *prim,CCOORD16 *vt0,CCOORD16 *vt1,
               CCOORD16 *vt2,CCOORD16 *vt3)
{
  /* @0x800C609C, 0x45C bytes -- GTE night / cop vertex-colour transform.
   * Canonical PsyQ inline GTE macros (../../lib/psx_gte.h): each vertex is loaded
   * (gte_ldv0), rotated (gte_rt = mvmva 1,0,0,0,0) and its lower MAC1-3 stored
   * (gte_stlvnl) into one shared temp0 buffer; Night_NightCalc/NightCopCalc consume
   * temp0 while the NEXT vertex rotates (software-pipelined, as in the handwritten
   * oracle). Vertex colours come from Chunk_lightTable[vtN->light] as word stores;
   * the quad's verts 2 and 3 are cross-fed (vt3 -> slot2, vt2 -> slot3). */
  VECTOR temp0;
  u_long CVar12;
  CVECTOR *lt;

  if (sd->light == -1) {
    if ((sd->nightFlags & 1U) != 0) {
      gte_SetRotMatrix((char *)sd + 0x34);
      gte_SetTransMatrix((char *)sd + 0x34);
      gte_ldv0(vt0);
      gte_rt();
      gte_stlvnl(&temp0);
      gte_ldv0(vt1);
      gte_rt();
      Night_NightCalc(&temp0, &vt0->light, sd);
      gte_stlvnl(&temp0);
      gte_ldv0(vt2);
      gte_rt();
      Night_NightCalc(&temp0, &vt1->light, sd);
      gte_stlvnl(&temp0);
      gte_ldv0(vt3);
      gte_rt();
      Night_NightCalc(&temp0, &vt2->light, sd);
      gte_stlvnl(&temp0);
      Night_NightCalc(&temp0, &vt3->light, sd);
    }
    if ((sd->nightFlags & 2U) != 0) {
      gte_SetRotMatrix((char *)sd + 0x54);
      gte_SetTransMatrix((char *)sd + 0x54);
      gte_ldv0(vt0);
      gte_rt();
      gte_stlvnl(&temp0);
      gte_ldv0(vt1);
      gte_rt();
      Night_NightCopCalc(&temp0, &vt0->light);
      gte_stlvnl(&temp0);
      gte_ldv0(vt2);
      gte_rt();
      Night_NightCopCalc(&temp0, &vt1->light);
      gte_stlvnl(&temp0);
      gte_ldv0(vt3);
      gte_rt();
      Night_NightCopCalc(&temp0, &vt2->light);
      gte_stlvnl(&temp0);
      Night_NightCopCalc(&temp0, &vt3->light);
    }
    lt = Chunk_lightTable;
    *(u_long *)&prim->r0 = *(u_long *)&lt[vt0->light];
    *(u_long *)&prim->r1 = *(u_long *)&lt[vt1->light];
    *(u_long *)&prim->r2 = *(u_long *)&lt[vt3->light];
    CVar12 = *(u_long *)&lt[vt2->light];
  }
  else {
    if ((sd->nightFlags & 1U) != 0) {
      gte_SetRotMatrix((char *)sd + 0x34);
      gte_SetTransMatrix((char *)sd + 0x34);
      gte_ldv0(vt0);
      gte_rt();
      gte_stlvnl(&temp0);
      Night_NightCalc(&temp0, &sd->light, sd);
    }
    if ((sd->nightFlags & 2U) != 0) {
      gte_SetRotMatrix((char *)sd + 0x54);
      gte_SetTransMatrix((char *)sd + 0x54);
      gte_ldv0(vt0);
      gte_rt();
      gte_stlvnl(&temp0);
      Night_NightCopCalc(&temp0, &sd->light);
    }
    CVar12 = *(u_long *)&Chunk_lightTable[sd->light];
    *(u_long *)&prim->r0 = CVar12;
    *(u_long *)&prim->r1 = CVar12;
    *(u_long *)&prim->r2 = CVar12;
  }
  *(u_long *)&prim->r3 = CVar12;
  gte_SetRotMatrix((char *)sd + 0x14);
  gte_SetTransMatrix((char *)sd + 0x14);
  return;
}

/* ---- DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad  [DRAWW.CPP:930-1297] SLD-VERIFIED ---- */
void DrawW_DrawQuad(Draw_tGiveShelbyMoreCache *sd,Trk_Quad *inQuad)

{
  int*z;
  int p1;
  int p2;
  int p3;
  int t2;
  short tx;
  short ty;
  short tz;
  long * dp0;
  long * dp1;
  long * dp2;
  int newIndex;
  DR_TWIN * aprim;
  int p0;
  u_long l1;
  u_long l2;
  u_long l3;
  int dU;
  short vert2_proj_x;
  u_long l0;
  int vertProj_p;
  short vert0_proj_x;
  short tu27;
  void *tp2;
  short vert1_proj_x;
  short tu28;
  short vert3_proj_x;
  u_int *tp1;
  short tu29;
  short tu30;
  int bfctResult;
  int tu24;
  int dV;
  int tu4;
  int ti5;
  u_int uVar3_00;
  short sVar1;
  short ts27;
  int iVar2;
  u_int uVar3;
  int depth_index;
  int primPtr;
  int depth_avg;
  int tC30;
  short ts31;
  int uVar7_00;
  int ti18;
  Track_tMaterial *currentQuadMat;
  int trk_mat_p;
  u_char d;
  int vert_y_pack;
  u_char c;
  int vert_x_pack;
  CCOORD16 *geomVertices;
  int geomVerts_p;
  short vert0_proj_y;
  short vert1_proj_y;
  short vert2_proj_y;
  short vert3_proj_y;
  int t1;
  short tu46;
  short tu47;
  short tu48;
  short tu49;
  int t3;
  int tp36;
  int zeroTransFlag;
  POLY_GT4 *prim;
  Draw_tPixMap *workPmx;
  int workPmx_p;
  int save_pre_otz;
  char flag;
  int doSubdivision;
  int face;
  int facetIdx;
  CCOORD16 vt0;
  CCOORD16 vt1;
  CCOORD16 vt2;
  CCOORD16 vt3;
  RECT r;
  long dvxy0;
  long dvxy1;
  long dvxy3;
  long dvxy2;
  long bfct;
  int depthcue;
  long a;
  long b;
  u_int uStack_28;
  long color;
  u_char bVar2;
  u_char tc3;
  u_char bVar4;
  int tu5;
  u_char bVar1;
  int tp6;
  u_char *tp20;
  u_char *p;
  u_char *tp18;
  u_char *tp19;
  int tu1;
  u_int tu2;
  u_int tu18;
  
  geomVerts_p = (int)sd->vertices;
  ts31 = (sd->trans).x;
  ts27 = (sd->trans).y;
  vert_x_pack = (int)*(u_char *)(((short *)inQuad) + 2);
  vert_y_pack = (int)*(u_char *)((int)((short *)inQuad) + 5);
  sVar1 = (sd->trans).z;
  vertProj_p = geomVerts_p + (u_int)*(u_char *)((int)((short *)inQuad) + 3) * 8;
  vt0.x = (short)*(u_int *)vertProj_p + ts31;
  vt0.y = (short)((u_int)*(u_int *)vertProj_p >> 0x10) + ts27;
  vt0.light = (short)((u_int)*(u_int *)(vertProj_p + 4) >> 0x10);
  vt0.z = (short)*(u_int *)(vertProj_p + 4) + sVar1;
gte_ldv0((int *)(&vt0));
  tp2 = (void *)(geomVerts_p + (*(u_char *)((int)((short *)inQuad) + 2) & 0xffU) * 8);
  gte_rtps_b();
  vt1.x = (short)*(u_int *)tp2 + ts31;
  vt1.y = (short)((u_int)*(u_int *)tp2 >> 0x10) + ts27;
  vt1.light = (short)((u_int)*(u_int *)((int)tp2 + 4) >> 0x10);
  vt1.z = (short)*(u_int *)((int)tp2 + 4) + sVar1;
gte_stlvnl(((char *)sd + 0x98));
gte_swc2(0xe,&dvxy0);
gte_ldv0((int *)(&vt1));
  tp1 = (u_int *)(geomVerts_p + (vert_y_pack & 0xffU) * 8);
  gte_rtps_b();
  tu18 = *tp1;
  tu2 = tp1[1];
  vt2.x = (short)tu18 + ts31;
  vt2.y = (short)((u_int)tu18 >> 0x10) + ts27;
  vt2.light = (short)((u_int)tu2 >> 0x10);
  vt2.z = (short)tu2 + sVar1;
gte_stlvnl(((char *)sd + 0xa8));
gte_ldv0((int *)(&vt2));
  tp1 = (u_int *)(geomVerts_p + (vert_x_pack & 0xffU) * 8);
  gte_rtps_b();
  tu18 = *tp1;
  tu2 = tp1[1];
  vt3.x = (short)tu18 + ts31;
  vt3.y = (short)((u_int)tu18 >> 0x10) + ts27;
  vt3.light = (short)((u_int)tu2 >> 0x10);
  vt3.z = (short)tu2 + sVar1;
gte_stlvnl(((char *)sd + 0xb8));
gte_ldv0((int *)(&vt3));
  gte_rtps();
gte_stlvnl(((char *)sd + 0xc8));
  if (((((((sd->tVn3).vx <= (sd->tVn3).vz) || ((sd->tVn0).vx <= (sd->tVn0).vz)) ||
        ((sd->tVn1).vx <= (sd->tVn1).vz)) || ((sd->tVn2).vx <= (sd->tVn2).vz)) &&
      (((-(sd->tVn3).vx <= (sd->tVn3).vz || (-(sd->tVn0).vx <= (sd->tVn0).vz)) ||
       ((-(sd->tVn1).vx <= (sd->tVn1).vz || (-(sd->tVn2).vx <= (sd->tVn2).vz)))))) &&
     (((-1 < (sd->tVn0).vz || (-1 < (sd->tVn1).vz)) ||
      ((-1 < (sd->tVn2).vz || (-1 < (sd->tVn3).vz)))))) {
    gte_avsz4_b();
    trk_mat_p = (int)(sd->materials + *((short *)inQuad));
    bVar2 = ((Track_tMaterial *)trk_mat_p)->flag;
gte_swc2(0x7,((char *)sd + 0x94));
    facetIdx = bVar2 >> 3 & 2;
gte_stsxy3(&dvxy1,&dvxy3,&dvxy2);
    bVar4 = 199 < sd->otz;
    if (((bVar2 >> 3 & 2) == 0) && ((bool)bVar4)) {
      gte_nclip_b();
gte_swc2(0x18,&bfct);
      iVar2 = 1;
      if ((sd->head).mirror == 1) {
        bfct = -bfct;
      }
      if (bfct < 0) {
gte_swc2(0x18,&bfct);
        if ((sd->head).mirror == iVar2) {
          bfct = -bfct;
        }
        if (bfct < 0) {
          return;
        }
      }
    }
gte_swc2(0x8,&depthcue);
    primPtr = (int)sd->artInfo->pPmx;
    workPmx_p = primPtr + *(short *)(trk_mat_p + 2) * 0x10;
    if ((((bVar2 & 8) != 0) && (sd->fogstate != '\0')) && ((int)sd->startfog <= sd->otz)) {
      workPmx_p = primPtr + ((int)*(short *)(trk_mat_p + 2) + (u_int)*(u_char *)(trk_mat_p + 1)) * 0x10
      ;
    }
    depth_avg = sd->otz;
    bfctResult = depth_avg >> 1;
    bVar1 = sd->offset == Draw_gMidGroundOtz;
    sd->otz = bfctResult;
    iVar2 = bfctResult;
    if ((bool)bVar1) {
      bfctResult = bfctResult << 2;
      iVar2 = depth_avg >> 4;
    }
    sd->otz = iVar2 + sd->offset;
    tp19 = Render_gPacketPtr;
    tp18 = Render_gPalettePtr;
    if ((0 < sd->otz) && (sd->otz <= Draw_gViewOtSize + -3)) {
      if ((bVar2 & 0x80) != 0) {
        r.w = 0;
        r.h = 0;
        r.x = 0;
        r.y = 0;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 |
             *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
        tu4 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0xc;
        *(u_int *)(tp18 + sd->otz * 4) = *(u_int *)(tp18 + sd->otz * 4) & 0xff000000 | tu4;
        SetTexWindow((DR_TWIN *)tp19,&r);
      }
      if ((bool)bVar4) {
        prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;
        tp36 = (int)(sd->head).cprim.LastPrim;
        iVar2 = tp36 + sd->otz * 4;
        (sd->head).cprim.PrimPtr = (char *)(prim + 1);
        uVar3_00 = iVar2 + 2;
        tu5 = uVar3_00 & 3;
        prim->tag = (u_long *)
                    ((*(int *)(uVar3_00 - tu5) << (3 - tu5) * 8 |
                     (u_int)(prim + 1) & 0xffffffffU >> (tu5 + 1) * 8) >> 8 | 0xc000000);
        uVar3_00 = iVar2 + 2;
        tu1 = uVar3_00 & 3;
        tp6 = uVar3_00 - tu1;
        *(u_int *)tp6 = *(u_int *)tp6 & -1 << (tu1 + 1) * 8 | (u_int)((int)prim << 8) >> (3 - tu1) * 8;
      }
      else {
        prim = &sd->GT4Prim;
      }
      prim->x0 = (u_short)dvxy0;
      prim->y0 = (*(u_short *)((u_char *)&(dvxy0) + 2));
      prim->x1 = (u_short)dvxy1;
      prim->y1 = (*(u_short *)((u_char *)&(dvxy1) + 2));
      prim->x2 = (u_short)dvxy2;
      prim->y2 = (*(u_short *)((u_char *)&(dvxy2) + 2));
      prim->x3 = (u_short)dvxy3;
      prim->y3 = (*(u_short *)((u_char *)&(dvxy3) + 2));
      if (sd->nightFlags == '\0') {
        gte_ldIR0(depthcue);
        if (sd->light == -1) {
          a = *(long *)(Chunk_lightTable + vt2.light);
          tC30 = (int)Chunk_lightTable;
gte_ldrgb(&a);
          gte_dpcs();
          uStack_28 = *(u_int *)(vt3.light * 4 + tC30);
          a = *(long *)(vt0.light * 4 + tC30);
          b = *(long *)(vt1.light * 4 + tC30);
gte_swc2(0x16,((char *)sd + 0x138));
gte_ldrgb3(&a,&b,&c);
          gte_dpct();
gte_swc2(0x14,((char *)sd + 0x114));
        }
        else {
          color = *(long *)(Chunk_lightTable + sd->light);
gte_swc2(0x15,((char *)sd + 0x120));
          gte_dpcs();
gte_swc2(0x16,((char *)sd + 0x12c));
          prim->r0 = (u_char)color;
          prim->g0 = ((u_char *)&(color))[1];
          prim->b0 = ((u_char *)&(color))[2];
          prim->code = ((u_char *)&(color))[3];
          prim->r1 = (u_char)color;
          prim->g1 = ((u_char *)&(color))[1];
          prim->b1 = ((u_char *)&(color))[2];
          prim->p1 = ((u_char *)&(color))[3];
          prim->r2 = (u_char)color;
          prim->g2 = ((u_char *)&(color))[1];
          prim->b2 = ((u_char *)&(color))[2];
          prim->p2 = ((u_char *)&(color))[3];
          prim->r3 = (u_char)color;
          prim->g3 = ((u_char *)&(color))[1];
          prim->b3 = ((u_char *)&(color))[2];
          prim->p3 = ((u_char *)&(color))[3];
        }
      }
      else {
        DrawW_NightColorCalc(sd,prim,&vt0,&vt1,&vt2,&vt3);
      }
      *(u_char *)((int)&prim->tag + 3) = 0xc;
      prim->code = *(u_char *)(workPmx_p + 0xe) | 0x3c;
      tu2 = *(u_int *)workPmx_p;
      tu18 = *(u_int *)(workPmx_p + 4);
      uVar3 = *(u_int *)(workPmx_p + 8);
      uVar7_00 = *(int *)(workPmx_p + 0xc);
      prim->u0 = (char)tu2;
      prim->v0 = (char)((u_int)tu2 >> 8);
      prim->clut = (short)((u_int)tu2 >> 0x10);
      prim->u1 = (char)tu18;
      prim->v1 = (char)((u_int)tu18 >> 8);
      prim->tpage = (short)((u_int)tu18 >> 0x10);
      prim->u2 = (char)uVar3;
      prim->v2 = (char)((u_int)uVar3 >> 8);
      prim->pad2 = (short)((u_int)uVar3 >> 0x10);
      prim->u3 = (char)uVar7_00;
      prim->v3 = (char)((u_int)uVar7_00 >> 8);
      prim->pad3 = (short)((u_int)uVar7_00 >> 0x10);
      if (prim->clut == 0xffff) {
        ti18 = (bfctResult - sd->startfog) * 0x10 >> ((int)sd->distfog & 0x1fU);
        if (ti18 < 0) {
          ti18 = 0;
        }
        else if (0xf < ti18) {
          ti18 = 0xf;
        }
        prim->clut = gClutDepth[*(u_short *)(workPmx_p + 10)][ti18];
      }
      if (!(bool)bVar4) {
        tc3 = sd->zeroGTETransFlag;
gte_SetRotMatrix(((char *)sd + 0x74));
        if (tc3 == 0) {
gte_SetTransMatrix(((char *)sd + 0x74));
        }
        if (stackSpeedUpEnbabledFlag == 0) {
          DrawW_SetUpSubdividFacet(facetIdx,sd);
        }
        else {
          tu24 = (int)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 0;
          gWSavePtr = tu24;
          DrawW_SetUpSubdividFacet(facetIdx,sd);
          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 1;
        }
gte_SetRotMatrix(((char *)sd + 0x14));
        if (tc3 == 0) {
gte_SetTransMatrix(((char *)sd + 0x14));
        }
      }
      p = Render_gPacketPtr;
      tp20 = Render_gPalettePtr;
      if ((bVar2 & 0x80) != 0) {
        iVar2 = (u_int)*(u_char *)(workPmx_p + 0xc) - (u_int)*(u_char *)workPmx_p;
        if (iVar2 < 0) {
          iVar2 = -iVar2;
        }
        ti5 = (u_int)*(u_char *)(workPmx_p + 0xd) - (u_int)*(u_char *)(workPmx_p + 1);
        if (ti5 < 0) {
          ti5 = -ti5;
        }
        r.w = (short)iVar2 + 1;
        r.h = (short)ti5 + 1;
        r.x = 0;
        r.y = 0;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 |
             *(u_int *)(Render_gPalettePtr + sd->otz * 4) & 0xffffff;
        uVar3_00 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0xc;
        *(u_int *)(tp20 + sd->otz * 4) = *(u_int *)(tp20 + sd->otz * 4) & 0xff000000 | uVar3_00;
        SetTexWindow((DR_TWIN *)p,&r);
      }
    }
  }
  return;
}

/* ---- DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:1302-1324] SLD-VERIFIED ---- */
void DrawW_kCtrlWorld_High(Draw_tGiveShelbyMoreCache *sd)

{
  /* MATCH: SYM (nfs4-f-v3.txt @0x800C6E38) names `numQuads` (reg $s0) and `pquad` (reg
     $s1, PTR Trk_Quad size 6); `sd` REGPARM lives in $s2. frame mask 0x800f0000 = ra+s0+
     s1+s2+s3 (FOUR saved regs) -- oracle's $s3 is a genuine dedicated `-1` sentinel local
     (materialized lazily: `li v0,-1` up front for the guard-check, then copied into `s3`
     only in the guard-branch's delay slot, once we know the loop runs >=1 time).
     BUG FIX (was a real correctness bug, not just a near-miss): `pquad` was never
     advanced -- every call drew the SAME quad. Oracle's `addiu $s1,$s1,0x6`
     (sizeof(Trk_Quad)) sits INSIDE the if-taken path, right after the DrawW_DrawQuad
     call -- pquad only advances when a quad is actually drawn.
     NEAR-MISS FLOOR (12 diffs, down from 34, ours 32 == oracle 32 insns): this do-while
     + explicit `sentinel` local reproduces the oracle's control-flow/frame/sentinel-
     lifetime exactly; residual is a register-CLASS choice for the raw `sd->quadCount`
     byte-load (oracle loads it straight into $s0, ours stages it through $v0 first) --
     tried splitting the load/decrement into two statements (frees $s0 for the load, but
     wrecks the surrounding do-while into a worse `beq+fallthrough+extra-j` shape) and a
     u_char staging temp (no effect); no clean source lever found. Allocator-internal,
     not reachable without a structural regression; permuter (no cast) or accept. */
  int sentinel;
  int numQuads;
  Trk_Quad *pquad;

  sentinel = -1;
  pquad = (Trk_Quad *)sd->quads;
  numQuads = (int)sd->quadCount - 1;
  if (numQuads != sentinel) {
    do {
      if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
        DrawW_DrawQuad(sd,pquad);
        pquad = pquad + 1;
      }
      numQuads = numQuads - 1;
    } while (numQuads != sentinel);
  }
  return;
}

/* ---- DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:1331-1375] SLD-VERIFIED ---- */
void DrawW_StripDraw_High(Draw_tGiveShelbyMoreCache *sd)

{
  /* MATCH: SYM (nfs4-f-v3.txt @0x800C6EB8) names `r0`,`r1` sharing ONE register ($v0) and
     `r2`,`r3` sharing ANOTHER ($v1) in the innermost block -- i.e. topVert/iquad is loaded
     ONCE into r0, reused for BOTH aPoints[1]=r0 and aPoints[0]=r0+1 (assigned to r1); same
     for botVert into r2/r3 -> aPoints[2]=r2, aPoints[3]=r3=r2+1. The previous version
     re-read pTVar4->topVert/botVert via 4 independent expressions (4 loads instead of 2) --
     also needed BOTH topVert/botVert loaded back-to-back BEFORE either `+iquad` add (same
     load-batch-then-compute idiom as DrawW_WorldSetUpMatrix), and a dedicated `pMaterial`
     pointer pre-offset by +4 (walked +2/iter) instead of re-deriving `(char*)pTVar4+4+
     iquad*2` each pass (frees $s2 for the oracle's addressing).
     NEAR-MISS FLOOR (10 diffs, down from 38; ours 58 == oracle 58 insns): the inner loop
     needed the SAME goto-TEST do-while lever as the sibling DrawW_kCtrlWorld_High/
     Draw_DeInitViews(InGame) -- oracle's inner for-loop is test-first-with-plain-
     fallthrough + unconditional `j`-back; ours is body-first-with-goto-skip + conditional
     `bnez`-back. Tried swapping the `iquad++`/`pMaterial++` increment order (regressed to
     12); this is the same loop-rotation-direction floor documented on the sibling fns --
     not reachable by a source lever at this opt level; permuter (no cast) or accept. */
  int r0;
  int r1;
  int r2;
  int r3;
  u_char bVar1;
  short sVar2;
  int iquad;
  int numQuads;
  Trk_NewStrip *stripPtr;
  Trk_NewStrip *pTVar4;
  u_short *pMaterial;
  Trk_Quad newQuad;

  pTVar4 = sd->stripPtr;
  sd->doublelayer = 1;
  while( true ) {
    sVar2 = sd->numStrips + -1;
    sd->numStrips = sVar2;
    iquad = 0;
    if (sVar2 == -1) break;
    bVar1 = pTVar4->quadCount;
    numQuads = (int)(u_int)bVar1;
    pMaterial = (u_short *)((char *)pTVar4 + 4);
    goto QUAD_TEST;
    do {
      if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
        newQuad.material = *pMaterial;
        r0 = pTVar4->topVert;
        r2 = pTVar4->botVert;
        r0 = r0 + iquad;
        newQuad.aPoints[1] = (u_char)r0;
        r1 = r0 + 1;
        r2 = r2 + iquad;
        newQuad.aPoints[2] = (u_char)r2;
        r3 = r2 + 1;
        newQuad.aPoints[0] = (u_char)r1;
        newQuad.aPoints[3] = (u_char)r3;
        DrawW_DrawQuad(sd,&newQuad);
      }
      pMaterial = pMaterial + 1;
      iquad = iquad + 1;
      QUAD_TEST:
      ;
    } while (iquad < numQuads);
    pTVar4 = (Trk_NewStrip *)(&pTVar4->topVert + (u_char)pTVar4->size);
  }
  return;
}

/* ---- DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry  [DRAWW.CPP:1390-1654] SLD-VERIFIED ---- */
void DrawW_DoTrough(DRender_tView *Vi,tBuildEntry *buildList)

{
  int cx;
  int cz;
  Group * group;
  u_char bVar1;
  int iVar2;
  Chunk *pCVar3;
  int dist;
  int iVar4;
  int iVar5;
  Group *pThis;
  Group *pGVar6;
  Draw_tGiveShelbyMoreCache *sd;
  Chunk *chunkDat;
  coorddef *pChunkCp;
  coorddef *pcVar7;
  int buildInd;
  int iVar8;
  coorddef tmp;
  coorddef tmp2;
  int chunkCount;
  
  iVar2 = BWorld_gChunkCount;
  iVar8 = 0;
  DrawW_gChunkObjFlag = 1;
  Render_gCopMat.m[8] = (*(int *)&(gIdentTemplate.m[0]));
  DrawWTrough_scratchVec[0] = (*(int *)((u_char *)&(gIdentTemplate.m) + 4));
  DrawWTrough_scratchVec[1] = (*(int *)((u_char *)&(gIdentTemplate.m[1]) + 2));
  DrawWTrough_scratchVec[2] = (*(int *)&(gIdentTemplate.m[2]));
  INT_1f800084 = (*(int *)((u_char *)&(gIdentTemplate) + 16));
  INT_1f800088 = gIdentTemplate.t[0];
  INT_1f80008c = gIdentTemplate.t[1];
  INT_1f800090 = gIdentTemplate.t[2];
  DrawW_gObjScratch_148 = 0;
  do {
    pCVar3 = Track_chunkList;
    if (iVar2 <= iVar8) {
      return;
    }
    if ((buildList->enableBits & 1U) != 0) {
      DrawW_gInitialArtPtr = &gInitialArt;
      bVar1 = (u_char)buildList->chunkInd;
      DrawW_gChunkGeomRez = buildList->geomRez;
      DrawW_gChunkInd = bVar1;
      DrawW_WorldSetUpMatrix(&gWorldMat,&Render_gWorldMat);
      DrawW_gNightFlags = '\0';
      DrawW_gFog_init = 0xffff;
      DrawW_gChunkVtxBuf = pCVar3[bVar1].vertexBuf + 1;
      DrawW_gMaterialLUT = Track_materials;
      pcVar7 = Chunk_chunkCenters + DrawW_gChunkInd;
      if (gNight_renderNight != 0) {
        DrawW_gNightFlags = '\x04';
        iVar4 = pcVar7->x - ((Camera_gInfo[Vi->player].target)->position).x >> 10;
        iVar5 = pcVar7->z - ((Camera_gInfo[Vi->player].target)->position).z >> 10;
        if (iVar4 * iVar4 + iVar5 * iVar5 < 0x47e0000) {
          if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
            DrawW_gNightFlags = '\x05';
          }
          tmp.x = (Vi->cview).translation.x - ((Camera_gInfo[Vi->player].target)->position).x;
          tmp.y = (Vi->cview).translation.y - ((Camera_gInfo[Vi->player].target)->position).y;
          tmp.z = (Vi->cview).translation.z - ((Camera_gInfo[Vi->player].target)->position).z;
          transform(&tmp.x,gNightMat.m,&tmp2.x);
          DrawW_WorldSetUpTranslation(&tmp2,(MATRIX *)&Render_gNightMat);
        }
        if ((BW_gCopCarObj != (Car_tObj *)0x0) &&
           (iVar4 = pcVar7->x - (BW_gCopCarObj->N).position.x >> 10,
           iVar5 = pcVar7->z - (BW_gCopCarObj->N).position.z >> 10,
           iVar4 * iVar4 + iVar5 * iVar5 < 0x47e0000)) {
          DrawW_gNightFlags = DrawW_gNightFlags | 2;
          tmp.x = (Vi->cview).translation.x - (BW_gCopCarObj->N).position.x;
          tmp.y = (Vi->cview).translation.y - (BW_gCopCarObj->N).position.y;
          tmp.z = (Vi->cview).translation.z - (BW_gCopCarObj->N).position.z;
          transform(&tmp.x,gCopMat.m,&tmp2.x);
          DrawW_WorldSetUpTranslation(&tmp2,(MATRIX *)&Render_gCopMat);
        }
      }
      DrawW_gChunkRelX = (short)(pcVar7->x - (Vi->cview).translation.x >> 10);
      DrawW_gChunkRelY = (short)(pcVar7->y - (Vi->cview).translation.y >> 10);
      DrawW_gChunkRelZ = (short)(pcVar7->z - (Vi->cview).translation.z >> 10);
      Render_gWorldMat.t[2] = 0;
      Render_gWorldMat.t[1] = 0;
      Render_gWorldMat.t[0] = 0;
gte_SetTransMatrix((void *)0x1f800014);
      if (DrawW_gChunkGeomRez == '\0') {
        pGVar6 = pCVar3[bVar1].lorezstripBuf;
        if (pGVar6 != (Group *)0x0) {
          DrawW_gGroupCount = (u_short)pGVar6->m_num_elements;
          DrawW_gGroupPtr = pGVar6 + 1;
          if (DrawW_gGroupPtr != (Group *)0x0) {
            DrawW_gMatID_tmp = 0x7d;
            DrawW_StripDraw_High((Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr);
          }
        }
        DrawW_gChunkQuadCount = pCVar3[bVar1].quadCounts[0];
        if (DrawW_gChunkQuadCount != '\0') {
          DrawW_gChunkStripBuf = (int)pCVar3[bVar1].renderQuads[0];
          DrawW_gMatID_tmp = 0x7d;
          DrawW_gNightTmpFlag = '\x01';
          DrawW_gFog_init = 0xffff;
          DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr);
        }
        DrawW_gChunkQuadCount = pCVar3[bVar1].quadCounts[1];
        if (DrawW_gChunkQuadCount != '\0') {
          DrawW_gChunkStripBuf = (int)pCVar3[bVar1].renderQuads[1];
DrawWTrough_setStateCallHigh:
          DrawW_gMatID_tmp = 0x1e;
          DrawW_gNightTmpFlag = '\x01';
          DrawW_gFog_init = 0xffff;
          DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr);
        }
      }
      else {
        pGVar6 = pCVar3[bVar1].stripBuf;
        if (pGVar6 != (Group *)0x0) {
          DrawW_gGroupPtr = pGVar6 + 1;
          DrawW_gGroupCount = (u_short)pGVar6->m_num_elements;
          DrawW_gMatID_tmp = 0x7d;
          DrawW_StripDraw_High((Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr);
          DrawW_gChunkQuadCount = pCVar3[bVar1].quadCounts[5];
          if (DrawW_gChunkQuadCount != '\0') {
            DrawW_gChunkStripBuf = (int)pCVar3[bVar1].renderQuads[3];
            goto DrawWTrough_setStateCallHigh;
          }
        }
      }
      DrawW_gChunkVtxBuf = pCVar3[bVar1].objVertexBuf + 1;
      DrawW_gChunkQuadCount = pCVar3[bVar1].quadCounts[2];
      if (DrawW_gChunkQuadCount != '\0') {
        DrawW_gMatID_tmp = 0x7d;
        DrawW_gNightTmpFlag = '\x01';
        DrawW_gFog_init = 0xffff;
        DrawW_gChunkStripBuf = (int)(pCVar3[bVar1].objQuadBuf + 1);
        DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr);
      }
      DrawW_gChunkQuadCount = pCVar3[bVar1].quadCounts[3];
      if (DrawW_gChunkQuadCount != '\0') {
        DrawW_gMatID_tmp = 0x32;
        DrawW_gNightTmpFlag = '\x01';
        DrawW_gFog_init = 0xffff;
        DrawW_gChunkStripBuf = (int)(pCVar3[bVar1].objQuadInstanceBuf + 1);
        DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr);
      }
    }
    buildList = buildList + 1;
    iVar8 = iVar8 + 1;
  } while( true );
}

/* ---- DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX  [DRAWW.CPP:1663-1670] SLD-VERIFIED ---- */
void DrawW_WorldSetUpMatrix(matrixtdef *m,MATRIX *mat)

{
  /* MATCH: SYM (nfs4-f-v3.txt @0x800C753C) shows the SAME "line = 3" repeated in THREE
     separate nested block scopes, each with its own {r0,r1,r2} REG triplet -- i.e. all
     three loads happen first, THEN all three shifts, THEN all three stores per row (not
     interleaved load-shift-store per element). Register classes per block: row0/row1 use
     $2/$3/$6 (v0/v1/a2), row2 uses $2/$3/$4 (v0/v1/a0 -- `m` is dead after its last read).
     NEAR-MISS FLOOR (6 diffs, down from 32): this shape reproduces row0/row1 byte-exact and
     gets row2's addressing/shift/store right; the residual is ONLY the 3rd-element temp's
     register class (oracle frees dead $a0/`m` and reuses it there, ours keeps allocating
     $a2). A real `for(i=0;i<3;i++)` loop does NOT reproduce this (gcc-2.8 does not unroll
     it here -- produces a genuine 57-insn branch-back loop, far worse); tried direct-cast
     `((int*)m)[8]`, no-temp inline row2, and reversed read-order within row2 (5 variants) --
     none freed $a0. Allocator-internal register-class choice, not reachable by a source
     lever at this opt level; permuter (no cast on the hot path) or accept. */
  int r0;
  int r1;
  int r2;

  r0 = m->m[0];
  r1 = m->m[3];
  r2 = m->m[6];
  r0 = r0 >> 4;
  r1 = r1 >> 4;
  r2 = r2 >> 4;
  mat->m[0][0] = (short)r0;
  mat->m[0][1] = (short)r1;
  mat->m[0][2] = (short)r2;

  r0 = m->m[1];
  r1 = m->m[4];
  r2 = m->m[7];
  r0 = r0 >> 4;
  r1 = r1 >> 4;
  r2 = r2 >> 4;
  mat->m[1][0] = (short)r0;
  mat->m[1][1] = (short)r1;
  mat->m[1][2] = (short)r2;

  r0 = m->m[2];
  r1 = m->m[5];
  r2 = m->m[8];
  r0 = r0 >> 4;
  r1 = r1 >> 4;
  r2 = r2 >> 4;
  mat->m[2][0] = (short)r0;
  mat->m[2][1] = (short)r1;
  mat->m[2][2] = (short)r2;

gte_SetRotMatrix(mat);
  return;
}

/* ---- DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX  [DRAWW.CPP:1674-1684] SLD-VERIFIED ---- */
void DrawW_WorldSetUpTranslation(coorddef *t,MATRIX *mat)

{
  int tx;
  int ty;
  int iVar1;
  int iVar2;
  int tz;
  
  tx = t->x;
  iVar1 = t->y;
  iVar2 = t->z;
  mat->t[0] = tx >> 10;
  mat->t[1] = iVar1 >> 10;
  mat->t[2] = iVar2 >> 10;
gte_SetTransMatrix(mat);
  return;
}

/* ---- DrawW_ResetAnimationTimer__Fv  [DRAWW.CPP:1698-1700] SLD-VERIFIED ---- */
void DrawW_ResetAnimationTimer(void)

{
  int i;

  i = 0xb;
  do {
    animation_timer[i] = 0;
    i = i + -1;
  } while (-1 < i);
  return;
}

/* ---- DrawW_GetAnimationTime__FP15Trk_AnimateInst  [DRAWW.CPP:1704-1716] SLD-VERIFIED ---- */
int DrawW_GetAnimationTime(Trk_AnimateInst *animInst)

{
  int track;
  int maxTick;
  int iVar2;

  /* MATCH: early-return the gameTicks case (inverted condition) so gcc lays out
     [conds][gameTicks][body] like the oracle; the body then re-reads objectIndex.
     SYM (nfs4-f-v3.txt @0x800C7644): inner block [0x800C7678,0x800C76C0) (line 11-13)
     names exactly ONE REG local, `maxTick` -- its live range spans the multiply result
     through the final compare/return, matching oracle reg $a1 (mflo -> slt -> conditional
     move -> jr-delay-slot v0). The animation_timer[] load is an unnamed expression temp
     (shorter live range, no SYM name) -- kept here as iVar2.
     NEAR-MISS FLOOR (4 diffs, re-confirmed): oracle's `lw v0,0(v0); nop; addu v1,v0,zero`
     (a genuine load-delay stall + redundant move) vs ours `lw v1,0(v0)` straight + `mflo`
     filling the delay slot naturally (ours 31 insns vs oracle 33 -- ours is objectively
     BETTER-scheduled). Re-tried compute-order swap, ternary-return, cached-address
     (int* pTick), and direct-dual-return (no iVar2) shapes this session -- all reproduce
     the identical 4-diff register-coloring floor or regress further. Not reachable by a
     source lever; candidate for permuter (no pointer/int cast on the hot path, so a
     re-seed is viable) or accept-as-is. */
  track = GameSetup_gData.track;
  if (((animInst->objectIndex == '\0') || (track == 3)) || (track == 7)) {
    return simGlobal.gameTicks;
  }
  maxTick = (animInst->count + -2) * (int)animInst->interval;
  iVar2 = animation_timer[animInst->objectIndex - 1];
  if (maxTick <= animation_timer[animInst->objectIndex - 1]) {
    iVar2 = maxTick;
  }
  return iVar2;
}

/* ---- DrawW_SetAnimationTime__FP15Trk_AnimateInstPii  [DRAWW.CPP:1721-1779] SLD-VERIFIED ---- */
void DrawW_SetAnimationTime(Trk_AnimateInst *animInst,int *table,int time)

{
  int objIndex;
  int iVar1;
  int *piVar2;
  int iVar3;
  int slice;
  int iVar4;
  Car_tObj **ppCVar5;
  int i;
  int iVar6;
  
  iVar1 = Cars_gNumHumanRaceCars;
  iVar3 = animInst->objectIndex - 1;
  if (animation_timer[iVar3] < 0xf01) {
    piVar2 = animation_timer + iVar3;
    iVar6 = 0;
    if (0 < *piVar2) {
      *piVar2 = *piVar2 + 1;
      return;
    }
    ppCVar5 = Cars_gHumanRaceCarList;
    for (; iVar6 < iVar1; iVar6 = iVar6 + 1) {
      iVar4 = (int)((*ppCVar5)->N).simRoadInfo.slice;
      if ((table[iVar3 * 2] <= iVar4) && (iVar4 <= (table + iVar3 * 2)[1])) {
        *piVar2 = *piVar2 + 1;
      }
      ppCVar5 = ppCVar5 + 1;
    }
  }
  else {
    ppCVar5 = Cars_gHumanRaceCarList;
    for (iVar6 = 0; iVar6 < iVar1; iVar6 = iVar6 + 1) {
      iVar4 = (int)((*ppCVar5)->N).simRoadInfo.slice;
      if ((iVar4 < table[iVar3 * 2]) || ((table + iVar3 * 2)[1] < iVar4)) {
        animation_timer[iVar3] = 0;
      }
      ppCVar5 = ppCVar5 + 1;
    }
  }
  return;
}

/* ---- DrawW_DoObjectAnimations__Fv  [DRAWW.CPP:1784-1805] SLD-VERIFIED ---- */
void DrawW_DoObjectAnimations(void)

{
  int time_00;
  int track;
  Trk_AnimateInst **ppTVar1;
  int i;
  int iVar2;
  int *trackPtr;
  int (*table) [2];
  int time;
  
  if (GameSetup_gData.track == 0) {
    table = trk0;
  }
  else {
    if (GameSetup_gData.track != 4) {
      return;
    }
    table = trk4;
  }
  time_00 = simGlobal.gameTicks;   /* MATCH: load deferred past the track test (oracle order) */
  iVar2 = 0;
  ppTVar1 = Anim_gInstanceFromIndex;
  do {
    if ((*ppTVar1)->objectIndex != '\0') {
      DrawW_SetAnimationTime(*ppTVar1,*table,time_00);
    }
    iVar2 = iVar2 + 1;
    ppTVar1 = ppTVar1 + 1;
  } while (iVar2 < 0x10);
  return;
}

/* ---- DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo  [DRAWW.CPP:1909-2048] SLD-VERIFIED ---- */
int DrawW_BuildObjectFacets(DRender_tView *Vi,ChunkObjectInfo *gObjInfo)

{
  Group * group;
  u_char bVar1;
  Group *pThis;
  int iVar2;
  void *pvVar3;
  int iVar4;
  short *psVar5;
  int iVar6;
  int iVar7;
  Trk_SimpleInst *objInstance;
  Trk_AnimateInst *animInst;
  Trk_ObjectDef *objDef;
  Trk_ObjectDef *objDef_00;
  int objectOffset;
  int iVar8;
  int objectIndex;
  int iVar9;
  int totalCount;
  int iVar10;
  int zClipSq;
  int iVar11;
  Draw_DCache *sd;
  matrixtdef matrix;
  coorddef cp;
  coorddef pt2;
  int groupNumElements;
  int offset;
  int doFrustumClip;
  short *visList;
  
  iVar10 = 0;
  animInst = (Trk_AnimateInst *)(gObjInfo->objInstanceBuf + 1);
  iVar2 = gObjInfo->objInstanceBuf->m_num_elements;
  if (iVar2 == 0) {
    iVar10 = 0;
  }
  else {
    iVar6 = gObjInfo->offset;
    iVar7 = gObjInfo->doFrustumClip;
    iVar11 = gObjInfo->zClipSq;
    psVar5 = gObjInfo->visList;
    Render_gWorldMat.t[2] = 0;
    Render_gWorldMat.t[1] = 0;
    Render_gWorldMat.t[0] = 0;
gte_SetTransMatrix((void *)0x1f800014);
    for (iVar9 = 0; iVar9 < iVar2; iVar9 = iVar9 + 1) {
      if ((psVar5 == (short *)0x0) || ((((u_short)psVar5[iVar9] >> 0xc ^ 1) & 1) == 0)) {
        iVar8 = iVar6;
        if (iVar6 == 0) {
          iVar8 = (int)goffsets[animInst->zoffset];
        }
        bVar1 = animInst->type;
        if (bVar1 == 1) {
          objDef_00 = Track_gObjDefs[animInst->pad];
          if (((iVar7 == 0) ||
              (pvVar3 = ObjectClipped(Vi,(int)animInst->pad,(coorddef *)&animInst->count,
                                   (Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr),
              pvVar3 == (void *)0x0)) &&
             ((iVar11 == -1 ||
              (iVar4 = xzsquaredist32((coorddef *)&animInst->count,&(Vi->cview).translation),
              iVar4 < iVar11)))) {
            iVar8 = DrawObjectSimple(Vi,(Draw_DCache *)&Render_gPalettePtr,objDef_00,
                               (coorddef *)&animInst->count,iVar8);
            iVar10 = iVar10 + iVar8;
          }
        }
        else if ((1 < bVar1) && ((bVar1 == 3 || (bVar1 == 7)))) {
          Anim_GetRotPos(animInst,1,DrawW_GetAnimationTime(animInst),&cp,&matrix);
          if ((iVar11 == -1) ||
             (iVar4 = xzsquaredist32(&cp,&(Vi->cview).translation),
             iVar4 < iVar11)) {
            iVar8 = DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,
                               Track_gObjDefs[animInst->pad],&cp,iVar8,-1);
            iVar10 = iVar10 + iVar8;
            if ((animInst->flags & 2) != 0) {
              pt2.x = cp.x + matrix.m[6] * -0x10;
              pt2.y = cp.y + matrix.m[7] * -0x10;
              pt2.z = cp.z + matrix.m[8] * -0x10;
              Flare_Halo2(Vi,-1,0x1e,&cp,&pt2,(Draw_FlareCache *)&Render_gPalettePtr);
            }
          }
        }
      }
      animInst = (Trk_AnimateInst *)((int)&animInst->size + (int)animInst->size);
    }
  }
  return iVar10;
}

/* ---- DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi  [DRAWW.CPP:2054-2151] SLD-VERIFIED ---- */
int DrawW_BuildCustomObjectFacets(DRender_tView *Vi,Draw_DCache *sd,Trk_SimObject *simObjs,Group *group,int zClipSq)

{
  Trk_CollideBoomInst * objCollideBoomInstance;
  u_int uVar1;
  u_int uVar2;
  int objDef_p;
  int buildResult;
  int instData_p;
  int iVar3;
  int iVar11_emit;
  int iVar4;
  ObjectAnim *pOVar5;
  Group *pThis;
  int iVar6;
  int objMat_p;
  int objPos_p;
  int z_check;
  int sx;
  int blend_x;
  int sy;
  int blend_y;
  int sz;
  int blend_z;
  int t2;
  Trk_SimpleInst *objInstance;
  int groupBase_p;
  int t1;
  int objectOffset;
  int objectIndex;
  int facetCount;
  Trk_ObjectDef *objDef;
  Trk_ObjectDef *objDef_00;
  int loc_70;
  int loc_6c;
  int loc_68;
  matrixtdef matrix;
  tQuat quat;
  int totalCount;
  int groupNumElements;
  int loc_28;
  int loc_24;
  int loc_20;
  int tu6;
  u_char bVar7;
  int tp2;
  int pbVar3;
  u_char tc4;
  u_char tc5;
  void *tp1;
  
  groupBase_p = (int)(group + 1);
  totalCount = 0;
  iVar6 = group->m_num_elements;
  if (iVar6 == 0) {
    totalCount = 0;
  }
  else {
    (sd->matB).t[2] = 0;
    (sd->matB).t[1] = 0;
    (sd->matB).t[0] = 0;
    objMat_p = (int)sd;
gte_SetTransMatrix(&CF_DVLC);
    for (facetCount = 0; facetCount < iVar6; facetCount = facetCount + 1) {
      tc5 = *(u_char *)(groupBase_p + 2);
      tc4 = offsets[*(u_char *)(groupBase_p + 4)];
      if ((tc5 == 5) || (tc5 == 2)) {
        objDef_00 = Track_gObjDefs[*(short *)(groupBase_p + 6)];
        if ((tc5 == 2) ||
           (objMat_p = (int)simObjs,
           objDef_p = (int)Object_GetAnim(simObjs + *(u_char *)(groupBase_p + 0x22)), objDef_p == 0)) {
          objPos_p = (int)Vi;
          buildResult = xzsquaredist32((coorddef *)(groupBase_p + 8),&(Vi->cview).translation);
          bVar7 = 0;
          if ((zClipSq <= buildResult) ||
             ((*(char *)(groupBase_p + 2) == '\x02' &&
              (instData_p = (int)ObjectClipped(Vi,(int)*(short *)(groupBase_p + 6),
                                            (coorddef *)(groupBase_p + 8),
                                            (Draw_tGiveShelbyMoreCache *)sd), instData_p != 0)))) {
            bVar7 = 1;
          }
          if (!(bool)bVar7) {
            tp2 = groupBase_p + 0x17;
            uVar1 = tp2 & 3;
            uVar2 = groupBase_p + 0x14U & 3;
            (*(int *)&(quat)) = (*(int *)(tp2 - uVar1) << (3 - uVar1) * 8 |
                         objMat_p & 0xffffffffU >> (uVar1 + 1) * 8) & -1 << (4 - uVar2) * 8 |
                         *(u_int *)((groupBase_p + 0x14U) - uVar2) >> uVar2 * 8;
            uVar1 = groupBase_p + 0x1bU & 3;
            uVar2 = groupBase_p + 0x18U & 3;
            z_check = (*(int *)((groupBase_p + 0x1bU) - uVar1) << (3 - uVar1) * 8 |
                      objPos_p & 0xffffffffU >> (uVar1 + 1) * 8) & -1 << (4 - uVar2) * 8 |
                      *(u_int *)((groupBase_p + 0x18U) - uVar2) >> uVar2 * 8;
            tp1 = (void *)((int)&quat.y + 1);
            uVar1 = (u_int)tp1 & 3;
            *(u_int *)((int)tp1 - uVar1) =
                 *(u_int *)((int)tp1 - uVar1) & -1 << (uVar1 + 1) * 8 |
                 (u_int)(*(int *)&(quat)) >> (3 - uVar1) * 8;
            pbVar3 = (int)&quat.w + 1;
            uVar1 = pbVar3 & 3;
            *(u_int *)(pbVar3 - uVar1) =
                 *(u_int *)(pbVar3 - uVar1) & -1 << (uVar1 + 1) * 8 |
                 (u_int)z_check >> (3 - uVar1) * 8;
            (*(int *)((u_char *)&(quat) + 4)) = z_check;
            Quatern_QuatToMat(&quat,&matrix);
            blend_x = (int)*(short *)(groupBase_p + 0x1c) << 8;
            blend_y = (int)*(short *)(groupBase_p + 0x1e) << 8;
            blend_z = (int)*(short *)(groupBase_p + 0x20) << 8;
            iVar3 = fixedmult(matrix.m[0],blend_x);
            iVar11_emit = fixedmult(matrix.m[3],blend_x);
            matrix.m[6] = fixedmult(matrix.m[6],blend_x);
            matrix.m[0] = iVar3;
            matrix.m[3] = iVar11_emit;
            iVar3 = fixedmult(matrix.m[1],blend_y);
            iVar4 = fixedmult(matrix.m[4],blend_y);
            matrix.m[7] = fixedmult(matrix.m[7],blend_y);
            matrix.m[1] = iVar3;
            matrix.m[4] = iVar4;
            iVar3 = fixedmult(matrix.m[2],blend_z);
            iVar4 = fixedmult(matrix.m[5],blend_z);
            matrix.m[8] = fixedmult(matrix.m[8],blend_z);
            matrix.m[2] = iVar3;
            matrix.m[5] = iVar4;
            iVar3 = DrawObjectTransform(Vi,sd,&matrix,objDef_00,(coorddef *)(groupBase_p + 8),(int)(char)tc4,
                               -1);
            objMat_p = totalCount + iVar3;
            totalCount = objMat_p;
          }
        }
        else {
          pOVar5 = Object_GetAnim(simObjs + *(u_char *)(groupBase_p + 0x22));
          (*(*pOVar5->_vf)[2].pfn)
                    ((int)&pOVar5->_vf + (int)(*pOVar5->_vf)[2].delta,Vi,sd,(int)(char)tc4);
        }
      }
      groupBase_p = groupBase_p + *(short *)groupBase_p;
    }
  }
  return totalCount;
}

/* ---- DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis  [DRAWW.CPP:2156-2241] SLD-VERIFIED ---- */
int DrawObjectTransform(DRender_tView *Vi,Draw_DCache *sd,matrixtdef *matrix,Trk_ObjectDef *objDef,
              coorddef *pCp,int offset,short light)

{
  int mat_local;
  matrixtdef mattemp;
  coorddef tmp;
  coorddef tmp2;
  u_char isCullable;
  Track_tMaterial *shapeDef_p;
  u_short objFlags;
  int drawResult;
  
  sd[1].head.cprim.PrimPtr = (char *)(objDef + 1);
  *(u_char *)((int)&sd[1].head.cprim.MPrimPtr + 3) = objDef->quadCount;
  shapeDef_p = Track_materials;
  isCullable = objDef->vertexCount;
  *(u_char *)((int)sd[1].matB.t + 2) = 0;
  drawResult = gNight_renderNight;
  sd[1].head.clipW = (u_short)offset;
  sd[1].head.clipH = (*(u_short *)((u_char *)&(offset) + 2));
  sd[1].head.mirror = (int)(objDef + (u_int)isCullable * 2 + 1);
  *(Track_tMaterial **)sd[1].matB.m[0] = shapeDef_p;
  if (drawResult != 0) {
    *(u_char *)((int)sd[1].matB.t + 2) = 4;
    if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
      *(u_char *)((int)sd[1].matB.t + 2) = 5;
    }
    tmp.x = pCp->x - ((Camera_gInfo[Vi->player].target)->position).x;
    tmp.y = pCp->y - ((Camera_gInfo[Vi->player].target)->position).y;
    tmp.z = pCp->z - ((Camera_gInfo[Vi->player].target)->position).z;
    transform(&tmp.x,gNightMat.m,&tmp2.x);
    DrawW_WorldSetUpTranslation(&tmp2,&sd->matNight);
    if (BW_gCopCarObj != (Car_tObj *)0x0) {
      *(u_char *)((int)sd[1].matB.t + 2) = *(u_char *)((int)sd[1].matB.t + 2) | 2;
      tmp.x = pCp->x - (BW_gCopCarObj->N).position.x;
      tmp.y = pCp->y - (BW_gCopCarObj->N).position.y;
      tmp.z = pCp->z - (BW_gCopCarObj->N).position.z;
      transform(&tmp.x,gCopMat.m,&tmp2.x);
      DrawW_WorldSetUpTranslation(&tmp2,&sd->matCop);
    }
    (sd->matB).t[2] = 0;
    (sd->matB).t[1] = 0;
    (sd->matB).t[0] = 0;
gte_SetTransMatrix((MATRIX *)&(sd->matB));
  }
  tmp.x = pCp->x - (Vi->cview).translation.x;
  tmp.y = pCp->y - (Vi->cview).translation.y;
  tmp.z = pCp->z - (Vi->cview).translation.z;
  TrsProj_SetPsxTransZero();
  TrsProj_TransPt(&tmp,&tmp2);
  if (offset == -1) {
    objFlags = (*(u_short *)((u_char *)&(Draw_gMidGroundOtz) + 2));
    sd[1].head.clipW = (u_short)Draw_gMidGroundOtz;
    sd[1].head.clipH = objFlags;
    tmp2.x = tmp2.x >> 2;
    tmp2.z = tmp2.z >> 2;
    tmp2.y = tmp2.y >> 2;
  }
  *(u_int *)(sd[1].matB.m[0] + 2) = 0;
  sd[1].matB.m[1][1] = 0;
  Math_fasttransmult(matrix,&gWorldMat,&mattemp);
  mat_local = (int)&sd->matB;
  DrawW_WorldSetUpMatrix(&mattemp,(MATRIX *)mat_local);
  DrawW_WorldSetUpTranslation(&tmp2,(MATRIX *)mat_local);
  *(u_char *)((int)sd[1].matB.t + 3) = 0;
  sd->light = light;
  DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache *)sd);
  DrawW_WorldSetUpMatrix(&gWorldMat,(MATRIX *)mat_local);
  (sd->matB).t[2] = 0;
  (sd->matB).t[1] = 0;
  (sd->matB).t[0] = 0;
gte_SetTransMatrix(&tmp2);
  return (u_int)objDef->quadCount;
}

/* ---- DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi  [DRAWW.CPP:2261-2334] SLD-VERIFIED ---- */
int DrawObjectSimple(DRender_tView *Vi,Draw_DCache *sd,Trk_ObjectDef *objDef,coorddef *pCp,int offset)

{
  short facetIdx;
  coorddef tmp;
  coorddef tmp2;
  u_short objFlags;
  u_char isCullable;
  Track_tMaterial *shapeDef_p;
  int drawResult;
  
  shapeDef_p = Track_materials;
  sd[1].head.cprim.PrimPtr = (char *)(objDef + 1);
  *(Track_tMaterial **)sd[1].matB.m[0] = shapeDef_p;
  *(u_char *)((int)&sd[1].head.cprim.MPrimPtr + 3) = objDef->quadCount;
  isCullable = objDef->vertexCount;
  *(u_char *)((int)sd[1].matB.t + 2) = 0;
  drawResult = gNight_renderNight;
  sd[1].head.clipW = (u_short)offset;
  sd[1].head.clipH = (*(u_short *)((u_char *)&(offset) + 2));
  sd[1].head.mirror = (int)(objDef + (u_int)isCullable * 2 + 1);
  if (drawResult != 0) {
    *(u_char *)((int)sd[1].matB.t + 2) = 4;
    if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
      *(u_char *)((int)sd[1].matB.t + 2) = 5;
    }
    tmp.x = (Vi->cview).translation.x - ((Camera_gInfo[Vi->player].target)->position).x;
    tmp.y = (Vi->cview).translation.y - ((Camera_gInfo[Vi->player].target)->position).y;
    tmp.z = (Vi->cview).translation.z - ((Camera_gInfo[Vi->player].target)->position).z;
    transform(&tmp.x,gNightMat.m,&tmp2.x);
    DrawW_WorldSetUpTranslation(&tmp2,&sd->matNight);
    if (BW_gCopCarObj != (Car_tObj *)0x0) {
      *(u_char *)((int)sd[1].matB.t + 2) = *(u_char *)((int)sd[1].matB.t + 2) | 2;
      tmp.x = (Vi->cview).translation.x - (BW_gCopCarObj->N).position.x;
      tmp.y = (Vi->cview).translation.y - (BW_gCopCarObj->N).position.y;
      tmp.z = (Vi->cview).translation.z - (BW_gCopCarObj->N).position.z;
      transform(&tmp.x,gCopMat.m,&tmp2.x);
      DrawW_WorldSetUpTranslation(&tmp2,&sd->matCop);
    }
    (sd->matB).t[2] = 0;
    (sd->matB).t[1] = 0;
    (sd->matB).t[0] = 0;
gte_SetTransMatrix((MATRIX *)&(sd->matB));
  }
  if (offset == -1) {
    objFlags = (*(u_short *)((u_char *)&(Draw_gMidGroundOtz) + 2));
    sd[1].head.clipW = (u_short)Draw_gMidGroundOtz;
    sd[1].head.clipH = objFlags;
    sd[1].matB.m[0][2] = (short)(pCp->x - (Vi->cview).translation.x >> 0xc);
    sd[1].matB.m[1][0] = (short)(pCp->y - (Vi->cview).translation.y >> 0xc);
    facetIdx = (short)(pCp->z - (Vi->cview).translation.z >> 0xc);
  }
  else {
    sd[1].matB.m[0][2] = (short)(pCp->x - (Vi->cview).translation.x >> 10);
    sd[1].matB.m[1][0] = (short)(pCp->y - (Vi->cview).translation.y >> 10);
    facetIdx = (short)(pCp->z - (Vi->cview).translation.z >> 10);
  }
  sd[1].matB.m[1][1] = facetIdx;
  *(u_char *)((int)sd[1].matB.t + 3) = 1;
  sd->light = -1;
  DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache *)sd);
  return (u_int)objDef->quadCount;
}

/* ---- DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo  [DRAWW.CPP:2346-2649] SLD-VERIFIED ---- */
int DrawW_BuildChunkObjectFacets(DRender_tView *Vi,ChunkObjectInfo *gObjInfo)

{
  Group * instGroup;
  u_char type;
  int t2;
  u_char bVar1;
  Group *pThis;
  int iVar2;
  void *pvVar3;
  int iVar4;
  int iVar5;
  ObjectAnim *pOVar6;
  int iVar7;
  Trk_SimObject *pTVar8;
  int sx;
  int iVar9;
  short light;
  int sy;
  int iVar10;
  int sz;
  int iVar11;
  int t1;
  Trk_SimpleInst *objInstance;
  Group *pGVar12;
  Trk_ObjectDef *objDef;
  Trk_ObjectDef *objDef_00;
  int totalCount;
  int iVar13;
  int objectOffset;
  int iVar14;
  matrixtdef matrix;
  Trk_SimObject *simObjs;
  int doFrustumClip;
  int groupNumElements;
  int objectIndex;
  
  pTVar8 = gObjInfo->simObjs;
  pGVar12 = gObjInfo->objInstanceBuf + 1;
  iVar2 = gObjInfo->objInstanceBuf->m_num_elements;
  iVar7 = gObjInfo->doFrustumClip;
  iVar13 = 0;
  if (iVar2 == 0) {
    iVar13 = 0;
  }
  else {
    Render_gWorldMat.t[2] = 0;
    Render_gWorldMat.t[1] = 0;
    Render_gWorldMat.t[0] = 0;
gte_SetTransMatrix((void *)0x1f800014);
    for (objectIndex = 0; objectIndex < iVar2; objectIndex = objectIndex + 1) {
      bVar1 = *(u_char *)((int)&pGVar12->m_num_elements + 2);
      iVar14 = (int)goffsets[(u_char)pGVar12[1].m_num_elements];
      if (((bVar1 & 0x80) != 0) ||
         ((((bVar1 != 5 && (iVar7 != 0)) &&
           (pvVar3 = ObjectClipped(Vi,(int)*(short *)((int)&pGVar12[1].m_num_elements + 2),
                                (coorddef *)(pGVar12 + 2),
                                (Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr),
           pvVar3 != (void *)0x0)) && (*(char *)((int)&pGVar12->m_num_elements + 2) != '\x02'))))
      goto DrawWChunkFacets_groupNext;
      DrawW_gObjScratch_148 = 0x400;
      light = -1;
      if ((pGVar12[1].m_num_elements & 0x100) == 0) {
        if (bVar1 == 2) {
          Quatern_QuatToMat((tQuat *)(pGVar12 + 5),&matrix);
          iVar9 = (int)(short)pGVar12[7].m_num_elements << 8;
          iVar10 = (int)*(short *)((int)&pGVar12[7].m_num_elements + 2) << 8;
          iVar11 = (int)(short)pGVar12[8].m_num_elements << 8;
          iVar4 = fixedmult(matrix.m[0],iVar9);
          iVar5 = fixedmult(matrix.m[3],iVar9);
          matrix.m[6] = fixedmult(matrix.m[6],iVar9);
          matrix.m[0] = iVar4;
          matrix.m[3] = iVar5;
          iVar4 = fixedmult(matrix.m[1],iVar10);
          iVar5 = fixedmult(matrix.m[4],iVar10);
          matrix.m[7] = fixedmult(matrix.m[7],iVar10);
          matrix.m[1] = iVar4;
          matrix.m[4] = iVar5;
          iVar4 = fixedmult(matrix.m[2],iVar11);
          iVar5 = fixedmult(matrix.m[5],iVar11);
          matrix.m[8] = fixedmult(matrix.m[8],iVar11);
          objDef_00 = Track_gObjDefs[*(short *)((int)&pGVar12[1].m_num_elements + 2)];
          light = *(short *)((int)&pGVar12[8].m_num_elements + 2);
          matrix.m[2] = iVar4;
          matrix.m[5] = iVar5;
          goto DrawWChunkFacets_emitObj;
        }
        if (bVar1 < 3) {
          if (bVar1 == 1) {
            iVar14 = DrawObjectSimple(Vi,(Draw_DCache *)&Render_gPalettePtr,
                                Track_gObjDefs[*(short *)((int)&pGVar12[1].m_num_elements + 2)],
                                (coorddef *)(pGVar12 + 2),iVar14);
            iVar13 = iVar13 + iVar14;
          }
        }
        else if (bVar1 == 5) {
          objDef_00 = Track_gObjDefs[*(short *)((int)&pGVar12[1].m_num_elements + 2)];
          pOVar6 = Object_GetAnim(pTVar8 + *(u_char *)((int)&pGVar12[8].m_num_elements + 2));
          if (pOVar6 == (ObjectAnim *)0x0) {
            Quatern_QuatToMat((tQuat *)(pGVar12 + 5),&matrix);
            iVar9 = (int)(short)pGVar12[7].m_num_elements << 8;
            iVar10 = (int)*(short *)((int)&pGVar12[7].m_num_elements + 2) << 8;
            iVar11 = (int)(short)pGVar12[8].m_num_elements << 8;
            iVar4 = fixedmult(matrix.m[0],iVar9);
            iVar5 = fixedmult(matrix.m[3],iVar9);
            matrix.m[6] = fixedmult(matrix.m[6],iVar9);
            matrix.m[0] = iVar4;
            matrix.m[3] = iVar5;
            iVar4 = fixedmult(matrix.m[1],iVar10);
            iVar5 = fixedmult(matrix.m[4],iVar10);
            matrix.m[7] = fixedmult(matrix.m[7],iVar10);
            matrix.m[1] = iVar4;
            matrix.m[4] = iVar5;
            iVar4 = fixedmult(matrix.m[2],iVar11);
            iVar5 = fixedmult(matrix.m[5],iVar11);
            matrix.m[8] = fixedmult(matrix.m[8],iVar11);
            light = -1;
            matrix.m[2] = iVar4;
            matrix.m[5] = iVar5;
            goto DrawWChunkFacets_emitObj;
          }
          pOVar6 = Object_GetAnim(pTVar8 + *(u_char *)((int)&pGVar12[8].m_num_elements + 2));
          (*(*pOVar6->_vf)[2].pfn)
                    ((int)&pOVar6->_vf + (int)(*pOVar6->_vf)[2].delta,Vi,0x1f800000,iVar14);
        }
        else if (bVar1 == 9) {
          xformy(&matrix,(int)(short)pGVar12[5].m_num_elements);
          iVar9 = (int)(short)pGVar12[6].m_num_elements << 8;
          iVar10 = (int)*(short *)((int)&pGVar12[5].m_num_elements + 2) << 8;
          iVar4 = fixedmult(matrix.m[0],iVar9);
          iVar5 = fixedmult(matrix.m[3],iVar9);
          matrix.m[6] = fixedmult(matrix.m[6],iVar9);
          matrix.m[0] = iVar4;
          matrix.m[3] = iVar5;
          iVar4 = fixedmult(matrix.m[1],iVar10);
          iVar5 = fixedmult(matrix.m[4],iVar10);
          matrix.m[7] = fixedmult(matrix.m[7],iVar10);
          matrix.m[1] = iVar4;
          matrix.m[4] = iVar5;
          iVar4 = fixedmult(matrix.m[2],iVar9);
          iVar5 = fixedmult(matrix.m[5],iVar9);
          matrix.m[8] = fixedmult(matrix.m[8],iVar9);
          DrawW_gObjScratch_148 = 0;
          objDef_00 = Track_gObjDefs[*(short *)((int)&pGVar12[1].m_num_elements + 2)];
          light = *(short *)((int)&pGVar12[6].m_num_elements + 2);
          matrix.m[2] = iVar4;
          matrix.m[5] = iVar5;
          goto DrawWChunkFacets_emitObj;
        }
      }
      else {
        iVar4 = fixedatan(pGVar12[2].m_num_elements - (Vi->cview).translation.x,
                           pGVar12[4].m_num_elements - (Vi->cview).translation.z);
        fixedxformy(&matrix,iVar4);
        if (bVar1 == 9) {
          iVar9 = (int)(short)pGVar12[6].m_num_elements << 8;
          iVar10 = (int)*(short *)((int)&pGVar12[5].m_num_elements + 2) << 8;
          iVar4 = fixedmult(matrix.m[0],iVar9);
          iVar5 = fixedmult(matrix.m[3],iVar9);
          matrix.m[6] = fixedmult(matrix.m[6],iVar9);
          matrix.m[0] = iVar4;
          matrix.m[3] = iVar5;
          iVar4 = fixedmult(matrix.m[1],iVar10);
          iVar5 = fixedmult(matrix.m[4],iVar10);
          matrix.m[7] = fixedmult(matrix.m[7],iVar10);
          matrix.m[1] = iVar4;
          matrix.m[4] = iVar5;
          iVar4 = fixedmult(matrix.m[2],iVar9);
          iVar5 = fixedmult(matrix.m[5],iVar9);
          matrix.m[8] = fixedmult(matrix.m[8],iVar9);
          light = *(short *)((int)&pGVar12[6].m_num_elements + 2);
          DrawW_gObjScratch_148 = 0;
          matrix.m[2] = iVar4;
          matrix.m[5] = iVar5;
        }
        objDef_00 = Track_gObjDefs[*(short *)((int)&pGVar12[1].m_num_elements + 2)];
DrawWChunkFacets_emitObj:
        iVar14 = DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef_00,
                            (coorddef *)(pGVar12 + 2),iVar14,light);
        iVar13 = iVar13 + iVar14;
      }
DrawWChunkFacets_groupNext:
      pGVar12 = (Group *)((int)&pGVar12->m_num_elements + (int)(short)pGVar12->m_num_elements);
    }
  }
  return iVar13;
}

/* ---- ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:2660-2709] SLD-VERIFIED ---- */
void * ObjectClipped(DRender_tView *Vi,int ind,coorddef *pCp,Draw_tGiveShelbyMoreCache *sd)

{
  tBoundingSphere * bSphere;
  int iVar1;
  int iVar2;
  void *pvVar3;
  Group *pThis;
  Group *pGVar4;
  coorddef tmp;
  coorddef tmp2;
  coorddef trans;
  
  pGVar4 = gPersistObjDefBoundingSpheres + ind * 2 + 1;
  tmp.x = (short)pGVar4->m_num_elements * 0x400 + pCp->x;
  tmp.y = *(short *)((int)&pGVar4->m_num_elements + 2) * 0x400 + pCp->y;
  tmp.z = (short)pGVar4[1].m_num_elements * 0x400 + pCp->z;
  iVar1 = (Vi->cview).translationInv.x;
  iVar2 = (Vi->cview).translationInv.z;
  transform(&tmp.x,(Vi->cview).mrotationInv.m,&tmp2.x);
  iVar1 = tmp2.x + iVar1;
  iVar2 = tmp2.z + iVar2 + *(short *)((int)&pGVar4[1].m_num_elements + 2) * 0x400;
  if (iVar2 < iVar1) {
    pvVar3 = (void *)0x1;
  }
  else {
    pvVar3 = (void *)(u_int)(iVar2 < -iVar1);
  }
  return pvVar3;
}

/* ---- DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry  [DRAWW.CPP:2717-2864] SLD-VERIFIED ---- */
void DrawW_DoObjects(DRender_tView *Vi,tBuildEntry *buildList)

{
  short sVar1;
  int iVar2;
  Chunk *pCVar3;
  Group *pGVar4;
  int chunkInd;
  int geomRez;
  Chunk *chunkDat;
  Trk_SimObject *simObjs;
  int buildInd;
  int iVar5;
  int thisChunkInd;
  int iVar6;
  Draw_DCache *sd;
  int chunkCount;
  
  iVar2 = BWorld_gChunkCount;
  iVar6 = gCurrContext->currentChunk;
  DrawW_gInitialArtPtr = &gInitialArt;
  gVi = Vi;
  for (iVar5 = 0; pCVar3 = Track_chunkList, iVar5 < iVar2; iVar5 = iVar5 + 1) {
    if ((buildList->enableBits & 2U) != 0) {
      sVar1 = buildList->chunkInd;
      pGVar4 = Track_chunkList[sVar1].simObjBuf;
      geomRez = (int)buildList->geomRez;
      if (Track_chunkList[sVar1].objInstanceBuf != (Group *)0x0) {
        DrawW_gChunkObjFlag = 1;
        gChunkObjInfo.objInstanceBuf = Track_chunkList[sVar1].objInstanceBuf;
        gChunkObjInfo.doFrustumClip = (int)(geomRez == 4);
        gChunkObjInfo.simObjs = (Trk_SimObject *)(pGVar4 + 1);
        gWSavePtr = (u_long)SetSp(&gScratchLastWord);
        stackSpeedUpEnbabledFlag = 1;
        DrawW_BuildChunkObjectFacets(gVi,&gChunkObjInfo);
        gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
      }
      if (((GameSetup_gData.Time == 0) && (GameSetup_gData.Weather == 0)) &&
         (pCVar3[sVar1].objSpecialInstanceBuf != (Group *)0x0)) {
        DrawW_gObjScratch_148 = 0x400;
        DrawW_gChunkObjFlag = 0;
        gChunkObjInfo.visList = (short *)0x0;
        gChunkObjInfo.objInstanceBuf = pCVar3[sVar1].objSpecialInstanceBuf;
        gChunkObjInfo.zClipSq = -1;
        gChunkObjInfo.offset = 0x32;
        gChunkObjInfo.doFrustumClip = 1;
        gChunkObjInfo.simObjs = (Trk_SimObject *)(pGVar4 + 1);
        DrawW_BuildObjectFacets(gVi,&gChunkObjInfo);
      }
    }
    buildList = buildList + 1;
  }
  DrawW_gChunkObjFlag = 0;
  DrawW_gObjScratch_148 = 0x400;
  if (gPersistObjInst != (Group *)0x0) {
    if (((GameSetup_gData.track != 4) ||
        (((0x27 < iVar6 - 1U && (0x1d < iVar6 - 0x3dU)) && (8 < iVar6 - 0x6cU)))) &&
       ((GameSetup_gData.track != 0 ||
        (((0x34 < iVar6 - 1U && (0x1b < iVar6 - 0x44U)) && (0x13 < iVar6 - 0x6cU)))))) {
      gChunkObjInfo.objInstanceBuf = gPersistObjInst;
      gChunkObjInfo.simObjs = (Trk_SimObject *)0x0;
      gChunkObjInfo.offset = 0x7d;
      gChunkObjInfo.doFrustumClip = 1;
      gChunkObjInfo.zClipSq = gCurrContext->polyFarZClipSq;
      gChunkObjInfo.visList = (short *)0x0;
      gWSavePtr = (u_long)SetSp(&gScratchLastWord);
      stackSpeedUpEnbabledFlag = 1;
      DrawW_BuildObjectFacets(gVi,&gChunkObjInfo);
      gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
      stackSpeedUpEnbabledFlag = 0;
    }
  }
  if (gPersistMidgroundObjInst != (Group *)0x0) {
    gChunkObjInfo.simObjs = (Trk_SimObject *)0x0;
    gChunkObjInfo.objInstanceBuf = gPersistMidgroundObjInst;
    gChunkObjInfo.zClipSq = -1;
    gChunkObjInfo.offset = -1;
    gChunkObjInfo.doFrustumClip = 1;
    gChunkObjInfo.visList = Track_gInViewList[iVar6];
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    DrawW_BuildObjectFacets(gVi,&gChunkObjInfo);
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
  }
  if ((Object_customObjInst != (Group *)0x0) && (0 < Object_customObjInst->m_num_elements)) {
    DrawW_BuildCustomObjectFacets(Vi,(Draw_DCache *)&Render_gPalettePtr,(Trk_SimObject *)(Object_customSimObjs + 1),
               Object_customObjInst,gCurrContext->polyFarZClipSq);
  }
  return;
}

/* ---- Draw_CircleClip__FP8coorddefT0i  [DRAWW.CPP:2888-2896] SLD-VERIFIED ---- */
int Draw_CircleClip(coorddef *pt1,coorddef *pt2,int r)

{
  int dist;
  int dz;
  int iVar1;
  int iVar2;
  int dx;
  
  dz = pt1->x;
  iVar2 = dz - pt2->x;
  if (iVar2 < 1) {
    iVar2 = pt2->x - dz;
  }
  iVar1 = pt1->z - pt2->z;
  if (iVar1 < 1) {
    iVar1 = pt2->z - pt1->z;
  }
  if (iVar1 < iVar2) {
    dist = iVar2 + (iVar1 >> 2);
  }
  else {
    dist = iVar1 + (iVar2 >> 2);
  }
  return (u_int)(dist < r);
}

/* ---- Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark  [DRAWW.CPP:2900-3038] SLD-VERIFIED ---- */
void Draw_kCtrlSkidmark(Draw_tCtrlSkidmark *fskid)

{
  int r0;
  int r1;
  int r2;
  u_long l1;
  u_long l0;
  int skidChunk_p;
  int vert_count;
  int depth_index;
  int uv_v_pack;
  int vert_idx;
  u_long l2;
  int uv_u_pack;
  u_long l3;
  int uv_alpha;
  POLY_GT4 *prim;
  void *primPtr;
  Draw_tPixMap *pmx;
  int pmx_dst;
  int type;
  int color_pack;
  int pt1_index;
  int save_pre_otz;
  int vt_y;
  int depth_offset;
  int i;
  int depth_skid;
  int count;
  Draw_DCache *sd;
  Skidmark_Chunk *sm;
  matrixtdef *m;
  int ccount;
  int ccount_local;
  coorddef *t;
  int skidIdx;
  int skidIter;
  coorddef td;
  coorddef ts;
  u_char *tp2;
  u_int tu1;
  int ti2;
  u_char *tp3;
  int tp1;
  u_char bVar2;
  int ti3;
  u_int tu2;
  
  ccount_local = fskid->count;
  l2 = (fskid->m).m[3];
  skidIdx = ccount_local * 0x2b0;
  Render_gWorldMat.m[0][0] = (short)((fskid->m).m[0] >> 4);
  Render_gWorldMat.m[0][1] = (short)((int)l2 >> 4);
  Render_gWorldMat.m[0][2] = (short)((fskid->m).m[6] >> 4);
  Render_gWorldMat.m[1][0] = (short)((fskid->m).m[1] >> 4);
  Render_gWorldMat.m[1][1] = (short)((fskid->m).m[4] >> 4);
  Render_gWorldMat.m[1][2] = (short)((fskid->m).m[7] >> 4);
  Render_gWorldMat.m[2][0] = (short)((fskid->m).m[2] >> 4);
  Render_gWorldMat.m[2][1] = (short)((fskid->m).m[5] >> 4);
  Render_gWorldMat.m[2][2] = (short)((fskid->m).m[8] >> 4);
  do {
    do {
      ccount_local = ccount_local + -1;
      skidIter = skidIdx + -0x2b0;
      if (ccount_local == -1) {
        return;
      }
      pt1_index = (int)(fskid->smp[-1].seg[0].svx + -2) + skidIdx;
      bVar2 = false;
      skidChunk_p = (int)BWorld_IsSliceInBuildList((int)*(short *)((int)&((coorddef *)(pt1_index + 0xc))->x + 2));
      if (skidChunk_p != 0) {
        vert_count = Draw_CircleClip((coorddef *)pt1_index,&fskid->t,0x320000);
        bVar2 = vert_count != 0;
      }
      skidIdx = skidIter;
    } while (!(bool)bVar2);
    ts.x = ((coorddef *)pt1_index)->x - (fskid->t).x;
    ts.y = ((coorddef *)pt1_index)->y - (fskid->t).y;
    ts.z = ((coorddef *)pt1_index)->z - (fskid->t).z;
    transform(&ts.x,(int *)fskid,&td.x);
    Render_gWorldMat.t[0] = td.x >> 6;
    Render_gWorldMat.t[1] = td.y >> 6;
    Render_gWorldMat.t[2] = td.z >> 6;
gte_SetRotMatrix((void *)0x1f800014);
gte_SetTransMatrix((void *)0x1f800014);
    ti2 = ((coorddef *)(pt1_index + 0xc))->x;
    for (depth_skid = 0; depth_skid < (short)ti2; depth_skid = depth_skid + 1) {
      if ((Render_gPacketPtr < Render_gPacketEnd) && (((coorddef *)(pt1_index + 0x24))->y != 0)) {
gte_ldv0((int *)(depth_index));
        gte_rtps();
gte_stlvnl((void *)0x1f800098);
        primPtr = Render_gPacketPtr;
gte_swc2(0xe,(void *)0x1f800008);
gte_ldv0((int *)(depth_index));
        gte_rtps();
gte_stlvnl((void *)0x1f8000a8);
gte_ldv0((int *)(((coorddef *)(pt1_index + 0x24))->y + 8));
        gte_rtps();
gte_stlvnl((void *)0x1f8000b8);
gte_ldv0((int *)(((coorddef *)(pt1_index + 0x24))->y));
        gte_rtps();
gte_stlvnl((void *)0x1f8000c8);
        if (((Skid_gCtrlScratch_98 < Skid_gCtrlPoint_0) ||
            (((Skid_gCtrlPoint_1 < Skid_gCtrlPoint_2 || (Skid_gCtrlPoint_3 < Skid_gCtrlPoint_4)) ||
             (Skid_gCtrlPoint_5 < Skid_gCtrlPoint_6)))) &&
           ((((-Skid_gCtrlScratch_98 < Skid_gCtrlPoint_0 || (-Skid_gCtrlPoint_1 < Skid_gCtrlPoint_2)
              ) || (-Skid_gCtrlPoint_3 < Skid_gCtrlPoint_4)) ||
            (-Skid_gCtrlPoint_5 < Skid_gCtrlPoint_6)))) {
          color_pack = ((coorddef *)(pt1_index + 0x24))->x;
          pmx_dst = (int)&gSkidMarkPixmap[color_pack & 1];
gte_stsxy3((void *)0x1f800014,(void *)0x1f80002c,(void *)0x1f800020);
          gte_avsz4();
gte_swc2(0x7,(void *)0x1f800094);
          vt_y = Skid_gCtrlScratch_94 >> 5;
          Skid_gCtrlScratch_94 = vt_y + 0x32;
          if (Skid_gCtrlScratch_94 < 1) {
            return;
          }
          if (Draw_gViewOtSize + -3 < Skid_gCtrlScratch_94) {
            return;
          }
          if (color_pack == 0) {
            *(int *)((int)primPtr + 4) = ((coorddef *)(pt1_index + 0x18))->z;
            *(int *)((int)primPtr + 0x10) = ((coorddef *)(pt1_index + 0x18))->z;
            *(u_int *)((int)primPtr + 0x28) =
                 *(u_int *)(((coorddef *)(pt1_index + 0x24))->y + 0x10);
            *(u_int *)((int)primPtr + 0x1c) =
                 *(u_int *)(((coorddef *)(pt1_index + 0x24))->y + 0x10);
          }
          else {
            *(u_int *)((int)primPtr + 4) = 0x404040;
            *(u_int *)((int)primPtr + 0x10) = 0x404040;
            *(u_int *)((int)primPtr + 0x28) = 0x404040;
            *(u_int *)((int)primPtr + 0x1c) = 0x404040;
          }
          *(u_char *)((int)primPtr + 7) = 0x3e;
          *(u_char *)((int)primPtr + 3) = 0xc;
          uv_v_pack = *(int *)(pmx_dst + 4);
          uv_u_pack = *(int *)(pmx_dst + 8);
          uv_alpha = *(int *)(pmx_dst + 0xc);
          *(u_int *)((int)primPtr + 0xc) = *(u_int *)pmx_dst;
          *(int *)((int)primPtr + 0x18) = uv_v_pack;
          *(int *)((int)primPtr + 0x24) = uv_u_pack;
          *(int *)((int)primPtr + 0x30) = uv_alpha;
          if (*(short *)((int)primPtr + 0xe) == -1) {
            vert_idx = (vt_y - (short)Skid_gScratchPos1) * 0x10 >> (Skid_gScratchPos2 & 0x1f);
            if (vert_idx < 0) {
              vert_idx = 0;
            }
            else if (0xf < vert_idx) {
              vert_idx = 0xf;
            }
            *(short *)((int)primPtr + 0xe) = gClutDepth[*(u_short *)(pmx_dst + 10)][vert_idx];
          }
          ti3 = Skid_gCtrlScratch_94;
          tp3 = Render_gPalettePtr;
          tu1 = (u_int)(Render_gPalettePtr + Skid_gCtrlScratch_94 * 4 + 2) & 3;
          depth_offset = (int)Render_gPacketPtr << 8;
          tp2 = Render_gPacketPtr + 0x34;
          *(u_int *)Render_gPacketPtr =
               (*(int *)(Render_gPalettePtr + Skid_gCtrlScratch_94 * 4 + 2 + -tu1) << (3 - tu1) * 8
               | (u_int)(Render_gPacketPtr + 0x34) & 0xffffffffU >> (tu1 + 1) * 8) >> 8 | 0xc000000;
          Render_gPacketPtr = tp2;
          tp1 = (int)tp3 + ti3 * 4 + 2;
          tu2 = tp1 & 3;
          *(u_int *)(tp1 - tu2) =
               *(u_int *)(tp1 - tu2) & -1 << (tu2 + 1) * 8 | (u_int)depth_offset >> (3 - tu2) * 8;
        }
      }
      pt1_index = (int)&((coorddef *)(pt1_index + 0x18))->y;
    }
  } while( true );
}

/* ---- DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:3049-3103] SLD-VERIFIED ---- */
void DrawW_SetUpSubdividFacet_Line(Draw_tGiveShelbyMoreCache *sd)

{
  POLY_GT4 * prim;
  u_char tpage_byte;
  u_short a;
  u_char tu8;
  u_char tu9;
  u_char tu10;
  u_short d;
  u_short b;
  u_char tu12;
  u_char tu13;
  u_char uVar1;
  u_char tu14;
  u_short c;
  Draw_SVertex *v2;
  Draw_SVertex *v3;
  Draw_SVertex *v1;
  Draw_SVertex *v0;
  int loc_28;
  int loc_24;
  int loc_20;
  short ts1;
  u_short tu3;
  u_short tu4;
  u_short tu5;
  u_short tu6;
  short ts3;
  short ts4;
  short ts2;
  short ts5;
  short ts6;
  
  DrawW_LoadPrecVECTOR(&sd->v0,&sd->tVn0);
  DrawW_LoadPrecVECTOR(&sd->v1,&sd->tVn1);
  DrawW_LoadPrecVECTOR(&sd->v2,&sd->tVn2);
  DrawW_LoadPrecVECTOR(&sd->v3,&sd->tVn3);
gte_ldv0(((char *)sd + 0x14c));
  gte_rtps();
gte_swc2(0xe,((char *)sd + 0x154));
gte_ldv3(((char *)sd + 0x15c),((char *)sd + 0x16c),((char *)sd + 0x17c));
  gte_rtpt();
  tpage_byte = (sd->GT4Prim).r1;
  tu8 = (sd->GT4Prim).g1;
  tu9 = (sd->GT4Prim).b1;
  tu10 = (sd->GT4Prim).p1;
  uVar1 = (sd->GT4Prim).r0;
  tu12 = (sd->GT4Prim).g0;
  tu13 = (sd->GT4Prim).b0;
  tu14 = (sd->GT4Prim).code;
  (sd->v2).r = tpage_byte;
  (sd->v2).g = tu8;
  (sd->v2).b = tu9;
  (sd->v2).a = tu10;
  (sd->v1).r = tpage_byte;
  (sd->v1).g = tu8;
  (sd->v1).b = tu9;
  (sd->v1).a = tu10;
  (sd->v3).r = uVar1;
  (sd->v3).g = tu12;
  (sd->v3).b = tu13;
  (sd->v3).a = tu14;
  (sd->v0).r = uVar1;
  (sd->v0).g = tu12;
  (sd->v0).b = tu13;
  (sd->v0).a = tu14;
gte_stsxy3(((char *)sd + 0x164),((char *)sd + 0x174),((char *)sd + 0x184));
  tu3 = *(u_short *)(((int)sd + 0x110) + 0xc);
  tu4 = *(u_short *)(((int)sd + 0x110) + 0x18);
  tu5 = *(u_short *)(((int)sd + 0x110) + 0x30);
  tu6 = *(u_short *)(((int)sd + 0x110) + 0x24);
  (sd->v0).u = (char)tu3;
  (sd->v0).v = (char)((u_short)tu3 >> 8);
  (sd->v1).u = (char)tu4;
  (sd->v1).v = (char)((u_short)tu4 >> 8);
  (sd->v2).u = (char)tu5;
  (sd->v2).v = (char)((u_short)tu5 >> 8);
  (sd->v3).u = (char)tu6;
  (sd->v3).v = (char)((u_short)tu6 >> 8);
  ts1 = (sd->v0).dvx;
  (sd->v0).a = '\0';
  if (ts1 < 0x3e9) {
    ts2 = (sd->v0).dvy;
    if ((((1000 < ts2) || (ts1 < -1000)) || (ts2 < -1000)) || ((sd->v0).vz < 0x65))
    goto DrW_SubSetupLine_v0Alpha;
  }
  else {
DrW_SubSetupLine_v0Alpha:
    (sd->v0).a = '\x01';
  }
  ts3 = (sd->v1).dvx;
  (sd->v1).a = '\0';
  if (ts3 < 0x3e9) {
    ts4 = (sd->v1).dvy;
    if (((1000 < ts4) || (ts3 < -1000)) || ((ts4 < -1000 || ((sd->v1).vz < 0x65))))
    goto DrW_SubSetupLine_v1Alpha;
  }
  else {
DrW_SubSetupLine_v1Alpha:
    (sd->v1).a = '\x01';
  }
  ts5 = (sd->v2).dvx;
  (sd->v2).a = '\0';
  if (ts5 < 0x3e9) {
    ts6 = (sd->v2).dvy;
    if (((1000 < ts6) || (ts5 < -1000)) || ((ts6 < -1000 || ((sd->v2).vz < 0x65))))
    goto DrW_SubSetupLine_v2Alpha;
  }
  else {
DrW_SubSetupLine_v2Alpha:
    (sd->v2).a = '\x01';
  }
  ts5 = (sd->v3).dvx;
  (sd->v3).a = '\0';
  if (ts5 < 0x3e9) {
    ts6 = (sd->v3).dvy;
    if ((((ts6 < 0x3e9) && (-0x3e9 < ts5)) && (-0x3e9 < ts6)) && (100 < (sd->v3).vz))
    goto DrW_SubSetupLine_callSubdiv;
  }
  (sd->v3).a = '\x01';
DrW_SubSetupLine_callSubdiv:
  DrawW_SubdividFacet(sd,0,&sd->v0,&sd->v1,&sd->v2,&sd->v3,0,0);
  return;
}

/* ---- DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:3108-3330] SLD-VERIFIED ---- */
void DrawW_OnyxLinePrim(CCOORD16 *geomVertices,Trk_Line *lineQuad,int count,Draw_tGiveShelbyMoreCache *sd)

{
  int linetype;
  int t1;
  int t2;
  long b;
  u_long l3;
  VECTOR temp0;
  u_long l0;
  int ot_addr_pack;
  int vert0_p;
  int CVar19;
  int vert_iter;
  CVECTOR *tC8;
  int color_pack;
  int tu21;
  u_long l1;
  int depth_avg;
  int vert1_p;
  int CVar23;
  int uVar8_00;
  u_long l2;
  u_int uVar1;
  int depth_index;
  u_int uVar2;
  Draw_tGiveShelbyMoreCache *idx;
  int tpage_word;
  int vert_y_pack;
  int v0_pack;
  int v1_pack_ptr;
  int vert_x_pack;
  int drmode_p;
  int ti9;
  POLY_GT4 *prim;
  int primSlot;
  Draw_tPixMap *pmx;
  int pmx_p;
  int lineVerts_p;
  int save_pre_otz;
  int save_pre_otz_l;
  int lineQuadCount;
  int lineIdx;
  CCOORD16 vt0;
  CCOORD16 vt1;
  CCOORD16 vt2;
  CCOORD16 vt3;
  CVECTOR a;
  long bfct;
  int depthcue;
  int loc_30;
  int doSubdivision;
  u_char *tp17;
  void *tp1;
  int tp4;
  int tp5;
  CCOORD16 *tC6;
  int tu1;
  int tp3;
  int tp2;
  u_char *tp6;
  u_int tu2;
  u_int tu4;
  
  sd->offsubdivid = 0x200;
  idx = sd;
  for (lineIdx = 0; tC6 = geomVertices, lineIdx < count + -1; lineIdx = lineIdx + 1) {
    for (; (lineVerts_p = (int)(tC6 + 2), lineIdx < count + -1 && (lineQuad->type != 0xff));
        lineQuad = lineQuad + 1) {
      pmx_p = (int)&gDLPixmap[lineQuad->type];
      vt2.x = geomVertices->x;
      vt2.y = geomVertices->y;
      vt2.z = tC6->z;
      vt2.light = tC6->light;
      (*(int *)&(vt3)) = *(u_int *)lineVerts_p;
      vt3.z = geomVertices[2].z;
      vt3.light = geomVertices[2].light;
      v0_pack = count;
gte_ldv0((int *)(&vt0));
      gte_rtps();
gte_stlvnl(((char *)sd + 0x98));
      tp17 = Render_gPacketPtr;
gte_swc2(0xe,(void *)0x1f800008);
gte_ldv0((int *)(&vt1));
      gte_rtps();
gte_stlvnl(((char *)sd + 0xa8));
gte_ldv0((int *)(&vt2));
      gte_rtps();
gte_stlvnl(((char *)sd + 0xb8));
gte_ldv0((int *)(&vt3));
      gte_rtps();
gte_stlvnl(((char *)sd + 0xc8));
      if ((((((sd->tVn0).vx < (sd->tVn0).vz) || ((sd->tVn1).vx < (sd->tVn1).vz)) ||
           ((sd->tVn2).vx < (sd->tVn2).vz)) || ((sd->tVn3).vx < (sd->tVn3).vz)) &&
         (((-(sd->tVn0).vx < (sd->tVn0).vz || (-(sd->tVn1).vx < (sd->tVn1).vz)) ||
          ((-(sd->tVn2).vx < (sd->tVn2).vz || (-(sd->tVn3).vx < (sd->tVn3).vz)))))) {
gte_stsxy3((void *)0x1f800014,(void *)0x1f80002c,(void *)0x1f800020);
        gte_avsz4();
        v1_pack_ptr = (int)&sd->otz;
gte_swc2(0x7,v1_pack_ptr);
        gte_nclip();
gte_swc2(0x18,&bfct);
        if ((sd->head).mirror == 1) {
          bfct = -bfct;
        }
        if (-1 < bfct) {
          save_pre_otz_l = sd->otz >> 1;
          depth_avg = save_pre_otz_l + 0x4b;
          ot_addr_pack = (int)(sd->otz < 200);
          sd->otz = depth_avg;
          if ((0 < depth_avg) && (depth_avg <= Draw_gViewOtSize + -3)) {
            if (ot_addr_pack == 0) {
              primSlot = (int)(sd->head).cprim.PrimPtr;
              drmode_p = (int)(sd->head).cprim.LastPrim;
              ti9 = drmode_p + sd->otz * 4;
              (sd->head).cprim.PrimPtr = (char *)(primSlot + 0x34);
              tu2 = ti9 + 2;
              tu4 = tu2 & 3;
              *(u_int *)primSlot =
                   (*(int *)(tu2 - tu4) << (3 - tu4) * 8 |
                   (u_int)(primSlot + 0x34) & 0xffffffffU >> (tu4 + 1) * 8) >> 8 | 0xc000000;
              tu2 = ti9 + 2;
              tu4 = tu2 & 3;
              tp5 = tu2 - tu4;
              *(u_int *)tp5 = *(u_int *)tp5 & -1 << (tu4 + 1) * 8 |
                             (u_int)(primSlot << 8) >> (3 - tu4) * 8;
            }
            else {
              primSlot = (int)&sd->GT4Prim;
            }
            tpage_word = ot_addr_pack;
gte_swc2(0x8,&depthcue);
            if (sd->nightFlags == 0) {
              vert_iter = (int)(Chunk_lightTable + vt3.light);
              tu2 = vert_iter + 3U & 3;
              tu1 = vert_iter & 3;
              *(u_int *)&a = ((*(int *)((vert_iter + 3U) - tu2) << (3 - tu2) * 8 |
                            v0_pack & 0xffffffffU >> (tu2 + 1) * 8) & -1 << (4 - tu1) * 8 |
                           *(u_int *)(vert_iter - tu1) >> tu1 * 8);
              tp1 = &a.cd;
              tu2 = (u_int)tp1 & 3;
              *(u_int *)((int)tp1 - tu2) =
                   *(u_int *)((int)tp1 - tu2) & -1 << (tu2 + 1) * 8 | (*(u_int *)&a) >> (3 - tu2) * 8;
gte_ldrgb(&a);
              gte_ldIR0(depthcue);
              gte_dpcs();
gte_swc2(0x16,((char *)sd + 0x12c));
              tu2 = (u_int)&((POLY_GT4 *)primSlot)->p2 & 3;
              tu4 = (u_int)&((POLY_GT4 *)primSlot)->r2 & 3;
              vert_x_pack = (*(int *)(&((POLY_GT4 *)primSlot)->p2 + -tu2) << (3 - tu2) * 8 |
                            v1_pack_ptr & 0xffffffffU >> (tu2 + 1) * 8) & -1 << (4 - tu4) * 8 |
                            *(u_int *)(&((POLY_GT4 *)primSlot)->r2 + -tu4) >> tu4 * 8;
              tu2 = (u_int)&((POLY_GT4 *)primSlot)->code & 3;
              tp4 = (int)&((POLY_GT4 *)primSlot)->code - tu2;
              *(u_int *)tp4 = *(u_int *)tp4 & -1 << (tu2 + 1) * 8 | (u_int)vert_x_pack >> (3 - tu2) * 8
              ;
              tu2 = (u_int)&((POLY_GT4 *)primSlot)->r0 & 3;
              tp3 = (int)&((POLY_GT4 *)primSlot)->r0 - tu2;
              *(u_int *)tp3 = *(u_int *)tp3 & 0xffffffffU >> (4 - tu2) * 8 | vert_x_pack << tu2 * 8;
              tC8 = Chunk_lightTable + vt2.light;
              tu2 = (u_int)&tC8->cd & 3;
              tu4 = (u_int)tC8 & 3;
              *(u_int *)&a = ((*(int *)(&tC8->cd + -tu2) << (3 - tu2) * 8 |
                            vert_x_pack & 0xffffffffU >> (tu2 + 1) * 8) & -1 << (4 - tu4) * 8 |
                           *(u_int *)((int)tC8 - tu4) >> tu4 * 8);
              tp2 = (int)&a.cd;
              tu2 = tp2 & 3;
              *(u_int *)(tp2 - tu2) =
                   *(u_int *)(tp2 - tu2) & -1 << (tu2 + 1) * 8 | (*(u_int *)&a) >> (3 - tu2) * 8;
gte_ldrgb(&a);
              gte_ldIR0(depthcue);
              gte_dpcs();
gte_swc2(0x16,((char *)sd + 0x138));
              tu2 = (u_int)&((POLY_GT4 *)primSlot)->p3 & 3;
              tu4 = (u_int)&((POLY_GT4 *)primSlot)->r3 & 3;
              vert_y_pack = (*(int *)(&((POLY_GT4 *)primSlot)->p3 + -tu2) << (3 - tu2) * 8 |
                            tpage_word & 0xffffffffU >> (tu2 + 1) * 8) & -1 << (4 - tu4) * 8 |
                            *(u_int *)(&((POLY_GT4 *)primSlot)->r3 + -tu4) >> tu4 * 8;
              tu2 = (u_int)&((POLY_GT4 *)primSlot)->p1 & 3;
              tp6 = &((POLY_GT4 *)primSlot)->p1 + -tu2;
              *(u_int *)tp6 = *(u_int *)tp6 & -1 << (tu2 + 1) * 8 | (u_int)vert_y_pack >> (3 - tu2) * 8
              ;
              tu2 = (u_int)&((POLY_GT4 *)primSlot)->r1 & 3;
              tp6 = &((POLY_GT4 *)primSlot)->r1 + -tu2;
              *(u_int *)tp6 = *(u_int *)tp6 & 0xffffffffU >> (4 - tu2) * 8 | vert_y_pack << tu2 * 8;
            }
            else {
              if ((sd->nightFlags & 1U) != 0) {
gte_SetRotMatrix(((char *)sd + 0x34));
gte_SetTransMatrix(((char *)sd + 0x34));
gte_ldv0((int *)(&vt2));
                gte_rt();
gte_stlvnl(&temp0);
gte_ldv0((int *)(&vt3));
                gte_rt();
                Night_NightCalc((VECTOR *)&a,&vt2.light,sd)
                ;
gte_stlvnl(&temp0);
                Night_NightCalc((VECTOR *)&a,&vt3.light,sd)
                ;
              }
              if (BW_gCopCarObj != (Car_tObj *)0x0) {
gte_SetRotMatrix(((char *)sd + 0x54));
gte_SetTransMatrix(((char *)sd + 0x54));
gte_ldv0((int *)(&vt2));
                gte_rt();
gte_stlvnl(&temp0);
gte_ldv0((int *)(&vt3));
                gte_rt();
                Night_NightCopCalc((VECTOR *)&a,(short *)idx);
gte_stlvnl(&temp0);
                Night_NightCopCalc((VECTOR *)&a,(short *)idx);
              }
              vert1_p = (int)(Chunk_lightTable + vt3.light);
              vert0_p = (int)(Chunk_lightTable + vt2.light);
              CVar19 = *(int *)vert0_p;
              CVar23 = *(int *)vert1_p;
              ((POLY_GT4 *)primSlot)->r3 = (char)CVar19;
              ((POLY_GT4 *)primSlot)->g3 = (char)((u_int)CVar19 >> 8);
              ((POLY_GT4 *)primSlot)->b3 = (char)((u_int)CVar19 >> 0x10);
              ((POLY_GT4 *)primSlot)->p3 = (char)((u_int)CVar19 >> 0x18);
              ((POLY_GT4 *)primSlot)->r1 = (char)CVar19;
              ((POLY_GT4 *)primSlot)->g1 = (char)((u_int)CVar19 >> 8);
              ((POLY_GT4 *)primSlot)->b1 = (char)((u_int)CVar19 >> 0x10);
              ((POLY_GT4 *)primSlot)->p1 = (char)((u_int)CVar19 >> 0x18);
              ((POLY_GT4 *)primSlot)->r2 = (char)CVar23;
              ((POLY_GT4 *)primSlot)->g2 = (char)((u_int)CVar23 >> 8);
              ((POLY_GT4 *)primSlot)->b2 = (char)((u_int)CVar23 >> 0x10);
              ((POLY_GT4 *)primSlot)->p2 = (char)((u_int)CVar23 >> 0x18);
              ((POLY_GT4 *)primSlot)->r0 = (char)CVar23;
              ((POLY_GT4 *)primSlot)->g0 = (char)((u_int)CVar23 >> 8);
              ((POLY_GT4 *)primSlot)->b0 = (char)((u_int)CVar23 >> 0x10);
              ((POLY_GT4 *)primSlot)->code = (char)((u_int)CVar23 >> 0x18);
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
            }
            ((POLY_GT4 *)primSlot)->code = '>';
            *(u_char *)((int)&((POLY_GT4 *)primSlot)->tag + 3) = 0xc;
            color_pack = *(int *)pmx_p;
            uVar8_00 = *(int *)(pmx_p + 4);
            uVar1 = *(u_int *)(pmx_p + 8);
            uVar2 = *(u_int *)(pmx_p + 0xc);
            ((POLY_GT4 *)primSlot)->u0 = (char)color_pack;
            ((POLY_GT4 *)primSlot)->v0 = (char)((u_int)color_pack >> 8);
            ((POLY_GT4 *)primSlot)->clut = (short)((u_int)color_pack >> 0x10);
            ((POLY_GT4 *)primSlot)->u1 = (char)uVar8_00;
            ((POLY_GT4 *)primSlot)->v1 = (char)((u_int)uVar8_00 >> 8);
            ((POLY_GT4 *)primSlot)->tpage = (short)((u_int)uVar8_00 >> 0x10);
            ((POLY_GT4 *)primSlot)->u2 = (char)uVar1;
            ((POLY_GT4 *)primSlot)->v2 = (char)((u_int)uVar1 >> 8);
            ((POLY_GT4 *)primSlot)->pad2 = (short)((u_int)uVar1 >> 0x10);
            ((POLY_GT4 *)primSlot)->u3 = (char)uVar2;
            ((POLY_GT4 *)primSlot)->v3 = (char)((u_int)uVar2 >> 8);
            ((POLY_GT4 *)primSlot)->pad3 = (short)((u_int)uVar2 >> 0x10);
            if (((POLY_GT4 *)primSlot)->clut == 0xffff) {
              ti9 = (save_pre_otz_l - sd->startfog) * 0x10 >> ((int)sd->distfog & 0x1fU);
              if (ti9 < 0) {
                ti9 = 0;
              }
              else if (0xf < ti9) {
                ti9 = 0xf;
              }
              ((POLY_GT4 *)primSlot)->clut = gClutDepth[*(u_short *)(pmx_p + 10)][ti9];
            }
            if (ot_addr_pack != 0) {
gte_SetRotMatrix(((char *)sd + 0x74));
gte_SetTransMatrix(((char *)sd + 0x74));
              if (stackSpeedUpEnbabledFlag == 0) {
                DrawW_SetUpSubdividFacet_Line(sd);
              }
              else {
                tu21 = (int)SetSp((void *)gWSavePtr);
                stackSpeedUpEnbabledFlag = 0;
                gWSavePtr = tu21;
                DrawW_SetUpSubdividFacet_Line(sd);
                gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
                stackSpeedUpEnbabledFlag = 1;
              }
gte_SetRotMatrix(((char *)sd + 0x14));
gte_SetTransMatrix(((char *)sd + 0x14));
            }
          }
        }
      }
      lineIdx = lineIdx + 1;
      geomVertices = geomVertices + 2;
      tC6 = (CCOORD16 *)lineVerts_p;
    }
    lineQuad = lineQuad + 1;
    geomVertices = geomVertices + 2;
  }
  return;
}

/* ---- DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16  [DRAWW.CPP:3344-3392] SLD-VERIFIED ---- */
void DrawW_BuildChunkCenterLineFacets(Chunk *chunkDat,Group *group,Draw_tGiveShelbyMoreCache *sd,COORD16 *trans)

{
  u_char bVar1;
  u_char bVar2;
  short sVar3;
  short sVar4;
  short sVar5;
  short sVar6;
  short sVar7;
  short sVar8;
  short sVar9;
  bool bVar10;
  u_char *pbVar11;
  short sVar12;
  short sVar13;
  short sVar14;
  Trk_NewSlice *pTVar15;
  Group *pThis;
  Group *pGVar16;
  int iVar17;
  short x;
  short y;
  short z;
  CCOORD16 *pts;
  short wz;
  Group *pGVar18;
  short wx;
  short wy;
  short *psVar19;
  CCOORD16 *pts3d;
  CCOORD16 *pCVar20;
  Trk_Line *lineQuad;
  int i;
  int iVar21;
  short tz;
  short ty;
  CCOORD16 *wpts;
  int slice;
  short tx;
  
  pTVar15 = BWorldSm_slices;
  pCVar20 = gVertex3d;
  iVar21 = 0;
  psVar19 = &gVertex3d[0].light;
  sVar3 = chunkDat->firstSimSliceInd;
  sVar4 = trans->x;
  sVar5 = trans->y;
  sVar6 = trans->z;
  pGVar16 = chunkDat->vertexBuf;
  pbVar11 = (u_char *)group;
  while( true ) {
    bVar10 = *(int *)(u_char *)group << 1 <= iVar21;
    iVar21 = iVar21 + 2;
    if (bVar10) break;
    pts = (CCOORD16 *)(u_int)pbVar11[4];
    iVar17 = (int)sVar3 + (u_int)pbVar11[5];
    pGVar18 = pGVar16 + (int)pts * 2 + 1;
    bVar1 = pTVar15[iVar17].right[1];
    bVar2 = pTVar15[iVar17].right[2];
    sVar7 = (short)pGVar18->m_num_elements;
    sVar8 = *(short *)((int)&pGVar18->m_num_elements + 2);
    sVar9 = (short)pGVar18[1].m_num_elements;
    sVar12 = (short)((int)((u_int)(u_char)pTVar15[iVar17].right[0] << 0x18) >> 0x1b);
    pCVar20->x = sVar4 + (sVar7 - sVar12);
    sVar13 = (short)((int)((u_int)bVar1 << 0x18) >> 0x1b);
    psVar19[-2] = sVar5 + (sVar8 - sVar13);
    sVar14 = (short)((int)((u_int)bVar2 << 0x18) >> 0x1b);
    psVar19[-1] = sVar6 + (sVar9 - sVar14);
    *psVar19 = *(short *)((int)&pGVar18[1].m_num_elements + 2);
    pCVar20[1].x = sVar4 + sVar7 + sVar12;
    psVar19[2] = sVar5 + sVar8 + sVar13;
    psVar19[3] = sVar6 + sVar9 + sVar14;
    pCVar20 = pCVar20 + 2;
    psVar19[4] = *(u_short *)((int)&pGVar18[1].m_num_elements + 2);
    psVar19 = psVar19 + 8;
    pbVar11 = pbVar11 + 4;
  }
  DrawW_OnyxLinePrim(gVertex3d,(Trk_Line *)((u_char *)group + 4),*(int *)(u_char *)group,sd);
  return;
}

/* ---- DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache  [DRAWW.CPP:3396-3467] SLD-VERIFIED ---- */
void DrawW_DoLines(DRender_tView *Vi,tBuildEntry *buildList,Draw_DCache *sd)

{
  int chunkCount;
  int buildInd;
  Chunk *chunkDat;
  int geomRez;
  Group *group;
  COORD16 trans;
  coorddef tmp;
  coorddef tmp2;
  coorddef *pChunkCp;
  u_char bVar1;

  chunkCount = BWorld_gChunkCount;
  sd->doublelayer = 0;
  (sd->matB).t[2] = 0;
  (sd->matB).t[1] = 0;
  (sd->matB).t[0] = 0;
  gte_SetTransMatrix(&sd->matB);
  for (buildInd = 0; buildInd < chunkCount; buildInd = buildInd + 1) {
    geomRez = (signed char)buildList->geomRez;
    if (geomRez == 4) {
      chunkDat = Track_chunkList + buildList->chunkInd;
      group = chunkDat->lineBuf;
      if ((group != (Group *)0x0) && ((buildList->enableBits & 4U) != 0)) {
        if (gNight_renderNight != 0) {
          bVar1 = *(u_char *)((int)sd[1].matB.t + 2);
          *(u_char *)((int)sd[1].matB.t + 2) = bVar1 | 4;
          if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
            *(u_char *)((int)sd[1].matB.t + 2) = bVar1 | 5;
          }
          tmp.x = (Vi->cview).translation.x - ((Camera_gInfo[Vi->player].target)->position).x;
          tmp.y = (Vi->cview).translation.y - ((Camera_gInfo[Vi->player].target)->position).y;
          tmp.z = (Vi->cview).translation.z - ((Camera_gInfo[Vi->player].target)->position).z;
          transform(&tmp.x,gNightMat.m,&tmp2.x);
          DrawW_WorldSetUpTranslation(&tmp2,&sd->matNight);
          if (BW_gCopCarObj != (Car_tObj *)0x0) {
            tmp.x = (Vi->cview).translation.x - (BW_gCopCarObj->N).position.x;
            tmp.y = (Vi->cview).translation.y - (BW_gCopCarObj->N).position.y;
            tmp.z = (Vi->cview).translation.z - (BW_gCopCarObj->N).position.z;
            transform(&tmp.x,gCopMat.m,&tmp2.x);
            DrawW_WorldSetUpTranslation(&tmp2,&sd->matCop);
          }
          (sd->matB).t[2] = 0;
          (sd->matB).t[1] = 0;
          (sd->matB).t[0] = 0;
          gte_SetTransMatrix(&sd->matB);
        }
        pChunkCp = Chunk_chunkCenters + buildList->chunkInd;
        trans.x = (short)(pChunkCp->x - (Vi->cview).translation.x >> 10);
        trans.y = (short)(pChunkCp->y - (Vi->cview).translation.y >> 10);
        trans.z = (short)(pChunkCp->z - (Vi->cview).translation.z >> 10);
        DrawW_BuildChunkCenterLineFacets(chunkDat,group,(Draw_tGiveShelbyMoreCache *)sd,&trans);
      }
    }
    buildList = buildList + 1;
  }
  return;
}

/* ---- DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache  [DRAWW.CPP:3692-3815] SLD-VERIFIED ---- */
void DrawW_BuildSpikeBelt(DRender_tView *Vi,int scale,Draw_DCache *sd)

{
  int i;
  short sVar1;
  short sVar2;
  short sVar3;
  short sVar4;
  u_char uVar5;
  int slice;
  u_int uVar6;
  u_int uVar7;
  u_int uVar8;
  int iVar9;
  Trk_NewSlice *pTVar10;
  CCOORD16 *pCVar11;
  int j;
  int iVar12;
  short sz;
  short sVar13;
  int iVar14;
  short sVar15;
  short sVar16;
  short sVar17;
  short sVar18;
  short wz;
  short wy;
  short wx;
  CCOORD16 vertex3d [27];
  Trk_Quad quads [16];
  Track_tMaterial material;
  coorddef tmp;
  coorddef tmp2;
  short fx;
  short fy;
  short fz;
  short sx;
  short sy;
  coorddef *cp;
  
  iVar9 = gSpikeBeltSlice;
  pTVar10 = BWorldSm_slices + gSpikeBeltSlice;
  if (scale < 0) {
    scale = scale + 7;
  }
  iVar14 = scale >> 3;
  uVar6 = fixedmult((int)pTVar10->right[0] << 9,iVar14);
  uVar7 = fixedmult((int)BWorldSm_slices[iVar9].right[1] << 9,iVar14);
  uVar8 = fixedmult((int)BWorldSm_slices[iVar9].right[2] << 9,iVar14);
  sVar18 = (short)((int)BWorldSm_slices[iVar9].forward[0] >> 1);
  sVar17 = (short)((int)BWorldSm_slices[iVar9].forward[1] >> 1);
  sVar16 = (short)((int)BWorldSm_slices[iVar9].forward[2] >> 1);
  iVar14 = fixedmult(gSpikeBeltX,(int)BWorldSm_slices[iVar9].right[0] << 9);
  sVar15 = (short)(iVar14 >> 10);
  iVar14 = fixedmult(gSpikeBeltX,(int)BWorldSm_slices[iVar9].right[1] << 9);
  sVar13 = (short)(iVar14 >> 10);
  iVar9 = fixedmult(gSpikeBeltX,(int)BWorldSm_slices[iVar9].right[2] << 9);
  iVar14 = 1;
  pCVar11 = vertex3d;
  vertex3d[9].z = (short)(iVar9 >> 10);
  vertex3d[0].x = sVar15 - sVar18;
  vertex3d[0].y = sVar13 - sVar17;
  vertex3d[0].z = vertex3d[9].z - sVar16;
  vertex3d[0].light = 0;
  iVar9 = 0;
  do {
    pCVar11 = pCVar11 + 1;
    sVar2 = (short)(uVar6 >> 10);
    pCVar11->x = *(short *)((int)&vertex3d[0].x + iVar9) + sVar2;
    sVar3 = (short)(uVar7 >> 10);
    pCVar11->y = *(short *)((int)&vertex3d[0].y + iVar9) + sVar3;
    sVar1 = *(short *)((int)&vertex3d[0].z + iVar9);
    iVar14 = iVar14 + 1;
    pCVar11->light = 0;
    sVar4 = (short)(uVar8 >> 10);
    pCVar11->z = sVar1 + sVar4;
    iVar9 = iVar9 + 8;
  } while (iVar14 < 9);
  iVar14 = 1;
  iVar12 = 0x50;
  vertex3d[9].light = 0;
  vertex3d[9].x = sVar15;
  vertex3d[9].y = sVar13 + 0x19;
  iVar9 = 0x48;
  do {
    *(short *)((int)&vertex3d[0].x + iVar12) = *(short *)((int)&vertex3d[0].x + iVar9) + sVar2;
    *(short *)((int)&vertex3d[0].y + iVar12) = *(short *)((int)&vertex3d[0].y + iVar9) + sVar3;
    sVar1 = *(short *)((int)&vertex3d[0].z + iVar9);
    iVar14 = iVar14 + 1;
    *(u_short *)((int)&vertex3d[0].light + iVar12) = 0;
    *(short *)((int)&vertex3d[0].z + iVar12) = sVar1 + sVar4;
    iVar12 = iVar12 + 8;
    iVar9 = iVar9 + 8;
  } while (iVar14 < 9);
  iVar14 = 1;
  vertex3d[0x12].x = sVar15 + sVar18;
  iVar12 = 0x98;
  vertex3d[0x12].light = 0;
  vertex3d[0x12].y = sVar13 + sVar17;
  vertex3d[0x12].z = vertex3d[9].z + sVar16;
  iVar9 = 0x90;
  do {
    *(short *)((int)&vertex3d[0].x + iVar12) = *(short *)((int)&vertex3d[0].x + iVar9) + sVar2;
    *(short *)((int)&vertex3d[0].y + iVar12) = *(short *)((int)&vertex3d[0].y + iVar9) + sVar3;
    sVar13 = *(short *)((int)&vertex3d[0].z + iVar9);
    iVar14 = iVar14 + 1;
    *(u_short *)((int)&vertex3d[0].light + iVar12) = 0;
    *(short *)((int)&vertex3d[0].z + iVar12) = sVar13 + sVar4;
    iVar12 = iVar12 + 8;
    iVar9 = iVar9 + 8;
  } while (iVar14 < 9);
  iVar14 = 0;
  iVar9 = 0;
  do {
    iVar14 = (iVar14 + iVar9) * 2;
    iVar12 = iVar9 + 1;
    uVar5 = (u_char)iVar9;
    iVar9 = iVar9 + 8;
    quads[0].aPoints[iVar14 + 3] = uVar5;
    (quads[0].aPoints + iVar14 + -2)[0] = '\0';
    (quads[0].aPoints + iVar14 + -2)[1] = '\0';
    quads[0].aPoints[iVar14] = (u_char)iVar12;
    quads[0].aPoints[iVar14 + 1] = uVar5 + '\n';
    quads[0].aPoints[iVar14 + 2] = uVar5 + '\t';
    quads[iVar9].material = 0;
    quads[iVar9].aPoints[1] = uVar5 + '\t';
    quads[iVar9].aPoints[2] = uVar5 + '\n';
    quads[iVar9].aPoints[3] = uVar5 + '\x13';
    quads[iVar9].aPoints[0] = uVar5 + '\x12';
    iVar14 = iVar12 * 2;
    iVar9 = iVar12;
  } while (iVar12 < 8);
  material.flag = '\0';
  material.mipmap_offset = '\0';
  material.pmxIndex = (short)gInitialArt.shapeCount + -1;
  *(u_char *)((int)sd[1].matB.t + 2) = 0;
  tmp.x = pTVar10->center[0] - (Vi->cview).translation.x;
  tmp.y = pTVar10->center[1] - (Vi->cview).translation.y;
  tmp.z = pTVar10->center[2] - (Vi->cview).translation.z;
  transform(&tmp.x,gWorldMat.m,&tmp2.x);
  DrawW_WorldSetUpTranslation(&tmp2,&sd->matB);
  sd[1].head.cprim.PrimPtr = (char *)vertex3d;
  *(u_char *)((int)&sd[1].head.cprim.MPrimPtr + 3) = 0x10;
  sd[1].head.mirror = (int)quads;
  sd[1].head.clipW = 0x23;
  sd[1].head.clipH = 0;
  *(Track_tMaterial **)sd[1].matB.m[0] = &material;
  *(u_int *)(sd[1].matB.m[0] + 2) = 0;
  sd[1].matB.m[1][1] = 0;
  *(u_char *)((int)sd[1].matB.t + 3) = 0;
  sd->light = -1;
  DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache *)sd);
  return;
}

/* ---- DepthCue_Init__Fv  [DRAWW.CPP:3830-3834] SLD-VERIFIED ---- */
void DepthCue_Init(void)

{
  SetFogNear(TrackSpec_gSpec.depthcuespec.distance << 6,0xa0);
  SetFarColor((u_int)TrackSpec_gSpec.depthcuespec.color.r,(u_int)TrackSpec_gSpec.depthcuespec.color.g,
             (u_int)TrackSpec_gSpec.depthcuespec.color.b);
  return;
}

/* end of draww.cpp */
