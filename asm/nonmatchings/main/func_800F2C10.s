.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F2C10, 0x148

glabel func_800F2C10
    /* E3410 800F2C10 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E3414 800F2C14 1400B1AF */  sw         $s1, 0x14($sp)
    /* E3418 800F2C18 21888000 */  addu       $s1, $a0, $zero
    /* E341C 800F2C1C 1800B2AF */  sw         $s2, 0x18($sp)
    /* E3420 800F2C20 2190A000 */  addu       $s2, $a1, $zero
    /* E3424 800F2C24 1380053C */  lui        $a1, %hi(D_80134AFC)
    /* E3428 800F2C28 FC4AA524 */  addiu      $a1, $a1, %lo(D_80134AFC)
    /* E342C 800F2C2C 80101100 */  sll        $v0, $s1, 2
    /* E3430 800F2C30 21204500 */  addu       $a0, $v0, $a1
    /* E3434 800F2C34 2400BFAF */  sw         $ra, 0x24($sp)
    /* E3438 800F2C38 2000B4AF */  sw         $s4, 0x20($sp)
    /* E343C 800F2C3C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E3440 800F2C40 1000B0AF */  sw         $s0, 0x10($sp)
    /* E3444 800F2C44 0000948C */  lw         $s4, 0x0($a0)
    /* E3448 800F2C48 00000000 */  nop
    /* E344C 800F2C4C 3A005412 */  beq        $s2, $s4, .L800F2D38
    /* E3450 800F2C50 21108002 */   addu      $v0, $s4, $zero
    /* E3454 800F2C54 FCFFA294 */  lhu        $v0, -0x4($a1)
    /* E3458 800F2C58 00000000 */  nop
    /* E345C 800F2C5C 35004010 */  beqz       $v0, .L800F2D34
    /* E3460 800F2C60 FCFFA624 */   addiu     $a2, $a1, -0x4
    /* E3464 800F2C64 1380023C */  lui        $v0, %hi(D_80135B88)
    /* E3468 800F2C68 885B428C */  lw         $v0, %lo(D_80135B88)($v0)
    /* E346C 800F2C6C 00000000 */  nop
    /* E3470 800F2C70 00004394 */  lhu        $v1, 0x0($v0)
    /* E3474 800F2C74 000040A4 */  sh         $zero, 0x0($v0)
    /* E3478 800F2C78 09004012 */  beqz       $s2, .L800F2CA0
    /* E347C 800F2C7C FFFF7330 */   andi      $s3, $v1, 0xFFFF
    /* E3480 800F2C80 01000324 */  addiu      $v1, $zero, 0x1
    /* E3484 800F2C84 04182302 */  sllv       $v1, $v1, $s1
    /* E3488 800F2C88 000092AC */  sw         $s2, 0x0($a0)
    /* E348C 800F2C8C 3000C294 */  lhu        $v0, 0x30($a2)
    /* E3490 800F2C90 25986302 */  or         $s3, $s3, $v1
    /* E3494 800F2C94 25104300 */  or         $v0, $v0, $v1
    /* E3498 800F2C98 30CB0308 */  j          .L800F2CC0
    /* E349C 800F2C9C 3000C2A4 */   sh        $v0, 0x30($a2)
  .L800F2CA0:
    /* E34A0 800F2CA0 01000224 */  addiu      $v0, $zero, 0x1
    /* E34A4 800F2CA4 04102202 */  sllv       $v0, $v0, $s1
    /* E34A8 800F2CA8 27100200 */  nor        $v0, $zero, $v0
    /* E34AC 800F2CAC 000080AC */  sw         $zero, 0x0($a0)
    /* E34B0 800F2CB0 2C00A394 */  lhu        $v1, 0x2C($a1)
    /* E34B4 800F2CB4 24986202 */  and        $s3, $s3, $v0
    /* E34B8 800F2CB8 24186200 */  and        $v1, $v1, $v0
    /* E34BC 800F2CBC 2C00A3A4 */  sh         $v1, 0x2C($a1)
  .L800F2CC0:
    /* E34C0 800F2CC0 08002016 */  bnez       $s1, .L800F2CE4
    /* E34C4 800F2CC4 04000224 */   addiu     $v0, $zero, 0x4
    /* E34C8 800F2CC8 0100502E */  sltiu      $s0, $s2, 0x1
    /* E34CC 800F2CCC 9519040C */  jal        ChangeClearPAD
    /* E34D0 800F2CD0 21200002 */   addu      $a0, $s0, $zero
    /* E34D4 800F2CD4 03000424 */  addiu      $a0, $zero, 0x3
    /* E34D8 800F2CD8 9919040C */  jal        ChangeClearRCnt
    /* E34DC 800F2CDC 21280002 */   addu      $a1, $s0, $zero
    /* E34E0 800F2CE0 04000224 */  addiu      $v0, $zero, 0x4
  .L800F2CE4:
    /* E34E4 800F2CE4 05002216 */  bne        $s1, $v0, .L800F2CFC
    /* E34E8 800F2CE8 05000224 */   addiu     $v0, $zero, 0x5
    /* E34EC 800F2CEC 21200000 */  addu       $a0, $zero, $zero
    /* E34F0 800F2CF0 9919040C */  jal        ChangeClearRCnt
    /* E34F4 800F2CF4 0100452E */   sltiu     $a1, $s2, 0x1
    /* E34F8 800F2CF8 05000224 */  addiu      $v0, $zero, 0x5
  .L800F2CFC:
    /* E34FC 800F2CFC 05002216 */  bne        $s1, $v0, .L800F2D14
    /* E3500 800F2D00 06000224 */   addiu     $v0, $zero, 0x6
    /* E3504 800F2D04 01000424 */  addiu      $a0, $zero, 0x1
    /* E3508 800F2D08 9919040C */  jal        ChangeClearRCnt
    /* E350C 800F2D0C 0100452E */   sltiu     $a1, $s2, 0x1
    /* E3510 800F2D10 06000224 */  addiu      $v0, $zero, 0x6
  .L800F2D14:
    /* E3514 800F2D14 03002216 */  bne        $s1, $v0, .L800F2D24
    /* E3518 800F2D18 02000424 */   addiu     $a0, $zero, 0x2
    /* E351C 800F2D1C 9919040C */  jal        ChangeClearRCnt
    /* E3520 800F2D20 0100452E */   sltiu     $a1, $s2, 0x1
  .L800F2D24:
    /* E3524 800F2D24 1380023C */  lui        $v0, %hi(D_80135B88)
    /* E3528 800F2D28 885B428C */  lw         $v0, %lo(D_80135B88)($v0)
    /* E352C 800F2D2C 00000000 */  nop
    /* E3530 800F2D30 000053A4 */  sh         $s3, 0x0($v0)
  .L800F2D34:
    /* E3534 800F2D34 21108002 */  addu       $v0, $s4, $zero
  .L800F2D38:
    /* E3538 800F2D38 2400BF8F */  lw         $ra, 0x24($sp)
    /* E353C 800F2D3C 2000B48F */  lw         $s4, 0x20($sp)
    /* E3540 800F2D40 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E3544 800F2D44 1800B28F */  lw         $s2, 0x18($sp)
    /* E3548 800F2D48 1400B18F */  lw         $s1, 0x14($sp)
    /* E354C 800F2D4C 1000B08F */  lw         $s0, 0x10($sp)
    /* E3550 800F2D50 0800E003 */  jr         $ra
    /* E3554 800F2D54 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_800F2C10
