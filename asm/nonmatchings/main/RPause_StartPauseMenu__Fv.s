.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RPause_StartPauseMenu__Fv, 0x20

glabel RPause_StartPauseMenu__Fv
    /* CD784 800DCF84 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CD788 800DCF88 1000BFAF */  sw         $ra, 0x10($sp)
    /* CD78C 800DCF8C B0F8020C */  jal        Draw_StartFrameRender__Fv
    /* CD790 800DCF90 00000000 */   nop
    /* CD794 800DCF94 1000BF8F */  lw         $ra, 0x10($sp)
    /* CD798 800DCF98 00000000 */  nop
    /* CD79C 800DCF9C 0800E003 */  jr         $ra
    /* CD7A0 800DCFA0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel RPause_StartPauseMenu__Fv
