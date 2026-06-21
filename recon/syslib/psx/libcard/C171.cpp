/* syslib/psx/libcard/C171.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(C171.OBJ): _card_info -- request the directory/status info for the card on
 *   channel `chan`.  Thin tail-call thunk into the PSX BIOS A0 jump table, entry 0xAB
 *   (_card_info / get_card_info).  The PSX form loads the table base into $t2, the call index into
 *   $t1, and jumps (jr, not jal) so the BIOS routine returns straight to our caller with $a0..$a3
 *   passed through untouched.  Signature: int _card_info(int chan). */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(_card_info, 0xA0, 0xAB);   /* @0x80109D10 */
