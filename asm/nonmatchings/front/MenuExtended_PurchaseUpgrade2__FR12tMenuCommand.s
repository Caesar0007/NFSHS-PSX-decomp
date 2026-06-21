.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_PurchaseUpgrade2__FR12tMenuCommand, 0x20

glabel MenuExtended_PurchaseUpgrade2__FR12tMenuCommand
    /* 1DFAC 8002D7AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1DFB0 8002D7B0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1DFB4 8002D7B4 93B5000C */  jal        MenuExtended_PurchaseUpgrade__Fi
    /* 1DFB8 8002D7B8 02000424 */   addiu     $a0, $zero, 0x2
    /* 1DFBC 8002D7BC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1DFC0 8002D7C0 00000000 */  nop
    /* 1DFC4 8002D7C4 0800E003 */  jr         $ra
    /* 1DFC8 8002D7C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_PurchaseUpgrade2__FR12tMenuCommand
