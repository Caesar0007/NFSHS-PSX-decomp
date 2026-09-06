/* P875 typed address references; compile-only, never linked into the game. */
#include "p875_common_original_clock.h"
void (*p875_common_clock_0)(void) = &Clock_MasterInterruptHandler__Fv;
void (*p875_common_clock_1)(void) = &Clock_SystemStartUp__Fv;
void (*p875_common_clock_2)(void) = &Clock_SystemCleanUp__Fv;
