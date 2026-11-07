/* cars.obj (retail): GameSetup and the scheduler types right after the pads -- included through
 * draw_leaf_types.h NFS4_DRAW_LEAF_HOOK_AFTER_PADS (cars_types.h). */
#include "gamesetup_leaf_types.h"
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_COLOR_SCHED_DONE   /* color_types.h: the scheduler types are already declared */
