/* P875 typed address references; compile-only, never linked into the game. */
#include "p875_common_original_fastrand.h"
void (*p875_common_fastrand_0)(void) = &FastRandom_CleanUp__Fv;
void (*p875_common_fastrand_1)(unsigned int seeder) = &FastRandom_StartUp__FUi;
