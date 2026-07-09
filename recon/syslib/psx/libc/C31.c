/* syslib/psx/libc/C31.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C31.obj ; libc.lib.  strrchr @0x80103590 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x1F) to PSX BIOS A0:0x1F.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(strrchr, 0xA0, 0x1F);   /* @0x80103590  BIOS A0:0x1F */
