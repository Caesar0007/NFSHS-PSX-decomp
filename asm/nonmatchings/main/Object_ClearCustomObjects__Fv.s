.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_ClearCustomObjects__Fv, 0xD0

glabel Object_ClearCustomObjects__Fv
    /* 95E6C 800A566C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 95E70 800A5670 7C0D828F */  lw         $v0, %gp_rel(Object_customObjInst)($gp)
    /* 95E74 800A5674 800D838F */  lw         $v1, %gp_rel(Object_customSimObjs)($gp)
    /* 95E78 800A5678 840D848F */  lw         $a0, %gp_rel(Object_customSFXInst)($gp)
    /* 95E7C 800A567C 1480063C */  lui        $a2, %hi(Cars_gNumTrafficCars)
    /* 95E80 800A5680 08C8C68C */  lw         $a2, %lo(Cars_gNumTrafficCars)($a2)
    /* 95E84 800A5684 21280000 */  addu       $a1, $zero, $zero
    /* 95E88 800A5688 1000BFAF */  sw         $ra, 0x10($sp)
    /* 95E8C 800A568C 000040AC */  sw         $zero, 0x0($v0)
    /* 95E90 800A5690 000060AC */  sw         $zero, 0x0($v1)
    /* 95E94 800A5694 0D00C018 */  blez       $a2, .L800A56CC
    /* 95E98 800A5698 000080AC */   sw        $zero, 0x0($a0)
    /* 95E9C 800A569C FFFB0724 */  addiu      $a3, $zero, -0x401
    /* 95EA0 800A56A0 1180023C */  lui        $v0, %hi(Cars_gTrafficCarList)
    /* 95EA4 800A56A4 90FA4424 */  addiu      $a0, $v0, %lo(Cars_gTrafficCarList)
  .L800A56A8:
    /* 95EA8 800A56A8 0000828C */  lw         $v0, 0x0($a0)
    /* 95EAC 800A56AC 00000000 */  nop
    /* 95EB0 800A56B0 6002438C */  lw         $v1, 0x260($v0)
    /* 95EB4 800A56B4 0100A524 */  addiu      $a1, $a1, 0x1
    /* 95EB8 800A56B8 24186700 */  and        $v1, $v1, $a3
    /* 95EBC 800A56BC 600243AC */  sw         $v1, 0x260($v0)
    /* 95EC0 800A56C0 2A10A600 */  slt        $v0, $a1, $a2
    /* 95EC4 800A56C4 F8FF4014 */  bnez       $v0, .L800A56A8
    /* 95EC8 800A56C8 04008424 */   addiu     $a0, $a0, 0x4
  .L800A56CC:
    /* 95ECC 800A56CC 1480063C */  lui        $a2, %hi(Cars_gNumCopCars)
    /* 95ED0 800A56D0 0CC8C68C */  lw         $a2, %lo(Cars_gNumCopCars)($a2)
    /* 95ED4 800A56D4 00000000 */  nop
    /* 95ED8 800A56D8 0D00C018 */  blez       $a2, .L800A5710
    /* 95EDC 800A56DC 21280000 */   addu      $a1, $zero, $zero
    /* 95EE0 800A56E0 FFFB0724 */  addiu      $a3, $zero, -0x401
    /* 95EE4 800A56E4 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* 95EE8 800A56E8 B4FA4424 */  addiu      $a0, $v0, %lo(Cars_gCopCarList)
  .L800A56EC:
    /* 95EEC 800A56EC 0000828C */  lw         $v0, 0x0($a0)
    /* 95EF0 800A56F0 00000000 */  nop
    /* 95EF4 800A56F4 6002438C */  lw         $v1, 0x260($v0)
    /* 95EF8 800A56F8 0100A524 */  addiu      $a1, $a1, 0x1
    /* 95EFC 800A56FC 24186700 */  and        $v1, $v1, $a3
    /* 95F00 800A5700 600243AC */  sw         $v1, 0x260($v0)
    /* 95F04 800A5704 2A10A600 */  slt        $v0, $a1, $a2
    /* 95F08 800A5708 F8FF4014 */  bnez       $v0, .L800A56EC
    /* 95F0C 800A570C 04008424 */   addiu     $a0, $a0, 0x4
  .L800A5710:
    /* 95F10 800A5710 1480043C */  lui        $a0, %hi(Track_gSaveSurface)
    /* 95F14 800A5714 CCD4848C */  lw         $a0, %lo(Track_gSaveSurface)($a0)
    /* 95F18 800A5718 00000000 */  nop
    /* 95F1C 800A571C 03008010 */  beqz       $a0, .L800A572C
    /* 95F20 800A5720 00000000 */   nop
    /* 95F24 800A5724 FFEB020C */  jal        RestoreAll__11SaveSurface
    /* 95F28 800A5728 00000000 */   nop
  .L800A572C:
    /* 95F2C 800A572C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 95F30 800A5730 00000000 */  nop
    /* 95F34 800A5734 0800E003 */  jr         $ra
    /* 95F38 800A5738 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Object_ClearCustomObjects__Fv
