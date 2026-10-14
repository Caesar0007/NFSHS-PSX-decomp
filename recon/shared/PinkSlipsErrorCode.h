/* Retail SYM 5dc989..5dcad8: shared four-byte result type, not int. */
#ifndef NFS4_SHARED_PINKSLIPSERRORCODE_H
#define NFS4_SHARED_PINKSLIPSERRORCODE_H
typedef enum PinkSlipsErrorCode {
    PinkSlipsNoError = 0,
    PinkSlipsError_NotOriginalCard = 1,
    PinkSlipsError_LoadFailed = 2,
    PinkSlipsError_SaveFailed = 3,
    PinkSlipsError_CardNotFound = 4,
    PinkSlipsError_NotFormatted = 5,
    PinkSlipsError_CardFull = 6,
    numPinkSlipsErrors = 7
} PinkSlipsErrorCode;
#endif
