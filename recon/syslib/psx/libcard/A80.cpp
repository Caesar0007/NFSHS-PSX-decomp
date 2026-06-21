/* syslib/psx/libcard/A80.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(A80.OBJ): _new_card -- tell the BIOS to accept a freshly-inserted card on the
 *   next access (clears the "card changed" latch).  Thin tail-call thunk into the PSX BIOS B0 jump
 *   table, entry 0x50 (allow_new_card). */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(_new_card, 0xB0, 0x50);    /* @0x8010A090 */
