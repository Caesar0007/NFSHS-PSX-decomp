.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdGetSector2, 0x20

glabel CdGetSector2
    /* E8490 800F7C90 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E8494 800F7C94 1000BFAF */  sw         $ra, 0x10($sp)
    /* E8498 800F7C98 6221040C */  jal        CD_getsector2
    /* E849C 800F7C9C 00000000 */   nop
    /* E84A0 800F7CA0 1000BF8F */  lw         $ra, 0x10($sp)
    /* E84A4 800F7CA4 0100422C */  sltiu      $v0, $v0, 0x1
    /* E84A8 800F7CA8 0800E003 */  jr         $ra
    /* E84AC 800F7CAC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CdGetSector2
