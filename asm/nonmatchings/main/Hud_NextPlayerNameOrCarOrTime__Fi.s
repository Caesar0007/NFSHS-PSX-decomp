.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_NextPlayerNameOrCarOrTime__Fi, 0x188

glabel Hud_NextPlayerNameOrCarOrTime__Fi
    /* C7EB0 800D76B0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C7EB4 800D76B4 1800B2AF */  sw         $s2, 0x18($sp)
    /* C7EB8 800D76B8 21908000 */  addu       $s2, $a0, $zero
    /* C7EBC 800D76BC 80201200 */  sll        $a0, $s2, 2
    /* C7EC0 800D76C0 1480033C */  lui        $v1, %hi(Input_gLookBehind)
    /* C7EC4 800D76C4 30D26324 */  addiu      $v1, $v1, %lo(Input_gLookBehind)
    /* C7EC8 800D76C8 21188300 */  addu       $v1, $a0, $v1
    /* C7ECC 800D76CC 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* C7ED0 800D76D0 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* C7ED4 800D76D4 21108200 */  addu       $v0, $a0, $v0
    /* C7ED8 800D76D8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* C7EDC 800D76DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* C7EE0 800D76E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* C7EE4 800D76E4 0000638C */  lw         $v1, 0x0($v1)
    /* C7EE8 800D76E8 2C00428C */  lw         $v0, 0x2C($v0)
    /* C7EEC 800D76EC 2A180300 */  slt        $v1, $zero, $v1
    /* C7EF0 800D76F0 2A100200 */  slt        $v0, $zero, $v0
    /* C7EF4 800D76F4 26886200 */  xor        $s1, $v1, $v0
    /* C7EF8 800D76F8 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* C7EFC 800D76FC 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* C7F00 800D7700 21208200 */  addu       $a0, $a0, $v0
    /* C7F04 800D7704 1480033C */  lui        $v1, %hi(Cars_gNumRaceCars)
    /* C7F08 800D7708 F8C7638C */  lw         $v1, %lo(Cars_gNumRaceCars)($v1)
    /* C7F0C 800D770C 0000908C */  lw         $s0, 0x0($a0)
    /* C7F10 800D7710 02006328 */  slti       $v1, $v1, 0x2
    /* C7F14 800D7714 41006014 */  bnez       $v1, .L800D781C
    /* C7F18 800D7718 1480023C */   lui       $v0, %hi(D_8013D91C)
    /* C7F1C 800D771C 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* C7F20 800D7720 21200002 */   addu      $a0, $s0, $zero
    /* C7F24 800D7724 01000324 */  addiu      $v1, $zero, 0x1
    /* C7F28 800D7728 07004314 */  bne        $v0, $v1, .L800D7748
    /* C7F2C 800D772C 21300000 */   addu      $a2, $zero, $zero
    /* C7F30 800D7730 06002016 */  bnez       $s1, .L800D774C
    /* C7F34 800D7734 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* C7F38 800D7738 075E0308 */  j          .L800D781C
    /* C7F3C 800D773C 1480023C */   lui       $v0, %hi(D_8013D91C)
  .L800D7740:
    /* C7F40 800D7740 085E0308 */  j          .L800D7820
    /* C7F44 800D7744 4902A224 */   addiu     $v0, $a1, 0x249
  .L800D7748:
    /* C7F48 800D7748 1180023C */  lui        $v0, %hi(GameSetup_gData)
  .L800D774C:
    /* C7F4C 800D774C EC314824 */  addiu      $t0, $v0, %lo(GameSetup_gData)
    /* C7F50 800D7750 5C02048E */  lw         $a0, 0x25C($s0)
    /* C7F54 800D7754 3000028D */  lw         $v0, 0x30($t0)
    /* C7F58 800D7758 1480033C */  lui        $v1, %hi(Cars_gNumCars)
    /* C7F5C 800D775C F4C7638C */  lw         $v1, %lo(Cars_gNumCars)($v1)
    /* C7F60 800D7760 00000000 */  nop
    /* C7F64 800D7764 FFFF6524 */  addiu      $a1, $v1, -0x1
    /* C7F68 800D7768 2B00A018 */  blez       $a1, .L800D7818
    /* C7F6C 800D776C 26882202 */   xor       $s1, $s1, $v0
    /* C7F70 800D7770 21386000 */  addu       $a3, $v1, $zero
    /* C7F74 800D7774 1180023C */  lui        $v0, %hi(Cars_gSortedList)
    /* C7F78 800D7778 FCFA4924 */  addiu      $t1, $v0, %lo(Cars_gSortedList)
    /* C7F7C 800D777C 40181200 */  sll        $v1, $s2, 1
    /* C7F80 800D7780 21187200 */  addu       $v1, $v1, $s2
    /* C7F84 800D7784 00110300 */  sll        $v0, $v1, 4
    /* C7F88 800D7788 23104300 */  subu       $v0, $v0, $v1
    /* C7F8C 800D778C 80100200 */  sll        $v0, $v0, 2
    /* C7F90 800D7790 21404800 */  addu       $t0, $v0, $t0
    /* C7F94 800D7794 2118A000 */  addu       $v1, $a1, $zero
  .L800D7798:
    /* C7F98 800D7798 03002012 */  beqz       $s1, .L800D77A8
    /* C7F9C 800D779C 00000000 */   nop
    /* C7FA0 800D77A0 EB5D0308 */  j          .L800D77AC
    /* C7FA4 800D77A4 FFFF8424 */   addiu     $a0, $a0, -0x1
  .L800D77A8:
    /* C7FA8 800D77A8 01008424 */  addiu      $a0, $a0, 0x1
  .L800D77AC:
    /* C7FAC 800D77AC 03008104 */  bgez       $a0, .L800D77BC
    /* C7FB0 800D77B0 2A108700 */   slt       $v0, $a0, $a3
    /* C7FB4 800D77B4 21208700 */  addu       $a0, $a0, $a3
    /* C7FB8 800D77B8 2A108700 */  slt        $v0, $a0, $a3
  .L800D77BC:
    /* C7FBC 800D77BC 03004014 */  bnez       $v0, .L800D77CC
    /* C7FC0 800D77C0 80100400 */   sll       $v0, $a0, 2
    /* C7FC4 800D77C4 21200000 */  addu       $a0, $zero, $zero
    /* C7FC8 800D77C8 80100400 */  sll        $v0, $a0, 2
  .L800D77CC:
    /* C7FCC 800D77CC 21104900 */  addu       $v0, $v0, $t1
    /* C7FD0 800D77D0 0000458C */  lw         $a1, 0x0($v0)
    /* C7FD4 800D77D4 00000000 */  nop
    /* C7FD8 800D77D8 6002A28C */  lw         $v0, 0x260($a1)
    /* C7FDC 800D77DC 00000000 */  nop
    /* C7FE0 800D77E0 0C004230 */  andi       $v0, $v0, 0xC
    /* C7FE4 800D77E4 08004010 */  beqz       $v0, .L800D7808
    /* C7FE8 800D77E8 02000224 */   addiu     $v0, $zero, 0x2
    /* C7FEC 800D77EC 5404038D */  lw         $v1, 0x454($t0)
    /* C7FF0 800D77F0 00000000 */  nop
    /* C7FF4 800D77F4 D2FF6210 */  beq        $v1, $v0, .L800D7740
    /* C7FF8 800D77F8 00000000 */   nop
    /* C7FFC 800D77FC 8802A28C */  lw         $v0, 0x288($a1)
    /* C8000 800D7800 085E0308 */  j          .L800D7820
    /* C8004 800D7804 5C004224 */   addiu     $v0, $v0, 0x5C
  .L800D7808:
    /* C8008 800D7808 0100C624 */  addiu      $a2, $a2, 0x1
    /* C800C 800D780C 2A10C300 */  slt        $v0, $a2, $v1
    /* C8010 800D7810 E1FF4014 */  bnez       $v0, .L800D7798
    /* C8014 800D7814 00000000 */   nop
  .L800D7818:
    /* C8018 800D7818 1480023C */  lui        $v0, %hi(D_8013D91C)
  .L800D781C:
    /* C801C 800D781C 1CD94224 */  addiu      $v0, $v0, %lo(D_8013D91C)
  .L800D7820:
    /* C8020 800D7820 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* C8024 800D7824 1800B28F */  lw         $s2, 0x18($sp)
    /* C8028 800D7828 1400B18F */  lw         $s1, 0x14($sp)
    /* C802C 800D782C 1000B08F */  lw         $s0, 0x10($sp)
    /* C8030 800D7830 0800E003 */  jr         $ra
    /* C8034 800D7834 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hud_NextPlayerNameOrCarOrTime__Fi
