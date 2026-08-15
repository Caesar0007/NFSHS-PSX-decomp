/* game/common/aih_opp_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */
extern __vtbl_ptr_type AIHigh_Opponent_vtable[], AIState_Idle_vtable[];

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

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
