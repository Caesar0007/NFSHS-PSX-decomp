/* syslib/psx/libc/C16.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C16.obj ; libc.lib.  atoi @0x800EB100 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x10) to PSX BIOS A0:0x10.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(atoi, 0xA0, 0x10);   /* @0x800EB100  BIOS A0:0x10 */
