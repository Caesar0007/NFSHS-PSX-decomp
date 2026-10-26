/* Private PSX sound-bank table entry, corroborated by bank add/scan/remove consumers
 * and the independent SndBank layout in recon/lib/snd.h. */
#ifndef _SNDPSXZ_SNDBANKPRIV_H_
#define _SNDPSXZ_SNDBANKPRIV_H_

union SndBankLoadStateView {
    signed char s;
    unsigned char u;
};
typedef char SndBankLoadStateView_size_check[(sizeof(union SndBankLoadStateView) == 1) ? 1 : -1];

union SndBankPlatformAllocatedView {
    signed char s;
    unsigned char u;
};
typedef char SndBankPlatformAllocatedView_size_check[(sizeof(union SndBankPlatformAllocatedView) == 1) ? 1 : -1];

struct SndBankDataHeaderPrefix;

struct SndBankTableEntry {
    struct SndBankDataHeaderPrefix *data_block;       /* +0x00: common bank-image header prefix */
    void *platform_block;                              /* +0x04 */
    union SndBankLoadStateView load_state;             /* +0x08 */
    union SndBankPlatformAllocatedView platform_allocated; /* +0x09 */
    signed char opaque_0A;
    unsigned char opaque_0B;
};
typedef char SndBankTableEntry_size_check[(sizeof(struct SndBankTableEntry) == 0x0C) ? 1 : -1];

#endif /* _SNDPSXZ_SNDBANKPRIV_H_ */
