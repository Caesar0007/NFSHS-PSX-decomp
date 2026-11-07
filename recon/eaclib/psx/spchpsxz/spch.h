/* spch.h -- SPCHPSXZ public interface: the SPCH_ entry points the game calls, spelled with plain C types.
 * The library's own sources keep the internal headers (spch_types.h + one per member): their Vox* layouts,
 * callback typedefs and iSPCH_ helpers are library-private -- no retail game object records any of them. */
#ifndef _SPCH_H_
#define _SPCH_H_

extern int   SPCH_AddBank(char *bank);                                  /* @0x800EB520 (spchbank) */
extern int   SPCH_AddEvent(unsigned int *table);                        /* @0x800E71B8 (spchevnt) */
extern void  SPCH_ClearEventQueue(void);                                /* @0x800E74E0 (spchevnt) */
extern void  SPCH_PlaySpeech(void);                                     /* @0x800E7644 (spchevnt) */
extern int   SPCH_ChooseSpeech(void);                                   /* @0x800E7684 (spchevnt) */
extern void  SPCH_Deinit(void);                                         /* @0x800EB600 (spchinit) */
extern int   SPCH_GetSampleDataRate(int numSamples, int rate, int channels);   /* @0x800EB66C (spchinit) */
extern void **SPCH_InitBankMem(char *(*memAllocFn)(long numBytes, char *tag),
                               void (*memFreeFn)(char *block), int numBanks);  /* @0x800EB6F0 (spchinit) */
extern int   SPCH_Init(long (*sampleRequestCb)(long bank, long offset, long size, long event),
                       unsigned int gameNum, int dataRate);             /* @0x800EB748 (spchinit) */
extern void  SPCH_SetPreLoadTicks(int ticks);                           /* @0x801018F4 (spchpick) */
extern int  *iSPCH_EACseedrandom(unsigned int seed);                    /* @0x800EBAC4 (spchrand) */
extern int   SPCH_ResolveData(char *dat);                               /* @0x800EBBD4 (spchrslv) */

#endif
