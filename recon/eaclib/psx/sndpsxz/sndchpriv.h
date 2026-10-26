#ifndef _SNDPSXZ_SNDCHPRIV_H_
#define _SNDPSXZ_SNDCHPRIV_H_

/* Private 100-byte voice/channel-pool record. This header is for sndpsxz
 * implementation TUs only; it is not a game-facing API. Field roles are
 * reconstructed from PSX accesses plus allocator, tick-server and SND helper
 * consumers; unknown bytes remain explicitly named/padded. */
/* On the little-endian PSX target, `halves.high` is the signed short at word+2;
 * calcvol reads it while the tick server updates the enclosing word. */
typedef union SndChannelWordView {
    int word;
    struct {
        unsigned short low;
        short high;
    } halves;
} SndChannelWordView;

/* Cross-context overlay at +0x34..+0x36: patch playback uses two signed factors
 * and group management uses the final group flag; FX-level code instead treats
 * these as a moving [previous,next] byte window at +0x34+bus. The public state
 * view has two FX buses, so bus 0/1 spans exactly these three bytes. */
typedef union SndChannelPlaybackFxView {
    struct {
        signed char playback_factor34;
        signed char playback_factor35;
        unsigned char group_flag;
    } playback;
    signed char fx_level_window[3];
} SndChannelPlaybackFxView;

typedef union SndChannelLinkedTagView {
    unsigned char linked_channels[6];
    struct {
        unsigned char bytes04_07[4];
        short tagged_patch_word;
    } tagged_patch;
} SndChannelLinkedTagView;

typedef struct SndSweepSegment {
    int duration;       /* +0x00: countdown ticks; negative means the terminal segment */
    int target_pitch;   /* +0x04: 16.16 pitch target source */
} SndSweepSegment;
typedef char SndSweepSegment_size_check[(sizeof(SndSweepSegment) == 8) ? 1 : -1];

typedef struct SndChannel {
    unsigned int owner_tag;               /* +0x00: allocation/request tag */
    SndChannelLinkedTagView linked_tag_view; /* +0x04..+0x09: allocator's linked indices; tagged patch also stores a word at +0x08 */
    signed char start_marker;             /* +0x0A: initialized to -1 by SNDPKTPLAY_start */
    signed char state;                    /* +0x0B: 0 free, 1 held, 2 linked/active */
    unsigned char age;                    /* +0x0C: allocator age */
    unsigned char pad0d[3];               /* +0x0D..+0x0F */
    unsigned int allocation_tick;         /* +0x10: allocation timestamp */
    int autovol_step;                     /* +0x14 */
    int autovol_limit;                    /* +0x18 */
    SndChannelWordView autovol_position;  /* +0x1C: word and high/low halfword views */
    int portamento_step;                  /* +0x20 */
    SndChannelWordView portamento_position; /* +0x24: word and high/low halfword views */
    int sweep_countdown;                  /* +0x28 */
    signed char patch_volume;             /* +0x2C */
    signed char volume;                   /* +0x2D: cached/current volume */
    signed char pan;                      /* +0x2E: base pan used by SNDpan */
    signed char bend;                     /* +0x2F */
    signed char sweep_count;              /* +0x30: signed segment-count comparison */
    unsigned char sweep_index;            /* +0x31 */
    unsigned char control32;              /* +0x32 */
    signed char pan_scale;                /* +0x33: signed scale about center; 1 is identity */
    SndChannelPlaybackFxView playback_fx; /* +0x34..+0x36: playback factors/group flag or FX level window */
    unsigned char group_id;               /* +0x37: group discriminator used by freechan */
    unsigned char velocity_phase_limit;   /* +0x38 */
    unsigned char lfo_phase_limit;        /* +0x39 */
    unsigned char velocity_phase;         /* +0x3A */
    unsigned char pitch_lfo_phase;        /* +0x3B */
    signed char linked_primary;           /* +0x3C: primary channel index for linked voices */
    signed char current_pan;              /* +0x3D: current pan angle */
    short tag_word_e;                     /* +0x3E: tagged playback copies the short from tag+0x0E */
    SndSweepSegment *sweep_table;         /* +0x40: segment table (duration, target pitch) */
    unsigned char *final_volume_curve;    /* +0x44: unsigned volume remap table */
    signed char *pan_curve;               /* +0x48: signed-byte pan remap table */
    signed char *detune_curve;            /* +0x4C: signed-byte bend table */
    signed char *velocity_curve;          /* +0x50: signed-byte velocity curve */
    signed char *pitch_lfo_table;         /* +0x54: signed-byte LFO table */
    short pitch_lfo_depth;                /* +0x58 */
    short envelope_detune_depth;          /* +0x5A */
    short base_detune;                    /* +0x5C */
    unsigned short linear_pitch_cache;    /* +0x5E */
    unsigned short base_pitch;            /* +0x60 */
    unsigned short spu_pitch;             /* +0x62 */
} SndChannel;
typedef char SndChannel_size_check[(sizeof(SndChannel) == 0x64) ? 1 : -1];

#endif /* _SNDPSXZ_SNDCHPRIV_H_ */
