.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdSync, 0x20

glabel CdSync
    /* E804C 800F784C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E8050 800F7850 1000BFAF */  sw         $ra, 0x10($sp)
    /* E8054 800F7854 771D040C */  jal        CD_sync
    /* E8058 800F7858 00000000 */   nop
    /* E805C 800F785C 1000BF8F */  lw         $ra, 0x10($sp)
    /* E8060 800F7860 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E8064 800F7864 0800E003 */  jr         $ra
    /* E8068 800F7868 00000000 */   nop
endlabel CdSync
