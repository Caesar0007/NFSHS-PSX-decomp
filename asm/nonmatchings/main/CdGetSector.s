.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdGetSector, 0x20

glabel CdGetSector
    /* E8470 800F7C70 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E8474 800F7C74 1000BFAF */  sw         $ra, 0x10($sp)
    /* E8478 800F7C78 2221040C */  jal        CD_getsector
    /* E847C 800F7C7C 00000000 */   nop
    /* E8480 800F7C80 1000BF8F */  lw         $ra, 0x10($sp)
    /* E8484 800F7C84 0100422C */  sltiu      $v0, $v0, 0x1
    /* E8488 800F7C88 0800E003 */  jr         $ra
    /* E848C 800F7C8C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CdGetSector
