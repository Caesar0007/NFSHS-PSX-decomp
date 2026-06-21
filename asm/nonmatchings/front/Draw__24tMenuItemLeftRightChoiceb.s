.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__24tMenuItemLeftRightChoiceb, 0xCC

glabel Draw__24tMenuItemLeftRightChoiceb
    /* 1522C 80024A2C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 15230 80024A30 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 15234 80024A34 21888000 */  addu       $s1, $a0, $zero
    /* 15238 80024A38 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 1523C 80024A3C 2800B4AF */  sw         $s4, 0x28($sp)
    /* 15240 80024A40 2400B3AF */  sw         $s3, 0x24($sp)
    /* 15244 80024A44 2000B2AF */  sw         $s2, 0x20($sp)
    /* 15248 80024A48 1800B0AF */  sw         $s0, 0x18($sp)
    /* 1524C 80024A4C 0400248E */  lw         $a0, 0x4($s1)
    /* 15250 80024A50 A4E4020C */  jal        TextSys_WordX__Fi
    /* 15254 80024A54 2198A000 */   addu      $s3, $a1, $zero
    /* 15258 80024A58 0400248E */  lw         $a0, 0x4($s1)
    /* 1525C 80024A5C ACE4020C */  jal        TextSys_WordY__Fi
    /* 15260 80024A60 21804000 */   addu      $s0, $v0, $zero
    /* 15264 80024A64 002C1000 */  sll        $a1, $s0, 16
    /* 15268 80024A68 032C0500 */  sra        $a1, $a1, 16
    /* 1526C 80024A6C 00940200 */  sll        $s2, $v0, 16
    /* 15270 80024A70 03941200 */  sra        $s2, $s2, 16
    /* 15274 80024A74 21304002 */  addu       $a2, $s2, $zero
    /* 15278 80024A78 2B981300 */  sltu       $s3, $zero, $s3
    /* 1527C 80024A7C 21386002 */  addu       $a3, $s3, $zero
    /* 15280 80024A80 04002486 */  lh         $a0, 0x4($s1)
    /* 15284 80024A84 06001424 */  addiu      $s4, $zero, 0x6
    /* 15288 80024A88 0584000C */  jal        FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
    /* 1528C 80024A8C 1000B4AF */   sw        $s4, 0x10($sp)
    /* 15290 80024A90 1C00268E */  lw         $a2, 0x1C($s1)
    /* 15294 80024A94 0580023C */  lui        $v0, %hi(gMenu_SubMenuPlayer)
    /* 15298 80024A98 0C00C38C */  lw         $v1, 0xC($a2)
    /* 1529C 80024A9C C017458C */  lw         $a1, %lo(gMenu_SubMenuPlayer)($v0)
    /* 152A0 80024AA0 18006484 */  lh         $a0, 0x18($v1)
    /* 152A4 80024AA4 1C00628C */  lw         $v0, 0x1C($v1)
    /* 152A8 80024AA8 00000000 */  nop
    /* 152AC 80024AAC 09F84000 */  jalr       $v0
    /* 152B0 80024AB0 2120C400 */   addu      $a0, $a2, $a0
    /* 152B4 80024AB4 00140200 */  sll        $v0, $v0, 16
    /* 152B8 80024AB8 03240200 */  sra        $a0, $v0, 16
    /* 152BC 80024ABC B4001026 */  addiu      $s0, $s0, 0xB4
    /* 152C0 80024AC0 00841000 */  sll        $s0, $s0, 16
    /* 152C4 80024AC4 032C1000 */  sra        $a1, $s0, 16
    /* 152C8 80024AC8 21304002 */  addu       $a2, $s2, $zero
    /* 152CC 80024ACC 21386002 */  addu       $a3, $s3, $zero
    /* 152D0 80024AD0 0584000C */  jal        FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
    /* 152D4 80024AD4 1000B4AF */   sw        $s4, 0x10($sp)
    /* 152D8 80024AD8 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 152DC 80024ADC 2800B48F */  lw         $s4, 0x28($sp)
    /* 152E0 80024AE0 2400B38F */  lw         $s3, 0x24($sp)
    /* 152E4 80024AE4 2000B28F */  lw         $s2, 0x20($sp)
    /* 152E8 80024AE8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 152EC 80024AEC 1800B08F */  lw         $s0, 0x18($sp)
    /* 152F0 80024AF0 0800E003 */  jr         $ra
    /* 152F4 80024AF4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Draw__24tMenuItemLeftRightChoiceb
