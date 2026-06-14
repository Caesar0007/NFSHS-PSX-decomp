.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_IsSliceCloseToAnyCopCar__Fi, 0xA0

glabel AILife_IsSliceCloseToAnyCopCar__Fi
    /* 590AC 800688AC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 590B0 800688B0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 590B4 800688B4 21908000 */  addu       $s2, $a0, $zero
    /* 590B8 800688B8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 590BC 800688BC 21880000 */  addu       $s1, $zero, $zero
    /* 590C0 800688C0 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* 590C4 800688C4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 590C8 800688C8 B4FA5024 */  addiu      $s0, $v0, %lo(Cars_gCopCarList)
    /* 590CC 800688CC 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L800688D0:
    /* 590D0 800688D0 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 590D4 800688D4 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 590D8 800688D8 00000000 */  nop
    /* 590DC 800688DC 2A102202 */  slt        $v0, $s1, $v0
    /* 590E0 800688E0 14004010 */  beqz       $v0, .L80068934
    /* 590E4 800688E4 21100000 */   addu      $v0, $zero, $zero
    /* 590E8 800688E8 0000028E */  lw         $v0, 0x0($s0)
    /* 590EC 800688EC 00000000 */  nop
    /* 590F0 800688F0 08004484 */  lh         $a0, 0x8($v0)
    /* 590F4 800688F4 6FCC010C */  jal        AIWorld_ApxSplineDistance__Fii
    /* 590F8 800688F8 21284002 */   addu      $a1, $s2, $zero
    /* 590FC 800688FC 3100033C */  lui        $v1, (0x31FFFF >> 16)
    /* 59100 80068900 FFFF6334 */  ori        $v1, $v1, (0x31FFFF & 0xFFFF)
    /* 59104 80068904 02004104 */  bgez       $v0, .L80068910
    /* 59108 80068908 00000000 */   nop
    /* 5910C 8006890C 23100200 */  negu       $v0, $v0
  .L80068910:
    /* 59110 80068910 2A186200 */  slt        $v1, $v1, $v0
    /* 59114 80068914 04006014 */  bnez       $v1, .L80068928
    /* 59118 80068918 00000000 */   nop
    /* 5911C 8006891C 0000028E */  lw         $v0, 0x0($s0)
    /* 59120 80068920 4DA20108 */  j          .L80068934
    /* 59124 80068924 00000000 */   nop
  .L80068928:
    /* 59128 80068928 04001026 */  addiu      $s0, $s0, 0x4
    /* 5912C 8006892C 34A20108 */  j          .L800688D0
    /* 59130 80068930 01003126 */   addiu     $s1, $s1, 0x1
  .L80068934:
    /* 59134 80068934 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 59138 80068938 1800B28F */  lw         $s2, 0x18($sp)
    /* 5913C 8006893C 1400B18F */  lw         $s1, 0x14($sp)
    /* 59140 80068940 1000B08F */  lw         $s0, 0x10($sp)
    /* 59144 80068944 0800E003 */  jr         $ra
    /* 59148 80068948 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AILife_IsSliceCloseToAnyCopCar__Fi
