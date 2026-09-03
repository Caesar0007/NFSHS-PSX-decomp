#ifndef _SPCH_TYPES_H_
#define _SPCH_TYPES_H_

/* VoxBank: one speech sample bank blob (layout recovered by access census across
 * spchbank/spchpick/spchsamp, 2026-09-04 -- the lib's SYM is bare, so every field
 * below is evidenced by at least one read/write site, most by several TUs). */
typedef struct {
    unsigned short id;           /* +0x0 bank id (iSPCH_FindBank / iSPCH_GetPhraseBank key) */
    unsigned char  flags;        /* +0x2 low nibble = filterCnt (sample entry stride - 2);
                                  *      high nibble != 0 -> bank carries cycle bits */
    unsigned char  numSamples;   /* +0x3 */
    unsigned short dataSize256;  /* +0x4 SPU data size of one sub-bank, in 256-byte units */
    unsigned short subBankCount; /* +0x6 (0xffff = no sub-banks) */
    /* +0x8: numSamples packed sample entries of (2 + filterCnt) bytes each --
     *       entry[0..1] = big-endian16 start offset (<<8 = SPU bytes), entry[0]&0x80 =
     *       redirect to entry #entry[1], entry[2..] = filter bytes -- followed by the
     *       cycle-bits array (its byte[0] = nGroups). */
} VoxBank;

#endif
