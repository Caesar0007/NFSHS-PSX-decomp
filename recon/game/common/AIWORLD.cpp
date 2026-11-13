/* game/common/AIWORLD.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   AIWORLD.obj (GAME\COMMON\AIWORLD.CPP) = 22 functions: AI road geometry,
 *   spline distances, lane queries and road-relative velocity calculations.
 *   Native SYM, SLD and raw-ROM verification: see sym-match.md.
 */
#include "aiworld_types.h"
#include "AIWORLD_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80055684): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* Canonical EA slice-wrap macro, independently retained by the symbol-bearing
   NFS2 source tree. */
#define WRAP_SLICE(a,b) (((a) >= 0) \
    ? ((((b) + (a)) >= gNumSlices) ? ((b) + (a)) - gNumSlices : ((b) + (a))) \
    : ((((b) + (a)) < 0) ? ((b) + (a)) + gNumSlices : ((b) + (a))))


/* ---- AIWORLD.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
int          inverseLaneWidthTable[80];   /* @0x8010e00c  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
int AIWorld_ZSplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj);
int AIWorld_ZSplineDistance(coorddef *pos1,coorddef *pos2,matrixtdef *roadMatrix);
int AIWorld_ApxSplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj);
int AIWorld_ApxSplineDistance(Car_tObj *carObj,int location);
int AIWorld_ApxSplineDistance(int location,Car_tObj *carObj);
int AIWorld_ApxSplineDistance(int locationA,int locationB);
int AIWorld_SplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj);
int AIWorld_SplineDistance(Car_tObj *carObj,int location,coorddef *position);
int AIWorld_GameOdometer(Car_tObj *carObj);
int AIWorld_IsDriveableLaneInSliceRange(int startSlice,int numSlicesToCheck,int direction,int laneIndex);
int AIWorld_IsDriveableLane(int slice,int laneIndex);
int AIWorld_GetProfileMask(int laneIndex);
int AIWorld_IsDriveableLane_UsingMask(int slice,int mask);
int AIWorld_CheckForBarrierBetweenLanes(int slice,int lane0,int lane1);
int AIWorld_LaneIndex(int slice,int position);
void AIWorld_CalculateLaneInfo(Car_tObj *carObj);
int AIWorld_CalculateDeltaRoadYaw(Car_tObj *carObj);
int AIWorld_CalcRoadBend(Car_tObj *carObj,int lookAhead);
int AIWorld_CalcFutureLateralVel(Car_tObj *carObj,int slicesAhead);
void AIWorld_CalcSpeed(Car_tObj *carObj);
int AIWorld_CalcLateralVelocity(Car_tObj *carObj);
void AIWorld_FindBarrierLessLaneAndPosition(Car_tObj *carObj,int *goodLane,int *goodPosition);

/* ---- AIWorld_ZSplineDistance__FP8Car_tObjT0  [@0x80072f90] ---- */

#line 28 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_ZSplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  coorddef relPos, forward;

  relPos.x = (carObj->N).position.x - (otherCarObj->N).position.x, relPos.y = (carObj->N).position.y - (otherCarObj->N).position.y, relPos.z = (carObj->N).position.z - (otherCarObj->N).position.z;
  forward = *(coorddef *)&(carObj->N).roadMatrix.m[6];
  return fixedmult(relPos.x,forward.x) + fixedmult(relPos.z,forward.z);
}

/* ---- AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef  [@0x80073024] ---- */

#line 37 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_ZSplineDistance(coorddef *pos1,coorddef *pos2,matrixtdef *roadMatrix)
{
  coorddef relPos, forward;
  relPos.x = pos1->x - pos2->x, relPos.y = pos1->y - pos2->y, relPos.z = pos1->z - pos2->z;
  forward = *(coorddef *)&roadMatrix->m[6];
  return fixedmult(relPos.x,forward.x) + fixedmult(relPos.z,forward.z);
}

/* ---- AIWorld_ApxSplineDistance__FP8Car_tObjT0  [@0x800730b8] ---- */
/* Native a/b name the input slices, not the multiply's anonymous shift/add
 * intermediates. SLD54/55 precedes diff at58 and the single return at63. */

#line 51 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_ApxSplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  int diff, halfTrack;
  int a = (int)(carObj->N).simRoadInfo.slice;
  int b = (int)(otherCarObj->N).simRoadInfo.slice;

  halfTrack = gNumSlices / 2;
  diff = a - b;
  if (diff > 0 && diff > halfTrack)
    diff -= gNumSlices;
  else if (diff < 0 && diff < -halfTrack)
    diff += gNumSlices;
  return diff * 0x60000;
}

/* ---- AIWorld_ApxSplineDistance__FP8Car_tObji  [@0x80073128] ---- */
/* As above, a is the input slice (SLD69), not a doubled-distance carrier. */

#line 66 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_ApxSplineDistance(Car_tObj *carObj,int location)
{
  int diff, halfTrack;
  int a = (int)(carObj->N).simRoadInfo.slice;


  halfTrack = gNumSlices / 2;
  diff = a - location;
  if (diff > 0 && diff > halfTrack)
    diff -= gNumSlices;
  else if (diff < 0 && diff < -halfTrack)
    diff += gNumSlices;
  return diff * 0x60000;
}

/* ---- AIWorld_ApxSplineDistance__FiP8Car_tObj  [@0x80073194] ---- */

#line 81 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_ApxSplineDistance(int location,Car_tObj *carObj)
{
  return -AIWorld_ApxSplineDistance(carObj,location);
}

/* ---- AIWorld_ApxSplineDistance__Fii  [@0x800731bc] ---- */

#line 86 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_ApxSplineDistance(int locationA,int locationB)
{
  int diff, halfTrack;

  halfTrack = gNumSlices / 2;
  diff = locationA - locationB;
  if (diff > 0 && diff > halfTrack)
    diff -= gNumSlices;
  else if (diff < 0 && diff < -halfTrack)
    diff += gNumSlices;
  return diff * 0x60000;
}

/* ---- AIWorld_SplineDistance__FP8Car_tObjT0  [@0x80073224] ---- */

#line 106 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_SplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  int distance;

  distance = AIWorld_ApxSplineDistance(carObj,otherCarObj);

  if (distance + 0xc0000U >= 0x180001)
    return distance;

  return AIWorld_ZSplineDistance(carObj,otherCarObj);
}

/* ---- AIWorld_SplineDistance__FP8Car_tObjiP8coorddef  [@0x8007327c] ---- */

#line 118 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_SplineDistance(Car_tObj *carObj,int location,coorddef *position)
{
  int distance;

  distance = AIWorld_ApxSplineDistance(carObj,location);
  if (distance + 0xc0000U >= 0x180001)
    return distance;

  return AIWorld_ZSplineDistance(&(carObj->N).position,position,&(carObj->N).roadMatrix);
}

/* ---- AIWorld_GameOdometer__FP8Car_tObj  [@0x800732d8] ---- */

#line 142 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_GameOdometer(Car_tObj *carObj)
{
  return (u_int)(carObj->N).totalSlice * 0x60000;
}

/* ---- AIWorld_IsDriveableLaneInSliceRange__Fiiii  [@0x800732f0] ---- */
/* Native scopes own the for-declared counter and the loop-body slice.
 * SLD177..195 also fixes the clamp, mask, loop and return statement regions. */

#line 171 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_IsDriveableLaneInSliceRange(int startSlice,int numSlicesToCheck,int direction,int laneIndex)
{
  int profileIndex;   /* SYM: REG -- clamp shape matches GetProfileMask/IsDriveableLane */
  int laneOffset;      /* SYM: REG */
  int mask;             /* SYM: REG -- computed ONCE before the loop */

  laneOffset = 7 - laneIndex;
  profileIndex = 8 - laneOffset;

  if (profileIndex < 0)
    profileIndex = 0;
  if (0xf < profileIndex)
    profileIndex = 0xf;


  mask = 1 << (0xfU - profileIndex);


  for (int checkSliceOffset = 0; checkSliceOffset < numSlicesToCheck; checkSliceOffset++)
  {
    int checkSlice = WRAP_SLICE(checkSliceOffset * direction,startSlice);
    if ((BWorldSm_slices[checkSlice].pavedProfile & mask) == 0)
      return 0;
  }
  return 1;
}

/* ---- AIWorld_IsDriveableLane__Fii  [@0x800733a8] ---- */

#line 202 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_IsDriveableLane(int slice,int laneIndex)
{
  int profileIndex;
  int laneOffset;
  int mask;

  laneOffset = 7 - laneIndex;
  profileIndex = 8 - laneOffset;

  if (profileIndex < 0)
    profileIndex = 0;
  if (0xf < profileIndex)
    profileIndex = 0xf;


  mask = 1 << (0xfU - profileIndex);
  return (int)BWorldSm_slices[slice].pavedProfile & mask;
}

/* ---- AIWorld_GetProfileMask__Fi  [@0x800733fc] ---- */
/* SLD232/233 keeps the two subtractions separate; folding them to laneIndex+1
 * drops the retail's intermediate operations. */

#line 227 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_GetProfileMask(int laneIndex)
{
  int profileIndex;   /* SYM: REG $v1 -- rewired from anonymous iVar1/iVar2 */
  int laneOffset;      /* SYM: REG $v0 */

  laneOffset = 7 - laneIndex;
  profileIndex = 8 - laneOffset;

  if (profileIndex < 0)
    profileIndex = 0;
  if (0xf < profileIndex)
    profileIndex = 0xf;

  return 1 << (0xfU - profileIndex);
}

/* ---- AIWorld_IsDriveableLane_UsingMask__Fii  [@0x8007343c] ---- */

#line 249 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_IsDriveableLane_UsingMask(int slice,int mask)
{
  return BWorldSm_slices[slice].pavedProfile & mask;
}

/* ---- AIWorld_CheckForBarrierBetweenLanes__Fiii  [@0x80073458] ---- */

#line 263 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_CheckForBarrierBetweenLanes(int slice,int lane0,int lane1)
{
  int profileLane0, profileLane1;
  int profile = (int)BWorldSm_slices[slice].pavedProfile;







  profileLane0 = 0xe - lane0;
  profileLane1 = 0xe - lane1;

  if (profileLane1 < profileLane0)
    return ~profile >> (profileLane1) & ~(-1 << ((profileLane0 - profileLane1) + 1));

  return ~profile >> (profileLane0) & ~(-1 << ((profileLane1 - profileLane0) + 1));
}

/* ---- AIWorld_LaneIndex__Fii  [@0x800734cc] ---- */
/* SYM identifies only laneWidth ($v0) and li ($s0). Keeping the direct slice
 * indexing in both arms preserves retail's duplicated base loads and register
 * allocation; the signed divisions retain the bgez/addiu/sra sequences.
 * NFS2's matched AI_LaneIndex supplies inverseLaneWidth/perpDistance; these
 * single-use values disappear from native -g records, unlike the old reused
 * perpDistance carrier. SLD309..313 separates lookup, multiply, divide and
 * clamps. The constant-first upper clamp preserves retail's return funnel. */

#line 289 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_LaneIndex(int slice,int position)
{
  int laneWidth;
  int inverseLaneWidth, perpDistance;
  int li;

  if (position < 0)
  {
    li = 6;
    laneWidth = (int)BWorldSm_slices[slice].avgPavedWidthLf * 0x8000;
  }

  else
  {
    li = 7;
    laneWidth = (int)BWorldSm_slices[slice].avgPavedWidthRt * 0x8000;
  }



  inverseLaneWidth = inverseLaneWidthTable[laneWidth / 0x4000];
  perpDistance = fixedmult(position,inverseLaneWidth);
  li += perpDistance / 0x10000;
  li = (li < 0) ? 0 : li;
  li = (0xd < li) ? 0xd : li;

  return li;
}

/* ---- AIWorld_CalculateLaneInfo__FP8Car_tObj  [@0x80073594] ---- */
/* SLD339/340 and341/342 separate each edge calculation from its lane query.
 * leftEdge/rightEdge are independently named by NFS2's AI_CalculateLaneInfo;
 * both optimize out here. Re-read the slice for each call, as retail does. */

#line 325 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
void AIWorld_CalculateLaneInfo(Car_tObj *carObj)
{
  int leftEdge;
  int rightEdge;
  int rightEdgeIndex;
  int leftEdgeIndex;
  int laneLoop;

  carObj->carInLane = 0;
  if ((carObj->AIFlags & 4U) != 0) return;


    carObj->laneIndex = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,carObj->roadPosition);

    leftEdge = (carObj->roadPosition - carObj->roadSpan) + 0x8000;
    leftEdgeIndex = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,leftEdge);
    rightEdge = carObj->roadPosition + carObj->roadSpan - 0x8000;
    rightEdgeIndex = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,rightEdge);


    if (((u_int)rightEdgeIndex < 0xe) && ((u_int)leftEdgeIndex < 0xe))
    {



      for (laneLoop = leftEdgeIndex; (int)laneLoop <= (int)rightEdgeIndex; laneLoop = laneLoop + 1)
        carObj->carInLane = carObj->carInLane | 1 << laneLoop;
    }


  /* retail: a long code-less span (SLD function end line 151) follows the last statement */

























































































































}

/* ---- AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj  [@0x80073658] ---- */
/* SLD491..493 separates the two yaw reads and subtraction. NFS2's native
 * AI_CalculateRoadYaw records yaw0/yaw1; yaw1 is optimized out here. The
 * explicit else-zero path restores retail allocation without an asm fence. */

#line 484 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_CalculateDeltaRoadYaw(Car_tObj *carObj)
{
  int delta;

  if ((carObj->carFlags & 8U) != 0)
  {
    int yaw0, yaw1;
    yaw0 = (carObj->N).roadYaw;
    yaw1 = Newton_CalculateSliceYaw(WRAP_SLICE(1,(int)(carObj->N).simRoadInfo.slice));
    delta = yaw1 - yaw0;
    if (0x200 < delta)
      delta = delta + -0x400;
    if (delta < -0x200)
      delta = delta + 0x400;
  }
  else
  {
    delta = 0;
  }






  return delta;
}

/* ---- AIWorld_CalcRoadBend__FP8Car_tObji  [@0x800736e0] ---- */
/* SLD528 computes the complete bend, followed by return at529. NFS2's native
 * AIPhysic_CalcRoadBend supplies the cross-version bend name. Keeping it as
 * the complete sum (not a first-product carrier) eliminates its debug record.
 * Plain signed divisions avoid the reconstruction-only helper's eight scopes. */

#line 517 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_CalcRoadBend(Car_tObj *carObj,int lookAhead)
{
  int thisSlice;
  int nextSlice;
  int bend;


  thisSlice = (int)(carObj->N).simRoadInfo.slice;
  nextSlice = WRAP_SLICE(lookAhead,thisSlice);


  bend = (((int)(signed char)BWorldSm_slices[nextSlice].forward[0] << 9) / 0x100) * (((int)(signed char)BWorldSm_slices[thisSlice].right[0] << 9) / 0x100) + (((int)(signed char)BWorldSm_slices[nextSlice].forward[2] << 9) / 0x100) * (((int)(signed char)BWorldSm_slices[thisSlice].right[2] << 9) / 0x100);
  return bend;
}

/* ---- AIWorld_CalcFutureLateralVel__FP8Car_tObji  [@0x800737bc] ---- */
/* NFS2's native AIPhysic_CalcFutureLateralVel supplies temp for the complete
 * dot product. SLD551 computes that sum and553 returns it; temp optimizes out. */

#line 536 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_CalcFutureLateralVel(Car_tObj *carObj,int slicesAhead)
{ Car_tObj *devLocal_Car_tObj; /* DEVICE (exact-only): record-less unused local; retail aiworld.obj type record #227 (TPDEF Car_tObj) between Car_tObj and coorddef, inside AIWorld_CalcFutureLateralVel__FP8Car_tObji's record run (locals-before-params, GSDATA_state 7h) */
  int temp;
  coorddef right;
  int futureSlice;
  int currentSlice;

  if ((carObj->carFlags & 0x10U) != 0 && __builtin_abs(carObj->currentSpeed) < 0x140000)
    slicesAhead = 0;

  currentSlice = (carObj->N).simRoadInfo.slice;
  futureSlice = WRAP_SLICE(slicesAhead,currentSlice);
  right.x = (int)(signed char)BWorldSm_slices[futureSlice].right[0] << 9;
  right.y = (int)(signed char)BWorldSm_slices[futureSlice].right[1] << 9;
  right.z = (int)(signed char)BWorldSm_slices[futureSlice].right[2] << 9;
  temp = fixedmult((carObj->N).linearVel.x,right.x) + fixedmult((carObj->N).linearVel.y,right.y) + fixedmult((carObj->N).linearVel.z,right.z);

  return temp;
}

/* ---- AIWorld_CalcSpeed__FP8Car_tObj  [@0x800738d4] ---- */
/* Native SYM16f19d/16f1b2 records these original INT names in a1/v1:
   optVar1 holds the X velocity and optVar2 the Z velocity. */

#line 556 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
void AIWorld_CalcSpeed(Car_tObj *carObj)
{
  int optVar1, optVar2;
  optVar1 = (carObj->N).linearVel.x;
  optVar2 = (carObj->N).linearVel.z;
  optVar1 = __builtin_abs(optVar1);
  optVar2 = __builtin_abs(optVar2);
  carObj->speed = (optVar2 < optVar1) ? optVar1 + (optVar2 >> 2) : optVar2 + (optVar1 >> 2);
}

/* ---- AIWorld_CalcLateralVelocity__FP8Car_tObj  [@0x8007391c] ---- */
/* Native temp accumulates each fixed product before the next call. */

#line 566 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
int AIWorld_CalcLateralVelocity(Car_tObj *carObj)
{
  int temp;

  temp = fixedmult((carObj->N).linearVel.x,(carObj->N).roadMatrix.m[0]);
  temp = temp + fixedmult((carObj->N).linearVel.y,(carObj->N).roadMatrix.m[1]);
  temp = temp + fixedmult((carObj->N).linearVel.z,(carObj->N).roadMatrix.m[2]);

  return temp;
}

/* ---- AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1  [@0x80073978] ---- */

#line 577 "C:/nfs4/GAME/COMMON/AIWORLD.CPP"
void AIWorld_FindBarrierLessLaneAndPosition(Car_tObj *carObj,int *goodLane,int *goodPosition)
{
  int roadSide = carObj->direction * AITune_driveSide;
  int laneWidth;
  int laneLoop = 0;
  if (roadSide == 1)
  {
    *goodLane = 7;
    laneWidth = BWorldSm_slices[(carObj->N).simRoadInfo.slice].avgPavedWidthRt << 15;
  }
  else
  {
    *goodLane = 6;
    laneWidth = BWorldSm_slices[(carObj->N).simRoadInfo.slice].avgPavedWidthLf << 15;
  }


  while (laneLoop < 3 && AIWorld_IsDriveableLane((int)(carObj->N).simRoadInfo.slice,*goodLane) == 0)
  {
    laneLoop++;
    *goodLane = *goodLane + roadSide;
  }




  *goodPosition = roadSide * (laneWidth * laneLoop + ((u_int)laneWidth >> 1));
}
