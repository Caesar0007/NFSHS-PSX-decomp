/* syslib/psx/libc/C25.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C25.obj ; libc.lib.  strcpy @0x800E5B28 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x19) to PSX BIOS A0:0x19.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strcpy, 0xA0, 0x19);   /* @0x800E5B28  BIOS A0:0x19 */
