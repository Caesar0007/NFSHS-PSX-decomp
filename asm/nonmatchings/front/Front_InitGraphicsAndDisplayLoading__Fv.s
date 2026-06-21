.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_InitGraphicsAndDisplayLoading__Fv, 0x20

glabel Front_InitGraphicsAndDisplayLoading__Fv
    /* 182D4 80027AD4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 182D8 80027AD8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 182DC 80027ADC 979E000C */  jal        Front_InitGraphics__Fv
    /* 182E0 80027AE0 00000000 */   nop
    /* 182E4 80027AE4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 182E8 80027AE8 00000000 */  nop
    /* 182EC 80027AEC 0800E003 */  jr         $ra
    /* 182F0 80027AF0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Front_InitGraphicsAndDisplayLoading__Fv
