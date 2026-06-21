#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", _padSetVsyncParam);
INCLUDE_ASM("asm/nonmatchings/main", _padStartCom);
INCLUDE_ASM("asm/nonmatchings/main", _padStopCom);
INCLUDE_ASM("asm/nonmatchings/main", _padInitSioMode);
INCLUDE_ASM("asm/nonmatchings/main", _padSioRW);
INCLUDE_ASM("asm/nonmatchings/main", _padSioRW2);
INCLUDE_ASM("asm/nonmatchings/main", _padClrIntSio0);
INCLUDE_ASM("asm/nonmatchings/main", _padWaitRXready);
INCLUDE_ASM("asm/nonmatchings/main", _padVbCallback1);
INCLUDE_ASM("asm/nonmatchings/main", _padVbCallback0);
INCLUDE_ASM("asm/nonmatchings/main", _padSioMain);
