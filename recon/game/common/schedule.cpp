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
  u_char bVar1;
  int mask;
  int index;
  int distanceIndex;
  int iVar2;
  
  if (0xf < simGlobal.gameTicks) {
    if (distance < 0) {
      distance = distance + 0xf;
    }
    iVar2 = distance >> 4;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xffff;
    }
    iVar2 = iVar2 >> 0x10;
    if (0x13 < iVar2) {
      iVar2 = 0x13;
    }
    if (forceNoSimOptz != 0) {
      iVar2 = 0;
    }
    bVar1 = Sched_gExecuteInfo[module][iVar2];
    *time = Sched_ExecuteTimes[bVar1];
    *iTime = Sched_ExecuteiTimes[bVar1];
    *elapsedTime = Sched_ExecuteElapsedTimes[bVar1];
    return (u_int)((simGlobal.gameTicks / 2 + carId * staggered & Sched_ExecuteMasks[bVar1]) ==
                 Sched_ExecuteMasks[bVar1]);
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
  Sched_tSchedule *pSVar1;
  Sched_tSchedule *pSVar2;
  int i;
  int iVar3;
  Sched_tSchedule *newSchedule;
  
  newSchedule = (Sched_tSchedule *)(maxFunctions * 0x10);
  pSVar1 = (Sched_tSchedule *)reservememadr(scheduleName,(int)(newSchedule + 1),0);
  pSVar1->maxNumFunctions = maxFunctions;
  iVar3 = 0;
  pSVar1->numFunctions = 0;
  pSVar2 = pSVar1;
  if (0 < maxFunctions) {
    do {
      pSVar2->func[0].priority = 0x7ffe;
      pSVar2->func[0].function = (u_char **)0x0;
      iVar3 = iVar3 + 1;
      pSVar2 = (Sched_tSchedule *)&pSVar2->func[0].var1;
    } while (iVar3 < pSVar1->maxNumFunctions);
  }
  return pSVar1;
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
  int iVar1;
  u_char **ppuVar2;
  void *ppuVar3;
  int j;
  int n;
  int iVar3;
  int i;
  
  i = 0;
  iVar3 = 0;
  iVar1 = schedule->numFunctions + 1;
  schedule->numFunctions = iVar1;
  if (0 < iVar1) {
    iVar1 = 0;
    do {
      iVar3 = i;
      if (priority < *(int *)((int)&schedule->func[0].priority + iVar1)) {
        iVar1 = schedule->numFunctions + -1;
        if (iVar3 < iVar1) {
          ppuVar3 = &schedule->func[schedule->numFunctions + -2].var1;
          do {
            *(u_int *)((int)ppuVar3 + 8) = *(u_int *)((int)ppuVar3 + -8);
            *(u_int *)((int)ppuVar3 + 0xc) = *(u_int *)((int)ppuVar3 + -4);
            *(u_int *)((int)ppuVar3 + 0x10) = *(u_int *)ppuVar3;
            *(u_int *)((int)ppuVar3 + 0x14) = *(u_int *)((int)ppuVar3 + 4);
            iVar1 = iVar1 + -1;
            ppuVar3 = (void *)((int)ppuVar3 + -0x10);
          } while (iVar3 < iVar1);
        }
        break;
      }
      i = iVar3 + 1;
      iVar1 = i * 0x10;
    } while (i < schedule->numFunctions);
  }
  ppuVar2 = (u_char **)&schedule->func[iVar3 + -1].var1;
  ppuVar2[2] = (u_char *)priority;
  ppuVar2[3] = (u_char *)function;
  ppuVar2[4] = (u_char *)var1;
  return;
}

/* ---- Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv  [SCHEDULE.CPP:160-183] SLD-VERIFIED ---- */
void Sched_DeleteFunction(Sched_tSchedule *schedule,fn_void *function,void *var1)

{
  int i;
  int iVar1;
  void *ppuVar2;
  int j;
  Sched_tSchedule *pSVar2;
  int iVar3;
  
  iVar3 = schedule->numFunctions;
  if (iVar3 != 0) {
    iVar1 = 0;
    pSVar2 = schedule;
    if (0 < iVar3) {
      do {
        if ((pSVar2->func[0].function == (void *)function) && (pSVar2->func[0].var1 == var1))
        {
          ppuVar2 = &schedule->func[iVar1 + -1].var1;
          if (iVar1 < iVar3 + -1) {
            do {
              *(u_int *)((int)ppuVar2 + 8) = *(u_int *)((int)ppuVar2 + 0x18);
              *(u_int *)((int)ppuVar2 + 0xc) = *(u_int *)((int)ppuVar2 + 0x1c);
              *(u_int *)((int)ppuVar2 + 0x10) = *(u_int *)((int)ppuVar2 + 0x20);
              *(u_int *)((int)ppuVar2 + 0x14) = *(u_int *)((int)ppuVar2 + 0x24);
              iVar1 = iVar1 + 1;
              ppuVar2 = (void *)((int)ppuVar2 + 0x10);
            } while (iVar1 < schedule->numFunctions + -1);
          }
          break;
        }
        iVar3 = schedule->numFunctions;
        iVar1 = iVar1 + 1;
        pSVar2 = (Sched_tSchedule *)&pSVar2->func[0].var1;
      } while (iVar1 < iVar3);
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
