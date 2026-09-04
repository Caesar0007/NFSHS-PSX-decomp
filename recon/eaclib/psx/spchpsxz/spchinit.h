#ifndef _SPCHINIT_H_
#define _SPCHINIT_H_

#include "spch_types.h"

typedef void *(*SPCHAllocFn)(int numBytes, const char *tag);
typedef void (*SPCHFreeFn)(void);

/* ---- speech state owned by spchinit.obj (+ the callback slots next to it) ---- */
extern int gGameNum;           /* @0x80148428 current game/race number */
extern int gFilterSetting;     /* @0x8014842C active filter mode (1 = length/priority filter) */
extern int gDataRate;          /* @0x80148434 sample data rate */
extern int gLastTick;          /* @0x80148438 last insert tick (spchevnt's user) */
extern int gSPCH_Initialized;  /* 0x1789a34 when initialised */
/* the five callback slots (@0x80137094..0x801370AC); SYM is bare for all five, so the
 * signatures are ours -- unified across the library 2026-09-04, byte-neutral (measured) */
extern SPCHAllocFn gMemAlloc;                                          /* @0x801370A8 */
extern SPCHFreeFn  gMemFree;                                           /* @0x801370AC */
extern void (*gSampleRequest)(int, int, int, int);                     /* @0x80137094 */
extern int  (*gSentenceRuleTest)(unsigned int, unsigned int, int);     /* @0x80137098 */
extern void (*gSentenceRuleSet)(unsigned int, unsigned int, int, int); /* @0x8013709C */

extern void *iSPCH_MemAlloc(int numBytes, const char *tag);             /* @0x800EB5A4 */
extern void iSPCH_MemFree(void *block);                                        /* @0x800EB5D4 */
extern void SPCH_Deinit(void);                                          /* @0x800EB600 */
extern void iSPCH_InitInGame(void);                                     /* @0x800EB654 */
extern int  SPCH_GetSampleDataRate(int numSamples, int rate, int channels); /* @0x800EB66C */
extern VoxBank **SPCH_InitBankMem(SPCHAllocFn memAllocFn, SPCHFreeFn memFreeFn, int numBanks);  /* @0x800EB6F0 */
extern int  SPCH_Init(void (*sampleRequestCb)(int, int, int, int), unsigned int gameNum, int dataRate); /* @0x800EB748 */

#endif
