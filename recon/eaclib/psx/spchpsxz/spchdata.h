#ifndef _SPCHDATA_H_
#define _SPCHDATA_H_

#include "spch_types.h"


extern int iSPCH_GetMatchValue(VoxPhrase *phrase, int index);         /* @0x80100710 */
extern int VoxSentence_GetShortRule(VoxSentence *sentence);           /* @0x80100724 */
extern int VoxSentence_GetNumPhrases(VoxSentence *sentence);          /* @0x80100730 */
extern int VoxEvent_GetFilterLengthFlag(VoxEvent *event);            /* @0x8010073C */
extern int iSPCH_GetOffset8(int base, int tableBase, int index);      /* @0x80100748 */
extern int iSPCH_GetOffset16(int base, int tableBase, int index);    /* @0x80100760 */

#endif
