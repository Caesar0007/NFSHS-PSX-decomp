/* game/common/bworldSm.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworldSm.obj (GAME\COMMON\bworldSm.cpp) = 28 fns: simplified BWorld road-follower
 *   (slice/quad/triangle finding, normal cache, sim-quad update). SYM-v3 locals; self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "bworldSm_externs.h"


/* ---- bworldSm.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
tNormalCacheEntry BWSM_NormalCache[16];   /* @0x8010f0ac  (bss(zero)) */
Trk_NewSimQuad GlobalSimQuad = {14u};   /* @0x8013c7bc */
Trk_NewSlice *BWorldSm_slices;   /* @0x8013c7c0  (bss(zero)) */
int          sim_Handle;   /* @0x8013c7c4  (bss(zero)) */
int          gNumSlices;   /* @0x8013c7c8  (bss(zero)) */
void         *sim_File;   /* @0x8013c7cc  (bss(zero)) */
Group        *sim_ItemPtr;   /* @0x8013c7d0  (bss(zero)) */
int          gMaxFindQuadSliceIterations;   /* @0x8013c7d4  (bss(zero)) */
u_long       BWSM_NormalCacheSysTime;   /* @0x8013c7d8  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
int BWorldSm_Init(Group *simGroup);
void BWorldSm_Restart(void);
void BWorldSm_DeInit(void);
void FindAbsClosestSliceCrude(coorddef *pt,BWorldSm_Pos *slicePos);
int BWorldSm_FindClosestSlice(coorddef *pt,BWorldSm_Pos *slicePos);
void RawFindClosestSlice(coorddef *pt,BWorldSm_Pos *slicePos);
void BWorldSm_SetSlice(int slice,BWorldSm_Pos *slicePos);
void GetStmQuadPts(BWorldSm_Pos *slicePos,coorddef *cp);
void SetStrip(BWorldSm_Pos *slicePos);
void GetFirstStmQuadPts(BWorldSm_Pos *slicePos,CCOORD16 *vertices);
void BWorld_SetSimSlice(BWorldSm_Pos *slicePos);
void BworldSm_UpdateSimQuad(BWorldSm_Pos *slicePos);
int BworldSm_IsSimQuadValid(BWorldSm_Pos *slicePos);
int RawFindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos);
int FindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos);
int BWorldSm_FindClosestQuadRez(coorddef *pt,BWorldSm_Pos *slicePos,int hiRezFlag);
int BWorldSm_FindClosestQuadMaxIterations(coorddef *pt,BWorldSm_Pos *slicePos,int maxIterations);
int PointDirection(coorddef *p1,coorddef *p2,coorddef *p3);
int BWorldSm_FindEdgeOff(coorddef *pt,BWorldSm_Pos *slicePos1,BWorldSm_Pos *slicePos2,int *heightDiff);
int BWorldSm_QuadLight(BWorldSm_Pos *slicePos);
void * BWorldSm_TunnelFlagSm(BWorldSm_Pos *slicePos);
void NormalCache_AddEntry(BWorldSm_Pos *slicePos);
void * NormalCache_FindEntry(BWorldSm_Pos *slicePos);
void NormalCache_Init(void);
void Check_Rot(BWorldSm_Pos *slicePos);
coorddef * BWorldSm_UNormal(BWorldSm_Pos *slicePos);
coorddef * BWorldSm_UForward(BWorldSm_Pos *slicePos);
int BWorldSm_FindClosestTriangleRez(coorddef *pt,BWorldSm_Pos *slicePos,int hiRezFlag);


/* ---- BWorldSm_Init__FP5Group  [@0x8007e910] ---- */
int BWorldSm_Init(Group *simGroup)
{
  gNumSlices = simGroup->m_num_elements;
  BWorldSm_slices = (int)(simGroup + 1);
  gMaxFindQuadSliceIterations = 5;
  BWorldSm_Restart();
  return 1;
}

/* ---- BWorldSm_Restart__Fv  [@0x8007e948] ---- */
void BWorldSm_Restart(void)
{
  NormalCache_Init();
  return;
}

/* ---- BWorldSm_DeInit__Fv  [@0x8007e968] ---- */
void BWorldSm_DeInit(void)
{
  return;
}

/* ---- FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos  [@0x8007e970] ---- */
void FindAbsClosestSliceCrude(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int numSlices;
  int currDist;
  int currInd;
  int dist;
  int i;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  short sVar5;
  int iVar6;
  
  iVar1 = gNumSlices;
  iVar4 = 0x7fffffff;
  iVar6 = -1;
  sVar5 = -1;
  iVar3 = 0;
  if (0 < gNumSlices) {
    do {
      iVar2 = xzsquaredist32((coorddef *)(BWorldSm_slices + iVar3 * 0x20),pt);
      if (iVar2 < iVar4) {
        iVar4 = iVar2;
        iVar6 = iVar3;
      }
      sVar5 = (short)iVar6;
      iVar3 = iVar3 + 8;
    } while (iVar3 < iVar1);
  }
  slicePos->slice = sVar5;
  return;
}

/* ---- BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos  [@0x8007ea14] ---- */
int BWorldSm_FindClosestSlice(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int startSlice;
  u_char uVar1;
  short sVar2;
  bool bVar3;
  int iVar4;
  
  sVar2 = slicePos->slice;
  iVar4 = Math_DistXZ((coorddef *)(BWorldSm_slices + sVar2 * 0x20),pt);
  if (0x800000 < iVar4) {
    FindAbsClosestSliceCrude(pt,slicePos);
  }
  RawFindClosestSlice(pt,slicePos);
  uVar1 = *(u_char *)(slicePos->slice * 0x20 + BWorldSm_slices + 0x1c);
  bVar3 = slicePos->slice != sVar2;
  slicePos->quadChanged = bVar3;
  slicePos->sliceChanged = bVar3;
  slicePos->chunk = uVar1;
  return (u_int)bVar3;
}

/* ---- RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos  [@0x8007eab0] ---- */
void RawFindClosestSlice(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int lastind;
  int maxind;
  int index;
  int distcurr;
  int distnext;
  int distprev;
  Trk_NewSlice*slices;
  bool bVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int *piVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  
  iVar7 = (int)slicePos->slice;
  iVar9 = gNumSlices + -1;
  iVar8 = iVar7;
  if (iVar7 != -1) {
    do {
      if (iVar8 < iVar9) {
        iVar2 = pt->x;
        iVar7 = iVar8;
      }
      else {
        iVar7 = iVar8 % gNumSlices;
        if (gNumSlices == 0) {
          trap(0x1c00);
        }
        if ((gNumSlices == -1) && (iVar8 == -0x80000000)) {
          trap(0x1800);
        }
        iVar2 = pt->x;
      }
      piVar5 = (int *)(iVar7 * 0x20 + BWorldSm_slices);
      iVar7 = iVar2 - *piVar5 >> 9;
      iVar2 = pt->z - piVar5[2] >> 9;
      iVar2 = iVar7 * iVar7 + iVar2 * iVar2;
      if (iVar8 < gNumSlices + -2) {
        iVar6 = iVar8 * 0x20 + BWorldSm_slices;
        iVar7 = pt->x - *(int *)(iVar6 + 0x20) >> 9;
        iVar6 = pt->z - *(int *)(iVar6 + 0x28) >> 9;
        if (iVar7 * iVar7 + iVar6 * iVar6 < iVar2) {
          iVar7 = iVar8 + 1;
        }
        else {
LAB_8007ec3c:
          if (iVar8 < 1) {
            iVar7 = iVar8 + 1 + iVar9;
            iVar6 = iVar7 + -1;
            if (gNumSlices == 0) {
              trap(0x1c00);
            }
            if ((gNumSlices == -1) && (iVar6 == -0x80000000)) {
              trap(0x1800);
            }
            piVar5 = (int *)((iVar6 % gNumSlices) * 0x20 + BWorldSm_slices);
            iVar3 = pt->x - *piVar5 >> 9;
            iVar4 = pt->z - piVar5[2] >> 9;
            if (iVar3 * iVar3 + iVar4 * iVar4 < iVar2) {
              iVar7 = iVar6;
            }
            iVar2 = iVar7 + 1 + iVar9;
            iVar7 = iVar2 % gNumSlices;
            if (gNumSlices == 0) {
              trap(0x1c00);
            }
            if ((gNumSlices == -1) && (iVar2 == -0x80000000)) {
              trap(0x1800);
            }
          }
          else {
            iVar7 = iVar8 * 0x20 + BWorldSm_slices;
            iVar6 = pt->x - *(int *)(iVar7 + -0x20) >> 9;
            iVar3 = pt->z - *(int *)(iVar7 + -0x18) >> 9;
            iVar7 = iVar8;
            if (iVar6 * iVar6 + iVar3 * iVar3 < iVar2) {
              iVar7 = iVar8 + -1;
            }
          }
        }
      }
      else {
        iVar7 = (iVar8 + 1) % gNumSlices;
        if (gNumSlices == 0) {
          trap(0x1c00);
        }
        if ((gNumSlices == -1) && (iVar8 + 1 == -0x80000000)) {
          trap(0x1800);
        }
        piVar5 = (int *)(iVar7 * 0x20 + BWorldSm_slices);
        iVar6 = pt->x - *piVar5 >> 9;
        iVar3 = pt->z - piVar5[2] >> 9;
        if (iVar2 <= iVar6 * iVar6 + iVar3 * iVar3) goto LAB_8007ec3c;
      }
      bVar1 = iVar8 != iVar7;
      iVar8 = iVar7;
    } while (bVar1);
  }
  slicePos->slice = (short)iVar7;
  return;
}

/* ---- BWorldSm_SetSlice__FiP12BWorldSm_Pos  [@0x8007ed64] ---- */
void BWorldSm_SetSlice(int slice,BWorldSm_Pos *slicePos)
{
  u_char uVar1;
  int iVar2;
  
  slicePos->slice = (short)slice;
  slicePos->sliceChanged = '\0';
  slicePos->quadChanged = '\0';
  slicePos->offEdge = '\0';
  iVar2 = BWorldSm_slices;
  slicePos->simSlice = (Trk_NewSimSlice *)0x0;
  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  slicePos->simRotFlag = 0;
  uVar1 = *(u_char *)(slicePos->slice * 0x20 + iVar2 + 0x1c);
  *(signed char *)&slicePos->lastRezRequested = -2;
  slicePos->rez = '\x01';
  slicePos->triangleFlag = '\0';
  *(signed char *)&slicePos->quad = -1;
  slicePos->chunk = uVar1;
  return;
}

/* ---- GetStmQuadPts__FP12BWorldSm_PosP8coorddef  [@0x8007edb8] ---- */
void GetStmQuadPts(BWorldSm_Pos *slicePos,coorddef *cp)
{
  Trk_NewStrip*pStrip;
  coorddef*pts;
  int cx;
  int cy;
  int cz;
  int topInd;
  int botInd;
  int x;
  int y;
  int z;
  short sVar1;
  int iVar2;
  Group *pGVar3;
  Group *pGVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  
  iVar7 = cp->x;
  iVar6 = cp->y;
  iVar5 = cp->z;
  pGVar3 = Track_chunkList[slicePos->chunk].vertexBuf +
           ((u_int)slicePos->strip->topVert + (int)slicePos->stripQuadInd) * 2 + 1;
  sVar1 = *(short *)((int)&pGVar3[2].m_num_elements + 2);
  iVar2 = pGVar3[3].m_num_elements;
  pGVar4 = Track_chunkList[slicePos->chunk].vertexBuf +
           ((u_int)slicePos->strip->botVert + (int)slicePos->stripQuadInd) * 2 + 1;
  slicePos->quadPts[1].x = iVar7 + (short)pGVar3[2].m_num_elements * 0x400;
  slicePos->quadPts[1].y = iVar6 + sVar1 * 0x400;
  slicePos->quadPts[1].z = iVar5 + (short)iVar2 * 0x400;
  sVar1 = *(short *)((int)&pGVar3->m_num_elements + 2);
  iVar2 = pGVar3[1].m_num_elements;
  slicePos->quadPts[2].x = iVar7 + (short)pGVar3->m_num_elements * 0x400;
  slicePos->quadPts[2].y = iVar6 + sVar1 * 0x400;
  slicePos->quadPts[2].z = iVar5 + (short)iVar2 * 0x400;
  sVar1 = *(short *)((int)&pGVar4->m_num_elements + 2);
  iVar2 = pGVar4[1].m_num_elements;
  slicePos->quadPts[3].x = iVar7 + (short)pGVar4->m_num_elements * 0x400;
  slicePos->quadPts[3].y = iVar6 + sVar1 * 0x400;
  slicePos->quadPts[3].z = iVar5 + (short)iVar2 * 0x400;
  sVar1 = *(short *)((int)&pGVar4[2].m_num_elements + 2);
  iVar2 = pGVar4[3].m_num_elements;
  slicePos->quadPts[0].x = iVar7 + (short)pGVar4[2].m_num_elements * 0x400;
  slicePos->quadPts[0].y = iVar6 + sVar1 * 0x400;
  slicePos->quadPts[0].z = iVar5 + (short)iVar2 * 0x400;
  return;
}

/* ---- SetStrip__FP12BWorldSm_Pos  [@0x8007eee0] ---- */
void SetStrip(BWorldSm_Pos *slicePos)
{
  int i;
  int maxIndex;
  int quadCount;
  bool bVar1;
  Trk_NewStrip *pTVar2;
  int iVar3;
  u_int uVar4;
  
  iVar3 = 0;
  uVar4 = (u_int)slicePos->simSlice->stripIndex;
  slicePos->strip = (Trk_NewStrip *)(Track_chunkList[slicePos->chunk].stripBuf + 1);
  if (uVar4 != 0) {
    do {
      iVar3 = iVar3 + 1;
      slicePos->strip =
           (Trk_NewStrip *)
           (&slicePos->strip[1].topVert + (u_int)(u_char)slicePos->strip->quadCount * 2);
    } while (iVar3 < (int)uVar4);
  }
  iVar3 = (int)slicePos->quad;
  uVar4 = (u_int)(u_char)slicePos->strip->quadCount;
  if ((int)uVar4 <= iVar3) {
    iVar3 = iVar3 - uVar4;
    do {
      pTVar2 = (Trk_NewStrip *)(&slicePos->strip[1].topVert + uVar4 * 2);
      slicePos->strip = pTVar2;
      uVar4 = (u_int)(u_char)pTVar2->quadCount;
      bVar1 = (int)uVar4 <= iVar3;
      iVar3 = iVar3 - uVar4;
    } while (bVar1);
    iVar3 = iVar3 + uVar4;
  }
  slicePos->stripQuadInd = (short)iVar3;
  return;
}

/* ---- GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16  [@0x8007ef98] ---- */
void GetFirstStmQuadPts(BWorldSm_Pos *slicePos,CCOORD16 *vertices)
{
  CCOORD16*pts;
  Trk_NewStrip*pStrip;
  int topInd;
  int botInd;
  short x;
  short z;
  u_char bVar1;
  short sVar2;
  short sVar3;
  CCOORD16 *pCVar4;
  CCOORD16 *pCVar5;
  
  SetStrip(slicePos);
  sVar2 = slicePos->stripQuadInd;
  bVar1 = slicePos->strip->botVert;
  pCVar4 = vertices + (u_int)slicePos->strip->topVert + (int)sVar2;
  sVar3 = pCVar4[1].z;
  slicePos->quadPts16[1].x = pCVar4[1].x;
  slicePos->quadPts16[1].z = sVar3;
  sVar3 = pCVar4->z;
  pCVar5 = vertices + (u_int)bVar1 + (int)sVar2;
  slicePos->quadPts16[2].x = pCVar4->x;
  slicePos->quadPts16[2].z = sVar3;
  sVar2 = pCVar5->z;
  slicePos->quadPts16[3].x = pCVar5->x;
  slicePos->quadPts16[3].z = sVar2;
  sVar2 = pCVar5[1].z;
  slicePos->quadPts16[0].x = pCVar5[1].x;
  slicePos->quadPts16[0].z = sVar2;
  return;
}

/* ---- BWorld_SetSimSlice__FP12BWorldSm_Pos  [@0x8007f034] ---- */
void BWorld_SetSimSlice(BWorldSm_Pos *slicePos)
{
  Trk_NewSimSlice*simSlices;
  int chunkSliceInd;
  u_char bVar1;
  
  bVar1 = *(u_char *)(slicePos->slice * 0x20 + BWorldSm_slices + 0x1c);
  slicePos->chunk = bVar1;
  slicePos->simSlice =
       (Trk_NewSimSlice *)
       ((int)Track_chunkList[bVar1].simSliceBuf +
       ((int)slicePos->slice - (int)Track_chunkList[bVar1].firstSimSliceInd) * 5 + 4);
  return;
}

/* ---- BworldSm_UpdateSimQuad__FP12BWorldSm_Pos  [@0x8007f094] ---- */
void BworldSm_UpdateSimQuad(BWorldSm_Pos *slicePos)
{
  int simIndex;
  Trk_NewSimQuad*startsimquad;
  Group *pGVar1;
  Trk_NewSimSlice *pTVar2;
  int iVar3;
  
  pTVar2 = slicePos->simSlice;
  iVar3 = (int)slicePos->quad - (u_int)pTVar2->simquadStartIndex;
  if ((-1 < iVar3) && (iVar3 < (int)(u_int)pTVar2->simquadCount)) {
    pGVar1 = Track_chunkList[slicePos->chunk].simQuadBuf;
    slicePos->simQuad = (Trk_NewSimQuad *)(pGVar1 + 1);
    slicePos->simQuad = (Trk_NewSimQuad *)((int)(pGVar1 + 1) + (u_int)pTVar2->simquadIndex + iVar3);
    return;
  }
  slicePos->simQuad = &GlobalSimQuad;
  return;
}

/* ---- BworldSm_IsSimQuadValid__FP12BWorldSm_Pos  [@0x8007f11c] ---- */
int BworldSm_IsSimQuadValid(BWorldSm_Pos *slicePos)
{
  if (slicePos->simQuad != (Trk_NewSimQuad *)0x0) {
    return (u_int)(((slicePos->simQuad->surface & 0xf) ^ 0xe) != 0);
  }
  return 0;
}

/* ---- RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos  [@0x8007f14c] ---- */
int RawFindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int attempt;
  int startQuadInd;
  static int sliceOffs[12];
  int sliceVariance;
  CCOORD16 pt16;
  int dist;
  int lastDist;
  int firstSliceOffEdge;
  int newSlice;
  int numSlices;
  u_char bVar1;
  u_char uVar2;
  short sVar3;
  short sVar4;
  Trk_NewSimSlice *pTVar5;
  char cVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int iVar10;
  int iVar11;
  int iVar12;
  int iVar13;
  int iVar14;
  int iVar15;
  int iVar16;
  int iVar17;
  CCOORD16 *vertices;
  int iVar18;
  coorddef *cp;
  u_char uVar19;
  int iVar20;
  
  iVar18 = 0;
  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  slicePos->simRotFlag = 0;
  BWorld_SetSimSlice(slicePos);
  iVar7 = (int)slicePos->quad;
  iVar20 = 0;
  if (((iVar7 < 0) || ((int)(slicePos->simSlice->quadCount - 1) <= iVar7)) ||
     (slicePos->offEdge != '\0')) {
    cVar6 = (char)((int)(slicePos->simSlice->quadCount - 1) / 2);
    iVar7 = (int)cVar6;
    slicePos->quad = cVar6;
  }
  cVar6 = '\0';
  slicePos->offEdge = '\0';
  uVar19 = (u_char)iVar7;
  slicePos->quad = uVar19;
  do {
    if (gMaxFindQuadSliceIterations <= iVar18) {
      iVar20 = slicePos->slice - iVar20;
      if (gNumSlices <= iVar20) {
        iVar20 = iVar20 - gNumSlices;
      }
      if (iVar20 < 0) {
        iVar20 = iVar20 + gNumSlices;
      }
      slicePos->slice = (short)iVar20;
      BWorld_SetSimSlice(slicePos);
      slicePos->offEdge = cVar6;
      slicePos->simQuad = (Trk_NewSimQuad *)0x0;
      slicePos->triangleFlag = '\0';
      return 0;
    }
    BWorld_SetSimSlice(slicePos);
    slicePos->quad = uVar19;
    bVar1 = slicePos->simSlice->quadCount;
    if ((int)(bVar1 - 1) < iVar7) {
      slicePos->quad = bVar1 - 2;
    }
    cp = Chunk_chunkCenters + slicePos->chunk;
    sVar3 = (short)(pt->x - cp->x >> 10);
    sVar4 = (short)(pt->z - cp->z >> 10);
    vertices = (CCOORD16 *)(Track_chunkList[slicePos->chunk].vertexBuf + 1);
    GetFirstStmQuadPts(slicePos,vertices);
    BworldSm_UpdateSimQuad(slicePos);
    pTVar5 = slicePos->simSlice;
    iVar17 = 0x7fffffff;
    while ((int)slicePos->quad <= (int)(pTVar5->quadCount - 1)) {
      GetFirstStmQuadPts(slicePos,vertices);
      iVar10 = (int)slicePos->quadPts16[1].x;
      iVar14 = (int)slicePos->quadPts16[2].x;
      iVar15 = (int)sVar4;
      iVar16 = (int)slicePos->quadPts16[2].z;
      iVar13 = (int)sVar3;
      iVar9 = (int)slicePos->quadPts16[1].z;
      if ((iVar10 - iVar14) * (iVar15 - iVar16) - (iVar13 - iVar14) * (iVar9 - iVar16) < 1) {
        iVar12 = (int)slicePos->quadPts16[0].x;
        iVar11 = (int)slicePos->quadPts16[0].z;
        if ((iVar12 - iVar10) * (iVar15 - iVar9) - (iVar13 - iVar10) * (iVar11 - iVar9) < 1) {
          iVar9 = (int)slicePos->quadPts16[3].x;
          iVar10 = (int)slicePos->quadPts16[3].z;
          if ((((iVar14 - iVar9) * (iVar15 - iVar10) - (iVar13 - iVar9) * (iVar16 - iVar10) < 1) &&
              ((iVar9 - iVar12) * (iVar15 - iVar11) - (iVar13 - iVar12) * (iVar10 - iVar11) < 1)) &&
             (iVar9 = BworldSm_IsSimQuadValid(slicePos), iVar9 != 0))
          goto LAB_8007f1dc;
        }
      }
      if ((int)slicePos->quad == slicePos->simSlice->quadCount - 1) {
        slicePos->offEdge = '\x02';
        break;
      }
      iVar10 = BworldSm_IsSimQuadValid(slicePos);
      iVar9 = iVar17;
      if (iVar10 != 0) {
        iVar10 = (int)sVar3;
        iVar9 = (int)slicePos->quadPts16[3].x;
        iVar13 = iVar10 - iVar9;
        if (iVar13 < 1) {
          iVar13 = iVar9 - iVar10;
        }
        iVar9 = (int)slicePos->quadPts16[2].x;
        iVar14 = iVar10 - iVar9;
        if (iVar14 < 1) {
          iVar14 = iVar9 - iVar10;
        }
        iVar9 = (int)slicePos->quadPts16[1].x;
        iVar15 = iVar10 - iVar9;
        if (iVar15 < 1) {
          iVar15 = iVar9 - iVar10;
        }
        iVar9 = (int)slicePos->quadPts16[0].x;
        iVar16 = iVar10 - iVar9;
        if (iVar16 < 1) {
          iVar16 = iVar9 - iVar10;
        }
        iVar9 = (int)slicePos->quadPts16[0].z;
        iVar10 = sVar4 - iVar9;
        iVar9 = iVar9 - sVar4;
        if (0 < iVar10) {
          iVar9 = iVar10;
        }
        iVar10 = (int)slicePos->quadPts16[1].z;
        iVar11 = sVar4 - iVar10;
        iVar10 = iVar10 - sVar4;
        if (0 < iVar11) {
          iVar10 = iVar11;
        }
        iVar11 = (int)slicePos->quadPts16[2].z;
        iVar12 = sVar4 - iVar11;
        iVar11 = iVar11 - sVar4;
        if (0 < iVar12) {
          iVar11 = iVar12;
        }
        iVar12 = (int)slicePos->quadPts16[3].z;
        iVar8 = sVar4 - iVar12;
        iVar12 = iVar12 - sVar4;
        if (0 < iVar8) {
          iVar12 = iVar8;
        }
        iVar9 = iVar16 + iVar9 + iVar15 + iVar10 + iVar14 + iVar11 + iVar13 + iVar12;
        if (0x28 < iVar9 - iVar17) break;
      }
      slicePos->quad = slicePos->quad + '\x01';
      BworldSm_UpdateSimQuad(slicePos);
      pTVar5 = slicePos->simSlice;
      iVar17 = iVar9;
    }
    uVar2 = uVar19;
    if ((slicePos->offEdge != '\0') && (iVar18 == 0)) {
      uVar2 = slicePos->simSlice->quadCount;
    }
    slicePos->quad = uVar2 + 0xff;
    if (slicePos->quad < '\0') {
      slicePos->quad = '\0';
    }
    GetFirstStmQuadPts(slicePos,vertices);
    iVar17 = 0x7fffffff;
    while (BworldSm_UpdateSimQuad(slicePos), -1 < slicePos->quad) {
      GetFirstStmQuadPts(slicePos,vertices);
      iVar10 = (int)slicePos->quadPts16[1].x;
      iVar14 = (int)slicePos->quadPts16[2].x;
      iVar15 = (int)sVar4;
      iVar16 = (int)slicePos->quadPts16[2].z;
      iVar13 = (int)sVar3;
      iVar9 = (int)slicePos->quadPts16[1].z;
      if ((iVar10 - iVar14) * (iVar15 - iVar16) - (iVar13 - iVar14) * (iVar9 - iVar16) < 1) {
        iVar12 = (int)slicePos->quadPts16[0].x;
        iVar11 = (int)slicePos->quadPts16[0].z;
        if ((iVar12 - iVar10) * (iVar15 - iVar9) - (iVar13 - iVar10) * (iVar11 - iVar9) < 1) {
          iVar9 = (int)slicePos->quadPts16[3].x;
          iVar10 = (int)slicePos->quadPts16[3].z;
          if ((((iVar14 - iVar9) * (iVar15 - iVar10) - (iVar13 - iVar9) * (iVar16 - iVar10) < 1) &&
              ((iVar9 - iVar12) * (iVar15 - iVar11) - (iVar13 - iVar12) * (iVar10 - iVar11) < 1)) &&
             (iVar9 = BworldSm_IsSimQuadValid(slicePos), iVar9 != 0)) {
LAB_8007f1dc:
            slicePos->rez = '\x02';
            slicePos->offEdge = '\0';
            GetStmQuadPts(slicePos,cp);
            return 1;
          }
        }
      }
      if (slicePos->quad == '\0') {
        slicePos->offEdge = '\x01';
        break;
      }
      iVar10 = BworldSm_IsSimQuadValid(slicePos);
      iVar9 = iVar17;
      if (iVar10 != 0) {
        iVar10 = (int)sVar3;
        iVar9 = (int)slicePos->quadPts16[3].x;
        iVar13 = iVar10 - iVar9;
        if (iVar13 < 1) {
          iVar13 = iVar9 - iVar10;
        }
        iVar9 = (int)slicePos->quadPts16[2].x;
        iVar14 = iVar10 - iVar9;
        if (iVar14 < 1) {
          iVar14 = iVar9 - iVar10;
        }
        iVar9 = (int)slicePos->quadPts16[1].x;
        iVar15 = iVar10 - iVar9;
        if (iVar15 < 1) {
          iVar15 = iVar9 - iVar10;
        }
        iVar9 = (int)slicePos->quadPts16[0].x;
        iVar16 = iVar10 - iVar9;
        if (iVar16 < 1) {
          iVar16 = iVar9 - iVar10;
        }
        iVar9 = (int)slicePos->quadPts16[0].z;
        iVar10 = sVar4 - iVar9;
        iVar9 = iVar9 - sVar4;
        if (0 < iVar10) {
          iVar9 = iVar10;
        }
        iVar10 = (int)slicePos->quadPts16[1].z;
        iVar11 = sVar4 - iVar10;
        iVar10 = iVar10 - sVar4;
        if (0 < iVar11) {
          iVar10 = iVar11;
        }
        iVar11 = (int)slicePos->quadPts16[2].z;
        iVar12 = sVar4 - iVar11;
        iVar11 = iVar11 - sVar4;
        if (0 < iVar12) {
          iVar11 = iVar12;
        }
        iVar12 = (int)slicePos->quadPts16[3].z;
        iVar8 = sVar4 - iVar12;
        iVar12 = iVar12 - sVar4;
        if (0 < iVar8) {
          iVar12 = iVar8;
        }
        iVar9 = iVar16 + iVar9 + iVar15 + iVar10 + iVar14 + iVar11 + iVar13 + iVar12;
        if (0x28 < iVar9 - iVar17) break;
      }
      slicePos->quad = slicePos->quad + -1;
      iVar17 = iVar9;
    }
    if (iVar18 == 0) {
      cVar6 = slicePos->offEdge;
    }
    iVar17 = iVar18 + 0x24;
    iVar9 = (int)slicePos->slice + BWorld_gChunkBuildList[iVar17];
    if (gNumSlices <= iVar9) {
      iVar9 = iVar9 - gNumSlices;
    }
    if (iVar9 < 0) {
      iVar9 = iVar9 + gNumSlices;
    }
    slicePos->slice = (short)iVar9;
    iVar18 = iVar18 + 1;
    iVar20 = iVar20 + BWorld_gChunkBuildList[iVar17];
  } while( true );
}

/* ---- FindClosestQuad__FP8coorddefP12BWorldSm_Pos  [@0x8007f8f8] ---- */
int FindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int startSlice;
  int startQuad;
  int foundSlice;
  static coorddef corrPt;
  int rCount;
  char cVar1;
  short sVar2;
  short sVar3;
  bool bVar4;
  char cVar5;
  int iVar6;
  Trk_NewSimQuad *pTVar7;
  
  sVar2 = slicePos->slice;
  cVar1 = slicePos->quad;
  BWorldSm_FindClosestSlice(pt,slicePos);
  sVar3 = slicePos->slice;
  iVar6 = RawFindClosestQuad(pt,slicePos);
  if (iVar6 == 0) {
    if (slicePos->offEdge != '\0') {
      slicePos->slice = sVar3;
      BWorld_SetSimSlice(slicePos);
      if (slicePos->offEdge == '\x01') {
        cVar5 = '\0';
      }
      else {
        cVar5 = slicePos->simSlice->quadCount + 0xff;
      }
      slicePos->quad = cVar5;
      BworldSm_UpdateSimQuad(slicePos);
      slicePos->rez = '\x02';
      SetStrip(slicePos);
      GetStmQuadPts(slicePos,Chunk_chunkCenters + slicePos->chunk);
    }
    corrPt.x = pt->x;
    corrPt.y = pt->y;
    corrPt.z = pt->z;
    pTVar7 = slicePos->simQuad;
    for (iVar6 = 0; (pTVar7 == (Trk_NewSimQuad *)0x0 && (iVar6 < 10)); iVar6 = iVar6 + 1) {
      corrPt.x = corrPt.x +
                    (*(int *)(slicePos->slice * 0x20 + BWorldSm_slices) - corrPt.x >> 5);
      corrPt.z = corrPt.z +
                    (*(int *)(slicePos->slice * 0x20 + BWorldSm_slices + 8) - corrPt.z >> 5);
      RawFindClosestQuad(&corrPt,slicePos);
      pTVar7 = slicePos->simQuad;
    }
  }
  cVar5 = '\0';
  bVar4 = sVar2 != slicePos->slice;
  slicePos->sliceChanged = bVar4;
  if ((cVar1 != slicePos->quad) || (bVar4)) {
    cVar5 = '\x01';
  }
  slicePos->quadChanged = cVar5;
  return (int)slicePos->sliceChanged;
}

/* ---- BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi  [@0x8007fac4] ---- */
int BWorldSm_FindClosestQuadRez(coorddef *pt,BWorldSm_Pos *slicePos,int hiRezFlag)
{
  bool bVar1;
  int iVar2;
  int iVar3;
  
  slicePos->triangleFlag = '\x03';
  if (hiRezFlag == 0) {
    slicePos->lastRezRequested = '\x01';
    slicePos->rez = '\x01';
    slicePos->simSlice = (Trk_NewSimSlice *)0x0;
    slicePos->simQuad = (Trk_NewSimQuad *)0x0;
    slicePos->quad = -1;
    slicePos->triangleFlag = '\0';
    iVar2 = BWorldSm_FindClosestSlice(pt,slicePos);
  }
  else {
    slicePos->lastRezRequested = '\x02';
    if (slicePos->simQuad != (Trk_NewSimQuad *)0x0) {
      bVar1 = false;
      iVar2 = fixedmult(slicePos->quadPts[1].x - slicePos->quadPts[2].x,
                         pt->z - slicePos->quadPts[2].z);
      iVar3 = fixedmult(pt->x - slicePos->quadPts[2].x,
                         slicePos->quadPts[1].z - slicePos->quadPts[2].z);
      if (iVar2 - iVar3 < 1) {
        iVar2 = fixedmult(slicePos->quadPts[0].x - slicePos->quadPts[1].x,
                           pt->z - slicePos->quadPts[1].z);
        iVar3 = fixedmult(pt->x - slicePos->quadPts[1].x,
                           slicePos->quadPts[0].z - slicePos->quadPts[1].z);
        if (iVar2 - iVar3 < 1) {
          iVar2 = fixedmult(slicePos->quadPts[2].x - slicePos->quadPts[3].x,
                             pt->z - slicePos->quadPts[3].z);
          iVar3 = fixedmult(pt->x - slicePos->quadPts[3].x,
                             slicePos->quadPts[2].z - slicePos->quadPts[3].z);
          if (iVar2 - iVar3 < 1) {
            iVar2 = fixedmult(slicePos->quadPts[3].x - slicePos->quadPts[0].x,
                               pt->z - slicePos->quadPts[0].z);
            iVar3 = fixedmult(pt->x - slicePos->quadPts[0].x,
                               slicePos->quadPts[3].z - slicePos->quadPts[0].z);
            bVar1 = iVar2 - iVar3 < 1;
          }
        }
      }
      if (bVar1) {
        slicePos->quadChanged = '\0';
        slicePos->sliceChanged = '\0';
        return 0;
      }
    }
    iVar2 = FindClosestQuad(pt,slicePos);
  }
  return iVar2;
}

/* ---- BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi  [@0x8007fc90] ---- */
int BWorldSm_FindClosestQuadMaxIterations(coorddef *pt,BWorldSm_Pos *slicePos,int maxIterations)
{
  int iVar1;
  
  iVar1 = BWorldSm_FindClosestQuadRez(pt,slicePos,1);
  return iVar1;
}

/* ---- PointDirection__FP8coorddefN20  [@0x8007fcb0] ---- */
int PointDirection(coorddef *p1,coorddef *p2,coorddef *p3)
{
  int iVar1;
  int iVar2;
  
  iVar1 = fixedmult(p1->x - p2->x,p3->z - p2->z);
  iVar2 = fixedmult(p3->x - p2->x,p1->z - p2->z);
  return iVar1 - iVar2;
}

/* ---- BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi  [@0x8007fd28] ---- */
int BWorldSm_FindEdgeOff(coorddef *pt,BWorldSm_Pos *slicePos1,BWorldSm_Pos *slicePos2,int *heightDiff)
{
  int ret;
  coorddef*pts;
  int y;
  int iVar1;
  u_int uVar2;
  
  iVar1 = PointDirection(slicePos1->quadPts + 2,slicePos1->quadPts + 3,pt);
  uVar2 = iVar1 < -0x18000 ^ 1;
  iVar1 = PointDirection(slicePos1->quadPts + 3,slicePos1->quadPts,pt);
  if (-1 < iVar1) {
    uVar2 = uVar2 | 8;
  }
  iVar1 = PointDirection(slicePos1->quadPts,slicePos1->quadPts + 1,pt);
  if (-0x18001 < iVar1) {
    uVar2 = uVar2 | 2;
  }
  iVar1 = PointDirection(slicePos1->quadPts + 1,slicePos1->quadPts + 2,pt);
  if (-1 < iVar1) {
    uVar2 = uVar2 | 4;
  }
  *heightDiff = (slicePos2->quadPts[0].y + slicePos2->quadPts[1].y + slicePos2->quadPts[2].y +
                 slicePos2->quadPts[3].y >> 2) - pt->y;
  return uVar2;
}

/* ---- BWorldSm_QuadLight__FP12BWorldSm_Pos  [@0x8007fe44] ---- */
int BWorldSm_QuadLight(BWorldSm_Pos *slicePos)
{
  CVECTOR light;
  CVECTOR temp0;
  CVECTOR temp1;
  CVECTOR temp2;
  CVECTOR temp3;
  int topInd;
  int botInd;
  short s1;
  short s2;
  short s3;
  Group *pThis;

  if (slicePos->rez != '\x02') {
    return 0x7f7f7f;
  }
  topInd = (u_int)slicePos->strip->topVert + (int)slicePos->stripQuadInd;
  botInd = (u_int)slicePos->strip->botVert + (int)slicePos->stripQuadInd;
  pThis = Track_chunkList[slicePos->chunk].vertexBuf;
  /* @0x6FEB4 four corner light indices read from the vertex buffer (corner0 signed, s1..s3 unsigned) */
  s1 = *(u_short *)((int)&pThis[topInd * 2 + 2].m_num_elements + 2);
  s2 = *(u_short *)((int)&pThis[botInd * 2 + 2].m_num_elements + 2);
  s3 = *(u_short *)((int)&pThis[botInd * 2 + 4].m_num_elements + 2);
  temp0 = Chunk_lightTable[*(short *)((int)&pThis[topInd * 2 + 4].m_num_elements + 2)];
  temp1 = Chunk_lightTable[s1];
  temp2 = Chunk_lightTable[s2];
  temp3 = Chunk_lightTable[s3];
  /* @0x6FF58 average the 4 corners per channel (>>2); light.cd left as-is (original reads only r/g/b) */
  light.r = (u_char)((temp0.r + temp1.r + temp2.r + temp3.r) >> 2);
  light.g = (u_char)((temp0.g + temp1.g + temp2.g + temp3.g) >> 2);
  light.b = (u_char)((temp0.b + temp1.b + temp2.b + temp3.b) >> 2);
  return *(int *)&light;
}

/* ---- BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos  [@0x8007ffd4] ---- */
void * BWorldSm_TunnelFlagSm(BWorldSm_Pos *slicePos)
{
  int surf;
  u_char bVar1;
  
  if ((*(u_char *)(slicePos->slice * 0x20 + BWorldSm_slices + 0x15) & 0x44) == 0) {
    if (slicePos->simQuad == (Trk_NewSimQuad *)0x0) {
      bVar1 = 0xe;
    }
    else {
      bVar1 = slicePos->simQuad->surface & 0xf;
    }
    return (void *)(u_int)(bVar1 == 8);
  }
  return (void *)0x1;
}

/* ---- NormalCache_AddEntry__FP12BWorldSm_Pos  [@0x8008002c] ---- */
void NormalCache_AddEntry(BWorldSm_Pos *slicePos)
{
  u_long oldestTime;
  int oldestInd;
  tNormalCacheEntry*ce;
  int i;
  tNormalCacheEntry *ptVar1;
  int iVar2;
  u_int uVar3;
  int iVar4;
  int iVar5;
  
  uVar3 = 0xffffffff;
  iVar4 = -1;
  ptVar1 = BWSM_NormalCache;
  iVar2 = 0;
  BWSM_NormalCacheSysTime = BWSM_NormalCacheSysTime + 1;
  do {
    if (ptVar1->accessTime < uVar3) {
      uVar3 = ptVar1->accessTime;
      iVar4 = iVar2;
    }
    iVar2 = iVar2 + 1;
    ptVar1 = ptVar1 + 1;
  } while (iVar2 < 0x10);
  BWSM_NormalCache[iVar4].accessTime = BWSM_NormalCacheSysTime;
  iVar2 = (slicePos->forward).y;
  iVar5 = (slicePos->forward).z;
  BWSM_NormalCache[iVar4].forward.x = (slicePos->forward).x;
  BWSM_NormalCache[iVar4].forward.y = iVar2;
  BWSM_NormalCache[iVar4].forward.z = iVar5;
  iVar2 = (slicePos->normal).y;
  iVar5 = (slicePos->normal).z;
  BWSM_NormalCache[iVar4].normal.x = (slicePos->normal).x;
  BWSM_NormalCache[iVar4].normal.y = iVar2;
  BWSM_NormalCache[iVar4].normal.z = iVar5;
  BWSM_NormalCache[iVar4].sliceInd = slicePos->slice;
  BWSM_NormalCache[iVar4].quadInd = slicePos->quad;
  BWSM_NormalCache[iVar4].triangleFlag = slicePos->triangleFlag;
  return;
}

/* ---- NormalCache_FindEntry__FP12BWorldSm_Pos  [@0x800800e8] ---- */
void * NormalCache_FindEntry(BWorldSm_Pos *slicePos)
{
  tNormalCacheEntry*ce;
  int slice;
  int quad;
  int i;
  u_char *puVar1;
  tNormalCacheEntry *ptVar2;
  int iVar3;
  int iVar4;
  
  ptVar2 = BWSM_NormalCache;
  iVar3 = 0;
  puVar1 = &BWSM_NormalCache[0].triangleFlag;
  BWSM_NormalCacheSysTime = BWSM_NormalCacheSysTime + 1;
  while (((ptVar2->sliceInd != slicePos->slice || (puVar1[1] != slicePos->quad)) ||
         ((u_int)*puVar1 != (int)slicePos->triangleFlag))) {
    puVar1 = puVar1 + 0x20;
    iVar3 = iVar3 + 1;
    ptVar2 = ptVar2 + 1;
    if (0xf < iVar3) {
LAB_80080154:
      if (0xf < iVar3) {
        return (void *)0x0;
      }
      iVar3 = (ptVar2->normal).y;
      iVar4 = (ptVar2->normal).z;
      (slicePos->normal).x = (ptVar2->normal).x;
      (slicePos->normal).y = iVar3;
      (slicePos->normal).z = iVar4;
      iVar3 = (ptVar2->forward).y;
      iVar4 = (ptVar2->forward).z;
      (slicePos->forward).x = (ptVar2->forward).x;
      (slicePos->forward).y = iVar3;
      (slicePos->forward).z = iVar4;
      return (void *)0x1;
    }
  }
  ptVar2->accessTime = BWSM_NormalCacheSysTime;
  goto LAB_80080154;
}

/* ---- NormalCache_Init__Fv  [@0x800801ac] ---- */
void NormalCache_Init(void)
{
  int i;
  tNormalCacheEntry *ptVar1;
  int iVar2;
  
  BWSM_NormalCacheSysTime = 0;
  iVar2 = 0;
  ptVar1 = BWSM_NormalCache;
  do {
    ptVar1->sliceInd = -1;
    ptVar1->quadInd = -1;
    ptVar1->triangleFlag = '\0';
    ptVar1->accessTime = 0;
    iVar2 = iVar2 + 1;
    ptVar1 = ptVar1 + 1;
  } while (iVar2 < 0x10);
  return;
}

/* ---- Check_Rot__FP12BWorldSm_Pos  [@0x800801e8] ---- */
void Check_Rot(BWorldSm_Pos *slicePos)
{
  coorddef vecX;
  coorddef vecZ;
  coorddef*forward;
  coorddef*normal;
  void *pvVar1;
  int iVar2;
  int local_30;
  int local_2c;
  int local_28;
  int local_20;
  int local_1c;
  int local_18;
  
  if (((int)slicePos->simRotFlag != (int)slicePos->triangleFlag) &&
     (pvVar1 = NormalCache_FindEntry(slicePos), pvVar1 != (void *)0x1)) {
    if (slicePos->triangleFlag == '\x03') {
      iVar2 = slicePos->quadPts[1].x - slicePos->quadPts[0].x;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 7;
      }
      local_20 = (slicePos->quadPts[2].x - slicePos->quadPts[3].x) + (iVar2 >> 3);
      iVar2 = slicePos->quadPts[1].y - slicePos->quadPts[0].y;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 7;
      }
      local_1c = (slicePos->quadPts[2].y - slicePos->quadPts[3].y) + (iVar2 >> 3);
      iVar2 = slicePos->quadPts[1].z - slicePos->quadPts[0].z;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 7;
      }
      local_18 = (slicePos->quadPts[2].z - slicePos->quadPts[3].z) + (iVar2 >> 3);
      iVar2 = slicePos->quadPts[1].x - slicePos->quadPts[2].x;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 7;
      }
      local_30 = (slicePos->quadPts[0].x - slicePos->quadPts[3].x) + (iVar2 >> 3);
      iVar2 = slicePos->quadPts[1].y - slicePos->quadPts[2].y;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 7;
      }
      local_2c = (slicePos->quadPts[0].y - slicePos->quadPts[3].y) + (iVar2 >> 3);
      iVar2 = slicePos->quadPts[1].z - slicePos->quadPts[2].z;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 7;
      }
      local_28 = (slicePos->quadPts[0].z - slicePos->quadPts[3].z) + (iVar2 >> 3);
    }
    else if (slicePos->triangleFlag == '\x02') {
      local_20 = slicePos->quadPts[1].x - slicePos->quadPts[0].x;
      local_1c = slicePos->quadPts[1].y - slicePos->quadPts[0].y;
      local_18 = slicePos->quadPts[1].z - slicePos->quadPts[0].z;
      local_30 = slicePos->quadPts[1].x - slicePos->quadPts[2].x;
      local_2c = slicePos->quadPts[1].y - slicePos->quadPts[2].y;
      local_28 = slicePos->quadPts[1].z - slicePos->quadPts[2].z;
    }
    else {
      local_20 = slicePos->quadPts[2].x - slicePos->quadPts[3].x;
      local_1c = slicePos->quadPts[2].y - slicePos->quadPts[3].y;
      local_18 = slicePos->quadPts[2].z - slicePos->quadPts[3].z;
      local_30 = slicePos->quadPts[0].x - slicePos->quadPts[3].x;
      local_2c = slicePos->quadPts[0].y - slicePos->quadPts[3].y;
      local_28 = slicePos->quadPts[0].z - slicePos->quadPts[3].z;
    }
    (slicePos->forward).x = local_20;
    (slicePos->forward).y = local_1c;
    (slicePos->forward).z = local_18;
    crossproduct((coorddef *)&local_20,(coorddef *)&local_30,(coorddef *)&(slicePos->normal).x);
    Math_NormalizeVector(&slicePos->normal);
    if (0xffff < (slicePos->normal).y) {
      (slicePos->normal).y = 0xfff9;
    }
    Math_NormalizeVector(&slicePos->forward);
    NormalCache_AddEntry(slicePos);
  }
  slicePos->simRotFlag = (short)slicePos->triangleFlag;
  return;
}

/* ---- BWorldSm_UNormal__FP12BWorldSm_Pos  [@0x80080520] ---- */
coorddef * BWorldSm_UNormal(BWorldSm_Pos *slicePos)
{
  Check_Rot(slicePos);
  return &slicePos->normal;
}

/* ---- BWorldSm_UForward__FP12BWorldSm_Pos  [@0x80080548] ---- */
coorddef * BWorldSm_UForward(BWorldSm_Pos *slicePos)
{
  Check_Rot(slicePos);
  return &slicePos->forward;
}

/* ---- BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi  [@0x80080570] ---- */
int BWorldSm_FindClosestTriangleRez(coorddef *pt,BWorldSm_Pos *slicePos,int hiRezFlag)
{
  int ret;
  char cVar1;
  int z;
  int iVar2;
  int iVar3;
  int iVar4;
  Trk_NewSimQuad *startsimquad;
  Group *pThis;
  Trk_NewSimSlice *simSlices;
  int simIndex;
  int botInd;
  int cz;
  int cy;
  int cx;
  Trk_NewSlice *slices;
  int y;
  int x;
  int i;
  int currDist;
  int startSlice;
  int attempt;
  int startQuadInd;
  
  iVar2 = BWorldSm_FindClosestQuadRez(pt,slicePos,hiRezFlag);
  if (slicePos->simQuad != (Trk_NewSimQuad *)0x0) {
    iVar3 = fixedmult(slicePos->quadPts[2].x - slicePos->quadPts[0].x,
                       pt->z - slicePos->quadPts[0].z);
    iVar4 = fixedmult(pt->x - slicePos->quadPts[0].x,
                       slicePos->quadPts[2].z - slicePos->quadPts[0].z);
    cVar1 = '\x02';
    if (0 < iVar3 - iVar4) {
      cVar1 = '\x01';
    }
    slicePos->triangleFlag = cVar1;
  }
  return iVar2;
}
