/* Private PSX SND effect-bus record. Local setters/readers establish the
 * type/master/depth/delay layout and bus-0 base at sndgs+0x9C. The indexed code
 * retains a 0x10 stride, but +0xAC overlaps live server-state fields and the
 * known game callsites use bus 0; do not infer an independent PSX bus-1 record
 * from the generic shared SndState view alone. */
#ifndef _SNDPSXZ_SNDFXPRIV_H_
#define _SNDPSXZ_SNDFXPRIV_H_

typedef struct SndFxBus {
    int type;       /* +0x00 */
    int master;     /* +0x04 */
    int depth;      /* +0x08 */
    int delay;      /* +0x0C */
} SndFxBus;
typedef char SndFxBus_size_check[(sizeof(SndFxBus) == 0x10) ? 1 : -1];

#endif /* _SNDPSXZ_SNDFXPRIV_H_ */
