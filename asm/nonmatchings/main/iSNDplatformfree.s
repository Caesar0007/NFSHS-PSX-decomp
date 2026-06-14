.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformfree, 0x20

glabel iSNDplatformfree
    /* EED94 800FE594 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EED98 800FE598 1000BFAF */  sw         $ra, 0x10($sp)
    /* EED9C 800FE59C F229040C */  jal        iSNDpsxfree
    /* EEDA0 800FE5A0 00000000 */   nop
    /* EEDA4 800FE5A4 1000BF8F */  lw         $ra, 0x10($sp)
    /* EEDA8 800FE5A8 00000000 */  nop
    /* EEDAC 800FE5AC 0800E003 */  jr         $ra
    /* EEDB0 800FE5B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDplatformfree
