/* game/common/aispeeds_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AISPEEDS_EXTERNS_H_
#define _GAME_COMMON_AISPEEDS_EXTERNS_H_

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
extern int GameSetup_gData[22];
#define AISPEEDS_RACE_TYPE GameSetup_gData[0]
#define AISPEEDS_NUM_LAPS GameSetup_gData[1]
#define AISPEEDS_SKILL GameSetup_gData[2]
#define AISPEEDS_TOURNAMENT_MULTIPLIER GameSetup_gData[4]
#define AISPEEDS_REVERSE_TRACK GameSetup_gData[12]
#define AISPEEDS_TRACK GameSetup_gData[15]
#define AISPEEDS_WEATHER GameSetup_gData[18]
#define AISPEEDS_TIME GameSetup_gData[21]
extern Sim_tSimGlobalVar simGlobal;
extern int AISpeeds_simGlobalWords[] asm("simGlobal");
#define AISPEEDS_GAME_TICKS AISpeeds_simGlobalWords[1]
extern u_char (*BWorldSm_slices)[32];
#define AISPEEDS_SLICE_LANE_COUNT(i) BWorldSm_slices[(i)][0x1d]
#define AISPEEDS_SLICE_WIDTH_LF(i) BWorldSm_slices[(i)][0x1e]
#define AISPEEDS_SLICE_WIDTH_RT(i) BWorldSm_slices[(i)][0x1f]
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
extern "C" int AIDataRecord_TrackCurve_Get(AIDataRecord_TrackCurve_t *self, int slice)
    asm("Get__25AIDataRecord_TrackCurve_ti");
extern "C" int fixeddiv(...);
extern "C" int fixedmult(...);
extern "C" int purgememadr(...);
extern "C" void *reservememadr(...);
extern "C" int sprintf(...);

#endif /* _GAME_COMMON_AISPEEDS_EXTERNS_H_ */
