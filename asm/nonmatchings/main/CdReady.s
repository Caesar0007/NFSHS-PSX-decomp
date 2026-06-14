.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdReady, 0x20

glabel CdReady
    /* E806C 800F786C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E8070 800F7870 1000BFAF */  sw         $ra, 0x10($sp)
    /* E8074 800F7874 171E040C */  jal        CD_ready
    /* E8078 800F7878 00000000 */   nop
    /* E807C 800F787C 1000BF8F */  lw         $ra, 0x10($sp)
    /* E8080 800F7880 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E8084 800F7884 0800E003 */  jr         $ra
    /* E8088 800F7888 00000000 */   nop
endlabel CdReady
