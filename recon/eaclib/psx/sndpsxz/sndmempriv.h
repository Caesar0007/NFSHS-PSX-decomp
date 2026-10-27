/* Private free-list and SPU sample-memory state views shared by allocator consumers. */
#ifndef _SNDPSXZ_SNDMEMPRIV_H_
#define _SNDPSXZ_SNDMEMPRIV_H_

struct SndSpuFreeBlock {
    unsigned short block; /* SPU RAM address in 64-byte units */
    unsigned short size;  /* extent in 64-byte units */
};
typedef char SndSpuFreeBlock_size_check[(sizeof(struct SndSpuFreeBlock) == 4) ? 1 : -1];

struct SndSpuAllocatorBounds {
    unsigned short block_total;
    unsigned short reverb_mode;
};
struct SndSpuAllocatorBoundary {
    union {
        struct SndSpuAllocatorBounds limits; /* sndpd+0x51C/+0x51E */
        struct SndSpuFreeBlock virtual_previous; /* free-list entry[-1] */
    } view;
};
struct SndSpuMemoryState {
    unsigned short alloc_count; /* sndpd+0x518 */
    unsigned short engine_ver;  /* sndpd+0x51A */
    struct SndSpuAllocatorBoundary boundary; /* sndpd+0x51C */
};
typedef char SndSpuMemoryState_size_check[(sizeof(struct SndSpuMemoryState) == 8) ? 1 : -1];

/* Displacement view into sndpd. The allocator admits at most 0x80 entries; the table ends at +0x720. */
struct SndSpuMemoryStateView {
    unsigned char reserved_000_517[0x518];
    struct SndSpuMemoryState memory;
    struct SndSpuFreeBlock entries[0x80]; /* sndpd+0x520..+0x71F */
};
typedef char SndSpuMemoryStateView_size_check[(sizeof(struct SndSpuMemoryStateView) == 0x720) ? 1 : -1];

#endif /* _SNDPSXZ_SNDMEMPRIV_H_ */
