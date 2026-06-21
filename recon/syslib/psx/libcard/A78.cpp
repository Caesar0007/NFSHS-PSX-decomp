/* syslib/psx/libcard/A78.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(A78.OBJ): _card_write -- write one 128-byte sector (`block`) of the card on
 *   `chan` from `buf`.  Thin tail-call thunk into the PSX BIOS B0 jump table, entry 0x4E
 *   (write_card_sector).  Signature: int _card_write(int chan, int block, unsigned char *buf). */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(_card_write, 0xB0, 0x4E);  /* @0x8010A0A0 */
