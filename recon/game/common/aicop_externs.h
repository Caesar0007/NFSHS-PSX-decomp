/* game/common/aicop_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AICOP_EXTERNS_H_
#define _GAME_COMMON_AICOP_EXTERNS_H_

extern AITrigger_TriggerManager *triggerManagerCops;
extern Car_tObj           *Cars_gCopCarList[];
/* AICOP.SYM omits the externally owned 2600-byte GameSetup body. */
extern int GameSetup_gData[16];
#define AICOP_COPS GameSetup_gData[5]
#define AICOP_TRACK GameSetup_gData[15]
extern char               *Paths_Paths[];          /* 0x80116468 (paths.obj) */
extern int                 Cars_gNumCopCars;
/* w64 unlock (A21 calltarget): all FOUR overloads -- a single decl made every
 * call bind __FP8Car_tObjT0 via silent 0->pointer conversion (w22-a14 back). */
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_ApxSplineDistance(Car_tObj *a, int sliceB);
int AIWorld_ApxSplineDistance(int sliceA, Car_tObj *b);
int AIWorld_ApxSplineDistance(int sliceA, int sliceB);
extern "C" int sprintf(...);
extern "C" char *loadfileadrz(...);
extern "C" int purgememadr(...);

#endif /* _GAME_COMMON_AICOP_EXTERNS_H_ */
