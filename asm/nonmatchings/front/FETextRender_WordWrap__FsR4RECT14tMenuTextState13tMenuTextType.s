.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType, 0x3C

glabel FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType
    /* 1208C 8002188C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 12090 80021890 2110A000 */  addu       $v0, $a1, $zero
    /* 12094 80021894 2118C000 */  addu       $v1, $a2, $zero
    /* 12098 80021898 002C0400 */  sll        $a1, $a0, 16
    /* 1209C 8002189C 21200000 */  addu       $a0, $zero, $zero
    /* 120A0 800218A0 032C0500 */  sra        $a1, $a1, 16
    /* 120A4 800218A4 21304000 */  addu       $a2, $v0, $zero
    /* 120A8 800218A8 1000A7AF */  sw         $a3, 0x10($sp)
    /* 120AC 800218AC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 120B0 800218B0 0986000C */  jal        FETextRender_WordWrapFade__FisR4RECT14tMenuTextState13tMenuTextType
    /* 120B4 800218B4 21386000 */   addu      $a3, $v1, $zero
    /* 120B8 800218B8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 120BC 800218BC 00000000 */  nop
    /* 120C0 800218C0 0800E003 */  jr         $ra
    /* 120C4 800218C4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FETextRender_WordWrap__FsR4RECT14tMenuTextState13tMenuTextType
