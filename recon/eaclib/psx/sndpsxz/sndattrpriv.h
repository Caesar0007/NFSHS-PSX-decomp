#ifndef _SNDPSXZ_SNDATTRPRIV_H_
#define _SNDPSXZ_SNDATTRPRIV_H_

/* The parser writes this 0x0C-byte logical attribute block. */
typedef struct SndPatchAttributeBlock {
    int patch_id;                       /* +0x00: tag 5; passed to iSNDallocchan */
    unsigned short base_detune;         /* +0x04: reset to zero; copied to SndChannel */
    unsigned char velocity;             /* +0x06: tag 6; signed load at allocator call */
    unsigned char patch_volume;         /* +0x07: default 0x7F */
    unsigned char pan;                  /* +0x08: default 0x40 */
    unsigned char playback_factor34;    /* +0x09: tag 0x13 */
    unsigned char envelope_detune;      /* +0x0A: tag 0x0A; multiplied by 100 */
    unsigned char use3dpos;             /* +0x0B: tag 0x80; selects 3D channel data */
} SndPatchAttributeBlock;
typedef char SndPatchAttributeBlock_size_check[(sizeof(SndPatchAttributeBlock) == 0x0c) ? 1 : -1];

/* Stream parser compares and copies a full 0x14-byte record although the tag
 * parser writes only the leading attribute block; preserve the unknown tail. */
typedef struct SndPatchAttributes {
    SndPatchAttributeBlock attributes;  /* +0x00..+0x0B */
    unsigned char unknown0c[8];         /* +0x0C..+0x13 */
} SndPatchAttributes;
typedef char SndPatchAttributes_size_check[(sizeof(SndPatchAttributes) == 0x14) ? 1 : -1];

#endif /* _SNDPSXZ_SNDATTRPRIV_H_ */
