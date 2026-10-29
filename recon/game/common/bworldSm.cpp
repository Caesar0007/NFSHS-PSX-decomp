/* game/common/bworldSm.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworldSm.obj (GAME\COMMON\bworldSm.cpp) = 28 fns: simplified BWorld road-follower
 *   (slice/quad/triangle finding, normal cache, sim-quad update). SYM-v3 locals; self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "bworldSm_types.h"
#include "bworldSm_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x8005588C): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


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
/* 2026-10-30: supplied slice pointer/center/chunkIndex and Group-header
 * types replace integer/byte address spellings. Group is4 bytes,NewSlice32;
 * center is offset0,chunkIndex UCHAR offset0x1c. No new object or scope.
 * Receipt:build/nc12/bworld_fields_20261030/final-proof.json. */
#line 83 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int BWorldSm_Init(Group *simGroup)
{
  BWorldSm_slices = (Trk_NewSlice *)simGroup->GetData();
  gNumSlices = simGroup->m_num_elements;



  gMaxFindQuadSliceIterations = 5;

  BWorldSm_Restart();

  return 1; }

/* ---- BWorldSm_Restart__Fv  [@0x8007e948] ----
 * Call and implicit void fallthrough share retail relative source line +1:
 * 8/8 instructions, 0/8 SLD differences, exact native block/end lines. */
#line 100 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void BWorldSm_Restart(void)
{
  NormalCache_Init(); }

/* ---- BWorldSm_DeInit__Fv  [@0x8007e968] ---- */
#line 113 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void BWorldSm_DeInit(void) {
}

/* ---- FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos  [@0x8007e970] ---- */
#line 122 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void FindAbsClosestSliceCrude(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int numSlices;
  int currDist = 0x7fffffff;
  int currInd = -1;
  int dist;
  int i;

  numSlices = gNumSlices;
  for (i = 0; i < numSlices; i += 8) {

    dist = xzsquaredist32((coorddef *)BWorldSm_slices[i].center,pt);
    if (dist < currDist) {

      currInd = i;
      currDist = dist;
    }
  }


  slicePos->slice = currInd; }

/* ---- BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos  [@0x8007ea14] ---- */
/* The supplied change fields are assigned166 and normalized at return168.
 * No separate result object is needed;the real boolean status return keeps
 * all39 instruction/source tags and the complete supplied local contract.
 * Literal original macro/comment text is not uniquely recovered.
 * Receipt:build/nc12/bworld_slice_return_20261030/final-proof.json. */
#line 151 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int BWorldSm_FindClosestSlice(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int startSlice;
  startSlice = slicePos->slice;

  if (0x800000 < Math_DistXZ((coorddef *)BWorldSm_slices[startSlice].center,pt)) {




    FindAbsClosestSliceCrude(pt,slicePos);
  }
  RawFindClosestSlice(pt,slicePos);

  slicePos->chunk = BWorldSm_slices[slicePos->slice].chunkIndex;
  slicePos->sliceChanged = slicePos->quadChanged = (slicePos->slice != startSlice);

  return slicePos->sliceChanged != 0; }

/* ---- RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos  [@0x8007eab0] ---- */
/* Retail has no inline-helper scope pairs here. Keep the distance arithmetic
 * as a macro, without introducing parameter/local debug records. Its name is
 * supported by the NFS2 PC helper symbol, not claimed as retail macro spelling.
 * Every argument below is side-effect-free. Byte/native receipt: run-3nuk7jqp. */
#define closeXZDistSquared(slice, pt) \
  (((((pt)->x - (slice)->center[0]) >> 9) * \
    (((pt)->x - (slice)->center[0]) >> 9)) + \
   ((((pt)->z - (slice)->center[2]) >> 9) * \
    (((pt)->z - (slice)->center[2]) >> 9)))

#line 178 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void RawFindClosestSlice(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int lastind; int maxind; int index;
  int distcurr; int distnext; int distprev;
  Trk_NewSlice *slices;

  index = slicePos->slice;
  lastind = -1;
  maxind = gNumSlices - 1;
  slices = BWorldSm_slices;

  while (lastind != index) {

    lastind = index;

    if (index < maxind) {

      distcurr = closeXZDistSquared(slices + index,pt);
    } else {

      distcurr = closeXZDistSquared(slices + index % (maxind + 1),pt);
    }

    if (index < maxind - 1) {

      distnext = (((pt->x - slices[index + 1].center[0]) >> 9) * ((pt->x - slices[index + 1].center[0]) >> 9)) + (((pt->z - slices[index + 1].center[2]) >> 9) * ((pt->z - slices[index + 1].center[2]) >> 9));

      if (distnext < distcurr) {


        index++; continue;
      }
    } else {

      distnext = closeXZDistSquared(slices + (index + 1) % (maxind + 1),pt);

      if (distnext < distcurr) {



        index++; index %= maxind + 1; continue;
      }
    }

    if (index > 0) {

      distprev = (((pt->x - slices[index - 1].center[0]) >> 9) * ((pt->x - slices[index - 1].center[0]) >> 9)) + (((pt->z - slices[index - 1].center[2]) >> 9) * ((pt->z - slices[index - 1].center[2]) >> 9));

      if (distprev < distcurr) {

        index--;
      }
    } else {

      index += maxind + 1;
      distprev = closeXZDistSquared(slices + (index - 1) % (maxind + 1),pt);

      if (distprev < distcurr) {

        index--;
      }
      index += maxind + 1;
      index %= maxind + 1;
    }





  }

  slicePos->slice = (short)index;

  return; }

/* ---- BWorldSm_SetSlice__FiP12BWorldSm_Pos  [@0x8007ed64] ---- */
#undef closeXZDistSquared
#line 260 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void BWorldSm_SetSlice(int slice,BWorldSm_Pos *slicePos)
{

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
  *(signed char *)&slicePos->quad = -1; }

/* ---- GetStmQuadPts__FP12BWorldSm_PosP8coorddef  [@0x8007edb8] ---- */
/* SOURCE-REVIEW-UNRESOLVED: vertices is corroborated by NFS2's
 * same-function source,not a uniquely retained NFS4 local spelling/object.
 * Earlier direct expansion was101 words/119 diffs,not a necessity proof.
 * All74 tags and supplied owners/regions match;the cached-value producer
 * and literal original expression remain review work,not an exemption.
 * Receipt:build/nc12/bworld_quadpts_layout_20261030/final-proof.json. */
#line 322 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void GetStmQuadPts(BWorldSm_Pos *slicePos,coorddef *cp)
{
  Trk_NewStrip *pStrip; coorddef *pts; CCOORD16 *vertices;
  int cx; int cy; int cz; int topInd; int botInd; int x; int y; int z;




  pStrip = slicePos->strip;
  vertices = (CCOORD16 *)Track_chunkList[slicePos->chunk].vertexBuf->GetData();



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
  pts[0].z = z; }

/* ---- SetStrip__FP12BWorldSm_Pos  [@0x8007eee0] ---- */
#line 378 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void SetStrip(BWorldSm_Pos *slicePos)
{
  int i;
  int maxIndex = (u_int)slicePos->simSlice->stripIndex;
  int quadCount;

  slicePos->strip = (Trk_NewStrip *)Track_chunkList[slicePos->chunk].stripBuf->GetData();

  for (i = 0; i < maxIndex; i = i + 1) {
    slicePos->strip = (Trk_NewStrip *)(&slicePos->strip[1].topVert + (u_int)(u_char)slicePos->strip->quadCount * 2); }





  i = (int)(signed char)slicePos->quad;

  quadCount = (u_int)(u_char)slicePos->strip->quadCount;
  while (quadCount <= i) {

    i = i - quadCount;

    slicePos->strip = (Trk_NewStrip *)(&slicePos->strip[1].topVert + quadCount * 2);
    quadCount = (u_int)(u_char)slicePos->strip->quadCount; }

  slicePos->stripQuadInd = (short)i; }

/* ---- GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16  [@0x8007ef98] ---- */
#line 414 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void GetFirstStmQuadPts(BWorldSm_Pos *slicePos,CCOORD16 *vertices)
{
  CCOORD16 *pts; Trk_NewStrip *pStrip; int topInd; int botInd; short x; short z;



  SetStrip(slicePos);

  pStrip = slicePos->strip;

  pts = slicePos->quadPts16;

  topInd = (u_int)pStrip->topVert;
  botInd = (u_int)pStrip->botVert;









  topInd += slicePos->stripQuadInd;
  botInd += slicePos->stripQuadInd;


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
  pts[0].z = z; }

/* ---- BWorld_SetSimSlice__FP12BWorldSm_Pos  [@0x8007f034] ---- */
#line 469 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void BWorld_SetSimSlice(BWorldSm_Pos *slicePos)
{
  Trk_NewSimSlice *simSlices;
  int chunkSliceInd;




  slicePos->chunk = BWorldSm_slices[slicePos->slice].chunkIndex;

  simSlices = (Trk_NewSimSlice *)(Track_chunkList[slicePos->chunk].simSliceBuf + 1);
  chunkSliceInd = (int)slicePos->slice - (int)Track_chunkList[slicePos->chunk].firstSimSliceInd;
  slicePos->simSlice = &simSlices[chunkSliceInd]; }

/* ---- BworldSm_UpdateSimQuad__FP12BWorldSm_Pos  [@0x8007f094] ---- */
/* Retail supplies simIndex and the zero-length startsimquad region.
 * An ordinary if/else and body-local pointer preserve both real stores,
 * all supplied owners/SLD;the old manual/statement-expression wrappers
 * are unnecessary. Literal original macro/expression text is unresolved.
 * Receipt:build/nc12/bworld_updatequad_layout_20261030/final-proof.json. */
#line 494 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void BworldSm_UpdateSimQuad(BWorldSm_Pos *slicePos)
{
  int simIndex;
  simIndex = (int)(signed char)slicePos->quad - (u_int)slicePos->simSlice->simquadStartIndex;

  if ((-1 < simIndex) && (simIndex < (int)(u_int)slicePos->simSlice->simquadCount))
  { Trk_NewSimQuad *startsimquad;
             startsimquad = (Trk_NewSimQuad *)(Track_chunkList[slicePos->chunk].simQuadBuf + 1);
    slicePos->simQuad = startsimquad;
    slicePos->simQuad += (u_int)slicePos->simSlice->simquadIndex + simIndex;
  } else

    slicePos->simQuad = &GlobalSimQuad; }

/* ---- BworldSm_IsSimQuadValid__FP12BWorldSm_Pos  [@0x8007f11c] ----
 * The explicit null-path else shares its source line with the closing if:
 * all 12 instruction SLD tags and the block/function end lines match retail.
 * Literal EA spelling remains unknown. */
#line 515 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int BworldSm_IsSimQuadValid(BWorldSm_Pos *slicePos)
{
  if (slicePos->simQuad != (Trk_NewSimQuad *)0x0) {
    return (u_int)(((slicePos->simQuad->surface & 0xf) ^ 0xe) != 0);
  } else return 0;
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
#line 536 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int RawFindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int attempt; int startQuadInd;
  static int sliceOffs[12] = { 1, -2, 3, -4, 5, -6, 7, -8, 9, -10, 11, -12 };
  int sliceVariance; coorddef *cp; CCOORD16 *vertices; CCOORD16 pt16; int dist; int lastDist; int firstSliceOffEdge;








  attempt = 0;
  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  slicePos->simRotFlag = 0;



  BWorld_SetSimSlice(slicePos);

  sliceVariance = 0;
  if ((0 <= (int)(signed char)slicePos->quad) && ((int)(signed char)slicePos->quad < (int)(slicePos->simSlice->quadCount - 1)) && ((signed char)slicePos->offEdge == 0)) {

    startQuadInd = (int)(signed char)slicePos->quad;
  } else {

    slicePos->quad = (char)((int)(slicePos->simSlice->quadCount - 1) / 2); startQuadInd = (int)(signed char)slicePos->quad;

  }


  firstSliceOffEdge = 0;
  slicePos->offEdge = '\0';
  slicePos->quad = (char)startQuadInd;

  while (attempt < gMaxFindQuadSliceIterations) {



    BWorld_SetSimSlice(slicePos);


    slicePos->quad = (char)startQuadInd;
    if ((int)(slicePos->simSlice->quadCount - 1) < startQuadInd)
      slicePos->quad = slicePos->simSlice->quadCount - 2;


    cp = Chunk_chunkCenters + slicePos->chunk;
    pt16.x = (short)(pt->x - cp->x >> 10);
    pt16.z = (short)(pt->z - cp->z >> 10);
    vertices = (CCOORD16 *)Track_chunkList[slicePos->chunk].vertexBuf->GetData();


    lastDist = 0x7fffffff;

    GetFirstStmQuadPts(slicePos,vertices);




    BworldSm_UpdateSimQuad(slicePos);


    while ((int)(signed char)slicePos->quad <= (int)(slicePos->simSlice->quadCount - 1)) {

      GetFirstStmQuadPts(slicePos,vertices);

      if ((((int)slicePos->quadPts16[1].x - (int)slicePos->quadPts16[2].x) * ((int)pt16.z - (int)slicePos->quadPts16[2].z) - ((int)pt16.x - (int)slicePos->quadPts16[2].x) * ((int)slicePos->quadPts16[1].z - (int)slicePos->quadPts16[2].z) < 1) && (((int)slicePos->quadPts16[0].x - (int)slicePos->quadPts16[1].x) * ((int)pt16.z - (int)slicePos->quadPts16[1].z) - ((int)pt16.x - (int)slicePos->quadPts16[1].x) * ((int)slicePos->quadPts16[0].z - (int)slicePos->quadPts16[1].z) < 1) && (((int)slicePos->quadPts16[2].x - (int)slicePos->quadPts16[3].x) * ((int)pt16.z - (int)slicePos->quadPts16[3].z) - ((int)pt16.x - (int)slicePos->quadPts16[3].x) * ((int)slicePos->quadPts16[2].z - (int)slicePos->quadPts16[3].z) < 1) && (((int)slicePos->quadPts16[3].x - (int)slicePos->quadPts16[0].x) * ((int)pt16.z - (int)slicePos->quadPts16[0].z) - ((int)pt16.x - (int)slicePos->quadPts16[0].x) * ((int)slicePos->quadPts16[3].z - (int)slicePos->quadPts16[0].z) < 1))



        if (BworldSm_IsSimQuadValid(slicePos)) {




          slicePos->rez = '\x02';
          slicePos->offEdge = '\0';



          GetStmQuadPts(slicePos,cp);

          return 1;
        }
      if ((int)(signed char)slicePos->quad == slicePos->simSlice->quadCount - 1) {

        slicePos->offEdge = '\x02';
        break; }




      if (BworldSm_IsSimQuadValid(slicePos)) {



        dist = RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[0]) + RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[1]) + RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[2]) + RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[3]);

        if (0x28 < dist - lastDist) break;




        lastDist = dist; }


      slicePos->quad = slicePos->quad + '\x01';
      BworldSm_UpdateSimQuad(slicePos); }




    lastDist = 0x7fffffff;
    if (((signed char)slicePos->offEdge != 0) && (attempt == 0)) {
      slicePos->quad = slicePos->simSlice->quadCount - 1;
    } else {
      slicePos->quad = (char)(startQuadInd - 1); }
    if ((signed char)slicePos->quad < 0) slicePos->quad = '\0';
    GetFirstStmQuadPts(slicePos,vertices);


    BworldSm_UpdateSimQuad(slicePos);



    while (-1 < (signed char)slicePos->quad) {

      GetFirstStmQuadPts(slicePos,vertices);

      if ((((int)slicePos->quadPts16[1].x - (int)slicePos->quadPts16[2].x) * ((int)pt16.z - (int)slicePos->quadPts16[2].z) - ((int)pt16.x - (int)slicePos->quadPts16[2].x) * ((int)slicePos->quadPts16[1].z - (int)slicePos->quadPts16[2].z) < 1) && (((int)slicePos->quadPts16[0].x - (int)slicePos->quadPts16[1].x) * ((int)pt16.z - (int)slicePos->quadPts16[1].z) - ((int)pt16.x - (int)slicePos->quadPts16[1].x) * ((int)slicePos->quadPts16[0].z - (int)slicePos->quadPts16[1].z) < 1) && (((int)slicePos->quadPts16[2].x - (int)slicePos->quadPts16[3].x) * ((int)pt16.z - (int)slicePos->quadPts16[3].z) - ((int)pt16.x - (int)slicePos->quadPts16[3].x) * ((int)slicePos->quadPts16[2].z - (int)slicePos->quadPts16[3].z) < 1) && (((int)slicePos->quadPts16[3].x - (int)slicePos->quadPts16[0].x) * ((int)pt16.z - (int)slicePos->quadPts16[0].z) - ((int)pt16.x - (int)slicePos->quadPts16[0].x) * ((int)slicePos->quadPts16[3].z - (int)slicePos->quadPts16[0].z) < 1))



        if (BworldSm_IsSimQuadValid(slicePos)) {


          slicePos->rez = '\x02';
          slicePos->offEdge = '\0';

          GetStmQuadPts(slicePos,cp);

          return 1;

        }




      if ((signed char)slicePos->quad == 0) {

        slicePos->offEdge = '\x01';
        break; }




      if (BworldSm_IsSimQuadValid(slicePos)) {



        dist = RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[0]) + RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[1]) + RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[2]) + RAW_QUAD_POINT_DIST(pt16,slicePos->quadPts16[3]);

        if (0x28 < dist - lastDist) break;




        lastDist = dist; }


      slicePos->quad = slicePos->quad - '\x01';
      BworldSm_UpdateSimQuad(slicePos); }







    if (attempt == 0)
      firstSliceOffEdge = (int)(signed char)slicePos->offEdge;


    { int newSlice; int numSlices; newSlice = (int)slicePos->slice; newSlice += sliceOffs[attempt]; numSlices = gNumSlices; if (numSlices <= newSlice) newSlice = newSlice - numSlices; if (newSlice < 0) newSlice = newSlice + numSlices; slicePos->slice = (short)newSlice; }
    sliceVariance = sliceVariance + sliceOffs[attempt];
    attempt = attempt + 1; }





  { int newSlice; int numSlices; newSlice = (int)slicePos->slice; newSlice -= sliceVariance; numSlices = gNumSlices; if (numSlices <= newSlice) newSlice = newSlice - numSlices; if (newSlice < 0) newSlice = newSlice + numSlices; slicePos->slice = (short)newSlice; }
  BWorld_SetSimSlice(slicePos);

  slicePos->offEdge = (char)firstSliceOffEdge;




  slicePos->simQuad = (Trk_NewSimQuad *)0x0;
  slicePos->triangleFlag = '\0';


  return 0; }
#undef RAW_QUAD_POINT_DIST
#undef RAW_QUAD_ABS

/* ---- FindClosestQuad__FP8coorddefP12BWorldSm_Pos  [@0x8007f8f8] ---- */
/* Retail supplies done at object-relative0x1160 (VA8007fa70);keep it.
 * SOURCE-REVIEW-UNRESOLVED: sliceChanged names the change-field comparison,
 * but this NFS4 local spelling/object is not supplied. The cited NFS2 PC
 * same-function SYM/source also does not list that local;the old recovered-
 * name claim was unsupported. Earlier failed controls are not a source-
 * object necessity proof. Keep this producer open,not as an exemption.
 * Receipt:build/nc12/bworld_findquad_source_20261030/final-proof.json. */
#line 1057 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int FindClosestQuad(coorddef *pt,BWorldSm_Pos *slicePos)
{
  int startSlice = slicePos->slice;
  int startQuad = (int)(signed char)slicePos->quad;
  int foundSlice;
  int sliceChanged;









  BWorldSm_FindClosestSlice(pt,slicePos);


  foundSlice = slicePos->slice;


  if (RawFindClosestQuad(pt,slicePos) != 0) goto done;






  if (*(signed char *)&slicePos->offEdge != 0) {



    slicePos->slice = (short)foundSlice; BWorld_SetSimSlice(slicePos);
    slicePos->quad = (*(signed char *)&slicePos->offEdge == 1) ? 0 : slicePos->simSlice->quadCount - 1;

    BworldSm_UpdateSimQuad(slicePos);

    slicePos->rez = '\x02';
    SetStrip(slicePos);
    GetStmQuadPts(slicePos,Chunk_chunkCenters + slicePos->chunk);

  }


  { static coorddef corrPt;
    int rCount;


    corrPt = *pt;
    rCount = 0; while ((slicePos->simQuad == (Trk_NewSimQuad *)0x0) && (rCount < 10)) {



      corrPt.x = corrPt.x + ((BWorldSm_slices[slicePos->slice].center[0] - corrPt.x) >> 5);
      corrPt.z = corrPt.z + ((BWorldSm_slices[slicePos->slice].center[2] - corrPt.z) >> 5);

      RawFindClosestQuad(&corrPt,slicePos);
      rCount = rCount + 1; } }







done:
  sliceChanged = startSlice != slicePos->slice; slicePos->sliceChanged = sliceChanged;
  slicePos->quadChanged = (startQuad != (int)(signed char)slicePos->quad) || sliceChanged;



  return (int)*(signed char *)&slicePos->sliceChanged; }

/* ---- BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi  [@0x8007fac4] ---- */
#define QUAD_PT_DIR(p1, p2, p3) \
  (fixedmult((p1).x - (p2).x,(p3).z - (p2).z) - \
   fixedmult((p3).x - (p2).x,(p1).z - (p2).z))
#define PT_IN_QUAD(q, p) \
  ((QUAD_PT_DIR((q)[1],(q)[2],(p)) <= 0 ? 1 : 0) && \
   QUAD_PT_DIR((q)[0],(q)[1],(p)) <= 0 && \
   QUAD_PT_DIR((q)[2],(q)[3],(p)) <= 0 && \
   (QUAD_PT_DIR((q)[3],(q)[0],(p)) <= 0 ? 1 : 0))
/* 2026-10-29: sliceChanged is supported by both original NFS2 SYM locals
 * and the NFS4 callees' returned slice-change flags;not an invented label.
 * Plain int values remove two unnecessary const qualifiers. Actual return
 * phases and original-file anchor match all115 source tags and supplied scopes.
 * SOURCE-REVIEW-UNRESOLVED: exact NFS4 local spelling/producer and macro text
 * are not uniquely retained;the current scopes are not an object-necessity proof.
 * Receipt:build/nc12/bworld_return_source_20261029/final-proof.json. */
#line 1138 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int BWorldSm_FindClosestQuadRez(coorddef *pt,BWorldSm_Pos *slicePos,int hiRezFlag)
{
  slicePos->triangleFlag = '\x03';

  if (hiRezFlag != 0)
  {


    slicePos->lastRezRequested = '\x02';






    if (slicePos->simQuad != (Trk_NewSimQuad *)0x0)
    {

      if (PT_IN_QUAD(slicePos->quadPts,*pt))
      {
        slicePos->quadChanged = '\0'; slicePos->sliceChanged = '\0';

        return 0;
      }
    }
    int sliceChanged = FindClosestQuad(pt,slicePos);

    return sliceChanged;
  }
  else {


    slicePos->lastRezRequested = '\x01';


    slicePos->simSlice = (Trk_NewSimSlice *)0x0;
    slicePos->simQuad = (Trk_NewSimQuad *)0x0;
    slicePos->rez = '\x01';
    *(signed char *)&slicePos->quad = -1; slicePos->triangleFlag = '\0';



    int sliceChanged = BWorldSm_FindClosestSlice(pt,slicePos);






    return sliceChanged; } }
#undef PT_IN_QUAD

/* ---- BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi  [@0x8007fc90] ---- */
#line 1198 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int BWorldSm_FindClosestQuadMaxIterations(coorddef *pt,BWorldSm_Pos *slicePos,int maxIterations)
{
  return BWorldSm_FindClosestQuadRez(pt,slicePos,1);
}

/* ---- PointDirection__FP8coorddefN20  [@0x8007fcb0] ---- */
#line 1211 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int PointDirection(coorddef *p1,coorddef *p2,coorddef *p3)
{
  return fixedmult(p1->x - p2->x,p3->z - p2->z) - fixedmult(p3->x - p2->x,p1->z - p2->z); }

/* ---- BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi  [@0x8007fd28] ---- */
#line 1216 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int BWorldSm_FindEdgeOff(coorddef *pt,BWorldSm_Pos *slicePos1,BWorldSm_Pos *slicePos2,int *heightDiff)
{
  int ret;
  coorddef *pts;









  pts = slicePos1->quadPts;


  ret = PointDirection(pts + 2,pts + 3,pt) >= -0x18000;

  if (PointDirection(pts + 3,pts,pt) >= 0)
    ret = ret | 8;
  if (PointDirection(pts,pts + 1,pt) >= -0x18000)
    ret = ret | 2;
  if (PointDirection(pts + 1,pts + 2,pt) >= 0)
    ret = ret | 4;




  { int y;


    pts = slicePos2->quadPts;

    y = pts[0].y + pts[1].y + pts[2].y + pts[3].y;
    y >>= 2;

    *heightDiff = y - pt->y;
  }

  return ret; }

/* ---- BWorldSm_QuadLight__FP12BWorldSm_Pos  [@0x8007fe44] ---- */
/* SOURCE-REVIEW-UNRESOLVED: QUAD_LIGHT_VERTICES is a reconstruction
 * cache name,not supplied by retail. Plain pointer and const pointer both
 * preserve the entire old native dump;const is unnecessary,not a source
 * object-necessity proof. Original cache/macro producer still needs recovery.
 * Receipt:build/nc12/bworld_quadlight_source_20261030/final-proof.json. */
#line 1260 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int BWorldSm_QuadLight(BWorldSm_Pos *slicePos)
{
  if (*(signed char *)&slicePos->rez == 2) {
    CVECTOR light; CVECTOR temp0; CVECTOR temp1; CVECTOR temp2; CVECTOR temp3;
    int topInd; int botInd; short s1; short s2; short s3;


    topInd = (u_int)slicePos->strip->topVert;
    botInd = (u_int)slicePos->strip->botVert;
    topInd += (int)slicePos->stripQuadInd;
    botInd += (int)slicePos->stripQuadInd;

    CCOORD16 *QUAD_LIGHT_VERTICES = (CCOORD16 *)Track_chunkList[slicePos->chunk].vertexBuf->GetData();
    s1 = (u_short)QUAD_LIGHT_VERTICES[topInd]
      .light; s2 = (u_short)QUAD_LIGHT_VERTICES[botInd]
      .light; s3 = (u_short)QUAD_LIGHT_VERTICES[botInd + 1]
      .light;

    temp0 = Chunk_lightTable[QUAD_LIGHT_VERTICES[topInd + 1].light];
    temp1 = Chunk_lightTable[s1];
    temp2 = Chunk_lightTable[s2];
    temp3 = Chunk_lightTable[s3];

    light.r = (u_char)((temp0.r + temp1.r + temp2.r + temp3.r) >> 2);
    light.g = (u_char)((temp0.g + temp1.g + temp2.g + temp3.g) >> 2);
    light.b = (u_char)((temp0.b + temp1.b + temp2.b + temp3.b) >> 2);

    return *(int *)&light;
  } else
    return 0x7f7f7f; }

/* ---- BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos  [@0x8007ffd4] ---- */
#line 1300 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *slicePos)
{
  int surf; if ((BWorldSm_slices[slicePos->slice].acousticType & 0x44) != 0) return 1;


  surf = (slicePos->simQuad != (Trk_NewSimQuad *)0x0) ? slicePos->simQuad->surface % 16 : 0xe;

  if (surf == 8) return 1;


  return 0; }

/* ---- NormalCache_AddEntry__FP12BWorldSm_Pos  [@0x8008002c] ---- */
#line 1340 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void NormalCache_AddEntry(BWorldSm_Pos *slicePos)
{
  u_long oldestTime = 0xffffffff;
  int oldestInd = -1;
  tNormalCacheEntry *ce = BWSM_NormalCache;

  BWSM_NormalCacheSysTime = BWSM_NormalCacheSysTime + 1;


  for (int i = 0; i < 0x10; i = i + 1, ce = ce + 1) {

    if (ce->accessTime < oldestTime) {

      oldestInd = i;
      oldestTime = ce->accessTime;
    }

  }


  ce = BWSM_NormalCache + oldestInd;
  ce->accessTime = BWSM_NormalCacheSysTime;
  ce->forward = slicePos->forward;
  ce->normal = slicePos->normal;
  ce->sliceInd = slicePos->slice;
  ce->quadInd = slicePos->quad;
  ce->triangleFlag = slicePos->triangleFlag; }

/* ---- NormalCache_FindEntry__FP12BWorldSm_Pos  [@0x800800e8] ---- */
#line 1371 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
bool NormalCache_FindEntry(BWorldSm_Pos *slicePos)
{
  BWSM_NormalCacheSysTime = BWSM_NormalCacheSysTime + 1;
  tNormalCacheEntry *ce = BWSM_NormalCache;

  int slice = slicePos->slice;
  int quad = *(signed char *)&slicePos->quad;

  int i;

  i = 0; while (i < 0x10) {

    if (ce->sliceInd == slice)

      if (ce->quadInd == quad)

        if ((u_int)ce->triangleFlag == (int)*(signed char *)&slicePos->triangleFlag) {

      ce->accessTime = BWSM_NormalCacheSysTime;
      break;
    }


    ce = ce + 1;
    i = i + 1; }

  if (i < 0x10) {

    slicePos->normal = ce->normal;
    slicePos->forward = ce->forward;

    return true;
  }

  return false; }

/* ---- NormalCache_Init__Fv  [@0x800801ac] ---- */
/* The ordinary for owns supplied i (INT REG4,depth2);the manual
 * declaration wrapper was unnecessary. Entire native dump/object/CPE match.
 * Receipt:build/nc12/bworld_cacheinit_source_20261030/final-proof.json. */
#line 1410 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void NormalCache_Init(void)
{
  BWSM_NormalCacheSysTime = 0;

  for (int i = 0; i < 0x10; i++) {

    BWSM_NormalCache[i].sliceInd = -1;
    BWSM_NormalCache[i].quadInd = -1;
    BWSM_NormalCache[i].triangleFlag = '\0';
    BWSM_NormalCache[i].accessTime = 0;
  }

}

/* ---- Check_Rot__FP12BWorldSm_Pos  [@0x800801e8] ---- */
/* Covered rotation names/roles/scopes and all206 source tags match.
 * Real cache-miss vectors and the forward/normal work region are preserved;
 * coordinate equality does not prove unique original macro/comment text.
 * Receipt:build/nc12/bworld_rotation_layout_20261030/final-proof.json. */
#line 1426 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
void Check_Rot(BWorldSm_Pos *slicePos)
{

  if (slicePos->simRotFlag != (signed char)slicePos->triangleFlag)
  {
    if (!NormalCache_FindEntry(slicePos))
    {
      coorddef vecX;
      coorddef vecZ;


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
        crossproduct(&vecZ.x,&vecX.x,&normal->x);
        Math_NormalizeVector(normal);
        if (normal->y > 0xffff) normal->y = 0xfff9;
        Math_NormalizeVector(forward); }



      NormalCache_AddEntry(slicePos); } }



  slicePos->simRotFlag = (signed char)slicePos->triangleFlag; }

/* ---- BWorldSm_UNormal__FP12BWorldSm_Pos  [@0x80080520] ---- */
#line 1498 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
coorddef * BWorldSm_UNormal(BWorldSm_Pos *slicePos)
{
  Check_Rot(slicePos);

  return &slicePos->normal;
}

/* ---- BWorldSm_UForward__FP12BWorldSm_Pos  [@0x80080548] ---- */
#line 1505 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
coorddef * BWorldSm_UForward(BWorldSm_Pos *slicePos)
{
  Check_Rot(slicePos);



  return &slicePos->forward;
}

/* ---- BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi  [@0x80080570] ---- */
#line 1516 "C:/nfs4/GAME/COMMON/BWORLDSM.CPP"
int BWorldSm_FindClosestTriangleRez(coorddef *pt,BWorldSm_Pos *slicePos,int hiRezFlag)
{
  int ret;
  ret = BWorldSm_FindClosestQuadRez(pt,slicePos,hiRezFlag);


  if (slicePos->simQuad != (Trk_NewSimQuad *)0x0) {

    if (QUAD_PT_DIR(slicePos->quadPts[2],slicePos->quadPts[0],*pt) > 0) {

      slicePos->triangleFlag = 1;

    } else {

      slicePos->triangleFlag = 2;

    }

  }

  return ret; }
#undef QUAD_PT_DIR
