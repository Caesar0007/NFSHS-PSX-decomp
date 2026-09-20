/* eaclib/psx/spchpsxz/spchdata.c -- RECONSTRUCTED.  spchpsxz.lib(spchdata.obj): the speech library's global DATA module.
 *   Retail SYM lists the module (FILE record, linked right before spchpick.obj) and no function belongs to it: the six
 *   Vox accessors once kept here are LOCAL labels of spchpick.obj.  Its contribution is this one contiguous .data block
 *   0x80137094..0x801370C4 (zero but INITIALISED in the image), which sits in spchdata.obj's link-order slot, right before
 *   sclcptch.obj's sndcents.  The variables are USED by spchinit / spchbank / spchpick / spchrule (externs in their headers). */
#include "../eaclib_types.h"
#include "spch_types.h"
/* first declarations in RETAIL ORDER: cc1 emits a file's uninitialised globals in the order it first saw them, and
 * spchinit.h (below) would otherwise introduce four of them early */
extern int gPreLoadTicks;
extern VoxEventDat *gEventDats[4];
extern int gVoxInGame;
extern int gRepeatCount;
extern VoxSlotsStruct gVoxEvents;
extern int gGameNum;
extern int gFilterSetting;
extern int gLastSubTick;
extern int gDataRate;
extern int gLastTick;
#include "spchinit.h"
#include "spchbank.h"

SPCHSampleRequestFn gSampleRequest = 0;                                   /* @0x80137094 */
int  (*gSentenceRuleTest)(unsigned int, unsigned int, int) = 0;           /* @0x80137098 */
void (*gSentenceRuleSet)(unsigned int, unsigned int, int, int) = 0;       /* @0x8013709C */
int gReparm = 0;                                                          /* @0x801370A0 */
int gTrace = 0;                                                           /* @0x801370A4 */
SPCHAllocFn gMemAlloc = 0;                                                /* @0x801370A8 */
SPCHFreeFn  gMemFree = 0;                                                 /* @0x801370AC */
int gSPCH_Initialized = 0;                                                /* @0x801370B0 */
VoxBank **gVoxBanks = 0;   /* @0x801370B4 */
int gNumBanks = 0;         /* @0x801370B8 */
int gClearCycle = 1;       /* @0x801370BC */
int gCDErrors = 0;         /* @0x801370C0 */

/* .bss 0x80148044..0x8014843C -- one contiguous run in spchdata.obj's link-order slot, retail names and order.
 * The users keep their own extern views (spchevnt.h spells gVoxInGame as int[2]: [1] is gRepeatCount). */
int gPreLoadTicks;              /* @0x80148044 */
VoxEventDat *gEventDats[4];     /* @0x80148048 the 4 bound event-data blobs */
int gVoxInGame;                 /* @0x80148058 */
int gRepeatCount;               /* @0x8014805C */
VoxSlotsStruct gVoxEvents;      /* @0x80148060 the 16-slot queue + its header (968 B) */
int gGameNum;                   /* @0x80148428 */
int gFilterSetting;             /* @0x8014842C */
int gLastSubTick;               /* @0x80148430 */
int gDataRate;                  /* @0x80148434 */
int gLastTick;                  /* @0x80148438 */
