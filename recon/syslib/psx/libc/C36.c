/* syslib/psx/libc/C36.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C36.obj ; libc.lib.  strstr @0x800E62CC -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x24) to PSX BIOS A0:0x24.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strstr, 0xA0, 0x24);   /* @0x800E62CC  BIOS A0:0x24 */
