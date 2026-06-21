#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketplayoverhead);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_overhead);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_create);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_start);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_submit);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_submitspace);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_unsafeframesoutstanding);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_framesoutstanding);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_purge);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_stop);
INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_destroy);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketget);
INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketfreeframes);
