/* game/common/ailife_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern Car_tObj           *Cars_gCopCarList[];
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj      *Cars_gSortedList[];
extern Car_tObj *Cars_gLifeBasisCarList[];
extern GameSetup_tData   GameSetup_gData;
extern Trk_NewSlice  *BWorldSm_slices;
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

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
