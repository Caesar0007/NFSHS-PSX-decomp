.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching asyncloadfile, 0x20

glabel asyncloadfile
    /* E1B68 800F1368 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1B6C 800F136C 1000BFAF */  sw         $ra, 0x10($sp)
    /* E1B70 800F1370 ACC4030C */  jal        asyncloadfilecallback
    /* E1B74 800F1374 21300000 */   addu      $a2, $zero, $zero
    /* E1B78 800F1378 1000BF8F */  lw         $ra, 0x10($sp)
    /* E1B7C 800F137C 00000000 */  nop
    /* E1B80 800F1380 0800E003 */  jr         $ra
    /* E1B84 800F1384 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel asyncloadfile
