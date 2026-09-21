#include "common.h"

/* spchpick.obj's own static Vox accessors (retail SYM: local labels 0x80100710..0x8010077C) */
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetMatchValue);
INCLUDE_ASM("asm/nonmatchings/main", VoxSentence_GetShortRule);
INCLUDE_ASM("asm/nonmatchings/main", VoxSentence_GetNumPhrases);
INCLUDE_ASM("asm/nonmatchings/main", VoxEvent_GetFilterLengthFlag_8010073C);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetOffset8);
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetOffset16_80100760);

/* The suffixed labels keep duplicate retail helper addresses distinct; objdiff.json maps them to the natural (static) names of
 * the reconstruction (symbol_mappings), so no alias is defined here -- an alias would be a second target symbol at the same address. */

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
