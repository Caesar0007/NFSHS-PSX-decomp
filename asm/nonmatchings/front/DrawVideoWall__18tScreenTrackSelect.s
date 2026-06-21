.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawVideoWall__18tScreenTrackSelect, 0x110

glabel DrawVideoWall__18tScreenTrackSelect
    /* 326FC 80041EFC A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 32700 80041F00 4C00B1AF */  sw         $s1, 0x4C($sp)
    /* 32704 80041F04 21888000 */  addu       $s1, $a0, $zero
    /* 32708 80041F08 1180043C */  lui        $a0, %hi(trackManager)
    /* 3270C 80041F0C 1180033C */  lui        $v1, %hi(frontEnd)
    /* 32710 80041F10 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 32714 80041F14 5400BFAF */  sw         $ra, 0x54($sp)
    /* 32718 80041F18 5000B2AF */  sw         $s2, 0x50($sp)
    /* 3271C 80041F1C 4800B0AF */  sw         $s0, 0x48($sp)
    /* 32720 80041F20 46006290 */  lbu        $v0, 0x46($v1)
    /* 32724 80041F24 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 32728 80041F28 21104300 */  addu       $v0, $v0, $v1
    /* 3272C 80041F2C 23004590 */  lbu        $a1, 0x23($v0)
    /* 32730 80041F30 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 32734 80041F34 1800A627 */   addiu     $a2, $sp, 0x18
    /* 32738 80041F38 DE010524 */  addiu      $a1, $zero, 0x1DE
    /* 3273C 80041F3C 21000624 */  addiu      $a2, $zero, 0x21
    /* 32740 80041F40 01000724 */  addiu      $a3, $zero, 0x1
    /* 32744 80041F44 4200A493 */  lbu        $a0, 0x42($sp)
    /* 32748 80041F48 0B000224 */  addiu      $v0, $zero, 0xB
    /* 3274C 80041F4C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 32750 80041F50 1400A2AF */  sw         $v0, 0x14($sp)
    /* 32754 80041F54 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 32758 80041F58 43008424 */   addiu     $a0, $a0, 0x43
    /* 3275C 80041F5C 21202002 */  addu       $a0, $s1, $zero
    /* 32760 80041F60 21280000 */  addu       $a1, $zero, $zero
    /* 32764 80041F64 96000224 */  addiu      $v0, $zero, 0x96
    /* 32768 80041F68 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3276C 80041F6C 0000278E */  lw         $a3, 0x0($s1)
    /* 32770 80041F70 3297000C */  jal        DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
    /* 32774 80041F74 1C000624 */   addiu     $a2, $zero, 0x1C
    /* 32778 80041F78 21200000 */  addu       $a0, $zero, $zero
    /* 3277C 80041F7C 40010524 */  addiu      $a1, $zero, 0x140
    /* 32780 80041F80 1E000624 */  addiu      $a2, $zero, 0x1E
    /* 32784 80041F84 A0000724 */  addiu      $a3, $zero, 0xA0
    /* 32788 80041F88 0A000224 */  addiu      $v0, $zero, 0xA
    /* 3278C 80041F8C 01001224 */  addiu      $s2, $zero, 0x1
    /* 32790 80041F90 1000A2AF */  sw         $v0, 0x10($sp)
    /* 32794 80041F94 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 32798 80041F98 1400B2AF */   sw        $s2, 0x14($sp)
    /* 3279C 80041F9C B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 327A0 80041FA0 21200000 */   addu      $a0, $zero, $zero
    /* 327A4 80041FA4 3A002296 */  lhu        $v0, 0x3A($s1)
    /* 327A8 80041FA8 00000000 */  nop
    /* 327AC 80041FAC 24105200 */  and        $v0, $v0, $s2
    /* 327B0 80041FB0 0C004010 */  beqz       $v0, .L80041FE4
    /* 327B4 80041FB4 60023026 */   addiu     $s0, $s1, 0x260
    /* 327B8 80041FB8 9802228E */  lw         $v0, 0x298($s1)
    /* 327BC 80041FBC 00000000 */  nop
    /* 327C0 80041FC0 08004014 */  bnez       $v0, .L80041FE4
    /* 327C4 80041FC4 00000000 */   nop
    /* 327C8 80041FC8 1B00A593 */  lbu        $a1, 0x1B($sp)
    /* 327CC 80041FCC 75DA000C */  jal        SetAvailable__10tVideoWalls
    /* 327D0 80041FD0 21200002 */   addu      $a0, $s0, $zero
    /* 327D4 80041FD4 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 327D8 80041FD8 21200002 */   addu      $a0, $s0, $zero
    /* 327DC 80041FDC 980232AE */  sw         $s2, 0x298($s1)
    /* 327E0 80041FE0 60023026 */  addiu      $s0, $s1, 0x260
  .L80041FE4:
    /* 327E4 80041FE4 79DA000C */  jal        UpdateTransition__10tVideoWall
    /* 327E8 80041FE8 21200002 */   addu      $a0, $s0, $zero
    /* 327EC 80041FEC EDDA000C */  jal        Draw__10tVideoWall
    /* 327F0 80041FF0 21200002 */   addu      $a0, $s0, $zero
    /* 327F4 80041FF4 5400BF8F */  lw         $ra, 0x54($sp)
    /* 327F8 80041FF8 5000B28F */  lw         $s2, 0x50($sp)
    /* 327FC 80041FFC 4C00B18F */  lw         $s1, 0x4C($sp)
    /* 32800 80042000 4800B08F */  lw         $s0, 0x48($sp)
    /* 32804 80042004 0800E003 */  jr         $ra
    /* 32808 80042008 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel DrawVideoWall__18tScreenTrackSelect
