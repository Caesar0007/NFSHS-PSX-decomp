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
