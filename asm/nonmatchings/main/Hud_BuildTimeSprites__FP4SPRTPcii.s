.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildTimeSprites__FP4SPRTPcii, 0x134

glabel Hud_BuildTimeSprites__FP4SPRTPcii
    /* C36F8 800D2EF8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* C36FC 800D2EFC 2800B2AF */  sw         $s2, 0x28($sp)
    /* C3700 800D2F00 2190A000 */  addu       $s2, $a1, $zero
    /* C3704 800D2F04 3000B4AF */  sw         $s4, 0x30($sp)
    /* C3708 800D2F08 21A0C000 */  addu       $s4, $a2, $zero
    /* C370C 800D2F0C 4000BEAF */  sw         $fp, 0x40($sp)
    /* C3710 800D2F10 1480023C */  lui        $v0, %hi(D_8013D8DC)
    /* C3714 800D2F14 4400BFAF */  sw         $ra, 0x44($sp)
    /* C3718 800D2F18 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* C371C 800D2F1C 3800B6AF */  sw         $s6, 0x38($sp)
    /* C3720 800D2F20 3400B5AF */  sw         $s5, 0x34($sp)
    /* C3724 800D2F24 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* C3728 800D2F28 2400B1AF */  sw         $s1, 0x24($sp)
    /* C372C 800D2F2C 2000B0AF */  sw         $s0, 0x20($sp)
    /* C3730 800D2F30 DCD84B24 */  addiu      $t3, $v0, %lo(D_8013D8DC)
    /* C3734 800D2F34 03006889 */  lwl        $t0, 0x3($t3)
    /* C3738 800D2F38 00006899 */  lwr        $t0, 0x0($t3)
    /* C373C 800D2F3C 04006981 */  lb         $t1, 0x4($t3)
    /* C3740 800D2F40 05006A81 */  lb         $t2, 0x5($t3)
    /* C3744 800D2F44 1300A8AB */  swl        $t0, 0x13($sp)
    /* C3748 800D2F48 1000A8BB */  swr        $t0, 0x10($sp)
    /* C374C 800D2F4C 1400A9A3 */  sb         $t1, 0x14($sp)
    /* C3750 800D2F50 1500AAA3 */  sb         $t2, 0x15($sp)
    /* C3754 800D2F54 1480023C */  lui        $v0, %hi(D_8013D8E4)
    /* C3758 800D2F58 E4D84B24 */  addiu      $t3, $v0, %lo(D_8013D8E4)
    /* C375C 800D2F5C 03006889 */  lwl        $t0, 0x3($t3)
    /* C3760 800D2F60 00006899 */  lwr        $t0, 0x0($t3)
    /* C3764 800D2F64 04006981 */  lb         $t1, 0x4($t3)
    /* C3768 800D2F68 05006A81 */  lb         $t2, 0x5($t3)
    /* C376C 800D2F6C 1B00A8AB */  swl        $t0, 0x1B($sp)
    /* C3770 800D2F70 1800A8BB */  swr        $t0, 0x18($sp)
    /* C3774 800D2F74 1C00A9A3 */  sb         $t1, 0x1C($sp)
    /* C3778 800D2F78 1D00AAA3 */  sb         $t2, 0x1D($sp)
    /* C377C 800D2F7C 1180023C */  lui        $v0, %hi(D_801132CC)
    /* C3780 800D2F80 CC32428C */  lw         $v0, %lo(D_801132CC)($v0)
    /* C3784 800D2F84 00005192 */  lbu        $s1, 0x0($s2)
    /* C3788 800D2F88 2118A203 */  addu       $v1, $sp, $v0
    /* C378C 800D2F8C 21106000 */  addu       $v0, $v1, $zero
    /* C3790 800D2F90 10007690 */  lbu        $s6, 0x10($v1)
    /* C3794 800D2F94 18005590 */  lbu        $s5, 0x18($v0)
    /* C3798 800D2F98 18002012 */  beqz       $s1, .L800D2FFC
    /* C379C 800D2F9C 21F0E000 */   addu      $fp, $a3, $zero
    /* C37A0 800D2FA0 4D001724 */  addiu      $s7, $zero, 0x4D
    /* C37A4 800D2FA4 21988000 */  addu       $s3, $a0, $zero
  .L800D2FA8:
    /* C37A8 800D2FA8 02003716 */  bne        $s1, $s7, .L800D2FB4
    /* C37AC 800D2FAC 53000224 */   addiu     $v0, $zero, 0x53
    /* C37B0 800D2FB0 FF00D132 */  andi       $s1, $s6, 0xFF
  .L800D2FB4:
    /* C37B4 800D2FB4 02002216 */  bne        $s1, $v0, .L800D2FC0
    /* C37B8 800D2FB8 00000000 */   nop
    /* C37BC 800D2FBC FF00B132 */  andi       $s1, $s5, 0xFF
  .L800D2FC0:
    /* C37C0 800D2FC0 D02D030C */  jal        Font_Getcharacter__Fi
    /* C37C4 800D2FC4 21202002 */   addu      $a0, $s1, $zero
    /* C37C8 800D2FC8 21206002 */  addu       $a0, $s3, $zero
    /* C37CC 800D2FCC 14007326 */  addiu      $s3, $s3, 0x14
    /* C37D0 800D2FD0 21282002 */  addu       $a1, $s1, $zero
    /* C37D4 800D2FD4 21308002 */  addu       $a2, $s4, $zero
    /* C37D8 800D2FD8 08005080 */  lb         $s0, 0x8($v0)
    /* C37DC 800D2FDC 2138C003 */  addu       $a3, $fp, $zero
    /* C37E0 800D2FE0 4148030C */  jal        Hud_BuildSpriteFromFont__FP4SPRTcii
    /* C37E4 800D2FE4 01001026 */   addiu     $s0, $s0, 0x1
    /* C37E8 800D2FE8 01005226 */  addiu      $s2, $s2, 0x1
    /* C37EC 800D2FEC 00005192 */  lbu        $s1, 0x0($s2)
    /* C37F0 800D2FF0 00000000 */  nop
    /* C37F4 800D2FF4 ECFF2016 */  bnez       $s1, .L800D2FA8
    /* C37F8 800D2FF8 21A09002 */   addu      $s4, $s4, $s0
  .L800D2FFC:
    /* C37FC 800D2FFC 4400BF8F */  lw         $ra, 0x44($sp)
    /* C3800 800D3000 4000BE8F */  lw         $fp, 0x40($sp)
    /* C3804 800D3004 3C00B78F */  lw         $s7, 0x3C($sp)
    /* C3808 800D3008 3800B68F */  lw         $s6, 0x38($sp)
    /* C380C 800D300C 3400B58F */  lw         $s5, 0x34($sp)
    /* C3810 800D3010 3000B48F */  lw         $s4, 0x30($sp)
    /* C3814 800D3014 2C00B38F */  lw         $s3, 0x2C($sp)
    /* C3818 800D3018 2800B28F */  lw         $s2, 0x28($sp)
    /* C381C 800D301C 2400B18F */  lw         $s1, 0x24($sp)
    /* C3820 800D3020 2000B08F */  lw         $s0, 0x20($sp)
    /* C3824 800D3024 0800E003 */  jr         $ra
    /* C3828 800D3028 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Hud_BuildTimeSprites__FP4SPRTPcii
