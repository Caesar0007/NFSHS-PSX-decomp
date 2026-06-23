#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", Platform_InitMemory__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Platform_ReserveMemory__FiPc);
INCLUDE_ASM("asm/nonmatchings/main", Platform_TempReserveMemory__FiPc);
INCLUDE_ASM("asm/nonmatchings/main", Platform_SysStartUp__Fv);
INCLUDE_ASM("asm/nonmatchings/main", nfs2eacinit__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Platform_ResetDCTBuffer__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Platform_GetDCTBuffer__FiPc);
INCLUDE_ASM("asm/nonmatchings/main", Platform_DebuggerPollHost__Fv);
