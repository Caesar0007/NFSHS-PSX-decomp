/* syslib/psx/libc/C26.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C26.obj ; libc.lib.  strncpy @0x800F6104 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x1A) to PSX BIOS A0:0x1A.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strncpy, 0xA0, 0x1A);   /* @0x800F6104  BIOS A0:0x1A */
