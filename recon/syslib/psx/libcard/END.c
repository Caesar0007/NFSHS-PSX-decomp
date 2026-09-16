/* syslib/psx/libcard/END.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcard.lib(END.OBJ): _ExitCard -- the libcard exit handler.  Part of the hand-assembled
 *   CARD.S unit (no C preimage): it saves $ra into a fixed scratch word (D_80148AD4) instead of the
 *   stack, INLINES the BIOS B0:0x56 table fetch (addiu $t1,0x56; addiu $t2,0xB0; jalr $t2), then
 *   restores the 3 overlaid words of the card-handler (loading zeros from the in-object D_8010CC30..
 *   D_8010CC3C blob into *(v0+0x70)), flushes the cache, and returns.  Because it cross-references its
 *   own object's data blob by symbol and pokes BIOS table entries, it is reproduced verbatim as a
 *   file-scope __asm__ (genuine hand-assembly; RULE 7 BIOS-stub form).  Numeric regs only (aspsx). */

/* Canonical PsyQ 4.3 END.obj has one 16-byte .bss section.  Its four text relocations name the
 * section base directly; the member has no BSS XDEF or retained local spelling.  Therefore the
 * scratch word and its 12-byte tail are one private owner section.  `D_80148AD4` is only the
 * retail-address oracle label used by this reconstruction.  The separate 32-byte interval after
 * END.obj (0x80148AE4..0x80148B04) remains outside this evidence and is not claimed here. */
__asm__("\t.section\t.bss\n\t.align\t2\n"
        "D_80148AD4:\n\t.space\t16\n\t.text");

#if defined(__mips__)
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto bne/jal delay nop) */
    "\t.set noreorder\n"    /* space form: passes THROUGH maspsx to gnu-as (keeps as from reordering) */
    "\t.globl _ExitCard\n"
    "_ExitCard:\n"
    "\tlui   $1, %hi(D_80148AD4)\n"            /* @0x8010CBC0  save ra -> scratch word */
    "\tsw    $31, %lo(D_80148AD4)($1)\n"       /* @0x8010CBC4                          */
    "\tjal   EnterCriticalSection\n"            /* @0x8010CBC8                          */
    "\t nop\n"                                   /* @0x8010CBCC  [delay]                 */
    "\taddiu $9, $0, 0x56\n"                /* @0x8010CBD0  BIOS call index 0x56    */
    "\taddiu $10, $0, 0xB0\n"                /* @0x8010CBD4  BIOS table base B0      */
    "\tjalr  $10\n"                             /* @0x8010CBD8  fetch table-6 handler   */
    "\t nop\n"                                   /* @0x8010CBDC  [delay]                 */
    "\tlw    $2, 24($2)\n"                    /* @0x8010CBE0  evt = *(v0+0x18)        */
    "\tlui   $10, %hi(D_8010CC30)\n"            /* @0x8010CBE4  src = zero blob         */
    "\taddiu $10, $10, %lo(D_8010CC30)\n"       /* @0x8010CBE8                          */
    "\tlui   $9, %hi(D_8010CC3C)\n"            /* @0x8010CBEC  end = blob+0xC          */
    "\taddiu $9, $9, %lo(D_8010CC3C)\n"       /* @0x8010CBF0                          */
    ".L_ExitCard_loop:\n"
    "\tlw    $3, 0($10)\n"                     /* @0x8010CBF4                          */
    "\tnop\n"                                    /* @0x8010CBF8  [load delay]            */
    "\tsw    $3, 112($2)\n"                   /* @0x8010CBFC  *(evt+0x70) = 0         */
    "\taddiu $10, $10, 4\n"                     /* @0x8010CC00                          */
    "\tbne   $10, $9, .L_ExitCard_loop\n"      /* @0x8010CC04                          */
    "\t addiu $2, $2, 4\n"                    /* @0x8010CC08  [delay] evt += 4        */
    "\tjal   FlushCache\n"                       /* @0x8010CC0C                          */
    "\t nop\n"                                   /* @0x8010CC10  [delay]                 */
    "\tjal   ExitCriticalSection\n"             /* @0x8010CC14                          */
    "\t nop\n"                                   /* @0x8010CC18  [delay]                 */
    "\tlui   $31, %hi(D_80148AD4)\n"            /* @0x8010CC1C  restore ra from scratch */
    "\tlw    $31, %lo(D_80148AD4)($31)\n"       /* @0x8010CC20                          */
    "\tnop\n"                                    /* @0x8010CC24  [load delay]            */
    "\tjr    $31\n"                             /* @0x8010CC28                          */
    "\t nop\n"                                   /* @0x8010CC2C  [delay]                 */

    /* The 4 zero words the loop above reads.  They live in THIS object, immediately after
     * _ExitCard's `endlabel`, and splat exported each alternate label as a GLOBAL symbol
     * (asm/nonmatchings/main/_ExitCard.s tail) -- so `D_8010CC30` and `D_8010CC3C` are rows in
     * the objdiff/progress list in their own right.  The recon referenced them by %hi/%lo but
     * left them UNDEFINED (`nm` showed both as *UND*), which is why both rows read 0% while
     * _ExitCard itself was byte-exact (W52-A9).  Defining them here also makes the object
     * self-contained: the loop's src pointer and end sentinel now resolve in-object exactly as
     * they did in CARD.S.  D_8010CC3C is the loop's END sentinel, i.e. D_8010CC30 + 0xC, so the
     * copied payload is the 3 words at D_8010CC30. */
    "\t.globl D_8010CC30\n"
    "D_8010CC30:\n"
    "\t.word 0\n"                                /* @0x8010CC30                          */
    "\t.word 0\n"                                /* @0x8010CC34                          */
    "\t.word 0\n"                                /* @0x8010CC38                          */
    "\t.globl D_8010CC3C\n"
    "D_8010CC3C:\n"
    "\t.word 0\n"                                /* @0x8010CC3C  loop end sentinel       */
    "\t.set at\n");

/* NOTE: the 28 instructions above are byte-identical to the oracle (asm/nonmatchings/main/
 * _ExitCard.s).  The oracle .s additionally lists the 3-word zero blob D_8010CC30..D_8010CC3C
 * (the values _ExitCard loads and stores into *(evt+0x70)) that physically follows the function
 * in .text; it is materialised in the run-tree's data section (the loads here are %hi/%lo
 * relocations -- the verifier is reloc-lenient), so verify_asm reports those trailing data words
 * as residual lines even though the FUNCTION body matches exactly. */
#endif
