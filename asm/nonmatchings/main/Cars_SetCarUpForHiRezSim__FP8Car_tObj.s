.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_SetCarUpForHiRezSim__FP8Car_tObj, 0x74

glabel Cars_SetCarUpForHiRezSim__FP8Car_tObj
    /* 772C4 80086AC4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 772C8 80086AC8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 772CC 80086ACC 21808000 */  addu       $s0, $a0, $zero
    /* 772D0 80086AD0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 772D4 80086AD4 90000292 */  lbu        $v0, 0x90($s0)
    /* 772D8 80086AD8 00000000 */  nop
    /* 772DC 80086ADC 0200422C */  sltiu      $v0, $v0, 0x2
    /* 772E0 80086AE0 11004010 */  beqz       $v0, .L80086B28
    /* 772E4 80086AE4 8C0700AE */   sw        $zero, 0x78C($s0)
    /* 772E8 80086AE8 A0000426 */  addiu      $a0, $s0, 0xA0
    /* 772EC 80086AEC 08000526 */  addiu      $a1, $s0, 0x8
    /* 772F0 80086AF0 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 772F4 80086AF4 01000624 */   addiu     $a2, $zero, 0x1
    /* 772F8 80086AF8 8000028E */  lw         $v0, 0x80($s0)
    /* 772FC 80086AFC 00000000 */  nop
    /* 77300 80086B00 09004010 */  beqz       $v0, .L80086B28
    /* 77304 80086B04 00000000 */   nop
    /* 77308 80086B08 00004290 */  lbu        $v0, 0x0($v0)
    /* 7730C 80086B0C 00000000 */  nop
    /* 77310 80086B10 0F004230 */  andi       $v0, $v0, 0xF
    /* 77314 80086B14 04004014 */  bnez       $v0, .L80086B28
    /* 77318 80086B18 21200002 */   addu      $a0, $s0, $zero
    /* 7731C 80086B1C 01000524 */  addiu      $a1, $zero, 0x1
    /* 77320 80086B20 9919020C */  jal        Cars_ResetCollidedCars__FP8Car_tObjii
    /* 77324 80086B24 21300000 */   addu      $a2, $zero, $zero
  .L80086B28:
    /* 77328 80086B28 1400BF8F */  lw         $ra, 0x14($sp)
    /* 7732C 80086B2C 1000B08F */  lw         $s0, 0x10($sp)
    /* 77330 80086B30 0800E003 */  jr         $ra
    /* 77334 80086B34 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cars_SetCarUpForHiRezSim__FP8Car_tObj
