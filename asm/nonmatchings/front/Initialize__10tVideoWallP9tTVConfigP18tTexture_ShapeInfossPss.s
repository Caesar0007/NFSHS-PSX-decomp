.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss, 0xB0

glabel Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
    /* 26F90 80036790 21408000 */  addu       $t0, $a0, $zero
    /* 26F94 80036794 21480000 */  addu       $t1, $zero, $zero
    /* 26F98 80036798 000005AD */  sw         $a1, 0x0($t0)
    /* 26F9C 8003679C 040007A5 */  sh         $a3, 0x4($t0)
    /* 26FA0 800367A0 080006AD */  sw         $a2, 0x8($t0)
    /* 26FA4 800367A4 1A0000A5 */  sh         $zero, 0x1A($t0)
    /* 26FA8 800367A8 180000A5 */  sh         $zero, 0x18($t0)
    /* 26FAC 800367AC 140000A5 */  sh         $zero, 0x14($t0)
    /* 26FB0 800367B0 1000A38F */  lw         $v1, 0x10($sp)
    /* 26FB4 800367B4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 26FB8 800367B8 1C0002A5 */  sh         $v0, 0x1C($t0)
    /* 26FBC 800367BC 1480023C */  lui        $v0, %hi(ticks)
    /* 26FC0 800367C0 060003A5 */  sh         $v1, 0x6($t0)
    /* 26FC4 800367C4 1400A48F */  lw         $a0, 0x14($sp)
    /* 26FC8 800367C8 1800A68F */  lw         $a2, 0x18($sp)
    /* 26FCC 800367CC ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 26FD0 800367D0 06000585 */  lh         $a1, 0x6($t0)
    /* 26FD4 800367D4 01000224 */  addiu      $v0, $zero, 0x1
    /* 26FD8 800367D8 1E0002A5 */  sh         $v0, 0x1E($t0)
    /* 26FDC 800367DC 200000A5 */  sh         $zero, 0x20($t0)
    /* 26FE0 800367E0 220002A5 */  sh         $v0, 0x22($t0)
    /* 26FE4 800367E4 280000AD */  sw         $zero, 0x28($t0)
    /* 26FE8 800367E8 0C0004AD */  sw         $a0, 0xC($t0)
    /* 26FEC 800367EC 100003AD */  sw         $v1, 0x10($t0)
    /* 26FF0 800367F0 1100A018 */  blez       $a1, .L80036838
    /* 26FF4 800367F4 160006A5 */   sh        $a2, 0x16($t0)
    /* 26FF8 800367F8 001C0900 */  sll        $v1, $t1, 16
  .L800367FC:
    /* 26FFC 800367FC 01002425 */  addiu      $a0, $t1, 0x1
    /* 27000 80036800 21488000 */  addu       $t1, $a0, $zero
    /* 27004 80036804 031C0300 */  sra        $v1, $v1, 16
    /* 27008 80036808 40100300 */  sll        $v0, $v1, 1
    /* 2700C 8003680C 21104300 */  addu       $v0, $v0, $v1
    /* 27010 80036810 00110200 */  sll        $v0, $v0, 4
    /* 27014 80036814 0000038D */  lw         $v1, 0x0($t0)
    /* 27018 80036818 00240400 */  sll        $a0, $a0, 16
    /* 2701C 8003681C 21104300 */  addu       $v0, $v0, $v1
    /* 27020 80036820 000040AC */  sw         $zero, 0x0($v0)
    /* 27024 80036824 06000285 */  lh         $v0, 0x6($t0)
    /* 27028 80036828 03240400 */  sra        $a0, $a0, 16
    /* 2702C 8003682C 2A208200 */  slt        $a0, $a0, $v0
    /* 27030 80036830 F2FF8014 */  bnez       $a0, .L800367FC
    /* 27034 80036834 001C0900 */   sll       $v1, $t1, 16
  .L80036838:
    /* 27038 80036838 0800E003 */  jr         $ra
    /* 2703C 8003683C 340000AD */   sw        $zero, 0x34($t0)
endlabel Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
