/* P875 follow-up typed API references; compile-only, never a game input. */
#include "p875_common2_original_mpause.h"
void (*p875_common2_mpause_0)(char active) = &MPause_MusicLogic__Fc;
void (*p875_common2_mpause_1)(void) = &MPause_ControllerLogic__Fv;
int (*p875_common2_mpause_2)(void) = &MPause_Logic__Fv;
void (*p875_common2_mpause_3)(void) = &MPause_Render__Fv;
void (*p875_common2_mpause_4)(void) = &MPause_InitMPause__Fv;
void (*p875_common2_mpause_5)(void) = &MPause_StartPauseMenu__Fv;
void (*p875_common2_mpause_6)(void) = &MPause_EndPauseMenu__Fv;
void (*p875_common2_mpause_7)(void) = &MPause_KillMPause__Fv;
