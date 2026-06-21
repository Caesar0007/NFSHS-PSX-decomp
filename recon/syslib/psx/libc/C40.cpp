/* syslib/psx/libc/C40.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C40.obj ; libc.lib.  bzero @0x8010A540 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x28) to PSX BIOS A0:0x28.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(bzero, 0xA0, 0x28);   /* @0x8010A540  BIOS A0:0x28 */
