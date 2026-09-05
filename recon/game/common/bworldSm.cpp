/* game/common/bworldSm.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworldSm.obj (GAME\COMMON\bworldSm.cpp) = 28 fns: simplified BWorld road-follower
 *   (slice/quad/triangle finding, normal cache, sim-quad update). SYM-v3 locals; self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "bworldSm_types.h"
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
bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *slicePos);
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
  /* ORIGINAL-NAME-RECOVERED: sliceChanged -- `sliceChanged` comes from the symbol-bearing
   * NFS2 BWorldSm_FindClosestSlice, where the same comparison result feeds the
   * two change fields and the return. Repeating the comparison directly grows
   * NFS4 from 39 to 45 instructions with 40 oracle diffs. */
  int sliceChanged;

  startSlice = slicePos->slice;
  if (0x800000 <
      Math_DistXZ((coorddef *)((char *)BWorldSm_slices + startSlice * 0x20),pt)) {
    FindAbsClosestSliceCrude(pt,slicePos);
  }
  RawFindClosestSlice(pt,slicePos);
  slicePos->chunk =
      *(u_char *)(slicePos->slice * 0x20 + (char *)BWorldSm_slices + 0x1c);
  sliceChanged = slicePos->slice != startSlice;
  slicePos->quadChanged = sliceChanged;
  slicePos->sliceChanged = sliceChanged;
  return sliceChanged;
}

/* ---- RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos  [@0x8007eab0] ---- */
static inline int closeXZDistSquared(Trk_NewSlice *slice,coorddef *pt)
{
  return (((pt->x - slice->center[0]) >> 9) *
          ((pt->x - slice->center[0]) >> 9)) +
         (((pt->z - slice->center[2]) >> 9) *
          ((pt->z - slice->center[2]) >> 9));
}

void RawFindClosestSlice(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int lastind;
  int maxind;
  int index;
  int distcurr;
  int distnext;
  int distprev;
  Trk_NewSlice *slices;

  lastind = -1;
  maxind = gNumSlices - 1;
  index = slicePos->slice;
  slices = BWorldSm_slices;

  if (index != lastind) {
    do {
      lastind = index;

      if (index < maxind) {
        distcurr = closeXZDistSquared(slices + index,pt);
      }
      else {
        distcurr = closeXZDistSquared(slices + index % (maxind + 1),pt);
      }

      if (index < maxind - 1) {
        distnext =
            (((pt->x - slices[index + 1].center[0]) >> 9) *
             ((pt->x - slices[index + 1].center[0]) >> 9)) +
            (((pt->z - slices[index + 1].center[2]) >> 9) *
             ((pt->z - slices[index + 1].center[2]) >> 9));
        if (distnext < distcurr) {
          index++;
          continue;
        }
      }
      else {
        distnext =
            closeXZDistSquared(slices + (index + 1) % (maxind + 1),pt);
        if (distnext < distcurr) {
          index++;
          index %= maxind + 1;
          continue;
        }
      }

      if (index > 0) {
        distprev =
            (((pt->x - slices[index - 1].center[0]) >> 9) *
             ((pt->x - slices[index - 1].center[0]) >> 9)) +
            (((pt->z - slices[index - 1].center[2]) >> 9) *
             ((pt->z - slices[index - 1].center[2]) >> 9));
        if (distprev < distcurr) {
          index--;
        }
      }
      else {
        index += maxind + 1;
        distprev =
            closeXZDistSquared(slices + (index - 1) % (maxind + 1),pt);
        if (distprev < distcurr) {
          index--;
        }
        index += maxind + 1;
        index %= maxind + 1;
      }
    } while (lastind != index);
  }
  slicePos->slice = (short)index;
  return;
}

/* ---- BWorldSm_SetSlice__FiP12BWorldSm_Pos  [@0x8007ed64] ---- */
void BWorldSm_SetSlice(int slice,BWorldSm_Pos *slicePos)
{
  /* SLD statement order is source-significant here: lines 263, 266-271,
   * 273, and 275-278 place the pointer resets before the change flags and
   * the direct chunk assignment before the final status bytes.  With that
   * order GCC hoists the chunkIndex load exactly as retail; no unrecorded
   * source local is required. */
  slicePos->slice = (short)slice;
  slicePos->simSlice = (Trk_NewSimSlice *)0x0;
  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  slicePos->simRotFlag = 0;
  slicePos->sliceChanged = '\0';
  slicePos->quadChanged = '\0';
  slicePos->offEdge = '\0';
  slicePos->chunk = BWorldSm_slices[slicePos->slice].chunkIndex;
  *(signed char *)&slicePos->lastRezRequested = -2;
  slicePos->rez = '\x01';
  slicePos->triangleFlag = '\0';
  *(signed char *)&slicePos->quad = -1;
  return;
}

/* ---- GetStmQuadPts__FP12BWorldSm_PosP8coorddef  [@0x8007edb8] ---- */
void GetStmQuadPts(BWorldSm_Pos *slicePos,coorddef *cp)
{
  Trk_NewStrip *pStrip;
  coorddef *pts;
  /* ORIGINAL-NAME-RECOVERED: vertices -- the symbol-bearing NFS2 GetStmQuadPts names this
   * same cached geometry-vertex base `vertices`.  Expanding the GetData/index
   * expression at each use compiles to 101 instructions and 119 oracle diffs.
   * This cached result preserves the exact 74-instruction coordinate-load
   * schedule; SYM still records the inlined member receiver separately. */
  CCOORD16 *vertices;
  int cx;
  int cy;
  int cz;
  int topInd;
  int botInd;
  int x;
  int y;
  int z;

  pStrip = slicePos->strip;
  vertices = (CCOORD16 *)
    Track_chunkList[slicePos->chunk].vertexBuf->GetData();
  cx = cp->x;
  cy = cp->y;
  cz = cp->z;
  topInd = (u_int)pStrip->topVert;
  botInd = (u_int)pStrip->botVert;
  topInd += (int)slicePos->stripQuadInd;
  botInd += (int)slicePos->stripQuadInd;
  pts = slicePos->quadPts;

  x = cx + ((int)vertices[topInd + 1].x << 10);
  y = cy + ((int)vertices[topInd + 1].y << 10);
  z = cz + ((int)vertices[topInd + 1].z << 10);
  pts[1].x = x;
  pts[1].y = y;
  pts[1].z = z;

  x = cx + ((int)vertices[topInd].x << 10);
  y = cy + ((int)vertices[topInd].y << 10);
  z = cz + ((int)vertices[topInd].z << 10);
  pts[2].x = x;
  pts[2].y = y;
  pts[2].z = z;

  x = cx + ((int)vertices[botInd].x << 10);
  y = cy + ((int)vertices[botInd].y << 10);
  z = cz + ((int)vertices[botInd].z << 10);
  pts[3].x = x;
  pts[3].y = y;
  pts[3].z = z;

  x = cx + ((int)vertices[botInd + 1].x << 10);
  y = cy + ((int)vertices[botInd + 1].y << 10);
  z = cz + ((int)vertices[botInd + 1].z << 10);
  pts[0].x = x;
  pts[0].y = y;
  pts[0].z = z;
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
  /* SYM/SLD records exactly this function-scope `simIndex` in $a2 and the
     nested line-6 `startsimquad`.  Grouping the final offset as
     startsimquad + (simquadIndex + simIndex) preserves that allocation; no
     decompiler-only delta temporary is part of the source. */
  int simIndex;

  simIndex = (int)(signed char)slicePos->quad -
             (u_int)slicePos->simSlice->simquadStartIndex;
  if ((-1 < simIndex) &&
      (simIndex < (int)(u_int)slicePos->simSlice->simquadCount)) {
    Trk_NewSimQuad *startsimquad;

    startsimquad = (Trk_NewSimQuad *)
        (Track_chunkList[slicePos->chunk].simQuadBuf + 1);
    slicePos->simQuad = startsimquad;
    slicePos->simQuad = (Trk_NewSimQuad *)
        ((int)startsimquad +
         ((u_int)slicePos->simSlice->simquadIndex + simIndex));
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
#define RAW_QUAD_ABS(value) ((0 < (value)) ? (value) : -(value))
#define RAW_QUAD_POINT_DIST(point, quadPoint) \
  (RAW_QUAD_ABS((int)(point).x - (int)(quadPoint).x) + \
   RAW_QUAD_ABS((int)(point).z - (int)(quadPoint).z))
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
  
  attempt = 0;
  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  slicePos->simRotFlag = 0;
  BWorld_SetSimSlice(slicePos);
  sliceVariance = 0;
  {
    if ((0 <= (int)(signed char)slicePos->quad) &&
        ((int)(signed char)slicePos->quad <
         (int)(slicePos->simSlice->quadCount - 1)) &&
        ((signed char)slicePos->offEdge == 0)) {
      startQuadInd = (int)(signed char)slicePos->quad;
    }
    else {
      slicePos->quad =
          (char)((int)(slicePos->simSlice->quadCount - 1) / 2);
      startQuadInd = (int)(signed char)slicePos->quad;
    }
  }
  firstSliceOffEdge = 0;
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
    lastDist = 0x7fffffff;
    vertices = (CCOORD16 *)(Track_chunkList[slicePos->chunk].vertexBuf + 1);
    GetFirstStmQuadPts(slicePos,vertices);
    BworldSm_UpdateSimQuad(slicePos);
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
        dist =
            RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[0]) +
            RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[1]) +
            RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[2]) +
            RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[3]);
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
    BworldSm_UpdateSimQuad(slicePos);
    while (-1 < (signed char)slicePos->quad) {
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
        slicePos->rez = '\x02';
        slicePos->offEdge = '\0';
        GetStmQuadPts(slicePos,cp);
        return 1;
      }
      if ((signed char)slicePos->quad == 0) {
        slicePos->offEdge = '\x01';
        break;
      }
      if (BworldSm_IsSimQuadValid(slicePos)) {
        dist =
            RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[0]) +
            RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[1]) +
            RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[2]) +
            RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[3]);
        if (0x28 < dist - lastDist) break;
        lastDist = dist;
      }
      slicePos->quad = slicePos->quad - '\x01';
      BworldSm_UpdateSimQuad(slicePos);
    }
    if (attempt == 0) {
      firstSliceOffEdge = (int)(signed char)slicePos->offEdge;
    }
    {
      int newSlice;
      int numSlices;

      newSlice = (int)slicePos->slice;
      newSlice += sliceOffs[attempt];
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

    newSlice = (int)slicePos->slice;
    newSlice -= sliceVariance;
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
#undef RAW_QUAD_POINT_DIST
#undef RAW_QUAD_ABS

/* ---- FindClosestQuad__FP8coorddefP12BWorldSm_Pos  [@0x8007f8f8] ---- */
int FindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int startSlice;
  int startQuad;
  int foundSlice;
  static coorddef corrPt;
  int rCount;
  /* ORIGINAL-NAME-RECOVERED: sliceChanged -- NFS2 FindClosestQuad's debug block and matching
   * source name the same post-search comparison local `sliceChanged`.
   * Reusing the stored byte adds an `andi` (116 instructions), while
   * recomputing the comparison produces 117 instructions/four diffs.  This
   * shared boolean gives the exact 115-instruction stores to sliceChanged and
   * quadChanged. */
  int sliceChanged;
  
  startSlice = slicePos->slice;
  startQuad = (int)(signed char)slicePos->quad;
  BWorldSm_FindClosestSlice(pt,slicePos);
  foundSlice = slicePos->slice;
  if (RawFindClosestQuad(pt,slicePos) == 0) {
    if (*(signed char *)&slicePos->offEdge != 0) {
      slicePos->slice = (short)foundSlice;
      BWorld_SetSimSlice(slicePos);
      slicePos->quad =
          (*(signed char *)&slicePos->offEdge == 1) ?
          0 : slicePos->simSlice->quadCount - 1;
      BworldSm_UpdateSimQuad(slicePos);
      slicePos->rez = '\x02';
      SetStrip(slicePos);
      GetStmQuadPts(slicePos,Chunk_chunkCenters + slicePos->chunk);
    }
    corrPt = *pt;
    rCount = 0;
    while ((slicePos->simQuad == (Trk_NewSimQuad *)0x0) &&
           (rCount < 10)) {
      corrPt.x = corrPt.x +
          ((BWorldSm_slices[slicePos->slice].center[0] - corrPt.x) >> 5);
      corrPt.z = corrPt.z +
          ((BWorldSm_slices[slicePos->slice].center[2] - corrPt.z) >> 5);
      RawFindClosestQuad(&corrPt,slicePos);
      rCount = rCount + 1;
    }
  }
  sliceChanged = startSlice != slicePos->slice;
  slicePos->sliceChanged = sliceChanged;
  slicePos->quadChanged =
      (startQuad != (int)(signed char)slicePos->quad) ||
      sliceChanged;
  return (int)*(signed char *)&slicePos->sliceChanged;
}

/* ---- BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi  [@0x8007fac4] ---- */
#define QUAD_PT_DIR(p1, p2, p3) \
  (fixedmult((p1).x - (p2).x,(p3).z - (p2).z) - \
   fixedmult((p3).x - (p2).x,(p1).z - (p2).z))
#define PT_IN_QUAD(q, p) \
  ((QUAD_PT_DIR((q)[1],(q)[2],(p)) <= 0 ? 1 : 0) && \
   QUAD_PT_DIR((q)[0],(q)[1],(p)) <= 0 && \
   QUAD_PT_DIR((q)[2],(q)[3],(p)) <= 0 && \
   (QUAD_PT_DIR((q)[3],(q)[0],(p)) <= 0 ? 1 : 0))
int BWorldSm_FindClosestQuadRez(coorddef *pt,BWorldSm_Pos *slicePos,int hiRezFlag)
{
  slicePos->triangleFlag = '\x03';
  if (hiRezFlag != 0) {
    slicePos->lastRezRequested = '\x02';
    if (slicePos->simQuad != (Trk_NewSimQuad *)0x0) {
      if (PT_IN_QUAD(slicePos->quadPts,*pt)) {
        slicePos->quadChanged = '\0';
        slicePos->sliceChanged = '\0';
        return 0;
      }
    }
    return FindClosestQuad(pt,slicePos);
  }
  slicePos->lastRezRequested = '\x01';
  slicePos->rez = '\x01';
  slicePos->simSlice = (Trk_NewSimSlice *)0x0;
  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  *(signed char *)&slicePos->quad = -1;
  slicePos->triangleFlag = '\0';
  return BWorldSm_FindClosestSlice(pt,slicePos);
}
#undef PT_IN_QUAD

/* ---- BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi  [@0x8007fc90] ---- */
int BWorldSm_FindClosestQuadMaxIterations(coorddef *pt,BWorldSm_Pos *slicePos,int maxIterations)
{
  return BWorldSm_FindClosestQuadRez(pt,slicePos,1);
}

/* ---- PointDirection__FP8coorddefN20  [@0x8007fcb0] ---- */
int PointDirection(coorddef *p1,coorddef *p2,coorddef *p3)
{
  return fixedmult(p1->x - p2->x,p3->z - p2->z) -
         fixedmult(p3->x - p2->x,p1->z - p2->z);
}

/* ---- BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi  [@0x8007fd28] ---- */
int BWorldSm_FindEdgeOff(coorddef *pt,BWorldSm_Pos *slicePos1,BWorldSm_Pos *slicePos2,int *heightDiff)
{
  int ret;
  coorddef *pts;
  int y;
  
  pts = slicePos1->quadPts;
  ret = PointDirection(pts + 2,pts + 3,pt) >= -0x18000;
  if (PointDirection(pts + 3,pts,pt) >= 0) {
    ret = ret | 8;
  }
  if (PointDirection(pts,pts + 1,pt) >= -0x18000) {
    ret = ret | 2;
  }
  if (PointDirection(pts + 1,pts + 2,pt) >= 0) {
    ret = ret | 4;
  }
  {
    pts = slicePos2->quadPts;
    y = pts[0].y + pts[1].y + pts[2].y + pts[3].y;
    *heightDiff = (y >> 2) - pt->y;
  }
  return ret;
}

/* ---- BWorldSm_QuadLight__FP12BWorldSm_Pos  [@0x8007fe44] ---- */
int BWorldSm_QuadLight(BWorldSm_Pos *slicePos)
{
#define QUAD_LIGHT_VERTICES \
  ((CCOORD16 *)Track_chunkList[slicePos->chunk].vertexBuf->GetData())
  if (*(signed char *)&slicePos->rez == 2) {
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

    topInd = (u_int)slicePos->strip->topVert;
    botInd = (u_int)slicePos->strip->botVert;
    topInd += (int)slicePos->stripQuadInd;
    botInd += (int)slicePos->stripQuadInd;
    s1 = *(u_short *)&QUAD_LIGHT_VERTICES[topInd].light;
    s2 = *(u_short *)&QUAD_LIGHT_VERTICES[botInd].light;
    s3 = *(u_short *)&QUAD_LIGHT_VERTICES[botInd + 1].light;
    temp0 = Chunk_lightTable[QUAD_LIGHT_VERTICES[topInd + 1].light];
    temp1 = Chunk_lightTable[s1];
    temp2 = Chunk_lightTable[s2];
    temp3 = Chunk_lightTable[s3];
    light.r = (u_char)((temp0.r + temp1.r + temp2.r + temp3.r) >> 2);
    light.g = (u_char)((temp0.g + temp1.g + temp2.g + temp3.g) >> 2);
    light.b = (u_char)((temp0.b + temp1.b + temp2.b + temp3.b) >> 2);
    return *(int *)&light;
  }
#undef QUAD_LIGHT_VERTICES
  return 0x7f7f7f;
}

/* ---- BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos  [@0x8007ffd4] ---- */
bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *slicePos)
{
  int surf;

  if ((*(u_char *)(slicePos->slice * 0x20 + (char *)BWorldSm_slices + 0x15) & 0x44) != 0) {
    return 1;
  }
  surf = (slicePos->simQuad != (Trk_NewSimQuad *)0x0) ? slicePos->simQuad->surface % 16 : 0xe;
  return (u_int)((surf ^ 8) < 1);
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
bool NormalCache_FindEntry(BWorldSm_Pos *slicePos)
{
  tNormalCacheEntry *ce;
  int slice;
  int quad;
  int i;

  ce = BWSM_NormalCache;
  i = 0;
  BWSM_NormalCacheSysTime = BWSM_NormalCacheSysTime + 1;
  slice = slicePos->slice;
  quad = *(signed char *)&slicePos->quad;
  while (i < 0x10) {
    if ((ce->sliceInd == slice) &&
        (ce->quadInd == quad) &&
        ((u_int)ce->triangleFlag ==
         (int)*(signed char *)&slicePos->triangleFlag)) {
      ce->accessTime = BWSM_NormalCacheSysTime;
      break;
    }
    ce = ce + 1;
    i = i + 1;
  }
  if (i < 0x10) {
    slicePos->normal = ce->normal;
    slicePos->forward = ce->forward;
    return true;
  }
  return false;
}

/* ---- NormalCache_Init__Fv  [@0x800801ac] ---- */
void NormalCache_Init(void)
{
  int i;

  BWSM_NormalCacheSysTime = 0;
  i = 0;
  do {
    BWSM_NormalCache[i].sliceInd = -1;
    BWSM_NormalCache[i].quadInd = -1;
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
  
  ret = BWorldSm_FindClosestQuadRez(pt,slicePos,hiRezFlag);
  if (slicePos->simQuad != (Trk_NewSimQuad *)0x0) {
    if (QUAD_PT_DIR(slicePos->quadPts[2],slicePos->quadPts[0],*pt) > 0) {
      slicePos->triangleFlag = 1;
    }
    else {
      slicePos->triangleFlag = 2;
    }
  }
  return ret;
}
#undef QUAD_PT_DIR
