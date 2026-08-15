/* syslib/psx/libcard/A74.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(A74.OBJ): InitCARD2 -- PsyQ libcard's hand-written InitCard2.  This is NOT a
 *   plain BIOS thunk: the object is part of the hand-assembled CARD.S unit.  It begins with the
 *   BIOS B0:0x4A (InitCard) tail-call (addiu $t2,0xB0; jr $t2; addiu $t1,0x4A) and is FOLLOWED by a
 *   small tail (SR/cop-flag OR-in 0x12 into the half-word at +0xA, then a 0x28-iteration spin-delay,
 *   then jr $ra).  That tail is unreachable through the BIOS tail-call but is REAL data: it is the
 *   first 28 words `_copy_memcard_patch` copies into kernel RAM (it reads from `InitCARD2 + 0x10`).
 *   So the whole blob must be emitted verbatim -> genuine hand-assembly, reproduced as a file-scope
 *   __asm__ (same BIOS-stub form as bios_thunk.h, allowed by RULE 7).  Numeric regs only (aspsx).  */

#if defined(__mips__)
__asm__(
    "\t.set push\n\t.set noreorder\n\t.set noat\n"
    "\t.globl InitCARD2\n"
    "InitCARD2:\n"
    "\taddiu $t2, $zero, 0xB0\n"          /* @0x8010C9C0  BIOS table B0 base            */
    "\tjr    $t2\n"                        /* @0x8010C9C4  tail-call into BIOS InitCard   */
    "\t addiu $t1, $zero, 0x4A\n"         /* @0x8010C9C8  [delay] call index 0x4A        */
    "\tnop\n"                              /* @0x8010C9CC                                  */
    "\tlhu   $t7, 10($v1)\n"              /* @0x8010C9D0  tail: read flag half-word       */
    "\tlui   $t0, 0\n"                     /* @0x8010C9D4                                  */
    "\tor    $t8, $t7, $v0\n"             /* @0x8010C9D8                                  */
    "\tori   $t9, $t8, 0x12\n"            /* @0x8010C9DC  set bits 0x12                    */
    "\tsh    $t9, 10($v1)\n"              /* @0x8010C9E0  write back                       */
    "\taddiu $t0, $zero, 0x28\n"          /* @0x8010C9E4  spin counter = 0x28             */
    ".LInitCARD2_spin:\n"
    "\taddiu $t0, $t0, -1\n"              /* @0x8010C9E8                                  */
    "\tbnez  $t0, .LInitCARD2_spin\n"     /* @0x8010C9EC  loop                            */
    "\t nop\n"                             /* @0x8010C9F0  [delay]                          */
    "\tjr    $ra\n"                        /* @0x8010C9F4                                  */
    "\t nop\n"                             /* @0x8010C9F8  [delay]                          */

    /* ---------------------------------------------------------------------------------------
     * @0x8010C9FC : func_8010C9FC -- the REMAINING 17 words of the same 28-word card-IRQ handler
     * blob (the blob runs [InitCARD2+0x10 .. func_8010CA40), i.e. 0x8010C9D0..0x8010CA40, and
     * InitCARD2's own symbol ends at 0x8010C9FC).  splat gave the overhang its own `func_` label,
     * so it is a separate SYMBOL that objdiff pairs -- but the recon only emitted InitCARD2, so
     * the row read 0% / verify_asm `NOT IN OBJECT` (W52-A9).  It is code-as-data class 2 per
     * methodology 3.9b: never `jal`'d, only its ADDRESS is used (by _copy_memcard_patch's word
     * loop), so it must be emitted VERBATIM under its project label.
     *
     * What it does once relocated to kernel RAM 0xDF80: poll the card-IRQ status word at
     * SIO+0x1074, bail to the plain `jr $ra` if bit 7 is clear, else spin on SIO+0x1044 bit 7
     * and chain to the previous handler whose pointer sits at 0xDFFC.
     * --------------------------------------------------------------------------------------- */
    "\t.globl func_8010C9FC\n"
    "func_8010C9FC:\n"
    "\tlw    $v0, 4212($v1)\n"             /* @0x8010C9FC  lw $v0,0x1074($v1)              */
    "\tnop\n"                              /* @0x8010CA00  [load delay]                     */
    "\tandi  $v0, $v0, 0x80\n"             /* @0x8010CA04                                  */
    "\tbeqz  $v0, .Lcard_irq_ret\n"        /* @0x8010CA08  -> 0x8010CA38                   */
    "\t nop\n"                             /* @0x8010CA0C  [delay]                          */
    ".Lcard_irq_spin:\n"
    "\tlw    $v0, 4164($v1)\n"             /* @0x8010CA10  lw $v0,0x1044($v1)              */
    "\tnop\n"                              /* @0x8010CA14  [load delay]                     */
    "\tandi  $v0, $v0, 0x80\n"             /* @0x8010CA18                                  */
    "\tbnez  $v0, .Lcard_irq_spin\n"       /* @0x8010CA1C                                  */
    "\t nop\n"                             /* @0x8010CA20  [delay]                          */
    "\tlui   $v0, 1\n"                     /* @0x8010CA24  0x10000                          */
    "\tlw    $v0, -8196($v0)\n"            /* @0x8010CA28  *(0xDFFC) = chained handler      */
    "\tnop\n"                              /* @0x8010CA2C  [load delay]                     */
    "\tjr    $v0\n"                        /* @0x8010CA30  chain                            */
    "\t nop\n"                             /* @0x8010CA34  [delay]                          */
    ".Lcard_irq_ret:\n"
    "\tjr    $ra\n"                        /* @0x8010CA38                                  */
    "\t nop\n"                             /* @0x8010CA3C  [delay]                          */
    "\t.set pop\n");
#endif
