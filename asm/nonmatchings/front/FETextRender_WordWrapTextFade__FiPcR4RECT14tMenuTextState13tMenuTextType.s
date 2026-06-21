.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType, 0xA8

glabel FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
    /* 11F40 80021740 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 11F44 80021744 21408000 */  addu       $t0, $a0, $zero
    /* 11F48 80021748 2000B2AF */  sw         $s2, 0x20($sp)
    /* 11F4C 8002174C 2190A000 */  addu       $s2, $a1, $zero
    /* 11F50 80021750 2400B3AF */  sw         $s3, 0x24($sp)
    /* 11F54 80021754 2198C000 */  addu       $s3, $a2, $zero
    /* 11F58 80021758 0580033C */  lui        $v1, %hi(kRGBVals)
    /* 11F5C 8002175C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 11F60 80021760 0580113C */  lui        $s1, %hi(textDefinitions)
    /* 11F64 80021764 4000A28F */  lw         $v0, 0x40($sp)
    /* 11F68 80021768 B8153126 */  addiu      $s1, $s1, %lo(textDefinitions)
    /* 11F6C 8002176C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 11F70 80021770 1800B0AF */  sw         $s0, 0x18($sp)
    /* 11F74 80021774 40800200 */  sll        $s0, $v0, 1
    /* 11F78 80021778 21800202 */  addu       $s0, $s0, $v0
    /* 11F7C 8002177C 40801000 */  sll        $s0, $s0, 1
    /* 11F80 80021780 03000226 */  addiu      $v0, $s0, 0x3
    /* 11F84 80021784 2138E200 */  addu       $a3, $a3, $v0
    /* 11F88 80021788 2138F100 */  addu       $a3, $a3, $s1
    /* 11F8C 8002178C 0000E290 */  lbu        $v0, 0x0($a3)
    /* 11F90 80021790 C8166324 */  addiu      $v1, $v1, %lo(kRGBVals)
    /* 11F94 80021794 80100200 */  sll        $v0, $v0, 2
    /* 11F98 80021798 21104300 */  addu       $v0, $v0, $v1
    /* 11F9C 8002179C 0000448C */  lw         $a0, 0x0($v0)
    /* 11FA0 800217A0 222E010C */  jal        CalcFadeVal__Fii
    /* 11FA4 800217A4 21280001 */   addu      $a1, $t0, $zero
    /* 11FA8 800217A8 21204002 */  addu       $a0, $s2, $zero
    /* 11FAC 800217AC 21801102 */  addu       $s0, $s0, $s1
    /* 11FB0 800217B0 21286002 */  addu       $a1, $s3, $zero
    /* 11FB4 800217B4 01000792 */  lbu        $a3, 0x1($s0)
    /* 11FB8 800217B8 00000392 */  lbu        $v1, 0x0($s0)
    /* 11FBC 800217BC 21304000 */  addu       $a2, $v0, $zero
    /* 11FC0 800217C0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 11FC4 800217C4 A984000C */  jal        FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
    /* 11FC8 800217C8 1000A3AF */   sw        $v1, 0x10($sp)
    /* 11FCC 800217CC 2800BF8F */  lw         $ra, 0x28($sp)
    /* 11FD0 800217D0 2400B38F */  lw         $s3, 0x24($sp)
    /* 11FD4 800217D4 2000B28F */  lw         $s2, 0x20($sp)
    /* 11FD8 800217D8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 11FDC 800217DC 1800B08F */  lw         $s0, 0x18($sp)
    /* 11FE0 800217E0 0800E003 */  jr         $ra
    /* 11FE4 800217E4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
