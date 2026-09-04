#ifndef _SPCHSAMP_H_
#define _SPCHSAMP_H_

#include "spch_types.h"

extern void iSPCH_InitSample(int *out);                            /* @0x8010B5AC */
extern int  iSPCH_UnPackSample(VoxBank *bank, int sampleIdx, int *out); /* @0x8010B5D4 */

#endif
