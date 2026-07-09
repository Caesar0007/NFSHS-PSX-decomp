/* syslib/psx/libc/C43.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C43.obj ; libc.lib.  memset @0x800E4318 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x2B) to PSX BIOS A0:0x2B.  Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(memset, 0xA0, 0x2B);   /* @0x800E4318  BIOS A0:0x2B */
