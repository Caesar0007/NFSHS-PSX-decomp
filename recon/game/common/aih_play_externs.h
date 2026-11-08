/* game/common/aih_play_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "aih_play_types.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */

extern AIHigh_Base *highLevelAIObjs[];
extern AITrigger_TriggerManager *triggerManagerCops;
extern Car_tObj      *Cars_gRaceCarList[];      /* 0x8010fa00 */
extern Car_tObj * AILife_IsSliceCloseToAnyCopCar(int slice);
extern Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);
extern Car_tObj *Cars_gList[];
extern Car_tObj *Cars_gCopCarList[];
extern int GameSetup_gData[650]; /* word view (2600 bytes): retail aih_play.obj records no GameSetup_tData */
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
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixdmult.h"
}

/* AICop_PerpChaseInfo inline members used by AIH_PLAY.CPP: header-defined, so their
   inlined scopes record the caller's line (retail SYM), not line 1. Moved from aih_play.cpp. */
/* AIH_PLAY.CPP's SLD maps every instruction in both expanded copies to one
 * caller line and records an inlined AICop_PerpChaseInfo `this`; the second
 * copy additionally records `level` in $s0.  This is therefore the original
 * inline member boundary rather than duplicated caller source.  SYM proves
 * the signatures and behavior but does not retain linkage names for inline-
 * only members; the descriptive getter/setter spellings below are therefore
 * sole remaining non-unique part of this recovered interface. */










/* Inferred accessor spellings: the supplied pointer/index fields and retail
 * inline receiver pairs establish these queries, not their original names. */













































/* The shared timer query is defined with its class interface. */

















/* header inline: retail SetupBlockade records its receiver pairs at the caller lines (moved from aih_play.cpp) */


#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
