/* syslib/psx/libc/C24.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C24.obj ; libc.lib.  strncmp @0x800EB1D0 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x18) to PSX BIOS A0:0x18.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strncmp, 0xA0, 0x18);   /* @0x800EB1D0  BIOS A0:0x18 */
