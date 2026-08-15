/* syslib/psx/libc/C42.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C42.obj ; libc.lib.  memcpy @0x800EAAC4 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x2A) to PSX BIOS A0:0x2A.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(memcpy, 0xA0, 0x2A);   /* @0x800EAAC4  BIOS A0:0x2A */
