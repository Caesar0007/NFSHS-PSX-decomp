.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CalcHumanTopSpeed__FP8Car_tObj, 0x20

glabel AISpeeds_CalcHumanTopSpeed__FP8Car_tObj
    /* 5FBFC 8006F3FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5FC00 8006F400 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5FC04 8006F404 07BD010C */  jal        AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj
    /* 5FC08 8006F408 00000000 */   nop
    /* 5FC0C 8006F40C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5FC10 8006F410 00000000 */  nop
    /* 5FC14 8006F414 0800E003 */  jr         $ra
    /* 5FC18 8006F418 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AISpeeds_CalcHumanTopSpeed__FP8Car_tObj
