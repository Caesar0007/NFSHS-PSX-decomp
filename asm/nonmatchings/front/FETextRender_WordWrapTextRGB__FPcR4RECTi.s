.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_WordWrapTextRGB__FPcR4RECTi, 0x28

glabel FETextRender_WordWrapTextRGB__FPcR4RECTi
    /* 11F18 80021718 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 11F1C 8002171C 21380000 */  addu       $a3, $zero, $zero
    /* 11F20 80021720 1800BFAF */  sw         $ra, 0x18($sp)
    /* 11F24 80021724 1000A0AF */  sw         $zero, 0x10($sp)
    /* 11F28 80021728 A984000C */  jal        FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
    /* 11F2C 8002172C 1400A0AF */   sw        $zero, 0x14($sp)
    /* 11F30 80021730 1800BF8F */  lw         $ra, 0x18($sp)
    /* 11F34 80021734 00000000 */  nop
    /* 11F38 80021738 0800E003 */  jr         $ra
    /* 11F3C 8002173C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FETextRender_WordWrapTextRGB__FPcR4RECTi
