.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi, 0x134

glabel Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi
    /* CFE88 800DF688 1C008014 */  bnez       $a0, .L800DF6FC
    /* CFE8C 800DF68C 21100000 */   addu      $v0, $zero, $zero
    /* CFE90 800DF690 0800E003 */  jr         $ra
    /* CFE94 800DF694 00000000 */   nop
  .L800DF698:
    /* CFE98 800DF698 D415838F */  lw         $v1, %gp_rel(Texture_gP8bitPmx)($gp)
    /* CFE9C 800DF69C 80100900 */  sll        $v0, $t1, 2
  .L800DF6A0:
    /* CFEA0 800DF6A0 21104300 */  addu       $v0, $v0, $v1
    /* CFEA4 800DF6A4 0000438C */  lw         $v1, 0x0($v0)
    /* CFEA8 800DF6A8 01000224 */  addiu      $v0, $zero, 0x1
    /* CFEAC 800DF6AC 03006D88 */  lwl        $t5, 0x3($v1)
    /* CFEB0 800DF6B0 00006D98 */  lwr        $t5, 0x0($v1)
    /* CFEB4 800DF6B4 07006E88 */  lwl        $t6, 0x7($v1)
    /* CFEB8 800DF6B8 04006E98 */  lwr        $t6, 0x4($v1)
    /* CFEBC 800DF6BC 0B006F88 */  lwl        $t7, 0xB($v1)
    /* CFEC0 800DF6C0 08006F98 */  lwr        $t7, 0x8($v1)
    /* CFEC4 800DF6C4 0F007888 */  lwl        $t8, 0xF($v1)
    /* CFEC8 800DF6C8 0C007898 */  lwr        $t8, 0xC($v1)
    /* CFECC 800DF6CC 0300CDA8 */  swl        $t5, 0x3($a2)
    /* CFED0 800DF6D0 0000CDB8 */  swr        $t5, 0x0($a2)
    /* CFED4 800DF6D4 0700CEA8 */  swl        $t6, 0x7($a2)
    /* CFED8 800DF6D8 0400CEB8 */  swr        $t6, 0x4($a2)
    /* CFEDC 800DF6DC 0B00CFA8 */  swl        $t7, 0xB($a2)
    /* CFEE0 800DF6E0 0800CFB8 */  swr        $t7, 0x8($a2)
    /* CFEE4 800DF6E4 0F00D8A8 */  swl        $t8, 0xF($a2)
    /* CFEE8 800DF6E8 0800E003 */  jr         $ra
    /* CFEEC 800DF6EC 0C00D8B8 */   swr       $t8, 0xC($a2)
  .L800DF6F0:
    /* CFEF0 800DF6F0 D015838F */  lw         $v1, %gp_rel(Texture_gP4bitPmx)($gp)
    /* CFEF4 800DF6F4 A87D0308 */  j          .L800DF6A0
    /* CFEF8 800DF6F8 80100900 */   sll       $v0, $t1, 2
  .L800DF6FC:
    /* CFEFC 800DF6FC 1700E010 */  beqz       $a3, .L800DF75C
    /* CFF00 800DF700 21480000 */   addu      $t1, $zero, $zero
    /* CFF04 800DF704 80000C24 */  addiu      $t4, $zero, 0x80
    /* CFF08 800DF708 CC158B8F */  lw         $t3, %gp_rel(Texture_gNum8bitPal)($gp)
    /* CFF0C 800DF70C DC158A8F */  lw         $t2, %gp_rel(Texture_gPalette8bit)($gp)
  .L800DF710:
    /* CFF10 800DF710 2A102B01 */  slt        $v0, $t1, $t3
    /* CFF14 800DF714 27004010 */  beqz       $v0, .L800DF7B4
    /* CFF18 800DF718 2140A000 */   addu      $t0, $a1, $zero
    /* CFF1C 800DF71C 0000478D */  lw         $a3, 0x0($t2)
    /* CFF20 800DF720 21200000 */  addu       $a0, $zero, $zero
  .L800DF724:
    /* CFF24 800DF724 0000E38C */  lw         $v1, 0x0($a3)
    /* CFF28 800DF728 0400E724 */  addiu      $a3, $a3, 0x4
    /* CFF2C 800DF72C 0000028D */  lw         $v0, 0x0($t0)
    /* CFF30 800DF730 00000000 */  nop
    /* CFF34 800DF734 05004314 */  bne        $v0, $v1, .L800DF74C
    /* CFF38 800DF738 04000825 */   addiu     $t0, $t0, 0x4
    /* CFF3C 800DF73C 01008424 */  addiu      $a0, $a0, 0x1
    /* CFF40 800DF740 80008228 */  slti       $v0, $a0, 0x80
    /* CFF44 800DF744 F7FF4014 */  bnez       $v0, .L800DF724
    /* CFF48 800DF748 00000000 */   nop
  .L800DF74C:
    /* CFF4C 800DF74C D2FF8C10 */  beq        $a0, $t4, .L800DF698
    /* CFF50 800DF750 04004A25 */   addiu     $t2, $t2, 0x4
    /* CFF54 800DF754 C47D0308 */  j          .L800DF710
    /* CFF58 800DF758 01002925 */   addiu     $t1, $t1, 0x1
  .L800DF75C:
    /* CFF5C 800DF75C 08000C24 */  addiu      $t4, $zero, 0x8
    /* CFF60 800DF760 C8158B8F */  lw         $t3, %gp_rel(Texture_gNum4bitPal)($gp)
    /* CFF64 800DF764 D8158A8F */  lw         $t2, %gp_rel(Texture_gPalette4bit)($gp)
  .L800DF768:
    /* CFF68 800DF768 2A102B01 */  slt        $v0, $t1, $t3
    /* CFF6C 800DF76C 11004010 */  beqz       $v0, .L800DF7B4
    /* CFF70 800DF770 2140A000 */   addu      $t0, $a1, $zero
    /* CFF74 800DF774 0000478D */  lw         $a3, 0x0($t2)
    /* CFF78 800DF778 21200000 */  addu       $a0, $zero, $zero
  .L800DF77C:
    /* CFF7C 800DF77C 0000E38C */  lw         $v1, 0x0($a3)
    /* CFF80 800DF780 0400E724 */  addiu      $a3, $a3, 0x4
    /* CFF84 800DF784 0000028D */  lw         $v0, 0x0($t0)
    /* CFF88 800DF788 00000000 */  nop
    /* CFF8C 800DF78C 05004314 */  bne        $v0, $v1, .L800DF7A4
    /* CFF90 800DF790 04000825 */   addiu     $t0, $t0, 0x4
    /* CFF94 800DF794 01008424 */  addiu      $a0, $a0, 0x1
    /* CFF98 800DF798 08008228 */  slti       $v0, $a0, 0x8
    /* CFF9C 800DF79C F7FF4014 */  bnez       $v0, .L800DF77C
    /* CFFA0 800DF7A0 00000000 */   nop
  .L800DF7A4:
    /* CFFA4 800DF7A4 D2FF8C10 */  beq        $a0, $t4, .L800DF6F0
    /* CFFA8 800DF7A8 04004A25 */   addiu     $t2, $t2, 0x4
    /* CFFAC 800DF7AC DA7D0308 */  j          .L800DF768
    /* CFFB0 800DF7B0 01002925 */   addiu     $t1, $t1, 0x1
  .L800DF7B4:
    /* CFFB4 800DF7B4 0800E003 */  jr         $ra
    /* CFFB8 800DF7B8 21100000 */   addu      $v0, $zero, $zero
endlabel Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi
