.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_NextPlayer__Fi, 0x164

glabel Hud_NextPlayer__Fi
    /* C7D4C 800D754C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C7D50 800D7550 1800B2AF */  sw         $s2, 0x18($sp)
    /* C7D54 800D7554 21908000 */  addu       $s2, $a0, $zero
    /* C7D58 800D7558 80201200 */  sll        $a0, $s2, 2
    /* C7D5C 800D755C 1480033C */  lui        $v1, %hi(Input_gLookBehind)
    /* C7D60 800D7560 30D26324 */  addiu      $v1, $v1, %lo(Input_gLookBehind)
    /* C7D64 800D7564 21188300 */  addu       $v1, $a0, $v1
    /* C7D68 800D7568 1180023C */  lui        $v0, %hi(DashHUD_gInfo)
    /* C7D6C 800D756C 30274224 */  addiu      $v0, $v0, %lo(DashHUD_gInfo)
    /* C7D70 800D7570 21108200 */  addu       $v0, $a0, $v0
    /* C7D74 800D7574 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* C7D78 800D7578 1400B1AF */  sw         $s1, 0x14($sp)
    /* C7D7C 800D757C 1000B0AF */  sw         $s0, 0x10($sp)
    /* C7D80 800D7580 0000638C */  lw         $v1, 0x0($v1)
    /* C7D84 800D7584 2C00428C */  lw         $v0, 0x2C($v0)
    /* C7D88 800D7588 2A180300 */  slt        $v1, $zero, $v1
    /* C7D8C 800D758C 2A100200 */  slt        $v0, $zero, $v0
    /* C7D90 800D7590 26886200 */  xor        $s1, $v1, $v0
    /* C7D94 800D7594 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* C7D98 800D7598 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* C7D9C 800D759C 21208200 */  addu       $a0, $a0, $v0
    /* C7DA0 800D75A0 1480033C */  lui        $v1, %hi(Cars_gNumRaceCars)
    /* C7DA4 800D75A4 F8C7638C */  lw         $v1, %lo(Cars_gNumRaceCars)($v1)
    /* C7DA8 800D75A8 0000908C */  lw         $s0, 0x0($a0)
    /* C7DAC 800D75AC 02006328 */  slti       $v1, $v1, 0x2
    /* C7DB0 800D75B0 39006014 */  bnez       $v1, .L800D7698
    /* C7DB4 800D75B4 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* C7DB8 800D75B8 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* C7DBC 800D75BC 21200002 */   addu      $a0, $s0, $zero
    /* C7DC0 800D75C0 01000324 */  addiu      $v1, $zero, 0x1
    /* C7DC4 800D75C4 08004314 */  bne        $v0, $v1, .L800D75E8
    /* C7DC8 800D75C8 21300000 */   addu      $a2, $zero, $zero
    /* C7DCC 800D75CC 07002016 */  bnez       $s1, .L800D75EC
    /* C7DD0 800D75D0 1180023C */   lui       $v0, %hi(D_8011321C)
    /* C7DD4 800D75D4 A65D0308 */  j          .L800D7698
    /* C7DD8 800D75D8 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800D75DC:
    /* C7DDC 800D75DC EC04A28C */  lw         $v0, 0x4EC($a1)
    /* C7DE0 800D75E0 A65D0308 */  j          .L800D7698
    /* C7DE4 800D75E4 00000000 */   nop
  .L800D75E8:
    /* C7DE8 800D75E8 1180023C */  lui        $v0, %hi(D_8011321C)
  .L800D75EC:
    /* C7DEC 800D75EC 5C02048E */  lw         $a0, 0x25C($s0)
    /* C7DF0 800D75F0 1C32428C */  lw         $v0, %lo(D_8011321C)($v0)
    /* C7DF4 800D75F4 1480033C */  lui        $v1, %hi(Cars_gNumCars)
    /* C7DF8 800D75F8 F4C7638C */  lw         $v1, %lo(Cars_gNumCars)($v1)
    /* C7DFC 800D75FC 00000000 */  nop
    /* C7E00 800D7600 FFFF6524 */  addiu      $a1, $v1, -0x1
    /* C7E04 800D7604 2300A018 */  blez       $a1, .L800D7694
    /* C7E08 800D7608 26882202 */   xor       $s1, $s1, $v0
    /* C7E0C 800D760C 21386000 */  addu       $a3, $v1, $zero
    /* C7E10 800D7610 1180023C */  lui        $v0, %hi(Cars_gSortedList)
    /* C7E14 800D7614 FCFA4924 */  addiu      $t1, $v0, %lo(Cars_gSortedList)
    /* C7E18 800D7618 2140A000 */  addu       $t0, $a1, $zero
  .L800D761C:
    /* C7E1C 800D761C 03002012 */  beqz       $s1, .L800D762C
    /* C7E20 800D7620 00000000 */   nop
    /* C7E24 800D7624 8C5D0308 */  j          .L800D7630
    /* C7E28 800D7628 FFFF8424 */   addiu     $a0, $a0, -0x1
  .L800D762C:
    /* C7E2C 800D762C 01008424 */  addiu      $a0, $a0, 0x1
  .L800D7630:
    /* C7E30 800D7630 03008104 */  bgez       $a0, .L800D7640
    /* C7E34 800D7634 2A108700 */   slt       $v0, $a0, $a3
    /* C7E38 800D7638 21208700 */  addu       $a0, $a0, $a3
    /* C7E3C 800D763C 2A108700 */  slt        $v0, $a0, $a3
  .L800D7640:
    /* C7E40 800D7640 03004014 */  bnez       $v0, .L800D7650
    /* C7E44 800D7644 80100400 */   sll       $v0, $a0, 2
    /* C7E48 800D7648 21200000 */  addu       $a0, $zero, $zero
    /* C7E4C 800D764C 80100400 */  sll        $v0, $a0, 2
  .L800D7650:
    /* C7E50 800D7650 21104900 */  addu       $v0, $v0, $t1
    /* C7E54 800D7654 0000458C */  lw         $a1, 0x0($v0)
    /* C7E58 800D7658 00000000 */  nop
    /* C7E5C 800D765C 6002A38C */  lw         $v1, 0x260($a1)
    /* C7E60 800D7660 00000000 */  nop
    /* C7E64 800D7664 04006230 */  andi       $v0, $v1, 0x4
    /* C7E68 800D7668 05004010 */  beqz       $v0, .L800D7680
    /* C7E6C 800D766C 08006230 */   andi      $v0, $v1, 0x8
    /* C7E70 800D7670 09004016 */  bnez       $s2, .L800D7698
    /* C7E74 800D7674 07000224 */   addiu     $v0, $zero, 0x7
    /* C7E78 800D7678 A65D0308 */  j          .L800D7698
    /* C7E7C 800D767C 08000224 */   addiu     $v0, $zero, 0x8
  .L800D7680:
    /* C7E80 800D7680 D6FF4014 */  bnez       $v0, .L800D75DC
    /* C7E84 800D7684 0100C624 */   addiu     $a2, $a2, 0x1
    /* C7E88 800D7688 2A10C800 */  slt        $v0, $a2, $t0
    /* C7E8C 800D768C E3FF4014 */  bnez       $v0, .L800D761C
    /* C7E90 800D7690 00000000 */   nop
  .L800D7694:
    /* C7E94 800D7694 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800D7698:
    /* C7E98 800D7698 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* C7E9C 800D769C 1800B28F */  lw         $s2, 0x18($sp)
    /* C7EA0 800D76A0 1400B18F */  lw         $s1, 0x14($sp)
    /* C7EA4 800D76A4 1000B08F */  lw         $s0, 0x10($sp)
    /* C7EA8 800D76A8 0800E003 */  jr         $ra
    /* C7EAC 800D76AC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hud_NextPlayer__Fi
