.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CheckForCarsOnSide__FP8Car_tObj, 0x150

glabel AI_CheckForCarsOnSide__FP8Car_tObj
    /* 4A48C 80059C8C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 4A490 80059C90 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4A494 80059C94 21988000 */  addu       $s3, $a0, $zero
    /* 4A498 80059C98 3000BFAF */  sw         $ra, 0x30($sp)
    /* 4A49C 80059C9C 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 4A4A0 80059CA0 2800B6AF */  sw         $s6, 0x28($sp)
    /* 4A4A4 80059CA4 2400B5AF */  sw         $s5, 0x24($sp)
    /* 4A4A8 80059CA8 2000B4AF */  sw         $s4, 0x20($sp)
    /* 4A4AC 80059CAC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4A4B0 80059CB0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4A4B4 80059CB4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4A4B8 80059CB8 6002628E */  lw         $v0, 0x260($s3)
    /* 4A4BC 80059CBC 00000000 */  nop
    /* 4A4C0 80059CC0 10004230 */  andi       $v0, $v0, 0x10
    /* 4A4C4 80059CC4 3A004014 */  bnez       $v0, .L80059DB0
    /* 4A4C8 80059CC8 21880000 */   addu      $s1, $zero, $zero
    /* 4A4CC 80059CCC 3C01628E */  lw         $v0, 0x13C($s3)
    /* 4A4D0 80059CD0 00000000 */  nop
    /* 4A4D4 80059CD4 40200200 */  sll        $a0, $v0, 1
    /* 4A4D8 80059CD8 C21F0200 */  srl        $v1, $v0, 31
    /* 4A4DC 80059CDC 21104300 */  addu       $v0, $v0, $v1
    /* 4A4E0 80059CE0 43100200 */  sra        $v0, $v0, 1
    /* 4A4E4 80059CE4 1480033C */  lui        $v1, %hi(Cars_gNumCars)
    /* 4A4E8 80059CE8 F4C7638C */  lw         $v1, %lo(Cars_gNumCars)($v1)
    /* 4A4EC 80059CEC 00000000 */  nop
    /* 4A4F0 80059CF0 2F006018 */  blez       $v1, .L80059DB0
    /* 4A4F4 80059CF4 21B88200 */   addu      $s7, $a0, $v0
    /* 4A4F8 80059CF8 FAFF163C */  lui        $s6, (0xFFFA0000 >> 16)
    /* 4A4FC 80059CFC 1180143C */  lui        $s4, %hi(CarLogic_gObs)
    /* 4A500 80059D00 E4CC9526 */  addiu      $s5, $s4, %lo(CarLogic_gObs)
    /* 4A504 80059D04 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 4A508 80059D08 DCF95224 */  addiu      $s2, $v0, %lo(Cars_gList)
  .L80059D0C:
    /* 4A50C 80059D0C 0000508E */  lw         $s0, 0x0($s2)
    /* 4A510 80059D10 00000000 */  nop
    /* 4A514 80059D14 20007012 */  beq        $s3, $s0, .L80059D98
    /* 4A518 80059D18 00000000 */   nop
    /* 4A51C 80059D1C 91000292 */  lbu        $v0, 0x91($s0)
    /* 4A520 80059D20 00000000 */  nop
    /* 4A524 80059D24 1C004010 */  beqz       $v0, .L80059D98
    /* 4A528 80059D28 21200002 */   addu      $a0, $s0, $zero
    /* 4A52C 80059D2C 89CC010C */  jal        AIWorld_SplineDistance__FP8Car_tObjT0
    /* 4A530 80059D30 21286002 */   addu      $a1, $s3, $zero
    /* 4A534 80059D34 02004104 */  bgez       $v0, .L80059D40
    /* 4A538 80059D38 21184000 */   addu      $v1, $v0, $zero
    /* 4A53C 80059D3C 23180300 */  negu       $v1, $v1
  .L80059D40:
    /* 4A540 80059D40 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* 4A544 80059D44 2A104300 */  slt        $v0, $v0, $v1
    /* 4A548 80059D48 13004014 */  bnez       $v0, .L80059D98
    /* 4A54C 80059D4C 2A107700 */   slt       $v0, $v1, $s7
    /* 4A550 80059D50 11004010 */  beqz       $v0, .L80059D98
    /* 4A554 80059D54 00000000 */   nop
    /* 4A558 80059D58 C406638E */  lw         $v1, 0x6C4($s3)
    /* 4A55C 80059D5C C406048E */  lw         $a0, 0x6C4($s0)
    /* 4A560 80059D60 FFFF6224 */  addiu      $v0, $v1, -0x1
    /* 4A564 80059D64 06008214 */  bne        $a0, $v0, .L80059D80
    /* 4A568 80059D68 01006224 */   addiu     $v0, $v1, 0x1
    /* 4A56C 80059D6C E4CC828E */  lw         $v0, %lo(CarLogic_gObs)($s4)
    /* 4A570 80059D70 00000000 */  nop
    /* 4A574 80059D74 21105600 */  addu       $v0, $v0, $s6
    /* 4A578 80059D78 66670108 */  j          .L80059D98
    /* 4A57C 80059D7C E4CC82AE */   sw        $v0, %lo(CarLogic_gObs)($s4)
  .L80059D80:
    /* 4A580 80059D80 05008214 */  bne        $a0, $v0, .L80059D98
    /* 4A584 80059D84 00000000 */   nop
    /* 4A588 80059D88 0800A28E */  lw         $v0, 0x8($s5)
    /* 4A58C 80059D8C 00000000 */  nop
    /* 4A590 80059D90 21105600 */  addu       $v0, $v0, $s6
    /* 4A594 80059D94 0800A2AE */  sw         $v0, 0x8($s5)
  .L80059D98:
    /* 4A598 80059D98 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 4A59C 80059D9C F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 4A5A0 80059DA0 01003126 */  addiu      $s1, $s1, 0x1
    /* 4A5A4 80059DA4 2A102202 */  slt        $v0, $s1, $v0
    /* 4A5A8 80059DA8 D8FF4014 */  bnez       $v0, .L80059D0C
    /* 4A5AC 80059DAC 04005226 */   addiu     $s2, $s2, 0x4
  .L80059DB0:
    /* 4A5B0 80059DB0 3000BF8F */  lw         $ra, 0x30($sp)
    /* 4A5B4 80059DB4 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 4A5B8 80059DB8 2800B68F */  lw         $s6, 0x28($sp)
    /* 4A5BC 80059DBC 2400B58F */  lw         $s5, 0x24($sp)
    /* 4A5C0 80059DC0 2000B48F */  lw         $s4, 0x20($sp)
    /* 4A5C4 80059DC4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4A5C8 80059DC8 1800B28F */  lw         $s2, 0x18($sp)
    /* 4A5CC 80059DCC 1400B18F */  lw         $s1, 0x14($sp)
    /* 4A5D0 80059DD0 1000B08F */  lw         $s0, 0x10($sp)
    /* 4A5D4 80059DD4 0800E003 */  jr         $ra
    /* 4A5D8 80059DD8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AI_CheckForCarsOnSide__FP8Car_tObj
