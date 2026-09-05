#ifndef _SPCHEVNT_H_
#define _SPCHEVNT_H_

#include "spch_types.h"

/* ---- storage owned by spchevnt.obj ---- */
extern VoxSlotsStruct gVoxEvents;   /* @0x80148060 the 16-slot queue + its header */
extern int gPreLoadTicks;           /* @0x80148044 */
extern VoxEventDat *gEventDats[4];  /* @0x80148048 the 4 bound event-data blobs */
extern int gVoxInGame[2];           /* @0x80148058; [1] is retail's gRepeatCount */
extern int gReparm;                 /* @0x801370A0 optional re-parameterize hook slot */

extern VoxEvent *iSPCH_SearchEventDat(VoxEventDat *dat, unsigned int eventID); /* @0x800E6EC4 */
extern VoxEvent *iSPCH_FindEvent(unsigned int eventID);               /* @0x800E6F4C */
extern void iSPCH_InitEventDat(void);                                 /* @0x800E6FBC */
extern int  GetFilterLength(void);                                    /* @0x800E6FE4 */
extern int  GetFilterPriority(void);                                  /* @0x800E6FFC */
extern void iSPCH_InitEventQueue(void);                               /* @0x800E7014 */
extern int  iSPCH_FindEventSlot(unsigned int priority);              /* @0x800E7088 */
extern int  SPCH_AddEvent(unsigned int *table);                      /* @0x800E71B8 */
extern int  iSPCH_ChooseEvent(void);                                 /* @0x800E7300 */
extern void SPCH_ClearEventQueue(void);                              /* @0x800E74E0 */
extern void iSPCH_ClearOldEvents(int winnerSlot);                    /* @0x800E7528 */
extern void SPCH_PlaySpeech(void);                                   /* @0x800E7644 */
extern int  SPCH_ChooseSpeech(void);                                 /* @0x800E7684 */

#endif
