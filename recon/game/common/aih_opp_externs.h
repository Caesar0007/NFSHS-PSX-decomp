/* game/common/aih_opp_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "aih_opp_types.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */

extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj *Cars_gList[];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Trk_NewSlice  *BWorldSm_slices;
extern int                 Cars_gNumCopCars;
extern int       Cars_gNumHumanRaceCars;
extern int AIScript_DoReAction(AIScript_t *script,AIScript_tAIReaction testReaction);
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
int AIWorld_SplineDistance(Car_tObj *a, Car_tObj *b);

/* AICop_PerpChaseInfo getters: header inlines (retail CheckForWipeOut records their nests at the
   caller's line 31; a same-.cpp definition records its own line 1 -- GAME6 2026-11-07). */
inline int AICop_PerpChaseInfo::GetChaseLevelIndex() { return chaseLevelIndex_; }
inline int AICop_PerpChaseInfo::BestChaseLevelIndex() { return bestChaseLevelIndex_; }
inline int AICop_PerpChaseInfo::GetNumLevels() { return copGameInfo_->numLevels; }

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
