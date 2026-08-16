/* game/common/bworld.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "bworld_externs.h"

/* ---- bworld.obj anon file-statics (no SYM name; Ghidra DAT_; real .bss bytes = 0) ---- */
static void *gBWPrimPtr;    /* .sbss (no SYM .sdata record; not in the image window) */


/* ---- bworld.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
matrixtdef   gWorldMat;   /* @0x8010ee40  (bss(zero)) */
matrixtdef   gNightMat;   /* @0x8010ee64  (bss(zero)) */
matrixtdef   gCopMat;   /* @0x8010ee88  (bss(zero)) */
BW_tContextMgr gContextMan;   /* @0x8010eeac  (bss(zero)) */
int BWorld_gChunkBuildList[36];   /* @0x8010efec  (bss(zero)) */
int          SceneLoaded = 0;   /* @0x8013c758  W67-A4: explicit =0 -- retail emits this
    cell FIRST in bworld.obj's .sdata run, before the fn-local statics and the -G8
    literal pool, so it cannot have been tentative (16E =0 discriminator).
    DO NOT strip the =0. */
BW_tContext  *gCurrContext;   /* @0x8013c790  (bss(zero)) */
int          gSpikeBelt;   /* @0x8013c794  (bss(zero)) */
int          gSpikeBeltSlice;   /* @0x8013c798  (bss(zero)) */
int          gSpikeBeltChunk;   /* @0x8013c79c  (bss(zero)) */
int          gSpikeBeltX;   /* @0x8013c7a0  (bss(zero)) */
int          gBWSlice;   /* @0x8013c7a4  (bss(zero)) */
int          BWorld_gChunkCount;   /* @0x8013c7a8  (bss(zero)) */
int          gSpikeBeltWidth;   /* @0x8013c7ac  (bss(zero)) */
int          gSpikeBeltColourTableIndex;   /* @0x8013c7b0  (bss(zero)) */
Car_tObj     *BW_gCopCarObj;   /* @0x8013c7b4  (bss(zero)) */
DRender_tView *gVi2;   /* @0x8013c7b8  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
int xzsquaredist32(coorddef *c1,coorddef *c2);
void UpdateContext(DRender_tView *Vi,int contextHandle);
void BWorld_BuildGlareEffects(DRender_tView *Vi,Draw_DCache *sd,Group *group);
void BWorld_InitSpikeBelt(void);
void BWorld_SetSpikeBelt(int slice,int x,int width);
int BWorld_GetSpikeBelt(int *slice,int *x,int *width);
void SetupBuildMatrices(DRender_tView *Vi,Draw_DCache *sd);
int BWorld_CheckChunkVisible(BWorldSm_Pos *slicePosSource,BWorldSm_Pos *slicePosTest);
int GetRezIndex(int dist);
int SetupChunkBuildList(DRender_tView *Vi);
void * BWorld_IsSliceInBuildList(int slice);
void BWorld_OnyxBuildFacets(DRender_tView *Vi);
char * BWAllocMem(long size);
void BWorld_InitContexts(void);
void BWorld_DeInitContexts(void);
void SetContext(int contextHandle);
int BWorld_OpenContext(int contextType,int client);
void BWorld_Restart(void);
void BWorld_StartLoop(void);
void BWorld_Init(void);


/* ---- xzsquaredist32__FP8coorddefT0  [@0x8007d5c4] ---- */
int xzsquaredist32(coorddef *c1,coorddef *c2)
{
  int iVar1;
  int iVar2;
  
  iVar1 = c2->x - c1->x >> 0xc;
  iVar2 = c2->z - c1->z >> 0xc;
  return (iVar1 * iVar1 >> 6) + (iVar2 * iVar2 >> 6);
}

/* ---- UpdateContext__FP13DRender_tViewi  [@0x8007d608] ---- */
void UpdateContext(DRender_tView *Vi,int contextHandle)
{
  u_int uVar1;
  DRender_tCalcView *pt;

  SetContext(contextHandle);
  if (contextHandle == 0) {
    pt = &Vi->cview;
    gBWSlice = (int)(gCurrContext->slicePos).slice;
  }
  else {
    pt = &Vi->cview;
  }
  BWorldSm_FindClosestQuadRez(&pt->translation,&gCurrContext->slicePos,1);
  if ((signed char)(gCurrContext->slicePos).offEdge != '\0') {
    FindAbsClosestSliceCrude(&pt->translation,&gCurrContext->slicePos);
    BWorldSm_FindClosestQuadRez(&pt->translation,&gCurrContext->slicePos,1);
  }
  uVar1 = (u_int)(gCurrContext->slicePos).chunk;
  if (gCurrContext->currentChunk != uVar1) {
    gCurrContext->currentChunk = uVar1;
  }
  return;
}

/* ---- BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group  [@0x8007d6c0] ---- */
void BWorld_BuildGlareEffects(DRender_tView *Vi,Draw_DCache *sd,Group *group)
{
  int i;
  int j;
  Trk_SFX *objInstance;
  int numObjects;

  i = 0;
  objInstance = (Trk_SFX *)(group + 1);
  numObjects = group->m_num_elements;
  while (i < numObjects) {
    u_short type;
    short pad;

    pad = objInstance[i].pad;
    type = (u_short)objInstance[i].type;
    if (objInstance[i].type == 100) {
      coorddef dir = {0, 0xa0000, 0};

      TrgSfx_AddEnviroEffect(i, 0x101,
                             (coorddef *)&objInstance[i], &dir);
      return;
    }
    if (pad != 0) {
      int found_match;
      int group;

      found_match = 0;
      group = pad & 0x7fff;
      for (j = 0; j < numObjects; j++) {
        coorddef *pt1;

        pt1 = (coorddef *)&objInstance[j];
        if (group == (objInstance[j].pad & 0x7fff)) {
          found_match = 1;
          break;
        }
      }
      if ((found_match != 0) && (pad < 0)) {
        Flare_Halo2(Vi, -1, (short)type,
                    (coorddef *)&objInstance[i],
                    (coorddef *)&objInstance[j], (Draw_FlareCache *)sd);
      }
    }
    else {
      Flare_Halo(Vi, -1, (short)type,
                 (coorddef *)&objInstance[i], (Draw_FlareCache *)sd);
    }
    i++;
  }
}

/* ---- BWorld_InitSpikeBelt__Fv  [@0x8007d818] ---- */
void BWorld_InitSpikeBelt(void)
{
  int leastDist;
  int leastDistInd;
  int i;

  leastDist = 0x7fffffff;
  leastDistInd = -1;
  gSpikeBelt = 0;
  gSpikeBeltSlice = 0;
  gSpikeBeltChunk = 0;
  for (i = 0; i < Chunk_numLight; i = i + 1) {
    int dist;
    int r;
    int g;
    int b;

    r = 0x80 - (u_int)Chunk_lightTable[i].r;
    g = 0x80 - (u_int)Chunk_lightTable[i].g;
    b = 0x80 - (u_int)Chunk_lightTable[i].b;
    dist = r * r + g * g + b * b;
    if (dist < leastDist) {
      leastDist = dist;
      leastDistInd = i;
    }
  }
  gSpikeBeltColourTableIndex = leastDistInd;
}

/* ---- BWorld_SetSpikeBelt__Fiii  [@0x8007d8c4] ---- */
void BWorld_SetSpikeBelt(int slice,int x,int width)
{
  gSpikeBelt = 1;
  gSpikeBeltSlice = slice;
  gSpikeBeltChunk = (u_int)*(u_char *)((char *)BWorldSm_slices + slice * 0x20 + 0x1c);
  gSpikeBeltWidth = width;
  gSpikeBeltX = x;
  return;
}

/* ---- BWorld_GetSpikeBelt__FPiN20  [@0x8007d8f8] ---- */
int BWorld_GetSpikeBelt(int *slice,int *x,int *width)
{
  if (gSpikeBelt == 1) {
    *slice = gSpikeBeltSlice;
    *x = gSpikeBeltX;
    *width = gSpikeBeltWidth;
    return 1;
  }
  *width = 0;
  *x = 0;
  *slice = 0;
  return 0;
}

/* ---- SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache  [@0x8007d940] ---- */
/* HISTORICAL ROUND: 94 diffs (179/181 insns), reduced from a baseline of 147 diffs (170/181 insns).
 * 🔴 THREE REAL BUGS FIXED (not just byte-match issues):
 * (1) `gNightMat.m[1]/[7]/[4] = 0` and the identical `gCopMat.m[1]/[7]/[4] = 0` were
 *     ZEROING these matrix elements, but the oracle NEGATES the existing value in
 *     place (`lw;negu;sw`) -- confirmed by the compiled `sw zero,N(a0)` vs the
 *     oracle's `lw v0,N(a0)/negu v0,v0/sw v0,N(a0)`. Same pattern as `gWorldMat`'s
 *     already-correct `m[1]=-m[1]` a few lines above (which this function ALSO sets
 *     up) -- gNightMat/gCopMat had regressed to the zero-fill at some point. Fixed to
 *     `gNightMat.m[N] = -gNightMat.m[N]` / `gCopMat.m[N] = -gCopMat.m[N]`.
 * (2) The cop-car search loop's `iVar5<0` branch read a hardcoded NULL
 *     (`pCVar4=(Car_tObj*)0x0`), but the oracle's fall-through for that branch does
 *     `lw a2,%lo(Cars_gList)(t4)` = `Cars_gList[0]` -- a REAL car pointer, not NULL.
 *     Fixed to `pCVar4 = Cars_gList[0];` (added `Cars_gList` extern to
 *     bworld_externs.h). This changed the very first loop iteration (iVar5==-1) from
 *     "always skip (NULL deref would crash / active-flag check would read garbage)"
 *     to "check the first car in Cars_gList", a real behavior difference.
 * (3) The loop's per-iteration pointer walk used `Cars_gTrafficCarList + 8`, which
 *     happens to be the SAME real address as the oracle's `Cars_gCopCarList - 4`
 *     (0x8010FA90+32 == 0x8010FAB4-4 == 0x8010FAB0) -- functionally identical at
 *     runtime, but expressed via a different symbol than the oracle uses, which
 *     blocks gcc from recognizing it and produces different address-materialization
 *     instructions. Fixed to `Cars_gCopCarList - 1` (added the extern) to match the
 *     oracle's actual symbol reference.
 * ALSO: removed 9 dead locals (t1/t2/t3/tm/i/maxdist/theCar/campos/dx/dz/diff/rotY/
 * cop_angle -- two of them whole unused `matrixtdef` [36 bytes each]) left over from
 * an earlier refactor; this alone dropped the stack frame from -192(sp) to the
 * oracle's exact -112(sp) and got insn count from 170 (under oracle's 181) to 181
 * (dead-on), before any further edits.
 * STRUCTURAL LEVER: the gWorldMat row-copy (`m[0..8] = mrotationInv.m[0..8]` with the
 * middle element of each row of 3 negated) needed explicit per-row temp locals
 * (iVar1/iVar3/iVar5, load all 3 then store all 3) to reproduce the oracle's
 * load-3-then-store-3 burst shape -- writing the 9 assignments directly (even in the
 * correct 0,1,2,3,4,5,6,7,8 order) left gcc doing them one at a time instead.
 * REMAINING 94 diffs are register-coloring only on an otherwise instruction-for-
 * instruction-aligned body (confirmed via SequenceMatcher: every hunk is the same
 * value in a differently-named register, e.g. oracle's v0/a1 vs ours a1/a3 for the
 * negate-target slot) -- tried swapping which named local holds the to-be-negated
 * value in each row (regressed to 112 diffs) and the same explicit-locals lever on
 * gNightMat's m[1]/m[7]/m[4] negation (regressed to 152 diffs, reverted both). Same
 * floor class as BWorld_OpenContext/BWorld_CheckChunkVisible above. ACCEPT (with the
 * three real bugs fixed). */
/* CURRENT: 16 diffs with exact 181/181 instruction parity (90 diffs at the
 * start of this round).  The SLD trace recovers the retail scopes and names:
 * tm@sp+16, rotY@sp+56, i=$a3, maxdist=$t1, theCar=$a2, plus the scoped
 * campos/dx/dz/diff locals.  `__builtin_abs` is required for the oracle's two
 * `bgez; nop; negu` sequences; hand-written abs lets GCC fill both delay slots.
 * The only residual is the same scheduling/coloring tie repeated for gNightMat
 * and gCopMat: ours processes m[4] before m[7], retail m[7] before m[4].  Direct
 * assignments, reordered locals/definitions, aliasing and volatile-load probes
 * were neutral; disabling sched2 regressed to 38 diffs. */
void SetupBuildMatrices(DRender_tView *Vi,Draw_DCache *sd)
{
  if ((Vi->id == Draw_gPlayer1View) || (Vi->id == Draw_gPlayer2View)) {
    UpdateContext(Vi,Vi->player);
  }
  else {
    UpdateContext(Vi,1);
  }
  {
    int t1;
    int t2;
    int t3;

    t1 = (Vi->cview).mrotationInv.m[0];
    t2 = (Vi->cview).mrotationInv.m[1];
    t3 = (Vi->cview).mrotationInv.m[2];
    gWorldMat.m[0] = t1;
    gWorldMat.m[1] = -t2;
    gWorldMat.m[2] = t3;
    t1 = (Vi->cview).mrotationInv.m[3];
    t2 = (Vi->cview).mrotationInv.m[4];
    t3 = (Vi->cview).mrotationInv.m[5];
    gWorldMat.m[3] = t1;
    gWorldMat.m[4] = -t2;
    gWorldMat.m[5] = t3;
    t1 = (Vi->cview).mrotationInv.m[6];
    t2 = (Vi->cview).mrotationInv.m[7];
    t3 = (Vi->cview).mrotationInv.m[8];
    gWorldMat.m[6] = t1;
    gWorldMat.m[7] = -t2;
    gWorldMat.m[8] = t3;
  }
  if (gNight_renderNight != 0) {
    matrixtdef tm;
    int i;
    int maxdist;

    transpose(&(Camera_gInfo[Vi->player].target)->orientMat,&gNightMat);
    {
      int t1;
      int t2;
      int t3;

      /* MATCH: retail negates m[7] through the FIRST temp and m[4] through the second
         (oracle 8007DA44 `lw v1,28` before `lw v0,16`); the 4-then-7 order emits the
         loads/stores the other way round. */
      t1 = gNightMat.m[1];
      t3 = gNightMat.m[4];
      gNightMat.m[1] = -t1;
      t2 = gNightMat.m[7];
      gNightMat.m[4] = -t3;
      gNightMat.m[7] = -t2;
    }
    DrawW_WorldSetUpMatrix(&gNightMat,&sd->matNight);
    BW_gCopCarObj = (Car_tObj *)0x0;
    maxdist = 0xb40000;
    if (GameSetup_gData.commMode != 1) {
      for (i = -1; i < Cars_gNumCopCars; i = i + 1) {
        Car_tObj *theCar;

        if (i < 0) {
          theCar = Cars_gList[0];
        }
        else {
          theCar = Cars_gCopCarList[i];
        }
        if ((((theCar->N).active != '\0') && ((theCar->AIFlags & 2U) != 0)) &&
           (((theCar->render).damageParts & 4U) == 0)) {
          coorddef *campos = &(Vi->cview).translation;
          int dx;
          int dz;
          int diff;

          dx = (theCar->N).position.x - campos->x;
          dz = (theCar->N).position.z - campos->z;
          dx = __builtin_abs(dx);
          dz = __builtin_abs(dz);
          if (dz < dx) {
            diff = dx + (dz >> 2);
          }
          else {
            diff = dz + (dx >> 2);
          }
          if (diff < maxdist) {
            maxdist = diff;
            BW_gCopCarObj = theCar;
          }
        }
      }
      if (BW_gCopCarObj != (Car_tObj *)0x0) {
        matrixtdef rotY;
        static int cop_angle = 0;   /* @0x8013c75c  W67-A4: =0 puts this (unused,
            SYM-attested) fn-local static into .sdata at its retail position;
            uninitialised it lands in .sbss.  Zero codegen impact (no refs). */

        Night_SetCopColor(BW_gCopCarObj->carInfo);
        gBWPrimPtr = (void *)((int)gBWPrimPtr + 0x40);
        xformy(&rotY,gBWPrimPtr);
        transpose(&(BW_gCopCarObj->N).orientMat,&tm);
        Math_fasttransmult(&tm,&rotY,&gCopMat);
        {
          int t1;
          int t2;
          int t3;

          /* MATCH: retail negates m[7] through the FIRST temp and m[4] through the second
             (oracle 8007DA44 `lw v1,28` before `lw v0,16`); the 4-then-7 order emits the
             loads/stores the other way round. */
          t1 = gCopMat.m[1];
          t3 = gCopMat.m[4];
          gCopMat.m[1] = -t1;
          t2 = gCopMat.m[7];
          gCopMat.m[4] = -t3;
          gCopMat.m[7] = -t2;
        }
        DrawW_WorldSetUpMatrix(&gCopMat,&sd->matCop);
      }
    }
  }
  return;
}

/* ---- BWorld_CheckChunkVisible__FP12BWorldSm_PosT0  [@0x8007dc14] ---- */
/* HISTORICAL NOTES (resolved; function now PASSes at 80/80 instructions).
 * 🔴 REAL BUG FIXED (not just a byte-match issue): the two `chunkIndex` lookups were
 * written as `*(u_char*)((int)BWorldSm_slices + idx*0x20 + 0x1c)` with NO cast to a byte
 * pointer before the `idx*0x20` add. Since (int)BWorldSm_slices is `Trk_NewSlice*` (32
 * bytes/elem), that pointer-arithmetic add scales by sizeof(Trk_NewSlice) AGAIN, so
 * the real byte offset was idx*0x20*0x20 = idx*1024, not idx*32 as intended --
 * confirmed by the compiled `sll $,$,10` (x1024) where the oracle has `sll $,$,5`
 * (x32). Fixed by using `BWorldSm_slices[idx].chunkIndex` (real field, offset 0x1C,
 * matches `struct Trk_NewSlice` in nfs4_types.h) -- lets the type system scale
 * correctly and confirmed the compiled shift is now `sll $,$,5`. This was silently
 * reading garbage 1000+ bytes past the intended slice record on every call.
 * (BWorld_SetSpikeBelt's near-identical line already had an explicit `(char*)` cast
 * and was NOT affected -- confirmed separately, still PASS.)
 * STRUCTURAL FIX: also hoisted both chunkIndex lookups out of the search loop's `if`
 * conditions into named locals (chunkIndFwd/chunkIndBwd) computed once before the
 * loop, each resolved via its own wrap/no-wrap if/else -- this matches the oracle's
 * shape (two independent address-then-lbu blocks before the loop) far better than a
 * shared post-branch lookup, and got insn count from 66 (well under oracle's 80) up
 * to 74 (much closer).
 * REMAINING GAP is a branch-polarity/scheduling floor: gcc-2.8.0 -O2 picks the
 * OPPOSITE branch as fall-through for the `testChunkIndFwd < gNumSlices` test
 * (`bnez`+skip-to-else in ours vs the oracle's `beqz`+jump-to-wrap), independent of
 * how the equivalent logic is phrased in source -- confirmed by testing if/else
 * block order, explicit goto-based control flow matching the oracle's literal
 * label targets, and both orderings of the bwd if/else; all four produced BYTE-
 * IDENTICAL codegen to each other (same 106 diffs), confirming this is a pure
 * compiler tie-break, not a source-shape lever. Some downstream reg-coloring
 * (e.g. `lh a1,0(a1)` position, add-then-subtract operand order in the bwd-wrap
 * computation) rides on this same root cause. Same floor class as
 * BWorld_OpenContext/BWorld_InitSpikeBelt above. ACCEPT (with the real bug fixed). */
/* PASS: ternary-selected slice pointers, packed byte counts, flat 32-short rows,
 * and a separate count-- reproduce the retail source and allocation shape. */
int BWorld_CheckChunkVisible(BWorldSm_Pos *slicePosSource,BWorldSm_Pos *slicePosTest)
{
  int sourceChunkInd;
  int testChunkIndFwd;
  int testChunkIndBwd;
  int chunkIndFwd;
  int chunkIndBwd;
  Trk_NewSlice *sliceFwd;
  Trk_NewSlice *sliceBwd;
  short *chunkViewList;
  int chunkInd;
  int count;
  int vis;

  if (slicePosSource == slicePosTest) {
    return 1;
  }
  testChunkIndFwd = slicePosTest->slice + 2;
  sliceFwd = testChunkIndFwd < gNumSlices
                 ? BWorldSm_slices + testChunkIndFwd
                 : BWorldSm_slices +
                       ((int)slicePosTest->slice - (gNumSlices + -2));
  chunkIndFwd = (u_short)sliceFwd->chunkIndex;
  testChunkIndBwd = slicePosTest->slice + -2;
  sliceBwd = testChunkIndBwd >= 0
                 ? BWorldSm_slices + testChunkIndBwd
                 : BWorldSm_slices +
                       ((int)slicePosTest->slice + (gNumSlices + -2));
  chunkIndBwd = (u_short)sliceBwd->chunkIndex;
  sourceChunkInd = slicePosSource->chunk;
  count = ((u_char *)Track_gInViewCount)[sourceChunkInd];
  chunkViewList = (short *)Track_gInViewList + sourceChunkInd * 32;
  count--;
  vis = 0;
  if (count != -1) {
    do {
      chunkInd = chunkViewList[count];
      if ((chunkInd & 0x3ff) == chunkIndFwd) {
        if ((chunkInd & 0x800) != 0) goto visible_check;
        vis++;
        if (vis != 1) goto visible_check;
      }
      if ((chunkInd & 0x3ff) == chunkIndBwd) {
        if ((chunkInd & 0x800) != 0) goto visible_check;
        vis++;
        if (vis != 1) goto visible_check;
      }
      count--;
    } while (count != -1);
  }
visible_check:
  return (u_int)((vis ^ 2) == 0);
}

/* ---- GetRezIndex__Fi  [@0x8007dd54] ---- */
int GetRezIndex(int dist)
{
  return (gCurrContext->lowDetailDistSq < dist ^ 1) << 2;
}

/* ---- SetupChunkBuildList__FP13DRender_tView  [@0x8007dd74] ---- */
/* NEAR-MISS 7 diffs (202/203 insns), reduced from 273 diffs. JEB recovered
 * the high-level loop while the SLD scopes/locals and IDA register annotations
 * established the 144-byte frame and saved-register allocation. Track_gInViewList
 * is stored as one flat 32-short row table despite its historical short ** type;
 * the row cast removes a spurious pointer load. Typed Trk_NewSlice indexing and
 * the source-order `-view + point` coordinate expressions reproduce retail's
 * address generation and load scheduling. The remaining gap is confined to two
 * prologue scheduling choices (one temporary register and one load-delay nop). */
int SetupChunkBuildList(DRender_tView *Vi)
{
  int chunkInd;
  int chunkCount;
  int totalVisChunks;
  volatile tBuildEntry *buildList;

  buildList = (volatile tBuildEntry *)BWorld_gChunkBuildList;
  {
    int viewInd;
    short *viewList;

    /* NEAR-MISS 7 (ours 202 / oracle 203) -- W61-A13 2026-08-15.  The residual is
       ONE scheduling decision plus its %hi-scratch shadow.  Retail emits
           sll a0,a1,6 ; addu s3,v1,a0 ; addu v0,v0,a1 ; lbu v0,0(v0) ; nop
       ours
           sll a0,a1,6 ; addu v0,v0,a1 ; lbu v0,0(v0) ; addu s3,v1,a0
       i.e. we SINK the viewList address computation into the `lbu`'s load-delay
       slot (so no nop is needed -> we are exactly 1 insn short), and that in turn
       flips the %hi scratch of BWorld_gChunkBuildList from retail's $v1 to $v0.
       FALSIFIED (each a real gate run, all 7 diffs / 202-203 unless noted):
         index-term-first cast subscript
           `(short *)((currentChunk << 6) + (int)Track_gInViewList)` ..... 7
         base-first cast subscript ..................................... 7
         statement order swapped (InViewCount first, InViewList second) . 7
         swapped + index-term-first .................................... 7
         void-tail fence between the two statements .................... 33
         read-only fence on viewList ................................... 33
         void-tail fence after both statements ......................... 15
         void-tail fence before both statements ........................ 27
       Note the fences never change the COUNT (202 in every case): they do not
       stop the sink, they only re-color.  So the sink is not a sched2 barrier
       question -- next angle is -dS/-dR on this TU to see which pass moves the
       addu below the lbu.

       W64-A15 2026-08-15 -- THE PASS IS NAMED, and the mechanism is quantified.
       A raw CC1PLPSX A/B (scratchpad/w64a15/cc1probe.py, -O2 -G4 -fno-exceptions
       -fno-rtti) shows the sink is entirely SCHED2:
         default            sll ; addu $2,$2,$5 ; lbu ; addu $19,$3,$4 ; sw
         -fno-schedule-insns2  sll ; addu $19,$3,$4 ; addu $2,$2,$5 ; lbu ; #nop ; sw
       i.e. the pre-sched2 order ALREADY has retail's order and cc1 itself marks
       the un-fillable load-delay slot (`#nop`).  sched2 then swaps them because
       `addu $19` is the only insn ready at the lbu's stall cycle.
       WHY it is only reachable through priority, not through a barrier:
       INSN_PRIORITY in sched2 is the dependency-chain length inside the block --
       addu $2 -> lbu -> sw = 3, while addu $19 (viewList's biv init, live-out
       into the loop) has NO dependent in the block = 0.  And the LAUNCH_PRIORITY
       boost cannot help: sched.c:2499 `birthing_insn_p` returns 0 outright once
       `reload_completed`, so sched2 has no boost at all.  That is exactly why
       every fence flavour/position re-colors without moving the count -- a
       barrier does not change a priority.
       ALSO FALSIFIED this wave (each a real gate run):
         named `int cc = gCurrContext->currentChunk;` local ................ 7 @202
         same + statement order swapped ................................... 7 @202
         count as an unsized u_char[] subscript ........................... 7 @202
         viewList via `(cc << 6) + (int)Track_gInViewList` ................ 7 @202
         count address split into its own pointer local ................... 7 @202
         ... + opacity fence on that pointer ............................. 13 @202
         identity fence on viewList (between statements) ................. 33 @202
         read-only fence on viewList (between statements) ................ 33 @202
         identity fence on viewList AFTER the count statement ............ 15 @202
         read-only fence on (viewList, totalVisChunks) after both ........ 15 @202
         WHOLE-TU no_schedule_insns2 (vprobe W60_TU_FLAGS) ............... 44 @205
       The `volatile u_char` read is still the ONLY count-exact form (18 @203):
       it wins by ADDING an insn (the VOLATILE-QImode `andi v0,v0,255`, which
       cannot fuse into the lbu), not by stopping the sink -- and it costs the
       early Track_gInViewList materialization as well.  So it is not the basin.
       NEXT ANGLE (named, instrument): give `addu $19` a real dependent chain of
       length >= 3 inside this block at zero bytes, or read the -dR sched2 ready
       list (tools/rtl_dump.py) to find a cheaper priority edge.  NOT a floor.

       W69 2026-08-16 -- THAT NAMED ANGLE WAS WALKED AND IS FALSIFIED.  The
       candidate zero-byte chain builder is the W69 device (the NON-VOLATILE
       identity launder `asm("" : "=r"(x) : "0"(y))`, which seals StatusReply in
       speech.cpp): N launders chained off `viewList` should give `addu $19` an
       in-block dependent chain of length N without emitting anything.  Gated:
         depth 1 ....... 33 diffs @202   (re-colors, sink unchanged)
         depth 2 ....... 35 diffs @204   depth 3 ... 35 @204   depth 4 ... 35 @204
       THE CHAIN IS NOT FREE past depth 1: from the second launder on, the
       matching-"0" tie can no longer be coalesced away and each link costs a
       real `addu` (+2 insns at depth 2 and it does not grow further), so the
       device cannot buy priority at zero bytes.  The sched2-priority route
       therefore needs a dependent that the SOURCE genuinely has (a real use of
       viewList inside this block), not a synthetic one -- or the reload/ready-
       list instrument.  Still NOT a floor; the axis is just narrower. */
    viewList =
        ((short (*)[32])Track_gInViewList)[gCurrContext->currentChunk];
    totalVisChunks =
        (int)*(u_char *)((char *)Track_gInViewCount +
                         gCurrContext->currentChunk);
    chunkCount = 0;
    viewInd = chunkCount;
    for (; viewInd < totalVisChunks; viewInd++) {
      int chunkDist;
      coorddef *pChunkCp;
      Chunk *chunkPtr;
      coorddef tmpPts[4];
      coorddef tmp;
      coorddef tmp2;

      chunkInd = (u_short)*viewList & 0x3ff;
      pChunkCp = Chunk_chunkCenters + chunkInd;
      chunkDist = xzsquaredist32(pChunkCp,&Vi->cview.translation);
      if ((chunkDist <= gCurrContext->chunkFarZClipSq) &&
          ((*viewList & 0x800U) == 0)) {
        tmp.x = -Vi->cview.translation.x + pChunkCp->x;
        tmp.y = -Vi->cview.translation.y +
                BWorldSm_slices[chunkInd << 3].center[1];
        tmp.z = -Vi->cview.translation.z + pChunkCp->z;
        chunkPtr = Track_chunkList + chunkInd;
        TrsProj_SetPsxTransZero();
        TrsProj_TransPt(&tmp,&tmp2);
        TrsProj_SetPsxTrans(&tmp2);
        TrsProj_TransPtN16(chunkPtr->boundPts,tmpPts,4);
        if (((tmpPts[0].x <= tmpPts[0].z) ||
             (tmpPts[1].x <= tmpPts[1].z) ||
             (tmpPts[2].x <= tmpPts[2].z) ||
             (tmpPts[3].x <= tmpPts[3].z)) &&
            ((-tmpPts[0].x <= tmpPts[0].z) ||
             (-tmpPts[1].x <= tmpPts[1].z) ||
             (-tmpPts[2].x <= tmpPts[2].z) ||
             (-tmpPts[3].x <= tmpPts[3].z)) &&
            ((0 <= tmpPts[0].z) ||
             (0 <= tmpPts[1].z) ||
             (0 <= tmpPts[2].z) ||
             (0 <= tmpPts[3].z))) {
          buildList->enableBits = 3;
          if (chunkDist < gCurrContext->lineFarZClipSq) {
            buildList->enableBits = 7;
          }
          if ((*viewList & 0x4000U) != 0) {
            buildList->enableBits &= 0xfd;
          }
          if ((*viewList & 0x2000U) != 0) {
            buildList->enableBits &= 0xfe;
          }
          buildList->geomRez = (char)GetRezIndex(chunkDist);
          buildList->chunkInd = (short)chunkInd;
          buildList++;
          chunkCount++;
        }
      }
      viewList++;
    }
  }
  return chunkCount;
}

/* ---- BWorld_IsSliceInBuildList__Fi  [@0x8007e0a0] ---- */
/* PASS (21/21 insns). Was a 5-diff near-miss: oracle loads BWorld_gChunkCount into $v0 for the
 * `blez` test, copies it to $a2 in the branch delay slot (`addu a2,v0,zero`) for the loop bound;
 * a single cached/direct global read gave gcc only ONE "value" to allocate, which it put
 * straight into $a2 (no v0 stage, no copy). FIX: read the global TWICE textually -- once bare in
 * the `if (0 < BWorld_gChunkCount)` test (gcc allocates this transient test value to $v0) and
 * once more into a local `chunkCount` right after entering the block (gcc allocates this
 * long-lived loop-bound value to $a2, materialized via the delay-slot copy) -- semantically a
 * no-op re-read of the same never-mutated global, but it hands gcc's -O2 scheduler two distinct
 * materializations instead of one, reproducing the oracle's v0-then-a2 shape exactly. */
void * BWorld_IsSliceInBuildList(int slice)
{
  int *piVar1;
  int bi;
  int chunkCount;

  bi = 0;
  if (slice < 0) {
    slice = slice + 7;
  }
  slice = slice >> 3;
  if (0 < BWorld_gChunkCount) {
    chunkCount = BWorld_gChunkCount;
    piVar1 = BWorld_gChunkBuildList;
    do {
      bi = bi + 1;
      if ((int)(short)*piVar1 == slice) {
        return (void *)0x1;
      }
      piVar1 = piVar1 + 1;
    } while (bi < chunkCount);
  }
  return (void *)0x0;
}

/* ---- BWorld_OnyxBuildFacets__FP13DRender_tView  [@0x8007e0f4] ---- */
void BWorld_OnyxBuildFacets(DRender_tView *Vi)
{
  Draw_DCache *sd;
  CTrackSpec *ts;
  u_short fogStart;
  u_short fogDist;
  u_char fogState;
  int time;
  void *pvVar3;
  
  Chunk_UpdateSys(Vi);
  gVi2 = Vi;
  gWSavePtr = (u_long)SetSp((void *)0x1f8003fc);
  stackSpeedUpEnbabledFlag = 1;
  SetupBuildMatrices(gVi2,(Draw_DCache *)0x1f800000);
  DrawW_WorldSetUpMatrix(&gWorldMat,(MATRIX *)0x1f800014);
  BWorld_gChunkCount = SetupChunkBuildList(gVi2);
  sd = (Draw_DCache *)0x1f800000;
  gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
  /* @0x8007E17C-1F4: the Onyx scratchpad (Draw_tGiveShelbyMoreCache @0x1F800000) gets the fog + night
   * params. startfog/distfog@+0xDC/+0xDE come from TrackSpec_gSpec's INT fog fields read as HALFWORDS
   * (lhu) [the 0xDC/0xDE slots are also read back as Skid_gScratchPos1/2 in draww.cpp]; fogstate@+0x10E
   * from the fogstate short's low byte (lbu). Ghidra AND IDA both constant-fold TrackSpec_gSpec (BSS-zero)
   * to 0 here -- RAW oracle wins (methodology 3.2c). One 0x1F800000 base ($s2) is CSE'd across every
  * scratchpad store (base+displacement), NOT a per-store lui. */
  ts = &TrackSpec_gSpec;
  fogStart = *(u_short *)&ts->fogspec.start;
  fogDist = *(u_short *)&ts->fogspec.dist2base;
  fogState = (u_char)ts->fogstate;
  time = GameSetup_gData.Time;
  /* MATCH: 0-insn void-tail fence pins the flag store BELOW the four fog/time
     loads -- sched2 otherwise hoists it up to fill their load-delay slots
     (oracle 8007E1A4 sits after `lw a1,0x54(s0)`). Statement reorder alone is
     inert here (3 positions probed, all 4 diffs). */
  __asm__("" : : "i"(0));
  stackSpeedUpEnbabledFlag = 0;
  ((Draw_tGiveShelbyMoreCache *)sd)->startfog = fogStart;
  ((Draw_tGiveShelbyMoreCache *)sd)->distfog  = fogDist;
  ((Draw_tGiveShelbyMoreCache *)sd)->fogstate = fogState;
  if (time != 0) {
    short a;
    u_char ac;
    u_char bc;
    u_char cc;
    u_char dc;

    a = (short)Night_gZNear;
    ac = (u_char)Night_gXDistShift;
    bc = (u_char)Night_gZDistShift;
    cc = (u_char)Night_gDrawLightning;
    dc = (u_char)Night_gLightningType;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_ZNear = a;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_XDistShift = ac;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_ZDistShift = bc;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_DrawLightning = cc;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_LightningType = dc;
  }
  gWSavePtr = (u_long)SetSp((void *)0x1f8003fc);
  stackSpeedUpEnbabledFlag = 1;
  DrawW_DoTrough(Vi,(tBuildEntry *)BWorld_gChunkBuildList);
  gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
  stackSpeedUpEnbabledFlag = 0;
  if (GameSetup_gData.track == 0 && GameSetup_gData.Weather == 1) goto NO_LINES;
  {
    gWSavePtr = (u_long)SetSp((void *)0x1f8003fc);
    stackSpeedUpEnbabledFlag = 1;
    DrawW_DoLines(Vi,(tBuildEntry *)BWorld_gChunkBuildList,sd);
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
  }
NO_LINES:
  if (gSpikeBelt != 0) {
    int buildInd;

    for (buildInd = 0; buildInd < BWorld_gChunkCount; buildInd = buildInd + 1) {
      if (((tBuildEntry *)BWorld_gChunkBuildList)[buildInd].chunkInd == gSpikeBeltChunk) {
        DrawW_BuildSpikeBelt(Vi,gSpikeBeltWidth,sd);
      }
    }
  }
  if (GameSetup_gData.commMode == 0) {
    int buildInd;

    for (buildInd = 0; buildInd < BWorld_gChunkCount; buildInd = buildInd + 1) {
      Chunk *chunkPtr;
      int chunkInd;

      chunkInd = ((tBuildEntry *)BWorld_gChunkBuildList)[buildInd].chunkInd;
      chunkPtr = Track_chunkList + chunkInd;
      if (chunkPtr->sfxBuf != (Group *)0x0) {
        BWorld_BuildGlareEffects(Vi,sd,chunkPtr->sfxBuf);
      }
    }
  }
  if ((Object_customSFXInst != (Group *)0x0) &&
     (pvVar3 = BWorld_IsSliceInBuildList(Object_customSliceNum), pvVar3 != (void *)0x0)) {
    BWorld_BuildGlareEffects(Vi,sd,Object_customSFXInst);
  }
  DrawW_WorldSetUpMatrix(&gWorldMat,&sd->matB);
  DrawW_DoObjects(Vi,(tBuildEntry *)BWorld_gChunkBuildList);
  return;
}

/* W67-A4: bworld.obj's retail .sdata run resumes here -- totalMem (our gBWMemTotal)
   @0x8013c760 then the -G8 string-literal pool 0x8013c764..0x8013c790 (18C):
   "bworld" "S.grp" "N.grp" "W.grp" ".grp" "" in use order.  NEEDS whole-TU
   g_value 8 (PER_TU_FLAGS spec, w67a4: gates 20/21 2x == baseline).  A named
   section(".sdata") array device was probed and REVERTED: such an array is
   la-addressed, losing the oracle's split lui/addiu delay-slot fill.
   gBWMemTotal's definition position (before BWAllocMem) is load-bearing. */
int gBWMemTotal = 0;   /* @0x8013c760  SYM: STAT totalMem (kept global: per-symbol
                          gp-rel reloc, sec.3.12 #12) */

/* ---- BWAllocMem__Fl  [@0x8007e3f8] ---- */
char * BWAllocMem(long size)
{
  char *pcVar1;

  gBWMemTotal = gBWMemTotal + size;
  pcVar1 = Platform_GetDCTBuffer(size,"bworld");
  return pcVar1;
}

/* ---- BWorld_InitContexts__Fv  [@0x8007e428] ---- */
/* PASS (14/14 insns). Was a 2-diff near-miss: oracle loads `li a3,-1` BEFORE `li a2,1`; a plain
 * `i=1` local put gcc's -O2 scheduler on the other tie-break order for the two independent
 * constant loads. FIX: name the -1 constant as its OWN local (`noClient`) declared textually
 * BEFORE the loop counter `i` and assigned first -- this reorders gcc's constant-materialization
 * to match the oracle (`li a3,-1` first) without changing the loop trip count/shape, so the real
 * `bgez` branch survives (an earlier attempt at "named local for -1" apparently didn't isolate it
 * into its own declared-first variable and either no-op'd or risked the gcc full-unroll trap).
 * Corrected the field this loop writes to `contexts[i].client` (was miscoded as .currentChunk,
 * decoded from BWorld_OpenContext's independently-anchored offset map) and removed a bare-VA hack
 * (`iVar1 = -0x7fef10b8`) that had been standing in for `&gContextMan + 0x9C` -- that literal was
 * necessary under the old (wrong) field to block constant-propagation-driven unrolling, but is no
 * longer needed with the array-index form. */
void BWorld_InitContexts(void)
{
  int noClient;
  int i;

  noClient = -1;
  gContextMan.initialized = 1;
  gContextMan.count = 0;
  i = 1;
  do {
    gContextMan.contexts[i].client = noClient;
    i = i + -1;
  } while (-1 < i);
  return;
}

/* ---- BWorld_DeInitContexts__Fv  [@0x8007e460] ---- */
void BWorld_DeInitContexts(void)
{
  BWorld_InitContexts();
  return;
}

/* ---- SetContext__Fi  [@0x8007e480] ---- */
void SetContext(int contextHandle)
{
  gCurrContext = gContextMan.contexts + contextHandle;
  return;
}

/* ---- BWorld_OpenContext__Fii  [@0x8007e4ac] ---- */
int BWorld_OpenContext(int contextType,int client)
{
  BW_tContext *context;

  context = gContextMan.contexts + gContextMan.count;
  context->slicePos.slice = 0;
  context->client = client;
  switch (contextType) {
    case 0:
      context->chunkFarZClipSq = 0xcea40;
      context->polyFarZClipSq = 640000;
      context->lineFarZClipSq = 0x4c90;
      context->lowDetailDistSq = 0xe100;
      break;
    case 1:
      context->chunkFarZClipSq = 0x52210;
      context->polyFarZClipSq = 0x44944;
      context->lineFarZClipSq = 10000;
      context->lowDetailDistSq = 0x8d04;
      break;
  }
  return gContextMan.count++;
}

/* ---- BWorld_Restart__Fv  [@0x8007e564] ---- */
void BWorld_Restart(void)
{
  Object_KillStatus();
  Object_InitStatus();
  SetContext(0);
  BWorld_InitSpikeBelt();
  Anim_Restart();
  SceneLoaded = 0;
  Object_ClearCustomObjects();
  Draw_gDoVSync = 0;
  BWorldSm_Restart();
  return;
}

/* ---- BWorld_StartLoop__Fv  [@0x8007e5c0] ---- */
void BWorld_StartLoop(void)
{
  return;
}

/* ---- BWorld_Init__Fv  [@0x8007e5c8] ---- */
void BWorld_Init(void)
{
  int AudioScene;
  int random;

  if (Replay_ReplayMode == 0) {
    if ((GameSetup_gData.commMode != 1) && (GameSetup_gData.raceType != RaceType_Tournament)) {
      GameSetup_gData.SceneNumber = rand() / 0x4000;
      random = rand();
      if (GameSetup_gData.numLaps >= 2) {
        GameSetup_gData.SceneStartLap =
            random * GameSetup_gData.numLaps / 0x8000;
      }
      else {
        GameSetup_gData.SceneStartLap = random / 0x4000;
      }
      GameSetup_gData.SceneEndLap = GameSetup_gData.SceneStartLap +
          rand() * GameSetup_gData.numLaps / 0x8000;
      if (GameSetup_gData.SceneStartLap == GameSetup_gData.SceneEndLap) {
        GameSetup_gData.SceneEndLap = GameSetup_gData.SceneStartLap + 1;
      }
      if (GameSetup_gData.Weather != 0) {
        GameSetup_gData.SceneNumber = GameSetup_gData.SceneNumber + 10;
        GameSetup_gData.SceneEndLap = GameSetup_gData.SceneEndLap + 5;
      }
      else if (GameSetup_gData.trafficDensity != 0) {
        GameSetup_gData.SceneNumber = GameSetup_gData.SceneNumber + 0x14;
      }
      SceneLoaded = 0;
    }
    else {
      GameSetup_gData.SceneNumber = 99;
      GameSetup_gData.SceneStartLap = 99;
      GameSetup_gData.SceneEndLap = 99;
    }
  }
  Object_InitStatus();
  Track_SetTrackNumber(GameSetup_gData.track);
  BWorld_InitContexts();
  if (GameSetup_gData.commMode == 1) {
    BWorld_OpenContext(1,0);
    BWorld_OpenContext(1,1);
  }
  else {
    BWorld_OpenContext(0,0);
  }
  SetContext(0);
  if (GameSetup_gData.Time != 0) {
    if (GameSetup_gData.Weather != 0) {
      Track_Init(Track_MakeTrackPathName("S.grp"));
    }
    else {
      Track_Init(Track_MakeTrackPathName("N.grp"));
    }
  }
  else if (GameSetup_gData.Weather != 0) {
    Track_Init(Track_MakeTrackPathName("W.grp"));
  }
  else {
    Track_Init(Track_MakeTrackPathName(".grp"));
  }
  Object_InitCustomObjects();
  Object_InitIMassObjectInfo();
  if (gPersistObjDef != (Group *)0x0) {
    Scene_Init(gPersistObjDef->m_num_elements);
  }
  Loading_UpdateLoadingScreen(5);
  Anim_InitSystem(Track_MakeTrackDataPathName(""));
  if (((GameSetup_gData.commMode != 1) && (GameSetup_gData.raceType != RaceType_HotPursuit)) &&
     (GameSetup_gData.raceType != RaceType_Id5)) {
    Scene_LoadSceneFile(GameSetup_gData.SceneNumber);
  }
  AudioScene = (u_int)(GameSetup_gData.Time != 0);
  if (GameSetup_gData.Weather != 0) {
    AudioScene = AudioScene + 2;
  }
  AudList_LoadAudioFile(AudioScene);
  BWorld_InitSpikeBelt();
  return;
}

/* ---- BWorld_DeInit__Fv  [@0x8007e8b4] ---- RECONSTRUCTED 2026-06-12 (Ghidra @NFS4.EXE.c:59139).
 *  Skipped from the original bworld.obj 20-fn pass; full faithful body. */
void Track_DeInit(void);
void Object_DeInitIMassObjectInfo(void);
void Scene_DeInit(void);
void Object_DeInitCustomObjects(void);
void AudList_PurgeAudio(void);
void Anim_DeInitSystem(void);

void BWorld_DeInit(void)
{
  Object_KillStatus();
  Track_DeInit();
  BWorld_DeInitContexts();
  Object_DeInitIMassObjectInfo();
  Scene_DeInit();
  Object_DeInitCustomObjects();
  SceneLoaded = 0;
  AudList_PurgeAudio();
  Anim_DeInitSystem();
}
