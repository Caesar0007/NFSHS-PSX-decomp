/* game/common/bworld.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "bworld_externs.h"

/* ---- bworld.obj anon file-statics (no SYM name; Ghidra DAT_; real .bss bytes = 0) ---- */
static void *gBWPrimPtr;    /* @0x8013c75c */
int   gBWMemTotal;   /* @0x8013c760  (global, not static: per-symbol gp-rel reloc, sec.3.12 #12) */


/* ---- bworld.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
matrixtdef   gWorldMat;   /* @0x8010ee40  (bss(zero)) */
matrixtdef   gNightMat;   /* @0x8010ee64  (bss(zero)) */
matrixtdef   gCopMat;   /* @0x8010ee88  (bss(zero)) */
BW_tContextMgr gContextMan;   /* @0x8010eeac  (bss(zero)) */
int BWorld_gChunkBuildList[36];   /* @0x8010efec  (bss(zero)) */
int          SceneLoaded;   /* @0x8013c758  (bss(zero)) */
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
  pt = &Vi->cview;
  if (contextHandle == 0) {
    gBWSlice = (int)(gCurrContext->slicePos).slice;
  }
  BWorldSm_FindClosestQuadRez(&pt->translation,&gCurrContext->slicePos,1);
  if ((gCurrContext->slicePos).offEdge != '\0') {
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
  Trk_SFX*objInstance;
  int numObjects;
  short pad;
  short type;
  coorddef dir;
  int found_match;
  coorddef*pt1;
  u_short uVar1;
  bool bVar2;
  coorddef *pcVar3;
  coorddef *pcVar4;
  int iVar5;
  coorddef *fpt;
  int obj;
  coorddef *pcVar6;
  int iVar7;
  coorddef local_30;
  
  obj = 0;
  pcVar6 = (coorddef *)(group + 1);
  iVar7 = group->m_num_elements;
  fpt = pcVar6;
  do {
    if (iVar7 <= obj) {
      return;
    }
    uVar1 = *(u_short *)((int)&fpt[1].x + 2);
    iVar5 = (int)(short)fpt[1].x;
    if (iVar5 == 100) {
      local_30.x = 0;
      local_30.y = 0xa0000;
      local_30.z = 0;
      TrgSfx_AddEnviroEffect(obj,0x101,fpt,&local_30);
      return;
    }
    bVar2 = false;
    if (uVar1 == 0) {
      Flare_Halo(Vi,-1,iVar5,fpt,(Draw_FlareCache *)sd);
    }
    else {
      pcVar4 = pcVar6;
      for (iVar5 = 0; iVar5 < iVar7; iVar5 = iVar5 + 1) {
        pcVar3 = pcVar4 + 1;
        pcVar4 = (coorddef *)&pcVar4[1].y;
        if ((uVar1 & 0x7fff) == (*(u_short *)((int)&pcVar3->x + 2) & 0x7fff)) {
          bVar2 = true;
          break;
        }
      }
      if ((bVar2) && ((int)((u_int)uVar1 << 0x10) < 0)) {
        Flare_Halo2(Vi,-1,(int)(short)fpt[1].x,fpt,(coorddef *)((int)pcVar6 + iVar5 * 0x10),(Draw_FlareCache *)sd);
      }
    }
    fpt = (coorddef *)&fpt[1].y;
    obj = obj + 1;
  } while( true );
}

/* ---- BWorld_InitSpikeBelt__Fv  [@0x8007d818] ---- */
void BWorld_InitSpikeBelt(void)
{
  int leastDist;
  int leastDistInd;
  int i;
  int dist;
  int iVar1;
  int iVar2;
  int iVar3;
  CVECTOR *pCVar4;
  int iVar5;
  int iVar6;
  
  iVar6 = 0x7fffffff;
  gSpikeBeltColourTableIndex = -1;
  gSpikeBelt = 0;
  gSpikeBeltSlice = 0;
  gSpikeBeltChunk = 0;
  pCVar4 = Chunk_lightTable;
  for (iVar5 = 0; iVar5 < Chunk_numLight; iVar5 = iVar5 + 1) {
    iVar1 = 0x80 - (u_int)pCVar4->r;
    iVar2 = 0x80 - (u_int)pCVar4->g;
    iVar3 = 0x80 - (u_int)pCVar4->b;
    iVar1 = iVar1 * iVar1 + iVar2 * iVar2 + iVar3 * iVar3;
    if (iVar1 < iVar6) {
      iVar6 = iVar1;
      gSpikeBeltColourTableIndex = iVar5;
    }
    pCVar4 = pCVar4 + 1;
  }
  return;
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
  if (gSpikeBelt != 1) {
    *width = 0;
    *x = 0;
    *slice = 0;
    return 0;
  }
  *slice = gSpikeBeltSlice;
  *x = gSpikeBeltX;
  *width = gSpikeBeltWidth;
  return 1;
}

/* ---- SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache  [@0x8007d940] ---- */
void SetupBuildMatrices(DRender_tView *Vi,Draw_DCache *sd)
{
  int t1;
  int t2;
  int t3;
  matrixtdef tm;
  int i;
  int maxdist;
  Car_tObj*theCar;
  coorddef*campos;
  int dx;
  int dz;
  int diff;
  matrixtdef rotY;
  static int cop_angle;
  int iVar1;
  int iVar2;
  int iVar3;
  Car_tObj *pCVar4;
  int iVar5;
  Car_tObj **ppCVar6;
  matrixtdef mStack_60;
  matrixtdef mStack_38;
  
  if ((Vi->id == Draw_gPlayer1View) || (Vi->id == Draw_gPlayer2View)) {
    iVar2 = Vi->player;
  }
  else {
    iVar2 = 1;
  }
  UpdateContext(Vi,iVar2);
  gWorldMat.m[0] = (Vi->cview).mrotationInv.m[0];
  gWorldMat.m[2] = (Vi->cview).mrotationInv.m[2];
  gWorldMat.m[1] = -(Vi->cview).mrotationInv.m[1];
  gWorldMat.m[3] = (Vi->cview).mrotationInv.m[3];
  gWorldMat.m[5] = (Vi->cview).mrotationInv.m[5];
  gWorldMat.m[4] = -(Vi->cview).mrotationInv.m[4];
  gWorldMat.m[6] = (Vi->cview).mrotationInv.m[6];
  gWorldMat.m[8] = (Vi->cview).mrotationInv.m[8];
  gWorldMat.m[7] = -(Vi->cview).mrotationInv.m[7];
  if (gNight_renderNight != 0) {
    transpose(&(Camera_gInfo[Vi->player].target)->orientMat,&gNightMat);
    gNightMat.m[1] = 0;
                    
    gNightMat.m[7] = 0;
                    
    gNightMat.m[4] = 0;
                    
    DrawW_WorldSetUpMatrix(&gNightMat,&sd->matNight);
    BW_gCopCarObj = (Car_tObj *)0x0;
    iVar2 = 0xb40000;
    if (GameSetup_gData.commMode != 1) {
      ppCVar6 = Cars_gTrafficCarList + 8;
      for (iVar5 = -1; iVar5 < Cars_gNumCopCars; iVar5 = iVar5 + 1) {
        if (iVar5 < 0) {
          pCVar4 = (Car_tObj *)0x0;
        }
        else {
          pCVar4 = *ppCVar6;
        }
        if ((((pCVar4->N).active != '\0') && ((pCVar4->AIFlags & 2U) != 0)) &&
           (((pCVar4->render).damageParts & 4U) == 0)) {
          iVar3 = (pCVar4->N).position.x - (Vi->cview).translation.x;
          iVar1 = (pCVar4->N).position.z - (Vi->cview).translation.z;
          if (iVar3 < 0) {
            iVar3 = -iVar3;
          }
          if (iVar1 < 0) {
            iVar1 = -iVar1;
          }
          if (iVar1 < iVar3) {
            iVar3 = iVar3 + (iVar1 >> 2);
          }
          else {
            iVar3 = iVar1 + (iVar3 >> 2);
          }
          if (iVar3 < iVar2) {
            iVar2 = iVar3;
            BW_gCopCarObj = pCVar4;
          }
        }
        ppCVar6 = ppCVar6 + 1;
      }
      if (BW_gCopCarObj != (Car_tObj *)0x0) {
        Night_SetCopColor(BW_gCopCarObj->carInfo);
        gBWPrimPtr = (void *)((int)gBWPrimPtr + 0x40);
        xformy(&mStack_38,gBWPrimPtr);
        transpose(&(BW_gCopCarObj->N).orientMat,&mStack_60);
        Math_fasttransmult(&mStack_60,&mStack_38,&gCopMat);
        gCopMat.m[1] = 0;
                    
        gCopMat.m[7] = 0;
                    
        gCopMat.m[4] = 0;
                    
        DrawW_WorldSetUpMatrix(&gCopMat,&sd->matCop);
      }
    }
  }
  return;
}

/* ---- BWorld_CheckChunkVisible__FP12BWorldSm_PosT0  [@0x8007dc14] ---- */
int BWorld_CheckChunkVisible(BWorldSm_Pos *slicePosSource,BWorldSm_Pos *slicePosTest)
{
  int sourceChunkInd;
  int testChunkIndFwd;
  int testChunkIndBwd;
  short*chunkViewList;
  int chunkInd;
  int count;
  int vis;
  u_short uVar1;
  int iVar2;
  u_int uVar3;
  int iVar4;
  u_int uVar5;
  u_int uVar6;
  int iVar7;
  short *psVar8;
  
  if (slicePosSource == slicePosTest) {
    return 1;
  }
  iVar4 = slicePosTest->slice + 2;
  if (gNumSlices <= iVar4) {
    iVar4 = (int)slicePosTest->slice - (gNumSlices + -2);
  }
  iVar2 = slicePosTest->slice + -2;
  if (iVar2 < 0) {
    iVar2 = (int)slicePosTest->slice + gNumSlices + -2;
  }
  iVar7 = Track_gInViewCount[slicePosSource->chunk] - 1;
  uVar5 = 0;
  if (iVar7 != -1) {
    psVar8 = Track_gInViewList[slicePosSource->chunk - 1] +
             Track_gInViewCount[slicePosSource->chunk] + 0x1f;
    do {
      uVar1 = *psVar8;
      if ((uVar1 & 0x3ff) == (u_short)*(u_char *)(BWorldSm_slices + iVar4 * 0x20 + 0x1c)) {
        uVar3 = uVar5 ^ 2;
        if ((uVar1 & 0x800) != 0) goto LAB_8007dd44;
        uVar6 = uVar5 + 1;
        uVar3 = uVar6 ^ 2;
        uVar5 = 1;
        if (uVar6 != 1) goto LAB_8007dd44;
      }
      if ((uVar1 & 0x3ff) == (u_short)*(u_char *)(BWorldSm_slices + iVar2 * 0x20 + 0x1c)) {
        uVar3 = uVar5 ^ 2;
        if ((uVar1 & 0x800) != 0) goto LAB_8007dd44;
        uVar6 = uVar5 + 1;
        uVar3 = uVar6 ^ 2;
        uVar5 = 1;
        if (uVar6 != 1) goto LAB_8007dd44;
      }
      iVar7 = iVar7 + -1;
      psVar8 = psVar8 + -1;
    } while (iVar7 != -1);
  }
  uVar3 = uVar5 ^ 2;
LAB_8007dd44:
  return (u_int)(uVar3 == 0);
}

/* ---- GetRezIndex__Fi  [@0x8007dd54] ---- */
int GetRezIndex(int dist)
{
  return (gCurrContext->lowDetailDistSq < dist ^ 1) << 2;
}

/* ---- SetupChunkBuildList__FP13DRender_tView  [@0x8007dd74] ---- */
int SetupChunkBuildList(DRender_tView *Vi)
{
  int chunkInd;
  int chunkCount;
  int totalVisChunks;
  int viewInd;
  int chunkDist;
  coorddef*pChunkCp;
  Chunk*chunkPtr;
  coorddef tmpPts[4];
  coorddef tmp;
  coorddef tmp2;
  int iVar1;
  coorddef *c1;
  Chunk *s;
  int *piVar2;
  u_int uVar3;
  short *psVar4;
  int iVar5;
  int iVar6;
  coorddef local_80;
  int local_74;
  int local_6c;
  int local_68;
  int local_60;
  int local_5c;
  int local_54;
  coorddef local_50;
  coorddef cStack_40;
  u_int local_30;
  
  piVar2 = BWorld_gChunkBuildList;
  iVar6 = 0;
  psVar4 = Track_gInViewList[gCurrContext->currentChunk];
  local_30 = (u_int)Track_gInViewCount[gCurrContext->currentChunk];
  for (iVar5 = 0; iVar5 < (int)local_30; iVar5 = iVar5 + 1) {
    uVar3 = (u_short)*psVar4 & 0x3ff;
    c1 = Chunk_chunkCenters + uVar3;
    iVar1 = xzsquaredist32(c1,&(Vi->cview).translation);
    if ((iVar1 <= gCurrContext->chunkFarZClipSq) && ((*psVar4 & 0x800U) == 0)) {
      local_50.x = c1->x - (Vi->cview).translation.x;
      local_50.y = *(int *)(uVar3 * 0x100 + BWorldSm_slices + 4) - (Vi->cview).translation.y;
      local_50.z = c1->z - (Vi->cview).translation.z;
      s = Track_chunkList + uVar3;
      TrsProj_SetPsxTransZero();
      TrsProj_TransPt(&local_50,&cStack_40);
      TrsProj_SetPsxTrans(&cStack_40);
      TrsProj_TransPtN16(s->boundPts,&local_80,4);
      if (((local_80.x <= local_80.z) ||
          (((local_74 <= local_6c || (local_68 <= local_60)) || (local_5c <= local_54)))) &&
         (((((-local_80.x <= local_80.z || (-local_74 <= local_6c)) || (-local_68 <= local_60)) ||
           (-local_5c <= local_54)) &&
          (((-1 < local_80.z || (-1 < local_6c)) || ((-1 < local_60 || (-1 < local_54)))))))) {
        *(u_char *)((int)piVar2 + 3) = 3;
        if (iVar1 < gCurrContext->lineFarZClipSq) {
          *(u_char *)((int)piVar2 + 3) = 7;
        }
        if ((*psVar4 & 0x4000U) != 0) {
          *(u_char *)((int)piVar2 + 3) = *(u_char *)((int)piVar2 + 3) & 0xfd;
        }
        if ((*psVar4 & 0x2000U) != 0) {
          *(u_char *)((int)piVar2 + 3) = *(u_char *)((int)piVar2 + 3) & 0xfe;
        }
        iVar1 = GetRezIndex(iVar1);
        *(char *)((int)piVar2 + 2) = (char)iVar1;
        *(short *)piVar2 = (short)uVar3;
        piVar2 = piVar2 + 1;
        iVar6 = iVar6 + 1;
      }
    }
    psVar4 = psVar4 + 1;
  }
  return iVar6;
}

/* ---- BWorld_IsSliceInBuildList__Fi  [@0x8007e0a0] ---- */
/* NEAR-MISS 5 diffs (20/21): oracle loads BWorld_gChunkCount into $v0 then blez + sra delay +
 * addu $a2,$v0,zero copy. Our gcc-2.8.0 -O2 loads directly into $a2 (no intermediate v0 copy).
 * Levers tried: (1) pre-shift hoist, (2) count local, (3) bi rename, (4) direct global read.
 * Pre-shift hoist fixed 7→5; the remaining v0/a2 split is a scheduler floor. ACCEPT. */
void * BWorld_IsSliceInBuildList(int slice)
{
  int *piVar1;
  int bi;

  bi = 0;
  if (slice < 0) {
    slice = slice + 7;
  }
  slice = slice >> 3;
  if (0 < BWorld_gChunkCount) {
    piVar1 = BWorld_gChunkBuildList;
    do {
      bi = bi + 1;
      if ((int)(short)*piVar1 == slice) {
        return (void *)0x1;
      }
      piVar1 = piVar1 + 1;
    } while (bi < BWorld_gChunkCount);
  }
  return (void *)0x0;
}

/* ---- BWorld_OnyxBuildFacets__FP13DRender_tView  [@0x8007e0f4] ---- */
void BWorld_OnyxBuildFacets(DRender_tView *Vi)
{
  Draw_DCache*sd;
  short a;
  u_char ac;
  u_char bc;
  u_char cc;
  u_char dc;
  int buildInd;
  Chunk*chunkPtr;
  int chunkInd;
  u_short uVar1;
  u_long uVar2;
  void *pvVar3;
  int iVar4;
  int *piVar5;
  
  Chunk_UpdateSys(Vi);
  gVi2 = Vi;
  gWSavePtr = (u_long)SetSp((void *)0x1f800000);
  stackSpeedUpEnbabledFlag = 1;
  SetupBuildMatrices(gVi2,(Draw_DCache *)&Render_gPalettePtr);
  DrawW_WorldSetUpMatrix(&gWorldMat,&Render_gWorldMat);
  BWorld_gChunkCount = SetupChunkBuildList(gVi2);
  gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
  stackSpeedUpEnbabledFlag = 0;
  Skid_gScratchPos1 = 0;
  Skid_gScratchPos2 = 0;
  (*(char *)0x1f80010e) = '\0';
  uVar1 = 0;
  if (GameSetup_gData.Time != 0) {
    (*(short *)0x1f800108) = (u_short)Night_gZNear;
    (*(u_char *)0x1f80010a) = (u_char)Night_gXDistShift;
    (*(u_char *)0x1f80010b) = (u_char)Night_gZDistShift;
    (*(char *)0x1f80010c) = Night_gDrawLightning;
    (*(u_char *)0x1f80010d) = (u_char)Night_gLightningType;
    uVar1 = (u_short)Night_gZNear;
  }
  uVar2 = (u_long)uVar1;
  gWSavePtr = (u_long)SetSp((void *)0x1f800000);
  stackSpeedUpEnbabledFlag = 1;
  DrawW_DoTrough(Vi,(tBuildEntry *)BWorld_gChunkBuildList);
  gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
  stackSpeedUpEnbabledFlag = 0;
  if ((GameSetup_gData.track != 0) ||
     (uVar2 = GameSetup_gData.Weather, GameSetup_gData.Weather != 1)) {
    gWSavePtr = (u_long)SetSp((void *)0x1f800000);
    stackSpeedUpEnbabledFlag = 1;
    DrawW_DoLines(Vi,(tBuildEntry *)BWorld_gChunkBuildList,(Draw_DCache *)&Render_gPalettePtr);
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
  }
  stackSpeedUpEnbabledFlag = 0;
  if ((gSpikeBelt != 0) && (iVar4 = 0, 0 < BWorld_gChunkCount)) {
    piVar5 = BWorld_gChunkBuildList;
    do {
      if ((short)*piVar5 == gSpikeBeltChunk) {
        DrawW_BuildSpikeBelt(Vi,gSpikeBeltWidth,(Draw_DCache *)&Render_gPalettePtr);
      }
      iVar4 = iVar4 + 1;
      piVar5 = piVar5 + 1;
    } while (iVar4 < BWorld_gChunkCount);
  }
  iVar4 = 0;
  if (GameSetup_gData.commMode == 0) {
    piVar5 = BWorld_gChunkBuildList;
    for (; iVar4 < BWorld_gChunkCount; iVar4 = iVar4 + 1) {
      if (Track_chunkList[(short)*piVar5].sfxBuf != (Group *)0x0) {
        BWorld_BuildGlareEffects(Vi,(Draw_DCache *)&Render_gPalettePtr,Track_chunkList[(short)*piVar5].sfxBuf);
      }
      piVar5 = piVar5 + 1;
    }
  }
  if ((Object_customSFXInst != (Group *)0x0) &&
     (pvVar3 = BWorld_IsSliceInBuildList(Object_customSliceNum), pvVar3 != (void *)0x0)) {
    BWorld_BuildGlareEffects(Vi,(Draw_DCache *)&Render_gPalettePtr,Object_customSFXInst);
  }
  DrawW_WorldSetUpMatrix(&gWorldMat,&Render_gWorldMat);
  DrawW_DoObjects(Vi,(tBuildEntry *)BWorld_gChunkBuildList);
  return;
}

/* ---- BWAllocMem__Fl  [@0x8007e3f8] ---- */
char * BWAllocMem(long size)
{
  static int totalMem;
  char *pcVar1;
  
  gBWMemTotal = gBWMemTotal + size;
  pcVar1 = Platform_GetDCTBuffer(size,"bworld");
  return pcVar1;
}

/* ---- BWorld_InitContexts__Fv  [@0x8007e428] ---- */
void BWorld_InitContexts(void)
{
  int i;
  int iVar1;
  int iVar2;
  
  iVar2 = 1;
  iVar1 = -0x7fef10b8;
  gContextMan.initialized = 1;
  gContextMan.count = 0;
  do {
    *(u_int *)(iVar1 + 8) = 0xffffffff;
    iVar2 = iVar2 + -1;
    iVar1 = iVar1 + -0x9c;
  } while (-1 < iVar2);
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
  BW_tContext*context;
  int iVar1;
  int iVar2;
  int iVar3;
  BW_tContext *pBVar4;
  
  iVar2 = gContextMan.count;
  pBVar4 = gContextMan.contexts + gContextMan.count;
  gContextMan.contexts[gContextMan.count].slicePos.slice = 0;
  pBVar4->client = client;
  if (contextType == 0) {
    iVar3 = 0xcea40;
    gContextMan.contexts[iVar2].polyFarZClipSq = 640000;
    gContextMan.contexts[iVar2].lineFarZClipSq = 0x4c90;
    iVar1 = 0xe100;
  }
  else {
    if (contextType != 1) goto LAB_8007e54c;
    iVar3 = 0x52210;
    gContextMan.contexts[iVar2].polyFarZClipSq = 0x44944;
    gContextMan.contexts[iVar2].lineFarZClipSq = 10000;
    iVar1 = 0x8d04;
  }
  gContextMan.contexts[iVar2].chunkFarZClipSq = iVar3;
  gContextMan.contexts[iVar2].lowDetailDistSq = iVar1;
LAB_8007e54c:
  iVar2 = gContextMan.count;
  gContextMan.count = gContextMan.count + 1;
  return iVar2;
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
  bool bVar1;
  int iVar2;
  char *pcVar3;
  u_int uVar4;
  
  if (Replay_ReplayMode == 0) {
    if ((GameSetup_gData.commMode == 1) || (GameSetup_gData.raceType == 2)) {
      GameSetup_gData.SceneNumber = 99;
      GameSetup_gData.SceneStartLap = 99;
      GameSetup_gData.SceneEndLap = 99;
    }
    else {
      iVar2 = rand();
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0x3fff;
      }
      GameSetup_gData.SceneNumber = iVar2 >> 0xe;
      iVar2 = rand();
      if (GameSetup_gData.numLaps < 2) {
        if (iVar2 < 0) {
          iVar2 = iVar2 + 0x3fff;
        }
        GameSetup_gData.SceneStartLap = iVar2 >> 0xe;
      }
      else {
        iVar2 = iVar2 * GameSetup_gData.numLaps;
        if (iVar2 < 0) {
          iVar2 = iVar2 + 0x7fff;
        }
        GameSetup_gData.SceneStartLap = iVar2 >> 0xf;
      }
      iVar2 = rand();
      iVar2 = iVar2 * GameSetup_gData.numLaps;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0x7fff;
      }
      GameSetup_gData.SceneEndLap = GameSetup_gData.SceneStartLap + (iVar2 >> 0xf);
      if (GameSetup_gData.SceneStartLap == GameSetup_gData.SceneEndLap) {
        GameSetup_gData.SceneEndLap = GameSetup_gData.SceneStartLap + 1;
      }
      if (GameSetup_gData.Weather == 0) {
        if (GameSetup_gData.trafficDensity != 0) {
          GameSetup_gData.SceneNumber = GameSetup_gData.SceneNumber + 0x14;
        }
      }
      else {
        GameSetup_gData.SceneNumber = GameSetup_gData.SceneNumber + 10;
        GameSetup_gData.SceneEndLap = GameSetup_gData.SceneEndLap + 5;
      }
      SceneLoaded = 0;
    }
  }
  Object_InitStatus();
  Track_SetTrackNumber(GameSetup_gData.track);
  BWorld_InitContexts();
  bVar1 = GameSetup_gData.commMode == 1;
  if (bVar1) {
    BWorld_OpenContext(1,0);
  }
  uVar4 = (u_int)bVar1;
  BWorld_OpenContext(uVar4,uVar4);
  SetContext(0);
  if (GameSetup_gData.Time == 0) {
    if (GameSetup_gData.Weather == 0) {
      pcVar3 = ".grp";
    }
    else {
      pcVar3 = "W.grp";
    }
  }
  else if (GameSetup_gData.Weather == 0) {
    pcVar3 = "N.grp";
  }
  else {
    pcVar3 = "S.grp";
  }
  pcVar3 = Track_MakeTrackPathName(pcVar3);
  Track_Init(pcVar3);
  Object_InitCustomObjects();
  Object_InitIMassObjectInfo();
  if (gPersistObjDef != (Group *)0x0) {
    Scene_Init(gPersistObjDef->m_num_elements);
  }
  Loading_UpdateLoadingScreen(5);
  pcVar3 = Track_MakeTrackDataPathName("");
  Anim_InitSystem(pcVar3);
  if (((GameSetup_gData.commMode != 1) && (GameSetup_gData.raceType != 1)) &&
     (GameSetup_gData.raceType != 5)) {
    Scene_LoadSceneFile(GameSetup_gData.SceneNumber);
  }
  uVar4 = (u_int)(GameSetup_gData.Time != 0);
  if (GameSetup_gData.Weather != 0) {
    uVar4 = uVar4 + 2;
  }
  AudList_LoadAudioFile(uVar4);
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
