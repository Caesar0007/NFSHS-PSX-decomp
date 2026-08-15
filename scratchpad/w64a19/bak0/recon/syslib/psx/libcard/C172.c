/* syslib/psx/libcard/C172.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(C172.OBJ): _card_load -- kick the asynchronous "load directory" operation for
 *   the card on channel `chan`.  Thin tail-call thunk into the PSX BIOS A0 jump table, entry 0xAC
 *   (_card_load / _card_async_load_directory).  Signature: int _card_load(int chan). */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(_card_load, 0xA0, 0xAC);   /* @0x80109D60 */
