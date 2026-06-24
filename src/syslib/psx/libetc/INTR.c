#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", ResetCallback);
INCLUDE_ASM("asm/nonmatchings/main", InterruptCallback);
INCLUDE_ASM("asm/nonmatchings/main", DMACallback);
INCLUDE_ASM("asm/nonmatchings/main", VSyncCallback);
INCLUDE_ASM("asm/nonmatchings/main", VSyncCallbacks);
INCLUDE_ASM("asm/nonmatchings/main", CheckCallback);
INCLUDE_ASM("asm/nonmatchings/main", SetIntrMask);
INCLUDE_ASM("asm/nonmatchings/main", _initIntr);
INCLUDE_ASM("asm/nonmatchings/main", _intrhand);
INCLUDE_ASM("asm/nonmatchings/main", _set_intr_callback);
INCLUDE_ASM("asm/nonmatchings/main", StopCallback);
INCLUDE_ASM("asm/nonmatchings/main", RestartCallback);
INCLUDE_ASM("asm/nonmatchings/main", _bzero_w);
