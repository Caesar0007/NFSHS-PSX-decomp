/* syslib/psx/libc/C23.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C23.obj ; libc.lib.  strcmp @0x800E5D7C -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x17) to PSX BIOS A0:0x17.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strcmp, 0xA0, 0x17);   /* @0x800E5D7C  BIOS A0:0x17 */
