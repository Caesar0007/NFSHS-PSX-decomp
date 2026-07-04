.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_queuemem, 0x12C

glabel STREAM_queuemem
    /* EDC28 800FD428 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EDC2C 800FD42C 2400B3AF */  sw         $s3, 0x24($sp)
    /* EDC30 800FD430 2198A000 */  addu       $s3, $a1, $zero
    /* EDC34 800FD434 1800B0AF */  sw         $s0, 0x18($sp)
    /* EDC38 800FD438 2180C000 */  addu       $s0, $a2, $zero
    /* EDC3C 800FD43C 2000B2AF */  sw         $s2, 0x20($sp)
    /* EDC40 800FD440 2190E000 */  addu       $s2, $a3, $zero
    /* EDC44 800FD444 1000A527 */  addiu      $a1, $sp, 0x10
    /* EDC48 800FD448 1400A627 */  addiu      $a2, $sp, 0x14
    /* EDC4C 800FD44C 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* EDC50 800FD450 2800B4AF */  sw         $s4, 0x28($sp)
    /* EDC54 800FD454 BEF0030C */  jal        validatehandle
    /* EDC58 800FD458 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* EDC5C 800FD45C 35004014 */  bnez       $v0, .L800FD534
    /* EDC60 800FD460 21100000 */   addu      $v0, $zero, $zero
    /* EDC64 800FD464 1000A48F */  lw         $a0, 0x10($sp)
    /* EDC68 800FD468 00F1030C */  jal        getfreerequest
    /* EDC6C 800FD46C 00000000 */   nop
    /* EDC70 800FD470 21884000 */  addu       $s1, $v0, $zero
    /* EDC74 800FD474 2F002012 */  beqz       $s1, .L800FD534
    /* EDC78 800FD478 21100000 */   addu      $v0, $zero, $zero
    /* EDC7C 800FD47C 10000016 */  bnez       $s0, .L800FD4C0
    /* EDC80 800FD480 21282002 */   addu      $a1, $s1, $zero
    /* EDC84 800FD484 0000628E */  lw         $v0, 0x0($s3)
    /* EDC88 800FD488 00000000 */  nop
    /* EDC8C 800FD48C 08005210 */  beq        $v0, $s2, .L800FD4B0
    /* EDC90 800FD490 21206002 */   addu      $a0, $s3, $zero
  .L800FD494:
    /* EDC94 800FD494 0400828C */  lw         $v0, 0x4($a0)
    /* EDC98 800FD498 00000000 */  nop
    /* EDC9C 800FD49C 21208200 */  addu       $a0, $a0, $v0
    /* EDCA0 800FD4A0 0000838C */  lw         $v1, 0x0($a0)
    /* EDCA4 800FD4A4 00000000 */  nop
    /* EDCA8 800FD4A8 FAFF7214 */  bne        $v1, $s2, .L800FD494
    /* EDCAC 800FD4AC 21800202 */   addu      $s0, $s0, $v0
  .L800FD4B0:
    /* EDCB0 800FD4B0 0400828C */  lw         $v0, 0x4($a0)
    /* EDCB4 800FD4B4 00000000 */  nop
    /* EDCB8 800FD4B8 21800202 */  addu       $s0, $s0, $v0
    /* EDCBC 800FD4BC 21282002 */  addu       $a1, $s1, $zero
  .L800FD4C0:
    /* EDCC0 800FD4C0 1000A48F */  lw         $a0, 0x10($sp)
    /* EDCC4 800FD4C4 01001424 */  addiu      $s4, $zero, 0x1
    /* EDCC8 800FD4C8 100034AE */  sw         $s4, 0x10($s1)
    /* EDCCC 800FD4CC 540033AE */  sw         $s3, 0x54($s1)
    /* EDCD0 800FD4D0 580030AE */  sw         $s0, 0x58($s1)
    /* EDCD4 800FD4D4 1EF1030C */  jal        queuerequest
    /* EDCD8 800FD4D8 5C0032AE */   sw        $s2, 0x5C($s1)
    /* EDCDC 800FD4DC 00600440 */  mfc0       $a0, $12 /* handwritten instruction */
    /* EDCE0 800FD4E0 00000000 */  nop
    /* EDCE4 800FD4E4 FEFB0124 */  addiu      $at, $zero, -0x402
    /* EDCE8 800FD4E8 24408100 */  and        $t0, $a0, $at
    /* EDCEC 800FD4EC 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* EDCF0 800FD4F0 00000000 */  nop
    /* EDCF4 800FD4F4 00000000 */  nop
    /* EDCF8 800FD4F8 00000000 */  nop
    /* EDCFC 800FD4FC 1000A28F */  lw         $v0, 0x10($sp)
    /* EDD00 800FD500 00000000 */  nop
    /* EDD04 800FD504 2800438C */  lw         $v1, 0x28($v0)
    /* EDD08 800FD508 00000000 */  nop
    /* EDD0C 800FD50C 02006014 */  bnez       $v1, .L800FD518
    /* EDD10 800FD510 00000000 */   nop
    /* EDD14 800FD514 280054AC */  sw         $s4, 0x28($v0)
  .L800FD518:
    /* EDD18 800FD518 00608440 */  mtc0       $a0, $12 /* handwritten instruction */
    /* EDD1C 800FD51C 04006014 */  bnez       $v1, .L800FD530
    /* EDD20 800FD520 00000000 */   nop
    /* EDD24 800FD524 1000A48F */  lw         $a0, 0x10($sp)
    /* EDD28 800FD528 6DF2030C */  jal        startnextrequest
    /* EDD2C 800FD52C 21280000 */   addu      $a1, $zero, $zero
  .L800FD530:
    /* EDD30 800FD530 0000228E */  lw         $v0, 0x0($s1)
  .L800FD534:
    /* EDD34 800FD534 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* EDD38 800FD538 2800B48F */  lw         $s4, 0x28($sp)
    /* EDD3C 800FD53C 2400B38F */  lw         $s3, 0x24($sp)
    /* EDD40 800FD540 2000B28F */  lw         $s2, 0x20($sp)
    /* EDD44 800FD544 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EDD48 800FD548 1800B08F */  lw         $s0, 0x18($sp)
    /* EDD4C 800FD54C 0800E003 */  jr         $ra
    /* EDD50 800FD550 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel STREAM_queuemem
