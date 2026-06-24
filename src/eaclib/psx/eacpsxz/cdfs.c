#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", CD_Open);
INCLUDE_ASM("asm/nonmatchings/main", CD_Stopread);
INCLUDE_ASM("asm/nonmatchings/main", CD_Getinfo);
INCLUDE_ASM("asm/nonmatchings/main", CD_Read);
INCLUDE_ASM("asm/nonmatchings/main", readsectorB);
INCLUDE_ASM("asm/nonmatchings/main", loaddirinfo);
INCLUDE_ASM("asm/nonmatchings/main", CD_Restore);
INCLUDE_ASM("asm/nonmatchings/main", CD_Init);
INCLUDE_ASM("asm/nonmatchings/main", CD_Restart);
INCLUDE_ASM("asm/nonmatchings/main", dircompare);
INCLUDE_ASM("asm/nonmatchings/main", CD_timerfunc);
INCLUDE_ASM("asm/nonmatchings/main", CD_systaskfunc);
INCLUDE_ASM("asm/nonmatchings/main", CdReadyHandler);
INCLUDE_ASM("asm/nonmatchings/main", CD_Close);
