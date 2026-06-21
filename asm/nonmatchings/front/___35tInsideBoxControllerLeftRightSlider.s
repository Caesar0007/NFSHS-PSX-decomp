.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___35tInsideBoxControllerLeftRightSlider, 0x20

glabel ___35tInsideBoxControllerLeftRightSlider
    /* 113B8 80020BB8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 113BC 80020BBC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 113C0 80020BC0 B27C000C */  jal        ___25tInsideBoxLeftRightSlider
    /* 113C4 80020BC4 00000000 */   nop
    /* 113C8 80020BC8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 113CC 80020BCC 00000000 */  nop
    /* 113D0 80020BD0 0800E003 */  jr         $ra
    /* 113D4 80020BD4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___35tInsideBoxControllerLeftRightSlider
