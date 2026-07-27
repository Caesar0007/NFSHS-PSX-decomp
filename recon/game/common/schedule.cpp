/* game/psx/schedule.cpp -- RECONSTRUCTED (NFS4 PSX cooperative scheduler; C++ TU)
 *   6 fns: Sched_ExecuteCheck/CreateNewSchedule/CleanUpSchedule/AddFunction/DeleteFunction/Execute.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "schedule_externs.h"

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Sched_CleanUpSchedule(Sched_tSchedule *schedule);
void Sched_AddFunction(Sched_tSchedule *schedule,fn_void *function,void *var1,int priority);
void Sched_DeleteFunction(Sched_tSchedule *schedule,fn_void *function,void *var1);
void Sched_Execute(Sched_tSchedule *schedule);


/* ---- Sched_ExecuteCheck__FiiiiPiN24i  [SCHEDULE.CPP:55-83] SLD-VERIFIED ---- */
int Sched_ExecuteCheck(int staggered,int module,int distance,int carId,int *time,int *elapsedTime,int *iTime
              ,int forceNoSimOptz)

{
  int mask;
  int index;
  int distanceIndex;
  int distanceTemp;

  if (0xf < simGlobal.gameTicks) {
    if (distance < 0) {
      distance = distance + 0xf;
    }
    distanceIndex = distance >> 4;
    distanceTemp = distanceIndex;
    if (distanceIndex < 0) {
      distanceTemp = distanceIndex + 0xffff;
    }
    distanceIndex = distanceTemp >> 0x10;
    if (0x13 < distanceIndex) {
      distanceIndex = 0x13;
    }
    if (forceNoSimOptz != 0) {
      distanceIndex = 0;
    }
    index = Sched_gExecuteInfo[module][distanceIndex];
    *time = Sched_ExecuteTimes[index];
    *iTime = Sched_ExecuteiTimes[index];
    *elapsedTime = Sched_ExecuteElapsedTimes[index];
    mask = Sched_ExecuteMasks[index];
    return (u_int)((simGlobal.gameTicks / 2 + carId * staggered & mask) == mask);
  }
  *time = Sched_ExecuteTimes[6];
  *iTime = Sched_ExecuteiTimes[6];
  *elapsedTime = Sched_ExecuteElapsedTimes[6];
  return 1;
}

/* ---- Sched_CreateNewSchedule__FPci  [SCHEDULE.CPP:89-109] SLD-VERIFIED ---- */
Sched_tSchedule *
Sched_CreateNewSchedule(char *scheduleName,int maxFunctions)

{
  int i;
  Sched_tSchedule *newSchedule;
  
  newSchedule = (Sched_tSchedule *)reservememadr(
      scheduleName,maxFunctions * sizeof(Sched_tFunctionSchedule) +
      sizeof(Sched_tSchedule),0);
  newSchedule->maxNumFunctions = maxFunctions;
  newSchedule->numFunctions = 0;
  for (i = 0; i < newSchedule->maxNumFunctions; i++) {
    newSchedule->func[i].priority = 0x7ffe;
    newSchedule->func[i].function = 0;
  }
  return newSchedule;
}

/* ---- Sched_CleanUpSchedule__FP15Sched_tSchedule  [SCHEDULE.CPP:113-118] SLD-VERIFIED ---- */
void Sched_CleanUpSchedule(Sched_tSchedule *schedule)

{
  purgememadr(schedule);
  return;
}

/* ---- Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi  [SCHEDULE.CPP:123-155] SLD-VERIFIED ---- */
void Sched_AddFunction(Sched_tSchedule *schedule,fn_void *function,void *var1,int priority)

{
  int i;
  int j;
  int n;

  schedule->numFunctions = schedule->numFunctions + 1;
  i = n = 0;
  if (0 < schedule->numFunctions) {
    do {
      n = i;
      if (priority < schedule->func[i].priority) {
        j = schedule->numFunctions + -1;
        if (n < j) {
          do {
            *(Sched_tFunctionSchedule *)
                ((char *)schedule + j * sizeof(Sched_tFunctionSchedule) + 8) =
                *(Sched_tFunctionSchedule *)
                ((char *)schedule + j * sizeof(Sched_tFunctionSchedule) + -8);
            j = j + -1;
          } while (i < j);
        }
        break;
      }
      i = n + 1;
    } while (i < schedule->numFunctions);
  }
  schedule->func[n].priority = priority;
  schedule->func[n].function = (void *)function;
  schedule->func[n].var1 = var1;
  return;
}

/* ---- Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv  [SCHEDULE.CPP:160-183] SLD-VERIFIED ---- */
void Sched_DeleteFunction(Sched_tSchedule *schedule,fn_void *function,void *var1)

{
  int count;
  int i;
  int j;

  count = schedule->numFunctions;
  if (count != 0) {
    i = 0;
    if (0 < count) {
      do {
        if ((schedule->func[i].function == (void *)function) &&
            (schedule->func[i].var1 == var1))
        {
          j = i;
          if (j < count + -1) {
            do {
              *(Sched_tFunctionSchedule *)
                  ((char *)schedule +
                   j * sizeof(Sched_tFunctionSchedule) + 8) =
                  *(Sched_tFunctionSchedule *)
                  ((char *)schedule +
                   j * sizeof(Sched_tFunctionSchedule) + 24);
              j = j + 1;
            } while (j < schedule->numFunctions + -1);
          }
          break;
        }
        count = schedule->numFunctions;
        i = i + 1;
      } while (i < count);
    }
    schedule->func[schedule->numFunctions].priority = 0x7ffe;
    schedule->numFunctions = schedule->numFunctions + -1;
  }
  return;
}

/* ---- Sched_Execute__FP15Sched_tSchedule  [SCHEDULE.CPP:195-206] SLD-VERIFIED ---- */
void Sched_Execute(Sched_tSchedule *schedule)

{
  void *ppuVar1;
  int mask;
  int distanceIndex;
  int j;
  int n;
  int i;
  int iVar2;

  iVar2 = 0;
  if (0 < schedule->numFunctions) {
    do {
      ppuVar1 = schedule->func[iVar2].function;
      if (ppuVar1 != (void *)0x0) {
        (*(fn_void *)ppuVar1)(schedule->func[iVar2].var1);
      }
      iVar2 = iVar2 + 1;
    } while (iVar2 < schedule->numFunctions);
  }
  return;
}

/* end of schedule.cpp */
