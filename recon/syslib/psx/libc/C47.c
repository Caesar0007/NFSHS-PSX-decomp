/* syslib/psx/libc/C47.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C47.obj ; libc.lib.  rand @0x800EAAD4 -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x2F) to PSX BIOS A0:0x2F.  Real code (the LCG over RandSeed) is the console BIOS,
 *   NOT the EXE -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(rand, 0xA0, 0x2F);   /* @0x800EAAD4  BIOS A0:0x2F */
