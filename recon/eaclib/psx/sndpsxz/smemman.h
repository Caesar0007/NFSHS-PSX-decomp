#ifndef _SNDPSXZ_SMEMMAN_H_
#define _SNDPSXZ_SMEMMAN_H_

typedef struct SndMemEnt {
    unsigned short blk, sz;
} SndMemEnt;

typedef struct SNDMemState {
    unsigned char *base;             /* +0x00: pool byte-address base */
    unsigned short count;
    unsigned short poolWords;
    int            highWater;
    SndMemEnt      entries[128];
} SNDMemState;

extern SNDMemState sndmm;

extern void iSNDmemconstrain(int *block, int *size); /* @0x801061A8 */
extern SNDMemState *iSNDmeminit(void *membase, int memsize); /* @0x801061D4 */
extern unsigned int iSNDmemrestore(void); /* @0x801061F4 */
extern void *iSNDmalloc(int size); /* @0x80106238 */

#endif /* _SNDPSXZ_SMEMMAN_H_ */
