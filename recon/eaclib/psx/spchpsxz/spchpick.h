#ifndef _SPCHPICK_H_
#define _SPCHPICK_H_

#include "spch_types.h"

/* ---- picker storage (defined by spchpick's own .bss block) ---- */
extern short          ispch_gChoice[];      /* short[6] per-phrase choice records */
extern unsigned char  ispch_gPickSamples[]; /* chosen sample-index pool */
extern int            gSentenceChoice[];    /* @0x8014843C chosen sentence + its 12 eventArgs */
extern int            DAT_80148448;         /* "one chosen" flag (@gSentenceChoice+0xC) */

extern int  iSPCH_MatchSample(int bankIdx, int sample, VoxPhrase *phraseTemplate, int paramTable); /* @0x8010077C : bankIdx UNUSED */
extern unsigned int iSPCH_GetPhraseBank(VoxPhrase *phraseTemplate, int paramTable, short *outChoice); /* @0x80100880 */
extern char *iSPCH_GetBankBits(VoxBank *bank);                        /* @0x80100994 */
extern unsigned char *iSPCH_ClearCycleBit(VoxBank *bank, int cycle); /* @0x801009B8 */
extern unsigned int iSPCH_CheckBankBit(VoxBank *bank, int cycle); /* @0x80100A1C : return must stay WORD-typed --
                                            * a char/unsigned char return makes the CALLERS re-narrow it
                                            * (`andi ...,0xff` in CheckTemplateSample/SampleExists, 2 diffs
                                            * each) where retail has a plain register copy (A/B/C-measured
                                            * 2026-09-03) */
extern unsigned int iSPCH_CheckTemplateSample(int choice, VoxBank *bank, int base); /* @0x80100A70 */
extern unsigned int iSPCH_SampleExists(int choice, VoxBank *bank, int sampleIdx); /* @0x80100AC0 */
extern int  iSPCH_ChooseSamples(short *choice, int maxToPick, VoxPhrase *phraseTemplate, int unused); /* @0x80100B4C */
extern int  iSPCH_SampleLength(short *choice);                        /* @0x80100C5C */
extern int  iSPCH_ConvertTime(int samples);                          /* @0x80100CC4 */
extern int  iSPCH_SentenceLength(VoxSentence *sentence);                      /* @0x80100D20 */
extern void iSPCH_OrderSentences(int event, int outOrder); /* @0x80100D94 */
extern unsigned int iSPCH_RepeatEvent(unsigned short *eventArgs);    /* @0x80100EE0 */
extern int  iSPCH_ShortRuleStatus(VoxSentence *sentence, int mode);           /* @0x80100F24 */
extern int  iSPCH_SentenceGetChoices(VoxSentence *sentence, int paramTable, unsigned int ruleByte1, unsigned int ruleByte2, int filterMode); /* @0x80100F8C */
extern void iSPCH_RandomizeSentencePicks(VoxSentence *sentence);             /* @0x801010CC */
extern int  iSPCH_IterateChoice(VoxSentence *sentence);                      /* @0x801011AC : returns 1 if the odometer is exhausted (Ghidra void-bug: real return, read at epilogue) */
extern int  iSPCH_ChooseShortSentence(VoxSentence *sentence);               /* @0x8010125C */
extern int  iSPCH_SentenceMakeChoice(VoxSentence *sentence, int mode);      /* @0x80101310 */
extern void iSPCH_ConstantRuleSet(VoxEvent *event, VoxSentence *sentence); /* @0x801013BC */
extern int  iSPCH_MakeSampleRequests(VoxSentence *sentence, int paramTable); /* @0x80101508 */
extern void iSPCH_ClearChosen(void);                               /* @0x80101650 */
extern int  iSPCH_SaveChosenSentence(VoxEvent *event, VoxSentence *sentence, int sentenceIdx, int *eventArgs); /* @0x8010165C */
extern int  iSPCH_OneChosen(void);                                 /* @0x801016A4 */
extern void iSPCH_PlayChosen(void);                                /* @0x801016B4 */
extern int  iSPCH_ChooseSentence(unsigned int *eventArgs);         /* @0x80101754 */
extern void SPCH_SetPreLoadTicks(int ticks);                       /* @0x801018F4 */

#endif
