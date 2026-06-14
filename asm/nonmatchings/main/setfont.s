.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching setfont, 0x190

glabel setfont
    /* E3694 800F2E94 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E3698 800F2E98 1800B2AF */  sw         $s2, 0x18($sp)
    /* E369C 800F2E9C 21908000 */  addu       $s2, $a0, $zero
    /* E36A0 800F2EA0 1380023C */  lui        $v0, %hi(currentfont)
    /* E36A4 800F2EA4 1400B1AF */  sw         $s1, 0x14($sp)
    /* E36A8 800F2EA8 A05B5124 */  addiu      $s1, $v0, %lo(currentfont)
    /* E36AC 800F2EAC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* E36B0 800F2EB0 1000B0AF */  sw         $s0, 0x10($sp)
    /* E36B4 800F2EB4 1C00508E */  lw         $s0, 0x1C($s2)
    /* E36B8 800F2EB8 64000224 */  addiu      $v0, $zero, 0x64
    /* E36BC 800F2EBC 7C0022AE */  sw         $v0, 0x7C($s1)
    /* E36C0 800F2EC0 10004282 */  lb         $v0, 0x10($s2)
    /* E36C4 800F2EC4 00000000 */  nop
    /* E36C8 800F2EC8 0C0022AE */  sw         $v0, 0xC($s1)
    /* E36CC 800F2ECC 11004282 */  lb         $v0, 0x11($s2)
    /* E36D0 800F2ED0 00000000 */  nop
    /* E36D4 800F2ED4 100022AE */  sw         $v0, 0x10($s1)
    /* E36D8 800F2ED8 12004282 */  lb         $v0, 0x12($s2)
    /* E36DC 800F2EDC 00000000 */  nop
    /* E36E0 800F2EE0 1C0022AE */  sw         $v0, 0x1C($s1)
    /* E36E4 800F2EE4 13004282 */  lb         $v0, 0x13($s2)
    /* E36E8 800F2EE8 00000000 */  nop
    /* E36EC 800F2EEC 200022AE */  sw         $v0, 0x20($s1)
    /* E36F0 800F2EF0 13004282 */  lb         $v0, 0x13($s2)
    /* E36F4 800F2EF4 12004382 */  lb         $v1, 0x12($s2)
    /* E36F8 800F2EF8 00000000 */  nop
    /* E36FC 800F2EFC 21104300 */  addu       $v0, $v0, $v1
    /* E3700 800F2F00 240022AE */  sw         $v0, 0x24($s1)
    /* E3704 800F2F04 13004282 */  lb         $v0, 0x13($s2)
    /* E3708 800F2F08 12004382 */  lb         $v1, 0x12($s2)
    /* E370C 800F2F0C 21805002 */  addu       $s0, $s2, $s0
    /* E3710 800F2F10 21104300 */  addu       $v0, $v0, $v1
    /* E3714 800F2F14 280022AE */  sw         $v0, 0x28($s1)
    /* E3718 800F2F18 0A004396 */  lhu        $v1, 0xA($s2)
    /* E371C 800F2F1C 01000224 */  addiu      $v0, $zero, 0x1
    /* E3720 800F2F20 180022AE */  sw         $v0, 0x18($s1)
    /* E3724 800F2F24 B00020AE */  sw         $zero, 0xB0($s1)
    /* E3728 800F2F28 AC0020AE */  sw         $zero, 0xAC($s1)
    /* E372C 800F2F2C 800032AE */  sw         $s2, 0x80($s1)
    /* E3730 800F2F30 880030AE */  sw         $s0, 0x88($s1)
    /* E3734 800F2F34 740023AE */  sw         $v1, 0x74($s1)
    /* E3738 800F2F38 1400428E */  lw         $v0, 0x14($s2)
    /* E373C 800F2F3C 21200002 */  addu       $a0, $s0, $zero
    /* E3740 800F2F40 21104202 */  addu       $v0, $s2, $v0
    /* E3744 800F2F44 F9D0030C */  jal        shapedepth
    /* E3748 800F2F48 840022AE */   sw        $v0, 0x84($s1)
    /* E374C 800F2F4C 21200002 */  addu       $a0, $s0, $zero
    /* E3750 800F2F50 F9D0030C */  jal        shapedepth
    /* E3754 800F2F54 140022AE */   sw        $v0, 0x14($s1)
    /* E3758 800F2F58 04000386 */  lh         $v1, 0x4($s0)
    /* E375C 800F2F5C 00000000 */  nop
    /* E3760 800F2F60 18006200 */  mult       $v1, $v0
    /* E3764 800F2F64 E0FF0324 */  addiu      $v1, $zero, -0x20
    /* E3768 800F2F68 12300000 */  mflo       $a2
    /* E376C 800F2F6C 1F00C224 */  addiu      $v0, $a2, 0x1F
    /* E3770 800F2F70 24104300 */  and        $v0, $v0, $v1
    /* E3774 800F2F74 C3100200 */  sra        $v0, $v0, 3
    /* E3778 800F2F78 780022AE */  sw         $v0, 0x78($s1)
    /* E377C 800F2F7C 0E004286 */  lh         $v0, 0xE($s2)
    /* E3780 800F2F80 02000324 */  addiu      $v1, $zero, 0x2
    /* E3784 800F2F84 03004230 */  andi       $v0, $v0, 0x3
    /* E3788 800F2F88 03004314 */  bne        $v0, $v1, .L800F2F98
    /* E378C 800F2F8C 1080023C */   lui       $v0, %hi(decodeshiftjis)
    /* E3790 800F2F90 F7CB0308 */  j          .L800F2FDC
    /* E3794 800F2F94 EC694224 */   addiu     $v0, $v0, %lo(decodeshiftjis)
  .L800F2F98:
    /* E3798 800F2F98 7400228E */  lw         $v0, 0x74($s1)
    /* E379C 800F2F9C 00000000 */  nop
    /* E37A0 800F2FA0 00014228 */  slti       $v0, $v0, 0x100
    /* E37A4 800F2FA4 04004014 */  bnez       $v0, .L800F2FB8
    /* E37A8 800F2FA8 20004426 */   addiu     $a0, $s2, 0x20
    /* E37AC 800F2FAC 1080023C */  lui        $v0, %hi(decodeshiftjis)
    /* E37B0 800F2FB0 F7CB0308 */  j          .L800F2FDC
    /* E37B4 800F2FB4 EC694224 */   addiu     $v0, $v0, %lo(decodeshiftjis)
  .L800F2FB8:
    /* E37B8 800F2FB8 23CC030C */  jal        geti
    /* E37BC 800F2FBC 02000524 */   addiu     $a1, $zero, 0x2
    /* E37C0 800F2FC0 0001422C */  sltiu      $v0, $v0, 0x100
    /* E37C4 800F2FC4 03004014 */  bnez       $v0, .L800F2FD4
    /* E37C8 800F2FC8 1080023C */   lui       $v0, %hi(decodeshiftjis)
    /* E37CC 800F2FCC F7CB0308 */  j          .L800F2FDC
    /* E37D0 800F2FD0 EC694224 */   addiu     $v0, $v0, %lo(decodeshiftjis)
  .L800F2FD4:
    /* E37D4 800F2FD4 1080023C */  lui        $v0, %hi(decodeansi)
    /* E37D8 800F2FD8 AC694224 */  addiu      $v0, $v0, %lo(decodeansi)
  .L800F2FDC:
    /* E37DC 800F2FDC A00022AE */  sw         $v0, 0xA0($s1)
    /* E37E0 800F2FE0 1380103C */  lui        $s0, %hi(currentfont)
    /* E37E4 800F2FE4 A05B1026 */  addiu      $s0, $s0, %lo(currentfont)
    /* E37E8 800F2FE8 34000426 */  addiu      $a0, $s0, 0x34
    /* E37EC 800F2FEC 40000524 */  addiu      $a1, $zero, 0x40
    /* E37F0 800F2FF0 2C0000AE */  sw         $zero, 0x2C($s0)
    /* E37F4 800F2FF4 300000AE */  sw         $zero, 0x30($s0)
    /* E37F8 800F2FF8 E8C5030C */  jal        blockclear
    /* E37FC 800F2FFC B40000AE */   sw        $zero, 0xB4($s0)
    /* E3800 800F3000 928F030C */  jal        inittextdraw
    /* E3804 800F3004 00000000 */   nop
    /* E3808 800F3008 A40000AE */  sw         $zero, 0xA4($s0)
    /* E380C 800F300C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* E3810 800F3010 1800B28F */  lw         $s2, 0x18($sp)
    /* E3814 800F3014 1400B18F */  lw         $s1, 0x14($sp)
    /* E3818 800F3018 1000B08F */  lw         $s0, 0x10($sp)
    /* E381C 800F301C 0800E003 */  jr         $ra
    /* E3820 800F3020 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel setfont
