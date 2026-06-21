.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_PurchaseUpgrade3__FR12tMenuCommand, 0x20

glabel MenuExtended_PurchaseUpgrade3__FR12tMenuCommand
    /* 1DFCC 8002D7CC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1DFD0 8002D7D0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1DFD4 8002D7D4 93B5000C */  jal        MenuExtended_PurchaseUpgrade__Fi
    /* 1DFD8 8002D7D8 21200000 */   addu      $a0, $zero, $zero
    /* 1DFDC 8002D7DC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1DFE0 8002D7E0 00000000 */  nop
    /* 1DFE4 8002D7E4 0800E003 */  jr         $ra
    /* 1DFE8 8002D7E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_PurchaseUpgrade3__FR12tMenuCommand
