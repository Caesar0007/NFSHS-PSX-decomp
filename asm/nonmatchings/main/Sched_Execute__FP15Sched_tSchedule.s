.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sched_Execute__FP15Sched_tSchedule, 0x74

glabel Sched_Execute__FP15Sched_tSchedule
    /* A6D00 800B6500 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A6D04 800B6504 1800B2AF */  sw         $s2, 0x18($sp)
    /* A6D08 800B6508 21908000 */  addu       $s2, $a0, $zero
    /* A6D0C 800B650C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* A6D10 800B6510 1400B1AF */  sw         $s1, 0x14($sp)
    /* A6D14 800B6514 1000B0AF */  sw         $s0, 0x10($sp)
    /* A6D18 800B6518 0400428E */  lw         $v0, 0x4($s2)
    /* A6D1C 800B651C 00000000 */  nop
    /* A6D20 800B6520 0E004018 */  blez       $v0, .L800B655C
    /* A6D24 800B6524 21880000 */   addu      $s1, $zero, $zero
    /* A6D28 800B6528 21804002 */  addu       $s0, $s2, $zero
  .L800B652C:
    /* A6D2C 800B652C 0C00028E */  lw         $v0, 0xC($s0)
    /* A6D30 800B6530 00000000 */  nop
    /* A6D34 800B6534 04004010 */  beqz       $v0, .L800B6548
    /* A6D38 800B6538 00000000 */   nop
    /* A6D3C 800B653C 1000048E */  lw         $a0, 0x10($s0)
    /* A6D40 800B6540 09F84000 */  jalr       $v0
    /* A6D44 800B6544 00000000 */   nop
  .L800B6548:
    /* A6D48 800B6548 0400428E */  lw         $v0, 0x4($s2)
    /* A6D4C 800B654C 01003126 */  addiu      $s1, $s1, 0x1
    /* A6D50 800B6550 2A102202 */  slt        $v0, $s1, $v0
    /* A6D54 800B6554 F5FF4014 */  bnez       $v0, .L800B652C
    /* A6D58 800B6558 10001026 */   addiu     $s0, $s0, 0x10
  .L800B655C:
    /* A6D5C 800B655C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* A6D60 800B6560 1800B28F */  lw         $s2, 0x18($sp)
    /* A6D64 800B6564 1400B18F */  lw         $s1, 0x14($sp)
    /* A6D68 800B6568 1000B08F */  lw         $s0, 0x10($sp)
    /* A6D6C 800B656C 0800E003 */  jr         $ra
    /* A6D70 800B6570 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Sched_Execute__FP15Sched_tSchedule
