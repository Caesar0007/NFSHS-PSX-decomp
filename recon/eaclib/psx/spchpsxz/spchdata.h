#ifndef _SPCHDATA_H_
#define _SPCHDATA_H_

#include "spch_types.h"

extern int iSPCH_GetMatchValue(VoxPhrase *phrase, int index);         /* @0x80100710 */
extern int VoxSentence_GetShortRule(VoxSentence *sentence);           /* @0x80100724 */
extern int VoxSentence_GetNumPhrases(VoxSentence *sentence);          /* @0x80100730 */
extern int VoxEvent_GetFilterLengthFlag(VoxEvent *event);            /* @0x8010073C */
extern void *iSPCH_GetOffset8(void *base, unsigned char *table, int index);   /* @0x80100748 : base + table[index]*4 */
extern void *iSPCH_GetOffset16(void *base, unsigned short *table, int index); /* @0x80100760 : base + table[index]*4 */

#endif
