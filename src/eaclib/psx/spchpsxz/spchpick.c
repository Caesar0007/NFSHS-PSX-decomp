#include "common.h"

/* spchpick.obj's own static Vox accessors (retail SYM: local labels 0x80100710..0x8010077C) */
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

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_MatchSample);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetPhraseBank);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetBankBits);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ClearCycleBit);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_CheckBankBit);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_CheckTemplateSample);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SampleExists);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ChooseSamples);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SampleLength);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ConvertTime);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SentenceLength);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_OrderSentences);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_RepeatEvent);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ShortRuleStatus);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SentenceGetChoices);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_RandomizeSentencePicks);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_IterateChoice);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ChooseShortSentence);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SentenceMakeChoice);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ConstantRuleSet);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_MakeSampleRequests);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ClearChosen);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SaveChosenSentence);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_OneChosen);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_PlayChosen);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ChooseSentence);
INCLUDE_ASM("asm/nonmatchings/main", SPCH_SetPreLoadTicks);
