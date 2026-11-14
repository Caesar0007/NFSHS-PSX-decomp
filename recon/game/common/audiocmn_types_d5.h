/* audiocmn_types_d5 -- moved verbatim out of audiocmn_types.h so that header holds only its include list. */
#ifndef NFS4_AUDIOCMN_TYPES_D5_H
#define NFS4_AUDIOCMN_TYPES_D5_H
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef long (*ReparmFuncPtr)();
typedef long (*TraceFuncPtr)();
#endif
