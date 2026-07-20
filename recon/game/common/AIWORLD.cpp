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
  int profileIndex;   /* SYM: REG -- clamp shape matches GetProfileMask/IsDriveableLane */
  int laneOffset;      /* SYM: REG */
  int mask;             /* SYM: REG -- computed ONCE before the loop */
  int checkSliceOffset;  /* SYM: REG */
  int checkSlice;         /* SYM: REG */
  int sliceDelta;
  int i;

  laneOffset = 7 - laneIndex;
  profileIndex = 8 - laneOffset;
  if (profileIndex < 0) {
    profileIndex = 0;
  }
  if (0xf < profileIndex) {
    profileIndex = 0xf;
  }
  mask = 1 << (0xfU - profileIndex);
  i = 0;
  sliceDelta = 0;
  while (true) {
    if (numSlicesToCheck <= i) {
      return 1;
    }
    checkSlice = startSlice + sliceDelta;
    if (sliceDelta >= 0) {    /* De Morgan complement -- oracle's sliceDelta<0 case is the
                                  branch-TAKEN target, sliceDelta>=0 is the fall-through */
      if (gNumSlices <= checkSlice) {
        checkSlice = checkSlice - gNumSlices;
      }
    }
    else if (checkSlice < 0) {
      checkSlice = checkSlice + gNumSlices;
    }
    checkSliceOffset = checkSlice * 0x20;
    sliceDelta = sliceDelta + direction;
    if ((*(short *)(checkSliceOffset + (int)BWorldSm_slices + 0x16) & mask) == 0) {
      return 0;   /* NOTE: cc1plus normalizes an equivalent `!=0{i++;continue;}return 0;` form to
                     the SAME asm as this -- the oracle's bnez/fallthrough-return-0 layout is a
                     genuine scheduling floor here, not a reachable De Morgan source-shape lever
                     (both forms tried, byte-identical output; remaining 10-diff residual is this
                     + a single-exit `li v0,1` delay-slot-fill scheduling choice, §F class). */
    }
    i = i + 1;
  }
}

/* ---- AIWorld_IsDriveableLane__Fii  [@0x800733a8] ---- */
int AIWorld_IsDriveableLane(int slice,int laneIndex)
{
  int profileIndex;   /* SYM: REG -- rewired from anonymous iVar1, matching the already-fixed
                          AIWorld_GetProfileMask's split-statement clamp shape below */
  int laneOffset;      /* SYM: REG */
  int mask;             /* SYM: REG */

  laneOffset = 7 - laneIndex;
  profileIndex = 8 - laneOffset;
  if (profileIndex < 0) {
    profileIndex = 0;
  }
  if (0xf < profileIndex) {
    profileIndex = 0xf;
  }
  mask = 1 << (0xfU - profileIndex);
  return (int)*(short *)(slice * 0x20 + (int)BWorldSm_slices + 0x16) & mask;
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
  if (profileLane1 < profileLane0) {   /* De Morgan complement of !(lane0<=lane1); the oracle's
                                           ELSE-branch (lane0<=lane1 case) is the FALL-THROUGH,
                                           this complement is the taken-branch target. */
    return ~profile >> (profileLane1) & ~(-1 << ((profileLane0 - profileLane1) + 1));
  }
  return ~profile >> (profileLane0) & ~(-1 << ((profileLane1 - profileLane0) + 1));
}

/* ---- AIWorld_LaneIndex__Fii  [@0x800734cc] ---- */
/* NEAR-MISS (40 diffs, ours 44 / oracle 50 -- 6 insns SHORT): the oracle's
 * `inverseLaneWidthTable[(bVar1<<15)>>14]` index expression keeps gcc's full signed-
 * divide-by-0x4000 codegen (`bgez;addiu 0x3fff;sra 14`, the standard gcc-2.x signed->>N
 * bias-adjust from reference_mips_isa_asm.md), but OUR compile PROVES the shifted byte is
 * always non-negative (max 255<<15 = 0x7F8000, well under 2^31) and folds the whole thing to a
 * bare `sra`/`sll`. Tried: widen bVar1 from u_char->int before use (no effect -- GCC tracks the
 * value's range from the ORIGINATING BYTE LOAD, not the destination variable's declared type);
 * real `BWorldSm_slices[slice].avgPavedWidthLf/Rt` struct-field access instead of raw
 * `*(u_char*)(base+off)` cast (no effect either, same range-proof triggers through field access
 * too). Migrated to the real struct fields for fidelity (avgPavedWidthLf/Rt are genuinely
 * u_char per nfs4_types.h:3092) since it's SYM/type-correct regardless. GENUINE GCC
 * value-range-provable-shift floor; accept, no source-shape lever found. */
int AIWorld_LaneIndex(int slice,int position)
{
  int laneWidth;
  int li;
  u_char bVar1;
  int iVar2;
  int iVar3;

  if (position < 0) {
    bVar1 = BWorldSm_slices[slice].avgPavedWidthLf;
    iVar3 = 6;
  }
  else {
    bVar1 = BWorldSm_slices[slice].avgPavedWidthRt;
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
  u_int rightEdgeIndex;   /* SYM: REG -- u_int: the <0xe clamp test is UNSIGNED (sltiu) */
  u_int leftEdgeIndex;     /* SYM: REG */
  u_int laneLoop;            /* SYM: REG -- loop induction var, separate from leftEdgeIndex.
                                 The LOOP compare itself is SIGNED (oracle `slt`, not `sltu`) --
                                 explicit (int) casts on both sides reproduce that mixed
                                 unsigned-clamp/signed-loop idiom. */
  int iVar2;

  carObj->carInLane = 0;
  if ((carObj->AIFlags & 4U) == 0) {
    /* the oracle RE-READS (carObj->N).simRoadInfo.slice fresh for EACH of the 3 calls (lh @+8,
       three times) instead of caching it into a local -- caching it (as the old `sVar1` did)
       forces an EXTRA value to survive across a call, needing a 3rd callee-saved reg (ours
       saved s0/s1/s2, oracle only s0/s1). Eager-cache-drop, same class as the femenu
       ptVar=FEApp finding in the catalog. */
    iVar2 = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,carObj->roadPosition);
    carObj->laneIndex = iVar2;
    leftEdgeIndex = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,
                       (carObj->roadPosition - carObj->roadSpan) + 0x8000);
    rightEdgeIndex = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,
                       carObj->roadPosition + carObj->roadSpan + -0x8000);
    if ((rightEdgeIndex < 0xe) && (leftEdgeIndex < 0xe)) {
      for (laneLoop = leftEdgeIndex; (int)laneLoop <= (int)rightEdgeIndex; laneLoop = laneLoop + 1) {
        carObj->carInLane = carObj->carInLane | 1 << laneLoop;
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
  int nextSlice;  /* fresh compiler temp (unnamed in SYM) -- keeps the wraparound value OUT of
                      'delta' until the call, so cc1plus can't algebraically reassociate
                      `iVar2 - (gNumSlices-1)` into `delta - gNumSlices` (it did when both
                      branches wrote directly into 'delta': same value, wrong reg/operand shape
                      -- oracle keeps iVar2 alive in its own reg and subtracts gNumSlices-1 from
                      IT, not from delta+1). SPLIT gNumSlices-1 into its own temp `gnLess1` too
                      -- collapsing it to `iVar2 - (gNumSlices + -1)` let cc1plus re-fold back to
                      the same reassociated form; the explicit intermediate keeps it apart. */
  int gnLess1;

  delta = 0;
  if ((carObj->carFlags & 8U) != 0) {
    iVar2 = (int)(carObj->N).simRoadInfo.slice;
    yaw0 = (carObj->N).roadYaw;
    nextSlice = iVar2 + 1;
    if (gNumSlices <= nextSlice) {
      gnLess1 = gNumSlices - 1;
      nextSlice = iVar2 - gnLess1;
    }
    delta = Newton_CalculateSliceYaw(nextSlice);
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
/* REMAINING NEAR-MISS (74 diffs, insn-count-exact 55/55): the front-half `iVar2+lookAhead`
 * clamp is written identically in both the `lookAhead<0` and `lookAhead>=0` arms (matches the
 * SYM's single `nextSlice` REG local across the whole function). cc1plus recognizes the two
 * copies as the SAME redundant computation and hoists ONE shared `addu` into the very first
 * branch's delay slot, reused by BOTH arms (verified in objdump: the taken-path block has no
 * own addu, it reads the delay-slot value). The oracle does NOT share it -- each arm computes
 * `thisSlice+lookAhead` separately (own reg, own insn). Tried: fresh-named temp per arm (no
 * effect -- gcc's RTL-level value numbering isn't source-name-sensitive), if/else branch-order
 * swap (flips branch polarity to bltz matching oracle, but breaks insn-count-exact 55->56,
 * net worse), negation-based rewrite (56->58, worse). GENUINE GCC GCSE-across-branches floor;
 * accept. The road-angle fields ARE real `Trk_NewSlice.forward[3]`/`.right[3]` (plain `char`
 * arrays, nfs4_types.h:3089) -- migrated from raw `*(char*)(base+off)` casts to real
 * `BWorldSm_slices[idx].forward[0]`/`.right[0]` etc. field access, WITH an explicit
 * `(signed char)` cast at each use (oracle emits `lb`; a bare `char` read on this build emits
 * `lbu` -- verified empirically, matches the catalog's char-field rule). Diff count unchanged
 * (still 74, the GCSE floor above dominates) but this is the byte-faithful, SYM/type-correct
 * reconstruction. */
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
  iVar1 = (int)(signed char)BWorldSm_slices[iVar1].forward[0] * 0x200;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar3 = iVar2 * 0x20 + (int)BWorldSm_slices;
  iVar2 = (int)(signed char)BWorldSm_slices[iVar2].right[0] * 0x200;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar4 = (int)(signed char)((Trk_NewSlice *)iVar4)->forward[2] * 0x200;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar3 = (int)(signed char)((Trk_NewSlice *)iVar3)->right[2] * 0x200;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  return (iVar1 >> 8) * (iVar2 >> 8) + (iVar4 >> 8) * (iVar3 >> 8);
}

/* ---- AIWorld_CalcFutureLateralVel__FP8Car_tObji  [@0x800737bc] ---- */
int AIWorld_CalcFutureLateralVel(Car_tObj *carObj,int slicesAhead)
{
  coorddef right;   /* SYM AUTO struct -- the oracle fully MATERIALIZES right.x/y/z (shifted
                        bytes) to the stack BEFORE any fixedmult call (sw 0x10/0x14/0x18(sp)),
                        then reloads right.y/right.z per call -- matches a real named-struct
                        write, not the old cVar1/cVar2 scalar-cache shortcut. */
  int futureSlice;   /* SYM: REG -- rewired from anonymous iVar3's slice-wrap result */
  int currentSlice;   /* SYM: REG -- (carObj->N).simRoadInfo.slice, cached once */
  int iVar3;
  int iVar4;
  int iVar5;
  /* REMAINING residual (52 diffs, insn-count-exact 70/70): carObj lands in s0 here vs oracle's
     s1 (a uniform s0<->s1 swap cascading through the accumulator regs too) -- the same
     "carObj cached across multiple calls, physical reg is a coin-flip" class as
     AIWorld_CalculateDeltaRoadYaw/ZSplineDistance. Tried: decl-order swap (no effect, reverted).
     Accepted as a coloring floor; the 2 real bugs (signed-char BWorldSm_slices reads via real
     Trk_NewSlice.right[] fields, right.x/y/z struct materialization order) are fixed+verified. */

  if ((carObj->carFlags & 0x10U) != 0) {
    iVar3 = carObj->currentSpeed;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    if (iVar3 < 0x140000) {
      slicesAhead = 0;
    }
  }
  currentSlice = (carObj->N).simRoadInfo.slice;
  futureSlice = currentSlice + slicesAhead;
  if (slicesAhead < 0) {
    if (futureSlice < 0) {
      futureSlice = futureSlice + gNumSlices;
    }
  }
  else if (gNumSlices <= futureSlice) {
    futureSlice = futureSlice - gNumSlices;
  }
  right.x = (int)(signed char)BWorldSm_slices[futureSlice].right[0] << 9;
  right.y = (int)(signed char)BWorldSm_slices[futureSlice].right[1] << 9;
  right.z = (int)(signed char)BWorldSm_slices[futureSlice].right[2] << 9;
  iVar3 = fixedmult((carObj->N).linearVel.x,right.x);
  iVar4 = fixedmult((carObj->N).linearVel.y,right.y);
  iVar5 = fixedmult((carObj->N).linearVel.z,right.z);
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
  int roadSide;    /* SYM: REG -- direction*driveSide, rewired from anonymous iVar2 */
  u_int laneWidth;   /* SYM: REG -- materialized PRE-SHIFTED (byte<<15) right where the byte is
                         read (oracle: `sll s1,v0,15` right after each branch's `lbu`), not kept
                         raw and multiplied later -- lets the shifted value be reused directly
                         by the loop-trailing multiply/shift below without re-deriving it. */
  int laneLoop;      /* SYM: REG -- rewired from anonymous iVar4 */
  int iVar3;

  roadSide = carObj->direction * AITune_driveSide;
  laneLoop = 0;
  if (roadSide == 1) {
    *goodLane = 7;
    laneWidth = *(u_char *)((carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0x1f) << 15;
  }
  else {
    *goodLane = 6;
    laneWidth = *(u_char *)((carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0x1e) << 15;
  }
  for (; laneLoop < 3; laneLoop = laneLoop + 1) {
    iVar3 = AIWorld_IsDriveableLane((int)(carObj->N).simRoadInfo.slice,*goodLane);
    if (iVar3 != 0) break;
    *goodLane = *goodLane + roadSide;
  }
  *goodPosition = roadSide * (laneWidth * laneLoop + (laneWidth >> 1));
  return;
}
