#ifndef _SPCHRULE_H_
#define _SPCHRULE_H_

#include "spch_types.h"

extern int  iSPCH_GetRuleDataAddr(int sentence);                       /* @0x8010B140 */
extern int  iSPCH_SentenceUsesParm(int sentence, unsigned int paramIdx); /* @0x8010B158 */
extern unsigned int iSPCH_GetRuleID(int sentence, int index);         /* @0x8010B220 */
extern void iSPCH_RuleSet(short *sentence, int rule, int *values);    /* @0x8010B294 */
extern unsigned char iSPCH_GetRuleSettings(short *sentence, int *values, char *out); /* @0x8010B3CC */
extern unsigned int iSPCH_CheckSentenceRules(int testVal, int clearMask, int rulePtr); /* @0x8010B58C */

#endif
