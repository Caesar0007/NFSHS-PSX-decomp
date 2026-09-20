/* syslib/psx/libapi/CHCLRPAD.c -- RECONSTRUCTED.  obj libapi.lib(CHCLRPAD.OBJ): _remove_ChgclrPAD -- zero the BIOS ChangeClearPAD patch slots (B0:0x57 table).
 *   Sony hand assembly.  Retail LINKED this member (SYM FILE record at the tail of the link order: libapi PAD.obj
 *   references it) and its final link then REMOVED every function in it -- PAD.obj's callers were unreferenced.  The
 *   member's .bss is not removed by that stripping: it is the 16 bytes at 0x80148AE4, right after libcard END.obj
 *   (link order END, ssine, CHCLRPAD, PATCH = the last 32 bytes of .bss).  Lines generated from the PsyQ 4.3 object (scratchpad/psyq_pipe/strip_asm_gen.py). */
#include "../../../link_stripped.h"

long _chgclrpad_bss[4];   /* CHCLRPAD.obj .bss (0x10 B) : +0 = $ra parked across the BIOS calls */

ASM_LINK_STRIPPED(_remove_ChgclrPAD,
    "\tlui $1,%hi(_chgclrpad_bss)\n"
    "\tsw $31,%lo(_chgclrpad_bss)($1)\n"
    "\tjal EnterCriticalSection\n"
    "\t nop\n"
    "\taddiu $9,$0,87\n"
    "\taddiu $10,$0,176\n"
    "\tjalr $10\n"
    "\t nop\n"
    "\taddiu $10,$0,9\n"
    "\tlw $2,364($2)\n"
    "\tnop\n"
    "\taddi $3,$2,1580\n"
    ".L_remove_ChgclrPAD_30:\n"
    "\tsw $0,0($3)\n"
    "\taddiu $3,$3,4\n"
    "\taddiu $10,$10,-1\n"
    "\tbne $10,$0,.L_remove_ChgclrPAD_30\n"
    "\t nop\n"
    "\tjal FlushCache\n"
    "\t nop\n"
    "\tjal ExitCriticalSection\n"
    "\t nop\n"
    "\tlui $31,%hi(_chgclrpad_bss)\n"
    "\tlw $31,%lo(_chgclrpad_bss)($31)\n"
    "\tnop\n"
    "\tjr $31\n"
    "\t nop\n");
