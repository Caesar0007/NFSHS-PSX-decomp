.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_QuickReOrthogonalize__FP10matrixtdefT0, 0x280

glabel Weather_QuickReOrthogonalize__FP10matrixtdefT0
    /* D3550 800E2D50 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* D3554 800E2D54 3400B5AF */  sw         $s5, 0x34($sp)
    /* D3558 800E2D58 21A88000 */  addu       $s5, $a0, $zero
    /* D355C 800E2D5C 3000B4AF */  sw         $s4, 0x30($sp)
    /* D3560 800E2D60 21A0A000 */  addu       $s4, $a1, $zero
    /* D3564 800E2D64 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* D3568 800E2D68 18009326 */  addiu      $s3, $s4, 0x18
    /* D356C 800E2D6C 21206002 */  addu       $a0, $s3, $zero
    /* D3570 800E2D70 0580023C */  lui        $v0, %hi(D_80056B2C)
    /* D3574 800E2D74 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* D3578 800E2D78 0C00B726 */  addiu      $s7, $s5, 0xC
    /* D357C 800E2D7C 2800B2AF */  sw         $s2, 0x28($sp)
    /* D3580 800E2D80 4000BFAF */  sw         $ra, 0x40($sp)
    /* D3584 800E2D84 3800B6AF */  sw         $s6, 0x38($sp)
    /* D3588 800E2D88 2400B1AF */  sw         $s1, 0x24($sp)
    /* D358C 800E2D8C 2000B0AF */  sw         $s0, 0x20($sp)
    /* D3590 800E2D90 2C6B4824 */  addiu      $t0, $v0, %lo(D_80056B2C)
    /* D3594 800E2D94 0000038D */  lw         $v1, 0x0($t0)
    /* D3598 800E2D98 0400068D */  lw         $a2, 0x4($t0)
    /* D359C 800E2D9C 0800078D */  lw         $a3, 0x8($t0)
    /* D35A0 800E2DA0 1000A3AF */  sw         $v1, 0x10($sp)
    /* D35A4 800E2DA4 1400A6AF */  sw         $a2, 0x14($sp)
    /* D35A8 800E2DA8 1800A7AF */  sw         $a3, 0x18($sp)
    /* D35AC 800E2DAC 1800A38E */  lw         $v1, 0x18($s5)
    /* D35B0 800E2DB0 1C00A68E */  lw         $a2, 0x1C($s5)
    /* D35B4 800E2DB4 2000A78E */  lw         $a3, 0x20($s5)
    /* D35B8 800E2DB8 180083AE */  sw         $v1, 0x18($s4)
    /* D35BC 800E2DBC 1C0086AE */  sw         $a2, 0x1C($s4)
    /* D35C0 800E2DC0 200087AE */  sw         $a3, 0x20($s4)
    /* D35C4 800E2DC4 8776020C */  jal        Math_NormalizeVector__FP8coorddef
    /* D35C8 800E2DC8 1800B226 */   addiu     $s2, $s5, 0x18
    /* D35CC 800E2DCC 1000A48F */  lw         $a0, 0x10($sp)
    /* D35D0 800E2DD0 1800A58E */  lw         $a1, 0x18($s5)
    /* D35D4 800E2DD4 CA90030C */  jal        fixedmult
    /* D35D8 800E2DD8 0C009626 */   addiu     $s6, $s4, 0xC
    /* D35DC 800E2DDC 1400A48F */  lw         $a0, 0x14($sp)
    /* D35E0 800E2DE0 0400458E */  lw         $a1, 0x4($s2)
    /* D35E4 800E2DE4 CA90030C */  jal        fixedmult
    /* D35E8 800E2DE8 21804000 */   addu      $s0, $v0, $zero
    /* D35EC 800E2DEC 1800A48F */  lw         $a0, 0x18($sp)
    /* D35F0 800E2DF0 0800458E */  lw         $a1, 0x8($s2)
    /* D35F4 800E2DF4 CA90030C */  jal        fixedmult
    /* D35F8 800E2DF8 21884000 */   addu      $s1, $v0, $zero
    /* D35FC 800E2DFC 21801102 */  addu       $s0, $s0, $s1
    /* D3600 800E2E00 21800202 */  addu       $s0, $s0, $v0
    /* D3604 800E2E04 1000001A */  blez       $s0, .L800E2E48
    /* D3608 800E2E08 00000000 */   nop
    /* D360C 800E2E0C 1000A48F */  lw         $a0, 0x10($sp)
    /* D3610 800E2E10 1800A58E */  lw         $a1, 0x18($s5)
    /* D3614 800E2E14 CA90030C */  jal        fixedmult
    /* D3618 800E2E18 00000000 */   nop
    /* D361C 800E2E1C 1400A48F */  lw         $a0, 0x14($sp)
    /* D3620 800E2E20 0400458E */  lw         $a1, 0x4($s2)
    /* D3624 800E2E24 CA90030C */  jal        fixedmult
    /* D3628 800E2E28 21804000 */   addu      $s0, $v0, $zero
    /* D362C 800E2E2C 1800A48F */  lw         $a0, 0x18($sp)
    /* D3630 800E2E30 0800458E */  lw         $a1, 0x8($s2)
    /* D3634 800E2E34 CA90030C */  jal        fixedmult
    /* D3638 800E2E38 21884000 */   addu      $s1, $v0, $zero
    /* D363C 800E2E3C 21801102 */  addu       $s0, $s0, $s1
    /* D3640 800E2E40 A18B0308 */  j          .L800E2E84
    /* D3644 800E2E44 21800202 */   addu      $s0, $s0, $v0
  .L800E2E48:
    /* D3648 800E2E48 1000A48F */  lw         $a0, 0x10($sp)
    /* D364C 800E2E4C 1800A58E */  lw         $a1, 0x18($s5)
    /* D3650 800E2E50 CA90030C */  jal        fixedmult
    /* D3654 800E2E54 00000000 */   nop
    /* D3658 800E2E58 1400A48F */  lw         $a0, 0x14($sp)
    /* D365C 800E2E5C 0400458E */  lw         $a1, 0x4($s2)
    /* D3660 800E2E60 CA90030C */  jal        fixedmult
    /* D3664 800E2E64 21804000 */   addu      $s0, $v0, $zero
    /* D3668 800E2E68 1800A48F */  lw         $a0, 0x18($sp)
    /* D366C 800E2E6C 0800458E */  lw         $a1, 0x8($s2)
    /* D3670 800E2E70 CA90030C */  jal        fixedmult
    /* D3674 800E2E74 21884000 */   addu      $s1, $v0, $zero
    /* D3678 800E2E78 21801102 */  addu       $s0, $s0, $s1
    /* D367C 800E2E7C 21800202 */  addu       $s0, $s0, $v0
    /* D3680 800E2E80 23801000 */  negu       $s0, $s0
  .L800E2E84:
    /* D3684 800E2E84 70FD0234 */  ori        $v0, $zero, 0xFD70
    /* D3688 800E2E88 2A805000 */  slt        $s0, $v0, $s0
    /* D368C 800E2E8C 07000012 */  beqz       $s0, .L800E2EAC
    /* D3690 800E2E90 00000000 */   nop
    /* D3694 800E2E94 0000E38E */  lw         $v1, 0x0($s7)
    /* D3698 800E2E98 0400E68E */  lw         $a2, 0x4($s7)
    /* D369C 800E2E9C 0800E78E */  lw         $a3, 0x8($s7)
    /* D36A0 800E2EA0 1000A3AF */  sw         $v1, 0x10($sp)
    /* D36A4 800E2EA4 1400A6AF */  sw         $a2, 0x14($sp)
    /* D36A8 800E2EA8 1800A7AF */  sw         $a3, 0x18($sp)
  .L800E2EAC:
    /* D36AC 800E2EAC 1400A48F */  lw         $a0, 0x14($sp)
    /* D36B0 800E2EB0 0800658E */  lw         $a1, 0x8($s3)
    /* D36B4 800E2EB4 CA90030C */  jal        fixedmult
    /* D36B8 800E2EB8 00000000 */   nop
    /* D36BC 800E2EBC 1800A48F */  lw         $a0, 0x18($sp)
    /* D36C0 800E2EC0 0400658E */  lw         $a1, 0x4($s3)
    /* D36C4 800E2EC4 CA90030C */  jal        fixedmult
    /* D36C8 800E2EC8 21804000 */   addu      $s0, $v0, $zero
    /* D36CC 800E2ECC 23800202 */  subu       $s0, $s0, $v0
    /* D36D0 800E2ED0 000090AE */  sw         $s0, 0x0($s4)
    /* D36D4 800E2ED4 1800A48F */  lw         $a0, 0x18($sp)
    /* D36D8 800E2ED8 0000658E */  lw         $a1, 0x0($s3)
    /* D36DC 800E2EDC CA90030C */  jal        fixedmult
    /* D36E0 800E2EE0 00000000 */   nop
    /* D36E4 800E2EE4 1000A48F */  lw         $a0, 0x10($sp)
    /* D36E8 800E2EE8 0800658E */  lw         $a1, 0x8($s3)
    /* D36EC 800E2EEC CA90030C */  jal        fixedmult
    /* D36F0 800E2EF0 21804000 */   addu      $s0, $v0, $zero
    /* D36F4 800E2EF4 23800202 */  subu       $s0, $s0, $v0
    /* D36F8 800E2EF8 040090AE */  sw         $s0, 0x4($s4)
    /* D36FC 800E2EFC 1000A48F */  lw         $a0, 0x10($sp)
    /* D3700 800E2F00 0400658E */  lw         $a1, 0x4($s3)
    /* D3704 800E2F04 CA90030C */  jal        fixedmult
    /* D3708 800E2F08 00000000 */   nop
    /* D370C 800E2F0C 1400A48F */  lw         $a0, 0x14($sp)
    /* D3710 800E2F10 0000658E */  lw         $a1, 0x0($s3)
    /* D3714 800E2F14 CA90030C */  jal        fixedmult
    /* D3718 800E2F18 21804000 */   addu      $s0, $v0, $zero
    /* D371C 800E2F1C 21208002 */  addu       $a0, $s4, $zero
    /* D3720 800E2F20 23800202 */  subu       $s0, $s0, $v0
    /* D3724 800E2F24 8776020C */  jal        Math_NormalizeVector__FP8coorddef
    /* D3728 800E2F28 080090AE */   sw        $s0, 0x8($s4)
    /* D372C 800E2F2C 0400648E */  lw         $a0, 0x4($s3)
    /* D3730 800E2F30 0800858E */  lw         $a1, 0x8($s4)
    /* D3734 800E2F34 CA90030C */  jal        fixedmult
    /* D3738 800E2F38 00000000 */   nop
    /* D373C 800E2F3C 0800648E */  lw         $a0, 0x8($s3)
    /* D3740 800E2F40 0400858E */  lw         $a1, 0x4($s4)
    /* D3744 800E2F44 CA90030C */  jal        fixedmult
    /* D3748 800E2F48 21804000 */   addu      $s0, $v0, $zero
    /* D374C 800E2F4C 23800202 */  subu       $s0, $s0, $v0
    /* D3750 800E2F50 0000D0AE */  sw         $s0, 0x0($s6)
    /* D3754 800E2F54 0800648E */  lw         $a0, 0x8($s3)
    /* D3758 800E2F58 0000858E */  lw         $a1, 0x0($s4)
    /* D375C 800E2F5C CA90030C */  jal        fixedmult
    /* D3760 800E2F60 00000000 */   nop
    /* D3764 800E2F64 0000648E */  lw         $a0, 0x0($s3)
    /* D3768 800E2F68 0800858E */  lw         $a1, 0x8($s4)
    /* D376C 800E2F6C CA90030C */  jal        fixedmult
    /* D3770 800E2F70 21804000 */   addu      $s0, $v0, $zero
    /* D3774 800E2F74 23800202 */  subu       $s0, $s0, $v0
    /* D3778 800E2F78 0400D0AE */  sw         $s0, 0x4($s6)
    /* D377C 800E2F7C 0000648E */  lw         $a0, 0x0($s3)
    /* D3780 800E2F80 0400858E */  lw         $a1, 0x4($s4)
    /* D3784 800E2F84 CA90030C */  jal        fixedmult
    /* D3788 800E2F88 00000000 */   nop
    /* D378C 800E2F8C 0400648E */  lw         $a0, 0x4($s3)
    /* D3790 800E2F90 0000858E */  lw         $a1, 0x0($s4)
    /* D3794 800E2F94 CA90030C */  jal        fixedmult
    /* D3798 800E2F98 21804000 */   addu      $s0, $v0, $zero
    /* D379C 800E2F9C 23800202 */  subu       $s0, $s0, $v0
    /* D37A0 800E2FA0 0800D0AE */  sw         $s0, 0x8($s6)
    /* D37A4 800E2FA4 4000BF8F */  lw         $ra, 0x40($sp)
    /* D37A8 800E2FA8 3C00B78F */  lw         $s7, 0x3C($sp)
    /* D37AC 800E2FAC 3800B68F */  lw         $s6, 0x38($sp)
    /* D37B0 800E2FB0 3400B58F */  lw         $s5, 0x34($sp)
    /* D37B4 800E2FB4 3000B48F */  lw         $s4, 0x30($sp)
    /* D37B8 800E2FB8 2C00B38F */  lw         $s3, 0x2C($sp)
    /* D37BC 800E2FBC 2800B28F */  lw         $s2, 0x28($sp)
    /* D37C0 800E2FC0 2400B18F */  lw         $s1, 0x24($sp)
    /* D37C4 800E2FC4 2000B08F */  lw         $s0, 0x20($sp)
    /* D37C8 800E2FC8 0800E003 */  jr         $ra
    /* D37CC 800E2FCC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Weather_QuickReOrthogonalize__FP10matrixtdefT0
