#ifndef _SPCHRULE_H_
#define _SPCHRULE_H_

#include "spch_types.h"

extern VoxRule *iSPCH_GetRuleDataAddr(VoxEvent *event);                        /* @0x8010B140 : the rule entries after the sentence table */
extern int  iSPCH_SentenceUsesParm(VoxSentence *sentence, unsigned int paramIdx); /* @0x8010B158 */
extern int  iSPCH_GetRuleID(VoxEvent *event, int index);                       /* @0x8010B220 : rule id, or -1 */
extern void iSPCH_RuleSet(VoxEvent *event, int sentenceIdx, int *values); /* @0x8010B294 */
extern unsigned char iSPCH_GetRuleSettings(VoxEvent *event, int *values, char *out); /* @0x8010B3CC */
extern unsigned int iSPCH_CheckSentenceRules(int testVal, int clearMask, int rulePtr); /* @0x8010B58C */

#endif
