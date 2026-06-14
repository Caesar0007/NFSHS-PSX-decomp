.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdFlush, 0x20

glabel CdFlush
    /* E8018 800F7818 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E801C 800F781C 1000BFAF */  sw         $ra, 0x10($sp)
    /* E8020 800F7820 CC1F040C */  jal        CD_flush
    /* E8024 800F7824 00000000 */   nop
    /* E8028 800F7828 1000BF8F */  lw         $ra, 0x10($sp)
    /* E802C 800F782C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E8030 800F7830 0800E003 */  jr         $ra
    /* E8034 800F7834 00000000 */   nop
endlabel CdFlush
