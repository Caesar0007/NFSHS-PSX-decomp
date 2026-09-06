/* P875 typed address references; compile-only, never linked into the game. */
#include "C:/Temp/nfs4-decomp/recon/game/common/fastrand.h"
void (*p875_common_fastrand_0)(void) = &FastRandom_CleanUp;
void (*p875_common_fastrand_1)(unsigned int seeder) = &FastRandom_StartUp;
