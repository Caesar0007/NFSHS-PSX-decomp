/* P875 typed address references; compile-only, never linked into the game. */
#include "C:/Temp/nfs4-decomp/recon/game/common/clock.h"
void (*p875_common_clock_0)(void) = &Clock_MasterInterruptHandler;
void (*p875_common_clock_1)(void) = &Clock_SystemStartUp;
void (*p875_common_clock_2)(void) = &Clock_SystemCleanUp;
