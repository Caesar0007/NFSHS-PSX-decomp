/* game/common/AIWORLD.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "AIWORLD_externs.h"


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
int AIWorld_ZSplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  coorddef relPos;    /* SYM AUTO struct @-0x28 -- H27 FIX: the oracle fully materializes ALL 3
                          components of relPos/forward on the stack (incl. the UNUSED .y) before
                          the two fixedmult calls; recon had inlined only the .x/.z terms actually
                          consumed, dropping 2 subu+2 lw (11 insns short). */
  coorddef forward;   /* SYM AUTO struct @-0x18 */

  relPos.x = (carObj->N).position.x - (otherCarObj->N).position.x;
  relPos.y = (carObj->N).position.y - (otherCarObj->N).position.y;
  relPos.z = (carObj->N).position.z - (otherCarObj->N).position.z;
  forward.x = (carObj->N).roadMatrix.m[6];
  forward.y = (carObj->N).roadMatrix.m[7];
  forward.z = (carObj->N).roadMatrix.m[8];
  return fixedmult(relPos.x,forward.x) + fixedmult(relPos.z,forward.z);
}

/* ---- AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef  [@0x80073024] ---- */
int AIWorld_ZSplineDistance(coorddef *pos1,coorddef *pos2,matrixtdef *roadMatrix)
{
  coorddef relPos;    /* SYM AUTO struct @-0x28 -- H27 FIX (see the FP8Car_tObjT0 overload above):
                          fully materialize relPos/forward incl. the unused .y component. */
  coorddef forward;   /* SYM AUTO struct @-0x18 */

  relPos.x = pos1->x - pos2->x;
  relPos.y = pos1->y - pos2->y;
  relPos.z = pos1->z - pos2->z;
  forward.x = roadMatrix->m[6];
  forward.y = roadMatrix->m[7];
  forward.z = roadMatrix->m[8];
  return fixedmult(relPos.x,forward.x) + fixedmult(relPos.z,forward.z);
}

/* ---- AIWorld_ApxSplineDistance__FP8Car_tObjT0  [@0x800730b8] ---- */
int AIWorld_ApxSplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  int diff;
  int halfTrack;
  int a;
  int b;
  int iVar1;
  int iVar2;
  
  diff = (int)(carObj->N).simRoadInfo.slice - (int)(otherCarObj->N).simRoadInfo.slice;   /* SYM: diff REG $a0 */
  halfTrack = gNumSlices / 2;   /* SYM: halfTrack REG $a1 -- computed ONCE, reused below
                                    (recon had `gNumSlices/2` inlined twice, a double-roll bug) */
  if (!(diff < 1) && !(diff <= halfTrack)) {
    diff = diff - gNumSlices;
  }
  else {
    iVar1 = diff * 2;
    if (-1 < diff) goto LAB_8007311c;
    if (diff < -halfTrack) {
      diff = diff + gNumSlices;
    }
  }
  iVar1 = diff << 1;
LAB_8007311c:
  return (iVar1 + diff) * 0x20000;
}

/* ---- AIWorld_ApxSplineDistance__FP8Car_tObji  [@0x80073128] ---- */
int AIWorld_ApxSplineDistance(Car_tObj *carObj,int location)
{
  int diff;
  int halfTrack;
  int a;
  int iVar1;
  int iVar2;
  
  diff = (carObj->N).simRoadInfo.slice - location;   /* SYM: diff REG $a0 */
  halfTrack = gNumSlices / 2;   /* SYM: halfTrack REG $a1 -- computed ONCE (double-roll bug) */
  if (!(diff < 1) && !(diff <= halfTrack)) {
    diff = diff - gNumSlices;
  }
  else {
    iVar1 = diff * 2;
    if (-1 < diff) goto LAB_80073188;
    if (diff < -halfTrack) {
      diff = diff + gNumSlices;
    }
  }
  iVar1 = diff << 1;
LAB_80073188:
  return (iVar1 + diff) * 0x20000;
}

/* ---- AIWorld_ApxSplineDistance__FiP8Car_tObj  [@0x80073194] ---- */
int AIWorld_ApxSplineDistance(int location,Car_tObj *carObj)
{
  int iVar1;
  
  iVar1 = AIWorld_ApxSplineDistance(carObj,location);
  return -iVar1;
}

/* ---- AIWorld_ApxSplineDistance__Fii  [@0x800731bc] ---- */
int AIWorld_ApxSplineDistance(int locationA,int locationB)
{
  int diff;
  int halfTrack;
  int iVar1;
  int iVar2;
  
  diff = locationA - locationB;   /* SYM: diff REG $a0 */
  halfTrack = gNumSlices / 2;   /* SYM: halfTrack REG $a1 -- computed ONCE (double-roll bug) */
  if (!(diff < 1) && !(diff <= halfTrack)) {
    diff = diff - gNumSlices;
  }
  else {
    iVar1 = diff * 2;
    if (-1 < diff) goto LAB_80073218;
    if (diff < -halfTrack) {
      diff = diff + gNumSlices;
    }
  }
  iVar1 = diff << 1;
LAB_80073218:
  return (iVar1 + diff) * 0x20000;
}

/* ---- AIWorld_SplineDistance__FP8Car_tObjT0  [@0x80073224] ---- */
int AIWorld_SplineDistance(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  int iVar1;

  iVar1 = AIWorld_ApxSplineDistance(carObj,otherCarObj);
  if (iVar1 + 0xc0000U < 0x180001) {
    return AIWorld_ZSplineDistance(carObj,otherCarObj);
  }
  return iVar1;
}

/* ---- AIWorld_SplineDistance__FP8Car_tObjiP8coorddef  [@0x8007327c] ---- */
int AIWorld_SplineDistance(Car_tObj *carObj,int location,coorddef *position)
{
  int distance;
  int iVar1;

  iVar1 = AIWorld_ApxSplineDistance(carObj,location);
  if (iVar1 + 0xc0000U < 0x180001) {
    return AIWorld_ZSplineDistance(&(carObj->N).position,position,&(carObj->N).roadMatrix);
  }
  return iVar1;
}

/* ---- AIWorld_GameOdometer__FP8Car_tObj  [@0x800732d8] ---- */
int AIWorld_GameOdometer(Car_tObj *carObj)
{
  return (u_int)(carObj->N).totalSlice * 0x60000;
}

/* ---- AIWorld_IsDriveableLaneInSliceRange__Fiiii  [@0x800732f0] ---- */
int AIWorld_IsDriveableLaneInSliceRange(int startSlice,int numSlicesToCheck,int direction,int laneIndex)
{
  int profileIndex;
  int laneOffset;
  int mask;
  int checkSliceOffset;
  int checkSlice;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  
  iVar3 = 8 - (7 - laneIndex);
  iVar4 = iVar3;
  if (iVar3 < 0) {
    iVar4 = 0;
  }
  if (0xf < iVar3) {
    iVar4 = 0xf;
  }
  iVar6 = 0;
  iVar3 = 0;
  do {
    if (numSlicesToCheck <= iVar6) {
      return 1;
    }
    iVar5 = startSlice + iVar3;
    if (iVar3 < 0) {
      iVar2 = iVar5 * 0x20;
      iVar1 = gNumSlices;
      if (iVar5 < 0) goto LAB_80073374;
    }
    else {
      iVar2 = iVar5 * 0x20;
      if (gNumSlices <= iVar5) {
        iVar1 = -gNumSlices;
LAB_80073374:
        iVar2 = (iVar5 + iVar1) * 0x20;
      }
    }
    iVar3 = iVar3 + direction;
    if (((int)*(short *)(iVar2 + BWorldSm_slices + 0x16) & 1 << (0xfU - iVar4 & 0x1f)) == 0) {
      return 0;
    }
    iVar6 = iVar6 + 1;
  } while( true );
}

/* ---- AIWorld_IsDriveableLane__Fii  [@0x800733a8] ---- */
int AIWorld_IsDriveableLane(int slice,int laneIndex)
{
  int profileIndex;
  int laneOffset;
  int mask;
  int iVar1;
  
  iVar1 = 8 - (7 - laneIndex);
  if (iVar1 < 0) {
    iVar1 = 0;
  }
  if (0xf < iVar1) {
    iVar1 = 0xf;
  }
  return (int)*(short *)(slice * 0x20 + (int)BWorldSm_slices + 0x16) & 1 << (0xfU - iVar1);
}

/* ---- AIWorld_GetProfileMask__Fi  [@0x800733fc] ---- */
int AIWorld_GetProfileMask(int laneIndex)
{
  int profileIndex;   /* SYM: REG $v1 -- rewired from anonymous iVar1/iVar2 */
  int laneOffset;      /* SYM: REG $v0 */

  laneOffset = 7 - laneIndex;      /* split into 2 statements matching the oracle's literal
                                       two subu ops -- a single `8 - (7 - laneIndex)` expression
                                       gets constant-folded to laneIndex+1 by cc1plus, 3 insns short */
  profileIndex = 8 - laneOffset;
  if (profileIndex < 0) {
    profileIndex = 0;
  }
  if (0xf < profileIndex) {
    profileIndex = 0xf;
  }
  return 1 << (0xfU - profileIndex);
}

/* ---- AIWorld_IsDriveableLane_UsingMask__Fii  [@0x8007343c] ---- */
int AIWorld_IsDriveableLane_UsingMask(int slice,int mask)
{
  return *(short *)(slice * 0x20 + (int)BWorldSm_slices + 0x16) & mask;
}

/* ---- AIWorld_CheckForBarrierBetweenLanes__Fiii  [@0x80073458] ---- */
int AIWorld_CheckForBarrierBetweenLanes(int slice,int lane0,int lane1)
{
  int profileLane0;   /* SYM: REG $a1 -- rewired from anonymous uVar3 */
  int profileLane1;   /* SYM: REG $v1 -- rewired from anonymous uVar1 */
  int profile;        /* SYM: REG $a0 -- rewired from anonymous uVar2 */

  profile = (int)*(short *)(slice * 0x20 + (int)BWorldSm_slices + 0x16);
  profileLane0 = 0xe - lane0;
  profileLane1 = 0xe - lane1;
  if (profileLane0 <= profileLane1) {
    return ~profile >> (profileLane0) & ~(-1 << ((profileLane1 - profileLane0) + 1));
  }
  return ~profile >> (profileLane1) & ~(-1 << ((profileLane0 - profileLane1) + 1));
}

/* ---- AIWorld_LaneIndex__Fii  [@0x800734cc] ---- */
int AIWorld_LaneIndex(int slice,int position)
{
  int laneWidth;
  int li;
  u_char bVar1;
  int iVar2;
  int iVar3;
  
  if (position < 0) {
    bVar1 = *(u_char *)(slice * 0x20 + (int)BWorldSm_slices + 0x1e);
    iVar3 = 6;
  }
  else {
    bVar1 = *(u_char *)(slice * 0x20 + (int)BWorldSm_slices + 0x1f);
    iVar3 = 7;
  }
  iVar2 = fixedmult(position,inverseLaneWidthTable[(int)((u_int)bVar1 * 0x8000) >> 0xe]);
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xffff;
  }
  iVar3 = iVar3 + (iVar2 >> 0x10);
  if (iVar3 < 0) {
    iVar3 = 0;
  }
  iVar2 = 0xd;
  if (iVar3 < 0xe) {
    iVar2 = iVar3;
  }
  return iVar2;
}

/* ---- AIWorld_CalculateLaneInfo__FP8Car_tObj  [@0x80073594] ---- */
void AIWorld_CalculateLaneInfo(Car_tObj *carObj)
{
  int rightEdgeIndex;
  int leftEdgeIndex;
  int laneLoop;
  short sVar1;
  int iVar2;
  u_int uVar3;
  u_int uVar4;
  
  carObj->carInLane = 0;
  if ((carObj->AIFlags & 4U) == 0) {
    iVar2 = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,carObj->roadPosition);
    sVar1 = (carObj->N).simRoadInfo.slice;
    carObj->laneIndex = iVar2;
    uVar3 = AIWorld_LaneIndex((int)sVar1,(carObj->roadPosition - carObj->roadSpan) + 0x8000);
    uVar4 = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,
                       carObj->roadPosition + carObj->roadSpan + -0x8000);
    if ((uVar4 < 0xe) && (uVar3 < 0xe)) {
      for (; (int)uVar3 <= (int)uVar4; uVar3 = uVar3 + 1) {
        carObj->carInLane = carObj->carInLane | 1 << (uVar3);
      }
    }
  }
  return;
}

/* ---- AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj  [@0x80073658] ---- */
int AIWorld_CalculateDeltaRoadYaw(Car_tObj *carObj)
{
  int delta;     /* SYM: REG $a0, whole-function scope -- rewired from anonymous iVar1 */
  int yaw0;      /* SYM: REG $s0, block-scoped inside the if -- rewired from anonymous iVar3 */
  int iVar2;

  delta = 0;
  if ((carObj->carFlags & 8U) != 0) {
    iVar2 = (int)(carObj->N).simRoadInfo.slice;
    yaw0 = (carObj->N).roadYaw;
    delta = iVar2 + 1;
    if (gNumSlices <= delta) {
      delta = iVar2 - (gNumSlices + -1);
    }
    delta = Newton_CalculateSliceYaw(delta);
    delta = delta - yaw0;
    if (0x200 < delta) {
      delta = delta + -0x400;
    }
    if (delta < -0x200) {
      delta = delta + 0x400;
    }
  }
  return delta;
}

/* ---- AIWorld_CalcRoadBend__FP8Car_tObji  [@0x800736e0] ---- */
int AIWorld_CalcRoadBend(Car_tObj *carObj,int lookAhead)
{
  int thisSlice;
  int nextSlice;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  
  iVar2 = (int)(carObj->N).simRoadInfo.slice;
  if (lookAhead < 0) {
    iVar1 = iVar2 + lookAhead;
    if (iVar1 < 0) {
      iVar1 = iVar1 + gNumSlices;
    }
  }
  else {
    iVar1 = iVar2 + lookAhead;
    if (gNumSlices <= iVar1) {
      iVar1 = iVar1 - gNumSlices;
    }
  }
  iVar4 = iVar1 * 0x20 + (int)BWorldSm_slices;
  iVar1 = *(char *)(iVar4 + 0xf) * 0x200;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar3 = iVar2 * 0x20 + (int)BWorldSm_slices;
  iVar2 = *(char *)(iVar3 + 0x12) * 0x200;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar4 = *(char *)(iVar4 + 0x11) * 0x200;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar3 = *(char *)(iVar3 + 0x14) * 0x200;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  return (iVar1 >> 8) * (iVar2 >> 8) + (iVar4 >> 8) * (iVar3 >> 8);
}

/* ---- AIWorld_CalcFutureLateralVel__FP8Car_tObji  [@0x800737bc] ---- */
int AIWorld_CalcFutureLateralVel(Car_tObj *carObj,int slicesAhead)
{
  coorddef right;
  int futureSlice;
  int currentSlice;
  char cVar1;
  char cVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  
  if ((carObj->carFlags & 0x10U) != 0) {
    iVar3 = carObj->currentSpeed;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    if (iVar3 < 0x140000) {
      slicesAhead = 0;
    }
  }
  iVar3 = (carObj->N).simRoadInfo.slice + slicesAhead;
  if (slicesAhead < 0) {
    if (iVar3 < 0) {
      iVar3 = iVar3 + gNumSlices;
    }
  }
  else if (gNumSlices <= iVar3) {
    iVar3 = iVar3 - gNumSlices;
  }
  iVar3 = iVar3 * 0x20 + (int)BWorldSm_slices;
  cVar1 = *(char *)(iVar3 + 0x13);
  cVar2 = *(char *)(iVar3 + 0x14);
  iVar3 = fixedmult((carObj->N).linearVel.x,(int)*(char *)(iVar3 + 0x12) << 9);
  iVar4 = fixedmult((carObj->N).linearVel.y,(int)cVar1 << 9);
  iVar5 = fixedmult((carObj->N).linearVel.z,(int)cVar2 << 9);
  return iVar3 + iVar4 + iVar5;
}

/* ---- AIWorld_CalcSpeed__FP8Car_tObj  [@0x800738d4] ---- */
void AIWorld_CalcSpeed(Car_tObj *carObj)
{
  int optVar1;
  int optVar2;
  int iVar1;
  int iVar2;
  
  iVar2 = (carObj->N).linearVel.x;
  iVar1 = (carObj->N).linearVel.z;
  iVar2 = __builtin_abs(iVar2);
  iVar1 = __builtin_abs(iVar1);
  if (iVar1 < iVar2) {
    carObj->speed = iVar2 + (iVar1 >> 2);
    return;
  }
  carObj->speed = iVar1 + (iVar2 >> 2);
  return;
}

/* ---- AIWorld_CalcLateralVelocity__FP8Car_tObj  [@0x8007391c] ---- */
int AIWorld_CalcLateralVelocity(Car_tObj *carObj)
{
  int temp;

  temp = fixedmult((carObj->N).linearVel.x,(carObj->N).roadMatrix.m[0]);   /* running accumulator,
                                    matches the oracle's immediate addu-after-each-call shape --
                                    NOT 3 separate iVar1/2/3 results summed at the end */
  temp = temp + fixedmult((carObj->N).linearVel.y,(carObj->N).roadMatrix.m[1]);
  temp = temp + fixedmult((carObj->N).linearVel.z,(carObj->N).roadMatrix.m[2]);
  return temp;
}

/* ---- AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1  [@0x80073978] ---- */
void AIWorld_FindBarrierLessLaneAndPosition(Car_tObj *carObj,int *goodLane,int *goodPosition)
{
  int laneWidth;
  int laneLoop;
  u_char bVar1;
  int iVar2;
  int currentSlice;
  int iVar3;
  int optVar2;
  int delta;
  int optVar1;
  int thisSlice;
  int checkSlice;
  int checkSliceOffset;
  int temp;
  int iVar4;
  int roadSide;
  coorddef right;
  
  iVar2 = carObj->direction * AITune_driveSide;
  iVar4 = 0;
  if (iVar2 == 1) {
    *goodLane = 7;
    bVar1 = *(u_char *)((carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0x1f);
  }
  else {
    *goodLane = 6;
    bVar1 = *(u_char *)((carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0x1e);
  }
  do {
    iVar3 = AIWorld_IsDriveableLane((int)(carObj->N).simRoadInfo.slice,*goodLane);
    if (iVar3 != 0) break;
    iVar4 = iVar4 + 1;
    *goodLane = *goodLane + iVar2;
  } while (iVar4 < 3);
  *goodPosition = iVar2 * ((u_int)bVar1 * 0x8000 * iVar4 + ((u_int)bVar1 * 0x8000 >> 1));
  return;
}
