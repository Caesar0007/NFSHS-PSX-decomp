/* game/psx/draww.cpp -- RECONSTRUCTED (NFS4 PSX world-geometry draw; C++ TU)
 *   35 fns: subdivision facets, world matrix/translation setup, night colour calc, DrawW_DrawQuad,
 *   object/chunk facet builders, object transforms, skidmarks, lines/spike-belt, anim timers, depth cue.
 *   GTE-heavy (142 cop2 stubs -> gte_ intrinsics). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "draww_externs.h"

/* file-local gte_rtps variant with a DEAD "r" input (no code emitted for it -- the value
 * is already in a register): a ref-count nudge for the v4/v8 reload-eviction tie
 * (see DrawW_SubdividFacet MATCH notes). PSX-only; host stub ignores it. */
#if defined(__mips__)
#define gte_rtps_u(u) __asm__ volatile ("nop\n\tnop\n\t.word 0x4A180001" : : "r"(u))
#else
#define gte_rtps_u(u) ((void)(u))
#endif

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
  /* MATCH (2026-07-04, was 50 diffs -> 10, insns now EXACT 34==34): SYM (nfs4-f-v3.txt
     @0x800C51FC) names FOUR outer-scope locals `z0`/`z1`/`z2`/`z3` (one per vertex's vz)
     -- the oracle reads ALL FOUR UPFRONT (v0/v1/v2/v3's vz, in that order) BEFORE any
     compare, then funnels the running-min through self-reassignment of the SAME reg
     ($a1) at each new-min step -- the previous interleaved read-then-compare-then-read
     shape only read 2 z's before the first branch. Load-batch-then-compute (same idiom
     as DrawW_WorldSetUpMatrix) reproduces the WHOLE min-chain byte-identical.
     MATCH 100% (2026-07-08): the tail is a FLAT DESCENDING guard-chain of direct
     returns -- `if (0x500 < minz) return 1; if (0x200 < minz) return 2; return 3;`
     (the natural LOD selector). Direct return-literals expand straight into $v0 (no
     iVar1 funnel var / no `addu v0,v1` copy), and the DESCENDING `0xN < minz` guard
     order gives the oracle's beqz-to-far-block layout + duplicated `jr` returns.
     Every funnel/ternary/nested form leaves the value in $v1 + a copy (14 diffs), and
     the ascending/nested direct-return orders flip branch polarity (6-10 diffs). */
  int iVar1;
  int minz;
  int z0;
  int z1;
  int z2;
  int z3;

  z0 = (int)v0->vz;
  z1 = (int)v1->vz;
  z2 = (int)v2->vz;
  z3 = (int)v3->vz;
  minz = z0;
  if (z1 < z0) {
    minz = z1;
  }
  if (z2 < minz) {
    minz = z2;
  }
  if (z3 < minz) {
    minz = z3;
  }
  minz = minz + sd->offsubdivid;
  if (0x800 < minz) {
    return 0;
  }
  if (0x500 < minz) {
    return 1;
  }
  if (0x200 < minz) {
    return 2;
  }
  return 3;
}

/* ---- DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss  [DRAWW.CPP:425-590] SLD-VERIFIED ----
 * MATCH (2026-07-10 SYM-structure rewrite, 3.8b): the SYM 8c block is the variable map --
 *   r_div ($s0, fn-scope) = &gDiv held across the CalcSubdivision call; midpoints are REAL
 *   Draw_SVertex* locals v4($s3) v5($s5) v6($s7) v7($s6) v8(AUTO 0x48) in the line-28 block;
 *   FIVE nested { int flag; } blocks (AUTO 0x20..0x30, address taken by gte_stflg);
 *   params l/v1/v2/v3/n/subDivide are class ARG (stack homes; v2 copied to $fp REG),
 *   with local AUTO SHORT copies of n(0x38)/subDivide(0x40) = gcc's narrowing of the
 *   short params under register pressure -- so the source REUSES n (`n = n + 5`) and
 *   l (`l = l + 1`), no n_00/l_00 temps.  All other Ghidra temps (tp2-tp5, tu*, newVert_*,
 *   subOtz_local, midX_01) were compiler temps -- NOT C variables (SYM has no record).
 *   doublelayer block: { POLY_GT3 *prim($a0); int otz($s0); } + flat goto web (each failed
 *   vertex test jumps PAST the edges that would re-test it); each GT3 emit = a nested
 *   block { POLY_GT3 *prim; u_int *pal; } (inline-helper scope, invisible to the SYM --
 *   gcc-2.8 sdb drops inlined scopes; the block-local prim gets the $a0 call-arg
 *   suggestion in LOCAL-alloc, and pal keeps the palette slot single-eval across the
 *   aliasing *prim store).  Leaf: { POLY_GT4 *prim($s3); } + { long bfct(AUTO 0x34); }
 *   and the OT-link done by the EA DMPSX-analog FIXED-REG template ($t4-$t6 scratches,
 *   lwl/swl 24-bit insert; operand 3 = &sd->otz).
 *   gte_rtps_u(v4)/gte_rtps_u(sd) in flag-blocks 1/2 = DEAD asm inputs (fastmovf.c
 *   dummy-input family, 0 insns emitted): +1 REG_N_REFS each on v4/sd -- breaks the
 *   reload spill-reg eviction tie (s3-vs-s4) that otherwise spills v4 instead of v8,
 *   and keeps sd above v4 in global-alloc priority (sd=s2, v4=s3, v8=AUTO 0x48 = the
 *   SYM allocation).  840 -> 262 this pass; residual bands: pivot-chain addiu base
 *   (n+k from n vs from a3=n+1, related-value CSE), GT3-emit t1/t2/t3 mask+addr
 *   rotation + advance-addiu schedule, reload-reg naming cascades (t7/t8/t9/s4),
 *   leaf prim a0-coalesce (oracle s3 + addu copy = placeholder-call artifact).
 *   All operand/coloring class, count near-exact (586 vs 588) -- permuter targets. */
void DrawW_SubdividFacet(Draw_tGiveShelbyMoreCache *sd,int l,Draw_SVertex *v0,Draw_SVertex *v1,
               Draw_SVertex *v2,Draw_SVertex *v3,short n,short subDivide)

{
  Draw_SubdivStruct *r_div;   /* SYM: REG $s0, fn scope */

  if ((((v0->dvx > (sd->head).clipW) && ((sd->head).clipW < v1->dvx)) && ((sd->head).clipW < v2->dvx)) &&
      ((sd->head).clipW < v3->dvx)) {
    return;
  }
  if (((v0->dvx < 0) && (v1->dvx < 0)) && ((v2->dvx < 0 && (v3->dvx < 0)))) {
    return;
  }
  if ((((v0->dvy > (sd->head).clipH) && ((sd->head).clipH < v1->dvy)) &&
      (((sd->head).clipH < v2->dvy && ((sd->head).clipH < v3->dvy))))) {
    return;
  }
  if ((((v0->dvy < 0) && (v1->dvy < 0)) && (v2->dvy < 0)) && (v3->dvy < 0)) {
    return;
  }
  if (((v0->vz < 0) && (v1->vz < 0)) && ((v2->vz < 0 && (v3->vz < 0)))) {
    return;
  }
  r_div = &gDiv;
  if (l < DrawW_CalcSubdivision(sd,v0,v1,v2,v3)) {
    Draw_SVertex *v8;   /* SYM: AUTO sp+0x48 */
    Draw_SVertex *v4;   /* SYM: REG $s3 */
    Draw_SVertex *v5;   /* SYM: REG $s5 */
    Draw_SVertex *v6;   /* SYM: REG $s7 */
    Draw_SVertex *v7;   /* SYM: REG $s6 */

    /* RESIDUAL (2026-07-11, re-verified not source-shapable): oracle computes
       v5/v6/v7/v8's indices as `n1=n+1` then `n1+1,n1+2,n1+3` (each independent
       off n1, not chained n+2-from-(n+1)) plus the new `n=n1+4` -- vs ours
       deriving n+1..n+4 straight from `n`. TRIED: an explicit `short n1=n+1;`
       intermediate with v6/v7/v8/n all written in terms of n1 (matching the
       oracle's exact dependency graph) -- cc1plpsx folds `n1+1` back to `n+2`
       (etc) at the RTL level regardless of the source chain, so the generated
       code is BYTE-IDENTICAL either way (confirmed, reverted to the simpler
       form). This 2-insn-short register-coloring tie (v1<->a3 swap on the
       n+1/n+2 computation, cascading a t8<->t9/t2<->t3/t1<->t2 rename through
       the 4 repeated GT3-prim-add blocks later in the fn) is a genuine
       allocator-internal floor, not reachable by a source-order lever;
       permuter candidate (not run here -- fn is large/GTE-heavy, see the two
       already-running permuter jobs on the smaller Night_* fns for the
       time-budget tradeoff). */
    v4 = &r_div->v[n];
    n = n + 1;
    v5 = &r_div->v[n];
    v6 = &r_div->v[(short)(n + 1)];
    v7 = &r_div->v[(short)(n + 2)];
    v8 = &r_div->v[(short)(n + 3)];
    n = n + 4;
    DrawW_DivVertice(v4,v0,v1);
    {
      int flag;
      gte_ldv0(v4);
      gte_rtps_u(v4);
      DrawW_DivVertice(v5,v1,v2);   /* CPU work in the GTE latency window */
      gte_stflg(&flag);
      if (flag < 0) {
        v4->a = 1;
      }
      else {
        v4->a = 0;
      }
    }
    {
      int flag;
      gte_stsxy(&v4->dvx);
      gte_ldv0(v5);
      gte_rtps_u(sd);
      DrawW_DivVertice(v6,v2,v3);
      gte_stflg(&flag);
      if (flag < 0) {
        v5->a = 1;
      }
      else {
        v5->a = 0;
      }
    }
    {
      int flag;
      gte_stsxy(&v5->dvx);
      gte_ldv0(v6);
      gte_rtps();
      DrawW_DivVertice(v7,v3,v0);
      gte_stflg(&flag);
      if (flag < 0) {
        v6->a = 1;
      }
      else {
        v6->a = 0;
      }
    }
    {
      int flag;
      gte_stsxy(&v6->dvx);
      gte_ldv0(v7);
      gte_rtps();
      DrawW_DivVertice(v8,v0,v2);
      gte_stflg(&flag);
      if (flag < 0) {
        v7->a = 1;
      }
      else {
        v7->a = 0;
      }
    }
    {
      int flag;
      gte_stsxy(&v7->dvx);
      gte_ldv0(v8);
      gte_rtps();
      gte_stflg(&flag);
      if (flag < 0) {
        v8->a = 1;
      }
      else {
        v8->a = 0;
      }
    }
    if (sd->doublelayer != 0) {
      POLY_GT3 *prim;   /* SYM: REG $a0 */
      int otz;          /* SYM: REG $s0 (r_div dead by here) */

      (sd->GT4Prim).code = (sd->GT4Prim).code & 0xf7;
      otz = sd->otz + 8;
      if (v0->a) goto DrawWSubdiv_edge1;
      if (v1->a) goto DrawWSubdiv_edge2;
      if (v4->a) goto DrawWSubdiv_edge1;
      {
        POLY_GT3 *prim;   /* block-local (inline-helper scope) */
        u_int *pal;
        prim = (POLY_GT3 *)Render_gPacketPtr;
        pal = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
        *(u_int *)prim = (*(u_int *)prim & 0xff000000) | (*pal & 0xffffff);
        {
          u_int t = *pal;   /* MATCH: bump store sits between pal load and pal store (oracle) */
          Render_gPacketPtr = (u_char *)prim + 0x28;
          *pal = ((u_int)prim & 0xffffff) | (t & 0xff000000);
        }
        DrawW_AddSubdividPrimGT3(prim,v0,v1,v4,sd);
      }
DrawWSubdiv_edge1:
      if (v1->a) goto DrawWSubdiv_edge2;
      if (v2->a) goto DrawWSubdiv_edge3;
      if (v5->a) goto DrawWSubdiv_edge2;
      {
        POLY_GT3 *prim;   /* block-local (inline-helper scope) */
        u_int *pal;
        prim = (POLY_GT3 *)Render_gPacketPtr;
        pal = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
        *(u_int *)prim = (*(u_int *)prim & 0xff000000) | (*pal & 0xffffff);
        {
          u_int t = *pal;   /* MATCH: bump store sits between pal load and pal store (oracle) */
          Render_gPacketPtr = (u_char *)prim + 0x28;
          *pal = ((u_int)prim & 0xffffff) | (t & 0xff000000);
        }
        DrawW_AddSubdividPrimGT3(prim,v1,v2,v5,sd);
      }
DrawWSubdiv_edge2:
      if (v2->a) goto DrawWSubdiv_edge3;
      if (v3->a) goto DrawWSubdiv_edgedone;
      if (v6->a) goto DrawWSubdiv_edge3;
      {
        POLY_GT3 *prim;   /* block-local (inline-helper scope) */
        u_int *pal;
        prim = (POLY_GT3 *)Render_gPacketPtr;
        pal = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
        *(u_int *)prim = (*(u_int *)prim & 0xff000000) | (*pal & 0xffffff);
        {
          u_int t = *pal;   /* MATCH: bump store sits between pal load and pal store (oracle) */
          Render_gPacketPtr = (u_char *)prim + 0x28;
          *pal = ((u_int)prim & 0xffffff) | (t & 0xff000000);
        }
        DrawW_AddSubdividPrimGT3(prim,v2,v3,v6,sd);
      }
DrawWSubdiv_edge3:
      if (v3->a) goto DrawWSubdiv_edgedone;
      if (v0->a) goto DrawWSubdiv_edgedone;
      if (v7->a) goto DrawWSubdiv_edgedone;
      {
        POLY_GT3 *prim;   /* block-local (inline-helper scope) */
        u_int *pal;
        prim = (POLY_GT3 *)Render_gPacketPtr;
        pal = (u_int *)(otz * 4 + (int)Render_gPalettePtr);
        *(u_int *)prim = (*(u_int *)prim & 0xff000000) | (*pal & 0xffffff);
        {
          u_int t = *pal;   /* MATCH: bump store sits between pal load and pal store (oracle) */
          Render_gPacketPtr = (u_char *)prim + 0x28;
          *pal = ((u_int)prim & 0xffffff) | (t & 0xff000000);
        }
        DrawW_AddSubdividPrimGT3(prim,v3,v0,v7,sd);
      }
DrawWSubdiv_edgedone:
      (sd->GT4Prim).code = (sd->GT4Prim).code | 8;
    }
    l = l + 1;
    gte_stsxy(&v8->dvx);
    DrawW_SubdividFacet(sd,l,v0,v4,v8,v7,n,subDivide);
    DrawW_SubdividFacet(sd,l,v4,v1,v5,v8,n,subDivide);
    DrawW_SubdividFacet(sd,l,v8,v5,v2,v6,n,subDivide);
    DrawW_SubdividFacet(sd,l,v7,v8,v6,v3,n,subDivide);
    return;
  }
  {
    POLY_GT4 *prim;   /* SYM: REG $s3 */

    if (subDivide != 0) {
      long bfct;   /* SYM: AUTO sp+0x34 */
      gte_ldsxy3(*(int *)&v0->dvx,*(int *)&v1->dvx,*(int *)&v2->dvx);
      gte_nclip();
      gte_swc2(0x18,&bfct);
      if ((sd->head).mirror == 1) {
        bfct = -bfct;
      }
      if (bfct < 0) {
        gte_ldsxy3(*(int *)&v0->dvx,*(int *)&v2->dvx,*(int *)&v3->dvx);
        gte_nclip();
        gte_swc2(0x18,&bfct);
        if ((sd->head).mirror == 1) {
          bfct = -bfct;
        }
        if (bfct < 0) {
          return;
        }
      }
    }
    prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;
    /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE (fastmovf.c family; $t4/$t5/$t6
     * scratches): slot = sd->head.cprim.LastPrim + sd->otz; sd->PrimPtr = prim+1 (0x34);
     * prim->tag = slot->addr24 | (0x0C<<24); slot->addr24 = prim.  Operand %2 = &sd->otz
     * (the expander read otz through a pointer arg -- the compiler materializes
     * `addiu v0,s2,0x94`, reorg copies it into the joining branches' delay slots). */
    __asm__ volatile(
        "lw	$t4,0(%2)
	lw	$t5,0(%1)
	addiu	$t6,%0,52
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4(%1)
	lwl	$t6,2($t5)
	lui	$t4,0x0C00
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,%0,8
	sw	$t6,0(%0)
	swl	$t4,2($t5)"
        : : "r"(prim), "r"(sd), "r"(&sd->otz)
        : "$12", "$13", "$14", "memory");
    DrawW_AddSubdividPrimGT4(prim,v0,v1,v2,v3,sd);
    return;
  }
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
  /* MATCH (2026-07-11): SYM (nfs4-f-v3.txt @0x800C5BE0) names the outer scope's
     REAL locals `v0,v1,v2,v3` (REG PTR Draw_SVertex) + `prim` (REG PTR POLY_GT4)
     -- same shape as the sibling DrawW_SetUpSubdividFacet_Line (which this fn's
     fix mirrors). THREE more nested blocks hold fused-word temps read via
     `prim`, each written back as ONE wide store (not per-field bytes/shorts):
     `t0,t1,t2,t3` (REG LONG, block line=1) = the four dvx/dvy word pairs
     (Draw_SVertex.dvx/dvy are adjacent shorts @+0x8); `t0,t1,t2,t3` (REG INT,
     SIBLING block line=49) = the four r/g/b/a color words (@+0xC); `u0,u1,u2,u3`
     (REG SHORT, block line=50) = the four u/v UV words (@+0x6). All three use
     the SAME screen-quad cross-feed as DrawW_AddSubdividPrimGT4 documents: v2
     takes POLY_GT4 slot 3, v3 takes slot 2 (v0/v1 map straight to slot 0/1).
     v0..v3/prim are set up BEFORE the LoadPrecVECTOR calls and passed as the
     call args directly (matches the oracle CSE'ing `&sd->vN` once, used both as
     the call arg and every later field access -- see _Line's fix comment for
     the full reasoning) instead of repeated `&sd->vN` / `(sd->vN)`. The 4
     alpha-flag blocks read `v->dvx` directly at both use sites (not cached into
     a named local) to get the oracle's plain signed `lh` instead of an
     `lhu+sll 16+sra 16` manual sign-extend (same fix as _Line). */
  Draw_SVertex *v0;
  Draw_SVertex *v1;
  Draw_SVertex *v2;
  Draw_SVertex *v3;
  POLY_GT4 *prim;
  short sVar2;

  v0 = &sd->v0;
  v1 = &sd->v1;
  v2 = &sd->v2;
  v3 = &sd->v3;
  DrawW_LoadPrecVECTOR(v0,&sd->tVn0);
  DrawW_LoadPrecVECTOR(v1,&sd->tVn1);
  DrawW_LoadPrecVECTOR(v2,&sd->tVn2);
  DrawW_LoadPrecVECTOR(v3,&sd->tVn3);
  prim = &sd->GT4Prim;
  {
    long t0;
    long t1;
    long t2;
    long t3;

    t0 = *(long *)&prim->x0;
    t1 = *(long *)&prim->x1;
    t2 = *(long *)&prim->x3;
    t3 = *(long *)&prim->x2;
    *(long *)&v0->dvx = t0;
    *(long *)&v1->dvx = t1;
    *(long *)&v2->dvx = t2;
    *(long *)&v3->dvx = t3;
  }
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
  {
    int t0;
    int t1;
    int t2;
    int t3;

    t0 = *(int *)&prim->r0;
    t1 = *(int *)&prim->r1;
    t2 = *(int *)&prim->r3;
    t3 = *(int *)&prim->r2;
    *(int *)&v0->r = t0;
    *(int *)&v1->r = t1;
    *(int *)&v2->r = t2;
    *(int *)&v3->r = t3;
  }
  {
    short u0;
    short u1;
    short u2;
    short u3;

    u0 = *(short *)&prim->u0;
    u1 = *(short *)&prim->u1;
    u2 = *(short *)&prim->u2;
    u3 = *(short *)&prim->u3;
    *(short *)&v0->u = u0;
    *(short *)&v1->u = u1;
    *(short *)&v2->u = u3;
    *(short *)&v3->u = u2;
  }
  v0->a = '\0';
  if (v0->dvx < 0x3e9) {
    sVar2 = v0->dvy;
    if ((((1000 < sVar2) || (v0->dvx < -1000)) || (sVar2 < -1000)) || (v0->vz < 0x65))
    goto DrW_SubSetup_v0Alpha;
  }
  else {
DrW_SubSetup_v0Alpha:
    v0->a = '\x01';
  }
  v1->a = '\0';
  if (v1->dvx < 0x3e9) {
    sVar2 = v1->dvy;
    if (((1000 < sVar2) || (v1->dvx < -1000)) || ((sVar2 < -1000 || (v1->vz < 0x65))))
    goto DrW_SubSetup_v1Alpha;
  }
  else {
DrW_SubSetup_v1Alpha:
    v1->a = '\x01';
  }
  v2->a = '\0';
  if (v2->dvx < 0x3e9) {
    sVar2 = v2->dvy;
    if (((1000 < sVar2) || (v2->dvx < -1000)) || ((sVar2 < -1000 || (v2->vz < 0x65))))
    goto DrW_SubSetup_v2Alpha;
  }
  else {
DrW_SubSetup_v2Alpha:
    v2->a = '\x01';
  }
  v3->a = '\0';
  if (v3->dvx < 0x3e9) {
    sVar2 = v3->dvy;
    if ((((sVar2 < 0x3e9) && (-0x3e9 < v3->dvx)) && (-0x3e9 < sVar2)) && (100 < v3->vz))
    goto DrW_SubSetup_callSubdiv;
  }
  v3->a = '\x01';
DrW_SubSetup_callSubdiv:
  DrawW_SubdividFacet(sd,0,v0,v1,v2,v3,0,(u_short)(face == 0));
  return;
}

/* ---- Night_NightCopCalc__FP6VECTORPs  [DRAWW.CPP:711-744] SLD-VERIFIED ---- */
void Night_NightCopCalc(VECTOR *v,short *idx)

{
  /* MATCH (2026-07-04, was 42 diffs / 38-vs-40 insns -> 40 diffs / EXACT 40==40 insns):
     SYM (nfs4-f-v3.txt @0x800C5F18) shows `z` (REG $3=v1) is the ONLY local at the
     function's outer scope -- `x` (REG $6=a2) is declared in a NESTED block starting at
     line 7 (VA 0x800C5F30), i.e. AFTER the first bounds-check branch, not before it. The
     oracle reads `v->vx` ONLY once the z-bounds test has already passed. Reading both
     fields UNCONDITIONALLY up-front (the previous shape) forced `x` into the outer scope
     too AND under-counted the true insn total by 2 (a genuine structural miss, not just
     coloring); moving the `x = v->vx` read INSIDE the first `if` restores the SYM's
     block nesting and the exact insn count. `coplookuptbl`/`index`/`lookup` (SYM: REG
     $3/$5/$2 = v1/a1/v0) are similarly nested one level deeper (inside `if(z<0)`'s
     scope, VA 0x800C5F48) -- kept as inline expressions here since no further
     register-class issue surfaced from them specifically.
     2026-07-16 (32 -> PASS 40/40): the earlier `neg`/char*-coplookuptbl mapping was
     WRONG vs the SYM -- true locals (SYM block @0x800C5F48, decl order) are
     `coplookuptbl` = u_char(*)[256][8] = the LOADED VALUE Night_gCopColor[index]
     (REG $3=v1), `index` = the 0/1 sign flag (REG $5=a1, explains idx's REGPARM
     $a3 entry copy), `lookup` = the FINAL color byte (REG $2=v0). Plus split
     `x = x + 0x400; x = x >> 5;` (in-place addiu/sra) and the permuter-found
     index-reuse for the table byte (see MATCH note below). */
  int z;

  z = v->vz;
  if ((u_int)(z + 0x7ff) < 0xfff) {
    int x = v->vx;

    if ((u_int)(x + 0x3ff) < 0x7ff) {
      u_char (*coplookuptbl)[256][8];
      int index;
      int lookup;

      index = 0;
      if (z < 0) {
        z = -z;
        index = 1;
      }
      z = z >> 5;
      x = x + 0x400;
      x = x >> 5;
      coplookuptbl = Night_gCopColor[index];
      /* MATCH (permuter output-0, 2026-07-16): the night-table byte REUSES `index`
         (dead after the Night_gCopColor[] load) -- the oracle's in-place
         `lbu a1; sra a1,a1,1` is index's pseudo morphing into the byte. Do NOT
         "clean up" into an anonymous subexpression (re-colors to srl v1 + 18 diffs). */
      index = (u_char)Night_gNightTbl[(z << 6) + x];
      lookup = (*coplookuptbl)[(short)*idx][index >> 1];
      *idx = (u_short)lookup;
    }
  }
  return;
}

/* ---- Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:750-788] SLD-VERIFIED ---- */
void Night_NightCalc(VECTOR *v,short *idx,Draw_tGiveShelbyMoreCache *sd)

{
  /* PARTIAL MATCH / STRUCTURAL FIX, RESIDUAL REGRESSED NUMERICALLY (2026-07-04, was 75
     diffs 66-vs-57 insns -> now 77 diffs, STILL 66-vs-57 insns): SYM (nfs4-f-v3.txt
     @0x800C5FB8) names FOUR outer-scope locals -- `z`(v->vz), `index`(unused/optimized-
     out at this opt level), `znear`(night_ZNear), `zfar` -- and nests `x`/`xdist` one
     block deeper (line 16, after the z-range test) and `lookup` deeper still (line 24,
     after the x-range test). The PREVIOUS version had TWO confirmed structural bugs vs
     the RAW oracle (not just coloring): (1) `zfar = znear + (1<<(night_ZDistShift+6))`
     is computed UNCONDITIONALLY in the oracle, sharing the lightning branch's shift
     amount and sitting in that branch's delay slot (§3.1: `beqz DrawLightning,skip [ds:
     zfar=...]` -- the ds instr ALWAYS executes) -- the old code instead recomputed a
     fresh `1<<...` term INSIDE the later z-range `if`, only reachable when lightning
     was already skipped -- wrong location, not just wrong shape; (2) each `&&` compound
     test is really TWO separate cascading `if`s in the oracle (`if(znear<z){if(z<zfar)`,
     `if(-xdist<x){if(x<xdist)`), confirmed by the disasm showing 2 independent
     `slt+beqz` pairs per test, not one fused short-circuit sequence.
     Rewriting to fix both (this version) reproduces the exact nested-if branch shape
     (2 slt+beqz pairs each, verified in the compiled disasm) and moves zfar's
     computation to the correct unconditional point -- but this SURFACED a separate,
     pre-existing register-pressure problem: `v`(a0)/`idx`(a1) are each read at TWO
     widely-separated points (top-of-fn and deep in the nested x/lookup block), and gcc
     now colors `zfar` into $a1 (idx's home) -- forcing gcc to defensively `move
     t2,a0`/`move t1,a1` at function entry to preserve v/idx across the intervening
     lightning-branch code (9 extra insns, the SAME excess as before). Tried 5 variants
     of statement/field-read ORDER (z-then-znear vs znear-then-z, zfar via an
     intermediate `shiftAmt`/`shift` var vs one combined expression, moving z's read
     before/after zfar's) -- gcc reorders the source freely by dependency in every case
     and the $a1-clash is unaffected; this is allocator-internal register-class
     selection for an unnamed value (zfar has no SYM-mandated register), not reachable
     by a source-order lever. The CONTROL-FLOW/delay-slot fix is semantically mandatory
     per the raw oracle (§1 authority: raw wins for delay-slot behavior) even though the
     diff count is numerically worse than the prior (structurally wrong) version;
     candidate for permuter or accept as the faithful-but-not-yet-coloring-matched form. */
  int z;
  int index;
  int znear;
  int zfar;

  z = v->vz;
  znear = (int)sd->night_ZNear;
  zfar = znear + (1 << (sd->night_ZDistShift + 6));
  if (sd->night_DrawLightning != '\0') {
    *idx = (u_short)(*Night_gWeatherLightingTable[sd->night_LightningType])[*idx];
  }
  if (znear < z) {
    if (z < zfar) {
      int x;
      int xdist;

      x = v->vx;
      xdist = 1 << (sd->night_XDistShift + 5);
      if (-xdist < x) {
        if (x < xdist) {
          int lookup;

          /* MATCH: oracle SELF-MUTATES z/x in place (subu a3,a3,t0 in the beqz delay
             slot / addu a0,a0,v1 / srav in place) and derefs Night_gCurrentNightColor
             ONCE (u_char (*)[256][16]: base + *idx*16 + byte). */
          z = z - znear;
          x = x + xdist;
          x = x >> sd->night_XDistShift;
          z = z >> sd->night_ZDistShift;
          lookup = (z << 6) + x;
          *idx = (u_short)(*Night_gCurrentNightColor)[*idx][(u_char)Night_gNightTbl[lookup]];
        }
      }
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
      gte_SetRotMatrix(&sd->matNight);
      gte_SetTransMatrix(&sd->matNight);
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
      gte_SetRotMatrix(&sd->matCop);
      gte_SetTransMatrix(&sd->matCop);
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
    /* NOTE (2026-07-10, 45 -> 2): the SYM 8c block (line-50 Block: `long a,b,c,d` =
       REG $a1/$a0/$v1/$v0) is the answer the 2026-07-08 attempt missed -- BLOCK-scoped
       LONG temps in SYM decl order (assignment order a=vt0, b=vt1, c=vt3, d=vt2 -- the
       r2/r3 cross-feed) batch the four chains WITHOUT the param s-reg recolor that the
       fn-scope u_long form caused. RESIDUAL 2: the last two value-loads (lw v1 / lw v0)
       emit in swapped order -- a scheduler tie (store/decl-order probes are diff-neutral,
       c/d assignment swap regresses to 154); permuter candidate. */
    {
      long a;   /* SYM block line 50: a,b,c,d = REG $a1/$a0/$v1/$v0 -- the 4 parallel
                   table-lookup chains, load-batched then store-batched (catalog par.A
                   N-named-value-temps; SYM-exact block scope + LONG type + decl order) */
      long b;
      long c;
      long d;
      a = *(long *)&Chunk_lightTable[vt0->light];
      b = *(long *)&Chunk_lightTable[vt1->light];
      c = *(long *)&Chunk_lightTable[vt3->light];
      d = *(long *)&Chunk_lightTable[vt2->light];
      *(u_long *)&prim->r0 = a;
      /* matching aid (permuter): do{}while(0) around the b/c/d stores forces gcc to
         schedule the two dependent light-table loads in the oracle's order */
      do {
        *(u_long *)&prim->r1 = b;
        *(u_long *)&prim->r2 = c;
        CVar12 = d;
      } while (0);
    }
  }
  else {
    if ((sd->nightFlags & 1U) != 0) {
      gte_SetRotMatrix(&sd->matNight);
      gte_SetTransMatrix(&sd->matNight);
      gte_ldv0(vt0);
      gte_rt();
      gte_stlvnl(&temp0);
      Night_NightCalc(&temp0, &sd->light, sd);
    }
    if ((sd->nightFlags & 2U) != 0) {
      gte_SetRotMatrix(&sd->matCop);
      gte_SetTransMatrix(&sd->matCop);
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
  gte_SetRotMatrix(&sd->matB);
  gte_SetTransMatrix(&sd->matB);
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
  int vertProj_idx;
  int vert1_idx;
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
  
  /* MATCH (2026-07-11 b): oracle reads the header in THIS interleaved order --
   * quad byte@3 (vt0 idx) FIRST, then sd's vertices/trans.x/trans.y, then
   * quad byte@2 (vt1 idx), byte@4 (vt3 idx), byte@5 (vt2 idx), then
   * sd->trans.z LAST -- not the previous grouped sd-then-quad-then-sd order
   * (which read byte@2 lazily at tp2's site, well after gte_ldv0(vt0)). */
  vertProj_idx = (int)*(u_char *)((char *)inQuad + 3);
  geomVerts_p = (int)sd->vertices;
  ts31 = (sd->trans).x;
  ts27 = (sd->trans).y;
  vert1_idx = (int)*(u_char *)((char *)inQuad + 2);
  vert_x_pack = (int)*(u_char *)((char *)inQuad + 4);
  vert_y_pack = (int)*(u_char *)((char *)inQuad + 5);
  sVar1 = (sd->trans).z;
  vertProj_p = geomVerts_p + (u_int)vertProj_idx * 8;
  /* MATCH (2026-07-11): read each vertex's xy/zl word ONCE into the SAME
   * tu18/tu2 temps DrawW_DrawQuad already uses for vt2/vt3 below (not a
   * fresh local -- oracle's asm shows a SINGLE lw per word, sra-extracted
   * into both fields), instead of dereferencing `*(u_int*)vertProj_p` twice
   * inline. The inline double-deref let gcc independently strength-reduce
   * each occurrence to its own plain lhu (2 lhu vs oracle's 1 lw+sra+2 add),
   * a structural (not just coloring) mismatch that was cascading a
   * register-coloring shift through vt1-vt3 and the whole function tail. */
  tu18 = *(u_int *)vertProj_p;
  tu2 = *(u_int *)(vertProj_p + 4);
  vt0.x = (short)tu18 + ts31;
  vt0.y = (short)((int)tu18 >> 0x10) + ts27;
  vt0.light = (short)((int)tu2 >> 0x10);
  vt0.z = (short)tu2 + sVar1;
gte_ldv0((int *)(&vt0));
  tp2 = (void *)(geomVerts_p + ((u_int)vert1_idx & 0xffU) * 8);
  gte_rtps_b();
  tu18 = *(u_int *)tp2;
  tu2 = *(u_int *)((int)tp2 + 4);
  vt1.x = (short)tu18 + ts31;
  vt1.y = (short)((int)tu18 >> 0x10) + ts27;
  vt1.light = (short)((int)tu2 >> 0x10);
  vt1.z = (short)tu2 + sVar1;
gte_stlvnl(((char *)sd + 0x98));
gte_swc2(0xe,&dvxy0);
gte_ldv0((int *)(&vt1));
  tp1 = (u_int *)(geomVerts_p + (vert_y_pack & 0xffU) * 8);
  gte_rtps_b();
  tu18 = *tp1;
  tu2 = tp1[1];
  vt2.x = (short)tu18 + ts31;
  vt2.y = (short)((int)tu18 >> 0x10) + ts27;
  vt2.light = (short)((int)tu2 >> 0x10);
  vt2.z = (short)tu2 + sVar1;
gte_stlvnl(((char *)sd + 0xa8));
gte_ldv0((int *)(&vt2));
  tp1 = (u_int *)(geomVerts_p + (vert_x_pack & 0xffU) * 8);
  gte_rtps_b();
  tu18 = *tp1;
  tu2 = tp1[1];
  vt3.x = (short)tu18 + ts31;
  vt3.y = (short)((int)tu18 >> 0x10) + ts27;
  vt3.light = (short)((int)tu2 >> 0x10);
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
    /* MATCH (2026-07-11): oracle re-derives this compare FRESH at each use
     * site (the intervening __asm__ blocks all clobber "memory", so gcc
     * rematerializes rather than spills the cheap byte flag) as a DIRECT
     * `slti;bnez` on `sd->otz < 200`, never the Yoda `199 < sd->otz` form
     * (which needs a slti+xori negate-dance to get the same truth value).
     * bVar4 is therefore stored NEGATED here and every use site below is
     * flipped to compensate. */
    bVar4 = sd->otz < 200;
    if (((bVar2 >> 3 & 2) == 0) && !((bool)bVar4)) {
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
    /* NOTE (2026-07-11): oracle's `sd->otz = bfctResult` intermediate store
     * is only conditionally reached on the offset==Draw_gMidGroundOtz path
     * (dead-but-harmless C-level difference from an unconditional store,
     * since sd->otz is overwritten right after either way). TRIED matching
     * the real if/else branch shape (verify-or-revert): compiled clean but
     * REGRESSED the gate (686->693 diffs) -- reverted, left on the simpler
     * always-store + always-overwritten form. */
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
      if (!(bool)bVar4) {
        prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;
        /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE (same shape as
         * DrawW_SubdividFacet's sealed instance; fastmovf.c family; $t4/$t5/$t6
         * scratches): slot = sd->head.cprim.LastPrim + sd->otz*4; sd->head.cprim.
         * PrimPtr = prim+1 (0x34); prim->tag = slot->addr24 | (0x0C<<24);
         * slot->addr24 = prim. */
        __asm__ volatile(
            "lw	$t4,0(%2)
	lw	$t5,0(%1)
	addiu	$t6,%0,52
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4(%1)
	lwl	$t6,2($t5)
	lui	$t4,0x0C00
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,%0,8
	sw	$t6,0(%0)
	swl	$t4,2($t5)"
            : : "r"(prim), "r"(sd), "r"(&sd->otz)
            : "$12", "$13", "$14", "memory");
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
      /* MATCH (2026-07-11): u0/v0/clut (and the u1/v1/tpage, u2/v2/pad2,
       * u3/v3/pad3 siblings) are 4 CONTIGUOUS bytes in POLY_GT4 (nfs4_types.h
       * +0xC: u_char u0,v0; u_short clut) -- a plain word copy at the
       * oracle's access width, not 3 manual sub-field byte/half stores per
       * group (field-fusion lever, same family as DrawW_SetUpSubdividFacet
       * _Line's *(u_short*)&v->u fusion). */
      tu2 = *(u_int *)workPmx_p;
      tu18 = *(u_int *)(workPmx_p + 4);
      uVar3 = *(u_int *)(workPmx_p + 8);
      uVar7_00 = *(int *)(workPmx_p + 0xc);
      *(u_int *)&prim->u0 = tu2;
      *(u_int *)&prim->u1 = tu18;
      *(u_int *)&prim->u2 = uVar3;
      *(u_int *)&prim->u3 = uVar7_00;
      if (prim->clut == 0xffff) {
        ti18 = (bfctResult - sd->startfog) * 0x10 >> ((int)sd->distfog);
        if (ti18 < 0) {
          ti18 = 0;
        }
        else if (0xf < ti18) {
          ti18 = 0xf;
        }
        prim->clut = gClutDepth[*(u_short *)(workPmx_p + 10)][ti18];
      }
      if ((bool)bVar4) {
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
     MATCH 100% (2026-07-08, was a 12-diff "floor"): THREE cooperating shape details --
     (1) SPLIT the load from the decrement (`numQuads = sd->quadCount; ... numQuads =
     numQuads - 1;`, methodology par.3.12 #15b) so the lbu lands straight in $s0;
     (2) guard compares the LITERAL `!= -1` (materialized once in temp $v0);
     (3) `sentinel = -1` assigned INSIDE the guard body -- gcc CSEs it as a COPY of the
     guard's -1 temp and fills the guard-branch delay slot with it (`addu s3,v0`),
     exactly the oracle's lazy sentinel. The earlier attempt failed because it kept
     `sentinel = -1` UP FRONT (sentinel then owns the -1 materialization in $s3 and the
     guard compares vs $s3) AND fused the load-decrement through a $v0 stage. */
  int sentinel;
  int numQuads;
  Trk_Quad *pquad;

  numQuads = sd->quadCount;
  pquad = (Trk_Quad *)sd->quads;
  numQuads = numQuads - 1;
  if (numQuads != -1) {
    sentinel = -1;
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
     NEAR-MISS 2 diffs (2026-07-08, was 10): the inner loop is the EXIT-IN-THE-MIDDLE
     no-rotation shape (methodology par.3.12 #15a) -- `while(true){ if(numQuads<=iquad)
     break; body; }` keeps gcc's top-test + unconditional `j`-back (the oracle's form);
     BOTH a goto-test do-while AND a plain `while(iquad<numQuads)` get rotated to a
     bottom-test `bnez`-back (10-11 diffs). RESIDUAL 2 = one scheduling transposition:
     ours hoists `addu v1,v1,s0` (r2+=iquad) up beside r0's add (sched priority: its
     consumer sb lands in the jal delay slot = longest path), oracle keeps it after
     `r1=r0+1`. 4 load/add placement variants all converge to the same 2; late-loading
     botVert regresses (+nop). Scheduler-priority artifact -> permuter candidate. */
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
    while (true) {
      if (numQuads <= iquad) break;
      if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
        newQuad.material = *pMaterial;
        r0 = pTVar4->topVert;
        r2 = pTVar4->botVert;
        r0 = r0 + iquad;
        newQuad.aPoints[1] = (u_char)r0;
        r0 = r0 + 1;   /* in-place increment (r0 dead after); r1 takes the result */
        r1 = r0;
        r2 = r2 + iquad;
        newQuad.aPoints[2] = (u_char)r2;
        r3 = r2 + 1;
        newQuad.aPoints[0] = (u_char)r1;
        newQuad.aPoints[3] = (u_char)r3;
        DrawW_DrawQuad(sd,&newQuad);
      }
      pMaterial = pMaterial + 1;
      iquad = iquad + 1;
    }
    pTVar4 = (Trk_NewStrip *)(&pTVar4->topVert + (u_char)pTVar4->size);
  }
  return;
}

/* ---- DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry  [DRAWW.CPP:1390-1654] SLD-VERIFIED ---- */
void DrawW_DoTrough(DRender_tView *Vi,tBuildEntry *buildList)

{
  /* MATCH (2026-07-11 FABLE-1): full SYM-driven + scratchpad-overlay rewrite.
     SYM's real local set is {sd (REG, Draw_tGiveShelbyMoreCache* -- NOT the
     ad-hoc `(Draw_tGiveShelbyMoreCache*)&Render_gPalettePtr` cast at each call
     site), chunkCount (AUTO/stack), buildInd, chunkDat, pChunkCp, per-block
     `this`/`group` (Group*), block-scoped tmp/tmp2/cx/cz/dist}. The prior draft
     (a) used Ghidra artifact temps (iVar2/iVar8/pCVar3/bVar1/pGVar6/pThis/group)
     with no SYM counterpart, AND (b) routed every scratchpad field through
     separate lost-symbol globals (DrawW_gNightFlags/gChunkInd/gChunkGeomRez/
     gChunkVtxBuf/gMaterialLUT/gChunkObjFlag/gInitialArtPtr/gObjScratch_148/
     gGroupCount/gGroupPtr/gMatID_tmp/gNightTmpFlag/gChunkQuadCount/
     gChunkStripBuf/gChunkRelX/Y/Z) and Render_gWorldMat/gNightMat/gCopMat --
     ALL plain unaliased externs -- while the oracle materializes ONE shared
     0x1F800000 base register reused via low-16 displacement for every one of
     these fields (they are literally offsets into a SINGLE 636-byte
     Draw_tGiveShelbyMoreCache scratchpad overlay: doublelayer@0xDA,
     identMat@0x74, offsubdivid@0x148, artInfo@0xFC, chunkInd@0xE4, rezInd@0xE5,
     matB@0x14, nightFlags@0x106, light@0xD8, materials@0xF0, trans@0xF4,
     stripPtr@0x100, numStrips@0x104, offset@0xEC, quadCount@0xE7, quads@0xE8,
     zeroGTETransFlag@0x107, vertices@0xE0 -- confirmed byte-for-byte against
     the raw oracle .s). Fixed correctness bugs found in the same pass: (1) a
     REDUNDANT `if (stripPtr != 0)` inner check after `lorez+1` -- always true,
     not in the oracle, deleted; (2) 3x `DrawW_gFog_init = 0xffff;` -- verified
     against every 0x1F8000xx offset touched by the oracle (grep of the raw .s)
     and NONE writes startfog/distfog (0xDC/0xDE) anywhere in this fn -- these
     were phantom statements with no oracle counterpart, deleted; (3) the FIRST
     gte_SetTransMatrix((void*)0x1f800014) call zeroed `Render_gWorldMat.t[]`
     (a DIFFERENT, unaliased global) instead of the memory it actually passed to
     the GTE -- a real correctness bug (dead zeroing + reads of uninitialized/
     stale scratchpad), fixed by zeroing (sd->matB).t[] and passing &sd->matB;
     (4) `sd->light = -1` was MISSING entirely (5 oracle sites: once after the
     rotation-matrix setup, once before each of the 4 DrawW_kCtrlWorld_High
     calls) -- added; (5) the two `dist < 0x47e0000` distance-gate checks used
     a strict-less round constant where the oracle materializes the ODD
     constant 0x47DFFFF via `slt CONST,dist` (CONST loaded first, non-immediate
     -- the 27-bit value can't fit `slti`) -- rewritten as `dist <= 0x47DFFFF`
     to match the oracle's exact comparison direction/constant. */
  Draw_tGiveShelbyMoreCache *sd;
  int chunkCount;
  int buildInd;
  Chunk *chunkDat;
  coorddef *pChunkCp;
  coorddef tmp;
  coorddef tmp2;

  sd = (Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr;
  chunkCount = BWorld_gChunkCount;
  buildInd = 0;
  sd->doublelayer = 1;
  sd->identMat = gIdentTemplate;
  sd->offsubdivid = 0;
  do {
    if (chunkCount <= buildInd) {
      return;
    }
    if ((buildList->enableBits & 1U) != 0) {
      /* MATCH: chunkInd/geomRez are NOT kept as persistent C locals -- the
         oracle stores each straight to its sd-> byte field (a genuine BYTE
         truncation of the `short chunkInd`/`char geomRez` tBuildEntry fields,
         `lbu` not `lh`) and then RE-READS the sd-> field every subsequent time
         the value is needed (chunkDat's multiply, pChunkCp's multiply, and the
         `geomRez==0` dispatch all reload from 0x1F8000E4/E5 rather than reusing
         a kept register) -- cheaper than keeping a value live across the
         WorldSetUpMatrix call, which clobbers every caller-saved reg anyway. */
      sd->artInfo = &gInitialArt;
      sd->chunkInd = (u_char)buildList->chunkInd;
      sd->rezInd = (u_char)buildList->geomRez;
      chunkDat = Track_chunkList + sd->chunkInd;
      DrawW_WorldSetUpMatrix(&gWorldMat,&sd->matB);
      sd->nightFlags = 0;
      sd->vertices = (CCOORD16 *)(chunkDat->vertexBuf + 1);
      sd->materials = Track_materials;
      sd->light = -1;
      pChunkCp = Chunk_chunkCenters + sd->chunkInd;
      if (gNight_renderNight != 0) {
        int cx;
        int cz;
        int dist;
        sd->nightFlags = 4;
        cx = (pChunkCp->x - ((Camera_gInfo[Vi->player].target)->position).x) >> 10;
        cz = (pChunkCp->z - ((Camera_gInfo[Vi->player].target)->position).z) >> 10;
        dist = cx * cx + cz * cz;
        if (dist <= 0x47DFFFF) {
          if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
            sd->nightFlags = 5;
          }
          {
            int posX = ((Camera_gInfo[Vi->player].target)->position).x;
            tmp.x = (Vi->cview).translation.x - posX;
          }
          {
            int posY = ((Camera_gInfo[Vi->player].target)->position).y;
            tmp.y = (Vi->cview).translation.y - posY;
          }
          {
            int posZ = ((Camera_gInfo[Vi->player].target)->position).z;
            tmp.z = (Vi->cview).translation.z - posZ;
          }
          transform(&tmp.x,gNightMat.m,&tmp2.x);
          DrawW_WorldSetUpTranslation(&tmp2,&sd->matNight);
        }
        if (BW_gCopCarObj != (Car_tObj *)0x0) {
          int cx2;
          int cz2;
          int dist2;
          cx2 = (pChunkCp->x - (BW_gCopCarObj->N).position.x) >> 10;
          cz2 = (pChunkCp->z - (BW_gCopCarObj->N).position.z) >> 10;
          dist2 = cx2 * cx2 + cz2 * cz2;
          if (dist2 <= 0x47DFFFF) {
            sd->nightFlags = sd->nightFlags | 2;
            {
              int posX = (BW_gCopCarObj->N).position.x;
              tmp.x = (Vi->cview).translation.x - posX;
            }
            {
              int posY = (BW_gCopCarObj->N).position.y;
              tmp.y = (Vi->cview).translation.y - posY;
            }
            {
              int posZ = (BW_gCopCarObj->N).position.z;
              tmp.z = (Vi->cview).translation.z - posZ;
            }
            transform(&tmp.x,gCopMat.m,&tmp2.x);
            DrawW_WorldSetUpTranslation(&tmp2,&sd->matCop);
          }
        }
      }
      sd->trans.x = (short)((pChunkCp->x - (Vi->cview).translation.x) >> 10);
      sd->trans.y = (short)((pChunkCp->y - (Vi->cview).translation.y) >> 10);
      sd->trans.z = (short)((pChunkCp->z - (Vi->cview).translation.z) >> 10);
      (sd->matB).t[2] = 0;
      (sd->matB).t[1] = 0;
      (sd->matB).t[0] = 0;
      gte_SetTransMatrix(&sd->matB);
      /* MATCH: BRANCH-POLARITY FLIP vs the prior draft -- the oracle tests
         `rezInd != 0` (not `== 0`) and puts the stripBuf (geomRez!=0) block as
         the FALL-THROUGH common path, with the lorezstripBuf (geomRez==0)
         block as the branch TARGET; the stripBuf block's own completion then
         JUMPS FORWARD into the lorez block's shared
         DrawWTrough_setStateCallHigh tail (a forward goto into the other arm),
         confirmed instruction-by-instruction against the raw oracle .s
         (rezInd reload @0x1F8000E5, stripBuf@chunkDat+0x38 read on the
         fall-through path, lorezstripBuf@chunkDat+0x3C read only after the
         branch is taken). The previous draft had the arms backwards (`==0`
         first, `!=0` second) -- same behavior, wrong branch sense/layout. */
      if (sd->rezInd != 0) {
        Group *strip = chunkDat->stripBuf;
        if (strip != (Group *)0x0) {
          sd->stripPtr = (Trk_NewStrip *)(strip + 1);
          sd->numStrips = (short)strip->m_num_elements;
          sd->offset = 0x7d;
          DrawW_StripDraw_High(sd);
          sd->quadCount = chunkDat->quadCounts[5];
          if (sd->quadCount != 0) {
            sd->quads = chunkDat->renderQuads[3];
            goto DrawWTrough_setStateCallHigh;
          }
        }
      }
      else {
        if (chunkDat->lorezstripBuf != (Group *)0x0) {
          sd->stripPtr = (Trk_NewStrip *)(chunkDat->lorezstripBuf + 1);
          sd->numStrips = (short)chunkDat->lorezstripBuf->m_num_elements;
          sd->offset = 0x7d;
          DrawW_StripDraw_High(sd);
        }
        sd->quadCount = chunkDat->quadCounts[0];
        if (sd->quadCount != 0) {
          sd->quads = chunkDat->renderQuads[0];
          sd->offset = 0x7d;
          sd->zeroGTETransFlag = 1;
          sd->light = -1;
          DrawW_kCtrlWorld_High(sd);
        }
        sd->quadCount = chunkDat->quadCounts[1];
        if (sd->quadCount != 0) {
          sd->quads = chunkDat->renderQuads[1];
DrawWTrough_setStateCallHigh:
          sd->offset = 0x1e;
          sd->zeroGTETransFlag = 1;
          sd->light = -1;
          DrawW_kCtrlWorld_High(sd);
        }
      }
      sd->vertices = (CCOORD16 *)(chunkDat->objVertexBuf + 1);
      sd->quadCount = chunkDat->quadCounts[2];
      if (sd->quadCount != 0) {
        sd->offset = 0x7d;
        sd->zeroGTETransFlag = 1;
        sd->light = -1;
        sd->quads = chunkDat->objQuadBuf + 1;
        DrawW_kCtrlWorld_High(sd);
      }
      sd->quadCount = chunkDat->quadCounts[3];
      if (sd->quadCount != 0) {
        sd->offset = 0x32;
        sd->zeroGTETransFlag = 1;
        sd->light = -1;
        sd->quads = chunkDat->objQuadInstanceBuf + 1;
        DrawW_kCtrlWorld_High(sd);
      }
    }
    buildList = buildList + 1;
    buildInd = buildInd + 1;
  } while( true );
}

/* ---- DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX  [DRAWW.CPP:1663-1670] SLD-VERIFIED ---- */
void DrawW_WorldSetUpMatrix(matrixtdef *m,MATRIX *mat)

{
  /* MATCH 100% (2026-07-08): the SYM (nfs4-f-v3.txt @0x800C753C) shows THREE separate
     nested BLOCK scopes, each with its own {r0,r1,r2} REG triplet -- and that block
     structure is LOAD-BEARING (methodology par.3.12 #15 declaration-scope rule): each
     block's r0/r1/r2 are FRESH gcc pseudos, so block 3's r2 grabs the just-freed $a0
     (`m` dies at its last read `lw $a0,0x20($a0)`), while a function-scope r2 kept its
     block-1 coloring $a2 forever (= the old 6-diff "floor"). DO NOT hoist the decls out
     of the blocks or merge the blocks -- that reverts to the near-miss. Per-row shape:
     all 3 loads, then all 3 shifts, then all 3 stores (not interleaved). */
  {
    int r0 = m->m[0];
    int r1 = m->m[3];
    int r2 = m->m[6];
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mat->m[0][0] = (short)r0;
    mat->m[0][1] = (short)r1;
    mat->m[0][2] = (short)r2;
  }
  {
    int r0 = m->m[1];
    int r1 = m->m[4];
    int r2 = m->m[7];
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mat->m[1][0] = (short)r0;
    mat->m[1][1] = (short)r1;
    mat->m[1][2] = (short)r2;
  }
  {
    int r0 = m->m[2];
    int r1 = m->m[5];
    int r2 = m->m[8];
    r0 = r0 >> 4;
    r1 = r1 >> 4;
    r2 = r2 >> 4;
    mat->m[2][0] = (short)r0;
    mat->m[2][1] = (short)r1;
    mat->m[2][2] = (short)r2;
  }

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
  if (maxTick <= iVar2) {
    iVar2 = maxTick;
  }
  return iVar2;
}

/* ---- DrawW_SetAnimationTime__FP15Trk_AnimateInstPii  [DRAWW.CPP:1721-1779] SLD-VERIFIED ---- */
void DrawW_SetAnimationTime(Trk_AnimateInst *animInst,int *table,int time)

{
  /* MATCH (2026-07-10 SYM-structure pass, 3.8b): the SYM 8c block has ONLY `objIndex`
     (REG $a0 -- gcc reuses the dead animInst reg), per-arm block-scoped `i` (REG $a3)
     and `slice` (REG $a0); piVar2/ppCVar5/iVar1 of the old draft were COMPILER TEMPS
     (no SYM records).  The list access is the INDEX form Cars_gHumanRaceCarList[i]
     (strength-reduced by gcc into the walking-pointer giv $a2, +4 in the j delay slot);
     `(table + objIndex*2)[k]` stays an IN-LOOP expression so loop.c hoists it into the
     preheader AFTER the Cars_gNumHumanRaceCars invariant load (a pre-loop `table +=`
     statement lands BEFORE the hoist = 8 diffs) and the hoisted add coalesces in-place
     into $a1 with the canonical scaled-term-first operand order (addu a1,v0,a1);
     the loops are the EXIT-IN-THE-MIDDLE no-rotation shape (top test + unconditional
     `j` back-edge, sect.3.12 #15a / catalog par.B).  *** PASS 80/80 (2026-07-10) *** */
  int objIndex;   /* SYM: REG $a0 */

  objIndex = animInst->objectIndex - 1;
  if (0xf00 < animation_timer[objIndex]) {
    int i;   /* SYM: REG $a3 (per-arm block scope) */
    i = 0;
    while (true) {
      if (Cars_gNumHumanRaceCars <= i) break;
      {
        int slice;   /* SYM: REG $a0 */
        slice = (int)(Cars_gHumanRaceCarList[i]->N).simRoadInfo.slice;
        if ((slice < (table + objIndex * 2)[0]) || ((table + objIndex * 2)[1] < slice)) {
          animation_timer[objIndex] = 0;
        }
      }
      i = i + 1;
    }
  }
  else {
    if (0 < animation_timer[objIndex]) {
      animation_timer[objIndex] = animation_timer[objIndex] + 1;
      return;
    }
    {
      int i;   /* SYM: REG $a3 */
      i = 0;
      while (true) {
        if (Cars_gNumHumanRaceCars <= i) break;
        {
          int slice;   /* SYM: REG $a0 */
          slice = (int)(Cars_gHumanRaceCarList[i]->N).simRoadInfo.slice;
          if (((table + objIndex * 2)[0] <= slice) && (slice <= (table + objIndex * 2)[1])) {
            animation_timer[objIndex] = animation_timer[objIndex] + 1;
          }
        }
        i = i + 1;
      }
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
    /* SYM: block-scoped REG local `sd` (Draw_DCache*, $fp) -- the scratchpad cache
       cursor cast ONCE here, not re-cast at every call site (used below at every
       ObjectClipped/DrawObjectSimple/DrawObjectTransform/Flare_Halo2 call). The
       world matrix itself is a SEPARATE scratchpad literal (0x1F800014, matches
       sd->matB's own address -- Draw_DCache.matB @+0x14) forced into its own
       register by the gte_SetTransMatrix() call argument. */
    sd = (Draw_DCache *)&Render_gPalettePtr;
    ((MATRIX *)0x1f800014)->t[2] = 0;
    ((MATRIX *)0x1f800014)->t[1] = 0;
    ((MATRIX *)0x1f800014)->t[0] = 0;
gte_SetTransMatrix((void *)0x1f800014);
    for (iVar9 = 0; iVar9 < iVar2; iVar9 = iVar9 + 1) {
      if ((psVar5 == (short *)0x0) || ((((u_short)psVar5[iVar9] >> 0xc ^ 1) & 1) == 0)) {
        iVar8 = iVar6;
        if (iVar6 == 0) {
          iVar8 = (int)goffsets[animInst->zoffset];
        }
        bVar1 = animInst->type;
        /* SYM block-scoping (line70/71 vs 95/107/114, all converging on the shared
           loop-tail at line124/132) + the oracle's flat forward-beq compare chain
           (==1 / <2-skip / ==3 / ==7 / skip) with BOTH case bodies pushed OUT OF LINE
           after the chain -- neither a plain if/else-if (inlines case1) nor a switch
           (gcc picks a range-check lowering for {1,3,7}) reproduces this; an explicit
           goto dispatch matches the oracle's actual block layout 1:1. */
        if (bVar1 == 1) goto animCase1;
        if (bVar1 < 2) goto animNext;
        if ((bVar1 == 3) || (bVar1 == 7)) goto animCase37;
        goto animNext;
      animCase1:
        objDef_00 = Track_gObjDefs[animInst->pad];
        if (((iVar7 == 0) ||
            (pvVar3 = ObjectClipped(Vi,(int)animInst->pad,(coorddef *)&animInst->count,
                                 (Draw_tGiveShelbyMoreCache *)sd),
            pvVar3 == (void *)0x0)) &&
           ((iVar11 == -1 ||
            (iVar4 = xzsquaredist32((coorddef *)&animInst->count,&(Vi->cview).translation),
            iVar4 < iVar11)))) {
          iVar8 = DrawObjectSimple(Vi,sd,objDef_00,
                             (coorddef *)&animInst->count,iVar8);
          iVar10 = iVar10 + iVar8;
        }
        goto animNext;
      animCase37:
        Anim_GetRotPos(animInst,1,DrawW_GetAnimationTime(animInst),&cp,&matrix);
        if ((iVar11 == -1) ||
           (iVar4 = xzsquaredist32(&cp,&(Vi->cview).translation),
           iVar4 < iVar11)) {
          iVar8 = DrawObjectTransform(Vi,sd,&matrix,
                             Track_gObjDefs[animInst->pad],&cp,iVar8,-1);
          iVar10 = iVar10 + iVar8;
          if ((animInst->flags & 2) != 0) {
            pt2.x = cp.x + matrix.m[6] * -0x10;
            pt2.y = cp.y + matrix.m[7] * -0x10;
            pt2.z = cp.z + matrix.m[8] * -0x10;
            Flare_Halo2(Vi,-1,0x1e,&cp,&pt2,(Draw_FlareCache *)sd);
          }
        }
      animNext:;
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
  u_char tc4;
  u_char tc5;

  groupBase_p = (int)(group + 1);
  totalCount = 0;
  iVar6 = group->m_num_elements;
  if (iVar6 == 0) {
    totalCount = 0;
  }
  else {
    /* MATCH (2026-07-11, correctness bug): gte_SetTransMatrix was reading a
       fabricated/wrong global (CF_DVLC -- a video-buffer symbol, completely
       unrelated) instead of the just-zeroed sd->matB the oracle loads (`lw
       t0,132(sp); addiu v0,t0,20` = &sd->matB, ctc2 t4/t5/t6,5/6/7). This would
       have fed garbage into the GTE's rotation-matrix control regs for every
       custom-object draw. */
    (sd->matB).t[2] = 0;
    (sd->matB).t[1] = 0;
    (sd->matB).t[0] = 0;
gte_SetTransMatrix((MATRIX *)&sd->matB);
    for (facetCount = 0; facetCount < iVar6; facetCount = facetCount + 1) {
      tc5 = *(u_char *)(groupBase_p + 2);
      tc4 = offsets[*(u_char *)(groupBase_p + 4)];
      if ((tc5 == 5) || (tc5 == 2)) {
        objDef_00 = Track_gObjDefs[*(short *)(groupBase_p + 6)];
        if ((tc5 == 2) ||
           (objMat_p = (int)simObjs,
           objDef_p = (int)Object_GetAnim(simObjs + *(u_char *)(groupBase_p + 0x22)), objDef_p == 0)) {
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
            /* MATCH (2026-07-11, rule-8/movstrsi): the oracle disasm shows a genuine
               UNALIGNED 8-byte struct copy here (`lwl/lwr` from $s2+0x14 into a temp,
               `swl/swr` into the stack `quat` local) -- groupBase_p is a variable-
               length-record walking pointer (Trk_SimpleInst 20B / Trk_CollideBoomInst
               36B per element), so gcc can never PROVE the runtime address is
               4-aligned and must emit the byte-safe movstrsi copy even though quat
               (tQuat, {qx,qy,qz,qw} at CollideBoomInst+0x14) is a plain aligned type.
               Ghidra hand-expanded that single compiler-generated lwl/lwr/swl/swr
               block move into ~20 lines of shift/mask bit math (the classic
               "movstrsi disease", methodology 3d/§catalog-row-303) -- a byte-array
               PACK8 cast reproduces the exact unaligned copy the oracle performs. */
            {
              struct Pack8 { char b[8]; };
              *(struct Pack8 *)&quat = *(struct Pack8 *)(groupBase_p + 0x14);
            }
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
  /* MATCH (2026-07-11, 125 -> 96 diffs; insns EXACT 214==214): the pair
     `sd[1].head.clipW = (u_short)offset; sd[1].head.clipH = *(u_short*)((u_char*)
     &offset+2);` was a BOGUS byte-split reconstruction of a single 32-bit store --
     clipW/clipH are adjacent `short` fields (nfs4_types.h +0x10/+0x12) spanning
     exactly one aligned word, and `offset` is a plain `int` 5th (stack-passed)
     arg. The split emitted TWO half-word loads from the stack slot instead of the
     oracle's ONE word load into a callee-saved reg ($s5, kept live for the later
     `if (offset==-1)` reuse) + one word store -- fixed to `*(int*)&sd[1].head.
     clipW = offset;`. Same bug in the sibling DrawObjectSimple below (same
     pattern).
     2026-07-11 cont'd (96 -> 88 diffs; insns now 212 == oracle 214, ours 2 SHORT):
     the SAME bogus byte-split bug was present a SECOND time, later in this fn --
     `objFlags = *(u_short*)((u_char*)&Draw_gMidGroundOtz+2); sd[1].head.clipW =
     (u_short)Draw_gMidGroundOtz; sd[1].head.clipH = objFlags;` (Draw_gMidGroundOtz
     is a plain `int`; clipW/clipH again span one aligned word) -- oracle is ONE
     `lw;nop;sw` (confirmed byte-exact against the .s), fixed to `*(int*)&sd[1].
     head.clipW = Draw_gMidGroundOtz;` (objFlags now dead, removed). This is a
     genuine correctness fix (oracle-evidenced single-word op vs a fabricated
     half-word split) and lowers raw diff count 96->88, but it un-masks a
     PRE-EXISTING -2 deficit that the old bug's extra half-word insns had been
     accidentally canceling: the Camera_gInfo target->position two-level pointer
     chase (oracle mutates the target-ptr reg IN PLACE for the `+0xA0/+0xA4/+0xA8`
     load, ours loads the ptr into a fresh reg) costs the oracle a scheduling nop
     ours doesn't pay, 4 occurrences worth ~-8, partly offset by other +1 residuals
     net -2. Already tried (both before AND after this fix): splitting each axis
     into its own `int posN=...; tmp.N=pCp->N-posN;` / named-pointer forms per the
     DrawW_DoLines lever -- OVERSHOOTS to 217/191 instead of landing exact 214, so
     reverted both times; not a straight port here. RESIDUAL 88 = this pointer-
     chase deficit + further register-coloring cascade. */
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
  *(int *)&sd[1].head.clipW = offset;
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
    *(int *)&sd[1].head.clipW = Draw_gMidGroundOtz;
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
  /* MATCH (2026-07-11, 97 -> 76 diffs; insns EXACT 189==189): same bogus
     byte-split bug as the sibling DrawObjectTransform above -- `sd[1].head.clipW
     = (u_short)offset; sd[1].head.clipH = *(u_short*)((u_char*)&offset+2);`
     replaced a single aligned word store `*(int*)&sd[1].head.clipW = offset;`
     (clipW/clipH are adjacent shorts spanning one word) with two half-word
     stack reloads, and dropped `offset`'s register cache for the later
     `if (offset==-1)` reuse (oracle: ONE `lw $s5,...` kept live in a callee-
     saved reg).
     2026-07-11 cont'd (76 -> 68 diffs; insns now 187 == oracle 189, ours 2 SHORT):
     the identical bogus split existed a SECOND time (`objFlags = *(u_short*)
     ((u_char*)&Draw_gMidGroundOtz+2); sd[1].head.clipW = (u_short)
     Draw_gMidGroundOtz; sd[1].head.clipH = objFlags;`) -- oracle proven as ONE
     `lw;nop;sw` (byte-exact), fixed to `*(int*)&sd[1].head.clipW =
     Draw_gMidGroundOtz;` (objFlags now dead, removed). Oracle-evidenced
     correctness fix, lowers raw diffs 76->68, but (same as DrawObjectTransform)
     un-masks the pre-existing Camera_gInfo target->position two-level
     pointer-chase deficit (oracle mutates the target-ptr reg IN PLACE for the
     `+0xA0/+0xA4/+0xA8` loads; ours loads into a fresh reg) that the old bug's
     extra half-word insns had been accidentally canceling out. ALSO NOTED: the
     3rd (z) axis of the offset==-1 / else clipping split (`facetIdx = (short)
     (pCp->z - translation.z >> N)`, merged via `sd[1].matB.m[1][1] = facetIdx`
     after the if/else) emits `srl` where oracle emits `sra` -- functionally
     IDENTICAL after the subsequent 16-bit truncation (`sh`), so a pure
     opcode-choice tie, not a value bug; left as documented residual. The
     target->position pointer-chase split (DrawW_DoLines lever) still overshoots
     the insn count (189->193 before this fix, 187->191 after) rather than
     landing exact -- reverted both times, same as DrawObjectTransform.
     RESIDUAL 68 = the pointer-chase deficit + sra/srl tie + coloring cascade. */
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
  *(int *)&sd[1].head.clipW = offset;
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
    *(int *)&sd[1].head.clipW = Draw_gMidGroundOtz;
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
  /* MATCH (2026-07-11): pGVar12 (Group*, 4-byte-stride byte-offset arithmetic) is the
     Ghidra-collapsed view of what the oracle really walks as a variable-length instance
     record. Every access site's byte offset (0,2,4,6,8,12,16,20,22,24,26,28,30,32,34)
     lines up EXACTLY with the existing (already-vendored) Trk_CollideBoomInst layout
     {size@0,type@2,objectIndex@3,zoffset@4,flags@5,pad@6,x@8,y@12,z@16,
     qx@20,qy@22,qz@24,qw@26,sx@28,sy@30,sz@32,simIndex@34,boomIndex@35} -- retyping the
     walking pointer as Trk_CollideBoomInst* turns every `pGVar12[N].m_num_elements`
     byte-math expression into a real field access, which is rule-8/SYM-driven local
     structure (SYM names this pointer `objInstance`). */
  u_char bVar1;
  void *pvVar3;
  int iVar4;
  int iVar5;
  ObjectAnim *pOVar6;
  int doFrustumClip;
  Trk_SimObject *simObjs;
  int iVar9;
  short light;
  int iVar10;
  int iVar11;
  Trk_CollideBoomInst *objInstance;
  Trk_ObjectDef *objDef_00;
  int totalCount;
  int iVar14;
  matrixtdef matrix;
  int groupNumElements;
  int objectIndex;

  simObjs = gObjInfo->simObjs;
  objInstance = (Trk_CollideBoomInst *)(gObjInfo->objInstanceBuf + 1);
  groupNumElements = gObjInfo->objInstanceBuf->m_num_elements;
  doFrustumClip = gObjInfo->doFrustumClip;
  totalCount = 0;
  if (groupNumElements == 0) {
    totalCount = 0;
  }
  else {
    Render_gWorldMat.t[2] = 0;
    Render_gWorldMat.t[1] = 0;
    Render_gWorldMat.t[0] = 0;
gte_SetTransMatrix((void *)0x1f800014);
    for (objectIndex = 0; objectIndex < groupNumElements; objectIndex = objectIndex + 1) {
      bVar1 = objInstance->type;
      iVar14 = (int)goffsets[objInstance->zoffset];
      if (((bVar1 & 0x80) != 0) ||
         ((((bVar1 != 5 && (doFrustumClip != 0)) &&
           (pvVar3 = ObjectClipped(Vi,(int)objInstance->pad,
                                (coorddef *)&objInstance->x,
                                (Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr),
           pvVar3 != (void *)0x0)) && ((char)bVar1 != '\x02'))))
      goto DrawWChunkFacets_groupNext;
      DrawW_gObjScratch_148 = 0x400;
      light = -1;
      if ((objInstance->flags & 1) != 0) {
        iVar4 = fixedatan(objInstance->x - (Vi->cview).translation.x,
                           objInstance->z - (Vi->cview).translation.z);
        fixedxformy(&matrix,iVar4);
        if (bVar1 == 9) {
          iVar9 = (int)objInstance->qz << 8;
          iVar10 = (int)objInstance->qy << 8;
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
          light = objInstance->qw;
          DrawW_gObjScratch_148 = 0;
          matrix.m[2] = iVar4;
          matrix.m[5] = iVar5;
        }
        objDef_00 = Track_gObjDefs[objInstance->pad];
DrawWChunkFacets_emitObj:
        iVar14 = DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef_00,
                            (coorddef *)&objInstance->x,iVar14,light);
        totalCount = totalCount + iVar14;
      }
      else {
        if (bVar1 == 2) {
          Quatern_QuatToMat((tQuat *)&objInstance->qx,&matrix);
          iVar9 = (int)objInstance->sx << 8;
          iVar10 = (int)objInstance->sy << 8;
          iVar11 = (int)objInstance->sz << 8;
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
          objDef_00 = Track_gObjDefs[objInstance->pad];
          light = *(short *)&objInstance->simIndex;
          matrix.m[2] = iVar4;
          matrix.m[5] = iVar5;
          goto DrawWChunkFacets_emitObj;
        }
        if (bVar1 < 3) {
          if (bVar1 == 1) {
            iVar14 = DrawObjectSimple(Vi,(Draw_DCache *)&Render_gPalettePtr,
                                Track_gObjDefs[objInstance->pad],
                                (coorddef *)&objInstance->x,iVar14);
            totalCount = totalCount + iVar14;
          }
        }
        else if (bVar1 == 5) {
          objDef_00 = Track_gObjDefs[objInstance->pad];
          pOVar6 = Object_GetAnim(simObjs + objInstance->simIndex);
          if (pOVar6 == (ObjectAnim *)0x0) {
            Quatern_QuatToMat((tQuat *)&objInstance->qx,&matrix);
            iVar9 = (int)objInstance->sx << 8;
            iVar10 = (int)objInstance->sy << 8;
            iVar11 = (int)objInstance->sz << 8;
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
          pOVar6 = Object_GetAnim(simObjs + objInstance->simIndex);
          (*(*pOVar6->_vf)[2].pfn)
                    ((int)&pOVar6->_vf + (int)(*pOVar6->_vf)[2].delta,Vi,0x1f800000,iVar14);
        }
        else if (bVar1 == 9) {
          xformy(&matrix,(int)objInstance->qx);
          iVar9 = (int)objInstance->qz << 8;
          iVar10 = (int)objInstance->qy << 8;
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
          objDef_00 = Track_gObjDefs[objInstance->pad];
          light = objInstance->qw;
          matrix.m[2] = iVar4;
          matrix.m[5] = iVar5;
          goto DrawWChunkFacets_emitObj;
        }
      }
DrawWChunkFacets_groupNext:
      objInstance = (Trk_CollideBoomInst *)((char *)objInstance + objInstance->size);
    }
  }
  return totalCount;
}

/* ---- ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:2660-2709] SLD-VERIFIED ---- */
void * ObjectClipped(DRender_tView *Vi,int ind,coorddef *pCp,Draw_tGiveShelbyMoreCache *sd)

{
  /* MATCH (2026-07-04, was 59 diffs -> 43): SYM (nfs4-f-v3.txt @0x800C8BD0) shows this
     fn returns BOOL and names ONLY ONE reg local -- `bSphere` (tBoundingSphere*, the
     REAL type of `gPersistObjDefBoundingSpheres[ind*2+1]` reinterpreted; matches the
     oracle's 4 halfword reads at +0/2/4/6 == tBoundingSphere{COORD16 cp;short radius;})
     -- plus the THREE already-declared AUTO stack locals `tmp`/`tmp2`/`trans` (each a
     12-byte coorddef). The Ghidra-decompiled Group/m_num_elements byte-cast arithmetic
     computed the SAME byte address (Group is 4B, `ind*2+1` elems == the tBoundingSphere
     byte offset `ind*8+4`) but obscured the clean typed struct access, and left `trans`
     UNUSED -- the oracle actually block-COPIES the whole `Vi->cview.translationInv`
     coorddef (x/y/z, all 3 ints incl. the otherwise-dead .y) into `trans` BEFORE the
     `transform()` call, then re-reads `trans.x`/`trans.z` from the STACK afterward
     (not from `Vi` again) -- `Vi` itself stays resident in the caller-saved $a3 across
     the call (never spilled) purely for the 3 field reads that happen before the call
     + the matrix-address arg; nothing reads `Vi` after the call. This is the classic
     §5.0c STRUCT-COPY lever (field-by-field would let gcc skip the .y copy + keep
     iVar1/iVar2 live across the call in registers -- the 59-diff version this replaces).
     The base-address arithmetic ALSO needed the exact `+4-then-scaled-index` ORDER the
     oracle uses (`addiu s0,s0,4; addu s0,s0,a1`, not `addu` first) -- a single combined
     expression `base+4+ind*8` (any operand order/grouping tried) instead folds the `+4`
     INTO the scaled index reg (`addiu a1,a1,4`), a different (wrong) 1-insn shape; only
     an explicit 3-statement sequential pointer mutation (assign, then +4, then
     +ind*8, each its own statement) reproduces the oracle's base-first-then-index order.
     PASS (2026-07-05, was 43 diffs 52-vs-61 insns -> 100% MATCH, 61==61 insns). The
     43-diff residual was NOT a scheduling/hoist issue as first suspected -- it was TWO
     more source-shape misses, same family as the STRUCT-COPY lever above:
     (1) `trans = (Vi->cview).translationInv;` (an aggregate struct assign) makes gcc
     block-copy via 3 PARALLEL temps ($t0-$t2 load-all/store-all); the oracle instead
     copies FIELD-BY-FIELD, one load+store at a time (`lw v0,0x38(a3); sw v0,0x30(sp);
     lw v0,0x3c(a3); sw v0,0x34(sp); ...`), reusing a SINGLE scratch ($v0) interleaved
     with the `transform()` arg-address computations -- writing `trans.x=...; trans.y=
     ...; trans.z=...;` as 3 separate field assigns reproduces this exactly.
     (2) `iVar1`/`iVar2` as separate scalars is wrong -- the oracle keeps the running sum
     IN `tmp2.x`/`tmp2.z` themselves (`tmp2.x += trans.x; tmp2.y += trans.y; tmp2.z +=
     trans.z;` -- note the otherwise-DEAD `.y` sum IS computed+stored, confirming an
     in-place 3-field accumulate, not 2 scalar adds) and again for the radius term
     (`tmp2.z += bSphere->radius*0x400;`) -- giving `iVar1=tmp2.x`/`iVar2=tmp2.z` as
     mere aliases of the accumulated fields, not independent locals.
     (3) the final `if/else` arms were SWAPPED vs the oracle's branch polarity: oracle's
     `bnez v0,.trueLabel` falls through to the `else`-shaped body first (delay-slot
     `sw`+`negu`+`j`+`slt`) and jumps forward only for the `pvVar3=1` arm -- writing
     `if(iVar1<=iVar2){slt-arm} else {pvVar3=1;}` (arms swapped from the natural
     `if(iVar2<iVar1)` reading) matches. All three combined -> 61==61, byte-identical. */
  tBoundingSphere *bSphere;
  int iVar1;
  int iVar2;
  void *pvVar3;
  coorddef tmp;
  coorddef tmp2;
  coorddef trans;

  bSphere = (tBoundingSphere *)(gPersistObjDefBoundingSpheres);
  bSphere = (tBoundingSphere *)((char *)bSphere + 4);
  bSphere = (tBoundingSphere *)((char *)bSphere + ind * 8);
  tmp.x = bSphere->cp.x * 0x400 + pCp->x;
  tmp.y = bSphere->cp.y * 0x400 + pCp->y;
  tmp.z = bSphere->cp.z * 0x400 + pCp->z;
  trans.x = (Vi->cview).translationInv.x;
  trans.y = (Vi->cview).translationInv.y;
  trans.z = (Vi->cview).translationInv.z;
  transform(&tmp.x,(Vi->cview).mrotationInv.m,&tmp2.x);
  tmp2.x = tmp2.x + trans.x;
  tmp2.y = tmp2.y + trans.y;
  tmp2.z = tmp2.z + trans.z;
  iVar1 = tmp2.x;
  tmp2.z = tmp2.z + bSphere->radius * 0x400;
  iVar2 = tmp2.z;
  if (iVar1 <= iVar2) {
    pvVar3 = (void *)(u_int)(iVar2 < -iVar1);
  }
  else {
    pvVar3 = (void *)0x1;
  }
  return pvVar3;
}

/* ---- DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry  [DRAWW.CPP:2717-2864] SLD-VERIFIED ---- */
void DrawW_DoObjects(DRender_tView *Vi,tBuildEntry *buildList)

{
  /* MATCH (2026-07-11 FABLE-1): full SYM-driven rewrite (rule 8 was never applied
     to this fn) -- the SYM's REAL local set for this fn is exactly {sd, chunkCount
     (AUTO/stack!), buildInd, chunkDat, simObjs, chunkInd, geomRez, thisChunkInd};
     the prior draft invented Ghidra-artifact temps (iVar2/iVar5/iVar6/pCVar3/
     pGVar4/sVar1) with NO SYM counterpart, which pinned an extra live pseudo the
     oracle doesn't have (oracle needs 9 persistent callee-saved regs incl. `fp`
     for this fn; the artifact-temp draft only ever colored 8, cascading a
     whole-function register-role shift). Key structural facts recovered from the
     SYM + raw oracle: (1) `chunkCount` is class AUTO (stack-resident, NOT a
     register) -- the oracle genuinely RELOADS it from the stack every loop test
     rather than keeping it live in an s-reg; (2) `chunkDat` (Track_chunkList +
     chunkInd) is computed ONCE per iteration and reused via ONE base register for
     BOTH the objInstanceBuf and objSpecialInstanceBuf field reads (no separate
     `pCVar3` re-index); (3) `simObjs` is likewise computed ONCE per iteration
     (right after chunkDat) and reused for BOTH DrawW_Build*Facets calls, not
     recomputed per-branch. */
  Draw_DCache *sd;
  int thisChunkInd;
  int chunkCount;

  sd = (Draw_DCache *)&Render_gPalettePtr;
  chunkCount = BWorld_gChunkCount;
  thisChunkInd = gCurrContext->currentChunk;
  *(Track_tArtresource **)((char *)sd + 0xfc) = &gInitialArt;
  gVi = Vi;
  {
  int buildInd;
  buildInd = 0;
  while (1) {
    if (chunkCount <= buildInd) break;
    if ((buildList->enableBits & 2U) != 0) {
      Chunk *chunkDat;
      Trk_SimObject *simObjs;
      int chunkInd;
      int geomRez;
      chunkInd = buildList->chunkInd;
      chunkDat = Track_chunkList + chunkInd;
      simObjs = (Trk_SimObject *)(chunkDat->simObjBuf + 1);
      geomRez = (int)buildList->geomRez;
      if (chunkDat->objInstanceBuf != (Group *)0x0) {
        *(short *)((char *)sd + 0xda) = 1;
        gChunkObjInfo.simObjs = simObjs;
        gChunkObjInfo.objInstanceBuf = chunkDat->objInstanceBuf;
        gChunkObjInfo.doFrustumClip = (int)(geomRez == 4);
        gWSavePtr = (u_long)SetSp(&gScratchLastWord);
        stackSpeedUpEnbabledFlag = 1;
        DrawW_BuildChunkObjectFacets(gVi,&gChunkObjInfo);
        gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
      }
      if (((GameSetup_gData.Time == 0) && (GameSetup_gData.Weather == 0)) &&
         (chunkDat->objSpecialInstanceBuf != (Group *)0x0)) {
        *(short *)((char *)sd + 0x148) = 0x400;
        *(short *)((char *)sd + 0xda) = 0;
        gChunkObjInfo.visList = (short *)0x0;
        gChunkObjInfo.simObjs = simObjs;
        gChunkObjInfo.objInstanceBuf = chunkDat->objSpecialInstanceBuf;
        gChunkObjInfo.zClipSq = -1;
        gChunkObjInfo.offset = 0x32;
        gChunkObjInfo.doFrustumClip = 1;
        DrawW_BuildObjectFacets(gVi,&gChunkObjInfo);
      }
    }
    buildList = buildList + 1;
    buildInd = buildInd + 1;
  }
  }
  *(short *)((char *)sd + 0xda) = 0;
  /* BUG FIXED (2026-07-11 consolidation, correctness over byte-match per project policy):
     oracle stores 0x400 here, not 0 -- the loop-exit branch's DELAY SLOT unconditionally
     re-materializes `addiu v0,zero,0x400` (B9548; delay slots execute on BOTH paths, §3.1),
     and that same v0 is stored at B9678 `sh v0,0x148(s6)`. The wave-7 `=0` reading misread
     the slot as the slt result. Costs one extra `li` vs `$zero` (+~15 fuzzy diffs) --
     accepted; this value feeds DrawW_BuildCustomObjectFacets via the scratchpad field. */
  *(short *)((char *)sd + 0x148) = 0x400;
  if (gPersistObjInst != (Group *)0x0) {
    if (((GameSetup_gData.track != 4) ||
        (((0x27 < thisChunkInd - 1U && (0x1d < thisChunkInd - 0x3dU)) && (8 < thisChunkInd - 0x6cU)))) &&
       ((GameSetup_gData.track != 0 ||
        (((0x34 < thisChunkInd - 1U && (0x1b < thisChunkInd - 0x44U)) && (0x13 < thisChunkInd - 0x6cU)))))) {
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
    /* MATCH+BUG (2026-07-11 FABLE-1): Track_gInViewList is declared `short **`
       (array of pointers) so `Track_gInViewList[iVar6]` double-derefs (index by
       stride 4, then load a pointer) -- oracle instead loads the GLOBAL'S OWN
       pointer VALUE once and does byte-address math with a 64-byte (0x40) row
       stride (`lw v0,Track_gInViewList; sll v1,iVar6,6; addu v0,v0,v1` -- single
       load, no second dereference). This matches track.cpp's own construction of
       the buffer (`*Track_gInViewList + matOffset`, matOffset += 0x40 per chunk):
       Track_gInViewList's real runtime semantics are a flat buffer base pointer
       with a 64-byte-per-chunk row stride, not an array of row pointers. Can't
       fix the extern's declared type here (decl-only change, out of scope for
       this pass) -- reproduce the true addressing via a body-local cast instead. */
    /* NEAR-MISS FLOOR (76 diffs, w9-a10 2026-07-11): traced the raw oracle prologue
       instruction-by-instruction -- it's a WHOLESALE callee-saved-register ROLE SHIFT,
       not a structural gap: oracle allocates {s2:buildList, s4:buildInd, s6:sd-scratchpad-
       base, s7:hi(gChunkObjInfo)-reused-for-fused-%lo(sym+off)-stores, s1:&gChunkObjInfo,
       fp:&GameSetup_gData, s5:thisChunkInd, t0(spilled@sp+0x18):chunkCount}; ours lands
       {s4:buildList, s6:buildInd, s7:sd, ...} -- every one of those roles is shifted DOWN
       one slot from where the oracle puts it. Root cause isolated to gChunkObjInfo's
       address materialization: oracle uses TWO registers for it (s1=full pointer for
       small-offset field stores, s7=bare hi-part reused via fused `%lo(sym+off)($s7)` for
       at least one field store `sw s3,%lo(gChunkObjInfo)($s7)`) -- a dual-materialization
       scheduling choice that consumes one extra callee-saved slot and pushes every
       lower-priority local (buildList/buildInd/sd) up by one register number. Our
       reconstruction's plain `gChunkObjInfo.field = val;` member-store syntax is
       source-identical to what SHOULD trigger this (nothing to rewrite at the C level);
       whether gcc dual-materializes is an allocator/scheduler heuristic decision (which
       field stores get batched under the same hi-part) not controlled by source shape.
       Not source-reachable within this pass's scope; accept as a genuine allocator floor. */
    gChunkObjInfo.visList = (short *)((char *)Track_gInViewList + thisChunkInd * 0x40);
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    DrawW_BuildObjectFacets(gVi,&gChunkObjInfo);
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
  }
  if ((Object_customObjInst != (Group *)0x0) && (0 < Object_customObjInst->m_num_elements)) {
    DrawW_BuildCustomObjectFacets(Vi,sd,(Trk_SimObject *)(Object_customSimObjs + 1),
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
  int ti2;
  u_char bVar2;

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
      /* MATCH (2026-07-11): oracle re-reads Render_gPacketEnd's TRUE storage
       * address (scratchpad 0x1F800008, same "Render_gPacketPtr style" fixed-
       * lvalue idiom as nfs4_types.h's Render_gPacketPtr/Render_gPalettePtr
       * macros -- confirmed via Draw_StartRenderingView's oracle .s, which
       * writes Render_gPacketEnd through a literal lui/ori 0x1F800008, never
       * %hi/%lo(sym)). draww_externs.h still declares it a plain extern
       * (header edits are out of scope here), so the literal cast is applied
       * locally at this one use site only -- no other TU's codegen changes. */
      if ((Render_gPacketPtr < *(u_char **)0x1f800008) && (((coorddef *)(pt1_index + 0x24))->y != 0)) {
gte_ldv0((int *)(depth_index));
        gte_rtps();
gte_stlvnl((void *)0x1f800098);
        primPtr = Render_gPacketPtr;
        /* CORRECTNESS FIX (2026-07-12, oracle @0x800C92E0): SXY goes to the
         * CURRENT packet cursor (Render_gPacketPtr + 8), not the fixed
         * scratchpad literal 0x1F800008 (= Render_gPacketEnd's slot). */
gte_swc2(0xe,(void *)(primPtr + 8));
gte_ldv0((int *)(depth_index));
        gte_rtps();
gte_stlvnl((void *)0x1f8000a8);
gte_ldv0((int *)(((coorddef *)(pt1_index + 0x24))->y + 8));
        gte_rtps();
gte_stlvnl((void *)0x1f8000b8);
gte_ldv0((int *)(((coorddef *)(pt1_index + 0x24))->y));
        gte_rtps();
gte_stlvnl((void *)0x1f8000c8);
        /* MATCH (2026-07-11): the four gte_stlvnl() calls just above write the
         * transformed vx/vy/vz triples DIRECTLY to scratchpad 0x1f800098 /
         * 0x1f8000a8 / 0x1f8000b8 / 0x1f8000c8 (matching DrawW_OnyxLinePrim's
         * sd->tVn0..tVn3 vx@+0/vz@+8 layout), and the oracle re-reads them
         * back via LITERAL displacements off a cached base register (never
         * %hi/%lo(sym)) -- the Skid_gCtrlScratch_98/Skid_gCtrlPoint_0..6
         * globals (skidmark.cpp, normal .bss) were consequently a STALE-READ
         * correctness bug: the compares never saw what gte_stlvnl() just
         * wrote. Used ONLY inside this one function (grep-confirmed), so
         * safe to fix in isolation. Eight SEPARATE `*(int*)0x1fxxxxxx` casts
         * (one per compare operand) compiled clean but REGRESSED the gate
         * (379->397 insns) -- gcc materialized the 0x1F80____ base
         * independently at each site instead of sharing ONE register. A
         * SINGLE shared local pointer (`skidCmp`, below), indexed, recovers
         * gcc's natural CSE of the base address AND wins outright
         * (379->365 insns, 462->410 diffs). */
        {
        int *skidCmp = (int *)0x1f800098;
        if (((skidCmp[0] < skidCmp[2]) ||
            (((skidCmp[4] < skidCmp[6] || (skidCmp[8] < skidCmp[10])) ||
             (skidCmp[12] < skidCmp[14])))) &&
           ((((-skidCmp[0] < skidCmp[2] || (-skidCmp[4] < skidCmp[6])
              ) || (-skidCmp[8] < skidCmp[10])) ||
            (-skidCmp[12] < skidCmp[14])))) {
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
            vert_idx = (vt_y - (short)Skid_gScratchPos1) * 0x10 >> (Skid_gScratchPos2);
            if (vert_idx < 0) {
              vert_idx = 0;
            }
            else if (0xf < vert_idx) {
              vert_idx = 0xf;
            }
            *(short *)((int)primPtr + 0xe) = gClutDepth[*(u_short *)(pmx_dst + 10)][vert_idx];
          }
          /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE (2026-07-11; same shape
           * as DrawW_OnyxLinePrim's sealed instance -- fastmovf.c family;
           * $t4/$t5/$t6 scratches, POLY_GT4 stride 0x34, tag 0x0C<<24): slot =
           * Render_gPalettePtr(value) + Skid_gCtrlScratch_94*4; Render_gPacketPtr
           * += 0x34; primOut->tag = slot->addr24 | (0x0C<<24); slot->addr24 =
           * primOut. Oracle materializes the scratch base (0x1F800000, ==
           * &Render_gPalettePtr) into ONE persistent register ($s1) and the otz
           * address (0x1F800094, == &Skid_gCtrlScratch_94) into a SECOND
           * persistent register ($fp) set once at function entry; we can't
           * force that cross-call register persistence from a single local
           * asm block without a header/global-decl change (out of scope here),
           * so &Skid_gCtrlScratch_94's value is passed in fresh -- a few insns
           * of address-materialization floor remain, but the whole 13-line
           * bit-shift/alignment emulation below (which was ALSO producing the
           * WRONG runtime effect: it recomputed a byte-aligned unaligned merge
           * generically instead of linking the primitive into the OT chain at
           * all -- Render_gPacketPtr's new prim was never inserted into
           * sub_ot[otz], a real rendering bug, dropped skidmark polys) collapses
           * into the compact link sequence. */
          {
            void *primOut;
            __asm__ volatile(
                "lw	%0,4(%1)\n\t"
                "sll	$t4,%2,2\n\t"
                "lw	$t5,0(%1)\n\t"
                "addiu	$t6,%0,52\n\t"
                "addu	$t5,$t5,$t4\n\t"
                "sw	$t6,4(%1)\n\t"
                "lwl	$t6,2($t5)\n\t"
                "lui	$t4,0x0C00\n\t"
                "srl	$t6,$t6,8\n\t"
                "or	$t6,$t6,$t4\n\t"
                "sll	$t4,%0,8\n\t"
                "sw	$t6,0(%0)\n\t"
                "swl	$t4,2($t5)"
                : "=&r"(primOut)
                : "r"(&Render_gPalettePtr), "r"(Skid_gCtrlScratch_94)
                : "$12", "$13", "$14", "memory");
          }
        }
        }
      }
      pt1_index = (int)&((coorddef *)(pt1_index + 0x18))->y;
    }
  } while( true );
}

/* ---- DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:3049-3103] SLD-VERIFIED ---- */
void DrawW_SetUpSubdividFacet_Line(Draw_tGiveShelbyMoreCache *sd)

{
  /* MATCH (2026-07-11, PASS 166==166, FAIL 174 -> 0): SYM (nfs4-f-v3.txt
     @0x800C9620) names the outer scope's REAL locals `v0,v1,v2,v3` (REG PTR
     Draw_SVertex) + `prim` (REG PTR POLY_GT4), kept live across the whole fn in
     callee-saved regs -- NOT repeated `sd->vN` field access (was 76 diffs: two
     copies of the same field-fusion bug -- see cont'd below). Two SIBLING nested
     blocks (both `line=1`, tight source scopes) hold: (1) `a,b` (REG LONG) = the
     two fused color words read via `prim` (POLY_GT4.r1/g1/b1/p1 and r0/g0/b0/code
     each pack into ONE u_long, `*(u_long*)&vN->r = word` not 4 byte fields); (2)
     `a,b,c,d` (REG USHORT) = the four UV shorts, ALSO fused on the WRITE side
     (`*(u_short*)&vN->u = word`, u/v are adjacent u_chars at +0x6 forming one
     u_short) -- not just the read. v0..v3/prim are set up BEFORE the
     LoadPrecVECTOR calls (matching the oracle: it materializes all 4 vertex
     addresses + saves all 4 callee-saved regs FIRST, then makes the 4 calls,
     since `&sd->vN` is CSE'd across its use as both the call arg and the later
     field access) and passed as the call args directly instead of `&sd->vN`
     inline.
     RESIDUAL (174 -> 0, PASS): the 4 near-identical alpha-flag blocks
     (`ts=v->dvx; v->a=0; if(ts<K){...ts...}`) each cost 2 extra insns -- oracle
     reads `dvx` ONCE via a signed `lh`; caching it into a named `short ts` local
     first made cc1plpsx instead emit `lhu+sll 16+sra 16` (functionally identical
     3-insn manual sign-extend) for the SAME value re-read inside the nested `if`.
     Removing the intermediate local and reading `v->dvx` directly at both use
     sites (matching how `v->dvy`/`vz` are already read a second time via ts2/
     ts4/ts6 already) restored the plain `lh`. Structurally-identical rewrite for
     all 4 vertices; v3's block additionally lost its own now-redundant `ts5`. */
  Draw_SVertex *v0;
  Draw_SVertex *v1;
  Draw_SVertex *v2;
  Draw_SVertex *v3;
  POLY_GT4 *prim;
  u_long cw_a;
  u_long cw_b;
  short ts4;
  short ts2;
  short ts6;

  v0 = &sd->v0;
  v1 = &sd->v1;
  v2 = &sd->v2;
  v3 = &sd->v3;
  DrawW_LoadPrecVECTOR(v0,&sd->tVn0);
  DrawW_LoadPrecVECTOR(v1,&sd->tVn1);
  DrawW_LoadPrecVECTOR(v2,&sd->tVn2);
  DrawW_LoadPrecVECTOR(v3,&sd->tVn3);
gte_ldv0(((char *)sd + 0x14c));
  gte_rtps();
gte_swc2(0xe,((char *)sd + 0x154));
gte_ldv3(((char *)sd + 0x15c),((char *)sd + 0x16c),((char *)sd + 0x17c));
  gte_rtpt();
  prim = &sd->GT4Prim;
  cw_a = *(u_long *)&prim->r1;
  cw_b = *(u_long *)&prim->r0;
  *(u_long *)&v2->r = cw_a;
  *(u_long *)&v1->r = cw_a;
  *(u_long *)&v3->r = cw_b;
  *(u_long *)&v0->r = cw_b;
gte_stsxy3(((char *)sd + 0x164),((char *)sd + 0x174),((char *)sd + 0x184));
  {
    u_short a;
    u_short b;
    u_short c;
    u_short d;

    a = *(u_short *)&prim->u0;
    b = *(u_short *)&prim->u1;
    c = *(u_short *)&prim->u3;
    d = *(u_short *)&prim->u2;
    *(u_short *)&v0->u = a;
    *(u_short *)&v1->u = b;
    *(u_short *)&v2->u = c;
    *(u_short *)&v3->u = d;
  }
  v0->a = '\0';
  if (v0->dvx < 0x3e9) {
    ts2 = v0->dvy;
    if ((((1000 < ts2) || (v0->dvx < -1000)) || (ts2 < -1000)) || (v0->vz < 0x65))
    goto DrW_SubSetupLine_v0Alpha;
  }
  else {
DrW_SubSetupLine_v0Alpha:
    v0->a = '\x01';
  }
  v1->a = '\0';
  if (v1->dvx < 0x3e9) {
    ts4 = v1->dvy;
    if (((1000 < ts4) || (v1->dvx < -1000)) || ((ts4 < -1000 || (v1->vz < 0x65))))
    goto DrW_SubSetupLine_v1Alpha;
  }
  else {
DrW_SubSetupLine_v1Alpha:
    v1->a = '\x01';
  }
  v2->a = '\0';
  if (v2->dvx < 0x3e9) {
    ts6 = v2->dvy;
    if (((1000 < ts6) || (v2->dvx < -1000)) || ((ts6 < -1000 || (v2->vz < 0x65))))
    goto DrW_SubSetupLine_v2Alpha;
  }
  else {
DrW_SubSetupLine_v2Alpha:
    v2->a = '\x01';
  }
  v3->a = '\0';
  if (v3->dvx < 0x3e9) {
    ts6 = v3->dvy;
    if ((((ts6 < 0x3e9) && (-0x3e9 < v3->dvx)) && (-0x3e9 < ts6)) && (100 < v3->vz))
    goto DrW_SubSetupLine_callSubdiv;
  }
  v3->a = '\x01';
DrW_SubSetupLine_callSubdiv:
  DrawW_SubdividFacet(sd,0,v0,v1,v2,v3,0,0);
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
      /* CORRECTNESS FIX (2026-07-12, oracle-adjudicated @0x800C99C8): the SXY
       * write targets the CURRENT packet cursor -- `lw s0,0x1F800004; addiu
       * v0,s0,8; swc2 $14,0(v0)` = Render_gPacketPtr + 8 -- NOT the fixed
       * scratchpad literal 0x1F800008 (which holds Render_gPacketEnd; writing
       * a screen coord there would clobber the end-of-buffer pointer). Kept
       * despite a small diff-rise (register-allocation cascade) per the
       * correctness-forward keep-rise policy. */
      tp17 = Render_gPacketPtr;
gte_swc2(0xe,(void *)(tp17 + 8));
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
              /* NOTE (2026-07-11, REVERTED after verify-or-revert): the oracle
                 emits a lone `lwl/swl $t4-$t6` 24-bit-tag-link sequence here (EA
                 DMPSX-analog fixed-register OT-link template family; see
                 drawc.cpp DRAWC_OTLINK_FT3, alloc stride 0x34/tag 0xC000000
                 variant, index via &sd->otz). A local fixed-register __asm__
                 equivalent was tried and round-tripped through cc1pl/maspsx with
                 no error, but produced ZERO change in the compiled object (no
                 lwl/swl emitted anywhere in the function -- confirmed via the
                 raw cc1pl .s between this function's .ent/.end markers). Root
                 cause not isolated in the time available (suspect an operand/
                 clobber-count limit or asm-statement placement quirk specific to
                 CC1PLPSX 2.8.0 on this call shape). Reverted to the compiling
                 shift/mask C form pending a follow-up debugging pass -- do not
                 re-attempt this exact asm text without diagnosing why it drops. */
              primSlot = (int)(sd->head).cprim.PrimPtr;
              /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE (same shape as
               * DrawW_SubdividFacet / DrawW_DrawQuad's sealed instances; fastmovf.c
               * family; $t4/$t5/$t6 scratches): slot = sd->head.cprim.LastPrim +
               * sd->otz*4; sd->head.cprim.PrimPtr = primSlot+0x34; primSlot->tag =
               * slot->addr24 | (0x0C<<24); slot->addr24 = primSlot. */
              __asm__ volatile(
                  "lw	$t4,0(%2)
	lw	$t5,0(%1)
	addiu	$t6,%0,52
	sll	$t4,$t4,2
	addu	$t5,$t5,$t4
	sw	$t6,4(%1)
	lwl	$t6,2($t5)
	lui	$t4,0x0C00
	srl	$t6,$t6,8
	or	$t6,$t6,$t4
	sll	$t4,%0,8
	sw	$t6,0(%0)
	swl	$t4,2($t5)"
                  : : "r"(primSlot), "r"(sd), "r"(&sd->otz)
                  : "$12", "$13", "$14", "memory");
            }
            else {
              primSlot = (int)&sd->GT4Prim;
            }
            tpage_word = ot_addr_pack;
gte_swc2(0x8,&depthcue);
            if (sd->nightFlags == 0) {
              /* MATCH: oracle reads Chunk_lightTable[light] as ONE unaligned WORD
               * (lwl/lwr -- primSlot is an `int`-typed address, so GCC can't prove
               * alignment through the cast and always uses the unaligned form; same
               * for the write-back below) and writes the dpcs() result DIRECTLY to
               * primSlot+0x1c (r2/g2/b2/p2), then duplicates that SAME word
               * (unaligned lwl+lwr / swl+swr re-read+copy) into primSlot+0x4
               * (r0/g0/b0/code -- the code byte there gets overwritten again below). */
              *(u_int *)&a = *(u_int *)(Chunk_lightTable + vt3.light);
gte_ldrgb(&a);
              gte_ldIR0(depthcue);
              gte_dpcs();
gte_swc2(0x16,(char *)primSlot + 0x1c);
              *(u_int *)(primSlot + 4) = *(u_int *)(primSlot + 0x1c);
              *(u_int *)&a = *(u_int *)(Chunk_lightTable + vt2.light);
gte_ldrgb(&a);
              gte_ldIR0(depthcue);
              gte_dpcs();
gte_swc2(0x16,(char *)primSlot + 0x28);
              *(u_int *)(primSlot + 0x10) = *(u_int *)(primSlot + 0x28);
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
              ti9 = (save_pre_otz_l - sd->startfog) * 0x10 >> ((int)sd->distfog);
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
  /* MATCH (2026-07-11, rule-8 SYM rewrite, 88==88 insn-exact -> coloring pass): SYM
     VA 800ca0a4 names this exact local set at fn scope (i, pts3d, lineQuad, slice,
     tx, ty, tz, wpts) -- pts3d/wpts replace the old pCVar20+psVar19 TWO-pointer
     scheme with array-indexed CCOORD16 struct-field stores off ONE base (pts3d[0].f
     / pts3d[1].f), matching the oracle's single `lhu/sh` displacement pattern (the
     2nd base the oracle DOES use, t2 = pts3d+6, is the compiler's own strength
     reduction of pts3d[N].light -- not a source-level variable). The walking
     Trk_Line* (curLine, oracle $t4) reads firstPoint/slice as named struct fields
     instead of raw u_char[0]/[1] casts (Trk_Line = {firstPoint,slice,type,quadIndex}
     matches the byte layout 1:1); lineQuad is materialized FRESH at the call site
     (matching oracle recomputing group+1 via $t9 there) rather than reusing the
     now-advanced walking pointer. chunkDat->firstSimSliceInd has NO separate SYM
     name -- it's a loop-invariant load the compiler CSEs into $s2 on its own; giving
     it an explicit local (the old sVar3) is unnecessary and is dropped. */
  int i;
  Trk_Line *curLine;
  CCOORD16 *pts3d;
  Trk_Line *lineQuad;
  int slice;
  short tx;
  short ty;
  short tz;
  CCOORD16 *wpts;

  pts3d = gVertex3d;
  curLine = (Trk_Line *)(group + 1);
  i = 0;
  slice = chunkDat->firstSimSliceInd;
  tx = trans->x;
  ty = trans->y;
  tz = trans->z;
  wpts = (CCOORD16 *)(chunkDat->vertexBuf + 1);
  while( true ) {
    bool bVar10 = i < group->m_num_elements << 1;
    i = i + 2;
    if (!bVar10) break;
    CCOORD16 *pCoord;
    int pts;
    int idx;
    char *rightN;
    short sVar7;
    short sVar8;
    short sVar9;
    short sVar12;
    short sVar13;
    short sVar14;
    pts = (u_int)curLine->firstPoint;
    idx = slice + (u_int)curLine->slice;
    pCoord = wpts + pts;
    sVar7 = pCoord->x;
    sVar8 = pCoord->y;
    sVar9 = pCoord->z;
    rightN = BWorldSm_slices[idx].right;
    sVar12 = (short)((int)((u_int)(u_char)rightN[0] << 0x18) >> 0x1b);
    pts3d[0].x = tx + (sVar7 - sVar12);
    sVar13 = (short)((int)((u_int)(u_char)rightN[1] << 0x18) >> 0x1b);
    pts3d[0].y = ty + (sVar8 - sVar13);
    sVar14 = (short)((int)((u_int)(u_char)rightN[2] << 0x18) >> 0x1b);
    pts3d[0].z = tz + (sVar9 - sVar14);
    pts3d[0].light = pCoord->light;
    pts3d[1].x = tx + sVar7 + sVar12;
    pts3d[1].y = ty + sVar8 + sVar13;
    pts3d[1].z = tz + sVar9 + sVar14;
    pts3d[1].light = pCoord->light;
    pts3d = pts3d + 2;
    curLine = curLine + 1;
  }
  lineQuad = (Trk_Line *)(group + 1);
  DrawW_OnyxLinePrim(gVertex3d,lineQuad,group->m_num_elements,sd);
  return;
}

/* ---- DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache  [DRAWW.CPP:3396-3467] SLD-VERIFIED ---- */
void DrawW_DoLines(DRender_tView *Vi,tBuildEntry *buildList,Draw_DCache *sd)

{
  /* MATCH (2026-07-11, 79 -> 52 diffs; insns now EXACT 199==199): the tmp.x/y/z
     computations `(Vi->cview).translation.N - ((Camera_gInfo[Vi->player].target)->
     position).N` (and the BW_gCopCarObj sibling block) are a genuine TWO-LEVEL
     POINTER CHASE (target ptr deref, then ->position.N) -- the oracle pays a real
     load-delay `nop` there because it evaluates the chase BEFORE reading
     Vi->cview.translation.N, but a single combined C expression let gcc interleave
     the translation.N load into the chase's delay slot instead (3 fewer insns,
     objectively better-scheduled but NOT byte-matching). Splitting each axis into
     its own `int posN = target->position.N; tmp.N = translation.N - posN;`
     statement pair forces the chase to be evaluated to completion FIRST (its own
     full statement), reproducing the oracle's stall + insn count exactly, for both
     the night-target and cop-car blocks (6 sites total).
     RESIDUAL 52 = ONE uniform $s1<->$s2 register-pair swap across the WHOLE body:
     oracle colors buildList(a1)->s1, sd(a2)->s2 (strict parameter order); ours
     colors sd->s1, buildList->s2 (sd's earlier/heavier use wins the low reg under
     gcc's usage-priority tie-break). Tried: index-form buildList[buildInd] instead
     of pointer-walk (regressed to 54, worse), a fresh `bl=buildList;` alias
     declared before any sd touch (diff-neutral, gcc coalesces bl back to a1), and
     (2026-07-11 FABLE-1) a `localSd=sd;` alias used for every pre-loop sd access
     (diff-neutral, gcc coalesces localSd back to a2 too) -- all three exhausted.
     No jal/call forces buildList or sd into a specific ABI reg at
     the point of divergence (the prologue's own initial parameter->s-reg copy), so
     this is a pure allocator usage-priority tie-break, not source-reachable by the
     standard levers; permuter/accept candidate. */
  int chunkCount;

  chunkCount = BWorld_gChunkCount;
  sd->doublelayer = 0;
  (sd->matB).t[2] = 0;
  (sd->matB).t[1] = 0;
  (sd->matB).t[0] = 0;
  gte_SetTransMatrix(&sd->matB);
  {
    int buildInd;
    for (buildInd = 0; buildInd < chunkCount; buildInd = buildInd + 1) {
      Chunk *chunkDat;
      int geomRez;
      geomRez = (signed char)buildList->geomRez;
      if (geomRez == 4) {
        chunkDat = Track_chunkList + buildList->chunkInd;
        Group *group = chunkDat->lineBuf;
        if ((group != (Group *)0x0) && ((buildList->enableBits & 4U) != 0)) {
          COORD16 trans;
          if (gNight_renderNight != 0) {
            coorddef tmp;
            coorddef tmp2;
            u_char bVar1;
            bVar1 = *(u_char *)((int)sd[1].matB.t + 2);
            *(u_char *)((int)sd[1].matB.t + 2) = bVar1 | 4;
            if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
              *(u_char *)((int)sd[1].matB.t + 2) = bVar1 | 5;
            }
            {
              int posX = ((Camera_gInfo[Vi->player].target)->position).x;
              tmp.x = (Vi->cview).translation.x - posX;
            }
            {
              int posY = ((Camera_gInfo[Vi->player].target)->position).y;
              tmp.y = (Vi->cview).translation.y - posY;
            }
            {
              int posZ = ((Camera_gInfo[Vi->player].target)->position).z;
              tmp.z = (Vi->cview).translation.z - posZ;
            }
            transform(&tmp.x,gNightMat.m,&tmp2.x);
            DrawW_WorldSetUpTranslation(&tmp2,&sd->matNight);
            if (BW_gCopCarObj != (Car_tObj *)0x0) {
              {
                int posX = (BW_gCopCarObj->N).position.x;
                tmp.x = (Vi->cview).translation.x - posX;
              }
              {
                int posY = (BW_gCopCarObj->N).position.y;
                tmp.y = (Vi->cview).translation.y - posY;
              }
              {
                int posZ = (BW_gCopCarObj->N).position.z;
                tmp.z = (Vi->cview).translation.z - posZ;
              }
              transform(&tmp.x,gCopMat.m,&tmp2.x);
              DrawW_WorldSetUpTranslation(&tmp2,&sd->matCop);
            }
            (sd->matB).t[2] = 0;
            (sd->matB).t[1] = 0;
            (sd->matB).t[0] = 0;
            gte_SetTransMatrix(&sd->matB);
          }
          {
            coorddef *pChunkCp;
            pChunkCp = Chunk_chunkCenters + buildList->chunkInd;
            trans.x = (short)(pChunkCp->x - (Vi->cview).translation.x >> 10);
            trans.y = (short)(pChunkCp->y - (Vi->cview).translation.y >> 10);
            trans.z = (short)(pChunkCp->z - (Vi->cview).translation.z >> 10);
            DrawW_BuildChunkCenterLineFacets(chunkDat,group,(Draw_tGiveShelbyMoreCache *)sd,&trans);
          }
        }
      }
      buildList = buildList + 1;
    }
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
  short fx;
  short fy;
  short fz;
  short sx;
  short sy;
  coorddef *cp;
  
  iVar9 = gSpikeBeltSlice;
  pTVar10 = BWorldSm_slices + iVar9;
  if (scale < 0) {
    scale = scale + 7;
  }
  iVar14 = scale >> 3;
  /* MATCH (2026-07-11): Trk_NewSlice.right[]/forward[] are declared plain `char`,
     which is UNSIGNED on this build (lbu on any bare read) -- but the oracle uses
     SIGNED byte loads (`lb`) for these full-range +-127 slope/width values (unlike
     the 5-bit-packed forms in BuildChunkCenterLineFacets). Cast to `signed char` at
     each use site to force `lb` and reproduce the sign-extension. */
  uVar6 = fixedmult((int)(signed char)pTVar10->right[0] << 9,iVar14);
  uVar7 = fixedmult((int)(signed char)BWorldSm_slices[iVar9].right[1] << 9,iVar14);
  uVar8 = fixedmult((int)(signed char)BWorldSm_slices[iVar9].right[2] << 9,iVar14);
  sVar18 = (short)((int)(signed char)BWorldSm_slices[iVar9].forward[0] >> 1);
  sVar17 = (short)((int)(signed char)BWorldSm_slices[iVar9].forward[1] >> 1);
  sVar16 = (short)((int)(signed char)BWorldSm_slices[iVar9].forward[2] >> 1);
  iVar14 = fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[iVar9].right[0] << 9);
  sVar15 = (short)(iVar14 >> 10);
  iVar14 = fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[iVar9].right[1] << 9);
  sVar13 = (short)(iVar14 >> 10);
  iVar9 = fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[iVar9].right[2] << 9);
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
  /* MATCH (2026-07-11): the `sd[1].head.xxx`/`sd[1].matB.t+N` byte-pun idiom used
     elsewhere in this TU (DoLines etc) computes sd+220+suboffset -- a numeric
     coincidence that happens to alias the REAL Draw_tGiveShelbyMoreCache fields
     (vertices@0xE0, quadCount@0xE7, quads@0xE8, offset@0xEC, materials@0xF0,
     trans@0xF4, nightFlags@0x106, zeroGTETransFlag@0x107) at sd+0 directly (the
     oracle's a0 IS sd, never sd+sizeof(Draw_DCache) -- confirmed against the final
     `DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache*)sd)` call, which already
     used the direct, unshifted cast). Writing through the real field names both
     fixes the address model and lets clipW+clipH (2 shorts) collapse into the
     oracle's single `offset` word store. */
  {
    Draw_tGiveShelbyMoreCache *sdG = (Draw_tGiveShelbyMoreCache *)sd;
    sdG->nightFlags = 0;
    /* MATCH (SYM @0x800CA520, Block start line=84): tmp/tmp2 are a NESTED
     * block-scope pair (not function-scope) -- §A row 36 "SYM BLOCK SCOPES
     * ARE LOAD-BEARING". */
    coorddef tmp;
    coorddef tmp2;
    tmp.x = pTVar10->center[0] - (Vi->cview).translation.x;
    tmp.y = pTVar10->center[1] - (Vi->cview).translation.y;
    tmp.z = pTVar10->center[2] - (Vi->cview).translation.z;
    transform(&tmp.x,gWorldMat.m,&tmp2.x);
    DrawW_WorldSetUpTranslation(&tmp2,&sd->matB);
    sdG->vertices = vertex3d;
    sdG->quadCount = 0x10;
    sdG->quads = quads;
    sdG->offset = 0x23;
    sdG->materials = &material;
    *(int *)&sdG->trans = 0;
    sdG->trans.z = 0;
    sdG->zeroGTETransFlag = 0;
    sdG->light = -1;
    DrawW_kCtrlWorld_High(sdG);
  }
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
