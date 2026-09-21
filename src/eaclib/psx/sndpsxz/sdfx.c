#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", SNDI_mutexalloc);
INCLUDE_ASM("asm/nonmatchings/main", SNDI_mutexfree);
INCLUDE_ASM("asm/nonmatchings/main", SNDI_mutexlock);
INCLUDE_ASM("asm/nonmatchings/main", SNDI_mutexunlock);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxfxinit);
INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformfxinit);

/* moved from sndpsxz/sfxlevel.c: the retail library pull order proves these are this member's (BUILDING.md, Route C) */
INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformfxmasterlevel);
