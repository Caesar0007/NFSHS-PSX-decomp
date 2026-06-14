.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Init__24AITrigger_TriggerManagerPc, 0xDC

glabel Init__24AITrigger_TriggerManagerPc
    /* 6306C 8007286C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 63070 80072870 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 63074 80072874 21988000 */  addu       $s3, $a0, $zero
    /* 63078 80072878 00F60424 */  addiu      $a0, $zero, -0xA00
    /* 6307C 8007287C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 63080 80072880 63001024 */  addiu      $s0, $zero, 0x63
    /* 63084 80072884 8C016326 */  addiu      $v1, $s3, 0x18C
    /* 63088 80072888 2000BFAF */  sw         $ra, 0x20($sp)
    /* 6308C 8007288C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 63090 80072890 1400B1AF */  sw         $s1, 0x14($sp)
    /* 63094 80072894 000060AE */  sw         $zero, 0x0($s3)
    /* 63098 80072898 040060AE */  sw         $zero, 0x4($s3)
  .L8007289C:
    /* 6309C 8007289C 980164AC */  sw         $a0, 0x198($v1)
    /* 630A0 800728A0 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* 630A4 800728A4 FDFF0106 */  bgez       $s0, .L8007289C
    /* 630A8 800728A8 FCFF6324 */   addiu     $v1, $v1, -0x4
    /* 630AC 800728AC 08001024 */  addiu      $s0, $zero, 0x8
    /* 630B0 800728B0 20006326 */  addiu      $v1, $s3, 0x20
  .L800728B4:
    /* 630B4 800728B4 280360AC */  sw         $zero, 0x328($v1)
    /* 630B8 800728B8 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* 630BC 800728BC FDFF0106 */  bgez       $s0, .L800728B4
    /* 630C0 800728C0 FCFF6324 */   addiu     $v1, $v1, -0x4
    /* 630C4 800728C4 1900A010 */  beqz       $a1, .L8007292C
    /* 630C8 800728C8 2190A000 */   addu      $s2, $a1, $zero
    /* 630CC 800728CC 04005126 */  addiu      $s1, $s2, 0x4
    /* 630D0 800728D0 0000428E */  lw         $v0, 0x0($s2)
    /* 630D4 800728D4 00000000 */  nop
    /* 630D8 800728D8 0B004018 */  blez       $v0, .L80072908
    /* 630DC 800728DC 21800000 */   addu      $s0, $zero, $zero
    /* 630E0 800728E0 21206002 */  addu       $a0, $s3, $zero
  .L800728E4:
    /* 630E4 800728E4 21282002 */  addu       $a1, $s1, $zero
    /* 630E8 800728E8 52CA010C */  jal        InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb
    /* 630EC 800728EC 01000624 */   addiu     $a2, $zero, 0x1
    /* 630F0 800728F0 21882202 */  addu       $s1, $s1, $v0
    /* 630F4 800728F4 0000428E */  lw         $v0, 0x0($s2)
    /* 630F8 800728F8 01001026 */  addiu      $s0, $s0, 0x1
    /* 630FC 800728FC 2A100202 */  slt        $v0, $s0, $v0
    /* 63100 80072900 F8FF4014 */  bnez       $v0, .L800728E4
    /* 63104 80072904 21206002 */   addu      $a0, $s3, $zero
  .L80072908:
    /* 63108 80072908 8CCB010C */  jal        Sort__24AITrigger_TriggerManager
    /* 6310C 8007290C 21206002 */   addu      $a0, $s3, $zero
    /* 63110 80072910 0000658E */  lw         $a1, 0x0($s3)
    /* 63114 80072914 00000000 */  nop
    /* 63118 80072918 0400A010 */  beqz       $a1, .L8007292C
    /* 6311C 8007291C 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 63120 80072920 0191030C */  jal        rdiv
    /* 63124 80072924 002C0500 */   sll       $a1, $a1, 16
    /* 63128 80072928 040062AE */  sw         $v0, 0x4($s3)
  .L8007292C:
    /* 6312C 8007292C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 63130 80072930 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 63134 80072934 1800B28F */  lw         $s2, 0x18($sp)
    /* 63138 80072938 1400B18F */  lw         $s1, 0x14($sp)
    /* 6313C 8007293C 1000B08F */  lw         $s0, 0x10($sp)
    /* 63140 80072940 0800E003 */  jr         $ra
    /* 63144 80072944 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Init__24AITrigger_TriggerManagerPc
