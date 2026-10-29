#ifndef _SPCHDATA_H_
#define _SPCHDATA_H_

#include "spch_types.h"

/* Shared declarations for the zero-initialized speech state owned by spchdata.obj.
 * Keep this order: it is also the order in which the owner first declares the BSS run. */
extern int gPreLoadTicks;               /* @0x80148044 */
extern VoxEventDat *gEventDats[4];      /* @0x80148048 */
typedef struct {
    int lastEventId;
    int repeatCount;
} SPCHInGameState;
extern SPCHInGameState gVoxInGame;      /* @0x80148058; two adjacent state words */
extern VoxSlotsStruct gVoxEvents;       /* @0x80148060 */
extern int gGameNum;                    /* @0x80148428 */
extern int gFilterSetting;              /* @0x8014842C */
extern int gLastSubTick;                /* @0x80148430; spchevnt uses the low 16 bits */
extern int gDataRate;                   /* @0x80148434 */
extern int gLastTick;                   /* @0x80148438 */

#endif
