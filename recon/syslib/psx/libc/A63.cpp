/* syslib/psx/libc/A63.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj A63.obj ; libc.lib.  puts @0x800E80CC -- BIOS trampoline (B0:0x3F -> std_out_puts).  In the EXE
 *   this is a 3-insn tail-call (addiu $t2,$zero,0xB0; jr $t2; addiu $t1,$zero,0x3F) to the PSX BIOS, so
 *   per RULE 7 it stays a BIOS thunk (the real code is the console BIOS TTY).
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(puts, 0xB0, 0x3F);   /* @0x800E80CC */
