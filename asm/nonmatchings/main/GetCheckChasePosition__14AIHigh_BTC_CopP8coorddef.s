.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef, 0x9C

glabel GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
    /* 4D41C 8005CC1C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4D420 8005CC20 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4D424 8005CC24 21808000 */  addu       $s0, $a0, $zero
    /* 4D428 8005CC28 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4D42C 8005CC2C 2190A000 */  addu       $s2, $a1, $zero
    /* 4D430 8005CC30 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 4D434 8005CC34 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4D438 8005CC38 0000028E */  lw         $v0, 0x0($s0)
    /* 4D43C 8005CC3C 5800048E */  lw         $a0, 0x58($s0)
    /* 4D440 8005CC40 1C00058E */  lw         $a1, 0x1C($s0)
    /* 4D444 8005CC44 5402468C */  lw         $a2, 0x254($v0)
    /* 4D448 8005CC48 D76F010C */  jal        CheckChaserPosition__16AIHigh_BasicPerpii
    /* 4D44C 8005CC4C 21880000 */   addu      $s1, $zero, $zero
    /* 4D450 8005CC50 5C00038E */  lw         $v1, 0x5C($s0)
    /* 4D454 8005CC54 00000000 */  nop
    /* 4D458 8005CC58 03004310 */  beq        $v0, $v1, .L8005CC68
    /* 4D45C 8005CC5C 00000000 */   nop
    /* 4D460 8005CC60 01001124 */  addiu      $s1, $zero, 0x1
    /* 4D464 8005CC64 5C0002AE */  sw         $v0, 0x5C($s0)
  .L8005CC68:
    /* 4D468 8005CC68 21102002 */  addu       $v0, $s1, $zero
    /* 4D46C 8005CC6C 1180043C */  lui        $a0, %hi(AIH_BTCCop_chasePositions)
    /* 4D470 8005CC70 5C00058E */  lw         $a1, 0x5C($s0)
    /* 4D474 8005CC74 A4CD8424 */  addiu      $a0, $a0, %lo(AIH_BTCCop_chasePositions)
    /* 4D478 8005CC78 40180500 */  sll        $v1, $a1, 1
    /* 4D47C 8005CC7C 21186500 */  addu       $v1, $v1, $a1
    /* 4D480 8005CC80 80180300 */  sll        $v1, $v1, 2
    /* 4D484 8005CC84 21186400 */  addu       $v1, $v1, $a0
    /* 4D488 8005CC88 0000678C */  lw         $a3, 0x0($v1)
    /* 4D48C 8005CC8C 0400688C */  lw         $t0, 0x4($v1)
    /* 4D490 8005CC90 0800698C */  lw         $t1, 0x8($v1)
    /* 4D494 8005CC94 000047AE */  sw         $a3, 0x0($s2)
    /* 4D498 8005CC98 040048AE */  sw         $t0, 0x4($s2)
    /* 4D49C 8005CC9C 080049AE */  sw         $t1, 0x8($s2)
    /* 4D4A0 8005CCA0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4D4A4 8005CCA4 1800B28F */  lw         $s2, 0x18($sp)
    /* 4D4A8 8005CCA8 1400B18F */  lw         $s1, 0x14($sp)
    /* 4D4AC 8005CCAC 1000B08F */  lw         $s0, 0x10($sp)
    /* 4D4B0 8005CCB0 0800E003 */  jr         $ra
    /* 4D4B4 8005CCB4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
