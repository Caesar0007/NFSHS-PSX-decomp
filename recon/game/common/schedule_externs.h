#include "../../lib/libfns.h"
/* schedule_externs.h -- extern decls for game/psx/schedule.cpp
 *   (NFS4 PSX cooperative scheduler: priority-ordered callback list driven each tick). */
#ifndef SCHEDULE_EXTERNS_H
#define SCHEDULE_EXTERNS_H

/* SYM PTR FCN(PTR VOID) VOID  ->  fn_void* == void(*)(void*)  (scheduled callback). */
typedef void fn_void(void *);

/* ---- eaclib EACPSXZ memstd allocator ---- */

/* ---- sim global (provides .gameTicks tick counter) ---- */
extern Sim_tSimGlobalVar simGlobal;                /* 0x8011e0ac */

/* ---- Sched_ExecuteCheck staggered-execution tables (indexed by Sched_gExecuteInfo entry) ---- */
extern int  Sched_ExecuteTimes[7];                 /* 0x8011dfdc */
extern int  Sched_ExecuteElapsedTimes[7];          /* 0x8011dff8 */
extern int  Sched_ExecuteiTimes[7];                /* 0x8011e014 */
extern int  Sched_ExecuteMasks[7];                 /* 0x8011e030 */
extern char Sched_gExecuteInfo[4][20];             /* 0x8011e04c (80B = 4 modules x 20 distance slots) */

#endif
