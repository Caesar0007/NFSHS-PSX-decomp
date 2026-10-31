/* game/common/bworld.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 21 native-debug-covered functions: road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "bworld_types.h"
#include "bworld_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80055874): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* ---- bworld.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
matrixtdef   gWorldMat;   /* @0x8010ee40  (bss(zero)) */
matrixtdef   gNightMat;   /* @0x8010ee64  (bss(zero)) */
matrixtdef   gCopMat;   /* @0x8010ee88  (bss(zero)) */
BW_tContextMgr gContextMan;   /* @0x8010eeac  (bss(zero)) */
tBuildEntry BWorld_gChunkBuildList[36];   /* @0x8010efec  (bss(zero)) */
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
bool BWorld_IsSliceInBuildList(int slice);
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
#line 126 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
int xzsquaredist32(coorddef *c1,coorddef *c2)
{
  return (((c2->x - c1->x >> 0xc) * (c2->x - c1->x >> 0xc)) >> 6) + (((c2->z - c1->z >> 0xc) * (c2->z - c1->z >> 0xc)) >> 6);
}

/* ---- UpdateContext__FP13DRender_tViewi  [@0x8007d608] ---- */
#line 139 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void UpdateContext(DRender_tView *Vi,int contextHandle)
{


  SetContext(contextHandle);

  if (contextHandle == 0) {
    gBWSlice = (int)(gCurrContext->slicePos).slice;
  }






















































  BWorldSm_FindClosestQuadRez(&Vi->cview.translation,&gCurrContext->slicePos,1);

  if ((signed char)(gCurrContext->slicePos).offEdge != '\0')
  {
    int unused; /* SOURCE-REVIEW-UNRESOLVED: dummy declaration,not proven original; bounded retry loop preserves46words but drops both nested retail regions. */

    FindAbsClosestSliceCrude(&Vi->cview.translation,&gCurrContext->slicePos);
    BWorldSm_FindClosestQuadRez(&Vi->cview.translation,&gCurrContext->slicePos,1);
  }


  if (gCurrContext->currentChunk != (u_int)(gCurrContext->slicePos).chunk) {


    gCurrContext->currentChunk = (u_int)(gCurrContext->slicePos).chunk; } return; }

/* ---- BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group  [@0x8007d6c0] ---- */
        /* SOURCE-REVIEW-UNRESOLVED: this unused declaration has no retail row.
           Clean infinite-while controls match86 words but lose two regions.
           The real scope/loop producer, not code bytes alone, must be recovered;
           see build/nc12/bworld_search_scope_20261022. No object exemption. */
#line 227 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_BuildGlareEffects(DRender_tView *Vi,Draw_DCache *sd,Group *group)
{
  int i;
  int j;
  Trk_SFX *objInstance;
  int numObjects;
  i = 0; objInstance = (Trk_SFX *)group->GetData(); numObjects = group->m_num_elements;


  for (; i < numObjects; i++) {
    short pad;
    short type;

    pad = objInstance[i].pad;
    type = (short)objInstance[i].type;


    if (objInstance[i].type == 100) {

      coorddef dir = {0, 0xa0000, 0};
      TrgSfx_AddEnviroEffect(i, 0x101,
                             (coorddef *)&objInstance[i], &dir);
      return;
    }
    if (pad != 0) {
      int found_match;
      int group;
      found_match = 0; group = pad & 0x7fff;



      for (j = 0; j < numObjects; j++) {
        coorddef *pt1;

        if (group == (objInstance[j].pad & 0x7fff)) {


          found_match = 1;
          break;
        }
      }


      if (found_match != 0) {


        if (pad < 0) {

          coorddef *pt1 = (coorddef *)&objInstance[j];
          Flare_Halo2(Vi, -1, (short)type,
                      (coorddef *)&objInstance[i], pt1, (Draw_FlareCache *)sd);
        }
      }
    }
    else {
      Flare_Halo(Vi, -1, (short)type,








                 (coorddef *)&objInstance[i], (Draw_FlareCache *)sd);
    }
  }
}

/* MATCH: retail's zero-store phase precedes the two minimum initializers.
 * Ordinary anchored layout reproduces all43 tags and every supplied region;
 * the existing for-owned i is retained. A separate counter block changes the
 * scope tree even when bytes agree. Literal original text remains unproven. */
/* ---- BWorld_InitSpikeBelt__Fv  [@0x8007d818] ---- */
#line 323 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_InitSpikeBelt(void)
{
  int leastDist; int leastDistInd; gSpikeBelt = 0;
  gSpikeBeltSlice = 0;
  gSpikeBeltChunk = 0;





  leastDist = 0x7fffffff;
  leastDistInd = -1;

  for (int i = 0; i < Chunk_numLight; i = i + 1) {
    int dist;
    dist = (0x80 - (u_int)Chunk_lightTable[i].r) * (0x80 - (u_int)Chunk_lightTable[i].r) + (0x80 - (u_int)Chunk_lightTable[i].g) * (0x80 - (u_int)Chunk_lightTable[i].g) + (0x80 - (u_int)Chunk_lightTable[i].b) * (0x80 - (u_int)Chunk_lightTable[i].b);



    if (dist < leastDist) {

      leastDist = dist;
      leastDistInd = i;
    }
  }
  gSpikeBeltColourTableIndex = leastDistInd;
}

/* ---- BWorld_SetSpikeBelt__Fiii  [@0x8007d8c4] ---- */
#line 351 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_SetSpikeBelt(int slice,int x,int width)
{
  gSpikeBelt = 1;
  gSpikeBeltSlice = slice;
  gSpikeBeltChunk = (u_int)BWorldSm_slices[slice].chunkIndex;
  gSpikeBeltWidth = width;
  gSpikeBeltX = x;
}

/* ---- BWorld_GetSpikeBelt__FPiN20  [@0x8007d8f8] ---- */
#line 362 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
int BWorld_GetSpikeBelt(int *slice,int *x,int *width)
{
  if (gSpikeBelt == 1) {

    *slice = gSpikeBeltSlice;
    *x = gSpikeBeltX;
    *width = gSpikeBeltWidth;
    return 1;
  }


  *width = 0; *x = 0; *slice = 0;
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
/* HISTORICAL (resolved): 16 diffs with exact 181/181 instruction parity (90 diffs at the
 * start of this round).  The SLD trace recovers the retail scopes and names:
 * tm@sp+16, rotY@sp+56, i=$a3, maxdist=$t1, theCar=$a2, plus the scoped
 * campos/dx/dz/diff locals.  `__builtin_abs` is required for the oracle's two
 * `bgez; nop; negu` sequences; hand-written abs lets GCC fill both delay slots.
 * The only residual is the same scheduling/coloring tie repeated for gNightMat
 * and gCopMat: ours processes m[4] before m[7], retail m[7] before m[4].  Direct
 * assignments, reordered locals/definitions, aliasing and volatile-load probes
 * were neutral; disabling sched2 regressed to 38 diffs. */
/* MATCH: all181 words and supplied local/scope tuples. Three real matrix
 * loads precede their three stores; ordinary anchored layout follows retail.
 * GCC's supported compound for-initialization executes the actual i=-1
 * statement on516 while its loop owner starts515, with no added debug region,
 * source object or fake use. Literal original macro/syntax text is unproven. */
#line 392 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void SetupBuildMatrices(DRender_tView *Vi,Draw_DCache *sd)
{























































  if ((Vi->id == Draw_gPlayer1View) || (Vi->id == Draw_gPlayer2View)) {
    UpdateContext(Vi,Vi->player);
  } else {
    UpdateContext(Vi,1);
  }









  { int t1; int t2; int t3;

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




    gWorldMat.m[8] = t3; } if (gNight_renderNight != 0)
  { matrixtdef tm; int i; int maxdist;







    transpose(&(Camera_gInfo[Vi->player].target)->orientMat,&gNightMat);

    { int t1; int t2; int t3;


      t1 = gNightMat.m[1];
      t2 = gNightMat.m[4];
      t3 = gNightMat.m[7];
      gNightMat.m[1] = -t1;
      gNightMat.m[4] = -t2;
      gNightMat.m[7] = -t3;
    }

    DrawW_WorldSetUpMatrix(&gNightMat,&sd->matNight);

    BW_gCopCarObj = (Car_tObj *)0x0;
    maxdist = 0xb40000;
    if (GameSetup_gData.commMode != 1)
    {

      for ({
        i = -1; } i < Cars_gNumCopCars; i = i + 1) {
        Car_tObj *theCar;

        if (i < 0) {
          theCar = Cars_gList[0];
        } else {
          theCar = Cars_gCopCarList[i];
        }

        if ((((theCar->N).active != '\0') && ((theCar->AIFlags & 2U) != 0)) && (((theCar->render).damageParts & 4U) == 0))
        { coorddef *campos = &(Vi->cview).translation; int dx; int dz; int diff;







          dx = (theCar->N).position.x - campos->x;
          dz = (theCar->N).position.z - campos->z;

          dx = __builtin_abs(dx);
          dz = __builtin_abs(dz);

          if (dz < dx) { diff = dx + (dz >> 2); } else { diff = dz + (dx >> 2); }

          if (diff < maxdist) {

            maxdist = diff;

            BW_gCopCarObj = theCar;
          }
        }
      }

      if (BW_gCopCarObj != (Car_tObj *)0x0)
      { matrixtdef rotY;

        static int cop_angle = 0;



        Night_SetCopColor(BW_gCopCarObj->carInfo);


        cop_angle = cop_angle + 0x40; xformy(&rotY,cop_angle);
        transpose(&(BW_gCopCarObj->N).orientMat,&tm);

        Math_fasttransmult(&tm,&rotY,&gCopMat);

        { int t1; int t2; int t3;

          t1 = gCopMat.m[1];
          t2 = gCopMat.m[4];
          t3 = gCopMat.m[7];
          gCopMat.m[1] = -t1;
          gCopMat.m[4] = -t2;
          gCopMat.m[7] = -t3;
        }
        DrawW_WorldSetUpMatrix(&gCopMat,&sd->matCop); } } } return; }


/* ---- BWorld_CheckChunkVisible__FP12BWorldSm_PosT0  [@0x8007dc14] ---- */
/* Current oracle: 80 words, 32-byte slice stride and chunkIndex at+0x1c.
 * The old branch-floor verdict is obsolete: the function already PASSes.
 * Its historical explanation also conflated integer and typed-pointer
 * arithmetic; a cast to int does not itself scale an addition by sizeof.
 * Keep actual field/stride and native/raw-link evidence as the authority,
 * not that old explanation or an allocator/source-object exemption. */
/* PASS: ternary-selected slice pointers, packed byte counts, flat 32-short rows,
 * and a separate count-- reproduce the retail instructions/allocation shape. */
/* HISTORICAL 2026-10-13 basin: removing forward-index capture gives18dif/80;
 * both captures gives22dif/80; backward alone gives4dif/80, distributing
 * -2 to a late -64 instead of reusing the tested index. Reverse pointer
 * subtraction gives6dif/82; widening the index remains4dif/80, widening
 * byte scaling gives96dif/92. Reusing testChunkIndBwd for both phases gives
 *63dif/79. The mixed no-wrap-byte/wrap-slice expressions below now remove
 * both captures jointly at80/80. Earlier failures did not prove objects.
 * Capture receipt: build/nc12/bworld_visibility_shift_20261022. The following
 * SLD round restores real base-before-count order and if/else result selection;
 * build/nc12/bworld_visibility_sld_20261022 checks all80 tags and full ownership.
 * Literal original expression/macro/label spellings remain unproven. */
#line 589 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
int BWorld_CheckChunkVisible(BWorldSm_Pos *slicePosSource,BWorldSm_Pos *slicePosTest)
{
  int sourceChunkInd;
  int testChunkIndFwd;
  int testChunkIndBwd;
  short *chunkViewList;
  int chunkInd;
  int count;
  int vis;


  if (slicePosSource == slicePosTest) {
    return 1;
  }

  testChunkIndFwd = (u_short)((int)slicePosTest->slice + 2 < gNumSlices ? (Trk_NewSlice *)((char *)BWorldSm_slices + (int)((u_int)((int)slicePosTest->slice + 2) << 5)) : BWorldSm_slices + ((int)slicePosTest->slice - (gNumSlices - 2)))->chunkIndex;
  testChunkIndBwd = (u_short)((int)slicePosTest->slice - 2 >= 0 ? (Trk_NewSlice *)((char *)BWorldSm_slices + (int)((u_int)((int)slicePosTest->slice - 2) << 5)) : BWorldSm_slices + ((int)slicePosTest->slice + (gNumSlices - 2)))->chunkIndex;
  sourceChunkInd = slicePosSource->chunk;

  chunkViewList = (short *)Track_gInViewList + sourceChunkInd * 32;


  count = ((u_char *)Track_gInViewCount)[sourceChunkInd];
  count--; vis = 0; if (count != -1) { do {

      chunkInd = chunkViewList[count];
      if ((chunkInd & 0x3ff) == testChunkIndFwd) {

        if ((chunkInd & 0x800) != 0) goto visible_check;




        vis++; if (vis != 1) goto visible_check;
      }


      if ((chunkInd & 0x3ff) == testChunkIndBwd) {

        if ((chunkInd & 0x800) != 0) goto visible_check;




        vis++; if (vis != 1) goto visible_check;
      } count--; } while (count != -1); }




visible_check:
  if (vis == 2)
    return 1;
  else
    return 0;
}

/* ---- GetRezIndex__Fi  [@0x8007dd54] ---- */
#line 656 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
int GetRezIndex(int dist)
{


  if (gCurrContext->lowDetailDistSq < dist)
    return 0;


  else
    return 4;
}

/* ---- SetupChunkBuildList__FP13DRender_tView  [@0x8007dd74] ---- */
/* PASS 203/203.  JEB recovered the high-level loop while the SLD scopes/locals
 * and IDA register annotations established the 144-byte frame and saved-register
 * allocation.  The indexed chunkViewList reads preserve the source shape needed
 * for GCC to strength-reduce the retail walker without a post-compile rewrite. */
/* MATCH: the for owns retail's viewInd; its body ends before the increment.
 * Split real clip-test phases and put chunkPtr's source assignment before
 * translation work. All203 words, all provided locals and six block records
 * match; 202/203 word tags agree. The remaining high-address tag is688 versus
 * retail677, created when loop optimization hoists the array's address.
 * SOURCE-REVIEW-UNRESOLVED: chunkViewList is supported by NFS2 BuildFacets'
 * parameter and SoundTrack's local, not a recovered NFS4 declaration/name.
 * Retail retains one row across calls; six direct global-row forms add26/27
 * instructions and reload the list/current chunk. This is not a metadata
 * ordering difference, but it does not uniquely prove the original C object.
 * Seven real counter/setup-initializer controls keep203 words yet leave the
 * high-address tag688. No failed or neutral control is adopted. The original
 * row producer/name and early address-note producer remain explicit work.
 * Receipt: build/nc12/bworld_buildlist_row_source_20261022. No exemption. */
#line 675 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
int SetupChunkBuildList(DRender_tView *Vi)
{
  int chunkInd;
  int chunkCount;
  int totalVisChunks;
  short *chunkViewList;
    totalVisChunks = (int)*(u_char *)((char *)Track_gInViewCount + gCurrContext->currentChunk);


    chunkViewList = ((short (*)[32])Track_gInViewList)[gCurrContext->currentChunk];
    chunkCount = 0;


    for (int viewInd = chunkCount; viewInd < totalVisChunks; viewInd++) {
      int chunkDist;
      coorddef *pChunkCp;
      Chunk *chunkPtr;
      coorddef tmpPts[4];
      coorddef tmp;
      coorddef tmp2;








































      chunkInd = (u_short)chunkViewList[viewInd] & 0x3ff;


      pChunkCp = Chunk_chunkCenters + chunkInd;
      chunkDist = xzsquaredist32(pChunkCp,&Vi->cview.translation);
      if (chunkDist <= gCurrContext->chunkFarZClipSq) {



        if ((chunkViewList[viewInd] & 0x800U) == 0) {





          chunkPtr = Track_chunkList + chunkInd;





          tmp.x = -Vi->cview.translation.x + pChunkCp->x;
          tmp.y = -Vi->cview.translation.y + BWorldSm_slices[chunkInd << 3].center[1];
          tmp.z = -Vi->cview.translation.z + pChunkCp->z;



          TrsProj_SetPsxTransZero();
          TrsProj_TransPt(&tmp,&tmp2);
          TrsProj_SetPsxTrans(&tmp2);

          TrsProj_TransPtN16(chunkPtr->boundPts,tmpPts,4);



          if (((tmpPts[0].x <= tmpPts[0].z) || (tmpPts[1].x <= tmpPts[1].z) || (tmpPts[2].x <= tmpPts[2].z) || (tmpPts[3].x <= tmpPts[3].z)) && ((-tmpPts[0].x <= tmpPts[0].z) || (-tmpPts[1].x <= tmpPts[1].z) || (-tmpPts[2].x <= tmpPts[2].z) || (-tmpPts[3].x <= tmpPts[3].z))) {





            if (((0 <= tmpPts[0].z) || (0 <= tmpPts[1].z) || (0 <= tmpPts[2].z) || (0 <= tmpPts[3].z))) {








              BWorld_gChunkBuildList[chunkCount].enableBits = 3;





















              if (chunkDist < gCurrContext->lineFarZClipSq) {
                BWorld_gChunkBuildList[chunkCount].enableBits = 7;
              }

              if ((chunkViewList[viewInd] & 0x4000U) != 0) {
                BWorld_gChunkBuildList[chunkCount].enableBits &= 0xfd;
              }
              if ((chunkViewList[viewInd] & 0x2000U) != 0) {
                BWorld_gChunkBuildList[chunkCount].enableBits &= 0xfe;
              }


              BWorld_gChunkBuildList[chunkCount].geomRez = (char)GetRezIndex(chunkDist);


              BWorld_gChunkBuildList[chunkCount].chunkInd = (short)chunkInd;

              chunkCount++; } } } }
    }

















  return chunkCount;
}

/* ---- BWorld_IsSliceInBuildList__Fi  [@0x8007e0a0] ---- */
/* PASS (21/21 insns): the indexed source loop strength-reduces its build-list
 * address into retail's $v1 induction.  The condition and loop bound retain
 * two textual BWorld_gChunkCount uses; GCC materializes the value in $v0 and
 * copies it to long-lived $a2 in the guard's delay slot. */
#line 846 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
bool BWorld_IsSliceInBuildList(int slice)
{
  int chunk = slice / 8;
  for (int bi = 0; bi < BWorld_gChunkCount; bi++) {
    if ((int)((tBuildEntry *)BWorld_gChunkBuildList)[bi].chunkInd == chunk) {

      return 1;
    }
  } return 0;
}

/* MATCH: numeric fog-field narrowing removes the old empty assembly fence.
 * The seven completed-type aliases belong to their shared headers; their
 * restoration also permits anonymous typed reads without losing supplied
 * typedef copies. No separate trackSpec source object is needed here.
 * Retail SLD groups the real stack/cache updates and owns each loop counter.
 * All193 word tags, block/end coordinates and supplied locals now match;
 * literal original macro/comment text is not uniquely proved by that seal. */
/* ---- BWorld_OnyxBuildFacets__FP13DRender_tView  [@0x8007e0f4] ---- */
#line 905 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_OnyxBuildFacets(DRender_tView *Vi)
{
  Draw_DCache *sd;






  Chunk_UpdateSys(Vi);




  gVi2 = Vi;
  gWSavePtr = SetSp(0x1f8003fc); stackSpeedUpEnbabledFlag = 1;

  SetupBuildMatrices(gVi2,(Draw_DCache *)0x1f800000);
  DrawW_WorldSetUpMatrix(&gWorldMat,(MATRIX *)0x1f800014);




  BWorld_gChunkCount = SetupChunkBuildList(gVi2); sd = (Draw_DCache *)0x1f800000;

  gWSavePtr = SetSp(gWSavePtr); stackSpeedUpEnbabledFlag = 0;


  ((Draw_tGiveShelbyMoreCache *)sd)->startfog = (u_short)TrackSpec_gSpec.fogspec.start;
  ((Draw_tGiveShelbyMoreCache *)sd)->distfog = (u_short)TrackSpec_gSpec.fogspec.dist2base;
  ((Draw_tGiveShelbyMoreCache *)sd)->fogstate = (u_char)TrackSpec_gSpec.fogstate;


  if (GameSetup_gData.Time != 0)
  { short a; u_char ac; u_char bc; u_char cc; u_char dc;
    a = (short)Night_gZNear;
    ac = (u_char)Night_gXDistShift;
    bc = (u_char)Night_gZDistShift;
    cc = (u_char)Night_gDrawLightning;
    dc = (u_char)Night_gLightningType;


    ((Draw_tGiveShelbyMoreCache *)sd)->night_ZNear = a;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_XDistShift = ac;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_ZDistShift = bc;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_DrawLightning = cc;
    ((Draw_tGiveShelbyMoreCache *)sd)->night_LightningType = dc; }














  gWSavePtr = SetSp(0x1f8003fc); stackSpeedUpEnbabledFlag = 1;
  DrawW_DoTrough(Vi,(tBuildEntry *)BWorld_gChunkBuildList);
  gWSavePtr = SetSp(gWSavePtr); stackSpeedUpEnbabledFlag = 0;





  if (GameSetup_gData.track != 0 || GameSetup_gData.Weather != 1) {


    gWSavePtr = SetSp(0x1f8003fc); stackSpeedUpEnbabledFlag = 1;

    DrawW_DoLines(Vi,(tBuildEntry *)BWorld_gChunkBuildList,sd);


    gWSavePtr = SetSp(gWSavePtr); stackSpeedUpEnbabledFlag = 0;
  }

  if (gSpikeBelt != 0) { { int buildInd = 0;

    while (buildInd < BWorld_gChunkCount) {

    if (((tBuildEntry *)BWorld_gChunkBuildList)[buildInd].chunkInd == gSpikeBeltChunk) {
      DrawW_BuildSpikeBelt(Vi,gSpikeBeltWidth,sd);
    } buildInd = buildInd + 1; } }

  }







  if (GameSetup_gData.commMode == 0)
  {

    for (int buildInd = 0; buildInd < BWorld_gChunkCount; buildInd = buildInd + 1) {
      Chunk *chunkPtr; int chunkInd;

      chunkInd = ((tBuildEntry *)BWorld_gChunkBuildList)[buildInd].chunkInd;

      chunkPtr = Track_chunkList + chunkInd;

      if (chunkPtr->sfxBuf != (Group *)0x0) {


        BWorld_BuildGlareEffects(Vi,sd,chunkPtr->sfxBuf);
      }
    }

  }

  if (Object_customSFXInst != (Group *)0x0) {


    if (BWorld_IsSliceInBuildList(Object_customSliceNum) != 0) {

      BWorld_BuildGlareEffects(Vi,sd,Object_customSFXInst);
    }
  }










  DrawW_WorldSetUpMatrix(&gWorldMat,&sd->matB);



  DrawW_DoObjects(Vi,(tBuildEntry *)BWorld_gChunkBuildList);












  return;
}

/* W67-A4: bworld.obj's retail .sdata run resumes here -- totalMem
   @0x8013c760 then the -G8 string-literal pool 0x8013c764..0x8013c790 (18C):
   "bworld" "S.grp" "N.grp" "W.grp" ".grp" "" in use order.  NEEDS whole-TU
   g_value 8 (PER_TU_FLAGS spec, w67a4: gates 20/21 2x == baseline).  A named
   section(".sdata") array device was probed and REVERTED: such an array is
   la-addressed, losing the oracle's split lui/addiu delay-slot fill.
   totalMem's definition position at BWAllocMem is load-bearing. */

/* ---- BWAllocMem__Fl  [@0x8007e3f8] ----
 * SLD separates the allocator call (+5) from its return (+6). The const
 * dctBuffer value is debug-elided; its semantic name is inferred, not SYM.
 * SOURCE-REVIEW-UNRESOLVED: direct return remains12word PASS/native CLEAN
 * but loses four retail +6 epilogue tags and end6 (becomes5). Restored;
 * producer/original-name recovery remains open, not a debug exemption. */
#line 1106 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
char * BWAllocMem(long size)
{
  /* SYM records this as BWAllocMem's function-local STAT at 0x8013c760. */
  static int totalMem = 0;

  totalMem = totalMem + size;
  char *const dctBuffer = Platform_GetDCTBuffer(size,"bworld");
  return dctBuffer;
}

/* ---- BWorld_InitContexts__Fv  [@0x8007e428] ---- */
#line 1145 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_InitContexts(void)
{
  int i;

  gContextMan.initialized = 1;
  gContextMan.count = 0;

  for (i = 0; i < 2; i++) {

    gContextMan.contexts[i].client = -1;
  }
}

/* ---- BWorld_DeInitContexts__Fv  [@0x8007e460] ---- */
#line 1164 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_DeInitContexts(void)
{

  BWorld_InitContexts();
}

/* ---- SetContext__Fi  [@0x8007e480] ---- */
#line 1177 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void SetContext(int contextHandle)
{
  gCurrContext = gContextMan.contexts + contextHandle;
}

/* MATCH: unchanged switch/field/return tokens, ordinary anchored layout.
 * The first break shares the last store's source line; all46 instruction
 * tags and block/end coordinates now agree. No source-only object added. */
/* ---- BWorld_OpenContext__Fii  [@0x8007e4ac] ---- */
#line 1188 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
int BWorld_OpenContext(int contextType,int client)
{
  BW_tContext *context;

  context = gContextMan.contexts + gContextMan.count;
  context->slicePos.slice = 0;


  context->client = client; switch (contextType) {
    case 0:

      context->chunkFarZClipSq = 0xcea40;
      context->polyFarZClipSq = 640000;

      context->lineFarZClipSq = 0x4c90;


      context->lowDetailDistSq = 0xe100; break;

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
/* SOURCE-REVIEW-UNRESOLVED: the unused declaration below is not supplied by
 * retail. Its zero-length region is real, but the original producer is not
 * recovered. Real call-work controls are private diagnostics, not a license
 * to add a wrapper merely to conceal the unresolved source obligation. */
#line 1231 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_Restart(void)
{
  { int unused; } Object_KillStatus();
  Object_InitStatus();
  SetContext(0);

  BWorld_InitSpikeBelt();

  Anim_Restart();


  SceneLoaded = 0;
  Object_ClearCustomObjects();



  Draw_gDoVSync = 0;


  BWorldSm_Restart(); return;
}

/* ---- BWorld_StartLoop__Fv  [@0x8007e5c0] ---- */
#line 1260 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_StartLoop(void)
{








}

/* MATCH: the bound-first maximum (2 > numLaps ? 2 : numLaps) removes the
 * unrecorded random-word capture with all187 words/whole normal ELF unchanged.
 * Value-first factor and destination-staging controls differ; their failures
 * did not prove a distinct original source object. Retail-derived ordinary
 * layout now matches all187 word tags, block lines and the function end;
 * this does not uniquely prove the literal original macro/comment text. */
/* ---- BWorld_Init__Fv  [@0x8007e5c8] ---- */
#line 1279 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
void BWorld_Init(void)
{
  int AudioScene;
  if (Replay_ReplayMode == 0) {

    if ((GameSetup_gData.commMode != 1) && (GameSetup_gData.raceType != RaceType_Tournament)) {


      GameSetup_gData.SceneNumber = rand() / 0x4000;
      GameSetup_gData.SceneStartLap = rand() * (2 > GameSetup_gData.numLaps ? 2 : GameSetup_gData.numLaps) / 0x8000;
      GameSetup_gData.SceneEndLap = GameSetup_gData.SceneStartLap + rand() * GameSetup_gData.numLaps / 0x8000;


      if (GameSetup_gData.SceneStartLap == GameSetup_gData.SceneEndLap) {
        GameSetup_gData.SceneEndLap = GameSetup_gData.SceneStartLap + 1;
      }

      if (GameSetup_gData.Weather != 0) {

        GameSetup_gData.SceneNumber = GameSetup_gData.SceneNumber + 10;
        GameSetup_gData.SceneEndLap = GameSetup_gData.SceneEndLap + 5;


      } else if (GameSetup_gData.trafficDensity != 0) {
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
  } else {

    BWorld_OpenContext(0,0);
  }
  SetContext(0);


  if (GameSetup_gData.Time != 0) { if (GameSetup_gData.Weather != 0) {
    Track_Init(Track_MakeTrackPathName("S.grp"));
  } else {
    Track_Init(Track_MakeTrackPathName("N.grp")); } }
  else if (GameSetup_gData.Weather != 0) {
    Track_Init(Track_MakeTrackPathName("W.grp"));
  } else {
    Track_Init(Track_MakeTrackPathName(".grp"));
  }


  Object_InitCustomObjects();

  Object_InitIMassObjectInfo();



  if (gPersistObjDef != (Group *)0x0) {
    Scene_Init(gPersistObjDef->m_num_elements);
  }
  Loading_UpdateLoadingScreen(5);

  Anim_InitSystem(Track_MakeTrackDataPathName(""));



  if (((GameSetup_gData.commMode != 1) && (GameSetup_gData.raceType != RaceType_HotPursuit)) && (GameSetup_gData.raceType != RaceType_Id5)) {

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

#line 1388 "C:/nfs4/GAME/COMMON/BWORLD.CPP"
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

  return;
}
