/* game/common/aih_basicperp_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- vtable: AIHigh_BasicPerp (this obj) ---- */
extern __vtbl_ptr_type AIHigh_BasicPerp_vtable[];

int Speech_Mobile(Car_tObj *carObj);   /* speech.obj flat (was Mobile__6SpeechP8Car_tObj; cast result to Speaker*) */
extern AIHigh_Base *highLevelAIObjs[];
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj *Cars_gList[];
extern Car_tObj *Cars_gCopCarList[];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Trk_NewSlice  *BWorldSm_slices;
extern int                 Cars_gNumCopCars;
extern int                AITune_driveSide;
extern int            Cars_gNumCars;
extern int       Cars_gNumHumanRaceCars;
extern int AISpeeds_GetLegalSpeed(int slice);
extern int AITune_oneWay;
extern int AIWorld_CheckForBarrierBetweenLanes(int slice,int lane0,int lane1);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_ApxSplineDistance(Car_tObj *a, int slice);   /* AIWorld_ApxSplineDistance__FP8Car_tObji -- CheckChaserPosition's call site (raw oracle @0x8005C008) */

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
