/* game/common/aih_btcperp_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "aih_btcperp_types.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */
extern __vtbl_ptr_type AIHigh_BTC_Perp_vtable[], AIHigh_BTC_HumanPerp_vtable[], AIHigh_BTC_AIPerp_vtable[], AIState_NonActive_vtable[], AIState_Base_vtable[];

Speaker *Speech_Dispatch(void) asm("Dispatch__6Speech");
Speaker *Speech_Mobile(Car_tObj *carObj) asm("Mobile__6SpeechP8Car_tObj");
extern AIHigh_Base *highLevelAIObjs[];
extern AITune_BTC_t AITune_BTC[];
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj *Cars_gList[];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern __vtbl_ptr_type AIHigh_Human_vtable[], AIHigh_BasicPerp_vtable[], AIState_Idle_vtable[];
extern camera_info       Camera_gInfo[2];            /* camera.obj */
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern AICop_RoadBlockState AICop_gRoadBlockState;
extern int Hud_InitMap(void);
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void  Camera_Update(void);
extern void AIPerson_SetPersonality(Car_tObj *carObj,int personalityIndex);
extern void AIWorld_FindBarrierLessLaneAndPosition(Car_tObj *carObj,int *goodLane,int *goodPosition);
extern void Camera_ResetRelPos(int bitMask);
extern void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
extern void Object_ClearCustomObjects(void);
extern void R3DCar_ChangeTrafficColor(Car_tObj *carObj,int newColorIndex);
extern void TrgSfx_RestartTrgSfx(void);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
void AILife_PlaceCarAtLocation(Car_tObj *c, int rot);
void AILife_PlaceCarAtLocation(Car_tObj *c, int slice, int lat, int dir, int spd, int rot);
void AudioClc_HonkHorn(Car_tObj *carObj, int a, int b, int c);
extern "C" int fixedmult(int, int);
extern "C" int fixeddiv(int, int);

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
