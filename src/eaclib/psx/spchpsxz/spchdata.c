#include "common.h"
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetMatchValue);
INCLUDE_ASM("asm/nonmatchings/main", VoxSentence_GetShortRule);
INCLUDE_ASM("asm/nonmatchings/main", VoxSentence_GetNumPhrases);
INCLUDE_ASM("asm/nonmatchings/main", VoxEvent_GetFilterLengthFlag_8010073C);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetOffset8);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetOffset16_80100760);

/* Natural exported names used by spchpick.obj; the suffixed labels only keep
 * duplicate retail helper VAs distinct in reconstruction tooling. */
__asm__(".globl VoxEvent_GetFilterLengthFlag\n"
        "VoxEvent_GetFilterLengthFlag = VoxEvent_GetFilterLengthFlag_8010073C\n"
        ".globl iSPCH_GetOffset16\n"
        "iSPCH_GetOffset16 = iSPCH_GetOffset16_80100760");
