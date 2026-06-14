.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdDataSync, 0x20

glabel CdDataSync
    /* E84D4 800F7CD4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E84D8 800F7CD8 1000BFAF */  sw         $ra, 0x10($sp)
    /* E84DC 800F7CDC C820040C */  jal        CD_datasync
    /* E84E0 800F7CE0 00000000 */   nop
    /* E84E4 800F7CE4 1000BF8F */  lw         $ra, 0x10($sp)
    /* E84E8 800F7CE8 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E84EC 800F7CEC 0800E003 */  jr         $ra
    /* E84F0 800F7CF0 00000000 */   nop
endlabel CdDataSync
