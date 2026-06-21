/* game/common/control_externs.h - reconstructed externs for control.cpp. NOT original. */
#ifndef _GAME_COMMON_CONTROL_EXTERNS_H_
#define _GAME_COMMON_CONTROL_EXTERNS_H_
#include "../../nfs4_types.h"

/* ===== globals (all cross-TU; control.obj owns NO data) ===== */
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern int                Cars_gNumAICars;     /* Cars.obj  */
extern Input_tResults     Input_gSim;          /* Input.obj (sim controller results) */
extern GameSetup_tData    GameSetup_gData;     /* GameSetup.obj (.mirrorTrack) */
extern int                HudBustedOverlay;    /* Hud.obj   */

/* ===== free helpers (cfront-mangled in originals; normal C++ linkage) ===== */
void AI_Main_OverallSetup(void);                          /* AI.obj  @ai.cpp:157 */
void InGame_SetRamp(void);                                /* PSXController.obj @psxcontroller.cpp:349 */
void R3DCar_TurnHeadLightOn(Car_tObj *carObj, int tail);  /* R3DCar.obj */
void R3DCar_TurnHeadLightOff(Car_tObj *carObj, int head); /* R3DCar.obj */
void Hud_WingmanFlash(int player, int index);             /* Hud.obj */
char Input_Gear(char currentGear, int numGears);          /* Input.obj */

#endif /* _GAME_COMMON_CONTROL_EXTERNS_H_ */
