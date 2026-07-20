/* game/common/aitriger.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   anim.obj = 18 fns: AnimScript C++ class (3 ctors + SetAnimAttrib/GetAnimFrameInfo/
 *   GetTimedAnimPosRot[x2 overload]/GetStatus) + 10 free Anim_* fns. AnimScript non-virtual
 *   (20 B, declared in nfs4_types.h). Faithful C++: `new AnimScript(..)`, obj->Method(..).
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "aitriger_externs.h"


/* ---- anim.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
AITrigger_TriggerManager *triggerManagerCops;   /* @0x8013c5e8  (bss(zero)) */
AITrigger_TriggerManager *triggerManagerTraffic;   /* @0x8013c5ec  (bss(zero)) */


/* ---- AITrigger_TriggerManager::Init  [@0x8007286c] ---- */
void AITrigger_TriggerManager::Init(char *rawTriggers)
{
  int *numTriggers;
  char *currentTrigger;
  int tLoop;
  trigger_t **pptVar2;
  trigger_t *deletedMarker;

  deletedMarker = (trigger_t *)0xfffff600;
  tLoop = 99;
  pptVar2 = this->triggers_ + 0x61;
  this->numTriggers_ = 0;
  this->invNumTriggers_ = 0;
  do {
    pptVar2[0x66] = deletedMarker;
    tLoop = tLoop + -1;
    pptVar2 = pptVar2 + -1;
  } while (-1 < tLoop);
  tLoop = 8;
  pptVar2 = this->triggers_ + 6;
  do {
    pptVar2[0xca] = (trigger_t *)0x0;
    tLoop = tLoop + -1;
    pptVar2 = pptVar2 + -1;
  } while (-1 < tLoop);
  if (rawTriggers != (char *)0x0) {
    numTriggers = (int *)rawTriggers;   /* SYM: numTriggers is a REG PTR INT, aliases rawTriggers's count header */
    currentTrigger = rawTriggers + 4;   /* SYM: currentTrigger is a REG PTR CHAR (byte cursor, NOT trigger_t* -- must NOT scale by sizeof(trigger_t)=72) */
    if (0 < *numTriggers) {
      tLoop = 0;
      do {
        currentTrigger = currentTrigger + this->InsertTrigger((trigger_t *)currentTrigger,true);
        tLoop = tLoop + 1;
      } while (tLoop < *numTriggers);
    }
    this->Sort();
    if (this->numTriggers_ != 0) {
      this->invNumTriggers_ = fixeddiv(0x10000,this->numTriggers_ << 0x10);
    }
  }
  return;
}

/* ---- AITrigger_TriggerManager::InsertTrigger  [@0x80072948] ---- */
int AITrigger_TriggerManager::InsertTrigger(trigger_t *trigger,bool fromFile)
{
  int iVar1;
  int size;

  size = 0;
  this->DescribeTrigger(trigger);
  iVar1 = *(int *)trigger;
  if (iVar1 == 5) {
    if (fromFile) {   /* @0x80072984: if(fromFile) bool test (disasm-v3) */
      /* SYM/type fix (w19-a4): trigger is trigger_t* (72-byte union) -- raw `trigger+0x3c`
       * pointer arithmetic SCALED by sizeof(trigger_t)=72 (bogus offsets 4320/4608 vs the
       * oracle's plain +0x3C/+0x40 byte displacements). +0x3C/+0x40 are the real
       * trigger_trafficPath_t::path field (a trigger_pathPosition_t* right after the header). */
      trigger->trafficPath.path = (trigger_pathPosition_t *)((char *)trigger + 0x40);
    }
    this->triggers_[this->numTriggers_] = trigger;
    size = trigger->trafficPath.numPoints * sizeof(trigger_pathPosition_t) + 0x40;
    goto LAB_80072a14;
  }
  if (iVar1 == 2) {
    size = 0x14;
  }
  else if (iVar1 < 3) {
    if (iVar1 == 1) {
      size = 0x14;
    }
  }
  else if (iVar1 == 3) {
    size = 0x48;
  }
  this->triggers_[this->numTriggers_] = trigger;
LAB_80072a14:
  this->numTriggers_ = this->numTriggers_ + 1;
  return size;
}

/* ---- AITrigger_TriggerManager::GetNextTrigger  [@0x80072a44] ---- */
trigger_t *
AITrigger_TriggerManager::GetNextTrigger(int car)
{
  int iVar1;

  if (this->numTriggers_ == 0) {
    return (trigger_t *)0x0;
  }
  iVar1 = this->lastTriggerChecked_[car] + 1;
  this->lastTriggerChecked_[car] = iVar1;
  if (iVar1 == this->numTriggers_) {
    this->lastTriggerChecked_[car] = 0;
  }
  if (this->lastTriggerChecked_[car] >= this->numTriggers_) {
    return (trigger_t *)0x0;
  }
  return this->triggers_[this->lastTriggerChecked_[car]];
}

/* ---- AITrigger_TriggerManager::GetPrevTrigger  [@0x80072ab4] ---- */
trigger_t *
AITrigger_TriggerManager::GetPrevTrigger(int car)
{
  int iVar1;

  if (this->numTriggers_ == 0) {
    return (trigger_t *)0x0;
  }
  iVar1 = this->lastTriggerChecked_[car] + -1;
  this->lastTriggerChecked_[car] = iVar1;
  if (iVar1 == -1) {
    this->lastTriggerChecked_[car] = this->numTriggers_ + -1;
  }
  if (this->lastTriggerChecked_[car] >= this->numTriggers_) {
    return (trigger_t *)0x0;
  }
  return this->triggers_[this->lastTriggerChecked_[car]];
}

/* ---- AITrigger_TriggerManager::CheckForTriggerAtSlice  [@0x80072b24] ---- */
int AITrigger_TriggerManager::CheckForTriggerAtSlice(int car,int slice)
{
  int *lastTrigger;
  int iVar1;

  if (this->numTriggers_ == 0) {
    return -1;
  }
  /* SYM/type fix (w19-a4): lastTrigger is the SYM-named REG PTR INT local; triggers_[idx] is
   * trigger_t* (72-byte union) -- raw `+4` pointer arithmetic on it SCALED by 72 (bogus +288
   * vs the oracle's plain +4). ->any.slice/->any.type are the real common-header fields. */
  lastTrigger = &this->lastTriggerChecked_[car];
  if ((this->triggers_[*lastTrigger]->any.slice < slice) && (1 < this->numTriggers_)) {
    while (this->triggers_[*lastTrigger]->any.slice < slice) {
      if (*lastTrigger == this->numTriggers_ + -1) break;
      this->GetNextTrigger(car);
    }
  }
  else {
    if ((slice < this->triggers_[*lastTrigger]->any.slice) && (1 < this->numTriggers_)) {
      while (slice < this->triggers_[*lastTrigger]->any.slice) {
        if (*lastTrigger == 0) break;
        this->GetPrevTrigger(car);
      }
    }
  }
  iVar1 = -1;
  if (((this->triggers_[*lastTrigger]->any.slice == slice) &&
      (0xa00 < simGlobal.gameTicks - this->checkTime_[*lastTrigger])) &&
     (this->triggers_[*lastTrigger]->any.type != 2)) {
    iVar1 = *lastTrigger;
  }
  return iVar1;
}

/* ---- AITrigger_TriggerManager::GetTrigger  [@0x80072cd8] ---- */
trigger_t *
AITrigger_TriggerManager::GetTrigger(int trigger,int *used)
{
  int triggerNum;
  trigger_t *ptVar1;
  
  if (0xa00 < simGlobal.gameTicks - this->checkTime_[trigger]) {
    *used = 0;
  }
  else {
    *used = 1;
  }
  this->checkTime_[trigger] = simGlobal.gameTicks;
  ptVar1 = (trigger_t *)0x0;
  if (trigger < this->numTriggers_) {
    ptVar1 = this->triggers_[trigger];
  }
  return ptVar1;
}

/* ---- AITrigger_TriggerManager::CheckForClosestTriggerOfType  [@0x80072d40] ---- */
int AITrigger_TriggerManager::CheckForClosestTriggerOfType(int slice,triggerType type,int direction)
{
  int tLoop;
  trigger_t *prevTrigger;
  trigger_t *firstTrigger;
  int prevTriggerIndex;
  int firstTriggerIndex;
  trigger_t *thisTrigger;
  int numTriggers;

  /* SYM-driven rewrite (w19-a4): SYM shows `fsize=0 mask=$00000000` -- a TRUE LEAF (no saved
   * regs, no stack frame at all). The Ghidra "shadow ptVar6/iVar8 provisional update, commit
   * at loop bottom" pattern was a decompiler SSA artifact -- the real source updates
   * prevTrigger/prevTriggerIndex directly (unconditionally, once per matching-type iteration)
   * right after the direction-based early-return checks. Also fixes the 72-byte trigger_t*
   * pointer-scaling bug (`ptVar3+4` -> ->any.slice). `this` (a0) is dead after the initial
   * count check (numTriggers_ cached AFTER the zero-test, not before) -- gcc strength-reduces
   * the `triggers_[tLoop]` index into a0 itself incrementing by 4/iter with a fixed +8 load
   * displacement (triggers_'s field offset), matching the oracle exactly. */
  prevTrigger = (trigger_t *)0x0;
  firstTrigger = prevTrigger;
  prevTriggerIndex = -1;
  firstTriggerIndex = -1;
  if (this->numTriggers_ == 0) {
    return prevTriggerIndex;
  }
  tLoop = 0;
  numTriggers = this->numTriggers_;
  while (true) {
    if (numTriggers <= tLoop) break;
    thisTrigger = this->triggers_[tLoop];
    if (thisTrigger->any.type == type) {
      if (firstTrigger == (trigger_t *)0x0) {
        firstTrigger = thisTrigger;
        firstTriggerIndex = tLoop;
      }
      if (thisTrigger->any.slice == slice) {
        return tLoop;
      }
      if (slice < thisTrigger->any.slice) {
        if (0 < direction) {
          return tLoop;
        }
        if ((direction < 0) && (prevTrigger != (trigger_t *)0x0)) {
          return prevTriggerIndex;
        }
      }
      prevTrigger = thisTrigger;
      prevTriggerIndex = tLoop;
    }
    tLoop = tLoop + 1;
  }
  if ((prevTrigger != (trigger_t *)0x0) && (direction < 0)) {
    return prevTriggerIndex;
  }
  if (0 < direction) {
    return firstTriggerIndex;
  }
  return -1;
}

/* ---- AITrigger_TriggerManager::DescribeTrigger  [@0x80072e10] ---- */
void AITrigger_TriggerManager::DescribeTrigger(trigger_t *trigger)
{
  return;
}

/* ---- AITrigger_Compare  [@0x80072e18] ---- */
/* HIDDEN-PHANTOM FIX (w14-a2): oracle mangles __FPCvT0 (const void*, const void* [T0 = same
 * type as param 0]) -- was __FPvT0 (non-const void*), a NAME MISMATCH invisible to the gate.
 * qsort comparator signature; both params really are const (never written). */
int AITrigger_Compare(const void *op1, const void *op2)
{
  trigger_t *ta;
  trigger_t *tb;
  return *(int *)(*(int *)op1 + 4) - *(int *)(*(int *)op2 + 4);
}

/* ---- AITrigger_TriggerManager::Sort  [@0x80072e30] ---- */
void AITrigger_TriggerManager::Sort()
{
  trigger_t *ta;
  trigger_t *tb;
  trigger_t *prevTrigger;
  trigger_t *firstTrigger;
  int prevTriggerIndex;
  int firstTriggerIndex;
  int size;
  int *lastTrigger;
  int *numTriggers;
  
  if (this->numTriggers_ != 0) {
    qsort(this->triggers_,this->numTriggers_,4,(int)AITrigger_Compare /* @0x80072e18 qsort comparator */);
  }
  return;
}
