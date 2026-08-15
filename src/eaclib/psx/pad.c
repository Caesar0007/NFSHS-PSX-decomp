#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", padinit);
INCLUDE_ASM("asm/nonmatchings/main", PAD_restore);
INCLUDE_ASM("asm/nonmatchings/main", PAD_state);
/* W67-A5: restored (W58 stub removal was right for the report -- the stub sat in the WRONG
 * unit, syslib/psx/libpad -- and wrong for the link: the asm body exists and no src TU
 * included it, leaving `PAD_convert' undefined in the src-lane link).  Retail VA order:
 * PAD_state 0x800E41AC < PAD_convert 0x800E41FC < PAD_update 0x800E4210. */
INCLUDE_ASM("asm/nonmatchings/main", PAD_convert);
INCLUDE_ASM("asm/nonmatchings/main", PAD_update);
