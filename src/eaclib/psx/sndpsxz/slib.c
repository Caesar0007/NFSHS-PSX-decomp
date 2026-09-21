#include "common.h"

/* moved from sndpsxz/spatkey.c: the retail library pull order proves these are this member's (BUILDING.md, Route C) */
INCLUDE_ASM("asm/nonmatchings/main", iSNDcalcvol);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxkeyon);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxkeyoff);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxeffecton);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxeffectoff);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxeffectvol);
INCLUDE_ASM("asm/nonmatchings/main", iSNDsetvol);
INCLUDE_ASM("asm/nonmatchings/main", iSNDsetslot);
INCLUDE_ASM("asm/nonmatchings/main", iSNDstartvoice);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformoutputcaps);
INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformoutputset);
INCLUDE_ASM("asm/nonmatchings/main", iSNDinit);
INCLUDE_ASM("asm/nonmatchings/main", iSNDrestore);
INCLUDE_ASM("asm/nonmatchings/main", iSNDserve);
