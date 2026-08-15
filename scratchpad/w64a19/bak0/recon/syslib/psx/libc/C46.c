/* syslib/psx/libc/C46.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C46.obj ; libc.lib.  memchr @0x800FE388 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x2E) to PSX BIOS A0:0x2E.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(memchr, 0xA0, 0x2E);   /* @0x800FE388  BIOS A0:0x2E */
