/* game/common/schedule.h — reconstructed from game/common/schedule.cpp (6 fns) */
#ifndef _GAME_COMMON_SCHEDULE_H_
#define _GAME_COMMON_SCHEDULE_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

int Sched_ExecuteCheck(int staggered,int module,int distance,int carId,int *time,int *elapsedTime,int *iTime ,int forceNoSimOptz);   /* :55 */
Sched_tSchedule * Sched_CreateNewSchedule(char *scheduleName,int maxFunctions);   /* :89 */
void Sched_CleanUpSchedule(Sched_tSchedule *schedule);   /* :113 */
void Sched_AddFunction(Sched_tSchedule *schedule,Sched_tFunctionPt function,void *var1,int priority);   /* :123 */
void Sched_DeleteFunction(Sched_tSchedule *schedule,Sched_tFunctionPt function,void *var1);   /* :160 */
void Sched_Execute(Sched_tSchedule *schedule);   /* :195 */

#endif /* _GAME_COMMON_SCHEDULE_H_ */
