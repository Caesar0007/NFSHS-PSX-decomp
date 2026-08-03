/* game/psx/draww.cpp -- RECONSTRUCTED (NFS4 PSX world-geometry draw; C++ TU)
 *   35 fns: subdivision facets, world matrix/translation setup, night colour calc, DrawW_DrawQuad,
 *   object/chunk facet builders, object transforms, skidmarks, lines/spike-belt, anim timers, depth cue.
 *   GTE-heavy (142 cop2 stubs -> gte_ intrinsics). Full SYM-locals applied.
 *
 * PER-TU FLAG RECEIPT (w39-a2, 2026-08-01 -- measured with the now-WIRED compile_cpp
 * PER_TU_FLAGS keys; whole-TU gate over all 32 oracles, baseline 1989 diffs / 15 PASS):
 *     no_split_addresses  1989 -> 2654  (+665, 3 PASS->FAIL)
 *     no_schedule_insns   1989 -> 4231 (+2242, 6 PASS->FAIL)
 *     no_schedule_insns2  1989 -> 2611  (+622, 9 PASS->FAIL)
 *     no_strength_reduce  1989 -> 2257  (+268, 2 PASS->FAIL)
 * All four are decisively NEGATIVE and none produced a single FAIL->PASS -- draww.obj
 * was built with the project-default flag set.  Do not re-probe.
 */
#include "../../nfs4_types.h"
#include "draww_externs.h"

/* file-local gte_rtps variant with a DEAD "r" input (no code emitted for it -- the value
 * is already in a register): a ref-count nudge for the v4/v8 reload-eviction tie
 * (see DrawW_SubdividFacet MATCH notes). Promoted to psx_gte.h (w40 consolidation),
 * together with the value-form gte_ldir0v (the oracle's `mtc2 rt,$8`; gte_ldIR0() is
 * the ADDRESS form and cannot express it). */

/* Scratchpad overlay base (methodology SS3.6b): the PSX fast-RAM Draw cache lives at
   0x1F800000 and every field the renderer's GTE actually reads is an offset into it.
   DrawW_BuildChunkObjectFacets' oracle reaches matB (+0x14) and offsubdivid (+0x148)
   through LITERAL addresses (`lui $at,(0x1F800014>>16); sw $zero,...($at)`,
   `sh $v0,(0x1F800148 & 0xFFFF)($at)`), never a %hi/%lo symbol relocation. */
#define DW_SCRATCH  ((Draw_tGiveShelbyMoreCache *)0x1F800000)
#define DW_WORLDMAT (*(MATRIX *)0x1F800014)   /* == DW_SCRATCH->matB; the oracle
       anchors these three stores on the 0x1F800014 base, not on 0x1F800000 */

/* PsyQ POINTER-form colour-FIFO stores (inline_c gte_strgb / gte_strgb3): a lone
   `swc2 $22,0(rt)` and the three-pointer RGB0/1/2 trio.  psx_gte.h only carries the
   FIXED-OFFSET `gte_strgb3_gt4(p)` family (one base + folded displacements); the
   DrawW_DrawQuad oracle materializes each destination address into its own register
   (`addiu $a0,$s1,0x4; addiu $v1,$s1,0x10; addiu $v0,$s1,0x1C; swc2 $20,0($a0) ...`),
   which is exactly the "r"-constraint pointer form (catalog SS.H: the constraint, not
   the call site, decides address-materialization-vs-displacement).
   Promoted to psx_gte.h (w40 consolidation). */

/* ---- DrawW.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
signed char  offsets[8] = { 125, 125, 50, 15, -1, 125, 0, 0 };   /* @0x8013D828 -- MATCH+CORRECTNESS:
                        the oracle reads this table with `lb` (BuildCustomObjectFacets @0x800C7C3C,
                        %hi(D_8013D828)); `char` is UNSIGNED on this build, so entry 4 (-1) was
                        being read as +255 -- a real z-offset bug as well as an lbu-vs-lb diff. */
MATRIX       gIdentTemplate = {4096, 0};   /* @0x8011f570 */
int          trk0[9][2] = { 410, 530, 800, 850, 800, 850, 800, 850, 800, 850, 800, 850, 815, 885, 815, 885, 815, 885 };   /* @0x8011f590 */
int          trk4[10][2] = { 300, 440, 300, 440, 300, 440, 300, 440, 300, 440, 705, 910, 705, 910, 705, 910, 705, 910, 705, 910 };   /* @0x8011f5d8 */
Draw_SubdivStruct gDiv;   /* @0x8011f628  (bss(zero)) */
int          animation_timer[12];   /* @0x8011f718  (bss(zero)) */
ChunkObjectInfo gChunkObjInfo;   /* @0x8011f748  (bss(zero)) */
CCOORD16     gVertex3d[160];   /* @0x8011f760  (bss(zero)) */
int          stackSpeedUpEnbabledFlag;   /* @0x8013d81c  (bss(zero)) */
signed char  goffsets[8] = { 125, 125, 50, 15, -1, 125, 0, 0 };   /* @0x8013d820 -- MATCH: oracle `lb` (signed byte) at the goffsets[] lookup site; -1 must sign-extend, not zero-extend */
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
/* w45-a6 RECEIPT -- residual 2 (count-exact 57/57).  The ONLY diff is the position
 * of `lbu v0,269(a2)` (sd->night_LightningType): the oracle issues it BEFORE the
 * lui/addiu %hi/%lo split of Night_gWeatherLightingTable, we issue it between the
 * two halves.  Both fill the same load-delay slot; it is a sched luid tie.
 * FALSIFIED this wave: (a) giving the type read its own statement through the SYM's
 * outer-scope `index` local -- gcc copy-props it back, output byte-identical;
 * (b) index-term-FIRST pointer arithmetic -- 2 -> 22 (and the extra deref scales
 * *idx by 256, a wrong shape).
 * SLD CONSTRAINT: every insn of this statement attributes to DRAWW.CPP line 761
 * (SYM 3dd55b..3dd561), so a fix must stay on ONE source line.
 * NEW NAMED ANGLE: the table is declared SIZED (`extern u_char (*T[2])[256]`), which
 * is exactly what produces the schedulable lui/addiu split.  Per the w44 storage-
 * shape menu, the UNSIZED asm-label view yields the UNSCHEDULABLE `la` macro form
 * = position-pinned, which is what would force the lbu to issue first.  Try a
 * per-SITE view `extern u_char (*Night_gWLT_v[])[256] asm("Night_gWeatherLightingTable");`
 * here only (night.cpp already owns both spellings of this symbol).
 * UPDATE (w45-a6, same session): that view WAS tried -- `extern u_char (*Night_gWLT_v[])[256]
 * asm("Night_gWeatherLightingTable")` leaves the diff byte-identical (still 2), so the
 * lbu-vs-lui order is NOT an address-materialization question either.  Remaining
 * angle: a pure sched1/sched2 ready-list tie -- read it off cc1 -dS/-dR for this fn
 * (both loads are ready at the same cycle and the tie is broken by luid). */
void Night_NightCalc(VECTOR *v,short *idx,Draw_tGiveShelbyMoreCache *sd);
/* w45-a6 RECEIPT -- DrawQuad 100 -> 20 (count-exact 592/592).
 * LANDED: the addPrim P_TAG-bitfield idiom at BOTH OT-link sites (see below).
 * RESIDUAL 20 = the SAME default-then-override-vs-if/else trade the w44-a7 block
 * below documents, RE-MEASURED at the new (post-P_TAG) baseline:
 *     default-then-override (this file) : gate  20
 *     retail's if/else shape            : gate 204   <- still loses sd's $s0
 * ALLOCNO RECEIPT at the new baseline (tools/rtl_dump.py -dg -dl + tools/prio.py,
 * if/else form):  prim p141 = 24 refs / 114 live -> floor_log2(24)*24/114 = 0.8421
 *                 sd   p 80 = 62 refs / 846 live -> floor_log2(62)*62/846 = 0.3664
 * prim is the FIRST call-crossing allocno so find_reg hands it $s0 (gcc-2.8.1
 * global.c, read this wave: pass 0 can NEVER allocate a register for the first
 * time because `used |= ~regs_used_so_far`, and pass 1 walks hard regs in NUMERIC
 * order since MIPS defines no REG_ALLOC_ORDER).  REQUIRED DELTA, solved exactly:
 *     sd must reach   >= 120 refs (floor_log2(r)*r > 714.1 at live 846), or
 *     prim must drop  <=  13 refs at live 114, or live > 263 at 24 refs.
 * MECHANISM PROVEN THIS WAVE (measured, NOT landed -- it is scaffolding): wrapping
 * the vertex-setup block in N nested do{}while(0) weights its in-body refs by N+1
 * (3 levels -> sd 62 -> 83 refs, prio.py agrees to 4 decimals).  At 9 levels sd
 * reaches 125 refs (0.884 > 0.8421) and THE FLIP HAPPENS: if/else 282 -> 133 with
 * sd in $s0.  But the LOOP_BEG/END barriers rotate the vertex block's caller-saved
 * regs (+1 insn, structural residual 52 -> 147), so the net is worse than 20.
 * NEW NAMED ANGLE (the honest version of the same delta): retail's sd ref count
 * must be ~2x ours, i.e. the original body reads `sd->...` where this recon caches
 * sd-derived values in locals.  Un-cache them one at a time (geomVertices,
 * currentQuadMat, depthcue, save_pre_otz, the tVn* backface reads), re-reading
 * prio.py after each -- a reload that cse folds is +1 ref at ZERO insn cost, and
 * only ~58 are needed.  Alternative direction: shed 11 of prim's 24 refs by routing
 * the four `*(long*)&prim->xN` and the four colour-word stores through ONE
 * `long *px = (long *)((char *)prim + 8);` base (each group is worth -3 refs). */
/* w45-a6 ADDENDUM (a10 gcc-lane intel, consumed): a10's allocator simulator solved
 * this fn on the OLD 100-diff baseline as a 4-cycle rotation of four BLOCK-LOCAL
 * qtys -- p317 (packet-cursor read), p318 (the literal 0x1F800004), p329 (the
 * 0x00FFFFFF mask) and p322 (the 0xFF000000 mask) -- with the required delta being
 * +1 reference on EACH mask (refs 3 -> 4 crosses the floor_log2 edge).  The P_TAG
 * bitfield conversion landed above IS that delta (a bitfield store generates the
 * value mask before the dest mask and changes both masks' ref counts): 100 -> 20,
 * and the mask registers no longer appear in the diff at all.
 * MEASURED after landing: all FOUR P_TAG dial combinations -- {bitfield-read,
 * plain-word-read} x {bump BETWEEN, bump BEFORE} -- gate identically at 20, i.e.
 * the mask rotation is fully resolved and the remaining 20 is the prim/sd $s0/$s1
 * trade + the dvxy store scheduling only. */

void DrawW_DrawQuad(Draw_tGiveShelbyMoreCache *sd,Trk_Quad *inQuad);
void DrawW_kCtrlWorld_High(Draw_tGiveShelbyMoreCache *sd);
void DrawW_StripDraw_High(Draw_tGiveShelbyMoreCache *sd);
void DrawW_DoTrough(DRender_tView *Vi,tBuildEntry *buildList);
void DrawW_WorldSetUpMatrix(matrixtdef *m,MATRIX *mat);
void DrawW_WorldSetUpTranslation(coorddef *t,MATRIX *mat);
void DrawW_ResetAnimationTimer(void);
/* w45-a6 RECEIPT -- residual 4 (ours 31 / oracle 33, ours SHORTER).
 * Oracle `lw v0,0(v0); nop; addu v1,v0,zero` = THREE pseudos (address, value,
 * result); we have two (the value pseudo IS the result pseudo, so the load lands
 * straight in $v1 and `mflo` fills its delay slot).
 * FALSIFIED this wave (all byte-identical to the base -- gcc coalesces every time):
 *   (a) `int tick = animation_timer[..]; iVar2 = tick;`   (copy-propagated away);
 *   (b) the same PLUS a second use of `tick` in the compare (still coalesced);
 *   (c) the UNSIZED asm-label view of animation_timer (storage-shape menu #2) --
 *       no change, so the load's DEST choice is not an addressing-shape question.
 * Earlier waves falsified: compute-order swap, ternary-return, cached-address
 * `int *pTick`, direct-dual-return, and the SetScreen (long long)+re-read recipe.
 * NEW NAMED ANGLE: per w44, a reg-reg copy only survives when the copied value comes
 * from a DISTINCT 1-insn computation, or when the two pseudos genuinely CONFLICT.
 * Untried dial: make the RESULT pseudo live BEFORE the load (default-then-override --
 * give the result variable a value on a path that reaches the load, e.g. hoist the
 * maxTick clamp so the result is live-in at the load).  Then value and result
 * conflict and local_alloc's combine_regs cannot merge their qtys. */
int DrawW_GetAnimationTime(Trk_AnimateInst *animInst);
void DrawW_SetAnimationTime(Trk_AnimateInst *animInst,int *table,int time);
void DrawW_DoObjectAnimations(void);
int DrawW_BuildObjectFacets(DRender_tView *Vi,ChunkObjectInfo *gObjInfo);
int DrawW_BuildCustomObjectFacets(DRender_tView *Vi,Draw_DCache *sd,Trk_SimObject *simObjs,Group *group,int zClipSq);
int DrawObjectSimple(DRender_tView *Vi,Draw_DCache *sd,Trk_ObjectDef *objDef,coorddef *pCp,int offset);
/* w45-a6 RECEIPT -- 212 diffs, count-EXACT 434/434, posdiff alpha-renamed first-use
 * order IDENTICAL: this is a pure whole-function callee-saved ROTATION (ours s3/fp
 * where the oracle has s4/s7), NOT structure.  Quantified with tools/rtl_dump.py
 * -dg -dl + tools/prio.py (allocno_compare = floor_log2(refs)*refs/live_length):
 *     rank 3  p88  79 refs / 375 live = 1.2640   -> ours $s3, oracle wants $s4
 *     rank 4  p234 12 refs /  29 live = 1.2414   -> ours $s4, oracle wants $s3
 * 1.8% apart -- a razor.  EXACT REQUIRED DELTA (any ONE suffices):
 *     p88  refs 79 -> 77   (6*77/375 = 1.2320 < 1.2414), or
 *     p88  live 375 -> 382 (6*79/382 = 1.2408 < 1.2414), or
 *     p234 live  29 ->  28 (3*12/28  = 1.2857 > 1.2640).
 * p88 is the 79-ref dominant walker (objInstance); p234 is a 12-ref/29-insn
 * block-local inside the loop.  NEW NAMED ANGLE: shed exactly TWO objInstance
 * references -- cheapest pair is the `objInstance->type` re-read after
 * ObjectClipped() plus one `&objInstance->x` address take, both routable through
 * the already-live `type` local / one cached address WITHOUT changing the emitted
 * stream (cse folds them).  Re-run prio.py after each single edit and stop the
 * moment p88 crosses below 1.2414. */
int DrawW_BuildChunkObjectFacets(DRender_tView *Vi,ChunkObjectInfo *gObjInfo);
void * ObjectClipped(DRender_tView *Vi,int ind,coorddef *pCp,Draw_tGiveShelbyMoreCache *sd);
void DrawW_DoObjects(DRender_tView *Vi,tBuildEntry *buildList);
int Draw_CircleClip(coorddef *pt1,coorddef *pt2,int r);
void Draw_kCtrlSkidmark(Draw_tCtrlSkidmark *fskid);
void DrawW_SetUpSubdividFacet_Line(Draw_tGiveShelbyMoreCache *sd);
/* w45-a6 RECEIPT -- 101 diffs (ours 506 / oracle 507).  posdiff shows a FOUR-WAY
 * callee-saved rotation, not a swap: ours {fp,s5,s7,s6,s3} vs oracle {s3,s6,fp,s5,s7},
 * alpha-renamed structural residual 247, so structure diverges too.
 * Its OT-link is already the EA DMPSX fixed-$t4-$t7 `__asm__` template (NOT a
 * hand-masked word RMW), so the P_TAG lever that cracked DrawQuad and SubdividFacet
 * this wave does not apply here.  NEW NAMED ANGLE: the w42 rule "an EA-template
 * verdict must be re-checked vs SYM fn-scope locals + a PASSing sibling"
 * (DivideShadowPrim 60 -> PASS) applies -- re-derive this fn's SYM 8c block first and
 * check whether the template's clobber list is evicting a parameter (a clobber that
 * grabs a callee-saved reg is a documented cause of exactly this whole-fn rotation),
 * then re-run posdiff before touching any coloring. */
void DrawW_OnyxLinePrim(CCOORD16 *geomVertices,Trk_Line *lineQuad,int count,Draw_tGiveShelbyMoreCache *sd);
void DrawW_BuildChunkCenterLineFacets(Chunk *chunkDat,Group *group,Draw_tGiveShelbyMoreCache *sd,COORD16 *trans);
void DrawW_DoLines(DRender_tView *Vi,tBuildEntry *buildList,Draw_DCache *sd);
/* w45-a6 RECEIPT -- 76 diffs, count-EXACT 268/268, posdiff first-use order
 * IDENTICAL.  THREE independent clusters, all scheduling/coloring:
 *  (1) the fx/fy/fz `lb;sra 1` trio: the oracle INTERLEAVES load-with-process
 *      (lb s4,15; lb s3,16; sra s4; sh s4; lb s2,17; sra s3; sh s3; ...) and hands
 *      out s4/s3/s2 in REVERSE birth order; we batch all three loads first and hand
 *      out s2/s3/s4 in forward birth order.  This is the w44 REVERSE-BIRTH-ORDER law
 *      for local_alloc.  NEW NAMED ANGLE: split the shared `{int t0,t1,t2;}` block
 *      into three SIBLING `{ int t; ... }` blocks so each axis is a fresh block-local
 *      qty, then read the -dl birth order (free) before touching anything else.
 *  (2) an $a2 <-> $a3 rotation on the two 8-iteration copy-loop offset counters
 *      (li 72/80 and li 144/152) -- the same two-constant live-length identity unit
 *      as the w42 two-mask rotation; the dial is which counter is BORN first.
 *  (3) a t3/t4 swap on the two quad-row base pointers (lw 408(sp) / lw 456(sp)).
 * Not attacked this wave (budget went to the P_TAG sweep + the DrawObject twins);
 * every cluster is small and independent. */
/* w45-a6 ADDENDUM (a10 gcc-lane intel): the "REVERSE-BIRTH-ORDER law" cited in
 * cluster (1) above is the gcc-2.7 local_alloc rule and is FALSE for this 2.8
 * toolchain -- local-alloc.c:1727 QTY_CMP_PRI is the SAME
 * floor_log2(refs)*refs*size/life priority as allocno_compare.  So the fx/fy/fz
 * trio is a REF/LIVE dial, not a birth-order one, and the 76 -> 70 win landed here
 * (emitting fz, fy, fx) works because it changes the three qtys' LIVE LENGTHS, not
 * because it reverses births.  Clusters (2) and (3) are therefore also ref-step
 * targets: dump with tools/rtl_dump.py -dg -dl and drive
 * tools/reqdelta.py --want "<pseudo>=<reg>,..." for the minimal delta. */

void DrawW_BuildSpikeBelt(DRender_tView *Vi,int scale,Draw_DCache *sd);
void DepthCue_Init(void);


/* ---- DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:235-282] SLD-VERIFIED ---- */
/* PsyQ libgpu P_TAG head word (addr:24 | len:8) -- the SDK addPrim()/getaddr()
   house idiom the retail OT-link code was written with (w45-a6). */
typedef struct { unsigned addr : 24, len : 8; } DrawW_PTag;

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
/* w45-a6 RECEIPT -- 115 -> 35 this wave via the addPrim P_TAG-bitfield idiom at the
 * four doublelayer OT-link sites; posdiff first-use order is now IDENTICAL to the
 * oracle and the structural residual is 18 (ours 587 / oracle 588, 1 SHORT).
 * RESIDUAL 35 = TWO clusters, both BLOCK-LOCAL qty picks:
 *  (a) the child-index pivot chain: oracle keeps n+1 in $a3 (and mutates it in
 *      place, `addiu a3,a3,3`), we keep it in $v1 -- identical instruction stream,
 *      different register.
 *  (b) the GT4 OT-link prim: oracle loads it into $s3 (callee-saved) and then
 *      copies `addu a0,s3,zero` for the AddSubdividPrimGT4 call; we load straight
 *      into $a0 (that copy is our 1-insn shortfall).
 * a10 (w45 gcc lane) explicitly RE-OPENED this class: local-alloc.c:1727 QTY_CMP_PRI
 * is the SAME floor_log2(refs)*refs*size/life priority as allocno_compare, so the
 * w44 ref-step dial APPLIES to these block-local qtys (the old "local qty = birth/
 * life only" reading was the gcc-2.7 rule).  NEW NAMED ANGLE: dump -dg/-dl, find the
 * two qtys in the .lreg "in block N" section, and drive tools/reqdelta.py for the
 * minimal +1-ref / -1-live delta; for (b) the natural zero-insn inflator is one more
 * reference to `prim` (e.g. reading back a field of the just-linked prim) which also
 * lengthens its range across the call and forces the callee-saved home + the copy. */
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
        ((DrawW_PTag *)prim)->addr = ((DrawW_PTag *)pal)->addr;
        Render_gPacketPtr = (u_char *)prim + 0x28;
        ((DrawW_PTag *)pal)->addr = (u_long)prim;
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
        ((DrawW_PTag *)prim)->addr = ((DrawW_PTag *)pal)->addr;
        Render_gPacketPtr = (u_char *)prim + 0x28;
        ((DrawW_PTag *)pal)->addr = (u_long)prim;
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
        ((DrawW_PTag *)prim)->addr = ((DrawW_PTag *)pal)->addr;
        Render_gPacketPtr = (u_char *)prim + 0x28;
        ((DrawW_PTag *)pal)->addr = (u_long)prim;
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
        ((DrawW_PTag *)prim)->addr = ((DrawW_PTag *)pal)->addr;
        Render_gPacketPtr = (u_char *)prim + 0x28;
        ((DrawW_PTag *)pal)->addr = (u_long)prim;
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

/* OPEN RESIDUAL (2026-08-01, w39-a2): after the rule-8 SYM rewrite (643->404) the
   dominant remaining diff is ONE allocation decision -- `sd` lands in $s1 and `prim`
   in $s0, the oracle has them the other way round (SYM: sd REGPARM $0x10 = $s0,
   prim REG $0x11 = $s1); 182 of the 404 diff lines are just that swap, the rest is
   its caller-saved fallout.  MEASURED with cc1plpsx `-dg`/`-dl` on the preprocessed
   TU: our allocno order is `... 145(prim) ... 80(sd) ...`, i.e. prim is ranked ~6
   places ABOVE sd and takes $s0 first; RTL ref counts are sd=97 / prim=28 over
   spans ~797 / ~192 insns.  Two razor edges are adjacent here (floor_log2 steps at
   16/32 for prim, 64/128 for sd), and reducing prim's ASM refs 35->31 by fusing the
   x/y stores into words did NOT flip it -- so the deciding term is live_length, not
   ref count.  NEXT IDEAS (untried): lengthen prim's live range without adding an
   instruction (catalog SS.A "live-range-lengthening read"), or find the remaining
   4-insn excess (596 vs 592) that inflates sd's span.  Do NOT grind the caller-saved
   permutations before this flips -- they are downstream of it.
   ---- DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad  [DRAWW.CPP:930-1297] SLD-VERIFIED ---- */
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
  int dU;
  short vert2_proj_x;
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
  int tu24;
  int dV;
  int ti5;
  u_int uVar3_00;
  short sVar1;
  short ts27;
  int iVar2;
  u_int uVar3;
  int depth_index;
  int primPtr;
  int depth_avg;
  short ts31;
  int uVar7_00;
  int ti18;
  Track_tMaterial *currentQuadMat;
  int vert_y_pack;
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
  int save_pre_otz;
  char flag;
  int doSubdivision;
  int face;
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
  long c;   /* SYM AUTO -0x28 -- vertex-3 colour for the dpct trio (was a stray u_int) */
  long color;
  int tu5;
  int tp6;
  u_char *tp20;
  u_char *p;
  int tu1;
  u_int tu2;
  u_int tu18;
  
  /* MATCH (2026-08-01, rule-8 SYM rewrite of the whole vertex-setup section):
   * the SYM 8c block @0x800C64F8 names EVERY local here -- outer block:
   * `geomVertices` (REG $9, PTR CCOORD16); inner block (line 1..106):
   * t1/t2/t3 (INT $10/$2/$11), z (PTR INT $2 -- shares $v0 with t2),
   * tx/ty/tz (SHORT $6/$5/$4) and a/c/d (UCHAR $3/$8/$7 = quad bytes 2/4/5).
   * The previous iVarN-soup form invented 13 temps for those 11 names and lost
   * three structural properties the oracle shows:
   *  (a) tx/ty/tz are SHORT locals whose sum lands in an INT local, so the
   *      oracle canonically sign-extends each `lhu` (sll;sra) -- the old
   *      "(short)word + shortlocal -> short field" form is pure truncation and
   *      gcc drops the extensions;
   *  (b) the second source word is stored as a FULL WORD into &vt.z (one `sw`
   *      sets z AND light) and only then the low half is overwritten with
   *      z+tz -- identity-then-tweak, vs the old separate sra+sh for .light;
   *  (c) the three sums MUTATE t1/t3/t2 in place before the field stores. */
  /* MATCH (w40-a2) -- THE $s0/$s1 FLIP, 404 -> 230 at ZERO instruction cost.
   * `prim` defaults to the in-cache GT4 slot here and is OVERRIDDEN in the
   * doSubdivision==0 arm below (the arm that allocates a packet + OT-links it).
   * WHY IT MATTERS: with the init living only in the `else` arm, cc1's global.c
   * ranked prim ABOVE sd and gave it $s0, where the oracle (SYM: sd REGPARM
   * $0x10=$s0, prim REG $0x11=$s1) has them the other way round -- 182 of the 404
   * diff lines were that one swap plus its caller-saved fallout.
   * RTL RECEIPT (cc1plpsx -dg/-dl on the preprocessed TU, scratch/rtl):
   *     prim = pseudo 145: 24 refs / 114 insns -> priority 4*24/114 = 0.842 (rank 9)
   *     sd   = pseudo  80: 62 refs / 850 insns -> priority 5*62/850 = 0.365 (rank 15)
   *   allocno_compare = floor_log2(refs)*refs/live_length, so prim only loses $s0
   *   once its live_length exceeds ~263 insns; defining it at the top of the body
   *   stretches the range over the whole function and drops it below sd.
   * The `addiu $s1,$s0,0x110` that the oracle issues in the else-arm's `j` delay
   * slot therefore moves into our prologue -- one instruction placed differently,
   * paid for by 174 diff lines. Semantically identical (default-then-override). */
  prim = &sd->GT4Prim;
  {
    int t1;
    int t2;
    int t3;
    int * z;
    short tx;
    short ty;
    short tz;
    u_char a;
    u_char c;
    u_char d;

    t2 = *(u_char *)((char *)inQuad + 3);
    geomVertices = sd->vertices;
    tx = (sd->trans).x;
    ty = (sd->trans).y;
    a = *(u_char *)((char *)inQuad + 2);
    c = *(u_char *)((char *)inQuad + 4);
    d = *(u_char *)((char *)inQuad + 5);
    tz = (sd->trans).z;

    z = (int *)(geomVertices + t2);
    t1 = z[0];
    t2 = z[1];
    t3 = t1 >> 0x10;
    *(long *)&vt0.z = t2;
    t1 = t1 + tx;
    t3 = t3 + ty;
    t2 = t2 + tz;
    vt0.x = t1;
    vt0.y = t3;
    vt0.z = t2;
    gte_ldv0((int *)(&vt0));
    z = (int *)(geomVertices + a);
    gte_rtps_b();
    t1 = z[0];
    t2 = z[1];
    t3 = t1 >> 0x10;
    *(long *)&vt1.z = t2;
    t1 = t1 + tx;
    t3 = t3 + ty;
    t2 = t2 + tz;
    vt1.x = t1;
    vt1.y = t3;
    vt1.z = t2;
    gte_stlvnl(((char *)sd + 0x98));
    gte_swc2(0xe,&dvxy0);
    gte_ldv0((int *)(&vt1));
    z = (int *)(geomVertices + d);
    gte_rtps_b();
    t1 = z[0];
    t2 = z[1];
    t3 = t1 >> 0x10;
    *(long *)&vt2.z = t2;
    t1 = t1 + tx;
    t3 = t3 + ty;
    t2 = t2 + tz;
    vt2.x = t1;
    vt2.y = t3;
    vt2.z = t2;
    gte_stlvnl(((char *)sd + 0xa8));
    gte_ldv0((int *)(&vt2));
    z = (int *)(geomVertices + c);
    gte_rtps_b();
    t1 = z[0];
    t2 = z[1];
    t3 = t1 >> 0x10;
    *(long *)&vt3.z = t2;
    t1 = t1 + tx;
    t3 = t3 + ty;
    t2 = t2 + tz;
    vt3.x = t1;
    vt3.y = t3;
    vt3.z = t2;
    gte_stlvnl(((char *)sd + 0xb8));
    gte_ldv0((int *)(&vt3));
  }
  gte_rtps();
gte_stlvnl(((char *)sd + 0xc8));
  if (((((((sd->tVn3).vx <= (sd->tVn3).vz) || ((sd->tVn0).vx <= (sd->tVn0).vz)) ||
        ((sd->tVn1).vx <= (sd->tVn1).vz)) || ((sd->tVn2).vx <= (sd->tVn2).vz)) &&
      (((-(sd->tVn3).vx <= (sd->tVn3).vz || (-(sd->tVn0).vx <= (sd->tVn0).vz)) ||
       ((-(sd->tVn1).vx <= (sd->tVn1).vz || (-(sd->tVn2).vx <= (sd->tVn2).vz)))))) &&
     (((-1 < (sd->tVn0).vz || (-1 < (sd->tVn1).vz)) ||
      ((-1 < (sd->tVn2).vz || (-1 < (sd->tVn3).vz)))))) {
    gte_avsz4_b();
    currentQuadMat = sd->materials + *((short *)inQuad);
    flag = currentQuadMat->flag;
gte_swc2(0x7,((char *)sd + 0x94));
    face = flag >> 3 & 2;
gte_stsxy3(&dvxy1,&dvxy3,&dvxy2);
    /* MATCH (2026-08-01): SYM names this `doSubdivision`, REG $21 = $s5, type INT
     * -- NOT the u_char it used to be (a u_char forced `andi rN,s5,255` before each
     * of its three tests; the oracle branches straight off `slti $s5,$v0,0xC8`). */
    doSubdivision = sd->otz < 200;
    if ((face == 0) && (doSubdivision == 0)) {
      gte_nclip_b();
gte_swc2(0x18,&bfct);
      iVar2 = 1;
      if ((sd->head).mirror == 1) {
        bfct = -bfct;
      }
      if (bfct < 0) {
        /* CORRECTNESS (oracle @0x800C6858: `lw t7,0x40(sp); lw t8,0x44(sp); lw t9,0x4C(sp);
         * mtc2 t7,$12; mtc2 t9,$14; mtc2 t8,$13; nclip`): the SECOND (other-triangle)
         * winding test must RELOAD SXY0-2 from dvxy0/dvxy1/dvxy2 and re-run nclip.  The
         * previous body only re-read the flag register, so the second test always saw the
         * first triangle's result -- every quad that failed test 1 was dropped. */
        gte_ldsxy3(dvxy0,dvxy1,dvxy2);
        gte_nclip();
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
    workPmx = (Draw_tPixMap *)(primPtr + currentQuadMat->pmxIndex * 0x10);
    if ((((flag & 8) != 0) && (sd->fogstate != '\0')) && ((int)sd->startfog <= sd->otz)) {
      workPmx = (Draw_tPixMap *)(primPtr +
        ((int)currentQuadMat->pmxIndex + (u_int)*(u_char *)&currentQuadMat->mipmap_offset) * 0x10);
    }
    /* MATCH (2026-08-01, re-opened -- the w7-era note that the if/else "regressed"
     * was measured on top of the old iVarN vertex block and is now stale).  SYM names
     * `save_pre_otz` REG $19 = $s3 and the oracle @0x800C6904 really is two-armed:
     *   sra v0,a1,1 ; addu s3,v0,zero ; bne a0,v1,ELSE ; [ds] sw s3,0x94(s0)
     *   sll s3,s3,2 ; sra v0,a1,4 ; j MERGE ; [ds] addu v0,v0,a0
     *   ELSE: addu v0,s3,a0 ; MERGE: sw v0,0x94(s0)
     * -- the `sd->otz = save_pre_otz` store rides the bne delay slot (unconditional),
     * each arm adds sd->offset into $v0 separately, and gcc cross-jump-merges the two
     * `sd->otz =` stores into the shared tail `sw`. */
    depth_avg = sd->otz;
    /* MATCH (w40-a2): STORE-THEN-READ-BACK -- the oracle emits `sra v0,a1,1` and then a
     * redundant `addu s3,v0,zero` copy before the `sw` in the bne delay slot; that copy
     * is cse forwarding the just-STORED field value into a second (named) evaluation.
     * Writing `save_pre_otz = depth_avg>>1; sd->otz = save_pre_otz;` computes straight
     * into $s3 and loses the copy. */
    sd->otz = depth_avg >> 1;
    save_pre_otz = sd->otz;
    if (sd->offset == Draw_gMidGroundOtz) {
      save_pre_otz = save_pre_otz << 2;
      sd->otz = (depth_avg >> 4) + sd->offset;
    }
    else {
      sd->otz = save_pre_otz + sd->offset;
    }
    if ((0 < sd->otz) && (sd->otz <= Draw_gViewOtSize + -3)) {
      if ((flag & 0x80) != 0) {
        /* MATCH (w40-a2): same shape the SECOND (flag&0x80) block below already uses --
         * the oracle loads the scratchpad PALETTE cursor exactly ONCE (`lui t0,0x1F80;
         * lw t0,0(t0)`) and drives both OT-slot computations off that register, while
         * re-reading `sd->otz` for each of them (`lw v0,0x94(s0)` ... `lw a2,0x94(s0)`).
         * Per-use `Render_gPalettePtr` costs a second scratchpad load. */
        u_char *pal;
        aprim = (DR_TWIN *)Render_gPacketPtr;
        pal = Render_gPalettePtr;
        r.w = 0;
        r.h = 0;
        r.x = 0;
        r.y = 0;
        ((DrawW_PTag *)aprim)->addr = ((DrawW_PTag *)(pal + sd->otz * 4))->addr;
        Render_gPacketPtr = (u_char *)aprim + 0xc;
        ((DrawW_PTag *)(pal + sd->otz * 4))->addr = (u_long)aprim;
        SetTexWindow(aprim,&r);
      }
      /* RECEIPT (w44-a7) -- THE ORACLE'S TRUE SHAPE HERE IS AN if/else, AND IT IS
       * MUTUALLY EXCLUSIVE WITH THE $s0/$s1 FLIP ABOVE.  Oracle @0x800C69F0:
       *     beqz  $s5,.L800C6A00        ; doSubdivision == 0 -> the OT-link arm
       *      addiu $v0,$s0,0x94
       *     j     .L800C6A38            ; else-arm ...
       *      addiu $s1,$s0,0x110        ; ... prim = &sd->GT4Prim, in the j slot
       *   .L800C6A00: lw $s1,0x4($s0)   ; prim = cprim.PrimPtr, then the OT-link
       * i.e.  if (doSubdivision != 0) prim = &sd->GT4Prim;
       *       else { prim = cprim.PrimPtr; OT-link; }
       * MEASURED (this wave, both with the nightFlags + cursor-defer fixes in):
       *     if/else form           : gate 282, posdiff structural residual  52
       *     default-then-override  : gate 100, posdiff structural residual 113
       * The if/else kills the last 52 lines of structure but LOSES the register
       * assignment: with the default gone, prim's live range collapses to 114
       * insns and allocno_compare ranks it ABOVE sd, so prim takes $s0 and sd
       * takes $s1 -- the exact inverse of the SYM (sd REGPARM $0x10 = $s0,
       * prim REG $0x11 = $s1) -- and ~230 diff lines of fallout follow.
       * -dg/-dl RECEIPT (tools/rtl_dump.py + tools/prio.py, if/else form):
       *     prim = p141: 24 refs / 114 live -> 4*24/114 = 0.8421  (rank  7)
       *     sd   = p 80: 62 refs / 848 live -> 5*62/848 = 0.3656  (rank 13)
       *   rank 7 is the FIRST call-crossing allocno, so it takes $s0.
       * For sd to win, prim's priority must fall below 0.3656.  Solving
       * floor_log2(r)*r/live < 0.3656 over the reachable (r,live):
       *     live 114 (if/else)  =>  r <= 13   (r = 14 gives 0.368, a razor MISS)
       *     r = 24              =>  live > 263
       * Retail's own $s1 span is 0x800C69FC..0x800C6C48 = 148 insns with 26 refs
       * (4*26/148 = 0.70), i.e. RETAIL'S OWN NUMBERS ALSO RANK prim ABOVE sd ->
       * this is the w41/w43 find_reg cost-pass boundary, third instance.
       * FALSIFIED: re-adding the top-of-function `prim = &sd->GT4Prim;` on top of
       * the if/else is a NO-OP (cse deletes it; output byte-identical, 282).
       * NEW NAMED ANGLE (untried): hold BOTH properties by giving prim a longer
       * live range that is NOT a redundant assignment -- hoist the whole
       * `if (0 < sd->otz && ...)` body one level so prim's def dominates the first
       * flag&0x80 block (+37 insns of live range), then shed 9 of prim's 24 refs
       * (the four `*(long*)&prim->xN` and four `*(u_int*)&prim->uN` stores are the
       * only compressible groups): at r=15 / live=151 the priority is
       * 3*15/151 = 0.298 < 0.3656 and sd wins.  Otherwise: permuter. */

      if (doSubdivision == 0) {
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
      /* MATCH (2026-08-01): the four dvxy AUTOs ARE packed screen-XY words, and the
       * oracle stores each with ONE `sw` (0x8/0x14/0x20/0x2C off prim) -- the 8
       * separate `sh` halves cost 4 extra insns AND, decisively, 4 extra references
       * to `prim`: at 29 body refs the oracle's prim sits just under the
       * floor_log2 razor edge at 32, so it loses $s0 to `sd`; at 33 ours crossed it
       * and stole $s0, flipping the entire function's $s0/$s1 assignment. */
      {
        /* MATCH (w40-a2): the oracle batches the three screen-XY reloads into THREE
         * distinct scratch regs (`lw v1,68(sp); lw a0,76(sp); lw a1,72(sp)` then the
         * three `sw`), so each load fills the previous one's delay slot; the plain
         * four-statement form serialized them through ONE reg and paid 3 `nop`s
         * (catalog par.B "load-3/store-3 grouped temps"). 230 -> 227, 596 -> 593. */
        long q1;
        long q2;
        long q3;
        *(long *)&prim->x0 = dvxy0;
        q1 = dvxy1;
        q2 = dvxy2;
        q3 = dvxy3;
        *(long *)&prim->x1 = q1;
        *(long *)&prim->x2 = q2;
        *(long *)&prim->x3 = q3;
      }
      /* NEGATIVE (w40-a2, retested at TWO baselines, 227 and 139): the oracle's
       * `beqz $v0` makes the DrawW_NightColorCalc call the FALL-THROUGH, so the arms
       * look swapped -- but writing `if (nightFlags != 0) {NightColorCalc} else {...}`
       * REGRESSES hard (227->374, 139->302) and leaves ours 9-12 insns SHORTER than the
       * oracle: with the depth-cue block as the out-of-line arm gcc cross-jump-merges
       * part of its two colour tails.  The polarity is downstream of that merge, not a
       * free arm-order choice -- do not re-try before the merge is killed. */
      if (sd->nightFlags != '\0') {
        DrawW_NightColorCalc(sd,prim,&vt0,&vt1,&vt2,&vt3);
      }
      else {
        gte_ldir0v(depthcue);   /* MATCH+CORRECTNESS: oracle `lw rt,depthcue; mtc2 rt,$8` -- gte_ldIR0() is the ADDRESS form (lwc2), so passing the VALUE read memory at the depth-cue number */
        /* CORRECTNESS + MATCH (2026-08-01, oracle @0x800C6A90/.L800C6B64 read
         * instruction-by-instruction): BOTH arms were wrong.
         *  - the depth-cue RESULTS were being dumped into three invented
         *    sd+0x114/0x120/0x12c slots via raw gte_swc2 numbers instead of into
         *    the prim's colour words / the SYM's `color` AUTO, so every quad drew
         *    with an unwritten colour and the dpcs/dpct output was discarded;
         *  - `uStack_28` was a separate u_int while `gte_ldrgb3(&a,&b,&c)` read the
         *    SYM's `c` (AUTO LONG @-0x28) which nothing ever wrote -> vertex 3's
         *    colour came from uninitialised stack;
         *  - the else arm wrote 16 individual bytes where the oracle re-reads the
         *    strgb'd `color` once and stores FOUR WORDS (`sw v0,4/0x10/0x1C/0x28(s1)`).
         * Oracle (light==-1 arm): ldrgb(&a); dpcs; c/a/b loads; strgb(&prim->r3);
         * ldrgb3(&a,&b,&c); dpct; strgb3(&prim->r0,&prim->r1,&prim->r2). */
        if (sd->light == -1) {
          a = *(long *)(Chunk_lightTable + vt2.light);
gte_ldrgb(&a);
          gte_dpcs();
          /* MATCH (w40-a2): a/b/c are address-taken AUTOs (gte_ldrgb3 needs their
           * addresses), so writing them directly serializes load->store->load->store
           * through ONE scratch and pays a `nop` per pair.  The oracle runs the three
           * light-table chains in PARALLEL (all three `lh` indices, then all three
           * `lw`s, then the three `sw`s) -- reproduce with three register temps
           * (catalog par.A "N named value-temps / parallel chains"). */
          {
            long tc;
            long ta;
            long tb;
            ta = *(long *)(Chunk_lightTable + vt0.light);
            tb = *(long *)(Chunk_lightTable + vt1.light);
            tc = *(long *)(Chunk_lightTable + vt3.light);
            c = tc;
            a = ta;
            b = tb;
          }
gte_strgb(&prim->r3);
gte_ldrgb3(&a,&b,&c);
          gte_dpct();
gte_strgb3(&prim->r0,&prim->r1,&prim->r2);
        }
        else {
          color = *(long *)(Chunk_lightTable + sd->light);
gte_ldrgb(&color);
          gte_dpcs();
gte_strgb(&color);
          *(long *)&prim->r0 = color;
          *(long *)&prim->r1 = color;
          *(long *)&prim->r2 = color;
          *(long *)&prim->r3 = color;
        }
      }
      *(u_char *)((int)&prim->tag + 3) = 0xc;
      prim->code = *(u_char *)&workPmx->flag | 0x3c;
      /* MATCH (2026-07-11): u0/v0/clut (and the u1/v1/tpage, u2/v2/pad2,
       * u3/v3/pad3 siblings) are 4 CONTIGUOUS bytes in POLY_GT4 (nfs4_types.h
       * +0xC: u_char u0,v0; u_short clut) -- a plain word copy at the
       * oracle's access width, not 3 manual sub-field byte/half stores per
       * group (field-fusion lever, same family as DrawW_SetUpSubdividFacet
       * _Line's *(u_short*)&v->u fusion). */
      tu2 = *(u_int *)&workPmx->u0;
      tu18 = *(u_int *)&workPmx->u1;
      uVar3 = *(u_int *)&workPmx->u2;
      uVar7_00 = *(int *)&workPmx->u3;
      *(u_int *)&prim->u0 = tu2;
      *(u_int *)&prim->u1 = tu18;
      *(u_int *)&prim->u2 = uVar3;
      *(u_int *)&prim->u3 = uVar7_00;
      if (prim->clut == 0xffff) {
        ti18 = (save_pre_otz - sd->startfog) * 0x10 >> ((int)sd->distfog);
        if (ti18 < 0) {
          ti18 = 0;
        }
        else if (0xf < ti18) {
          ti18 = 0xf;
        }
        prim->clut = gClutDepth[workPmx->pad2][ti18];
      }
      if (doSubdivision != 0) {
        zeroTransFlag = sd->zeroGTETransFlag;
gte_SetRotMatrix(((char *)sd + 0x74));
        if (zeroTransFlag == 0) {
gte_SetTransMatrix(((char *)sd + 0x74));
        }
        /* MATCH: oracle `beqz flag -> else` = the SPEEDUP arm is the fall-through, and it
         * stores gWSavePtr BEFORE clearing the flag (`sw v0,%gp_rel(gWSavePtr); sw zero,
         * %gp_rel(stackSpeedUpEnbabledFlag)`). */
        if (stackSpeedUpEnbabledFlag != 0) {
          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 0;
          DrawW_SetUpSubdividFacet(face,sd);
          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 1;
        }
        else {
          DrawW_SetUpSubdividFacet(face,sd);
        }
gte_SetRotMatrix(((char *)sd + 0x14));
        if (zeroTransFlag == 0) {
gte_SetTransMatrix(((char *)sd + 0x14));
        }
      }
      if ((flag & 0x80) != 0) {
        /* MATCH: the oracle reads the two scratchpad cursors INSIDE the guard (single
         * use site); hoisting them above the `andi 0x80` test costs 5 unconditional
         * insns the oracle never pays. */
        iVar2 = (u_int)workPmx->u3 - (u_int)workPmx->u0;
        if (iVar2 < 0) {
          iVar2 = -iVar2;
        }
        ti5 = (u_int)workPmx->v3 - (u_int)workPmx->v0;
        if (ti5 < 0) {
          ti5 = -ti5;
        }
        r.w = (short)iVar2 + 1;
        r.h = (short)ti5 + 1;
        r.x = 0;
        r.y = 0;
        p = Render_gPacketPtr;
        tp20 = Render_gPalettePtr;
        /* MATCH: the oracle reads each scratchpad cursor ONCE (`lw a0,0(t2)` /
         * `lw t0,0(t0)`) and drives the whole OT-link off those two registers -- the
         * per-use `Render_gPacketPtr` / `Render_gPalettePtr` re-reads cost 5 extra
         * scratchpad loads. */
        ((DrawW_PTag *)p)->addr = ((DrawW_PTag *)(tp20 + sd->otz * 4))->addr;
        Render_gPacketPtr = p + 0xc;
        ((DrawW_PTag *)(tp20 + sd->otz * 4))->addr = (u_long)p;
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
  MATRIX *mB;                      /* &sd->matB, the shared trans-matrix base */
  /* RE-GATE (w44-a7): 125 diffs, ours 358 / oracle 359 (worklist said 179).
     TRIAGE (tools/posdiff.py): alpha-renamed LCS 261/359, structural residual 98,
     and the first-use order differs ONLY in where `s4`(=buildList) and `fp`(=the
     constant 0) sit -- ours  s3 a0 s4 a1 s6 fp s5 s7 s0 ...
                       oracle s3 a0 fp s6 s5 s7 s4 a1 s0 ...
     i.e. the prologue emits the saved-reg initializers in allocation-priority
     order and our `buildList` copy outranks the `0` constant where the oracle has
     it the other way round.  The remaining mass is a set of one-insn transpositions
     of the same shape all through the body (`lw v1,168(a0)` / `lw v1,160(a0)` /
     `lw v1,8(s3)`... each landing one slot early or late), i.e. sched1 ready-list
     ties downstream of that head order.
     NEW NAMED ANGLE (untried this wave, needs a dedicated pass): the briefing's
     giv-worth razor -- run tools/rtl_dump.py -dL on this TU and read the
     `giv of insn N not worth while, W vs insn_count` line for the trough loop;
     W is constant, so the dial is the loop's RTL insn count and it is usually a
     1-insn razor.  Pair it with the negOne/giv history already recorded below. */

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
  /* MATCH (wave-14, 157->127): CONSTANTS-IN-REGS lever. The oracle prologue
     materializes -1/1 ONCE (`addiu $s6,$zero,-1` / `addiu $s7,$zero,1`) and
     reuses those TWO callee-saved regs at every one of the 5/4 sd->light /
     sd->zeroGTETransFlag stores across the whole function (spanning many
     intervening jal calls) -- a literal `-1`/`1` repeated at each site (the
     prior form) does NOT get GCSE'd into a persistent pseudo across this
     many basic blocks/calls; it re-materializes fresh via `li` at every site
     and starves buildInd of its oracle register (fp), landing it on s7
     instead. Naming the constants as real fn-scope locals gives gcc a
     value with a full-function live range that DOES win a callee-saved reg,
     which also frees buildInd to land on `fp` (SYM REG 0x1e) as the oracle
     has it. Residual 127: the ONE remaining prologue floor is buildList
     (a1->s4)'s SAVE POSITION -- oracle schedules it LAST (after fp/s6/s5/s7)
     via allocno-priority ordering; a liveness-fence (`__asm__("":: "r"
     (buildList))`) tried to nudge it and REGRESSED (127->137, reverted) --
     genuine scheduling floor, not source-reachable. Remaining diffs beyond
     the prologue are instruction-SCHEDULING interleaving of independent
     load/store chains (vertexBuf ptr, chunkInd*12 ptr, nightFlags/materials/
     light stores) that gcc's scheduler reorders across statement boundaries
     -- a §A row-38 "N named value-temps" class floor, untried further this
     session. */
  /* MATCH (w45-a5, 118 -> 114): BIRTH ORDER.  The oracle's prologue interleaves
     the saves with the initializing copies in allocation order --
       s3=Vi, fp=buildInd(0), s6=negOne(-1), s5=&tmp, s7=gteFlag(1),
       s4=buildList, s0=sd(0x1F800000)
     -- so buildInd/negOne/gteFlag are BORN BEFORE sd and chunkCount.  With the
     old `int negOne = -1; int gteFlag = 1;` declaration-initializers sitting
     ahead of `buildInd = 0`, ours emitted the buildList parm copy first and
     rotated the whole prologue.  Assigning them as statements in the oracle's
     birth order fixes it.  Measured: this form 114 · assign after the sd block
     142 · assign around the doublelayer store 142 · decl-initializers 118. */
  int negOne;
  int gteFlag;

  buildInd = 0;
  negOne = -1;
  gteFlag = 1;
  sd = (Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr;
  chunkCount = BWorld_gChunkCount;
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
      /* MATCH (w45-a5, 114 -> 100): the oracle reads sd->chunkInd for the
         chunk-centre index (`lbu $a0,0xE4($s0)` then the x12 sll/addu/sll
         chain) BEFORE it loads the Track_materials global
         (`lui $v1; lw $v1,0($v1)`), and only then stores it to sd->materials.
         With the materials store written first, our chunkInd byte load lands
         after the global load and the whole v0/v1/a0 web rotates.  All three
         orderings that put pChunkCp ahead of the materials store measure 100. */
      pChunkCp = Chunk_chunkCenters + sd->chunkInd;
      sd->materials = Track_materials;
      sd->light = negOne;
      if (gNight_renderNight != 0) {
        int cx;
        int cz;
        int dist;
        /* MATCH (w41-a2): the oracle materializes this 4 into a REGISTER
         * (`addiu $v0,$zero,0x4; sb $v0,0x106($s0)`) and then REUSES that register
         * as the shift COUNT for the Camera_gInfo element scale -- `sllv $v0,$a1,$v0`
         * instead of a plain `sll $v0,$a1,4` (cse substitutes an equivalent register
         * for a constant it already has in hand; sizeof(Camera_tCamSlot) == 0x110 ==
         * ((x<<4)+x)<<4).  A bare literal store is folded into the `sb` immediate and
         * never leaves a register behind, so ours emits the constant shift.  Same
         * named-constant device as `negOne` above. */
        int four = 4;

        sd->nightFlags = (char)four;
        /* MATCH (w45-a5, 94 -> 92): same subtrahend-first operand-load-order class as
           the sd->trans block above -- the oracle issues `lw $v1,168($a0)` (the
           camera-target position component) BEFORE `lw $v0,8($s2)` (the chunk
           centre).  Only the .z site is load-bearing (splitting .x alone measures
           94, splitting .z alone or both measures 92); written uniformly. */
        { int px = ((Camera_gInfo[Vi->player].target)->position).x;
          cx = (pChunkCp->x - px) >> 10; }
        { int pz = ((Camera_gInfo[Vi->player].target)->position).z;
          cz = (pChunkCp->z - pz) >> 10; }
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
          /* MATCH (w45-a5, 92 -> 88): third site of the subtrahend-first class (both
             axes load-bearing here: z-only measures 90, both 88). */
          { int px = (BW_gCopCarObj->N).position.x;
            cx2 = (pChunkCp->x - px) >> 10; }
          { int pz = (BW_gCopCarObj->N).position.z;
            cz2 = (pChunkCp->z - pz) >> 10; }
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
      /* MATCH (w45-a5, 100 -> 94): OPERAND LOAD ORDER.  The oracle loads the
         SUBTRAHEND first (`lw $v1,8($s3)` = Vi->cview.translation.N) and only
         then the minuend (`lw $v0,0($s2)` = pChunkCp->N).  A single
         `a->N - b->N` expression evaluates left-to-right, so ours loaded them
         the other way round at all three axes.  Same device as DrawW_DoLines'
         per-axis split below.  (One shared temp measures the same 94.) */
      { int vx = (Vi->cview).translation.x;
        sd->trans.x = (short)((pChunkCp->x - vx) >> 10); }
      { int vy = (Vi->cview).translation.y;
        sd->trans.y = (short)((pChunkCp->y - vy) >> 10); }
      { int vz = (Vi->cview).translation.z;
        sd->trans.z = (short)((pChunkCp->z - vz) >> 10); }
      /* MATCH (w45-a5, 125 -> 118, count 358 -> EXACT 359): the oracle computes
         `addiu $v0,$s0,0x14` = &sd->matB ONCE and reaches t[2]/t[1] through it
         (`sw $zero,0x1C($v0)` / `0x18($v0)`) while t[0] keeps the sd base
         (`sw $zero,0x28($s0)`); the SAME $v0 then feeds the gte_SetTransMatrix
         expansion (`lw $t4,0x14($v0)` ...).  Writing all three stores as
         `(sd->matB).t[k]` gives sd-relative displacements 48/44/40 and a
         separate address for the call; a named MATRIX* for the two high
         offsets + the call reproduces the shared base.  Measured: this form
         118 · all three through mB 120 · none (sd for all) 125. */
      mB = &sd->matB;
      mB->t[2] = 0;
      mB->t[1] = 0;
      (sd->matB).t[0] = 0;
      gte_SetTransMatrix(mB);
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
          sd->zeroGTETransFlag = gteFlag;
          sd->light = negOne;
          DrawW_kCtrlWorld_High(sd);
        }
        sd->quadCount = chunkDat->quadCounts[1];
        if (sd->quadCount != 0) {
          sd->quads = chunkDat->renderQuads[1];
DrawWTrough_setStateCallHigh:
          sd->offset = 0x1e;
          sd->zeroGTETransFlag = gteFlag;
          sd->light = negOne;
          DrawW_kCtrlWorld_High(sd);
        }
      }
      sd->vertices = (CCOORD16 *)(chunkDat->objVertexBuf + 1);
      sd->quadCount = chunkDat->quadCounts[2];
      if (sd->quadCount != 0) {
        sd->offset = 0x7d;
        sd->zeroGTETransFlag = gteFlag;
        sd->light = negOne;
        sd->quads = chunkDat->objQuadBuf + 1;
        DrawW_kCtrlWorld_High(sd);
      }
      sd->quadCount = chunkDat->quadCounts[3];
      if (sd->quadCount != 0) {
        sd->offset = 0x32;
        sd->zeroGTETransFlag = gteFlag;
        sd->light = negOne;
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
  /* rule-8 SYM rewrite (w44-a7): SYM 8c block @0x800C78A8 names EVERY local and
     fixes both the register map and the AUTO SLOT ORDER:
       Vi REGPARM $0x17=$s7 · gObjInfo REGPARM $5=$a1
       sd $0x1e=$fp · objInstance $0x10=$s0 · objDef $0x11=$s1 · totalCount $0x15=$s5
       group $2=$v0 · groupNumElements AUTO -0x40 · offset AUTO -0x3c
       doFrustumClip AUTO -0x38 · zClipSq $0x16=$s6 · visList AUTO -0x34
       objectIndex $0x14=$s4 (blk16) · objectOffset $0x12=$s2 + matrix AUTO -0x88 (blk25)
       cp AUTO -0x60 (blk95) · pt2 AUTO -0x50 (blk114);  fsize 168.
     The DECLARATION ORDER of the four scalar AUTOs IS the frame layout (reload
     slots the pseudos in the order the decls are reached, w41): the old order
     (groupNumElements, visList, offset, doFrustumClip) put gObjInfo->offset at
     112(sp) and visList at 108(sp) where the oracle has 108/116. */
  Draw_DCache *sd;                 /* $fp   -- the 0x1F800000 scratchpad cache */
  Trk_AnimateInst *objInstance;    /* $s0   -- SYM type Trk_SimpleInst* */
  Trk_ObjectDef *objDef;           /* $s1 */
  int totalCount;                  /* $s5 */
  int groupNumElements;            /* AUTO -0x40 -> 104(sp) */
  int offset;                      /* AUTO -0x3c -> 108(sp) */
  int doFrustumClip;               /* AUTO -0x38 -> 112(sp) */
  int zClipSq;                     /* $s6 */
  short *visList;                  /* AUTO -0x34 -> 116(sp) */
  int objectIndex;                 /* $s4 (SYM block line 16) */
  int objectOffset;                /* $s2 (SYM block line 25) */
  matrixtdef matrix;               /* AUTO -0x88 -> 32(sp) */
  coorddef cp;                     /* AUTO -0x60 -> 72(sp) */
  coorddef pt2;                    /* AUTO -0x50 -> 88(sp) */
  int animType;
  void *clipRes;
  int distSq;

  
  /* NEGATIVE (w41-a2, both halves measured, both REVERTED).  SYM declares `sd`
   * (Draw_DCache*, REG $0x1e == $fp) in the FUNCTION-scope block and the oracle
   * materializes it in the prologue (`lui $fp,0x1F80`) BEFORE the zero-count
   * `beqz $v0`, reaching the GTE translation vector as `sw $zero,0x28($fp)`
   * (== sd->matB.t[]) while STILL building a separate `lui/ori 0x1F800014` for the
   * gte_SetTransMatrix argument.  Reproducing either half makes it WORSE:
   *   hoist sd to fn scope                : 147 -> 153 (192 -> 194 insns)
   *   matB zeroing through sd (sd in-arm) : 147 -> 158 (192 -> 195 insns)
   *   both together                       : 147 -> 153
   * Root cause is an allocno-priority inversion, not the statement position: with
   * the longer live range `sd`'s priority falls below `Vi`'s, `Vi` takes $fp (the
   * oracle's `sd` home) and `sd` gets no callee-saved reg at all -- so it is
   * rematerialized per use and the whole file rotates.  The lever that would land
   * this is one that RAISES sd's ref count or SHORTENS Vi's range, not the
   * declaration move; do not re-try the move on its own. */
  /* RECEIPT (w45-a5) -- ROOT CAUSE ISOLATED AND THE w41 DIAGNOSIS CORRECTED.
     Re-gated baseline 130 (ours 193 / oracle 189 = +4 EXACTLY).
     `sd` IS NOT AN ALLOCNO AT ALL -- it never reaches the register allocator.
     -dg (tools/rtl_dump.py -> scratch/rtl/draww.i.greg) prints
        ;; 20 regs to allocate: 93 123 92 83 130 81 84 85 141 91 89 80 82 183 ...
        ;; Register dispositions: 80 in 30  81 in 5  83 in 17 ...
     -- 80 is `Vi` and it takes $30/$fp; there is NO pseudo anywhere in that
     table holding 0x1F800000.  `sd = (Draw_DCache *)&Render_gPalettePtr;` is a
     CONST_INT initializer (Render_gPalettePtr is the 3.6b fixed-address macro),
     so cse propagates 0x1F800000 into every use and the pseudo disappears
     BEFORE local-alloc.  Consequence, visible 1:1 in tools/ourdis.py:
       ours   5x `lui $r,0x1f80` (one per call-arg site) + `lui $at,0x1f80;
              sw $zero,40($at)`   <- the ASSEMBLER $at macro, 2 insns
       oracle 1x `lui $fp,0x1F80` + 3x `addu $aN,$fp,$zero` + `sw $fp,0x14($sp)`
              + `sw $zero,0x28($fp)`                      <- 1 insn
     = the whole +4.  So this is NOT the w41 "allocno-priority inversion"
     (that verdict was formed without a -dg dump); Vi legitimately owns $fp
     because nothing else is competing for it.  Getting sd allocated would also
     hand Vi its SYM home $s7 and unwind the whole 9-value rotation
     (ours s1/s3/s4/s5/s6/s7/fp vs oracle s0..s7/fp).
     FALSIFIED THIS WAVE (all re-gated, all reverted):
       USE-fence `__asm__ volatile("" : : "r"(sd))` after the init  138 (+2 insns)
       same fence inside the else arm                               142
       sd assigned inside the else arm only                         138
       sd assigned before groupNumElements                          130 (no-op)
       two static sets of the same constant / `sd = sd;`            130 (no-op --
         jump-opt collapses them, so REG_N_SETS stays 1)
       set in BOTH guard arms                                       137
       all three matB.t[] stores routed through sd                  143
       gte_SetTransMatrix(&sd->matB) instead of the 0x1F800014 literal 130
       t[0] store moved ahead of t[2]/t[1]                          130
     MECHANISM READ OUT OF THE GCC SOURCE (C:\Temp\gcc-2.8.1-src\extracted\
     local-alloc.c, update_equiv_regs): the LOCAL-ALLOC substitution is gated on
     `REG_N_REFS(regno) == 2 && REG_BASIC_BLOCK(regno) < 0`, which sd (6 refs)
     does NOT satisfy -- so local-alloc is innocent and the propagation is
     cse.c's, upstream.  Note the same routine does `REG_LIVE_LENGTH *= 2` for
     ANY pseudo carrying a REG_EQUIV note, i.e. a constant-initialized pointer is
     priority-HALVED even when it does survive: any lever here must either kill
     the REG_EQUIV or beat a 2x live-length penalty.
     NEW NAMED ANGLE (untried, in order):
       1. Make the initializer NON-CONSTANT-P so cse cannot propagate and no
          REG_EQUIV note is attached.  The honest candidate is the storage-shape
          menu (catalog w44 -> six forms): give the scratchpad cache a SIZED
          asm-label VIEW (`extern Draw_DCache sd_v[1] asm("...")`-style) or the
          volatile-MEM form which w44 proved "defeats TARGET_SPLIT_ADDRESSES";
          here we want the OPPOSITE polarity (register base instead of the $at
          macro), so probe both the sized and unsized views on the 0x1F800000
          base and read which one stops the fold.
       2. Ask the a10 instrument lane for the cse.c constant-propagation gate
          (which predicate lets `(mem (const_int 0x1F800028))` validate on MIPS;
          if it is rejected, gcc must force a base register and we win for free).
       3. Required delta for the simulator: we need ONE extra call-crossing
          allocno holding 0x1F800000 whose priority lands LAST (it must take
          $fp, i.e. rank 9 of 9), pushing Vi from $fp up to $s7.  Everything
          else in the table is already the oracle's set. */
  totalCount = 0;
  objInstance = (Trk_AnimateInst *)(gObjInfo->objInstanceBuf + 1);
  groupNumElements = gObjInfo->objInstanceBuf->m_num_elements;
  sd = (Draw_DCache *)&Render_gPalettePtr;
  if (groupNumElements == 0) {
    totalCount = 0;
  }
  else {
    offset = gObjInfo->offset;
    doFrustumClip = gObjInfo->doFrustumClip;
    zClipSq = gObjInfo->zClipSq;
    visList = gObjInfo->visList;
    /* SYM: block-scoped REG local `sd` (Draw_DCache*, $fp) -- the scratchpad cache
       cursor cast ONCE here, not re-cast at every call site (used below at every
       ObjectClipped/DrawObjectSimple/DrawObjectTransform/Flare_Halo2 call). The
       world matrix itself is a SEPARATE scratchpad literal (0x1F800014, matches
       sd->matB's own address -- Draw_DCache.matB @+0x14) forced into its own
       register by the gte_SetTransMatrix() call argument. */
    ((MATRIX *)0x1f800014)->t[2] = 0;
    ((MATRIX *)0x1f800014)->t[1] = 0;
    (sd->matB).t[0] = 0;
gte_SetTransMatrix((void *)0x1f800014);
    for (objectIndex = 0; objectIndex < groupNumElements; objectIndex = objectIndex + 1) {
      if ((visList == (short *)0x0) || ((((u_short)visList[objectIndex] >> 0xc ^ 1) & 1) == 0)) {
        objectOffset = offset;
        if (offset == 0) {
          objectOffset = (int)goffsets[objInstance->zoffset];
        }
        animType = objInstance->type;
        /* SYM block-scoping (line70/71 vs 95/107/114, all converging on the shared
           loop-tail at line124/132) + the oracle's flat forward-beq compare chain
           (==1 / <2-skip / ==3 / ==7 / skip) with BOTH case bodies pushed OUT OF LINE
           after the chain -- neither a plain if/else-if (inlines case1) nor a switch
           (gcc picks a range-check lowering for {1,3,7}) reproduces this; an explicit
           goto dispatch matches the oracle's actual block layout 1:1. */
        if (animType == 1) goto animCase1;
        if (animType < 2) goto animNext;
        if ((animType == 3) || (animType == 7)) goto animCase37;
        goto animNext;
      animCase1:
        objDef = Track_gObjDefs[objInstance->pad];
        if (((doFrustumClip == 0) ||
            (clipRes = ObjectClipped(Vi,(int)objInstance->pad,(coorddef *)&objInstance->count,
                                 (Draw_tGiveShelbyMoreCache *)sd),
            clipRes == (void *)0x0)) &&
           ((zClipSq == -1 ||
            (distSq = xzsquaredist32((coorddef *)&objInstance->count,&(Vi->cview).translation),
            distSq < zClipSq)))) {
          objectOffset = DrawObjectSimple(Vi,sd,objDef,
                             (coorddef *)&objInstance->count,objectOffset);
          totalCount = totalCount + objectOffset;
        }
        goto animNext;
      animCase37:
        Anim_GetRotPos(objInstance,1,DrawW_GetAnimationTime(objInstance),&cp,&matrix);
        if ((zClipSq == -1) ||
           (distSq = xzsquaredist32(&cp,&(Vi->cview).translation),
           distSq < zClipSq)) {
          objectOffset = DrawObjectTransform(Vi,sd,&matrix,
                             Track_gObjDefs[objInstance->pad],&cp,objectOffset,-1);
          totalCount = totalCount + objectOffset;
          if ((objInstance->flags & 2) != 0) {
            pt2.x = cp.x + matrix.m[6] * -0x10;
            pt2.y = cp.y + matrix.m[7] * -0x10;
            pt2.z = cp.z + matrix.m[8] * -0x10;
            Flare_Halo2(Vi,-1,0x1e,&cp,&pt2,(Draw_FlareCache *)sd);
          }
        }
      animNext:;
      }
      objInstance = (Trk_AnimateInst *)((int)&objInstance->size + (int)objInstance->size);
    }
  }
  return totalCount;
}

/* ---- DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi  [DRAWW.CPP:2054-2151] SLD-VERIFIED ---- */
int DrawW_BuildCustomObjectFacets(DRender_tView *Vi,Draw_DCache *sd,Trk_SimObject *simObjs,Group *group,int zClipSq)

{
  /* RE-GATE (w44-a7): 120 diffs, ours 192 / oracle 200 -- we are EIGHT INSNS
     SHORT (worklist said 84).  TRIAGE (tools/posdiff.py): alpha-renamed LCS
     121/200, structural residual 79, and the first-use order is oracle-identical
     except for one adjacent swap (ours ... a0 a2 a1 v0 t4 ...  vs oracle
     ... a0 a1 a2 v0 t0 t4 ...).  Per the catalog's posdiff rule a single adjacent
     swap at an 8-insn deficit is NOT coloring: `ours SHORTER` + intact call
     skeleton = collapsed inline math or a missing arm.
     NEW NAMED ANGLE (untried): run tools/brcensus.py first (jal deficit = dropped
     call, conditional-branch deficit = missing arm, beqz<->bnez at equal totals =
     polarity) before touching any register; the w10 note in this file already
     flags the quaternion copy as a genuine UNALIGNED lwl/lwr stream, so the
     8-insn hole is most likely a second movstrsi-shaped copy still written as
     scalar math, or the wave-9 `Pack8` cast applied at only one of two sites.
     CENSUS RUN (tools/brcensus.py, w44-a7):  beqz 4v3  bnez 2v3  j 2v3
     -- equal conditional totals with a beqz<->bnez SWAP (one arm's polarity is
     inverted) plus a `j` DEFICIT (we tail-merged a block the oracle keeps as a
     separate jump).  Located at the head guard; the oracle prologue is
         addiu $sp,$sp,-0x80
         sw $s4,0x68($sp); addiu $s4,$a3,0x4
         ... sw $a0,0x80($sp); sw $a1,0x84($sp); sw $a2,0x88($sp)
         sw $zero,0x50($sp)
         lw $a3,0x0($a3); nop
         bnez $a3,.L800C7BF4
          sw $a3,0x54($sp)
     THREE separate facts fall out, and together they are the 8-insn deficit:
       (a) Vi ($a0), sd ($a1) and simObjs ($a2) are SYM class ARG -- retail spills
           all three to their incoming stack homes in the prologue and RELOADS
           them at each use (`lw $a1,132(sp)` / `lw $a1,128(sp)` appear at the
           DrawObjectTransform sites in the oracle).  We keep `sd` in $s5
           (`addu $a1,$s5,$zero` / `addu $a2,$s5,$zero`), which is exactly why the
           oracle has loads we lack.  Same ARG-spill class as Draw_kCtrlSkidmark's
           `sw $a0,0x58($sp)`.
       (b) totalCount is a stack AUTO at 0x50($sp) (`sw $zero,0x50($sp)`) and
           groupNumElements at 0x54($sp); our decl order puts the count at
           0x50($sp) instead, so every AUTO displacement is off by one slot --
           the w41 decl-position-IS-frame-layout rule, the same fix that landed
           on DrawW_BuildObjectFacets this wave.
       (c) the zero-count guard is `bnez` with the groupNumElements store riding
           its delay slot, i.e. the SOURCE arm order is
              if (groupNumElements != 0) { ...loop... } else { totalCount = 0; }
           and not our `if (== 0) {...} else {...}`.
     NEW NAMED ANGLE: do the full rule-8 SYM rewrite here exactly as
     DrawW_BuildObjectFacets got this wave -- pull the SYM 8c block, delete the
     ~20 fabricated iVarN/loc_NN locals, order the scalar AUTOs into the SYM's
     declaration sequence, and let the three ARG params stay memory-resident
     (reference the parameter directly at each use instead of caching it in a
     local -- catalog w22: "different register CLASS, not a different sN"). */
  /* RECEIPT (w45-a5) -- PARKED at 120 (ours 192 / oracle 200, EIGHT SHORT).
     PROLOGUE DIFFED BYTE-FOR-BYTE (tools/ourdis.py vs the oracle .s) and the two
     are IDENTICAL for 14 instructions -- same frame (-0x80), same `addiu $s4,
     $a3,4`, same nine callee-saved saves at the same offsets, same `sw $a0,
     0x80($sp)` -- with EXACTLY ONE divergence:
         oracle  sw $a0,0x80($sp);  sw $a1,0x84($sp);  sw $a2,0x88($sp)
         ours    sw a0,128(sp);     <MISSING>;         sw a2,136(sp)
     i.e. the ONLY prologue difference in the whole function is that retail
     ALSO spills `sd` ($a1) to its incoming ARG home and we do not.  That is the
     w44/w40 ARG-SPILL class, and it confirms the w44 reading exactly.
     Note both builds save the SAME nine callee-saved registers, so the pool is
     not merely "one short": retail has an EXTRA call-crossing pseudo that
     outranks sd and pushes sd out to memory, and the ~8 missing instructions are
     that pseudo's work plus retail's `lw $a1,0x84($sp)` reloads.
     FALSIFIED THIS WAVE (re-gated, reverted): guard-polarity rewrites -- the
     `bnez`-into-the-loop shape the census asks for is NOT independently
     reachable: `if (n != 0) goto work; return 0; work:` gates 120 (no change)
     and `if (n != 0) { body }` gates 121 at 191 insns.  The polarity really is
     downstream of the spill, as the w44 note suspected.
     NEW NAMED ANGLE: this is the w40 ARG-SPILL-FORCING recipe, not a polarity or
     decl-order job.  A param spills only when the callee-saved pool is FULL AT
     ITS PRIORITY RANK, so (1) find the retail pseudo we are missing -- start
     from the 8-insn deficit and the SYM 8c block's REG entries, since a SYM REG
     local we never materialized is both the missing work AND the missing
     allocno; (2) failing that, raise a rival's rank across the calls with the
     zero-insn ref-step family (a semantic no-op re-mask, or making an existing
     flag/count assignment CALL-CROSSING by moving it above the first jal, which
     is the exact w40 ReadIn 344->186 device).  Gate on the appearance of
     `sw $a1,0x84($sp)` in tools/ourdis.py output, not on the LCS. */

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
  int bVar7;   /* MATCH (w40-a2): a u_char flag makes cc1plus re-mask on every use
                  (`andi v0,s1,255` x3) -- the oracle tests it bare (`bnez s1`), so the
                  original local was int-width (catalog par.C u_char->u_int lever). */
  int tc4;   /* the z-offset -- SYM/oracle keep it sign-extended in a saved reg (`lb`) */
  u_char tc5;

  groupBase_p = (int)(group + 1);
  totalCount = 0;
  iVar6 = group->m_num_elements;
  /* MATCH (2026-08-01): the oracle's guard is `bnez` INTO the loop with the empty
   * group as the FALL-THROUGH `j <epilogue>; [ds] addu $v0,$zero,$zero` -- the
   * non-empty case is the branch TARGET, not the else arm. */
  /* MATCH (w41-a2, partial): the oracle's guard is an EARLY RETURN --
   * `lw $a3,0($a3); bnez $a3,.L800C7BF4; [ds] sw $a3,0x54($sp); j <epilogue>;
   * [ds] addu $v0,$zero,$zero` -- so the empty-group case falls through into a
   * `return 0` that shares the epilogue.  Writing it as `if (count == 0) return 0;`
   * aligns that `addu $v0,$zero,$zero` delay slot (121 -> 120) but does NOT flip
   * the branch itself: the arm census is still beqz 4v3 / bnez 2v3 / j 2v3.
   * REASON (head diff): the oracle SPILLS all three of Vi/sd/simObjs to their ARG
   * homes (`sw $a0,0x80($sp); sw $a1,0x84($sp); sw $a2,0x88($sp)`) and RELOADS sd
   * (`lw $t0,0x84($sp); addiu $v0,$t0,0x14`) for the matB zeroing, while ours keeps
   * sd live in $s5 -- the same ARG-SPILL-pressure gap as Draw_kCtrlSkidmark.  The
   * polarity is downstream of that, not an independent arm-order choice. */
  if (iVar6 == 0) {
    return 0;
  }
  {
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
          if (bVar7 == 0) {
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
            iVar3 = DrawObjectTransform(Vi,sd,&matrix,objDef_00,(coorddef *)(groupBase_p + 8),tc4,
                               -1);
            objMat_p = totalCount + iVar3;
            totalCount = objMat_p;
          }
        }
        else {
          pOVar5 = Object_GetAnim(simObjs + *(u_char *)(groupBase_p + 0x22));
          (*(*pOVar5->_vf)[2].pfn)
                    ((int)&pOVar5->_vf + (int)(*pOVar5->_vf)[2].delta,Vi,sd,tc4);
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
  int isCullable;  /* MATCH: int not u_char -- u_char local emitted bogus andi 255 */
  Track_tMaterial *shapeDef_p;
  int drawResult;

  sd[1].head.cprim.PrimPtr = (char *)(objDef + 1);
  *(u_char *)((int)&sd[1].head.cprim.MPrimPtr + 3) = objDef->quadCount;
  isCullable = objDef->vertexCount;
  shapeDef_p = Track_materials;
  *(u_char *)((int)sd[1].matB.t + 2) = 0;
  drawResult = gNight_renderNight;
  *(int *)&sd[1].head.clipW = offset;
  sd[1].head.mirror = (int)(objDef + ((u_int)isCullable * 2 + 1));
  *(Track_tMaterial **)sd[1].matB.m[0] = shapeDef_p;
  if (drawResult != 0) {
    *(u_char *)((int)sd[1].matB.t + 2) = 4;
    if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
      *(u_char *)((int)sd[1].matB.t + 2) = 5;
    }
    { int posX = ((Camera_gInfo[Vi->player].target)->position).x; tmp.x = pCp->x - posX; }
    { int posY = ((Camera_gInfo[Vi->player].target)->position).y; tmp.y = pCp->y - posY; }
    { int posZ = ((Camera_gInfo[Vi->player].target)->position).z; tmp.z = pCp->z - posZ; }
    transform(&tmp.x,gNightMat.m,&tmp2.x);
    DrawW_WorldSetUpTranslation(&tmp2,&sd->matNight);
    if (BW_gCopCarObj != (Car_tObj *)0x0) {
      *(u_char *)((int)sd[1].matB.t + 2) = *(u_char *)((int)sd[1].matB.t + 2) | 2;
      { int posX = (BW_gCopCarObj->N).position.x; tmp.x = pCp->x - posX; }
      { int posY = (BW_gCopCarObj->N).position.y; tmp.y = pCp->y - posY; }
      { int posZ = (BW_gCopCarObj->N).position.z; tmp.z = pCp->z - posZ; }
      transform(&tmp.x,gCopMat.m,&tmp2.x);
      DrawW_WorldSetUpTranslation(&tmp2,&sd->matCop);
    }
    {
      MATRIX *m = (MATRIX *)&(sd->matB);
      m->t[2] = 0;
      m->t[1] = 0;
      (sd->matB).t[0] = 0;
gte_SetTransMatrix(m);
    }
  }
  { int tX = (Vi->cview).translation.x; tmp.x = pCp->x - tX; }
  { int tY = (Vi->cview).translation.y; tmp.y = pCp->y - tY; }
  { int tZ = (Vi->cview).translation.z; tmp.z = pCp->z - tZ; }
  TrsProj_SetPsxTransZero();
  TrsProj_TransPt(&tmp,&tmp2);
  if (offset == -1) {
    *(int *)&sd[1].head.clipW = Draw_gMidGroundOtz;
    tmp2.x = tmp2.x >> 2;
    tmp2.y = tmp2.y >> 2;
    tmp2.z = tmp2.z >> 2;
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
  ((MATRIX *)mat_local)->t[2] = 0;
  ((MATRIX *)mat_local)->t[1] = 0;
  (sd->matB).t[0] = 0;
gte_SetTransMatrix((MATRIX *)mat_local);
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
  coorddef tmp;
  coorddef tmp2;
  int isCullable;
  Track_tMaterial *shapeDef_p;
  int drawResult;

  /* MATCH: SYM 0x800c8214 shows ONLY tmp/tmp2 (+REG offset) as locals; u_char
     isCullable had emitted a bogus `andi 255` (retyped int), and the mirror
     expression now groups (cnt*2+1) before the base add per the oracle
     `sll;addiu 4;addu`. */
  shapeDef_p = Track_materials;
  sd[1].head.cprim.PrimPtr = (char *)(objDef + 1);
  *(Track_tMaterial **)sd[1].matB.m[0] = shapeDef_p;
  *(u_char *)((int)&sd[1].head.cprim.MPrimPtr + 3) = objDef->quadCount;
  isCullable = objDef->vertexCount;
  *(u_char *)((int)sd[1].matB.t + 2) = 0;
  drawResult = gNight_renderNight;
  *(int *)&sd[1].head.clipW = offset;
  sd[1].head.mirror = (int)(objDef + ((u_int)isCullable * 2 + 1));
  if (drawResult != 0) {
    *(u_char *)((int)sd[1].matB.t + 2) = 4;
    if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
      *(u_char *)((int)sd[1].matB.t + 2) = 5;
    }
    { int posX = ((Camera_gInfo[Vi->player].target)->position).x; tmp.x = (Vi->cview).translation.x - posX; }
    { int posY = ((Camera_gInfo[Vi->player].target)->position).y; tmp.y = (Vi->cview).translation.y - posY; }
    { int posZ = ((Camera_gInfo[Vi->player].target)->position).z; tmp.z = (Vi->cview).translation.z - posZ; }
    transform(&tmp.x,gNightMat.m,&tmp2.x);
    DrawW_WorldSetUpTranslation(&tmp2,&sd->matNight);
    if (BW_gCopCarObj != (Car_tObj *)0x0) {
      *(u_char *)((int)sd[1].matB.t + 2) = *(u_char *)((int)sd[1].matB.t + 2) | 2;
      { int posX = (BW_gCopCarObj->N).position.x; tmp.x = (Vi->cview).translation.x - posX; }
      { int posY = (BW_gCopCarObj->N).position.y; tmp.y = (Vi->cview).translation.y - posY; }
      { int posZ = (BW_gCopCarObj->N).position.z; tmp.z = (Vi->cview).translation.z - posZ; }
      transform(&tmp.x,gCopMat.m,&tmp2.x);
      DrawW_WorldSetUpTranslation(&tmp2,&sd->matCop);
    }
    {
      MATRIX *m = (MATRIX *)&(sd->matB);
      m->t[2] = 0;
      m->t[1] = 0;
      (sd->matB).t[0] = 0;
gte_SetTransMatrix(m);
    }
  }
  if (offset == -1) {
    *(int *)&sd[1].head.clipW = Draw_gMidGroundOtz;
    { int tX = (Vi->cview).translation.x; sd[1].matB.m[0][2] = (short)(pCp->x - tX >> 0xc); }
    { int tY = (Vi->cview).translation.y; sd[1].matB.m[1][0] = (short)(pCp->y - tY >> 0xc); }
    { int tZ = (Vi->cview).translation.z; sd[1].matB.m[1][1] = (short)(pCp->z - tZ >> 0xc); }
  }
  else {
    { int tX = (Vi->cview).translation.x; sd[1].matB.m[0][2] = (short)(pCp->x - tX >> 10); }
    { int tY = (Vi->cview).translation.y; sd[1].matB.m[1][0] = (short)(pCp->y - tY >> 10); }
    { int tZ = (Vi->cview).translation.z; sd[1].matB.m[1][1] = (short)(pCp->z - tZ >> 10); }
  }
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
  /* RECEIPT (w44-a7) -- RE-GATED 212 diffs, COUNT-EXACT 434/434 (the worklist's
     78 is stale in the usual direction).  posdiff's first-use order is IDENTICAL
     to the oracle; the whole residual is ONE saved-register pair swap plus its
     fallout: SYM says objInstance REG $0x14 = $s4 (objDef $s6, totalCount $s7,
     type $s0, light $s1, objectOffset $fp -- all of those we already match), but
     we give objInstance $s3 and push each case block's t1 from $s3/$s5 to $s4/$s5.
     -dl/-dg RECEIPT (tools/rtl_dump.py + tools/prio.py):
       objInstance = p88 : 79 refs / 375 live -> 6*79/375 = 1.2640  (rank 3)
       block-10 t2 = p131: 12 refs /  27 live -> 3*12/ 27 = 1.3333  (rank 2 -> $s2)
       block-10 t1 = p130: 12 refs /  36 live -> 3*12/ 36 = 1.0000  (rank 7)
     Only ONE hard reg ($s2) is consumed before objInstance, so it lands on $s3.
     The SYM proves retail consumed TWO before objInstance took $s4 ($s2 <- the
     b81/b195 t2's, $s3 <- the b81/b195 t1's and the b150/b252 t2's) -- i.e.
     block-10's t1 must outrank objInstance.  Two quantified, reachable dials:
       (a) objInstance refs 79 -> <= 63 crosses the floor_log2 razor 6 -> 5 and
           gives 5*63/375 = 0.84 < t1's 1.00.  That is ~8 fewer SOURCE refs (42
           today; the compressible groups are objInstance->x x7 and ->pad x6).
       (b) objInstance live 375 -> > 474 gives < 1.00 (the loop is 375 of the
           function's 754 RTL insns, so this needs a use outside the loop --
           less faithful, listed for completeness).
     FALSIFIED this wave: moving each `matrix.m[K+6] = fixedmult(matrix.m[K+6],sX);`
     RMW to AFTER the two `matrix.m[K] = t1/t2;` stores (9 sites) -- 212 -> 229 and
     the count collapses 434 -> 423.  The RMW must stay third; the oracle's store
     order (m[0], m[3], m[6], the last riding the next jal's delay slot) is a
     scheduling consequence of the register assignment, not a source order.
     NB the SYM types objInstance `Trk_SimpleInst *` (size 20), not
     Trk_CollideBoomInst -- EA declared the small record and byte-cast the rest. */

  u_char type;   /* SYM REG $s0 */
  ObjectAnim *anim;
  int doFrustumClip;
  Trk_SimObject *simObjs;
  short light;
  Group *instGroup;   /* SYM REG $2 */
  Trk_CollideBoomInst *objInstance;
  Trk_ObjectDef *objDef;
  int totalCount;
  int objectOffset;
  matrixtdef matrix;
  int groupNumElements;
  int objectIndex;

  simObjs = gObjInfo->simObjs;
  instGroup = gObjInfo->objInstanceBuf;
  objInstance = (Trk_CollideBoomInst *)(instGroup + 1);
  groupNumElements = instGroup->m_num_elements;
  doFrustumClip = gObjInfo->doFrustumClip;
  totalCount = 0;
  if (groupNumElements == 0) {
    totalCount = 0;
  }
  else {
    /* CORRECTNESS (2026-08-01, same class as the DoTrough/kCtrlSkidmark finds):
     * the GTE translation vector zeroed here must be the SCRATCHPAD matrix at
     * 0x1F800014 (== sd->matB) that the very next gte_SetTransMatrix loads --
     * the oracle stores through literal 0x1F800014/0x1F800028 addresses.  Writing
     * the separate linked `Render_gWorldMat` .bss symbol left the scratchpad
     * translation STALE, so every chunk object was transformed with whatever the
     * previous draw had left at 0x1F800028..0x30. */
    DW_WORLDMAT.t[2] = 0;
    DW_WORLDMAT.t[1] = 0;
    /* MATCH (w42-a2): t[0] is materialized as its OWN literal scratchpad address,
     * not as a displacement off the base the other two share.  Oracle @0x800C857C:
     *   sw $zero,0x1C($v0)   ; t[2], $v0 = 0x1F800014 (lui+ori)
     *   sw $zero,0x18($v0)   ; t[1]
     *   lui $at,0x1F80 ; sw $zero,0x28($at)      <-- the $at assembler macro form
     * The $at expansion only appears for a store whose address gcc emitted as a
     * bare `sw $r,ADDR` macro (catalog: "$at-macro store in the diff => wrong
     * declared shape") -- i.e. this one store was a separate address expression in
     * the source, so gcc never folded it onto the CSE'd base.  0x1F800028 ==
     * &DW_WORLDMAT.t[0] (matrixtdef.t @+0x14 of the matrix @0x1F800014); identical
     * semantics, and it is what makes the insn count EXACT (433 -> 434 == oracle). */
    *(int *)0x1f800028 = 0;
gte_SetTransMatrix(&DW_WORLDMAT);
    for (objectIndex = 0; objectIndex < groupNumElements; objectIndex = objectIndex + 1) {
      objectOffset = (int)goffsets[objInstance->zoffset];
      type = objInstance->type;
      /* MATCH: oracle is a CASCADE of separate ifs, not one fused ||/&& expression --
         type==5 short-circuits straight to emit (skipping the clip test entirely), and
         the final type!=2 check is a FRESH re-read of objInstance->type from memory
         (`lbu` after the ObjectClipped() call), not a reuse of the cached type. */
      if ((type & 0x80) != 0) {
        goto DrawWChunkFacets_groupNext;
      }
      if (type != 5) {
        if (doFrustumClip != 0) {
          /* rule-8: the SYM names NO local for either the clip result or the
           * heading -- both were invented temps whose register pressure pushed
           * `totalCount` (SYM REG $s7) out into a stack slot (frame 136 vs 128). */
          if ((ObjectClipped(Vi,(int)objInstance->pad,(coorddef *)&objInstance->x,
                             (Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr) != (void *)0x0)
              && (objInstance->type != 2)) {
            goto DrawWChunkFacets_groupNext;
          }
        }
      }
      /* CORRECTNESS: oracle `sh $v0,(0x1F800148 & 0xFFFF)($at)` -- this is the
       * scratchpad cache's `offsubdivid` SHORT (the same field OnyxLinePrim sets to
       * 0x200), not a private .bss int.  The old write-only DrawW_gObjScratch_148
       * global meant the subdivision offset never reached the renderer. */
      DW_SCRATCH->offsubdivid = 0x400;
      light = -1;
      if ((objInstance->flags & 1) != 0) {
        fixedxformy(&matrix,
                    fixedatan(objInstance->x - (Vi->cview).translation.x,
                              objInstance->z - (Vi->cview).translation.z));
        if (type == 9) {
          /* MATCH: SYM block scope (t1,t2,sx,sy -- no sz for the qz/qy-only shift pair). */
          int t1, t2, sx, sy;

          sx = (int)objInstance->qz << 8;
          sy = (int)objInstance->qy << 8;
          t1 = fixedmult(matrix.m[0],sx);
          t2 = fixedmult(matrix.m[3],sx);
          matrix.m[6] = fixedmult(matrix.m[6],sx);
          matrix.m[0] = t1;
          matrix.m[3] = t2;
          t1 = fixedmult(matrix.m[1],sy);
          t2 = fixedmult(matrix.m[4],sy);
          matrix.m[7] = fixedmult(matrix.m[7],sy);
          matrix.m[1] = t1;
          matrix.m[4] = t2;
          t1 = fixedmult(matrix.m[2],sx);
          t2 = fixedmult(matrix.m[5],sx);
          matrix.m[8] = fixedmult(matrix.m[8],sx);
          light = objInstance->qw;
          DW_SCRATCH->offsubdivid = 0;
          matrix.m[2] = t1;
          matrix.m[5] = t2;
        }
        objDef = Track_gObjDefs[objInstance->pad];
DrawWChunkFacets_emitObj:
        objectOffset = DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef,
                            (coorddef *)&objInstance->x,objectOffset,light);
        totalCount = totalCount + objectOffset;
      }
      else {
        /* MATCH (2026-08-01): the oracle @0x800C8780 dispatches with gcc's
         * balance_case_nodes BST -- `andi v1,s0,0xFF; li v0,2; beq (case 2);
         * slti v0,v1,3; beqz -> {li 5/beq, li 9/beq}; li v0,1; beq (case 1)` --
         * the unmistakable fingerprint of a real `switch` (root compare + bound
         * test + two subtree compares), NOT the if/else-if cascade this used to
         * be (which collapsed to one `sltiu` unsigned range test).  gcc emits
         * case BODIES in SOURCE order and the oracle's physical order is
         * 1 (0x800C87C4), 2 (0x87F8), 9 (0x8900), 5 (0x8A08) -- exactly the SYM
         * block line numbers 121/137/186/235. */
        switch (type) {
        case 1:
          objDef = Track_gObjDefs[objInstance->pad];
          totalCount = totalCount + DrawObjectSimple(Vi,(Draw_DCache *)&Render_gPalettePtr,
                              objDef,(coorddef *)&objInstance->x,objectOffset);
          break;
        case 2: {
          /* MATCH: SYM block scope (t1,t2,sx,sy,sz -- full 3-axis shift). */
          int t1, t2, sx, sy, sz;

          Quatern_QuatToMat((tQuat *)&objInstance->qx,&matrix);
          sx = (int)objInstance->sx << 8;
          sy = (int)objInstance->sy << 8;
          sz = (int)objInstance->sz << 8;
          t1 = fixedmult(matrix.m[0],sx);
          t2 = fixedmult(matrix.m[3],sx);
          matrix.m[6] = fixedmult(matrix.m[6],sx);
          matrix.m[0] = t1;
          matrix.m[3] = t2;
          t1 = fixedmult(matrix.m[1],sy);
          t2 = fixedmult(matrix.m[4],sy);
          matrix.m[7] = fixedmult(matrix.m[7],sy);
          matrix.m[1] = t1;
          matrix.m[4] = t2;
          t1 = fixedmult(matrix.m[2],sz);
          t2 = fixedmult(matrix.m[5],sz);
          matrix.m[8] = fixedmult(matrix.m[8],sz);
          objDef = Track_gObjDefs[objInstance->pad];
          matrix.m[2] = t1;
          matrix.m[5] = t2;
          /* MATCH (w41-a2): this arm passes its light value INLINE -- it must NOT go
           * through the SYM `short light` ($s1) variable.  The oracle proves the split:
           * the flags&1/type==9 arm loads `lhu $s1,0x1A($s4)` and pays a `sll 16;sra 16`
           * sign-extend at its own call site, while case 2 and case 9 emit a bare
           * `lh $v0,0x22/0x1A($s4); j .L800C8B30; sw $v0,0x18($sp)` -- i.e. gcc
           * cross-jumped the two $v0-carried arms DEEPER (sharing the light store) than
           * the $s1-carried one (which stores its own and enters one insn later).  That
           * is the catalog's cross-jump-DEPTH-follows-the-variable rule; assigning
           * `light` in all three arms collapsed them to one depth AND turned both `lh`
           * sites into `lhu` (census lh 19v21 / lhu 3v1). */
          objectOffset = DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef,
                              (coorddef *)&objInstance->x,objectOffset,
                              *(short *)&objInstance->simIndex);
          totalCount = totalCount + objectOffset;
          break;
        }
        case 9: {
        /* MATCH: SYM block scope (t1,t2,sx,sy -- no sz for the qz/qy-only shift pair). */
        int t1, t2, sx, sy;

        xformy(&matrix,(int)objInstance->qx);
        sx = (int)objInstance->qz << 8;
        sy = (int)objInstance->qy << 8;
        t1 = fixedmult(matrix.m[0],sx);
        t2 = fixedmult(matrix.m[3],sx);
        matrix.m[6] = fixedmult(matrix.m[6],sx);
        matrix.m[0] = t1;
        matrix.m[3] = t2;
        t1 = fixedmult(matrix.m[1],sy);
        t2 = fixedmult(matrix.m[4],sy);
        matrix.m[7] = fixedmult(matrix.m[7],sy);
        matrix.m[1] = t1;
        matrix.m[4] = t2;
        t1 = fixedmult(matrix.m[2],sx);
        t2 = fixedmult(matrix.m[5],sx);
        matrix.m[8] = fixedmult(matrix.m[8],sx);
        DW_SCRATCH->offsubdivid = 0;
        objDef = Track_gObjDefs[objInstance->pad];
        matrix.m[2] = t1;
        matrix.m[5] = t2;
        /* MATCH (w41-a2): inline light, see the case-2 note. */
        objectOffset = DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef,
                            (coorddef *)&objInstance->x,objectOffset,objInstance->qw);
        totalCount = totalCount + objectOffset;
        break;
        }
        case 5: {
        objDef = Track_gObjDefs[objInstance->pad];
        anim = Object_GetAnim(simObjs + objInstance->simIndex);
        if (anim == (ObjectAnim *)0x0) {
          /* MATCH: SYM block scope (t1,t2,sx,sy,sz -- full 3-axis shift). */
          int t1, t2, sx, sy, sz;

          Quatern_QuatToMat((tQuat *)&objInstance->qx,&matrix);
          sx = (int)objInstance->sx << 8;
          sy = (int)objInstance->sy << 8;
          sz = (int)objInstance->sz << 8;
          t1 = fixedmult(matrix.m[0],sx);
          t2 = fixedmult(matrix.m[3],sx);
          matrix.m[6] = fixedmult(matrix.m[6],sx);
          matrix.m[0] = t1;
          matrix.m[3] = t2;
          t1 = fixedmult(matrix.m[1],sy);
          t2 = fixedmult(matrix.m[4],sy);
          matrix.m[7] = fixedmult(matrix.m[7],sy);
          matrix.m[1] = t1;
          matrix.m[4] = t2;
          t1 = fixedmult(matrix.m[2],sz);
          t2 = fixedmult(matrix.m[5],sz);
          matrix.m[8] = fixedmult(matrix.m[8],sz);
          matrix.m[2] = t1;
          matrix.m[5] = t2;
          /* MATCH (w42-a2): case 5 passes its light INLINE as the literal -1 --
           * exactly the same cross-jump-DEPTH rule the case-2/case-9 notes above
           * document, and the reason `light` (SYM REG $s1) must NOT be live here.
           * Oracle: this arm ends `addiu $v0,$zero,-0x1; sw $fp,0x14($sp)` and
           * FALLS INTO the shared tail at .L800C8B30 (`sw $v0,0x18($sp)`; the
           * 7th arg's stack home), while the flags&1 arm sign-extends its own
           * $s1 and enters one insn later at .L800C8B34.  Routing this arm
           * through the `light` variable extended $s1's live range across the
           * whole switch, where the oracle REUSES $s1 as each arm's `sy`
           * (`lh $s1,0x1E($s4); sll $s1,$s1,8`) -- so `light` got spilled to a
           * HImode stack slot, costing the phantom 8 frame bytes (136 vs SYM
           * fsize 128) and rotating totalCount off $s7 onto $fp. */
          objectOffset = DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef,
                              (coorddef *)&objInstance->x,objectOffset,-1);
          totalCount = totalCount + objectOffset;
          break;
          }
          anim = Object_GetAnim(simObjs + objInstance->simIndex);
          (*(*anim->_vf)[2].pfn)
                    ((int)&anim->_vf + (int)(*anim->_vf)[2].delta,Vi,0x1f800000,objectOffset);
          break;
        }
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
  gVi = Vi;
  sd = (Draw_DCache *)&Render_gPalettePtr;
  chunkCount = BWorld_gChunkCount;
  thisChunkInd = gCurrContext->currentChunk;
  *(Track_tArtresource **)((char *)sd + 0xfc) = &gInitialArt;
  {
  int buildInd;
  buildInd = 0;
  while (1) {
    if (chunkCount <= buildInd) break;
    if (((u_int)buildList[buildInd].enableBits & 2U) != 0) {
      Chunk *chunkDat;
      Trk_SimObject *simObjs;
      int chunkInd;
      int geomRez;
      chunkInd = buildList[buildInd].chunkInd;
      chunkDat = Track_chunkList + chunkInd;
      simObjs = (Trk_SimObject *)(chunkDat->simObjBuf + 1);
      geomRez = (int)*(signed char *)&buildList[buildInd].geomRez;
      /* MATCH (w40-a2): TWO cooperating fixes, must land together.
         (1) `(signed char)` cast -> the oracle's `lb $a1,0x2($s2)` (`char` is UNSIGNED on
             this build, so the plain field read emitted `lbu`; the previous
             `*(volatile signed char*)` form kept the giv down but cost `lbu+sll+sra`).
         (2) INDEX FORM for every buildList access (`buildList[buildInd].f`, pointer no
             longer walked) -- catalog "giv-anchor Cure B": with the pointer-walk form
             loop.c built a SECOND address giv anchored at `buildList+2` for this one
             byte read (`addiu s4,s2,2` in the prologue + a per-iteration bump), which
             cost 2 insns AND an extra callee-saved allocno that shifted every saved-reg
             role. Index form reduces onto the single +0 walker the oracle uses.
         Also dropped the `volatile` on the enableBits test (scaffolding that is a no-op
         under the index form). 59 -> 45 diffs, insns 225 -> 223 (oracle 222). */
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
    u_int chunkM1 = thisChunkInd - 1U;
    if (((GameSetup_gData.track != 4) ||
        (((0x27 < chunkM1 && (0x1d < thisChunkInd - 0x3dU)) && (8 < thisChunkInd - 0x6cU)))) &&
       ((GameSetup_gData.track != 0 ||
        (((0x34 < chunkM1 && (0x1b < thisChunkInd - 0x44U)) && (0x13 < thisChunkInd - 0x6cU)))))) {
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

/* MATCH (w46-a6, step A): UNSIZED ASM-LABEL VIEW of the depth-CLUT table.  The
   sized `extern short gClutDepth[256][16]` decl gives loop.c a %hi/%lo pseudo
   PAIR it hoists twice (inner loop then outer loop, -dL insns 723/724 -> 795/797
   -> 809/811) so the address arrives in the prologue with a 226-insn live range
   and eats a CALLEE-SAVED register.  The oracle materializes it at the use site
   (`lui $t8,%hi(gClutDepth); addiu $t8,$t8,%lo(gClutDepth)` @0x800C9584) and
   spends that callee-saved slot on `t = &fskid->t` ($s6) instead.  The unsized
   view removes the symbol's pseudo pair entirely -> nothing to hoist (catalog
   w45 §B/F "the unsized asm-label view KILLS a LICM address hoist"). */
extern short gClutDepth_v[] __asm__("gClutDepth");

/* ---- Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark  [DRAWW.CPP:2900-3038] SLD-VERIFIED ---- */
void Draw_kCtrlSkidmark(Draw_tCtrlSkidmark *fskid)

{
  /* RECEIPT (w44-a7) -- THE WALKER REGRESSION IS EXPLAINED: A gClutDepth LICM
     HOIST WAS EATING THE SAVED REGISTER THAT `t` NEEDS.
     Oracle prologue (asm/nonmatchings/main/Draw_kCtrlSkidmark...s):
         addiu $sp,$sp,-0x58
         sw $s4,0x40($sp); addu  $s4,$a0,$zero        ; m    = fskid
         sw $s6,0x48($sp); addiu $s6,$s4,0x24         ; t    = &fskid->t
         sw $fp,0x50($sp); lui/ori $fp,0x1F800094     ; otz94
         sw $s3,0x3C($sp); lui/ori $s3,0x404040       ; grey
         sw $s1,0x34($sp); lui     $s1,0x1F800000     ; sd
         ...             ; sw $a0,0x58($sp)           ; fskid SPILLED to its ARG
         lw $s5,0x30($s4)                             ;   home (SYM class ARG!)
     OURS (before this wave) materialized otz94/grey/sd but NOT m/t, and instead
     burned $fp on `lui %hi(gClutDepth); addiu %lo(gClutDepth)` hoisted all the way
     to the function entry.  -dL proves it is a DOUBLE LICM hoist:
         Insn 723: regno 239 (life 6),   move-insn savings 2  moved to 795
         Insn 724: regno 238 (life 5),   move-insn forces 723 savings 1 moved to 797
         Insn 795: regno 239 (life 226), savings 1 halved since already moved -> 809
         Insn 797: regno 238 (life 226), savings 1 halved since already moved -> 811
     i.e. the %hi/%lo pair is lifted out of the inner loop and then out of the outer
     loop, arriving in the prologue with a 226-insn live range -> a callee-saved
     home.  The oracle keeps it CALLER-saved at the use site
     (`lui $t8,%hi(gClutDepth) ... addiu $t8,$t8,%lo(gClutDepth)` @0x800C9584).
     CURE FOUND + MEASURED: an unsized asm-label VIEW of the table --
         extern short gClutDepth_v[] __asm__("gClutDepth");
         ... = ((short (*)[16])gClutDepth_v)[idx][vert_idx];
     -- removes the hoist entirely.  With that plus `m = (matrixtdef *)fskid;` and
     `t = &fskid->t;` routed through every (fskid->m).m[] / fskid->t use, OUR
     PROLOGUE REPRODUCES THE ORACLE'S COMPLETE MATERIALIZATION SET *AND* THE
     `sw $a0,0x58($sp)` ARG SPILL (verified with tools/ourdis.py):
         sw a0,88(sp); move s5,a0; addiu s7,s5,36; lui/ori s8,0x1F800094;
         lui/ori s6,0x404040; lui s3,0x1f80
     -- exactly the oracle's set, modulo a 5-register rotation
        (ours m=$s5 t=$s7 otz94=$s8 grey=$s6 sd=$s3
         vs   m=$s4 t=$s6 otz94=$fp grey=$s3 sd=$s1).
     NOT ADOPTED: the LCS gate goes 332 -> 366 and the count 361 -> 365 (the m/t
     pair costs 4 insns the oracle pays for elsewhere) while posdiff's structural
     residual is unchanged at ~256.  Reverted per verify-or-revert; the full
     working tree is kept at scratch/skid_walker_view.cpp.
     Isolated control: the gClutDepth view WITHOUT m/t gates 336 (structural 256).
     NEW NAMED ANGLE for the next pass, in this order:
       1. LAND THE VIEW + m/t FIRST (they are provably the oracle's shape) and
          accept the temporary gate rise;
       2. hunt the 12-insn excess (ours 365 vs oracle 353) with tools/brcensus.py
          -- posdiff says the mass here is STRUCTURE, not coloring (alpha-renamed
          LCS is only 94/353);
       3. the 5-register rotation should then fall out, because with gClutDepth off
          the callee-saved pool our set of saved-reg consumers finally equals the
          oracle's.
     Do NOT re-test t/m WITHOUT the gClutDepth view -- that is exactly the w39/w40/
     w41 "adding t regresses 344->415" measurement, and it was measuring the
     missing saved register, not the walkers. */
  /* RECEIPT (w45-a5) -- PARKED at the re-gated baseline 332 (ours 361 / oracle
     353, i.e. EIGHT INSNS OVER).  Three things settled this wave:
     (1) WALKER-PROBE RECOVERY: `scratch/skid_walker_view.cpp` is GONE and is NOT
         recoverable.  scratch/ is gitignored, so it was never an object: the
         w44-a7 merge (main 3565ea25, side commits 1a02c482/c844114f/cef1caeb/
         4d42abbb) touches recon/game/psx/draww.cpp and NOTHING else, and
         `git rev-list --all --objects | grep skid_walker` is empty tree-wide.
         NOTHING WAS LOST -- the full recipe is the w44 receipt above.
     (2) The gClutDepth unsized asm-label VIEW reproduces EXACTLY in this basin:
            extern short gClutDepth_v[] __asm__("gClutDepth");
            ... = ((short (*)[16])gClutDepth_v)[idx][vert_idx];
         gates 336 with the count UNCHANGED at 361 -- bit-for-bit the w44 number,
         so the w44 measurement stands and the +4 is pure LCS churn (the LCS is
         non-monotone on a far-miss; posdiff's structural residual is 256/353
         either way).  It is NOT landed here only because verify-or-revert needs a
         paired win to carry it.
     (3) FRESH TRIAGE (this wave, the piece w44 never ran):
           tools/brcensus.py : beqz 7v8  bnez 9v8   -- equal totals (16 = 16) with
             a beqz<->bnez SWAP = exactly ONE arm's branch polarity inverted.
           tools/rove_op.py  : sra 13v14  sll 10v12  lh 3v2  lhu 4v5  sw 31v32
             lw 76v78  andi 2v1
           tools/posdiff.py  : LCS 97/353, and the first-use orders differ only by
             a small permutation (ours s4 a0 s7 s6 v0 fp s3 s5 ... vs oracle
             s4 a0 s6 fp s3 s1 s7 s5 ...).
         READ: the `sll`/`sra` DEFICIT tracking together (-2 sll, -1 sra) with an
         EXTRA `lh` and a MISSING `lhu` is the w40 "missing SHORT SIGN-EXTENSION
         PAIRS" signature -- retail reads a short field `lhu` and canonicalizes
         `sll 16; sra 16` because the value lands in an INT local, while ours
         declares the local `short` and gets a bare `lh`.  That is a rule-8 TYPE
         question, not coloring, and it is worth 3 insns of the 8-insn excess.
     NEW NAMED ANGLE (ordered, all untried):
       A. Land the gClutDepth VIEW together with the short->int local retyping
          (the rove_op sll/sra/lh/lhu signature above): the view is provably the
          oracle's addressing and the retype is provably the oracle's arithmetic,
          and together they move the COUNT (the only monotone metric here) toward
          353.  Gate on insn count + posdiff, NOT on the LCS.
       B. Then the single inverted arm from brcensus (one beqz that should be a
          bnez) -- find it with tools/chunkdiff.py, which localizes a mismatched
          run in one call.
       C. Only then re-test the m/t walkers (w44 step 1), and if a 5-register
          rotation survives, dial it with the ALLOCNO PRIORITY family rather than
          birth order: per the w45 a10 gcc-source finding, gcc-2.8's local_alloc
          uses `QTY_CMP_PRI` = the SAME floor_log2(refs)*refs*size/life formula as
          allocno_compare (local-alloc.c:1727) -- the "longest-lived-first /
          reverse-birth-order" law in the catalog is the gcc-2.7 rule and is FALSE
          here.  So compute refs/live for the rotating quantities and look for a
          floor_log2 STEP; the zero-insn re-mask (`| (x & 0xffffff)`) and the
          do{}while(0) depth wrapper are the dials even for block-local qtys that
          never reach find_reg. */
  /* ================= RECEIPT (w46-a6) -- PLAN A/B/C EXECUTED, 332 -> 303 ======
     BASELINE re-gated at 6a43ac79: 332 diffs, ours 361 / oracle 353 (EIGHT over).
     NOW: 303 diffs, ours 354 / oracle 353 (ONE over), posdiff residual 234 -> 225,
     brcensus CLEAN, opcode census down to `addiu +2 / lw -1` (everything else --
     sw, nop, andi, lh, lhu, sll, sra, lui, addu -- is now EXACT).

     WHAT LANDED (each gated + full-TU re-gated, 21 PASS held):
       A1. gClutDepth unsized asm-label view (kills the double LICM hoist that ate
           a callee-saved register; alone it is LCS-neutral at 336/361 -- exactly
           the w44/w45 measurement -- and only pays once `t` exists to use the
           freed slot).
       A2. EVERY 0x1F8000xx literal routed through the SYM's `sd` (Draw_DCache*,
           REG $s1): the 4 gte_stlvnl targets (&sd->tVn0..tVn3), the 4 backface
           compares (sd->tVnN.vx/vz by displacement, NOT a `skidCmp` pointer local
           -- that local is an address PSEUDO loop.c hoists into a saved reg), the
           startfog/distfog pair (0xDC/0xDE off the same base, via the bigger
           Draw_tGiveShelbyMoreCache view), and the OT-link template's base
           operand.  This alone was -6 insns AND it dissolved the whole
           `lh/lhu/sll/sra` census signature the w45 receipt read as "missing short
           sign-extension pairs": there was no type bug at all -- the two `lui
           0x1F80`s were what the census was seeing.  (All five (short)/(u_short)/
           local spellings of the fog read measure IDENTICAL once the base is
           shared -- recorded so nobody re-sweeps them.)
       A3. CORRECTNESS: gte_stsxy3 wrote SXY0/1/2 to 0x1F800014/2C/20 (inside
           sd->matB) instead of prim->x1y1/x3y3/x2y2.  Oracle @0x800C9440 uses
           `addiu $aN,$a2,0x14/0x2C/0x20` with $a2 == prim (proved by the later
           `sw $v0,0xC($a2)` pixmap + `lhu $v1,0xE($a2)` clut on the same reg).
       B.  The ONE inverted arm brcensus flagged (`beqz 7v8 bnez 9v8`): the oracle
           guards with `beqz $t0` @0x800C94B0, so the GREY arm is the fall-through
           and the pixmap arm is the branch target -- `if (color_pack != 0)`.
       C1. `bVar2` u_char -> int (killed a per-iteration `andi ,255` + a copy;
           oracle is `sltu $s0,$zero,$v0; beqz $s0`).
       C2. `m = &fskid->m` as a separate variable -- this is what FORCES the SYM's
           `fskid` class ARG stack home: the oracle spills `sw $a0,0x58($sp)` and
           RELOADS it (`lw $t8,0x58($sp); lw $v0,0x34($t8)`) for `fskid->smp`
           while keeping `m` in a callee-saved reg.  With 9 callee-saved consumers
           the pool is full and the param loses -- exactly the w40 ARG-SPILL
           FORCING mechanism.  Our `sw a0,88(sp)` now appears.
       C3. `skidIter` DELETED -- retail mutates the byte cursor IN PLACE in the
           exit test's delay slot (`beq $s5,$v0,exit; addiu $s7,$s7,-0x2B0`) and
           forms the pointer with one `addu $s2,$v0,$s7`.  The copy-through-a-
           second-variable form created an extra call-crossing allocno.

     RESIDUAL = ONE 6-WAY CALLEE-SAVED ROTATION, QUANTIFIED WITH allocsim
     (tools/allocsim.py reproduces our handout 23/23 IDENTICAL; dump via
      `python tools/rtl_dump.py recon/game/psx/draww.cpp -dg -dl`):
        pseudo  what                     ours  RETAIL   refs/live   QTY pri
        p107    bVar2 flag                s0     s0  OK   9/5       5.4000
        p92     pt1_index (sm base)       s1     s2      17/40      1.7000
        p98     sd = 0x1F800000           s2     s1      96/438     1.3150
        p102    ccount                    s3     s5      14/229     0.1834
        p100    m = &fskid->m             s4     s4  OK   14/234    0.1794
        p109    grey 0x404040 (hi half)   s5     s3      13/232     0.1681
        p104    skidIdx                   s6     s7      10/220     0.1363
        p103    t = &fskid->t             s7     s6      10/233     0.1287
        p108    otz94 = 0x1F800094        fp     fp  OK   10/236    0.1271
     REQUIRED DELTAS (tools/reqdelta.py, flr2 boundary math -- the chain must be
     applied top-down, each step is a strict prerequisite for the next):
       1. p98 must outrank p92  ->  p92 refs 17->15 (floor_log2 4->3, .170->.1097)
                                OR p92 live 40->52 (+12).   [reqdelta-verified]
       2. p109 must outrank p102 -> p109 refs 13->15, or p109 live 232->=212.
       3. p100 must outrank p102 -> p100 live 234->=228, or p102 live 229->=235.
       4. p103 must outrank p104 -> p103 live 233->=219, or p104 live 220->=234.
     FALSIFIED IN THIS BASIN (do not re-run): all 24 permutations of the four init
     statements (otz94/sd/t/grey) -- every one gates 317-325 at the same count;
     all 5 positions of `skidIdx = ccount*0x2b0` (before/after each matrix block /
     inside block 1) -- all identical at 305/posdiff 230; moving the `>> 4` into
     the r0/r1/r2 load statements (any subset of rows) -- identical; all 3
     orderings of {exit test, cursor decrement, pt1_index form} -- identical.

     NEW NAMED ANGLE (the one that pays delta #1, and it is a rule-8 job, not a
     dial): the oracle runs TWO walkers -- `$s2` = the Skidmark_Chunk BASE (SYM
     `sm`, REG $s2, PTR STRUCT size 688, block line 33) held constant across the
     inner loop, and `$t1`/`$t3` = per-segment cursors advanced by `addiu ,0x1C`
     with `$t7` the index.  OUR recon fuses all of them into the single invented
     `pt1_index` int, which is why p92 carries 17 refs where retail's `sm` carries
     fewer.  Materialize `Skidmark_Chunk *sm` with its real fields and give the
     inner loop its own cursor locals; that is the same "one fabricated iVarN
     spanning two register lifetimes = two real SYM locals" split that cracked
     SetupBlockader (424->345), and it moves p92's ref count directly.
     ============================================================================ */

  int skidChunk_p;
  int vert_count;
  int smBase;
  int segOff;
  int vert_idx;
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
  coorddef td;
  coorddef ts;
  int ti2;
  /* MATCH (w46-a6): SYM has no u_char here and the oracle keeps the
   * backface flag as a plain word in $s0 (`sltu $s0,$zero,$v0;
   * beqz $s0` @0x800C91B8) -- a u_char local forced an extra
   * `andi ...,255` + a copy on every loop iteration. */
  int bVar2;

  /* MATCH (wave-14): `sd` (SYM REG Draw_DCache*, the scratchpad cache cursor
     -- same idiom as DrawW_BuildObjectFacets/DoTrough) was DECLARED but never
     ASSIGNED/used -- the body instead wrote a plain linked global
     `Render_gWorldMat` and literal-cast the matrix work-area as bare
     `(void*)0x1f800014` at the gte_Set{Rot,Trans}Matrix call sites. The oracle
     never materializes %hi/%lo(Render_gWorldMat) at all (confirmed: raw .s
     loads a LITERAL 0x1F800000-range constant, `lui s1,(0x1F800000>>16)` with
     NO relocation) -- Render_gWorldMat here is really `sd->matB`
     (Draw_DCache.matB @+0x14, matches the 0x1f800014 literal exactly), the
     SAME single shared scratchpad struct DoTrough/BuildObjectFacets already
     use via `sd=(Draw_DCache*)&Render_gPalettePtr`. This explains the
     whole-function register/frame divergence from insn 1 -- our recon spent
     an extra reg + a real relocation on a global that was never linked here. */
  /* NEGATIVE (2026-08-01, w39-a2 -- re-confirms the wave-9 note with two more
     shapes).  SYM @0x800C909C declares the matrix conversion as THREE sibling
     blocks of `int r0,r1,r2` ($3/$4/$5 then $2/$3/$4 twice) plus fn-scope
     pointers `m` (PTR matrixtdef, $s4 == fskid) and `t` (PTR coorddef, $s6 ==
     fskid+36) and `ccount` ($s5); the oracle prologue is `addu $s4,$a0,$zero;
     addiu $s6,$s4,36; lw $s5,48($s4)` and each row is `lw r0/r1/r2; sra; sra;
     sh; sh; sh` (three parallel chains).  MEASURED: writing the three r0/r1/r2
     blocks 377 -> 383 (count 364 -> 362, so the parallel chains ARE the right
     shape but re-colour the head); additionally routing every `fskid->t` /
     `(int*)fskid` use through `t` / `m` 383 -> 405.  Both reverted.  The whole
     residual is upstream of this: our prologue/frame layout differs from insn 1
     and the `sm` (Skidmark_Chunk*, SYM REG $s2, size 0x2B0) walker is still
     modelled as the invented `skidIdx`/`skidIter` byte offsets -- that walker,
     not the matrix rows, is the next lever. */
  /* CORRECTNESS + MATCH (w40-a2): `Skid_gCtrlScratch_94` is a real linked .bss int
   * (skidmark.cpp), but the OT depth this function computes is written by
   * `gte_swc2(0x7, 0x1F800094)` straight into SCRATCHPAD -- so every read of the .bss
   * symbol saw a stale value and the whole skidmark depth clamp / OT index ran on
   * garbage (same bug class as the Skid_gCtrlScratch_98 compares fixed in wave-9).
   * 0x1F800094 is `sd->otz`'s address in the same cache header, and the oracle keeps
   * that literal in its OWN callee-saved reg across the calls (`lui fp,0x1F80;
   * ori fp,fp,0x94` in the prologue), so model it as a local pointer. */
  int *otz94;
  /* MATCH (w40-a2): 0x404040 is stored four times deep inside the loop across calls;
   * the oracle materializes it ONCE into a callee-saved reg in the prologue
   * (`lui s3,0x40; ori s3,s3,0x4040`).  Diff-neutral on its own but it reproduces the
   * oracle's prologue materialization SET (0x1F800000 base + 0x1F800094 + 0x404040);
   * the only one still missing is `t = &fskid->t` ($s6), which REGRESSES (344->415)
   * every time it is added -- retested twice, w39 and w40. */
  int grey;

  otz94 = (int *)0x1f800094;
  sd = (Draw_DCache *)&Render_gPalettePtr;
  m = &fskid->m;
  t = &fskid->t;
  grey = 0x404040;
  ccount_local = fskid->count;
  skidIdx = ccount_local * 0x2b0;
  /* MATCH (w40-a2): SYM @0x800C909C declares the matrix conversion as THREE sibling
   * blocks of `int r0,r1,r2`; the oracle runs each row as three PARALLEL chains
   * (`lw r0; lw r1; lw r2; sra; sra; sra; sh; sh; sh`) so the loads fill each other's
   * delay slots -- the flat nine-statement form serialized them through one scratch
   * and paid a `nop` per row. */
  {
    int r0;
    int r1;
    int r2;
    r0 = m->m[0];
    r1 = m->m[3];
    r2 = m->m[6];
    (sd->matB).m[0][0] = (short)(r0 >> 4);
    (sd->matB).m[0][1] = (short)(r1 >> 4);
    (sd->matB).m[0][2] = (short)(r2 >> 4);
  }
  {
    int r0;
    int r1;
    int r2;
    r0 = m->m[1];
    r1 = m->m[4];
    r2 = m->m[7];
    (sd->matB).m[1][0] = (short)(r0 >> 4);
    (sd->matB).m[1][1] = (short)(r1 >> 4);
    (sd->matB).m[1][2] = (short)(r2 >> 4);
  }
  {
    int r0;
    int r1;
    int r2;
    r0 = m->m[2];
    r1 = m->m[5];
    r2 = m->m[8];
    (sd->matB).m[2][0] = (short)(r0 >> 4);
    (sd->matB).m[2][1] = (short)(r1 >> 4);
    (sd->matB).m[2][2] = (short)(r2 >> 4);
  }
  do {
    do {
      ccount_local = ccount_local + -1;
      if (ccount_local == -1) {
        return;
      }
      /* MATCH (w46-a6): retail has NO `skidIter` -- the SYM lists no such
       * local and the oracle mutates the byte cursor IN PLACE inside the
       * exit-test's delay slot (`beq $s5,$v0,exit; addiu $s7,$s7,-0x2B0`
       * @0x800C917C) and then forms the chunk pointer with a single
       * `addu $s2,$v0,$s7`.  The old copy-through-a-second-variable form
       * created an extra call-crossing allocno that took $s1 away from
       * `sd`.  Identical arithmetic: smp[-1]+0x10-2*8 == (int)smp-0x2B0. */
      skidIdx = skidIdx + -0x2b0;
      pt1_index = (int)fskid->smp + skidIdx;
      bVar2 = 0;
      skidChunk_p = (int)BWorld_IsSliceInBuildList((int)*(short *)((int)&((coorddef *)(pt1_index + 0xc))->x + 2));
      if (skidChunk_p != 0) {
        vert_count = Draw_CircleClip((coorddef *)pt1_index,t,0x320000);
        bVar2 = vert_count != 0;
      }
    } while (bVar2 == 0);
    ts.x = ((coorddef *)pt1_index)->x - t->x;
    ts.y = ((coorddef *)pt1_index)->y - t->y;
    ts.z = ((coorddef *)pt1_index)->z - t->z;
    transform(&ts.x,(int *)m,&td.x);
    (sd->matB).t[0] = td.x >> 6;
    (sd->matB).t[1] = td.y >> 6;
    (sd->matB).t[2] = td.z >> 6;
gte_SetRotMatrix(&sd->matB);
gte_SetTransMatrix(&sd->matB);
    ti2 = ((coorddef *)(pt1_index + 0xc))->x;
    smBase = pt1_index;
    segOff = 0x10;
    for (depth_skid = 0; depth_skid < (short)ti2; depth_skid = depth_skid + 1) {
      /* MATCH (2026-07-11): oracle re-reads Render_gPacketEnd's TRUE storage
       * address (scratchpad 0x1F800008, same "Render_gPacketPtr style" fixed-
       * lvalue idiom as nfs4_types.h's Render_gPacketPtr/Render_gPalettePtr
       * macros -- confirmed via Draw_StartRenderingView's oracle .s, which
       * writes Render_gPacketEnd through a literal lui/ori 0x1F800008, never
       * %hi/%lo(sym)). draww_externs.h still declares it a plain extern
       * (header edits are out of scope here), so the literal cast is applied
       * locally at this one use site only -- no other TU's codegen changes. */
      /* MATCH (w40-a2): the packet cursor and its end-limit ARE fields of the same
       * scratchpad cache header `sd` already points at (0x1F800004 = head.cprim.PrimPtr,
       * 0x1F800008 = head.cprim.MPrimPtr) -- reaching them through the `Render_gPacketPtr`
       * literal-address macro made gcc materialize a SECOND scratchpad base
       * (`ori s7,s6,4`) in its own callee-saved reg, which is the slot the oracle spends
       * on `count*0x2B0`. Same base, same bytes, one fewer allocno. */
      /* CORRECTNESS FIX (w42-a2) -- LATENT BUG, the whole first half of this
       * loop's geometry was garbage.  The two gte_ldv0() calls below read
       * `depth_index`, which is NEVER ASSIGNED anywhere in this function: it is
       * the CLUT-ramp index (SYM block @0x800C9548 line 125, `depth_index`
       * class REG $3 == $v1), and Ghidra merged it with the ANONYMOUS $v1
       * compiler temp that carries the vertex address here -- same register,
       * two disjoint lifetimes, one Ghidra name.  So the recon fed the GTE an
       * uninitialised value for skid-segment vertices 0 and 1 (the near edge of
       * every skidmark quad) while only vertices 2/3 (via ->next) were right.
       * Raw oracle @0x800C92B8/0x800C92F4 (authority):
       *   addu  $v1,$s2,$t3   ; $s2 = sm (Skidmark_Chunk*), $t3 = 0x10 + i*0x1C
       *   lwc2  $0,0($v1); lwc2 $1,4($v1)        = &sm->seg[i].svx[0]
       *   ...
       *   addiu $v1,$v1,8
       *   lwc2  $0,0($v1); lwc2 $1,4($v1)        = &sm->seg[i].svx[1]
       * Skidmark_Chunk.seg @+0x10, stride 0x1C; Skidmark_Segment.svx[2] @+0x0.
       * `pt1_index` is the oracle's $t1 walker (sm + i*0x1C), so the two
       * addresses are pt1_index+0x10 and pt1_index+0x18 -- and the +8 step
       * between them is the oracle's own `addiu $v1,$v1,8`. */
      if ((sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) && (((coorddef *)(pt1_index + 0x24))->y != 0)) {
        int svp = smBase + segOff;                  /* &sm->seg[i].svx[0] */
gte_ldv0((int *)(svp));
        gte_rtps();
gte_stlvnl(&sd->tVn0);
        primPtr = sd->head.cprim.PrimPtr;
        /* CORRECTNESS FIX (2026-07-12, oracle @0x800C92E0): SXY goes to the
         * CURRENT packet cursor (Render_gPacketPtr + 8), not the fixed
         * scratchpad literal 0x1F800008 (= Render_gPacketEnd's slot). */
gte_swc2(0xe,(void *)(primPtr + 8));
        svp = svp + 8;                              /* &sm->seg[i].svx[1] */
gte_ldv0((int *)(svp));
        gte_rtps();
gte_stlvnl(&sd->tVn1);
gte_ldv0((int *)(((coorddef *)(pt1_index + 0x24))->y + 8));
        gte_rtps();
gte_stlvnl(&sd->tVn2);
gte_ldv0((int *)(((coorddef *)(pt1_index + 0x24))->y));
        gte_rtps();
gte_stlvnl(&sd->tVn3);
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
        /* MATCH (w46-a6): the compares read the four transformed normals by
         * DISPLACEMENT off the shared scratchpad base -- oracle
         * `lw $v0,0x98($s1); lw $v1,0xA0($s1)` ... `lw $v0,0xC8($s1);
         * lw $v1,0xD0($s1)` (@0x800C93B0-0x800C9428).  A `skidCmp` pointer
         * local instead creates an address PSEUDO for `sd+0x98` which loop.c
         * hoists into a CALLEE-SAVED register (it is loop-invariant and shared
         * with the gte_stlvnl store), eating the slot the oracle spends on
         * `t = &fskid->t` ($s6). */
        if (((sd->tVn0.vx < sd->tVn0.vz) ||
            (((sd->tVn1.vx < sd->tVn1.vz || (sd->tVn2.vx < sd->tVn2.vz)) ||
             (sd->tVn3.vx < sd->tVn3.vz)))) &&
           ((((-sd->tVn0.vx < sd->tVn0.vz || (-sd->tVn1.vx < sd->tVn1.vz)
              ) || (-sd->tVn2.vx < sd->tVn2.vz)) ||
            (-sd->tVn3.vx < sd->tVn3.vz)))) {
          color_pack = ((coorddef *)(pt1_index + 0x24))->x;
          pmx_dst = (int)&gSkidMarkPixmap[color_pack & 1];
          /* CORRECTNESS BUG (w46-a6) -- the three transformed screen XYs were
           * written to SCRATCHPAD 0x1F800014/2C/20 (= sd->matB's interior!),
           * clobbering the rotation matrix and leaving the primitive's
           * x1y1/x3y3/x2y2 fields UNWRITTEN (garbage vertices 1..3 on every
           * skidmark quad).  Raw oracle @0x800C9440-0x800C9468 is authority:
           *     addiu $a1,$a2,0x14 ; addiu $a0,$a2,0x2C ; addiu $v0,$a2,0x20
           *     swc2  $12,0($a1)   ; swc2  $13,0($a0)   ; swc2  $14,0($v0)
           * and $a2 is `prim` (SYM Block line 62, REG $6) -- proven by the
           * later `sw $v0,0xC($a2)` / `lhu $v1,0xE($a2)` pixmap+clut stores.
           * POLY_GT4: x1y1@0x14, x2y2@0x20, x3y3@0x2C.  Also -3 insns: the
           * oracle's addiu-off-prim replaces our lui/ori literal pairs. */
gte_stsxy3((void *)((int)primPtr + 0x14),(void *)((int)primPtr + 0x2c),
                     (void *)((int)primPtr + 0x20));
          gte_avsz4();
gte_swc2(0x7,(void *)0x1f800094);
          vt_y = *otz94 >> 5;
          *otz94 = vt_y + 0x32;
          if (*otz94 < 1) {
            return;
          }
          if (Draw_gViewOtSize + -3 < *otz94) {
            return;
          }
          /* MATCH (w46-a6, step B -- the ONE inverted arm brcensus flagged as
           * `beqz 7v8 bnez 9v8`): the oracle's guard is `beqz $t0,.L800C94CC`
           * @0x800C94B0, i.e. the GREY arm is the FALL-THROUGH and the pixmap
           * arm is the branch TARGET.  Writing `if (color_pack == 0)` first
           * emitted `bnez` and swapped the two blocks' physical order. */
          if (color_pack != 0) {
            *(u_int *)((int)primPtr + 4) = grey;
            *(u_int *)((int)primPtr + 0x10) = grey;
            *(u_int *)((int)primPtr + 0x28) = grey;
            *(u_int *)((int)primPtr + 0x1c) = grey;
          }
          else {
            *(int *)((int)primPtr + 4) = ((coorddef *)(pt1_index + 0x18))->z;
            *(int *)((int)primPtr + 0x10) = ((coorddef *)(pt1_index + 0x18))->z;
            *(u_int *)((int)primPtr + 0x28) =
                 *(u_int *)(((coorddef *)(pt1_index + 0x24))->y + 0x10);
            *(u_int *)((int)primPtr + 0x1c) =
                 *(u_int *)(((coorddef *)(pt1_index + 0x24))->y + 0x10);
          }
          *(u_char *)((int)primPtr + 7) = 0x3e;
          *(u_char *)((int)primPtr + 3) = 0xc;
          /* MATCH (w41-a2): SYM block @0x800C950C line 119 declares FOUR ULONG REG
           * locals l0..l3 ($2/$3/$4/$5).  The oracle batches all four pixmap word
           * loads (lw v0,0(a3); lw v1,4(a3); lw a0,8(a3); lw a1,0xC(a3)) and only
           * then issues the four prim stores, so each load fills the previous one's
           * delay slot; the three-temp form (first word copied by a direct
           * load-store expression) serialized the head pair. */
          {
            u_long l0, l1, l2, l3;

            l0 = *(u_long *)pmx_dst;
            l1 = *(u_long *)(pmx_dst + 4);
            l2 = *(u_long *)(pmx_dst + 8);
            l3 = *(u_long *)(pmx_dst + 0xc);
            *(u_long *)((int)primPtr + 0xc) = l0;
            *(u_long *)((int)primPtr + 0x18) = l1;
            *(u_long *)((int)primPtr + 0x24) = l2;
            *(u_long *)((int)primPtr + 0x30) = l3;
          }
          /* CORRECTNESS + MATCH (w41-a2, census lh 4v2 / lhu 2v5):
           * (a) the POLY_GT4 clut at +0xE is a U_SHORT compared against the literal
           *     0xFFFF -- the oracle is `lhu $v1,0xE($a2); ori $v0,$zero,0xFFFF;
           *     bne $v1,$v0`.  Reading it as a SIGNED short and comparing to -1 is
           *     the recurring unsigned-vs--1 class (it happens to be true here for
           *     the same bit pattern, but it emits `lh` + a different constant).
           * (b) `Skid_gScratchPos1`/`Skid_gScratchPos2` are linked .bss ints in
           *     skidmark.cpp, but the oracle reads BOTH as u_shorts straight off the
           *     scratchpad cache base ($s1): `lhu $v0,0xDC($s1); lhu $v1,0xDE($s1)`
           *     == Draw_tGiveShelbyMoreCache::startfog / ::distfog.  Same stale-read
           *     bug class as Skid_gCtrlScratch_94/98 already fixed here -- the depth
           *     ramp index was computed from .bss values nothing in this frame wrote.
           *     The `sll 16; sra 16` on the first one is the u_short read narrowed
           *     back to SIGNED for the subtract; the second stays unsigned (it is a
           *     shift COUNT feeding `srav`). */
          if (*(u_short *)((int)primPtr + 0xe) == 0xffff) {
            /* MATCH (w46-a6): read the fog pair by DISPLACEMENT off the shared
             * scratchpad base -- oracle `lhu $v0,0xDC($s1); lhu $v1,0xDE($s1)`
             * @0x800C9548.  The DW_SCRATCH literal form materialized TWO extra
             * `lui 0x1F80`s.  (Draw_DCache stops at 0xDC; the fog pair lives in
             * the bigger Draw_tGiveShelbyMoreCache view of the same header.) */
            vert_idx = (vt_y - ((Draw_tGiveShelbyMoreCache *)sd)->startfog) * 0x10 >>
                       ((Draw_tGiveShelbyMoreCache *)sd)->distfog;
            if (vert_idx < 0) {
              vert_idx = 0;
            }
            else if (0xf < vert_idx) {
              vert_idx = 0xf;
            }
            *(short *)((int)primPtr + 0xe) =
                 ((short (*)[16])gClutDepth_v)[*(u_short *)(pmx_dst + 10)][vert_idx];
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
                : "r"(sd), "r"(*otz94)
                : "$12", "$13", "$14", "memory");
          }
        }
        }
      }
      pt1_index = (int)&((coorddef *)(pt1_index + 0x18))->y;
      segOff = segOff + 0x1c;
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

/* MATCH (SYM DRAWW.CPP line 3128 block: `int t1, t2;` in $a0/$a1): 8-byte 4-ALIGNED
   vertex copy used by DrawW_OnyxLinePrim -- lw/lw/sw/sw, not the align-2 movstrsi. */
#define ONYX_COPYVT(d,s)  { int t1, t2;  t1 = ((int *)(s))[0];  t2 = ((int *)(s))[1];                             ((int *)(d))[0] = t1;  ((int *)(d))[1] = t2; }

/* ---- DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:3108-3330] SLD-VERIFIED ----
   REWRITTEN 2026-07-31 (w38-a2) from the SYM 8c block + raw oracle.  The prior body was
   Ghidra soup (~50 fabricated locals) and carried FOUR behavioural bugs (see below).
   SYM ground truth (nfs4-f-v3.txt @0x800C98B8, fsize 120, mask 0xc0ff0000):
     REGPARM geomVertices=$s3 lineQuad=$s6 sd=$s1;  count = class ARG (stack home 0x80(sp),
     re-loaded at every loop test -- never register-cached);
     REG   prim=$s0 (POLY_GT4*), lineQuadCount=$fp, pmx=$s4 (Draw_tPixMap*),
           linetype=$v0, save_pre_otz=$s7, t1/t2=$a0/$a1 (the 8-byte vertex-copy temps),
           a/b=$v1/$v0 (night colour words), l0..l3=$v0/$v1/$a0/$a1 (pmx word copy),
           depth_index=$a1;
     AUTO  vt0..vt3 @0x10/0x18/0x20/0x28, temp0(VECTOR)/a(CVECTOR) SHARE @0x30,
           bfct @0x40, depthcue @0x44, doSubdivision @0x4C;
     LABEL loopbot  -> the rejection paths are `goto loopbot`, not nested ifs.
   BUGS FIXED (all oracle-cited):
    1. vt0/vt1 were NEVER INITIALISED -- the old body only filled vt2/vt3, so two of the
       four RTPS transforms ran on garbage stack.  Oracle @0x800C9950-0x800C997C copies
       four whole CCOORD16s: vt0=geomVertices[3], vt1=[1], vt2=[0], vt3=[2].
    2. pmx: oracle `lbu type; sll 2; addu gDLPixmap; lw s4,0(v0)` = pmx = gDLPixmap[type]
       (gDLPixmap is an ARRAY OF POINTERS).  The old body used &gDLPixmap[type] and then
       read the pixmap words out of the POINTER TABLE itself.
    3. gte_stsxy3 targets are Render_gPacketPtr + 0x14/0x2C/0x20 (oracle keeps the packet
       cursor in $s0 from the +8 store above), NOT the scratchpad literals 0x1F800014 /
       0x1F80002C / 0x1F800020 -- same bug class as the +8 store fixed in 2026-07-12.
    4. Night_NightCopCalc was called with (temp0, (short*)sd); oracle passes &vt2.light
       (`addiu a1,sp,0x26`) and &vt3.light (`addiu a1,sp,0x2E`).
   MATCH shapes taken from the oracle: whole-struct CCOORD16/CVECTOR assignments (the
   align-1 CVECTOR ones expand to the oracle's lwl/lwr+swl/swr movstrsi runs, the u_long
   casts to plain lw/sw); the night colour path stores WORDS (4 stores), not 16 bytes;
   the pmx->prim copy is the SYM's load-4/store-4 l0..l3 group; `if (nightFlags)` has the
   NIGHT arm as the fall-through (oracle `beqz -> .L800C9E14` = the dpcs arm is out of
   line); the stack-speedup `if` likewise has the speedup arm as fall-through. ---- */
void DrawW_OnyxLinePrim(CCOORD16 *geomVertices,Trk_Line *lineQuad,int count,Draw_tGiveShelbyMoreCache *sd)

{
  POLY_GT4 *prim;
  int lineQuadCount;
  Draw_tPixMap *pmx;
  CCOORD16 vt0;
  CCOORD16 vt1;
  CCOORD16 vt2;
  CCOORD16 vt3;

  sd->offsubdivid = 0x200;
  for (lineQuadCount = 0; lineQuadCount < count + -1;
       lineQuadCount = lineQuadCount + 1, lineQuad = lineQuad + 1, geomVertices = geomVertices + 2) {
    int linetype;

    while ((lineQuadCount < count + -1) && (lineQuad->type != 0xff)) {
      int doSubdivision;
      int save_pre_otz;
      int depthcue;
      u_char *packetPtr;

      linetype = lineQuad->type;
      pmx = gDLPixmap[linetype];
      /* MATCH: the vertex copy is the SYM's line-21 block { int t1, t2; ... } (t1=$a0,
       * t2=$a1) -- a WORD-PAIR copy, i.e. the original knew the CCOORD16s are 4-aligned.
       * A plain `vt0 = geomVertices[3];` struct assignment carries CCOORD16's align-2
       * and expands to the unaligned lwl/lwr+swl/swr movstrsi run (8 insns/copy vs 4). */
      { int t1, t2;
        t1 = ((int *)&geomVertices[3])[0]; t2 = ((int *)&geomVertices[3])[1];
        ((int *)&vt0)[0] = t1; ((int *)&vt0)[1] = t2;
        t1 = ((int *)&geomVertices[1])[0]; t2 = ((int *)&geomVertices[1])[1];
        ((int *)&vt1)[0] = t1; ((int *)&vt1)[1] = t2;
        t1 = ((int *)&geomVertices[0])[0]; t2 = ((int *)&geomVertices[0])[1];
        ((int *)&vt2)[0] = t1; ((int *)&vt2)[1] = t2;
        t1 = ((int *)&geomVertices[2])[0]; t2 = ((int *)&geomVertices[2])[1];
        ((int *)&vt3)[0] = t1; ((int *)&vt3)[1] = t2; }
      gte_ldv0((int *)(&vt0));
      gte_rtps();
      gte_stlvnl(((char *)sd + 0x98));
      /* CORRECTNESS (oracle @0x800C99C8): the SXY writes target the CURRENT packet
       * cursor (Render_gPacketPtr + 8 / +0x14 / +0x2C / +0x20), never the fixed
       * scratchpad literals -- 0x1F800008 is Render_gPacketEnd's own slot. */
      packetPtr = Render_gPacketPtr;
      gte_swc2(0xe,(void *)(packetPtr + 8));
      gte_ldv0((int *)(&vt1));
      gte_rtps();
      gte_stlvnl(((char *)sd + 0xa8));
      gte_ldv0((int *)(&vt2));
      gte_rtps();
      gte_stlvnl(((char *)sd + 0xb8));
      gte_ldv0((int *)(&vt3));
      gte_rtps();
      gte_stlvnl(((char *)sd + 0xc8));
      if (!((((sd->tVn0).vx < (sd->tVn0).vz || ((sd->tVn1).vx < (sd->tVn1).vz)) ||
             ((sd->tVn2).vx < (sd->tVn2).vz)) || ((sd->tVn3).vx < (sd->tVn3).vz))) goto loopbot;
      if (!((((-(sd->tVn0).vx < (sd->tVn0).vz) || (-(sd->tVn1).vx < (sd->tVn1).vz)) ||
             (-(sd->tVn2).vx < (sd->tVn2).vz)) || (-(sd->tVn3).vx < (sd->tVn3).vz))) goto loopbot;
      gte_stsxy3((void *)(packetPtr + 0x14),(void *)(packetPtr + 0x2c),(void *)(packetPtr + 0x20));
      {
        long bfct;

        gte_avsz4();
        gte_swc2(0x7,&sd->otz);
        gte_nclip();
        gte_swc2(0x18,&bfct);
        if ((sd->head).mirror == 1) {
          bfct = -bfct;
        }
        if (bfct < 0) goto loopbot;
      }
      save_pre_otz = sd->otz >> 1;
      doSubdivision = (int)(sd->otz < 200);
      sd->otz = save_pre_otz + 0x4b;
      if (sd->otz <= 0) goto loopbot;
      if (Draw_gViewOtSize + -3 < sd->otz) goto loopbot;
      if (doSubdivision != 0) {
        prim = &sd->GT4Prim;
      }
      else {
        /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE ($t4/$t5/$t6 scratches; same shape
         * as DrawW_SubdividFacet / DrawW_DrawQuad's sealed instances): slot =
         * sd->head.cprim.LastPrim + sd->otz*4; sd->head.cprim.PrimPtr = prim+0x34;
         * prim->tag = slot->addr24 | (0x0C<<24); slot->addr24 = prim. */
        prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;
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
      gte_swc2(0x8,&depthcue);
      if (sd->nightFlags != 0) {
        if ((sd->nightFlags & 1U) != 0) {
          VECTOR temp0;

          gte_SetRotMatrix(((char *)sd + 0x34));
          gte_SetTransMatrix(((char *)sd + 0x34));
          gte_ldv0((int *)(&vt2));
          gte_rt();
          gte_stlvnl(&temp0);
          gte_ldv0((int *)(&vt3));
          gte_rt();
          Night_NightCalc(&temp0,&vt2.light,sd);
          gte_stlvnl(&temp0);
          Night_NightCalc(&temp0,&vt3.light,sd);
        }
        if (BW_gCopCarObj != (Car_tObj *)0x0) {
          VECTOR temp0;

          gte_SetRotMatrix(((char *)sd + 0x54));
          gte_SetTransMatrix(((char *)sd + 0x54));
          gte_ldv0((int *)(&vt2));
          gte_rt();
          gte_stlvnl(&temp0);
          gte_ldv0((int *)(&vt3));
          gte_rt();
          Night_NightCopCalc(&temp0,&vt2.light);
          gte_stlvnl(&temp0);
          Night_NightCopCalc(&temp0,&vt3.light);
        }
        {
          long a;
          long b;

          a = *(long *)&Chunk_lightTable[vt3.light];
          b = *(long *)&Chunk_lightTable[vt2.light];
          *(long *)&prim->r3 = b;
          *(long *)&prim->r1 = b;
          *(long *)&prim->r2 = a;
          *(long *)&prim->r0 = a;
        }
        gte_SetRotMatrix(((char *)sd + 0x14));
        gte_SetTransMatrix(((char *)sd + 0x14));
      }
      else {
        CVECTOR a;

        /* the CVECTOR (align-1) struct assignments ARE the oracle's lwl/lwr + swl/swr
         * movstrsi runs; a u_long cast here would emit aligned lw/sw instead. */
        a = *(CVECTOR *)&Chunk_lightTable[vt3.light];
        gte_ldrgb(&a);
        gte_ldir0v(depthcue);
        gte_dpcs();
        gte_swc2(0x16,(char *)prim + 0x1c);
        *(CVECTOR *)&prim->r0 = *(CVECTOR *)&prim->r2;
        a = *(CVECTOR *)&Chunk_lightTable[vt2.light];
        gte_ldrgb(&a);
        gte_ldir0v(depthcue);
        gte_dpcs();
        gte_swc2(0x16,(char *)prim + 0x28);
        *(CVECTOR *)&prim->r1 = *(CVECTOR *)&prim->r3;
      }
      prim->code = 0x3e;
      *(u_char *)((int)&prim->tag + 3) = 0xc;
      {
        u_long l0;
        u_long l1;
        u_long l2;
        u_long l3;

        l0 = *(u_long *)&pmx->u0;
        l1 = *(u_long *)&pmx->u1;
        l2 = *(u_long *)&pmx->u2;
        l3 = *(u_long *)&pmx->u3;
        *(u_long *)&prim->u0 = l0;
        *(u_long *)&prim->u1 = l1;
        *(u_long *)&prim->u2 = l2;
        *(u_long *)&prim->u3 = l3;
      }
      if (prim->clut == 0xffff) {
        int depth_index;

        depth_index = (save_pre_otz - sd->startfog) * 0x10 >> ((int)sd->distfog);
        if (depth_index < 0) {
          depth_index = 0;
        }
        else if (0xf < depth_index) {
          depth_index = 0xf;
        }
        prim->clut = gClutDepth[pmx->pad2][depth_index];
      }
      if (doSubdivision != 0) {
        gte_SetRotMatrix(((char *)sd + 0x74));
        gte_SetTransMatrix(((char *)sd + 0x74));
        if (stackSpeedUpEnbabledFlag != 0) {
          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 0;
          DrawW_SetUpSubdividFacet_Line(sd);
          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 1;
        }
        else {
          DrawW_SetUpSubdividFacet_Line(sd);
        }
        gte_SetRotMatrix(((char *)sd + 0x14));
        gte_SetTransMatrix(((char *)sd + 0x14));
      }
loopbot:
      lineQuadCount = lineQuadCount + 1;
      lineQuad = lineQuad + 1;
      geomVertices = geomVertices + 2;
    }
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
    /* MATCH (w45-a5) -- PASS 88/88.  Four cooperating levers, in this order:
       (1) RULE-8: SYM VA 800ca0f8 block declares EXACTLY seven inner names --
           `pts` (PTR CCOORD16, reg $6=$a2) and six SHORTs x($3=$v1) y($4=$a0)
           z($5=$a1) wx($8=$t0) wy($9=$t1) wz($7=$a3).  The old `pCoord` +
           integer `pts` + `idx` + sVar7..sVar14 set was Ghidra invention;
           deleting it and naming the six shorts per SYM took 54 -> 43 and put
           wx/wy/wz in their oracle registers.
       (2) `(signed char)b >> 3` IS the 5-bit extend -- combine merges the
           widen into the oracle's `lbu; sll 24; sra 27` (the hand-expanded
           `(int)((u_int)(u_char)b << 0x18) >> 0x1b` form is equivalent here but
           the plain spelling is what a 1998 author wrote; cf. catalog w42
           "PLAIN SPELLING BEATS HAND-EXPANDED SHIFTS").
       (3) STATEMENT ORDER: `pts` (the firstPoint load) must be the FIRST
           statement of the block -- the oracle issues `lbu a2,0(t4)` before the
           slice byte, then sched1 defers the `sll/addu` address arithmetic past
           the slice chain.  pts-first: 43 -> 29.
       (4) The `rn` POINTER MUST EXIST AND BE ASSIGNED *AFTER* `pts`
           (29 -> 2, count 87 -> 88 exact).  It is a compiler temp (absent from
           SYM) but it is REAL: the oracle folds rn[0] into `lbu t0,18(v0)` off
           the still-live slice base and only then materializes rn by MUTATING
           that base IN PLACE (`addiu v0,v0,18; lbu t1,1(v0); lbu a3,2(v0)`).
           Measured basin: rn-after-pts 2 · rn-first 4 · rn-after-wx 40 · no rn
           at all (displacements 19/20, one insn SHORT) 29.
       (5) The last diff was the commutative `addu` operand order on the slice
           base -- `BWorldSm_slices[i]` emits `addu v0,s1,v0` (base first) while
           the oracle wants the scaled index first (`addu v0,v0,s1`); the
           explicit `(T*)((i << 5) + (int)base)` cast form delivers it
           (methodology 5.0c commutative-addu lever).  2 -> PASS. */
    CCOORD16 *pts;
    char *rn;
    short x;
    short y;
    short z;
    short wx;
    short wy;
    short wz;

    pts = wpts + (u_int)curLine->firstPoint;
    rn = ((Trk_NewSlice *)(((slice + (u_int)curLine->slice) << 5) + (int)BWorldSm_slices))->right;
    wx = (signed char)rn[0] >> 3;
    wy = (signed char)rn[1] >> 3;
    wz = (signed char)rn[2] >> 3;
    x = pts->x;
    y = pts->y;
    z = pts->z;
    /* MATCH: the oracle walks pts3d with TWO +8 bumps per iteration (one per vertex,
       `addiu t3,t3,8` mid-body and again at the tail) and splits the stores across a
       base/base+6 giv pair -- the index form pts3d[0]/pts3d[1] + a single +16 bump
       collapses that to one walker.  Operand order `t + (v +/- n)` matches the oracle's
       `addu v1,v1,t0; addu v1,t8,v1` (vertex value first, translation last). */
    pts3d->x = tx + (x - wx);
    pts3d->y = ty + (y - wy);
    pts3d->z = tz + (z - wz);
    pts3d->light = pts->light;
    pts3d = pts3d + 1;
    pts3d->x = tx + (x + wx);
    pts3d->y = ty + (y + wy);
    pts3d->z = tz + (z + wz);
    pts3d->light = pts->light;
    pts3d = pts3d + 1;
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
     standard levers; permuter/accept candidate.
     UPDATE (w11-a9, 52 -> 14): CRACKED by TWO catalog levers --
     (1) matB t[]-zero REBASING: the oracle stores t[2]/t[1] THROUGH the same
     materialized `&sd->matB` reg the gte_SetTransMatrix "r" operand uses, but
     t[0] via the sd base (`sw zero,40(sd)`) -- reproduced with a block-local
     `MATRIX *m = (MATRIX *)&sd->matB; m->t[2]=0; m->t[1]=0; (sd->matB).t[0]=0;
     gte_SetTransMatrix(m);` (MIXED lvalues are load-bearing; all-m or all-direct
     both miss). Same idiom at the in-loop site (m2). -4 diffs.
     (2) the s1<->s2 swap: NET-ZERO POINTER INC/DEC PAIRS (catalog SA
     BworldSm_UpdateSimQuad lever) -- `buildList++; buildList--;` alone
     over-rotated (buildList past Vi, s0/s1 flip); adding `Vi++; Vi--;` restores
     Vi > buildList > sd = oracle's s0/s1/s2. -28 diffs. RESIDUAL 14 = prologue
     param-copy schedule (ours copies a1->s1 at top, oracle sinks it to the loop
     head) + a translation.x-vs-pChunkCp->x load-order sched tie in trans.x/y/z;
     both pure sched2 tie-breaks; permuter candidates. */
  int chunkCount;

  Vi++; Vi--;  /* MATCH: net-zero pair -- lifts Vi's allocno priority above buildList (see above) */
  chunkCount = BWorld_gChunkCount;
  sd->doublelayer = 0;
  {
    MATRIX *m = (MATRIX *)&sd->matB;  /* MATCH: mixed-lvalue matB rebasing (see above) */
    m->t[2] = 0;
    m->t[1] = 0;
    (sd->matB).t[0] = 0;
    gte_SetTransMatrix(m);
  }
  {
    int buildInd;
    buildList++; buildList--;  /* MATCH: net-zero pair -- buildList wins s1 over sd (see above) */
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
            {
              MATRIX *m2 = (MATRIX *)&sd->matB;
              m2->t[2] = 0;
              m2->t[1] = 0;
              (sd->matB).t[0] = 0;
              gte_SetTransMatrix(m2);
            }
          }
          {
            coorddef *pChunkCp;
            pChunkCp = Chunk_chunkCenters + buildList->chunkInd;
            {
              int tx = (Vi->cview).translation.x;
              trans.x = (short)(pChunkCp->x - tx >> 10);
            }
            {
              int ty = (Vi->cview).translation.y;
              trans.y = (short)(pChunkCp->y - ty >> 10);
            }
            {
              int tz = (Vi->cview).translation.z;
              trans.z = (short)(pChunkCp->z - tz >> 10);
            }
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
  /* MATCH (w11-a9): full rule-8 SYM rewrite (SYM @0x800CA520) -- REAL local set
     {i,j,vertex3d,wx,wy,wz,fx,fy,fz,sx,sy,sz,slice,cp,quads,material,tmp,tmp2};
     the prior draft used ~15 Ghidra temps (uVar6-8/sVar13-18/iVar9-14/pTVar10/
     pCVar11) with no SYM counterpart. Ground truth read off the raw oracle:
     frame 0x1C8 with decl-order slots vertex3d@0x10 quads@0xE8 material@0x148
     tmp@0x150 tmp2@0x160 fx/fy/fz/sx/sy@0x170..0x190 (AUTO, 8-byte aligned)
     cp@0x198; scale = scale/8 (signed-div idiom, in-place); wx/wy/wz = srl-10 of
     fixedmult held in fp/s7/s6 across all three copy loops; fx/fy/fz = lb+sra 1
     (SIGNED char reads) spilled to their AUTO homes; sx/sy spilled, sz stays in
     $t1 (REG class, no calls intervene); belt rows built by three 8-iter copy
     loops (lhu reads = u_short element reads); quads built in j/j+8 pairs with
     material as ONE sh store (the old aPoints[-2] byte-pair was a mis-model);
     pmxIndex/vertex reads via *(u_short*) where the oracle uses lhu. */
  int i;
  int j;
  int k;
  CCOORD16 vertex3d [27];
  Trk_Quad quads [16];
  Track_tMaterial material;
  coorddef tmp;
  coorddef tmp2;
  u_short fx;
  u_short fy;
  u_short fz;
  u_short sx;
  u_short sy;
  short sz;
  short wx, wy, wz;
  int slice;
  coorddef *cp;

  slice = gSpikeBeltSlice;
  cp = (coorddef *)(BWorldSm_slices + slice);
  scale = scale / 8;
  wx = (short)((u_int)fixedmult((int)(signed char)((Trk_NewSlice *)cp)->right[0] << 9,scale) >> 10);
  wy = (short)((u_int)fixedmult((int)(signed char)BWorldSm_slices[slice].right[1] << 9,scale) >> 10);
  wz = (short)((u_int)fixedmult((int)(signed char)BWorldSm_slices[slice].right[2] << 9,scale) >> 10);
  /* MATCH: `lb;sra 1` -- a bare `(signed char)f >> 1` gets combine-merged into
     lbu+sll24+sra25 on cc1plus 2.8.0 (proven invariant across 8 source shapes,
     scratchpad/lbtest*.cpp); an int temp with a net-zero ++/-- pair blocks the
     merge and folds away completely (0 extra insns). */
  { int t2 = (signed char)BWorldSm_slices[slice].forward[2]; t2++; t2--; fz = (u_short)(t2 >> 1); }
  { int t1 = (signed char)BWorldSm_slices[slice].forward[1]; t1++; t1--; fy = (u_short)(t1 >> 1); }
  { int t0 = (signed char)BWorldSm_slices[slice].forward[0]; t0++; t0--; fx = (u_short)(t0 >> 1); }
  sx = (u_short)(fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[slice].right[0] << 9) >> 10);
  sy = (u_short)(fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[slice].right[1] << 9) >> 10);
  sz = (short)(fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[slice].right[2] << 9) >> 10);
  vertex3d[0].x = sx - fx;
  vertex3d[0].y = sy - fy;
  vertex3d[0].z = sz - fz;
  vertex3d[0].light = 0;
  k = 0;
  i = 1;
  do {
    CCOORD16 *p = (CCOORD16 *)((int)vertex3d + k);
    vertex3d[i].x = *(u_short *)&p->x + wx;
    vertex3d[i].y = *(u_short *)&p->y + wy;
    vertex3d[i].z = *(u_short *)&p->z + wz;
    vertex3d[i].light = 0;
    k += 8;
    i++;
  } while (i < 9);
  vertex3d[9].x = sx;
  vertex3d[9].y = sy + 0x19;
  vertex3d[9].z = sz;
  vertex3d[9].light = 0;
  k = 0x48;
  i = 1;
  do {
    CCOORD16 *p = (CCOORD16 *)((int)vertex3d + k);
    vertex3d[i+9].x = *(u_short *)&p->x + wx;
    vertex3d[i+9].y = *(u_short *)&p->y + wy;
    vertex3d[i+9].z = *(u_short *)&p->z + wz;
    vertex3d[i+9].light = 0;
    k += 8;
    i++;
  } while (i < 9);
  vertex3d[18].x = sx + fx;
  vertex3d[18].y = sy + fy;
  vertex3d[18].z = sz + fz;
  vertex3d[18].light = 0;
  k = 0x90;
  i = 1;
  do {
    CCOORD16 *p = (CCOORD16 *)((int)vertex3d + k);
    vertex3d[i+18].x = *(u_short *)&p->x + wx;
    vertex3d[i+18].y = *(u_short *)&p->y + wy;
    vertex3d[i+18].z = *(u_short *)&p->z + wz;
    vertex3d[i+18].light = 0;
    k += 8;
    i++;
  } while (i < 9);
  j = 0;
  do {
    quads[j].aPoints[3] = (u_char)j;
    quads[j].material = 0;
    quads[j].aPoints[0] = (u_char)(j + 1);
    quads[j].aPoints[1] = (u_char)(j + 10);
    quads[j].aPoints[2] = (u_char)(j + 9);
    quads[j+8].material = 0;
    quads[j+8].aPoints[1] = (u_char)(j + 9);
    quads[j+8].aPoints[2] = (u_char)(j + 10);
    quads[j+8].aPoints[3] = (u_char)(j + 0x13);
    quads[j+8].aPoints[0] = (u_char)(j + 0x12);
    j = j + 1;
  } while (j < 8);
  material.flag = 0;
  material.mipmap_offset = 0;
  material.pmxIndex = *(u_short *)&gInitialArt.shapeCount - 1;
  {
    Draw_tGiveShelbyMoreCache *sdG = (Draw_tGiveShelbyMoreCache *)sd;
    sdG->nightFlags = 0;
    tmp.x = cp->x - (Vi->cview).translation.x;
    tmp.y = cp->y - (Vi->cview).translation.y;
    tmp.z = cp->z - (Vi->cview).translation.z;
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
