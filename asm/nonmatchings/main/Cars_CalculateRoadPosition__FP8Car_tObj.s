.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_CalculateRoadPosition__FP8Car_tObj, 0x20

glabel Cars_CalculateRoadPosition__FP8Car_tObj
    /* 7B6C8 8008AEC8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 7B6CC 8008AECC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 7B6D0 8008AED0 158F020C */  jal        Newton_CalculateRoadPosition__FP13BO_tNewtonObj
    /* 7B6D4 8008AED4 00000000 */   nop
    /* 7B6D8 8008AED8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 7B6DC 8008AEDC 00000000 */  nop
    /* 7B6E0 8008AEE0 0800E003 */  jr         $ra
    /* 7B6E4 8008AEE4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cars_CalculateRoadPosition__FP8Car_tObj
