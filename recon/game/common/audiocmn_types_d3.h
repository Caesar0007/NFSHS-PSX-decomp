/* audiocmn_types_d3 -- moved verbatim out of audiocmn_types.h so that header holds only its include list. */
#ifndef NFS4_AUDIOCMN_TYPES_D3_H
#define NFS4_AUDIOCMN_TYPES_D3_H
struct AudioCmn_tReTrig {
    int count, pan;
    short delay, nextd;
    int patch;
    char bend, amp;
    coorddef pos;
};

struct AudioCmn_tAsyncSfxSlot {
    int bank, patch, handle, ticks, addr;
    char *header;
};
#endif
