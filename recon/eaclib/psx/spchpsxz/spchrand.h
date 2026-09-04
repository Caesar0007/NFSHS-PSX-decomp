#ifndef _SPCHRAND_H_
#define _SPCHRAND_H_

#include "spch_types.h"

extern unsigned int seedX[];   /* @0x801235F4 the 6-word PRNG state (word0 = accumulator) */

extern int   iSPCH_EACrandom(void);                 /* @0x800EB9C4 */
extern int  *iSPCH_EACseedrandom(unsigned int seed);/* @0x800EBAC4 */
extern int   iSPCH_Rand(int n);                     /* @0x800EBB30 */
extern int   iSPCH_BindData(unsigned short *dat);   /* @0x800EBB84 */

#endif
