/* syslib/psx/libc/C27.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C27.obj ; libc.lib.  strlen @0x800E9F74 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x1B) to PSX BIOS A0:0x1B.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strlen, 0xA0, 0x1B);   /* @0x800E9F74  BIOS A0:0x1B */
