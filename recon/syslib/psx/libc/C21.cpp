/* syslib/psx/libc/C21.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C21.obj ; libc.lib.  strcat @0x800E78E8 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x15) to PSX BIOS A0:0x15.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strcat, 0xA0, 0x15);   /* @0x800E78E8  BIOS A0:0x15 */
