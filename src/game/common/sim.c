#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", Sim_StartUp__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Sim_Restart__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Sim_CleanUp__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Sim_FadeInSFX__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Sim_ProcessSimSchedules__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Sim_CheckForPause__Fi);
INCLUDE_ASM("asm/nonmatchings/main", Sim_MainGameLoop__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Sim_ProcessPause__Fv);
