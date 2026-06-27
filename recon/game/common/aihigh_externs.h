/* game/common/aihigh_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"

/* ---- vtables: AIHigh_Base/None + AIState_None/Base + AIHigh_BTC_Perp (weak frags) ---- */
extern __vtbl_ptr_type AIHigh_Base_vtable[], AIHigh_None_vtable[], AIState_None_vtable[], AIState_Base_vtable[], AIHigh_BTC_Perp_vtable[];

extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj *Cars_gList[];
extern GameSetup_tData   GameSetup_gData;
extern __vtbl_ptr_type AIHigh_BTC_Perp_vtable[], AIHigh_BTC_HumanPerp_vtable[], AIHigh_BTC_AIPerp_vtable[], AIState_NonActive_vtable[], AIState_Base_vtable[];
extern __vtbl_ptr_type AIHigh_BasicPerp_vtable[];
extern int            Cars_gNumCars;
extern int       Cars_gNumHumanRaceCars;
extern int AI_elapsedTime;   /* @0x8013c554 */
extern int AI_iTime;   /* @0x8013c558 */
extern int AI_time;   /* @0x8013c550 */
extern void AIHigh_CleanUp(void);
extern void AIState_CleanUp(void);
extern void AIState_Restart(void);
extern void AIState_StartUp(void);
int Sched_ExecuteCheck(int a, int b, int c, int d, int *e, int *f, int *g, int h);

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
