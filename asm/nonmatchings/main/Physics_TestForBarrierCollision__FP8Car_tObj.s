.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_TestForBarrierCollision__FP8Car_tObj, 0x58

glabel Physics_TestForBarrierCollision__FP8Car_tObj
    /* 9AFB0 800AA7B0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9AFB4 800AA7B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9AFB8 800AA7B8 21808000 */  addu       $s0, $a0, $zero
    /* 9AFBC 800AA7BC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 9AFC0 800AA7C0 2EA5020C */  jal        Physics_DoBarrierCheck__FP8Car_tObj
    /* 9AFC4 800AA7C4 1400B1AF */   sw        $s1, 0x14($sp)
    /* 9AFC8 800AA7C8 21884000 */  addu       $s1, $v0, $zero
    /* 9AFCC 800AA7CC 09002012 */  beqz       $s1, .L800AA7F4
    /* 9AFD0 800AA7D0 00000000 */   nop
    /* 9AFD4 800AA7D4 6002028E */  lw         $v0, 0x260($s0)
    /* 9AFD8 800AA7D8 00000000 */  nop
    /* 9AFDC 800AA7DC 04004230 */  andi       $v0, $v0, 0x4
    /* 9AFE0 800AA7E0 03004010 */  beqz       $v0, .L800AA7F0
    /* 9AFE4 800AA7E4 00000000 */   nop
    /* 9AFE8 800AA7E8 39A9020C */  jal        Physics_FixEngineRpm__FP8Car_tObj
    /* 9AFEC 800AA7EC 21200002 */   addu      $a0, $s0, $zero
  .L800AA7F0:
    /* 9AFF0 800AA7F0 EC0311AE */  sw         $s1, 0x3EC($s0)
  .L800AA7F4:
    /* 9AFF4 800AA7F4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 9AFF8 800AA7F8 1400B18F */  lw         $s1, 0x14($sp)
    /* 9AFFC 800AA7FC 1000B08F */  lw         $s0, 0x10($sp)
    /* 9B000 800AA800 0800E003 */  jr         $ra
    /* 9B004 800AA804 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Physics_TestForBarrierCollision__FP8Car_tObj
