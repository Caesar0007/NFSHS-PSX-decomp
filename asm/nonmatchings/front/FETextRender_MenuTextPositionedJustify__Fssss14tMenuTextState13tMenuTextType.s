.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType, 0x54

glabel FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 11980 80021180 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 11984 80021184 003C0700 */  sll        $a3, $a3, 16
    /* 11988 80021188 3800A28F */  lw         $v0, 0x38($sp)
    /* 1198C 8002118C 3C00A38F */  lw         $v1, 0x3C($sp)
    /* 11990 80021190 033C0700 */  sra        $a3, $a3, 16
    /* 11994 80021194 1000A7AF */  sw         $a3, 0x10($sp)
    /* 11998 80021198 003C0600 */  sll        $a3, $a2, 16
    /* 1199C 8002119C 033C0700 */  sra        $a3, $a3, 16
    /* 119A0 800211A0 2000BFAF */  sw         $ra, 0x20($sp)
    /* 119A4 800211A4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 119A8 800211A8 00140400 */  sll        $v0, $a0, 16
    /* 119AC 800211AC 1800A3AF */  sw         $v1, 0x18($sp)
    /* 119B0 800211B0 001C0500 */  sll        $v1, $a1, 16
    /* 119B4 800211B4 21200000 */  addu       $a0, $zero, $zero
    /* 119B8 800211B8 032C0200 */  sra        $a1, $v0, 16
    /* 119BC 800211BC 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 119C0 800211C0 03340300 */   sra       $a2, $v1, 16
    /* 119C4 800211C4 2000BF8F */  lw         $ra, 0x20($sp)
    /* 119C8 800211C8 00000000 */  nop
    /* 119CC 800211CC 0800E003 */  jr         $ra
    /* 119D0 800211D0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
