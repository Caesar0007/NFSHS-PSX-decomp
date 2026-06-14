.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPerson_SetPersonalityPointers__Fv, 0x64

glabel AIPerson_SetPersonalityPointers__Fv
    /* 592FC 80068AFC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 59300 80068B00 1400B1AF */  sw         $s1, 0x14($sp)
    /* 59304 80068B04 21880000 */  addu       $s1, $zero, $zero
    /* 59308 80068B08 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 5930C 80068B0C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 59310 80068B10 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
    /* 59314 80068B14 1800BFAF */  sw         $ra, 0x18($sp)
  .L80068B18:
    /* 59318 80068B18 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 5931C 80068B1C F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 59320 80068B20 00000000 */  nop
    /* 59324 80068B24 2A102202 */  slt        $v0, $s1, $v0
    /* 59328 80068B28 08004010 */  beqz       $v0, .L80068B4C
    /* 5932C 80068B2C 00000000 */   nop
    /* 59330 80068B30 0000048E */  lw         $a0, 0x0($s0)
    /* 59334 80068B34 04001026 */  addiu      $s0, $s0, 0x4
    /* 59338 80068B38 EC04858C */  lw         $a1, 0x4EC($a0)
    /* 5933C 80068B3C 8DA2010C */  jal        AIPerson_SetPersonality__FP8Car_tObji
    /* 59340 80068B40 01003126 */   addiu     $s1, $s1, 0x1
    /* 59344 80068B44 C6A20108 */  j          .L80068B18
    /* 59348 80068B48 00000000 */   nop
  .L80068B4C:
    /* 5934C 80068B4C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 59350 80068B50 1400B18F */  lw         $s1, 0x14($sp)
    /* 59354 80068B54 1000B08F */  lw         $s0, 0x10($sp)
    /* 59358 80068B58 0800E003 */  jr         $ra
    /* 5935C 80068B5C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIPerson_SetPersonalityPointers__Fv
