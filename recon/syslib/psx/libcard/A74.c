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
    "\t.set pop\n");
#endif
