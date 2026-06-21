.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType, 0xA0

glabel FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
    /* 11814 80021014 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 11818 80021018 1800B0AF */  sw         $s0, 0x18($sp)
    /* 1181C 8002101C 21808000 */  addu       $s0, $a0, $zero
    /* 11820 80021020 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 11824 80021024 2188A000 */  addu       $s1, $a1, $zero
    /* 11828 80021028 2000B2AF */  sw         $s2, 0x20($sp)
    /* 1182C 8002102C 2190C000 */  addu       $s2, $a2, $zero
    /* 11830 80021030 2400B3AF */  sw         $s3, 0x24($sp)
    /* 11834 80021034 2198E000 */  addu       $s3, $a3, $zero
    /* 11838 80021038 4000A58F */  lw         $a1, 0x40($sp)
    /* 1183C 8002103C 0E000224 */  addiu      $v0, $zero, 0xE
    /* 11840 80021040 0500A214 */  bne        $a1, $v0, .L80021058
    /* 11844 80021044 2800BFAF */   sw        $ra, 0x28($sp)
    /* 11848 80021048 00241000 */  sll        $a0, $s0, 16
    /* 1184C 8002104C 9CE4020C */  jal        TextSys_WordFlags__Fi
    /* 11850 80021050 03240400 */   sra       $a0, $a0, 16
    /* 11854 80021054 21284000 */  addu       $a1, $v0, $zero
  .L80021058:
    /* 11858 80021058 00241000 */  sll        $a0, $s0, 16
    /* 1185C 8002105C 0580033C */  lui        $v1, %hi(textDefinitions)
    /* 11860 80021060 B8156324 */  addiu      $v1, $v1, %lo(textDefinitions)
    /* 11864 80021064 40100500 */  sll        $v0, $a1, 1
    /* 11868 80021068 21104500 */  addu       $v0, $v0, $a1
    /* 1186C 8002106C 40100200 */  sll        $v0, $v0, 1
    /* 11870 80021070 21104300 */  addu       $v0, $v0, $v1
    /* 11874 80021074 01004790 */  lbu        $a3, 0x1($v0)
    /* 11878 80021078 03240400 */  sra        $a0, $a0, 16
    /* 1187C 8002107C 1400A5AF */  sw         $a1, 0x14($sp)
    /* 11880 80021080 002C1100 */  sll        $a1, $s1, 16
    /* 11884 80021084 00341200 */  sll        $a2, $s2, 16
    /* 11888 80021088 032C0500 */  sra        $a1, $a1, 16
    /* 1188C 8002108C 03340600 */  sra        $a2, $a2, 16
    /* 11890 80021090 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 11894 80021094 1000B3AF */   sw        $s3, 0x10($sp)
    /* 11898 80021098 2800BF8F */  lw         $ra, 0x28($sp)
    /* 1189C 8002109C 2400B38F */  lw         $s3, 0x24($sp)
    /* 118A0 800210A0 2000B28F */  lw         $s2, 0x20($sp)
    /* 118A4 800210A4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 118A8 800210A8 1800B08F */  lw         $s0, 0x18($sp)
    /* 118AC 800210AC 0800E003 */  jr         $ra
    /* 118B0 800210B0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType
