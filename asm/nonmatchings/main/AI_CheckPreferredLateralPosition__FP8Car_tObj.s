.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CheckPreferredLateralPosition__FP8Car_tObj, 0x1B4

glabel AI_CheckPreferredLateralPosition__FP8Car_tObj
    /* 4A6AC 80059EAC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 4A6B0 80059EB0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 4A6B4 80059EB4 21808000 */  addu       $s0, $a0, $zero
    /* 4A6B8 80059EB8 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 4A6BC 80059EBC 2800B2AF */  sw         $s2, 0x28($sp)
    /* 4A6C0 80059EC0 2400B1AF */  sw         $s1, 0x24($sp)
    /* 4A6C4 80059EC4 1C07058E */  lw         $a1, 0x71C($s0)
    /* 4A6C8 80059EC8 3401028E */  lw         $v0, 0x134($s0)
    /* 4A6CC 80059ECC 08000486 */  lh         $a0, 0x8($s0)
    /* 4A6D0 80059ED0 2328A200 */  subu       $a1, $a1, $v0
    /* 4A6D4 80059ED4 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 4A6D8 80059ED8 00C0A524 */   addiu     $a1, $a1, -0x4000
    /* 4A6DC 80059EDC C406038E */  lw         $v1, 0x6C4($s0)
    /* 4A6E0 80059EE0 00000000 */  nop
    /* 4A6E4 80059EE4 03004314 */  bne        $v0, $v1, .L80059EF4
    /* 4A6E8 80059EE8 2A104300 */   slt       $v0, $v0, $v1
    /* 4A6EC 80059EEC BF670108 */  j          .L80059EFC
    /* 4A6F0 80059EF0 01001224 */   addiu     $s2, $zero, 0x1
  .L80059EF4:
    /* 4A6F4 80059EF4 01004238 */  xori       $v0, $v0, 0x1
    /* 4A6F8 80059EF8 40900200 */  sll        $s2, $v0, 1
  .L80059EFC:
    /* 4A6FC 80059EFC 1180023C */  lui        $v0, %hi(AI_Info)
    /* 4A700 80059F00 F0CC4224 */  addiu      $v0, $v0, %lo(AI_Info)
    /* 4A704 80059F04 3000438C */  lw         $v1, 0x30($v0)
    /* 4A708 80059F08 3400448C */  lw         $a0, 0x34($v0)
    /* 4A70C 80059F0C 3800428C */  lw         $v0, 0x38($v0)
    /* 4A710 80059F10 00000000 */  nop
    /* 4A714 80059F14 1800A2AF */  sw         $v0, 0x18($sp)
    /* 4A718 80059F18 80101200 */  sll        $v0, $s2, 2
    /* 4A71C 80059F1C 1000A3AF */  sw         $v1, 0x10($sp)
    /* 4A720 80059F20 1000A327 */  addiu      $v1, $sp, 0x10
    /* 4A724 80059F24 21186200 */  addu       $v1, $v1, $v0
    /* 4A728 80059F28 1400A4AF */  sw         $a0, 0x14($sp)
    /* 4A72C 80059F2C 0000628C */  lw         $v0, 0x0($v1)
    /* 4A730 80059F30 2007048E */  lw         $a0, 0x720($s0)
    /* 4A734 80059F34 00000000 */  nop
    /* 4A738 80059F38 21104400 */  addu       $v0, $v0, $a0
    /* 4A73C 80059F3C 000062AC */  sw         $v0, 0x0($v1)
    /* 4A740 80059F40 1000A38F */  lw         $v1, 0x10($sp)
    /* 4A744 80059F44 1400A48F */  lw         $a0, 0x14($sp)
    /* 4A748 80059F48 00000000 */  nop
    /* 4A74C 80059F4C 2A106400 */  slt        $v0, $v1, $a0
    /* 4A750 80059F50 03004010 */  beqz       $v0, .L80059F60
    /* 4A754 80059F54 21880000 */   addu      $s1, $zero, $zero
    /* 4A758 80059F58 01001124 */  addiu      $s1, $zero, 0x1
    /* 4A75C 80059F5C 21188000 */  addu       $v1, $a0, $zero
  .L80059F60:
    /* 4A760 80059F60 1800A28F */  lw         $v0, 0x18($sp)
    /* 4A764 80059F64 00000000 */  nop
    /* 4A768 80059F68 2A106200 */  slt        $v0, $v1, $v0
    /* 4A76C 80059F6C 02004010 */  beqz       $v0, .L80059F78
    /* 4A770 80059F70 00000000 */   nop
    /* 4A774 80059F74 02001124 */  addiu      $s1, $zero, 0x2
  .L80059F78:
    /* 4A778 80059F78 1C07058E */  lw         $a1, 0x71C($s0)
    /* 4A77C 80059F7C 3401028E */  lw         $v0, 0x134($s0)
    /* 4A780 80059F80 08000486 */  lh         $a0, 0x8($s0)
    /* 4A784 80059F84 2128A200 */  addu       $a1, $a1, $v0
    /* 4A788 80059F88 33CD010C */  jal        AIWorld_LaneIndex__Fii
    /* 4A78C 80059F8C 0040A524 */   addiu     $a1, $a1, 0x4000
    /* 4A790 80059F90 C406038E */  lw         $v1, 0x6C4($s0)
    /* 4A794 80059F94 00000000 */  nop
    /* 4A798 80059F98 03004314 */  bne        $v0, $v1, .L80059FA8
    /* 4A79C 80059F9C 2A104300 */   slt       $v0, $v0, $v1
    /* 4A7A0 80059FA0 EC670108 */  j          .L80059FB0
    /* 4A7A4 80059FA4 01000624 */   addiu     $a2, $zero, 0x1
  .L80059FA8:
    /* 4A7A8 80059FA8 01004238 */  xori       $v0, $v0, 0x1
    /* 4A7AC 80059FAC 40300200 */  sll        $a2, $v0, 1
  .L80059FB0:
    /* 4A7B0 80059FB0 1180023C */  lui        $v0, %hi(AI_Info)
    /* 4A7B4 80059FB4 F0CC4224 */  addiu      $v0, $v0, %lo(AI_Info)
    /* 4A7B8 80059FB8 3000438C */  lw         $v1, 0x30($v0)
    /* 4A7BC 80059FBC 3400448C */  lw         $a0, 0x34($v0)
    /* 4A7C0 80059FC0 3800428C */  lw         $v0, 0x38($v0)
    /* 4A7C4 80059FC4 00000000 */  nop
    /* 4A7C8 80059FC8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 4A7CC 80059FCC 80100600 */  sll        $v0, $a2, 2
    /* 4A7D0 80059FD0 1000A3AF */  sw         $v1, 0x10($sp)
    /* 4A7D4 80059FD4 1000A327 */  addiu      $v1, $sp, 0x10
    /* 4A7D8 80059FD8 21186200 */  addu       $v1, $v1, $v0
    /* 4A7DC 80059FDC 1400A4AF */  sw         $a0, 0x14($sp)
    /* 4A7E0 80059FE0 0000628C */  lw         $v0, 0x0($v1)
    /* 4A7E4 80059FE4 2007048E */  lw         $a0, 0x720($s0)
    /* 4A7E8 80059FE8 00000000 */  nop
    /* 4A7EC 80059FEC 21104400 */  addu       $v0, $v0, $a0
    /* 4A7F0 80059FF0 000062AC */  sw         $v0, 0x0($v1)
    /* 4A7F4 80059FF4 1000A38F */  lw         $v1, 0x10($sp)
    /* 4A7F8 80059FF8 1400A58F */  lw         $a1, 0x14($sp)
    /* 4A7FC 80059FFC 00000000 */  nop
    /* 4A800 8005A000 2A106500 */  slt        $v0, $v1, $a1
    /* 4A804 8005A004 03004010 */  beqz       $v0, .L8005A014
    /* 4A808 8005A008 21200000 */   addu      $a0, $zero, $zero
    /* 4A80C 8005A00C 01000424 */  addiu      $a0, $zero, 0x1
    /* 4A810 8005A010 2118A000 */  addu       $v1, $a1, $zero
  .L8005A014:
    /* 4A814 8005A014 1800A28F */  lw         $v0, 0x18($sp)
    /* 4A818 8005A018 00000000 */  nop
    /* 4A81C 8005A01C 2A106200 */  slt        $v0, $v1, $v0
    /* 4A820 8005A020 02004010 */  beqz       $v0, .L8005A02C
    /* 4A824 8005A024 00000000 */   nop
    /* 4A828 8005A028 02000424 */  addiu      $a0, $zero, 0x2
  .L8005A02C:
    /* 4A82C 8005A02C 06003216 */  bne        $s1, $s2, .L8005A048
    /* 4A830 8005A030 21100000 */   addu      $v0, $zero, $zero
    /* 4A834 8005A034 04008614 */  bne        $a0, $a2, .L8005A048
    /* 4A838 8005A038 00000000 */   nop
    /* 4A83C 8005A03C 1C07038E */  lw         $v1, 0x71C($s0)
    /* 4A840 8005A040 01000224 */  addiu      $v0, $zero, 0x1
    /* 4A844 8005A044 580503AE */  sw         $v1, 0x558($s0)
  .L8005A048:
    /* 4A848 8005A048 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 4A84C 8005A04C 2800B28F */  lw         $s2, 0x28($sp)
    /* 4A850 8005A050 2400B18F */  lw         $s1, 0x24($sp)
    /* 4A854 8005A054 2000B08F */  lw         $s0, 0x20($sp)
    /* 4A858 8005A058 0800E003 */  jr         $ra
    /* 4A85C 8005A05C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AI_CheckPreferredLateralPosition__FP8Car_tObj
