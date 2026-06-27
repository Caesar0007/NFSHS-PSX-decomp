/* game/common/aih_play_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */
extern __vtbl_ptr_type AIHigh_Player_vtable[], AIHigh_BasicPerp_vtable[], AIState_Idle_vtable[];

int Speech_Dispatch(void);             /* speech.obj flat (was Dispatch__6Speech; cast result to Speaker*) */
int Speech_Mobile(Car_tObj *carObj);   /* speech.obj flat (was Mobile__6SpeechP8Car_tObj; cast result to Speaker*) */
extern AIHigh_Base *highLevelAIObjs[];
extern AITrigger_TriggerManager *triggerManagerCops;
extern Car_tObj      *Cars_gRaceCarList[];      /* 0x8010fa00 */
extern Car_tObj * AILife_IsSliceCloseToAnyCopCar(int slice);
extern Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);
extern Car_tObj *Cars_gList[];
extern Car_tObj *Cars_gCopCarList[];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Sim_tSimSystemVar simVar;
extern Trk_NewSlice  *BWorldSm_slices;
extern copGame_t copGame[];
extern dashhud_info    DashHUD_gInfo;            /* dashHUD.obj */
extern int                 Cars_gNumCopCars;
extern int               Cars_gNumRaceCars;
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int   Cars_gNumAIRaceCars;
extern int AICop_gRoadBlockState;
extern int AICop_numArrestedHumans;
extern int AITune_gRoughLapTime;
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void Cars_ResetCollidedCars(Car_tObj *carObj,int forceReset,int forceParkAtSide);
extern void Hud_Perp_OverlayOff(int player);
extern void Hud_Perp_OverlayOn(int player,int level);
extern void Stats_ExtrapolateOpponentTimes(int);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
/* AITrigger_TriggerManager::CheckForClosestTriggerOfType/GetTrigger now C++ members (aitriger.obj) -- flat externs removed */
void  trap(int code);

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
