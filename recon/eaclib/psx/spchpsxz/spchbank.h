#ifndef _SPCHBANK_H_
#define _SPCHBANK_H_

#include "spch_types.h"

/* ---- bank-table storage (data-materialized in the spchbank data block) ---- */
extern VoxBank **gVoxBanks;  /* @~0x801370B4 heap array of gNumBanks VoxBank pointers */
extern int gNumBanks;        /* @0x801370B8  number of bank slots */
extern int gClearCycle;      /* @0x801370BC  "cycle-bit clearing enabled" (init 1); sits next to
                              * gNumBanks in the same data block, no home TU of its own yet */

extern void  iSPCH_InitBanks(void);                         /* @0x800EB1E0 */
extern void  iSPCH_DisposeBanks(void);                      /* @0x800EB1F4 */
extern VoxBank **iSPCH_BankMemAlloc(int numBanks);          /* @0x800EB234 : returns gVoxBanks */
extern int   iSPCH_GetFreeBank(void);                       /* @0x800EB2B8 */
extern int   iSPCH_FindBank(unsigned short key);                       /* @0x800EB310 */
extern bool iSPCH_TestSubBankBounds(int bankIdx, int subIdx); /* @0x800EB37C */
extern void  iSPCH_SetCycleBits(VoxBank *bank);             /* @0x800EB3C8 */
extern int   SPCH_AddBank(VoxBank *bank);                     /* @0x800EB520 */

#endif
