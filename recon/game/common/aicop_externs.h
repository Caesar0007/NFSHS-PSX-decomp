/* game/common/aicop_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern AITrigger_TriggerManager *triggerManagerCops;
extern Car_tObj           *Cars_gCopCarList[];
extern GameSetup_tData   GameSetup_gData;
extern char               *Paths_Paths[];          /* 0x80116468 (paths.obj) */
extern int                 Cars_gNumCopCars;
/* w64 unlock (A21 calltarget): all FOUR overloads -- a single decl made every
 * call bind __FP8Car_tObjT0 via silent 0->pointer conversion (w22-a14 back). */
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_ApxSplineDistance(Car_tObj *a, int sliceB);
int AIWorld_ApxSplineDistance(int sliceA, Car_tObj *b);
int AIWorld_ApxSplineDistance(int sliceA, int sliceB);
/* AITrigger_TriggerManager::Init now called as C++ member (aitriger.obj) -- flat extern removed */

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
