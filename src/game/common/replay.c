#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", Replay_Compress__FPc);
INCLUDE_ASM("asm/nonmatchings/main", Replay_Decompress__FPc);
INCLUDE_ASM("asm/nonmatchings/main", Replay_InitReplay__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Replay_ResetReplay__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Replay_StoringReplay__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Replay_StoringControllerData__FG15tControllerData);
INCLUDE_ASM("asm/nonmatchings/main", Replay_RetreivingControllerData__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Replay_SaveInput__Fi);
INCLUDE_ASM("asm/nonmatchings/main", Replay_GetInput__Fi);
INCLUDE_ASM("asm/nonmatchings/main", Replay_SaveReplay__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Replay_DoReplay__FP8Car_tObj);
INCLUDE_ASM("asm/nonmatchings/main", Replay_GetInterfaceKey__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Replay_LoadCameraFile__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Replay_ReplayChooseCamera__Fii);
INCLUDE_ASM("asm/nonmatchings/main", Replay_ReplayFindClosestCamera__Fii);
