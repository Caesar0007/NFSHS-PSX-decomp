/* game/common/aiphysic_externs.h - reconstructed externs. NOT original. */
#ifndef _GAME_COMMON_AIPHYSIC_EXTERNS_H_
#define _GAME_COMMON_AIPHYSIC_EXTERNS_H_
#include "../../nfs4_types.h"

extern "C" int fixedmult(int, int);
int AIScript_DoReAction(AIScript_t *script, AIScript_tAIReaction testReaction);
void AIPhysic_ChangeDirection(Car_tObj *car, int dir);
void AIPhysic_HandleDirection(Car_tObj *car);
int  AIPhysic_HitWallCheck(Car_tObj *car);
void AIPhysic_Preperation(Car_tObj *car);
int  AIPhysic_CheckIfOutOfControl(Car_tObj *car);
void AIPhysic_OutOfControlPhysics(Car_tObj *car);
void AIPhysic_InControlPhysics(Car_tObj *car);
void AIPhysic_FinishUp(Car_tObj *car);
void Cars_ResetCollidedCars(Car_tObj *car, int a, int b);
extern GameSetup_tData GameSetup_gData;
extern Trk_NewSlice *BWorldSm_slices;
extern int AIPhysic_elapsedTime;
extern int simGlobal[];        /* @0x8011E0AC */
extern int D_8011E0B0[];       /* @0x8011E0B0 == &simGlobal[1]; UNSIZED array → separate-temp HI-scratch load (§3.12#5). oracle addresses it as the D_8011E0B0 symbol directly */
extern int fastRandom;         /* @0x8013D0FC */
extern int randtemp;           /* @0x8013D100 */
extern int randSeed;           /* @0x8013D104 */

/* ---- additions for the 17 ported AIPhysic functions (forward callee decls + globals) ---- */
/* intra-TU forward decls of the ported set */
void   AIPhysic_StopCar(Car_tObj *carObj, int velScale, int rotScale);
void   AIPhysic_RevEngine(Car_tObj *carObj);
void   AIPhysic_HandleShifting(Car_tObj *carObj);
int    AIPhysic_CalculateGear(Car_tObj *carObj);
int    AIPhysic_GearInvSpeedRange(Car_tObj *carObj, Gear_t gear);
int    AIPhysic_GearTopSpeed(Car_tObj *carObj, Gear_t gear);
int    AIPhysic_GearBottomSpeed(Car_tObj *carObj, Gear_t gear);
int    AIPhysic_CalcAcceleration(Car_tObj *carObj, int speed);
int    AIPhysic_ModifyAccelerationAccordingToScript(Car_tObj *carObj, int acc);
int    AIPhysic_CalcDeceleration(Car_tObj *carObj);
void   AIPhysic_CheckDesiredDirection(Car_tObj *carObj);
void   AIPhysic_HandleSignalling(Car_tObj *carObj);
void   AIPhysic_HandleWipeoutTimer(Car_tObj *carObj);
void   AIPhysic_Main(Car_tObj *carObj);
void   AIPhysic_CheckForBadPosition(Car_tObj *carObj);
int    AIPhysics_UseCoolPhysics(Car_tObj *carObj);
void   AIPhysic_SimplePhysics(Car_tObj *carObj);
void   AIPhysic_SimplePhysics_LongVel(Car_tObj *carObj);
void   AIPhysic_SimplePhysics_LatVel(Car_tObj *carObj);
void   AIPhysic_CoolPhysics(Car_tObj *carObj);
void   AIPhysic_TargetedGetDesiredVector(Car_tObj *carObj);
int    AIPhysic_CalculateRoadPosition(coorddef *pos, int slice);
void   AIPhysic_GetDesiredVector(Car_tObj *carObj);
int    AIPhysic_GetRearEndDamageFactor(Car_tObj *carObj);
void   AIPhysic_CalculateRampedDesiredLatPos(Car_tObj *carObj, eRampType rampType);
void   AIPhysic_CheckForGripReduction(Car_tObj *carObj);
void   AIPhysic_InitCar(Car_tObj *carObj);

/* external callees */
extern "C" int  fixeddiv(int, int);
extern "C" int  intatan(int, int);
extern "C" void transpose(matrixtdef *src, matrixtdef *dst);
int  Sched_ExecuteCheck(int a, int b, int dist, int objID, int *t, int *et, int *it, int forceNoSimOptz);
void AIWorld_CalcSpeed(Car_tObj *carObj);
int  AIWorld_CalcLateralVelocity(Car_tObj *carObj);
int  AIWorld_CalcRoadBend(Car_tObj *carObj, int slices);
int  AIWorld_CalcFutureLateralVel(Car_tObj *carObj, int slices);
int  AIWorld_LaneIndex(int slice, int roadPos);
int  AIWorld_IsDriveableLane(int slice, int lane);
void AIWorld_CalculateDeltaRoadYaw(Car_tObj *carObj);
int  AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(Car_tObj *carObj);
int  AISpeeds_GetUpgradeBrakeMult(int carIndex);
void Math_QDNormalizeVector(coorddef *v);
void Newton_CopyRoadMatrixToOrientMat(BO_tNewtonObj *N, int rev);
void Cars_DoGravityEffectsOnAcc(Car_tObj *carObj, int a);
void Cars_ResetCollidedCars(Car_tObj *car, int a, int b);

/* PSX runtime helpers used by ported fns */
extern "C" void *__builtin_new(unsigned int);
extern "C" void  __builtin_delete(void *);

/* globals (AIPhysicConfig / AIPhysic_time / AIPhysic_iTime are aiphysic.obj-owned —
 *  defined as tentative defs in aiphysic.cpp, like AIPhysic_elapsedTime) */
extern AIPhysic_Config_t  AIPhysicConfig;              /* @0x8010dc74 */
extern int                AIPhysic_time;               /* @0x8013c598 */
extern int                AIPhysic_iTime;              /* @0x8013c594 */
extern AIDataRecord_TrackCurve_t *AIDataRecord_TrackCurve;
extern AIScript_tReactionDetails  AIPerson_ScriptData[]; /* flat view @0x8010da5c */
extern u_char             AIInit_forceHumanHandBrake[]; /* (int)array decays to base addr */
extern int                gNumSlices;
extern int                Cars_topSpeedCap[];
extern Car_tObj          *Cars_gHumanRaceCarList[];
extern int                Cars_gNumHumanRaceCars;
extern int                AITune_BTCPerpAccMults[];

#endif
