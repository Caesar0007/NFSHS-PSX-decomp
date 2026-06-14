.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching asyncloadfileat, 0x20

glabel asyncloadfileat
    /* E1C3C 800F143C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E1C40 800F1440 1000BFAF */  sw         $ra, 0x10($sp)
    /* E1C44 800F1444 E2C4030C */  jal        asyncloadfileatcallback
    /* E1C48 800F1448 21300000 */   addu      $a2, $zero, $zero
    /* E1C4C 800F144C 1000BF8F */  lw         $ra, 0x10($sp)
    /* E1C50 800F1450 00000000 */  nop
    /* E1C54 800F1454 0800E003 */  jr         $ra
    /* E1C58 800F1458 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel asyncloadfileat
