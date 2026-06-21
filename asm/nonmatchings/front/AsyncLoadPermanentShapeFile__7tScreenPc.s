.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AsyncLoadPermanentShapeFile__7tScreenPc, 0x20

glabel AsyncLoadPermanentShapeFile__7tScreenPc
    /* 16598 80025D98 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1659C 80025D9C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 165A0 80025DA0 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 165A4 80025DA4 21308000 */   addu      $a2, $a0, $zero
    /* 165A8 80025DA8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 165AC 80025DAC 00000000 */  nop
    /* 165B0 80025DB0 0800E003 */  jr         $ra
    /* 165B4 80025DB4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AsyncLoadPermanentShapeFile__7tScreenPc
