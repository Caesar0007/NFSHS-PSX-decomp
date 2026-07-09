/* syslib/psx/libc/C19.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj C19.obj ; libc.lib.  setjmp @0x8010668C -- 3-insn BIOS trampoline (addiu $t2,$zero,0xA0; jr $t2;
 *   addiu $t1,$zero,0x13) to PSX BIOS A0:0x13 (SaveState).  RULE 7 BIOS thunk (args pass through; the
 *   BIOS saves the caller context into `env`, returns 0 first time and the longjmp value later).
 */
#include "../../../lib/bios_thunk.h"

BIOS_THUNK(setjmp, 0xA0, 0x13);   /* @0x8010668C  BIOS A0:0x13 */
