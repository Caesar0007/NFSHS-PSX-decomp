/* game/common/aih_btccop_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- vtables: AIHigh_BTC_Cop/HumanCop/Wingman (this obj) + AIState_NonActive/Base ---- */
extern __vtbl_ptr_type AIHigh_BTC_Cop_vtable[], AIHigh_BTC_HumanCop_vtable[], AIHigh_BTC_Wingman_vtable[], AIState_NonActive_vtable[], AIState_Base_vtable[];

CARDINFO_def *MCRD_getcard(...);
int Speech_Dispatch(void);             /* speech.obj flat (was Dispatch__6Speech; cast result to Speaker*) */
int Speech_Mobile(Car_tObj *carObj);   /* speech.obj flat (was Mobile__6SpeechP8Car_tObj; cast result to Speaker*) */
extern AICop_spikeBelt_t AICop_spikeBelt;
extern AIDataRecord_TrackCurve_t *AIDataRecord_TrackCurve;   /* was stale array-of-value shape; owner
                                                     (aidatarecord.cpp) defines it as a POINTER --
                                                     consumers call AIDataRecord_TrackCurve->Get(...),
                                                     which under the array shape decays to &storage
                                                     (this global's own address) instead of the real
                                                     stored pointer value -- wrong `this` bug */
extern AIHigh_Base *highLevelAIObjs[];
extern AIHigh_CopGameType_t AIHigh_CopGameType;   /* @0x8013c55c */
extern AITune_BTC_t AITune_BTC[];
extern Car_tObj           *Cars_gTrafficCarList[];
extern Car_tObj      *Cars_gRaceCarList[];      /* 0x8010fa00 */
extern Car_tObj      *Cars_gHumanRaceCarList[9];   /* cars.obj */
extern Car_tObj * AILife_IsCarInAnyVisibleArea(Car_tObj *carObj);
extern Car_tObj *Cars_gList[];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Sim_tSimSystemVar simVar;
extern Trk_NewSlice  *BWorldSm_slices;
extern __vtbl_ptr_type AIHigh_Human_vtable[], AIHigh_BasicPerp_vtable[], AIState_Idle_vtable[];
extern int                 Cars_gNumTrafficCars;
extern int                 generic128HzClock, stackSpeedUpEnbabledFlag;
extern int                AIInit_forceHumanHandBrake;
extern int                AITune_driveSide;
extern int               Cars_gNumRaceCars;
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int   AIWorld_IsDriveableLane(int slice, int lane);
extern int   AIWorld_IsDriveableLaneInSliceRange(int slice, int lookAhead, int rsControl, int dir);
extern int AICop_gRoadBlockState;
extern int AIWorld_CalcRoadBend(Car_tObj *carObj,int lookAhead);
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern u_long gWSavePtr;
extern void AILife_ReencarnateCopByLatPosAndRotation(Car_tObj *carObj,int slice,int travelDirection,int latPos,int rotation1024);
extern void AIWorld_FindBarrierLessLaneAndPosition(Car_tObj *carObj,int *goodLane,int *goodPosition);
extern void BWorld_InitSpikeBelt(void);
extern void BWorld_SetSpikeBelt(int slice,int x,int width);
extern void Hud_BTC_BonusTime(long extratime);
extern void Hud_BTC_Update(char *perpname,int timeleft,bool userHasControl);
extern void Hud_BustedOverlayOff(void);
extern void Hud_BustedOverlayOn(int time,char *name,bool caught,short player);
extern void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
extern void Object_ClearCustomObjects(void);
extern void TrgSfx_RestartTrgSfx(void);
int AISpeeds_CalcHumanTopSpeed(Car_tObj *carObj);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
/* AIDataRecord_TrackCurve_t::Get now called as C++ member (aidatarecord.obj) -- flat extern removed */
void AILife_PlaceCarAtLocation(Car_tObj *c, int rot);
void AILife_PlaceCarAtLocation(Car_tObj *c, int slice, int lat, int dir, int spd, int rot);

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
