/* game/common/control_externs.h - reconstructed externs for control.cpp. NOT original. */
#ifndef _GAME_COMMON_CONTROL_EXTERNS_H_
#define _GAME_COMMON_CONTROL_EXTERNS_H_
/* ===== globals (all cross-TU; control.obj owns NO data) ===== */
extern Sim_tSimGlobalVar   simGlobal;          /* Sim.obj */
#define CONTROL_GAME_TICKS (*(int *)((char *)&simGlobal + 4))
extern int                Cars_gNumAICars;     /* Cars.obj  */
extern int                Input_gSim;          /* Input.obj word view */
/* Owner SYM: steering CHAR@0, gas/brake/flags UCHAR@1/2/3. */
/* The opaque aggregate trial changes this caller's address expansion
 * (26 diffs/282 versus 288); retain the proven four-byte view for review. */
#define CONTROL_INPUT_STEERING (*(signed char *)&Input_gSim)
#define CONTROL_INPUT_GAS (((u_char *)&Input_gSim)[1])
#define CONTROL_INPUT_BRAKE (((u_char *)&Input_gSim)[2])
#define CONTROL_INPUT_FLAGS (((u_char *)&Input_gSim)[3])
extern GameSetup_tData     GameSetup_gData;     /* gmesetup.obj */
#define CONTROL_MIRROR_TRACK (*(int *)((char *)&GameSetup_gData + 44))
extern int                HudBustedOverlay;    /* Hud.obj   */

/* ===== free helpers (cfront-mangled in originals; normal C++ linkage) ===== */
void AI_Main_OverallSetup(void);                          /* AI.obj  @ai.cpp:157 */
void InGame_SetRamp(void);                                /* PSXController.obj @psxcontroller.cpp:349 */
void R3DCar_TurnHeadLightOn(Car_tObj *carObj, int tail);  /* R3DCar.obj */
void R3DCar_TurnHeadLightOff(Car_tObj *carObj, int head); /* R3DCar.obj */
void Hud_WingmanFlash(int player, int index);             /* Hud.obj */
char Input_Gear(char currentGear, int numGears);          /* Input.obj */

#endif /* _GAME_COMMON_CONTROL_EXTERNS_H_ */
