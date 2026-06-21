/* syslib/psx/libc/C30.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C30.obj ; libc.lib.  strchr @0x800F6214 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x1E) to PSX BIOS A0:0x1E.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strchr, 0xA0, 0x1E);   /* @0x800F6214  BIOS A0:0x1E */
