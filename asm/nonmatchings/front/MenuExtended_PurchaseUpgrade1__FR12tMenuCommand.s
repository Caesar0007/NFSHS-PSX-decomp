.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_PurchaseUpgrade1__FR12tMenuCommand, 0x20

glabel MenuExtended_PurchaseUpgrade1__FR12tMenuCommand
    /* 1DF8C 8002D78C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1DF90 8002D790 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1DF94 8002D794 93B5000C */  jal        MenuExtended_PurchaseUpgrade__Fi
    /* 1DF98 8002D798 01000424 */   addiu     $a0, $zero, 0x1
    /* 1DF9C 8002D79C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1DFA0 8002D7A0 00000000 */  nop
    /* 1DFA4 8002D7A4 0800E003 */  jr         $ra
    /* 1DFA8 8002D7A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_PurchaseUpgrade1__FR12tMenuCommand
