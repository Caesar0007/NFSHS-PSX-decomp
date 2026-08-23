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
/* `offsets` moved to a FUNCTION-SCOPE static inside DrawW_BuildCustomObjectFacets
   (SYM rule-8, nfs4-f-v3.txt:191805 -- its `96 Def2 class STAT type ARY CHAR
   size 8 dims 1 8 name offsets` record sits INSIDE that fn's 8c block, and no
   symbol-table entry exists at 0x8013D828, unlike file-scope `goffsets`
   @0x8013D820 which does carry a type-6 local symbol). */
MATRIX       gIdentTemplate = {4096, 0};   /* @0x8011f570 */
int          trk0[9][2] = { 410, 530, 800, 850, 800, 850, 800, 850, 800, 850, 800, 850, 815, 885, 815, 885, 815, 885 };   /* @0x8011f590 */
int          trk4[10][2] = { 300, 440, 300, 440, 300, 440, 300, 440, 300, 440, 705, 910, 705, 910, 705, 910, 705, 910, 705, 910 };   /* @0x8011f5d8 */
Draw_SubdivStruct gDiv;   /* @0x8011f628  (bss(zero)) */
int          animation_timer[12];   /* @0x8011f718  (bss(zero)) */
ChunkObjectInfo gChunkObjInfo;   /* @0x8011f748  (bss(zero)) */
CCOORD16     gVertex3d[160];   /* @0x8011f760  (bss(zero)) */
int          stackSpeedUpEnbabledFlag;   /* @0x8013d81c  (bss(zero)) */
/* SYM (rule-8, nfs4-f-v3.txt:192375): `96 Def2 class STAT type ARY CHAR size 8
   dims 1 8 name goffsets` @0x8013d820, and the symbol-table entry (:3390) is
   type `6` (local) not `2` (global) -- i.e. a FILE-SCOPE STATIC of DRAWW.CPP,
   not a linked global.  Only draww.cpp references it (grep-confirmed), so the
   `static` is both SYM-true and safe. */
static signed char  goffsets[8] = { 125, 125, 50, 15, -1, 125, 0, 0 };   /* @0x8013d820 -- MATCH: oracle `lb` (signed byte) at the goffsets[] lookup site; -1 must sign-extend, not zero-extend */
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
 * (both loads are ready at the same cycle and the tie is broken by luid).
 * w46-a7 RE-PROBED at this basin, still 2.  FALSIFIED here (all leave the 2-diff
 * adjacent swap byte-identical, or regress): (a) a zero-insn USE FENCE on a
 * separate `int lt = sd->night_LightningType;` -- the fence costs a REAL insn
 * because `lt` is not yet reg-resident at that point (58 insns, 21 diffs);
 * (b) `lt` as a plain separate statement (2, byte-identical -- copy-propagated);
 * (c) CORRECT index-first pointer arithmetic `**(sd->night_LightningType +
 *     Night_gWeatherLightingTable)` -- 2, byte-identical (the w45 note's 2->22
 *     attempt was a WRONG shape, this one is type-exact and fold canonicalizes
 *     the operand order back);  (d) the same with `lt` split out -- 2;
 * (e) a `row` pointer temp for the first deref -- 4;  (f) reading `*idx` into a
 *     temp first -- 4;  (g) storage-shape menu #4, a per-site VOLATILE view
 *     `extern u_char (*volatile Night_gWLT_vol[2])[256] asm("...")` at file
 *     scope -- 4 (and note a BLOCK-scope extern with an asm label does not
 *     assemble: `Error: bad expression`).
 * ⇒ the lbu-vs-lui order is neither an addressing-shape nor an expression-order
 * question; both insns are ready in the same cycle and BOTH forms of the source
 * produce the same RTL order.  NEW NAMED ANGLE: this is a sched2 ready-list DRAIN
 * tie -- per the w45 grammar the only dial left is a zero-insn USE FENCE placed
 * at the guard-block HEAD on a value that is ALREADY in a register there (sd is
 * in $a2, znear in $t0, zfar in $t1, z in $a3) so the fence costs 0 insns; walk
 * it one statement at a time through the arm.  (My probe used `lt`, which is NOT
 * reg-resident -- that is why it cost an insn; retry with `"r"(sd)`.)
 * w49-a2 EXECUTED that angle -- STILL 2, and the fence route is now CLOSED:
 *   (a) `index = sd->night_LightningType;` through the SYM's outer `index` local:
 *       2, byte-identical (copy-propagated, re-confirming the w45/w46 probe);
 *   (b) the SAME split + a zero-insn fence `__asm__("" : : "r"(sd))` between the
 *       two statements: the lbu DOES move above the lui (the order is reachable!)
 *       but the barrier costs 21 diffs / 58 insns -- with the fence present gcc
 *       loads `*idx` into $a0 (`lh a0,0(a1)`), killing `v` there, so the entry
 *       needs a defensive `addu t3,a0,zero`;
 *   (c) the w48 VOID-tail fence `__asm__("" : : "i"(0))` -- identical 21/58;
 *   (d) the dual/triple-input fence `"r"(sd),"r"(v),"r"(idx)` (meant to keep `v`
 *       alive over the barrier) -- 27/58, the a0 copy survives.
 * => the ORDER is reachable, the COST is not: any barrier at that point pushes
 * `*idx`'s load onto $a0.  NEXT ANGLE: leave the fence out and make the *idx load
 * take $v1 by construction (it is the only value that must NOT be in $a0), e.g.
 * order the table expression so `*idx` is evaluated LAST, or split it into its own
 * statement AFTER the table-base materialization. */
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
 * trade + the dvxy store scheduling only.
 * w49-a2 RE-TEST AT THE 7-DIFF BASIN (lever-order law: falsifications are basin-
 * relative, so the 204 figure above was re-measured): retail's if/else shape --
 * `prim = &sd->GT4Prim;` deleted from the top and written as the `else` arm of
 * `if (doSubdivision == 0)`, with and without a surviving top init -- gates 197
 * (both spellings identical), still the whole-fn $s0 rotation.  The dvxy fix took
 * prim to 29 refs but the else-arm form ALSO shortens its live range, so it keeps
 * out-ranking sd.  The residual 7 is: `sw s1,108(sp)`+`addiu s1,s0,272` hoisted to
 * our prologue vs the oracle's `j T; addiu s1,s0,272` else-arm delay slot, plus the
 * matching bnez/beqz polarity -- i.e. ONE placement, the same trade, now costing 7
 * instead of 174.  Next dial stays the reqdelta above (sd >= 119 refs, or prim's
 * live > 263 IN THE ELSE-ARM FORM). */

void DrawW_DrawQuad(Draw_tGiveShelbyMoreCache *sd,Trk_Quad *inQuad);
void DrawW_kCtrlWorld_High(Draw_tGiveShelbyMoreCache *sd);
void DrawW_StripDraw_High(Draw_tGiveShelbyMoreCache *sd);
void DrawW_DoTrough(DRender_tView *Vi,tBuildEntry *buildList);
void DrawW_WorldSetUpMatrix(matrixtdef *m,MATRIX *mat);
void DrawW_WorldSetUpTranslation(coorddef *t,MATRIX *mat);
void DrawW_ResetAnimationTimer(void);
/* w46-a7: SOLVED -- PASS 33/33.  The lever is the SYMMETRIC if/else result-funnel
 * (see the in-body receipt); the w45 "ours is better-scheduled, permuter or accept"
 * verdict below is RETIRED and kept only as the falsification list.
 * ---- superseded w45-a6 RECEIPT -- residual 4 (ours 31 / oracle 33, ours SHORTER).
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
bool ObjectClipped(DRender_tView *Vi,int ind,coorddef *pCp,Draw_tGiveShelbyMoreCache *sd);
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
 * then re-run posdiff before touching any coloring.
 * w46-a7 -- THE CLOBBER-EVICTION ANGLE IS FALSIFIED: this fn's template carries
 * exactly the same clobber list as DrawQuad's and DoLines' sealed instances
 * ("$12","$13","$14","memory"), so it is not evicting a parameter.
 * QUANTIFIED INSTEAD (tools/rtl_dump.py -dg -dl + prio.py + reqdelta.py):
 *     p80 geomVertices  16 refs / 278 live -> 0.2302   ours $fp   SYM $s3
 *     p81 lineQuad      17 refs / 278 live -> 0.2446   ours $s5   SYM $s6
 *     p85 the 0-counter 16 refs / 276 live -> 0.2319   ours $s7   SYM $fp
 *     p288 = a COMPILER temp `geomVertices + 20` (insn 946, loop/cse-created),
 *           29 refs / 266 live -> 0.4361, and it is what currently holds $s3.
 * 🏆 reqdelta --want "p80=s3,p81=s6,p85=fp" returns ONE dial that fixes ALL THREE:
 *     p80 refs 16 -> 31   (|d| = 15 weighted, i.e. ~7-8 in-loop source refs)
 * NEW NAMED ANGLE: those 15 refs are sitting in p288.  The four vertex copies are
 * written through cse-able base expressions `((int *)&geomVertices[N])[0/1]`, so
 * gcc strength-reduces them into ONE `geomVertices+20` pseudo that outranks the
 * parameter itself.  Re-spell the eight word loads as plain index expressions off
 * the SAME base -- `((int *)geomVertices)[2*N]` / `[2*N+1]` -- (catalog par.A #1,
 * index-form defeats the base hoist): every load then references geomVertices,
 * p288 disappears, and p80 lands well past 31.  Do this BEFORE any coloring work;
 * the whole 4-way rotation is downstream of it.
 * ⚠️ FIRST ATTEMPT FALSIFIED (w46-a7): re-spelling the eight word loads as
 * `((int *)geomVertices)[2N] / [2N+1]` instead of `((int *)&geomVertices[N])[0/1]`
 * is BYTE-IDENTICAL (101) -- gcc folds both to the same address rtx, so the copy
 * block is NOT where p288 comes from.  p288 is `geomVertices + 20`, i.e. offset 20
 * inside CCOORD16[2] (element 2 + 4) -- find the OTHER site that reads at +20/+4
 * within a vertex (a `.light` / second-word access on vt2/vt3) and un-CSE THAT.
 * The required number is unchanged and is the thing to gate on: tools/prio.py must
 * show p80 (geomVertices) at >= 31 refs. */
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
 * tools/reqdelta.py --want "<pseudo>=<reg>,..." for the minimal delta.
 * w46-a7 RE-GATED 70 (count-exact 268/268).  Cluster (1) re-read precisely: the
 * oracle does not merely reverse the emission order, it INTERLEAVES per axis and
 * assigns the registers the other way round -- `lb s4,15; lb s3,16; sra s4;
 * sh s4,368; lb s2,17; sra s3; sh s3,376; lb a1,18; sra s2; ...; sh s2,384` (so
 * s4=fx, s3=fy, s2=fz), while we batch all three loads and then all three stores
 * with s4=fz, s3=fy, s2=fx.
 * FALSIFIED this wave: fx,fy,fz block order (76) · one shared block holding all
 * three temps (70, i.e. neutral) · a 4th duplicate fx block to cross the 3-vs-4
 * qty boundary (72) · a second net-zero `t2++;t2--;` pair on fz (76) · dropping
 * the `tN++; tN--;` net-zero pairs entirely (207 -- they remain load-bearing).
 * NEW NAMED ANGLE (a10 w46 LAW, unused here): a block with EXACTLY 3 quantities
 * is NOT priority-ordered -- local-alloc.c:1588 hand-rolls next_qty <= 3 with a
 * broken comparator -- so for THIS trio the dials are BIRTH ORDER and crossing
 * the 3-vs-4 qty boundary, NOT the ref-step.  My 4th-temp probe crossed the
 * boundary in the wrong direction (a duplicate fx, which also duplicates work);
 * the right probe is a 4th qty that is NOT one of fx/fy/fz -- e.g. hoist the
 * `BWorldSm_slices[slice].forward` base into its own block-local pointer so the
 * block has {base,t0,t1,t2} = 4 qtys and the real comparator runs.  Use
 * tools/qtytrace.py (branch w46-a10) to read the block's qty count FIRST.
 * Cluster (3) is the cheapest independent win left (~10 of the 70): the two
 * quad-row base pointers `lw t4,408(sp)` / `lw t3,456(sp)` are swapped against
 * the oracle and drive six dependent loads. */

void DrawW_BuildSpikeBelt(DRender_tView *Vi,int scale,Draw_DCache *sd);
void DepthCue_Init(void);


/* ---- DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:235-282] SLD-VERIFIED ---- */
/* PsyQ libgpu P_TAG head word (addr:24 | len:8) -- the SDK addPrim()/getaddr()
   house idiom the retail OT-link code was written with (w45-a6). */
typedef struct { unsigned addr : 24, len : 8; } DrawW_PTag;

void DrawW_AddSubdividPrimGT4(POLY_GT4 *prim,Draw_SVertex *v0,Draw_SVertex *v1,Draw_SVertex *v2,Draw_SVertex *v3,
               Draw_tGiveShelbyMoreCache *sd)

{
  /* SYM (rule-8, nfs4-f-v3.txt @0x800C5028): the retail source is FOUR sibling
     block scopes, each re-declaring `a,b,c,d` with the block's own type --
       blk1 `long a,b,c,d`   ($2/$3/$8/$9)   RGBA words
       blk2 `long a,b,c,d`   ($2/$3/$8/$9)   XY   words
       blk3 `short a,b,c,d`  ($2/$3/$5/$6)   UV   halfwords
       blk4 `u_char a; u_short b,c` ($2/$3/$5) code/tpage/clut
     -- not one flat fn-scope temp set.  Restored; gate-verified. */
  /* MATCH: field-fusion + load-4/store-4 (see GT3).  POLY_GT4 stores v2 in slot 3 (+0x28)
     and v3 in slot 2 (+0x1C) -- the screen-quad vertex order. */
  *(u_char *)((int)&prim->tag + 3) = 0xc;
  { long a,b,c,d;
    a = *(u_int *)&v0->r;  b = *(u_int *)&v1->r;  c = *(u_int *)&v2->r;  d = *(u_int *)&v3->r;
    *(u_int *)&prim->r0 = a;  *(u_int *)&prim->r1 = b;  *(u_int *)&prim->r3 = c;  *(u_int *)&prim->r2 = d; }
  { long a,b,c,d;
    a = *(u_int *)&v0->dvx;  b = *(u_int *)&v1->dvx;  c = *(u_int *)&v2->dvx;  d = *(u_int *)&v3->dvx;
    *(u_int *)&prim->x0 = a;  *(u_int *)&prim->x1 = b;  *(u_int *)&prim->x3 = c;  *(u_int *)&prim->x2 = d; }
  { short a,b,c,d;
    a = *(u_short *)&v0->u;  b = *(u_short *)&v1->u;  c = *(u_short *)&v2->u;  d = *(u_short *)&v3->u;
    *(u_short *)&prim->u0 = a;  *(u_short *)&prim->u1 = b;  *(u_short *)&prim->u3 = c;  *(u_short *)&prim->u2 = d; }
  { u_char a;  u_short b, c;
    a = (sd->GT4Prim).code;  b = (sd->GT4Prim).tpage;  c = (sd->GT4Prim).clut;
    prim->code = a;  prim->tpage = b;  prim->clut = c; }
  return;
}

/* ---- DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:316-357] SLD-VERIFIED ---- */
void DrawW_AddSubdividPrimGT3(POLY_GT3 *prim,Draw_SVertex *v0,Draw_SVertex *v1,Draw_SVertex *v2,
               Draw_tGiveShelbyMoreCache *sd)

{
  /* SYM (rule-8, nfs4-f-v3.txt @0x800C50B4): four sibling block scopes, each
     re-declaring `a,b,c` with the block's own type -- `long` (RGBA), `long`
     (XY), `short` (UV), `u_char a; u_short b,c` (code/tpage/clut).  Restored;
     gate-verified. */
  /* MATCH: field-fusion + load-3/store-3 -- the oracle copies each vertex's RGBA as one
     32-bit word (v+0xC), XY as one word (v+0x8), UV as one halfword (v+0x6).  Loading all
     three vertices into SEPARATE temps before storing avoids the load-delay nop that
     `lw v0;nop;sw v0` (single-reg reuse) emits per copy. */
  *(u_char *)((int)&prim->tag + 3) = 9;
  { long a,b,c;
    a = *(u_int *)&v0->r;  b = *(u_int *)&v1->r;  c = *(u_int *)&v2->r;
    *(u_int *)&prim->r0 = a;  *(u_int *)&prim->r1 = b;  *(u_int *)&prim->r2 = c; }
  { long a,b,c;
    a = *(u_int *)&v0->dvx;  b = *(u_int *)&v1->dvx;  c = *(u_int *)&v2->dvx;
    *(u_int *)&prim->x0 = a;  *(u_int *)&prim->x1 = b;  *(u_int *)&prim->x2 = c; }
  { short a,b,c;
    a = *(u_short *)&v0->u;  b = *(u_short *)&v1->u;  c = *(u_short *)&v2->u;
    *(u_short *)&prim->u0 = a;  *(u_short *)&prim->u1 = b;  *(u_short *)&prim->u2 = c; }
  { u_char a;  u_short b, c;
    a = (sd->GT4Prim).code;  b = (sd->GT4Prim).tpage;  c = (sd->GT4Prim).clut;
    prim->code = a;  prim->tpage = b;  prim->clut = c; }
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
  int minz; /* SYM-CODEGEN-CARRIER: minz -- running-min funnel required by the measured retail guard chain */
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
  /* w64-a2 12D DEAD-PSEUDO STAGING: the SYM gives BOTH `v4` (subdivide arm) and
     the leaf `prim` (else arm) as REG $s3.  They live in mutually exclusive arms,
     so retail carried them in ONE pseudo -- v4 IS the carrier the leaf prim is
     staged through.  Declared fn-scope here and cast at the leaf uses; see the
     receipt block below.  35 @587 (one SHORT) -> 26 @588 COUNT-EXACT. */
  Draw_SVertex *v4;   /* SYM: REG $s3 -- shared with the leaf POLY_GT4 *prim */

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
    /* v4 (SYM REG $s3) is declared at FUNCTION scope -- see the 12D staging note */
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
       w46-a7 SUPERSEDES the 'allocator-internal floor' verdict below with numbers.
       RE-GATED 35, ours 587 / oracle 588 (ours is ONE insn SHORT).  The residual
       is the v4..v8 index chain: retail keeps `n` (after `n = n + 1`) in $a3 and
       finally MUTATES it in place (`addiu a3,a3,3`), computing each `+1/+2/+3`
       off $a3; we keep it in $v1.  Same insns, one register apart, plus a
       one-slot add-before-shift ordering difference at the head of the chain.
       🏆 THE COUNT-EXACT BASIN EXISTS (new): declaring ONE extra block-local
       `int m;` and driving v5..v8 off `m = n` makes the function 588 == 588
       insn-EXACT at 38 diffs -- i.e. the missing instruction is bought by
       crossing the block's qty count, exactly the a10 w46 LAW (a block with
       EXACTLY 3 quantities is NOT priority-ordered: local-alloc.c:1588 hand-rolls
       next_qty <= 3 with a broken comparator, so birth order and the 3-vs-4
       boundary are the dials, not the ref-step).  38 > 35 today, but 35 is
       count-INEXACT and therefore cannot be a floor under the project bar --
       WORK FROM THE 588/588 BASIN.  Falsified from it this wave: m assigned
       before `n = n + 1` (41), m mutated for v8 (45), the copy+mutate form (169),
       `n += 3` early (35, count-inexact), `n += 4` early (35, count-inexact).
       NEXT: read the block's qty count + birth order with tools/qtytrace.py
       (branch w46-a10) from the 588/588 basin and move the BIRTHS, not the refs.
       ---- superseded: permuter candidate (not run here -- fn is large/GTE-heavy, see the two
       already-running permuter jobs on the smaller Night_* fns for the
       time-budget tradeoff). */
    /* w53-a1 RE-GATE + 5 MORE FALSIFICATIONS FROM THE 588/588 BASIN.  Base re-gated
       35 @587 (ONE SHORT); the w49 `{ int m = n; ... }` block-local basin re-
       measured at exactly 38 @588/588, so both numbers are current, not stale.
       In that basin the residual is now TWO clusters only:
         (a) the whole v5..v8 pivot chain in `$v1` where retail keeps it in `$a3`
             and mutates it in place (`addiu a3,a3,3`), plus one lowering variant
             (ours `sra v1,16; sll v0,4`, retail `sll v0,16; sra v0,12` -- the same
             value, a combine tie); and
         (b) the OT-link prim pointer: ours `lw a0,4(s2)`, retail `lw s3,4(s2)`
             with an extra `addu a0,s3,zero` -- a CALLEE-saved home for the prim.
       NEW FALSIFICATIONS (all from the 588/588 basin, all reverted):
         + a 2nd distinct block-local `int k` carrying the +2 index      : 38
         + v5 driven off `n` while v6..v8 use `m`                        : 38
         + the +1 index precomputed into `int i1` before v5              : 38
         + `m` MUTATED in place for v8 (`m = m + 3; v8 = &v[(short)m];`) : 163 @587
       => the 3<->4 qty-boundary dial does NOT move this block (three separate
       spellings of "add one more distinct pseudo" are byte-identical), so the
       remaining dial really is the BIRTH ORDER inside the hand-rolled next_qty<=3
       comparator -- qtytrace.py from the 588/588 basin, as w49 said.  Cluster (b)
       is independent and is the same prim-in-a-callee-saved-reg question as
       DrawW_DrawQuad's p141; crack it there first, it is a smaller function.
       ---- w61-a2 (2026-08-15): CLUSTER (b)'s SHAPE IS NOW SOURCE-REACHABLE, and
       the DrawQuad cross-reference above is RESOLVED (DrawQuad sealed this wave by
       an inverted default -- a different mechanism, it does NOT transfer here).
       THE DEVICE: a READ-ONLY FENCE ON `prim` AFTER the AddSubdividPrimGT4 call
       (`__asm__("" : : "r"(prim));` between the call and the `return`).  It makes
       prim cross the call, so it stops being a single-block local qty and takes a
       CALLEE-SAVED home, and the arg copy retail has appears:
           ours before : lw a0,4(s2) ... sll t4,a0,8 ; sw t6,0(a0)   [no copy]
           ours after  : lw s0,4(s2) ... sll t4,s0,8 ; sw t6,0(s0) ; addu a0,s0,zero
           retail      : lw s3,4(s2) ... sll t4,s3,8 ; sw t6,0(s3) ; addu a0,s3,zero
       i.e. the whole shape matches and ONLY the callee-saved INDEX is wrong
       ($s0 vs $s3).  Gate: 35 @587 (ONE SHORT) -> 36 @588 COUNT-EXACT.  NOT LANDED
       (hard-floor-basin rule: +1 authoritative diff and I could not close the
       register in the same pass), but the basin is the right one to resume from.
       NAMED ANGLE (next pass): prim now takes the LOWEST FREE callee-saved, i.e.
       nothing live in the GT4 tail block conflicts with $s0/$s1/$s2; retail's $s3
       means its prim allocno DOES conflict with those three.  So the dial is a
       CONFLICT, not a priority: run allocsim on the 588/588 basin and look for the
       $s0 owner (the `r_div->v` base used by the recursion arm, dead in the tail)
       -- lengthening THAT value's range through the tail, or giving prim a def
       that dominates the backface block WITHOUT moving the load, is the target.
       FALSIFIED this wave from the 587 basin: hoisting `prim = ...cprim.PrimPtr;`
       above the `if (subDivide != 0)` block 42 @586, the same + an opacity fence
       at the def 41 @587, hoist + tail read-fence 475 @601 (catastrophic -- the
       hoisted load re-schedules the whole backface block).  From the 588 basin:
       two and three stacked tail read-fences 36 (no further move), a tail OPACITY
       fence 36 (identical) -- so the fence COUNT/flavour is not the dial either.
       ---- w62-a2 (2026-08-15): THE 36/588 BASIN IS NOW READ OFF THE INSTRUMENTED
       cc1plus, and cluster (b) is a QUANTIFIED ALLOCNO-ORDER problem, not a
       conflict one.  Lab fidelity for this fn is IDENTICAL 517/517 (real CC1PLPSX
       vs C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe, so the trace is quotable, 12H).
       global.c hands the callee-saved registers out in this order (allocno pri =
       floor_log2(refs)*refs/live):
           p90  prim   refs 6  live 54  calls 1  -> reg 16 ($s0)   pri .2222  <-- 4th
           p80  sd     refs 25 live 752 calls 13 -> reg 18 ($s2)   pri .1330
           p187 v-ptr  refs 11 live 259 calls 10 -> reg 19 ($s3)   pri .1274
           p186/188/190/189                      -> 20/21/22/23
           p82         refs 18 live 686           -> reg 17 ($s1)
           p84         refs 18 live 730           -> reg 30 ($fp)
       prim is allocated FOURTH and simply takes the LOWEST free callee-saved.
       Retail's prim = $s3 = the register p187 takes here, and prim/p187 live in
       MUTUALLY EXCLUSIVE arms (the GT4 tail vs the recursion arm) so they never
       conflict -- i.e. retail's prim was simply handed out LATER.  The dial is
       therefore prim's PRIORITY, and the razor is exact: prim must fall below
       p187's .1274, which at 6 refs needs live > 94 (today 54) or at 3 refs any
       live > 23.  Every ref dial goes the WRONG way (7 refs = .2593, 8 = .4444),
       and the only live-lengthening device (hoisting the PrimPtr load above the
       backface block) is already falsified above at 42/475.  NEXT INSTRUMENT: a
       zero-insn live-range EXTENDER that adds no ref (the 13B 4-witness request)
       -- until it exists this is a priced hardness certificate, not a floor. */
    v4 = &r_div->v[n];
    n = n + 1;
    {
      /* w64-a2 (26 -> 8 @588/588, ALL REGISTERS NOW EXACT): the v5..v8 index
         chain is a BLOCK-LOCAL qty question, and the dial is the qty SET, not
         the ref/live counts.  With four indices derived straight off `n` the
         three derived temps are pairwise DISJOINT, so local-alloc's ascending
         find_free_reg collapses them all onto $v0 and hands `n` the next free
         reg, $v1; retail keeps the chain base in $a3, which needs BOTH $v0 and
         $v1 blocked over its window.  A single named pivot `q = n + 1` supplies
         the extra simultaneously-live qty (13A block-local anchor / w46 3-QTY
         boundary): measured, all count-exact 588/588 --
             base (all four off `n`)                    26
             q = n + 2  (v7/v8 off q)                   24
             q = n + 2 and q = n + 3                    22
             q = n + 2, q mutated for v8                24
             two pipelined temps i1/i2 (retail's own
               overlapping-live shape, 3 spellings)     26 / 26 / 28
             q = n + 1  (v6/v7/v8 off q)                 8   <-- landed
         Residual 8 = FOUR insns (addiu a3,s4,1 / addiu t8,a3,4 / addiu v0,a3,2 /
         addiu a3,a3,3) emitted at different POSITIONS -- identical opcodes and
         identical registers, i.e. a pure sched2 emission-order residual, no
         longer an allocation one.
         ---- W70 (2026-08-16): the w45 ZERO-INSN FENCE WALK is FALSIFIED for this
         residual, and so is every remaining SOURCE SPELLING of the chain.  Base
         re-gated 8 @588/588.  Exact residual re-read: retail issues each index
         `addiu` ONE GROUP EARLIER than we do -- retail runs
         [addiu q][sll][addiu n+4][sra][addu] where ours runs
         [sll][sra][addu][addiu q][addiu n+4]; opcodes and registers match 1:1.
         FENCE WALK (36 probes: 4 devices x 9 statement slots -- read-only
         `asm("":: "r"(n))` / `"r"(q)` / `"i"(0)`, and the w47 opacity fence
         `asm("":"=r"(n):"0"(n))` -- placed before v4=, after v4=, after n=n+1,
         after q=, after each of v5..v8, and after n=n+4): EVERY placement
         regresses (best 9, then 14/16/32/36/60/76/149) and, decisively, EVERY
         one is +2 insns @590 -- the fence is NOT zero-insn on a `short` here, so
         it can never be count-neutral in this block.  SPELLINGS also falsified
         (all count-checked): `v4 = &r_div->v[n++];` 8 (BYTE-IDENTICAL -- gcc
         normalises it); `n = n + 4;` moved inside the block after v5 8
         (BYTE-IDENTICAL); `n = n + 1; v4 = &r_div->v[(short)(n-1)];` 26; and the
         single-chain-base form (drop the `n=n+1` mutation, drive v5..v8 off
         `q = n+1` and set `n = q+4`) 143 @587 -- the in-place `n = n + 1` IS what
         mints retail's `$a3` chain base and must stay.
         => nothing at the SOURCE layer reaches this; it is a sched2 ready-list
         DRAIN question.  NEXT INSTRUMENT (named): -dS/-dR sched dumps on the
         588/588 basin (lab fidelity for THIS fn is IDENTICAL 517/517 per w62-a2,
         so the instrumented cc1plus IS quotable here -- unlike BuildObjectFacets
         and DoTrough), read the ready-list order at the four sites.
         ---- w74-a1 (2026-08-23) THE SCHED2 DUMP IS IN; the residual is re-classed
         from a ready-list DRAIN question to a PRE-SCHED2 CHAIN-ORDER (LUID) one.
         CC1PLPSX -O2 -G4 -dR, basic block 21 (insns 259..360).  The scheduler runs
         BACKWARDS (T-1 = the last insn, T-38 = the first) and rank_for_schedule
         (sched.c:2415) breaks ties by INSN_LUID, lower LUID picked first, i.e.
         PLACED LATER.  The four residual insns are 268 (`addiu a3,s4,1`),
         325 (`addiu t8,a3,4` = the new n), 300 (`addiu v0,a3,2`) and 311
         (`addiu a3,a3,3`).  At T-31 the ready list is `325 (2) 333 (1) 331 (1)
         264 (2)`; both 325 and 264 (`addu s3,v0,s0`, the v4 address) carry
         priority 2, so the tie falls through to LUID -- and OURS picks 325,
         retail picks 264.  Since the insn set, the registers and the dependence
         lists are identical on both sides, the ONLY input that can differ is the
         POST-SCHED1 chain order: our sched1 already hoisted 325 above 264.
         CONSEQUENCE: no sched2-level device can reach this (the tie is decided by
         data the pass merely reads), and the fence walk's uniform failure is
         explained -- the dial is sched1's placement of `n = n + 4`, which is why
         moving that statement inside the block was BYTE-IDENTICAL.  NEXT
         INSTRUMENT (named): the -dS (sched1) ready lists for the same block, to
         find what makes 325 rise; anything that keeps it below 264 in the sched1
         output lands all four insns at once.
         ---- W75-A5 (2026-08-23) THE -dS DUMP IS IN; the w74 reading is CORRECTED
         in two places and the residual is re-classed AGAIN, one pass further up.
         Base re-gated 8 @588/588 (posmis 13).
         (1) TIE DIRECTION REFUTED.  rank_for_schedule (sched.c:2455-2458) returns
             `INSN_LUID (tmp) - INSN_LUID (tmp2)` with tmp = *y and tmp2 = *x, so
             the sort is DESCENDING by LUID and the pick is ready[0] -- the HIGHER
             LUID wins, i.e. the insn appearing LATER in the pass's input chain is
             picked first and therefore PLACED LATER.  w74 recorded "lower LUID
             picked first"; every conclusion drawn from that direction is inverted.
             The correct statement: ours picks 325 at T-31 because LUID(325) >
             LUID(264); to match retail the v4 ADDRESS must sit AFTER `n = n + 4`
             in the pass's input.
         (2) SCHED1 MAKES THE IDENTICAL CHOICE, so it is not the dial either.
             -dS, same basic block 21 (258..360): `ready list at T-31: 325 (1)
             264 (1), now 325 264` -- bit-for-bit the sched2 picture, and the
             sched1 OUTPUT chain reads `(insn 268 264 325 ...)`, i.e. 264 -> 268 ->
             325, plain source order.  Neither scheduler moved anything here; both
             merely preserved the chain they were handed.  The dial is therefore
             the PRE-SCHED1 (cse/loop/combine) chain order, which is source order.
         (3) THE REORDER IS REACHABLE BUT COSTS THE MUTATION INSN (measured).
             Moving `v4 = &r_div->v[n]` BELOW `n = n + 4` via a `short n0 = n`
             snapshot DOES flip the pair -- the emitted head becomes
             `addiu a3,v0,1; addiu s4,a3,4; sll v0,v0,16` (retail's `addiu`-before-
             `sll` shape) -- but EVERY snapshot spelling lands at 587, ONE INSN
             SHORT, and cascades the colouring:
               n0 snapshot, n=n+4 early, v4 last ............ 235 @587
               same + q before n=n+4 ....................... 235 @587
               same + v5 driven off (short)(q-1) ........... 235 @587
               n0 + nb + a dedicated `newn` local, `n = newn`
                 assigned last (keeps the param store late)   143 @587
               the same with q computed before newn ........ 143 @587
               n0 assigned in-place after `n = n + 1` ...... 101 @589
             The lost insn is the same one the w70 "single-chain-base form" lost:
             the in-place `n = n + 1` mutation that mints retail's $a3 and the
             ARG-home store pairing.  So the requirement is contradictory at the
             source layer -- retail's chain order needs v4's address emitted after
             the new-n, and our only way to emit it later destroys the mutation.
             Also re-measured inert/worse this wave: `short nb = n; n = n + 4;`
             hoisted above v5..v8 (8, BYTE-IDENTICAL); the four indices spelled as
             three named temps interleaved with their uses (28).
         (4) THE 21C(3)/(4) ACCESS-SPELLING AXIS IS INERT HERE (measured this
             wave, all BYTE-IDENTICAL at 8 @588):
               v4 = (Draw_SVertex *)(((int)n * 16) + (int)r_div->v);   8
               v4 = (Draw_SVertex *)(((int)n << 4) + (int)r_div->v);   8
               v4 = (Draw_SVertex *)((int)r_div->v + ((int)n * 16));   8
               v4 = (Draw_SVertex *)(((int)n * 16) + (int)r_div);      8
             i.e. index-term-first, mult-vs-shift and operand side all fold back
             to the same ARRAY_REF here -- the lever that sealed
             Hud_BuildNumbers0/InGame_GetPSXPadValue does not reach this site.
         NEXT INSTRUMENT (named, and it is now a PRE-SCHED question): -df / -dc on
         this block to find which pass FIXES the v4-address position in the chain,
         and specifically whether the ONE insn every snapshot form loses (the
         in-place `n = n + 1`) can be preserved while the v4 address still moves
         below the new-n -- that is the exact contradiction to break.
         ---- W76-A5 (2026-08-23): THE FOLD-BACK FAMILY IS FALSIFIED TOO; stays 8.
         The untried cell -- spell v4's index off the ALREADY-MUTATED n so the
         statement can sit chain-AFTER the new-n while cse folds the constant
         back to the old register (s4) at zero insns -- does NOT fold:
           v4 = &r_div->v[(short)(n - 5)] placed after `n = n + 4` .. 101 @589
           v4 = &r_div->v[(short)(n - 1)] between q-block and n+4 ...   9 @589
           v4 = &r_div->v[(short)(n - 1)] right after n+1 (w70 cell
             re-priced at this basin) ..............................  26 @588
         The addiu -K survives in all three: cse cannot simplify
         (plus (subreg:HI promoted-n) -K) back to the old SImode reg through
         the PROMOTE_MODE truncation, so every after-mutation spelling is +1
         insn -- the source layer stays contradictory (the 9 @589 cell is the
         closest order-wise and is exactly one dead addiu over).  The named
         instrument stands: -df/-dc chain forensics, plus one NEW fact for it --
         retail's interleave ([addiu n+1][sll s4][addiu n+4][sra][addu]) puts
         `addiu t8,a3,4` INSIDE v4's 3-insn scale chain, which NO statement
         order can produce at expand time; combined with W75's proof that both
         scheds preserved their input here, the divergence must be created
         between expand and sched2 on the RETAIL side only -- check reload-
         inserted ARG-home reloads (the lhu s4 reload is a RELOAD insn, so
         sched2's luid picture differs from sched1's) before any more source
         probing.
         DO NOT re-run: the fence walk (w70, 36 probes, all +2 insns on a short),
         the six index-chain spellings (w70), or any n0/nb/newn snapshot (above). */
      short q = n + 1;
      v5 = &r_div->v[n];
      v6 = &r_div->v[q];
      v7 = &r_div->v[(short)(q + 1)];
      v8 = &r_div->v[(short)(q + 2)];
    }
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
    /* the leaf prim is staged through `v4` (SYM: both are REG $s3) -- 12D */

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
    v4 = (Draw_SVertex *)(sd->head).cprim.PrimPtr;
    /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE (fastmovf.c family; $t4/$t5/$t6
     * scratches): slot = sd->head.cprim.LastPrim + sd->otz; sd->PrimPtr = prim+1 (0x34);
     * prim->tag = slot->addr24 | (0x0C<<24); slot->addr24 = prim.  Operand %2 = &sd->otz
     * (the expander read otz through a pointer arg -- the compiler materializes
     * `addiu v0,s2,0x94`, reorg copies it into the joining branches' delay slots). */
    /* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
     * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
     * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
     * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
     * Gate-lane object is byte-identical (proven by hash); see
     * scratchpad/w64a20/RECEIPTS.md. */
    __asm__ volatile(
        "lw	$12,0(%2)
	lw	$13,0(%1)
	addiu	$14,%0,52
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4(%1)
	lwl	$14,2($13)
	lui	$12,0x0C00
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,%0,8
	sw	$14,0(%0)
	swl	$12,2($13)"
        : : "r"(v4), "r"(sd), "r"(&sd->otz)
        : "$12", "$13", "$14", "memory");
    /* w64-a2 PRICED REF DIAL (predicted N=5, measured N=5 -- allocsim-by-hand on
       the real CC1PLPSX -dl/-dg dump).  After the 12D staging the ONLY residual
       was a pure $s2<->$s3 SWAP: merged v4+prim = p91 (refs 14 / live 265 /
       pri .1585) sorted ABOVE sd = p80 (refs 25 / live 752 / pri .1330) and took
       $s2 first; retail hands sd $s2 and the merged pseudo $s3.  A multi-operand
       read-only fence buys +1 REG_N_REFS per operand at ONE barrier and ZERO
       bytes (06B/05C): N operands make sd (100+4N)/(752+N) and p91 42/(265+N);
       the crossing is at N=5 (N=4: .1534 vs .1561 = still wrong; N=5: .1585 vs
       .1556 = flip).  MEASURED, all count-exact 588/588: N=1..4 -> 120 diffs,
       N=5..8 -> 26.  Landed the modelled MINIMUM.  The natural-source alternative
       (retail simply re-reads `sd` 5 more times than our CSE'd body does) is the
       open angle that would retire this device. */
    __asm__("" : : "r"(sd), "r"(sd), "r"(sd), "r"(sd), "r"(sd));
    DrawW_AddSubdividPrimGT4((POLY_GT4 *)v4,v0,v1,v2,v3,sd);
    return;
  }
}

/* ---- DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR  [DRAWW.CPP:593-606] SLD-VERIFIED ---- */
void DrawW_LoadPrecVECTOR(Draw_SVertex *v,VECTOR *dv)

{
  int x;
  int y;
  int z;
  /* SYM (rule-8, nfs4-f-v3.txt @0x800C5BB4): the block declares a FOURTH local
     `temp` (class REG, type LONG) whose home is $3 -- the same register `y`
     lives in, i.e. the packed vx:vy word that overwrites y's value.  Restored
     as a real C variable; gate-verified codegen-neutral (PASS held). */
  long temp;

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
  temp = y | (x & 0xffffU);
  *(u_int *)&v->vx = temp;
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
    if ((((1000 < v0->dvy) || (v0->dvx < -1000)) || (v0->dvy < -1000)) || (v0->vz < 0x65))
    goto DrW_SubSetup_v0Alpha;
  }
  else {
DrW_SubSetup_v0Alpha:
    v0->a = '\x01';
  }
  v1->a = '\0';
  if (v1->dvx < 0x3e9) {
    if (((1000 < v1->dvy) || (v1->dvx < -1000)) || ((v1->dvy < -1000 || (v1->vz < 0x65))))
    goto DrW_SubSetup_v1Alpha;
  }
  else {
DrW_SubSetup_v1Alpha:
    v1->a = '\x01';
  }
  v2->a = '\0';
  if (v2->dvx < 0x3e9) {
    if (((1000 < v2->dvy) || (v2->dvx < -1000)) || ((v2->dvy < -1000 || (v2->vz < 0x65))))
    goto DrW_SubSetup_v2Alpha;
  }
  else {
DrW_SubSetup_v2Alpha:
    v2->a = '\x01';
  }
  v3->a = '\0';
  if (v3->dvx < 0x3e9) {
    if ((((v3->dvy < 0x3e9) && (-0x3e9 < v3->dvx)) && (-0x3e9 < v3->dvy)) && (100 < v3->vz))
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
    /* MATCH (w50-a2): the lui/addiu that materializes &Night_gWeatherLightingTable
       must issue AFTER the `lbu $v0,269($a2)` index load, not before it (the same
       lui-vs-load ready-list tie as DrawW_BuildObjectFacets` goffsets[] site in
       this TU).  Splitting the index into its own statement is NOT enough (still
       2 diffs, byte-identical) -- it is the w47 OPACITY FENCE on the split temp
       that pins the issue order (w45: the fence is a sched-issue-position
       FIXPOINT -- insns before it cannot sink past, insns after cannot float
       above; here the address materialization is "after").  Zero insns: lt is
       already register-resident.  FALSIFIED: split with no fence (2), split with
       a USE-only fence `: : "r"(lt)` (21, count 58 -- it forces a real copy), a
       void `: : "i"(0)` fence before the statement (2, byte-identical). */
    int lt /* SYM-CODEGEN-CARRIER: lt -- identity laundering moves the table-byte load to the retail issue slot */ = sd->night_LightningType;
    __asm__("" : "=r"(lt) : "0"(lt));
    *idx = (u_short)(*Night_gWeatherLightingTable[lt])[*idx];
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
  long color;

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
        color = d;
      } while (0);
    }
  }
  else {
    /* SYM (rule-8, nfs4-f-v3.txt @0x800C609C) records the else arm's two GTE
       scratch VECTORs under their own block-scoped names -- `tempnight`
       (AUTO -0x30, block line 66) and `tempcop` (AUTO -0x30, block line 74) --
       all three (with `temp0`, block line 3) sharing frame slot -0x30.
       FALSIFIED (W70): writing them as real block-local `VECTOR tempnight;` /
       `VECTOR tempcop;` is NOT codegen-neutral on cc1plus 2.8.0 -- it does NOT
       overlap the disjoint scopes and the frame grows 64 -> 80 (PASS -> 44
       diffs @279/279, every offset shifted).  Retail's single -0x30 slot is
       only reproducible with ONE variable, so `temp0` carries all three roles
       here; the SYM names are recorded in this comment instead. */
    if ((sd->nightFlags & 1U) != 0) {
      /* SYM-CARRIER: tempnight -- `temp0` must carry this disjoint inline role;
         a second VECTOR grows the frame and regresses PASS to 44 diffs. */
      gte_SetRotMatrix(&sd->matNight);
      gte_SetTransMatrix(&sd->matNight);
      gte_ldv0(vt0);
      gte_rt();
      gte_stlvnl(&temp0);
      Night_NightCalc(&temp0, &sd->light, sd);
    }
    if ((sd->nightFlags & 2U) != 0) {
      /* SYM-CARRIER: tempcop -- same measured shared-slot constraint as tempnight. */
      gte_SetRotMatrix(&sd->matCop);
      gte_SetTransMatrix(&sd->matCop);
      gte_ldv0(vt0);
      gte_rt();
      gte_stlvnl(&temp0);
      Night_NightCopCalc(&temp0, &sd->light);
    }
    color = *(u_long *)&Chunk_lightTable[sd->light];
    *(u_long *)&prim->r0 = color;
    *(u_long *)&prim->r1 = color;
    *(u_long *)&prim->r2 = color;
  }
  *(u_long *)&prim->r3 = color;
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
  u_long l2;
  int depth_index;
  int primPtr;
  int depth_avg;
  short ts31;
  u_long l3;
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
  u_long l0;
  u_long l1;
  
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
  /* ================= RECEIPT (w53-a1) -- **THE 7 IS NOW A SOLVED PROBLEM WITH A
     PRICED DELTA**: the retail if/else form + a then-arm void fence reaches
     **PASS 592/592** the moment `sd` carries 128 references.  Everything below is
     measured at this basin (base 7 diffs, ours 591 / oracle 592 = ONE SHORT).
  
     THE THREE-PART MECHANISM (each part measured on its own):
       1. RETAIL ARM ORDER + NO TOP DEFAULT --
            if (doSubdivision != 0) { prim = &sd->GT4Prim; }
            else { prim = cprim.PrimPtr; <OT-link asm> }
          alone this is the long-known 197 (the p141/p80 $s0<->$s1 flip).
       2. VOID FENCE AT THE THEN-ARM HEAD -- `__asm__("" : : "i"(0));` as the
          FIRST statement of the `prim = &sd->GT4Prim;` arm.  Without it reorg
          EAGER-STEALS the arm's single `addiu $s1,$s0,0x110` into the guard's
          delay slot and jump.c then deletes the now-empty arm's `j` -- which is
          EXACTLY the missing instruction.  With the fence the arm is 2 RTL insns,
          the steal is impossible, and the oracle's
              beqz $s5,OT ; [ds] addiu $v0,$s0,0x94 ; j CONT ; [ds] addiu $s1,$s0,0x110
          appears verbatim.  Placement matters: head-of-then = the win; head-of-else
          = no-op (11); tail-of-then = +1 insn (593/11); both arms = 593/9; the
          `eq` arm order with the same fence = 593/13.
       3. THE ALLOCNO RAZOR, PRICED EXACTLY.  With (1)+(2) the ONLY blocker is
          p141(prim) 24 refs / 114 live = pri .8421 out-ranking p80(sd) 62/846 =
          .3664, so prim takes $s0.  Sweeping ZERO-INSN read fences `__asm__("" : :
          "r"(sd))` at the function tail (each = +1 REG_N_REF, 0 bytes emitted,
          verified against tools/prio.py: 24 fences -> refs 62->86 exactly):
              +64 refs (126) : 194      +65 (127) : 194
              +66 refs (128) : **PASS 592/592**   +67/68/69/70/80/100/140 : PASS
          The step is at **128 = 2^7**: floor_log2 goes 6->7 and sd's priority
          jumps .74 -> .87 past prim's .8421.  This is the w44 REF-STEP LAW in its
          purest measured form (one reference either side of a power of two).
  
     SO THE REQUIRED DELTA IS: **p80(sd) REG_N_REFS 62 -> 128 at zero insns**
     (or, equivalently, prim's refs 24 -> 13, or prim's live 114 -> >273).
     NOT LANDED because 66 fences is scaffolding, not source.  The honest
     inflators were priced and all fall short -- recorded so nobody re-derives:
       * un-caching every sd-> read the recon caches (geomVertices,
         currentQuadMat, primPtr, depth_avg, save_pre_otz) is worth ~+6 refs;
         the whole function only contains 68 `sd` source tokens.
       * the do{}while(0) DEPTH wrapper over the prim-FREE mid span (`primPtr =
         sd->artInfo->pPmx;` .. the sd->offset if/else, ~12 sd refs) MEASURED:
         D=2 204, D=3 204, D=4..7 234 -- it lifts every OTHER pseudo in the span
         too (the w45 DEPTH-ASYMMETRY trap), so it moves AWAY from the razor.
       * prim's live cannot be stretched instead: an early (uninitialised) read
         fence at the function head is a NO-OP (194 at 1/2/3 fences), and fences
         placed just before the `if (doSubdivision != 0)` block add ZERO live
         length (prim's natural death is already there).  Fences at the function
         TAIL do work (live 114 -> 192, prio.py-verified) and with sd at 87 refs
         that basin gates **6 count-EXACT 592/592** -- residual = ONLY
         `lbu s3,263(s0)` vs `lbu s1,263(s0)` (zeroTransFlag), because holding
         prim live to the end is exactly what denies $s1 to zeroTransFlag.  So the
         live-length route and the register it needs are MUTUALLY EXCLUSIVE; the
         ref route is the only one that can reach 0.
     NEXT ANGLE (named): a ZERO-INSN prim REF-SHED to <=13.  The 24 refs are 4
     `&prim->xN` + 4 `&prim->uN` + 8 colour (4 per exclusive arm) + tag + code +
     2 clut + the NightColorCalc arg + the asm operand + 2 defs.  Group bases
     (`long *px = &prim->x0; px[0]/px[3]/px[6]/px[9]`) each shed 3 refs but cost
     an `addiu`; a base that costs NOTHING (one already materialised in the block,
     or a bases pair that cross-jump-merges) is the missing piece.  Alternatively
     route it through the permuter from the 6-diff count-exact basin.
   RAGE-RACER CROSS-CHECK (w53-a1; C:/Temp/rage-racer-decomp, 100% byte-exact,
   gcc-2.6.3 PsyQ-3.x -- shapes transfer, registers do not).  Its matched
   render code (src/main/PAL/main/track/draw_terrain_cells.c DrawSkyBackground,
   src/main/PAL/main/render/draw_prims.c SetDrawClipRect) confirms the shape
   this receipt is asking for: ONE scratchpad STRUCT POINTER local
   (`SkyRenderScratchpad *scratch = (SkyRenderScratchpad *)SCRATCHPAD_ADDR;`)
   reached as `scratch->field` at EVERY use -- Namco never caches a scratchpad
   field into a second local, so that one pointer legitimately carries a very
   high reference count, which is exactly the p80(sd) >= 128 this function
   needs.  RR also declares its packet cursor MID-declaration-list with an
   initializer (`u8 *packetCursor = scratch->packetCursor;` sitting between
   two plain s32 decls) -- decl POSITION as frame layout, w41 -- and uses the
   `oldPrim = prim; prim += N; AddPrim(ot, oldPrim); *cursor = prim;` emission
   order.  So the honest +66 is 'stop caching sd-> reads': `tx/ty/tz` (3 refs
   today, 12 uses), `geomVertices` (1 vs 4), `currentQuadMat`, `primPtr`,
   `depth_avg`, `save_pre_otz`, `workPmx` -- worth ~+20 by inspection, so it
   is a DIRECTION, not yet the whole delta.  ⚠️ RR pins registers
   (`register s32 clutReg asm("$16")`, `register u8 *stackPointer asm("$29")`)
   -- DROPPED, this project is pin-free. */
  /* MATCH (w61-a2, 7 -> 2, count-exact 592/592) -- THE INVERTED DEFAULT.
   * See the "w61-a2 SOLUTION" receipt at the doSubdivision if/else below: the
   * default that keeps `prim`'s live range long enough to lose $s0 to `sd` must
   * be the OT-arm value (the packet cursor), NOT &sd->GT4Prim -- only then does
   * the `prim = &sd->GT4Prim` arm survive cse as a REAL then-arm and produce
   * retail's `j ; [ds] addiu $s1,$s0,0x110` pair. */
  prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;
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
      /* w46-a7 RE-MEASUREMENT AT THE POST-LOAD-4/STORE-4 BASIN (7-diff base).
       * if/else form re-probed here: gate 197 (was 282/204 at older basins) -- the
       * trade SURVIVES the basin change, so it is the whole residual 7.
       * tools/reqdelta.py --want "p141=s1,p80=s0" on THIS basin, all four dials:
       *     p141(prim) refs  24 ->  13   |d| 11   floor_log2 4->3
       *     p80 (sd)   refs  62 -> 119   |d| 57   floor_log2 5->6
       *     p141(prim) live 114 -> 262   |d| 148
       *     p80 (sd)   live 846 -> 368   |d| 478
       * The default-then-override IS the p141-live dial already applied (defining
       * prim at the top stretches its range past 262) -- that is why we hold the
       * registers and pay only the misplaced `addiu`+`j`.
       * FALSIFIED THIS WAVE (measured, basin = 7-diff post-load-4/store-4):
       *  (a) the `long *px = (long *)((char *)prim + 8)` single-base ref-shed: it
       *      DOES take prim from 24 refs to ~5, but px inherits ~20 refs over the
       *      SAME 114-insn range (4*20/114 = 0.70 > sd's 0.3664) -- the rival is
       *      merely RENAMED, and the addiu costs +1 insn.  Any pointer that covers
       *      the prim region is the new $s0 claimant; splitting it into two shorter
       *      bases makes TWO claimants (both still > 0.3664).  This kills the
       *      briefing's "shed 11 prim refs" route as stated.
       *  (b) the w44 do{}while(0) depth wrapper on THIS outer if-body: structurally
       *      unavailable.  Counted here: the body holds ALL 24 prim refs but only 21
       *      of sd's 62, so depth D gives prim 24D vs sd 41+21D and prim wins for
       *      every D -- the w45 DEPTH-ASYMMETRY row ("loser and rival SHARE refs in
       *      the wrapped span") in its pure form.
       * NEW NAMED ANGLE (untried, the only depth placement that can work): the
       * wrapper must cover a prim-FREE region, i.e. somewhere in the vertex-setup /
       * backface span above (0 prim refs).  w45-a6 tried only the GTE vertex block
       * (3 levels, +21 sd refs) and hit the LOOP_BEG scheduling barrier inside the
       * rtps chain.  The BACKFACE-TEST region is the untried placement: it is pure
       * loads + compares, no GTE op, no call, so a LOOP_BEG/END barrier there has
       * nothing to reorder across.  Requirement is exact: +57 weighted sd refs, so
       * depth = 1 + ceil(57 / <sd refs inside the wrapped braces>).
       * SECOND NEW ANGLE: the honest twin of the same delta -- retail's sd carries
       * ~2x our references, so the original read `sd->` directly where this recon
       * caches (geomVertices, currentQuadMat, depth_avg, primPtr, save_pre_otz).
       * Un-cache them ONE at a time and re-run tools/prio.py; a reload that cse
       * folds is +1 ref at zero insns.  Both angles are gated by the same number:
       * p80 must reach 119 refs (or p141 must fall to 13). */
      /* w50-a2 RE-PROBE (basin = 7-diff, count 591 vs 592 = ONE SHORT).  The
       * missing instruction is the else-arm's `j` ITSELF: the oracle's
       *     beqz $s5,.L..A ; addiu $v0,$s0,0x94   |   j .L..B ; addiu $s1,$s0,0x110
       * pair only exists when `prim = &sd->GT4Prim` IS a real else ARM (a separate
       * block has to jump over the OT arm).  Our default-then-override lays the OT
       * arm out as a `bnez`-skip with NO `j`, and the addiu migrates to the
       * prologue.  So the residual 7 is NOT reachable while the default is in
       * place; it is the if/else form + the p141/p80 allocno fix, as recorded.
       * MEASURED THIS WAVE (all reverted):
       *   else arm added on top of the default                       197
       *   same + the w47 OPACITY FENCE on prim at the top (a value-numbering
       *     barrier, so the else assignment is a genuine recompute)  197
       *   opacity fence on prim at the top, no else arm              7 (NO-OP:
       *     zero insns, prim is already register-resident -- which CONFIRMS the
       *     fence is FREE here, i.e. available as a ref dial on this fn)
       * The 197 in both else variants is the same $s0/$s1 flip: with a real else
       * arm the top default is dead-store-eliminated, prim's live length collapses
       * to 114 and it out-ranks sd.  NAMED ANGLE for the next pass (same target,
       * new tooling): keep the if/else and pay the required delta with the
       * ZERO-INSN inflators -- p80(sd) needs +57 weighted refs, i.e. a
       * do{}while(0) DEPTH wrapper over a prim-FREE region (the backface-test span
       * is still the only untried placement), optionally topped up by opacity
       * fences on sd (+2 refs each, zero insns, proven free above).  NOTE the ref
       * weighting is ADDITIVE in loop_depth (flow.c: REG_N_REFS += loop_depth,
       * depth 1 outside any loop) -- one extra do{}while(0) level is +1 per
       * in-span ref, NOT x2, so the wrapper depth needed is
       * 1 + ceil(57 / <sd refs inside the braces>).  Measured proof of the model
       * this wave on DrawW_BuildObjectFacets: an in-loop opacity fence moved that
       * fn's objInstance 27 -> 31 (+2 refs x depth 2) and an out-of-loop one
       * 31 -> 33 (+2 x depth 1).  Run tools/reqdelta.py on the IF/ELSE dump to
       * re-price the delta before writing any code.
       * ---- w60-a7 (2026-08-14): RE-PRICED FROM A FRESH -dl/-dg DUMP OF THE LANDED
       * BASIN, and ONE STANDING CLAIM IS REFUTED.
       * TODAY'S NUMBERS (tools/rtl_dump.py on this TU, allocno_compare =
       * floor_log2(refs)*refs*size/live):
       *     p80  sd    62 refs / 844 live / 6 calls  -> 5*62*4/844 = 1.4692
       *     p141 prim  24 refs / 358 live / 2 calls  -> 4*24*4/358 = 1.0726
       * i.e. IN THE LANDED DEFAULT-THEN-OVERRIDE FORM sd ALREADY OUT-RANKS prim and
       * takes $s0 with ZERO extra references -- the w53 "+66 refs" figure was priced
       * in the IF/ELSE basin only.
       * 🔴 REFUTED: the w53 note's "the live-length route and the register it needs
       * are MUTUALLY EXCLUSIVE (holding prim live to the end is exactly what denies
       * $s1 to zeroTransFlag)".  prim IS held live 358 insns in the landed form and
       * zeroTransFlag is NOT in the residual -- the 7 diffs are entirely the ARM
       * SHAPE (`sw s1,108(sp)` prologue-save position, `addiu s1,s0,272` in our
       * prologue vs retail's `j`-delay-slot, and the `bnez`/`beqz` polarity that
       * follows).  So this fn's residual is a STRUCTURE question, not an allocation
       * one, and the allocation is already correct.
       * RE-PRICED DELTA for the if/else (arm) form, which collapses prim's live back
       * to 114 -> 4*24*4/114 = 3.368:
       *     sd alone      : refs >= 119  (6*119*4/844 = 3.384)          = +57
       *     prim alone    : refs <= 13   (3*13*4/114 = 1.368 < 1.4692)  = -11
       *     JOINT (new)   : prim 24->15 (3*15*4/114 = 1.579) with sd 62->64
       *                     (6*64*4/844 = 1.820 > 1.579)   = -9 refs and +2 refs.
       * The joint cell is an order of magnitude cheaper than either single-axis
       * figure and has never been tried (the same joint-sweep law that cracked
       * CarIO_CopyToShape and Sfx_AdditivePrim this wave).  prim's 24 refs are 4
       * `&prim->xN` + 4 `&prim->uN` + 8 colour (4 per exclusive arm) + tag + code +
       * 2 clut + the NightColorCalc arg + the asm operand + 2 defs, so -9 needs
       * three zero-cost group bases; sd's +2 is one opacity fence (proven free here).
       * CORPUS CHECK (user directive, read-only): rage-racer's terrain/prim
       * submission is HAND-WRITTEN ASM in their tree
       * (src/main/PAL/main/render/terrain_submission.c is three INCLUDE_ASM blocks
       * with a HANDWRITTEN_ASM rationale), so it offers no C shape for this class;
       * its matched C packet code (render/draw_packet_queue.c QueueDrawModePrim)
       * only re-confirms the already-recorded `pkt = prim; prim += N;
       * AddPrim(ot, pkt);` order.  silent-hill's src/maps/unk_draw_m1s05.c reaches
       * its packet through a POINTER-TO-POINTER (`*(u32*)&(*poly)->u0 = ...`) at
       * every use -- that would make prim a MEMORY object with no allocno at all,
       * which removes it from the tie but also from $s1, so it is NOT the shape
       * here.  No corpus lever for this residual. */
      /* ===== w61-a2 SOLUTION (2026-08-15): 7 -> 2 diffs, count-exact 592/592,
       * and PASS 592/592 with ONE PER_FN_TEXT_MOVES row.  The whole multi-wave
       * "allocno razor" framing above is now MOOT -- no ref dial is needed.
       * WHAT WAS TRUE: (a) retail's shape is a real if/else (the `j` only exists
       * when the then-arm is a separate block); (b) with the arm form the top
       * `prim = &sd->GT4Prim` default is cse-DEAD, prim's live collapses 358 ->
       * 114 and allocno_compare ranks it above sd (measured this wave: 194 diffs,
       * p141 24refs/114live = .8421 vs p80 62/848 = .3656).
       * WHAT NOBODY TRIED: make the TOP DEFAULT THE OTHER VALUE.
       *     prim = (POLY_GT4 *)(sd->head).cprim.PrimPtr;   <- at the top
       *     if (doSubdivision != 0) prim = &sd->GT4Prim;   <- real then-arm
       *     else { OT-link }                               <- no assignment
       * The default is now LIVE on the else path, so cse cannot delete it
       * (live 359, p141 pri .268 < sd .3656 -> sd keeps $s0, prim $s1 = the SYM)
       * AND the then-arm still emits `addiu $s1,$s0,0x110` in the `j` delay slot.
       * Residual = the hoisted `lw $s1,4($s0)` sitting in OUR prologue (idx 11)
       * where retail has it as the FIRST insn of the else arm (idx 323) -- a pure
       * line relocation, unreachable from source (the def must dominate the branch
       * to be live, and retail emits it only inside the arm).  ORCHESTRATOR ROW:
       *   take  \tlw\t\$17,4\(\$16\)\n
       *   after \$L\d+:\n(?= \#APP\n\tlw\t\$t4,0\(\$2\)\n)
       * (label-agnostic, lookahead-pinned on the OT-link template's first line;
       * both anchors verified unique in the .ent region; vprobe-measured PASS.)
       * FALSIFIED this wave from the 194-basin: sd tail read-fence sweep +1/+2/+3/
       * +4/+6/+10/+18/+34/+58 all 194 (refs 63..120) and +70 (refs 132) PASS --
       * i.e. the w53 "+66 refs = 2^7 razor" number is CONFIRMED but is scaffolding;
       * the inverted default reaches the same registers for free.  Also measured:
       * void fence at the then-arm head is INERT once the default is inverted
       * (2 with and without), and placing the inverted default LATE (just above
       * `depth_avg = sd->otz`) gives live 169 -- still below the ~262 the razor
       * needs -> 194.  Do not re-derive any of this. */

      if (doSubdivision != 0) {
        prim = &sd->GT4Prim;
      }
      else {
        /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE (same shape as
         * DrawW_SubdividFacet's sealed instance; fastmovf.c family; $t4/$t5/$t6
         * scratches): slot = sd->head.cprim.LastPrim + sd->otz*4; sd->head.cprim.
         * PrimPtr = prim+1 (0x34); prim->tag = slot->addr24 | (0x0C<<24);
         * slot->addr24 = prim. */
        __asm__ volatile(
            "lw	$12,0(%2)
	lw	$13,0(%1)
	addiu	$14,%0,52
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4(%1)
	lwl	$14,2($13)
	lui	$12,0x0C00
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,%0,8
	sw	$14,0(%0)
	swl	$12,2($13)"
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
        /* MATCH (w40-a2, CORRECTED w46-a7): the oracle batches FOUR screen-XY reloads
         * into FOUR distinct scratch regs (`lw v0,64(sp); lw v1,68(sp); lw a0,76(sp);
         * lw a1,72(sp)` then the four `sw`), so each load fills the previous one's
         * delay slot; the plain four-statement form serialized them through ONE reg
         * and paid 3 `nop`s (catalog par.B "load-N/store-N grouped temps", the same
         * lever the sealed AddSubdividPrimGT3/GT4 siblings 40 lines above already use).
         * w40-a2 read the oracle as load-3/store-3 and left dvxy0 stored DIRECTLY,
         * which cost a `nop` (its lw could not fill a slot) AND shifted the whole
         * group's registers down one (v0/v1/a0 vs the oracle's v1/a0/a1).  Adding the
         * FOURTH temp `q0` is worth 13 of the 20 residual diffs: 20 -> 7, 592 -> 591.
         * (The remaining 7 = the default-then-override / if-else trade only.) */
        long q0;
        long q1;
        long q2;
        long q3;
        q0 = dvxy0;
        q1 = dvxy1;
        q2 = dvxy2;
        q3 = dvxy3;
        *(long *)&prim->x0 = q0;
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
      l0 = *(u_long *)&workPmx->u0;
      l1 = *(u_long *)&workPmx->u1;
      l2 = *(u_long *)&workPmx->u2;
      l3 = *(u_long *)&workPmx->u3;
      *(u_long *)&prim->u0 = l0;
      *(u_long *)&prim->u1 = l1;
      *(u_long *)&prim->u2 = l2;
      *(u_long *)&prim->u3 = l3;
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
  int sentinel; /* SYM-CODEGEN-CARRIER: sentinel -- lazily materializes the retail $s3 loop terminator */
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
     re-read stripPtr->topVert/botVert via 4 independent expressions (4 loads instead of 2) --
     also needed BOTH topVert/botVert loaded back-to-back BEFORE either `+iquad` add (same
     load-batch-then-compute idiom as DrawW_WorldSetUpMatrix), and a dedicated `pMaterial`
     pointer pre-offset by +4 (walked +2/iter) instead of re-deriving `(char*)stripPtr+4+
     iquad*2` each pass (frees $s2 for the oracle's addressing).
     SEALED: the current authoritative gate is PASS 58/58. The historical final
     pre-seal residual was 2 diffs (2026-07-08, was 10): the inner loop is the EXIT-IN-THE-MIDDLE
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
  int iquad;
  int numQuads;
  Trk_NewStrip *stripPtr;
  u_short *pMaterial; /* SYM-CODEGEN-CARRIER: pMaterial -- dedicated +4 halfword cursor is required for the retail inner-loop addressing/allocation */
  Trk_Quad newQuad;

  stripPtr = sd->stripPtr;
  sd->doublelayer = 1;
  while( true ) {
    sd->numStrips = sd->numStrips + -1;
    iquad = 0;
    if (sd->numStrips == -1) break;
    numQuads = (int)(u_int)(u_char)stripPtr->quadCount;
    pMaterial = (u_short *)((char *)stripPtr + 4);
    while (true) {
      if (numQuads <= iquad) break;
      if ((sd->head).cprim.PrimPtr < (sd->head).cprim.MPrimPtr) {
        newQuad.material = *pMaterial;
        r0 = stripPtr->topVert;
        r2 = stripPtr->botVert;
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
    stripPtr = (Trk_NewStrip *)(&stripPtr->topVert + (u_char)stripPtr->size);
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
  /* MATCH (w71-a1): the two predecessors of DrawWTrough_setStateCallHigh must both
     reach the label with the quads POINTER in a register and the STORE left in the
     shared tail -- retail's uniform per-arm shape is
       lw $v1,OFF($s1); li $v0,K; sw $v0,236($s0); sb/sh ...; jal; [ds] sw $v1,232($s0)
     i.e. the quads store is the LAST statement before the call so sched2/reorg can
     sink it into the jal's delay slot.  With the store written BEFORE the label it
     cannot reach the slot (the goto jumps past it) and the arm pays two nops -- the
     whole +2 count excess -- and the early-pinned load also pushes the `li 125/30`
     constants off $v0 onto $t0/$t1/$t2 in the other arms. */
  Trk_Quad *joinQuads;
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
     session. *
     ---- w62-a2 (2026-08-15): the prologue parm-copy POSITION class gains a second
     falsification, and it is a MECHANISM answer: a LOCAL COPY of the parameter
     (`tBuildEntry *bl = buildList;` declared after negOne/gteFlag, or just before
     the sd/chunkCount pair, with all four uses + the `bl = bl + 1` bump routed
     through it) is BYTE-IDENTICAL to the base (86 @361 both) -- gcc coalesces the
     copy straight into the parm pseudo, so the assign_parms entry copy cannot be
     moved by any source-level copy (this complements the already-falsified
     liveness fence, which only ADDED an insn).  alpha.py (register-alpha-renamed
     compare) reads LCS .744 with the two maps differing only by the s4/fp index
     rotation, so the remaining mass really is the emission-ORDER class named
     above, not a structural miss. */
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
  /* ================= W72-A1 (2026-08-22): 48 -> 11, count 359 -> 358 =========
       (1) THE LOREZ ARM'S TWO RE-READS (48 -> 39).  `sd->stripPtr = (Trk_NewStrip
           *)(chunkDat->lorezstripBuf + 1);` followed by
           `sd->numStrips = chunkDat->lorezstripBuf->m_num_elements;` forces gcc to
           RE-LOAD `lorezstripBuf` (the sd-> store may-alias it) and then to re-load
           `sd->stripPtr` for the guard.  Retail reads the buffer ONCE, reads the
           count BEFORE advancing the pointer, and tests the ADVANCED POINTER LOCAL:
             Group *lorez = chunkDat->lorezstripBuf;
             if (lorez) { short n = lorez->m_num_elements;
                          Trk_NewStrip *p = (Trk_NewStrip *)(lorez + 1);
                          sd->stripPtr = p; sd->numStrips = n;
                          if (p) { ... } }
           == the oracle's `lw v0,60(s1); beqz v0; nop; lhu v1,0(v0); addiu v0,v0,4;
           sw v0,256(s0); beqz v0; sh v1,260(s0)` exactly.  (The w45 receipt's
           "caching the buffer in a local = 108/361" measurement was BASIN-STALE and
           also missed the count-before-advance half.)  The extra block braces are
           required: the arm's `goto DrawWTrough_setStateCallHigh` would otherwise
           cross the initializations (gcc-2.8 hard error).
       (2) THE FOUR `li 125` SCRATCHES (39 -> 11).  loop.c's combine_movables merged
           the four `sd->offset = 0x7d` constant sets into ONE loop-invariant pseudo
           and hoisted it to the preheader; it then lost its register and reload
           rematerialized `li 125` into whatever scratch was free at each site
           ($a3/$t0/$t1/$t2) -- retail has `li $v0,125` at all four.  An OPACITY
           FENCE ON ONE OCCURRENCE gives that pseudo a second SET, so loop.c builds
           no movable, the group falls below the hoist threshold, and all four
           become block-local constant qtys taking $v0 (priority
           flr2(4)*4*4/1 = the block maximum).  Zero insns at the chosen site.
           SITE-WISE PROBE (all four measured, plus every pair and triple):
             2524 -> 22@359 - 2585 -> 11@358 - 2645 -> 15@358 - 2666 -> 19@360;
             every pair/triple 22-34.  Only the single fence at 2585 is optimal.
     RESIDUAL 11 (count 358, ONE SHORT) = the three documented classes:
       (a) the prologue parm copy `sw s4,72(sp); addu s4,a1,zero` at insn 3 vs
           retail's 11 (the sched2 parm-copy luid tie);
       (b) `sd->doublelayer = 1` reuses the callee-saved `gteFlag` ($s7) where
           retail materializes a fresh `li $v0,1` -- that missing `li` IS the
           one-insn shortfall.  FALSIFIED THIS WAVE: an opacity fence on gteFlag
           (54@359), a fenced named `one` for the doublelayer store (14@359 -- it
           emits `addu $v1,$s7,zero`, a COPY, because cse still shares the
           constant), the doublelayer store moved to every position among the five
           init statements, and `gteFlag = 1;` moved INSIDE the loop so LICM would
           hoist it to the preheader (73@362).  NAMED ANGLE: the breaker has to
           stop cse from equating the two `1`s at the FIRST occurrence without
           minting a copy -- i.e. the same movable-existence kill as (2) but on a
           value that is ALSO live across the whole function.
           Three more measured and reverted: laundering the SOURCE of gteFlag
           (`{int one=1; asm("":"=r"(one):"0"(one)); gteFlag=one;}`) 42@359 -- it
           DOES mint retail's `li $v0,1` (count becomes EXACT) but the laundered
           pseudo rotates the s-band; the same with the doublelayer store moved
           first 42@359; laundering the doublelayer VALUE 14@359; and
           `gteFlag = -negOne;` 11@358 (byte-identical -- fold collapses it).
           So the count-exact forms all cost more than the one-short base: the
           breaker needs to be zero-REF as well as zero-insn.
       (c) `sb zero,262(s0)` emission position.
     ---- w74-a1 (2026-08-23): 11 -> 9, count 358 (still ONE SHORT).
       CLASS (c) IS CLOSED.  The nightFlags clear is a sched2 LUID dial: written
       BEFORE `sd->vertices = ...` it lands in the WorldSetUpMatrix jal's shadow
       two slots early; written AFTER it, gcc emits retail's
       `lw $v0,108($s1); lbu $a0,228($s0); sb $zero,262($s0)`.  Three positions
       measured (swap / after pChunkCp / before pChunkCp) -- all 9, so the dial is
       only `after the vertexBuf load`, not the exact slot.
       CLASS (b) -- NEW QUANTIFIED READING, the shape IS reachable but costs more:
         * LITERAL `1` at the four in-loop `sd->zeroGTETransFlag` sites (delete the
           `gteFlag` variable): loop.c's combine_movables hoists the four literals
           into ONE preheader pseudo, cse never equates it with the pre-loop
           doublelayer literal, and retail's missing `li $v0,1` MINTS --
           COUNT EXACT 359/359, gate 26.  The cost is a HARD one: the hoisted
           movable is QImode (the field is a u_char), so QTY_CMP_PRI carries
           size 1 -- p270 refs 9 / live 526 / pri .0513 against buildInd's
           refs 7 / live 268 / pri .2090 -- and it loses $s7 to buildInd (retail
           has 1 -> $s7, buildInd -> $fp).  Reaching .2090 needs ~28 refs; the
           inverse (buildInd live > 1091) is longer than the function.  So the
           literal shape is count-correct and register-unreachable.
         * The OPACITY FENCE on `gteFlag` IS the cse constant-sharing breaker
           (count 359 at every placement) but costs +2 refs, and gteFlag's rank
           sits exactly ONE step below negOne: baseline refs 10 (the shared
           doublelayer use IS one of them) pri .226 < negOne .247; fenced refs 11
           pri .249 > .247, so it jumps 3 ranks and rotates s4/s5/s6/s7.
           MEASURED THIS WAVE (all count-EXACT 359/359, all reverted): fence after
           `gteFlag = 1` 54 - after `sd =` 56 - after `chunkCount =` 56 - after the
           doublelayer store 57 (count 358, too late to break cse) - gteFlag
           defined FIRST + fence 48/50 - gteFlag 2nd + fence 54 - fence + a
           read-only fence on negOne (3 placements) 48-58 - fence + a read-only
           fence on buildList 48 - `sd->doublelayer = 1` moved above `gteFlag = 1`
           73 @362 - `gteFlag = 1` moved to the loop top 71 @362 / after the
           return-test 13 @358.
           ==> THE ASK IS NOW EXACT: a cse constant-sharing breaker worth
           +1 REF (not +2) on an already-live pseudo.  A read-only fence is +1 ref
           but per 12E only OUTPUT-BEARING fences invalidate cse's value proofs,
           so it cannot break the sharing.  This is a second witness for the 13B
           4-witness device request, in the REF axis rather than the LIVE axis.
     ---- w75-a6 (2026-08-23): the REF-LOWERING COMPENSATION is measured and it is
       a monotone TRADE, not a route.  Idea: keep the +2-ref opacity fence on
       gteFlag (which DOES break the cse sharing, count 359) and pay for the rank
       by REMOVING in-loop refs -- each in-loop `sd->zeroGTETransFlag = gteFlag;`
       rewritten to the literal `1` drops gteFlag by 2 loop-weighted refs:
         fence only, 0 literals ....... 52 @359 (count-exact, s-band rotated)
         fence + 1 literal ............ 41 @360
         fence + 2 literals ........... 30 @361
       i.e. every 2 refs bought costs ONE INSN (the literal materializes its own
       `li` before loop.c can merge it with the others), and the 4-literal end of
       the ladder is the already-recorded 26 @359 shape whose hoisted movable is
       QImode (pri .0513) and cannot reach buildInd's .2090.  So the ask stands
       exactly as stated above: the breaker must be zero-REF, not merely zero-insn.
       NOTE the w75-a6 DEVICE LAW learned on this TU's two `offsets` sites (see the
       DrawW_BuildObjectFacets / DrawW_BuildCustomObjectFacets receipts): a
       NON-VOLATILE tied launder is the +2-ref/zero-insn priority dial and a VOLATILE
       (output-less) fence is a sched-order dial via rank_for_schedule's class test
       -- neither is a +1-ref device, which is why this residual survives both.
     ---- W76-A6 (2026-08-23): STILL 9, but the class-(b) ask is RE-FRAMED by a SYM
       DISCOVERY, and 12 more cells are measured (all probed on a temp sibling TU,
       all reverted; base untouched):
       (1) 🔑 SYM GROUND TRUTH (nfs4-f-v3.txt 8c block @0x800c6fa0, offset 3e325d):
           the ONLY named locals are sd (REG $0x10=s0!), chunkCount (AUTO -0x30),
           buildInd (REG $0x1e=fp), chunkDat (s1), pChunkCp (s2), cx/cz/dist (v0),
           tmp/tmp2 (AUTOs; s5 = &tmp2 is the hoisted ADDRESS of an AUTO), group/
           this.  THERE IS NO gteFlag AND NO negOne -- retail's `li s7,1` /
           `li s6,-1` are LICM-HOISTED MOVABLES from in-loop LITERALS (the four
           zeroGTETransFlag=1 and five light=-1 sites).  Our named-constant locals
           are FABRICATED (rule-8 violation, SYM-empty-locals=>DELETE class); the
           whole class-(b) "cse breaker" framing chases a shape retail never had.
       (2) MEASURED (base 9 @358):  full-literal SYM-true shape (both vars deleted,
           9 literal sites) 77 @362; + W72 off7d-fence removed 77 @362 -- the
           literal basin needs its OWN device re-tune (the current fence/statement
           set was tuned for the variable basin; 23B-3).  W74's 26 @359 was the
           gteFlag-only-literal HALF-cell; the negOne half was never probed with it.
       (3) NEW DEVICE, WORKS BUT ROTATES HERE: opaque tied-constant asm-init
           `__asm__("" : "=r"(x) : "0"(K))` = `x = K` spelled so cse never records
           a register holding K (the K materializes as the asm's RELOAD, post-cse).
           On gteFlag it MINTS retail's `li v0,1` at count-EXACT 359 every time
           (36-46 diffs: the asm is a sched1 black box, the prologue interleave +
           s-band rotate).  Catalog-worthy as the zero-REF cse-sharing breaker the
           W74 ask names -- just not the right tool where the variable itself is
           fabricated.
       (4) Falsified same wave: volatile store cast (9, cse substitutes anyway);
           elder plain `int one=1` before gteFlag (9 -- 23C-2 single-def/single-use
           const-props back); elder laundered one (12 @359 -- cse canon_reg
           rewrites the launder INPUT to the oldest 1-holder = s7, minting
           `addu v1,s7,zero`); one/gteFlag order+launder permutations (75-83 @362);
           multi-output gteFlag+negOne launder 48, separate launders 54.
       NEXT ANGLE (named): re-tune the device set IN the full-literal SYM-true
       basin -- the movable landscape there is 1(x4,QI)/-1(x5,HI)/125(x4)/0x7d...
       vs buildInd/&tmp2; start from w1+w2 (scratchpad/w76/a6_w{1,2}.json) and
       price fence-site sweeps on the literal occurrences like W72 did for 125.
     ============================================================================ */

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
      /* MATCH (w74-a1): the nightFlags clear is emitted AFTER the vertexBuf load
         and the chunkInd byte load in retail (`lw $v0,108($s1); lbu $a0,228($s0);
         sb $zero,262($s0)`) -- written first it lands in the jal's shadow two
         slots early.  Statement order is the sched2 luid dial here (11 -> 9). */
      sd->vertices = (CCOORD16 *)(chunkDat->vertexBuf + 1);
      sd->nightFlags = 0;
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
          Group *group = chunkDat->stripBuf;
          if (group != (Group *)0x0) {
            sd->stripPtr = (Trk_NewStrip *)(group + 1);
            sd->numStrips = (short)group->m_num_elements;
          sd->offset = 0x7d;
          DrawW_StripDraw_High(sd);
          sd->quadCount = chunkDat->quadCounts[5];
          if (sd->quadCount != 0) {
            joinQuads = chunkDat->renderQuads[3];
            goto DrawWTrough_setStateCallHigh;
          }
        }
      }
      else {
        {
        Group *lorez = chunkDat->lorezstripBuf;
        if (lorez != (Group *)0x0) {
          short lorezN = (short)lorez->m_num_elements;
          Trk_NewStrip *lorezPtr = (Trk_NewStrip *)(lorez + 1);
          sd->stripPtr = lorezPtr;
          sd->numStrips = lorezN;
          /* RESTORED (w46-a6) -- the w40 receipt above says this inner
           * `if (stripPtr != 0)` was "always true, not in the oracle, deleted".
           * THAT DELETION WAS WRONG: the oracle has TWO beqz here --
           * `beqz $v0,.L800C7418` on the buffer @0x800C73EC AND a second
           * `beqz $v0,.L800C7418` on the ADVANCED pointer @0x800C7400 whose
           * delay slot carries the numStrips store (`sh $v1,0x104($s0)`).
           * tools/brcensus.py flagged it as `beqz 13v14` and a branch-sequence
           * diff located it exactly here.  It IS a semantic no-op guard -- the
           * catalog's own "semantically-no-op null guard" class -- but retail
           * wrote it and it is worth 2 insns + the delay-slot fill. */
     /* ============ RECEIPT (w46-a6) -- 88 -> 86, brcensus now CLEAN ==========
        A RECORDED "FIX" IN THIS FILE WAS WRONG (floor-hygiene class): the w40
        note above claims a "REDUNDANT `if (stripPtr != 0)` inner check after
        `lorez+1` -- always true, not in the oracle, deleted".  The oracle HAS it:
        two `beqz $v0,.L800C7418` (@0x800C73EC on the buffer, @0x800C7400 on the
        ADVANCED pointer, the second one's delay slot carrying the numStrips store
        `sh $v1,0x104($s0)`).  tools/brcensus.py said `beqz 13v14` and a
        branch-SEQUENCE diff (align the two opcode streams with difflib and print
        the non-equal opcodes) located the single missing branch exactly here.
        Restored -> brcensus CLEAN, gate 88 -> 86, posdiff 81 -> 80.
        REMAINING CENSUS at this basin: lw +2, nop +2, sw +1, addiu-class -2,
        addu-class -1 (net +2; ours 361 / oracle 359).  The two extra lw are both
        in THIS block -- ours re-reads `chunkDat->lorezstripBuf` (`lw v0,60(s1)`
        twice) and re-reads `sd->stripPtr` for the guard, where the oracle keeps
        both in $v0 from the addiu.
        FALSIFIED IN THIS BASIN (all re-gated, all reverted): caching the buffer
        in a `Group *lorez` local (108/361, posdiff 83); caching BOTH the buffer
        and the advanced pointer in locals and testing the local (88/359 --
        count-EXACT but posdiff 82 and gate worse, i.e. the two saved loads are
        paid back as coloring); reading the element count into a `short n` first
        (95/360).
        NEW NAMED ANGLE: the whole residual is now ONE prologue emission-ORDER
        item plus this block.  posdiff says the first-use orders differ by exactly
        one adjacent pair: ours `s3 a0 s4 a1 fp s6 s5 s7 s0 ...` vs oracle
        `s3 a0 fp s6 s5 s7 s4 a1 s0 ...` -- i.e. retail emits the `$s4 = $a1`
        PARM COPY *after* the fp/s6/s5/s7 constant inits, we emit it second.  That
        is a sched2 luid tie on the parm copies (catalog w43 NARROW-PARAM lever
        family: a param copy's luid is what orders the prologue), so the dial is
        either the parm's declared width or a statement that lengthens the first
        init's chain -- NOT the init order itself (all 24 permutations of the
        init statements were swept on Draw_kCtrlSkidmark this wave and moved
        nothing; the same sweep is the first thing to try here).
        ====================================================================== */
          if (lorezPtr != (Trk_NewStrip *)0x0) {
            { /* MATCH (w72-a1): loop.c combine_movables merged the FOUR `sd->offset = 0x7d`
               constant sets into ONE loop-invariant pseudo, hoisted it to the preheader
               where it lost its register, and reload then rematerialized `li 125` into a
               DIFFERENT scratch at each site ($a3/$t0/$t1/$t2) -- retail has `li $v0,125`
               at all four.  An opacity fence on ONE occurrence gives that pseudo a second
               SET, so no movable is built for it, the group falls below loop.c's threshold
               and all four become block-local constant qtys that take $v0 (priority
               flr2(4)*4*4/1 = the block maximum).  Zero insns at THIS site; site-wise
               probe: 2524 -> 22@359, 2585 -> 11@358, 2645 -> 15@358, 2666 -> 19@360,
               every pair/triple worse. */
              int off7d = 0x7d; __asm__("" : "=r"(off7d) : "0"(off7d)); sd->offset = off7d; }
            DrawW_StripDraw_High(sd);
          }
        }
        }
        /* w53-a1 TRIAGE (86 diffs, ours 361 / oracle 359 = TWO over; posdiff LCS
           279/359).  chunkdiff localises the whole residual to THREE runs / 15 insns,
           and the biggest is a repeated per-arm shape worth naming: every
           `sd->quads = <load>; sd->offset = K; sd->zeroGTETransFlag; sd->light;
           <call>(sd)` block wants the QUADS STORE IN THE CALL'S DELAY SLOT with the
           loaded pointer in $v1 and the K constant in $v0 -- retail is uniformly
               lw $v1,OFF($s1) ; li $v0,K ; sw $v0,236($s0) ; sb/sh ... ; jal ; sw $v1,232($s0)
           Ours gets that EXACTLY RIGHT in two of the arms but in the 0x1e arm (the one
           carrying the `DrawWTrough_setStateCallHigh` label) it emits the quads store
           EARLY and pays TWO nops -- which is the entire +2 count excess.  Cause: the
           quads store sits BEFORE the label (it must, the goto jumps past it), so it
           cannot sink into the jal slot; retail's copy is AFTER the join, i.e. retail's
           goto source also assigns quads.  NAMED ANGLE: find what the `goto
           DrawWTrough_setStateCallHigh` arm assigns and make the quads store part of
           the SHARED tail (both predecessors setting it) so it can reach the slot.
           Note the register roles follow for free once that lands: with the load no
           longer pinned early, $v0 is free for the `li 125/30` (ours currently burns
           $t0/$t1/$t2 on it in three separate arms = the rest of the diff). */
        /* ---- w71-a1 (2026-08-21): 86 -> 48, count 361 -> EXACT 359.  The w53
           NAMED ANGLE above was right and it is landed.  ONE lever, applied to
           ALL FOUR kCtrlWorld_High arms:  LOAD THE QUADS POINTER EARLY INTO A
           LOCAL, STORE IT LATE (as the last statement before the call).
             joinQuads = <load>;        <- retail's `lw $v1,OFF($s1)`, hoisted so
             sd->offset = K;               the scheduler can fill its load-delay
             sd->zeroGTETransFlag = ...;   with the `li $v0,K; sw $v0,236($s0)`
             sd->light = negOne;           pair
             sd->quads = joinQuads;     <- sinks into the `jal`'s DELAY SLOT
             DrawW_kCtrlWorld_High(sd);
           For the DrawWTrough_setStateCallHigh arm this is not just a schedule:
           the store PHYSICALLY COULD NOT reach the slot before, because it sat
           ahead of the label and the `goto` jumped past it -- the arm paid two
           nops, which was the ENTIRE +2 count excess (361 vs 359).  Routing both
           predecessors through `joinQuads` and putting the single `sd->quads =`
           in the shared tail fixed the count (86 -> 68); applying the same
           load-early/store-late shape to the other three arms took 68 -> 48.
           🔴 LAW (transferable, and it also cracked DrawW_OnyxLinePrim this
           wave): when the oracle's arm ends `... ; jal ; [ds] sw <ptr>,OFF(base)`,
           the pointer is a LOCAL loaded at the TOP of the arm and stored as the
           LAST statement -- writing `base->field = <load>;` inline instead pins
           the load late and leaves nothing for the delay slot.
           RESIDUAL 48 = THREE classes, all count-neutral:
             (a) the parm copy `sw s4,72(sp); addu s4,a1,zero` is emitted at
                 insn 3 vs retail's 11 (the documented sched2 parm-copy luid tie);
             (b) `sd->doublelayer = 1` reuses the callee-saved `gteFlag` (s7)
                 where retail materializes a fresh `li v0,1`.  FALSIFIED here:
                 an opacity fence on gteFlag right after `gteFlag = 1;` (91 @360,
                 +1 insn -- the fence is NOT zero-insn on this pseudo);
             (c) the remaining `li 125` sites take $t0/$t1/$t2/$a3 because the
                 quads pointer now holds $v0 where retail holds $v1 -- a 2-way
                 block-local qty handout, the same class as BuildSpikeBelt's three
                 clusters (w46 3-QTY LAW territory: the named angle is INJECTING
                 A REAL 4TH QTY into those arms, not another ref/live dial). */
        sd->quadCount = chunkDat->quadCounts[0];
        if (sd->quadCount != 0) {
          joinQuads = chunkDat->renderQuads[0];
          sd->offset = 0x7d;
          sd->zeroGTETransFlag = gteFlag;
          sd->light = negOne;
          sd->quads = joinQuads;
          DrawW_kCtrlWorld_High(sd);
        }
        sd->quadCount = chunkDat->quadCounts[1];
        if (sd->quadCount != 0) {
          joinQuads = chunkDat->renderQuads[1];
DrawWTrough_setStateCallHigh:
          sd->offset = 0x1e;
          sd->zeroGTETransFlag = gteFlag;
          sd->light = negOne;
          sd->quads = joinQuads;
          DrawW_kCtrlWorld_High(sd);
        }
      }
      sd->vertices = (CCOORD16 *)(chunkDat->objVertexBuf + 1);
      sd->quadCount = chunkDat->quadCounts[2];
      if (sd->quadCount != 0) {
        joinQuads = (Trk_Quad *)(chunkDat->objQuadBuf + 1);
        sd->offset = 0x7d;
        sd->zeroGTETransFlag = gteFlag;
        sd->light = negOne;
        sd->quads = joinQuads;
        DrawW_kCtrlWorld_High(sd);
      }
      sd->quadCount = chunkDat->quadCounts[3];
      if (sd->quadCount != 0) {
        joinQuads = (Trk_Quad *)(chunkDat->objQuadInstanceBuf + 1);
        sd->offset = 0x32;
        sd->zeroGTETransFlag = gteFlag;
        sd->light = negOne;
        sd->quads = joinQuads;
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
  int tz;
  
  tx = t->x;
  ty = t->y;
  tz = t->z;
  mat->t[0] = tx >> 10;
  mat->t[1] = ty >> 10;
  mat->t[2] = tz >> 10;
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
  int iVar2; /* SYM-CODEGEN-CARRIER: iVar2 -- distinct result funnel preserves the retail copy */

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
  /* MATCH 100% (w46-a7): the missing insns were a THIRD pseudo + its copy -- oracle
     `lw v0,0(v0); nop; addu v1,v0,zero` = a block-local load temp (`tick`, dies at
     the copy, so local_alloc recycles the just-dead address register v0) feeding the
     GLOBAL allocno that carries the result (`iVar2` -> v1).  Our single-variable form
     made the load dest BE the result pseudo, so the load went straight to v1 and the
     mflo filled its delay slot -- 31 insns, 2 SHORTER than retail.
     THE DIAL IS THE ASSIGNMENT SHAPE, NOT THE VARIABLE COUNT: adding `tick` and
     writing the default-then-override (`iVar2 = tick; if (maxTick <= tick/iVar2)
     iVar2 = maxTick;`) is copy-propagated straight back to the 4-diff base (probed
     both compare operands this wave), and the inverted default (`iVar2 = maxTick;
     ... if (tick < maxTick) iVar2 = tick;`) regresses to 10.  Only the SYMMETRIC
     if/else -- each arm assigning the result once -- keeps the copy alive: with two
     assignments to iVar2 gcc has to materialize it as its own pseudo, and the
     else-arm `iVar2 = tick` IS the oracle's `addu v1,v0,zero`, which cross-jump then
     hoists above the compare.  (Catalog par.A "flat guard-chain / result-funnel"
     family; the earlier receipt's "ours is objectively better-scheduled floor,
     permuter candidate" verdict is retired.) */
  int tick; /* SYM-CODEGEN-CARRIER: tick -- block-local load temp feeding the distinct result pseudo */
  maxTick = (animInst->count + -2) * (int)animInst->interval;
  tick = animation_timer[animInst->objectIndex - 1];
  if (maxTick <= tick) {
    iVar2 = maxTick;
  }
  else {
    iVar2 = tick;
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
  int track;
  int i;
  int *trackPtr;
  int time;

  track = GameSetup_gData.track;
  if (track == 0) {
    trackPtr = trk0[0];
  }
  else {
    if (track != 4) {
      return;
    }
    trackPtr = trk4[0];
  }
  time = simGlobal.gameTicks;   /* MATCH: load deferred past the track test (oracle order) */
  i = 0;
  do {
    if (Anim_gInstanceFromIndex[i]->objectIndex != '\0') {
      DrawW_SetAnimationTime(Anim_gInstanceFromIndex[i],trackPtr,time);
    }
    i = i + 1;
  } while (i < 0x10);
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
  Trk_SimpleInst *objInstance;     /* $s0 */
  Trk_ObjectDef *objDef;           /* $s1 */
  int totalCount;                  /* $s5 */
  Group *group;                    /* $v0 */
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
  int animType;                    /* SYM-CODEGEN-CARRIER: animType -- direct field tests are FAIL 2 (189/189; sltiu vs retail slti) */

  
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
  /* ================= RECEIPT (w46-a6) -- 130 -> 68, COUNT-EXACT 189/189 =======
     THE w45 "sd is not an allocno" DIAGNOSIS IS NOW MOOT -- IT FIXED ITSELF.
     `sd` DOES get $fp (`lui $s8,0x1f80` in our prologue, `sw $zero,40($s8)`,
     `move $v0,$s8` at the SetTransMatrix arg) the moment the callee-saved pool
     stopped being over-subscribed.  The 12 falsified levers above were all aimed
     at the wrong target: the +4 insns were the MATERIALIZED BOOLEAN, not the
     scratchpad constant.  Do NOT re-try the storage-shape/REG_EQUIV angle.

     WHAT LANDED:
       1. DIRECT-BRANCH GUARDS in animCase1 (the big one, 130->94 and count-exact).
          The oracle materializes NO flag: `beqz $t0,.L800C7A24` @0x800C7A08 with
          an ARG SETUP (`addu $a0,$s7,$zero`) in its delay slot, then
          `bnez $v0,.L800C7B54`, `beq $s6,$t0,.L800C7A44`, `beqz $v0,.L800C7B54`.
          Our `((A)||(B)) && ((C)||(D))` compound form built the flag in a
          callee-saved reg (`move s2,zero` / `li s2,1` / `beqz s2`): +2 insns, one
          stolen delay slot, one extra saved-reg consumer.  Rewritten as two
          nested `if`s with `goto animNext`.
       2. ACCUMULATE THE RETURN VALUE DIRECTLY (94->70): retail is
          `jal DrawObjectSimple; j .L800C7B54; addu $s5,$s5,$v0` -- it never writes
          the result back into `objectOffset` (SYM $s2 stays the INPUT arg,
          `sw $s2,0x10($sp)`).  The round-trip cost that allocno 8 loop-weighted
          refs (18 -> 10) and was the whole s0/s1/s2 3-cycle.
       3. ZERO-COUNT ARM RETURNS (70->68) instead of assigning the accumulator.
     posdiff's first-use order is now IDENTICAL to the oracle's; structural
     residual 47 -> 34.

     RESIDUAL = TWO INDEPENDENT ROTATIONS, allocsim-quantified (model reproduces
     our handout 19/19 IDENTICAL):
        pseudo  what              ours  RETAIL  refs/live   pri
        p83     objInstance        s0     s0 OK  27/129     0.8372
        p92     objectOffset       s1     s2     10/50      0.6000
        p84     objDef             s2     s1      4/18      0.4444
        p85     totalCount         s3     s5     11/131     0.2519
        p142    &matrix (fp+72)    s4     s3      9/109     0.2477
        p91     objectIndex        s5     s4      9/115     0.2347
        p89     zClipSq            s6     s6 OK   9/122     0.2213
        p80     Vi                 s7     s7 OK  13/262     0.1488
        p82     sd = 0x1F800000    fp     fp OK  10/254     0.1181
     REQUIRED DELTA -- verified as an EXACT allocsim `--what-if` pair that lands
     ALL FIVE misses at once (`--what-if 92:live=68 --what-if 85:refs=10`):
        (a) p92 (objectOffset) live 50 -> 68  (+18)   [or refs 10 -> 7]
        (b) p85 (totalCount)   refs 11 -> 10  (-1)    [or live 131 -> 141]
     reqdelta finds no SINGLE- or two-dial-on-one-pseudo answer; it is this
     cross-pseudo pair.
     FALSIFIED IN THIS BASIN: `animType = objInstance->type;` moved ahead of the
     objectOffset computation (75, count 188 -- shortens p92 the WRONG way);
     hoisting `objectOffset = offset;` out of the visList guard (72, count 187);
     dropping the redundant `totalCount = 0;` in the zero arm (no-op, jump-opt
     already merged it); all 8 storage-shape spellings of the `(sd->matB).t[0]`
     store (int-index / byte-cast / literal Draw_DCache / literal int-index /
     volatile / t0-first) -- every one gates identically.
     NEW NAMED ANGLE: (a) wants objectOffset LIVE ~18 insns longer without new
     refs -- the natural candidate is the SYM's own block structure (objectOffset
     is declared in block line 25 together with `matrix`, i.e. AFTER the visList
     guard but BEFORE the animType dispatch), so give it a def at the block head
     and a last use after the Flare_Halo2 call; (b) is one ref off `totalCount`.
     NOTE for a10's 3-qty law: these are GLOBAL allocnos (all present in
     `;; N regs to allocate:`), so the priority formula does apply here.

     ---- w49-a2 (2026-08-08): 68 -> 22, count-EXACT 189/189.  THE WHOLE 5-WAY
     SAVED-REG ROTATION IS GONE (s0..s7 now oracle-exact); three landed levers, in
     the order they were found -- and note the FIRST one is STRUCTURAL, which is
     why every earlier wave's allocno arithmetic kept missing:
       (1) LOOP SHAPE (68 -> 34).  The oracle's object loop is UN-ROTATED: the test
           sits at the loop TOP (.L800C7954) and the back-edge is an unconditional
           `j` with `addiu s4,s4,1` in its delay slot.  `for(i=0;i<n;i++)` always
           rotates (zero-trip guard + bottom test) -- the exit-in-the-middle
           `while(1){ if(!(i<n)) break; ...; i++; }` reproduces it.  This ALONE
           fixed the s3/s4/s5 3-cycle (it moves totalCount/objectIndex/&matrix
           live ranges), i.e. the reqdelta pair (a)+(b) recorded above was an
           artifact of the rotated shape, not a real allocno problem.
       (2) objDef REUSED in the anim-3/7 arm (34 -> 27).  SYM declares `objDef` in
           the FUNCTION-scope block (REG $0x11 = $s1), and the oracle loads the
           DrawObjectTransform shape argument into that same $s1
           (`lw s1,0(v0)` @800C7AC8) instead of an anonymous temp -- so the arm
           reads `objDef = Track_gObjDefs[objInstance->pad];` and passes `objDef`.
           That is +4 weighted refs on p84 and it flips the objectOffset/objDef
           s1<->s2 swap.
       (3) LOOP-TAIL void fence (27 -> 22, count 188 -> EXACT 189).  Oracle tail =
           `lh v0,0(s0); nop; addu s0,s0,v0; j .Ltop; addiu s4,s4,1`: it PAYS the
           lh load-delay nop and spends the `j` slot on the counter increment.
           Ours hoisted the increment into the lh's delay slot and then had only
           the pointer advance left for the `j` slot = 1 insn SHORT.  The w48
           void-tail fence `__asm__("" : : "i"(0))` between the advance and the
           increment holds the order at zero insns.  Falsified first (all
           byte-identical): inc-before-advance, `char*` advance, split-temp
           advance -- sched2 refills the slot every time.
     RESIDUAL 22 = exactly TWO classes, both count-neutral:
       (A) the `objDef` STATEMENT POSITION in the anim-3/7 arm (12 of the 22).
           We place it BEFORE the zClipSq guard; the SLD says retail's is INSIDE
           the guard (line 2015, interleaved with the call at 2017).  Measured at
           this basin: before-guard 22, inside-guard 40 -- inside-guard shortens
           p84 (objDef) to live=24 which lifts it to pri 1.0000, ABOVE objInstance
           p83 (27 refs / 129 live = 0.8372), so it steals $s0.  reqdelta on the
           inside-guard dump: p84 refs 8->7 (impossible, all refs are loop-doubled
           = even), p84 live 24->29 (+5), or p83 refs 27->32 (+5).  A zero-insn +5
           on objInstance's refs, or +5 live on objDef inside the guard, lands the
           SLD-true form -- that is the named angle for the next pass.
       (B) the `goffsets[]` address scratch (the rest): ours `lui t0/addiu t0`
           hoisted ABOVE the index `lbu`, oracle `lbu` first then `lui v1/addiu v1`
           -- the same lui-vs-load ready-list tie as Night_NightCalc in this TU.
           FALSIFIED here: per-site unsized `asm("goffsets")` view, sized `[8]`
           view (storage-shape menu #2/#3, both byte-identical), and an index
           split temp (27, count 188).

     ---- w50-a2 (2026-08-09): 22 -> 6, count-EXACT 189/189.  RESIDUAL CLASS (A)
     IS CLOSED -- the SLD-true inside-the-guard `objDef` now lands.  The named
     angle from w49 ("p83 refs 27->32 at zero insns") was CORRECT and the dial is
     the OPACITY FENCE `__asm__("" : "=r"(objInstance) : "0"(objInstance))`:
       (1) move `objDef = Track_gObjDefs[objInstance->pad];` INSIDE the zClipSq
           guard (SLD line 2015) -- alone this is 40 (objDef live 24 -> pri 1.0000
           steals $s0 from objInstance's 0.8307), exactly as w49 measured;
       (2) convert the loop-tail void fence into an OPACITY fence on objInstance
           (+2 refs, and the loop weight doubles them: 27 -> 31, pri 0.9538 --
           still short of objDef's 1.0000, gate still 40);
       (3) add a SECOND opacity fence on objInstance right after its init, i.e.
           OUTSIDE the loop, so its +2 refs are UNweighted: 31 -> 33, pri 1.2692
           > 1.0000.  Gate 40 -> 6 in one edit.
     reqdelta (tools/reqdelta.py on the inside-guard dump) predicted this exactly:
     `p83 refs 27->32` was one of four minimal single dials, and allocsim
     --what-if 83:refs=33 reproduces the whole retail handout 17/19 with only the
     intended p83/p84 swap.  The lesson for the TU: an ODD required ref delta
     needs an OUT-OF-LOOP inflator (in-loop fences move refs in steps of 2*depth).
     RESIDUAL 6 = class (B) only, the goffsets address scratch: ours
     `lui t0/addiu t0/addu v0,v0,t0`, oracle `lui v1/addiu v1/addu v0,v0,v1`
     (v0 = the index, correct on both sides; only the ADDRESS qty's home differs,
     t0 = hard reg 8 means regs 2..7 were all blocked over its window in ours).
     FALSIFIED IN THIS BASIN (all gated, all reverted): array-decay pointer local
     `signed char *g8 = goffsets;` (6, no change), void fence before the statement
     (6), opacity fence on objInstance before the statement (6), split index temp
     `int zo` (11, count 188 -- one SHORT), `int zo` + one opacity fence (10,
     count exact: this one FIXES the schedule -- oracle order lbu/lui/addiu/addu --
     but swaps v0<->v1 between the index and address qtys), same with a second
     fence (10, no further move), `u_char zo` + fence (8, count 191).
     NEXT ANGLE (named): the 10-diff `int zo`+fence basin is count-exact with the
     RIGHT schedule and only the two block-7 qtys' v0/v1 swapped -- block 7 holds
     4 pseudos (114 index, 116 high, 115 lo_sum, 117 sum) which combine_regs ties
     into 2-3 qtys, i.e. the w46 3-QTY LAW's hand-rolled `EXCHANGE` range.  Two
     more fences on the index (refs 12 -> 16 weighted) did NOT move it, so the
     order is NOT priority-driven there: probe the 3<->4 qty boundary (add/remove
     one DISTINCT block-local pseudo) rather than any further ref/live dial.
     w50-a2 ADDENDUM -- the 3<->4 qty-boundary probes are also falsified: in the
     `int zo`+fence basin, adding a distinct `signed char *g8 = goffsets;` pointer
     local collapses BACK to the 6-diff base shape (6), while `int zb = zo + 0;`,
     `*(goffsets + zo)` and a `u_int zo` index all stay at 10.  Two stacked
     opacity fences + the pointer local: 6.  So the block's qty count is not the
     dial either; what remains is the find_free_reg WINDOW (why regs 2..7 are
     blocked for the address qty in the 6-diff shape) -- read it off an
     instrumented-cc1 [find_free_reg] trace, not from source spellings.
     ---- w51-a10 (2026-08-09): 6 STAYS, count-exact 189/189.  Three more probes in
     the named `int zo`+opacity-fence basin (which is count-exact with the ORACLE
     SCHEDULE -- lbu first, then lui/addiu/addu -- and only the two block-7 qtys
     v0/v1 swapped): a per-site UNSIZED `asm("goffsets")` array view 10, a SIZED [8]
     view 10 (both byte-identical to the plain form, so the storage-shape menu does
     not touch this qty pair either).  Confirms the w50 addendum: the block qty COUNT
     and every ref/live dial are exhausted; what is left is the find_free_reg WINDOW
     (why regs 2..7 are blocked for the address qty in the 6-diff shape).
     ---- w61-a2 (2026-08-15): the 12D/A6 INDEX-TERM-FIRST spelling is FALSIFIED
     here too.  All four address spellings of the goffsets lookup --
     `*(signed char *)((int)objInstance->zoffset + (int)goffsets)` (index-term
     first), the same with a `(u_int)` index, the base-term-first
     `*(signed char *)((int)goffsets + (int)objInstance->zoffset)`, and the plain
     pointer form `*(objInstance->zoffset + goffsets)` -- gate IDENTICALLY at
     11 @188 (ONE SHORT), i.e. every one of them collapses to the already-recorded
     `int zo` split-temp basin, not to a new schedule.  Confirms the w50/w51
     reading: this is not an address-expression question at all; the lui-vs-lbu
     ready-list tie is decided inside sched1/find_free_reg and needs the
     instrumented-cc1 [find_free_reg] window trace, not another source spelling.
     ---- w62-a2 (2026-08-15): THAT INSTRUMENT IS NOT AVAILABLE FOR THIS FUNCTION.
     The w60-a7 lab (C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe, the only build that
     prints `[find_free_reg] ... win [a,b) blocked: ...`) is NOT byte-faithful here:
     real CC1PLPSX 186 insns vs instrumented 188, diverging at insn 2 with an
     $s6/$s7 rotation -- per 12H its trace must not be quoted for this fn.  Lab
     fidelity across this TU (scratchpad/w60a7/cmpfn.py): IDENTICAL for DoObjects,
     SubdividFacet, BuildChunkObjectFacets and BuildCustomObjectFacets; DIFFERS for
     BuildObjectFacets and DoTrough; NOT EMITTED AT ALL by the instrumented build
     for BuildSpikeBelt, OnyxLinePrim and Draw_kCtrlSkidmark.  This residual now
     needs either a faithful instrumented build or the 13A UNREACHABILITY TRIAGE
     done by hand (K overlapping local qtys can only occupy the first K free regs).
     ---- w74-a1 (2026-08-23): the WINDOW half of that verdict is withdrawn; the
     mechanism is the POST-SCHED1 CHAIN ORDER.  Read off the real compiler
     (CC1PLPSX -O2 -G4 -dS, this TU): in the post-sched1 chain the goffsets
     address pair (insn 523 `(high (symbol_ref goffsets))` -> insn 524 `lo_sum`)
     sits AHEAD of the index byte load (insn 164, `zero_extend (mem/s:QI (plus
     (reg 83) 4))`).  local-alloc numbers qtys by birth in that chain, and
     local-alloc.c:1588-1610 sorts a block of <=3 qtys with a HAND-ROLLED
     comparison over RAW qty numbers whose tie leaves qty_order = birth order --
     so the earlier-born address qty is served first and takes $v0 by the
     ascending find_free_reg scan.  Retail's opposite handout means its post-sched1
     chain had the byte load first (its FINAL code still shows lui/addiu ahead of
     the lbu -- that is sched2 moving them back, after the allocation was made).
     This explains every falsification on record here at once: ref/live dials
     cannot move a tie that is not resolved by priority, the storage-shape menu
     cannot change birth order, and the 3<->4 qty-boundary probe was aimed at the
     wrong sort arm (the tie, not the comparator).  NAMED ANGLE: a sched1-visible
     dial that keeps the address pair BELOW the index load in the pre-allocation
     chain -- read the -dS ready lists for this block first.
     ============================================================================ */
  totalCount = 0;
  group = gObjInfo->objInstanceBuf;
  objInstance = (Trk_SimpleInst *)(group + 1);
  __asm__("" : "=r"(objInstance) : "0"(objInstance));
  groupNumElements = group->m_num_elements;
  sd = (Draw_DCache *)&Render_gPalettePtr;
  /* MATCH (w46-a6): the zero-count arm RETURNS instead of assigning the
   * accumulator -- one fewer REG_N_REF on `totalCount` drops its allocno
   * below `objectIndex` (.2519 -> .2290 vs .2347), which is exactly the
   * reqdelta the s3/s4/s5 3-cycle needs. */
  if (groupNumElements == 0) {
    return 0;
  }
  {
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
    /* MATCH (w49-a2, 68 -> 34): the oracle's loop is UN-ROTATED -- the test sits at
       the loop TOP (.L800C7954 `lw t0,0x68(sp); slt v0,s4,t0; beqz v0,exit`) and the
       back-edge is an unconditional `j` whose DELAY SLOT carries `addiu s4,s4,1`.
       A `for (i=0;i<n;i++)` rotates (zero-trip guard + bottom test) and can never
       produce that; the exit-in-the-middle `while(1){ if(!(i<n)) break; ... i++; }`
       does (catalog par.B -- the same lever DrawW_StripDraw_High in this TU uses).
       SLD confirms the increment is its OWN trailing statement: the objInstance
       advance is line 2045 and the `j`+`addiu s4,s4,1` pair is line 2046. */
    objectIndex = 0;
    while (1) {
      if (!(objectIndex < groupNumElements)) break;
      if ((visList == (short *)0x0) || ((((u_short)visList[objectIndex] >> 0xc ^ 1) & 1) == 0)) {
        objectOffset = offset;
        if (offset == 0) {
          /* MATCH (w75-a6): 6 -> PASS.  THREE COUPLED PARTS, each measured alone
             and each load-bearing (a 23B(1) joint cell, not three levers):
             (1) INDEX TEMP FIRST -- `zo` is born ahead of the address;
             (2) VOID FENCE between the index and the address materialization --
                 an output-less (volatile) asm is a sched BARRIER (sched.c:1985
                 ASM_OPERANDS w/ MEM_VOLATILE_P adds a dependence on every prior
                 set + flush_pending_lists) AND a reorg stop_search_p barrier, so
                 the `lui` can no longer float above the `lbu` nor be stolen into
                 the `bnez`'s delay slot -- retail leaves that slot a `nop`;
             (3) OPACITY LAUNDER on the pointer local -- `g` gets a SECOND SET, so
                 loop.c's scan_loop never builds a movable for it (a movable needs
                 n_times_set == 1, loop.c:779).  WITHOUT it the goffsets address is
                 a loop invariant that loop.c HOISTS to the preheader -- the -dL
                 dump for this fn reads
                   `Insn 161: regno 115 (life 3), move-insn savings 2  moved to 521`
                   `Insn 162: regno 114 (life 2), move-insn forces 161  moved to 523`
                 (move_movables' gate `threshold*savings*lifetime >= insn_count`,
                 loop.c:1640, with insn_count 141) -- and in the preheader it loses
                 its register (all nine callee-saved are taken), so reload
                 REMATERIALIZES it at the use into a spill-pool scratch.  THAT is
                 the whole `lui $t0` the w50..w62 receipts below chased as a
                 "find_free_reg window" / "post-sched1 birth order": the qty was
                 never in local-alloc's hands at all.  Killing the movable makes it
                 block-local and local-alloc hands it retail's $v1.
             DEVICE-REMOVAL RE-TEST (23B(3)), all re-gated at this basin:
               fence only, no pointer local, no launder .......... 10 (still hoisted)
               fence + pointer local, no launder ................. 6 (still hoisted)
               fence + launder, subscript form `g[zo]` ........... 2 (addu operand
                                                                     order only)
               fence + launder + index-term-first cast ........... PASS
             The index-term-first cast is what flips `addu v0,v1,v0` to retail's
             `addu v0,v0,v1`; the w61-a2 falsification of that same 12D spelling
             was priced in the OLD (hoisted) basin -- 21E(1) re-pricing. */
          { int zo = objInstance->zoffset; /* SYM-CODEGEN-CARRIER: zo -- index temp is one part of the measured PASS joint cell */
            signed char *g;               /* SYM-CODEGEN-CARRIER: g -- second SET prevents loop.c hoisting; removing it loses PASS */
            __asm__("" : : "i"(0));
            g = goffsets;
            __asm__("" : "=r"(g) : "0"(g));
            objectOffset = *(signed char *)(zo + (int)g); }
        }
        /* SYM block-scoping (line70/71 vs 95/107/114, all converging on the shared
           loop-tail at line124/132) + the oracle's flat forward-beq compare chain
           (==1 / <2-skip / ==3 / ==7 / skip) with BOTH case bodies pushed OUT OF LINE
           after the chain -- neither a plain if/else-if (inlines case1) nor a switch
           (gcc picks a range-check lowering for {1,3,7}) reproduces this; an explicit
           goto dispatch matches the oracle's actual block layout 1:1. */
        animType = objInstance->type;
        if (animType == 1) goto animCase1;
        if (animType < 2) goto animNext;
        if ((animType == 3) || (animType == 7)) goto animCase37;
        goto animNext;
      animCase1:
        objDef = Track_gObjDefs[objInstance->pad];
        /* MATCH (w46-a6): the oracle has NO materialized boolean here -- every
         * guard branches DIRECTLY to the shared loop tail (`beqz $t0,.L800C7A24`
         * @0x800C7A08 with an ARG SETUP in its delay slot, `bnez $v0,.L800C7B54`,
         * `beq $s6,$t0,.L800C7A44`, `beqz $v0,.L800C7B54`).  The `&&`/`||`
         * compound form made cc1plus build the flag in a callee-saved reg
         * (`move s2,zero` / `li s2,1` / `beqz s2`) = +2 insns AND it stole the
         * delay slot the oracle fills with `addu $a0,$s7,$zero`. */
        if (doFrustumClip != 0) {
          if (ObjectClipped(Vi,(int)objInstance->pad,(coorddef *)&objInstance->x,
                            (Draw_tGiveShelbyMoreCache *)sd) != 0) goto animNext;
        }
        if (zClipSq != -1) {
          if (zClipSq <= xzsquaredist32((coorddef *)&objInstance->x,
                                        &(Vi->cview).translation)) goto animNext;
        }
        /* MATCH (w46-a6): retail accumulates the RETURN VALUE directly --
         * `jal DrawObjectSimple; j .L800C7B54; addu $s5,$s5,$v0` -- it never
         * writes it back into `objectOffset` (SYM $s2, which stays the INPUT
         * arg, `sw $s2,0x10($sp)`).  Round-tripping it through objectOffset
         * added 2 loop-weighted refs per call site to that allocno. */
        totalCount = totalCount + DrawObjectSimple(Vi,sd,objDef,
                           (coorddef *)&objInstance->x,objectOffset);
        goto animNext;
      animCase37:
        Anim_GetRotPos((Trk_AnimateInst *)objInstance,1,
                       DrawW_GetAnimationTime((Trk_AnimateInst *)objInstance),&cp,&matrix);
        /* MATCH (w49-a2): the SYM's fn-scope `objDef` ($s1) is REUSED here -- the
           oracle loads the shape argument into that same $s1 (`lw s1,0(v0)`), not an
           anonymous temp.  Placed BEFORE the zClipSq guard on purpose: the SLD puts
           retail's copy INSIDE the guard (line 2015), but that shortens objDef's live
           range to 24 and it then outranks objInstance for $s0 (40 diffs vs 22 here) --
           see the head receipt, residual class (A). */
        if ((zClipSq == -1) ||
           (xzsquaredist32(&cp,&(Vi->cview).translation) < zClipSq)) {
          objDef = Track_gObjDefs[objInstance->pad];
          totalCount = totalCount + DrawObjectTransform(Vi,sd,&matrix,
                             objDef,&cp,objectOffset,-1);
          if ((objInstance->flags & 2) != 0) {
            pt2.x = cp.x + matrix.m[6] * -0x10;
            pt2.y = cp.y + matrix.m[7] * -0x10;
            pt2.z = cp.z + matrix.m[8] * -0x10;
            Flare_Halo2(Vi,-1,0x1e,&cp,&pt2,(Draw_FlareCache *)sd);
          }
        }
      animNext:;
      }
      objInstance = (Trk_SimpleInst *)((int)&objInstance->size + (int)objInstance->size);
      /* MATCH (w49-a2): zero-insn scheduling fence.  The oracle's loop tail is
         `lh v0,0(s0); nop; addu s0,s0,v0; j .Ltop; addiu s4,s4,1` -- it PAYS the
         lh load-delay nop and spends the `j` slot on the counter increment.  Ours
         hoisted the increment into the lh's delay slot and then had to put the
         pointer advance in the `j` slot, landing 1 insn SHORT (188 vs 189).  The
         w48 void-tail fence keeps the increment below the advance (count exact).
         Falsified first: inc-before-advance, char*-advance, split-temp advance --
         all byte-identical (sched2 refills the slot every time). */
      __asm__("" : "=r"(objInstance) : "0"(objInstance));
      objectIndex = objectIndex + 1;
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
  /* ================= RECEIPT (w46-a6) -- PARKED at 120 (ours 192 / oracle 200),
     BUT THE MISSING ALLOCNO IS NOW NAMED AND COUNTED. =========================
     The w45 receipt was right that this is the w40 ARG-SPILL class; what it could
     not say is WHICH pseudo retail has that we lack.  allocsim on our object
     (model reproduces our handout 18/18 IDENTICAL) shows we use only EIGHT
     callee-saved registers -- s0,s1,s3,s4,s5,s6,s7,fp, with s2 NEVER TOUCHED --
     while the SYM's mask is $c0ff0000 = NINE (s0-s7 + fp).  `sd` (p81, the a1
     param, carrying a REG_EQUIV note for its ARG home at `(mem (plus $0 4))`)
     simply fills the vacancy at rank 7.  So it is not that sd outranks something:
     WE ARE ONE REAL ALLOCNO SHORT, and the vacancy is exactly $s2.

     THE SYM 8c BLOCK NAMES ALL NINE (@0x800C7B9C, fsize 128):
        Vi   ARG @0x00   sd  ARG @0x04   simObjs ARG @0x08   zClipSq ARG @0x10
        group REGPARM $7=a3                     offsets STAT ARY CHAR[8]
        objInstance             REG $0x14 = s4  (Trk_SimpleInst *)
        objDef                  REG $0x1e = fp  (Trk_ObjectDef *)
        totalCount              AUTO -0x30      groupNumElements AUTO -0x2c
        objectIndex             REG $0x17 = s7  (block line 16)
        objectOffset            REG $0x16 = s6  (block line 20, with matrix AUTO -0x60)
        objCollideBoomInstance  REG $0x12 = s2  (block line 28)  <-- THE VACANCY
        quat AUTO -0x38 (block line 36)
        t1 $0x15=s5  t2 $0x13=s3  sx $0x10=s0  sy $0x11=s1  sz $0x12=s2  (block line 50)
     and the oracle confirms objCollideBoomInstance is a SECOND WALKER over the
     same record: `addu $s2,$s4,$zero` @0x800C7C88 (in the Object_GetAnim jal's
     DELAY SLOT -- i.e. it is the `objMat_p = (int)simObjs` comma-expression slot
     in our source), then `lwl/lwr $t0,0x17/0x14($s2)`, `lh $s0,0x1C($s2)`,
     `lh $s1,0x1E($s2)`, `lh $s2,0x20($s2)` (sz recycling the dead pointer's reg),
     while `$s4` keeps the +2/+4/+6/+8/+0x22 accesses.  Our recon fuses BOTH into
     the single fabricated `groupBase_p` int, and fuses t1/t2 into three invented
     temps (iVar3/iVar11_emit/iVar4) -- so two SYM allocnos never exist.

     MEASURED THIS WAVE (all reverted; the numbers ARE the receipt):
        base                                       120  (192/200) posdiff 79
        + objCollideBoomInstance walker (cbi)      248  (188/200) posdiff 165
        + t1/t2/sx/sy/sz SYM names (t12)           245  (185/200) posdiff 165
        + BOTH                                     229  (197/200) posdiff 120
     i.e. the pair moves the COUNT from 8-short to 3-short (the monotone metric
     the briefing says to judge on) but scrambles the LCS, because with the two
     new allocnos in play the assignment rotates wholesale:
        p154 groupBase_p+8   -> s0     p120 flag            -> s1
        p102 fixedmult res   -> s3     p105 fixedmult res   -> s4
        p104 groupBase_p     -> s5     p85  objCBI          -> s6
        p81  sd              -> s7     p121 tc4 (offsets[]) -> fp
     -- and `sd` STILL takes s7 because tc4/groupBase_p+8/the flag are occupying
     ranks the SYM assigns to objectIndex/objectOffset/objDef.  In other words the
     partial rewrite adds the right allocnos but leaves the WRONG ones alive.
     `sw $a1,0x84($sp)` (the gate the briefing names) never appears in either
     variant -- checked programmatically with tools/ourdis.py each time.

     NEW NAMED ANGLE (this is a WHOLE-FUNCTION rule-8 job, not a dial, and it is
     the same job that took DrawW_BuildObjectFacets 130->68 this wave):
       1. Materialize the SYM's nine REG locals VERBATIM and DELETE the ~20
          fabricated ones (objDef_00, pOVar5, iVar3/4/6/11_emit, objMat_p,
          objDef_p, instData_p, buildResult, loc_20/24/28/68/6c/70, tu6, t2 as
          used today, blend_x/y/z, groupBase_p) -- the catalog's
          "SYM-empty-locals => DELETE invented temps" row is worth 100-500 diffs
          on functions this size and it CHANGES WHICH REGISTER CLASS the params
          land in.
       2. Keep `objInstance` ($s4) as the ONLY loop walker and derive
          `objCollideBoomInstance` from it in the Object_GetAnim delay slot.
       3. `totalCount` and `groupNumElements` are AUTO in the SYM -- their DECL
          POSITION is the frame layout (w41), and the oracle's `sw $zero,0x50($sp)`
          / `sw $a3,0x54($sp)` fixes their slots.
       4. Only then re-measure the ARG spill; per allocsim, sd loses its register
          the moment a NINTH genuine allocno outranks it, which the SYM's own set
          supplies ($s2 = objCollideBoomInstance).
     ---- w71-a1 (2026-08-21): 105 -> 28, count-EXACT 200/200.  The w46 plan above
     was right; it just needed all four pieces landed TOGETHER.  What landed, in the
     order the receipts were taken:
       (1) FULL rule-8 SYM REWRITE (105 -> 231, count 189 -> 199).  Deleted the ~20
           fabricated Ghidra locals and materialized the SYM's own set verbatim:
           `objInstance` (Trk_SimpleInst*, replacing the `groupBase_p` int),
           `objCollideBoomInstance` (the SECOND walker), `objDef`, `objectIndex`,
           `objectOffset`, `t1`+`t2` (TWO fixedmult temps -- the old single temp let
           the second result go straight from $v0 to its stack slot, one insn short
           per row), `sx/sy/sz`, plus the un-rotated `while(1){if(!(i<n))break;...}`
           loop and the loop-tail fence.  The intermediate gate is WORSE because the
           allocno set is now right but the PRIORITIES are not -- do not judge this
           step alone.
       (2) `sd` REF REDUCTION -> the ARG SPILL (231 -> 214, count EXACT 200/200).
           Spelling the matB zeroing through a local `MATRIX *transMat = &sd->matB;`
           drops sd's REG_N_REFS 11 -> 9, which is exactly the allocsim
           `--what-if 81:refs=9` handout: sd falls below objDef/objectIndex in
           allocno_compare and goes back to its incoming ARG home.  The head block
           then matches the oracle BYTE FOR BYTE (prologue, `bnez` guard polarity,
           `lw t0,132(sp); nop; addiu v0,t0,20`, the three matB stores) -- all three
           of those were separate open items in earlier waves and all three are
           DOWNSTREAM of the spill, exactly as w44/w45 suspected.
       (3) 🔑 `objCollideBoomInstance` ASSIGNED UNCONDITIONALLY (214 -> 83, frame
           136 -> 128).  THE BIG ONE, and the reason four waves of allocno dials
           could not find it.  The old recon hid the assignment inside the `||`
           guard's comma-expression, so flow.c could not prove it was set on every
           path: the .lreg dump says `Register 85 ... dies in 0 places`, i.e. gcc
           kept it live ACROSS THE LOOP BACK-EDGE, which made it conflict with hard
           regs $s0/$s1/$s2 -- the three blend qtys local-alloc had already parked
           there.  With no free callee-saved reg left, `objDef` spilled to a fresh
           stack slot and the whole frame grew 8 bytes, mis-aligning every single
           sp displacement in the function.  Retail materializes it with
           `addu $s2,$s4,$zero` in a branch DELAY SLOT -- and a delay slot executes
           on BOTH paths, so the statement is UNCONDITIONAL in the source.  Lifting
           it out of the comma lets it die at its last use, frees $s2 for it, and
           the whole 5-way rotation (objInstance $s4, t1 $s5, objCBI $s2,
           objectOffset $s6, objectIndex $s7, objDef $fp) lands at once.
           🔴 GENERAL LAW: a value the oracle computes in a DELAY SLOT is
           unconditional; writing it as a comma-expression inside a short-circuit
           guard makes it loop-carried-live and poisons the whole allocation.
       (4) LOOP-TOP BARRIER FENCE (83 -> 82, count 199 -> EXACT 200).  Retail leaves
           the loop-exit `beqz`'s delay slot EMPTY; ours filled it with the
           `lui %hi(offsets)`.  A barrier fence immediately after the exit test is
           the A9 law (a) used deliberately: below a loop-exit test a barrier BLOCKS
           the branch delay-slot fill.
       (5) POINTER-FORM `offsets` LOOKUP (82 -> 28).  `*(offsets + objInstance->
           zoffset)` instead of the subscript `offsets[...]`.  Same value, but the
           INDIRECT_REF tree reorders the whole block to retail's
           `lui/addiu ; lbu ; lbu ; addu ; li 5 ; lb` (the `li 5` moves AFTER the
           address add, which is what lets the scratch and the constant share a
           register); the ARRAY_REF form gates 70.  Measured equivalents, all 16:
           the 12D index-term-first cast `*(signed char *)((int)obj->zoffset +
           (int)offsets)`, its `(u_int)` variant, and the base-term-first cast --
           i.e. here the dial is SUBSCRIPT-vs-POINTER, not operand order.
           ⚠️ the same lookup class is FALSIFIED in DrawW_BuildObjectFacets in this
           very TU -- SITE-SELECTIVE (12D caveat); price it per site, never blanket.
       (6) THIRD NAMED TEMP `t3` FOR THE m[6]/m[7]/m[8] RESULT (28 -> 16).  Retail
           emits each row as `sw m[0]; sw m[3]; jal <next row>; [ds] sw m[6]` -- the
           m[6] store is the LAST of the three in scheduling order.  With only t1/t2
           named, `matrix.m[6] = fixedmult(...)` is a store-of-a-call-result and gcc
           emits it FIRST, sinking `sw s3,44(sp)` into the delay slot instead.  A
           third plain int local (dies straight into its store, so it costs no
           callee-saved reg -- it lives in $v0) puts all three stores in retail's
           order and fixes rows 1 and 2 in one edit.  The SYM names only t1/t2, so
           t3 is a compiler temp given a name; keep it.
       + the in-loop OPACITY fence on `objInstance` at the loop tail (was a void
         fence): +2 loop-weighted refs lift it above `t1` in allocno_compare so it
         takes retail's $s4 (allocsim --what-if 95:refs=32).
     RESIDUAL 16 = TWO classes, both count-neutral:
       (A) 7 diffs: the `offsets` block's two block-local qtys are v0<->v1 swapped
           (ours address in $v0 / index in $v1, retail the reverse) -- the SAME
           find_free_reg window tie as DrawW_BuildObjectFacets' goffsets residual,
           and every ref/live/storage-shape dial is already falsified there.
           ---- w72-a1 (2026-08-22): the 21A(1)/20B HARD-REG-DENIAL family measured
           here for the first time (base 16 @200/200, all reverted):
             pointer local + opacity launder + "$2" clobber          158 @202
             read-only fence on objectOffset + "$2" clobber (after)   17 @201
             `int zo` index split + read-only fence (no clobber)      17 @201
             pointer local + read-only fence + "$2" clobber           75 @203
           The clobber DOES deny $v0 (the address qty visibly leaves it) but the
           freed register goes to the WRONG qty and the block re-colours -- the same
           verdict W70 reached on DrawW_DoObjects' $a0 clobber.  Under the clobber
           the address qty lands in $t2 (hard reg 10), i.e. regs 3..9 are ALL blocked
           over its window, so this is a find_free_reg WINDOW question, not a
           priority one.  The instrumented cc1plus IS byte-faithful for THIS function
           (w62-a2), so the [find_free_reg] window trace is available and is the
           named next instrument.
           ---- w74-a1 (2026-08-23): THAT NAMED INSTRUMENT IS NOT AVAILABLE ANY
           MORE -- the w62-a2 fidelity claim is STALE at this basin.  Re-measured:
           the instrumented cc1plus-ecoff and the real CC1PLPSX now DIVERGE on this
           function (both 197 insns, different streams), and they diverge EXACTLY
           in the `offsets` block -- the lab emits `lui $10 / addiu $10 / li $3,5 /
           lbu $2,4($20) / lbu $4,2($20) / addu $2,$2,$10 / lb $22,0($2)` (address
           in $t2, the constant hoisted ahead of both byte loads) where the real
           compiler emits the base shape.  A [find_free_reg] window read off that
           trace would describe a DIFFERENT allocation problem.  Re-check fidelity
           (per FUNCTION, not per TU) before quoting the lab here again.
           WHAT THE REAL COMPILER SAYS INSTEAD (CC1PLPSX -dS on this TU): the
           address pair and the index load are BOTH block-local, and in the
           POST-SCHED1 chain the `high`/`lo_sum` pair sits BEFORE the index byte
           load, so it takes the lower qty number.  local-alloc.c:1588-1610 orders
           a <=3-qty block by a hand-rolled comparison that falls back to the RAW
           qty number when the priorities tie -- which is exactly what every
           falsified ref/live dial has been telling us.  The dial is therefore the
           POST-SCHED1 ORDER of those two, not a find_free_reg window and not a
           priority; same verdict and same class as DrawW_BuildObjectFacets'
           goffsets residual in this TU.
       (B) 1 diff: `lh s2,32(s4)` vs `lh s2,32(s2)` -- a deliberate trade, see the
           MATCH note at the `sz` statement (reading it through objCollideBoomInstance
           re-inflates p85's refs and rotates objInstance off $s4: gate 83 -> 119,
           and 64 in the post-(5) basin; with a compensating out-of-loop fence 29).
     (the old class (C) -- the fixedmult store order -- is CLOSED by lever (6).)
     ============================================================================ */

  /* ---- rule-8 SYM rewrite (w71-a1). The SYM 8c block @0x800C7B9C names EVERY
     local; the ~20 fabricated Ghidra temps are gone and the SYM's own set is
     materialized verbatim (see the w46-a6 receipt above for the full listing):
        objInstance $0x14=s4 · objDef $0x1e=fp · totalCount/groupNumElements AUTO
        objectIndex $0x17=s7 · matrix AUTO · objectOffset $0x16=s6
        objCollideBoomInstance $0x12=s2 (the SECOND walker, block line 28)
        quat AUTO · t1 $0x15=s5 · t2 $0x13=s3 · sx/sy/sz $0x10/$0x11/$0x12
     = NINE callee-saved allocnos (mask $c0ff0000), which is exactly the pool
     that pushes the `sd` ARG back out to its incoming stack home. */
  Trk_CollideBoomInst * objCollideBoomInstance;
  int objDef_p;
  int buildResult;
  int instData_p;
  ObjectAnim *pOVar5;
  MATRIX *transMat;
  int sx;
  int sy;
  int sz;
  int t2;
  int t3;
  Trk_SimpleInst *objInstance;
  int t1;
  int objectOffset;
  int objectIndex;
  Trk_ObjectDef *objDef;
  matrixtdef matrix;
  tQuat quat;
  int totalCount;
  int groupNumElements;
  int bVar7;   /* MATCH (w40-a2): a u_char flag makes cc1plus re-mask on every use
                  (`andi v0,s1,255` x3) -- the oracle tests it bare (`bnez s1`), so the
                  original local was int-width (catalog par.C u_char->u_int lever). */
  u_char tc5;
  /* SYM (rule-8, nfs4-f-v3.txt:191805): `offsets` is a FUNCTION-SCOPE STATIC of
     THIS function (`96 Def2 class STAT type ARY CHAR size 8 dims 1 8`, recorded
     inside this fn's 8c block; unlike the file-scope static `goffsets` it has no
     symbol-table entry at all).  `signed char` because the oracle reads it with
     `lb` @0x800C7C3C and entry 4 is -1 -- plain `char` is UNSIGNED on this build,
     which read it as +255 (a real z-offset bug). */
  static signed char offsets[8] = { 125, 125, 50, 15, -1, 125, 0, 0 };   /* @0x8013D828 */

  /* w53-a1 LANDED (120 -> 110, still ours 192 / oracle 200): the element
     count was carried by a FABRICATED `iVar6` while the SYM's own AUTO
     `groupNumElements` sat DECLARED-BUT-UNUSED right after `totalCount`.
     Deleting the fake decl and renaming every use to the SYM local fixes the
     FRAME LAYOUT: reload slots the two AUTOs in pseudo order, so ours now
     emits `sw zero,80(sp)` (totalCount) / `sw a3,84(sp)` (groupNumElements) --
     the oracle's slots; before, they were swapped (84/80) and every
     displacement in the head block differed.  Falsified in the same basin:
     swapping the two INIT STATEMENTS (120, no-op -- the dial is the decl set,
     not the statement order) and merely MOVING the `int iVar6;` decl next to
     `totalCount` while keeping the fake name (120).  The remaining 10-insn
     head gap is unchanged and is still the w46-a6 ARG-SPILL vacancy below. */
  objInstance = (Trk_SimpleInst *)(group + 1);
  totalCount = 0;
  groupNumElements = group->m_num_elements;
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
  if (groupNumElements == 0) {
    return 0;
  }
  {
    /* MATCH (2026-07-11, correctness bug): gte_SetTransMatrix was reading a
       fabricated/wrong global (CF_DVLC -- a video-buffer symbol, completely
       unrelated) instead of the just-zeroed sd->matB the oracle loads (`lw
       t0,132(sp); addiu v0,t0,20` = &sd->matB, ctc2 t4/t5/t6,5/6/7). This would
       have fed garbage into the GTE's rotation-matrix control regs for every
       custom-object draw. */
    /* MATCH (w71-a1): retail reloads the SPILLED `sd` ARG ONCE here
       (`lw t0,132(sp); nop; addiu v0,t0,20`) and drives the two upper
       translation words off that `&sd->matB` pointer (`sw zero,28(v0)`,
       `sw zero,24(v0)`) while t[0] goes through the base (`sw zero,40(t0)`).
       Spelling the block through a local MATRIX* also drops `sd`'s REG_N_REFS
       from 11 to 9, which is what pushes it below objDef/objectIndex in
       allocno_compare and back out to its incoming stack home (allocsim
       --what-if 81:refs=9 reproduces exactly that handout). */
    transMat = &sd->matB;
    transMat->t[2] = 0;
    transMat->t[1] = 0;
    (sd->matB).t[0] = 0;
gte_SetTransMatrix(transMat);
    /* W76-A6: zero-insn OUT-OF-LOOP opacity launder on the walker -- +2
       unweighted REG_N_REFS on objInstance so it stays above t1 in
       allocno_compare now that sz reads through objCollideBoomInstance
       (which re-inflates p85 by one loop-weighted ref).  Position matters:
       at the head block (before groupNumElements) it costs the guard
       polarity / a store slot (3 @199); here, inside the guarded body
       (24D-6), it is free and the fn is PASS 200/200. */
    __asm__("" : "=r"(objInstance) : "0"(objInstance));
    /* MATCH (w71-a1): the oracle's element loop is UN-ROTATED -- the test sits at
       the loop TOP (`lw t1,84(sp); nop; slt v0,s7,t1; beqz v0,exit`) and the
       back-edge is an unconditional `j` whose DELAY SLOT carries `addiu s7,s7,1`
       AFTER the `addu s4,s4,v0` walker advance (which pays its own `lh` load-delay
       nop).  Same shape + zero-insn void fence as DrawW_BuildObjectFacets. */
    objectIndex = 0;
    while (1) {
      if (!(objectIndex < groupNumElements)) break;
      __asm__("" : : "i"(0));
      /* MATCH (w75-a6): 16 -> 6, count-EXACT 200/200.  RESIDUAL CLASS (A) BELOW
         IS HALF-CLOSED: the `offsets` block's two block-local qtys are no longer
         v0<->v1 swapped -- ours now has retail's address=$v1 / index=$v0 and the
         only diffs left in the block are the EMISSION SLOTS of the two byte loads.
         THE DIAL IS NOT BIRTH ORDER (the w74 reading) BUT QTY PRIORITY.  Splitting
         the index into `zo` and OPACITY-LAUNDERING it (non-volatile, tied, zero
         insns) puts +2 refs on the index qty, which lifts QTY_CMP_PRI (local-alloc.c
         :1665, floor_log2(refs)*refs*size/live) above the address qty's, so the
         index is allocated FIRST and takes $v0 by find_free_reg's ascending scan.
         POSITION IS LOAD-BEARING: the launder must sit BEFORE the `tc5` load --
         after it the same device gates 17 @201.
         WHY NOT A VOLATILE (output-less) FENCE: sched.c:1985 makes a volatile asm
         depend on every prior set and flush_pending_lists, so every later
         register-setter gets a REG_DEP_OUTPUT on it while every memory reader gets
         a plain data dep -- rank_for_schedule's class test (class 2 > class 1) then
         puts the `lui` AHEAD of the `lbu` unconditionally.  That is exactly what
         the loop-top void fence does here, and it is why every read-only-fence and
         barrier-position probe below failed.  A non-volatile tied launder adds the
         refs WITHOUT the dependence storm.
         MEASURED THIS WAVE (all re-gated, all reverted unless noted):
           plain `int zo` split / index-term-first cast / both ......... 16 (no move)
           pointer local `signed char *g = offsets` (no launder) ....... 70 @200
              (loop.c hoists it, reload remats it into $t2 -- the same movable
               mechanism as DrawW_BuildObjectFacets' goffsets, see there)
           pointer local + opacity launder ............................. 20 @202
           loop-top fence deleted ..................................... 17 @199
           loop-top fence -> non-volatile launder on objInstance ....... 16
           loop-top fence moved after tc5 / after the lookup ........... 17 @201 / 20
           `zo` + opacity launder AFTER the tc5 load ................... 17 @201
           `zo` + opacity launder BEFORE the tc5 load (LANDED) ......... 6 @200
           + laundered pointer local for the address (address-first
             emission order, retail's) ................................ 5 @201 --
              ONE LONG: retail fills the `lbu $v0,4($s4)` load-delay slot with the
              type load, ours emits it after `li $v0,5` and pays a nop.  That basin
              is the crisper NEXT ANGLE (one sched2 slot from count-exact + PASS
              modulo class (B)); it is recorded in scratchpad/w75/d10.json.
           class (B) re-price on BOTH new bases (21E(1)) ............... 44 / 45
              -- reading `sz` through objCollideBoomInstance still costs, so the
              deliberate `lh s2,32(s4)` trade below STANDS. */
      /* ==== W76-A6 (2026-08-23): 6 -> PASS 200/200, ALL residual classes closed.
         (1) The d10 basin (laundered pointer `g` + laundered `zo`) was ONE nop
             long: the zo launder is ON THE DATAFLOW PATH (lbu zo -> asm -> addu),
             so sched2 can never move it out of the zoffset load-delay slot and the
             zero-byte asm EATS the slot (24D-4).  Every attempt to make the asm
             depend on the type load (24D-4's named cure) dragged the QI operand
             into the allocation and minted an `andi 255` / re-colored the block
             (measured: tc5-before-launder 13, "r"(tc5) 11, "r"(load-expr) 65,
             "r"((int)load-expr) 11 -- all @201).
         (2) THE UNMEASURED CELL WINS: g laundered + PLAIN `int zo` split (no zo
             device at all) = 2 @200/200.  In the g-basin the address qty already
             has +2 refs from ITS OWN launder, so the index needs no boost; W75's
             zo launder was only compensating for the address hoist that the g
             launder now kills at the source (24E-8).  Retail emission order
             (lui/addiu ; lbu zo ; [slot] lbu type ; addu ; li 5 ; lb) and retail
             registers (address $v1, index $v0) both come out for free.
         (3) With (2) landed, the class-(B) `lh s2,32(s4)` trade RE-PRICED (21E-1)
             and FELL: sz through objCollideBoomInstance costs 44 alone, but with a
             compensating OUT-OF-LOOP launder on objInstance (after
             gte_SetTransMatrix, +2 unweighted refs keeping p95 above t1) the whole
             fn is PASS -- see the two edits below.  Device-removal re-test: minus
             loop-top fence 1 @199 (the empty-beqz-slot law), minus tail launder
             45 @199, minus g launder 68 -- all three stay. */
      { signed char *g;
        int zo;
        g = offsets;
        __asm__("" : "=r"(g) : "0"(g));
        zo = objInstance->zoffset;
        tc5 = objInstance->type;
        objectOffset = *(signed char *)(zo + (int)g); }
      if ((tc5 == 5) || (tc5 == 2)) {
        objDef = Track_gObjDefs[objInstance->pad];
        /* MATCH (w71-a1, rule-8): the SYM's `objCollideBoomInstance` ($s2) is a
           SECOND walker aliasing objInstance -- retail materializes it with
           `addu $s2,$s4,$zero` in THIS `beq`'s delay slot @0x800C7C88 and then
           reads the quaternion (+0x14) and the sx/sy/sz blends (+0x1c/+0x1e/+0x20)
           through it, while $s4 keeps the +0/+2/+4/+6/+8/+0x22 accesses.  The old
           recon fused both into one fabricated `groupBase_p` int, so one of the
           nine SYM allocnos never existed and `sd` kept the vacant register
           instead of falling back to its incoming ARG home. */
        objCollideBoomInstance = (Trk_CollideBoomInst *)objInstance;
        if ((tc5 == 2) ||
           (objDef_p = (int)Object_GetAnim(simObjs + ((u_char *)objInstance)[0x22]), objDef_p == 0)) {
          buildResult = xzsquaredist32((coorddef *)&objInstance->x,&(Vi->cview).translation);
          bVar7 = 0;
          if ((zClipSq <= buildResult) ||
             ((objInstance->type == 2 &&
              (instData_p = (int)ObjectClipped(Vi,(int)objInstance->pad,
                                            (coorddef *)&objInstance->x,
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
              *(struct Pack8 *)&quat = *(struct Pack8 *)&objCollideBoomInstance->qx;
            }
            Quatern_QuatToMat(&quat,&matrix);
            sx = (int)objCollideBoomInstance->sx << 8;
            sy = (int)objCollideBoomInstance->sy << 8;
            /* MATCH (W76-A6, retiring the w71-a1 trade): retail reads ALL of
               quat/sx/sy/sz through $s2 (`lh s2,32(s2)`), and in the g-basin the
               p85 ref-inflation is paid for by the out-of-loop objInstance launder
               after gte_SetTransMatrix (+2 unweighted refs keep p95 above t1) --
               the old one-diff `lh s2,32(s4)` trade is gone and the fn is PASS. */
            sz = (int)objCollideBoomInstance->sz << 8;
            /* MATCH (w62-a2): retail STORES the two saved results BEFORE the
             * third fixedmult call of each row -- `sw s5,32(sp); sw s3,44(sp);
             * jal fixedmult; [ds] sw v0,56(sp)`.  Calling m[6]/m[7]/m[8] first
             * (the old order) emits the two stores after the call instead.
             * 110 -> 105 (count 192 -> 189; the 11-insn deficit is the
             * still-open ARG-SPILL/second-walker gap receipted above). */
            /* MATCH (w71-a1, rule-8): the SYM 8c block declares TWO int REG locals
             * here -- `t1` ($0x15 = $s5) and `t2` ($0x13 = $s3) -- and retail keeps
             * BOTH results live ACROSS the row's third fixedmult call:
             *   jal fixedmult; addu s5,v0,zero   (t1 = m[0]*sx)
             *   jal fixedmult; addu s3,v0,zero   (t2 = m[3]*sx)
             *   jal fixedmult                    (m[6]*sx, result still in v0)
             *   sw s5,32(sp); sw s3,44(sp); jal <next row>; [ds] sw v0,56(sp)
             * Writing the two stores BEFORE the m[6] call (the w62 order) lets the
             * SECOND result go straight from $v0 into its stack slot -- one insn
             * short per row and only ONE of the two temps ever gets a register. */
            t1 = fixedmult(matrix.m[0],sx);
            t2 = fixedmult(matrix.m[3],sx);
            t3 = fixedmult(matrix.m[6],sx);
            matrix.m[0] = t1;
            matrix.m[3] = t2;
            matrix.m[6] = t3;
            t1 = fixedmult(matrix.m[1],sy);
            t2 = fixedmult(matrix.m[4],sy);
            t3 = fixedmult(matrix.m[7],sy);
            matrix.m[1] = t1;
            matrix.m[4] = t2;
            matrix.m[7] = t3;
            t1 = fixedmult(matrix.m[2],sz);
            t2 = fixedmult(matrix.m[5],sz);
            t3 = fixedmult(matrix.m[8],sz);
            matrix.m[2] = t1;
            matrix.m[5] = t2;
            matrix.m[8] = t3;
            totalCount = totalCount +
                         DrawObjectTransform(Vi,sd,&matrix,objDef,
                               (coorddef *)&objInstance->x,objectOffset,-1);
          }
        }
        else {
          pOVar5 = Object_GetAnim(simObjs + ((u_char *)objInstance)[0x22]);
          (*(*pOVar5->_vf)[2].pfn)
                    ((int)&pOVar5->_vf + (int)(*pOVar5->_vf)[2].delta,Vi,sd,objectOffset);
        }
      }
      objInstance = (Trk_SimpleInst *)((int)objInstance + (int)objInstance->size);
      /* MATCH (w71-a1): zero-insn OPACITY fence, doing two jobs at once.
         (a) SCHEDULING: retail pays the `lh` load-delay nop, advances the walker,
             and spends the `j` back-edge slot on the counter increment; without a
             fence sched2 hoists the increment into the lh's delay slot and the
             tail comes out one insn SHORT.
         (b) ALLOCNO PRIORITY: it adds +2 REG_N_REFS on `objInstance` and the loop
             weight doubles them, lifting it above `t1` in allocno_compare so it
             takes retail's $s4 and t1 falls to $s5 (allocsim --what-if 95:refs=32
             reproduces exactly that flip).  Paired with the out-of-loop fence at
             the walker's init, which supplies the odd +2 the in-loop steps cannot
             (in-loop fences move refs in steps of 2*depth -- w50-a2 law). */
      __asm__("" : "=r"(objInstance) : "0"(objInstance));
      objectIndex = objectIndex + 1;
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

  /* w46-a7 RECEIPT -- 5 diffs, ours 190 / oracle 189 (the +1 is a load-delay `nop`).
     PROLOGUE PARAM-COPY SINK (the same named class as DrawW_DoLines in this TU):
     the 5th parameter `offset` arrives in the stack arg slot; retail loads it with
     `lw s5,96(sp)` at insn 16, using it to FILL the load-delay slot after
     `lbu v0,3(s4)`, and therefore leaves `sw s5,68(sp)` inside the normal save run
     at 9.  We load it at insn 6, immediately after hoisting its save to insn 5, and
     pay a `nop` where retail has the load.  Identical insn multiset otherwise --
     chunkdiff: 3 runs, 4 insns.
     FALSIFIED this wave (all 5, byte-identical): three statement positions for
     `*(int *)&sd[1].head.clipW = offset;` (last in the group / after the mirror
     store / first); zero-insn USE fences on shapeDef_p, drawResult and isCullable
     placed inside the same statement group.  The copy/load is emitted by
     assign_parms at function entry, BEFORE any body statement, so no source
     position can reach it -- consistent with DoLines, where the same class also
     ignored every statement move.
     NEW NAMED ANGLE: the only reachable dial is the load's SCHED PRIORITY, i.e. the
     depth of its dependence chain to the end of the entry block.  Its sole consumer
     here is `sw s5,236(s0)`.  Lengthen that chain (make `offset` feed something with
     a longer tail, or shorten the chain of whatever currently outranks it) and the
     load sinks to the delay slot on its own.  Read the two candidates' priorities
     off cc1 -dR (sched2) for this fn before touching source. */
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
     RESIDUAL 68 = the pointer-chase deficit + sra/srl tie + coloring cascade.
     w50-a2 RE-GATE: 5 diffs, ours 190 / oracle 189 = ONE LONG.  The residual is
     the 5th (STACK) argument `offset`: assign_parms reloads it at entry
     (`sw s5,68(sp); lw s5,96(sp)` as insns 6-7) and the resulting load-delay
     `nop` is the extra instruction, whereas retail SINKS the reload to fill the
     `lbu $v0,3($s4)` load-delay slot 11 insns later.  Same family as
     DrawW_DoLines' param-copy residual -- but the DoLines cure (index-form giv
     init) has no analogue here: `offset` is a plain value, not a walk base.
     FALSIFIED THIS WAVE (all reverted; the w47 fence toolkit in full):
       parameter renamed to `offsetArg` + `int offset = offsetArg;` alias
         at the decl block / before `shapeDef_p =` : 5 (byte-identical)
         before `drawResult = gNight_renderNight;` : 8 at count-EXACT 189
         before the clipW store                    : 8 at count-EXACT 189
       w47 OPACITY fence on offset at the decl block / before shapeDef_p : 45
       same before `drawResult =`                                       : 39
       same after `*(u_char*)(...matB.t+2) = 0;`                        : 38 @189
       w45 USE fence `__asm__("" : : "r"(offset))` before `drawResult =`: 8 @189
       same before shapeDef_p                                           : 17
     The two count-EXACT 8-diff forms are the interesting ones: they DO kill the
     nop, but they pull `addu s2,a0,zero` / `addu s3,a3,zero` (the Vi and pCp
     parm copies) out of retail's order in exchange -- i.e. the reload and the
     three parm copies are ONE ready-list ordering problem, not two.  NEXT ANGLE:
     price it with tools/allocsim.py/-dS on the entry block rather than probing
     spellings (the LAUNCH-BOOST/luid tie that solved DoLines step 2 is the model
     to apply -- there, deleting a net-zero pair restored a copy's birthing_insn_p
     boost; here look for whatever costs `offset` its boost or gives the Vi/pCp
     copies theirs).
     ---- w51-a10 (2026-08-09): 5 STAYS.  The w50 alias basin RE-MEASURED and its
     residual PINNED EXACTLY: `int offset = offsetArg;` at either the `drawResult =`
     or the clipW-store position is count-EXACT 189/189 at 8 diffs, and side_by_side
     shows those 8 are a pure 3-insn ENTRY-BLOCK ROTATION plus one store move --
     ours `addu s2,a0,zero . addu s3,a3,zero . lw s5,96(sp)` vs retail
     `lw s5,96(sp) . addu s2,a0,zero . addu s3,a3,zero`, with `sw s5,236(s0)` one
     slot late.  The un-aliased base (5 @190) instead keeps `sw s5,68(sp);
     lw s5,96(sp)` at insns 6-7 and pays a nop where retail FILLS the
     `lbu v0,3(s4)` load-delay slot at insn 17: retail saves s0,s4,ra,s5,s3,s2,s1
     and we save s0,s4,s5,ra,s3,s2,s1.  FALSIFIED this wave -- at the alias basin,
     repositioning the clipW store after the mirror store 10 and before the guard 10;
     at the base basin, a zero-insn USE fence naming Vi and/or pCp walked to four
     entry positions (top / after cprim / after isCullable / after the matB.t byte
     store) = 18 @191, 18 @191, 9 @190, 9 @190, plus a void-tail fence at the top
     18 @191.  EVERY fence COSTS instructions here, so the class is not
     fence-reachable.  => this is the PROLOGUE PARAM-COPY SINK class in pure form
     (assign_parms emits the parm copies and the stack-arg reload before any body
     statement, so no source position can reach them) and the reachable mechanism is
     a PER_FN textual splice on the .s -- the PER_FN_RA_SINK / PROLOGUE_UNSINK family
     already wired in tools/build.py.  NAMED LANE CANDIDATE: sink `sw s5,68(sp)` to
     retail insn 11 and `lw s5,96(sp)` into the lbu load-delay slot at 17, which also
     deletes the nop and lands the count. */
  /* w53-a1 RE-GATE: 5 diffs, ours 190 / oracle 189, UNCHANGED.  The w51-a10
     diagnosis is re-confirmed against the current object: the only residual is
     the 5th (STACK) argument's assign_parms reload -- ours emits
     `sw s5,68(sp); lw s5,96(sp)` as insns 5-6 and pays a `nop` at insn 17,
     retail saves s0,s4,ra,s5,... and SINKS `lw s5,96(sp)` into the
     `lbu $v0,3($s4)` load-delay slot at insn 16.  Nothing in the source can
     reach assign_parms (proven again by this wave's DrawQuad work: every fence
     form COSTS instructions when the target is a prologue copy).
     >>> ORCHESTRATOR ACTION: this is a PER_FN textual-splice lane exactly like
     the already-wired PER_FN_RA_SINK / PER_FN_EPILOGUE_UNFILL in tools/build.py.
     The splice is 2 moves inside the `.ent` region:
         (a) move `sw $21,68($sp)`  to just after `sw $31,72($sp)`
         (b) move `lw $21,96($sp)`  to just after `lbu $2,3($20)` (deleting the
             `nop` that follows it)
     -> count 189 == 189 and the fn PASSes.  I am not permitted to edit
     tools/*.py, so this stays a named lane, not a landing. */
  coorddef tmp;
  coorddef tmp2;
  int isCullable; /* SYM-CODEGEN-CARRIER: isCullable -- direct objDef->vertexCount is current FAIL 8/189 */
  int drawResult; /* SYM-CODEGEN-CARRIER: drawResult -- direct gNight_renderNight guard is current FAIL 6/189 */

  /* MATCH: SYM 0x800c8214 shows ONLY tmp/tmp2 (+REG offset) as locals; u_char
     isCullable had emitted a bogus `andi 255` (retyped int), and the mirror
     expression now groups (cnt*2+1) before the base add per the oracle
     `sll;addiu 4;addu`. */
  sd[1].head.cprim.PrimPtr = (char *)(objDef + 1);
  *(Track_tMaterial **)sd[1].matB.m[0] = Track_materials;
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
    { int posX = ((Camera_gInfo[Vi->player].target)->position).x; /* SYM-CODEGEN-CARRIER: posX -- split target-position load preserves the retail pointer chase */ tmp.x = (Vi->cview).translation.x - posX; }
    { int posY = ((Camera_gInfo[Vi->player].target)->position).y; /* SYM-CODEGEN-CARRIER: posY -- y-axis member of the measured split-load shape */ tmp.y = (Vi->cview).translation.y - posY; }
    { int posZ = ((Camera_gInfo[Vi->player].target)->position).z; /* SYM-CODEGEN-CARRIER: posZ -- direct three-axis expressions are current FAIL 38/185 */ tmp.z = (Vi->cview).translation.z - posZ; }
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
      MATRIX *m = (MATRIX *)&(sd->matB); /* SYM-CODEGEN-CARRIER: m -- mixed base/direct matB lvalues keep retail's store bases; fully direct form is FAIL 4/189 */
      m->t[2] = 0;
      m->t[1] = 0;
      (sd->matB).t[0] = 0;
gte_SetTransMatrix(m);
    }
  }
  if (offset == -1) {
    *(int *)&sd[1].head.clipW = Draw_gMidGroundOtz;
    { int tX = (Vi->cview).translation.x; /* SYM-CODEGEN-CARRIER: tX -- split load fixes the clip-store issue position */ sd[1].matB.m[0][2] = (short)(pCp->x - tX >> 0xc); }
    { int tY = (Vi->cview).translation.y; /* SYM-CODEGEN-CARRIER: tY -- y-axis member of the same source statement split */ sd[1].matB.m[1][0] = (short)(pCp->y - tY >> 0xc); }
    { int tZ = (Vi->cview).translation.z; /* SYM-CODEGEN-CARRIER: tZ -- folding all six loads is current FAIL 12/189 */ sd[1].matB.m[1][1] = (short)(pCp->z - tZ >> 0xc); }
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

/* w55-a9 NEGATIVE: the w48 zero-insn VOID fence `__asm__("" : : "i"(0))` was swept over
 * EVERY statement of the body (scratchpad/w55a9_fencesweep.py, each position gated).  No
 * position beats the 42 @434/434 baseline (best alternatives 46 @436).  The sched-fixpoint
 * device is CLOSED here; the residual is coloring, not a barrier problem. */
/* ---- DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo  [DRAWW.CPP:2346-2649] SLD-VERIFIED ---- */
int DrawW_BuildChunkObjectFacets(DRender_tView *Vi,ChunkObjectInfo *gObjInfo)

{
  /* MATCH (2026-08-21): SYM declares the variable-length record walker as
     Trk_SimpleInst*.  That type owns the common header through x/y/z; only the
     type-specific switch arms cast it to Trk_CollideBoomInst for the q/s/light
     tail.  This is also the source idiom preserved by the matched NFS2 PC beta.
     The explicit casts are zero-code and the corrected declaration retains
     PASS434. */
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
     Trk_CollideBoomInst -- EA declared the small record and byte-cast the rest.
     w46-a7 -- LANDED, 212 -> 144: objInstance now takes $s4 exactly as the SYM says.
     The dial was NOT on objInstance at all.  tools/reqdelta.py --want "p88=s4,p234=s3"
     ranked every reachable single-dial delta and the CHEAPEST is |d| = 1 on the RIVAL:
         p234 (case 5's `t2`)  live 29 -> 28   <-- landed
         p234                  refs 12 -> 13
         p88  (objInstance)    refs 79 -> 77   (the w44 receipt's route; = ONE in-loop
                                                source ref, since loop depth weights x2)
         p88                   live 375 -> 382
     SOURCE FORM: swap case 5's LAST TWO matrix stores to `matrix.m[5] = t2;
     matrix.m[2] = t1;`.  That shortens t2's third live segment by exactly one insn
     (29 -> 28, priority 3*12/28 = 1.2857) so it now outranks objInstance's 1.2640 by
     the same razor that used to run the other way; t1 (p233) pays the +1 (38 -> 39)
     and stays well below.  ZERO instruction cost, count stays 434/434.
     NOTE the store-order swap is ONLY correct for case 5 -- the other three arms end
     with `m[2] = t1; m[5] = t2;` and their t1/t2 pairs are already ranked where the
     oracle wants them; do not "regularize" the four arms.
     REMAINING 144 (new, quantified at the new basin): two further rotations --
       (1) totalCount is $fp for us, $s7 for the oracle, and the reverse swap on the
           `lb` source (`lb s7,0(v1)` ours vs `lb fp,0(v1)`); plus
       (2) an $s5/$s6 pair swap on the two DrawObjectTransform arms that ALSO costs us
           two extra spill stores (`sw s6,32/36(sp)` + `sw s3,44/48(sp)` where the
           oracle has just `addu s5,v0,zero`) -- i.e. our $s6 claimant is call-crossing
           where the oracle's is not.
     w46-a7 CONTINUED, 144 -> 42.  All six SYM registers now match (objInstance $s4,
     objDef $s6, totalCount $s7, objectOffset $fp, type $s0, light $s1).  Levers, in
     the order they landed, all zero-insn (count stays 434/434 throughout):
       2. objDef (p89) live 85 -> 89: hoist case 2's `objDef = Track_gObjDefs[...]`
          above its m[8] RMW.  reqdelta wanted live > 86.7 so it falls under case 5's
          t1 (p233, 0.9230) -> objDef takes $s6, t1 takes $s5.       [144 -> 120]
       3. objectOffset (p91) refs 30 -> 14: write all four DrawObjectTransform arms in
          case 1's own direct-add form `totalCount = totalCount + call(...)` instead of
          storing the result back into objectOffset first.  The store-back was DEAD (the
          next iteration re-loads objectOffset from goffsets[]) and cost 2 weighted refs
          per arm; totalCount (22/377) then outranks it and the pair lands $s7 / $fp.
                                                                      [120 -> 98]
       4. the m[6]/m[7]/m[8] RMW STORE, not the call, is what retail defers: retail emits
          `sw m[K]=t1; sw m[K+3]=t2; jal <next fixedmult>; [ds] sw m[K+6]=<result>`.
          Moving the whole RMW statement after the two stores (the w44 falsification,
          RE-TESTED here and still bad: 250 diffs, count collapses to 422) is the wrong
          split.  The right one keeps the CALL third and moves only the STORE last:
          `t3 = fixedmult(matrix.m[K+6],sX); ... matrix.m[K+6] = t3;`  [98 -> 50]
       5. the two groups whose m[2]/m[5] stores are NOT adjacent to the RMW (the flags&1
          type==9 arm and case 9) additionally want those stores moved UP, above the
          light / offsubdivid / objDef statements.                     [50 -> 42]
     RESIDUAL 42, two independent clusters:
      (A) ~14 diffs: in case 2 the objDef load (`lh v0,6(s4) ... lw s6,0(v0)`) must issue
          AFTER the last `jal fixedmult` and after the three matrix stores -- but lever 2
          put it BEFORE the RMW, and that position is exactly what buys objDef its $s6.
          The two requirements are currently coupled.  FALSIFIED this wave: objDef moved
          back below the three stores (56, loses $s6); that PLUS hoisting the flags&1
          arm's objDef above its `if (type == 9)` block to restore the live length (52,
          and the count drops to 432).  NEW NAMED ANGLE: buy objDef's +4 live somewhere
          that is NOT an emission-order change -- case 1 and case 5 also assign objDef,
          and case 5's is already the arm's first statement, so the reachable dial is
          case 1 (`objDef = ...; totalCount += DrawObjectSimple(...)`, currently the
          shortest segment): lengthen THAT segment and restore case 2's oracle order.
      (B) ~4 diffs: a $v0/$v1 swap on case 5's anim vtable dispatch (`lh a0,16(v1);
          lw v1,20(v1); jalr v1` oracle vs `...v0...` ours) -- a two-pseudo local rotation
          in the `(*(*anim->_vf)[2].pfn)(...)` expression.
     ---- w62-a2 (2026-08-15): 42 -> 19, count 434 -> 433 (ONE SHORT).  BOTH
     landings are 13A laws, and cluster (B) is CLOSED:
       (i) SPILL-SLOT ORDER IS DECLARATION ORDER.  The SYM frame map is
           simObjs AUTO -56 = sp+72, doFrustumClip AUTO -52 = sp+76, and ours had
           the two slots SWAPPED (`sw t0,76(sp)` / `sw a1,72(sp)` + the 3 reload
           sites) purely because `int doFrustumClip;` was DECLARED before
           `Trk_SimObject *simObjs;`.  Swapping the two declarations (no statement
           moved) fixes every slot: 42 -> 32, count stays 434.  Declaring simObjs
           at the very head of the list measures the same 32.
      (ii) THE BLOCK-LOCAL ANCHOR LAW closes cluster (B): the SYM names NO `anim`
           local anywhere in this function, and giving case 5's dispatch its own
           ARM-LOCAL `ObjectAnim *anim = Object_GetAnim(...)` (the fn-scope decl
           stays, now unused) moves the pseudo from the shared fn-scope anchor to
           a local qty that keeps the call result in $v0 -- the `addu v1,v0,zero`
           copy disappears and the vtable load takes $v1 exactly like retail.
           32 -> 19.  decl-with-init and split decl+assign forms measure the same.
     FALSIFIED at the 32/19 basins (all re-gated, all reverted): case 2's objDef
     load swept over all five positions in the sz row (before t2 40 / after t2 =
     current 32 / after t3 32 / after m[2] 34 / after m[5] 32 / after m[8] 46), so
     the w46 cluster-(A) coupling is unchanged; a read-only fence on objDef in
     case 1 to buy the +4 live COSTS an insn (35 @435 alone, 49 @435 with the
     case-2 restore), i.e. it is not the zero-insn inflator that class needs;
     a second `return totalCount;` at the loop exit (to mint retail's
     `addu v0,s7,zero` in the guard's delay slot) 21 @435, and `return 0;` in the
     empty-group arm 19 (inert).
     RESIDUAL 19 = the w46 cluster (A) (case 2's objDef load must issue after the
     last jal + the three matrix stores, which costs it the $s6 race) plus the ONE
     missing `addu v0,s7,zero` retail duplicates into the loop-guard delay slot.
  ===== w67-a7 (2026-08-15): 8 -> PASS 434/434, branch words 15/15 BYTE-EXACT =====
  FOUR PER_FN_TEXT_MOVES rows + ONE COUPLED PER_FN_BRANCH_RETARGET row (probe-verified
  2x via scratchpad/w67a7/vprobe_br.py -- a tools/vprobe.py copy with a W67_BR_FILE hook,
  ROOT hardcoded per the 16F parents[] promotion bug; row files:
  scratchpad/w67a7/tm_bcof.json + br_bcof.json; siblings re-gated unchanged):
   (1) `li $5,0x1f800000` moved into the case-dispatch `beq $3,$2,$L915` delay slot
       (slot:true; kills our maspsx reorder nop -- the 8-diff cluster's balance insn);
   (2) `lw $4,128($sp)` hoisted to the $L915 arm head (retail loads the sd arg FIRST,
       before the objDef chain; crosses the w63-a2 empty fence harmlessly post-cc1);
   (3) `sw $21,40($sp)`/`sw $19,52($sp)` adjacent stack-arg store swap at the
       DrawObjectTransform site (pin: the following `sw $2,16($sp)`);
   (4) copy:true row -- `move $2,$23` DUPLICATED into the loop-guard `beq $2,$0` slot
       (the 11B/aspsx copy-into-slot class: retail stages the return value on BOTH
       paths; our exit-block copy stays).
  RED FLAG LAW UPHELD -- THE COPY ROW ALONE IS THE HeliCam TRAP: with only rows 1-4 the
  gate reads PASS but the guard beqz's WORD is 0x17a vs retail 0x17b -- retail's exit
  branch lands ONE INSN PAST the exit-block `move $2,$23` (the slot copy already staged
  v0; executing the exit move twice is value-identical, so the gate AND the board are
  both blind).  The BR row plants a fresh label after the exit move and re-points the
  guard beqz: branch-word census 15/15 == retail.  17C: every slot-touching TEXT_MOVES
  row needs its branch-word proof, and a copy-into-slot row nearly always needs a
  coupled BR row (the duplicate changes where the taken edge should land).
  ORCHESTRATOR: wire tm_bcof.json into PER_FN_TEXT_MOVES and br_bcof.json into
  PER_FN_BRANCH_RETARGET as ONE unit (18A coupling). */

  u_char type;   /* SYM REG $s0 */
  ObjectAnim *anim; /* SYM-CODEGEN-CARRIER: anim -- the arm-local anchor receipt removes the retail v0/v1 dispatch copy */
  Trk_SimObject *simObjs;   /* SYM AUTO -56 -> sp+72 */
  int doFrustumClip;        /* SYM AUTO -52 -> sp+76 */
  short light;
  Group *instGroup;   /* SYM REG $2 */
  Trk_SimpleInst *objInstance;
  Trk_ObjectDef *objDef;
  int totalCount;
  int objectOffset;
  matrixtdef matrix;
  int groupNumElements;
  int objectIndex;

  simObjs = gObjInfo->simObjs;
  instGroup = gObjInfo->objInstanceBuf;
  objInstance = (Trk_SimpleInst *)(instGroup + 1);
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
                             (Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr) != 0)
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
          int t1, t2, t3 /* SYM-CODEGEN-CARRIER: t3 -- split fixedmult result delays only the matrix store, preserving retail call/store scheduling */, sx, sy;

          sx = (int)((Trk_CollideBoomInst *)objInstance)->qz << 8;
          sy = (int)((Trk_CollideBoomInst *)objInstance)->qy << 8;
          t1 = fixedmult(matrix.m[0],sx);
          t2 = fixedmult(matrix.m[3],sx);
          t3 = fixedmult(matrix.m[6],sx);
          matrix.m[0] = t1;
          matrix.m[3] = t2;
          matrix.m[6] = t3;
          t1 = fixedmult(matrix.m[1],sy);
          t2 = fixedmult(matrix.m[4],sy);
          t3 = fixedmult(matrix.m[7],sy);
          matrix.m[1] = t1;
          matrix.m[4] = t2;
          matrix.m[7] = t3;
          t1 = fixedmult(matrix.m[2],sx);
          t2 = fixedmult(matrix.m[5],sx);
          t3 = fixedmult(matrix.m[8],sx);
          matrix.m[2] = t1;
          matrix.m[5] = t2;
          matrix.m[8] = t3;
          light = ((Trk_CollideBoomInst *)objInstance)->qw;
          DW_SCRATCH->offsubdivid = 0;
        }
        objDef = Track_gObjDefs[objInstance->pad];
DrawWChunkFacets_emitObj:
        totalCount = totalCount + DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef,
                            (coorddef *)&objInstance->x,objectOffset,light);
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
          /* MATCH (w63-a2) -- THE FOREIGN-OPERAND FENCE, the pair-half that lets
             case 2's objDef load sit at its SLD/oracle position (see below).
             flow.c:1594's REG_LIVE_LENGTH++ lives inside the
             `GET_RTX_CLASS(...) == 'i'` arm at flow.c:1399, so live length counts
             REAL RTL INSNS only -- an empty __asm__ IS such an insn and assembles
             to ZERO bytes, so it adds +1 live to EVERY pseudo live across it while
             the +1 REG_N_REFS lands only on ITS OWN operand.  Operand =
             objInstance (a NEIGHBOUR), so objDef gets the live it needs
             (79 -> 85 measured on the real CC1PLPSX -dl dump) at refs UNCHANGED
             (20) -- which is why the w62 read-only fence ON objDef was falsified
             (it costs an insn AND raises refs, the wrong direction: same fence
             with `"r"(objDef)` measures 220 diffs, with `"r"(Vi)` 23 @435).
             DO NOT DELETE: without it the case-2 move alone loses objDef's $s6
             (33 diffs, p89 live 79 -> $s5). */
          __asm__("" : : "r"(objInstance));
          totalCount = totalCount + DrawObjectSimple(Vi,(Draw_DCache *)&Render_gPalettePtr,
                              objDef,(coorddef *)&objInstance->x,objectOffset);
          break;
        case 2: {
          /* MATCH: SYM block scope (t1,t2,sx,sy,sz -- full 3-axis shift). */
          int t1, t2, t3, sx, sy, sz;

          Quatern_QuatToMat((tQuat *)&((Trk_CollideBoomInst *)objInstance)->qx,&matrix);
          sx = (int)((Trk_CollideBoomInst *)objInstance)->sx << 8;
          sy = (int)((Trk_CollideBoomInst *)objInstance)->sy << 8;
          sz = (int)((Trk_CollideBoomInst *)objInstance)->sz << 8;
          t1 = fixedmult(matrix.m[0],sx);
          t2 = fixedmult(matrix.m[3],sx);
          t3 = fixedmult(matrix.m[6],sx);
          matrix.m[0] = t1;
          matrix.m[3] = t2;
          matrix.m[6] = t3;
          t1 = fixedmult(matrix.m[1],sy);
          t2 = fixedmult(matrix.m[4],sy);
          t3 = fixedmult(matrix.m[7],sy);
          matrix.m[1] = t1;
          matrix.m[4] = t2;
          matrix.m[7] = t3;
          t1 = fixedmult(matrix.m[2],sz);
          t2 = fixedmult(matrix.m[5],sz);
          t3 = fixedmult(matrix.m[8],sz);
          matrix.m[2] = t1;
          matrix.m[5] = t2;
          matrix.m[8] = t3;
          /* MATCH (w63-a2) -- the w46/w62 cluster-(A) position: retail issues this
             load AFTER the last `jal fixedmult` AND after the three m[2]/m[5]/m[8]
             stores.  Landing it required buying objDef's live back in case 1 (see
             the foreign-operand fence there) -- the two edits are a PAIR, neither
             works alone (case-2 move alone 33, fence alone 24, both 8). */
          objDef = Track_gObjDefs[objInstance->pad];
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
          totalCount = totalCount + DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef,
                              (coorddef *)&objInstance->x,objectOffset,
                              *(short *)&((Trk_CollideBoomInst *)objInstance)->simIndex);
          break;
        }
        case 9: {
        /* MATCH: SYM block scope (t1,t2,sx,sy -- no sz for the qz/qy-only shift pair). */
        int t1, t2, t3, sx, sy;

        xformy(&matrix,(int)((Trk_CollideBoomInst *)objInstance)->qx);
        sx = (int)((Trk_CollideBoomInst *)objInstance)->qz << 8;
        sy = (int)((Trk_CollideBoomInst *)objInstance)->qy << 8;
        t1 = fixedmult(matrix.m[0],sx);
        t2 = fixedmult(matrix.m[3],sx);
        t3 = fixedmult(matrix.m[6],sx);
        matrix.m[0] = t1;
        matrix.m[3] = t2;
        matrix.m[6] = t3;
        t1 = fixedmult(matrix.m[1],sy);
        t2 = fixedmult(matrix.m[4],sy);
        t3 = fixedmult(matrix.m[7],sy);
        matrix.m[1] = t1;
        matrix.m[4] = t2;
        matrix.m[7] = t3;
        t1 = fixedmult(matrix.m[2],sx);
        t2 = fixedmult(matrix.m[5],sx);
        t3 = fixedmult(matrix.m[8],sx);
        matrix.m[2] = t1;
        matrix.m[5] = t2;
        matrix.m[8] = t3;
        DW_SCRATCH->offsubdivid = 0;
        objDef = Track_gObjDefs[objInstance->pad];
        /* MATCH (w41-a2): inline light, see the case-2 note. */
        totalCount = totalCount + DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef,
                            (coorddef *)&objInstance->x,objectOffset,
                            ((Trk_CollideBoomInst *)objInstance)->qw);
        break;
        }
        case 5: {
        objDef = Track_gObjDefs[objInstance->pad];
        anim = Object_GetAnim(simObjs + ((Trk_CollideBoomInst *)objInstance)->simIndex);
        if (anim == (ObjectAnim *)0x0) {
          /* MATCH: SYM block scope (t1,t2,sx,sy,sz -- full 3-axis shift). */
          int t1, t2, t3, sx, sy, sz;

          Quatern_QuatToMat((tQuat *)&((Trk_CollideBoomInst *)objInstance)->qx,&matrix);
          sx = (int)((Trk_CollideBoomInst *)objInstance)->sx << 8;
          sy = (int)((Trk_CollideBoomInst *)objInstance)->sy << 8;
          sz = (int)((Trk_CollideBoomInst *)objInstance)->sz << 8;
          t1 = fixedmult(matrix.m[0],sx);
          t2 = fixedmult(matrix.m[3],sx);
          t3 = fixedmult(matrix.m[6],sx);
          matrix.m[0] = t1;
          matrix.m[3] = t2;
          matrix.m[6] = t3;
          t1 = fixedmult(matrix.m[1],sy);
          t2 = fixedmult(matrix.m[4],sy);
          t3 = fixedmult(matrix.m[7],sy);
          matrix.m[1] = t1;
          matrix.m[4] = t2;
          matrix.m[7] = t3;
          t1 = fixedmult(matrix.m[2],sz);
          t2 = fixedmult(matrix.m[5],sz);
          t3 = fixedmult(matrix.m[8],sz);
          matrix.m[5] = t2;
          matrix.m[2] = t1;
          matrix.m[8] = t3;
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
          totalCount = totalCount + DrawObjectTransform(Vi,(Draw_DCache *)&Render_gPalettePtr,&matrix,objDef,
                              (coorddef *)&objInstance->x,objectOffset,-1);
          break;
          }
          /* MATCH (w62-a2): the SYM names NO `anim` local -- an ARM-LOCAL
           * declaration (13A block-local anchor law) keeps the call result in
           * $v0 and puts the vtable load in $v1 like retail, killing the
           * `addu v1,v0,zero` copy + the whole v0/v1 rotation.  32 -> 19. */
          { ObjectAnim *anim = Object_GetAnim(
                simObjs + ((Trk_CollideBoomInst *)objInstance)->simIndex);
          (*(*anim->_vf)[2].pfn)
                    ((int)&anim->_vf + (int)(*anim->_vf)[2].delta,Vi,0x1f800000,objectOffset);
          }
          break;
        }
        }
      }
DrawWChunkFacets_groupNext:
      objInstance = (Trk_SimpleInst *)((char *)objInstance + objInstance->size);
    }
  }
  return totalCount;
}

/* ---- ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:2660-2709] SLD-VERIFIED ---- */
bool ObjectClipped(DRender_tView *Vi,int ind,coorddef *pCp,Draw_tGiveShelbyMoreCache *sd)

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
  BOOL pvVar3; /* SYM-CODEGEN-CARRIER: pvVar3 -- result funnel preserves retail branch polarity; direct returns are FAIL 6 (61/61) */
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
  tmp2.z = tmp2.z + bSphere->radius * 0x400;
  if (tmp2.x <= tmp2.z) {
    pvVar3 = (u_int)(tmp2.z < -tmp2.x);
  }
  else {
    pvVar3 = 1;
  }
  return pvVar3;
}

/* w55-a9 TRIAGE + NEGATIVE.  Re-gated 30 @222/222 (count EXACT).  chunkdiff localises the
 * whole residual to TWO runs / 6 insns, both pure emission order:
 *   (1) entry block -- retail SPLITS the `lui $v0,%hi(sym)` from its `addiu $v0,$v0,%lo`
 *       with `sw $t0,24(sp)` + `lw $s5,136($v1)` between them; ours emits the pair adjacent
 *       and pushes those two stores/loads after it;
 *   (2) the `sltiu $v0,...,53` guard -- retail computes `addiu $v0,$s5,-1` and the
 *       `lui $a0,0x1F80` right there; ours has the -1 in $a0 from earlier.
 * The w48 VOID fence was swept over every statement of the body -- NOTHING below 30.
 * ⇒ the barrier axis is closed; item (1) is the split-address ready-list tie (same class as
 * DrawC_NightHeadlight's residual 4) and item (2) wants the `-1` as its own late statement
 * (the lever that took DrawC_PrimStart 60 -> 54 this wave) -- untried here. */
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
  /* ================= W72-A1 (2026-08-22): 30 -> PASS 222/222 =================
     Four landings, three of them one general law each.
       (1) THE ALIAS-DEPENDENCE DIAL, applied to the scratchpad cache (30 -> 10).
           Every `*(short *)((char *)sd + 0xNN)` cast store is a PLAIN MEM: gcc's
           alias.c cannot prove it independent of a fixed-address global load
           (a SYMBOL_REF MEM vs a register+displacement MEM), so sched_analyze
           CHAINS them and emission order == source order.  Spelling the SAME
           stores as real COMPONENT_REFs -- `sd->doublelayer` (+0xDA),
           `((Draw_tGiveShelbyMoreCache *)sd)->artInfo` (+0xFC) and `->offsubdivid`
           (+0x148) -- sets MEM_IN_STRUCT_P, so fixed_scalar_and_varying_struct_p
           (sched.c:846-56) declares them INDEPENDENT of the `gPersistObjInst` /
           `gInitialArt` symbol accesses and the loads hoist exactly like retail:
           the `sh zero,218(s6)` store moves down into the `lw a1` load-delay slot
           (killing our extra nop) and the `lui/addiu` of &gInitialArt splits
           around the chunkCount spill + the gCurrContext load.  -3 then -8 diffs.
           => TU-WIDE SWEEP CANDIDATE: every `(char *)sd + 0xNN` cast in this file.
           CORPUS CORROBORATION (mined this wave, C:/Temp/ps1-decomp-refs/
           tenchu-decomp/docs/compiler-facts.md:155 + matching-cookbook.md:1379):
           tenchu records the SAME mechanism from the other side and sharpens it --
           "MEM_IN_STRUCT_P alias heuristic (cse.c and sched.c): a varying-address
           struct-member store does not invalidate a fixed-address non-struct
           scalar's cached load ... a width-forcing cast `*(u16 *)&p->field` is an
           INDIRECT_REF and CLEARS /s".  That is exactly what our
           `*(short *)((char *)sd + 0xNN)` spellings were doing to the scratchpad
           cache, in a TU where every scratchpad field was written that way.
       (2) cse CONSTANT-SHARING BREAKER on the second track guard (30 -> 21).
           Retail RECOMPUTES `addiu $v0,$s5,-1` inside the second `||` chain, which
           frees $a0 so reorg can steal the body's `lui $a0,0x1F80` into the
           `bnez $v1` delay slot; ours CSE'd one `chunkM1` across both chains, kept
           it in $a0, and the second chain's own `sltiu` filled the slot instead.
           Every previously-tried device failed BECAUSE IT AIMED AT $a0 (w46/w53/
           w62/W70: named copies, void fences, `$4`-clobber 20B fences, nested-if
           splits -- 12 probes, all recorded above).  The reachable dial is cse's
           REACHABILITY, not the register: an opacity fence on the FIRST occurrence
           (a statement-expression inside chain 1) makes chain 2's inline
           `(u_int)(thisChunkInd - 1U)` un-provable-equal, so it recomputes.
           Zero insns.  (catalog 21E(5), applied to a computed value rather than a
           literal.)
       (3) SCHED2 LUID TIE in the first build arm (18 -> 10 -> PASS).  Retail's
           `simObjs` store lands AFTER the objInstanceBuf load and the
           doFrustumClip `sltiu`; all 24 permutations of the four statements were
           measured and exactly ONE gates PASS: doublelayer, objInstanceBuf,
           simObjs, doFrustumClip.
     ============================================================================ */
  gVi = Vi;
  sd = (Draw_DCache *)&Render_gPalettePtr;
  /* w49-a2 FALSIFIED (residual 30, count-exact 222/222): all four statement
     orders of {chunkCount, thisChunkInd, the &gInitialArt store} gate
     BYTE-IDENTICALLY -- sched2 re-orders them freely.  The SLD says retail's
     source order is thisChunkInd(2721), chunkCount(2722), gInitialArt(2730),
     which is what we have modulo the first two; the residual is SIX separate
     1-3 slot transpositions spread over the whole body, every one of them
     ours-EARLIER than the oracle (lui %hi, the two entry stores, `li v0,1`,
     `sw s3,0(s7)`, `lw a0,0(gp)`, `sh zero,218(s6)`), plus geomRez in $v1 vs
     the oracle's $a1.  That uniform ours-earlier signature is the sched2
     ready-list DRAIN class, not a source order -- next instrument is a
     zero-insn fence WALK (w45 grammar) or -dR. */
  /* w50-a2: THE FENCE WALK IS FALSIFIED for the entry block.  A zero-insn void
     fence `__asm__("" : : "i"(0))` was walked through all six statement slots of
     the prologue (before/after gVi=Vi, sd=, chunkCount=, thisChunkInd=,
     &gInitialArt store, and at the loop block head): 60 / 62 / 62 / 90 / 60 / 60
     -- every placement REGRESSES, none is neutral, so the barrier is strictly
     harmful here (it splits the entry block's ready list, which is precisely the
     resource the drain is consuming).  The remaining named angles are unchanged:
     (a) the RANGE-CHAIN rematerialization at the second track guard (the dial is
     WHERE 0x1F800000 is materialized, not the chunkM1 temp -- see below), and
     (b) -dR (sched2) traces to read the drain order directly. */
  chunkCount = BWorld_gChunkCount;
  thisChunkInd = gCurrContext->currentChunk;
  ((Draw_tGiveShelbyMoreCache *)sd)->artInfo = &gInitialArt;
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
        sd->doublelayer = 1;
        /* MATCH (w72-a1): the sched2 LUID tie -- retail's simObjs store lands
           AFTER the objInstanceBuf load + the doFrustumClip sltiu (source order
           doublelayer / objInstanceBuf / simObjs / doFrustumClip).  All 24
           permutations measured; this is the only PASS. */
        gChunkObjInfo.objInstanceBuf = chunkDat->objInstanceBuf;
        gChunkObjInfo.simObjs = simObjs;
        gChunkObjInfo.doFrustumClip = (int)(geomRez == 4);
        gWSavePtr = (u_long)SetSp(&gScratchLastWord);
        stackSpeedUpEnbabledFlag = 1;
        DrawW_BuildChunkObjectFacets(gVi,&gChunkObjInfo);
        gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
      }
      if (((GameSetup_gData.Time == 0) && (GameSetup_gData.Weather == 0)) &&
         (chunkDat->objSpecialInstanceBuf != (Group *)0x0)) {
        ((Draw_tGiveShelbyMoreCache *)sd)->offsubdivid = 0x400;
        sd->doublelayer = 0;
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
  {
  sd->doublelayer = 0;
  /* BUG FIXED (2026-07-11 consolidation, correctness over byte-match per project policy):
     oracle stores 0x400 here, not 0 -- the loop-exit branch's DELAY SLOT unconditionally
     re-materializes `addiu v0,zero,0x400` (B9548; delay slots execute on BOTH paths, §3.1),
     and that same v0 is stored at B9678 `sh v0,0x148(s6)`. The wave-7 `=0` reading misread
     the slot as the slt result. Costs one extra `li` vs `$zero` (+~15 fuzzy diffs) --
     accepted; this value feeds DrawW_BuildCustomObjectFacets via the scratchpad field. */
  *(short *)((char *)sd + 0x148) = 0x400;
  if (gPersistObjInst != (Group *)0x0) {
    /* w46-a7 RECEIPT -- 30 diffs, count-EXACT 222/222, 4 tiny independent clusters
       (chunkdiff: 10 insns total).  The one worth naming:
         RANGE-CHAIN REMATERIALIZATION -- the shared `chunkM1` temp below is CSE'd
         into a live register ($a0) that spans BOTH track-guard chains, so our second
         chain reuses it (`sltiu v0,a0,53`); retail RECOMPUTES `addiu v0,s5,-1` at the
         second site because it needs $a0 there for a `lui a0,0x1F80` (the scratchpad
         cache pointer) that we materialize elsewhere.
       FALSIFIED this wave: inlining `thisChunkInd - 1U` at BOTH sites (45, count 223)
       · inlining at the SECOND site only (30, byte-identical -- cse folds it back)
       · two separate named temps (45, count 223).
       NEW NAMED ANGLE: the dial is NOT the temp, it is WHERE `0x1F800000` (the sd
       scratchpad base) is materialized.  Retail's `lui a0,8064` lands inside the
       second guard chain and is what evicts the CSE'd `chunkM1`.  Find the source
       site that owns that constant (a `(Draw_tGiveShelbyMoreCache *)&Render_gPalettePtr`
       / `sd` use) and move it INTO the second chain's block; the remat follows for
       free.  Remaining clusters: an early store-order pair (`sw a0,0(gp)` vs
       `sw t0,24(sp)` + the `lw s5,136(v1)` position) and one `v1`-vs-`a1` operand on
       an `xori ...,4`. */
    /* w53-a1 RE-GATE + FALSIFICATIONS (30 diffs, count-EXACT 222/222; posdiff
       first-use order is ORACLE-IDENTICAL, structural residual 15).  The w46-a7
       "NEW NAMED ANGLE" (move the 0x1F800000 materialisation into the second
       guard chain) was attacked from the OTHER side -- free `$a0` by killing the
       CSE that keeps `chunkM1` live across both chains -- and every form COSTS an
       instruction, which is why the class survives:
         nested-if split of the `&&` (chain1 { chain2 { body } }), chain 2 written
           with the inline `(u_int)(thisChunkInd - 1U)`      : 30, BYTE-IDENTICAL
           (so the `&&` -> nested-if rewrite is free here and can carry a fence)
         + w47 OPACITY fence on `thisChunkInd` between the chains : 57 @223 (+1)
         + fenced COPY `u_int ind2 = thisChunkInd;` used by chain 2 only : 68 @224
         + the same fence but chain 2 still reading thisChunkInd  : 55 @223
       READ: the fence DOES force retail's `addiu $v0,$s5,-1` remat, but it also
       materialises a copy -- the recompute must come from cse being unable to
       reach across a BLOCK, not from a barrier.  Since the nested-if form is
       byte-free, the next probe is to put a STATEMENT (not a fence) between the
       chains that legitimately clobbers `$a0` -- e.g. hoisting the `SetSp`
       argument's own address local into that position, which is the very value
       retail's `lui $a0,0x1F80` is computing. 
       ---- w62-a2 (2026-08-15): THAT PROBE IS NOW RUN AND FALSIFIED.  The
       nested-if split (chain 1 { chain 2 { body } }, chain 2 re-spelled with the
       inline `(u_int)(thisChunkInd - 1U)`) re-measures BYTE-FREE at 30 @222, and
       putting the SetSp argument's own address local (`int *spArg =
       &gScratchLastWord;`, the value behind retail's `lui $a0,0x1F80`) between
       the two chains -- with the call site rewritten to `SetSp(spArg)` -- is ALSO
       byte-identical 30 @222: gcc coalesces the address local straight back into
       the call's own materialization, so a named copy cannot own that `lui`.
       (Same mechanism as the w62 DoTrough finding: a source-level copy of a
       value gcc already materializes is coalesced away and is never a position
       dial -- 13B's governing limit, `the copy IS the mechanism`, in the
       negative direction.)  The class still needs a real $a0 CLOBBER between
       the chains that is not an extra insn.
       ---- W70 (2026-08-16): THAT DEVICE NOW EXISTS AND IS FALSIFIED HERE.  The
       catalog's 20B row (`__asm__("" : "=r"(x) : "0"(x) : "$N")` -- a zero-insn,
       NON-volatile hard-register conflict; the output tied via "0" drops the
       implicit volatility so it is not a sched barrier) is exactly the "real $a0
       clobber that is not an extra insn" this receipt asked for.  Measured from
       the byte-free nested-if split, 12 probes (2 chain-2 spellings x 6 devices):
         chain2 = `chunkM1`         : no fence 30 @222 (byte-free, confirms w62)
                  clobber "$4"      : 58 @222   <- count-EXACT but far worse
                  clobber "$4" on chunkM1 : 40 @222
                  clobber "$4","$5" : 58 @222
                  clobber "$3"      : 66 @222
                  launder, no clobber: 54 @222
         chain2 = inline (u_int)(thisChunkInd - 1U):
                  no fence 30 @222 ; every fenced variant 57-61 @223 (+1 insn)
       READ: denying `$a0` DOES land count-exact (222/222) but the freed register
       is taken by the WRONG qty and the whole guard-chain block re-colours -- the
       remat we want is not gated on $a0 availability at all.  So the w46/w53/w62
       "$a0 clobber" hypothesis is dead; the dial is cse's reachability across the
       chains, and the only untried instrument is a -dS/-dR + cse dump on the
       30-diff basin.  ⚠️ lab fidelity for THIS fn is IDENTICAL per w62-a2, so the
       instrumented cc1plus is quotable. */
    if (((GameSetup_gData.track != 4) ||
        (((0x27 < ({ u_int c = thisChunkInd - 1U; __asm__("" : "=r"(c) : "0"(c)); c; }) && (0x1d < thisChunkInd - 0x3dU)) && (8 < thisChunkInd - 0x6cU)))) &&
       ((GameSetup_gData.track != 0 ||
        (((0x34 < (u_int)(thisChunkInd - 1U) && (0x1b < thisChunkInd - 0x44U)) && (0x13 < thisChunkInd - 0x6cU)))))) {
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
  int dx;
  
  dx = pt1->x - pt2->x;
  if (dx < 1) {
    dx = pt2->x - pt1->x;
  }
  dz = pt1->z - pt2->z;
  if (dz < 1) {
    dz = pt2->z - pt1->z;
  }
  if (dz < dx) {
    dist = dx + (dz >> 2);
  }
  else {
    dist = dz + (dx >> 2);
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
     NOTE (a10 w46 law): every pseudo in the table above is a GLOBAL allocno --
     all nine appear in the -dg `;; N regs to allocate:` list -- so the
     `QTY_CMP_PRI` priority formula DOES arbitrate them; the w46-a10
     `next_qty <= 3` hand-rolled-comparator quirk (local-alloc.c:1588) does
     NOT apply here.
     `pt1_index` int, which is why p92 carries 17 refs where retail's `sm` carries
     fewer.  Materialize `Skidmark_Chunk *sm` with its real fields and give the
     inner loop its own cursor locals; that is the same "one fabricated iVarN
     spanning two register lifetimes = two real SYM locals" split that cracked
     SetupBlockader (424->345), and it moves p92's ref count directly.
     ============================================================================ */

  /* w53-a1 RE-GATE: 303 diffs, ours 354 / oracle 353 (ONE over) -- the w46-a6
     numbers stand unchanged at this HEAD, so the 4-step reqdelta chain and the
     `Skidmark_Chunk *sm` rule-8 angle are both still CURRENT (not basin-stale).
     posdiff re-run: LCS 128/353, first-use order still the same 6-way callee-
     saved rotation.  chunkdiff localises the mass to FIVE runs / 52 insns, and
     the biggest one is a PARALLEL-CHAIN shape, not coloring: retail issues
         lw $v1,0($s4); lw $a0,12($s4); lw $a1,24($s4); sra x3; sh 20/22/24($s1)
     (three independent load->shift->store chains batched, each load filling the
     previous one's delay slot) where ours serialises them through two regs and
     permutes which source offset lands in which destination half-word.  That is
     the catalog's "N named value-temps / parallel chains" row and it is worth
     attacking BEFORE the rotation -- it is a source shape, the rotation is not. */
  /* ================= W70 (2026-08-16): 303 -> 274, ONE REAL BUG FIXED ==========
     Found by the MANDATORY m2c CROSS-VERIFY (seal criterion 6) against the fresh
     whole-binary m2c decompilation at
       C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_800C909C.c
     m2c line 86 is unambiguous:  temp_a3 = *(0x8013D1EC + ((temp_t0 & 1) * 4));
     i.e. `gSkidMarkPixmap` is an ARRAY OF POINTERS and the entry is LOADED, then
     dereferenced (`temp_a3->unk0/4/8/C`, `temp_a3->unkA << 5`).  Our recon took
     the ADDRESS of the pointer slot (`&gSkidMarkPixmap[i]`) and read five fields
     off it -- so the primitive's four UV words were the two POINTER words plus
     8 bytes PAST THE END of the 8-byte array, and the gClutDepth row index was
     garbage.  Exactly the catalog's BWorld_SetSpikeBelt typed-global class.
     FIXED: use the SYM's own local `pmx` (block @0x800C9438 line 89, class REG,
     `PTR STRUCT size 16 tag Draw_tPixMap`) -- `pmx = gSkidMarkPixmap[i]` and all
     five reads through `pmx->`.  The dead `pmx_dst` int is gone.
     Everything else in this function CROSS-VERIFIES CLEAN against m2c: the
     `var_t1`/`var_t3`/`var_t7` walker triple maps 1:1 onto pt1_index/segOff/
     depth_skid (pt1_index IS the advancing 0x1C cursor, smBase the constant
     base), the `>> 5` + `0x32` OTZ math, the `var_t1->unk24 & 1` colour select,
     the `Draw_gViewOtSize - 3` guard and the OT-link template all agree.
     ⚠️ The receipted allocsim table above is now BASIN-STALE (it was measured at
     303/354; we are at 274/355) -- re-dump before using its reqdelta chain.
     ============================================================================ */
  int skidChunk_p;
  int vert_count;
  int depth_index;
  POLY_GT4 *prim;
  void *primPtr;
  Draw_tPixMap *pmx;
  int type;
  int color_pack;
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

  /* ================= W72-A1 (2026-08-22): 274 -> 28, count 355 -> EXACT 353 ====
     THE RULE-8 `Skidmark_Chunk *sm` WALKER SPLIT (the named angle every wave since
     w46 recorded and none executed) IS LANDED, and it cascaded into eight more.
     BASELINE re-gated at cd9849ac: 274 diffs, ours 355 / oracle 353.

     WHAT LANDED, in the order it was measured (each gated, whole-TU re-gated):
       (1) RULE-8 WALKER SPLIT (274 -> 109, count 355 -> 354).  The invented
           `pt1_index` int -- which started as the CHUNK base and then walked by
           0x1C, so every access was a `(coorddef *)(pt1_index + 0xNN)` cast --
           is gone, together with its `smBase`/`segOff` twin.  In its place the
           SYM own pair: `Skidmark_Chunk *sm` (REG $s2, PTR STRUCT size 688, block
           line 33) held CONSTANT over the inner loop, with the segment accesses
           written `sm->seg[i]` so loop.c strength-reduces them into retail's two
           $t1/$t3 cursors + the $t7 index.  Offset map recovered from the old
           casts: +0x0 cp - +0xC n - +0xE slice - +0x10+i*0x1C seg[i]
           (svx[0] +0x0, svx[1] +0x8, rgb +0x10, type +0x14, next +0x18).
           `ti2 = *(int *)&sm->n;` keeps the oracle's WORD load of the n/slice pair.
           This alone satisfied the first link of the w46 4-step reqdelta chain:
           `sd` took retail's $s1 and `sm` retail's $s2.
       (2) READ-ONLY FENCE on `t` = +1 REG_N_REFS at zero insns (109 -> 97).
           reqdelta on the post-(1) dump named it exactly: `p102 refs 10 -> 11` is
           the MINIMAL single dial that flips the t/skidIdx pair to $s6/$s7.
           OUT of every loop, so no loop-depth weighting (21E(2)).
       (3) THE OTZ SPLIT (97 -> 89, count 354 -> 352).  Retail STORES the GTE OTZ
           through the literal pointer it keeps in $fp (`swc2 $7,0($fp)`) but READS
           and WRITES the same word as `sd->otz` (+0x94 == 148 off $s1).  Spelling
           both sides through the literal cost a SECOND lui/ori 0x1F800094 pair.
       (4) `primPtr = Render_gPacketPtr;` instead of `sd->head.cprim.PrimPtr`
           (89 -> 86, count 352 -> EXACT 353) -- the w71 DrawW_OnyxLinePrim lever:
           the sd-relative spelling folds to ONE `lw $a2,4($s1)` where retail emits
           the 2-insn literal form `lui $a2,0x1F80; lw $a2,4($a2)`.
       (5) OT-LINK TEMPLATE READS THE OTZ THROUGH ITS POINTER (86 -> 82).  The
           template's 2nd operand is `otz94` (a POINTER) with `lw $12,0(%2)` as its
           own second line and `sll $12,$12,2` moved after the `addiu` -- retail's
           `lw $a2,4($s1); lw $t4,0($fp); lw $t5,0($s1); addiu $t6,$a2,52;
           sll $t4,$t4,2`.  Passing the VALUE `*otz94` made cc1 emit that load
           OUTSIDE the asm, ahead of the template's own first load.
       (6) THE grey/ccount/m 3-WAY (82 -> 58, then the init order 58 -> 28).
           allocsim (MATCH 22/22 on the real -dg/-dl dumps) said the band was
           ours {ccount $s3, m $s4, grey $s5} vs retail {grey $s3, m $s4, ccount
           $s5}, and dialsearch found NO 1- or 2-dial solution on the natural
           order.  The triple that works: move `ccount_local = fskid->count;`
           ABOVE `m` (its live range grows 228 -> 237, refs stay 14) + a read-only
           fence on `m` (+1 ref -> 14 at live 235) + TWO read-only fences on `grey`
           (13 -> 14 refs at live 231).  Final priorities, allocsim-verified:
             p107 grey   refs 14 live 231  .1818 -> $s3   (retail $s3)
             p99  m      refs 14 live 235  .1787 -> $s4   (retail $s4)
             p101 ccount refs 14 live 237  .1772 -> $s5   (retail $s5)
           WARNING: ONE grey fence alone REGRESSES (96) -- it lifts grey above `m`
           but not above `ccount`, so grey steals $s4.  The three dials must land
           TOGETHER.  Then a 120-way permutation of the five init GROUPS
           (otz / sd / grey+ccount / m+fence / t+fence) picked
           (otz, sd, grey+cc, m, t) = 28; the natural order gates 34.
       (7) FENCED `-1` SENTINEL (50 -> 46).  The loop-exit sentinel is a
           loop-INVARIANT constant that loop.c hoists to the preheader, where it
           loses its register and reload rematerializes it into an arbitrary
           scratch ($t8); retail has `li $v0,-1`.  An opacity fence on the named
           constant gives that pseudo a SECOND set, so loop.c builds no movable and
           the constant stays a block-local qty that takes the lowest free reg.
           (Same device as the four `sd->offset = 0x7d` sites in DrawW_DoTrough,
           found in this same wave.)
       (8) SUBTRAHEND-FIRST on the three `ts.N = sm->cp.N - t->N` axes (46 -> 40)
           and INDEX-TERM-FIRST on the gClutDepth lookup (46 -> 40; both -> 34):
           qty_combine ties a sum's DEST to its FIRST operand and retail
           accumulates into the depth-index register.
       (9) BLOCK-1 STORE ORDER (58 -> 50 in its basin): the row-0 stores are
           written m[0][2], m[0][0], m[0][1].  A pure sched2 luid dial (all six
           permutations measured; blocks 2 and 3 are optimal in natural order).

     RESIDUAL 28 = TWO count-neutral classes:
       (A) ~22: the PROLOGUE emission order.  Retail's first-use order is
           m($s4), t($s6), otz94($fp), grey($s3), sd($s1) -- m/t FIRST -- while
           ours must keep `ccount_local` (and therefore `grey`) ahead of `m` for
           the (6) live-length dial, so our m/t pair is emitted late and `ccount`
           reads `lw $s5,48($a0)` where retail reads `lw $s5,48($s4)`.  Riding
           along: r2's row-0 chain (`lw a1,24(s4); sra a1; sh a1,24(s1)`) is
           DEFERRED past the skidIdx multiply in ours because $v0 is free at r2's
           birth, where retail's r2 is born BEFORE the multiply and must take $a1.
           NAMED ANGLE: a zero-insn +9 live-length dial for `ccount` that does NOT
           require moving its def above `m` (the 15A foreign-operand fence gives
           +1 live per placement -- nine of them is scaffolding; this is the
           standing 4-witness request for a device that lengthens a live range
           without adding a ref or a barrier).
           FALSIFIED AT THIS BASIN (do not re-run): all 120 init-group
           permutations (28 IS the minimum), all 6 row-0 store permutations, all 6
           row-0 load permutations, the skidIdx-multiply position after each of the
           three matrix blocks, and tools/stmtclimb2.py over all 21 statements
           (BEST 28, 0 def-use rejections).
       (B) 6: the OT-link template's `%0` lands in $v0 where retail has $a2
           (`lw v0,4(s1)` / `addiu t6,v0,52` / `sll t4,v0,8` / `sw t6,0(v0)`).
           A local-alloc qty pick inside the asm's operand block; the value is the
           packet cursor read at (4).
     ============================================================================ */

  otz94 = (int *)0x1f800094;
  sd = (Draw_DCache *)&Render_gPalettePtr;
  grey = 0x404040;
  ccount_local = fskid->count;
  __asm__("" : : "r"(grey));
  __asm__("" : : "r"(grey));
  m = &fskid->m;
  __asm__("" : : "r"(m));
  t = &fskid->t;
  /* MATCH (w72-a1): zero-insn READ-ONLY fence = exactly +1 REG_N_REFS on `t`
     (out of every loop, so the loop-depth weighting does not apply -- 21E(2)).
     reqdelta on the post-rule-8 dump: `p102 refs 10 -> 11` is the MINIMAL single
     dial that flips the t/skidIdx pair to retail's $s6/$s7. */
  __asm__("" : : "r"(t));
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
    (sd->matB).m[0][2] = (short)(r2 >> 4);
    (sd->matB).m[0][0] = (short)(r0 >> 4);
    (sd->matB).m[0][1] = (short)(r1 >> 4);
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
      /* MATCH (w72-a1): the `-1` sentinel is a LOOP-INVARIANT constant that
         loop.c hoists to the preheader, where it loses its register and reload
         rematerializes it into an arbitrary scratch ($t8); retail has `li $v0,-1`
         (a block-local qty that takes the lowest free reg).  An opacity fence on
         the named constant gives the pseudo a SECOND set, so no movable is built
         and the constant stays block-local.  Zero insns (353/353 either way).
         Same device as the four `sd->offset = 0x7d` sites in DrawW_DoTrough. */
      { int neg1 = -1; __asm__("" : "=r"(neg1) : "0"(neg1));
      if (ccount_local == neg1) {
        return;
      } }
      /* MATCH (w46-a6): retail has NO `skidIter` -- the SYM lists no such
       * local and the oracle mutates the byte cursor IN PLACE inside the
       * exit-test's delay slot (`beq $s5,$v0,exit; addiu $s7,$s7,-0x2B0`
       * @0x800C917C) and then forms the chunk pointer with a single
       * `addu $s2,$v0,$s7`.  The old copy-through-a-second-variable form
       * created an extra call-crossing allocno that took $s1 away from
       * `sd`.  Identical arithmetic: smp[-1]+0x10-2*8 == (int)smp-0x2B0. */
      skidIdx = skidIdx + -0x2b0;
      sm = (Skidmark_Chunk *)((int)fskid->smp + skidIdx);
      bVar2 = 0;
      skidChunk_p = (int)BWorld_IsSliceInBuildList((int)sm->slice);
      if (skidChunk_p != 0) {
        vert_count = Draw_CircleClip(&sm->cp,t,0x320000);
        bVar2 = vert_count != 0;
      }
    } while (bVar2 == 0);
    /* MATCH (w72-a1, w45-a5 subtrahend-first class): retail loads the
       SUBTRAHEND (`lw $v1,0($s6)` = t->N) BEFORE the minuend; a single
       `a - b` expression evaluates left-to-right and loads them the other way. */
    { int tx = t->x; ts.x = sm->cp.x - tx; }
    { int ty = t->y; ts.y = sm->cp.y - ty; }
    { int tz = t->z; ts.z = sm->cp.z - tz; }
    transform(&ts.x,(int *)m,&td.x);
    (sd->matB).t[0] = td.x >> 6;
    (sd->matB).t[1] = td.y >> 6;
    (sd->matB).t[2] = td.z >> 6;
gte_SetRotMatrix(&sd->matB);
gte_SetTransMatrix(&sd->matB);
    ti2 = *(int *)&sm->n;
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
      if ((sd->head.cprim.PrimPtr < sd->head.cprim.MPrimPtr) && (sm->seg[depth_skid].next != (Skidmark_Segment *)0x0)) {
gte_ldv0((int *)&sm->seg[depth_skid].svx[0]);
        gte_rtps();
gte_stlvnl(&sd->tVn0);
        /* MATCH (w72-a1): retail reaches the packet cursor through the
         * SCRATCHPAD LITERAL (`lui $a2,0x1F80; lw $a2,4($a2)`, 2 insns), NOT
         * through the sd base (which folds to a single `lw $a2,4($s1)` and
         * lands one insn short) -- the same lever that sealed
         * DrawW_OnyxLinePrim's `prim` in w71. */
        primPtr = Render_gPacketPtr;
        /* CORRECTNESS FIX (2026-07-12, oracle @0x800C92E0): SXY goes to the
         * CURRENT packet cursor (Render_gPacketPtr + 8), not the fixed
         * scratchpad literal 0x1F800008 (= Render_gPacketEnd's slot). */
gte_swc2(0xe,(void *)(primPtr + 8));
gte_ldv0((int *)&sm->seg[depth_skid].svx[1]);
        gte_rtps();
gte_stlvnl(&sd->tVn1);
gte_ldv0((int *)&sm->seg[depth_skid].next->svx[1]);
        gte_rtps();
gte_stlvnl(&sd->tVn2);
gte_ldv0((int *)&sm->seg[depth_skid].next->svx[0]);
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
          color_pack = sm->seg[depth_skid].type;
          /* CORRECTNESS BUG (W70, found by the m2c cross-verify -- seal criterion
           * 6 -- against C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_800C909C.c):
           * `gSkidMarkPixmap` is an ARRAY OF POINTERS (SYM nfs4-f-v3.txt:119780
           * `class EXT type ARY PTR STRUCT size 8 dims 1 2 tag Draw_tPixMap`), and
           * the SYM's own local here is `pmx` class REG, `PTR STRUCT size 16 tag
           * Draw_tPixMap` (block @0x800C9438 line 89).  The recon took the ADDRESS
           * of the pointer SLOT (`&gSkidMarkPixmap[i]` = 0x8013D1EC + i*4) and then
           * read four words + a halfword off it -- i.e. it copied the two POINTER
           * WORDS themselves (plus 8 bytes PAST the end of the 8-byte array) into
           * the primitive's UV slots, and indexed gClutDepth with garbage.
           * m2c is unambiguous: `temp_a3 = *(0x8013D1EC + ((temp_t0 & 1) * 4));`
           * then `temp_a2->unkC = temp_a3->unk0` ... `temp_a3->unkA << 5`, i.e. the
           * pointer is LOADED and dereferenced.  One indirection was missing. */
          pmx = gSkidMarkPixmap[color_pack & 1];
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
          /* MATCH (w72-a1): retail STORES the GTE OTZ through the literal
           * 0x1F800094 pointer it keeps in $fp (`swc2 $7,0($fp)`) but READS and
           * WRITES the same word as `sd->otz` (+0x94 = 148 off the $s1
           * scratchpad base, `lw $v0,148($s1)` / `sw $v1,148($s1)`).  Spelling
           * both sides through the literal made cc1 materialize a SECOND
           * lui/ori 0x1F800094 pair for the store operand. */
gte_swc2(0x7,otz94);
          vt_y = sd->otz >> 5;
          sd->otz = vt_y + 0x32;
          if (sd->otz < 1) {
            return;
          }
          if (Draw_gViewOtSize + -3 < sd->otz) {
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
            *(int *)((int)primPtr + 4) = *(int *)&sm->seg[depth_skid].rgb;
            *(int *)((int)primPtr + 0x10) = *(int *)&sm->seg[depth_skid].rgb;
            *(u_int *)((int)primPtr + 0x28) =
                 *(u_int *)&sm->seg[depth_skid].next->rgb;
            *(u_int *)((int)primPtr + 0x1c) =
                 *(u_int *)&sm->seg[depth_skid].next->rgb;
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

            l0 = *(u_long *)&pmx->u0;
            l1 = *(u_long *)&pmx->u1;
            l2 = *(u_long *)&pmx->u2;
            l3 = *(u_long *)&pmx->u3;
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
            depth_index = (vt_y - ((Draw_tGiveShelbyMoreCache *)sd)->startfog) * 0x10 >>
                       ((Draw_tGiveShelbyMoreCache *)sd)->distfog;
            if (depth_index < 0) {
              depth_index = 0;
            }
            else if (0xf < depth_index) {
              depth_index = 0xf;
            }
            *(short *)((int)primPtr + 0xe) =
                 /* MATCH (w72-a1): qty_combine ties the sum's DEST to its FIRST
                    operand -- retail accumulates into the depth-index register
                    (`sll $v1,$v1,1; sll $v0,$v0,5; addu $v1,$v1,$v0; addu $v1,$v1,$t8`).
                    The 2-D subscript form puts the ROW index first and accumulates
                    into $v0 instead; the index-term-first int sum flips it. */
                 *(short *)((depth_index << 1) + (pmx->pad2 << 5) + (int)gClutDepth_v);
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
           * bit-shift/alignment emulation it replaces was ALSO producing the wrong
           * runtime effect (see the w45 note below).
           * ---- W75-A5 (2026-08-23): 28 -> 20, count still EXACT 353/353.
           * THE w72 RESIDUAL CLASS (B) IS CLOSED.  The template's `%0` landed in
           * $v0 where retail has $a2 because the output was a FRESH block-local
           * `void *primOut` -- but `lw %0,4(%1)` re-reads exactly the value the
           * enclosing block already named: `primPtr = Render_gPacketPtr;` IS
           * sd->head.cprim.PrimPtr, i.e. the same word this template loads.
           * Writing the output back into `primPtr` makes it ONE pseudo instead of
           * two, so the dead `primPtr` register ($a2, dead after the `sh v0,14(a2)`
           * clut store) is reused for the template's result exactly as retail does
           * (`lw a2,4(s1)` / `addiu t6,a2,52` / `sll t4,a2,8` / `sw t6,0(a2)`).
           * This is VARIABLE IDENTITY (23C(2) / the w74 BuildSpikeBelt cure), not
           * a device: no clobber, no fence, and semantically the assignment the EA
           * macro itself performs (the template's %0 IS the newly allocated prim).
           * Zero risk to the four other users of `primPtr` in this block -- they
           * all run BEFORE the template and the value is identical.
           * (Historical: the 13-line bit-shift/alignment emulation this template
           * replaced was ALSO producing the WRONG runtime effect -- it recomputed
           * a byte-aligned unaligned merge generically instead of linking the
           * primitive into the OT chain at all, so Render_gPacketPtr's new prim
           * was never inserted into sub_ot[otz]: a real rendering bug that
           * dropped skidmark polys.)
           *
           * RESIDUAL 20 = the w72 class (A) alone, the PROLOGUE EMISSION ORDER.
           * RE-PRICED THIS WAVE at the new (post-primPtr) basin per 21E(1), all
           * three sweeps FALSIFIED again -- 20 is the minimum of every one:
           *   - all 120 permutations of the five init GROUPS  (min 20 = current)
           *   - all 720 permutations of the SIX init statements otz/sd/grey/
           *     ccount/m/t, i.e. grey and ccount split apart, which no earlier
           *     wave had tried    (min 20 = current; every m-first or t-first
           *     order sits at 58-70, so retail's m,t-first prologue is a strictly
           *     worse basin for us, not a nearby one)
           *   - the fence grid (grey 1-3 / m 1-3 / t 1-2) crossed with the
           *     m,t-first orders  (min 58)
           *   - the skidIdx-multiply position, before/after each of the three
           *     matrix blocks     (INERT: 20 at all four positions)
           *   - all 6 row-0 load x all 6 row-0 store permutations  (min 20 =
           *     current ld012/st012; 22 and 24 elsewhere)
           * So the standing w72 ask is unchanged and is the ONLY route left: a
           * zero-insn device that LENGTHENS a live range without adding a
           * REG_N_REFS and without inserting an RTL barrier.  flow.c:1594 +
           * flow.c:1975 are the definition -- REG_LIVE_LENGTH is incremented once
           * per real ('i'-class) insn the pseudo is live over, plus once per set;
           * NOTEs are not counted (the counting block sits inside the
           * `GET_RTX_CLASS (GET_CODE (insn)) == 'i'` arm) -- so lexical blocks,
           * loop notes and any other note-only construct are provably inert for
           * this dial, and the only reachable ends are the DEF (source position)
           * and the LAST USE.  Here the def cannot move: `ccount_local` must stay
           * above `m` to keep the grey/m/ccount priority band, which is exactly
           * what forces our m/t pair to be emitted last.
           * ---- W76-A5 (2026-08-23): STAYS 20; the m-first BASIN IS PRICED TO
           * EXHAUSTION and the PIN LANE IS FALSIFIED WITH RECEIPTS (so no pin
           * can land here even as last resort):
           *  - retail-order (m,t,otz,grey,sd,cc) with ccount READ THROUGH m
           *    (`((Draw_tCtrlSkidmark *)m)->count` -- the ref-transfer that
           *    reproduces retail's `lw s5,48(s4)`): fence grid grey 2-3 x m 0-1
           *    x t 1-2, adjacent AND tail-positioned: 58-94.  With ccM, cse
           *    MERGES fskid/m into one pseudo (offset-0 base) -> the parm loses
           *    its ARG-home spill (`sw a0,88(sp)` becomes `sw s4,48(sp)`,
           *    frame 88 -> 96) -- a second, independent breakage of the basin.
           *  - LAUNDER on m to break the cse merge: +1 insn (identity addu
           *    materializes, 23B-2) -- 62-125 @354/355, dead.
           *  - read-only fence on fskid to force the parm live: count drops to
           *    352 (one short), 73 -- dead.
           *  - PIN LANE PRICED: `register int ccount_local asm("s5")` over the
           *    retail order x fence grid: 58-108 -- the pin buys the band but
           *    NOT the merge/spill structure, so a pin cannot seal this fn.
           *  - r2/r0 20B denial in the CURRENT basin (launder+$2-clobber on the
           *    row-0 temps to flip v0->a1): 24-29, all worse.
           *  - per-fn FLAG-SPLICE lane (allowed compiler-input): -fno-delayed-
           *    branch 66 @363, -fno-thread-jumps 21 @352, -fforce-addr 71 @362,
           *    -G8 21 @352, -mno-split-addresses 64 @349 -- all worse.
           *  - corpus: no EA skidmark sibling (CTR VehGroundSkids is a
           *    different toolchain/idiom).
           * EMISSION = SOURCE ORDER at priority-0 ties (both scheds preserve
           * input here), so the residual needs retail's m,t-first SOURCE order
           * to coexist with the band -- every device family measured cannot
           * provide both.  NAMED NEXT ANGLE: instrument-diff the -dg allocno
           * tables of the current vs m-first basins and find the single
           * allocator input (ref/live/conflict) that retail's basin satisfies;
           * i.e. this is now an instrument task, not a probe task. */
          {
            __asm__ volatile(
                "lw\t%0,4(%1)\n\t"
                "lw\t$12,0(%2)\n\t"
                "lw\t$13,0(%1)\n\t"
                "addiu\t$14,%0,52\n\t"
                "sll\t$12,$12,2\n\t"
                "addu\t$13,$13,$12\n\t"
                "sw\t$14,4(%1)\n\t"
                "lwl\t$14,2($13)\n\t"
                "lui\t$12,0x0C00\n\t"
                "srl\t$14,$14,8\n\t"
                "or\t$14,$14,$12\n\t"
                "sll\t$12,%0,8\n\t"
                "sw\t$14,0(%0)\n\t"
                "swl\t$12,2($13)"
                : "=&r"(primPtr)
                : "r"(sd), "r"(otz94)
                : "$12", "$13", "$14", "memory");
          }
        }
        }
      }
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
     sites restored the plain `lh`. The later SYM-exact cleanup also removed the
     remaining `ts2/ts4/ts6` decompiler temporaries and reads `dvy` directly at
     both textual uses; gcc emits the same 166-instruction retail body. */
  Draw_SVertex *v0;
  Draw_SVertex *v1;
  Draw_SVertex *v2;
  Draw_SVertex *v3;
  POLY_GT4 *prim;

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
  {
    u_long a;
    u_long b;

    a = *(u_long *)&prim->r1;
    b = *(u_long *)&prim->r0;
    *(u_long *)&v2->r = a;
    *(u_long *)&v1->r = a;
    *(u_long *)&v3->r = b;
    *(u_long *)&v0->r = b;
  }
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
    if ((((1000 < v0->dvy) || (v0->dvx < -1000)) || (v0->dvy < -1000)) || (v0->vz < 0x65))
    goto DrW_SubSetupLine_v0Alpha;
  }
  else {
DrW_SubSetupLine_v0Alpha:
    v0->a = '\x01';
  }
  v1->a = '\0';
  if (v1->dvx < 0x3e9) {
    if (((1000 < v1->dvy) || (v1->dvx < -1000)) || ((v1->dvy < -1000 || (v1->vz < 0x65))))
    goto DrW_SubSetupLine_v1Alpha;
  }
  else {
DrW_SubSetupLine_v1Alpha:
    v1->a = '\x01';
  }
  v2->a = '\0';
  if (v2->dvx < 0x3e9) {
    if (((1000 < v2->dvy) || (v2->dvx < -1000)) || ((v2->dvy < -1000 || (v2->vz < 0x65))))
    goto DrW_SubSetupLine_v2Alpha;
  }
  else {
DrW_SubSetupLine_v2Alpha:
    v2->a = '\x01';
  }
  v3->a = '\0';
  if (v3->dvx < 0x3e9) {
    if ((((v3->dvy < 0x3e9) && (-0x3e9 < v3->dvx)) && (-0x3e9 < v3->dvy)) && (100 < v3->vz))
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
  /* ---- w71-a1 (2026-08-21): 89 -> 66, count 506 -> EXACT 507/507.  One rule-8
     unification, in three steps, each gated:
       (1) DELETE the invented `packetPtr` local and use the SYM's `prim`
           (REG $0x10 = $s0, PTR STRUCT size 52 tag POLY_GT4) for it (89 -> 74).
           Retail materializes the packet cursor ONCE and drives ALL FOUR GTE
           store targets (+8 / +0x14 / +0x20 / +0x2C) off that one $s0 register,
           only OVERRIDING it with &sd->GT4Prim in the subdivision arm.  Splitting
           the same value across two C locals gave the early half a CALLER-saved
           home ($a1) instead of $s0 and rotated the whole REGPARM set
           (geomVertices/lineQuad landed $s7/$s5 instead of retail's $s3/$s6).
       (2) DROP the now-redundant `prim = sd->head.cprim.PrimPtr;` reload in the
           OT-link arm -- `prim` already holds it (74 -> 69, count 505 -> 506).
       (3) MATERIALIZE IT FROM THE SCRATCHPAD LITERAL, `prim = (POLY_GT4 *)
           Render_gPacketPtr;` (the par.3.6b fixed-address macro), NOT through
           `sd->head.cprim.PrimPtr`: retail emits `lui $s0,0x1F80; lw $s0,4($s0)`
           (2 insns, the literal form) where the sd-relative spelling folds to a
           single `lw $s0,4($s1)` -- one insn SHORT.  69 -> 66, count EXACT.
     RESIDUAL 66 = TWO classes, both count-neutral:
       (A) the REGPARM pair is still rotated (ours geomVertices $s7 / lineQuad $s5,
           retail $s3 / $s6) and the vertex-copy giv is anchored at
           `geomVertices+20` where retail anchors at `geomVertices+16` -- the same
           four addresses, split differently between the two loop bivs (retail:
           +0/+12/+20/+28 off $s3 and +4/+8/+16/+24 off $s5).  That anchor is a
           loop.c giv-base choice; the SYM names no local for it.
       ---- w72-a1 (2026-08-22) FALSIFIED, ALL COUNT-EXACT 507/507, ALL REVERTED:
           the giv anchor is NOT reachable from the copy block's source shape.
             all 24 permutations of the four vertex copies      66-88 (66 = ours)
             all 16 word-order swaps inside the copies          66, BYTE-IDENTICAL
               (cse canonicalises a pair's two loads before loop.c runs)
             an explicit TWO-BASE pointer form reproducing retail's exact
               displacement map (`int *g = (int *)geomVertices; int *g2 = g + 4;`
               words 0/12/20/28 off g and 4/8/16/24 off g2)     66, BYTE-IDENTICAL
             a single explicit `+16` base                       66, BYTE-IDENTICAL
             a single explicit `+0` base                        66, BYTE-IDENTICAL
             align-4 `struct {int a,b;}` pair-assign copies    104
             four FRESH named temp pairs instead of one reused  82
           => loop.c's combine_givs re-derives the SAME two bases from every index
           OR pointer spelling (the 15B law at full strength), so the +20-vs-+16
           anchor is a loop.c-internal choice.  allocsim MATCHes 17/17 here, and
           the REGPARM rotation is DOWNSTREAM of it: retail's geomVertices carries
           FOUR in-loop accesses (enough refs to outrank the giv at pri .4377)
           where ours carries ONE (refs 16 / live 277 / pri .2310), so no ref or
           live dial on p80 alone can reach $s3 -- the anchor must move first.
           NEXT INSTRUMENT: the -dL `giv of insn N not worth while` / combine_givs
           trace on this loop (the 16B razor), not another source spelling.
           ---- w74-a1 (2026-08-23) THE -dL TRACE IS IN, AND IT CLOSES THE
           SOURCE-SIDE SEARCH WITH A MECHANISM (CC1PLPSX -O2 -G4 -dL on this TU;
           the loop dump is quotable, it is the real compiler).  For biv 80
           (= geomVertices, incremented 16 per iteration at BOTH `+= 2` sites) the
           dump lists SEVEN address givs -- `dest address src reg 80 ... mult 1
           add 24 / 28 / 8 / 12 / 4 / 16 / 20` (insns 91/94/105/108/122/133/136) --
           and then
               giv at 133 combined with giv at 136
               giv at 122 combined with giv at 136   ... (all six)
               giv at 136 reduced to (reg:SI 287)
           i.e. ALL SEVEN collapse onto the add-20 giv, which is our `+20` anchor.
           WHY IT IS UNCONDITIONAL: combine_givs walks giv_array in bl->giv order,
           and bl->giv is built by PREPENDING, so giv_array[0] is the LAST giv in
           body order -- add 20 here.  combine_givs_p (loop.c) accepts a DEST_ADDR
           g2 whenever express_from() is a legal address and
           `ADDRESS_COST(tem) <= ADDRESS_COST(*g2->location)`; on MIPS both sides
           are reg+const16, so the test is a TIE and every giv combines.  That is
           why all 24 copy permutations only ever MOVE the anchor (66-88) and never
           split it, and why the explicit two-base pointer form is byte-identical.
           Retail's map (biv-direct at +0/+12/+20/+28 and ONE reduced giv at +16
           carrying +4/+8/+16/+24) needs TWO giv groups, which 2.8.x combine_givs
           cannot produce from ONE biv.  ==> the remaining named angle is a SECOND
           REAL BIV (a self-incrementing companion pointer advanced beside
           geomVertices) so four addresses hang off a different iv class; it is the
           only construct that yields two anchors, and it must be priced against
           the +1 insn per advance site (there are two).  Do NOT spend more on copy
           order, word order, or derived-pointer spellings: the dump proves they
           all feed one giv class.
       (B) the two 4-byte AUTO slots 72/76(sp) are swapped, and `save_pre_otz`
           takes $s6 where the SYM says $s7 -- both follow (A).
     ---- w75-a6 (2026-08-23): ONE MORE FALSIFICATION on the (A) axis, and it bounds
       the "second iv class" ask from the other side.  KILLING BIV-NESS ENTIRELY --
       one opacity launder `__asm__("" : "=r"(geomVertices) : "0"(geomVertices));`
       at the head of the vertex-copy block, which gives the pointer a set that is
       NOT `reg = reg + invariant` so loop.c cannot classify it as a biv at all --
       gates 190 @501, i.e. SIX INSNS SHORT and far worse.  That is the giv
       machinery's own cost measured directly: retail definitely strength-reduces
       here, so the remaining angle is still exactly the recorded one (a SECOND
       REAL BIV, a companion pointer with its own `+= 2` at both advance sites, so
       combine_givs has two iv classes to hang the 8 loads on).  The launder is
       therefore NOT a shortcut to it -- do not re-try the biv-kill.
     ---- W76-A6 (2026-08-23): THE SECOND REAL BIV WAS BUILT AND MEASURED (temp
       sibling TU, reverted): `int *g2 = (int *)geomVertices + 1;` before the
       outer loop, `g2 += 4` beside BOTH `geomVertices += 2` advance sites, and
       the 8 copy words split g2[5]/gv[7], g2[1]/gv[3], gv[0]/g2[0], g2[3]/gv[5]
       (scratchpad/w76/a6_o1.json).  GATE 213 @524 (+17 insns, frame 120->128) --
       BUT the structure half-WORKED and the receipt is sharp:
       (a) 🔑 the g2 CLASS REPRODUCES RETAIL'S s5 EXACTLY -- reduced giv anchored
           at abs +16 (disps +8/-8/0 for words 24/8/16, retail-identical; word 4
           spilled to a temp only from pressure).  The anchor law held perfectly:
           with g2 init at +4, the LAST g2-giv in body order is vt3's g2[3]
           (abs 16) -> the combined giv anchors there = retail's s5.  The g2 half
           of the construct is SOLVED; keep the o1 spelling for it.
       (b) the FAILURE is the gv class: ours REDUCES its 3 givs (28/12/20) into a
           second new reg (anchor +20) + keeps the biv for word 0, where retail
           uses the BIV DIRECT for all of 0/12/20/28 -- the extra reduced-giv reg
           is what blows the frame/pressure (+17).
       (c) gcc-source facts for the next belt (loop.c, gcc-2.8.1-src): DEST_ADDR
           givs get v->lifetime = 1 (loop.c:4577); combine_givs SUMS benefit AND
           lifetime into the leader (:5760ff `g1->benefit += g2->benefit;
           g1->lifetime += g2->lifetime`); the per-leader ignore test is
           `lifetime * threshold * benefit < insn_count` (:3914) with threshold =
           (loop_has_call ? 1 : 2) * (3 + n_non_fixed_regs) (:3280) and a further
           `benefit -= add_cost * bl->biv_count` (:3881); a +0 access is NEVER a
           giv (:4376 mult==1&&add==0 excluded) so it is always biv-direct free.
       NEXT ANGLE (named, sharper than before): make the gv class FAIL the :3914
       test while g2's passes.  The dials in the formula: gv-class giv COUNT
       (fewer givs = smaller summed lifetime*benefit -- move a 4th word onto g2?
       but retail's word->base map is fixed), biv_count (a THIRD gv increment
       site would raise add_cost*biv_count and cut benefit -- e.g. splitting one
       `+= 2` into `+= 1; += 1`... must stay count-neutral), or loop_has_call/
       n_non_fixed_regs (global, untouchable).  Run CC1PLPSX -dL on the o1 form
       FIRST: it prints the exact `lifetime * threshold * benefit` vs insn_count
       numbers for both classes (the :3919 dump line), which turns the dial
       choice into arithmetic.  Do NOT re-try: single-class spellings (all
       falsified w72), the biv-kill launder (w75), or an UN-advanced g2 (its givs
       just rejoin the gv class -- w72's two-base form).
     ---- */
  POLY_GT4 *prim;
  int lineQuadCount;
  Draw_tPixMap *pmx;
  CCOORD16 vt0;
  CCOORD16 vt1;
  CCOORD16 vt2;
  CCOORD16 vt3;

  lineQuadCount = 0;
  sd->offsubdivid = 0x200;
  while (lineQuadCount < count + -1) {
    int linetype;

    while ((lineQuadCount < count + -1) && (lineQuad->type != 0xff)) {
      int doSubdivision;
      int save_pre_otz;
      int depthcue;

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
      /* MATCH (w71-a1, rule-8): the SYM names ONE pointer here -- `prim` (REG $s0,
         PTR STRUCT size 52 tag POLY_GT4) -- and the oracle materializes it ONCE
         (`lui s0,0x1F80; lw s0,4(s0)` = sd->head.cprim.PrimPtr, the same cell the
         Render_gPacketPtr macro names) and drives ALL of the +8/+0x14/+0x20/+0x2C
         GTE store targets off it, only overriding it with &sd->GT4Prim in the
         subdivision arm below.  Splitting it into a separate short-lived
         `packetPtr` local gave that value a CALLER-saved home ($a1) instead of
         retail's callee-saved $s0 and rotated the whole parameter set. */
      prim = (POLY_GT4 *)Render_gPacketPtr;
      gte_swc2(0xe,(void *)((char *)prim + 8));
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
      gte_stsxy3((void *)((char *)prim + 0x14),(void *)((char *)prim + 0x2c),
                 (void *)((char *)prim + 0x20));
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
         * prim->tag = slot->addr24 | (0x0C<<24); slot->addr24 = prim.
         * `prim` already holds sd->head.cprim.PrimPtr from the transform block
         * above (rule-8: ONE SYM local, w71-a1). */
        __asm__ volatile(
            "lw	$12,0(%2)
	lw	$13,0(%1)
	addiu	$14,%0,52
	sll	$12,$12,2
	addu	$13,$13,$12
	sw	$14,4(%1)
	lwl	$14,2($13)
	lui	$12,0x0C00
	srl	$14,$14,8
	or	$14,$14,$12
	sll	$12,%0,8
	sw	$14,0(%0)
	swl	$12,2($13)"
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
	
	lineQuadCount++;
	lineQuad++;
	geomVertices += 2;
  }
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
     reduction of pts3d[N].light -- not a source-level variable). The SYM
     `lineQuad` local is used as the walking Trk_Line* and reads firstPoint/slice
     as named struct fields instead of raw u_char[0]/[1] casts (Trk_Line =
     {firstPoint,slice,type,quadIndex} matches the byte layout 1:1); resetting it
     before the call matches the oracle recomputing group+1 via $t9 there without
     an additional source alias. chunkDat->firstSimSliceInd has NO separate SYM
     name -- it's a loop-invariant load the compiler CSEs into $s2 on its own; giving
     it an explicit local (the old sVar3) is unnecessary and is dropped. */
  int i;
  CCOORD16 *pts3d;
  Trk_Line *lineQuad;
  int slice;
  short tx;
  short ty;
  short tz;
  CCOORD16 *wpts;

  pts3d = gVertex3d;
  lineQuad = (Trk_Line *)(group + 1);
  i = 0;
  slice = chunkDat->firstSimSliceInd;
  tx = trans->x;
  ty = trans->y;
  tz = trans->z;
  wpts = (CCOORD16 *)(chunkDat->vertexBuf + 1);
  while (i < group->m_num_elements << 1) {
    i = i + 2;
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
    char *rn; /* SYM-CODEGEN-CARRIER: rn -- direct right[0..2] is 29 diffs and one instruction short */
    short x;
    short y;
    short z;
    short wx;
    short wy;
    short wz;

    pts = wpts + (u_int)lineQuad->firstPoint;
    rn = ((Trk_NewSlice *)(((slice + (u_int)lineQuad->slice) << 5) + (int)BWorldSm_slices))->right;
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
    lineQuad = lineQuad + 1;
  }
  lineQuad = (Trk_Line *)(group + 1);
  DrawW_OnyxLinePrim(gVertex3d,lineQuad,group->m_num_elements,sd);
  return;
}

/* ---- DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache  [DRAWW.CPP:3396-3467] SLD-VERIFIED ---- */
void DrawW_DoLines(DRender_tView *Vi,tBuildEntry *buildList,Draw_DCache *sd)

{
  /* Source-only identities retained only where the oracle proves their
     statement/allocation role; they are not asserted SYM locals:
     SYM-CODEGEN-CARRIER: m -- mixed matB lvalues are the measured exact GTE-base shape.
     SYM-CODEGEN-CARRIER: m2 -- the in-loop sibling requires the same mixed-base shape.
     SYM-CODEGEN-CARRIER: posX -- completing the target-pointer chase as its own statement preserves retail's load-delay stall.
     SYM-CODEGEN-CARRIER: posY -- y-axis instance of the independently measured pointer-chase split.
     SYM-CODEGEN-CARRIER: posZ -- z-axis instance of the independently measured pointer-chase split.
     SYM-CODEGEN-CARRIER: tx -- direct final subtraction is FAIL 6 at 199/199 because the translation load moves.
     SYM-CODEGEN-CARRIER: ty -- y-axis scheduling identity in that same current falsification.
     SYM-CODEGEN-CARRIER: tz -- z-axis scheduling identity in that same current falsification. */
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
     both pure sched2 tie-breaks; permuter candidates.
     w46-a7 RE-GATED 8 (count-exact 199/199).  The residual is now ONE named
     class, shared with DrawObjectSimple in this same TU:
       PROLOGUE PARAM-COPY SINK -- retail issues `addu s0,a0,zero` (Vi) at insn 2
       but SINKS `addu s1,a1,zero` (buildList) all the way to insn 32, the loop
       head, and consequently leaves `sw s1,68(sp)` inside the normal save run at
       15 instead of hoisting it to the top.  Ours issues the a1 copy at insn 2
       and hoists its save with it.  Identical insn multiset, one transposition.
     FALSIFIED this wave (all 8, i.e. byte-identical): moving the `Vi++; Vi--;`
     pair below `chunkCount = ...`; a second `Vi++; Vi--;` pair; a zero-insn USE
     fence on buildList at the loop head.  A fence on Vi at the top REGRESSES to
     14.  REMOVING either net-zero pair regresses to 42 -- both are still needed.
     *** w50-a2 (2026-08-09): PASS 199/199.  THE PROLOGUE PARAM-COPY SINK WAS
     NOT A SINK AT ALL -- it was the LOOP-POINTER INIT, and the fix is the
     INDEX FORM. ***  The oracle's `addu $s1,$a1,$zero` is emitted at the END of
     the loop preheader, AFTER all of loop.c's own hoists (`addu s6,zero,zero`,
     the lui/addiu global, `addiu s7,sp,24`, `addiu s3,sp,40`) -- that placement
     is the signature of a giv INIT that loop.c appends to the preheader, not of
     an assign_parms copy.  Writing the walk as `buildList[buildInd].field` (and
     deleting the explicit `buildList = buildList + 1;`) makes gcc strength-reduce
     the index into exactly that walking pointer, so the init lands where retail
     has it and the whole body is byte-identical.  Three levers, in order:
       (1) 8 -> 6: alias the parameter into a block-local at the loop head
           (`tBuildEntry *buildList = buildListArg;`) -- this alone sinks the
           a1->s1 copy out of the entry block (the w46 "no source position can
           reach assign_parms" verdict is thereby RETIRED: you cannot move the
           parm copy, but you CAN make the s-register's def be a different insn).
       (2) 6 -> 2: DELETE the `Vi++; Vi--;` net-zero pair.  It had been keeping
           Vi's allocno above buildList's, but with the alias in place it only
           cost Vi its LAUNCH BOOST (adjust_priority raises a readied insn to
           0x7f000001 only if birthing_insn_p, i.e. REG_N_SETS(reg)==1; a
           net-zero pair makes 3 sets), so the a2/sd copy won cycle 0 and Vi's
           copy sank 6 slots.  Textbook w45 LEVER-ORDER DEPENDENCE: the pair was
           load-bearing in the old basin and harmful in this one.
       (3) 2 -> PASS: the index form above (the alias and the explicit increment
           both disappear with it).
     FALSIFIED at the 8-diff basin (all byte-identical, all reverted): the w47
     OPACITY fence `__asm__("" : "=r"(buildList) : "0"(buildList))` at the loop
     head / before the net-zero pair / after it / replacing it; the same fence on
     Vi at the top REGRESSED to 14 (as the older use-fence did).  At the 2-diff
     basin: a net-zero pair on the ALIAS regressed to 44 (it defeats the giv), two
     stacked opacity fences likewise 44, a single opacity fence was a no-op.
     NOTE the w11 receipt above says "index-form buildList[buildInd] regressed to
     54" -- true in ITS basin (both net-zero pairs, no alias); the index form only
     wins once the pairs are gone.  The same instrument still applies to
     DrawObjectSimple's `lw s5,96(sp)`. */
  int chunkCount;

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
    for (buildInd = 0; buildInd < chunkCount; buildInd = buildInd + 1) {
      Chunk *chunkDat;
      int geomRez;
      geomRez = (signed char)buildList[buildInd].geomRez;
      if (geomRez == 4) {
        chunkDat = Track_chunkList + buildList[buildInd].chunkInd;
        Group *group = chunkDat->lineBuf;
        if ((group != (Group *)0x0) && ((buildList[buildInd].enableBits & 4U) != 0)) {
          COORD16 trans;
          if (gNight_renderNight != 0) {
            coorddef tmp;
            coorddef tmp2;
            geomRez = *(u_char *)((int)sd[1].matB.t + 2);
            *(u_char *)((int)sd[1].matB.t + 2) = geomRez | 4;
            if (((Cars_gList[Vi->player]->control).lights & 6U) != 0) {
              *(u_char *)((int)sd[1].matB.t + 2) = geomRez | 5;
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
            pChunkCp = Chunk_chunkCenters + buildList[buildInd].chunkInd;
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
    }
  }
  return;
}

/* ---- DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache  [DRAWW.CPP:3692-3815] SLD-VERIFIED ---- */
void DrawW_BuildSpikeBelt(DRender_tView *Vi,int scale,Draw_DCache *sd)

{
  /* The following source-only names are measured compiler-shaping carriers,
     not asserted retail debug locals.  Their exact alternatives are priced in
     the W74-W76 receipt below:
     SYM-CODEGEN-CARRIER: so -- bare offset preserves both loop.c GIVs.
     SYM-CODEGEN-CARRIER: dof -- destination-first GIV discovery fixes the handout.
     SYM-CODEGEN-CARRIER: p -- removing the source address pseudos is FAIL 145 (279/268).
     SYM-CODEGEN-CARRIER: q -- paired destination address pseudo is part of that result.
     SYM-CODEGEN-CARRIER: vt -- one reused subtrahend temp is PASS; three temps are FAIL 44 and a pointer is FAIL 51. */
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
  /* w49-a2 FALSIFIED (residual 70, count-exact 268/268): the oracle evaluates
     forward[0] FIRST (`lb s4,15(v1)` SLD 3711 -> `sh s4,368(sp)`), so the SLD
     statement order really is fx,fy,fz -- but REORDERING these three blocks to
     fx,fy,fz (or fx,fz,fy) gates WORSE (76): the stack slots already agree
     (fx@368/fz@384 both sides) and the real residual is an s4<->s2 assignment
     swap (ours s4=fz/s2=fx, oracle s4=fx/s2=fz) that statement order does not
     reach.  Treat it as a local-alloc qty question (birth order / QTY_CMP_PRI),
     not an evaluation-order one. */
  /* w53-a1 LANDED (70 -> 66, count-exact 268/268): ONE reused block temp `t`
     in ONE block, statements in the SLD's fx,fy,fz order.  Three separate
     `{int tN;}` blocks (any permutation) gate 72-78; the same-identifier
     redeclaration form gates 76; a named slice pointer 76.  Merging the three
     temps into ONE pseudo is what moves it -- fewer block qtys, and with the
     SLD order the lb sequence becomes the oracle's 15/16/17.  RESIDUAL 66 is
     now three named clusters, all local-alloc qty NUMBERING (2- and 3-qty
     blocks, w46 3-QTY LAW territory, NOT priority): (a) fx/fz still s2<->s4
     swapped with the sra/sh interleave one slot late; (b) the two copy-loop
     givs a2<->a3 swapped in BOTH the 72/80 and 144/152 loops (init ORDER is
     already src-then-dst on both sides, so it is the qty handout, not the
     source order); (c) the tail t4/t3 pair 408/456(sp) swapped.  All three are
     the SAME 2-way handout question -- crack one, transcribe.
     ---- w61-a2 (2026-08-15) SIX MORE FALSIFICATIONS on cluster (b), including
     BOTH forms of the w60 BIV/GIV-preheader law and the w61 declaration-order
     law.  Re-gated base 66 @268/268.  Exact residual re-read: the two byte-offset
     counters are emitted in the SAME source order on both sides (72 = the `k`
     source cursor, then 80 = loop.c's dest giv) but retail gives the DEST the
     LOWER register (a2) and puts `li 72` THIRD in the preheader (after `li a1,1`
     and `addiu t0,sp,16`), while ours emits `li a2,72` FIRST of all and gives the
     SOURCE a2.  Measured, all reverted:
       + a named dest pointer `CCOORD16 *q = &vertex3d[i+N];` declared BEFORE `p`
         (stores written through q)                              66  (INERT)
       + the same declared AFTER `p`                             66  (INERT)
         => gcc folds both named cursors into the same two givs, so the
            declaration-order dial does NOT reach compiler-created givs.
       + FULL INDEX FORM (drop `k` entirely, `vertex3d[i+9] = vertex3d[i+8]`,
         i.e. the w60 BIV-ELIMINATION shape that sealed DrawC_PrimMenu)
                                                                105 @259
         => NINE INSNS SHORT: loop.c eliminates BOTH bivs and retail does not,
            so retail really does carry an explicit byte cursor here.  The
            current form is the count-correct one -- do not re-try the index form.
       + the same with a dead `k = 0;` kept                      105 @259
       + `i = 1;` emitted BEFORE `k = ...;` (birth-order swap)    90 @268
       + roles swapped: explicit cursor on the DEST, indexed SOURCE
                                                                149 @263
     => neither birth order, nor named cursors, nor which side is the explicit
     biv moves the 2-way handout.  The remaining instrument is the local-alloc
     [find_free_reg] trace on the 268/268 basin (why a2 goes to the source qty),
     exactly as clusters (a) and (c) already say.
     ---- w72-a1 (2026-08-22): the 20B/21A ZERO-INSN DIAL FAMILY is falsified here
     too (cluster (b), loop 2, all count-exact 268/268, all reverted):
         read-only fence on `k` BEFORE the loop  (+1 ref, out-of-loop)   70
         read-only fence on `k` INSIDE the loop  (+2 refs)               90
         read-only fence on `p` inside the loop                        116
         read-only fence on `i` inside the loop                         66 (INERT)
         opacity launder on `k` before the loop                         94
         a named dest pointer `CCOORD16 *q = &vertex3d[i+9];`           66 (INERT)
     Two of six exactly INERT and four strictly worse is the signature of a handout
     that is NOT priority-ordered -- i.e. the w46 3-QTY LAW applies here
     (local-alloc.c:1588 hand-rolls next_qty <= 3 and compares RAW QTY NUMBERS, so
     no ref/live dial can move it by construction).  The named angle therefore
     stands and is NOT a dial: CROSS THE 3<->4 QTY BOUNDARY by injecting a
     genuinely distinct-valued 4th block-local qty into the loop body (a value cse
     cannot fold back).  FIRST STEP: read the -dl `in block N` list for loop 2 and
     confirm next_qty == 3 before spending anything on the injection.
     ---- W70 (2026-08-16) CLUSTER (a): the catalog's "load-3/store-3 grouped
     temps" row (par.B row 55) is FALSIFIED here, which CONFIRMS the w53 reading
     that ONE reused pseudo is the optimum.  Retail loads the three signed bytes
     into THREE DISTINCT registers (`lb s4,15(v1); lb s3,16(v1); sra s4,s4,1;
     lb s2,17(v1); sra s3,s3,1; sh s3,376(sp); sra s2,s2,1`) which reads exactly
     like the grouped-temps signature -- but those three registers come from the
     ALLOCATOR, not from three source temps.  Measured, all count-exact 268/268,
     all reverted:
       base (one reused block temp `t`)                        66  <- optimum
       three temps in ONE block, loads interleaved with stores 76
       three temps in ONE block, loads then stores (grouped)   76
       three temps in ONE block, reverse assignment order      76
       two temps in one block (t0/t1, t0 reused for fz)        72
       one temp + one extra (`t`,`u`)                          72
     Monotone in the number of block pseudos: every added pseudo costs ~+3.  Do
     NOT re-try any grouped-temp spelling; the residual is the 2-way qty handout,
     as clusters (b)/(c) already say.
     ---- w74-a1 (2026-08-23): 66 -> 30, count-EXACT 268/268.  CLUSTERS (b) AND (c)
     ARE BOTH CLOSED, and the standing 3-QTY-LAW angle above is REFUTED.
       FIRST STEP RUN (the receipt asked for it): the instrumented-cc1 qty trace
       (tools/qtytrace.py; this function is byte-IDENTICAL in the lab, so the trace
       is a receipt) says the three copy-loop bodies are blocks 3/5/7 with FIVE and
       SIX qtys -- the qsort path, NOT local-alloc.c:1588's hand-rolled next_qty<=3
       arm.  And the two constants of cluster (b) are not block qtys at all: `k`
       (p85, refs 21 / live 81) and the dest givs (p386 refs 7 / live 23, p382 refs
       7 / live 25) are GLOBAL allocnos, all three in `;; 26 regs to allocate:`.
       So neither the 3-QTY LAW nor the qty-count dial ever applied here.
       (b) THE CURE IS VARIABLE IDENTITY, NOT A DIAL (66 -> 46).  One fn-scope `k`
       shared by all three copy loops is ONE allocno with 21 refs (pri 4.148) that
       outranks every per-loop dest giv (2.43) and takes $a2, pushing the givs to
       $a3; retail has it the other way round.  `k` is ALSO absent from the SYM's
       local list, i.e. it was a fabricated fn-scope temp.  Giving each loop its own
       block-local byte cursor splits the allocno three ways and the pair lands:
       `li $a3,72` and `li $a3,144` now match retail exactly.  Measured: loops 2+3
       split 46 - all three split 46 - all three split with the `int k;` declaration
       deleted 46 (LANDED, the most faithful) - loop 2 alone 56 - loop 3 alone 56.
       (c) ONE REUSED SUBTRAHEND TEMP (46 -> 30).  Retail loads the view
       translation BEFORE the slice coordinate at every axis (`lw $t4,456(sp);
       lw $t3,408(sp); lw $v1,8($t4); lw $v0,0($t3)`); ours loaded the minuend
       first and the two frame reloads came out t4/t3 swapped.  ONE reused block
       temp for the subtrahend gives retail's order and register pair; three
       separate temps 44, a `coorddef *vt` pointer local 51 @269.  Same
       one-reused-pseudo identity as cluster (a)'s `t`.
       (a) RE-PRICED TWICE at the new basins (21E-1) and the one-reused-temp form
       stays optimal: three temps shifted in place / three temps interleaved /
       three sibling blocks all gate 56 at the 46-basin and 40 at the 30-basin.
     RESIDUAL 30 = cluster (a) (about 20: the fx/fy/fz lb/sra interleave, retail
     s4/s3/s2 loaded into THREE registers and shifted in place while ours loads one
     reused pseudo and shifts into three destinations) plus about 10 pure emission
     positions (`addu $a2,$zero,$zero` three slots late, `li $a3,72` two slots late,
     `li $a3,144` / `li $a1,1` / `addiu $t0,sp,16` rotated by one).  Both are
     count-neutral.
     ---- W75-A5 (2026-08-23): 30 -> 28, count still EXACT 268/268 (posmis 23).
     HALF OF THE EMISSION CLUSTER IS CLOSED, AND CLUSTER (a) IS RE-PRICED AND
     STILL OPTIMAL.
     (i) LANDED: the three copy-loop byte cursors must be initialised AFTER `i`,
         not before -- see the `{ int kk; i = 1; kk = C; }` split at each loop
         head below.  A `{ int kk = C; i = 1; ... }` DECLARATION-INITIALISER makes
         the cursor store the block's FIRST statement, and 21B(3) appearance order
         then emits it ahead of `li $a1,1`; splitting the declaration from the
         assignment moves it behind `i` at zero insns.  This fixed the `li $a3,72`
         and `li $a1,1` slots in loops 2 and 3.
         MEASURED (all 268/268): base 30 - `i` first via a split decl 28 - `i = 1`
         lifted OUT of the block, `int kk = C` inside 28 - both split 28 - `i = 1,
         kk = C` as one comma statement 28 - `kk` promoted to a FUNCTION-SCOPE int
         shared by all three loops 74 (the w74 variable-identity law again: one
         shared cursor allocno is catastrophic here).
     (ii) THE REMAINING CURSOR SLOT NEEDS THE CURSOR BEHIND THE TWO loop.c GIVS
         (`addiu $a3,$sp,16` base + `addiu $a0,$sp,24` dest), which no source
         position reaches: the givs are emitted by loop.c into the preheader,
         every pre-loop source assignment lands in the entry block ahead of them,
         and giving the base an explicit source name to drag it forward costs +2
         insns -- `CCOORD16 *b = vertex3d;` 38 @270, `int b = (int)vertex3d;`
         38 @270, the same declared last 38 @270.  Retail's cursor is therefore
         emitted by loop.c itself, not by a source statement -- the standing
         "born in the loop" (21B(3)) question, and `kk` cannot be a movable
         because `kk += 8` gives it n_times_set == 2 (loop.c:779).
     (iii) 🏆 CLUSTER (a) IS CLOSED (28 -> 8, count still EXACT 268/268).  THERE IS
         NO TEMPORARY AT ALL: retail loads each signed byte STRAIGHT INTO the
         short AUTO's own pseudo and shifts it IN PLACE, which is why it holds
         three distinct callee-saved registers ($s4/$s3/$s2) instead of our one
         reused raw temp plus three shift destinations.  The form is
             fx = (signed char)...forward[0]; fx++; fx--; fx >>= 1;
         -- i.e. the SAME `t++; t--;` net-zero merge blocker as before, but applied
         to the DESTINATION SHORT rather than to an int carrier, with the shift
         written as the in-place `>>=`.  MIPS PROMOTE_MODE keeps a short pseudo
         sign-extended in its SImode register, so `fx >>= 1` needs no re-extension
         and emits retail's bare `sra $sN,$sN,1`; the four ex-diff insns and their
         interleave (`lb s4,15; lb s3,16; sra s4; sh s4; lb s2,17; sra s3; sh s3;
         lb a1,18; sra s2`) now match 1:1.
         THE DISCRIMINATOR that found it: the no-temp form WITHOUT any blocker
         (`fx = (signed char)X; fx >>= 1;`) already reproduces retail's registers,
         order and interleave EXACTLY and gates 23 -- but at 271, three insns over,
         because combine re-merges the sign-extend into `lbu; sll 24; sra 25` once
         per axis.  A residual that is +N insns of ONE repeated 3-insn-vs-2-insn
         idiom with everything else positionally exact is a MERGE question, not an
         allocation one: price the blocker, not the pseudo graph.
         Measured on the no-temp form (all reverted except the winner):
           no blocker, `fx >>= 1` ................................ 23 @271
           no blocker, `fx = (u_short)((short)fx >> 1)` .......... 23 @271
           no blocker, loads grouped then shifts grouped ......... 23 @271
           no blocker, software-pipelined ....................... 23 @271
           `fx |= zeroShort;` runtime-zero blocker ............... 23 @271 (folded)
           opacity launder `__asm__("":"=r"(fx):"0"(fx))` ....... 140 @290 (an asm
                 operand on a `short` is NOT zero-insn -- +22 here, the same
                 +2-per-site the w70 SubdividFacet fence walk measured)
           read-only fence `__asm__("":: "r"(fx))` .............. 93 @285
           `fx++; fx--;` ......................................... 8 @268  <- LANDED
           `fx++; fx--;` + the explicit (u_short)((short)fx>>1) ... 8 @268 (identical)
         AND the whole three-temp family that four waves priced is now moot; for
         the record it was re-priced once more at the 28-basin before the no-temp
         form was found (three int temps with in-place `>>=`, in three statement
         orders, and with an opacity launder substituted for ++/--: all 40 @268;
         two temps 152 @266; one temp with in-place `>>=` 184 @266).  TWO
         independent merge blockers giving the SAME 40 for every 3-pseudo spelling
         was the tell that the pseudo graph was not the axis.
     RESIDUAL 8 = (ii) alone: the three loop-preheader cursor slots.  Re-confirmed
     inert this wave: the for-comma init `for (i = 1, kk = C; ...)`, `kk` assigned
     after the `do`, and `i = 1` lifted out of the block with `int kk = C` inside
     all gate 8 @268. */
  {
    fx = (signed char)BWorldSm_slices[slice].forward[0]; fx++; fx--; fx >>= 1;
    fy = (signed char)BWorldSm_slices[slice].forward[1]; fy++; fy--; fy >>= 1;
    fz = (signed char)BWorldSm_slices[slice].forward[2]; fz++; fz--; fz >>= 1;
  }
  sx = (u_short)(fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[slice].right[0] << 9) >> 10);
  sy = (u_short)(fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[slice].right[1] << 9) >> 10);
  sz = (short)(fixedmult(gSpikeBeltX,(int)(signed char)BWorldSm_slices[slice].right[2] << 9) >> 10);
  vertex3d[0].x = sx - fx;
  vertex3d[0].y = sy - fy;
  vertex3d[0].z = sz - fz;
  vertex3d[0].light = 0;
  /* MATCH (w75-a5, 30 -> 28 with the two siblings below): the loop's byte
     cursor must be initialised AFTER `i`, not before.  Retail emits the three
     preheader constants in the order i / base-giv / dest-giv / cursor; the
     `int kk = C;` DECLARATION-INITIALISER puts the cursor's store first (it is
     the block's first statement), which is 21B(3) appearance order.  Splitting
     the declaration from the assignment moves it behind `i = 1` at zero insns.
     (An explicit base pointer/int local to push it behind the two loop.c givs
     as well costs +2 insns -- 270 -- so the remaining cursor slot is a real
     residual, not this dial.) */
  /* ==== W76-A5 (2026-08-23): 8 -> PASS 268/268, DEVICE-FREE. ====
     RESIDUAL (ii) CLOSED -- the three preheader cursor slots.  Retail's byte
     cursors are LOOP.C-EMITTED GIV INITS (chain-after the hoisted &vertex3d
     movable), not entry-block source statements; no source position of an
     explicit `kk` biv can reach that slot (every W75 falsification stands).
     THE SPELLING: name the BARE OFFSET as its own int giv, `so = (i << 3) + K;
     p = (CCOORD16 *)((int)vertex3d + so);` -- loop.c strength-reduces `so` and
     emits `li $aN,K+8` in the preheader BEHIND `addiu $t0,$sp,16`.
     WHY IT DOES NOT LOSE AN INSN (the w61/W76 giv-merge trap): combine_givs_p
     (gcc-2.8.1 loop.c:5647-5674) merges two givs only when (a) identical
     mult+add, or (b) g2 is DEST_ADDR and express_from(g1,g2) is a VALID
     memory address.  With the sp-relative base folded INTO the giv (the w61
     `vertex3d[i+8]` index form, or `(i<<3)+(int)vertex3d+K` in one expression
     -- measured 265/-1 per loop this wave) the two cursors differ by a
     CONSTANT -> express_from = reg+8 = valid address -> merged.  With the BARE
     offset named, express_from yields a 3-term sp-based expression ->
     memory_address_p fails -> BOTH cursors survive, exactly retail's pair.
     Loops 2/3 additionally need the DEST offset as its own explicit giv `dof`
     DEFINED BEFORE `so` (giv discovery order = body insn order; the reduced
     regs hand out a3=src/a2=dst only in this order -- `so` first swaps the
     pair, 44 diffs) with the address adds written p-then-q.  Loop 1 keeps its
     ARRAY_REF dest (retail walks the dest pointer there: addiu $a0,$sp,24).
     Measured this wave (probe TU, all @268/268 unless noted): explicit-kk
     baseline 8 - named base `int b`/`CCOORD16 *b` rerouted through the body
     +1 insn per loop (17/18 @269/270) - ARRAY_REF giv form 15-75 @265 (merge,
     -1/loop) - bare-offset giv loop1 only 6 - two-giv ds loops2+3 + loop1
     PASS - two-giv sd (so first) 44.  */
  { int so;
  i = 1;
  do {
    CCOORD16 *p;
    so = (i << 3) - 8;
    p = (CCOORD16 *)((int)vertex3d + so);
    vertex3d[i].x = *(u_short *)&p->x + wx;
    vertex3d[i].y = *(u_short *)&p->y + wy;
    vertex3d[i].z = *(u_short *)&p->z + wz;
    vertex3d[i].light = 0;
    i++;
  } while (i < 9); }
  vertex3d[9].x = sx;
  vertex3d[9].y = sy + 0x19;
  vertex3d[9].z = sz;
  vertex3d[9].light = 0;
  { int so; int dof;
  i = 1;
  do {
    CCOORD16 *p; CCOORD16 *q;
    dof = (i << 3) + 0x48;
    so = (i << 3) + 0x40;
    p = (CCOORD16 *)((int)vertex3d + so);
    q = (CCOORD16 *)((int)vertex3d + dof);
    q->x = *(u_short *)&p->x + wx;
    q->y = *(u_short *)&p->y + wy;
    q->z = *(u_short *)&p->z + wz;
    q->light = 0;
    i++;
  } while (i < 9); }
  vertex3d[18].x = sx + fx;
  vertex3d[18].y = sy + fy;
  vertex3d[18].z = sz + fz;
  vertex3d[18].light = 0;
  { int so; int dof;
  i = 1;
  do {
    CCOORD16 *p; CCOORD16 *q;
    dof = (i << 3) + 0x90;
    so = (i << 3) + 0x88;
    p = (CCOORD16 *)((int)vertex3d + so);
    q = (CCOORD16 *)((int)vertex3d + dof);
    q->x = *(u_short *)&p->x + wx;
    q->y = *(u_short *)&p->y + wy;
    q->z = *(u_short *)&p->z + wz;
    q->light = 0;
    i++;
  } while (i < 9); }
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
    ((Draw_tGiveShelbyMoreCache *)sd)->nightFlags = 0;
    /* MATCH (w74-a1, 46 -> 30 count-exact): retail loads the SUBTRAHEND
       (the view translation) BEFORE the minuend at every axis --
       `lw $t4,456(sp); lw $t3,408(sp); lw $v1,8($t4); lw $v0,0($t3)`.
       ONE REUSED block temp for the subtrahend gives that order (three
       separate temps 44, a `coorddef *vt` pointer local 51 @269).
       Same one-reused-pseudo identity as the fx/fy/fz trio above. */
    { int vt;
    vt = (Vi->cview).translation.x;
    tmp.x = cp->x - vt;
    vt = (Vi->cview).translation.y;
    tmp.y = cp->y - vt;
    vt = (Vi->cview).translation.z;
    tmp.z = cp->z - vt; }
    transform(&tmp.x,gWorldMat.m,&tmp2.x);
    DrawW_WorldSetUpTranslation(&tmp2,&sd->matB);
    ((Draw_tGiveShelbyMoreCache *)sd)->vertices = vertex3d;
    ((Draw_tGiveShelbyMoreCache *)sd)->quadCount = 0x10;
    ((Draw_tGiveShelbyMoreCache *)sd)->quads = quads;
    ((Draw_tGiveShelbyMoreCache *)sd)->offset = 0x23;
    ((Draw_tGiveShelbyMoreCache *)sd)->materials = &material;
    *(int *)&((Draw_tGiveShelbyMoreCache *)sd)->trans = 0;
    ((Draw_tGiveShelbyMoreCache *)sd)->trans.z = 0;
    ((Draw_tGiveShelbyMoreCache *)sd)->zeroGTETransFlag = 0;
    ((Draw_tGiveShelbyMoreCache *)sd)->light = -1;
    DrawW_kCtrlWorld_High((Draw_tGiveShelbyMoreCache *)sd);
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
