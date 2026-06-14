.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_UpdateTVCam__Fi, 0x14C

glabel Camera_UpdateTVCam__Fi
    /* 72648 80081E48 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 7264C 80081E4C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 72650 80081E50 21988000 */  addu       $s3, $a0, $zero
    /* 72654 80081E54 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 72658 80081E58 ACF24224 */  addiu      $v0, $v0, %lo(Camera_gInfo)
    /* 7265C 80081E5C 00191300 */  sll        $v1, $s3, 4
    /* 72660 80081E60 21187300 */  addu       $v1, $v1, $s3
    /* 72664 80081E64 00190300 */  sll        $v1, $v1, 4
    /* 72668 80081E68 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7266C 80081E6C 21886200 */  addu       $s1, $v1, $v0
    /* 72670 80081E70 08004224 */  addiu      $v0, $v0, 0x8
    /* 72674 80081E74 1000B0AF */  sw         $s0, 0x10($sp)
    /* 72678 80081E78 21806200 */  addu       $s0, $v1, $v0
    /* 7267C 80081E7C 2000BFAF */  sw         $ra, 0x20($sp)
    /* 72680 80081E80 1800B2AF */  sw         $s2, 0x18($sp)
    /* 72684 80081E84 0400248E */  lw         $a0, 0x4($s1)
    /* 72688 80081E88 21280002 */  addu       $a1, $s0, $zero
    /* 7268C 80081E8C 0E75020C */  jal        Math_Dist3D__FP8coorddefT0
    /* 72690 80081E90 A0008424 */   addiu     $a0, $a0, 0xA0
    /* 72694 80081E94 06004018 */  blez       $v0, .L80081EB0
    /* 72698 80081E98 21280002 */   addu      $a1, $s0, $zero
    /* 7269C 80081E9C 0400248E */  lw         $a0, 0x4($s1)
    /* 726A0 80081EA0 0E75020C */  jal        Math_Dist3D__FP8coorddefT0
    /* 726A4 80081EA4 A0008424 */   addiu     $a0, $a0, 0xA0
    /* 726A8 80081EA8 B1070208 */  j          .L80081EC4
    /* 726AC 80081EAC 03910200 */   sra       $s2, $v0, 4
  .L80081EB0:
    /* 726B0 80081EB0 0400248E */  lw         $a0, 0x4($s1)
    /* 726B4 80081EB4 0E75020C */  jal        Math_Dist3D__FP8coorddefT0
    /* 726B8 80081EB8 A0008424 */   addiu     $a0, $a0, 0xA0
    /* 726BC 80081EBC 23100200 */  negu       $v0, $v0
    /* 726C0 80081EC0 03910200 */  sra        $s2, $v0, 4
  .L80081EC4:
    /* 726C4 80081EC4 80881300 */  sll        $s1, $s3, 2
    /* 726C8 80081EC8 1480023C */  lui        $v0, %hi(D_8013DD88)
    /* 726CC 80081ECC 88DD4224 */  addiu      $v0, $v0, %lo(D_8013DD88)
    /* 726D0 80081ED0 21202202 */  addu       $a0, $s1, $v0
    /* 726D4 80081ED4 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* 726D8 80081ED8 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 726DC 80081EDC 00111300 */  sll        $v0, $s3, 4
    /* 726E0 80081EE0 21105300 */  addu       $v0, $v0, $s3
    /* 726E4 80081EE4 00110200 */  sll        $v0, $v0, 4
    /* 726E8 80081EE8 21804300 */  addu       $s0, $v0, $v1
    /* 726EC 80081EEC 0000828C */  lw         $v0, 0x0($a0)
    /* 726F0 80081EF0 0800038E */  lw         $v1, 0x8($s0)
    /* 726F4 80081EF4 00000000 */  nop
    /* 726F8 80081EF8 07004310 */  beq        $v0, $v1, .L80081F18
    /* 726FC 80081EFC 00000000 */   nop
    /* 72700 80081F00 1480023C */  lui        $v0, %hi(D_8013DD90)
    /* 72704 80081F04 90DD4224 */  addiu      $v0, $v0, %lo(D_8013DD90)
    /* 72708 80081F08 000083AC */  sw         $v1, 0x0($a0)
    /* 7270C 80081F0C 0C00038E */  lw         $v1, 0xC($s0)
    /* 72710 80081F10 21102202 */  addu       $v0, $s1, $v0
    /* 72714 80081F14 000043AC */  sw         $v1, 0x0($v0)
  .L80081F18:
    /* 72718 80081F18 2C00048E */  lw         $a0, 0x2C($s0)
    /* 7271C 80081F1C 00C04526 */  addiu      $a1, $s2, -0x4000
    /* 72720 80081F20 CA90030C */  jal        fixedmult
    /* 72724 80081F24 83200400 */   sra       $a0, $a0, 2
    /* 72728 80081F28 2C00038E */  lw         $v1, 0x2C($s0)
    /* 7272C 80081F2C 00000000 */  nop
    /* 72730 80081F30 2A206200 */  slt        $a0, $v1, $v0
    /* 72734 80081F34 02008010 */  beqz       $a0, .L80081F40
    /* 72738 80081F38 21304000 */   addu      $a2, $v0, $zero
    /* 7273C 80081F3C 21306000 */  addu       $a2, $v1, $zero
  .L80081F40:
    /* 72740 80081F40 02008010 */  beqz       $a0, .L80081F4C
    /* 72744 80081F44 00000000 */   nop
    /* 72748 80081F48 21106000 */  addu       $v0, $v1, $zero
  .L80081F4C:
    /* 7274C 80081F4C 02004104 */  bgez       $v0, .L80081F58
    /* 72750 80081F50 21206002 */   addu      $a0, $s3, $zero
    /* 72754 80081F54 21300000 */  addu       $a2, $zero, $zero
  .L80081F58:
    /* 72758 80081F58 1480023C */  lui        $v0, %hi(D_8013DD90)
    /* 7275C 80081F5C 90DD4224 */  addiu      $v0, $v0, %lo(D_8013DD90)
    /* 72760 80081F60 21102202 */  addu       $v0, $s1, $v0
    /* 72764 80081F64 0000428C */  lw         $v0, 0x0($v0)
    /* 72768 80081F68 21284002 */  addu       $a1, $s2, $zero
    /* 7276C 80081F6C 21104600 */  addu       $v0, $v0, $a2
    /* 72770 80081F70 4E07020C */  jal        SetCameraZoom__Fii
    /* 72774 80081F74 0C0002AE */   sw        $v0, 0xC($s0)
    /* 72778 80081F78 2000BF8F */  lw         $ra, 0x20($sp)
    /* 7277C 80081F7C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 72780 80081F80 1800B28F */  lw         $s2, 0x18($sp)
    /* 72784 80081F84 1400B18F */  lw         $s1, 0x14($sp)
    /* 72788 80081F88 1000B08F */  lw         $s0, 0x10($sp)
    /* 7278C 80081F8C 0800E003 */  jr         $ra
    /* 72790 80081F90 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Camera_UpdateTVCam__Fi
