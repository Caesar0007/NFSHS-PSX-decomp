/* game/common/aispeeds_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern "C" CARDINFO_def *MCRD_getcard(int);
extern AIDataRecord_TrackCurve_t *AIDataRecord_TrackCurve;   /* was stale array-of-value shape; owner
                                                     (aidatarecord.cpp) defines it as a POINTER --
                                                     consumers call AIDataRecord_TrackCurve->Get(...),
                                                     which under the array shape decays to &storage
                                                     (this global's own address) instead of the real
                                                     stored pointer value -- wrong `this` bug */
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj *Cars_gList[];
extern Car_tObj *Cars_gAIRaceCarList[9];
extern Car_tObj *Cars_gTotalSortedList[];
extern char *Paths_Paths[];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Trk_NewSlice  *BWorldSm_slices;
extern Udff_tInfo * Udff_Opena(char *name,char *mem,int abortFlag);
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int   Cars_gNumAIRaceCars;
extern int   Udff_GetInt(Udff_tInfo *handle);
extern int AIPerson_glueTable[];
extern int AIScript_DoReAction(AIScript_t *script,AIScript_tAIReaction testReaction);
extern int AIWorld_GameOdometer(Car_tObj *carObj);
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void Udff_Close(Udff_tInfo *handle);
extern void Udff_GetBuffer(Udff_tInfo *handle,char *mem,int size);
/* w64 unlock (A21 calltarget): all FOUR overloads -- a single decl made every
 * call bind __FP8Car_tObjT0 via silent 0->pointer conversion (w22-a14 back). */
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_ApxSplineDistance(Car_tObj *a, int sliceB);
int AIWorld_ApxSplineDistance(int sliceA, Car_tObj *b);
int AIWorld_ApxSplineDistance(int sliceA, int sliceB);
/* AIDataRecord_TrackCurve_t::Get / AIDataRecord_CurveSpeedTable_t::Get now called as C++ members (aidatarecord.obj) -- flat externs removed */

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
