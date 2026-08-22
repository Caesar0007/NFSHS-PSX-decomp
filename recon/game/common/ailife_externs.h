/* game/common/ailife_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AILIFE_EXTERNS_H_
#define _GAME_COMMON_AILIFE_EXTERNS_H_

extern Car_tObj           *Cars_gCopCarList[];
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj      *Cars_gSortedList[];
extern Car_tObj *Cars_gLifeBasisCarList[];
/* AILIFE.SYM does not materialize either large owner type.  Preserve the
 * original addresses and access widths through their source-visible rows. */
extern int GameSetup_gData[13];
#define AILIFE_REVERSE_TRACK GameSetup_gData[12]
extern u_char (*BWorldSm_slices)[32];
#define AILIFE_SLICE_CENTER(i) ((coorddef *)&BWorldSm_slices[(i)][0])
#define AILIFE_SLICE_LANE_COUNT(i) BWorldSm_slices[(i)][0x1d]
#define AILIFE_SLICE_WIDTH_LF(i) BWorldSm_slices[(i)][0x1e]
#define AILIFE_SLICE_WIDTH_RT(i) BWorldSm_slices[(i)][0x1f]
extern int                 Cars_gNumCopCars;
extern int                 generic128HzClock, stackSpeedUpEnbabledFlag;
extern int                AIInit_forceHumanHandBrake;
extern int                AITune_driveSide;
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int AITune_oneWay;
extern int Cars_CalculateRoadPosition(Car_tObj *carObj);
extern int Cars_CalculateRoadSpan(Car_tObj *carObj);
extern int Cars_gNumLifeBasisCars;
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern u_long gWSavePtr;
extern void  Math_fasttransmult(matrixtdef *a, matrixtdef *b, matrixtdef *out);
extern void AIPhysic_ResetCar(Car_tObj *carObj);
extern void AISpeeds_SetTrafficSpeedRandomFactor(Car_tObj *carObj);
extern void AIWorld_CalculateLaneInfo(Car_tObj *carObj);
extern void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
extern void Physics_ResetCar(Car_tObj *carObj);
extern void R3DCar_ChangeTrafficColor(Car_tObj *carObj,int newColorIndex);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_ApxSplineDistance(int locationA, int locationB);   /* AIWorld_ApxSplineDistance__Fii -- IsSliceInAnyVisibleArea/IsSliceCloseToAnyCopCar call sites */
void  trap(int code);
void AIInit_ClearAICar(Car_tObj *carObj);
void AISpeeds_CalcDesiredSpeed(Car_tObj *carObj);
void AI_ChooseNewLaneSlack(Car_tObj *carObj);
extern "C" void *SetSp(...);
extern "C" int fixedmult(...);
extern "C" void *memset(...);
extern "C" int xformy(...);

#endif /* _GAME_COMMON_AILIFE_EXTERNS_H_ */
