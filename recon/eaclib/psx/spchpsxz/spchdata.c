/* eaclib/psx/spchpsxz/spchdata.c -- RECONSTRUCTED.  spchpsxz.lib(spchdata.obj): the speech library's global DATA module.
 *   Retail SYM lists the module (FILE record, linked right before spchpick.obj) and no function belongs to it: the six
 *   Vox accessors once kept here are LOCAL labels of spchpick.obj.  Its contribution is this one contiguous .data block
 *   0x80137094..0x801370C4 (zero but INITIALISED in the image), which sits in spchdata.obj's link-order slot, right before
 *   sclcptch.obj's sndcents.  The variables are USED by spchinit / spchbank / spchpick / spchrule (externs in their headers). */
#include "../eaclib_types.h"
#include "spch_types.h"
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
