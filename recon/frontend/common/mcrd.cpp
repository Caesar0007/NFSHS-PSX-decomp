/* frontend/common/mcrd.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3 @0x80050244).
 *   MCRD_getcard: memory-card slot accessor over the global gMemCardInfo (fMemCardInfo_def
 *   @0x80052D68).  Selects card `card` (1..8), sets the active PSX dev-port/slot channel
 *   (slot in bits0-1, port in bit4), and returns a pointer to that card's CARDINFO_def
 *   (card[] @+0x49C, 616 bytes each).  Body is an exact transcription of the MIPS:
 *     a0=card-1; chan = ((a0&4)<<2)|(a0&3); gMemCardInfo.channel=chan;
 *     return gMemCardInfo + 0x49C + a0*616  == &gMemCardInfo.card[a0].
 */
#include "../../nfs4_types.h"

extern fMemCardInfo_def gMemCardInfo;   /* @0x80052D68 (link_defs.cpp owns the BSS) */

CARDINFO_def *MCRD_getcard(int card)
{
    int idx = card - 1;
    gMemCardInfo.channel = ((idx & 4) << 2) | (idx & 3);
    return &gMemCardInfo.card[idx];
}
