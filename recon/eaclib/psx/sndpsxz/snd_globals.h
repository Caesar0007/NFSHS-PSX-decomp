/* snd_globals.h -- typed overlay of the shared sndgs state block. `play_records` and `bank_table`
 * are typed array bases. Do not combine with sdata.h's generic `int sndgs[]` view in one TU. */
#ifndef _SNDPSXZ_SND_GLOBALS_H_
#define _SNDPSXZ_SND_GLOBALS_H_

struct SndBankTableEntry;
struct SndChannel;

struct SNDGlobals {
    char pad0[0x0c];
    unsigned short bank_count;
    char pad0e[3];
    unsigned char channel_count;
    char pad12[0x2a];
    signed char initialized;
    char pad3d[0x57];
    struct SndChannel *play_records;
    struct SndBankTableEntry *bank_table; /* +0x98 */
};

extern struct SNDGlobals sndgs;

#endif /* _SNDPSXZ_SND_GLOBALS_H_ */
