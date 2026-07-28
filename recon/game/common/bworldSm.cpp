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
bool NormalCache_FindEntry(BWorldSm_Pos *slicePos);
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
  
  numSlices = gNumSlices;
  currDist = 0x7fffffff;
  currInd = -1;
  for (i = 0; i < numSlices; i += 8) {
    dist = xzsquaredist32(
        (coorddef *)((char *)BWorldSm_slices + i * 0x20),pt);
    if (dist < currDist) {
      currInd = i;
      currDist = dist;
    }
  }
  slicePos->slice = currInd;
  return;
}

/* ---- BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos  [@0x8007ea14] ---- */
int BWorldSm_FindClosestSlice(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int startSlice;
  bool bVar3;
  int iVar4;
  
  startSlice = slicePos->slice;
  iVar4 = Math_DistXZ((coorddef *)((char *)BWorldSm_slices + startSlice * 0x20),pt);
  if (0x800000 < iVar4) {
    FindAbsClosestSliceCrude(pt,slicePos);
  }
  RawFindClosestSlice(pt,slicePos);
  slicePos->chunk =
      *(u_char *)(slicePos->slice * 0x20 + (char *)BWorldSm_slices + 0x1c);
  bVar3 = slicePos->slice != startSlice;
  slicePos->quadChanged = bVar3;
  slicePos->sliceChanged = bVar3;
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
        iVar2 = pt->x;
      }
      piVar5 = (int *)(iVar7 * 0x20 + (char *)BWorldSm_slices);
      iVar7 = iVar2 - *piVar5 >> 9;
      iVar2 = pt->z - piVar5[2] >> 9;
      iVar2 = iVar7 * iVar7 + iVar2 * iVar2;
      if (iVar8 < gNumSlices + -2) {
        iVar6 = iVar8 * 0x20 + (char *)BWorldSm_slices;
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
            piVar5 = (int *)((iVar6 % gNumSlices) * 0x20 + (char *)BWorldSm_slices);
            iVar3 = pt->x - *piVar5 >> 9;
            iVar4 = pt->z - piVar5[2] >> 9;
            if (iVar3 * iVar3 + iVar4 * iVar4 < iVar2) {
              iVar7 = iVar6;
            }
            iVar2 = iVar7 + 1 + iVar9;
            iVar7 = iVar2 % gNumSlices;
          }
          else {
            iVar7 = iVar8 * 0x20 + (char *)BWorldSm_slices;
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
        piVar5 = (int *)(iVar7 * 0x20 + (char *)BWorldSm_slices);
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

  i = 0;
  maxIndex = (u_int)slicePos->simSlice->stripIndex;
  slicePos->strip = (Trk_NewStrip *)(Track_chunkList[slicePos->chunk].stripBuf + 1);
  if (maxIndex != 0) {
    do {
      i = i + 1;
      slicePos->strip =
           (Trk_NewStrip *)
           (&slicePos->strip[1].topVert + (u_int)(u_char)slicePos->strip->quadCount * 2);
    } while (i < maxIndex);
  }
  i = (int)(signed char)slicePos->quad;
  quadCount = (u_int)(u_char)slicePos->strip->quadCount;
  while (quadCount <= i) {
    i = i - quadCount;
    slicePos->strip =
         (Trk_NewStrip *)(&slicePos->strip[1].topVert + quadCount * 2);
    quadCount = (u_int)(u_char)slicePos->strip->quadCount;
  }
  slicePos->stripQuadInd = (short)i;
  return;
}

/* ---- GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16  [@0x8007ef98] ---- */
void GetFirstStmQuadPts(BWorldSm_Pos *slicePos,CCOORD16 *vertices)
{
  CCOORD16 *pts;
  Trk_NewStrip *pStrip;
  int topInd;
  int botInd;
  short x;
  short z;
  
  SetStrip(slicePos);
  pts = slicePos->quadPts16;
  pStrip = slicePos->strip;
  topInd = (u_int)pStrip->topVert + slicePos->stripQuadInd;
  botInd = (u_int)pStrip->botVert + slicePos->stripQuadInd;

  x = vertices[topInd + 1].x;
  z = vertices[topInd + 1].z;
  pts[1].x = x;
  pts[1].z = z;
  x = vertices[topInd].x;
  z = vertices[topInd].z;
  pts[2].x = x;
  pts[2].z = z;

  x = vertices[botInd].x;
  z = vertices[botInd].z;
  pts[3].x = x;
  pts[3].z = z;
  x = vertices[botInd + 1].x;
  z = vertices[botInd + 1].z;
  pts[0].x = x;
  pts[0].z = z;
  return;
}

/* ---- BWorld_SetSimSlice__FP12BWorldSm_Pos  [@0x8007f034] ---- */
void BWorld_SetSimSlice(BWorldSm_Pos *slicePos)
{
  Trk_NewSimSlice *simSlices;
  int chunkSliceInd;

  slicePos->chunk =
      *(u_char *)(slicePos->slice * 0x20 + (char *)BWorldSm_slices + 0x1c);
  simSlices = (Trk_NewSimSlice *)
      ((char *)Track_chunkList[slicePos->chunk].simSliceBuf + 4);
  chunkSliceInd =
      (int)slicePos->slice -
      (int)Track_chunkList[slicePos->chunk].firstSimSliceInd;
  slicePos->simSlice = &simSlices[chunkSliceInd];
  return;
}

/* ---- BworldSm_UpdateSimQuad__FP12BWorldSm_Pos  [@0x8007f094] ---- */
void BworldSm_UpdateSimQuad(BWorldSm_Pos *slicePos)
{
  Trk_NewSimSlice *pTVar2;
  int iVar3;
  int simIndex;
  Trk_NewSimQuad*startsimquad;
  Group *pGVar1;

  pTVar2 = slicePos->simSlice;
  iVar3 = (int)(signed char)slicePos->quad - (u_int)pTVar2->simquadStartIndex;
  slicePos->simSlice++;   /* @codegen-device: net-zero pair forces pTVar2 into oracle's a1
                              (permuter-derived; do NOT simplify away, see verify_asm) */
  slicePos->simSlice--;
  if ((-1 < iVar3) && (iVar3 < (int)(u_int)pTVar2->simquadCount)) {
    pGVar1 = Track_chunkList[slicePos->chunk].simQuadBuf;
    startsimquad = (Trk_NewSimQuad *)(pGVar1 + 1);
    slicePos->simQuad = startsimquad;
    simIndex = (u_int)slicePos->simSlice->simquadIndex + iVar3;  /* MATCH: re-read via slicePos (cse -> addu v0,a1 copy), not pTVar2 direct */
    slicePos->simQuad = (Trk_NewSimQuad *)((int)startsimquad + simIndex);
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
/* JEB/IDA plus the SLD local map recover the retail 64-byte frame and saved
   registers (pt=fp, slicePos=s0, attempt=s3, cp=s4, startQuadInd=s5,
   sliceVariance=s6, firstSliceOffEdge=s7, vertices=s2, lastDist=s1).
   Direct coordinate expressions are significant: they preserve the original
   short-lived v0/v1/a0-a3 allocation across both distance scans. */
int RawFindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int attempt;
  int startQuadInd;
  static int sliceOffs[12];
  int sliceVariance;
  coorddef *cp;
  CCOORD16 *vertices;
  CCOORD16 pt16;
  int dist;
  int lastDist;
  int firstSliceOffEdge;
  int iVar9;
  int iVar10;
  int iVar13;
  int iVar14;
  int iVar15;
  int iVar16;
  int pointZ;
  
  attempt = 0;
  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  slicePos->simRotFlag = 0;
  BWorld_SetSimSlice(slicePos);
  sliceVariance = 0;
  {
    int currentQuad;

    currentQuad = (int)(signed char)slicePos->quad;
    if ((0 <= currentQuad) &&
        (currentQuad < (int)(slicePos->simSlice->quadCount - 1)) &&
        ((signed char)slicePos->offEdge == 0)) {
      startQuadInd = currentQuad;
      firstSliceOffEdge = 0;
    }
    else {
      slicePos->quad =
          (char)((int)(slicePos->simSlice->quadCount - 1) / 2);
      startQuadInd = (int)(signed char)slicePos->quad;
      firstSliceOffEdge = 0;
    }
  }
  slicePos->offEdge = '\0';
  slicePos->quad = (char)startQuadInd;
  while (attempt < gMaxFindQuadSliceIterations) {
    BWorld_SetSimSlice(slicePos);
    slicePos->quad = (char)startQuadInd;
    if ((int)(slicePos->simSlice->quadCount - 1) < startQuadInd) {
      slicePos->quad = slicePos->simSlice->quadCount - 2;
    }
    cp = Chunk_chunkCenters + slicePos->chunk;
    pt16.x = (short)(pt->x - cp->x >> 10);
    pt16.z = (short)(pt->z - cp->z >> 10);
    vertices = (CCOORD16 *)(Track_chunkList[slicePos->chunk].vertexBuf + 1);
    GetFirstStmQuadPts(slicePos,vertices);
    BworldSm_UpdateSimQuad(slicePos);
    lastDist = 0x7fffffff;
    while ((int)(signed char)slicePos->quad <=
           (int)(slicePos->simSlice->quadCount - 1)) {
      GetFirstStmQuadPts(slicePos,vertices);
      if ((((int)slicePos->quadPts16[1].x -
            (int)slicePos->quadPts16[2].x) *
               ((int)pt16.z - (int)slicePos->quadPts16[2].z) -
           ((int)pt16.x - (int)slicePos->quadPts16[2].x) *
               ((int)slicePos->quadPts16[1].z -
                (int)slicePos->quadPts16[2].z) < 1) &&
          (((int)slicePos->quadPts16[0].x -
            (int)slicePos->quadPts16[1].x) *
               ((int)pt16.z - (int)slicePos->quadPts16[1].z) -
           ((int)pt16.x - (int)slicePos->quadPts16[1].x) *
               ((int)slicePos->quadPts16[0].z -
                (int)slicePos->quadPts16[1].z) < 1) &&
          (((int)slicePos->quadPts16[2].x -
            (int)slicePos->quadPts16[3].x) *
               ((int)pt16.z - (int)slicePos->quadPts16[3].z) -
           ((int)pt16.x - (int)slicePos->quadPts16[3].x) *
               ((int)slicePos->quadPts16[2].z -
                (int)slicePos->quadPts16[3].z) < 1) &&
          (((int)slicePos->quadPts16[3].x -
            (int)slicePos->quadPts16[0].x) *
               ((int)pt16.z - (int)slicePos->quadPts16[0].z) -
           ((int)pt16.x - (int)slicePos->quadPts16[0].x) *
               ((int)slicePos->quadPts16[3].z -
                (int)slicePos->quadPts16[0].z) < 1) &&
          BworldSm_IsSimQuadValid(slicePos)) {
LAB_8007f1dc:
        slicePos->rez = '\x02';
        slicePos->offEdge = '\0';
        GetStmQuadPts(slicePos,cp);
        return 1;
      }
      if ((int)(signed char)slicePos->quad ==
          slicePos->simSlice->quadCount - 1) {
        slicePos->offEdge = '\x02';
        break;
      }
      if (BworldSm_IsSimQuadValid(slicePos)) {
        iVar13 = (int)pt16.x -
                 (int)slicePos->quadPts16[3].x;
        if (iVar13 < 1) {
          iVar13 = (int)slicePos->quadPts16[3].x -
                   (int)pt16.x;
        }
        iVar14 = (int)pt16.x -
                 (int)slicePos->quadPts16[2].x;
        if (iVar14 < 1) {
          iVar14 = (int)slicePos->quadPts16[2].x -
                   (int)pt16.x;
        }
        iVar15 = (int)pt16.x -
                 (int)slicePos->quadPts16[1].x;
        if (iVar15 < 1) {
          iVar15 = (int)slicePos->quadPts16[1].x -
                   (int)pt16.x;
        }
        iVar16 = (int)pt16.x -
                 (int)slicePos->quadPts16[0].x;
        if (iVar16 < 1) {
          iVar16 = (int)slicePos->quadPts16[0].x -
                   (int)pt16.x;
        }
        pointZ = (int)pt16.z;
        iVar9 = pointZ -
                (int)slicePos->quadPts16[0].z;
        iVar10 = (int)slicePos->quadPts16[0].z -
                 pointZ;
        if (0 < iVar9) {
          iVar16 = iVar16 + iVar9;
        }
        else {
          iVar16 = iVar16 + iVar10;
        }
        pointZ = (int)pt16.z;
        iVar9 = pointZ -
                (int)slicePos->quadPts16[1].z;
        iVar10 = (int)slicePos->quadPts16[1].z -
                 pointZ;
        if (0 < iVar9) {
          iVar9 = iVar15 + iVar9;
        }
        else {
          iVar9 = iVar15 + iVar10;
        }
        iVar16 = iVar16 + iVar9;
        pointZ = (int)pt16.z;
        iVar9 = pointZ -
                (int)slicePos->quadPts16[2].z;
        iVar10 = (int)slicePos->quadPts16[2].z -
                 pointZ;
        iVar16 =
            iVar16 + (iVar14 +
                      ((0 < iVar9) ? iVar9 : iVar10));
        pointZ = (int)pt16.z;
        iVar9 = pointZ -
                (int)slicePos->quadPts16[3].z;
        iVar10 = (int)slicePos->quadPts16[3].z -
                 pointZ;
        dist =
            iVar16 + (iVar13 +
                      ((0 < iVar9) ? iVar9 : iVar10));
        if (0x28 < dist - lastDist) break;
        lastDist = dist;
      }
      slicePos->quad = slicePos->quad + '\x01';
      BworldSm_UpdateSimQuad(slicePos);
    }
    lastDist = 0x7fffffff;
    if (((signed char)slicePos->offEdge != 0) && (attempt == 0)) {
      slicePos->quad = slicePos->simSlice->quadCount - 1;
    }
    else {
      slicePos->quad = (char)(startQuadInd - 1);
    }
    if ((signed char)slicePos->quad < 0) {
      slicePos->quad = '\0';
    }
    GetFirstStmQuadPts(slicePos,vertices);
    goto LAB_8007f5c8;
    do {
      GetFirstStmQuadPts(slicePos,vertices);
      if ((((int)slicePos->quadPts16[1].x -
            (int)slicePos->quadPts16[2].x) *
               ((int)pt16.z - (int)slicePos->quadPts16[2].z) -
           ((int)pt16.x - (int)slicePos->quadPts16[2].x) *
               ((int)slicePos->quadPts16[1].z -
                (int)slicePos->quadPts16[2].z) < 1) &&
          (((int)slicePos->quadPts16[0].x -
            (int)slicePos->quadPts16[1].x) *
               ((int)pt16.z - (int)slicePos->quadPts16[1].z) -
           ((int)pt16.x - (int)slicePos->quadPts16[1].x) *
               ((int)slicePos->quadPts16[0].z -
                (int)slicePos->quadPts16[1].z) < 1) &&
          (((int)slicePos->quadPts16[2].x -
            (int)slicePos->quadPts16[3].x) *
               ((int)pt16.z - (int)slicePos->quadPts16[3].z) -
           ((int)pt16.x - (int)slicePos->quadPts16[3].x) *
               ((int)slicePos->quadPts16[2].z -
                (int)slicePos->quadPts16[3].z) < 1) &&
          (((int)slicePos->quadPts16[3].x -
            (int)slicePos->quadPts16[0].x) *
               ((int)pt16.z - (int)slicePos->quadPts16[0].z) -
           ((int)pt16.x - (int)slicePos->quadPts16[0].x) *
               ((int)slicePos->quadPts16[3].z -
                (int)slicePos->quadPts16[0].z) < 1) &&
          BworldSm_IsSimQuadValid(slicePos))
        goto LAB_8007f1dc;
      if ((signed char)slicePos->quad == 0) {
        slicePos->offEdge = '\x01';
        break;
      }
      if (BworldSm_IsSimQuadValid(slicePos)) {
        iVar13 = (int)pt16.x -
                 (int)slicePos->quadPts16[3].x;
        if (iVar13 < 1) {
          iVar13 = (int)slicePos->quadPts16[3].x -
                   (int)pt16.x;
        }
        iVar14 = (int)pt16.x -
                 (int)slicePos->quadPts16[2].x;
        if (iVar14 < 1) {
          iVar14 = (int)slicePos->quadPts16[2].x -
                   (int)pt16.x;
        }
        iVar15 = (int)pt16.x -
                 (int)slicePos->quadPts16[1].x;
        if (iVar15 < 1) {
          iVar15 = (int)slicePos->quadPts16[1].x -
                   (int)pt16.x;
        }
        iVar16 = (int)pt16.x -
                 (int)slicePos->quadPts16[0].x;
        if (iVar16 < 1) {
          iVar16 = (int)slicePos->quadPts16[0].x -
                   (int)pt16.x;
        }
        pointZ = (int)pt16.z;
        iVar9 = pointZ -
                (int)slicePos->quadPts16[0].z;
        iVar10 = (int)slicePos->quadPts16[0].z -
                 pointZ;
        if (0 < iVar9) {
          iVar16 = iVar16 + iVar9;
        }
        else {
          iVar16 = iVar16 + iVar10;
        }
        pointZ = (int)pt16.z;
        iVar9 = pointZ -
                (int)slicePos->quadPts16[1].z;
        iVar10 = (int)slicePos->quadPts16[1].z -
                 pointZ;
        if (0 < iVar9) {
          iVar9 = iVar15 + iVar9;
        }
        else {
          iVar9 = iVar15 + iVar10;
        }
        iVar16 = iVar16 + iVar9;
        pointZ = (int)pt16.z;
        iVar9 = pointZ -
                (int)slicePos->quadPts16[2].z;
        iVar10 = (int)slicePos->quadPts16[2].z -
                 pointZ;
        iVar16 =
            iVar16 + (iVar14 +
                      ((0 < iVar9) ? iVar9 : iVar10));
        pointZ = (int)pt16.z;
        iVar9 = pointZ -
                (int)slicePos->quadPts16[3].z;
        iVar10 = (int)slicePos->quadPts16[3].z -
                 pointZ;
        dist =
            iVar16 + (iVar13 +
                      ((0 < iVar9) ? iVar9 : iVar10));
        if (0x28 < dist - lastDist) break;
        lastDist = dist;
      }
      slicePos->quad = slicePos->quad + -1;
LAB_8007f5c8:
      BworldSm_UpdateSimQuad(slicePos);
    } while (-1 < (signed char)slicePos->quad);
    if (attempt == 0) {
      firstSliceOffEdge = (int)(signed char)slicePos->offEdge;
    }
    {
      int newSlice;
      int numSlices;

      newSlice = (int)slicePos->slice + sliceOffs[attempt];
      numSlices = gNumSlices;
      if (numSlices <= newSlice) {
        newSlice = newSlice - numSlices;
      }
      if (newSlice < 0) {
        newSlice = newSlice + numSlices;
      }
      slicePos->slice = (short)newSlice;
    }
    sliceVariance = sliceVariance + sliceOffs[attempt];
    attempt = attempt + 1;
  }
  {
    int newSlice;
    int numSlices;

    newSlice = (int)slicePos->slice - sliceVariance;
    numSlices = gNumSlices;
    if (numSlices <= newSlice) {
      newSlice = newSlice - numSlices;
    }
    if (newSlice < 0) {
      newSlice = newSlice + numSlices;
    }
    slicePos->slice = (short)newSlice;
  }
  BWorld_SetSimSlice(slicePos);
  slicePos->offEdge = (char)firstSliceOffEdge;
  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  slicePos->triangleFlag = '\0';
  return 0;
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
                    (*(int *)(slicePos->slice * 0x20 + (char *)BWorldSm_slices) - corrPt.x >> 5);
      corrPt.z = corrPt.z +
                    (*(int *)(slicePos->slice * 0x20 + (char *)BWorldSm_slices + 8) - corrPt.z >> 5);
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
  u_long surfVal;
  u_char bVar1;

  if ((*(u_char *)(slicePos->slice * 0x20 + (char *)BWorldSm_slices + 0x15) & 0x44) != 0) {
    return (void *)0x1;
  }
  if (slicePos->simQuad != (Trk_NewSimQuad *)0x0) {
    surfVal = slicePos->simQuad->surface;
    bVar1 = surfVal & 0xf;
  }
  else {
    bVar1 = 0xe;
  }
  return (void *)(u_int)((bVar1 ^ 8) < 1);
}

/* ---- NormalCache_AddEntry__FP12BWorldSm_Pos  [@0x8008002c] ---- */
void NormalCache_AddEntry(BWorldSm_Pos *slicePos)
{
  u_long oldestTime;
  int oldestInd;
  tNormalCacheEntry *ce;

  oldestTime = 0xffffffff;
  oldestInd = -1;
  ce = BWSM_NormalCache;
  BWSM_NormalCacheSysTime = BWSM_NormalCacheSysTime + 1;
  {
    int i;

    i = 0;
    do {
      if (ce->accessTime < oldestTime) {
        oldestInd = i;
        oldestTime = ce->accessTime;
      }
      i = i + 1;
      ce = ce + 1;
    } while (i < 0x10);
  }
  ce = BWSM_NormalCache + oldestInd;
  ce->accessTime = BWSM_NormalCacheSysTime;
  ce->forward = slicePos->forward;
  ce->normal = slicePos->normal;
  ce->sliceInd = slicePos->slice;
  ce->quadInd = slicePos->quad;
  ce->triangleFlag = slicePos->triangleFlag;
  return;
}

/* ---- NormalCache_FindEntry__FP12BWorldSm_Pos  [@0x800800e8] ---- */
/* NEAR-MISS 3 diffs (50/49 insns), reduced from 4. Forming the byte-field
 * cursor in two steps keeps the relocation anchored at BWSM_NormalCache and
 * preserves IDA/SLD's ce=$a2, flags=$a1 allocation. The remaining difference
 * is one redundant base copy before the +2 adjustment. */
bool NormalCache_FindEntry(BWorldSm_Pos *slicePos)
{
  u_char *cacheFlags;
  tNormalCacheEntry *ce;
  int slice;
  int quad;
  int i;

  cacheFlags = (u_char *)BWSM_NormalCache;
  cacheFlags = cacheFlags + 2;
  ce = BWSM_NormalCache;
  i = 0;
  BWSM_NormalCacheSysTime = BWSM_NormalCacheSysTime + 1;
  slice = slicePos->slice;
  quad = *(signed char *)&slicePos->quad;
searchCache:
  if (ce->sliceInd != slice) goto nextCacheEntry;
  if (*(signed char *)&cacheFlags[1] != quad) goto nextCacheEntry;
  if ((u_int)*cacheFlags ==
      (int)*(signed char *)&slicePos->triangleFlag) goto cacheHit;
nextCacheEntry:
  cacheFlags = cacheFlags + sizeof(tNormalCacheEntry);
  i = i + 1;
  ce = ce + 1;
  if (i < 0x10) goto searchCache;
searchDone:
  if (i < 0x10) goto copyCacheEntry;
  return false;
cacheHit:
  ce->accessTime = BWSM_NormalCacheSysTime;
  goto searchDone;
copyCacheEntry:
  slicePos->normal = ce->normal;
  slicePos->forward = ce->forward;
  return true;
}

/* ---- NormalCache_Init__Fv  [@0x800801ac] ---- */
void NormalCache_Init(void)
{
  int i;
  int invalid;
  
  BWSM_NormalCacheSysTime = 0;
  i = 0;
  invalid = -1;
  do {
    BWSM_NormalCache[i].sliceInd = invalid;
    BWSM_NormalCache[i].quadInd = invalid;
    BWSM_NormalCache[i].triangleFlag = '\0';
    BWSM_NormalCache[i].accessTime = 0;
    i++;
  } while (i < 0x10);
  return;
}

/* ---- Check_Rot__FP12BWorldSm_Pos  [@0x800801e8] ---- */
void Check_Rot(BWorldSm_Pos *slicePos)
{
  coorddef vecX;
  coorddef vecZ;
  
  if (slicePos->simRotFlag != (signed char)slicePos->triangleFlag) {
    if (!NormalCache_FindEntry(slicePos)) {
      if ((signed char)slicePos->triangleFlag == 3) {
        vecZ.x = slicePos->quadPts[2].x - slicePos->quadPts[3].x;
        vecZ.x += (slicePos->quadPts[1].x - slicePos->quadPts[0].x) / 8;
        vecZ.y = slicePos->quadPts[2].y - slicePos->quadPts[3].y;
        vecZ.y += (slicePos->quadPts[1].y - slicePos->quadPts[0].y) / 8;
        vecZ.z = slicePos->quadPts[2].z - slicePos->quadPts[3].z;
        vecZ.z += (slicePos->quadPts[1].z - slicePos->quadPts[0].z) / 8;
        vecX.x = slicePos->quadPts[0].x - slicePos->quadPts[3].x;
        vecX.x += (slicePos->quadPts[1].x - slicePos->quadPts[2].x) / 8;
        vecX.y = slicePos->quadPts[0].y - slicePos->quadPts[3].y;
        vecX.y += (slicePos->quadPts[1].y - slicePos->quadPts[2].y) / 8;
        vecX.z = slicePos->quadPts[0].z - slicePos->quadPts[3].z;
        vecX.z += (slicePos->quadPts[1].z - slicePos->quadPts[2].z) / 8;
      }
      else if ((signed char)slicePos->triangleFlag == 2) {
        vecZ.x = slicePos->quadPts[1].x - slicePos->quadPts[0].x;
        vecZ.y = slicePos->quadPts[1].y - slicePos->quadPts[0].y;
        vecZ.z = slicePos->quadPts[1].z - slicePos->quadPts[0].z;
        vecX.x = slicePos->quadPts[1].x - slicePos->quadPts[2].x;
        vecX.y = slicePos->quadPts[1].y - slicePos->quadPts[2].y;
        vecX.z = slicePos->quadPts[1].z - slicePos->quadPts[2].z;
      }
      else {
        vecZ.x = slicePos->quadPts[2].x - slicePos->quadPts[3].x;
        vecZ.y = slicePos->quadPts[2].y - slicePos->quadPts[3].y;
        vecZ.z = slicePos->quadPts[2].z - slicePos->quadPts[3].z;
        vecX.x = slicePos->quadPts[0].x - slicePos->quadPts[3].x;
        vecX.y = slicePos->quadPts[0].y - slicePos->quadPts[3].y;
        vecX.z = slicePos->quadPts[0].z - slicePos->quadPts[3].z;
      }
      {
        coorddef *forward = &slicePos->forward;
        coorddef *normal = &slicePos->normal;
        *forward = vecZ;
        crossproduct(&vecZ,&vecX,normal);
        Math_NormalizeVector(normal);
        if (normal->y > 0xffff) {
          normal->y = 0xfff9;
        }
        Math_NormalizeVector(forward);
        NormalCache_AddEntry(slicePos);
      }
    }
  }
  slicePos->simRotFlag = (signed char)slicePos->triangleFlag;
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
    slicePos->triangleFlag = 0 < iVar3 - iVar4 ? 1 : 2;
  }
  return iVar2;
}
