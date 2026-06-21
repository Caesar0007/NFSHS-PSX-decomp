/* syslib/psx/libc/C37.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C37.obj ; libc.lib.  toupper @0x8010907C -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x25) to PSX BIOS A0:0x25.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(toupper, 0xA0, 0x25);   /* @0x8010907C  BIOS A0:0x25 */
