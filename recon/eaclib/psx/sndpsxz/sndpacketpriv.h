/* Private per-voice DMA/packet state stored in sndpd+0xD8, stride 0x2C. */
#ifndef _SNDPSXZ_SNDPACKETPRIV_H_
#define _SNDPSXZ_SNDPACKETPRIV_H_

union SndPacketPitchWordView {
    short s;
    unsigned short u;
    volatile short vs;
    volatile unsigned short vu;
};
typedef union SndPacketPitchWordView SndPacketPitchWordView;
typedef char SndPacketPitchWordView_size_check[(sizeof(SndPacketPitchWordView) == 2) ? 1 : -1];

union SndPacketLinkIndexView {
    signed char s;
    unsigned char u;
    volatile signed char vs;
    volatile unsigned char vu;
};
typedef union SndPacketLinkIndexView SndPacketLinkIndexView;
typedef char SndPacketLinkIndexView_size_check[(sizeof(SndPacketLinkIndexView) == 1) ? 1 : -1];

union SndPacketSubmitFrameView {
    int words[8];
    struct {
        int word_00;
        int data_size;       /* +0x04 */
        int word_08;
        unsigned char *channel_data[5]; /* +0x0C; variable-length sample-pointer list */
    } fields;
};
typedef union SndPacketSubmitFrameView SndPacketSubmitFrameView;
typedef char SndPacketSubmitFrameView_size_check[(sizeof(SndPacketSubmitFrameView) == 0x20) ? 1 : -1];

struct SndPacketVoiceState {
    unsigned char *spu_start_address; /* +0x00: resolved SPU sample start address */
    int loop_length_param;         /* +0x04: tag 0x85 loop-length value */
    unsigned int position_step;          /* +0x08: per-tick playback-position step set by iSNDplatformpitch */
    int byte_position;                /* +0x0C: SPU play position, 12 fractional bits */
    int served_position;              /* +0x10 */
    int loop_length;                  /* +0x14: 12-bit-shifted loop length */
    unsigned short volume_angle;      /* +0x18 */
    SndPacketPitchWordView initial_pitch; /* +0x1A: signed store, unsigned pitch read */
    unsigned char play_state;         /* +0x1C */
    unsigned char voice_status;       /* +0x1D: 0/2/3 observed in iSNDserve */
    unsigned char route;              /* +0x1E */
    unsigned char channel_count;      /* +0x1F */
    SndPacketLinkIndexView link_index; /* +0x20: signed index, plus unsigned/volatile byte views */
    unsigned char link_flag;          /* +0x21 */
    unsigned char level;              /* +0x22 */
    unsigned char fx_level;           /* +0x23 */
    unsigned char pan_left_cache;  /* +0x24: signed pan output cached for delta-pan calls */
    unsigned char pan_right_cache; /* +0x25: signed pan output cached for delta-pan calls */
    unsigned char stop_pending;       /* +0x26 */
    unsigned char voice_done;         /* +0x27: high-bit/status tag also tested by iSNDserve */
    unsigned char pitch_dirty;        /* +0x28 */
    unsigned char pad29_2b[3];
};
typedef struct SndPacketVoiceState SndPacketVoiceState;
typedef char SndPacketVoiceState_size_check[(sizeof(struct SndPacketVoiceState) == 0x2C) ? 1 : -1];

union SndPacketContextHalfword {
    unsigned short u;
    short s;
};
typedef union SndPacketContextHalfword SndPacketContextHalfword;

/* Proven prefix of each malloc'd per-player SPU context; allocation extends beyond this view. */
struct SndPacketPlayerContextPrefix {
    unsigned char *spu_address;       /* +0x00: allocated SPU byte-address base */
    int spu_size;                     /* +0x04 */
    int source_channel_stride;        /* +0x08 */
    int buffer_bytes;                 /* +0x0C */
    int queue_threshold;              /* +0x10 */
    int write_position;               /* +0x14 */
    int serve_position;               /* +0x18 */
    int last_new_position;            /* +0x1C */
    int dma_handle;                   /* +0x20 */
    unsigned char *channel_frame_data0; /* +0x24: next sample-byte address */
    unsigned char opaque_28_2B[4];   /* +0x28: no typed consumer establishes scalar or address semantics */
    unsigned short *frame_size_table; /* +0x2C: per-chunk 16-bit frame-byte counters */
    SndPacketContextHalfword channel_frame_stride;   /* +0x30 */
    SndPacketContextHalfword source_frame_offset;    /* +0x32 */
    SndPacketContextHalfword source_frame_remaining; /* +0x34 */
    SndPacketContextHalfword empty_source_loop_count; /* +0x36: zeroed on a new frame; counts empty-source loop-back/end passes */
    unsigned short frame_count;                      /* +0x38 */
    SndPacketContextHalfword frame_index;             /* +0x3A */
    SndPacketContextHalfword spu_bytes_remaining;     /* +0x3C */
    SndPacketContextHalfword spu_buffer_offset;       /* +0x3E */
    SndPacketContextHalfword queue_fill_limit;        /* +0x40 */
    signed char active_note;          /* +0x42: -1 means idle */
    unsigned char block_shift;        /* +0x43 */
    SndPacketContextHalfword block_bytes;             /* +0x44 */
    SndPacketContextHalfword frames_per_block;        /* +0x46 */
    unsigned char *channel_buffer0;   /* +0x48: channel RAM buffer */
    unsigned char *channel_buffer1;   /* +0x4C: second channel RAM buffer */
};
typedef struct SndPacketPlayerContextPrefix SndPacketPlayerContextPrefix;
typedef char SndPacketPlayerContextPrefix_size_check[(sizeof(struct SndPacketPlayerContextPrefix) == 0x50) ? 1 : -1];

/* Two callback-selected context slots at +0x4F8/+0x4FC; the remaining bytes to allocator state +0x518 are opaque. */
struct SndPacketContextTableView {
    unsigned char opaque_000_4F7[0x4F8];
    SndPacketPlayerContextPrefix *contexts[2];
    unsigned char opaque_500_517[0x18];
};
typedef char SndPacketContextTableView_size_check[(sizeof(struct SndPacketContextTableView) == 0x518) ? 1 : -1];

/* Exact-displacement cursor for code that first computes sndpd + player*4 and then loads
 * the context pointer as a fixed +0x4F8 displacement. This is not an independent table base. */
struct SndPacketContextSlotCursorView {
    unsigned char opaque_000_4F7[0x4F8];
    SndPacketPlayerContextPrefix *context;
};
typedef char SndPacketContextSlotCursorView_size_check[(sizeof(struct SndPacketContextSlotCursorView) == 0x4FC) ? 1 : -1];

#endif /* _SNDPSXZ_SNDPACKETPRIV_H_ */
