/* Common prefix of a loaded PSX sound-bank header. Type-specific patch-offset tables
 * follow at +0x0C or +0x14; this prefix does not claim their full extent. */
#ifndef _SNDPSXZ_SNDBANKHDRPRIV_H_
#define _SNDPSXZ_SNDBANKHDRPRIV_H_

struct SndBankDataHeaderPrefix {
    unsigned char opaque_00_02[3];
    unsigned char opaque_03;        /* root-bank header byte; do not conflate with tagged-patch flags */
    unsigned char type;             /* +0x04; value 4 selects the +0x14 patch-offset table */
    unsigned char opaque_05;
    unsigned short patch_count;     /* +0x06 */
    int header_size;                /* +0x08 */
};
typedef char SndBankDataHeaderPrefix_size_check[(sizeof(struct SndBankDataHeaderPrefix) == 0x0C) ? 1 : -1];



/* A patch-table entry points to a tagged-patch record, a distinct object from the
 * root bank header above. Its byte at +3 selects the tag-stream prefix form. */
struct SndTaggedPatchRecordPrefixView {
    unsigned char opaque_00_02[3];
    unsigned char flags;            /* +0x03; bit 1 selects +8 vs +4, bit 0 is resolved */
};
typedef char SndTaggedPatchRecordPrefixView_size_check[(sizeof(struct SndTaggedPatchRecordPrefixView) == 4) ? 1 : -1];

/* The tagged-patch record's tag stream begins at +4 or +8 according to its flags. These
 * prefix views name only the first byte at the selected stream boundary. */
struct SndTaggedPatchStream4PrefixView {
    struct SndTaggedPatchRecordPrefixView record;
    unsigned char first_tag_byte;    /* +0x04 */
};
typedef char SndTaggedPatchStream4PrefixView_size_check[(sizeof(struct SndTaggedPatchStream4PrefixView) == 5) ? 1 : -1];

struct SndTaggedPatchStream8PrefixView {
    struct SndTaggedPatchRecordPrefixView record;
    unsigned char opaque_04_07[4];
    unsigned char first_tag_byte;    /* +0x08 */
};
typedef char SndTaggedPatchStream8PrefixView_size_check[(sizeof(struct SndTaggedPatchStream8PrefixView) == 9) ? 1 : -1];

/* The two serialized variants place the relative patch-pointer list at different offsets. */
struct SndBankPatchTable12Prefix {
    struct SndBankDataHeaderPrefix header;
    struct SndTaggedPatchRecordPrefixView *first_relative_patch[1]; /* +0x0C; patch_count entries */
};
typedef char SndBankPatchTable12Prefix_size_check[(sizeof(struct SndBankPatchTable12Prefix) == 0x10) ? 1 : -1];

struct SndBankPatchTable20Prefix {
    struct SndBankDataHeaderPrefix header;
    unsigned char opaque_0C_13[8];
    struct SndTaggedPatchRecordPrefixView *first_relative_patch[1]; /* +0x14; patch_count entries */
};
typedef char SndBankPatchTable20Prefix_size_check[(sizeof(struct SndBankPatchTable20Prefix) == 0x18) ? 1 : -1];

/* Exact-displacement views for loops that carry a cursor across patch entries while keeping
 * the serialized table base folded into the +0x0C/+0x14 load/store displacement. */
union SndBankPatchRelocationValue {
    int file_offset;                                      /* before bank relocation */
    struct SndTaggedPatchRecordPrefixView *record;        /* after bank relocation */
};
typedef char SndBankPatchRelocationValue_size_check[(sizeof(union SndBankPatchRelocationValue) == 4) ? 1 : -1];

struct SndBankPatchOffset12CursorView {
    unsigned char opaque_000_00B[0x0C];
    union SndBankPatchRelocationValue relative_offset;
};
typedef char SndBankPatchOffset12CursorView_size_check[(sizeof(struct SndBankPatchOffset12CursorView) == 0x10) ? 1 : -1];

struct SndBankPatchOffset20CursorView {
    unsigned char opaque_000_013[0x14];
    union SndBankPatchRelocationValue relative_offset;
};
typedef char SndBankPatchOffset20CursorView_size_check[(sizeof(struct SndBankPatchOffset20CursorView) == 0x18) ? 1 : -1];

#endif /* _SNDPSXZ_SNDBANKHDRPRIV_H_ */
