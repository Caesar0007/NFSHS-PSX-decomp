/* syslib/psx/libapi/PATCH.c -- RECONSTRUCTED.  obj libapi.lib(PATCH.OBJ): EnablePAD / DisablePAD (tail-jump through the two saved BIOS entry points) and _patch_pad (find them).
 *   Sony hand assembly.  Retail LINKED this member (SYM FILE record at the tail of the link order: libapi PAD.obj
 *   references it) and its final link then REMOVED every function in it -- PAD.obj's callers were unreferenced.  The
 *   member's .bss is not removed by that stripping; its retail address is unknown (no label), so it is left to the
 *   linker.  Lines generated from the PsyQ 4.3 object (scratchpad/psyq_pipe/strip_asm_gen.py). */
#include "../../../link_stripped.h"

long _patchpad_bss[4];   /* PATCH.obj .bss: +0 $ra, +8 / +12 the two BIOS pad entry points */

ASM_LINK_STRIPPED(EnablePAD,
    "\tlui $9,%hi(_patchpad_bss+8)\n"
    "\tlw $9,%lo(_patchpad_bss+8)($9)\n"
    "\tnop\n"
    "\tjr $9\n"
    "\t nop\n");
ASM_LINK_STRIPPED(DisablePAD,
    "\tlui $9,%hi(_patchpad_bss+12)\n"
    "\tlw $9,%lo(_patchpad_bss+12)($9)\n"
    "\tnop\n"
    "\tjr $9\n"
    "\t nop\n");
ASM_LINK_STRIPPED(_patch_pad,
    "\tlui $1,%hi(_patchpad_bss)\n"
    "\tsw $31,%lo(_patchpad_bss)($1)\n"
    "\tjal EnterCriticalSection\n"
    "\t nop\n"
    "\taddiu $9,$0,87\n"
    "\taddiu $10,$0,176\n"
    "\tjalr $10\n"
    "\t nop\n"
    "\tlw $2,364($2)\n"
    "\taddiu $9,$0,11\n"
    "\taddi $3,$2,2180\n"
    "\tlui $1,%hi(_patchpad_bss+8)\n"
    "\tsw $3,%lo(_patchpad_bss+8)($1)\n"
    "\taddi $3,$2,2196\n"
    "\tlui $1,%hi(_patchpad_bss+12)\n"
    "\tsw $3,%lo(_patchpad_bss+12)($1)\n"
    ".L_patch_pad_40:\n"
    "\tsw $0,1428($2)\n"
    "\taddiu $2,$2,4\n"
    "\taddiu $9,$9,-1\n"
    "\tbne $9,$0,.L_patch_pad_40\n"
    "\t nop\n"
    "\tjal FlushCache\n"
    "\t nop\n"
    "\tlui $31,%hi(_patchpad_bss)\n"
    "\tlw $31,%lo(_patchpad_bss)($31)\n"
    "\tnop\n"
    "\tjr $31\n"
    "\t nop\n");
