.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp, 0xB8

glabel NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp
    /* 504E8 8005FCE8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 504EC 8005FCEC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 504F0 8005FCF0 21988000 */  addu       $s3, $a0, $zero
    /* 504F4 8005FCF4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 504F8 8005FCF8 21880000 */  addu       $s1, $zero, $zero
    /* 504FC 8005FCFC 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 50500 8005FD00 1800B2AF */  sw         $s2, 0x18($sp)
    /* 50504 8005FD04 38CD5224 */  addiu      $s2, $v0, %lo(highLevelAIObjs)
    /* 50508 8005FD08 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 5050C 8005FD0C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50510 8005FD10 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
    /* 50514 8005FD14 2000BFAF */  sw         $ra, 0x20($sp)
  .L8005FD18:
    /* 50518 8005FD18 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 5051C 8005FD1C F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 50520 8005FD20 00000000 */  nop
    /* 50524 8005FD24 2A102202 */  slt        $v0, $s1, $v0
    /* 50528 8005FD28 16004010 */  beqz       $v0, .L8005FD84
    /* 5052C 8005FD2C 00000000 */   nop
    /* 50530 8005FD30 0000038E */  lw         $v1, 0x0($s0)
    /* 50534 8005FD34 00000000 */  nop
    /* 50538 8005FD38 6002628C */  lw         $v0, 0x260($v1)
    /* 5053C 8005FD3C 00000000 */  nop
    /* 50540 8005FD40 20024230 */  andi       $v0, $v0, 0x220
    /* 50544 8005FD44 0C004010 */  beqz       $v0, .L8005FD78
    /* 50548 8005FD48 00000000 */   nop
    /* 5054C 8005FD4C 91006290 */  lbu        $v0, 0x91($v1)
    /* 50550 8005FD50 00000000 */  nop
    /* 50554 8005FD54 08004010 */  beqz       $v0, .L8005FD78
    /* 50558 8005FD58 00000000 */   nop
    /* 5055C 8005FD5C 5402628C */  lw         $v0, 0x254($v1)
    /* 50560 8005FD60 00000000 */  nop
    /* 50564 8005FD64 80100200 */  sll        $v0, $v0, 2
    /* 50568 8005FD68 21105200 */  addu       $v0, $v0, $s2
    /* 5056C 8005FD6C 0000448C */  lw         $a0, 0x0($v0)
    /* 50570 8005FD70 A073010C */  jal        FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 50574 8005FD74 21286002 */   addu      $a1, $s3, $zero
  .L8005FD78:
    /* 50578 8005FD78 04001026 */  addiu      $s0, $s0, 0x4
    /* 5057C 8005FD7C 467F0108 */  j          .L8005FD18
    /* 50580 8005FD80 01003126 */   addiu     $s1, $s1, 0x1
  .L8005FD84:
    /* 50584 8005FD84 2000BF8F */  lw         $ra, 0x20($sp)
    /* 50588 8005FD88 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5058C 8005FD8C 1800B28F */  lw         $s2, 0x18($sp)
    /* 50590 8005FD90 1400B18F */  lw         $s1, 0x14($sp)
    /* 50594 8005FD94 1000B08F */  lw         $s0, 0x10($sp)
    /* 50598 8005FD98 0800E003 */  jr         $ra
    /* 5059C 8005FD9C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp
