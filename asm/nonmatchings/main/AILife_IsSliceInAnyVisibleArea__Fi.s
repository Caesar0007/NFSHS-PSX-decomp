.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_IsSliceInAnyVisibleArea__Fi, 0xA0

glabel AILife_IsSliceInAnyVisibleArea__Fi
    /* 5900C 8006880C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 59010 80068810 1800B2AF */  sw         $s2, 0x18($sp)
    /* 59014 80068814 21908000 */  addu       $s2, $a0, $zero
    /* 59018 80068818 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5901C 8006881C 21880000 */  addu       $s1, $zero, $zero
    /* 59020 80068820 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 59024 80068824 1000B0AF */  sw         $s0, 0x10($sp)
    /* 59028 80068828 48FA5024 */  addiu      $s0, $v0, %lo(Cars_gHumanRaceCarList)
    /* 5902C 8006882C 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L80068830:
    /* 59030 80068830 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 59034 80068834 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 59038 80068838 00000000 */  nop
    /* 5903C 8006883C 2A102202 */  slt        $v0, $s1, $v0
    /* 59040 80068840 14004010 */  beqz       $v0, .L80068894
    /* 59044 80068844 21100000 */   addu      $v0, $zero, $zero
    /* 59048 80068848 0000028E */  lw         $v0, 0x0($s0)
    /* 5904C 8006884C 00000000 */  nop
    /* 59050 80068850 08004484 */  lh         $a0, 0x8($v0)
    /* 59054 80068854 6FCC010C */  jal        AIWorld_ApxSplineDistance__Fii
    /* 59058 80068858 21284002 */   addu      $a1, $s2, $zero
    /* 5905C 8006885C AB00033C */  lui        $v1, (0xABFFFF >> 16)
    /* 59060 80068860 FFFF6334 */  ori        $v1, $v1, (0xABFFFF & 0xFFFF)
    /* 59064 80068864 02004104 */  bgez       $v0, .L80068870
    /* 59068 80068868 00000000 */   nop
    /* 5906C 8006886C 23100200 */  negu       $v0, $v0
  .L80068870:
    /* 59070 80068870 2A186200 */  slt        $v1, $v1, $v0
    /* 59074 80068874 04006014 */  bnez       $v1, .L80068888
    /* 59078 80068878 00000000 */   nop
    /* 5907C 8006887C 0000028E */  lw         $v0, 0x0($s0)
    /* 59080 80068880 25A20108 */  j          .L80068894
    /* 59084 80068884 00000000 */   nop
  .L80068888:
    /* 59088 80068888 04001026 */  addiu      $s0, $s0, 0x4
    /* 5908C 8006888C 0CA20108 */  j          .L80068830
    /* 59090 80068890 01003126 */   addiu     $s1, $s1, 0x1
  .L80068894:
    /* 59094 80068894 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 59098 80068898 1800B28F */  lw         $s2, 0x18($sp)
    /* 5909C 8006889C 1400B18F */  lw         $s1, 0x14($sp)
    /* 590A0 800688A0 1000B08F */  lw         $s0, 0x10($sp)
    /* 590A4 800688A4 0800E003 */  jr         $ra
    /* 590A8 800688A8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AILife_IsSliceInAnyVisibleArea__Fi
