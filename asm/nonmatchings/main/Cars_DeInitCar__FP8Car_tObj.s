.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_DeInitCar__FP8Car_tObj, 0x48

glabel Cars_DeInitCar__FP8Car_tObj
    /* 7AC84 8008A484 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 7AC88 8008A488 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7AC8C 8008A48C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 7AC90 8008A490 3A9D010C */  jal        AIInit_DeInitAICar__FP8Car_tObj
    /* 7AC94 8008A494 21808000 */   addu      $s0, $a0, $zero
    /* 7AC98 8008A498 6404048E */  lw         $a0, 0x464($s0)
    /* 7AC9C 8008A49C 00000000 */  nop
    /* 7ACA0 8008A4A0 04008010 */  beqz       $a0, .L8008A4B4
    /* 7ACA4 8008A4A4 00000000 */   nop
    /* 7ACA8 8008A4A8 5095030C */  jal        purgememadr
    /* 7ACAC 8008A4AC 00000000 */   nop
    /* 7ACB0 8008A4B0 640400AE */  sw         $zero, 0x464($s0)
  .L8008A4B4:
    /* 7ACB4 8008A4B4 1EBB020C */  jal        R3DCar_DeInstantiate3DCar__FP8Car_tObj
    /* 7ACB8 8008A4B8 21200002 */   addu      $a0, $s0, $zero
    /* 7ACBC 8008A4BC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 7ACC0 8008A4C0 1000B08F */  lw         $s0, 0x10($sp)
    /* 7ACC4 8008A4C4 0800E003 */  jr         $ra
    /* 7ACC8 8008A4C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cars_DeInitCar__FP8Car_tObj
