#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", SimQueue_StartUp__Fv);
INCLUDE_ASM("asm/nonmatchings/main", SimQueue_Reset__Fv);
INCLUDE_ASM("asm/nonmatchings/main", SimQueue_CleanUp__Fv);
INCLUDE_ASM("asm/nonmatchings/main", SimQueue_Put__FiP14Input_tResults);
INCLUDE_ASM("asm/nonmatchings/main", SimQueue_SetCurrentInput__Fi);
INCLUDE_ASM("asm/nonmatchings/main", SimQueue_GetCurrentInput__FiP14Input_tResults);
INCLUDE_ASM("asm/nonmatchings/main", SimQueue_SetLag__Fv);
INCLUDE_ASM("asm/nonmatchings/main", SimQueue_IsBlocking__Fi);
