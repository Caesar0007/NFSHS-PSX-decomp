/* syslib/psx/libcard/END.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(END.OBJ): _ExitCard -- the libcard exit handler.  Part of the hand-assembled
 *   CARD.S unit (no C preimage): it saves $ra into a fixed scratch word (D_80148AD4) instead of the
 *   stack, INLINES the BIOS B0:0x56 table fetch (addiu $t1,0x56; addiu $t2,0xB0; jalr $t2), then
 *   restores the 3 overlaid words of the card-handler (loading zeros from the in-object D_8010CC30..
 *   D_8010CC3C blob into *(v0+0x70)), flushes the cache, and returns.  Because it cross-references its
 *   own object's data blob by symbol and pokes BIOS table entries, it is reproduced verbatim as a
 *   file-scope __asm__ (genuine hand-assembly; RULE 7 BIOS-stub form).  Numeric regs only (aspsx). */

#if defined(__mips__)
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto bne/jal delay nop) */
    "\t.set noreorder\n"    /* space form: passes THROUGH maspsx to gnu-as (keeps as from reordering) */
    "\t.globl _ExitCard\n"
    "_ExitCard:\n"
    "\tlui   $at, %hi(D_80148AD4)\n"            /* @0x8010CBC0  save ra -> scratch word */
    "\tsw    $ra, %lo(D_80148AD4)($at)\n"       /* @0x8010CBC4                          */
    "\tjal   EnterCriticalSection\n"            /* @0x8010CBC8                          */
    "\t nop\n"                                   /* @0x8010CBCC  [delay]                 */
    "\taddiu $t1, $zero, 0x56\n"                /* @0x8010CBD0  BIOS call index 0x56    */
    "\taddiu $t2, $zero, 0xB0\n"                /* @0x8010CBD4  BIOS table base B0      */
    "\tjalr  $t2\n"                             /* @0x8010CBD8  fetch table-6 handler   */
    "\t nop\n"                                   /* @0x8010CBDC  [delay]                 */
    "\tlw    $v0, 24($v0)\n"                    /* @0x8010CBE0  evt = *(v0+0x18)        */
    "\tlui   $t2, %hi(D_8010CC30)\n"            /* @0x8010CBE4  src = zero blob         */
    "\taddiu $t2, $t2, %lo(D_8010CC30)\n"       /* @0x8010CBE8                          */
    "\tlui   $t1, %hi(D_8010CC3C)\n"            /* @0x8010CBEC  end = blob+0xC          */
    "\taddiu $t1, $t1, %lo(D_8010CC3C)\n"       /* @0x8010CBF0                          */
    ".L_ExitCard_loop:\n"
    "\tlw    $v1, 0($t2)\n"                     /* @0x8010CBF4                          */
    "\tnop\n"                                    /* @0x8010CBF8  [load delay]            */
    "\tsw    $v1, 112($v0)\n"                   /* @0x8010CBFC  *(evt+0x70) = 0         */
    "\taddiu $t2, $t2, 4\n"                     /* @0x8010CC00                          */
    "\tbne   $t2, $t1, .L_ExitCard_loop\n"      /* @0x8010CC04                          */
    "\t addiu $v0, $v0, 4\n"                    /* @0x8010CC08  [delay] evt += 4        */
    "\tjal   FlushCache\n"                       /* @0x8010CC0C                          */
    "\t nop\n"                                   /* @0x8010CC10  [delay]                 */
    "\tjal   ExitCriticalSection\n"             /* @0x8010CC14                          */
    "\t nop\n"                                   /* @0x8010CC18  [delay]                 */
    "\tlui   $ra, %hi(D_80148AD4)\n"            /* @0x8010CC1C  restore ra from scratch */
    "\tlw    $ra, %lo(D_80148AD4)($ra)\n"       /* @0x8010CC20                          */
    "\tnop\n"                                    /* @0x8010CC24  [load delay]            */
    "\tjr    $ra\n"                             /* @0x8010CC28                          */
    "\t nop\n"                                   /* @0x8010CC2C  [delay]                 */
    "\t.set at\n");

/* NOTE: the 28 instructions above are byte-identical to the oracle (asm/nonmatchings/main/
 * _ExitCard.s).  The oracle .s additionally lists the 3-word zero blob D_8010CC30..D_8010CC3C
 * (the values _ExitCard loads and stores into *(evt+0x70)) that physically follows the function
 * in .text; it is materialised in the run-tree's data section (the loads here are %hi/%lo
 * relocations -- the verifier is reloc-lenient), so verify_asm reports those trailing data words
 * as residual lines even though the FUNCTION body matches exactly. */
#endif
