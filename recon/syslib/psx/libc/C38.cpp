/* syslib/psx/libc/C38.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C38.obj ; libc.lib.  tolower @0x801035A0 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x26) to PSX BIOS A0:0x26.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(tolower, 0xA0, 0x26);   /* @0x801035A0  BIOS A0:0x26 */
