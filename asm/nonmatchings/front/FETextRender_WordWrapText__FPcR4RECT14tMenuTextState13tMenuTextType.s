.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType, 0x3C

glabel FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
    /* 11FE8 800217E8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 11FEC 800217EC 21108000 */  addu       $v0, $a0, $zero
    /* 11FF0 800217F0 2118A000 */  addu       $v1, $a1, $zero
    /* 11FF4 800217F4 2140C000 */  addu       $t0, $a2, $zero
    /* 11FF8 800217F8 21200000 */  addu       $a0, $zero, $zero
    /* 11FFC 800217FC 21284000 */  addu       $a1, $v0, $zero
    /* 12000 80021800 21306000 */  addu       $a2, $v1, $zero
    /* 12004 80021804 1000A7AF */  sw         $a3, 0x10($sp)
    /* 12008 80021808 1800BFAF */  sw         $ra, 0x18($sp)
    /* 1200C 8002180C D085000C */  jal        FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
    /* 12010 80021810 21380001 */   addu      $a3, $t0, $zero
    /* 12014 80021814 1800BF8F */  lw         $ra, 0x18($sp)
    /* 12018 80021818 00000000 */  nop
    /* 1201C 8002181C 0800E003 */  jr         $ra
    /* 12020 80021820 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
