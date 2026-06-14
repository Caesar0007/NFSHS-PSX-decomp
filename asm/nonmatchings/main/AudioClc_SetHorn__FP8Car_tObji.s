.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_SetHorn__FP8Car_tObji, 0x70

glabel AudioClc_SetHorn__FP8Car_tObji
    /* 64F38 80074738 21400000 */  addu       $t0, $zero, $zero
    /* 64F3C 8007473C 1180023C */  lui        $v0, %hi(AudioClc_gClosest)
    /* 64F40 80074740 48E34624 */  addiu      $a2, $v0, %lo(AudioClc_gClosest)
    /* 64F44 80074744 01000724 */  addiu      $a3, $zero, 0x1
    /* 64F48 80074748 2C00C324 */  addiu      $v1, $a2, 0x2C
  .L8007474C:
    /* 64F4C 8007474C 0000C28C */  lw         $v0, 0x0($a2)
    /* 64F50 80074750 00000000 */  nop
    /* 64F54 80074754 0D004414 */  bne        $v0, $a0, .L8007478C
    /* 64F58 80074758 00000000 */   nop
    /* 64F5C 8007475C 0400A010 */  beqz       $a1, .L80074770
    /* 64F60 80074760 00000000 */   nop
    /* 64F64 80074764 F4FF67AC */  sw         $a3, -0xC($v1)
    /* 64F68 80074768 E3D10108 */  j          .L8007478C
    /* 64F6C 8007476C F8FF60AC */   sw        $zero, -0x8($v1)
  .L80074770:
    /* 64F70 80074770 F4FF628C */  lw         $v0, -0xC($v1)
    /* 64F74 80074774 00000000 */  nop
    /* 64F78 80074778 04004010 */  beqz       $v0, .L8007478C
    /* 64F7C 8007477C 00000000 */   nop
    /* 64F80 80074780 F4FF67AC */  sw         $a3, -0xC($v1)
    /* 64F84 80074784 F8FF67AC */  sw         $a3, -0x8($v1)
    /* 64F88 80074788 000067AC */  sw         $a3, 0x0($v1)
  .L8007478C:
    /* 64F8C 8007478C 01000825 */  addiu      $t0, $t0, 0x1
    /* 64F90 80074790 38006324 */  addiu      $v1, $v1, 0x38
    /* 64F94 80074794 04000229 */  slti       $v0, $t0, 0x4
    /* 64F98 80074798 ECFF4014 */  bnez       $v0, .L8007474C
    /* 64F9C 8007479C 3800C624 */   addiu     $a2, $a2, 0x38
    /* 64FA0 800747A0 0800E003 */  jr         $ra
    /* 64FA4 800747A4 00000000 */   nop
endlabel AudioClc_SetHorn__FP8Car_tObji
