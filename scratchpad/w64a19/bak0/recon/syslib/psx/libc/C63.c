/* syslib/psx/libc/C63.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C63.obj ; libc.lib.  printf @0x801028AC -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x3F) to PSX BIOS A0:0x3F.  Variadic; $a0..$a3 + stack args pass straight through.
 *   Real code is the console BIOS -> RULE 7 BIOS thunk.
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(printf, 0xA0, 0x3F);   /* @0x801028AC  BIOS A0:0x3F */
