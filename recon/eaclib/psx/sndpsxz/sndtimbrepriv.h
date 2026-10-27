/* Private 0x98-byte tag-built timbre/override record. `fields` is the resolved typed view; `tag_words`
 * holds scalar values while `tag_data` holds the corresponding parser payload addresses. */
#ifndef _SNDPSXZ_SNDTIMBREPRIV_H_
#define _SNDPSXZ_SNDTIMBREPRIV_H_

union SndTimbreWordView {
    int word;
    unsigned int uword;
    unsigned short uhalf;
    unsigned char ubyte;
    unsigned char *byte_pointer;
    signed char *sbyte_pointer;
};
typedef char SndTimbreWordView_size_check[(sizeof(union SndTimbreWordView) == 4) ? 1 : -1];

struct SndTimbre {
    union SndTimbreWordView opaque_00;
    union SndTimbreWordView velocity_min;             /* +0x04 */
    union SndTimbreWordView velocity_max;             /* +0x08 */
    union SndTimbreWordView note_min;                 /* +0x0C */
    union SndTimbreWordView note_max;                 /* +0x10 */
    union SndTimbreWordView channel_priority;         /* +0x14 */
    union SndTimbreWordView allocation_flags;         /* +0x18 */
    union SndTimbreWordView base_note;                /* +0x1C */
    union SndTimbreWordView control32;                /* +0x20 */
    union SndTimbreWordView sweep_count;              /* +0x24 */
    union SndTimbreWordView envelope_detune;          /* +0x28 */
    union SndTimbreWordView channel_count;            /* +0x2C */
    union SndTimbreWordView detune;                   /* +0x30 */
    union SndTimbreWordView detune_range;             /* +0x34 */
    union SndTimbreWordView pan;                      /* +0x38 */
    union SndTimbreWordView pan_range;                /* +0x3C */
    union SndTimbreWordView base_detune;              /* +0x40 */
    union SndTimbreWordView base_detune_range;        /* +0x44 */
    union SndTimbreWordView final_volume_curve;       /* +0x48 */
    union SndTimbreWordView playback_factor;          /* +0x4C */
    union SndTimbreWordView opaque_50;
    union SndTimbreWordView pan_curve;                /* +0x54 */
    union SndTimbreWordView opaque_58;
    union SndTimbreWordView detune_curve;             /* +0x5C */
    union SndTimbreWordView opaque_60;
    union SndTimbreWordView envelope_sweep_table;     /* +0x64 */
    union SndTimbreWordView opaque_68;
    union SndTimbreWordView opaque_6C;
    union SndTimbreWordView portamento_initial;       /* +0x70 */
    union SndTimbreWordView velocity_curve;           /* +0x74 */
    union SndTimbreWordView velocity_phase_limit;     /* +0x78 */
    union SndTimbreWordView velocity_phase_seed;      /* +0x7C */
    union SndTimbreWordView pitch_lfo_table;          /* +0x80 */
    union SndTimbreWordView lfo_phase_limit;          /* +0x84 */
    union SndTimbreWordView pitch_lfo_depth;          /* +0x88 */
    union SndTimbreWordView pitch_lfo_seed;           /* +0x8C */
    union SndTimbreWordView apply_pitch_offset;       /* +0x90 */
    union SndTimbreWordView pan_scale;                /* +0x94 */
};
typedef char SndTimbre_size_check[(sizeof(struct SndTimbre) == 0x98) ? 1 : -1];

union SndTimbreBufferView {
    struct SndTimbre fields;
    int tag_words[0x26];
    unsigned char *tag_data[0x26];
};
typedef char SndTimbreBufferView_size_check[(sizeof(union SndTimbreBufferView) == 0x98) ? 1 : -1];

#endif /* _SNDPSXZ_SNDTIMBREPRIV_H_ */
