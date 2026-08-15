/* game/common/schedule.h — reconstructed from game/common/schedule.cpp (6 fns) */
#ifndef _GAME_COMMON_SCHEDULE_H_
#define _GAME_COMMON_SCHEDULE_H_
#include "../../nfs4_types.h"

int Sched_ExecuteCheck__FiiiiPiN24i(int staggered, int module, int distance, int carId, int *time, int *elapsedTime, int *iTime, int forceNoSimOptz);   /* :55 */
void * Sched_CreateNewSchedule__FPci(char *scheduleName, int maxFunctions);   /* :89 */
void Sched_CleanUpSchedule__FP15Sched_tSchedule(Sched_tSchedule *schedule);   /* :113 */
void Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi(Sched_tSchedule *schedule, void *function, void *var1, int priority);   /* :123 */
void Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv(Sched_tSchedule *schedule, void *function, void *var1);   /* :160 */
void Sched_Execute__FP15Sched_tSchedule(Sched_tSchedule *schedule);   /* :195 */

#endif /* _GAME_COMMON_SCHEDULE_H_ */
