.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching iSNDdmqueue, 0xF4

glabel iSNDdmqueue
    /* FB4A0 8010ACA0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FB4A4 8010ACA4 2800AA8F */  lw         $t2, 0x28($sp)
    /* FB4A8 8010ACA8 3F00C230 */  andi       $v0, $a2, 0x3F
    /* FB4AC 8010ACAC 1400BFAF */  sw         $ra, 0x14($sp)
    /* FB4B0 8010ACB0 02004010 */  beqz       $v0, .L8010ACBC
    /* FB4B4 8010ACB4 1000B0AF */   sw        $s0, 0x10($sp)
    /* FB4B8 8010ACB8 4000C624 */  addiu      $a2, $a2, 0x40
  .L8010ACBC:
    /* FB4BC 8010ACBC 1480023C */  lui        $v0, %hi(sndpd)
    /* FB4C0 8010ACC0 18794324 */  addiu      $v1, $v0, %lo(sndpd)
    /* FB4C4 8010ACC4 0800628C */  lw         $v0, 0x8($v1)
    /* FB4C8 8010ACC8 00000000 */  nop
    /* FB4CC 8010ACCC 01004224 */  addiu      $v0, $v0, 0x1
    /* FB4D0 8010ACD0 080062AC */  sw         $v0, 0x8($v1)
    /* FB4D4 8010ACD4 0800628C */  lw         $v0, 0x8($v1)
    /* FB4D8 8010ACD8 00600940 */  mfc0       $t1, $12 /* handwritten instruction */
    /* FB4DC 8010ACDC 00000000 */  nop
    /* FB4E0 8010ACE0 FEFB0124 */  addiu      $at, $zero, -0x402
    /* FB4E4 8010ACE4 24402101 */  and        $t0, $t1, $at
    /* FB4E8 8010ACE8 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* FB4EC 8010ACEC 00000000 */  nop
    /* FB4F0 8010ACF0 00000000 */  nop
    /* FB4F4 8010ACF4 00000000 */  nop
    /* FB4F8 8010ACF8 04004014 */  bnez       $v0, .L8010AD0C
    /* FB4FC 8010ACFC 21400000 */   addu      $t0, $zero, $zero
    /* FB500 8010AD00 01000224 */  addiu      $v0, $zero, 0x1
    /* FB504 8010AD04 080062AC */  sw         $v0, 0x8($v1)
    /* FB508 8010AD08 21400000 */  addu       $t0, $zero, $zero
  .L8010AD0C:
    /* FB50C 8010AD0C 21806000 */  addu       $s0, $v1, $zero
    /* FB510 8010AD10 10000326 */  addiu      $v1, $s0, 0x10
  .L8010AD14:
    /* FB514 8010AD14 0000628C */  lw         $v0, 0x0($v1)
    /* FB518 8010AD18 00000000 */  nop
    /* FB51C 8010AD1C 14004014 */  bnez       $v0, .L8010AD70
    /* FB520 8010AD20 01000825 */   addiu     $t0, $t0, 0x1
    /* FB524 8010AD24 0C000292 */  lbu        $v0, 0xC($s0)
    /* FB528 8010AD28 00000000 */  nop
    /* FB52C 8010AD2C 01004224 */  addiu      $v0, $v0, 0x1
    /* FB530 8010AD30 0C0002A2 */  sb         $v0, 0xC($s0)
    /* FB534 8010AD34 0800028E */  lw         $v0, 0x8($s0)
    /* FB538 8010AD38 040064AC */  sw         $a0, 0x4($v1)
    /* FB53C 8010AD3C 000062AC */  sw         $v0, 0x0($v1)
    /* FB540 8010AD40 C2100500 */  srl        $v0, $a1, 3
    /* FB544 8010AD44 080062A4 */  sh         $v0, 0x8($v1)
    /* FB548 8010AD48 83110600 */  sra        $v0, $a2, 6
    /* FB54C 8010AD4C 0A0062A0 */  sb         $v0, 0xA($v1)
    /* FB550 8010AD50 0B0067A0 */  sb         $a3, 0xB($v1)
    /* FB554 8010AD54 0C006AA0 */  sb         $t2, 0xC($v1)
    /* FB558 8010AD58 00608940 */  mtc0       $t1, $12 /* handwritten instruction */
    /* FB55C 8010AD5C 082B040C */  jal        iSNDdmservice
    /* FB560 8010AD60 00000000 */   nop
    /* FB564 8010AD64 0800028E */  lw         $v0, 0x8($s0)
    /* FB568 8010AD68 612B0408 */  j          .L8010AD84
    /* FB56C 8010AD6C 00000000 */   nop
  .L8010AD70:
    /* FB570 8010AD70 0A000229 */  slti       $v0, $t0, 0xA
    /* FB574 8010AD74 E7FF4014 */  bnez       $v0, .L8010AD14
    /* FB578 8010AD78 14006324 */   addiu     $v1, $v1, 0x14
    /* FB57C 8010AD7C 00608940 */  mtc0       $t1, $12 /* handwritten instruction */
    /* FB580 8010AD80 21100000 */  addu       $v0, $zero, $zero
  .L8010AD84:
    /* FB584 8010AD84 1400BF8F */  lw         $ra, 0x14($sp)
    /* FB588 8010AD88 1000B08F */  lw         $s0, 0x10($sp)
    /* FB58C 8010AD8C 0800E003 */  jr         $ra
    /* FB590 8010AD90 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDdmqueue
