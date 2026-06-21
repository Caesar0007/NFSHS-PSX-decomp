#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketgetirq);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketsetirq);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketirqcallback);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxzerospu);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketpurgeframes);
INCLUDE_ASM("asm/nonmatchings/main", iSNDfillspuwithpackets);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketserve);
INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpacketoverhead);
INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformcalcdatarate);
INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpacketplaycreate);
INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpacketplaydestroy);
INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpacketplay);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxpacketstop);
