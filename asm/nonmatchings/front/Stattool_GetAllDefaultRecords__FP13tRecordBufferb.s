.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stattool_GetAllDefaultRecords__FP13tRecordBufferb, 0xF8

glabel Stattool_GetAllDefaultRecords__FP13tRecordBufferb
    /* 3B498 8004AC98 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3B49C 8004AC9C 2800B6AF */  sw         $s6, 0x28($sp)
    /* 3B4A0 8004ACA0 21B08000 */  addu       $s6, $a0, $zero
    /* 3B4A4 8004ACA4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3B4A8 8004ACA8 2180A000 */  addu       $s0, $a1, $zero
    /* 3B4AC 8004ACAC 0180043C */  lui        $a0, %hi(D_800125AC)
    /* 3B4B0 8004ACB0 AC258424 */  addiu      $a0, $a0, %lo(D_800125AC)
    /* 3B4B4 8004ACB4 9C0E0524 */  addiu      $a1, $zero, 0xE9C
    /* 3B4B8 8004ACB8 10000624 */  addiu      $a2, $zero, 0x10
    /* 3B4BC 8004ACBC 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 3B4C0 8004ACC0 2400B5AF */  sw         $s5, 0x24($sp)
    /* 3B4C4 8004ACC4 2000B4AF */  sw         $s4, 0x20($sp)
    /* 3B4C8 8004ACC8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 3B4CC 8004ACCC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3B4D0 8004ACD0 CF94030C */  jal        reservememadr
    /* 3B4D4 8004ACD4 1400B1AF */   sw        $s1, 0x14($sp)
    /* 3B4D8 8004ACD8 21A84000 */  addu       $s5, $v0, $zero
    /* 3B4DC 8004ACDC 2120A002 */  addu       $a0, $s5, $zero
    /* 3B4E0 8004ACE0 642B010C */  jal        Stattool_ReadDefaultRecords__FP13tRecordBufferb
    /* 3B4E4 8004ACE4 21280002 */   addu      $a1, $s0, $zero
    /* 3B4E8 8004ACE8 21A00000 */  addu       $s4, $zero, $zero
    /* 3B4EC 8004ACEC 21988002 */  addu       $s3, $s4, $zero
  .L8004ACF0:
    /* 3B4F0 8004ACF0 21900000 */  addu       $s2, $zero, $zero
    /* 3B4F4 8004ACF4 21107202 */  addu       $v0, $s3, $s2
  .L8004ACF8:
    /* 3B4F8 8004ACF8 80800200 */  sll        $s0, $v0, 2
    /* 3B4FC 8004ACFC 21800202 */  addu       $s0, $s0, $v0
    /* 3B500 8004AD00 80801000 */  sll        $s0, $s0, 2
    /* 3B504 8004AD04 2188D002 */  addu       $s1, $s6, $s0
    /* 3B508 8004AD08 21202002 */  addu       $a0, $s1, $zero
    /* 3B50C 8004AD0C 2180B002 */  addu       $s0, $s5, $s0
    /* 3B510 8004AD10 CA96030C */  jal        strcpy
    /* 3B514 8004AD14 21280002 */   addu      $a1, $s0, $zero
    /* 3B518 8004AD18 F42A010C */  jal        Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc
    /* 3B51C 8004AD1C 21202002 */   addu      $a0, $s1, $zero
    /* 3B520 8004AD20 0800028E */  lw         $v0, 0x8($s0)
    /* 3B524 8004AD24 00000000 */  nop
    /* 3B528 8004AD28 080022AE */  sw         $v0, 0x8($s1)
    /* 3B52C 8004AD2C 0C00028E */  lw         $v0, 0xC($s0)
    /* 3B530 8004AD30 00000000 */  nop
    /* 3B534 8004AD34 0C0022AE */  sw         $v0, 0xC($s1)
    /* 3B538 8004AD38 1000028E */  lw         $v0, 0x10($s0)
    /* 3B53C 8004AD3C 01005226 */  addiu      $s2, $s2, 0x1
    /* 3B540 8004AD40 100022AE */  sw         $v0, 0x10($s1)
    /* 3B544 8004AD44 1100422A */  slti       $v0, $s2, 0x11
    /* 3B548 8004AD48 EBFF4014 */  bnez       $v0, .L8004ACF8
    /* 3B54C 8004AD4C 21107202 */   addu      $v0, $s3, $s2
    /* 3B550 8004AD50 01009426 */  addiu      $s4, $s4, 0x1
    /* 3B554 8004AD54 0B00822A */  slti       $v0, $s4, 0xB
    /* 3B558 8004AD58 E5FF4014 */  bnez       $v0, .L8004ACF0
    /* 3B55C 8004AD5C 11007326 */   addiu     $s3, $s3, 0x11
    /* 3B560 8004AD60 5095030C */  jal        purgememadr
    /* 3B564 8004AD64 2120A002 */   addu      $a0, $s5, $zero
    /* 3B568 8004AD68 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 3B56C 8004AD6C 2800B68F */  lw         $s6, 0x28($sp)
    /* 3B570 8004AD70 2400B58F */  lw         $s5, 0x24($sp)
    /* 3B574 8004AD74 2000B48F */  lw         $s4, 0x20($sp)
    /* 3B578 8004AD78 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 3B57C 8004AD7C 1800B28F */  lw         $s2, 0x18($sp)
    /* 3B580 8004AD80 1400B18F */  lw         $s1, 0x14($sp)
    /* 3B584 8004AD84 1000B08F */  lw         $s0, 0x10($sp)
    /* 3B588 8004AD88 0800E003 */  jr         $ra
    /* 3B58C 8004AD8C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Stattool_GetAllDefaultRecords__FP13tRecordBufferb
