/* game/common/aih_play_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "aih_play_types.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */
extern __vtbl_ptr_type AIHigh_Player_vtable[], AIHigh_BasicPerp_vtable[], AIState_Idle_vtable[];

Speaker *Speech_Dispatch(void) asm("Dispatch__6Speech");
Speaker *Speech_Mobile(Car_tObj *carObj) asm("Mobile__6SpeechP8Car_tObj");
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
extern AICop_RoadBlockState AICop_gRoadBlockState;
extern int AICop_numArrestedHumans;
extern int AITune_gRoughLapTime;
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void Cars_ResetCollidedCars(Car_tObj *carObj,int forceReset,int forceParkAtSide);
extern void Hud_Perp_OverlayOff(int player);
extern void Hud_Perp_OverlayOn(int player,int level);
extern void Stats_ExtrapolateOpponentTimes(int);
int AIWorld_ApxSplineDistance(Car_tObj *carObj, int slice);
/* AITrigger_TriggerManager::CheckForClosestTriggerOfType/GetTrigger now C++ members (aitriger.obj) -- flat externs removed */
void  trap(int code);
extern "C" int fixedmult(int, int);

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
